Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E8EC4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiKHSah (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKHSag (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:30:36 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1353F05E
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932235; x=1699468235;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Av6IyuHvGJr8brfWMPwuS8wabZmI7DOSQJTHBSYC2l0=;
  b=XRBFkobl2K4mbiUfw68JMlfVn/JSwxDOw3VEQ4xY02VWWytCT3bbjSq0
   z1TcSMW0LK0SgnedhN6IO7ZOj/P0AljU+ywjUNuNjKah0stBtL6SNf7d/
   7jUHEln9lEszL4oklcr8LjJgxj00f0y3NFl7H5WqllRrQXhcb0yBVCk9a
   r7tbDZrTfnex7RJDEKrbmvZknw7gEh9oK4+UUHpp/T5nMoI+cb1W1l1ca
   BZdSE3+oU6QdUtWdJeyJhnXY96o9KNOzQ0X1IHrBZrerRp4spAW5TZwrF
   MA9W8dLju8i4tl+r/5Y6sGdZDRy/ApxI14UwCgHqUr5pQZw6HSsl0c7rm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="294143783"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="294143783"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="705400144"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="705400144"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:34 -0800
Subject: [PATCH v4 08/10] cxl: add an optional pid check to event parsing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:30:34 -0700
Message-ID: <166793223408.3768752.4466685754838805704.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When parsing CXL events, callers may only be interested in events
that originate from the current process. Introduce an optional
argument to the event trace context: event_pid. When event_pid is
present, only include events with a matching pid in the returned
JSON list. It is not a failure to see other, non matching results.
Simply skip those.

The initial use case for this is the listing of media errors,
where only the media-errors requested by this process are wanted.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/event_trace.c |    5 +++++
 cxl/event_trace.h |    1 +
 2 files changed, 6 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index 490c30e1dbfc..89c9c2db26a3 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -215,6 +215,11 @@ static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record
 			return 0;
 	}
 
+	if (event_ctx->event_pid) {
+		if (event_ctx->event_pid != tep_data_pid(event->tep, record))
+			return 0;
+	}
+
 	if (event_ctx->parse_event)
 		return event_ctx->parse_event(event, record, &event_ctx->jlist_head);
 
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index 89e98cafb320..e72b4347175e 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -15,6 +15,7 @@ struct event_ctx {
 	const char *system;
 	struct list_head jlist_head;
 	const char *event_name;					/* optional */
+	int event_pid;						/* optional */
 	int (*parse_event)(struct tep_event *event, struct tep_record *record,
 			   struct list_head *jlist_head);	/* optional */
 };


