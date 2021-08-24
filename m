Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FEAC43214
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C5D61247
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhHXQHJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:07:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:63233 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231829AbhHXQHJ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 24 Aug 2021 12:07:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="214220789"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="214220789"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:05:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="575064047"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:05:57 -0700
Subject: [PATCH v3 06/28] libnvdimm/labels: Add blk special cases for nlabel
 and position helpers
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, ben.widawsky@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Tue, 24 Aug 2021 09:05:57 -0700
Message-ID: <162982115698.1124374.10182273478536799613.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for LIBNVDIMM to manage labels on CXL devices deploy
helpers that abstract the label type from the implementation. The CXL
label format is mostly similar to the EFI label format with concepts /
fields added, like dynamic region creation and label type guids, and
other concepts removed like BLK-mode and interleave-set-cookie ids.

Finish off the BLK-mode specific helper conversion with the nlabel and
position behaviour that is specific to EFI v1.2 labels and not the
original v1.1 definition.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.c |   46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index d1a7f399cfe4..7188675c0955 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -898,6 +898,10 @@ static struct resource *to_resource(struct nvdimm_drvdata *ndd,
 	return NULL;
 }
 
+/*
+ * Use the presence of the type_guid as a flag to determine isetcookie
+ * usage and nlabel + position policy for blk-aperture namespaces.
+ */
 static void nsl_set_blk_isetcookie(struct nvdimm_drvdata *ndd,
 				   struct nd_namespace_label *nd_label,
 				   u64 isetcookie)
@@ -925,6 +929,28 @@ bool nsl_validate_blk_isetcookie(struct nvdimm_drvdata *ndd,
 	return true;
 }
 
+static void nsl_set_blk_nlabel(struct nvdimm_drvdata *ndd,
+			       struct nd_namespace_label *nd_label, int nlabel,
+			       bool first)
+{
+	if (!namespace_label_has(ndd, type_guid)) {
+		nsl_set_nlabel(ndd, nd_label, 0); /* N/A */
+		return;
+	}
+	nsl_set_nlabel(ndd, nd_label, first ? nlabel : 0xffff);
+}
+
+static void nsl_set_blk_position(struct nvdimm_drvdata *ndd,
+				 struct nd_namespace_label *nd_label,
+				 bool first)
+{
+	if (!namespace_label_has(ndd, type_guid)) {
+		nsl_set_position(ndd, nd_label, 0);
+		return;
+	}
+	nsl_set_position(ndd, nd_label, first ? 0 : 0xffff);
+}
+
 /*
  * 1/ Account all the labels that can be freed after this update
  * 2/ Allocate and write the label to the staging (next) index
@@ -1056,23 +1082,9 @@ static int __blk_label_update(struct nd_region *nd_region,
 		nsl_set_name(ndd, nd_label, nsblk->alt_name);
 		nsl_set_flags(ndd, nd_label, NSLABEL_FLAG_LOCAL);
 
-		/*
-		 * Use the presence of the type_guid as a flag to
-		 * determine isetcookie usage and nlabel + position
-		 * policy for blk-aperture namespaces.
-		 */
-		if (namespace_label_has(ndd, type_guid)) {
-			if (i == min_dpa_idx) {
-				nsl_set_nlabel(ndd, nd_label, nsblk->num_resources);
-				nsl_set_position(ndd, nd_label, 0);
-			} else {
-				nsl_set_nlabel(ndd, nd_label, 0xffff);
-				nsl_set_position(ndd, nd_label, 0xffff);
-			}
-		} else {
-			nsl_set_nlabel(ndd, nd_label, 0); /* N/A */
-			nsl_set_position(ndd, nd_label, 0); /* N/A */
-		}
+		nsl_set_blk_nlabel(ndd, nd_label, nsblk->num_resources,
+				   i == min_dpa_idx);
+		nsl_set_blk_position(ndd, nd_label, i == min_dpa_idx);
 		nsl_set_blk_isetcookie(ndd, nd_label, nd_set->cookie2);
 
 		nsl_set_dpa(ndd, nd_label, res->start);

