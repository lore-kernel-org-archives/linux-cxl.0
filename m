Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB931922FA
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747236293; cv=none; b=kGbUXmr4SJoLytKZiM7RuaA/ca2jo+VM4YL1NCIRrnEy+QIH+cTRbX6mYqGcHFhf7LEgXukP6X2vKckzfRJkuc+g39YvOmFVykF3U9D9jPLYTzIo+UJ62aPK/BJPtmEkBiby93DTCRK9IbEpUXkykhxqk7Bl/WRwyhpGPIhVJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747236293; c=relaxed/simple;
	bh=wmHnJpmAcIa7JfmQ9fODXpc63dyceb/b4Pk1I3sUdbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntB7SkZZgOwM/v3PBTD/sapv1FC4Yb7NrT4FOocjdyhSooyrQFrjrKOjk2noA8J+TaJo1oy9V68TIs6LlpDEY3WqeKJKnffYjA8j1oSW1XDJl9V5a8JOlZeOU2pzJwBT7O4Si/sBhy/NtChJrBDKGyvWIUjSkPJpATZDmBuChJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZwWynmG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZwWynmG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747236292; x=1778772292;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wmHnJpmAcIa7JfmQ9fODXpc63dyceb/b4Pk1I3sUdbM=;
  b=RZwWynmGKlbbPHCso/hGS8148kP5hxKsNgvItkwV7Y5JEccT+XJPeFYD
   egkbYVJuzeCoyZZGZNNbmMuuQugXCiDyRRf6gH63pxwVYjsNqmMPO82cF
   RX8ORRzgy/lEqG8DD4lePaHvmLAs5LlOYmO4k1XwCxKvFieu7LG6/jgb/
   3vM+u05jBathzBUpEd3T7pPry6J64Eh2MLeu8l186cRiWEnvrz1JuTlw3
   HzLaeaprxCsstqCtxAeaj0vwRI+ZOcK3JbZOLzAgFvZfsNydQNehB58DL
   u+y8+0o0n0tc2HqzN0bWXbTdBQkr3fUTJ2aX0g2xRxJuw83FSXPWEHJhv
   A==;
X-CSE-ConnectionGUID: i2dUAvycR5u2VncTil9D5A==
X-CSE-MsgGUID: iiPjliqJTSGgW/kpLVN17A==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49011492"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49011492"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:24:51 -0700
X-CSE-ConnectionGUID: DdSU+TYoT2WzF/uvhAHRjQ==
X-CSE-MsgGUID: lZwObntySbmdigvZyeB7rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="138990009"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.25]) ([10.125.109.25])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:24:50 -0700
Message-ID: <a340a0a1-6b2f-469b-b609-9e618ce28070@intel.com>
Date: Wed, 14 May 2025 08:24:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/events: Update Common Event Record to CXL spec
 rev 3.2
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: nifan.cxl@gmail.com, linuxarm@huawei.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com
References: <20250514151913.752-1-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250514151913.752-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/25 8:19 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.2.1 Table 8-55, Common Event Record format
> has updated with LD-ID and ID of the device head fields.
> 
> Add updates for the above spec changes in the CXL events record and CXL
> common trace event implementation.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/trace.h | 22 ++++++++++++++++------
>  include/cxl/event.h      |  4 +++-
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 25ebfbc1616c..ce482e57a477 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -214,12 +214,16 @@ TRACE_EVENT(cxl_overflow,
>  #define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
>  #define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
>  #define CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID	BIT(6)
> +#define CXL_EVENT_RECORD_FLAG_LD_ID_VALID	BIT(7)
> +#define CXL_EVENT_RECORD_FLAG_HEAD_ID_VALID	BIT(8)
>  #define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
>  	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
>  	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
>  	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
> -	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	},  \
> -	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,	"MAINT_OP_SUB_CLASS_VALID" }	\
> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}, \
> +	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,	"MAINT_OP_SUB_CLASS_VALID" }, \
> +	{ CXL_EVENT_RECORD_FLAG_LD_ID_VALID,	"LD_ID_VALID" }, \
> +	{ CXL_EVENT_RECORD_FLAG_HEAD_ID_VALID,	"HEAD_ID_VALID" } \
>  )
>  
>  /*
> @@ -247,7 +251,9 @@ TRACE_EVENT(cxl_overflow,
>  	__field(u64, hdr_timestamp)				\
>  	__field(u8, hdr_length)					\
>  	__field(u8, hdr_maint_op_class)				\
> -	__field(u8, hdr_maint_op_sub_class)
> +	__field(u8, hdr_maint_op_sub_class)			\
> +	__field(u16, hdr_ld_id)					\
> +	__field(u8, hdr_head_id)
>  
>  #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
>  	__assign_str(memdev);				\
> @@ -260,18 +266,22 @@ TRACE_EVENT(cxl_overflow,
>  	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
>  	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
>  	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
> -	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class
> +	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class;		\
> +	__entry->hdr_ld_id = le16_to_cpu((hdr).ld_id);				\
> +	__entry->hdr_head_id = (hdr).head_id
>  
>  #define CXL_EVT_TP_printk(fmt, ...) \
>  	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
>  		"len=%d flags='%s' handle=%x related_handle=%x "		\
> -		"maint_op_class=%u maint_op_sub_class=%u : " fmt,		\
> +		"maint_op_class=%u maint_op_sub_class=%u ld_id=%x "		\
> +		"head_id=%x : " fmt,						\
>  		__get_str(memdev), __get_str(host), __entry->serial,		\
>  		cxl_event_log_type_str(__entry->log),				\
>  		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
>  		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
>  		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
> -		__entry->hdr_maint_op_sub_class,	\
> +		__entry->hdr_maint_op_sub_class, __entry->hdr_ld_id,		\
> +		__entry->hdr_head_id,						\
>  		##__VA_ARGS__)
>  
>  TRACE_EVENT(cxl_generic_event,
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index f9ae1796da85..f4cb8568566b 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -19,7 +19,9 @@ struct cxl_event_record_hdr {
>  	__le64 timestamp;
>  	u8 maint_op_class;
>  	u8 maint_op_sub_class;
> -	u8 reserved[14];
> +	__le16 ld_id;
> +	u8 head_id;
> +	u8 reserved[11];
>  } __packed;
>  
>  struct cxl_event_media_hdr {

