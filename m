Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A53EFD02;
	Thu,  5 Mar 2026 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740690; cv=none; b=J1GQtVhSs5gPiOhaCmQcQzNojGsZ5kV0plYf6Yvd4f89YDrbLaAeGE4l8h2j73vq2njqJuFvNsWy1Ae33QiQ5wX4Xo/BGP/ZmWCui7T+HomIK41Yqp+d2dj7z6+hIm4St3lwpJo8OIRK9vymSjuYfJFdGN9ykMH6PdfGqOjzf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740690; c=relaxed/simple;
	bh=X1M+FPVM7rzo88WluFXAAIF9cF5Qwod/VEt/zSY0gZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+ptZhfbEO5xTIdH53jRp7PsO9lDSCvzwfmQ/aQhTRNZnMKGMVatsQtrR2Jyooyns7m5PWJwZnJvfvBElX9N33xVotEi7JeeThKNKYdq43HvMmrtKXOta1l83qDlQayNqody1E3SY8e/Iv1YRzYwMHOTQAOudP+BiWbZENajHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ej9avsq5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ej9avsq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772740684; x=1804276684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X1M+FPVM7rzo88WluFXAAIF9cF5Qwod/VEt/zSY0gZ4=;
  b=ej9avsq5Uw/vU45/ktUV+RKVCpWi4XCxAgU366+miG0PgM3JMMUchcWz
   ngwfRPhbFOfkKxaAlz4kQvfybfq0GS+8Pcfjtknml+8mZMJzGGWVLihDv
   b9w8g27Ogq/HGfJ1TYdbtqmXqHe/PEoqkM1UGBf6jTDh75tmt/Qb/Ol4c
   RiuMBHCFCPxhbsyTfTnfBVcGDAL+oVIK0k3ctmjqYV6rqMsv5KbE/Koy9
   ks5QotduDYIWb/nlZSs14conHuKNFYTlzMc2P4nr7FUpQdpLqNExRExCl
   1qdmH6dThG+ungBoF8gg6lCvG2j5r7dGIVxR8yJhoXTxTCUw15KTfvbb/
   g==;
X-CSE-ConnectionGUID: 7AcTvyAbR6iYUamyOXHcTA==
X-CSE-MsgGUID: wIPnNGNpRl+YMunbQCcRiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77711975"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="77711975"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 11:58:03 -0800
X-CSE-ConnectionGUID: dcCYy1TnStur0EytdVQmNg==
X-CSE-MsgGUID: ZYariooLRNC+t4Neo3sgQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="218771907"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Mar 2026 11:58:00 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyEpY-000000001Ae-177i;
	Thu, 05 Mar 2026 19:57:56 +0000
Date: Fri, 6 Mar 2026 03:57:09 +0800
From: kernel test robot <lkp@intel.com>
To: Haifeng Xu <haifeng.xu@shopee.com>, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com
Cc: oe-kbuild-all@lists.linux.dev, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
Message-ID: <202603060345.jgq2PSAZ-lkp@intel.com>
References: <20260304080647.169434-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304080647.169434-1-haifeng.xu@shopee.com>

Hi Haifeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge cxl/next tip/x86/mm linus/master v7.0-rc2 next-20260305]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haifeng-Xu/ACPI-add-a-boot-parameter-to-disable-parsing-CFMWS-during-NUMA-init/20260304-160933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260304080647.169434-1-haifeng.xu%40shopee.com
patch subject: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS during NUMA init
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20260306/202603060345.jgq2PSAZ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603060345.jgq2PSAZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603060345.jgq2PSAZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/numa/srat.c:323:12: warning: no previous prototype for 'cfmws_disabled' [-Wmissing-prototypes]
     323 | int __init cfmws_disabled(void)
         |            ^~~~~~~~~~~~~~


vim +/cfmws_disabled +323 drivers/acpi/numa/srat.c

   322	
 > 323	int __init cfmws_disabled(void)
   324	{
   325		return cfmws_numa < 0;
   326	}
   327	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
