Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197917758
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714735950; cv=none; b=gVrNf/xxpdCs5Gvd750ljr3XjxqkqBYGDNDH2cGMvTGlX8N4j0INfTNRruuoWFNFZD8xvwnDu0hGGD7v+JVuDB8l0thPNdX+buL9tKsfld4T1T2hQtmLmicOYox8+X4YZFN1gqkhvGJM64GbrJcTKycaVIVS8ueBFy18zmq57oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714735950; c=relaxed/simple;
	bh=Ph0sVC8wxZB+O9I9nzGHvBBheV5ChbIMFIQ6F7nE5nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubJVAYa+wh7gwgIgqCVTDFeTzF2Ee786EsJvhs9Gva6dP/3oDb6k8ssSu7msaenz/zRxJrw6oewIiMpfL/qX2fuEg+woRYEHooA57ZrCuu4qGaiv1bZnzzt8XhTXwSW0cdCMT3yA8infHcqHkRoaaxFe94oSQoTqsC6v6yBe1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pH2U10Qu; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pH2U10Qu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1714735948; x=1746271948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ph0sVC8wxZB+O9I9nzGHvBBheV5ChbIMFIQ6F7nE5nQ=;
  b=pH2U10Qu+td4cm/M9PpmFzmcQBGwypqB6cYLojLwkcO6V5o07sBrYxnV
   6yUsAuGVrSMsrscTo++j9SV07JAV4n9gs0HLLd4yQGNlxRaoinA+lUknA
   VMSIdBSMLrXUBGPs6wjQd4+OQ/R96QCTLECf7gjHb6pH/2t0sACmzDSCZ
   bkTSnTOcjoM6WVMuaEYztdFPYwppW1wPOxGo3CbSKsqsCMDwARkyhIKB5
   1DpP85qaMxgbPPx7JbJtUZvV9d7xbUlnBTrEpD485QIiB2Dux7fbWOiWk
   VZfELb8/7GmhCbs6x9tikVo3Ufk+NfVHaUmHYFYYYjnZ//b9fyYt5gZ9B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="156735899"
X-IronPort-AV: E=Sophos;i="6.07,251,1708354800"; 
   d="scan'208";a="156735899"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 20:32:19 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0992D5AF65
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 20:32:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 418EDBDC97
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 20:32:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D14902008BCE2
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 20:32:15 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 215F31A0002;
	Fri,  3 May 2024 19:32:15 +0800 (CST)
Message-ID: <b5eb1017-5f0a-4d68-bb63-41e628706a78@fujitsu.com>
Date: Fri, 3 May 2024 19:32:14 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 alison.schofield@intel.com
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
 <6628008c39e80_a96f29415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <6628008c39e80_a96f29415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28358.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28358.007
X-TMASE-Result: 10--17.853000-10.000000
X-TMASE-MatchedRID: iE9XhvgCcn2PvrMjLFD6eJTQgFTHgkhZw5PXDQWptSnHr4PSWTXSLMWl
	hj9iHeVpfif6PsvfsVJjDSloE/K2AoDL4lw7ay41bMGKOuLn5FWlY4F8r0vXP2O0yVK/5LmcOUJ
	GvwdveqIaMKZ6Kdx++qByu2sDWGqW2BIRRxPqiXqAO0kpgKezRCy+piTiLP72nc419+1VHFoRQP
	nsANQIhSm8xqSuoEo4ex+UDbqohJBaTyDiyKJai0H0jmDpcSmLpxAd6mi1Ga3/z5X0KzxduuiBx
	aphBmrYoKLaH5bp/M7zteLMLyOs0V9dhvgA/NqZaw1J1gAXJ1KX2rvknNYlE7+7SLqdnJMRV8uV
	ka6dpKMDUWAqBlTrGHzelVjH2BNfH9BbtD/NYuUEOhHzDsL05jzLhqT0KeNiL31P64kiV5HoKEr
	2irJf5CL637QCIVpi8vc3EUpCmrXDiZmOF0V5FVhRyidsElYk8LGB8WXSdboTf11Tnw43V6xIjS
	YfsSaZ6mGP/NvIDJh+QYb9VB9LzuIFWrKTp/z05DSMPEZQAkNK4f4Z+CZAZ9pSUoaJ2MP7kHs1A
	zjpA+xaM5U7dRXqm1+24nCsUSFNt7DW3B48kkHYoM82yqmFMvoLR4+zsDTtFEAkLaTcFnomiH6x
	IjcSC4jfW/vklDmQBEC8ggnHU5PP8/c7m0jcKw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/4/24 2:40, Dan Williams 写道:
