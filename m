Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861329ACFC
	for <linux-cxl@vger.kernel.org>; Sat,  3 Jan 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767472353; cv=none; b=OikmAT2VMMWsMOwAivFrNqI1ENFPCTCT7mWTOobwZR6tXozXFHPLLL2hNFfQfANXkgRhZO1Wz2p/RWXdnW/YPg+3gSxog6h/ftBK37XRnSnuwcDxq/z/pbobqht79TT31FYbt5OOhZvasl1QzUXjajypQ9No6pf0td35M/nK/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767472353; c=relaxed/simple;
	bh=5+oEr/jkE5oCGIkGYrJbM3CWVfRfPAoBvVwyUQAaYAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7k5DKc+VFAV6ZSWAOD0lXJiDZTzBp0XQvA37BKpkfUfZHwFRpztd5IAmMgkmZYog2KZ3MluHY1cGInzcfaO2mFkmLkkvh0CzByupnPDvBVPAE2tKXPUCSHL3rpGDWVYaXFKJAhlPaJjMVJXd5EA5l4TSPXKXweJ7I+5CoJitns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejbGoY4L; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejbGoY4L"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso14666176e87.3
        for <linux-cxl@vger.kernel.org>; Sat, 03 Jan 2026 12:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767472349; x=1768077149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7o+8V3bXuMIGcHyQUku83CYs/vu8fbyRY+Gob8yvlG8=;
        b=ejbGoY4LrhGPxJndjspwkhg1RJ7ngxIoasWTIht/eGDKL0kbU9RuvlBH87ylNbKK0n
         7wTRMRpAJHD1Vfq3qplk/w7C343y9MaczuoM65VJss23su+4gOtkdNwAj7Kd8KOZ58te
         1RCcgNNNZro874ZR7NlsPDg6xkOHJksmX2mT9JJpRXRv3zxMiBgUGhL/BQdxIhnCfu74
         oesFnVRuk4gm6uBGemxin/5/DkJ4DrAZtcCKkIV0eBPyWgX5iyJH8sxwHhQ/KmSt9CPo
         OdK3aeW3sf+GB6fA/2J0vkj5dpmxk1vEWkktTB8Osxx4vhPoQrEMudRf4WBZZ5pFwccd
         0rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767472349; x=1768077149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o+8V3bXuMIGcHyQUku83CYs/vu8fbyRY+Gob8yvlG8=;
        b=IcDR7Tv6iBVHsqu+REel/eWVrme/7kwZl0Osk/vy2O7W+shsFWjBF14zsJpg2VGBN2
         xowhDKAwV0yIvo+d4CLYux+XVn9fMWpdRGvgiW9h0kL5pQ5AlBh0/s3ckdvoJVvQjSkH
         sOgX5E4Sln8gQQbjivjyyKlFWg1tHM5RXxm8bxBy84PPcfV2LsEa9xUrZoRviIkf5zKN
         /edgWLJZHpOe63CY2/+8Hq56BDhrkMjjRZLZYxsj50xBaBSzcisz2aljrLjNswdzyi93
         YdKoh8F80Xz4i4GECGCT+3c+kyRailLDx3IDvbsUq/KFs5lehHS7vF0rwWKJwJ30caab
         Rk3A==
X-Forwarded-Encrypted: i=1; AJvYcCXny8yTJw5J90kquyfW2YnC0uca61i/IvlEyrIrBIBiB/NZFspAsrAPN7j0BPs7fiIVzgAkZDOya8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD2OuSIDsPNKPYQ/eMxS8m3eDVvSAHgFTb9FG6SF6mcM9IXMs1
	voUz28NzxhBScfmgUa1HV87C8dMao8iQYknU3qKetT+ggdxhUtMFLp5+
