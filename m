Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2168C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbiAXAxO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:53:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:61605 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240656AbiAXAxO (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985594; x=1674521594;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f4TsbY0arBy9TgsxhRBAhOeC2o6qnZZlY2sCaYSITdo=;
  b=W2wKOrV9jlyP3sCsxYUK0KgN6bsbX5qBYbqrWzSg3Ukng6Sl5b45Afxo
   JhALvPn7xd5LY/Ln1HYSZPESjqH21y3PKJUr55Wdx6/TW4glGaqd1rd24
   /jTp7IrV99j1VSlmJjdcqLrASHXwaBmV9FN6495J8eW1zZNpozYcS7iYz
   iEz2/7sWFeI9LL6tVLc0YduIyIB1Vr3AIsIouA/e852/DMhBx6+6gqHVA
   0CzkuitHr9Ktt/n9n++kXcRsN1lPXWfWPeLprXCjUauqihXA9Q8hV9IA5
   WdCGhpxBebRmvwkiEDyVYbj26W/iCi73P3UOYdj1v7iCB7oi0QVkjO+qM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233293971"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233293971"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695243417"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:13 -0800
Subject: [ndctl PATCH 16/37] util/sysfs: Uplevel modalias lookup helper to
 util/
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:53:13 -0800
Message-ID: <164298559346.3021641.11059026790676662837.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The to_module() helper looks up modules relative to a modalias. Uplevel
this to share with libcxl.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/lib/libndctl.c |   33 +++++----------------------------
 util/sysfs.c         |   27 +++++++++++++++++++++++++++
 util/sysfs.h         |    8 ++++++++
 3 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 47a234ccc8ce..1374ad9e504f 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1668,7 +1668,6 @@ static enum ndctl_fwa_result fwa_result_to_result(const char *result)
 static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
 		const char *devname);
 static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
-static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
 
 static int populate_dimm_attributes(struct ndctl_dimm *dimm,
 				    const char *dimm_base,
@@ -1878,7 +1877,7 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	sprintf(path, "%s/modalias", dimm_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
-	dimm->module = to_module(ctx, buf);
+	dimm->module = util_modalias_to_module(ctx, buf);
 
 	dimm->handle = -1;
 	dimm->phys_id = -1;
@@ -2597,7 +2596,7 @@ static void *add_region(void *parent, int id, const char *region_base)
 	sprintf(path, "%s/modalias", region_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
-	region->module = to_module(ctx, buf);
+	region->module = util_modalias_to_module(ctx, buf);
 
 	sprintf(path, "%s/numa_node", region_base);
 	if ((rc = sysfs_read_attr(ctx, path, buf)) == 0)
@@ -3885,28 +3884,6 @@ NDCTL_EXPORT struct ndctl_ctx *ndctl_mapping_get_ctx(
 	return ndctl_mapping_get_bus(mapping)->ctx;
 }
 
-static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias)
-{
-	struct kmod_list *list = NULL;
-	struct kmod_module *mod;
-	int rc;
-
-	if (!ctx->kmod_ctx)
-		return NULL;
-
-	rc = kmod_module_new_from_lookup(ctx->kmod_ctx, alias, &list);
-	if (rc < 0 || !list) {
-		dbg(ctx, "failed to find module for alias: %s %d list: %s\n",
-				alias, rc, list ? "populated" : "empty");
-		return NULL;
-	}
-	mod = kmod_module_get_module(list);
-	dbg(ctx, "alias: %s module: %s\n", alias, kmod_module_get_name(mod));
-	kmod_module_unref_list(list);
-
-	return mod;
-}
-
 static char *get_block_device(struct ndctl_ctx *ctx, const char *block_path)
 {
 	char *bdev_name = NULL;
@@ -4069,7 +4046,7 @@ static void *add_namespace(void *parent, int id, const char *ndns_base)
 	sprintf(path, "%s/modalias", ndns_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
-	ndns->module = to_module(ctx, buf);
+	ndns->module = util_modalias_to_module(ctx, buf);
 
 	ndctl_namespace_foreach(region, ndns_dup)
 		if (ndns_dup->id == ndns->id) {
@@ -5182,7 +5159,7 @@ static void *add_btt(void *parent, int id, const char *btt_base)
 	sprintf(path, "%s/modalias", btt_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
-	btt->module = to_module(ctx, buf);
+	btt->module = util_modalias_to_module(ctx, buf);
 
 	sprintf(path, "%s/uuid", btt_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
@@ -5533,7 +5510,7 @@ static void *__add_pfn(struct ndctl_pfn *pfn, const char *pfn_base)
 	sprintf(path, "%s/modalias", pfn_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
-	pfn->module = to_module(ctx, buf);
+	pfn->module = util_modalias_to_module(ctx, buf);
 
 	sprintf(path, "%s/uuid", pfn_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
diff --git a/util/sysfs.c b/util/sysfs.c
index cfbab7da74e9..23330cb29002 100644
--- a/util/sysfs.c
+++ b/util/sysfs.c
@@ -10,6 +10,7 @@
 #include <ctype.h>
 #include <fcntl.h>
 #include <dirent.h>
+#include <libkmod.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/ioctl.h>
@@ -118,3 +119,29 @@ int __sysfs_device_parse(struct log_ctx *ctx, const char *base_path,
 
 	return add_errors;
 }
+
+struct kmod_module *__util_modalias_to_module(struct kmod_ctx *kmod_ctx,
+					      const char *alias,
+					      struct log_ctx *log)
+{
+	struct kmod_list *list = NULL;
+	struct kmod_module *mod;
+	int rc;
+
+	if (!kmod_ctx)
+		return NULL;
+
+	rc = kmod_module_new_from_lookup(kmod_ctx, alias, &list);
+	if (rc < 0 || !list) {
+		log_dbg(log,
+			"failed to find module for alias: %s %d list: %s\n",
+			alias, rc, list ? "populated" : "empty");
+		return NULL;
+	}
+	mod = kmod_module_get_module(list);
+	log_dbg(log, "alias: %s module: %s\n", alias,
+		kmod_module_get_name(mod));
+	kmod_module_unref_list(list);
+
+	return mod;
+}
diff --git a/util/sysfs.h b/util/sysfs.h
index 6485a73d8ed7..bdee4f5c291d 100644
--- a/util/sysfs.h
+++ b/util/sysfs.h
@@ -27,4 +27,12 @@ static inline const char *devpath_to_devname(const char *devpath)
 {
 	return strrchr(devpath, '/') + 1;
 }
+
+struct kmod_ctx;
+struct kmod_module;
+struct kmod_module *__util_modalias_to_module(struct kmod_ctx *kmod_ctx,
+					      const char *alias,
+					      struct log_ctx *log);
+#define util_modalias_to_module(ctx, buf)                                      \
+	__util_modalias_to_module((ctx)->kmod_ctx, buf, &(ctx)->ctx)
 #endif /* __UTIL_SYSFS_H__ */