> Shiyang Ruan wrote:
>> Currently driver only traces cxl events, poison creation (for both vmem
>> and pmem type) on cxl memdev is silent.
> 
> As it should be.
> 
>> OS needs to be notified then it could handle poison pages in time.
> 
> No, it was always the case that latent poison is an "action optional"
> event. I am not understanding the justification for this approach. What
> breaks if the kernel does not forward events to memory_failure_queue()?

I think for type3(pmem) device, it should be handled like NVDIMM.  If 
there are processes or filesystems running on it, they could be notified 
then operate a friendly shutdown if POISON happens.

> 
> Consider that in the CPU consumption case that the firmware first path
> will do its own memory_failure_queue() and in the native case the MCE
> handler will take care of this. So that leaves pages that are accessed
> by DMA or background operation that encounter poison. Those are "action
> optional" scenarios and it is not clear to me how the driver tells the
> difference.

So for real CXL device, it always use FW-First path to notify such 
failure event?  Then, there is nothing to do with OS-First path?

> 
> This needs more precision on which agent is repsonsible for what level
> of reporting. The distribution of responsibility between ACPI GHES,
> EDAC, and the CXL driver is messy and I expect this changelog to
> demonstrate it understands all those considerations.

Ok, I'll try to understand them.

> 
>> Per CXL spec, the device error event could be signaled through
>> FW-First and OS-First methods.
>>
>> So, add poison creation event handler in OS-First method:
>>    - Qemu:
> 
> Why is QEMU relevant for this patch? QEMU is only a development vehicle
> the upstream enabling should be reference shipping or expected to be
> shipping hardware implementations.

Yes, but currently we don't have a real CXL device so developing and 
verification could only be done on Qemu with simulated CXL device.

> 
>>      - CXL device reports POISON creation event to OS by MSI by sending
>>        GMER/DER after injecting a poison record;
> 
> When you say "inject" here do you mean "add to the poison list if
> present". Because "inject" to me means the "Inject Poison" Memory Device
> Command.

It's a Qemu qmp command called "cxl-inject-poison", which only adds a 
given address,length record to CXL's poison list, doesn't send 
INJECT_POISON mbox command.

> 
>>    - CXL driver:
>>      a. parse the POISON event from GMER/DER;
>>      b. translate poisoned DPA to HPA (PFN);
>>      c. enqueue poisoned PFN to memory_failure's work queue;
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
>>   drivers/cxl/cxlmem.h      |   8 +--
>>   include/linux/cxl-event.h |  18 +++++-
>>   3 files changed, 125 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index f0f54aeccc87..76af0d73859d 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>>   
>> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>> -			    enum cxl_event_log_type type,
>> -			    enum cxl_event_type event_type,
>> -			    const uuid_t *uuid, union cxl_event *evt)
>> +static void cxl_report_poison(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
>> +			      u64 dpa)
>>   {
>> -	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>> +	u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>> +	unsigned long pfn = PHYS_PFN(hpa);
>> +
>> +	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
>> +		return;
> 
> No need for this check, memory_failure_queue() is already stubbed out in
> the CONFIG_MEMORY_FAILURE=n case.
Yes, I'm overthinking it.

> 
>> +	memory_failure_queue(pfn, MF_ACTION_REQUIRED);
> 
> My expectation is MF_ACTION_REQUIRED is not appropriate for CXL event
> reported errors since action is only required for direct consumption
> events and those need not be reported through the device event queue.
Got it.

> 
> It would be useful to collaborate with a BIOS firmware engineer so that
> the kernel ends up with similar logic as is used to set CPER record
> severity, or at least understands why it would want to be different.
> See how ghes_handle_memory_failure() determines the
> memory_failure_queue() flags.

Ok, thanks for the advice.


--
Ruan.



