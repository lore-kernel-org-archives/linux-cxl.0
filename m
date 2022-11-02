Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ACCC4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKBVUb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiKBVU3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:20:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E015BCDE
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424027; x=1698960027;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FYl96AYa+9mYcRrueQWjxARr3cCfb7hrf8pGn5DMCMg=;
  b=dtlgXzFXLmLW/SR7ZeEs87xNzsTXkT4jpGVa8+T3f51T5xBI0ADJEcpa
   oVzNoNWcSW/jimnK/Qged+Z1coyBKaQd5ThhqjYXQtHVtyPEUezrciq2I
   /Uxd9xHndNIbfxLxadGphJXQoh+jq74UJYnjBBeTLWnDfGtrkf9HXPoqs
   vy+JG/5b4X1VhXqfdnu+Of1HE9U0rXwrmPGDM0Ni6ED6KbTcfxkRvdUb7
   1NEnriu3J26tF5VV3oyhvxZ3UAlOymgocb9xkKgiHHEQcPb8SUgaFZN2L
   KjETQJaxaMXTB+piqhwkJln/MxaIoqjPAomKWXvQznkaT7432+G+1yMcw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="309520488"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="309520488"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723706012"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723706012"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:27 -0700
Subject: [PATCH v3 04/10] cxl: add common function to disable event trace
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 02 Nov 2022 14:20:26 -0700
Message-ID: <166742402697.2654617.15955710715103932892.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a common function for cxl command that disables the event trace for the
instance created.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/event_trace.c |    8 ++++++++
 cxl/event_trace.h |    1 +
 2 files changed, 9 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index d59e54c33df6..bcd4f8b2968e 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -221,3 +221,11 @@ int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system)
 	tracefs_trace_on(inst);
 	return 0;
 }
+
+int cxl_event_tracing_disable(struct tracefs_instance *inst)
+{
+	if (!tracefs_trace_is_on(inst))
+		return 0;
+
+	return tracefs_trace_off(inst);
+}
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index 0258b8dc65a3..17d922f922c1 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -21,5 +21,6 @@ struct event_ctx {
 
 int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
 int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system);
+int cxl_event_tracing_disable(struct tracefs_instance *inst);
 
 #endif


