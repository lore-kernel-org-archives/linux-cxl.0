Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F4CC6FA8E
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 15:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIUPiq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiIUPi1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 11:38:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C569E890
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663774465; x=1695310465;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gt2jmv9wWZQFQH3sB6A0swBtQahAJrX7Q7RXVbA0WSU=;
  b=Sm5BGC6msN+dLmom0i34vOMsvrveKIdatIvwbS9GgNZjd0PXN5PiZJ5H
   BtDk9EuJkl6tdZk0VXu35qCEfbjNs2/gjkY5kBniMvN+IfkACGsnKMI5j
   D47ZfxBKxiKkgoW0wq2GHxLd4iNwwYTcWYRIK+IRe6XAtD8zAOfUY+ikJ
   W/h8PZpnqZdclJbQzFuCoY4swgmgB4wlNJ4bIOqNJMB3JsvYRumgB8j2h
   UCh4/qYwQ5CE+zwPhLKeeq5uQTsOb5m2u9U6VaB7H2cvqRfaOPMerxxzK
   5w0UhyNZe74Pieg1jUsakuRwSn7ySgZw9b2FppfxubizGpILOYalKU5gp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300877292"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="300877292"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:33:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="723257378"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:33:21 -0700
Subject: [PATCH v2 19/19] cxl: add dimm_id support for __nvdimm_create()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com
Date:   Wed, 21 Sep 2022 08:33:21 -0700
Message-ID: <166377440119.430546.15623409728442106946.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h         |    3 +++
 drivers/cxl/pci.c            |    4 ++++
 drivers/cxl/pmem.c           |    4 +++-
 tools/testing/cxl/test/mem.c |    4 ++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 1266df3b2d3d..24d1c66a30ed 100644
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
index faeb5d9d7a7a..de5f37e0fe6f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -451,6 +451,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
index cb303edb925d..444f18c09848 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -113,9 +113,11 @@ static int cxl_nvdimm_probe(struct device *dev)
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
index a0a58156c15a..ca1d8f2fc6a4 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -556,6 +556,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return PTR_ERR(cxlds);
 
 	cxlds->serial = pdev->id;
+	rc = snprintf(cxlds->dev_id, CXL_DEV_ID_LEN, "%llu", cxlds->serial);
+	if (rc <= 0)
+		return -ENXIO;
+
 	cxlds->mbox_send = cxl_mock_mbox_send;
 	cxlds->payload_size = SZ_4K;
 


