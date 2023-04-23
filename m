Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DABC77B60
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 15:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjDWPXo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjDWPXn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 11:23:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7745B10CC
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 08:23:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q4Bp96MJrz67nH3;
        Sun, 23 Apr 2023 23:22:25 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 16:23:39 +0100
Date:   Sun, 23 Apr 2023 16:23:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v13 2/9] cxl/mbox: Restrict poison cmds to debugfs
 cxl_raw_allow_all
Message-ID: <20230423162338.00007ddb@huawei.com>
In-Reply-To: <0e5cb41ffae2bab800957d3b9003eedfd0a2dfd5.1681838291.git.alison.schofield@intel.com>
References: <cover.1681838291.git.alison.schofield@intel.com>
        <0e5cb41ffae2bab800957d3b9003eedfd0a2dfd5.1681838291.git.alison.schofield@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 18 Apr 2023 10:39:02 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> The Get, Inject, and Clear poison commands are not available for
> direct user access because they require kernel driver controls to
> perform safely.
> 
> Further restrict access to these commands by requiring the selection
> of the debugfs attribute 'cxl_raw_allow_all' to enable in raw mode.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Makes sense. I see Dan already has these queued in cxl pending so
don't mind if tags get added or not.  I'm only looking again as I was
testing the latest version of the qemu emulation of poison handling.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 938cff2c948e..fd1026970d3a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -82,6 +82,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>   *
>   * CXL_MBOX_OP_[GET_]SCAN_MEDIA: The kernel provides a native error list that
>   * is kept up to date with patrol notifications and error management.
> + *
> + * CXL_MBOX_OP_[GET_,INJECT_,CLEAR_]POISON: These commands require kernel
> + * driver orchestration for safety.
>   */
>  static u16 cxl_disabled_raw_commands[] = {
>  	CXL_MBOX_OP_ACTIVATE_FW,
> @@ -90,6 +93,9 @@ static u16 cxl_disabled_raw_commands[] = {
>  	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
>  	CXL_MBOX_OP_SCAN_MEDIA,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA,
> +	CXL_MBOX_OP_GET_POISON,
> +	CXL_MBOX_OP_INJECT_POISON,
> +	CXL_MBOX_OP_CLEAR_POISON,
>  };
>  
>  /*

