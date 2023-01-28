Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21070C61DA4
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 05:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjA1F3X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 28 Jan 2023 00:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA1F3W (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 28 Jan 2023 00:29:22 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF127AE73
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 21:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674883761; x=1706419761;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X0ptAT0cfSbvY5VVygGFU65u81HaZhs6kcj4hMF8xSw=;
  b=AMQWu4F1aGRP3/yQh8cHL9PV/58FHqEoyMfvyOn+noMIQkqkMtTHoC31
   sFfTqzt0mbXKKb3NimKTdtkgYhM5OMWcpzwt6pdaGefg7MaBbtkupyAvn
   8//PRUjXKTlqBGJRXptd8U5H8aiDkpPgCknebkeO4ELKvJwlGt8cEjrUn
   hLOpkj3c0l/R66cckYA8Rad/PVKVQ6RMHWJZdMPGa3MG9nJOmbuZCrIbM
   gCOJG8XosAawD/bXMxxesv1ePdd8gWIog/JgUJGL4EgEQRIdvHaI2lXts
   ERZ/cXUvntrci8NbGeyuIOwQjl0sBnr3MOLEnGIID+4qvX1Xwwyx6h5CG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310887869"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="310887869"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 21:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="693952255"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="693952255"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2023 21:29:18 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLdm9-0000Pt-24;
        Sat, 28 Jan 2023 05:29:17 +0000
Date:   Sat, 28 Jan 2023 13:28:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:for-6.3/cxl-ram-region 17/18] drivers/cxl/core/region.c:2404:6:
 warning: variable 'rc' is used uninitialized whenever 'if' condition is true
Message-ID: <202301281313.kVrIreUj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
head:   a7cf664d7e997ac36b0f466af2e2be33464ab598
commit: 3c6c8594f9a2bcb4af19bc8de669ed43834b8d7f [17/18] cxl/region: Add region autodiscovery
config: i386-randconfig-a012-20230123 (https://download.01.org/0day-ci/archive/20230128/202301281313.kVrIreUj-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=3c6c8594f9a2bcb4af19bc8de669ed43834b8d7f
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-6.3/cxl-ram-region
        git checkout 3c6c8594f9a2bcb4af19bc8de669ed43834b8d7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/cxl/core/region.c:1772:7: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
                   int rc;
                       ^
   drivers/cxl/core/region.c:1775:7: warning: variable 'rc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (!dev)
                       ^~~~
   drivers/cxl/core/region.c:1789:6: note: uninitialized use occurs here
           if (rc < 0)
               ^~
   drivers/cxl/core/region.c:1775:3: note: remove the 'if' if its condition is always true
                   if (!dev)
                   ^~~~~~~~~
   drivers/cxl/core/region.c:1766:8: note: initialize the variable 'rc' to silence this warning
           int rc;
                 ^
                  = 0
>> drivers/cxl/core/region.c:2404:6: warning: variable 'rc' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/cxl/core/region.c:2461:17: note: uninitialized use occurs here
           return ERR_PTR(rc);
                          ^~
   drivers/cxl/core/region.c:2404:2: note: remove the 'if' if its condition is always false
           if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/cxl/core/region.c:2387:8: note: initialize the variable 'rc' to silence this warning
           int rc;
                 ^
                  = 0
   3 warnings generated.


vim +2404 drivers/cxl/core/region.c

  2376	
  2377	/* Establish an empty region covering the given HPA range */
  2378	static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
  2379						   struct cxl_endpoint_decoder *cxled)
  2380	{
  2381		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
  2382		struct cxl_port *port = cxlrd_to_port(cxlrd);
  2383		struct range *hpa = &cxled->cxld.hpa_range;
  2384		struct cxl_region_params *p;
  2385		struct cxl_region *cxlr;
  2386		struct resource *res;
  2387		int rc;
  2388	
  2389		do {
  2390			cxlr = __create_region(cxlrd, cxled->mode,
  2391					       atomic_read(&cxlrd->region_id));
  2392		} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
  2393	
  2394		if (IS_ERR(cxlr)) {
  2395			dev_err(cxlmd->dev.parent,
  2396				"%s:%s: %s failed assign region: %ld\n",
  2397				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
  2398				__func__, PTR_ERR(cxlr));
  2399			return cxlr;
  2400		}
  2401	
  2402		down_write(&cxl_region_rwsem);
  2403		p = &cxlr->params;
> 2404		if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
  2405			dev_err(cxlmd->dev.parent,
  2406				"%s:%s: %s autodiscovery interrupted\n",
  2407				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
  2408				__func__);
  2409			goto err_intr;
  2410		}
  2411	
  2412		set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
  2413	
  2414		res = kmalloc(sizeof(*res), GFP_KERNEL);
  2415		if (!res) {
  2416			rc = -ENOMEM;
  2417			goto err_res;
  2418		}
  2419	
  2420		*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
  2421					    dev_name(&cxlr->dev));
  2422		rc = insert_resource(cxlrd->res, res);
  2423		if (rc) {
  2424			dev_dbg(cxlmd->dev.parent, "%s:%s: %s resource conflict: %d\n",
  2425				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
  2426				__func__, rc);
  2427			goto err_insert;
  2428		}
  2429	
  2430		p->res = res;
  2431		p->interleave_ways = cxled->cxld.interleave_ways;
  2432		p->interleave_granularity = cxled->cxld.interleave_granularity;
  2433		p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
  2434		/*
  2435		 * unregister_region() is now enabled and @res does not need
  2436		 * separate cleanup
  2437		 */
  2438	
  2439		rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
  2440		if (rc)
  2441			goto err_sysfs;
  2442	
  2443		dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
  2444			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
  2445			dev_name(&cxlr->dev), p->res, p->interleave_ways,
  2446			p->interleave_granularity);
  2447	
  2448		/* ...to match put_device() in cxl_add_to_region() */
  2449		get_device(&cxlr->dev);
  2450		up_write(&cxl_region_rwsem);
  2451	
  2452		return cxlr;
  2453	
  2454	err_insert:
  2455		kfree(res);
  2456	err_res:
  2457	err_sysfs:
  2458	err_intr:
  2459		up_write(&cxl_region_rwsem);
  2460		devm_release_action(port->uport, unregister_region, cxlr);
  2461		return ERR_PTR(rc);
  2462	}
  2463	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
