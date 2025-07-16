Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298D2ECD1E
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702030; cv=none; b=UzITSWYbXhcKN7dBDAAR9rQ4CHZw5zLSoZJwgAKy5Bg7r3S91InqvA+Dp+o0esN3NGF2cD3eLXHqk5vzE3nvYCsS7OL8sGQ0qk3CcfGQ+lIjIwJbkGa4XwDn1bR785rhqEiLxNOEc7Yigrg47UofZ+y+yYFXGLqffw6Sack3+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702030; c=relaxed/simple;
	bh=qSChPQ6NuQRrhIF6Pp5peOhOO55cRVP0LxrAOSfitis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dD2pcTWd5+0CnvIBRFDhufxZZfQLVHFD9faKo5LmsoxCOYRBQBmUxnFuRQDVhQEdO9KiKAlGJ+OJRatbQAIpCIBEH5lwGasWsLlshDyTuY/QFie4BZkeOcgWIdX236EVnAvwZ9MACg55VvDMOsIOb7UhgCtH6Dxwi5ywlEQLjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOdEHGW/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOdEHGW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752702029; x=1784238029;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qSChPQ6NuQRrhIF6Pp5peOhOO55cRVP0LxrAOSfitis=;
  b=TOdEHGW/76z0/9BrHB412oROFInQThaP477bfCMCH7CJLwnQR3fr87X7
   hVsdo+zcIVREbsV+j45P/s/op4WNkk3ovIjNnx16tg6nyxM2KQDgeQI5p
   Tfm9+uLT3wokg7q1eF9SpjqAm4ESbgLbJozDWUw6+2k4OuW0csijXT4QE
   PQ4n0LBxlpnhDL4bTsw90BS/tVtet/7KGcHXo/d2ob50rTho43am9vdkW
   CfO8Yy2xrX1N+/kDEbFIBYQ7cg8MCp2tEU6GP7ohOCZY8SsmNcKuqexE5
   +pFw7aCrkaA+moAZzJV4IQsM8NF9aycCI1r/d4MXGlFvxDGw+MLTiVYIU
   A==;
X-CSE-ConnectionGUID: vQhQnW8KRq+qzpjjF7QaJw==
X-CSE-MsgGUID: UkVrOM9PQOG6v7IMVPePRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65222137"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="65222137"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 14:40:28 -0700
X-CSE-ConnectionGUID: zsIeWf41QXie/AsYxRHzKw==
X-CSE-MsgGUID: Qj+6vcvOTRy4WakKOi8UNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="161929426"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.193]) ([10.125.111.193])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 14:40:28 -0700
Message-ID: <94f2fdd8-56d4-45c8-8ed3-5c23522425b7@intel.com>
Date: Wed, 16 Jul 2025 14:40:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cxl/events: Add extra validity checks for corrected
 memory error count in General Media Event Record
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, dave@stgolabs.net, vishal.l.verma@intel.com,
 ira.weiny@intel.com
Cc: tanxiaofei@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com
References: <20250716104945.2002-1-shiju.jose@huawei.com>
 <20250716104945.2002-3-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250716104945.2002-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/25 3:49 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> According to the CXL Specification Revision 3.2, Section 8.2.10.2.1.1,
> Table 8-57 (General Media Event Record), the Corrected Memory Error Count
> field is valid under the following conditions:
> 1. The Threshold Event bit is set in the Memory Event Descriptor field, and
> 2. The Corrected Memory Error Count must be greater than 0 for events where
>    the Advanced Programmable Threshold Counter has expired.
> 
> Additionally, if the Advanced Programmable Corrected Memory Error Counter
> Expire bit in the Memory Event Type field is set, then the Threshold Event
> bit in the Memory Event Descriptor field shall also be set.
> 
> Add validity checks for the above conditions while reporting the event to
> the userspace.
> 
> Note: CXL spec rev3.2 Table 8-57. General Media Event Record
> Field: Corrected Memory Error Count at Event) "For events in which the
> advanced programmable threshold counter has expired, this field value
> shall be a value greater than 0. Counter expiration events in which
> the corrected memory error count is 0 shall not generate a media event
> record".
> Q: Should kernel drop the event record in this case or user space
> to handle?
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

As Jonathan mentioned, the Q doesn't belong in the commit log.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c  | 9 +++++++++
>  drivers/cxl/core/trace.h | 5 ++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2689e6453c5a..5a30d3891b17 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -926,6 +926,15 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
>  				dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
>  
> +			if (evt->gen_media.media_hdr.descriptor &
> +			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
> +				WARN_ON_ONCE((evt->gen_media.media_hdr.type &
> +					      CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
> +					     !evt->gen_media.cme_count);
> +			else
> +				WARN_ON_ONCE(evt->gen_media.media_hdr.type &
> +					     CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
> +
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>  						hpa_alias, &evt->gen_media);
>  		} else if (event_type == CXL_CPER_EVENT_DRAM) {
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a77487a257b3..c38f94ca0ca1 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -506,7 +506,10 @@ TRACE_EVENT(cxl_general_media,
>  			uuid_copy(&__entry->region_uuid, &uuid_null);
>  		}
>  		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
> -		__entry->cme_count = get_unaligned_le24(rec->cme_count);
> +		if (rec->media_hdr.descriptor & CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
> +			__entry->cme_count = get_unaligned_le24(rec->cme_count);
> +		else
> +			__entry->cme_count = 0;
>  	),
>  
>  	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \

