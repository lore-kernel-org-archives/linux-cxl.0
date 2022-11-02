Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D55C433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiKBVUa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiKBVUZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:20:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F4DF46
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424022; x=1698960022;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2sZoWCbvQoJP/Dn1B6MyS7w8oq8h9wDt6qUbBWHw4LY=;
  b=fLtBPiJM7UfTZQUUZEpZiIgPCbU8dojSLwqB0vcQLeNycPBRWPKAMKWn
   x+YkC1ZBQrzJSCP0dkuHe7GXNVN06IUIErMUDD6oGJkbhlDYlBxCt0/gl
   cqpwafdnez4tuWSXrdl/TWDJJSN+7s1haFHXR5VqfKl07RycOEtbFkYu8
   MNhLS98N47fBLrTHz74MQq7pVG6cEmxrpDIqqSL2NWvnSG24GuITzCtcw
   BjUQuZie2Nu8kjTit3yJQHG+kBe1PtYCQeKJZHMix9X8SCuL+lrLnZMlW
   +QgB0qyp0oQRX+iitZe6valXilhnRn1bFvlB9gb/CK4INx3QvL0bJAGtL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="310632667"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="310632667"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723705989"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723705989"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:21 -0700
Subject: [PATCH v3 03/10] cxl: add common function to enable event trace
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 02 Nov 2022 14:20:21 -0700
Message-ID: <166742402130.2654617.9308255604215496136.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
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
 cxl/event_trace.c |   21 +++++++++++++++++++++
 cxl/event_trace.h |    1 +
 2 files changed, 22 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index cf63d2346f6e..d59e54c33df6 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -200,3 +200,24 @@ int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx)
 	tep_free(tep);
 	return rc;
 }
+
+int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system)
+{
+	int rc;
+	char *path;
+
+	rc = asprintf(&path, "events/%s/enable", system);
+	if (rc == -1)
+		return -errno;
+
+	rc = tracefs_instance_file_write(inst, path, "1");
+	free(path);
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
index 582882c1eb35..0258b8dc65a3 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -20,5 +20,6 @@ struct event_ctx {
 };
 
 int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
+int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system);
 
 #endif


