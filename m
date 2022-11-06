Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD98C433FE
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Nov 2022 23:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiKFXr2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Nov 2022 18:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiKFXr1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Nov 2022 18:47:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE45AD2DB
        for <linux-cxl@vger.kernel.org>; Sun,  6 Nov 2022 15:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667778446; x=1699314446;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oo+YDC2MaJSBfiBtU5WPJPPsRqc63yK4zGMMsoyeCMg=;
  b=jJWo8V1IK4BrIiw7Bd7qu1xFXQAkxJIvalbUntX9QQvWGkIEMJNVGoid
   odRaPsmMmTUSSsNTHdQqr6O3RvAn0S5weUhHQoh6qGtQ1Xl6di0H1uOCz
   VZuY/U/QvC1tr5Q5oX9+HGQSU8zu/9gkIC6gKJomHPizrQomCQUagpzpd
   emjogEb5b4SHQFoMUSjkX23fhx9+RPk54/cXhi2THuGWyhHaF9m4CDsQR
   2+QM++PuTket+1Ao8Z/6AsslcM3/vkZergcKst0vLK/WvPEgLIuNiuKTw
   fy8iLgXCef+QB/S4HoS8lu4Yy9UPwEEBSwvcTXJUl3Rl+DKH1NpaRu8Zq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="310292106"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="310292106"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:47:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="964951421"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="964951421"
Received: from durgasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.240.219])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:47:26 -0800
Subject: [ndctl PATCH 07/15] cxl/filter: Return json-c topology
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 06 Nov 2022 15:47:25 -0800
Message-ID: <166777844585.1238089.453902924006914638.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
References: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for cxl_filter_walk() to be used to collect and publish cxl
objects for other utilities, return the resulting json_object directly.
Move the responsibility of freeing and optionally printing the object to
the caller.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/filter.c |   30 ++++++------------------------
 cxl/filter.h |   22 +++++++++++++++++++++-
 cxl/list.c   |    7 ++++++-
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/cxl/filter.c b/cxl/filter.c
index 040e7deefb3e..8499450ded01 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -672,23 +672,6 @@ util_cxl_decoder_filter_by_region(struct cxl_decoder *decoder,
 	return decoder;
 }
 
-static unsigned long params_to_flags(struct cxl_filter_params *param)
-{
-	unsigned long flags = 0;
-
-	if (param->idle)
-		flags |= UTIL_JSON_IDLE;
-	if (param->human)
-		flags |= UTIL_JSON_HUMAN;
-	if (param->health)
-		flags |= UTIL_JSON_HEALTH;
-	if (param->targets)
-		flags |= UTIL_JSON_TARGETS;
-	if (param->partition)
-		flags |= UTIL_JSON_PARTITION;
-	return flags;
-}
-
 static void splice_array(struct cxl_filter_params *p, struct json_object *jobjs,
 			 struct json_object *platform,
 			 const char *container_name, bool do_container)
@@ -1027,11 +1010,12 @@ walk_children:
 	}
 }
 
-int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *p)
+struct json_object *cxl_filter_walk(struct cxl_ctx *ctx,
+				    struct cxl_filter_params *p)
 {
 	struct json_object *jdevs = NULL, *jbuses = NULL, *jports = NULL;
 	struct json_object *jplatform = json_object_new_array();
-	unsigned long flags = params_to_flags(p);
+	unsigned long flags = cxl_filter_to_flags(p);
 	struct json_object *jportdecoders = NULL;
 	struct json_object *jbusdecoders = NULL;
 	struct json_object *jepdecoders = NULL;
@@ -1044,7 +1028,7 @@ int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *p)
 
 	if (!jplatform) {
 		dbg(p, "platform object allocation failure\n");
-		return -ENOMEM;
+		return NULL;
 	}
 
 	janondevs = json_object_new_array();
@@ -1232,9 +1216,7 @@ walk_children:
 		     top_level_objs > 1);
 	splice_array(p, jregions, jplatform, "regions", top_level_objs > 1);
 
-	util_display_json_array(stdout, jplatform, flags);
-
-	return 0;
+	return jplatform;
 err:
 	json_object_put(janondevs);
 	json_object_put(jbuses);
@@ -1246,5 +1228,5 @@ err:
 	json_object_put(jepdecoders);
 	json_object_put(jregions);
 	json_object_put(jplatform);
-	return -ENOMEM;
+	return NULL;
 }
diff --git a/cxl/filter.h b/cxl/filter.h
index 256df49c3d0c..2bda6ddd77ca 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -5,6 +5,7 @@
 
 #include <stdbool.h>
 #include <util/log.h>
+#include <util/json.h>
 
 struct cxl_filter_params {
 	const char *memdev_filter;
@@ -59,6 +60,25 @@ struct cxl_dport *util_cxl_dport_filter_by_memdev(struct cxl_dport *dport,
 						  const char *serial);
 struct cxl_decoder *util_cxl_decoder_filter(struct cxl_decoder *decoder,
 					    const char *__ident);
-int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *param);
+struct json_object *cxl_filter_walk(struct cxl_ctx *ctx,
+				    struct cxl_filter_params *param);
+
+static inline unsigned long cxl_filter_to_flags(struct cxl_filter_params *param)
+{
+	unsigned long flags = 0;
+
+	if (param->idle)
+		flags |= UTIL_JSON_IDLE;
+	if (param->human)
+		flags |= UTIL_JSON_HUMAN;
+	if (param->health)
+		flags |= UTIL_JSON_HEALTH;
+	if (param->targets)
+		flags |= UTIL_JSON_TARGETS;
+	if (param->partition)
+		flags |= UTIL_JSON_PARTITION;
+	return flags;
+}
+
 bool cxl_filter_has(const char *needle, const char *__filter);
 #endif /* _CXL_UTIL_FILTER_H_ */
diff --git a/cxl/list.c b/cxl/list.c
index 8c48fbbaaec3..2026de2b548b 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -72,6 +72,7 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 		"cxl list [<options>]",
 		NULL
 	};
+	struct json_object *jtopology;
 	int i;
 
 	argc = parse_options(argc, argv, options, u, 0);
@@ -140,5 +141,9 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 		param.endpoints = true;
 
 	dbg(&param, "walk topology\n");
-	return cxl_filter_walk(ctx, &param);
+	jtopology = cxl_filter_walk(ctx, &param);
+	if (!jtopology)
+		return -ENOMEM;
+	util_display_json_array(stdout, jtopology, cxl_filter_to_flags(&param));
+	return 0;
 }

