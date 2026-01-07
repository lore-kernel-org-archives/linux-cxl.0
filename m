Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2047227BA4
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752557; cv=none; b=VqqIxXD0hsQPjGUXHWpWDgfoqDnIekluFxLhflLNNp0rvUY0r//XvcrdySytRtI5gWfNj/p6ATq9E1hig17/SkDkPi+PAK06fPCO6rsijRiLvVaDCDcxGunHH8Zql+EalI6aJx30GblwaXD1qCWqkzbGIjhOuiV+ZOUsZkA3SeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752557; c=relaxed/simple;
	bh=iA31QYY3ox9Oz5bMskHJLL7gygHIWHB2mVUf8WC/3Ig=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gKvsU04wBtQtltjNdmSJdR7GxKVWBN31SbPj1KaiYJDSLiPQKamM1Wl6ExemaWCTXq3I8nUCwLeZVX1L2WZAbOUeb6oy8BEusMa+SdyuWQsdWgAeNEbTwFVRez0buzWTGYo5Fi1SRYXsnNfIb/WwOuLPQ5TFmuA15hvqvmjT1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rmt2IXo3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rmt2IXo3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767752555; x=1799288555;
  h=date:from:to:cc:subject:message-id;
  bh=iA31QYY3ox9Oz5bMskHJLL7gygHIWHB2mVUf8WC/3Ig=;
  b=Rmt2IXo31pjRJnhX2FYfYagmf0i8orN28Cy4wwavlHkcXhC5w5CcMUyQ
   rxzJm+1XYrJ0qd+265mTa4KpavYIsNdOvuN53JkKMpcUpWWYVZKB4X75l
   1uK5l3SJAIkS4JmhY4LYZ+DAO6M3SSoYNJ9UIUWihhtMRPlgImgYq2JC9
   fe5F/3wc3J+Snhp8tH6j/F6/SR0Umg/Dr+HrM/Jtk+JSBgkjzd0r3ppHk
   PAlmlP+V5eoF6gGxhIje64qYye7gYMg3ynRrwH0H/jXr3W9FDpMuRewgr
   r2tAMV28N3JtEXU0f7H4n9c4kqLU3tL2ibFQV08PAmy70CTC/KyNLPvZS
   Q==;
X-CSE-ConnectionGUID: oybXyf1xQNCn3Vqcax1FRQ==
X-CSE-MsgGUID: Eaa6gs5CTMCDBiPaJGhJog==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="72969429"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="72969429"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 18:22:35 -0800
X-CSE-ConnectionGUID: zfCnjUtCSpaqrig8umqB1g==
X-CSE-MsgGUID: nl14uoCPToyr3ZlSFZOCiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="202815557"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Jan 2026 18:22:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdJBc-000000003O1-2ZIs;
	Wed, 07 Jan 2026 02:22:12 +0000
Date: Wed, 07 Jan 2026 10:21:43 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 88c72bab77aaf389beccf762e112828253ca0564
Message-ID: <202601071033.h89vraK1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 88c72bab77aaf389beccf762e112828253ca0564  cxl/region: fix format string for resource_size_t

elapsed time: 1507m

configs tested: 54
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.1.0
csky          allnoconfig    gcc-15.1.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.1.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
mips         allmodconfig    gcc-15.1.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.1.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc         allnoconfig    gcc-15.1.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
