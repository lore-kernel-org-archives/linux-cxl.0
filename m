Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82B288AD
	for <linux-cxl@vger.kernel.org>; Fri, 24 Apr 2026 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052334; cv=pass; b=fPbH91RI/iybqEXSR70YYltXs3XyNTNbW4b1cKW0Li3BKh9AqclGSbHJcAN8DO40eTPwyF+tAbFgFZtU0H3y6GhkhfdkRNV0O2lgaOXILZe/m2Vu+Ow0cUXwEnfWwdcxKoll/o3RZgFg5CbOfzHO/rq1SYk7ARs6wbjkaSAGDp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052334; c=relaxed/simple;
	bh=b/xeCCC5W128UaMBbfsEO1lBBherMKdTDKmjJXAMNfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6Xp8b4AL+Qbw7maRouVzaZvotKhHwfFIbGEYhM/4EFHCwu13FtPG5cPrQ6tk8hH5nXVxOvSZstF0/YJd6E0pQVYiyejrbPlKY2Mz1mfkpfaA1Hjo8y8RVIxPiMRbmywTOCTXC3xhKGV3Ph6Ld5RofyVymgdWOG9KRRyHZO8JFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prvI4kb6; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prvI4kb6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so748855e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 24 Apr 2026 10:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777052332; cv=none;
        d=google.com; s=arc-20240605;
        b=ISidJC5KB6E0PPdOOk/by8SJwOHwExEeNfQGPU8LxCdyPcU4tG+vO/yaWRcLl0xwdF
         2K3fdLBmPVIdlp6ekXaLdCDb1KixRvbuB3qM6Xxja6X7L6N2kOLjVY30IxEhP/naBgJX
         JA3ZILgdbxQfIYTOmtO0KfMqHGxxoxWbpsm0mhIeamsDL69gxWOttfM6ruddONM8d/2a
         vVmUNIibCSUQb4vRNmRaJf/M20t1giTR/GGEV+iXZCB99j9tWtLN6Fwi7sEcbxqa8mgC
         4cnSyt31YaH1wZQuPo9v+JXP1k6dX9ObOFjcxCeEShFI4Q8FaqgOGCzmz+UJ6pU2pODW
         vMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b/xeCCC5W128UaMBbfsEO1lBBherMKdTDKmjJXAMNfc=;
        fh=g0n4FLRjit0COuJxDrk0mZZvgaJwbB1LnPLyvgZdLk4=;
        b=SdjJg/IT0KocK0unfBAdjZdIb/XvlcwAgOTk6H4xEu78lhk6GATdQLD5ZwNdZeDeUk
         STWm2GhSeRv/HGOBc+vQNJAc3QdE29XuKMvoJR6kMBHvDUSVdL5/a38RUFSfjhGc5UpF
         fqp15p9oEVtX2YlGYU5z0Wjyix02SNv5U5Ec6rvU+2qhjz+r40Qb6QRvwdh5MHJLtgWW
         Hs8hc5hihvZID7kL+Klax+Mpz4QQjVhem95li2YH/1HRF/OpcI9hh5k8PuNPG0vQxHH6
         4RL9x+jkMu+oCvyn7iFxpQbPExlrk7VfvZ63YxitiuNAjVLkiNLtebS24HRKBPQJa5UG
         JYYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777052332; x=1777657132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/xeCCC5W128UaMBbfsEO1lBBherMKdTDKmjJXAMNfc=;
        b=prvI4kb6uDvV4slSkfYyoY8B8gbcJ87HaqZ5pqhrLBJ9BqqARN+onFOHuZvx1WcpBh
         c/k5H7LzHtOCOKkOzJa7NuvvytbQllz0cAHdig8itiRdRd61oYSNtOz5WN0ouRuylVCD
         WWL765PKwhe7IM3blWsQDtp4F5o8eZiTd+0TE7XCXhZmRMvoXDnzNSCo2tUAMW5YnboM
         3GTL0uHzTaXs2y73/+vFbVR0Gg3chS1ElCzH+sckTBmQ0KDdAQkaXoqqEUfjprddyuiq
         swyD4raCWHIdw7f+mbGGb7lkJqr9uBzHkEAWGNkI63c2lUQ60F3AcwIQazaBo6hB7drU
         ZIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777052332; x=1777657132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/xeCCC5W128UaMBbfsEO1lBBherMKdTDKmjJXAMNfc=;
        b=dJ1rrDJU1fbSJ6JNNX4TMjZAE61qZ5nxU1y4guDVVqy/uGHAz7eGcJcs6iCQoYMN5j
         LLuoozFHWY6EZ6Tyeo8i7HCOgE6wiYlhfgwwXtUtvr/rOYpjJRne9Cn5PxbhG0rWhXiJ
         xmaGCwGKbSehlPSuXCuDt+VQndgiaLbT65Omc7tXaGKNG+2y4+ejxjd7zLjDrM2nv66M
         aUQ7qKKEv+p5H6T8EIwPmS7cE3XqOWLZWT4qQffq7G3A9+hXRiVzJTpR2H0IumCKaLqE
         RE64I60uxFjnOmA0Q3aOuaEuoYXWD2njy3tT/TtM0Xe7q4Ei0uZXgFv1dLA5ffey2HkG
         2c3A==
