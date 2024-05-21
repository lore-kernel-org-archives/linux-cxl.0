Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D942056
	for <linux-cxl@vger.kernel.org>; Tue, 21 May 2024 05:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716269728; cv=none; b=geB4HeMhUeKhGs9rOCF4UANOURS7JUFLPTDgVM0eZggZOfFsP8q7kWdNd0TLsAice/ZqMOPXgRboezrA05QUwEch5Er+dd/PWaLrxUk2+sBvV5ALcrPUZGdN9pu5TUPDD67rrg0QKnPkDGs4O/zkRcAwETh3BhTBI7BrsljiMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716269728; c=relaxed/simple;
	bh=SCUPDGU310DnTYsYaeNWK/y5FGc6tJaxJGlEiMyI7Sw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K5a2EuOSpapiViui7IV1wR1BOK6okLAt09g1AHdtHVzIv7VKE4vFhTDrKglQlIQ3N4Zt9ShGmvjpyrqffsq8BRXGPTK5H6hyyYAvnW9lSg2tFG9PQMYk/XDQ3hs5CqBLT2+QusXjktxbGyJ3ozAMl2iiDYyJcaaFRoPaUGaRKz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FNVHhIDr; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FNVHhIDr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1716269727; x=1747805727;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=SCUPDGU310DnTYsYaeNWK/y5FGc6tJaxJGlEiMyI7Sw=;
  b=FNVHhIDrbtHCgZJynwoWq2F6+OdfEbE87M5ThwFotr+leEUoKPn0d5IG
   in9poRmo4IqABIjtfS0MRXxTI+8m6+PkUXK+bjnEMOIOda3fq24kVaw4U
   t38XIKceJlOBPDdXuDRmSoLkRooTrgUjQkPcvwRUWrd1KIsSOAMGJnr/1
   a0jN/Yn3oa/k7zK4blq5P+hepu/olTBc548V2la6b/ss0lXtIvMDxTPfb
   dZQldxryGBL6iU5fKMsQIClXCcYok68D/TEyfxJOZHox8ADY1lqhI3BHp
   fFuQBFQhqiND7QPcaX97oRItOVNQWy5nMYht76PbmARfAXjP9s7OyRybC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="158926162"
X-IronPort-AV: E=Sophos;i="6.08,176,1712588400"; 
   d="scan'208";a="158926162"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 14:35:17 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0CD41DF0D7
	for <linux-cxl@vger.kernel.org>; Tue, 21 May 2024 14:35:15 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2F345BDC87
	for <linux-cxl@vger.kernel.org>; Tue, 21 May 2024 14:35:14 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9284320094ACC
	for <linux-cxl@vger.kernel.org>; Tue, 21 May 2024 14:35:13 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id BCACC1A000A;
	Tue, 21 May 2024 13:35:12 +0800 (CST)
Message-ID: <b14ed74c-7fc5-461a-9c5f-fbb94df50e7d@fujitsu.com>
Date: Tue, 21 May 2024 13:35:12 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 alison.schofield@intel.com
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
 <6628008c39e80_a96f29415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <b5eb1017-5f0a-4d68-bb63-41e628706a78@fujitsu.com>
In-Reply-To: <b5eb1017-5f0a-4d68-bb63-41e628706a78@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28400.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28400.005
X-TMASE-Result: 10--18.138600-10.000000
X-TMASE-MatchedRID: OnXFgg5KIq2PvrMjLFD6eJTQgFTHgkhZ2q80vLACqaeeT9kASxo4MUbg
	XczvLJKOfif6PsvfsVJjDSloE/K2AoDL4lw7ay41bMGKOuLn5FWlY4F8r0vXP2O0yVK/5LmcOUJ
	GvwdveqIaMKZ6Kdx++qByu2sDWGqW2BIRRxPqiXqAO0kpgKezRCy+piTiLP72nc419+1VHFoRQP
	nsANQIhSm8xqSuoEo4ex+UDbqohJBaTyDiyKJai0H0jmDpcSmLpxAd6mi1Ga3/z5X0Kzxdul292
	NvkjB1uZ4LpE3hFYlFGhiWNz7usIuCPCC2ZACqAI0cHLI6lhgJUENBIMyKD0Wjliw+xvItdH2FV
	/Q4wfcSNlF1efden0xLg+Gj28iXz62wfhnJCIYyVF2HD8EHNp2o8zUxTJUAjQWa52++sgNmzhHc
	t+GcMBE/3QbfXts8PmJxhCNBaN2LiNzFg3s1SJRhvfWx0TE/bCZa9cSpBObnAuQ0xDMaXkN9kut
	SXDwfHVzYnrImPSZdBCdSPDWIIm7/KM1zCNPCMWTWEh5N2a9EYQYFQ2+HwYAbxceezd6S1Wt19W
	/5IzWypuN1B0n2bvZwCzlUmqhVlb7A96mLiSaSAwosDBeuPwRxCcOlDoVfTfL8fHUCAmusE3acA
	rSTnfcL0Uzyk5KX7nagtny7ZPcS/WXZS/HqJ2kY41YX/o/8K9+qbtSz74qV4N1jhRVQFLSAHAop
	Ed76vCHJHCFbsTn+bNtBoHfBInQq8MbEB8QgeaMHO+hPtLa/pH1q/Md+SQA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/5/3 19:32, Shiyang Ruan 写道:
