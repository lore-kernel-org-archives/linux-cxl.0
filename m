Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C612557A
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148437; cv=none; b=JS6rqMLL/z1FINUaDbU3IEa6laVUo2yrFSUaxgtKy8vHwhR5j06Iy0SSkQT/tAab2P2sJc8RTQ1ZhUKn3CFP3L4axUxIiK98lFgGLFJjv/tOvuj5ppvTyzXdyu5uKUBmmK1EUsKoPLmoZrYps0OVP2g7acoiRgrElFOygjtqy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148437; c=relaxed/simple;
	bh=zrvXKF8W3wQ3r5b5s2jD6kmqeUtqyfGkprYOpJjfvGo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bfGtzh3KiPRlylYY5fHpRJ8sl6jcYZviPunjoDnDRC2DjstChoo+IXRMyCCTgg+lSDU/3vxVcDQnf3TjhkTfRlay87k0kT+w6kfGaO+J8r7ydQmgaA/EP0DEgyul4u0yEoUpQKldggrZHvQzXBDym4G+RJb+FL95ynQ4A2U16L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8NGkqeQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8NGkqeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747148436; x=1778684436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zrvXKF8W3wQ3r5b5s2jD6kmqeUtqyfGkprYOpJjfvGo=;
  b=L8NGkqeQenf5brrS/GZAgcwRchfhPmu+pl7ti9pFNecd/cFoZ9DLeV3D
   74ypMRE/Zk20RSlwLzffLkiBtNS6TcmUkk5lVOG7Kznm1yMwiRQryoUAa
   Wdz7/C/hqc3HDrggPXUkr8wcADA1C8Kt/lWFIOiF3MPN+pCI3pTrj0CnY
   2+tEJsyt2CRf0Zr85F9lwWtVvOSe+VZXW76dLcYax/y7w7EIyTRGuyuZZ
   jXIcX4RiahknlxvihJAEmtcg3j6SArOUUGZDNVaID5cRRSywI/iS6MR8L
   PXTy1RJ5W8ujkTHsE4rhOPHUReyYtRMrfNo3IdiELgyJH4jbj3yUVzstz
   A==;
X-CSE-ConnectionGUID: f4m5vDjTQ5eLv4I8NUGnBQ==
X-CSE-MsgGUID: 4dxUAuW3R6yMJW98kj3xJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="52803486"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="52803486"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 08:00:35 -0700
X-CSE-ConnectionGUID: VJW97oTxSnuVTlIpJp7AAQ==
X-CSE-MsgGUID: pO7DIjjRSlyD/LFGo8Ec8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="138238422"
Received: from igk-lkp-server01.igk.intel.com (HELO b9ffd1689040) ([10.211.3.150])
  by orviesa007.jf.intel.com with ESMTP; 13 May 2025 08:00:33 -0700
Received: from kbuild by b9ffd1689040 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEr7O-0000zy-0D;
	Tue, 13 May 2025 15:00:30 +0000
Date: Tue, 13 May 2025 22:59:55 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:cxl-acquire 6/7] drivers/cxl/core/core.h:64:1: warning:
 non-void function does not return a value
Message-ID: <202505132222.3xgbkl4I-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-acquire
head:   8b6078f03a61a162ea390c80585942f6cd9e60f4
commit: f86344b036325af56a7f90fa8d90b19bb6961faf [6/7] cxl/region: Introduce CLASS(cxl_decoder_detach...) consolidate multiple paths
config: x86_64-buildonly-randconfig-2001-20250513 (https://download.01.org/0day-ci/archive/20250513/202505132222.3xgbkl4I-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505132222.3xgbkl4I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505132222.3xgbkl4I-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cxl/core/hdm.c:8:
>> drivers/cxl/core/core.h:64:1: warning: non-void function does not return a value [-Wreturn-type]
      64 | }
         | ^
   1 warning generated.


vim +64 drivers/cxl/core/core.h

