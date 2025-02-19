Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11081FECAE
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987983; cv=none; b=uE9v08Dvfs2DYyjpr8nM8TPQEFwGJd9Tnnpe8Q51BoIaw6yPzNsgm58HN13zWTGESMbhzPlplQpNTy1LAPk7RRKxZ0Fw4S5JJ7MsoBfW3hV0n+qVifHY8BokriMrCNJjTzo4hGmPp9kNd94SB9MpNwrPxLgAp4zD+5+5QLBBsDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987983; c=relaxed/simple;
	bh=y+HXUQl3d9wX6q1mnhzed4a5lEaqV4h7BJ9bnzPpzLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpG0oGGifWKgH4SVt0BoCTp5xdF58x8nPVbVl6gykULURCO2JlKh1PSUl6xmOi7l5fAygDioG1SiOVd/0IcmJEnazz9bjWo6VV58ypOLpxOrO9yJB8U+YKSom1fXRDA9OoRlGq1QaOFxojvcD3A9RavSaylp7iy8z2xDwvaTVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNjrsumM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNjrsumM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739987982; x=1771523982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y+HXUQl3d9wX6q1mnhzed4a5lEaqV4h7BJ9bnzPpzLs=;
  b=iNjrsumMApKoLmXinTzXZuUvCGTD7IkNEi2pj6P9pmD1Z+waqZF8NYCI
   nbUowHP0VVZlX6jhgIovgEzhwmmLmx0BT0McqztLcJNSSyMG7/2C0nQ7v
   aBFELaQhOq0Qdo1RguQt3UcvXUsxFqsrEIc3XqCNvu2X265IhX3TPeLOX
   zspU7fi2DJkDSiYBhsqBgaqT21F5B1+mFFKqLg/spgv7icqd7RsdjjDed
   HHkrsaYzQQRjZoC1H/qZ+auuaTjHVuw7UaL/0CJf89BemFjP2g/MUUV10
   IwIgb37qu3SI5y6wUlYIFGWXht49Ld1/GhNIdV45MTzOpjdDN3zsxxd1y
   A==;
X-CSE-ConnectionGUID: 57BfQdXwQSa69s3KxDT9XA==
X-CSE-MsgGUID: +rqNIuoTSAq59duGUmJEQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44508175"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44508175"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:59:42 -0800
X-CSE-ConnectionGUID: cffawLiJTK6wMTM19Smwsg==
X-CSE-MsgGUID: urv4IFNVQbaSsXnFWrqArA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114641666"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 08:44:09 -0800
Message-ID: <6afeaba7-3fbb-45af-b5e6-8d69396c8e54@intel.com>
Date: Wed, 19 Feb 2025 09:44:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cxl/pmem: Export dirty shutdown count via sysfs
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org
References: <20250219062832.237881-1-dave@stgolabs.net>
 <20250219062832.237881-4-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250219062832.237881-4-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 11:28 PM, Davidlohr Bueso wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

just a couple nits below

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl       | 12 +++
>  Documentation/driver-api/cxl/maturity-map.rst |  2 +-
>  drivers/cxl/core/mbox.c                       | 21 +++++
>  drivers/cxl/cxl.h                             |  1 +
>  drivers/cxl/cxlmem.h                          | 13 ++++
>  drivers/cxl/pmem.c                            | 77 +++++++++++++++++--
>  6 files changed, 117 insertions(+), 9 deletions(-)
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
> index 86d13f4a1c18..f1009a265f9d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1281,6 +1281,27 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
> +int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
> +{
> +	int rc;
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mbox_get_health_info_out hi;

reverse xmas tree pls

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
>  int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index acbbba41356d..4dbf1cc60047 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -542,6 +542,7 @@ struct cxl_nvdimm {
>  	struct device dev;
>  	struct cxl_memdev *cxlmd;
>  	u8 dev_id[CXL_DEV_ID_LEN]; /* for nvdimm, string of 'serial' */
> +	u64 dirty_shutdowns;
>  };
>  
>  struct cxl_pmem_region_mapping {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 6d60030139df..3b6ef9e936c3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -681,6 +681,18 @@ struct cxl_mbox_set_partition_info {
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
> @@ -822,6 +834,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
> +int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
>  int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 6b284962592f..aee1afe9d287 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -42,15 +42,44 @@ static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *
>  }
>  static DEVICE_ATTR_RO(id);
>  
> +static ssize_t dirty_shutdown_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> +
> +	return sysfs_emit(buf, "%lld\n", cxl_nvd->dirty_shutdowns);
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
> +#define CXL_INVALID_DIRTY_SHUTDOWN_COUNT -1
> +static umode_t cxl_dimm_visible(struct kobject *kobj,
> +				struct attribute *a, int n)
> +{
> +	if (a == &dev_attr_dirty_shutdown.attr) {
> +		struct device *dev = kobj_to_dev(kobj);
> +		struct nvdimm *nvdimm = to_nvdimm(dev);
> +		struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> +
> +		if (cxl_nvd->dirty_shutdowns ==
> +		    CXL_INVALID_DIRTY_SHUTDOWN_COUNT)
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
> @@ -58,6 +87,38 @@ static const struct attribute_group *cxl_dimm_attribute_groups[] = {
>  	NULL
>  };
>  
> +static void cxl_nvdimm_setup_dirty_tracking(struct cxl_nvdimm *cxl_nvd)
> +{
> +	u32 count;
> +	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct device *dev = &cxl_nvd->dev;

reverse xmas tree pls

> +
> +	/*
> +	 * Dirty tracking is enabled and exposed to the user, only when:
> +	 *   - dirty shutdown on the device can be set, and,
> +	 *   - the device has a Device GPF DVSEC (albeit unused), and,
> +	 *   - the Get Health Info cmd can retrieve the device's dirty count.
> +	 */
> +	cxl_nvd->dirty_shutdowns = CXL_INVALID_DIRTY_SHUTDOWN_COUNT;
> +
> +	if (cxl_arm_dirty_shutdown(mds)) {
> +		dev_warn(dev, "GPF: could not set dirty shutdown state\n");
> +		return;
> +	}
> +
> +	if (cxl_gpf_get_dvsec(cxlds->dev, false) <= 0)
> +		return;
> +
> +	if (cxl_get_dirty_count(mds, &count)) {
> +		dev_warn(dev, "GPF: could not retrieve dirty count\n");
> +		return;
> +	}
> +
> +	cxl_nvd->dirty_shutdowns = count;
> +}
> +
>  static int cxl_nvdimm_probe(struct device *dev)
>  {
>  	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
> @@ -78,20 +139,20 @@ static int cxl_nvdimm_probe(struct device *dev)
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
> -	if (cxl_arm_dirty_shutdown(mds))
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

