Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970351581FB
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160495; cv=none; b=cQsnHGmxo2/XUO0q5x3oUelfc/XmdD+HpRfcWqv2tIRDOBmRhm/CP6OJnJ4SbIvCcTXro3whTMxFLzM0jh9f4wkLk28PaD4fPP/AYhNgmlTgxBc/YJ6brLXHGkkcdwwDHPRgIXDzlIin+UFxZpu5iunt8L/ATxQxTrJF/5eMIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160495; c=relaxed/simple;
	bh=8BrMJd0kEwB4kmIMqbroKV8LIqt5gErKljrqofvhSE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWWhBJN9ViGrpcswLc4RZLPAk8InsJdxNmpp13WWNgfGdHK5yDxXQb5UT8bwxpZQEPAkGlxLvR8i2As1EkrR9+XTMfQH/SwCpdemS6U+krIVANYyUCstj5vGgQKkFu7aijrMj/YkdBiv6yK5vA1AiGFmcmVA+vxoPEs6v9vAgUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ab3qK6us; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ab3qK6us"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717160493; x=1748696493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8BrMJd0kEwB4kmIMqbroKV8LIqt5gErKljrqofvhSE0=;
  b=Ab3qK6usBFWhI7YhMV/GYhHBWlJEvbyprzHVmvxXL6ITZqCvUVb9MSlh
   J7r0SLBTnp+y1DdMB4rLebPPE2mTcLEgS4XcB49KwLFA4xo939F/NzgJI
   koXVSYcvcCDwoYpn+7+pTMGtDUZxHLyjdTmM6ASETeJkDs6blLRiDxDdo
   hNnCwOdDl4zllcxXWjYidEMGwVliYez0Q7xsyBKl+vnVIOFSfvg6Di/mU
   uxcrdLy+3LtS8CB3VFG/WMxQaA1mVnTrXzFj5Vr3XdgkggiafbAj0uYnx
   eCL31KqSeJAWV24nPsEcOgE8wVw0czOslBFlonwe4U3Q6+X0gFLebcmi+
   w==;
X-CSE-ConnectionGUID: dciF+AffRQGnVSzWVXH/Yw==
X-CSE-MsgGUID: anZxfJUxT92F+i2o15SyqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25101618"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25101618"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:01:30 -0700
X-CSE-ConnectionGUID: HGDJAzJxT3CE8qAnY0g4rA==
X-CSE-MsgGUID: MP3xXiq9QFS97tBUVKAqkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="41229691"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 31 May 2024 06:01:28 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD1sr-000H73-1T;
	Fri, 31 May 2024 13:01:25 +0000
Date: Fri, 31 May 2024 21:00:38 +0800
From: kernel test robot <lkp@intel.com>
To: Li Ming <ming4.li@intel.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Li Ming <ming4.li@intel.com>
Subject: Re: [PATCH 1/1] cxl/mem: Fix no cxl_nvd during pmem region
 auto-assembing
Message-ID: <202405312008.SFZRRSYU-lkp@intel.com>
References: <20240531070229.1596811-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531070229.1596811-1-ming4.li@intel.com>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cxl/next]
[also build test WARNING on linus/master v6.10-rc1 next-20240531]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Ming/cxl-mem-Fix-no-cxl_nvd-during-pmem-region-auto-assembing/20240531-150446
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20240531070229.1596811-1-ming4.li%40intel.com
patch subject: [PATCH 1/1] cxl/mem: Fix no cxl_nvd during pmem region auto-assembing
config: i386-buildonly-randconfig-001-20240531 (https://download.01.org/0day-ci/archive/20240531/202405312008.SFZRRSYU-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405312008.SFZRRSYU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405312008.SFZRRSYU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/pmem.c:71: warning: expecting prototype for cxl_nvdimm_bridge(). Prototype was for cxl_find_nvdimm_bridge() instead


vim +71 drivers/cxl/core/pmem.c

2e52b6256b9af2 Dan Williams 2021-09-14  64  
0417bd9707cb07 Li Ming      2024-05-31  65  /**
0417bd9707cb07 Li Ming      2024-05-31  66   * cxl_nvdimm_bridge() - find a bridge device relative to a port
0417bd9707cb07 Li Ming      2024-05-31  67   * @port: any descendant port of an nvdimm-bridge associated
0417bd9707cb07 Li Ming      2024-05-31  68   *        root-cxl-port
0417bd9707cb07 Li Ming      2024-05-31  69   */
0417bd9707cb07 Li Ming      2024-05-31  70  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port)
2e52b6256b9af2 Dan Williams 2021-09-14 @71  {
0417bd9707cb07 Li Ming      2024-05-31  72  	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
2e52b6256b9af2 Dan Williams 2021-09-14  73  	struct device *dev;
2e52b6256b9af2 Dan Williams 2021-09-14  74  
44cd71ef7bacdf Dave Jiang   2024-01-05  75  	if (!cxl_root)
a46cfc0f011ce7 Dan Williams 2022-01-31  76  		return NULL;
a46cfc0f011ce7 Dan Williams 2022-01-31  77  
66f11890d35a60 Dave Jiang   2024-01-05  78  	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
a46cfc0f011ce7 Dan Williams 2022-01-31  79  
2e52b6256b9af2 Dan Williams 2021-09-14  80  	if (!dev)
2e52b6256b9af2 Dan Williams 2021-09-14  81  		return NULL;
a46cfc0f011ce7 Dan Williams 2022-01-31  82  
2e52b6256b9af2 Dan Williams 2021-09-14  83  	return to_cxl_nvdimm_bridge(dev);
2e52b6256b9af2 Dan Williams 2021-09-14  84  }
affec782742e08 Dan Williams 2021-11-12  85  EXPORT_SYMBOL_NS_GPL(cxl_find_nvdimm_bridge, CXL);
2e52b6256b9af2 Dan Williams 2021-09-14  86  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
