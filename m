Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D1214A9B
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076931; cv=none; b=ot/Xp7fSLFvjELfq74W8GNPA6YJNViOsqcDWTPP4Dbo/bxkUw/uglskZ/xVM/cY0Dm531rixi+1bTKy8NWkysVXe8bmyDqyxDJrNxRYKavVSf+XkkRS8sUtVRGJlTVMdkRPiDxNaXcqNxgXg+EJlIYb5f8u9K0Ks3jr1zdikhyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076931; c=relaxed/simple;
	bh=p5xm1o22PRFvmKnwXPUj7mBJCX1wDvSvLIhEab3PO58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY1H9Y1Bsooqf8e45ip0A2VXreuVPGkn70393rXGbZeZleBSg32PZWXcQ7aV9lhJvnrbcNWcKwONnIwcReF0zMi4bMTbtFfNgtx6sk82MPTK1HdYdUaHfkqDG5bOF0ibfpJAxnIUqdWyhYVbv6kXLTxXu88imKQsbCbwsHFK4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=l6vwVNjq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="l6vwVNjq"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dd420f82e2so15723326d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 10:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740076928; x=1740681728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gx0W/uUZlTRGbJlDEomLybSdty7XE+fwJpN36vGWqNQ=;
        b=l6vwVNjqQOS2498+ipxt3sNWZMLteLmYoVkpt8+lOiRxwyRoa7fx9XOHopubJmCf9D
         vPxEZotp15CIHH2mK+snURXqWPwvm3a6KBltG7Jhl+CL3fXOGQvqIWLFzGykCeHDX8uy
         g4y9Kvd20FLElnGl9dTEedTV1S6BJt+5N7YSmoL2PvEJ77lC2QD8wQ9B0ym1bzbaM7Bn
         yXHuNbADzdeDR4jvufGQPpb17tIEtvtnqkermr1xh7G+iZn7G5m85lm6A42HBehCXVak
         rkt5mTYv3Saie7mGH4pukmhtWoHGhKuGGm0KsUlty+g2GJlMwQ6cpIBqsJp1zGJf6P9J
         Jdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740076928; x=1740681728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gx0W/uUZlTRGbJlDEomLybSdty7XE+fwJpN36vGWqNQ=;
        b=J5haeEz/SUF7BCW13GEo4dRRAm8MFgwqIuh+47/bqa3/D7F13q1L7a+qIMkdcZ2LMH
         VNb5pMlnrNQM/LNSQWe55DqwWxR0snkf+3vWUiP4A+AtFPQuZwhcV2Cv+7UQGdGaIz2z
         hb9/eIPQezJJFJAfeg7Dhj4KK9lsq+wqiOpaiPswLR0Rcll3Zyv0Fb9ucp2tXXO0C3sA
         9EmBdLjO4mp2Au2eRLXT6QJ1Su7My3gt3Pfm9l3NnGL/eTibJwui9zQ6qsunEPiL8Gyv
         7T7/teJCBC8viebdgcTQVPxfHA0baJ+VFQzMGZkEgXCpjTWUZ9LEb83DrlRuFo3Ig+Oe
         gAxg==
X-Forwarded-Encrypted: i=1; AJvYcCVs0jIuPVPsIswtMnOW2GJYFjUpuvNXezh85bmzO7ZzMMmfQEMrj1SqbhyfPeCC4nnEtIY5zqT+yZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2kISmASi/4OehFAtVZvw6sLzdhq95lEZQiHsXiLEkOwKQEJ9j
	BIz/W0t/To1pZqy5bqs2PyiBLdbHv9ZEDVWRyXcFSH5PDbkLnibxqV/+a/nmXH8=
X-Gm-Gg: ASbGncssmNCf3pp2OCQhVZ3MaxHjfKAeC8tCkBMspj+tN4Ur4+iRZG3ofaHANPWown1
	nXzNZgD9o4SaH0qKaThMFAnOqJ16q10pAjsE6uZQwlyxLr43KKvYS4mY+4THA76kkhcqqdDmQEv
	bDpfaUVAmDrv+OC63HAcULBIdBdSTQ38RLlPKW3V0KJJ0ufGVp0L9yA6AxR+5lc3HthLrgEmFr8
	Km4jvusefoyhQ2cByD+N3Cx/6DaLivvdGSJAS8a9nD87Ia13IEJAx/KQYFBSx3dA5nVJpXJVJJO
	Hvmz1zMbfxS979ydrNzzkWiJRyAEftYGn91VXGmz4cmJ4UtLq5G+XDdZ4n4XlsklghUFmE6uUw=
	=
X-Google-Smtp-Source: AGHT+IHxs7YJJAceyj3jfJdQOg1vrzRGu2Ox2ngK865GcPb4UiuNqVh3X9LOAtp+SMVMNER6i4rkEw==
X-Received: by 2002:a05:6214:e8d:b0:6e6:9c39:ae4b with SMTP id 6a1803df08f44-6e6ae9e2293mr2780336d6.42.1740076928276;
        Thu, 20 Feb 2025 10:42:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a40bdsm89111136d6.59.2025.02.20.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:42:07 -0800 (PST)
Date: Thu, 20 Feb 2025 13:42:06 -0500
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
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 05/15] cxl/region: Calculate and store the SPA range
 of an endpoint
Message-ID: <Z7d3fuL_YuwFWM2n@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-6-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-6-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:46PM +0100, Robert Richter wrote:
> To find the correct region and root port of an endpoint of a system
> needing address translation, the endpoint's HPA range must be
> translated to each of the parent port address ranges up to the root
> decoder.
> 
> Calculate the SPA range using the newly introduced callback function
> port->to_hpa() that translates the decoder's HPA range to its parent
> port's HPA range of the next outer memory domain. Introduce the helper
> function cxl_port_calc_hpa() for this to calculate address ranges
> using the low-level port->to_hpa() callbacks. Determine the root port
> SPA range by iterating all the ports up to the root. Store the
> endpoint's SPA range for later use.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
>  
> +	/*
> +	 * Address translation is only supported for auto-discovery of
> +	 * decoders. There is no need to support address translation
> +	 * here. That is, do not recalculate ctx.hpa_range here.
> +	 */

Can we at least add why translation is not supported / needed?  Just
saying "there is no need" doesn't help devs after us understand the code.

With that change:

Reviewed-by: Gregory Price <gourry@gourry.net>
