Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1B2F6168;
	Fri, 10 Oct 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107797; cv=none; b=BY4v5lDZ02Ybjh515NzCEXkdNd5ZfLRwGa0dV51QusWqR5PNuWOnoG8G8VDolsEtono7fDkjndhjpJX/wTx7/a0bHvTMx5cNnfNRVv3jnwFRYhArwy5zHMiy0QbFupPF5Njmk5mSgYshnp1KAcYnrUAfHFL0d7KLvE3YMRuWw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107797; c=relaxed/simple;
	bh=x/nQh9NYCS7bzE7Ro77DDsqXiiN6FnnyCHeEtoXsDIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thvgGpMjLBU2mipBuz9PZmqZc8gNLGapO4ieQ8eh7mrDNR0UP0ZY7S2AVINxaxM5zDZ/9Sl1u+42QkuM9DVn7cDUiyDijwf03W8ZCbMETw2qIB1WU+4M/Q8f/stqMKcLgouP0OnmuYEUXFJYSH8prSHAcxB4dnz3CjtoxBnhByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPKVPQ46; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPKVPQ46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760107795; x=1791643795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x/nQh9NYCS7bzE7Ro77DDsqXiiN6FnnyCHeEtoXsDIQ=;
  b=JPKVPQ46RAxf7xEEzExmqPPEX3Is7JTG/XjQaShylStJkvNGbBP6XXKX
   ACNtEwcZmRLLi169YzBQCtmLmWz2cFyBxdxQcsTWnzgTMjdNQxlXbk9W0
   zgH+FSo+nFzAKKicIOO3JjNV+qllsx+GXhY9Ynq75l6nDJyloR2Seqh7X
   ZMuPKTg70NEPZwBU+kdCRvwsHqmjPTMWW2UiJG+4y+2cLKlQSUbIfNDOk
   Ew4q7djf+tXYOkQWfsorT06/EFoNfZ3zFeu1OhPqYGGxMkTUrvU+jmrp/
   X/BVBPPelYP2XZGNSP3Wos0KwE+xNpLjK1VJR2dnokJ63i0L12syRDUTl
   A==;
X-CSE-ConnectionGUID: lzwbFXUmTt+X9pBpqhisQg==
X-CSE-MsgGUID: nc7LRjxWQoak9Ot+wQjYiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="65980807"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="65980807"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 07:49:54 -0700
X-CSE-ConnectionGUID: vv13mbr8Tf+TpG9cjxF5hg==
X-CSE-MsgGUID: Q+xU13TNQUe3N+FGTwfKow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="181011172"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Oct 2025 07:49:50 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7ERH-0002rv-2b;
	Fri, 10 Oct 2025 14:49:47 +0000
Date: Fri, 10 Oct 2025 22:49:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-cxl@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes
 on x86
Message-ID: <202510102229.iFcGqbMH-lkp@intel.com>
References: <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>

Hi Fabio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 46037455cbb748c5e85071c95f2244e81986eb58]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/cxl-core-Change-match_-_by_range-signatures/20251010-111627
base:   46037455cbb748c5e85071c95f2244e81986eb58
patch link:    https://lore.kernel.org/r/20251006155836.791418-3-fabio.m.de.francesco%40linux.intel.com
patch subject: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes on x86
config: i386-randconfig-011-20251010 (https://download.01.org/0day-ci/archive/20251010/202510102229.iFcGqbMH-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510102229.iFcGqbMH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510102229.iFcGqbMH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/platform_quirks.c:70:36: warning: result of comparison of constant 4294967296 with expression of type 'const resource_size_t' (aka 'const unsigned int') is always true [-Wtautological-constant-out-of-range-compare]
      70 |             res->end < r->end && res->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
         |                                  ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +70 drivers/cxl/core/platform_quirks.c

    50	
    51	/**
    52	 * platform_region_matches_cxld() - Platform quirk to match a CXL Region and a
    53	 * Switch or Endpoint Decoder. It allows matching on platforms with LMH's.
    54	 * @p: Region Params against which @cxled is matched.
    55	 * @cxld: Switch or Endpoint Decoder to be tested for matching @p.
    56	 *
    57	 * Similar to platform_cxlrd_matches_cxled(), it matches regions and
    58	 * decoders on platforms with LMH's.
    59	 *
    60	 * Return: true if a Decoder matches a Region, else false.
    61	 */
    62	bool platform_region_matches_cxld(const struct cxl_region_params *p,
    63					  const struct cxl_decoder *cxld)
    64	{
    65		const struct range *r = &cxld->hpa_range;
    66		const struct resource *res = p->res;
    67		int align = cxld->interleave_ways * SZ_256M;
    68	
    69		if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
  > 70		    res->end < r->end && res->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
    71		    IS_ALIGNED(range_len(r), align))
    72			return true;
    73	
    74		return false;
    75	}
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
