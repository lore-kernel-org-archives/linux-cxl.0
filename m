Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15436BCE7
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233649; cv=none; b=nz8RMihfkp79t1VUrjtGEgCDQsr8m2ifalARr+U5z50lQZf0Dcz9up0QO/L0SzBzxORrGH/CbtfZ0o0obErA6/+DjtdH4Yzd0bqh3PHTUigRf2bj6ePki1IUibzL+aqAwsfSHBs8VH7Gc91KzrNEKtKSfcCaqGR0I+QdInfVVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233649; c=relaxed/simple;
	bh=+9SaFYClqb7p16I7i/FRxMmd3fl6XqDpKglW36YGrDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC3/R9t3xgRZ8dkCJh+WhQaKPfUN/sm15RoJRb68e4dn7Re4Rb37oajRv5WwZJZt2GfTC9Jj423JilJzM9PiaPYxboQKbu3zq2ouifgJ2m8A/7nTnfOe3qNW8tiu0KQqMbP0hygOVV+Oib7mQOBgxzviuKa2XKWQMgtpOqG73kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gXQ/1/ZF; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gXQ/1/ZF"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb420fbb5dso150643585a.3
        for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 15:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772233647; x=1772838447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgjD1UJG2qaMbMVM5N7MexfN0DQdoqKM/USOsU4c+UE=;
        b=gXQ/1/ZFrykkXVNdFvLGWI2/VrSTwP1fKjuuDLgCzUukQWK62dA2cq/HSrZjIx6A/3
         bzvhEIhsoYoxyipVAxHEKsshcc3r64Co0w1UROPFVG3ROsUfOLhlb+QqZtnrxRsYt+6f
         OBFK1GDBJK6f8Ty/CLHvdwGSTFS6DiuOlVcnBsA81WtL7o6FcAePItlRX+D7QZ6oE6Uf
         6nYG27r0JV9fRhywVjmkIY7yOOV7W7AM/hVwUmEIS/9Hlzv7zh7SN3/IO98xmg91HZYH
         6rY0Py07j02s1QjZhdAqT1He0Bc8apPD25p3R6fTJaLENCjzUvkEpXqb/NmxBCYvg7LT
         sRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772233647; x=1772838447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgjD1UJG2qaMbMVM5N7MexfN0DQdoqKM/USOsU4c+UE=;
        b=I9ca8u1pLjspIxo+5V7nkZ3Law3lqOhh0/27VV6ZcxaiysArM0/qpV6BOnD6sGfMyG
         PWvsTz3WJkYv8yD5GP7/S5cxsqF4aMpSm54ZClg/bbkvf6jtJ1tPS8JC2kavkZnDSOAG
         otQmSWTJLN08sPLUzeccflAbB+6vLzHWaheoRwHlErarNVRMMzTLnAi/02OAxEC6XiH+
         kj+lEcMRY20/+Xx+nli7BoNR5Dm+ZphOYmW3PuP+BcENJS2BsXp71BxUcYv7T9ythT+D
         hyNmzcZpYCwDwOePj6nTxqL+uacdGGr6zTPw9rRFzNuEX3jJtk4Z59o0okoQkgfpkrfe
         sxRw==
X-Forwarded-Encrypted: i=1; AJvYcCWR2nr2RdF5IVzFyBOJ5+BGIOuoQt6N+aNZG7LIY6ypF0s9uu3r6xJsYZRo9cOUjcCp2lUGzHMFVMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDYvx0zvzooRp0IZNqCKDc+79E29Lo73RfolBs4gF0KdUYQG+G
	JCh6vC3euLFHTf4lTPWx60KstOQT9nKIjSvYkPvckpgQoOOlx0kP9SsjeFAJ4v+NpZ4=
X-Gm-Gg: ATEYQzxAmIk/7yfM52FwQY60WiITiJOueDxJ52fuj24Plj+ABkDsAYe4Awk7frpfFsM
	lPB4GvF4iSQ0lMRYfFs0i+ryvuWNu/B/Nvc/nLDL2CiAia1VvzR6LEf9zX2wPJNPUE6Mi5gyRmM
	WFpXHRj5Z0zKzuclBFFm5UH3wvEEMx5EinHR+jdFmmCfPtyhRiUJiIxys7vJxf69oicnW3p2bMT
	yVIOtI64p0za36r/r5Si/6TFLRpaFlGBsT6fqTmPaj60QyDeEZ7b06A6FpMEb+MK7NU+nD01fF9
	9qP4oVEz+99GjKh9WDLp2x+5E6KxFZI0o3xJDssdTl3awZXqKIVk7u1LQhP+JwYsrNsCNcTR7Ym
	c4CLCso/J3Z3LS6ESQS2rvP1UEfhJ631LMBjDcn7V4BqBcP4xztPYZ+MvizMfvuEzGhp1LIMs9P
	nwpkeXaEwzlvJf1eQ40ZJPZnitAnAdIdaZjke8euFoXmgvwsSX31tWuXUQssu0unn5W79UXkFfn
	2/yszrvBw==
X-Received: by 2002:a05:620a:4410:b0:8c5:1fd2:e9ef with SMTP id af79cd13be357-8cbc8e98257mr595797385a.28.1772233647137;
        Fri, 27 Feb 2026 15:07:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf72e21bsm579738385a.44.2026.02.27.15.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:07:25 -0800 (PST)
Date: Fri, 27 Feb 2026 18:07:23 -0500
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, dave.jiang@intel.com
Subject: Re: [PATCH v2 3/3] cxl: Move pci generic code
Message-ID: <aaIjq03lnrD_4tsS@gourry-fedora-PF4VCD3F>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
 <20260225121430.3839189-4-alejandro.lucero-palau@amd.com>
 <aZ8cp4_xhEspZxwX@gourry-fedora-PF4VCD3F>
 <c3d22e56-8762-421b-acfd-1b7dabdc17f3@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d22e56-8762-421b-acfd-1b7dabdc17f3@amd.com>

On Fri, Feb 27, 2026 at 07:59:19PM +0000, Alejandro Lucero Palau wrote:
> > we call cxl_pci_find_port() here twice on the same pdev and pass the
> > dport into the second caller.
> > 
> > Can something actually change between these two secnarios?  Seems like
> > we can just drop the check in cxl_rcrb_get_comp_regs?
> 
> 
> Uhmm, I do not think we need the second one inside cxl_rcrb_get_comp_regs?
> 
> I will drop it and mention that in the commit.
> 
> 

Since this is existing code, i would just use the patch i provided below
as an add-on.  That way if something breaks later it can be bisected
cleanly without affecting your original movement commit.

~Gregory

> Thank you
> 
> 
> > ~Gregory
> > 
> > ---
> > 
> > cxl/pci: Remove redundant cxl_pci_find_port() call in cxl_rcrb_get_comp_regs()
> > 
> > Remove the redundant port lookup from cxl_rcrb_get_comp_regs() and use the
> > dport parameter directly. The caller has already validated the port is
> > non-NULL before invoking this function.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index c32cc62c501d..d1f487b3d809 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -707,11 +707,6 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> >                  .resource = CXL_RESOURCE_NONE,
> >          };
> > 
> > -       struct cxl_port *port __free(put_cxl_port) =
> > -               cxl_pci_find_port(pdev, &dport);
> > -       if (!port)
> > -               return -EPROBE_DEFER;
> > -
> >          component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
> >          if (component_reg_phys == CXL_RESOURCE_NONE)
> >                  return -ENXIO;
> > 
