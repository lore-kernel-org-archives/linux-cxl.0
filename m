Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C814534A
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736324; cv=none; b=iwpm5FpCxnJojNBAz2eHIo9SO5xWj0/Qm/32COhVZIRtHhHS1X3G7ygpx0eBGLBCwDlG9vPv5qTLXccN6lEvtqu956whAl+wqTeOXxEziHiX1TCjh34GJ6wN2hPToXpAGkrnHWZTlgp9Rb5E7fBOi+n3oc4EFRCHFSi9CgLRD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736324; c=relaxed/simple;
	bh=dxkrvDCZNoTH6UzikNB5h5QEWMplJ94dcTU6BIAt1iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhptq2Qf6Y1Iy89pc6qYRe85BKlwFxKi3YrbaJaAvKt1BzsUUeonAExHBlk0pGVg7NTEIx9DXdUI6HdjbwyPYiVl4K9IvSP1QzdrZGhpzq5dgkYF/hq/bbcig9mQ6UGBXhUzzp7XXynsgdFaKWtzVR5k5mucLUjOZaggpqTFdsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KDh16ajo; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KDh16ajo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1714736322; x=1746272322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dxkrvDCZNoTH6UzikNB5h5QEWMplJ94dcTU6BIAt1iM=;
  b=KDh16ajovBWTq2pt+uCDWDesLCb67a6SehK4MVjJIABgcLziTMTGSfB5
   I38LQQbWjWyM4pLzXoaohuvtJOZTHHQ+w6D9oj3ECcMxVr9RChSdRtzvW
   tTCit3nXSxXmQWguPWmPa5SqWbMfWyNT73f2RS+X10vMKt4p6g5jDgbUJ
   GTaLyRm8LcOu2oPpSPfNIVCTloWM06ZN4qGFJYlMcS8vN+DeDWLeb6OiW
   2nqVTV1QxYYEODBM8wXNoIAF0EwQ+X1w1NE1cjgt6ncE4/ROyyfFQkqN8
   4NAJr9wkGDq3CgMqMGjkonY4yEMqtY/q2twcaVtneBFa4l4l9VbkquZxM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="136591436"
X-IronPort-AV: E=Sophos;i="6.07,251,1708354800"; 
   d="scan'208";a="136591436"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 20:37:30 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id C6715D7708
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 20:37:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0BF2924FAB
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 20:37:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8E5602008BCDE
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 20:37:26 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id EC6DE1A0002;
	Fri,  3 May 2024 19:37:25 +0800 (CST)
Message-ID: <f9e1c047-192b-4d50-8588-5a90bfe7e96b@fujitsu.com>
Date: Fri, 3 May 2024 19:37:25 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
To: Alison Schofield <alison.schofield@intel.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
 <ZjFb7p4wn9bcUrzU@aschofie-mobl2>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <ZjFb7p4wn9bcUrzU@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28358.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28358.007
X-TMASE-Result: 10--8.932000-10.000000
X-TMASE-MatchedRID: 5U6uFEJz7+qPvrMjLFD6eHchRkqzj/bEC/ExpXrHizw0tugJQ9Wdwwvz
	nYJVXoOYa/8aZGNpfqY65m9meG/WS9fk7hbCEuNogvmNrsT46HIQARQHZYEjpND0fCJzqdHb1a9
	Gw6X1fIgreMjPCBtKqxPT4WWiXjYzIQPGoj5DOk5f2SdIdby5dcdvO1Rp+sgmqRTAHcwAECdm2e
	55IVZ1oM2JZjaQ73l9ZcW/i2O53DhdInhzedP5B1hRyidsElYkRYYm6fbhZvXRnp8Qx+pp65hj4
	4rNETuJIvrftAIhWmLy9zcRSkKate2aXYCZD9Vi3IFFT9wqfr19LQinZ4QefNQdB5NUNSsiDrBA
	jvbPhh50HSe131POnsZW5ai5WKlyS8vbBiSyYXmfus/r6APjpOYSCtCVlxicSPNjBqdf6x+OGgM
	3MsQ7s35uyI/OFesN886gGzbqib5WV8McR6Zfhr93LmVDgtT58wykF/dkuej3FzhuUqY+wb77j9
	TR8omKbFWdBw/YcNq7b6knBzvluw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/5/1 5:00, Alison Schofield 写道:
> On Wed, Apr 17, 2024 at 03:50:52PM +0800, Shiyang Ruan wrote:
>> The length of Physical Address in General Media Event Record/DRAM Event
>> Record is 64-bit, so the field mask should be defined as such length.
>> Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
>> mask off the upper-32-bits of DPA addresses. The cxl_poison event is
>> unaffected.
>>
>> If userspace was doing its own DPA-to-HPA translation this could lead to
>> incorrect page retirement decisions, but there is no known consumer
>> (like rasdaemon) of this event today.
>>
>> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
>> Cc: <stable@vger.kernel.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> Hi Ruan,
> 
> This fixup is important for the Event DPA->HPA translation work, so I
> grabbed it, updated it with most* of the review comments, and posted
> with that set. I expect you saw that in your mailbox.

Yes, I saw that.  Nice fix!

> 
> DaveJ queued it in a topic branch for 6.10 here:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.10/dpa-to-hpa
> 

That's good!

> *I did not create a common mask for events and poison because I wanted to
> limit the changes. If you'd like to make that change it would be welcomed.

Ok~


--
Thanks,
Ruan.

> 
> -- Alison
> 
>> ---
>>   drivers/cxl/core/trace.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index e5f13260fc52..cdfce932d5b1 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
>>    * DRAM Event Record
>>    * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>>    */
>> -#define CXL_DPA_FLAGS_MASK			0x3F
>> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>>   #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>>   
>>   #define CXL_DPA_VOLATILE			BIT(0)
>> -- 
>> 2.34.1
>>
