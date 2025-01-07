Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87319408C
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736289306; cv=none; b=B2scu3bHr5YLexL58as3JFVbuAzDFYmC0K6bvjyIN2ITZWPKnLAC05HlB4h2mql3JWGHPQ1SJ5sg0fjZPO8Gi85pWrwe3TojwxSkEFIZmyMdB3clJlq8NsAYj384fRwdnTVpTPdndrF6GqCq39H1X+z57mHq0UQCoOkk563fi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736289306; c=relaxed/simple;
	bh=yPZGWdBx5A0pMgHsMGyEc3nl2PscNIs/BxteV4XQEhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2KhyFlfrmE6YWMkG2KwY4rEUGuYwnwB0eirM5UT73Q0LoWB2eldHXgf60hdTdLT43m0KpHhywxAQMbk7Ledgp185GVOUU7yp/md/HNspF7iASLhP0xTMCZryPskvAeHoaFSOL88DWtmuzoMTlLWz/hX1arL+FmCHYviDZntFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kDn9Gzem; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kDn9Gzem"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6f53c12adso1275721085a.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 14:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736289302; x=1736894102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W32+DfbiSFJc5BSiD7HWso1Bv/1sco9S6FmQB5UqoO0=;
        b=kDn9Gzem2RGLEIjkKfQLcr6VplOyFNNvj8lI0ngk+ysWWFsz+1FU/NT1QPWNkCMhY5
         nYu1Tdlg3VEWJZdT/2e+cVj1eGwWuMIz8p136LhFllZRaA3kfL9CYf20hY5SiV6vkzxi
         YILZw3WW9NUFVBTz/2m/Z+4yd1wIF1KISvPuhHNl3cNaT5HGgY8nwLhSfSAaA2BD0e3l
         Vg/FMA7yIKVZUXwgqfc2/TQu7ueLDuDLP91NJ9yQ26/S03arR/DmTDXO7YWA5HzOSKJC
         1bZwvkH+AAmE9IARBT6osHrZJ2HA9EQGdZDJILPNQ0GdWRONuk9lTGne6DxAbpNx+G9X
         WSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736289302; x=1736894102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W32+DfbiSFJc5BSiD7HWso1Bv/1sco9S6FmQB5UqoO0=;
        b=UXm3UsqT+pz46F9TilYzrSzP9B+qx4y2ToEWFu+vIKQm0XTtLb+rcpsc9G3hyB/+NH
         JAhCnR7OAfefqe5JUWfheT++NUtLlolgTbh52mY3H6JY3vcuM9CMuvvUpp5I038J4rBN
         GaSZs8kons/p71KkoWtkQj8mQcQR+ldKk2OkO9gY9veLQA7nifhI1J5DxxU/Cpzu7ZDJ
         G82HfLlzP05thmXiIDyUk1uFjqyAxJixqnWR8portbXpHZtll75j4lhvArUDh0u6f61O
         9Gzj65rvZMxBMp/GD/EQt6K/6J6qSZw+8EhEdbF3rfyUdlP6iK5T4v7/2oyTUAvwW+bp
         DjOg==
X-Forwarded-Encrypted: i=1; AJvYcCX23KdDga/N01a2WsWVs0Y3J/tPnwIPhQ31ud3iAOFXbAlZSXwqgFV1LaAJa6GoEq/6k8Z0cktWy+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyOI68kL5PPWmJc4+V9KLYhGXhD2mFLGoZ6Zk0e79P/xXnkKO4
	Utu1gCbBZb6VwlHxraiHaQ30od+izvgf8dv7voQ4jnOhtleiAGCSpi0DimiSGcQ=
X-Gm-Gg: ASbGncukXN4n0qYQNhf6AM+WESN/4/kIxYYBix3/L8KpO/LEc9R4u/AZRku1sAxP/dZ
	c7HB8o2pAFYU2qsnuUmGj7FuPzu6PaukKBXcUTffUQXIWOLtf8d33VbtRiIxGIR68SiPrj5M9iT
	afy39ZydjojJfxZQKbUFd4POY+JwKfYi/KS+w7aPcl58UxnGuEBoWBHFq26Sy95QCLALWrJ229a
	VNjiJ8GPjIT3xHrck5TUJVUq53Cq9OSh+/MOOlNku42DTBnJFDewJFn35cWYg0plRM1QYeWP5cy
	5SYsJm6w7Q5cmik4BWCeoI4X7Mdr+6aImhcbAXw=
X-Google-Smtp-Source: AGHT+IEaPaQR/CUFN15VORQEgoexJmgGjQbJC03yJsAU5djhDHrZK+o8/ABz82G4BVWZq1TsOQu/WQ==
X-Received: by 2002:a05:620a:2785:b0:7b6:7970:651c with SMTP id af79cd13be357-7bcd97a57d7mr77471185a.41.1736289302358;
        Tue, 07 Jan 2025 14:35:02 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2d11a2sm1622392085a.29.2025.01.07.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:35:02 -0800 (PST)
Date: Tue, 7 Jan 2025 17:35:00 -0500
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
Subject: Re: [PATCH v1 21/29] cxl/region: Lock decoders that need address
 translation
Message-ID: <Z32sFDz-gH1tZgmB@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-22-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-22-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:07PM +0100, Robert Richter wrote:
> There is only support to translate from the endpoint to its parent
> port, but not in the opposite direction from the parent to the
> endpoint. Thus, the endpoint address range cannot be determined and
> setup manually. If the parent implements the ->to_hpa() callback and
> needs address translation, forbit reprogramming of the decoders and
                             ^^^^^^
                             forbid?

> lock them.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8d7893878362..681c26abc26e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3353,6 +3353,17 @@ static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
>  		if (cxl_port_calc_hpa(parent, cxld, &hpa))
>  			return -ENXIO;
>  
> +		/*
> +		 * There is only support to translate from the endpoint to its
> +		 * parent port, but not in the opposite direction from the
> +		 * parent to the endpoint. Thus, the endpoint address range
> +		 * cannot be determined and setup manually. If the parent
> +		 * implements the ->to_hpa() callback and needs address
> +		 * translation, forbit reprogramming of the decoders and lock
                                ^^^^^^
                                forbid?

> +		 * them.
> +		 */
> +		cxld->flags |= CXL_DECODER_F_LOCK;
> +
>  		/* Iterate from endpoint to root_port refining the position */
>  		pos = cxl_port_calc_pos(iter, &hpa, pos);
>  		if (pos < 0)
> -- 
> 2.39.5
> 
