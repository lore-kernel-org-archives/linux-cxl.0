Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05829406
	for <linux-cxl@vger.kernel.org>; Sun, 17 Nov 2024 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731827590; cv=none; b=jAzRKFXIi5Bd/rHZjC3dttD/qyr/+TKfUb+ziYtUV3o0It75To6+C7xi4eGUS+tycyziNC+wNetapJcOmu6jAd4Kr6l9abYemJGxpTfn81t4X9Nnecu9X2Eayb0ga+J21VHlRcoFkP76vuotnRcOxIT6/iP456NSR+e1RnRnOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731827590; c=relaxed/simple;
	bh=dnjyK7JcRz1fpjjgMXpPT8ch7/cxUcTD3lZ3kKgG3y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0yP4J2MrQYf/PglIks+AayCxRkRg82eNeLN97LUOEpjfVU4Y+uEd+EE/4SbPUWy+7zLjpTeRRV4EC6UURJnPXTKGkyaDUX8A3LwDxt9eYWPn6yU1PXbDRXpEiYGa8bKr75niOhLGyYrY66GWTNok4caYQnItjYKPhz6NUDmWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVUSAJ8s; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVUSAJ8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731827589; x=1763363589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dnjyK7JcRz1fpjjgMXpPT8ch7/cxUcTD3lZ3kKgG3y8=;
  b=jVUSAJ8s5wIinU8xj7w90E9VoI7sPp7bjVBY3h3QuN0V4+8Pa0TpJYUT
   u2nbZFvPUdn06yPN+cpb6Rhksbs2SU/Ld1koK5TEPPpzxuH5FGfz5rbOT
   ylfAUS7CTLBi8s/q7QwficVhbzE5eZ8ScMzQfOHZjBA+/nnyHaE/KSQjY
   voHBHMP9lJJvJ81Db9+vhb949UmqG89Hnk9mC6nzwUyzLi2Cg8KJA7ykR
   5pgSslBxTO+IsvA5GqrBmW17pIythhzS+gIcX6IaEo4fM9TKhfjFIi+y9
   JLGFAlr8RTemB48NWI7oQirhvQEzcGWNTYOyOGaQPssVIgp7jKDl9HXKa
   Q==;
X-CSE-ConnectionGUID: 3qNEoJ3jSoG6lqTqbUca8A==
X-CSE-MsgGUID: 420HRb/MSf6syeCWWEeGwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31638516"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31638516"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 23:13:09 -0800
X-CSE-ConnectionGUID: chuAExxeRaq35Mh+U3Pn2Q==
X-CSE-MsgGUID: PRZW6FbfTemSdbsf7NWDIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="89094172"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 16 Nov 2024 23:13:07 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCZSx-0001cT-39;
	Sun, 17 Nov 2024 07:13:03 +0000
Date: Sun, 17 Nov 2024 15:12:53 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Message-ID: <202411171720.1crMgwi0-lkp@intel.com>
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
config: arm-randconfig-003-20241117 (https://download.01.org/0day-ci/archive/20241117/202411171720.1crMgwi0-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171720.1crMgwi0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171720.1crMgwi0-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/cxl/cxlmem.h:12,
                    from drivers/cxl/port.c:7:
>> drivers/cxl/cxl.h:823:32: warning: 'struct cxl_dev_state' declared inside parameter list will not be visible outside of this definition or declaration
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^~~~~~~~~~~~~
   drivers/cxl/port.c: In function 'cxl_endpoint_port_probe':
>> drivers/cxl/port.c:101:34: error: passing argument 1 of 'cxl_dvsec_rr_decode' from incompatible pointer type [-Wincompatible-pointer-types]
     101 |         rc = cxl_dvsec_rr_decode(cxlds, &info);
         |                                  ^~~~~
         |                                  |
         |                                  struct cxl_dev_state *
   drivers/cxl/cxl.h:823:47: note: expected 'struct cxl_dev_state *' but argument is of type 'struct cxl_dev_state *'
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                         ~~~~~~~~~~~~~~~~~~~~~~^~~~~
--
   In file included from drivers/cxl/cxlmem.h:12,
                    from drivers/cxl/pci.c:15:
>> drivers/cxl/cxl.h:823:32: warning: 'struct cxl_dev_state' declared inside parameter list will not be visible outside of this definition or declaration
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^~~~~~~~~~~~~
--
   In file included from drivers/cxl/cxlpci.h:6,
                    from drivers/cxl/core/pci.c:10:
>> drivers/cxl/cxl.h:823:32: warning: 'struct cxl_dev_state' declared inside parameter list will not be visible outside of this definition or declaration
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^~~~~~~~~~~~~
>> drivers/cxl/core/pci.c:294:5: error: conflicting types for 'cxl_dvsec_rr_decode'; have 'int(struct cxl_dev_state *, struct cxl_endpoint_dvsec_info *)'
     294 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |     ^~~~~~~~~~~~~~~~~~~
   drivers/cxl/cxl.h:823:5: note: previous declaration of 'cxl_dvsec_rr_decode' with type 'int(struct cxl_dev_state *, struct cxl_endpoint_dvsec_info *)'
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |     ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from arch/arm/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:12,
                    from include/linux/io-64-nonatomic-lo-hi.h:5,
                    from drivers/cxl/core/pci.c:4:
   drivers/cxl/core/pci.c:389:22: error: conflicting types for 'cxl_dvsec_rr_decode'; have 'int(struct cxl_dev_state *, struct cxl_endpoint_dvsec_info *)'
     389 | EXPORT_SYMBOL_NS_GPL(cxl_dvsec_rr_decode, CXL);
         |                      ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   drivers/cxl/core/pci.c:389:1: note: in expansion of macro 'EXPORT_SYMBOL_NS_GPL'
     389 | EXPORT_SYMBOL_NS_GPL(cxl_dvsec_rr_decode, CXL);
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/cxl/cxl.h:823:5: note: previous declaration of 'cxl_dvsec_rr_decode' with type 'int(struct cxl_dev_state *, struct cxl_endpoint_dvsec_info *)'
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |     ^~~~~~~~~~~~~~~~~~~


vim +/cxl_dvsec_rr_decode +101 drivers/cxl/port.c

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
