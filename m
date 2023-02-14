Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900FEC61DA4
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 19:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjBNTlN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBNTlM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 14:41:12 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE132D140
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 11:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676403669; x=1707939669;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=btCArGDFC06JemQLuHLf5iC6KscBRvqhNXwoPNFoY7w=;
  b=HH+STHw1l6moUChivWeHyALKJRoFJ1WhQ59K9GCjtjI++UPFHtcgP3EZ
   A4x3rUdMKeTV9+KP61f99ugJnoSb7ijbxUsDlUaKcT1+BbnFAG8uyxXHA
   fhsasa3f/PDwJFrBR39WWMD/bbg5TlNquYIKl1gnqmDhC92rYe9ZtSJPO
   V4Mib/7F45DR8u5Jy8pc2euE13YnG5OTU3PB4cNNH0ra8CKoCvrvAEOuH
   q7dqFGtoVYjbV9bA9iWCNoS+FBiuzLs6PQ/zM5c6EwJXj/C8pCUPMR4nB
   i85n4t4ILWK21UfWww5zmIOyghqwem4Oe1h4lr06suA7h/X2PUEdSbhpH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333384797"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="333384797"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793207791"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="793207791"
Received: from mofarooq-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.68.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:08 -0800
Subject: [PATCH v5 1/7] cxl/pci: Break out range register decoding from
 cxl_hdm_decode_init()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Tue, 14 Feb 2023 11:41:08 -0800
Message-ID: <167640366839.935665.11816388524993234329.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
References: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

There are 2 scenarios that requires additional handling. 1. A device that
has active ranges in DVSEC range registers (RR) but no HDM decoder register
block. 2. A device that has both RR active and HDM, but the HDM decoders
are not programmed. The goal is to create emulated decoder software structs
based on the RR.

Move the CXL DVSEC range register decoding code block from
cxl_hdm_decode_init() to its own function. Refactor code in preparation for
the HDM decoder emulation.  There is no functionality change to the code.
Name the new function to cxl_dvsec_rr_decode().

The only change is to set range->start and range->end to CXL_RESOURCE_NONE
and skipping the reading of base registers if the range size is 0, which
equates to range not active.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c |   64 ++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 57764e9cd19d..52bf6b4d093e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -141,11 +141,10 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
 
-static int wait_for_valid(struct cxl_dev_state *cxlds)
+static int wait_for_valid(struct pci_dev *pdev, int d)
 {
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	int d = cxlds->cxl_dvsec, rc;
 	u32 val;
+	int rc;
 
 	/*
 	 * Memory_Info_Valid: When set, indicates that the CXL Range 1 Size high
@@ -334,20 +333,11 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 	return true;
 }
 
-/**
- * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
- * @cxlds: Device state
- * @cxlhdm: Mapped HDM decoder Capability
- *
- * Try to enable the endpoint's HDM Decoder Capability
- */
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
+static int cxl_dvsec_rr_decode(struct device *dev, int d,
+			       struct cxl_endpoint_dvsec_info *info)
 {
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	struct cxl_endpoint_dvsec_info info = { 0 };
+	struct pci_dev *pdev = to_pci_dev(dev);
 	int hdm_count, rc, i, ranges = 0;
-	struct device *dev = &pdev->dev;
-	int d = cxlds->cxl_dvsec;
 	u16 cap, ctrl;
 
 	if (!d) {
@@ -378,7 +368,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
-	rc = wait_for_valid(cxlds);
+	rc = wait_for_valid(pdev, d);
 	if (rc) {
 		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
 		return rc;
@@ -389,9 +379,9 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 	 * disabled, and they will remain moot after the HDM Decoder
 	 * capability is enabled.
 	 */
-	info.mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
-	if (!info.mem_enabled)
-		goto hdm_init;
+	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
+	if (!info->mem_enabled)
+		return 0;
 
 	for (i = 0; i < hdm_count; i++) {
 		u64 base, size;
@@ -410,6 +400,13 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 			return rc;
 
 		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
+		if (!size) {
+			info->dvsec_range[i] = (struct range) {
+				.start = 0,
+				.end = CXL_RESOURCE_NONE,
+			};
+			continue;
+		}
 
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
@@ -425,22 +422,41 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 
 		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
-		info.dvsec_range[i] = (struct range) {
+		info->dvsec_range[i] = (struct range) {
 			.start = base,
 			.end = base + size - 1
 		};
 
-		if (size)
-			ranges++;
+		ranges++;
 	}
 
-	info.ranges = ranges;
+	info->ranges = ranges;
+
+	return 0;
+}
+
+/**
+ * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
+ * @cxlds: Device state
+ * @cxlhdm: Mapped HDM decoder Capability
+ *
+ * Try to enable the endpoint's HDM Decoder Capability
+ */
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
+{
+	struct cxl_endpoint_dvsec_info info = { 0 };
+	struct device *dev = cxlds->dev;
+	int d = cxlds->cxl_dvsec;
+	int rc;
+
+	rc = cxl_dvsec_rr_decode(dev, d, &info);
+	if (rc < 0)
+		return rc;
 
 	/*
 	 * If DVSEC ranges are being used instead of HDM decoder registers there
 	 * is no use in trying to manage those.
 	 */
-hdm_init:
 	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, &info)) {
 		dev_err(dev,
 			"Legacy range registers configuration prevents HDM operation.\n");

