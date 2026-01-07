Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70837BE83
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801304; cv=none; b=OdOFu/tlgIArItYlfYpGFWZYx4NwJg2dDI5fd1RHRcws2OfKPO3GI0IIlxzCSa9i3/WbY1P4xmS4LhroPorkc2o+cgKFUOiQJ9Ilv/vLLQaIymxsjh4Ywg8wvaZ1sy4l3a3PRtIWwKfIS9Nz3WwMO6Z2dSRhwBS7kXaLtqyRgt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801304; c=relaxed/simple;
	bh=WYEOL0RkopAT8vHLW3yYNxpW83vvZLkZz4GxJKbBsdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl/I4LOYd+WrUKDblnTqXnRlB3+FZut7u4/yYmtIBxc8T30m3UVBd95OXT9UzwqR81UY/py9JmEObVh9YbB1nbzUB95cZiRo/5z8Apn1VAIb82CYjQ2bEPNKb6qymY3Du2v4/uzN23S+XUyeinQrLkT77m2sLSEDUMAHsxZNpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CGkNNUDf; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CGkNNUDf"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4ee05b2b1beso20474921cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 07:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767801290; x=1768406090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bjq1wNZqnohOPk2/673/mr1eb1p695Mtldzjo3XTb1k=;
        b=CGkNNUDfU/ZNikeTnRqvMDFI28NLbTTGOmOJXKmkT4LBnJTC5p9aKuRXXbrcTp+goS
         2YkBE0CQcCml9p8mZu40DnekRcF0KSiWP9B8zNVmAVzNp9EVBtrh8FDwXsvk6cxXCNnt
         W+4JboD8Hhpxi+9ycaVI74CimzQfOlJ7m5XiKMDBe3sYBRMbMeQNjzbt9SfB/pC2t1rV
         E4NtxmJUDRna8hovQ3aMFjWPo7kYuRn9j5iZreQUgw2CxLMGweAX7rmLOtY823PkBEk5
         4n0nbYCFGPzEV5SU1YnKEqhGGNVRFeHiSQX5rW3aJt2Nqt4IKEmS3lTJCwKlpA4djNh7
         07YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767801290; x=1768406090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bjq1wNZqnohOPk2/673/mr1eb1p695Mtldzjo3XTb1k=;
        b=aBOJPzQhyB7eYAfVy0YkLdYvUt21C7i4WnQfR07c+MuBJv64XgCAYpPWXip8DtZ/Vj
         hzv5AvQzzRIO+cffSEzIvCMhmY+35CY4sGjy2lRYK9SDvZkBsuzRZs0WFxgp35IG1bpo
         BV0M0NxxGEPgFpcIdtB/nWX6A92FKJKJgu/aDlZolWBJys8zC8zoyoGJ2+vU+j64a+rC
         fmzMUacQm6ocqb9n25Gc/9aOUXiBmmkpDUYcrU9V8Wjh9lGyO9IP2LuaO8651JYgvb0O
         NexTJiodxu3HJLJDXq6/3BkJzYrgf8Eof8Dv2mh/JC39YirszdTtC6MwJAueBKMDBTvA
         LxEg==
X-Gm-Message-State: AOJu0YwZzukDFXcM2pK9Re5zjNp8Js4sHQxYa7/P4TW9lXsDCrCUAtj7
	NuPJCohwJeDQBICsFP1QRRljhEDDQ0hTVYUCya1HXQJJR9rJ4eYlHMjvTgMHMxqlbS8=
X-Gm-Gg: AY/fxX7IiJfQlf1N3UauGScthwX+2+NCwaTxkGeVubCAfns3ZdSY7lhixxt1nqxAzbO
	KubfGSuDPQ5A76wojV8+eUHu/XsGDSqP85SMBrxYd4rgMKQW+IeIyhFPxvMpSv+wqUuQmOg7QHn
	wr2c3T+eWHBR/MVWZ5uAGO12XbYQvQwvpVguGhQIP3GS2vGG00fTehpFnPrRPt1FoBtNd8Nrccs
	D/Ljm4kDrvQZKmQtMOMj5TKdv7OXY74fhEto/h/4VKZb2H9q+zlQENPBQlXbyx3OxMcL2WutK9Z
	+FaJICgtg0rkCgVGaim1t/8CVx5/Ul7RX+UY7jejUpEp53MaqvlI7uehecMLriX/4buQr3KmWhO
	Vk/nk8KiKup+LRD4BxKwS91URV+3Fmv/5n8YJkn1iM/HUofU3i8AEGoR/njXT8BrlNjgT+inF1J
	YwzTCLWwDKEhfmGF8gI7tZ7zNJuTHSTG2HQVArXfDz6uqxoFoJuAsx+fKvOlgyaImgS7ExAA==
