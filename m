Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63352204F7A
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jan 2025 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461520; cv=none; b=cFEGgtARDFe8B68ucaIQnU94mGjzg5zybTOIdKtFdjFKWKmLUpxI/+naffsxeAZkgevD5n7nB9vRQJH8w51yi8v4Y1U/aEoG7GLaaaG7e5J4R+fXgrH5Nr0nNsebTgA36KTi/iuWB2EvclEyd0tlXizM3mk8efEHHjt6vkiarHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461520; c=relaxed/simple;
	bh=XURsEI5RKboGmhnBu9Rd4Q9kxrNZjD3U4/DUGAPuOjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKEvoN/XtAJ6CuKZMbphzNZG8LoRSlquPfp8QkngZkTt9rs9QPhXFfD+aBZmlPSMDffUIv8Y9YR75tHKRDikVx3Jgn7VH40j/jDKSxWSjDo2Clp+r7AGX9YoDSz9IhJUg9jF0TppfNYEP2IGb5fa668g7HcyoBuuHuReV+AEe4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Cs8qJhO9; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Cs8qJhO9"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46783d44db0so12811271cf.1
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jan 2025 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736461517; x=1737066317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq9G9ETbBir89jV8qIj9358O07LvRmxRK93Af9slxLY=;
        b=Cs8qJhO98pmZ9fuHsrJURKOjaIkv7vmccUU6DX6+glR9D1H5PPQTNax8AVfsSc8Oem
         7tgpVpmyttZ9ZOU5L0XjXeD3ApdbozkqhbGeVVIeT7VHFk391qey6bDQrV93JhZpLrxR
         YfgBgucAKtu9VOYrPCBO3Xly+fCa1r+uC9n7aTbehZth3mSNptR1a+j5s2wgedg3bSin
         dwazNv3bZi6i9tnB3G33agUgeB4DuJWgS5Yyy5Nv1Vegp6S+OqkuGuGVuv5N6Xdv/5Of
         /w7Yv6VDYPK3IrALzITKAP7dV88lHxMg2/trxonOUC4LKW4l6OhrFjtnaixjUX1Guv22
         EywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736461517; x=1737066317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq9G9ETbBir89jV8qIj9358O07LvRmxRK93Af9slxLY=;
        b=CguzIZcdlsg9jLepLoq11tayK0kzRTBv7yLBETQqoG4gJD7OtSToSQZ6sCr/h/TDM9
         TtjVglD1ZjCt0LzasnVjIzaV2gfMWhs/P+tsUzClxymn3nqAVB5bMa9cNcxC2Qs0FUV8
         2K+xbTP758d/AxXjn9GCDqPHIuxIrPoUwvNL8WnODzOHetTmxQd/86a71Q9U3EzZxzqp
         66aFCVlvNzxZ1Im3B2BubyWZt1DNKNUKGPKPavW61UmMgLRtbCSdYFvWJrV9OSmOwdB/
         LNvDgOMqBcPTRAMG8h1iZk5IqExM5E1VsFxhRFPAbT/PpEVe4H59PkmqObwA7oEqgSCf
         jLxw==
X-Forwarded-Encrypted: i=1; AJvYcCXKbdlv67yvTOegpqn7e451d1DnRXQ7lXDbYlP4UHXVg1Jg/by930w4jQmwex4vjiSrHlxyptcKIPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Gv8LbdtMcwicOsJczjW5W0e0PdHHGHfi1aKsDPqX/0uaDqzG
	0zxWvEk0weRiqInQ8gnToLnKgGss8K07WWT0Gc6QNm011uFj4oGK0yCORa2hqOk=
