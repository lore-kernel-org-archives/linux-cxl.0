Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564E2E36EA
	for <linux-cxl@vger.kernel.org>; Thu, 31 Jul 2025 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753923702; cv=none; b=bJGAR2QXoT5VpObvhsDk5mQuNuDNWLWivtjuh+zDNSt0+SyrVcK+sx58tVqfPSNVYjX7q5faYjZLHmDwQb1Of0BEkr9Nb0DNFfUKpat4GHbronsz3bi+WOf7WXlX3ika/TlMBQPbFDbo/pB/PmcKs+quUkciy9W+N737towwpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753923702; c=relaxed/simple;
	bh=O9+57ca9e/+D7WbkvNImPczCxYrJJ58OkUAqHpQslyU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=olsFW41LyLblmDCw4eUoY4QrIgqRa+5QjoqQ6Psa6gd8q2+DibDvhLnO1jm3sxv7y4FkgBrxB1SDLrZ3OTESwgGKgGVH+S8jsaGW2/9rk1+/QSB5nLBUEg1FvMiyhTAq1DqbH8Bv5S+wqnRljYB+QEKeCKER0Jceh9PeIoe1Nno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfySy73m; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfySy73m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753923699; x=1785459699;
  h=date:from:to:cc:subject:message-id;
  bh=O9+57ca9e/+D7WbkvNImPczCxYrJJ58OkUAqHpQslyU=;
  b=QfySy73mirotWnmiyq9owvYTTipkLHOTl1LCMHrfwbW5XTAEUrP2XSaz
   l8TJXnbJLlbabqAliHHSbrVyVOKKQnZ87HrS9GRF1v0Ym2zvORRJoWEFq
   3a3dJSZY5ilCMsckMj4rZfzqyg1dY7CO4XlLP/xZ1M+wzM3Hajt0SGOhJ
   1nndU2VAIlmog2HP3y2Veld4knzV8wBQM2zrFrGOkoKER4igf7FOf5t3D
   tSJvz+ogFYuKO6LeA/r6peFETF4ZB41ydqC65tisR0yJY7OopIeh2mS1a
   3u//DmtA2Zno1De3VS45YWZuO2p44Vqbsu9Nk0FakW0x0heWwcSfZgVkn
   A==;
X-CSE-ConnectionGUID: hSOzEsRVRjWvABhPd3ox1Q==
X-CSE-MsgGUID: Tgpn1Kq7QSmBQRabwCK6qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56122213"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56122213"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 18:01:37 -0700
X-CSE-ConnectionGUID: sDoJ3DSjReKQA54kkBpX3g==
X-CSE-MsgGUID: A8iTCRZ2T32Gbg9FW0oYFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="167353057"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Jul 2025 18:01:35 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhHfo-0003HQ-29;
	Thu, 31 Jul 2025 01:01:32 +0000
Date: Thu, 31 Jul 2025 09:01:26 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.18/cxl-probe-order] BUILD REGRESSION
 5e29cbd1077b79468339aca04b16e401252b5a24
Message-ID: <202507310946.xH6yARF9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.18/cxl-probe-order
branch HEAD: 5e29cbd1077b79468339aca04b16e401252b5a24  dax/cxl: Defer Soft Reserved registration

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202507301452.Dmrkcrcr-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202507301656.6Y5x3Dqd-lkp@intel.com

    ERROR: modpost: "devm_cxl_add_memdev" [drivers/cxl/cxl_pci.ko] undefined!
    Warning: kernel/resource.c:342 function parameter 'parent' not described in 'find_next_res'
    drivers/cxl/pci.c:1009: undefined reference to `devm_cxl_add_memdev'
    ld.lld: error: undefined symbol: devm_cxl_add_memdev
    pci.c:(.text+0x1130): undefined reference to `devm_cxl_add_memdev'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- alpha-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- alpha-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- alpha-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- alpha-randconfig-r121-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- alpha-randconfig-r131-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arc-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arc-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arc-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arc-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arc-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arc-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arc-randconfig-r113-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-randconfig-003-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-randconfig-004-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-randconfig-004-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm-s3c6400_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-randconfig-003-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-randconfig-003-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-randconfig-004-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-randconfig-004-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- arm64-randconfig-r062-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- csky-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- csky-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- csky-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- csky-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- csky-randconfig-r053-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- csky-randconfig-r112-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- hexagon-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- hexagon-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- hexagon-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- hexagon-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- hexagon-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- hexagon-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-buildonly-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-buildonly-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-buildonly-randconfig-003-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-buildonly-randconfig-004-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-buildonly-randconfig-005-20250730
