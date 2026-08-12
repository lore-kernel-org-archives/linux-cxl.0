Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CC3546F9;
	Wed, 12 Aug 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540707; cv=none; b=EFePDfe954VsvKKo5ZgcRaJh/4KWAmDJyxYuk4jj9PbUcXy39Q016lnAh2Gl7fj5W08FXJ9Sb8UjktP3t5fifmb/P00KIFa2Vd9GCnpKy8iiSYHdZqOfAE0rggo3MmT/2lykcVQ6eM6DyjhYkHghdqn4fgYSGJzxR3DRPlSFr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540707; c=relaxed/simple;
	bh=FNYMuvDxnN2le7GrJsSybD+3kq9674S4u5uqSocNf8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXjWw63q8UsTqfJR/g7oLXkAnOzy9Y5lVbTvPXnjBmA/PUYG6Dw4x1JBXJwOz0elj5M0fAd76Jjf7bf+W2Ryc258Mm5fVxXwHI9Z1tJHri4/VnSGT2/RdsGW1E6hBQMIo96wei+ZecUkPFQwbtC7YGQhg/qxBXCfbQCNvvX1Uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VDMJoP7o; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VDMJoP7o"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786540702; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w5Ux7//5pOr7u2EOh2gxhjxHv/3OlkRpCDUVa9tIf1U=;
	b=VDMJoP7o2wOCOsMWZFuTGfqomOVQGMcjb8K8Szn/UJ33Z7o3zPcubgxUSgJkbNwj+bVVYSvFC0VT4nbTdn3XAI4ay5EvqKkPLNt8YDeioOeyHX6dDC4K6x3zNI/KEqYF3/q+GP3lLvEHpqZ4f5nkSuqTzTAlEq5LXKAdiaMD3xg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8rgG-I_1786540701;
Received: from 30.246.161.236(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8rgG-I_1786540701 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 21:18:21 +0800
Message-ID: <607b4999-6054-4fc9-8e30-d2de20031bc2@linux.alibaba.com>
Date: Wed, 12 Aug 2026 21:18:20 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] ACPI: extlog: Validate elog record length before
 walking sections
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 sashiko-bot@kernel.org
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-11-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717161647.1493259-11-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 12:16 AM, Dave Jiang wrote:
> sashiko-bot flagged a missing bounds check on data_length that allows
> an out-of-bounds read of elog_buf.
> 
> extlog_print() copies a fixed ELOG_ENTRY_LEN (4096) bytes from the elog
> record into elog_buf, then walks the sections using the
> firmware-controlled data_length. Nothing checks that data_length stays
> within the buffer, so a malformed record can walk the section pointer
> past elog_buf and read adjacent memory.
> 
> Unlike the GHES paths, extlog never calls cper_estatus_check(). Reject a
> record whose length exceeds ELOG_ENTRY_LEN and run cper_estatus_check()
> before walking the sections.
> 
> A malformed record is now dropped with NOTIFY_DONE without setting
> MCE_HANDLED_EXTLOG, reflecting that extlog did not consume it.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=6
> Fixes: f6ec01da40e4 ("ACPI: extlog: Handle multiple records")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - New patch. sashiko's review of v2 pointed out extlog walks the elog
>    sections without the cper_estatus_check() bound the GHES paths use.
> ---
>   drivers/acpi/acpi_extlog.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 1fbaf134c04e..30863fd3f5b0 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -200,6 +200,13 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>   
>   	tmp = (struct acpi_hest_generic_status *)elog_buf;
>   
> +	/*
> +	 * data_length is firmware controlled, so make sure the record and its
> +	 * sections stay within elog_buf before anything walks them.
> +	 */
> +	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
> +		return NOTIFY_DONE;
> +
>   	if (!ras_userspace_consumers()) {
>   		print_extlog_rcd(NULL, tmp, cpu);
>   		goto out;

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
