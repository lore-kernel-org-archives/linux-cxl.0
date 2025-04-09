Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6326463A;
	Wed,  9 Apr 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206307; cv=none; b=OboJa1GzGKnsSSunIoqmMaiv7ybMoZ0OxN7JMC8RZqDYghDfDrztW864Z9/X/QOQIj3HdmAD5XVb13k2AEi4aTyEuv2tkP0JvfDspf8NQWFikML9fVJnqSlRyZ0Ukrmy6IXwihxbPGjGlVTjp5R2fgvVGWF+4I87nt1C1F/cc44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206307; c=relaxed/simple;
	bh=HyS4m1OpwGEtu3XRkRAYOhoHUmgZgzmM+y4vxfx8MlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk1yvVFqTHAb++2R/n3ZXWB+RaAKqG23eNJ4nBTwrA+P5wVtoGU6aLwi7/+zPltWnwirPtyP5b3b96KA6MEgEpqmGmQwum7urS4rkwg8LQJGQqWgHoY/8v+HNQ0a1BcPE/FHTkS8JJu/U0sz7jOw3c2FDxC/LEo+23/hihQVYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhuqA4zz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhuqA4zz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744206305; x=1775742305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HyS4m1OpwGEtu3XRkRAYOhoHUmgZgzmM+y4vxfx8MlM=;
  b=FhuqA4zzODUQI2vp2ep4w6WMBV7WKvzD87Ts+u10f+MdRIfz5w/K1ye7
   4CzPgw8MUN1nXbkC6IBmU5wYjWjLYe5nbYZ8cgT2TKN87mi3VWcw/VsBH
   ab06cL5VtqOA2W+f8qlru1rpkfDi18V4sr86LGci0hh5IJJhqDnhNCB1N
   B3s03KBOBm4OeDa/A6c7pyEpI8jfQ9NB1QRwAPOphDtXC9MCDElf2XVLh
   3WWuRiZDQL1ZOfjPhI1HF0StywgJZIW8lreUGPLHcOl/ydgoXVyOdX5L3
   sCF0+k4mrtFlgaNkEicrT/W9PMbHwYJiaJsr0EsOQp14bSd3a9QeW2/md
   Q==;
X-CSE-ConnectionGUID: KHxOC+pcQA+u0pZjilaORg==
X-CSE-MsgGUID: nP+2OgZJR32rV2JsKNLtxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="63222874"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="63222874"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 06:45:04 -0700
X-CSE-ConnectionGUID: 5bc9poUdSwCEOvxn3g96CA==
X-CSE-MsgGUID: vDtgPYLbQ22GHh15T1wa/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="128567296"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Apr 2025 06:45:02 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2Vjf-0008uH-14;
	Wed, 09 Apr 2025 13:44:59 +0000
Date: Wed, 9 Apr 2025 21:44:52 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 2/3] mm,memory_hotplug: Implement numa node notifier
Message-ID: <202504092104.MyHeSV43-lkp@intel.com>
References: <20250408084153.255762-3-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408084153.255762-3-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20250409]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus tj-cgroup/for-next linus/master vbabka-slab/for-next v6.15-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/mm-slub-Do-not-special-case-N_NORMAL-nodes-for-slab_nodes/20250408-164417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250408084153.255762-3-osalvador%40suse.de
patch subject: [PATCH v2 2/3] mm,memory_hotplug: Implement numa node notifier
config: arm64-randconfig-001-20250409 (https://download.01.org/0day-ci/archive/20250409/202504092104.MyHeSV43-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 92c93f5286b9ff33f27ff694d2dc33da1c07afdd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250409/202504092104.MyHeSV43-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504092104.MyHeSV43-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/base/node.c:115:5: error: redefinition of 'register_node_notifier'
     115 | int register_node_notifier(struct notifier_block *nb)
         |     ^
   include/linux/memory.h:172:19: note: previous definition is here
     172 | static inline int register_node_notifier(struct notifier_block *nb)
         |                   ^
>> drivers/base/node.c:121:6: error: redefinition of 'unregister_node_notifier'
     121 | void unregister_node_notifier(struct notifier_block *nb)
         |      ^
   include/linux/memory.h:176:20: note: previous definition is here
     176 | static inline void unregister_node_notifier(struct notifier_block *nb)
         |                    ^
>> drivers/base/node.c:127:5: error: redefinition of 'node_notify'
     127 | int node_notify(unsigned long val, void *v)
         |     ^
   include/linux/memory.h:179:19: note: previous definition is here
     179 | static inline int node_notify(unsigned long val, void *v)
         |                   ^
   3 errors generated.


vim +/register_node_notifier +115 drivers/base/node.c

   114	
 > 115	int register_node_notifier(struct notifier_block *nb)
   116	{
   117		return blocking_notifier_chain_register(&node_chain, nb);
   118	}
   119	EXPORT_SYMBOL(register_node_notifier);
   120	
 > 121	void unregister_node_notifier(struct notifier_block *nb)
   122	{
   123		blocking_notifier_chain_unregister(&node_chain, nb);
   124	}
   125	EXPORT_SYMBOL(unregister_node_notifier);
   126	
 > 127	int node_notify(unsigned long val, void *v)
   128	{
   129		return blocking_notifier_call_chain(&node_chain, val, v);
   130	}
   131	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
