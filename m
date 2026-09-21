Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751332E4257
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027438; cv=none; b=R82LOzVIjOPCN+7aUpSjbqSAuOyyM8Pl+66MRwMMOJfnXmAybly32OAGfbzkFpYfRf52yc90vsMLITp8n0nmsnVDj3gvjU5uRcKWPTHCEGV6InQsDqWyYQNu+SFxRe56T795OfhXE54vDsfd8rBKXvz/GCvpGJfAeLVeQGsiV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027438; c=relaxed/simple;
	bh=6gU12y9lRb7jz7szPd4yHiRxFbVUXKlZYplP95D5Lck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFnytirn9BJzxsi5NV/qcVr24N+BI+5Y//0rlEUYOauofsOjxiqTodYUKgg8KY3oTQ1xJmxIgYSzxgzzBLCZKtJ+kvDPQZS7Sk7oPApOlbYlNKngq1fvjdK9TbKA5zJsOM86SEObgxPaOujBPQCofgYtow5nQIJAhbfTOlf4qtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oa9yN8aZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oa9yN8aZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790027435; x=1821563435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6gU12y9lRb7jz7szPd4yHiRxFbVUXKlZYplP95D5Lck=;
  b=Oa9yN8aZqUqMJfWOU0YS9DrMFfB4yN4Dh6qniOXfhZrLANDzkPBUVTu2
   +n02cVqCERxJ3KSJnILd5HcE+BvSg1HZtgWj/htTb9vK4aw/+P+nxN6g7
   wFUPTuNFU6pyucfetJ+6ndsYYFb12R0m/PGNuQhbJONtvENeaiTYHlF5x
   XB6Ah3HQDDMPd6j6IWr6vxuAA0ESjFBP8n2R6qj4fvlhjXuwusMoQMZKR
   bYQ7LWmC2SMCEdpUqW35JRPQX74IWGlm7e97cEPsbbScG/XqkkRGBy7om
   F2fmgjt/8+xjGlB4CdgTLxTonGhwzLM9pp3sxLpXm1io6vQNQszLM8aJ2
   w==;
X-CSE-ConnectionGUID: SV98D2BpTKW06V/6z6S1Lw==
X-CSE-MsgGUID: v4UKdfkpTZ+SYTmWlNVJDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101173120"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="101173120"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 14:50:34 -0700
X-CSE-ConnectionGUID: O5RV5sV5Qlii7UyeDesQdA==
X-CSE-MsgGUID: sygFfH2DSvGOY7mzutPFSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="280905887"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.234]) ([10.125.109.234])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 14:50:33 -0700
Message-ID: <cc15fecb-2847-4791-9fa3-53356b466473@intel.com>
Date: Mon, 21 Sep 2026 14:50:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/8] cxl/mem: Read dynamic capacity configuration from
 the device
To: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
 Gregory Price <gourry@gourry.net>, Richard Cheng <icheng@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>, Ira Weiny <iweiny@kernel.org>,
 Anisa Su <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>,
 Junhee Park <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-3-anisa.su@samsung.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260918203049.7273-3-anisa.su@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/26 1:30 PM, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Devices which support Dynamic Capacity (DC) are configured
