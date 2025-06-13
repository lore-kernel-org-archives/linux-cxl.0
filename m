Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909F20D500
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830858; cv=none; b=uHanImgQ6TQk6KvHtXrEyqa6msbCdTCwjlOQz5rUshP+3LnQ7CMuJ9AWFnBSm7eSprFxoQjA4kw03ZaNXP7yjIrx37c6JNst+L0OqZO67MAyKy/YA5IOS8j1plA6w5xB2sFSFZqC51AqzbcaoEGuorhr28Hac2d1MTDsXGqn0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830858; c=relaxed/simple;
	bh=Poau7ySbx2NqlWmbbAixDa7PGO3c5xJsHamg2eHlQJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYR76DoWQpYq3c9NCuZ0zMN2NSsLil2KWpGgNvRgL+M1EXn03RwkFf1+83wRyx5lDa9rIQQg9+D4elUUBW8d42nG1gpG2f3lgIFDSfpemau746L7wRf2v4WSwLEglq+FEV/t2tUasFho7MAMz9aca/3+4fKTcRd6prdMil8KefU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wxc9hrze; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wxc9hrze"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ff4faf858cso15768247b3.2
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749830856; x=1750435656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=runPSHNnAiofURFB4Prnk+4ZgiuQj3pP6BD3srb8FRw=;
        b=wxc9hrzeVBB+A+wqvO3ZZcu86vK249bhAC+/yrj60SYvCYUgW0hxY0fkylMfRPJyKe
         L5ze+GAwpTDxIZFigNhho06Q6QNLRjQJZegiqbONgbzFope8CeYLVcp/1i4nzS1FxEii
         rYRSSf5xyDG4I47DjcmeyFduJ5kv0kT70zXPsc7sQngdyryjQSjvPVINKRjErL4d7ySV
         oSyk25oz+/Zl253uDwPdM+SRpJw2mOgEz0p7PSoDhbbr8nLTxXkrdRcMovlB2GZNBhYg
         XfUoZIKUlqeT9uSu34duLzf30Jh1rRmDa7ay/fc9dl72dMS6+Lm/5fi5FKCi/h+Tb7M4
         WvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749830856; x=1750435656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=runPSHNnAiofURFB4Prnk+4ZgiuQj3pP6BD3srb8FRw=;
        b=TvfM15BefRpqnGapwDeKFVn68U2JaXgX0bOa+Rka5v2M3wjMK4Iq8/bCPRUmU3dNBa
         AYRztSEx2gQ2SasYsIxahYQymWa7DE7OKzKgL1GepTsj9Qp7JcpJgqwzlT3Mw0Fe+TDc
         DBTu4VNshKpWPVZs88z3cahXJC+UimpxxNZ6q3F2Fl29OSQyzIQy5AKR8KJyw5enLKwx
         11cUPKetkWuoZYQmeUBJQwbx6ct+YOKcZMO631WeE24Wfb6Fz5MocdHIvjFe2Nu/Ow+S
         H47DFHfcZxucs83jf0T/vgItO3xdySDg1hMhR8pRoEj+ZFVInN3Lhf6WEnncjdn1QUsP
         Cl7g==
X-Forwarded-Encrypted: i=1; AJvYcCVzKM90/a0Ad8MFMV6OhSfcnS4UrXD7lPQOS+icQLxlLQd0s7Obeco78BwuYDC8tACeC8bHnR7n3j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKknQOuwNj0kTKJjCXqxnu2SzgVueOUGzo8oX7VMiQ6LVzVdXs
	TDeMeKLcKxbQ3qbAkpV8lCKUdlRD7c8TsZ7EaNqq8I27EyeL80neT+cypZ59u8seap+8badUVgj
	vKLWljOtHY2GBzwfqcEu8DK7/ioJsHJDQprZ0TA5OOA==
X-Gm-Gg: ASbGncv5ckDTcDLf6ABNFuCrMtvYMQdk3ZvzgcC+60muSQZ81P2qgvkhg/AQoD4xSKn
	fHoBnDE18+fbGeO6k11pX1AvOykuGegGtZWd8MMnhJysUJ3coljucbFBNZqwe/StXKtqFmD1SxU
	YyxfBiXifNI8M718fboVFoQnzGSMVeOOOV7JVzoSf6dwaO
X-Google-Smtp-Source: AGHT+IEt1SN6zbIZVZJ7Z2S/c4snZBWEGwekLPATt6rzh8CCPguf80eGpk0hQhWJ4FCS/m9fqbYDVpyBHmqiFVV4ea4=
X-Received: by 2002:a05:690c:968e:b0:70e:7a67:b4c5 with SMTP id
 00721157ae682-7116377cee5mr52563887b3.36.1749830855766; Fri, 13 Jun 2025
 09:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-4-Jonathan.Cameron@huawei.com> <CAFEAcA-J+vAGfEV67PezA72rUiqpuqTBT=8hJLc1sw+xo3XHWQ@mail.gmail.com>
 <20250613162054.000003cf@huawei.com>
