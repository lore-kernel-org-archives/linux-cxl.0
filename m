Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42C7E1
	for <linux-cxl@vger.kernel.org>; Wed, 30 Jul 2025 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866638; cv=none; b=lvB3IfVK/KMUjJB9FHta2Brc+G2WAfjCQ9bRwKn+Ix+/LOBllUX2uAxHzOyh+3EbfX44nJM9cT3LWMVm++//Nge8Ym097XHihqysGWiFy1/JkHTpaiwDTRDmpkdZDPxveQ0hiPlwxAdLVOaztPoOOiFLVvXy1FHd4WEuVHP3bZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866638; c=relaxed/simple;
	bh=a5b4UoGNmRJtxisAJWViJD2hZAnjeHieNa8gZwcxDB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aab7ZIkBxZ6g1Mw97xPZooF7N253qyQ7StL/8Tc4Zpz9ELa8Km6OXhcfT4Vfa2FoT7h8PtxOFaq6Cy/+lutck2ZNMtc5tgRLhVTxSV+Xqj9aR4Zj7ylHEV0ghAKuiq2gu5z063UkW4kIRyjaSUwJESd8yg5ahlf+uxc6ozi9WnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCxQFPLC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCxQFPLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753866637; x=1785402637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a5b4UoGNmRJtxisAJWViJD2hZAnjeHieNa8gZwcxDB0=;
  b=fCxQFPLC5l8SpVz2deOMOaZj4m/lJYs4zXFekaTvz4U33fjeprwyzcB3
   E+1IlGWEioJOzfPmQUgqGcsAioEE3itpKEjKWwwKaZ2w/R4zTSMeuPrj2
   drcbQ/FZruo/b63yfytaWHd+BDglpy17wFDVc3gpzT+Zx/25DFnyph2Da
   lA+DjBqUnOrC8YiOXU+sEsU+Se2BJwbHF7f6zMjGeRGsoDrASsl0uEGC9
   UoIMmW6j6+47anCYCZF2GBil6dFl10GeGJPrMZ+NAOvhMl9mmzWOonCoU
   RWDVrAt4/yel5Y8F6yaEKb9jqf2ufjyOxeV11uWI59epemmTrr4H4R4vL
   A==;
X-CSE-ConnectionGUID: ZEcj7QpwRlComLxvFlJ/1w==
X-CSE-MsgGUID: TDKPlcwKSO2Zhy1XtlkVsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="43764817"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="43764817"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 02:10:36 -0700
X-CSE-ConnectionGUID: JWWdBUwRTQGFSEFvDiMMow==
X-CSE-MsgGUID: W4yfoq5MSuOXxwYDy2hnVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163717254"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jul 2025 02:10:34 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh2pU-0002F6-2U;
	Wed, 30 Jul 2025 09:10:32 +0000
Date: Wed, 30 Jul 2025 17:09:50 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.18/cxl-probe-order 1/4] ld.lld: error: undefined symbol:
 devm_cxl_add_memdev
Message-ID: <202507301656.6Y5x3Dqd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.18/cxl-probe-order
head:   5e29cbd1077b79468339aca04b16e401252b5a24
commit: 158247aaf6d927da3628d27a6799a89c43db1aca [1/4] cxl/mem: Arrange for always-synchronous memdev attach
config: i386-buildonly-randconfig-005-20250730 (https://download.01.org/0day-ci/archive/20250730/202507301656.6Y5x3Dqd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507301656.6Y5x3Dqd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507301656.6Y5x3Dqd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: devm_cxl_add_memdev
   >>> referenced by pci.c
   >>>               drivers/cxl/pci.o:(cxl_pci_probe) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
