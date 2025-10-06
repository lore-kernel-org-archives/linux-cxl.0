Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A11C8630
	for <linux-cxl@vger.kernel.org>; Mon,  6 Oct 2025 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772457; cv=none; b=rB09+msJ6S2Yg61dTZC/U2N4PdZYVTqRSo7eT0u1DkW+ZiZwbaVEe6Pn+R+aWct44qTlOpaDRRUyh7bhSuTKzPb6tDI9oE8+AFuES9IllLAwHYYxoUy+5CNw+X0DCRVEOp47wOpSvRAPpdwitZgxKZVCr5qd5et7rCAoraYG7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772457; c=relaxed/simple;
	bh=X3oGisebRlN7TGv9fnOE86D7EABh68RcxwSctp4usVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSQFqV8xFD3fkHvNjNJgjfywTRk3FHlI+5eSB7EJaWcnx8PIDG5zBc/LHHiqkQZDpi0JQmmj+sRYQdfeFsfIZ1R1t0ppHLWmuQG5dhEl5c20RjoJSEOSDutzD3BiHecV1AxTjkHB9niRv8JJvKhxBSZov8hbBhnfSpena5vEe4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sOHxDoxR; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sOHxDoxR"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-86be8a110f5so55378046d6.3
        for <linux-cxl@vger.kernel.org>; Mon, 06 Oct 2025 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759772453; x=1760377253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6zbU8nkw6qlp1oRKT9kqkgJqrXveHjdID6Q3hkDONE=;
        b=sOHxDoxRzP/MGNAS7cyvaa5yDvy3UQNZP4G5F2ZqvH0HyKUw6c4cZSsPC7VLh8j8cq
         y6yLAyMFW+zb3gb1WFzSeLhnEM9Grii/MJNbqpaBKB7+f0GZC2vIYvsdhn5fHhjnrnKD
         U94ulnK9JixQAufAmlP9+/ORWAiDDKIOY0rG5nzuuGqQ9hQD/Dc+MFBH7AO7dHWur5uk
         7GeA53NO1LYYDpRaflILstXkuPNU/zcRnBmHDdjoy1O9jWplKihsGinCuXXl1Zxst7oE
         bfLvd4CgINO3+6XYQSl5oZ0TQoB8uYk0nIcE20/7Ca9HWkGXFpqQJbElAXtioz864eDy
         9jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772453; x=1760377253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6zbU8nkw6qlp1oRKT9kqkgJqrXveHjdID6Q3hkDONE=;
        b=uIKPzyJm5qbCc6vA7C1sO6HUZf8e8ByA75uIvlObSqLl91MnJKwXiILOlWHugncCkV
         yv0dLkY+xoXceEEXJfT0sHYuOIoidHE9bXtRlTBsnTBEOfcFBC+sar8e3DY6bNf0bFnv
         DnUjPKoApjoR4kcF56u1q+wI+g6XxHsF/IeApnHlNObYRCdLg5CDKOmleVvTHHCpQjZ8
         wYSQ3rqzcrmEomwgUz214OOhM2eysP+WDqxvR/O8cxoeqycWt2QXMTgwAbqP+CMU9DPF
         Xi3lJAbqz8lbxKBPnvuYaNYGwGbjgpeWMWUHwdIGOzGJ6r+QauEobAgUSR+NlumCFcLa
         Lobw==
X-Gm-Message-State: AOJu0Yy//XRGLJue2+kW9JlRRjleMvRF9lgCfehKs+RUqpHnuuzwkYyh
	2RarnBKCcqF7y+3rSl0ne2cs5hhYxv6yW4GuSWWhEEFxLAardoYFdipcmfjvGSjD6IA=
X-Gm-Gg: ASbGncu6oYcgnV342yrYlCmwDFGyJ7AcdLtl86Xt5ovtiK619u7YgSoeU6NC6tYdpVk
	97NtzzU0p6gd2Rm1vmanf6zVNJCQs/lEogbTvhndanwMZbtyt1gHPy4UofxdY78CmZ/7IVanvzh
	Thym6zHoqTtcl4pbxKz9t2eUYScF+7hdvtmqWPmuMhg+RkI1Bl74Bjk8CyGn3onGENw7X+5oi1q
	qxlfZTaR6qcp/X402oy7gbp4dmYwReQdfViZZbkSSO3HfxOh470PhjUxEIOSVH35nSQkPwReVHx
	EmkTe8jBGH1cL9Jsf+KNBKfGBynhgbq/HWMSYdueQ9LJfNLqeT9SC2rXu6NiOMWYIbURLWrmFcy
	1bPdLri7Ys8FD+zxhS05/bKFN8d0EkxF4+5WCH13dUrR4zkWJfGJm4Vm1xE6FBrwaj2bBv63Ht4
	Krrh0aSB7mL6wq487wwPgqja2WtWgkWQ==
X-Google-Smtp-Source: AGHT+IHL82cO15eHplVrd1kOv7KiCQ0/gvt1t2zsTkhJijBzgWb2+lG9R/9BD16PD2C7Tq5jYtu/eA==
X-Received: by 2002:a05:6214:5f81:b0:879:dcbc:8ce4 with SMTP id 6a1803df08f44-879dcbc8e21mr144530546d6.52.1759772453210;
        Mon, 06 Oct 2025 10:40:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61fb91sm121659976d6.60.2025.10.06.10.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:40:52 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:40:50 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes
 on x86
Message-ID: <aOP_IobeHXlUPnle@gourry-fedora-PF4VCD3F>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>

On Mon, Oct 06, 2025 at 05:58:05PM +0200, Fabio M. De Francesco wrote:
> On a x86 platform with a low memory hole (LHM), the BIOS may publish
                                        ^^^ LMH ^^^

> CFMWS that describes a system physical address (SPA) range that
> typically is only a subset of the corresponding CXL intermediate switch
> and endpoint decoder's host physical address (HPA) ranges. The CFMWS
> range never intersects the LHM and so the driver instantiates a root
> decoder whose HPA range size doesn't fully contain the matching switch
> and endpoint decoders' HPA ranges.[1]
> 
> To construct regions and attach decoders, the driver needs to match root
> decoders and regions with endpoint decoders. The process fails and
> returns errors because the driver is not designed to deal with SPA
> ranges which are smaller than the corresponding hardware decoders HPA
> ranges.
> 
> Introduce two functions that indirectly detect the presence of x86 LMH
> and allow the matching between a root decoder or an already constructed
> region with a corresponding intermediate switch or endpoint decoder to
> enable the construction of a region and the subsequent attachment of the
> same decoders to that region.
> 
> These functions return true when SPA/HPA misalignments due to LMH's are
> detected under specific conditions:
> 
> - Both the SPA and HPA ranges must start at LMH_CFMWS_RANGE_START (i.e.,
>   0x0 on x86 with LMH's).
> - The SPA range's size is less than HPA's.
> - The SPA range's size is less than 4G.
> - The HPA range's size is aligned to the NIW * 256M rule.
> 
> Also introduce a function that adjusts the range end of a region to be
> constructed and the DPA range's end of the endpoint decoders that will
> be later attached to that region.
> 
> [1] commit 7a81173f3 ("cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution")
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

lgmt

Reviewed-by: Gregory Price <gourry@gourry.net>

