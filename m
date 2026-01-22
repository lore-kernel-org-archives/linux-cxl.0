Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11372388840
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099332; cv=none; b=Ic6uSlskqpONtqBwWw4ftoacpoK+RR1oLizOow54diOdY9JhcnzSnRGRGczSO1XBy9Rc1PM7j5l2NHAuW8ZsbO67srzzHHE7RSduZhN/wPNHaSM/5oAEqcx17tgZBzgBTGzvOCGu9Kh2ZUjekvqw1Kjxi8UKczDDhjFO/iBj6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099332; c=relaxed/simple;
	bh=zB+qEZ8EpeRHvX53ZsIUxrTOKaSOOAxpFiVxkc0PaQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYBJXNZ0ZQsz12MZktVQKixEjU4zfMlW1rxLq4h+ZElPNPeq0+4HbemCOSbskbLL3uZBAzWJdu5tE0idq12csVzHLn+MdacyWD8GLdbzotmKmRLhkjRJYd/95YZoP7bugxcaUkX3zQSYd9RY/qIDPqppyln6n6ej2oXkGOCMUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Vmu2oAW1; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Vmu2oAW1"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8947404b367so13109326d6.3
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 08:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769099323; x=1769704123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jlAxY2gp3BONxkfJk95t/9cJhh/Z8xyZKsDUhJMCK0=;
        b=Vmu2oAW1x/tbBVVndmIIdIM83aud6TI+sjO8JQdvgFpHP2ZHTCKVPXAww6TNxgh5lq
         SOU4hZYSwPkYub0m2qtGWwaJYeCrUkxLEB+6MAwjTfgGdYjtpCL0U1lHHwyPlsHZUNPB
         NVVKbY4MEjVasYLjgADf1nf8SKtww1SGU1Whxjairg8Fl76aOuQjFDXtKu9YDutFHnso
         vX7pRe9lygViKtt+xcrlZdaR+dZ/WrIWAoo9/6uODo9ANROSXxfuHQUxO4fILyOjD7Il
         B0qbCaSWMNl41H1p415CpUzdyJrlnhfemvF9uUN/wAv3fDpKfSz6zOjLgbQP9eeAHh+u
         J93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099323; x=1769704123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jlAxY2gp3BONxkfJk95t/9cJhh/Z8xyZKsDUhJMCK0=;
        b=MKnBywndXc0xzNoxMIk+89/GGfG52+Vmd/7aaAKg0eN7h6WP1M4z8vEqVXPuWArDRm
         /L5GGQpcl6yDPI5gOdIRlE9gcFhACq7lefXUAN56cMy5YD1nby77dliJz/vCi0gzEPMC
         +FGA+Ldj5mcFQZvL2DRB1kXTtEKRnLh8i47rqZ8Jc1TzWnFZpN6xwtdzZPUFHJFMJH+V
         B0qVBXdZrP4X7C2goer/ecyyxSn5E8W+Pwwl2tN5b4ACVa4rebX6MQEpPRfZ6CkGZygx
         RRM7wGoWa0ZF4chowdgL4M6kObu3FRuXHWsvBrjDaPuUSj5h1EK+0KyoHLZwlPY+m2Cg
         22Yw==
X-Gm-Message-State: AOJu0Yx2DYDvTHMTF1VZezW1q1Eub4t0yj4xiHWHuCdr4dsqQIhq9+fl
	5NMN6CJwjlTs8ngWDM4MM3a++zMat6nY+Ra4mMUZNqRsJU7Q3ep+GnYNDWcnfIh1VRAj+MJlwJX
	UUjpkEPo=
X-Gm-Gg: AZuq6aJiugMSsZFkaaBHiXIOvQcklmizHYYw9TFx12j78IafZo33zGZh+5vTphlC6AQ
	jhhN03DLCR4W3c2XLPVmtmJAmBLPI4gKZsNBeQUL+3kIfNfQsrvN1t+Lsv+Y17O7fd8oJc/BPnQ
	aOPM3jI7099ByK1RXMfqbBckOg+tM306a7L9owsRuEPCUo06AY4C8B65fVtW5rUdX2FGs+Pk+cW
	gj6PBYPkudI3/UgLPr8N4SFdUnE5Wq/MaUUiXGxIMDUDiDsnE8m6foVsAZLJfwC+aoC+KG4e/rS
	lItys0RTr2E+9puNVZndJp8uWboxA0i7qUFkc4n8z5zPusRChtbcsMGy0HIDI2XlIauI/Lm5mvw
	e/u/wK/m+qzX5OpkRAc/xZR108ZKDqwJDdGPtNDd2tk4DlObBdQChp2nxW6bFSTnwLZp3Z1oxSm
	5Ioy1yHiSg9bCj4M7rKLcvXuVjy3xmYqJm2yUVdfGw+pJSjQ7hm0ZBGiRijSuZtoLHE6GWrA==
X-Received: by 2002:a05:6214:cc2:b0:892:6efb:95e3 with SMTP id 6a1803df08f44-8949018afe0mr255216d6.3.1769099322761;
        Thu, 22 Jan 2026 08:28:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ca640sm156764656d6.47.2026.01.22.08.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:28:42 -0800 (PST)
Date: Thu, 22 Jan 2026 11:28:10 -0500
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, dave.jiang@intel.com,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, dave@stgolabs.net,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	vishal.l.verma@intel.com, david@kernel.org,
	benjamin.cheatham@amd.com
