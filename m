Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7451CCB20;
	Mon, 25 Nov 2024 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574697; cv=none; b=lzKFcHoy9xNQY+VoRrAosXl0/gMEC5pTxlI/ldeu7UG5zopOV13XD+9Sse/nJN42PYKPK+eJXtENUm4UeWsDRoIYqcN1TBpXpa0sB/aMKDqY9KpfB9YBjjouRjvMzvlZ8u63DZ3nSHbVyTcFZkZJaL9VuZTn2wCwIQTdzaV1ZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574697; c=relaxed/simple;
	bh=d8JoIYRFa+uafz3y0UPrSTAu9B61sL4LmbhvzjrD0js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8eRnTtXCAyKiErpWTIy9iVDPyaU+FqiEZ70kYtfGcWLl/lTF+3sfB2GDBcWFdEsYlh1HgKvX252gPNhJwhN+FAvf3ZgOpuzArtQXFXD39RI8YWV/mCJLltT+vSuLK/pjPgdO+RK9GcQIwJepox7/yttYCcM0/WNwQ/GVpSs+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNmoRtjE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNmoRtjE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732574697; x=1764110697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d8JoIYRFa+uafz3y0UPrSTAu9B61sL4LmbhvzjrD0js=;
  b=gNmoRtjENMPNJoWg4H++MTOIYfXAk8BcFe5JtxGmBI7juLxTVKpxdU08
   4r8Zjzuc9CUwckUl9KXcelfEDYEP7eMjiDJWIau/kW94Yx/3dxjZtED2e
   gzCjA9qLl2qYpbouUqhJpSXin51jYnkfqXAGWBL3E0FpI1agds6CUbBbS
   Du2E00KxCTgaBTcAF5efwH32SrUnkykBdHLbIAibcE73GDTpS3qbCC0vN
   hjttdeL5lqu+YujQnkIF65qrQMzVpnh2k7EamH8vfIDaNHa+iSYI5Wn4/
   YcQjLZgLFzP9MpPcA3y3k3CU6VGs4Pk7IoS5zOShkwUastUkMabyBcyYE
   g==;
X-CSE-ConnectionGUID: AcNJGzfPRkqUoMmnGtJBqQ==
X-CSE-MsgGUID: vYQPJ4SnSNerT6EUgnTR5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="44088946"
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="44088946"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 14:44:56 -0800
X-CSE-ConnectionGUID: J8RwqPJwRyGTiZOlX3I/3w==
X-CSE-MsgGUID: 1acq6WeeQyiJja+316KjSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,184,1728975600"; 
   d="scan'208";a="122374672"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Nov 2024 14:44:52 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFhp3-0006rx-28;
	Mon, 25 Nov 2024 22:44:49 +0000
Date: Tue, 26 Nov 2024 06:44:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
Message-ID: <202411260633.Oq6ps76M-lkp@intel.com>
References: <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>

