Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763A54673
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891205; cv=none; b=WJ5S+hGXd5qvCKwM8HLe++tBzaM3xix44FvZyOt1eNtbF2UwCYWbn6WavzispQa1UW/0X4q40pKROiNX+vHOBB1WC8UtZHSlGkXh/fTcxHFSvZjCJ/JOVmqFOlRY9LovCtNY2zW9UvP2pbsDv8GRFvK3uDpDdot1aV65CrxlDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891205; c=relaxed/simple;
	bh=nLtdyu5+SOBb4Waa/j/gTxhT3XzQeijh2c+5DTlx9PY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYxUzxcSRn9Rd3vgWlZ2gtkEWkX58N6pXofrbsaXsGU12rZY9RXGunTtDwwnl/JXHERDBWb4soMMDUaq/P7xnKEg4McT98h6pGo/WH0ss7Xmp04UJOGz9V34wzbvm8qJ4pxnmJAtz/ThALJ/TWnY8faT2XXLhSyY7afDi12keLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TRLg156cfz6K8n8;
	Sat,  3 Feb 2024 00:23:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7270514038F;
	Sat,  3 Feb 2024 00:26:35 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 2 Feb
 2024 16:26:34 +0000
Date: Fri, 2 Feb 2024 16:26:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gregory.price@memverge.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Alex =?ISO-8859-1?Q?Benn=E9e?=
	<alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, "Dimitrios Palyvos"
	<dimitrios.palyvos@zptcorp.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <richard.henderson@linaro.org>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <20240202162633.0000453c@huawei.com>
In-Reply-To: <ZbvpSaOXzZkqDd6c@memverge.com>
References: <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
	<20240201140100.000016ce@huawei.com>
	<CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
	<87msskkyce.fsf@draig.linaro.org>
	<CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
	<20240201162150.000022cf@huawei.com>
	<87h6iskuad.fsf@draig.linaro.org>
	<20240201170822.00005bad@Huawei.com>
	<87r0hwjdvl.fsf@draig.linaro.org>
	<CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
	<ZbvpSaOXzZkqDd6c@memverge.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 1 Feb 2024 13:56:09 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Thu, Feb 01, 2024 at 06:04:26PM +0000, Peter Maydell wrote:
> > On Thu, 1 Feb 2024 at 17:25, Alex Benn=E9e <alex.bennee@linaro.org> wro=
te: =20
> > >
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes: =20
> > > >> > #21 0x0000555555ca3e5d in do_st8_mmu (cpu=3D0x5555578e0cb0, addr=
=3D23937, val=3D18386491784638059520, oi=3D6, ra=3D140736029817822) at ../.=
./accel/tcg/cputlb.c:2853
> > > >> > #22 0x00007fffa9107c63 in code_gen_buffer () =20
> > > >>
> > > >> No thats different - we are actually writing to the MMIO region he=
re.
> > > >> But the fact we hit cpu_abort because we can't find the TB we are
> > > >> executing is a little problematic.
> > > >>
> > > >> Does ra properly point to the code buffer here? =20
> > > >
> > > > Err.  How would I tell? =20
> > >
> > > (gdb) p/x 140736029817822
> > > $1 =3D 0x7fffa9107bde
> > >
> > > seems off because code_gen_buffer starts at 0x00007fffa9107c63 =20
> >=20
> > The code_gen_buffer doesn't *start* at 0x00007fffa9107c63 --
> > that is our return address into it, which is to say it's just
> > after the call insn to the do_st8_mmu helper. The 'ra' argument
> > to the helper function is going to be a number slightly lower
> > than that, because it points within the main lump of generated
> > code for the TB, whereas the helper call is done as part of
> > an out-of-line lump of common code at the end of the TB.
> >=20
> > The 'ra' here is fine -- the problem is that we don't
> > pass it all the way down the callstack and instead end
> > up using 0 as a 'ra' within the ptw code.
> >=20
> > -- PMM =20
>=20
> Is there any particular reason not to, as below?
> ~Gregory
>=20
One patch blindly applied.=20
New exciting trace...
Thread 5 "qemu-system-x86" received signal SIGABRT, Aborted.
[Switching to Thread 0x7ffff4efe6c0 (LWP 16503)]
__pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<optimized=
 out>) at ./nptl/pthread_kill.c:44
