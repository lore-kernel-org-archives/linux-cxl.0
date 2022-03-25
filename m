Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D6FC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 11:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353378AbiCYLGW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348433AbiCYLGV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 07:06:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D9748314
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 04:04:47 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPzjJ04kcz67wqt;
        Fri, 25 Mar 2022 19:03:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 12:04:44 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 11:04:44 +0000
Date:   Fri, 25 Mar 2022 11:04:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] cxl/mbox: Make handle_mailbox_cmd_from_user()
 use a mbox param
Message-ID: <20220325110443.0000139f@huawei.com>
In-Reply-To: <20220324011126.1144504-7-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
        <20220324011126.1144504-7-alison.schofield@intel.com>
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

On Wed, 23 Mar 2022 18:11:23 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Previously, handle_mailbox_cmd_from_user(), constructed the mailbox
> command and dispatched it to the hardware. The construction work
> has moved to the validation path.
> 
> handle_mailbox_cmd_from_user() now expects a fully validated
> mbox param. Make it's caller, cxl_send_cmd(), deliver it. Update
> the comments and dereferencing of the new mbox parameter.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

One suggestion below.

> ---
>  drivers/cxl/core/mbox.c | 45 +++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d582baa1ee..0340399c7029 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -422,8 +422,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  /**
>   * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
>   * @cxlds: The device data for the operation
> - * @cmd: The validated command.
> - * @in_payload: Pointer to userspace's input payload.
> + * @mbox_cmd: The validated mailbox command.
>   * @out_payload: Pointer to userspace's output payload.
>   * @size_out: (Input) Max payload size to copy out.
>   *            (Output) Payload size hardware generated.
> @@ -438,34 +437,27 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>   *  * %-EINTR	- Mailbox acquisition interrupted.
>   *  * %-EXXX	- Transaction level failures.
>   *
> - * Creates the appropriate mailbox command and dispatches it on behalf of a
> - * userspace request. The input and output payloads are copied between
> - * userspace.
> + * Dispatches a mailbox command on behalf of a userspace request.
> + * The output payload is copied to userspace.
>   *
>   * See cxl_send_cmd().
>   */
>  static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
> -					const struct cxl_mem_command *cmd,
> -					u64 in_payload, u64 out_payload,
> -					s32 *size_out, u32 *retval)
> +					struct cxl_mbox_cmd *mbox_cmd,
> +					u64 out_payload, s32 *size_out,
> +					u32 *retval)
>  {
>  	struct device *dev = cxlds->dev;
> -	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> -	rc = cxl_to_mbox_cmd(cxlds, &mbox_cmd, cmd->opcode, cmd->info.size_in,
> -			     cmd->info.size_out, in_payload);
> -	if (rc)
> -		return rc;
> -
>  	dev_dbg(dev,
>  		"Submitting %s command for user\n"
>  		"\topcode: %x\n"
>  		"\tsize: %zx\n",
> -		cxl_mem_opcode_to_name(mbox_cmd.opcode),
> -		mbox_cmd.opcode, mbox_cmd.size_in);
> +		cxl_mem_opcode_to_name(mbox_cmd->opcode),
> +		mbox_cmd->opcode, mbox_cmd->size_in);
>  
> -	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
> +	rc = cxlds->mbox_send(cxlds, mbox_cmd);
>  	if (rc)
>  		goto out;
>  
> @@ -474,22 +466,22 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>  	 * to userspace. While the payload may have written more output than
>  	 * this it will have to be ignored.
>  	 */
> -	if (mbox_cmd.size_out) {
> -		dev_WARN_ONCE(dev, mbox_cmd.size_out > *size_out,
> +	if (mbox_cmd->size_out) {
> +		dev_WARN_ONCE(dev, mbox_cmd->size_out > *size_out,
>  			      "Invalid return size\n");
>  		if (copy_to_user(u64_to_user_ptr(out_payload),
> -				 mbox_cmd.payload_out, mbox_cmd.size_out)) {
> +				 mbox_cmd->payload_out, mbox_cmd->size_out)) {
>  			rc = -EFAULT;
>  			goto out;
>  		}
>  	}
>  
> -	*size_out = mbox_cmd.size_out;
> -	*retval = mbox_cmd.return_code;
> +	*size_out = mbox_cmd->size_out;
> +	*retval = mbox_cmd->return_code;
>  
>  out:
> -	kvfree(mbox_cmd.payload_in);
> -	kvfree(mbox_cmd.payload_out);
> +	kvfree(mbox_cmd->payload_in);
> +	kvfree(mbox_cmd->payload_out);

As this function is no longer responsible for allocating these, I'd be inclined
to pull the frees out to the caller.

That will make things less fragile to any additional code that might in future
occur between

cxl_validate_cmd_from_user() and handle_mailbox_cmd_from_user()

>  	return rc;
>  }
>  
> @@ -511,9 +503,8 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>  	if (rc)
>  		return rc;
>  
> -	rc = handle_mailbox_cmd_from_user(cxlds, &c, send.in.payload,
> -					  send.out.payload, &send.out.size,
> -					  &send.retval);
> +	rc = handle_mailbox_cmd_from_user(cxlds, &mbox_cmd, send.out.payload,
> +					  &send.out.size, &send.retval);
>  	if (rc)
>  		return rc;
>  

