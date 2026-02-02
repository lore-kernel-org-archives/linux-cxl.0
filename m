Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF63803D0
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051061; cv=none; b=YA2k/LDE38cWQW7FQ5r7ZBlPpfYx24Bx2nDLuOfOVJC2qO8Rk9rquHShn7q6n3fDkCRVKm0v5rYwSML8UOFCmNHS5Ol/vcF3ovFHZTIdIKa9AP3njt6ZxnXqEw/PnpBB41pD1aYIG2XBBiV4Y2knD7c8gX+uuDOpV0lpEszTSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051061; c=relaxed/simple;
	bh=/3UrVd5Wd0fid6CiyjlUMe5joojxqOpiFLWnG5tBrq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldNfos61ds2dGUZRcKfWuS4JhZ5pQIEXj0SgTLPqri42M4afdpTkcjvJUK9KohR1TFEq6CO1CFSeCOjARPv0jgscFPrcULW7gsXrnrghVUkXLR43tX/AMmQrEm13yulkdYpwl4Z4WvRiQxb8/N/3ducl6kyHqd8JJRceVLkLvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ByGUUKAl; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ByGUUKAl"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-501488a12cbso57320101cf.3
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 08:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770051058; x=1770655858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHAB+t3AcqkDODFoQ5Ne2kPKoBff+Krqt2HfCqWK4lk=;
        b=ByGUUKAl0XNul9uqyUsEnGFPcwlvAJdfdR9lwALsQsUh3W2N+A9aRodXS6icfk21SY
         NwczpcagTZqTLcBlEL49rf0ORpYHizq9xakouarsdNeOxKiShXZl3+xuWpl2aJ420G82
         4PNaOk4ifjXMGhbD6Wsu4NQV32tuN3fO2MUwJMZPI6gD52a4kbW1Ns2n7Gl4UhW2rcYC
         IKiMlnmbUPLka6oYzT81XoHA3BFy3DVGJLsmzfeK0c2D8Gib1LbVXFcTpchakmNCNf38
         8Su+T2btU9rdvtEtvZQZKXOuj/inTP35xUXt8rHEvrPuzO4DZ5C0D5MVx2TjvgPQbl8e
         j+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770051058; x=1770655858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHAB+t3AcqkDODFoQ5Ne2kPKoBff+Krqt2HfCqWK4lk=;
        b=aGdZ4EnCIKb8Xq3+6PKyY6THDtyTBm67iNOjNbzVYzwGKv45AtwSRTc7NZpcYQFjg1
         HFNuyF+vEhiZgAaUBL8UlisZBFsutGm04OE++BBCx7l1dOz26b45QOEGHk2t+/AQEyxV
         H3nYKM5rJq8NHvC609UJciXa/KqYHg9oVjgs5o5ahm1oPY9EMUo7zY8+GhbwiDNJ4oLy
         4Wzg0l5Yr4/rKXq8y0MUjBw+5NXYtKAJWbZYYIqvY01yMpxuDdo7jsNGuODZZAiV1irO
         YbruRUusE+m/vRE9Oz7MJVuEK5JPDyA6GfVPFTJN4GAMdFgDnDyb4whrSBBB1fFgSLl5
         CtTA==
X-Forwarded-Encrypted: i=1; AJvYcCX6AerRi6PvaqpVfRr2qu1iXVVs/o6k9betjkPPw0DkK6tEnPx1ePBrn6lJO9WCMDcvsWpCTkOHgX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiVCObI8PZoDAdHQkPOCFF+Qx/hMXJ18h8kkGeg1IEY2+ZwSWJ
	g7pLTJ9HF+zdSUjVvHiE5tET3I5r++A/9ZRj7tGyI6zksEfXktzcXrHjM8N+LzbMRP0=
