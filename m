Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9379526E703;
	Wed, 19 Nov 2025 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544871; cv=none; b=dJGkRl8COcoBpQSIxlv3p+M4fvQ2Jvxo4AIxAJDZFNVrhL/xIoRhFQ8xc/HaehyfY0zYA6/GmSyHolKiZyGYfXAaZDTk8DsEvJR/fh6SCvMRicBOTgMBXQCYnxrKdbPCdwyuF3hMB8Y31ssEjtqoF8K/svrtnJBXtqpKEM7Dlmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544871; c=relaxed/simple;
	bh=rt1dK5mUjJCU+oDDyz7ttJ0ljVGuDFtw09KBx+xqZ0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqZN8fbKUciSoNJHrbjTtxtnIdXaFRbkOBqqOR7Urjneo9tvipS5zC7+w4IGQGypB4Ve4ovFNFVrlf/Z4LskqoXZDHGgXh8aoO/DxvCserwdMGz+JJoYYQU8oG+2FDlcDF9KfM9MbCptLxdsn2KyXmHuyRghyEkURUJjSimATS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqmNHyZL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqmNHyZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763544869; x=1795080869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rt1dK5mUjJCU+oDDyz7ttJ0ljVGuDFtw09KBx+xqZ0M=;
  b=bqmNHyZLGWuv2dWXr8j/UAqvT0ZRToi1gOS8/nu1C4X2Qt3s3DvoRLwb
   RGxkF8mmKDxpd7MR1pzyU1cAHbDbGBukjmZnhd1VFu8QDt4Hd5XX7uEd+
   d1FLhg+qu8oomTxCR9RX6IzstCLlJZB3/CdbhuNqBRtzUj+/sxShpi6pm
   +g5NlVVCezBTfei3LjQCRc2N5LGrWh8Fkzy6jXUFsTLRI57zORqgJPdUz
   Jlaow7H0x+mLlIB9OSJhi2w+WhLMInOQ+uy9PCkd5yp3VK59UD2yjM9Mv
   10wNaGudwJ2ZeevqvXM5fn0jZZ0zVnURTi5fDjaKzsbncHakJ4tQJ/fVv
   w==;
X-CSE-ConnectionGUID: cHTebIuSQm2S4P67dlwfYQ==
X-CSE-MsgGUID: YvMJvA9OSg+qr0EQqp3PeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="77038021"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="77038021"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 01:34:29 -0800
X-CSE-ConnectionGUID: NA1UNjAUR0SNiQW3iAbJ3Q==
X-CSE-MsgGUID: jwnvvV7wQUGSssZm4Fikrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190805313"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 Nov 2025 01:34:25 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLeZz-0002fL-0w;
	Wed, 19 Nov 2025 09:34:23 +0000
Date: Wed, 19 Nov 2025 17:33:31 +0800
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
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH 4/4 v6] cxl/test: Simulate an x86 Low Memory Hole for
 tests
Message-ID: <202511191640.3qEkK2oZ-lkp@intel.com>
References: <20251118194321.1773484-5-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118194321.1773484-5-fabio.m.de.francesco@linux.intel.com>

