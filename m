Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852191B218A;
	Mon, 25 Nov 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541896; cv=none; b=e6xZlt+IB46jUGqUdwuyo0oHxDTv7Qibs1nDn6/U0FZIUAwlLsonjIxWcANU3iyjjYK9efUNdz7MEp1HG00kcpB2PQ4y5irbp5/YaWjikVJ9oDLqIpodcMEFgEdPSn0dQicRm+cPYSaHmjtqpkGrIcyZ1P509NjboC6pn9g0iQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541896; c=relaxed/simple;
	bh=Q6Jj9px3SKZWIVRE0NRwNKltszOpTU80WmPxhjN8Bsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE0QxF0XF+JDQ/yjbj+QcTXO+Be5BgRkTNp/q9auhzloSxxASd4PUArDKuT5rE/7k7GgtDyvuNaHRhlkBxNvzxPpnM0hoavqVDhteroOK+dlbLJlrjzdtGceY4EgJY8TRMY4rphov2KjWDJ4jXKXoqCtkO1zwpWj/pAvKr/4Kv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRjkMGbU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRjkMGbU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732541891; x=1764077891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q6Jj9px3SKZWIVRE0NRwNKltszOpTU80WmPxhjN8Bsw=;
  b=YRjkMGbU+vk/Zucq+vmU8d5GrIJqJVsfg+atyyGdXpLNxCYzklxsxYkN
   B0viqBhzp1c/uvnedrxETJpU0tMBWaIoUn/r9UI2wg93UyL1qUyd1AsFr
   K67ms/uCL+6gPzNlbL3Nv5QEbRnIaCSFh1qRW+HIZkvV6vGQ9oVC85yG0
   sd1xEZt2TMvGvXMwhxIUb8giosJI+Mne5ZlHucSQ+1b7RV3y8fkXg6QeJ
   WmKZIFNh2hmWdytV0lGmr/UGT0Yxzl04HD3LE2GZ9wW0WS2IugfVxJMmO
   ZlEnXCbT01NnOYJ4y3QvKCtfONdZEbATRkgbeQWUU2x22ZTjOBT5rZf/t
   Q==;
X-CSE-ConnectionGUID: do5fITCgSb6EsvjkjB0aWA==
X-CSE-MsgGUID: QcO7nBOWRBiU1TJk3VoUEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="36427578"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="36427578"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:38:09 -0800
X-CSE-ConnectionGUID: kM6MdTeCSYSzHTet+BE0hQ==
X-CSE-MsgGUID: QHBkNTZSRrqt5EaNOca6zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="96329496"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Nov 2024 05:38:05 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFZHu-0006RN-2Z;
	Mon, 25 Nov 2024 13:38:02 +0000
Date: Mon, 25 Nov 2024 21:37:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
Message-ID: <202411252126.T7xKY88q-lkp@intel.com>
References: <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>

