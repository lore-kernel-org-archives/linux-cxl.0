Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A331EFFA1
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210957; cv=pass; b=AWQ0yjKGHj3ycHfDEUcuswqiCAV0TNYQCiForaXQo9Qthi7fl25aFT//srv171PIG7uEYb3s98R4kPDtVJlt61cjyMzd2VpS98Q56TsM+GX2sCHw6Hehnk75OLPbhgYk+hHnWKgAP48qHZ3lo0LLtT4Ykj9lRHaur63bMXRp3cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210957; c=relaxed/simple;
	bh=l1Hp7q6hdFYQO8t/9bvt3IHdua8WXok7nYKswS7N9Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P50RwJbBa8/P4np+qZIxhWUEFWAAtODG6FurH9pUb0W7Rm5nax6VvMsTaTiLZ4ACOVnC/YjaeplNgsMbuFnNRRT09K7ofZKN2x9UaFB1qCaN1RmCSQnbcXbhAONlRE5glKlwGQUIytjWjisFilvrDPKiHuHy46E4oPPfuLU/Zmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=MOTyd5FZ; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="MOTyd5FZ"
ARC-Seal: i=1; a=rsa-sha256; t=1790210947; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LyL6Yv/8lriOeiFhiVTX6mTJLV+5VbgBNdChtx/CcXXlS6dFSIyhFfdLC9vpNY3Ux5d9Zy6Vi1453JlAyBkIxB3CWFuGX3j0JzPXY2SIavgbVV6SA0e062vDSVcgsBKtEbOJz5Cwq4BmCMrrEZMSMJixN/VSHwvnRUfJ0WRZKBg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790210947; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S3FwqqC/UutSvkrd75osmoSb2Du8BeTaoLctXaIUB6c=; 
	b=Jw1viAyiKp95UR66ZbdnWKiZci6SEgGuswvxW/qUN5cwdxxXh7pdUxIEDF7n6WUDspmpeB/XSMd8n4CW4ycOlHC91+i1t+Z4qNAKBzPEJu25AyZ5H7A3/BKPc3yDJm7X/TXBr0Y2ZflhZafaXLRfD1sCZJFw44UEKPMIvJpuG4o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790210947;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=S3FwqqC/UutSvkrd75osmoSb2Du8BeTaoLctXaIUB6c=;
	b=MOTyd5FZaXOiA00M5CF78tc8OCPhSW2rpbwlMzzST3exwJUJv3UOv3cnhkbdQNZt
	YoQS/IxSy7ENG0hcXO7XIeml7FFX6qo8HVbUUEy+mdnupsX4D7HF4VGiatR2QCeNrL0
	9JCMYUf9ZQo4m/QcnhEqRlYgkF9EFhAHiwSE/5FU=
Received: by smtp.zohomail.com with SMTPS id 1790210946580826.1884292998839;
	Wed, 23 Sep 2026 17:49:06 -0700 (PDT)
Message-ID: <fa9d5743-e60b-4086-b46d-22652ccf284e@zohomail.com>
Date: Thu, 24 Sep 2026 08:49:00 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/10] cxl/hdm: Rename decoder coherency flags
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1790103847.git.dave@stgolabs.net>
 <3586f226c41a1b49e798d1f36b77ea54e573fc87.1790103847.git.dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <3586f226c41a1b49e798d1f36b77ea54e573fc87.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu080112270d0274f965ce08328df222430000d510157fc2c0e02648cf1957e5879165be0c12ac94bc6848fb:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 9/23/2026 7:38 AM, Davidlohr Bueso wrote:
> Align with the ACPI CXL Window restriction naming and convert
> CXL_DECODER_F_TYPE2/F_TYPE3 to F_DEVMEM/F_HOSTONLY. Type2 and
> Type3 coherency models were named prior to Back-Invalidate.
>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/acpi.c      |  8 ++++----
>  drivers/cxl/core/port.c | 12 ++++++------
>  drivers/cxl/cxl.h       |  4 ++--
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 2e8e31544a5f..f04ac5275af8 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -143,9 +143,9 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  	unsigned long flags = CXL_DECODER_F_ENABLE;
>  
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
> -		flags |= CXL_DECODER_F_TYPE2;
> +		flags |= CXL_DECODER_F_DEVMEM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
> -		flags |= CXL_DECODER_F_TYPE3;
> +		flags |= CXL_DECODER_F_HOSTONLY;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
>  		flags |= CXL_DECODER_F_RAM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
> @@ -459,8 +459,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>  	/* host-only wins if firmware sets both coherency restrictions */
>  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> -	if (cxld->flags & CXL_DECODER_F_TYPE2) {
> -		if (cxld->flags & CXL_DECODER_F_TYPE3)
> +	if (cxld->flags & CXL_DECODER_F_DEVMEM) {
> +		if (cxld->flags & CXL_DECODER_F_HOSTONLY)
>  			dev_dbg(dev, "CFMWS has both HDM-H and HDM-D\n");
>  		else
>  			cxld->target_type = CXL_DECODER_DEVMEM;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d26cd7c88a1..fa1574b46b6f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -129,8 +129,8 @@ static DEVICE_ATTR_RO(name)
>  
>  CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
>  CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
> -CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
> -CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
> +CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_DEVMEM);
> +CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_HOSTONLY);
>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
>  CXL_DECODER_FLAG_ATTR(cap_back_invalidate, CXL_DECODER_F_BI);
>  
> @@ -365,8 +365,8 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>  	unsigned long flags = cxlrd->cxlsd.cxld.flags;
>  	unsigned long hdm_h, hdm_db;
>  
> -	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> -	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
> +	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_PMEM;
> +	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
>  
>  	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
> @@ -376,8 +376,8 @@ static bool can_create_ram(struct cxl_root_decoder *cxlrd)
>  	unsigned long flags = cxlrd->cxlsd.cxld.flags;
>  	unsigned long hdm_h, hdm_db;
>  
> -	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> -	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
> +	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_RAM;
> +	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
>  
>  	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9fb0278e2ce4..3639cd2daf0c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -296,8 +296,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>   */
>  #define CXL_DECODER_F_RAM   BIT(0)
>  #define CXL_DECODER_F_PMEM  BIT(1)
> -#define CXL_DECODER_F_TYPE2 BIT(2)
> -#define CXL_DECODER_F_TYPE3 BIT(3)
> +#define CXL_DECODER_F_DEVMEM BIT(2)
> +#define CXL_DECODER_F_HOSTONLY BIT(3)
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)


