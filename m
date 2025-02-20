Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3F1E883E
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081443; cv=none; b=U398jz+nbT85YldnRGRRtbrFsuAZJB/dq9bnXdFtbYRMLQCeXU8QV49i+Z4i1fn4KcEGsTMxl8F899WyFS7OWa9Yby8jrYjeXpgOA60qUToHF4nQvds0FxLZIu/LoAnAHIWS49ns2evHv2Aszx1+rDsiU8wyjKDhIDXG3S8pes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081443; c=relaxed/simple;
	bh=7bUrJ1Cjqb2EiUJGa4KTWG7F8qOdrjd3V9ZbYf2XJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTpR/eXqDyQxJ1VMqnHANLrLlcw+hgdKKHizLvBbCKeTcRJVhg8rPQTEgTvcruGrSs0HyLirWnKX21tkE/J5snJ7UPp5iNggIqNiM1TzgGVEBJUStatmyROmWOlbsZ965PDxmHN2nfUVjvQoan4/Qe9rrza25TfO0ao951awxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Z1Yowb9l; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Z1Yowb9l"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c04df48a5bso138101985a.2
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 11:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740081441; x=1740686241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUhOlff27U4QoWDOX5P1YVDFfN2sk4tXY1Rf/8iKATQ=;
        b=Z1Yowb9lxccYsNR3ecyU9GJ80VlKfnOmHhtHu/mPWj9DxQ0wBbIGLvFuSpcpq9JekH
         homPPGJlDOG5xy3AD9cWi371EIAiXdZVcr/VRW48+DAuzquUArpvMBTRTHJCBRkW/dbq
         8L53ZdhrJK42a+SdHI+Lyvh+TovjK03KhORXDDA3O7uimC8I4QlcZNJsG4GpogPXDH/a
         AJTYdVqlsLAZlaEdXz+8Z7/Xg+tiiS0aEZwYWkNwxX5LFfzyoTREKQsQFUmLcsM4AL7R
         hO+YsN7miq1TVcozlwfEhSEJQT7u6u8el6PVJX7OaDu1yx/u0HZpGoE959XqquejVV+L
         JXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081441; x=1740686241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUhOlff27U4QoWDOX5P1YVDFfN2sk4tXY1Rf/8iKATQ=;
        b=CUoXhQ5aBPm56xHH7sYMEw4GqEtzp8WIuV6WcT9DBlviZTPYFmexmGt6cC5AvWt5BM
         SBVtkiT8gospBn8QxJgE1zVmXTe336C7f4rpmM+CFeTWI/BWU7Wxs+PXuepnYltXI+S9
         S8buVHVzlshR2i4LIu0Ze81jRC/IFGGPr6H1U1qc6yBtxQl4IF+ZkVUaWwrfnaCpM02C
         xR5DMo8oACC6xF+lUjTCn6VyHBLqag8EmFvQqTdEdfhqBRdtZnGFPo097yNiliqKYYkb
         JjWBToI74gz7CjRjCYJ/x1nEJDK+FCXUPRswGM2qHY4D4DQrV1Oc/a/xs6CBXfY7j/wD
         fnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDRX4ABTlv16PKbQ/11xXY/d62nFQ6WUupWvKxbEN2Q1YVPZ1MErvuft/EUHfMlCbECagy6bp6Rh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eFrJ5rGbEDlvmlDNYzaM9fdIdhYj3DsNWL7+/CAkLrfXUbex
	SUhKzRekRftvfGvwWKNhtWYiGgH1/EhYL3GDEEm97gO0mH029G0URHWjNuZmMJ8=
X-Gm-Gg: ASbGncu2uhjJ87ipvT7ru9PWL+7RepyRQFEFMdZO1MudD2QcnR+iGqEKlOmH2ngGbVC
	IdoQDWQkpssikSeL2RpHr0PZ/yYb/oQ5w3/TD3rgX8UQHL08qntoT53TRV+/ATPVo1gJfV6ppEv
	ewUBJxB6+YEMEFHU6Q++diwi1qboCklWKPzGTD+Jy+HM2PiFNo2efcIuRVKIsrHEvPiBYAYgbbK
	RKeqNpMWh/Dyj3TUZ2WdSXNKS01dP4bJk7pg7ZMfZ6iyttyVvwAcZLo6/9TR6SIPlBjAy8GN83v
	Exlnl7b02NyGKbYQIb/dHa1kxOAYOwNUgYZ1oY7oBlIRAuq68DPyX39QmdKQAbVSlRBNwGUhqQ=
	=
X-Google-Smtp-Source: AGHT+IGF+v/hS/yyKv5D1whZamS+A1vgR4WWuNyb6f+i2eFGhFkLObm9Oi2CTo0XkJ9/LAnLFRGlwg==
X-Received: by 2002:a05:620a:40c5:b0:7c0:b0a8:52f1 with SMTP id af79cd13be357-7c0ceefe6abmr85895585a.13.1740081440746;
        Thu, 20 Feb 2025 11:57:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a8cf5eadsm405080585a.11.2025.02.20.11.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:57:20 -0800 (PST)
Date: Thu, 20 Feb 2025 14:57:18 -0500
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
Subject: Re: [PATCH v2 12/15] cxl/region: Lock decoders that need address
 translation
Message-ID: <Z7eJHpJT2j-2BLvH@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-13-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-13-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:53PM +0100, Robert Richter wrote:
> There is only support to translate from the endpoint to its parent
> port, but not in the opposite direction from the parent to the
> endpoint. Thus, the endpoint address range cannot be determined and
> setup manually. If the parent implements the ->to_hpa() callback and
> needs address translation, forbid reprogramming of the decoders and
> lock them.
>

Re-reading this explanation, it reads oddly.

I think what you are trying to say is:

On platforms where endpoint decoders require HPA-to-SPA translation,
decoders cannot be reprogrammed due to opaque translation done by
the platform's memory controllers. When address range is modified
(translated) lock the decoder to prevent reprogramming.

Is this accurate?


> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2ca24565757a..dab059ee26ef 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3410,6 +3410,17 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  		if (rc < 0)
>  			return rc;
>  
> +		/*
> +		 * There is only support to translate from the endpoint to its
> +		 * parent port, but not in the opposite direction from the
> +		 * parent to the endpoint. Thus, the endpoint address range
> +		 * cannot be determined and setup manually. If the address range
> +		 * was translated and modified, forbid reprogramming of the
> +		 * decoders and lock them.
> +		 */
> +		if (rc)
> +			cxld->flags |= CXL_DECODER_F_LOCK;
> +
>  		/* Convert interleave settings to next port upstream. */
>  		rc = cxl_port_calc_interleave(iter, &ctx);
>  		if (rc < 0)
> -- 
> 2.39.5
> 
