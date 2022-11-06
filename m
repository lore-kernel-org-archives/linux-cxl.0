Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E41C433FE
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Nov 2022 23:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKFXrG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Nov 2022 18:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKFXrE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Nov 2022 18:47:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03463D2C8
        for <linux-cxl@vger.kernel.org>; Sun,  6 Nov 2022 15:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667778423; x=1699314423;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PmnMB0EJo7BqWBD1GuQkF9aVenGk+FT0gRp/npgZFcs=;
  b=JZkDn0KUMdvcZgqjpS+08t7bFHM141RPSbyHQ6eSCuv8aTUAPS5xORor
   4YxpMgi6eW0DanuWBkEBBMrGgR1qC+Z0gCT7cBrE8JTWIUuQKNVaxZcaa
   4h8pwOFT03kDTIQSVuvAf5tuUc4OsvUIMRf70H3npZB8QQfl9+RoqPYmV
   oNU2gUepcoYt/WV8GMb6KUVapzZRUY56DrOvp90CedpbJc6AoSDqBRA60
   v22BlGS3KQuT9Bmyorvx3h6Nv5xkcHhexj4CGox2fR+oRlF+kJaKdkt1C
   yxF0QFAnLAaq4siG7MewV38VUyYJYXC76jg6VEB3DDOp+7/aW2buYIjC3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="307916064"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="307916064"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:47:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="964951346"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="964951346"
Received: from durgasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.240.219])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:47:03 -0800
Subject: [ndctl PATCH 03/15] ndctl/clang-format: Move minimum version to 6
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 06 Nov 2022 15:47:03 -0800
Message-ID: <166777842304.1238089.14893633815148907315.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
References: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Follow the kernel change that did the same:

sed -i 's/^\(\s*\)#\(\S*\s\+\S*\) # Unknown to clang-format.*/\1\2/' .clang-format

commit 96232c7d4f84 ("clang-format: Update to clang-format >= 6")

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .clang-format |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/.clang-format b/.clang-format
index b6169e15097c..f372823c3248 100644
--- a/.clang-format
+++ b/.clang-format
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# clang-format configuration file. Intended for clang-format >= 4.
+# clang-format configuration file. Intended for clang-format >= 6.
 # Copied from Linux's .clang-format
 #
 # For more information, see:
@@ -13,7 +13,7 @@ AccessModifierOffset: -4
 AlignAfterOpenBracket: Align
 AlignConsecutiveAssignments: false
 AlignConsecutiveDeclarations: false
-#AlignEscapedNewlines: Left # Unknown to clang-format-4.0
+AlignEscapedNewlines: Left
 AlignOperands: true
 AlignTrailingComments: false
 AllowAllParametersOfDeclarationOnNextLine: false
@@ -37,24 +37,24 @@ BraceWrapping:
   AfterObjCDeclaration: false
   AfterStruct: false
   AfterUnion: false
-  #AfterExternBlock: false # Unknown to clang-format-5.0
+  AfterExternBlock: false
   BeforeCatch: false
   BeforeElse: false
   IndentBraces: false
-  #SplitEmptyFunction: true # Unknown to clang-format-4.0
-  #SplitEmptyRecord: true # Unknown to clang-format-4.0
-  #SplitEmptyNamespace: true # Unknown to clang-format-4.0
+  SplitEmptyFunction: true
+  SplitEmptyRecord: true
+  SplitEmptyNamespace: true
 BreakBeforeBinaryOperators: None
 BreakBeforeBraces: Custom
-#BreakBeforeInheritanceComma: false # Unknown to clang-format-4.0
+BreakBeforeInheritanceComma: false
 BreakBeforeTernaryOperators: false
 BreakConstructorInitializersBeforeComma: false
-#BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
+BreakConstructorInitializers: BeforeComma
 BreakAfterJavaFieldAnnotations: false
 BreakStringLiterals: false
 ColumnLimit: 80
 CommentPragmas: '^ IWYU pragma:'
-#CompactNamespaces: false # Unknown to clang-format-4.0
+CompactNamespaces: false
 ConstructorInitializerAllOnOneLineOrOnePerLine: false
 ConstructorInitializerIndentWidth: 8
 ContinuationIndentWidth: 8
@@ -62,7 +62,7 @@ Cpp11BracedListStyle: false
 DerivePointerAlignment: false
 DisableFormat: false
 ExperimentalAutoDetectBinPacking: false
-#FixNamespaceComments: false # Unknown to clang-format-4.0
+FixNamespaceComments: false
 
 # Taken from:
 # while read -r sym; do
@@ -118,13 +118,13 @@ ForEachMacros:
   - 'ndctl_region_foreach'
   - 'udev_list_entry_foreach'
 
-#IncludeBlocks: Preserve # Unknown to clang-format-5.0
+IncludeBlocks: Preserve
 IncludeCategories:
   - Regex: '.*'
     Priority: 1
 IncludeIsMainRegex: '(Test)?$'
 IndentCaseLabels: false
-#IndentPPDirectives: None # Unknown to clang-format-5.0
+IndentPPDirectives: None
 IndentWidth: 8
 IndentWrappedFunctionNames: false
 JavaScriptQuotes: Leave
@@ -134,13 +134,13 @@ MacroBlockBegin: ''
 MacroBlockEnd: ''
 MaxEmptyLinesToKeep: 1
 NamespaceIndentation: None
-#ObjCBinPackProtocolList: Auto # Unknown to clang-format-5.0
+ObjCBinPackProtocolList: Auto
 ObjCBlockIndentWidth: 8
 ObjCSpaceAfterProperty: true
 ObjCSpaceBeforeProtocolList: true
 
 # Taken from git's rules
-#PenaltyBreakAssignment: 10 # Unknown to clang-format-4.0
+PenaltyBreakAssignment: 10
 PenaltyBreakBeforeFirstCallParameter: 30
 PenaltyBreakComment: 10
 PenaltyBreakFirstLessLess: 0
@@ -151,14 +151,14 @@ PenaltyReturnTypeOnItsOwnLine: 60
 PointerAlignment: Right
 ReflowComments: false
 SortIncludes: false
-#SortUsingDeclarations: false # Unknown to clang-format-4.0
+SortUsingDeclarations: false
 SpaceAfterCStyleCast: false
 SpaceAfterTemplateKeyword: true
 SpaceBeforeAssignmentOperators: true
-#SpaceBeforeCtorInitializerColon: true # Unknown to clang-format-5.0
-#SpaceBeforeInheritanceColon: true # Unknown to clang-format-5.0
+SpaceBeforeCtorInitializerColon: true
+SpaceBeforeInheritanceColon: true
 SpaceBeforeParens: ControlStatements
-#SpaceBeforeRangeBasedForLoopColon: true # Unknown to clang-format-5.0
+SpaceBeforeRangeBasedForLoopColon: true
 SpaceInEmptyParentheses: false
 SpacesBeforeTrailingComments: 1
 SpacesInAngles: false

