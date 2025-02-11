Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1346926BD80
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739239802; cv=none; b=KD+oqiN0PFNncU+1kkal+uFqs90rOTgl7kqw4nlBZmvmcWIv8rDkdsgx8c31RZ9ZxCDhcAjvbM4EyWGyBYyhp2euDDCstC/zbg96Wa87yGKpe0AAQ4L5zC+8oxRTEWuaxDItOnDYdRSCaukke/Y+4TxhWfZcWGwAt2IFqYnMctE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739239802; c=relaxed/simple;
	bh=EGuWftvGb3MJbzF0qMMJ9K/tqFQgle48oD6kIWQyiT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnjmCdn8EN1cxh2EXJT2cbD9YFeM40CYdmc1xiqS1XP8owHl2ZSo+OPeppjEGnqiLY5z9oBReGNpI145sUGlu91myzp+TuVMgL+nf9otJCb1DX03UIH/H1pQykxVM3GBEYwAMksDuyNMIPEkjvoOFafD+nITPXXprw+my62XiKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJVy94s8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJVy94s8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739239801; x=1770775801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EGuWftvGb3MJbzF0qMMJ9K/tqFQgle48oD6kIWQyiT0=;
  b=FJVy94s8EmO8vlbzpw2Q6vpDr1PSoXIs0LYfJJexBjzpVn6mxVKRygFk
   gN6JchAIdfMcj6TyI9gESqqWgdlpO/mDtrNod1SuSmnJPr3AB7PLneLDL
   fiL1HyDyQkRXt+Nupz4F6j4tIx511yk7Ca8dWA+dbL0Q6hZC2KmqR8UbU
   s0ryWhAusdq9/jHfraF+dDI60VOjgSGgTR8ya09RthwVYACOxsOccNUAx
   BViWgZ5J7Dj0hE2Snwr8zYnqJQca0pfZfZQBo87Jh7OwIl1levrh2p2LP
   Vx9BBa92R+sLmu1d1yb7pSsBqbGkKZ7AnkGa6zU9h/iw0lE3OloOLVf30
   g==;
X-CSE-ConnectionGUID: kgHSLGFNSkmCIG5CT0ZnWw==
X-CSE-MsgGUID: FACFR2q5TOKPKm57ar9fvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39866179"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="39866179"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:10:00 -0800
X-CSE-ConnectionGUID: ES4I3gheSm2hM1bqlB98QQ==
X-CSE-MsgGUID: vYd2TFZhRleczqR2K7Yb0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149547004"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.192]) ([10.125.111.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:09:58 -0800
Message-ID: <49bf1136-c4b5-4c25-8b3f-2b9f68e23983@intel.com>
Date: Mon, 10 Feb 2025 19:09:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl/pmem: Export dirty shutdown count via sysfs
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org
References: <20250205040842.1253616-1-dave@stgolabs.net>
 <20250205040842.1253616-2-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250205040842.1253616-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/4/25 9:08 PM, Davidlohr Bueso wrote:
