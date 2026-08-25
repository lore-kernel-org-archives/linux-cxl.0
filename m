Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888033515E5;
	Tue, 25 Aug 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675498; cv=none; b=DQ7XpO6DXxbBM46UitsX3sCW6ghe2Hnt1cSSxVNqYaL4fy1nVCNNzlG4qjYVpSDxuIZuVCsOqDUQxF2uXBXaQ/WIGedE/WIduN6VFjt3lz2Ty+9QwBlO3G0HO49RAG0JsRUxzELQNBzr5ZPoVDmTCIm5XVpUDE7sGTk+gIOc/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675498; c=relaxed/simple;
	bh=dp+KW4f8+XPu+All9CHluvBCReWZ+TC7lcG0OTywihM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n82hv8xUwVrLk/GVPgMnmXEsQ1P5tK5FLqSlv+BNx6mem9C6iWbQWm+0C9MoZVS1L2y7L80HKdI9LnJn1C4bUK+jvFnGXpxOcGG0ncJhDlYu5XG1nndtKzPLYT+sKRERcLF+SLN4/j7UY83md5PktZlOsGjZcnKrjDN98GM4gDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeVGWzqV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeVGWzqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787675495; x=1819211495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dp+KW4f8+XPu+All9CHluvBCReWZ+TC7lcG0OTywihM=;
  b=aeVGWzqVPoeCBYccfqZfocDNtYXZ+9U70x2WkaIqDD2nOl4j5YVm1Toj
   jHwg+Xp/YBfIlWbvSEKIWxCs7IchfK11oiUH1WzgT5X4OqLgO2JMzjJCL
   EgzKH/pQYvSMOCpetJ1tzisxP69s55GumrJLb5dmjioyhKXurZ26QKTIu
   5YZmZHYCYh8sTW+DmcHDCqGcRmFE6Mf7veZyuqSycJWejScjRBocHz0yu
   nK3O+CJ0CndXl6nSmcWkwAfXeDtilJJ8I3R5DyxSL9Hxaz4o0scc+witI
   yU/Iq21RvOblnrViQTw9n3zxK6frVf+t+izr8fE3zbnzLdlhagLPiykxa
   A==;
X-CSE-ConnectionGUID: frG1NGs0Q3ibq1+y8nBFIg==
X-CSE-MsgGUID: PDRVug1wQ86NMyNVmVaKXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99672718"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99672718"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 09:31:33 -0700
X-CSE-ConnectionGUID: DcwmwOpvQsuo+93AAIqMNw==
X-CSE-MsgGUID: okcB3BlcS9KLlCBvWFpZkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="266026376"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 09:31:32 -0700
Message-ID: <5d86f754-c1ca-4a70-ad8e-a94b3c23ff4a@intel.com>
Date: Tue, 25 Aug 2026 09:31:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] efi/cper: Reject CPER records with an
 out-of-range error_data_length
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, rafael@kernel.org,
 tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 xueshuai@linux.alibaba.com, terry.bowman@amd.com, benjamin.cheatham@amd.com,
 alison.schofield@intel.com, sashiko-bot@kernel.org
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-2-dave.jiang@intel.com>
 <20260824225720.60a4fdcf@jic23-huawei>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260824225720.60a4fdcf@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/24/26 2:57 PM, Jonathan Cameron wrote:
> On Mon, 24 Aug 2026 10:49:24 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> cper_estatus_check() sizes each section with acpi_hest_get_record_size(),
>> which adds the firmware-controlled u32 error_data_length to the header size
>> as a signed int (see <acpi/ghes.h>). A value in the top sizeof(*gdata)
>> bytes of the u32 range wraps the sum small rather than large, so it slips
>> past the "record_size > data_len" check: against the 72-byte v300 header,
>> 0xffffffb9 sizes the record at 1 and acpi_hest_get_next() walks it a byte
>> at a time, off the end. 0xffffffb8 sizes it at 0 and loops forever.
>>
>> Sum in u64 so the check sees the real size, and reject a size the int
>> helpers cannot carry, since the walk advances by their return value.
>>
>> This is the per-section upper bound the later "len < sizeof(*foo)" guards
>> rely on; they are lower bounds only.
>>
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=1
>> Fixes: 45b14a4ffcc1 ("efi: cper: Fix possible out-of-bounds access")
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> I know I'm late to the discussion but maybe it would just be simpler to
> use check_add_overflow()?
> 
>> ---
>> v4:
>> - Do the arithmetic in u64 at the choke point instead of bounding the u32
>>   error_data_length against data_len, so the check no longer depends on the
>>   signed helpers in <acpi/ghes.h> behaving (Tony Luck). Bounding the u32
>>   still left a window when data_length itself was within a header of
>>   U32_MAX, and it did not stop acpi_hest_get_next() advancing by a wrapped
>>   int. The v3 "< 0" arm was dead either way, since data_len is unsigned and
>>   promoted the int back (Tony Luck, Shuai Xue).
>> - Dropped Alison's and Shuai's Reviewed-by; the check was reworked after
>>   they reviewed it.
>> ---
>>  drivers/firmware/efi/cper.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 06b4fdb59917..ec092729cacc 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -752,7 +752,7 @@ EXPORT_SYMBOL_GPL(cper_estatus_check_header);
>>  int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
>>  {
>>  	struct acpi_hest_generic_data *gdata;
>> -	unsigned int data_len, record_size;
>> +	unsigned int data_len;
>>  	int rc;
>>  
>>  	rc = cper_estatus_check_header(estatus);
>> @@ -762,11 +762,21 @@ int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
>>  	data_len = estatus->data_length;
>>  
>>  	apei_estatus_for_each_section(estatus, gdata) {
>> +		u64 record_size;
>> +
>>  		if (acpi_hest_get_size(gdata) > data_len)
>>  			return -EINVAL;
>>  
>> -		record_size = acpi_hest_get_record_size(gdata);
>> -		if (record_size > data_len)
>> +		/*
>> +		 * acpi_hest_get_record_size() sums these as a signed int (see
>> +		 * <acpi/ghes.h>), which wraps small for a huge
>> +		 * error_data_length and slips past the check below. Sum in u64,
>> +		 * and reject what those helpers cannot carry, since the walk
>> +		 * advances by their return value.
>> +		 */
>> +		record_size = (u64)acpi_hest_get_size(gdata) +
>> +			      gdata->error_data_length;
> 
> I'm late to the game obviously and what you have works but could this have
> used some explicit overflow checking?  Something like

Not late at all.

> 
> 		if (check_add_overflow(acpi_hest_get_size(gdata),
> 				       gdata->error_data_length, &record_size))
> 			return -EINVAL;
> 
> 		if (record_size > data_len)
> 			return -EINVAL;
> 
> That uses the compiler __builtin_add_overflow() which checks if the infinite
> precision result of the sum of the parameters would have wrapped when written
> to the output one.
> 
> I think you could then drop the earlier check as well as
> record_size is at least as big as acpi_hest_get_size() and we know there
> was no wrap around.
> 

Yup I'll do that.

DJ

> 	
>> +		if (record_size > data_len || record_size > INT_MAX)
>>  			return -EINVAL;
>>  
>>  		data_len -= record_size;
> 

