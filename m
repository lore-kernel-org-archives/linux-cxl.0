Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D06C00140
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 11:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiHHLYy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 07:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHHLYx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 07:24:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302EAE0A8
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 04:24:51 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M1Yl412PYz67M3B;
        Mon,  8 Aug 2022 19:24:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 8 Aug 2022 13:24:48 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 8 Aug
 2022 12:24:45 +0100
Date:   Mon, 8 Aug 2022 12:24:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v2 3/3] cxl/region: Disallow region granularity !=
 window granularity
Message-ID: <20220808122438.0000548d@huawei.com>
In-Reply-To: <165973127171.1526540.9923273539049172976.stgit@dwillia2-xfh.jf.intel.com>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
        <165973127171.1526540.9923273539049172976.stgit@dwillia2-xfh.jf.intel.com>
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

On Fri, 05 Aug 2022 13:27:51 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The endpoint decode granularity must be <= the window granularity
> otherwise capacity in the endpoints is lost in the decode. Consider an
> attempt to have a region granularity of 512 with 4 devices within a
> window that maps 2 host bridges at a granularity of 256 bytes:
> 
> HPA	DPA Offset	HB	Port	EP
> 0x0	0x0		0	0	0
> 0x100	0x0		1	0	2
> 0x200	0x100		0	0	0
> 0x300	0x100		1	0	2
> 0x400	0x200		0	1	1
> 0x500	0x200		1	1	3
> 0x600	0x300		0	1	1
> 0x700	0x300		1	1	3
> 0x800	0x400		0	0	0
> 0x900	0x400		1	0	2
> 0xA00	0x500		0	0	0
> 0xB00	0x500		1	0	2
> 
> Notice how endpoint0 maps HPA 0x0 and 0x200 correctly, but then HPA
> 0x800 results in DPA 0x200 to 0x400 on endpoint0 being not skipped.
> 
> Fix this by restricing the region granularity to be equal to the window

restricting

> granularity resulting in the following for a x4 region under a x2 window
> at a granularity of 256.
> 
> HPA	DPA Offset	HB	Port	EP
> 0x0	0x0		0	0	0
> 0x100	0x0		1	0	2
> 0x200	0x0		0	1	1
> 0x300	0x0		1	1	3
> 0x400	0x100		0	0	0
> 0x500	0x100		1	0	2
> 0x600	0x100		0	1	1
> 0x700	0x100		1	1	3
> 
> Not that it ever made practical sense to support region granularity >
> window granularity. The window rotates host bridges causing endpoints to
> never see a consecutive stream of requests at the desired granularity
> without breaks to issue cycles to the other host bridge.

Possibly worth description mentioning the (possible to support in the
future) case you have in the comment in the code.  I'm not that fussed
though either way.

>              (Regions with a granularity less than the root
> +	 * interleave result in needing multiple endpoints to support a single
> +	 * slot in the interleave)

Last bit is interesting and based on region granularity is always
constant across different EPs (currently interface enforces that - not as
far as I can tell the spec) I think the spec would allow:
HB0: 2 EP, HB1 1EP with HB interleave at 256 bytes (interleave irrelevant
for HB1 as it only has one port) and CFMWS at 512.

HPA	DPA Offset	HB	Port	EP
0x0	0x0		0	0	0
0x100	0x0		0	1	1
0x200	0x0		1	0	2
0x300	0x100		1	0	2
0x400	0x100		0	0	0
0x500	0x100		0	1	1
0x600	0x200		1	0	2
0x700	0x300		1	0	2
0x800	0x200		0	0	0
0x900	0x200		0	1	1
0xa00	0x400		1	0	2
0xb00	0x500		1	0	2

Fun bit is region ends up having granularity 256 on some devices and 512 on
others.  Perhaps better to not mention this (assuming I haven't made
an error in the maths) :) So I'm fine with leaving the comment as is
given it's correct for current combination of software model and what
the spec allows.

> 
> Fixes: 80d10a6cee05 ("cxl/region: Add interleave geometry attributes")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 641bc6344a4a..401148016978 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -395,13 +395,14 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  		return rc;
>  
>  	/*
> -	 * Disallow region granularity less than root granularity to
> -	 * simplify the implementation. Otherwise, region's with a
> -	 * granularity less than the root interleave result in needing
> -	 * multiple endpoints to support a single slot in the
> -	 * interleave.
> +	 * When the host-bridge is interleaved, disallow region granularity !=
> +	 * root granularity. Regions with a granularity less than the root
> +	 * interleave result in needing multiple endpoints to support a single
> +	 * slot in the interleave (possible to suport in the future). Regions
> +	 * with a granularity greater than the root interleave result in invalid
> +	 * DPA translations (invalid to support).
>  	 */
> -	if (val < cxld->interleave_granularity)
> +	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
>  		return -EINVAL;
>  
>  	rc = down_write_killable(&cxl_region_rwsem);
> 

