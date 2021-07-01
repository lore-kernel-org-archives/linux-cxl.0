Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB30C11F6D
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jul 2021 20:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3A761413
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jul 2021 20:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhGAUM7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jul 2021 16:12:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:63974 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233938AbhGAUM5 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 1 Jul 2021 16:12:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="208653285"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="208653285"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 13:10:26 -0700
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="409271447"
Received: from anandvig-mobl.amr.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.254.38.85])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 13:10:26 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v3 20/21] ndctl: Add CXL packages to the RPM spec
Date:   Thu,  1 Jul 2021 14:10:04 -0600
Message-Id: <20210701201005.3065299-21-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210701201005.3065299-1-vishal.l.verma@intel.com>
References: <20210701201005.3065299-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Add CXL related packages - the cxl-cli utility, the libcxl library, and
development headers to respective RPM packages in the main spec file.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Makefile.am   |  4 ++++
 ndctl.spec.in | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index e2f6bef..fa2010a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -23,17 +23,21 @@ CLEANFILES += $(noinst_SCRIPTS)
 
 do_rhel_subst = sed -e 's,VERSION,$(VERSION),g' \
             -e 's,DAX_DNAME,daxctl-devel,g' \
+            -e 's,CXL_DNAME,cxl-devel,g' \
             -e 's,DNAME,ndctl-devel,g' \
             -e '/^%defattr.*/d' \
 	    -e 's,DAX_LNAME,daxctl-libs,g' \
+	    -e 's,CXL_LNAME,cxl-libs,g' \
 	    -e 's,LNAME,ndctl-libs,g'
 
 do_sles_subst = sed -e 's,VERSION,$(VERSION),g' \
             -e 's,DAX_DNAME,libdaxctl-devel,g' \
+            -e 's,CXL_DNAME,libcxl-devel,g' \
             -e 's,DNAME,libndctl-devel,g' \
             -e 's,%license,%doc,g' \
             -e 's,\(^License:.*GPL\)v2,\1-2.0,g' \
             -e "s,DAX_LNAME,libdaxctl$$(($(LIBDAXCTL_CURRENT) - $(LIBDAXCTL_AGE))),g" \
+            -e "s,CXL_LNAME,libcxl$$(($(LIBCXL_CURRENT) - $(LIBCXL_AGE))),g" \
             -e "s,LNAME,libndctl$$(($(LIBNDCTL_CURRENT) - $(LIBNDCTL_AGE))),g"
 
 rhel/ndctl.spec: ndctl.spec.in Makefile.am version.m4
diff --git a/ndctl.spec.in b/ndctl.spec.in
index 0563b2d..4b08c05 100644
--- a/ndctl.spec.in
+++ b/ndctl.spec.in
@@ -8,6 +8,7 @@ Source0:	https://github.com/pmem/%{name}/archive/v%{version}.tar.gz#/%{name}-%{v
 
 Requires:	LNAME%{?_isa} = %{version}-%{release}
 Requires:	DAX_LNAME%{?_isa} = %{version}-%{release}
+Requires:	CXL_LNAME%{?_isa} = %{version}-%{release}
 BuildRequires:	autoconf
 %if 0%{?rhel} < 9
 BuildRequires:	asciidoc
@@ -54,6 +55,24 @@ the Linux kernel Device-DAX facility. This facility enables DAX mappings
 of performance / feature differentiated memory without need of a
 filesystem.
 
+%package -n cxl-cli
+Summary:	Manage CXL devices
+License:	GPLv2
+Requires:	CXL_LNAME%{?_isa} = %{version}-%{release}
+
+%description -n cxl-cli
+The cxl utility provides enumeration and provisioning commands for
+the Linux kernel CXL devices.
+
+%package -n CXL_DNAME
+Summary:	Development files for libcxl
+License:	LGPLv2
+Requires:	CXL_LNAME%{?_isa} = %{version}-%{release}
+
+%description -n CXL_DNAME
+This package contains libraries and header files for developing applications
+that use libcxl, a library for enumerating and communicating with CXL devices.
+
 %package -n DAX_DNAME
 Summary:	Development files for libdaxctl
 License:	LGPLv2
@@ -84,6 +103,13 @@ Device DAX is a facility for establishing DAX mappings of performance /
 feature-differentiated memory. DAX_LNAME provides an enumeration /
 control API for these devices.
 
+%package -n CXL_LNAME
+Summary:	Management library for CXL devices
+License:	LGPLv2
+
+%description -n CXL_LNAME
+libcxl is a library for enumerating and communicating with CXL devices.
+
 
 %prep
 %setup -q ndctl-%{version}
@@ -105,6 +131,8 @@ make check
 
 %ldconfig_scriptlets -n DAX_LNAME
 
+%ldconfig_scriptlets -n CXL_LNAME
+
 %define bashcompdir %(pkg-config --variable=completionsdir bash-completion)
 
 %files
@@ -126,6 +154,12 @@ make check
 %{_mandir}/man1/daxctl*
 %{_datadir}/daxctl/daxctl.conf
 
+%files -n cxl-cli
+%defattr(-,root,root)
+%license LICENSES/preferred/GPL-2.0 LICENSES/other/MIT LICENSES/other/CC0-1.0
+%{_bindir}/cxl
+%{_mandir}/man1/cxl*
+
 %files -n LNAME
 %defattr(-,root,root)
 %doc README.md
@@ -138,6 +172,12 @@ make check
 %license LICENSES/preferred/LGPL-2.1 LICENSES/other/MIT LICENSES/other/CC0-1.0
 %{_libdir}/libdaxctl.so.*
 
+%files -n CXL_LNAME
+%defattr(-,root,root)
+%doc README.md
+%license LICENSES/preferred/LGPL-2.1 LICENSES/other/MIT LICENSES/other/CC0-1.0
+%{_libdir}/libcxl.so.*
+
 %files -n DNAME
 %defattr(-,root,root)
 %license LICENSES/preferred/LGPL-2.1
@@ -152,6 +192,15 @@ make check
 %{_libdir}/libdaxctl.so
 %{_libdir}/pkgconfig/libdaxctl.pc
 
+%files -n CXL_DNAME
+%defattr(-,root,root)
+%license LICENSES/preferred/LGPL-2.1
+%{_includedir}/cxl/
+%{_libdir}/libcxl.so
+%{_libdir}/pkgconfig/libcxl.pc
+%{_mandir}/man3/cxl*
+%{_mandir}/man3/libcxl.3.gz
+
 
 %changelog
 * Fri May 27 2016 Dan Williams <dan.j.williams@intel.com> - 53-1
-- 
2.31.1

