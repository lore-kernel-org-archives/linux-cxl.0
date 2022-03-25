Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A29C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 10:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344473AbiCYKz5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352168AbiCYKz4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 06:55:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A69419B0
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 03:54:18 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPzRv6m9Pz67yL5;
        Fri, 25 Mar 2022 18:51:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 11:54:15 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 10:54:15 +0000
Date:   Fri, 25 Mar 2022 10:54:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 4/9] cxl/mbox: Construct a users cxl_mbox_cmd in the
 validation path
Message-ID: <20220325105413.00002ac5@huawei.com>
In-Reply-To: <20220324011126.1144504-5-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
        <20220324011126.1144504-5-alison.schofield@intel.com>
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

On Wed, 23 Mar 2022 18:11:21 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Since the validation of a mailbox command is done as it is built,

Perhaps reword this.  I agree it's desirable to have validation
and build together but this says 'is done' and it wasn't done until
this patch.

> move that work out of the dispatch path and into the validation
> path.
> 
> This is a step in refactoring the handling of user space mailbox
> commands. The intent is to have all the validation work originate
> in cxl_validate_cmd_from_user().
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Sometimes things can get broken into too many baby steps!

This change looks odd until patch 7 given info is passed twice
in mbox_cmd and out_cmd.  Maybe note in the patch description that
out_cmd will be brought local in a few patches time?
Probably not worth working out how to reorder and squish the patches
to make this easier to review.

Otherwise, one trivial inline.


Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d4233cfb2f99..205e671307c3 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -324,6 +324,7 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
>   * @cxlds: The device data for the operation
>   * @send_cmd: &struct cxl_send_command copied in from userspace.
>   * @out_cmd: Sanitized and populated &struct cxl_mem_command.
> + * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
>   *
>   * Return:
>   *  * %0	- @out_cmd is ready to send.
> @@ -340,7 +341,8 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
>   */
>  static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
>  				      const struct cxl_send_command *send_cmd,
> -				      struct cxl_mem_command *out_cmd)
> +				      struct cxl_mem_command *out_cmd,
> +				      struct cxl_mbox_cmd *mbox_cmd)
>  {
>  	int rc;
>  
> @@ -361,6 +363,14 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
>  	else
>  		rc = cxl_to_mem_cmd(cxlds, send_cmd, out_cmd);
>  
> +	if (rc)
> +		return rc;
> +
> +	/* Sanitize and construct a cxl_mbox_cmd */
> +	rc = cxl_to_mbox_cmd(cxlds, mbox_cmd, out_cmd->opcode,
> +			     out_cmd->info.size_in, out_cmd->info.size_out,
> +			     send_cmd->in.payload);
> +
return cxl_to_mbox_cmd()....

>  	return rc;
>  }
>  
> @@ -478,6 +488,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>  	struct device *dev = &cxlmd->dev;
>  	struct cxl_send_command send;
>  	struct cxl_mem_command c;
> +	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
>  	dev_dbg(dev, "Send IOCTL\n");
> @@ -485,7 +496,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>  	if (copy_from_user(&send, s, sizeof(send)))
>  		return -EFAULT;
>  
> -	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c);
> +	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c, &mbox_cmd);
>  	if (rc)
>  		return rc;
>  

