Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F823372C
	for <linux-cxl@vger.kernel.org>; Fri, 24 Apr 2026 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060934; cv=pass; b=PSGygXDf0zproT2AlpWCBHWh2P+W88UXB99qXJ4Cuu07iAI9oDQbchEa1UrWmdNkm3SpcUf3F/hczphPtdOGlYJC3ILoShiw0Eo+FElE5mY8tOawlZfVaj8aVOi3DTcFyNXgzcTh6QGpbGRllblWFEyVwbmK8PfzX2wtoMYgwV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060934; c=relaxed/simple;
	bh=opi3GnG+GYzn2UgzsBWPxwzmr8APgJV4zt/dGtJ+25c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ored/dyFXNCaM+xlf46uqWxRofUw1L9DlBFUSnsdAO64zeV+Mr7x33JUH+PYGHIWXMQ5jOnQIXIqlDpPdHbLAOgTaQv++cbgsuDBz/8k3oRGdiQ6/8Hsz+t+yEXCLq2UVztQq1mu6ISj1FTvaGD3gXswZpIydl1XypHZ3XANQ4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ozsy5Oi9; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ozsy5Oi9"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so701285e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 24 Apr 2026 13:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777060932; cv=none;
        d=google.com; s=arc-20240605;
        b=fvNbOo2NSzvhy32p8cp49yg9/ZJ/CL1SVYz6bV5xFZMs2tgI+hBZGEyokcwwT8il+F
         T1gOHSEAOMF00PWtPQmVzgSPMDL0NYIDGoaaIhAVBWCNjoJeeGvX1bMOlh95gcM83gpU
         MN+0YNToIugtriZJaqKKQ1rm0OeEcXpyqyRXj4sqaZZVWrf83JiOw5Ppe4IojlPV0zKu
         2zf/2gKl0eJPY2N6XR/ui0ftMQBUsYWXjycjDolwC4zGfzxYd46e6+y63SFiaFwWc3f5
         nateAd7MOmmfCeNIqUk4aM5Pf5EbQtv2/fgSobxQaaquk3cziJl1oP5AbD7bVHlUwBo/
         cOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=opi3GnG+GYzn2UgzsBWPxwzmr8APgJV4zt/dGtJ+25c=;
        fh=4qNxB7XlHsUXL3hVIDFTXOCmtxYLZ7MxCdP6UUc1iAA=;
        b=Al5AhEJGAkgE5hrw1LMb5AtzQpeteMBf16phhkKTZeUvs2gmlWwMqGnuXpYzRTp0E+
         NcsB4yjr44jG3srmTFA0hSWU2nITwBzlJGT+CgLUuJgNSKbofgqok+L/tFEp4uIdghYE
         Q5GgI8pxnFid4ifqTWWJlWsag0CQuYrn+f5y3ySxR+JXuQGsEqGpPOj42qqLw3VWhMdU
         tIXz6QAuW/8pfks/uMbQDEPSXRsYvSPdy6z1CfzDLAQYWhYxejFzCS5vrXrvhwvFZi0m
         gUs7umAaKO8AwNuOyZwp4hXOUQyhHt4WL+XXNseinRlxGBqI9h7W7vEFXAizyEXBqIg5
         E0bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777060932; x=1777665732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opi3GnG+GYzn2UgzsBWPxwzmr8APgJV4zt/dGtJ+25c=;
        b=Ozsy5Oi9n1d9UsCN679JtKSp8JqGEQ0l98GtdP+Ulyf2+yu+BOlBozhs0lY8IGX4l6
         KDdwkQPorWpC1Vf+GKk4e87jb9WKMiRm+xTMbL67edGh2n1rjqlTAJ/eMnr8hEhxpoKK
         SE5LYbXlSEXfTjXbc9bS5dcy0lo+fgJRL+k+dMmedUu7eNxdha1PoCkIXpe5L9w2xJlA
         UzoZEF8pyBjoPnPo6hqpU9FrjEy3t11CbEoJFD5k+IEGRfZFd7EEieJm69vrb46ISAl/
         KUgovhslXQf2h+NgBK1i8yfu9cVJKfLlswpr/fqQqgkRfjYaw90VWuCgxbil20ca2RKT
         kD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060932; x=1777665732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opi3GnG+GYzn2UgzsBWPxwzmr8APgJV4zt/dGtJ+25c=;
        b=NHUQFpRvO2Us8GHWLOwTjAmPzP6rNeQG/sbIzzSgYCjsjBhS0aSFi8phgAKV2d5+25
         iiPUX6VHRPePDrjXVLikZbLje3NIa06/ebwAOwnLpK6clRv5/og1ff77XtgZKm499O6p
         kzGDMzru3b2DLjFbeohuEpL0DDXQVeWBOXdb1tkm5mtU+jPBlI0GGvrfhxb+0aUO/fgp
         oZAUU6A4BTBZfg5VXD7LZYf8YJuupaI0NzkLIvX/ExZxGDcFOeOKutB/1vyTxi4StPGF
         7jJKiTogTg4godXKRBRTLdWeDYXhtbKAxH1+NMDZhsh+rWV6xFVMtnIEOY4WZ8Q8+au0
         4lUA==
