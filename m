Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E432C7EE22
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 20:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjEHUru (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 16:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjEHUrt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 16:47:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C05595
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578868; x=1715114868;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l4vAICEVugnj0cTgHH6YR4VLxq7drchAv/8YeNLDUcU=;
  b=QZcvfOxNsceYPMPYyj3HI/2hEIKotSVUXMzmPE7rLl5w89ewqnJA5FYZ
   aDy2FiTe3gGuFHAKifYpjTXmSSwaVnGFKZKDcSvHe+J99QX2jTXc/afPj
   1haEIRV66VubzomYB2+U9qovlcehHC4NWc4cYlX2T8dzfDEzqwtkQWv9o
   F9zLhPUk/ruOptgNok+i5X41HEyKSzOclLNtpO7sShZRePsHVrzMxVyoL
   HZkh3sEyf2t2xFT2TEpmLywAnw8bmkn9GwUhQcGDhESATHM+LAh2UxG1j
   QDPSVSh88aDLtrbYmrhRAUtnrg+T8xTPWpvIoPE7fx7t/8XjvMtF5IZs5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436072417"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="436072417"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="944996580"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="944996580"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.172.228])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:47:48 -0700
Subject: [PATCH v5 09/14] cxl: Wait Memory_Info_Valid before access memory
 related info
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 May 2023 13:47:47 -0700
Message-ID: <168357886796.2756219.4806167633587850772.stgit@djiang5-mobl3>
In-Reply-To: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL rev3.0 8.1.3.8.2 Memory_Info_valid field

The Memory_Info_Valid bit indicates that the CXL Range Size High and Size
Low registers are valid. The bit must be set within 1 second of reset
deassertion to the device. Check valid bit before we check the
Memory_Active bit when waiting for cxl_await_media_ready() to ensure that
the memory info is valid for consumption.

Fixes: 2e4ba0ec9783 ("cxl/pci: Move cxl_await_media_ready() to the core")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Check both ranges. (Jonathan)
---
 drivers/cxl/core/pci.c |   83 +++++++++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxlpci.h   |    2 +
 2 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6c99a964eb54..536672d469a1 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -102,21 +102,55 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
 
-/*
- * Wait up to @media_ready_timeout for the device to report memory
- * active.
- */
-int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec;
+	bool valid = false;
+	int rc, i;
+	u32 temp;
+
+	if (id > CXL_DVSEC_RANGE_MAX)
+		return -EINVAL;
+
+	/* Check MEM INFO VALID bit first, give up after 1s */
+	i = 1;
+	do {
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
+					   &temp);
+		if (rc)
+			return rc;
+
+		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
+		if (valid)
+			break;
+		msleep(1000);
+	} while (i--);
+
+	if (!valid) {
+		dev_err(&pdev->dev,
+			"Timeout awaiting memory range %d valid after 1s.\n",
+			id);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
 	bool active = false;
-	u64 md_status;
 	int rc, i;
+	u32 temp;
 
-	for (i = media_ready_timeout; i; i--) {
-		u32 temp;
+	if (id > CXL_DVSEC_RANGE_MAX)
+		return -EINVAL;
 
+	/* Check MEM ACTIVE bit, up to 60s timeout by default */
+	for (i = media_ready_timeout; i; i--) {
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
 		if (rc)
@@ -135,6 +169,39 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 		return -ETIMEDOUT;
 	}
 
+	return 0;
+}
+
+/*
+ * Wait up to @media_ready_timeout for the device to report memory
+ * active.
+ */
+int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec;
+	int rc, i, hdm_count;
+	u64 md_status;
+	u16 cap;
+
+	rc = pci_read_config_word(pdev,
+				  d + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	for (i = 0; i < hdm_count; i++) {
+		rc = cxl_dvsec_mem_range_valid(cxlds, i);
+		if (rc)
+			return rc;
+	}
+
+	for (i = 0; i < hdm_count; i++) {
+		rc = cxl_dvsec_mem_range_active(cxlds, i);
+		if (rc)
+			return rc;
+	}
+
 	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
 	if (!CXLMDEV_READY(md_status))
 		return -EIO;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 84c9f73c7d92..1772cd226108 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -31,6 +31,8 @@
 #define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
 #define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
 
+#define CXL_DVSEC_RANGE_MAX		2
+
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
 #define CXL_DVSEC_FUNCTION_MAP					2
 


