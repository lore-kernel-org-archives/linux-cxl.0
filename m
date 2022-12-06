Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25243C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 22:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLFWrO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 17:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLFWqz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 17:46:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765AC4A596
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 14:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670366804; x=1701902804;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=a794AuGbH/PH6NpfV+HpFvRv1ixTVY/j1Ps0zvxgrqo=;
  b=gCQ86CaJVm+jCmwJh7aTi3xfSjWHqOBS9WNG2T3HYQIbxQCFG2LTYKix
   BhyiCOUCB+xB+oyrwfPc2WXXeXuh/H+hMPw24ACvh0jV9oiJ4ZD3NWfue
   gZ6GIE3lrTDHkDjcpwZ45uF5kSfIDLnUQLe6rwqfmGnhaUGfJ4+wDcFmi
   ADhCtljmBdSAUGhc4FBqquazOUQpa1N31Vxyli2QhS3tcttFVB8gx91ye
   SX5b8+heJAHNBtdCALDJDPvgYO5XCsPq7B8nZxcYWUCmj+g76sPb4wsw6
   U7eNiQcgIWmAYNvBHvebunrAOLsFM3JgTR4osW7DaGUVOPD0SMEvokZDm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="315462745"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="315462745"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 14:46:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="714967834"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="714967834"
Received: from yguo-mobl1.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.212.82.140])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 14:46:26 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Tue, 06 Dec 2022 15:46:24 -0700
Subject: [PATCH ndctl 2/2] meson.build: add a check argument to run_command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221206-vv-misc-v1-2-4c5bd58c90ca@intel.com>
References: <20221206-vv-misc-v1-0-4c5bd58c90ca@intel.com>
In-Reply-To: <20221206-vv-misc-v1-0-4c5bd58c90ca@intel.com>
To:     nvdimm@lists.linux.dev
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
X-Mailer: b4 0.11.0-dev-b6525
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=a794AuGbH/PH6NpfV+HpFvRv1ixTVY/j1Ps0zvxgrqo=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMn9x5xkq+J/piUlTlSb1XguYuL65axXrpku2bEh32mK7N2r
 PG0eHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZhInyXD/+ib+ix7N0fN4DYxM4wS3F
 BaqXer2NTjgvme/rwWycnSygz/g3OMHryesuNVVqnL3XDP1Sm/rPZ+XSQqGDVxk9HtOwGezAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Meson has started to warn about:

  WARNING: You should add the boolean check kwarg to the run_command call.
         It currently defaults to false,
         but it will default to true in future releases of meson.
         See also: https://github.com/mesonbuild/meson/issues/9300

There is one instance of run_command() in the top-level meson.build
which elides the explicit check argument. Since we don't care about the
result of clean_config.sh (if any config.h are found they will be
cleaned, and if none are found, we're fine), add a 'check: false'
argument to this and squelch the warning.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 20a646d..33ed0ed 100644
--- a/meson.build
+++ b/meson.build
@@ -89,6 +89,7 @@ env = find_program('env')
 if git.found()
   run_command('clean_config.sh',
     env : 'GIT_DIR=@0@/.git'.format(project_source_root),
+    check : false,
   )
 endif
 

-- 
2.38.1
