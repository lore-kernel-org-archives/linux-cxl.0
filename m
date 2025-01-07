Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24F190664
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736289195; cv=none; b=CiDVRTp+mmL2lLcwZu584WFY+W+qx//MJpXB1DXuQ5kywvTBqKTd2144jONdKDEZA8VC5UF/YuNMvY29kE/Ug/q8l32CVcySmWmgF3QiIDhG6/76s0j3yPQ4DyL1AVpY2MER+qfUHIwUPL0NTTxfLfb92TFyfDxu+sR99aqapLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736289195; c=relaxed/simple;
	bh=tNwgxqOT/vI/GIvjoscnIuOyBkzLYkjGKwTFuBByznA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ6o1+pwXegB+qwc5WryipqcA+HV313RmhmR9BIyEW9qlPI/TSfVu0JI6LykzK5vaFZh1JNQwvoOs0jrlX5CuLQTXTjUehR7TO1qgQpI/kdwmyVguDxZrZHg9aOJNkUY+k74yToJ+2fx6n83T9VwQ24C2PPhg2YYCI7Znn/ykps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CNUoObEj; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CNUoObEj"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b98a2e3b3eso795818585a.2
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 14:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736289192; x=1736893992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpX6JiZ5ixPvDUx6ndbdQvSLHYQ9YjrroJ3HRy4IFyI=;
        b=CNUoObEjso55Fh6dCeqhr/ZA2Ojq6dUwbSBYCY7dz5MNlfkDsjw9jK+pxEVatkP840
         WzOIXbhakXurZ9wyHBuEXrRRlMbkc/noWWA5uDS5vNivvQvFXR54ytGGSK5UF8YWPR82
         FgRVRpEKt/kiZ92CKJ/+KP2evZlHJAeBVcj/PMVicwAAqymUPkHqQWKQP7f1VnTwHipl
         iTfvS1EIpk/asI2nInOb80e4vTgMWprh4/19zlWNokNe/rAeA4/pfsteQtaUD/OZFJMC
         v1jUxdf7Iif6dJ/h1cD28g8x3mQd35tgd0voDPUL7kHAq1PbP46+sB0JPnvkYyKrpCu6
         Nxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736289192; x=1736893992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpX6JiZ5ixPvDUx6ndbdQvSLHYQ9YjrroJ3HRy4IFyI=;
        b=dJp19MRfIVeVm85YAJRdi8JXuqzZ3qtLt/WWFGhmewcW/QoLYcWWLwl+3v/GLfkOP7
         5nGNuq5rwa4WOOuLNgEV7CH+kbtvjmeTfGdaXWvEWFiwB+ekDzCx+QWzscJHopRqTZjr
         TMImWcOzrHXAT9XTuoUteCPTAkuDo4m8vWJiy1h+U9ox5wt43L4lo4LWm8d4GTY7yFaV
         muzMm7uDxUyN2SjOmhwXKylsqz5S7GfdKWTJF8qEfyBGdLIwZDGPLYF9FP+azrHyQp/J
         wrV2kwXWKGkuOLJShYj3zRK2h0nSRsP7qPAoAHA2LowsYLwVZtBf9ND/hCC7eXL8G5sD
         MKzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Y5ApnKiD7twVDpHieYCKPWCoJ1BEJ4kP9kSoKUEknj8h8NeP8QvUyQYypumjuCdWOgOUdsRLfjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywsuWbd+HRfdLjDogKk4fbsETxJcRMD94333yZKVyWg4c2Shs
	gWkJIdtKpoiACJJbBwWgLDbcpjCkJ7YFM+lFh2CldqclMuxYexZfWSImXBFS0tM=
X-Gm-Gg: ASbGncspu1oGPtdG+nMjQjYg6VNgcHRiFSHRz6NhKzt1o9uI0YUepAW3Zy6kCNWbmEH
	koWOTgnk5lr+DFWx2K1qRcEUQpxNPHN/DaAW21Z2nIvOGf1UetuVDEO0M99H8AhMUolRV0hALzp
	Ou71+qhDQo1nRxIvrc/9Zn5+LYB3x8637umVwt9OhRuPSp/KZJ2wOWFJOJD0CUGH3DF2TEhuBaB
	bJBbvJr4VGZTNc9xmFPv46B3TOax82Z0zZwx8k3SK8FKSLTJ2kZMMp5Pi5CnW9um3PSaa/v+pZK
	A6J35pK9DKpgqsGvd3dUUxtCZMthnOoAJzXL39A=
X-Google-Smtp-Source: AGHT+IE84BqwkI0EuKCnUHRTjlVelOU1z5n7oTkTtGcNA90GhGXtHXKxlKsG5Wb479y22tMfhN736Q==
X-Received: by 2002:a05:620a:2454:b0:7b6:db89:2e9a with SMTP id af79cd13be357-7bcd970a86dmr79800085a.22.1736289192395;
        Tue, 07 Jan 2025 14:33:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bbcfasm1627643885a.25.2025.01.07.14.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:33:11 -0800 (PST)
Date: Tue, 7 Jan 2025 17:33:09 -0500
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
Subject: Re: [PATCH v1 20/29] cxl/region: Use translated HPA ranges to find
 the port's decoder
Message-ID: <Z32rpXDLIWnoYc85@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-21-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-21-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:06PM +0100, Robert Richter wrote:
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
>  drivers/cxl/core/region.c | 63 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 23b86de3d4e7..8d7893878362 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -876,6 +876,66 @@ static int match_auto_decoder(struct device *dev, void *data)
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
> +	while (1) {

Similar to prior patch, probably we should have while(parent) instead of
while(1) and be at least a bit defensive against (extremely unlikely) loops.

At the very least maybe we can express the condition more explicitly.

> +		parent = parent_port_of(iter);
> +		if (!parent) {
> +			dev_warn(&port->dev,
> +				"port not a parent of endpoint decoder %s\n",
> +				dev_name(&cxled->cxld.dev));
> +			return NULL;
> +		}
... snip ...
