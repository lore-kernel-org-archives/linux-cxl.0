Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD663C19F2D
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Aug 2022 01:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiHJBOp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 21:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiHJBOn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 21:14:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F0804AA
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 18:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660094082; x=1691630082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4vnS4P7Hz5y11sOTtLU3j3IBpb1zPjvJL7oVo0ZdFSg=;
  b=RqQHPqYGHI1jjBTlMjur/AN9S0OmHz6YadRKIShKqkgdY7/FquMloseZ
   GTAJCl8iZ73QNdD3bcevW/6924AfYB5bPuMRr7rFR2aD8TnWwT1CwLkqA
   /CQLEhBCOrd3EVEZ/BhPSNv8R7qMrNMjxJMOBJO+fqX8UassiXW9LQ40n
   uuPxEoXMVLfCXGJXTaz8/gt6eiKxf1iv4Y2BKQfz3OJQqa2LssQipdjVe
   XEnEBi5xl5Y+p0xRwN8mHdoxksJ+amERpTualo9tTsNylCE/JhTgYleTA
   d0BjqsZAKdB1FWHTeegftXmJG10TYIsfmoaW75EGQITvee1UeQa/1hCmB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="288535693"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="288535693"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:14:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="664671076"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 18:14:42 -0700
Date:   Tue, 9 Aug 2022 18:12:23 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <20220810011223.GA1757903@alison-desk>
References: <cover.1660079951.git.alison.schofield@intel.com>
 <f092ab4c6eb82c83c9cec4e7000bac8115c3664d.1660079951.git.alison.schofield@intel.com>
 <62f2ef6e71b35_332482941c@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f2ef6e71b35_332482941c@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 09, 2022 at 04:36:14PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When the CFMWS is using XOR math, parse the corresponding
> > CXIMS structure and store the xormaps in the root decoder.
> > Use the xormaps in a new lookup, cxl_hb_xor(), to discover
> > a targets entry in a host bridge interleave target list.
> > 
> > Defined in CXL Spec 3.0 Section: 9.17.1
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/cxl.h  |  2 +
> >  drivers/cxl/acpi.c | 96 +++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 93 insertions(+), 5 deletions(-)
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
> > index fb649683dd3a..6ac6751c7f4e 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -9,6 +9,79 @@
> >  #include "cxlpci.h"
> >  #include "cxl.h"
> >  
> > +struct cxims_data {
> > +	int nr_maps;
> > +	u64 xormaps[];
> > +};
> > +
> > +static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> > +{
> > +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> > +	struct cxims_data *cximsd = cxlrd->platform_data;
> > +	struct cxl_decoder *cxld = &cxlsd->cxld;
> > +	int ig = cxld->interleave_granularity;
> > +	int i, n = 0;
> > +	u64 hpa;
> > +
> > +	if (dev_WARN_ONCE(&cxld->dev,
> > +			  cxld->interleave_ways != cxlsd->nr_targets,
> > +			  "misconfigured root decoder\n"))
> > +		return NULL;
> > +	/*
> > +	 * Find this targets entry (n) in the host bridge interleave
> > +	 * list. Defined in CXL Spec 3.0 Section 9.17.1.3 Table 9-22
> > +	 */
> > +	hpa = cxlrd->res->start + pos * ig;
> > +	for (i = 0; i < cximsd->nr_maps; i++)
> > +		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
> > +
> > +	return cxlrd->cxlsd.target[n];
> > +}
> > +
> > +struct cxl_cxims_context {
> > +	struct device *dev;
> > +	struct cxl_root_decoder *cxlrd;
> > +};
> > +
> > +static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
> > +			   const unsigned long end)
> > +{
> > +	struct acpi_cedt_cxims *cxims = (struct acpi_cedt_cxims *)header;
> > +	struct cxl_cxims_context *ctx = arg;
> > +	struct cxl_root_decoder *cxlrd = ctx->cxlrd;
> > +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> > +	struct device *dev = ctx->dev;
> > +	struct cxims_data *cximsd;
> > +	unsigned int hbig;
> > +	u8 eiw;
> 
> Per your comment on Dave's patch lets keep eiw as a shorthand for
> "encoded interleave ways" i.e. the ilog2()'ish value of interleave-ways.
> So just: s/eiw/iw/.

Then maybe it's intentionally wrong. The eiw tells the number of
xormaps to store for use in cxl_hb_xor(). The 'iw', as stored in
cxld->interleave_ways would be too many, so I translate back to the
encoded version here.

> 
> Otherwise, looks good to me. Just need the ACPICA side to land.
