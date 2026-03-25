Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF6C3E3153
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454165; cv=none; b=X0QMgEnn6xQKCju5jnqTb+1/CHOhmSCaAKQYl1ms6b/0Cxgr5sNumEDt2i23oqNoVY3wUK18r1DM535WkI/vS6Ny23PfTBzWnwWIZ6We0/JcwODEAw2qu2Bp/CBTnTgcN295TeC8qQQCef3e8GpUmDDjPTFeEfo4tqWlPublFFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454165; c=relaxed/simple;
	bh=ETNNaZJB4mo7GQzSxJ4Q+CxVG6UQiXC23/D8drAZme0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VO/E517pmeV7jyLb5hwwIyDCG3iNCyiv3uGjroKbBAgb7/s5o5s45t7RunQjq4iBNJf8W7Fn88qb9kgEznQg1g77n+qGx/orF/V+Eg+UFcjYI21tw+Egq53pKsObDp9ZPklhwr9RyXdFZJUMfS8NBrd2GNl4dObtDMRY1zPQ2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jx9lGiCb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jx9lGiCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774454164; x=1805990164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ETNNaZJB4mo7GQzSxJ4Q+CxVG6UQiXC23/D8drAZme0=;
  b=jx9lGiCbS9/reaEZJ44aw/0SZLlWheDaZDm/+U4rS2wU8sC1DIfdr7YH
   2C9gpABU1i8kCMXOJUosq5Hkx9N/yjRKbmWNgiADD+TOEwN5VR/TVA7uA
   WFhMlg4wboT/GrAAdtRuapoB6Xd1+ojzxW4HnIYcxrlsb/K4KKDqWIizV
   lT97JajMw6QjrQNRsG02DAnkKnSf++NK+6mzZRI7qHDWSow5/yAW2ueCn
   FnEWSNpywZmkIWotTPSVgcknWTzvoAXDy6mNVlN5+rDxIvqi6KyNeVUQ7
   ruBGBUEgi+4lDVumqOwYMfFC/kcDGcjc73u4XkIOdmUCGWerIV1TrJlfc
   A==;
X-CSE-ConnectionGUID: DUkkIgJPQhiCqElerLtvDg==
X-CSE-MsgGUID: 2ciWjT4sQZCswfa2ZxubVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75382846"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75382846"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:56:04 -0700
X-CSE-ConnectionGUID: GhcfkY8bS5CuIZu+B++SSQ==
X-CSE-MsgGUID: OYDtFZ/pTtqQJ+ZVinaaqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="229655557"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Mar 2026 08:56:02 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5QaM-000000007B7-3rTj;
	Wed, 25 Mar 2026 15:55:58 +0000
Date: Wed, 25 Mar 2026 23:55:09 +0800
From: kernel test robot <lkp@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: oe-kbuild-all@lists.linux.dev, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, dongjoo.seo1@samsung.com,
	anisa.su@samsung.com, linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: Re: [PATCH 1/1] cxl/mbox: Support Media Operation
Message-ID: <202603252348.nPuXnlRG-lkp@intel.com>
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
config: openrisc-randconfig-r071-20260325 (https://download.01.org/0day-ci/archive/20260325/202603252348.nPuXnlRG-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.3.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603252348.nPuXnlRG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603252348.nPuXnlRG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/cxl/core/mbox.c:908 expecting prototype for cxl_media_op_discover(). Prototype was for CXL_MEDIA_OP_MAX_OPS() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
