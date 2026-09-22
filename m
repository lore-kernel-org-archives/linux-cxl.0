Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586940BCB8
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118311; cv=none; b=pqmSPt1vu57B9WLt0YqxylCymq+HvDT3V/0N6Ay35lKUEaZQcXPYxfpLV56rAvkDGOCwKFmIVgE4nA8jpfn4HUwwHYzgXt2hEuQjIt0BIMEa6/D7j47zQxgOAfuNzfJWKar/NzZZHXek83dfqOT/o/3K0TW3jwgnHIizuVYIQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118311; c=relaxed/simple;
	bh=VdToNMW/24BHsqYHOTLilTFPEmmKxIX7NuIso+o5ivI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRDpTNri/DZvl03/xLFm4vgGG26W24kfQgrF1Hn7EtvU8HztNnT65jcgjJyjSZLsAwmQtC+i9vp+2H3O5p8e9zACMYibaDabPqnRwZq1am0To6A24XYrzqLufSz8dwmRptoAbzLEZeTfadDFLDQkc/HeEnq5GISUBO+4yuky4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJHUSqNb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJHUSqNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790118308; x=1821654308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VdToNMW/24BHsqYHOTLilTFPEmmKxIX7NuIso+o5ivI=;
  b=VJHUSqNbsujj4rAHGLQL/O8uwe/cJkG4QX2esdlLQTYbkSf2E4GBCalL
   x1kOA+vq+BEvY+ySusZen+3r8uPpBZdKdwLROVrT7JkGNv7EU9cHhRuiL
   ZequgMWRLduR9rhbYJt7WqFvfAc5Sr/kfKUZYsJcFQvLar/BjVyk9KeA4
   45DRLbGqXMfSNcFjvkwWEl9xJA0O1q6FJC13SZXFvYImdAWq+CRbg0Iha
   OAptL9CB8Ii1kTXZSbVsydNsEFPlqVcIkk5UcDC4uNyppWLXjkgv9scqh
   FLLn9D928zSXR/kVetQOdTV5DANB8+fbvKdM8DtA4Aa7jLshudPJKTQ3c
   w==;
X-CSE-ConnectionGUID: hpjezp+uTkKWnv1hk1Vm5A==
X-CSE-MsgGUID: /N2qHqRgS7ueEKyeNRvVJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89685811"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="89685811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 16:05:06 -0700
X-CSE-ConnectionGUID: bw2EZPN8SAW49RlQxqR2VQ==
X-CSE-MsgGUID: uYdHQQLqRte+bIClHiHgjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="299590187"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.110.50]) ([10.125.110.50])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 16:05:05 -0700
Message-ID: <59dd77a4-3ab0-4a6b-bab3-dd634c95f0f5@intel.com>
Date: Tue, 22 Sep 2026 16:05:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/8] cxl/cdat: Gather DSMAS data for DCD partitions
To: Anisa Su <anisa.su887@gmail.com>
Cc: Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
 Gregory Price <gourry@gourry.net>, Ben Cheatham <benjamin.cheatham@amd.com>,
 Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
 Junhee Park <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-4-anisa.su@samsung.com> <arH67By0gfwd-b1e@MWDK4CY14F>
 <fdccd5b2-69ac-4a00-af65-4b0584fa07e9@intel.com>
 <arLv12gmC-6ClDX6@4470NRD-ASU.ssi.samsung.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <arLv12gmC-6ClDX6@4470NRD-ASU.ssi.samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 2:15 PM, Anisa Su wrote:
