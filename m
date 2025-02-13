Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D624501F;
	Thu, 13 Feb 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470877; cv=none; b=oj6A/j0PXPC3M0xhNt0bf9fq/vthJs48pz71LeK/TSgr3TicHnQL2If4YlGVbjReRfhowNJNTo6g4duoV9LSmfA/9+8EWhyUIXuCBoWDk/mWJyxBdiAzK4hS2ANx4N9NsJpXgNoeBIfrMBmklzTJXVDz61Nq9avp1WDh7ewRRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470877; c=relaxed/simple;
	bh=GFVRQOMr5LkqU8Lku2OheFZ32wfU+LzSDcV5fBCXzok=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTwwGdz5uvlfICExjjZ5DV/f5tA02Zy95POTymmor4/mD8NxbATXybr9BCiAuTENwE19uwozMPLsJE+0gOfbqlZAaZ1yuuIUPO9fT9kHRj1rz6qRujP5Qb+2ucQxo7uUIcpdQi4wD/xnZIsOgQeXGuCTlD/e1BuJu05DByMT9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKl3rQHe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKl3rQHe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so20198075ad.0;
        Thu, 13 Feb 2025 10:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739470875; x=1740075675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s55JAvrkZ+mckTGI/dTfSx7v207w3H+pRifFPPJEuqg=;
        b=ZKl3rQHe1oaxKjwvPfzUnFNpLCHGeXjW8XsWhGt0k2mVHDzoojrax06HC5B57O1a0x
         XbPaWQmZb0H/CuGUy7iCeDeiu/psfJbaAAEqa/zHUeWRbCQTfGk8g27a0Qm6yyxnAETh
         vOxiTbE+hXJc+VN1j90dw2heZ25EAbmeUGD85qr+Ixvrt1Yi88jXhIDkOWUQ3GjQj336
         CxeQcGGzsdvwckcZVWqjn7efCayVx6hYW3em4D3u8vkttxCBTPizxmSGERwWADBNsoVu
         UZ2pdxeVl4ZoSuMA7qVyRykF5nQtQz5J9PRZLm3BSd2liZ0cR+SAni61HnxlosRe0tYf
         t1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470875; x=1740075675;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s55JAvrkZ+mckTGI/dTfSx7v207w3H+pRifFPPJEuqg=;
        b=V51DCeT1L9Y+v9uehb4Vymg+rbv6RnySkCIxnpOPKOC663V0JECRW60JVJNa3MdsVc
         TNiLM033Z5yg766KcZwmv7B49X1x7+XZcrefkbeQaILZIK3e/MsG55q8iNrgAD2CnAuU
         SikwZmm80KGiGelvpLc7n84DZ/Zna7OVWqQ3yGCqkiGpCH6ZD2F4OvPxwglUJQS3PSfq
         5+mvHMsk3nXejQnuL2eBy9eRDrT+oH7k09Ztuca/DrvKwK3YVzn3ORLCRlE95QveLukO
         clV+pv6k3NdWfHjooJ1SOSQwAd6PTEOeOkJkjcarzCefqXz77I4AzBkW0m4W65PnoJpy
         dnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMJkb3YHlO69sNYFZNUi0lVB6cDQ/0dG7xD9R/8+SmYdWm3Av+LO7aKBLsEYJONmRjUU5rkJ8KrP/bNVUB@vger.kernel.org, AJvYcCXjHMMDYO418ZWcvAeNIVr0SoLmmiqEBLFp4u+5MVVQ1aFghg/D4P+HHc4O4Vnq4ltSQc7/k0BdYaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYz0Eb7I/TRQ4WAaNLtpe5OpFeM42OEJ0YURzzE0M94bUEkcir
	HDHAknqxqXyG07IoltHczuYT1AbesbOkZ5qy+fesUxrsYJFiKCAR
X-Gm-Gg: ASbGncvt71lMH5D+kjXvvND1K59ofH4th4Vg49R45jL16Okm1l6lswTpxjjFPRmPeG/
	EJybocgwiMiscQCXhoB45nN1IZp9/N0cloJ2H1lP+M4nT44VRiGxxXlCK54DnQXqujB7/RckZmd
	tMnDqcxpvHLfnrnpjX983Flq/xZB1QRg8Di+AxePuvrUNpOZcDyDmSvm5OGPGYqkKV8jLJn2frk
	Lw2X/Oy7TSbPihtnxEdaGVx7X2noQJRTs3v4HnZZEh9yPqJKfVhcVsOsJWfPRNcQeeaup2UtbYG
	zvAPWZQF8WgqLlEKF70knO63EorOzGUSqcfvuy8zMiM=
X-Google-Smtp-Source: AGHT+IHHjbD3SCWpcLZyKdyhWklbzLgH1E7bHRn1Ff7UIDa2/tSONO7XHewrgjBHlMKmHedAoGZa+Q==
X-Received: by 2002:a17:902:e946:b0:216:282d:c67b with SMTP id d9443c01a7336-220bbc67f90mr158799195ad.35.1739470874925;
        Thu, 13 Feb 2025 10:21:14 -0800 (PST)
Received: from asus. (c-73-189-148-61.hsd1.ca.comcast.net. [73.189.148.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5585fbfsm15310745ad.226.2025.02.13.10.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:21:14 -0800 (PST)
Message-ID: <67ae381a.170a0220.362a2c.8f42@mx.google.com>
X-Google-Original-Message-ID: <Z644EoiqEy5YegEW@asus.>
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 13 Feb 2025 10:21:06 -0800
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/pmem: debug invalid serial number data
References: <20250213064008.4032730-1-wangyuquan1236@phytium.com.cn>
 <20250213064008.4032730-2-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213064008.4032730-2-wangyuquan1236@phytium.com.cn>

On Thu, Feb 13, 2025 at 02:40:08PM +0800, Yuquan Wang wrote:
> In a nvdimm interleave-set each device with an invalid or zero
> serial number may cause pmem region initialization to fail, but in
> cxl case such device could still set cookies of nd_interleave_set
> and create a nvdimm pmem region.
> 
> This adds the validation of serial number in cxl pmem region creation.
> The event of no serial number would cause to fail to set the cookie
> and pmem region.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  drivers/cxl/pmem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index f9c95996e937..89f4eac49313 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -384,6 +384,13 @@ static int cxl_pmem_region_probe(struct device *dev)
>  		};
>  		info[i].offset = m->start;
>  		info[i].serial = cxlds->serial;
> +
> +		if (info[i].serial == 0) {
> +			dev_dbg(dev, "%s: invalid serial number\n",

Should we use dev_err() instead? 

Fan
> +				dev_name(&cxlmd->dev));
> +			rc = -ENXIO;
> +			goto out_nvd;
> +		}
>  	}
>  	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
>  	ndr_desc.mapping = mappings;
> -- 
> 2.34.1
> 
