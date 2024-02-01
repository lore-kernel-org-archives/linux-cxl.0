Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1D62167
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801379; cv=none; b=Dxk9DrYTzPDhOg2UL3PpNEl2ADpyfLJJ3XokhVPdeqrMjHxD/vgM3SODPzR4oiU9WaGRCnUKY7VtYmqCUflvAKeCD2+QhiGjCHADQeLSjNG2XhnMcfeNmPq+jtUAqZnndeApSnJtnIlL2FmFtCQ6MmLTR/jkURIdiMfUljHF7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801379; c=relaxed/simple;
	bh=W84NPuNuqQIFPJITCne5/1VklJr1Ot3wNuJE4O7r8f8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQaWsCrOxgo3WXcTuaGIRQOgnxamuN5T//wObx9LNE2tVeR1xyqAlMsHfZF56dylVrKA/dCjCwQIMLl4lPdFPh6sfWnWQbacGZTz7bZusC8rz47aMFyg55OlJPQ5fKC0oYhZVx+PjNQ9fEwNsc7QK/0mmN/dsNKklMdV93sRGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQjRh5cN2z6K8wX;
	Thu,  1 Feb 2024 23:26:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B0971409EA;
	Thu,  1 Feb 2024 23:29:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 15:29:32 +0000
Date: Thu, 1 Feb 2024 15:29:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Sajjan Rao <sajjanr@gmail.com>,
	Gregory Price <gregory.price@memverge.com>, "Dimitrios Palyvos"
	<dimitrios.palyvos@zptcorp.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <richard.henderson@linaro.org>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <20240201152931.00001511@Huawei.com>
In-Reply-To: <87msskkyce.fsf@draig.linaro.org>
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
	<CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
	<CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
	<CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
	<CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 01 Feb 2024 15:17:53 +0000
Alex Benn=E9e <alex.bennee@linaro.org> wrote:

> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On Thu, 1 Feb 2024 at 14:01, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote: =20
> >> > Can you run QEMU under gdb and give the backtrace when it stops
> >> > on the abort() ? That will probably have a helpful clue. I
> >> > suspect something is failing to pass a valid retaddr in
> >> > when it calls a load/store function. =20
> > =20
> >> [Switching to Thread 0x7ffff56ff6c0 (LWP 21916)]
> >> __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<opti=
mized out>) at ./nptl/pthread_kill.c:44
> >> 44      ./nptl/pthread_kill.c: No such file or directory.
> >> (gdb) bt
> >> #0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<=
optimized out>) at ./nptl/pthread_kill.c:44
> >> #1  __pthread_kill_internal (signo=3D6, threadid=3D<optimized out>) at=
 ./nptl/pthread_kill.c:78
