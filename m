Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C547381AD
	for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108164; cv=none; b=Bf8gQCstANfXm9GIitCbYfAHZz+kQj1Q5hLA7MF1lREztKtzurqv7RwcHjvrMPkyD13n9qvUJop8v1Jj2QtpF08ovS7lLuMjUQI9D10yGa8vFbm2TwR6LPQIM+YE1p9X0lXn1i2lV8UcRWARuxz1trnH1rT7Kk+KVfduVc60Mdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108164; c=relaxed/simple;
	bh=nMF6HDuRetpi5J9QIqw/fhQ/q+YBf5UJuEQevZtoYNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAjwAODGfvQwczcYWeMBzijQUToXDXTMPP/U1UJNUCGHhzjqb17+bmfiap8HkM1NC3+sMaGDAXA7NIqt3HZze1dZYOgRA7/OcFAL9PdOiTJxOpSwkHGyiJxSJL/GL+lFhXKVRv8OGE1E8qR3Zf6V6ZdzSPPuZkJPuLoA43omzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9ixB6V4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9ixB6V4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717108163; x=1748644163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nMF6HDuRetpi5J9QIqw/fhQ/q+YBf5UJuEQevZtoYNA=;
  b=k9ixB6V4tmaULB2F9s6H97S85EDVG4JPlI5iARegDwwQdFOGdPr+7RgK
   P5fiiqLkd4M90rgPVDY92x1kLJQBAxq3YDgKAUG+tcnVpURFqnLk82cBB
   L5pOJgEqZqC2fUIvRmUfrMa6onC84a4lGEtffwToc1Vra2zHdMypKKfr7
   HKhlGNsVV8Y32duXazkr5Zwn098FK2lBKviZNQ5ULn/4c2PACRjLMqz2g
   H03BJVZ66GLSxv3ANsI6OpPgh/I/aBfcF2nishJ9K+e/Jx+yunhNHvibS
   hq2i1iq3Jivcc696kzGnlWFwUmcDVY1fjLbWQcE/VJu0rONcmf91OS0DZ
   A==;
X-CSE-ConnectionGUID: T4IH2ou3SbqPET6Zkc2+gA==
X-CSE-MsgGUID: YRNwqItISoyA+PbG+CfcQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24755274"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24755274"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 15:29:22 -0700
X-CSE-ConnectionGUID: YDlkTQ4YSASFs2uL4W9mBw==
X-CSE-MsgGUID: fulaqqpxQxudQLM73LcrkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40884867"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.212.83])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 15:29:22 -0700
Date: Thu, 30 May 2024 15:29:20 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/4] cxl/acpi: Restore XOR'd position bits during
 address translation
Message-ID: <Zlj9wBHEXpF8M/xD@aschofie-mobl2>
References: <cover.1715192606.git.alison.schofield@intel.com>
 <77d251960a557f23aa6e6e0465e0e42f1d461514.1715192606.git.alison.schofield@intel.com>
 <6657f8b2d218e_6ec32943d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6657f8b2d218e_6ec32943d@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Wed, May 29, 2024 at 08:55:30PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a CXL region is created in a CXL Window (CFMWS) that uses XOR
> > interleave arithmetic XOR maps are applied during the HPA->DPA
> > translation. The XOR function changes the interleave selector
> > bit (aka position bit) in the HPA thereby varying which host bridge
> > services an HPA. The purpose is to minimize hot spots thereby
> > improving performance.
> 
> I think it is important to either detail how "interleave hot spots"
> arise, or just omit that description since it is ultimately not relevant
> to Linux.  I.e. the "why XOR" question is irrelevant compared to "what
> happens to a end user with a kernel that does not comprehend XOR
> interleave maths".

I think I understand. Long ago we decided to add XOR Math support to
the CXL Driver. The point now is to do it correctly not rejustify it's
existence.

I'll chop 'The purpose...'

> 
> > When a device reports a DPA in events such as poison, general_media,
> > and dram, the driver translates that DPA back to an HPA. Presently,
> > the CXL driver translation only considers the modulo position and
> > will report the wrong HPA for XOR configured CFMWS's.
> > 
> > Add a helper function that restores the XOR'd bits during DPA->HPA
> > address translation. Plumb a root decoder callback to the new helper
> > when XOR interleave arithmetic is in use. For MODULO arithmetic, just
> > let the callback be NULL - as in no extra work required.
> 
> Perhaps add a handful of sentences about the testing for this patch to
> make sure the maths are now correct compared to what was there before?
> 

There was nothing there before, but I think I know what you mean.
More on that below...

> > 
> > Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---

snip

> > +
> > +	for (int i = 0; i < cximsd->nr_maps; i++) {
> > +		if (!cximsd->xormaps[i])
> > +			continue;
> > +		pos = __ffs(cximsd->xormaps[i]);
> > +		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
> > +		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
> > +	}
> 
> This looks correct to me, but so did the original broken implementation.
> I would feel better about a self test either integrated into
> tools/testing/cxl/, or documented / referenced in the CXL Device Driver
> Writer's Guide that gives confidence that "This is the way".

Let me see about adding a unit test to the cxl suite that exercises the
translation path using data from the sample XOR translation tables that are
currently being added to the CXL Driver Writer's Guide. That would allow the
test to verify against a known set of DPA->HPA offsets for a given XOR region
config. 

-- Alison

