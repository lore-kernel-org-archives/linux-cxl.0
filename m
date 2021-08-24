Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD175C4338F
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3BB6125F
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhHXQGr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:06:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:46690 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhHXQGq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 24 Aug 2021 12:06:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="302926495"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="302926495"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:05:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="535913099"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:05:35 -0700
Subject: [PATCH v3 02/28] libnvdimm/labels: Add isetcookie validation helper
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, ben.widawsky@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Tue, 24 Aug 2021 09:05:35 -0700
Message-ID: <162982113550.1124374.206762177785773038.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation to handle CXL labels with the same code that handles EFI
labels, add a specific interleave-set-cookie validation helper
rather than a getter since the CXL label type does not support this
concept. The answer for CXL labels will always be true.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |    8 +++-----
 drivers/nvdimm/nd.h             |    7 +++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 94da804372bf..f33245c27cc4 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1847,15 +1847,13 @@ static bool has_uuid_at_pos(struct nd_region *nd_region, u8 *uuid,
 		list_for_each_entry(label_ent, &nd_mapping->labels, list) {
 			struct nd_namespace_label *nd_label = label_ent->label;
 			u16 position, nlabel;
-			u64 isetcookie;
 
 			if (!nd_label)
 				continue;
-			isetcookie = nsl_get_isetcookie(ndd, nd_label);
 			position = nsl_get_position(ndd, nd_label);
 			nlabel = nsl_get_nlabel(ndd, nd_label);
 
-			if (isetcookie != cookie)
+			if (!nsl_validate_isetcookie(ndd, nd_label, cookie))
 				continue;
 
 			if (memcmp(nd_label->uuid, uuid, NSLABEL_UUID_LEN) != 0)
@@ -1968,10 +1966,10 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 		return ERR_PTR(-ENXIO);
 	}
 
-	if (nsl_get_isetcookie(ndd, nd_label) != cookie) {
+	if (!nsl_validate_isetcookie(ndd, nd_label, cookie)) {
 		dev_dbg(&nd_region->dev, "invalid cookie in label: %pUb\n",
 				nd_label->uuid);
-		if (nsl_get_isetcookie(ndd, nd_label) != altcookie)
+		if (!nsl_validate_isetcookie(ndd, nd_label, altcookie))
 			return ERR_PTR(-EAGAIN);
 
 		dev_dbg(&nd_region->dev, "valid altcookie in label: %pUb\n",
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 61f43f0edabf..b3feaf3699f7 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -83,6 +83,13 @@ static inline u64 nsl_get_isetcookie(struct nvdimm_drvdata *ndd,
 	return __le64_to_cpu(nd_label->isetcookie);
 }
 
+static inline bool nsl_validate_isetcookie(struct nvdimm_drvdata *ndd,
+					   struct nd_namespace_label *nd_label,
+					   u64 cookie)
+{
+	return cookie == __le64_to_cpu(nd_label->isetcookie);
+}
+
 static inline u16 nsl_get_position(struct nvdimm_drvdata *ndd,
 				   struct nd_namespace_label *nd_label)
 {

