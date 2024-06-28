Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F15674D
	for <linux-cxl@vger.kernel.org>; Fri, 28 Jun 2024 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553375; cv=none; b=OE3rFljlF1ceKiLZoZD7pYqcjqECN1UVhTWLSdCIlADgN/ewdb0ytGxca1ARfz3kbkOfop9gl0Na9m97/RPdOulLibpF81FEHK6HFbsmJnY+eRBX7IDPKBCzH7qJWaar3G1rE9YH6JuEiVJtZhMl+fJKtFAxYg41QqdyOVSlS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553375; c=relaxed/simple;
	bh=h+TDsGg0KlAVuUxQBIvnzFnbP/shv+Rs/VorkB9amio=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UvihP/8N9avJI4dwM1TBBUmhSXDoBFt/4HwoM3blcRGYXysD9xk3QyAgIPkGBBoK7NIyB5XE4toVQVYd7MB6Bo5uIgkcmnOs3jdThz8L3L9I1etgkY+bv9qLjKM4a+dkidcVrk7ZYhJsKZWnPvAgwS6+3S0ijePJLUz8n6s+xrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bn4xyx0R; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bn4xyx0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719553373; x=1751089373;
  h=date:from:to:cc:subject:message-id;
  bh=h+TDsGg0KlAVuUxQBIvnzFnbP/shv+Rs/VorkB9amio=;
  b=bn4xyx0RQfmNzPDnz9KQbQ8yrP8u7XAhtokjul6VyxAaXUpMVOHGW9PC
   f+gWs7+Vhh0V7FAkPXzdv+EPQs/YDLTup4AH7UO5kXpYro4yBrYByOARz
   capCG/t2a/PmkBKNk5Li0eD3YIi9aYNjZ9OdrR/jBs2/O8rzSfW5YTsAM
   Rz22wvUOLtQk9KpBcXUYF0Y9ri12frkXEA8QznbosRrve7BIpzEvRXhVp
   ucEn5b73AtSJcN+AM8npbbrVFtxJpECFwPDBgtYacWSTs7VQ3EM9pedaE
   NffsGqc5tAgIyvJD6GzWcsjI6UEGmBkmXVFYmm5ix9WW1axpbkrZwlrBO
   g==;
X-CSE-ConnectionGUID: jCrlWXA5QSyJ4RTGhKZxgw==
X-CSE-MsgGUID: ggiiEegiRnm5bFZHFwbX9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27310522"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="27310522"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 22:42:53 -0700
X-CSE-ConnectionGUID: 8B6FG0/iR16wHxVzG9Pd7A==
X-CSE-MsgGUID: 9N9LERnOQcKJ2OAOmlLneg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="49225013"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Jun 2024 22:42:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN4Nl-000GqM-1l;
	Fri, 28 Jun 2024 05:42:49 +0000
Date: Fri, 28 Jun 2024 13:42:16 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 a0f39d51dbf72c28283bd201b97559ed82bc0fe5
Message-ID: <202406281313.fBJI1M2x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: a0f39d51dbf72c28283bd201b97559ed82bc0fe5  cxl: documentation: add missing files to cxl driver-api

elapsed time: 3307m

configs tested: 25
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                              allmodconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
riscv                            allmodconfig   clang-19
riscv                            allyesconfig   clang-19
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
