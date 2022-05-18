Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718F2C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiERXfI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiERXfH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:35:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422F19FAE
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916906; x=1684452906;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b3TAymHosyj87qbnHwgkCYcSD2l6lC7iw7sZNMCeLBs=;
  b=KbPh2x121jcjlYyZPnxtUqYJTkANMhM+6ZUj6fOiVbyRc3/ZvEXiPnJa
   AYdeyPXr5JpNMAlDXVBjEsjyPMZn/tXqNYfLNzRXPXLoT3yc+Szm5T71I
   Lc98a+lx8FBfttXFk7LU97KRSeRnfDyd0nzWZhn3GPVd7AM2gY8Bvds3y
   1z1nRMUeseezpctjSohlREv5W0Y4ou48/ci6apFFM4wRjcZve1NzGCnH1
   s8VXLwjFCjs8j/sIQ/n633p5l6yLcqy8aHdKY7kqsvhKg+mrTYzRpWuiG
   TOj6mkvBWaeazJ9TwlqyVPPXdmomp+pqqMIYxImqSnIaBeWr/BDEWlMBC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="251836940"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="251836940"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:35:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="523774423"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:35:06 -0700
Subject: [PATCH v3 10/13] cxl/pci: Drop @info argument to
 cxl_hdm_decode_init()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:35:06 -0700
Message-ID: <165291690612.1426646.7866084245521113414.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Now that nothing external to cxl_hdm_decode_init() considers
'struct cxl_endpoint_dvec_info' move it internal to
cxl_hdm_decode_init().

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c        |   15 +++++++--------
 drivers/cxl/cxlpci.h          |    4 +---
 drivers/cxl/mem.c             |    3 +--
 tools/testing/cxl/test/mock.c |    9 +++------
 4 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0fbda1a1ca1b..7d2238edc379 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -234,14 +234,13 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 /**
  * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
  * @cxlds: Device state
- * @info: DVSEC Range cached enumeration
  *
  * Try to enable the endpoint's HDM Decoder Capability
  */
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
-			struct cxl_endpoint_dvsec_info *info)
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct cxl_endpoint_dvsec_info info = { 0 };
 	int hdm_count, rc, i, ranges = 0;
 	struct device *dev = &pdev->dev;
 	int d = cxlds->cxl_dvsec;
@@ -281,8 +280,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 		return rc;
 	}
 
-	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
-	if (!info->mem_enabled)
+	info.mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
+	if (!info.mem_enabled)
 		return 0;
 
 	for (i = 0; i < hdm_count; i++) {
@@ -317,7 +316,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 
 		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
-		info->dvsec_range[i] = (struct range) {
+		info.dvsec_range[i] = (struct range) {
 			.start = base,
 			.end = base + size - 1
 		};
@@ -326,13 +325,13 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 			ranges++;
 	}
 
-	info->ranges = ranges;
+	info.ranges = ranges;
 
 	/*
 	 * If DVSEC ranges are being used instead of HDM decoder registers there
 	 * is no use in trying to manage those.
 	 */
-	if (!__cxl_hdm_decode_init(cxlds, info)) {
+	if (!__cxl_hdm_decode_init(cxlds, &info)) {
 		dev_err(dev,
 			"Legacy range registers configuration prevents HDM operation.\n");
 		return -EBUSY;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 202fdaa8d293..53cd34f8813c 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -73,7 +73,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
-struct cxl_endpoint_dvsec_info;
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
-			struct cxl_endpoint_dvsec_info *info);
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2a5dc92d566f..8ce89d128e36 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -54,7 +54,6 @@ static void enable_suspend(void *data)
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_endpoint_dvsec_info info = { 0 };
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *parent_port;
 	int rc;
@@ -95,7 +94,7 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = cxl_hdm_decode_init(cxlds, &info);
+	rc = cxl_hdm_decode_init(cxlds);
 	if (rc)
 		return rc;
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index ddf0e7dd9249..45ffbb8f519a 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -208,16 +208,13 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
 
-int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
-				struct cxl_endpoint_dvsec_info *info)
+bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
 {
 	int rc = 0, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (ops && ops->is_mock_dev(cxlds->dev))
-		info->mem_enabled = 1;
-	else
-		rc = cxl_hdm_decode_init(cxlds, info);
+	if (!ops || !ops->is_mock_dev(cxlds->dev))
+		rc = cxl_hdm_decode_init(cxlds);
 	put_cxl_mock_ops(index);
 
 	return rc;

