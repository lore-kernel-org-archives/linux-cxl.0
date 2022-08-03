Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F90AC19F29
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 16:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiHCQA2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiHCQA1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 12:00:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B93EB30
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 09:00:24 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lybzj1pyPz68967;
        Wed,  3 Aug 2022 23:55:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 3 Aug 2022 18:00:22 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 3 Aug
 2022 17:00:22 +0100
Date:   Wed, 3 Aug 2022 17:00:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/5] cxl/acpi: Minimize granularity for x1 interleaves
Message-ID: <20220803170020.00000c81@huawei.com>
In-Reply-To: <62e95fdf9f6e2_30440294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
        <165853776917.2430596.16823264262010844458.stgit@dwillia2-xfh.jf.intel.com>
        <20220802165627.00003464@huawei.com>
        <62e95fdf9f6e2_30440294e4@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 2 Aug 2022 10:33:19 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 22 Jul 2022 17:56:09 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > The kernel enforces that region granularity is >= to the top-level
> > > interleave-granularity for the given CXL window. However, when the CXL
> > > window interleave is x1, i.e. non-interleaved at the host bridge level,
> > > then the specified granularity does not matter. Override the window
> > > specified granularity to the CXL minimum so that any valid region
> > > granularity is >= to the root granularity.
> > > 
> > > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > 
> > Hi Dan,
> > 
> > Debugging exactly why this is failing (from cxl.git/preview) for my test setup...
> > (1 hb, 8 rp, 8 direct connected devices)
> > 
> > If I set the interleave granularity of a region to 256, I end
> > up with 256 for the CFMWS which is fine, then 512 for the HB which
> > is not - EP interleave granularity is expected 256.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/drivers/cxl/core/region.c?h=preview#n1070
> > 
> > Calculates the eig as address_bit - eiw + 1
> > 
> > iw = 8
> > eiw = 3
> > peig = 0 (pig = 256)
> > peiw = 0 (piw = 1)
> > (all as expected I think...)
> > 
> > So address_bit = s max(peig + peiw, eiw + peig) = max(0, 3)
> > and eig = 3 - 3 + 1 = 1 (ig = 512) which is wrong.
> > 
> > I'm not 100% sure on the logic behind this maths, but would expect eig = 0 as the output for this
> > setup..  
> 
> Yeah, the "+ 1" is not required when routing from the x1 HB level. I can
> reproduce this config with cxl_test to validate.

Other than this off by one, with the other fixes you posted everything now works for me
with the particular test case above.

Thanks

Jonathan

> 
> > Even with this hacked, qemu address decode is landing at wrong address in the backing files (but it
> > is at least landing in the right file!)
> > Curiously interleave ways = 1 for the EPs which is obviously wrong. (I'm not convinced the
> > qemu address logic is right but it'll never work with that value).  I'm struggling to figure
> > out where we actually set the interleave ways for an EP.  
> 
> Ugh, it is not set and I think I was blinded by some successful region
> creation results and assumed they also ran cycles to validate the data
> consistency. My expectation is that the EP interleave_ways is set here:
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cf5d5811fe4c..dd4035d92041 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1285,6 +1285,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  
>         p->targets[pos] = cxled;
>         cxled->pos = pos;
> +       cxled->cxld.interleave_ways = p->interleave_ways;
> +       cxled->cxld.interleave_granularity = p->interleave_granularity;
>         p->nr_targets++;
>  
>         if (p->nr_targets == p->interleave_ways) {
> 
> 
> > Also I'm not having much luck requesting a larger interleave granularity for the region (desirable perhaps
> > because the devices give better performance with 1024 byte sequential reads)
> > 
> > Clearly going to be one of those bugs all the way down days. 
> >   
> 
> Yes, the hunt continues, but I think the driver has some large ones the
> squash first.

