Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012413;
	b=15QYyrQZ8K/6+Ip6aHZaSiJ7SqfFSJqVJKAxORUGBsm3AmfbadC0R7g1Gp+9GdCULoO7
	 w47SnG9Wp3E2x5K/q5eVk3bYuE2tAFAEbqFzelIynecvtp2bVOypwg9CqskSSjuGFqnqx
	 mtjYcXmqHGQ3VLHAbPXMKB2EtSUxo4hrhaw84HMzgqqFZsEpiwQV9Kwz/KaWo//ps/DMI
	 k2kJCS0UXQ7l1UoitvtmyPdmUFy8R2OIOOCVpfpncnAFA5QaeauuwekXGo1jKwnjyk1oH
	 Nt8Rx92BOfTgBbcnjueyMe4ihPQpVINAXI1qovj3ZLy+FHepwdn8kVRUDQ5L++trsmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012413;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=nD/JdX6lbM5R5CQ51SeLJq9cMh8lykX/SJxgaz3FR4Y=;
	b=yxwMByhQ8zYIIY5FdwVOIUwE/evYQSNLsQPlAYqj577fmxC9f6Sxk1BMMcY4l+L3cbg8
	 reBOqCBYmgE+6xMSu5Ew8HEnH4Ii/p5If7xpp6AO9ljqCboKjz40MVnzGhiTB4XQD7Tux
	 9LpCFeMXpdXXwVALCKne62o3dMqTcl9OtJraBnOWyv0dWcCL4HdpH8nBhihRrUlrfk9Y9
	 5LC6Joh7BMfuzKQxYUHBZll1t5eejf/O1ltoZJVmcIZMA6kJFsHeTKcsy6R6Fm2sSsV3m
	 RLu0E0YElIVSfFWpsqocjo1YjQs7dTTc6Jy8s45Fw7J6mhCJP21DjHq8NTCcjltEulg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HBF5rT6C;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C21E606A320
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 14:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C21E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HBF5rT6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795012411; x=1826548411;
  h=date:from:to:cc:subject:message-id;
  bh=fGUtPTiHSgu1DfAvazGZIYI+8hATOA2tq0E3zuJYvQY=;
  b=HBF5rT6CJgvKVOcKf7/ASZsUpaOz4XI4k4Gu0ffvUXqbuSTkFZqS+K8P
   o1VGByHRxtcaknoGYE1ZBxleLiq7tpWAsCPawCe3ZVUEM7gHbdJ138pCN
   EE989DD5DH/o2a+rTvA+qYR8EnX1v28EBE7vKDrpfZEzyTCjunDnnsyte
   uG6hp3Q5ONjV+rnRLGokCw/0taUJcUZ3Y7lM+QlRM+U0YX+oaH20/MxhN
   LIitWj/LFL/FX9L9EDw9sccGx6S4jH+8p4nnydnxEe5yygrT2Jr+Ok3Op
   hhT6fUMTfp7ijY92LfHhWUV8MoxbzoPCVVhXtHzzw0igcXOVP3KNts+hL
   w==;
X-CSE-ConnectionGUID: ktoaqN+cRKKXLfxLLVQb2A==
X-CSE-MsgGUID: DXA2lNJjRgyO0Slvnok21w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3815025"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3815025"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 06:33:30 -0800
X-CSE-ConnectionGUID: Zzdj2UUDR92NkpuJTsTbYg==
X-CSE-MsgGUID: d+q9xcWuTyOm2Er/+DknNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10172110"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Nov 2026 06:33:27 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTgiz-00000001DeI-2QTo;
	Wed, 18 Nov 2026 14:33:25 +0000
Date: Wed, 18 Nov 2026 22:33:04 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
Subject: [cxl:fixes] BUILD SUCCESS
 4c6796e8d018371d8c71c55f75716ab216fb3b9d
Message-ID: <20261118223304.DbNmzSu7-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
branch HEAD: 4c6796e8d018371d8c71c55f75716ab216fb3b9d  cxl/port: Fix endpoint RAS error unmasking

elapsed time: 1415m

