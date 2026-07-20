Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6864156C1;
	Mon, 20 Jul 2026 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550099; cv=none; b=LMfiQHKjljBmTiqSuGEOVyncIs2hFi2fehgnWexZkcomMcsbwL4s8DNmWn2xJdnr0IZdCRLNKtT0ebo75sO3zxyGWSgc1+4kbPZPhLQODuFDbWiOZvUx2qqc/AC26KXc3LS5XPMijX/GqlvMvx5Wd8dMLkhmYCVv7FYwxj68dFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550099; c=relaxed/simple;
	bh=pupM7zHhxmRKkXDERSwg26lBavfgxgiV96xC1dfu2YQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EZH4GidHuF1m7S8a+Zl0iwAICO6a9xwdvyqyWFzsUowqnQF+kTkLJ1pY/JIm18k9tuMVdyt6lrZXQ99FWnf7vnZ/omgNeaDJ4Kk+MyGPNwCmQwD2MJvPWGDAP97zezSqqClix2Je3VK1J2CBwENnmSkqTM3YwHYykAv5g2/5gfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pHxCe/KR; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pHxCe/KR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=md+ehhv4RmbeVMh7hCfCuHRpoXQtdqZOz6Z4RGL6RsU=;
	b=pHxCe/KRndRds5iQXRh5b+G8mROUOdaNu7WSquLgqAEC//9v3BdvOznBJtULCxZ4c+YWW5sMr
	XbGZnGGrBrSz67ApGdrc/Rky29RBkWy98nfYIYb5xJRPEZKe0/BgQF5LjQd9OoFAO6KxM23wTOn
	zeQuXRBJSa9Q3oivWtVleMU=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h3fX93vdkzLlTV;
	Mon, 20 Jul 2026 20:12:09 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 125474048B;
	Mon, 20 Jul 2026 20:21:31 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jul 2026 20:21:30 +0800
Subject: Re: [PATCH v3 01/10] ACPI: APEI: GHES: Bound CXL event record copy to
 the firmware section length
To: Dave Jiang <dave.jiang@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<mchehab@kernel.org>, <xueshuai@linux.alibaba.com>, <terry.bowman@amd.com>,
	<sashiko-bot@kernel.org>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-2-dave.jiang@intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <186d9c27-d4f3-f8f4-122b-041f847dc55c@huawei.com>
Date: Mon, 20 Jul 2026 20:21:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260717161647.1493259-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/7/18 0:16, Dave Jiang wrote:
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

[...]

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

There are multi places in this patch set doing the same thing, I was
thinking if we can do the check in on place but we are facing different
row error data, any good idea?

Thanks
Hanjun
