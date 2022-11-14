Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2057EC4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 20:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbiKNUfA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiKNUev (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 15:34:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6711472
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668458089; x=1699994089;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jpSWnISbv2VImCMR2REZ86zBTitBZ/PNe/oOYeKWB3w=;
  b=Yju5DEbgVhQm1fMCV14eVvQp36AHaz0mJCGORhsQTULYp41RwiXKLWDV
   nVzDnh6zb4gha1eox3l/6F64CePQNzsD06kcKwFFFv3WfkxxC1MhOX8Xp
   6RilCEmIFT9yjQ1fhZwKtvA1EOc9igJVprYAkZQxF3aruXjqfgqMaW/NR
   1GJTsvmxTMZu0bLehjrycnwPXfMuOgVoFTqT4XaNm285PvQwhZAaEEayT
   pcVT7yVaak2492K1nDY6Ou0LwuBsKGhkYXR30r47hvYVFsjon4nwDK+LM
   HaEK8i5er5onwMKsiio+SCrf8fGDKHNPDLTtxXt1KWMcCmUMEPLJo93Tw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313224153"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313224153"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:34:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702155142"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="702155142"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:34:48 -0800
Subject: [PATCH v4 18/18] cxl: add dimm_id support for __nvdimm_create()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Mon, 14 Nov 2022 13:34:48 -0700
Message-ID: <166845808855.2496228.2510882323325476885.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
References: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Set the cxlds->serial as the dimm_id to be fed to __nvdimm_create(). The
security code uses that as the key description for the security key of the
memory device. The nvdimm unlock code cannot find the respective key
without the dimm_id.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h         |    3 +++
 drivers/cxl/pci.c            |    4 ++++
 drivers/cxl/pmem.c           |    4 +++-
 tools/testing/cxl/test/mem.c |    4 ++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 75baeb0bbe57..76bdec873868 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -178,6 +178,8 @@ struct cxl_endpoint_dvsec_info {
 	struct range dvsec_range[2];
 };
 
+#define CXL_DEV_ID_LEN 32
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -244,6 +246,7 @@ struct cxl_dev_state {
 
 	resource_size_t component_reg_phys;
 	u64 serial;
+	u8 dev_id[CXL_DEV_ID_LEN]; /* for nvdimm, string of 'serial' */
 
 	struct xarray doe_mbs;
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 621a0522b554..c48fcd2a90ef 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -456,6 +456,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return PTR_ERR(cxlds);
 
 	cxlds->serial = pci_get_dsn(pdev);
+	rc = snprintf(cxlds->dev_id, CXL_DEV_ID_LEN, "%llu", cxlds->serial);
+	if (rc <= 0)
+		return -ENXIO;
+
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
 		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
 	if (!cxlds->cxl_dvsec)
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 322f834cc27d..80556dc8d29c 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -112,9 +112,11 @@ static int cxl_nvdimm_probe(struct device *dev)
 	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
 	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
 	set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
+
 	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
 				 cxl_dimm_attribute_groups, flags,
-				 cmd_mask, 0, NULL, NULL, cxl_security_ops, NULL);
+				 cmd_mask, 0, NULL, cxlds->dev_id,
+				 cxl_security_ops, NULL);
 	if (!nvdimm) {
 		rc = -ENOMEM;
 		goto out;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index fc28f7cc147a..35723d45438e 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -571,6 +571,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return PTR_ERR(cxlds);
 
 	cxlds->serial = pdev->id;
+	rc = snprintf(cxlds->dev_id, CXL_DEV_ID_LEN, "%llu", cxlds->serial);
+	if (rc <= 0)
+		return -ENXIO;
+
 	cxlds->mbox_send = cxl_mock_mbox_send;
 	cxlds->payload_size = SZ_4K;
 


