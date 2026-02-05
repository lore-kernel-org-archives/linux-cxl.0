Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADDE35505C
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273897; cv=none; b=dgNZEZVvod1G9J5LIpXimOuvncI4UBqo1lEe3XS6x7hTcQJBqUM1mLXIuasN6DC7V3cDWvAc9R01nF7x1i6L2K5o+mtDzt3eJvVBfy62NpzGUJ/SgxlNlLhVmIDyew5vB2P2/zgOE0wPbqbmjqT22rWDvH7zQdIAl1Ktv7um4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273897; c=relaxed/simple;
	bh=D65u+dDBUQo9zPWF0ZHLSsn3W5lQXZ4WYi3bw5jc/WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4m6Uz597zW+BBV9jZ9tkDB4mYWcDU5YlnhH8DshewQ09YoNYRZtwzKAlp3VYiJyATOxmVo1BUgGyqF0h0tWSdbtyqT3Tcdgl13Gd0NfLdQNJFHTnWjGNzEBbOYoF1wqRyrKg9WolDa5df8WhpQLiQ/x92PFCT+8Eo52mJjdlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPGdbmrK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPGdbmrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770273896; x=1801809896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D65u+dDBUQo9zPWF0ZHLSsn3W5lQXZ4WYi3bw5jc/WA=;
  b=fPGdbmrKUq5HPX/8aXYarl8doDJrM+zCT4XbTO5l97UpyI6ks2kJcfwM
   DFZR7doJXlevi8+7ayVK8jCX4n4EYBhkaLrXoUf9y6mqFjgkcn5c6znHU
   YRjbmuKypYMlXXTEGTasXxpi9Xkb2pWoErqPPy3Oie9A7LDVFa9b7nAIf
   DZZjMIIN9VQ89fP8LmqFZMtScqlQr0w6Y3qxDR8AlEjUr7xQ9N9zWEqDg
   8APJRF/KQVEm8R6r1pYcoFts6sSGSerqf+PaVnZm9gyShNk8J5AaL/DJK
   F06fMmHZ8578kT+tqJ88/tAonyXgksYrhdCIMGL97ev/Y5f73rFlhkfiv
   A==;
X-CSE-ConnectionGUID: FbcuRYtITYan6O0eKUG1zw==
X-CSE-MsgGUID: 4pwh+g7GRGKQUeTKmbeJ5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71563017"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71563017"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 22:44:55 -0800
X-CSE-ConnectionGUID: y8CnTUG0ScueOIuH3iTOmg==
X-CSE-MsgGUID: 9yeApKwjQU6Ph2zB6O5DNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="215383911"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 Feb 2026 22:44:53 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnt6g-00000000jVs-1KJT;
	Thu, 05 Feb 2026 06:44:50 +0000
Date: Thu, 5 Feb 2026 14:44:33 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 2/2] cxl: Fix race of nvdimm_bus for the nvdimm_bridge
 object
Message-ID: <202602051405.Laq0NMV5-lkp@intel.com>
References: <20260205001633.1813643-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205001633.1813643-3-dave.jiang@intel.com>

Hi Dave,

kernel test robot noticed the following build errors:

