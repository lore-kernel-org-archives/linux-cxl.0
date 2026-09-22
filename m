Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B422560ADD
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098146; cv=none; b=TGrbxGOZV3GAeSMF8EMRnQ53zFwpanjb80txrAdOH0O+P+qYhv8HaPHVJ5TI9PDtcOdSZJ2g54D+aSKFb5KSMG4qYH7wmZW7jgj8pXphL3p9L1ouRfiIM3/E58mrkRFE7AClDt51icGbFJLGfK9VuSxptFUEBYOEgwb3N5vtEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098146; c=relaxed/simple;
	bh=Hypwxct+j3Ot7qW9oW8IuXUEy77WfENLBR9rwZ7wRBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBagPzu/TTfMisTyMp8fi4/4Kvqt5SbM+vwA1HGO8gojTJzqOnbgU++iJP1aGmp9MZp5aXR94jKGL5qdWz1Vfx9KXT77+8oVLaLJxKY8BMIvzRxSXkKVeppSnrXOLOpa7IUM09F4gf/lVNL3Y10uc2VYu05LHXXR2jO/2mZJm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVSkfGTe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVSkfGTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790098143; x=1821634143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hypwxct+j3Ot7qW9oW8IuXUEy77WfENLBR9rwZ7wRBA=;
  b=AVSkfGTewfanerAbCY3+xu4yYB5rBeRIrr6NZ/tbzcIV7EuzjBijty8s
   wYrNwYsTo9DmhDxyHlAzbydB7QHckl1bZXv89/GMHiNqDHMoRldNXMgHZ
   f24flSbpUbZYhZ1IzaxW01sWYDL+n4+uAtUQe6W30WC9WDxykFufkYCN3
   d5ooD46JPQoOHOlffZhsESgghKpiMB+iTbIY2LVxcykaZff0DxRktrYZk
   TOXPWkbdb+fvCjhHMA2D4bleNotfKWqjWGFsNsYtooGIOilZCgDL38fqy
   nzohiqS+xQafx6hrYP0G0WIDsFmWJBIyXvKijdUMuMBUxGiqIM6lL6nVT
   g==;
X-CSE-ConnectionGUID: QwTzhq70SkeWjESvp5clmw==
X-CSE-MsgGUID: zzM5j4IqTNy2zj/niJig7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89642791"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="89642791"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 10:29:02 -0700
X-CSE-ConnectionGUID: 57va9qvxRRqn3LaZZ2fhcw==
X-CSE-MsgGUID: 1hkhuLK3ToSGQUrXukZ9WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="301129116"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.110.50]) ([10.125.110.50])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 10:29:01 -0700
Message-ID: <8908efc5-8add-4dcc-9df6-c4de9cf6de2b@intel.com>
Date: Tue, 22 Sep 2026 10:29:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/events: Test CME counter expiry with equality, not
 bitwise AND
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260922082214.3526355-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260922082214.3526355-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 1:22 AM, Guixin Liu wrote:
> The Memory Event Type field in the General Media and DRAM event records
> is an enumeration, not a bitmask. The validity checks for the advanced
> programmable CME counter expiration event (05h) test the field with a
> bitwise AND, so types 01h, 03h, 04h and 06h match it as well.
> 
> A device reporting one of those types trips WARN_ON_ONCE once the
> general media or DRAM tracepoint is enabled, which is the case anywhere
> rasdaemon collects CXL events. Under panic_on_warn=1 that kills the
> machine.
> 
> Compare the type field for equality instead. Type 05h records that do
> violate the spec conditions still warn.
> 
> Fixes: cd3b36cfc659 ("cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record")
> Fixes: d8145bb8af5c ("cxl/events: Add extra validity checks for CVME count in DRAM Event Record")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Found by code inspection during review of a downstream backport of
> these two patches. Reproduced in a QEMU CXL topology by injecting
> General Media events through the cxl-inject-general-media-event QMP
> command: a type 01h event warns in cxl_event_trace_record() without
> the fix and is traced without a warning with it; type 05h events that
> violate the spec conditions still warn.
> 
> Changes since v1 [1]:
> - Collect the commit log suggested by Dave Jiang and the subject
>   suggested by Alison Schofield.
> - Move the reproducer explanation below '---' (Dave Jiang).
> - Add the 'Assisted-by: LLM' tag (Dave Jiang).
> 
> [1]: https://lore.kernel.org/all/20260921120932.1769566-1-kanie@linux.alibaba.com/
> 
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

