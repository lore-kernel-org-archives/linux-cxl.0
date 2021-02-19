Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49170C433E0
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 02:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A89D64ED2
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 02:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBSCFf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Feb 2021 21:05:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:50642 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhBSCFf (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 18 Feb 2021 21:05:35 -0500
IronPort-SDR: CG5XPrXNaGh+u4lDWg4UcQJon7EVLaVOAuPdzRDN19CFilGvr91Ux57LH5WupNB5hQVsfIj6cl
 82sthrpPizOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="162854728"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="162854728"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:56 -0800
IronPort-SDR: QoIZ0i4ySHXLoUw8caSh8y6/4quGuLGeZUmWf0dCN7BiOYzK0Uk6h2v9Yow6zmPJAJ1FakqF4w
 /EFsCvloJ7Fg==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="513509687"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:55 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-nvdimm@lists.01.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v2 12/13] Documentation/cxl: add library API documentation
Date:   Thu, 18 Feb 2021 19:03:30 -0700
Message-Id: <20210219020331.725687-13-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add library API documentation for libcxl(3) using the existing
asciidoc(tor) build system. Add a section 3 man page for 'libcxl' that
provides an overview of the library and its usage, and a man page for
the 'cxl_new()' API.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/cxl/lib/cxl_new.txt | 43 +++++++++++++++++++++++
 Documentation/cxl/lib/libcxl.txt  | 56 +++++++++++++++++++++++++++++
 configure.ac                      |  1 +
 Makefile.am                       |  1 +
 .gitignore                        |  3 ++
 Documentation/cxl/lib/Makefile.am | 58 +++++++++++++++++++++++++++++++
 6 files changed, 162 insertions(+)
 create mode 100644 Documentation/cxl/lib/cxl_new.txt
 create mode 100644 Documentation/cxl/lib/libcxl.txt
 create mode 100644 Documentation/cxl/lib/Makefile.am

diff --git a/Documentation/cxl/lib/cxl_new.txt b/Documentation/cxl/lib/cxl_new.txt
new file mode 100644
index 0000000..d4d5bcb
--- /dev/null
+++ b/Documentation/cxl/lib/cxl_new.txt
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl_new(3)
+==========
+
+NAME
+----
+cxl_new - Create a new library context object that acts as a handle for all
+library operations
+
+SYNOPSIS
+--------
+[verse]
+----
+#include <cxl/libcxl.h>
+
+int cxl_new(struct cxl_ctx **ctx);
+----
+
+DESCRIPTION
+-----------
+Instantiates a new library context, and stores an opaque pointer in ctx. The
+context is freed by linklibcxl:cxl_unref[3], i.e. cxl_new(3) implies an
+internal linklibcxl:cxl_ref[3].
+
+
+RETURN VALUE
+------------
+Returns 0 on success, and a negative errno on failure.
+Possible error codes are:
+
+ * -ENOMEM
+ * -ENXIO
+
+EXAMPLE
+-------
+See example usage in test/libcxl.c
+
+include::../../copyright.txt[]
+
+SEE ALSO
+--------
+linklibcxl:cxl_ref[3], linklibcxl:cxl_unref[3]
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
new file mode 100644
index 0000000..47f4cc3
--- /dev/null
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+libcxl(3)
+=========
+
+NAME
+----
+libcxl - A library to interact with CXL devices through sysfs(5)
+and ioctl(2) interfaces
+
+SYNOPSIS
+--------
+[verse]
+#include <cxl/libcxl.h>
+cc ... -lcxl
+
+DESCRIPTION
+-----------
+libcxl provides interfaces to interact with CXL devices in Linux, using sysfs
+interfaces for most kernel interactions, and the ioctl() interface for command
+submission.
+
+The starting point for all library interfaces is a 'cxl_ctx' object, returned
+by linklibcxl:cxl_new[3]. CXL 'Type 3' memory devices are children of the
+cxl_ctx object, and can be iterated through using an iterator API.
+
+Library level interfaces that are agnostic to any device, or a specific
+subclass of operations have the prefix 'cxl_'
+
+The object representing a CXL Type 3 device is 'cxl_memdev'. Library interfaces
+related to these devices have the prefix 'cxl_memdev_'. These interfaces are
+mostly associated with sysfs interactions (unless otherwise noted in their
+respective documentation pages). They are typically used to retrieve data
+published by the kernel, or to send data or trigger kernel operations for a
+given device.
+
+A 'cxl_cmd' is a reference counted object which is used to perform 'Mailbox'
+commands as described in the CXL Specification. A 'cxl_cmd' object is tied to a
+'cxl_memdev'. Associated library interfaces have the prefix 'cxl_cmd_'. Within
+this sub-class of interfaces, there are:
+
+ * 'cxl_cmd_new_*' interfaces that allocate a new cxl_cmd object for a given
+   command type.
+
+ * 'cxl_cmd_submit' which submits the command via ioctl()
+
+ * 'cxl_cmd_<name>_get_<field>' interfaces that get specific fields out of the
+   command response
+
+ * 'cxl_cmd_get_*' interfaces to get general command related information.
+
+include::../../copyright.txt[]
+
+SEE ALSO
+--------
+linklibcxl:cxl[1]
diff --git a/configure.ac b/configure.ac
index 7f5e6f0..a357042 100644
--- a/configure.ac
+++ b/configure.ac
@@ -231,6 +231,7 @@ AC_CONFIG_FILES([
         Documentation/ndctl/Makefile
         Documentation/daxctl/Makefile
         Documentation/cxl/Makefile
+        Documentation/cxl/lib/Makefile
 ])
 
 AC_OUTPUT
