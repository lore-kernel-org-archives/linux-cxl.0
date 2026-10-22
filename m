Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792643642;
	b=ZXm0PjEXT24PN0ZnQuNGRlxYisqGP1f+wDe82JSvqUo521b/Q9xfPSboNr+sJJtPgyJW
	 KU9wz32VXYXSqvZ9NerJon/NdeKrWSCWNsUbHMpKpyFIcz/JrFEiA8bDUh2xxzMVUanVU
	 JHTrDo57DA7pqDge9fj0UHkaeViJiMozHVYFHqbsWY+miCChke67wLq/f+15VSBmzjEFq
	 pj2b69fsVb1st514lKQvqWLV37m0kLmjq+GtRiRn/D0ui0od3kzxlhyN+hemLu57D3t29
	 ZAVrE5urfuK4Z6qXD9sa1usFAkj/mRR9QtarI5FAVzhNg1tQslMOinfyHD5gmowU7+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792643642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FX6Mu1YeIXFmXkKYuzzN3WwkU16Ko5e6ASCr8EcCtu0=;
	b=bxj9Cf48hNM0JvWMrDRSnXIQMep+1NfVxqpu+jdP1oY4YmC3IsqPLWfMymMSFjoDXipz
	 Qi+mtV9w5fhRFO8S+q/LpKCI+KZy3cLVyjm8Rz2Z2Hdd8NyYpzKvqUrbO81yAtfLI04SC
	 UMi1bp4KWNzZilnsDUYdFswYb9I8/QQ+6GYthE5HAQkBk9u1J+ScqRKxJDG/as4CDko6z
	 BNexzTIuyTcJMAT0WqaFk41Cgonid+TE8rMIDHOtuT5mItzz4oImbZa346iYSmjTtk+xC
	 DDynQMjoiVsNrSbKyBigul/7EJSKGlST1OCkc0rQ9oWupjGuOpJYurNh/+BekvEn1Cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kh4Kj3yO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D571606A31B
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 04:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D571606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kh4Kj3yO
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so2439512a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 21 Oct 2026 21:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792643641; cv=none;
        d=google.com; s=arc-20260327;
        b=MyYwLyp27NqBCFDk3BmzcCyYRCg1ZiP4wW8+HrFzoLtBlmYvs8q1AHT/MlTszYO0Ok
         9caaWrivEZA6TBf+l0NJJqB7gwl9v4N4ykmktpvRzj3sAMRAbHkNZeVYbXZI8DQXkwu2
         EVcdksWYvS9d82tY1D8AbDAZecxRXgGBSJLA1PsEOwo2SAztwiRiymcFGsUW8BHHY0+x
         wv0J0L2ISgNb5RSDjfZCmh9dc3nE2pqmGoHSm/CgQce8KX5gH25wmy0a4foo17oMA2Ee
         HWbbV9K36pK6XWcjswVM65KHUWic98aPKT7VYE7aGFyK/gJSaPm2zEug3zyKfCcdkzzK
         /GJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FX6Mu1YeIXFmXkKYuzzN3WwkU16Ko5e6ASCr8EcCtu0=;
        fh=LQ5LWUPnEVOGlo/hoWuSqEh6TAHhpmPDlXswXSJoY3c=;
        b=SwgThMN8imkBOT54XC016/heSxXurio8hQIfXyYjjAm0WzFHnFCkRt3IT0uGkmpL2m
         moW53aw14IDWIcd6KEyTJHCz3aWdKz7j+dNuW1/SD8xTUeGwrd5yYEX7h5ohrSjrjhq5
         y3IacttqrIvgH+g32JjOTQlxhsAhrXoNxOM7/Fk/cR/nzPZNUYltVrYWj75t4DdsP316
         zYSiV3T6bkECuAclaBPV7+ysjOfNLqkSnt6JPIEyXMuxPhak/CHms7Tqqhs9/mMGGiM+
         evb5IQZOfgTKEVUYAIXCEBjTbUQz7NvYGAnQT6VkODGNI8HhcSMBDoMd7/tPTPGuDzLe
         wp+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792643641; x=1793248441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FX6Mu1YeIXFmXkKYuzzN3WwkU16Ko5e6ASCr8EcCtu0=;
        b=kh4Kj3yOXXV8CiQcn4iFy1A+6FMPrhHZk30T8qITp+G7TmFL8FUg5YYRobXac7PDFA
         TkiaFKqL4mhd4RHCf6FQzEACq2KAHTf1cnH712Uc1wB4agR0mDXXIn9WwajVCJT/8So2
         83dfzqfRpe7qzMyB2ArFshwYf/YrDWzzXjvi7pK5/yh0J5EqiP1yud4QYRjixuGuHuk7
         mBpYQYJfrR5N8gnJiyCkq+Bx3KaTlhvG2YSGeTuiKrZYfUH1vYXO7chff65aeu4YKhgL
         XKmsG318gDwJ3ALdCKg+YSBvDnFnleja+tZ20vdl3JkBUJxXgw2vaU9JfSF7AaGLqhxu
         kDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792643641; x=1793248441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FX6Mu1YeIXFmXkKYuzzN3WwkU16Ko5e6ASCr8EcCtu0=;
        b=aFzjl0pZ9qTUhqEB2F+hvB3QaTixeGBWkp05gCTrITbbth1NP/YDXugaHlDmhLc0Yp
         aPmS379eujVkNNQx+wmpeKVJ+/6X5euaXKDYOCgbc4ZOCgj0mojcbN6G2G82/XhhiZfw
         7Mb8oNanOCaAPqo0TDRCYYdp/Jy39vQz+aiYtathRzNXcpQ3QRRgW7eJP7EvtWuHo0C9
         pOip9KfWQLrQomc9cEPF0XxXKvuZ8vh1XvGKjcsBJMR4lUh4JUALlRrWQ/CCwQcGvFzC
         lorFrNkRrRH5qmRRKv79s6nMZLLVPLTtoANrApxJ0wJFo2RxyaKfLbR4V4QDDDdWWiL8
         nujg==
