Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D7DC4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Dec 2022 22:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiLLWU0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiLLWUZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Dec 2022 17:20:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81131DED2
        for <linux-cxl@vger.kernel.org>; Mon, 12 Dec 2022 14:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670883623; x=1702419623;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h0bf9qAUT14XhFVT8IePutVfPs6E2XuKLQ7NiiLLICc=;
  b=PoS2v9EIzu9j29ZxMmrH6M7kAyeCvrv9btdwwaNO9TNPaVrdrmV9pATb
   LRY3kOtc+RVs4xaB0begVNH4JkH1/ayc/D6ACC3EQi4Q+WztnEHUCzah/
   yP8ysEdCyJbRzOxhVUn4JM1CDxgmqx26NlYumqm8PBWzO8zVDdVqiM9Dw
   YWMgU+InBKgOp/Y/uFbaX7Moui9nvJo9NaOjoqj8tpZoglznx+mEGhmh1
   v7ujI7hus7CH3LVcdHb5Vu1gYI7WRuU0XcEeAhmhQiwejCXxnhTW1WkAW
   Y7g2+8T7AkQMUndgc03UTn+06O3pV5Q8xypZ+M14aIE4pkVtnQU8II6t7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="345033528"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="345033528"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 14:20:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="641885356"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="641885356"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 14:20:22 -0800
Subject: [PATCH] cxl: add RAS status unmasking for CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com
Date:   Mon, 12 Dec 2022 15:20:22 -0700
Message-ID: <167088362227.2423645.1158488960356900672.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

By default the CXL RAS mask registers bits are defaulted to 1's and suppress
all error reporting. If the kernel has negotiated ownership of error
handling for CXL then unmask the mask registers by writing 0s.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---

Based on patch posted by Ira [1] to export CXL native error reporting control.

[1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/
---
 drivers/cxl/cxl.h |    1 +
 drivers/cxl/pci.c |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1b1cf459ac77..31e795c6d537 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
 #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
 #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
+#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
 #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
 #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
 #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 33083a522fd1..7fce67d493f3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -419,6 +419,41 @@ static void disable_aer(void *pdev)
 	pci_disable_pcie_error_reporting(pdev);
 }
 
+/*
+ * CXL v3.0 6.2.3 Table 6-4
+ * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
+ * mode, otherwise it's 68B flits mode.
+ */
+static bool cxl_pci_flit_256(struct pci_dev *pdev)
+{
+	u32 lnksta2;
+
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
+	return lnksta2 & BIT(10);
+}
+
+static void cxl_pci_ras_unmask(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	u32 val;
+
+	if (!cxlds->regs.ras)
+		return;
+
+	/* BIOS has CXL error control */
+	if (!host_bridge->native_cxl_error)
+		return;
+
+	val = 0;
+	if (!cxl_pci_flit_256(pdev))
+		val |= CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
+	writel(val, cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET);
+
+	val = 0;
+	writel(val, cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -498,6 +533,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	if (cxlds->regs.ras) {
 		pci_enable_pcie_error_reporting(pdev);
+		cxl_pci_ras_unmask(pdev);
 		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
 		if (rc)
 			return rc;


