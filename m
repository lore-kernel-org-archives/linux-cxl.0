Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5FCC001DB
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Aug 2023 00:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjHOA1G (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Aug 2023 20:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjHOA1E (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Aug 2023 20:27:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB3E7
        for <linux-cxl@vger.kernel.org>; Mon, 14 Aug 2023 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692059223; x=1723595223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aYYgOKWtwhMywMmfp6desVzaiMwMV7zlQ0VAvhFM82M=;
  b=RSrlI9KZM82QdCAbx+G41o5GCBaAwqW0898pHXk4BjGOSSnJaBQGiACD
   0e23PcyZZHh3xzSEQbhT9D9WaXk9AXt6S3tk7GuH+m48tUK15BL60LIli
   Qo1UKd1hQuAGJ//kvxMZqxhq5e7SzIzvlRv8EAiXgg/ciLzTlhCbBQsfN
   skF0L+v+SkOaSWKl+IPuWFUS4vrIZvo6j9VHMTzKS43JMn5su++nb0Oew
   E1t0te3PS51LtsN9vQtWlCGGfBaOgd9CVfh8K95/wUmHIAHVYJdczzJcX
   1Jr6flLCpYC3RhHfMK43VD1vsFpYKQB78MhUQAOdtNRhl+1/EN8FgiVOE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374937149"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="374937149"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="823658170"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="823658170"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.148.210])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:27:02 -0700
Date:   Mon, 14 Aug 2023 17:27:00 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Refactor granularity select in
 cxl_port_setup_targets()
Message-ID: <ZNrGVJYTTyuBykns@aschofie-mobl2>
References: <20230804232726.1672782-1-alison.schofield@intel.com>
 <64cdb8aa91847_2138e294bb@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cdb8aa91847_2138e294bb@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 04, 2023 at 07:49:14PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > In cxl_port_setup_targets() the region driver validates the
> > configuration of auto-discovered region decoders, as well
> > as decoders the driver is preparing to program.
> > 
> > The existing calculations use the encrypted interleave granularity
> 
> s/encrypted/encoded/

Got it.

> 
> > value, the eig, to create an interleave granularity that properly
> > fans out when routing an x1 interleave to a greater than x1 interleave.
> > 
> > That all worked well, until this config came along:
> > Host Bridge: 2 way at 256 granularity
> >     Switch Decoder_A:	1 way at 512
> >         Endpoint_X:	2 way at 512
> >     Switch Decoder_B:	1 way at 512
> >         Endpoint_Y:	2 way at 512
> > 
> > When the Host Bridge interleave is greater that 1, and the root
> 
> s/that/than/

Got it.

> > decoder interleave is exactly 1, the region driver needs to
> > consider the number of targets in the region when calculating
> > the expected granularity.
> > 
> > While examining the existing logic, and trying to cover the case
> > above, a couple of simplifications appeared, hence this proposed
> > refactoring.
> > 
> > The first simplicfication is to apply the logic to the unencrypted
> 
> s/unencrypted/nominal/

Got it.

> 
> > values and use the existing helper function granularity_to_eig() to
> > translate the desired granularity to the encrypted form. This means
> > the comment and code regarding setting address bits is discarded.
> > Although that logic was not wrong, it adds a level of complexity that
> > is not required in the granularity selection. The eig and eiw are
> > indeed part of the routing instructions programmed into the decoders.
> > Up-level the discussion to plain ways and granularity for clearer
> > analysis.
> > 
> > The second simplification reduces the logic to a single granularity
> > calculation that works for all cases. The new calculation doesn't
> > care if parent_iw => 1,  because parent_iw is used as a multiplier.
> > 
> > The refactor cleans up a useless assignment of eiw, made after the iw
> > is already calculated.
> > 
> > Regression testing included an examination of all of the ways and
> > granularity selections made during a run of the cxl_test unit tests.
> > There were no differences in selections before and after this patch.
> 
> Fixes: ("27b3f8d13830 cxl/region: Program target lists")

Got it.

> 
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> Fix *and* less code!? Yes, please!
> 

:)

> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e115ba382e04..5a1cc59cca99 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1154,16 +1154,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	}
> >  
> >  	/*
> > -	 * If @parent_port is masking address bits, pick the next unused address
> > -	 * bit to route @port's targets.
> > +	 * Interleave granularity is a multiple of @parent_port granularity.
> > +	 * Multiplier is the parent port interleave ways.
> >  	 */
> > -	if (parent_iw > 1 && cxl_rr->nr_targets > 1) {
> > -		u32 address_bit = max(peig + peiw, eiw + peig);
> > -
> > -		eig = address_bit - eiw + 1;
> > -	} else {
> > -		eiw = peiw;
> > -		eig = peig;
> > +	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> 
> I was going to say "wait, does this work with x3 parent_iw", and I
> believe it does because this:
> 
>                 /*
>                  * For purposes of address bit routing, use power-of-2 math for
>                  * switch ports.
>                  */
>                 if (!is_power_of_2(parent_iw))
>                         parent_iw /= 3;
> 
> ...is handled in the is_cxl_root(parent_port) case.

I think I'll mention the above in the commit log.

Thanks!



> 
> A thing of beauty this patch. Ship it! (modulo those minor nits above).
