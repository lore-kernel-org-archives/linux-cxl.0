Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438FFAD39
	for <linux-cxl@vger.kernel.org>; Tue,  3 Dec 2024 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185963; cv=none; b=HAeV8ORt+KuP35hrWBv+eLJDd6Kx4q2Oh/27Ob6x21O0oMUUTtiuiCDlvO2Qkk/PEbxnUmXMtIG0hnP0bJKEPO/xC/lnKV6e/3QSKug2jwJnu+R2SwvIRumjMaATbTyjS2zLVHZi/vUUbAmHDtiPxatUF4Pxey7CqSJHgLRwiYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185963; c=relaxed/simple;
	bh=tc4KuYkMaQjD8Yv6z+HG3OsdK2KxchFXkKiWS7msvBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV4b/8tpp7l9sSIwtS2nTAn6ESvNR/NlDrzm5HnyEaei2xympFRgx2XkDFZw1sBn+80RqfrOCSmrvd4MTTQvatuHFWE8OMMcDSiKnD8EbF9ncVdb0dZulYPyWWDEP0z+XORIPjseC2mYh4Xqkb1c6Mi8jy/LJz92DpW291gPO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdDp+Mfr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdDp+Mfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733185961; x=1764721961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tc4KuYkMaQjD8Yv6z+HG3OsdK2KxchFXkKiWS7msvBc=;
  b=EdDp+MfrpvC4pcfpTgkjGSuNWQCvMrovF4jWO1txYoXK/scbb3VRg/fY
   amCuOt/zX3lwu2uskL8yeSr4dLXQmA2am/uSxhVFFpfEoa8bHpRj3Pux8
   K1263yvHsxU+UWhfleyW5p/8QOEtZSvKjIwP1rRcCWrlUQJosytaX+4Bo
   81lQyiR9d2ePDO6DIILaxA9h9RU16CfeKMzHBYnDd0JKoPkhGAb/VwH+q
   MHu7sEu9ZEP3l6mKj9mJ3utLxVBhJlSSxBCA+tvUY+ICacADA3TMZ/LOk
   n88zSu8PM/p1Ztqcj7WtB9X92LyODds+7qrQmtkmTE7kFT3PKJTPNuIqP
   Q==;
X-CSE-ConnectionGUID: iMKjxPcPR9G/tmvAi82UCg==
X-CSE-MsgGUID: 9Z5aWXGDRA6SRDQpLZx6/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33126954"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33126954"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 16:32:41 -0800
X-CSE-ConnectionGUID: S6x7zoaRQWGs8momJ4WX9A==
X-CSE-MsgGUID: ZzfdE6t9SR+rHau2C58lfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93157503"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Dec 2024 16:32:39 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIGq1-00034n-1g;
	Tue, 03 Dec 2024 00:32:32 +0000
Date: Tue, 3 Dec 2024 08:31:34 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>, alison.schofield@intel.com,
	dan.j.williams@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <202412030858.l8DbOnRQ-lkp@intel.com>
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202155542.22111-1-nathan.fontenot@amd.com>

Hi Nathan,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on tip/x86/core]
[cannot apply to linus/master cxl/pending v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nathan-Fontenot/cxl-Update-Soft-Reserved-resources-upon-region-creation/20241202-235757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20241202155542.22111-1-nathan.fontenot%40amd.com
patch subject: [PATCH] cxl: Update Soft Reserved resources upon region creation
config: arm-randconfig-004-20241203 (https://download.01.org/0day-ci/archive/20241203/202412030858.l8DbOnRQ-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030858.l8DbOnRQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030858.l8DbOnRQ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/resource.c:21:
   In file included from include/linux/pseudo_fs.h:4:
   In file included from include/linux/fs_context.h:14:
   In file included from include/linux/security.h:33:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/resource.c:1183:36: warning: declaration of 'union acpi_subtable_headers' will not be visible outside of this function [-Wvisibility]
    1183 | static int srmem_parse_cfmws(union acpi_subtable_headers *hdr,
         |                                    ^
>> kernel/resource.c:1212:2: error: call to undeclared function 'acpi_table_parse_cedt'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1212 |         acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
         |         ^
   kernel/resource.c:1212:2: note: did you mean 'acpi_table_parse'?
   include/linux/acpi.h:914:19: note: 'acpi_table_parse' declared here
     914 | static inline int acpi_table_parse(char *id,
         |                   ^
   2 warnings and 1 error generated.


vim +/acpi_table_parse_cedt +1212 kernel/resource.c

  1182	
> 1183	static int srmem_parse_cfmws(union acpi_subtable_headers *hdr,
  1184				     void *arg, const unsigned long unused)
  1185	{
  1186		struct acpi_cedt_cfmws *cfmws;
  1187		struct srmem_arg *args = arg;
  1188		struct resource cfmws_res;
  1189		struct resource *res;
  1190	
  1191		res = args->res;
  1192	
  1193		cfmws = (struct acpi_cedt_cfmws *)hdr;
  1194		cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
  1195					   cfmws->base_hpa + cfmws->window_size);
  1196	
  1197		if (resource_overlaps(&cfmws_res, res)) {
  1198			args->overlaps += 1;
  1199			return 1;
  1200		}
  1201	
  1202		return 0;
  1203	}
  1204	
  1205	static bool resource_overlaps_cfmws(struct resource *res)
  1206	{
  1207		struct srmem_arg arg = {
  1208			.res = res,
  1209			.overlaps = 0
  1210		};
  1211	
> 1212		acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
  1213	
  1214		if (arg.overlaps)
  1215			return true;
  1216	
  1217		return false;
  1218	}
  1219	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
