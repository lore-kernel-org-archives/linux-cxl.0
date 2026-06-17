Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2237F735
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jun 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709900; cv=none; b=q9g+/v3pW31MdkvaCYDdNB2AP8kdu67QD/i6x5hTPNjOs+KWlf2ynuNaYMPCTC1mrVZKBXgrBpLLgQ03mgmkhHcpDVeHsEbv8pQ2/MWms+akFPMu+gDr7vqu6JXFQ3DAyVmqp+BiwI2RJ7q/hooQwIsbJqAp5DS4hN3sOO0ufrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709900; c=relaxed/simple;
	bh=1amRvsYCv6nvYrlnejddFl2I3r49QkddWCNLd9Tyrrw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F7tLhQoHpIBD/p8FSGeQqLaR80AczvunRmTPn65Dsbwtafnsy7qav9jY7bsUSPN1NP0NzMoDEQjC/KHBvSPlolV0u8zWfcWzTM17Pzdt50+6j4A2ZByKqnIEQ01HNW6gCR8SKMA9KDJMv2i7qm2OtQkDYgk9qYL8dEtTjjt3p/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0sYhnl4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0sYhnl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781709898; x=1813245898;
  h=date:from:to:cc:subject:message-id;
  bh=1amRvsYCv6nvYrlnejddFl2I3r49QkddWCNLd9Tyrrw=;
  b=e0sYhnl4m75bIhZGuQi+nyOrJ+n5e4MaOPBKc6uxYw9clWPVpFpQ04Kz
   G8Se+9rwa1Rmpjgu8kb6KQZCDJ+M9VhMrsdMTwGUUDbzx4xlWcwuSnVsN
   Qawti22lTQT3m/hFzPePhpHSbeQ45tdFGppoYr/E+Gk7ww3Im94DBs/Nq
   7Hce7bJaO1pBqwwlqznQyW/uJSwuXYgjut15ya2Wz2ZvMZkvhspQTQoGq
   xR0tudzg45cP2O3EvoB5GMcMz/o+N07owkDgz1nBc1rMFiDMW/CJ+S8UJ
   n2gpunvTa/pMKTL+vmhPm+BCm2271tpEVkWEtnyIrotKyZNWExPt+1h16
   Q==;
X-CSE-ConnectionGUID: ONAqKvUJQsSu4fhDnc91ZA==
X-CSE-MsgGUID: v/b9zcwjQJGxl+VuHPqfBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93625056"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93625056"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:24:57 -0700
X-CSE-ConnectionGUID: uekydynHSW2CvEpySJDNJQ==
X-CSE-MsgGUID: 2s4qV2SIRv257WBeFqYECQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="249989741"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Jun 2026 08:24:56 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZs8K-00000000UfG-2PD7;
	Wed, 17 Jun 2026 15:24:52 +0000
Date: Wed, 17 Jun 2026 23:24:43 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Subject: [cxl:for-7.2/cxl-pci-fixes] BUILD SUCCESS
 26aa60e0276272ae61b843a05a91748dcb1130f9
Message-ID: <202606172330.tAsCWwss-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.2/cxl-pci-fixes
branch HEAD: 26aa60e0276272ae61b843a05a91748dcb1130f9  cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses

elapsed time: 18250m

configs tested: 35
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha        allnoconfig    gcc-16.1.0
arc         allmodconfig    gcc-16.1.0
arc          allnoconfig    gcc-16.1.0
arc         allyesconfig    gcc-16.1.0
arm          allnoconfig    clang-23
arm64        allnoconfig    gcc-16.1.0
csky        allmodconfig    gcc-16.1.0
csky         allnoconfig    gcc-16.1.0
hexagon      allnoconfig    clang-23
i386         allnoconfig    gcc-14
loongarch    allnoconfig    clang-20
m68k        allmodconfig    gcc-16.1.0
m68k         allnoconfig    gcc-16.1.0
m68k        allyesconfig    gcc-16.1.0
microblaze   allnoconfig    gcc-16.1.0
microblaze  allyesconfig    gcc-16.1.0
mips         allnoconfig    gcc-16.1.0
mips        allyesconfig    gcc-16.1.0
nios2       allmodconfig    gcc-11.5.0
nios2        allnoconfig    gcc-11.5.0
openrisc    allmodconfig    gcc-16.1.0
openrisc     allnoconfig    gcc-16.1.0
parisc       allnoconfig    gcc-16.1.0
parisc      allyesconfig    gcc-16.1.0
powerpc      allnoconfig    gcc-16.1.0
riscv        allnoconfig    gcc-16.1.0
s390         allnoconfig    clang-23
sh          allmodconfig    gcc-16.1.0
sh           allnoconfig    gcc-16.1.0
sh          allyesconfig    gcc-16.1.0
sparc        allnoconfig    gcc-16.1.0
sparc64     allmodconfig    clang-20
um           allnoconfig    clang-16
x86_64       allnoconfig    clang-22
xtensa       allnoconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
