Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2011DA0E1
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892497; cv=none; b=kKHtMbS2q7C/V0bhhyHECBID0fAh3PiWdR5lcmWk9+f0CaZ+MWlomyZ8Ol729QsABXaSbPVfOUTglwVdhIrhCU1W+9a5S0BccSD5TXAvNcc4OOP9fO+Iw60Yt54Jtgkdtq1Y4NIgsHgI6VIZG+aMm2rr8WGLtI5lWhUmrSQgc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892497; c=relaxed/simple;
	bh=lC7zXgAvunxszqRMbTrJIYu2uTwgEVHgzPOKafE22NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KO/LahF0EFpxSwIUsfVxhs0020/RZ/ts23ecnjkS55yHxmXTmdgvE7vBpOvMYZ7iDgmeRWlWBJhSuE2ph/GnbyhmMh6t+DpZWZDNi7gSy2yFELCw9cQR1babxuVsnnfGxDmhCQ2ahlVw9UIT5zTnihlC5Cm7ZZRXiAgaReoM9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYF2E18G; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYF2E18G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771892495; x=1803428495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lC7zXgAvunxszqRMbTrJIYu2uTwgEVHgzPOKafE22NA=;
  b=jYF2E18Guq3B+cIkBhrYiHuITA3AwVeQrkE49AwDPqQb7Q73cAee+GAM
   3N/EXbHA7G84avGBg5xC13kAHleHuJgSbjqLfkCQlAp6Y9eSe0AQsOvNS
   MxG4bnQorCu12SVloX94ZEMHNoqjHppH5EXP/iwkPsI/WMbzjXh/ow6bY
   c3Lw6Zm8MHq78w0H3BrJwYqJNKMWfwn2UAVdIM/5aU1iH04zJGewOJSiT
   pTNDtPsFT8lOFvJZpDsW+Y2s3YuUUQXByjlO18y4DSH7jgJOmglNx/l3G
   j6CimBZm5MIuQO0tZBCjzK/4Fn4nItqdHUI9f1NzYNo6ZAY8GGZ5f61NJ
   w==;
X-CSE-ConnectionGUID: R8JD2OduSU+F3Whp+JWoWA==
X-CSE-MsgGUID: H+wrAvrfQqq+9yg9k75Xaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84355839"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="84355839"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 16:21:35 -0800
X-CSE-ConnectionGUID: /C3c7emxReSSuS5ejJ+bLA==
X-CSE-MsgGUID: lmUOR8KaSLOGclk0gxweuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="219831520"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 16:21:35 -0800
Message-ID: <f32c1df3-80b4-4951-90da-fcca1e6a6339@intel.com>
Date: Mon, 23 Feb 2026 17:21:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cxl: export internal structs for external Type2
 drivers
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
 <20260223142633.2994082-3-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260223142633.2994082-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/26 7:26 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for type2 support, move structs and functions needed by
