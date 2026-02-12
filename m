Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F006E1CFBA
	for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770876133; cv=none; b=SsxD4e4FYr/PIz4WlhZiULly2Qap4EGhrydlmTLsFAJO6pyXkLgcxmB04GK78HPSOiIFxxJ0QcbevksV8SjobOyi6qxHPtaOrJ6anJYDsNYUDDHxiCccMTFwsIeEsWmGzfI9OX8mW5GkaJjHN4bx3gEE2QRMlwmS/D9UfY5Nugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770876133; c=relaxed/simple;
	bh=KD29+j71pGyR4yNcgfg11H98jxbreWU3SOi0nowMMBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upBb1Aa/Lgg4jm9UAVUCMSEma6wWSnvCGoaswUMSu68J3LvedulJxuSbtKFRk0u7phAw3fzQL5n3Ihap4unFEUenFm/WAMTNyKo9X0Z3gbyWZUBXj7lvBZLWRujSu2N5D+hLACqmFrMiZ6p2M9GG8SzpdCw4mTsFl1SBDxjyNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iy0MDBCz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iy0MDBCz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770876131; x=1802412131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KD29+j71pGyR4yNcgfg11H98jxbreWU3SOi0nowMMBA=;
  b=iy0MDBCz7SzfaAtAaSs1kyDQ/Efj9mo6ZALy9D+MuRcLJ54jplT7RWQ5
   h4StiwZdR79va0BZuzEFZPfIHXErxIUK2X2gIC2dudVeJkH9wcV8F/eha
   RLdpaATPPQGvGX84Ql8OPVjeLXyU2tCKXnRv33dAVyfYlH12lFZ05cUmS
   pYZ6o9ASJMKz9QBlQgR3O94egS6+7LMKFv7W8kN1izZwl8dy5ST4vSFt4
   gkFMVhLnNh4TxyjlYuiQwmwB9t+6ANn4daHapVCuswKIv730qbz5iBpbg
   XpNYGNQufkAT+VdBPczoPxQRm79QQrqPHa9NFoPbsOpuVc/3wjxXbZxBd
   A==;
X-CSE-ConnectionGUID: yrpNM1LjSm+i9bgK0TdEgw==
X-CSE-MsgGUID: Kt9/ALs8SL24D6cC5ik5+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="74640959"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="74640959"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 22:02:10 -0800
X-CSE-ConnectionGUID: 26tH01k6QNyjFIklZ6n1ug==
X-CSE-MsgGUID: ZsJBb3I8SXObdc9YfmVs8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="235462530"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Feb 2026 22:02:08 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqPm9-00000000qkm-3mA5;
	Thu, 12 Feb 2026 06:02:05 +0000
Date: Thu, 12 Feb 2026 14:01:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v2 3/3] cxl: Clean up cxl_nvdimm devices when removing
 nvdimm_bus
Message-ID: <202602121343.8IGnsS7f-lkp@intel.com>
References: <20260211232630.480509-4-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211232630.480509-4-dave.jiang@intel.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 63fbf275fa9f18f7020fb8acf54fa107e51d0f23]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Jiang/cxl-Move-devm_cxl_add_nvdimm_bridge-to-cxl_pmem-ko/20260212-073008
base:   63fbf275fa9f18f7020fb8acf54fa107e51d0f23
patch link:    https://lore.kernel.org/r/20260211232630.480509-4-dave.jiang%40intel.com
patch subject: [PATCH v2 3/3] cxl: Clean up cxl_nvdimm devices when removing nvdimm_bus
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260212/202602121343.8IGnsS7f-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260212/202602121343.8IGnsS7f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602121343.8IGnsS7f-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/pmem.c:407:7: warning: variable 'cxl_nvd' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     407 |                 if (dev->driver) {
         |                     ^~~~~~~~~~~
   drivers/cxl/pmem.c:416:10: note: uninitialized use occurs here
     416 |         cxlmd = cxl_nvd->cxlmd;
         |                 ^~~~~~~
   drivers/cxl/pmem.c:407:3: note: remove the 'if' if its condition is always true
     407 |                 if (dev->driver) {
         |                 ^~~~~~~~~~~~~~~~
   drivers/cxl/pmem.c:399:28: note: initialize the variable 'cxl_nvd' to silence this warning
     399 |         struct cxl_nvdimm *cxl_nvd;
         |                                   ^
         |                                    = NULL
   1 warning generated.


vim +407 drivers/cxl/pmem.c

8fdcb1704f61a8 Dan Williams 2021-06-15  396  
19398821b25a9c Dan Williams 2023-01-20  397  static int detach_nvdimm(struct device *dev, void *data)
19398821b25a9c Dan Williams 2023-01-20  398  {
19398821b25a9c Dan Williams 2023-01-20  399  	struct cxl_nvdimm *cxl_nvd;
5f761998c93e30 Dave Jiang   2026-02-11  400  	struct cxl_memdev *cxlmd;
19398821b25a9c Dan Williams 2023-01-20  401  	bool release = false;
19398821b25a9c Dan Williams 2023-01-20  402  
19398821b25a9c Dan Williams 2023-01-20  403  	if (!is_cxl_nvdimm(dev))
19398821b25a9c Dan Williams 2023-01-20  404  		return 0;
19398821b25a9c Dan Williams 2023-01-20  405  
7f569e917b7866 Li Ming      2024-08-30  406  	scoped_guard(device, dev) {
7f569e917b7866 Li Ming      2024-08-30 @407  		if (dev->driver) {
19398821b25a9c Dan Williams 2023-01-20  408  			cxl_nvd = to_cxl_nvdimm(dev);
19398821b25a9c Dan Williams 2023-01-20  409  			if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
19398821b25a9c Dan Williams 2023-01-20  410  				release = true;
7f569e917b7866 Li Ming      2024-08-30  411  		}
7f569e917b7866 Li Ming      2024-08-30  412  	}
19398821b25a9c Dan Williams 2023-01-20  413  	if (release)
19398821b25a9c Dan Williams 2023-01-20  414  		device_release_driver(dev);
5f761998c93e30 Dave Jiang   2026-02-11  415  
5f761998c93e30 Dave Jiang   2026-02-11  416  	cxlmd = cxl_nvd->cxlmd;
5f761998c93e30 Dave Jiang   2026-02-11  417  	devm_release_action(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);
5f761998c93e30 Dave Jiang   2026-02-11  418  
19398821b25a9c Dan Williams 2023-01-20  419  	return 0;
19398821b25a9c Dan Williams 2023-01-20  420  }
19398821b25a9c Dan Williams 2023-01-20  421  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
