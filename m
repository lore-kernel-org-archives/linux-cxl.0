Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8C349B00
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047974; cv=none; b=LcIEMChiUklzKyz23k5+6LddhSEwFJE54R6PhuIJsTvfNBfMWcijmuN+oKWiL7CxUU+ANN4DekpzNlMVGGKAdkv1/1QoAJEiliO85K4sk+cnju3PXV7E7AhK5fOyEjOcFZ6EtrntZGzgJ5XbsyYlMWW1p/7Dmx8ypTkW3JjRd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047974; c=relaxed/simple;
	bh=FpHmiuAi2PEGYGdfUWr8Tpxa4Vnxi7QjC6hzvBSKe2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouV38LV12eb4s88/DQOVsMCPoMG4R7/sT9lVHJxNbMiId/9+pFy5no/n7kFA6dBy8Lc3oCEpyFdwZHiX14rxhil6t7HkuRPYjfwyQg6o324IQm/4rDZqp/UTGuD+isMnDQ8+73aGXToZz3zMSeTZAHKjzfk7WU+IsoeOTkGrdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kgGIN7j7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kgGIN7j7"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-502a789834fso3614131cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 21 Jan 2026 18:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769047971; x=1769652771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fl0XJaBVsCAG2KnA3TdcTZofBYpAtYootNm4y1Bh3aU=;
        b=kgGIN7j7Af87qcXodrZ0M5tYXSNbnQWSBTst5cccZ+0x4glcDjiPNeMehjCCHd8hxI
         Bo6mPHz+tPRMz4ABdcRh2wDCoNnvlkkaQNMz+3JkDOpw27AxKB4xzk82x/igqSj3qIHI
         3OCZD72KiBRqmpXjC0weVduqv9/2vV8ZRBWLDVowImHdMk6c3lSuPIp0JWhhApMCJYPf
         VQuPrEF89RzmYGSFoX58bdMT4lnTKYBTu5yYPPQVv/0UcxT7aPWWPD/xi4zbibUq3Cj6
         GThxD/wbi4ULr9HkRRLNb4oOioAcaFMEkDTFcXy6w3Z4VLeNy4xavfPJQdZI3ul/L2xe
         HP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769047971; x=1769652771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl0XJaBVsCAG2KnA3TdcTZofBYpAtYootNm4y1Bh3aU=;
        b=j66DAu6dwsGnaqFY1lhFPwxIvM+WI8CkyqF5+czF//S2kt5flrGayNgk695423Pr7e
         /4/KGIyIm2rIaW2eec9u7kOr8f60x2v5knCaI2lAH9/QB5gvv4qyfyUcmqLbHLdJ73co
         pysDN6FKsU/bQ5Coez9Msbv2GT9U0Ci/d5VbJ9HfHhysqNf86lunst1fUuVbTtiRyeTx
         Ef2av0T/Lm/RmhdhXzWXW7lbo0DKJsfoxzVJRTc3YqPfx8Vwec+hGboOK11SsoHTV+XM
         4QlE0dLaT/jO8rNdJYME0ObtSS6UUsxcXiQuaAsZh7x03Vp9ysqgqQ/rZmtyQNAco9M4
         21QA==
X-Gm-Message-State: AOJu0YyPXHfX1kHtSDVf8tHKFMQkstoWBu1BvzRHhHwYSboArVn7QhJb
	3KH3vLib89be/lWKfdCfsRsEsPwyPAzJaS20ma4//1uk1t/U2RjtpkqjmPraenyynGY=
