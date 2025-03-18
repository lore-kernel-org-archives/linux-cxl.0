Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613CB190059
	for <linux-cxl@vger.kernel.org>; Tue, 18 Mar 2025 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267309; cv=none; b=rTh6uDNnAACjhPa2jWz7cUHs+/gFV7NYfxc35LcIkkm4Bi3g0zEYKyJQr4J5c3dh9gIN+MenTYrqxxi1rCTLMNtbbCrNSUXZFUsoMeH9QKhuA7VF/R3FxMXmUMTddFUTJsCtwiNVQCaM/0WPzRbG47ij9JiM/oVVSnlL2aZfVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267309; c=relaxed/simple;
	bh=Dw6S7S52G3ZDoXdOVfRFcW+kfnjTlmEREWykvWpZwHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY9/f1BCcIupjSSZSKFVT84TZvhIre2ItMRGC7sItpD3dQEIHdsK5G1sE3YKVaAp/Xr8n/cet4BDz3y0Fmc7NKfS0eCFZ1NHtuKZ/QaPTmlWJZXpOIrNtAYrQMdlGjx3wPl6Ad1wjNzmw49mZHVATO2TyWhaCtpQ1MWxpTapiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U650Wet6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U650Wet6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742267307; x=1773803307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dw6S7S52G3ZDoXdOVfRFcW+kfnjTlmEREWykvWpZwHQ=;
  b=U650Wet65jMxoetQLTVhi50XAPfOwJxGUsRp5r3N1lF4HPOaQFD4s+3j
   JSn0zoV1TChOgKMhR34IuGMmnkWofuzIljAz2YSKVM4cG3LxXN9vGQbnu
   g6FQqv2evXXv+Xk64QHMef4RancbsiHUbvPlVgmEwODsm4JUvIExiOaX3
   12XK+2C1avlgi4DYNPa8QYCrUCCeDqrAA15NZZsf0ETs2AK6e7kqtpNr5
   VDZEDqpXsYT0g7xCshFTdkQhU0QdRD0QhdUCC9MazGrmmzcVbENzgoPBb
   DefS5ULgKRBkgiAad4Qd9Z0YoYh+ot/YaKMUPIEbf6xBF9QbJzgPG0H2x
   w==;
X-CSE-ConnectionGUID: KL2r/ALFSmKgbT6F+ojgBQ==
X-CSE-MsgGUID: rpVG5yIDT7iEBvCpnY1mOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43578878"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="43578878"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:08:26 -0700
X-CSE-ConnectionGUID: mufbdTy5TN28CvlW/HBJ6w==
X-CSE-MsgGUID: QJK/d4+TSceQ7fs/ToYYvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="126779324"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.156])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:08:26 -0700
Date: Mon, 17 Mar 2025 20:08:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
Message-ID: <Z9jjqPopE2IF5VXn@aschofie-mobl2.lan>
References: <20250306232239.2609017-1-alison.schofield@intel.com>
 <20250314120036.000034a9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314120036.000034a9@huawei.com>

On Fri, Mar 14, 2025 at 12:00:36PM +0000, Jonathan Cameron wrote:
> On Thu,  6 Mar 2025 15:22:37 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The CXL driver requires the granularity of a region and its root
> > decoder to be the same. This is particularly restrictive for 3-way
> > host bridge interleaves where the only spec defined interleave
> > configurations for creating 6-way and 12-way regions on a 3-way HB
> > interleave require mixed granularities.
> > 
> > CXL 3.2 Specification 9.13.1.1:
> > Legal Interleaving Configurations: 12-way, 6-way, and 3-way
> 
> Ah this is finally a valid reason to do coarser interleave first
> (going away from host). That was subject of long discussions way back
> when original interleaving code was discussed (mostly because
> my mental model did it that way around and I couldn't follow what
> the kernel code was doing).
> 
> We 'could' revisit allowing this more generally - at least for
> already configured set ups.  Only real reason for that is
> either that someone ships a config that does it for a different
> case, or that we want to avoid special casing 3*x cases.

Hi Jonathan,

I'll bring these configs up as an OPEN at the upcoming community collab,
and hope you can elaborate more there.

--Alison


> 
> Jonathan