Subject: Re: cxl/region.c improvements and DAX/Hotplug plumbing
Message-ID: <aXJQGlRr7WrLyiU-@gourry-fedora-PF4VCD3F>
References: <aXErSP1zKnv4koKG@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXErSP1zKnv4koKG@gourry-fedora-PF4VCD3F>

On Wed, Jan 21, 2026 at 02:38:48PM -0500, Gregory Price wrote:
> --------------------------------
> Problem: Per-region usage policy
> --------------------------------
... snip ...
> 
>   ABI:  (RW) regionN/region_driver
>         Read: Displays what region driver is assigned
>         Write: Changing an uncommitted region's underlying driver
> 
>   ABI:  regionN/rctl/*
>         Exposes region_driver specific controls / information
>         example: auto-online policy for sysram_region
>  

Referencing this thread and questions from Ira:
https://lore.kernel.org/linux-cxl/aXGHgtAHNVWJsZbo@gourry-fedora-PF4VCD3F/

the appropriate design here is likely breaking out new drivers with
their own bind functions and leaving cxl/drivers/region/bind to be the
auto-decoder / compat interface.

so this turns into:

ABI:
   cxl/drivers/dax_region/bind
   cxl/drivers/pmem_region/bind
   cxl/drivers/sysram_region/bind

   Private regions likely remain internal interaces for device drivers
   (there's no way for userland to configure a set of callbacks)

   (Note for Dan: Each probe function here can determine which
      PARTMODE's are valid for that driver - so we can prevent
      pmem from ever using non-pmem drivers)

This implies some changes to dax_region to at least not immediately
probe the dax device on creation so that policy can be programmed.

(see: dax_bus_probe() - unconditionally probes at discovery)

So laying out the current workflow:

CURRENT: region/bind auto-decoder / compat workflow
----------------------------------------------------
echo region0 > decoder0.0/create_ram_region
   => creates region0
   /* program region (decoders, targets */

echo region0 > cxl/drivers/region/bind
  => probe() creates dax_region
  => dax_region creates, configures, and registers dev_dax
  => dax_bus_probe discovers dev_dax and selects a driver
     => IORESOURCE_DAX_KMEM = dax_kmem if KMEM built in
     => otherwise device_dax
  => dev_dax probe happens automatically from bus_probe()
     => if device_dax driver, make /dev/dax/* and stop
     => if kmem driver, engage memory-hotplug.c
        => system default hotplug policy is applied

All of this basically just happens automagically
----------------------------------------------------


The new workflows for manually created/programmed regions:

Manual dax_region Workflow
------------------------------------
echo region0 > decoder0.0/create_ram_region
   => creates region0
   /* program region0 (decoders, targets) */

echo region0 > cxl/drivers/dax_region/bind
   => creates dax_region
      => selects device_dax driver
   => creates unprobed dev_dax
   /* program dax_region controls */

echo daxN.M > dax/drivers/device_dax/bind
   => probes daxN.M
   => creates /dev/dax/ file
------------------------------------

Manual sysram_region Workflow
---------------------------------------
echo region0 > decoder0.0/create_ram_region
   => creates region0
   /* program region0 (decoders, targets) */

echo region0 > cxl/drivers/sysram_region/bind
   => creates sysram_region which
      => creates dax_region
         => creates unprobed dev_dax
      => selects dev_kmem driver for dev_dax

/* program hotplug policy */
echo online_movable > sysram_region/hotplug
   => dax_region.hotplug_mode = MMOP_ONLINE_MOVABLE

echo daxN.M > dax/drivers/kmem/bind
   => probe daxN.M
   => add_memory_driver_managed(..., dax_region.hotplug_mod);
---------------------------------------


And for dynamic capacity regions, you can use these same drivers, it
just changes the default behavior of [dax,sysram]_region when probed. 

Manual dc_region workflow
---------------------------------------
echo region0 > decoder0.0/create_dc_region
   => creates region0
   /* program region0 (decoders, targets) */

echo region0 > cxl/drivers/[dax, sysram]/bind
  => creates xxx_region WITHOUT dev_dax
  /* At this point, the extent discovery process takes over */

extent set arrives:
  => dc code calls `[dax,sysram]_region.add_extents(tag, extents)`
     => dax_region    -> create new device_dax w/ set
     => sysram_region -> create new dax_kmem w/ set
---------------------------------------


cxl-cli
---------------------------------------
What this should look like to cxl-cli is something like:

  cxl create-region -t [pmem,ram,dc] --driver=[pmem,dax,sysram,] ...
  /* if not --driver ... -c --controller ? */

And since `[dax,sysram,...]_region/bind` will restrict which PARTMODE is
valid (pmem=>[pmem],  ram=>[dax, sysram], dc=>[dax, sysram, ...]),

We have a clean failure condition that lets us undo the probe process
above if the user selects a bad combination.

   cxl create-region -t pmem --driver=sysram ...  => -ENOSUPP
----------------------------------------


I think this detangles most of region.c probe/policy issues.

From here most everything else I describe can be implemented in the
relevant driver directory. (replaces region0/rctl/ in original email)

   region0/sysram_region/*                         - policy controls
   region0/sysram_region/dax_region/*              - account daxN.M's
   region0/sysram_region/dax_region/daxN.M/hotplug - atomic hotplug

~Gregory
