Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802184E325C
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010074; cv=none; b=VtcInFocycjLa0TBvTMot6LE4m1A7BYibIsMfqC0JaULHD1LobK3VSGvdYCWc+Lhq/MY59TQrd5toi2rETAiGSSiAXYruskmp/qHjYXGY4Vep8y2xRc1FpD+dgfnTX1ESzN00x28n5MOMfWJHQoxFYULrZwfk8nmZOMcC179OA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010074; c=relaxed/simple;
	bh=Z6VguDCVUYLa2jc7fm92/oU/DSDoAe+cqH2eBSAFD8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRsF/MZIg22FAb7jLhB2rdUleTcrZ6fqxAcNYGXXnJca30UY+E5f+eh+POd4HS/1iKOxAHvAhBXqU7vKNQ8LYzC2qC3imPCTYR+pfyboaBdmGh5N294ScV7983AkMSkap41Xq++XUYkL/cfOr1FcR5OGfoGEd0YEACkoINEMOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmQocXrf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmQocXrf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790010072; x=1821546072;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z6VguDCVUYLa2jc7fm92/oU/DSDoAe+cqH2eBSAFD8A=;
  b=YmQocXrfNbDwZBehBmKfryBjZxQu7BqYsmklH5rXnMhNhrYH7JNHtKqS
   2o/dAdWgETxPi8jIBbenwSNF91dO3w0x3+B/hx/A4VsYAmvfddKz8P2lq
   1sjJuRqwZb8QzZ6RA5qOVLCIK4rDA1+VvliYj6/dVG90XIvep8Q7rDPLm
   3PJb4sdSRBk1hZs/f8Do61GFAKLKSabipx1egmnKpvsi28upK7AJh5N6A
   L2PJMTNnTXWwrHPakF7Or8R50xSiuR0lK8+9WCQ5rUPOnfkuWP1SFoQkx
   /VAMw5sgzEhgajldDx6DADlUKTqhnxI5PPXxIPqhecQuJE/eIAcauvuut
   Q==;
X-CSE-ConnectionGUID: AwgkGwl0Q9mWInUEbf/ZPg==
X-CSE-MsgGUID: YhpXC4deTra+CfGvKt1wUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="94371243"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="94371243"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 09:54:11 -0700
X-CSE-ConnectionGUID: JQ+TUxt4Sz+tQ//AvKzu7Q==
X-CSE-MsgGUID: h0Thut7nQreeH9TN/GMDlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="269261825"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.234]) ([10.125.109.234])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 09:54:10 -0700
Message-ID: <c9508310-acc0-402b-bfc2-8791744a3653@intel.com>
Date: Mon, 21 Sep 2026 09:54:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/events: Fix event type check for CME counter
 expiration
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260921120932.1769566-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260921120932.1769566-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/21/26 5:09 AM, Guixin Liu wrote:
> The Memory Event Type field of the General Media and DRAM event
> records is an enumeration; 05h designates the advanced programmable
> CME counter expiration event. The validity checks for that event
> test the field with a bitwise AND against
> CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE instead of comparing it
> for equality, so benign event types that share a bit with 05h, such
> as 01h (Invalid Address), 03h (TE State Violation), 04h (Scrub
> Media ECC Error) or 06h (CKID Violation), match too.
> 
> A device reporting any of those types with an otherwise valid record
> therefore trips WARN_ON_ONCE, once the general media or DRAM
> tracepoint is enabled, which is the case for any deployment
> collecting CXL events with rasdaemon. The warning panics the kernel
> under panic_on_warn=1.
> 
> Compare the type field for equality instead.
> 
> Found by code inspection during review of a downstream backport of
> these two patches. Reproduced in a QEMU CXL topology by injecting a
> General Media event with type 01h through the
> cxl-inject-general-media-event QMP command, which warns in
> cxl_event_trace_record(); with the fix the same injection is traced
> without a warning. Events that do violate the spec conditions, type
> 05h without the threshold event descriptor bit and type 05h with the
> bit set but a zero CME count, still warn.

Please consider using the following simplified commit log:

    The Memory Event Type field in the General Media and DRAM event records
    is an enumeration, not a bitmask. The validity checks for the advanced
    programmable CME counter expiration event (05h) test the field with a
    bitwise AND, so types 01h, 03h, 04h and 06h match it as well.

    A device reporting one of those types trips WARN_ON_ONCE once the
    general media or DRAM tracepoint is enabled, which is the case anywhere
    rasdaemon collects CXL events. Under panic_on_warn=1 that kills the
    machine.

    Compare the type field for equality instead. Type 05h records that do
    violate the spec conditions still warn.

Move the explanation on reproducer under '---'.

Otherwise LGTM

DJ

> 
> Fixes: cd3b36cfc659 ("cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record")
> Fixes: d8145bb8af5c ("cxl/events: Add extra validity checks for CVME count in DRAM Event Record")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/cxl/core/mbox.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836c01..01341f524a93 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -942,11 +942,11 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  
>  			if (evt->gen_media.media_hdr.descriptor &
>  			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
> -				WARN_ON_ONCE((evt->gen_media.media_hdr.type &
> +				WARN_ON_ONCE((evt->gen_media.media_hdr.type ==
>  					      CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
>  					     !get_unaligned_le24(evt->gen_media.cme_count));
>  			else
> -				WARN_ON_ONCE(evt->gen_media.media_hdr.type &
> +				WARN_ON_ONCE(evt->gen_media.media_hdr.type ==
>  					     CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
>  
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> @@ -957,11 +957,11 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  
>  			if (evt->dram.media_hdr.descriptor &
>  			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
> -				WARN_ON_ONCE((evt->dram.media_hdr.type &
> +				WARN_ON_ONCE((evt->dram.media_hdr.type ==
>  					      CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
>  					     !get_unaligned_le24(evt->dram.cvme_count));
>  			else
> -				WARN_ON_ONCE(evt->dram.media_hdr.type &
> +				WARN_ON_ONCE(evt->dram.media_hdr.type ==
>  					     CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
>  
>  			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,