> 
> 
> 在 2024/4/24 2:40, Dan Williams 写道:
>> Shiyang Ruan wrote:
>>> Currently driver only traces cxl events, poison creation (for both vmem
>>> and pmem type) on cxl memdev is silent.
>>
>> As it should be.
>>
>>> OS needs to be notified then it could handle poison pages in time.
>>
>> No, it was always the case that latent poison is an "action optional"
>> event. I am not understanding the justification for this approach. What
>> breaks if the kernel does not forward events to memory_failure_queue()?
> 
> I think for type3(pmem) device, it should be handled like NVDIMM.  If 
> there are processes or filesystems running on it, they could be notified 
> then operate a friendly shutdown if POISON happens.
> 
>>
>> Consider that in the CPU consumption case that the firmware first path
>> will do its own memory_failure_queue() and in the native case the MCE
>> handler will take care of this. So that leaves pages that are accessed
>> by DMA or background operation that encounter poison. Those are "action
>> optional" scenarios and it is not clear to me how the driver tells the
>> difference.
> 
> So for real CXL device, it always use FW-First path to notify such 
> failure event?  Then, there is nothing to do with OS-First path?
> 
>>
>> This needs more precision on which agent is repsonsible for what level
>> of reporting. The distribution of responsibility between ACPI GHES,
>> EDAC, and the CXL driver is messy and I expect this changelog to
>> demonstrate it understands all those considerations.
> 
> Ok, I'll try to understand them.

Hi Dan,

I checked the GHES, EDAC codes. I think they belong to FW-First path. 
GHES polls mem errors, then
  1. report by EDAC
  2. construct a MCE, mce_log(), and handle in work queue
  3. queue it into memory_failure right now if needed (sync, ...)
And community is adding CXL FW-First trace support[1].

But in OS-First path, error record is sent to CXL driver via MSI, it 
won't conflict with FW-First path, I think.

[1] 
https://lore.kernel.org/linux-cxl/43ab39e9-c9c2-bfe4-7d1c-bad462221c9c@amd.com/T/#t

> 
>>
>>> Per CXL spec, the device error event could be signaled through
>>> FW-First and OS-First methods.
>>>
>>> So, add poison creation event handler in OS-First method:
>>>    - Qemu:
>>
>> Why is QEMU relevant for this patch? QEMU is only a development vehicle
>> the upstream enabling should be reference shipping or expected to be
>> shipping hardware implementations.
> 
> Yes, but currently we don't have a real CXL device so developing and 
> verification could only be done on Qemu with simulated CXL device.
> 
>>
>>>      - CXL device reports POISON creation event to OS by MSI by sending
>>>        GMER/DER after injecting a poison record;
>>
>> When you say "inject" here do you mean "add to the poison list if
>> present". Because "inject" to me means the "Inject Poison" Memory Device
>> Command.
> 
> It's a Qemu qmp command called "cxl-inject-poison", which only adds a 
> given address,length record to CXL's poison list, doesn't send 
> INJECT_POISON mbox command.
> 
>>
>>>    - CXL driver:
>>>      a. parse the POISON event from GMER/DER;
>>>      b. translate poisoned DPA to HPA (PFN);
>>>      c. enqueue poisoned PFN to memory_failure's work queue;
>>>
>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>> ---
>>>   drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
>>>   drivers/cxl/cxlmem.h      |   8 +--
>>>   include/linux/cxl-event.h |  18 +++++-
>>>   3 files changed, 125 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>> index f0f54aeccc87..76af0d73859d 100644
>>> --- a/drivers/cxl/core/mbox.c
>>> +++ b/drivers/cxl/core/mbox.c
>>> @@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state 
>>> *mds)
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>>> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>> -                enum cxl_event_log_type type,
>>> -                enum cxl_event_type event_type,
>>> -                const uuid_t *uuid, union cxl_event *evt)
>>> +static void cxl_report_poison(struct cxl_memdev *cxlmd, struct 
>>> cxl_region *cxlr,
>>> +                  u64 dpa)
>>>   {
>>> -    if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>>> +    u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>>> +    unsigned long pfn = PHYS_PFN(hpa);
>>> +
>>> +    if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
>>> +        return;
>>
>> No need for this check, memory_failure_queue() is already stubbed out in
>> the CONFIG_MEMORY_FAILURE=n case.
> Yes, I'm overthinking it.
> 
>>
>>> +    memory_failure_queue(pfn, MF_ACTION_REQUIRED);
>>
>> My expectation is MF_ACTION_REQUIRED is not appropriate for CXL event
>> reported errors since action is only required for direct consumption
>> events and those need not be reported through the device event queue.
> Got it.

I'm not very sure about 'Host write/read' type.  In my opinion, these 
two types of event should be sent from device when CPU is accessing a 
bad memory address, they could be thought of a sync event which needs 
the 'MF_ACTION_REQUIRED' flag.  Then, we can determine the flag by the 
types like this:
- CXL_EVENT_TRANSACTION_READ | CXL_EVENT_TRANSACTION_WRITE
                                               => MF_ACTION_REQUIRED
- CXL_EVENT_TRANSACTION_INJECT_POISON         => MF_SW_SIMULATED
- others                                      => 0


--
Thanks,
Ruan.

> 
>>
>> It would be useful to collaborate with a BIOS firmware engineer so that
>> the kernel ends up with similar logic as is used to set CPER record
>> severity, or at least understands why it would want to be different.
>> See how ghes_handle_memory_failure() determines the
>> memory_failure_queue() flags.
> 
> Ok, thanks for the advice.
> 
> 
> -- 
> Ruan.
> 
> 
> 
