Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13275C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiAXAwL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:63513 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAwK (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985530; x=1674521530;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tk1yFx6UY7Xg/YMi/NYFjfeJNxMktgdWvvkVGqFzrQw=;
  b=M4HNkmPOd7AFS/2t9hniZ5dP0n6LkceQgmHrmsPgLs7ZhkXQXP8XEG0w
   JtTR4s0Kyea4yS2M+N7BiFxSRIcN2MAA5VVCRr7YvYlSMusBOZWyqY6CA
   e6hCLhf1jql/cO9H/WXoTZwqpQw09lvJRYG1krsHdNV1+hg6YqIX5JdlJ
   wkrD5qdXtz+R7l7o41qBEXghkxBaXqnYUyVfx4EPP79Txpg9WqRknulLH
   cSRzo9ZRKnTuqXLSmrNTViwxmFFzQYly/xWEi9LKJizuZO5rfgWiLdAmw
   /RbD4gwCp2jp5lsrxFMQntD8dPRqhR4a/sfgx5ANTaKwYb12yYw4hTaEj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245880848"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245880848"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="478866108"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:10 -0800
Subject: [ndctl PATCH 04/37] json: Add support for json_object_new_uint64()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:10 -0800
Message-ID: <164298553057.3021641.17232869374733997747.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Recent versions of json-c add a proper u64 type. However since ndctl still
needs to build against older json-c add build infrastructure to fallback to
s64.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 config.h.meson |    3 +++
 cxl/json.c     |    6 +++---
 daxctl/json.c  |    2 +-
 meson.build    |    6 ++++++
 ndctl/dimm.c   |    2 +-
 ndctl/json.c   |   10 +++++-----
 util/json.c    |    2 +-
 util/json.h    |   13 ++++++++++++-
 8 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/config.h.meson b/config.h.meson
index 98102251b494..2852f1e9cd8b 100644
--- a/config.h.meson
+++ b/config.h.meson
@@ -88,6 +88,9 @@
 /* Define to 1 if you have the `__secure_getenv' function. */
 #mesondefine HAVE___SECURE_GETENV
 
+/* Define to 1 if you have json_object_new_uint64 in json-c */
+#mesondefine HAVE_JSON_U64
+
 /* Define to the sub-directory where libtool stores uninstalled libraries. */
 #mesondefine LT_OBJDIR
 
diff --git a/cxl/json.c b/cxl/json.c
index e562502d9116..97ed76b65a6b 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -159,17 +159,17 @@ static struct json_object *util_cxl_memdev_health_to_json(
 	}
 
 	field = cxl_cmd_health_info_get_dirty_shutdowns(cmd);
-	jobj = json_object_new_int64(field);
+	jobj = util_json_new_u64(field);
 	if (jobj)
 		json_object_object_add(jhealth, "dirty_shutdowns", jobj);
 
 	field = cxl_cmd_health_info_get_volatile_errors(cmd);
-	jobj = json_object_new_int64(field);
+	jobj = util_json_new_u64(field);
 	if (jobj)
 		json_object_object_add(jhealth, "volatile_errors", jobj);
 
 	field = cxl_cmd_health_info_get_pmem_errors(cmd);
-	jobj = json_object_new_int64(field);
+	jobj = util_json_new_u64(field);
 	if (jobj)
 		json_object_object_add(jhealth, "pmem_errors", jobj);
 
diff --git a/daxctl/json.c b/daxctl/json.c
index 66a795e2e544..3cbce9dcd651 100644
--- a/daxctl/json.c
+++ b/daxctl/json.c
@@ -190,7 +190,7 @@ struct json_object *util_daxctl_region_to_json(struct daxctl_region *region,
 
 	align = daxctl_region_get_align(region);
 	if (align < ULONG_MAX) {
-		jobj = json_object_new_int64(align);
+		jobj = util_json_new_u64(align);
 		if (!jobj)
 			goto err;
 		json_object_object_add(jregion, "align", jobj);
diff --git a/meson.build b/meson.build
index 68f3d0ceff1c..f25ec6c47e7b 100644
--- a/meson.build
+++ b/meson.build
@@ -241,6 +241,12 @@ foreach ident : ['secure_getenv', '__secure_getenv']
   conf.set10('HAVE_' + ident.to_upper(), cc.has_function(ident))
 endforeach
 
+conf.set10('HAVE_JSON_U64',
+  cc.has_function('json_object_new_uint64',
+    prefix : '''#include <json-c/json.h>''',
+    dependencies : json,
+  )
+)
 
 ndctlconf_dir = sysconfdir / 'ndctl.conf.d'
 ndctlconf = ndctlconf_dir / 'monitor.conf'
diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 0f052644a46e..d9718a33b22f 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -168,7 +168,7 @@ static struct json_object *dump_label_json(struct ndctl_dimm *dimm,
 			break;
 		json_object_object_add(jlabel, "isetcookie", jobj);
 
-		jobj = json_object_new_int64(le64_to_cpu(nslabel.lbasize));
+		jobj = util_json_new_u64(le64_to_cpu(nslabel.lbasize));
 		if (!jobj)
 			break;
 		json_object_object_add(jlabel, "lbasize", jobj);
diff --git a/ndctl/json.c b/ndctl/json.c
index c62e6cae01a9..23bad7fd7445 100644
--- a/ndctl/json.c
+++ b/ndctl/json.c
@@ -357,7 +357,7 @@ static struct json_object *util_##type##_build_size_array(struct ndctl_##type *a
 		int64_t align;					\
 								\
 		align = get_elem(arg, i);			\
-		jobj = json_object_new_int64(align);		\
+		jobj = util_json_new_u64(align);		\
 		if (!jobj)					\
 			goto err;				\
 		json_object_array_add(arr, jobj);		\
@@ -550,7 +550,7 @@ struct json_object *util_region_badblocks_to_json(struct ndctl_region *region,
 		if (!jbb)
 			goto err_array;
 
-		jobj = json_object_new_int64(bb->offset);
+		jobj = util_json_new_u64(bb->offset);
 		if (!jobj)
 			goto err;
 		json_object_object_add(jbb, "offset", jobj);
@@ -604,7 +604,7 @@ static struct json_object *util_namespace_badblocks_to_json(
 		if (!jbb)
 			goto err_array;
 
-		jobj = json_object_new_int64(bb->offset);
+		jobj = util_json_new_u64(bb->offset);
 		if (!jobj)
 			goto err;
 		json_object_object_add(jbb, "offset", jobj);
@@ -682,7 +682,7 @@ static struct json_object *dev_badblocks_to_json(struct ndctl_region *region,
 		if (!jbb)
 			goto err_array;
 
-		jobj = json_object_new_int64(offset);
+		jobj = util_json_new_u64(offset);
 		if (!jobj)
 			goto err;
 		json_object_object_add(jbb, "offset", jobj);
@@ -972,7 +972,7 @@ struct json_object *util_namespace_to_json(struct ndctl_namespace *ndns,
 	}
 
 	if (align) {
-		jobj = json_object_new_int64(align);
+		jobj = util_json_new_u64(align);
 		if (!jobj)
 			goto err;
 		json_object_object_add(jndns, "align", jobj);
diff --git a/util/json.c b/util/json.c
index 9f0a8e137caa..bd5f8fc47a2b 100644
--- a/util/json.c
+++ b/util/json.c
@@ -82,7 +82,7 @@ struct json_object *util_json_object_size(unsigned long long size,
 struct json_object *util_json_object_hex(unsigned long long val,
 		unsigned long flags)
 {
-	struct json_object *jobj = json_object_new_int64(val);
+	struct json_object *jobj = util_json_new_u64(val);
 
 	if (jobj && (flags & UTIL_JSON_HUMAN))
 		json_object_set_serializer(jobj, display_hex, NULL, NULL);
diff --git a/util/json.h b/util/json.h
index 4ca2c890fa5c..061f0d423158 100644
--- a/util/json.h
+++ b/util/json.h
@@ -4,6 +4,7 @@
 #define __UTIL_JSON_H__
 #include <stdio.h>
 #include <stdbool.h>
+#include <json-c/json.h>
 
 enum util_json_flags {
 	UTIL_JSON_IDLE		= (1 << 0),
@@ -19,11 +20,21 @@ enum util_json_flags {
 	UTIL_JSON_HEALTH	= (1 << 10),
 };
 
-struct json_object;
 void util_display_json_array(FILE *f_out, struct json_object *jarray,
 		unsigned long flags);
 struct json_object *util_json_object_size(unsigned long long size,
 		unsigned long flags);
 struct json_object *util_json_object_hex(unsigned long long val,
 		unsigned long flags);
+#if HAVE_JSON_U64
+static inline struct json_object *util_json_new_u64(unsigned long long val)
+{
+	return json_object_new_uint64(val);
+}
+#else /* fallback to signed */
+static inline struct json_object *util_json_new_u64(unsigned long long val)
+{
+	return json_object_new_int64(val);
+}
+#endif /* HAVE_JSON_U64 */
 #endif /* __UTIL_JSON_H__ */

