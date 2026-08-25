Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6D360EE1;
	Tue, 25 Aug 2026 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679511; cv=none; b=cCrVgu8QBTtTwkcKVcntZGV3U/IA1oEz+XWDd7gIm0yRwGV83OuzFxMEpRu8wgKFkZjQscv6WiZmcjjwDkaVLSL7O4W7fVk3kh2doPKxvc3BMBI1pjEZHNrDpBTuiLUNb9BqmbVJ+0WhI4NXkAoRTblNq2Izj5EaPSU9JeHHDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679511; c=relaxed/simple;
	bh=q9NGIV0CrgWhJ8R+7EF3vkJV4NkhkTugigu6RtuqG6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU1lQWCra+qZdCh6jseTKLd+Jo5XQIUc7wK4mYXBbz/9l+mQVfNlebKPHDDHR3kDFg/ZM5zbwur0msBPmEntYYZGStRXAMJEyZTtNr/LPeK/c/oVWC77Y3YxOzXOPRG74J9SRRR2MVEwjDuXzqhgZ9m/xvumqfpkLYc39ocYLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbYK/htB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbYK/htB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787679509; x=1819215509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q9NGIV0CrgWhJ8R+7EF3vkJV4NkhkTugigu6RtuqG6o=;
  b=BbYK/htBlQ3PfBFIE4pdZxkAgqcXgtJQOm/YZbtTETOehSO+8FnlyVXT
   hbT3fugmWnpSOHTS9t9FfaA/SabhdwX3ciyD6LFTXGWZU6p7IvQE7YH9n
   aJTCaemPKnCUSx8Z/fmISmcqasfpxS2zvff4Jw04TtUaWTTudRkZefy1B
   8+chznPjq58lCTibpjnFmIP77P73oxIZ/JatysEt5HQhYhsH9bdxemYH9
   +HkmvGvs0Ct+iqsMWBklqBQ5WUsOCb3rrX8IllXRAWteRBmoTBuy935Mi
   uKUFGXIgXoNSwGnBrvieaeBR1HqpQ6TDazVodw4BBXTnHRMk4znCe3R2E
   w==;
X-CSE-ConnectionGUID: L6zRukCiR9GEVWeMkH5MsQ==
X-CSE-MsgGUID: kDH8o1WjRJqbS2vXxrdXaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99679114"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99679114"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 10:38:25 -0700
X-CSE-ConnectionGUID: nMac/ka+SjSa7F3kfg7+Fw==
X-CSE-MsgGUID: DFX0qidyQTy/e6EZlsM4Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="264722200"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 10:38:24 -0700
Message-ID: <9c2ab3b9-02c3-44f2-878c-8e7f5b91bd3c@intel.com>
Date: Tue, 25 Aug 2026 10:38:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] ACPI: extlog: Avoid populating software AER
 metadata from raw hardware buffer
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, rafael@kernel.org,
 tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 xueshuai@linux.alibaba.com, terry.bowman@amd.com, benjamin.cheatham@amd.com,
 alison.schofield@intel.com, sashiko-bot@kernel.org
References: <20260824174936.939059-1-dave.jiang@intel.com>
 <20260824174936.939059-6-dave.jiang@intel.com>
 <20260825000523.3ab0d33d@jic23-huawei>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260825000523.3ab0d33d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/24/26 4:05 PM, Jonathan Cameron wrote:
> On Mon, 24 Aug 2026 10:49:28 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> extlog_print_pcie() casts pcie_err->aer_info straight to struct
>> aer_capability_regs *. That struct embeds struct pcie_tlp_log, whose
>> software-only header_len and flit fields sit at offset 84 - inside the
>> 96-byte aer_info buffer - so the cast fills them with raw firmware bytes.
>> pcie_print_tlp_log() uses both to bound a loop over dw[], and a large
>> header_len walks past the end of the array.
>>
>> Copy aer_info into a zeroed local struct aer_capability_regs and clear
>> header_len and flit before passing it on.
> 
> The existing code is very odd. It might be nice to clean it up more
> generally so that we can handle the rest of the aer_info buffer
> via a definition that matches the hardware spec. 
> 
> For now I'd be tempted to just copy the bit of the structure that
> is matching the spec - side effect being the rest ends up as zero
> including the two things you clear.
> 
> So just copy to first 4 dw of the header log. 

Ok will do.

> 
> Jonathan
> 
> 
> 
>>
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
>> Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Assisted-by: Claude:claude-sonnet-4-6
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v4:
>> - Dropped the now-pointless aer pointer alias.
>> ---
>>  drivers/acpi/acpi_extlog.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
>> index f6e3da4e13e7..6d5532ec0920 100644
>> --- a/drivers/acpi/acpi_extlog.c
>> +++ b/drivers/acpi/acpi_extlog.c
>> @@ -137,7 +137,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>>  			      int severity)
>>  {
>>  #ifdef ACPI_APEI_PCIEAER
>> -	struct aer_capability_regs *aer;
>> +	struct aer_capability_regs aer_regs = {};
>>  	struct pci_dev *pdev;
>>  	unsigned int devfn;
>>  	unsigned int bus;
>> @@ -149,7 +149,11 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>>  		return;
>>  
>>  	aer_severity = cper_severity_to_aer(severity);
>> -	aer = (struct aer_capability_regs *)pcie_err->aer_info;
>> +
>> +	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
>> +	aer_regs.header_log.header_len = 0;
>> +	aer_regs.header_log.flit = false;
>> +
>>  	domain = pcie_err->device_id.segment;
>>  	bus = pcie_err->device_id.bus;
>>  	devfn = PCI_DEVFN(pcie_err->device_id.device,
>> @@ -158,7 +162,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>>  	if (!pdev)
>>  		return;
>>  
>> -	pci_print_aer(pdev, aer_severity, aer);
>> +	pci_print_aer(pdev, aer_severity, &aer_regs);
>>  	pci_dev_put(pdev);
>>  #endif
>>  }
> 

