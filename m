Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AB1A0AF0
	for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699224; cv=none; b=dE8OZtAZWm2v37ujJfFQsXGrMxkP0OGA1ev8JaSBvfb4hTPbf0KCE+Q/GZBdNU00kOhJteYylr4yifLqIBAd4sX84D9BoyRS1sIEqkuxSJ8XIyukG9TTxHILHEfwp/Oc29Z4Vw9Zp1b9jPJ9V24eVHOZrtZQlkkwZULA5YrVXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699224; c=relaxed/simple;
	bh=59MwCHZI2eRr0Lgw3OtYNaA1fcBaVDiTk9prZoAzHbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9JSZJqqHCnAuGeyzTQatg8hffUtCiGSxoUiqkl8mXEtLsRYwrW24I/cupQ4evCdDRCXFO5dLMvng8TigUOJb8h8x3PEbFt3ayWCZm2ZJU0QTapMXmmYp+6YCIkQBvx0vGn71CpDInpmlpadqP5z7DPXMmjD14RYH/EWVO9/bNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rQU+BXPG; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rQU+BXPG"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso8850956d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729699221; x=1730304021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZE5mo+XRZoTQy0RhARBcoff9U8u1ODouYGk8DXBUoE=;
        b=rQU+BXPGpxgux4Y7kqU3sDOKPIsjEbUcK228X+ZUv9HbnjNqAxRWH4uR5djk23WwBR
         4vxmb73D0KIDMejjxX3S1IsKPgJ+VvEPtE0Pq/jrvIegecLYI1vq6+IpZs48AsCOBrka
         fGp4ftKDZj4yTP17g9LFUpe+CzRNBxgohNiPrlCdGPDDB7lxiDgHreRLYG7EAugNAQYu
         CtsGSy3Fn5ycX6SBLdr5CCXx4Z8gezboNn8jnf8cWQm/LirdGkofe2dOWYI33txngBio
         aP5mfF51V4dYJabbgWyJhkjvcyL98SNnFCTVgCavlRf66q61UuF8j7/i/xI7T5+We7BV
         Atww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729699221; x=1730304021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZE5mo+XRZoTQy0RhARBcoff9U8u1ODouYGk8DXBUoE=;
        b=oEP41zVzNKG+46YrbXdI0Ilypsru1p8Hbewy5LIY6FxF3J9HAsMw4uC6Baf/tkb1Wo
         G6hhxY2oU1a36F5WmQI6BG4tLplORvPZv36Nmu4JGAQhdxLJVSSBLHdRmcdShOHOhovh
         ucaTpRDLVToW1oz7CAqDQ0/e/n9Lz1Ck7tQdUVnFCEM8ZIAFQ+hx55sEERWNSrBJ0DG9
         0EP4JPoHDY55S+Hd+PhekXRXrMNKCaE3X0bhbh0A03Y3tSC8ImalZSVAFryCZqox2aIZ
         c7qTcjYyHxoMSYpVmU6Ru3QYpxWutzlyWVBMYQWtdwRUWps/ChHHN4idmOFvk2auuRt2
         OR7w==
X-Forwarded-Encrypted: i=1; AJvYcCXY52FEUDih3pUanuaFr2d4gGeIRzAS4AstBR0gwZAmvk+m4VWge+W9zmFObYOI8ZJ4RmYM985re6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8j2oadF+9bPNl/jP/PAYQ9OstE3Ba/YWF8zuf/Oim7HqnMPhh
	lImfQcOUtx4i2ziuwU3GwqSOiy+rvDRXZQk8m5x2jqlF8G/0WM3YZdQG7+bv0Wk=
X-Google-Smtp-Source: AGHT+IFT7UP/R2GwBpkcLMSMz0sbAQ2MaCxYMZIBaQrsveVtoCLfqVSspXEg8OQnAfl2i9+zyrWJ/A==
X-Received: by 2002:a05:6214:3388:b0:6cb:cc30:1b0a with SMTP id 6a1803df08f44-6ce342f15bbmr52367256d6.14.1729699221324;
        Wed, 23 Oct 2024 09:00:21 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009e32f9sm40702836d6.112.2024.10.23.09.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:00:20 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:00:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/6] cxl: Initialization and shutdown fixes
