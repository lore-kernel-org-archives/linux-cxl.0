Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87528C636D3
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 19:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjBHTU4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjBHTU4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 14:20:56 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBDF51C60
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 11:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675884055; x=1707420055;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KEQoi+p6qL7LGo9+vJjFVHdrgXYd/XM/Zv401xq5arQ=;
  b=eIEAbD/LGurwvVFw5XHj3+Detzl55PpiYabrKZj/v1+ezFlKQ2ISOWti
   0lZZU65ussdrvOzci8cBLULedcRp+34WyXw5uTcyIu9Y0YhNDAfoHvtyx
   tOAPT7UIOiA96cctL01ZxB3xCUJskgrB07o7O8qbV1o0prmSUHztF/Cti
   iBZKlYaMCgcbSlQIlQ6Wpkw5fMR3BDB0xlGg+DXgEJKctPzxm84a7XnIb
   CBx3hncHse/3V8Yi2pnd4MJU0BSLn3ZatI7MCark2xJzEm7qzHRQ0ufCc
   9ciP7pimNT5u1/59dq0YZaxg5A4qubHujHmikN2ItHdWB3OFEGVX+FeQC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="329925982"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="329925982"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:20:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776164923"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776164923"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.48.215])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:20:54 -0800
Subject: [PATCH v4 1/7] cxl: break out range register decoding from
 cxl_hdm_decode_init()
From:   Dave Jiang <dave.jiang@intel.com>
To:     dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Date:   Wed, 08 Feb 2023 12:20:52 -0700
Message-ID: <167588405143.1155956.12227802555070949872.stgit@djiang5-mobl3.local>
In-Reply-To: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
References: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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

---
v4:
- Init invalid range start to 0. (Dan)
v2:
- Refactor to continue when size is 0. (Jonathan)
---
 drivers/cxl/core/pci.c |   63 ++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 57764e9cd19d..2ef03161a8bb 100644
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
+static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
+			       struct cxl_endpoint_dvsec_info *info)
 {
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	struct cxl_endpoint_dvsec_info info = { 0 };
 	int hdm_count, rc, i, ranges = 0;
 	struct device *dev = &pdev->dev;
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
@@ -425,22 +422,42 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 
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
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct cxl_endpoint_dvsec_info info = { 0 };
+	struct device *dev = &pdev->dev;
+	int d = cxlds->cxl_dvsec;
+	int rc;
+
+	rc = cxl_dvsec_rr_decode(pdev, d, &info);
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


