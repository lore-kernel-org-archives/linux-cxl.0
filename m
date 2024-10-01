Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F931C8FAB
	for <linux-cxl@vger.kernel.org>; Tue,  1 Oct 2024 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791043; cv=none; b=kDOTSVBlPRyssdCWKrq/AUWeMoBaiy/iMxKg8cCSDIgJVPLNW2fwJT4Uj972C/k0g1TjKO9kicZD3pYsfbGNVg6kWusPBDoll/jeIPFMDCS+FxdUT3BFatn8E1NQiDtGB4nl81VZz+h9P6LesG8CP7SRMdYrqvIdyO8uQAaXLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791043; c=relaxed/simple;
	bh=J97Riel3EyHM9P0l5RmkuSADWU53z3rqYXMpCPZTpX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uijxUF3i06swKk0GwPc8jp8wDUfHezGZ2FcC69AFac7PnNavAkjCwRAYskglHuI81Nn7sKwIn+Z35/0kXPR8+4n3NhdAj50lb18uOec5fVgrUoejOOFNv/kNgt6JHyG4zWeBfEiQpbX4RkZ6NPNC6LFbtwyfivdwBPSpamE612Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WdkpaRQD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WdkpaRQD"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4585e25f42bso55466681cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 01 Oct 2024 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727791040; x=1728395840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hZ4Myb3ejuom1MixmHckZnOKNa7Bc6TIjvG/EsrTe8=;
        b=WdkpaRQDUpaFg31ybOqTZ9f7jT7TyGd5hK4zUwf2/fLFMNNHAl2ohWrtH2fLPtx90g
         LRIbnpTDHT/4I0SOQiQW1V9x//yAFX//UppZkd+0xSSwGrY5Gz9+jdI1uAe+qgGsYMAx
         mUg0WMaYm4ztA+P2f3uFOIklCGk80+6zuLvdYXnowx91b7re2qplNqepOaUtDG56uvWy
         T4Lflt0qduxeTOIuDp+pEKaEh/EVVxGGXo3h4tXRpB5PHHXqvlPvu+LgEPR6K+SiS/V6
         qDCG0H6xwmz1haOPSqOVORu0IwWu3zfPEUSsS2TVpdQKUMvNzuUr9QrgyLCqElAzd2cP
         e9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791040; x=1728395840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hZ4Myb3ejuom1MixmHckZnOKNa7Bc6TIjvG/EsrTe8=;
        b=ZeiRSpp/SWy7bZ3w5ifpM3Bo+nvugr4yO31ESqEzz1VGS+XGztf/OPPjxRxh2StKDY
         symLzTmSP/BddElRyvR0QT5pHYcxpqVfqyhojGIVJaH1UN6h6RpWVaE0+Xzyh8mh//Bd
         +pSZyetHQTL4eWBiP8atOkG4YoSokQKVvDwh11bDufShQsNsRr6wkjQWRjUya5K8nzSk
         yFY64vkfTgrbPBPMQ4PMvtiGvXVlrWfrR0170Ez3Pxpzpx1hgvtgci5hCXu1eKoJECyz
         nrHySbW0p9HjLtnS9uYqGnUhzwzseri1+Zg5uBHUqIc8Yj218b7AMlOr7fQ0cScfau0h
         AYtw==
X-Forwarded-Encrypted: i=1; AJvYcCWiYzRhh/OB/XE8Ch8oxeZQyRxMuVe9nXfjjXTV4la5oQTuU6BqgfbvZBGbEnYd3+OtOjr02V7I/pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhi7uEv1t2n2VYWwWCRiFLyHOydTQOKUKIXE97TD0i+3HkdWn
	j55GcSYlR5e/SEoFJXc8qZiitlYFkHXrrXEt9GYzu/3FAIv7+8FHNa1Lcfhgy4k=
X-Google-Smtp-Source: AGHT+IGJMZ0MxG4HiH8DwJxEybevsBYrrNT0mTSZweDXAMg7YhQCkDRcg6CcnaqbFslRUC5P+nQRVA==
X-Received: by 2002:a05:622a:24b:b0:458:4aec:2738 with SMTP id d75a77b69052e-45c9f2a68d0mr296432361cf.56.1727791039977;
        Tue, 01 Oct 2024 06:57:19 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f353147sm45804531cf.84.2024.10.01.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:57:19 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:56:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 4/5] cxl: Set type of region to that of the first endpoint
Message-ID: <Zvv_oov557lzvYUM@PC2K9PVX.TheFacebook.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-5-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925024647.46735-5-ying.huang@intel.com>

On Wed, Sep 25, 2024 at 10:46:46AM +0800, Huang Ying wrote:
> The type of region is hard-coded as type 3 expander now, because this
> is the only supported device type.  As a preparation to support type 2
> accelerators, we set the type of region to that of the first endpoint.
> Then, we will check whether the type of region is same as the type of
> other endpoints of the region.  Because what we really need is to make
> sure the type of all endpoints of a region is same.
> 
> The target type of endpoint devices comes from expander/accelerator
> device drivers via struct cxl_dev_state.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/acpi.c        |  1 -
>  drivers/cxl/core/hdm.c    | 28 +++++++++++++---------------
>  drivers/cxl/core/port.c   |  2 ++
>  drivers/cxl/core/region.c | 13 +++++++------
>  drivers/cxl/cxl.h         |  1 +
>  5 files changed, 23 insertions(+), 22 deletions(-)
> 

Reviewed-by: Gregory Price <gourry@gourry.net>

>  static ssize_t create_pmem_region_store(struct device *dev,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 99398c868d82..2a2d2c483654 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -324,6 +324,7 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  #define CXL_DECODER_F_MASK        GENMASK(5, 0)
>  
>  enum cxl_decoder_type {
> +	CXL_DECODER_INVALID,

nit - should this be an explicit value?

>  	CXL_DECODER_ACCEL = 2,
>  	CXL_DECODER_EXPANDER = 3,
>  };
> -- 
> 2.39.2
> 
