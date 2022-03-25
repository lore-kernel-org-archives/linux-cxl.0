Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052ADC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 10:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiCYKeG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbiCYKeF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 06:34:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DB4C55A9
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 03:32:29 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPz0239PYz680gx;
        Fri, 25 Mar 2022 18:31:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 11:32:27 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 10:32:26 +0000
Date:   Fri, 25 Mar 2022 10:32:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] cxl/mbox: Move raw command warning to raw
 command validation
Message-ID: <20220325103225.00007b3c@huawei.com>
In-Reply-To: <20220324011126.1144504-3-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
        <20220324011126.1144504-3-alison.schofield@intel.com>
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

On Wed, 23 Mar 2022 18:11:19 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> This move serves two purposes: 1) Emit the warning in the raw
> command validation path, and 2) Remove the dependency on the
> struct cxl_mem_command in handle_mailbox_cmd_from_user() in
> preparation for a refactor of that function.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
FWIW as this is obviously fine.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 6612d73c37a8..28131c6f7fcf 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -224,6 +224,8 @@ static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
>  	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
>  		return -EPERM;
>  
> +	dev_WARN_ONCE(cxlds->dev, true, "raw command path used\n");
> +
>  	*mem_cmd = (struct cxl_mem_command) {
>  		.info = {
>  			.id = CXL_MEM_COMMAND_ID_RAW,
> @@ -424,9 +426,6 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>  		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
>  		cmd->info.size_in);
>  
> -	dev_WARN_ONCE(dev, cmd->info.id == CXL_MEM_COMMAND_ID_RAW,
> -		      "raw command path used\n");
> -
>  	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
>  	if (rc)
>  		goto out;

