Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE37274B37
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142449; cv=none; b=oCqebQJLCKFqJtqhnOgJ5tjgYSMoZs6p9LEFvq+Eha3iMjd/bfSUebgZnErbJEQpdGeamNtnTHSMHFzZPziyrnmjXDEJHnnkbmZvF0BTgKliA8hkyuUNNzP9p8w9fbT+X6wAAvkycLQGh+0A+eywzi6C127gDDd2qRnQW5JiaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142449; c=relaxed/simple;
	bh=K+W1WDio6lk+ITDSHWIHjSqoEIPRhq3FXhhJkTR7mH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBo0GmhDlOpeiaAp3RPbwgSfZx384a5y5CViX4TMnl/lptwsnupe49PXQxym3T4DK3P1S56Pc20sZ8EY7cmptQmu1FWi00AvzJ4oLq5mKbjf3GHdmbAe6UqVXXCz+uAAO2m9bggu1OL3hADd8R/auj8OpgFFgaFDdTOeJzj7814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IqqFv8b3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IqqFv8b3"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-778d99112fbso2638946d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758142447; x=1758747247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcmqKXFeHUqx/Zd3AQldL9H7ZjaJD86SN/59W2f2bAs=;
        b=IqqFv8b3vcf2fDK44mE57FrYJTu6BxSHwlJTelsRxsGtobZ1Fz1uRI4u+FYpn3/r4i
         fmgLy/Ul5Astyqprqyu2R5xh/36I4HnFGUgtPhGZWVWigfrmP8iDo3Ao8m+lf5v8njef
         zQHNgT/EmoTOfkG1tn+jQ2FrkyQVTIDV+fU+9lIto0XtzMpR+FJ1Q4e96N3IP+rJIvIu
         0vimjBM8q4Pss7QaTiv5XVi6EwNFJ0ZcInD5eOQFAw/bLe+CwNGu4SA6Vkuzp+5J+xqq
         kFMIcvQDBswk+8cBzhQkj/iJ1LLCDebTwgS/lfjZ/RYqj5+DbuwKUDcS7iORFkoYQlc8
         xhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142447; x=1758747247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcmqKXFeHUqx/Zd3AQldL9H7ZjaJD86SN/59W2f2bAs=;
        b=ZjzzOyhkXy3kwhH0jM8j0bF/ZgYTnil9hRglnpb2cUAzng3O7EGB1xyWjrDj6echBm
         g6DgfFr4+mPS+H7ZQUhgpOqJdR/LMBIMAD0l4swbjRZX1JCrc+2R2A3LBW+nPpTcVAGR
         wce0ZdX8am0hd1LuN3Lj1vAe45gnSII9oHwuzVj9ECLcbf9pvPfGf81I1dKuTRlvjvpM
         UTwfNsWpo2Oixsk17iqCGLowoqni6LeQ1XdIQVwfRaYWQm+pCiXgdEcHNWj/GSTEcdB+
         2QhAG6KZd+rYNSDnG+wQe7VqTS2NDDQAcPcAlQEUjvNUHe1jCZq3o9RAySaSUkziMYhe
         h8kg==
X-Forwarded-Encrypted: i=1; AJvYcCUQEGvydpQ6xBD/FlhnU4izHWWOst+ShXt8faZjI9g19Z4XacVyAaXQ4n7aSNnT1H0J8SmuGN68qyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7boB2IcfvvImCg3Sm/Lw4tKs+bpxULC+9phu/i5+F4pIWRgq
	iWPNQxbsLdYkf2v0hcGrPFi+J0t0UWz81wv8RXtn3sHp7EYA0/rp40Ev10UVbvRMu2k=
X-Gm-Gg: ASbGncsL8fAOb6sQDkOcvjegLNgLZP038hbGC+U5Pb8uW7tWlVhUWu3lA9jDn1BoDay
	6CmrdjfyRm2306hx0IdiFrSS3bidVIAe4EZ3Ibdi0nMY1VOpc3QNHWh9W0ueiPIEmwPCXwRFzYb
	pbobgaPwojWTQpSeAfZ4yWUyBNPOEmQox4lL/H/rccZymeWIbze9bp1TfGGPNRKySRrvc0a6ylq
	knbqecGX8neF6yQ6ZdtNmN32tRPU1Lj0lpYFis0TBRE/0twXarrKKd+wue1GDSU2qo5WBgES+fG
	Ra7y8L1UINS3w/QsHUE9XNfMHjfwhKov3Hdzu+34Y0Gv2rssq34idQH2v4Mjb7C/J8ElF7/JUOB
	1djwHmlxT4zljqFAFbsfbZadahGzNsAg2v7o4mzdrNH2ZVnKOdt0e5cckJbgX6cP/4EirWJRqp5
	xLY8UxGu9X2+/mBMGqLhonWg==
X-Google-Smtp-Source: AGHT+IGDXIKr016Rx3/Xv8gq8Sj5/rMui3SP4djoDyXpvBJ2Prp8xro0Uk1OdXAiTR7V4JoBTmiKeA==
X-Received: by 2002:a05:6214:2622:b0:76f:6972:bb89 with SMTP id 6a1803df08f44-78ecc438e04mr47323676d6.9.1758142446767;
        Wed, 17 Sep 2025 13:54:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79353c4d4b3sm1804606d6.51.2025.09.17.13.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:54:06 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:54:04 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 10/11] cxl/acpi: Prepare use of EFI runtime services
Message-ID: <aMsf7EP8W99QJFTI@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-11-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-11-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:12PM +0200, Robert Richter wrote:
> In order to use EFI runtime services, esp. ACPI PRM which uses the
> efi_rts_wq workqueue, initialize EFI before CXL ACPI.
> 
> There is a subsys_initcall order dependency if driver is builtin:
> 
>  subsys_initcall(cxl_acpi_init);
>  subsys_initcall(efisubsys_init);
> 
> Prevent the efi_rts_wq workqueue being used by cxl_acpi_init() before
> its allocation. Use subsys_initcall_sync(cxl_acpi_init) to always run
> efisubsys_init() first.
> 
> Reported-by: Gregory Price <gourry@gourry.net>
> Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 26c494704437..95a5ba395c1a 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -1012,8 +1012,12 @@ static void __exit cxl_acpi_exit(void)
>  	cxl_bus_drain();
>  }
>  
> -/* load before dax_hmem sees 'Soft Reserved' CXL ranges */
> -subsys_initcall(cxl_acpi_init);
> +/*
> + * Load before dax_hmem sees 'Soft Reserved' CXL ranges. Use
> + * subsys_initcall_sync() since there is an order dependency with
> + * subsys_initcall(efisubsys_init), which must run first.
> + */
> +subsys_initcall_sync(cxl_acpi_init);
>  
>  /*
>   * Arrange for host-bridge ports to be active synchronous with
> -- 
> 2.39.5
> 
