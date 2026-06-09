Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E040D598
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035844; cv=none; b=Dk2NrxNYA7xTvVmkETgzaBBt13iQ8Hp+v8IGQpIWETtS91af2BL/VXoScSv1K6rCemAijcNUlyxO3d3PbOgkJa7/44QOzC4x2V3dHKeMpaYd23bozRfsU+3ki01kj7sOMfR2EMtn+ITViL3RfOSXPh/RAgWi4VJCP9lOD9K1eAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035844; c=relaxed/simple;
	bh=CxiNd3FHBlZ/8Bgt9cx5ue6PCFi5vIZSXQimovD33lE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gBzWdTAnH5p484ofjolJUUVD6CEe3+GtOMxg2dj0TG5KmqcnvypQ6wEdVSrd2X+u1KCzXeJN+fQaF0UvFJ2d8C7TIiL1HnAsld8xNSezLe2ERnwgGWanpSPLMInikEEXJUutb7y6XPUChKCYL2GSr2Lnm0PFm3u6mxV9eGP2LAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUHmOD8z; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUHmOD8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781035843; x=1812571843;
  h=date:from:to:cc:subject:message-id;
  bh=CxiNd3FHBlZ/8Bgt9cx5ue6PCFi5vIZSXQimovD33lE=;
  b=XUHmOD8zjbSz4aj4yiRfZCI3nuyeVVBrbW+awWya5jqckACpVdjLL1gU
   HyV6TU94DPW/p97NZWxdMqKPexToUx76wUSl7MI1bMMB/9LSBhQD8i5o0
   uhHSB5ehxJoPNHgcL8RfIvIyvoLKWBLJ9VJTEsmk6OaeHtlypSa9+yJPD
   Ugfe32woXMFo4zdYANvaDzTodj8apDtE5Jo0sTI2+0CVyXmoaxT87qq04
   DsWl9z0pu4sHZ79j/7cbCqHQal5B2z0pV7DcqKiMr+f3X+SJQxqWvWOrb
   YyffySLem6QgKwRJGNXY9ku5meOxvuD0zDEpUfpD7GYshgLThpUO0z8cR
   A==;
X-CSE-ConnectionGUID: FAsPJitnSgmC4rJQ096dMg==
X-CSE-MsgGUID: 8Z4S6Zn4Sq6rX8cCBaXv4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81560668"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81560668"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 13:10:43 -0700
X-CSE-ConnectionGUID: 3iC8thE0TNK/RusOLunJxg==
X-CSE-MsgGUID: qynkcvGYQ/+t6WxjH67QIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245817181"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 13:10:41 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wX2mU-00000000KVG-03mE;
	Tue, 09 Jun 2026 20:10:38 +0000
Date: Wed, 10 Jun 2026 04:10:16 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <djbw@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: [cxl:for-7.3/cxl-type2-enabling 5/5] mem.c:undefined
 reference to `cxl_memdev_attach_region'
Message-ID: <202606100401.GOjzpKHo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.3/cxl-type2-enabling
head:   9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686
commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686 [5/5] cxl/region: Introduce devm_cxl_probe_mem()
config: um-randconfig-002-20260609 (https://download.01.org/0day-ci/archive/20260610/202606100401.GOjzpKHo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260610/202606100401.GOjzpKHo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606100401.GOjzpKHo-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: drivers/cxl/mem.o: in function `devm_cxl_probe_mem':
>> mem.c:(.text+0x9f): undefined reference to `cxl_memdev_attach_region'
   collect2: error: ld returned 1 exit status

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_STMFX
   Depends on [n]: HAS_IOMEM [=y] && I2C [=y] && OF [=n]
   Selected by [y]:
   - PINCTRL_STMFX [=y] && PINCTRL [=y] && I2C [=y] && HAS_IOMEM [=y]

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
