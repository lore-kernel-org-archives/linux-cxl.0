Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD32360EFF
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030679; cv=none; b=aCfJtJLi7MCeF6jUuIOKE+TOG08DOAIcVIMUAwEk5yYHojBpOujO1+MBxoVzxwOQIGZ1RnjUU5tLPhgaR6XaHsviVz5Q9VJsQuQeCxD4PkeFrcqF6uYVaJFQIF7jVmLx5kgfpCR7qotHpSlwA8BhpVIHwzWgODB4g8k5WW4u7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030679; c=relaxed/simple;
	bh=E0T9B6iRfL4m2DwBmD7KhHWbCh/A2Ttarazh+eo3n54=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k2WRdkuRCGdjO2Xl1AFpYE6KTZ3nOEKTU8pUxQy1GqlnvevLQDksll/5IIg1TK0FCzZpGrkij9lQHw7rquu68GLW3r2bmIQV5CGEzLbS0smO4EAwRuiG5xXUkAChkpx8uA/NX3FaUR2SL4s+Koivxq2iZRYZNHPFBeonyKr6fBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xcoogfs4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xcoogfs4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781030679; x=1812566679;
  h=date:from:to:cc:subject:message-id;
  bh=E0T9B6iRfL4m2DwBmD7KhHWbCh/A2Ttarazh+eo3n54=;
  b=Xcoogfs4N9T+EDS6+5JfTNPtpCn4oOl4myyyFqSaS2ZUS+aVcaFJODIS
   ma6rVS2DvwS+rEDOjNuqnCLSDN057u//rPfEiybJKalm8APDHqbeKkiLu
   XSDSNfYgqmEViVJOA8Fp7fU86eQQwzTDGHiOVIvD0HAtgqeyAj37TO4t/
   vMr06iW7/EYWJEv7A3wMj8hxf8SW6UYwwcrXQ//bC5aEdhSKewtXcyHuS
   IcOoLrN7W9s97jMeW68dEGle3UFzLfSG6hmyW1UzUHS1hpdUJ+ti+DHQH
   LIBsskVU7nXVbAjOX592vTXr1aio0+SmEAPrCe2fYz7RVJuqeAN3WLlbA
   A==;
X-CSE-ConnectionGUID: aRaIseLLQzeHrbVqQGIcOQ==
X-CSE-MsgGUID: 57RqIb80StqC2kRes4u0wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="104471526"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="104471526"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:44:38 -0700
X-CSE-ConnectionGUID: bYxm0/ddT8ShE816GSHk0g==
X-CSE-MsgGUID: UiEJVtHmQeCB/Ki284r+Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="247797032"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Jun 2026 11:44:35 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wX1RA-00000000KRe-3lP9;
	Tue, 09 Jun 2026 18:44:32 +0000
Date: Wed, 10 Jun 2026 02:44:10 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <djbw@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: [cxl:for-7.3/cxl-type2-enabling 5/5] ld.lld: error:
 undefined symbol: cxl_memdev_attach_region
Message-ID: <202606100235.1ur3Z4YQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-7.3/cxl-type2-enabling
head:   9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686
commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686 [5/5] cxl/region: Introduce devm_cxl_probe_mem()
config: i386-buildonly-randconfig-004-20260609 (https://download.01.org/0day-ci/archive/20260610/202606100235.1ur3Z4YQ-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260610/202606100235.1ur3Z4YQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606100235.1ur3Z4YQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: cxl_memdev_attach_region
   >>> referenced by mem.c:227 (drivers/cxl/mem.c:227)
   >>>               drivers/cxl/mem.o:(devm_cxl_probe_mem) in archive vmlinux.a

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
