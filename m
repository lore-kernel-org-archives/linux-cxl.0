Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300017A90F
	for <linux-cxl@vger.kernel.org>; Tue,  3 Sep 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382765; cv=none; b=bx4UFZfDpkxhGEBqtwM1degYdG8VaUwx4sXCd6kmrO9GR5LGgyI4wfFo1oITe4odpOGGDBcWwvXXmrSBmVgKgxJH/nzg/HqIWKQYiUhYnyDrw9f5XqVB8Cfmu1smuontELd2QH3EVg6ZSRA3OBptuUuw8tXTKknhrQsWguTvb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382765; c=relaxed/simple;
	bh=NqD0KjUYLUqZjf+h45oIDnI7UgcCt77pUgo/JygmMuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJYuTr0ddThcK79MjrmFtFpChb9+a9E/gs1t0GJ/2E2lZAyuDxM55JT2NprRzLNbwMmd9T8f4mb+vCG/GbZ2Xx1UnQYCPDgMQwMUcMQ0s93y6eXaN+iXkLbj9BINbHEpD6DZgD+80we5dpSwKNsyta5Rz4VJZ6UCiAIWbAd3f7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhiIEMMN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhiIEMMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725382764; x=1756918764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NqD0KjUYLUqZjf+h45oIDnI7UgcCt77pUgo/JygmMuk=;
  b=mhiIEMMNQrYMuMem5Oc9cVZiUF/nfDApNPLGEtwoB5l0UJUbqWti0mfe
   6vMH9PM0uXM0tiikt1TkJregzRf9r/cQ0E3pclIer3bQWVr65HY/DBK9+
   30SlSb8Z88uZRek6gSUY25kieasj4Jb8eaFCTRkq/klRLxrO9vtIJ6N86
   RKcKetLq2mLETd/dp60Q/7sQCXhqPr2x0YWp6fhLuB9eM4S0K1lPqExor
   3kHyGIyY3jklfTM0wZrkSM2tFl2kq+QBAJDf5zr9AGoxVO9vE2Fde5e3P
   pnp8/b/wT4XVUVIfUkvx1QKFQ83B7BC3IvdD8lXSTLTgh6xN2/gGXpHeK
   A==;
X-CSE-ConnectionGUID: MKFr/2vGQ5u0HHmWTPbmTw==
X-CSE-MsgGUID: uRwIjpXeR32+iLA2F5GWIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35154042"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="35154042"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 09:59:24 -0700
X-CSE-ConnectionGUID: 6JJAdnTkTbmZkM6YU1L3dA==
X-CSE-MsgGUID: nXQVUhrmR0GbIjv6Vr8EtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65030974"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Sep 2024 09:59:20 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slWsA-0006vt-2H;
	Tue, 03 Sep 2024 16:59:18 +0000
Date: Wed, 4 Sep 2024 00:59:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Kobayashi, Daisuke" <kobayashi.da-06@fujitsu.com>,
	linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, mj@ucw.cz,
	"Kobayashi, Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v17 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Message-ID: <202409040010.afyGcWUe-lkp@intel.com>
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
config: x86_64-randconfig-001-20240903 (https://download.01.org/0day-ci/archive/20240904/202409040010.afyGcWUe-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409040010.afyGcWUe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409040010.afyGcWUe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/pci.c:510:25: error: use of undeclared identifier '__free_put_cxl_port'; did you mean '__free_put_cxl_root'?
     510 |                 struct cxl_port *port __free(put_cxl_port) =
         |                                       ^
   include/linux/cleanup.h:64:33: note: expanded from macro '__free'
      64 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:28:1: note: expanded from here
      28 | __free_put_cxl_port
         | ^
   drivers/cxl/cxl.h:752:1: note: '__free_put_cxl_root' declared here
     752 | DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
         | ^
   include/linux/cleanup.h:62:21: note: expanded from macro 'DEFINE_FREE'
      62 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                            ^
   <scratch space>:64:1: note: expanded from here
      64 | __free_put_cxl_root
         | ^
   1 error generated.


vim +510 drivers/cxl/pci.c

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
 > 510			struct cxl_port *port __free(put_cxl_port) =
   511				cxl_pci_find_port(pdev, &dport);
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
