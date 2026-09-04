Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C851FCD9;
	Fri,  4 Sep 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551063; cv=none; b=cdi1MLvhwsEm8F4+vIqhaq/UFEFgWd1Xvel3FsJMd8RDXdW1F1RnMHHYe2Vf1OBdyJoLGjlQ1PgP4v9KVStGJxsl2fOB5UZmVQwfyX/sZnDmdPIOtda5fZjG8UIej2Aai92ZRSmU9RQRAWhidQtDIZap7iy9TKfZcsBlE23cnWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551063; c=relaxed/simple;
	bh=AL9KyQR7QyDCjJVnTWt0rc5nDhOkZqznnVwlDWUTWYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5l49BP6yk8X8nLpGgxyaTq893lpD+AvkmHt39+khmgXO5UDuDbfmTKtEjUVauRkEPm36zf0QQw0GTUIIddJaN8kkgCnYDw4LDjIlM53Fb98WLK62dcejLykHu1ANN6/gogaNM8USjeQFFsJiDts8JRn9xfCDNxMkQEi+YkAiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCis/kvp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCis/kvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788551058; x=1820087058;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AL9KyQR7QyDCjJVnTWt0rc5nDhOkZqznnVwlDWUTWYY=;
  b=BCis/kvpdRZE8eSFXToX/vjINzk8UmUWQG7WR6YzDY5yVboTD1ZlW3qm
   W/2hn1nvrg6S19ZU6mluun+JmVBcDCOXOnaAV3pNTNzpz+rwIt9B0Vk7v
   6p0e/cYVtCCQY1St4wTUo2+24qxtc7g6Jhaa457bPUDrdFea9UWku6z4L
   0TT6Z0YRfihgLdb/blmAjGAK+npkcQr2yhI/F4B8J+91E2xGURWXH2da+
   b4kGxW7m5cf7Zb4sId1/GAwU8ZiEm0kGwSZtHJqUgl7g5S5Oyd8+8MN8l
   7RqP8E+RJmUEagGeQxmKqaNH/yEVOQ1U8mofZdoCmucItQuXGRvarF66c
   g==;
X-CSE-ConnectionGUID: oi1xU7eyST6UXYfUOQjhBw==
X-CSE-MsgGUID: 25w9zO0ERNC2nOoL/UYMzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="88202268"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="88202268"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 12:44:09 -0700
X-CSE-ConnectionGUID: Egsu+x8ZRsuYaH+JLRxZng==
X-CSE-MsgGUID: cFl5xWTySsyt/VcD8RpKhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="268377455"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.248]) ([10.125.110.248])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 12:44:08 -0700
Message-ID: <60466c81-f7c9-46fc-a809-06ac2f8a76af@intel.com>
Date: Fri, 4 Sep 2026 12:44:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] ACPI: APEI: GHES: Collection of fixes for issues
 reported by sashiko
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 xueshuai@linux.alibaba.com, terry.bowman@amd.com, benjamin.cheatham@amd.com,
 alison.schofield@intel.com,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20260904172337.1409775-1-dave.jiang@intel.com>
 <CAJZ5v0hDv11cPuztPZsaDd7uwD_49KznJy=tzuRO+dZc=CnAEQ@mail.gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0hDv11cPuztPZsaDd7uwD_49KznJy=tzuRO+dZc=CnAEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/4/26 11:21 AM, Rafael J. Wysocki (Intel) wrote:
