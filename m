Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B45EC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Nov 2022 00:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiKJAHs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiKJAHr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Nov 2022 19:07:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0BF1EEEE
        for <linux-cxl@vger.kernel.org>; Wed,  9 Nov 2022 16:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668038867; x=1699574867;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ehcg6U+XkUNEWruYQ06r5bcfAbWgr36pgmxI+ZpPk9M=;
  b=Z7501CheK0EwNm8kRQkfA0A326/lSL5xpOzNbuacf673EcrL4jLeMR2J
   strmqdwjdE4M8659Xc236RXggDl/RM2OBXYFnfycOysijApvekrVFoACz
   GiLDVwqxe6qD/ExKyO7mV5iJ/OhyipXWdO8uEbU4EtcK+tI6cbKrhet0O
   9O3Uc2ghYdMAlWObefkqr7EvuSjoS804cCPEADLVam1g14HzvjcZwiqVG
   4K2fU16ZvBe56D+9TJ6ttpxIabhV14NYDbzEqfS7VhC9LGFS6WSDjUPz9
   Hvu23gI1CIMtWhwzsJ2pwHGb3FADoTM0d3v1fioACbqMgKzEq/YBPUNtG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312287935"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="312287935"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:07:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="631442549"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="631442549"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:07:46 -0800
Subject: [PATCH v5 3/7] ndctl: cxl: add common function to enable/disable
 event trace
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 09 Nov 2022 17:07:45 -0700
Message-ID: <166803886584.145141.15515518810880150458.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
References: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a common function for cxl command to enable and disable event
tracing for the instance created. Will only enable "cxl" system.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/event_trace.c |   21 +++++++++++++++++++++
 cxl/event_trace.h |    3 +++
 2 files changed, 24 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index d7bbd3cf4946..a973a1f62d35 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -228,3 +228,24 @@ int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx)
 	tep_free(tep);
 	return rc;
 }
+
+int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system,
+		const char *event)
+{
+	int rc;
+
+	rc = tracefs_event_enable(inst, system, event);
+	if (rc == -1)
+		return -errno;
+
+	if (tracefs_trace_is_on(inst))
+		return 0;
+
+	tracefs_trace_on(inst);
+	return 0;
+}
+
+int cxl_event_tracing_disable(struct tracefs_instance *inst)
+{
+	return tracefs_trace_off(inst);
+}
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index e83737de0ad5..ec6267202c8b 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -20,5 +20,8 @@ struct event_ctx {
 };
 
 int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
+int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system,
+		const char *event);
+int cxl_event_tracing_disable(struct tracefs_instance *inst);
 
 #endif


