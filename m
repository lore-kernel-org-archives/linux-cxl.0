Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC87C7EE22
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 00:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbjELADf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 20:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbjELADf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 20:03:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53015255
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 17:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683849783; x=1715385783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WQrmkTQHCvluhbHGvafC5quwR9aWF5OH1hilV3DiaUg=;
  b=S7HceML/M9VfMqzJ9H9VOzm18UvAio0G7xA2N6JlUv+qrjX360avlMFp
   +si5zGavVsk/EERLnpsOeE68XZJ7GjFbRHLPEAP0n7zdQJrOUdEJpcnNV
   x3lknDoXenQCrFaKqX9CgC8b32cLj8pLFHRwa0JChYB+sfM+74Q2eCPVp
   hmX915k9zde/+1E3wZTgAmkbw1e3VIh7EmR0ApIb50mStpy4L05Ksn9js
   EQiFODV/IUhaHJu52P3/ID1Jyg7f75pqnl6NDmB2Qizgn9DezOlOza+P6
   DtXrbA7nC+IHmfGoPx9K1pesYaHfhHGD1NMtpSdclIpXl4cedJwBm86Km
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="330283433"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="330283433"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 17:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769578530"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="769578530"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.63.7])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 17:01:21 -0700
Date:   Thu, 11 May 2023 17:01:19 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org
Subject: Re: [RFC 3/3] ACPI: NUMA: Apply SRAT proximity domain to entire
 CFMWS window
Message-ID: <ZF2Bz9Kw9rNOyOdZ@aschofie-mobl2>
References: <cover.1683742429.git.alison.schofield@intel.com>
 <79a10b7101a8fab56f9ff3f9a4de73bee3156b40.1683742429.git.alison.schofield@intel.com>
 <645d7765a218a_1e6f2944c@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <645d7765a218a_1e6f2944c@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, May 11, 2023 at 04:16:53PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:

snip...

> > +	/*
> > +	 * The SRAT may have already described the NUMA details for
> > +	 * this CFMWS HPA range, yet it may not have created memblks
> > +	 * for the entire range. Look for a node with a memblk covering
> > +	 * any part of the HPA range. Don't bother figuring out if it
> > +	 * is partially or wholly described. Replace any memblks in the
> > +	 * range with one single memblk that covers the entire range.
> > +	 *
> > +	 * This preserves the SRAT defined node and Proximity Domain.
> > +	 */
> > +
> > +	found_node = numa_find_node(start, end);
> > +	if (found_node != NUMA_NO_NODE) {
> > +		numa_remove_memblks(found_node, start, end);
> > +		if (numa_add_memblk(found_node, start, end) < 0) {
> 
> I worry that this blows away information in the case where the BIOS for
> some reason decides to describe multiple proximity domains per CXL
> window.
> 
> I think this wants to be an algorithm like
> 
> numa_fill_memblks(start, end)
> 
> ...where that walks the range and for any gaps in that range extend the
> last memblk to the end of the gap.
> 
> For example if the CFWMS to SRAT mapping is this:
> 
>  ┌──────────────────────────────────────────────────┐
>  │                  WINDOW0                         │
>  ├──────────┬────────────┬────────────┬─────────────┤
>  │PXM0      │ GAP        │ PXM1       │ GAP         │
>  └──────────┴────────────┴────────────┴─────────────┘
> 
> 
>  ┌──────────────────────────────────────────────────┐
>  │                  WINDOW0                         │
>  ├───────────────────────┬──────────────────────────┤
>  │PXM0                   │ PXM1                     │
>  └───────────────────────┴──────────────────────────┘
> 
> ...and if that finds nothing to fill, *then* create the next proximity
> domain for the window.

Thanks for the feedback Dan.

Is there any guarantee that the first PXM begins at cfmws.start?
ie...that gaps always 'follow'

This one's easy:	gap-pxm0 	becomes all pxm0
This one's easy too:	gap-pxm0-gap 	becomes all pxm0

This one's not so obvious: gap-pxm0-gap-pxm1 

Imagine those are quarters. Is the end result 50/50 or 75/25?

I'm wondering if there is any policy in existence or this is new,
and we are setting the policy now?

Alison

> 
> 
> > +			/* CXL driver must handle the NUMA_NO_NODE case */
> > +			pr_warn("ACPI NUMA: failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> > +				found_node, start, end);
> > +		}
> >  		return 0;
> > +	}
> >  
> > +	/*
> > +	 * SRAT did not describe this window at all.
> > +	 * Create a new node with a fake proximity domain. Add a
> > +	 * memblk covering the entire HPA range.
> > +	 */
> >  	node = acpi_map_pxm_to_node(*fake_pxm);
> >  
> >  	if (node == NUMA_NO_NODE) {
> >  		pr_err("ACPI NUMA: Too many proximity domains while processing CFMWS.\n");
> >  		return -EINVAL;
> >  	}
> > -
> 
> Unrelated whitespace change.
> 
> >  	if (numa_add_memblk(node, start, end) < 0) {
> >  		/* CXL driver must handle the NUMA_NO_NODE case */
> >  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> > -- 
> > 2.37.3
> > 
> 
> 