> >> #2  __GI___pthread_kill (threadid=3D<optimized out>, signo=3Dsigno@ent=
ry=3D6) at ./nptl/pthread_kill.c:89
> >> #3  0x00007ffff77c43b6 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysde=
ps/posix/raise.c:26
> >> #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
> >> #5  0x0000555555c0d4ce in cpu_abort
> >>     (cpu=3Dcpu@entry=3D0x555556fd9000, fmt=3Dfmt@entry=3D0x555555fe337=
8 "cpu_io_recompile: could not find TB for pc=3D%p")
> >>     at ../../cpu-target.c:359
> >> #6  0x0000555555c59435 in cpu_io_recompile (cpu=3Dcpu@entry=3D0x555556=
fd9000, retaddr=3Dretaddr@entry=3D0) at ../../accel/tcg/translate-all.c:611
> >> #7  0x0000555555c5c956 in io_prepare
> >>     (retaddr=3D0, addr=3D19595792376, attrs=3D..., xlat=3D<optimized o=
ut>, cpu=3D0x555556fd9000, out_offset=3D<synthetic pointer>)
> >>     at ../../accel/tcg/cputlb.c:1339 =20
> <snip>
> >> #21 tb_htable_lookup (cpu=3D<optimized out>, pc=3Dpc@entry=3D184467440=
72116178925, cs_base=3D0, flags=3D415285936, cflags=3D4278353920)
> >>     at ../../accel/tcg/cpu-exec.c:231
> >> #22 0x0000555555c50c08 in tb_lookup
> >>     (cpu=3Dcpu@entry=3D0x555556fd9000, pc=3Dpc@entry=3D184467440721161=
78925, cs_base=3Dcs_base@entry=3D0, flags=3D<optimized out>, cflags=3D<opti=
mized out>) at ../../accel/tcg/cpu-exec.c:267
> >> #23 0x0000555555c51e23 in helper_lookup_tb_ptr (env=3D0x555556fdb7c0) =
at ../../accel/tcg/cpu-exec.c:423
> >> #24 0x00007fffa9076ead in code_gen_buffer ()
> >> #25 0x0000555555c50fab in cpu_tb_exec (cpu=3Dcpu@entry=3D0x555556fd900=
0, itb=3D<optimized out>, tb_exit=3Dtb_exit@entry=3D0x7ffff56fe708)
> >>     at ../../accel/tcg/cpu-exec.c:458
> >> #26 0x0000555555c51492 in cpu_loop_exec_tb
> >>     (tb_exit=3D0x7ffff56fe708, last_tb=3D<synthetic pointer>, pc=3D184=
46744072116179169, tb=3D<optimized out>, cpu=3D0x555556fd9000)
> >>     at ../../accel/tcg/cpu-exec.c:920
> >> #27 cpu_exec_loop (cpu=3Dcpu@entry=3D0x555556fd9000, sc=3Dsc@entry=3D0=
x7ffff56fe7a0) at ../../accel/tcg/cpu-exec.c:1041
> >> #28 0x0000555555c51d11 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x555556f=
d9000, sc=3Dsc@entry=3D0x7ffff56fe7a0) at ../../accel/tcg/cpu-exec.c:1058
> >> #29 0x0000555555c523b4 in cpu_exec (cpu=3Dcpu@entry=3D0x555556fd9000) =
at ../../accel/tcg/cpu-exec.c:1084
> >> #30 0x0000555555c74053 in tcg_cpus_exec (cpu=3Dcpu@entry=3D0x555556fd9=
000) at ../../accel/tcg/tcg-accel-ops.c:76
> >> #31 0x0000555555c741a0 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x555=
556fd9000) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
> >> #32 0x0000555555dfb580 in qemu_thread_start (args=3D0x55555703c3e0) at=
 ../../util/qemu-thread-posix.c:541
> >> #33 0x00007ffff78176ba in start_thread (arg=3D<optimized out>) at ./np=
tl/pthread_create.c:444
> >> #34 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_=
64/clone3.S:81 =20
> >
> > So, that looks like:
> >  * we call cpu_tb_exec(), which executes some generated code
> >  * that generated code calls the lookup_tb_ptr helper to see
> >    if we have a generated TB already for the address we're going
> >    to execute next
> >  * lookup_tb_ptr probes the TLB to see if we know the host RAM
> >    address for the guest address
> >  * this results in a TLB walk for an instruction fetch
> >  * the page table descriptor load is to IO memory
> >  * io_prepare assumes it needs to do a TLB recompile, because
> >    can_do_io is clear
> >
> > I am not surprised that the corner case of "the guest put its
> > page tables in an MMIO device" has not yet come up :-)
> >
> > I'm really not sure how the icount handling should interact
> > with that... =20
>=20
> Its not just icount - we need to handle it for all modes now. That said
> seeing as we are at the end of a block shouldn't can_do_io be set?
>=20
> Does:
>=20
> modified   accel/tcg/translator.c
> @@ -201,6 +201,8 @@ void translator_loop(CPUState *cpu, TranslationBlock =
*tb, int *max_insns,
>          }
>      }
> =20
> +    set_can_do_io(db, true);
> +
>      /* Emit code to exit the TB, as indicated by db->is_jmp.  */
>      ops->tb_stop(db, cpu);
>      gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
>=20
> do the trick?

no :(

>=20
> >
> > -- PMM =20
>=20

