Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C628CF49
	for <linux-cxl@vger.kernel.org>; Wed, 31 Dec 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767196188; cv=none; b=lU9tSOhugVQM3E1q4ll9RmE0qW90Boms4V6QAKKA8vr7MJAahpI3rRTyJ8qs0hEZM/UqZsgbYRSLagbOz1wM2ryEshEEW5fvwMqLDoPMMmkh/IjvyB7QPUM0uwChGP+sZlQrbNne2III9jPSyjpoisMIWxJNzo/aAxUyQeHdRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767196188; c=relaxed/simple;
	bh=3O2pKoi3Hwirhh0+J04ChOJnDVUiP3w0hlE8zKMOybs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPBXIxZhvX1fdwySwbHvHcw2qkFlHI+/g3KkBcJ8sKqJRTgyoZYF1i2MS86tX2lFWNfOZw/LehZUyA9l2fjKobEb+GEZP3V2luomyifhypCKwoHka12WMn+/LPxXkfIUgeFDEjfKNB+Q3C5uP0W80JlKM+BM3lIbDBDVpWuAd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2mBtzVR; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2mBtzVR"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b81ec3701so17436521a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 31 Dec 2025 07:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767196183; x=1767800983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6r7yw9l553CBnZ0Oq6/Kvj3e3aIbXAlTRdm8Qc8sow=;
        b=k2mBtzVRSH1v+FGKxeSAlmrpoWJXHRrGk48w1hRSCCe+VJ02bBPiRZANqhLbXR2hOY
         21EyUlifjsLEM1xVf7OaJZ4iu4dIVgA20ZoP7Cq8CpTWrjZWh1QDQ1BWcQjTafZgZEqG
         x6ytaO0jlKRb6Mf+R/ITTbD0YqfAkioqr0gj4YHlF4ga4ax0mckcgaZE4aljhudBNybJ
         KOKmnhZiYOw4i8T9WFUm2qI08zlv1FS9OSrj2KblI4Ym88f7dxhWmAhoUlxE0sjMDeCY
         8AIReZEkVs2R+Y/ApvqNJsTv5vZot/ZOaI2Hk/ccXAtkHRBXtm9S44o2QsdjPbWS2YRi
         C5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767196183; x=1767800983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6r7yw9l553CBnZ0Oq6/Kvj3e3aIbXAlTRdm8Qc8sow=;
        b=d+ZT/xZtW8bqGz1kueMLOOIDhsXRai24BSnHwPyd02Xlp/ZSohn1tWoB+PtA0tOwWC
         QBEoMkYiiL1RvMfj0DPIo4LRjHWMFASLBUQzzmoGdm5HaYlmu0iaSHW3GkLa1JnCuunX
         Jm5FgWsS8V7wrABHeBx/ni+bq1E88O8iqoMq6g1kn7HS+jlmdG0nM8XU5w5Sc3BDTOHd
         vVt0vkniZhNqbiIbGQGt18AnFzYExzg/ZPWwCJfY1Ig62UDbrKpmbWLan/kSOFzU9+Ap
         magUK3DKzva/t1yBKZq0ZgEtQ8gv+OX66NEw6DH/kzKn80VR0GI58HPCxP9ZmRVxlCoY
         d72A==
X-Forwarded-Encrypted: i=1; AJvYcCUhaalT78NUGfTrkwqYVbzmdGEBFpmESgDOE2YUMgPdvnvsj/doxaMV9WxWiKTvF4HdRZ0QJM/4Zh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykKt5KMMQ8PDZ+PexR7FgmcmUSc04EqNRnMFsXTYXAAjpJrHPq
	6isMB1rBdCxDDv97Ya1ZYUThJqD+1GaB5jpXnPNGLV6dEEMIirUSI/zv8Yd7bEgsmT4MPyWx9w3
	CqfUjBnXSQBWkGo7vSSHTaMb4CmIw8tw=
