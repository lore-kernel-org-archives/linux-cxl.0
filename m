Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806ACC433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiKHSaU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKHSaT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:30:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9436526CF
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932218; x=1699468218;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DhucDPoPZco3IJng6uR4kcYHNC1k1NwMtPRheRVs150=;
  b=WoKCSUcb9UX5Q8wLMLI4MquAeJIh3Y2z+joWuv3zDPnvyB1lhyk+DDMv
   qVtO58fdhlBnc4E/H0UzW1CGuirHC1q7qlDwuJrIj3MKQxO1P8duaY0mM
   WOpIuXDrxDEy4Zgq0EPzC9NLFd8jlXzYqsb75XmLvctn8tyLNroKJMMNW
   2J4kVc16BHq6SxK/7UfGZy2Nbx9gZ9tExubitilkrv3njEZ/0/uHNHm+i
   Q3FxkAnoDy6058nR55c/ict/WxNyP2K+dJFJNiaLn8J9Vq8ABJ/AvqDVd
   g/Xw2Sc3n5YmNoj2E0eCF/ejqpTcxq/KoPiSuDuciM6/oKnM2HL8WemFU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="375046161"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="375046161"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669650153"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669650153"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:17 -0800
Subject: [PATCH v4 05/10] cxl: add monitor function for event trace events
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:30:16 -0700
Message-ID: <166793221692.3768752.18351228388707416243.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add function that creates an event trace instance and utilize the cxl event
trace common functions to extract interested events from the trace buffer.
The monitoring function will pend on an epoll fd and wait for new events
to appear in the trace buffer.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/meson.build |    1 
 cxl/monitor.c   |  140 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 cxl/monitor.c

diff --git a/cxl/meson.build b/cxl/meson.build
index c59876262e76..eb8b2b1070ed 100644
--- a/cxl/meson.build
+++ b/cxl/meson.build
@@ -8,6 +8,7 @@ cxl_src = [
   'json.c',
   'filter.c',
   'event_trace.c',
+  'monitor.c',
 ]
 
 cxl_tool = executable('cxl',
diff --git a/cxl/monitor.c b/cxl/monitor.c
new file mode 100644
index 000000000000..c3f7e3639ec0
--- /dev/null
+++ b/cxl/monitor.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022, Intel Corp. All rights reserved.
+/* Some bits copied from ndctl monitor code */
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <json-c/json.h>
+#include <libgen.h>
+#include <time.h>
+#include <dirent.h>
+#include <ccan/list/list.h>
+#include <util/json.h>
+#include <util/util.h>
+#include <util/parse-options.h>
+#include <util/parse-configs.h>
+#include <util/strbuf.h>
+#include <sys/epoll.h>
+#include <sys/stat.h>
+#include <traceevent/event-parse.h>
+#include <tracefs/tracefs.h>
+#include <cxl/libcxl.h>
+
+/* reuse the core log helpers for the monitor logger */
+#ifndef ENABLE_LOGGING
+#define ENABLE_LOGGING
+#endif
+#ifndef ENABLE_DEBUG
+#define ENABLE_DEBUG
+#endif
+#include <util/log.h>
+
+#include "event_trace.h"
+
+static const char *cxl_system = "cxl";
+
+static struct monitor {
+	struct log_ctx ctx;
+	FILE *log_file;
+	bool human;
+} monitor;
+
+static int monitor_event(struct cxl_ctx *ctx)
+{
+	int fd, epollfd, rc = 0, timeout = -1;
+	struct epoll_event ev, *events;
+	struct tracefs_instance *inst;
+	struct event_ctx ectx;
+	int jflag;
+
+	events = calloc(1, sizeof(struct epoll_event));
+	if (!events) {
+		err(&monitor, "alloc for events error\n");
+		return -ENOMEM;
+	}
+
+	epollfd = epoll_create1(0);
+	if (epollfd == -1) {
+		rc = -errno;
+		err(&monitor, "epoll_create1() error: %d\n", rc);
+		goto epoll_err;
+	}
+
+	inst = tracefs_instance_create("cxl_monitor");
+	if (!inst) {
+		rc = -errno;
+		err(&monitor, "tracefs_instance_create( failed: %d\n", rc);
+		goto inst_err;
+	}
+
+	fd = tracefs_instance_file_open(inst, "trace_pipe", -1);
+	if (fd < 0) {
+		rc = fd;
+		err(&monitor, "tracefs_instance_file_open() err: %d\n", rc);
+		goto inst_file_err;
+	}
+
+	memset(&ev, 0, sizeof(ev));
+	ev.events = EPOLLIN;
+	ev.data.fd = fd;
+
+	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev) != 0) {
+		rc = -errno;
+		err(&monitor, "epoll_ctl() error: %d\n", rc);
+		goto epoll_ctl_err;
+	}
+
+	rc = cxl_event_tracing_enable(inst, cxl_system, NULL);
+	if (rc < 0) {
+		err(&monitor, "cxl_trace_event_enable() failed: %d\n", rc);
+		goto event_en_err;
+	}
+
+	memset(&ectx, 0, sizeof(ectx));
+	ectx.system = cxl_system;
+	if (monitor.human)
+		jflag = JSON_C_TO_STRING_PRETTY;
+	else
+		jflag = JSON_C_TO_STRING_PLAIN;
+
+	while (1) {
+		struct jlist_node *jnode, *next;
+
+		rc = epoll_wait(epollfd, events, 1, timeout);
+		if (rc < 0) {
+			rc = -errno;
+			if (errno != EINTR)
+				err(&monitor, "epoll_wait error: %d\n", -errno);
+			break;
+		}
+
+		list_head_init(&ectx.jlist_head);
+		rc = cxl_parse_events(inst, &ectx);
+		if (rc < 0)
+			goto parse_err;
+
+		if (list_empty(&ectx.jlist_head))
+			continue;
+
+		list_for_each_safe(&ectx.jlist_head, jnode, next, list) {
+			notice(&monitor, "%s\n",
+				json_object_to_json_string_ext(jnode->jobj, jflag));
+			list_del(&jnode->list);
+			json_object_put(jnode->jobj);
+			free(jnode);
+		}
+	}
+
+parse_err:
+	rc = cxl_event_tracing_disable(inst);
+event_en_err:
+epoll_ctl_err:
+	close(fd);
+inst_file_err:
+	tracefs_instance_free(inst);
+inst_err:
+	close(epollfd);
+epoll_err:
+	free(events);
+	return rc;
+}


