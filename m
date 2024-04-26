Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44121200D2
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162417; cv=none; b=Y5oIKXIdWvZGgsybCfS+VY3fwDIRKl7U9GhtAuI6z83Wl0brZWTAGACV3Np0mHNrfly0yd3CgN6a+J9NN1jUEmG/PuxLOY3o2aCdmJw+AGuxH4GzOW1HQNwmPuw5o23TtaecXGRh2Ls/YyR7KnfO/LGyH8D1zGdYRQdy4+NVloQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162417; c=relaxed/simple;
	bh=t/l04ERXNrTEzcWWeuoMyoIhbsSB4VeFGqOS98b8ft8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIUWfE7RZarTYuniqX987u3+gRLqDi8QaU73TWYhNZ8X4rOB4rX16vfmz6hTjqTFLnDdgHFxXN848qHtuUAlH3G2ikt7Ch0Ax/x7htjenDcmmg+mARJ7W7/+HLtf0mt/RJck/Dt664LptelZLjEM2FOTTsg/ER30fQK1A0xOTxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJZh/da1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJZh/da1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714162416; x=1745698416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t/l04ERXNrTEzcWWeuoMyoIhbsSB4VeFGqOS98b8ft8=;
  b=WJZh/da1o2HmUncuORCdLR1Qrsmwn3nPP1hdf1M5Vjw8zHCy+u8J1D1X
   a+UoJOV6o4wwGzxIwbk15wNgYr1z7kznHid4cHeeM0U+zhx0ZCf1h6ulN
   0GKdPKZxyQT+U70N73V+PYoIGZBTZKWSAquXjqLv+KNtSoPzjgd0T00zQ
   apr9k+xwP1X9d2fdvxO/S6RhuNSBOoYTAC5nARcfKqwe3Eclq8p0gS7UG
   teyQfqWOPHS4wp+/N9dIDinrDQ4ykQMF5c/9Yb8TUze3VA2LjMpi2UO05
   78pkmNFSNLuIBohwv2TlrO5FyDGowbofIBRhpsOK+Z9IHg5qc6V0H5OOS
   w==;
X-CSE-ConnectionGUID: CSstdixDSoWKHRBUjvQBBA==
X-CSE-MsgGUID: N8MyCXQtQcmTb+wV8MCuSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10444105"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10444105"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 13:13:35 -0700
X-CSE-ConnectionGUID: KarIw7d6SqqIFUgNqb1s6g==
X-CSE-MsgGUID: IsWH4aM9SWCCKNpbOtRBPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="63002354"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.33.42]) ([10.212.33.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 13:13:34 -0700
Message-ID: <4fe3d95a-54cd-40ab-9cdd-b7417d38e75f@intel.com>
Date: Fri, 26 Apr 2024 13:13:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] cxl: Remove checking of iter in
 cxl_endpoint_get_perf_coordinates()
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240403154844.3403859-1-dave.jiang@intel.com>
 <20240403154844.3403859-2-dave.jiang@intel.com>
 <Ziv8GfSMSbvlBB0h@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Ziv8GfSMSbvlBB0h@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/24 12:10 PM, Robert Richter wrote:
> On 03.04.24 08:47:12, Dave Jiang wrote:
>> The while() loop in cxl_endpoint_get_perf_coordinates() checks to see if
>> 'iter' is valid as part of the condition breaking out of the loop.
>> is_cxl_root() will stop the loop before the next iteration could go NULL.
>> Remove the iter check.
>>
>> The presence of the iter or removing the iter does not impact the behavior
>> of the code. This is a code clean up and not a bug fix.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/port.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 2b0cab556072..6cbde50a742b 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -2197,7 +2197,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>  	 * port each iteration. If the parent is cxl root then there is
>>  	 * nothing to gather.
>>  	 */
>> -	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
>> +	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
> 
> I am seeing the following mainline after [1]:
> 
>  [   39.815379] cxl_acpi ACPI0017:00: not a cxl_port device
>  [   39.827123] WARNING: CPU: 46 PID: 1754 at drivers/cxl/core/port.c:592 to_cxl_port+0x56/0x70 [cxl_core]
> 
> ... plus some related subsequent NULL pointer dereference:
> 
>  [   40.718708] BUG: kernel NULL pointer dereference, address: 00000000000002d8
> 
> This changes looks related. I am going to dig deeper here but just a
> headsup in advance.
> 
> Note this is tested on an RCH topology.

Hi Robert,
Can you please provide the 'ls -l /sys/bus/cxl/devices/$memX' of the RCH device? Maybe the iterator may need to be tweaked for RCH topology support.

> 
> Thanks,
> 
> -Robert
> 
> [1] commit 586b5dfb51b9 ("Merge tag 'cxl-fixes-6.9-rc4' of
>     git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl"):
> 
>>  		cxl_coordinates_combine(&c, &c, &dport->sw_coord);
>>  		c.write_latency += dport->link_latency;
>>  		c.read_latency += dport->link_latency;
>> -- 
>> 2.44.0
>>
> 