> On Fri, Sep 4, 2026 at 7:23 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>> Fixes for pre-existing issues sashiko-bot found while reviewing patches in the
>> CPER, extlog and GHES paths. v1 through v3 fixed successive batches as the
>> review widened; see the links below.
>>
>> The series is grouped in three parts, plus a cleanup.
>>
>> Bound the record before anything walks it:
>>
>> 1/13:  Reject CPER records with an out-of-range error_data_length.
>> 2/13:  Reject an error status block length that wraps a u32.
>> 3/13:  Validate the extlog record length before walking sections.
>>
>> Fix the extlog error paths, then enable them:
>>
>> 4/13:  Defer CXL protocol error handling to avoid a lock inversion.
>> 5/13:  Avoid populating software AER metadata from the raw hardware buffer.
>> 6/13:  Validate the PCIe error section length before payload access.
>> 7/13:  Fix the CONFIG_ACPI_APEI_PCIEAER guard typo in extlog.c.
>>
>> Bound each section payload before its consumers read it:
>>
>> 8/13:  Bound the CXL event record copy to the firmware section length.
>> 9/13:  Validate the CXL protocol error section length before the RAS cap copy.
>> 10/13: Read only validated fields in cper_mem_err_pack().
>> 11/13: Validate the memory error section length before payload access.
>> 12/13: Bound the AER info copy and sanitize software metadata in ghes.c.
>>
>> Then drop an export patch 4 made redundant:
>>
>> 13/13: Make cxl_cper_handle_prot_err() static.
>>
>> Patches 1, 2 and 10 touch drivers/firmware/efi/cper.c, closing the holes at
>> the shared choke point the rest of the series relies on. Patch 2 also fixes an
>> infinite loop in bert_print_all(), unrelated to this series but the same root
>> cause.
>>
>> Known gaps, left for separate patches:
>>
>>   - cxl_cper_print_prot_err() in drivers/firmware/efi/cper_cxl.c uses
>>     dvsec_len without bounding it against the section length.
>>   - cxl_rch_get_aer_info() in drivers/cxl/core/ras_rch.c reads the RCH AER
>>     capability from MMIO without clearing header_len/flit, the same class as
>>     patches 5 and 12. In the same file, cxl_rch_get_aer_severity() tests
>>     PCI_ERR_ROOT_FATAL_RCV against uncor_status, where that bit is
>>     PCI_ERR_UNC_FCP.
>>   - struct pcie_tlp_log grew to 60 bytes for Flit mode, so the 96-byte CPER
>>     AER info no longer maps 1:1 onto struct aer_capability_regs past the
>>     Header Log. Patches 5 and 12 now copy the part that maps and place the TLP
>>     Prefix Log from its own offset, which covers every field the print path
>>     reads - but nothing here decodes the Flit-mode header DWORDs, which reuse
>>     those same prefix registers at payload offset 56 while the struct expects
>>     dw[4..13] at 44. Doing that properly wants a field-by-field mapping
>>     shared with cxl_rch_get_aer_info(), plus a clamp: pcie_print_tlp_log()
>>     trusts header_len against a 14-entry dw[], and PCI_ERR_CAP_TLP_LOG_SIZE
>>     is five bits wide.
>>
>> v1: https://lore.kernel.org/linux-cxl/20260709162807.1957783-1-dave.jiang@intel.com/
>> v2: https://lore.kernel.org/linux-cxl/20260714231835.303081-1-dave.jiang@intel.com/
>> v3: https://lore.kernel.org/linux-cxl/20260717161647.1493259-1-dave.jiang@intel.com/
>> v4: https://lore.kernel.org/linux-cxl/20260824174936.939059-1-dave.jiang@intel.com/
>> v5: https://lore.kernel.org/linux-cxl/20260827203726.3027541-1-dave.jiang@intel.com/
>>
>> Changes since v5
>> ----------------
>> - Patches 5 and 12: also place the TLP Prefix Log from its own hardware
>>   offset rather than leaving it zero. Shortening the copy in v5 dropped it,
>>   and it is the one field the print path still reads (sashiko). Alison's and
>>   Shuai's Reviewed-by are kept on both, since the intent and location have
>>   not changed.
>>
>> Changes since v4
>> ----------------
>> - Patch 1: use check_add_overflow() instead of a u64 sum plus an INT_MAX
>>   test, and drop the now-redundant acpi_hest_get_size() bound, since
>>   record_size is never smaller than the header (Jonathan Cameron).
>> - Patches 5 and 12: copy only the 44 bytes of aer_info that map onto struct
>>   aer_capability_regs - the leading registers and the four Header Log DWORDs
>>   - and leave the rest zero, instead of copying all 96 bytes and then
>>   clearing header_len and flit (Jonathan Cameron). That also keeps the Root
>>   Error Command, Root Error Status and Error Source ID out of
>>   header_log.prefix[], where pcie_print_tlp_log() was printing them as
>>   end-to-end prefixes.
>> - Patch 3: kept the length bound ahead of cper_estatus_check() and expanded
>>   the comment to say why. Swapping them would let cper_estatus_check() walk
>>   sections over an unbounded data_length, past the end of elog_buf
>>   (Jonathan Cameron).
>> - Condensed the commit logs and comments again; prose only.
>>
>> Changes since v3
>> ----------------
>> - Regrouped into three parts: bound the record, fix and enable the extlog
>>   paths, then bound each section payload. v3 interleaved them, so patch 1
>>   checked a section before the patch establishing that contract. No code
>>   changed.
>> - Moved the extlog lock inversion fix (patch 4) ahead of the CXL protocol
>>   error length validation (patch 9). The former deletes
>>   extlog_cxl_cper_handle_prot_err(), which the v3 order plumbed a new len
>>   argument through three patches before removing it. No functional change.
>> - Patch 1: bound the sum rather than the u32 error_data_length, so the check
>>   does not depend on the <acpi/ghes.h> helpers behaving. The v3 "< 0" check
>>   was dead code (Tony Luck, Shuai Xue). Reviewed-by dropped; not the same
>>   check.
>> - New patch 2: reject an error status block length that wraps the u32 sum in
>>   cper_estatus_len(). A data_length of 0xffffffec makes it read back as 0,
>>   slipping past the extlog bound in patch 3 and leaving bert_print_all()
>>   advancing by zero forever (sashiko).
>> - Patch 4: moved the cxl_cper_post_prot_err() declaration inside the
>>   CONFIG_ACPI_APEI_GHES block in <acpi/ghes.h> (Shuai Xue).
>> - Patch 6: warn instead of returning silently on a short PCIe section (Shuai
>>   Xue), and added the Closes: link v3 omitted.
>> - Patch 7: corrected the Fixes tag to e778ffefa34d, the commit that added the
>>   "#ifdef ACPI_APEI_PCIEAER" guard, and dropped its Reported-by; sashiko-bot
>>   reviewed that patch rather than reporting the typo.
>> - Patch 9: made the two prot-err length messages distinguishable; both printed
>>   the same text. The second now reports dvsec_len (Shuai Xue).
>> - New patch 10: read only validated fields in cper_mem_err_pack(). It copied
>>   extended, rank, mem_array_handle and mem_dev_handle unconditionally from
>>   offsets 73 to 79, past the end of the 73-byte UEFI 2.1/2.2 layout (sashiko).
>> - Patch 11: derive the required length from the claimed validation bits. A
>>   single size gets it wrong both ways (sashiko). Reviewed-by dropped; the
>>   check gained a helper and is no longer the one Alison and Shuai reviewed.
>> - New patch 13: make cxl_cper_handle_prot_err() static. Patch 4 removed its
>>   last external caller.
>>
>> Dave Jiang (13):
>>   efi/cper: Reject CPER records with an out-of-range error_data_length
>>   efi/cper: Reject an error status block length that wraps a u32
>>   ACPI: extlog: Validate elog record length before walking sections
>>   ACPI: extlog: Defer CXL protocol error handling to avoid lock
>>     inversion
>>   ACPI: extlog: Avoid populating software AER metadata from raw hardware
>>     buffer
>>   ACPI: extlog: Validate PCIe error section length before payload access
>>   ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
>>   ACPI: APEI: GHES: Bound CXL event record copy to the firmware section
>>     length
>>   ACPI: APEI: GHES: Validate CXL protocol error section length before
>>     RAS cap copy
>>   efi/cper: Read only validated fields in cper_mem_err_pack()
>>   ACPI: APEI: GHES: Validate memory error section length before payload
>>     access
>>   ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
>>   cxl/ras: Make cxl_cper_handle_prot_err() static
>>
>>  drivers/acpi/acpi_extlog.c       | 64 +++++++++++++---------
>>  drivers/acpi/apei/ghes.c         | 92 +++++++++++++++++++++++++++-----
>>  drivers/acpi/apei/ghes_helpers.c | 18 ++++++-
>>  drivers/cxl/core/ras.c           |  3 +-
>>  drivers/firmware/efi/cper.c      | 51 +++++++++++++++---
>>  include/acpi/ghes.h              |  4 ++
>>  include/cxl/event.h              |  6 +--
>>  7 files changed, 186 insertions(+), 52 deletions(-)
> 
> Sashiko has still reported a finding (medium-level) in patch [5/13]:
> 
> https://sashiko.dev/#/patchset/20260904172337.1409775-1-dave.jiang%40intel.com
> 
> but since the entire series has been reviewed by humans, I'm going to
> apply it as is for 7.4 and if you think that the potential issue
> pointed out in the above is worth taking care of, please send a
> follow-up fix patch (which also applies to the pre-existing issues
> reported there).

You can apply as is. I have a follow on patch to address the issue raised. Thank you!> 
> Thanks!
> 

