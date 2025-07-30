Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4B1E633C
	for <linux-cxl@vger.kernel.org>; Wed, 30 Jul 2025 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753857563; cv=none; b=pOdTqo6mg2rw7sX5V3NYPWF5GCSYRdcL8GEOxADrxY8AD8xpnoxC9XaeC3wNPoVeWqyUN2Mf5B9ltogK29WjVeqxc6fvmwR5vbTRofAhHVSmP8fCPQldF8J58So4uODxfNZH9A3UhefJnH3D13tHP1U8G5Ta+rpyHVQxmmJedbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753857563; c=relaxed/simple;
	bh=/vMYwosxw2p+VDuGMGH3yHgF4fv2n5majXfQqdomUKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i3B0jO/2G+PO0MuYlvk11vk8sywkDchMS4dPQ2R1Nd89JohyIfcaro0srB5NP2NDPqCjBhzaDS0GejeK/j9WVgBKxuFa9ckii2Ihnx5zkUVR8Z4I9d50OxWlsBEuivlthWWSoaU49S3qnHmJFG0VPpcfp6EKPid5+UK0Otxh+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBB8yd6V; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBB8yd6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753857561; x=1785393561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/vMYwosxw2p+VDuGMGH3yHgF4fv2n5majXfQqdomUKk=;
  b=JBB8yd6VqHN1WVURQtDL2PduvujDZ7K75i4ypfcEwypC1zi0zfNkwLEw
   Eyspfa6MKnmwl+U8OevVI4yGxob6VbnzeCiJmJ6rbXjpVayqIL8KcmLf1
   LWG/yHQqELDA10er17VSvHe8aaff9rlNsoZAQIiO7vJ55EfKA8AAT654q
   FTWmlogHi6mf/c3jGYq2huCsObueyQ0mVu3mEoCcAjvX1pISBTv0gQPHn
   2JJvSlboifCnS1UcV7vK9UUEMMcGlLlTEDUIxwxhr3gdMNi0EtiYAuHrQ
   BbUDUj9PbnG2qIHE8IlxBNUWW8ap1T4WXvffrJ5cF7HOW1vrbWMxhRdMD
   A==;
X-CSE-ConnectionGUID: uAkqVzPORaek3UlOOlYckQ==
X-CSE-MsgGUID: jTxKtlEbQuS4Xv1Ag+dKyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56295599"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56295599"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 23:39:21 -0700
X-CSE-ConnectionGUID: nJVsi4XhR26bJ7ZHR/zATw==
X-CSE-MsgGUID: xa0CPNEbR7a2mkcduEITkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163687342"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jul 2025 23:39:19 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh0T7-00027s-0a;
	Wed, 30 Jul 2025 06:39:17 +0000
Date: Wed, 30 Jul 2025 14:38:38 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.18/cxl-probe-order 4/4] Warning: kernel/resource.c:342
 function parameter 'parent' not described in 'find_next_res'
Message-ID: <202507301452.Dmrkcrcr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.18/cxl-probe-order
head:   5e29cbd1077b79468339aca04b16e401252b5a24
commit: 5e29cbd1077b79468339aca04b16e401252b5a24 [4/4] dax/cxl: Defer Soft Reserved registration
config: arm-randconfig-001-20250730 (https://download.01.org/0day-ci/archive/20250730/202507301452.Dmrkcrcr-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 8f09b03aebb71c154f3bbe725c29e3f47d37c26e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507301452.Dmrkcrcr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507301452.Dmrkcrcr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/resource.c:342 function parameter 'parent' not described in 'find_next_res'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