Hi Fabio,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master cxl/pending v6.12 next-20241125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/cxl-core-Change-match_-_by_range-calling-convention/20241125-102754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20241122155226.2068287-3-fabio.m.de.francesco%40linux.intel.com
patch subject: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low Memory Hole
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241125/202411252126.T7xKY88q-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411252126.T7xKY88q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411252126.T7xKY88q-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/dax/cxl.c:6:
>> drivers/dax/../cxl/cxl.h:921:6: warning: no previous prototype for 'arch_match_spa' [-Wmissing-prototypes]
     921 | bool arch_match_spa(struct cxl_root_decoder *cxlrd,
         |      ^~~~~~~~~~~~~~
>> drivers/dax/../cxl/cxl.h:927:6: warning: no previous prototype for 'arch_match_region' [-Wmissing-prototypes]
     927 | bool arch_match_region(struct cxl_region_params *p,
         |      ^~~~~~~~~~~~~~~~~
>> drivers/dax/../cxl/cxl.h:933:6: warning: no previous prototype for 'arch_trim_hpa_by_spa' [-Wmissing-prototypes]
     933 | void arch_trim_hpa_by_spa(struct resource *res,
         |      ^~~~~~~~~~~~~~~~~~~~
--
   s390-linux-ld: drivers/cxl/core/port.o: in function `arch_match_spa':
>> port.c:(.text+0x87c0): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/port.o: in function `arch_match_region':
>> port.c:(.text+0x8840): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/port.o: in function `arch_trim_hpa_by_spa':
>> port.c:(.text+0x88c0): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/core/pmem.o: in function `arch_match_spa':
   pmem.c:(.text+0xe00): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/pmem.o: in function `arch_match_region':
   pmem.c:(.text+0xe80): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/pmem.o: in function `arch_trim_hpa_by_spa':
   pmem.c:(.text+0xf00): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/core/regs.o: in function `arch_match_spa':
   regs.c:(.text+0x1740): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/regs.o: in function `arch_match_region':
   regs.c:(.text+0x17c0): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/regs.o: in function `arch_trim_hpa_by_spa':
   regs.c:(.text+0x1840): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/core/memdev.o: in function `arch_match_spa':
   memdev.c:(.text+0x3ec0): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/memdev.o: in function `arch_match_region':
   memdev.c:(.text+0x3f40): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/memdev.o: in function `arch_trim_hpa_by_spa':
   memdev.c:(.text+0x3fc0): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/core/mbox.o: in function `arch_match_spa':
   mbox.c:(.text+0x4f80): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/mbox.o: in function `arch_match_region':
   mbox.c:(.text+0x5000): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/mbox.o: in function `arch_trim_hpa_by_spa':
   mbox.c:(.text+0x5080): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/core/pci.o: in function `arch_match_spa':
   pci.c:(.text+0x3e40): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/pci.o: in function `arch_match_region':
   pci.c:(.text+0x3ec0): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/pci.o: in function `arch_trim_hpa_by_spa':
   pci.c:(.text+0x3f40): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/core/hdm.o: in function `arch_match_spa':
   hdm.c:(.text+0x4880): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/hdm.o: in function `arch_match_region':
   hdm.c:(.text+0x4900): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/hdm.o: in function `arch_trim_hpa_by_spa':
   hdm.c:(.text+0x4980): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/core/pmu.o: in function `arch_match_spa':
   pmu.c:(.text+0x340): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/pmu.o: in function `arch_match_region':
   pmu.c:(.text+0x3c0): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/pmu.o: in function `arch_trim_hpa_by_spa':
   pmu.c:(.text+0x440): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/core/cdat.o: in function `arch_match_spa':
   cdat.c:(.text+0x19c0): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/cdat.o: in function `arch_match_region':
   cdat.c:(.text+0x1a40): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/cdat.o: in function `arch_trim_hpa_by_spa':
   cdat.c:(.text+0x1ac0): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/core/trace.o: in function `arch_match_spa':
   trace.c:(.text+0x8ec0): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/trace.o: in function `arch_match_region':
   trace.c:(.text+0x8f40): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/trace.o: in function `arch_trim_hpa_by_spa':
   trace.c:(.text+0x8fc0): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/core/region.o: in function `arch_match_spa':
   region.c:(.text+0xca00): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/core/region.o: in function `arch_match_region':
   region.c:(.text+0xce00): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/core/region.o: in function `arch_trim_hpa_by_spa':
   region.c:(.text+0x11a80): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/pci.o: in function `arch_match_spa':
   pci.c:(.text+0x4cc0): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/pci.o: in function `arch_match_region':
   pci.c:(.text+0x4d40): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/pci.o: in function `arch_trim_hpa_by_spa':
   pci.c:(.text+0x4dc0): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/mem.o: in function `arch_match_spa':
   mem.c:(.text+0xe40): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/mem.o: in function `arch_match_region':
   mem.c:(.text+0xec0): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/mem.o: in function `arch_trim_hpa_by_spa':
   mem.c:(.text+0xf40): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/pmem.o: in function `arch_match_spa':
   pmem.c:(.text+0x18c0): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/pmem.o: in function `arch_match_region':
   pmem.c:(.text+0x1940): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/pmem.o: in function `arch_trim_hpa_by_spa':
   pmem.c:(.text+0x19c0): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/security.o: in function `arch_match_spa':
   security.c:(.text+0xb00): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/security.o: in function `arch_match_region':
   security.c:(.text+0xb80): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/security.o: in function `arch_trim_hpa_by_spa':
   security.c:(.text+0xc00): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/cxl/port.o: in function `arch_match_spa':
   port.c:(.text+0x840): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/cxl/port.o: in function `arch_match_region':
   port.c:(.text+0x8c0): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/cxl/port.o: in function `arch_trim_hpa_by_spa':
   port.c:(.text+0x940): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here
   s390-linux-ld: drivers/perf/cxl_pmu.o: in function `arch_match_spa':
   cxl_pmu.c:(.text+0x3380): multiple definition of `arch_match_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x200): first defined here
   s390-linux-ld: drivers/perf/cxl_pmu.o: in function `arch_match_region':
   cxl_pmu.c:(.text+0x3400): multiple definition of `arch_match_region'; drivers/dax/cxl.o:cxl.c:(.text+0x280): first defined here
   s390-linux-ld: drivers/perf/cxl_pmu.o: in function `arch_trim_hpa_by_spa':
   cxl_pmu.c:(.text+0x3480): multiple definition of `arch_trim_hpa_by_spa'; drivers/dax/cxl.o:cxl.c:(.text+0x300): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
