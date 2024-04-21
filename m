Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275310A3C
	for <linux-cxl@vger.kernel.org>; Sun, 21 Apr 2024 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713701699; cv=none; b=EzkPvrrBfoqXZvPFuU7gO9oZcKGDpCsgqQtMqx17dqdmXPrTBWe0yVDk5lB0ysmRCK1fUiEtrTTOUrzIzMh1Y4jAG5rPu8yaqPDHWAwvC6qBzwemjMV5T9LbR6jKr6DaScZjyCRi4g46hUaRBqJkfukvaFgrFnE8mSrVSzj2GXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713701699; c=relaxed/simple;
	bh=LPPVp3JalpchXXn5VxkxWYPZ6dKa11QDpIhFan31a8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScsjF5p0DHhI/lStDrv6oUfo2FVqrNZbB3fnLlP6utNP7X9Xc8huU8aw9LKvqKWaI6diS7V0fKNu6AWLBfX6v1y6YEqpKj+zkTYxwsJwr1g4Dyi5Q32JQdiC3ScN/i4Vq90WlcexJc/OUDiN15oeuDFJ2DUiQ1+BITH5Xm3P+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTNvm+JO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTNvm+JO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713701697; x=1745237697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LPPVp3JalpchXXn5VxkxWYPZ6dKa11QDpIhFan31a8w=;
  b=lTNvm+JOlBWu5J7w7QcgPFd3hVOF1OsoL9GbriJScNIBrQoMoO5v6XBp
   DPBLb7qogXYsWQ/KNYSRJ+Tm//JBtWuF63Cm4n34RST0n2+wiMAbuD4rO
   8H5ffhkjJ29/2GwVEYfcXoGHRQozOk9dHdPyeVD9aeiNeKSIp7fZzbsKP
   DEc1qE+bhJmIhLbTo6Y62gd0X0NpdUkDViMnyfIcB7fZSw9awSedZaNCG
   47OX6ScG7EsavAPl6rkcLVXbaZH+W9FI0Uwk3RAIqSa6C2PKuEr6+4E9F
   O8FRlfyORJDX5xb4S/Irol1rFfU8RmY9KJAAsF+rU0dv4LNCO/9MVgXXr
   A==;
X-CSE-ConnectionGUID: 93GMzv6sTteO1Hmc3WlKGg==
X-CSE-MsgGUID: tAwl3MhPTCeU/4ZRKLFqQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="20386906"
X-IronPort-AV: E=Sophos;i="6.07,218,1708416000"; 
   d="scan'208";a="20386906"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 05:14:56 -0700
X-CSE-ConnectionGUID: C0Jeq7A3RpiqZCcgLkMW0w==
X-CSE-MsgGUID: Vu8TxWsvR5ONSzipf1pQHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,218,1708416000"; 
   d="scan'208";a="61205258"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 21 Apr 2024 05:14:53 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryW5q-000Bu2-15;
	Sun, 21 Apr 2024 12:14:50 +0000
Date: Sun, 21 Apr 2024 20:14:21 +0800
From: kernel test robot <lkp@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, dave@stgolabs.net, ira.weiny@intel.com,
	alison.schofield@intel.com
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
Message-ID: <202404212044.uSxtGRtL-lkp@intel.com>
References: <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>

Hi Shiyang,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master v6.9-rc4 next-20240419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shiyang-Ruan/cxl-core-correct-length-of-DPA-field-masks/20240417-155443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20240417075053.3273543-3-ruansy.fnst%40fujitsu.com
patch subject: [PATCH v3 2/2] cxl/core: add poison creation event handler
config: csky-randconfig-002-20240421 (https://download.01.org/0day-ci/archive/20240421/202404212044.uSxtGRtL-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240421/202404212044.uSxtGRtL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404212044.uSxtGRtL-lkp@intel.com/

All errors (new ones prefixed by >>):

   `.exit.text' referenced in section `__jump_table' of fs/ceph/super.o: defined in discarded section `.exit.text' of fs/ceph/super.o
   `.exit.text' referenced in section `__jump_table' of fs/ceph/super.o: defined in discarded section `.exit.text' of fs/ceph/super.o
   csky-linux-ld: drivers/cxl/core/mbox.o: in function `__cxl_report_poison':
   mbox.c:(.text+0xa12): undefined reference to `cxl_trace_hpa'
>> csky-linux-ld: mbox.c:(.text+0xa44): undefined reference to `cxl_trace_hpa'
   `.exit.text' referenced in section `__jump_table' of drivers/target/target_core_configfs.o: defined in discarded section `.exit.text' of drivers/target/target_core_configfs.o
   `.exit.text' referenced in section `__jump_table' of drivers/target/target_core_configfs.o: defined in discarded section `.exit.text' of drivers/target/target_core_configfs.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o
   `.exit.text' referenced in section `__jump_table' of net/ceph/ceph_common.o: defined in discarded section `.exit.text' of net/ceph/ceph_common.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
