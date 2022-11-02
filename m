Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12673C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiKBVUV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKBVUT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:20:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9214DDF93
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424011; x=1698960011;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F9lEBYQIY1HrzR5EM8xlY6g61f02FhSv8FfUCM9aQSo=;
  b=NA06Rav0ZmnYAne9Z8Y/Zxh0vqPkCK4osgEA+kKNPtYhxUyw0SB3BLel
   oDRpXIa6r28eYa16QOAWc5xHPRjIw6L4ya42ekyTaaRzuBguvG2Whop0Z
   o02Z9JJdcs/TCZ8/LvHAzC/NJLIpVtalN/WQhC+NBfsOzqFUTc0J+cMIw
   HklHqSGVENmjLxfgSIdgwldJgVlbtioriDA5PZLQjZlzmOIuM0HLWrQ02
   skReOqEstmb/6Z+gNWwrGQrE1g7FL3DQQLdKwvpGVNbJKdaMoVdTZ5Iny
   e9GaAclwwvf++FELRAYdUU50LlnFC9MVG8fwnmzaDP06GfREq4bdMzD4r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="373748693"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="373748693"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:10 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723705948"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723705948"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:10 -0700
Subject: [PATCH v3 01/10] cxl: add helper function to parse trace event to
 json object
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 02 Nov 2022 14:20:09 -0700
Message-ID: <166742400990.2654617.4918438509154032997.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/event_trace.c |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 cxl/event_trace.h |   14 ++++
 cxl/meson.build   |    2 +
 meson.build       |    1 
 4 files changed, 183 insertions(+)
 create mode 100644 cxl/event_trace.c
 create mode 100644 cxl/event_trace.h

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
new file mode 100644
index 000000000000..803df34452f3
--- /dev/null
+++ b/cxl/event_trace.c
@@ -0,0 +1,166 @@
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
+static struct json_object *num_to_json(void *num, int size)
+{
+	if (size <= 4)
+		return json_object_new_int(*(int *)num);
+
+	return util_json_object_hex(*(unsigned long long *)num, 0);
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
+		char *tmp;
+
+		tmp = strcasestr(f->type, "char[]");
+		if (tmp) { /* event field is a string */
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
+		} else if (f->arraylen) { /* data array */
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
+				jobj = num_to_json(data, f->elementsize);
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
+			jobj = num_to_json(data, f->elementsize);
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


