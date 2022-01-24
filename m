Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F1C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbiAXAwf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:50209 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAwb (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985551; x=1674521551;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NF2XknFo78Bj2VyYzMjDGENQQPGTTQUgtgoGrzfXLiQ=;
  b=IZJZcRN1fQHXhZ8QTsm71j4EVk/aUT2a6OpgkdSNzm0O40bL5reiNWnI
   pCWfStAa56qFSmig8nnTFn0eI/0G7mjsfc3ei2Lk13EKzRoJFe5Kt8Jni
   lR/Lo67ZzBu66+p+5wpEU4zoUNq7YS4Pv82AOxfU26ut9MXWVYOMerYL5
   XVgLn6nadOx/IK7LvIFmaN9S/pGSgwytrbVb5A8OM8t4SvQVkTt9eJnN5
   uJgn+6ytOcl4/beEetimMaFTS+MbmBYS4H84yQF7lS/7fWM71VJDgoDMU
   lEfqyMjaRzFYWAOhW3sampcYTmiFRY+Uu74UUshxbjHuLheZ6eIj74oKI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243530535"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243530535"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695243342"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:31 -0800
Subject: [ndctl PATCH 08/37] cxl/list: Introduce cxl_filter_walk()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:31 -0800
Message-ID: <164298555121.3021641.16127840206319352254.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for introducing more objects and filtering options for 'cxl
list' introduce cxl_filter_walk() to centralize CXL topology walks. It
fills the same role as ndctl_filter_walk() as a way to distribute topology
interrogation beyond 'cxl list' to other commands, and serve as the
template for CXL object hierarchy in JSON output payloads.

Use the common dbg() logger for log messages.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-list.txt |    2 +
 cxl/filter.c                   |   50 ++++++++++++++++++++
 cxl/filter.h                   |   18 ++++++-
 cxl/list.c                     |  102 ++++++++--------------------------------
 cxl/meson.build                |    1 
 5 files changed, 90 insertions(+), 83 deletions(-)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 686e0ea768f0..4d409babb99a 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -15,6 +15,8 @@ SYNOPSIS
 Walk the CXL capable device hierarchy in the system and list all device
 instances along with some of their major attributes.
 
+Options can be specified to limit the output to specific objects.
+
 EXAMPLE
 -------
 ----
diff --git a/cxl/filter.c b/cxl/filter.c
index 405b653d80b2..d1ff4b62c806 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -1,10 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
+#include <errno.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <util/log.h>
+#include <util/json.h>
 #include <cxl/libcxl.h>
+#include <json-c/json.h>
+
 #include "filter.h"
+#include "json.h"
 
 static const char *which_sep(const char *filter)
 {
@@ -48,3 +54,47 @@ struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
 		return memdev;
 	return NULL;
 }
+
+static unsigned long params_to_flags(struct cxl_filter_params *param)
+{
+	unsigned long flags = 0;
+
+	if (param->idle)
+		flags |= UTIL_JSON_IDLE;
+	if (param->human)
+		flags |= UTIL_JSON_HUMAN;
+	if (param->health)
+		flags |= UTIL_JSON_HEALTH;
+	return flags;
+}
+
+int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *p)
+{
+	struct json_object *jplatform = json_object_new_array();
+	unsigned long flags = params_to_flags(p);
+	struct cxl_memdev *memdev;
+
+	if (!jplatform) {
+		dbg(p, "platform object allocation failure\n");
+		return -ENOMEM;
+	}
+
+	cxl_memdev_foreach(ctx, memdev) {
+		struct json_object *jdev;
+
+		if (!util_cxl_memdev_filter(memdev, p->memdev_filter))
+			continue;
+		if (p->memdevs) {
+			jdev = util_cxl_memdev_to_json(memdev, flags);
+			if (!jdev) {
+				dbg(p, "memdev object allocation failure\n");
+				continue;
+			}
+			json_object_array_add(jplatform, jdev);
+		}
+	}
+
+	util_display_json_array(stdout, jplatform, flags);
+
+	return 0;
+}
diff --git a/cxl/filter.h b/cxl/filter.h
index da800336b528..664b74b23b0a 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -1,7 +1,21 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2015-2020 Intel Corporation. All rights reserved. */
+/* Copyright (C) 2021 Intel Corporation. All rights reserved. */
 #ifndef _CXL_UTIL_FILTER_H_
 #define _CXL_UTIL_FILTER_H_
+
+#include <stdbool.h>
+#include <util/log.h>
+
+struct cxl_filter_params {
+	const char *memdev_filter;
+	bool memdevs;
+	bool idle;
+	bool human;
+	bool health;
+	struct log_ctx ctx;
+};
+
 struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
-		const char *ident);
+					  const char *ident);
+int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *param);
 #endif /* _CXL_UTIL_FILTER_H_ */
