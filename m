Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FF075812
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448766; cv=none; b=sCTOvZe8VI6jnj94hwBaHlHFMjij4mhfNTZx81Ya7QecSBzerdxAMvWemVvQ4eLLhLEd4a7lSZuS7BeZN5dtscDydOIPdA0GifyJRlhPXMXMxsGuitaoOZnh0i84UktFiyAIZsV88TD4dsstNL+ZBT8c8DZ/l6QYhFFCbGRFF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448766; c=relaxed/simple;
	bh=ZninfWk10Fd1xe7gGJP5FUlMXyUi1AQJVrdUfu/A06U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1PxnA/qDZ0IhdMe5+fSaKa3hHHrMOS1sdgfuROheaHMCjAQEt9iQWLXYJbAudV0wLxfGx78sx6lOJlpY9cvQcTTGs6n16slqdjhgrhHOqwLcdJrEUUZz/o9UBiQtS+DedbGCToWWpLGlZ1Z0IhxH6HvkXZtZi90UGnfZEf4h30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A66DC433C7;
	Thu, 14 Mar 2024 20:39:25 +0000 (UTC)
Date: Thu, 14 Mar 2024 16:41:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: alison.schofield@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/trace: Properly initialize cxl_poison region
 name
Message-ID: <20240314164136.6d10aa28@gandalf.local.home>
In-Reply-To: <20240314201217.2112644-1-alison.schofield@intel.com>
References: <20240314201217.2112644-1-alison.schofield@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 13:12:17 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> The TP_STRUCT__entry that gets assigned the region name, or an
> empty string if no region is present, is erroneously initialized
> to the cxl_region pointer. It needs to be properly initialized
> otherwise it's length is wrong and garbage chars can appear in
> the kernel trace output: /sys/kernel/tracing/trace
> 
> The bad initialization was due in part to a naming conflict with
> the parameter: struct cxl_region *region. The field 'region' is
> already exposed externally as the region name, so changing that
> to something logical, like 'region_name' is not an option. Instead
> rename the internal only struct cxl_region to the commonly used
> 'cxlr'.
> 
> Impact is that tooling depending on that trace data can miss
> picking up a valid event when searching by region name. The
> TP_printk() output, if enabled, does emit the correct region
> names in the dmesg log.
> 
> This was found during testing of the cxl-list option to report
> media-errors for a region.
> 
> Fixes: ddf49d57b841 ("cxl/trace: Add TRACE support for CXL media-error records")

Probably should add Cc: stable, as passing in region as a string was a real
bug.

> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Changes in v2:
> - Initialize the region name with an assignment (Steve)
> - Rename struct cxl_region 'cxlr' instead of overusing 'region' identifier
> - Update commit message & log
> 
> 
>  drivers/cxl/core/trace.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index bdf117a33744..e5f13260fc52 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -646,18 +646,18 @@ u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
>  
>  TRACE_EVENT(cxl_poison,
>  
> -	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
> +	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
>  		 const struct cxl_poison_record *record, u8 flags,
>  		 __le64 overflow_ts, enum cxl_poison_trace_type trace_type),
>  
> -	TP_ARGS(cxlmd, region, record, flags, overflow_ts, trace_type),
> +	TP_ARGS(cxlmd, cxlr, record, flags, overflow_ts, trace_type),
>  
>  	TP_STRUCT__entry(
>  		__string(memdev, dev_name(&cxlmd->dev))
>  		__string(host, dev_name(cxlmd->dev.parent))
>  		__field(u64, serial)
>  		__field(u8, trace_type)
> -		__string(region, region)
> +		__string(region, cxlr ? dev_name(&cxlr->dev) : "")

I'm still curious to why NULL didn't work. I guess it may never have as I
noticed there's nothing else doing that. There are cases that a variable
returns NULL and the __string() handles it. But I guess the compiler gets
confused if the NULL is a possible return to the condition in __string().

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve



>  		__field(u64, overflow_ts)
>  		__field(u64, hpa)
>  		__field(u64, dpa)
> @@ -677,10 +677,10 @@ TRACE_EVENT(cxl_poison,
>  		__entry->source = cxl_poison_record_source(record);
>  		__entry->trace_type = trace_type;
>  		__entry->flags = flags;
> -		if (region) {
> -			__assign_str(region, dev_name(&region->dev));
> -			memcpy(__entry->uuid, &region->params.uuid, 16);
> -			__entry->hpa = cxl_trace_hpa(region, cxlmd,
> +		if (cxlr) {
> +			__assign_str(region, dev_name(&cxlr->dev));
> +			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
> +			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd,
>  						     __entry->dpa);
>  		} else {
>  			__assign_str(region, "");
> 
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba

