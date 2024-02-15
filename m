Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A4136672
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018481; cv=none; b=RNezzEOpdWiFkavfQN7rc5BhbWalyAHldhqOk9koZaNXOyc9i1SJXluLVgkCB5XJ5gffZrgonN7w0bzBx2H6KAPeGUp8oGL3DnSwH0IK44BiwIiQW7CQ25ayyIT8xdRYcnUxihkR9jWoiS5vY82mp7RyZmtsKoG12sbuP4PCO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018481; c=relaxed/simple;
	bh=sI0O/UXCDwQ4ZGfhdBcxurGwEeaVobmI6qD1q/ZmWp8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTk3P6MWmDv+ZjEt6wxWEMva30m4ij3n1cln8FcyYStiIkq82OPQMCFJpcieeLWMSxmlkLLv4hv+DwJ2Z85Wv7xN3n7pMoWGJgLVwTvRanaecLTc7z4ZasfDtaccUb+r+w+zU5neVV2kzM77M3+pHkBXAD3uZ3ZlMmu2+u64+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbMXT0fknz6J9bQ;
	Fri, 16 Feb 2024 01:30:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 028C1140682;
	Fri, 16 Feb 2024 01:34:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 17:34:35 +0000
Date: Thu, 15 Feb 2024 17:34:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Gregory Price <gregory.price@memverge.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Sajjan Rao
	<sajjanr@gmail.com>, Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
	<richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be
 in mmio memory.
Message-ID: <20240215173434.00004882@Huawei.com>
In-Reply-To: <CAFEAcA-rHZe2xF9anKxYFm0zHYc6gV=g9JiXxeZ4E_LoQ7DhSA@mail.gmail.com>
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
	<20240215150133.2088-4-Jonathan.Cameron@huawei.com>
	<CAFEAcA-rHZe2xF9anKxYFm0zHYc6gV=g9JiXxeZ4E_LoQ7DhSA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 16:11:26 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 15 Feb 2024 at 15:03, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On i386, after fixing the page walking code to work with pages in
> > MMIO memory (specifically CXL emulated interleaved memory),
> > a crash was seen in an interrupt handling path.
> >
> > Useful part of bt  
> 
> Did you intend to put in a backtrace here?
ah. Indeed.

Forgot that the # at start of a bt is a comment in a git message
oops.

I'll put those back in (hash removed) for v2.

