Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9AD1607B4
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jan 2025 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867050; cv=none; b=JjhvjV75NdgV/0VYM5rUnyBePABdyExVKJlQekhB2y0WrokKbHv257GEwhQwyZjAJWpN3b+3B7nebmV2NLsaPHpo4FD2fPtb0Q6TPaHohveumweO4cRXlj9d4dfvY03Q6FlFZOStC8kwrkT5Sj6QIi3+OU7HL/WOJ10rLhbXaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867050; c=relaxed/simple;
	bh=tfILLtWeqqECk70OUTxBNI4PM4mhfz8zOAEA3KLj1Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWFRtGB2fmD22edIBCf+qXW3fHWOCjPx0N/H8wSBGYwgRj3YtLdKEdsHMEYw8GlgsZ/JenIkjrsTZgZoVub/MhqTwI/EjNSWJtMiy3wWktaWfjigIm22EFo/LO193ob5BR45YYlrMFPOnajsyyTvO0CGAyFB944D8O+RHU5xHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPWqHuka; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPWqHuka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736867049; x=1768403049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tfILLtWeqqECk70OUTxBNI4PM4mhfz8zOAEA3KLj1Hs=;
  b=dPWqHukaG2kmRjTotblfiIOFkPx6a4g4Vku/jDufPTs/AQDlMi9jBKMb
   z3ZIzTKIKvLbFgo7aZuOmV0IIffoNDrb8xi/QHsWD6WevTfB9/STTjiow
   zrE2YVwyChQw80BtChL2Sh0kq16p/NPvAqDDSHYV52NpNILYaY15bAkTx
   2IIBd6bZfkqb6xf68/MI5U2KllsdTpqABy8WBTmrrD1HZXA9OD2nwTbeH
   /z50n2LYSIFGjiaNt23SCm/y5eXwDUK8dLU+HthIzw4wpmCZ1+GWSH9eI
   uY0dFw5BTMzdsyDxxfGanh7FP6ulyEdahdZI+iFieyw21H5EptpYPj2sb
   Q==;
X-CSE-ConnectionGUID: qRN2CEcXT76kAFI369LT5w==
X-CSE-MsgGUID: tK6jiSdgQ7iu1fVC0rCdvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36860436"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="36860436"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 07:04:08 -0800
X-CSE-ConnectionGUID: 8tgsbuSVTr6YwOqbo3go8w==
X-CSE-MsgGUID: oAJus1taRBKU9deDEbdGZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104687776"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Jan 2025 07:04:05 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXiSY-000OgF-2r;
	Tue, 14 Jan 2025 15:04:02 +0000
Date: Tue, 14 Jan 2025 23:03:17 +0800
From: kernel test robot <lkp@intel.com>
To: Huaisheng Ye <huaisheng.ye@intel.com>, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, dave.jiang@intel.com,
	ming.li@zohomail.com
Cc: oe-kbuild-all@lists.linux.dev, pei.p.jia@intel.com,
	linux-cxl@vger.kernel.org, Huaisheng Ye <huaisheng.ye@intel.com>
Subject: Re: [PATCH v4 1/1] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Message-ID: <202501142243.PmkW84KY-lkp@intel.com>
References: <20250114131041.17512-2-huaisheng.ye@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114131041.17512-2-huaisheng.ye@intel.com>

