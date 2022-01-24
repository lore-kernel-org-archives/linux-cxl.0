Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16B2C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbiAXAws (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:11532 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAws (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985568; x=1674521568;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zWYipVByTuY3zBAnr0pn5fQsJ62AcQBWrPkSpJwd+6I=;
  b=lWAP6FD2bSVkal1lMg7mw9rnydIP+TnK/x601VfjlIxZynFh1R59WX4J
   GEvujwY3OnXrs6hw8yCuUVUXQMYo4BrwbGEEbobKE5F/n1DBrPlk9WCvT
   WqemmD6/DaIN+WUsx/+Y+Hpx9d/ENn8caA3kS55ScN7B+FqLTRlGHyUp+
   TuBf171xR+tD9s4v5dxLSU7ulGaq0MRlJ+o6AES5yCOr431uzqPsyIGQq
   jE4k71K9Lvn8d2iP48TY37ELA2ThNiAYrrya6ofhPlF8LKCZyyT3mOXRC
   aFe9nG3Gaj9rA+EtUf1QBuQHHR2TqsGYLk/VtbGWzujGlgedF0XUGIY1G
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245716854"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245716854"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="673456353"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:47 -0800
Subject: [ndctl PATCH 11/37] cxl/lib: Rename nvdimm bridge to pmem
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:47 -0800
Message-ID: <164298556712.3021641.15612755067301105130.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The kernel has 2 object classes for connecting CXL to NVDIMM. There is an
'nvdimm-bridge' object (one per root CXL port) that represents a CXL NVDIMM
Bus, and there are 'pmem' object that represent CXL NVDIMM DIMM devices.
The object that the library is currently calling an nvdimm-bridge is
actually the 'pmem' object. Rename accordingly.

The exported function cxl_memdev_nvdimm_bridge_active() is not renamed, but
since it is a cxl_memdev operation and 'struct cxl_pmem' is an
implementation detail it is fine as is.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/lib/libcxl.c  |   56 +++++++++++++++++++++++++++--------------------------
 cxl/lib/private.h |    4 ++--
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 8d3cf8092c8b..9839f26f9507 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -45,11 +45,11 @@ struct cxl_ctx {
 	void *private_data;
 };
 
-static void free_bridge(struct cxl_nvdimm_bridge *bridge)
+static void free_pmem(struct cxl_pmem *pmem)
 {
-	free(bridge->dev_buf);
-	free(bridge->dev_path);
-	free(bridge);
+	free(pmem->dev_buf);
+	free(pmem->dev_path);
+	free(pmem);
 }
 
 static void free_memdev(struct cxl_memdev *memdev, struct list_head *head)
@@ -57,7 +57,7 @@ static void free_memdev(struct cxl_memdev *memdev, struct list_head *head)
 	if (head)
 		list_del_from(head, &memdev->list);
 	kmod_module_unref(memdev->module);
-	free_bridge(memdev->bridge);
+	free_pmem(memdev->pmem);
 	free(memdev->firmware_version);
 	free(memdev->dev_buf);
 	free(memdev->dev_path);
@@ -213,36 +213,36 @@ CXL_EXPORT void cxl_set_log_priority(struct cxl_ctx *ctx, int priority)
 	ctx->ctx.log_priority = priority;
 }
 
-static void *add_cxl_bridge(void *parent, int id, const char *br_base)
+static void *add_cxl_pmem(void *parent, int id, const char *br_base)
 {
 	const char *devname = devpath_to_devname(br_base);
 	struct cxl_memdev *memdev = parent;
 	struct cxl_ctx *ctx = memdev->ctx;
-	struct cxl_nvdimm_bridge *bridge;
+	struct cxl_pmem *pmem;
 
-	dbg(ctx, "%s: bridge_base: \'%s\'\n", devname, br_base);
+	dbg(ctx, "%s: pmem_base: \'%s\'\n", devname, br_base);
 
-	bridge = calloc(1, sizeof(*bridge));
-	if (!bridge)
+	pmem = calloc(1, sizeof(*pmem));
+	if (!pmem)
 		goto err_dev;
-	bridge->id = id;
+	pmem->id = id;
 
-	bridge->dev_path = strdup(br_base);
-	if (!bridge->dev_path)
+	pmem->dev_path = strdup(br_base);
+	if (!pmem->dev_path)
 		goto err_read;
 
-	bridge->dev_buf = calloc(1, strlen(br_base) + 50);
-	if (!bridge->dev_buf)
+	pmem->dev_buf = calloc(1, strlen(br_base) + 50);
+	if (!pmem->dev_buf)
 		goto err_read;
-	bridge->buf_len = strlen(br_base) + 50;
+	pmem->buf_len = strlen(br_base) + 50;
 
-	memdev->bridge = bridge;
-	return bridge;
+	memdev->pmem = pmem;
+	return pmem;
 
  err_read:
-	free(bridge->dev_buf);
-	free(bridge->dev_path);
-	free(bridge);
+	free(pmem->dev_buf);
+	free(pmem->dev_path);
+	free(pmem);
  err_dev:
 	return NULL;
 }
@@ -319,7 +319,7 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 		goto err_read;
 	memdev->buf_len = strlen(cxlmem_base) + 50;
 
-	sysfs_device_parse(ctx, cxlmem_base, "pmem", memdev, add_cxl_bridge);
+	sysfs_device_parse(ctx, cxlmem_base, "pmem", memdev, add_cxl_pmem);
 
 	cxl_memdev_foreach(ctx, memdev_dup)
 		if (memdev_dup->id == memdev->id) {
@@ -430,18 +430,18 @@ static int is_enabled(const char *drvpath)
 CXL_EXPORT int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev)
 {
 	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
-	struct cxl_nvdimm_bridge *bridge = memdev->bridge;
+	struct cxl_pmem *pmem = memdev->pmem;
 	char *path;
 	int len;
 
-	if (!bridge)
+	if (!pmem)
 		return 0;
 
-	path = bridge->dev_buf;
-	len = bridge->buf_len;
+	path = pmem->dev_buf;
+	len = pmem->buf_len;
 
-	if (snprintf(path, len, "%s/driver", bridge->dev_path) >= len) {
-		err(ctx, "%s: nvdimm bridge buffer too small!\n",
+	if (snprintf(path, len, "%s/driver", pmem->dev_path) >= len) {
+		err(ctx, "%s: nvdimm pmem buffer too small!\n",
 				cxl_memdev_get_devname(memdev));
 		return 0;
 	}
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 28f7e16dbd04..7c81e24a6f79 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -10,7 +10,7 @@
 
 #define CXL_EXPORT __attribute__ ((visibility("default")))
 
-struct cxl_nvdimm_bridge {
+struct cxl_pmem {
 	int id;
 	void *dev_buf;
 	size_t buf_len;
@@ -30,7 +30,7 @@ struct cxl_memdev {
 	int payload_max;
 	size_t lsa_size;
 	struct kmod_module *module;
-	struct cxl_nvdimm_bridge *bridge;
+	struct cxl_pmem *pmem;
 	unsigned long long serial;
 };
 

