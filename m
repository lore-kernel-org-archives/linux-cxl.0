Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60752C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 10:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbiCYK5k (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbiCYK5k (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 06:57:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A25BD8AD
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 03:56:06 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPzV06f7yz684TK;
        Fri, 25 Mar 2022 18:53:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 11:56:02 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 10:56:01 +0000
Date:   Fri, 25 Mar 2022 10:56:00 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 5/9] cxl/mbox: Remove dependency on cxl_mem_command
 for a debug msg
Message-ID: <20220325105600.0000529a@huawei.com>
In-Reply-To: <20220324011126.1144504-6-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
        <20220324011126.1144504-6-alison.schofield@intel.com>
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

On Wed, 23 Mar 2022 18:11:22 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> In preparation for removing access to struct cxl_mem_command,
> change this debug message to use cxl_mbox_cmd fields instead.
> Retrieve the pretty command name from cxl_mbox_cmd using a new
> opcode to command name helper.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 205e671307c3..d6d582baa1ee 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -127,6 +127,17 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
>  	return NULL;
>  }
>  
> +static const char *cxl_mem_opcode_to_name(u16 opcode)
> +{
> +	struct cxl_mem_command *c;
> +
> +	c = cxl_mem_find_command(opcode);
> +	if (c)
> +		return cxl_command_names[c->info.id].name;

nitpick, but i'd prefer the error path out of line.
	if (!c)
		return NULL;

	return cxl_command_names[c->info.id].name;

Otherwise
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +
> +	return NULL;
> +}
> +
>  /**
>   * cxl_mbox_send_cmd() - Send a mailbox command to a device.
>   * @cxlds: The device data for the operation
> @@ -450,9 +461,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>  	dev_dbg(dev,
>  		"Submitting %s command for user\n"
>  		"\topcode: %x\n"
> -		"\tsize: %ub\n",
> -		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
> -		cmd->info.size_in);
> +		"\tsize: %zx\n",
> +		cxl_mem_opcode_to_name(mbox_cmd.opcode),
> +		mbox_cmd.opcode, mbox_cmd.size_in);
>  
>  	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
>  	if (rc)

