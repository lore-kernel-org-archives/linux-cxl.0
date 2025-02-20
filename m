Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8324BD1C
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078804; cv=none; b=JKOoy1BlXgMcEWpPqOzT5l+uJFqfisx15Vxpc3F8eWv2W68X0aW5nCcdW7DmOvMYjCPrXkmM7+IY46/PUmyMl+qwz//64zCgjbn9gbBSmsIh1XurIH7pOwffaA3TryznjGlH64j4XRp7g9D8LZcHkf5/sQwuipPWGDKMA+Xb05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078804; c=relaxed/simple;
	bh=3ju+Fge1vefH4rJ7oHab4mwdT63sJzOAo2WkeZe1IsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHeJ90LrG0xMtP6bgWTNwJGldEExRSavWeX/kEmxwO7YGLi/J9B3hbCQhFUz4ic0U40YupeGCmRhIkU8ZNBvzxnmaTeeLYw/vBhLW7bZAxMjUEfulV9PeDDPA9rCz3G1LpDOULMGYJlQxjRhXBLtappNG7HKAEhiI+n02K7dpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YRe0ouD8; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YRe0ouD8"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0a1677aebso122522085a.0
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 11:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740078802; x=1740683602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNx9JrIVabkYve1PD6+5XRax/4bHll/Ja/FL4uUPxuM=;
        b=YRe0ouD8vryCVVMEU/Wf9SG3jLxWgZZY3b0m+wZtLy+O9/srHa6sfPbXdlcsb1WeNw
         Cip8lhHRudkVU9Vt8twQ+qYohTfpjQHdM9cnOmb79JwkldVVutTWr4XvmZczOYGBYdHr
         ZIBPoAhFkVXqsPWtCK2+dBPNs1mrfJMReUtN6tht86ZejSN75yR+LTAC+At5x1w0zVUj
         MkX2+A6bCOe+BjCoJz7xVsObj73R7WW2P8+wh16BK40dgEX9fqDJnSYbA3o41QxdGzeC
         BkejS4Fnmfe1d1m7M7BPHaCHyFov2uk2iGdHIf5GQ1ka6MIIuY2QTH0EEBS4hvRWR7hJ
         gIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078802; x=1740683602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNx9JrIVabkYve1PD6+5XRax/4bHll/Ja/FL4uUPxuM=;
        b=ry3HuMAMjNQRXJ7JZMTFEz373B1sVZUXQNg+HeyVS84ThIz9DWIIcXtyUYLKjH/mA7
         Iy/0C9sTpm48itWv7BnCXAMbuKnZNcbRhYyjfuy+yi+OfBv6eGjkRSF+iCtXv9M0xoSN
         IU/aaZuqIApAZR6FHGwBFgU77edv/xLRbDJioOqRHv6n9SZZ61/SkvDCMxfCMnSozqD7
         LvRDDT/NUBsWK8+n3LSR5BpD4gjJBV5VB89TSXxeSyQ1UMqOjSousbQ+RpUslqO8Xic/
         qoC3bNi/YpwDPeMxw6aYdXDMl2IB4RmsJ2U7X4OcwTN0nCujwya1qh0IQZoHOPav2Cyf
         BSbg==
X-Forwarded-Encrypted: i=1; AJvYcCV0h6C8KyS5dwh37TDXdGWJ3G4KDgo5D0Z6II3IQALKs2zA6kl5u1EM8W1CWQbE+JJQIq0GgbAqWXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr188HoTbfCdVKUWaolRu/5G3ErYrajToAzxGCow3i4VXYl+pv
	5yMLSvSy2BoUBFOeBhY64gnv+KtAURvJLFNb8QxNsxX4gsfqy1gHIUuqI5GczuI=
X-Gm-Gg: ASbGnctgtAUSnauOatiNQ9Q3TAVpq7x7DHSK0fXUgujs3Z/diZy3eFb4mEdl74cRMpI
	zOAnV+NsJr3ujv2qxqwB8Bwor3cFSSEmyq4PdO7sPmUprbIPz2/AHLPd+lwDbqfLJ0C+Z/bxhnG
	8+NtaclFSzQ6/mT94t+TyF5H69RGqUwim+88G95klMvLRcGfCQCqai0V34J1T482CV536Ca4yUa
	w+AdulQCGPx+OfNrzX2V9aIuMgOJa2W9eronNGq9plaejsWyiOoNDXbPc2g/K01pi65wiUkJxQS
	5oPs+BXC0vdlUsMgxa0j0VDQhtymmuFtmZC/KOL8wmgZGG8eTbG6k3EQk40eUTEZJD0vY17ylg=
	=
X-Google-Smtp-Source: AGHT+IFQN9nUHNkBphF2rvfCIhCVm6Hj1N0F070dzNmNKy/cVT7UuqEFg+GppUV0fFHN/1S/dwR13Q==
X-Received: by 2002:a05:620a:191f:b0:7c0:bb63:5377 with SMTP id af79cd13be357-7c0cef66889mr51580985a.39.1740078800600;
        Thu, 20 Feb 2025 11:13:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b424d51bsm269027185a.77.2025.02.20.11.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:13:20 -0800 (PST)
Date: Thu, 20 Feb 2025 14:13:18 -0500
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
Subject: Re: [PATCH v2 07/15] cxl/region: Use translated HPA ranges to find
 the port's decoder
Message-ID: <Z7d-zqJBVD7KNR4_@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-8-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-8-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:48PM +0100, Robert Richter wrote:
> This is the second step to find the port's decoder with address
> translation enabled. The translated HPA range must be used to find a
> decoder. The port's HPA range is determined by applying address
> translation when crossing memory domains for the HPA range to each
> port while traversing the topology from the endpoint up to the port.
> 
> Introduce a function cxl_find_auto_decoder() that calculates the
> port's translated address range to determine the corresponding
> decoder. Use the existing helper function cxl_port_calc_hpa() for HPA
> range calculation.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 60 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5048511f9de5..6d5ede5b4c43 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -887,6 +887,63 @@ static int match_auto_decoder(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> +static struct device *
> +cxl_find_auto_decoder(struct cxl_port *port, struct cxl_endpoint_decoder *cxled,
> +		      struct cxl_region *cxlr)
> +{
> +	struct cxl_port *parent, *iter = cxled_to_port(cxled);
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct range hpa = cxld->hpa_range;
> +	struct cxl_region_ref *rr;
> +
> +	while (iter != port) {

I understand this is used to map an endpoint to a region associated with
the given port.  Is there a scenario where `port` is *not* a root decoder?

Seems like port will (should) always be a root decoder here in practice.

May or may not be a useful check on input, either way:

Reviewed-by: Gregory Price <gourry@gourry.net>
