Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC586FC3;
	Sat, 21 Feb 2026 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771674844; cv=none; b=lvOENTvgmZh1CbEamzytdKpbT40f0YXOCrw44TXSiXh35kik2o7jYHIF1V+mEhLjrsDXRg57iBB8Cu35bfxrXJWB+BRcKjVjvxlWbXmg/EjDyg0iACBu4WI2DQsibXaMqERGPOtp2wSPPKxNUu71IG/+2FW2XIc916EDmA0eBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771674844; c=relaxed/simple;
	bh=dgKcC2exrLX8LuLtBQ8GHknd+cf3zVoX32VHa3HY2CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0Rx4hxtMJBJfBoUjFai/iouBuGon8KOuvj0N3me74/BEWf1hX8yDv4z9cmxu/1avHeVwbOmrGY512HPAPIPRGlqXgDIPGZ5wu8DkDDMmvWdVwdTlUnaNJOYjTaAjOIPpvoFWPKJ9D46+cLXtQw89GPgod2drGQdZ48QmG6LPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEM1rxu6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEM1rxu6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771674844; x=1803210844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dgKcC2exrLX8LuLtBQ8GHknd+cf3zVoX32VHa3HY2CA=;
  b=lEM1rxu6WkdjFWbwkRaGyS6TEF5t9eCp3wNB7Ao8Ql/7M1s7ESqspmOm
   vqx2jdTtUbdW01AcWe3M6Y2kMrDlaDRvCDo8KmDzc3az+KVY2KL1iY3R7
   C7t37aBwPxzq34wrfQzKRNPO7eO+cZcKRYgqyJnAHb9UydPRAnChlOwZD
   6WPq3zXyK9gAR7rSv4+tIaeKbNWEdoF42OP+Ei5kBmz+Xb+66DRvhsk4D
   NwROpd16HJhyOgNwkNrXxB481k8vO0R1/7yxBiBksAZEGW33CPDX2AaP2
   BMK4BnnGWxvjTylTbndtXK6/3+YyyflKcmnL1J7Hjrg4fNeYWA4KU5z7I
   A==;
X-CSE-ConnectionGUID: an6dN41CSoqohf1Z3luFqQ==
X-CSE-MsgGUID: 4TQR0H0QS8GH0URPuLVioQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="83847106"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="83847106"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2026 03:54:04 -0800
X-CSE-ConnectionGUID: Zc4RfbZLSleJ8Bpn6H7xPg==
X-CSE-MsgGUID: Hi34OjvGSAyCf+QXL1nhCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214938301"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 21 Feb 2026 03:54:00 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtlYb-000000004Of-3Fib;
	Sat, 21 Feb 2026 11:53:57 +0000
Date: Sat, 21 Feb 2026 12:53:27 +0100
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 1/2] cxl/region: fix region leak when attach_target fails
 in cxl_add_to_region
Message-ID: <202602211252.7qKUA8jp-lkp@intel.com>
References: <20260221043013.1420169-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221043013.1420169-1-gourry@gourry.net>

Hi Gregory,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master next-20260220]
[cannot apply to cxl/pending v6.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/cxl-region-skip-default-driver-attach-for-memdev-with-attach-callbacks/20260221-123300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20260221043013.1420169-1-gourry%40gourry.net
patch subject: [PATCH 1/2] cxl/region: fix region leak when attach_target fails in cxl_add_to_region
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260221/202602211252.7qKUA8jp-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260221/202602211252.7qKUA8jp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602211252.7qKUA8jp-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cxl/core/region.c: In function 'cxl_add_to_region':
>> drivers/cxl/core/region.c:3964:25: error: implicit declaration of function 'drop_region' [-Wimplicit-function-declaration]
    3964 |                         drop_region(cxlrd, cxlr);
         |                         ^~~~~~~~~~~


vim +/drop_region +3964 drivers/cxl/core/region.c

  3920	
  3921	int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
  3922	{
  3923		struct cxl_region_context ctx;
  3924		struct cxl_region_params *p;
  3925		bool attach = false;
  3926		bool newly_created = false;
  3927		int rc;
  3928	
  3929		ctx = (struct cxl_region_context) {
  3930			.cxled = cxled,
  3931			.hpa_range = cxled->cxld.hpa_range,
  3932			.interleave_ways = cxled->cxld.interleave_ways,
  3933			.interleave_granularity = cxled->cxld.interleave_granularity,
  3934		};
  3935	
  3936		struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
  3937			get_cxl_root_decoder(cxled, &ctx);
  3938	
  3939		if (IS_ERR(cxlrd))
  3940			return PTR_ERR(cxlrd);
  3941	
  3942		/*
  3943		 * Ensure that, if multiple threads race to construct_region()
  3944		 * for the HPA range, one does the construction and the others
  3945		 * add to that.
  3946		 */
  3947		mutex_lock(&cxlrd->range_lock);
  3948		struct cxl_region *cxlr __free(put_cxl_region) =
  3949			cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
  3950		if (!cxlr) {
  3951			cxlr = construct_region(cxlrd, &ctx);
  3952			newly_created = !IS_ERR(cxlr);
  3953		}
  3954		mutex_unlock(&cxlrd->range_lock);
  3955	
  3956		rc = PTR_ERR_OR_ZERO(cxlr);
  3957		if (rc)
  3958			return rc;
  3959	
  3960		rc = attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
  3961		if (rc) {
  3962			/* If endpoint was just created, tear it down to release HPA */
  3963			if (newly_created)
> 3964				drop_region(cxlrd, cxlr);
  3965			return rc;
  3966		}
  3967	
  3968		scoped_guard(rwsem_read, &cxl_rwsem.region) {
  3969			p = &cxlr->params;
  3970			attach = p->state == CXL_CONFIG_COMMIT;
  3971		}
  3972	
  3973		if (attach) {
  3974			/*
  3975			 * If device_attach() fails the range may still be active via
  3976			 * the platform-firmware memory map, otherwise the driver for
  3977			 * regions is local to this file, so driver matching can't fail.
  3978			 */
  3979			if (device_attach(&cxlr->dev) < 0)
  3980				dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
  3981					p->res);
  3982		}
  3983	
  3984		return 0;
  3985	}
  3986	EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
  3987	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
