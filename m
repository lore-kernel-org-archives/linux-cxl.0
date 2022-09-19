Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19854C6FA8B
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Sep 2022 23:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiISXqy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiISXqx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Sep 2022 19:46:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CD94F643
        for <linux-cxl@vger.kernel.org>; Mon, 19 Sep 2022 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663631212; x=1695167212;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zRvCCQdFMS8gRXk3Cb3ubH4bqvKv8FV3o8BZZcD+tqc=;
  b=CHo2LeYZOwguBvzBGiC3aaXSz1dGs6RdaX3zzKV/pfIR43baFvux+sZ5
   dD8nECExuTgv+4Juhlkv+G9bsUVhSTCoohWnOaoRHjosbuenkC9tReo4c
   pPLHRVwVSSJYnOtEF3nUFsLgf6CRJCJg6dikXwoGfAKLyU2o86IFPUAv3
   TAIQKV/X4+2hDTYrij9BCcrcSeHMLNH7VNlLIOSTvo7MTlE84kGuyd3Rc
   4zI2nCTEl3fmuW5vTbULHHB9IIRvtl/vjRsHPUqXtpPDsC9XFavvHPMEw
   nKAUAqrESj3aLg++uGQWKPdCYkAKy0QD58q6nw78gl72qoxCzOMrRdX07
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279278291"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="279278291"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 16:46:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="722504592"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 16:46:51 -0700
Subject: [PATCH v2 3/9] cxl: add common function to enable event trace
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        nafonten@amd.com, nvdimm@lists.linux.dev
Date:   Mon, 19 Sep 2022 16:46:51 -0700
Message-ID: <166363121162.3861186.4784558227642526260.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com>
References: <166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com>
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
index 430146ce66f5..ca2fb94f2eba 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -197,3 +197,24 @@ int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx)
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
index 2fbefa1586d9..1fb905664625 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -17,5 +17,6 @@ struct event_ctx {
 };
 
 int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
+int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system);
 
 #endif


