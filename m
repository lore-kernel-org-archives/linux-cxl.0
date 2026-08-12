Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D73164D8;
	Wed, 12 Aug 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539559; cv=none; b=eFYkV7Z4L0pskefJwlSNTPuJn5z/tL6JsKTvk1BM0A6+orBLUygWrvQ81L37duI8/rkoxnzwWMKr9ABa3zVorcyfyTnc3JysOMe0spP1tz9lCA61hlDDNDn/Ogqo30hnP3Je55/ldnyRBCyTFcJyOmfdme5+jKE035tzJw1U09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539559; c=relaxed/simple;
	bh=zxoY3g/vvnYwubm4n1UYRg9arMtHdhviVnMMc8GaVXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpUO0Icfjn2WiLQkQ7nYhWY69WuIIgGXSYyAawF90LT28hYYYYRwBjJgycu11E5p2EZIIC6lDhTegslsTLMsSs5yJR8DR+jIYYHsGz5x6WXHhKdkP0VgpMZGuDyUA0jeLTCmp+1Ra7kM9zsVZ+aqB+DVl7xdSJR92kdNTU3WL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iSjyBeco; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iSjyBeco"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786539549; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q6Yg1UbTGaXn79yI56scgIi5HOCAj6uV8ltJtHKzt3I=;
	b=iSjyBeco51FPmv3TrMYYX1Je9wB+rGbdy5G6xEfteOg+YJmfz65MVTN2MQkR+IlCaMUGXXA+sDBKmNKP50CWFcNl6kL48sHTx5LRTO6LgD5zZuqWlRjQBqbj1puqaBqgDw0QXQwu0OnuN6alWKWvuKEwSaj/eM61QGkCycjuM5Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8rgYVK_1786539547;
Received: from 30.246.161.236(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8rgYVK_1786539547 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 20:59:08 +0800
Message-ID: <60916d84-84f1-4be2-b81e-9c256b0eaa4e@linux.alibaba.com>
Date: Wed, 12 Aug 2026 20:59:06 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] ACPI: extlog: Validate PCIe error section length
 before payload access
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 sashiko-bot@kernel.org
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-6-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717161647.1493259-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 12:16 AM, Dave Jiang wrote:
> sashiko-bot flagged the missing section-length check before
> extlog_print_pcie() touches the PCIe payload.
> 
> extlog_print_pcie() reads pcie_err->validation_bits and device_id and
> copies the 96-byte aer_info buffer without checking that
> gdata->error_data_length is large enough for a struct cper_sec_pcie.
> cper_estatus_check() keeps the read within the estatus block, but a
> short section still lets stale adjacent bytes be treated as PCIe error
> data. Reject a section too small to hold the record before touching any
> field.
> 
> Reported-by: sashiko-bot@kernel.org
> Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/acpi/acpi_extlog.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index fbc88c584c06..0c440d75d9a7 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -134,7 +134,7 @@ static int print_extlog_rcd(const char *pfx,
>   }
>   
>   static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
> -			      int severity)
> +			      int severity, u32 len)
>   {
>   #ifdef ACPI_APEI_PCIEAER
>   	struct aer_capability_regs aer_regs = {};
> @@ -145,6 +145,9 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>   	int aer_severity;
>   	int domain;
>   
> +	if (len < sizeof(*pcie_err))
> +		return;

Minor: The other length rejections this series adds (patch 1 and patch 3)
both print an FW_WARN message, but this one returns silently. Since
the point is to catch firmware emitting truncated PCIe sections, a
ratelimited warning here would match and make the problem visible.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai

