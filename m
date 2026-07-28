Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907E2D060B
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202204; cv=none; b=EdJ3JqTsimWVn6NNEf08mWM8Oucgr6LKCjmQn3wHliMgRq4I4VtU16HKwApMjTT+dAqihbUO63A6tSekWzKHaX9tYD2gj2iz1rD++welAgUW9aHH0JR95XPN5DCraA9OLeNrIOEoqjCkZQHEo6LbOaVWz/rjIrJVW37ZvMJGnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202204; c=relaxed/simple;
	bh=XZm4dairn1Iw0EoQlhgrByPaBrhi17+y7s3pJ5A037Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=axAbs9cEUyGrkTTM9bO3KYyiWEfAd5fROLpDXLOw8T4ZNJ2TFeQtJJJcFJmUnvT4bhsm9AdIjeZjq1z6J2OTXdQjrU/wHqtWhJdmz6qEIZ8iM+cNbM3H1kdjyswY7iW5u5pCfJpu9c105qWcRjFMZm9toicd1cyYzIZsVs0n6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmWTbhkp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmWTbhkp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785202203; x=1816738203;
  h=date:from:to:cc:subject:message-id;
  bh=XZm4dairn1Iw0EoQlhgrByPaBrhi17+y7s3pJ5A037Q=;
  b=WmWTbhkplEYCGYbKdvBaK75fVktikH90bBC50Msx5UHFNUdisskt0+FF
   AHxEs+nxaWb2AYAbSx2sdjOKE/RjuqtKfIPJZsDLVZPoSIWX9Ps7jOImV
   qJQgS2nnHYKD6Qzj8rIlNZlbqVhkwfZ8QVaHiDSbzZjaEIWQM3BzSkLf1
   f/VI3iRf3njnS9Kc2eV01TFp0/fSfsktSRV9t17BdDlEVEfcM1RsnN4Lc
   /rWyD2gi2RLYqPDG3oaM27woIacFcKJnBgU7M6GXFaCIuFT0FzVttmhVd
   0gVi4WHwyXAcSStbxp0cyWlyynVDbxomLLKv92PQYWycogo/7A8QYWmA8
   A==;
X-CSE-ConnectionGUID: w99FuytaThCFq6b2fKKW3A==
X-CSE-MsgGUID: S1Ec+ltjSp+fA/YJCZE+gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85969048"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85969048"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 18:30:02 -0700
X-CSE-ConnectionGUID: bHWqD48NQs2RRPmJxikJPw==
X-CSE-MsgGUID: TBtXgz/ZR7OLy+yOQBdC4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289530899"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Jul 2026 18:30:01 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woWdq-00000000dnz-2O4Z;
	Tue, 28 Jul 2026 01:29:58 +0000
Date: Tue, 28 Jul 2026 09:29:48 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 f0986e9e6028f746b2ee63efd85a2d13318d6808
Message-ID: <202607280904.6UPLjnIe-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: f0986e9e6028f746b2ee63efd85a2d13318d6808  Merge branch 'for-7.3/cxl-fixes' into cxl-for-next

elapsed time: 3404m

configs tested: 38
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arm            imx_v6_v7_defconfig    clang-24
csky                  allmodconfig    gcc-16.1.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
parisc     randconfig-001-20260728    gcc-10.5.0
parisc     randconfig-002-20260728    gcc-10.5.0
powerpc    randconfig-001-20260728    gcc-10.5.0
powerpc    randconfig-002-20260728    gcc-10.5.0
powerpc64  randconfig-001-20260728    gcc-10.5.0
powerpc64  randconfig-002-20260728    gcc-10.5.0
riscv      randconfig-001-20260728    gcc-14.3.0
riscv      randconfig-002-20260728    gcc-14.3.0
s390       randconfig-001-20260728    gcc-14.3.0
s390       randconfig-002-20260728    gcc-14.3.0
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260728    gcc-14.3.0
sh         randconfig-002-20260728    gcc-14.3.0
sparc               randconfig-001    gcc-11.5.0
sparc      randconfig-001-20260728    gcc-11.5.0
sparc      randconfig-002-20260728    gcc-11.5.0
sparc64    randconfig-001-20260728    gcc-11.5.0
sparc64    randconfig-002-20260728    gcc-11.5.0
um         randconfig-001-20260728    gcc-11.5.0
um         randconfig-002-20260728    gcc-11.5.0
x86_64                       kexec    clang-22
x86_64                rhel-9.4-bpf    gcc-14
xtensa     randconfig-001-20260728    gcc-11.5.0
xtensa     randconfig-002-20260728    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