X-Forwarded-Encrypted: i=1; AKwUvByvKBZkTSjoEa6N71X3e4d5iz16SjSHoULCMFVoaFhTqi390OBhAO0WNfzFNjwakURjDrQXPNz0DNg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcPwa+DD5/QKkCsPYrA6AuXudwVBipojHkly7IB8GNrUsqJK2e
	qmOl7V1VJXwUV7Rvm0iw6A3Zrcs0divbJwdCf5QVvwHP9NJGHGiFedV09sIIkS2ytJnvyUEAHP1
	i1cKEqsk357sCpNbXeJ/oWyB1z7NV6do=
X-Gm-Gg: AYBFou0nbXuDkqS2ugGTDgL+c/v9RZu22k8zH0n9IClAANEpQ+mhIHmglqJhgKtKjv/
	rEqpZ8LDspZxCZsmc5meJymmB8p1HQMpbLN1eMnjhi4OMqrQXEMYdOZCbRhz8TsFy7Vo0nPk2ds
	g8/Gdi5mtxY0eGD3JrcLY4okDMLUEepQsIPzy4fvrnGS4BkS3gJ+CECG9BZe1jUJQj8V5KzOEMD
	M85NZg6EA6j+GEd2YDktJ4TD55FhrDyBaazWW4jiz28Y7C7855OsSMReRh675njSK90p7Q1b5fp
	aoxGsLPRghXw5BMIqzMq2PPhlDnigsupVRQpsVFtr+kJMLbgK5rWtXE3Z343dlUvO1DTew3sOkA
	8qRJ2Obc79UNQ5pD4SodS9kSIlhQCFxSIuIJnIQpHyE/id4Nx4umvCEROLl7YXM08B7c=
X-Received: by 2002:a05:6402:28c8:b0:6ac:bd53:d29a with SMTP id
 4fb4d7f45d1cf-6b408dcd1femr2989972a12.3.1792643640365; Wed, 21 Oct 2026
 21:34:00 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <as_r8n7p_wdbChuQ@google.com> <CAKmqyKOkmwompJqaP2k-oJicmXmqHY4E0wuLcrvkHLx+oauQ2Q@mail.gmail.com>
 <DM596TT7E841.1U05OKY9N6I6C@nvidia.com>
