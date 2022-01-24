Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3841AC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiAXAwA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:25163 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAwA (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985520; x=1674521520;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RVmRRIwN+BtXP+wCKLSjlwKnd8pbAb9StJz+SREWbCA=;
  b=Uieen3y5WUngvH72b8o9t9EMLby5x/6441C+RFHoOIoqI5jJTN8/7N+6
   AwuE1eNbCPfjMI8vv52TaGvQ8a+y5U0FNOl7lItn0AxSGe/eT2DGwqri0
   qXWVCPrp2QjH8fpf/p3FTRW/Bzm3cweSjani03dS8z4yse8S9iHTWxfL9
   0d7su+fOx6dVhQg45l6mBoHb+JaDTRvYlaB2my1r8tuWyLV5BWG6wxYsP
   yM73lJ1Jno3TxkogxRM4AM0ic4XfWrpOAKwLIsnkBJ7i7yY9NhBE3owHU
   wsS2cUfnAP1c6n6tJo2uERpz3hTfucyQHYoLmxSXMsFwX4B9wADuE0Aje
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226609534"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226609534"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596630560"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:00 -0800
Subject: [ndctl PATCH 02/37] ndctl: Rename util_filter to ndctl_filter
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:00 -0800
Message-ID: <164298552014.3021641.16369576632179722489.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for introducing a cxl_filter_walk() implementation rename
the current filter_walk infrastructure with an ndctl_ prefix.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/filter.c         |    4 ++--
 ndctl/filter.h         |   21 +++++++++++----------
 ndctl/list.c           |   14 +++++++-------
 ndctl/monitor.c        |   12 ++++++------
 test/list-smart-dimm.c |   12 ++++++------
 5 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/ndctl/filter.c b/ndctl/filter.c
index 64d00ce87dd5..5b810dc5926d 100644
--- a/ndctl/filter.c
+++ b/ndctl/filter.c
@@ -338,8 +338,8 @@ const char *util_nsmode_name(enum ndctl_namespace_mode mode)
 	return modes[mode];
 }
 
