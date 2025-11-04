Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE62C3254;
	Tue,  4 Nov 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248797; cv=none; b=qeCq+1fq6p9+T5H9TFY6VsVjLIGWJFTgmfHxvTg/e+Jco9ASP2VKZBEvKVL4tgrgF1s1Elvuu4IR6DdZaUMHmnJ3YHjmuFLanGNWSRkzP6BGrrpliVLs1tCjaw0R28FCmEZkBsddJAg+83e9T177G9Mqs0BOqHypmX1o2NpixZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248797; c=relaxed/simple;
	bh=cN9H7ZhJf3nnJ1g656RnHeU+GFAnuSv5RWdv9SAimRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqrTqAoeo1GnFqJuHvdHa/8V+GG1QREsq4r7dzK4GplyVoEU6yhLn3sNIOgB9tPK31BCGWc233DE8WlGNq5xk4U7ZE+og+7GTxLh/v7gqMeiPv98ZAarLFqraByJaJGkiMJPFHB9hdhGY8loHVQgyQDpF3sWvECy6hP1bfoyCM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwvRdFA+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwvRdFA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762248796; x=1793784796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cN9H7ZhJf3nnJ1g656RnHeU+GFAnuSv5RWdv9SAimRc=;
  b=BwvRdFA+4H19A5EUo2UPGMMOKG14Ed8W3vEpa3VbHpQecU8KyfyAPFPB
   6rrtARsnP9F2n627rxuHdkrULw/URQsoWnt+7aa6Kb9A6h6+Gzf7YWmt0
   ZW5RrLxgCAwNEo0xJGFquSkAu1a31XZMcpPyEXLiBJSJdIZGW8PtwbsNH
   QYLRMbZvla8DkvT/A95dg/RPBLw79gH5od061MawrFCQkx72rSKm8aqq0
   V/9DA7ewxnlsm4u5rUPkz+NFj4+9ytwMBsw0O/jNZ2yN2pQUFIcXxUo2l
   k0sqWbOivUh6E7/EFC4iue/fbnkl+ameqtLCZYZcovCfoHXlGuvkIMLRA
   Q==;
X-CSE-ConnectionGUID: WUX9C38cTM2VNruy8aAzEA==
X-CSE-MsgGUID: pnCGUEY7RXGxOucMoYBEsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="89800214"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="89800214"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:33:15 -0800
X-CSE-ConnectionGUID: KxH+KwbAQliQ121G2A+xWQ==
X-CSE-MsgGUID: DSFTjp29Sb2wYJJHgFNNfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="210616320"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 04 Nov 2025 01:33:11 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGDPZ-000RCi-1S;
	Tue, 04 Nov 2025 09:33:09 +0000
Date: Tue, 4 Nov 2025 17:33:06 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 10/14] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <202511041721.oCz4BaCp-lkp@intel.com>
References: <20251103184804.509762-11-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103184804.509762-11-rrichter@amd.com>

Hi Robert,

kernel test robot noticed the following build errors:

