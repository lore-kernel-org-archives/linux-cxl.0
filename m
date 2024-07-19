Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB381A269
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jul 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405099; cv=none; b=Q4WMhzhpbsNrkxoW/Rdf0ctIGoHGNeOIpl7sHc7sJS3m+2waI4IWoo4HSxDYPw5oYkjAIXyh7KOOOdXssTyJpGSaTfj8kN5NEVljgpdAinF4WRuQvKsvqNE7+jdDeOsfSj7nScIKRDukiuxQ+AqC/K70voaJPS1vpGb9P3hFsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405099; c=relaxed/simple;
	bh=kYt4UDBdOF6BsVwzu2b5IEEajWkfjXkFEJSvTAgkhSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0F2LexQtc00XUH9M5mFWXIUjHrzqMeoVfWN+OidAImV0+WC34zr1BOosQHR1n1g8XcbmDHTmoOrunhY1//xUY8NaNYi7IuKrar+uPNgNZL7usQPLIaubi9G484igQeFYgzLNOsr1xshv6NfR3IwkQwvAHkxeo3F4HQQ3T+yul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3LlFKgR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3LlFKgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721405097; x=1752941097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kYt4UDBdOF6BsVwzu2b5IEEajWkfjXkFEJSvTAgkhSA=;
  b=C3LlFKgR9Ev7D70ElcXEFNjVftL6+Sp2e6U9S/qg4pf71aucssxVKEnf
   18S/cJx9vdUxRDi6q0FaWmhzUA8E0SK2ZPOUeQSm8NqM90EEYNxmD4yZA
   SfGHmSrVOiwhGL55/MDV2bCWvNphyk7KooGLHPiAUR/3Jevds6V5UEjES
   lxbP/5jLBnEVdzl68QuX8WOpURDipTjTMz7rQnDB0iRVzaF8tLQ1jBCDX
   dT8rXXhAe4DN1NDGbB1m1qmgYmuiLdOCpCE7c2seQ32SYRt4AM6yMA7QT
   cA8gLmvw075zYVAW6fDuavpRMQIgXxJEJLkHCuowPahqBPf+nE8A1SLTl
   A==;