X-Gm-Gg: AY/fxX5nxtAItTHa+P2TQ3SD/4olv//5pmnu713TAkECmeDzV2xo1h6Qi0q1ZOhcBPf
	Hl+b1RFQ/xnNnnnGBZ5Z+FHChI9qW1P6BDSvQGLX155NPAcJCdtRUoGdaER9hq3cpB3Xxa+hbiC
	QdgBnrkl4yboRoHNQzaFLOBz01TzU1T34MaK9M/uio/oyi0LohT9PPZUVOaSsLA6A41cVl+kH5h
	UBzZQBTj+KHnctfKQ0areLwwy6vnVrgHcnqztMTnQrPVrwrpizdKoL39humI0CpdNFZws6CZvQm
	+P4at2Ktx7fswQEdz/M9kyYLYTrr0oG/GIF5dXQ9U16RxT5cScVfVjTw44KXjAUM9zH/8kEEQQj
	QJS5pwF0Fpzniu1llgXdjcZDwe/8Yvr4k29f/wHEXtaF6yjcyU044w3UI1ZACHxWOw2y3NKG+GJ
	LQ0ycFH+hUyBQP6iBFXtDWMrzVpGtvZW6PlvJ8wFG+Qg==
X-Google-Smtp-Source: AGHT+IEnoPR3bLjgiHz8V/D0bqIfe+KGL8qN+8iViiiSSYeZJp9K5TsXzLfWqe+YE0ZXBkQi72/slw==
X-Received: by 2002:a05:6512:401b:b0:598:fabf:afc2 with SMTP id 2adb3069b0e04-59a17d77697mr15522207e87.14.1767472348240;
        Sat, 03 Jan 2026 12:32:28 -0800 (PST)