> On Tue, Sep 22, 2026 at 10:08:08AM -0700, Dave Jiang wrote:
>>
>>
>> On 9/21/26 8:53 PM, Richard Cheng wrote:
>>> On Fri, Sep 18, 2026 at 01:30:12PM +0800, Anisa Su wrote:
>>>> From: Ira Weiny <iweiny@kernel.org>
>>>>
>>>> Additional DCD partition (AKA region) information is contained in the
>>>> DSMAS CDAT tables, including performance and shareable attributes.
>>>>
>>>> Match DCD partitions with DSMAS tables and store the meta data.
>>>>
>>>> Signed-off-by: Ira Weiny <iweiny@kernel.org>
>>>> Co-developed-by: Anisa Su <anisa.su@samsung.com>
>>>> Signed-off-by: Anisa Su <anisa.su@samsung.com>
>>>> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
>>>> Tested-by: Junhee Park <jh9934.park@samsung.com>
>>>> Tested-by: Heesoo Kim <habil.kim@samsung.com>
>>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>>>
>>>
>>> Hi Anisa,
>>>
>>> LGTM but I have limited knowledge for details of device's CDAT.
>>> Other experts would be more suitable to leave their tag.
>>>
>>> I have a question here only, I wonder if a CDAT with no DSLBIS supported is
>>> possible ? seems that the implementation has the assumption that device's
>>> CDAT would be always supported with valid DSMAS and DSLBIS.
>>
>> According to the spec, the device suppoort DCD shall provide DSMAS (CXL r4.0 9.13.3). DSLBIS is optional.
>>
>> So I do wonder if we need to add plumbing to disable DCD if DSMAS is missing or malformed. 
>>
>> DJ
>>
> Can do. DSMAS is missing/malformed in 3 scenarios:
> - CDAT is missing
> - Failed to parse DSMAS from the CDAT
> - No DSMAS entry matched the DC partition.
> 
> So we can make a helper function to disable DCD and call from all 3 sites:
> 
> +/*
> + * A DCD shall describe its DC partition in a DSMAS entry (CXL r4.0 9.13.3).
> + * Without one the partition's attributes are unknown, so disable DCD.
> + */
> +static void cxl_dcd_dsmas_missing(struct cxl_dev_state *cxlds, const char *why)
> +{
> +	struct cxl_memdev_state *mds;
> +
> +	if (cxlds->type != CXL_DEVTYPE_CLASSMEM)
> +		return;
> +
> +	mds = to_cxl_memdev_state(cxlds);
> +	if (!cxl_dcd_supported(mds) ||
> +	    !cxl_part_size(cxlds, CXL_PARTMODE_DYNAMIC_RAM_1))
> +		return;
> +
> +	dev_warn(cxlds->dev, "DC partition has no valid DSMAS entry (%s), disabling DCD\n",
> +		 why);
> +	cxl_disable_dcd(mds);
> +}
> 
> Called if there's no CDAT/fails to parse CDAT:
> 
> void cxl_endpoint_parse_cdat(struct cxl_port *port)
>  	int rc;
>  
>  	xa_init(&__dsmas_xa);
> -	if (!port->cdat.table)
> +	if (!port->cdat.table) {
> +		cxl_dcd_dsmas_missing(cxlds, "no CDAT");
>  		return;
> +	}
>  
>  	rc = cxl_cdat_endpoint_process(port, dsmas_xa);
>  	if (rc < 0) {
>  		dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
> +		cxl_dcd_dsmas_missing(cxlds, "CDAT parse failed");
>  		return;
>  	}
> 
> Or no DSMAS entry matched the DC partition:
> static void cxl_memdev_apply_dsmas(struct cxl_dev_state *cxlds,
>  	struct device *dev = cxlds->dev;
>  	struct dsmas_entry *dent;
> +	bool dc_matched = false;
>  	unsigned long index;
> ...
>  			if (set_perf)
>  				update_perf_entry(dev, dent, &part->perf);
> -			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1) {
>  				part->shareable = dent->shareable;
> +				dc_matched = true;
> +			}
>  			break;
>  		}
> 
> ... 
> 			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
>  				&dent->dpa_range);
>  	}
> +
> +	if (!dc_matched)
> +		cxl_dcd_dsmas_missing(cxlds, "no matching entry");
>  }
> 
> But currently cxl_cdat_endpoint_process() fails if there's no DSLBIS or it's
> empty and DSLBIS is optional for DCD, so need a prep patch to allow empty DSLBIS
> and skip cxl_port_perf_data_calculate(port, dsmas_xa) if it's empty.

But perf calc failure does not stop the probe. cxl_endpoint_parse_cdat() returns void. We swallow the error. So I don't think changes are needed around here? You get -ENOENT if no entries from cdat_table_parse_output(). 

