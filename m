Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36460C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Apr 2022 15:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbiDAPy4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354287AbiDAPLm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 1 Apr 2022 11:11:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFF11B0BFE
        for <linux-cxl@vger.kernel.org>; Fri,  1 Apr 2022 07:54:56 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KVNRv2JM6z67x0N;
        Fri,  1 Apr 2022 22:52:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Apr 2022 16:54:53 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Apr
 2022 15:54:52 +0100
Date:   Fri, 1 Apr 2022 15:54:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] cxl/mbox: Move build of user mailbox cmd to a
 helper functions
Message-ID: <20220401155450.00004879@Huawei.com>
In-Reply-To: <493d7618a846d787c3ae28778935ca35e2b85eed.1648687552.git.alison.schofield@intel.com>
References: <cover.1648687552.git.alison.schofield@intel.com>
        <493d7618a846d787c3ae28778935ca35e2b85eed.1648687552.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 30 Mar 2022 18:27:13 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> In preparation for moving the construction of a mailbox command
> to the validation path, extract the work into a helper functions.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 70 ++++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 39c8f6ded175..99b933fb2d9b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -207,6 +207,44 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>  	return true;
>  }
>  
> +static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
> +			     struct cxl_dev_state *cxlds, u16 opcode,
> +			     size_t in_size, size_t out_size, u64 in_payload)
> +{
> +	*mbox = (struct cxl_mbox_cmd) {
> +		.opcode = opcode,
> +		.size_in = in_size,
> +	};
> +
> +	if (in_size) {
> +		mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
> +						in_size);
> +		if (!mbox->payload_in)
> +			return PTR_ERR(mbox->payload_in);
> +	}
> +
> +	/* Prepare to handle a full payload for variable sized output */
> +	if (out_size < 0)
> +		mbox->size_out = cxlds->payload_size;
> +	else
> +		mbox->size_out = out_size;
> +
> +	if (mbox->size_out) {
> +		mbox->payload_out = kvzalloc(mbox->size_out, GFP_KERNEL);
> +		if (!mbox->payload_out) {
> +			kvfree(mbox->payload_in);
> +			return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void cxl_mbox_cmd_dtor(struct cxl_mbox_cmd *mbox)
> +{
> +	kvfree(mbox->payload_in);
> +	kvfree(mbox->payload_out);
> +}
> +
>  static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>  			      const struct cxl_send_command *send_cmd,
>  			      struct cxl_dev_state *cxlds)
> @@ -390,27 +428,14 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>  					s32 *size_out, u32 *retval)
>  {
>  	struct device *dev = cxlds->dev;
> -	struct cxl_mbox_cmd mbox_cmd = {
> -		.opcode = cmd->opcode,
> -		.size_in = cmd->info.size_in,
> -		.size_out = cmd->info.size_out,
> -	};
> +	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> -	if (cmd->info.size_out) {
> -		mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
> -		if (!mbox_cmd.payload_out)
> -			return -ENOMEM;
> -	}
> -
> -	if (cmd->info.size_in) {
> -		mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
> -						   cmd->info.size_in);
> -		if (IS_ERR(mbox_cmd.payload_in)) {
> -			kvfree(mbox_cmd.payload_out);
> -			return PTR_ERR(mbox_cmd.payload_in);
> -		}
> -	}
> +	rc = cxl_mbox_cmd_ctor(&mbox_cmd, cxlds, cmd->opcode,
> +			       cmd->info.size_in, cmd->info.size_out,
> +			       in_payload);
> +	if (rc)
> +		return rc;
>  
>  	dev_dbg(dev,
>  		"Submitting %s command for user\n"
> @@ -442,8 +467,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>  	*retval = mbox_cmd.return_code;
>  
>  out:
> -	kvfree(mbox_cmd.payload_in);
> -	kvfree(mbox_cmd.payload_out);
> +	cxl_mbox_cmd_dtor(&mbox_cmd);
>  	return rc;
>  }
>  
> @@ -464,10 +488,6 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>  	if (rc)
>  		return rc;
>  
> -	/* Prepare to handle a full payload for variable sized output */
> -	if (c.info.size_out < 0)
> -		c.info.size_out = cxlds->payload_size;
> -
>  	rc = handle_mailbox_cmd_from_user(cxlds, &c, send.in.payload,
>  					  send.out.payload, &send.out.size,
>  					  &send.retval);

