Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8720BC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Nov 2022 21:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiKPVTm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiKPVTj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Nov 2022 16:19:39 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4037660695
        for <linux-cxl@vger.kernel.org>; Wed, 16 Nov 2022 13:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668633572; x=1700169572;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hcha5yeEAsYB3VZJSJu4gRqE5RkS9w5rPapNT2czLC4=;
  b=FySJxPJqj83OeQD7IC3VY/8AasqLi1iGDCrplBAJSCSHO2j50OTm/naS
   Z9L39XAl/WZK8sx57YvWK1pXzEAWgVDG2hqgYfwHjtukIG1dD/IJ4NM6O
   i9DflPfY8QOF3IyViuRYcUOmycSKt6YCJZ9JJviuVL4H8yQmrNSLAHADT
   nw4p9ef3YysqEdEB7Vr8QrIqON2GEcavzLTX8al7Ytr75XV+zrTc3eA/2
   yEs5AmCYvOOr+iQMj/cRmB2hESoJRsWRb/wnZqCTMMQzkV1HH2Bdz38d1
   6tvrLIhiqPjrbR5vFYEIc5ssJPteQal/S6qWIgtK1YiUeuo+sHS1rDpN6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="374805472"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="374805472"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:19:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="670654310"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="670654310"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:19:30 -0800
Subject: [PATCH v5 18/18] cxl: add dimm_id support for __nvdimm_create()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        benjamin.cheatham@amd.com
Date:   Wed, 16 Nov 2022 14:19:30 -0700
Message-ID: <166863357043.80269.4337575149671383294.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
References: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
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
index 38f1cea0a353..94a3f42096c8 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -593,6 +593,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return PTR_ERR(cxlds);
 
 	cxlds->serial = pdev->id;
+	rc = snprintf(cxlds->dev_id, CXL_DEV_ID_LEN, "%llu", cxlds->serial);
+	if (rc <= 0)
+		return -ENXIO;
+
 	cxlds->mbox_send = cxl_mock_mbox_send;
 	cxlds->payload_size = SZ_4K;
 


