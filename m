Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC51233701
	for <linux-cxl@vger.kernel.org>; Sun, 13 Jul 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752427448; cv=none; b=tKWuOKXZhvBcOeEC9mLxS/dAj03U695SNXaF7f0bW4ZlNkWdiW703s7SFHhvXjH2enCsFxu4ZreDmTMDUcwD0aDR4u3LdPLcfz7HiN1sSVepPKRkOJzqV7VQBHgzutDig6fHWOhZfBsAEHdSegvDWAkbfXQs1VMIPqGqfr6xSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752427448; c=relaxed/simple;
	bh=pfs+nImhmhBVEf2/Gcpm96k5OSZcEdlsYUyiHoci0bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMhhVgv4jpKiPON6BfuOIJ1EdRZdSDKsNwVd/4Lf343ojTj7wNWNSkT7E4WKlm7EEg87I5VsOzwmNfhZGYpd6P7J/9utIUUqJ0e19MsEdHK05xpfLs2tdLmF5sVmRFWaFQi6yP9wGJGrUd5e5bVtN+4CqK095ryuian6HI/g5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMF+pxOb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMF+pxOb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752427445; x=1783963445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pfs+nImhmhBVEf2/Gcpm96k5OSZcEdlsYUyiHoci0bs=;
  b=cMF+pxObYj8b6eFi/BxOeXG0nkE+VUBs813MVwD4IWwfPKp7ktREvkWX
   Y7j9zTAwvKJddJjM+/7G1HAZp3ksenUpK+SukBR5zf9tPEME7qDx1c7c6
   I0KwajP6qj4mEO83x3mhKfYihVhb7jL76lIjk8qytYRl2ORn+ej4XR4L0
   xZ7h48uFfXid3PE3TU/MVeyryL75JbhsA+CWLRymQEW3Hiss+GzuQJJue
   jScYr96K6+leRIx81T6RpBd2UiMGk5gLOjJkUHWWiPdAZWhKu76ZMd12G
   +Y6238lthc0IVfB8azMX/Xj+Vg5R/AS3nU2tKjEmqUiSpmfXud0u6+rsW
   Q==;
X-CSE-ConnectionGUID: q1tlf11ERly4N4vz1QZAHA==
X-CSE-MsgGUID: j+xSuxpORo+RZREQx1vaIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54789802"
X-IronPort-AV: E=Sophos;i="6.16,309,1744095600"; 
   d="scan'208";a="54789802"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 10:24:04 -0700
X-CSE-ConnectionGUID: Ms1W6BCMRn6TMBkZFsGVXQ==
X-CSE-MsgGUID: Q0oIzrCxQDGqxo6tj/qEpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,309,1744095600"; 
   d="scan'208";a="156181116"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Jul 2025 10:24:02 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ub0Qh-0008Df-1b;
	Sun, 13 Jul 2025 17:23:59 +0000
Date: Mon, 14 Jul 2025 01:23:27 +0800
From: kernel test robot <lkp@intel.com>
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 4/4] cxl/region: Add inject and clear poison by region
 offset
Message-ID: <202507140133.Qi2pYjES-lkp@intel.com>
References: <612f019902bfb63ab22d7c4cf0f2f52fbc3ba5b8.1752365427.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612f019902bfb63ab22d7c4cf0f2f52fbc3ba5b8.1752365427.git.alison.schofield@intel.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6c90a41a7833a6bb2fb17b9f3cafda66ebdf259b]