Download failed: Invalid argument.  Continuing without source file ./nptl/.=
/nptl/pthread_kill.c.
44      ./nptl/pthread_kill.c: No such file or directory.
(gdb) bt
#0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<optim=
ized out>) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=3D6, threadid=3D<optimized out>) at ./np=
tl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=3D<optimized out>, signo=3Dsigno@entry=3D=
6) at ./nptl/pthread_kill.c:89
#3  0x00007ffff77c43b6 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/po=
six/raise.c:26
#4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
#5  0x00007ffff7b2ed1e in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
#6  0x00007ffff7b9622e in g_assertion_message_expr () at /lib/x86_64-linux-=
gnu/libglib-2.0.so.0
#7  0x0000555555ab1929 in bql_lock_impl (file=3D0x555556049122 "../../accel=
/tcg/cputlb.c", line=3D2033) at ../../system/cpus.c:524
#8  bql_lock_impl (file=3Dfile@entry=3D0x555556049122 "../../accel/tcg/cput=
lb.c", line=3Dline@entry=3D2033) at ../../system/cpus.c:520
#9  0x0000555555c9f7d6 in do_ld_mmio_beN (cpu=3D0x5555578e0cb0, full=3D0x7f=
fe88012950, ret_be=3Dret_be@entry=3D0, addr=3D19595792376, size=3Dsize@entr=
y=3D8, mmu_idx=3D4, type=3DMMU_DATA_LOAD, ra=3D0) at ../../accel/tcg/cputlb=
.c:2033
#10 0x0000555555ca0fbd in do_ld_8 (cpu=3Dcpu@entry=3D0x5555578e0cb0, p=3Dp@=
entry=3D0x7ffff4efd1d0, mmu_idx=3D<optimized out>, type=3Dtype@entry=3DMMU_=
DATA_LOAD, memop=3D<optimized out>, ra=3Dra@entry=3D0) at ../../accel/tcg/c=
putlb.c:2356
#11 0x0000555555ca341f in do_ld8_mmu (cpu=3Dcpu@entry=3D0x5555578e0cb0, add=
r=3Daddr@entry=3D19595792376, oi=3Doi@entry=3D52, ra=3D0, ra@entry=3D52, ac=
cess_type=3Daccess_type@entry=3DMMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:=
2439
#12 0x0000555555ca5f59 in cpu_ldq_mmu (ra=3D52, oi=3D52, addr=3D19595792376=
, env=3D0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
#13 cpu_ldq_le_mmuidx_ra (env=3D0x5555578e3470, addr=3D19595792376, mmu_idx=
=3D<optimized out>, ra=3Dra@entry=3D0) at ../../accel/tcg/ldst_common.c.inc=
:301
#14 0x0000555555b4b5fc in ptw_ldq (ra=3D0, in=3D0x7ffff4efd320) at ../../ta=
rget/i386/tcg/sysemu/excp_helper.c:98
#15 ptw_ldq (ra=3D0, in=3D0x7ffff4efd320) at ../../target/i386/tcg/sysemu/e=
xcp_helper.c:93
#16 mmu_translate (env=3Denv@entry=3D0x5555578e3470, in=3D0x7ffff4efd3e0, o=
ut=3D0x7ffff4efd3b0, err=3Derr@entry=3D0x7ffff4efd3c0, ra=3Dra@entry=3D0) a=
t ../../target/i386/tcg/sysemu/excp_helper.c:174
#17 0x0000555555b4c4b3 in get_physical_address (ra=3D0, err=3D0x7ffff4efd3c=
0, out=3D0x7ffff4efd3b0, mmu_idx=3D0, access_type=3DMMU_DATA_LOAD, addr=3D1=
8446741874686299840, env=3D0x5555578e3470) at ../../target/i386/tcg/sysemu/=
excp_helper.c:580
#18 x86_cpu_tlb_fill (cs=3D0x5555578e0cb0, addr=3D18446741874686299840, siz=
e=3D<optimized out>, access_type=3DMMU_DATA_LOAD, mmu_idx=3D0, probe=3D<opt=
imized out>, retaddr=3D0) at ../../target/i386/tcg/sysemu/excp_helper.c:606
#19 0x0000555555ca0ee9 in tlb_fill (retaddr=3D0, mmu_idx=3D0, access_type=
=3DMMU_DATA_LOAD, size=3D<optimized out>, addr=3D18446741874686299840, cpu=
=3D0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1315
#20 mmu_lookup1 (cpu=3Dcpu@entry=3D0x5555578e0cb0, data=3Ddata@entry=3D0x7f=
fff4efd540, mmu_idx=3D0, access_type=3Daccess_type@entry=3DMMU_DATA_LOAD, r=
a=3Dra@entry=3D0) at ../../accel/tcg/cputlb.c:1713
#21 0x0000555555ca2c61 in mmu_lookup (cpu=3Dcpu@entry=3D0x5555578e0cb0, add=
r=3Daddr@entry=3D18446741874686299840, oi=3Doi@entry=3D32, ra=3Dra@entry=3D=
0, type=3Dtype@entry=3DMMU_DATA_LOAD, l=3Dl@entry=3D0x7ffff4efd540) at ../.=
./accel/tcg/cputlb.c:1803
#22 0x0000555555ca3165 in do_ld4_mmu (cpu=3Dcpu@entry=3D0x5555578e0cb0, add=
r=3Daddr@entry=3D18446741874686299840, oi=3Doi@entry=3D32, ra=3Dra@entry=3D=
0, access_type=3Daccess_type@entry=3DMMU_DATA_LOAD) at ../../accel/tcg/cput=
lb.c:2416
#23 0x0000555555ca5ef9 in cpu_ldl_mmu (ra=3D0, oi=3D32, addr=3D184467418746=
86299840, env=3D0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:158
#24 cpu_ldl_le_mmuidx_ra (env=3Denv@entry=3D0x5555578e3470, addr=3Daddr@ent=
ry=3D18446741874686299840, mmu_idx=3D<optimized out>, ra=3Dra@entry=3D0) at=
 ../../accel/tcg/ldst_common.c.inc:294
