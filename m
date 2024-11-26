Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD771DACBF;
	Tue, 26 Nov 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642033; cv=none; b=Fnh6UEm6jxZ8mVWBjFiEPCxOfp4WuC9EokyC+RIzei/2YDeMtVlmJ7vklgvzVL2cjqA9iwsi7vw1pto350R2H9POC2npHdZpzrfNWut4sPam0RaXj/UrM3SiuV1SiGSdssR7LSQjanrpyiHRSXeb/br0tJasrDIdqnMwOEG3nKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642033; c=relaxed/simple;
	bh=15Ie3c0nMKk7FwI6ERY8A7cw9NxduQnjCWk/i7XFKAA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFyIGrGDis6hMEUfrYCPeH2u4JnoQBbkHnVNeY9YuPt/hdDke/4vGwF1EMICSJXBXuyiPHSEOhNlk9rshJZm41J8yXzpEuoH2JkAxifFtCwdyFD5bqtzgc6CcPJv5x9PEF3ngYcdbSow5hdpm8H8zqwBcbMxctFHeJkSJwIHkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm6RLIjI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm6RLIjI"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f71f2b136eso4750416a12.1;
        Tue, 26 Nov 2024 09:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732642032; x=1733246832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NatBUjdFy+3pOZ5W0mNTPAtwCcyaMloJIAxq7lkMslY=;
        b=Fm6RLIjI9gkfTRwmfde8BYH/ar2JgDD1lThT6GMHUnvqPllOIK4qdIMBLF8Md6AjV3
         GBVbOnGOmKDFHDBVuz0GFCc1+TCcD0LLwYhyIrfXIq4dhTl3oZmX/7jQeTXTAbuuRdhZ
         gbmWkU/tN/LNgG7B/i8yGdof1jDMX+IpK71lyOnSmf+p5I6++Y9kxnF2TWurqhjg1h5/
         7YolB1dlD38vVdswbOE2WneK3mfU6Vg8AVUhxP/ErgkgYga30VowtQ/Ox7iBeqe8R8UW
         FBSXCzUlXgOImeQIneNShLidD8x1bGlgxtuf5xIFLzJZ4Jo4vBYRZNu9guWSBB6avSwd
         NiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732642032; x=1733246832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NatBUjdFy+3pOZ5W0mNTPAtwCcyaMloJIAxq7lkMslY=;
        b=rRd7DVTMkdV7xrOWs9WNDjk3N1bUhFnBh18YD9XwY4MjkcdX8bFqbL6ZxPs3hJ3YDm
         xIuP8GThk2+0ScSglQ1OxxwT6c4l9DTQ+ze4PHVXkEm9spSueJ/huS9XR4oCkI1/Jt03
         APr4A/AS744gxi95UPThtWM5kQzQWhUVTYl9dfV51aRCVOxdUMoB17GMy0MLaQNMGpvJ
         APZ+DDakYBzMPKeU+7dkUfzjuIiuBPDBX3U2xbFKRA5sFYQA71rqbMdv4ihAm9P2egTr
         E8cXGI303CfPt4iTuAMRj4xy6w+BJeJ+yVcNvqxNAELtyrm4qtid93oY7w/ECn4xsJzB
         8/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWl10Bryk3QxtTB8EjASSc6VxM7yU+t0C8bsZx6mU6vCe1q4ud/ttXOmHUtkeknS/9lsBAyVKf4gX0=@vger.kernel.org, AJvYcCX68BllZrhgO+QDcQlOM087U4yq/yUBOfTxPI+2jpy+QFGOfpHsg5PLdc9Vo0m5UXBv/ZHdjBAV+vyMQjC5@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAsDSZSrsB32eiwRZmUuu7JeUuPu6jnaVv9ikE7jBmDFXemHE
	aFIDDuIiUqz7Ad8aPgWAF5rLxwAhUMnCenBAvn3BmrMEcbXCRrIc