diff --git a/cxl/list.c b/cxl/list.c
index 7f7a04d9a6e5..17303073b49a 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -9,60 +9,27 @@
 #include <json-c/json.h>
 #include <cxl/libcxl.h>
 #include <util/parse-options.h>
-#include <ccan/array_size/array_size.h>
 
-#include "json.h"
 #include "filter.h"
 
-static struct {
-	bool memdevs;
-	bool idle;
-	bool human;
-	bool health;
-} list;
-
-static unsigned long listopts_to_flags(void)
-{
-	unsigned long flags = 0;
-
-	if (list.idle)
-		flags |= UTIL_JSON_IDLE;
-	if (list.human)
-		flags |= UTIL_JSON_HUMAN;
-	if (list.health)
-		flags |= UTIL_JSON_HEALTH;
-	return flags;
-}
-
-static struct {
-	const char *memdev;
-} param;
-
-static int did_fail;
-
-#define fail(fmt, ...) \
-do { \
-	did_fail = 1; \
-	fprintf(stderr, "cxl-%s:%s:%d: " fmt, \
-			VERSION, __func__, __LINE__, ##__VA_ARGS__); \
-} while (0)
+static struct cxl_filter_params param;
 
 static int num_list_flags(void)
 {
-	return list.memdevs;
+	return param.memdevs;
 }
 
 int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 {
 	const struct option options[] = {
-		OPT_STRING('m', "memdev", &param.memdev, "memory device name",
+		OPT_STRING('m', "memdev", &param.memdev_filter, "memory device name",
 			   "filter by CXL memory device name"),
-		OPT_BOOLEAN('M', "memdevs", &list.memdevs,
+		OPT_BOOLEAN('M', "memdevs", &param.memdevs,
 			    "include CXL memory device info"),
-		OPT_BOOLEAN('i', "idle", &list.idle, "include idle devices"),
-		OPT_BOOLEAN('u', "human", &list.human,
+		OPT_BOOLEAN('i', "idle", &param.idle, "include disabled devices"),
+		OPT_BOOLEAN('u', "human", &param.human,
 				"use human friendly number formats "),
-		OPT_BOOLEAN('H', "health", &list.health,
+		OPT_BOOLEAN('H', "health", &param.health,
 				"include memory device health information "),
 		OPT_END(),
 	};
@@ -70,9 +37,6 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 		"cxl list [<options>]",
 		NULL
 	};
-	struct json_object *jdevs = NULL;
-	unsigned long list_flags;
-	struct cxl_memdev *memdev;
 	int i;
 
 	argc = parse_options(argc, argv, options, u, 0);
@@ -83,46 +47,22 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 		usage_with_options(u, options);
 
 	if (num_list_flags() == 0) {
-		/*
-		 * TODO: We likely want to list regions by default if nothing
-		 * was explicitly asked for. But until we have region support,
-		 * print this error asking for devices explicitly.
-		 * Once region support is added, this TODO can be removed.
-		 */
-		error("please specify entities to list, e.g. using -m/-M\n");
-		usage_with_options(u, options);
-	}
-
-	list_flags = listopts_to_flags();
-
-	cxl_memdev_foreach(ctx, memdev) {
-		struct json_object *jdev = NULL;
-
-		if (!util_cxl_memdev_filter(memdev, param.memdev))
-			continue;
-
-		if (list.memdevs) {
-			if (!jdevs) {
-				jdevs = json_object_new_array();
-				if (!jdevs) {
-					fail("\n");
-					continue;
-				}
-			}
-
-			jdev = util_cxl_memdev_to_json(memdev, list_flags);
-			if (!jdev) {
-				fail("\n");
-				continue;
-			}
-			json_object_array_add(jdevs, jdev);
+		if (param.memdev_filter)
+			param.memdevs = true;
+		else {
+			/*
+			 * TODO: We likely want to list regions by default if
+			 * nothing was explicitly asked for. But until we have
+			 * region support, print this error asking for devices
+			 * explicitly.  Once region support is added, this TODO
+			 * can be removed.
+			 */
+			error("please specify entities to list, e.g. using -m/-M\n");
+			usage_with_options(u, options);
 		}
 	}
 
-	if (jdevs)
-		util_display_json_array(stdout, jdevs, list_flags);
+	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
 
-	if (did_fail)
-		return -ENOMEM;
-	return 0;
+	return cxl_filter_walk(ctx, &param);
 }
diff --git a/cxl/meson.build b/cxl/meson.build
index 805924b9df9b..fc7ee71b54f0 100644
--- a/cxl/meson.build
+++ b/cxl/meson.build
@@ -3,6 +3,7 @@ cxl_src = [
   'list.c',
   'memdev.c',
   '../util/json.c',
+  '../util/log.c',
   'json.c',
   'filter.c',
 ]

