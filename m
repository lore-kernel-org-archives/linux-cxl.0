Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF543D5C15
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787871964; cv=none; b=ZZFNcAFGFspaj/5GvOO1CALxlqcE6cFzxevvKZBNn9UY8Jtrm2X0q/LdrkUYa3nCuAr0fZEF2r5MV50SomXYuYSES0bdZRi7Zfz/8WFZZv8X0z0r7Iiob36rn3J4etcp4Iv3fFj0u59sqFa9x0WxMBAeFCTeZgOJfEYPbWlJPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787871964; c=relaxed/simple;
	bh=T9VZ1sqSDvtVELw4/EF1x9yWIoZhfINoAxWNlNqAQMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdnVe6Yi4GSs4RaGIfD2azqV1rKkq4YG60SSg34gSqC/Kjk1oqLLBOYxUfddHuWlu0J0pZBJNNYexm43QmH4sfr4bxXv2OdvR4CsykmjugCPFaBguaE54ocENojhgqULq7J6aHtTBqlfNivcF04ASQQqh69Np1Z9B83/10g9DR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COgDpRLx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COgDpRLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787871963; x=1819407963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T9VZ1sqSDvtVELw4/EF1x9yWIoZhfINoAxWNlNqAQMQ=;
  b=COgDpRLxGLY+3ET4d+q8X7ks+laKUfIstFZOzuPOAONSPwJC/Rc6WdY3
   GA6KRPISmT93/1NpvtZRDAL6GX4Fs/1fqcgroTkRtFgbnrqIzW06toV9h
   qnxK0dtlqwIyxIuDa5hoyQEkOb/kZzjF5dz3ukVRzRRLmzEU/f6iTMUZ7
   s271Y/rvPhFrUUASkxlrBTkKGaulQnetvjEFZUhihrp3K1hzR7dF564IV
   JolnTk3RuZ0h6fIBudpT1h0p0rhZcMy+KkITr+xQBMezQ35UdipgH2/Bl
   8wSlsDsJW7a3fhx3gq8g84MwoFZmsAknM9kBkCOBEeN1fkcbsYG4CZ2tE
   Q==;
X-CSE-ConnectionGUID: 8riJ4xvXS4SIje0GckyIvA==
X-CSE-MsgGUID: FIpZQs8RQGiotvTX5VYP4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88587277"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="88587277"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 16:06:02 -0700
X-CSE-ConnectionGUID: MUFUtP+iQoCzJ8twxMDsag==
X-CSE-MsgGUID: Obn5HkUCRZGzefsw/sXWYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="271815736"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.124]) ([10.125.109.124])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 16:06:01 -0700
Message-ID: <58b33ede-e679-4251-bbc6-3af30c8edcbe@intel.com>
Date: Thu, 27 Aug 2026 16:06:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] ACPI: extlog: Avoid populating software AER
 metadata from raw hardware buffer
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20260827203726.3027541-1-dave.jiang@intel.com>
 <20260827203726.3027541-6-dave.jiang@intel.com>
 <20260827205837.468361F000E9@smtp.kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260827205837.468361F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/27/26 1:58 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Data loss of TLP Prefix Log / Extended Flit Log due to arbitrary payload truncation.

Yup. Will fix in v6.

DJ

> 
> Pre-existing issues:
> - [High] Out-of-bounds MMIO read and stack array bounds poisoning in `cxl_rch_get_aer_info()`.
> --
> 
> commit 99282f77735a9b69f6cccf74ca39147b80930bf8
> Author: Dave Jiang <dave.jiang@intel.com>
> ACPI: extlog: Avoid populating software AER metadata from raw hardware buffer
> 
> This commit addresses an issue in extlog_print_pcie() where casting the raw
> CPER aer_info buffer to a software struct populates software-only fields
> with raw hardware bytes. It copies only the leading registers and the
> Header Log DWORDs into a zeroed local struct to prevent out-of-bounds loop
> reads.
> 
> Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> 
>> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
>> --- a/drivers/acpi/acpi_extlog.c
>> +++ b/drivers/acpi/acpi_extlog.c
> [ ... ]
>> @@ -149,7 +149,17 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>>  		return;
>>  
>>  	aer_severity = cper_severity_to_aer(severity);
>> -	aer = (struct aer_capability_regs *)pcie_err->aer_info;
>> +
>> +	/*
>> +	 * struct pcie_tlp_log is larger than the hardware layout, so only the
>> +	 * leading registers and the four Header Log DWORDs of aer_info map onto
>> +	 * the struct. Copy that much and leave the rest zero, which covers the
>> +	 * software-only header_len and flit.
>> +	 */
>> +	memcpy(&aer_regs, pcie_err->aer_info,
>> +	       offsetof(struct aer_capability_regs, header_log) +
>> +	       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));
> 
> [Severity: Medium]
> Will this truncated copy result in the permanent loss of the TLP Prefix Log?
> 
> The CPER aer_info array contains a raw 96-byte snapshot of the hardware AER
> capability, with the TLP Prefix Log located at offset 0x38 (56 bytes). By
> truncating the memcpy to 44 bytes, the remainder of the CPER payload is
> ignored, which silently drops the hardware-provided TLP Prefix Logs or
> Extended Flit Logs during PCIe error handling.
> 
> Would it be better to explicitly extract the prefix log from offset 56 in
> the CPER record into aer_regs.header_log.prefix to avoid data loss?
> 
> [ ... ]
> 
> This isn't a bug introduced by this patch, but I noticed a similar 
> pre-existing AER software struct issue in drivers/cxl/core/ras_rch.c.
> 
> drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_info()
>> 	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>> 	u32 *aer_regs_buf = (u32 *)aer_regs;
>> 	int n;
>> ...
>> 	for (n = 0; n < read_cnt; n++)
>> 		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> 
> [Severity: High]
> Does this loop perform an out-of-bounds MMIO read by using the size of the
> software structure?
> 
> Using sizeof(struct aer_capability_regs) (104 bytes) instead of the actual
> hardware capability size directly maps MMIO data into software fields
> (header_len and flit at offset 84). Later, when pcie_print_tlp_log() runs,
> it uses the MMIO-poisoned header_len (which can be up to 255) as a loop
> bound over the 14-element stack array log->dw[]. This leads to a massive
> out-of-bounds stack read that can log arbitrary stack memory.
> 
> Additionally, in the same file:
> 
> drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_severity()
>> 		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>> 			*severity = AER_FATAL;
> 
> [Severity: High]
> Does this code misinterpret the flow control protocol error bit?
> 
> It tests the Root Error Status flag PCI_ERR_ROOT_FATAL_RCV (0x40) against
> the uncor_status register. In the uncor_status register context, 0x40
> actually represents PCI_ERR_UNC_FCP, meaning the severity is incorrectly
> computed.
> 

