Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B0285418
	for <linux-cxl@vger.kernel.org>; Wed, 22 Oct 2025 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177247; cv=none; b=mNLeWdCldx38BYdNDwXELjddS5gsLFcbDuZhLRNJxkUjW5Td0BV0j1qwJzA+P9siBoJ2gA7g8n9pfTH8/AtLyYTUo8p76n05r9tDUgVI0YTh4nKqYMKsnaTDWL/nEzIv6pOLS6GshY1jxSLMKBcgl6sHATPqhMRfQ5dNnzZ7A7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177247; c=relaxed/simple;
	bh=nO5DHKyBlotpTFhDE7x2Z/A+Jp3/mi/ndcWWH+QPYVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szQ5MalW/PrEsw1kaKtWrcVXwzo0Q5p4t4XotXTfFM1awueCJ4+0OslLT+HzEhRXSrX37FrFEuB28ylRTfTJYADcUhw7053QxO1m0oxOWwuSaQPXgnG7TA+dDlAaUpgA1R4iDr7RwwgGOuM8nFK0LtZtKBOzVHuIQRBKBxBZkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AAzY8Fy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AAzY8Fy"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so2718a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 22 Oct 2025 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761177244; x=1761782044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6RHQchnkCCZHFiL1DU1wWeMfjedF3ffXwGFW4DpStk=;
        b=3AAzY8FyDWSAyHIOLBp5xsus3et6haNDeh4BaHTNFjcxZ1izUQlL5zbxywDHi6DUTi
         BED/9KrewQeuwQGlb65WPgK/tFgtwLBeVZ29KYt7yqMX/o8yj/BXz5ROZrl7EgQtBWCE
         +vqAdgr2+v6QqG8CClWu8cNvhZQwBg8S5kNofZIBN8V/SztOZ5GFDBuCX/uve92sPuEK
         jYWzI3u4zSwCRsb03yHqLIAhBhhozq20oeYrcOe3BWN7ZnylG7B9l3OduQ1+gQDRu2QQ
         Unx5rXDMnS7YdszEMyhkuQYM0Jvyo0nDEZ0l8/pRd2c0XJAUzv/0MpNranEZJGhdWqMZ
         TTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177244; x=1761782044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6RHQchnkCCZHFiL1DU1wWeMfjedF3ffXwGFW4DpStk=;
        b=k7m3cpWZtGyDY4euONCG/3P1u0jIGu24KtwCUcClmTOwXjytH97D3qzTKoifiiRv1J
         bMRSMUk+SI9t6mP6RUlI3fLERHckR9D2ILN0k5dsQyL8xJ5fJPf623uw3aCpGNF5wRO3
         JDiFTg1/802jmVSvoXTHVu6H480wEPto/tSklAhBoPcEcLlDI5UVVo4jHfvyFsr5w+/R
         tsJ2TAm5PPj+JHvFjrQxkgEO7C0hLJFKpKMePCKNdpsBeAiWFspNE8w8dSwUJzddcsV4
         QClLzR9u6cqtFqfV26Fdmv4mEZs/EvauX8BTZGLFc8aJvZ2uwiceHRWHifuwXk5DYvvj
         AW9w==
X-Forwarded-Encrypted: i=1; AJvYcCUhZozi0+Se+A4bx3Bg9WTzr2O0zzANofQlQ/uaIN95FVekbhdHqdtz8I9OaLa1WvNGu2LVxmiYFM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nRjl5+ndMCxVvyhIhynrdnqU/SnZDTiV+0ssIfjk/eYhrKLl
	Fq4Q2fhW/eD4zFSONKLtaPz7rnWua0DEq9Yjd6SOfSc6UekyM7tfoXbzTtAGh/IEhzMpTaEIv3N
	Va0rtgffjMDXKIhmZBDi1OwJJeKVgAHgqiz48c/f0AyluYYDoOLy2XjUNnTcu7kSA
