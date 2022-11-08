Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C8EC4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiKHSaO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKHSaN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:30:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3B26CF
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932212; x=1699468212;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EzEGlRQ6ptosn4px7u15Y1lZqnWs1uJ4iJuKGMoeyPY=;
  b=IghMAkiS46UrOaG27tYeuQsQyCgl4rzcTVv4A0V4yNK9xdF09j6OvW1R
   lheK/EuA/6BqPbRt+PJU45UEye4UQc9mzzfe7P1tj80jc+EBMA4HdGyq5
   12AzFLj6ZkqFH6XdpRv5BtFVtFPEpkDbDqtktJRQhhL/mtqX1R4A3G74j
   huJt74jk2/tZyio3b7mhciXfJcDFUnuTMn2/UON+dRrJTFpqgpW65J6+K
   SSj9QbDAMivZ/WIbmTXsRrzD4LWveGgbXoCjKmLKKiqV0WUuCUdkZAX6i
   bwxo1gShOQRQME3kUca8bAEXGflfzQKZEaPaHpBQc5dbJsbqOJLfmu331
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309480428"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="309480428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669650095"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669650095"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:11 -0800
Subject: [PATCH v4 04/10] cxl: add common function to disable event trace
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:30:11 -0700
Message-ID: <166793221113.3768752.2422093575535918509.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
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
 cxl/event_trace.c |    5 +++++
 cxl/event_trace.h |    1 +
 2 files changed, 6 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index 95b0ce071166..490c30e1dbfc 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -251,3 +251,8 @@ int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system,
 	tracefs_trace_on(inst);
 	return 0;
 }
+
+int cxl_event_tracing_disable(struct tracefs_instance *inst)
+{
+	return tracefs_trace_off(inst);
+}
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index aecf9aa96187..89e98cafb320 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -22,5 +22,6 @@ struct event_ctx {
 int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
 int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system,
 		const char *event);
+int cxl_event_tracing_disable(struct tracefs_instance *inst);
 
 #endif


