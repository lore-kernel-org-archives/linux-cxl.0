Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4132B9BF;
	Tue,  4 Nov 2025 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299345; cv=none; b=bfusF5Cvl4TzYXpPAGKfgUva/IUHezfW1kwk41F5GmNtyQY7A75WI9Ls0QFYNuIc3h41LnopE1DNcQW1c/om0KCSeo1wtL8xsqgSYaFGYS1QfnJjdC5SPWxcj8knbLCw4xIS8bXbP0jpHKQ1Fed2UmQ6n2QYk9i+OUGVAz3kbBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299345; c=relaxed/simple;
	bh=P8sM+279r/7jC+SZ4ufobrgc7rpxTIYv5eNtUj3Xros=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze7cEl4InAguuNzKHnfBf0HC8jZo53KgLdblVVvzxM+k5WS7cu8DVzu1HIRkaZYUqVJi+A4bh75iL+anoqyyuo3E9X5YG8V/3zKHcQsQOzlnL8qyuQF0NvEXckQEN0GElrOBWRdBEc1840lHh0M6JoeLF+EGJIM58MmLHk7MA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llBSXQFT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llBSXQFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762299343; x=1793835343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P8sM+279r/7jC+SZ4ufobrgc7rpxTIYv5eNtUj3Xros=;
  b=llBSXQFTXh38z34RDeEQx+bnwv4qTc7RylM+vDEKoyLvvuRxclb2OFyN
   kLkBVHLaPcerfwApAVxWatRZPrZFD1KQDp9KsfCAzyd0mIXZnZDt+fhqe
   mfSDfILuhlmntNYzznR1egRIdPAdNALHKCjDNZ+LhqKYfsOVDx+Cyjk5p
   Px8OhBP8FjcN9qBFxxCAUb09CEHO09YVHjRG1iZ6CRImq72Uuy/dIZ4dZ
   a0VSiGsMXlnYBJ+fmYeY3FXwKNHjxw2sFztPqaLfYdBJp1v1fE8AhWYNi
   eeVTggxZxYECB48sMkL5p1hbblw5XEjdVXk+LFMM7v5ZTXIYfCkNDaeSs
   Q==;
X-CSE-ConnectionGUID: z8NLg7juRECFA6c+p/M8Iw==
X-CSE-MsgGUID: q/MkU720Q6qECM+mm88ToA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64505244"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="64505244"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:35:43 -0800
X-CSE-ConnectionGUID: tXH83n4/T8+V0cnwP08HyQ==
X-CSE-MsgGUID: SymAw6/0SNeK+eYx1M/4Iw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Nov 2025 15:35:39 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGQYr-000Rw4-1Z;
	Tue, 04 Nov 2025 23:35:37 +0000
