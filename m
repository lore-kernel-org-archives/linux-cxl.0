Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D1CC4708D
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 20:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjADU0C (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 15:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbjADUZ4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 15:25:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0DC1C414
        for <linux-cxl@vger.kernel.org>; Wed,  4 Jan 2023 12:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672863954; x=1704399954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IvitO1NUNviR5+jSRFUomsNZLGPn9HyazOoIDxLkthQ=;
  b=BigKQP4VErZf7T6HGZm9hd5pcKxSi8xpikODmHLfpl/ofC20G5o58N92
   iG4sofBkBvg/Sx5GCpkszxuADpeBXViNiVQ9vG0uT3uXg0aXnRPGM643J
   4hh1v8OcLD2wHdOyonLJb1mEp4ItSJsHWCNf/dRYpNhRzOFPxVnnHvZd0
   7DqoLPXLxCqMSlU0FPosa17cTBorkGsLXh2Ed+C/T06ORB3C9E6zw6XTJ
   8Moo03Zp5UaApkomJexli68Nqbo5cNUzZpRRfvjNtrHNfpmhIG9wqT1ww
   FmOi8l8PQpXZDv7CZvphWrOTd7+eiDpJsuCeV/Xha6b7StR+mlc73OapB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="386469688"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="386469688"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:25:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="984043340"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="984043340"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.42.169])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 12:25:53 -0800
Date:   Wed, 4 Jan 2023 12:25:51 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4] cxl/region: Check addr trans at pmem region create
 (debug only)
Message-ID: <Y7Xgz1e0lSXiaDDy@aschofie-mobl2>
References: <cover.1669153711.git.alison.schofield@intel.com>
 <48b8ab49a54597d56b1732fc4e2955b5e726d4c9.1669153711.git.alison.schofield@intel.com>
 <20221130164235.000064a5@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130164235.000064a5@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 30, 2022 at 04:42:35PM +0000, Jonathan Cameron wrote:
> On Tue, 22 Nov 2022 15:07:49 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > At the time of region creation, device physical addresses (DPA)
> > are mapped to host physical addresses (HPA). The CXL driver
> > translates DPA's to HPA's for user space consumption. In order
> > to prove and exercise that translation functionality, perform
> > a small sample of DPA to HPA translations whenever a pmem region
> > is created in a debug kernel.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> I'd drop this patch - it isn't doing a particularly useful check
> as it only checks the resulting HPA is in range, not that it's
> actually correct.

Hi Jonathan,
Belated thanks on this review. I've put this set aside and implemented
the DPA -> HPA translation for the specific use case of adding an 
HPA field to the cxl_poison TRACE EVENT. I'm about to post that
patch, but want to respond to your feedback, which I did take
into the new patch.

more...


> 
> 
> > ---
> >  drivers/cxl/core/region.c | 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index c847517e766c..32216b5fe450 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1945,6 +1945,36 @@ u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
> >  	return hpa;
> >  }
> >  
> > +static bool cxl_check_addrtrans(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	u64 start, end, dpa;
> > +
> > +	/*
> > +	 * Translate a few DPAs (start,mid,end) to HPAs
> > +	 * for each contributing endpoint decoder.
> > +	 */
> > +	for (int i = 0; i <  p->nr_targets; i++) {
> > +		cxled = p->targets[i];
> > +		start = cxl_dpa_resource_start(cxled);
> > +		end = start + cxl_dpa_size(cxled) - 1;
> > +
> > +		dpa = start;
> > +		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
> > +			return false;
> Hmm. This verifies they are in range, but not that the
> address is right.  Not sure that is particularly helpful.
> Also - in theory, hpa address 0 is valid value, or does something
> stop people putting a CFMWS at HPA 0 onwards?
> Sure it's unlikely anyone will do so, but not impossible...
> 

Understand about the HPA 0 now, and use ULLONG_MAX as failure
on non-translateable - in future patch.


> > +
> > +		dpa = start + cxl_dpa_size(cxled) / 2;
> > +		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
> > +			return false;
> > +
> > +		dpa = end;
> > +		if (!cxl_dpa_to_hpa(dpa, cxlr, cxled))
> > +			return false;
> Maybe more useful to check 1 higher and trip the 'out of range'
> return?

So, I've dropped this check on region create work entirely for now.

> > +	}
> > +	return true;
> > +}
> > +
> >  /**
> >   * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> >   * @cxlr: parent CXL region for this pmem region bridge device
> > @@ -1973,8 +2003,10 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> >  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> >  		dev_name(dev));
> >  
> > +	dev_dbg(&cxlr->dev, "Address translation check: %s\n",
> > +		cxl_check_addrtrans(cxlr) ? "Pass" : "Fail");
> > +
> >  	return devm_add_action_or_reset(&cxlr->dev, cxlr_pmem_unregister, dev);
> > -
> 
> stray change

Thanks

> 
> >  err:
> >  	put_device(dev);
> >  	return rc;
> 
