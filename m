Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1150131E49
	for <linux-cxl@vger.kernel.org>; Wed,  6 May 2026 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099008; cv=pass; b=obI6zpwD4LhLiQjjYfx7d8aTYZbXlMulJV+t4Vu7Pr4KNVo02xoOQE/jMtpBCEbinz0N+nut1KaEcMSgqEj2ClFTJ0E6uTe4pZlcYyv20Mc+L0VvCtF9s5IADGv9T25NOY7ntpSfwNqHne0xZkDpUuhbQDtnfOrV6+Q1YuO5Zs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099008; c=relaxed/simple;
	bh=l2qvs/OpiAY7DahdxZ+FXBkHDAj1ng953bhsOXn6/98=;
	h=From:In-Reply-To:MIME-Version:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=LWhlUYmoRabpOCE8mjaAfOxOm7VO/ZuEXh3u4U2hnIkKmWRF/vc4+3/4uDpiJRl7Gbzc5oDP/EBlGd3SMTgsIDTmD3NWzMQcWK5Q4+NcPYZzrWFfA3tCLSFy7wyYIlXKmeNZgL5pL+yOQfuqCCzdqb/Xb3M6/7VDPZm45moBMOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUe5V4C1; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUe5V4C1"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-60fee2fa3b8so53234137.2
        for <linux-cxl@vger.kernel.org>; Wed, 06 May 2026 13:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778099006; cv=none;
        d=google.com; s=arc-20240605;
        b=G/IrnHkAiYTAJMONvpfvHS5s6dkIo/lajASK1QdTBnsKW/8VqyZTIDWmPw2wEw5sIS
         OQD0rqp9Fq6ZjQ/FM+gb5Vcu4dyl3TSJw6m1QpDKP3Lk/nnjf5MFHiAbygLp3CQou75m
         olTvQomtb3xWa2LNnQ2Y8YIf/KuMZyaLN1RCvIfhnWcV+euGr4d/QeqetQOqZ4/h41Zk
         ii/iHkXQg/WRc0Uen3oaxzyArnBmqvh0n6RQfatdMBrWqP4AFT1BGVeimosCMjIxAoTd
         /vLF41qv+KYRJUl6q9y+cLJur0oTytJzUNa2plKubVUTAh2nj097qGmutRWqIrw3A11Z
         w0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:in-reply-to:from:dkim-signature;
        bh=l2qvs/OpiAY7DahdxZ+FXBkHDAj1ng953bhsOXn6/98=;
        fh=hCwdSieFKSA+ezmCqgo9rF/FPXEU5jzuy5aoS1nBUIQ=;
        b=PzVFhmwGNWYGpUqxP7Bwl1ov7ASeDp+K7ZibBMGHypUnlOqDSWK/Wrk0stBp7+fJh/
         tvlLl8o+QeS50gm8WTaI/Ebr2T03OdKpANrUYhgKbUnCqJQvoOUt9yhKtjblbyfLXf1F
         X7RYvSBJD69fe7lY6V6ZnjbPEuFXG7GjxXWW713cxTuHFNzirMt4mlT4X74Cz01bbyYq
         JWYsQBIsXHKtdbFFBdc/1hphowt54iQhu/lOtmPmo/KPodmSObgz8NjxxpQcWTed5Mgw
         7lif/Xu+jmcDlXkaHsQ1NtMf4UdNiH8PijBKRiaLS0MMjrnqj0Gb5p8giEjrEKhdNwvN
         u/7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778099006; x=1778703806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2qvs/OpiAY7DahdxZ+FXBkHDAj1ng953bhsOXn6/98=;
        b=lUe5V4C19wovKh//AHemWzWXNJf4ve92ZItjBXVb3ADK7VKkY+cb2VYdQx5tRm56WU
         bo1904GJfphIv/1uCPY6J2otSNoJTQrltOvFtxXNF9b0P9OCf/jwJT5J9chtbxYCfW72
         ISyEUa4u1vWw86MdxDBTkN22olUTA0CKfzXr2NS66H6dBMX5P8TOIuvMtLABEMHrxgZT
         00QS+zuRINsi8Y/qDsMX7rYTqvaHNKgjQpaJbhp3rXP8lRurc2aqEZi3237OmI0HWETC
         s3Voirbuk+hSD00HGmRTHf3tiG1USoxTw9iWyd5IrXlk5OFyA6PjiZA+8gl1c9p69/y+
         NbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778099006; x=1778703806;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2qvs/OpiAY7DahdxZ+FXBkHDAj1ng953bhsOXn6/98=;
        b=gFzRczi/N0jQnmZpM3/FivBN5KdTaxI4s6OMeoNhl9Pmu/Y0+4ev7GcGj/Gb60vhkg
         lv/DjY3UuD0uBAGJpXeeF12jyqYel4CoZBpgAAUp/OMpRG3Na8qI51lXH3PrnHiQ+EXH
         XagGYIwFaN05f/ia/ws/lt5+R3KnGhUwBMADVliWOY7WRS48DheE9jKmm2h8TQ5rpnsO
         fo632fy0zR4Ghi72TxbbOlPdIxA+kYi1VS0bUKEqpmg7OvkKNmR32eXAg4rDYY4aCQLE
         Er27DU9rpepDfhpepxkEc8QEm66bNnhS91+oYTFS7KiEMsPxvwACH2Eok0Zhrw+Ht6W/
         te5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+q5j3ZVxLXfXE03FpJsBTZf4Nmk6JpEcsxk4KKCtyS5oR8JEEB+uCW+ejFLP/yfaaoW6l+3dGRTng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/bP3WvNDqq2HdVislGBRUMUhN2SmrwePhOZRHWmqJDCdPm8HR
	wVjCPt/gevS1Ga/bkr+E/y9Ann7aqt4TP/qH3eUdwTLeQON0/7jjp3GLApl2TQoAyjmHZJELohi
	g3wJrGx7rjBYCj7x11nq1+D/pb2CPgaL6k+AnVFf/