Date: Wed, 5 Nov 2025 07:35:28 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 10/14] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <202511050720.Hy1VQf0n-lkp@intel.com>
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
config: x86_64-randconfig-071-20251105 (https://download.01.org/0day-ci/archive/20251105/202511050720.Hy1VQf0n-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511050720.Hy1VQf0n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511050720.Hy1VQf0n-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cxl/core/atl.c: In function 'cxl_prm_translate_hpa_range':
>> drivers/cxl/core/atl.c:63:49: error: invalid use of undefined type 'struct cxl_region_context'
      63 |         struct cxl_endpoint_decoder *cxled = ctx->cxled;
         |                                                 ^~
   drivers/cxl/core/atl.c:65:39: error: invalid use of undefined type 'struct cxl_region_context'
      65 |         struct cxl_memdev *cxlmd = ctx->cxlmd;
         |                                       ^~
   drivers/cxl/core/atl.c:66:37: error: invalid use of undefined type 'struct cxl_region_context'
      66 |         struct range hpa_range = ctx->hpa_range;
         |                                     ^~
   drivers/cxl/core/atl.c:92:16: error: invalid use of undefined type 'struct cxl_region_context'
      92 |         if (ctx->interleave_ways != 1) {
         |                ^~
   In file included from include/linux/device.h:15,
                    from include/linux/pci.h:37,
                    from drivers/cxl/core/atl.c:7:
   drivers/cxl/core/atl.c:94:28: error: invalid use of undefined type 'struct cxl_region_context'
      94 |                         ctx->interleave_ways, ctx->interleave_granularity);
         |                            ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:93:17: note: in expansion of macro 'dev_dbg'
      93 |                 dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granularity: %d\n",
         |                 ^~~~~~~
   drivers/cxl/core/atl.c:94:50: error: invalid use of undefined type 'struct cxl_region_context'
      94 |                         ctx->interleave_ways, ctx->interleave_granularity);
         |                                                  ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:93:17: note: in expansion of macro 'dev_dbg'
      93 |                 dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granularity: %d\n",
         |                 ^~~~~~~
   drivers/cxl/core/atl.c:114:60: error: invalid use of undefined type 'struct cxl_region_context'
     114 |                         hpa_range.start, hpa_range.end, ctx->hpa_range.start,
         |                                                            ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:112:17: note: in expansion of macro 'dev_dbg'
     112 |                 dev_dbg(cxld->dev.parent,
         |                 ^~~~~~~
   drivers/cxl/core/atl.c:115:28: error: invalid use of undefined type 'struct cxl_region_context'
     115 |                         ctx->hpa_range.end, dev_name(&cxld->dev));
         |                            ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:112:17: note: in expansion of macro 'dev_dbg'
     112 |                 dev_dbg(cxld->dev.parent,
         |                 ^~~~~~~
   drivers/cxl/core/atl.c:130:60: error: invalid use of undefined type 'struct cxl_region_context'
     130 |                         hpa_range.start, hpa_range.end, ctx->hpa_range.start,
         |                                                            ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:128:17: note: in expansion of macro 'dev_dbg'
     128 |                 dev_dbg(cxld->dev.parent,
         |                 ^~~~~~~
   drivers/cxl/core/atl.c:131:28: error: invalid use of undefined type 'struct cxl_region_context'
     131 |                         ctx->hpa_range.end, dev_name(&cxld->dev));
         |                            ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:128:17: note: in expansion of macro 'dev_dbg'
     128 |                 dev_dbg(cxld->dev.parent,
         |                 ^~~~~~~
   drivers/cxl/core/atl.c:156:60: error: invalid use of undefined type 'struct cxl_region_context'
     156 |                         hpa_range.start, hpa_range.end, ctx->hpa_range.start,
         |                                                            ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:154:17: note: in expansion of macro 'dev_dbg'
     154 |                 dev_dbg(cxld->dev.parent,
         |                 ^~~~~~~
   drivers/cxl/core/atl.c:157:28: error: invalid use of undefined type 'struct cxl_region_context'
     157 |                         ctx->hpa_range.end, dev_name(&cxld->dev));
         |                            ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/cxl/core/atl.c:154:17: note: in expansion of macro 'dev_dbg'
     154 |                 dev_dbg(cxld->dev.parent,
         |                 ^~~~~~~
   drivers/cxl/core/atl.c:161:12: error: invalid use of undefined type 'struct cxl_region_context'
     161 |         ctx->hpa_range = hpa_range;
         |            ^~
   drivers/cxl/core/atl.c:162:12: error: invalid use of undefined type 'struct cxl_region_context'
     162 |         ctx->interleave_ways = ways;
         |            ^~
   drivers/cxl/core/atl.c:163:12: error: invalid use of undefined type 'struct cxl_region_context'
     163 |         ctx->interleave_granularity = gran;
         |            ^~
   drivers/cxl/core/atl.c:167:29: error: invalid use of undefined type 'struct cxl_region_context'
     167 |                 dev_name(ctx->cxlmd->dev.parent), base, len, hpa_range.start,
         |                             ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \


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
