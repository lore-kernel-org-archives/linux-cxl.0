Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924B2459BF
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948083; cv=none; b=nTuN/7ERIlyOOn/IFZr6jYPhqonlH4mA12BRF8XrPJRUaDzj9OzaLHRwwWTmunq9hoKYI1jElkexrkAvIJ2DERulO3GSFGC7fOd+imZCGlZMlh1c/Ebm2LQXaybo0cZluPPYjIkiAVcMK+Plhtome/Ry/lLrveEMqlQLh6RJV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948083; c=relaxed/simple;
	bh=UTmEPbF/laTtPmzFr2BNQEsdiaGFe1O+kj74kGFo+W4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1eSLmCZAppt+92dsWudIqy0FLop00CfgSVGwJz4nK9sTA3DJSXoU3qUmuz/A6RDge1gJEJEyU1mimNRrSLuFpKplGmfwYbJHgtrYQEDXhq5DrqwyWruffipTinRoUfnuoHJVNRRW5yuiba7bowo0RHcjPi9SrJit99AQJeSXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY6Pd5Tpnz6LD4C;
	Wed, 15 Jan 2025 21:32:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E4BED140A35;
	Wed, 15 Jan 2025 21:34:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 15 Jan
 2025 14:34:38 +0100
Date: Wed, 15 Jan 2025 13:34:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: kernel test robot <lkp@intel.com>
CC: Huaisheng Ye <huaisheng.ye@intel.com>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <ming.li@zohomail.com>,
	<oe-kbuild-all@lists.linux.dev>, <pei.p.jia@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Message-ID: <20250115133437.00003240@huawei.com>
In-Reply-To: <202501142243.PmkW84KY-lkp@intel.com>
References: <20250114131041.17512-2-huaisheng.ye@intel.com>
	<202501142243.PmkW84KY-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 14 Jan 2025 23:03:17 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Huaisheng,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on cxl/next]
> [also build test WARNING on linus/master v6.13-rc7 next-20250114]
> [cannot apply to cxl/pending]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Huaisheng-Ye/cxl-core-regs-Refactor-out-functions-to-count-regblocks-of-given-type/20250114-212025
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
> patch link:    https://lore.kernel.org/r/20250114131041.17512-2-huaisheng.ye%40intel.com
> patch subject: [PATCH v4 1/1] cxl/core/regs: Refactor out functions to count regblocks of given type
> config: i386-buildonly-randconfig-001-20250114 (https://download.01.org/0day-ci/archive/20250114/202501142243.PmkW84KY-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250114/202501142243.PmkW84KY-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501142243.PmkW84KY-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/cxl/core/regs.c:303: warning: Function parameter or struct member 'pdev' not described in '__cxl_find_regblock_instance'
> >> drivers/cxl/core/regs.c:303: warning: Function parameter or struct member 'type' not described in '__cxl_find_regblock_instance'
> >> drivers/cxl/core/regs.c:303: warning: Function parameter or struct member 'map' not described in '__cxl_find_regblock_instance'
> >> drivers/cxl/core/regs.c:303: warning: Function parameter or struct member 'index' not described in '__cxl_find_regblock_instance'  
> 
As you've probably gathered from this, kernel-doc needs to be complete.
I'd just drop the extra *. This isn't stuff we need outside of someone
reading the actual code.

/*
 * __cxl_find_....

> 
> vim +303 drivers/cxl/core/regs.c
> 
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  291  
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  292  /**
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  293   * __cxl_find_regblock_instance() - Locate a register block or count instances by type / index
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  294   * Use CXL_INSTANCES_COUNT for @index if counting instances.
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  295   *
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  296   * __cxl_find_regblock_instance() may return:
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  297   * 0 - if register block enumerated.
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  298   * >= 0 - if counting instances.
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  299   * < 0 - error code otherwise.
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  300   */
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  301  static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
> d717d7f3df1849 Jonathan Cameron 2023-05-26  302  			       struct cxl_register_map *map, int index)
> 303ebc1b1741b6 Ben Widawsky     2022-01-23 @303  {
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  304  	u32 regloc_size, regblocks;
> d717d7f3df1849 Jonathan Cameron 2023-05-26  305  	int instance = 0;
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  306  	int regloc, i;
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  307  
> 573408049b7598 Robert Richter   2023-06-22  308  	*map = (struct cxl_register_map) {
> dd22581f895371 Robert Richter   2023-10-18  309  		.host = &pdev->dev,
> 573408049b7598 Robert Richter   2023-06-22  310  		.resource = CXL_RESOURCE_NONE,
> 573408049b7598 Robert Richter   2023-06-22  311  	};
> 573408049b7598 Robert Richter   2023-06-22  312  
> 962f1e79e7acfb Dave Jiang       2024-05-02  313  	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  314  					   CXL_DVSEC_REG_LOCATOR);
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  315  	if (!regloc)
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  316  		return -ENXIO;
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  317  
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  318  	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  319  	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  320  
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  321  	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  322  	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  323  
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  324  	for (i = 0; i < regblocks; i++, regloc += 8) {
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  325  		u32 reg_lo, reg_hi;
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  326  
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  327  		pci_read_config_dword(pdev, regloc, &reg_lo);
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  328  		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  329  
> 6c7f4f1e51c2a2 Dan Williams     2022-11-29  330  		if (!cxl_decode_regblock(pdev, reg_lo, reg_hi, map))
> 6c7f4f1e51c2a2 Dan Williams     2022-11-29  331  			continue;
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  332  
> d717d7f3df1849 Jonathan Cameron 2023-05-26  333  		if (map->reg_type == type) {
> d717d7f3df1849 Jonathan Cameron 2023-05-26  334  			if (index == instance)
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  335  				return 0;
> d717d7f3df1849 Jonathan Cameron 2023-05-26  336  			instance++;
> d717d7f3df1849 Jonathan Cameron 2023-05-26  337  		}
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  338  	}
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  339  
> 6c7f4f1e51c2a2 Dan Williams     2022-11-29  340  	map->resource = CXL_RESOURCE_NONE;
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  341  	if (index == CXL_INSTANCES_COUNT)
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  342  		return instance;
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  343  
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  344  	return -ENODEV;
> 303ebc1b1741b6 Ben Widawsky     2022-01-23  345  }
> 7167af677c5aa1 Huaisheng Ye     2025-01-14  346  
> 