> Similar to how the acpi_nfit driver exports Optane dirty shutdown count,
> introduce:
> 
>   /sys/bus/cxl/devices/nvdimm-bridge0/ndbusX/nmemY/cxl/dirty_shutdown
> 
> Under the conditions that 1) dirty shutdown can be set, 2) Device GPF
> DVSEC exists, and 3) the count itself can be retrieved.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl       | 12 ++++
>  Documentation/driver-api/cxl/maturity-map.rst |  2 +-
>  drivers/cxl/core/mbox.c                       | 21 ++++++
>  drivers/cxl/core/pci.c                        | 23 +++++++
>  drivers/cxl/cxl.h                             |  1 +
>  drivers/cxl/cxlmem.h                          | 15 ++++
>  drivers/cxl/pmem.c                            | 69 ++++++++++++++++---
>  7 files changed, 134 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3f5627a1210a..a7491d214098 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -586,3 +586,15 @@ Description:
>  		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
>  		the number to the closest initiator and access1 provides the
>  		number to the closest CPU.
> +
> +
> +What:		/sys/bus/cxl/devices/nvdimm-bridge0/ndbusX/nmemY/cxl/dirty_shutdown
> +Date:		Feb, 2025
> +KernelVersion:	v6.15
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The device dirty shutdown count value, which is the number
> +		of times the device could have incurred in potential data loss.
> +		The count is persistent across power loss and wraps back to 0
> +		upon overflow. If this file is not present, the device does not
> +		have the necessary support for dirty tracking.
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index 99dd2c841e69..a2288f9df658 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -130,7 +130,7 @@ Mailbox commands
>  * [0] Switch CCI
>  * [3] Timestamp
>  * [1] PMEM labels
> -* [1] PMEM GPF / Dirty Shutdown
> +* [3] PMEM GPF / Dirty Shutdown
>  * [0] Scan Media
>  
>  PMU
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4d22bb731177..d03fc7ed76a8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1290,6 +1290,27 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
> +int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
> +{
> +	int rc;
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mbox_get_health_info_out hi;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_HEALTH_INFO,
> +		.size_out = sizeof(hi),
> +		.payload_out = &hi,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +	if (!rc)
> +		*count = le32_to_cpu(hi.dirty_shutdown_cnt);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_dirty_count, "CXL");
> +
>  int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a5c65f79db18..bcf05d010a77 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1141,3 +1141,26 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
>  
>  	return 0;
>  }
> +
> +int cxl_gpf_device(struct cxl_dev_state *cxlds)

Maybe turn this into a helper for retrieving the dvsec and use it in cxl_gpf_port_setup() as well?

