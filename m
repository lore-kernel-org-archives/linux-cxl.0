Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D98C129
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719886401; cv=none; b=D7MdeVS9eMe6Z3bXkpn39DzrCfrgy5kjV/ahaC+hCfHzEswP/1uI1l5X2PbjQMqW+t9bzhFnya7NMuNcIXxeMXuo056YbLoYWHOZz+0RSK/4JaXA8jbVPtcv2xJNQoblZio2nvbSmSnO8fXTmcHBBVNgxNv5HimVe37ci6cMMFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719886401; c=relaxed/simple;
	bh=P0c36FUeZiCc9g+24qcIraZdLU8Djm8lhJdaciP5RMg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=usRx3Dqm90T4PxiXanDHw7D7mUWryReQoJBkGpIrohImY9Lq7jTmAl5EXuMQo3NqjoepCT6/P2ZEdEH84I6ur71W9vdYsWQ6Sa8mcFnpN/PsgEjuWaXAnIrNJVzUADU2112YGYXUSz2OZNRESKCgIn+j71Jn6vovLYWBL6ytA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Auyp5SMy; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Auyp5SMy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1719886399; x=1751422399;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=P0c36FUeZiCc9g+24qcIraZdLU8Djm8lhJdaciP5RMg=;
  b=Auyp5SMylZt0ngyIaw6pQy6OlyziOobGMMXp1D/cllSX+FSVlbw6FmcJ
   hRq8jWpOTlcMgTp1iTVzv0Rmhvo0XUL67L9EQitywZxaJ355FTkud50rF
   8P9mA6OofsTvwK31XxLtUEtdVjT9JdFEsoIpbgc5NG3ukDRkqNO+U/SDc
   26S7vUdAL1Z5ktwS9nsh6bxQ5n9cTEZ8xHERV26+lVLU7lcMvSwWj7jiJ
   6smwcDEbeEsyGRGbz5NDPNhsROCQ3fS8ISO5+flMc8zOlkdtq4fLgFwyQ
   jQhv0Bb3V1S4uw29fkdXTtMEcg+aREFYJ+e0crqD4KmV7LijfJECKTvt8
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="164804699"
X-IronPort-AV: E=Sophos;i="6.09,177,1716217200"; 
   d="scan'208";a="164804699"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 11:12:08 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 52D12C9443
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 11:12:05 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7F9D6D50ED
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 11:12:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 076A41EBBC0
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 11:12:04 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 20B531A000B;
	Tue,  2 Jul 2024 10:12:03 +0800 (CST)
Message-ID: <1fab087b-eb6c-485e-a2ed-f86e8dfacc5d@fujitsu.com>
Date: Tue, 2 Jul 2024 10:12:01 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 alison.schofield@intel.com, dave.jiang@intel.com, vishal.l.verma@intel.com
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <6675bd86ea005_57ac29411@dwillia2-xfh.jf.intel.com.notmuch>
 <965e2c27-6147-4237-b4b6-6aaf74363aa2@fujitsu.com>
In-Reply-To: <965e2c27-6147-4237-b4b6-6aaf74363aa2@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28496.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28496.002
X-TMASE-Result: 10--22.554500-10.000000
X-TMASE-MatchedRID: OnXFgg5KIq2PvrMjLFD6eKn9fPsu8s0a2q80vLACqaeeT9kASxo4MUbg
	XczvLJKOZrChzCJ9VmyNZCQJKjBBDgMPXi5ZiyFvVnzlQiaE21r4h+uI7dxXxOjMOEZ5AL0SsJs
	JK5IfvnZTx0o+4nb1whJ+INVehs+97IFOpFOFSvixaW0fY4IMuDqu3dM+YhFRVxk27EKh25K0pv
	xdZww2r8T+c55jUI9At1K/UeVR3qjWNSt25psfwjz6L+U/pejxpSwAzAEivMea9Zo7TJaDsJgUL
	y4zAbFBOQzI/xUtTVxfahmBw9cTVoke/R2iCaQjn6y0mNkW0aSlY4F8r0vXP6Y5ZGw7wyeHsDBn
	W53+2jl755lTx6LDRs9gc1n8GYlrmcUNCy5hvn9kBXeGzp60+nZljA0Gozoih2WtnORUKg685QX
	45szp96KnDnwlJfeMOyOCKgT1VIsqr12s6iu4vArcxrzwsv5uf70KM8eatUjfc2Xd6VJ+ym+tWV
	Fb8XYlPJEa0PzdsXmikrdCCR3aDe/i00nUfc4wnVTWWiNp+v8Jlr1xKkE5ucC5DTEMxpeQfiq1g
	j2xET/FG6rPbKnpuqrlqe9TaLwsJfmEcyk6uEa3D7EeeyZCM9fgqdEINwWeVgkL9epqBvGxpN5W
	P+PXywGRC3bBIF8owlUW6AAzaVaR9GF2J2xqM4MbH85DUZXyudR/NJw2JHcNYpvo9xW+mI6HM5r
	qDwqtlExlQIQeRG0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/6/25 21:56, Shiyang Ruan 写道:
