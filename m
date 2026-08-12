Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7F43A7F6;
	Wed, 12 Aug 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537845; cv=none; b=gImrrbkhHKuH4/GkgcSF5v1RSziAOsf9O35qSxsEPcxkMawnaCyMFIfTxdT8B4Tc25onORL58qnMtqRifZ7rB1MsrL/Oc6NVe8X7ePWT7nNXtHZF2AaH1SZjTOBBpdIOM6GN4sV0JgRQJ4qDHoR9AcoC82qe87+YdcA5BHTJ+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537845; c=relaxed/simple;
	bh=YrhscCD5PMHOSTPuWCj+f0LlrZDpo77+cgeJZtW3c2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvTDkQJQHhldQ81hQkGdnlv3qx2mlRr0NhSjN6uMa/ygfrFbaVQ63oUK5hIIljN6pu2ikWNtQoGWfFgKOALQk9ZxopPU+k8ejoDuBlUDTUsC6TiSG8jencCWXIIJGEt0q5t8ANR1zbeMm7Z3QXT13mFpHicVkUhpxKOF9VSZBv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yc1vmQoz; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yc1vmQoz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786537835; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RM5enxsXU/n5vvmX9wp2JwJY0Qo4JlZY9tVFQiWUaqo=;
	b=Yc1vmQozQhYxi1GzmWcsoRvUyIfBGSyEynnBOTd6bdcnEA47W480xSYJgPCDZv70Fz/DNXcFG2iGMqqDFMi2v7WxtCd65qZo2Anqsu3eHHJxkJVvFoTc6lBRoyOEWrY4KR/zkjqQiJwCv75PuKv0a7x5udTknyFKK1X1b5w5Uhk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X8rZrwl_1786537833;
Received: from 30.246.161.236(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8rZrwl_1786537833 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 20:30:34 +0800
Message-ID: <5dc47478-8fbd-477d-9af0-c4b40e961dca@linux.alibaba.com>
Date: Wed, 12 Aug 2026 20:30:33 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] ACPI: APEI: GHES: Validate CXL protocol error
 section length before RAS cap copy
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 sashiko-bot@kernel.org, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-4-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717161647.1493259-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 12:16 AM, Dave Jiang wrote:
> sashiko-bot flagged an out-of-bounds read driven by an unvalidated
> firmware dvsec_len.
> 
> cxl_cper_setup_prot_err_work_data() locates the RAS Capability block at
> prot_err + sizeof(*prot_err) + dvsec_len and copies it, but dvsec_len is
> firmware controlled and never validated.
> 
> Extend cxl_cper_sec_prot_err_valid() to verify the section can hold the
> header, and that the header, DVSEC and RAS Capability block all fit
> within the reported section length.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
> Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> Fixes: 315c2f0b53ba ("acpi/ghes, cper: Recognize and cache CXL Protocol errors")
> Assisted-by: Claude:claude-sonnet-4-6
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/acpi/acpi_extlog.c       |  7 ++++---
>   drivers/acpi/apei/ghes.c         |  7 ++++---
>   drivers/acpi/apei/ghes_helpers.c | 21 ++++++++++++++++++++-
>   include/cxl/event.h              |  4 ++--
>   4 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 7ad3b36013cc..06a944dadbc1 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -165,12 +165,12 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>   
>   static void
>   extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				int severity)
> +				int severity, u32 len)
>   {
>   #ifdef ACPI_APEI_PCIEAER
>   	struct cxl_cper_prot_err_work_data wd;
>   
> -	if (cxl_cper_sec_prot_err_valid(prot_err))
> +	if (cxl_cper_sec_prot_err_valid(prot_err, len))
>   		return;
>   
>   	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
> @@ -236,7 +236,8 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>   				acpi_hest_get_payload(gdata);
>   
>   			extlog_cxl_cper_handle_prot_err(prot_err,
> -							gdata->error_severity);
> +							gdata->error_severity,
> +							gdata->error_data_length);
>   		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>   			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>   
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a752e152a5a0..17e4ef555292 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -753,12 +753,12 @@ static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
>   struct work_struct *cxl_cper_prot_err_work;
>   
>   static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				   int severity)
> +				   int severity, u32 len)
>   {
>   #ifdef CONFIG_ACPI_APEI_PCIEAER
>   	struct cxl_cper_prot_err_work_data wd;
>   
> -	if (cxl_cper_sec_prot_err_valid(prot_err))
> +	if (cxl_cper_sec_prot_err_valid(prot_err, len))
>   		return;
>   
>   	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> @@ -950,7 +950,8 @@ static void ghes_do_proc(struct ghes *ghes,
>   		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>   			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
>   
> -			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
> +			cxl_cper_post_prot_err(prot_err, gdata->error_severity,
> +					       gdata->error_data_length);
>   		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>   			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>   
> diff --git a/drivers/acpi/apei/ghes_helpers.c b/drivers/acpi/apei/ghes_helpers.c
> index bc7111b740af..d625ec98a24c 100644
> --- a/drivers/acpi/apei/ghes_helpers.c
> +++ b/drivers/acpi/apei/ghes_helpers.c
> @@ -5,8 +5,15 @@
>   #include <linux/aer.h>
>   #include <cxl/event.h>
>   
> -int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
> +int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err, u32 len)
>   {
> +	if (len < sizeof(*prot_err)) {
> +		pr_err_ratelimited(FW_WARN
> +				   "CXL CPER prot err section too small (%u)\n",
> +				   len);
> +		return -EINVAL;
> +	}
> +
>   	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
>   		pr_err_ratelimited("CXL CPER invalid agent type\n");
>   		return -EINVAL;
> @@ -23,6 +30,18 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
>   		return -EINVAL;
>   	}
>   
> +	/*
> +	 * The RAS Capability block follows a firmware-controlled DVSEC of
> +	 * dvsec_len bytes; verify it and the header fit the section.
> +	 */
> +	if (sizeof(*prot_err) + prot_err->dvsec_len +
> +	    sizeof(struct cxl_ras_capability_regs) > len) {
> +		pr_err_ratelimited(FW_WARN
> +				   "CXL CPER prot err section too small (%u)\n",
> +				   len);

Nit, this prints the same message as the header-too-small case above, so
the log can't tell them apart. Maybe include dvsec_len here.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
