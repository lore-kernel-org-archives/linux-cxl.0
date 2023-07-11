Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA32BC001B0
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jul 2023 17:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGKR6P (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjGKR6O (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jul 2023 13:58:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9B8170C
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689098293; x=1720634293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LrQ2feoJb0lTsvXApIj7daksJddOoRFr0OInB5Y1dyY=;
  b=UHdl2L60oaP+rSAOip/nZnPYtxuhmG2rpgqgGfiiP7osWNTeUA0eCR1i
   iWFn+kI4JPQu2RB/UQU/hDB/jmmQQcgtTb8jDqJOk7HuwA+AKB5q57wHB
   mtymP0HgvguDa57j2t8lNNt1htvTsAzBEFq6V3jSkFdt1qz77HRIkYp3q
   frqiRFBQEzczC6qYGYiZGgIIfHtqxt2F4oEglc4T5cAdLsKcy3pWBeCej
   cjBujV3MRnOxzqTLsGzQ5A0A7aolyFF2TFwWrhawFKX3ji968+cBURgmw
   A+ddhLRA6KGvs2IIDxDvHBZ0IbAhRcRKHx8NHkiAQKXpJfaxr6VyPb0g/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362159131"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362159131"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:58:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715255731"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="715255731"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.140.181])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:58:12 -0700
Date:   Tue, 11 Jul 2023 10:58:11 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [ndctl PATCH v4 3/4] ndctl: use strcmp for reserved word in
 monitor commands
Message-ID: <ZK2YM7nlCrEmz1+9@aschofie-mobl2>
References: <20230711115344.562823-1-lizhijian@fujitsu.com>
 <20230711115344.562823-4-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711115344.562823-4-lizhijian@fujitsu.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jul 11, 2023 at 07:53:43PM +0800, Li Zhijian wrote:
> According to the tool's documentation, when '-l standard' is specified,
> log would be output to the stdout. But since it's using strncmp(a, b, 10)
> to compare the former 10 characters, it will also wrongly detect a filename
> starting with a substring 'standard' as stdout.
> 
> For example:
> $ cxl monitor -l standard.log
> 
> User is most likely want to save log to ./standard.log instead of stdout.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V4: combine ndctl/monitor to one patch
> V3: Improve commit log # Dave
> V2: commit log updated # Dave
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  cxl/monitor.c   | 2 +-
>  ndctl/monitor.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/cxl/monitor.c b/cxl/monitor.c
> index e83455b63d35..a85452a4dc82 100644
> --- a/cxl/monitor.c
> +++ b/cxl/monitor.c
> @@ -188,7 +188,7 @@ int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx)
>  	else
>  		monitor.ctx.log_priority = LOG_INFO;
>  
> -	if (strncmp(log, "./standard", 10) == 0)
> +	if (strcmp(log, "./standard") == 0)
>  		monitor.ctx.log_fn = log_standard;
>  	else {
>  		monitor.ctx.log_file = fopen(log, "a+");
> diff --git a/ndctl/monitor.c b/ndctl/monitor.c
> index 89903def63d4..bd8a74863476 100644
> --- a/ndctl/monitor.c
> +++ b/ndctl/monitor.c
> @@ -610,9 +610,9 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
>  	if (monitor.log) {
>  		if (strncmp(monitor.log, "./", 2) != 0)
>  			fix_filename(prefix, (const char **)&monitor.log);
> -		if (strncmp(monitor.log, "./syslog", 8) == 0)
> +		if (strcmp(monitor.log, "./syslog") == 0)
>  			monitor.ctx.log_fn = log_syslog;
> -		else if (strncmp(monitor.log, "./standard", 10) == 0)
> +		else if (strcmp(monitor.log, "./standard") == 0)
>  			monitor.ctx.log_fn = log_standard;
>  		else {
>  			monitor.ctx.log_file = fopen(monitor.log, "a+");
> -- 
> 2.29.2
> 