configs tested: 795
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261117    gcc-15.3.0
alpha                 randconfig-2000-20261117    gcc-8.5.0
alpha                 randconfig-2000-20261118    gcc-16.2.0
alpha                 randconfig-2001-20261117    gcc-10.5.0
alpha                 randconfig-2001-20261117    gcc-15.3.0
alpha                 randconfig-2001-20261118    gcc-16.2.0
alpha                 randconfig-2200-20261117    gcc-8.5.0  smatch
alpha                 randconfig-2200-20261118    gcc-13.5.0 smatch
alpha                randconfig-r2102-20261117    gcc-13.5.0 cocci
alpha                randconfig-r2105-20261118    gcc-14.4.0 cocci
alpha                randconfig-r2106-20261117    clang-24   cocci
alpha                randconfig-r2107-20261117    gcc-8.5.0  cocci
alpha                randconfig-r2110-20261117    gcc-16.2.0 cocci
alpha                randconfig-r2111-20261117    gcc-16.2.0 cocci
alpha                randconfig-r2111-20261117    gcc-8.5.0  cocci
alpha                randconfig-r2300-20261117    gcc-8.5.0  sparse
alpha                randconfig-r2301-20261117    gcc-12.5.0 sparse
alpha                randconfig-r2301-20261117    gcc-14.4.0 sparse
alpha                randconfig-r2301-20261117    gcc-8.5.0  sparse
alpha                randconfig-r2305-20261117    gcc-8.5.0  sparse
alpha                randconfig-r2309-20261117    gcc-14.4.0 sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261118    gcc-10.5.0
arc                   randconfig-1000-20261118    gcc-16.2.0
arc                   randconfig-1001-20261118    gcc-10.5.0
arc                   randconfig-1001-20261118    gcc-8.5.0
arc                   randconfig-2000-20261117    gcc-12.5.0
arc                   randconfig-2000-20261118    gcc-11.5.0
arc                   randconfig-2001-20261117    gcc-12.5.0
arc                   randconfig-2001-20261117    gcc-14.4.0
arc                   randconfig-2001-20261118    gcc-11.5.0
arc                   randconfig-2002-20261117    gcc-12.5.0
arc                   randconfig-2002-20261117    gcc-16.2.0
arc                   randconfig-2002-20261118    gcc-11.5.0
arc                   randconfig-2003-20261117    gcc-12.5.0
arc                   randconfig-2003-20261117    gcc-8.5.0
arc                   randconfig-2003-20261118    gcc-11.5.0
arc                   randconfig-2004-20261117    gcc-12.5.0
arc                   randconfig-2004-20261117    gcc-16.2.0
arc                   randconfig-2004-20261118    gcc-11.5.0
arc                   randconfig-2005-20261117    gcc-10.5.0
arc                   randconfig-2005-20261117    gcc-12.5.0
arc                   randconfig-2005-20261118    gcc-11.5.0
arc                   randconfig-2200-20261117    gcc-8.5.0  smatch
arc                  randconfig-r2100-20261117    gcc-11.5.0 cocci
arc                  randconfig-r2102-20261117    gcc-14     cocci
arc                  randconfig-r2104-20261118    gcc-14.4.0 cocci
arc                  randconfig-r2108-20261117    gcc-12     cocci
arc                  randconfig-r2111-20261117    gcc-12     cocci
arc                  randconfig-r2301-20261117    gcc-15.3.0 sparse
arc                  randconfig-r2309-20261117    gcc-11.5.0 sparse
arc                         vdk_hs38_defconfig    clang-24
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.2.0
arm                      am200epdkit_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                           gemini_defconfig    gcc-16.2.0
arm                            h3600_defconfig    gcc-16.2.0
arm                           ixp4xx_defconfig    gcc-16.2.0
arm                           moxart_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261118    gcc-10.5.0
arm                   randconfig-1000-20261118    gcc-8.5.0
arm                   randconfig-1001-20261118    gcc-10.5.0
arm                   randconfig-1001-20261118    gcc-8.5.0
arm                   randconfig-1002-20261118    gcc-10.5.0
arm                   randconfig-1003-20261118    gcc-10.5.0
arm                   randconfig-1003-20261118    gcc-8.5.0
arm                   randconfig-2000-20261117    gcc-10.5.0
arm                   randconfig-2001-20261117    gcc-10.5.0
arm                   randconfig-2001-20261117    gcc-12.5.0
arm                   randconfig-2002-20261117    gcc-10.5.0
arm                   randconfig-2200-20261117    clang-24   smatch
arm                   randconfig-2200-20261118    gcc-8.5.0  smatch
arm                  randconfig-r2100-20261117    gcc-13.5.0 cocci
arm                  randconfig-r2102-20261117    gcc-11.5.0 cocci
arm                  randconfig-r2103-20261117    gcc-8.5.0  cocci
arm                  randconfig-r2109-20261117    gcc-16.2.0 cocci
arm                  randconfig-r2109-20261118    clang-17   cocci
arm                  randconfig-r2111-20261117    gcc-16.2.0 cocci
arm                  randconfig-r2302-20261117    gcc-8.5.0  sparse
arm                  randconfig-r2308-20261117    clang-20   sparse
arm                  randconfig-r2308-20261117    gcc-10.5.0 sparse
arm                  randconfig-r2309-20261117    gcc-10.5.0 sparse
arm                          s3c6400_defconfig    clang-24
arm                         spear3xx_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261118    gcc-16.2.0
arm64                 randconfig-1001-20261118    gcc-16.2.0
arm64                 randconfig-1002-20261118    gcc-16.2.0
arm64                 randconfig-1003-20261118    gcc-16.2.0
arm64                 randconfig-2000-20261117    gcc-10.5.0
arm64                 randconfig-2000-20261117    gcc-15.3.0
arm64                 randconfig-2001-20261117    clang-21
arm64                 randconfig-2001-20261117    gcc-10.5.0
arm64                 randconfig-2002-20261117    gcc-10.5.0
arm64                 randconfig-2002-20261117    gcc-15.3.0
arm64                 randconfig-2200-20261117    clang-17   smatch
arm64                 randconfig-2200-20261118    clang-24   smatch
arm64                randconfig-r2103-20261117    gcc-13.5.0 cocci
arm64                randconfig-r2105-20261117    gcc-11.5.0 cocci
arm64                randconfig-r2108-20261117    gcc-16.2.0 cocci
arm64                randconfig-r2300-20261117    clang-22   sparse
arm64                randconfig-r2300-20261117    clang-24   sparse
arm64                randconfig-r2303-20261117    clang-22   sparse
arm64                randconfig-r2303-20261117    gcc-15.3.0 sparse
arm64                randconfig-r2305-20261117    gcc-8.5.0  sparse
arm64                randconfig-r2307-20261117    gcc-11.5.0 sparse
arm64                randconfig-r2307-20261117    gcc-14.4.0 sparse
arm64                randconfig-r2310-20261117    gcc-10.5.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261118    gcc-16.2.0
csky                  randconfig-1001-20261118    gcc-16.2.0
csky                  randconfig-2000-20261117    gcc-16.2.0
csky                  randconfig-2000-20261118    gcc-16.2.0
csky                  randconfig-2001-20261117    gcc-16.2.0
csky                  randconfig-2001-20261118    gcc-16.2.0
csky                  randconfig-2200-20261117    gcc-14.4.0 smatch
csky                  randconfig-2200-20261118    gcc-16.2.0 smatch
csky                 randconfig-r2101-20261118    gcc-14.4.0 cocci
csky                 randconfig-r2107-20261117    clang-24   cocci
csky                 randconfig-r2109-20261117    gcc-16.2.0 cocci
csky                 randconfig-r2300-20261117    gcc-15.3.0 sparse
csky                 randconfig-r2305-20261118    clang-24   sparse
csky                 randconfig-r2306-20261117    gcc-10.5.0 sparse
csky                 randconfig-r2307-20261117    gcc-16.2.0 sparse
csky                 randconfig-r2309-20261117    clang-20   sparse
csky                 randconfig-r2309-20261117    gcc-13.5.0 sparse
csky                 randconfig-r2311-20261117    gcc-10.5.0 sparse
csky                 randconfig-r2311-20261117    gcc-13.5.0 sparse
hexagon                           allmodconfig    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261117    clang-24
hexagon               randconfig-1000-20261118    clang-22
hexagon               randconfig-1001-20261117    clang-17
hexagon               randconfig-1001-20261118    clang-22
hexagon               randconfig-2000-20261117    clang-24
hexagon               randconfig-2000-20261117    gcc-16.2.0
hexagon               randconfig-2000-20261118    gcc-16.2.0
hexagon               randconfig-2001-20261117    clang-17
hexagon               randconfig-2001-20261117    gcc-16.2.0
hexagon               randconfig-2001-20261118    gcc-16.2.0
hexagon               randconfig-2200-20261117    clang-17   smatch
hexagon               randconfig-2200-20261118    clang-20   smatch
hexagon              randconfig-r2106-20261117    gcc-16.2.0 cocci
hexagon              randconfig-r2107-20261118    clang-17   cocci
hexagon              randconfig-r2111-20261117    clang-24   cocci
hexagon              randconfig-r2111-20261117    gcc-16.2.0 cocci
hexagon              randconfig-r2307-20261117    clang-24   sparse
i386                              allmodconfig    clang-22
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261118    gcc-12
i386        buildonly-randconfig-1001-20261118    gcc-12
i386        buildonly-randconfig-1001-20261118    gcc-14
i386        buildonly-randconfig-1002-20261118    clang-22
i386        buildonly-randconfig-1002-20261118    gcc-12
i386        buildonly-randconfig-1003-20261118    gcc-12
i386        buildonly-randconfig-1003-20261118    gcc-14
i386        buildonly-randconfig-1004-20261118    clang-22
i386        buildonly-randconfig-1004-20261118    gcc-12
i386        buildonly-randconfig-1005-20261118    gcc-12
i386        buildonly-randconfig-1005-20261118    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261117    gcc-14
i386                  randconfig-1000-20261118    clang-22
i386                  randconfig-1001-20261117    gcc-14
i386                  randconfig-1001-20261118    clang-22
i386                  randconfig-1002-20261117    clang-22
i386                  randconfig-1002-20261118    clang-22
i386                  randconfig-1003-20261117    clang-22
i386                  randconfig-1003-20261118    clang-22
i386                  randconfig-1004-20261117    clang-22
i386                  randconfig-1004-20261118    clang-22
i386                  randconfig-1005-20261117    clang-22
i386                  randconfig-1005-20261118    clang-22
i386                  randconfig-1006-20261117    gcc-14
i386                  randconfig-1006-20261118    clang-22
i386                  randconfig-1007-20261118    clang-22
i386                  randconfig-1008-20261118    clang-22
i386                  randconfig-1009-20261118    clang-22
i386                  randconfig-1009-20261118    gcc-14
i386                  randconfig-1010-20261118    clang-22
i386                  randconfig-1011-20261118    clang-22
i386                  randconfig-1011-20261118    gcc-14
i386                  randconfig-1012-20261118    clang-22
i386                  randconfig-1013-20261118    clang-22
i386                  randconfig-2000-20261117    clang-22
i386                  randconfig-2000-20261117    gcc-14
i386                  randconfig-2000-20261118    gcc-14
i386                  randconfig-2001-20261117    clang-22
i386                  randconfig-2001-20261118    gcc-14
i386                  randconfig-2002-20261117    clang-22
i386                  randconfig-2002-20261118    gcc-14
i386                  randconfig-2003-20261117    clang-22
i386                  randconfig-2003-20261117    gcc-12
i386                  randconfig-2003-20261118    gcc-14
i386                  randconfig-2004-20261117    clang-22
i386                  randconfig-2004-20261118    gcc-14
i386                  randconfig-2005-20261117    clang-22
i386                  randconfig-2005-20261118    gcc-14
i386                  randconfig-2100-20261117    clang-22   cocci
i386                  randconfig-2100-20261117    gcc-13     cocci
i386                  randconfig-2100-20261118    gcc-14     cocci
i386                  randconfig-2101-20261117    clang-22   cocci
i386                  randconfig-2101-20261117    gcc-14     cocci
i386                  randconfig-2101-20261118    gcc-14     cocci
i386                  randconfig-2102-20261117    clang-22   cocci
i386                  randconfig-2102-20261118    gcc-14     cocci
i386                  randconfig-2103-20261117    clang-22   cocci
i386                  randconfig-2103-20261118    gcc-14     cocci
i386                  randconfig-2104-20261117    clang-22   cocci
i386                  randconfig-2104-20261118    gcc-14     cocci
i386                  randconfig-2105-20261117    clang-22   cocci
i386                  randconfig-2105-20261118    gcc-14     cocci
i386                  randconfig-2200-20261117    gcc-14     smatch
i386                  randconfig-2200-20261118    gcc-13     smatch
i386                  randconfig-2300-20261117    clang-22   sparse
i386                  randconfig-2300-20261118    gcc-14     sparse
i386                  randconfig-2301-20261117    clang-22   sparse
i386                  randconfig-2301-20261117    gcc-13     sparse
i386                  randconfig-2301-20261118    gcc-14     sparse
i386                  randconfig-2302-20261117    clang-22   sparse
i386                  randconfig-2302-20261118    gcc-14     sparse
i386                 randconfig-r2101-20261118    gcc-14     cocci
i386                 randconfig-r2102-20261118    gcc-14     cocci
i386                 randconfig-r2106-20261117    clang-24   cocci
i386                 randconfig-r2110-20261117    clang-24   cocci
i386                 randconfig-r2302-20261117    clang-22   sparse
i386                 randconfig-r2303-20261117    clang-22   sparse
i386                 randconfig-r2305-20261117    clang-22   sparse
i386                 randconfig-r2308-20261117    gcc-10.5.0 sparse
i386                 randconfig-r2309-20261117    gcc-16.2.0 sparse
loongarch                         allmodconfig    clang-19
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261117    clang-24
loongarch             randconfig-1000-20261118    clang-22
loongarch             randconfig-1001-20261117    clang-18
loongarch             randconfig-1001-20261118    clang-22
loongarch             randconfig-2000-20261117    clang-24
loongarch             randconfig-2000-20261117    gcc-8.5.0
loongarch             randconfig-2000-20261118    gcc-11.5.0
loongarch             randconfig-2001-20261117    clang-24
loongarch             randconfig-2001-20261117    gcc-8.5.0
loongarch             randconfig-2001-20261118    gcc-11.5.0
loongarch             randconfig-2200-20261117    gcc-13.5.0 smatch
loongarch             randconfig-2200-20261118    gcc-16.2.0 smatch
loongarch            randconfig-r2103-20261117    gcc-16.2.0 cocci
loongarch            randconfig-r2104-20261117    gcc-8.5.0  cocci
loongarch            randconfig-r2105-20261117    gcc-11.5.0 cocci
loongarch            randconfig-r2106-20261117    gcc-12     cocci
loongarch            randconfig-r2107-20261117    clang-24   cocci
loongarch            randconfig-r2108-20261117    gcc-16.2.0 cocci
loongarch            randconfig-r2109-20261117    clang-24   cocci
loongarch            randconfig-r2109-20261117    gcc-16.2.0 cocci
loongarch            randconfig-r2110-20261117    gcc-12     cocci
loongarch            randconfig-r2300-20261117    gcc-8.5.0  sparse
loongarch            randconfig-r2302-20261117    gcc-8.5.0  sparse
loongarch            randconfig-r2304-20261117    gcc-16.2.0 sparse
loongarch            randconfig-r2306-20261117    gcc-11.5.0 sparse
loongarch            randconfig-r2306-20261117    gcc-16.2.0 sparse
loongarch            randconfig-r2308-20261117    gcc-13.5.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                        m5249evb_defconfig    gcc-16.2.0
m68k                        m5329evb_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261117    gcc-15.3.0
m68k                  randconfig-2000-20261117    gcc-8.5.0
m68k                  randconfig-2000-20261118    gcc-16.2.0
m68k                  randconfig-2001-20261117    gcc-15.3.0
m68k                  randconfig-2001-20261118    gcc-16.2.0
m68k                  randconfig-2200-20261117    gcc-11.5.0 smatch
m68k                  randconfig-2200-20261118    gcc-12.5.0 smatch
m68k                 randconfig-r2100-20261117    gcc-13.5.0 cocci
m68k                 randconfig-r2104-20261117    gcc-13.5.0 cocci
m68k                 randconfig-r2109-20261117    clang-24   cocci
m68k                 randconfig-r2304-20261117    gcc-14.4.0 sparse
m68k                 randconfig-r2306-20261117    gcc-10.5.0 sparse
m68k                 randconfig-r2307-20261117    gcc-10.5.0 sparse
m68k                 randconfig-r2308-20261117    clang-24   sparse
m68k                 randconfig-r2311-20261117    gcc-16.2.0 sparse
m68k                         stmark2_defconfig    clang-24
microblaze                        alldefconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261117    gcc-12.5.0
microblaze            randconfig-2000-20261117    gcc-15.3.0
microblaze            randconfig-2000-20261118    gcc-16.2.0
microblaze            randconfig-2001-20261117    gcc-14.4.0
microblaze            randconfig-2001-20261117    gcc-15.3.0
microblaze            randconfig-2001-20261118    gcc-16.2.0
microblaze            randconfig-2200-20261117    gcc-14.4.0 smatch
microblaze            randconfig-2200-20261118    gcc-13.5.0 smatch
microblaze           randconfig-r2103-20261117    gcc-13.5.0 cocci
microblaze           randconfig-r2106-20261117    gcc-16.2.0 cocci
microblaze           randconfig-r2108-20261117    clang-24   cocci
microblaze           randconfig-r2109-20261117    gcc-16.2.0 cocci
microblaze           randconfig-r2110-20261118    clang-17   cocci
microblaze           randconfig-r2302-20261117    gcc-14.4.0 sparse
microblaze           randconfig-r2304-20261117    gcc-8.5.0  sparse
microblaze           randconfig-r2306-20261117    clang-24   sparse
microblaze           randconfig-r2306-20261117    gcc-14.4.0 sparse
microblaze           randconfig-r2310-20261117    gcc-13.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                         bcm63xx_defconfig    gcc-16.2.0
mips                       bmips_stb_defconfig    gcc-16.2.0
mips                       malta_kvm_defconfig    clang-24
mips                 malta_qemu_32r6_defconfig    clang-24
mips                       pic32mzda_defconfig    gcc-16.2.0
mips                  randconfig-2000-20261117    clang-17
mips                  randconfig-2000-20261117    gcc-16.2.0
mips                  randconfig-2000-20261118    gcc-15.3.0
mips                  randconfig-2001-20261117    gcc-16.2.0
mips                  randconfig-2001-20261117    gcc-8.5.0
mips                  randconfig-2001-20261118    gcc-15.3.0
mips                  randconfig-2002-20261117    clang-24
mips                  randconfig-2002-20261117    gcc-16.2.0
mips                  randconfig-2002-20261118    gcc-15.3.0
mips                  randconfig-2200-20261117    clang-24   smatch
mips                  randconfig-2200-20261118    clang-24   smatch
mips                 randconfig-r2100-20261118    gcc-14.4.0 cocci
mips                 randconfig-r2103-20261117    gcc-11.5.0 cocci
mips                 randconfig-r2110-20261117    gcc-16.2.0 cocci
mips                 randconfig-r2111-20261117    clang-24   cocci
mips                 randconfig-r2310-20261117    clang-24   sparse
mips                 randconfig-r2310-20261117    gcc-10.5.0 sparse
mips                 randconfig-r2311-20261117    clang-24   sparse
mips                          rt305x_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261117    gcc-8.5.0
nios2                 randconfig-1000-20261118    clang-22
nios2                 randconfig-1001-20261117    gcc-11.5.0
nios2                 randconfig-1001-20261118    clang-22
nios2                 randconfig-2000-20261117    gcc-8.5.0
nios2                 randconfig-2000-20261118    gcc-11.5.0
nios2                 randconfig-2001-20261117    gcc-10.5.0
nios2                 randconfig-2001-20261117    gcc-8.5.0
nios2                 randconfig-2001-20261118    gcc-11.5.0
nios2                 randconfig-2200-20261117    gcc-11.5.0 smatch
nios2                 randconfig-2200-20261118    gcc-8.5.0  smatch
nios2                randconfig-r2100-20261117    gcc-8.5.0  cocci
nios2                randconfig-r2101-20261117    gcc-11.5.0 cocci
nios2                randconfig-r2101-20261117    gcc-13.5.0 cocci
nios2                randconfig-r2102-20261117    gcc-13.5.0 cocci
nios2                randconfig-r2108-20261118    clang-17   cocci
nios2                randconfig-r2302-20261117    clang-22   sparse
nios2                randconfig-r2305-20261117    gcc-14.4.0 sparse
nios2                randconfig-r2311-20261117    gcc-10.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-16.2.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.2.0
openrisc                             defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261117    gcc-16.2.0
openrisc              randconfig-2000-20261118    gcc-15.3.0
openrisc              randconfig-2001-20261117    gcc-10.5.0
openrisc              randconfig-2001-20261117    gcc-16.2.0
openrisc              randconfig-2001-20261118    gcc-15.3.0
openrisc              randconfig-2002-20261117    gcc-16.2.0
openrisc              randconfig-2002-20261118    gcc-15.3.0
openrisc              randconfig-2200-20261117    gcc-16.2.0 smatch
openrisc             randconfig-r2109-20261117    clang-24   cocci
openrisc             randconfig-r2110-20261117    clang-24   cocci
openrisc             randconfig-r2111-20261117    clang-24   cocci
openrisc             randconfig-r2306-20261117    gcc-13.5.0 sparse
openrisc             randconfig-r2308-20261117    gcc-14.4.0 sparse
openrisc             randconfig-r2309-20261117    gcc-16.2.0 sparse
openrisc             randconfig-r2310-20261117    clang-20   sparse
openrisc             randconfig-r2310-20261117    clang-24   sparse
parisc                            alldefconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.2.0
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.2.0
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261118    gcc-8.5.0
parisc                randconfig-1001-20261118    gcc-12.5.0
parisc                randconfig-1001-20261118    gcc-8.5.0
parisc                randconfig-2000-20261117    gcc-10.5.0
parisc                randconfig-2000-20261117    gcc-8.5.0
parisc                randconfig-2000-20261118    gcc-11.5.0
parisc                randconfig-2001-20261117    gcc-12.5.0
parisc                randconfig-2001-20261117    gcc-8.5.0
parisc                randconfig-2001-20261118    gcc-11.5.0
parisc                randconfig-2200-20261117    gcc-8.5.0  smatch
parisc               randconfig-r2100-20261118    gcc-14     cocci
parisc               randconfig-r2102-20261117    gcc-8.5.0  cocci
parisc               randconfig-r2102-20261118    gcc-14.4.0 cocci
parisc               randconfig-r2104-20261117    gcc-11.5.0 cocci
parisc               randconfig-r2106-20261117    gcc-16.2.0 cocci
parisc               randconfig-r2109-20261117    gcc-16.2.0 cocci
parisc               randconfig-r2302-20261117    gcc-15.3.0 sparse
parisc               randconfig-r2304-20261117    clang-22   sparse
parisc               randconfig-r2309-20261117    clang-24   sparse
parisc               randconfig-r2310-20261117    gcc-11.5.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.2.0
powerpc                      asp8347_defconfig    clang-24
powerpc                         cell_defconfig    gcc-16.2.0
powerpc                    currituck_defconfig    gcc-16.2.0
powerpc                       katmai_defconfig    clang-24
powerpc                       pasemi_defconfig    clang-24
powerpc                       ppc6xx_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261118    clang-24
powerpc               randconfig-1000-20261118    gcc-8.5.0
powerpc               randconfig-1001-20261118    clang-24
powerpc               randconfig-1001-20261118    gcc-8.5.0
powerpc               randconfig-2000-20261117    gcc-8.5.0
powerpc               randconfig-2000-20261118    clang-21
powerpc               randconfig-2001-20261117    gcc-15.3.0
powerpc               randconfig-2001-20261117    gcc-8.5.0
powerpc               randconfig-2001-20261118    clang-21
powerpc               randconfig-2002-20261117    gcc-13.5.0
powerpc               randconfig-2002-20261117    gcc-8.5.0
powerpc               randconfig-2002-20261118    clang-21
powerpc               randconfig-2200-20261117    gcc-8.5.0  smatch
powerpc               randconfig-2200-20261118    clang-24   smatch
powerpc              randconfig-r2105-20261117    gcc-9.5.0  cocci
powerpc              randconfig-r2106-20261117    clang-24   cocci
powerpc              randconfig-r2111-20261118    clang-17   cocci
powerpc              randconfig-r2301-20261118    clang-24   sparse
powerpc              randconfig-r2305-20261117    gcc-15.3.0 sparse
powerpc              randconfig-r2307-20261117    gcc-13.5.0 sparse
powerpc              randconfig-r2307-20261117    gcc-8.5.0  sparse
powerpc                     socrates_defconfig    gcc-16.2.0
powerpc                      tqm8540_defconfig    clang-24
powerpc                      tqm8555_defconfig    gcc-16.2.0
powerpc                       tqm8xx_defconfig    clang-20
powerpc64             randconfig-1000-20261118    gcc-11.5.0
powerpc64             randconfig-1000-20261118    gcc-8.5.0
powerpc64             randconfig-1001-20261118    clang-24
powerpc64             randconfig-1001-20261118    gcc-8.5.0
powerpc64             randconfig-2000-20261117    gcc-8.5.0
powerpc64             randconfig-2000-20261118    clang-21
powerpc64             randconfig-2001-20261117    gcc-8.5.0
powerpc64             randconfig-2001-20261118    clang-21
powerpc64             randconfig-2002-20261117    clang-19
powerpc64             randconfig-2002-20261117    gcc-8.5.0
powerpc64             randconfig-2002-20261118    clang-21
powerpc64             randconfig-2200-20261117    gcc-8.5.0  smatch
powerpc64             randconfig-2200-20261118    clang-24   smatch
powerpc64            randconfig-r2107-20261117    gcc-16.2.0 cocci
powerpc64            randconfig-r2108-20261117    clang-24   cocci
powerpc64            randconfig-r2110-20261117    clang-24   cocci
powerpc64            randconfig-r2301-20261117    clang-22   sparse
powerpc64            randconfig-r2301-20261117    gcc-15.3.0 sparse
powerpc64            randconfig-r2308-20261117    gcc-11.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.2.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                     nommu_k210_defconfig    clang-24
riscv                 randconfig-1000-20261118    gcc-11.5.0
riscv                 randconfig-1001-20261118    gcc-11.5.0
riscv                 randconfig-2000-20261117    gcc-11.5.0
riscv                 randconfig-2000-20261117    gcc-8.5.0
riscv                 randconfig-2000-20261118    gcc-8.5.0
riscv                 randconfig-2001-20261117    clang-18
riscv                 randconfig-2001-20261117    gcc-11.5.0
riscv                 randconfig-2001-20261118    gcc-8.5.0
riscv                 randconfig-2002-20261117    clang-24
riscv                 randconfig-2002-20261117    gcc-11.5.0
riscv                 randconfig-2002-20261118    gcc-8.5.0
riscv                 randconfig-2003-20261117    gcc-11.5.0
riscv                 randconfig-2003-20261118    gcc-8.5.0
riscv                 randconfig-2004-20261117    clang-17
riscv                 randconfig-2004-20261117    gcc-11.5.0
riscv                 randconfig-2004-20261118    gcc-8.5.0
riscv                 randconfig-2005-20261117    clang-24
riscv                 randconfig-2005-20261117    gcc-11.5.0
riscv                 randconfig-2005-20261118    gcc-8.5.0
riscv                 randconfig-2200-20261117    clang-24   smatch
riscv                 randconfig-2200-20261118    clang-24   smatch
riscv                randconfig-r2104-20261117    gcc-11.5.0 cocci
riscv                randconfig-r2108-20261117    gcc-16.2.0 cocci
riscv                randconfig-r2300-20261117    gcc-15.3.0 sparse
riscv                randconfig-r2301-20261117    gcc-8.5.0  sparse
riscv                randconfig-r2303-20261118    clang-24   sparse
riscv                randconfig-r2310-20261117    gcc-14.4.0 sparse
riscv                randconfig-r2311-20261117    clang-20   sparse
s390                              allmodconfig    clang-17
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    clang-18
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261118    gcc-11.5.0
s390                  randconfig-1001-20261118    gcc-11.5.0
s390                  randconfig-2000-20261117    gcc-13.5.0
s390                  randconfig-2000-20261117    gcc-15.3.0
s390                  randconfig-2000-20261118    clang-24
s390                  randconfig-2001-20261117    clang-24
s390                  randconfig-2001-20261117    gcc-15.3.0
s390                  randconfig-2001-20261118    clang-24
s390                  randconfig-2002-20261117    clang-17
s390                  randconfig-2002-20261117    gcc-15.3.0
s390                  randconfig-2002-20261118    clang-24
s390                  randconfig-2003-20261117    clang-24
s390                  randconfig-2003-20261117    gcc-15.3.0
s390                  randconfig-2003-20261118    clang-24
s390                  randconfig-2004-20261117    gcc-15.3.0
s390                  randconfig-2004-20261117    gcc-8.5.0
s390                  randconfig-2004-20261118    clang-24
s390                  randconfig-2005-20261117    gcc-15.3.0
s390                  randconfig-2005-20261118    clang-24
s390                  randconfig-2200-20261117    gcc-11.5.0 smatch
s390                  randconfig-2200-20261118    gcc-8.5.0  smatch
s390                 randconfig-r2103-20261117    gcc-11.5.0 cocci
s390                 randconfig-r2107-20261117    gcc-16.2.0 cocci
s390                 randconfig-r2300-20261117    clang-22   sparse
s390                 randconfig-r2303-20261117    gcc-8.5.0  sparse
s390                        zfcpdump_defconfig    clang-24
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.2.0
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                                   defconfig    gcc-16.2.0
sh                         edosk7760_defconfig    gcc-16.2.0
sh                           landisk_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261118    gcc-11.5.0
sh                    randconfig-1001-20261118    gcc-11.5.0
sh                    randconfig-2000-20261117    gcc-14.4.0
sh                    randconfig-2000-20261117    gcc-16.2.0
sh                    randconfig-2000-20261118    gcc-9.5.0
sh                    randconfig-2001-20261117    gcc-14.4.0
sh                    randconfig-2001-20261117    gcc-16.2.0
sh                    randconfig-2001-20261118    gcc-9.5.0
sh                    randconfig-2002-20261117    gcc-14.4.0
sh                    randconfig-2002-20261117    gcc-16.2.0
sh                    randconfig-2002-20261118    gcc-9.5.0
sh                    randconfig-2003-20261117    gcc-10.5.0
sh                    randconfig-2003-20261117    gcc-14.4.0
sh                    randconfig-2003-20261118    gcc-9.5.0
sh                    randconfig-2004-20261117    gcc-12.5.0
sh                    randconfig-2004-20261117    gcc-14.4.0
sh                    randconfig-2004-20261118    gcc-9.5.0
sh                    randconfig-2005-20261117    gcc-14.4.0
sh                    randconfig-2005-20261118    gcc-9.5.0
sh                    randconfig-2200-20261117    gcc-16.2.0 smatch
sh                    randconfig-2200-20261118    gcc-13.5.0 smatch
sh                   randconfig-r2105-20261117    gcc-8.5.0  cocci
sh                   randconfig-r2106-20261117    gcc-16.2.0 cocci
sh                   randconfig-r2107-20261117    gcc-16.2.0 cocci
sh                   randconfig-r2108-20261117    clang-24   cocci
sh                   randconfig-r2109-20261117    gcc-16.2.0 cocci
sh                   randconfig-r2300-20261117    gcc-14.4.0 sparse
sh                   randconfig-r2300-20261118    clang-24   sparse
sh                   randconfig-r2303-20261117    gcc-14.4.0 sparse
sh                   randconfig-r2304-20261117    gcc-8.5.0  sparse
sh                   randconfig-r2307-20261117    gcc-10.5.0 sparse
sh                   randconfig-r2308-20261117    gcc-16.2.0 sparse
sh                           rsk7201_defconfig    gcc-16.2.0
sh                           rsk7269_defconfig    clang-24
sh                              sh03_defconfig    clang-24
sh                             titan_defconfig    gcc-16.2.0
sh                           urquell_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.2.0
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261118    gcc-16.2.0
sparc                 randconfig-1001-20261118    gcc-16.2.0
sparc                 randconfig-2000-20261117    gcc-14
sparc                 randconfig-2000-20261117    gcc-16.2.0
sparc                 randconfig-2000-20261118    clang-24
sparc                 randconfig-2001-20261117    gcc-14
sparc                 randconfig-2001-20261117    gcc-14.4.0
sparc                 randconfig-2001-20261118    clang-24
sparc                 randconfig-2200-20261117    gcc-14.4.0 smatch
sparc                 randconfig-2200-20261118    gcc-13.5.0 smatch
sparc                randconfig-r2101-20261117    gcc-13.5.0 cocci
sparc                randconfig-r2101-20261117    gcc-16.2.0 cocci
sparc                randconfig-r2108-20261117    gcc-16.2.0 cocci
sparc                randconfig-r2110-20261117    gcc-11.5.0 cocci
sparc                randconfig-r2111-20261117    gcc-16.2.0 cocci
sparc                randconfig-r2311-20261117    gcc-11.5.0 sparse
sparc                randconfig-r2311-20261117    gcc-14.4.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261118    gcc-16.2.0
sparc64               randconfig-1001-20261118    gcc-16.2.0
sparc64               randconfig-2000-20261117    clang-24
sparc64               randconfig-2000-20261117    gcc-14
sparc64               randconfig-2000-20261118    clang-24
sparc64               randconfig-2001-20261117    gcc-14
sparc64               randconfig-2001-20261117    gcc-8.5.0
sparc64               randconfig-2001-20261118    clang-24
sparc64               randconfig-2200-20261117    gcc-8.5.0  smatch
sparc64               randconfig-2200-20261118    clang-22   smatch
sparc64              randconfig-r2100-20261117    gcc-8.5.0  cocci
sparc64              randconfig-r2101-20261117    gcc-14     cocci
sparc64              randconfig-r2104-20261117    gcc-14     cocci
sparc64              randconfig-r2104-20261118    gcc-14     cocci
sparc64              randconfig-r2105-20261117    gcc-14     cocci
sparc64              randconfig-r2111-20261117    clang-24   cocci
sparc64              randconfig-r2111-20261117    gcc-16.2.0 cocci
sparc64              randconfig-r2302-20261117    gcc-15.3.0 sparse
sparc64              randconfig-r2302-20261118    clang-24   sparse
sparc64              randconfig-r2304-20261117    gcc-15.3.0 sparse
sparc64              randconfig-r2306-20261117    clang-20   sparse
sparc64              randconfig-r2307-20261117    clang-20   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261118    gcc-16.2.0
um                    randconfig-1001-20261118    gcc-16.2.0
um                    randconfig-2000-20261117    gcc-14
um                    randconfig-2000-20261118    clang-24
um                    randconfig-2001-20261117    gcc-14
um                    randconfig-2001-20261118    clang-24
um                    randconfig-2200-20261117    clang-21   smatch
um                    randconfig-2200-20261118    clang-24   smatch
um                   randconfig-r2100-20261117    gcc-14     cocci
um                   randconfig-r2102-20261117    gcc-14     cocci
um                   randconfig-r2103-20261117    gcc-14     cocci
um                   randconfig-r2103-20261118    gcc-14.4.0 cocci
um                   randconfig-r2104-20261117    clang-18   cocci
um                   randconfig-r2106-20261118    clang-17   cocci
um                   randconfig-r2107-20261117    clang-24   cocci
um                   randconfig-r2301-20261117    clang-22   sparse
um                   randconfig-r2302-20261117    gcc-14     sparse
um                   randconfig-r2303-20261117    gcc-8.5.0  sparse
um                   randconfig-r2306-20261117    gcc-14     sparse
um                   randconfig-r2310-20261117    gcc-16.2.0 sparse
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261118    gcc-14
x86_64      buildonly-randconfig-1001-20261118    gcc-12
x86_64      buildonly-randconfig-1001-20261118    gcc-14
x86_64      buildonly-randconfig-1002-20261118    gcc-12
x86_64      buildonly-randconfig-1002-20261118    gcc-14
x86_64      buildonly-randconfig-1003-20261118    clang-22
x86_64      buildonly-randconfig-1003-20261118    gcc-14
x86_64      buildonly-randconfig-1004-20261118    gcc-14
x86_64      buildonly-randconfig-1005-20261118    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261117    clang-22
x86_64                randconfig-1000-20261118    gcc-14
x86_64                randconfig-1001-20261117    clang-22
x86_64                randconfig-1001-20261118    gcc-14
x86_64                randconfig-1002-20261117    gcc-14
x86_64                randconfig-1002-20261118    gcc-14
x86_64                randconfig-1003-20261117    clang-22
x86_64                randconfig-1003-20261118    gcc-14
x86_64                randconfig-1004-20261117    gcc-14
x86_64                randconfig-1004-20261118    gcc-14
x86_64                randconfig-1005-20261117    gcc-14
x86_64                randconfig-1005-20261118    gcc-14
x86_64                randconfig-1006-20261118    gcc-14
x86_64                randconfig-1007-20261118    gcc-14
x86_64                randconfig-1008-20261118    gcc-14
x86_64                randconfig-1009-20261118    gcc-14
x86_64                randconfig-1010-20261118    gcc-14
x86_64                randconfig-1011-20261118    gcc-14
x86_64                randconfig-1012-20261118    gcc-14
x86_64                randconfig-1013-20261118    gcc-14
x86_64                randconfig-1014-20261118    gcc-14
x86_64                randconfig-1015-20261118    gcc-14
x86_64                randconfig-1016-20261118    gcc-14
x86_64                randconfig-1017-20261118    gcc-14
x86_64                randconfig-2000-20261117    clang-22
x86_64                randconfig-2000-20261117    gcc-14
x86_64                randconfig-2000-20261118    gcc-13
x86_64                randconfig-2001-20261117    gcc-14
x86_64                randconfig-2001-20261118    gcc-13
x86_64                randconfig-2002-20261117    gcc-14
x86_64                randconfig-2002-20261118    gcc-13
x86_64                randconfig-2003-20261117    clang-22
x86_64                randconfig-2003-20261117    gcc-14
x86_64                randconfig-2003-20261118    gcc-13
x86_64                randconfig-2004-20261117    gcc-14
x86_64                randconfig-2004-20261118    gcc-13
x86_64                randconfig-2005-20261117    gcc-14
x86_64                randconfig-2005-20261118    gcc-13
x86_64                randconfig-2100-20261117    gcc-14     cocci
x86_64                randconfig-2100-20261118    clang-22   cocci
x86_64                randconfig-2101-20261117    gcc-14     cocci
x86_64                randconfig-2101-20261118    clang-22   cocci
x86_64                randconfig-2102-20261117    clang-22   cocci
x86_64                randconfig-2102-20261117    gcc-14     cocci
x86_64                randconfig-2102-20261118    clang-22   cocci
x86_64                randconfig-2103-20261117    clang-22   cocci
x86_64                randconfig-2103-20261117    gcc-14     cocci
x86_64                randconfig-2103-20261118    clang-22   cocci
x86_64                randconfig-2104-20261117    clang-22   cocci
x86_64                randconfig-2104-20261117    gcc-14     cocci
x86_64                randconfig-2104-20261118    clang-22   cocci
x86_64                randconfig-2105-20261117    clang-22   cocci
x86_64                randconfig-2105-20261117    gcc-14     cocci
x86_64                randconfig-2105-20261118    clang-22   cocci
x86_64                randconfig-2200-20261117    gcc-14     smatch
x86_64                randconfig-2200-20261118    clang-22   smatch
x86_64                randconfig-2300-20261117    clang-22   sparse
x86_64                randconfig-2300-20261118    gcc-14     sparse
x86_64                randconfig-2301-20261117    clang-22   sparse
x86_64                randconfig-2301-20261117    gcc-14     sparse
x86_64                randconfig-2301-20261118    gcc-14     sparse
x86_64                randconfig-2302-20261117    clang-22   sparse
x86_64                randconfig-2302-20261118    gcc-14     sparse
x86_64               randconfig-r2101-20261117    gcc-11.5.0 cocci
x86_64               randconfig-r2101-20261117    gcc-8.5.0  cocci
x86_64               randconfig-r2102-20261117    gcc-11.5.0 cocci
x86_64               randconfig-r2103-20261118    gcc-14     cocci
x86_64               randconfig-r2107-20261117    clang-24   cocci
x86_64               randconfig-r2109-20261117    gcc-12     cocci
x86_64               randconfig-r2304-20261117    gcc-15.3.0 sparse
x86_64               randconfig-r2309-20261117    gcc-10.5.0 sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.2.0
xtensa                            allyesconfig    clang-20
xtensa                            allyesconfig    gcc-16.2.0
xtensa                randconfig-1000-20261118    gcc-16.2.0
xtensa                randconfig-1001-20261118    gcc-16.2.0
xtensa                randconfig-2000-20261117    gcc-14.4.0
xtensa                randconfig-2000-20261117    gcc-16.2.0
xtensa                randconfig-2000-20261118    gcc-16.2.0
xtensa                randconfig-2001-20261117    gcc-12.5.0
xtensa                randconfig-2001-20261117    gcc-16.2.0
xtensa                randconfig-2001-20261118    gcc-16.2.0
xtensa                randconfig-2200-20261117    gcc-8.5.0  smatch
xtensa               randconfig-r2100-20261117    gcc-11.5.0 cocci
xtensa               randconfig-r2104-20261117    gcc-13.5.0 cocci
xtensa               randconfig-r2105-20261117    gcc-13.5.0 cocci
xtensa               randconfig-r2105-20261118    gcc-14     cocci
xtensa               randconfig-r2106-20261117    gcc-16.2.0 cocci
xtensa               randconfig-r2107-20261117    gcc-12     cocci
xtensa               randconfig-r2107-20261117    gcc-16.2.0 cocci
xtensa               randconfig-r2108-20261117    gcc-11.5.0 cocci
xtensa               randconfig-r2108-20261117    gcc-16.2.0 cocci
xtensa               randconfig-r2110-20261117    gcc-16.2.0 cocci
xtensa               randconfig-r2304-20261117    clang-22   sparse
xtensa               randconfig-r2304-20261118    clang-24   sparse
xtensa               randconfig-r2305-20261117    gcc-8.5.0  sparse
xtensa               randconfig-r2308-20261117    gcc-13.5.0 sparse
xtensa               randconfig-r2311-20261117    clang-24   sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
