Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AB7428A
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809297; cv=none; b=h5M6rgI8JYhWFroHKGdqnEjvTu9KIm5oMNf/3eNBdTBjYAi3AdPLhDjIW/Ji5B2HZKn8hVoND8ROUqNIvE2CYmZuZX560OOmiVMrVr2GhCwFgRzELOM88WF46osYBm6evW3VBFab15yvEEJ/CQJ2kUnEbDE3h8EWjGbFEmSfLkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809297; c=relaxed/simple;
	bh=2H6PcCIojyBgEN0C98tC4i0rPe2N7wpp+x8ABjnRDqw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyI1f/QvAaWKdtY0Ss+qpYI+WLmbqHZ71mwBaCY3Ny8IRLZ1ZV/5zvGXXvByt8Gw5w4f1xkdrf8AUGfxC8wD1V1t8b43IkR+ryVY6zc9PBU+cMEapQPEJEOWlrWkwH59rx9iwzW+/h7SJ9tF5qMKHWSdiSgC1trPXAJWDsKeHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQmMw1sPbz6K8t3;
	Fri,  2 Feb 2024 01:38:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C95D1404F5;
	Fri,  2 Feb 2024 01:41:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 17:41:28 +0000
Date: Thu, 1 Feb 2024 17:41:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Sajjan Rao
	<sajjanr@gmail.com>, Gregory Price <gregory.price@memverge.com>, "Dimitrios
 Palyvos" <dimitrios.palyvos@zptcorp.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <richard.henderson@linaro.org>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <20240201174127.0000666c@Huawei.com>
In-Reply-To: <CAFEAcA-5KhX+O0tCTdkPbkobNo1sprgebqs63ebzKc5v7KqYeg@mail.gmail.com>
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
	<20230823175056.00001a84@Huawei.com>
	<CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
	<CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
	<20240126123926.000051bd@Huawei.com>
	<ZbPTL00WOo7UC0e6@memverge.com>
	<20240126171233.00002a2e@Huawei.com>
	<CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
	<20240201130438.00001384@Huawei.com>
	<CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
	<20240201140100.000016ce@huawei.com>
	<CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
	<87msskkyce.fsf@draig.linaro.org>
	<CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
	<20240201162150.000022cf@huawei.com>
	<87h6iskuad.fsf@draig.linaro.org>
	<20240201170822.00005bad@Huawei.com>
	<CAFEAcA-5KhX+O0tCTdkPbkobNo1sprgebqs63ebzKc5v7KqYeg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 1 Feb 2024 17:21:49 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 1 Feb 2024 at 17:08, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 01 Feb 2024 16:45:30 +0000
> > Alex Benn=E9e <alex.bennee@linaro.org> wrote:
> > =20
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> > > =20
> > > > On Thu, 1 Feb 2024 16:00:56 +0000
> > > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > =20
> > > >> On Thu, 1 Feb 2024 at 15:17, Alex Benn=E9e <alex.bennee@linaro.org=
> wrote: =20
> > > >> >
> > > >> > Peter Maydell <peter.maydell@linaro.org> writes: =20
> > > >> > > So, that looks like:
> > > >> > >  * we call cpu_tb_exec(), which executes some generated code
> > > >> > >  * that generated code calls the lookup_tb_ptr helper to see
> > > >> > >    if we have a generated TB already for the address we're goi=
ng
> > > >> > >    to execute next
> > > >> > >  * lookup_tb_ptr probes the TLB to see if we know the host RAM
> > > >> > >    address for the guest address
> > > >> > >  * this results in a TLB walk for an instruction fetch
> > > >> > >  * the page table descriptor load is to IO memory
> > > >> > >  * io_prepare assumes it needs to do a TLB recompile, because
> > > >> > >    can_do_io is clear
> > > >> > >
> > > >> > > I am not surprised that the corner case of "the guest put its
> > > >> > > page tables in an MMIO device" has not yet come up :-)
> > > >> > >
> > > >> > > I'm really not sure how the icount handling should interact
> > > >> > > with that... =20
> > > >> >
> > > >> > Its not just icount - we need to handle it for all modes now. Th=
at said
> > > >> > seeing as we are at the end of a block shouldn't can_do_io be se=
t? =20
> > > >>
> > > >> The lookup_tb_ptr helper gets called from tcg_gen_goto_tb(),
> > > >> which happens earlier than the tb_stop callback (it can
> > > >> happen in the trans function for branch etc insns, for
> > > >> example).
> > > >>
> > > >> I think it should be OK to clear can_do_io at the start
> > > >> of the lookup_tb_ptr helper, something like:
> > > >> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > > >> index 977576ca143..7818537f318 100644
> > > >> --- a/accel/tcg/cpu-exec.c
> > > >> +++ b/accel/tcg/cpu-exec.c
> > > >> @@ -396,6 +396,15 @@ const void *HELPER(lookup_tb_ptr)(CPUArchStat=
e *env)
> > > >>      uint64_t cs_base;
> > > >>      uint32_t flags, cflags;
> > > >>
> > > >> +    /*
> > > >> +     * By definition we've just finished a TB, so I/O is OK.
> > > >> +     * Avoid the possibility of calling cpu_io_recompile() if
> > > >> +     * a page table walk triggered by tb_lookup() calling
> > > >> +     * probe_access_internal() happens to touch an MMIO device.
> > > >> +     * The next TB, if we chain to it, will clear the flag again.
> > > >> +     */
> > > >> +    cpu->neg.can_do_io =3D true;
> > > >> +
> > > >>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> > > >>
> > > >>      cflags =3D curr_cflags(cpu);
> > > >>
> > > >> -- PMM =20
> > > >
> > > > No joy.  Seems like a very similar backtrace.
> > > >
> > > > Thread 5 "qemu-system-x86" received signal SIGABRT, Aborted.
> > > > [Switching to Thread 0x7ffff4efe6c0 (LWP 23937)]
> > > > __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<o=
ptimized out>) at ./nptl/pthread_kill.c:44
> > > > 44      ./nptl/pthread_kill.c: No such file or directory.
> > > > (gdb) bt
> > > > #0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=
=3D<optimized out>) at ./nptl/pthread_kill.c:44
> > > > #1  __pthread_kill_internal (signo=3D6, threadid=3D<optimized out>)=
 at ./nptl/pthread_kill.c:78
