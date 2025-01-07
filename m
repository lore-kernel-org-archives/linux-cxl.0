Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B319CC06
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291753; cv=none; b=EmeCziNZZadBrRadTR37sbadKgVUGBXEUQq+rlJmjBtB6BZQeDLtocWz/4tCBWHDzBiPHvMFWS0oDpROKpL78GV8LbW6E1EavnMSMdK3q8FwYka6XpDW8fgWKdZwnF/yNEyvgRT1Uf17nVot2+gqdBqQZy6wP+N595kOKL08oFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291753; c=relaxed/simple;
	bh=pFWxezqT1DI9DyOHFcLc1OHERgqhPA2pIujd56mDimc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUZB0t3qF0VJJwF1wYntsRssghihTegEvaoI0CyzLH0S56kCqa5CSH16u4LFkTzxHQe/0xPojfXKfbrI/7G+U1NYpYSOL//OoIbAqgAH21wHAhmuUaoxlqiBIdnMvDRjuxyHttbIIL0phJV3EMVHu7dmqumA9XMQZFG8wq5/G0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B04tndsX; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B04tndsX"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6e8814842so1389550285a.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 15:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736291749; x=1736896549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XDu301wq0XXZyuFF31qT5Gt5XQlAyFuyRzWIQ6zdlao=;
        b=B04tndsXTpwCyjyFI8Uyte/oYdh9fqzkzG7MVEJIM+iIe6Nkte1X2p5TNOyboATi5V
         b4x8WazsmcdDv8bSqMSMsgtpO4xpU3Mh0HDRkgV9CI80Zye55fXm/KSAd/D06aJ0robX
         S7rr16/m6M6J7EBBi+avRGkcMaCqa36Z8NjCtoPnd2iX6SuA5Z4E/lflOGQBb79Z4wHV
         W9H5qmXD9CVIGAEZt2/dIXYnipT9b/oLdusLrsZa/YKF6lZ8JQXn+2u8aSHWAdVfzW1v
         j6oAk/odRDyg5rsHG3ZcANdAIbv93qpfjbsHNslNM8idLAr/OvALmqLuMcOryMOAxeDC
         0gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291749; x=1736896549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDu301wq0XXZyuFF31qT5Gt5XQlAyFuyRzWIQ6zdlao=;
        b=AfXerasqggkqRjCQxu3BL3YPfpL9EgbZEkFDI/Kol2liDPsnarLtZpBHoFmQlEwJWu
         lPXKpMU4outmaTVWBNcCvvkV+mkKsyIAz5unKHHLifLYyFC4sLj37qDX6zknGuvW1/wf
         pUNjycj4EN6k5KApIyL+mKzdichFxiFR4H/2jcbFvs0V3SILIZQHSMGnpTAAxDkySnkI
         BGFj6D/9k6UjTEYMFAft9xRCxQI9FwRocNVGpyXr9FRJhi9dWZ9zK351wtqKjPSUl403
         2+a3nTQypru0iOSHD5BwWX7/BM4AjFTqyxs67vsU+ZagsbyrfCR57h8ar2Xs3IxicpwN
         R9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXf9Wf2Q2JNs2sww6kPEBXwcZlM0Eouk0CZhJFIsPhb9GC4oa0ucML1tmNM1qwWsdgBkLcwfgj0wUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHz0n8dC5y1lO/p+oYc8Ks3HOXDu/gAPSpunoIDPiP9V/aHnKY
	uGhDsFQEUDiX+FYkkaTXuMJGEsr/hd/eWKwf1rtz5tKz4CWmhnUWHd25qEyOJc0=
X-Gm-Gg: ASbGnctUT+6kp9nwBhiCIaEMYAcLJRJmMLVRlu8XXy/9KorngCcZmphy+S6r0S8GsWm
	Vck1Y1ZJdpQa6Jt5IbkiAmEvsleV7QSMRen93uB0f7+DL1KLCBI4zVLdEug1cB4zZHdwMOErjPp
	Iw9b18JMdF/BreR2SaBkjI3Zzbx5GIDoCKXs4RLKGboOjg8JZ5DlSHhP3VrMqbw6nXmAiVGGQYR
	sfT5f0i5TkbLnjh9fMJchfNgra1Plbbox6D2y55rcoe3QodC1qHEa7OYdV336lCV/cxyjPbd+s7
	nmS6vL5n7+tpRiNYjGS9k53PlyJkej2iSSuzbZs=
X-Google-Smtp-Source: AGHT+IGCyYNP6+U9degSlxI/9qiTXJzW7crFVEaR7ZDLnuYAgfsJfmvGKeYRdtlzMkEDPKVcVvI27A==
X-Received: by 2002:a05:6214:23c5:b0:6d8:890c:1f08 with SMTP id 6a1803df08f44-6df9b2348a7mr16328936d6.26.1736291748889;
        Tue, 07 Jan 2025 15:15:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd17fdc7ebsm185156236d6.0.2025.01.07.15.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 15:15:48 -0800 (PST)
Date: Tue, 7 Jan 2025 18:15:46 -0500
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
Subject: Re: [PATCH v1 29/29] cxl: Show message when a decoder was added to a
 port
Message-ID: <Z321ovYSCK9pJjxD@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-30-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-30-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:15PM +0100, Robert Richter wrote:
> Improve debugging by adding and unifying messages whenever a decoder
> was added to a port. It is especially useful to get the decoder
> mapping of the involved CXL host bridge or PCI device. This avoids a
> complex lookup of the decoder/port/device mappings in sysfs.

It would be nice if we could create some of these links in the absense
of the full configuration, but I understand why that's difficult.

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>


Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/acpi.c     | 10 +++++++++-
>  drivers/cxl/core/hdm.c |  3 ++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index b42cffd6751f..ac74b6f6dad7 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -421,7 +421,15 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	rc = cxl_decoder_add(cxld, target_map);
>  	if (rc)
>  		return rc;
> -	return cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));
> +
> +	rc = cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));
> +	if (rc)
> +		return rc;
> +
> +	dev_dbg(root_port->dev.parent, "%s added to %s\n",
> +		dev_name(&cxld->dev), dev_name(&root_port->dev));
> +
> +	return 0;
>  }
>  
>  static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 28edd5822486..7d6778f908c8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -34,7 +34,8 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (rc)
>  		return rc;
>  
> -	dev_dbg(&cxld->dev, "Added to port %s\n", dev_name(&port->dev));
> +	dev_dbg(port->uport_dev, "%s added to %s\n",
> +		dev_name(&cxld->dev), dev_name(&port->dev));
>  
>  	return 0;
>  }
> -- 
> 2.39.5
> 
