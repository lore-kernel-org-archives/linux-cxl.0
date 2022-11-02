Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B0C4167B
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiKBVUx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiKBVUw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:20:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B83304
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424051; x=1698960051;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFZz3s5lVB+WMwojI4suQOcAX4/k0VRJ3nMKn5GhhaU=;
  b=Hw/d3XKa89rHeQGrX/cUDYd0uzK6daYvutjfhFOyVlXKuhvnzlzl7iY5
   s4P924VJdyy7UEDTNyoE48/NIppq0jmecw3AsUn/4Fw+0GgLLnQ5hLZsd
   IiStYUKUvh4iCIomLoVfUOTPOxFTojOkPwsYfnT5YyM7QtdcTB1dKvATN
   hsj7ky7NRwBLMsSj61AABG6YLhmsxFXg4jLwEP/UvZkpGRb6d7KgGPyGG
   kjQ+bm5nHkD7X0iPa0nLuyjq79b5Kc+Jk4PCqPIDaUBDfM08HIzfqQ6s5
   0g8ZeTRk8+gw6Yejt8GTh6IOum4xCEdR8gk/12BpB88JADKkLjqg9UqRH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="395830838"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="395830838"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="634418704"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="634418704"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:49 -0700
Subject: [PATCH v3 08/10] cxl: add an optional pid check to event parsing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 02 Nov 2022 14:20:49 -0700
Message-ID: <166742404957.2654617.13465219167688999810.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
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
 cxl/event_trace.c |   18 ++++++++++++++++++
 cxl/event_trace.h |    1 +
 2 files changed, 19 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index bcd4f8b2968e..0be6317e6ada 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -166,6 +166,19 @@ err_jevent:
 	return rc;
 }
 
+static bool cxl_match_pid(struct tep_event *event, struct tep_record *record,
+			  int pid)
+{
+	unsigned long long val;
+
+	if (tep_get_common_field_val(NULL, event, "common_pid", record, &val, 0))
+		return false;
+	if (pid != (int)val)
+		return false;
+
+	return true;
+}
+
 static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record,
 		int cpu, void *ctx)
 {
@@ -180,6 +193,11 @@ static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record
 			return 0;
 	}
 
+	if (event_ctx->event_pid) {
+		if (!cxl_match_pid(event, record, event_ctx->event_pid))
+			return 0;
+	}
+
 	if (event_ctx->parse_event)
 		return event_ctx->parse_event(event, record, &event_ctx->jlist_head);
 
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index 17d922f922c1..64f07854b91b 100644
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


