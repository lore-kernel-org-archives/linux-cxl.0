Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5823F2111
	for <linux-cxl@vger.kernel.org>; Wed,  1 Apr 2026 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039863; cv=pass; b=Wj6/J1Y7JUBxXa+3gOU149RgWXlxKM1diOP1qLDQk1YH52rPpKSxqrDlioBOngVsKeCuddkw0tykSMyCu9PjDmuQgAfNoKbizJMq0+558LZpImNx4KFr9F/Js+52wAv+4sc+91clssQi0vxSNiMuORi2KyxtuOLZycZ64LQMdNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039863; c=relaxed/simple;
	bh=NB7IgTsm5fAY1HRxukcTkg282cMT+NcIa7BPVwXaI4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGnqeafJ17rLqldTmlF8C3hPD+oqKArVOsY9ZmOriG646pyQmOZcSVvdjWTzENMNAFB1tuI/Bdv2SOf+YE0RK0CoVylW9COM0SIYFb8wtbrLrO672imF5H+L8k1/YtIGTSmwl4L1mXHd1IqRqhIfLXk59fa4AUpVLKi/8B5kggo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV4MJZUe; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV4MJZUe"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2c47a327cso34659e87.3
        for <linux-cxl@vger.kernel.org>; Wed, 01 Apr 2026 03:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775039859; cv=none;
        d=google.com; s=arc-20240605;
        b=UPzI9aRXsnyhzudNpNimEp3qIcfxWEOqDMF7I957gAjdU0GkNHbSKlKg7F99UuJ9dj
         bjLIURRvsKbufs5Y5zePr7kBE8IAbHrkUhbPkY/5U0NXvNYM8S1qCXYH3skQJ+GCc1cf
         IuSsjz7MVPGZhUkWx3tj/IrYgDn/LWVKyGngjs5fdWbYCJuBMYMO6sFn4y8W+TiIPQta
         Z96RbaVxdm4UmyMulo9j97+xG8NVDvAx+kk/0tkr4hFeVwzuHLsc22NHv4S+H/thiBtI
         dY5vwyFTX35KMsfWtd1H6fsUmNyTQ5CFxYH/kFtETM5zKwHCumR5DRuR0yzzXk2wpdYP
         z6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VOv6sQrE1pMcWIiRRePCMC/GRfEX8gOaFbZKQ7PwRiA=;
        fh=2UuS5Ir0x2L+jDnbjT/V6vKyNihGqtqudSX2vIkjXBk=;
        b=R7VV+ugJ2YhP8HS0dkhvi+dYdzZi2YBOvkzJlIF6nTm3hswtBc/rIgL4PhaQTlqljn
         GXBaFt07hetuAIuampHuZMGvj/6sgWPlYxVkboae05jyOpeuGPTGg4+0HaEr4FgBZYD9
         QgKZXTzut4DE4Xvj3tSnQ5dyekKpn8arAlpP9e2upSMz2X32eL1OgzRtN/0+sJMW62D8
         P3jBbszIl3QD49xzjd6V/OqYqH16kDzPMOQ4eY2A3099qxhDPekPN5Jw10498Yxoq4z1
         1SHXZgPyteNALRyf1+WrOEKipFX237+1hxkEAHHRKXThnlhlh1lQ1eSW4/u8aAIjPcNr
         8W2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775039859; x=1775644659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOv6sQrE1pMcWIiRRePCMC/GRfEX8gOaFbZKQ7PwRiA=;
        b=PV4MJZUe6fk484cZO4W/xaPmqcNtTaWfVnuaPvOycgHWLcjwfiVSFv2g01d5SgmkGY
         cG8c7ck+6drc11/+l9jE2IUVKfo9LeNaHp7M7pReSwj4N6o9tm0VSVtcVRBbr9Fk+k75
         T5aHs7N7Bf0bnfCIlOBMMv266XqCQHj1z/ZZbTxTLppyAZj8w8V9JStkAZKeRmEL7AyJ
         Gm0UxLN/3rwmZvRnRonxAcNCcixLoXmE9raVWYd1jPMeKAAFNXppSaKHfIt0krHlGs6i
         Ag4MpoICZkTddJ9vJ3DQRg/6G5mB7MZ1KS02KblwcHxj7v/Q1i8nMlgZx7fmjD/zRBzx
         X+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775039859; x=1775644659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VOv6sQrE1pMcWIiRRePCMC/GRfEX8gOaFbZKQ7PwRiA=;
        b=l9+6ObhyNK1bci8Gt7ZRe3ysm40k7JvJHw6Bdi6BNAJaXzWjI4M3vNoQwlaqHXdIK1
         Em1Vxj2ZBUttEj3HfXLdmwsdTyO55DtLc0mjTkSIFqbjZ2uhqNbN67VDgEXLIJZMkR1U
         nlXYgSGBEkcx/eD8LqvtkTquwEjQKglDS2d/RuuZX4eUNB+Y4PPEvsIP3aHYwBRkrtTq
         aUvG9J6i6pQsQiRmdxEt0kYPjt78OZFpvbSHzK/jbhkNYFDrGPGdpkR6t7vM8xWExGbL
         KlQ0cIMpvsWtxulGO/5HqPmuP9bGtNv2dM6Yy1pRJukxrZeNpxaKqBBTcUlFXa4W8NJR
         f5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqQAi5mw1GBIDmWK2mt07WgtxIdF6FXVtNc7otaorS5CPzgVjjysB6tetkcTvL+YgTDl0XcuZp76A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UAY4npWjHKDhE3ueB9lbTTrwsmyi02ru3FiRtG66SouJfhY7
	MYYImIBrSeqe1Xfbn+zI/Vyb45B1+1hxP/fjxovcUrXnV/SA7b4eDD4t2BzdqM9Qq3cF15a0xxi
	RwrfSzhWX9XgvnhznZsSs/S83fvapN+o=
