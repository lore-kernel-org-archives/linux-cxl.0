Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4201FF1A1
	for <linux-cxl@vger.kernel.org>; Sat, 27 Sep 2025 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758937489; cv=none; b=t5POCuanbO1t8+ebEQfClWdaAXhNGbBd/4sip5etZkUTaVfcuaZryfoa3/KodJ+2eoTYpFklVRwtbVAzsGV5830XwOxGaP79FhQR7F1kPGSRRyuk1LfKvrkSJHgkemDdchQ0DHwVnWzujdcstzF/dgEPiT65E4NSDtQaz04cAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758937489; c=relaxed/simple;
	bh=dqdxCmArGa9yxPqwCNkcLXOI22MJukoEgJBNjnFbuNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuloXkjQReO0Kg356M+ArQZ94duuWXn5XRagYnUAZkBvAdBm+HFThSObYB6QMZoSRHS9BmLcR108f5qnGaECfyKliMG4YotVYXg0sH6LoAAmy9O01dEKvvWI4NIe66irSDUOVTOht3eTOr/pGgTEDSfUtBkWvtXYowbX49NJtZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gan/JCB3; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gan/JCB3"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-858183680b4so358442385a.2
        for <linux-cxl@vger.kernel.org>; Fri, 26 Sep 2025 18:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758937487; x=1759542287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLtYuDKI14SpP+23oPAYnH6nmb86y+sxjILKpo0x83o=;
        b=gan/JCB3r0kQMyh/Fi1W/RGWqgJipINImCGgW1AQA49Kx+QE1qBkn9QgKwzXI10Tbv
         EjmO+Lnw5v8Sckc8irHAODbNZRMFXLq8shvfhwURtnTCqVFedK9dXDJoa1a9wUlEj/NG
         Twhx92eGP5je7bj24VethvIovxAh71yOJYLkGxPfgPJMErOC9lrmNvhlgFhHh43fUfDf
         yxve6BOK4fTQSjZFKpAb1+x8g9fxDChbakeaYo3P7mqnmxXBcdmboEhRpg49rtkdpw2V
         Pbfcq1ApfVkRxUczAxUbecMIgXeHA6j+Wg3hv+z92yjYASo6GCYkJjkeVLbdY+JGVsjH
         uSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758937487; x=1759542287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLtYuDKI14SpP+23oPAYnH6nmb86y+sxjILKpo0x83o=;
        b=imB7xIrH9ZEu/WkrHt/7J9F5v/mJMslfD3YIngIiUsU5Vz2+yOp9li5ehg8ZzF+35q
         VLQGt5wuV3xAqVaPbmuyzch8gU1DdhwCpV2Dbg90HVIRSr+tY02zEa5pGmqXN7s7kmSN
         UXpzVc00BDIU+TJcHXBTz3UoAusJWpmko4uNL0KWbJ9NIBrGh3RUtW+rNU20HkLeMJVW
         cMUCc48KxgV5OA7eAhC8oav0+BZfLmlOn6LT2rTWCI1/uEMtK7uRkWIZR6w4Lj3ox/dN
         XAHwGa1e4bk63Yi+naEYRnyApZjs9G+GR4TIWXL7TkiMZTqzPpsNdlkIUAteKl8Dc1yJ
         SUjA==
X-Forwarded-Encrypted: i=1; AJvYcCVfCmD0FaUGzNhW1TasMqTpK4MetpKM1OjPMozpezK+dQGEMnqpFlAP0N9dJoTfRF+Z7AiLKUh+KBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDcM7U4pLLAGduowAM6lOmsx9FdhbY3EE76QdRA1C3QCvu2hp
	SDInqk/X43NMxznkc0GIumPDPctNzldjksh4zqlpqLAD5+G/5ZSFfRGhVsgjvzOvmaw=
