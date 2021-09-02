Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00197C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 20:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20E661054
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 20:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344848AbhIBUoR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:44:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:20361 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344846AbhIBUoK (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 16:44:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="206462219"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="206462219"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 13:43:11 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="602548264"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 13:43:10 -0700
Subject: [ndctl PATCH v2 2/6] Documentation: Drop attrs.adoc include
From:   Dan Williams <dan.j.williams@intel.com>
To:     nvdimm@lists.linux.dev
Cc:     vishal.l.verma@intel.com, linux-cxl@vger.kernel.org
Date:   Thu, 02 Sep 2021 13:43:10 -0700
Message-ID: <163061539059.1943957.3717594871893118896.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163061537869.1943957.8491829881215255815.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163061537869.1943957.8491829881215255815.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for switching build systems, drop the attrs.adoc include for
communicating variables to asciidoc. Simply add the necessary variable
values to the invocation of the command using the --attribute argument.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/Makefile.am                 |   14 ++++----------
 Documentation/ndctl/intel-nvdimm-security.txt   |    2 --
 Documentation/ndctl/ndctl-load-keys.txt         |    2 --
 Documentation/ndctl/ndctl-monitor.txt           |    5 +----
 Documentation/ndctl/ndctl-sanitize-dimm.txt     |    2 --
 Documentation/ndctl/ndctl-setup-passphrase.txt  |    2 --
 Documentation/ndctl/ndctl-update-passphrase.txt |    2 --
 7 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/Documentation/ndctl/Makefile.am b/Documentation/ndctl/Makefile.am
index f0d5b213057c..9ec5458c2268 100644
--- a/Documentation/ndctl/Makefile.am
+++ b/Documentation/ndctl/Makefile.am
@@ -56,14 +56,6 @@ EXTRA_DIST = $(man1_MANS)
 
 CLEANFILES = $(man1_MANS)
 
-.ONESHELL:
-attrs.adoc: $(srcdir)/Makefile.am
-	$(AM_V_GEN) cat <<- EOF >$@
-		:ndctl_monitorconfdir: $(ndctl_monitorconfdir)
-		:ndctl_monitorconf: $(ndctl_monitorconf)
-		:ndctl_keysdir: $(ndctl_keysdir)
-		EOF
-
 XML_DEPS = \
 	../../version.m4 \
 	Makefile \
@@ -76,8 +68,7 @@ XML_DEPS = \
 	xable-namespace-options.txt \
 	ars-description.txt \
 	labels-description.txt \
-	labels-options.txt \
-	attrs.adoc
+	labels-options.txt
 
 RM ?= rm -f
 
@@ -88,6 +79,9 @@ if USE_ASCIIDOCTOR
 		$(ASCIIDOC) -b manpage -d manpage -acompat-mode \
 		-I. -rasciidoctor-extensions \
 		-amansource=ndctl -amanmanual="ndctl Manual" \
+		-andctl_monitorconf=$(ndctl_monitorconfdir)/$(ndctl_monitorconf) \
+		-andctl_monitorconfdir=$(ndctl_monitorconfdir) \
+		-andctl_keysdir=$(ndctl_keysdir) \
 		-andctl_version=$(VERSION) -o $@+ $< && \
 		mv $@+ $@
 
diff --git a/Documentation/ndctl/intel-nvdimm-security.txt b/Documentation/ndctl/intel-nvdimm-security.txt
index 142b4603db69..88b305b81978 100644
--- a/Documentation/ndctl/intel-nvdimm-security.txt
+++ b/Documentation/ndctl/intel-nvdimm-security.txt
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-include::attrs.adoc[]
-
 THEORY OF OPERATION
 -------------------
 The Intel Device Specific Methods (DSM) specification v1.7 and v1.8 [1]
diff --git a/Documentation/ndctl/ndctl-load-keys.txt b/Documentation/ndctl/ndctl-load-keys.txt
index a064f97fd069..70db57441820 100644
--- a/Documentation/ndctl/ndctl-load-keys.txt
+++ b/Documentation/ndctl/ndctl-load-keys.txt
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-include::attrs.adoc[]
-
 ndctl-load-keys(1)
 ==================
 
diff --git a/Documentation/ndctl/ndctl-monitor.txt b/Documentation/ndctl/ndctl-monitor.txt
index dbc9070c6331..14e0026c657e 100644
--- a/Documentation/ndctl/ndctl-monitor.txt
+++ b/Documentation/ndctl/ndctl-monitor.txt
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-include::attrs.adoc[]
-
 ndctl-monitor(1)
 ================
 
@@ -21,8 +19,7 @@ objects and dumping the json format notifications to syslog, standard
 output or a logfile.
 
 The objects to monitor and smart events to notify can be selected by
-setting options and/or the configuration file at
-{ndctl_monitorconfdir}/{ndctl_monitorconf}
+setting options and/or the configuration file at {ndctl_monitorconf}
 
 Both, the values in configuration file and in options will work. If
 there is a conflict, the values in options will override the values in
diff --git a/Documentation/ndctl/ndctl-sanitize-dimm.txt b/Documentation/ndctl/ndctl-sanitize-dimm.txt
index b2e5fde9ecb3..e04467856ca4 100644
--- a/Documentation/ndctl/ndctl-sanitize-dimm.txt
+++ b/Documentation/ndctl/ndctl-sanitize-dimm.txt
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-include::attrs.adoc[]
-
 ndctl-sanitize-dimm(1)
 ======================
 
diff --git a/Documentation/ndctl/ndctl-setup-passphrase.txt b/Documentation/ndctl/ndctl-setup-passphrase.txt
index 1219279b4c66..96f709b468fc 100644
--- a/Documentation/ndctl/ndctl-setup-passphrase.txt
+++ b/Documentation/ndctl/ndctl-setup-passphrase.txt
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-include::attrs.adoc[]
-
 ndctl-setup-passphrase(1)
 =========================
 
diff --git a/Documentation/ndctl/ndctl-update-passphrase.txt b/Documentation/ndctl/ndctl-update-passphrase.txt
index c7c1bfc8ab0b..591ce44ebc3e 100644
--- a/Documentation/ndctl/ndctl-update-passphrase.txt
+++ b/Documentation/ndctl/ndctl-update-passphrase.txt
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-include::attrs.adoc[]
-
 ndctl-update-passphrase(1)
 ==========================
 

