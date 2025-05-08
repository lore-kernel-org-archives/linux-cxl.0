Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98043221703;
	Thu,  8 May 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746690278; cv=none; b=KMSWEuPTiUszMkpC0DGjCg0VNvDMoJFg1+3OUckbSJesEjsTjROV28FVSxGiGg+Paxk1n8XPrBjCZ/G19dFfjbRU9Qx+1FCBzGotZ1wgBpUWJK4rbagTY7XyW/A7Ghd4UIC6e/OZv6NP4jwGZWdI70oUyxckBX1foc8VR3W5kJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746690278; c=relaxed/simple;
	bh=biB3S/OHcTSuSenX2kZE0QSCZGXojUgcvvFDQiSjYOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXi3MLV3j2keCyTJIaprsWFCVO7XldhN09F19G8tRDcLXVxdI5cOqQ/TvZ6BA1rrFHxz2K6wXse27CUs5UGdP4zz6x3/Ztj3rmqeZPVUtqHMhOQ2CewdjaVfep6/sO4PL/vWZB3iZU006P7AXZfkESytKfhUI8Hdjlz5nmuAgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3nPKT+H; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3nPKT+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746690276; x=1778226276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=biB3S/OHcTSuSenX2kZE0QSCZGXojUgcvvFDQiSjYOY=;
  b=i3nPKT+HVcQlgDulbrjF4DAB0jCm6vMg1TXWbJyOW4IlSVcLHj2m5nmR
   qfzYsbA86AN/3Bcpr2XJOfWfA0Gwu6WiaEdK0P+k+gfdccaLb1EY7JHMV
   +fejOlo7G02+VI37iK+hOqVaP48zQ30wKI7D7+qiqrkwPjYS4SymHKVqo
   PV55joK9Q37nUtAGuj8xNOfMo57YYaNYOZBKEiLfq/dclXi/b6ap6DmkS
   rm602i0bVUb920PWdDSd9NaeQ7gdjN4R4enGqIn8PAQE2rEhQKdS6sPNf
   qt7fTOWzfBchUfLFxABds8drGrBmwy9kMkpsvp701bIV+abnH/MBdbEwg
   w==;
X-CSE-ConnectionGUID: 8+CL0cPvTYq5Secz/JXidw==
X-CSE-MsgGUID: debpBoCzSHmS41mSf+9ZXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59120953"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="59120953"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 00:44:35 -0700
X-CSE-ConnectionGUID: ZDMYDDvmSJuzHLF7tcvRvg==
X-CSE-MsgGUID: chBRilHeSpOM8G0Bx873Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="141109304"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2025 00:44:32 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCvvi-000AlB-0n;
	Thu, 08 May 2025 07:44:30 +0000
Date: Thu, 8 May 2025 15:44:10 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 6/7] cxl/region: Introduce CLASS(cxl_decoder_detach...)
 consolidate multiple paths
Message-ID: <202505081548.9HldF62Y-lkp@intel.com>
References: <20250507072145.3614298-7-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507072145.3614298-7-dan.j.williams@intel.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b4432656b36e5cc1d50a1f2dc15357543add530e]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/cleanup-Introduce-DEFINE_ACQUIRE-a-CLASS-for-conditional-locking/20250507-152728
base:   b4432656b36e5cc1d50a1f2dc15357543add530e
patch link:    https://lore.kernel.org/r/20250507072145.3614298-7-dan.j.williams%40intel.com
patch subject: [PATCH 6/7] cxl/region: Introduce CLASS(cxl_decoder_detach...) consolidate multiple paths
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250508/202505081548.9HldF62Y-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505081548.9HldF62Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505081548.9HldF62Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cxl/core/port.c:9:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/cxl/core/port.c:9:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/cxl/core/port.c:9:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/cxl/core/port.c:17:
>> drivers/cxl/core/core.h:64:1: warning: non-void function does not return a value [-Wreturn-type]
      64 | }
         | ^
   13 warnings generated.


vim +64 drivers/cxl/core/core.h

79ed8367834ee8 Dan Williams     2025-05-07  28  
79ed8367834ee8 Dan Williams     2025-05-07  29  struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
79ed8367834ee8 Dan Williams     2025-05-07  30  				      struct cxl_endpoint_decoder *cxled,
79ed8367834ee8 Dan Williams     2025-05-07  31  				      int pos, enum cxl_detach_mode mode);
79ed8367834ee8 Dan Williams     2025-05-07  32  
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
79ed8367834ee8 Dan Williams     2025-05-07  60  static inline struct cxl_region *
79ed8367834ee8 Dan Williams     2025-05-07  61  cxl_decoder_detach(struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled,
79ed8367834ee8 Dan Williams     2025-05-07  62  		   int pos, enum cxl_detach_mode mode)
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