X-Gm-Gg: ASbGncvb/113dlokmBdNnB020GUXRhwblpaBfpFoQ6m+JaVGftLbRGeOk6xJlx1C32P
	B2GHjRjx7MOpTXdzUuyUy3W2bz7AgelHfzc4Wd0oUfnk4gTNrku2WfRV7sFjj+Buv2pmbjciwNX
	sRHR9C0dw+1KiMlXttRYGJQQk0XBOJA0ZYdVOfPXAu28A20PIfRYxg7GbA19Jj3I2XvR0Uz3Ooi
	DOyhyRvu39N+LG/T/Wlra2OBVjEhzf3V59YZrc7tVTeTiIIZKIt6A==
X-Google-Smtp-Source: AGHT+IE4F39SUwpnVdVJgUqEIrLanQrTvy1ank0oKkqfYwUXI4hYQTFsAczXPZZshnMFcsaaEP9RtQ==
X-Received: by 2002:a05:6a21:33a9:b0:1e0:c0fa:e088 with SMTP id adf61e73a8af0-1e0e0b4e91bmr325771637.18.1732642031498;
        Tue, 26 Nov 2024 09:27:11 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3fb290sm8977528a12.74.2024.11.26.09.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:27:10 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 26 Nov 2024 17:27:08 +0000
To: shiju.jose@huawei.com
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	nifan.cxl@gmail.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [PATCH v4 1/6] cxl/events: Update Common Event Record to CXL
 spec rev 3.1
Message-ID: <Z0YE7C5NkyydjiRR@smc-140338-bm01>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
 <20241120093745.1847-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120093745.1847-2-shiju.jose@huawei.com>

On Wed, Nov 20, 2024 at 09:37:40AM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.2.1 Table 8-42, Common Event Record format has
> updated with Maintenance Operation Subclass information.
The table reference is incorrect, should be Table 8-43 based on spec r3.1,
v1.0, Auguest 7, 2023.

Other than that,


Reviewed-by: Fan Ni <fan.ni@samsung.com>

> 
> Add updates for the above spec change in the CXL events record and CXL
> common trace event implementations.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/trace.h | 13 +++++++++----
>  include/cxl/event.h      |  3 ++-
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 8389a94adb1a..7305974e2301 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -166,11 +166,13 @@ TRACE_EVENT(cxl_overflow,
>  #define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
>  #define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
>  #define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
> +#define CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID	BIT(6)
>  #define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
>  	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
>  	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
>  	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
> -	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}  \
> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	},  \
> +	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,	"MAINT_OP_SUB_CLASS_VALID" }	\
>  )
>  
>  /*
> @@ -197,7 +199,8 @@ TRACE_EVENT(cxl_overflow,
>  	__field(u16, hdr_related_handle)			\
>  	__field(u64, hdr_timestamp)				\
>  	__field(u8, hdr_length)					\
> -	__field(u8, hdr_maint_op_class)
> +	__field(u8, hdr_maint_op_class)				\
> +	__field(u8, hdr_maint_op_sub_class)
>  
>  #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
>  	__assign_str(memdev);				\
> @@ -209,17 +212,19 @@ TRACE_EVENT(cxl_overflow,
>  	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
>  	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
>  	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> -	__entry->hdr_maint_op_class = (hdr).maint_op_class
> +	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
> +	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class
>  
>  #define CXL_EVT_TP_printk(fmt, ...) \
>  	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
>  		"len=%d flags='%s' handle=%x related_handle=%x "		\
> -		"maint_op_class=%u : " fmt,					\
> +		"maint_op_class=%u maint_op_sub_class=%u : " fmt,		\
>  		__get_str(memdev), __get_str(host), __entry->serial,		\
>  		cxl_event_log_type_str(__entry->log),				\
>  		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
>  		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
>  		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
> +		__entry->hdr_maint_op_sub_class,	\
>  		##__VA_ARGS__)
>  
>  TRACE_EVENT(cxl_generic_event,
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 0bea1afbd747..e1d485ad376b 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -18,7 +18,8 @@ struct cxl_event_record_hdr {
>  	__le16 related_handle;
>  	__le64 timestamp;
>  	u8 maint_op_class;
> -	u8 reserved[15];
> +	u8 maint_op_sub_class;
> +	u8 reserved[14];
>  } __packed;
>  
>  struct cxl_event_media_hdr {
> -- 
> 2.43.0
> 

-- 
Fan Ni (From gmail)
