Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE91C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Nov 2022 00:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKJAHm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiKJAHl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Nov 2022 19:07:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09DB17A99
        for <linux-cxl@vger.kernel.org>; Wed,  9 Nov 2022 16:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668038860; x=1699574860;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bgE4cV4pKoNmNhtTJt9gbdSlFsN0Knt7pJIFCKeiaoU=;
  b=GQnsv2L4wOYJlvopdTl53JrItMHWC88SCwCm4LW296ZugUl0x2VYEKZH
   xDuK0bLaQRhsBn6zWFZ7wT/JBwZodd7d3ODgzho+/40hOA/Cf5fFqjqOO
   v4j2WAxBviy6QxS9VVQsGBy4QI4foZ1FVxKysYpUpXjZhIbqsibtZNQvA
   bsglmpgHNH20wiAi38H8UdMPbDYCcpSNvev2EgFrxOkOreNCkpP+hqoXv
   LQpnW97fZQXLwUZ6KCL3XFye7nZfUU0Haoh9sQr9KPhOA8mq1N0moLmzD
   m3yI4uXzSihM4fqs8ak4436eqzv0sblavKWs42sjCVpFpdmyZX9llukT/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="375403408"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="375403408"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:07:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="631442541"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="631442541"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:07:40 -0800
Subject: [PATCH v5 2/7] ndctl: cxl: add helper to parse through all current
 events
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 09 Nov 2022 17:07:39 -0700
Message-ID: <166803885992.145141.11751557821515668416.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
References: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
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
monitor, the "system" or category of trace event, in this case "cxl",
is provided in order to filter for the CXL events.

Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/event_trace.c |   37 +++++++++++++++++++++++++++++++++++++
 cxl/event_trace.h |   10 ++++++++++
 cxl/meson.build   |    1 +
 meson.build       |    2 ++
 4 files changed, 50 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index 3c9fb684139a..d7bbd3cf4946 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -9,6 +9,7 @@
 #include <ccan/list/list.h>
 #include <uuid/uuid.h>
 #include <traceevent/event-parse.h>
+#include <tracefs/tracefs.h>
 #include "event_trace.h"
 
 #define _GNU_SOURCE
@@ -191,3 +192,39 @@ err_jnode:
 	free(jnode);
 	return rc;
 }
+
+static int cxl_event_parse(struct tep_event *event, struct tep_record *record,
+			   int cpu, void *ctx)
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
+		return event_ctx->parse_event(event, record,
+					      &event_ctx->jlist_head);
+
+	return cxl_event_to_json(event, record, &event_ctx->jlist_head);
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
+	rc = tracefs_iterate_raw_events(tep, inst, NULL, 0, cxl_event_parse,
+					ectx);
+	tep_free(tep);
+	return rc;
+}
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index 00975a0b5680..e83737de0ad5 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -11,4 +11,14 @@ struct jlist_node {
 	struct list_node list;
 };
 
+struct event_ctx {
+	const char *system;
+	struct list_head jlist_head;
+	const char *event_name; /* optional */
+	int (*parse_event)(struct tep_event *event, struct tep_record *record,
+			   struct list_head *jlist_head); /* optional */
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


