Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF01CC001B0
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Aug 2023 00:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjHOARQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Aug 2023 20:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjHOARI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Aug 2023 20:17:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08B1723
        for <linux-cxl@vger.kernel.org>; Mon, 14 Aug 2023 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692058627; x=1723594627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jFc+jOQDUYtWpuypeq2s3t7TlP6fFAIwQXxumkHBJAc=;
  b=C3saqESKEiocgSqOrp6ExNDq2ZVdN1JLK3nK0xWs56xwV0/AmHfPHA+N
   yq5Y0iHtHjdr9ZRpQCnme5doUalCrl664uUTQva4OzzDZLYashEy65d/c
   G/gQs9UdiuMRxSlIQzg+MpKbCYBNmIuKie3azBmtnrs01IE0gIY328NQ5
   UC5z9F+usfJzNb3jjFA6ML7Ssz+iGOlL2Zu/PZmQZUk6Wbh9vUFdQRUpo
   H5y8MNXn+iUTe0+spxC1sdrzw41P99BDbplUg3ussbpUI5Ym/D9Q+UrUH
   r7vMxpGB5/9H3KlDcy5/ihuhqI8Z4MxhZL9U0byvftBlaCCSF7cHqnYtB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357132462"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357132462"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:17:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="1064261032"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="1064261032"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.148.210])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:17:06 -0700
Date:   Mon, 14 Aug 2023 17:17:05 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Refactor granularity select in
 cxl_port_setup_targets()
Message-ID: <ZNrEAfT/4wXTNHjT@aschofie-mobl2>
References: <20230804232726.1672782-1-alison.schofield@intel.com>
 <6a944c93-6ad6-c934-afa5-276277d4757d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a944c93-6ad6-c934-afa5-276277d4757d@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 09, 2023 at 03:28:36PM -0700, Dave Jiang wrote:
> 
> 
> On 8/4/23 16:27, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > In cxl_port_setup_targets() the region driver validates the
> > configuration of auto-discovered region decoders, as well
> > as decoders the driver is preparing to program.
> > 
> > The existing calculations use the encrypted interleave granularity
> 
> s/encrypted/encoded/

Thanks. I'll clean up the language around this to use encoded & normal.


> 
> > value, the eig, to create an interleave granularity that properly
> > fans out when routing an x1 interleave to a greater than x1 interleave.
> > 
> > That all worked well, until this config came along:
> > Host Bridge: 2 way at 256 granularity
> >      Switch Decoder_A:	1 way at 512
> >          Endpoint_X:	2 way at 512
> >      Switch Decoder_B:	1 way at 512
> >          Endpoint_Y:	2 way at 512
> > 
> > When the Host Bridge interleave is greater that 1, and the root
> > decoder interleave is exactly 1, the region driver needs to
> > consider the number of targets in the region when calculating
> > the expected granularity.
> > 
> > While examining the existing logic, and trying to cover the case
> > above, a couple of simplifications appeared, hence this proposed
> > refactoring.
> > 
> > The first simplicfication is to apply the logic to the unencrypted
> s/simplicfication/simplification/
> s/unencrypted/normal?/

Got it.


> 
> 
> > values and use the existing helper function granularity_to_eig() to
> > translate the desired granularity to the encrypted form. This means
> 
> s/encrypted/encoded/

Got it.

> 
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
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >   drivers/cxl/core/region.c | 17 ++++++++---------
> >   1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e115ba382e04..5a1cc59cca99 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1154,16 +1154,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >   	}
> >   	/*
> > -	 * If @parent_port is masking address bits, pick the next unused address
> > -	 * bit to route @port's targets.
> > +	 * Interleave granularity is a multiple of @parent_port granularity.
> > +	 * Multiplier is the parent port interleave ways.
> >   	 */
> > -	if (parent_iw > 1 && cxl_rr->nr_targets > 1) {
> > -		u32 address_bit = max(peig + peiw, eiw + peig);
> > -
> > -		eig = address_bit - eiw + 1;
> > -	} else {
> > -		eiw = peiw;
> > -		eig = peig;
> > +	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > +	if (rc) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s: invalid granularity calculation (%d * %d)\n",
> > +			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > +		return rc;
> >   	}
> >   	rc = eig_to_granularity(eig, &ig);
> > 
> > base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
