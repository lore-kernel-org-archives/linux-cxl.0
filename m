Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C843B6F5;
	Wed, 12 Aug 2026 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540237; cv=none; b=lveUDNWawhMf7P1BeWnseJRrDmER39p6ksZGDLv0/G5uFd0AZZLg31epPp3nkqCf8j3Vjpwcr1DfzZm6KLyigDI5EwpvnrRyzXg9ciY5SL242xTP4G2xHuvou+p3GTlxuR7MlmZmyGAArFG2cLywdPCW8z1R/zfXW1Qfjh4GEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540237; c=relaxed/simple;
	bh=Z8eMbLMl9guW3tgmU7WdT4/02TWDIL/qvvlS+AAkoDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+8TvDSngVjz5svHKt46VvP+v1EuSE3uM4EfMrzAF69rhFHUHseQKY1cqYoWqfflBWXubvrl7uCKgTY8LocyhecMVgUZCg+rvwC31PrmScje+pFZ15Pu7RZ+VEYWBGj0n15Ux2HKx5nSEDU9SlDbsLq3RnBsqg4jtnTox6SRH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IAlsZck8; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IAlsZck8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786540229; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kDgvsQTrWJ7hXbe+NcyuFighpU3yEyBOoSmvdJDkFCw=;
	b=IAlsZck8EGN9Uou/LepcqbVgseFFd+ZrlexkcljZVcl9FvlaJB+l6DE9lJTtqSsnwm0fyxVTeznwCd6MlpR8sNujzWNhE5zXNCWXKsWi1CDY4zTvoz+/0f27GdjiUGlGIslKHBigLGa43COufJFjt758dGeJ5T7+8a/Dr7IhNrQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X8rgDhk_1786540228;
Received: from 30.246.161.236(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8rgDhk_1786540228 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 21:10:28 +0800
Message-ID: <b86ad5f8-5987-4e0a-bb82-d1df63228913@linux.alibaba.com>
Date: Wed, 12 Aug 2026 21:10:27 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard
 typo
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 sashiko-bot@kernel.org, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-8-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717161647.1493259-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 12:16 AM, Dave Jiang wrote:
> sashiko-bot flagged that a Kconfig macro typo compiles out the extlog
> CXL protocol error handling entirely.
> 
> The guard reads "#ifdef ACPI_APEI_PCIEAER" instead of
> "#ifdef CONFIG_ACPI_APEI_PCIEAER", so the wrapped code is always compiled
> out. Use the correct CONFIG_ prefixed symbol.
> 
> Reported-by: sashiko-bot@kernel.org
> Fixes: 95350effc3ad ("ACPI: extlog: Trace CPER CXL Protocol Error Section")
> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/acpi/acpi_extlog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index ae79d090de33..1fbaf134c04e 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -136,7 +136,7 @@ static int print_extlog_rcd(const char *pfx,
>   static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>   			      int severity, u32 len)
>   {
> -#ifdef ACPI_APEI_PCIEAER
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
>   	struct aer_capability_regs aer_regs = {};
>   	struct aer_capability_regs *aer;
>   	struct pci_dev *pdev;

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
