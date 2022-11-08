Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2BBC43217
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiKHSaZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKHSaY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:30:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D811F117D
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932223; x=1699468223;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T+RwdEaG7CAzsk3DbJ08hToav07BCFc/S567d0iVkG4=;
  b=gAB4SNG60AZApiiOZtu1zmKxldolnpOE9oF8Y1dTkqa8oxMdNbmfZ0At
   IBfz8qfCHRIVw0NFkssgK6wd6geUdS6NXk981aV2xAVbwgeD351IX5Zmh
   RkNhSvW272jDWi8QyI95iHDCfhQg5ORsazNhDQiWEBIQvwedExxbUmyHM
   r6sI9ZsOOr2/+/OdSfcIqZtbpym8TP/rzam4faSQVEiLUN60GcvhenCgG
   osW10y7ZJ1YmqNNEM/7lTFFpXV8Zdi9Y9pQBl7ZeiiD4OF7k78x4SsQtG
   /oDmZy3/1Zuyr+Efwd9zIMkF2SoU0Jfy1WLWNVkh0BPq63UXpnZB3i4xe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="375046171"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="375046171"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="705400091"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="705400091"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:23 -0800
Subject: [PATCH v4 06/10] cxl: add logging functions for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:30:22 -0700
Message-ID: <166793222281.3768752.3333516400569686550.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
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
index c3f7e3639ec0..518d8142e40d 100644
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