Received: from localhost (parmesan.int.kasm.eu. [2001:678:a5c:1204:126f:f00a:513f:807b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185ddc12sm13314957e87.37.2026.01.03.12.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 12:32:27 -0800 (PST)
Date: Sat, 3 Jan 2026 21:32:26 +0100
From: Klara Modin <klarasmodin@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 22/28] arch, mm: consolidate initialization of nodes,
 zones and memory map
Message-ID: <aVlwOyicOLPB9SOa@parmesan.int.kasm.eu>
References: <20260102070005.65328-1-rppt@kernel.org>
 <20260102070005.65328-23-rppt@kernel.org>
 <aVhN2NgQEKe0yzva@soda.int.kasm.eu>
 <aVll339wim7dCIaQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVll339wim7dCIaQ@kernel.org>

Hi,

On 2026-01-03 20:54:23 +0200, Mike Rapoport wrote:
> Hi,
> 
> On Sat, Jan 03, 2026 at 12:33:29AM +0100, Klara Modin wrote:
> > On 2026-01-02 08:59:58 +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > 
> > > To initialize node, zone and memory map data structures every architecture
> > > calls free_area_init() during setup_arch() and passes it an array of zone
> > > limits.
> > > 
> > > Beside code duplication it creates "interesting" ordering cases between
> > > allocation and initialization of hugetlb and the memory map. Some
> > > architectures allocate hugetlb pages very early in setup_arch() in certain
> > > cases, some only create hugetlb CMA areas in setup_arch() and sometimes
> > > hugetlb allocations happen mm_core_init().
> > > 
> > > With arch_zone_limits_init() helper available now on all architectures it
> > > is no longer necessary to call free_area_init() from architecture setup
> > > code. Rather core MM initialization can call arch_zone_limits_init() in a
> > > single place.
> > > 
> > > This allows to unify ordering of hugetlb vs memory map allocation and
> > > initialization.
> > > 
> > > Remove the call to free_area_init() from architecture specific code and
> > > place it in a new mm_core_init_early() function that is called immediately
> > > after setup_arch().
> > > 
> > > After this refactoring it is possible to consolidate hugetlb allocations
> > > and eliminate differences in ordering of hugetlb and memory map
> > > initialization among different architectures.
> > > 
> > > As the first step of this consolidation move hugetlb_bootmem_alloc() to
> > > mm_core_early_init().
> > > 
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > 
> > This breaks boot on my Raspberry Pi 1. The reason seems to be the use of
> > page_folio() when initializing the dynamically allocated zero page in
> > arm, which doesn't work when free_area_init() hasn't been called yet.
> 
> I believe the reason is rather the use of virt_to_phys() that now happens
> before the memory map is ready.
> 

Right, that makes sense, the fault just becomes apparent when
page_folio() is called on some bogus address then?

> > The following oopses are generated:
> > 
> >  8<--- cut here ---
> >  Unable to handle kernel paging request at virtual address 003dfb44 when read
> >  [003dfb44] *pgd=00000000
> >  Internal error: Oops: 5 [#1] ARM
> >  CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.19.0-rc3-03898-g7975b0084358 #451 NONE
> >  Hardware name: BCM2835
> >  PC is at paging_init (include/linux/page-flags.h:284 (discriminator 2) arch/arm/mm/mmu.c:1790 (discriminator 2))
> >  LR is at paging_init (arch/arm/mm/mmu.c:1789 (discriminator 1))
> 
> ...
> 
> >  8<--- cut here ---
> > 
> > and the second one repeats for some time afterwards.
> > 
> > I experimented a little by allocating the zero page statically as many
> > other arches do which fixes the issue as it does not need to be
> > initialized at this point anymore, though I have no idea if that's
> > appropriate.
> 
> Do you mean putting the zero in the BSS like, e.g. arm64? I don't see a
> reason why this shouldn't work.
> 

Yes, exactly that. The diff I had was:

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 86378eec7757..6fa9acd6a7f5 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -15,8 +15,8 @@
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern struct page *empty_zero_page;
-#define ZERO_PAGE(vaddr)	(empty_zero_page)
+extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
+#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
 #endif
 
 #include <asm-generic/pgtable-nopud.h>
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 8bac96e205ac..518def8314e7 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -45,7 +45,7 @@ extern unsigned long __atags_pointer;
  * empty_zero_page is a special page that is used for
  * zero-initialized data and COW.
  */
-struct page *empty_zero_page;
+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 /*
@@ -1754,8 +1754,6 @@ static void __init early_fixmap_shutdown(void)
  */
 void __init paging_init(const struct machine_desc *mdesc)
 {
-	void *zero_page;
-
 #ifdef CONFIG_XIP_KERNEL
 	/* Store the kernel RW RAM region start/end in these variables */
 	kernel_sec_start = CONFIG_PHYS_OFFSET & SECTION_MASK;
@@ -1781,13 +1779,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 
 	top_pmd = pmd_off_k(0xffff0000);
 
-	/* allocate the zero page. */
-	zero_page = early_alloc(PAGE_SIZE);
-
 	bootmem_init();
-
-	empty_zero_page = virt_to_page(zero_page);
-	__flush_dcache_folio(NULL, page_folio(empty_zero_page));
 }
 
 void __init early_mm_init(const struct machine_desc *mdesc)
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index d638cc87807e..7e42d8accec6 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -31,7 +31,7 @@ unsigned long vectors_base;
  * empty_zero_page is a special page that is used for
  * zero-initialized data and COW.
  */
-struct page *empty_zero_page;
+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_ARM_MPU
@@ -156,18 +156,10 @@ void __init adjust_lowmem_bounds(void)
  */
 void __init paging_init(const struct machine_desc *mdesc)
 {
-	void *zero_page;
-
 	early_trap_init((void *)vectors_base);
 	mpu_setup();
 
-	/* allocate the zero page. */
-	zero_page = (void *)memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
-
 	bootmem_init();
-
-	empty_zero_page = virt_to_page(zero_page);
-	flush_dcache_page(empty_zero_page);
 }
 
 /*

> I also have a patch with some minor changes that still keeps
> empty_zero_page allocated, but avoids virt_to_page() and folio_page()
> dance. Can you please test it in your setup?
> 
> From 8a213c13211106d592fbe96b68ee29879ed739f8 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Date: Sat, 3 Jan 2026 20:40:09 +0200
> Subject: [PATCH] arm: make initialization of zero page independent of the
>  memory map
> 
> Unlike most architectures, arm keeps a struct page pointer to the
> empty_zero_page and to initialize it requires conversion of a virtual
> address to page which makes it necessary to have memory map initialized
> before creating the empty_zero_page.
> 
> Make empty_zero_page a void * to decouple it's initialization from the
> initialization of the memory map.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/arm/include/asm/pgtable.h |  4 ++--
>  arch/arm/mm/mmu.c              | 10 +++-------
>  arch/arm/mm/nommu.c            | 10 +++-------
>  3 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 86378eec7757..08bbd2aed6c9 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -15,8 +15,8 @@
>   * ZERO_PAGE is a global shared page that is always zero: used
>   * for zero-mapped memory areas etc..
>   */
> -extern struct page *empty_zero_page;
> -#define ZERO_PAGE(vaddr)	(empty_zero_page)
> +extern void *empty_zero_page;
> +#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
>  #endif
>  
>  #include <asm-generic/pgtable-nopud.h>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 8bac96e205ac..867258f1ae09 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -45,7 +45,7 @@ extern unsigned long __atags_pointer;
>   * empty_zero_page is a special page that is used for
>   * zero-initialized data and COW.
>   */
> -struct page *empty_zero_page;
> +void *empty_zero_page;
>  EXPORT_SYMBOL(empty_zero_page);
>  
>  /*
> @@ -1754,8 +1754,6 @@ static void __init early_fixmap_shutdown(void)
>   */
>  void __init paging_init(const struct machine_desc *mdesc)
>  {
> -	void *zero_page;
> -
>  #ifdef CONFIG_XIP_KERNEL
>  	/* Store the kernel RW RAM region start/end in these variables */
>  	kernel_sec_start = CONFIG_PHYS_OFFSET & SECTION_MASK;
> @@ -1782,12 +1780,10 @@ void __init paging_init(const struct machine_desc *mdesc)
>  	top_pmd = pmd_off_k(0xffff0000);
>  
>  	/* allocate the zero page. */
> -	zero_page = early_alloc(PAGE_SIZE);
> +	empty_zero_page = early_alloc(PAGE_SIZE);
> +	__cpuc_flush_dcache_area(empty_zero_page, PAGE_SIZE);
>  
>  	bootmem_init();
> -
> -	empty_zero_page = virt_to_page(zero_page);
> -	__flush_dcache_folio(NULL, page_folio(empty_zero_page));
>  }
>  
>  void __init early_mm_init(const struct machine_desc *mdesc)
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index d638cc87807e..f80ff5a69fbb 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -31,7 +31,7 @@ unsigned long vectors_base;
>   * empty_zero_page is a special page that is used for
>   * zero-initialized data and COW.
>   */
> -struct page *empty_zero_page;
> +void *empty_zero_page;
>  EXPORT_SYMBOL(empty_zero_page);
>  
>  #ifdef CONFIG_ARM_MPU
> @@ -156,18 +156,14 @@ void __init adjust_lowmem_bounds(void)
>   */
>  void __init paging_init(const struct machine_desc *mdesc)
>  {
> -	void *zero_page;
> -
>  	early_trap_init((void *)vectors_base);
>  	mpu_setup();
>  
>  	/* allocate the zero page. */
> -	zero_page = (void *)memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
> +	empty_zero_page = memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
> +	__cpuc_flush_dcache_area(empty_zero_page, PAGE_SIZE);
>  
>  	bootmem_init();
> -
> -	empty_zero_page = virt_to_page(zero_page);
> -	flush_dcache_page(empty_zero_page);
>  }
>  
>  /*
> -- 
> 2.51.0
> 

This also works for me.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

>  
> > Regards,
> > Klara Modin
> > 
> 
> -- 
> Sincerely yours,
> Mike.
