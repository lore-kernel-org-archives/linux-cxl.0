Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9139C4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKHS36 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKHS34 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:29:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F7C15735
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932195; x=1699468195;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C5ktDag9K9FWp0zPwFOuS+0FNry24XJ9fIX8/PhOyvA=;
  b=Ak10IpDJV/HJhAXbMFCLxVx5O2D2X3T4bCorSLojLIJvtKSNJvpTU2dC
   k/bVBEG6lDRkFu0a2NPrflekyp8sovJpv4WiJ8QNORksnaN/WwhKnUmiB
   YQe0W7agoBkXZUZstKDJ7igclvJGPIlW+WGqEBKJoaMVMUBw+iCkfZGX7
   d/fITJRgEBry24ciMkaYw3aXzK33ZumbosNb0dbVcjv26m2Gmvv3FMcVl
   zSeCEHxlJoDfvLaTPqyIzLATqlrFMmuLJPKtzVtEUnTXbs5r5E6+0icZo
   Gl7EjA1gBu+INq47l3lreo6AeHwSGGMOJEXMoCMoHkUFSuSr9Q6SBzkRQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290491125"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="290491125"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:29:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669650001"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669650001"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:29:54 -0800
Subject: [PATCH v4 01/10] cxl: add helper function to parse trace event to
 json object
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:29:53 -0700
Message-ID: <166793219376.3768752.15370223291855764073.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add the helper function that parses a trace event captured by
libtraceevent in a tep handle. All the parsed fields are added to a json
object. The json object is added to the provided list in the input parameter.

Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/event_trace.c |  201 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 cxl/event_trace.h |   14 ++++
 cxl/meson.build   |    2 +
 meson.build       |    1 
 4 files changed, 218 insertions(+)
 create mode 100644 cxl/event_trace.c
 create mode 100644 cxl/event_trace.h

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
new file mode 100644
index 000000000000..1b1b037e48bf
--- /dev/null
+++ b/cxl/event_trace.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022, Intel Corp. All rights reserved.
+#include <stdio.h>
+#include <json-c/json.h>
+#include <util/json.h>
+#include <util/util.h>
+#include <util/parse-options.h>
+#include <util/parse-configs.h>
+#include <util/strbuf.h>
+#include <util/sysfs.h>
+#include <ccan/list/list.h>
+#include <ndctl/ndctl.h>
+#include <ndctl/libndctl.h>
+#include <sys/epoll.h>
+#include <sys/stat.h>
+#include <libcxl.h>
+#include <uuid/uuid.h>
+#include <traceevent/event-parse.h>
+#include "json.h"
+#include "event_trace.h"
+
+#define _GNU_SOURCE
+#include <string.h>
+
+static struct json_object *num_to_json(void *num, int elem_size, unsigned long flags)
+{
+	bool sign = flags & TEP_FIELD_IS_SIGNED;
+	int64_t val = 0;
+
+	/* special case 64 bit as the call depends on sign */
+	if (elem_size == 8) {
+		if (sign)
+			return json_object_new_int64(*(int64_t *)num);
+		else
+			return json_object_new_uint64(*(uint64_t *)num);
+	}
+
+	/* All others fit in a signed 64 bit */
+	switch (elem_size) {
+	case 1:
+		if (sign)
+			val = *(int8_t *)num;
+		else
+			val = *(uint8_t *)num;
+		break;
+	case 2:
+		if (sign)
+			val = *(int16_t *)num;
+		else
+			val = *(uint16_t *)num;
+		break;
+	case 4:
+		if (sign)
+			val = *(int32_t *)num;
+		else
+			val = *(uint32_t *)num;
+		break;
+	default:
+		/*
+		 * Odd sizes are converted in the kernel to one of the above.
+		 * It is an error to see them here.
+		 */
+		return NULL;
+	}
+
+	return json_object_new_int64(val);
+}
+
+static int cxl_event_to_json_callback(struct tep_event *event,
+		struct tep_record *record, struct list_head *jlist_head)
+{
+	struct tep_format_field **fields;
+	struct json_object *jevent, *jobj, *jarray;
+	struct jlist_node *jnode;
+	int i, j, rc = 0;
+
+	jnode = malloc(sizeof(*jnode));
+	if (!jnode)
+		return -ENOMEM;
+
+	jevent = json_object_new_object();
+	if (!jevent) {
+		rc = -ENOMEM;
+		goto err_jevent;
+	}
+	jnode->jobj = jevent;
+
+	fields = tep_event_fields(event);
+	if (!fields) {
+		rc = -ENOENT;
+		goto err;
+	}
+
+	jobj = json_object_new_string(event->system);
+	if (!jobj) {
+		rc = -ENOMEM;
+		goto err;
+	}
+	json_object_object_add(jevent, "system", jobj);
+
+	jobj = json_object_new_string(event->name);
+	if (!jobj) {
+		rc = -ENOMEM;
+		goto err;
+	}
+	json_object_object_add(jevent, "event", jobj);
+
+	jobj = json_object_new_uint64(record->ts);
+	if (!jobj) {
+		rc = -ENOMEM;
+		goto err;
+	}
+	json_object_object_add(jevent, "timestamp", jobj);
+
+	for (i = 0; fields[i]; i++) {
+		struct tep_format_field *f = fields[i];
+		int len;
+
+		if (f->flags & TEP_FIELD_IS_STRING) {
+			char *str;
+
+			str = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
+			if (!str)
+				continue;
+
+			jobj = json_object_new_string(str);
+			if (!jobj) {
+				rc = -ENOMEM;
+				goto err;
+			}
+
+			json_object_object_add(jevent, f->name, jobj);
+		} else if (f->flags & TEP_FIELD_IS_ARRAY) {
+			unsigned char *data;
+			int chunks;
+
+			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
+			if (!data)
+				continue;
+
+			jarray = json_object_new_array();
+			if (!jarray) {
+				rc = -ENOMEM;
+				goto err;
+			}
+
+			chunks = f->size / f->elementsize;
+			for (j = 0; j < chunks; j++) {
+				jobj = num_to_json(data, f->elementsize, f->flags);
+				if (!jobj) {
+					json_object_put(jarray);
+					return -ENOMEM;
+				}
+				json_object_array_add(jarray, jobj);
+				data += f->elementsize;
+			}
+
+			json_object_object_add(jevent, f->name, jarray);
+		} else { /* single number */
+			unsigned char *data;
+			char *tmp;
+
+			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
+			if (!data)
+				continue;
+
+			/* check to see if we have a UUID */
+			tmp = strcasestr(f->type, "uuid_t");
+			if (tmp) {
+				char uuid[SYSFS_ATTR_SIZE];
+
+				uuid_unparse(data, uuid);
+				jobj = json_object_new_string(uuid);
+				if (!jobj) {
+					rc = -ENOMEM;
+					goto err;
+				}
+
+				json_object_object_add(jevent, f->name, jobj);
+				continue;
+			}
+
+			jobj = num_to_json(data, f->elementsize, f->flags);
+			if (!jobj) {
+				rc = -ENOMEM;
+				goto err;
+			}
+
+			json_object_object_add(jevent, f->name, jobj);
+		}
+	}
+
+	list_add_tail(jlist_head, &jnode->list);
+	return 0;
+
+err:
+	json_object_put(jevent);
+err_jevent:
+	free(jnode);
+	return rc;
+}
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
new file mode 100644
index 000000000000..00975a0b5680
--- /dev/null
+++ b/cxl/event_trace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2022 Intel Corporation. All rights reserved. */
+#ifndef __CXL_EVENT_TRACE_H__
+#define __CXL_EVENT_TRACE_H__
+
+#include <json-c/json.h>
+#include <ccan/list/list.h>
+
+struct jlist_node {
+	struct json_object *jobj;
+	struct list_node list;
+};
+
+#endif
diff --git a/cxl/meson.build b/cxl/meson.build
index f2474aaa6e2e..8c7733431613 100644
--- a/cxl/meson.build
+++ b/cxl/meson.build
@@ -7,6 +7,7 @@ cxl_src = [
   'memdev.c',
   'json.c',
   'filter.c',
+  'event_trace.c',
 ]
 
 cxl_tool = executable('cxl',
@@ -19,6 +20,7 @@ cxl_tool = executable('cxl',
     kmod,
     json,
     versiondep,
+    traceevent,
   ],
   install : true,
   install_dir : rootbindir,
diff --git a/meson.build b/meson.build
index 20a646d135c7..f611e0bdd7f3 100644
--- a/meson.build
+++ b/meson.build
@@ -142,6 +142,7 @@ kmod = dependency('libkmod')
 libudev = dependency('libudev')
 uuid = dependency('uuid')
 json = dependency('json-c')
+traceevent = dependency('libtraceevent')
 if get_option('docs').enabled()
   if get_option('asciidoctor').enabled()
     asciidoc = find_program('asciidoctor', required : true)


