Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3029CC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Nov 2022 00:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiKJAIS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKJAIN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Nov 2022 19:08:13 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EBC18B13
        for <linux-cxl@vger.kernel.org>; Wed,  9 Nov 2022 16:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668038885; x=1699574885;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9bYf4uzMvSiwyh8AUjn4qN7a2n9nebGOpPbY+vozG/0=;
  b=dYv2O9DdjPx2iWqbQnI8yE3ug3w2sKWNF/OVbE85aEDEO+JnYgrcc05F
   3XvHR2hnRg+r849GyrNhqCRtUtGms+fbjIjJL8KK9zybKJwXbZQp+x1Df
   /Ynqk85Gjv7S9XqpSZkzW0+zFAQH8gaqu1bAE76+3GXDxLW32rz4Q/Y1G
   Lmf8NTpsGav4fQy0qkqVofrWSr4lco4ivbYoihY5q6el0rcWmplwJs1kL
   hSQXe5GxXjJoNvq0eucv96UYzN73Ng2/jMSUczxFMdsLgJrLVUUIBuQ23
   1nRMDR0Gci9sas9EaM/Dxb71KoFkD1L7XN+uhQHFGUuLMtvD8fnjVD+9s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312928108"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="312928108"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:08:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="882130295"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="882130295"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:08:03 -0800
Subject: [PATCH v5 6/7] ndctl: cxl: add systemd service for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 09 Nov 2022 17:08:02 -0700
Message-ID: <166803888294.145141.16866651060328585251.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
References: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a systemd service file for cxl monitor to start the monitoring service
on boot initialization. Add the installation setup for the service file.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/cxl-monitor.service |    9 +++++++++
 cxl/meson.build         |    4 ++++
 ndctl.spec.in           |    1 +
 3 files changed, 14 insertions(+)
 create mode 100644 cxl/cxl-monitor.service

diff --git a/cxl/cxl-monitor.service b/cxl/cxl-monitor.service
new file mode 100644
index 000000000000..66de39d883be
--- /dev/null
+++ b/cxl/cxl-monitor.service
@@ -0,0 +1,9 @@
+[Unit]
+Description=CXL Monitor Daemon
+
+[Service]
+Type=simple
+ExecStart=/usr/bin/cxl monitor
+
+[Install]
+WantedBy=multi-user.target
diff --git a/cxl/meson.build b/cxl/meson.build
index eb8b2b1070ed..fc2e946707a8 100644
--- a/cxl/meson.build
+++ b/cxl/meson.build
@@ -11,6 +11,10 @@ cxl_src = [
   'monitor.c',
 ]
 
+if get_option('systemd').enabled()
+  install_data('cxl-monitor.service', install_dir : systemdunitdir)
+endif
+
 cxl_tool = executable('cxl',
   cxl_src,
   include_directories : root_inc,
diff --git a/ndctl.spec.in b/ndctl.spec.in
index cfcafa2ba816..c883317c5ce7 100644
--- a/ndctl.spec.in
+++ b/ndctl.spec.in
@@ -194,6 +194,7 @@ fi
 %{_bindir}/cxl
 %{_mandir}/man1/cxl*
 %{bashcompdir}/cxl
+%{_unitdir}/cxl-monitor.service
 
 %files -n LNAME
 %defattr(-,root,root)


