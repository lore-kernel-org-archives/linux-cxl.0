Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB3FC25B0E
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Aug 2022 08:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbiHSIbk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346799AbiHSIbk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 Aug 2022 04:31:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343DE97E8
        for <linux-cxl@vger.kernel.org>; Fri, 19 Aug 2022 01:31:38 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M8FMq3w38z685XB;
        Fri, 19 Aug 2022 16:31:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 10:31:35 +0200
Received: from localhost (10.45.145.91) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 19 Aug
 2022 09:31:35 +0100
Date:   Fri, 19 Aug 2022 09:31:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <linuxarm@huawei.com>, Bobo WL <lmw.bobo@gmail.com>
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference due to pass
 through decoder commit
Message-ID: <20220819093133.00006c22@huawei.com>
In-Reply-To: <62fedb421d71f_11e5e3294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220818164210.2084-1-Jonathan.Cameron@huawei.com>
        <62fedb421d71f_11e5e3294bd@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.145.91]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 18 Aug 2022 17:37:22 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > Not all decoders have a commit callback.
> > 
> > The CXL specification allows a host bridge with a single root port to
> > have no explicit HDM decoders. Currently we assumes there are none.
> > As such we create a special pass through decoder instance without
> > a commit callback.
> > 
> > Prior to this patch, the commit callback was called unconditionally.
> > Thus a configuration with 1 Host Bridge, 1 Root Port, 1 switch with
> > multiple downstream ports below which there are multiple CXL type 3
> > devices results in a situation where committing the region causes
> > a null pointer dereference.
> > 
> > Reported-by: Bobo WL <lmw.bobo@gmail.com>
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > 
> > We could fix this with a stub function perhaps as an alternative?  
> 
> How about keep the callback mandatory except for the passthrough switch
> case?

Should work, but makes it messier if we do add support for HDM decoders
in the pass through case (which I'm 90% + sure we will have once actual
platforms appear - we regularly have PCIe host bridges that on a particular
platform have one RP and on other platforms expose multiple - it's just a
wiring question - I doubt we'll bother hiding the HDMs given the spec
allows for them to be there in this case and it adds complexity to the
design to hide them).

Keeping the cxlsd->nr_targets > 1 check in one place would be my preference
or adding a wrapper. e.g.
is_passthrough_decoder()
that we can change easily later.

Either way, focus now is getting fix in, can change how it's done
later.  So I'm fine with either fix.

Jonathan




> 
> Something like this (untested):
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 401148016978..b1137f6dc2d1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -172,11 +172,17 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>                 /* commit bottom up */
>                 for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
>                      iter = to_cxl_port(iter->dev.parent)) {
> +                       struct cxl_switch_decoder *cxlsd = NULL;
> +
>                         cxl_rr = cxl_rr_load(iter, cxlr);
>                         cxld = cxl_rr->decoder;
> -                       rc = cxld->commit(cxld);
> -                       if (rc)
> -                               break;
> +                       if (is_switch_decoder(&cxld->dev))
> +                               cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +                       if (cxld->commit || cxlsd && cxlsd->nr_targets > 1) {
> +                               rc = cxld->commit(cxld);
> +                               if (rc)
> +                                       break;
> +                       }
>                 }
>  
>                 if (rc) {
> 

