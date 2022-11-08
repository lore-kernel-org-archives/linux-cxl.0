Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BFCC4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKHSaw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKHSav (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:30:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391654B36
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932251; x=1699468251;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUDO3qN6CnzVve4e8IjJOpZdaKU3qswJTV/Ln6jCQfA=;
  b=T/eobY7ooyvFJhWOGa68ufxAbB1Gn2BdNMWwKRPgWq5AuOX5KNg/oxoI
   Mqlik9NaTUoL91T7ODgs1Wb+PjsW0QuMTpa2aNJdmsNQmuFJepup5rBU9
   ONPNCYSHbSZBAAu1moeMEMXK+KDC5OiDBOtDakKE5Xh3mobU4MF+/aAcV
   OuC1LXl7M0Sh7FMMz3KuZ2sdiiVWquYDTolijyL7uHXGgGrfZEHt9RKKB
   Tcq5Bu1TLT0CwkyCTSRAdeldnb4z8qFibcV3bqMK4j1a3ZVx8/YevCaTo
   Z79D3LsEnXqzlM3oO8vQX0sbe7lLutsurqqy9nuS6DCEgaq5FUDb5cWqB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="372916011"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="372916011"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669650018"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669650018"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:29:59 -0800
Subject: [PATCH v4 02/10] cxl: add helper to parse through all current events
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:29:59 -0700
Message-ID: <166793219956.3768752.10060411389279195687.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
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

Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/event_trace.c |   36 ++++++++++++++++++++++++++++++++++++
 cxl/event_trace.h |   10 ++++++++++
 cxl/meson.build   |    1 +
 meson.build       |    2 ++
 4 files changed, 49 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index 1b1b037e48bf..4667044e4a66 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -16,6 +16,7 @@
 #include <libcxl.h>
 #include <uuid/uuid.h>
 #include <traceevent/event-parse.h>
+#include <tracefs/tracefs.h>
 #include "json.h"
 #include "event_trace.h"
 
@@ -199,3 +200,38 @@ err_jevent:
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


