Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B78C433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKBVVH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiKBVVD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:21:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC25DE90
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424062; x=1698960062;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KSFZB3ntka+bSSvolTA/Uf4WdX3s1HtcDYCRMCLVZIU=;
  b=Zhpi2uJLGfXj0ozfQ09ttgWrPQFBK2DURyJigWUYR9c72bgPv3N5oDi5
   m8v6F0l9O5zqz+q3Y259Tb9NihzNB1aIwiniXdyYBiehA7OqtKC2IkaSL
   V0SyTru4rSwSVPe0A0t+L9Bztyr9/yXZtYM5s0/jtEFBqqskhPZrX8KYr
   Bls19gHZ3pAbaS1F3uwE6PGN9ZgzQ9ydwgX9deIf47LIbcNllvIY+ujK9
   BjgnMCmO8eVxLrbbHj29taO7pgc0NGq6oJ6YkNc64brN5a0f+s/KPHT3P
   B3SCaT3f8AGAqr/Fvt907L4QJvNaUX8/GdcFDynr0nv0erIqu332Iw7Lg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="395830873"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="395830873"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:21:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="634418752"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="634418752"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:21:01 -0700
Subject: [PATCH v3 10/10] cxl: add man page documentation for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 02 Nov 2022 14:21:01 -0700
Message-ID: <166742406119.2654617.6459404446929986268.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add man page documentation to explain the usage of cxl monitor.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/cxl/cxl-monitor.txt |   77 +++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/cxl/cxl-monitor.txt

diff --git a/Documentation/cxl/cxl-monitor.txt b/Documentation/cxl/cxl-monitor.txt
new file mode 100644
index 000000000000..43c2ece72220
--- /dev/null
+++ b/Documentation/cxl/cxl-monitor.txt
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-monitor(1)
+================
+
+NAME
+----
+cxl-monitor - Monitor the CXL kernel trace events
+
+SYNOPSIS
+--------
+[verse]
+'cxl monitor' [<options>]
+
+DESCRIPTION
+-----------
+Cxl monitor is used for monitoring the CXL trace events emitted by
+the kernel and convert them to json objects and dumping the json format
+notifications to standard output or a logfile.
+
+Both, the values in configuration file and in options will work. If
+there is a conflict, the values in options will override the values in
+the configuration file. Any updated values in the configuration file will
+take effect only after the monitor process is restarted.
+
+EXAMPLES
+--------
+
+Run a monitor as a daemon to monitor events and output to a log file.
+[verse]
+cxl monitor --daemon --log=/var/log/cxl-monitor.log
+
+Run a monitor as a one-shot command and output the notifications to stdio.
+[verse]
+cxl monitor
+
+Run a monitor daemon as a system service
+[verse]
+systemctl start cxl-monitor.service
+
+OPTIONS
+-------
+-l::
+--log=::
+	Send log messages to the specified destination.
+	- "<file>":
+	  Send log messages to specified <file>. When fopen() is not able
+	  to open <file>, log messages will be forwarded to syslog.
+	- "standard":
+	  Send messages to standard output.
+
+The default log destination is '/var/log/cxl-monitor.log' if "--daemon" is specified,
+otherwise 'standard'. Note that standard and relative path for <file>
+will not work if "--daemon" is specified.
+
+--daemon::
+	Run a monitor as a daemon.
+
+-u::
+--human::
+	Output monitor notification as human friendly json format instead
+	of the default machine friendly json format.
+
+-v::
+--verbose::
+	Emit extra debug messages to log.
+
+COPYRIGHT
+---------
+Copyright (c) 2022, Intel Corp. License GPLv2: GNU GPL version 2
+<http://gnu.org/licenses/gpl.html>. This is free software: you are
+free to change and redistribute it. There is NO WARRANTY, to the
+extent permitted by law.
+
+SEE ALSO
+--------
+linkcxl:cxl-list[1]


