Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858F3D3D07
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446462; cv=none; b=sUf8lfZ8IpXe565BbLOwxDSQlSpxqDKz8OnCTk391rkWAXCEhAVVevD5wC0Li4/vk8JstyCm4OerRaT3KUFW3Hnm07/Nz14s8QdLvC5m9Gym43947HsQeOs620q9WmY0Ef1ogx5gm0cELZChy/zAYEXfYsxysni5OULVHYaMI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446462; c=relaxed/simple;
	bh=V5z01KaJq8+1MYQjF2fqLPNjo41qg5v5E0aGVbdTNOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD5836sfIX+15gM2GADyZOq0613gtmIogrkH2FzWV1chFE2Y+k25gbSd1nK6UAXW1z+bMZl3XsPkr5Fa5gG5nrPFlzcS2/sploEvkg2LgIbfK/mtojVE3UGAkWfMh9KIrUWLvqpOlzXu533v3y+a3LbbsZc7ULGkQgr8coiC1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiQjqsen; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiQjqsen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774446455; x=1805982455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V5z01KaJq8+1MYQjF2fqLPNjo41qg5v5E0aGVbdTNOM=;
  b=NiQjqsenk0682VGH/dB03wZ2l3mImuuyanUctpzf0Ey5quxFyiCNzyZP
   Uoo8iI8YSbRiIfXpBUqgdmHjlbxijXPvoOp1nS5FYq0auQOcF2ir2p0ob
   X18e5WXo8Ex092AHCtjQI3woXeK7X48ojYtMV1vacNN6CAikhK0rq3ip/
   S/EvBToDWc5Rw0jxj0pqiZvRyBDzIgSol99Q8CRqZxe9BChTsGyNiqIDJ
   ru+88l2O3eiWYsTodXDzsf63jqPFr0U3WfGeqp6mcIsnIALv5dNruAmEi
   A6i5wfjh5r7mkYAQIs4dkYxhD4XADKL/wf/Vi6gg/LkW8kiNi5BLMUdlU
   g==;
X-CSE-ConnectionGUID: GQG2oOJRTCeEDQis8v5Dtw==
X-CSE-MsgGUID: g35L3JKeTVKt8PiCJKjhiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86960034"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="86960034"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:47:33 -0700
X-CSE-ConnectionGUID: Hrnx+0ijR+qLI9i4z6l3BQ==
X-CSE-MsgGUID: c+seg8dcQTmuIoqRmnH0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="220282040"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 25 Mar 2026 06:47:31 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5Oa0-00000000761-3lgN;
	Wed, 25 Mar 2026 13:47:28 +0000
Date: Wed, 25 Mar 2026 14:47:08 +0100
From: kernel test robot <lkp@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: oe-kbuild-all@lists.linux.dev, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, dongjoo.seo1@samsung.com,
	anisa.su@samsung.com, linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: Re: [PATCH 1/1] cxl/mbox: Support Media Operation
Message-ID: <202603251458.SwLIShRj-lkp@intel.com>
References: <20260323204013.4010634-2-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323204013.4010634-2-dave@stgolabs.net>

Hi Davidlohr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cxl/next]
[also build test WARNING on next-20260324]
[cannot apply to linus/master cxl/pending v7.0-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Davidlohr-Bueso/cxl-mbox-Support-Media-Operation/20260325-172343
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20260323204013.4010634-2-dave%40stgolabs.net
patch subject: [PATCH 1/1] cxl/mbox: Support Media Operation
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260325/202603251458.SwLIShRj-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603251458.SwLIShRj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603251458.SwLIShRj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/cxl/core/mbox.c:908 expecting prototype for cxl_media_op_discover(). Prototype was for CXL_MEDIA_OP_MAX_OPS() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
