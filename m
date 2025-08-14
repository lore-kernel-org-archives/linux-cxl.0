Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0E301030
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178066; cv=none; b=pqKazO/CeFixXygwGUYF9UrTxnazY4dDK83tKfDu/lBg8yd98eGVUwmtRQQla0n/ms7a3PBer/xKJMyIhiLeXlal75BUpnLJ2lkXonHYwdQfm02AdokgD2Pg1E7BR/wpq9QYOoB+7YXuuiAlP1tBECt2sVteXNrqcXLjIwIt10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178066; c=relaxed/simple;
	bh=rKjVUqpwl17P+KMTSKwInqH48WkuPopBFLrzR8IYqTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpFdjo5J7pJTSKMKT8dU+KlT+GBe16HKwmqfJXWX3R3RzfdaNv4kwPd/CCuxX+n0WJnOjtRTkvIfNiqDsMGCDRGOj7fildpbe9zgG4VBXFZZbLCTe9AJrz7aqnx1QETEdIW4nQhzFe1B54o50eUUvUR0l7B52525TFpFnCk6iTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4HHrKOk; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4HHrKOk"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-617ff2c8e5dso10258a12.0
        for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755178063; x=1755782863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKjVUqpwl17P+KMTSKwInqH48WkuPopBFLrzR8IYqTc=;
        b=h4HHrKOk/liyRwlTPPppmlh/WxNqlJ/rjsHI4+m3QH59nseStSsmr4nijJwvVHPfPU
         wyIvvdX8POmOuzsWKIU2BxrieIaQlpKvn80cum50pjMucvXMrN2sHgTQONKZK/1G3A0e
         tFlOEurLpRNT59mNMzBfP262ZAvNCNsq5erG9oYPlBxwBjUPsc5ymUnP/TpK7ppwtnPS
         mcN+X9Szuqk8y2djPQVURUUwbZzswKYpj7ME2X5DNR69xw6UY/xjAX85yqxuBr14XEs4
         v5/npTkrryYL39bKpnHg8kofRE1EVJIJFQkuok9KqkS9Y6Udqb+0p8Ua2FnHGousuPko
         MoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178063; x=1755782863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKjVUqpwl17P+KMTSKwInqH48WkuPopBFLrzR8IYqTc=;
        b=oKh1CZHuPCXgGvgLg4Ek85R9Ck6rg2usuzj2cAMAm6CY8qLwfuwp7jSyjAlcQktr2e
         c2wD3qnG02EPlFEq2tMmqSQeNXsXLvHAFLd+CI5SitzXh/vppeQZLV9DwR3v2roCG8Tk
         1WkvLhpHa9EYGppc/Vqm9E3YlfxtdUvBzNgpCo/cKgEHAZpr7cuETHAH2L2gYYD+SsOg
         SdUrJU+w+vzlNPMKDaw1jCPN2CpNyGIGku9iIMuYyCMWyEVqxCDVDUs275JGLjSJlFzQ
         8LN/UaJwVXO7cA58V81eG51utAEspvqWBp7u5puD+ZLAc4p39rU0NdqCWK/hW7UizoDw
         wPxg==
X-Forwarded-Encrypted: i=1; AJvYcCU4i1aPe/S7/YqbiObKBpR8r2DyeNdPxfwjyDGMu9qw51g7a5nCJFQoPa23wyrq3aGKoabNXSZ3Xro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgQydgAFrGkK3wUaU9BlA8TxcKUV/fk5Kh3aZqbOCZWff//nTo
	yvi3RWny2+BdwqIZrhrjrvB7n6oGyekE05Qm9UVrsE5cX6UMS/Hz2oXBgseJds5ACwPmyUP4Oxx
	8ZC0C+fSUOwDS8xZ6XcCR7ILWHSx2UKz8UZvgA5b/