X-Google-Smtp-Source: AGHT+IFpHX6/YFKVjY16kkps3B6rjOjHNzpeXC9ORk5Bf21BUdwNhxYNCkRmY3HRfO/4NIPq5km3Ag==
X-Received: by 2002:a05:622a:4086:b0:4ed:e337:2e52 with SMTP id d75a77b69052e-4ffb4980436mr38934021cf.30.1767801290097;
        Wed, 07 Jan 2026 07:54:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa926a9d9sm31623201cf.25.2026.01.07.07.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:54:49 -0800 (PST)
Date: Wed, 7 Jan 2026 10:54:16 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, corbet@lwn.net, rakuram.e96@gmail.com,
	alucerop@amd.com
Subject: Re: [PATCH v3 2/2] Documentation/driver-api/cxl: device hotplug
 section
Message-ID: <aV6BqOarpY0PUt7h@gourry-fedora-PF4VCD3F>
References: <20251219170538.1675743-1-gourry@gourry.net>
 <20251219170538.1675743-3-gourry@gourry.net>
 <aV3CsPl8Zsp5JtGu@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV3CsPl8Zsp5JtGu@aschofie-mobl2.lan>

On Tue, Jan 06, 2026 at 06:19:28PM -0800, Alison Schofield wrote:
> On Fri, Dec 19, 2025 at 12:05:38PM -0500, Gregory Price wrote:
> > Describe cxl memory device hotplug implications, in particular how the
> > platform CEDT CFMWS must be described to support successful hot-add of
> > memory devices.
> 
> Who is the intended audience for this doc?
> 
> Maybe it's already in another section not being edited, but I'd
> expect to see CXL spec references.
>

The audience for this particular doc is platform folks who want to know
what limitations there are on cxl-device hotplug in linux.

This originated from a discussion at LPC where some device folks
understood the hotplug process, but did not understand the linux
limitations (in particular around the CFMWS and node creation).

Tl;dr: Linux consumes ACPI tables to generate NUMA nodes and constructs
memory regions.  This is linux "having an opinion" on "how ACPI tables
should reasonably be constructed" - and this tries to document that.

This is all obviously mutable, but it at least helps drive understanding
between device, bios, platform, and linux if we at least have this
document that says "this is what Linux wants/expects".

I'm not sure what if anything I would reference in the spec, since this
largely describes what linux wants, not what the spec says is possible.

Happy to improve.

> > +Memory Device Hot-Add
> > +=====================
> > +A device present at boot may be associated with a CXL Fixed Memory Window
> > +reported in :doc:`CEDT<acpi/cedt>`.  That CFMWS may match the size of the
> > +device, but the construction of the CEDT CFMWS is platform-defined.
> > +
> > +Hot-adding a memory device requires this pre-defined, **static** CFMWS to
> > +have sufficient HPA space to describe that device.
> > +
> 
> Isn't it more like the usable capacity of the hot added device will be 
> limited to the HPA space described in the CFMWS?
> 
> a bit similar comment below -
> 
> 

This is more precise and concise.  I can change that.

> > +Single-Endpoint Memory Device Present at Boot
> > +---------------------------------------------
> > +A device present at boot likely had its capacity reported in the
> > +:doc:`CEDT<acpi/cedt>`.  If a device is removed and a new device hotplugged,
> > +the capacity of the new device will be limited to the original CFMWS capacity.
> > +
> > +Adding capacity larger than the original device will cause memory region
> > +creation to fail if the region size is greater than the CFMWS size.
> 
> While it’s true that the CFMWS bounds the maximum HPA space available,
> hotplugging a device with larger physical capacity doesn’t necessarily
> cause region creation to fail outright. It only fails if the requested
> region size exceeds the CFMWS size. Users can still create smaller
> regions that fit within the existing CFMWS window, even if the device
> itself has additional unused capacity

This does say: "if the region size is greater than the CFMWS size"

But maybe it's more accurate to say "if the unused CFMWS HPA space is
smaller than a user-defined memory region capacity".

This is really all saying the same thing though - if your device
capacity is smaller than your CFMWS, you can't map the entire device.

> 
> > +
> > +The CFMWS is **static** and cannot be adjusted.  Platforms which may expect
> > +different sized devices to be hotplugged must allocate sufficient CFMWS space
> > +**at boot time** to cover all future expected devices.
> 
> Yes. Above is crisp. Might be crisper by suggesting that the 'sufficient'
> CFMWS space could be achieved with one monster CFMWS or multiple CFMWS of
> all their imaginable capacities.
> 
> Like my first comment, I'm not clear on why we are dipping our toe in
> here, when understanding requires CXL spec, platform provider, and more
> guidance. Are we describing anything Linux specific here.
> 

Linux specific piece here is the fact that once Linux proceeds past
__init, you cannot achieve hotplug for CXL memory not described (or
insufficiently described) in the ACPI tables.

In this case - memory is special.  We're (linux) basically telling
platform vendors "You can't add memory you haven't described in some way
since the beginning of time".

It's unclear that the same would be true on all operating systems, but
it is true on linux.

---

general note - i'm happy to drop this if folks think it's not the right
place to put it, but based on LPC discussions and feedback from Jonathan
and Dan, it seemed useful.

Maybe I should just be writing a book instead, lol. (Please no)

~Gregory
