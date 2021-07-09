Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674BCC07E99
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Jul 2021 19:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC38613CA
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Jul 2021 19:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGITzl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Jul 2021 15:55:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:13649 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGITzl (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 9 Jul 2021 15:55:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="190145189"
X-IronPort-AV: E=Sophos;i="5.84,227,1620716400"; 
   d="scan'208";a="190145189"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 12:52:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,227,1620716400"; 
   d="scan'208";a="428909490"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 12:52:57 -0700
Subject: [ndctl PATCH 3/6] build: Drop unnecessary $tool/config.h includes
From:   Dan Williams <dan.j.williams@intel.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org
Date:   Fri, 09 Jul 2021 12:52:56 -0700
Message-ID: <162586037675.1431180.18352963282603697078.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162586035908.1431180.14991721381432827647.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162586035908.1431180.14991721381432827647.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for support for meson as the build infrastructure remove
some explicit config.h includes that will be replaced by a unified config.h
at the top of the project.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 daxctl/migrate.c |    1 -
 ndctl/keys.c     |    1 -
 ndctl/monitor.c  |    1 -
 3 files changed, 3 deletions(-)

diff --git a/daxctl/migrate.c b/daxctl/migrate.c
index 5fbe970fdaff..c51106625849 100644
--- a/daxctl/migrate.c
+++ b/daxctl/migrate.c
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
-#include <daxctl/config.h>
 #include <daxctl/libdaxctl.h>
 #include <util/parse-options.h>
 #include <ccan/array_size/array_size.h>
diff --git a/ndctl/keys.c b/ndctl/keys.c
index ed869d383641..f90ac1f1a6db 100644
--- a/ndctl/keys.c
+++ b/ndctl/keys.c
@@ -14,7 +14,6 @@
 #include <syslog.h>
 
 #include <ndctl.h>
-#include <ndctl/config.h>
 #include <ndctl/libndctl.h>
 
 #include "keys.h"
diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index 85890c5367d3..fde5b1209565 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -10,7 +10,6 @@
 #include <util/util.h>
 #include <util/parse-options.h>
 #include <util/strbuf.h>
-#include <ndctl/config.h>
 #include <ndctl/ndctl.h>
 #include <ndctl/libndctl.h>
 #include <sys/epoll.h>

