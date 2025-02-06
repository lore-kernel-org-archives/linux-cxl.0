Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB801A5B86
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857582; cv=none; b=uTYRlCuz1RziJjwUU0wnWZr7K3QjMhY1BG3A9sJBCwFyKsd6PKppYxeFTSITiwLINww/sq22WSoluFaXHQmPcW1bbKU5iXBvnFX6Cc0HjZvk7q1H6wsgqo2b/ICbG9cmlT19SWR7ZonSuonbjhYBl4t+zrUjHrtIhc53HmacVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857582; c=relaxed/simple;
	bh=wfWG1lBorKdXeSnfHeDzLFkNJVBsnc4Vd66lUdn9zGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNYpiDqq9KZ1v6F2/5x8KzObol20k7dg0OFhq5eUt4C2D0sHwrDXNcW10nWB2D/XDP3cQF/BwQYyEq0i8EYL2mnYJUNhF111elAqIjGaOUi24xUYMcb3S8gvyEo5fzKu4r2OqFIieniNkPheT7xNFknp1URse+KfiAI7lVscYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Jam60QJw; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Jam60QJw"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7bcf33f698dso93429685a.2
        for <linux-cxl@vger.kernel.org>; Thu, 06 Feb 2025 07:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738857579; x=1739462379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rgX3enkDd37pO8Eu6+jW5LrbU18LPSV6Ey4Xi/pbpE=;
        b=Jam60QJwtO8nYmi8PXsRfGX7Yl35tjWmgQ0Ui3Q1FNoRg3sCgKA31Xs13UoeI7CIBa
         bglsgdc3S/QuQbWJde15hqWsAX9NDhmAv0kXkkJ43Ghg5URzJjyI3JZvjfowBA1ZIhND
         3MOsLLCFHMDBYbwBuUhJmca1qSe+eE3Pjyz6A3SEYgFQEy1F56dzGPw3Kck932jbqSyB
         8OsQMAYcbNxIxjZyU1MR3HuU8olV7wwhwqm56GkBV+ZMEuBbmdT3CRU72Ptc/y/nKT0a
         +evArztY6vvkh8HdCItkFFbvkpuM4ulTvqRJS3voxK7AbqnvNxbKx1Zwb8OVzI1caYXn
         0HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738857579; x=1739462379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rgX3enkDd37pO8Eu6+jW5LrbU18LPSV6Ey4Xi/pbpE=;
        b=w4eGN3XcRoROEWGXVlPkoO3ZFmf5b/tTbJJ0le4JK26BeZfTvxyIMDxUmlmFLYRyhQ
         WDrDE/4ampJU4JgbcOHNyxPyARH9yQJnXWu9mWVvcCvhI1QHX4KzgoWCvxxrUMQl7a3W
         thRqmcX1HFmXSOTjCWGcma4ziCI9vT6ptGVDsZ6d0dD7LRLSvf+PzSK2mVByg8pzbKcc
         JzlKmCvK0P7wfXKUYkYXHiZj/iBHF1cdLkwUyObn1bLT3H5QR+h+p2hL2d1hcr/08TGM
         8Xat16dhArJd5hE+knRhTyC4ooCRQAtPfnc/x8wr8WkduZSVgEOkTONOZg7qs1ZBKkDu
         YWzA==
X-Forwarded-Encrypted: i=1; AJvYcCVPym+x2gCw9HmlAuFgYjUbdB1cZk9OjqiQgAkHy757JkbMB1/7MuLCtZyrusMET7fZAzgNotD6t0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ygOfGFkhOfuN4w3weNZVVpz5lBcrqXS8/vJMBHQWGzXOoSdo
	W9D2XGE2m7fykYOUAnUBTm/XvYnNRZSzaIeOIc81pN9TMGhSprROmA5daCT7DSImEn5ggGtYcoQ
	i
X-Gm-Gg: ASbGnctI5++xOG04W+yYG1b0I5wlR2Qs3NC6hOD4dKseajmUJ8s43OJ8Hq+Zz+m+wVB
	fW1EsmodJWlh5APMe0CuelIIJXFZ8WiEJub8nPU0ubzaPH1yvRSvhr6uDtKmadkzLe8J9kUSM7T
	/7CVpGCeVmIqRoHC3oiQjFy9Mdk5KZthezdMTC+HBO7yRCbnejymrbQvpVat0IlzOoUBwoiQ7BX
	m1Ts3/PTFFWOnZ1yFcqwmy8xfsjpZAqlzUdbWPjpknKiEVf5Orph+P6jY5Sdbnt5XNfrEtA5rJq
	FjmVcvl/QQLk03aynCiFYOCIvt9cxSv1Jug4VgtSvnrSuyppakRcw6wwk//FyHbyfW+jvPdFTg=
	=
X-Google-Smtp-Source: AGHT+IGVD8lviSGrZUHhDUeXaeng33mAdOdehqoxqNfFEFyKhbcfoqIeOcq35NP8wXT2MTIiiQ0kcA==
X-Received: by 2002:a05:620a:40d4:b0:7b1:492c:ba83 with SMTP id af79cd13be357-7c039f95dfemr1002655885a.10.1738857579502;
        Thu, 06 Feb 2025 07:59:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ded12asm75286685a.5.2025.02.06.07.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 07:59:39 -0800 (PST)
