Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40C4C00140
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Aug 2022 23:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiHJXJp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiHJXJl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 Aug 2022 19:09:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A05A7B797
        for <linux-cxl@vger.kernel.org>; Wed, 10 Aug 2022 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660172980; x=1691708980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hWdnQGSa5Du+Yzjo1XKDR7Gzv21wnxh5foUJXYJfm4I=;
  b=aBy/d0sNle+5N4T73Cqbw/5sJMWb1mc3LplgobBp/HlIEdVJpcYzQkBu
   jR7NFDE0SM4mdOLtP5ijRtJv7L4SPjNl/mU/TNXiqUIuXOS2IOVStwkXH
   mUkKLAjn/dIgOdeNaaXV2axsMh1l4vRMLAy5MudTpJr/IxiYQGNafvmgb
   V1c9479j8qWnNy9lGCIkOi2TZ8h1UpoIQQ7Rj3eREU/rbzTE62qtraPh/
   1L5SiFcNhw/a4en7HCXHy6JXZG/NWCuguOGsT2dZ+j72458leU6u2c7+W
   8Cm9XOvPXlkHcLZfb3ehp1wKf1IwpvIaXtc+i7dC2F4cWFlXLMdDh595r
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271599777"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271599777"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:09:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="581429427"
Received: from maughenb-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.94.5])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:09:31 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v2 02/10] cxl/port: Consolidate the debug option in cxl-port man pages
Date:   Wed, 10 Aug 2022 17:09:06 -0600
Message-Id: <20220810230914.549611-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810230914.549611-1-vishal.l.verma@intel.com>
References: <20220810230914.549611-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; h=from:subject; bh=hWdnQGSa5Du+Yzjo1XKDR7Gzv21wnxh5foUJXYJfm4I=; b=owGbwMvMwCXGf25diOft7jLG02pJDElfrGbYp8U4iv6d8OrDDf7myRHuy2+KWEeUnK0LVf8+4fma MOUHHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZjIrOmMDP/q9rzLTjq/48UulbfZCS dX/1rNe0fH716PlJ7qlbLKU86MDAc2znVtq80q88/xUFkR9lDN03PBm2P12evNd+abz1l3kAkA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for additional commands that implement the --debug
option, consolidate the option description from the cxl-port man pages
into an include.

The port man pages also mentioned the debug option requiring a build
with debug enabled, which wasn't true - so remove that part.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 Documentation/cxl/cxl-disable-port.txt | 5 +----
 Documentation/cxl/cxl-enable-port.txt  | 5 +----
 Documentation/cxl/debug-option.txt     | 4 ++++
 Documentation/cxl/meson.build          | 1 +
 4 files changed, 7 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/cxl/debug-option.txt

diff --git a/Documentation/cxl/cxl-disable-port.txt b/Documentation/cxl/cxl-disable-port.txt
index ac56f20..7a22efc 100644
--- a/Documentation/cxl/cxl-disable-port.txt
+++ b/Documentation/cxl/cxl-disable-port.txt
@@ -30,10 +30,7 @@ OPTIONS
 	firmware and disabling an active device is akin to force removing memory
 	from a running system.
 
---debug::
-	If the cxl tool was built with debug disabled, turn on debug
-	messages.
-
+include::debug-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/cxl/cxl-enable-port.txt b/Documentation/cxl/cxl-enable-port.txt
index 9a37cef..50b53d1 100644
--- a/Documentation/cxl/cxl-enable-port.txt
+++ b/Documentation/cxl/cxl-enable-port.txt
@@ -31,10 +31,7 @@ OPTIONS
 	memdev is only enabled after all CXL ports in its device topology
 	ancestry are enabled.
 
---debug::
-	If the cxl tool was built with debug enabled, turn on debug
-	messages.
-
+include::debug-option.txt[]
 
 include::../copyright.txt[]
 
diff --git a/Documentation/cxl/debug-option.txt b/Documentation/cxl/debug-option.txt
new file mode 100644
index 0000000..70b922f
--- /dev/null
+++ b/Documentation/cxl/debug-option.txt
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--debug::
+	Turn on additional debug messages including library debug.
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index d019dfc..423be90 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -22,6 +22,7 @@ filedeps = [
   '../copyright.txt',
   'memdev-option.txt',
   'labels-options.txt',
+  'debug-option.txt',
 ]
 
 cxl_manpages = [
-- 
2.37.1

