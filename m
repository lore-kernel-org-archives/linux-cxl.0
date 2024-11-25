Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C2187FFA;
	Mon, 25 Nov 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524140; cv=none; b=kG9TeraWcuJ0LctdJLnAe67xojXMLnh7LDsqEhAoDNQOABn6uiD2Ny0ZDNV/okaQnioD8VrGckmzDlTIxncJkp4W+NIkrNdpzwdwYygT50wHPi59Dmyrk/O8916Iuap/nH+R0fKB5zDX+Yaf6NIE4npg9qX1gYXar7jqJQerN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524140; c=relaxed/simple;
	bh=H8dVvaxAfzgmHdBxZDBeyOpaTmlwiqO6Fj5VB1iEfQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWdWvwCSieIWlhEiGayOhCN5XJQCnDFLIo6VZA7g4qj1UGWop40mdSPAWwlbhYL4Z+XMzh+W+nCAOd2OuDlW9LpbeOL57VkBQKPsV0+UuUr5CBlfhk7inLOvqkTHsowUZNY1BbqxEZlgthvtixApwXjxJ/w1AvOk2Oisu5G+N8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0FfkRAu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0FfkRAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732524139; x=1764060139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H8dVvaxAfzgmHdBxZDBeyOpaTmlwiqO6Fj5VB1iEfQ0=;
  b=e0FfkRAuFyCqpbjDpozikBXc2f10z14cVAHivHjymst502MDdP8t+svK
   Qw9VKXNeaFcu8jcTw284vkOI1zKMOK2Jv4wnBuB7O8ltTE+eOfKAB+wf+
   MtkQwvWQc1aFWZRXT47LKAI+7522uw71dgkGmG+J50pqxeWAPxPkEq8X8
   HSTYmp2Bh8YQ8TiCU5bp+iEDeKSIwAA+WiotnBFhyL1dVWRC2fmJ0m7eR
   Nlc0mSId993r27mfMsKZE301z8Zwf3JZZ5GJXHHghEowm3+HEVnaFcdoh
   QYghQo2Zy4eH6bj8BkL87JJJQZfGoSUUIGc8iMIFGa7/+7PdKblP6md9l
   w==;
X-CSE-ConnectionGUID: 2Rp0JZOGR5Klq/BQiTesew==
X-CSE-MsgGUID: 8dAJvrqwTyaE3dfoGLcR6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="32560324"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32560324"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 00:42:18 -0800
X-CSE-ConnectionGUID: GcAFz0zYRlKfEwYPcw2CTQ==
X-CSE-MsgGUID: 9pFpg5OST8qVHjnhr/EP5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91546181"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Nov 2024 00:42:15 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFUfc-00065N-1l;
	Mon, 25 Nov 2024 08:42:12 +0000
Date: Mon, 25 Nov 2024 16:41:34 +0800
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
Message-ID: <202411251632.4eenIlnF-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on cxl/next]
[also build test WARNING on linus/master cxl/pending v6.12 next-20241125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/cxl-core-Change-match_-_by_range-calling-convention/20241125-102754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20241122155226.2068287-3-fabio.m.de.francesco%40linux.intel.com
patch subject: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low Memory Hole
config: i386-buildonly-randconfig-001-20241125 (https://download.01.org/0day-ci/archive/20241125/202411251632.4eenIlnF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411251632.4eenIlnF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411251632.4eenIlnF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cxl/cxlmem.h:12,
                    from drivers/cxl/port.c:7:
>> drivers/cxl/cxl.h:921:6: warning: no previous prototype for 'arch_match_spa' [-Wmissing-prototypes]
     921 | bool arch_match_spa(struct cxl_root_decoder *cxlrd,
         |      ^~~~~~~~~~~~~~
>> drivers/cxl/cxl.h:927:6: warning: no previous prototype for 'arch_match_region' [-Wmissing-prototypes]
     927 | bool arch_match_region(struct cxl_region_params *p,
         |      ^~~~~~~~~~~~~~~~~
>> drivers/cxl/cxl.h:933:6: warning: no previous prototype for 'arch_trim_hpa_by_spa' [-Wmissing-prototypes]
     933 | void arch_trim_hpa_by_spa(struct resource *res,
         |      ^~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/arch_match_spa +921 drivers/cxl/cxl.h

   912	
   913	#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
   914	bool arch_match_spa(struct cxl_root_decoder *cxlrd,
   915			    struct cxl_endpoint_decoder *cxled);
   916	bool arch_match_region(struct cxl_region_params *p,
   917			       struct cxl_decoder *cxld);
   918	void arch_trim_hpa_by_spa(struct resource *res,
   919				  struct cxl_root_decoder *cxlrd);
   920	#else
 > 921	bool arch_match_spa(struct cxl_root_decoder *cxlrd,
   922			    struct cxl_endpoint_decoder *cxled)
   923	{
   924		return false;
   925	}
   926	
 > 927	bool arch_match_region(struct cxl_region_params *p,
   928			       struct cxl_decoder *cxld)
   929	{
   930		return false;
   931	}
   932	
 > 933	void arch_trim_hpa_by_spa(struct resource *res,
   934				  struct cxl_root_decoder *cxlrd)
   935	{ }
   936	#endif /* CXL_ARCH_LOW_MEMORY_HOLE */
   937	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
