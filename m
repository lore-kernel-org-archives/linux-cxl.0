Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A119D071
	for <linux-cxl@vger.kernel.org>; Wed, 18 Feb 2026 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771381103; cv=pass; b=TzYAl0q71yvW/7vR8Fwc9KKWa5/dDxVWatCnjkvzwAKmbd/4mflBT1SdzdD22+oQzj3FcK02C3Fm1obfWYPYf+JMNHPmaxKF0z94zre4p6+hTR7Mcvzhc6Ko6lBIWpPDwUhLRlhVlmk1M71gnCBuEvq3qSHUY/DwPU9lrsZXv60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771381103; c=relaxed/simple;
	bh=oisk5RNGpe9X3B4rnNrrpIM/YAw2CyQ7pCGjtBnp3LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=askaL9mFaUz+TmmAxTO/AkEpkLW8W70GRmN87HomY2nvAJeCXxxcV+Y89ibcekmAUaD7zkQIX6s/qjx7XxP74YpHEPLJOA0JVicMrtrlL2KuccmKzfEg/kP9Wxby7zyWvQn5AuNFB5mJlGKezGXApUabynymEcIYbzATrUN65Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpByvxaA; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpByvxaA"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8fbb24a9a9so61287566b.0
        for <linux-cxl@vger.kernel.org>; Tue, 17 Feb 2026 18:18:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771381100; cv=none;
        d=google.com; s=arc-20240605;
        b=aczF/NQQ1UA2kzOEypDfcLOUvsxCSbJaCtj0WiIEajtbDp79+l10M32KtypRnRm2d0
         yKwOudacbCiG/w7tHe9pqSoRLtWPTXPHl37/1i2vTAl7GpyScFjDtDDRPyds3URg3a51
         N+2q5iXWXoGfmIULbZjy3LZrPiHr6bEFxSFINK+Nvu5cFlarL2WUJdSmlVN15aLckJZ2
         pVY7qRNItOQkaoCT+FO0T/mqnJZ+DuUa8+6sq/0TU9vQ1ejkr8DL2mL7vUI4CniFlxL5
         AdnS0tBwiqMDzcO2EBjsHjTVtUW3g7aSV1GJ7pDjuXUdFi2H+LlPwG+J89EF01IXzgf3
         1CEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oisk5RNGpe9X3B4rnNrrpIM/YAw2CyQ7pCGjtBnp3LE=;
        fh=TdoJnGKyzBs85/4wUuyknI4sD3IDkQKAc+pvdEgvVoo=;
        b=eLtWVOtmTWtYiocdzVspeJUl99JWWdI3jDm7waYiDBYgqDmLOVD1k2lgkVAR7Z26wT
         zWr+pRqMh2e5Oi0rll04IEoEdKuGemC4sVNMqVmMkc9npPV+bI8x6K8REKxSY7+H/N0H
         M0D8dM6ikEKZQQYcEwpqO/agWwHWp0vnFWndazj+ZN4pLS3KQUxc/QLeVtTLTmyChVmo
         EtriW7Ezaf06sgSnzxBZo6SFSpTJNLFmEZwSL8iIqoUh9/IU4921cqpfnUYKozBteSlB
         9aUmChXCSPXjViiDRpo+IDIbCV/4iuFFeatcvu/9x9bNu8VeITfjLF7kF5ohFtwJNX4i
         VoNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771381100; x=1771985900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oisk5RNGpe9X3B4rnNrrpIM/YAw2CyQ7pCGjtBnp3LE=;
        b=jpByvxaAdfjRsOfPiOQAodpAVVLRxR2MeIWdlW005xLzXoPH5BcC7s2D1ShgO5j5Jn
         /y5Wkpb99qJui36tSejkvEPumsE+akubQsBud21XznDpcTLook5pCeIQPhODlaJFxxhJ
         r+EVvQc1hq30dbFr5ox/aoFhrKZNckRT9SpUEfjdQ1mJo6+AJhoE5TS1144JAAAukZI+
         iz32grPxYgG1OY79JknQBUr7T3ctEPqWcfhq/0IzYo2KauXMC2J7oo/ULaWvjzoEhpdI
         lAvEiCrzw0hCw+IGQgqSqV8b4plqrYbBdblU8axZlfnmaIRASpTgkIw3hDesAIMOytlV
         WCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771381100; x=1771985900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oisk5RNGpe9X3B4rnNrrpIM/YAw2CyQ7pCGjtBnp3LE=;
        b=sIzm0AdC4Huew+F4vX9D1Pz0QunQMowDL5xh99RNPa6Lpoti6VgOq2kbNlzWGDHKJt
         2217qzVZp9f7C9X1HT06K/0ZwIFDA+/bc4+ozIMLuMN7KZXvYwWT3MUQU7BbXvn+Q80G
         VB4iijaeWvqR7utX1AVCpDEMioVz1MqdwsdI55LCykMlvmJnsu1r0gaXrCM2/s+nHN2F
         w74Bq5dqab+lNTdkUwO+OradoTlKxSK2rs1Fmv/ASPQo8W13UyqpveOqzA3LRZR7gt36
         QOIQmm0SCMO2rQuCMhrd8LFXX7K1E3N3DXwEe8Y+7ri3Bg6FqeLUb/zkgYdbh0CBLLNQ
         apOw==
