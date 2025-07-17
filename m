Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBC1A83FB
	for <linux-cxl@vger.kernel.org>; Thu, 17 Jul 2025 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752723203; cv=none; b=tmgfCcZj8+x+X1XkkpX3VUfnw7peEhFOv0dlQUQnDvGrT2lAxGlg1mNHtdnpUVljX2SKc8aVBZW/dbfxw6mmg//E1cOvQyvzkFXDA4PwAND7Gn3Ly6ZH0n9gvFml+KWD06Ifyrj8KXpBlWZ0ohnHT8qqNj6Cqhea0zYQwkTRrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752723203; c=relaxed/simple;
	bh=f3hxzSVHR5VI9sLIl5Ps1iRebpYpymn4j30kYKHxKI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsKGAJefAQtlUOe/d2QnkqqfcONtubSJdjmc880WqY2IP2IVDk/EamnyyM1JDNcuvcOo8sbFbqmlArd2xP5pxTVxizqR0VtZ9MoGomTfFZwwonzEhxhgxUJ5C5f3HbdXCU9OaJrQZJ+9jRwvTgYvUnj8hCHQSiHyCOQFYpX0brE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEseXih0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEseXih0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752723201; x=1784259201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f3hxzSVHR5VI9sLIl5Ps1iRebpYpymn4j30kYKHxKI8=;
  b=gEseXih00dgcYHjsKe3f3Qbmnt4YiUA17nPR8/fgPmnhP9IcoJcHhKhV
   TPcDlVuvup8QuEOYQJv8ENCtMWfBX+bJ88Mc+xFEPsNGexfzL294frisF
   dCr61XyXpZa4jZBrCFgK1oTFW/3Z9w/Of05lAigKASKz27A01Woz0wMRx
   vm1Yh9cw9yVQ4QW2Clkc9+TwywCZTHGCjZXwKeDflaL3oi3cQnYgYDtEa
   3TBkzxDzyDVZYzuWJTBR+NmELSGCMCRCRskX05xCrvbg5qe2oXlnzS4q9
   lIaaQ+6xXKoE8Gql9Zv9Vz0s+Lvw+AjNAAdfyHKJd37MY5AN4ZhV+2qme
   A==;
X-CSE-ConnectionGUID: W7IeOz9mQ5qpgXOyAgeIaw==
X-CSE-MsgGUID: CxD91wwmSvC093ppZ/ZuHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="66434795"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="66434795"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 20:33:21 -0700
X-CSE-ConnectionGUID: r1XFg/BMTFSw78OngHtvow==
X-CSE-MsgGUID: CG+pYBB0RoeUH6di2ThwIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="181364599"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2025 20:33:17 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucFMx-000D7L-0I;
	Thu, 17 Jul 2025 03:33:15 +0000
Date: Thu, 17 Jul 2025 11:32:30 +0800
From: kernel test robot <lkp@intel.com>
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, dave.jiang@intel.com,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	dave@stgolabs.net, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com, shiju.jose@huawei.com
Subject: Re: [PATCH 2/4] cxl/events: Add extra validity checks for corrected
 memory error count in General Media Event Record
Message-ID: <202507171153.p2RrAdN4-lkp@intel.com>
References: <20250716104945.2002-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716104945.2002-3-shiju.jose@huawei.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cxl/next]
[also build test WARNING on linus/master v6.16-rc6 next-20250716]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-events-Update-Common-Event-Record-to-CXL-spec-rev-3-2/20250716-192336
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20250716104945.2002-3-shiju.jose%40huawei.com
patch subject: [PATCH 2/4] cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record
config: arm-randconfig-004-20250717 (https://download.01.org/0day-ci/archive/20250717/202507171153.p2RrAdN4-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507171153.p2RrAdN4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507171153.p2RrAdN4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/mbox.c:933:27: warning: address of array 'evt->gen_media.cme_count' will always evaluate to 'true' [-Wpointer-bool-conversion]
     933 |                                              !evt->gen_media.cme_count);
         |                                              ~~~~~~~~~~~~~~~~^~~~~~~~~
   include/asm-generic/bug.h:148:18: note: expanded from macro 'WARN_ON_ONCE'
     148 |         DO_ONCE_LITE_IF(condition, WARN_ON, 1)
         |                         ^~~~~~~~~
   include/linux/once_lite.h:28:27: note: expanded from macro 'DO_ONCE_LITE_IF'
      28 |                 bool __ret_do_once = !!(condition);                     \
         |                                         ^~~~~~~~~
   1 warning generated.


vim +933 drivers/cxl/core/mbox.c

   888	
   889	void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
   890				    enum cxl_event_log_type type,
   891				    enum cxl_event_type event_type,
   892				    const uuid_t *uuid, union cxl_event *evt)
   893	{
   894		if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
   895			trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
   896			return;
   897		}
   898		if (event_type == CXL_CPER_EVENT_GENERIC) {
   899			trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
   900			return;
   901		}
   902	
   903		if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
   904			u64 dpa, hpa = ULLONG_MAX, hpa_alias = ULLONG_MAX;
   905			struct cxl_region *cxlr;
   906	
   907			/*
   908			 * These trace points are annotated with HPA and region
   909			 * translations. Take topology mutation locks and lookup
   910			 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
   911			 */
   912			guard(rwsem_read)(&cxl_region_rwsem);
   913			guard(rwsem_read)(&cxl_dpa_rwsem);
   914	
   915			dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
   916			cxlr = cxl_dpa_to_region(cxlmd, dpa);
   917			if (cxlr) {
   918				u64 cache_size = cxlr->params.cache_size;
   919	
   920				hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
   921				if (cache_size)
   922					hpa_alias = hpa - cache_size;
   923			}
   924	
   925			if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
   926				if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
   927					dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
   928	
   929				if (evt->gen_media.media_hdr.descriptor &
   930				    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
   931					WARN_ON_ONCE((evt->gen_media.media_hdr.type &
   932						      CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
 > 933						     !evt->gen_media.cme_count);
   934				else
   935					WARN_ON_ONCE(evt->gen_media.media_hdr.type &
   936						     CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
   937	
   938				trace_cxl_general_media(cxlmd, type, cxlr, hpa,
   939							hpa_alias, &evt->gen_media);
   940			} else if (event_type == CXL_CPER_EVENT_DRAM) {
   941				if (cxl_store_rec_dram((struct cxl_memdev *)cxlmd, evt))
   942					dev_dbg(&cxlmd->dev, "CXL store rec_dram failed\n");
   943	
   944				trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
   945					       &evt->dram);
   946			}
   947		}
   948	}
   949	EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, "CXL");
   950	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
