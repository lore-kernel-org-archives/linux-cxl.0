Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D760C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Nov 2022 03:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiKKDUP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Nov 2022 22:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiKKDUO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Nov 2022 22:20:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27864B9A2
        for <linux-cxl@vger.kernel.org>; Thu, 10 Nov 2022 19:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668136812; x=1699672812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2L3oHReSuQCpClXWNtrrvwtAMs5qrMUwLJZ+JgDDIRs=;
  b=mju0M6v1/M14HHevnyXAAFJlz1JmkIZ5Mng5b7v426tzyUHPQ0NA162L
   tgK4IQNex5PK+XuxxXvsGOwF0QbgtlAMSvwQyXz7rlvZJmxyzAin7Htba
   VnGPbU4N5lWevhOs+bUbwX815kAH/iv0o5mK1PnTVDunIuY/nS1Lk3IqA
   aFXAQD7u6TgLUjf2vF8KkHH1iA5EKNvr1uqrP99O6YMb8UtEfxIEWCpq+
   tfVwN1x5f69LBATYXSN5OgmD6Gg7I8VXszHIRKKs+Ix7MPtexydAQFlxh
   3gXIhFhisZsByPVl32ExYvbRyNDjPomoxpYRWzssXnzEfnuHSHg9ipXGu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397807330"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397807330"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:20:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="743129956"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="743129956"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.161.45])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:20:12 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 1/5] libcxl: add interfaces for GET_POISON_LIST mailbox commands
Date:   Thu, 10 Nov 2022 19:20:04 -0800
Message-Id: <73b2edf5ded979cb3164bcf2b76c4f300cdf2250.1668133294.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668133294.git.alison.schofield@intel.com>
References: <cover.1668133294.git.alison.schofield@intel.com>
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

Retrieval is offered by memdev or by region:
int cxl_memdev_trigger_poison_list(struct cxl_memdev *memdev);
int cxl_region_trigger_poison_list(struct cxl_region *region);

This interface triggers the retrieval of the poison list from the
devices and logs the error records as kernel trace events named
'cxl_poison'.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/lib/libcxl.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  6 ++++++
 cxl/libcxl.h       |  2 ++
 3 files changed, 52 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e8c5d4444dd0..1a8a8eb0ffcb 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1331,6 +1331,50 @@ CXL_EXPORT int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev)
 	return 0;
 }
 
+CXL_EXPORT int cxl_memdev_trigger_poison_list(struct cxl_memdev *memdev)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	char *path = memdev->dev_buf;
+	int len = memdev->buf_len, rc;
+
+	if (snprintf(path, len, "%s/trigger_poison_list", memdev->dev_path) >=
+	    len) {
+		err(ctx, "%s: buffer too small\n",
+		    cxl_memdev_get_devname(memdev));
+		return -ENXIO;
+	}
+	rc = sysfs_write_attr(ctx, path, "1\n");
+	if (rc < 0) {
+		fprintf(stderr,
+			"%s: Failed write sysfs attr trigger_poison_list\n",
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
+	if (snprintf(path, len, "%s/trigger_poison_list", region->dev_path) >=
+	    len) {
+		err(ctx, "%s: buffer too small\n",
+		    cxl_region_get_devname(region));
+		return -ENXIO;
+	}
+	rc = sysfs_write_attr(ctx, path, "1\n");
+	if (rc < 0) {
+		fprintf(stderr,
+			"%s: Failed write sysfs attr trigger_poison_list\n",
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

