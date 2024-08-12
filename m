Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B664317C;
	Mon, 12 Aug 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496398; cv=none; b=uxNoHu3ozerlbXqo/LJPyzehXc8LTkqbq2zsqOElbhWD2OTol0+aSIkVbyspu4Aj8KiKb4jlc/vwYUCGnMosNEMuqubSPKmzYyuHdunOoBx/ZIFjm+BPyC+skwh8EWamMIyQXkuBSHFbC6p0mNoidrBmRgiRngzopxaTM2zpkwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496398; c=relaxed/simple;
	bh=ZZY9L6mDJKyULQtLc3eUqFJKAOAzm0Uy8TZQUnDIkF0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyfQfSzFAEYpq/awzkmOgEI3kMbn1d9vqOZYzNbg5R3MhLywBkDbk8YxUG1ZDpSXE0lEg9TPWhwiIroBhyjFGbskRWxyhXQLznjR9g9CuBuKU4XL3dKIjkmGhXIIr+Al4kFRgr7+UhO7TYYJh6/GPnQgrJ03AvXZsOIKYAQJByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ8dy8y8; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ8dy8y8"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0bf9602db6so4626150276.1;
        Mon, 12 Aug 2024 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723496396; x=1724101196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5fnaMf391Fpz4xRHQ8kba7KvsYQNRSauNWK6kJhMao=;
        b=eZ8dy8y8IEaR0HTq1colBi//Uh4QWr+0ZyMI4bUVfWwqnIADN7QOq+LiBc/kEdkhA1
         55RTYODdFRogk9Ty2uAQZMFJlbXl6m26jJFt2NhAFkPDL/xoqh9QQhuEoOydEBh/TTkA
         lKvjgl32oPZ5bCpgOkjcfbIiaY6TPJW2B1xFhMHAZ/rQLggk9vFwpScmlLArGnmsga+i
         1KjCBh6heCGm8YMXx964pqiU4KFdMhukw83hmaVQ7sehu1hPIZzr9QfDVEhrrov0iFJ8
         pygE6p13vw98854eG3xTxTkpF4dyOh4D8giQff311wReQY5WbYAYoZfpSzK7zvIlV7AD
         3xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723496396; x=1724101196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5fnaMf391Fpz4xRHQ8kba7KvsYQNRSauNWK6kJhMao=;
        b=AakouukQojW2lU2tYU8NDHcINMuqIhy+MJ1wrZB9adDt+kKpjuSilDw0nMevuKeC6m
         2M3Z++N6Rpzuf673nMgPzej/zjLOh0XRD+KkUrbUahffTvh5On/Y33DcizuDm3GTpFNq
         uN5oZTWoSMlZ/ssYZr4tRpltfB6gqp7rsfkhxiGLU+CYbxtWFRcWgdugV+xG4WLB9kNB
         fzvyYT3pFe4W6Q8Jk1Ja8KkecG174i4LAKjPlXBQ+3QitblcmlUr1MhDKNIJ4wreYqdv
         e05zQbsmw+9uOFJOFq0qoMOGCdlpAX81EqYh6RCLz1svdYM/HWnSXwJfzb2OGmQRaHTG
         PLow==
X-Forwarded-Encrypted: i=1; AJvYcCXsg4mY7nuZKklQi02uDBYSd+WA/xYeMRL8XTRkX5rjI3dhkwIafWn/SzzFuxlDk+wLBex/8C2hSJBmGoYmwbUhyVnE1GWaJ+IIAdFCcunJ/nwoHO+NKfsJj3l014PZL7ofDi3v4tbo
X-Gm-Message-State: AOJu0YwARENqfp8BiNP7YsTtoFnJ7m1XLx/ERbirw+rC0Oxdt8HxnwKW
	vj5U1AHTN8nXOv3MU7PAm77VgjfyGvduQDdEjXmUBIzexh04a2KK
X-Google-Smtp-Source: AGHT+IHznrVOhF2lXDkThTht/dG8KZpY2MPF58XvF0vs97HEUaAH8iMGdnVVzoCIBkpUSQtUzbKIRQ==
X-Received: by 2002:a05:6902:1243:b0:e0b:c402:b03f with SMTP id 3f1490d57ef6-e113cec1fa7mr1528924276.27.1723496395751;
        Mon, 12 Aug 2024 13:59:55 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a15eaf6dsm10190397b3.67.2024.08.12.13.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 13:59:55 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 12 Aug 2024 13:59:48 -0700
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH 1/3] cxl: Set target type of root decoder based on CFMWS
 restrictions
Message-ID: <Zrp3pZQ11kqdHjUl@fan>
References: <20240729084611.502889-1-ying.huang@intel.com>
 <20240729084611.502889-2-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729084611.502889-2-ying.huang@intel.com>

On Mon, Jul 29, 2024 at 04:46:09PM +0800, Huang Ying wrote:
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

Reviewed-by: Fan Ni <fan.ni@samsung.com>

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
> +		cxld->target_type = CXL_DECODER_DEVMEM;
> +	else
> +		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
> -- 
> 2.39.2
> 
