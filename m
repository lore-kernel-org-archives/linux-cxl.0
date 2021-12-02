Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706F9C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355512AbhLBEnv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:61242 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355530AbhLBEng (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438380"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438380"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:08 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717453"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:07 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 08/14] cxl/pci: Implement wait for media active
Date:   Wed,  1 Dec 2021 20:37:44 -0800
Message-Id: <20211202043750.3501494-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL Type 3 Memory Device Software Guide (Revision 1.0) describes the
need to check media active before using HDM. CXL 2.0 8.1.3.8.2 states:

  Memory_Active: When set, indicates that the CXL Range 1 memory is
  fully initialized and available for software use. Must be set within
  Range 1. Memory_Active_Timeout of deassertion of reset to CXL device
  if CXL.mem HwInit Mode=1

Unfortunately, Memory_Active can take quite a long time depending on
media size (up to 256s per 2.0 spec). Since the cxl_pci driver doesn't
care about this, a callback is exported as part of driver state for use
by drivers that do care. The implementation waits for 60s as that is
considered more than enough and falls within typical Linux timeout
lengths.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxlmem.h |  1 +
 drivers/cxl/pci.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8d0a14c53518..47651432e2ae 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -163,6 +163,7 @@ struct cxl_dev_state {
 	struct cxl_endpoint_dvsec_info *info;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
 };
 
 enum cxl_opcode {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4e00abde5dbb..e7523a7614a4 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -466,6 +466,63 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
 	return valid ? 0 : -ETIMEDOUT;
 }
 
+/*
+ * Implements Figure 43 of the CXL Type 3 Memory Device Software Guide. Waits a
+ * full 60s no matter what the device reports.
+ */
+static int wait_for_media_ready(struct cxl_dev_state *cxlds)
+{
+	const unsigned long timeout = jiffies + (60 * HZ);
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->device_dvsec;
+	u64 md_status;
+	bool active;
+	int rc;
+
+	rc = wait_for_valid(cxlds);
+	if (rc)
+		return rc;
+
+	do {
+		u64 size;
+		u32 temp;
+		int rc;
+
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_PCIE_DEVICE_RANGE_SIZE_HIGH_OFFSET(0),
+					   &temp);
+		if (rc)
+			return -ENXIO;
+		size = (u64)temp << 32;
+
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_PCIE_DEVICE_RANGE_SIZE_LOW_OFFSET(0),
+					   &temp);
+		if (rc)
+			return -ENXIO;
+		size |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK;
+
+		active = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_MEM_ACTIVE, temp);
+		if (active)
+			break;
+		cpu_relax();
+		mdelay(100);
+	} while (!time_after(jiffies, timeout));
+
+	if (!active)
+		return -ETIMEDOUT;
+
+	rc = check_device_status(cxlds);
+	if (rc)
+		return rc;
+
+	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+	if (!CXLMDEV_READY(md_status))
+		return -EIO;
+
+	return 0;
+}
+
 static struct cxl_endpoint_dvsec_info *dvsec_ranges(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
@@ -579,6 +636,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENXIO;
 	}
 
+	cxlds->wait_media_ready = wait_for_media_ready;
+
 	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
 		return rc;
-- 
2.34.1

