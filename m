Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC214D267
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710392424; cv=none; b=GK2E3WPFASPSYsc96JeRTgocReYrd+4nwNqVwYlh9KsEYlc2BVVcs0VGTs43Plylkf2ZzhC0fdmnRHve3OZdCqHU4JMmoVG1hrOK9TDUg6UtAazcKEuKF7iMK7Et8u5lVkZ9AzklFc4oxg4lJJixPtBcjq+IV/uCsUu/+RKja5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710392424; c=relaxed/simple;
	bh=mqkM5/wu5VA3SYAqpusCC2mmXXDSkmQTflAZsfnJ+Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GY0wX4l/JbfChJLS9toJW0y5WAnDTIZHH6KI/i+CRwMDV+JUVPIIWkm904hiwRQl/5bqHHvb/GntaPsm88sVc3lPa7PEMpGvygDyuJdf0dfrX8JT530cABVy9UYxlPvelL+NVLGNY+JEDB5mpqIjHfaGcmiX8ojO2LTGbpUxbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqcIbb0w; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqcIbb0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710392421; x=1741928421;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mqkM5/wu5VA3SYAqpusCC2mmXXDSkmQTflAZsfnJ+Yk=;
  b=bqcIbb0w719XKeJOGdIzOEW8woQHX7vWrskePmxLP3WL8kVyDCqNYDqe
   j4c3eULUVjFNrERPIdMn35yiPZVeSzZRv6Kj85Vvqdgj5vAeMpqY92E+Y
   W/6RtEHsQjNBIwXeKWOMGEeXore3YCzxpSR9agBdYX0ytH55PSa0EK3xV
   dOBSNM+Ej9267N7Zk3geNgL/Srwi9OCsFEjtLY91kpR8Fr3pTki8XGDwz
   4HXx8aolXmuwFzEFTgv5Iyagf+MeTgFgr+XUM5CpIIECeND045SA9H7nk
   /0/2zhHnunogkA/rIaXHmIIIIMCGLUhTeK9HDoU7AVw83siqoujGLEGWB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5320234"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="5320234"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 22:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="35295404"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Mar 2024 22:00:17 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkdCR-000D7B-18;
	Thu, 14 Mar 2024 05:00:15 +0000
Date: Thu, 14 Mar 2024 12:59:49 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [cxl:next 14/23] drivers/acpi/apei/einj-core.c:222:11: sparse:
 sparse: incorrect type in assignment (different address spaces)
