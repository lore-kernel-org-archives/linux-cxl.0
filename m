Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6457378838;
	Fri,  4 Sep 2026 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501641; cv=none; b=XnwzAUQn8K+IiM9YOKQWWVgwoS6hRfAOninItZCXmiuOhhBbAK6Vnbe4uTa61pY/nGNqzuPZahxtyoEnw813UD0JJahg2KDT9wQRuyIPqsaV/jTd1AVEFv7LPR+fqmcsjBCeKsKAxRswV9B9YvfmX7Ji3gDcgMj7gdb2jYDrgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501641; c=relaxed/simple;
	bh=H1OMTQHMLUK4eqBCghChOInBLMt7J44d6rbJsDYiAOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb2zYOwK1UQw+U7VHVrQp0g32viuEYB3wQV2MoqNGlikojGjDw7QsfwBEUYsmxaekaNhvEGCt/1e2xP+px1Sla/2u6NTIQ4h4QWlrGCRFIOhFaDcNT9yiEt8qURABxlbqrrPdKBQPeQMMp50JOr1GWfNa2HLJewMFfRgIfgflss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mlhsUyVl; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mlhsUyVl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788501635; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QevNzGukyc9K1TC6aGGFqL9kqXy72XEO1c7HLLlIt7Q=;
	b=mlhsUyVlz+ejPnpqwLOszXgN2hvqphM+0rSnGjXVykmcPhxtrafJ0lBcMGG87oG0+9novfSRNQd/cID5AXXOs4pMx5S755VUesJjGUHxlxr8ETTGia3jSr5B0ETiZsSgEDohgWOODGfQexz2XsQ2bLfaVBXdzYmMz3WyxCgzsSk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XAHtEdR_1788501633;
