Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D92ED86D
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702839; cv=none; b=t7X6XOtFnwMBmVtaStLoiE2BuejVxhr76p2QtnnrLOv+g1YA4D2KM9Eik9wKLdZ5uJs1IvuuamAn2V0od2jkH+RlZown1Q0fZZyYrWAZ4iiWM9f0C8GmSN/AxKBn0OLuTZ3Hhut1EoHHD/JGLdjPNsvR9/0XumMcTy+GPwMl6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702839; c=relaxed/simple;
	bh=EQ3gnclWK+tP4XSWjOzBhm+kBw0fldnlrch1fLA6x5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qom34TiB1dn4Ck8Gt3epSXML6+sTVnJM73gzeNKQtp1d1IqBUUMk0i0VylMVLHgp2n9LAyWF8LX9Od1sC6UYILBItCM1JfEnf/vkdpKF9PzRg1L4lbqKLP2Fv3Ob6NalBC8tIUrhlcIGkhWqxyjC/Rehhl+4Y1DGkOkmziVCyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJYdUKyQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJYdUKyQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752702838; x=1784238838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EQ3gnclWK+tP4XSWjOzBhm+kBw0fldnlrch1fLA6x5I=;
  b=EJYdUKyQeBDCkqLYlcWtkUVTkkLrmF01MypSeJI4exhl9JFMUwCjep6x
   TxbAJtx0UUyfkotR5mThNqGODRONWboDLPm7i98QfZNAy9DKse5v4U/AJ
   FtzNRrH2BYiPHjX77ggoCWoiYtunURdj2efNrPpWaZ1JsLm0eNamxfOjx
   Utrv50g0WWYlduW0L9raAEuPgiv8o/azCJ20hyz+HVLx3ccmigNpKyMw7
   6bILcK5EMuUIUt/H/bD6jgIe6u0EGfobsRy+44pJYhuhon3FFVXZabPH7
   Puvg2Y1QgEpk699hIHz52325xfUg1I3uiWNUbqvxic0qIA4RdAxO0wvk2
   Q==;
X-CSE-ConnectionGUID: r7XknB8xQsGNlD7h1thppA==
X-CSE-MsgGUID: s1zRzHd7R+GUlpnCZRYe1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54937943"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54937943"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 14:53:57 -0700
X-CSE-ConnectionGUID: kLDdnj7BQAWUhA6ODZDSUQ==
X-CSE-MsgGUID: 3/KEvgKOR6aYz3fUXJ2OQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157970997"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.193]) ([10.125.111.193])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 14:53:56 -0700
Message-ID: <2cb1666d-2ebd-4630-924f-bd945a120cf7@intel.com>
Date: Wed, 16 Jul 2025 14:53:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cxl/events: Add extra validity checks for CVME count
 in DRAM Event Record
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, dave@stgolabs.net, vishal.l.verma@intel.com,
 ira.weiny@intel.com
Cc: tanxiaofei@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com
References: <20250716104945.2002-1-shiju.jose@huawei.com>
 <20250716104945.2002-4-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250716104945.2002-4-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/25 3:49 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> According to the CXL Specification Revision 3.2, Section 8.2.10.2.1.2,
> Table 8-58 (DRAM Event Record), the CVME (Corrected Volatile Memory Error)
> Count field is valid under the following conditions:
> 1. The Threshold Event bit is set in the Memory Event Descriptor field,
> and
> 2. The CVME Count must be greater than 0 for events where the Advanced
> Programmable Threshold Counter has expired.
> 
> Additionally, if the Advanced Programmable Corrected Memory Error Counter
> Expire bit in the Memory Event Type field is set, then the Threshold Event
> bit in the Memory Event Descriptor field shall also be set.
> 
> Add validity checks for the above conditions while reporting the event to
> the userspace.
> 
> Note: CXL spec rev3.2 Table 8-58. DRAM Event Record, (Field: CVME Count
> at Event), "For events in which the advanced programmable threshold
> counter has expired, this field value shall be a value greater than 0.
> Counter expiration events in which the corrected memory error count
> is 0 shall not generate a media event record".
> Q: Should kernel drop the event record in this case or user space
> to handle?
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

The Q should be after '---' or dropped from commit log.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c  | 9 +++++++++
>  drivers/cxl/core/trace.h | 4 ++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 5a30d3891b17..e8c49ae28828 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -941,6 +941,15 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			if (cxl_store_rec_dram((struct cxl_memdev *)cxlmd, evt))
>  				dev_dbg(&cxlmd->dev, "CXL store rec_dram failed\n");
>  
> +			if (evt->dram.media_hdr.descriptor &
> +			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
> +				WARN_ON_ONCE((evt->dram.media_hdr.type &
> +					      CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
> +					     !evt->dram.cvme_count);
> +			else
> +				WARN_ON_ONCE(evt->dram.media_hdr.type &
> +					     CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
> +
>  			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
>  				       &evt->dram);
>  		}
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index c38f94ca0ca1..c3cd871942c5 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -662,6 +662,10 @@ TRACE_EVENT(cxl_dram,
>  		__entry->sub_channel = rec->sub_channel;
>  		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
>  		__entry->cvme_count = get_unaligned_le24(rec->cvme_count);
> +		if (rec->media_hdr.descriptor & CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
> +			__entry->cvme_count = get_unaligned_le24(rec->cvme_count);
> +		else
> +			__entry->cvme_count = 0;
>  	),
>  
>  	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' sub_type='%s' " \

