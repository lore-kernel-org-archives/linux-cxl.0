Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FECC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 07:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiJZHMi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 03:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiJZHMh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 03:12:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0107DBA266
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 00:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666768356; x=1698304356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gQzfSI09V3ZSYrLIPOlifwAxteAY9ldJwDezZ+mNKvE=;
  b=MtxEGYF95KQFM7qoasFOH37AkEhaEgXFuRNqO5oST11tdipBuzO3xlb6
   jqjYEA8SM313nN0n+WzIXFbTmKRfZJNYXxGJ3A9xlk2Hd4fvtqXyV0clX
   EOkZTwPTRGS5JW6In4xORhBBa0st4PzLETrHYxDn8lVyzpa6m6iDirBdZ
   4qztw59ECGvKXExFD4Pwjq5ZvTMqr0urIvLzJuwG9J48cOMSVRnpIKfgg
   Mfa1STwX2eVmitdNUAXfmidEk1cs0JKLb7T8AhODa9hsSU4CMUytqRbyY
   2Qe3STP+ZiAvzPF0Qb4YBnyt6GIBydd+Y2iwIMWFXGI2O/7bcOmVQZs1h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="306607824"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="306607824"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 00:12:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="757206532"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="757206532"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.16.15])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 00:12:36 -0700
Date:   Wed, 26 Oct 2022 00:12:34 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <Y1jd4mE5n4P1+Jtw@aschofie-mobl2>
References: <cover.1663687681.git.alison.schofield@intel.com>
 <8c93daf7080f45ad4085d6e8556e4deac03f6322.1663687681.git.alison.schofield@intel.com>
 <635332e65ebec_4da329485@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635332e65ebec_4da329485@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 21, 2022 at 05:01:42PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When the CFMWS is using XOR math, parse the corresponding
> > CXIMS structure and store the xormaps in the root decoder
> > structure. Use the xormaps in a new lookup, cxl_hb_xor(),
> > to find a targets entry in the host bridge interleave
> > target list.
> > 
> > Defined in CXL Specfication 3.0 Section: 9.17.1
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/cxl.h  |   2 +
> >  drivers/cxl/acpi.c | 133 +++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 130 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index f680450f0b16..0a17a7007bff 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -330,12 +330,14 @@ struct cxl_switch_decoder {
> >   * @res: host / parent resource for region allocations
> >   * @region_id: region id for next region provisioning event
> >   * @calc_hb: which host bridge covers the n'th position by granularity
> > + * @platform_data: platform specific configuration data
> >   * @cxlsd: base cxl switch decoder
> >   */
> >  struct cxl_root_decoder {
> >  	struct resource *res;
> >  	atomic_t region_id;
> >  	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
> > +	void *platform_data;
> >  	struct cxl_switch_decoder cxlsd;
> >  };
> >  
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index fb649683dd3a..51cd45d2ed98 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -6,9 +6,110 @@
> >  #include <linux/kernel.h>
> >  #include <linux/acpi.h>
> >  #include <linux/pci.h>
> > +#include <asm/div64.h>
> >  #include "cxlpci.h"
> >  #include "cxl.h"
> >  
> > +struct cxims_data {
> > +	int nr_maps;
> > +	u64 xormaps[];
> > +};
> > +
> > +/*
> > + * Find a targets entry (n) in the host bridge interleave list.
> > + * CXL Specfication 3.0 Table 9-22
> > + */
> > +static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> > +{
> > +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> > +	struct cxims_data *cximsd = cxlrd->platform_data;
> > +	struct cxl_decoder *cxld = &cxlsd->cxld;
> > +	int ig = cxld->interleave_granularity;
> > +	int iw = cxld->interleave_ways;
> > +	int i, eiw, n = 0;
> > +	u64 hpa;
> > +
> > +	if (dev_WARN_ONCE(&cxld->dev,
> > +			  cxld->interleave_ways != cxlsd->nr_targets,
> > +			  "misconfigured root decoder\n"))
> > +		return NULL;
> > +
> > +	if (iw == 1)
> > +		/* Entry is always 0 for no interleave */
> > +		return cxlrd->cxlsd.target[0];
> > +
> > +	hpa = cxlrd->res->start + pos * ig;
> > +
> > +	if (iw == 3) {
> > +		/* Initialize 'i' for the modulo calc */
> > +		i = 0;
> 
> From cxl_acpi:
> 
> nr_maps = ilog2(cxld->interleave_ways / 3);
> 
> ...so cximsd->nr_maps is already 0 when iw is 3, so no need for a goto,
> unless I missed something.

That'd be a NULL dereference. For x1 and x3, which don't use
xormaps, no cximsd is saved. 

I kept the goto, but moved the init to the declaration.

> 
> > +		goto no_map;
> > +	}
> > +
> > +	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
> > +	for (i = 0; i < cximsd->nr_maps; i++)
> > +		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
> > +
> > +no_map:
> > +	/* IW: 3,6,12 add a modulo calculation to 'n' */
> > +	if (!is_power_of_2(iw)) {
> > +		eiw = ilog2(iw / 3) + 8;
> > +		hpa &= GENMASK_ULL(51, eiw + ig);
> > +		n = do_div(hpa, 3) << i;
> 
> I would just use "<< cxmisd->nr_maps" and move this before the
> power-of-2 loop with its own early "return cxlrd->cxlsd.target[n];" in
> the 'if ()' block. No need to force these 2 cases to have a common exit.

That makes sense based on what you see above, but the code is wrong.
It should add that final calc to the 'n' that was started with the xormaps.
Although x3 doesn't use any maps, x6 and x12 do.

this:
> +             n = do_div(hpa, 3) << i;
it should be
 +             n |= do_div(hpa, 3) << i;



