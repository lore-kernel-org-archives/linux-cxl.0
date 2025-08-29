Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0E42056
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435250; cv=none; b=Rh1rQv69j3s68Zsk7px+QPzGlgUcxLcbdSUS74NW+SiFHxALKsaYZ/tOFYAmS7ajwxfEPvY1G34gSe6+CLaXA7XVkKnFA+lKMUJpXx0Hxubv5BQQkxrMlDYyJjT6UQYaibJ1slV7ddzsZUn4QYyPKycpQhGOOLelY3zKD0R4kEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435250; c=relaxed/simple;
	bh=1rc25cTIqjjOz8QUgkVtPyp6ikf2DOOaXB7T4eWd4qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzSzdDKVx8U3crbVfoHs46YYCUWVVf5Jy045e5t3/stWxgrpsa+e+VCWu2Nj+aMxjXNc72r9Ev22wWdTSKgWIljrkyqj33E5TLL6loA+PPrFgXXlEJs85GuxDJMXmjbxogy5EsLGueRdtYqgw/R2AmxLd963IX/xATDpUZYtzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=AhQqxK7D; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AhQqxK7D"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b30d09da3aso3580731cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 28 Aug 2025 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756435248; x=1757040048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Zy6qlRujNRvsanVAYiBzYvZ4C5MT/ROGnbV1WkURNs=;
        b=AhQqxK7Djehs0IxZA9g5x9qdRwPs8gD5+88GeMJ9K41QotLivA+FYALXHlZBt492pA
         vZUFRPqCGIUEA6BoS2ZreCNXI/QMoHUiYbRIfyX705mJfuPu2xBcEMzZL5AY6IgIRFRU
         n1K/I6bWb/sBq6KADaK5UaHuejtiYYZlkQZHSPqgbxYyiuaFZo8lz/+F5CqIZYyR6kOU
         7R/ySZGWxOXhnuUltRaIKJJ38f1d/ItzJ5/dewq54chdZvoHD5BHJ/GhDWOZp1QtwiMF
         2owZ8n0baVZhixwrZfCTvwQ6kf4M/Gi1GNgn2jLizQueM8YOYlfvGKRKURm2Z9T0GupF
         gVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756435248; x=1757040048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Zy6qlRujNRvsanVAYiBzYvZ4C5MT/ROGnbV1WkURNs=;
        b=uG9KB74fzAmk3CNvNm9FtDYlZabjov5ZDcGUK088yr8/QPqtm5hMkpqXOLowwv4uQ+
         G8bNeX9lWyOo6uzyAle+5Whu20ot/B65WXwZyQ38vsbNVVZ4LDYPgV2VIJNzjA7ZZMdc
         JI0LX5Iq6uwRGBNjJVvCixOk738e7eumg0CfnFqcYLKvkr0nHcuu5fbLuk3psRH4CHZf
         0XCGWhmRwDXqavAxgH5316F+V/IwtWLZjJutkDk2IkPYvAETJIdP4yVcj8GUryaTEwts
         dI4POiSejIL6tBmRk+5icos9ZUt0i62g6+jBIZpqSVgGDNRQYIUX6BjWF26Dc0pmZjJW
         rhmA==
X-Forwarded-Encrypted: i=1; AJvYcCWNfo2FbMmndNa4DFIuDs0KK0HtNtVl2ipftgQy5O4y/0kWws0jXlTVMSCySYpf7mrht3TebodJLVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDJrBcoaLfCsl6RHbr/l25P7rjti54F1igajl0vJBM+GG3kQq
	lwtKTKW534on/W82lpY/bhZgMffFpFmc07zKta1ga/Eecvw/MnlUsecvjrA7Xr/ZuMnrZ/hDev1
	b5+7ZbAYHx2TYf+aQrvgTB1TQkH6bXVF17ITsV2aXmw==
X-Gm-Gg: ASbGncsfoaiarkc1aEZ0IM3gzf/PlFE7bAcMSHo2GWcOaxTNCjEJ3BLPMAckmS8JtbP
	kjHMwt1S4aOAtecTkhNpwy5Y8v1aCATzV4XjEMn0d71fr36hNd2Wiasq+FyTebEUkeszuq4MHF5
	iZmKnir5ZfizxGjrIQ2yMIXdvn/C0KLwR2j3AtKIF1Zn5A9cpZjbTSh1mRa/g1D8onqp1WGilti
	MO1
