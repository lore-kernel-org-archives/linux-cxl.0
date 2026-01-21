Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782344E050
	for <linux-cxl@vger.kernel.org>; Wed, 21 Jan 2026 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039101; cv=none; b=BIxrrUpE2qfVqhvyXuETED0Y8UBpG8ETCtNbgA56tiYxoekZaksDudDO7EVzcwxCPl4dB5JL+H/ZTlbY58sCjz9yghwKT69s1c6bihpuqsMN6na+xQcGlSJMYSgrxqqNViKb9+2fiUHpT8INhdvc5KPxpIc5DDdgAVyZqIjs//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039101; c=relaxed/simple;
	bh=wBkerrGdM2fYQ5LNr3dtwQqunfzruJca9BSaKRsq0iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf2uqYtRgn716chGIneDt4cIiEAL4+DFnIQE5B0ZzlAKGhBqas6PHKdNNBnoNXAxyNPHqjkdMzV/wuBDvWJBdhcqbwrp/5yaBC3gVId6alzzG92hSMTdy4EP/YBG6ELwarRQBA5E89cFHRhg+WIv7ogvD6Vmc+LNM7fwwmQTcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BCDz5puj; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BCDz5puj"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a288811a4so4681996d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 21 Jan 2026 15:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769039098; x=1769643898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jE0ltWsYjM4scOr3navfxKF0tjslfZhpW8TxxjI3bRk=;
        b=BCDz5pujan4hoyTfypAvo5E8fPZN+CJhrcl2X+AqCHgzBOfi9OfwlHaVHUS0Y7cI+D
         g+JgY4nY78GoIKg8zDWW697hJ4uGLpLd/xRMdfZrWwD7tX8nGKcg64CLIaqR/I3r8PLi
         Obnuex7xv2EoyO+J2EJGa9U0GAnd/Hw6KGwepfDb5Xc344MJ5hloF9dopDeYdCIl9BF9
         61Fr+wKG2vKPQx7c1HBBGR3l2pWmPLXkHH9iFE6OJjOrx1zOhenMssTEstKuVOs1sQOD
         Sf4gvyQ7BYpXbtarwskFL2fX2nktCT0PJXGYSHf40qOZSFHWvdilqowms1p8AGmP8+AR
         Py1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769039098; x=1769643898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jE0ltWsYjM4scOr3navfxKF0tjslfZhpW8TxxjI3bRk=;
        b=fSyuI5VBRerkFKyta8Qxw0xoACH0ZlFQN3aExd6BxXRX8Ooo9SnSdlbWUKXob5GcM6
         rSQsYVHi00TPKOw0dO4TpV/UvrK0rHgwZS8AEYVB3UmCZAR6UmpxGOEPbWrVcd2DB1eI
         JQYTmKXDfxrxZvW+JBdNpo16NxU23YaIWspC7rIHlqfkUyMKIBhfYtAo1IX44IkHiL70
         XqcnaVfvFFKNu5UQWI9wwePuUPbwz9CavFpn4iQynS040OcxSEZPZ6ynCXtsReVQmlsq
         fV9xA9CLpC4fds1kHhLJMHljIQUZohTSIIuoTsBbQ/7VBCfnkrHZ85zrg7BmUF3hmQmS
         +ffQ==
X-Gm-Message-State: AOJu0YzSkmnv3hs9vDutZOf0vxOify3BucRCsM9NZlCO2HMUL9H+PLY8
	rciRJcMBrHMDdW5ecTqCwU3FtshzXNlkyolL07GWlh3/JR+P89WhWUIX/zq/odNNQqg=
X-Gm-Gg: AZuq6aJ3kQs+S5sU28tDG0Ri6aiEtp1WHpE+Du9fPj9irUB1bVdeMEz+L9OmChH1FXa
	HmRCdy0Zs31sL+jvBwcqxNcbpntjaGPZQOyPRM4D2NbPatFiXijejxjtY2/RYazXL6y74uTFAmI
	pq9QDHIEck3MksrHSk6wR2BWBpz/E+YiiveHrjt0q5JQtpannm+P8sbRZJ8wU2qmNqq7TbDaQ8+
	N1T8Ra+HHvGDpkyEN9OQ1ct7EqV2ztpzezrWJFDGsEW6vRaAGWEIRZ/0Td+ovzCKhPx32E+LZNh
	UJzMo1r5a2XJCdj1qQrgif6r3jA8VU6KFawa1co1Bl046E6OJ/oN3Exc7zjDFVF/3fpOKDYWGKV
	bnz7NXw1Fv2JAvd2DhFDNTKdcSEOPHn98dAFXxppnx9+XELEVwWhBvDttcekCsRdfWuCi+7QSyS
	wX94HwXEZli7l4mjCZxQ3L10163308DBJkpsBNqbympIn7XymfAWDg1DXTm78+nO2VbEQwPw==
