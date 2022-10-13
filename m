Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC9FC43217
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 23:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJMXjS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 19:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJMXjR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 19:39:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B6018DD77
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665704356; x=1697240356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eN6lcDVjsR55vDtjZErE2HjYBzlQ5DmzvW/qI5ib3Mw=;
  b=HCuQisC0ahyCKBkpfY299gj1XKxqC5JRAL76opD4mMpsLD7eAHfjaBjh
   QcQ5qaguKdDdnKrOOWAGEICozwHhNj+bfR3f5qaIS45GBekF4wnKR5eBw
   I5VlGbhDFvWh1iXq0i5XjBm7St/jXJ0ua5VsBqdq22gN6NFJrTOS+y7xA
   8NU17CB8453ubB3HQkb3DImqE6+ZhqFORT3W9ccrHipfP+jZ63494J/6k
   z874yI/7dzOCQy9fff61JbMIIVa08OnBx5T9rBfktDw5HtdO1rOb3Z7y4
   sJabcFFyLHuJ7gMjD+nLbz3HI/awFfBM/luBiL+3zMzs4sMVTuiGdtNt0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="303977913"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="303977913"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 16:39:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="872527640"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="872527640"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.171.186])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 16:39:07 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [RFC 1/3] libcxl: add interfaces for GET_POISON_LIST mailbox commands
Date:   Thu, 13 Oct 2022 16:39:01 -0700
Message-Id: <2b277ebcb8dff698a5d1beddeae525ff7e30aba6.1665699750.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665699750.git.alison.schofield@intel.com>
References: <cover.1665699750.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices maintain a list of locations that are poisoned or result
in poison if the addresses are accessed by the host.

Per the spec (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
list as a set of  Media Error Records that include the source of the
error, the starting device physical address and length.

Trigger the retrieval of the poison list by writing to the device
sysfs attribute: trigger_poison_list.

The retrieval is offered by memdev or by region:
int cxl_memdev_trigger_poison_list(struct cxl_memdev *memdev);
int cxl_region_trigger_poison_list(struct cxl_region *region);

This interface only triggers the retrieval of the poison list
from the devices. Users need to use the kernel trace event
'cxl_poison' to collect and view the error records.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/lib/libcxl.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  6 ++++++
 cxl/libcxl.h       |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e8c5d4444dd0..a99ac154b7d2 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1331,6 +1331,46 @@ CXL_EXPORT int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev)
 	return 0;
 }
 
+CXL_EXPORT int cxl_memdev_trigger_poison_list(struct cxl_memdev *memdev)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	char *path = memdev->dev_buf;
+	int len = memdev->buf_len, rc;
+
+	if (snprintf(path, len, "%s/trigger_poison_list", memdev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small\n",
+		    cxl_memdev_get_devname(memdev));
+		return -ENXIO;
+	}
+	rc = sysfs_write_attr(ctx, path, "1\n");
+	if (rc < 0) {
+		fprintf(stderr, "%s: Failed write sysfs attr trigger_poison_list\n",
+			cxl_memdev_get_devname(memdev));
+		return rc;
+	}
+	return 0;
+}
+
+CXL_EXPORT int cxl_region_trigger_poison_list(struct cxl_region *region)
+{
+	struct cxl_ctx *ctx = cxl_region_get_ctx(region);
+	char *path = region->dev_buf;
+	int len = region->buf_len, rc;
+
+	if (snprintf(path, len, "%s/trigger_poison_list", region->dev_path) >= len) {
+		err(ctx, "%s: buffer too small\n",
+		    cxl_region_get_devname(region));
+		return -ENXIO;
+	}
+	rc = sysfs_write_attr(ctx, path, "1\n");
+	if (rc < 0) {
+		fprintf(stderr, "%s: Failed write sysfs attr trigger_poison_list\n",
+			cxl_region_get_devname(region));
+		return rc;
+	}
+	return 0;
+}
+
 CXL_EXPORT int cxl_memdev_enable(struct cxl_memdev *memdev)
 {
 	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 8bb91e05638b..ecf98e6c7af2 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -217,3 +217,9 @@ global:
 	cxl_decoder_get_max_available_extent;
 	cxl_decoder_get_region;
 } LIBCXL_2;
+
+LIBCXL_4 {
+global:
+	cxl_memdev_trigger_poison_list;
+	cxl_region_trigger_poison_list;
+} LIBCXL_3;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 9fe4e99263dd..5ebdf0879325 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -375,6 +375,8 @@ enum cxl_setpartition_mode {
 
 int cxl_cmd_partition_set_mode(struct cxl_cmd *cmd,
 		enum cxl_setpartition_mode mode);
+int cxl_memdev_trigger_poison_list(struct cxl_memdev *memdev);
+int cxl_region_trigger_poison_list(struct cxl_region *region);
 
 #ifdef __cplusplus
 } /* extern "C" */
-- 
2.37.3

