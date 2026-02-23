Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A7305046
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861899; cv=pass; b=Q0/OG6rI8f/NZbrfVKL7p0DxHbLgfE4uX1aBQsiXDqbGWhUmEif1VTlSFUt5+4jyeMFuE2lBl5NmfTchBH1PmZrTFCWOFjt18gRY5KfPod8Gz6Ld1YCpwTA+4YEuv8czcYCYePMlcslU8Bhab4Y1GP5S4niPWMYZ74gXSGgp7jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861899; c=relaxed/simple;
	bh=d5zCa3ysNLijKNaGOI7tuajauNFQ8GHfuuwERS7PUF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUtrEeD9TQbRRpjAf2bcyAsAb+e9DxLmPmkX4BVE8fohck9zLPysQuxAwVvjuE1tjGBbNEJ7jgvRqdB/Swdlgq1IvwyQoXRppdpkPvKXuQufy+YqsuB//czZQf71IoVya2822HglEi87DukvWRRKX3PTuKL3l3dMYEJZedqAKbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bez0+ejt; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bez0+ejt"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f86167d39so567861766b.0
        for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 07:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771861896; cv=none;
        d=google.com; s=arc-20240605;
        b=Jzo0Nyq+uMqTJ2dMzEX80ZGG88emPdZhvZiAPyhVMAfFMxOEn5hsygACc0EXhh5dor
         rS8T/RHSkeMVvWkKZPvAKpUs//4iS7C7fjnbViFnc0Wl9QtVbrLl29ZIPY0TvM1GAMwP
         hdN288AzDmH5s8TFcrcyj/foz+zduGFrlUnI5dtDOl0/jcI4Etn7t9D6EAZJod4h06eT
         0rv0NrDqI6xlWUXrXdcekthMEVaJ+EP0Om9NQGwHcUAyOJ9v1tsmCF1p7JhFW3xpEJu6
         lkVIBB75HYt5Art0R8Ao/J10BSkOdVaIK4LyXviJsP2E0eiMWmMdK35IRAZA/UvskkEP
         3tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=npGY86N71VPo4TOfv73Omx9yZ3z0Eb9N82/SaZDWxbc=;
        fh=l/5xcxP6IkJmfsq4oEzeJ/7U/DxvJr87JTHS+6iU6j4=;
        b=IPROOaVCUcyphch9SCtwX45M/TQ2WeBsGk8/f/I2Ud6m9Xwyl4QyKgxq1jHpOnLiWp
         JZUuG2SyiI7Cn9h34XP4XxSpnfe0N7130uRgELrfgZfyQ0TDl04zw+N2pSvB1DHGQfdR
         6dvTrz82n3t5/xlYb/9YIUK0Yv966gMmLY0VfcuF1hW8KiqlIIxtNZIanZ+oj2Sg+01S
         ADsOAWjb+iKTXqy9ZKDbVJp3SoE3qta4RsLq56NLM5D7NSfA8irDfXiajnALqmnGMg7C
         HnFXTK1s0qYpGqv72mD9rX/a2BNU5AFIWhA1JUD0YwTOAN2wRjWNZf10cBbXAbiJxKMI
         h5Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771861896; x=1772466696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npGY86N71VPo4TOfv73Omx9yZ3z0Eb9N82/SaZDWxbc=;
        b=Bez0+ejtvpYWPD6Kti1bkjLrHh/4ih0eYIM0CLxjHJVlyC5lHQHjEKF0CNkHaDuEqj
         cX2cnDEAf7qRrLs8/C3MibBqjq4NnO55kbXTfuH8/Nxx6jwnOMpahcd+BT6S/CdCi1JH
         KUJtx0cspJycQjPwSfacE7jXqTjOKa2T5ILFwWyAwyTfTP05EQrGoHDnILUdu9FWad3o
         qbEmW4NoUFk3SaZ6xWr4LES3oxs34gzL9jKWeuyFPeI3DkWSJDZv4Gpd6GKXlNwQMJpf
         nVxvrZuxvOrPFJhe7ZUNsnwKzjKRrU4q7YjLGxGI51cWL7miac2P1Y9+lB0iWh/Q5Nv6
         YUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861896; x=1772466696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npGY86N71VPo4TOfv73Omx9yZ3z0Eb9N82/SaZDWxbc=;
        b=TOIO+j633n3pgvF8HOnYrGZcfAXcAj/Z8wgsat8paWXHibQO3+hoClLRJA8EWjUfu8
         ECAHXHD6OOWJ5SwsdlYYeIGoZw/fzcftnYM1gUv2XNeOHSz1+cEAGJPyYtbpiQk5A2Su
         u5KICDDcDerQpVv/fWZxnYz9Guf6sMidIMvsm8y7iOHoLsvMV8JPP9YaLWh8LD9czP9c
         TGRXAgiRKTDC5qvXftd+rSI5OCzoDeww1UN2tR+8sD1FCO1wdJW5AfZYIIIT46aqF1ww
         fplbVTTluenPDxi62nUJa5M3m+Mbczqkcli7Ej0pRs5sOajGcukDXLwD+aufhrKvsMJD
         Z4mg==