-int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
-		struct util_filter_params *param)
+int ndctl_filter_walk(struct ndctl_ctx *ctx, struct ndctl_filter_ctx *fctx,
+		      struct ndctl_filter_params *param)
 {
 	struct ndctl_bus *bus;
 	unsigned int type = 0;
diff --git a/ndctl/filter.h b/ndctl/filter.h
index 9800cc230865..f6fe325acdc1 100644
--- a/ndctl/filter.h
+++ b/ndctl/filter.h
@@ -31,7 +31,7 @@ const char *util_nsmode_name(enum ndctl_namespace_mode mode);
 
 struct json_object;
 
-/* json object hierarchy for the util_filter_walk() performed by cmd_list() */
+/* json object hierarchy for the ndctl_filter_walk() performed by cmd_list() */
 struct list_filter_arg {
 	struct json_object *jnamespaces;
 	struct json_object *jregions;
@@ -50,19 +50,20 @@ struct monitor_filter_arg {
 };
 
 /*
- * struct util_filter_ctx - control and callbacks for util_filter_walk()
+ * struct ndctl_filter_ctx - control and callbacks for ndctl_filter_walk()
  * ->filter_bus() and ->filter_region() return bool because the
  * child-object filter routines can not be called if the parent context
  * is not established. ->filter_dimm() and ->filter_namespace() are leaf
  * objects, so no child dependencies to check.
  */
-struct util_filter_ctx {
-	bool (*filter_bus)(struct ndctl_bus *bus, struct util_filter_ctx *ctx);
-	void (*filter_dimm)(struct ndctl_dimm *dimm, struct util_filter_ctx *ctx);
+struct ndctl_filter_ctx {
+	bool (*filter_bus)(struct ndctl_bus *bus, struct ndctl_filter_ctx *ctx);
+	void (*filter_dimm)(struct ndctl_dimm *dimm,
+			    struct ndctl_filter_ctx *ctx);
 	bool (*filter_region)(struct ndctl_region *region,
-			struct util_filter_ctx *ctx);
+			      struct ndctl_filter_ctx *ctx);
 	void (*filter_namespace)(struct ndctl_namespace *ndns,
-			struct util_filter_ctx *ctx);
+				 struct ndctl_filter_ctx *ctx);
 	union {
 		void *arg;
 		struct list_filter_arg *list;
@@ -70,7 +71,7 @@ struct util_filter_ctx {
 	};
 };
 
-struct util_filter_params {
+struct ndctl_filter_params {
 	const char *bus;
 	const char *region;
 	const char *type;
@@ -81,6 +82,6 @@ struct util_filter_params {
 };
 
 struct ndctl_ctx;
-int util_filter_walk(struct ndctl_ctx *ctx, struct util_filter_ctx *fctx,
-		struct util_filter_params *param);
+int ndctl_filter_walk(struct ndctl_ctx *ctx, struct ndctl_filter_ctx *fctx,
+		      struct ndctl_filter_params *param);
 #endif /* _NDCTL_UTIL_FILTER_H_ */
diff --git a/ndctl/list.c b/ndctl/list.c
index 869edde4fc65..d89801946a0d 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -55,7 +55,7 @@ static unsigned long listopts_to_flags(void)
 	return flags;
 }
 
-static struct util_filter_params param;
+static struct ndctl_filter_params param;
 
 static int did_fail;
 
@@ -234,7 +234,7 @@ static struct json_object *region_to_json(struct ndctl_region *region,
 }
 
 static void filter_namespace(struct ndctl_namespace *ndns,
-		struct util_filter_ctx *ctx)
+			     struct ndctl_filter_ctx *ctx)
 {
 	struct json_object *jndns;
 	struct list_filter_arg *lfa = ctx->list;
@@ -272,7 +272,7 @@ static void filter_namespace(struct ndctl_namespace *ndns,
 }
 
 static bool filter_region(struct ndctl_region *region,
-		struct util_filter_ctx *ctx)
+			  struct ndctl_filter_ctx *ctx)
 {
 	struct list_filter_arg *lfa = ctx->list;
 	struct json_object *jbus = lfa->jbus;
@@ -318,7 +318,7 @@ static bool filter_region(struct ndctl_region *region,
 	return true;
 }
 
-static void filter_dimm(struct ndctl_dimm *dimm, struct util_filter_ctx *ctx)
+static void filter_dimm(struct ndctl_dimm *dimm, struct ndctl_filter_ctx *ctx)
 {
 	struct list_filter_arg *lfa = ctx->list;
 	struct json_object *jdimm;
@@ -367,7 +367,7 @@ static void filter_dimm(struct ndctl_dimm *dimm, struct util_filter_ctx *ctx)
 	json_object_array_add(lfa->jdimms, jdimm);
 }
 
-static bool filter_bus(struct ndctl_bus *bus, struct util_filter_ctx *ctx)
+static bool filter_bus(struct ndctl_bus *bus, struct ndctl_filter_ctx *ctx)
 {
 	struct list_filter_arg *lfa = ctx->list;
 
@@ -489,7 +489,7 @@ int cmd_list(int argc, const char **argv, struct ndctl_ctx *ctx)
 		NULL
 	};
 	bool lint = !!secure_getenv("NDCTL_LIST_LINT");
-	struct util_filter_ctx fctx = { 0 };
+	struct ndctl_filter_ctx fctx = { 0 };
 	struct list_filter_arg lfa = { 0 };
 	int i, rc;
 
@@ -544,7 +544,7 @@ int cmd_list(int argc, const char **argv, struct ndctl_ctx *ctx)
 	fctx.list = &lfa;
 	lfa.flags = listopts_to_flags();
 
-	rc = util_filter_walk(ctx, &fctx, &param);
+	rc = ndctl_filter_walk(ctx, &fctx, &param);
 	if (rc)
 		return rc;
 
diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index ae694c614593..3e6a42527088 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -49,7 +49,7 @@ struct monitor_dimm {
 	struct list_node list;
 };
 
-static struct util_filter_params param;
+static struct ndctl_filter_params param;
 
 static int did_fail;
 
@@ -264,12 +264,12 @@ out:
 }
 
 static bool filter_region(struct ndctl_region *region,
-		struct util_filter_ctx *fctx)
+			  struct ndctl_filter_ctx *fctx)
 {
 	return true;
 }
 
-static void filter_dimm(struct ndctl_dimm *dimm, struct util_filter_ctx *fctx)
+static void filter_dimm(struct ndctl_dimm *dimm, struct ndctl_filter_ctx *fctx)
 {
 	struct monitor_dimm *mdimm;
 	struct monitor_filter_arg *mfa = fctx->monitor;
@@ -317,7 +317,7 @@ static void filter_dimm(struct ndctl_dimm *dimm, struct util_filter_ctx *fctx)
 	return;
 }
 
-static bool filter_bus(struct ndctl_bus *bus, struct util_filter_ctx *fctx)
+static bool filter_bus(struct ndctl_bus *bus, struct ndctl_filter_ctx *fctx)
 {
 	return true;
 }
@@ -602,7 +602,7 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
 		CONF_END(),
 	};
 	const char *prefix = "./", *ndctl_configs;
