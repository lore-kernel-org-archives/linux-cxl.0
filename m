Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCBE1D958E
	for <linux-cxl@vger.kernel.org>; Mon,  2 Dec 2024 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166603; cv=none; b=ag751SdW/GW4/nC64m52SfsgSkO36qU8/hj8suAZY1QBF2V9PxiuHDGqIb+GloDCeFfCk9641Dnk/NdNDd4HMufugbKnYoonrUdIA1LlPWhOZPkHmgiSz9NBhswq5bw4VSJIX9VDONkJwZyefR+g89qAVOvtkUJfNfvtN1w01UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166603; c=relaxed/simple;
	bh=gyT4Q/GZAOYvmGMWc3B/psRBQ0+SVD2dOOfewimBQeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5gJauSRstjm3pwUuS2Ptta3WzFpuGTKQ/QTkO+xQJWv2e+hnUXVu/JETyIM6ISl1YQPquGt80gTXsa8prnH/xA5U38eFd9Jq5ZdQq9KhHwVzlJMdh67iltiZ9pb/dBGFsCFyXEF4YCpy9pisVRzr/na6e5EPT5pfoH+B6N4M+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwhFrUax; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwhFrUax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733166601; x=1764702601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gyT4Q/GZAOYvmGMWc3B/psRBQ0+SVD2dOOfewimBQeE=;
  b=nwhFrUaxVoLvDVrT1/YxZgYPyULreswozISC5u2t8NGbob8SHPes8BVF
   U+eEqvoGlrF/0FQQMiaGk3zUU6ZBAki1YQE3E1NQzhiyr0kKJlgSGL2iZ
   2xsEzK0TZwE/Xa14pkL/lAnfqPC3rdXtpkq2eflmhLoWgpJTKiEdwzNbU
   gScoGpVlQEfN5fmWNatbgeRxDhzdyWENY1GdlINfaDmih9LIs+ceIV8Ew
   P2rEdfCnjIAcLSwHhZmeuguBfSYpDLturNO9bzBVaq6jwDNQ0sOML14mI
   z+gTT5jAnDbhHAODUiN0ow3XcXS7etb/76A5GrRlGx/R2QQhUZlRYE1J0
   A==;
X-CSE-ConnectionGUID: Y2NCgGCCR4miMo/zAma0sQ==
X-CSE-MsgGUID: C+vbSXV2TfCyIUgcgOtK2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44740998"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44740998"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 11:10:01 -0800
X-CSE-ConnectionGUID: WQpqEmg7TcyxOrJmZRHh6w==
X-CSE-MsgGUID: Z+nYJEM6QwSPxsE0kovUag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="98177051"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 02 Dec 2024 11:09:59 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIBmV-0002nB-20;
	Mon, 02 Dec 2024 19:09:56 +0000
Date: Tue, 3 Dec 2024 03:00:34 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>, alison.schofield@intel.com,
	dan.j.williams@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <202412030237.JDiP8yCU-lkp@intel.com>
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
config: mips-ath79_defconfig (https://download.01.org/0day-ci/archive/20241203/202412030237.JDiP8yCU-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030237.JDiP8yCU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030237.JDiP8yCU-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> kernel/resource.c:1183:36: warning: 'union acpi_subtable_headers' declared inside parameter list will not be visible outside of this definition or declaration
    1183 | static int srmem_parse_cfmws(union acpi_subtable_headers *hdr,
         |                                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/resource.c: In function 'resource_overlaps_cfmws':
>> kernel/resource.c:1212:9: error: implicit declaration of function 'acpi_table_parse_cedt'; did you mean 'acpi_table_parse'? [-Wimplicit-function-declaration]
    1212 |         acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         acpi_table_parse


vim +1212 kernel/resource.c

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