f86344b036325a Dan Williams     2025-05-05  28  
f86344b036325a Dan Williams     2025-05-05  29  struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
f86344b036325a Dan Williams     2025-05-05  30  				      struct cxl_endpoint_decoder *cxled,
f86344b036325a Dan Williams     2025-05-05  31  				      int pos, enum cxl_detach_mode mode);
f86344b036325a Dan Williams     2025-05-05  32  
779dd20cfb56c5 Ben Widawsky     2021-06-08  33  #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
8d48817df6ac20 Dan Williams     2021-06-15  34  #define CXL_REGION_TYPE(x) (&cxl_region_type)
779dd20cfb56c5 Ben Widawsky     2021-06-08  35  #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
04ad63f086d1a9 Dan Williams     2022-01-11  36  #define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
09d09e04d2fcf8 Dan Williams     2023-02-10  37  #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
8d48817df6ac20 Dan Williams     2021-06-15  38  int cxl_region_init(void);
8d48817df6ac20 Dan Williams     2021-06-15  39  void cxl_region_exit(void);
f0832a58639691 Alison Schofield 2023-04-18  40  int cxl_get_poison_by_endpoint(struct cxl_port *port);
b98d042698a325 Alison Schofield 2024-04-30  41  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
9aa5f6235e16ac Alison Schofield 2024-07-02  42  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
86954ff5032d9d Alison Schofield 2024-04-30  43  		   u64 dpa);
b98d042698a325 Alison Schofield 2024-04-30  44  
779dd20cfb56c5 Ben Widawsky     2021-06-08  45  #else
9aa5f6235e16ac Alison Schofield 2024-07-02  46  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
9aa5f6235e16ac Alison Schofield 2024-07-02  47  				 const struct cxl_memdev *cxlmd, u64 dpa)
86954ff5032d9d Alison Schofield 2024-04-30  48  {
86954ff5032d9d Alison Schofield 2024-04-30  49  	return ULLONG_MAX;
86954ff5032d9d Alison Schofield 2024-04-30  50  }
b98d042698a325 Alison Schofield 2024-04-30  51  static inline
b98d042698a325 Alison Schofield 2024-04-30  52  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
b98d042698a325 Alison Schofield 2024-04-30  53  {
b98d042698a325 Alison Schofield 2024-04-30  54  	return NULL;
b98d042698a325 Alison Schofield 2024-04-30  55  }
f0832a58639691 Alison Schofield 2023-04-18  56  static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
f0832a58639691 Alison Schofield 2023-04-18  57  {
f0832a58639691 Alison Schofield 2023-04-18  58  	return 0;
f0832a58639691 Alison Schofield 2023-04-18  59  }
f86344b036325a Dan Williams     2025-05-05  60  static inline struct cxl_region *
f86344b036325a Dan Williams     2025-05-05  61  cxl_decoder_detach(struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled,
f86344b036325a Dan Williams     2025-05-05  62  		   int pos, enum cxl_detach_mode mode)
b9686e8c8e39d4 Dan Williams     2022-06-04  63  {
b9686e8c8e39d4 Dan Williams     2022-06-04 @64  }
8d48817df6ac20 Dan Williams     2021-06-15  65  static inline int cxl_region_init(void)
8d48817df6ac20 Dan Williams     2021-06-15  66  {
8d48817df6ac20 Dan Williams     2021-06-15  67  	return 0;
8d48817df6ac20 Dan Williams     2021-06-15  68  }
8d48817df6ac20 Dan Williams     2021-06-15  69  static inline void cxl_region_exit(void)
8d48817df6ac20 Dan Williams     2021-06-15  70  {
8d48817df6ac20 Dan Williams     2021-06-15  71  }
779dd20cfb56c5 Ben Widawsky     2021-06-08  72  #define CXL_REGION_ATTR(x) NULL
8d48817df6ac20 Dan Williams     2021-06-15  73  #define CXL_REGION_TYPE(x) NULL
779dd20cfb56c5 Ben Widawsky     2021-06-08  74  #define SET_CXL_REGION_ATTR(x)
04ad63f086d1a9 Dan Williams     2022-01-11  75  #define CXL_PMEM_REGION_TYPE(x) NULL
09d09e04d2fcf8 Dan Williams     2023-02-10  76  #define CXL_DAX_REGION_TYPE(x) NULL
779dd20cfb56c5 Ben Widawsky     2021-06-08  77  #endif
779dd20cfb56c5 Ben Widawsky     2021-06-08  78  

:::::: The code at line 64 was first introduced by commit
:::::: b9686e8c8e39d4072081ef078c04915ee51c8af4 cxl/region: Enable the assignment of endpoint decoders to regions

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