> > > > #2  __GI___pthread_kill (threadid=3D<optimized out>, signo=3Dsigno@=
entry=3D6) at ./nptl/pthread_kill.c:89
> > > > #3  0x00007ffff77c43b6 in __GI_raise (sig=3Dsig@entry=3D6) at ../sy=
sdeps/posix/raise.c:26
> > > > #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
> > > > #5  0x0000555555c4d19e in cpu_abort (cpu=3Dcpu@entry=3D0x5555578e0c=
b0, fmt=3Dfmt@entry=3D0x555556048ee8 "cpu_io_recompile: could not find TB f=
or pc=3D%p") at ../../cpu-target.c:373
> > > > #6  0x0000555555c9cb25 in cpu_io_recompile (cpu=3Dcpu@entry=3D0x555=
5578e0cb0, retaddr=3Dretaddr@entry=3D0) at ../../accel/tcg/translate-all.c:=
611
> > > > #7  0x0000555555c9f744 in io_prepare (retaddr=3D0, addr=3D195957906=
64, attrs=3D..., xlat=3D<optimized out>, cpu=3D0x5555578e0cb0, out_offset=
=3D<synthetic pointer>) at ../../accel/tcg/cputlb.c:1339
> > > > #8  do_ld_mmio_beN (cpu=3D0x5555578e0cb0, full=3D0x7ffe88012890, re=
t_be=3Dret_be@entry=3D0, addr=3D19595790664, size=3Dsize@entry=3D8, mmu_idx=
=3D4, type=3DMMU_DATA_LOAD, ra=3D0) at ../../accel/tcg/cputlb.c:2030
> > > > #9  0x0000555555ca0ecd in do_ld_8 (cpu=3Dcpu@entry=3D0x5555578e0cb0=
, p=3Dp@entry=3D0x7ffff4efcdd0, mmu_idx=3D<optimized out>, type=3Dtype@entr=
y=3DMMU_DATA_LOAD, memop=3D<optimized out>, ra=3Dra@entry=3D0) at ../../acc=
el/tcg/cputlb.c:2356
> > > > #10 0x0000555555ca332f in do_ld8_mmu (cpu=3Dcpu@entry=3D0x5555578e0=
cb0, addr=3Daddr@entry=3D19595790664, oi=3Doi@entry=3D52, ra=3Dra@entry=3D0=
, access_type=3Daccess_type@entry=3DMMU_DATA_LOAD) at ../../accel/tcg/cputl=
b.c:2439
> > > > #11 0x0000555555ca5e69 in cpu_ldq_mmu (ra=3D0, oi=3D52, addr=3D1959=
5790664, env=3D0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
> > > > #12 cpu_ldq_le_mmuidx_ra (env=3D0x5555578e3470, addr=3D19595790664,=
 mmu_idx=3D<optimized out>, ra=3Dra@entry=3D0) at ../../accel/tcg/ldst_comm=
