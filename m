Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CA1D79BE
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007971; cv=none; b=rA2CBS1XFRCJrwGhikntPG2+kT0U8OYbjz4J2ZcmdAHFGrsdh6Tntx5fXqRu7V9UoynD9oWY9+l8WOGXryeS/EVJ7kj+i8SJAmzblX/zhcMK4hCxOP6J/t5UNBmRW/PYT5aXV+fwvlWN4Wwew4RxhyYJd2x3WpsD9L574kXIAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007971; c=relaxed/simple;
	bh=3Qpi59IwyoeIc+HODTOPdRs+OhUPUgKytanIj4rGMlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSZslucnjHgtzQVq+gbXhfeu0DWGM4F7xLCx87N4YwiQi2rkCokL+lIvXCSxNRgQ04YgRs9EplAgoDG4rYt2QM/RpedoNwmPIZN/gIqs+Dxd6GiO/y+6ZgIqIC2yDLNvB9Pj/CaO1teuomdcYpxws0SAAR+VK3TYuctC9N4mX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=S44wyVWX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="S44wyVWX"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e677921db0so2464796d6.0
        for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 15:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740007968; x=1740612768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BuJ8MnTrLLKgSkkWBdG51HCA8Qkyi0aXGWMt1dCxiM4=;
        b=S44wyVWXSFRWrX9p0tc8MphkaYAy+ql4+wXN6T2wP0qjNqpEXvhFXjfeeZv5zEo9l1
         JxNYsaHNcJIl6fMtDooaC4SKGJfctspyxJJ74OB97ezOYzwvigl3MhZ6opJ1u+IQkT/U
         eOfV2H5TWTuLf9yIJsraJy0fNeww7sY3a8EZmwuqSQeVvbJYhn/bKFIgDpu9McqliC2/
         mFe/zV9zTHPiRTTD0h3T5Q/yKXppI1FYJCijYd5mtnzXAcWCljCNbiOqBWqLL9DfI19X
         1Qm9/hG3M1dESMP9NcQBSOIamYZ1AG7daVlYAGj6vHPjOot5UqHCBKxqwooqVBYRFy1W
         st1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007968; x=1740612768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuJ8MnTrLLKgSkkWBdG51HCA8Qkyi0aXGWMt1dCxiM4=;
        b=FGSs2G376e/8eH6CG5XqFHRFaDVPYRHbS2Hcdu3P/Z2ke7hi4LQ9IHQRAdWfMtWbrI
         qV4qB98efPSXKg+x4ZJvO5uhLndcNUA7uKfLiTyDy+RAKKNCdqrPfIJUmHaoUel4F2y8
         Ki/36ljYj6swp916E0jd0YWjxo6bLbw13s9DeezUtj1eXAEKQMjERVPI5xDOQBDf+CzX
         elH/clbAq8hnTrLroHBQNTT1pSr0nmSocYq18qx547Y6s3bfJANPj/o0IYA8A0bGzwyR
         ncAGWbd46DLe7zyNvsC9JsEIwsEppXtpFJ3tC6CiMTBgCKbU0v2PEvLEbTlAKqCT6y2M
         MBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc92wMBh7BQ2gPwFEOWU/alEjvqDdk00nrkLKpbGu+MreVIZ3OEpww+sOIPVd/A3XvwCF0Agp/nno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaDVsYtUUC4TsjXPyLWZYAchE6tiWA/C/5PW2Ql+yo7gEcYB8J
	BlOBbTySv/4Eo4fjf1uDLoEbZ5FyzaqreVJdHCKkNfuyxf7VbAHFQn82enTYDPQ=
X-Gm-Gg: ASbGncueJDPQFiXVrApD5RUU05RyA4L+smZTiUOhR5bE/vAWhGvyZ+VyaAnkyAbyQhM
	C8mEN9I0T/gJvbqJdgXEWWB8ISGAY0xC/SyZpgQVvasI4jaT6kIjuM/zEB2W3wREjI8U3bfG8w5
	msReziG2ttwHQcmxNtXJjdiDATypVFzOUWB6I61JbA52ccLAv1ucHbBdQx5Gbz186ugpHeG5QYr
	zd8ZciyxncAmL0J7+9kgj/xZNHPEShbsZ8zCVmGTH78PDbe4bgmi2TSoSlPpxMA5MJDSQ6v0MNI
	qxFz7KlfMO54fv0vwOR32lfNUgL6/EN39WN5+6mwKWo8enmaZA0otjEq3asXZKAmJkw54Dp+dQ=
	=
X-Google-Smtp-Source: AGHT+IEb1NSA6KP9GRyN2gqcBNFucCfbTKdR4b3/RwdPjgrLvsacTXJUjiUUYluNqmcUzxHzBNnpzQ==
X-Received: by 2002:a05:6214:d46:b0:6e4:4484:f357 with SMTP id 6a1803df08f44-6e66cd19ecamr248188026d6.30.1740007967718;
        Wed, 19 Feb 2025 15:32:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d784e99sm80839416d6.28.2025.02.19.15.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:32:47 -0800 (PST)
Date: Wed, 19 Feb 2025 18:32:45 -0500
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
Subject: Re: [PATCH v2 04/15] cxl/region: Calculate endpoint's region
 position during init
Message-ID: <Z7ZqHc44qLU73hpS@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-5-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218132356.1809075-5-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:45PM +0100, Robert Richter wrote:
> The calculation of an endpoint's position in a region traverses all
> ports up to the root port and determines the corresponding decoders
> for that particular address range. For address translation the HPA
> range must be recalculated between ports. In order to prepare the
> implementation of address translation, move code to
> cxl_endpoint_decoder_initialize() and reuse the existing iterator
> there.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ad4a6ce37216..6f106bfa115f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1903,7 +1903,6 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> -		cxled->pos = cxl_calc_interleave_pos(cxled);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
>  		 * cxled->pos so that follow-on code paths can reliably
> @@ -3264,10 +3263,22 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *iter = cxled_to_port(cxled);
>  	struct cxl_decoder *root, *cxld = &cxled->cxld;
> -	struct range *hpa = &cxld->hpa_range;
> +	struct range hpa = cxld->hpa_range;

I believe you have a build error here:

drivers/cxl/core/region.c: In function ‘cxl_endpoint_decoder_initialize’:
drivers/cxl/core/region.c:3286:51: error: incompatible type for argument 2 of ‘cxl_port_find_switch_decoder’
 3286 |         root = cxl_port_find_switch_decoder(iter, hpa);
      |                                                   ^~~
      |                                                   |
      |                                                   struct range
drivers/cxl/core/region.c:3244:67: note: expected ‘struct range *’ but argument is of type ‘struct range’
 3244 | cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
      |                                                     ~~~~~~~~~~~~~~^~~

Just a missed & later in the function

~Gregory
