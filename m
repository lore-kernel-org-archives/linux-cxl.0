Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44728C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiKBVVE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiKBVU6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:20:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FCD2618
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424058; x=1698960058;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DeqOUaGy2SP0BpG6nmA3vfDOX3XIVNbyvfzpqIRcQuk=;
  b=bLgaOS3ScpCyvbM9hsExHGTv5utTpMC2dWeKoFIrRFvGbQES7r7+geXK
   YnFDRtbUF0YMCwxksitTOL5HQaZClO2QPH9qay0dHUlOJMFS6rGwuf+47
   eRqoRvtPkFtR11vGrYxA+WHSDi7Lma+V4hSbfHX/OnkBxUqw+AJ7yXxdM
   auqIdevm0/RTVxXJ8g+5pAz6xRv9NEICS7IPfEEI3D+dltQydgfErfF4p
   7RGaKQ3vCGRLuMhWNgOwMGqPHy4rfDnJ2az5yEyJbPTxpS1Vy4fwUjrPw
   3EwNIXflXoTIlavy5Sc9Os64CpF9Dl7Xfk/UCkNBy7vGvNmf8oLrcE3A/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="395830840"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="395830840"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="634418722"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="634418722"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:55 -0700
Subject: [PATCH v3 09/10] cxl: add systemd service for monitor
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 02 Nov 2022 14:20:55 -0700
Message-ID: <166742405541.2654617.8889413333579462956.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
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