#25 0x0000555555bb6cdd in do_interrupt64 (is_hw=3D1, next_eip=3D18446744072=
399775809, error_code=3D0, is_int=3D0, intno=3D236, env=3D0x5555578e3470) a=
t ../../target/i386/tcg/seg_helper.c:889
#26 do_interrupt_all (cpu=3Dcpu@entry=3D0x5555578e0cb0, intno=3D236, is_int=
=3Dis_int@entry=3D0, error_code=3Derror_code@entry=3D0, next_eip=3Dnext_eip=
@entry=3D0, is_hw=3Dis_hw@entry=3D1) at ../../target/i386/tcg/seg_helper.c:=
1130
#27 0x0000555555bb87da in do_interrupt_x86_hardirq (env=3Denv@entry=3D0x555=
5578e3470, intno=3D<optimized out>, is_hw=3Dis_hw@entry=3D1) at ../../targe=
t/i386/tcg/seg_helper.c:1162
#28 0x0000555555b5039c in x86_cpu_exec_interrupt (cs=3D0x5555578e0cb0, inte=
rrupt_request=3D<optimized out>) at ../../target/i386/tcg/sysemu/seg_helper=
.c:197
#29 0x0000555555c94480 in cpu_handle_interrupt (last_tb=3D<synthetic pointe=
r>, cpu=3D0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:844
#30 cpu_exec_loop (cpu=3Dcpu@entry=3D0x5555578e0cb0, sc=3Dsc@entry=3D0x7fff=
f4efd7b0) at ../../accel/tcg/cpu-exec.c:951
#31 0x0000555555c94791 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x5555578e0cb0=
, sc=3Dsc@entry=3D0x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:1029
#32 0x0000555555c94f7c in cpu_exec (cpu=3Dcpu@entry=3D0x5555578e0cb0) at ..=
/../accel/tcg/cpu-exec.c:1055
#33 0x0000555555cb9043 in tcg_cpu_exec (cpu=3Dcpu@entry=3D0x5555578e0cb0) a=
t ../../accel/tcg/tcg-accel-ops.c:76
#34 0x0000555555cb91a0 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x5555578e=
0cb0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
#35 0x0000555555e57270 in qemu_thread_start (args=3D0x555557956000) at ../.=
./util/qemu-thread-posix.c:541
#36 0x00007ffff78176ba in start_thread (arg=3D<optimized out>) at ./nptl/pt=
hread_create.c:444
#37 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/cl=
one3.S:81