> +{
> +	int dvsec;
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
> +	pdev = to_pci_dev(dev);
> +	if (!pdev)
> +		return -EINVAL;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_DEVICE_GPF);
> +	if (!dvsec) {
> +		pci_warn(pdev, "Device GPF DVSEC not present\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

I think it needs to export the symbol to use outside of cxl core.

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6baec4ba9141..40cc44a18df8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -542,6 +542,7 @@ struct cxl_nvdimm {
>  	struct device dev;
>  	struct cxl_memdev *cxlmd;
>  	u8 dev_id[CXL_DEV_ID_LEN]; /* for nvdimm, string of 'serial' */
> +	long dirty_shutdown;

Maybe consider using u64 and call it 'dirty_shutdowns'?

>  };
>  
>  struct cxl_pmem_region_mapping {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 536cbe521d16..ee0c93fde50c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -725,6 +725,18 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +/* Get Health Info Output Payload CXL 3.2 Spec 8.2.10.9.3.1 Table 8-148 */
> +struct cxl_mbox_get_health_info_out {
> +	u8 health_status;
> +	u8 media_status;
> +	u8 additional_status;
> +	u8 life_used;
> +	__le16 device_temperature;
> +	__le32 dirty_shutdown_cnt;
> +	__le32 corrected_volatile_error_cnt;
> +	__le32 corrected_persistent_error_cnt;
> +} __packed;
> +
>  /* Set Shutdown State Input Payload CXL 3.2 Spec 8.2.10.9.3.5 Table 8-152 */
>  struct cxl_mbox_set_shutdown_state_in {
>  	u8 state;
> @@ -866,6 +878,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
> +int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
>  int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
> @@ -910,4 +923,6 @@ struct cxl_hdm {
>  struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
> +
> +int cxl_gpf_device(struct cxl_dev_state *cxlds);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index a39e2c52d7ab..d83ecd568a9c 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -42,15 +42,41 @@ static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *
>  }
>  static DEVICE_ATTR_RO(id);
>  
> +static ssize_t dirty_shutdown_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> +
> +	return sysfs_emit(buf, "%ld\n", cxl_nvd->dirty_shutdown);
> +}
> +static DEVICE_ATTR_RO(dirty_shutdown);
> +
>  static struct attribute *cxl_dimm_attributes[] = {
>  	&dev_attr_id.attr,
>  	&dev_attr_provider.attr,
> +	&dev_attr_dirty_shutdown.attr,
>  	NULL
>  };
>  
> +static umode_t cxl_dimm_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	if (a == &dev_attr_dirty_shutdown.attr) {
> +		struct device *dev = kobj_to_dev(kobj);
> +		struct nvdimm *nvdimm = to_nvdimm(dev);
> +		struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> +
> +		if (cxl_nvd->dirty_shutdown == -1)
> +			return 0;
> +	}
> +
> +	return a->mode;
> +}
> +
>  static const struct attribute_group cxl_dimm_attribute_group = {
>  	.name = "cxl",
>  	.attrs = cxl_dimm_attributes,
> +	.is_visible = cxl_dimm_visible
>  };
>  
>  static const struct attribute_group *cxl_dimm_attribute_groups[] = {
> @@ -58,6 +84,33 @@ static const struct attribute_group *cxl_dimm_attribute_groups[] = {
>  	NULL
>  };
>  
> +static void cxl_nvdimm_setup_dirty_tracking(struct cxl_nvdimm *cxl_nvd)

Please consider cxl_nvdimm_arm_dirty_shutdown_tracking()

> +{
> +	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct device *dev = &cxl_nvd->dev;
> +
> +	/*
> +	 * Dirty tracking is enabled and exposed to the user, only when:
> +	 *   - dirty shutdown on the device can be set, and,
> +	 *   - the device has a Device GPF DVSEC (albeit unused), and,
> +	 *   - the Get Health Info cmd can retrieve the device's dirty count.
> +	 */
> +	cxl_nvd->dirty_shutdown = -1;

#define CXL_INVALID_DIRTY_SHUTDOWN_COUNT -1
perhaps?

> +
> +	if (cxl_dirty_shutdown_state(mds)) {
> +		dev_warn(dev, "GPF: could not dirty shutdown state\n");

"could not set dirty shutdown state"

Speaking of which, should we rename cxl_dirty_shutdown_state() to cxl_arm_dirty_shutdown()?

Also, maybe just return here instead of falling through

> +	} else if (!cxl_gpf_device(cxlds)) {

Just return the fail case here

> +		u32 count;
> +
> +		if (!cxl_get_dirty_count(mds, &count))
> +			cxl_nvd->dirty_shutdown = count;
> +		else
> +			dev_warn(dev, "GPF: could not retrieve dirty count\n");

Warn and call return directly here for the failed case first

DJ

> +	}
> +}
> +
>  static int cxl_nvdimm_probe(struct device *dev)
>  {
>  	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
> @@ -78,20 +131,20 @@ static int cxl_nvdimm_probe(struct device *dev)
>  	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
>  	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
>  	set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
> -	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
> -				 cxl_dimm_attribute_groups, flags,
> -				 cmd_mask, 0, NULL, cxl_nvd->dev_id,
> -				 cxl_security_ops, NULL);
> -	if (!nvdimm)
> -		return -ENOMEM;
>  
>  	/*
>  	 * Set dirty shutdown now, with the expectation that the device
>  	 * clear it upon a successful GPF flow. The exception to this
>  	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
>  	 */
> -	if (cxl_dirty_shutdown_state(mds))
> -		dev_warn(dev, "GPF: could not dirty shutdown state\n");
> +	cxl_nvdimm_setup_dirty_tracking(cxl_nvd);
> +
> +	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
> +				 cxl_dimm_attribute_groups, flags,
> +				 cmd_mask, 0, NULL, cxl_nvd->dev_id,
> +				 cxl_security_ops, NULL);
> +	if (!nvdimm)
> +		return -ENOMEM;
>  
>  	dev_set_drvdata(dev, nvdimm);
>  	return devm_add_action_or_reset(dev, unregister_nvdimm, nvdimm);

