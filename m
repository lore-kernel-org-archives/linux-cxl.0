Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04745C07E99
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Jul 2021 19:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBF1613D1
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Jul 2021 19:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhGITzr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Jul 2021 15:55:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:40522 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGITzr (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 9 Jul 2021 15:55:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="206751447"
X-IronPort-AV: E=Sophos;i="5.84,227,1620716400"; 
   d="scan'208";a="206751447"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 12:53:02 -0700
X-IronPort-AV: E=Sophos;i="5.84,227,1620716400"; 
   d="scan'208";a="647171021"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 12:53:02 -0700
Subject: [ndctl PATCH 4/6] build: Explicitly include version.h
From:   Dan Williams <dan.j.williams@intel.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org
Date:   Fri, 09 Jul 2021 12:53:02 -0700
Message-ID: <162586038235.1431180.11031769782992113308.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162586035908.1431180.14991721381432827647.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162586035908.1431180.14991721381432827647.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for switching to meson explicitly include version.h rather
than depend on -DGIT_VERSION.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/cxl.c       |    1 +
 cxl/list.c      |    1 +
 daxctl/daxctl.c |    1 +
 daxctl/list.c   |    1 +
 ndctl/list.c    |    1 +
 ndctl/monitor.c |    1 +
 ndctl/ndctl.c   |    1 +
 7 files changed, 7 insertions(+)

diff --git a/cxl/cxl.c b/cxl/cxl.c
index 4b1661d8d4c1..4aa2038d6435 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <version.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <cxl/libcxl.h>
diff --git a/cxl/list.c b/cxl/list.c
index d7b836bd2b46..7923f64d1884 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
+#include <version.h>
 #include <util/json.h>
 #include <json-c/json.h>
 #include <cxl/libcxl.h>
diff --git a/daxctl/daxctl.c b/daxctl/daxctl.c
index 928814c8b35f..3668e760ea23 100644
--- a/daxctl/daxctl.c
+++ b/daxctl/daxctl.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <version.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <daxctl/libdaxctl.h>
diff --git a/daxctl/list.c b/daxctl/list.c
index aeff1967116b..2b2bc19d23cb 100644
--- a/daxctl/list.c
+++ b/daxctl/list.c
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
+#include <version.h>
 #include <util/json.h>
 #include <json-c/json.h>
 #include <daxctl/libdaxctl.h>
diff --git a/ndctl/list.c b/ndctl/list.c
index 869edde4fc65..3baf8e13c2ea 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
+#include <version.h>
 
 #include <util/json.h>
 #include <json-c/json.h>
diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index fde5b1209565..870dec2ef679 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -13,6 +13,7 @@
 #include <ndctl/ndctl.h>
 #include <ndctl/libndctl.h>
 #include <sys/epoll.h>
+#include <version.h>
 #define BUF_SIZE 2048
 
 /* reuse the core log helpers for the monitor logger */
diff --git a/ndctl/ndctl.c b/ndctl/ndctl.c
index 31d2c5e35939..4c8bf3434245 100644
--- a/ndctl/ndctl.c
+++ b/ndctl/ndctl.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <version.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <ndctl/builtin.h>

