Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2863171664
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375038; cv=none; b=Bp8qW32+jpcuOpfQrZqnAERFBvDhh15HjdMRnMz/uQr3qsUA25WmCmIHcv7X8jO3m+Q24P91qAznV/0FjL/pB24I5VjMZAfKGGbHQZk5qvonLZTIcbtwO+BZ1TVJuM4zsadx9ZB1mDohCct6wFEvmwVwPggJsfF4gFzBhGGEvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375038; c=relaxed/simple;
	bh=5mH3cTp6TZtRdu9Nx6lCJ+m7zkZHFOEqCRMyPxsY7kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doRSGhvhrgayqVftbGQZAif/ZmtAEvNagx4z+PRhb8ZCdmMbWECgscWMoV9k509uen70ct0dyOw7HtvFgNi51+rTiMcimIpiNHlikIGWir25sFY7YTOJWFI9t/WmWz8xEiXfIxM2kRVPzHukLlzqX8fO94ZprzE8PSy/RE5hTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqOfyS9m; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqOfyS9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713375036; x=1744911036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5mH3cTp6TZtRdu9Nx6lCJ+m7zkZHFOEqCRMyPxsY7kM=;
  b=iqOfyS9mAeMYv2052f2d+D0Hzx+4xcRqqMzAE4cDuJPnaj7fBHwMaqUg
   s2dV0//7Bou/kKg+cBOMrNUMFF7+V5P1N2l796KRsjwoag9IXR0SOvQ0o
   mbV8hT6Lj+e3NzsGp7STatDwq9JjIRGl4Ma76lfAxWnDkEDlLpGBURWa+
   6HhTQGpqAeEPtjo+DbTqJTEM/oxnrsno1FUYONLXR5m+actM0MzoAdKgt
   DzCTZzV8zCQr/lbMe4WfGHiSVDG/9A75ZZbO8mi5K2i2ETaT5ELGzgwUj
   MkW2crYZjhjLaCQGZ1nZwZvzMnbmsE6Z06s1s5dbhAdlrhvYVCGo7G9X2
   g==;
X-CSE-ConnectionGUID: OxIFh/ULStK9HgWChI3aJw==
X-CSE-MsgGUID: Xb07gE0cSxShWp6T9kPFiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9005932"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9005932"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:30:35 -0700
X-CSE-ConnectionGUID: jX0vY89rQSaPBMPhF80OZQ==
X-CSE-MsgGUID: 357QEn3cQjy6jJyoSzbbIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="23118306"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.69.240]) ([10.212.69.240])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:30:35 -0700
Message-ID: <13652e98-3a70-4946-b8b0-be11032ca431@intel.com>
Date: Wed, 17 Apr 2024 10:30:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, alison.schofield@intel.com
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/17/24 12:50 AM, Shiyang Ruan wrote:
> Currently driver only traces cxl events, poison creation (for both vmem
> and pmem type) on cxl memdev is silent.  OS needs to be notified then it
> could handle poison pages in time.  Per CXL spec, the device error event
> could be signaled through FW-First and OS-First methods.

Please consider below for better clarity:
Currently the driver only traces CXL events. Poison creation (for both ram
and pmem type) on a CXL memdev is silent. The OS needs to be notified so it
can handle poison pages. Per CXL spec, the device error event
can be signaled through the FW-First method or the OS-First method.

> 
> So, add poison creation event handler in OS-First method:
>   - Qemu:
>     - CXL device reports POISON creation event to OS by MSI by sending
>       GMER/DER after injecting a poison record;

Can probably drop the QEMU changes and this is the kernel commit log.