X-Gm-Gg: ASbGnct9c5z7eC6t5RmWPlwh8DYuDzdbjB3NWv6nRPyCXlVtFwEgH9U8a73FaHJqzC2
	7x2te1rx0o+6F7ShJtxFpA+zh4n5gMPHf2w2pLw4vLS6ftGPfl+pwWf49vJ2MepMBCz1dyJyuPO
	J0ngkKEvl00EXXtcPjRhxZ/Itt1aP4o5IAWVBRca6i4kDZeB+2MvfInq+tgVafVhHnOuT32QxEI
	tpjGDQ3RT5WRg2amcaOGx5pa5h4LTZn6+9lK4bz4RvhrudkniI57xMIGbGEJMZOp9V6VP5qa8Ph
	KyiJnVLJzM4rfG2iQiQDl7h40FalmoNK7QSK9yA=
X-Google-Smtp-Source: AGHT+IHl0ZxPZVWv1wOo/lm312/DgZYNNsCEklJfFLn/rdYWKFOzRUw8O0dJCwifNsG244KVCOqIGg==
X-Received: by 2002:ac8:5f90:0:b0:467:681a:69f4 with SMTP id d75a77b69052e-46c71083e51mr149571491cf.39.1736461517172;
        Thu, 09 Jan 2025 14:25:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c87321a6csm2977471cf.4.2025.01.09.14.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 14:25:16 -0800 (PST)
Date: Thu, 9 Jan 2025 17:25:13 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z4BMyVsz7bLZAFEy@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-26-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:11PM +0100, Robert Richter wrote:
> Add AMD platform specific Zen5 support for address translation.

Doing some testing here and I'm seeing some odd results, also noticing
some naming inconsistencies

> 
> +static u64 cxl_zen5_to_hpa(struct cxl_decoder *cxld, u64 hpa)
> +{

Function name is _to_hpa, but hpa is an argument?

Should be dpa as argument? Confusing to convert an hpa to an hpa.

... snip ...

> +#define DPA_MAGIC	0xd20000
> +	base = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC);
> +	spa  = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K);
> +	spa2 = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K - SZ_256);

For two devices interleaved, the base should be the same, correct?

example: 2 128GB devices interleaved/normalized:

dev0: base(0xc051a40000) spa(0xc051a48000) spa2(0xc051a47e00)
dev1: base(0xc051a40100) spa(0xc051a48100) spa2(0xc051a47f00)

I believe these numbers are correct.

(Note: Using PRMT emulation because I don't have a BIOS with this blob,
 but this is the same emulation i have been using for about 4 months now
 with operational hardware, so unless the translation contract changed
 and this code expects something different, it should be correct).

... snip ...
> +	len = spa - base;
> +	len2 = spa2 - base;
> +
> +	/* offset = pos * granularity */
> +	if (len == SZ_16K && len2 == SZ_16K - SZ_256) {
> +		ways = 1;
> +		offset = 0;
> +		granularity = 0;
> +		pos = 0;
> +	} else {
> +		ways = len / SZ_16K;
> +		offset = spa & (SZ_16K - 1);
> +		granularity = (len - len2 - SZ_256) / (ways - 1);
> +		pos = offset / granularity;
> +	}

the interleave ways and such calculate out correctly

dev0: ways(0x2) offset(0x0)   granularity(0x100) pos(0x0)
dev1: ways(0x2) offset(0x100) granularity(0x100) pos(0x1)

> +
> +	base = base - DPA_MAGIC * ways - pos * granularity;
> +	spa = base + hpa;

DPA(0)
dev0: base(0xc050000000) spa(0xc050000000)
dev1: base(0xc050000000) spa(0xc050000000)

DPA(0x1fffffffff)
dev0: base(0xc050000000) spa(0xe04fffffff)
dev1: base(0xc050000000) spa(0xe04fffffff)

The bases seems correct, the SPAs looks suspect.

dev1 should have a very different SPA shouldn't it?

> +
> +	/*
> +	 * Check SPA using a PRM call for the closest DPA calculated
> +	 * for the HPA. If the HPA matches a different interleaving
> +	 * position other than the decoder's, determine its offset to
> +	 * adjust the SPA.
> +	 */
> +
> +	dpa = (hpa & ~(granularity * ways - 1)) / ways
> +		+ (hpa & (granularity - 1));

