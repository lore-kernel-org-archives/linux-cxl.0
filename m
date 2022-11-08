Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAC0C433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKHSaI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKHSaH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:30:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F7C26CF
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932206; x=1699468206;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKg83VT9VshQ06FCtL9b/WzizLNhG1qurjA4Zy0CMBM=;
  b=JuK+mppiWk5u9X8ErcPZepkOC0YDlMJdP+mEsFQIQMT7NLBPLoH5a3AF
   QHKtQz+R/+Igry5pqOn/B55J7K2hIvWEBDKqY+MYKa5IVg5u+/Y4YgOSp
   J4M+ohoi48KlGddqptJ2SBEIKxyIWWFGhxcN5any8x2UVtEwHY7UqQUHV
   Xayagon1UHIYRnrMkI5AxuoZVkmekTMLb5VScJyuSLbmrDCPbC4jo/xXk
   UiUhaCZSKClOGoHi0s/PdUusL4iPXb8HpMFMb7P2S102jUXki0PtyUjqB
   jgI0V8pz3muH0gDlrRwuwR2q64ocYIJ0ttDx2R22f5fRINLMbIWJSbKT1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290491175"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="290491175"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669650060"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669650060"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:05 -0800
Subject: [PATCH v4 03/10] cxl: add common function to enable event trace
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:30:05 -0700
Message-ID: <166793220535.3768752.9190750068767610122.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a common function for cxl command to enable event tracing for the
instance created. The interested "systems" will be enabled for tracing
as well.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/event_trace.c |   16 ++++++++++++++++
 cxl/event_trace.h |    2 ++
 2 files changed, 18 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index 4667044e4a66..95b0ce071166 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -235,3 +235,19 @@ int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx)
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
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index 582882c1eb35..aecf9aa96187 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -20,5 +20,7 @@ struct event_ctx {
 };
 
 int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
+int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system,
+		const char *event);
 
 #endif


