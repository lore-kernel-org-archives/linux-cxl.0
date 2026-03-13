Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C1383C8E
	for <linux-cxl@vger.kernel.org>; Fri, 13 Mar 2026 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398176; cv=pass; b=fVs1vbdexpQ6NWicKyT0a9PkhK5fvWFWpt0TT0AGOtRKGwYXz7W0rPYxVvF3emJZz2/1PaqkJZaTpDRBWU+mqog5cB/dvyGAlBrxWn3ORFeIoCpXLx1Z+43toS+YlV3hAkJlPOU11695dUo38EEEcC7A+BOoKiGcZ/D5miNBIHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398176; c=relaxed/simple;
	bh=8g5q3C7nsRWNNtihsDdWzjoOptctN5Xc2r4pN5gjoAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npwCgxwFRt2lLPcfuR2vq1Oygj+M6p/7TIH9eK1g+a99W/SXwk/dOntJlntVUWzajvZLjSFR0Zy2OdidrhNW/d/7KPNakYA9q669iGIRtp4l1WFlkC/fiWr2XDRi3TFv6u92dIO8RnPq2OsRFnogQDMN+eVKqz50mzENPXgKEm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/1tPuQ3; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/1tPuQ3"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1587147f8f.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 Mar 2026 03:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773398173; cv=none;
        d=google.com; s=arc-20240605;
        b=OA8eiLZMv1VUxi4XzOpCqf1orijCwr0Ys2zk91wskvwk5cfE+NhZwh6r2huolgYza2
         NUjiYAlCxzYdhQdMEquOR7OdMWz6khgwC4e94e5OmOqo76Gw8PpjOGzZTFESY0Ivcktv
         6wMMA22xz5Lm/6G8jfMOPU4IM4KQegsmkID0WY1pDyicej3T+qEp7KpF4rCYDnmulWOW
         ZkkP1/3xllht6HVL6U8s1PpqUTmqKtbW3YPwKJVSAJlOWHBJa3/TNHDXZwV+FTAbvUSX
         dxGrFcLBVZkIwxTIV3uEfe1AJTeMwpUmtpW6r8taJLgcZ3SKksyr0ivsmiHI+380umzn
         zSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/w5DLUFTZVMWmc49ACjqJvi6te4AWIx+IOTh3G/EERU=;
        fh=dH1LvrX/lAJu4jAQROcY7c9q2s2n7xt+8sJQ25xpwIc=;
        b=hcr5mGesfudmNUIdXjgjdnt0G96zraWsqyRZ/oqFMBQPhnjgY6k5Pm6oW/ORi/Brnz
         71Moewo3iwr5nSAUONge5DFOXcmw7jI0LKmDRtX0nbJazmVPPNLZWJ6sOR8nXVJSejQj
         0j+IiZqZCnOqTJPhnDHRZuydA2xmkCpa93QeMWgOONn/Genj8F4uWrou4iGG9LxjO0Vf
         v4h2OosIutUJ0P4B7jmKejEmAgsJbH+dGyCj8khAcXKB2bSPOC0pgR0qp7u3A8tXddOd
         6D49/4JGoKYgpArcklzn/oqocidbGvdtgw4zkc0lP0wghAeyt7LH3FLuRpL9WBT+PaD0
         gtzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773398173; x=1774002973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/w5DLUFTZVMWmc49ACjqJvi6te4AWIx+IOTh3G/EERU=;
        b=s/1tPuQ3pvsnKiJ6NNFhcZW2U162K2KIl9xpqvLj/XgXR/hzWGHjw+T+wEh0ksRAR5
         X8F7nrxs4jRGj8G3aySYrvo6DG181oe1CAQRq1qGYhzoiDzvh9/+I4JNRZ1eg6EgU7/2
         uxNgZgBoeZtsckXPw4XrAVqpqmkawRqwzW86M6FntDSDFhk6cjWBC+PAH8migQrBygPq
         ypsK1cP8k5ZpAQM2PqWZGzQN3pTmJYAMpBhDgNyta2YFNkEyjcTLLI6P1uXTaW/P+WAU
         Nv9qjdzBGh1kzjQ0rTIuTFcDB1J3NkJeQ7AHL6op9a7rz+MD1KgNrQ20QaN+K1joYK47
         n19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398173; x=1774002973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/w5DLUFTZVMWmc49ACjqJvi6te4AWIx+IOTh3G/EERU=;
        b=H0hZ6cUwNUbFfkaeItbLhxspziSCcZszzinnLhoBl8ScUWyGLIHFpNhWhzoMQLF6ZJ
         phX33XAwJ9848I/HV/qYqD55AcK9vJOJ6IjyEiRqy7nWz7HcxGixKCI9mJ3cp3mtUuZF
         4JQmeDw2vatnLc/605l4wYohLZMOoeMIqIOx1njw31BXbHA6eH/zIFaq9ZDnRFky3e9N
         H/Ob7UesoVBD1lvg/iXMFoVtTDZe1g/VG9lvVW+mHs/Aeg+Y7v9YN2oS9fKpNf3nP1m9
         G0KrzBY8mZrcqGIo5meLXkdVkkJUvkJtNGdtqd5IHP+5717mFrv9O/qTKwtAZ7jBhId0
         ESRw==
