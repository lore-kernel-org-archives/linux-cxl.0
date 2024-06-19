Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C248F7D07F
	for <linux-cxl@vger.kernel.org>; Wed, 19 Jun 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789075; cv=none; b=fJfW3uuJOKeQnghaqxy5VB03LjAyJu2WKsAhlGkBgSPpdA97M1l9uxTgq6k7hR2kU/+TSMDkPyVlEbbdYSPmHXWzyjAp0EqSvXZqTyupxN01E4cMF+wZ1livlI4QKuqYYzE5isLRjMRPweOGwZ4BD1sgZRMXbvkZC1h0F6KHPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789075; c=relaxed/simple;
	bh=P5qUMmTvxRhRm+xvXml4/gq2sDOAqp/7/NAm9NbVRRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkwypoWPXOtRgmpaVXn5qNMVUT9tFIMjPHrScjvq4yoz6voTLczKo7q/RfiY4UBK8DoBM12NyM4awtcNIGp+0yXM1XUlND6o+Ww0cACdUKd+R9AGEuGIHey89eyv+N2fgGQ8NfEymzfDnD48xBiTMs7NU+/V7OsyMHLnD7TzNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gm+dCSjl; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gm+dCSjl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718789073; x=1750325073;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P5qUMmTvxRhRm+xvXml4/gq2sDOAqp/7/NAm9NbVRRo=;
  b=gm+dCSjlJFIT6TkKC7otMpPAuHyoJkN02QZrVTvzTGF1Bn9hbQfiuXgb
   BolMrBGpoXiL3P38hkcZXkpBxap09wspt1HDQkAoIdHLs4WK7HKIUSi2V
   YU/yvNYeK9dRIViYJlazKyN5doPbtvaiUODVtMPS+mKF7KYaSLbx5CORE
   Y6bk4ocEZ8MFzJ3vzO9lA8oyNnp2FHgoUznIyGyKSd5SbwNz9u75AcbSq
   mREYhk5avFQpDNeZsv3sZDVctWY9pFPg8bzY881CpuQlqUxrzPxPGYeDc
   T0eU2/U4BEalfKyiovq4TIyjUx6/BgU/n+LFbZG5a2ORTAmCY82zWPxzp
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="163387116"
X-IronPort-AV: E=Sophos;i="6.08,250,1712588400"; 
   d="scan'208";a="163387116"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 18:24:25 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 06F7FD647A
	for <linux-cxl@vger.kernel.org>; Wed, 19 Jun 2024 18:24:22 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 28CEDD4BE9
	for <linux-cxl@vger.kernel.org>; Wed, 19 Jun 2024 18:24:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A2515E369F
	for <linux-cxl@vger.kernel.org>; Wed, 19 Jun 2024 18:24:15 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 840D11A0002;
	Wed, 19 Jun 2024 17:24:14 +0800 (CST)
Message-ID: <b9bbf3bc-9125-4cbb-b127-613b841dc9a8@fujitsu.com>
Date: Wed, 19 Jun 2024 17:24:14 +0800
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
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <be14ee00-6d43-4db1-ad63-beac6aacb814@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28462.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28462.006
X-TMASE-Result: 10--16.853000-10.000000
X-TMASE-MatchedRID: NuHz/06ZeuaPvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYLBk
	jjdoOP1bp3Z/y3zTL9+zN6XcSN8uuHerlGbz8OXFolVO7uyOCDUXivwflisSrEJsNXD374+pO+W
	Rk1kOc5MCcJ+0x3yT8twnF1a+MpDfC5dVqsgzBjuOFfLQqF6P0tUEOicf335WUoV94zwLp3VJ9L
	43nm/22bqZhYf6F5ZElyW1ZrZx68b/awIuxLRW1EhwlOfYeSqxlDt5PQMgj00zAwv94MqCLh8aR
	hKglPt8mNVEdxRO2BKiQrGQ0QrIUcfdkIlEiI2knVTWWiNp+v9AApRfVHzqNN9RlPzeVuQQunqB
	IQj+1Jm8HpxVQnR8jFIgVt7sAjKWDOQhvAmAT8UDccazfMVOqLFcDzCo2ZtWmWGz8DF0pgYRRLf
	e6UPgvOt2gGXLArR6zG7gfWFsstqR9GF2J2xqM4MbH85DUZXyudR/NJw2JHcNYpvo9xW+mI6HM5
	rqDwqtjBK61ITomYqktjwv041Qk/+6+AIb3vIoeBQZ5OZ7tJxxR93z5vKGpA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/6/19 7:35, Dave Jiang 写道:
> 
> 
> On 6/18/24 9:53 AM, Shiyang Ruan wrote:
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
>>
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

...

>> +
>> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
>> +{
>> +	struct cxl_contains_hpa_context ctx = {
>> +		.contains = false,
>> +		.hpa = hpa,
>> +	};
>> +	struct cxl_port *port;
>> +
>> +	port = cxlmd->endpoint;
>> +	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
> 
> Maybe no need to check is_cxl_endpoint() if the port is retrieved from cxlmd->endpoint.

OK, I'll remove this.

> 
> Also, in order to use cxl_num_decoders_committed(), cxl_region_rwsem must be held. See the lockdep_assert_held() in the function. Maybe add a
> guard(cxl_regoin_rwsem);
> before the if statement above.

Got it.  I didn't realize it before.  Will add it.


BTW, may I have your opinion on this proposal?  I'm not sure if the 
Background and problem described above are correct or not.  If not, it 
could lead me in the wrong direction.

Thank you very much!


--
Ruan.

> 
> DJ
> 