In-Reply-To: <DM596TT7E841.1U05OKY9N6I6C@nvidia.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 Oct 2026 14:33:34 +1000
X-Gm-Features: AclHuK9U67i3MHCSs1fpGty_QgfHHhn6FdMHJ0fAOkjnn4XpsrsbQBC3WfRL_pw
Message-ID: <CAKmqyKMbs_N6C8MAKGUU11DW1y5nJRWPqnUcrVZoyi0SDjsv3g@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, lukas@wunner.de, linux-cxl@vger.kernel.org, 
	akpm@linux-foundation.org, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, bhelgaas@google.com, alistair@alistair23.me, 
	djbw@kernel.org, linux-pci@vger.kernel.org, wilfred.mallawa@wdc.com, 
	a.hindborg@kernel.org, gregkh@linuxfoundation.org, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, gary@garyguo.net, ojeda@kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 6:02=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> On Thu Oct 15, 2026 at 2:23 PM JST, Alistair Francis wrote:
> > On Thu, Oct 15, 2026 at 6:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> >>
> >> On Mon, Sep 28, 2026 at 11:11:01AM +1000, alistair23@gmail.com wrote:
> >> > From: Alistair Francis <alistair.francis@wdc.com>
> >> >
> >> > Security Protocols and Data Models (SPDM) [1] is used for authentica=
tion,
> >> > attestation and key exchange. SPDM is generally used over a range of
> >> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >> >
> >> > From the kernels perspective SPDM is used to authenticate and attest=
 devices.
> >> > In this threat model a device is considered untrusted until it can b=
e verified
> >> > by the kernel and userspace using SPDM. As such SPDM data is untrust=
ed data
> >> > that can be mallicious.
> >> >
> >> > The SPDM specification is also complex, with the 1.2.1 spec being al=
most 200
> >> > pages and the 1.3.0 spec being almost 250 pages long.
> >> >
> >> > As such we have the kernel parsing untrusted responses from a comple=
x
> >> > specification, which sounds like a possible exploit vector. This is =
the type
> >> > of place where Rust excels!
> >> >
> >> > This series implements a SPDM requester in Rust.
> >>
> >> So I looked a bit at this, and here are some comments. I will not repe=
at
> >> what Alexandre has already said.
> >>
> >> First, I'd like to say that it's good to see that all wire-format
> >> parsing in lib/rspdm/validator.rs is written in completely safe Rust.
> >> That's exactly what we want to see for parsing in Rust. We want the co=
de
> >> to have basically no unsafe code whatsoever so that we really get to
> >> rely on the bullet-proof guarantees about bugs being caught at compile
> >> time, or at least at runtime.
> >>
> >> Unfortunately it looks like the same cannot be said for the state
> >> machine in lib/rspdm/state.rs, which has way too much unsafe code in i=
ts
> >> interaction with the rest of the kernel. There needs to be more
> >> intermediate Rust abstractions here. This file should not have *any*
> >> unsafe code, except maybe 1-2 blocks for using the C transport and
> >> validate function pointers.
> >
> > Yeah, it's the crypto functions. There are currently no bindings, so
> > it's just directly calling the C functions.
> >
> > Without the crypto functions it's just a single unsafe call to
> > `transport_function()` in `state.rs` and a few in `lib.rs` to handl
> > the C <-> FFI boundy.
> >
> > I was trying to avoid adding crypto and X.509 bindings in this series,
> > as that's a few more subsystems this ends up touching. We need to add
> > PQC as well, so crypto bindings are next on the todo list once this is
> > merged.
> >
> > Is this going to stall on adding crypto bindings?
>
> So without going all the way to fully-fledged crypto bindings, you will
> spare yourself and your reviewers quite a bit of pain if you at least
> implement a safe and lightweight crypto wrapper that is local to SPDM
> and could eventually grow into official crypto bindings as a future
> effort. As it is the code is very hard to review: for instance
> `crypto_free_shash` is always called after `free_desc`, and looks like
> it could/should be part of it, but that's hard to assess as the crypto
> code is mixed with the rest and called here and there. I just cannot
> tell whether all these unsafe blocks are safe of not, which is a problem
> since the goal of writing this in Rust is to prevent exploits.
>
> A self-contained crypto module exposing a safe interface would remove
> that burden, reduce the number of `unsafe` blocks, and make the series
> easier to review globally while not necessarily resulting in more code.
> You just need to store the relevant pointers into a new data structure,
> enforce the required invariants at construction time, and codify the
> actions that SPDM is already doing in the form of methods.

Oh! That is a great idea. I have added that locally and it's pretty
nice. I'll tidy it up a bit more and then send a v5

Alistair
