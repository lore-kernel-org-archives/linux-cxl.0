Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156CF29E10B
	for <linux-cxl@vger.kernel.org>; Sat, 18 Apr 2026 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776485379; cv=none; b=aotjz9FL23miDTxSMhbHLjBO5xfrxFeqqRM5oZQ4IVlAQCweS6msYS9Eno++EweboYmbHECB6gMOGHgXsw2XFmCEKpFCmtY6hwbz869fjYIlMOz2sk5fzpNuujs9PHbjYEmr5Ulkp8vkWZKzhq5DSEh8SjPq3BBre3TKNww51Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776485379; c=relaxed/simple;
	bh=1qWmYlM4D2pYp21a7wxsLwARHCv4pMh0sLU18BHlqtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aytHP8rM/kQGhIUxHQTSmI0FueXa8YTvjkLrcYahRQAPtHO4KA/PWs/ax5AXCGJGDBCMjcbHRcf+S07IXB85FObXahQHSTVFb1zZFYJoumtHCGAtprJBzrhfCnmVRnPcwr8Xzxbzrksu7XTZXIHnnRaY8Ouw1bgdNY2G8CK4o2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMi9t/Lj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMi9t/Lj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776485377; x=1808021377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1qWmYlM4D2pYp21a7wxsLwARHCv4pMh0sLU18BHlqtE=;
  b=mMi9t/Lj6FA+6iDmumiv6lGX/JgossYSdGRCWozAneoPPtp4eIAxuXpi
   7xKvpZnmyuCFis/RjsH5vPXg/dKoMTrKxjFGM/tRKy4EXSF4tvZBItexO
   JneVgD+eL1noS1r1Z7qVzzNiJH3tl+JAin0LPTUhA2KcX70YU4Y4TB0H0
   +EHSYA5UWOyDHtZVjvYnn57VlkxEGYh3V748bHcXoItHDGxiHWcxlPMcB
   kXLKBr0gNzyaIm14M9mgQhYcqj1b9WC+2kimmv/paJtRPoi0Js9QbQjnm
   u4uxup0AvL1brf/voTRgskK8Z6JrZSyvMaBKQwMTtAJFZCiiX7TXKqz0M
   g==;
X-CSE-ConnectionGUID: jm+8Dc3CQqm/dQCfoircPg==
X-CSE-MsgGUID: 774BAdjERXqg0Dq+otYxVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="100147050"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="100147050"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 21:09:36 -0700
X-CSE-ConnectionGUID: hfcMKpQDQ6KOUBx44yFVdw==
X-CSE-MsgGUID: g6n9cLO7SkeQAbTDFI9VbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="232954929"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Apr 2026 21:09:34 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDwzr-000000000zo-04xo;
	Sat, 18 Apr 2026 04:09:31 +0000
Date: Sat, 18 Apr 2026 12:09:14 +0800
From: kernel test robot <lkp@intel.com>
To: Anisa Su <anisa.su887@gmail.com>, dave.jiang@intel.com,
	gourry@gourry.net
Cc: oe-kbuild-all@lists.linux.dev, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH] cxl/core/region_dax.c: fix missing assignment in
 cxl_dax_region_alloc()
Message-ID: <202604181220.pU6ypqms-lkp@intel.com>
References: <20260411011137.43545-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411011137.43545-1-anisa.su@samsung.com>

Hi Anisa,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master next-20260417]
[cannot apply to cxl/pending v7.0]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anisa-Su/cxl-core-region_dax-c-fix-missing-assignment-in-cxl_dax_region_alloc/20260417-104320
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20260411011137.43545-1-anisa.su%40samsung.com
patch subject: [PATCH] cxl/core/region_dax.c: fix missing assignment in cxl_dax_region_alloc()
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20260418/202604181220.pU6ypqms-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260418/202604181220.pU6ypqms-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604181220.pU6ypqms-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cxl/core/region_dax.c: In function 'cxl_dax_region_alloc':
>> drivers/cxl/core/region_dax.c:65:15: error: 'struct cxl_region' has no member named 'cxlr_dax'; did you mean 'cxlrd'?
      65 |         cxlr->cxlr_dax = cxlr_dax;
         |               ^~~~~~~~
         |               cxlrd


vim +65 drivers/cxl/core/region_dax.c

    45	
    46	static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
    47	{
    48		struct cxl_region_params *p = &cxlr->params;
    49		struct cxl_dax_region *cxlr_dax;
    50		struct device *dev;
    51	
    52		guard(rwsem_read)(&cxl_rwsem.region);
    53		if (p->state != CXL_CONFIG_COMMIT)
    54			return ERR_PTR(-ENXIO);
    55	
    56		cxlr_dax = kzalloc_obj(*cxlr_dax);
    57		if (!cxlr_dax)
    58			return ERR_PTR(-ENOMEM);
    59	
    60		cxlr_dax->hpa_range.start = p->res->start;
    61		cxlr_dax->hpa_range.end = p->res->end;
    62	
    63		dev = &cxlr_dax->dev;
    64		cxlr_dax->cxlr = cxlr;
  > 65		cxlr->cxlr_dax = cxlr_dax;
    66		device_initialize(dev);
    67		lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
    68		device_set_pm_not_required(dev);
    69		dev->parent = &cxlr->dev;
    70		dev->bus = &cxl_bus_type;
    71		dev->type = &cxl_dax_region_type;
    72	
    73		return cxlr_dax;
    74	}
    75	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
