Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324B158A20
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430988; cv=none; b=KsIxb+A5M4y8ESH79V/JfluaHp/g4HKJDePk5StoGkdzN+FQZ1s/YSsSCJRHTNBGmB6y5tVlMJBSxr0Gvs8f0h7cdm2HEdOcoNlxlrL9rZraH8VLc+oV4GJ9uRgD4zrUOy+uLzfmui2D0tnPgBTFmATG6RH2ct8R+bwC51Tmt0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430988; c=relaxed/simple;
	bh=uDJwwFOuP/hupsK1Xl66DmKRvm8/ULIM+uZHIuIdS24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DO5lXv6A6WhWONUj8VShxR2+zfUoMF41bK+LVE85IC7IV5CF9qz32uegMiTmwOG7PxUjDvF+X6D3emn9UXMX5FDE393PNiwUbh+1C179/kTHvrA68aHo7+tfmIpA5xX12bxItEZ3rUYLv7v5sFOMor2/wHYUQki+PQ52w1st/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CKa46x31; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CKa46x31"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713430983; x=1744966983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uDJwwFOuP/hupsK1Xl66DmKRvm8/ULIM+uZHIuIdS24=;
  b=CKa46x31kR4hsAe4u6lvRehEvJGCt7MOkS76uBS4Q17mOS6Ea9DjObIN
   0Dwm7rNnYyGdJ1xJ1hC6u+oQpuf+oKNheGYn7piDjj8NMe7RKKlVukAEP
   B3sY3+MwbeUP7v/t3X847szNA5eNomlFFjjcYN5CMdgzfCFNwWKy0bjLW
   VjaCuNahUKtyQRAYtY//aB6VZRpWfwQ/2zd6ctIvfqhS58cUac3djaOpc
   +io0o7VbzsKa0Ty99sXNjHlBJNaDROwPBdRFInK120400zZJ9Kc8ETzkU
   N4G5I+MtCmYHZkhyUBEgsqkWd5deyCWHfZgJrEG3ERtXsM5VQFIDT2Aky
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="134797094"
X-IronPort-AV: E=Sophos;i="6.07,211,1708354800"; 
   d="scan'208";a="134797094"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 18:01:51 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0A5E2C2AC3
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 18:01:50 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 405ADC7296
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 18:01:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id C214D22CCB5
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 18:01:48 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E36F11A000A;
	Thu, 18 Apr 2024 17:01:47 +0800 (CST)
Message-ID: <57182a01-0fc9-4c03-a99d-3a17faced5ff@fujitsu.com>
Date: Thu, 18 Apr 2024 17:01:47 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
To: Dave Jiang <dave.jiang@intel.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, alison.schofield@intel.com
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
 <13652e98-3a70-4946-b8b0-be11032ca431@intel.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <13652e98-3a70-4946-b8b0-be11032ca431@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28328.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28328.005
X-TMASE-Result: 10--23.167500-10.000000
X-TMASE-MatchedRID: 9xvWjox81uOPvrMjLFD6eJTQgFTHgkhZ2q80vLACqaeqvcIF1TcLYANw
	091XoRE6tdBbZHtILeuNZCQJKjBBDuQJzj0xQdQ4vHKClHGjjr3DCscXmnDN78+WYjg3WzyKZ28
	gEzxS4tLh6irq2fTMTeuIRaLznvypzroGAhCVDDVYUconbBJWJDzLhqT0KeNiL31P64kiV5HoKE
	r2irJf5CL637QCIVpi8vc3EUpCmrXDiZmOF0V5Fd+pUF0HsjxRBPY4SegK3jy8GLW9IO2MLTpPt
	Z9ix6SwbSL9AN4UjlsdjcJQBafotb9ZdlL8eonaRjjVhf+j/woNlf30fAUOwiq2rl3dzGQ1A/3R
	8k/14e0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/4/18 1:30, Dave Jiang 写道:
> 
> 
> On 4/17/24 12:50 AM, Shiyang Ruan wrote:
>> Currently driver only traces cxl events, poison creation (for both vmem
>> and pmem type) on cxl memdev is silent.  OS needs to be notified then it
>> could handle poison pages in time.  Per CXL spec, the device error event
>> could be signaled through FW-First and OS-First methods.
> 
> Please consider below for better clarity:
> Currently the driver only traces CXL events. Poison creation (for both ram
> and pmem type) on a CXL memdev is silent. The OS needs to be notified so it
> can handle poison pages. Per CXL spec, the device error event
> can be signaled through the FW-First method or the OS-First method.

Thanks, this is better.

> 
>>
>> So, add poison creation event handler in OS-First method:
>>    - Qemu:
>>      - CXL device reports POISON creation event to OS by MSI by sending
>>        GMER/DER after injecting a poison record;
> 
> Can probably drop the QEMU changes and this is the kernel commit log.

Ok.

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
> 
> I think this needs to be changed to __cxl_report_poison() and the function below to cxl_report_poison(). Otherwise it goes against typical Linux methodology of having the __functionX() as the raw functionality function called by a functionX() wrapper.

This function was designed to do the real reporting work, and could be 
called at other places (actually did in previous version).  Now that it 
is called only below in this version, yes, it's better to change the names.


--
Thanks,
Ruan.

> 
> DJ
> 
