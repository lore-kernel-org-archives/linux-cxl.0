Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A74336ECB
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415189; cv=none; b=Rsk0JPfCyS0081WYlXFqHbHJTFcyhcVPyC3utLsrEHIdWk25PCpxZonT6TIZvEkf3ngT4yI/eOQUhdCimj7iIr+D7HwQrPJG0tDPURt9FL7rndpeef47uSH+aDouONhXR6lzp7wQK2w+8eXo1oLcd4/4+kHfzcr2KJEDCNJ554s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415189; c=relaxed/simple;
	bh=8JKnIWiSHKRzraEBPrxRkZcNRxuxDmfdvDxrPIQVs3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACG41movsHojfKNGtKmyVFKWO3GBZ/+aRQLsjRbHKjInNhVOTvMT0ImJ89W3r/SHDjl1WJcVZQ/QQ9FZ8TkIZM4SUNr3sHA0+GE9gthlTU0Gr23zurrTVPT9O5EPCs1CQDcLOgAt5jFB1Ds+DX3WtvEb8ZkBNBGFcoCVYGJR+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=i2PTWsod; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="i2PTWsod"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b29ff9d18cso10208885a.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 10:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768415187; x=1769019987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hqHt2KcHE/zmeJJbObiaCl9QyK/oJJfhNmS1tWGwenk=;
        b=i2PTWsodxR6zZ4fOyIn8i9GamIUiq1m3R1cVD6h/Rs91iQjJMRBonqle6HcimSW1iI
         y235U0qruvH2tGemMWHcjCwaWqUUAZ+lwUGLgY5i9MHnyPYdVxdPV4b+zNzkcTLaQHnX
         MqDAe6VWiHO2ouDxPv3NkTHiz9EYOYtUeAg2ha4hbOZsunAqArZPtCny6d9vt+doORKe
         3MGJyrvGKnkXsHDGJv3CbBFvMBV6Q26cl7HV0EzpEf886juqP1IWeavDjGdIkRKNVlCR
         x6sAJ7UgfaqIPfWODxe4was4Ujn8hLzhjyn6jzveZSQbhvgetBbMCzl0n6/xuvnN7aPN
         6V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768415187; x=1769019987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqHt2KcHE/zmeJJbObiaCl9QyK/oJJfhNmS1tWGwenk=;
        b=UKsHMPj6bHNWtLZTLmBlb2duukWYe8/R8l/cWV/5QOj9D5Wq6gWIbQaOicGIrDP80k
         R7vSVYxQxgnY/RslbE/YTooR8AuqLi+Wq8pzz8a3xOtRlHyEIT3IkSVj/abPyA2IQcSF
         Rf3XDYKwCxwBNDJ50ZDdspkH5lNFQZ+DbX2Y7U8wFOYw63ZOtO7SltZ89EHwuJ3vLBnv
         VCaCNj4qbfpKs3q50HqlG4EWOiEIOQVY9JbwS373Zf+QWVSo/TD7gpzz7Uka34nE2jva
         to13cN6xMboemYUNhSavJbhOE4uiqmDKffIDA6nuyJ7aBK98JEZQlbLoT2hk9UAKUNtq
         yi/Q==
X-Gm-Message-State: AOJu0YyBQfBGAHO5vcRAmZ+7gp5vvkvEh4zTL2hae/1NYJvhnh9MqWFO
	GsPqvf/ZzZJv/w9+A7qRa0rY+laD4PV0CcmLRt9c0zZGU1i+rUUsuORpqJgdknZemJo=
X-Gm-Gg: AY/fxX7P2D3quayhuc0/LMH1R2IeLbHNZpp5jUaO8LFWe3FodwMVm3vfT2KuDXNhD7g
	1HGtat9gqoo2/vtwyzs2jV4jzPb4frJhAOcxRuwXpYOlyA9Uezyim7VaUORZyg305FHDXn5qK2c
	0DkRwJQRhbfXPNkKJlC665ZHJhcHyHc2cduLqOlKlIxsOas2FPiiSlE4yXOk5KSyPqrD7aoJZd+
	MoIlreWV8iXUFzovp9321NFBQFNz+ScCgELgKauL782q8HHIOPgp31HZS938mu7AiLroqIngRwX
	4JPkHDzkbNr0P5QvRo8KNtt2IGusV7bbkD1ie0FiiI1nxkgJ8eniwuTt0uA9MEOlDJ7oDQFGqoo
	Gm7vyjttZ+fwYRy7YzJ75gY6sG5hoUP94KyLBn3jdxwY7M5AnkR2QqQu5vcW60a6ZBM+gM5H4Vy
	d0UmhUTiA2y/Ka5Q48+4NKg+lQg/BHMFb86zThP8pln7vATq9JmLrVJrtCpdEA2zukSZ0p0Q==
X-Received: by 2002:a05:620a:45a6:b0:8b3:e4c:1bd3 with SMTP id af79cd13be357-8c53148d95fmr413670685a.12.1768415186611;
        Wed, 14 Jan 2026 10:26:26 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530be5446sm204964985a.54.2026.01.14.10.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:26:26 -0800 (PST)
Date: Wed, 14 Jan 2026 13:25:53 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and region->memctrl
Message-ID: <aWffsUbIx2DUefSS@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-2-gourry@gourry.net>
 <20260114171808.000067e2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114171808.000067e2@huawei.com>

On Wed, Jan 14, 2026 at 05:18:08PM +0000, Jonathan Cameron wrote:
> On Mon, 12 Jan 2026 11:35:09 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > The CXL driver presently hands policy management over to DAX subsystem
> > for sysram regions, which makes building policy around the entire region
> > clunky and at time difficult (e.g. multiple actions to offline and
> > hot-unplug memory reliably).
> > 
> > To support multiple backend controllers for memory regions (for example
> > dax vs direct hotplug), implement a memctrl field in cxl_region allows
> > switching uncomitted regions between different "memory controllers".
> > 
> > CXL_CONTROL_NONE: No selected controller, probe will fail.
> > CXL_CONTROL_AUTO: If memory is already online as SysRAM, no controller
> >                   otherwise register a dax_region
> > CXL_CONTROL_DAX : register a dax_region
> > 
> > Auto regions will either be static sysram (BIOS-onlined) and has no
> > region controller associated with it - or if the SP bit was set a
> > DAX device will be created.
> > 
> > Rather than default all regions to the auto-controller, only default
> > auto-regions to the auto controller.
> > 
> > Non-auto regions will be defaulted to CXL_CONTROL_NONE, which will cause
> > a failure to probe unless a controller is selected.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> Trivial comments whilst I try to get my head around the series.
> 
> ...
>

Recommend piviting to v2 which simplifies and addresses some of your
notes here already:

https://lore.kernel.org/linux-cxl/aWfe-r7uEV-ajfhX@gourry-fedora-PF4VCD3F/T/#m791301178876f9b1ab55ed4091c674d4f4ceb07c

Still need to add some docs.

~Gregory