diff --git a/Makefile.am b/Makefile.am
index 4904ee7..e2f6bef 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -4,6 +4,7 @@ ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
 SUBDIRS = . cxl/lib daxctl/lib ndctl/lib cxl ndctl daxctl
 if ENABLE_DOCS
 SUBDIRS += Documentation/ndctl Documentation/daxctl Documentation/cxl
+SUBDIRS += Documentation/cxl/lib
 endif
 SUBDIRS += test
 
diff --git a/.gitignore b/.gitignore
index de43823..b0f93dc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,12 +13,15 @@ Makefile.in
 /libtool
 /stamp-h1
 *.1
+*.3
 Documentation/daxctl/asciidoc.conf
 Documentation/ndctl/asciidoc.conf
 Documentation/cxl/asciidoc.conf
+Documentation/cxl/lib/asciidoc.conf
 Documentation/daxctl/asciidoctor-extensions.rb
 Documentation/ndctl/asciidoctor-extensions.rb
 Documentation/cxl/asciidoctor-extensions.rb
+Documentation/cxl/lib/asciidoctor-extensions.rb
 .dirstamp
 daxctl/config.h
 daxctl/daxctl
diff --git a/Documentation/cxl/lib/Makefile.am b/Documentation/cxl/lib/Makefile.am
new file mode 100644
index 0000000..41e3a5f
--- /dev/null
+++ b/Documentation/cxl/lib/Makefile.am
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020-2021 Intel Corporation. All rights reserved.
+
+if USE_ASCIIDOCTOR
+
+do_subst = sed -e 's,@Utility@,Libcxl,g' -e's,@utility@,libcxl,g'
+CONFFILE = asciidoctor-extensions.rb
+asciidoctor-extensions.rb: ../../asciidoctor-extensions.rb.in
+	$(AM_V_GEN) $(do_subst) < $< > $@
+
+else
+
+do_subst = sed -e 's,UTILITY,libcxl,g'
+CONFFILE = asciidoc.conf
+asciidoc.conf: ../../asciidoc.conf.in
+	$(AM_V_GEN) $(do_subst) < $< > $@
+
+endif
+
+man3_MANS = \
+	libcxl.3 \
+	cxl_new.3
+
+EXTRA_DIST = $(man3_MANS)
+
+CLEANFILES = $(man3_MANS)
+
+XML_DEPS = \
+	../../../version.m4 \
+	../../copyright.txt \
+	Makefile \
+	$(CONFFILE)
+
+RM ?= rm -f
+
+if USE_ASCIIDOCTOR
+
+%.3: %.txt $(XML_DEPS)
+	$(AM_V_GEN)$(RM) $@+ $@ && \
+		$(ASCIIDOC) -b manpage -d manpage -acompat-mode \
+		-I. -rasciidoctor-extensions \
+		-amansource=libcxl -amanmanual="libcxl Manual" \
+		-andctl_version=$(VERSION) -o $@+ $< && \
+		mv $@+ $@
+
+else
+
+%.xml: %.txt $(XML_DEPS)
+	$(AM_V_GEN)$(RM) $@+ $@ && \
+		$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
+		--unsafe -alibcxl_version=$(VERSION) -o $@+ $< && \
+		mv $@+ $@
+
+%.3: %.xml $(XML_DEPS)
+	$(AM_V_GEN)$(RM) $@ && \
+		$(XMLTO) -o . -m ../../manpage-normal.xsl man $<
+
+endif
-- 
2.29.2

