Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C2C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKBVUm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiKBVUl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:20:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9879155A6
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424040; x=1698960040;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8VrrOGl+4QbdLBn+FsTqIFMHjX9ebTMDn5JxQ+Eqrdo=;
  b=SRqhWnYJNjsHkrIQxwjDk0sVnNbzTbhTwNPdzyY2kV1vKVT8+/F9Eaku
   s8icMZXCmG8N1UCS7esqoanHYFkLFFjAcreAez/fcguFvdsnGCM/8mRoi
   rNt5NWevhF0z8ihK3WgbpoQEhIS0fH32z3vPc3CSywVubgLJmt+0OAeAi
   2HNqrIxZGCX4UCCy9QDhtFCGWXu0s/37KJwuIBgSlqt0ZJqcPiyRF2BqF
   Ry1Z3kYfqBjoE/MvwTymqcR9vkKuasfUQ3MoYO6NkGP/vZeauDlmp4sGX
   2gz0iBkRAp9N4NBeo44LdlRLs27CDYPt89XIho0Af8dmO+BalSiPhDa3s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="292840181"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="292840181"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723706056"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723706056"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:38 -0700
Subject: [PATCH v3 06/10] cxl: add logging functions for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 02 Nov 2022 14:20:38 -0700
Message-ID: <166742403814.2654617.14718739161494839655.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
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
index 85559d9a4b94..9af12954b89b 100644
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


