Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7ABC07E99
	for <linux-cxl@archiver.kernel.org>; Sat, 10 Jul 2021 01:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E380613C9
	for <linux-cxl@archiver.kernel.org>; Sat, 10 Jul 2021 01:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhGJBPa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Jul 2021 21:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhGJBP2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 9 Jul 2021 21:15:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D570DC0613DD
        for <linux-cxl@vger.kernel.org>; Fri,  9 Jul 2021 18:12:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b8-20020a17090a4888b02901725eedd346so7009136pjh.4
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jul 2021 18:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5P5PuZyafSwbyxbBKz7CUH21g9sFgp9pD+ZWs0x87I=;
        b=xV2Oduy2V5Vu8P+FKqV97cep3dEdhgM1joE4huw0PrHnZjnhkJfFRpI3JFPRnjzf8T
         39dwCBqPUboNJ/eOZePL6B2siymB808s3jtwII2jvf0TvCF6yzC3P3A/1czEedDPQd+7
         WHXoK9dhH1k569s0rmECDQZqorFecxKKf/AcyK3nMOOdEPAWNKrsrZ+PvM9vkYWl3i/w
         K/Xcudo4dZXxOBExl11D3E9hehQj+gbkfxZXv0iFfeAFbFwmbv835CmuTKL/GcFqJZ17
         Fa7u0+S8Ia3oIxsDCdf3pCnokB37f4oB/+fPwyh73GDlmf2NfqmSCHMjkFYEaMfjsSHC
         xX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5P5PuZyafSwbyxbBKz7CUH21g9sFgp9pD+ZWs0x87I=;
        b=m0LyaEtx5cFaR/uXrpFQ8o1h4cXVAZWET/x0RXf6FnQHTHM+tK4SxdC0fflRJ3g9Cs
         AYKtgHkkuuplEJyJ97ZcoyLcbC2QXxy/ttzyD/rbDcwz1MZLRiKWHOtTlaAcqBPsrEKq
         bgqCfhrix7tExjYKcf/ppXklYTznabzwfeHEb+Ar7y02ER+BRHdOmT16if/R6XCXHf1J
         l5gj3V0oU/aIbVQeoOG4n1xLjWjLJ5lcpVi9qJLTgp8kmFfMG+8H6QwOreajvDVOMQ2/
         uWvSv3KQaO7Tply3fmqDf1OZS4nD+Ym2Hz2uhreACwM2rOcIpSpUDr5Pi7mh/2xqkjaY
         SKbQ==
X-Gm-Message-State: AOAM531dAZR2aVv6wvE/tLRk0bnwEaHtaxgiteE1Wll/lQlEns5+BAcR
        yOzHFMCtbKG8ECjXHkOQPUsiHjfB1Isl1uH4IMH03w==
X-Google-Smtp-Source: ABdhPJy/rhpXWzoy9pK4K5Gver0TfYMBuJk7dyMx2xASR9/RDjjuVKhNcK74nYqPv+/HfMHSaccoAeuR3WHHCslhrVs=
X-Received: by 2002:a17:90a:8589:: with SMTP id m9mr1606514pjn.168.1625879564474;
 Fri, 09 Jul 2021 18:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210701201005.3065299-1-vishal.l.verma@intel.com> <20210701201005.3065299-2-vishal.l.verma@intel.com>
In-Reply-To: <20210701201005.3065299-2-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 9 Jul 2021 18:12:33 -0700
Message-ID: <CAPcyv4h8aD2ZOzySrzo2y96LNfuhxDp75RA+_YUWFFVHoO91Jg@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 01/21] ndctl: add .clang-format
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 1, 2021 at 1:10 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Copy the Linux kernel's .clang-format and modify it for ndctl. Only the
> 'ForEachMacros' section has been modified from the original kernel copy.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Nice!

Reviewed-by: Dan Williams <dan.j.williams@intel.com>