X-Gm-Gg: AZuq6aIHdiZgBo9r/i1yz6DLDhf/SsQEtM4cXOmvS6E7ULFw66NNizvqCuzgBj+0bCL
	K6OsGyZcPEo3EfuxxmIhtSbL0LK7sI3i1Th0hOjwNIgI7sBgnwSq8jZJ1CPE89tbuvMZ4OqvUHa
	HHlsjKFQq8BSX++hW25p3yPHx7iSBgmNZG5RGi1kQTGyAhScj1qu8AOhBEUbvisraS8rEmUKAgA
	2yPt1BWie0ELKXXjT6XOTgRPzqcloMWEFtvxTb65ia1iVXmieqWS2HdqNkJ7JC1ICP0hlHpIB1x
	yLUHVYJL/T8RTaow9bscJKe7gkf37IW4TugB7wySWWdmk+h2oNesDv4TiVg48GFa0NfQmmguuof
	p8A89rYEgYqxg3msUbP3PV5+CUpq4kjz728CCOqvV1JNmdXm3MTetBYvgDewVoPLAdwRIVBNwrg
	CWt6DNLd87EuelQnFBUA7RKUOfydEpUm86bZsuIQTWrLU4FYQof11rnmVO7rp6E7DHRz+xSw==
X-Received: by 2002:a05:622a:134a:b0:4e8:ad19:99c3 with SMTP id d75a77b69052e-505d22baeb6mr159367341cf.77.1770051058391;
        Mon, 02 Feb 2026 08:50:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740c86sm114645536d6.34.2026.02.02.08.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:50:57 -0800 (PST)
Date: Mon, 2 Feb 2026 11:50:56 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	linux-cxl@vger.kernel.org
Subject: Re: RFC: CXL Isolation Support
Message-ID: <aYDV8EwSx8pM_Fw8@gourry-fedora-PF4VCD3F>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
 <aX0jC3DEqcnyrg7x@gourry-fedora-PF4VCD3F>
 <20260202155905.00000cb0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202155905.00000cb0@huawei.com>

On Mon, Feb 02, 2026 at 03:59:05PM +0000, Jonathan Cameron wrote:
> On Fri, 30 Jan 2026 16:30:51 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > But even then, you have bigger issues for shared file-backed VMAs.
> > 
> > e.g. imagine libc gets demoted and comes back poisoned: kabloooey
> > 
> > But, you can at least get data from the system that the link went
> > down and even have a chance to investigate before nicely blowing up.
> > 
> > Which is at least much more helpful.
> 
> Let's pretend it's tagged (just for ease of thinking about it).
> So shareable that happens not be shared ever.
> 
> Application specific memory isolated to one application - using
> famfs or similar.
> 
> Then it's safe enough, but maybe not that useful.  It's a possible
> path to get to a world in which type 3 mem an be isolated.
> 

Absolutely.  I agree any kind of explicit-use isolation is feasible to
implement large-scale recoverability.

But I suppose to clarify my concerns - I think isolation guarantees
require much more clarity on how involved BIOS can be.

Auto-regions online memory as nodes by default.  If CXL memory is online
as a node (in the current kernel) - then isolation is broken, even in
ZONE_MOVABLE.  No amount of desire for recoverability is feasible.

This obviously changes if the exposure is limited via some explicit
mechanism (FAMFS, N_MEMORY_PRIVATE, etc).  But this is already true
of those paths - users of FAMFS will get SIGBUS'd instead of MCE'd on
poison, for example.

So if isolation is desired, then the default opinion should be that all
management of the CXL bus (endpoints, decoders, etc) should be deferred
to the driver and not programmed by the BIOS.

Auto-regions are basically incompatible with this feature.
   (for more useless information - see: $REASONS)

~Gregory

--- $REASONS

   This is partially informed by the fact that auto-regions are defined
   as BIOS-programmed decoders - which the current driver auto-plugs
   into the dax_kmem driver, and we're stuck with that unfortunate
   backwards compatibility story for quite some time.

   And the platform which use auto-regions may not adhere to expected
   programming patterns due to some subtle deviations from the spec.

   So tearing complexes down and reprogramming them may not even be
   feasible.  ( cough Zen5 :[ )

   But more generally, proposing additional features for auto-regions
   creates an incentive to push ever-increasingly-complex policy down
   into the BIOS, which will just lead to sadness and heartache.