X-Received: by 2002:a05:6214:19cc:b0:890:738f:b037 with SMTP id 6a1803df08f44-89463837353mr113776306d6.3.1769039098571;
        Wed, 21 Jan 2026 15:44:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8946ca900e5sm39403656d6.8.2026.01.21.15.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 15:44:58 -0800 (PST)
Date: Wed, 21 Jan 2026 18:44:26 -0500
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v2 1/3] drivers/cxl: introduce cxl_region_driver field
 for cxl_region
Message-ID: <aXFk2pr7mFw4eqMK@gourry-fedora-PF4VCD3F>
References: <20260113202138.3021093-1-gourry@gourry.net>
 <697152cb75dd6_1ccf5a100da@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697152cb75dd6_1ccf5a100da@iweiny-mobl.notmuch>

On Wed, Jan 21, 2026 at 04:27:23PM -0600, Ira Weiny wrote:
> > enum cxl_region_driver {
> > 	CXL_REGION_DRIVER_NONE,
> > 	CXL_REGION_DRIVER_DAX,
> > 	CXL_REGION_DRIVER_PMEM
> > };
> 
> The problem I see with this series is that this is not actually telling
> the user which driver is being used.  Only which device is being created.
> Then it is assumed the proper driver attaches.
> 

I'm not fully following this comment, apologies.

> > 
> > $cat regionN/region_driver
> > [none,dax,pmem]
> 
> I feel like this will be more useful when CXL RAM regions can be driven by
> different drivers.  I forget right now the rest of your other series.  But
> I wonder if the actual driver in drivers/dax/cxl.c (the dax driver) should
> be setting this field?
> 

the code in drivers/dax/cxl.c gets called by region code at probe() time

So by the point you get to there, you've already made the decision to
engage the dax_region glue - i.e. this is actually needed to be set
prior to `echo region0 > cxl/drivers/bind`

so the workflow looks like this


   - echo region0 > decoder0.0/create_ram_region
   - /* do all the decoder programming and commit */
   - echo [dax,sysram,...] > region0/region_driver
   - echo region0 > cxl/drivers/region/bind
     -> region probe() creates dax_region
     -> dax_region probe()
     -> dax probe()

so region probe() then sees you selected DAX and goes down the dax
rabbit hole.

> Also escaping my memory ATM, is why one can't relate the dax_region to the
> cxl_region in user space already?
> 

you can, it's linked in `region0/dax_region` after probe()

> > Auto-regions will either be static sysram (BIOS-onlined) and has no
> > region controller associated with it - or if the SP bit was set a
> > DAX device will be created.  This will be discovered at probe time.
> 
> This seems like it adds information.  Since these BIOS controlled regions
> kind of get 'lost'.
>

It actually just formally encodes: "Auto-regions have only two
reasonable end-points:

    auto-SysRAM region:  no driver control (it's already online)
    EFI_MEMORY_SP     :  DAX

This is what the current implicit behavior is.

> :-/
> 
> I'm not opposed to this idea but I'm worried that this adds to the already
> very implicit nature of the CXL subsystem.
> 

Point of clarification:
    "All RAM regions will be defaulted to CXL_REGION_DRIVER_DAX"
                      |
		      V
    "All Auto-regions in a RAM partition will be defaulted to
     CXL_REGION_DRIVER_DAX" 


Auto (BIOS-configured) regions should be considered evil for exactly this
reason. They make the software model much more difficult to discern.

If a user wants to change an auto-decoder region, they would have to:

  1) unbind daxdev
  2) unbind dax_region
  3) unbind region0
  4) echo 'new_driver' > region0/region_driver
  5) echo region0 > cxl/drivers/region/bind

Unless we want to change the existing default pattern for auto-regions
to just not auto-probe, which would break existing systems.

> > +	/* NONE type is not a valid selection for manually probed regions */
> > +	if (sysfs_streq(buf, "dax"))
> > +		cxlr->driver = CXL_REGION_DRIVER_DAX;
> 
> How does this work?  Doesn't this have to create a dax_region device for
> the driver to attach to?  That is the equal to CXL_REGION_DRIVER_DAX being
> set at region probe time.
> 

This gets read at probe() time essentially to generate dax_region

This is essentially how it "already works" - the information is just
obfuscated by the default nature of:

pmem region?  ->  nvdimm glue
ram  region?  ->  dax glue

> Hindsight: It seems like this driver should have been called the CXL
> partition driver.  As it is triggered by the partitions being found...  I
> think.  I'm probably really confused right now.

I was trying to say this on the recent dax and CXL calls - the current
region driver (region.c) is really the PARTITION driver, and what i'm
trying to break out is the ACTUAL region driver pieces.

This is why the original series called this a region_controller, because
both region and driver here is just overloaded :[ 

~Gregory