Message-ID: <202403141236.g8QtgI6t-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
head:   88482878c3b4abc2a6e66e016cc01eacbdc5b0ed
commit: 12fb28ea6b1cf24bde27c406eb38ee3c108d73f9 [14/23] EINJ: Add CXL error type support
config: i386-randconfig-063-20240314 (https://download.01.org/0day-ci/archive/20240314/202403141236.g8QtgI6t-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240314/202403141236.g8QtgI6t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403141236.g8QtgI6t-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/apei/einj-core.c:222:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vendor_error_type_extension *v @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:222:11: sparse:     expected struct vendor_error_type_extension *v
   drivers/acpi/apei/einj-core.c:222:11: sparse:     got void [noderef] __iomem *
>> drivers/acpi/apei/einj-core.c:231:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct vendor_error_type_extension *v @@
   drivers/acpi/apei/einj-core.c:231:29: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/apei/einj-core.c:231:29: sparse:     got struct vendor_error_type_extension *v
>> drivers/acpi/apei/einj-core.c:257:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct set_error_type_with_address *v5param @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:257:25: sparse:     expected struct set_error_type_with_address *v5param
   drivers/acpi/apei/einj-core.c:257:25: sparse:     got void [noderef] __iomem *
>> drivers/acpi/apei/einj-core.c:267:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct einj_parameter *v4param @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:267:25: sparse:     expected struct einj_parameter *v4param
   drivers/acpi/apei/einj-core.c:267:25: sparse:     got void [noderef] __iomem *
>> drivers/acpi/apei/einj-core.c:271:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got struct einj_parameter *v4param @@
   drivers/acpi/apei/einj-core.c:271:45: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/apei/einj-core.c:271:45: sparse:     got struct einj_parameter *v4param
>> drivers/acpi/apei/einj-core.c:338:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct acpi_einj_trigger *trigger_tab @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:338:21: sparse:     expected struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj-core.c:338:21: sparse:     got void [noderef] __iomem *
>> drivers/acpi/apei/einj-core.c:364:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct acpi_einj_trigger *trigger_tab @@
   drivers/acpi/apei/einj-core.c:364:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/einj-core.c:364:17: sparse:     got struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj-core.c:365:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct acpi_einj_trigger *trigger_tab @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/einj-core.c:365:21: sparse:     expected struct acpi_einj_trigger *trigger_tab
   drivers/acpi/apei/einj-core.c:365:21: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/einj-core.c:428:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct acpi_einj_trigger *trigger_tab @@
   drivers/acpi/apei/einj-core.c:428:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/einj-core.c:428:25: sparse:     got struct acpi_einj_trigger *trigger_tab
>> drivers/acpi/apei/einj-core.c:863:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *virt @@     got void *static [assigned] [toplevel] einj_param @@
   drivers/acpi/apei/einj-core.c:863:37: sparse:     expected void [noderef] __iomem *virt
   drivers/acpi/apei/einj-core.c:863:37: sparse:     got void *static [assigned] [toplevel] einj_param
   drivers/acpi/apei/einj-core.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +222 drivers/acpi/apei/einj-core.c

22fca621bd1bbc drivers/acpi/apei/einj.c Avadhut Naik     2023-11-16  212  
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  213  static void check_vendor_extension(u64 paddr,
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  214  				   struct set_error_type_with_address *v5param)
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  215  {
459413db33d6c9 drivers/acpi/apei/einj.c Tony Luck        2012-01-23  216  	int	offset = v5param->vendor_extension;
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  217  	struct	vendor_error_type_extension *v;
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  218  	u32	sbdf;
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  219  
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  220  	if (!offset)
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  221  		return;
a238317ce81855 drivers/acpi/apei/einj.c Lv Zheng         2014-05-20 @222  	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  223  	if (!v)
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  224  		return;
22fca621bd1bbc drivers/acpi/apei/einj.c Avadhut Naik     2023-11-16  225  	get_oem_vendor_struct(paddr, offset, v);
459413db33d6c9 drivers/acpi/apei/einj.c Tony Luck        2012-01-23  226  	sbdf = v->pcie_sbdf;
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  227  	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  228  		sbdf >> 24, (sbdf >> 16) & 0xff,
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  229  		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
459413db33d6c9 drivers/acpi/apei/einj.c Tony Luck        2012-01-23  230  		 v->vendor_id, v->device_id, v->rev_id);
a238317ce81855 drivers/acpi/apei/einj.c Lv Zheng         2014-05-20 @231  	acpi_os_unmap_iomem(v, sizeof(*v));
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  232  }
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  233  
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  234  static void *einj_get_parameter_address(void)
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  235  {
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  236  	int i;
d3ab3edc029bf7 drivers/acpi/apei/einj.c Chen, Gong       2013-12-18  237  	u64 pa_v4 = 0, pa_v5 = 0;
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  238  	struct acpi_whea_header *entry;
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  239  
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  240  	entry = EINJ_TAB_ENTRY(einj_tab);
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  241  	for (i = 0; i < einj_tab->entries; i++) {
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  242  		if (entry->action == ACPI_EINJ_SET_ERROR_TYPE &&
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  243  		    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  244  		    entry->register_region.space_id ==
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  245  		    ACPI_ADR_SPACE_SYSTEM_MEMORY)
d3ab3edc029bf7 drivers/acpi/apei/einj.c Chen, Gong       2013-12-18  246  			pa_v4 = get_unaligned(&entry->register_region.address);
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  247  		if (entry->action == ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS &&
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  248  		    entry->instruction == ACPI_EINJ_WRITE_REGISTER &&
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  249  		    entry->register_region.space_id ==
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  250  		    ACPI_ADR_SPACE_SYSTEM_MEMORY)
d3ab3edc029bf7 drivers/acpi/apei/einj.c Chen, Gong       2013-12-18  251  			pa_v5 = get_unaligned(&entry->register_region.address);
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  252  		entry++;
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  253  	}
d3ab3edc029bf7 drivers/acpi/apei/einj.c Chen, Gong       2013-12-18  254  	if (pa_v5) {
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  255  		struct set_error_type_with_address *v5param;
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  256  
a238317ce81855 drivers/acpi/apei/einj.c Lv Zheng         2014-05-20 @257  		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  258  		if (v5param) {
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  259  			acpi5 = 1;
d3ab3edc029bf7 drivers/acpi/apei/einj.c Chen, Gong       2013-12-18  260  			check_vendor_extension(pa_v5, v5param);
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  261  			return v5param;
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  262  		}
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  263  	}
d3ab3edc029bf7 drivers/acpi/apei/einj.c Chen, Gong       2013-12-18  264  	if (param_extension && pa_v4) {
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  265  		struct einj_parameter *v4param;
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  266  
a238317ce81855 drivers/acpi/apei/einj.c Lv Zheng         2014-05-20 @267  		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  268  		if (!v4param)
29924b9f8f39e3 drivers/acpi/apei/einj.c Dan Carpenter    2012-01-20  269  			return NULL;
459413db33d6c9 drivers/acpi/apei/einj.c Tony Luck        2012-01-23  270  		if (v4param->reserved1 || v4param->reserved2) {
a238317ce81855 drivers/acpi/apei/einj.c Lv Zheng         2014-05-20 @271  			acpi_os_unmap_iomem(v4param, sizeof(*v4param));
29924b9f8f39e3 drivers/acpi/apei/einj.c Dan Carpenter    2012-01-20  272  			return NULL;
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  273  		}
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  274  		return v4param;
c130bd6f82e5dd drivers/acpi/apei/einj.c Tony Luck        2012-01-17  275  	}
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  276  
29924b9f8f39e3 drivers/acpi/apei/einj.c Dan Carpenter    2012-01-20  277  	return NULL;
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  278  }
6e320ec1d98f9e drivers/acpi/apei/einj.c Huang Ying       2010-05-18  279  
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  280  /* do sanity check to trigger table */
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  281  static int einj_check_trigger_header(struct acpi_einj_trigger *trigger_tab)
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  282  {
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  283  	if (trigger_tab->header_size != sizeof(struct acpi_einj_trigger))
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  284  		return -EINVAL;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  285  	if (trigger_tab->table_size > PAGE_SIZE ||
4c40aed869a200 drivers/acpi/apei/einj.c Niklas Söderlund 2012-01-09  286  	    trigger_tab->table_size < trigger_tab->header_size)
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  287  		return -EINVAL;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  288  	if (trigger_tab->entry_count !=
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  289  	    (trigger_tab->table_size - trigger_tab->header_size) /
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  290  	    sizeof(struct acpi_einj_entry))
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  291  		return -EINVAL;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  292  
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  293  	return 0;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  294  }
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  295  
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  296  static struct acpi_generic_address *einj_get_trigger_parameter_region(
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  297  	struct acpi_einj_trigger *trigger_tab, u64 param1, u64 param2)
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  298  {
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  299  	int i;
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  300  	struct acpi_whea_header *entry;
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  301  
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  302  	entry = (struct acpi_whea_header *)
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  303  		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  304  	for (i = 0; i < trigger_tab->entry_count; i++) {
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  305  		if (entry->action == ACPI_EINJ_TRIGGER_ERROR &&
1d5d820b8fe83b drivers/acpi/apei/einj.c Yazen Ghannam    2017-08-28  306  		entry->instruction <= ACPI_EINJ_WRITE_REGISTER_VALUE &&
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  307  		entry->register_region.space_id ==
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  308  			ACPI_ADR_SPACE_SYSTEM_MEMORY &&
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  309  		(entry->register_region.address & param2) == (param1 & param2))
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  310  			return &entry->register_region;
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  311  		entry++;
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  312  	}
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  313  
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  314  	return NULL;
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  315  }
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  316  /* Execute instructions in trigger error action table */
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  317  static int __einj_error_trigger(u64 trigger_paddr, u32 type,
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  318  				u64 param1, u64 param2)
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  319  {
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  320  	struct acpi_einj_trigger *trigger_tab = NULL;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  321  	struct apei_exec_context trigger_ctx;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  322  	struct apei_resources trigger_resources;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  323  	struct acpi_whea_header *trigger_entry;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  324  	struct resource *r;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  325  	u32 table_size;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  326  	int rc = -EIO;
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  327  	struct acpi_generic_address *trigger_param_region = NULL;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  328  
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  329  	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  330  			       "APEI EINJ Trigger Table");
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  331  	if (!r) {
b2f740baa42152 drivers/acpi/apei/einj.c Borislav Petkov  2016-05-23  332  		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  333  		       (unsigned long long)trigger_paddr,
46b91e379f7180 drivers/acpi/apei/einj.c Bjorn Helgaas    2011-12-08  334  		       (unsigned long long)trigger_paddr +
46b91e379f7180 drivers/acpi/apei/einj.c Bjorn Helgaas    2011-12-08  335  			    sizeof(*trigger_tab) - 1);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  336  		goto out;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  337  	}
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18 @338  	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  339  	if (!trigger_tab) {
b2f740baa42152 drivers/acpi/apei/einj.c Borislav Petkov  2016-05-23  340  		pr_err("Failed to map trigger table!\n");
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  341  		goto out_rel_header;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  342  	}
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  343  	rc = einj_check_trigger_header(trigger_tab);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  344  	if (rc) {
933ca4e323de77 drivers/acpi/apei/einj.c Kefeng Wang      2019-10-18  345  		pr_warn(FW_BUG "Invalid trigger error action table.\n");
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  346  		goto out_rel_header;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  347  	}
4c40aed869a200 drivers/acpi/apei/einj.c Niklas Söderlund 2012-01-09  348  
4c40aed869a200 drivers/acpi/apei/einj.c Niklas Söderlund 2012-01-09  349  	/* No action structures in the TRIGGER_ERROR table, nothing to do */
4c40aed869a200 drivers/acpi/apei/einj.c Niklas Söderlund 2012-01-09  350  	if (!trigger_tab->entry_count)
4c40aed869a200 drivers/acpi/apei/einj.c Niklas Söderlund 2012-01-09  351  		goto out_rel_header;
4c40aed869a200 drivers/acpi/apei/einj.c Niklas Söderlund 2012-01-09  352  
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  353  	rc = -EIO;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  354  	table_size = trigger_tab->table_size;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  355  	r = request_mem_region(trigger_paddr + sizeof(*trigger_tab),
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  356  			       table_size - sizeof(*trigger_tab),
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  357  			       "APEI EINJ Trigger Table");
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  358  	if (!r) {
b2f740baa42152 drivers/acpi/apei/einj.c Borislav Petkov  2016-05-23  359  		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  360  		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
46b91e379f7180 drivers/acpi/apei/einj.c Bjorn Helgaas    2011-12-08  361  		       (unsigned long long)trigger_paddr + table_size - 1);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  362  		goto out_rel_header;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  363  	}
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18 @364  	iounmap(trigger_tab);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  365  	trigger_tab = ioremap_cache(trigger_paddr, table_size);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  366  	if (!trigger_tab) {
b2f740baa42152 drivers/acpi/apei/einj.c Borislav Petkov  2016-05-23  367  		pr_err("Failed to map trigger table!\n");
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  368  		goto out_rel_entry;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  369  	}
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  370  	trigger_entry = (struct acpi_whea_header *)
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  371  		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  372  	apei_resources_init(&trigger_resources);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  373  	apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  374  			   ARRAY_SIZE(einj_ins_type),
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  375  			   trigger_entry, trigger_tab->entry_count);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  376  	rc = apei_exec_collect_resources(&trigger_ctx, &trigger_resources);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  377  	if (rc)
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  378  		goto out_fini;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  379  	rc = apei_resources_sub(&trigger_resources, &einj_resources);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  380  	if (rc)
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  381  		goto out_fini;
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  382  	/*
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  383  	 * Some firmware will access target address specified in
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  384  	 * param1 to trigger the error when injecting memory error.
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  385  	 * This will cause resource conflict with regular memory.  So
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  386  	 * remove it from trigger table resources.
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  387  	 */
c5a130325f13b2 drivers/acpi/apei/einj.c Chen Gong        2013-06-06  388  	if ((param_extension || acpi5) && (type & MEM_ERROR_MASK) && param2) {
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  389  		struct apei_resources addr_resources;
37ea9693869627 drivers/acpi/apei/einj.c Jay Lu           2022-12-06  390  
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  391  		apei_resources_init(&addr_resources);
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  392  		trigger_param_region = einj_get_trigger_parameter_region(
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  393  			trigger_tab, param1, param2);
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  394  		if (trigger_param_region) {
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  395  			rc = apei_resources_add(&addr_resources,
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  396  				trigger_param_region->address,
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  397  				trigger_param_region->bit_width/8, true);
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  398  			if (rc)
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  399  				goto out_fini;
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  400  			rc = apei_resources_sub(&trigger_resources,
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  401  					&addr_resources);
b4e008dc53a31c drivers/acpi/apei/einj.c Xiao, Hui        2011-12-08  402  		}
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  403  		apei_resources_fini(&addr_resources);
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  404  		if (rc)
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  405  			goto out_fini;
fdea163d8c17ba drivers/acpi/apei/einj.c Huang Ying       2011-12-08  406  	}
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  407  	rc = apei_resources_request(&trigger_resources, "APEI EINJ Trigger");
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  408  	if (rc)
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  409  		goto out_fini;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  410  	rc = apei_exec_pre_map_gars(&trigger_ctx);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  411  	if (rc)
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  412  		goto out_release;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  413  
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  414  	rc = apei_exec_run(&trigger_ctx, ACPI_EINJ_TRIGGER_ERROR);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  415  
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  416  	apei_exec_post_unmap_gars(&trigger_ctx);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  417  out_release:
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  418  	apei_resources_release(&trigger_resources);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  419  out_fini:
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  420  	apei_resources_fini(&trigger_resources);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  421  out_rel_entry:
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  422  	release_mem_region(trigger_paddr + sizeof(*trigger_tab),
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  423  			   table_size - sizeof(*trigger_tab));
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  424  out_rel_header:
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  425  	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  426  out:
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  427  	if (trigger_tab)
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  428  		iounmap(trigger_tab);
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  429  
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  430  	return rc;
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  431  }
e40213450b5315 drivers/acpi/apei/einj.c Huang Ying       2010-05-18  432  

:::::: The code at line 222 was first introduced by commit
:::::: a238317ce8185519ed083e81e84260907fbbcf7f ACPI: Clean up acpi_os_map/unmap_memory() to eliminate __iomem.

:::::: TO: Lv Zheng <lv.zheng@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
