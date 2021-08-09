Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A30EC4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Aug 2021 22:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E03960EB5
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Aug 2021 22:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbhHIW2a (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:28:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:26086 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236692AbhHIW23 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 9 Aug 2021 18:28:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="300382419"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="300382419"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 15:28:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="439090753"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 15:28:08 -0700
Subject: [PATCH 04/23] libnvdimm/labels: Add a checksum calculation helper
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Jonathan.Cameron@huawei.com,
        ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com
Date:   Mon, 09 Aug 2021 15:28:08 -0700
Message-ID: <162854808885.1980150.16357075479454603275.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
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

CXL labels support checksums by default, but early versions of the EFI
labels did not. Add a validate function that can return true in the case
the label format does not implement a checksum.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.c |   68 +++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index b40a4eda1d89..3f73412dd438 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -346,29 +346,45 @@ static bool preamble_next(struct nvdimm_drvdata *ndd,
 			free, nslot);
 }
 
+static bool nsl_validate_checksum(struct nvdimm_drvdata *ndd,
+				  struct nd_namespace_label *nd_label)
+{
+	u64 sum, sum_save;
+
+	if (!namespace_label_has(ndd, checksum))
+		return true;
+
+	sum_save = nsl_get_checksum(ndd, nd_label);
+	nsl_set_checksum(ndd, nd_label, 0);
+	sum = nd_fletcher64(nd_label, sizeof_namespace_label(ndd), 1);
+	nsl_set_checksum(ndd, nd_label, sum_save);
+	return sum == sum_save;
+}
+
+static void nsl_calculate_checksum(struct nvdimm_drvdata *ndd,
+				   struct nd_namespace_label *nd_label)
+{
+	u64 sum;
+
+	if (!namespace_label_has(ndd, checksum))
+		return;
+	nsl_set_checksum(ndd, nd_label, 0);
+	sum = nd_fletcher64(nd_label, sizeof_namespace_label(ndd), 1);
+	nsl_set_checksum(ndd, nd_label, sum);
+}
+
 static bool slot_valid(struct nvdimm_drvdata *ndd,
 		struct nd_namespace_label *nd_label, u32 slot)
 {
+	bool valid;
+
 	/* check that we are written where we expect to be written */
 	if (slot != nsl_get_slot(ndd, nd_label))
 		return false;
-
-	/* check checksum */
-	if (namespace_label_has(ndd, checksum)) {
-		u64 sum, sum_save;
-
-		sum_save = nsl_get_checksum(ndd, nd_label);
-		nsl_set_checksum(ndd, nd_label, 0);
-		sum = nd_fletcher64(nd_label, sizeof_namespace_label(ndd), 1);
-		nsl_set_checksum(ndd, nd_label, sum_save);
-		if (sum != sum_save) {
-			dev_dbg(ndd->dev, "fail checksum. slot: %d expect: %#llx\n",
-				slot, sum);
-			return false;
-		}
-	}
-
-	return true;
+	valid = nsl_validate_checksum(ndd, nd_label);
+	if (!valid)
+		dev_dbg(ndd->dev, "fail checksum. slot: %d\n", slot);
+	return valid;
 }
 
 int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd)
@@ -812,13 +828,7 @@ static int __pmem_label_update(struct nd_region *nd_region,
 		guid_copy(&nd_label->abstraction_guid,
 				to_abstraction_guid(ndns->claim_class,
 					&nd_label->abstraction_guid));
-	if (namespace_label_has(ndd, checksum)) {
-		u64 sum;
-
-		nsl_set_checksum(ndd, nd_label, 0);
-		sum = nd_fletcher64(nd_label, sizeof_namespace_label(ndd), 1);
-		nsl_set_checksum(ndd, nd_label, sum);
-	}
+	nsl_calculate_checksum(ndd, nd_label);
 	nd_dbg_dpa(nd_region, ndd, res, "\n");
 
 	/* update label */
@@ -1049,15 +1059,7 @@ static int __blk_label_update(struct nd_region *nd_region,
 			guid_copy(&nd_label->abstraction_guid,
 					to_abstraction_guid(ndns->claim_class,
 						&nd_label->abstraction_guid));
-
-		if (namespace_label_has(ndd, checksum)) {
-			u64 sum;
-
-			nsl_set_checksum(ndd, nd_label, 0);
-			sum = nd_fletcher64(nd_label,
-					sizeof_namespace_label(ndd), 1);
-			nsl_set_checksum(ndd, nd_label, sum);
-		}
+		nsl_calculate_checksum(ndd, nd_label);
 
 		/* update label */
 		offset = nd_label_offset(ndd, nd_label);

