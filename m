Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96325B0B6
	for <linux-cxl@vger.kernel.org>; Thu, 15 Oct 2026 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067895; cv=none; b=bC9CuiEZrqTWqj4kNKVoO1a7A2y1sGhovgb1HTvc5+pjrwIySIiK4fFdWe3LdvMPDa2gw1dfudUP48HDESL6dz9MICyt7TrxJKzBONRQneNSsJSRST4E/tJH4ElJVz5FhuP56Nv7YFMtnO88JTJyUsdxjgTXLymnTexiomAk888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067895; c=relaxed/simple;
	bh=FIRP5mnHuUvjLxr3p20DXVmosUadYGbjU1v9EE52j0M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P/m4kvFc4qSpCwpuiiTP76kku2Okhpk6kyP+tpvXtezoOsSHGCtSey7xeAiwezrm2euOPYITg5vHAarl1TD4Q9kRcjmN3T7VJBXNoordsrr+z0u8XF1kDxinoCy5NQ5Mwt3VjdWqAtjsR1HS3TdCUpuirBYhFHkB8L0VU+fLtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TPKqquSb; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TPKqquSb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792067888; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=MoRyDBYF+XGjnhsImnOoRdQDhqdWLlcF0SszBPtf53w=;
	b=TPKqquSbOL2XYYGAs/FjuoPrHhQSP8xTS/T4jQpMTNf0vD1VsGaAjSFUDROx0IzGN1rVAe9WRxiyrPi/oRyxDxCOu/nYnfawxeCBOUYr6cMfMrHy5eXpi1kx8lF5vkCq/MBLtw3FNJyNdqf1L9NxopNIE5ruhBkufKXuXxB7XPU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCriC-E_1792067886;
Received: from 30.178.84.15(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCriC-E_1792067886 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 20:38:07 +0800
Message-ID: <ee74d7b7-8433-46d6-8f99-50ebbd71a6aa@linux.alibaba.com>
Date: Thu, 15 Oct 2026 20:38:06 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/events: Test CME counter expiry with equality, not
 bitwise AND
From: Guixin Liu <kanie@linux.alibaba.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>, Dan Williams
 <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
References: <20260922082214.3526355-1-kanie@linux.alibaba.com>
In-Reply-To: <20260922082214.3526355-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dave,

It looks like this patch hasn't made it into cxl/next yet — could you please pick it up?

Best Regards,
Guixin Liu


在 2026/9/22 16:22, Guixin Liu 写道:
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

