Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC85C6FA82
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Sep 2022 23:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiISXrh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiISXra (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Sep 2022 19:47:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB44F3B3
        for <linux-cxl@vger.kernel.org>; Mon, 19 Sep 2022 16:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663631248; x=1695167248;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KSFZB3ntka+bSSvolTA/Uf4WdX3s1HtcDYCRMCLVZIU=;
  b=LkD3K/8PFEGDaByf7SF5rYWlmy7/WMYnd+iRq4wmcfme71xrtuLCqd8l
   BU+nIHOfygaHXoxmF9pjWxeQlLjyLZ9GNgZJxNJ68y2Tl22zap5pnRFQQ
   X+FeDibxFN1tkUZ6SeGFKI1dYwXdaMT8krc+UnaaYiKX1ZVok1HRZUsbq
   F1C0ah3i9E1Md9+mCHgWugdkU7+ihTrrP+xDSD0ZUAWOg1n+ARcWzYWm1
   B7qC5u+wxHG76sm1MqicME6kUkhSpQvo4hjcSYEY6duVz4wiQj/uspaNf
   gFJE5xVQpB9teRnZaJItji2JI+Aq4NgYdIb5Ia7NVmFM7m6GNbNXg3xK8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="297142215"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="297142215"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 16:47:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="744305591"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 16:47:27 -0700
Subject: [PATCH v2 9/9] cxl: add man page documentation for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        nafonten@amd.com, nvdimm@lists.linux.dev
Date:   Mon, 19 Sep 2022 16:47:27 -0700
Message-ID: <166363124742.3861186.7691291186058723572.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com>
References: <166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com>
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