X-CSE-ConnectionGUID: Fe+YRcMbTo+29y96zu8CWg==
X-CSE-MsgGUID: 76ZeqeZOQzWdI/OmPqPv6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="41548715"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="41548715"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 09:04:52 -0700
X-CSE-ConnectionGUID: 67IU+5wqQlK14ipapRYxvg==
X-CSE-MsgGUID: xaZ7BVu5TseJHcJomKBn4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="50896205"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.46]) ([10.125.109.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 09:04:51 -0700
Message-ID: <ec0f2e8d-e783-4211-8d41-2b9a6df67049@intel.com>
Date: Fri, 19 Jul 2024 09:04:50 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>,
 Dan Williams <dan.j.williams@intel.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <6675bd86ea005_57ac29411@dwillia2-xfh.jf.intel.com.notmuch>
 <965e2c27-6147-4237-b4b6-6aaf74363aa2@fujitsu.com>
 <1fab087b-eb6c-485e-a2ed-f86e8dfacc5d@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1fab087b-eb6c-485e-a2ed-f86e8dfacc5d@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/1/24 7:12 PM, Shiyang Ruan wrote:
> 
> 
> 在 2024/6/25 21:56, Shiyang Ruan 写道:
>>
>>
>> 在 2024/6/22 1:51, Dan Williams 写道:
>>> Shiyang Ruan wrote:
>>>> Background:
>>>> Since CXL device is a memory device, while CPU consumes a poison page of
>>>> CXL device, it always triggers a MCE by interrupt (INT18), no matter
>>>> which-First path is configured.  This is the first report.  Then
>>>> currently, in FW-First path, the poison event is transferred according
>>>> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES
>>>>   -> CPER -> trace report.  This is the second one.  These two reports
>>>> are indicating the same poisoning page, which is the so-called "duplicate
>>>> report"[1].  And the memory_failure() handling I'm trying to add in
>>>> OS-First path could also be another duplicate report.
>>>>
>>>> Hope the flow below could make it easier to understand:
>>>> CPU accesses bad memory on CXL device, then
>>>>   -> MCE (INT18), *always* report (1)
>>>>   -> * FW-First (implemented now)
>>>>        -> CXL device -> FW
>>>>           -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>>>>      * OS-First (not implemented yet, I'm working on it)
>>>>        -> CXL device -> MSI
>>>>           -> OS:CXL driver -> memory_failure() (2.b)
>>>> so, the (1) and (2.a/b) are duplicated.
>>>>
>>>> (I didn't get response in my reply for [1] while I have to make patch to
>>>> solve this problem, so please correct me if my understanding is wrong.)
>>>
>>> The CPU MCE may not be in the loop. Consider the case of patrol scrub,
>>> or device-DMA accessing poison. In that case the device will signal a
>>> component event and the CPU may never issue the MCE.
>>
>> My other patch: "cxl/core: add poison creation event handler", adds calling memory_failure() when an event is received form device, which checks the poison record (insert if not exists) to make sure poison would be reported/handled, but not twice, no matter CPU issues the MCE later or earlier.  And the lock of poison record makes sure that it's fine even in race condition.
>>
>>>
>>> What is missing for me from this description is *why* does the duplicate
>>> report matter in practice? If all that happens is that the kernel
>>> repeats the lookup to offline the page and set the HWPoison bit, is that
>>> duplicated work worth adding more tracking?
>>
>> Besides setting the HWPoison bit for the poison page, memory_failure() also finds and notifies those processes who are accessing the poison page, and tries to recovery the page.  And there seems no lock to prevent the 2nd memory_failure() and clearing poison operation from being called in race, then the HWPoison bit could be unsure.  I think that's the problem.
>>
>>  > So, I think all CXL poison notification events should trigger an
>>  > action optional memory_failure(). I expect this needs to make sure
>>  > that duplicates re not a problem. I.e. in the case of CPU consumption
>>  > of CXL poison, that causes a synchronous MF_ACTION_REQUIRED event via
>>  > the MCE path *and* it may trigger the device to send an error record
>>  > for the same page. As far as I can see, duplicate reports (MCE + CXL
>>  > device) are unavoidable.
>>
>> As you mentioned in my other patch, this problem should be solved at first.  My patch adds the poison record (tracking, which might not become very large) to prevent duplicating report.
> 
> Ping~
> 
> And I had some problems when using xarray, please see below.
> 
>>
>>>
>>>> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
>>>> to check whether the current poison page has been reported (if yes,
>>>> stop the notifier chain, won't call the following memory_failure()
>>>> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
>>>> page already handled(recorded and reported) in (1) or (2), the other one
>>>> won't duplicate the report.  The record could be clear when
>>>> cxl_clear_poison() is called.
>>>>
>>>> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>>>>
>>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>>> ---
>>>>   arch/x86/include/asm/mce.h |   1 +
>>>>   drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++++
>>>>   drivers/cxl/core/memdev.c  |   6 +-
>>>>   drivers/cxl/cxlmem.h       |   3 +
>>>>   4 files changed, 139 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
>>>> index dfd2e9699bd7..d8109c48e7d9 100644
>>>> --- a/arch/x86/include/asm/mce.h
>>>> +++ b/arch/x86/include/asm/mce.h
>>>> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
>>>>       MCE_PRIO_NFIT,
>>>>       MCE_PRIO_EXTLOG,
>>>>       MCE_PRIO_UC,
>>>> +    MCE_PRIO_CXL,
>>>>       MCE_PRIO_EARLY,
>>>>       MCE_PRIO_CEC,
>>>>       MCE_PRIO_HIGHEST = MCE_PRIO_CEC
>>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>>> index 2626f3fff201..0eb3c5401e81 100644
>>>> --- a/drivers/cxl/core/mbox.c
>>>> +++ b/drivers/cxl/core/mbox.c
>>>> @@ -4,6 +4,8 @@
>>>>   #include <linux/debugfs.h>
>>>>   #include <linux/ktime.h>
>>>>   #include <linux/mutex.h>
>>>> +#include <linux/notifier.h>
>>>> +#include <asm/mce.h>
>>>>   #include <asm/unaligned.h>
>>>>   #include <cxlpci.h>
>>>>   #include <cxlmem.h>
>>>> @@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>>>           if (cxlr)
>>>>               hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>>>> +        if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
>>>> +            return;
>>>> +
>>>>           if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>>>>               trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>>>>                           &evt->gen_media);
>>>> @@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>>>>   }
>>>>   EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>>>> +struct cxl_mce_record {
>>>> +    struct list_head node;
>>>> +    u64 hpa;
>>>> +};
>>>> +LIST_HEAD(cxl_mce_records);
>>>> +DEFINE_MUTEX(cxl_mce_mutex);
>>>
>>> I would recommend an xarray for this use case as that already has its
>>> own internal locking and efficient memory allocation for new nodes.
>>>
>>> However, the "why" question needs to be answered first.
>>
>> xarray does look better.  I didn't think of it befre.  Thanks for suggestion.
> 
> I'm trying using xarray but but I'm running into two problems.
> 
> The first one is: xarray stores an entry with a specified index, but here we only need to store the PFN.  I'm not sure how to specific an index for a PFN.  So I think xarray might not suitable for my case.
> The second one: because we only need to store/search PFN, the list node only contains a list_head and a PFN. But xarray seems to require more memory for each node, which causes more overhead.

Use PFN as the index of the xarray since it's unique. And that makes finding the entry easy with xarray because you just pass in the PFN as the key. You can store an xarray entry with no data. At this point you are just detecting whether the entry has been stored (valid) or not. Hope that helps.  

> 
> Maybe I'm overthinking this?
> 
> 
> -- 
> Thanks
> Ruan.
> 
>>
>> -- 
>> Thanks
>> Ruan.
