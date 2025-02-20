Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD471DED7C
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081025; cv=none; b=BRRtGw9vhTKlNF9C3XWgdnDBaOPVa/BU3F/Rrsr6vmkhWTABp0AKKYbmZ1OIV0v/niULAx8yNQLqYPEeOEODvGDU+Y7WE0drrd+XL8zBnKnm+s+4Y6dqlwkd2RTOXok3I7vK9764us9dNwjCjxgbBjeVE5Aie3pPwL3yDTsU6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081025; c=relaxed/simple;
	bh=hrA9p38IDspEkGP1O2nHIhWSgfQXQd2krV1yHoiJhZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvM4+byjHPKWLVBT7I7Iz0SK/wxKFD9siidhWvBCdCMVn1AB5PK49hIwqWIkC+dYOSX7Cqdw4T/Z9Lj7kY4zVLmZ5GG740dUJP1w/4YbFI/six/Yir63P6vngy4GEk7w2Dk5gYKJXzxIuwz/UCZsbeBFe76SccAIXJ4CIskmEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XreyP/6V; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XreyP/6V"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c04df48a5bso137461585a.2
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740081021; x=1740685821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vsR/rhOtN1rjKKzwMCE+sYzTv4I88D0Di854W37LUUs=;
        b=XreyP/6VZR+/YlqqsKyd/jk6z18yFsNjCesyjq1uzTTXdRqQI6zR6xijGstcs8KBYM
         wER5BnvKL5jg3oMtzvYCc/UoJpI50wZvZIqz/UF0yY2fRAv+xQ+Oellzny35NYn9wk2D
         qytqRcU0jHxCSZ4s1YRR2cG4aWOz3wwDTu+Lt+GU9TXyd6g9wL+ejrYESAuf2yjxpyIx
         LYe8E8CHrHCXU6F+p6epRmVC7MDXTUnvevQrLSXb4rcUXwkk16tEr/vrWBpcpYXTQlKq
         kyA/rR3Ob2wl8tAqrds6C21gn2tRau7sN2Ovgi4YYhURT/f7SAejJ7RQf8IeXQI1qKlf
         8ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081021; x=1740685821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsR/rhOtN1rjKKzwMCE+sYzTv4I88D0Di854W37LUUs=;
        b=W7TGeJyB407u2hOQ2UYtZKlJ8CuOWQKJyul69vnt206+nVIKCaSAZucHvLVv4PzkQO
         jrhKFhcAx0mJjCyF3rkDIeRZUIAutckxpNc+OG8w2ACMomNmre1g28VKsKWR/AvoJ+F4
         Ng6BA8/tjl2BjT7Ir2G/weisHKqF6hViCsIMBsDWzocHN6zW/CNhjf/+/ZGPLe30Mbel
         R95MVDwuTE58pg/ZKEJQHzoUJdqMqCn3q9xSTU3+oQ5n8quX6EOzVxT2ondqdrOreZuU
         nmb95scdR7YxTXRPNL74MVigs0YKOTtRYCXYdgyVXjDKOZmnaJt/KrwkFF+cn596AxEY
         qZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCUfXOZZnq+VQWUc5faN5NmMySQ7il6wxXnITv+3GFQVv7ow/I9p8taegsrs2G3xQ/ce3/75tdRXGl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznevi638TEZ3QRpaZj5QiScnvZ39ZufIrEKCTeEPHj1XI4N2o4
	Uo5vevgzTuXLcI7FWtVoV90PwZjfTQocVQWufs7hC58fHltbVBJC/DVbWw4uRGY=
X-Gm-Gg: ASbGncvLLbFNfhRLoCQwyhUwxwQi8XL435Thfeo0n/qAV1Teoca/UwwAT3cpJA5ozZ8
	vm3mu6PxX8FJwM03pziAvqRpzJbOSOBdebyjg6chE+4W/ZmxprYHYuFA10F8m/KsL4YcOEWNvG+
	ddcSaWhUDg5a8FzddmqMzsML/vfan/SMpBURJKAZUe/hD/nu82aAAup463vjkiuoMSlrKtyjqKU
	0CYfYqH2JZkdvfnItRytsFyYPbHFC0gKT/5cW9oemwPGmum9zHuMJlJ+Z1dqcREJhKUIv8uF+9r
	YQVtJSOxCI8+yZV9sPNtk4XIP8xjal9VuxmloMcAuUW9QXYH3s/xh+XG7eklBO1OYaw0HRSW8w=
	=
X-Google-Smtp-Source: AGHT+IEpdlOT13ijaiv8n6s5j9ITcvCGGzuTUZDlk5Q68kLQIU9M+/yqHtmw3jOZcJB0IM4LCuCABQ==
X-Received: by 2002:a05:620a:444c:b0:7c0:ae2e:630d with SMTP id af79cd13be357-7c0ceefe6c0mr64848485a.16.1740081021543;
        Thu, 20 Feb 2025 11:50:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0c46f59cbsm98364485a.41.2025.02.20.11.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:50:20 -0800 (PST)
Date: Thu, 20 Feb 2025 14:50:18 -0500
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
Subject: Re: [PATCH v2 11/15] cxl/region: Use the endpoint's SPA range to
 check a region
Message-ID: <Z7eHeuikvako1Xhh@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-12-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-12-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:52PM +0100, Robert Richter wrote:
> Endpoints or switches requiring address translation might not be aware
> of the system's interleaving configuration. Then, the configured
> endpoint's address range might not match the expected range. In
> contrast, the SPA range of an endpoint is calculated applying platform
> specific address translation. That range is correct and can be used to
> check a region range.
> 
> Adjust the region range check and use the endpoint's SPA range to
> check it.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Explanation could be a little clearer, something like:

Endpoint and switch decoders may have an HPA range that differs from
the memory region's SPA range.  Utilize the device's calculated
spa_range instead of its hpa_range to validate the region mapping.


The interleave comments don't seem particularly relevant here unless i'm
missing something.

The content of the patch looks good.

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3afcc9ca06ae..2ca24565757a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1531,22 +1531,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    cxld->interleave_granularity != ig ||
> -		    cxld->hpa_range.start != p->res->start ||
> -		    cxld->hpa_range.end != p->res->end ||
> +		    cxled->spa_range.start != p->res->start ||
> +		    cxled->spa_range.end != p->res->end ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
>  				dev_name(port->uport_dev), dev_name(&port->dev),
>  				__func__, iw, ig, p->res);
>  			dev_err(&cxlr->dev,
> -				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
> +				"%s:%s %s got iw: %d ig: %d state: %s %#llx-%#llx:%#llx-%#llx(%s):%#llx-%#llx(%s)\n",
>  				dev_name(port->uport_dev), dev_name(&port->dev),
>  				__func__, cxld->interleave_ways,
>  				cxld->interleave_granularity,
>  				(cxld->flags & CXL_DECODER_F_ENABLE) ?
>  					"enabled" :
>  					"disabled",
> -				cxld->hpa_range.start, cxld->hpa_range.end);
> +				p->res->start, p->res->end,
> +				cxled->spa_range.start, cxled->spa_range.end,
> +				dev_name(&cxled->cxld.dev),
> +				cxld->hpa_range.start, cxld->hpa_range.end,
> +				dev_name(&cxld->dev));
>  			return -ENXIO;
>  		}
>  	} else {
> -- 
> 2.39.5
> 
