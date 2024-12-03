Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84041C65
	for <linux-cxl@vger.kernel.org>; Tue,  3 Dec 2024 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188403; cv=none; b=lmO94BxCTx/9ediHu39i96QDlQqjOEF5NXX2TJXEoSYyc4KNb3/j83r1C8yaYJ1ETJcIZaihoEMlW0ELa+ewH4x0G4xNaTCmt4GXz9UTl4PH4Ugite+BgutFYBEpqDlXZ34dvmfojYZvqAMML+kuvTDuZrMVoHCv9e8SVIz+x3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188403; c=relaxed/simple;
	bh=rRMfud00nJu/mYxQdqFyTRhP8p8EKqi4ZmshJhc64P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhHg/aE9PDAf/oLS4NNIL0Wx4PnCxXTmMEQYbH5jdgmALIPF1KiT7K8SRRiQLpZMK5GTk74Yqe5VEV54LXsNBTNl9WzzsB+4IzT7rQc4MBDnPpLsnqmjIJJgVDKzeYx7uUmEwk5IyUS/9u2JhyvejGh54nGbCST1HgNXpzf+fpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXuIDvdm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXuIDvdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733188401; x=1764724401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rRMfud00nJu/mYxQdqFyTRhP8p8EKqi4ZmshJhc64P4=;
  b=iXuIDvdmbTcjhOXghsenfXDo9e19lCk5xDrBq2ZawQAiYwukelXoHiD1
   6BSCKHbPr2wddl9PTqKC85Cp6DHKBSWFjXAxk6dn+qft6d8rdNFm7G9e/
   26zxc8b4bUmrke8X2MvpS+4fQTgo8qMkCdeBTsfIpWdWbDfnbMeyE8OaB
   EAJKMTVReCMFv9+yXfkPvtImOfQgWxEs+v5JcZ68iSPK1sciFouxsLLC+
   QCQvCoQVa/5ML6/AvcE382iszT6YPCCa1M6guSQ2/jrMRNKQnsptS8dLU
   vMwR7M8r/8YbvQJelLv40vDnGp8x5VQSsyayvmN7IGkQ+j3Yt6UtriLrJ
   Q==;
X-CSE-ConnectionGUID: CnkO2V72SnGzm0tb4PtAxw==
X-CSE-MsgGUID: cwvgdpvbTpGHUHCAl5Z5kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32731445"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="32731445"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 17:13:20 -0800
X-CSE-ConnectionGUID: ORl33E53ST68iNeSzGdqcA==
X-CSE-MsgGUID: wGHzIpLERTqQVDf9hn/9Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98292773"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 02 Dec 2024 17:13:18 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIHTX-00036h-1r;
	Tue, 03 Dec 2024 01:13:15 +0000
Date: Tue, 3 Dec 2024 09:12:36 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>, alison.schofield@intel.com,
	dan.j.williams@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <202412030840.56S2Dv8L-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on cxl/next]
[also build test WARNING on tip/x86/core]
[cannot apply to linus/master cxl/pending v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nathan-Fontenot/cxl-Update-Soft-Reserved-resources-upon-region-creation/20241202-235757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20241202155542.22111-1-nathan.fontenot%40amd.com
patch subject: [PATCH] cxl: Update Soft Reserved resources upon region creation
config: arm64-randconfig-001-20241203 (https://download.01.org/0day-ci/archive/20241203/202412030840.56S2Dv8L-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030840.56S2Dv8L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030840.56S2Dv8L-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: insert_soft_reserve_resource+0x90 (section: .text.unlikely) -> acpi_table_parse_cedt (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