X-Gm-Gg: AZuq6aIrns03N9UdKmQCx31Ho0ViEVSLQdQuZz1h8wYFe7BxYrzL/9Kjzj46wUDAoZj
	XkTav2Vvy9XKNJVJakADa6kEiQSHkPIKzzHauacGN1GGxKiRmhmZqaEfNzzMhNxiHAaF1CVeclE
	AkfNEiecnUDSdUyAFe0PnIo9rsXpNJYWG3F78XyuCNAtOcoe95eF5xW1G78kMXnMgqIhWAV5Bxf
	Ty+9puXmohgVhClaZc2NyTDLhFQ2KclClEUpH/EBi7tYn6fIgOtxTtfRKHz+pVRsmVTyUC4KFlX
	VKJGJclIo+7/U0gC18Y5uaQzVIBDtRjWZwZph12Pd56gTdsA9nBcSjTeEgyfjHSgCcIntWS7+ee
	yvg0M7/7bQHHwMB+frHPC7vEZS4uXx/EIKl0cqwUfJ9RrRlAhACqx2Ub+iC+8aAPcdw8jpMfZCC
	Ocwssq4Xrp9Pq9g7uBZWOK33uRmgqYBM08XYFRY5efUp9qK8s9ZZn7I+MKtHvMhY65SMyWlw==
X-Received: by 2002:ac8:6487:0:b0:502:a21c:ada with SMTP id d75a77b69052e-502a21c0c5fmr226856531cf.1.1769047970945;
        Wed, 21 Jan 2026 18:12:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d6e101sm138259591cf.3.2026.01.21.18.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 18:12:50 -0800 (PST)
Date: Wed, 21 Jan 2026 21:12:18 -0500
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v2 1/3] drivers/cxl: introduce cxl_region_driver field
 for cxl_region
Message-ID: <aXGHgtAHNVWJsZbo@gourry-fedora-PF4VCD3F>
References: <20260113202138.3021093-1-gourry@gourry.net>
 <697152cb75dd6_1ccf5a100da@iweiny-mobl.notmuch>
 <aXFk2pr7mFw4eqMK@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXFk2pr7mFw4eqMK@gourry-fedora-PF4VCD3F>

> > :-/
> > 
> > I'm not opposed to this idea but I'm worried that this adds to the already
> > very implicit nature of the CXL subsystem.
> > 
> 

Took me a bit, but i follow this now.

The current flow of things:

   echo region0 > cxl/drivers/cxl_region/bind
      cxl_region_probe()
        - devm_cxl_add_dax_region()
        - dax_region is created and probed

      cxl_dax_region_probe()
        - devm_create_dev_dax(&data));
	  dax0.0 is created with IORESOURCE_DAX_KMEM

      dax/bus.c discovery
        - dax bus discovers new dev_dax
	- dax bus auto-sets driver type to dax_kmem
	  dax_bus_match() -> dax_match_type() 
          if (dev_dax->region->res.flags & IORESOURCE_DAX_KMEM)
                type = DAXDRV_KMEM_TYPE;
        - dax_bus_probe() calls dax_drv->probe() unconditionally
	  
      dev_dax_kmem_probe()
        - kmem driver starts memory hotplug procedure


So to my (your? our?) point - the following is implicit in cxl:

	if (IS_ENABLED(CONFIG_DEV_DAX_KMEM))
		create_ram_region  ===>  dax_kmem
	else
		create_ram_region  ===>  device_dax


What would have been nice:

echo region0 > decoder0.0/create_ram_region
  - region0 is created
  - program decoders

echo region0 > cxl/drivers/dax_region/bind
  - dax_region0 is created
  - dax_region0 creates dax0.0
  - dax/bus.c *does not* auto-probe the driver type
  - user configures dax0.0

echo dax0.0 > dax/drivers/kmem/bind
  - dax/kmem.c does the whole hotplug song and dance

But in an effort to make auto-onlining capacity user-friendly,
the middle piece was automated away.

I don't see how we dig ourself out of the former flow without either:

1) Breaking the current auto-config flow by adding:

      cxl/drivers/[xxx_region]/bind

2) Adding something akin to `region0/region_driver` which is basically
   used to replace the `echo region0 > cxl/drivers/[xxx_region]/bind

   you just get
   switch (region->region_driver) {
   case dax: do_dax_thing(); break;
   case sysram: do_sysram_thing(); break;
   ...
   }

   do_dax_thing() is otherwise just dax_region_probe()
   do_sysram_thing() is otherwise just sysram_region_probe()


~Gregory
