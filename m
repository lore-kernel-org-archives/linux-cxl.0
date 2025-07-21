Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB123D2A1;
	Mon, 21 Jul 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753131589; cv=none; b=jDUDvgoOPnPh1AhhF7jtnafhdbeA0wFrBTwz5p3WsPxdxegaR5iDQvisRzXigncFYzZT9YxEgIreSRh0bC7aEZA+d5CaFy2qTo7hdljIPAbqRn/oTylKGjgHMBd4ZzgiFWhHVERdpideF0ViuvugwOuRGRMdp5++L90G1vqhMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753131589; c=relaxed/simple;
	bh=3V+Kf0asmOFTtoBgv3kxoSBytJOTwV1imp7ZohhKxCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWjL4C/fFeLSCHv2KrqfOGDr1Ut/eC1Iv6Zh4gQGmPqPm9w1y3x4DFucVzFPLoMyOPD6eu81YbW4lyai3lnwuFQrQwrsQCgGcxWrrjkD1NmuO+F1KmWhQqWh6H27kSxFWqE2oUi2yS2SQr8VX6pFoKjYNvJPFawqDgvRCcI8nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBa52QjI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBa52QjI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753131587; x=1784667587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3V+Kf0asmOFTtoBgv3kxoSBytJOTwV1imp7ZohhKxCo=;
  b=iBa52QjIpyiifZWrnnAxnzBhN7aagbb2Df4+0EApEb+39klDGNBHnl7/
   NabayLplZjx3Uk052+qmbgzGA1+uIEHodfBpZ6IDbMVc7uDhQCHNYQcqQ
   1uWuhcRZi+iO2Zuc/sVNYI/KeJ4pAKqSFt9H13fIyKXPgGS7d1Em56hBv
   p2S4ECOYPFQBiQXByK9V16e+sUM8iotxNdQdvkinN2UsCrWLdVHv3QE3B
   4H44q7Wy2cVR32I97E2mJthtQht/GtHPsZdcHvl0kIM3AXWRJW53MmUwM
   aXuf7ITFMybf3tplWJa4Pr3FODyghOLievfw1zpcBioKrDu1AI9yBl/RH
   w==;
X-CSE-ConnectionGUID: TI/gOpO6QLGiRRkmKVXkTw==
X-CSE-MsgGUID: uwfEFiQDSDW7bOlcNt8zgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55452718"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="55452718"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:59:46 -0700
X-CSE-ConnectionGUID: FKZCQim5RIyVR051uMviWA==
X-CSE-MsgGUID: SPeDBijxQ0OdsYO14t2W9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="162990014"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.247.118.153]) ([10.247.118.153])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:59:39 -0700
Message-ID: <78284b12-3e0b-4758-af18-397f32136c3f@intel.com>
Date: Mon, 21 Jul 2025 13:59:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/20] cxl: Address translation support, part 2: Region
 code rework
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250715191143.1023512-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/25 12:11 PM, Robert Richter wrote:
> This series is the second part of adding support for CXL address
> translation. It adds another rework of region code to address
> implementation changes or conflicts of current address translation
> code with cxl/next, esp. the introduction of support of extended
> linear caching.
> 
> Following parts are currently planned, worked on or finished:
> 
> Part 1: Cleanups and refactoring
> Upstream: 68d8b4f399e7 ("Merge branch 'for-6.16/cxl-cleanups' into cxl-for-next")
> 
> Part 2: Region code rework
> This initial patch series.
> 
> Part 3: Extended linear cache rework
> Not yet posted.
> 
> Part 4: Generic support and AMD Zen5 platform enablement.
> Not yet posted. (Earlier version posted as part 2, v2: Generic support
> and AMD Zen5 platform enablement. [1])

Hi Robert, this is A LOT of refactoring and we are not anywhere near the actual translation implementation. Before we proceed further, can you please send out a documentation patch and describe the ZEN5 translation needs for docs/driver-api/cxl/conventions.rst similar to what Fabio is doing for LMH [1]? Thank you!

[1]: https://lore.kernel.org/linux-cxl/687ea20d2e508_34e0f2941@iweiny-mobl.notmuch/T/#t

DJ

> 
> The general changes in the implementation compared to [1] are in
> particular to use the attached region of an endpoint decoder to host
> the HPA range and interleaving configuration parameters. That is, the
> region's root decoder and HPA range are added as members @cxlrd and
> @hpa_range to struct cxl_region. Both are introduced to keep track of
> the region's SPA address range and the interleaving configuration.
> Those parameters are the same for all endpoint decoders that share the
> same interleaving setup.
> 
> The implementation must ensure that the endpoint decoder's region
> parameters are always valid. All parameters must be determined first
> and then a check must be performed if a region with identical
> parameters already exists. A split of region creation and registration
> is required as the region may not become active and may need to be
> replaced by an already existing region. Several high-level functions
> are introduced (create_region(), setup_region(), register_region(),
> cxl_endpoint_get_region(), cxl_region_find_duplicate()). Most of it is
> implemented in cxl_add_to_region().
> 
> Finally, this series adds a lot of simplification and improves error
> handling and code readability.
> 
> [1] https://lore.kernel.org/all/20250218132356.1809075-1-rrichter@amd.com/
> 
> Robert Richter (20):
>   cxl/region: Move helper functions closer to their users
>   cxl/region: Store root decoder in struct cxl_region
>   cxl/region: Remove region id handling from cxl_region_alloc()
>   cxl/region: Add region registration code to new function
>     register_region()
>   cxl/region: Separate cxl_region_alloc() from devm_cxl_add_region()
>   cxl/region: Remove dev_err() from cxl_find_root_decoder()
>   cxl/region: Add new function cxl_endpoint_get_region() to simplify
>     cxl_add_to_region()
>   cxl/region: Rework memregion id allocation and move it to
>     register_region()
>   cxl/region: Change __construct_region() to use it as a tail function
>     call
>   cxl/region: Remove __construct_region()
>   cxl/region: Separate auto-generated region cration code path
>   cxl/region: Remove region creation code from construct_region()
>   cxl/region: Move devm_cxl_add_region() out of create_region()
>   cxl/region: Prepare removal of @cxlrd argument from create_region()
>   cxl/region: Prepare removal of @cxled argument from construct_region()
>   cxl/region: Introduce @hpa_range to struct cxl_region
>   cxl/region: Remove create_region() call from construct_region()
>   cxl/region: Determine root decoder in create_region()
>   cxl/region: Add function to find a region's duplicate
>   cxl/region: Early check region's interleaving configuration
> 
>  drivers/cxl/core/region.c | 514 +++++++++++++++++++++++---------------
>  drivers/cxl/cxl.h         |   4 +
>  2 files changed, 315 insertions(+), 203 deletions(-)
> 
> 
> base-commit: 12b3d697c812aaf356e82d9e1f351fbb2ea97500

