Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C02190063
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287883; cv=none; b=OHpbAGy9AOkKMFIULufEsP4VUa2lLSmPHZGSK33/2wPRyNpLCxJ39YuFfM9dCFsl5hNvrZDqMoXzcWx/HwTXhGW4QHKtuQb27siDaPTYkuVSMMZ0CLR7FufIc9jtGqIsrMCPbHqSL9Y1j1njUSjZQ5jKQPm0ayyF04RdmKpeHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287883; c=relaxed/simple;
	bh=z4Vmfgn+O/OSj4UC/6OVTa6AfwvKJuTth0cPv3Aw9M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxHFBVMNup6wmr/qxZFJK7fp29tKxbbxSKBi1sjLmSLxCfsN2KK9bPkXSRsvd9uQinQ4JkunNweragM6cHbujLUBIvJaq7Ulu0xBnudKwYuilVgYOptBprhXm6jW1iJDqeGqyKKD4AfkaMK0qBjqPtzLMr25xZPCKgDjRxEtWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uiXLblsx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uiXLblsx"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467725245a2so107189751cf.3
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736287880; x=1736892680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1nrG8KENphRBU6xE2gJeK+jv2lpPnut1E3vj779B2g=;
        b=uiXLblsxpOO7UFNzxkY2w1OU7IFZN3M9zrXfjpN3Ufdpg2LNRNDebcejL1+XZ76C5c
         1IWB3jDbgKiEg3LWE3qdbEiiFbMvDPePELdfwRBQr14vNc6rTw4wyvGLoacvcfWpKC2y
         Lt6SKkL+rtVjAH/MM2E2cDdU0xOyDA6dLM3fUYD4s0Aa0ffOEn1GGNxq2AkGCqQSQsSN
         /pVycMoeYly21gISOh6G4t0I6IZ4/F/y1iIoQAp225gX1qnwGP2QsZAuJdSvh3cwX6ue
         qWv9Y6lCyDiMQGux4pT/FUH27VGDnDHURAKABLFhqwsqc8ChzY9yIDDgVUaKs+vo94Q4
         Cu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287880; x=1736892680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1nrG8KENphRBU6xE2gJeK+jv2lpPnut1E3vj779B2g=;
        b=hkCqlnblcRpaulEv8i0YTRFO6yc5T5VriHFvGjud3jGdaT4jywKqu0svzZ8pjXb3JL
         brhQkRaX/p9TxkTGROEEJDLfui2wrKwb9mgPxFxuRHALG8VvyTgF73sCIy4n2wQHBOGx
         Mau0ciQKp11USxaF1NfPRZB2xis8SDKvyVKNCSsRwEFH8UOz1dFfTqxKn16K6L5F1P32
         91SZQ5Ozbl0OwmrDmIZgIGN9fu954MY2YA07G8FosEFMhADiCR4BG2LdqgAZ8z86E4rU
         qquZYbfd9zT43dxupEM1laPvGAh4kq6Iw2uja/umpXedxFqKRfz8ZtaCVQC1eVjl0lve
         M6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2eRFJvukstmFZoMMLrN8Vl/MiWe8IEdnjBN7ijT0pQN1pLzC3BJjTDv/FwyOT+WZQvUo2w74mkss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7ogski9ruyI2katJVggAZv4KYEu5OYJSEf2HkYYnseA8hh0n
	PCoV2yzNVRQGlEqaWfzqWTAOaE4Xs1kG+ZfBKZJ7Bjmv+ookuMBfThztjAvnv4o=
X-Gm-Gg: ASbGncvzwoh3tFvjiy2beMcTnKa99bGv6PoF13+MCyAnp3SyD6HD5rRZceyEtmsAWw3
	YIa6uAzzxNBA/q+4ZLJUB6QF7fTt64ywqP3+7gm+oazpz6Fxt3qGIV7o9Zz24WV3WJVV5VAKQ/Z
	MLisEZCHL9bzAW/PQzkazHYFH3MgAXMcMWaw8l204EjOiYRYAzlmqnVFPYEHQtS+rgmASSaP/4p
	3Krtzgsh5cjw/CETClKMNBUrEyY6RWET60xlm0cVvObvidH1cwavSquObTibWfHDC5ZUgzPVVKJ
	w1sXStaZei2FQuF8BWt2HytoYmlffmgbZsq6EXQ=
X-Google-Smtp-Source: AGHT+IGDu4UlRwDmROTGjDdJMYNWwTuQnPHkXfRK3kxqx6LqAKPurhWrloIiQ7wQQM2gN9pM9a+DWg==
X-Received: by 2002:ac8:5d06:0:b0:466:b2c9:fb00 with SMTP id d75a77b69052e-46c70fd30femr9603021cf.3.1736287880426;
        Tue, 07 Jan 2025 14:11:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e653f52sm190191541cf.16.2025.01.07.14.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:11:20 -0800 (PST)
Date: Tue, 7 Jan 2025 17:11:18 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 18/29] cxl/region: Avoid duplicate call of
 cxl_find_decoder_early()
Message-ID: <Z32mhhNyjN_lAnzJ@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-19-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-19-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:04PM +0100, Robert Richter wrote:
> Function cxl_find_decoder_early() is called twice, in
> alloc_region_ref() and cxl_rr_alloc_decoder(). Move it out there and
> instead pass the decoder as function argument to both.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>

Reviewed-by: Gregory Price <gourry@gourry.net>

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2bc2028988d3..b7f6d8a83e4e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -928,7 +928,8 @@ static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
>  
>  static struct cxl_region_ref *
>  alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
> -		 struct cxl_endpoint_decoder *cxled)
> +		 struct cxl_endpoint_decoder *cxled,
> +		 struct cxl_decoder *cxld)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_region_ref *cxl_rr, *iter;
> @@ -942,9 +943,6 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
>  			continue;
>  
>  		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -			struct cxl_decoder *cxld;
> -
> -			cxld = cxl_find_decoder_early(port, cxled, cxlr);
>  			if (auto_order_ok(port, iter->region, cxld))
>  				continue;
>  		}
> @@ -1028,17 +1026,9 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
>  
>  static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  				struct cxl_endpoint_decoder *cxled,
> -				struct cxl_region_ref *cxl_rr)
> +				struct cxl_region_ref *cxl_rr,
> +				struct cxl_decoder *cxld)
>  {
> -	struct cxl_decoder *cxld;
> -
> -	cxld = cxl_find_decoder_early(port, cxled, cxlr);
> -	if (!cxld) {
> -		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> -			dev_name(&port->dev));
> -		return -EBUSY;
> -	}
> -
>  	if (cxld->region) {
>  		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
>  			dev_name(&port->dev), dev_name(&cxld->dev),
> @@ -1129,7 +1119,16 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  			nr_targets_inc = true;
>  		}
>  	} else {
> -		cxl_rr = alloc_region_ref(port, cxlr, cxled);
> +		struct cxl_decoder *cxld;
> +
> +		cxld = cxl_find_decoder_early(port, cxled, cxlr);
> +		if (!cxld) {
> +			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> +				dev_name(&port->dev));
> +			return -EBUSY;
> +		}
> +
> +		cxl_rr = alloc_region_ref(port, cxlr, cxled, cxld);
>  		if (IS_ERR(cxl_rr)) {
>  			dev_dbg(&cxlr->dev,
>  				"%s: failed to allocate region reference\n",
> @@ -1138,7 +1137,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  		}
>  		nr_targets_inc = true;
>  
> -		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
> +		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr, cxld);
>  		if (rc)
>  			goto out_erase;
>  	}
> -- 
> 2.39.5
> 
