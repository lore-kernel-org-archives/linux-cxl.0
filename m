Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75865CA0FFA
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 17:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjIERqy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbjIERqf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 13:46:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837832C6DD
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693934989; x=1725470989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6bArw/fGIA7yaLAINoWv+uHN2LGzvreGmvSL5JCBaxw=;
  b=LUwHTXpvd4bJAP78PX4ybdbIETs15iG/kWypCXPpilVDNNLVVUy+IIIZ
   0uCZcTNkZ6QNnkcjo4ONcHVajana0AA0EK0/X8GWSh9Z16SoeIy2P8sxG
   QwfOVt08eIzLJTKz9nGrgDd1Qh0+H2euSMA2CI9mVaSO7CRKeJJpmDmQt
   VYTD/gfoqsQCinxuJLIUa742f8BCvTT2SyN/UTjn2/b0e5qo8FnJeKb6h
   08Z0MaS9TviDKjLcaIuaxCN1XlLGxP01CEbromYi9YcAllrZFTrbdFTrx
   6Ll+fQ3uKlEf25rYI+lSJzBVWgSiHThKybhEhaXXb2RIPSgy+VW0dPDek
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="380663778"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="380663778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741171611"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="741171611"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.50.9])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:29:01 -0700
Date:   Tue, 5 Sep 2023 10:29:00 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Refactor granularity select in
 cxl_port_setup_targets()
Message-ID: <ZPdlXLchNe9T4r5S@aschofie-mobl2>
References: <20230822180928.117596-1-alison.schofield@intel.com>
 <20230829143240.000072d7@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829143240.000072d7@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 29, 2023 at 02:32:40PM +0100, Jonathan Cameron wrote:
> On Tue, 22 Aug 2023 11:09:28 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > In cxl_port_setup_targets() the region driver validates the
> > configuration of auto-discovered region decoders, as well
> > as decoders the driver is preparing to program.
> > 
> > The existing calculations use the encoded interleave granularity
> > value to create an interleave granularity that properly fans out
> > when routing an x1 interleave to a greater than x1 interleave.
> > 
> > That all worked well, until this config came along:
> > Host Bridge: 2 way at 256 granularity
> >     Switch Decoder_A:	1 way at 512
> 
> Arguably doesn't matter what the granularity is for a 1 way
> decode. Probably just drop that or does it matter for the
> calculations somewhere?
> 
>       Switch Decoder_A: 1 way

I agree that the gran for a 1 way decode doesn't matter. The config
offered is an example, so it includes actual gran.

> 
> Feel free to ignore the suggestion below.

see below -

> 
> 
> >         Endpoint_X:	2 way at 256
> >     Switch Decoder_B:	1 way at 512
> >         Endpoint_Y:	2 way at 256
> > 
> > When the Host Bridge interleave is greater than 1 and the root
> > decoder interleave is exactly 1, the region driver needs to
> > consider the number of targets in the region when calculating
> > the expected granularity.
> > 
> > While examining the existing logic, and trying to cover the case
> > above, a couple of simplifications appeared, hence this proposed
> > refactoring.
> > 
> > The first simplification is to apply the logic to the nominal
> > values and use the existing helper function granularity_to_eig() to
> > translate the desired granularity to the encoded form. This means
> > the comment and code regarding setting address bits is discarded.
> > Although that logic is not wrong, it adds a level of complexity that
> > is not required in the granularity selection. The eig and eiw are
> > indeed part of the routing instructions programmed into the decoders.
> > Up-level the discussion to nominal ways and granularity for clearer
> > analysis.
> > 
> > The second simplification reduces the logic to a single granularity
> > calculation that works for all cases. The new calculation doesn't
> > care if parent_iw => 1 because parent_iw is used as a multiplier.
> > 
> > The refactor cleans up a useless assignment of eiw made after the
> > iw is already calculated.
> > 
> > Regression testing included an examination of all of the ways and
> > granularity selections made during a run of the cxl_test unit tests.
> > There were no differences in selections before and after this patch.
> > 
> > Fixes: ("27b3f8d13830 cxl/region: Program target lists")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > Changes in v2:
> > - No changes to the code. Commit log fixups only.
> > - Correct the commit log example. Endpoints are 2 * 256 (Jonathan)
> > - Use 'encoded' and 'nominal' when referring to the interleave
> >   granularity format (Dan, DaveJ) 
> > - Commit log grammar & spelling fixups (Dan, DaveJ)
> > - Add Fixes Tag (Dan)
> > - v1: https://lore.kernel.org/linux-cxl/20230804232726.1672782-1-alison.schofield@intel.com/
> > 
> >  drivers/cxl/core/region.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
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
> 
> This threw me briefly.   eiw isn't used before this patch.
> You 'could' pull that out as a precursor to make this logic a tiny bit
> more obvious but meh it may not be worth doing so.

I expect it will ease the backport of this fix to keep as is.

Alison

> 
> I've not checked the maths (As interleave gives me headaches far too quickly
> so will rely on the you and the other reviewers to ensure that was right :)
> 
> 
> 
> > -		eig = peig;
> > +	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > +	if (rc) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s: invalid granularity calculation (%d * %d)\n",
> > +			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > +		return rc;
> >  	}
> >  
> >  	rc = eig_to_granularity(eig, &ig);
> > 
> > base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
> 
