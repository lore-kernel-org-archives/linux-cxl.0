Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8331A567
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965252; cv=none; b=e2hwhzFOdHEUUw7utdGb0g9Eh//lJKK18rJNoCDppA2NWDH+wZi3yvX0wh+2ltSnSYedTmkxeOI8bKEKzHA1Eszi9vUTo/SiZ55w+hlvGcznIUWoAucaNYJD+6QFhPOMNErn8jQSXquaNAmrM+0uNVYsJjo1Vh37idkygRuYoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965252; c=relaxed/simple;
	bh=Iw9IjvIGMsKoBUILNNyJxK0ypNF4yUyPycUJvOWnFoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3SRLBYHUcQiAY0SfqdlrlP0IJLTWa1Z5ooxq4bWVCu6B3Swedp9VLD9vDGF7ZLdzPzVo37g9k2249DmlPl+7F1wspVQUtsh1n4mufdAkwJ6KC3KCuZ860Cu4jCD8xRuQDaWn1bA/n7ybELrgq4lTFRFOxf90ohOQlyGZsD5BKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gr3Hxkj5; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gr3Hxkj5"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50335b926c2so53759531cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776965249; x=1777570049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvC66dFEnVbU2q3BQXKFJd31eHL1LmeSE9BPsJjLUdk=;
        b=gr3Hxkj5Igj2eaUqFD/6jFowem0TeDI4bBrP+B7xvYZMtIARP5DOF2x93hZdM3YhvC
         OJnYFP3Jo/DkQrhz9p6KhvHdD13tX4Pu/VUYVKWUhBg/JPlEqLyDXP79PI6iP8HaOQTA
         /zv06rKsyKhg6id3XrecG4IW9M95yGtz4RvdF2FemEua6oS5kPa49YoBviYyHdTMt0Iz
         3AcPkVpcoV2/sdIo2ce4pwvMk/NBuTvaTqrVCFBumgxnwUFpz3crhJ+LQzrI10OQ8J8V
         0w+3/SCea+FUcm5Ws/+KyP9vTJ9hAQlmynZ2vDf97xr9g20mjPaAPpCnv+lOPFIXiwn8
         oWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965249; x=1777570049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvC66dFEnVbU2q3BQXKFJd31eHL1LmeSE9BPsJjLUdk=;
        b=qXIu/yHA4wrd3ldXCu1BmNExE8YZOiVC54ngRiNsUuyTbIO4GxqVnklXDOoKh2PXEg
         8jT4eiMOlfbx14h4NFYZTD29nPG9/DSfOj1BV1LsJE0BNjZyiFQwNwkWx+Ebk9CdmfmV
         nUwZ+Q+i0RL8d5EKTUnWXPprBEy4RsoYtVIN5TtrHSBsaJJyfOsg5khSOo361eKAtrMR
         qBdPCpzhbFMT6i3msSNu8GtRQ8mVwsywnMcBXTed2fzmpALlD2Lo99/Ovz7D7nKWyX9h
         RPiJAAD5S9pkmSnLkGLRPo8L2CcWRRzIhQGYMZ5rFB34WIbG7t9y1pAo7jPhAjzVKegP
         rh/w==
X-Gm-Message-State: AOJu0YwwGKooj+fg2CLaDIxAeQoScdk9QsL8KJdLzC2yGZVjR+cDTH6i
	nvVLfLL3orWs6HY/kunc/b84x/+O5Wgn/97k2HiPMmBruLdBKsQfJgDDPQKRjb/5kxM=
X-Gm-Gg: AeBDiet050hPFtAUwovTLNP6kjEFHyMfYFwn20KkQsV715DlGqp2b0jomxErfoabSnk
	AwssdkdU0ETry2D1/EEjLrhcvote9WpHcP3Vn+eZ0m26CoB13n+FDcBhGDyPXe163S5jPPsvSHs
	Hv41T0hS0JDfCTiwltsi8rQAZe2+IzKbxEfRH82cWsFfkVT2NtDDG9ZY6W04Mmymgrc+LZBI0Ur
	yE0YLZ4TqGbe/g2yY4h2bK+sml+ULcMdwLSMtktLA+b7V+EjZRidJzfTRILBx1KUfH+qFbBsLF8
	HKvDoYIgcNCiQU5K/Bo+qSM87DbB4HBRdn5YwfggSKANFBhBtECW8JgywDItYd5Xo0GqhY9vPA8
	LQ+qB6J4e2bSpsfoKSi1/MJ2NfRHSDsk1yMRG09xiWXUZcKj5qx/qtWXSeq7Bsub2rzy0Gdad8Q
	EUd0RvEwsAS6KO/E52sQdeLWqdcl4LyofyrpGGssGlVE0whMyOq0rFir7Bf2wQqw==
