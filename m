Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95396C6FA82
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Sep 2022 20:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiINUs0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Sep 2022 16:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiINUs0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Sep 2022 16:48:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7EA6C752
        for <linux-cxl@vger.kernel.org>; Wed, 14 Sep 2022 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663188505; x=1694724505;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+O0ELCZLuUf6nwv6swT3F6dH4yOXGMoTMRu8Sm+IUmQ=;
  b=IxZtoqXdf+5eEUIhu1d3NPiOXlHBiCSEXR8rm27bjjs0udEW8L1tRFYH
   wlJJG1wEob7FBvgwwcTS+o+BUX8bbdH7TmgFuVICsfZuzSIM6KB0+x/JW
   dAlDvKC0ZrkVNHCq9xfe5ufdJi3sS+P0+EnINSYO//rSTxMzH0SIDFuXm
   tf6ofx7Q05SHU8bRR+ChVzhe+0wwVQ8WrZJ5SDvD1s29gSw0peOUh0KzM
   3rFE+1fp0sl8wRxAetAtSP1gxjxJIKkmlMofeRPXWlLrRhBEBLhWmGmli
   Pi2Y5XYcipHCex3FMYAi3h3ImHUD2cFoDpRFEVxtJev36jVaW4aP1M0k8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278266160"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278266160"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:48:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="594538625"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:48:24 -0700
Subject: [PATCH 6/7] ndctl: cxl: add logging functions for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Date:   Wed, 14 Sep 2022 13:48:24 -0700
Message-ID: <166318850459.3087953.851045527272435004.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
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
 cxl/monitor.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/cxl/monitor.c b/cxl/monitor.c
index 2ab2e249f575..e030542a3fe8 100644
--- a/cxl/monitor.c
+++ b/cxl/monitor.c
@@ -39,6 +39,32 @@ static struct monitor {
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
+		vfprintf(f, format, args);
+	} else
+		vfprintf(f, format, args);
+
+	fflush(f);
+}
+
 static int monitor_event(struct cxl_ctx *ctx)
 {
 	int fd, epollfd, rc = 0, timeout = -1;


