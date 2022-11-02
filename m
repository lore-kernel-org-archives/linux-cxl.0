Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82779C433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiKBVU1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiKBVUW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:20:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B55E081
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424020; x=1698960020;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tBgcqliIeNQO0A4/Pbm8sJEcuj8B5ki2PlvZfdgk8R0=;
  b=KZzLoLtDU6toS7I1EATN7O64OLKqhapDXhdfUTGzxbg9Qo94z4aZ3q8x
   0B09HJxnnLROchGh4G5SBD/DLG0dB7tgZTR03OBhaAZ27CF4I3k8ASZ7O
   r4ojTwS3QGg5lCTksJKpYaf9hnXvXecfiSZxhlB81odOsOUHJV3XedG6J
   cwIDwWVQ170OtuPB6vueDWFVeFY8cDTBNknx1oxnLPXIiiRgKEoxMmLNi
   703TqBPqak0KxYG95aZlvIhyMTyZF2gIjJjq1amOFJT3JTsBG0gR44HSv
   5uxAbinVSfmi8l1njimOZn48EzB2NntlAgswKEUG5Htu+Xl+l3oEpC5/D
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="296973463"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="296973463"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723705972"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723705972"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:15 -0700
Subject: [PATCH v3 02/10] cxl: add helper to parse through all current events
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 02 Nov 2022 14:20:15 -0700
Message-ID: <166742401562.2654617.7486764828664651966.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add common function to iterate through and extract the events in the
current trace buffer. The function uses tracefs_iterate_raw_events() from
libtracefs to go through all the events loaded into a tep_handle. A
callback is provided to the API call in order to parse the event. For cxl
monitor, an array of interested "systems" is provided in order to filter
for the interested events.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/event_trace.c |   36 ++++++++++++++++++++++++++++++++++++
 cxl/event_trace.h |   10 ++++++++++
 cxl/meson.build   |    1 +
 meson.build       |    2 ++
 4 files changed, 49 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index 803df34452f3..cf63d2346f6e 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -16,6 +16,7 @@
 #include <libcxl.h>
 #include <uuid/uuid.h>
 #include <traceevent/event-parse.h>
+#include <tracefs/tracefs.h>
 #include "json.h"
 #include "event_trace.h"
 
@@ -164,3 +165,38 @@ err_jevent:
 	free(jnode);
 	return rc;
 }
+
+static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record,
+		int cpu, void *ctx)
+{
+	struct event_ctx *event_ctx = (struct event_ctx *)ctx;
+
+	/* Filter out all the events that the caller isn't interested in. */
+	if (strcmp(event->system, event_ctx->system) != 0)
+		return 0;
+
+	if (event_ctx->event_name) {
+		if (strcmp(event->name, event_ctx->event_name) != 0)
+			return 0;
+	}
+
+	if (event_ctx->parse_event)
+		return event_ctx->parse_event(event, record, &event_ctx->jlist_head);
+
+	return cxl_event_to_json_callback(event, record, &event_ctx->jlist_head);
+}
+
+int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx)
+{
+	struct tep_handle *tep;
+	int rc;
+
+	tep = tracefs_local_events(NULL);
+	if (!tep)
+		return -ENOMEM;
+
+	rc = tracefs_iterate_raw_events(tep, inst, NULL, 0,
+			cxl_event_parse_cb, ectx);
+	tep_free(tep);
+	return rc;
+}
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index 00975a0b5680..582882c1eb35 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -11,4 +11,14 @@ struct jlist_node {
 	struct list_node list;
 };
 
+struct event_ctx {
+	const char *system;
+	struct list_head jlist_head;
+	const char *event_name;					/* optional */
+	int (*parse_event)(struct tep_event *event, struct tep_record *record,
+			   struct list_head *jlist_head);	/* optional */
+};
+
+int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
+
 #endif
diff --git a/cxl/meson.build b/cxl/meson.build
index 8c7733431613..c59876262e76 100644
--- a/cxl/meson.build
+++ b/cxl/meson.build
@@ -21,6 +21,7 @@ cxl_tool = executable('cxl',
     json,
     versiondep,
     traceevent,
+    tracefs,
   ],
   install : true,
   install_dir : rootbindir,
diff --git a/meson.build b/meson.build
index f611e0bdd7f3..c204c8ac52de 100644
--- a/meson.build
+++ b/meson.build
@@ -143,6 +143,8 @@ libudev = dependency('libudev')
 uuid = dependency('uuid')
 json = dependency('json-c')
 traceevent = dependency('libtraceevent')
+tracefs = dependency('libtracefs')
+
 if get_option('docs').enabled()
   if get_option('asciidoctor').enabled()
     asciidoc = find_program('asciidoctor', required : true)