|   |-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|   `-- ld.lld:error:undefined-symbol:devm_cxl_add_memdev
|-- i386-buildonly-randconfig-006-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-003-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-004-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-005-20250731
|   |-- ERROR:devm_cxl_add_memdev-drivers-cxl-cxl_pci.ko-undefined
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-006-20250731
|   |-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|   `-- drivers-cxl-pci.c:undefined-reference-to-devm_cxl_add_memdev
|-- i386-randconfig-007-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-011-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-012-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-013-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-014-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-015-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-016-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-017-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-051-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-052-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-053-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-054-20250731
|   |-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|   `-- drivers-cxl-pci.c:undefined-reference-to-devm_cxl_add_memdev
|-- i386-randconfig-141-20250730
|   |-- ERROR:devm_cxl_add_memdev-drivers-cxl-cxl_pci.ko-undefined
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- i386-randconfig-141-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- loongarch-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- loongarch-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- loongarch-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- loongarch-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- loongarch-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- loongarch-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- loongarch-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- loongarch-randconfig-r051-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- m68k-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- m68k-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- m68k-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- m68k-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- m68k-randconfig-r061-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- m68k-randconfig-r111-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- m68k-randconfig-r122-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- microblaze-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- microblaze-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- microblaze-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- microblaze-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- mips-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- mips-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- mips-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- mips-ip27_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- mips-randconfig-r053-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- mips-randconfig-r121-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- nios2-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- nios2-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- nios2-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- nios2-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- nios2-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- nios2-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- nios2-randconfig-r061-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- nios2-randconfig-r072-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- openrisc-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- openrisc-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- openrisc-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- openrisc-randconfig-r052-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- openrisc-randconfig-r054-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc-randconfig-r064-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc64-alldefconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- parisc64-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-arches_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-cell_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-gamecube_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-randconfig-003-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-randconfig-r073-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-randconfig-r111-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-stx_gp3_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-taishan_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc-xes_mpc85xx_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc64-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc64-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc64-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc64-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc64-randconfig-003-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc64-randconfig-003-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- powerpc64-randconfig-r121-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- riscv-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- riscv-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- riscv-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- riscv-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- riscv-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- riscv-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- s390-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- s390-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- s390-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- s390-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- s390-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- s390-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- s390-randconfig-r132-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sh-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sh-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sh-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sh-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sh-polaris_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sh-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sh-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sh-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sh-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sh-randconfig-r064-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc-randconfig-r131-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc64-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc64-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc64-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc64-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc64-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- sparc64-randconfig-r063-20250730
|   |-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|   `-- pci.c:(.text):undefined-reference-to-devm_cxl_add_memdev
|-- sparc64-randconfig-r063-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-i386_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-randconfig-r123-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- um-x86_64_defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-allmodconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-allyesconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-buildonly-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-buildonly-randconfig-002-20250730
|   |-- ERROR:devm_cxl_add_memdev-drivers-cxl-cxl_pci.ko-undefined
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-buildonly-randconfig-003-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-buildonly-randconfig-004-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-buildonly-randconfig-005-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-buildonly-randconfig-006-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-defconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-kexec
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-002-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-003-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-004-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-005-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-006-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-007-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-008-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-071-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-072-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-073-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-074-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-075-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-076-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-077-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-078-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-101-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-102-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-103-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-104-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-161-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-161-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-randconfig-r071-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-rhel-9.4
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-rhel-9.4-bpf
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-rhel-9.4-func
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-rhel-9.4-kselftests
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-rhel-9.4-kunit
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- x86_64-rhel-9.4-ltp
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- xtensa-allnoconfig
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- xtensa-randconfig-001-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- xtensa-randconfig-001-20250731
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
|-- xtensa-randconfig-002-20250730
|   `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res
`-- xtensa-randconfig-002-20250731
    `-- Warning:kernel-resource.c-function-parameter-parent-not-described-in-find_next_res

elapsed time: 1211m

configs tested: 245
configs skipped: 7

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250730    gcc-8.5.0
arc                   randconfig-001-20250731    gcc-8.5.0
arc                   randconfig-002-20250730    gcc-14.3.0
arc                   randconfig-002-20250731    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                       imx_v4_v5_defconfig    clang-22
arm                   randconfig-001-20250730    clang-22
arm                   randconfig-001-20250731    gcc-8.5.0
arm                   randconfig-002-20250730    clang-20
arm                   randconfig-002-20250731    gcc-8.5.0
arm                   randconfig-003-20250730    gcc-8.5.0
arm                   randconfig-003-20250731    gcc-8.5.0
arm                   randconfig-004-20250730    gcc-14.3.0
arm                   randconfig-004-20250731    gcc-8.5.0
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250730    clang-22
arm64                 randconfig-001-20250731    gcc-8.5.0
arm64                 randconfig-002-20250730    clang-20
arm64                 randconfig-002-20250731    gcc-8.5.0
arm64                 randconfig-003-20250730    clang-17
arm64                 randconfig-003-20250731    gcc-8.5.0
arm64                 randconfig-004-20250730    clang-22
arm64                 randconfig-004-20250731    gcc-8.5.0
csky                             alldefconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250730    gcc-14.3.0
csky                  randconfig-001-20250731    gcc-13.4.0
csky                  randconfig-002-20250730    gcc-12.5.0
csky                  randconfig-002-20250731    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250730    clang-20
hexagon               randconfig-001-20250731    gcc-13.4.0
hexagon               randconfig-002-20250730    clang-22
hexagon               randconfig-002-20250731    gcc-13.4.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250730    clang-20
i386        buildonly-randconfig-002-20250730    clang-20
i386        buildonly-randconfig-003-20250730    gcc-12
i386        buildonly-randconfig-004-20250730    gcc-12
i386        buildonly-randconfig-005-20250730    clang-20
i386        buildonly-randconfig-006-20250730    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250731    gcc-12
i386                  randconfig-002-20250731    gcc-12
i386                  randconfig-003-20250731    gcc-12
i386                  randconfig-004-20250731    gcc-12
i386                  randconfig-005-20250731    gcc-12
i386                  randconfig-006-20250731    gcc-12
i386                  randconfig-007-20250731    gcc-12
i386                  randconfig-011-20250731    gcc-12
i386                  randconfig-012-20250731    gcc-12
i386                  randconfig-013-20250731    gcc-12
i386                  randconfig-014-20250731    gcc-12
i386                  randconfig-015-20250731    gcc-12
i386                  randconfig-016-20250731    gcc-12
i386                  randconfig-017-20250731    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250730    clang-22
loongarch             randconfig-001-20250731    gcc-13.4.0
loongarch             randconfig-002-20250730    clang-20
loongarch             randconfig-002-20250731    gcc-13.4.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip27_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250730    gcc-11.5.0
nios2                 randconfig-001-20250731    gcc-13.4.0
nios2                 randconfig-002-20250730    gcc-9.5.0
nios2                 randconfig-002-20250731    gcc-13.4.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250730    gcc-14.3.0
parisc                randconfig-001-20250731    gcc-13.4.0
parisc                randconfig-002-20250730    gcc-8.5.0
parisc                randconfig-002-20250731    gcc-13.4.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250730    gcc-8.5.0
powerpc               randconfig-001-20250731    gcc-13.4.0
powerpc               randconfig-002-20250730    gcc-8.5.0
powerpc               randconfig-002-20250731    gcc-13.4.0
powerpc               randconfig-003-20250730    clang-22
powerpc               randconfig-003-20250731    gcc-13.4.0
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc                     taishan_defconfig    clang-17
powerpc                     tqm8548_defconfig    clang-22
powerpc                 xes_mpc85xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250730    clang-22
powerpc64             randconfig-001-20250731    gcc-13.4.0
powerpc64             randconfig-002-20250730    clang-22
powerpc64             randconfig-002-20250731    gcc-13.4.0
powerpc64             randconfig-003-20250730    gcc-10.5.0
powerpc64             randconfig-003-20250731    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250730    gcc-10.5.0
riscv                 randconfig-001-20250731    gcc-14.3.0
riscv                 randconfig-002-20250730    gcc-8.5.0
riscv                 randconfig-002-20250731    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250730    clang-20
s390                  randconfig-001-20250731    gcc-14.3.0
s390                  randconfig-002-20250730    gcc-15.1.0
s390                  randconfig-002-20250731    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20250730    gcc-12.5.0
sh                    randconfig-001-20250731    gcc-14.3.0
sh                    randconfig-002-20250730    gcc-15.1.0
sh                    randconfig-002-20250731    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250730    gcc-14.3.0
sparc                 randconfig-001-20250731    gcc-14.3.0
sparc                 randconfig-002-20250730    gcc-14.3.0
sparc                 randconfig-002-20250731    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250730    clang-22
sparc64               randconfig-001-20250731    gcc-14.3.0
sparc64               randconfig-002-20250730    clang-20
sparc64               randconfig-002-20250731    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250730    gcc-11
um                    randconfig-001-20250731    gcc-14.3.0
um                    randconfig-002-20250730    clang-22
um                    randconfig-002-20250731    gcc-14.3.0
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250730    gcc-12
x86_64      buildonly-randconfig-002-20250730    clang-20
x86_64      buildonly-randconfig-003-20250730    clang-20
x86_64      buildonly-randconfig-004-20250730    clang-20
x86_64      buildonly-randconfig-005-20250730    clang-20
x86_64      buildonly-randconfig-006-20250730    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250731    clang-20
x86_64                randconfig-002-20250731    clang-20
x86_64                randconfig-003-20250731    clang-20
x86_64                randconfig-004-20250731    clang-20
x86_64                randconfig-005-20250731    clang-20
x86_64                randconfig-006-20250731    clang-20
x86_64                randconfig-007-20250731    clang-20
x86_64                randconfig-008-20250731    clang-20
x86_64                randconfig-071-20250731    clang-20
x86_64                randconfig-072-20250731    clang-20
x86_64                randconfig-073-20250731    clang-20
x86_64                randconfig-074-20250731    clang-20
x86_64                randconfig-075-20250731    clang-20
x86_64                randconfig-076-20250731    clang-20
x86_64                randconfig-077-20250731    clang-20
x86_64                randconfig-078-20250731    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250730    gcc-11.5.0
xtensa                randconfig-001-20250731    gcc-14.3.0
xtensa                randconfig-002-20250730    gcc-12.5.0
xtensa                randconfig-002-20250731    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
