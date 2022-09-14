Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D105ECAAD3
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Sep 2022 20:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiINUsJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Sep 2022 16:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiINUsI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Sep 2022 16:48:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0772F6AA25
        for <linux-cxl@vger.kernel.org>; Wed, 14 Sep 2022 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663188488; x=1694724488;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ei9H7tMIrz+qBeCy4wxIj4jWlpbcQf9Wmr1EXirsk74=;
  b=X9ou+trmnTFLmij9BLKsolCm5YOECFaB9HRh1/p9EAvFlirQFT45ME5W
   t2uKXxC9J1CGaGjPC2AxuaS4MV7rOF+rgti1NCtWMu7heSFKaFEX17Yb6
   rGkzZSz6Bw4A6YmIuG7JIYLSad4LTzyhXGXGgnZQ+OCVNnUNTmBnhqOCx
   e792FV6rE6YF/EyGGVb/nnUY6uUSfjHLSZ37nSMT4zEYwkqlF0evnK7kP
   GmuPI8HmbC2RqZc+zPU4aPEFwAgk+twQJEjGe9/yECIhZ/Zmi7qzjT8Ka
   qA1goB4B31irC8SMnTLZxkCq0owii308NirVSksl0V1fRJ3uLeanAsIhN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="281570322"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="281570322"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:48:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="720719115"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:48:07 -0700
Subject: [PATCH 3/7] ndctl: cxl: add common function to enable event trace
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Date:   Wed, 14 Sep 2022 13:48:06 -0700
Message-ID: <166318848691.3087953.726606131511690601.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
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
 cxl/event_trace.c |   27 +++++++++++++++++++++++++++
 cxl/event_trace.h |    1 +
 2 files changed, 28 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index d5e67b55a4d8..39ca5a9c49be 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -199,3 +199,30 @@ int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx)
 	tep_free(tep);
 	return rc;
 }
+
+int cxl_event_tracing_enable(struct tracefs_instance *inst, const char **systems)
+{
+	int rc, i, en_count = 0;
+
+	for (i = 0; systems[i]; i++) {
+		char *path;
+
+		rc = asprintf(&path, "events/%s/enable", systems[i]);
+		if (rc == -1)
+			continue;
+		rc = tracefs_instance_file_write(inst, path, "1");
+		free(path);
+		if (rc == -1)
+			continue;
+		en_count++;
+	}
+
+	if (!en_count)
+		return -ENOENT;
+
+	if (tracefs_trace_is_on(inst))
+		return 0;
+
+	tracefs_trace_on(inst);
+	return 0;
+}
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index 98cfbb4602e1..b4453c393e7a 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -17,5 +17,6 @@ struct event_ctx {
 };
 
 int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
+int cxl_event_tracing_enable(struct tracefs_instance *inst, const char **systems);
 
 #endif


