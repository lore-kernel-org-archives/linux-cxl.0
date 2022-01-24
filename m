Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BAAC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiAXAyV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:54:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:3972 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240670AbiAXAyR (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985657; x=1674521657;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vHekN5lP0FydPCqtjPLuBuMRkc4Fj1Bhsd2qWnFJ8v4=;
  b=m3tdmZuXbvo7zj6bhu70Ql3ZUZgUOhb96NK2J5FH6azHdtwAkRGVCgXi
   C5qaBEkqwmsA+OE980i65tpMyKnQvwKorvM3jkgZ4YQrfmCur4ZLJ78ep
   WPVE2eLEvDmPeeelPOxV+6SQjzrObKQqqQqffzbFJCJdIY6dd6bjWKppm
   afvMN4Vwiph1IjHmZbtKy7a2ornPq+H9RwG9MTUmD/PYyduhMx3kgahrV
   xvHQcWKwYqIPHC2s9LtsuQcTAhgXKf/oTEk3NVzLrvV6PYghkWLsPSCW5
   EGy8aD0bnt+LXMrY08va5bhcLx3kzYF4q0Fz+ziH6NYDNsj18UxAEBxbU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="225916746"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="225916746"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596630819"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:17 -0800
Subject: [ndctl PATCH 28/37] util: Implement common bind/unbind helpers
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:54:17 -0800
Message-ID: <164298565707.3021641.7763459936156744907.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Refactor ndctl_{bind,unbind}() into util_{bind,unbind}() for libcxl to
reuse.

daxctl can not join the party for now as it needs to play games with
'new_id'.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/lib/libndctl.c |  103 ++++++--------------------------------------------
 util/sysfs.c         |   76 +++++++++++++++++++++++++++++++++++++
 util/sysfs.h         |    8 ++++
 3 files changed, 96 insertions(+), 91 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 1374ad9e504f..98d184ba1bf8 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1665,10 +1665,6 @@ static enum ndctl_fwa_result fwa_result_to_result(const char *result)
 	return NDCTL_FWA_RESULT_INVALID;
 }
 
-static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
-		const char *devname);
-static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
-
 static int populate_dimm_attributes(struct ndctl_dimm *dimm,
 				    const char *dimm_base,
 				    const char *bus_prefix)
@@ -2305,7 +2301,7 @@ NDCTL_EXPORT int ndctl_dimm_disable(struct ndctl_dimm *dimm)
 	if (!ndctl_dimm_is_enabled(dimm))
 		return 0;
 
