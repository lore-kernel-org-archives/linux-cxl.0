Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163318FDDB
	for <linux-cxl@vger.kernel.org>; Wed, 10 Dec 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378044; cv=none; b=WjroZlmrczNDlORfWh5SsL8zFx9FbzHFbNB7tKym6KCFUgB1JHGgYK3owUjvkB3ce4x3qhe9BA4KGIqQx9Dlqqtiyv6Vi+0xNRb0I+LF4UUrd/i4ZfLL10UXiSwpIKS+8UcVAcbVEn6VkiSFNU9er6WgI+/o97jkbQjj33SDP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378044; c=relaxed/simple;
	bh=RHkAKYL4SrHUDCtNxSfw7MYpWnciFVN62Yb63AVwetI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntXxCb5DveF7NuW01pkuBTy32DGokmRx1rBhN7nwSmcJpYxVspPJq7W8QHiqSXBwCWc+vys4TXKX+oQhqIrYyfhgip0xmFC1OuKaC4EJ/ev0TObcJj8yvdxX3QKYvtXhBXMbeXi/BF6WymLAuSf1O73FVAD3pnJuRIFXGk+fOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQTgo5QE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQTgo5QE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765378042; x=1796914042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RHkAKYL4SrHUDCtNxSfw7MYpWnciFVN62Yb63AVwetI=;
  b=UQTgo5QE6GtKGQMb30hnA+kpGVbG74tHi/yM7KQrz7w2lwrFWozjbFOr
   3WdAbzVApL7Tg0T149LEWctHzM8YGHchBYjOtmI5xi1vYfKlXPahXnyXi
   Bf/HGxIH3CsI5lU/Lki5KtScv12GjYYcsTt8/VX7QHdIvLQcsG6i/ZUwk
   Q0AKHnMNDOXNXgJzaIikZXZ7f8bArT1Bh9mmvQkpfPhBSjo4gfkW7i6xm
   sJrPwIKe5nfrCjQaaDEjpAprfntw6uT3yJNPNenB/qbgl8iU069C/0FRu
   Ij+wgCQ3+flRTCV8w1vT30atIsgCzjh+J3vdsvg8B79P7YAca1geqkQSf
   Q==;
X-CSE-ConnectionGUID: 45PvshYIQo+iWR3AIjHVgw==
X-CSE-MsgGUID: IRky/JRORsW8rQIPuXUBJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="77966422"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="77966422"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 06:47:22 -0800
X-CSE-ConnectionGUID: SqJz4ROPRiyESP96xqk+sQ==
X-CSE-MsgGUID: 4UPzuURmSNW9E56xXu5u6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="201447043"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 06:47:21 -0800
Message-ID: <a98e51a3-7939-4fca-9983-413d250f178a@intel.com>
Date: Wed, 10 Dec 2025 07:47:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/events: Update memory event type for patrol scrub
 cycle end event
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, dave@stgolabs.net, vishal.l.verma@intel.com,
 ira.weiny@intel.com
Cc: tanxiaofei@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com
References: <20251210131235.1731-1-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251210131235.1731-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/10/25 6:12 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> According to the CXL Specification Revision 4.0, Advanced CVME (Corrected
> Volatile Memory Error) enhancements added additional granularity control
> and event generation for Patrol Scrub cycle end.
> 
> Update Memory Event Type field in the trace events for section
> 8.2.10.2.1.1, Table 8-224 (General Media Event Record), and section
> 8.2.10.2.1.2, Table 8-225 (DRAM Event Record), to include the event type
> 'Patrol Scrub cycle end'.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Open Question,
> Option to enable event generation for 'Patrol Scrub cycle end' is given in
> the Memory Error Threshold feature, Section 8.2.10.9.11.3 Advanced
> Programmable Corrected  Volatile Memory Error Threshold Feature Discovery
> and Configuration. Does support of this Memory Error Threshold feature is
> required in the kernel or via fwctl?

Any thoughts Jonathan? Is that something that would be exposed through EDAC?

DJ

> ---
>  drivers/cxl/core/trace.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a972e4ef1936..e79c2bd415af 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -367,6 +367,7 @@ TRACE_EVENT(cxl_generic_event,
>  #define CXL_GMER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x04
>  #define CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE	0x05
>  #define CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION		0x06
> +#define CXL_GMER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END	0x07
>  #define show_gmer_mem_event_type(type)	__print_symbolic(type,				\
>  	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },			\
>  	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },		\
> @@ -374,7 +375,8 @@ TRACE_EVENT(cxl_generic_event,
>  	{ CXL_GMER_MEM_EVT_TYPE_TE_STATE_VIOLATION,	"TE State Violation" },		\
>  	{ CXL_GMER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },	\
>  	{ CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE,	"Adv Prog CME Counter Expiration" },	\
> -	{ CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" }		\
> +	{ CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" },		\
> +	{ CXL_GMER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END,	"Adv Prog CME Patrol Scrub Cycle End" }	\
>  )
>  
>  #define CXL_GMER_TRANS_UNKNOWN				0x00
> @@ -554,6 +556,7 @@ TRACE_EVENT(cxl_general_media,
>  #define CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION	0x04
>  #define CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE	0x05
>  #define CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION		0x06
> +#define CXL_DER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END	0x07
>  #define show_dram_mem_event_type(type)	__print_symbolic(type,					\
>  	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },				\
>  	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },		\
> @@ -561,7 +564,8 @@ TRACE_EVENT(cxl_general_media,
>  	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" },			\
>  	{ CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION,	"TE State Violation" },			\
>  	{ CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE,	"Adv Prog CME Counter Expiration" },	\
> -	{ CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" }			\
> +	{ CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" },			\
> +	{ CXL_DER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END,	"Adv Prog CME Patrol Scrub Cycle End" }	\
>  )
>  
>  #define CXL_DER_VALID_CHANNEL				BIT(0)

