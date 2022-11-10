Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BFCC433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Nov 2022 00:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiKJAIV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiKJAIP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Nov 2022 19:08:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1EE29804
        for <linux-cxl@vger.kernel.org>; Wed,  9 Nov 2022 16:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668038890; x=1699574890;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yAOtC6k/Gr4dNTMKOO78BnW1LvIBCpDNKx2BQ5dyxfA=;
  b=Y2g2+mwFaNlON/Wefkcy31PGG9kFnvCcCtDIhlgJf89Gnp4/QxARxl/F
   JvmWCDJCQq8+v/Gxr7fMa9jvg34vpY8d87tsLodi2Q++135V3UfzYEDEs
   KDCjtOycyVwgDlC/mMvSscMwdcPcOusepMLe0qLlVsHiBZ00sAX7kzqDs
   31ave6olKE02iFlgS4LAlE0WEeSG2ym4WIcQmUrkr377x5Dggs3P/nVgR
   E5J/27VULiiX6THT8/dLbxdzd2HbIcAKhskFUl6FG4K4tVu1vRIsiOdpy
   dyNs1N+z/K4QLXaaRtl6X2s7tSmXdIcJ7z4VBjDGX6D7mywHySpPY15Ce
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="294502189"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="294502189"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:08:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="882130336"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="882130336"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:08:09 -0800
Subject: [PATCH v5 7/7] ndctl: cxl: add man page documentation for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 09 Nov 2022 17:08:09 -0700
Message-ID: <166803888924.145141.2305759221442551251.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
References: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
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
 Documentation/cxl/cxl-monitor.txt |   62 +++++++++++++++++++++++++++++++++++++
 Documentation/cxl/meson.build     |    1 +
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/cxl/cxl-monitor.txt

diff --git a/Documentation/cxl/cxl-monitor.txt b/Documentation/cxl/cxl-monitor.txt
new file mode 100644
index 000000000000..3fc992e4d4d9
--- /dev/null
+++ b/Documentation/cxl/cxl-monitor.txt
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-monitor(1)
+==============
+
+NAME
+----
+cxl-monitor - Monitor the CXL trace events
+
+SYNOPSIS
+--------
+[verse]
+'cxl monitor' [<options>]
+
+DESCRIPTION
+-----------
+cxl-monitor is used for monitoring the CXL trace events emitted by
+the kernel and convert them to json objects and dumping the json format
+notifications to standard output or a logfile.
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
+include::verbose-option.txt[]
+
+include::human-option.txt[]
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkcxl:cxl-list[1]
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index 147ea7130211..a6d77ab8cbc2 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -45,6 +45,7 @@ cxl_manpages = [
   'cxl-disable-region.txt',
   'cxl-enable-region.txt',
   'cxl-destroy-region.txt',
+  'cxl-monitor.txt',
 ]
 
 foreach man : cxl_manpages


