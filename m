Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE50D17991;
	Thu, 20 Mar 2025 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435179; cv=none; b=aEyfXy53XQaCjpB9MAabhGeXxlvPnNnirgwbYNTpM1+kzL5HB66V/JaD9wL0qXoPZsbsOOHUcuvmkIpBFJ9Gd4RsII83EDJ0RkHH96PN9sZlLZ/XWYb/+Oxp308SJeusL2zPQxSdupURw5+W/jtNAbzztLMxekqjzZ1PQtF3Gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435179; c=relaxed/simple;
	bh=SvcwQS4Iw/lWUXoRVbyZKH9s2y37xApp15yT3jr2J0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzEureImmr2nj1Xk2t9pZYxUU+KVgYCfrC4KCZBdhzG9QACct17mx1mgzJ1koGRMiC3KUOGwU6eDGXtY84oz323/poZApX40zc5SquQOJoUJL/YrvzXCdWdmS/nY6SSw5IB0/UIh2mY7R1wCATgM/eeP01QRqmqJWRDSVy7bY2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfOUSRdy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfOUSRdy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742435177; x=1773971177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SvcwQS4Iw/lWUXoRVbyZKH9s2y37xApp15yT3jr2J0E=;
  b=SfOUSRdy2HM0a8qCwPUlaGQfcF3Ge667Q9JgkddO2Vkha/UoNRxqz6I9
   1+PsGF31gSQKRMTvFlDmOwuPlIO+jZJBF3QWwdm/vjIy57tKat5D0djkJ
   MBn2+w7Ah1Cm3a9/sHwFb4sp1+J4gqGSYG3qH4EXTaexHwm6dPT7apIoI
   1Ul//9zfk5fn7QYdZxR6uaaYFCxiPr8p+cuP0vthBL3NZu+eGXcZi4EoB
   I3zO1zTQVVoxe2dPWVNYwF+Vs/bhTEmQe+LIBuwSHjUEzMdR1YIIa5va8
   xrZPvVBUIxjgRXEOwXP+XwO99s+tTIb/7OAlNde5TbC4n3cDJfSeV8wqT
   w==;
X-CSE-ConnectionGUID: 0x9a8GO3RlyRgoOo21+sbQ==
X-CSE-MsgGUID: DjXREx82SL6nDQSFiUlMAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="47425326"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="47425326"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 18:46:17 -0700
X-CSE-ConnectionGUID: eHHtwSwSQRyIPckfsL7QyQ==
X-CSE-MsgGUID: /sKVIWVWR4yXttnHRf7jwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="123394916"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.43])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 18:46:16 -0700
Date: Wed, 19 Mar 2025 18:46:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Robert Richter <rrichter@amd.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low
 Mem Hole
Message-ID: <Z9tzZkn1rqd2Uk_6@aschofie-mobl2.lan>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>

On Fri, Mar 14, 2025 at 12:36:29PM +0100, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. On those systems, BIOS
> publishes CFMWS which communicate the active System Physical Address (SPA)
> ranges that map to a subset of the Host Physical Address (HPA) ranges. The
> SPA range trims out the hole, and capacity in the endpoint is lost with no
> SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, the driver fails and returns an error because it
> expects that the CXL Endpoint Decoder range is a subset of the Root
> Decoder's (SPA >= HPA). On x86 with LMH's, it happens that SPA < HPA.
> 
> Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
> Decoders or already made CXL Regions and Decoders to allow the
> construction of new CXL Regions and the attachment of Endpoint Decoders,
> even if SPA < HPA. If needed because of LMH's, adjust the Endpoint Decoder
> range end to match Root Decoder's.

I think the dpa_res field of the endpoint decoder needs adjusting.
After the region is setup, the cxled->dpa_res has the unadjusted value
and that leads to region warning and address translation failure because
the driver 'thinks' that DPA is within a region, but when it tries
to translate to an HPA in that region, it fails.

Here's where I looked at it: using the cxl-test LMH auto-region (nice!)
each endpoint decoder is programmed to contribute 512MB to the 1024MB region.
The LMH adjustment shrunk the region to 768MB, so each endpoint is only
contributing 384MB to the region. 

DPA->HPA address translations of DPA addresses in the 384->512 gap cause
a problem. The driver will needlessly warn that they are in a region for
any poison inject or clear, and will fail address translations for any
poison, general media or dram event.

I think this should fail in region.c: __cxl_dpa_to_region()
        if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
                return 0;

For that to fail, LMH code needs to adjust cxled->dpa_res too. 


To test is using clear_poison you can:
# echo 536866816 > /sys/kernel/debug/cxl/mem1/clear_poison
  (536866816 = 512MB - 4096)

[ ] cxl_core:__cxl_dpa_to_region:2860: cxl decoder18.0: dpa:0x1ffff000 mapped in region:region0
[ ] cxl_core:cxl_dpa_to_hpa:2963: cxl_region region0: Addr trans fail: hpa 0x3ff04fffe000 not in region


snip
> 