Hi Fabio,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master cxl/pending v6.12 next-20241125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/cxl-core-Change-match_-_by_range-calling-convention/20241125-102754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20241122155226.2068287-3-fabio.m.de.francesco%40linux.intel.com
patch subject: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low Memory Hole
config: i386-buildonly-randconfig-001-20241125 (https://download.01.org/0day-ci/archive/20241126/202411260633.Oq6ps76M-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241126/202411260633.Oq6ps76M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411260633.Oq6ps76M-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/cxl/core/pmem.o: in function `arch_match_spa':
>> drivers/cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/cxl/core/pmem.o: in function `arch_match_region':
>> drivers/cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/cxl/core/pmem.o: in function `arch_trim_hpa_by_spa':
>> drivers/cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here
   ld: drivers/cxl/core/regs.o: in function `arch_match_spa':
>> drivers/cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/cxl/core/regs.o: in function `arch_match_region':
>> drivers/cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/cxl/core/regs.o: in function `arch_trim_hpa_by_spa':
>> drivers/cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here
   ld: drivers/cxl/core/memdev.o: in function `arch_match_spa':
>> drivers/cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/cxl/core/memdev.o: in function `arch_match_region':
>> drivers/cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/cxl/core/memdev.o: in function `arch_trim_hpa_by_spa':
>> drivers/cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here
   ld: drivers/cxl/core/mbox.o: in function `arch_match_spa':
>> drivers/cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/cxl/core/mbox.o: in function `arch_match_region':
>> drivers/cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/cxl/core/mbox.o: in function `arch_trim_hpa_by_spa':
>> drivers/cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here
   ld: drivers/cxl/core/pci.o: in function `arch_match_spa':
>> drivers/cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/cxl/core/pci.o: in function `arch_match_region':
>> drivers/cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/cxl/core/pci.o: in function `arch_trim_hpa_by_spa':
>> drivers/cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here
   ld: drivers/cxl/core/hdm.o: in function `arch_match_spa':
>> drivers/cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/cxl/core/hdm.o: in function `arch_match_region':
>> drivers/cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/cxl/core/hdm.o: in function `arch_trim_hpa_by_spa':
>> drivers/cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here
   ld: drivers/cxl/core/pmu.o: in function `arch_match_spa':
>> drivers/cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/cxl/core/pmu.o: in function `arch_match_region':
>> drivers/cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/cxl/core/pmu.o: in function `arch_trim_hpa_by_spa':
   drivers/cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here
   ld: drivers/cxl/core/cdat.o: in function `arch_match_spa':
   drivers/cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/cxl/core/cdat.o: in function `arch_match_region':
   drivers/cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/cxl/core/cdat.o: in function `arch_trim_hpa_by_spa':
   drivers/cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here
   ld: drivers/cxl/core/trace.o: in function `arch_match_spa':
   drivers/cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/cxl/core/trace.o: in function `arch_match_region':
   drivers/cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/cxl/core/trace.o: in function `arch_trim_hpa_by_spa':
   drivers/cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here
   ld: drivers/cxl/port.o: in function `arch_match_spa':
   drivers/cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/cxl/port.o: in function `arch_match_region':
   drivers/cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/cxl/port.o: in function `arch_trim_hpa_by_spa':
   drivers/cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here
   ld: drivers/perf/cxl_pmu.o: in function `arch_match_spa':
   drivers/perf/../cxl/cxl.h:923: multiple definition of `arch_match_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:923: first defined here
   ld: drivers/perf/cxl_pmu.o: in function `arch_match_region':
   drivers/perf/../cxl/cxl.h:927: multiple definition of `arch_match_region'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:927: first defined here
   ld: drivers/perf/cxl_pmu.o: in function `arch_trim_hpa_by_spa':
   drivers/perf/../cxl/cxl.h:935: multiple definition of `arch_trim_hpa_by_spa'; drivers/cxl/core/port.o:drivers/cxl/cxl.h:935: first defined here

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +923 drivers/cxl/cxl.h

   912	
   913	#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
   914	bool arch_match_spa(struct cxl_root_decoder *cxlrd,
   915			    struct cxl_endpoint_decoder *cxled);
   916	bool arch_match_region(struct cxl_region_params *p,
   917			       struct cxl_decoder *cxld);
   918	void arch_trim_hpa_by_spa(struct resource *res,
   919				  struct cxl_root_decoder *cxlrd);
   920	#else
   921	bool arch_match_spa(struct cxl_root_decoder *cxlrd,
   922			    struct cxl_endpoint_decoder *cxled)
 > 923	{
   924		return false;
   925	}
   926	
 > 927	bool arch_match_region(struct cxl_region_params *p,
   928			       struct cxl_decoder *cxld)
   929	{
   930		return false;
   931	}
   932	
   933	void arch_trim_hpa_by_spa(struct resource *res,
   934				  struct cxl_root_decoder *cxlrd)
 > 935	{ }
   936	#endif /* CXL_ARCH_LOW_MEMORY_HOLE */
   937	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
