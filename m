Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A1481250;
	Tue, 25 Aug 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678106; cv=none; b=pIhe/afPFH54aANYrCAAy0rCGUvDV1EtaAWmaCq4lp1NXdIrAHOa/VDvyPImVCEMBlA6Ab2pmNCHKNMlqOr+vZCzdANpuC6DFdmD9pFM2lIN7tROztUtNtIpyCGes7MZTGz+y80mOt3No7uE4BkzjoLj3WPs02dM73BmN7/hCvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678106; c=relaxed/simple;
	bh=fHwpoEjqdHX1DqdCJcoF9AnKF67dGafWC6LnbXYJOnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZ82NeeJ6pRghiLu753Q7eaGOh3qO2fqqJQPmx6K9H79ogx7CKrbxVSQW0BSuYzQETXUiugR7dSWHsX04RZD6qd67XGRrp80Pdl3KBaqZVJv9gudRJZS29kH+DCGd+Hx1QSHUtAP7R+jxFPfHv61Yz5TZ797bmDgU8DZU5/Xh5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flv+sRie; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flv+sRie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787678105; x=1819214105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fHwpoEjqdHX1DqdCJcoF9AnKF67dGafWC6LnbXYJOnc=;
  b=flv+sRiefGH2oS/Xdau8/HJYAlxz9Ran+JUNMgVjQ0IYjCb7c4ToOVMA
   iWvk9QbU3aNTlEzjN9YZrsJVSzn9CMFs5AT+kmzlaOMW09m9xbS/CA5gQ
   vJKOGHsFQhiPJg7dF1A2sYoaHEQJdpljwFCRE5ebe7WERm6vCwE+IRS26
   cVZEhwYwNP7bChrKQ4vpJh4IVLflYpRO69pnDF126Au8tEREVekU14RS2
   6ZpRcyrGLPQ+ikCwnNzO4cM1J/fK+D3F0LCKVya/m3lFBL2z4+/iBYJ5T
   NL/iOtInxJiv98n+cLhiWdis1nEmNdAed0B/XLzym9sBUE+MhHUZ5xR3J
   w==;
X-CSE-ConnectionGUID: qyaXRZCDQHSt8Omwc42RvA==
X-CSE-MsgGUID: u7dRu+5BT6ihZkiHpZFXCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="105682809"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="105682809"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 10:15:04 -0700
X-CSE-ConnectionGUID: RXlx6rEkQ0y9/EYjVHLN1w==
X-CSE-MsgGUID: 4dfaT2/2T/iYSNUXMw2dTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264085050"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 10:15:02 -0700
Message-ID: <2333b4c6-9185-482f-a3de-3c59258717a8@intel.com>
Date: Tue, 25 Aug 2026 10:15:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] ACPI: extlog: Validate elog record length before
 walking sections
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, rafael@kernel.org,
 tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 xueshuai@linux.alibaba.com, terry.bowman@amd.com, benjamin.cheatham@amd.com,
 alison.schofield@intel.com, sashiko-bot@kernel.org
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-4-dave.jiang@intel.com>
 <20260824232804.7071d9fc@jic23-huawei>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260824232804.7071d9fc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/24/26 3:28 PM, Jonathan Cameron wrote:
> On Mon, 24 Aug 2026 10:49:26 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> extlog_print() copies a fixed ELOG_ENTRY_LEN (4096) bytes from the elog
>> record into elog_buf, then walks the sections using the firmware-controlled
>> data_length. Nothing keeps data_length inside the buffer, so a malformed
>> record walks the section pointer past elog_buf and reads adjacent memory.
>> Unlike the GHES paths, extlog never calls cper_estatus_check().
>>
>> Reject a record longer than ELOG_ENTRY_LEN and run cper_estatus_check()
>> before walking the sections. The length test alone is not enough: a wrapped
>> length reads back short and passes it, which cper_estatus_check() catches
>> via the header check added earlier. Drop a malformed record with
>> NOTIFY_DONE and without MCE_HANDLED_EXTLOG, since extlog did not consume
>> it.
>>
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=6
>> Fixes: f6ec01da40e4 ("ACPI: extlog: Handle multiple records")
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/acpi/acpi_extlog.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
>> index 7ad3b36013cc..9ad0052aa20c 100644
>> --- a/drivers/acpi/acpi_extlog.c
>> +++ b/drivers/acpi/acpi_extlog.c
>> @@ -208,6 +208,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>>  
>>  	tmp = (struct acpi_hest_generic_status *)elog_buf;
>>  
>> +	/* Keep the firmware-controlled data_length inside elog_buf. */
>> +	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
> 
> Why this order?  To me checking if we are in crazy world (overflow) before
> doing anything with the overflowed value makes more sense. So that would be swapping
> the two conditions.

Swapping it lets cper_estatus_check() walk the sections with data_length unbounded relative to elog_buf. elog_buf is a 4k buffer via kmalloc(ELOG_ENTRY_LEN). cper_estatus_check() iterates sections bounded by data_length, over a fixed kmalloc(ELOG_ENTRY_LEN) of 4096 bytes, reading gdata->revision at +20 and gdata->error_data_length at +24 each time. In the current order it only runs once cper_estatus_len() <= 4096 has passed, which caps data_length at 4076. Swapped, the only thing standing before the walk is cper_estatus_check_header(), and that admits data_length up to 4294967275.

Expand the comment to:

	/*
	 * Bound the length before cper_estatus_check() walks the sections: it
	 * iterates over data_length, which is not yet known to fit elog_buf.
	 * cper_estatus_check_header() then rejects a length that wrapped, which
	 * the bound cannot see.
	 */

DJ

> 
>> +		return NOTIFY_DONE;
>> +
>>  	if (!ras_userspace_consumers()) {
>>  		print_extlog_rcd(NULL, tmp, cpu);
>>  		goto out;
> 