> external type2 drivers. Differentiate between public and private data to
> be preserved by type2 drivers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/cxl.h    |  97 +------------------
>  drivers/cxl/cxlmem.h | 114 ----------------------
>  include/cxl/cxl.h    | 226 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 227 insertions(+), 210 deletions(-)
>  create mode 100644 include/cxl/cxl.h
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 04c673e7cdb0..0d350b69f1c8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -12,6 +12,7 @@
>  #include <linux/node.h>
>  #include <linux/io.h>
>  #include <linux/range.h>
> +#include <cxl/cxl.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> @@ -201,97 +202,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> -/*
> - * Using struct_group() allows for per register-block-type helper routines,
> - * without requiring block-type agnostic code to include the prefix.
> - */
> -struct cxl_regs {
> -	/*
> -	 * Common set of CXL Component register block base pointers
> -	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
> -	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> -	 */
> -	struct_group_tagged(cxl_component_regs, component,
> -		void __iomem *hdm_decoder;
> -		void __iomem *ras;
> -	);
> -	/*
> -	 * Common set of CXL Device register block base pointers
> -	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
> -	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> -	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
> -	 */
> -	struct_group_tagged(cxl_device_regs, device_regs,
> -		void __iomem *status, *mbox, *memdev;
> -	);
> -
> -	struct_group_tagged(cxl_pmu_regs, pmu_regs,
> -		void __iomem *pmu;
> -	);
> -
> -	/*
> -	 * RCH downstream port specific RAS register
> -	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> -	 */
> -	struct_group_tagged(cxl_rch_regs, rch_regs,
> -		void __iomem *dport_aer;
> -	);
> -
> -	/*
> -	 * RCD upstream port specific PCIe cap register
> -	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> -	 */
> -	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> -		void __iomem *rcd_pcie_cap;
> -	);
> -};
> -
> -struct cxl_reg_map {
> -	bool valid;
> -	int id;
> -	unsigned long offset;
> -	unsigned long size;
> -};
> -
> -struct cxl_component_reg_map {
> -	struct cxl_reg_map hdm_decoder;
> -	struct cxl_reg_map ras;
> -};
> -
> -struct cxl_device_reg_map {
> -	struct cxl_reg_map status;
> -	struct cxl_reg_map mbox;
> -	struct cxl_reg_map memdev;
> -};
> -
> -struct cxl_pmu_reg_map {
> -	struct cxl_reg_map pmu;
> -};
> -
> -/**
> - * struct cxl_register_map - DVSEC harvested register block mapping parameters
> - * @host: device for devm operations and logging
> - * @base: virtual base of the register-block-BAR + @block_offset
> - * @resource: physical resource base of the register block
> - * @max_size: maximum mapping size to perform register search
> - * @reg_type: see enum cxl_regloc_type
> - * @component_map: cxl_reg_map for component registers
> - * @device_map: cxl_reg_maps for device registers
> - * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> - */
> -struct cxl_register_map {
> -	struct device *host;
> -	void __iomem *base;
> -	resource_size_t resource;
> -	resource_size_t max_size;
> -	u8 reg_type;
> -	union {
> -		struct cxl_component_reg_map component_map;
> -		struct cxl_device_reg_map device_map;
> -		struct cxl_pmu_reg_map pmu_map;
> -	};
> -};
> -
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> @@ -497,11 +407,6 @@ struct cxl_region_params {
>  	resource_size_t cache_size;
>  };
>  
> -enum cxl_partition_mode {
> -	CXL_PARTMODE_RAM,
> -	CXL_PARTMODE_PMEM,
> -};
> -
>  /*
>   * Indicate whether this region has been assembled by autodetection or
>   * userspace assembly. Prevent endpoint decoders outside of automatic
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9daf4bc42692..281546de426e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -113,8 +113,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
>  
> -#define CXL_NR_PARTITIONS_MAX 2
> -
>  struct cxl_dpa_info {
>  	u64 size;
>  	struct cxl_dpa_part_info {
> @@ -373,87 +371,6 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };
>  
> -/*
> - * enum cxl_devtype - delineate type-2 from a generic type-3 device
> - * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> - *			 HDM-DB, no requirement that this device implements a
> - *			 mailbox, or other memory-device-standard manageability
> - *			 flows.
> - * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> - *			   HDM-H and class-mandatory memory device registers
> - */
> -enum cxl_devtype {
> -	CXL_DEVTYPE_DEVMEM,
> -	CXL_DEVTYPE_CLASSMEM,
> -};
> -
> -/**
> - * struct cxl_dpa_perf - DPA performance property entry
> - * @dpa_range: range for DPA address
> - * @coord: QoS performance data (i.e. latency, bandwidth)
> - * @cdat_coord: raw QoS performance data from CDAT
> - * @qos_class: QoS Class cookies
> - */
> -struct cxl_dpa_perf {
> -	struct range dpa_range;
> -	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> -	int qos_class;
> -};
> -
> -/**
> - * struct cxl_dpa_partition - DPA partition descriptor
> - * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> - * @perf: performance attributes of the partition from CDAT
> - * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> - */
> -struct cxl_dpa_partition {
> -	struct resource res;
> -	struct cxl_dpa_perf perf;
> -	enum cxl_partition_mode mode;
> -};
> -
> -/**
> - * struct cxl_dev_state - The driver device state
> - *
> - * cxl_dev_state represents the CXL driver/device state.  It provides an
> - * interface to mailbox commands as well as some cached data about the device.
> - * Currently only memory devices are represented.
> - *
> - * @dev: The device associated with this CXL state
> - * @cxlmd: The device representing the CXL.mem capabilities of @dev
> - * @reg_map: component and ras register mapping parameters
> - * @regs: Class device "Device" registers
> - * @cxl_dvsec: Offset to the PCIe device DVSEC
> - * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> - * @media_ready: Indicate whether the device media is usable
> - * @dpa_res: Overall DPA resource tree for the device
> - * @part: DPA partition array
> - * @nr_partitions: Number of DPA partitions
> - * @serial: PCIe Device Serial Number
> - * @type: Generic Memory Class device or Vendor Specific Memory device
> - * @cxl_mbox: CXL mailbox context
> - * @cxlfs: CXL features context
> - */
> -struct cxl_dev_state {
> -	struct device *dev;
> -	struct cxl_memdev *cxlmd;
> -	struct cxl_register_map reg_map;
> -	struct cxl_device_regs regs;
> -	int cxl_dvsec;
> -	bool rcd;
> -	bool media_ready;
> -	struct resource dpa_res;
> -	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> -	unsigned int nr_partitions;
> -	u64 serial;
> -	enum cxl_devtype type;
> -	struct cxl_mailbox cxl_mbox;
> -#ifdef CONFIG_CXL_FEATURES
> -	struct cxl_features_state *cxlfs;
> -#endif
> -};
> -
>  static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  {
>  	/*
> @@ -523,37 +440,6 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>  }
>  
> -struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
> -						 enum cxl_devtype type,
> -						 u64 serial, u16 dvsec,
> -						 size_t size, bool has_mbox);
> -
> -/**
> - * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
> - * driver specific struct.
> - *
> - * @parent: device behind the request
> - * @type: CXL device type
> - * @serial: device identification
> - * @dvsec: dvsec capability offset
> - * @drv_struct: driver struct embedding a cxl_dev_state struct
> - * @member: drv_struct member as cxl_dev_state
> - * @mbox: true if mailbox supported
> - *
> - * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
> - * struct initialized.
> - *
> - * Introduced for Type2 driver support.
> - */
> -#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
> -	({										\
> -		static_assert(__same_type(struct cxl_dev_state,				\
> -			      ((drv_struct *)NULL)->member));				\
> -		static_assert(offsetof(drv_struct, member) == 0);			\
> -		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
> -						      sizeof(drv_struct), mbox);	\
> -	})
> -
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> new file mode 100644
> index 000000000000..11f76d61c9f1
> --- /dev/null
> +++ b/include/cxl/cxl.h
> @@ -0,0 +1,226 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2020 Intel Corporation. */
> +/* Copyright(c) 2026 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_CXL_H__
> +#define __CXL_CXL_H__
> +
> +#include <linux/node.h>
> +#include <linux/ioport.h>
> +#include <cxl/mailbox.h>
> +
> +/**
> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
> + * @CXL_DEVTYPE_DEVMEM: Vendor specific CXL Type-2 device implementing HDM-D or
> + *			 HDM-DB, no requirement that this device implements a
> + *			 mailbox, or other memory-device-standard manageability
> + *			 flows.
> + * @CXL_DEVTYPE_CLASSMEM: Common class definition of a CXL Type-3 device with
> + *			   HDM-H and class-mandatory memory device registers
> + */
> +enum cxl_devtype {
> +	CXL_DEVTYPE_DEVMEM,
> +	CXL_DEVTYPE_CLASSMEM,
> +};
> +
> +struct device;
> +
> +/*
> + * Using struct_group() allows for per register-block-type helper routines,
> + * without requiring block-type agnostic code to include the prefix.
> + */
> +struct cxl_regs {
> +	/*
> +	 * Common set of CXL Component register block base pointers
> +	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
> +	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> +	 */
> +	struct_group_tagged(cxl_component_regs, component,
> +		void __iomem *hdm_decoder;
> +		void __iomem *ras;
> +	);
> +	/*
> +	 * Common set of CXL Device register block base pointers
> +	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
> +	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> +	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
> +	 */
> +	struct_group_tagged(cxl_device_regs, device_regs,
> +		void __iomem *status, *mbox, *memdev;
> +	);
> +
> +	struct_group_tagged(cxl_pmu_regs, pmu_regs,
> +		void __iomem *pmu;
> +	);
> +
> +	/*
> +	 * RCH downstream port specific RAS register
> +	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rch_regs, rch_regs,
> +		void __iomem *dport_aer;
> +	);
> +
> +	/*
> +	 * RCD upstream port specific PCIe cap register
> +	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> +		void __iomem *rcd_pcie_cap;
> +	);
> +};
> +
> +struct cxl_reg_map {
> +	bool valid;
> +	int id;
> +	unsigned long offset;
> +	unsigned long size;
> +};
> +
> +struct cxl_component_reg_map {
> +	struct cxl_reg_map hdm_decoder;
> +	struct cxl_reg_map ras;
> +};
> +
> +struct cxl_device_reg_map {
> +	struct cxl_reg_map status;
> +	struct cxl_reg_map mbox;
> +	struct cxl_reg_map memdev;
> +};
> +
> +struct cxl_pmu_reg_map {
> +	struct cxl_reg_map pmu;
> +};
> +
> +/**
> + * struct cxl_register_map - DVSEC harvested register block mapping parameters
> + * @host: device for devm operations and logging
> + * @base: virtual base of the register-block-BAR + @block_offset
> + * @resource: physical resource base of the register block
> + * @max_size: maximum mapping size to perform register search
> + * @reg_type: see enum cxl_regloc_type
> + * @component_map: cxl_reg_map for component registers
> + * @device_map: cxl_reg_maps for device registers
> + * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> + */
> +struct cxl_register_map {
> +	struct device *host;
> +	void __iomem *base;
> +	resource_size_t resource;
> +	resource_size_t max_size;
> +	u8 reg_type;
> +	union {
> +		struct cxl_component_reg_map component_map;
> +		struct cxl_device_reg_map device_map;
> +		struct cxl_pmu_reg_map pmu_map;
> +	};
> +};
> +
> +/**
> + * struct cxl_dpa_perf - DPA performance property entry
> + * @dpa_range: range for DPA address
> + * @coord: QoS performance data (i.e. latency, bandwidth)
> + * @cdat_coord: raw QoS performance data from CDAT
> + * @qos_class: QoS Class cookies
> + */
> +struct cxl_dpa_perf {
> +	struct range dpa_range;
> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> +	int qos_class;
> +};
> +
> +enum cxl_partition_mode {
> +	CXL_PARTMODE_RAM,
> +	CXL_PARTMODE_PMEM,
> +};
> +
> +/**
> + * struct cxl_dpa_partition - DPA partition descriptor
> + * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> + * @perf: performance attributes of the partition from CDAT
> + * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> + */
> +struct cxl_dpa_partition {
> +	struct resource res;
> +	struct cxl_dpa_perf perf;
> +	enum cxl_partition_mode mode;
> +};
> +
> +#define CXL_NR_PARTITIONS_MAX 2
> +
> +/**
> + * struct cxl_dev_state - The driver device state
> + *
> + * cxl_dev_state represents the CXL driver/device state.  It provides an
> + * interface to mailbox commands as well as some cached data about the device.
> + * Currently only memory devices are represented.
> + *
> + * @dev: The device associated with this CXL state
> + * @cxlmd: The device representing the CXL.mem capabilities of @dev
> + * @reg_map: component and ras register mapping parameters
> + * @regs: Parsed register blocks
> + * @cxl_dvsec: Offset to the PCIe device DVSEC
> + * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @media_ready: Indicate whether the device media is usable
> + * @dpa_res: Overall DPA resource tree for the device
> + * @part: DPA partition array
> + * @nr_partitions: Number of DPA partitions
> + * @serial: PCIe Device Serial Number
> + * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @cxl_mbox: CXL mailbox context
> + * @cxlfs: CXL features context
> + */
> +struct cxl_dev_state {
> +	/* public for Type2 drivers */
> +	struct device *dev;
> +	struct cxl_memdev *cxlmd;
> +
> +	/* private for Type2 drivers */
> +	struct cxl_register_map reg_map;
> +	struct cxl_device_regs regs;
> +	int cxl_dvsec;
> +	bool rcd;
> +	bool media_ready;
> +	struct resource dpa_res;
> +	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> +	unsigned int nr_partitions;
> +	u64 serial;
> +	enum cxl_devtype type;
> +	struct cxl_mailbox cxl_mbox;
> +#ifdef CONFIG_CXL_FEATURES
> +	struct cxl_features_state *cxlfs;
> +#endif
> +};
> +
> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
> +						 enum cxl_devtype type,
> +						 u64 serial, u16 dvsec,
> +						 size_t size, bool has_mbox);
> +
> +/**
> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
> + * driver specific struct.
> + *
> + * @parent: device behind the request
> + * @type: CXL device type
> + * @serial: device identification
> + * @dvsec: dvsec capability offset
> + * @drv_struct: driver struct embedding a cxl_dev_state struct
> + * @member: drv_struct member as cxl_dev_state
> + * @mbox: true if mailbox supported
> + *
> + * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
> + * struct initialized.
> + *
> + * Introduced for Type2 driver support.
> + */
> +#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
> +	({										\
> +		static_assert(__same_type(struct cxl_dev_state,				\
> +			      ((drv_struct *)NULL)->member));				\
> +		static_assert(offsetof(drv_struct, member) == 0);			\
> +		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
> +						      sizeof(drv_struct), mbox);	\
> +	})
> +#endif /* __CXL_CXL_H__ */