Hi Huaisheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cxl/next]
[also build test WARNING on linus/master v6.13-rc7 next-20250114]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huaisheng-Ye/cxl-core-regs-Refactor-out-functions-to-count-regblocks-of-given-type/20250114-212025
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20250114131041.17512-2-huaisheng.ye%40intel.com
patch subject: [PATCH v4 1/1] cxl/core/regs: Refactor out functions to count regblocks of given type
config: i386-buildonly-randconfig-001-20250114 (https://download.01.org/0day-ci/archive/20250114/202501142243.PmkW84KY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250114/202501142243.PmkW84KY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501142243.PmkW84KY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/regs.c:303: warning: Function parameter or struct member 'pdev' not described in '__cxl_find_regblock_instance'
>> drivers/cxl/core/regs.c:303: warning: Function parameter or struct member 'type' not described in '__cxl_find_regblock_instance'
>> drivers/cxl/core/regs.c:303: warning: Function parameter or struct member 'map' not described in '__cxl_find_regblock_instance'
>> drivers/cxl/core/regs.c:303: warning: Function parameter or struct member 'index' not described in '__cxl_find_regblock_instance'


vim +303 drivers/cxl/core/regs.c

303ebc1b1741b6 Ben Widawsky     2022-01-23  291  
303ebc1b1741b6 Ben Widawsky     2022-01-23  292  /**
7167af677c5aa1 Huaisheng Ye     2025-01-14  293   * __cxl_find_regblock_instance() - Locate a register block or count instances by type / index
7167af677c5aa1 Huaisheng Ye     2025-01-14  294   * Use CXL_INSTANCES_COUNT for @index if counting instances.
303ebc1b1741b6 Ben Widawsky     2022-01-23  295   *
7167af677c5aa1 Huaisheng Ye     2025-01-14  296   * __cxl_find_regblock_instance() may return:
7167af677c5aa1 Huaisheng Ye     2025-01-14  297   * 0 - if register block enumerated.
7167af677c5aa1 Huaisheng Ye     2025-01-14  298   * >= 0 - if counting instances.
7167af677c5aa1 Huaisheng Ye     2025-01-14  299   * < 0 - error code otherwise.
303ebc1b1741b6 Ben Widawsky     2022-01-23  300   */
7167af677c5aa1 Huaisheng Ye     2025-01-14  301  static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
d717d7f3df1849 Jonathan Cameron 2023-05-26  302  			       struct cxl_register_map *map, int index)
303ebc1b1741b6 Ben Widawsky     2022-01-23 @303  {
303ebc1b1741b6 Ben Widawsky     2022-01-23  304  	u32 regloc_size, regblocks;
d717d7f3df1849 Jonathan Cameron 2023-05-26  305  	int instance = 0;
303ebc1b1741b6 Ben Widawsky     2022-01-23  306  	int regloc, i;
303ebc1b1741b6 Ben Widawsky     2022-01-23  307  
573408049b7598 Robert Richter   2023-06-22  308  	*map = (struct cxl_register_map) {
dd22581f895371 Robert Richter   2023-10-18  309  		.host = &pdev->dev,
573408049b7598 Robert Richter   2023-06-22  310  		.resource = CXL_RESOURCE_NONE,
573408049b7598 Robert Richter   2023-06-22  311  	};
573408049b7598 Robert Richter   2023-06-22  312  
962f1e79e7acfb Dave Jiang       2024-05-02  313  	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
303ebc1b1741b6 Ben Widawsky     2022-01-23  314  					   CXL_DVSEC_REG_LOCATOR);
303ebc1b1741b6 Ben Widawsky     2022-01-23  315  	if (!regloc)
303ebc1b1741b6 Ben Widawsky     2022-01-23  316  		return -ENXIO;
303ebc1b1741b6 Ben Widawsky     2022-01-23  317  
303ebc1b1741b6 Ben Widawsky     2022-01-23  318  	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
303ebc1b1741b6 Ben Widawsky     2022-01-23  319  	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
303ebc1b1741b6 Ben Widawsky     2022-01-23  320  
303ebc1b1741b6 Ben Widawsky     2022-01-23  321  	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
303ebc1b1741b6 Ben Widawsky     2022-01-23  322  	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
303ebc1b1741b6 Ben Widawsky     2022-01-23  323  
303ebc1b1741b6 Ben Widawsky     2022-01-23  324  	for (i = 0; i < regblocks; i++, regloc += 8) {
303ebc1b1741b6 Ben Widawsky     2022-01-23  325  		u32 reg_lo, reg_hi;
303ebc1b1741b6 Ben Widawsky     2022-01-23  326  
303ebc1b1741b6 Ben Widawsky     2022-01-23  327  		pci_read_config_dword(pdev, regloc, &reg_lo);
303ebc1b1741b6 Ben Widawsky     2022-01-23  328  		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
303ebc1b1741b6 Ben Widawsky     2022-01-23  329  
6c7f4f1e51c2a2 Dan Williams     2022-11-29  330  		if (!cxl_decode_regblock(pdev, reg_lo, reg_hi, map))
6c7f4f1e51c2a2 Dan Williams     2022-11-29  331  			continue;
303ebc1b1741b6 Ben Widawsky     2022-01-23  332  
d717d7f3df1849 Jonathan Cameron 2023-05-26  333  		if (map->reg_type == type) {
d717d7f3df1849 Jonathan Cameron 2023-05-26  334  			if (index == instance)
303ebc1b1741b6 Ben Widawsky     2022-01-23  335  				return 0;
d717d7f3df1849 Jonathan Cameron 2023-05-26  336  			instance++;
d717d7f3df1849 Jonathan Cameron 2023-05-26  337  		}
303ebc1b1741b6 Ben Widawsky     2022-01-23  338  	}
303ebc1b1741b6 Ben Widawsky     2022-01-23  339  
6c7f4f1e51c2a2 Dan Williams     2022-11-29  340  	map->resource = CXL_RESOURCE_NONE;
7167af677c5aa1 Huaisheng Ye     2025-01-14  341  	if (index == CXL_INSTANCES_COUNT)
7167af677c5aa1 Huaisheng Ye     2025-01-14  342  		return instance;
7167af677c5aa1 Huaisheng Ye     2025-01-14  343  
303ebc1b1741b6 Ben Widawsky     2022-01-23  344  	return -ENODEV;
303ebc1b1741b6 Ben Widawsky     2022-01-23  345  }
7167af677c5aa1 Huaisheng Ye     2025-01-14  346  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
