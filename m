Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1276C433C1
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848296023C
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 18:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbhCXSnM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Mar 2021 14:43:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:57980 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237598AbhCXSm7 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 24 Mar 2021 14:42:59 -0400
IronPort-SDR: 2WTxByD4qvYRrZRYG0j9IpCl9FHw4p1KO8C0Y2jeldT3LJaToe+d/GgGGI5WKtfHCkfDNzk1kC
 uEAv7sIZfCPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="188469687"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="188469687"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:42:59 -0700
IronPort-SDR: //PXagpZka724rzCYPJkuPQg8GC3CvIT+idH94eQjhvv5X0hlaMN6OBcwucgj69H+T/0dehZxF
 MidM/1Q+qXgw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="514299493"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:42:58 -0700
Date:   Wed, 24 Mar 2021 11:42:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/mem: Force array size of mem_commands[] to
 CXL_MEM_COMMAND_ID_MAX
Message-ID: <20210324184257.GV3014244@iweiny-DESK2.sc.intel.com>
References: <20210324141635.22335-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324141635.22335-1-rrichter@amd.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 24, 2021 at 03:16:35PM +0100, Robert Richter wrote:
> Typically the mem_commands[] array is in sync with 'enum { CXL_CMDS }'.
> Current code works well.
> 
> However, the array size of mem_commands[] may not strictly be the same
> as CXL_MEM_COMMAND_ID_MAX. E.g. if a new CXL_CMD() is added that is
> guarded by #ifdefs, the array could be shorter. This could lead then
> further to an out-of-bounds array access in cxl_validate_cmd_from_user().
> 
> Fix this by forcing the array size to CXL_MEM_COMMAND_ID_MAX. This
> also adds range checks for array items in mem_commands[] at compile
> time.

Can't we use ARRAY_SIZE?

Ira

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 244cb7d89678..ecfc9ccdba8d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -169,7 +169,7 @@ struct cxl_mem_command {
>   * table will be validated against the user's input. For example, if size_in is
>   * 0, and the user passed in 1, it is an error.
>   */
> -static struct cxl_mem_command mem_commands[] = {
> +static struct cxl_mem_command mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
>  #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
>  	CXL_CMD(RAW, ~0, ~0, 0),
> -- 
> 2.29.2
> 