-	struct util_filter_ctx fctx = { 0 };
+	struct ndctl_filter_ctx fctx = { 0 };
 	struct monitor_filter_arg mfa = { 0 };
 	int i, rc;
 
@@ -672,7 +672,7 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
 	mfa.maxfd_dimm = -1;
 	mfa.flags = 0;
 
-	rc = util_filter_walk(ctx, &fctx, &param);
+	rc = ndctl_filter_walk(ctx, &fctx, &param);
 	if (rc)
 		goto out;
 
diff --git a/test/list-smart-dimm.c b/test/list-smart-dimm.c
index 47b711e63670..f94277e8febd 100644
--- a/test/list-smart-dimm.c
+++ b/test/list-smart-dimm.c
@@ -11,7 +11,7 @@
 #include <ndctl/ndctl.h>
 #include <ndctl/json.h>
 
-struct util_filter_params param;
+struct ndctl_filter_params param;
 static int did_fail;
 static int jflag = JSON_C_TO_STRING_PRETTY;
 
@@ -23,12 +23,12 @@ do { \
 } while (0)
 
 static bool filter_region(struct ndctl_region *region,
-		struct util_filter_ctx *ctx)
+		struct ndctl_filter_ctx *ctx)
 {
 	return true;
 }
 
-static void filter_dimm(struct ndctl_dimm *dimm, struct util_filter_ctx *ctx)
+static void filter_dimm(struct ndctl_dimm *dimm, struct ndctl_filter_ctx *ctx)
 {
 	struct list_filter_arg *lfa = ctx->list;
 	struct json_object *jdimm;
@@ -57,7 +57,7 @@ static void filter_dimm(struct ndctl_dimm *dimm, struct util_filter_ctx *ctx)
 	json_object_array_add(lfa->jdimms, jdimm);
 }
 
-static bool filter_bus(struct ndctl_bus *bus, struct util_filter_ctx *ctx)
+static bool filter_bus(struct ndctl_bus *bus, struct ndctl_filter_ctx *ctx)
 {
 	return true;
 }
@@ -89,7 +89,7 @@ int main(int argc, const char *argv[])
 		"list-smart-dimm [<options>]",
 		NULL
 	};
-	struct util_filter_ctx fctx = { 0 };
+	struct ndctl_filter_ctx fctx = { 0 };
 	struct list_filter_arg lfa = { 0 };
 
 	rc = ndctl_new(&ctx);
@@ -108,7 +108,7 @@ int main(int argc, const char *argv[])
 	fctx.list = &lfa;
 	lfa.flags = 0;
 
-	rc = util_filter_walk(ctx, &fctx, &param);
+	rc = ndctl_filter_walk(ctx, &fctx, &param);
 	if (rc)
 		return rc;
 

