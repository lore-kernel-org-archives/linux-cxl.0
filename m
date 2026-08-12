Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725B44CAE4;
	Wed, 12 Aug 2026 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540594; cv=none; b=jgEYzG2arjmfoqjiiCNHA1EWfTzzkclwchTxib7SrkWMatijgCUFysVvFJf2s5IFQRHH4yNFrIQSk0uHBUtj3E746jauDqnTQyVgQwU5LEqqEY9BFDjeCsCebJwGQ4cCc1K+6yGsyAIzuhMEjyv9HzBVhGgW8tKSigQLZEj9RA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540594; c=relaxed/simple;
	bh=LV6g4rSfeBtvELrTpGlKyW3TuTUnJyevxLqRho3fQY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J421NhaWFJhHpvWx8bcwqe7bOu3CZY4DSZWDDn4XHeHMTpTfbWzHb0P1tN/Gs983DIi4anQyGjzQ6RvbUtGvEvonBubEmSfQYNmzsj7ll2JGsgShvT8xyXkMosy/SCoeHT6m30xlcFanjClRfvpa9MErv3XEJVPjGs1fL7tDkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sALEL4te; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sALEL4te"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786540587; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aQSccCsu0Xsag5+67r9fm4jnLbPYdxivtjYwkHtaCvM=;
	b=sALEL4tel7P6EBKOQs1KVcJgTcnK6JhFFL18qSkHh5yGRP5YB1Xr+Zx4lS0YkWmRvB2JpolydT2A7bz9hhzWX1fqjFC4zkd47HoaDE4xH6J9VA3EXdxpqUvfORYDkWvJf9f2sDak/BFzlBz6zWuynsZy61SvHo9wJk9EvDbLWvg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8reU4X_1786540586;
Received: from 30.246.161.236(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8reU4X_1786540586 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 21:16:27 +0800
Message-ID: <ad1516bc-3582-495c-9de6-a384d4a3259e@linux.alibaba.com>
Date: Wed, 12 Aug 2026 21:16:26 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] ACPI: APEI: GHES: Bound AER info copy and
 sanitize software metadata
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 sashiko-bot@kernel.org
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-10-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717161647.1493259-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 12:16 AM, Dave Jiang wrote:
> sashiko-bot flagged that ghes_handle_aer() has the same unvalidated
> AER buffer handling plus a 4-byte over-read.
> 
> ghes_handle_aer() copies sizeof(struct aer_capability_regs) from the
> fixed 96-byte pcie_err->aer_info, reading past the section since the
> struct is larger. It also fills the software-only header_len and flit
> fields of the embedded struct pcie_tlp_log from raw firmware bytes;
> pcie_print_tlp_log() uses them to bound a loop over dw[], so a large
> value walks past the array. There is also no check that the section can
> hold a struct cper_sec_pcie.
> 
> Validate error_data_length, zero the destination, bound the copy to the
> 96-byte source, and clear header_len and flit. This mirrors the
> extlog_print_pcie() fix.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=3
> Fixes: 7e077e6707b3 ("PCI/ERR: Handle TLP Log in Flit mode")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - New patch. sashiko's review of v2 flagged the same unvalidated AER
>    buffer handling in ghes_handle_aer() that v2 fixed for extlog.
> ---
>   drivers/acpi/apei/ghes.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 1d2966a437bd..bd53509dcab3 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -642,11 +642,14 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>   #ifdef CONFIG_ACPI_APEI_PCIEAER
>   	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>   
> +	if (gdata->error_data_length < sizeof(*pcie_err))
> +		return;
> +
>   	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
>   	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> +		struct aer_capability_regs *aer_info;
>   		unsigned int devfn;
>   		int aer_severity;
> -		u8 *aer_info;
>   
>   		devfn = PCI_DEVFN(pcie_err->device_id.device,
>   				  pcie_err->device_id.function);
> @@ -664,13 +667,22 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>   						  sizeof(struct aer_capability_regs));
>   		if (!aer_info)
>   			return;
> -		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
> +
> +		/*
> +		 * aer_info is a fixed 96-byte buffer, smaller than struct
> +		 * aer_capability_regs, so bound the copy to the source. Clear
> +		 * the software-only header_len and flit fields afterwards so
> +		 * firmware bytes cannot drive the pcie_print_tlp_log() loop over
> +		 * dw[] out of bounds.
> +		 */
> +		memset(aer_info, 0, sizeof(struct aer_capability_regs));
> +		memcpy(aer_info, pcie_err->aer_info, sizeof(pcie_err->aer_info));
> +		aer_info->header_log.header_len = 0;
> +		aer_info->header_log.flit = false;
>   
>   		aer_recover_queue(pcie_err->device_id.segment,
>   				  pcie_err->device_id.bus,
> -				  devfn, aer_severity,
> -				  (struct aer_capability_regs *)
> -				  aer_info);
> +				  devfn, aer_severity, aer_info);
>   	}
>   #endif
>   }


Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
