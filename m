Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFE6C001B0
	for <linux-cxl@archiver.kernel.org>; Sat, 15 Jul 2023 02:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjGOCDD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 22:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjGOCDC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 22:03:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B41BEB
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 19:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689386571; x=1720922571;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=87NLTqJhwjITkyX61/dEteUq9vdfCzTqw9XvpTVICp4=;
  b=MIx7v+jKYFR8/Z3vPZD7pI1DMGxdkXbbn/qc9+8F303dO2pY6yRBqhj/
   cXqSK7ddAtiS+smRwnk25Uz+0E+zMPEjmu9dsxl8QvhpvTgoZwNnVrFVZ
   9y1SjXOT6N5kqvsUP62um5gzkvtllsdJreX8+Se134hxvzECnQypbRPKm
   /rrvyli2uwlOhnwx8yp5aLP/9uKCFyNIXERQHwjbpjUzc3t4EuDrzywR4
   iQXEY6NDxFmmcwmvT/p/xMLGRQ8SarqZgGd8TiVSfxadIgZSneiZ1rKBH
   P/zGeIgSAKsgzYxsz5H8AMpzGJJD15AxqJStrpUbThQzCM3KFjN1BGPI7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="369169100"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="369169100"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 19:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="846675313"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="846675313"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2023 19:02:48 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKUcR-0007pr-23;
        Sat, 15 Jul 2023 02:02:47 +0000
Date:   Sat, 15 Jul 2023 10:02:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:fixes 4/5] drivers/cxl/acpi.c:299:30: warning: format '%llx'
 expects argument of type 'long long unsigned int', but argument 3 has type
 'resource_size_t' {aka 'unsigned int'}