In-Reply-To: <20250613162054.000003cf@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 17:07:24 +0100
X-Gm-Features: AX0GCFsd8mxMT-w2iPsLlVwEKMHjA3lJ8J7CkRV_0qv7wyH083gjLI13UxLyzBI
Message-ID: <CAFEAcA9dHc8werChGk_HzXWsxqv1E4==iDPxRtCmPe9Ndr7nmA@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>, linuxarm@huawei.com, 
	linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Alireza Sanaee <alireza.sanaee@huawei.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 16:20, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 13 Jun 2025 13:57:39 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > Code based on i386/pc enablement. The memory layout places space for 16
> > > host bridge register regions after the GIC_REDIST2 in the extended memmap.
> > > The CFMWs are placed above the extended memmap.
> > >
> > > Only create the CEDT table if cxl=on set for the machine.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > ---
> > > v15: No changes.
> > > ---
> > >  include/hw/arm/virt.h    |  4 ++++
> > >  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
> > >  hw/arm/virt.c            | 29 +++++++++++++++++++++++++++++
> > >  3 files changed, 67 insertions(+)
> >
> Hi Peter,
>
> Thanks for reviewing.
>
> > Can we have some user-facing documentation, please?
> > (docs/system/arm/virt.rst -- can just be a brief mention
> > and link to docs/system/devices/cxl.rst if you want to put the
> > examples of aarch64 use in there.)
>
> Given the examples should look exactly like those for x86/pc, do we need
> extra examples in cxl.rst? I guess I can add one simple arm/virt example
> in a follow up patch without bloating that file too badly..

That's fine too -- if the answer is "all these command lines work
for aarch64 too", then you can just say that in cxl.rst.

> Is the following sufficient for the board specific docs?
>
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index 6a719b9586..10cbffc8a7 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -31,6 +31,7 @@ Supported devices
>  The virt board supports:
>
>  - PCI/PCIe devices
> +- CXL Fixed memory windows, root bridges and devices.
>  - Flash memory
>  - Either one or two PL011 UARTs for the NonSecure World
>  - An RTC
> @@ -189,6 +190,14 @@ ras
>  acpi
>    Set ``on``/``off``/``auto`` to enable/disable ACPI.
>
> +cxl
> +  Set  ``on``/``off`` to enable/disable CXL. More details in
> +  :doc:`../devices/cxl`. The default is off.
> +
> +cxl-fmw
> +  Array of CXL fixed memory windows describing fixed address routing to
> +  target CXL host bridges. See :doc:`../devices/cxl`.
> +
>  dtb-randomness
>    Set ``on``/``off`` to pass random seeds via the guest DTB
>    rng-seed and kaslr-seed nodes (in both "/chosen" and

Looks OK.

> >
> > > @@ -220,6 +223,7 @@ static const MemMapEntry base_memmap[] = {
> > >  static MemMapEntry extended_memmap[] = {
> > >      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
> > >      [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
> > > +    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */
> >
> > This is going to shuffle the memory map around, even if CXL
> > isn't enabled, which will break migration compatibility.
> > You need to do something to ensure that the CXL region isn't
> > included in the calculations of the base addresses for these
> > regions if CXL isn't enabled.
> >
>
> It doesn't move any existing stuff because these are naturally aligned
> regions so this is in a gap before the PCIE ECAM region.

Is that true even when we have the maximum number of CPUs and
so the max number of redistributors in that VIRT_HIGH_GIC_REDIST2
region ?

> > >      [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
> > >      /* Second PCIe window */
> > >      [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
> >
> > If you're OK with having the CXL host region at the end of the
> > list then that's a simpler way to avoid its presence disturbing
> > the layout of the existing regions, but you might not like it
> > being at such a high physaddr.
>
> From what I recall a higher address isn't a problem I just wanted to not waste any
> PA space at all so used the gap.
>
> Chunk of /proc/iomem with a random test case (in first case with the cxl bits
> removed as obvious that doesn't start until this patch is in place).
> Need more than 123 cpus to make the second gicv3 redist appear
> (I've no idea why that number I just printed the threshold where
> it was calculated to find out what I needed to wait for boot on).

It's 123 because that's the most redistributors we can fit into
the lower redistributor region. (We didn't really allow enough
space in the lower memory map, which is why we need this awkward
split setup.

(I have to run now, will look at the rest of the email next week.)

-- PMM
