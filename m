Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC802C197
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736855; cv=none; b=UeepHdqjINBFcUvZIaoqbAdsQ8fBCEbAbH6jfMGcOpeLI+xXVrsHoOgTOhLS3KSg3X0ZDXF0r3f7Uz3oYD1SeoU0ORXuQPFBql2ctzelYBYMCbiQxoZp26Ou70N91L+qtaD5mVWi8m7bXnf6e/juRkt5VDeV2J4ML2AvOZlWdSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736855; c=relaxed/simple;
	bh=S2qdv+SnNoKHxZRT086jR4m8AN6i21k7r1PVt7j7Duw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnlE9q/1ddZalPUqFFYjcqtQrExdAeOnoaoPYLX1z8uK6huoYTvnGIM5NfU5GefGLTfoclrw6+SRSfmPvXWAEW5cD+vyBlTVpwmX8tH7y3ACjHZAxZk+N53GmoxLU+3klq/DBCEWdEv3qHNbijmtxOKwun4Ls+hAq4pclIxY43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xg4gCe6l; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xg4gCe6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711736854; x=1743272854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S2qdv+SnNoKHxZRT086jR4m8AN6i21k7r1PVt7j7Duw=;
  b=Xg4gCe6l84okGzpXhDfOxYQsYivgScxZvIDqk5bjan1jVANyF0urCAwT
   IdBMfbC78woLNwTa2NK2l/2A2YRWDiNQxggeZtOz4/QsuyrDpiO6o34aE
   oMH1AzlZmDfcEJIv6p4NTQ5SJJK8C7VZFRR8gKKF2kiiW+MDSDfvbjz5/
   ZZkWbvcCE2JV/M/ABRqOBbmnwT72tlprPcUhVmfyVOF9QtlxBK97wdyek
   CW8jToOQ+4bZ9vmlpd3E2xWRlKkDcE4lkaU1ZApoTII6o83GTYVgeLLum
   I9HdRQ8oXdmwG3F+T/Fq3zo6YpE0YRVcC4dl289sbp3IqgItODiVNYe4K
   A==;
X-CSE-ConnectionGUID: d/OTM7xVTjODOsx3jKZyAQ==
X-CSE-MsgGUID: m8h5nZERScaM4qT4drFVig==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="17489274"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17489274"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 11:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="40195361"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.86.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 11:27:31 -0700
Date: Fri, 29 Mar 2024 11:27:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	dave@stgolabs.net, ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 6/6] cxl/core: add poison injection event handler
Message-ID: <ZgcIEVajbf9tV5ZQ@aschofie-mobl2>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-7-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329063614.362763-7-ruansy.fnst@fujitsu.com>

On Fri, Mar 29, 2024 at 02:36:14PM +0800, Shiyang Ruan wrote:
> Currently driver only traces cxl events, poison injection (for both vmem
> and pmem type) on cxl memdev is silent.  OS needs to be notified then it
> could handle poison range in time.  Per CXL spec, the device error event
> could be signaled through FW-First and OS-First methods.
> 
> So, add poison event handler in OS-First method:
>   - qemu:
>     - CXL device report POISON event to OS by MSI by sending GMER after
>       injecting a poison record
>   - CXL driver
>     a. parse the POISON event from GMER;        <-- this patch
>     b. retrieve POISON list from memdev;
>     c. translate poisoned DPA to HPA;
>     d. enqueue poisoned PFN to memory_failure's work queue;
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
> 
> the reply to Jonathan's comment in last version:
> > I'm not 100% convinced this is necessary poison causing.  Also
> > the text tells us we should see 'an appropriate event'.
> > DRAM one seems likely to be chosen by some vendors.
> I think it's right to use DRAM Event Record for volatile-memdev, but 
> should poison on a persistent-memdev also use DRAM Event Record too? 
> Though its 'Physical Address' feild has the 'Volatile' bit too, which is 
> same as General Media Event Record.  I am a bit confused about this.


Similar thought as shared in cover letter -
Can the driver trigger new poison list read on any events of interest,
and implement a policy to report mem failures on all poison list reads
that hit mapped addresses?

I guess if the answer to that question is NO - we only report memory
failures on GMER/poison, can we find more synergy and not repeat so 
much work.

--Alison

> 
> ---
>  drivers/cxl/core/mbox.c | 100 ++++++++++++++++++++++++++++++++++------
>  drivers/cxl/cxlmem.h    |   8 ++--
>  2 files changed, 91 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 19b46fb06ed6..97ef45d808b8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -837,25 +837,99 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt)
> +struct cxl_event_poison_context {
> +	u64 dpa;
> +	u64 length;
> +};
> +
> +static int __cxl_report_poison(struct device *dev, void *arg)
> +{
> +	struct cxl_event_poison_context *ctx = arg;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
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
> +	if (ctx->dpa > cxled->dpa_res->end || ctx->dpa < cxled->dpa_res->start)
> +		return 0;
> +
> +	cxlmd = cxled_to_memdev(cxled);
> +	cxl_mem_get_poison(cxlmd, ctx->dpa, ctx->length, cxled->cxld.region,
> +			   true);
> +
> +	return 1;
> +}
> +
> +static void cxl_event_handle_poison(struct cxl_memdev *cxlmd,
> +				    struct cxl_event_gen_media *rec)
> +{
> +	struct cxl_port *port = cxlmd->endpoint;
> +	u64 phys_addr = le64_to_cpu(rec->phys_addr);
> +	struct cxl_event_poison_context ctx = {
> +		.dpa = phys_addr & CXL_DPA_MASK,
> +	};
> +
> +	/* No regions mapped to this memdev, that is to say no HPA is mapped */
> +	if (!port || !is_cxl_endpoint(port) ||
> +	    cxl_num_decoders_committed(port) == 0)
> +		return;
> +
> +	/*
> +	 * Host Inject Poison may have a range of DPA, but the GMER only has
> +	 * "Physical Address" field, no such one indicates length.  So it's
> +	 * better to call cxl_mem_get_poison() to find this poison record.
> +	 */
> +	ctx.length = phys_addr & CXL_DPA_VOLATILE ?
> +			resource_size(&cxlmd->cxlds->ram_res) :
> +			resource_size(&cxlmd->cxlds->pmem_res) - ctx.dpa;
> +
> +	device_for_each_child(&port->dev, &ctx, __cxl_report_poison);
> +}
> +
> +static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
> +					   enum cxl_event_log_type type,
> +					   struct cxl_event_gen_media *rec)
> +{
> +	if (type == CXL_EVENT_TYPE_FAIL) {
> +		switch (rec->transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> +			cxl_event_handle_poison(cxlmd, rec);
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
>  {
> -	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>  		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> -	else if (event_type == CXL_CPER_EVENT_DRAM)
> +		cxl_event_handle_general_media(cxlmd, type, &evt->gen_media);
> +	} else if (event_type == CXL_CPER_EVENT_DRAM)
>  		trace_cxl_dram(cxlmd, type, &evt->dram);
>  	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
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
> @@ -867,7 +941,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
>  		ev_type = CXL_CPER_EVENT_MEM_MODULE;
>  
> -	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
> +	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
>  }
>  
>  static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> @@ -978,8 +1052,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
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
> index 1f03130b9d6a..dfd7bdd0d66a 100644
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
>  void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
> -- 
> 2.34.1
> 
> 
