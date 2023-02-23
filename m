Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D45DC61DA4
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 20:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBWU3F (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 15:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBWU3E (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 15:29:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4B23526E
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 12:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677184143; x=1708720143;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e/3c3V2Fi+MJIbocQ14oNds3ZXY2PEqZvbKgYyh5vn4=;
  b=EmPevH9UJUFk14jcrajWQ4Bws0cmCE8H6gwZwnZ8reJviTeiqXijKrO8
   BKP5fFe+On9OPwNHq0Gh+KkXYeMMaLU6xi5oXUKNzMos+GAXwLtsfPlWd
   o317UNKTM22OjkZJIZz5vNw3EvrFl2M2o04BFYXO7uUTcWjlXtI6Yewkm
   pGswRSoYUib4YypEo9yQMCi7dnYzqctKhUcx0X/GhS6Y7q31pB0DUiAVG
   TFeebsLKQz7CAB3GK13yR7Sc5BF8iG1qJa7YxNfqsSLR51P+ZqwUzm6ft
   7cNK6NyShZbRoYdZxEf1r+PWRqMVTbm0iTuBncSeOTu5atvlihkKWecuO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="360815678"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="360815678"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 12:29:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="736533949"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="736533949"
Received: from rakther-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.6.182])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 12:29:02 -0800
Subject: [ndctl PATCH] cxl/monitor: Make libtracefs dependency optional
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Thu, 23 Feb 2023 12:29:02 -0800
Message-ID: <167718414197.16926.10394415062829848410.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Build a stub version of 'cxl monitor' that reports that the facility was
statically disabled at configure / build time. Provide the meson
configuration line to correct the build.

This is in response to the fact that some distros fail to ship
libtracefs-devel even though they ship libtracefs (looking at you CentOS
Stream 8).

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 config.h.meson    |    3 +++
 cxl/builtin.h     |    9 +++++++++
 cxl/meson.build   |   33 +++++++++++++++++++++------------
 meson.build       |    7 +++++--
 meson_options.txt |    1 +
 ndctl.spec.in     |    8 +++++---
 6 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/config.h.meson b/config.h.meson
index 2852f1e9cd8b..5441dff9fce7 100644
--- a/config.h.meson
+++ b/config.h.meson
@@ -19,6 +19,9 @@
 /* ndctl test support */
 #mesondefine ENABLE_TEST
 
+/* cxl monitor support */
+#mesondefine ENABLE_LIBTRACEFS
+
 /* Define to 1 if big-endian-arch */
 #mesondefine HAVE_BIG_ENDIAN
 
diff --git a/cxl/builtin.h b/cxl/builtin.h
index 34c5cfb49051..9baa43b8a2ac 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -22,5 +22,14 @@ int cmd_create_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_enable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_disable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_destroy_region(int argc, const char **argv, struct cxl_ctx *ctx);
+#ifdef ENABLE_LIBTRACEFS
 int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx);
+#else
+static inline int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	fprintf(stderr,
+		"cxl monitor: unavailable, rebuild with '-Dlibtracefs=enabled'\n");
+	return EXIT_FAILURE;
+}
+#endif
 #endif /* _CXL_BUILTIN_H_ */
diff --git a/cxl/meson.build b/cxl/meson.build
index fc2e946707a8..391219be76d1 100644
--- a/cxl/meson.build
+++ b/cxl/meson.build
@@ -7,27 +7,36 @@ cxl_src = [
   'memdev.c',
   'json.c',
   'filter.c',
-  'event_trace.c',
-  'monitor.c',
 ]
 
 if get_option('systemd').enabled()
   install_data('cxl-monitor.service', install_dir : systemdunitdir)
 endif
 
+deps = [
+  cxl_dep,
+  util_dep,
+  uuid,
+  kmod,
+  json,
+  versiondep,
+]
+
+if get_option('libtracefs').enabled()
+  cxl_src += [
+    'event_trace.c',
+    'monitor.c',
+  ]
+  deps += [
+    traceevent,
+    tracefs,
+  ]
+endif
+
 cxl_tool = executable('cxl',
   cxl_src,
   include_directories : root_inc,
-  dependencies : [
-    cxl_dep,
-    util_dep,
-    uuid,
-    kmod,
-    json,
-    versiondep,
-    traceevent,
-    tracefs,
-  ],
+  dependencies : deps,
   install : true,
   install_dir : rootbindir,
 )
diff --git a/meson.build b/meson.build
index 6d2c6827fa88..b4f977f5b7ee 100644
--- a/meson.build
+++ b/meson.build
@@ -143,8 +143,10 @@ kmod = dependency('libkmod')
 libudev = dependency('libudev')
 uuid = dependency('uuid')
 json = dependency('json-c')
-traceevent = dependency('libtraceevent')
-tracefs = dependency('libtracefs')
+if get_option('libtracefs').enabled()
+  traceevent = dependency('libtraceevent')
+  tracefs = dependency('libtracefs')
+endif
 
 if get_option('docs').enabled()
   if get_option('asciidoctor').enabled()
@@ -234,6 +236,7 @@ conf.set('ENABLE_TEST', get_option('test').enabled())
 conf.set('ENABLE_DESTRUCTIVE', get_option('destructive').enabled())
 conf.set('ENABLE_LOGGING', get_option('logging').enabled())
 conf.set('ENABLE_DEBUG', get_option('dbg').enabled())
+conf.set('ENABLE_LIBTRACEFS', get_option('libtracefs').enabled())
 
 typeof_code = '''
   void func() {
diff --git a/meson_options.txt b/meson_options.txt
index 4ed519e1f36b..5c41b1abe1f1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -2,6 +2,7 @@ option('version-tag', type : 'string',
        description : 'override the git version string')
 option('docs', type : 'feature', value : 'enabled')
 option('asciidoctor', type : 'feature', value : 'enabled')
+option('libtracefs', type : 'feature', value : 'enabled')
 option('systemd', type : 'feature', value : 'enabled')
 option('keyutils', type : 'feature', value : 'enabled',
   description : 'enable nvdimm device passphrase management')
diff --git a/ndctl.spec.in b/ndctl.spec.in
index 0543c481da7f..7702f9552cd0 100644
--- a/ndctl.spec.in
+++ b/ndctl.spec.in
@@ -13,9 +13,13 @@ BuildRequires:	autoconf
 %if 0%{?rhel} < 9
 BuildRequires:	asciidoc
 %define asciidoctor -Dasciidoctor=disabled
+%define libtracefs -Dlibtracefs=disabled
 %else
 BuildRequires:	rubygem-asciidoctor
+BuildRequires:	libtraceevent-devel
+BuildRequires:	libtracefs-devel
 %define asciidoctor -Dasciidoctor=enabled
+%define libtracefs -Dlibtracefs=enabled
 %endif
 BuildRequires:	xmlto
 BuildRequires:	automake
@@ -31,8 +35,6 @@ BuildRequires:	keyutils-libs-devel
 BuildRequires:	systemd-rpm-macros
 BuildRequires:	iniparser-devel
 BuildRequires:	meson
-BuildRequires:	libtraceevent-devel
-BuildRequires:	libtracefs-devel
 
 %description
 Utility library for managing the "libnvdimm" subsystem.  The "libnvdimm"
@@ -124,7 +126,7 @@ libcxl is a library for enumerating and communicating with CXL devices.
 %setup -q ndctl-%{version}
 
 %build
-%meson %{?asciidoctor} -Dversion-tag=%{version}
+%meson %{?asciidoctor} %{?libtracefs} -Dversion-tag=%{version}
 %meson_build
 
 %install

