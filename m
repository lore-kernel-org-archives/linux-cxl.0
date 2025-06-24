Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D4257AEC
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752413; cv=none; b=cj0A6RWAj1nzgmutVufrhecgZK4ofrYCRiWsxEu6DYQm46/d0cx52bfiWDF3qWfzSz896hyxmF+a1jN8I68gIlTa2+ZOmT3NJ/yqM/X8rJSX/T/lEbQ0zHhhhJH6UkPoTHyZDBfeSxU5LHAlPaBsHd4lsbbjtNSTifcEZAwRwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752413; c=relaxed/simple;
	bh=ty8ZcAc1Q11PBC5qdqSeESYBNa/hdgih7udjrCU15U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Soy0Xb5crGv8hCcoXVn/3RcXQsSSIii6p8srUaDgic0Xnx1hGKoUwqQWutW568tRullqQclU1YODIAG5R1NbpBK1HNSsUHyzQ1iUPg/THlBCPyl7MizDReQRjSq9w+Dk1vBOa3eDglyIXz4H0dSDCVgYg3zc6GD7c9BQBSRBWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sweo6MdK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sweo6MdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750752412; x=1782288412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ty8ZcAc1Q11PBC5qdqSeESYBNa/hdgih7udjrCU15U0=;
  b=Sweo6MdKvW+20Fx/rb6h6gYaAxTdiLtFCH/3yh1dfbPMBBdu0+j6Z7Qm
   oAcQMSMN2VQUdDz5zIWdvh3r5HUycq51m+MhUdF14lZrrUxViTdwF94Zy
   IPF1xFsrG1UGYqsqmSNYcCMctwLQlddqysIF5adZp3ClbI7+DCoc3DCTk
   2NjnQGoVed4tKdvsEKFuboahRBH8gKQnqBMQNEooDt70YBzkkgvxdmtYB
   7oyTt1MB7F+kPeiSzLj8nnx9amL6NrMP2LLAzXAhJcl/TIlIm9mbJ2cFF
   lSGuLtfHSPC0fAvZCvoxoN86O9u6i8t4ChS0mpaW3e3got1IVS29qA3Uc
   g==;
X-CSE-ConnectionGUID: miACFDDRRkqUH9HHMoYOgw==
X-CSE-MsgGUID: 0wguGbybRIGVWHbElxu/gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53052423"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53052423"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:06:51 -0700
X-CSE-ConnectionGUID: DdSn36BxTX6qI0YuXA63LQ==
X-CSE-MsgGUID: h+vt+efTT2ObxyiITFsy4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152016835"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Jun 2025 01:06:49 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTyg2-000Rtu-1B;
	Tue, 24 Jun 2025 08:06:46 +0000
Date: Tue, 24 Jun 2025 16:06:18 +0800
From: kernel test robot <lkp@intel.com>
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/3] cxl/region: Add inject and clear poison by HPA
Message-ID: <202506241504.qzHRxclP-lkp@intel.com>
References: <50bd42e0db1ed5979a00e6f5a43147320a1d5b9b.1750725512.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50bd42e0db1ed5979a00e6f5a43147320a1d5b9b.1750725512.git.alison.schofield@intel.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 19272b37aa4f83ca52bdf9c16d5d81bdd1354494]

url:    https://github.com/intel-lab-lkp/linux/commits/alison-schofield-intel-com/cxl-core-Add-locked-variants-of-the-poison-inject-and-clear-funcs/20250624-085810
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/50bd42e0db1ed5979a00e6f5a43147320a1d5b9b.1750725512.git.alison.schofield%40intel.com
patch subject: [PATCH 3/3] cxl/region: Add inject and clear poison by HPA
config: arm-randconfig-003-20250624 (https://download.01.org/0day-ci/archive/20250624/202506241504.qzHRxclP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506241504.qzHRxclP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506241504.qzHRxclP-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/cxl/core/region.o: in function `cxl_hpa_to_dpa':
>> region.c:(.text.cxl_hpa_to_dpa+0x3dc): undefined reference to `__aeabi_uldivmod'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
