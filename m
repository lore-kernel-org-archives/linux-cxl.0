Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC8EC6FA8B
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Sep 2022 23:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiISXrV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiISXrQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Sep 2022 19:47:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5673850048
        for <linux-cxl@vger.kernel.org>; Mon, 19 Sep 2022 16:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663631232; x=1695167232;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnODmAgjnYx1nHlyVa13SsuAKaF4YhWKWtpWXZgWLj8=;
  b=WPvCLHtsCN0Pe0xA7sI8styN+Jib0837MQE/G0sjF5I1zDSqknrAcRSD
   mtzYXvNuXPJwe+RTfsgMzUYGDbqe69Tm0EOPBwu86V5DS8ou+s4HYElQA
   MAP+kJ5eoE2L1UIBC8oUOMFNZ1HFHUpot8yhWqcV/JJRp56BXPdKuPACq
   YNWUGt294CnqwBUtx15Bqh3OfPUtfQucgJXJA/6zOH1C9EehPAYviIJHh
   VmAFqE3nHsQrBZeOoBwQgmthrkmp9Fp9aLNZriTroIT/zYzkZD4DXMx+H
   DFQFs0IATJbQpPVavwMHI28drW/S1hDka2iV3d4E/KZUMpne4Qvwn3/AX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279932288"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="279932288"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 16:47:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="618690539"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 16:47:09 -0700
Subject: [PATCH v2 6/9] cxl: add logging functions for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        nafonten@amd.com, nvdimm@lists.linux.dev
Date:   Mon, 19 Sep 2022 16:47:09 -0700
Message-ID: <166363122964.3861186.7714736198829346130.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com>
References: <166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Duplicate log functions from ndctl/monitor to use for stdout and file
logging.

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
---
 cxl/monitor.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/cxl/monitor.c b/cxl/monitor.c
index 759246926e05..c241ed31584f 100644
--- a/cxl/monitor.c
+++ b/cxl/monitor.c
@@ -39,6 +39,31 @@ static struct monitor {
 	bool human;
 } monitor;
 
+static void log_standard(struct log_ctx *ctx, int priority, const char *file,
+		int line, const char *fn, const char *format, va_list args)
+{
+	if (priority == 6)
+		vfprintf(stdout, format, args);
+	else
+		vfprintf(stderr, format, args);
+}
+
+static void log_file(struct log_ctx *ctx, int priority, const char *file,
+		int line, const char *fn, const char *format, va_list args)
+{
+	FILE *f = monitor.log_file;
+
+	if (priority != LOG_NOTICE) {
+		struct timespec ts;
+
+		clock_gettime(CLOCK_REALTIME, &ts);
+		fprintf(f, "[%10ld.%09ld] [%d] ", ts.tv_sec, ts.tv_nsec, getpid());
+	}
+
+	vfprintf(f, format, args);
+	fflush(f);
+}
+
 static int monitor_event(struct cxl_ctx *ctx)
 {
 	int fd, epollfd, rc = 0, timeout = -1;


