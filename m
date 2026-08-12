Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2F37E2EB;
	Wed, 12 Aug 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540003; cv=none; b=T/uVgQkzzlBym+oeOcbUh49gd5HZZsgLwj9Y4JTNJLX7ojHidyHypjLO6q3heAW7SvEWEigFpskDFtlZVqQqTXoCkxeSfVpZTPiaH+N0ubyQLpzQOKMKFTbJPCeNJa4ya4+uh8IzZzix5ogc5Vclc5q9H31+OnuIh3G+oAWXkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540003; c=relaxed/simple;
	bh=pf2bJUJNjk+AmV0HiWEkUJX2tKwzBU8TT7iu/OClHAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaejtaPPe31pEUhKMP1Hx8XjILsxa8WU/DNG9xq75PRgB3+HeJ++6Tqu1OrG56LS8+fVfVqryEARNsF65o0xCCyO++R0ZAsUyYfMtNN0y5ZZ/A78jjY+dKW7XXYQNOorfYb8jhL6ZFhT5xf9sE7ntHN8bf1qGMkeHslSxryQSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZhuNPFOJ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZhuNPFOJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786539997; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kBT6U1Xx56a9igQgquAaO1LiXZ/D2Wm0cuq0UJSsjAY=;
	b=ZhuNPFOJh5ApjE9VxclVFEaWh95/oPn8mVxh9YYyFlEpuFD/MpFAaO+dr4BPGpTyPWeAfCAksENePDqofbrhh3Vddw6gyOmFDNnKohIVR6SOi7dle86UW0khMuQUovuIkFKcEZUd8VcSsSkkwsP3GQ3GA8Kf7b8AXXqktpYZA6c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8rgabc_1786539995;
Received: from 30.246.161.236(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8rgabc_1786539995 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 21:06:36 +0800
Message-ID: <62f740bf-beb0-42fe-9e11-6724d1d2ede2@linux.alibaba.com>
Date: Wed, 12 Aug 2026 21:06:35 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] ACPI: extlog: Defer CXL protocol error handling
 to avoid lock inversion
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 sashiko-bot@kernel.org
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-7-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717161647.1493259-7-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 12:16 AM, Dave Jiang wrote:
> sashiko-bot flagged an AB-BA deadlock between the PCI device_lock and
> the MCE decoder chain rwsem.
> 
> extlog_print() calls cxl_cper_handle_prot_err() synchronously while the
> MCE notifier chain rwsem is held, and that path takes the PCI device_lock
> via guard(device)(). The probe path takes the locks in the opposite
> order (device_lock held while mce_register_decode_chain() takes the
> rwsem), so the two form an AB-BA deadlock.
> 
> ghes.c already avoids this by posting protocol errors to a kfifo and
> handling them from a workqueue via cxl_cper_post_prot_err(). Export that
> function and use it from acpi_extlog.c instead of calling
> cxl_cper_handle_prot_err() directly.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/acpi/acpi_extlog.c | 23 +++--------------------
>   drivers/acpi/apei/ghes.c   |  5 +++--
>   include/acpi/ghes.h        |  4 ++++
>   3 files changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 0c440d75d9a7..ae79d090de33 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -172,23 +172,6 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>   #endif
>   }
>   
> -static void
> -extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				int severity, u32 len)
> -{
> -#ifdef ACPI_APEI_PCIEAER
> -	struct cxl_cper_prot_err_work_data wd;
> -
> -	if (cxl_cper_sec_prot_err_valid(prot_err, len))
> -		return;
> -
> -	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
> -		return;
> -
> -	cxl_cper_handle_prot_err(&wd);
> -#endif
> -}
> -
>   static int extlog_print(struct notifier_block *nb, unsigned long val,
>   			void *data)
>   {
> @@ -244,9 +227,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>   			struct cxl_cper_sec_prot_err *prot_err =
>   				acpi_hest_get_payload(gdata);
>   
> -			extlog_cxl_cper_handle_prot_err(prot_err,
> -							gdata->error_severity,
> -							gdata->error_data_length);
> +			cxl_cper_post_prot_err(prot_err,
> +					       gdata->error_severity,
> +					       gdata->error_data_length);
>   		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>   			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>   
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 17e4ef555292..b8dbd99da47e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -752,8 +752,8 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
>   static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
>   struct work_struct *cxl_cper_prot_err_work;
>   
> -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				   int severity, u32 len)
> +void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +			    int severity, u32 len)
>   {
>   #ifdef CONFIG_ACPI_APEI_PCIEAER
>   	struct cxl_cper_prot_err_work_data wd;
> @@ -777,6 +777,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>   	schedule_work(cxl_cper_prot_err_work);
>   #endif
>   }
> +EXPORT_SYMBOL_FOR_MODULES(cxl_cper_post_prot_err, "acpi_extlog");
>   
>   int cxl_cper_register_prot_err_work(struct work_struct *work)
>   {
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 8d7e5caef3f1..4dcbb2c30ea2 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -143,4 +143,8 @@ static inline int ghes_notify_sea(void) { return -ENOENT; }
>   struct notifier_block;
>   extern void ghes_register_report_chain(struct notifier_block *nb);
>   extern void ghes_unregister_report_chain(struct notifier_block *nb);
> +
> +struct cxl_cper_sec_prot_err;
> +void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +			    int severity, u32 len);
>   #endif /* GHES_H */

The declaration lands outside the CONFIG_ACPI_APEI_GHES section,
but the definition only exists in ghes.c, which is not built when
ACPI_APEI_GHES is disabled. ACPI_EXTLOG doesn't depend on GHES, so
GHES=n + EXTLOG=m is a legal config and modpost will fail on the
missing symbol. Either move the declaration into the GHES block with
a stub in the #else, or add the Kconfig dependency.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
