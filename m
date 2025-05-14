Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514B8F4ED
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747236169; cv=none; b=R47e+hEtE5kAGjAoMyTzODO2o0AWu6S7JR/nLz3YbSTru98QQ65FYyZQAB0eunjd/Gsdrhowuf67SSOhfYuYfX68V+aealESeMSVF4VhkjcoH4HFmy0sTMva15EgRPoElNRpqg+4P1V6Cb3TAnW3BCF0H01eHqH1lT7Bsu7P4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747236169; c=relaxed/simple;
	bh=IdXTiW+D2B/rG1YZVMcTrW9ArM0YeTWx6mEJheoRiPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEhfV6UVTb5+HwcgyEdBvjd/k0UnG0v7NYzvoypMSuFMkDrLzi1ci47bkDllk2xOoh3whLcFZOL0G6xAXF+pYtyqeCoaDgEk0hMn2+I+W5tI5SSuGEVzQ3J+wRSBAAXEacRvygglTJThN4+3xCEhV9XN+SsGvJB6Bu3kr8jj+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PE9aJ2s/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PE9aJ2s/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747236169; x=1778772169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IdXTiW+D2B/rG1YZVMcTrW9ArM0YeTWx6mEJheoRiPw=;
  b=PE9aJ2s/hd/Oycf43NqsEjfuwwI4VTgqhyeceXy3PLfVZGrK/pb1z8L4
   +tRvxiJESyJAYccbXTzyF7zDbdMJ8FZUVpkllB/WcCIBAHJw7KKTEsWKz
   Q9cwhS8zcrnwyZJfsHpUBMbEpYMErGQR2VM/tioUvBsY6HuNgfvy8ApgU
   LYI9/Werr+rmMu/V3X8aCkry6f1ebFGVqPa5Ha0C8j3t8tRmcBMuE0Rrs
   oww9zV+Niov8kqzj5ZijjNQSSx42Fbhf6vf1QJWINOW1q25TLDI658Aqe
   bLQPPZRyh+P1ktYRBbTbztMLDVyUPaSYkZ5hvrOeWURO+fa8q2XF+8oOK
   g==;
X-CSE-ConnectionGUID: yHHqLn1pTXaDtzUd9gIWig==
X-CSE-MsgGUID: U2jOxmbFSX2FuRVClFEOGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49011305"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49011305"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:22:48 -0700
X-CSE-ConnectionGUID: VzOGaLi7RsSGtID4mfaGUw==
X-CSE-MsgGUID: uXEtH4P3Q8+X3yWMVYqhBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="138989633"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.25]) ([10.125.109.25])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:22:48 -0700
Message-ID: <4a71537f-9c98-49fa-ae34-227353bea25f@intel.com>
Date: Wed, 14 May 2025 08:22:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cxl: docs/platform/acpi/srat fix memory table
 misalignment
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250514003133.584401-1-dave.jiang@intel.com>
 <20250514003133.584401-3-dave.jiang@intel.com>
 <aCP0oeBo--WC6qV-@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aCP0oeBo--WC6qV-@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/25 6:40 PM, Gregory Price wrote:
> On Tue, May 13, 2025 at 05:31:31PM -0700, Dave Jiang wrote:
>> Fix the misalignment in the SRAT table example.
>>
> 
> This misalignment was intentional, but i don't have a strong feeling
> either way. 
> 
> (This is how it comes out of iasl -d)

I can drop it. It just looks weird in documentation. :)

> 
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  Documentation/driver-api/cxl/platform/acpi/srat.rst | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/driver-api/cxl/platform/acpi/srat.rst b/Documentation/driver-api/cxl/platform/acpi/srat.rst
>> index 56d7bbb18c3b..cc7687645de7 100644
>> --- a/Documentation/driver-api/cxl/platform/acpi/srat.rst
>> +++ b/Documentation/driver-api/cxl/platform/acpi/srat.rst
>> @@ -39,6 +39,6 @@ Example ::
>>          Address Length : 0000003CA0000000
>>               Reserved2 : 00000000
>>   Flags (decoded below) : 0000000B
>> -              Enabled : 1
>> -        Hot Pluggable : 1
>> -         Non-Volatile : 0
>> +               Enabled : 1
>> +         Hot Pluggable : 1
>> +          Non-Volatile : 0
>> -- 
>> 2.49.0
>>