Date: Thu, 6 Feb 2025 10:59:37 -0500
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 2: The Drivers
Message-ID: <Z6TcaaScBWzZvLWW@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
 <67a4069572eab_2d2c294d4@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a4069572eab_2d2c294d4@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Feb 05, 2025 at 04:47:17PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > [/sys/bus/cxl/devices]# ls
> > dax_region0  decoder0.0  decoder1.0  decoder2.0 .....
> > dax_region1  decoder0.1  decoder1.1  decoder3.0 .....
> > 
> > ^^^ These dax regions require `CONFIG_DEV_DAX_CXL` enabled to fully
> > surface as dax devices, which can then be converted to system ram.
> 
> At least for this problem the plan is to fall back to
> CONFIG_DEV_DAX_HMEM [1] which skips all of the RAS and device
> enumeration benefits and just shunts EFI_MEMORY_SP over to device_dax.
> 

Hm, would this actually happen in the scenario where CONFIG_DEV_DAX_CXL
is not enabled but everything else is?  The region0 still gets created
and associated with the resource, but the dax_region0 never gets
created.

On one system I have I see the following:

c050000000-fcefffffff : Soft Reserved
  c050000000-fcefffffff : CXL Window 0
    c050000000-fcefffffff : region0
      c050000000-fcefffffff : dax0.0
        c050000000-fcefffffff : System RAM (kmem)
fcf0000000-ffffffffff : Reserved
10000000000-1035fffffff : Soft Reserved
  10000000000-1035fffffff : CXL Window 1
    10000000000-1035fffffff : region1
      10000000000-1035fffffff : dax1.0
        10000000000-1035fffffff : System RAM (kmem)

I would expect the above HMEM/shunt to only work if everything down
through CXL Window 0 is torn down.

But if CONFIG_DEV_DAX_CXL is not enabled, everything "succeeds", it just
doesn't "Do what you want"(TM) - dax0.0 and RAM entries are absent.

It makes me wonder whether the driver over-componentized the build.

> I am otherwise open to suggestions about a better model for how to
> handle a type of memory capacity that elicits diverging opinions on
> whether it should be treated as System RAM, dedicated application
> memory, or some kind of cold-memory swap target.
> 

My gut tells me there's no "elegant solution" here given that user
intent is fairly unknowable - i.e. best we can do is make the build
and boot options easier to understand.

> > ---------------------------------------------------------------
> > Step 6: DAX surfacing Memory Blocks - First bit of User Policy.
> > ---------------------------------------------------------------
> > 
> > The last step in surfacing memory to allocators is to convert a dax
> > device into memory blocks. On most default kernel builds, dax devices
> > are not automatically converted to SystemRAM.
> 
> I thought most distributions are shipping with
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE, or the default online udev rule?
> For example Fedora is CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y and RHEL is
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n, but with the udev hotplug rule.
> 

Good point, my bias take showing up in the notes here.  I didn't know
RHEL had gotten as far as a udev rule already. I'll adjust my notes.

But this also hides some nuance as well - the default behavior onlines
memory into ZONE_NORMAL with DEFAULT_ONLINE (next section).  

> > Alternatively, this can be done at Build or Boot time using
> >   CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE   (v6.13 or below)
> >   CONFIG_MHP_DEFAULT_ONLINE_TYPE_*       (v6.14 or above)
> >   memhp_default_state=*                  (boot param predating cxl)
> 
> Oh, TIL the new CONFIG_MHP_DEFAULT_ONLINE_TYPE_* option.
> 

It was only just added:
https://lore.kernel.org/linux-mm/20241226182918.648799-1-gourry@gourry.net/

Basically creates parity between memhp_default_state and build options.

> > The base is 256MB aligned (the minimum for the CXL Spec), and the
> > window size is 512MB.  This results in a loss of almost a full memory
> > block worth of memory (~1280MB on the front, and ~512MB on the back).
> > 
> > This is a loss of ~0.7% of capacity (1.5GB) for that region (121.25GB).
> 
> This feels like an example, of "hey platform vendors, I understand
> that spec grants you the freedom to misalign, please refrain from taking
> advantage of that freedom".
> 

Only x86 appears to actually do this (presently) - so is this a real
constraint or just a quirk of how the x86 arch code has chosen to
"optimize memory block size"?

Granted I'm a platform consumer, not a vendor - but I wouldn't even know
where to look to see where this constraint is defined (if it is).

All I'd know is "CXL Says I can align to 256MB, and minimum memory block
size on linux is 256MB so allons y!"

On the linux side - these platforms are now out there, in the wild.
So the surface impression now appears to be that linux just throws
away ~0.5% of your CXL capacity for no reason on these platforms.

That said, I also understand that more memory blocks might affect
allocation performance when the system is pressured - but losing
gigabytes of memory can also reduce performance.
(Preview of one of my next nuance additions in section 3)

If this (advisement) change is unwelcome, then we should be spewing
a really loud warning somewhere so vendors get signal for consumers.

~Gregory