Received: from 30.246.160.252(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XAHtEdR_1788501633 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 14:00:34 +0800
Message-ID: <e69018a4-8ddf-4347-943a-f97c261133d5@linux.alibaba.com>
Date: Fri, 4 Sep 2026 14:00:33 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] ACPI: APEI: GHES: Collection of fixes for issues
 reported by sashiko
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 benjamin.cheatham@amd.com, alison.schofield@intel.com,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260827203726.3027541-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/28/26 4:37 AM, Dave Jiang wrote:
> Fixes for pre-existing issues sashiko-bot found while reviewing patches in the
> CPER, extlog and GHES paths. v1 through v3 fixed successive batches as the
> review widened; see the links below.
> 
> The series is grouped in three parts, plus a cleanup.
> 
> Bound the record before anything walks it:
> 
> 1/13:  Reject CPER records with an out-of-range error_data_length.
> 2/13:  Reject an error status block length that wraps a u32.
> 3/13:  Validate the extlog record length before walking sections.
> 
> Fix the extlog error paths, then enable them:
> 
> 4/13:  Defer CXL protocol error handling to avoid a lock inversion.
> 5/13:  Avoid populating software AER metadata from the raw hardware buffer.
> 6/13:  Validate the PCIe error section length before payload access.
> 7/13:  Fix the CONFIG_ACPI_APEI_PCIEAER guard typo in extlog.c.
> 
> Bound each section payload before its consumers read it:
> 
> 8/13:  Bound the CXL event record copy to the firmware section length.
> 9/13:  Validate the CXL protocol error section length before the RAS cap copy.
> 10/13: Read only validated fields in cper_mem_err_pack().
> 11/13: Validate the memory error section length before payload access.
> 12/13: Bound the AER info copy and sanitize software metadata in ghes.c.
> 
> Then drop an export patch 4 made redundant:
> 
> 13/13: Make cxl_cper_handle_prot_err() static.
> 
> Patches 1, 2 and 10 touch drivers/firmware/efi/cper.c, closing the holes at
> the shared choke point the rest of the series relies on. Patch 2 also fixes an
> infinite loop in bert_print_all(), unrelated to this series but the same root
> cause.
> 
> Known gaps, left for separate patches:
> 
>    - cxl_cper_print_prot_err() in drivers/firmware/efi/cper_cxl.c uses
>      dvsec_len without bounding it against the section length.
>    - cxl_rch_get_aer_info() in drivers/cxl/core/ras_rch.c reads the RCH AER
>      capability from MMIO without clearing header_len/flit, the same class as
>      patches 5 and 12.
>    - struct pcie_tlp_log grew to 60 bytes for Flit mode, so the 96-byte CPER
>      AER info no longer maps 1:1 onto struct aer_capability_regs past the
>      Header Log. Patches 5 and 12 now copy only the 44 bytes that do map and
>      leave the rest zero, which keeps the Root Error registers out of
>      header_log.prefix[] - but nothing here decodes the Flit-mode header
>      DWORDs, which live at payload offset 56 while the struct expects them at
>      44. Doing that properly wants a field-by-field mapping shared with
>      cxl_rch_get_aer_info(), plus a clamp: pcie_print_tlp_log() trusts
>      header_len against a 14-entry dw[], and PCI_ERR_CAP_TLP_LOG_SIZE is five
>      bits wide.
> 
> v1: https://lore.kernel.org/linux-cxl/20260709162807.1957783-1-dave.jiang@intel.com/
> v2: https://lore.kernel.org/linux-cxl/20260714231835.303081-1-dave.jiang@intel.com/
> v3: https://lore.kernel.org/linux-cxl/20260717161647.1493259-1-dave.jiang@intel.com/
> v4: https://lore.kernel.org/linux-cxl/20260824174936.939059-1-dave.jiang@intel.com/
> 
> Review tags from the v3 and v4 threads are carried over, and Jonathan reviewed
> patches 2, 4, 6, 7, 8 and 9 on v4. Patches 1, 10, 11 and 13 carry none: 10 and
> 13 are new since v3, and 1 and 11 were reworked far enough that Alison's and
> Shuai's v3 tags no longer applied. Patches 5 and 12 keep theirs, but the copy
> length changed in v5 - same intent, different bound - so please re-check if you
> disagree.
> 
> Changes since v4
> ----------------
> - Patch 1: use check_add_overflow() instead of a u64 sum plus an INT_MAX
>    test, and drop the now-redundant acpi_hest_get_size() bound, since
>    record_size is never smaller than the header (Jonathan Cameron).
> - Patches 5 and 12: copy only the 44 bytes of aer_info that map onto struct
>    aer_capability_regs - the leading registers and the four Header Log DWORDs
>    - and leave the rest zero, instead of copying all 96 bytes and then
>    clearing header_len and flit (Jonathan Cameron). This also keeps the Root
>    Error Command, Root Error Status and Error Source ID out of
>    header_log.prefix[], where pcie_print_tlp_log() was printing them as
>    end-to-end prefixes.
> - Patch 3: kept the length bound ahead of cper_estatus_check() and expanded
>    the comment to say why. Swapping them would let cper_estatus_check() walk
>    sections over an unbounded data_length, past the end of elog_buf
>    (Jonathan Cameron).
> 
> Dave Jiang (13):
>    efi/cper: Reject CPER records with an out-of-range error_data_length
>    efi/cper: Reject an error status block length that wraps a u32
>    ACPI: extlog: Validate elog record length before walking sections
>    ACPI: extlog: Defer CXL protocol error handling to avoid lock
>      inversion
>    ACPI: extlog: Avoid populating software AER metadata from raw hardware
>      buffer
>    ACPI: extlog: Validate PCIe error section length before payload access
>    ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
>    ACPI: APEI: GHES: Bound CXL event record copy to the firmware section
>      length
>    ACPI: APEI: GHES: Validate CXL protocol error section length before
>      RAS cap copy
>    efi/cper: Read only validated fields in cper_mem_err_pack()
>    ACPI: APEI: GHES: Validate memory error section length before payload
>      access
>    ACPI: APEI: GHES: Bound AER info copy and sanitize software metadata
>    cxl/ras: Make cxl_cper_handle_prot_err() static
> 
>   drivers/acpi/acpi_extlog.c       | 60 +++++++++++++---------
>   drivers/acpi/apei/ghes.c         | 88 +++++++++++++++++++++++++++-----
>   drivers/acpi/apei/ghes_helpers.c | 18 ++++++-
>   drivers/cxl/core/ras.c           |  3 +-
>   drivers/firmware/efi/cper.c      | 51 +++++++++++++++---
>   include/acpi/ghes.h              |  4 ++
>   include/cxl/event.h              |  6 +--
>   7 files changed, 178 insertions(+), 52 deletions(-)
> 
> 
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68


LGTM.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.

Shuai



