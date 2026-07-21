Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB23845D8;
	Tue, 21 Jul 2026 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646417; cv=none; b=qKzlhtUiassjKhB6pxx7OJdI4jiL0jUblSbupKrUWDqCALIjiBnzkPaohrWIW76nwPMUm/iKbNczcY9G3osuRWKPPwmAU///UJwfdTXQTUafkcaAu8AbK9TxYmLc9tPDUiPpfAgf2hYMwmfaQ36s7yYpmY+hqq0b27aXhOh/oGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646417; c=relaxed/simple;
	bh=CcvUIeqigSygCGtNOPb8sVT8Pr2fc6JEh3pu7NYqG4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCte8o2bWbuz2lv7uQX05/oG5sll0iTskjDlqdcSn4NGE2gjSFchqAI6eEG98gOryjIw9COXemKp1oUKSEU0yzhj1sSz95r002ThxLCzUS+a0wjhP5V45SZg1/tPfcZGArzNVLm1AfGgsL89Lew6sn2EqVFoC3MnkCUmej8v1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fny3PYZG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fny3PYZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784646416; x=1816182416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CcvUIeqigSygCGtNOPb8sVT8Pr2fc6JEh3pu7NYqG4o=;
  b=Fny3PYZGqr2g5S9sBP5GDp7JrOnQjT5l9FhgvmATm5C6a9SRObTfCSkC
   1o6dM9OQtko69ajfcauyDjBJ49KIuhv0sjAQWRJhnKfX/cEYeuVxStVe6
   +TWdxqS+3hW6V/6mXoWEcOMd36yQ/gioZyowBc3kSA+WwQmBMSFlt1L+I
   e7FEBz8sAm/Aozv5aq+EzmWDaIohesfzhutj0nF1fZLIgmfTw+ebXrlD7
   VKoUUGJS9hoFkzJhDYbTZguhwc8GD3AZX0BNNeDTHp1rrm3VTacCGDz7M
   Q4SCcXaj/+IcMWE0G4Mxq9IchuMuDNY/UvW4nhVubJszHlyW9uDGvHE9S
   Q==;