Message-ID: <202307151059.2vvBt55H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
head:   0e99e96b85fc2c608a65d05063f40c671214b2da
commit: 3840e10e8dcafc89a2d96ab7dbb640434c8da8cf [4/5] cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()
config: i386-randconfig-i005-20230714 (https://download.01.org/0day-ci/archive/20230715/202307151059.2vvBt55H-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230715/202307151059.2vvBt55H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307151059.2vvBt55H-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/cxl/acpi.c:3:
   drivers/cxl/acpi.c: In function 'cxl_parse_cfmws':
>> drivers/cxl/acpi.c:299:30: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     299 |                 dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/cxl/acpi.c:299:17: note: in expansion of macro 'dev_err'
     299 |                 dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
         |                 ^~~~~~~
   drivers/cxl/acpi.c:299:63: note: format string is defined here
     299 |                 dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
         |                                                           ~~~~^
         |                                                               |
         |                                                               long long unsigned int
         |                                                           %#x
   drivers/cxl/acpi.c:299:30: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     299 |                 dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/cxl/acpi.c:299:17: note: in expansion of macro 'dev_err'
     299 |                 dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
         |                 ^~~~~~~
   drivers/cxl/acpi.c:299:71: note: format string is defined here
     299 |                 dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
         |                                                                   ~~~~^
         |                                                                       |
         |                                                                       long long unsigned int
         |                                                                   %#x


vim +299 drivers/cxl/acpi.c

f4ce1f766f1ebf Dan Williams     2021-10-29  196  
f4ce1f766f1ebf Dan Williams     2021-10-29  197  static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
f4ce1f766f1ebf Dan Williams     2021-10-29  198  			   const unsigned long end)
3e23d17ce1980c Alison Schofield 2021-06-17  199  {
a5c25802168993 Dan Williams     2021-09-08  200  	int target_map[CXL_DECODER_MAX_INTERLEAVE];
f4ce1f766f1ebf Dan Williams     2021-10-29  201  	struct cxl_cfmws_context *ctx = arg;
f4ce1f766f1ebf Dan Williams     2021-10-29  202  	struct cxl_port *root_port = ctx->root_port;
974854ab072853 Dan Williams     2022-07-12  203  	struct resource *cxl_res = ctx->cxl_res;
f9db85bfec0dcc Alison Schofield 2022-11-30  204  	struct cxl_cxims_context cxims_ctx;
0f157c7fa1a0e1 Dan Williams     2022-07-12  205  	struct cxl_root_decoder *cxlrd;
f4ce1f766f1ebf Dan Williams     2021-10-29  206  	struct device *dev = ctx->dev;
3e23d17ce1980c Alison Schofield 2021-06-17  207  	struct acpi_cedt_cfmws *cfmws;
f9db85bfec0dcc Alison Schofield 2022-11-30  208  	cxl_calc_hb_fn cxl_calc_hb;
3e23d17ce1980c Alison Schofield 2021-06-17  209  	struct cxl_decoder *cxld;
419af595b11891 Dan Williams     2022-05-22  210  	unsigned int ways, i, ig;
974854ab072853 Dan Williams     2022-07-12  211  	struct resource *res;
419af595b11891 Dan Williams     2022-05-22  212  	int rc;
3e23d17ce1980c Alison Schofield 2021-06-17  213  
f4ce1f766f1ebf Dan Williams     2021-10-29  214  	cfmws = (struct acpi_cedt_cfmws *) header;
3e23d17ce1980c Alison Schofield 2021-06-17  215  
3e23d17ce1980c Alison Schofield 2021-06-17  216  	rc = cxl_acpi_cfmws_verify(dev, cfmws);
3e23d17ce1980c Alison Schofield 2021-06-17  217  	if (rc) {
3e23d17ce1980c Alison Schofield 2021-06-17  218  		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
f4ce1f766f1ebf Dan Williams     2021-10-29  219  			cfmws->base_hpa,
f4ce1f766f1ebf Dan Williams     2021-10-29  220  			cfmws->base_hpa + cfmws->window_size - 1);
f4ce1f766f1ebf Dan Williams     2021-10-29  221  		return 0;
3e23d17ce1980c Alison Schofield 2021-06-17  222  	}
3e23d17ce1980c Alison Schofield 2021-06-17  223  
c99b2e8cf79616 Dave Jiang       2022-12-05  224  	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
419af595b11891 Dan Williams     2022-05-22  225  	if (rc)
419af595b11891 Dan Williams     2022-05-22  226  		return rc;
83351ddb786b30 Dave Jiang       2022-12-05  227  	rc = eig_to_granularity(cfmws->granularity, &ig);
419af595b11891 Dan Williams     2022-05-22  228  	if (rc)
419af595b11891 Dan Williams     2022-05-22  229  		return rc;
419af595b11891 Dan Williams     2022-05-22  230  	for (i = 0; i < ways; i++)
a5c25802168993 Dan Williams     2021-09-08  231  		target_map[i] = cfmws->interleave_targets[i];
a5c25802168993 Dan Williams     2021-09-08  232  
974854ab072853 Dan Williams     2022-07-12  233  	res = kzalloc(sizeof(*res), GFP_KERNEL);
974854ab072853 Dan Williams     2022-07-12  234  	if (!res)
974854ab072853 Dan Williams     2022-07-12  235  		return -ENOMEM;
974854ab072853 Dan Williams     2022-07-12  236  
974854ab072853 Dan Williams     2022-07-12  237  	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
974854ab072853 Dan Williams     2022-07-12  238  	if (!res->name)
974854ab072853 Dan Williams     2022-07-12  239  		goto err_name;
974854ab072853 Dan Williams     2022-07-12  240  
974854ab072853 Dan Williams     2022-07-12  241  	res->start = cfmws->base_hpa;
974854ab072853 Dan Williams     2022-07-12  242  	res->end = cfmws->base_hpa + cfmws->window_size - 1;
974854ab072853 Dan Williams     2022-07-12  243  	res->flags = IORESOURCE_MEM;
974854ab072853 Dan Williams     2022-07-12  244  
974854ab072853 Dan Williams     2022-07-12  245  	/* add to the local resource tracking to establish a sort order */
974854ab072853 Dan Williams     2022-07-12  246  	rc = insert_resource(cxl_res, res);
974854ab072853 Dan Williams     2022-07-12  247  	if (rc)
974854ab072853 Dan Williams     2022-07-12  248  		goto err_insert;
974854ab072853 Dan Williams     2022-07-12  249  
f9db85bfec0dcc Alison Schofield 2022-11-30  250  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
f9db85bfec0dcc Alison Schofield 2022-11-30  251  		cxl_calc_hb = cxl_hb_modulo;
f9db85bfec0dcc Alison Schofield 2022-11-30  252  	else
f9db85bfec0dcc Alison Schofield 2022-11-30  253  		cxl_calc_hb = cxl_hb_xor;
f9db85bfec0dcc Alison Schofield 2022-11-30  254  
f9db85bfec0dcc Alison Schofield 2022-11-30  255  	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
0f157c7fa1a0e1 Dan Williams     2022-07-12  256  	if (IS_ERR(cxlrd))
f4ce1f766f1ebf Dan Williams     2021-10-29  257  		return 0;
3e23d17ce1980c Alison Schofield 2021-06-17  258  
0f157c7fa1a0e1 Dan Williams     2022-07-12  259  	cxld = &cxlrd->cxlsd.cxld;
48667f676189ec Dan Williams     2021-09-21  260  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
5aa39a9165cfc8 Dan Williams     2023-06-14  261  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
e50fe01e1f2a4a Dan Williams     2022-05-18  262  	cxld->hpa_range = (struct range) {
974854ab072853 Dan Williams     2022-07-12  263  		.start = res->start,
974854ab072853 Dan Williams     2022-07-12  264  		.end = res->end,
e50fe01e1f2a4a Dan Williams     2022-05-18  265  	};
419af595b11891 Dan Williams     2022-05-22  266  	cxld->interleave_ways = ways;
e77483055c325f Dan Williams     2022-07-22  267  	/*
e77483055c325f Dan Williams     2022-07-22  268  	 * Minimize the x1 granularity to advertise support for any
e77483055c325f Dan Williams     2022-07-22  269  	 * valid region granularity
e77483055c325f Dan Williams     2022-07-22  270  	 */
e77483055c325f Dan Williams     2022-07-22  271  	if (ways == 1)
e77483055c325f Dan Williams     2022-07-22  272  		ig = CXL_DECODER_MIN_GRANULARITY;
419af595b11891 Dan Williams     2022-05-22  273  	cxld->interleave_granularity = ig;
48667f676189ec Dan Williams     2021-09-21  274  
f9db85bfec0dcc Alison Schofield 2022-11-30  275  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
f9db85bfec0dcc Alison Schofield 2022-11-30  276  		if (ways != 1 && ways != 3) {
f9db85bfec0dcc Alison Schofield 2022-11-30  277  			cxims_ctx = (struct cxl_cxims_context) {
f9db85bfec0dcc Alison Schofield 2022-11-30  278  				.dev = dev,
f9db85bfec0dcc Alison Schofield 2022-11-30  279  				.cxlrd = cxlrd,
f9db85bfec0dcc Alison Schofield 2022-11-30  280  			};
f9db85bfec0dcc Alison Schofield 2022-11-30  281  			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
f9db85bfec0dcc Alison Schofield 2022-11-30  282  						   cxl_parse_cxims, &cxims_ctx);
f9db85bfec0dcc Alison Schofield 2022-11-30  283  			if (rc < 0)
f9db85bfec0dcc Alison Schofield 2022-11-30  284  				goto err_xormap;
14628aec8415e4 Alison Schofield 2022-12-04  285  			if (!cxlrd->platform_data) {
14628aec8415e4 Alison Schofield 2022-12-04  286  				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
14628aec8415e4 Alison Schofield 2022-12-04  287  				rc = -EINVAL;
14628aec8415e4 Alison Schofield 2022-12-04  288  				goto err_xormap;
14628aec8415e4 Alison Schofield 2022-12-04  289  			}
f9db85bfec0dcc Alison Schofield 2022-11-30  290  		}
f9db85bfec0dcc Alison Schofield 2022-11-30  291  	}
48667f676189ec Dan Williams     2021-09-21  292  	rc = cxl_decoder_add(cxld, target_map);
f9db85bfec0dcc Alison Schofield 2022-11-30  293  err_xormap:
48667f676189ec Dan Williams     2021-09-21  294  	if (rc)
48667f676189ec Dan Williams     2021-09-21  295  		put_device(&cxld->dev);
48667f676189ec Dan Williams     2021-09-21  296  	else
48667f676189ec Dan Williams     2021-09-21  297  		rc = cxl_decoder_autoremove(dev, cxld);
48667f676189ec Dan Williams     2021-09-21  298  	if (rc) {
e50fe01e1f2a4a Dan Williams     2022-05-18 @299  		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
3840e10e8dcafc Breno Leitao     2023-07-14  300  			res->start, res->end);
f4ce1f766f1ebf Dan Williams     2021-10-29  301  		return 0;
da6aafec3dca61 Alison Schofield 2021-06-17  302  	}
e50fe01e1f2a4a Dan Williams     2022-05-18  303  	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
e50fe01e1f2a4a Dan Williams     2022-05-18  304  		dev_name(&cxld->dev),
e50fe01e1f2a4a Dan Williams     2022-05-18  305  		phys_to_target_node(cxld->hpa_range.start),
e50fe01e1f2a4a Dan Williams     2022-05-18  306  		cxld->hpa_range.start, cxld->hpa_range.end);
da6aafec3dca61 Alison Schofield 2021-06-17  307  
f4ce1f766f1ebf Dan Williams     2021-10-29  308  	return 0;
974854ab072853 Dan Williams     2022-07-12  309  
974854ab072853 Dan Williams     2022-07-12  310  err_insert:
974854ab072853 Dan Williams     2022-07-12  311  	kfree(res->name);
974854ab072853 Dan Williams     2022-07-12  312  err_name:
974854ab072853 Dan Williams     2022-07-12  313  	kfree(res);
974854ab072853 Dan Williams     2022-07-12  314  	return -ENOMEM;
da6aafec3dca61 Alison Schofield 2021-06-17  315  }
da6aafec3dca61 Alison Schofield 2021-06-17  316  

:::::: The code at line 299 was first introduced by commit
:::::: e50fe01e1f2a4aba2275edee7d5c77ac87674ddb cxl/core: Drop ->platform_res attribute for root decoders

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
