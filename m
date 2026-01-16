Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514620C00C
	for <linux-cxl@vger.kernel.org>; Fri, 16 Jan 2026 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768541084; cv=none; b=QW833Sqtbe6A2qnEglnnTjdM2WsQmFhxQOTYttoncoBHACozwOvDIfCbvdnpmckYoWpGjxNOEpbZrLejxZNqxMX7puLddPEb+WzX7gwA/UfA5rtAUJEDZuoDe7B6TB5bi5oMl0YN2EsA0byqIJeOm6TQe8iLkP2g1i4ktkj7M2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768541084; c=relaxed/simple;
	bh=5YPf87ZGuinlRtituBGIhNcQxgeYz4Tr1NAjaf4vQgI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hkVo5iCVWLg/lEdNbqxj0gJtwewPCz/UYaidIKpCcQQdCvTCUFU4/qsnsWDIv6t6EfY+3xvF3oNyVLM+eyI2DMBqGVXq201FJzcZwBWXB/GpXA9yunpdDpcnvG/li9HxRJkTXSftOO42Jhy0Q50N7bNy/zmy+SYnbl62GZcxdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqti4aJp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqti4aJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768541082; x=1800077082;
  h=date:from:to:cc:subject:message-id;
  bh=5YPf87ZGuinlRtituBGIhNcQxgeYz4Tr1NAjaf4vQgI=;
  b=iqti4aJp9e4PLli7N0eSZOauj8b7rbr9Fv52JjrJWkdv15U5/bc0DTAa
   0Bc4AQSbqkte7Y2mdzVVwSvzcs8vvwfdcnNZIczNDt2QmZGINpVq4sYHr
   y0FmrUsV9YOcquxSfXkeulkEl0hzR+roY9sjEjV8uEZ7oPZh5Zo2AMQRR
   h6IrjnPFNbZ2jy9W07hyFVKNBeQMZ7RbEAbvfO0JTHtkBZRLB2yYtlg60
   DNQOW59YQ+DW8f28Vbhgc+DC81Q9713Ag41pbPFNUDp2zf+4jCwv5EtrD
   ger2OIeMD/Ohjc1GVXrQeZ9LpEEtcsrXwq0K0mlCkdDe2f2npbCUG+urb
   Q==;
X-CSE-ConnectionGUID: PT1IrIfyR0iymZrgjD0AvA==
X-CSE-MsgGUID: MndXLJkUQGCiRNwRfrNVqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="72441848"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="72441848"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 21:24:42 -0800
X-CSE-ConnectionGUID: TM+lC10ERfSlUPeBNZRjpA==
X-CSE-MsgGUID: kueySC1/QEWO1Hgim4eaVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="210186400"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Jan 2026 21:24:38 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgcK4-00000000KPc-1pqB;
	Fri, 16 Jan 2026 05:24:36 +0000
Date: Fri, 16 Jan 2026 13:23:44 +0800
From: kernel test robot <lkp@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [cxl:next 8/8] ERROR: modpost: "__udivdi3"
 [drivers/cxl/core/cxl_core.ko] undefined!
Message-ID: <202601161359.cnyZgr4S-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
head:   9582b6a47ef87168a3a57084f75fd7239a6c56f6
commit: 9582b6a47ef87168a3a57084f75fd7239a6c56f6 [8/8] cxl/region: Translate HPA to DPA and memdev in unaligned regions
config: i386-buildonly-randconfig-004-20260116 (https://download.01.org/0day-ci/archive/20260116/202601161359.cnyZgr4S-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260116/202601161359.cnyZgr4S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601161359.cnyZgr4S-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/cxl/core/cxl_core.ko] undefined!
>> ERROR: modpost: "__umoddi3" [drivers/cxl/core/cxl_core.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