X-Received: by 2002:ac8:5988:0:b0:50b:4eb9:a97c with SMTP id d75a77b69052e-50e36bd6e6cmr429301921cf.15.1776965249137;
        Thu, 23 Apr 2026 10:27:29 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb11f9986sm82137441cf.22.2026.04.23.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:27:28 -0700 (PDT)
Date: Thu, 23 Apr 2026 17:27:27 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, djbw@kernel.org, 
	iweiny@kernel.org, pasha.tatashin@soleen.com, mclapinski@google.com, 
	rppt@kernel.org, joao.m.martins@oracle.com, jic23@kernel.org, gourry@gourry.net, 
	john@groves.net, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/12] dax: Add DAX to guest memfd support for KVM
Message-ID: <aepS0w2aeIh2xx0G@plex>
References: <20260423170219.281618-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423170219.281618-1-dave.jiang@intel.com>

Hi Dave,

On 04-23 10:02, Dave Jiang wrote:
> This RFC series is created as a proof of concept to connect device DAX to guest
> memory by riding on top of guest memfd in order to prove out that device DAX
> can be used as guest memory. The series seeks to jump start a discussion on
> if there are interests in creating a DAX bridge to utilize CXL memory for guest
> memory until the N_PRIVATE implementation by Gregory [1] is available upstream
> and DAX users are ready to move to the new scheme. Once there's an established
> consensus of interest, we can move the discussion to the best way to implement
> the DAX bridge and the future of device DAX as guest.

I cannot speak to the CXL/DAX use case, but I can provide perspective 
from a persistence point of view. Currently, as a temporary workaround, 
we are using emulated pmem in DevDax mode for live update purposes. 
However, going forward, our plan is to switch to regular memory and use 
LUO + memfd/guestmemfd backed by regular RAM to preserve resources.

We are working on a patch series that we plan to send out in the coming 
weeks to preserve guestmemfd via LUO.

By design, all resources that participate and need to be preserved 
across reboots for live update purposes must have FD handlers.

Does your series allow DAX memory with 1G alignment (i.e. 1G pages) to 
back guest_memfd?  That is also an interesting use case, while HugeTLB 
support for guest_memfd is in progress, it still has not yet landed.

> I did the bare minimal to get the PoC to pass a modified version of KVM gmem
> selftest (guest_memfd_test) in order to prove out that DAX can go in the gmem
> path. A DAX char dev is created and the fd is passed in user space with
> vm_set_user_memory_region2(). The DAX region is passed in as a whole when used
> unlike memfd where any size can be passed in to be allocated.
> 
> The folks on the cc line are people that Dan Williams has mentioned that may be
> of interest to this.
> 
> [1]: https://lore.kernel.org/linux-cxl/aeWV1CvP9ImZ3eEG@gourry-fedora-PF4VCD3F/T/#t
> 
> 
> Dave Jiang (12):
>   dax: rate limit dev_dax_huge_fault() output
>   dax: Save the kva from memremap
>   dax: Add fallocate support to device dax
>   dax: Move dax_pgoff_to_phys() to dax bus to be used by dev dax
>   dax: Add dax_operations and supporting functions to device dax
>   dax: Add helper to determine if a 'struct file' supports dax
>   KVM: guest_memfd: Add setup of daxfd when binding gmem
>   fs: allow char dev to go through fallocate
>   dax: Add dax_get_dev_dax() helper function
>   kvm: Implement dax support for KVM faulting
>   kvm: Add daxfd support for supported flags
>   selftest/kvm: Add daxfd support for gmem selftest
> 
>  arch/x86/kvm/Kconfig                          |   1 +
>  arch/x86/kvm/mmu/mmu.c                        |  48 ++-
>  drivers/dax/bus.c                             | 132 ++++++-
>  drivers/dax/dax-private.h                     |   8 +
>  drivers/dax/device.c                          |  80 +++--
>  fs/open.c                                     |   3 +-
>  include/linux/dax.h                           |  15 +
>  include/linux/kvm_host.h                      |  39 +++
>  include/uapi/linux/kvm.h                      |   4 +
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../testing/selftests/kvm/guest_daxfd_test.c  | 329 ++++++++++++++++++
>  virt/kvm/Kconfig                              |   4 +
>  virt/kvm/guest_memfd.c                        |  92 ++++-
>  virt/kvm/kvm_main.c                           |   6 +
>  14 files changed, 711 insertions(+), 51 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/guest_daxfd_test.c
> 
> 
> base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> -- 
> 2.53.0
> 