>   - CXL driver:
>     a. parse the POISON event from GMER/DER;
>     b. translate poisoned DPA to HPA (PFN);
>     c. enqueue poisoned PFN to memory_failure's work queue;
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxlmem.h      |   8 +--
>  include/linux/cxl-event.h |  18 +++++-
>  3 files changed, 125 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f0f54aeccc87..76af0d73859d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt)
> +static void cxl_report_poison(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,

I think this needs to be changed to __cxl_report_poison() and the function below to cxl_report_poison(). Otherwise it goes against typical Linux methodology of having the __functionX() as the raw functionality function called by a functionX() wrapper. 

DJ

> +			      u64 dpa)
>  {
> -	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +	u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> +	unsigned long pfn = PHYS_PFN(hpa);
> +
> +	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
> +		return;
> +
> +	memory_failure_queue(pfn, MF_ACTION_REQUIRED);
> +}
> +
> +static int __cxl_report_poison(struct device *dev, void *arg)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
> +	u64 dpa = *(u64 *)arg;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
> +		return 0;
> +
> +	if (cxled->mode == CXL_DECODER_MIXED) {
> +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> +		return 0;
> +	}
> +
> +	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
> +		return 0;
> +
> +	cxlmd = cxled_to_memdev(cxled);
> +	cxl_report_poison(cxlmd, cxled->cxld.region, dpa);
> +
> +	return 1;
> +}
> +
> +static void cxl_event_handle_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	struct cxl_port *port = cxlmd->endpoint;
> +
> +	/*
> +	 * No region is mapped to this endpoint, that is to say no HPA is
> +	 * mapped.
> +	 */
> +	if (!port || !is_cxl_endpoint(port) ||
> +	    cxl_num_decoders_committed(port) == 0)
> +		return;
> +
> +	device_for_each_child(&port->dev, &dpa, __cxl_report_poison);
> +}
> +
> +static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
> +					   enum cxl_event_log_type type,
> +					   struct cxl_event_gen_media *rec)
> +{
> +	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
> +
> +	if (type == CXL_EVENT_TYPE_FAIL) {
> +		switch (rec->transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> +			cxl_event_handle_poison(cxlmd, dpa);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static void cxl_event_handle_dram(struct cxl_memdev *cxlmd,
> +				  enum cxl_event_log_type type,
> +				  struct cxl_event_dram *rec)
> +{
> +	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
> +
> +	if (type == CXL_EVENT_TYPE_FAIL) {
> +		switch (rec->transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> +			cxl_event_handle_poison(cxlmd, dpa);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt)
> +{
> +	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>  		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> -	else if (event_type == CXL_CPER_EVENT_DRAM)
> +		cxl_event_handle_general_media(cxlmd, type, &evt->gen_media);
> +	} else if (event_type == CXL_CPER_EVENT_DRAM) {
>  		trace_cxl_dram(cxlmd, type, &evt->dram);
> -	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
> +		cxl_event_handle_dram(cxlmd, type, &evt->dram);
> +	} else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
>  		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
>  	else
>  		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_event_handle_record, CXL);
>  
> -static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -				     enum cxl_event_log_type type,
> -				     struct cxl_event_record_raw *record)
> +static void __cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +				      enum cxl_event_log_type type,
> +				      struct cxl_event_record_raw *record)
>  {
>  	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
>  	const uuid_t *uuid = &record->id;
> @@ -867,7 +958,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
>  		ev_type = CXL_CPER_EVENT_MEM_MODULE;
>  
> -	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
> +	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
>  }
>  
>  static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> @@ -979,8 +1070,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			break;
>  
>  		for (i = 0; i < nr_rec; i++)
> -			__cxl_event_trace_record(cxlmd, type,
> -						 &payload->records[i]);
> +			__cxl_event_handle_record(cxlmd, type,
> +						  &payload->records[i]);
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 36cee9c30ceb..ba1347de5651 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -822,10 +822,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt);
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 03fa6d50d46f..8189bed76c12 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -23,6 +23,20 @@ struct cxl_event_generic {
>  	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
>  } __packed;
>  
> +/*
> + * Event transaction type
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +enum cxl_event_transaction_type {
> +	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
> +	CXL_EVENT_TRANSACTION_READ,
> +	CXL_EVENT_TRANSACTION_WRITE,
> +	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
> +	CXL_EVENT_TRANSACTION_INJECT_POISON,
> +	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
> +	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
> +};
> +
>  /*
>   * General Media Event Record
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> @@ -33,7 +47,7 @@ struct cxl_event_gen_media {
>  	__le64 phys_addr;
>  	u8 descriptor;
>  	u8 type;
> -	u8 transaction_type;
> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>  	u8 validity_flags[2];
>  	u8 channel;
>  	u8 rank;
> @@ -52,7 +66,7 @@ struct cxl_event_dram {
>  	__le64 phys_addr;
>  	u8 descriptor;
>  	u8 type;
> -	u8 transaction_type;
> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>  	u8 validity_flags[2];
>  	u8 channel;
>  	u8 rank;
