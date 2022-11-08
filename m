Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC44BC4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 17:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiKHR16 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiKHR1j (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 12:27:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806EF60EAB
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 09:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667928426; x=1699464426;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SmKi4qdgdYHPR6Cxq5tL4Aqdb93XBr9hHHYMsDK0G/Q=;
  b=hgSwWnKmKNNENDElmyOzUhNf/mel5j/9XGf/XJ7sNt4vSYFS/yTD61NO
   dUjmLvBr21hSB9r/rtebO7L4V8ntgZCBqzm9mMAVLAaC6zmbKZ2C33q53
   N8zWRKMDKFmQD5ohZXhQdvqZK8Tg95b1B0Dmm1Uu19vR9MWsiRMXqbGrU
   Zg55nw5/kn2Qi0Omy/FNJz5f3cyH/3yFjnBLxC1Zeryw/EUuG4jj3Q3mD
   z1p2VkTDcThsLEm0XSCVTNOKbjtCNtZit3TJhd+mFL7UaGWCNmuj/2zsY
   FyU/aMiJARZtU9PH+eadw7/yoSDg0Mjxu20rwgNZLpE96xdjg3rdzh9eg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309465537"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="309465537"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:27:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="705378776"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="705378776"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:27:06 -0800
Subject: [PATCH v3 18/18] cxl: add dimm_id support for __nvdimm_create()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Tue, 08 Nov 2022 10:27:05 -0700
Message-ID: <166792842570.3767969.9130360593083380428.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166792815961.3767969.2621677491424623673.stgit@djiang5-desk3.ch.intel.com>
References: <166792815961.3767969.2621677491424623673.stgit@djiang5-desk3.ch.intel.com>
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
index aa6dda21bc5f..9ce7a0560ce4 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -565,6 +565,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return PTR_ERR(cxlds);
 
 	cxlds->serial = pdev->id;
+	rc = snprintf(cxlds->dev_id, CXL_DEV_ID_LEN, "%llu", cxlds->serial);
+	if (rc <= 0)
+		return -ENXIO;
+
 	cxlds->mbox_send = cxl_mock_mbox_send;
 	cxlds->payload_size = SZ_4K;
 


