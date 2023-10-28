Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D504FBFE
	for <linux-cxl@vger.kernel.org>; Sat, 28 Oct 2023 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5bzUmxW"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB131D9
	for <linux-cxl@vger.kernel.org>; Sat, 28 Oct 2023 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698493042; x=1730029042;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tQdYM0nSpOCbrg3ltpifw/3hnZB4kzq8LEAEdS5VAnQ=;
  b=T5bzUmxWhum+nR164S2+iLHj3OyA7SvfJFK3AAlHmx6gFw4lYvjF73Ke
   f39XTvyCjlx0L8B8YmXPmqBOA8mi7A5MsCFlbILhAtJ6Xg0QI5yrE3Skc
   iFC34QDMA4k8CYF4EmrqGK3aP5rLCYa0jW9aP0MVarZd6uZ+pKcBW3gA3
   W5tQocenIjX+BYMwBw31foYt3IKJtOf143+5hMeXkUWvSuRl4iTaBDyaO
   WdJ2Gqq7WBhmGhvdtezI+o+k6JFGMl6paObBT+Cq58heOgtFNgKACzV1q
   Xdl2asDcyzxf9AtpU1RIOIy9f2FFXGqDU05pN92e/SNAFssc8ESQ94AZM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="372947291"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="372947291"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 04:37:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="7479390"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Oct 2023 04:35:56 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qwhcz-000Bgp-3B;
	Sat, 28 Oct 2023 11:37:17 +0000
Date: Sat, 28 Oct 2023 19:36:50 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Ben Widawsky <ben.widawsky@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next 20/30] /usr/bin/ld: pci.c:undefined reference to
 `pci_print_aer'
Message-ID: <202310281946.qLmWjxcT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
head:   2630b3957abe46d7bc4ae0e26275030d76cefb94
commit: 6e72dacff95c149e8ca9f010a4ee8ba14f5e7d5c [20/30] PCI/AER: Increase compile coverage of CONFIG_PCIEAER_CXL implementation
config: um-randconfig-001-20231028 (https://download.01.org/0day-ci/archive/20231028/202310281946.qLmWjxcT-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310281946.qLmWjxcT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310281946.qLmWjxcT-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: drivers/cxl/core/pci.o: in function `cxl_handle_rdport_errors.isra.0':
   pci.c:(.text+0x6c9): undefined reference to `pci_print_aer'
>> /usr/bin/ld: pci.c:(.text+0x6f0): undefined reference to `pci_print_aer'
   /usr/bin/ld: pci.c:(.text+0x72e): undefined reference to `pci_print_aer'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
