Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF924CEEA;
	Sun, 14 Dec 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765755658; cv=none; b=fbaPKlRRtx/zJKD1ZYMc0yTZBkkMn9Ti2Wfd9H/ZAGyQfB/OfyZQu0rUrG711WwjiWlJIxhTnF3sJJ9mWEK1Fo36QLxqc8QJB9dFyRMdQzFDjaejcPK0J5CMg0k5laKu+UHbPWt6VYqUtlaMMMeF+DPA48f4DW6IlZh4YmerQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765755658; c=relaxed/simple;
	bh=Mlgt7Ccfxy1QT1IHBHuoHmQIsUnImYHObHx+bbCZaZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niwopH7en8n6M7L4lC65uO0TSX7h1LgQcB+vS9DHQMVI7dYtwagBpYhMwpxOpRC9VIeIX96KiHHoiH/w2S0lDS1kG5j3XTlLJhoV/k4mCG124XE1DlUZ2+d+C3oZRswt4yBhiav7+l4b0qtMRj5pKmoc3Le2vGdYW2ttXD0hKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMQU++vn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMQU++vn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765755656; x=1797291656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mlgt7Ccfxy1QT1IHBHuoHmQIsUnImYHObHx+bbCZaZA=;
  b=iMQU++vnZZeMEBnFxRC4UMp/3W60e+SpvNFpmmoKo8A9xhRp/3ruToUc
   RHcd2g1FJqzZPWaUxDyT3EMth0d8IxbRsI6QFrTtc3XYfO50Jz9gndPpt
   q5vRAfbYmS/vFtuXxhz3ZKg1PGrF1MiMexMLt5bglrcQI0f5YMNmvBf8z
   shTBL4p3wOK9Mqk6gubG/RqIgeazDzLV5hTgZlJFrqOaXV/44Xvji5Lig
   cDiFzLNQ+RvaMQTePaj699qgMS8N82+4iqhXqDNnZ7czoRQtCkSWYaVJX
   IwPQdAs1Sl2J/uoscbtdSj3ti19vmAYSk2qxPYTWoKyaM6fBnDmb0rFSN
   Q==;
X-CSE-ConnectionGUID: RJVm/SyERDyDY7i9WIt/Lw==
X-CSE-MsgGUID: Z4d4CFo/Tq6YCCPAzLJzzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="67621405"
X-IronPort-AV: E=Sophos;i="6.21,148,1763452800"; 
   d="scan'208";a="67621405"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 15:40:56 -0800
X-CSE-ConnectionGUID: OPGiykANSoONaQBnqnHJfg==
X-CSE-MsgGUID: KmBC9UIHTyaJqP8C1eJ9Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,148,1763452800"; 
   d="scan'208";a="234973968"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Dec 2025 15:40:52 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUvhp-000000009Un-2WT3;
	Sun, 14 Dec 2025 23:40:49 +0000
Date: Mon, 15 Dec 2025 07:40:14 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v8 12/13] cxl: Check if ULLONG_MAX was returned from
 translation functions
Message-ID: <202512150712.0PH2z2O5-lkp@intel.com>
References: <20251209180659.208842-13-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209180659.208842-13-rrichter@amd.com>

Hi Robert,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ea5514e300568cbe8f19431c3e424d4791db8291]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/cxl-region-Rename-misleading-variable-name-hpa-to-hpa_range/20251210-021858
base:   ea5514e300568cbe8f19431c3e424d4791db8291
patch link:    https://lore.kernel.org/r/20251209180659.208842-13-rrichter%40amd.com
patch subject: [PATCH v8 12/13] cxl: Check if ULLONG_MAX was returned from translation functions
config: i386-randconfig-003-20251215 (https://download.01.org/0day-ci/archive/20251215/202512150712.0PH2z2O5-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251215/202512150712.0PH2z2O5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512150712.0PH2z2O5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/hdm.c:533:25: warning: implicit conversion from 'unsigned long long' to 'resource_size_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     533 |         resource_size_t base = ULLONG_MAX;
         |                         ~~~~   ^~~~~~~~~~
   include/vdso/limits.h:16:21: note: expanded from macro 'ULLONG_MAX'
      16 | #define ULLONG_MAX      (~0ULL)
         |                          ^~~~~
   1 warning generated.


vim +533 drivers/cxl/core/hdm.c

   530	
   531	resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
   532	{
 > 533		resource_size_t base = ULLONG_MAX;
   534	
   535		lockdep_assert_held(&cxl_rwsem.dpa);
   536		if (cxled->dpa_res)
   537			base = cxled->dpa_res->start;
   538	
   539		return base;
   540	}
   541	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
