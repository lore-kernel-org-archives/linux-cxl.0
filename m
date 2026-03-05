Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD935E92F
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751371; cv=none; b=U6JIvKVgeQU9YS2W4ek/+xwzAVVWWNezq1M+DXnuD9hHFZnypD5QqRF5GHK5pPbieuyRbSewGYodz433w7qCx2EJ7WCQ7XxntHuxFPDeZgSFiYqKmi2Nna5veGCdFX0wnBSQbI5HOPdF7iOpMPfqGma8Zx5g1oPNoSoTd0rwUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751371; c=relaxed/simple;
	bh=qpI76v0XgFB3yIVbRt2u1yo0QZ6L3hkZJNDOFh4GshQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkpQPVAm03Qgy+vWGbUe1Mjd3shtujI+9ks9YRqzO+nftdMNBbDGN8PMtNL4ItYO9p2SZF2j+3dhPLy/zy+1UsfPXbfa8mKMBplZ81Zi85NDV17E/fmnH2qMByMxxHEEqR6leZbML6fMWJNiGR43BlOM/EpFXfKzjVGNW/oZQUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kPUlzkQa; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kPUlzkQa"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5069df1d711so73485291cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 05 Mar 2026 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772751369; x=1773356169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98PGHqayllVhENZOb1pwRczAKpzLwpJo7+UIcfoKFEY=;
        b=kPUlzkQamzALcn4Qmep4LEyA2opjfnKdLVswWBkyQdmVLGZFw2OU3oCV1Na6VM0cpn
         1E+DI75hMUUJMkKiprMaJvwqVOsYjTmgbGqKECFZK+VOY4H9J4ZJvfS0y6FQpSR5DDPx
         O28ZTTKkw1VV9ArUEepX5SkTMHt9mYTr3SmBbjBAAlfrt9+2Zbk4Maqy1ABvRJyaXvqa
         DrJFUzGZTwcDKfXwD+/eEhwLmvgGdirXIVAB7VIi8ko6YjPCuM3ZAUnxzOmAzNfG+KaY
         ivzHak82hq6yXiN7y6rQ22MDSjskfypk4KXFDydXMa+fzjBP616VXMZdEOwxij3agFRO
         tS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772751369; x=1773356169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98PGHqayllVhENZOb1pwRczAKpzLwpJo7+UIcfoKFEY=;
        b=ZbGm+yVEC/XSk76iNCfQVTaiKzDacaY7y/XNvfEe9tpUXZHVFhLcM0wuxFjVI8y1Y2
         uJQwBjfSmXdZqT8SkaYDqSA++yQs5d2E9ODA/B8iPYCNS0CeJq/TKASxZYrTku5feaQ5
         7HfoG6pPoqqe+aO+RP8GR/hp0/Ng//9PNTAauNxqYhdEg683CW4GNatVzBRTWudSwGA+
         5552kf5IirYereq1Vk1KuN9o8bw+WhNpcxlp2VJj3FvyZVlo4/Z/HEBDvZYymKrqQRDo
         d3TOn6lc5NGVGwcTe0f1VYeJIgcncT1LXkVw2J9fHXv2m2PzIuwtPa5sp1QowiJW+8wa
         bo6g==
X-Forwarded-Encrypted: i=1; AJvYcCUIn2HubbTYESTFF+bGm5yPnbk/EWH10rNTtCFB9q1PJViafwohwKE9I7nkRvr6rpUZ11aeoKqQ2G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9syuMzqLdk3qz0vgi8/HRqLbAKZ6XfN+EMTf2WCs8CkXpfECJ
	aSdi0t1w3hX8zT7E2nIQ+4ZZhmi7HMBv5WpLKFBMHVkkaeFO+wGAK6AvvPWFXooBrNFDAWZ06r1
	BOGka
X-Gm-Gg: ATEYQzzcJn071yBLrbCi34m+lKjqV1IqCp4UwOVfgMlLLfDFEkhzj3pdr2YNzuVDfeN
	hMVA6b5GVBlgNcQQJcPUshqZTZ2QS8MHPRCPEyxROuAFEqWfAETh4WOqx1kT23MOWXid7dH2NnI
	aOO5Ek9BP2X039aZ9eMxYxnQZZDcqLGrcbnO9Yq773ACrLWwCwqyLlJDaT+TmGt/Dyre4GZXuPh
	lCPeA5LGYQmUwPUQlfrO7TsmOMTDXLya/MB46UgKAYt5oATQiEFvkbrjadqowVSQQRECgC7m8d3
	9jpY/rGp7N3BdpciR2/43ciaVd/pFr5bKKhMOP5GlsHtkthv+WSi/eK6n9DQmkbJTXBPBdwknT1
	zawMnCcQpV1DRgrXMJVz+qn0US8WUyWXsS5mYgzC4kmavmiPsqW3TXWUXmE+0C1fiAX7kNSbRUl
	k2A80ObIz5GO+zq4vbTBLpLowUQZWMPOzOJXI+SU/dS2/IO99WT8reHDhmyaD0ewGOiUQKu179s
	Bd9Zseiqw==
X-Received: by 2002:a05:622a:15d4:b0:501:4701:e9f9 with SMTP id d75a77b69052e-508f49097c5mr1344401cf.26.1772751369007;
        Thu, 05 Mar 2026 14:56:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50751256df4sm160509621cf.16.2026.03.05.14.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:56:08 -0800 (PST)
Date: Thu, 5 Mar 2026 17:56:06 -0500
From: Gregory Price <gourry@gourry.net>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, dave.jiang@intel.com
Subject: Re: [PATCH] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate
 mismatch
Message-ID: <aaoKBqP6pzAeF96q@gourry-fedora-PF4VCD3F>
References: <20260305204057.1516948-1-kbusch@meta.com>
 <aan_z0psj080u1e_@gourry-fedora-PF4VCD3F>
 <aaoHBcKZeQpioh4d@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaoHBcKZeQpioh4d@kbusch-mbp>

On Thu, Mar 05, 2026 at 03:43:17PM -0700, Keith Busch wrote:
> On Thu, Mar 05, 2026 at 05:12:31PM -0500, Gregory Price wrote:
> > > @@ -59,6 +59,7 @@ config CXL_ACPI
> > >  	tristate "CXL ACPI: Platform Support"
> > >  	depends on ACPI
> > >  	depends on ACPI_NUMA
> > > +	depends on CXL_PMEM || !CXL_PMEM
> > 
> > Trivially looking at this it looks funky lol
>  
> > alternatively:
> > 
> > https://lore.kernel.org/linux-cxl/20260302200429.803417-1-gourry@gourry.net/
> > 
> > Not sure which one we want here
> 
> Yeah, I found your proposal just minutes after sending mine.
> 
> I agree this is whacky syntax, but it's a somewhat common Kconfig
> pattern (see NF_CONNTRACK in net/ipv4/netfilter/Kconfig).
> 
> Anyway, my proposal here should force demotion to "m" for CXL_ACPI if
> PMEM is also "m", where your proposal should force a failure path at
> compile time if ACPI=y and PMEM=m. I really don't know if there's any
> preference at all, I also just wanted the kernel build to complete
> successfuly. :)

my proposal allows compilation but fails during probe because the symbol
is IS_REACHABLE()=false, but yeah, i have no idea what we want here.

I somewhat prefer not to auto-convert config settings, as packaging
changes can be painful - but I can investigate whether this will break
us.

~Gregory
