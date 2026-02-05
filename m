Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387EB2FFDFC
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313707; cv=none; b=I20wnzPf4oc1JyieK3FXcDIuptk+r/P+Vgi+GO9A0r9cpiKhLDu3VRoWBBqvnPSonnaTuGFQ0RofZLJ9Ovacwt4lYmqivMgfLceYp9BhtnPtrT5Ai5avJn5SSKkjc1/pduYUc4Av1F9MFp1ctHll25ZOMhZW47z66w0zOiafddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313707; c=relaxed/simple;
	bh=G40LrUIb+mkM87n0wkvUIvUGq5sI4wqIiUUGvPYKsv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSTTunhRdg4h2Qx9Hf9EkAv6ErO0MLyYFp62lffCteVFrge8xTl58Qgn4ea/oee9/oca04fm6sUsqvklXeGWQuzqqdLL27n33FMgvjKRL9EDmYXrxcoQdt5l58HM8s8dE9UXGZDCx68IRsXoa2ImRGyzYtyrM5NxC+VvJgtzRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMWVpBWt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMWVpBWt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770313707; x=1801849707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G40LrUIb+mkM87n0wkvUIvUGq5sI4wqIiUUGvPYKsv0=;
  b=QMWVpBWt5PsN5RrM/VeaLHG6tIH+UcOdbV2e37mjimpjzCPexwR/7E9g
   t++doB40vAiy7pGunUGkTPEMSq+vajn3Ep1Hlv/JvzVOiDyJfT0728FW/
   xgPAqbcdmMI+SuJs2NrMByiPgvCsb19kyJtSDLFVH8p1SSPgFFPQUk36T
   rZw3TKTF9JXYYI4tXgW4jQZX/+oBsW5vRDV8LoJgrCwcJ0WldAFOMUNCt
   Js1KgZjQX1x9AJi2M362ntbjnWeeJXqUQEq5sXkRSxNQawUOKNsISTNXh
   zeu3Awp4pvG05OEQnoK/SDH0NPX7+2r44mJTfY7/AW7QBIo447r4/jaSL
   w==;
X-CSE-ConnectionGUID: jIf0aSv2TAGnt/NkUt7kRg==
X-CSE-MsgGUID: 7hK8+4D2T3qzfBoNG0JrIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82887863"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82887863"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:48:26 -0800
X-CSE-ConnectionGUID: 7jnQ61z4TjeZJB9NyDfWXQ==
X-CSE-MsgGUID: iy3SFgTnS2O48tThf46k4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215578736"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 05 Feb 2026 09:48:24 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo3Sn-00000000k4W-3kl0;
	Thu, 05 Feb 2026 17:48:21 +0000
Date: Fri, 6 Feb 2026 01:47:48 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 2/2] cxl: Fix race of nvdimm_bus for the nvdimm_bridge
 object
Message-ID: <202602060104.uSyuffEI-lkp@intel.com>
References: <20260205001633.1813643-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205001633.1813643-3-dave.jiang@intel.com>

Hi Dave,

kernel test robot noticed the following build errors:

[auto build test ERROR on 18f7fcd5e69a04df57b563360b88be72471d6b62]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Jiang/cxl-test-Removal-of-nvdimm_bus_register-wrapper-in-cxl_test/20260205-081838
base:   18f7fcd5e69a04df57b563360b88be72471d6b62
patch link:    https://lore.kernel.org/r/20260205001633.1813643-3-dave.jiang%40intel.com
patch subject: [PATCH 2/2] cxl: Fix race of nvdimm_bus for the nvdimm_bridge object
config: parisc-randconfig-r061-20260205 (https://download.01.org/0day-ci/archive/20260206/202602060104.uSyuffEI-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260206/202602060104.uSyuffEI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602060104.uSyuffEI-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "nvdimm_bus_unregister" [drivers/cxl/core/cxl_core.ko] undefined!
>> ERROR: modpost: "nvdimm_provider_data" [drivers/cxl/core/cxl_core.ko] undefined!
>> ERROR: modpost: "nvdimm_bus_register" [drivers/cxl/core/cxl_core.ko] undefined!
>> ERROR: modpost: "nvdimm_cmd_mask" [drivers/cxl/core/cxl_core.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