[auto build test ERROR on 211ddde0823f1442e4ad052a2f30f050145ccada]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/cxl-region-Store-root-decoder-in-struct-cxl_region/20251104-025351
base:   211ddde0823f1442e4ad052a2f30f050145ccada
patch link:    https://lore.kernel.org/r/20251103184804.509762-11-rrichter%40amd.com
patch subject: [PATCH v4 10/14] cxl: Enable AMD Zen5 address translation using ACPI PRMT
config: x86_64-randconfig-072-20251104 (https://download.01.org/0day-ci/archive/20251104/202511041721.oCz4BaCp-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511041721.oCz4BaCp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511041721.oCz4BaCp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/core/atl.c:63:42: error: incomplete definition of type 'struct cxl_region_context'
      63 |         struct cxl_endpoint_decoder *cxled = ctx->cxled;
         |                                              ~~~^
   drivers/cxl/core/atl.c:62:9: note: forward declaration of 'struct cxl_region_context'
      62 |         struct cxl_region_context *ctx = data;
         |                ^
   drivers/cxl/core/atl.c:65:32: error: incomplete definition of type 'struct cxl_region_context'
      65 |         struct cxl_memdev *cxlmd = ctx->cxlmd;
         |                                    ~~~^
   drivers/cxl/core/atl.c:62:9: note: forward declaration of 'struct cxl_region_context'
      62 |         struct cxl_region_context *ctx = data;
         |                ^
   drivers/cxl/core/atl.c:66:30: error: incomplete definition of type 'struct cxl_region_context'
      66 |         struct range hpa_range = ctx->hpa_range;
         |                                  ~~~^
   drivers/cxl/core/atl.c:62:9: note: forward declaration of 'struct cxl_region_context'
      62 |         struct cxl_region_context *ctx = data;
         |                ^
   drivers/cxl/core/atl.c:92:9: error: incomplete definition of type 'struct cxl_region_context'
      92 |         if (ctx->interleave_ways != 1) {
         |             ~~~^
   drivers/cxl/core/atl.c:62:9: note: forward declaration of 'struct cxl_region_context'
      62 |         struct cxl_region_context *ctx = data;
         |                ^
   drivers/cxl/core/atl.c:94:7: error: incomplete definition of type 'struct cxl_region_context'
      94 |                         ctx->interleave_ways, ctx->interleave_granularity);
         |                         ~~~^
   include/linux/dev_printk.h:171:49: note: expanded from macro 'dev_dbg'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~~~~~
   include/linux/dev_printk.h:139:35: note: expanded from macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:62:9: note: forward declaration of 'struct cxl_region_context'
      62 |         struct cxl_region_context *ctx = data;
         |                ^
   drivers/cxl/core/atl.c:94:29: error: incomplete definition of type 'struct cxl_region_context'
      94 |                         ctx->interleave_ways, ctx->interleave_granularity);
         |                                               ~~~^
   include/linux/dev_printk.h:171:49: note: expanded from macro 'dev_dbg'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~~~~~
   include/linux/dev_printk.h:139:35: note: expanded from macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:62:9: note: forward declaration of 'struct cxl_region_context'
      62 |         struct cxl_region_context *ctx = data;
         |                ^
   drivers/cxl/core/atl.c:114:39: error: incomplete definition of type 'struct cxl_region_context'
     114 |                         hpa_range.start, hpa_range.end, ctx->hpa_range.start,
         |                                                         ~~~^
   include/linux/dev_printk.h:171:49: note: expanded from macro 'dev_dbg'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~~~~~
   include/linux/dev_printk.h:139:35: note: expanded from macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:62:9: note: forward declaration of 'struct cxl_region_context'
      62 |         struct cxl_region_context *ctx = data;
         |                ^
   drivers/cxl/core/atl.c:115:7: error: incomplete definition of type 'struct cxl_region_context'
     115 |                         ctx->hpa_range.end, dev_name(&cxld->dev));
         |                         ~~~^
   include/linux/dev_printk.h:171:49: note: expanded from macro 'dev_dbg'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~~~~~
   include/linux/dev_printk.h:139:35: note: expanded from macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:62:9: note: forward declaration of 'struct cxl_region_context'
      62 |         struct cxl_region_context *ctx = data;
         |                ^
   drivers/cxl/core/atl.c:130:39: error: incomplete definition of type 'struct cxl_region_context'
     130 |                         hpa_range.start, hpa_range.end, ctx->hpa_range.start,
         |                                                         ~~~^
   include/linux/dev_printk.h:171:49: note: expanded from macro 'dev_dbg'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~~~~~
   include/linux/dev_printk.h:139:35: note: expanded from macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:62:9: note: forward declaration of 'struct cxl_region_context'
      62 |         struct cxl_region_context *ctx = data;
         |                ^
   drivers/cxl/core/atl.c:131:7: error: incomplete definition of type 'struct cxl_region_context'
     131 |                         ctx->hpa_range.end, dev_name(&cxld->dev));
         |                         ~~~^
   include/linux/dev_printk.h:171:49: note: expanded from macro 'dev_dbg'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~~~~~
   include/linux/dev_printk.h:139:35: note: expanded from macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:62:9: note: forward declaration of 'struct cxl_region_context'
      62 |         struct cxl_region_context *ctx = data;
         |                ^
   drivers/cxl/core/atl.c:156:39: error: incomplete definition of type 'struct cxl_region_context'
     156 |                         hpa_range.start, hpa_range.end, ctx->hpa_range.start,
         |                                                         ~~~^
   include/linux/dev_printk.h:171:49: note: expanded from macro 'dev_dbg'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)


