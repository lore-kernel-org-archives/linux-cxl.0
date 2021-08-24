Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C620C4338F
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5661357
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhHXQIY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:08:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:10539 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhHXQIY (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 24 Aug 2021 12:08:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="278355783"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="278355783"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:06:24 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="426161680"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:06:24 -0700
Subject: [PATCH v3 11/28] libnvdimm/label: Add a helper for nlabel validation
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, ben.widawsky@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Tue, 24 Aug 2021 09:06:24 -0700
Message-ID: <162982118423.1124374.11980785134458815600.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In the CXL namespace label there is no need for nlabel since that is
inferred from the region. Add a helper that moves nsl_get_label() behind
a helper that validates the number of labels relative to the region.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |    5 ++---
 drivers/nvdimm/nd.h             |    7 +++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index d4959981c7d4..28ed14052e36 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1848,12 +1848,11 @@ static bool has_uuid_at_pos(struct nd_region *nd_region, const uuid_t *uuid,
 
 		list_for_each_entry(label_ent, &nd_mapping->labels, list) {
 			struct nd_namespace_label *nd_label = label_ent->label;
-			u16 position, nlabel;
+			u16 position;
 
 			if (!nd_label)
 				continue;
 			position = nsl_get_position(ndd, nd_label);
-			nlabel = nsl_get_nlabel(ndd, nd_label);
 
 			if (!nsl_validate_isetcookie(ndd, nd_label, cookie))
 				continue;
@@ -1870,7 +1869,7 @@ static bool has_uuid_at_pos(struct nd_region *nd_region, const uuid_t *uuid,
 				return false;
 			}
 			found_uuid = true;
-			if (nlabel != nd_region->ndr_mappings)
+			if (!nsl_validate_nlabel(nd_region, ndd, nd_label))
 				continue;
 			if (position != pos)
 				continue;
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ec3c9aad7f50..036638bdb7e3 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -342,6 +342,13 @@ struct nd_region {
 	struct nd_mapping mapping[];
 };
 
+static inline bool nsl_validate_nlabel(struct nd_region *nd_region,
+				       struct nvdimm_drvdata *ndd,
+				       struct nd_namespace_label *nd_label)
+{
+	return nsl_get_nlabel(ndd, nd_label) == nd_region->ndr_mappings;
+}
+
 struct nd_blk_region {
 	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
 	int (*do_io)(struct nd_blk_region *ndbr, resource_size_t dpa,