> via mailbox commands. CXL r4.0 section 9.13.3 describes the use of
> the Get DC Configuration command in order to obtain DCD partition
> characteristics.
> 
> Implement the DC mailbox commands as specified in CXL 4.0 section
> 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> information. Disable DCD if an invalid configuration is found.
> 
> Initial enablement for Linux only supports one dynamic capacity
> partition. Read all the partitions the device reports but validate
> only the first, and configure it as 'dynamic ram 1'.
> 
> The specification requires that volatile capacity starts at DPA 0 and pmem
> starts at the DPA immediately following it, but DC partitions only need
> to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> So a device could leave a gap between ram/pmem (static) capacity and its first
> DC partition, or between one DC partition and the next.
> 
> However, Linux chooses not to support gaps between static and dynamic
> capacity, and requires the first DC partition to begin at the DPA
> immediately following static capacity.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Co-developed-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Changes:
> 1. mbox.c: do not refuse DCD when the device reports more than
>    CXL_MAX_DC_PARTITIONS. A future spec revision may allow more and
>    Linux only maps partition 0, so read only the first 8. A count of
>    zero is still refused.
>    Jonathan
> 2. mbox.c: reject a decode length that overflows when scaled by
>    CXL_CAPACITY_MULTIPLIER. A device reporting 2^36 or more wraps and
>    yields a plausible looking partition size rather than an error.
>    Richard
> 3. memdev.c: reject a DC partition size that overflows the DPA total.
>    The wrapped total reads as zero capacity, which cxl_dpa_setup()
>    accepts silently, so the device enumerates with no DPA and no error.
>    Richard
> 4. memdev.c: skip DC configuration when the media is not ready, as
>    cxl_mem_dpa_fetch() does for static capacity. The DC base was compared
>    against a static size forced to 0, disabling DCD with a misleading
>    gap message, or configuring dynamic capacity on a DCD-only device
>    whose static partitions were withheld.
> ---
>  drivers/cxl/core/hdm.c    |   2 +
>  drivers/cxl/core/mbox.c   | 237 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c |  48 ++++++++
>  drivers/cxl/cxlmem.h      |  55 +++++++++
>  drivers/cxl/pci.c         |   6 +
>  include/cxl/cxl.h         |   3 +-
>  6 files changed, 350 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..0ef076c08ed2 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -446,6 +446,8 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
>  		return "ram";
>  	case CXL_PARTMODE_PMEM:
>  		return "pmem";
> +	case CXL_PARTMODE_DYNAMIC_RAM_1:
> +		return "dynamic_ram_1";
>  	default:
>  		return "";
>  	};
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 199bb986d674..c96c16cc08e1 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1349,6 +1349,243 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return -EBUSY;
>  }
>  
> +/*
> + * A partition unavailable for Dynamic Capacity reports zeros for decode_length,
> + * length, and block_size.
> + */
> +static bool cxl_dc_partition_unavailable(struct cxl_dc_partition *dev_part)
> +{
> +	return !le64_to_cpu(dev_part->decode_length) &&
> +	       !le64_to_cpu(dev_part->length) &&
> +	       !le64_to_cpu(dev_part->block_size);
> +}
> +
> +static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> +			struct cxl_dc_partition *dev_part)
> +{
> +	u64 decode_len = le64_to_cpu(dev_part->decode_length);
> +	u64 blk_size = le64_to_cpu(dev_part->block_size);
> +	u64 len = le64_to_cpu(dev_part->length);
> +	u64 size;
> +
> +	/*
> +	 * Not an error; leave the entry empty. A partially zeroed partition
> +	 * is rejected by the checks below. CXL r4.0 Table 8-347.
> +	 */
> +	if (cxl_dc_partition_unavailable(dev_part)) {
> +		*part = (struct cxl_dc_partition_info) { };
> +		dev_dbg(dev, "Partition 0 unavailable for DC\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Decode length is a count of 256M units, so a device reporting 2^36
> +	 * or more wraps.
> +	 */
> +	if (check_mul_overflow(decode_len, (u64)CXL_CAPACITY_MULTIPLIER, &size)) {
> +		dev_err(dev, "DC partition 0 decode length %#llx overflows\n",
> +			decode_len);
> +		return -EINVAL;
> +	}
> +
> +	*part = (struct cxl_dc_partition_info) {
> +		.start = le64_to_cpu(dev_part->base),
> +		.size = size,
> +	};
> +
> +	/*
> +	 * Block size is a power of 2 and a multiple of 40h. is_power_of_2()
> +	 * takes an unsigned long, which truncates blk_size on 32 bit.
> +	 */
> +	if (blk_size == 0 || (blk_size & (blk_size - 1)) ||
> +	    blk_size % CXL_DCD_BLOCK_LINE_SIZE) {
> +		dev_err(dev, "DC partition 0 invalid block size %#llx\n", blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (part->size == 0) {
> +		dev_err(dev, "DC partition 0 zero decode length\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len == 0) {
> +		dev_err(dev, "DC partition 0 zero length\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len > part->size) {
> +		dev_err(dev, "DC partition 0 length %#llx exceeds decode length %#llx\n",
> +			len, part->size);
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(len, blk_size)) {
> +		dev_err(dev, "DC partition 0 length %#llx not a multiple of block size %#llx\n",
> +			len, blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(part->start, SZ_256M)) {
> +		dev_err(dev, "DC partition 0 base %#llx not aligned to 256M\n",
> +			part->start);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "DC partition 0 start %#llx size %#llx blk_size: %#llx\n",
> +		part->start, part->size, blk_size);
> +
> +	return 0;
> +}
> +
> +/* Returns the number of partitions in dc_resp or -ERRNO */
> +static int cxl_get_dc_config(struct cxl_mailbox *mbox, u8 start_partition,
> +			     u8 partition_count,
> +			     struct cxl_mbox_get_dc_config_out *dc_resp,
> +			     size_t dc_resp_size)
> +{
> +	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
> +		.partition_count = partition_count,
> +		.start_partition_index = start_partition,
> +	};
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in = &get_dc,
> +		.size_in = sizeof(get_dc),
> +		.size_out = dc_resp_size,
> +		.payload_out = dc_resp,
> +		/* The device must return at least the fixed header */
> +		.min_out = sizeof(*dc_resp),
> +	};
> +	size_t expected_sz;
> +	int rc;
> +
> +	rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (dc_resp->partitions_returned > partition_count) {
> +		dev_err(mbox->host, "Device returned %u partitions, requested %u\n",
> +			dc_resp->partitions_returned, partition_count);
> +		return -EIO;
> +	}
> +
> +	/* The trailing extent/tag counts (CXL r4.0 Table 8-346) are not read */
> +	expected_sz = struct_size(dc_resp, partition,
> +				  dc_resp->partitions_returned);
> +
> +	if (mbox_cmd.size_out < expected_sz) {
> +		dev_err(mbox->host,
> +			"Payload size %zu less than expected %zu for %u partitions\n",
> +			mbox_cmd.size_out,
> +			expected_sz,
> +			dc_resp->partitions_returned);
> +		return -EIO;
> +	}
> +
> +	dev_dbg(mbox->host, "Read %d/%d DC partitions\n",
> +		dc_resp->partitions_returned, dc_resp->avail_partition_count);
> +	return dc_resp->partitions_returned;
> +}
> +
> +/**
> + * cxl_dev_dc_identify() - Reads the dynamic capacity information from the
> + *                         device.
> + * @mbox: Mailbox to query
> + * @dc_info: The dynamic partition information to return
> + *
> + * Read every partition the device reports, but validate only the first:
> + * Linux maps partition 0 and nothing else, so a defect in capacity the
> + * driver never touches is not a reason to refuse the device dynamic
> + * capacity.  The remaining entries of @partitions are left unset.
> + *
> + * Return: 0 if identify was executed successfully, -ERRNO on error.
> + *         on error only dc_info is left unchanged.
> + */
> +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> +			struct cxl_dc_partition_info *dc_info)
> +{
> +	struct cxl_dc_partition_info partitions[CXL_MAX_DC_PARTITIONS] = { };
> +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) = NULL;
> +	struct device *dev = mbox->host;
> +	u8 avail_partitions = 0;
> +	u8 start_partition;
> +	u8 num_partitions;
> +	u8 partition_count;
> +	size_t dc_resp_size;
> +
> +	/*
> +	 * Bound requested number of partitions by mailbox payload size. The
> +	 * 256 byte spec minimum, verified in cxl_pci_setup_mailbox(), keeps
> +	 * the subtraction below from underflowing.
> +	 */
> +	partition_count = min(CXL_MAX_DC_PARTITIONS,
> +			      (mbox->payload_size - sizeof(*dc_resp) -
> +			       sizeof(struct cxl_mbox_get_dc_config_tail)) /
> +			      sizeof(struct cxl_dc_partition));
> +	dc_resp_size = struct_size(dc_resp, partition, partition_count) +
> +		       sizeof(struct cxl_mbox_get_dc_config_tail);
> +
> +	dc_resp = kmalloc(dc_resp_size, GFP_KERNEL);
> +	if (!dc_resp)
> +		return -ENOMEM;
> +
> +	start_partition = 0;
> +	num_partitions = 0;
> +	do {
> +		int returned, rc;
> +
> +		returned = cxl_get_dc_config(mbox, start_partition,
> +					     partition_count, dc_resp,
> +					     dc_resp_size);
> +		if (returned < 0) {
> +			dev_err(dev, "Failed to get DC config: %d\n", returned);
> +			return returned;
> +		}
> +
> +		if (returned == 0) {
> +			dev_err(dev,
> +				"Device reported %u partitions available but returned none at index %u\n",
> +				dc_resp->avail_partition_count, start_partition);
> +			return -EIO;
> +		}
> +
> +		/* A DCD reports at least one partition (CXL r4.0 Table 8-346) */
> +		if (dc_resp->avail_partition_count == 0) {
> +			dev_err(dev, "Device reported no DC partitions\n");
> +			return -EIO;
> +		}
> +
> +		avail_partitions = min(dc_resp->avail_partition_count,
> +				       CXL_MAX_DC_PARTITIONS);
> +
> +		/*
> +		 * Only partition 0 is mapped, so it is the only one checked.
> +		 * The rest are read to complete the enumeration and dropped.
> +		 */
> +		if (start_partition == 0) {
> +			rc = cxl_dc_check(dev, &partitions[0],
> +					  &dc_resp->partition[0]);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		num_partitions += returned;
> +		start_partition = num_partitions;
> +
> +	} while (num_partitions < avail_partitions);
> +
> +	/* Linux only supports the 1st partition; nothing to do if it is unavailable */
> +	if (partitions[0].size == 0)
> +		return -ENODEV;
> +
> +	*dc_info = partitions[0];
> +	dev_dbg(dev, "Returning partition 0 %#llx size %#llx\n",
> +		dc_info->start, dc_info->size);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dc_identify, "CXL");
> +
>  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..15df8db314d9 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -643,6 +643,54 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> +{
> +	struct cxl_dc_partition_info dc_info = { };
> +	struct device *dev = mds->cxlds.dev;
> +	u64 total;
> +	int rc;
> +
> +	if (!mds->cxlds.media_ready)
> +		return 0;
> +
> +	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
> +	if (rc) {
> +		dev_warn(dev,
> +			 "Failed to read Dynamic Capacity config: %d\n", rc);
> +		return rc;
> +	}
> +
> +	if (dc_info.start < info->size) {
> +		dev_err(dev,
> +			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n",
> +			dc_info.start, info->size);
> +		return -EINVAL;
> +	}
> +
> +	/* A gap between static capacity and the DC partition is not supported */
> +	if (dc_info.start > info->size) {
> +		dev_warn(dev,
> +			 "DC partition 0 base %#llx leaves a gap from static capacity ending at %#llx\n",
> +			 dc_info.start, info->size);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (check_add_overflow(info->size, dc_info.size, &total)) {
> +		dev_err(dev,
> +			"DC partition 0 size %#llx overflows DPA space ending at %#llx\n",
> +			dc_info.size, info->size);
> +		return -EINVAL;
> +	}
> +
> +	info->size = total;
> +	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> +		dc_info.start, dc_info.size);
> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_configure_dcd, "CXL");
> +
>  
>  /**
>   * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0c8e23276dc6..4fac65dbb808 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -407,6 +407,8 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };
>  
> +#define CXL_MAX_DC_PARTITIONS 8
> +
>  static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  {
>  	/*
> @@ -689,6 +691,39 @@ struct cxl_mbox_set_shutdown_state_in {
>  	u8 state;
>  } __packed;
>  
> +/* See CXL r4.0 Table 8-345 get dynamic capacity config Input Payload */
> +struct cxl_mbox_get_dc_config_in {
> +	u8 partition_count;
> +	u8 start_partition_index;
> +} __packed;
> +
> +/* See CXL r4.0 Table 8-346 get dynamic capacity config Output Payload */
> +struct cxl_mbox_get_dc_config_out {
> +	u8 avail_partition_count;
> +	u8 partitions_returned;
> +	u8 rsvd[6];
> +	/* See CXL r4.0 Table 8-347 */
> +	struct cxl_dc_partition {
> +		__le64 base;
> +		__le64 decode_length;
> +		__le64 length;
> +		__le64 block_size;
> +		__le32 dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed partition[] __counted_by(partitions_returned);
> +	/* Trailing extent/tag count fields unused */
> +} __packed;
> +
> +/* Trailing counts; cannot be a member after the flex array above */
> +struct cxl_mbox_get_dc_config_tail {
> +	__le32 num_extents_supported;
> +	__le32 num_extents_available;
> +	__le32 num_tags_supported;
> +	__le32 num_tags_available;
> +} __packed;
> +#define CXL_DCD_BLOCK_LINE_SIZE 0x40
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -812,9 +847,18 @@ enum {
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +
> +struct cxl_dc_partition_info {
> +	u64 start;
> +	u64 size;
> +};
> +
> +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> +			struct cxl_dc_partition_info *dc_info);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>  						 u16 dvsec);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> @@ -828,6 +872,17 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  			    const uuid_t *uuid, union cxl_event *evt);
>  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
>  int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
> +
> +static inline bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> +{
> +	return mds->dcd_supported;
> +}
> +
> +static inline void cxl_disable_dcd(struct cxl_memdev_state *mds)
> +{
> +	mds->dcd_supported = false;
> +}
> +
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..2fe9db4b3d86 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -868,6 +868,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	if (cxl_dcd_supported(mds)) {
> +		rc = cxl_configure_dcd(mds, &range_info);
> +		if (rc)
> +			cxl_disable_dcd(mds);
> +	}
> +
>  	rc = cxl_dpa_setup(cxlds, &range_info);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..4ef9511fbbdd 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -133,6 +133,7 @@ struct cxl_dpa_perf {
>  enum cxl_partition_mode {
>  	CXL_PARTMODE_RAM,
>  	CXL_PARTMODE_PMEM,
> +	CXL_PARTMODE_DYNAMIC_RAM_1,
>  };
>  
>  /**
> @@ -147,7 +148,7 @@ struct cxl_dpa_partition {
>  	enum cxl_partition_mode mode;
>  };
>  
> -#define CXL_NR_PARTITIONS_MAX 2
> +#define CXL_NR_PARTITIONS_MAX 3
>  
>  /**
>   * struct cxl_dev_state - The driver device state

