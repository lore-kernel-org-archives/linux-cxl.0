Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE01DC4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Aug 2021 22:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EBB60F8F
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Aug 2021 22:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbhHIW2r (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:28:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:16712 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236692AbhHIW2q (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 9 Aug 2021 18:28:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="201966648"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="201966648"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 15:28:24 -0700
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="505593427"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 15:28:24 -0700
Subject: [PATCH 07/23] libnvdimm/labels: Add type-guid helpers
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Jonathan.Cameron@huawei.com,
        ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com
Date:   Mon, 09 Aug 2021 15:28:24 -0700
Message-ID: <162854810459.1980150.1781727637396465986.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for CXL label support, which does not have the type-guid
concept, wrap the existing users with nsl_set_type_guid, and
nsl_validate_type_guid. Recall that the type-guid is a value in the ACPI
NFIT table to indicate how the memory range is used / should be
presented to upper layers.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.c          |   26 ++++++++++++++++++++++----
 drivers/nvdimm/namespace_devs.c |   19 ++++---------------
 drivers/nvdimm/nd.h             |    2 ++
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 7188675c0955..294ffc3cb582 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -772,6 +772,26 @@ static void reap_victim(struct nd_mapping *nd_mapping,
 	victim->label = NULL;
 }
 
+static void nsl_set_type_guid(struct nvdimm_drvdata *ndd,
+			      struct nd_namespace_label *nd_label, guid_t *guid)
+{
+	if (namespace_label_has(ndd, type_guid))
+		guid_copy(&nd_label->type_guid, guid);
+}
+
+bool nsl_validate_type_guid(struct nvdimm_drvdata *ndd,
+			    struct nd_namespace_label *nd_label, guid_t *guid)
+{
+	if (!namespace_label_has(ndd, type_guid))
+		return true;
+	if (!guid_equal(&nd_label->type_guid, guid)) {
+		dev_dbg(ndd->dev, "expect type_guid %pUb got %pUb\n", guid,
+			&nd_label->type_guid);
+		return false;
+	}
+	return true;
+}
+
 static int __pmem_label_update(struct nd_region *nd_region,
 		struct nd_mapping *nd_mapping, struct nd_namespace_pmem *nspm,
 		int pos, unsigned long flags)
@@ -822,8 +842,7 @@ static int __pmem_label_update(struct nd_region *nd_region,
 	nsl_set_lbasize(ndd, nd_label, nspm->lbasize);
 	nsl_set_dpa(ndd, nd_label, res->start);
 	nsl_set_slot(ndd, nd_label, slot);
-	if (namespace_label_has(ndd, type_guid))
-		guid_copy(&nd_label->type_guid, &nd_set->type_guid);
+	nsl_set_type_guid(ndd, nd_label, &nd_set->type_guid);
 	if (namespace_label_has(ndd, abstraction_guid))
 		guid_copy(&nd_label->abstraction_guid,
 				to_abstraction_guid(ndns->claim_class,
@@ -1091,8 +1110,7 @@ static int __blk_label_update(struct nd_region *nd_region,
 		nsl_set_rawsize(ndd, nd_label, resource_size(res));
 		nsl_set_lbasize(ndd, nd_label, nsblk->lbasize);
 		nsl_set_slot(ndd, nd_label, slot);
-		if (namespace_label_has(ndd, type_guid))
-			guid_copy(&nd_label->type_guid, &nd_set->type_guid);
+		nsl_set_type_guid(ndd, nd_label, &nd_set->type_guid);
 		if (namespace_label_has(ndd, abstraction_guid))
 			guid_copy(&nd_label->abstraction_guid,
 					to_abstraction_guid(ndns->claim_class,
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index fbd0c2fcea4a..af5a31dd3147 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1859,14 +1859,9 @@ static bool has_uuid_at_pos(struct nd_region *nd_region, u8 *uuid,
 			if (memcmp(nd_label->uuid, uuid, NSLABEL_UUID_LEN) != 0)
 				continue;
 
-			if (namespace_label_has(ndd, type_guid)
-					&& !guid_equal(&nd_set->type_guid,
-						&nd_label->type_guid)) {
-				dev_dbg(ndd->dev, "expect type_guid %pUb got %pUb\n",
-						&nd_set->type_guid,
-						&nd_label->type_guid);
+			if (!nsl_validate_type_guid(ndd, nd_label,
+						    &nd_set->type_guid))
 				continue;
-			}
 
 			if (found_uuid) {
 				dev_dbg(ndd->dev, "duplicate entry for uuid\n");
@@ -2265,14 +2260,8 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 	struct device *dev = NULL;
 	struct resource *res;
 
-	if (namespace_label_has(ndd, type_guid)) {
-		if (!guid_equal(&nd_set->type_guid, &nd_label->type_guid)) {
-			dev_dbg(ndd->dev, "expect type_guid %pUb got %pUb\n",
-					&nd_set->type_guid,
-					&nd_label->type_guid);
-			return ERR_PTR(-EAGAIN);
-		}
-	}
+	if (!nsl_validate_type_guid(ndd, nd_label, &nd_set->type_guid))
+		return ERR_PTR(-EAGAIN);
 	if (!nsl_validate_blk_isetcookie(ndd, nd_label, nd_set->cookie2))
 		return ERR_PTR(-EAGAIN);
 
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 2a9a608b7f17..f3c364df9449 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -179,6 +179,8 @@ static inline void nsl_set_lbasize(struct nvdimm_drvdata *ndd,
 bool nsl_validate_blk_isetcookie(struct nvdimm_drvdata *ndd,
 				 struct nd_namespace_label *nd_label,
 				 u64 isetcookie);
+bool nsl_validate_type_guid(struct nvdimm_drvdata *ndd,
+			    struct nd_namespace_label *nd_label, guid_t *guid);
 
 struct nd_region_data {
 	int ns_count;

