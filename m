Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8A0C00140
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 11:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiHHLDN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiHHLDM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 07:03:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C80C55A1
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 04:03:11 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M1YC16jDlz67yBh;
        Mon,  8 Aug 2022 19:00:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 13:03:08 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 8 Aug
 2022 12:03:08 +0100
Date:   Mon, 8 Aug 2022 12:03:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH v2 2/3] cxl/region: Fix x1 interleave to greater than x1
 interleave routing
Message-ID: <20220808120306.00000847@huawei.com>
In-Reply-To: <165973126583.1526540.657948655360009242.stgit@dwillia2-xfh.jf.intel.com>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
        <165973126583.1526540.657948655360009242.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 05 Aug 2022 13:27:45 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In cases where the decode fans out as it traverses downstream, the
> interleave granularity needs to increment to identify the port selector
> bits out of the remaining address bits. For example, recall that with an
> x2 parent port intereleave (IW == 1), the downstream decode for children
> of those ports will either see address bit IG+8 always set, or address
> bit IG+8 always clear. So if the child port needs to select a downstream
> port it can only use address bits starting at IG+9 (where IG and IW are
> the CXL encoded values for interleave granularity (ilog2(ig) - 8) and
> ways (ilog2(iw))).
> 
> When the parent port interleave is x1 no such masking occurs and the
> child port can maintain the granularity that was routed to the parent
> port.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #via qemu

Now this is resolved, I'll get qemu fix sent out (hopefully later today).

Thanks,

Jonathan

> ---
>  drivers/cxl/core/region.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e71077beb021..641bc6344a4a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1025,7 +1025,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	if (cxl_rr->nr_targets > 1) {
> +	/*
> +	 * If @parent_port is masking address bits, pick the next unused address
> +	 * bit to route @port's targets.
> +	 */
> +	if (parent_iw > 1 && cxl_rr->nr_targets > 1) {
>  		u32 address_bit = max(peig + peiw, eiw + peig);
>  
>  		eig = address_bit - eiw + 1;
> 