X-Gm-Gg: ASbGncv4OgREEN5Kh8ZmRtcTFJdTaEvHSDBaVyqZQCcjHdSE0i8NB7VAYXq72NC0EUZ
	xZjOf2CmpsHD3vlrsWYv1nDOH5hZC2w7s+NXrIQV1eemtujwyMxwJAR9xv0SPbdqFj4JbZKD8Eh
	EmvRALGiUNqMxiz2pmGpE7Q+NHXoRPOQloJ/ZzPDe7I37nkUECNvfTRF2n6LkiTH8kMy1i2iQBs
	xwjD6h6fZbXKOjL9zfILzao2pqyMYJPh1wcoPwO828KIHLVtyv85XlvLAUyoyRWBccVOns5q9av
	9MhgPwNo/FRfmGo=
X-Google-Smtp-Source: AGHT+IEWd9FR9gKb9Zr14FO/SKIlqzxl6oi295G5iTkBVXoZe00E7i9wXEgtTQAijiYV0qbtiq+FZcMar8NwTFkA0k4=
X-Received: by 2002:aa7:d519:0:b0:62f:9f43:2117 with SMTP id
 4fb4d7f45d1cf-63e38faf5f8mr36697a12.0.1761177244223; Wed, 22 Oct 2025
 16:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002131900.3252980-1-mclapinski@google.com> <68f96adc63d_10e9100fc@dwillia2-mobl4.notmuch>
In-Reply-To: <68f96adc63d_10e9100fc@dwillia2-mobl4.notmuch>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Wed, 22 Oct 2025 16:53:52 -0700
X-Gm-Features: AS18NWAykxizA4pVQXnJ4CA0IxhWYm4ch5MzN7bzmvn3HrW8QsvVciVZgzdKZZQ
Message-ID: <CAAi7L5eY898mdBLsW113c1VNdm9n+1rydT8WLLNJX86n8Q+zHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
To: dan.j.williams@intel.com
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:38=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Michal Clapinski wrote:
> > Comments in linux/device/driver.h say that the goal is to do async
> > probing on all devices. The current behavior unnecessarily slows down
> > the boot by synchronous probing dax_pmem devices, so let's change that.
> >
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > ---
> >  drivers/dax/pmem.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
> > index bee93066a849..737654e8c5e8 100644
> > --- a/drivers/dax/pmem.c
> > +++ b/drivers/dax/pmem.c
> > @@ -77,6 +77,7 @@ static struct nd_device_driver dax_pmem_driver =3D {
> >       .probe =3D dax_pmem_probe,
> >       .drv =3D {
> >               .name =3D "dax_pmem",
> > +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> >       },
> >       .type =3D ND_DRIVER_DAX_PMEM,
> >  };
>
> Hi Michal,
>
> Apologies for not commenting earlier. When this first flew by I paused
> because libnvdimm predated some of the driver core work on asynchronous
> and has some local asynchronous registration.
>
> Can you say a bit more about how this patch in particular helps your
> case? For example, the pmem devices registered by memmap=3D (nd_e820
> driver), should end up in the nd_async_device_register() path.
>
> So even though the final attach is synchronous with device arrival, it
> should still be async with respect to other device probing.
>
> However, I believe that falls back to synchronous probing if the driver
> is loaded after the device has already arrived. Is that the case you are
> hitting?

Yes. I use all pmem/devdax modules built into the kernel so loading
them is in the critical path for kernel boot.
I use memmap=3D with devdax. So first, the pmem device is created
asynchronously, which means loading the nd_e820 module is always fast.
But then, the dax_pmem driver is loaded. If the dax device has not yet
been created by the async code, then loading this module is also fast.
But if the dax device has already been created, then attaching it to
the dax_pmem driver will be synchronous and on the critical boot path.

For thousands of dax devices, this increases the boot time by more
than a second. With the patch it takes ~10ms.

> I am ok with this in concept, but if we do this it should be done for
> all dax drivers, not just dax_pmem.

Will do in v2.
