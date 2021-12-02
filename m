Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D95C433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355506AbhLBEnq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:61245 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355501AbhLBEnc (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438377"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438377"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:06 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717433"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:06 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 06/14] cxl/pci: Cache device DVSEC offset
Date:   Wed,  1 Dec 2021 20:37:42 -0800
Message-Id: <20211202043750.3501494-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The PCIe device DVSEC, defined in the CXL 2.0 spec, 8.1.3 is required to
be implemented by CXL 2.0 endpoint devices. Since the information
contained within this DVSEC will be critically important, it makes sense
to find the value early, and error out if it cannot be found.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Changes since v1:
- Error out if device dvsec isn't found (Jonathan)
- Reword commit message
---
 drivers/cxl/cxlmem.h | 2 ++
 drivers/cxl/pci.c    | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8d96d009ad90..3ef3c652599e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -98,6 +98,7 @@ struct cxl_mbox_cmd {
  *
  * @dev: The device associated with this CXL state
  * @regs: Parsed register blocks
+ * @device_dvsec: Offset to the PCIe device DVSEC
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @lsa_size: Size of Label Storage Area
@@ -125,6 +126,7 @@ struct cxl_dev_state {
 	struct device *dev;
 
 	struct cxl_regs regs;
+	int device_dvsec;
 
 	size_t payload_size;
 	size_t lsa_size;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6aa3dd4b29a1..09ff82b4ea06 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -457,6 +457,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
 
+	cxlds->device_dvsec = pci_find_dvsec_capability(pdev,
+							PCI_DVSEC_VENDOR_ID_CXL,
+							CXL_DVSEC_PCIE_DEVICE);
+	if (!cxlds->device_dvsec) {
+		dev_err(&pdev->dev,
+			"Device DVSEC not present. Expect limited functionality.\n");
+		return -ENXIO;
+	}
+
 	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
 		return rc;
-- 
2.34.1

