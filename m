Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A32ED141;
	Wed, 12 Aug 2026 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537986; cv=none; b=LeDdkERRmqld+coOxGxlzmRuxXerk8/l28opR9eVP2B02aZkFMD+KLgVdcV2JN5ZPJhX6jlHZ2Bz0APF6bkEcRimd2pf8Osu8cCMvR1bwugR/lxxX715eoP/Bzgga6V61iTJg7t6N7jit+e140VMyqX0u9lo0Sxh4tuLjuABpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537986; c=relaxed/simple;
	bh=bwrmeQeZTrTL5PBbdrxlP5vs7fHth0zfKdKGmbNasVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INeHam5jJrTa5SlQ1aHguzivfT0dFERY1ja2QX3JYVtYxB5HLhXWc9tvIncaTui5VMqn/uwBruuAMnM7wYVndEHKG5pMuWNQe2wZp/JCQVU7W2yCbCA3r7PpnhhzIeUdAWYBItTzaz3eezweTk/mG+tAoeKa0dvlgArcRMyY0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v1Hxk0Il; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v1Hxk0Il"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786537973; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aXxZlwM5ZZ+VM1YpXVwB7/VLe2G4IM8ezvnUbmfxZUk=;
	b=v1Hxk0IlkB51WeKvLoOmjgDJQ8sPNbaER+NZDSFjB99imWJrNi7tFGAcRoDqQRWPI6zNVzAWFgABE9wJDJUaBKkqdWccnqXJP5fVruWeR4ux8356mFvMahl9EO78ndWvmHclb3xELm8nGz26YYfh7UZJLwKXQ3wHsxCD1pmkp8Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8rYOUe_1786537972;
Received: from 30.246.161.236(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8rYOUe_1786537972 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 20:32:53 +0800
Message-ID: <9cb6cd90-9a28-447b-9011-1e6cafe19593@linux.alibaba.com>
Date: Wed, 12 Aug 2026 20:32:52 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] ACPI: extlog: Avoid populating software AER
 metadata from raw hardware buffer
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 sashiko-bot@kernel.org
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-5-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717161647.1493259-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 12:16 AM, Dave Jiang wrote:
> sashiko-bot flagged that casting the raw aer_info buffer fills
> software-only AER metadata with hardware data, driving an out-of-bounds
> read.
> 
> extlog_print_pcie() casts pcie_err->aer_info directly to struct
> aer_capability_regs *. That struct embeds struct pcie_tlp_log, whose
> software-only header_len and flit fields sit at offset 84, within the
> 96-byte aer_info buffer, so the cast fills them with raw hardware data.
> pcie_print_tlp_log() uses flit and header_len to bound a loop over the
> dw[] array, so a large header_len walks past its end.
> 
> Copy aer_info into a zeroed local struct aer_capability_regs and clear
> header_len and flit before passing it on.
> 
> Reported-by: sashiko-bot@kernel.org
> Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
> Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/acpi/acpi_extlog.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 06a944dadbc1..fbc88c584c06 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -137,6 +137,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>   			      int severity)
>   {
>   #ifdef ACPI_APEI_PCIEAER
> +	struct aer_capability_regs aer_regs = {};
>   	struct aer_capability_regs *aer;
>   	struct pci_dev *pdev;
>   	unsigned int devfn;
> @@ -149,7 +150,12 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>   		return;
>   
>   	aer_severity = cper_severity_to_aer(severity);
> -	aer = (struct aer_capability_regs *)pcie_err->aer_info;
> +
> +	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
> +	aer_regs.header_log.header_len = 0;
> +	aer_regs.header_log.flit = false;
> +	aer = &aer_regs;
> +
>   	domain = pcie_err->device_id.segment;
>   	bus = pcie_err->device_id.bus;
>   	devfn = PCI_DEVFN(pcie_err->device_id.device,

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
