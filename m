Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182E21B8E0
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 03:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713323; cv=none; b=UeIzFWHc+iftDC1Zj2Y1FYrJlje6FGuRuWKdlc6D/XJdfJDI9bUE25pA+jRtaccYpRu8dsMfJ1jqsnNb2+NRd74AF4iliKqE8HQAbCAVkGqkksr5xgV/eIRzzgNdSmXesHAa9sNKVU5j58Kfg2ePWFopLQvv+5Zpz9ZUjxfVHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713323; c=relaxed/simple;
	bh=8Mvcim+aFINZSgDmb2fCLSlpZ3cnd8Yzlx+bS5idMsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgNUhfpzJYkkqHKpfrvjbfYpsmPpR7PF6LlTVVI/RY2nojrScCnL0ox9MKmHdVcVnXzneVN4wgrlrNj7lvuf7zI7StCFyXLjCDsGwMA/gd6i99YwR0dmXI6/htibiPHm7zPilV12VKcWey5A1wqO0ANKiASvqgvrNGSJLpToDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=H1HDr/vL; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="H1HDr/vL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1747713322; x=1779249322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Mvcim+aFINZSgDmb2fCLSlpZ3cnd8Yzlx+bS5idMsQ=;
  b=H1HDr/vLsZ4P2iUy9dqRGbbng8KkLQRwbCGFKc2VFEAVubBWAVpuEe5/
   2EmI1jK9dPBc/K+3rT+HAp85qPOjz8TWt49lQdvEAImlHcWiRJOd3qMFf
   bFCGoDjN+zR/J9wr4qc/AEbFfnN70+hjSo3lSBI5ORIIYKsPiqotfv3yB
   M3prkH2HQU7l/ROQDEVscOpt9bnEYIPNeBT77m4fZsLRBDNAuHKeLNKSo
   RzciStPXuWAnGK+sUcietXJa/E/JTh6u/lAkaTs/pFwjAnqFcjo+h/4TO
   YSThXqdqjBsGan/KsxQfBL0+AG2OZ2cLME2IooI+Vt1F4qwSua66mLmQd
   A==;
X-CSE-ConnectionGUID: cxobiTK4Qx2Oo1oe2n1s3A==
X-CSE-MsgGUID: 8uePF0mySmGA5FgdNLHCmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="178888655"
X-IronPort-AV: E=Sophos;i="6.15,302,1739804400"; 
   d="scan'208";a="178888655"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 12:54:10 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8FC2AD4C31
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 12:54:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 51E89D8AE5
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 12:54:08 +0900 (JST)
Received: from [192.168.22.105] (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 54DBF1A0071;
	Tue, 20 May 2025 11:54:07 +0800 (CST)
Message-ID: <741d99d9-4a42-4ce1-aca5-1112f7f39229@fujitsu.com>
Date: Tue, 20 May 2025 11:54:07 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/cxl-xor-region.sh: remove redundant waitting
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, sunfishho12@gmail.com, nvdimm@lists.linux.dev
References: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
 <aCev83lpHZlsYV1d@aschofie-mobl2.lan>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <aCev83lpHZlsYV1d@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/17 5:36, Alison Schofield 写道:
> On Wed, May 14, 2025 at 07:20:03PM +0800, ruansy.fnst wrote:
>> From: Ruan Shiyang <ruansy.fnst@fujitsu.com>
>>
>> Now that cxl_wait_probe() has been added[1] to wait for udev queue
>> empty, the `udevadm settle` here is no longer necessary.
>>
>> [1] b231603 cxl/lib: Add cxl_wait_probe()
>>
>> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> Hi Ruan, It looks like I snuck this one in right before Dan introduced
> udevadm settle and cleaned up all the usages. I'll take this patch as
> is. The next time you patch ndctl, do these:
> 
> [PATCH] --> [ndctl PATCH]
> Send to nvdimm@lists.linux.dev and 'cc linux-cxl@vger.kernel.org
> if it's CXL related like this one.

OK, got it.  I'll add 'ndctl' tag and cc nvdimm&cxl ml next time. 
Thanks for pointing out.

> 
> I suggest you resend this udev question in a new email to linux-cxl
> list to draw attention.

OK.  The lucky thing is that they have noticed this and started discussion.

> 
> Thanks for the patch!

--
Thanks,
Ruan.

> 
>>
>> ===
>> Question to Dan:
>>
>> I understand how cxl_wait_probe() work, but I have some questions about
>> the motivation of adding this function:  Firstly, is it function added
>> for simply waiting for new added CXL device been ready before cxl
>> command does the actual work?  Just for replacing `udevadm settle`'s
>> work?
>>
>> Now I am facing a problem that cxl command takes a long time to complete
>> when I run it in a udev rule(do some configuration when CXL memdev is
>> added).  I found it is caused by this function: waitting for udev
>> queue's endding but itself is in the queue.  The cxl_wait_probe()
>> function does not seem to allow me to do that.  So, the 2nd question is:
>> is it against the spec to run cxl command in a udev rule?
>> ====
>> ---
>>   test/cxl-xor-region.sh | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/test/cxl-xor-region.sh b/test/cxl-xor-region.sh
>> index b9e1d79..fb4f9a0 100644
>> --- a/test/cxl-xor-region.sh
>> +++ b/test/cxl-xor-region.sh
>> @@ -14,7 +14,6 @@ check_prereq "jq"
>>   
>>   modprobe -r cxl_test
>>   modprobe cxl_test interleave_arithmetic=1
>> -udevadm settle
>>   rc=1
>>   
>>   # THEORY OF OPERATION: Create x1,2,3,4 regions to exercise the XOR math
>> -- 
>> 2.43.0
>>
>>