I do not understand this chunk here, we seem to just be chopping the HPA
in half to acquire the DPA.  But the value passed in is already a DPA.

dpa = (0x1fffffffff & ~(256 * 2 - 1)) / 2 + (0x1fffffffff & (256 - 1))
    =  0xfffffffff

I don't understand why the DPA address is suddenly half (64GB boundary).

> +	offset = hpa & (granularity * ways - 1) & ~(granularity - 1);
> +	offset -= pos * granularity;
> +	spa2 = prm_cxl_dpa_spa(pci_dev, dpa) + offset;
> +
> +	dev_dbg(&cxld->dev,
> +		"address mapping found for %s (dpa -> hpa -> spa): %#llx -> %#llx -> %#llx base: %#llx ways: %d pos: %d granularity: %llu\n",
> +		pci_name(pci_dev), dpa, hpa, spa, base, ways, pos, granularity);
> +

This results in a translation that appears to be wrong:

dev0:
cxl decoder5.0: address mapping found for 0000:e1:00.0
    (dpa -> hpa -> spa): 0x0 -> 0x0 -> 0xc050000000
    base: 0xc050000000 ways: 2 pos: 0 granularity: 256
cxl decoder5.0: address mapping found for 0000:e1:00.0
    (dpa -> hpa -> spa): 0xfffffffff -> 0x1fffffffff -> 0xe04fffffff
    base: 0xc050000000 ways: 2 pos: 0 granularity: 256

dev1:
cxl decoder6.0: address mapping found for 0000:c1:00.0
	(dpa -> hpa -> spa): 0x0 -> 0x0 -> 0xc050000000 
	base: 0xc050000000 ways: 2 pos: 1 granularity: 256
cxl decoder6.0: address mapping found for 0000:c1:00.0
	(dpa -> hpa -> spa): 0xfffffffff -> 0x1fffffffff -> 0xe04fffffff
	base: 0xc050000000 ways: 2 pos: 1 granularity: 256

These do not look correct.

Is my understanding of the PRMT translation incorrect?
I expect the following: (assuming one contiguous CFMW)

dev0 (dpa -> hpa -> spa): 0x0          -> 0x0          -> 0xc050000000
dev1 (dpa -> hpa -> spa): 0x0          -> 0x100        -> 0xc050000100
dev0 (dpa -> hpa -> spa): 0x1fffffffff -> 0x3ffffffeff -> 0x1004ffffeff
dev1 (dpa -> hpa -> spa): 0x1fffffffff -> 0x3fffffffff -> 0x1004fffffff

Extra data: here are the programmed endpoint decoder values

[endpoint5/decoder5.0]# cat start size dpa_size interleave_ways interleave_granularity 
0x0
0x2000000000
0x0000002000000000
1
256

[endpoint6/decoder6.0]# cat start size dpa_size interleave_ways interleave_granularity 
0x0
0x2000000000
0x0000002000000000
1
256


Anyway, yeah I'm a bit confused how this is all supposed to actually
work given that both devices translate to the same addresses.

In theory this *should* work since the root decoder covers the whole
space - as this has been working for me previously with some hacked up
PRMT emulation code.

[decoder0.0]# cat start size interleave_ways interleave_granularity
0xc050000000
0x4000000000
2
256

[decoder1.0]# cat start size interleave_ways interleave_granularity
0xc050000000
0x4000000000
1
256

[decoder3.0]# cat start size interleave_ways interleave_granularity 
0xc050000000
0x4000000000
1
256

[decoder5.0]# cat start size interleave_ways interleave_granularity
0x0
0x2000000000
1
256

[decoder6.0]# cat start size interleave_ways interleave_granularity 
0x0
0x2000000000
1
256

~Gregory
