Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5211586CB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239996; cv=none; b=asu69X48NNRdarnEZ71mRZmYierRdr4M7uPU3c1DPcEgYCUSBMe7xMv4fUB1rexOKYpyU0iCkbNCLP7wa76kSuMqeApD3XNUqO13IbTjcylXXIcPupmB5IKQeCh/4egl6KkjiG9X2bn9TSxJ3WZLeQGn8Blg+pPub2YS2qrcJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239996; c=relaxed/simple;
	bh=jDlXG1BdKr8C7n733ocAnV/tBd1AO77HAwFvqtg/Wcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6NB/QTJpsTDaV/J7VZmF48Z0DfzB2Yd1CiAJnXx+p+GEZMJW5M8NkcXl5XyE9HOwRPS7cyAsAZzOLNs2jvR0rY2qaGaysBFrL6OOIXPrbKP0Um/yVlPYKyS/WKMK7vlJp4YxBpbPpJXCJ9Puw4R1b1Lo7MGGT5JlN+VLGIOqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kg0PK0O8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kg0PK0O8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732239994; x=1763775994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jDlXG1BdKr8C7n733ocAnV/tBd1AO77HAwFvqtg/Wcg=;
  b=Kg0PK0O81vJ+qXjL3edvdNpCRnQsmGLuV6NOn6hv++iMy22pI7SK57jX
   AS3Y02VHY3nB9fRgZ+jwoDQbBTUz5hV8JMjzGnwJd1lMK2erH0opsdiEE
   PZOMHy2+Ufgv1zSL0rkauUuNfeXHQBuYJpWWkhnO7Rxkam4y/IqHl3kIn
   /R7kW3cs9ymkWQA5RfwdDgAC6ZMIvTJc6DhzO+PTnX6AgKD2Z29ZZSSl7
   NZC7a4NATeklxPaGqV7p22srAI2lwlUFv2wW7NEyPOKWGpAndU0DPwXCv
   /BzhOREo7wYqdThk9Cy7SWQ1OLVUEDNYztdH8Vk0mjznKwVE8t8ZJI7O6
   g==;
X-CSE-ConnectionGUID: Drz8hWE/R/GQDcwoAdu14w==
X-CSE-MsgGUID: vX5gBVDrQ5WG1KR+SzIz4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43447923"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="43447923"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 17:46:29 -0800
X-CSE-ConnectionGUID: hFl4TVR6SkKxQtlKOwLjIA==
X-CSE-MsgGUID: RaOb8TLFQXuS8aworknPHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="113716357"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Nov 2024 17:46:27 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEIka-0003Yv-1h;
	Fri, 22 Nov 2024 01:46:24 +0000
