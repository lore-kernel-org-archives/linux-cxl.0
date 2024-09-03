Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DD18BBB0
	for <linux-cxl@vger.kernel.org>; Tue,  3 Sep 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381563; cv=none; b=l+tfwHxxo7qdzmWmqikdIz/QaHq94bDJVnh9xuORk5CtHcjBKz/sOr96eRnf+9xD1jbF6FRpVbXSzuzpEQbLQFXGKUeXNEyJuj5YosTbLVHfve2OKb+KqjmgsRKuEVLpPPszvELnoDVVmClZ4AFRykurIjxZVobTKZqRdYQpITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381563; c=relaxed/simple;
	bh=O4qJr+TVKyCC4UEwJBtP4mDrHLH62P5vv5tA1n4KB4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAZp4NMIqGIX7z5VTNBJc+39lPZDysF4aen+TtqLQdfif69kXO/aIrlrj+gqGkAPeSS3G5tASFybrz1CIsIHoZVqkVg5PAWrXmcMIjO0gwq7jEqMhJt5YkeXRCEvI1vHdKaiThLB8V9RKXr19H1IB5pHT3vUF+KXSjvKD9hDtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+o+K7eR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+o+K7eR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725381561; x=1756917561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O4qJr+TVKyCC4UEwJBtP4mDrHLH62P5vv5tA1n4KB4M=;
  b=c+o+K7eR8TBhQSEBsnfW4rYA12fTyqsKDITWPHJJatK2VfJtbevBi4d3
   K3KRhIrKTK4fEkHU0ohnWLf4Iso/tP5fu04AfjSpDT7e6XBICzk24G5S4
   g3ULAZ5YSbZen1pLtbQffRloIBAypOFlJDCyYJh/eJqGuj0fo0bNflH1y
   1KH2mBoMKcfOaao0Hi9sKi7BPDbNKXB9s+6pHp+lvAlHskt/05WWqwb8W
   gQUfW2kjn2wgyFwDlvwuDRQCaMlCBH1YYv2I+PmroQe+690Lf6xVt3CzD
   67kynJ/PhyzBCV11LgK+/m6zHvyD5A2XgvSLOeiuKZsnh3BWtiaQgC0xj
   g==;
X-CSE-ConnectionGUID: gDxkoS4XTuOisXlavTszGA==
X-CSE-MsgGUID: uXoKX+1qSlu7yb9dgikAJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="41465935"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="41465935"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 09:39:21 -0700
X-CSE-ConnectionGUID: tU8LSY0VSsG6TjIpKgxXog==
X-CSE-MsgGUID: pF3P06IjQfOMKXRVBY4TZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65334473"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 Sep 2024 09:39:19 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slWYn-0006uu-0J;
	Tue, 03 Sep 2024 16:39:17 +0000
Date: Wed, 4 Sep 2024 00:38:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Kobayashi, Daisuke" <kobayashi.da-06@fujitsu.com>,
	linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc: oe-kbuild-all@lists.linux.dev, mj@ucw.cz,
	"Kobayashi, Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v17 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Message-ID: <202409040011.kaajNuCb-lkp@intel.com>
References: <20240903025915.270521-2-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903025915.270521-2-kobayashi.da-06@fujitsu.com>

Hi Kobayashi,Daisuke,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master cxl/pending v6.11-rc6 next-20240903]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kobayashi-Daisuke/cxl-core-regs-Add-rcd_pcie_cap-initialization/20240903-110023
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20240903025915.270521-2-kobayashi.da-06%40fujitsu.com
patch subject: [PATCH v17 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240904/202409040011.kaajNuCb-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409040011.kaajNuCb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409040011.kaajNuCb-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cxl/pci.c: In function 'cxl_pci_setup_regs':
>> drivers/cxl/pci.c:511:25: error: cleanup argument not a function
     511 |                         cxl_pci_find_port(pdev, &dport);
         |                         ^~~~~~~~~~~~~~~~~


vim +511 drivers/cxl/pci.c

   495	
   496	static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
   497				      struct cxl_register_map *map)
   498	{
   499		int rc;
   500	
   501		rc = cxl_find_regblock(pdev, type, map);
   502	
   503		/*
   504		 * If the Register Locator DVSEC does not exist, check if it
   505		 * is an RCH and try to extract the Component Registers from
   506		 * an RCRB.
   507		 */
   508		if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
   509			struct cxl_dport *dport;
   510			struct cxl_port *port __free(put_cxl_port) =
 > 511				cxl_pci_find_port(pdev, &dport);
   512			if (!port)
   513				return -EPROBE_DEFER;
   514	
   515			rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
   516			if (rc)
   517				return rc;
   518	
   519			rc = cxl_dport_map_rcd_linkcap(pdev, dport);
   520			if (rc)
   521				return rc;
   522	
   523		} else if (rc) {
   524			return rc;
   525		}
   526	
   527		return cxl_setup_regs(map);
   528	}
   529	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