DJ

> 
> Something like this:
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -181,7 +181,7 @@
>  }
>  
>  static int cxl_cdat_endpoint_process(struct cxl_port *port,
> -				     struct xarray *dsmas_xa)
> +				     struct xarray *dsmas_xa, bool *has_dslbis)
>  {
>  	int rc;
>  
> @@ -191,9 +191,13 @@
>  	if (rc)
>  		return rc;
>  
> +	/* DSLBIS is optional; without it there is no perf data to apply */
>  	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
>  			      dsmas_xa, port->cdat.table, port->cdat.length);
> -	return cdat_table_parse_output(rc);
> +	if (rc < 0)
> +		return rc;
> +	*has_dslbis = rc > 0;
> +	return 0;
>  }
>  
>  static int cxl_port_perf_data_calculate(struct cxl_port *port,
> @@ -430,19 +434,22 @@
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct xarray __dsmas_xa;
>  	struct xarray *dsmas_xa __free(dsmas) = &__dsmas_xa;
> +	bool has_dslbis = false;
>  	int rc;
>  
>  	xa_init(&__dsmas_xa);
>  	if (!port->cdat.table)
>  		return;
>  
> -	rc = cxl_cdat_endpoint_process(port, dsmas_xa);
> +	rc = cxl_cdat_endpoint_process(port, dsmas_xa, &has_dslbis);
>  	if (rc < 0) {
>  		dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
>  		return;
>  	}
>  
> -	rc = cxl_port_perf_data_calculate(port, dsmas_xa);
> +	rc = -ENOENT;
> +	if (has_dslbis)
> +		rc = cxl_port_perf_data_calculate(port, dsmas_xa);
>  	if (rc)
>  		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
> 
> 
> Would something like this work? (I am also not an expert in CDAT/DSMAS/DSLBIS)
> 
> Thanks,
> Anisa
>>>
>>> Best regards,
>>> Richard Cheng.
>>>
>>>  
>>>> ---
>>>> Changes:
>>>> 1. cdat.c: record the DSMAS shareable flag independently of QTG
>>>>    discovery. cxl_port_perf_data_calculate() returns -ENOENT when FW
>>>>    recommends no QTG for any entry, which skipped the assignment even
>>>>    though the CDAT parsed successfully and the DSMAS flag was valid.
>>>>    Richard
>>>> ---
>>>>  drivers/cxl/core/cdat.c   | 49 +++++++++++++++++++++++++++++----------
>>>>  drivers/cxl/core/hdm.c    |  1 +
>>>>  drivers/cxl/core/mbox.c   |  9 +++++++
>>>>  drivers/cxl/core/memdev.c | 17 ++++++++------
>>>>  drivers/cxl/cxlmem.h      |  2 ++
>>>>  include/cxl/cxl.h         |  4 ++++
>>>>  6 files changed, 63 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>>>> index 5c9f07262513..6e7950f12134 100644
>>>> --- a/drivers/cxl/core/cdat.c
>>>> +++ b/drivers/cxl/core/cdat.c
>>>> @@ -17,6 +17,7 @@ struct dsmas_entry {
>>>>  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
>>>>  	int entries;
>>>>  	int qos_class;
>>>> +	bool shareable;
>>>>  };
>>>>  
>>>>  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
>>>> @@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
>>>>  		return -ENOMEM;
>>>>  
>>>>  	dent->handle = dsmas->dsmad_handle;
>>>> +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
>>>> +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
>>>>  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
>>>>  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
>>>>  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
>>>> @@ -255,8 +258,13 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>>>>  		dent->coord[ACCESS_COORDINATE_CPU].write_latency);
>>>>  }
>>>>  
>>>> -static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>>>> -				     struct xarray *dsmas_xa)
>>>> +/*
>>>> + * The DSMAS shareable flag is a property of the CDAT entry and is recorded
>>>> + * even if FW returns no QTG recommendations for any entry; only update perf
>>>> + * if those recommendations exist, indicated by @set_perf
>>>> + */
>>>> +static void cxl_memdev_apply_dsmas(struct cxl_dev_state *cxlds,
>>>> +				   struct xarray *dsmas_xa, bool set_perf)
>>>>  {
>>>>  	struct device *dev = cxlds->dev;
>>>>  	struct dsmas_entry *dent;
>>>> @@ -266,18 +274,34 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>>>>  		bool found = false;
>>>>  
>>>>  		for (int i = 0; i < cxlds->nr_partitions; i++) {
>>>> -			struct resource *res = &cxlds->part[i].res;
>>>> +			struct cxl_dpa_partition *part = &cxlds->part[i];
>>>>  			struct range range = {
>>>> -				.start = res->start,
>>>> -				.end = res->end,
>>>> +				.start = part->res.start,
>>>> +				.end = part->res.end,
>>>>  			};
>>>>  
>>>> -			if (range_contains(&range, &dent->dpa_range)) {
>>>> -				update_perf_entry(dev, dent,
>>>> -						  &cxlds->part[i].perf);
>>>> -				found = true;
>>>> +			if (!range_contains(&range, &dent->dpa_range))
>>>> +				continue;
>>>> +
>>>> +			found = true;
>>>> +			/*
>>>> +			 * part->handle is from Get DC Config, dent->handle
>>>> +			 * from the CDAT DSMAS entry.
>>>> +			 */
>>>> +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
>>>> +			    dent->handle != part->handle) {
>>>> +				dev_warn(dev,
>>>> +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
>>>> +					 &range, part->handle,
>>>> +					 &dent->dpa_range, dent->handle);
>>>>  				break;
>>>>  			}
>>>> +
>>>> +			if (set_perf)
>>>> +				update_perf_entry(dev, dent, &part->perf);
>>>> +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
>>>> +				part->shareable = dent->shareable;
>>>> +			break;
>>>>  		}
>>>>  
>>>>  		if (!found)
>>>> @@ -419,12 +443,13 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
>>>>  	}
>>>>  
>>>>  	rc = cxl_port_perf_data_calculate(port, dsmas_xa);
>>>> -	if (rc) {
>>>> +	if (rc)
>>>>  		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
>>>> +
>>>> +	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, rc == 0);
>>>> +	if (rc)
>>>>  		return;
>>>> -	}
>>>>  
>>>> -	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
>>>>  	cxl_qos_class_verify(cxlmd);
>>>>  	cxl_memdev_update_perf(cxlmd);
>>>>  }
>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>>> index 0ef076c08ed2..7f63b86887f4 100644
>>>> --- a/drivers/cxl/core/hdm.c
>>>> +++ b/drivers/cxl/core/hdm.c
>>>> @@ -477,6 +477,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
>>>>  
>>>>  		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
>>>>  		cxlds->part[i].mode = part->mode;
>>>> +		cxlds->part[i].handle = part->handle;
>>>>  
>>>>  		/* Require ordered + contiguous partitions */
>>>>  		if (i) {
>>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>>> index c96c16cc08e1..d84a90320081 100644
>>>> --- a/drivers/cxl/core/mbox.c
>>>> +++ b/drivers/cxl/core/mbox.c
>>>> @@ -1366,6 +1366,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
>>>>  	u64 decode_len = le64_to_cpu(dev_part->decode_length);
>>>>  	u64 blk_size = le64_to_cpu(dev_part->block_size);
>>>>  	u64 len = le64_to_cpu(dev_part->length);
>>>> +	u32 handle = le32_to_cpu(dev_part->dsmad_handle);
>>>>  	u64 size;
>>>>  
>>>>  	/*
>>>> @@ -1378,6 +1379,13 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
>>>>  		return 0;
>>>>  	}
>>>>  
>>>> +	/* The CDAT DSMAD handle this refers to is 8 bits */
>>>> +	if (handle & ~0xFF) {
>>>> +		dev_warn(dev, "DSMAD handle 0x%x exceeds the 8 bit CDAT DSMAD handle\n",
>>>> +			 handle);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>>  	/*
>>>>  	 * Decode length is a count of 256M units, so a device reporting 2^36
>>>>  	 * or more wraps.
>>>> @@ -1391,6 +1399,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
>>>>  	*part = (struct cxl_dc_partition_info) {
>>>>  		.start = le64_to_cpu(dev_part->base),
>>>>  		.size = size,
>>>> +		.handle = handle,
>>>>  	};
>>>>  
>>>>  	/*
>>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>>> index 15df8db314d9..8883c8850759 100644
>>>> --- a/drivers/cxl/core/memdev.c
>>>> +++ b/drivers/cxl/core/memdev.c
>>>> @@ -594,7 +594,8 @@ bool is_cxl_memdev(const struct device *dev)
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>>>>  
>>>> -static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
>>>> +static void add_part(struct cxl_dpa_info *info, u64 start, u64 size,
>>>> +		     enum cxl_partition_mode mode, u8 handle)
>>>>  {
>>>>  	int i = info->nr_partitions;
>>>>  
>>>> @@ -606,6 +607,7 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>>>>  		.end = start + size - 1,
>>>>  	};
>>>>  	info->part[i].mode = mode;
>>>> +	info->part[i].handle = handle;
>>>>  	info->nr_partitions++;
>>>>  }
>>>>  
>>>> @@ -623,9 +625,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>>>>  	info->size = mds->total_bytes;
>>>>  
>>>>  	if (mds->partition_align_bytes == 0) {
>>>> -		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
>>>> +		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM, 0);
>>>>  		add_part(info, mds->volatile_only_bytes,
>>>> -			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
>>>> +			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM, 0);
>>>>  		return 0;
>>>>  	}
>>>>  
>>>> @@ -635,9 +637,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>>>>  		return rc;
>>>>  	}
>>>>  
>>>> -	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
>>>> +	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM, 0);
>>>>  	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
>>>> -		 CXL_PARTMODE_PMEM);
>>>> +		 CXL_PARTMODE_PMEM, 0);
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -685,7 +687,8 @@ int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>>>>  	info->size = total;
>>>>  	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
>>>>  		dc_info.start, dc_info.size);
>>>> -	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
>>>> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1,
>>>> +		 dc_info.handle);
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -704,7 +707,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
>>>>  		.size = capacity,
>>>>  	};
>>>>  
>>>> -	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
>>>> +	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM, 0);
>>>>  	return cxl_dpa_setup(cxlds, &range_info);
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>> index 4fac65dbb808..9fd5af2e41d4 100644
>>>> --- a/drivers/cxl/cxlmem.h
>>>> +++ b/drivers/cxl/cxlmem.h
>>>> @@ -140,6 +140,7 @@ struct cxl_dpa_info {
>>>>  	struct cxl_dpa_part_info {
>>>>  		struct range range;
>>>>  		enum cxl_partition_mode mode;
>>>> +		u8 handle;
>>>>  	} part[CXL_NR_PARTITIONS_MAX];
>>>>  	int nr_partitions;
>>>>  };
>>>> @@ -851,6 +852,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>>>>  struct cxl_dc_partition_info {
>>>>  	u64 start;
>>>>  	u64 size;
>>>> +	u8 handle;
>>>>  };
>>>>  
>>>>  int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
>>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>>> index 4ef9511fbbdd..43edcde5bce3 100644
>>>> --- a/include/cxl/cxl.h
>>>> +++ b/include/cxl/cxl.h
>>>> @@ -141,11 +141,15 @@ enum cxl_partition_mode {
>>>>   * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
>>>>   * @perf: performance attributes of the partition from CDAT
>>>>   * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
>>>> + * @handle: DSMAS handle that represents this partition
>>>> + * @shareable: Is the partition shareable (from its CDAT DSMAS entry)
>>>>   */
>>>>  struct cxl_dpa_partition {
>>>>  	struct resource res;
>>>>  	struct cxl_dpa_perf perf;
>>>>  	enum cxl_partition_mode mode;
>>>> +	u8 handle;
>>>> +	bool shareable;
>>>>  };
>>>>  
>>>>  #define CXL_NR_PARTITIONS_MAX 3
>>>> -- 
>>>> 2.43.0
>>>>
>>>
>>

