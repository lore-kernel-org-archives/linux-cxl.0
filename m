Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DB0C6FA82
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Sep 2022 20:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiINUsP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Sep 2022 16:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiINUsO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Sep 2022 16:48:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1416BD62
        for <linux-cxl@vger.kernel.org>; Wed, 14 Sep 2022 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663188494; x=1694724494;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qqFd9z0Ay6h2dsUpWd6B4jHhDdYbPVJj/DQK6umx3Vg=;
  b=C4le4Ewxvl3tBp9R9/qfKb+GkGg3/O/vTBvsVjucRF+M5kZiKhRAvfAw
   C8vp4UMtpueiokIM+vkKwVlgapXRB3ec8+/A7iS8KWMQlthiZP8CHm4+5
   E36vx4trazG69c7DqNOqM2DkPMnOYTEvW2Z0wD39vHSFMpQIIlyuYjjaJ
   axUz8tmLFZF0h3n+x9IQllTg+627ane4oYfzL6pEwa0NZN/sN5ul1dJPM
   7FhLJcxPYr5N/LYRRPzgPxVWTeqX2yo9qXcnwnlm/8a3Qu3UX6XGH8Q0F
   2qoptpO60/eQPeAyNljYRsBYcuAA3dG/IDnjGrWr3dn0aH+4c6RW/4T3N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="297266817"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="297266817"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:48:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="617007441"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:48:13 -0700
Subject: [PATCH 4/7] ndctl: cxl: add common function to disable event trace
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Date:   Wed, 14 Sep 2022 13:48:12 -0700
Message-ID: <166318849259.3087953.6822321103087684015.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
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
index 39ca5a9c49be..50f9cc428aa7 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -226,3 +226,11 @@ int cxl_event_tracing_enable(struct tracefs_instance *inst, const char **systems
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
index b4453c393e7a..9931fb32b245 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -18,5 +18,6 @@ struct event_ctx {
 
 int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
 int cxl_event_tracing_enable(struct tracefs_instance *inst, const char **systems);
+int cxl_event_tracing_disable(struct tracefs_instance *inst);
 
 #endif


