Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B66C6FA82
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Sep 2022 20:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiINUsE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Sep 2022 16:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiINUsD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Sep 2022 16:48:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A4E6AA25
        for <linux-cxl@vger.kernel.org>; Wed, 14 Sep 2022 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663188482; x=1694724482;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DwIldEzUVI0O6ficbQRXaBTNXjY6xo/z8V+glpZgRv4=;
  b=DniWETvY2le62qL1npqXLCTLsksOt3PsflHOJNOqMOLh/7N/4Ub1n3Cx
   F7gtrj99N4QuMbH/LV/PxcECIERX6sTE7/wTJuwbVqit0XInq5jqROeTT
   qh/N0SVHenLhgPsKL6REdY/1AbNRkyI7Q6nC+I48J26cfEtDxkXie8Iug
   5HVoeThOGQQncMK6sMqj/AbbntQvh0T0Wlqw1EMIktA8t8ZQBZ3sOOOcT
   2gNGVFwWI623A8JaRtqLwz8ysIFiT9Hss+13gzdjE5udjXRHeXV0R0u3R
   eR5sCMaSVrIGljRbFc7aryotoLuZVfuYbhacV2qrPOrbB+00WQKDodgIE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362498940"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="362498940"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:48:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="759360388"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:48:01 -0700
Subject: [PATCH 2/7] ndctl: cxl: add helper to parse through all current
 events
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Date:   Wed, 14 Sep 2022 13:48:01 -0700
Message-ID: <166318848131.3087953.17609964424559300800.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
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
 cxl/event_trace.c |   35 +++++++++++++++++++++++++++++++++++
 cxl/event_trace.h |    7 +++++++
 cxl/meson.build   |    1 +
 meson.build       |    2 ++
 4 files changed, 45 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index ffa2a9b9b036..d5e67b55a4d8 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -16,6 +16,7 @@
 #include <libcxl.h>
 #include <uuid/uuid.h>
 #include <traceevent/event-parse.h>
+#include <tracefs/tracefs.h>
 #include "json.h"
 #include "event_trace.h"
 
@@ -164,3 +165,37 @@ err_jevent:
 	free(jnode);
 	return rc;
 }
+
+static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record,
+		int cpu, void *ctx)
+{
+	struct event_ctx *event_ctx = (struct event_ctx *)ctx;
+	int rc, i;
+
+	/* Filter out all the events that the caller isn't interested in. */
+	for (i = 0; event_ctx->systems[i]; i++) {
+		if (strcmp(event->system, event_ctx->systems[i]) != 0)
+			continue;
+
+		rc = cxl_event_to_json_callback(event, record, &event_ctx->jlist_head);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
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
index 00975a0b5680..98cfbb4602e1 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -11,4 +11,11 @@ struct jlist_node {
 	struct list_node list;
 };
 
+struct event_ctx {
+	const char **systems;
+	struct list_head jlist_head;
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


