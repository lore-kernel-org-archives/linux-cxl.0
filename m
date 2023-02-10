Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D76C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Feb 2023 16:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjBJQvp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Feb 2023 11:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjBJQvo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Feb 2023 11:51:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F99547088
        for <linux-cxl@vger.kernel.org>; Fri, 10 Feb 2023 08:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676047903; x=1707583903;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nSzng8kiRdDVACz4XJUD/Xl9rQMBEjR4hZY8l5ikNbY=;
  b=Uoos53AKdTur6+/ntmcMQPtYDkxIc8PwxErVvuW09hY/qrrJOv6Y/dUq
   wBSvWvpk/mQ9ESsH7+4o/bjEfSHgAaEVrWhDvAPnefK9OebxuqpflaDit
   fHu03LeJQY2XEyuXdDwcjt/ef/amOH/2k8ZIgXIVR+pKzoK6me8SYN+v0
   mx6tYFntQ7QE8tj/fwmAlacEqYLV7s5fgeQ3UW1v0qHHQ3qgRx8BWaCG2
   IYd/+kDCa2BT6rKBfkE9okPoCYS8uaZLqKYiGKs0UbDBlZdl36X0t1WFr
   fEregGrBzvViNywNYOXow70bIA9CmzHg/CNKT8PREYz0D0nhzR+fShscH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310095081"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310095081"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 08:51:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="645678483"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="645678483"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Feb 2023 08:51:40 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQWce-0005un-0Y;
        Fri, 10 Feb 2023 16:51:40 +0000
Date:   Sat, 11 Feb 2023 00:50:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:for-6.3/cxl-ram-region 21/28] drivers/cxl/core/region.c:2527:7:
 warning: Local variable 'rc' shadows outer variable [shadowVariable]
Message-ID: <202302110030.nDFn2KVK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
head:   58c651c6c4bbf46725502ffbccde2c24b94dc5c0
commit: eefc4eedc896b9b3af21a96657d00a9d3f4e88dd [21/28] cxl/region: Add region autodiscovery
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout eefc4eedc896b9b3af21a96657d00a9d3f4e88dd
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302110030.nDFn2KVK-lkp@intel.com/

cppcheck warnings: (new ones prefixed by >>)
>> drivers/cxl/core/region.c:2527:7: warning: Local variable 'rc' shadows outer variable [shadowVariable]
     int rc = device_attach(&cxlr->dev);
         ^
   drivers/cxl/core/region.c:2487:6: note: Shadowed declaration
    int rc;
        ^
   drivers/cxl/core/region.c:2527:7: note: Shadow variable
     int rc = device_attach(&cxlr->dev);
         ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   drivers/cxl/core/region.c:1626:5: warning: Redundant initialization for 'rc'. The initialized value is overwritten before it is read. [redundantInitialization]
    rc = cxl_region_validate_position(cxlr, cxled, pos);
       ^
   drivers/cxl/core/region.c:1527:9: note: rc is initialized
    int rc = -ENXIO;
           ^
   drivers/cxl/core/region.c:1626:5: note: rc is overwritten
    rc = cxl_region_validate_position(cxlr, cxled, pos);
       ^

vim +/rc +2527 drivers/cxl/core/region.c

  2476	
  2477	int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
  2478	{
  2479		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
  2480		struct range *hpa = &cxled->cxld.hpa_range;
  2481		struct cxl_decoder *cxld = &cxled->cxld;
  2482		struct cxl_root_decoder *cxlrd;
  2483		struct cxl_region_params *p;
  2484		struct cxl_region *cxlr;
  2485		bool attach = false;
  2486		struct device *dev;
  2487		int rc;
  2488	
  2489		dev = device_find_child(&root->dev, &cxld->hpa_range,
  2490					match_decoder_by_range);
  2491		if (!dev) {
  2492			dev_err(cxlmd->dev.parent,
  2493				"%s:%s no CXL window for range %#llx:%#llx\n",
  2494				dev_name(&cxlmd->dev), dev_name(&cxld->dev),
  2495				cxld->hpa_range.start, cxld->hpa_range.end);
  2496			return -ENXIO;
  2497		}
  2498	
  2499		cxlrd = to_cxl_root_decoder(dev);
  2500	
  2501		/*
  2502		 * Ensure that if multiple threads race to construct_region() for @hpa
  2503		 * one does the construction and the others add to that.
  2504		 */
  2505		mutex_lock(&cxlrd->range_lock);
  2506		dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
  2507					match_region_by_range);
  2508		if (!dev)
  2509			cxlr = construct_region(cxlrd, cxled);
  2510		else
  2511			cxlr = to_cxl_region(dev);
  2512		mutex_unlock(&cxlrd->range_lock);
  2513	
  2514		if (IS_ERR(cxlr)) {
  2515			rc = PTR_ERR(cxlr);
  2516			goto out;
  2517		}
  2518	
  2519		attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
  2520	
  2521		down_read(&cxl_region_rwsem);
  2522		p = &cxlr->params;
  2523		attach = p->state == CXL_CONFIG_COMMIT;
  2524		up_read(&cxl_region_rwsem);
  2525	
  2526		if (attach) {
> 2527			int rc = device_attach(&cxlr->dev);
  2528	
  2529			/*
  2530			 * If device_attach() fails the range may still be active via
  2531			 * the platform-firmware memory map, otherwise the driver for
  2532			 * regions is local to this file, so driver matching can't fail.
  2533			 */
  2534			if (rc < 0)
  2535				dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
  2536					p->res);
  2537		}
  2538	
  2539		put_device(&cxlr->dev);
  2540	out:
  2541		put_device(&cxlrd->cxlsd.cxld.dev);
  2542		return rc;
  2543	}
  2544	EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
  2545	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
