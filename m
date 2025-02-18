Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1DC1E0DB0
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910342; cv=none; b=Vt0HUX5uJUhTvhSBHDd727nKi0aSqJAbXIDVKKJLg0E9ATQsON9Id7LTlG0A6/j2WwRn+ylx1nI+OCG08Lzvbf39Ew/5P4zWIxNdbZKR08lPDQ0dZ0GpHi77OE748PYGT07uTYTXJc14OhN29Vtwfvdwf8HffGzeIHG/NxcHS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910342; c=relaxed/simple;
	bh=cDkEeHC9gnLs+ohg4PIIyzg8RBeo4zppUQIu/rcKYug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZANC3ETQN2lUvQRaGd4ySQ5VDkynYUmMWhCJ6P1Nv/zzOsmWNsPvTr1Rz7DnuP0IzG2tfLG25HXGhouHAGSScYCGQvXf24RLNbxIa4oDmjJMeaVhBUKGrgjYHCR3LDao53t+t75l+7k1+l8Abqv7IqWgpcdl7OydGUycr6DgHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gHIkD4zo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gHIkD4zo"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e6698667c7so53558036d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 12:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739910339; x=1740515139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22K3K8H/Z4VEtlmzFLZqURw4WdVHs3LP2poxDfotsZE=;
        b=gHIkD4zoR5M7kIF6gESfGO6ZGntALAOdRrImpbY/3pCxKxl33jSyuKS3rIEYXbvkHg
         PH2GkmoZbt6LPZO2zwiirLkna8cOA/Qk6l06Fo3fzq+htVrZX5Pp9RiL+0xrgD1Be2He
         AEtrJ/eTsaTSYzttNoZAef+eavyKoWSbY5Xl2iEgIMR+wYdS+O3IGAHtUpf6Yqh6Lh1P
         d+bbJfW3aqjY2j94gM9jW5XIBIFZkwwrRnRe09zZKbyTBZg9RYGYGxcO1ZHY0ZdBLEGp
         AL3ozj6SAdDq4Z8Hzzts/CnsmcIw43p/GZewaWKA+sLHV5jMniP8JLuPJMTCWJRS9ntw
         NUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739910339; x=1740515139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22K3K8H/Z4VEtlmzFLZqURw4WdVHs3LP2poxDfotsZE=;
        b=TXAiT2cpzF2FTyGprKQrMkS0IPYcek10fQmSghMybKr58Y2kSx37RHhHAZHRwCotIn
         NUPA02i5rQdcZzv+1eHGmV3Ut1zDPQZluCx3NJF+ADw7Fd+V2rUIsFG+PGLqtKwFVDQ4
         ofzzCZcNyXXJPyEzcQoGurJ8b77oL9Np1pt5jxmbaO2r6ufR3yh18akMg73fSM5QvS9v
         gQEzzdCKUXwoW0NxG0a7kU9arlemheMLy5iom+FIUs1BWV/vbIu5y9tKctPCWMlr/fB+
         2I3rRr3gSnOJbjNupUrv+p5Sjdmved1yy1M6imOVaBa87Xl+mJzHGk2G2Km0CA2SPjUM
         LjMw==
X-Forwarded-Encrypted: i=1; AJvYcCVD/P86BEzVY/SI3o58defxSt+t8UeTemexNrHNr7Mpz/e94Xq60stxDcHfJlcpRjtybn2HQ9NhDRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvJf+JayPG2LY1nOBkcnnPeBCs9JHoBrJX9ebx6kBQXmRwzhE
	iNhw+gvJJvplObWsFBOcXHTgG8xkx6lXOyTcbxLB7tCD+4ZQysKuPW2Hpy8T0JQ=
X-Gm-Gg: ASbGncsWOTnyireoZ5AjJGo81IkLBq9qpTRbOzq3XxK9FvPNCYmm80IExNq7eNakDHK
	sT5JRDpWOBUuUYoxhDr9p93JwVG5VaRUx4g30+NJ2zCO1BRPB+Lfa1J0kJBmD7rrAP5HfOnCOe6
	VHD+aCvNB+eixD9r4IhXRenUINDI33ztvqM5zLDUGv9m55sF2rpNtL5laMXNtft2jsjhr8847FI
	q8J2y3QMZl2jiXFjFvRUBX6jFSGSx9Jj8x1fSeadXVD58a57DNn/pJdJnqQwU3aHuCMr0nmdLne
	iiaOtVyXVcYUR6WAz11c0kwn16tuxS5Ij10IP9o0ZU2OtUOnQxA8roPqmUDw8Q3yBHGQwBD2IA=
	=
X-Google-Smtp-Source: AGHT+IEI19wWOEv8YZ18w+TjkiABH7btIaZS7NvAL6Op0w+BcszJCj70Cd8D/1/PYxxqGY2625dWkA==
X-Received: by 2002:a05:6214:300e:b0:6e6:5bb2:c1a6 with SMTP id 6a1803df08f44-6e66cd064f7mr220329296d6.28.1739910339666;
        Tue, 18 Feb 2025 12:25:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09a14d45dsm308921585a.10.2025.02.18.12.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 12:25:38 -0800 (PST)
Date: Tue, 18 Feb 2025 15:25:37 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>

On Tue, Feb 18, 2025 at 08:25:59PM +0100, David Hildenbrand wrote:
> On 18.02.25 19:04, Gregory Price wrote:
> 
> Hm?
> 
> If you enable memmap_on_memory, we will place the memmap on that carved-out
> region, independent of ZONE_NORMAL/ZONE_MOVABLE etc. It's the "altmap".
>
> Reason that we can place the memmap on a ZONE_MOVABLE is because, although
> it is "unmovable", we told memory offlining code that it doesn't have to
> care about offlining that memmap carveout, there is no migration to be done.
> Just offline the block (memmap gets stale) and remove that block (memmap
> gets removed).
> 
> If there is a reason where we carve out the memmap and *not* use it, that
> case must be fixed.
> 

Hm, I managed to trace down the wrong path on this particular code.

I will go back and redo my tests to sanity check, but here's what I
would expect to see:

1) if memmap_on_memory is off, and hotplug capacity (node1) is
   zone_movable - then zone_normal (node0) should have N pages
   accounted in nr_memmap_pages

   1a) when dropping these memory blocks, I should see node0 memory
       use drop by 4GB - since this is just GFP_KERNEL pages.

2) if memmap_on_memory is on, and hotplug capacity (node1) is
   zone_movable - then each memory block (256MB) should appear
   as 252MB (-4MB of 64-byte page structs).  For 256GB (my system)
   I should see a total of 252GB of onlined memory (-4GB of page struct)

   2a) when dropping these memory blocks, I should see node0 memory use
       stay the same - since it was vmemmap usage.

I will double check that this isn't working as expected, and i'll double
check for a build option as well.

stupid question - it sorta seems like you'd want this as the default
setting for driver-managed hotplug memory blocks, but I suppose for
very small blocks there's problems (as described in the docs).

:thinking: - is it silly to suggest maybe a per-driver memmap_on_memory
setting rather than just a global setting?  For CXL capacity, this seems
like a no-brainer since blocks can't be smaller than 256MB (per spec).

~Gregory
