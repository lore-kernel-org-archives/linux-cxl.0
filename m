Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD15AC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 11:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354586AbiCYLMe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355288AbiCYLMc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 07:12:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBCD3716
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 04:10:58 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPzqq0hhYz685FT;
        Fri, 25 Mar 2022 19:09:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 12:10:56 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 11:10:56 +0000
Date:   Fri, 25 Mar 2022 11:10:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] cxl/mbox: Move cxl_mem_command param to a local
 variable
Message-ID: <20220325111054.00004204@huawei.com>
In-Reply-To: <20220324011126.1144504-8-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
        <20220324011126.1144504-8-alison.schofield@intel.com>
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

On Wed, 23 Mar 2022 18:11:24 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> cxl_validate_command_from_user() is now the single point of validation
> for mailbox commands coming from user space. Previously, it returned a
> a cxl_mem_command, but that was not sufficient when validation of the
> actual mailbox command became a requirement. Now, it returns a fully
> validated cxl_mbox_cmd.
> 
> Remove the extraneous cxl_mem_command parameter. Define and use a
> local version only.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 0340399c7029..c323d6792405 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -331,10 +331,9 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
>  }
>  
>  /**
> - * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
> + * cxl_validate_cmd_from_user() - Construct a valid cxl_mbox_cmd
>   * @cxlds: The device data for the operation
>   * @send_cmd: &struct cxl_send_command copied in from userspace.
> - * @out_cmd: Sanitized and populated &struct cxl_mem_command.
>   * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
>   *
>   * Return:
> @@ -345,16 +344,14 @@ static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
>   *  * %-EPERM	- Attempted to use a protected command.
>   *  * %-EBUSY	- Kernel has claimed exclusive access to this opcode
>   *
> - * The result of this command is a fully validated command in @out_cmd that is
> + * The result of this command is a fully validated command in @mbox_cmd that is
>   * safe to send to the hardware.
> - *
> - * See handle_mailbox_cmd_from_user()
>   */
>  static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
>  				      const struct cxl_send_command *send_cmd,
> -				      struct cxl_mem_command *out_cmd,
>  				      struct cxl_mbox_cmd *mbox_cmd)
>  {
> +	struct cxl_mem_command mem_cmd;
>  	int rc;
>  
>  	if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
> @@ -370,16 +367,16 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
>  
>  	/* Sanitize and construct a cxl_mem_command */
>  	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
> -		rc = cxl_to_mem_cmd_raw(cxlds, send_cmd, out_cmd);
> +		rc = cxl_to_mem_cmd_raw(cxlds, send_cmd, &mem_cmd);
>  	else
> -		rc = cxl_to_mem_cmd(cxlds, send_cmd, out_cmd);
> +		rc = cxl_to_mem_cmd(cxlds, send_cmd, &mem_cmd);
>  
>  	if (rc)
>  		return rc;
>  
>  	/* Sanitize and construct a cxl_mbox_cmd */
> -	rc = cxl_to_mbox_cmd(cxlds, mbox_cmd, out_cmd->opcode,
> -			     out_cmd->info.size_in, out_cmd->info.size_out,
> +	rc = cxl_to_mbox_cmd(cxlds, mbox_cmd, mem_cmd.opcode,
> +			     mem_cmd.info.size_in, mem_cmd.info.size_out,
>  			     send_cmd->in.payload);
>  
>  	return rc;
> @@ -490,7 +487,6 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxlmd->dev;
>  	struct cxl_send_command send;
> -	struct cxl_mem_command c;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> @@ -499,7 +495,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>  	if (copy_from_user(&send, s, sizeof(send)))
>  		return -EFAULT;
>  
> -	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &c, &mbox_cmd);
> +	rc = cxl_validate_cmd_from_user(cxlmd->cxlds, &send, &mbox_cmd);
>  	if (rc)
>  		return rc;
>  

