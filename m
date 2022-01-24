Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD59C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiAXAwG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:37224 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAwF (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985525; x=1674521525;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/n08efVd4FlVzj6lSAF+42Bux11O+fcmeLoS0iVckmA=;
  b=EYEf4soOHj0l9tPNww0TlfQ5+weGmYSOfFGg/yDzanr70yE6m4DkGzgc
   w5xJFO/MTg32JA6XfVC9epqmv684FEt3uZSkZ5HpWgV4yilehRIy0u5q4
   wNBZIyftTsfsTUAHfNDEVV0Dbrh3aFBphCAP/YWBgKFYMfDUFJmijOKlw
   SHlzc/hSIQtl8HZSK9GOsEDWbxpl8uHW1rwhcM1aICNH1bt8XCqEtsMm6
   88jDYKiAW6WE7Re6BY9QTvxKexG/q8nOKWpCV+f510YrSH+dlXrLUF7G2
   u7wHMrNnxCgjbZzT0v0hNKUVc+VXLzD6XNvOgoxmf4Q9ymR4ECM6ta3Lz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233293921"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233293921"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="519735695"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:05 -0800
Subject: [ndctl PATCH 03/37] build: Add tags
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:52:05 -0800
Message-ID: <164298552547.3021641.2951502977152843738.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Copy the systemd approach to generating tags with a file listing from git.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 meson.build |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/meson.build b/meson.build
index b22fb2e57f6b..68f3d0ceff1c 100644
--- a/meson.build
+++ b/meson.build
@@ -82,6 +82,7 @@ project_source_root = meson.current_source_dir()
 # Cleanup the leftover config.h files to avoid conflicts with the meson
 # generated config.h
 git = find_program('git', required : false)
+env = find_program('env')
 if git.found()
   run_command('clean_config.sh',
     env : 'GIT_DIR=@0@/.git'.format(project_source_root),
@@ -111,6 +112,24 @@ else
   )
 endif
 
+if git.found()
+  all_files = run_command(
+    env, '-u', 'GIT_WORK_TREE',
+    git, '--git-dir=@0@/.git'.format(project_source_root),
+         'ls-files', ':/*.[ch]',
+    check : false)
+  if all_files.returncode() == 0
+    all_files = files(all_files.stdout().split())
+    custom_target(
+            'tags',
+            output : 'tags',
+            command : [env, 'etags', '-o', '@0@/TAGS'.format(project_source_root)] + all_files)
+    run_target(
+            'ctags',
+            command : [env, 'ctags', '-o', '@0@/tags'.format(project_source_root)] + all_files)
+  endif
+endif
+
 versiondep = declare_dependency(
   compile_args: ['-include', 'version.h'],
   sources: version_h

