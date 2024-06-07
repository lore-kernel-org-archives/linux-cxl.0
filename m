Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331F4DA08
	for <linux-cxl@vger.kernel.org>; Fri,  7 Jun 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717784429; cv=none; b=DMbzaJGoKBu0PNitl9NTTQx15iK2/oTxIHUJflep+DwLFfnDwqtJuwq+nyFfN6dU/jrscrfCXezzWedSzCsAevprtkkraYBMf8No8u3w8UNfv9jEX+zljtsqY8Bh4O2Co7dshekcAGQ7QY+bYwPoB3TQ9caT56iA35tKyOTwPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717784429; c=relaxed/simple;
	bh=laQ7vjO3ip3SE9pnFq3RkHd5py36rjDfM4jBd7olzc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaoPQoGwzEiV7It5pS9GEbxsMc+FhhgoIKgZfeKq60e0E3jcStuxFTuqZ+IlxVwqvV9wMKvYUZ+NpbQN4crVL9RI2LB0AY1Fca4ULUav7IYAFp9bLCKFZ6Q8Gmjv7qv/82yJaiBYiXdKFCXQ7bfNXBQjrqMNy4MX/Sdo6remSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ue2gHIO0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ue2gHIO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717784427; x=1749320427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=laQ7vjO3ip3SE9pnFq3RkHd5py36rjDfM4jBd7olzc0=;
  b=Ue2gHIO0Vg835K6+wLuxboFoEbWwctuIbNB9PiZmGJX+girqnxWrTR/q
   aOcTb43skeQ/bXcdimJcOAJcGXhvqox7UtL4Musy9aJinv13RMgjQD0Au
   bLgJmU77qxgBdLcqtHvNHiuds5RSc70mrxUfmXxy2QckxF6XE7NJex7Z6
   pJ6KZkDU8ap7qu9nTuaf8StQkNl7aEdG9Ri54unh0Sz3YlKNDPUZRHMN+
   up8TDo4LHcQKRHX3HILjDA1sO/HN7IqpnxwPyuWxlvMs/bQMwycgmNm5i
   5YwukT/PWRudmBm+esHyfatD3UZ4rLGsfVBIFPXw8lWPgf16Xs9IFxFDW
   A==;
X-CSE-ConnectionGUID: kNrOJZr7RtaKMbb2ewuKug==
X-CSE-MsgGUID: sXQlK0F4T52QWqmkS7g9VQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="18345783"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="18345783"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 11:20:27 -0700
X-CSE-ConnectionGUID: 5FsQ2/j1S4qm7xVpihGx9w==
X-CSE-MsgGUID: EIti3GF3TNq1S7oJUOCmEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="75894515"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.38.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 11:20:26 -0700
Date: Fri, 7 Jun 2024 11:20:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/4] cxl/acpi: Restore XOR'd position bits during
 address translation
Message-ID: <ZmNPaXST5ninEBbx@aschofie-mobl2>
References: <cover.1715192606.git.alison.schofield@intel.com>
 <77d251960a557f23aa6e6e0465e0e42f1d461514.1715192606.git.alison.schofield@intel.com>
 <20240607160114.00006e4d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607160114.00006e4d@Huawei.com>

On Fri, Jun 07, 2024 at 04:01:14PM +0100, Jonathan Cameron wrote:
> On Wed,  8 May 2024 11:47:51 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a CXL region is created in a CXL Window (CFMWS) that uses XOR
> > interleave arithmetic XOR maps are applied during the HPA->DPA
> > translation. The XOR function changes the interleave selector
> > bit (aka position bit) in the HPA thereby varying which host bridge
> > services an HPA. The purpose is to minimize hot spots thereby
> > improving performance.
> > 
> > When a device reports a DPA in events such as poison, general_media,
> > and dram, the driver translates that DPA back to an HPA. Presently,
> > the CXL driver translation only considers the modulo position and
> > will report the wrong HPA for XOR configured CFMWS's.
> > 
> > Add a helper function that restores the XOR'd bits during DPA->HPA
> > address translation. Plumb a root decoder callback to the new helper
> > when XOR interleave arithmetic is in use. For MODULO arithmetic, just
> > let the callback be NULL - as in no extra work required.
> > 
> > Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Trivial comment inline.   Agree entirely that some tests would be good.
> I ran through a few trivial cases on a bit of paper and it looks to
> me like it works but that hardly counts as testing :)

Thanks for the review and for doing some calcs.

I've become very adept at working these out with paper/pencil, that hop
to C implementation is the challenge ;)

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hmm...well, let me know if I can keep that after you read below...

> 
> > ---
> >  drivers/cxl/acpi.c        | 48 ++++++++++++++++++++++++++++++++++++---
> >  drivers/cxl/core/port.c   |  5 +++-
> >  drivers/cxl/core/region.c |  5 ++++
> >  drivers/cxl/cxl.h         |  6 ++++-
> >  4 files changed, 59 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 571069863c62..20488e7b09ac 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -74,6 +74,43 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> >  	return cxlrd->cxlsd.target[n];
> >  }
> >  
> > +static u64 cxl_xor_translate(struct cxl_root_decoder *cxlrd, u64 hpa)
> > +{
> > +	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> > +	int hbiw = cxlrd->cxlsd.nr_targets;
> > +	u64 val;
> > +	int pos;
> > +
> > +	/* No xormaps for host bridge interleave ways of 1 or 3 */
> > +	if (hbiw == 1 || hbiw == 3)
> > +		return hpa;
> > +
> > +	/*
> > +	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
> > +	 * the position bit to its value before the xormap was applied at
> > +	 * HPA->DPA translation.
> > +	 *
> > +	 * pos is the lowest set bit in an XORMAP
> > +	 * val is the XORALLBITS(HPA & XORMAP)
> > +	 *
> > +	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
> > +	 * as an operation that outputs a single bit by XORing all the
> > +	 * bits in the input (hpa & xormap). Implement XORALLBITS using
> > +	 * hweight64(). If the hamming weight is even the XOR of those
> > +	 * bits results in 0, if odd the XOR result is 1.
> > +	 */
> > +
> > +	for (int i = 0; i < cximsd->nr_maps; i++) {
> > +		if (!cximsd->xormaps[i])
> > +			continue;
> > +		pos = __ffs(cximsd->xormaps[i]);
> 
> At the moment the comment on XORALLBITS isn't associated with this
> code very well. I'd factor it out as cxl_xorallbits() mostly so
> you can stick the comment next to the bit that does the work.
> Or maybe a #define XORALLBITS(hpa, xormap)  is good enough if
> you move it up under the comment.
> 
> > +		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
> > +		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
> > +	}
> > +
> > +	return hpa;
> > +}
> > +

You haven't convinced me that readers will not be able to associate
the block comment directly above the for-loop with the work inside
the for-loop. Especially since this is a 25 line function with a
single focus.

I intentionally didn't insert line-by-line commentary in the
for loop, but rather told the story in the comment and then
just did it. 

Maybe repeating 'val' here, wraps up the comment better:

-        * bits results in 0, if odd the XOR result is 1.
+        * bits results in val==0, if odd the XOR results in val==1.

-- Alison









> 
> 