X-CSE-ConnectionGUID: UL6YZIr1Te6qecfe49e6IQ==
X-CSE-MsgGUID: FibcDwhYSuisrrvD8XAuBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85193927"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85193927"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:06:56 -0700
X-CSE-ConnectionGUID: yO6KrpiBT4uIDzX9IYtClQ==
X-CSE-MsgGUID: yzGgcSMBQF2aH40ZwcfhDQ==
X-ExtLoop1: 1
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.244]) ([10.125.109.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 08:06:54 -0700
Message-ID: <983e48d0-b281-44dc-9ca6-4e1612319ce3@intel.com>
Date: Tue, 21 Jul 2026 08:06:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] ACPI: APEI: GHES: Collection of fixes for issues
 reported by sashiko
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 xueshuai@linux.alibaba.com, terry.bowman@amd.com,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <CAJZ5v0gLTkGLX_3PLBJYCfFS0_qFjHR+P4agvQQ-Usg4p5nUcA@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJZ5v0gLTkGLX_3PLBJYCfFS0_qFjHR+P4agvQQ-Usg4p5nUcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/21/26 4:33 AM, Rafael J. Wysocki (Intel) wrote:
> On Fri, Jul 17, 2026 at 6:16 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>> A collection of fixes for pre-existing issues reported by sashiko-bot while
>> reviewing patches.
>>
>> The v1 posting fixed a first batch of these issues, and v2 grew the set as
>> sashiko-bot's review surfaced more problems in the same CPER/extlog paths.
>> sashiko-bot's review of v2 flagged yet more of the same class of bug in
>> neighbouring code, so v3 adds those as well: an out-of-range section length
>> that defeats cper_estatus_check(), the same unvalidated AER buffer handling
>> in ghes_handle_aer() that was already fixed for extlog, and an unbounded
>> walk of the extlog record.
>>
>> 1/10:  Bound the CXL event record copy to the firmware section length.
>> 2/10:  Reject CPER records with an out-of-range error_data_length.
>> 3/10:  Validate the CXL protocol error section length before the RAS cap copy.
>> 4/10:  Avoid populating software AER metadata from the raw hardware buffer.
>> 5/10:  Validate the PCIe error section length before payload access.
>> 6/10:  Fix the CONFIG_ACPI_APEI_PCIEAER guard typo in extlog.c.
>> 7/10:  Defer CXL protocol error handling to avoid a lock inversion.
>> 8/10:  Validate the memory error section length before payload access.
>> 9/10:  Bound the AER info copy and sanitize software metadata in ghes.c.
>> 10/10: Validate the extlog record length before walking sections.
>>
>> Note patch 2 touches drivers/firmware/efi/cper.c; it closes the length
>> validation hole at the shared choke point that the per-section guards in the
>> rest of the series rely on.
>>
>> sashiko-bot's review of v2 also flagged a few related issues that are not
>> addressed here because they live in other subsystems.
>>
>>   - cxl_cper_print_prot_err() in drivers/firmware/efi/cper_cxl.c uses the
>>     firmware-controlled dvsec_len without bounding it against the section
>>     length.
>>   - cxl_rch_get_aer_info() in drivers/cxl/core/ras_rch.c reads the RCH AER
>>     capability from MMIO into a struct aer_capability_regs without clearing
>>     the software-only header_len/flit fields, the same class of issue as
>>     patches 4 and 9.
>>
>> v1: https://lore.kernel.org/linux-cxl/20260709162807.1957783-1-dave.jiang@intel.com/
>> v2: https://lore.kernel.org/linux-cxl/20260714231835.303081-1-dave.jiang@intel.com/
>>
>> Changes since v2
>> ----------------
>> - Dropped the standalone spin_lock_irqsave() change; it is a separate issue
>>   being handled by Terry Bowman.
>> - New patch 2: reject a section whose error_data_length is out of range in
>>   cper_estatus_check(), closing the signed-int overflow that let a crafted
>>   section bypass the check and defeat the per-caller size guards (sashiko).
>> - New patch 9: apply the same AER buffer sanitization to ghes_handle_aer()
>>   that patch 4 applies to extlog (sashiko).
>> - New patch 10: bound the extlog record and run cper_estatus_check() before
>>   walking its sections, which extlog did not do (sashiko).
>> - Patch 8: move the memory error length check into ghes_do_proc() so the
>>   report chain and arch reporter are covered too, and bound against the
>>   older UEFI 2.1/2.2 layout rather than the full struct (sashiko).
>> - Reordered so the extlog PCIe path is hardened, and the CXL protocol error
>>   handling is deferred to the workqueue, before the typo fix that activates
>>   that code.
>>
>> Changes since v1
>> ----------------
>> - See the v2 posting for the full v1 -> v2 changelog.
>>
>>
>> Dave Jiang (10):
>>   ACPI: APEI: GHES: Bound CXL event record copy to the firmware section
>>     length
>>   efi/cper: Reject CPER records with an out-of-range error_data_length
>>   ACPI: APEI: GHES: Validate CXL protocol error section length before
>>     RAS cap copy
>>   ACPI: extlog: Avoid populating software AER metadata from raw hardware
>>     buffer
>>   ACPI: extlog: Validate PCIe error section length before payload access
>>   ACPI: extlog: Defer CXL protocol error handling to avoid lock
>>     inversion
>>   ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
>>   ACPI: APEI: GHES: Validate memory error section length before payload
>>     access
>>   ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
>>   ACPI: extlog: Validate elog record length before walking sections
>>
>>  drivers/acpi/acpi_extlog.c       | 47 ++++++++++++-------------
>>  drivers/acpi/apei/ghes.c         | 59 +++++++++++++++++++++++++-------
>>  drivers/acpi/apei/ghes_helpers.c | 21 +++++++++++-
>>  drivers/firmware/efi/cper.c      | 10 ++++++
>>  include/acpi/ghes.h              |  4 +++
>>  include/cxl/event.h              |  4 +--
>>  6 files changed, 106 insertions(+), 39 deletions(-)
> 
> All of this looks reasonable to me, but it really is material for Tony
> to look at.

Thanks Rafael. I've asked Tony to take a look. Looks like he's on vacation so hopefully soon. 