> 
> 
> 在 2024/6/22 1:51, Dan Williams 写道:
>> Shiyang Ruan wrote:
>>> Background:
>>> Since CXL device is a memory device, while CPU consumes a poison page of
>>> CXL device, it always triggers a MCE by interrupt (INT18), no matter
>>> which-First path is configured.  This is the first report.  Then
>>> currently, in FW-First path, the poison event is transferred according
>>> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES
>>>   -> CPER -> trace report.  This is the second one.  These two reports
>>> are indicating the same poisoning page, which is the so-called 
>>> "duplicate
>>> report"[1].  And the memory_failure() handling I'm trying to add in
>>> OS-First path could also be another duplicate report.
>>>
>>> Hope the flow below could make it easier to understand:
>>> CPU accesses bad memory on CXL device, then
>>>   -> MCE (INT18), *always* report (1)
>>>   -> * FW-First (implemented now)
>>>        -> CXL device -> FW
>>>           -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>>>      * OS-First (not implemented yet, I'm working on it)
>>>        -> CXL device -> MSI
>>>           -> OS:CXL driver -> memory_failure() (2.b)
>>> so, the (1) and (2.a/b) are duplicated.
>>>
>>> (I didn't get response in my reply for [1] while I have to make patch to
>>> solve this problem, so please correct me if my understanding is wrong.)
>>
>> The CPU MCE may not be in the loop. Consider the case of patrol scrub,
>> or device-DMA accessing poison. In that case the device will signal a
>> component event and the CPU may never issue the MCE.
> 
> My other patch: "cxl/core: add poison creation event handler", adds 
> calling memory_failure() when an event is received form device, which 
> checks the poison record (insert if not exists) to make sure poison 
> would be reported/handled, but not twice, no matter CPU issues the MCE 
> later or earlier.  And the lock of poison record makes sure that it's 
> fine even in race condition.
> 
>>
>> What is missing for me from this description is *why* does the duplicate
>> report matter in practice? If all that happens is that the kernel
>> repeats the lookup to offline the page and set the HWPoison bit, is that
>> duplicated work worth adding more tracking?
> 
> Besides setting the HWPoison bit for the poison page, memory_failure() 
> also finds and notifies those processes who are accessing the poison 
> page, and tries to recovery the page.  And there seems no lock to 
> prevent the 2nd memory_failure() and clearing poison operation from 
> being called in race, then the HWPoison bit could be unsure.  I think 
> that's the problem.
> 
>  > So, I think all CXL poison notification events should trigger an
>  > action optional memory_failure(). I expect this needs to make sure
>  > that duplicates re not a problem. I.e. in the case of CPU consumption
>  > of CXL poison, that causes a synchronous MF_ACTION_REQUIRED event via
>  > the MCE path *and* it may trigger the device to send an error record
>  > for the same page. As far as I can see, duplicate reports (MCE + CXL
>  > device) are unavoidable.
> 
> As you mentioned in my other patch, this problem should be solved at 
> first.  My patch adds the poison record (tracking, which might not 
> become very large) to prevent duplicating report.

Ping~

And I had some problems when using xarray, please see below.

> 
>>
>>> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
>>> to check whether the current poison page has been reported (if yes,
>>> stop the notifier chain, won't call the following memory_failure()
>>> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
>>> page already handled(recorded and reported) in (1) or (2), the other one
>>> won't duplicate the report.  The record could be clear when
>>> cxl_clear_poison() is called.
>>>
>>> [1] 
>>> https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>>>
>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>> ---
>>>   arch/x86/include/asm/mce.h |   1 +
>>>   drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++++
>>>   drivers/cxl/core/memdev.c  |   6 +-
>>>   drivers/cxl/cxlmem.h       |   3 +
>>>   4 files changed, 139 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
>>> index dfd2e9699bd7..d8109c48e7d9 100644
>>> --- a/arch/x86/include/asm/mce.h
>>> +++ b/arch/x86/include/asm/mce.h
>>> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
>>>       MCE_PRIO_NFIT,
>>>       MCE_PRIO_EXTLOG,
>>>       MCE_PRIO_UC,
>>> +    MCE_PRIO_CXL,
>>>       MCE_PRIO_EARLY,
>>>       MCE_PRIO_CEC,
>>>       MCE_PRIO_HIGHEST = MCE_PRIO_CEC
>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>> index 2626f3fff201..0eb3c5401e81 100644
>>> --- a/drivers/cxl/core/mbox.c
>>> +++ b/drivers/cxl/core/mbox.c
>>> @@ -4,6 +4,8 @@
>>>   #include <linux/debugfs.h>
>>>   #include <linux/ktime.h>
>>>   #include <linux/mutex.h>
>>> +#include <linux/notifier.h>
>>> +#include <asm/mce.h>
>>>   #include <asm/unaligned.h>
>>>   #include <cxlpci.h>
>>>   #include <cxlmem.h>
>>> @@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct 
>>> cxl_memdev *cxlmd,
>>>           if (cxlr)
>>>               hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>>> +        if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
>>> +            return;
>>> +
>>>           if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>>>               trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>>>                           &evt->gen_media);
>>> @@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct 
>>> cxl_memdev_state *mds)
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>>> +struct cxl_mce_record {
>>> +    struct list_head node;
>>> +    u64 hpa;
>>> +};
>>> +LIST_HEAD(cxl_mce_records);
>>> +DEFINE_MUTEX(cxl_mce_mutex);
>>
>> I would recommend an xarray for this use case as that already has its
>> own internal locking and efficient memory allocation for new nodes.
>>
>> However, the "why" question needs to be answered first.
> 
> xarray does look better.  I didn't think of it befre.  Thanks for 
> suggestion.

I'm trying using xarray but but I'm running into two problems.

The first one is: xarray stores an entry with a specified index, but 
here we only need to store the PFN.  I'm not sure how to specific an 
index for a PFN.  So I think xarray might not suitable for my case.
The second one: because we only need to store/search PFN, the list node 
only contains a list_head and a PFN. But xarray seems to require more 
memory for each node, which causes more overhead.

Maybe I'm overthinking this?


--
Thanks
Ruan.

> 
> -- 
> Thanks
> Ruan.
