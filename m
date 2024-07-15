Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F99D22318;
	Mon, 15 Jul 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065964; cv=none; b=De5t0VxAeEzPOVDBJMLn7gwNSOwVZF8cRuIW5sac16vgCPc4XXpjSwAE4VGS3u1J7lmkd+5cCqGqYnGxixpIKvemESy/SXSiUlNj21iRrTu/TwIC1hePiTRh6IP8thkSpqSO7xDaHf07SbSLsenY5xIjlzwIiBQxJa1QLx6Os6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065964; c=relaxed/simple;
	bh=Aj6nh5mGAl+teHdD050cfcGPMAEinYG2c8dUe3wwZ/Q=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J42lfVZPhl+v5QCWTrPsxNMRqhsSygcsKGtdTx7aekb5L3qDN8L7La5lTy47InS1YdwzuRtuWZFFezuV/A/RSFq1JQ2pKGC4FlsUbUSUeccZFkS14zmb/qPotpwrYM/LckcnKeSMYWTNwq2t/X6UbdTLKqg+w2tMdzXW1A5ie2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQF3kN89; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQF3kN89"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e036d1ce4f7so3601613276.0;
        Mon, 15 Jul 2024 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721065962; x=1721670762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iKR/ODC5NWkjfKlAhKkUtVQjminwT/CBUyLSJA+//MI=;
        b=iQF3kN89ZdM4BMZqQ0vZFLRgB04MOqkP0XifZ1IbhMNI2X/ef+mKAV34Klw8SoUO4B
         Jy2wx93aduawaVbqOG1cBgnWgQBHKvwkDWRSLhUHJc2+P8NhvXkOKjkqAwWDnB1jLNJK
         RxrogGwHOGBhitI4tTHuMIiw//k8YTrWZydGnKRioGgmYXPHL5Pu9QAxAyXWugKlA+Tp
         MiQ97rVlBy9YMZPpnJY0laz/M0ulBvaTnFS+JeZEva4bmYFzj5gndFVdo0tp88I+4ppX
         GCQUXQMIYiDn1YEXS+ZOIuumwjP2YafgrLT/PEzY+X4irlHOz+mJ3T6tsXDMZw8dYsdr
         hD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721065962; x=1721670762;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKR/ODC5NWkjfKlAhKkUtVQjminwT/CBUyLSJA+//MI=;
        b=mrFX7RCGYu401iJRyYr6wR/MZuSZxsDiliSdQc+H3qB5NJ1mprGZl99XhK8DBj+Ypc
         t4D2moKx/+RjhpaYtgAcy4XZebtvbZfuqkdtot/1IWRjGaIPKY6mrRHMphmSh6I4Op7N
         /eUoGpAgfWUo6F/vvqNITZISM9o97ia9VCAU9nZxvrTapFtAJ3bLerdfPhdvB01ce5Zr
         DvjrY8ax7jDC0eEcykLoSrZkaCeYy6s7Uar85bSce3b9cHuZK/A4awi8JhmxEeS1cXT9
         hlVbqJiXs7Rgj5PREB9zk/gOYUTjyJWjZifzsDXSDPX07HLnCDqFxYQ1NILuSW4gyQfa
         tmjw==
X-Forwarded-Encrypted: i=1; AJvYcCXG3H+aoo0/LfqAYVORzcWobNQ1eUbyj3jUpm64YJqN0zuc6eCcePzsOvBuNhk/lGgM1YT5PIH4qslHXr/DiaYkbsS21FGqqd9NKH2CtrjWLhfF2QozwE7F2xfwTWFZHaKDB92fO3pm
X-Gm-Message-State: AOJu0YyaWdKVFabw0NBb4KiUcH663QUHT1McLtPdSLqWcjicenJIJQS4
	INpPiKkCYR2XaYqetN1Le9ppLe50ojpcAkMhVGM+34AjujVIsA7M
X-Google-Smtp-Source: AGHT+IGxaJl8NKgJ/K8f0rzvjF1kPYVZnnnSxHse3dQIG1/xpw7+Uff4gsI6SioFX/QU4LDqYnGomw==
X-Received: by 2002:a05:6902:e08:b0:e03:5e56:9827 with SMTP id 3f1490d57ef6-e05d272d00emr815016276.27.1721065962284;
        Mon, 15 Jul 2024 10:52:42 -0700 (PDT)
Received: from gpd. ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05a4617285sm934658276.24.2024.07.15.10.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:52:42 -0700 (PDT)
Message-ID: <669561ea.050a0220.948fd.3f0d@mx.google.com>
X-Google-Original-Message-ID: <ZpVhae8OtL6qwQ1m@gpd.>
From: nifan.cxl@gmail.com
X-Google-Original-From: fan@gpd.
Date: Mon, 15 Jul 2024 10:50:33 -0700
To: Terry Bowman <terry.bowman@amd.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	ming4.li@intel.com, vishal.l.verma@intel.com,
	jim.harris@samsung.com, ilpo.jarvinen@linux.intel.com,
	ardb@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yazen.Ghannam@amd.com, Robert.Richter@amd.com
Subject: Re: [RFC PATCH 5/9] cxl/pci: Update RAS handler interfaces to
 support CXL PCIe ports
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-6-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617200411.1426554-6-terry.bowman@amd.com>

On Mon, Jun 17, 2024 at 03:04:07PM -0500, Terry Bowman wrote:
> CXL RAS error handling includes support for endpoints and RCH downstream
> ports. The same support is missing for CXL root ports, CXL downstream
> switch ports, and CXL upstream switch ports. This patch is in preparation
> for adding CXL ports' RAS handling.
> 
> The cxl_pci driver's RAS support functions use the 'struct cxl_dev_state'
> type parameter that is not available in CXL port devices. The same CXL
> RAS capability structure is required for most CXL components/devices
> and should have common handling where possible.[1]
> 
> Update __cxl_handle_cor_ras() and __cxl_handle_ras() to use 'struct
> device' instead of 'struct cxl_dev_state'. Add function call to translate
> device to CXL device state where needed.
> 
> [1] CXL3.1 - 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e6c91b3dfccf..59a317ab84bb 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -686,9 +686,10 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> +static void __cxl_handle_cor_ras(struct device *dev,
>  				 void __iomem *ras_base)
>  {
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	void __iomem *addr;
>  	u32 status;
>  
> @@ -699,13 +700,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +		trace_cxl_aer_correctable_error(cxlmd, status);
>  	}
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>  {
> -	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>  }
>  
>  /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -729,9 +730,10 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
> -				  void __iomem *ras_base)
> +static bool __cxl_handle_ras(struct device *dev,
> +			     void __iomem *ras_base)
>  {
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
>  	u32 status;
> @@ -757,7 +759,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> @@ -765,7 +767,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>  
>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  {
> -	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>  }
>  
>  #ifdef CONFIG_PCIEAER_CXL
> @@ -871,13 +873,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  					  struct cxl_dport *dport)
>  {
> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>  }
>  
>  static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>  				       struct cxl_dport *dport)
>  {
> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>  }
>  
>  /*
> -- 
> 2.34.1
> 

Looks good to me.

Fan
