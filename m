Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3DEC433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jan 2022 21:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbiAEVfB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:35:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:45285 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244528AbiAEVeV (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 5 Jan 2022 16:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641418461; x=1672954461;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iz6AwOBqRhVIF+2BPFBwyfgVIPz0neV1GHLBEx3UFBs=;
  b=W5iqtmhGv8+usR8xO9YhTJmTzzZjE3J4SZ1qiTNhe4qzXqiwx+RlJ8R7
   t2EQRkZ4w4zMbxGcxC5LGHFhoJ+KCDJ1eN42R7U1p3b44AbFdfu0EzbOW
   U+FU3il59tR23k3qMgQ3PF+1hWZ/4P3uMYMXuIfh5nKRxVfhJ9AQ5l0nT
   TKP8Ivoh2n54wZv1wwVmXniD0Vhvkkt4R+y9kkR0HrbtfIVpDL5Kj51Ux
   X8ANy2SyDEEwpa+g6htO4aqb+wkQS7BiKfzPjThOmWdi6qtQgm+tHHC4s
   Oe5dzZ7OYf+ufHIFOoqGV5uev1L23QGXrNeW4480I9SPLvnrxxA8KJFd5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242496030"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="242496030"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="470718904"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:37 -0800
Subject: [ndctl PATCH v3 11/16] build: Drop unnecessary $tool/config.h
 includes
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Wed, 05 Jan 2022 13:32:37 -0800
Message-ID: <164141835727.3990253.12971738434561351928.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
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
index 876b34714b7e..2f33b8fb488c 100644
--- a/ndctl/keys.c
+++ b/ndctl/keys.c
@@ -13,7 +13,6 @@
 #include <keyutils.h>
 #include <syslog.h>
 
-#include <ndctl/config.h>
 #include <ndctl/ndctl.h>
 #include <ndctl/libndctl.h>
 
diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index 8b600a4e762b..ae694c614593 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -11,7 +11,6 @@
 #include <util/parse-options.h>
 #include <util/parse-configs.h>
 #include <util/strbuf.h>
-#include <ndctl/config.h>
 #include <ndctl/ndctl.h>
 #include <ndctl/libndctl.h>
 #include <sys/epoll.h>

