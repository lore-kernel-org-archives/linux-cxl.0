Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3911FC7C2
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jan 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351309; cv=none; b=hUpX0hvI+/zPE16EdtnbJL0Zxcei3bQvwA0bc5foY9ytexVymfYsei7QNtJG4CF8UGvwa7vklfdoYstDPidrNPR5EQP/0xiyRF45QYXkkLxG1ZxckoYCa2RB8ojfAHJ7OC8V9OgBivoXQnWp8kCj6h3zk8WYhgcDQRhxIpyEeWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351309; c=relaxed/simple;
	bh=lPPdsgIctYuOR3T65Khi2c+znGNhJ1mUAUANbKJhEYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK5KetT8YaedOKHI8nJ930jFlGxIi+PrRKZIbsIg66R97tCqXnEh4zN+96pDp3Z7RrlAMMrPYBiSJ8Hn4hMsbt38l3qd/mXYqJ85DNRid39p5YOxK+8F1EGfUNAGEnFbusJ2J9pZd0xgv17yMGrb+FwPU9l0euCSu0TvEtOTQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KHSZZB2h; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KHSZZB2h"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so137726656d6.2
        for <linux-cxl@vger.kernel.org>; Wed, 08 Jan 2025 07:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736351306; x=1736956106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UMdEnKACleX9uwy7fK5On8764yRNpf5ZlddHv0JPlKk=;
        b=KHSZZB2hEdrfLjWT0KVFW5cqd5l+DQqMLqejTn0QwHvFExGn6RGnYFfcJWCRtGWf9k
         ievAl/SfqtDpCJ6Wn4H5aSVWceQ6qjigujCz6CI8184ewYxsc8kQI6RrpWvS7xdadEmK
         Qmp6zWu/gq34IPkYvZbU7X9NRfEQe5FsFawPiS+vLJPic+QL36JI6tEzmff3w6HvIcFs
         xce3Oca6KrpWkZHQpbmFpX3QvgWR4/ygI3TYl+0iyl4z5r0QK0nMRb3giFw1XZmqLvLU
         oYh0it8pmG3oKnzfNxg03xm9S2hfZVmayBEo6x4CiDq7zCyXguTW+mpb4HnEY7WLrqHD
         4hdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736351306; x=1736956106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMdEnKACleX9uwy7fK5On8764yRNpf5ZlddHv0JPlKk=;
        b=DTa1cJ3OtdkP1tOAc7DsDSRkJ1e78EwIEA6knt36fNI8kl1gw+782xn5kAgPp/M1Qk
         XPLjRRuCPd7G+hdDUPn5aELNzWmeEX19ToEdZn0ZsSO6ZIgiZ1CTNQoCEHr1nhT5OpIK
         Ky7zM14j8vCBMRg8LJRlGxhZwELSEjJeX2fV0Td6CDU4cMvxvZ+B4dF6R7VM8q1sjG4r
         TSHY624rC1QSI9dech4w7Dqe0jwsLID65zuKuvvM1ilbpJyGTRyFmoqbaG7P41NJxdfS
         4oKdbGrIFVhSguTbHHmsc9KBN+r3mu+lBHCDiK9JIr5/IpVcWoyfhj0RRd65Qpi2LaLn
         KE0g==
X-Forwarded-Encrypted: i=1; AJvYcCXTjcuVzVRz4zWk8TmLz6me7Q184lt6j21RkRapguGG0ZleurFTfAIxwfOs0NN/ADbR5CNpNZVR+84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSu7BkOxCijqCUC+AxI62Y39H+FDSynYYP/fO22olxtdRB6Vf
	4C7CZQvRiS1FHEI8jwDBGAICdtYa+lwpIqd8nGOP0uDWN+37D3mu7G3e6w9llAQ=
X-Gm-Gg: ASbGnctV6+u5+jQ1FHCwl3Csk+VnaJ1GUa5NTccaODwp4MHOZQ3ozdf/tKbui5MdOq9
	BvOED36SYBEwonXJBQkoOrtchHafYIf/gNWWokkR8kWdNYFXBqvqePuWhGTS6qiObi10IFI8LNJ
	gB8NAYZuaaAojOGTT2pcjm7zhZvsn6LwJ6Dxwy6vADZ6X6ODZzkg8Y1v2N1N+f+3f5nfah8Q64K
	FGbTNNf+7cgAjH4M/82rMvZYOcouYJk8YjHo+T6WyHAvZrI2O7EAOcjQuEmfz3umRiQ18N3Tb5F
	Bz7k5A/dEb2Vgkdi2sLcCDVIxs0H75VFKcG8moQ=
X-Google-Smtp-Source: AGHT+IHKuRmaWamB5gMX5MJhlxXx27TTJMqBv7LOXAn0uwrRIBh1bInm6bKRAgYM32A/jiYm4yNC6Q==
X-Received: by 2002:a05:6214:20ce:b0:6d8:812e:1fd0 with SMTP id 6a1803df08f44-6df9b1da95amr51261766d6.15.1736351306022;
        Wed, 08 Jan 2025 07:48:26 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180eaa0csm192445276d6.5.2025.01.08.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 07:48:25 -0800 (PST)
Date: Wed, 8 Jan 2025 10:48:23 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z36eR5oXcv3rpEZ-@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-26-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:11PM +0100, Robert Richter wrote:
> Add AMD platform specific Zen5 support for address translation.
> 
... snip ...
> 
> Once the endpoint is attached to a region and its SPA range is know,
> calling the PRM is no longer needed, the SPA base can be used.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

One inline question, but not a blocker

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/amd.c    | 227 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/core.h   |   6 +
>  drivers/cxl/core/port.c   |   7 ++
>  5 files changed, 245 insertions(+)
>  create mode 100644 drivers/cxl/core/amd.c
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 901555bf4b73..c8176265c15c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -831,6 +831,11 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  			    &cxl_einj_inject_fops);
>  }
>  
> +static void cxl_port_platform_setup(struct cxl_port *port)
> +{
> +	cxl_port_setup_amd(port);
> +}
> +

Assuming this gets expanded (which it may not), should we expect this
function to end up like so?

static void cxl_port_platform_setup(struct cxl_port *port)
{
	cxl_port_setup_amd(port);
	cxl_port_setup_intel(port);
	cxl_port_setup_arm(port);
	... etc ...
}

I suppose this logic has to exist somewhere in some form, just want to make
sure this is what we want.  Either way, this is easily modifiable, so
not a blocker as I said.

>  static int cxl_port_add(struct cxl_port *port,
>  			resource_size_t component_reg_phys,
>  			struct cxl_dport *parent_dport)
> @@ -868,6 +873,8 @@ static int cxl_port_add(struct cxl_port *port,
>  			return rc;
>  	}
>  
> +	cxl_port_platform_setup(port);
> +
>  	rc = device_add(dev);
>  	if (rc)
>  		return rc;
> -- 
> 2.39.5
> 
