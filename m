Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EF374C3
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775754; cv=none; b=WnSoNx3OL6hJnRd9N9ADojteGuuiDv5hOC05ei9SfKRuvbNYYktzvP4srcWwMU80HBd+ee1WrgIV7aD/RvQW+lLptloLVcz5iG7k5u6xDQYazRLMAyGAS553Ge5pB8bJ8iHuIUTXdfg54LIY7VjvA910KzSCLCAP7U+ohP2ElFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775754; c=relaxed/simple;
	bh=KOFGNvdYNXvg+XSw0bqtg0TGgrWXXj+ZIJ+ZiPxHiWw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jE577g2+tavzxVj7G0eMHBwu7ItFWWSFfvPYTp/SNyhnFSRdbkLS/ly4Qo12JMoU7ABJsJhHOFLS2jv9tgUXuqw5mJbYYaPcgrrUDcVkztSJVUe7BRQxE90uW0Hknf/C/x/rf6VO74iY5mHLBT3NHX/zL+JPwqumrLoqS/u74DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtXmf2Wvwz6L6SH;
	Wed, 28 Aug 2024 00:19:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 539761400D4;
	Wed, 28 Aug 2024 00:22:29 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:22:28 +0100
Date: Tue, 27 Aug 2024 17:22:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yanfei Xu <yanfei.xu@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <ming4.li@intel.com>
Subject: Re: [v3 3/4] cxl/pci: Check Mem_info_valid bit for each applicable
 DVSEC
Message-ID: <20240827172228.00001207@Huawei.com>
In-Reply-To: <20240813110532.870869-4-yanfei.xu@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
	<20240813110532.870869-4-yanfei.xu@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 13 Aug 2024 19:05:31 +0800
Yanfei Xu <yanfei.xu@intel.com> wrote:

> The right way is to checking Mem_info_valid bit for each applicable
> DVSEC range against HDM_COUNT, not only for the DVSEC range 1, hence
> let's move the check into the "for loop" of handling each DVSEC range.
Say why it's the 'right' way.   I agree it probably is, but more
detail in this patch description would be good.
I assume it's as simple as
"In theory a device might set the mem_info_valid bit for a first range
 after it is ready but before as second range has reached that state."

If so looks fine to me and with that additional detail,
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---
>  drivers/cxl/core/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 38c567727dbb..519989ada48e 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -324,10 +324,6 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>  	if (!hdm_count || hdm_count > 2)
>  		return -EINVAL;
>  
> -	rc = cxl_dvsec_mem_range_valid(cxlds, 0);
> -	if (rc)
> -		return rc;
> -
>  	/*
>  	 * The current DVSEC values are moot if the memory capability is
>  	 * disabled, and they will remain moot after the HDM Decoder
> @@ -345,6 +341,10 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>  		u64 base, size;
>  		u32 temp;
>  
> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
> +		if (rc)
> +			return rc;
> +
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
>  		if (rc)

