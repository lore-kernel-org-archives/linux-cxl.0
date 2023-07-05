Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA7CEB64DA
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jul 2023 23:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGEXx3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Jul 2023 19:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGEXx3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 5 Jul 2023 19:53:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E507CF
        for <linux-cxl@vger.kernel.org>; Wed,  5 Jul 2023 16:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688601208; x=1720137208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vfwj2TrdfZRsha2Ytu1/Llppjw/vL7dUZrBaGpysVdE=;
  b=c/8dtrr81dyrrhHpRY3mx71y1ftzhpJOVbamEcIzhsMrVS2hmotz0ooK
   sf0djxAw7Bw0OmWXsU0UOdG664vjYPyQlENyyX32bQ4L8KntBl2X/LAaA
   wIJ+woTp8VbGQAMOAfXA2SP2BeOkgZVSbh3xma7CIiVHCL/0vccIkDiN8
   jiUQgCSI2p6QVgxtbzJV1ZyrGCi4/Rk0JQffuNlT3EBjJaJRSEk3AIAT2
   hXf2/HDhinCjZBPTODkKthmJroIlI0SzOkCGTSQNHlvbVRnpNzBgfb4cN
   Ww0cynUn7XAVykpcukyR2HJu0vkJaYlXgOghVJBXKE/vcrI/kcZc/AWW7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="360940571"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="360940571"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 16:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="843464546"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="843464546"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.61.134])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 16:53:27 -0700
Date:   Wed, 5 Jul 2023 16:53:25 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        dave.jiang@intel.com
Subject: Re: [ndctl PATCH v3 0/6] cxl/monitor and ndctl/monitor fixes
Message-ID: <ZKYCdf2RP3+3BMhi@aschofie-mobl2>
References: <20230531021936.7366-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531021936.7366-1-lizhijian@fujitsu.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 31, 2023 at 10:19:30AM +0800, Li Zhijian wrote:
> V3:
> - update comit log of patch3 and patch6 per Dave's comments.
> 
> V2:
> - exchange order of previous patch1 and patch2
> - add reviewed tag in patch5
> - commit log improvements
> 
> It mainly fix monitor not working when log file is specified. For
> example
> $ cxl monitor -l ./cxl-monitor.log
> It seems that someone missed something at the begining.
> 
> Furture, it compares the filename with reserved word more accurately
> 
> patch1-2: It re-enables logfile(including default_log) functionality
> and simplify the sanity check in the combination relative path file
> and daemon mode.
> 
> patch3 and patch6 change strncmp to strcmp to compare the acurrate
> reserved words.
> 
> Li Zhijian (6):
>   cxl/monitor: Enable default_log and refactor sanity check
>   cxl/monitor: replace monitor.log_file with monitor.ctx.log_file
>   cxl/monitor: use strcmp to compare the reserved word
>   cxl/monitor: always log started message
>   Documentation/cxl/cxl-monitor.txt: Fix inaccurate description
>   ndctl/monitor: use strcmp to compare the reserved word

Hi,

Patches 3 & 6 make the same change in 2 different files, with
near identical commit logs. Please consider combining them into
one patch, perhaps something like:

ndctl: use strcmp for reserved word in monitor commands

Thanks,
Alison

> 
>  Documentation/cxl/cxl-monitor.txt |  3 +--
>  cxl/monitor.c                     | 45 ++++++++++++++++---------------
>  ndctl/monitor.c                   |  4 +--
>  3 files changed, 26 insertions(+), 26 deletions(-)
> 
> -- 
> 2.29.2
> 