X-Gm-Gg: ASbGncs7A50bKQtGcTzFkVtUqMJQj8rjhDJVjAB+CnS3U4tOh1g0ANZFJJY02mbExCE
	2e+rSYdsSoLuIMAR2tb5J580Ty5jOwHR8fo8NjI8GTSERlvfnN7KNH4XTZ6h/txCMdfL294KWJ+
	F0EdLmF3DykdKDbM5ULd818mFmTe88LFu6QGMLCpNJ+G77be0nel70s2D/QxakjZT9o38DGLk+U
	caxJupy5LuI/UDbpTG0xTXyJO5dTL5Hz+rmqgC3haC/JAc0EnM6
X-Google-Smtp-Source: AGHT+IEu9U0pbzMYFCpXzMGkMdfavpp0q0i1lIx9CK73KOosqb3zwB/n5//3FMTW4AWTjYRn2/rUlEjYnuedieOKxqk=
X-Received: by 2002:a05:6402:c1a:b0:617:b4c9:4f90 with SMTP id
 4fb4d7f45d1cf-618928d1bcemr49916a12.5.1755178062489; Thu, 14 Aug 2025
 06:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612114210.2786075-1-mclapinski@google.com>
 <685c67525ba79_2c35442945@iweiny-mobl.notmuch> <CAAi7L5cq9OqRGdyZ07rHhsA8GRh2xVXYGh7n20UoTCRfQK03WA@mail.gmail.com>
In-Reply-To: <CAAi7L5cq9OqRGdyZ07rHhsA8GRh2xVXYGh7n20UoTCRfQK03WA@mail.gmail.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Thu, 14 Aug 2025 15:27:31 +0200
X-Gm-Features: Ac12FXyHou1fyJhNDgAZDR7CRUt48o6SkCf0niifqm0hDvHBUXmlc4ifrrlM40Q
Message-ID: <CAAi7L5djEJCVzWWjDMO7WKbXgx6Geba6bku=Gjj2DnBtysQC4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] libnvdimm/e820: Add a new parameter to configure
 many regions per e820 entry
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, 
	"Paul E. McKenney" <paulmck@kernel.org>, Thomas Huth <thuth@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 2:05=E2=80=AFPM Micha=C5=82 C=C5=82api=C5=84ski <mcl=
apinski@google.com> wrote:
>
> On Wed, Jun 25, 2025 at 11:16=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> =
wrote:
> >
> > Michal Clapinski wrote:
> > > This includes:
> > > 1. Splitting one e820 entry into many regions.
> > > 2. Conversion to devdax during boot.
> > >
> > > This change is needed for the hypervisor live update. VMs' memory wil=
l
> > > be backed by those emulated pmem devices. To support various VM shape=
s
> > > I want to create devdax devices at 1GB granularity similar to hugetlb=
.
> > > Also detecting those devices as devdax during boot speeds up the whol=
e
> > > process. Conversion in userspace would be much slower which is
> > > unacceptable while trying to minimize
> >
> > Did you explore the NFIT injection strategy which Dan suggested?[1]
> >
> > [1] https://lore.kernel.org/all/6807f0bfbe589_71fe2944d@dwillia2-xfh.jf=
.intel.com.notmuch/
> >
> > If so why did it not work?
>
> I'm new to all this so I might be off on some/all of the things.
>
> My issues with NFIT:
> 1. I can either go with custom bios or acpi nfit injection. Custom
> bios sounds rather aggressive to me and I'd prefer to avoid this. The
> NFIT injection is done via initramfs, right? If a system doesn't use
> initramfs at the moment, that would introduce another step in the boot
> process. One of the requirements of the hypervisor live update project
> is that the boot process has to be blazing fast and I'm worried
> introducing initramfs would go against this requirement.
> 2. If I were to create an NFIT, it would have to contain thousands of
> entries. That would have to be parsed on every boot. Again, I'm
> worried about the performance.
>
> Do you think an NFIT solution could be as fast as the simple command
> line solution?

Hello,
just a follow up email. I'd like to receive some feedback on this.
