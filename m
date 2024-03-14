Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5D6FE36
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429823; cv=none; b=S+8reDaGsUeo1CIDpWaPjmyAYIzR8rGQDe472kWPTl63kSPasYHsDnS47fDD/WHiIHJ58CRcgkzd7B4qeNGqxbkXH3e81DD+lfuLN/CzI03P54wVEYe56tbGwgu58oFiYoDwNdi4exohHWamneGIJcpJQJZE/zVYRNy/1gMJ/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429823; c=relaxed/simple;
	bh=evENAN8QwOVpGZETLVj8aFWGFrZb4cuvRJYiwQLopHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6zDr7rhVKYWzf4QS/LqX4kCh9u++87f9ZrhyrcBH/p8swlJ97ShC673TroqOPF7DrwX0COtPQZT49BYN+4599uGIhDIwzo3Wtdyf8MhNumQrGMIB/QynhMIHVBSS7FXB6FnT3DRhJJPNA3j9HYOKJKpeNAC1ImqtuRIDiyZl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Xv1bDtQV; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Xv1bDtQV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710429821; x=1741965821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=evENAN8QwOVpGZETLVj8aFWGFrZb4cuvRJYiwQLopHk=;
  b=Xv1bDtQVFHc5S4cGysbORCcLjwOrz7M6ZV63BUpLSPDC2VAJtxUIcpwY
   FRgiMrILaSxsAmZ+hZ6/JezuYzDq2BJbzBi8GX2+jnkt+ZL3akH3DYtGZ
   m0LF7atEPmZBhXJKtIpzchW2OCqHLZ8M78GjF0CNJM5sTQvysmKFuJjWd
   fR5Dtd0dbrTPrFPygzwOwNEDmN0Q5g3XOFW3O6iHGKR82MMMhCaihXCPC
   bSM4lT8aiQCabHbYMRGVdOI9iRgPMQSY4Ra5gbQAcMvvz1w3c1eKOo+7j
   m+49nqxzxuPyPqaboVypygYa+oXGox3Hx1HEqXiSPsDp5g/RPk9IuAaXv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="131638615"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="131638615"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 00:23:38 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0702AFBD86
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 00:23:36 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3AA3436580
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 00:23:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id BDFCA200932D5
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 00:23:34 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 32B901A006A;
	Thu, 14 Mar 2024 23:23:34 +0800 (CST)
Message-ID: <125c1701-3f18-45f7-9770-45ec41feae7b@fujitsu.com>
Date: Thu, 14 Mar 2024 23:23:33 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] cxl/core: introduce cxl_mem_report_poison()
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan.Cameron@huawei.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-6-ruansy.fnst@fujitsu.com>
 <65c71bdc81927_d2d4294f9@dwillia2-xfh.jf.intel.com.notmuch>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <65c71bdc81927_d2d4294f9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28252.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28252.000
X-TMASE-Result: 10--16.183800-10.000000
X-TMASE-MatchedRID: 6Yvl3or3fgqPvrMjLFD6eCkMR2LAnMRp2q80vLACqaeqvcIF1TcLYA4p
	qmczoDwtjlYl41I8jVOZKLS7xMLJgrKFg5Tail4EWFHKJ2wSViT865QlVwxmG7rfxlRjqBJ34MP
	8QbjSbz3qhalTWVmQtzioQ72L2lCJjnkOkV5xgha5x7uAXGEprcE5XPQnBzGXq8KsbROd9VTZ3y
	a1EhGxQ5J5q9EvnZr1z2BzWfwZiWsMeUy96gk4BMQ4mpKyfkqZdmWMDQajOiKwcSh5kytY+bTLc
	NrcH2Gr585VzGMOFzABi3kqJOK62b+/RSFMoL2cxEHRux+uk8h+ICquNi0WJNQlmYqwTTb1fLTm
	1duEMC3e/XLnHnOr96YgO4sEv0aRftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/2/10 14:46, Dan Williams 写道:
> Shiyang Ruan wrote:
>> If poison is detected(reported from cxl memdev), OS should be notified to
>> handle it.  Introduce this function:
>>    1. translate DPA to HPA;
>>    2. construct a MCE instance; (TODO: more details need to be filled)
>>    3. log it into MCE event queue;
>>
>> After that, MCE mechanism can walk over its notifier chain to execute
>> specific handlers.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   arch/x86/kernel/cpu/mce/core.c |  1 +
>>   drivers/cxl/core/mbox.c        | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index bc39252bc54f..a64c0aceb7e0 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -131,6 +131,7 @@ void mce_setup(struct mce *m)
>>   	m->ppin = cpu_data(m->extcpu).ppin;
>>   	m->microcode = boot_cpu_data.microcode;
>>   }
>> +EXPORT_SYMBOL_GPL(mce_setup);
> 
> No, mce_setup() is x86 specific and the CXL subsystem is CPU
> architecture independent. My expectation is that CXL should translate
> errors for edac similar to how the ACPI GHES code does it. See usage of
> edac_raw_mc_handle_error() and memory_failure_queue().
> 
> Otherwise an MCE is a CPU consumption of poison event, and CXL is
> reporting device-side discovery of poison.

Yes, I misunderstood here.  I was mean to use MCE to finally call 
memory_failure(). I think memory_failure_queue() is what I need.

   void memory_failure_queue(unsigned long pfn, int flags)

But it can only queue one PFN at a time, we may need to make it support 
queuing a range of PFN.


--
Thanks,
Ruan.