[auto build test ERROR on 18f7fcd5e69a04df57b563360b88be72471d6b62]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Jiang/cxl-test-Removal-of-nvdimm_bus_register-wrapper-in-cxl_test/20260205-081838
base:   18f7fcd5e69a04df57b563360b88be72471d6b62
patch link:    https://lore.kernel.org/r/20260205001633.1813643-3-dave.jiang%40intel.com
patch subject: [PATCH 2/2] cxl: Fix race of nvdimm_bus for the nvdimm_bridge object
config: i386-randconfig-013-20260205 (https://download.01.org/0day-ci/archive/20260205/202602051405.Laq0NMV5-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602051405.Laq0NMV5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602051405.Laq0NMV5-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/cxl/core/pmem.o: in function `unregister_nvdimm_bus':
>> drivers/cxl/core/pmem.c:279:(.text+0x320): undefined reference to `nvdimm_bus_unregister'
   ld: drivers/cxl/core/pmem.o: in function `devm_cxl_add_nvdimm_bridge':
>> drivers/cxl/core/pmem.c:349:(.text+0x473): undefined reference to `nvdimm_bus_register'
   ld: drivers/cxl/core/pmem.o: in function `cxl_pmem_nvdimm_ctl':
>> drivers/cxl/core/pmem.c:236:(.text+0x91c): undefined reference to `nvdimm_provider_data'
>> ld: drivers/cxl/core/pmem.c:237:(.text+0x926): undefined reference to `nvdimm_cmd_mask'


vim +279 drivers/cxl/core/pmem.c

   232	
   233	static int cxl_pmem_nvdimm_ctl(struct nvdimm *nvdimm, unsigned int cmd,
   234				       void *buf, unsigned int buf_len)
   235	{
 > 236		struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 > 237		unsigned long cmd_mask = nvdimm_cmd_mask(nvdimm);
   238		struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
   239		struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
   240	
   241		if (!test_bit(cmd, &cmd_mask))
   242			return -ENOTTY;
   243	
   244		switch (cmd) {
   245		case ND_CMD_GET_CONFIG_SIZE:
   246			return cxl_pmem_get_config_size(mds, buf, buf_len);
   247		case ND_CMD_GET_CONFIG_DATA:
   248			return cxl_pmem_get_config_data(mds, buf, buf_len);
   249		case ND_CMD_SET_CONFIG_DATA:
   250			return cxl_pmem_set_config_data(mds, buf, buf_len);
   251		default:
   252			return -ENOTTY;
   253		}
   254	}
   255	
   256	static int cxl_pmem_ctl(struct nvdimm_bus_descriptor *nd_desc,
   257				struct nvdimm *nvdimm, unsigned int cmd, void *buf,
   258				unsigned int buf_len, int *cmd_rc)
   259	{
   260		/*
   261		 * No firmware response to translate, let the transport error
   262		 * code take precedence.
   263		 */
   264		*cmd_rc = 0;
   265	
   266		if (!nvdimm)
   267			return -ENOTTY;
   268		return cxl_pmem_nvdimm_ctl(nvdimm, cmd, buf, buf_len);
   269	}
   270	
   271	static void unregister_nvdimm_bus(void *_cxl_nvb)
   272	{
   273		struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
   274		struct nvdimm_bus *nvdimm_bus = cxl_nvb->nvdimm_bus;
   275	
   276		bus_for_each_dev(&cxl_bus_type, NULL, cxl_nvb, detach_nvdimm);
   277	
   278		cxl_nvb->nvdimm_bus = NULL;
 > 279		nvdimm_bus_unregister(nvdimm_bus);
   280	}
   281	
   282	DEFINE_FREE(put_cxl_nvb, struct cxl_nvdimm_bridge *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
   283	static struct cxl_nvdimm_bridge *
   284	__devm_cxl_add_nvdimm_bridge(struct device *host, struct cxl_port *port)
   285	{
   286		struct device *dev;
   287		int rc;
   288	
   289		if (!IS_ENABLED(CONFIG_CXL_PMEM))
   290			return ERR_PTR(-ENXIO);
   291	
   292		struct cxl_nvdimm_bridge *cxl_nvb __free(put_cxl_nvb) =
   293			cxl_nvdimm_bridge_alloc(port);
   294		if (IS_ERR(cxl_nvb))
   295			return cxl_nvb;
   296	
   297		dev = &cxl_nvb->dev;
   298		rc = dev_set_name(dev, "nvdimm-bridge%d", cxl_nvb->id);
   299		if (rc)
   300			return ERR_PTR(rc);
   301	
   302		rc = device_add(dev);
   303		if (rc)
   304			return ERR_PTR(rc);
   305	
   306		rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
   307		if (rc) {
   308			retain_and_null_ptr(cxl_nvb);
   309			return ERR_PTR(rc);
   310		}
   311	
   312		return no_free_ptr(cxl_nvb);
   313	}
   314	
   315	static void release_nvb(void *_cxl_nvb)
   316	{
   317		struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
   318	
   319		devm_release_action(&cxl_nvb->dev, unregister_nvb, cxl_nvb);
   320	}
   321	
   322	DEFINE_FREE(release_cxl_nvb, struct cxl_nvdimm_bridge *, if (!IS_ERR_OR_NULL(_T)) release_nvb(_T))
   323	/**
   324	 * devm_cxl_add_nvdimm_bridge() - add the root of a LIBNVDIMM topology
   325	 * @host: platform firmware root device
   326	 * @port: CXL port at the root of a CXL topology
   327	 *
   328	 * Return: bridge device that can host cxl_nvdimm objects
   329	 */
   330	struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
   331							     struct cxl_port *port)
   332	{
   333		struct device *dev;
   334		int rc;
   335	
   336		struct cxl_nvdimm_bridge *cxl_nvb __free(release_cxl_nvb) =
   337			__devm_cxl_add_nvdimm_bridge(host, port);
   338		if (IS_ERR(cxl_nvb))
   339			return cxl_nvb;
   340	
   341		dev = &cxl_nvb->dev;
   342		cxl_nvb->nd_desc = (struct nvdimm_bus_descriptor) {
   343			.provider_name = dev_name(dev->parent->parent),
   344			.module = THIS_MODULE,
   345			.ndctl = cxl_pmem_ctl,
   346		};
   347	
   348		cxl_nvb->nvdimm_bus =
 > 349			nvdimm_bus_register(&cxl_nvb->dev, &cxl_nvb->nd_desc);
   350		if (!cxl_nvb->nvdimm_bus)
   351			return ERR_PTR(-ENOMEM);
   352	
   353		rc = devm_add_action_or_reset(dev, unregister_nvdimm_bus, cxl_nvb);
   354		if (rc)
   355			return ERR_PTR(rc);
   356	
   357		return no_free_ptr(cxl_nvb);
   358	}
   359	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
