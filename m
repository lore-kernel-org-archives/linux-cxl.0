Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FC223336
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259143; cv=none; b=evvns1JLh3Obe5a1nXqnwefBhUJ3DqvAEhw37gK6bNVtdUkt0wjzDNeg+eOxhYWBKn2dkTqe1B/GBl8Bx03trY1rWaNidpN2ysqo0SdLcxUTx9bkHSetDeKmBsbaCCxJlYpT6bAGxcf0gsZWdLNolBdETMg3DZ0ba5mqzDDeJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259143; c=relaxed/simple;
	bh=ZoNauLjpKyH3DAShcEsgvFSrJpJqozh6wLl0Ed6u9Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nttI7RZ3R3EXiABfWzj+bhS90jKWYUwnGxeOBvRH/kxF2jB6F1jywmQ3yv6GZeh4lzyknecpuC5gXBRiYeC4C8zIDAF6UWuW/Mn+i7fbaAmTFLdarPZFCRfa9jZ+/C1r316BguGF9wi3BvxtV+IthQHTqOs/37MlHpvxnzDkuzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t+leLGhn; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t+leLGhn"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c24f867b75so713323485a.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 15:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768259141; x=1768863941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=92L4TdOg/AQugAUIkow3sIKqVPV7itnh+gH/CFEV7/M=;
        b=t+leLGhnKbvjzVgw+dHEopz9WwJBxLefX6isjRS90lJep1iN3D2qrCSyRaMNnEbTRD
         Wh+YSrtSG6b0nCDWonQGAe7qzf11SNmoWsZMIMcQbvdp5Y/h1RB+v4td9BttI2CRSBey
         6qKcHbe5iRGXFjVsaWDsGLPbMRzMmYJetTby3omJB41YYZ7hs7Cg0eB5wAb33SN2xOkp
         0RclmqVdSEivBpUDqoIFxljHqlWzM30C9jwgvyBFYIAODkW4VGhkQ+kkrUp/QG3EQgm3
         H7wF5Ta1GAaGp4OQR/0F53IaepQ0DXOmNAYalV5a9tPufxUycvcRyi/wMRJaWDMozaNH
         GX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768259141; x=1768863941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92L4TdOg/AQugAUIkow3sIKqVPV7itnh+gH/CFEV7/M=;
        b=laLK7J7hv+7H3Mzbqw+9uDK9xUd5gIZQnPu0EYpi6RYrTDUrorOcf5XHOPMBOXZp4a
         vIZKfI74/Y4JQ6jRDrSZaTDmAspCXcRjaw5NiVUJUr6ku/SEOm4cPpPg0nOoyMEizv34
         d+YOjy9LRseywIa1H8tAU9Sb6kbSXOEBwVoOW8cAK+wTtSVSQmLnHPqW+PdiCZ65Hdau
         POtFIFl+o3e+Be9ndeL3F5xNUakaBGW7i3SHCqBCqeigdpSPuNXofu5fOt+ZPXzep6yO
         yvlT2VbDIXcS8+ZWZglDTT2XjXqBwRPElFnsnC/QDwUoEji4vUkQgxW7E1u4sUa7WYXt
         zeng==
X-Gm-Message-State: AOJu0Yxth+kZiIAuG6qs1TfpXn5bXHRfl5BYEgbX9mr1AoqwenEjerdo
	Orvrf8T6vxzUj839MJRv0aMHNA3ya+ENgpZnRrLwLmRnyy8oknJpoGH3HlpN+LRXjxo=
X-Gm-Gg: AY/fxX6+LCLdhA8WwPvAYmk7U1HDsLVjez4YKNJMuhNAzFZi8dwF25ULKuwNJJ6e81e
	5Xo5X+bAkU6hyCixeAGliMtPxPaLiGCTHwJfVgJjWeFddgCYxt56f+95/h63BqJrqq/CEt9A7sL
	EJwIW8M4CsAsiZ+63U3kEtVTohm4y9ARkhqPgGPHlvei0XeEEjyAVuqqqaO7xliFWCIfPNUiPwJ
	xYs8By5zDQ21TH30Ytc1v7ltuUBYhkIytF1mRT/+cCepCaC4MVjsQCq43acqS1GuwSCc4HbPivY
	hBvE4MafBnbaNuE9YIxN9ec7enj+XVaIwT7XTjpaGY09dR/xt+rWMLx2RQBlHAgB8ToCSn3ZFKA
	GUukfslhPwIlgE7LCgDNAyZ9tV9+zEEZcC9ln1uO4FSTxalgVTDnh2Xjzo3n/tRYQDLFOKFijJM
	IkcVU4Io8QlfLJQZaPYw4gKhoTKeSHDDZjR3JAmys2xoxteXk1HYux4fPOJjd2/CVsRgjMlaHet
	qZVS6Te
X-Google-Smtp-Source: AGHT+IHwlNOUc3Pi8nsZFjFBY+3Up3ZCkjfkv6qwWxdPY/nNO44Sehb/7txzyAuNhDSiI6FwTr0sJQ==
X-Received: by 2002:a05:622a:2611:b0:4f3:4cde:1660 with SMTP id d75a77b69052e-4ffb4a52a39mr278973801cf.83.1768259140847;
        Mon, 12 Jan 2026 15:05:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffc17c2897sm96783981cf.32.2026.01.12.15.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:05:38 -0800 (PST)
Date: Mon, 12 Jan 2026 18:05:03 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 4/6] cxl: add CONFIG_CXL_REGION_CTRL_AUTO_* build config
 options
Message-ID: <aWV-H_YbSrmgAZYd@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-5-gourry@gourry.net>
 <05591180-c299-42e1-b8a0-ddd74c5f2174@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05591180-c299-42e1-b8a0-ddd74c5f2174@amd.com>

On Mon, Jan 12, 2026 at 03:10:55PM -0600, Cheatham, Benjamin wrote:
> On 1/12/2026 10:35 AM, Gregory Price wrote:
> > +choice
> > +	prompt "CXL Region Auto Control Mode"
> > +	depends on CXL_REGION
> > +	default CXL_REGION_CTRL_AUTO_DAX
> > +	help
> > +	  Select the default controller for CXL regions when ctrl mode is
> > +	  set to 'auto'. This determines how CXL memory regions are exposed
> > +	  to the system when no explicit control mode is specified.
> > +
> > +config CXL_REGION_CTRL_AUTO_DAX
> 
> This should probably be renamed to CXL_REGION_CTRL_DAX since only DAX is mentioned.
>
> > +	bool "DAX"
> > +	help
> > +	  When a CXL region's control mode is 'auto', create a DAX region
> > +	  controller. This allows fine-grained control over the memory region
> > +	  through the DAX subsystem, and the region can later be converted to
> > +	  System RAM via daxctl.
> > +
> > +	  This is the default and recommended option for most use cases.
> 
> If you remove the 'auto' mode earlier on, then you can just drop the first sentence here.
> I'd also add a note about when a DAX region can be failed to be created (i.e. BIOS already
> set up and onlined the memory).
> 

I think I'm just going to drop this entirely, probably this was just too
ambitious trying to create an easy transition from dax to sysram for
auto regions.

The reality is BIOS-configured decoders "is NOT the way" (TM). If BIOS
configures it - it's DAX, otherwise the user gets a choice (or they can
tear it down and rebuild).

~Gregory