Hi Fabio,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7ec9db66cc552f2f8a6779c16d01a2a01eccedde]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/cxl-core-Change-match_-_by_range-signatures/20251119-034652
base:   7ec9db66cc552f2f8a6779c16d01a2a01eccedde
patch link:    https://lore.kernel.org/r/20251118194321.1773484-5-fabio.m.de.francesco%40linux.intel.com
patch subject: [PATCH 4/4 v6] cxl/test: Simulate an x86 Low Memory Hole for tests
config: powerpc64-randconfig-001-20251119 (https://download.01.org/0day-ci/archive/20251119/202511191640.3qEkK2oZ-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511191640.3qEkK2oZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511191640.3qEkK2oZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/core/region.c:892:9: error: call to undeclared function '__platform_region_matches_cxld'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     892 |         return platform_region_matches_cxld(p, cxld);
         |                ^
   drivers/cxl/core/platform_quirks.h:48:38: note: expanded from macro 'platform_region_matches_cxld'
      48 | #define platform_region_matches_cxld DECLARE_TESTABLE(platform_region_matches_cxld)
         |                                      ^
   drivers/cxl/core/platform_quirks.h:46:29: note: expanded from macro 'DECLARE_TESTABLE'
      46 | #define DECLARE_TESTABLE(x) __##x
         |                             ^
   <scratch space>:63:1: note: expanded from here
      63 | __platform_region_matches_cxld
         | ^
   drivers/cxl/core/region.c:892:9: note: did you mean 'platform_region_matches_cxld'?
   drivers/cxl/core/platform_quirks.h:48:38: note: expanded from macro 'platform_region_matches_cxld'
      48 | #define platform_region_matches_cxld DECLARE_TESTABLE(platform_region_matches_cxld)
         |                                      ^
   drivers/cxl/core/platform_quirks.h:46:29: note: expanded from macro 'DECLARE_TESTABLE'
      46 | #define DECLARE_TESTABLE(x) __##x
         |                             ^
   <scratch space>:63:1: note: expanded from here
      63 | __platform_region_matches_cxld
         | ^
   drivers/cxl/core/platform_quirks.h:31:1: note: 'platform_region_matches_cxld' declared here
      31 | platform_region_matches_cxld(const struct cxl_region_params *p,
         | ^
>> drivers/cxl/core/region.c:1837:7: error: call to undeclared function '__platform_cxlrd_matches_cxled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1837 |                 if (platform_cxlrd_matches_cxled(cxlrd, cxled))
         |                     ^
   drivers/cxl/core/platform_quirks.h:47:38: note: expanded from macro 'platform_cxlrd_matches_cxled'
      47 | #define platform_cxlrd_matches_cxled DECLARE_TESTABLE(platform_cxlrd_matches_cxled)
         |                                      ^
   drivers/cxl/core/platform_quirks.h:46:29: note: expanded from macro 'DECLARE_TESTABLE'
      46 | #define DECLARE_TESTABLE(x) __##x
         |                             ^
   <scratch space>:101:1: note: expanded from here
     101 | __platform_cxlrd_matches_cxled
         | ^
   drivers/cxl/core/region.c:1837:7: note: did you mean 'platform_cxlrd_matches_cxled'?
   drivers/cxl/core/platform_quirks.h:47:38: note: expanded from macro 'platform_cxlrd_matches_cxled'
      47 | #define platform_cxlrd_matches_cxled DECLARE_TESTABLE(platform_cxlrd_matches_cxled)
         |                                      ^
   drivers/cxl/core/platform_quirks.h:46:29: note: expanded from macro 'DECLARE_TESTABLE'
      46 | #define DECLARE_TESTABLE(x) __##x
         |                             ^
   <scratch space>:101:1: note: expanded from here
     101 | __platform_cxlrd_matches_cxled
         | ^
   drivers/cxl/core/platform_quirks.h:24:1: note: 'platform_cxlrd_matches_cxled' declared here
      24 | platform_cxlrd_matches_cxled(const struct cxl_root_decoder *cxlrd,
         | ^
   drivers/cxl/core/region.c:2056:32: error: call to undeclared function '__platform_cxlrd_matches_cxled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2056 |             resource_size(p->res) && !platform_cxlrd_matches_cxled(cxlrd, cxled)) {
         |                                       ^
   drivers/cxl/core/platform_quirks.h:47:38: note: expanded from macro 'platform_cxlrd_matches_cxled'
      47 | #define platform_cxlrd_matches_cxled DECLARE_TESTABLE(platform_cxlrd_matches_cxled)
         |                                      ^
   drivers/cxl/core/platform_quirks.h:46:29: note: expanded from macro 'DECLARE_TESTABLE'
      46 | #define DECLARE_TESTABLE(x) __##x
         |                             ^
   <scratch space>:102:1: note: expanded from here
     102 | __platform_cxlrd_matches_cxled
         | ^
   drivers/cxl/core/region.c:3490:4: error: call to undeclared function '__platform_cxlrd_matches_cxled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3490 |                 (platform_cxlrd_matches_cxled(cxlrd, cxled));
         |                  ^
   drivers/cxl/core/platform_quirks.h:47:38: note: expanded from macro 'platform_cxlrd_matches_cxled'
      47 | #define platform_cxlrd_matches_cxled DECLARE_TESTABLE(platform_cxlrd_matches_cxled)
         |                                      ^
   drivers/cxl/core/platform_quirks.h:46:29: note: expanded from macro 'DECLARE_TESTABLE'
      46 | #define DECLARE_TESTABLE(x) __##x
         |                             ^
   <scratch space>:84:1: note: expanded from here
      84 | __platform_cxlrd_matches_cxled
         | ^
   4 errors generated.


vim +/__platform_region_matches_cxld +892 drivers/cxl/core/region.c

384e624bb211b4 Dan Williams          2022-06-07  872  
c43521b9db7f5e Dave Jiang            2025-11-06  873  static bool spa_maps_hpa(const struct cxl_region_params *p,
0f6f1982cb28ab Dave Jiang            2025-10-10  874  			 const struct range *range)
0ec9849b63338d Dave Jiang            2025-02-26  875  {
7c15a3666e848d Fabio M. De Francesco 2025-11-18  876  	struct cxl_decoder *cxld;
7c15a3666e848d Fabio M. De Francesco 2025-11-18  877  
0ec9849b63338d Dave Jiang            2025-02-26  878  	if (!p->res)
0ec9849b63338d Dave Jiang            2025-02-26  879  		return false;
0ec9849b63338d Dave Jiang            2025-02-26  880  
0ec9849b63338d Dave Jiang            2025-02-26  881  	/*
8d27dd0b219f00 Dave Jiang            2025-11-06  882  	 * The extended linear cache region is constructed by a 1:1 ratio
8d27dd0b219f00 Dave Jiang            2025-11-06  883  	 * where the SPA maps equal amounts of DRAM and CXL HPA capacity with
8d27dd0b219f00 Dave Jiang            2025-11-06  884  	 * CXL decoders at the high end of the SPA range.
0ec9849b63338d Dave Jiang            2025-02-26  885  	 */
7c15a3666e848d Fabio M. De Francesco 2025-11-18  886  	if (p->res->start + p->cache_size == range->start &&
7c15a3666e848d Fabio M. De Francesco 2025-11-18  887  	    p->res->end == range->end)
7c15a3666e848d Fabio M. De Francesco 2025-11-18  888  		return true;
7c15a3666e848d Fabio M. De Francesco 2025-11-18  889  
7c15a3666e848d Fabio M. De Francesco 2025-11-18  890  	cxld = container_of(range, struct cxl_decoder, hpa_range);
7c15a3666e848d Fabio M. De Francesco 2025-11-18  891  
7c15a3666e848d Fabio M. De Francesco 2025-11-18 @892  	return platform_region_matches_cxld(p, cxld);
0ec9849b63338d Dave Jiang            2025-02-26  893  }
0ec9849b63338d Dave Jiang            2025-02-26  894  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