> ---
>  .clang-format | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 .clang-format
>
> diff --git a/.clang-format b/.clang-format
> new file mode 100644
> index 0000000..4e00fff
> --- /dev/null
> +++ b/.clang-format
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# clang-format configuration file. Intended for clang-format >= 4.
> +# Copied from Linux's .clang-format
> +#
> +# For more information, see:
> +#
> +#   https://clang.llvm.org/docs/ClangFormat.html
> +#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
> +#
> +---
> +AccessModifierOffset: -4
> +AlignAfterOpenBracket: Align
> +AlignConsecutiveAssignments: false
> +AlignConsecutiveDeclarations: false
> +#AlignEscapedNewlines: Left # Unknown to clang-format-4.0
> +AlignOperands: true
> +AlignTrailingComments: false
> +AllowAllParametersOfDeclarationOnNextLine: false
> +AllowShortBlocksOnASingleLine: false
> +AllowShortCaseLabelsOnASingleLine: false
> +AllowShortFunctionsOnASingleLine: None
> +AllowShortIfStatementsOnASingleLine: false
> +AllowShortLoopsOnASingleLine: false
> +AlwaysBreakAfterDefinitionReturnType: None
> +AlwaysBreakAfterReturnType: None
> +AlwaysBreakBeforeMultilineStrings: false
> +AlwaysBreakTemplateDeclarations: false
> +BinPackArguments: true
> +BinPackParameters: true
> +BraceWrapping:
> +  AfterClass: false
> +  AfterControlStatement: false
> +  AfterEnum: false
> +  AfterFunction: true
> +  AfterNamespace: true
> +  AfterObjCDeclaration: false
> +  AfterStruct: false
> +  AfterUnion: false
> +  #AfterExternBlock: false # Unknown to clang-format-5.0
> +  BeforeCatch: false
> +  BeforeElse: false
> +  IndentBraces: false
> +  #SplitEmptyFunction: true # Unknown to clang-format-4.0
> +  #SplitEmptyRecord: true # Unknown to clang-format-4.0
> +  #SplitEmptyNamespace: true # Unknown to clang-format-4.0
> +BreakBeforeBinaryOperators: None
> +BreakBeforeBraces: Custom
> +#BreakBeforeInheritanceComma: false # Unknown to clang-format-4.0
> +BreakBeforeTernaryOperators: false
> +BreakConstructorInitializersBeforeComma: false
> +#BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
> +BreakAfterJavaFieldAnnotations: false
> +BreakStringLiterals: false
> +ColumnLimit: 80
> +CommentPragmas: '^ IWYU pragma:'
> +#CompactNamespaces: false # Unknown to clang-format-4.0
> +ConstructorInitializerAllOnOneLineOrOnePerLine: false
> +ConstructorInitializerIndentWidth: 8
> +ContinuationIndentWidth: 8
> +Cpp11BracedListStyle: false
> +DerivePointerAlignment: false
> +DisableFormat: false
> +ExperimentalAutoDetectBinPacking: false
> +#FixNamespaceComments: false # Unknown to clang-format-4.0
> +
> +# Taken from:
> +# while read -r sym; do
> +#      printf "  - '%s'\n" "$sym";
> +# done < \
> +#      <(cscope -dL6 "foreach|for_each" \
> +#      | awk '{ print $4 $5 }' | grep -E 'foreach|for_each' \
> +#      | sed -e 's/#define//' \
> +#              -e 's/*//' \
> +#              -e 's/://' \
> +#              -e 's/\(.*for_each.*\)(.*/\1/' \
> +#              -e 's/\(.*foreach.*\)(.*/\1/' \
> +#      | sort -u)
> +ForEachMacros:
> +  - 'daxctl_dev_foreach'
> +  - 'daxctl_mapping_foreach'
> +  - 'daxctl_region_foreach'
> +  - 'kmod_list_foreach'
> +  - 'kmod_list_foreach_reverse'
> +  - 'list_for_each'
> +  - 'list_for_each_off'
> +  - 'list_for_each_rev'
> +  - 'list_for_each_safe'
> +  - 'list_for_each_safe_off'
> +  - 'ndctl_btt_foreach'
> +  - 'ndctl_btt_foreach_safe'
> +  - 'ndctl_bus_foreach'
> +  - 'ndctl_dax_foreach'
> +  - 'ndctl_dax_foreach_safe'
> +  - 'ndctl_dimm_foreach'
> +  - 'ndctl_dimm_foreach_in_interleave_set'
> +  - 'ndctl_dimm_foreach_in_region'
> +  - 'ndctl_interleave_set_foreach'
> +  - 'ndctl_mapping_foreach'
> +  - 'ndctl_namespace_badblock_foreach'
> +  - 'ndctl_namespace_bb_foreach'
> +  - 'ndctl_namespace_foreach'
> +  - 'ndctl_namespace_foreach_safe'
> +  - 'ndctl_pfn_foreach'
> +  - 'ndctl_pfn_foreach_safe'
> +  - 'ndctl_region_badblock_foreach'
> +  - 'ndctl_region_foreach'
> +  - 'udev_list_entry_foreach'
> +
> +#IncludeBlocks: Preserve # Unknown to clang-format-5.0
> +IncludeCategories:
> +  - Regex: '.*'
> +    Priority: 1
> +IncludeIsMainRegex: '(Test)?$'
> +IndentCaseLabels: false
> +#IndentPPDirectives: None # Unknown to clang-format-5.0
> +IndentWidth: 8
> +IndentWrappedFunctionNames: false
> +JavaScriptQuotes: Leave
> +JavaScriptWrapImports: true
> +KeepEmptyLinesAtTheStartOfBlocks: false
> +MacroBlockBegin: ''
> +MacroBlockEnd: ''
> +MaxEmptyLinesToKeep: 1
> +NamespaceIndentation: None
> +#ObjCBinPackProtocolList: Auto # Unknown to clang-format-5.0
> +ObjCBlockIndentWidth: 8
> +ObjCSpaceAfterProperty: true
> +ObjCSpaceBeforeProtocolList: true
> +
> +# Taken from git's rules
> +#PenaltyBreakAssignment: 10 # Unknown to clang-format-4.0
> +PenaltyBreakBeforeFirstCallParameter: 30
> +PenaltyBreakComment: 10
> +PenaltyBreakFirstLessLess: 0
> +PenaltyBreakString: 10
> +PenaltyExcessCharacter: 100
> +PenaltyReturnTypeOnItsOwnLine: 60
> +
> +PointerAlignment: Right
> +ReflowComments: false
> +SortIncludes: false
> +#SortUsingDeclarations: false # Unknown to clang-format-4.0
> +SpaceAfterCStyleCast: false
> +SpaceAfterTemplateKeyword: true
> +SpaceBeforeAssignmentOperators: true
> +#SpaceBeforeCtorInitializerColon: true # Unknown to clang-format-5.0
> +#SpaceBeforeInheritanceColon: true # Unknown to clang-format-5.0
> +SpaceBeforeParens: ControlStatements
> +#SpaceBeforeRangeBasedForLoopColon: true # Unknown to clang-format-5.0
> +SpaceInEmptyParentheses: false
> +SpacesBeforeTrailingComments: 1
> +SpacesInAngles: false
> +SpacesInContainerLiterals: false
> +SpacesInCStyleCastParentheses: false
> +SpacesInParentheses: false
> +SpacesInSquareBrackets: false
> +Standard: Cpp03
> +TabWidth: 8
> +UseTab: Always
> +...
> --
> 2.31.1
>
