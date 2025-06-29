Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D619F11F
	for <linux-cxl@vger.kernel.org>; Sun, 29 Jun 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751220173; cv=none; b=uvO+PykF8V8M5IUwrhm7HGQ6ln7dNxXTJKqXnUqDgt/NiT80LTmt2r4QjQvB+9CPJ6FrSFSWBlqNEKRHNDNZJW/QwQRQ1KlzOLpaIiAarOjAd+F8rQZWoGdQYiUMj38AICJpGXh1doKG2fNwKDpDNdxWxhp199Q+rJwkX9mQ5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751220173; c=relaxed/simple;
	bh=M0CFUiyT09mKvCy8cDPLDkur3Owiih3SkYwZ9aOXCU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LLlYSLe1QZF8RsWXamMUWo3I0AKAy0iuA6PeUuIP2OZWq+2ifV275I6JKoqV76wg1djZwfnX4xT29TA4qoTHgfY6/+lzkJlMyiNvpm1IHxmcEj1NJRpjetRAJQM8NXlGjDbeG/YAyYx1p0bLmlYBHM7AzwfQlUjG5ElEvADIB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgJhAXl5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgJhAXl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751220171; x=1782756171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M0CFUiyT09mKvCy8cDPLDkur3Owiih3SkYwZ9aOXCU8=;
  b=lgJhAXl55tSGEyRYj416XWZUXinESczAZIJlRHAUef3udGjazoBTZ8f2
   SUXXynZv+GKdkXXfJHA0f5rHOzWcNrFEGSVmsHwcF9NztkTd1YlA7E/n1
   Wucj1eB4ZKeBjGuMcLyMM4UCBzSHHWPUmvUxj0uqB3hWf2lbOR8wsUoyD
   gjjtmK+zgLQ0mqCC2u2YVotYryUBB3NaNo7N+6ohO8C0YlsVGxWmd1ozl
   YDGupStnv/PwIXOMuTID8pOF9zsCur8EInLO+syKyRAaT60J56dhyYE16
   mu2MJA4tDenrfOOE8UF++dGGapua46C7+nJHFb3In9KC7yOwBvPUnSR1c
   Q==;
X-CSE-ConnectionGUID: KdMIGHN8ToOEhzDxEkxsIA==
X-CSE-MsgGUID: v0NoOZyMQrOCr7AGGj+8AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="76000756"
X-IronPort-AV: E=Sophos;i="6.16,275,1744095600"; 
   d="scan'208";a="76000756"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 11:02:51 -0700
X-CSE-ConnectionGUID: LwGWyT6gREeypdxOI9LArQ==
X-CSE-MsgGUID: Q8/Kj4stT5SkiVm0UYr+jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,275,1744095600"; 
   d="scan'208";a="152650052"
Received: from igk-lkp-server01.igk.intel.com (HELO e588e990b675) ([10.91.175.65])
  by orviesa010.jf.intel.com with ESMTP; 29 Jun 2025 11:02:49 -0700
Received: from kbuild by e588e990b675 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVwMY-0000wt-2h;
	Sun, 29 Jun 2025 18:02:46 +0000
Date: Sun, 29 Jun 2025 20:02:22 +0200
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: [cxl:for-6.17/cxl-acquire 7/8] drivers/cxl/core/core.h:64:1:
 warning: non-void function does not return a value
Message-ID: <202506292006.J8za5CBf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.17/cxl-acquire
head:   6c90a41a7833a6bb2fb17b9f3cafda66ebdf259b
commit: e559ce544d18f6290e8f8bca761e3c22e4e845b5 [7/8] cxl/region: Introduce CLASS(cxl_decoder_detach...) consolidate multiple paths
config: i386-buildonly-randconfig-2001-20250625 (https://download.01.org/0day-ci/archive/20250629/202506292006.J8za5CBf-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250629/202506292006.J8za5CBf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506292006.J8za5CBf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cxl/core/memdev.c:11:
   In file included from drivers/cxl/core/trace.h:15:
>> drivers/cxl/core/core.h:64:1: warning: non-void function does not return a value [-Wreturn-type]
      64 | }
         | ^
   1 warning generated.


vim +64 drivers/cxl/core/core.h

e559ce544d18f6 Dan Williams     2025-06-18  28  
e559ce544d18f6 Dan Williams     2025-06-18  29  struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
e559ce544d18f6 Dan Williams     2025-06-18  30  				      struct cxl_endpoint_decoder *cxled,
e559ce544d18f6 Dan Williams     2025-06-18  31  				      int pos, enum cxl_detach_mode mode);
e559ce544d18f6 Dan Williams     2025-06-18  32  
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
e559ce544d18f6 Dan Williams     2025-06-18  60  static inline struct cxl_region *
e559ce544d18f6 Dan Williams     2025-06-18  61  cxl_decoder_detach(struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled,
e559ce544d18f6 Dan Williams     2025-06-18  62  		   int pos, enum cxl_detach_mode mode)
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
