Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A767C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Apr 2022 22:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiD1WN0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiD1WNZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Apr 2022 18:13:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C60A266F
        for <linux-cxl@vger.kernel.org>; Thu, 28 Apr 2022 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651183809; x=1682719809;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wTOhNnGM4fH3f48hOp4pX+ub4ekvi2i7bAZMl9dNetU=;
  b=GI8oYLPH2PhDC/jf03gQEBqshaavgMlOBb2YufLwRH4eCyhqgBQsBlYZ
   Nubohd63v/hg2+6lt7HCkyBOm6QGmPA0D6qucGYFVZ7/FkfTA50a0PmZw
   kzHJJ6DfYNiLkxnH+nILEBAlrlbQXiJg8uP6AiBTfWCfdNtfXSb2pnQ3P
   b07F+Z+TWi+3QZ9nPvJ+QOZh12scUIBXZVNbvQlrP+nJONQWm2pjLEXM8
   Puu9eipvIHyne3pa8aJ94bnyUgnpA0PCalcy/7qPBZe4WwApqyTEbQkTS
   k0dn+FcR/c/lxpAzn5epTvG+FA4Bs1dElO9VSncpKAQ3yXjzZLIxlVdRf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="291604800"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="291604800"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:10:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="534122457"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:10:06 -0700
Subject: [ndctl PATCH 01/10] build: Move utility helpers to libutil.a
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Thu, 28 Apr 2022 15:10:05 -0700
Message-ID: <165118380572.1676208.16232543117821121022.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165118380037.1676208.7644295506592461996.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165118380037.1676208.7644295506592461996.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Stop listing util/json.c and util/log.c per command, just add them to
the common libutil.a object.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/meson.build    |    2 --
 daxctl/meson.build |    1 -
 ndctl/meson.build  |    2 --
 util/meson.build   |    2 ++
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/cxl/meson.build b/cxl/meson.build
index 87cfea73e40b..671c8e1626ef 100644
--- a/cxl/meson.build
+++ b/cxl/meson.build
@@ -3,8 +3,6 @@ cxl_src = [
   'list.c',
   'port.c',
   'memdev.c',
-  '../util/json.c',
-  '../util/log.c',
   'json.c',
   'filter.c',
 ]
diff --git a/daxctl/meson.build b/daxctl/meson.build
index 8474d02f2c0d..8f27dd71b965 100644
--- a/daxctl/meson.build
+++ b/daxctl/meson.build
@@ -4,7 +4,6 @@ daxctl_src = [
   'list.c',
   'migrate.c',
   'device.c',
-  '../util/json.c',
   'json.c',
   'filter.c',
 ]
diff --git a/ndctl/meson.build b/ndctl/meson.build
index c7889af36084..050d5769c384 100644
--- a/ndctl/meson.build
+++ b/ndctl/meson.build
@@ -6,11 +6,9 @@ ndctl_src = [
   'check.c',
   'region.c',
   'dimm.c',
-  '../util/log.c',
   '../daxctl/filter.c',
   'filter.c',
   'list.c',
-  '../util/json.c',
   '../daxctl/json.c',
   'json.c',
   'json-smart.c',
diff --git a/util/meson.build b/util/meson.build
index 695037a924b9..a6ded7ee1473 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -3,6 +3,8 @@ util = static_library('util', [
   'parse-configs.c',
   'usage.c',
   'size.c',
+  'json.c',
+  'log.c',
   'main.c',
   'help.c',
   'strbuf.c',

