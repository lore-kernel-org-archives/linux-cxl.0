Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E73E546
	for <linux-cxl@vger.kernel.org>; Thu,  7 Mar 2024 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709786460; cv=none; b=O0Wa0Uxt2kqbMdrSAhrjRAo0J8NUrA83adSMGmCIy8gNnqs9cumpO0n8d197Cj+3Q2LmPivjKE5/QxHyxLY86Rc7B88Bkw/ILHKXADIiOu9n1xNdhb7tCPxhJfg5vYJjmac4rnp2MR7eoaGoWKbJwu8Dp4ZOvX4I4a5hXeKmafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709786460; c=relaxed/simple;
	bh=j+oDve+5N6FwzukuKwJjRIFkdIgGtj4LQHR4HINuyhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erVMKepjcj4aHjooOS10FGCm4oDJ8fKxpRWyaohqCOpeJM6rvEdaKLDLBjyy2UIWwUkdAu0QWD+hps2MfzsFuLm6JBXr3wzfiFQeAg81j7OmOgd0cr62wuciCZ7yAlLaq9iKviqZ+7XfmtQAmcvOrdHtHDAem4LEpQk0xB3TOZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpoUn00B; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpoUn00B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709786459; x=1741322459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j+oDve+5N6FwzukuKwJjRIFkdIgGtj4LQHR4HINuyhY=;
  b=FpoUn00B1Gppd9I4aLtI6t8CmhHmInpp5OpMRWzA0WDWqiVG38hrltRT
   sUhxCupPRFWnkm/gwFgMnpZYMfxOA7WbUUccPZ+YX74VYr61iDEnx+yOx
   g1M6rEF5ACq2vjX6zkjB6ZceNii7txg72x0KIoGL9eG7AEXcVBLBul7la
   fLtov9jhWiIvMc9URnF9UFkxBWeZ2B2KmYKn8d0TO7/8KuDWwwe0uU6iX
   a+juY3nMCqxZFzLTxcen6xH5C3eC38izAfku/MCqPyDdI23YTroc4Q9Bg
   XJFQqkskterUfvczMLWCLkQYf87cDeR7M3C/WzuNxZflCNxj3/dq8pI4V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4559081"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4559081"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 20:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="10413397"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.9.155])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 20:40:58 -0800
Date: Wed, 6 Mar 2024 20:40:55 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/acpi: Fix XOR 3-6-12 way host bridge look-up
 calculation
Message-ID: <ZelFV/y3X+l4Wf0J@aschofie-mobl2>
References: <cover.1707891715.git.alison.schofield@intel.com>
 <0eebc96f0e36ebc74b0dc0f4112b70cced6907a7.1707891715.git.alison.schofield@intel.com>
 <65e0d0b7bd91f_1138c72943c@dwillia2-xfh.jf.intel.com.notmuch>
 <65e106a0e45f8_1138c729462@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e106a0e45f8_1138c729462@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Feb 29, 2024 at 02:35:12PM -0800, Dan Williams wrote:
> Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > The XOR host bridge look-up function is broken in its application
> > > of the modulo calculation for interleaves that are multiples of 3.
> > > 
> > > The failure appears like this:
> > > [] cxl_core:cxl_region_attach_position:1433: cxl region4: mem0:decoder8.1 invalid target position for decoder3.2
> > > 
> > > Replace the broken modulo calc with the same modulo calc as used
> > > for Modulo Math. This is per CXL spec definition but was overlooked
> > > in the original over-complicated implementation.
> > > 
> > > With the simple modulo calculation, the jump to a helper function
> > > becomes needless and the work is now presented in a straight line.
> > > 
> > > Display the interleave_arithmetic in the dev_dbg() of successfully
> > > setup root decoders to make debug lookup easier.
> > > 
> > > Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> [..]
> > > -	/* Entry (n) is 0 for no interleave (iw == 1) */
> > > -	if (iw != 1)
> > > -		n = cxl_xor_calc_n(hpa, cximsd, iw, ig);
> > > +	if (iw == 6 || iw == 12)
> > > +		n |= pos % iw;
> > 
> > Can you help me map this back to Table-9-22?
> > 
> > Shouldn't this be:
> > 
> > 	n |= (pos % iw) << (iw / 3);
> 
> Wait, no:
> 
>  	n |= (pos % iw) * (iw / 3);
> 
> ...to match:
> 
>  6:   + 2* HPA[51:9+HBIG] MOD 3
> 
>  12:  + 4* HPA[51:10+HBIG] MOD 3

