Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EBE38A706
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299877; cv=none; b=tRXAf5C/JtklTs3u1sIZQAqd5Qc6cK11QItzDpBBzoTVdty2hscFJvat8fr1uSmXZ2O1xHdAfeC1KurjLPGP2p26H7B2DraNALx+bp5dTQ1wjD4husTtwaXvbT3HsusVrJB5X9Fe0J5l6eiI93mlC4x71MjJziyU60pKxBq0tww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299877; c=relaxed/simple;
	bh=39NtxAeqpXvhawaLycQSgS8a7QXmm9U/xmb9EyW+PGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PCZnFTCCzjUrz8FVRfH0Ubora0CXP9OiglOW3tf+X0hpyGlsZp7zqTNp/hHij2r524T0iDX2ZTTWTMrptC/wUGCn2xtTMrWlnGRDGPu/FqKRGt1z1PUDXHw994fGQCvhRfg9t/LkAjO20hY2gegvnj+zSXkvPc3KlbBSto/r/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWbvpur4; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWbvpur4"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b7c2614f7so4207183e87.3
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 02:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768299874; x=1768904674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=nWbvpur48T6+lgVC+38d4FmCsIIS6aSrFAS6vJyFEseEv+HA7UF9lrULjk3vdG8DPg
         KIU3jJeCl2DjAFVMPbPSU54z4WQDmfEl5DhOS8ULd8gwV53PByJSONQBfVVszwtTxi6x
         2ZPrx8pU24QQiAMoIUjExfhevlm/gIb4LzeWEVTuT0F+zWEy/uavqGznpGjebp8eCtcA
         c1924iLHpHCGwEmuY/h3zMXCpKxQ2lICzp0mqWZgVdWDKPQEZOMV7Tyq0HMJibC9n/yI
         nTL7JUqC7wuRpLZFm3dPvCfR9W7a2ctoGmb9DLjTE5+bCT/S9U1217xtEzt74Ftq1RHz
         MJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768299874; x=1768904674;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=tZT3Qvrex6VsB0tOV7LN+zlFGQjrRchWNqR2P6VxOib0JXyXeziYDuB1Bl1+2yy3Jj
         nJZJ4EiBXIS2yCDMHP3d9Iv1mMHgzqrHeZ2kD16Ua+f6R94/yCSWaAsj8b3m0kzM5fhR
         UdDjGClSR4+nLTXj8Ux8UCEt7zPJDh09kiR/u67KNdQBLgWlJAMvib3GPnHQXnWCMzor
         NvsDk4YC6bDjeIgCA7n2aJT6VqASGJtUwYjPW1O9VOaF8oGkr8qju+SaktHcxWsCYMr3
         7DlSSJAdKEP+kymbr0tyHZ075Lp9X9sGkEnZrqIqwYZEbsg2Pr3Q5JHzDItBXHAm9SFF
         qsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcTN0RuEanwIabfsQMggReCQG+9MnAHXxtuxzfnEIYVPDqd5dJw7F22G397k5eqSpskgQfDmKtkwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMEfOdKH7DV8af+GXMI/dzpwQob1ibUAaARJNFuC5WaP/Sb6Lb
	+KzKPaVXtA9pDK3n0ZYfhxDuuu28INeVhQ8xainCK9211yPaZtIv4CB81QUs9g==
X-Gm-Gg: AY/fxX551crSIUx6wBzjen9xt0XS+OpDfOKIFdzbrVGELtydR3L74V5oQCuVVlaB7Ts
	Jm2x9DV+06A5mHq5Un6XLbeZ2HP5EFt/Ztx2PclnDG8Qg+3QjhubM1QVBPYkYHo2WdJ8CfhERl2
	KS/oKmrCgwGcXIdKi3zZC/hhKP5paycuKk3NjHlXHo23p58+1X2Snn4CW/XMJ1JQxipIylddhKu
	UIgRIRWHSa/XyuVUBCLXj/WK5q8vFxP3UtXyqguKHS99Vh2id3GcsQqFr9jkbP2x8N5bhide5vQ
	H/GUTvUnwwAf8qZZHe31MXjBx00LwT7EofIF2mTBDF5eMV+HhTgAOb/g9yGq1g0y2yUjObOnutX
	0XrZFiH2m5NVCDSWr1+Iuo5YIVYejy03sYUMjRHyMhJCXiE2sQfMzidGhu0eEyywqglgZIibOOX
	6FxYs0B3pVAfFucyhFyibqnYQ2TGOF6PbvnqgsWNs183/yXiv6x4hdQZ8jSw==
X-Google-Smtp-Source: AGHT+IEOoK2sWcGzQ5k4NJjsFR/RmdeWAB9vvZrFfNJ0u+S6dsEFK74/fdYnqiqEV2XmHMt6sJ390w==
X-Received: by 2002:a05:6512:138b:b0:598:e851:1db3 with SMTP id 2adb3069b0e04-59b6ef05760mr8236951e87.11.1768293628066;
        Tue, 13 Jan 2026 00:40:28 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b72f3ae82sm4416299e87.71.2026.01.13.00.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:40:27 -0800 (PST)
Message-ID: <f861a1c6-7ec7-477c-bc42-f9aaf6724bed@gmail.com>
Date: Tue, 13 Jan 2026 10:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
From: Kalle Niemi <kaleposti@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
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
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
 <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Language: en-US
In-Reply-To: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/13/26 08:50, Kalle Niemi wrote:
> On 1/13/26 00:23, Andrew Morton wrote:
>> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
>>
>>> v3 changes:
>>> * fix empty_zero_page initialization on arm
>>> * fix ZONE_DMA limit calculation on powerpc
>>> * add Acks
>>
>> updated, thanks.  I'll suppress the ensuing email flood.
>>
>> Kalle, can you please retest sometime, see if the BeagleBone Black boot
>> failure was fixed?
>>
>> Seems we haven't heard back from rmk regarding
>> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.
> 
> Hello!
> 
> I will test this v3 patch ASAP and reply results here.
> Collective sorry for the delay; I have been busy!
> 
> BR
> Kalle

Hello!

I tried this patch by cloning 
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=hugetlb-init/v3

Boots succesfully on BeagleBone Black!

BR
Kalle