X-Gm-Gg: AeBDieuamEEZcopbifJ6l769HbpQDoSh/G3+XVUHtSbmtMTR7n0hXIdHqGZq7oPa9ve
	HTOs2HaiVWE9fnjqT0+SuP0j9kQHOL99jcxmpyreFsitXU7GKBMw5qlaMiQc3eCtGzvgFSldYo7
	FwtecJuOgpgeOdlcGBxW7ObuYX9tYTCb02JKXll/sgqx4nAUpKhXLZZ2rMCrjc2qVm+8ObcNoK3
	gaTU+/OeqrvFW5vSB95yQh7SKPzsHzbyjDq/tZHNQiQbK3Rp6VGBnTyw5LbYsI6nISaMLPe4qU7
	hNeA9Othxs6eGBE6gAFv9a2ok8b5Zs23Zm68Ew+puavIbyrHLHXY/j3N9AL3kbJUQyj/gOzn2mI
	TZytAhzsDXv7DWA==
X-Received: by 2002:a05:6102:374d:b0:611:a5b6:f4d6 with SMTP id
 ada2fe7eead31-630f8ff141fmr2407196137.18.1778099005276; Wed, 06 May 2026
 13:23:25 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 May 2026 13:23:24 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 May 2026 13:23:24 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <0e831045-3b01-4934-bf43-b3ef01ce0158@intel.com> (message from
 Dave Jiang on Fri, 24 Apr 2026 11:23:09 -0700)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 6 May 2026 13:23:24 -0700
X-Gm-Features: AVHnY4IJAbobQd1jI1QFhsLlfJKxJLWrWZnikjZTL2Cfiw0_frRcrImPr17kfIg
Message-ID: <CAEvNRgE3ifAvgVS4bLeNp_eVp0=6b3p+myYEXSfyS+Qrw5mrtw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] dax: Add DAX to guest memfd support for KVM
To: Dave Jiang <dave.jiang@intel.com>
Cc: fvdl@google.com, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, 
	djbw@kernel.org, iweiny@kernel.org, pasha.tatashin@soleen.com, 
	mclapinski@google.com, rppt@kernel.org, joao.m.martins@oracle.com, 
	jic23@kernel.org, gourry@gourry.net, john@groves.net, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dave Jiang <dave.jiang@intel.com> writes:

> On 4/24/26 10:13 AM, Frank van der Linden wrote:
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>> This RFC series is created as a proof of concept to connect device DAX =
to guest
>>> memory by riding on top of guest memfd in order to prove out that devic=
e DAX
>>> can be used as guest memory. The series seeks to jump start a discussio=
n on
>>> if there are interests in creating a DAX bridge to utilize CXL memory f=
or guest
>>> memory until the N_PRIVATE implementation by Gregory [1] is available u=
pstream
>>> and DAX users are ready to move to the new scheme. Once there's an esta=
blished
>>> consensus of interest, we can move the discussion to the best way to im=
plement
>>> the DAX bridge and the future of device DAX as guest.
>>>
>>> I did the bare minimal to get the PoC to pass a modified version of KVM=
 gmem
>>> selftest (guest_memfd_test) in order to prove out that DAX can go in th=
e gmem
>>> path. A DAX char dev is created and the fd is passed in user space with
>>> vm_set_user_memory_region2(). The DAX region is passed in as a whole wh=
en used
>>> unlike memfd where any size can be passed in to be allocated.
>>>
>>> The folks on the cc line are people that Dan Williams has mentioned tha=
t may be
>>> of interest to this.
>>>

Thanks for the PoC! I've been working on guest_memfd HugeTLB and I'm
glad there is interest in other "backends" for guest_memfd :)

>>> [1]: https://lore.kernel.org/linux-cxl/aeWV1CvP9ImZ3eEG@gourry-fedora-P=
F4VCD3F/T/#t
>>
>> One of the main ideas behind guest_memfd is that the memory is managed
>> by the kernel only, so it knows what it has and that it can trust
>> the memory. This RFC passes an fd in via the ioctl(), which I think
>> breaks that model.

Yup! One of guest_memfd's core purposes is to be able to block host
accesses to guest private (in the CoCo sense) memory.

>
> Don't we issue KVM_CREATE_GUEST_MEMFD ioctl to get a fd in userspace to b=
e passed to KVM_SET_USER_MEMORY_REGION2 ioctl later? We are just passing in=
 a DAX fd instead of a guest mem fd.
>

This RFC is passing a DAX fd instead of a guest_memfd when creating a
memslot, so it's not really using guest_memfd, it's just reusing the
functions that were first created for guest_memfd to support another
kind of fd.

What's the use case you're shooting for? Why not mmap() from the DAX
fd and then pass the userspace address to KVM when setting up a memslot?

Is there a requirement to have the DAX memory usable by CoCo guests as
well, and hence requiring guest_memfd-style protection from host
accesses for private DAX memory?

>>
>> Since there is interest for several different allocation backends
>> (default, hugetlb, zone_device), it might be better to use a model
>> where guest_memfd has the option for backend allocators to register
>> themselves in the kernel. The ioctl can then select one by their
>> id/name (could be just a string). They can be configured using
>> e.g. sysfs (like hugetlb already is).
>>
>> This would also allow easy experimentation with new allocators,
>> having an allocator with BPF control, etc.
>
> Agreed. Although my main intent is to see if there's interest with provid=
ing something to the usages already on the DAX path an ease of transition u=
ntil something like what's proposed above shows up. But if what I proposed =
will be a security issue then maybe not.
>
>>
>> - Frank