vim +63 drivers/cxl/core/atl.c

    59	
    60	static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
    61	{
    62		struct cxl_region_context *ctx = data;
  > 63		struct cxl_endpoint_decoder *cxled = ctx->cxled;
    64		struct cxl_decoder *cxld = &cxled->cxld;
    65		struct cxl_memdev *cxlmd = ctx->cxlmd;
    66		struct range hpa_range = ctx->hpa_range;
    67		struct pci_dev *pci_dev;
    68		u64 spa_len, len = range_len(&hpa_range);
    69		u64 addr, base_spa, base = hpa_range.start;
    70		int ways, gran;
    71	
    72		/*
    73		 * When Normalized Addressing is enabled, the endpoint
    74		 * maintains a 1:1 mapping between HPA and DPA. If disabled,
    75		 * skip address translation and perform only a range check.
    76		 */
    77		if (hpa_range.start != cxled->dpa_res->start)
    78			return 0;
    79	
    80		if (!IS_ALIGNED(hpa_range.start, SZ_256M) ||
    81		    !IS_ALIGNED(hpa_range.end + 1, SZ_256M)) {
    82			dev_dbg(cxld->dev.parent,
    83				"CXL address translation: Unaligned decoder HPA range: %#llx-%#llx(%s)\n",
    84				hpa_range.start, hpa_range.end, dev_name(&cxld->dev));
    85			return -ENXIO;
    86		}
    87	
    88		/*
    89		 * Endpoints are programmed passthrough in Normalized
    90		 * Addressing mode.
    91		 */
    92		if (ctx->interleave_ways != 1) {
    93			dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granularity: %d\n",
    94				ctx->interleave_ways, ctx->interleave_granularity);
    95			return -ENXIO;
    96		}
    97	
    98		if (!cxlmd || !dev_is_pci(cxlmd->dev.parent)) {
    99			dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%#llx\n",
   100				dev_name(cxld->dev.parent), hpa_range.start,
   101				hpa_range.end);
   102			return -ENXIO;
   103		}
   104	
   105		pci_dev = to_pci_dev(cxlmd->dev.parent);
   106	
   107		/* Translate HPA range to SPA. */
   108		hpa_range.start = base_spa = prm_cxl_dpa_spa(pci_dev, hpa_range.start);
   109		hpa_range.end = prm_cxl_dpa_spa(pci_dev, hpa_range.end);
   110	
   111		if (hpa_range.start == ULLONG_MAX || hpa_range.end == ULLONG_MAX) {
   112			dev_dbg(cxld->dev.parent,
   113				"CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
   114				hpa_range.start, hpa_range.end, ctx->hpa_range.start,
   115				ctx->hpa_range.end, dev_name(&cxld->dev));
   116			return -ENXIO;
   117		}
   118	
   119		/*
   120		 * Since translated addresses include the interleaving
   121		 * offsets, align the range to 256 MB.
   122		 */
   123		hpa_range.start = ALIGN_DOWN(hpa_range.start, SZ_256M);
   124		hpa_range.end = ALIGN(hpa_range.end, SZ_256M) - 1;
   125	
   126		spa_len = range_len(&hpa_range);
   127		if (!len || !spa_len || spa_len % len) {
   128			dev_dbg(cxld->dev.parent,
   129				"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
   130				hpa_range.start, hpa_range.end, ctx->hpa_range.start,
   131				ctx->hpa_range.end, dev_name(&cxld->dev));
   132			return -ENXIO;
   133		}
   134	
   135		ways = spa_len / len;
   136		gran = SZ_256;
   137	
   138		/*
   139		 * Determine interleave granularity
   140		 *
   141		 * Note: The position of the chunk from one interleaving block
   142		 * to the next may vary and thus cannot be considered
   143		 * constant. Address offsets larger than the interleaving
   144		 * block size cannot be used to calculate the granularity.
   145		 */
   146		while (ways > 1 && gran <= SZ_16M) {
   147			addr = prm_cxl_dpa_spa(pci_dev, base + gran);
   148			if (addr != base_spa + gran)
   149				break;
   150			gran <<= 1;
   151		}
   152	
   153		if (gran > SZ_16M) {
   154			dev_dbg(cxld->dev.parent,
   155				"CXL address translation: Cannot determine granularity: %#llx-%#llx:%#llx-%#llx(%s)\n",
   156				hpa_range.start, hpa_range.end, ctx->hpa_range.start,
   157				ctx->hpa_range.end, dev_name(&cxld->dev));
   158			return -ENXIO;
   159		}
   160	
   161		ctx->hpa_range = hpa_range;
   162		ctx->interleave_ways = ways;
   163		ctx->interleave_granularity = gran;
   164	
   165		dev_dbg(&cxld->dev,
   166			"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
   167			dev_name(ctx->cxlmd->dev.parent), base, len, hpa_range.start,
   168			spa_len, ways, gran);
   169	
   170		return 0;
   171	}
   172	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
