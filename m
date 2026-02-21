Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B530DECE;
	Sat, 21 Feb 2026 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771670228; cv=none; b=LUcGshHXNx4z9qHq6YUjg2rQehC2tTtcvefxlQczwHLC/0ffnFtEN1XlTsctnj4LAN8ARITva5AYqBDgwEwpo9DtX7I6mpfwoTXXWpq27NSJHSMjPYRbOlZfNJtK46p2OZxCiRjWUC8xDL2sEFgdzSbSjRCskj94I5sTp+KT5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771670228; c=relaxed/simple;
	bh=8tztXBbje3m0zLy0pHyyhvBPUtSqAtzzxa49bmtgq6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZQ22bxcv/HwVnUlH6DhHvkr3ONDSj36jtVtO1tLjb6kgCNxt6I3rd5nj+XEyT1QalvMcEn3bnqnv8HMrQQnHucdPkC2tqsyE9mwxaWmLSKOJhqaOGQBRJYA2SNEysFqlwTmKrPGHQeqmg/jyCfYEoZpaoNlkC5pFLk270y7Xqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUz5fJHw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUz5fJHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771670227; x=1803206227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8tztXBbje3m0zLy0pHyyhvBPUtSqAtzzxa49bmtgq6o=;
  b=bUz5fJHw/px/8scCY2yfIlIo0NEtNHuZeb4wmiLFTx95Q22+bFzQaY0u
   +W/sNo/jiw/D7jk7miweVgJWCbV2kVfnosPKkOc12JNKoqC7eiVbGmV05
   e4mblrlCXGMyfu4R8YOghLPJNaZr/I94SRSX+keVqSMvyOkAewh/auWq4
   UR22I9w/+mdrGv+1gVcIEsna1xswajkml+CwqXGpHzuTn6uVQLmS0PKMm
   Zo62oGuekPSxtvq/qbkeraPDFZXuyHb9xHhFw1GY3kXhqrTAQia1lBuxU
   4lsObMAoO1iIiQqcFpMA7i0zZIlpV5W+tAcSD4brEeZMvEzOa2wLxPFMb
   w==;
X-CSE-ConnectionGUID: U8CJ7mjGSjyxlVvjnDJ5cA==
X-CSE-MsgGUID: fFjlhS4BTJ6Tc8Kq685jqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="76578104"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="76578104"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2026 02:37:06 -0800
X-CSE-ConnectionGUID: +vK9BSspS8qVzng+l2CLMQ==
X-CSE-MsgGUID: bJyp3RLaSLab5QyBozu1+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="245679599"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Feb 2026 02:37:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtkM8-000000014qq-18GF;
	Sat, 21 Feb 2026 10:37:00 +0000
Date: Sat, 21 Feb 2026 18:36:36 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 1/2] cxl/region: fix region leak when attach_target fails
 in cxl_add_to_region
Message-ID: <202602211806.TN3ENfmn-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260221/202602211806.TN3ENfmn-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260221/202602211806.TN3ENfmn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602211806.TN3ENfmn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/cxl/core/region.c:3964:4: error: call to undeclared function 'drop_region'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3964 |                         drop_region(cxlrd, cxlr);
         |                         ^
   1 error generated.


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