X-Forwarded-Encrypted: i=1; AJvYcCVqJ+VGiCloLC0SU9QYGdEKti7OCC9Jgzlqh8z6EEqgkQFKB4XzbdUA+cHWnf5UhXRqUWrdfaNgGoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVZo9Q99gQ8ziYP/FXLNNQ+7J9OUpf97HrDwJhRICxAF7cPmvs
	VE5FJ8gIlotdt/LWRRnD1lZlisAmEa/n72wO70ftRvu2qKjYWanXrzj9kqfD8k45/oLG3uL8Mnh
	YdBfLvJe2ZmwxMn+Nl5gEfRtJYXOBN9W76HiP/aeW
X-Gm-Gg: ATEYQzwe6psANrbtCKXqsJmCSYN1WYys8lUfUIhYHZ5hw0PZy492me46TGZQgI+yNAe
	VlPaXj2GWuFKe5+IXMRRSxviXaHBy6q3uvU45E0DUw0LU5SrxuLtk6s5jZCfiulm99Gw7fM4HMb
	otBs1jOVHG7vHDhwWPZDBRKt8E57AaQJIKOy01eR9gfbnkWAFoY/ETUQfTl18ZFaHRkUUHZU/l3
	DKxZQ8iSV3wqn0ikjrr1w5Ug/Wzw/9CGJqm1Wcu6ErSKuTc7Ivirzliqg5kbMXWfDj+jJDHbNSa
	Q7OzQSdD72OIu+y1fyvMeisGyvXgPu/H26IkjYI/NGthnus8LrAgaWvmA6u4mbwW6GQbsQ==
X-Received: by 2002:a05:6000:2903:b0:439:d7e1:fc51 with SMTP id
 ffacd0b85a97d-43a04dbeec1mr5539039f8f.36.1773398172510; Fri, 13 Mar 2026
 03:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-8-alistair.francis@wdc.com> <8403c8b7a832b5274743816eb77abfa4@garyguo.net>
 <CAKmqyKMXmn6=suyjhB3Kq12-UHuLbPLOHPd2JO2b3Nxn4jYHpw@mail.gmail.com>
In-Reply-To: <CAKmqyKMXmn6=suyjhB3Kq12-UHuLbPLOHPd2JO2b3Nxn4jYHpw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Mar 2026 11:35:59 +0100
X-Gm-Features: AaiRm53JNqGQ31WbLp4l7arJWG84T-kzONXay54ApMwLtspn9NZSDJv5HhHLQcU
Message-ID: <CAH5fLggOnVguVErjySphX__vs3iYAo4O+J6hrXW546JrWSq5ZA@mail.gmail.com>
Subject: Re: [RFC v3 07/27] rust: error: impl From<FromBytesWithNulError> for
 Kernel Error
To: Alistair Francis <alistair23@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com, 
	a.hindborg@kernel.org, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, wilfred.mallawa@wdc.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:20=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Fri, Feb 20, 2026 at 12:49=E2=80=AFAM Gary Guo <gary@garyguo.net> wrot=
e:
> >
> > On 2026-02-11 03:29, alistair23@gmail.com wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Implement From<FromBytesWithNulError> for the Kernel Error type
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  rust/kernel/error.rs | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > > index 258b12afdcba..569d9d032ab3 100644
> > > --- a/rust/kernel/error.rs
> > > +++ b/rust/kernel/error.rs
> > > @@ -12,6 +12,7 @@
> > >      str::CStr,
> > >  };
> > >
> > > +use core::ffi::FromBytesWithNulError;
> > >  use core::num::NonZeroI32;
> > >  use core::num::TryFromIntError;
> > >  use core::str::Utf8Error;
> > > @@ -251,6 +252,12 @@ fn from(e: core::convert::Infallible) -> Error {
> > >      }
> > >  }
> > >
> > > +impl From<FromBytesWithNulError> for Error {
> > > +    fn from(_: FromBytesWithNulError) -> Error {
> > > +        code::EINVAL
> > > +    }
> > > +}
> >
> > Are we sure that `FromBytesWithNulError` maps cleanly to the `EINVAL`
> > error code?
>
> `FromBytesWithNulError` means "An error indicating that a nul byte was
> not in the expected position." [1]
>
> To me that maps with `EINVAL`
>
> 1: https://doc.rust-lang.org/std/ffi/enum.FromBytesWithNulError.html
>
> >
> > Anyhow, please add `#[inline]` for such simple functions.
>
> I can, just noting that none of the others have `#[inline]`

I think add #[inline] to these could be a nice easy issue for new
contributors. If you want, you can open an issue on our github.
Alice
