Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7828E34
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339869; cv=none; b=uNRPGNWNQ492EXnJhUF31id3znQ8GesMhoOadT3BL8TLgHuWaCfCdOL+ejQvtlAKuqlzE/gi5+Xk2EKEDKKFAb15g640+AsvxcVmDXtzzaBfFeWhEFsdkWcLVVNXvZvBBM7O9QEbG7nxOxUvdvy9ToIW6kcsIHC5gehD5WDYiNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339869; c=relaxed/simple;
	bh=d8UmbUuuAGN5pgeVGQcwfJ3D8MXc0ov8Q4oLVueaUlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WG7xq73uriv2OtiU/SWbaR/XGqQ58jGCabrDkuCaqxyPbN3WleMKN5XwwOzGapmk0OWn5HK/TReXfcLcbrDa05oeaCb0D0cA35O9Fy2wvYxORvDvi30jXGAmiATc8l6d7hYQ3ck/ucxS1jjYgM/3WHdMVjsIYhZhALUiyfmOeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=T/HiowTo; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="T/HiowTo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1708339866; x=1739875866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d8UmbUuuAGN5pgeVGQcwfJ3D8MXc0ov8Q4oLVueaUlA=;
  b=T/HiowToBZYz/RuxWw5AesnOfR0RxyYEhOvwPmSsqeiN2rRXx3l5cuyk
   kFXQDOmvNmVmMD+TvDD2JRnJ4+Oqhd0Bl5/tHxEN/e+TH6Zie4ZGsjEsh
   5EpMED8WhVTD1tJBYaZ1j7MhKxybhpJUe5iYdpaw3K+G4U6o8/VTGHY/8
   UyT3ZVsM4W8pq4dOVgsnwcGnabSe6d6kAtW6dwIgbAVafSDdObwzmwMMg
   VXZBHb2r/xvvdfTjWF4ZuiQCUuyc9T4LjPEKjiWd7fZIFlAise8THJV8A
   CQ3vW1z77IC0+0jHmxo9aVu2IxmjGrqrwCDWVSCkn7Rw6jkiDADGzW0i3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="129075954"
X-IronPort-AV: E=Sophos;i="6.06,170,1705330800"; 
   d="scan'208";a="129075954"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 19:49:54 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id CDC2D176140
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 19:49:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 226BAF3165
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 19:49:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E59B20097788
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 19:49:51 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E91D71A006B;
	Mon, 19 Feb 2024 18:49:50 +0800 (CST)
Message-ID: <92d66f47-3b03-4128-8243-68f917c692f0@fujitsu.com>
Date: Mon, 19 Feb 2024 18:49:50 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] cxl/core: correct length of DPA field masks
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan.Cameron@huawei.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-4-ruansy.fnst@fujitsu.com>
 <65c718f786340_d2d4294b9@dwillia2-xfh.jf.intel.com.notmuch>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <65c718f786340_d2d4294b9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28200.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28200.006
X-TMASE-Result: 10--10.905100-10.000000
X-TMASE-MatchedRID: X+fKKgQJwrGPvrMjLFD6eCkMR2LAnMRp2q80vLACqaeqvcIF1TcLYLBk
	jjdoOP1bZ7SNREHYHRG4TDy5Lbm+t/RseJdyxL18Be3KRVyu+k2RgLeuORRdEsC5DTEMxpeQfiq
	1gj2xET/lxQMqjyUzSdgNg9jbo12SkfRhdidsajODGx/OQ1GV8rnUfzScNiR3DWKb6PcVvpiOhz
	Oa6g8KrRSQKMCB3VoeerNzoMmBWtUITClHxqpMBkVnRUzyyyjj3z7RgXDPuz8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/2/10 14:34, Dan Williams 写道:
> Shiyang Ruan wrote:
>> The length of Physical Address in General Media Event Record/DRAM Event
>> Record is 64-bit, so the field mask should be defined as such length.
> 
> Can you include this user visible side-effect of this change. Looks like
> this could cause usages of CXL_DPA_FLAGS_MASK to return an incorrect
> result?

Ok.  Will change it to this:

The length of Physical Address in General Media Event Record/DRAM Event 
Record is 64bit, per CXL Spec r3.0 - 8.2.9.2.1.1, Table 8-43.  Currently 
CXL_DPA_FLAGS_MASK is defined as int (32bit), then CXL_DPA_MASK is a int 
too, it will be 0x00000000FFFFFFC0 while using "->dpa & CXL_DPA_MASK" to 
obtain real physical address (to drop flags in lower bits), in this case 
the higher 32bit of ->dpa will be lost.

To avoid this, define CXL_DPA_FLAGS_MASK as 64bit: 0x3FULL.


--
Thanks,
Ruan.

> 
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/cxl/core/trace.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index 89445435303a..388a87d972c2 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -253,11 +253,11 @@ TRACE_EVENT(cxl_generic_event,
>>    * DRAM Event Record
>>    * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>>    */
>> -#define CXL_DPA_FLAGS_MASK			0x3F
>> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>>   #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>>   
>> -#define CXL_DPA_VOLATILE			BIT(0)
>> -#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
>> +#define CXL_DPA_VOLATILE			BIT_ULL(0)
>> +#define CXL_DPA_NOT_REPAIRABLE			BIT_ULL(1)
>>   #define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
>>   	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
>>   	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
>> -- 
>> 2.34.1
>>
> 
> 
