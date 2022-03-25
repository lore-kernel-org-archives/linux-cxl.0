Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E22C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 10:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358853AbiCYK3E (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245022AbiCYK3E (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 06:29:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11EDBD2E7
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 03:27:29 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPysd4ZlBz683mQ;
        Fri, 25 Mar 2022 18:25:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 11:27:27 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 10:27:26 +0000
Date:   Fri, 25 Mar 2022 10:27:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] cxl/mbox: Move cxl_mem_command construction to
 helper funcs
Message-ID: <20220325102724.0000144d@huawei.com>
In-Reply-To: <20220324011126.1144504-2-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
        <20220324011126.1144504-2-alison.schofield@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 23 Mar 2022 18:11:18 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Sanitizing and constructing a cxl_mem_command from a userspace
> command is part of the validation process prior to submitting
> the command to a CXL device. Move this work to helper functions:
> cxl_to_mem_cmd(), cxl_to_mem_cmd_raw().
> 
> This declutters cxl_validate_cmd_from_user() in preparation for
> adding new validation steps.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

A few trivial comments inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 158 +++++++++++++++++++++-------------------
>  1 file changed, 85 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index be61a0d8016b..6612d73c37a8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -207,6 +207,84 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>  	return true;
>  }
>  
> +static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
> +			      const struct cxl_send_command *send_cmd,
> +			      struct cxl_mem_command *mem_cmd)
> +{
> +	if (send_cmd->raw.rsvd)
> +		return -EINVAL;

trivial: Blank line here would be good.

> +	/*
> +	 * Unlike supported commands, the output size of RAW commands
> +	 * gets passed along without further checking, so it must be
> +	 * validated here.
> +	 */
> +	if (send_cmd->out.size > cxlds->payload_size)
> +		return -EINVAL;
> +
> +	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
> +		return -EPERM;
> +
> +	*mem_cmd = (struct cxl_mem_command) {
> +		.info = {
> +			.id = CXL_MEM_COMMAND_ID_RAW,
> +			.size_in = send_cmd->in.size,
> +			.size_out = send_cmd->out.size,
> +		},
> +		.opcode = send_cmd->raw.opcode
> +	};
> +
> +	return 0;
> +}
> +
> +static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
> +			  const struct cxl_send_command *send_cmd,
> +			  struct cxl_mem_command *mem_cmd)
> +{
> +	const struct cxl_command_info *info;
> +	struct cxl_mem_command *c;
> +
> +	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> +		return -EINVAL;
> +
> +	if (send_cmd->rsvd)
> +		return -EINVAL;
> +
> +	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
> +		return -EINVAL;
> +
> +	/* Convert user's command into the internal representation */

Not clear which chunk of code this applies to.  Seems like we
are just getting some addresses here (obviously that applies to original
code as well) Perhaps move down to where you fill in mem_cmd?

> +	c = &cxl_mem_commands[send_cmd->id];
> +	info = &c->info;

I don't mind that much either way, but you could do these at
declaration of the local variables above, before doing the sanity checks.

> +
> +	/* Check that the command is enabled for hardware */
> +	if (!test_bit(info->id, cxlds->enabled_cmds))
> +		return -ENOTTY;
> +
> +	/* Check that the command is not claimed for exclusive kernel use */
> +	if (test_bit(info->id, cxlds->exclusive_cmds))
> +		return -EBUSY;
> +
> +	/* Check the input buffer is the expected size */
> +	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
> +		return -ENOMEM;
> +
> +	/* Check the output buffer is at least large enough */
> +	if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
> +		return -ENOMEM;
> +
> +	*mem_cmd = (struct cxl_mem_command) {
> +		.info = {
> +			.id = info->id,
> +			.flags = info->flags,
> +			.size_in = send_cmd->in.size,
> +			.size_out = send_cmd->out.size,
> +		},
> +		.opcode = c->opcode
> +	};
> +
> +	return 0;
> +}
> +
>  /**
>   * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
>   * @cxlds: The device data for the operation
> @@ -230,8 +308,7 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
>  				      const struct cxl_send_command *send_cmd,
>  				      struct cxl_mem_command *out_cmd)
>  {
> -	const struct cxl_command_info *info;
> -	struct cxl_mem_command *c;
> +	int rc;
>  
>  	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
>  		return -ENOTTY;
> @@ -244,78 +321,13 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
>  	if (send_cmd->in.size > cxlds->payload_size)
>  		return -EINVAL;
>  
> -	/*
> -	 * Checks are bypassed for raw commands but a WARN/taint will occur
> -	 * later in the callchain
> -	 */
> -	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW) {
> -		const struct cxl_mem_command temp = {
> -			.info = {
> -				.id = CXL_MEM_COMMAND_ID_RAW,
> -				.flags = 0,
> -				.size_in = send_cmd->in.size,
> -				.size_out = send_cmd->out.size,
> -			},
> -			.opcode = send_cmd->raw.opcode
> -		};
> +	/* Sanitize and construct a cxl_mem_command */
> +	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
> +		rc = cxl_to_mem_cmd_raw(cxlds, send_cmd, out_cmd);
> +	else
> +		rc = cxl_to_mem_cmd(cxlds, send_cmd, out_cmd);
>  
> -		if (send_cmd->raw.rsvd)
> -			return -EINVAL;
> -
> -		/*
> -		 * Unlike supported commands, the output size of RAW commands
> -		 * gets passed along without further checking, so it must be
> -		 * validated here.
> -		 */
> -		if (send_cmd->out.size > cxlds->payload_size)
> -			return -EINVAL;
> -
> -		if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
> -			return -EPERM;
> -
> -		memcpy(out_cmd, &temp, sizeof(temp));
> -
> -		return 0;
> -	}
> -
> -	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> -		return -EINVAL;
> -
> -	if (send_cmd->rsvd)
> -		return -EINVAL;
> -
> -	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
> -		return -EINVAL;
> -
> -	/* Convert user's command into the internal representation */
> -	c = &cxl_mem_commands[send_cmd->id];
> -	info = &c->info;
> -
> -	/* Check that the command is enabled for hardware */
> -	if (!test_bit(info->id, cxlds->enabled_cmds))
> -		return -ENOTTY;
> -
> -	/* Check that the command is not claimed for exclusive kernel use */
> -	if (test_bit(info->id, cxlds->exclusive_cmds))
> -		return -EBUSY;
> -
> -	/* Check the input buffer is the expected size */
> -	if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
> -		return -ENOMEM;
> -
> -	/* Check the output buffer is at least large enough */
> -	if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
> -		return -ENOMEM;
> -
> -	memcpy(out_cmd, c, sizeof(*c));
> -	out_cmd->info.size_in = send_cmd->in.size;
> -	/*
> -	 * XXX: out_cmd->info.size_out will be controlled by the driver, and the
> -	 * specified number of bytes @send_cmd->out.size will be copied back out
> -	 * to userspace.
> -	 */
> -
> -	return 0;
> +	return rc;
I haven't read on yet so I'll assume there is more coming in this function as otherwise
you could just return directly in the two if / else paths.

Thanks,

Jonathan

>  }
>  
>  int cxl_query_cmd(struct cxl_memdev *cxlmd,