X-Gm-Message-State: AOJu0Yz7Y0Yb2ww2UbnobnPfM1UcUUkkhU4Vjv1HC26QnPrQvRF0jjhY
	at+FZtl0kBFjlBf8BoEM66I7ea1JPmiZ1ygbEomTYFdxuRd3kyH3/s8ouUzkcezz8wZOuRxEIu4
	IKpX1/JxWQdqwXRZpzjrMbxXu6WNEJt+tZN44naVQ
X-Gm-Gg: AeBDiesJrwYuPbob3/QK3VyDIGnVjGczvVAxrbSkcGEne4lOkY9fTYb5OnY4o4cdp8L
	k+tdDqAx+Iqp/Up4ZgFk2hhumPX12D+kWm5yc1+COe5rEO3YKP3mH2RGScKsDO2/m+IrJ79i/sc
	D4GtEWuIGLOHjWJ6hlQJvq2AKUM9yEftFUshWoCaZk1aB+RDQFdlFUJ8lBOXU3gjCrmvhubEXny
	IjLhDHjvvrDA2feAQotcENqGL5pqE28pcVpHvcHywMVEHrEDD+hP45yvS2cBHR3dV1mhEx4xyCf
	075yuOq/aca1gXPtpgWfFYp3GPd3LvNnXxI10FA=
X-Received: by 2002:a7b:cc04:0:b0:486:f772:91c4 with SMTP id
 5b1f17b1804b1-4890099fc06mr5959995e9.8.1777060931354; Fri, 24 Apr 2026
 13:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423170219.281618-1-dave.jiang@intel.com> <20260424172912.548636-1-fvdl@google.com>
 <0e831045-3b01-4934-bf43-b3ef01ce0158@intel.com>
In-Reply-To: <0e831045-3b01-4934-bf43-b3ef01ce0158@intel.com>
From: Frank van der Linden <fvdl@google.com>
Date: Fri, 24 Apr 2026 13:01:59 -0700
X-Gm-Features: AQROBzBNKCMWsvrneA4HKVPUSplj9uBs_lEv48Q-q2Gi0reTVyn2yTOOmiot4KI
Message-ID: <CAPTztWaXt8izKtpC=g4aOBddvSX9ViekxyPS8UnSBuqitGZuyw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] dax: Add DAX to guest memfd support for KVM
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, djbw@kernel.org, 
	iweiny@kernel.org, pasha.tatashin@soleen.com, mclapinski@google.com, 
	rppt@kernel.org, joao.m.martins@oracle.com, jic23@kernel.org, 
	gourry@gourry.net, john@groves.net, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 11:23=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> =
wrote:
>
>
>
> On 4/24/26 10:13 AM, Frank van der Linden wrote:
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >> This RFC series is created as a proof of concept to connect device DAX=
 to guest
> >> memory by riding on top of guest memfd in order to prove out that devi=
ce DAX
> >> can be used as guest memory. The series seeks to jump start a discussi=
on on
> >> if there are interests in creating a DAX bridge to utilize CXL memory =
for guest
> >> memory until the N_PRIVATE implementation by Gregory [1] is available =
upstream
> >> and DAX users are ready to move to the new scheme. Once there's an est=
ablished
> >> consensus of interest, we can move the discussion to the best way to i=
mplement
> >> the DAX bridge and the future of device DAX as guest.
> >>
> >> I did the bare minimal to get the PoC to pass a modified version of KV=
M gmem
> >> selftest (guest_memfd_test) in order to prove out that DAX can go in t=
he gmem
> >> path. A DAX char dev is created and the fd is passed in user space wit=
h
> >> vm_set_user_memory_region2(). The DAX region is passed in as a whole w=
hen used
> >> unlike memfd where any size can be passed in to be allocated.
> >>
> >> The folks on the cc line are people that Dan Williams has mentioned th=
at may be
> >> of interest to this.
> >>
> >> [1]: https://lore.kernel.org/linux-cxl/aeWV1CvP9ImZ3eEG@gourry-fedora-=
PF4VCD3F/T/#t
> >
> > One of the main ideas behind guest_memfd is that the memory is managed
> > by the kernel only, so it knows what it has and that it can trust
> > the memory. This RFC passes an fd in via the ioctl(), which I think
> > breaks that model.
>
> Don't we issue KVM_CREATE_GUEST_MEMFD ioctl to get a fd in userspace to b=
e passed to KVM_SET_USER_MEMORY_REGION2 ioctl later? We are just passing in=
 a DAX fd instead of a guest mem fd.

Sorry, yes, I should have said "it passes in a *non-guest_memfd file
descriptor*" via the ioctl. I think the intent of the guest_memfd code
is that it can only bind to a guest_memfd file descriptor (hence the
check in kvm_gmem_bind()), otherwise its trust model would break. Of
course, I'm not a guest_memfd expert, the maintainers can give you the
definitive answer on this.

>
> >
> > Since there is interest for several different allocation backends
> > (default, hugetlb, zone_device), it might be better to use a model
> > where guest_memfd has the option for backend allocators to register
> > themselves in the kernel. The ioctl can then select one by their
> > id/name (could be just a string). They can be configured using
> > e.g. sysfs (like hugetlb already is).
> >
> > This would also allow easy experimentation with new allocators,
> > having an allocator with BPF control, etc.
>
> Agreed. Although my main intent is to see if there's interest with provid=
ing something to the usages already on the DAX path an ease of transition u=
ntil something like what's proposed above shows up. But if what I proposed =
will be a security issue then maybe not.

Sure, yes, understood that you're looking for a transitional solution.

- Frank
