Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8B17106D
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965103; cv=none; b=Q5mAFMQLgwoV5PAlPFwloXuNGAChpcuRB4zRLlUrp/q/tJtCfDB2aXj4ScyskO5NvYZ541r6CN3QY/Kb9CxiK3fnWm4JlaeW4kLKsyGFV8rM/nblXK4by4l+mYgs4XTYQoc52VghgLE/kTcUh7STS3bqtSEygxGJg3fGY8NFCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965103; c=relaxed/simple;
	bh=bDC+tKWoCb/DV/ywP3UArJCu2GL4AXjVXl71+53QbMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMAqmoQ8+2H5ec1F7Ue/V2dKgSEJFg8jZa7FpX2XWoes4UJjrSE6uHVl2F1/K+5HHxqq2JlT+YY1B5rijQIhplZObmUvZP9Hxp823WHg7viWJl7UNxmk+0ycozoWjNeicFpQeUTM3EG5F0q0tP4WpJ/XTH8VMuIp4Mywlk/JT54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Ta4c1mX1; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Ta4c1mX1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718965100; x=1750501100;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bDC+tKWoCb/DV/ywP3UArJCu2GL4AXjVXl71+53QbMk=;
  b=Ta4c1mX1dYxVGsqeNj7Aw+K5pVc6dA62slAcedxZKcsvWOf7Bl8XqjGu
   KEqHZTVJQgm4QD7Idv2c0/4PlMCsLz6NmqrtXvUC5Ww57yVoEOQqRYpY1
   nxCKHZwmL2Kr/A9P8e140SOfRl11ELM6MQtLGHZ32T/39xiKkq3HW/vaB
   mrWi9fqR2IEGu+QRzoXs/xejXHpoBtZhUS1zabndGC1AHZ8lhyIm4DrNL
   Y+JrSeiubp1KycN+4BaDDWEBP1/Iq3aMbCP4+TjHSjVoHKP2d2fc6Agn+
   LP9U1uuNNjOhJp6awoawUd6Lg8yW7wlnzLVbnODvSIG1zPhLPf/nYKWIU
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="151913838"
X-IronPort-AV: E=Sophos;i="6.08,254,1712588400"; 
   d="scan'208";a="151913838"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 19:18:12 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 015E7C68E4
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 19:18:10 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 46AE7D0ADD
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 19:18:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C5F6220088E9A
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 19:18:08 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 361FE1A0002;
	Fri, 21 Jun 2024 18:18:08 +0800 (CST)
Message-ID: <cc2236cf-ace2-498d-a0b3-2fbc9f7fc317@fujitsu.com>
Date: Fri, 21 Jun 2024 18:18:08 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: Dave Jiang <dave.jiang@intel.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <be14ee00-6d43-4db1-ad63-beac6aacb814@intel.com>
 <b9bbf3bc-9125-4cbb-b127-613b841dc9a8@fujitsu.com>
 <e6b3a936-9c45-4d34-bf7c-2b68e2ad79ae@intel.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <e6b3a936-9c45-4d34-bf7c-2b68e2ad79ae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28468.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28468.004
X-TMASE-Result: 10--20.375500-10.000000
X-TMASE-MatchedRID: sH5kboBHks6PvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYLBk
	jjdoOP1bp3Z/y3zTL9+zN6XcSN8uuHerlGbz8OXFolVO7uyOCDUXivwflisSrEJsNXD374+pO+W
	Rk1kOc5MCcJ+0x3yT8twnF1a+MpDfC5dVqsgzBjuOFfLQqF6P0tUEOicf335WUoV94zwLp3VJ9L
	43nm/22bqZhYf6F5ZElyW1ZrZx68b/awIuxLRW1EhwlOfYeSqxlDt5PQMgj00zAwv94MqCLh8aR
	hKglPt8mNVEdxRO2BKiQrGQ0QrIUcfdkIlEiI2knVTWWiNp+v9AApRfVHzqNN9RlPzeVuQQunqB
	IQj+1Jm8HpxVQnR8jFIgVt7sAjKWDOQhvAmAT8UDccazfMVOqLFcDzCo2ZtWmWGz8DF0pgYRRLf
	e6UPgvJ7xaTBl9U9ut1K/UeVR3qj3Pg7atDU0/Y61Z+HJnvsOiFg4TY5QPrAGWfDd0b0zMaPFjJ
	EFr+oloTCA5Efyn8C3ApS8cfJcZd0H8LFZNFG7JQhrLH5KSJ0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/6/20 23:51, Dave Jiang 写道:
> 
> 
> On 6/19/24 2:24 AM, Shiyang Ruan wrote:
>>
>>
>> 在 2024/6/19 7:35, Dave Jiang 写道:
>>>
>>>
>>> On 6/18/24 9:53 AM, Shiyang Ruan wrote:
>>>> Background:
>>>> Since CXL device is a memory device, while CPU consumes a poison page of
>>>> CXL device, it always triggers a MCE by interrupt (INT18), no matter
>>>> which-First path is configured.  This is the first report.  Then
>>>> currently, in FW-First path, the poison event is transferred according
>>>> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES
>>>>    -> CPER -> trace report.  This is the second one.  These two reports
>>>> are indicating the same poisoning page, which is the so-called "duplicate
>>>> report"[1].  And the memory_failure() handling I'm trying to add in
>>>> OS-First path could also be another duplicate report.
>>>>
>>>> Hope the flow below could make it easier to understand:
>>>> CPU accesses bad memory on CXL device, then
>>>>    -> MCE (INT18), *always* report (1)
>>>>    -> * FW-First (implemented now)
>>>>         -> CXL device -> FW
>>>>            -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>>>>       * OS-First (not implemented yet, I'm working on it)
>>>>         -> CXL device -> MSI
>>>>            -> OS:CXL driver -> memory_failure() (2.b)
>>>> so, the (1) and (2.a/b) are duplicated.
>>>>
>>>> (I didn't get response in my reply for [1] while I have to make patch to
>>>> solve this problem, so please correct me if my understanding is wrong.)
>>>>
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
>>
>> ...
>>
>>>> +
>>>> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
>>>> +{
>>>> +    struct cxl_contains_hpa_context ctx = {
>>>> +        .contains = false,
>>>> +        .hpa = hpa,
>>>> +    };
>>>> +    struct cxl_port *port;
>>>> +
>>>> +    port = cxlmd->endpoint;
>>>> +    if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
>>>
>>> Maybe no need to check is_cxl_endpoint() if the port is retrieved from cxlmd->endpoint.
>>
>> OK, I'll remove this.
>>
>>>
>>> Also, in order to use cxl_num_decoders_committed(), cxl_region_rwsem must be held. See the lockdep_assert_held() in the function. Maybe add a
>>> guard(cxl_regoin_rwsem);
>>> before the if statement above.
>>
>> Got it.  I didn't realize it before.  Will add it.
>>
>>
>> BTW, may I have your opinion on this proposal?  I'm not sure if the Background and problem described above are correct or not.  If not, it could lead me in the wrong direction.
> 
> Patch looks ok to me, but I'm no RAS expert in this area. Lets wait for comments from Jonathan and Dan.

Thanks!

--
Ruan.

>>
>> Thank you very much!
>>
>>
>> -- 
>> Ruan.
>>
>>>
>>> DJ
>>>
