Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9FBC4338F
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BB461371
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Aug 2021 16:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhHXQJV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:09:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:13644 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232622AbhHXQJU (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 24 Aug 2021 12:09:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="281060138"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="281060138"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:06:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="643232631"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:06:36 -0700
Subject: [PATCH v3 13/28] libnvdimm/label: Define CXL region labels
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, ben.widawsky@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Tue, 24 Aug 2021 09:06:36 -0700
Message-ID: <162982119604.1124374.8364301519543316156.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a definition of the CXL 2.0 region label format. Note this is done
as a separate patch to make the next patch that adds namespace label
support easier to read.

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.h |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index 31f94fad7b92..76ecd0347dc2 100644
--- a/drivers/nvdimm/label.h
+++ b/drivers/nvdimm/label.h
@@ -65,6 +65,36 @@ struct nd_namespace_index {
 	u8 free[];
 };
 
+/**
+ * struct cxl_region_label - CXL 2.0 Table 211
+ * @type: uuid identifying this label format (region)
+ * @uuid: uuid for the region this label describes
+ * @flags: NSLABEL_FLAG_UPDATING (all other flags reserved)
+ * @position: this label's position in the set
+ * @dpa: start address in device-local capacity for this label
+ * @rawsize: size of this label's contribution to region
+ * @hpa: mandatory system physical address to map this region
+ * @slot: slot id of this label in label area
+ * @ig: interleave granularity (1 << @ig) * 256 bytes
+ * @align: alignment in SZ_256M blocks
+ * @checksum: fletcher64 sum of this label
+ */
+struct cxl_region_label {
+	u8 type[NSLABEL_UUID_LEN];
+	u8 uuid[NSLABEL_UUID_LEN];
+	__le32 flags;
+	__le16 nlabel;
+	__le16 position;
+	__le64 dpa;
+	__le64 rawsize;
+	__le64 hpa;
+	__le32 slot;
+	__le32 ig;
+	__le32 align;
+	u8 reserved[0xac];
+	__le64 checksum;
+};
+
 /**
  * struct nd_namespace_label - namespace superblock
  * @uuid: UUID per RFC 4122