on.c.inc:301
> > > > #13 0x0000555555b4b5de in ptw_ldq (in=3D0x7ffff4efcf10) at ../../ta=
rget/i386/tcg/sysemu/excp_helper.c:98
> > > > #14 ptw_ldq (in=3D0x7ffff4efcf10) at ../../target/i386/tcg/sysemu/e=
xcp_helper.c:93
> > > > #15 mmu_translate (env=3Denv@entry=3D0x5555578e3470, in=3D0x7ffff4e=
fcfd0, out=3D0x7ffff4efcfa0, err=3Derr@entry=3D0x7ffff4efcfb0) at ../../tar=
get/i386/tcg/sysemu/excp_helper.c:173
> > > > #16 0x0000555555b4c3f3 in get_physical_address (err=3D0x7ffff4efcfb=
0, out=3D0x7ffff4efcfa0, mmu_idx=3D0, access_type=3DMMU_DATA_STORE, addr=3D=
18386491786698339392, env=3D0x5555578e3470) at ../../target/i386/tcg/sysemu=
/excp_helper.c:578
> > > > #17 x86_cpu_tlb_fill (cs=3D0x5555578e0cb0, addr=3D18386491786698339=
392, size=3D<optimized out>, access_type=3DMMU_DATA_STORE, mmu_idx=3D0, pro=
be=3D<optimized out>, retaddr=3D140736029817822) at ../../target/i386/tcg/s=
ysemu/excp_helper.c:604
> > > > #18 0x0000555555ca0df9 in tlb_fill (retaddr=3D140736029817822, mmu_=
idx=3D0, access_type=3DMMU_DATA_STORE, size=3D<optimized out>, addr=3D18386=
491786698339392, cpu=3D0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1315
> > > > #19 mmu_lookup1 (cpu=3Dcpu@entry=3D0x5555578e0cb0, data=3Ddata@entr=
y=3D0x7ffff4efd120, mmu_idx=3D0, access_type=3Daccess_type@entry=3DMMU_DATA=
_STORE, ra=3Dra@entry=3D140736029817822) at ../../accel/tcg/cputlb.c:1713
> > > > #20 0x0000555555ca2b71 in mmu_lookup (cpu=3D0x5555578e0cb0, addr=3D=
18386491786698339392, oi=3D<optimized out>, ra=3D140736029817822, type=3DMM=
U_DATA_STORE, l=3D0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1803
> > > > #21 0x0000555555ca3e5d in do_st8_mmu (cpu=3D0x5555578e0cb0, addr=3D=
23937, val=3D18386491784638059520, oi=3D6, ra=3D140736029817822) at ../../a=
ccel/tcg/cputlb.c:2853
> > > > #22 0x00007fffa9107c63 in code_gen_buffer () =20
> > >
> > > No thats different - we are actually writing to the MMIO region here.
> > > But the fact we hit cpu_abort because we can't find the TB we are
> > > executing is a little problematic.
> > >
> > > Does ra properly point to the code buffer here? =20
> >
> > Err.  How would I tell? =20
>=20
> Well, a NULL pointer for the return address is definitely not in
> the codegen buffer :-)
>=20
> This is again a TLB fill case, but this time it's a data
> access from a guest store insn. We had the correct ra when we
> did the do_st8_mmu() down in frame 21: ra=3D140736029817822,
> but as we go through the page table walk, we leave the ra
> behind in x86_cpu_tlb_fill(), and so the ptw_ldq()
> passes a zero ra down to the cpu_ldq_mmuidx_ra() (which
> is generally meant to mean "I am not being called from
> translated code and so can_do_io should be false").
>=20
> I think that none of the page-table-walking handling
> (either in target code or in general) has been designed
> with the idea in mind that it might need to do something
> for icount if the ptw touches an MMIO device. This is probably
> not as simple as merely "plumb the ra value down through the
> ptw code" -- somebody needs to think about whether doing
> an io_recompile() is the right response to that situation.
> And any "do an address translation for me" system insns
> might or might not need to be dealt with differently.
>=20
> If you can at all arrange for your workload not to put
> page tables into MMIO device regions then your life will
> be a lot simpler.

The only way we can do that is abandon supporting emulation
of fine grained interleave (or at least documented that
if you are using this 'mode', don't use it as normal memory)

Whilst I do plan to add a performance option that just
locks out those settings so that we can avoid using MMIO
regions we are going to keep getting people assuming this
case will work  :(=20

We need the high perf restricted option for virtualization
usecases where it's reasonable to fake it that there is
no interleave going on (it will be happening in hardware).

I guess doing that goes up in priority :(

Jonathan

>=20
> thanks
> -- PMM

