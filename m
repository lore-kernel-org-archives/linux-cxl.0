Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3A2BAF7
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682030; cv=none; b=UryHNkE+WTCTkuZLAEseeBDGazTQEpajhJG6xg++j9bK55J5Rcf8HwPYFoE+M4oneRAT+R5lS2RwrhpBVS77S06/Yp/gVQx799l+MGrxIo+PF1vjdLCE1j9cLIOTtkPZrJY8DM0T0g+DR9/t9bK+9tHRyqfJx2XiVk1tEKTgQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682030; c=relaxed/simple;
	bh=MNZ2eEoUcjd+c2yhCUrZCuSIP632z45uusR4g8TbTBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqR5W5ApOEkW/BE6SObQTRTrQNai6A641LH7761LDCg2Lgrnl0DReED32G85IrNvdG52hs8NYadMUTeoOZeVL7me+RIUPs3Hgx/g1CBfHdTITq7ItXdoKAC30JqgIIktasDwrS0mJXkVKfPNq8Z94OnyC7vzdBtpUHsHgdiq1Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3D3+2yn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3D3+2yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738682028; x=1770218028;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MNZ2eEoUcjd+c2yhCUrZCuSIP632z45uusR4g8TbTBw=;
  b=Z3D3+2ynghRsG69kWrCNQBhRQjrmJmTjzD/s7dCwIkfxfTMl7Ae6+PfE
   AhHzxjAMVI5fTdbJmM+rrlDcDJ10ERKfTdO8EpuscdQ5Zx06Kw7alQ8qn
   zIdU09A7rscA6mVauj7QRGZpU09GMM9MiuXqVH+BvRnIYhIFvSPNP1UKs
   llOAY6Vy5cjq4fKrifASeOUdwY9rbUKYm5uzC/MEICN3ZFr60Jk0u9Yf4
   TKrMIZdvjKuEX5RPhl9V/MpANMNTrApUyAK+4WKtqgSc47K5T6vkR526W
   YqZkOoSEFq2K7yvHfIxpMtGgnCeblGlMTxn3gNcfhqkBLvXB9LvNLki8q
   w==;
X-CSE-ConnectionGUID: 5CmQgWNBQkG5SOYPpyBkFQ==
X-CSE-MsgGUID: Ib/g2tQeShqwK12W8Z69Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39319254"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39319254"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 07:13:47 -0800
X-CSE-ConnectionGUID: 0Lof8Po7QjK9dp4vss3/UQ==
X-CSE-MsgGUID: u+6EvOvwRPudTozwc9X9gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110457174"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.57]) ([10.125.110.57])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 07:13:45 -0800
Message-ID: <2ef7503b-1b80-47ce-8ecd-b81fd280e0ae@intel.com>
Date: Tue, 4 Feb 2025 08:13:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cxl:next 1/1] drivers/cxl/core/pci.c:1103:9: warning: result of
 comparison of constant 18446744073709551615 with expression of type 'typeof
 (_Generic((base), char: (unsigned char)0, unsigned char: (unsigned char)0,
 signed char: (unsigned char)0, unsigned short: (unsign...
To: kernel test robot <lkp@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: oe-kbuild-all@lists.linux.dev,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <202502040454.Jtb55wW7-lkp@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <202502040454.Jtb55wW7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/3/25 1:13 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
> head:   0fd158c1ea0cc70434a52b4b812cbec4579b9f66
> commit: 0fd158c1ea0cc70434a52b4b812cbec4579b9f66 [1/1] cxl/pci: Support Global Persistent Flush (GPF)
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250204/202502040454.Jtb55wW7-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250204/202502040454.Jtb55wW7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502040454.Jtb55wW7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/cxl/core/pci.c:7:
>    In file included from include/linux/pci.h:1660:
>    In file included from include/linux/dmapool.h:14:
>    In file included from include/linux/scatterlist.h:8:
>    In file included from include/linux/mm.h:2224:
>    include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      505 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      512 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      525 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/cxl/core/pci.c:1103:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((base), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (base)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>     1103 |         ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);

Davidlohr,
It looks like setting 'base' and 'scale' to u64 quiets the compiler warning. Do you see any issues with that?

DJ

>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
>      115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
>       72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>       73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
>          |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       74 |                                  _pfx "type of reg too small for mask"); \
>          |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
>    include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
>      542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
>      530 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
>      522 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>>> drivers/cxl/core/pci.c:1104:10: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((scale), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (scale)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>     1104 |         ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
>      115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
>       72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>       73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
>          |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       74 |                                  _pfx "type of reg too small for mask"); \
>          |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
>    include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
>      542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
>      530 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
>      522 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    5 warnings generated.
> 
> 
> vim +1103 drivers/cxl/core/pci.c
> 
>   1074	
>   1075	static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>   1076	{
>   1077		u16 ctrl;
>   1078		int rc, offset, base, scale;
>   1079	
>   1080		switch (phase) {
>   1081		case 1:
>   1082			offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
>   1083			base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
>   1084			scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
>   1085			break;
>   1086		case 2:
>   1087			offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
>   1088			base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
>   1089			scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
>   1090			break;
>   1091		default:
>   1092			return -EINVAL;
>   1093		}
>   1094	
>   1095		rc = pci_read_config_word(pdev, dvsec + offset, &ctrl);
>   1096		if (rc)
>   1097			return rc;
>   1098	
>   1099		if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
>   1100		    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
>   1101			return 0;
>   1102	
>> 1103		ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);
>> 1104		ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
>   1105	
>   1106		rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
>   1107		if (!rc)
>   1108			pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
>   1109				phase, GPF_TIMEOUT_BASE_MAX);
>   1110	
>   1111		return rc;
>   1112	}
>   1113	
> 

