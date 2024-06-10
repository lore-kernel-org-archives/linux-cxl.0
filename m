Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009F78B4C
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014839; cv=none; b=f8HDVWJf2cQoFV6TeZPwHDHc9bq5XccPDloulIh2M0V9bAYoRp3VYLrzzHkqdsnA4upITwmsP82QdcRvcxtRRMKph/nF36LdahkyrwwUVD9EUlrT01bALDtRz38FYRqsR4v2CZ0s07enC3e+e7O11CLhHELVqs/6UXs6bOFgltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014839; c=relaxed/simple;
	bh=L6nRb+P9+mx6LVAvz1thgURTTax3BdFBuzLkkHh4rcQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vxvpi61dsFg3Usdzxn31PJUcH0TorqZBzR1zVwJROced3J5RKHS4nUxDmqUCVp+t/DrVIgzWjbzYlVC3qJF966c+hq7T8WayG0gU2tAk2TbnkdyFoth87di+KO2mOiqpRS4/CNfsbLwp6mW/6juYxmZ+nqJ8LbYZFgNay2qdO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VySP53vzXz6K5qb;
	Mon, 10 Jun 2024 18:15:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 68341140C98;
	Mon, 10 Jun 2024 18:20:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Jun
 2024 11:20:27 +0100
Date: Mon, 10 Jun 2024 11:20:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] cxl/acpi: Restore XOR'd position bits during
 address translation
Message-ID: <20240610112026.00001b13@Huawei.com>
In-Reply-To: <ZmNPaXST5ninEBbx@aschofie-mobl2>
References: <cover.1715192606.git.alison.schofield@intel.com>
	<77d251960a557f23aa6e6e0465e0e42f1d461514.1715192606.git.alison.schofield@intel.com>
	<20240607160114.00006e4d@Huawei.com>
	<ZmNPaXST5ninEBbx@aschofie-mobl2>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 7 Jun 2024 11:20:25 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Fri, Jun 07, 2024 at 04:01:14PM +0100, Jonathan Cameron wrote:
> > On Wed,  8 May 2024 11:47:51 -0700
> > alison.schofield@intel.com wrote:
> >   
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > When a CXL region is created in a CXL Window (CFMWS) that uses XOR
> > > interleave arithmetic XOR maps are applied during the HPA->DPA
> > > translation. The XOR function changes the interleave selector
> > > bit (aka position bit) in the HPA thereby varying which host bridge
> > > services an HPA. The purpose is to minimize hot spots thereby
> > > improving performance.
> > > 
> > > When a device reports a DPA in events such as poison, general_media,
> > > and dram, the driver translates that DPA back to an HPA. Presently,
> > > the CXL driver translation only considers the modulo position and
> > > will report the wrong HPA for XOR configured CFMWS's.
> > > 
> > > Add a helper function that restores the XOR'd bits during DPA->HPA
> > > address translation. Plumb a root decoder callback to the new helper
> > > when XOR interleave arithmetic is in use. For MODULO arithmetic, just
> > > let the callback be NULL - as in no extra work required.
> > > 
> > > Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>  
> > Trivial comment inline.   Agree entirely that some tests would be good.
> > I ran through a few trivial cases on a bit of paper and it looks to
> > me like it works but that hardly counts as testing :)  
> 
> Thanks for the review and for doing some calcs.
> 
> I've become very adept at working these out with paper/pencil, that hop
> to C implementation is the challenge ;)
> 
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Hmm...well, let me know if I can keep that after you read below...

Meh. I don't care that much.  Just made me thing a tiny bit more
than I like to ;)   Fine with or without the change you suggest.

Jonathan

> 
> >   
> > > ---
> > >  drivers/cxl/acpi.c        | 48 ++++++++++++++++++++++++++++++++++++---
> > >  drivers/cxl/core/port.c   |  5 +++-
> > >  drivers/cxl/core/region.c |  5 ++++
> > >  drivers/cxl/cxl.h         |  6 ++++-
> > >  4 files changed, 59 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index 571069863c62..20488e7b09ac 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -74,6 +74,43 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> > >  	return cxlrd->cxlsd.target[n];
> > >  }
> > >  
> > > +static u64 cxl_xor_translate(struct cxl_root_decoder *cxlrd, u64 hpa)
> > > +{
> > > +	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> > > +	int hbiw = cxlrd->cxlsd.nr_targets;
> > > +	u64 val;
> > > +	int pos;
> > > +
> > > +	/* No xormaps for host bridge interleave ways of 1 or 3 */
> > > +	if (hbiw == 1 || hbiw == 3)
> > > +		return hpa;
> > > +
> > > +	/*
> > > +	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
> > > +	 * the position bit to its value before the xormap was applied at
> > > +	 * HPA->DPA translation.
> > > +	 *
> > > +	 * pos is the lowest set bit in an XORMAP
> > > +	 * val is the XORALLBITS(HPA & XORMAP)
> > > +	 *
> > > +	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
> > > +	 * as an operation that outputs a single bit by XORing all the
> > > +	 * bits in the input (hpa & xormap). Implement XORALLBITS using
> > > +	 * hweight64(). If the hamming weight is even the XOR of those
> > > +	 * bits results in 0, if odd the XOR result is 1.
> > > +	 */
> > > +
> > > +	for (int i = 0; i < cximsd->nr_maps; i++) {
> > > +		if (!cximsd->xormaps[i])
> > > +			continue;
> > > +		pos = __ffs(cximsd->xormaps[i]);  
> > 
> > At the moment the comment on XORALLBITS isn't associated with this
> > code very well. I'd factor it out as cxl_xorallbits() mostly so
> > you can stick the comment next to the bit that does the work.
> > Or maybe a #define XORALLBITS(hpa, xormap)  is good enough if
> > you move it up under the comment.
> >   
> > > +		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
> > > +		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
> > > +	}
> > > +
> > > +	return hpa;
> > > +}
> > > +  
> 
> You haven't convinced me that readers will not be able to associate
> the block comment directly above the for-loop with the work inside
> the for-loop. Especially since this is a 25 line function with a
> single focus.
> 
> I intentionally didn't insert line-by-line commentary in the
> for loop, but rather told the story in the comment and then
> just did it. 
> 
> Maybe repeating 'val' here, wraps up the comment better:
> 
> -        * bits results in 0, if odd the XOR result is 1.
> +        * bits results in val==0, if odd the XOR results in val==1.
> 
> -- Alison
> 
> 
> 
> 
> 
> 
> 
> 
> 
> > 
> >   
> 

