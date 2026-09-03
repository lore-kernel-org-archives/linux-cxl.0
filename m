Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A3455618;
	Thu,  3 Sep 2026 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435211; cv=none; b=sk5bsqBUUKEtxZ/h966GbO77A2i7A5vzgXmBLzjb9ZXIYorxVCrOuHf9I7epPDgX3NO0gNLaIeBKU0IFuGX4ZatRbpJwnH8TOBYP4I3snTfa4G22p7fYzPl3FmJRaXr3L+NwKQRQP7bTlwk+K6t0B3WgChiIq0WYiZm3thfFGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435211; c=relaxed/simple;
	bh=hOALd6O56B/OtMocDenZe476lg1o5+DK4iMBaRbUxwo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JdkeCNqDU61+GDDD+q8oNMqeBGLexMwvRcCzgigQ3LGZMlAyNfXzetCljVpIOJokSFIkjqC1Hog6r92djKPArSKLamuN7GS+1/Ewdl+lEV8mvCH2X/usIf3ACh523WLyK89UvE8jtGQuCfUzFhuWQXfUH2zQQxanAoZbVJZRSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gDoom7TK; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gDoom7TK"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=K6Xzum2XK9LXJAO35qSXS+pj6pXqkk9zUg4sH2yPFds=;
	b=gDoom7TKSieHkNs1NJHudpbiIgYOhPbBzTSuOxkUk+GxTeGXwJw9NMvJlwAskE84qlEZzzHFV
	aAo5cpSA+xzu3P1M2WxDpjjRGy589ONe7wudti90QxkGLEYya5C/EtLg6oZJ10X2QtP8QxgCdxm
	BDaUHPeP8onBUGGif/H2HYc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hbHHN4Mg6z1T4Fq;
	Thu,  3 Sep 2026 19:21:52 +0800 (CST)
Received: from whupemk200014.china.huawei.com (unknown [7.152.185.79])
	by mail.maildlp.com (Postfix) with ESMTPS id AC80440561;
	Thu,  3 Sep 2026 19:33:15 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 whupemk200014.china.huawei.com (7.152.185.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 3 Sep 2026 19:33:14 +0800
Subject: Re: [PATCH v5 00/13] ACPI: APEI: GHES: Collection of fixes for issues
 reported by sashiko
To: Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<mchehab@kernel.org>, <xueshuai@linux.alibaba.com>, <terry.bowman@amd.com>,
	<benjamin.cheatham@amd.com>, <alison.schofield@intel.com>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9c77c241-85f6-b175-15bd-76786d5c1364@huawei.com>
Date: Thu, 3 Sep 2026 19:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260827203726.3027541-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk200014.china.huawei.com (7.152.185.79)

On 2026/8/28 4:37, Dave Jiang wrote:
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

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