X-Forwarded-Encrypted: i=1; AJvYcCVzuluW/4BfWiaH/DMAEL1xZKs8UP3NQwVVzfqi9ogkwp+1dFbW7V+h0GsHix1zHOm8JwIwZ8AkQCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwudhaZSF8F4X6ty3QNmwS7Qqn3XQ+kK/qsFdzoY7LmkaOTe9jE
	+ksYaaqjdqhm61MLK7HjeJ4DUgnF7Dnqt9of9EsDWr5nL8nePgK4snq//7TAA/IcwtxeMKt1snA
	zKAY68+mnT8iAzBRm5O/56gXfnqWfGAc=
X-Gm-Gg: AZuq6aJDBWO6z2uekzjKo2KfwGYHjjUrmdpk2hNHKT8j3SBj9YvpWhW7+zPAd1VkHkW
	1A26IVJ7s85iMC+qf1AIFyF9HGPurU+R8Wcc7/C8tvfqAkmZLjKayV60izC9mt7GdYOHdqq+2yV
	9tGd7JTnOWEk9UYSz6tJVZ79gXldzob4ux0TIGqVEox8UmN1V6M+1ay5GCGOGFXzh9nLhHVCEs5
	UeFMGY5QRoNKp6SpdMUfYgmQ60kYZBZRCRY1dGNR9wuEeKExv1/Hp8dp26ni+Ox17wrfwxGxpgx
	mQdDba/aKyUIb0vIZNlc+wNcV0QpnnA/+wtZnunyh9+qMffaivW4EHU6voIX6ax5R73JPFrS7du
	xAS4IxPY=
X-Received: by 2002:a17:906:5ad6:b0:b8f:e424:ae56 with SMTP id
 a640c23a62f3a-b9081badd6emr413937066b.44.1771861895691; Mon, 23 Feb 2026
 07:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Feb 2026 17:50:59 +0200
