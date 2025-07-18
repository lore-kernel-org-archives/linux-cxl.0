Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF8221FDA
	for <linux-cxl@vger.kernel.org>; Fri, 18 Jul 2025 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880992; cv=none; b=IKAMY0YWQ0A7liLWrYft+RoRoUDA9YX6/HPIQlKWGi5dsg8C8mZGeCUyqXMzT2X7/NJASXxe9WBTERzNZFirxD0o/WfDq38LRKysiHCGu4GgZX+ne2fQ5D9XUBBLof1Vctr3Uj0hUtjh9btFM7MKPQrfeW4mFwwxajnIFNzcFsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880992; c=relaxed/simple;
	bh=UOofghNSCi/8rYfacNf7GeXP7989hRoY5O/2jkwhRqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQiL/JlCQ81VhRm1gjlEkDUkhJaR/Tl8oobVfd6munJiaYpVPjAOJ/5GXH/maMC4J94V8v+5LB0+6CFsjnlxa0H5Rag2qnni+4zw1vx4j3fqFg7Z71NEmpthUaWhDWBHuIGwcUB6Shr00sOWdso4EtKKVbQ2DEo5t6IhmYsS4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fl4DRtK3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fl4DRtK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752880991; x=1784416991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UOofghNSCi/8rYfacNf7GeXP7989hRoY5O/2jkwhRqQ=;
  b=Fl4DRtK3QMmyDrdMPpZOfBTI1wTgkw/GHoAIrtbcc+v3jZ8+YPiNkfQG
   IIUkNbbBA3JaXnuuMPmOFNkhOCDi4fCQJJdRdG8bMX3mejbAiDjF7UO8s
   im7L4Hev5l4jTEBT34NTV+pbeePY1pUkazM6+2e/TZvB3EaL3muu1p+g8
   EkIiy31hAJI+PkNPpta1UeGeXNPb39uN/TVwDBauLXxFyKdWzs5fiMhJL
   kiwGDEJPRx/fePt2gSYv1fVuo7KLhjUleqOGdXXgyJHBldhe8BTKR72Dg
   hWQLcEoBmMBovnbyAqD6iwW91HLICca50YXveVPR2rE0D+7r9jNVQWEst
   Q==;
X-CSE-ConnectionGUID: hIFIBYxNQo2CaUaEKD0DsA==
X-CSE-MsgGUID: QS52qmkeSeqCRxrt45Fp1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="42805648"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="42805648"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 16:23:11 -0700
X-CSE-ConnectionGUID: 3y9A+HeZRPOO1qXhoNTgYA==
X-CSE-MsgGUID: 8fsfS01iTqy48ySytytkyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="158873062"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 Jul 2025 16:23:08 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucuPy-000F8F-04;
	Fri, 18 Jul 2025 23:23:06 +0000
Date: Sat, 19 Jul 2025 07:22:59 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
Message-ID: <202507190707.JfYKXyu9-lkp@intel.com>
References: <20250718212452.2100663-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718212452.2100663-1-dave.jiang@intel.com>

Hi Dave,

kernel test robot noticed the following build errors:

[auto build test ERROR on 347e9f5043c89695b01e66b3ed111755afcf1911]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Jiang/cxl-Remove-ifdef-blocks-of-CONFIG_PCIEAER_CXL-from-core-pci-c/20250719-052711
base:   347e9f5043c89695b01e66b3ed111755afcf1911
patch link:    https://lore.kernel.org/r/20250718212452.2100663-1-dave.jiang%40intel.com
patch subject: [PATCH] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
config: riscv-randconfig-001-20250719 (https://download.01.org/0day-ci/archive/20250719/202507190707.JfYKXyu9-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250719/202507190707.JfYKXyu9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507190707.JfYKXyu9-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "cxl_handle_rdport_errors" [drivers/cxl/core/cxl_core.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