X-Gm-Gg: AY/fxX4yZ/XkuJrCkgiDmxtiEPnQPCZGzt5i6IYjl2+q7dQcs7b950QyNkjcVSYE3bc
	7yAre6tLyXFfkdWG+NLXvGIFmwLO4IdoVr9QpdFfkydcX7eCpTnV05x62ZYNnMLgvEwZQk0cXV8
	anfFxaNnDilC5p9NjKhWD7aaTQu9ySgN21QVqFVEjR/zDbN3z3F7taL2XUA+EaCsXnMod6jJ01L
	eV9l+YxY9PFs2S/OG/MWsGbDxRDASI7xr/FKIo0NbZPMPzSdaOo4I2ozDTATuUrnDkRFT5c
X-Google-Smtp-Source: AGHT+IFWPXcZKnGq0Krk9SV9S7c2h0pNtpTmEWv1Brc1vDiv5zIRm5JUQPWxix5qBNEZM9fT8eFcchz/mGnlgfTZ7QQ=
X-Received: by 2002:a05:6402:430d:b0:64d:170:7976 with SMTP id
 4fb4d7f45d1cf-64d01707bacmr33060451a12.16.1767196183052; Wed, 31 Dec 2025
 07:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228124001.3624742-1-rppt@kernel.org> <20251228124001.3624742-2-rppt@kernel.org>
In-Reply-To: <20251228124001.3624742-2-rppt@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 31 Dec 2025 16:49:31 +0100
X-Gm-Features: AQt7F2rayRHt2K_8t_heYN2h4Fxse0t-QPEGBzoKWlAlrWu2fr6sWsAyLE9oYEU
Message-ID: <CA+=Fv5TDfwnu7Qf2y=PLWWN1EvNpNbr8habnTO7R4_caAySDzw@mail.gmail.com>
Subject: Re: [PATCH 01/28] alpha: introduce arch_zone_limits_init()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 1:40=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
>
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/alpha/mm/init.c | 15 ++++++++++-----
>  include/linux/mm.h   |  1 +
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
> index 4c5ab9cd8a0a..cd0cb1abde5f 100644
> --- a/arch/alpha/mm/init.c
> +++ b/arch/alpha/mm/init.c
> @@ -208,12 +208,8 @@ callback_init(void * kernel_end)
>         return kernel_end;
>  }
>
> -/*
> - * paging_init() sets up the memory map.
> - */
> -void __init paging_init(void)
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfn)
>  {
> -       unsigned long max_zone_pfn[MAX_NR_ZONES] =3D {0, };
>         unsigned long dma_pfn;
>
>         dma_pfn =3D virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
> @@ -221,8 +217,17 @@ void __init paging_init(void)
>
>         max_zone_pfn[ZONE_DMA] =3D dma_pfn;
>         max_zone_pfn[ZONE_NORMAL] =3D max_pfn;
> +}
> +
> +/*
> + * paging_init() sets up the memory map.
> + */
> +void __init paging_init(void)
> +{
> +       unsigned long max_zone_pfn[MAX_NR_ZONES] =3D {0, };
>
>         /* Initialize mem_map[].  */
> +       arch_zone_limits_init(max_zone_pfn);
>         free_area_init(max_zone_pfn);
>
>         /* Initialize the kernel's ZERO_PGE. */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 15076261d0c2..628c0e0ac313 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3552,6 +3552,7 @@ static inline unsigned long get_num_physpages(void)
>   * free_area_init(max_zone_pfns);
>   */
>  void free_area_init(unsigned long *max_zone_pfn);
> +void arch_zone_limits_init(unsigned long *max_zone_pfn);
>  unsigned long node_map_pfn_alignment(void);
>  extern unsigned long absent_pages_in_range(unsigned long start_pfn,
>                                                 unsigned long end_pfn);
> --
> 2.51.0
>

This looks fine to me from the Alpha side.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
