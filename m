Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02860C433E0
	for <linux-cxl@archiver.kernel.org>; Mon, 22 Feb 2021 16:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E4364E76
	for <linux-cxl@archiver.kernel.org>; Mon, 22 Feb 2021 16:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhBVQcH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:32:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2594 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhBVQaH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 Feb 2021 11:30:07 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DknbT5DwLz67gS3;
        Tue, 23 Feb 2021 00:25:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 22 Feb 2021 17:29:24 +0100
Received: from localhost (10.47.74.92) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 22 Feb
 2021 16:29:23 +0000
Date:   Mon, 22 Feb 2021 16:28:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2] cxl/mem: Fix potential memory leak
Message-ID: <20210222162818.00000bfb@Huawei.com>
In-Reply-To: <20210221035846.680145-1-ben.widawsky@intel.com>
References: <20210220215641.604535-1-ben.widawsky@intel.com>
        <20210221035846.680145-1-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.74.92]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 20 Feb 2021 19:58:46 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> When submitting a command for userspace, input and output payload bounce
> buffers are allocated. For a given command, both input and output
> buffers may exist and so when allocation of the input buffer fails, the
> output buffer must be freed too.
> 
> As far as I can tell, userspace can't easily exploit the leak to OOM a
> machine unless the machine was already near OOM state.
> 
> Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
> Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

I'd probably have used a goto and label but I guess this works fine a well.
FWIW on such a small patch.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/mem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index df895bcca63a..244cb7d89678 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -514,8 +514,10 @@ static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
>  	if (cmd->info.size_in) {
>  		mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
>  						   cmd->info.size_in);
> -		if (IS_ERR(mbox_cmd.payload_in))
> +		if (IS_ERR(mbox_cmd.payload_in)) {
> +			kvfree(mbox_cmd.payload_out);
>  			return PTR_ERR(mbox_cmd.payload_in);
> +		}
>  	}
>  
>  	rc = cxl_mem_mbox_get(cxlm);

