Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D167A2744D;
	Sun,  4 Aug 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722788684; cv=none; b=JXF4PpdwnWvTmXgkIAlN6tKNA2hoHXa/4eS4Mnr7yjOR+Jq0NMkv7BmEFbxH+Lj0r8wfn6ThnC4raDdvVu1w8h2H+X6fQBoVcws/XH9gUaN9a7eD0UOk7UzBo4HqmdzUOsLieG5Wr1u5zepv2MRnlFPwPJNPG02p5EhgRMFd0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722788684; c=relaxed/simple;
	bh=L0ai+hB2ujAmB3bk3dLz9OmYHyA3dryG6Sg5Iu3N4eA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0WwydgElduBn1i2lQNVZOaeGlVgKDCRnepnvF7/mLpmlJmaiLDxcjp2H4JsgHZiuZkT+PDagHNv5fTVrN6O7vkyNrmSx8OGrSmqEIXJ6RnchyTZ7TGsAgZ/m8XZbS9kOtJRxWda7mXVaAodnRFV4hrEYauT89vde/SWfdI8IPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcPwy6b8dz6K5Yr;
	Mon,  5 Aug 2024 00:22:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D1FA71406AC;
	Mon,  5 Aug 2024 00:24:37 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 17:24:37 +0100
Date: Sun, 4 Aug 2024 17:24:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huang Ying <ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>
Subject: Re: [PATCH 1/3] cxl: Set target type of root decoder based on CFMWS
 restrictions
Message-ID: <20240804172436.00003275@Huawei.com>
In-Reply-To: <20240729084611.502889-2-ying.huang@intel.com>
References: <20240729084611.502889-1-ying.huang@intel.com>
	<20240729084611.502889-2-ying.huang@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Jul 2024 16:46:09 +0800
Huang Ying <ying.huang@intel.com> wrote:

> Now, the target type of root decoder is hard-coded to HOSTONLYMEM,
> because only type3 expanders are supported.  To support type2
> accelerators, set the target type of root decoder based on the
> window restrictions field of CFMWS entry.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 82b78e331d8e..40c92ad29122 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -382,7 +382,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> -	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	if (cxld->flags & CXL_DECODER_F_TYPE2)

These flags need updating or we are going to run into problems
long term.

As of more recent specs, the distinction is messier than it was and
it's device coherent HDM-D / HDM-DB (second one being type2 or type3 with
BI support) and/or Host only coherent HDM-H.

I'm curious on whether anyone is support both on same CFWMS?
I believe it is possible and the spec doesn't rule it out.

Jonathan


> +		cxld->target_type = CXL_DECODER_DEVMEM;
> +	else
> +		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,

