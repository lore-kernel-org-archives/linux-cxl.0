Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EB381C4
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739015334; cv=none; b=o+LNWSnMv3yI2GV3blOMsUtzHUlDLDuW7KETpQVH0yPk6G5g63+Hpb7p4bF/r25MRRwGnHiLh1PCVWA3F/hb5w226pmu1cdDDFi5cMwU2iAuQSWvGWhQRenzcNHia3iRCPJLwL0usQvHeDI+3szs7qQA1Sr7L4eIAXXNsxiKD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739015334; c=relaxed/simple;
	bh=HLmBbTuhVfiMWNhqpQ1zixvAXCyK91pNdKswqsMBV8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl8TMj4wYqbrGwgUFqCcEboq1vKpxQVymvJbwPDQUidfVf/DbL8+PqctQLahHp4kduMYg5UyjlsVyHbUfeMgum10SrTH8Q4jSGNF/1xkrX2XeqUGaLvuJHdQA6242StoFKL2mTrD4O+gXUoicPm0bdDxk1u4TBA0J2fZVHT5HW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2MQXur/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2MQXur/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739015331; x=1770551331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HLmBbTuhVfiMWNhqpQ1zixvAXCyK91pNdKswqsMBV8Q=;
  b=Q2MQXur/4IWsIgFCcvzS6vovW/3Hzm9RuSSRfuf4S2TryrrH5eH+Idqm
   UsKZGJcG0CeFFj/31vOuSTaBmT4/S+5vmqpsFOKXHh1wkHH1HB3YHNu4x
   JWD3axtcyNH2Z9PZYdX2OR/+q/t9H0Ry34RuJk8uQRijVlyZqryvD1swB
   ciNj+9OQe5yP4YZ19mRLlWL6jInqQYdpMNtawb9LYoOxmKg/2qV/8HCLj
   U1YnanH64keUNnI/vZ45rQvv5S5ieR/eDsq/a+bZTFgpc7IjqTHnM0MA0
   mVqkzu+Hisp9VTrKYEVIg5LvytM8LJN2Q/H1BXInCNSUVwLJB8+5dumW/
   g==;
X-CSE-ConnectionGUID: 6EmPFdHYTLup8He0CKUmZQ==
X-CSE-MsgGUID: 1JJ039xZTLWfmxO1k9hmzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39521268"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; 
   d="scan'208";a="39521268"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 03:48:51 -0800
X-CSE-ConnectionGUID: sFvVayEWTviPv0RS569+uA==
X-CSE-MsgGUID: rFNL0yVGTxCm5qcnDucQXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148960818"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 08 Feb 2025 03:48:48 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgjKH-000zv9-0Z;
	Sat, 08 Feb 2025 11:48:45 +0000
Date: Sat, 8 Feb 2025 19:48:35 +0800
From: kernel test robot <lkp@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Zhi Wang <zhiw@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v1 1/1] cxl: add support for cxl reset
Message-ID: <202502081954.MzqpYilc-lkp@intel.com>
References: <20250207090327.172478-2-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207090327.172478-2-smadhavan@nvidia.com>

Hi Srirangan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.14-rc1 next-20250207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srirangan-Madhavan/cxl-add-support-for-cxl-reset/20250207-170511
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250207090327.172478-2-smadhavan%40nvidia.com
patch subject: [PATCH v1 1/1] cxl: add support for cxl reset
config: x86_64-randconfig-161-20250208 (https://download.01.org/0day-ci/archive/20250208/202502081954.MzqpYilc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502081954.MzqpYilc-lkp@intel.com/

smatch warnings:
drivers/pci/pci.c:5172 cxl_reset_prepare() warn: unsigned 'timeout_tot_us' is never less than zero.

vim +/timeout_tot_us +5172 drivers/pci/pci.c

  5124	
  5125	static int cxl_reset_prepare(struct pci_dev *dev, u16 dvsec)
  5126	{
  5127		u16 reg, val, cap;
  5128		int rc;
  5129		u32 timeout_us = 100, timeout_tot_us = 10000;
  5130	
  5131		/*
  5132		 * Wait for any pending transactions.
  5133		 * Assuming this does cxl.io stuff.
  5134		 */
  5135		if (!pci_wait_for_pending_transaction(dev))
  5136			pci_err(dev, "timed out waiting for pending transaction; performing cxl reset anyway\n");
  5137	
  5138		/*
  5139		 * Disable caching and then write back and invalidate lines.
  5140		 */
  5141		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
  5142					  &cap);
  5143		if (rc)
  5144			return rc;
  5145	
  5146		if (!(cap & PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE))
  5147			return 0;
  5148	
  5149		/*
  5150		 * Disable cache.
  5151		 * WB and invalidate cahce if capability is advertised.
  5152		 */
  5153		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
  5154					  &reg);
  5155		if (rc)
  5156			return rc;
  5157		val = reg | PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING;
  5158	
  5159		if (cap & PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE)
  5160			val = reg | PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE;
  5161		pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
  5162				      val);
  5163	
  5164		/*
  5165		 * From Section 9.6: "Software may leverage the cache size reported in
  5166		 * the DVSEC CXL Capability2 register to compute a suitable timeout
  5167		 * value".
  5168		 * Given there is no conversion factor for cache size -> timeout,
  5169		 * setting timer for default 10ms.
  5170		 */
  5171		do {
> 5172			if (timeout_tot_us < 0)
  5173				return -ETIMEDOUT;
  5174			usleep_range(timeout_us, timeout_us+1);
  5175			timeout_tot_us -= timeout_us;
  5176			rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
  5177						  &reg);
  5178			if (rc)
  5179				return rc;
  5180		} while (!(reg & PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID));
  5181	
  5182		return 0;
  5183	}
  5184	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