X-Gm-Gg: ASbGnctAmFqTWQUrjgU3BKO1XWEj4pBRUfKkEDN7WR0NK2S7MomrHO1Rhz0rZdff//V
	+z+R2Yue/4AzBYCA+2EGiNn/H3CkRqtRZDEEVSewaluB9U/e99dgUx6RQXwMjIxV4WvrkpqxVcb
	EkPUJPdXQj8LMtsSGHh50WY/pgmlLRczP8mFVHL6sQ8LBcGrWDVfoJay9cGrqvoG0MiqlWOQ5CM
	MqhwMtFnuN2of0NTWgoDDIx/EZhxpxlYzc76yr/qRHYLSLFWpCSOSzafOFGIR/QtT35JTg2KK1B
	SXSGzqeKpYsv+rgBrS3LwTC0sXvgKD8m9xDJ+IcCtgvPAFzBt9IDctNw3qqZwJLdSF1SpNrT3ko
	ckzLEAkCZyE3q3kZE5TYKYJKdkWTuluddBdCdshmrNRXd0HUe7bTtu8LbNc+ExAFO9cc1KL/ont
	Yf1jGfKQ==
X-Google-Smtp-Source: AGHT+IHp6aaJim+FGxPXwaKcRAhC/7o+RiCQEQ0xsgnerht7ZPGqeEPIy0Gt8By0UJ/GpFPpjGy09g==
X-Received: by 2002:a05:620a:290a:b0:860:e823:887d with SMTP id af79cd13be357-860e8238f93mr631609685a.71.1758937486781;
        Fri, 26 Sep 2025 18:44:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b94599esm34985571cf.16.2025.09.26.18.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 18:44:45 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:44:43 -0400
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
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 11/11] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aNdBixt1AzIxdCpX@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-12-rrichter@amd.com>
 <aNQl2ogOPKid7yyp@gourry-fedora-PF4VCD3F>
 <aNbGfOxB4LXaFL0Z@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNbGfOxB4LXaFL0Z@rric.localdomain>

On Fri, Sep 26, 2025 at 06:59:40PM +0200, Robert Richter wrote:
> On 24.09.25 13:09:46, Gregory Price wrote:
> > On Fri, Sep 12, 2025 at 04:45:13PM +0200, Robert Richter wrote:
> > > +static void cxl_prm_init(struct cxl_port *port)
> > > +{
> > > +	u64 spa;
> > > +	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
> > > +	int rc;
> > > +
> > > +	if (!check_prm_address_translation(port))
> > > +		return;
> > > +
> > > +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> > > +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> > > +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> > > +		return;
> > > +
> > > +	port->to_hpa = cxl_prm_to_hpa;
> > > +
> > > +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> > > +		dev_name(&port->dev));
> > > +}
> > 
> > Is it possible that the PRMT function is present but uninitialize?
> > For example if expanders are not in a normalized address mode.
> > 
> > This code would likely still add the to_hpa() function reference even
> > if the underlying PRMT function hasn't been set up for translation.
> 
> At this point during init, it is not yet possible to determine
> normalized address mode. Endpoint and hdm decoders are still unknown.
> Thus, PRM is enabled for the port. Later, during region setup, there is
> a check for that while determining the region's HPA range. Addresses
> are translated and ranges adjusted only if needed. Once the ranges are
> set up, no further PRM handler calls are executed.
>

Right, but that errors out if address translation fails (below).

Is this code missing a check for the endpoint_decoder.start==0?

static int setup_address_translation(struct cxl_endpoint_decoder *cxled,
                                     struct cxl_region_context *ctx)
{
...
        /* Translate HPA range to SPA. */
        range.start = port->to_hpa(cxld, range.start);
        range.end = port->to_hpa(cxld, range.end);

        if (range.start == ULLONG_MAX || range.end == ULLONG_MAX) {
                dev_warn(&port->dev,
                        "CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
                        range.start, range.end, ctx->hpa_range.start,
                        ctx->hpa_range.end, dev_name(&cxld->dev));
                return -ENXIO;
        }
...
}


static int setup_region_params(struct cxl_endpoint_decoder *cxled,
                               struct cxl_region_context *ctx)
{          
...
        rc = setup_address_translation(cxled, ctx);
...
}


int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
{
...
        rc = setup_region_params(cxled, &ctx);
        if (rc)
                return rc;
}
