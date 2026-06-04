Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFEA131E49
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780544922; cv=none; b=BecIrfWIb7JSeNeDacY5wVUF2Yedo7IzsBuMtQ/Fl+Nmm0X/lZBjoGtHj+XcYTx+3Zx4mffHZur3FMUKUl3fGhWevZf6WJjV5Hi17lH6GkTx7+qY52D8+pZpeJX3dO9Yxf/5xUE6O5FT4A67fziohKUGAd/G+ciJQyfzV5gZjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780544922; c=relaxed/simple;
	bh=TldWsE2nakx3E1ggRuPq7kuEr225QXc8iC+RYF3l6WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAkgSxalhYBFzmnK5Ztt4EjZFmJNOj5QPImpXwJ9VolpvV76CoAy60WvfwLf02iUr1+yY7ZBTt9Se+WbItaYCKgRocWqe2bp5yjUmo0TTm6JxfzT3+y+O3dHlc50kVxbpfpqtNzJvP36CVaPxfOmn+BDOUQqJ29NE+DN+Nlhq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nC8JaxRd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nC8JaxRd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780544921; x=1812080921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TldWsE2nakx3E1ggRuPq7kuEr225QXc8iC+RYF3l6WE=;
  b=nC8JaxRdKzCXO8Wixfy9Rd2SknYuF4aRyyrmRBRo6Z0s55CX3eOq6koY
   wLUzA8shWJlpB3rIxHdBbLvD4yLnP3LsNNxDp2+ZycH3ky5tF9cQxt+c3
   sSIL3cqfXDtZpipsuUS0Q2LShFOfGoF6pCre3DfardmHCDQZ9iaz/+ATP
   VNAf5rW7Ko27A7otJ0CKXUNSGr0hGPu7AETt/6aNN3C6hidZYtMdgXJt8
   FIsAgIXzb/hqE6s6EsP0WisKr7fb3lVSWZToMLtpPQzN8xLwxcSSBr6HS
   M3jCVjZ8XYhfkuVvzkzp2WnOfsLef9osIsncM9xXRtNzzLzysSOfrYzof
   Q==;
X-CSE-ConnectionGUID: DH0etTIGRaO4kAw/i9jqdg==
X-CSE-MsgGUID: GbOT0BjvS6SsYHYyOCo7Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81363502"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81363502"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:48:40 -0700
X-CSE-ConnectionGUID: sMzQVWhvQsSxmWS5dTPicw==
X-CSE-MsgGUID: LzSDd30dRmWFKcf8f0hvqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241921433"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jun 2026 20:48:37 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUz4M-00000000EFK-2Pem;
	Thu, 04 Jun 2026 03:48:34 +0000
Date: Thu, 4 Jun 2026 11:47:45 +0800
From: kernel test robot <lkp@intel.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 6/6] Documentation/cxl: Add region granularity and
 multi-level interleave guide
Message-ID: <202606041115.8RwB2Cuv-lkp@intel.com>
References: <ef2ba341a7ed6f754012e11110750d57929575b2.1780095671.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2ba341a7ed6f754012e11110750d57929575b2.1780095671.git.alison.schofield@intel.com>

Hi Alison,

kernel test robot noticed the following build errors:

[auto build test ERROR on 254f49634ee16a731174d2ae34bc50bd5f45e731]

url:    https://github.com/intel-lab-lkp/linux/commits/Alison-Schofield/cxl-region-Validate-interleave-selector-bits/20260530-080529
base:   254f49634ee16a731174d2ae34bc50bd5f45e731
patch link:    https://lore.kernel.org/r/ef2ba341a7ed6f754012e11110750d57929575b2.1780095671.git.alison.schofield%40intel.com
patch subject: [PATCH 6/6] Documentation/cxl: Add region granularity and multi-level interleave guide
config: i386-randconfig-012-20250916 (https://download.01.org/0day-ci/archive/20260604/202606041115.8RwB2Cuv-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260604/202606041115.8RwB2Cuv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606041115.8RwB2Cuv-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/cxl/core/cxl_core.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
