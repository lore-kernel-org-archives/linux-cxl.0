Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9E26CE39
	for <linux-cxl@vger.kernel.org>; Sat,  3 Jan 2026 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767418596; cv=none; b=ZcN3ZfHeytY6YOjOxYzvAQPKjDC2WjS20ATCC9bhdTAFZWHLRMnFvHlfYU4VvgosxeUhQqJt9Ty6sl5Ede3IV65RHvtjQgkL9+BLCvv2rmjhV10q1nW6r1ZFdUrt98GZkpdo5Ndf/Pdylk2JVDIco7ZBM3qoLzRKyMoU3uQ/ucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767418596; c=relaxed/simple;
	bh=ATXYUvNs1r7k2R+QkRXiglU8qywdgmSoPgsNlVWS4pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up7CjDlbVo4DnjYhYZ2Gwif69H8cA8VmwhnUpt67q3tAQfgPEKZw6u0V6wfs5EED2Tx17HMn6yOWQFUItzxvOF+i5pAG7366YhcFalYs/4vpZCtuF9fz9L/7gtg4G3NxTUWzOnughoCU0CmKU0psAW1ygatRiV5ruZ6ingsJSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDXMiTxx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDXMiTxx"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb5810d39so8128696f8f.2
        for <linux-cxl@vger.kernel.org>; Fri, 02 Jan 2026 21:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767418591; x=1768023391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10gk4kIzv5viXrYP6wsblohOaaYzL8Wh9uCfOfLAyTE=;
        b=gDXMiTxxJbSjZSyFQUB6T5kBrvh2LsNE97UOkAmZYirAEl0yRraTfieWvOhBoqRUqm
         FIHLEGPxujyCQ7b66gUmIrAfOBp7ZQQM3oo59+R2v2NQ6TSeJYwC1+sItTOs92L+mPC0
         YOyKfOGX7SpTHcnTlGt7O7cRpP7+e1ku6+iHq6X7qBAfXhq/5C14HOJ86NOU1aIrYiYH
         eCgLhdjtCLh/ZPCiL4WZX3EZAkiX1RxBgsaDDWflHrVLWdoHDOG4GK6ARhzE6uUQrbGT
         SxBpM24mo+zNzRAf3+4C+lNZlydg1P+21uuT1rhnmXBZLBRxqG5dbSIdSV7mOFxyqUk6
         b+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767418591; x=1768023391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10gk4kIzv5viXrYP6wsblohOaaYzL8Wh9uCfOfLAyTE=;
        b=dhxrz/q2jIWrgIIyTgz+bzKLHkLzSs9TEU8rMdZqFuRSq3N5IWnT0YUrRzxQyM30pN
         5gwYT2jBJmrjSJ9Kk9qzrNB493dLgRPippS5OR1VLYxdUj+eIB8UMHUW0mHZaSE9qTJG
         YYpxnv8jchZUfwTwOsJakIz6scm04WYfddDa/pS6o9L7sMMmgeEFyA/P37mLe7Zh8s69
         54E9teOMh/LRJbFd34cVKPP9AOwyg18+4arqGkDzUfIxyWtl0fN9SnkX5FW15QV2ifJj
         JLZBvUXMymEqTJyvu33+thTnjX4Egzq0RAfFYUplfnFNvzDLs9l+OhLvKm7vvPcv53Ih
         mrCw==
X-Forwarded-Encrypted: i=1; AJvYcCV0sRyxqMcSPscPyCXEEcT1XGZCcF4pGSED7jawuMbcLJQcZGtSLCJkNhnxUwWXaBLV5xy7HDRVtZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXmqnBEZoGWewy6klv1NMTv01jxzcefgmiyZprNaIw1Et9+o9m
	5jwpDqWqTr8w/K06en6QhX9gWZPVfy+9GE3cwVzbAOSowv+u0q/1njch
X-Gm-Gg: AY/fxX4GPhS+efYS72hTFfnvHgOCHhMoQnNLZUG+RF71MniGSiS7ON7u8McH4j/unpe
	S1hZtgjMKFKlNddMzCLkIX8L+b1R4j/PbO7CPhkqA5aRWZB3w7ZDNm/rxEr2cqFOrZkgOfPFILM
	cxFWw4ArX34D8611P7sXoALABRl+PdQFA77oJJ7VlVdqgDWs7mbfnmdaxGALYNMW4DtCA5xAFkJ
	aU92NzzU0zc+VjvcueBxtRQswT/jFP+Rqmt/HodN668K6UhtBK47/SxCnF1FkH8HUPfAIU0bOkC
	LuGUst/AtVmTMOAwqC6wCmWoDj253VzRfgyxIOnV5Y5P+TVhhrqch/3szz7mjIjCpVLpzik8ZMv
	C8H8jAH4Q2aqXghDeU+N6iX0GKPh5GwqDyAai1ThpW0dvTkWSWPi65Iyglsw8s8kgjzfmrgH9R7
	pl2c3/ghdI/nTKXG0GOELR/fPaeblQgoVA1bL0B1Wq16DZFO6y0RDfrwps3kHwG264
X-Google-Smtp-Source: AGHT+IGVfFhDmvRzquITceR9a5MtoKyW2aPxvUx0HbCgVxiLGpVVcSZGOqzt3JsoKLBzXfIUaXLywg==
X-Received: by 2002:a05:6000:178f:b0:430:fd84:317a with SMTP id ffacd0b85a97d-4324e4fb825mr53362620f8f.38.1767418590643;
        Fri, 02 Jan 2026 21:36:30 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm89007161f8f.37.2026.01.02.21.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 21:36:28 -0800 (PST)
Date: Sat, 3 Jan 2026 05:36:26 +0000
From: Stafford Horne <shorne@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	x86@kernel.org, linux-alpha@vger.kernel.org,
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
Subject: Re: [PATCH v2 12/28] openrisc: introduce arch_zone_limits_init()
Message-ID: <aViq2vsMk5tltK0f@antec>
References: <20260102070005.65328-1-rppt@kernel.org>
 <20260102070005.65328-13-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102070005.65328-13-rppt@kernel.org>

On Fri, Jan 02, 2026 at 08:59:48AM +0200, Mike Rapoport wrote:
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
>  arch/openrisc/mm/init.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index 9382d9a0ec78..67de93e7a685 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -39,15 +39,19 @@
>  
>  int mem_init_done;
>  
> -static void __init zone_sizes_init(void)
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
>  {
> -	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
> -
>  	/*
>  	 * We use only ZONE_NORMAL
>  	 */
> -	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
> +	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> +}
> +
> +static void __init zone_sizes_init(void)
> +{
> +	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
>  
> +	arch_zone_limits_init(max_zone_pfn);
>  	free_area_init(max_zone_pfn);
>  }

Thanks, this looks like a good cleanup.


Acked-by: Stafford Horne <shorne@gmail.com>