X-Forwarded-Encrypted: i=1; AFNElJ/dV0T4sBqJ3ucjNMVbJ7WJEGMPGpPN4bSEnrGnfOsdpDg/ZJRtF2k6SmoX0GlG0khRqv7HeLD5nB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5RT+kHOy2FUIuTIPIrQHHVxiao2uBN43bdcYfMEQMKw1rZq1
	PVV0KFZTwL2HaJeYvBn3pOtVO98jp0CxRePYH7FxwFfJ48TpFxJp8T3HAsrv6tZ0Jo4J8OPSxPS
	G4bOH6gcpHty1fKx6rEKFQdw0zladt2N/BTLbkfRM
X-Gm-Gg: AeBDies94/pIw9DNvmRyBgEy9rd0heGq+VqD6IziEDXo9uidnfwr2XbdpVvtAJmYHHY
	VBffplaOUsCFnx+9DXn//gaIag8ubFoYMGHXrzrRoySLJZ3J363H5a6uz3n07UpYGLkVg33Aigs
	eUppHOKYfmF/0JiNlFZtMvKYFAP+BRu7OLWtavewJiOQpu/nApgUT2HGoD+fdsnoOCkRRYATfnv
	+QMTdJgjg+HVR39tK2Cyn0fn2+x8ndFW9LhRf3O2V56U63oFv/EhF5NolUOd6EiGktbp0pFX8f+
	XAg3uq+/H4bXF9z9oG3h5Bnucalx
X-Received: by 2002:a05:600c:35c8:b0:485:b6e4:9808 with SMTP id
 5b1f17b1804b1-4890139c764mr8364715e9.1.1777052331512; Fri, 24 Apr 2026
 10:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423170219.281618-1-dave.jiang@intel.com> <aerm4yDVYpOhxXEF@gourry-fedora-PF4VCD3F>
In-Reply-To: <aerm4yDVYpOhxXEF@gourry-fedora-PF4VCD3F>
From: Frank van der Linden <fvdl@google.com>
Date: Fri, 24 Apr 2026 10:38:39 -0700
X-Gm-Features: AQROBzDOaDaeRGYrRb7SiY3F0XElXTuplBC6pu5Adcv_74_sTvogE-uZI0FJx0I
Message-ID: <CAPTztWZwaCYwNp3d_SvRTUD9PwUqfOyRTjoqmq-DwqUVwK4QtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] dax: Add DAX to guest memfd support for KVM
To: Gregory Price <gourry@gourry.net>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, 
	djbw@kernel.org, iweiny@kernel.org, pasha.tatashin@soleen.com, 
	mclapinski@google.com, rppt@kernel.org, joao.m.martins@oracle.com, 
	jic23@kernel.org, john@groves.net, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 8:43=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Thu, Apr 23, 2026 at 10:02:07AM -0700, Dave Jiang wrote:
> > This RFC series is created as a proof of concept to connect device DAX =
to guest
> > memory by riding on top of guest memfd in order to prove out that devic=
e DAX
> > can be used as guest memory. The series seeks to jump start a discussio=
n on
> > if there are interests in creating a DAX bridge to utilize CXL memory f=
or guest
> > memory until the N_PRIVATE implementation by Gregory [1] is available u=
pstream
> > and DAX users are ready to move to the new scheme. Once there's an esta=
blished
> > consensus of interest, we can move the discussion to the best way to im=
plement
> > the DAX bridge and the future of device DAX as guest.
> >
> > I did the bare minimal to get the PoC to pass a modified version of KVM=
 gmem
> > selftest (guest_memfd_test) in order to prove out that DAX can go in th=
e gmem
> > path. A DAX char dev is created and the fd is passed in user space with
> > vm_set_user_memory_region2(). The DAX region is passed in as a whole wh=
en used
> > unlike memfd where any size can be passed in to be allocated.
> >
> > The folks on the cc line are people that Dan Williams has mentioned tha=
t may be
> > of interest to this.
>
> I see these as *mildly* orthogonal, but I think maybe you should propose
> a discussion at LSF to talk about this.
>
> guest_memfd in particular wants the host to never map the memory - and
> guests *generally* want 1GB huge page support (TLB go brrrrr).
>
> There's a real argument for just handing a physical memory region over
> to guest_memfd and making it manage the region manually, rather than
> doing a bunch of nonsense just so you can call alloc_pages_node()
>

Yes, I agree. I originally planned to do that as a project - I had a
prototype of a physical memory pool allocator that just sets memory
aside at boot. But I quickly concluded that you still need folios,
they are the currency of memory management, and hard to avoid (and
maybe they shouldn't be avoided).

So, I ended up hotplugging the memory in as ZONE_DEVICE memory, which
can then be used as a new backend allocator to guest_memfd.

I like the private node idea a lot, but for guest memory, you often
don't want the buddy allocator involved, like you mentioned.

I think there's room for both. Like I mentioned in my previous
message, if guest_memfd moves to a model where there can be registered
backend allocators, both could be used. E.g. a ZONE_DEVICE allocator
which hands out 1G, HVO-ed pages, and a private node allocator with
buddy and LRU functionality (which you may need if you're running
memory overcommitted VMs).

- Frank
