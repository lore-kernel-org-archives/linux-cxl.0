Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CB2C00140
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Aug 2022 16:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiHBQwp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Aug 2022 12:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiHBQwo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Aug 2022 12:52:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C65513EBB
        for <linux-cxl@vger.kernel.org>; Tue,  2 Aug 2022 09:52:41 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ly1BW0xs0z67twb;
        Wed,  3 Aug 2022 00:47:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 18:52:38 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 2 Aug
 2022 17:52:38 +0100
Date:   Tue, 2 Aug 2022 17:52:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/5] cxl/acpi: Minimize granularity for x1 interleaves
Message-ID: <20220802175236.00004c40@huawei.com>
In-Reply-To: <20220802165627.00003464@huawei.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
        <165853776917.2430596.16823264262010844458.stgit@dwillia2-xfh.jf.intel.com>
        <20220802165627.00003464@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 2 Aug 2022 16:56:27 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 22 Jul 2022 17:56:09 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The kernel enforces that region granularity is >= to the top-level
> > interleave-granularity for the given CXL window. However, when the CXL
> > window interleave is x1, i.e. non-interleaved at the host bridge level,
> > then the specified granularity does not matter. Override the window
> > specified granularity to the CXL minimum so that any valid region
> > granularity is >= to the root granularity.
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> 
> Hi Dan,
> 
> Debugging exactly why this is failing (from cxl.git/preview) for my test setup...
> (1 hb, 8 rp, 8 direct connected devices)
> 
> If I set the interleave granularity of a region to 256, I end
> up with 256 for the CFMWS which is fine, then 512 for the HB which
> is not - EP interleave granularity is expected 256.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/drivers/cxl/core/region.c?h=preview#n1070
> 
> Calculates the eig as address_bit - eiw + 1
> 
> iw = 8
> eiw = 3
> peig = 0 (pig = 256)
> peiw = 0 (piw = 1)
> (all as expected I think...)
> 
> So address_bit = s max(peig + peiw, eiw + peig) = max(0, 3)
> and eig = 3 - 3 + 1 = 1 (ig = 512) which is wrong.
> 
> I'm not 100% sure on the logic behind this maths, but would expect eig = 0 as the output for this
> setup..
> 
> Even with this hacked, qemu address decode is landing at wrong address in the backing files (but it
> is at least landing in the right file!)
> Curiously interleave ways = 1 for the EPs which is obviously wrong. (I'm not convinced the
> qemu address logic is right but it'll never work with that value).  I'm struggling to figure
> out where we actually set the interleave ways for an EP.

FWIW I hacked qemu to default to EPs with eig = 3 (ig = 8) for the EPs and decode looks better.
There is a write to eiw for the EPs when commit is set, but seems to be just writing back value
cached when we originally read the setup back from the HDM decoders at probe.

Test code is that QEMU fix I sent a few weeks back + a hack of -= 1 of eig as above for the HB given
I haven't figured out what right fix for that is.

Jonathan



> 
> Also I'm not having much luck requesting a larger interleave granularity for the region (desirable perhaps
> because the devices give better performance with 1024 byte sequential reads)
> 
> Clearly going to be one of those bugs all the way down days. 
> 
> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  drivers/cxl/acpi.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index eb436268b92c..67137e17b8c9 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -140,6 +140,12 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  		.end = res->end,
> >  	};
> >  	cxld->interleave_ways = ways;
> > +	/*
> > +	 * Minimize the x1 granularity to advertise support for any
> > +	 * valid region granularity
> > +	 */
> > +	if (ways == 1)
> > +		ig = 256;
> >  	cxld->interleave_granularity = ig;
> >  
> >  	rc = cxl_decoder_add(cxld, target_map);
> > 
> >   
> 