Hi Dan,

tl;mrp  <-- must read please :)


Yes - that table is the key and I have a new found understanding, or
misunderstaning, of how to use it to share here.

But first, I did follow up on your suggestions along with more
variation to try and fix the existing code path:

Evaluating other calcs with an HBIW of 6 and pos[0..5]:

> Shouldn't this be:
> 
> 	n |= (pos % iw) << (iw / 3);
No. For each pos in [0..5] and HBIW = 6 the right-hand side of that
assignment results in 0, 4, 8, 12, 16, and 20, so goes beyond the
HBIW of 6.

> Wait, no:
>
> 	n |= (pos % iw) * (iw / 3);
No. The right side yields 0,2,4,6,8,10, beyond HBIW of 6.

I sampled many flavors of these and kept going back to Table-22
and a 6 way HB interleave setup, trying to make something work.
The fact that the target-list is in HB interleave order hit me
and here's where it took me:

From Table - 22 "A list of all the Interleave Targets. The number of
entries in this list shall match the Number of Interleave Ways (NIW).
The order of the targets reported in this List indicates the order
in the Interleave Set"

Using a 6 way Host Bridge Interleave: HB0  HB1  HB2  HB3  HB4  HB5

Using this CFMWS and CXIMS. This is a sample of what a 6 way interleave
may look like and how the xormap directs the traffic to HBs.

cfmws30 = {
                .cfmws = {
                        .header = {
                                .type = ACPI_CEDT_TYPE_CFMWS,
                                .length = sizeof(mock_cedt.cfmws30),
                        },
                        .interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
                        .interleave_ways = 9,
                        .granularity = 0,
                        .restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
                                        ACPI_CEDT_CFMWS_RESTRICT_PMEM,
                        .qtg_id = 0,
                        .window_size = SZ_256M * 24UL,
                },
                .target = { HB0, HB3, HB4, HB1, HB2, HB5 },
        },
cxims0 = {
                .cxims = {
                        .header = {
                                .type = ACPI_CEDT_TYPE_CXIMS,
                                .length = sizeof(mock_cedt.cxims0),
                        },
                        .hbig = 0,
                        .nr_xormaps = 1,
                },
                /* xormap for 6 way interleave */
                .xormap_list = { 0x2020900 },
        },


Given an HPA, HBIG, HBIW - the Table 9-22 calcs direct the routing of
that HPA. In order to route an address to the correct decoder (N), do

N = XORALLBITS (HPA AND XORMAP[0]) + 2* HPA[51:9+HBIG] MOD 3

Example data: hpa:0xf010000100 map:0x2020900 HBIG: 6
N = XORALLBITS (0xf01000010 AND 0x2020900) + 2* 1 MOD 3
N = 3

That says to route HPA 0xf01000100 to the 3rd Host Bridge: HB3
(And, of course, part of the routing is that gets reduced to
an offset, the position bit gets removed and the offset is
applied to the DPA base.)

All very interesting but is not applicable for what the driver
is trying to do in calc_hb. The driver wants to find the index
into the root decoder (cxlsd) target list. It is not HB3.

Recall that the CFMWS presents the target list is interleave order.
The CXL driver stores that target_list in interleave order.

Applying the Table 9-22 calc doesn't apply. It shouldn't and my ahah
moment here is that the CXL driver does not need to use that calc.
I didn't see this until I had that 6 way HBIW where a CFMWS target
list was 'dis-ordered'. Previously, 2 & 4 way XOR, applying the
calc was needless, but functioned, because the lists were ordered.

Given that the drivers target-list is in interleave order, use (pos % HBIW)
to get the index into the decoder target list. We don't need the 
complex calc to jump to the right location in the interleave since
we stored the interleave order. And note that the (pos % HBIW) will
fail with 'invalid target position' if the region creation is attempted
with a badly ordered target list. The check is as valid as ever.

I've verified this with these configs:
configs="1 11 111 1111 111111 2 22 222 2222 222222 4 44"
where an entry like 111 means 1+1+1 means 3 way HB Interleave

I only reached this point while working on that 6 way XOR config.
The upstream code works for 1 11 1111 and the like probably because
the lists were simply ordered. 

I'm ready to hear where this goes wrong. It reminds me of the address
translation work where I was hung up on the xormaps until figuring out
that those were routing instructions and didn't come into play at the
driver level of translation.

Direction check please. If this makes sense, the fix is simple, but the
cleanup of useless code will cause some churn.

Alison