7  0x0000555555ab1929 in bql_lock_impl (file=0x555556049122 "../../accel/tcg/cputlb.c", line=2033) at ../../system/cpus.c:524
8  bql_lock_impl (file=file@entry=0x555556049122 "../../accel/tcg/cputlb.c", line=line@entry=2033) at ../../system/cpus.c:520
9  0x0000555555c9f7d6 in do_ld_mmio_beN (cpu=0x5555578e0cb0, full=0x7ffe88012950, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2033
10 0x0000555555ca0fbd in do_ld_8 (cpu=cpu@entry=0x5555578e0cb0, p=p@entry=0x7ffff4efd1d0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
11 0x0000555555ca341f in do_ld8_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=19595792376, oi=oi@entry=52, ra=0, ra@entry=52, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
12 0x0000555555ca5f59 in cpu_ldq_mmu (ra=52, oi=52, addr=19595792376, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
13 cpu_ldq_le_mmuidx_ra (env=0x5555578e3470, addr=19595792376, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:301
14 0x0000555555b4b5fc in ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:98
15 ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:93
16 mmu_translate (env=env@entry=0x5555578e3470, in=0x7ffff4efd3e0, out=0x7ffff4efd3b0, err=err@entry=0x7ffff4efd3c0, ra=ra@entry=0) at ../../target/i386/tcg/sysemu/excp_helper.c:174
17 0x0000555555b4c4b3 in get_physical_address (ra=0, err=0x7ffff4efd3c0, out=0x7ffff4efd3b0, mmu_idx=0, access_type=MMU_DATA_LOAD, addr=18446741874686299840, env=0x5555578e3470) at ../../target/i386/tcg/sysemu/excp_helper.c:580
18 x86_cpu_tlb_fill (cs=0x5555578e0cb0, addr=18446741874686299840, size=<optimized out>, access_type=MMU_DATA_LOAD, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:606
19 0x0000555555ca0ee9 in tlb_fill (retaddr=0, mmu_idx=0, access_type=MMU_DATA_LOAD, size=<optimized out>, addr=18446741874686299840, cpu=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1315
20 mmu_lookup1 (cpu=cpu@entry=0x5555578e0cb0, data=data@entry=0x7ffff4efd540, mmu_idx=0, access_type=access_type@entry=MMU_DATA_LOAD, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:1713
21 0x0000555555ca2c61 in mmu_lookup (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=18446741874686299840, oi=oi@entry=32, ra=ra@entry=0, type=type@entry=MMU_DATA_LOAD, l=l@entry=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1803
22 0x0000555555ca3165 in do_ld4_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=18446741874686299840, oi=oi@entry=32, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2416
23 0x0000555555ca5ef9 in cpu_ldl_mmu (ra=0, oi=32, addr=18446741874686299840, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:158
24 cpu_ldl_le_mmuidx_ra (env=env@entry=0x5555578e3470, addr=addr@entry=18446741874686299840, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:294
25 0x0000555555bb6cdd in do_interrupt64 (is_hw=1, next_eip=18446744072399775809, error_code=0, is_int=0, intno=236, env=0x5555578e3470) at ../../target/i386/tcg/seg_helper.c:889
26 do_interrupt_all (cpu=cpu@entry=0x5555578e0cb0, intno=236, is_int=is_int@entry=0, error_code=error_code@entry=0, next_eip=next_eip@entry=0, is_hw=is_hw@entry=1) at ../../target/i386/tcg/seg_helper.c:1130
27 0x0000555555bb87da in do_interrupt_x86_hardirq (env=env@entry=0x5555578e3470, intno=<optimized out>, is_hw=is_hw@entry=1) at ../../target/i386/tcg/seg_helper.c:1162
28 0x0000555555b5039c in x86_cpu_exec_interrupt (cs=0x5555578e0cb0, interrupt_request=<optimized out>) at ../../target/i386/tcg/sysemu/seg_helper.c:197
29 0x0000555555c94480 in cpu_handle_interrupt (last_tb=<synthetic pointer>, cpu=0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:844
> 
> >
> > Peter identified this as being due to the BQL already being
> > held when the page table walker encounters MMIO memory and attempts
> > to take the lock again.  There are other examples of similar paths
> > TCG, so this follows the approach taken in those of simply checking
> > if the lock is already held and if it is, don't take it again.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  accel/tcg/cputlb.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 047cd2cc0a..3b8d178707 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
> >                                 int mmu_idx, MMUAccessType type, uintptr_t ra)
> >  {
> >      MemoryRegionSection *section;
> > +    bool locked = bql_locked();
> >      MemoryRegion *mr;
> >      hwaddr mr_offset;
> >      MemTxAttrs attrs;
> > @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
> >      section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
> >      mr = section->mr;
> >
> > -    bql_lock();
> > +    if (!locked) {
> > +        bql_lock();
> > +    }
> >      ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
> >                            type, ra, mr, mr_offset);
> > -    bql_unlock();
> > +    if (!locked) {
> > +        bql_unlock();
> > +    }
> >
> >      return ret;
> >  }  
> 
> Can we do this consistently across all four functions
> do_ld_mmio_beN, do_ld16_mmio_beN, do_st_mmio_leN,
> do_st16_mmio_leN, please ? It happens that your workload
> only needs to do an 8-byte load but conceptually the same
> thing applies in all these cases.

Sure,

Jonathan


> 
> thanks
> -- PMM

