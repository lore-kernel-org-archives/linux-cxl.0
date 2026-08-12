Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE37437847;
	Wed, 12 Aug 2026 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536649; cv=none; b=Wb2Fu7Xtyo9n8qszjmVOzeTTKrBovdF2dBAtWQHQyKK/0F6FM5cGfaqvw4Mq7f/1R+M81ol2rbMZk8AZ7CP2bCmrI7pzoNitxL6e6njnDWjGZBgOkkK5TVg2CZyt+SMFolhlkNO6XUYPRKxvrH6K24KAhhyZxsh2vIV/ZJgq1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536649; c=relaxed/simple;
	bh=0UDr0EBBfcrUP0FjorC38oo5e9HO+aQKsepeABQNmec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXZn3duCimRypa3S1oCXM2dYQHd+T06sfFchQ+A/IV+cUKf3dFT4mUC53sk0K8286dszqmwg20705XWS+mGBpr5F7oqN8YWPD9hAULmqQ4TUJODfOqVNKE9CDIREarqXercHXoRL+0mjfIuAAVJ4TICFiyecz+UxtH/tgInZ76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XToKDol2; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XToKDol2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786536642; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=L/ApQ+Kp5ph3UNP2SUM7U7txnWOka8qjdFdllep9x8s=;
	b=XToKDol2AKBnD1To8yxy+krP4H7kBOE+J0hnDU73n+46AiWCs3lO+6p6zn6JFzcpYRyDkHewahH29I+5VYqHtJF9NYq19DoUuOi9wKqu1o3I2OffQJTZFvf37GgUyi+jy7ONlJYzQlPIFzUv2+piCdmjbkt+puYaFHiR83Qfwo0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X8rUyu3_1786536641;
Received: from 30.246.161.236(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8rUyu3_1786536641 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 20:10:41 +0800
Message-ID: <1f92dbb9-a25b-4833-891e-2a4e3d2392a6@linux.alibaba.com>
Date: Wed, 12 Aug 2026 20:10:40 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] ACPI: APEI: GHES: Bound CXL event record copy to
 the firmware section length
To: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, terry.bowman@amd.com,
 sashiko-bot@kernel.org
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-2-dave.jiang@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260717161647.1493259-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 12:16 AM, Dave Jiang wrote:
> sashiko-bot flagged a missing bounds check that allows an
> out-of-bounds read of the firmware CPER section.
> 
> cxl_cper_post_event() copies a fixed sizeof(struct cxl_cper_event_rec)
> out of the firmware CPER section without checking its length. Pass
> gdata->error_data_length in and reject a section too small to hold the
> record before the copy.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
> Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/acpi/apei/ghes.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6..a752e152a5a0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -815,10 +815,15 @@ static DEFINE_SPINLOCK(cxl_cper_work_lock);
>   struct work_struct *cxl_cper_work;
>   
>   static void cxl_cper_post_event(enum cxl_event_type event_type,
> -				struct cxl_cper_event_rec *rec)
> +				struct cxl_cper_event_rec *rec, u32 len)
>   {
>   	struct cxl_cper_work_data wd;
>   
> +	if (len < sizeof(*rec)) {
> +		pr_err(FW_WARN "CXL CPER section too small (%u)\n", len);
> +		return;
> +	}
> +
>   	if (rec->hdr.length <= sizeof(rec->hdr) ||
>   	    rec->hdr.length > sizeof(*rec)) {
>   		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> @@ -949,15 +954,18 @@ static void ghes_do_proc(struct ghes *ghes,
>   		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>   			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>   
> -			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
> +			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec,
> +					    gdata->error_data_length);
>   		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
>   			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>   
> -			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
> +			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec,
> +					    gdata->error_data_length);
>   		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
>   			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>   
> -			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
> +			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec,
> +					    gdata->error_data_length);
>   		} else {
>   			void *err = acpi_hest_get_payload(gdata);
>   


Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