X-Google-Smtp-Source: AGHT+IHwXj+LBZuJEcqAH63FcF7Bf6gg8caP9O+PnQGOchIvb5/XFjh6XaIc3WnVFKQjw020TTzcQhZZqWvU0FReMKg=
X-Received: by 2002:ac8:5e49:0:b0:4b2:9ac2:686e with SMTP id
 d75a77b69052e-4b2aab4a159mr308961841cf.77.1756435247854; Thu, 28 Aug 2025
 19:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612114210.2786075-1-mclapinski@google.com>
 <685c67525ba79_2c35442945@iweiny-mobl.notmuch> <CAAi7L5cq9OqRGdyZ07rHhsA8GRh2xVXYGh7n20UoTCRfQK03WA@mail.gmail.com>
 <CAAi7L5djEJCVzWWjDMO7WKbXgx6Geba6bku=Gjj2DnBtysQC4A@mail.gmail.com> <68b0f92761d25_293b329449@iweiny-mobl.notmuch>
In-Reply-To: <68b0f92761d25_293b329449@iweiny-mobl.notmuch>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 28 Aug 2025 22:40:11 -0400
X-Gm-Features: Ac12FXwmgsLWCvC9t_zrDymTIu_H7ymCFDa4DGCwoCVIx5lOzsb8sPf1krkiuUE
Message-ID: <CA+CK2bAPJR00j3eFZtF7WgvgXuqmmOtqjc8xO70bGyQUSKTKGg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] libnvdimm/e820: Add a new parameter to configure
 many regions per e820 entry
To: Ira Weiny <ira.weiny@intel.com>
Cc: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, 
	"Paul E. McKenney" <paulmck@kernel.org>, Thomas Huth <thuth@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:48=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Micha=C5=82 C=C5=82api=C5=84ski wrote:
> > On Tue, Jul 1, 2025 at 2:05=E2=80=AFPM Micha=C5=82 C=C5=82api=C5=84ski =
<mclapinski@google.com> wrote:
> > >
> > > On Wed, Jun 25, 2025 at 11:16=E2=80=AFPM Ira Weiny <ira.weiny@intel.c=
om> wrote:
> > > >
> > > > Michal Clapinski wrote:
> > > > > This includes:
> > > > > 1. Splitting one e820 entry into many regions.
> > > > > 2. Conversion to devdax during boot.
> > > > >
> > > > > This change is needed for the hypervisor live update. VMs' memory=
 will
> > > > > be backed by those emulated pmem devices. To support various VM s=
hapes
> > > > > I want to create devdax devices at 1GB granularity similar to hug=
etlb.
> > > > > Also detecting those devices as devdax during boot speeds up the =
whole
> > > > > process. Conversion in userspace would be much slower which is
> > > > > unacceptable while trying to minimize
> > > >
> > > > Did you explore the NFIT injection strategy which Dan suggested?[1]
> > > >
> > > > [1] https://lore.kernel.org/all/6807f0bfbe589_71fe2944d@dwillia2-xf=
h.jf.intel.com.notmuch/
> > > >
> > > > If so why did it not work?
> > >
> > > I'm new to all this so I might be off on some/all of the things.
> > >
> > > My issues with NFIT:
> > > 1. I can either go with custom bios or acpi nfit injection. Custom
> > > bios sounds rather aggressive to me and I'd prefer to avoid this. The
> > > NFIT injection is done via initramfs, right? If a system doesn't use
> > > initramfs at the moment, that would introduce another step in the boo=
t
> > > process. One of the requirements of the hypervisor live update projec=
t
> > > is that the boot process has to be blazing fast and I'm worried
> > > introducing initramfs would go against this requirement.
> > > 2. If I were to create an NFIT, it would have to contain thousands of
> > > entries. That would have to be parsed on every boot. Again, I'm
> > > worried about the performance.
> > >
> > > Do you think an NFIT solution could be as fast as the simple command
> > > line solution?
> >
> > Hello,
> > just a follow up email. I'd like to receive some feedback on this.
>
> Apologies.  I'm not keen on adding kernel parameters so I'm curious what
> you think about Mike's new driver?[1]

Hi Ira,

Mike's proposal and our use case are different.

What we're proposing is a way to automatically convert emulated PMEM
into DAX/FSDAX during boot and subdivide it into page-aligned chunks
(e.g., 1G/2M). We have a userspace agent that then manages these
devdax devices, similar to how HugeTLB pages are handled, allowing the
chunks to be used in a cloud environment to support guest memory for
live updates.

To be clear, we are not trying to make the carved-out PMEM region
scalable. The hypervisor's memory allocation stays the same, and these
PMEM/DAX devices are used exclusively for running VMs. This approach
isn't intended for the general-purpose, scalable persistent memory use
case that Mike's driver addresses.

Pasha