X-Forwarded-Encrypted: i=1; AJvYcCWSCjhT0fR1Kek57Dnt+a0tl2BtHYrhLVDSiZ5iDIj5NolaLc2CpqkMUuuyUBu6koXiTEplOQMn3mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfQpT+IWFxJoht7dW0lmF7KmmqCwMFAbNkZb5UUZicF0sSQ2d
	8grgsI+EWm/icvetxFOpr1qYSyiRo9upk2251gcRUGTucCHD6P8bnThmXzSnPn4i4MDT0SHOvWx
	ZsyzYdmp16Rj0x6D9DP52EsLyKjRpdnw=
X-Gm-Gg: AZuq6aJmw8Q9f2CUv0iLhEbOS30CunrmjOAF0aSvq1IA4nEvdaCWAuSM/op5vmKp0MO
	r+/Yq4Lqjs9ec+gF2yGUYwF75CNGSUtmnqvKgc269eYBQMhA9E2G1niEGJRSDQu7KIZY9bmh9V5
	GHebihklf8hx/K0H1gDx8TB1iYi/BK7kg5SVOdJCz9IKg/+AlwOJ026/DeVqnv1MUVZPUWpTUkB
	1ZTgIxsXzf426q7kYFyqXaTI1sXRcRhMaWWxBJebe6aIfu/nqGJZ5Tfj3C06FPRHjN6kpUvsYgI
	icCQhdRN5i3LdW075GflAyg3M4nv9Z4BV7zpWw==
X-Received: by 2002:a17:907:8e95:b0:b88:50ea:f64f with SMTP id
 a640c23a62f3a-b903ce412bemr23014066b.11.1771381099947; Tue, 17 Feb 2026
 18:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com> <20260217235604.GA1595019@nvidia.com>
In-Reply-To: <20260217235604.GA1595019@nvidia.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 18 Feb 2026 12:17:53 +1000
X-Gm-Features: AaiRm51IyO5p1ZFm7PemT4PZZF2gD_mhc5e0kBVSJ5OU9yRJy4LX-SjwiRKMPKk
Message-ID: <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 9:56=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Feb 11, 2026 at 01:29:07PM +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Security Protocols and Data Models (SPDM) [1] is used for authenticatio=
n,
> > attestation and key exchange. SPDM is generally used over a range of
> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >
> > >From the kernels perspective SPDM is used to authenticate and attest d=
evices.
> > In this threat model a device is considered untrusted until it can be v=
erified
> > by the kernel and userspace using SPDM. As such SPDM data is untrusted =
data
> > that can be mallicious.
> >
> > The SPDM specification is also complex, with the 1.2.1 spec being almos=
t 200
> > pages and the 1.3.0 spec being almost 250 pages long.
> >
> > As such we have the kernel parsing untrusted responses from a complex
> > specification, which sounds like a possible exploit vector. This is the=
 type
> > of place where Rust excels!
>
> I was arguing for exactly this at a recent conference, so I'm glad to
> see it. It is a great meaningful usecase for rust in the kernel.

Woo, someone is on board!

>
> IIRC the netlink was my suggestion too, it really needs a careful
> look on its own. It is much better than sysfs, but comes with its own
> pitfalls.

It was!

>
> You might want to try to break this up into two parts, one just dumps
> a large text file in debugfs where there are not uAPI rules. This
> would let the rust work proceed.

I'm currently thinking of splitting this in 3 parts. One for the
ground work patches (crypto), one for SPDM (without netlink) and then
a final one for netlink support.

I feel that this RFC proves netlink can work, which is important. For
SPDM the authenticated syfs attribute is enough to provide usefulness
to userspace to merge that while sending the netlink later.

That way hopefully everything is a little more self contained, but
still has users and value to justify being merged.

That's a good idea about debugfs though, I'll keep that in mind

Alistair

>
> And another to introduce a proper uAPI for the data.
>
> It will be easier to get the right people interested in both parts if
> it is split up I think, given the size.
>
> Jason
