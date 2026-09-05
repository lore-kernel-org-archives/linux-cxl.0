Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705D3F3287
	for <linux-cxl@vger.kernel.org>; Sat,  5 Sep 2026 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788592043; cv=none; b=pEb86VXbdaNxnJyC0mkDlOPFdDBcSu/5oILpQmKN/M2Lv1Mts+IlDhBMyohdkiltsqZPCV6XBqlXWKA5JB1D0mDiXs+FW/jwxcSi/AEQp/rcYUkQSfx7eFDlUua9aJWEc9fPvU8rRlu5UuueOWNiEOggvLR/uyRO7EqrhK8BloQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788592043; c=relaxed/simple;
	bh=tlIi+RU+JMLYt4iODh2EMMJnhVPTtG2xWDL4pzjtV0I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nJ85RAhJqpCwSOjNsK2ZjUZtaHd61AQGkEZHWJI7JeM/tR3whbem8vFvxqS7tSE7LA20jo9pc+Cmx4yH/xYljUnyswwMhRiGEpS0qo3XEy3KlLLo0LjNfTERIOyscfvUvC3d5JHAlPwFqedAT3wvLovZqaNYH20L5PWr+fkVoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K44CaBKW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K44CaBKW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788592040; x=1820128040;
  h=date:from:to:cc:subject:message-id;
  bh=tlIi+RU+JMLYt4iODh2EMMJnhVPTtG2xWDL4pzjtV0I=;
  b=K44CaBKWbIuxp1a7vnbnRk7P0Vgc5Vk8hjAvc5xh6kPiR/29pH/4XrkY
   Ukd5K50k18G0SvkxwzCw8n2DrOG171B41709nFFWMAfxj9Yc3dmCk5+gw
   I/a73s3+E7GDJpqOBjnlfdv8XtZOWuQoHjcdbSpcSRoniI2SRsMVHxNz3
   7ix4r2YY9Sc03X/Fxg/BlTgKjEifmoSFkwIpkIB9iDqgKDhvBCR4NobvL
   feM7ui4Nmk+oNi+80sjWZ5l9/j11aXLY85qAZw1l4mjM/KyBkSl6PNqx8
   +4TcWdafog0MYgu7bM/SrQu3JOwI8Yd0dKyDnoWdHbS1OieYbyw0A48d1
   Q==;
X-CSE-ConnectionGUID: vGJlfE3USgWvxJ42mMJdlw==
X-CSE-MsgGUID: LdYYj0fyTiivDTYuMjNnOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="89208298"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="89208298"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:07:16 -0700
X-CSE-ConnectionGUID: tO5bHki9Rf+6E0TNZnpZHA==
X-CSE-MsgGUID: 8YKVqdkIQAWO5ZPfRweQrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="295112491"
Received: from lkp-server01.sh.intel.com (HELO 73f3364bc37e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Sep 2026 00:07:15 -0700
Received: from kbuild by 73f3364bc37e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x2kUa-000000000FH-2s4R;
	Sat, 05 Sep 2026 07:07:12 +0000
Date: Sat, 05 Sep 2026 15:06:13 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Subject: [cxl:next] BUILD SUCCESS
 999811aca000b0d3d1c838c60dc9db7c72eb0c73
Message-ID: <202609051511.c4JJoo4L-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
branch HEAD: 999811aca000b0d3d1c838c60dc9db7c72eb0c73  Merge branch 'for-7.4/cxl-fixes' into cxl-for-next

elapsed time: 876m

configs tested: 63
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-24
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    clang-20
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um           allyesconfig    gcc-14
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
