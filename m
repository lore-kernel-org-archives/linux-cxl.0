Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FF614F85
	for <linux-cxl@vger.kernel.org>; Sat, 28 Oct 2023 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QW7TruGx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C65F0
	for <linux-cxl@vger.kernel.org>; Sat, 28 Oct 2023 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698494303; x=1730030303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e/tVJgXdhTeMHz302qZBsMxM29nEg0wz6f01JNrzBPQ=;
  b=QW7TruGxndv+YWzVQw/CY7h8q0TD5RdoY7RNLsl4/TZcKcEjOysMqnux
   NMC+g+lcliJHbeLxgfWm9AdhUSi3ihHLokexmmuTmFacp72gsqXmI3XS9
   9XK8qQ+96HPMuRdC5MjHSiiXzkiQtHuGZJe8rSi14o+L4fJzwyuv8XzDO
   bjTPux58h8mB5Jz7sJqr3ElkpCKOPpx12ANsP6AzUg28bQFjiiBoZoMZK
   N4wz0ajDpu1yasxvLHxa+w34fQ3k7PTyrorYoO5+9XSgn1H2efdOR0YVi
   uy2GbS50uigOe9u9sDzveBibQzX5haa+WIXY2ynQE8nieNJYLO3hJfaDD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="9431829"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="9431829"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 04:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="933361186"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="933361186"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Oct 2023 04:58:21 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qwhxK-000Bhr-2W;
	Sat, 28 Oct 2023 11:58:18 +0000
Date: Sat, 28 Oct 2023 19:57:20 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Ben Widawsky <ben.widawsky@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:next 20/30] arm-linux-gnueabi-ld: pci.c:undefined reference to
 `pci_print_aer'
Message-ID: <202310281921.W9lzomPk-lkp@intel.com>
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
config: arm-randconfig-002-20231028 (https://download.01.org/0day-ci/archive/20231028/202310281921.W9lzomPk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310281921.W9lzomPk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310281921.W9lzomPk-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/cxl/core/pci.o: in function `cxl_handle_rdport_errors':
   pci.c:(.text+0x15a4): undefined reference to `pci_print_aer'
>> arm-linux-gnueabi-ld: pci.c:(.text+0x15d8): undefined reference to `pci_print_aer'
   arm-linux-gnueabi-ld: pci.c:(.text+0x1634): undefined reference to `pci_print_aer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