Date: Fri, 22 Nov 2024 09:46:14 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v2] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Message-ID: <202411220917.CiqYJijn-lkp@intel.com>
References: <20241118163238.6723-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118163238.6723-1-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master v6.12 next-20241121]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-avoid-driver-data-for-obtaining-cxl_dev_state-reference/20241121-141608
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20241118163238.6723-1-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v2] cxl: avoid driver data for obtaining cxl_dev_state reference
config: mips-randconfig-r061-20241122 (https://download.01.org/0day-ci/archive/20241122/202411220917.CiqYJijn-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220917.CiqYJijn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220917.CiqYJijn-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/cxl/cxlmem.h:12,
                    from drivers/cxl/pci.c:15:
   drivers/cxl/cxl.h:830:24: error: storage class specified for parameter 'cxl_bus_type'
     830 | extern struct bus_type cxl_bus_type;
         |                        ^~~~~~~~~~~~
>> drivers/cxl/cxl.h:879:20: error: storage class specified for parameter 'is_cxl_pmem_region'
     879 | static inline bool is_cxl_pmem_region(struct device *dev)
         |                    ^~~~~~~~~~~~~~~~~~
>> drivers/cxl/cxl.h:879:20: warning: parameter 'is_cxl_pmem_region' declared 'inline'
>> drivers/cxl/cxl.h:880:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
     880 | {
         | ^
>> drivers/cxl/cxl.h:879:20: error: 'no_instrument_function' attribute applies only to functions
     879 | static inline bool is_cxl_pmem_region(struct device *dev)
         | ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cxl/cxl.h:880:1: error: expected ';', ',' or ')' before '{' token
     880 | {
         | ^
--
   In file included from drivers/perf/../cxl/cxlpci.h:6,
                    from drivers/perf/cxl_pmu.c:23:
   drivers/perf/../cxl/cxl.h:830:24: error: storage class specified for parameter 'cxl_bus_type'
     830 | extern struct bus_type cxl_bus_type;
         |                        ^~~~~~~~~~~~
>> drivers/perf/../cxl/cxl.h:879:20: error: storage class specified for parameter 'is_cxl_pmem_region'
     879 | static inline bool is_cxl_pmem_region(struct device *dev)
         |                    ^~~~~~~~~~~~~~~~~~
>> drivers/perf/../cxl/cxl.h:879:20: warning: parameter 'is_cxl_pmem_region' declared 'inline'
>> drivers/perf/../cxl/cxl.h:880:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
     880 | {
         | ^
>> drivers/perf/../cxl/cxl.h:879:20: error: 'no_instrument_function' attribute applies only to functions
     879 | static inline bool is_cxl_pmem_region(struct device *dev)
         | ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/../cxl/cxl.h:880:1: error: expected ';', ',' or ')' before '{' token
     880 | {
         | ^


vim +/is_cxl_pmem_region +879 drivers/cxl/cxl.h

779dd20cfb56c5 Ben Widawsky       2021-06-08  829  
b39cb1052a5cf4 Dan Williams       2021-02-16 @830  extern struct bus_type cxl_bus_type;
6af7139c979474 Dan Williams       2021-06-15  831  
6af7139c979474 Dan Williams       2021-06-15  832  struct cxl_driver {
6af7139c979474 Dan Williams       2021-06-15  833  	const char *name;
6af7139c979474 Dan Williams       2021-06-15  834  	int (*probe)(struct device *dev);
6af7139c979474 Dan Williams       2021-06-15  835  	void (*remove)(struct device *dev);
6af7139c979474 Dan Williams       2021-06-15  836  	struct device_driver drv;
6af7139c979474 Dan Williams       2021-06-15  837  	int id;
6af7139c979474 Dan Williams       2021-06-15  838  };
6af7139c979474 Dan Williams       2021-06-15  839  
d69d804845985c Greg Kroah-Hartman 2024-07-01  840  #define to_cxl_drv(__drv)	container_of_const(__drv, struct cxl_driver, drv)
6af7139c979474 Dan Williams       2021-06-15  841  
6af7139c979474 Dan Williams       2021-06-15  842  int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
6af7139c979474 Dan Williams       2021-06-15  843  			  const char *modname);
6af7139c979474 Dan Williams       2021-06-15  844  #define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
6af7139c979474 Dan Williams       2021-06-15  845  void cxl_driver_unregister(struct cxl_driver *cxl_drv);
6af7139c979474 Dan Williams       2021-06-15  846  
c57cae78bfa6a8 Ben Widawsky       2022-01-23  847  #define module_cxl_driver(__cxl_driver) \
c57cae78bfa6a8 Ben Widawsky       2022-01-23  848  	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
c57cae78bfa6a8 Ben Widawsky       2022-01-23  849  
8fdcb1704f61a8 Dan Williams       2021-06-15  850  #define CXL_DEVICE_NVDIMM_BRIDGE	1
21083f51521fb0 Dan Williams       2021-06-15  851  #define CXL_DEVICE_NVDIMM		2
54cdbf845cf719 Ben Widawsky       2022-02-01  852  #define CXL_DEVICE_PORT			3
54cdbf845cf719 Ben Widawsky       2022-02-01  853  #define CXL_DEVICE_ROOT			4
8dd2bc0f8e02d3 Ben Widawsky       2022-02-04  854  #define CXL_DEVICE_MEMORY_EXPANDER	5
8d48817df6ac20 Dan Williams       2021-06-15  855  #define CXL_DEVICE_REGION		6
04ad63f086d1a9 Dan Williams       2022-01-11  856  #define CXL_DEVICE_PMEM_REGION		7
09d09e04d2fcf8 Dan Williams       2023-02-10  857  #define CXL_DEVICE_DAX_REGION		8
1ad3f701c39999 Jonathan Cameron   2023-05-26  858  #define CXL_DEVICE_PMU			9
8fdcb1704f61a8 Dan Williams       2021-06-15  859  
6af7139c979474 Dan Williams       2021-06-15  860  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
6af7139c979474 Dan Williams       2021-06-15  861  #define CXL_MODALIAS_FMT "cxl:t%d"
6af7139c979474 Dan Williams       2021-06-15  862  
8fdcb1704f61a8 Dan Williams       2021-06-15  863  struct cxl_nvdimm_bridge *to_cxl_nvdimm_bridge(struct device *dev);
8fdcb1704f61a8 Dan Williams       2021-06-15  864  struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
8fdcb1704f61a8 Dan Williams       2021-06-15  865  						     struct cxl_port *port);
21083f51521fb0 Dan Williams       2021-06-15  866  struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
21083f51521fb0 Dan Williams       2021-06-15  867  bool is_cxl_nvdimm(struct device *dev);
53989fad1286e6 Dan Williams       2021-11-11  868  bool is_cxl_nvdimm_bridge(struct device *dev);
84ec985944ef34 Li Ming            2024-06-12  869  int devm_cxl_add_nvdimm(struct cxl_port *parent_port, struct cxl_memdev *cxlmd);
84ec985944ef34 Li Ming            2024-06-12  870  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
04ad63f086d1a9 Dan Williams       2022-01-11  871  
04ad63f086d1a9 Dan Williams       2022-01-11  872  #ifdef CONFIG_CXL_REGION
04ad63f086d1a9 Dan Williams       2022-01-11  873  bool is_cxl_pmem_region(struct device *dev);
04ad63f086d1a9 Dan Williams       2022-01-11  874  struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
a32320b71f085f Dan Williams       2023-02-10  875  int cxl_add_to_region(struct cxl_port *root,
a32320b71f085f Dan Williams       2023-02-10  876  		      struct cxl_endpoint_decoder *cxled);
09d09e04d2fcf8 Dan Williams       2023-02-10  877  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
04ad63f086d1a9 Dan Williams       2022-01-11  878  #else
04ad63f086d1a9 Dan Williams       2022-01-11 @879  static inline bool is_cxl_pmem_region(struct device *dev)
04ad63f086d1a9 Dan Williams       2022-01-11 @880  {
04ad63f086d1a9 Dan Williams       2022-01-11  881  	return false;
04ad63f086d1a9 Dan Williams       2022-01-11  882  }
04ad63f086d1a9 Dan Williams       2022-01-11  883  static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
04ad63f086d1a9 Dan Williams       2022-01-11  884  {
04ad63f086d1a9 Dan Williams       2022-01-11  885  	return NULL;
04ad63f086d1a9 Dan Williams       2022-01-11  886  }
a32320b71f085f Dan Williams       2023-02-10  887  static inline int cxl_add_to_region(struct cxl_port *root,
a32320b71f085f Dan Williams       2023-02-10  888  				    struct cxl_endpoint_decoder *cxled)
a32320b71f085f Dan Williams       2023-02-10  889  {
a32320b71f085f Dan Williams       2023-02-10  890  	return 0;
a32320b71f085f Dan Williams       2023-02-10  891  }
09d09e04d2fcf8 Dan Williams       2023-02-10  892  static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
09d09e04d2fcf8 Dan Williams       2023-02-10  893  {
09d09e04d2fcf8 Dan Williams       2023-02-10  894  	return NULL;
09d09e04d2fcf8 Dan Williams       2023-02-10  895  }
04ad63f086d1a9 Dan Williams       2022-01-11  896  #endif
67dcdd4d3b832a Dan Williams       2021-09-14  897  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
