Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB271C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 10:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiCYKpa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbiCYKp2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 06:45:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D8B85BEA
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 03:43:53 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPzCv0rJPz67ljv;
        Fri, 25 Mar 2022 18:41:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 11:43:50 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 10:43:50 +0000
Date:   Fri, 25 Mar 2022 10:43:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 3/9] cxl/mbox: Move build of user mailbox cmd to a
 helper function
Message-ID: <20220325104348.00002709@huawei.com>
In-Reply-To: <20220324011126.1144504-4-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
        <20220324011126.1144504-4-alison.schofield@intel.com>
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

On Wed, 23 Mar 2022 18:11:20 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> In preparation for moving the construction of a mailbox command
> to the validation path, extract the work into a helper function.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Some suggestions for possible improvements to code organization now
possible because everything is in one place.

Otherwise looks good to me.

Jonathan

> ---
>  drivers/cxl/core/mbox.c | 60 +++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 28131c6f7fcf..d4233cfb2f99 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -207,6 +207,38 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>  	return true;
>  }
>  
> +static int cxl_to_mbox_cmd(struct cxl_dev_state *cxlds,
> +			   struct cxl_mbox_cmd *mbox, u16 opcode,
> +			   size_t in_size, size_t out_size, u64 in_payload)
> +{
> +	*mbox = (struct cxl_mbox_cmd) {
> +		.opcode = opcode,
> +		.size_in = in_size,
> +		.size_out = out_size,

Given we are going to possibly override this later, my inclination would
be to not set it here and instead do

	if (out_size < 0)
		mbox->size_out = cxlds->payload_size
	else
		mbox->size_out = out_size;

or
	mbox->size_out = out_size < 0 ? cxlds->payload_size : out_size;

> +	};
> +
> +	if (!in_size)
> +		goto size_out;
> +
> +	mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload), in_size);
> +	if (!mbox->payload_in)
> +		return PTR_ERR(mbox->payload_in);
> +
> +size_out:
Why format this like this?  Using a goto to skip a couple of lines of code
is a bit ugly.

	if (in_size) {
		mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload), in_size);
		if (!mbox->payload_in)
			return PTR_ERR(mbox->payload_in);
	}
	etc

> +	/* Prepare to handle a full payload for variable sized output */
> +	if (out_size < 0)
> +		mbox->size_out = cxlds->payload_size;
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
>  static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
>  			      const struct cxl_send_command *send_cmd,
>  			      struct cxl_mem_command *mem_cmd)
> @@ -397,27 +429,13 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
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
> +	rc = cxl_to_mbox_cmd(cxlds, &mbox_cmd, cmd->opcode, cmd->info.size_in,
> +			     cmd->info.size_out, in_payload);
> +	if (rc)
> +		return rc;
>  
>  	dev_dbg(dev,
>  		"Submitting %s command for user\n"
> @@ -471,10 +489,6 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
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