-	ndctl_unbind(ctx, dimm->dimm_path);
+	util_unbind(dimm->dimm_path, ctx);
 
 	if (ndctl_dimm_is_enabled(dimm)) {
 		err(ctx, "%s: failed to disable\n", devname);
@@ -2324,7 +2320,7 @@ NDCTL_EXPORT int ndctl_dimm_enable(struct ndctl_dimm *dimm)
 	if (ndctl_dimm_is_enabled(dimm))
 		return 0;
 
-	ndctl_bind(ctx, dimm->module, devname);
+	util_bind(devname, dimm->module, "nd", ctx);
 
 	if (!ndctl_dimm_is_enabled(dimm)) {
 		err(ctx, "%s: failed to enable\n", devname);
@@ -3573,7 +3569,7 @@ NDCTL_EXPORT int ndctl_region_enable(struct ndctl_region *region)
 	if (ndctl_region_is_enabled(region))
 		return 0;
 
-	ndctl_bind(ctx, region->module, devname);
+	util_bind(devname, region->module, "nd", ctx);
 
 	if (!ndctl_region_is_enabled(region)) {
 		err(ctx, "%s: failed to enable\n", devname);
@@ -3610,7 +3606,7 @@ static int ndctl_region_disable(struct ndctl_region *region, int cleanup)
 	if (!ndctl_region_is_enabled(region))
 		return 0;
 
-	ndctl_unbind(ctx, region->region_path);
+	util_unbind(region->region_path, ctx);
 
 	if (ndctl_region_is_enabled(region)) {
 		err(ctx, "%s: failed to disable\n", devname);
@@ -4373,81 +4369,6 @@ NDCTL_EXPORT struct badblock *ndctl_namespace_get_first_badblock(
 	return badblocks_iter_first(&ndns->bb_iter, ctx, path);
 }
 
-static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
-		const char *devname)
-{
-	DIR *dir;
-	int rc = 0;
-	char path[200];
-	struct dirent *de;
-	const int len = sizeof(path);
-
-	if (!devname) {
-		err(ctx, "missing devname\n");
-		return -EINVAL;
-	}
-
-	if (module) {
-		rc = kmod_module_probe_insert_module(module,
-				KMOD_PROBE_APPLY_BLACKLIST, NULL, NULL, NULL,
-				NULL);
-		if (rc < 0) {
-			err(ctx, "%s: insert failure: %d\n", __func__, rc);
-			return rc;
-		}
-	}
-
-	if (snprintf(path, len, "/sys/bus/nd/drivers") >= len) {
-		err(ctx, "%s: buffer too small!\n", devname);
-		return -ENXIO;
-	}
-
-	dir = opendir(path);
-	if (!dir) {
-		err(ctx, "%s: opendir(\"%s\") failed\n", devname, path);
-		return -ENXIO;
-	}
-
-	while ((de = readdir(dir)) != NULL) {
-		char *drv_path;
-
-		if (de->d_ino == 0)
-			continue;
-		if (de->d_name[0] == '.')
-			continue;
-		if (asprintf(&drv_path, "%s/%s/bind", path, de->d_name) < 0) {
-			err(ctx, "%s: path allocation failure\n", devname);
-			continue;
-		}
-
-		rc = sysfs_write_attr_quiet(ctx, drv_path, devname);
-		free(drv_path);
-		if (rc == 0)
-			break;
-	}
-	closedir(dir);
-
-	if (rc) {
-		dbg(ctx, "%s: bind failed\n", devname);
-		return -ENXIO;
-	}
-	return 0;
-}
-
-static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath)
-{
-	const char *devname = devpath_to_devname(devpath);
-	char path[200];
-	const int len = sizeof(path);
-
-	if (snprintf(path, len, "%s/driver/unbind", devpath) >= len) {
-		err(ctx, "%s: buffer too small!\n", devname);
-		return -ENXIO;
-	}
-
-	return sysfs_write_attr(ctx, path, devname);
-}
-
 static void *add_btt(void *parent, int id, const char *btt_base);
 static void *add_pfn(void *parent, int id, const char *pfn_base);
 static void *add_dax(void *parent, int id, const char *dax_base);
@@ -4533,7 +4454,7 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct ndctl_namespace *ndns)
 	if (ndctl_namespace_is_enabled(ndns))
 		return 0;
 
-	rc = ndctl_bind(ctx, ndns->module, devname);
+	rc = util_bind(devname, ndns->module, "nd", ctx);
 
 	/*
 	 * Rescan now as successfully enabling a namespace device leads
@@ -4581,7 +4502,7 @@ NDCTL_EXPORT int ndctl_namespace_disable(struct ndctl_namespace *ndns)
 	if (!ndctl_namespace_is_enabled(ndns))
 		return 0;
 
-	ndctl_unbind(ctx, ndns->ndns_path);
+	util_unbind(ndns->ndns_path, ctx);
 
 	if (ndctl_namespace_is_enabled(ndns)) {
 		err(ctx, "%s: failed to disable\n", devname);
@@ -5420,7 +5341,7 @@ NDCTL_EXPORT int ndctl_btt_enable(struct ndctl_btt *btt)
 	if (ndctl_btt_is_enabled(btt))
 		return 0;
 
-	ndctl_bind(ctx, btt->module, devname);
+	util_bind(devname, btt->module, "nd", ctx);
 
 	if (!ndctl_btt_is_enabled(btt)) {
 		err(ctx, "%s: failed to enable\n", devname);
@@ -5457,7 +5378,7 @@ NDCTL_EXPORT int ndctl_btt_delete(struct ndctl_btt *btt)
 		return 0;
 	}
 
-	ndctl_unbind(ctx, btt->btt_path);
+	util_unbind(btt->btt_path, ctx);
 
 	rc = ndctl_btt_set_namespace(btt, NULL);
 	if (rc) {
@@ -5908,7 +5829,7 @@ NDCTL_EXPORT int ndctl_pfn_enable(struct ndctl_pfn *pfn)
 	if (ndctl_pfn_is_enabled(pfn))
 		return 0;
 
-	ndctl_bind(ctx, pfn->module, devname);
+	util_bind(devname, pfn->module, "nd", ctx);
 
 	if (!ndctl_pfn_is_enabled(pfn)) {
 		err(ctx, "%s: failed to enable\n", devname);
@@ -5945,7 +5866,7 @@ NDCTL_EXPORT int ndctl_pfn_delete(struct ndctl_pfn *pfn)
 		return 0;
 	}
 
-	ndctl_unbind(ctx, pfn->pfn_path);
+	util_unbind(pfn->pfn_path, ctx);
 
 	rc = ndctl_pfn_set_namespace(pfn, NULL);
 	if (rc) {
@@ -6101,7 +6022,7 @@ NDCTL_EXPORT int ndctl_dax_enable(struct ndctl_dax *dax)
 	if (ndctl_dax_is_enabled(dax))
 		return 0;
 
-	ndctl_bind(ctx, pfn->module, devname);
+	util_bind(devname, pfn->module, "nd", ctx);
 
 	if (!ndctl_dax_is_enabled(dax)) {
 		err(ctx, "%s: failed to enable\n", devname);
@@ -6132,7 +6053,7 @@ NDCTL_EXPORT int ndctl_dax_delete(struct ndctl_dax *dax)
 		return 0;
 	}
 
-	ndctl_unbind(ctx, pfn->pfn_path);
+	util_unbind(pfn->pfn_path, ctx);
 
 	rc = ndctl_dax_set_namespace(dax, NULL);
 	if (rc) {
diff --git a/util/sysfs.c b/util/sysfs.c
index 23330cb29002..968683b19f4e 100644
--- a/util/sysfs.c
+++ b/util/sysfs.c
@@ -145,3 +145,79 @@ struct kmod_module *__util_modalias_to_module(struct kmod_ctx *kmod_ctx,
 
 	return mod;
 }
+
+int __util_bind(const char *devname, struct kmod_module *module,
+		const char *bus, struct log_ctx *ctx)
+{
+	DIR *dir;
+	int rc = 0;
+	char path[200];
+	struct dirent *de;
+	const int len = sizeof(path);
+
+	if (!devname) {
+		log_err(ctx, "missing devname\n");
+		return -EINVAL;
+	}
+
+	if (module) {
+		rc = kmod_module_probe_insert_module(module,
+						     KMOD_PROBE_APPLY_BLACKLIST,
+						     NULL, NULL, NULL, NULL);
+		if (rc < 0) {
+			log_err(ctx, "%s: insert failure: %d\n", __func__, rc);
+			return rc;
+		}
+	}
+
+	if (snprintf(path, len, "/sys/bus/%s/drivers", bus) >= len) {
+		log_err(ctx, "%s: buffer too small!\n", devname);
+		return -ENXIO;
+	}
+
+	dir = opendir(path);
+	if (!dir) {
+		log_err(ctx, "%s: opendir(\"%s\") failed\n", devname, path);
+		return -ENXIO;
+	}
+
+	while ((de = readdir(dir)) != NULL) {
+		char *drv_path;
+
+		if (de->d_ino == 0)
+			continue;
+		if (de->d_name[0] == '.')
+			continue;
+
+		if (asprintf(&drv_path, "%s/%s/bind", path, de->d_name) < 0) {
+			log_err(ctx, "%s: path allocation failure\n", devname);
+			continue;
+		}
+
+		rc = __sysfs_write_attr_quiet(ctx, drv_path, devname);
+		free(drv_path);
+		if (rc == 0)
+			break;
+	}
+	closedir(dir);
+
+	if (rc) {
+		log_dbg(ctx, "%s: bind failed\n", devname);
+		return -ENXIO;
+	}
+	return 0;
+}
+
+int __util_unbind(const char *devpath, struct log_ctx *ctx)
+{
+	const char *devname = devpath_to_devname(devpath);
+	char path[200];
+	const int len = sizeof(path);
+
+	if (snprintf(path, len, "%s/driver/unbind", devpath) >= len) {
+		log_err(ctx, "%s: buffer too small!\n", devname);
+		return -ENXIO;
+	}
+
+	return __sysfs_write_attr(ctx, path, devname);
+}
diff --git a/util/sysfs.h b/util/sysfs.h
index bdee4f5c291d..4c95c70558ba 100644
--- a/util/sysfs.h
+++ b/util/sysfs.h
@@ -35,4 +35,12 @@ struct kmod_module *__util_modalias_to_module(struct kmod_ctx *kmod_ctx,
 					      struct log_ctx *log);
 #define util_modalias_to_module(ctx, buf)                                      \
 	__util_modalias_to_module((ctx)->kmod_ctx, buf, &(ctx)->ctx)
+
+int __util_bind(const char *devname, struct kmod_module *module, const char *bus,
+	      struct log_ctx *ctx);
+#define util_bind(n, m, b, c) __util_bind(n, m, b, &(c)->ctx)
+
+int __util_unbind(const char *devpath, struct log_ctx *ctx);
+#define util_unbind(p, c) __util_unbind(p, &(c)->ctx)
+
 #endif /* __UTIL_SYSFS_H__ */

