Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C12E62B5
	for <linux-cxl@vger.kernel.org>; Sat, 14 Feb 2026 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771043657; cv=none; b=gFcGgRZSruixpBr/Di6jllZhk3gfzTj9h7Kszd9qP9bfjQTKdZq3m4dg3ZWcwED/WUBrfzS7HA+BvjexP8TbYcmkewj2Iy2OEkoxEorIdTwGGocbU+VDCjaSX2Nuo3ewfygt6tQRuCNCaHE6/yc8xy3TkEngX6jkk3rF3WP+I04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771043657; c=relaxed/simple;
	bh=aiUZzn44P7TsJTdKDUDcfUm2UCHqM/TussKifHEIUEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJ092hq6cYUPZ3VFUlZR28VF5MCYmkp0tSgx69aJp2TxiCU+epNvCv8rJ/F5IY6wIkJMPD7zyTX8NhHfD1PPeMxFg9anh/13wZRfWAaHVPYyLL9jfnR5QeF/GqdOkGOFy3Z4Zb67xWF43heJYQAA/BJT69CGjDl74ms+k4feAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRPviRny; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRPviRny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771043653; x=1802579653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aiUZzn44P7TsJTdKDUDcfUm2UCHqM/TussKifHEIUEo=;
  b=cRPviRnyF3LysNllN5QVxzwFiyvpVKgiGCyZ8EXqW46qJ91IyoGDw2dD
   dOWI1InY9+kq/JLCZBBVAvXU3mXl0/NtDm/Ea4mSJPIwxbXjxngMtSu9O
   EqCawiL18GswoA48z/sgY1N5bX/xa8CUDnsLWxrURQXtWrUaQUTgYb31f
   D4S97o2iaRAaQAg8m/N3IhCAGyeSpLlzmEa3NaY1TsaiHHLNsbRd/YtYU
   xhxuiK9gxqHBAcoYAxYrrEHjo1132cAXQPABRTMXJMcaZIkELcoNyPB98
   m/HxXZO57tXv3AcKfHT08GzQFynblDp2DXSVpOk9sFYz4U8o0pXKOU9Dn
   A==;
X-CSE-ConnectionGUID: 83SFGpQtS6yeS7pgshWpeA==
X-CSE-MsgGUID: 7Xgk5eb7Q1yu1WkdsGCWhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72128180"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="72128180"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 20:34:12 -0800
X-CSE-ConnectionGUID: OBzX8pdZRoaYiQ6W1GROvA==
X-CSE-MsgGUID: XVpvDw/qRjaWeOh0OBdGcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="217215968"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Feb 2026 20:34:10 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vr7M8-00000000wDg-0RY8;
	Sat, 14 Feb 2026 04:34:08 +0000
Date: Sat, 14 Feb 2026 12:33:44 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v3 1/2] cxl: Move devm_cxl_add_nvdimm_bridge() to
 cxl_pmem.ko
Message-ID: <202602141202.umHQ46td-lkp@intel.com>
References: <20260213224038.549798-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213224038.549798-2-dave.jiang@intel.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 63fbf275fa9f18f7020fb8acf54fa107e51d0f23]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Jiang/cxl-Move-devm_cxl_add_nvdimm_bridge-to-cxl_pmem-ko/20260214-064242
base:   63fbf275fa9f18f7020fb8acf54fa107e51d0f23
patch link:    https://lore.kernel.org/r/20260213224038.549798-2-dave.jiang%40intel.com
patch subject: [PATCH v3 1/2] cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko
config: powerpc64-randconfig-002-20260214 (https://download.01.org/0day-ci/archive/20260214/202602141202.umHQ46td-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260214/202602141202.umHQ46td-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602141202.umHQ46td-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/cxl/pmem.c:24 expecting prototype for __devm_cxl_add_nvdimm_bridge(). Prototype was for devm_cxl_add_nvdimm_bridge() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
