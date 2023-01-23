Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5A3C38142
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 14:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjAWOJm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 09:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjAWOJm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 09:09:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F177173C;
        Mon, 23 Jan 2023 06:09:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0sMy2Qt7z6J6Vq;
        Mon, 23 Jan 2023 22:06:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 14:09:35 +0000
Date:   Mon, 23 Jan 2023 14:09:34 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Add debug messages for supported mailbox
 commands
Message-ID: <20230123140934.000066ff@Huawei.com>
In-Reply-To: <20230119130450.107519-1-rrichter@amd.com>
References: <20230119130450.107519-1-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 19 Jan 2023 14:04:50 +0100
Robert Richter <rrichter@amd.com> wrote:

> Only unsupported mailbox commands are reported in debug messages. A
> list of supported commands is useful too. Change debug messages to
> also report the opcodes of supported commands.
> 
> On that occasion also add missing trailing newlines.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Seems reasonable to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a48ade466d6a..ffa9f84c2dce 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -629,11 +629,12 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>  
>  		if (!cmd) {
>  			dev_dbg(cxlds->dev,
> -				"Opcode 0x%04x unsupported by driver", opcode);
> +				"Opcode 0x%04x unsupported by driver\n", opcode);
>  			continue;
>  		}
>  
>  		set_bit(cmd->info.id, cxlds->enabled_cmds);
> +		dev_dbg(cxlds->dev, "Opcode 0x%04x supported by driver\n", opcode);
>  	}
>  }
>  
> 
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2

