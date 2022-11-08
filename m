Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AE1C4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKHSav (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKHSas (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:30:48 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E0554B36
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932246; x=1699468246;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KSFZB3ntka+bSSvolTA/Uf4WdX3s1HtcDYCRMCLVZIU=;
  b=TeR/hs7NFTVdD0boDbenxfRwDQskdjyQzBfLXyIv65hUeU+BFFpCB0xt
   mzZu9HcKaMDSXP991u9RkfC9J5ie3qHv3VyIPoVhsAOSvyc9Y77bN4BTp
   JyCq7MX0JW7osii3iZrmDsNvWc8Q4f3cBfIGIZBDR/xrEmgfJItfTxpyg
   YM+nDbkYJO4g2P2+yQB9LwofyAwv89aVtimefmo7k66hBHhb3F5sKgpCw
   oKU/6jB61PB8E5vKVo7o2wyrhOUv2r67el3+04upaOQHvlG9MKRHFVDHd
   xOF1oMCd0EsEKOKYtxAqOzIDWT2MfuiJo/6MG3P5lQTMCxYPCmkPwfq1J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="375046233"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="375046233"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="705400251"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="705400251"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:45 -0800
Subject: [PATCH v4 10/10] cxl: add man page documentation for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:30:45 -0700
Message-ID: <166793224539.3768752.16520384828313781321.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
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