url:    https://github.com/intel-lab-lkp/linux/commits/alison-schofield-intel-com/cxl-Define-a-SPA-CXL-HPA-root-decoder-callback-for-XOR-Math/20250713-104013
base:   6c90a41a7833a6bb2fb17b9f3cafda66ebdf259b
patch link:    https://lore.kernel.org/r/612f019902bfb63ab22d7c4cf0f2f52fbc3ba5b8.1752365427.git.alison.schofield%40intel.com
patch subject: [PATCH v3 4/4] cxl/region: Add inject and clear poison by region offset
config: i386-randconfig-001-20250713 (https://download.01.org/0day-ci/archive/20250714/202507140133.Qi2pYjES-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250714/202507140133.Qi2pYjES-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507140133.Qi2pYjES-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/cxl/core/region.o: in function `region_offset_to_dpa_result':
>> drivers/cxl/core/region.c:3007: undefined reference to `__umoddi3'


vim +3007 drivers/cxl/core/region.c

f7f82c631d48c8 Alison Schofield 2025-07-12  2964  
f15c7deb79e3c8 Alison Schofield 2025-07-12  2965  static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
f7f82c631d48c8 Alison Schofield 2025-07-12  2966  				       struct dpa_result *result)
f7f82c631d48c8 Alison Schofield 2025-07-12  2967  {
f7f82c631d48c8 Alison Schofield 2025-07-12  2968  	struct cxl_region_params *p = &cxlr->params;
f7f82c631d48c8 Alison Schofield 2025-07-12  2969  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
f7f82c631d48c8 Alison Schofield 2025-07-12  2970  	struct cxl_endpoint_decoder *cxled;
f7f82c631d48c8 Alison Schofield 2025-07-12  2971  	u64 hpa, hpa_offset, dpa_offset;
f7f82c631d48c8 Alison Schofield 2025-07-12  2972  	u64 bits_upper, bits_lower;
f7f82c631d48c8 Alison Schofield 2025-07-12  2973  	u16 eig = 0;
f7f82c631d48c8 Alison Schofield 2025-07-12  2974  	u8 eiw = 0;
f7f82c631d48c8 Alison Schofield 2025-07-12  2975  	int pos;
f7f82c631d48c8 Alison Schofield 2025-07-12  2976  
f7f82c631d48c8 Alison Schofield 2025-07-12  2977  	lockdep_assert_held(&cxl_rwsem.region);
f7f82c631d48c8 Alison Schofield 2025-07-12  2978  	lockdep_assert_held(&cxl_rwsem.dpa);
f7f82c631d48c8 Alison Schofield 2025-07-12  2979  
f7f82c631d48c8 Alison Schofield 2025-07-12  2980  	if (granularity_to_eig(p->interleave_granularity, &eig) ||
f7f82c631d48c8 Alison Schofield 2025-07-12  2981  	    ways_to_eiw(p->interleave_ways, &eiw))
f7f82c631d48c8 Alison Schofield 2025-07-12  2982  		return -ENXIO;
f7f82c631d48c8 Alison Schofield 2025-07-12  2983  
f7f82c631d48c8 Alison Schofield 2025-07-12  2984  	/*
f7f82c631d48c8 Alison Schofield 2025-07-12  2985  	 * If the root decoder has SPA to CXL HPA callback, use it. Otherwise
f7f82c631d48c8 Alison Schofield 2025-07-12  2986  	 * CXL HPA is assumed to equal SPA.
f7f82c631d48c8 Alison Schofield 2025-07-12  2987  	 */
f7f82c631d48c8 Alison Schofield 2025-07-12  2988  	if (cxlrd->spa_to_hpa) {
f7f82c631d48c8 Alison Schofield 2025-07-12  2989  		hpa = cxlrd->spa_to_hpa(cxlrd, p->res->start + offset);
f7f82c631d48c8 Alison Schofield 2025-07-12  2990  		hpa_offset = hpa - p->res->start;
f7f82c631d48c8 Alison Schofield 2025-07-12  2991  	} else {
f7f82c631d48c8 Alison Schofield 2025-07-12  2992  		hpa_offset = offset;
f7f82c631d48c8 Alison Schofield 2025-07-12  2993  	}
f7f82c631d48c8 Alison Schofield 2025-07-12  2994  	/*
f7f82c631d48c8 Alison Schofield 2025-07-12  2995  	 * Interleave position: CXL Spec 3.2 Section 8.2.4.20.13
f7f82c631d48c8 Alison Schofield 2025-07-12  2996  	 * eiw < 8
f7f82c631d48c8 Alison Schofield 2025-07-12  2997  	 *	Position is in the IW bits at HPA_OFFSET[IG+8+IW-1:IG+8].
f7f82c631d48c8 Alison Schofield 2025-07-12  2998  	 *	Per spec "remove IW bits starting with bit position IG+8"
f7f82c631d48c8 Alison Schofield 2025-07-12  2999  	 * eiw >= 8
f7f82c631d48c8 Alison Schofield 2025-07-12  3000  	 *	Position is not explicitly stored in HPA_OFFSET bits. It is
f7f82c631d48c8 Alison Schofield 2025-07-12  3001  	 *	derived from the modulo operation of the upper bits using
f7f82c631d48c8 Alison Schofield 2025-07-12  3002  	 *	the total number of interleave ways.
f7f82c631d48c8 Alison Schofield 2025-07-12  3003  	 */
f7f82c631d48c8 Alison Schofield 2025-07-12  3004  	if (eiw < 8)
f7f82c631d48c8 Alison Schofield 2025-07-12  3005  		pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
f7f82c631d48c8 Alison Schofield 2025-07-12  3006  	else
f7f82c631d48c8 Alison Schofield 2025-07-12 @3007  		pos = (hpa_offset >> (eig + 8)) % p->interleave_ways;
f7f82c631d48c8 Alison Schofield 2025-07-12  3008  
f7f82c631d48c8 Alison Schofield 2025-07-12  3009  	if (pos < 0 || pos >= p->nr_targets) {
f7f82c631d48c8 Alison Schofield 2025-07-12  3010  		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
f7f82c631d48c8 Alison Schofield 2025-07-12  3011  			pos, p->nr_targets);
f7f82c631d48c8 Alison Schofield 2025-07-12  3012  		return -ENXIO;
f7f82c631d48c8 Alison Schofield 2025-07-12  3013  	}
f7f82c631d48c8 Alison Schofield 2025-07-12  3014  	/*
f7f82c631d48c8 Alison Schofield 2025-07-12  3015  	 * DPA offset: CXL Spec 3.2 Section 8.2.4.20.13
f7f82c631d48c8 Alison Schofield 2025-07-12  3016  	 * Lower bits [IG+7:0] pass through unchanged
f7f82c631d48c8 Alison Schofield 2025-07-12  3017  	 * (eiw < 8)
f7f82c631d48c8 Alison Schofield 2025-07-12  3018  	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
f7f82c631d48c8 Alison Schofield 2025-07-12  3019  	 *	Clear the position bits to isolate upper section, then
f7f82c631d48c8 Alison Schofield 2025-07-12  3020  	 *	reverse the left shift by eiw that occurred during DPA->HPA
f7f82c631d48c8 Alison Schofield 2025-07-12  3021  	 * (eiw >= 8)
f7f82c631d48c8 Alison Schofield 2025-07-12  3022  	 *	Per spec: DPAOffset[51:IG+8] = HPAOffset[51:IG+IW] / 3
f7f82c631d48c8 Alison Schofield 2025-07-12  3023  	 *	Extract upper bits from the correct bit range and divide by 3
f7f82c631d48c8 Alison Schofield 2025-07-12  3024  	 *	to recover the original DPA upper bits
f7f82c631d48c8 Alison Schofield 2025-07-12  3025  	 */
f7f82c631d48c8 Alison Schofield 2025-07-12  3026  
f7f82c631d48c8 Alison Schofield 2025-07-12  3027  	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
f7f82c631d48c8 Alison Schofield 2025-07-12  3028  	if (eiw < 8) {
f7f82c631d48c8 Alison Schofield 2025-07-12  3029  		hpa_offset &= ~((u64)GENMASK(eiw + eig + 8 - 1, 0));
f7f82c631d48c8 Alison Schofield 2025-07-12  3030  		dpa_offset = hpa_offset >> eiw;
f7f82c631d48c8 Alison Schofield 2025-07-12  3031  	} else {
f7f82c631d48c8 Alison Schofield 2025-07-12  3032  		bits_upper = div64_u64(hpa_offset >> (eig + eiw), 3);
f7f82c631d48c8 Alison Schofield 2025-07-12  3033  		dpa_offset = bits_upper << (eig + 8);
f7f82c631d48c8 Alison Schofield 2025-07-12  3034  	}
f7f82c631d48c8 Alison Schofield 2025-07-12  3035  	dpa_offset |= bits_lower;
f7f82c631d48c8 Alison Schofield 2025-07-12  3036  
f7f82c631d48c8 Alison Schofield 2025-07-12  3037  	/* Look-up and return the result: a memdev and a DPA */
f7f82c631d48c8 Alison Schofield 2025-07-12  3038  	for (int i = 0; i < p->nr_targets; i++) {
f7f82c631d48c8 Alison Schofield 2025-07-12  3039  		cxled = p->targets[i];
f7f82c631d48c8 Alison Schofield 2025-07-12  3040  		if (cxled->pos != pos)
f7f82c631d48c8 Alison Schofield 2025-07-12  3041  			continue;
f7f82c631d48c8 Alison Schofield 2025-07-12  3042  		result->cxlmd = cxled_to_memdev(cxled);
f7f82c631d48c8 Alison Schofield 2025-07-12  3043  		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
f7f82c631d48c8 Alison Schofield 2025-07-12  3044  
f7f82c631d48c8 Alison Schofield 2025-07-12  3045  		return 0;
f7f82c631d48c8 Alison Schofield 2025-07-12  3046  	}
f7f82c631d48c8 Alison Schofield 2025-07-12  3047  	dev_err(&cxlr->dev, "No device found for position %d\n", pos);
f7f82c631d48c8 Alison Schofield 2025-07-12  3048  
f7f82c631d48c8 Alison Schofield 2025-07-12  3049  	return -ENXIO;
f7f82c631d48c8 Alison Schofield 2025-07-12  3050  }
f7f82c631d48c8 Alison Schofield 2025-07-12  3051  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
