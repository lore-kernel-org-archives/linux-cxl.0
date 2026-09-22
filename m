Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66B282F26
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065406; cv=none; b=fi4PrNq1/Cy78MegWUZs4QqmXrIWfkhynlxlhfyOzd4zvc9NYW9eUHPaFBcbmDXtuMs5/SPDaKN4+2Rbt5oXFCMg/xynbyO2ce5ghCH7rnGGETZgvcOSlmHXfR8SliFaSOcNXIlbDf56avNwjfrGpeCg8anL2E2zwzDHxrEm4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065406; c=relaxed/simple;
	bh=LHIr9jOKiq8nKGeMraI9+hbJ5gcFy7EJ12GX2rLmgTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=md+Q0QQwIpfWJ71JGpFX8t62giSs0NcDwKf9qeUE670suawAeQ2QxK9GFn06faWTzqYStX0NzFw+yBx+M0BlQ3zEb4qf9C54XDXjfG9TbnV1KQKb7KJaYyOJamDb4o9bO907yr6uFbPYfsciglphOXuXt55VuNSXR0rPUquXvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JH/ZeozW; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JH/ZeozW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790065396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JxGLTUP+HvxmYnF8Mn9/0tlwLU+aSVSBPXG0lg3iNdE=;
	b=JH/ZeozW3V43ZiycoClo8VZQSW0jlWNgZaJH/seMsZ3Eyl9lWdrP6LbbYMRlJZdxM3CaZlc+bntY1JwKE4aC+jeVE2U/QXpS+UNLlyPrhLOBDAbLTKbfwd5uc4EYZrKG34s0GP/Zi3FAKolGy8n4s76CLmRmjOp2Nteu1L9UK5E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBTA.Wj_1790065394;
Received: from 30.178.81.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBTA.Wj_1790065394 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 16:23:15 +0800
Message-ID: <86ed8379-7e00-4766-8cd2-cbd5bbf00c37@linux.alibaba.com>
Date: Tue, 22 Sep 2026 16:23:14 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/events: Fix event type check for CME counter
 expiration
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260921120932.1769566-1-kanie@linux.alibaba.com>
 <c9508310-acc0-402b-bfc2-8791744a3653@intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <c9508310-acc0-402b-bfc2-8791744a3653@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/22 00:54, Dave Jiang 写道:
>
> On 9/21/26 5:09 AM, Guixin Liu wrote:
>> The Memory Event Type field of the General Media and DRAM event
>> records is an enumeration; 05h designates the advanced programmable
>> CME counter expiration event. The validity checks for that event
>> test the field with a bitwise AND against
>> CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE instead of comparing it
>> for equality, so benign event types that share a bit with 05h, such
>> as 01h (Invalid Address), 03h (TE State Violation), 04h (Scrub
>> Media ECC Error) or 06h (CKID Violation), match too.
>>
>> A device reporting any of those types with an otherwise valid record
>> therefore trips WARN_ON_ONCE, once the general media or DRAM
>> tracepoint is enabled, which is the case for any deployment
>> collecting CXL events with rasdaemon. The warning panics the kernel
>> under panic_on_warn=1.
>>
>> Compare the type field for equality instead.
>>
>> Found by code inspection during review of a downstream backport of
>> these two patches. Reproduced in a QEMU CXL topology by injecting a
>> General Media event with type 01h through the
>> cxl-inject-general-media-event QMP command, which warns in
>> cxl_event_trace_record(); with the fix the same injection is traced
>> without a warning. Events that do violate the spec conditions, type
>> 05h without the threshold event descriptor bit and type 05h with the
>> bit set but a zero CME count, still warn.
> Please consider using the following simplified commit log:
>
>     The Memory Event Type field in the General Media and DRAM event records
>     is an enumeration, not a bitmask. The validity checks for the advanced
>     programmable CME counter expiration event (05h) test the field with a
>     bitwise AND, so types 01h, 03h, 04h and 06h match it as well.
>
>     A device reporting one of those types trips WARN_ON_ONCE once the
>     general media or DRAM tracepoint is enabled, which is the case anywhere
>     rasdaemon collects CXL events. Under panic_on_warn=1 that kills the
>     machine.
>
>     Compare the type field for equality instead. Type 05h records that do
>     violate the spec conditions still warn.
>
> Move the explanation on reproducer under '---'.
>
OK, changed in v2, thanks.

Best Regards,
Guixin Liu
> Otherwise LGTM
>
> DJ
>
>> Fixes: cd3b36cfc659 ("cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record")
>> Fixes: d8145bb8af5c ("cxl/events: Add extra validity checks for CVME count in DRAM Event Record")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>  drivers/cxl/core/mbox.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 55828a836c01..01341f524a93 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -942,11 +942,11 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>>  
>>  			if (evt->gen_media.media_hdr.descriptor &
>>  			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
>> -				WARN_ON_ONCE((evt->gen_media.media_hdr.type &
>> +				WARN_ON_ONCE((evt->gen_media.media_hdr.type ==
>>  					      CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
>>  					     !get_unaligned_le24(evt->gen_media.cme_count));
>>  			else
>> -				WARN_ON_ONCE(evt->gen_media.media_hdr.type &
>> +				WARN_ON_ONCE(evt->gen_media.media_hdr.type ==
>>  					     CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
>>  
>>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>> @@ -957,11 +957,11 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>>  
>>  			if (evt->dram.media_hdr.descriptor &
>>  			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
>> -				WARN_ON_ONCE((evt->dram.media_hdr.type &
>> +				WARN_ON_ONCE((evt->dram.media_hdr.type ==
>>  					      CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
>>  					     !get_unaligned_le24(evt->dram.cvme_count));
>>  			else
>> -				WARN_ON_ONCE(evt->dram.media_hdr.type &
>> +				WARN_ON_ONCE(evt->dram.media_hdr.type ==
>>  					     CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
>>  
>>  			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,