X-Gm-Gg: ATEYQzz1uJ2U8y0DOjhlZAcXhBW+ZKf3M/6bcHu7SYBmCt9XaTB94GK0bK6WzxhNgX7
	reGVZ4Gn0B+D0Nmq9Wwwq6762bVGrRMvaMbg56btlHvMEcuUD9kZk749uIw2qF18oPOhO/Nd3a1
	wr5yUYl0iJWmJUqXzskOL3O04EtYp3WYPV2S3cp9+KzJMCVGBEs3pgsoMcwXjfoeHqiDQJ+kyzb
	2jczT5kA7h4taKKi9mplhK9M23ZCr8GSorGzloaniygLpERB25hTf2BbG6W+idp7dDD6eyD1WVT
	MBjHnPHXcgg5acciuUoJKzFEtoG7GgSnrL5nqKc6D2LYZEmcuW6L++Y8hpUKQ7GzCFaPV+NzLkK
	pwg8NJ7EgodOHWmJbrPnJ5O8=
X-Received: by 2002:a05:6512:1093:b0:5a1:2ec0:7442 with SMTP id
 2adb3069b0e04-5a2c1ca6ad7mr571822e87.0.1775039858363; Wed, 01 Apr 2026
 03:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-23-alistair.francis@wdc.com> <20260303150040.00007458@huawei.com>
 <CAKmqyKM6CBucDEo0aKZVWrKtozbT_ddk0PaZFtHyEMMMx558JA@mail.gmail.com>
 <CANiq72nOt1E8=GYdh2T5BWNvG7J8sZRF+60taghoxKm8fkadHg@mail.gmail.com> <CAKmqyKPa5fDmo1A6OzF0ROn7iTrBrhV1Q2L=1Wkb=o27f5fDSQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPa5fDmo1A6OzF0ROn7iTrBrhV1Q2L=1Wkb=o27f5fDSQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 12:37:23 +0200
X-Gm-Features: AQROBzCtb7kxhE58oOSjFtnvKeq8ygzpCG4EYIkaMQYWrhFl3CKqeEv1E8oqMJc
Message-ID: <CANiq72nV3ArhtQoQYbX-cRKM5JjnqVtzP79c43q+eJjbANgONA@mail.gmail.com>
Subject: Re: [RFC v3 22/27] lib: rspdm: Support SPDM certificate validation
To: Alistair Francis <alistair23@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 3:48=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> I think it's Rust-ier as it uses the fact that
>  * if statements can be used as expressions, which is a cool feature of R=
ust

Sure, but a feature being nice doesn't mean it is idiomatic to apply
it in every context.

More generally, regarding cool features (whether in C or C++ or Rust
etc.), I would say one should strive to keep code as simple as
possible, i.e. we use fancy features when they buy us something, not
just because we can. The kernel applies this principle too.

>  * Rust is explicit about comparisons being bools (no `if (value)` for ex=
ample)

Yes, but I am not sure how this is related.

> So I find the if statement expression returning explicit bools very
> Rust-y and easier to read

If you mean that that seeing `true` and `false` may be clearer because
it is more explicit, then that sounds OK (whether someone agrees or
not), but it is a different argument than being idiomatic.

In any case, I replied initially because the code should be
Clippy-clean, and currently we have that lint enabled -- does it not
trigger in your particular case? i.e. even if you have removed the
code, it would be nice to know why it didn't trigger, or if you were
not testing with `CLIPPY=3D1`.

Anyway, if you think it is idiomatic Rust, then I would suggest
discussing it with the Clippy folks, because they have it as a warning
by default.

Thanks!

Cheers,
Miguel
