Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30433710E
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415006; cv=none; b=qTjCmdK5KyRAMIu9TlT8KUEkz1GNFUzL+Hxu+TjDPXLPy8U8FB9+7T3Hvgb55kjziPZXFnklkaf1v5OOgquQ8UeUSgYZzsOIchwDq+LHqax2cq6eqkhg2pvFvfaODj3pur/Nyffd8ZuFrfvABd+vcrDJ0egaxujbx0lbMu/3XCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415006; c=relaxed/simple;
	bh=2keFckqpLJKdDOkEdKDk+Nx9mon02aLwCfWMS15qEXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD3IMTAqw8l86+6syWSA+KlIJzrsP8ZBc+kj+7lkM9Fw2DQoAEU9CgPdK0OI9oZ59wa9FBJj9se0R5gcZD4lqYAL+Yq1nnkT/2bCrcH8pNrYv2ct6qnt/A7v4TE60WGBhkGgRGr27WwaecSzS7w3oFArK9e/2Unf10JPnGLyO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=amkMzU/6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="amkMzU/6"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014e8a42aeso717231cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 10:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768415003; x=1769019803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya4q+UASQ4QjguMn83iPpFUtoRo5pCvQ8o6DMhQTXMo=;
        b=amkMzU/6i14/JZEy8ujZtTIpwtIIcK6bwovMeHKSeGzZImvQek5wkAEYbwOXh2P6Sr
         OKBQ7+U8MMGNeD34uZ9CvBk+Terv6v3qbmvPhTFoG2hbmsVasSQWYH7F7sHCndaSrL9o
         z/Xtm7TccElzqJICoOByNMQlSPIlMaYj9jCzG9ReZbW458vmo0URnaWVIQJcw3nI62TW
         AcXZQrwRAMNjgjNNGeKTbE+ZLR4d0ipBlINCttrL+dHUVK2bb+DwaLWn8qtm2J17UZZ4
         eaHMwPWK9AJ0Nw14RKW1uRDWxzL+dYyPfs7GFZ3sBh9TttH+Ghar6hCqOIrz3kcWvcGl
         cO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768415003; x=1769019803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ya4q+UASQ4QjguMn83iPpFUtoRo5pCvQ8o6DMhQTXMo=;
        b=uwSCi6eE/UfZHsaxdEqjsb3PQcqqOT2VbftsIjgI5spmcjZ9nF4fXbWDuOwidU9Kf8
         G1W9GUUXivM0xcW4Kg16uEALx+0lJAkgD3VhBKdzNiRzSuU0w/443bIjzbb8okuPxRww
         ZJI9w+ZoHt9/eZDCNJA7VVxoD0nDLXBrELoz4O2JCXqPOfW1EMLQqc/LxFHqBE8CarH9
         xvg40PXSBMZSH68BdQzB0jjtWkH5zdVNSKbu4kB+91iyKyDOYq0nzbcfdcOlBRYOQv4m
         TpONDr9vO8E7rmV/IbNIixjtADHzwX5q6HWE9zxCofhi4VFdEq2IV/YPhqYJEquAxgJF
         Ze8Q==
X-Gm-Message-State: AOJu0YyC1es8RCaPCY48s4z8pFzPSpf1Hnxohbm4+5TFer1U2ZZYsk4r
	cCjywJBbQuWLRf+gb0zdogWrIR+FqzODlnPZ91DoPMUNf0PlkJ9eENe/pdueNHN4G4U=
X-Gm-Gg: AY/fxX6+yVyXas2dHXVqlcee0C9BKBfNkwTrLMCSAbudXZpbXquqSdCg1xzV5DpzKhe
	E+54gaqFEB9hyF4th0XTIzyQJeGvNQbkjvnwcPYjqMC6RzgnkEB2DWDzImzgt6GPqBSccYG6HP4
	PijY/MVvgMAH+eVBYXPenINyZGzgr6qzkPKtiMsZmuMgpMbAFuD5+Os1r9ilDBWuqE5Erq7OCIQ
	hrdqvLhxVYpY9XAbIHkv4VxfzIDXIOvdeDjGb4+5KRfSvBKCM1F9G7NYmPEUe9svDWGo9HjWyJ9
	EFSa9/oxHpLSZIz08ZV8BTauo6nStHbwrzwchfuh72Jx2PZrQju6EAxxYjwDWXFHT2J0wjtYOZH
	m5YbkymYLMgQm9ZB13+0q/GSI0hkqHKG41krVVIY9WiUlFvysKD7Mfb8sqQ9aeUvLr9eV3GiPot
	uQKETWl/Cchgnp6dyR9avq9MqReS/33Di68v/nfRGuRzJ1DV6dAniGWxBsUgqUoJyvLUGmYw==
X-Received: by 2002:ac8:60c6:0:b0:501:4bb5:51a3 with SMTP id d75a77b69052e-5014bb554bcmr25211621cf.39.1768415003326;
        Wed, 14 Jan 2026 10:23:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148dd7454sm17467301cf.6.2026.01.14.10.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:23:22 -0800 (PST)
Date: Wed, 14 Jan 2026 13:22:50 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v2 1/3] drivers/cxl: introduce cxl_region_driver field
 for cxl_region
Message-ID: <aWfe-r7uEV-ajfhX@gourry-fedora-PF4VCD3F>
References: <20260113202138.3021093-1-gourry@gourry.net>
 <aWfdQESLWEKDlBL_@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWfdQESLWEKDlBL_@aschofie-mobl2.lan>

On Wed, Jan 14, 2026 at 10:15:28AM -0800, Alison Schofield wrote:
> On Tue, Jan 13, 2026 at 03:21:36PM -0500, Gregory Price wrote:
> > The CXL driver presently has 3 modes of managing a cxl_region:
> >   - no specific driver (bios-onlined SystemRAM)
> >   - dax_region (all other RAM regions, for now)
> >   - pmem_region (all PMEM regions)
> > 
> > Formalize these into specific "region drivers".
> > 
> > enum cxl_region_driver {
> > 	CXL_REGION_DRIVER_NONE,
> > 	CXL_REGION_DRIVER_DAX,
> > 	CXL_REGION_DRIVER_PMEM
> > };
> > 
> > $cat regionN/region_driver
> > [none,dax,pmem]
> > 
> > The intent is to clarify how to to add additional drivers (sysram,
> > dynamic_capacity, etc) in the future, and to allow switching the
> > driver selection via a sysfs entry `regionN/region_driver`.
> 
> Needs description in Documentation/ABI/testing/sysfs-bus-cxl
> I think that will help me understand the switching we expect
> to support.
>

Can do.

> > +	/* PMEM drivers cannot be changed */
> > +	if (cxlr->mode == CXL_PARTMODE_PMEM)
> > +		return -EBUSY;
> 
> why isn't above "if (cxlr->driver == CXL_REGION_DRIVER_PMEM)"
>

I wanted to future-proof against someone trying to do something silly
like changing PMEM to come up as REGION_DRIVER_NONE and then scootching
past the check here.  But I can change to

if (cxlr->mode == CXL_PARTMODE_PMEM ||
    cxlr->driver CXL_REGION_DRIVER_PMEM)

to make this even more explicit.

~Gregory
