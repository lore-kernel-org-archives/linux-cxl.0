Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318C7C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbiAXAwx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:8732 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAwx (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985573; x=1674521573;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=//x4eGYQcOOr3KJKveLHEa+jKASAHR988xPwtn56it8=;
  b=c/F67c+pCdhdlfnxPdF7DjkhsehgdyamtygwcV0bMiErO60DmpJsafyw
   sJFAP3L4OhPiylTyLMNyLzOlfAEmiivS7eGzaq07L72Z9+icDvfm00p4A
   UwJcduMZ9lVnG9YaGP4+X/oixs+IQ9fKtLeXahd1JVBgeTQAHgkE0epr2
   6CPailAK8Djbwt9qC10rBOEEihXA9LEZJk5rFilg0TP7f8Ofwed2bsbze
   D6+pqbZkenuGJMOF6bkJ4CYYdEvQqQxLB06pn4UPRoCS007yoEUMob48a
   7AR1VHSZubIqQ+hBVRnnvVhQmPajoJDhcwrzLGqJEV0931nWfcJYmC+gy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332290525"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332290525"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="519735780"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:52 -0800
Subject: [ndctl PATCH 12/37] cxl/list: Cleanup options definitions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:52 -0800
Message-ID: <164298557263.3021641.8121105326167408001.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Clarify which options take lists by adding a "(s)" to the object name, and
move the option block out of cmd_list() to reduce the column-80 collisions.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/list.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/cxl/list.c b/cxl/list.c
index 6bc48df0ea84..7e2744dd8b19 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -19,22 +19,24 @@ static int num_list_flags(void)
 	return param.memdevs;
 }
 
+static const struct option options[] = {
+	OPT_STRING('m', "memdev", &param.memdev_filter, "memory device name(s)",
+		   "filter by CXL memory device name(s)"),
+	OPT_STRING('s', "serial", &param.serial_filter,
+		   "memory device serial(s)",
+		   "filter by CXL memory device serial number(s)"),
+	OPT_BOOLEAN('M', "memdevs", &param.memdevs,
+		    "include CXL memory device info"),
+	OPT_BOOLEAN('i', "idle", &param.idle, "include disabled devices"),
+	OPT_BOOLEAN('u', "human", &param.human,
+		    "use human friendly number formats "),
+	OPT_BOOLEAN('H', "health", &param.health,
+		    "include memory device health information "),
+	OPT_END(),
+};
+
 int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 {
-	const struct option options[] = {
-		OPT_STRING('m', "memdev", &param.memdev_filter, "memory device name",
-			   "filter by CXL memory device name"),
-		OPT_STRING('s', "serial", &param.serial_filter, "memory device serial",
-			   "filter by CXL memory device serial number"),
-		OPT_BOOLEAN('M', "memdevs", &param.memdevs,
-			    "include CXL memory device info"),
-		OPT_BOOLEAN('i', "idle", &param.idle, "include disabled devices"),
-		OPT_BOOLEAN('u', "human", &param.human,
-				"use human friendly number formats "),
-		OPT_BOOLEAN('H', "health", &param.health,
-				"include memory device health information "),
-		OPT_END(),
-	};
 	const char * const u[] = {
 		"cxl list [<options>]",
 		NULL

