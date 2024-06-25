Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A816A945
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323888; cv=none; b=t2wl0UMd4b0V/cj6VMuyNX++SLy9YOJbh29TVo1UeU2p5rutqUtYyMqVJhllmSQ5GOuh+OyIdOQERQJQ2PLuIGjBAJMK5FH6z/htFaKnvUl9xf8vQpdpAsSn/brAkk5+e0dRVZ9/KTPGqMN/H/k8S0az4653s/eLdbES8KzAZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323888; c=relaxed/simple;
	bh=od/J33fdJNZ9Rdr41ekxlwM7bqqV3VVVriEyW9v/q4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0aQlEmrvHxjSM4WZF8xzJMmSjV9ijFfT2Fduc2coytXhUfeEFGk2aVRmTOCcj9/ycgd4vyoxDMBF8FxRrVM7Sj3UbiDoGYnrDwQPKmOUfmsNFPWmUO4xO34x+4dVpWiu+adaYHRPUznDfVs4ERlxYjnJu8XoOcD9yS4m8tYpjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=b8kWmnlw; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="b8kWmnlw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1719323885; x=1750859885;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=od/J33fdJNZ9Rdr41ekxlwM7bqqV3VVVriEyW9v/q4g=;
  b=b8kWmnlwSC4wzKw+ub9upPQjkqqoKbsybp138wF/sI+K0iUHOydxi8Fa
   VTiOLGWhwKbl061dEPKkc7WEPC3k8Be5IFOdCUhZPfck65jzqmX4aeWNr
   ic19gl7Sh72MTzKtQJS/4OaJfpAh/U9VJO090H3ObeVWeoS8h1stbKKi/
   xx31dU6A2AEaE6v5mDTkPs+p0D2kv4m41gJJtV+MDxwcYTlcB0G2MIYAH
   UjQzn1IAv2gysWwebVF+QAzxuxeDCo8+5QoJUiQ+Vs8Wm5fN6MnDGRmpv
   CHqUb902GTt7dHVBspkoO6ZXkQ0Hkj3gcYizA0kKCfzXMtkRRJiWBh+VE
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="143930137"
X-IronPort-AV: E=Sophos;i="6.08,264,1712588400"; 
   d="scan'208";a="143930137"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 22:56:53 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 00E21C68E2
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 22:56:51 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 37F31CF7CD
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 22:56:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BDE42E36B4
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 22:56:49 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B67C51A000A;
	Tue, 25 Jun 2024 21:56:48 +0800 (CST)
Message-ID: <965e2c27-6147-4237-b4b6-6aaf74363aa2@fujitsu.com>
Date: Tue, 25 Jun 2024 21:56:48 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: Dan Williams <dan.j.williams@intel.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 alison.schofield@intel.com, dave.jiang@intel.com, vishal.l.verma@intel.com
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <6675bd86ea005_57ac29411@dwillia2-xfh.jf.intel.com.notmuch>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <6675bd86ea005_57ac29411@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28480.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28480.000
X-TMASE-Result: 10--23.326400-10.000000
X-TMASE-MatchedRID: +J68l7PWK+aPvrMjLFD6eKn9fPsu8s0aw5PXDQWptSnHr4PSWTXSLMWl
	hj9iHeVpZrChzCJ9VmyNZCQJKjBBDgMPXi5ZiyFvVnzlQiaE21r4h+uI7dxXxOjMOEZ5AL0SsJs
	JK5IfvnZTx0o+4nb1whJ+INVehs+97IFOpFOFSvixaW0fY4IMuDqu3dM+YhFRVxk27EKh25K0pv
	xdZww2r8T+c55jUI9At1K/UeVR3qjWNSt25psfwjz6L+U/pejxpSwAzAEivMea9Zo7TJaDsJgUL
	y4zAbFBOQzI/xUtTVxfahmBw9cTVoke/R2iCaQjn6y0mNkW0aSlY4F8r0vXP6Y5ZGw7wyeHsDBn
	W53+2jl755lTx6LDRs9gc1n8GYlrmcUNCy5hvn9kBXeGzp60+nZljA0Gozoih2WtnORUKg685QX
	45szp96KnDnwlJfeMOyOCKgT1VIspsn9kdROMaR+0aBf65h9MBGvINcfHqhevY1zctlJ9TB8aRh
	KglPt8mNVEdxRO2BKiQrGQ0QrIUWFqPXSLpNdAuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVUEW6ng
	Ig0fclgYWutzp9Uz8dS8JMpci4WUT8BEtUV1doFxov+3JYvY74X/8yfdrbDm5T5iF8gWt8YQb1o
	GZV/vOfOVcxjDhcwAYt5KiTiutm/v0UhTKC9nMRB0bsfrpPI6T/LTDsmJmg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/6/22 1:51, Dan Williams 写道:
> Shiyang Ruan wrote:
>> Background:
>> Since CXL device is a memory device, while CPU consumes a poison page of
>> CXL device, it always triggers a MCE by interrupt (INT18), no matter
>> which-First path is configured.  This is the first report.  Then
>> currently, in FW-First path, the poison event is transferred according
>> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES
>>   -> CPER -> trace report.  This is the second one.  These two reports
>> are indicating the same poisoning page, which is the so-called "duplicate
>> report"[1].  And the memory_failure() handling I'm trying to add in
>> OS-First path could also be another duplicate report.
>>
>> Hope the flow below could make it easier to understand:
>> CPU accesses bad memory on CXL device, then
>>   -> MCE (INT18), *always* report (1)
>>   -> * FW-First (implemented now)
>>        -> CXL device -> FW
>> 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>>      * OS-First (not implemented yet, I'm working on it)
>>        -> CXL device -> MSI
>> 	      -> OS:CXL driver -> memory_failure() (2.b)
>> so, the (1) and (2.a/b) are duplicated.
>>
>> (I didn't get response in my reply for [1] while I have to make patch to
>> solve this problem, so please correct me if my understanding is wrong.)
> 
> The CPU MCE may not be in the loop. Consider the case of patrol scrub,
> or device-DMA accessing poison. In that case the device will signal a
> component event and the CPU may never issue the MCE.

My other patch: "cxl/core: add poison creation event handler", adds 
calling memory_failure() when an event is received form device, which 
checks the poison record (insert if not exists) to make sure poison 
would be reported/handled, but not twice, no matter CPU issues the MCE 
later or earlier.  And the lock of poison record makes sure that it's 
fine even in race condition.

> 
> What is missing for me from this description is *why* does the duplicate
> report matter in practice? If all that happens is that the kernel
> repeats the lookup to offline the page and set the HWPoison bit, is that
> duplicated work worth adding more tracking?

Besides setting the HWPoison bit for the poison page, memory_failure() 
also finds and notifies those processes who are accessing the poison 
page, and tries to recovery the page.  And there seems no lock to 
prevent the 2nd memory_failure() and clearing poison operation from 
being called in race, then the HWPoison bit could be unsure.  I think 
that's the problem.

 > So, I think all CXL poison notification events should trigger an
 > action optional memory_failure(). I expect this needs to make sure
 > that duplicates re not a problem. I.e. in the case of CPU consumption
 > of CXL poison, that causes a synchronous MF_ACTION_REQUIRED event via
 > the MCE path *and* it may trigger the device to send an error record
 > for the same page. As far as I can see, duplicate reports (MCE + CXL
 > device) are unavoidable.

As you mentioned in my other patch, this problem should be solved at 
first.  My patch adds the poison record (tracking, which might not 
become very large) to prevent duplicating report.

> 
>> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
>> to check whether the current poison page has been reported (if yes,
>> stop the notifier chain, won't call the following memory_failure()
>> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
>> page already handled(recorded and reported) in (1) or (2), the other one
>> won't duplicate the report.  The record could be clear when
>> cxl_clear_poison() is called.
>>
>> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   arch/x86/include/asm/mce.h |   1 +
>>   drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/memdev.c  |   6 +-
>>   drivers/cxl/cxlmem.h       |   3 +
>>   4 files changed, 139 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
>> index dfd2e9699bd7..d8109c48e7d9 100644
>> --- a/arch/x86/include/asm/mce.h
>> +++ b/arch/x86/include/asm/mce.h
>> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
>>   	MCE_PRIO_NFIT,
>>   	MCE_PRIO_EXTLOG,
>>   	MCE_PRIO_UC,
>> +	MCE_PRIO_CXL,
>>   	MCE_PRIO_EARLY,
>>   	MCE_PRIO_CEC,
>>   	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 2626f3fff201..0eb3c5401e81 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -4,6 +4,8 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/ktime.h>
>>   #include <linux/mutex.h>
>> +#include <linux/notifier.h>
>> +#include <asm/mce.h>
>>   #include <asm/unaligned.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>> @@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>   		if (cxlr)
>>   			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>>   
>> +		if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
>> +			return;
>> +
>>   		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>>   			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>>   						&evt->gen_media);
>> @@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>>   
>> +struct cxl_mce_record {
>> +	struct list_head node;
>> +	u64 hpa;
>> +};
>> +LIST_HEAD(cxl_mce_records);
>> +DEFINE_MUTEX(cxl_mce_mutex);
> 
> I would recommend an xarray for this use case as that already has its
> own internal locking and efficient memory allocation for new nodes.
> 
> However, the "why" question needs to be answered first.

xarray does look better.  I didn't think of it befre.  Thanks for 
suggestion.

--
Thanks
Ruan.
