Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9F7FBA1
	for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745538388; cv=none; b=THvnnK8r6jLV/OUu+MqV6C7s9zPwZf/9TI6IVmJ0Ed+5bnBMlzwSXw35ERlw/sjuWlSAU/a/WFBoWasMfyc77mSj0alTOe1GkBiF+XSjaGZLOJdxP6zE2TFNlQRjbd5WE2VvFxobTc3QxfC+H26gg1YRiapzOuO9Eugt8b+OP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745538388; c=relaxed/simple;
	bh=cgxkOOr+aArOC1h6OdPymoq0m6N6WQCGvPhZQ1eKE0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2B+i0v+XEDUnjJfROJFuWEKgkKCZhRSW4qGqxqgxFK0/mxPwDQAhcy/E6XhX3qYldlQRUpYU36y21uShlSeqwypz3Q1yWbuG41Gx8lQaCpoZJ4ixI5YaQJJXbdoyIneV+qd2cj1k3GVPIBtTt1bqdxEA+tLZ6JXEeilLQVhY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FoWVRyaS; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FoWVRyaS"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ecf0e07947so17034176d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 16:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745538385; x=1746143185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YEAi2WhyTrKKsIEGS24DIqJtZonvDBpfYFt5yLGQVew=;
        b=FoWVRyaScCIVAPRY73nQGOurDAsgcEpPoM9CiPPWy2UU6YLXR2u+cw9XT5xSr+Rnlw
         73mBXSsxv4MVqhNyDiv0lQodta4MJBql2AYBwolAJU1gIiKSyMZnPkk2cFqpFhEDUR8G
         MTtikp3J77BQYBj6zUR57nXi0UNqAssjU0EKrmozmM43xEdx2EOBHT/gOJ9wM1UYHRkc
         vGG1y6+IvYi6xSiR8WDmCDainWZZMERLtAIDU4IF1fRDqtCLYgBnXsCqZkGvT+BEWbH1
         68FLW++07yPcapprEd5MP+JCGGpau/fIUlE2xZXB+kcKSlA0UWjKkGt5cB2N73OkpjUm
         bNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745538385; x=1746143185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEAi2WhyTrKKsIEGS24DIqJtZonvDBpfYFt5yLGQVew=;
        b=DTSyV4F1Y0vcgA6qHGlXxO+g25oE4GTzoHXXlHMhMRUFfFrXIR0qQjZOEoFv/5Ex6+
         eBtme/ACRvf1GEBg6V4dkF/xSB1NpgvAM9L7y5wkpqsyGzVLeGhHRvxqErsRR/HY951J
         Rxplhig9C82yfb6RJmrt29YiUvezdBaqjc0Ic3i8Q5AlEfZ+tDBsGZklw9I18jv/P7vK
         GBV9R53VXOtvp/Bmk1YF7K4Dl9ZYIOq0rXPV8hX691Zkzf07m6QRp/CieM4Mif7hpDWa
         b6N6ZyBrOO+ovmLZaP5XNRx37YeeMCimHhYF7C41AQwMwnbeW2wgKuuKXfb7ZGEvTEab
         5BxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4u3xfc3jPB6hQP/n5Odf2+FbZfK1AJbEzmIXNGA8VOj+rr57OBtHxj0wEu7zNX6xI40wghR0IdUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26CdTRVeikCB9mysGHm1iaNOUrMD719Yvgb5dvjtXWvt9esFn
	4O7uG1Rvvh5+pmyfz7FOI9NdWP0RqZf3BFc4J1dWDtQ48Fy7HvbjaAfMbRwoPXE=
X-Gm-Gg: ASbGncu17WbnULMoEQzKXCkoQZH4tag74G/cJS86wvRrOfiitlH/EpiBgSZJZifQ780
	ucNPDPc2DcywHugwE4o+TuHb+WEa2N/+0I5zkrKV05EWCXCVWAnR+mlp7en6gA2YjNiKyA/DhBj
	Hp0sgDHz/eBEpX0QGLP4t8J8UsLBGHi5k1oZCrsYeAWgVyipf1i0I7gdKbmzqCh2Rhsmgq/WPdK
	/e1Lf8bfVIzDkg1dFcpUdX2j0ZEiCJ317C+TnKihZmH8oLXfPcZ7NV2SUkWwcgITEtLaaPuoce2
	RaECzWTXpiPKg5P0wQ+HbgE2Ix7tM0Vl4qAB/f13gvQbWL3vN1C8iWY/XPLWUzLULGPf4notB2A
	8LIKtV/ByDpeniiu80mm0nKU=
X-Google-Smtp-Source: AGHT+IHVIQahRBRjFujQsX/oVEHpzhYjotm5kOcv092cB3rq2Z5DmpzekL+dkfwTQCm8OAdREUXkmA==
X-Received: by 2002:a05:6214:1d01:b0:6e4:3478:8ea7 with SMTP id 6a1803df08f44-6f4cc2f6dc9mr2543336d6.4.1745538384725;
        Thu, 24 Apr 2025 16:46:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c093501esm15412946d6.37.2025.04.24.16.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 16:46:24 -0700 (PDT)
Date: Thu, 24 Apr 2025 19:46:22 -0400
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
Subject: Re: [PATCH v2 06/15] cxl/region: Use endpoint's HPA range to find
 the port's decoder
Message-ID: <aArNTsJfIxdM9ybQ@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-7-rrichter@amd.com>
 <aAmFk1iQcS7UpslQ@gourry-fedora-PF4VCD3F>
 <aAqx74FWd--8aVw1@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAqx74FWd--8aVw1@gourry-fedora-PF4VCD3F>

On Thu, Apr 24, 2025 at 05:49:35PM -0400, Gregory Price wrote:
> On Wed, Apr 23, 2025 at 08:28:03PM -0400, Gregory Price wrote:
> > @@ -916,13 +921,14 @@ cxl_find_decoder_early(struct cxl_port *port,
> >  		       struct cxl_region *cxlr)
> >  {
> >  	struct device *dev;
> > +	struct mad_context mad = { .p = &cxlr->params,
> > +				   .r =&cxled->cxld.hpa_range };
>                                                ^^^^^^^^^^^^^^
> 					       spa_range
> 
> Woops, missed this.  Not sure if it goes here or a later patch, but
> that's needed to make this work.
> 
> ~Gregory

And for the sake of completeness - I've confirmed that this is
sufficient to get a Zen5 working on top of

   v6.13 + (v6.14, v6.15, cxl-next) PCI/CXL backports

So a smaller set of changes than I was expecting (some other mild fixups
but nothing major).  Just kind of have to decide what the shape of this
change looks like, if not like this.

I can share my modified line if you'd like, but I haven't incorporated
any suggestions from the chain here.

~Gregory
