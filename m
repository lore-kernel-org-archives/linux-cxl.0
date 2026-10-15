Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B55427E3
	for <linux-cxl@vger.kernel.org>; Thu, 15 Oct 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077828; cv=none; b=aCensjq6Q+eMzTOxRVQ7nH9QG9f2M95UCBh+fcHW6npfXe2kbJ3fAbqNmqazQOahGsKd08EfjgRZ9GTDxbLXssdievm5eqmDblKr5xRJ+91iuM8uDSW37nmvjlVunqUcop/kDH385+eKlb+DeQdg1ernslnTuqh2Vh3ikt2InkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077828; c=relaxed/simple;
	bh=wHHrIya8ADH9XMxcvurUZ9pk8nZ1jLtJ8hOvDW9Bk8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwKMTciS3RlmF7CSqFR2mStQPqt0flBZaJfoznGFM1T8BvbuoDm3upe/SlbYlJbCQJ7oi+AqJFOg2JT/xke/jCh2SVBOSxagUKJ69hdD4BFo4100UAf7YYUrwNfAGck22D2vmWG6i7IPRp4O4Z+HXEjYASXmqyzh/w9JOAaqR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcXjdaOw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcXjdaOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792077817; x=1823613817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wHHrIya8ADH9XMxcvurUZ9pk8nZ1jLtJ8hOvDW9Bk8M=;
  b=BcXjdaOwHoj6eqyWDEUFWBREuPqCWd10KNnsID3pFPEk1rPrRAoFzYhL
   z0sAE1rSJReHYzm+kOURifRaP/SrOx2X3fzkRnk1aSvzQyBYEk/VyM7NY
   bpadY96JLN8h/DK/CeMxWQqYuGlBau0WOm6aZeWgb9KZCPr6PFrL9xjpm
   vHo1l0+eJys29mwKAgtc3wqp0xbOgmB3izarGaeJAxHex0EvHSnkd4qPg
   5aQL05GzYhrOf9tai0IAh4O3MCZACg02wAmdOs4gY6Ws+0E39ih7B34OD
   Ye2i9qcSmJqCXudcw9qTgVChkyKfNt10aKzxlJTdVrVwbbgF9ZpYdGDPn
   g==;
X-CSE-ConnectionGUID: LOlTLZJsTzauXzRauFqb3g==
X-CSE-MsgGUID: A86SWeEDTIikSU89GT/b9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="837021"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="837021"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:23:35 -0700
X-CSE-ConnectionGUID: mLaYfPCWRF2IALtnHdaseg==
X-CSE-MsgGUID: GKvHu2JzRlCsqkXPwdLvDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1649715"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.113]) ([10.125.110.113])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:23:34 -0700
Message-ID: <0d870742-8da1-40eb-b661-bdcb26e5a03d@intel.com>
Date: Thu, 15 Oct 2026 08:23:34 -0700
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

Applied to cxl/next
b94ba9a1f2d5

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

