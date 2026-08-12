Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFD438029;
	Wed, 12 Aug 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540481; cv=none; b=gIa86XkZmXfGERL7MFkVtAcPKhvtMArBO0F6v+np1slllS7Wj7Q/LiICX+8R1MB3FvyfzPAlqaFllPyfq71glDHiDhvqjOX0DZ1Iz+J8p6TUMH1JjxJ26ORl7DYaZ9qaJoVT7DQgbdWfx+LMRv3bAFlYWQflvyaIVhvG93R4WKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540481; c=relaxed/simple;
	bh=k++lc8F3GwEljazcLEYF8pwKVeleIGJNxJv31iuAh9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSorix71r5Sx/AFQasnjIJPOsnidcwYs2+eywXs5p9QQ7AKfBIXzsOrYTN1Qrzo1g6Ae+cOTnKRVa9E5putPGJFnPMzzN6WCEUKLVcsca1sRv6ehDtoSB2Bqt3PTLDuTMKpozIxqTOP+OyNaHSMrDDuQTuxvHAYjCOBU81Gb4lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zjfxgc2h; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zjfxgc2h"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786540474; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=idpJnvKEX08WirBJ9gpqvVCTyBWHveHF9SFsqcD8Cik=;
	b=Zjfxgc2hFhnrqKIPltTFB/9W+g9Mb1NKm/INIZi/jqnfbHqXJOPswdFRRTCEW5HXBvmAeT0rAXnp6w8S/ML8TJE5/0/BcD5DY8oK4EIrELtNBQjOBd+uk/pi6yaBnc6PE2GNr33OdfppvAERDNHoemqDabbTeFnO7ktaga4ReAA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8reTWX_1786540473;
Received: from 30.246.161.236(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8reTWX_1786540473 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 21:14:33 +0800
Message-ID: <a33e09ba-40a6-42e4-b36a-5a6155a5b7d1@linux.alibaba.com>
Date: Wed, 12 Aug 2026 21:14:32 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] ACPI: APEI: GHES: Validate memory error section
 length before payload access
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 sashiko-bot@kernel.org
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-9-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717161647.1493259-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 12:16 AM, Dave Jiang wrote:
> sashiko-bot flagged that the memory error length check was placed too
> late, leaving the other payload consumers unprotected.
> 
> ghes_do_proc() hands the CPER_SEC_PLATFORM_MEM payload to the report
> chain, arch_apei_report_mem_error() and ghes_handle_memory_failure()
> without checking gdata->error_data_length. These read validation_bits
> and physical_addr (offsets 0 and 16), so a shorter section reads past the
> record.
> 
> Validate error_data_length once in ghes_do_proc(), before any consumer
> runs, so every consumer is covered. Bound against struct
> cper_sec_mem_err_old (the UEFI 2.1/2.2 layout) rather than the full
> struct: the section length is authoritative, older firmware legitimately
> emits the shorter record, and the trailing fields, though packed
> unconditionally by cper_mem_err_pack(), are only acted on under
> validation bits that a short record leaves clear. This matches the lower
> bound already used in drivers/firmware/efi/cper.c.
> 
> A malformed sub-record no longer reaches ghes_handle_memory_failure().
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=7
> Fixes: ca104edc1784 ("ACPI, APEI, GHES: Cleanup ghes memory error handling")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Move the length check into ghes_do_proc() so the report chain and arch
>    reporter are covered too, and bound against the older UEFI 2.1/2.2
>    layout instead of the full struct (sashiko).
> ---
>   drivers/acpi/apei/ghes.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b8dbd99da47e..1d2966a437bd 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -940,6 +940,17 @@ static void ghes_do_proc(struct ghes *ghes,
>   		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
>   			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
>   
> +			/*
> +			 * Several consumers below dereference the record, so
> +			 * check the length once here. Bound against the shorter
> +			 * UEFI 2.1/2.2 layout that older firmware still emits;
> +			 * the extra fields are only used under validation bits
> +			 * such records leave clear.
> +			 */
> +			if (gdata->error_data_length <
> +			    sizeof(struct cper_sec_mem_err_old))
> +				continue;
> +
>   			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
>   
>   			arch_apei_report_mem_error(sev, mem_err);

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
