Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE9C433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiKHSas (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKHSal (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:30:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034A0554F1
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932241; x=1699468241;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DeqOUaGy2SP0BpG6nmA3vfDOX3XIVNbyvfzpqIRcQuk=;
  b=kTuEiBeyv1/7m/5xuyaZlkUQe+ihiBuTuyuRWPmq2HlASB+opZTZjVYo
   LB/9/wdRmy5RivsVJZel/875dr9AW2EwET0/gyCRn0eJj0pziJZBnBSeG
   Ut1Chl1P4TlaMpWnkpZXEhy4g10FtOOxUCRa2BBTGtQsTcpFCwuWPHYAk
   j5E+//lDMGvbecHffLMqyYaYmRDBLBWw0JvVatGHcfRE39vPQoOKWOxds
   OOrNfjCvtAFjuutp591bk9B/rHcM9sDgrNAJiLl7+UsyRXgJD7hy5fsZh
   nCRi30LD4U/FNSRySJGjs5oSKowgxa5efVcMGNFG8oYfmRA9Zk+635sjj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298290970"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="298290970"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="705400184"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="705400184"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:40 -0800
Subject: [PATCH v4 09/10] cxl: add systemd service for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:30:39 -0700
Message-ID: <166793223975.3768752.11846694721780323639.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
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
index 000000000000..87c842b6f595
--- /dev/null
+++ b/cxl/cxl-monitor.service
@@ -0,0 +1,9 @@
+[Unit]
+Description=Cxl Monitor Daemon
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


