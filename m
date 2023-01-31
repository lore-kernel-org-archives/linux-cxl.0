Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D27C61DA4
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 00:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjAaAtS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 19:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjAaAtR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 19:49:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A91E2A4
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 16:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675126156; x=1706662156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9hRIhFDf/VeTIhsYoTkIKPm8Wy+goz8pI/7Xobwwp4=;
  b=BgWi9LbjdsseAOGot56VSzEHHqRLlPCs+afSkZGXEO25uYjii9SIPpv1
   6ddyuAVcSkT+xdxmGVuYXSjl2fecVNeK01hOAz3p3CJkmCZq9ifie+aTl
   VCTVB6sk2mz/rSxLTS1xE3WZ2iMfkOio9wTKlI1VOEKZ8nJptL5odgfGG
   KdHqcnK4sE0HDxQXAOdQ16rP/BJ0SMsvxDDS0ALLkgQfkL5MUVRjvVV/F
   s1D3k9tuRMWQdF+Fslq05CE/bccttWGzPVPN5y8PTxvUXJNd61mDcYOLa
   16P4FQ7N3SkfEXbi8MWXhm2VFaXMaXKx9RxWq+9bvS3fqkCeQ29vEr+i2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="392266649"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="392266649"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 16:49:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="788236066"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="788236066"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.254.37])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 16:49:15 -0800
Date:   Mon, 30 Jan 2023 16:49:13 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/4] cxl/uapi: Only return valid commands from
 cxl_query_cmd()
Message-ID: <Y9hliSIGqYAZwk4o@aschofie-mobl2>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
 <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222-cxl-misc-v2-3-60403cc37257@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 27, 2023 at 04:09:40PM -0800, Ira Weiny wrote:
> It was pointed out that commands not supported by the device or excluded
> by the kernel were being returned in cxl_query_cmd().[1]
> 
> While libcxl correctly handles failing commands, it is more efficient to
> not issue an invalid command in the first place.
> 
> Exclude both kernel exclusive and disabled commands from the list of
> commands returned by cxl_query_cmd().

Hi Ira,
I have read everyone's responses here, and I'm not sure where to
append mine, so I'll spit it out right here.

This is great to clean up as we (or at least me) keep stumbling on it.

'Excluding kernel exclusive and disable commands from the list'  may not
tell user what they want to know. It seems you are after these 3 bits
of info:

1) does my device support this cmd
2) does the driver support this cmd
3) is user allowed to run this cmd (ie..or is it kernel reserved).

Can we crisply impart this status, all of  it, in query cmd?

Note that I'm thinking you deliver the whole truth, not piecemeal.
ie. Don't tell me that my device doesn't support it, then I go off
and try another device that supports it, only to find out that the
driver doesn't support it, and....rat hole deepens, then I see
driver support added, only to find out it's exclusive to kernel. ;)

I'm assuming kernel exclusive includes raw command not allowed.

Thanks for getting this all tidy'd up Ira,
Alison

> 
> [1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v2:
> 	New patch
> ---
>  drivers/cxl/core/mbox.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..a1618b7f01e5 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -326,12 +326,27 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>  	return 0;
>  }
>  
> +/* Return 0 if the cmd id is available for userspace */
> +static int cxl_cmd_id_user(__u32 id, struct cxl_dev_state *cxlds)
> +{
> +	/* Check that the command is enabled for hardware */
> +	if (!test_bit(id, cxlds->enabled_cmds))
> +		return -ENOTTY;
> +
> +	/* Check that the command is not claimed for exclusive kernel use */
> +	if (test_bit(id, cxlds->exclusive_cmds))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
>  static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
>  			  const struct cxl_send_command *send_cmd,
>  			  struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
>  	const struct cxl_command_info *info = &c->info;
> +	int rc;
>  
>  	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
>  		return -EINVAL;
> @@ -342,13 +357,9 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
>  	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
>  		return -EINVAL;
>  
> -	/* Check that the command is enabled for hardware */
> -	if (!test_bit(info->id, cxlds->enabled_cmds))
> -		return -ENOTTY;
> -
> -	/* Check that the command is not claimed for exclusive kernel use */
> -	if (test_bit(info->id, cxlds->exclusive_cmds))
> -		return -EBUSY;
> +	rc = cxl_cmd_id_user(info->id, cxlds);
> +	if (rc)
> +		return rc;
>  
>  	/* Check the input buffer is the expected size */
>  	if ((info->size_in != CXL_VARIABLE_PAYLOAD) &&
> @@ -446,9 +457,15 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  	 */
>  	cxl_for_each_cmd(cmd) {
>  		const struct cxl_command_info *info = &cmd->info;
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +		int rc;
>  
> -		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> -			return -EFAULT;
> +		rc = cxl_cmd_id_user(info->id, cxlds);
> +		if (!rc) {
> +			if (copy_to_user(&q->commands[j++], info,
> +					 sizeof(*info)))
> +				return -EFAULT;
> +		}
>  
>  		if (j == n_commands)
>  			break;
> 
> -- 
> 2.39.1
