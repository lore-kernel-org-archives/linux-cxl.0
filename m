Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33A191F91
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458177; cv=none; b=uRlISMQf+3TgR4ZPAGtSjqaBN4HdXLgnsUO0OdbqRuqdj2HGbMhMkdPulQB6NId7LezvtkDmboRpY+LUjtpe/U3RTFf+1dMxh5jUdzRiVjNmwqvQ98GPvLDmac2IQIG+1MvXWd9wSes3owjfS1OZ9PJSNLeBX/93Ycg1YhaZvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458177; c=relaxed/simple;
	bh=pnVJFbiYOWmfbtUVbCRnSH01HwY8EhsGbp196NKj748=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYYBmbJUsVf9OhuRtXtHgBZpGNSAHgJiXK5tio+hKTuHKUb0Tf9fvycnWjX32gLqexd/04I6OLOi2XRUko3fPS+FQrsMnVRSRAuHFi/hZI2mHrO6aHYcaZ90xyxfj9ndgl1k1buIkCY4prf74rM7FaAGiMzrXaTaSHU6mzIdhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ktus5zNL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ktus5zNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776458176; x=1807994176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pnVJFbiYOWmfbtUVbCRnSH01HwY8EhsGbp196NKj748=;
  b=Ktus5zNLSqWTRwZrVHgVVtDq9JR8ZB7dMaOQI75+MFyfUMhpZppHUe5A
   CYlm4VaOxAmZeX0y36He5LAECl4BDF8YF4XOP3q7Lk6bIx0ekNDVhQS8b
   TW9rmDEicdaPitsrUP+q0s98G+FbxJwTyfS/2rFOIVaH8cuyjG/+66e1G
   WyM4UEBmix4VtA0FKtzyuw0NrC+Of7N3HPCqGIof3S26MSLOhEdicsGkK
   Ea98UNz9Th2jBZF/Fl/3BXkhF65NYt6whmtO78j1i3Q7wDh2kIj+dCg7S
   NdBasaFhcG6Y1CUx5Lj1JhZWkwebCoxx57oZS1odRZuwpJwPSsYZjuZu/
   g==;
X-CSE-ConnectionGUID: b10RgJh3Tm2iJcImOiGg3w==
X-CSE-MsgGUID: W+7K6Z2IQpSPfb3L9+69JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77386803"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="77386803"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 13:36:16 -0700
X-CSE-ConnectionGUID: RTtFaMm8RqOonnnixRi9cg==
X-CSE-MsgGUID: lXHNBINrT827P+cJQ+Trew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="231399571"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Apr 2026 13:36:12 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDpv7-000000000gW-1vxr;
	Fri, 17 Apr 2026 20:36:09 +0000
Date: Sat, 18 Apr 2026 04:35:17 +0800
From: kernel test robot <lkp@intel.com>
To: Anisa Su <anisa.su887@gmail.com>, dave.jiang@intel.com,
	gourry@gourry.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH] cxl/core/region_dax.c: fix missing assignment in
 cxl_dax_region_alloc()
Message-ID: <202604180424.a2VTSNB7-lkp@intel.com>
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
[also build test ERROR on next-20260416]
[cannot apply to linus/master cxl/pending v7.0]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anisa-Su/cxl-core-region_dax-c-fix-missing-assignment-in-cxl_dax_region_alloc/20260417-104320
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20260411011137.43545-1-anisa.su%40samsung.com
patch subject: [PATCH] cxl/core/region_dax.c: fix missing assignment in cxl_dax_region_alloc()
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20260418/202604180424.a2VTSNB7-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260418/202604180424.a2VTSNB7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604180424.a2VTSNB7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/core/region_dax.c:65:8: error: no member named 'cxlr_dax' in 'struct cxl_region'
      65 |         cxlr->cxlr_dax = cxlr_dax;
         |         ~~~~  ^
   1 error generated.


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
