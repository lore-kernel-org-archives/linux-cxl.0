Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38180C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 16:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJJQMB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJJQMA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 12:12:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C4E2CDF1
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 09:11:59 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmP5Y1Vq0z67ykV;
        Tue, 11 Oct 2022 00:10:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 10 Oct 2022 18:11:56 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 17:11:56 +0100
Date:   Mon, 10 Oct 2022 17:11:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        Bobo WL <lmw.bobo@gmail.com>
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference due to pass
 through decoder commit
Message-ID: <20221010171132.000028f1@huawei.com>
In-Reply-To: <20220819093133.00006c22@huawei.com>
References: <20220818164210.2084-1-Jonathan.Cameron@huawei.com>
        <62fedb421d71f_11e5e3294bd@dwillia2-xfh.jf.intel.com.notmuch>
        <20220819093133.00006c22@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 Aug 2022 09:31:33 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 18 Aug 2022 17:37:22 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:  
> > > Not all decoders have a commit callback.
> > > 
> > > The CXL specification allows a host bridge with a single root port to
> > > have no explicit HDM decoders. Currently we assumes there are none.
> > > As such we create a special pass through decoder instance without
> > > a commit callback.
> > > 
> > > Prior to this patch, the commit callback was called unconditionally.
> > > Thus a configuration with 1 Host Bridge, 1 Root Port, 1 switch with
> > > multiple downstream ports below which there are multiple CXL type 3
> > > devices results in a situation where committing the region causes
> > > a null pointer dereference.
> > > 
> > > Reported-by: Bobo WL <lmw.bobo@gmail.com>
> > > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > > 
> > > We could fix this with a stub function perhaps as an alternative?    
> > 
> > How about keep the callback mandatory except for the passthrough switch
> > case?  
> 
> Should work, but makes it messier if we do add support for HDM decoders
> in the pass through case (which I'm 90% + sure we will have once actual
> platforms appear - we regularly have PCIe host bridges that on a particular
> platform have one RP and on other platforms expose multiple - it's just a
> wiring question - I doubt we'll bother hiding the HDMs given the spec
> allows for them to be there in this case and it adds complexity to the
> design to hide them).
> 
> Keeping the cxlsd->nr_targets > 1 check in one place would be my preference
> or adding a wrapper. e.g.
> is_passthrough_decoder()
> that we can change easily later.
> 
> Either way, focus now is getting fix in, can change how it's done
> later.  So I'm fine with either fix.
> 
> Jonathan
> 
> 

Hi Dan,

I forgot to test your suggestion. Now done and it works as expected.

One comment below.

Given this is now your code, do you want to send the patch or is it
easier if I do so?
 
> 
> 
> > 
> > Something like this (untested):
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 401148016978..b1137f6dc2d1 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -172,11 +172,17 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
> >                 /* commit bottom up */
> >                 for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
> >                      iter = to_cxl_port(iter->dev.parent)) {
> > +                       struct cxl_switch_decoder *cxlsd = NULL;
> > +
> >                         cxl_rr = cxl_rr_load(iter, cxlr);
> >                         cxld = cxl_rr->decoder;
> > -                       rc = cxld->commit(cxld);
> > -                       if (rc)
> > -                               break;
> > +                       if (is_switch_decoder(&cxld->dev))
> > +                               cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > +                       if (cxld->commit || cxlsd && cxlsd->nr_targets > 1) {

I'd add brackets around the (cxlsd && cxlsd->nr_targets > 1) 
just to stop forgetful people like me having to check the precedence ordering..
 
> > +                               rc = cxld->commit(cxld);
> > +                               if (rc)
> > +                                       break;
> > +                       }
> >                 }
> >  
> >                 if (rc) {
> >   
> 

