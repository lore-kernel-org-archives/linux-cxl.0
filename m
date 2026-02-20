Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B482773EC
	for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771565040; cv=none; b=O6G0LhAmlR7wyDntp1v7ILbM+I/Uf5JjeN5/nTPizO99AaIk54Fz6jdPoDOHm/VGRwjgiL7drBBNmM2HarcsF2Z5zMMACBBtHNgc04VINhfvm9wn7Nq2SdZcqoS9iHf2mXtG/DaAIWk9+kal/NdxikFN9yDxSNgKoZFm9e+cWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771565040; c=relaxed/simple;
	bh=UHd4B3J7HEupzmWVv7GzRXngOGVQEy+4OCQQYYWfbl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THHQ0VFHcVxpykfHZ8j0z7VtmDfxDmrLHM/Z2h2F7KuxYP6QPMiT0sjr8T+ecjZEFRSswjsFre39i4RDvVEUPm4qFlQVgmHz0ZSadFHZhJ36a+l82K/joqJtRJlsDkvA4oUSgfJqt9KETQDskpKlXJxMs7+qsaIfSjF11CuRwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NxyRk/52; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NxyRk/52"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c710439535so120526285a.1
        for <linux-cxl@vger.kernel.org>; Thu, 19 Feb 2026 21:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771565036; x=1772169836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3KruqnMh9Yui6pRs3kQeBNIY15XR1zawggAIpyZqDw=;
        b=NxyRk/52bsWJ0Jazv0Gp6xB9qLLNJtUMG8Xl4X5K29LUSoVjI1nM3lbkGtvVaxX7BD
         PRaJdWDpH0XbhUf1ObD05jT4I/8yNtZBOMdr6OzKYxiBjgrRC/wO/ue0Zkn1WK+2+B2L
         Ct7DgWShFmlIVvL+QYZ3/csgBCyVLcsuSyDzAelIi2jpuv7E04FHqeLBJfZn53CvAYFf
         1kurdrd9huDOyXNqkM7RhRN5Irkl1UFdZPoW+doqr16XFKQUEo7uQ5eq/TyqMmIObYT5
         2frCeFhZqyxOK0Fpzx3bg6KgojNj6fQDi1oouzPWVb+VgcydcKUs0QyWk2bdK2Rt303w
         18iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771565036; x=1772169836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3KruqnMh9Yui6pRs3kQeBNIY15XR1zawggAIpyZqDw=;
        b=Npv1nu0tyFHdc0y11tUuFr3J5fZQ8jyfzrJw1zYfw4PFRxLPdHzEqJ56P5uXnAPsU4
         unlwP1AzFm/ZN+FUhWkxSPHSjWbquySWpAjQQQMNZ06xAAbUl611YhR6zN8KwlZ8RZ/I
         0UemyqdHXTQhXESYKY/W+WcVlJcs0b+k1HEQ3o8t2omzqTddt+XcPyQ/aodUEBRgzyEn
         OglPm+e4dRDcJv6VOSfDJexFKU8r+83B2eyuoMnjYPzHIlHyjI9MeGSiP4QoCLLUsQIn
         ojLpXFaeo5AXjZdrCtsplw46gCK6yK1k/2wRenuxBvopN2uQqvf9nwpr3Lvi83CS31i0
         mkcw==
X-Gm-Message-State: AOJu0YxX/YX5kR/v06huHNzOKAVKIAieAyVhfOzwm80jXTs1ipX608Cc
	XJrngJRz1lBd14rrmdqae80d/d4hFFh3YiL3wOLjJrMr2peKnZ0S5m1OOvzUnubws7g=
X-Gm-Gg: AZuq6aIF5sUwvRPDlchqrHwPpAbNhKN5Gv4KUcZiFURObYQ3BLv7efNFRF69zMT8gwL
	TBgemVd1aHVNsxYNAPt196da8ZRoRYc3E0hWQOXblBW6IvtLwLV6OVRSLbIRXG0yQN8hIR4Y5WZ
	i1DENr633x6GhJ0VAdkY/zJllQLfPGAeDrL4ysn+KZu+GMKwL6zjb4aLAMrIdvvVkaytcuCHrj8
	RD9ke6WK7yMmgrMy1QFkilr1uXeXBwomK31vUuztLu17qhtllc1cmB46OELCWj1Sg3dD2ZPO6jU
	4E1S93iKXWE/FWSr5NJIz4wTFp0XPnewl5eUjYj7RzC8VxCD0v9H42QmMkiMDttpNiHXTALjP1a
	NydQy9b9LziTJU/NiOQm8nyLHpD6CElVHfG1tXP9IUUKuhlLV/4Yvqzf7I08Tvu6kHrv81MQKch
	Y7l89q6FumIBSoRAYh36z0MIhngPPqoC6j7Z+uKHsbhL35oxxzwunUs8SSnYR+Dncnbdn+LtgOT
	ydBS51TGQ==
X-Received: by 2002:a05:620a:2996:b0:8c7:a84:d0e4 with SMTP id af79cd13be357-8cb740324d6mr936535985a.24.1771565036560;
        Thu, 19 Feb 2026 21:23:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdb5dbfsm266965576d6.41.2026.02.19.21.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 21:23:56 -0800 (PST)
Date: Fri, 20 Feb 2026 00:23:54 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v3 3/3] cxl/core: use cleanup.h for
 devm_cxl_add_dax_region
Message-ID: <aZfv6qQR5DoZ7Chp@gourry-fedora-PF4VCD3F>
References: <20260211204206.2171525-1-gourry@gourry.net>
 <20260211204206.2171525-4-gourry@gourry.net>
 <68d44fc4-55fe-42df-85ea-cffc60454325@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d44fc4-55fe-42df-85ea-cffc60454325@intel.com>

On Tue, Feb 17, 2026 at 04:55:13PM -0700, Dave Jiang wrote:
> 
> 
> On 2/11/26 1:42 PM, Gregory Price wrote:
> > Cleanup the gotos in the function.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/cxl/core/region_dax.c | 21 ++++++++-------------
> >  drivers/cxl/cxl.h             |  1 +
> >  2 files changed, 9 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
> > index c8dd2bd1d9b9..49907c6c7620 100644
> > --- a/drivers/cxl/core/region_dax.c
> > +++ b/drivers/cxl/core/region_dax.c
> > @@ -81,29 +81,24 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
> >  
> >  int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> >  {
> > -	struct cxl_dax_region *cxlr_dax;
> > -	struct device *dev;
> > +	struct cxl_dax_region *cxlr_dax __free(put_cxl_dax_region) = NULL;
> >  	int rc;
> >  
> >  	cxlr_dax = cxl_dax_region_alloc(cxlr);
> 
> The typical __cleanup() pattern is to move the variable declaration here in order to minimize unintended issues between declare and check.
>

Ah, relatively new pattern for me, i'll clean it up

> >  	if (IS_ERR(cxlr_dax))
> >  		return PTR_ERR(cxlr_dax);
> >  
> > -	dev = &cxlr_dax->dev;
> 
> Given that this local var is used multiple times, maybe we should keep it?
> 

Fair, will re-spin claned up

~Gregory