X-Gm-Features: AaiRm51McMZohKyigNQFIbQDImiJ8vF_g2F0DjapyVKPe6Rkgx4x17MorqEdw1M
Message-ID: <CAHp75VeWD5A0r7-Uayyte1ZXXxdhLixd+z_y0xNeki0N+Ro=jQ@mail.gmail.com>
Subject: Re: [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector management by
 removing devres auto-free
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>, 
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, Even Xu <even.xu@intel.com>, 
	Xinpeng Sun <xinpeng.sun@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Longfang Liu <liulongfang@huawei.com>, Vinod Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Maciej Falkowski <maciej.falkowski@linux.intel.com>, 
	Karol Wachowski <karol.wachowski@linux.intel.com>, Min Ma <mamin506@gmail.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Andreas Noever <andreas.noever@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Will Deacon <will@kernel.org>, Xinliang Liu <xinliang.liu@linaro.org>, 
	Tian Tao <tiantao6@hisilicon.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Srujana Challa <schalla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Antoine Tenart <atenart@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Raag Jadav <raag.jadav@intel.com>, 
	Hans de Goede <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Robert Richter <rric@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-i3c@lists.infradead.org, dmaengine@vger.kernel.org, 
	Philipp Stanner <phasta@kernel.org>, netdev@vger.kernel.org, nic_swsd@realtek.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-usb@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-cxl@vger.kernel.org, linux-crypto@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, 
	mhi@lists.linux.dev, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 5:32=E2=80=AFPM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> This patch series addresses a long-standing design issue in the PCI/MSI
> subsystem where the implicit, automatic management of IRQ vectors by
> the devres framework conflicts with explicit driver cleanup, creating
> ambiguity and potential resource management bugs.
>
> =3D=3D=3D=3D The Problem: Implicit vs. Explicit Management =3D=3D=3D=3D
> Historically, `pcim_enable_device()` not only manages standard PCI resour=
ces
> (BARs) via devres but also implicitly triggers automatic IRQ vector manag=
ement
> by setting a flag that registers `pcim_msi_release()` as a cleanup action=
.
>
> This creates an ambiguous ownership model. Many drivers follow a pattern =
of:
> 1. Calling `pci_alloc_irq_vectors()` to allocate interrupts.
> 2. Also calling `pci_free_irq_vectors()` in their error paths or remove r=
outines.
>
> When such a driver also uses `pcim_enable_device()`, the devres framework=
 may
> attempt to free the IRQ vectors a second time upon device release, leadin=
g to
> a double-free. Analysis of the tree shows this hazardous pattern exists w=
idely,
> while 35 other drivers correctly rely solely on the implicit cleanup.

Is this confirmed? What I read from the cover letter, this series was
only compile-tested, so how can you prove the problem exists in the
first place?

> =3D=3D=3D=3D The Solution: Making Management Explicit =3D=3D=3D=3D
> This series enforces a clear, predictable model:
> 1.  New Managed API (Patch 1/37): Introduces pcim_alloc_irq_vectors() and
>     pcim_alloc_irq_vectors_affinity(). Drivers that desire devres-managed=
 IRQ
>     vectors should use these functions, which set the is_msi_managed flag=
 and
>     ensure automatic cleanup.
> 2.  Patches 2 through 36 convert each driver that uses pcim_enable_device=
() alongside
>     pci_alloc_irq_vectors() and relies on devres for IRQ vector cleanup t=
o instead
>     make an explicit call to pcim_alloc_irq_vectors().
> 3.  Core Change (Patch 37/37): With the former cleanup, now modifies pcim=
_setup_msi_release()
>     to check only the is_msi_managed flag. This decouples automatic IRQ c=
leanup from
>     pcim_enable_device(). IRQ vectors allocated via pci_alloc_irq_vectors=
*()
>     are now solely the driver's responsibility to free with pci_free_irq_=
vectors().
>
> With these changes, we clear ownership model: Explicit resource managemen=
t eliminates
> ambiguity and follows the "principle of least surprise." New drivers choo=
se one model and
> be consistent.
> - Use `pci_alloc_irq_vectors()` + `pci_free_irq_vectors()` for explicit c=
ontrol.
> - Use `pcim_alloc_irq_vectors()` for devres-managed, automatic cleanup.

Have you checked previous attempts? Why is your series better than those?

> =3D=3D=3D=3D Testing And Review =3D=3D=3D=3D
> 1. This series is only compiled test with allmodconfig.
> 2. Given the substantial size of this patch series, I have structured the=
 mailing
>    to facilitate efficient review. The cover letter, the first patch and =
the last one will be sent
>    to all relevant mailing lists and key maintainers to ensure broad visi=
bility and
>    initial feedback on the overall approach. The remaining subsystem-spec=
ific patches
>    will be sent only to the respective subsystem maintainers and their as=
sociated
>    mailing lists, reducing noise.

--=20
With Best Regards,
Andy Shevchenko
