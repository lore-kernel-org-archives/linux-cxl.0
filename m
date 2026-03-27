Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F153B9DA6
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618040; cv=none; b=qsfkzOr1MZCJJx8xf+z2eHtqqHZlSBjX/AZkQClKQ35jjoiLgFFcHzWghZMOyUo8Bg1rshU+nayI2sDMpF0r7d4ZkWornX1WGBTc1cQK4W4PGbBrbLASnA/gl/ZgZGzqHe9TZRteglN7btvUK9bot32OGFxpx8dIz7wV3NUHIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618040; c=relaxed/simple;
	bh=Fs0Zu7BzfWMWvpZrZXXWwl+h8mly81mWY39/A/0JgvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGzBcpZjnsPP7zpPQfWcoUD0v07YIGqQw/1NCcF1i1IGeQkYU/YH9kSko0eRxbZIGDRIAAnsb0RfEcdSp5O1anWfCWx9KL55Q6TTFc19goKTRotnk6rQPeQIkIrivXr+6XKr95HSErBHedqyQ/z64zKgGuv2dqCrkygRGjH6V2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=CStHXI48; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="CStHXI48"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 94DAE2C2C29
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 13:27:11 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6F04BC00074;
	Fri, 27 Mar 2026 13:27:03 +0000 (UTC)
Received: from [192.168.101.118] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 5B52B13C2B0;
	Fri, 27 Mar 2026 06:27:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5B52B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1774618021;
	bh=Fs0Zu7BzfWMWvpZrZXXWwl+h8mly81mWY39/A/0JgvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CStHXI48c1pYryKQT+XchvE5RhxVqCi9op+kSQc7t4lFY6+4toNLDD2gyniI5rBkD
	 SZtokn6jaB9zesgTiFSnsuCDLyYeGlh/lbBn2uJtxTXvOwBv1pJer7kl7MeRf5/AKW
	 p01tRyeI86ODH61GiPEMnBknhqeuLwXqSLa7aPBo=
Message-ID: <7e8a5d33-9b5e-41a1-b431-afa8c63d2ee4@candelatech.com>
Date: Fri, 27 Mar 2026 06:27:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Add CXL_PMEM as dependency for CXL_ACPI
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20260326211441.83573-2-dylan.eskew@candelatech.com>
 <594e2663-06ff-44c4-8420-f00b788290cc@intel.com>
Content-Language: en-US
From: "Dylan E." <dylan.eskew@candelatech.com>
In-Reply-To: <594e2663-06ff-44c4-8420-f00b788290cc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1774618024-mOqQIxMBP4CZ
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1774618024;mOqQIxMBP4CZ;<dylan.eskew@candelatech.com>;12862f54078ff5ce47578406b6d80bf8
X-PPE-TRUSTED: V=1;DIR=OUT;

> On 3/26/26 2:14 PM, dylan.eskew@candelatech.com wrote:
>> From: Dylan Eskew <dylan.eskew@candelatech.com>
>>
>> Prevent a linking issue against CXL_PMEM when CXL_ACPI is configured in
>> Kconfig.
>>
>> Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
> Hi Dylan, does this commit fixes your issue? It's in Linus's tree now.
> 93d0fcdddc9e ("cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate mismatch")

Hi Dave,

This looks to fix it, thanks! I was sitting at -rc5 not thinking there 
was anything farther up the tree.

>> ---
>>   drivers/cxl/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 48b7314afdb8..baf1d17ec0fc 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -58,6 +58,7 @@ config CXL_ACPI
>>   	tristate "CXL ACPI: Platform Support"
>>   	depends on ACPI
>>   	depends on ACPI_NUMA
>> +	depends on CXL_PMEM
>>   	default CXL_BUS
>>   	select ACPI_TABLE_LIB
>>   	select ACPI_HMAT