>=20
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysem=
u/excp_helper.c
> index 5b86f439ad..2f581b9bfb 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -59,14 +59,14 @@ typedef struct PTETranslate {
>      hwaddr gaddr;
>  } PTETranslate;
>=20
> -static bool ptw_translate(PTETranslate *inout, hwaddr addr)
> +static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
>  {
>      CPUTLBEntryFull *full;
>      int flags;
>=20
>      inout->gaddr =3D addr;
>      flags =3D probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
> -                              inout->ptw_idx, true, &inout->haddr, &full=
, 0);
> +                              inout->ptw_idx, true, &inout->haddr, &full=
, ra);
>=20
>      if (unlikely(flags & TLB_INVALID_MASK)) {
>          TranslateFault *err =3D inout->err;
> @@ -82,20 +82,20 @@ static bool ptw_translate(PTETranslate *inout, hwaddr=
 addr)
>      return true;
>  }
>=20
> -static inline uint32_t ptw_ldl(const PTETranslate *in)
> +static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
>  {
>      if (likely(in->haddr)) {
>          return ldl_p(in->haddr);
>      }
> -    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
> +    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
>  }
>=20
> -static inline uint64_t ptw_ldq(const PTETranslate *in)
> +static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
>  {
>      if (likely(in->haddr)) {
>          return ldq_p(in->haddr);
>      }
> -    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
> +    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
>  }
>=20
>  /*
> @@ -132,7 +132,8 @@ static inline bool ptw_setl(const PTETranslate *in, u=
int32_t old, uint32_t set)
>  }
>=20
>  static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
> -                          TranslateResult *out, TranslateFault *err)
> +                          TranslateResult *out, TranslateFault *err,
> +                          uint64_t ra)
>  {
>      const int32_t a20_mask =3D x86_get_a20_mask(env);
>      const target_ulong addr =3D in->addr;
> @@ -166,11 +167,11 @@ static bool mmu_translate(CPUX86State *env, const T=
ranslateParams *in,
>                   */
>                  pte_addr =3D ((in->cr3 & ~0xfff) +
>                              (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
> -                if (!ptw_translate(&pte_trans, pte_addr)) {
> +                if (!ptw_translate(&pte_trans, pte_addr, ra)) {
>                      return false;
>                  }
>              restart_5:
> -                pte =3D ptw_ldq(&pte_trans);
> +                pte =3D ptw_ldq(&pte_trans, ra);
>                  if (!(pte & PG_PRESENT_MASK)) {
>                      goto do_fault;
>                  }
> @@ -191,11 +192,11 @@ static bool mmu_translate(CPUX86State *env, const T=
ranslateParams *in,
>               */
>              pte_addr =3D ((pte & PG_ADDRESS_MASK) +
>                          (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
> -            if (!ptw_translate(&pte_trans, pte_addr)) {
> +            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
>                  return false;
>              }
>          restart_4:
> -            pte =3D ptw_ldq(&pte_trans);
> +            pte =3D ptw_ldq(&pte_trans, ra);
>              if (!(pte & PG_PRESENT_MASK)) {
>                  goto do_fault;
>              }
> @@ -212,11 +213,11 @@ static bool mmu_translate(CPUX86State *env, const T=
ranslateParams *in,
>               */
>              pte_addr =3D ((pte & PG_ADDRESS_MASK) +
>                          (((addr >> 30) & 0x1ff) << 3)) & a20_mask;
> -            if (!ptw_translate(&pte_trans, pte_addr)) {
> +            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
>                  return false;
>              }
>          restart_3_lma:
> -            pte =3D ptw_ldq(&pte_trans);
> +            pte =3D ptw_ldq(&pte_trans, ra);
>              if (!(pte & PG_PRESENT_MASK)) {
>                  goto do_fault;
>              }
> @@ -239,12 +240,12 @@ static bool mmu_translate(CPUX86State *env, const T=
ranslateParams *in,
>               * Page table level 3
>               */
>              pte_addr =3D ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a=
20_mask;
> -            if (!ptw_translate(&pte_trans, pte_addr)) {
> +            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
>                  return false;
>              }
>              rsvd_mask |=3D PG_HI_USER_MASK;
>          restart_3_nolma:
> -            pte =3D ptw_ldq(&pte_trans);
> +            pte =3D ptw_ldq(&pte_trans, ra);
>              if (!(pte & PG_PRESENT_MASK)) {
>                  goto do_fault;
>              }
> @@ -262,11 +263,11 @@ static bool mmu_translate(CPUX86State *env, const T=
ranslateParams *in,
>           */
>          pte_addr =3D ((pte & PG_ADDRESS_MASK) +
>                      (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
> -        if (!ptw_translate(&pte_trans, pte_addr)) {
> +        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
>              return false;
>          }
>      restart_2_pae:
> -        pte =3D ptw_ldq(&pte_trans);
> +        pte =3D ptw_ldq(&pte_trans, ra);
>          if (!(pte & PG_PRESENT_MASK)) {
>              goto do_fault;
>          }
> @@ -289,10 +290,10 @@ static bool mmu_translate(CPUX86State *env, const T=
ranslateParams *in,
>           */
>          pte_addr =3D ((pte & PG_ADDRESS_MASK) +
>                      (((addr >> 12) & 0x1ff) << 3)) & a20_mask;
> -        if (!ptw_translate(&pte_trans, pte_addr)) {
> +        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
>              return false;
>          }
> -        pte =3D ptw_ldq(&pte_trans);
> +        pte =3D ptw_ldq(&pte_trans, ra);
>          if (!(pte & PG_PRESENT_MASK)) {
>              goto do_fault;
>          }
> @@ -307,11 +308,11 @@ static bool mmu_translate(CPUX86State *env, const T=
ranslateParams *in,
>           * Page table level 2
>           */
>          pte_addr =3D ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20=
_mask;
> -        if (!ptw_translate(&pte_trans, pte_addr)) {
> +        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
>              return false;
>          }
>      restart_2_nopae:
> -        pte =3D ptw_ldl(&pte_trans);
> +        pte =3D ptw_ldl(&pte_trans, ra);
>          if (!(pte & PG_PRESENT_MASK)) {
>              goto do_fault;
>          }
> @@ -336,10 +337,10 @@ static bool mmu_translate(CPUX86State *env, const T=
ranslateParams *in,
>           * Page table level 1
>           */
>          pte_addr =3D ((pte & ~0xfffu) + ((addr >> 10) & 0xffc)) & a20_ma=
sk;
> -        if (!ptw_translate(&pte_trans, pte_addr)) {
> +        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
>              return false;
>          }
> -        pte =3D ptw_ldl(&pte_trans);
> +        pte =3D ptw_ldl(&pte_trans, ra);
>          if (!(pte & PG_PRESENT_MASK)) {
>              goto do_fault;
>          }
> @@ -529,7 +530,8 @@ static G_NORETURN void raise_stage2(CPUX86State *env,=
 TranslateFault *err,
>=20
>  static bool get_physical_address(CPUX86State *env, vaddr addr,
>                                   MMUAccessType access_type, int mmu_idx,
> -                                 TranslateResult *out, TranslateFault *e=
rr)
> +                                 TranslateResult *out, TranslateFault *e=
rr,
> +                                 uint64_t ra)
>  {
>      TranslateParams in;
>      bool use_stage2 =3D env->hflags2 & HF2_NPT_MASK;
> @@ -548,7 +550,7 @@ static bool get_physical_address(CPUX86State *env, va=
ddr addr,
>              in.mmu_idx =3D MMU_USER_IDX;
>              in.ptw_idx =3D MMU_PHYS_IDX;
>=20
> -            if (!mmu_translate(env, &in, out, err)) {
> +            if (!mmu_translate(env, &in, out, err, ra)) {
>                  err->stage2 =3D S2_GPA;
>                  return false;
>              }
> @@ -575,7 +577,7 @@ static bool get_physical_address(CPUX86State *env, va=
ddr addr,
>                      return false;
>                  }
>              }
> -            return mmu_translate(env, &in, out, err);
> +            return mmu_translate(env, &in, out, err, ra);
>          }
>          break;
>      }
> @@ -601,7 +603,7 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int s=
ize,
>      TranslateResult out;
>      TranslateFault err;
>=20
> -    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err=
)) {
> +    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err=
, retaddr)) {
>          /*
>           * Even if 4MB pages, we map only one 4KB page in the cache to
>           * avoid filling it too fast.

