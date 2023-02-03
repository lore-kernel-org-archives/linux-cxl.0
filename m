Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A47FC61DA4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Feb 2023 22:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBCWas (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Feb 2023 17:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBCWas (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Feb 2023 17:30:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B6B11A
        for <linux-cxl@vger.kernel.org>; Fri,  3 Feb 2023 14:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675463447; x=1706999447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yg0GC+9CH25d/wlDJ54AqKgSWxw5tQBjQx7bmNUPUQE=;
  b=XBzikcSZlBz8XfBm107Fhbsnx7wosf+THXEOUCBtOKPsJQoNXXKeszd2
   mNsHN6Yc+W1scJSW5SLqhVTC5ueM4EcFTn9WmmFyTPEE4hOTzr+AHUFxf
   ueH2OR2pCqQKjNGtRoEdBcZdyi6yjkY1pGmc887/y/jlNv9Pwh1/PFXtA
   b8j5G2yXETIAERdsZFU81vTWLh9J8y/mvvvlo0juptCmaVQlXexzZIWlj
   aEsR9ansV5HV5nhPA+rxhR1UHhvcyBxrmb7nlACVuc/E1VXTdDXTcFnp2
   5d4Lyx93iThfHTjdVoMcGL38hBnFc5uAv+lyHyLxZ0IokiCNoPpQjV1Wg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="308513876"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="308513876"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 14:30:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="994654538"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="994654538"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.119.40]) ([10.212.119.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 14:30:46 -0800
Message-ID: <9146dc1c-275f-5116-d537-199914f9f74f@intel.com>
Date:   Fri, 3 Feb 2023 15:30:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH ndctl] ndctl/cxl: Remove unnecessary null check
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org
References: <20230201-update_query-v1-1-4dd3de2d35c1@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230201-update_query-v1-1-4dd3de2d35c1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/3/23 2:56 PM, Ira Weiny wrote:
> cmd->query_cmd can never be null in cxl_cmd_alloc_send().  The only call chain
> is:
> 
>          cxl_cmd_do_query(cmd);
>          cxl_cmd_validate(cmd, cmd_id);
>          cxl_cmd_alloc_send(cmd, cmd_id);
> 
> And cxl_cmd_do_query() ensures it is non-null.  In addition the local variable
> query is already dereferenced by the time it is checked for null.
> 
> Remove the unneeded null check.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Minor fix I found while working on the kernel side query command.
> ---
>   cxl/lib/libcxl.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 4205a587d3bb..4859bd5e2fbb 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -3091,9 +3091,6 @@ static int cxl_cmd_alloc_send(struct cxl_cmd *cmd, u32 cmd_id)
>   	struct cxl_command_info *cinfo = &query->commands[cmd->query_idx];
>   	size_t size;
>   
> -	if (!query)
> -		return -EINVAL;
> -
>   	size = sizeof(struct cxl_send_command);
>   	cmd->send_cmd = calloc(1, size);
>   	if (!cmd->send_cmd)
> 
> ---
> base-commit: b73e4e0390aae822bc91b8bf72430e6f0e84d668
> change-id: 20230201-update_query-ad2845ba197a
> 
> Best regards,
