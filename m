Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B9274FF9;
	Fri, 10 Oct 2025 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081950; cv=none; b=g6iwt7LiL9bclb9LKcxMGBI0MXsJZzXP9bHLcXY4AxQlIVbwiiZDLEpT4/zlWtpojon4L1U+BqkNWoCAX0ens0/kRIJ54P6Mv2i5Auk8C8Ot1sKOSmBC6XPVIQKCWaNOXejxlgph+pX+UsmO4fkA3Bl4l83Y92tUicInXfd9Mhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081950; c=relaxed/simple;
	bh=t5IJJx4kPbbwg7ljX2+w4hVtPwBcGYi2Buk9ChSRlgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZVP5kX/CLgFAEEcx3b2R6LWEDhjxjXAmyG5C+7uPbLCAi5yC7eGmnBKzRBPdvBDDcjnQBWPd2rEg+B9/5Lemhtft3qc1s5t6PcNLlN2+DnafyF91L/uzB2UVaGthWxW4dvW5daBM//DQgcnRwdgv6XktKF9lx670qMtRi4f9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cp8Atrw/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cp8Atrw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760081949; x=1791617949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t5IJJx4kPbbwg7ljX2+w4hVtPwBcGYi2Buk9ChSRlgw=;
  b=Cp8Atrw/RHIRUNq3r83MhZH2agOxw+T4B8UF+eLDYJMFPI3scqHeyuK8
   kwrXBLivhWT+myhRGhDu86Xd0ZRvcHx24mEZnFp0JmXZdC/S35/uyta+e
   BYC//amO2enuDcpC6+vPByCBZEe44YpBWZh7SoYrZbkVmiipXQnHCSJG3
   sV9wB8SgtEUCTkoYu5lE0QYkGDvrK0I5SjdR40Mbz6xFmoiHneBatMtCf
   oucdT07SX/RKfbc/R9zheA4gLrDhHqZofD5z/8pA+oi1Jd2EjgP4p2Pbg
   FJ2ZrYJvef24Omfbeol0x0qTzyYGUfxPParBUWVZ5NZuxkxO1imXBpdPQ
   Q==;
X-CSE-ConnectionGUID: F16H7FLjSyeFnL1STn8how==
X-CSE-MsgGUID: YIHPHj9ARPWu4fAlyWel6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="61330667"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="61330667"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:39:08 -0700
X-CSE-ConnectionGUID: Rqx7rlU1ShC+slAvdV4afg==
X-CSE-MsgGUID: 4EPbltHWSIaL7RyweUdzsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="184951573"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Oct 2025 00:39:05 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v77iQ-0002Q7-0S;
	Fri, 10 Oct 2025 07:39:02 +0000
Date: Fri, 10 Oct 2025 15:38:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-cxl@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Davidlohr Bueso <dave@stgolabs.net>,
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
Message-ID: <202510101555.zofjGvZF-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 46037455cbb748c5e85071c95f2244e81986eb58]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/cxl-core-Change-match_-_by_range-signatures/20251010-111627
base:   46037455cbb748c5e85071c95f2244e81986eb58
patch link:    https://lore.kernel.org/r/20251006155836.791418-3-fabio.m.de.francesco%40linux.intel.com
patch subject: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes on x86
config: i386-buildonly-randconfig-005-20251010 (https://download.01.org/0day-ci/archive/20251010/202510101555.zofjGvZF-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510101555.zofjGvZF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510101555.zofjGvZF-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/cxl/core/platform_quirks.o: in function `platform_res_adjust':
>> drivers/cxl/core/platform_quirks.c:95:(.text+0x1f1): undefined reference to `__udivdi3'


vim +95 drivers/cxl/core/platform_quirks.c

    76	
    77	void platform_res_adjust(struct resource *res,
    78				 struct cxl_endpoint_decoder *cxled,
    79				 const struct cxl_root_decoder *cxlrd)
    80	{
    81		if (!platform_cxlrd_matches_cxled(cxlrd, cxled))
    82			return;
    83	
    84		guard(rwsem_write)(&cxl_rwsem.dpa);
    85		dev_dbg(cxled_to_memdev(cxled)->dev.parent,
    86			"Low Memory Hole detected. Resources were (%s: %pr, %pr)\n",
    87			dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
    88		if (res) {
    89			/* Trim region resource overlap with LMH */
    90			res->end = cxlrd->res->end;
    91		}
    92		/* Match endpoint decoder's DPA resource to root decoder's */
    93		cxled->dpa_res->end =
    94			cxled->dpa_res->start +
  > 95			resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
