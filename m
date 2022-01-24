Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8BCC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiAXAxY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:53:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:60764 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240660AbiAXAxY (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985604; x=1674521604;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T1lh8ubpQiuAYkDDTGax+rdEW8mXy9dtFolAomjgM3U=;
  b=N/TCeTFtOevntlbSrTJh1NKFV7ln55qrhFhAg7WWeM/g9C776mf8kOZp
   jwrgG20lco197Ce4LkVxJ6kpCIpQjIBVrOjaHzjqJAwj+pyz/WXvVoKwa
   r+YBtLx1/efyHpqBr2NYD5eR6ZXvMPe5PC7iS1iueIUXgJHBAguRkWGDI
   MxtOblLJxll7FwlIl8biaoJcr1aTNihHr9XS78qvvACn5dcJtQzHxG8ma
   XuRxPstAk2kqBRnI1ABYoG2aR1REFe/Sr2JN3Tsjt8xXUHGvElc/1bpYi
   +quhrOiWC6wud+sHfD8qHV54tUwir7Vq/5ZuB+KP59MduAeK7XV9lipPx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270370012"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270370012"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695243441"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:24 -0800
Subject: [ndctl PATCH 18/37] cxl/list: Add --debug option
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:53:24 -0800
Message-ID: <164298560409.3021641.11040422738199381922.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add an option to turn on libray and cxl_filter_walk() messages. Gate it
based on the global ENABLE_DEBUG configuration setting.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-list.txt |    6 ++++--
 cxl/filter.c                   |    3 +++
 cxl/list.c                     |    9 +++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 3076deb43b9e..42b6de6e5c61 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -200,9 +200,11 @@ OPTIONS
 	descendants of the individual ports that match the filter. By default
 	all descendant objects are listed.
 
-include::human-option.txt[]
+--debug::
+	If the cxl tool was built with debug enabled, turn on debug
+	messages.
 
-include::verbose-option.txt[]
+include::human-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/cxl/filter.c b/cxl/filter.c
index 8b79db3dae8d..32171a47e8d5 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -387,6 +387,7 @@ int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *p)
 	if (!jports)
 		goto err;
 
+	dbg(p, "walk memdevs\n");
 	cxl_memdev_foreach(ctx, memdev) {
 		struct json_object *jdev;
 
@@ -403,6 +404,7 @@ int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *p)
 		}
 	}
 
+	dbg(p, "walk buses\n");
 	cxl_bus_foreach(ctx, bus) {
 		struct json_object *jbus = NULL;
 		struct json_object *jchildports = NULL;
@@ -431,6 +433,7 @@ int cxl_filter_walk(struct cxl_ctx *ctx, struct cxl_filter_params *p)
 			}
 		}
 walk_children:
+		dbg(p, "walk ports\n");
 		walk_child_ports(port, p, pick_array(jchildports, jports),
 				 flags);
 		cond_add_put_array_suffix(jbus, "ports", devname, jchildports);
diff --git a/cxl/list.c b/cxl/list.c
index 1ef91b44dca1..01ab19bff706 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -13,6 +13,7 @@
 #include "filter.h"
 
 static struct cxl_filter_params param;
+static bool debug;
 
 static const struct option options[] = {
 	OPT_STRING('m', "memdev", &param.memdev_filter, "memory device name(s)",
@@ -35,6 +36,9 @@ static const struct option options[] = {
 		    "use human friendly number formats "),
 	OPT_BOOLEAN('H', "health", &param.health,
 		    "include memory device health information "),
+#ifdef ENABLE_DEBUG
+	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
+#endif
 	OPT_END(),
 };
 
@@ -84,9 +88,14 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 	}
 
 	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
+	if (debug) {
+		cxl_set_log_priority(ctx, LOG_DEBUG);
+		param.ctx.log_priority = LOG_DEBUG;
+	}
 
 	if (cxl_filter_has(param.port_filter, "root") && param.ports)
 		param.buses = true;
 
+	dbg(&param, "walk topology\n");
 	return cxl_filter_walk(ctx, &param);
 }

