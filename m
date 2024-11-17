Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6F101F2
	for <linux-cxl@vger.kernel.org>; Sun, 17 Nov 2024 04:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731817372; cv=none; b=ADE5XXs1YIV2RvlOJreK1VCWiWIlh3e9tSQTTSGeLJ5+VIuN+Yprg3F7rbwCb0AWl3+NmM1mDaC3iHQ05VhoDfvVq29xAzBcinDCW0LTGVpr0u/3Jl1YRTKzZ2L4QjY/ejN3waXzqhgZ6KGg4oig9G0QtFONSMhAnPeyoKzQv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731817372; c=relaxed/simple;
	bh=vUvMlFbUX0QiaPmD1QeTHC7tbGYCk60nGF3Q/Mh/g7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f01ShqwH8GbtsJh0/4TdynWre8vB2wiyaK3u48im9iUUHUOKRUHDo6pCyDGn0M1qaJAVUgCHx0M1YtbnAXHqu+seK70LC1IYQ86JTKK6X1dLcMW9lKfn3l61vMm8oz9cPTTsF0Dt1ztUD4TqYhzDOYCLhN8+68QsVl9Q6GcMqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZGOoord; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZGOoord"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731817372; x=1763353372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vUvMlFbUX0QiaPmD1QeTHC7tbGYCk60nGF3Q/Mh/g7s=;
  b=YZGOoord3v2Fs4uXkGKllzD5iAvtFl+oyRem+piVIqT2Ke8VzEz/QkHc
   +2+nzUpsXNPIM5oupB9wjWmo+jEEyuikmFsRWIqiSjEZp9WHsyzkFim9N
   rvrg/bvs+Yk1B81c9uUwDKvUYJe3ApwK12GMnaqzt14DxtCJ+rRz9m4Gk
   AnzMzbVd/jvem46o2MnEMrUwYPeXClOGsNkwaMcPFHE9OglJab1A77jpD
   SX3s1xsavL1TbyRJcSjVwu8Db9BfOqRtdV+jfp4nPKbLYYl4yiqbG/c5s
   /B3fxZzRHUbieUMDUY1KUrOYPC1wmNUI0sjeZXHR9+TeqMqQrSO9xgySH
   Q==;
X-CSE-ConnectionGUID: MAp3dCvHSSipxeuriJGiXw==
X-CSE-MsgGUID: qJCQshfuTli2Gi+nDm23Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="54290830"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="54290830"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 20:22:51 -0800
X-CSE-ConnectionGUID: VIYZd6vrQpSAoXyJ3cGQsg==
X-CSE-MsgGUID: n+shh4tlSDSbrHBr+x8XEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="89325859"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 16 Nov 2024 20:22:48 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCWoA-0001RZ-0y;
	Sun, 17 Nov 2024 04:22:46 +0000
Date: Sun, 17 Nov 2024 12:21:59 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Message-ID: <202411171240.wwR1wRdZ-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on cxl/next]
[also build test WARNING on linus/master v6.12-rc7 next-20241115]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-avoid-driver-data-for-obtaining-cxl_dev_state-reference/20241114-192818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20241114112435.45593-1-alejandro.lucero-palau%40amd.com
patch subject: [PATCH] cxl: avoid driver data for obtaining cxl_dev_state reference
config: alpha-randconfig-r051-20241117 (https://download.01.org/0day-ci/archive/20241117/202411171240.wwR1wRdZ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171240.wwR1wRdZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171240.wwR1wRdZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/perf/../cxl/cxlpci.h:6,
                    from drivers/perf/cxl_pmu.c:23:
>> drivers/perf/../cxl/cxl.h:823:32: warning: 'struct cxl_dev_state' declared inside parameter list will not be visible outside of this definition or declaration
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^~~~~~~~~~~~~


vim +823 drivers/perf/../cxl/cxl.h

   816	
   817	struct cxl_hdm;
   818	struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
   819					   struct cxl_endpoint_dvsec_info *info);
   820	int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
   821					struct cxl_endpoint_dvsec_info *info);
   822	int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
 > 823	int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
   824				struct cxl_endpoint_dvsec_info *info);
   825	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
