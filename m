Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3CD531
	for <linux-cxl@vger.kernel.org>; Sun, 17 Nov 2024 04:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731816651; cv=none; b=pqGYdRkcEFwF9hHSicThxB06/P2bDiQn7dMhlx8OuOWQnlWnHVhtvQ7k7A8hjQohiYwYeF0eiVp5h2gOgrbNTxf95V3QpP1qOqF76utftVR3NWxWXnq3lf9AgEQnVvERudLvgkZs31xe2KCBbKNE/1s1IJyWFOlkO5NM5hv4R70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731816651; c=relaxed/simple;
	bh=4VuRwoZgMhCe1kKKHaMtaRyUwBfXSVhlMUlghRFQQ0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noLU4y+xqe0yUPW6iMoEbygkMBvwnQOLdNsLvbwz3O08LPF3yeBOSBME+rnjDANTnhct4zWh/f58swzSnatciBRfuLuvCigNXrlL2eyBMOBMbXz+IhrHpLueuWiVmpW32tk2vsvhbvDVtOpAgCoNfcAIcj0IzOFNY1Ul7z5zjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJoWoxlx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJoWoxlx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731816649; x=1763352649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4VuRwoZgMhCe1kKKHaMtaRyUwBfXSVhlMUlghRFQQ0k=;
  b=oJoWoxlxLBEJvh5r67mBdt6UxrsCjn44rsu3ctxkunAW0Ra8pu1O4CKZ
   P4nZES/LhjOPMFnU5x9quC9mr4EeNt3lVKyDjA/jt7ScDMOF2J+V+smvk
   ADz9gBov/RuSO19fO+bNrsjzTwFGMlQ/d16O9X8MjkvLzOaK0XliCQxRp
   2DPhgKYlCpGMfPWEEcLRsFvXpYN68QDzBGp0Wx3HBnbPFV1RhhhgiTjo2
   2HlfjL2SWYvQV0X8nLU++Wkvi7syT3aY7xM80/37TJfXdhNPpEuVvPR1L
   acxF9sbXINhPWBu4zNxG5l6o1OTkZ2nKiQiAksaAgOl5ZhnkdC2FstpOn
   g==;
X-CSE-ConnectionGUID: YXVC/dSKSjuU2VTdxPLQ+Q==
X-CSE-MsgGUID: QXDG9CTKSjyT0O8o9Wk7HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="32033457"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="32033457"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 20:10:49 -0800
X-CSE-ConnectionGUID: 2J6rMLKpQNOSkrs4n2ej0A==
X-CSE-MsgGUID: rLCDyl2bT8SU4VrPS82Esw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="92988781"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Nov 2024 20:10:47 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCWcX-0001Qf-0X;
	Sun, 17 Nov 2024 04:10:45 +0000
Date: Sun, 17 Nov 2024 12:10:35 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Message-ID: <202411171112.pEhqyZHy-lkp@intel.com>
References: <20241114112435.45593-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114112435.45593-1-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master v6.12-rc7 next-20241115]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-avoid-driver-data-for-obtaining-cxl_dev_state-reference/20241114-192818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20241114112435.45593-1-alejandro.lucero-palau%40amd.com
patch subject: [PATCH] cxl: avoid driver data for obtaining cxl_dev_state reference
config: i386-randconfig-053-20241117 (https://download.01.org/0day-ci/archive/20241117/202411171112.pEhqyZHy-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171112.pEhqyZHy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171112.pEhqyZHy-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/cxl/pci.c:11:
   In file included from include/linux/pci.h:1650:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/cxl/pci.c:15:
   In file included from drivers/cxl/cxlmem.h:12:
>> drivers/cxl/cxl.h:823:32: warning: declaration of 'struct cxl_dev_state' will not be visible outside of this function [-Wvisibility]
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^
   2 warnings generated.
--
   In file included from drivers/cxl/port.c:7:
   In file included from drivers/cxl/cxlmem.h:6:
   In file included from include/linux/pci.h:1650:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/cxl/port.c:7:
   In file included from drivers/cxl/cxlmem.h:12:
>> drivers/cxl/cxl.h:823:32: warning: declaration of 'struct cxl_dev_state' will not be visible outside of this function [-Wvisibility]
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^
>> drivers/cxl/port.c:101:27: error: incompatible pointer types passing 'struct cxl_dev_state *' to parameter of type 'struct cxl_dev_state *' [-Werror,-Wincompatible-pointer-types]
     101 |         rc = cxl_dvsec_rr_decode(cxlds, &info);
         |                                  ^~~~~
   drivers/cxl/cxl.h:823:47: note: passing argument to parameter 'cxlds' here
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                               ^
   2 warnings and 1 error generated.
--
   In file included from drivers/cxl/core/pci.c:7:
   In file included from include/linux/pci.h:1650:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/cxl/core/pci.c:10:
   In file included from drivers/cxl/cxlpci.h:6:
>> drivers/cxl/cxl.h:823:32: warning: declaration of 'struct cxl_dev_state' will not be visible outside of this function [-Wvisibility]
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^
>> drivers/cxl/core/pci.c:294:5: error: conflicting types for 'cxl_dvsec_rr_decode'
     294 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |     ^
   drivers/cxl/cxl.h:823:5: note: previous declaration is here
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |     ^
   2 warnings and 1 error generated.


vim +101 drivers/cxl/port.c

    91	
    92	static int cxl_endpoint_port_probe(struct cxl_port *port)
    93	{
    94		struct cxl_endpoint_dvsec_info info = { .port = port };
    95		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
    96		struct cxl_dev_state *cxlds = cxlmd->cxlds;
    97		struct cxl_hdm *cxlhdm;
    98		struct cxl_port *root;
    99		int rc;
   100	
 > 101		rc = cxl_dvsec_rr_decode(cxlds, &info);
   102		if (rc < 0)
   103			return rc;
   104	
   105		cxlhdm = devm_cxl_setup_hdm(port, &info);
   106		if (IS_ERR(cxlhdm)) {
   107			if (PTR_ERR(cxlhdm) == -ENODEV)
   108				dev_err(&port->dev, "HDM decoder registers not found\n");
   109			return PTR_ERR(cxlhdm);
   110		}
   111	
   112		/* Cache the data early to ensure is_visible() works */
   113		read_cdat_data(port);
   114		cxl_endpoint_parse_cdat(port);
   115	
   116		get_device(&cxlmd->dev);
   117		rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
   118		if (rc)
   119			return rc;
   120	
   121		rc = cxl_hdm_decode_init(cxlds, cxlhdm, &info);
   122		if (rc)
   123			return rc;
   124	
   125		rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
   126		if (rc)
   127			return rc;
   128	
   129		/*
   130		 * This can't fail in practice as CXL root exit unregisters all
   131		 * descendant ports and that in turn synchronizes with cxl_port_probe()
   132		 */
   133		struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
   134	
   135		root = &cxl_root->port;
   136	
   137		/*
   138		 * Now that all endpoint decoders are successfully enumerated, try to
   139		 * assemble regions from committed decoders
   140		 */
   141		device_for_each_child(&port->dev, root, discover_region);
   142	
   143		return 0;
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