Message-ID: <Zxkdl7H37gg5iXbO@PC2K9PVX.TheFacebook.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <Zxj2J6h8v788Vhxh@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxj2J6h8v788Vhxh@rric.localdomain>

On Wed, Oct 23, 2024 at 03:12:07PM +0200, Robert Richter wrote:
> On 22.10.24 18:43:15, Dan Williams wrote:
> > Changes since v1 [1]:
> > - Fix some misspellings missed by checkpatch in changelogs (Jonathan)
> > - Add comments explaining the order of objects in drivers/cxl/Makefile
> >   (Jonathan)
> > - Rename attach_device => cxl_rescan_attach (Jonathan)
> > - Fixup Zijun's email (Zijun)
> > 
> > [1]: http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com
> > 
> > ---
> > 
> > Original cover:
> > 
> > Gregory's modest proposal to fix CXL cxl_mem_probe() failures due to
> > delayed arrival of the CXL "root" infrastructure [1] prompted questions
> > of how the existing mechanism for retrying cxl_mem_probe() could be
> > failing.
> 
> I found a similar issue with the region creation. 
> 
> A region is created with the first endpoint found and immediately
> added as device which triggers cxl_region_probe(). Now, in
> interleaving setups the region state comes into commit state only
> after the last endpoint was probed. So the probe must be repeated
> until all endpoints were enumerated. I ended up with this change:
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a07b62254596..c78704e435e5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3775,8 +3775,8 @@ static int cxl_region_probe(struct device *dev)
>  	}
>  
>  	if (p->state < CXL_CONFIG_COMMIT) {
> -		dev_dbg(&cxlr->dev, "config state: %d\n", p->state);
> -		rc = -ENXIO;
> +		rc = dev_err_probe(&cxlr->dev, -EPROBE_DEFER,
> +				"region config state: %d\n", p->state);
>  		goto out;
>  	}
> 

I have not experienced any out of order operations since applying Dan's
v1 of this patch set, do you still see this after applying the existing
set?

Probably this is indicative of needing another SOFTDEP / ordering issue.

~Gregory


> -- 
> 2.39.5
> 
> I don't see an init order issue here as the mem module is always up
> before the regions are probed.
> 
> -Robert
> 
> > 
> > The critical missing piece in the debug was that Gregory's setup had
> > almost all CXL modules built-in to the kernel.
> > 
> > On the way to that discovery several other bugs and init-order corner
> > cases were discovered.
> > 
> > The main fix is to make sure the drivers/cxl/Makefile object order
> > supports root CXL ports being fully initialized upon cxl_acpi_probe()
> > exit. The modular case has some similar potential holes that are fixed
> > with MODULE_SOFTDEP() and other fix ups. Finally, an attempt to update
> > cxl_test to reproduce the original report resulted in the discovery of a
> > separate long standing use after free bug in cxl_region_detach().
> > 
> > [2]: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
> > 
> > ---
> > 
> > Dan Williams (6):
> >       cxl/port: Fix CXL port initialization order when the subsystem is built-in
> >       cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()
> >       cxl/acpi: Ensure ports ready at cxl_acpi_probe() return
> >       cxl/port: Fix use-after-free, permit out-of-order decoder shutdown
> >       cxl/port: Prevent out-of-order decoder allocation
> >       cxl/test: Improve init-order fidelity relative to real-world systems
> > 
> > 
> >  drivers/base/core.c          |   35 +++++++
> >  drivers/cxl/Kconfig          |    1 
> >  drivers/cxl/Makefile         |   20 +++-
> >  drivers/cxl/acpi.c           |    7 +
> >  drivers/cxl/core/hdm.c       |   50 +++++++++--
> >  drivers/cxl/core/port.c      |   13 ++-
> >  drivers/cxl/core/region.c    |   91 ++++++++++---------
> >  drivers/cxl/cxl.h            |    3 -
> >  include/linux/device.h       |    3 +
> >  tools/testing/cxl/test/cxl.c |  200 +++++++++++++++++++++++-------------------
> >  tools/testing/cxl/test/mem.c |    1 
> >  11 files changed, 269 insertions(+), 155 deletions(-)
> > 
> > base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
