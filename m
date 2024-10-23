Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E73211C
	for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699105; cv=none; b=CNQB3kHLlBnaICn0GjByJS2f8Tyw88kyTGC4g+DwQMFBRC0uZIU5NzhwypCbcnbyMHG6SM6X9OFjPxQdyhuJCc344Bd4HbfZmU3ujPYC/JoHy7Vc2ktLaL682Y6y2PSTONRM+r7d0i5rwXspO6ceMfad3G03WuyPBtZQ6vWmrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699105; c=relaxed/simple;
	bh=qoe2VJnqaslYjU0z1XWrPX5DY6zObFwsrYV18dCA7so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRw3IVO6Ayt61AJ2gIC/P8OtdJD9TzKjHiQX2hzht0rZBKQGz8y18uD8X4H0FzuzPHC0OU2HZ05tI65UW+ko2Yq7vbK6tPO/wo1CWSBL8S9NxbCwmQLO2AHhd1J0o3Pq8gau8SzSY+LCXBygm7RHMhONVBH0/x2oiDnWUK2k3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bY9DVZHg; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bY9DVZHg"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8377fd760b0so277418239f.2
        for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729699103; x=1730303903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVxmtnP0fd1LGV8n3Z0B5B2s2UaPPWZlOmrAuRQeUvk=;
        b=bY9DVZHgfG+6lRhuLXBUexkDk+G2Q1zszcIzpp0e7+JCPiqnJoKEWDR0LMq/T1AOv/
         myHIXJPfBnYcyoNQa9AMR+siPiuplvC2epMZ9gLIKJdEtxHmVFWXiGLdvNSv4sldp1fM
         13cq5iqh8lgvR6lv9e8d1IVvan/kzTQe2XIIK2g041NiK3aJe7Zz8JxXk0Hn4g/Swrpg
         z00WsT1f1s4oHofrISRpNv86gvVTJ0ry2cPv3amstXk6+knxmR/5eSDLtPo0Ne5G/jnC
         3PRqBabce5HkpLbAvKyg2jj29sY4BUoSv1CZxdEdE4+lUZXa+4ZJEXB2Xgcb30vPg//R
         DZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729699103; x=1730303903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVxmtnP0fd1LGV8n3Z0B5B2s2UaPPWZlOmrAuRQeUvk=;
        b=pS9NWT87cJ4e3SMLF2XQ67J0CDHK/1SFb7nW6a7skhW1gQyDYOIvqFxzq4OX9TtUAf
         MVxgi/hQVUdpaFFZCZN0DSi7xdd7R/RnVjXUpqx9CfASn/kWArYIHWfVr+So2jxvaxtn
         qky01PGj5xoDckMI2ufEgcz+u2tFcooY9kCC4aGjihvIJBGERQATpQFjDRrfUNv45iOv
         zsS31poaeuvyCV4ERJFJB1NJUSHgvCikJ+VuxmD2Qqzk0bp4hBABfJs/gztnib6cdkNw
         apVDigyjBH2gbjLX01TvmYk1wvdpEcURb3p22Z6kIKM2WQ+DF0mQA/JAKF8+sh15Qsmd
         mR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNT1swgzED7SzFG+cEqRW5c3Aj27xOhZNPqCz9uV21UVwud+egKA+Y82kXgjFIa3ljz3wo7bXfOBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4w9e+jMZiOt9XrVjp3YgD4fjkFazGmaDfuGEcwm5beU7hlOj+
	EW7CryQEsOleDk7J0gJ5pJ+sdYZRW/G3ZKLvVCMZcA/OEYq+N3FwaONsfpXVASk=
X-Google-Smtp-Source: AGHT+IHZcfunmY4kyy+fi6zXF1t4mvBgcDv/ODI+0sPq58dmK+dRTGXoCXFoH3bWL+kFX3ZPZVzPtQ==
X-Received: by 2002:a05:6602:2b0d:b0:82d:9b0:ecb7 with SMTP id ca18e2360f4ac-83af61534d8mr371115639f.3.1729699102786;
        Wed, 23 Oct 2024 08:58:22 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ad1c93541sm223534939f.33.2024.10.23.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:58:22 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:58:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, dave.jiang@intel.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/6] cxl/acpi: Ensure ports ready at cxl_acpi_probe()
 return
Message-ID: <ZxkdH3H3XJ_-8MlW@PC2K9PVX.TheFacebook.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964781969.81806.17276352414854540808.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172964781969.81806.17276352414854540808.stgit@dwillia2-xfh.jf.intel.com>

On Tue, Oct 22, 2024 at 06:43:40PM -0700, Dan Williams wrote:
> In order to ensure root CXL ports are enabled upon cxl_acpi_probe()
> when the 'cxl_port' driver is built as a module, arrange for the
> module to be pre-loaded or built-in.
> 
> The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
> is merely by inspection since the bug that triggered the discovery of
> this potential problem [1] is fixed by other means. However, a stable
> backport should do no harm.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/acpi.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 82b78e331d8e..432b7cfd12a8 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -924,6 +924,13 @@ static void __exit cxl_acpi_exit(void)
>  
>  /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
>  subsys_initcall(cxl_acpi_init);
> +
> +/*
> + * Arrange for host-bridge ports to be active synchronous with
> + * cxl_acpi_probe() exit.
> + */
> +MODULE_SOFTDEP("pre: cxl_port");
> +
>  module_exit(cxl_acpi_exit);
>  MODULE_DESCRIPTION("CXL ACPI: Platform Support");
>  MODULE_LICENSE("GPL v2");
> 
