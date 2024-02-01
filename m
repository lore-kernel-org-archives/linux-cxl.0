Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DD5CAF
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805943; cv=none; b=bG6Xtd/cvsI50ZGca3uupfMpishSreWfzUzChruGzALMZ6mc1PoLpSXg5GogSIrE5ihad8pMlYsCVcWJjrCIMzZmuaTtKnNnTBXt4UWwHYzVAdQWAJWTQX6ZLuC5iu8fCAO1gDe92PmnFBeamzPs78/4+qLhsrwW2TW97NaNumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805943; c=relaxed/simple;
	bh=3FJPGVDQqCcLq4nzOUJpCXwrVCSf93gBB/ml9TiDNL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tirJH1BqozlwB4xDASKoxyRsPQ9x5sbl7p2dO1Jk26BFnRK7HNeq60Bwgy4y8e2AR6JxqtFQ1Zr3ko9agY3NsEQ3OVaIjcsA7+axl6lumLAgumbFsKkb99aY735fNBn6DRglT5QMUyy53I/1oA00YrUfdr98rsvNYmpTYXAO5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEUtfrQD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEUtfrQD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40ef6bbb61fso10152335e9.1
        for <linux-cxl@vger.kernel.org>; Thu, 01 Feb 2024 08:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706805931; x=1707410731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MuEAwzpRRM44/0U+wQmVFZKpKJxDi0iYSDTV2dvb9M=;
        b=VEUtfrQDtLtWCmnXLH1reyCpma8160WoV8SqynbOsDMj3V3kPje7ctLyJuB1Ft+CyQ
         R58YuBC2vik/xhZdnZrwPRBY1eAst/RllFHg+rLO1gB7fhuJRvqDMMdwDDttHhxKkJ0+
         yTHfATrk/L7NMdKK1d0QN9jAl5DsKCRFaUzt2t4PfJ3c3B+wMawXVHpurJmQfQA92J2g
         0Epiv1xIC3fhqg6h5IcHgaui2lAuanW8D7fDOKh5fM3fX/38QrS2bl0TADaljkjujQOv
         vRTP0qUE+rJqj6RDkz/GdGQ6Q8kP2GZfhDvmV1kfjEumwyBz+JQ2glfRbOGEEKOIHqhY
         iNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706805931; x=1707410731;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5MuEAwzpRRM44/0U+wQmVFZKpKJxDi0iYSDTV2dvb9M=;
        b=BER8k1NLICufsGZGiYlWe+7uSz0RQ/0IzOiZHoqr6XIGTNH9FJI2EyYKO1UuRP2YGr
         J45WZg+7qbrQPBav+w47e1n2s3UxXEXIZk+EZ1Nevn2ZNGIBVSC9ZlpPsRu3mZN0NaJL
         zGWngRgr/oo5Je+cEhkvbFjBztt06tiD3gBe8VIcw6gG5mXtImeNF/4oKQIMFMKyh4Ze
         k+1hDOQtEhjHi977VW/YqmC9HRkLrcTvq9m6vTaO5bUQLts4lpsUS6l6iSJv46V3taA6
         aQo5fSxrnT+VL2udvNi2rRCGX/+wLGHullv9L0KLzZiNiUKqUT5JMPugVqri7k8GzUPz
         0iCQ==
X-Gm-Message-State: AOJu0Yzz4MmlI5ouOC3LIfAU+Z32HqBqs6haxJuMka/BaKCw1aU4ZgOj
	vtwqFdppqzX5Qv0OTdCcORb11nQCzpkQX9J10uFzZq6Fn6+TC2Lknksv8a81E5Y=
X-Google-Smtp-Source: AGHT+IFs51NoUYck6AKzu8vc41c2pWjWHgIZbVd+8hiteuuFUymT8Q8cv+sdWaTCsz6clAXlhGb2TQ==
X-Received: by 2002:a05:600c:3554:b0:40f:bda1:f8c7 with SMTP id i20-20020a05600c355400b0040fbda1f8c7mr1700886wmq.34.1706805930906;
        Thu, 01 Feb 2024 08:45:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX+ufVaQP1yNFouLl1c45bJMNS/eK/UK+CtSZKQG3kIZhasWlSyCilouI7ZetVYtg85SKsgeIl54Xi8TagBYB1zmZz+X5oaKZOPqxWsNSFmeEHLf+7jAZUT6U87gUWaPdqE4rhrf64Lj5Dry2jQDEsHskYpy3/7bcyIW6tZvE9aV6Lgi1Uf9ivp9E2HhLKqfw9jbfxrUa4OkoN6sM6MEsLg4ZhmMkwQz7XVErkfQfbQD34m8gPzw/jQOyWz0briPz4yHb9EhMRbm4UYheo=
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c450c00b0040d5ae2906esm4977970wmo.30.2024.02.01.08.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:45:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 2FAF85F7AF;
	Thu,  1 Feb 2024 16:45:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Sajjan Rao
 <sajjanr@gmail.com>,  Gregory Price <gregory.price@memverge.com>,
  "Dimitrios Palyvos" <dimitrios.palyvos@zptcorp.com>,
  <linux-cxl@vger.kernel.org>,  <qemu-devel@nongnu.org>,
  <richard.henderson@linaro.org>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
In-Reply-To: <20240201162150.000022cf@huawei.com> (Jonathan Cameron's message
	of "Thu, 1 Feb 2024 16:21:50 +0000")
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
	<CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
	<CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
	<CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
	<20230823175056.00001a84@Huawei.com>
	<CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
	<CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
	<20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com>
	<20240126171233.00002a2e@Huawei.com>
	<CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
	<20240201130438.00001384@Huawei.com>
	<CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
	<20240201140100.000016ce@huawei.com>
	<CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
	<87msskkyce.fsf@draig.linaro.org>
	<CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
	<20240201162150.000022cf@huawei.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 16:45:30 +0000
Message-ID: <87h6iskuad.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Thu, 1 Feb 2024 16:00:56 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On Thu, 1 Feb 2024 at 15:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> >
>> > Peter Maydell <peter.maydell@linaro.org> writes:=20=20
>> > > So, that looks like:
>> > >  * we call cpu_tb_exec(), which executes some generated code
>> > >  * that generated code calls the lookup_tb_ptr helper to see
>> > >    if we have a generated TB already for the address we're going
>> > >    to execute next
>> > >  * lookup_tb_ptr probes the TLB to see if we know the host RAM
>> > >    address for the guest address
>> > >  * this results in a TLB walk for an instruction fetch
>> > >  * the page table descriptor load is to IO memory
>> > >  * io_prepare assumes it needs to do a TLB recompile, because
>> > >    can_do_io is clear
>> > >
>> > > I am not surprised that the corner case of "the guest put its
>> > > page tables in an MMIO device" has not yet come up :-)
>> > >
>> > > I'm really not sure how the icount handling should interact
>> > > with that...=20=20
>> >
>> > Its not just icount - we need to handle it for all modes now. That said
>> > seeing as we are at the end of a block shouldn't can_do_io be set?=20=
=20
>>=20
>> The lookup_tb_ptr helper gets called from tcg_gen_goto_tb(),
>> which happens earlier than the tb_stop callback (it can
>> happen in the trans function for branch etc insns, for
>> example).
>>=20
>> I think it should be OK to clear can_do_io at the start
>> of the lookup_tb_ptr helper, something like:
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index 977576ca143..7818537f318 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -396,6 +396,15 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>>      uint64_t cs_base;
>>      uint32_t flags, cflags;
>>=20
>> +    /*
>> +     * By definition we've just finished a TB, so I/O is OK.
>> +     * Avoid the possibility of calling cpu_io_recompile() if
>> +     * a page table walk triggered by tb_lookup() calling
>> +     * probe_access_internal() happens to touch an MMIO device.
>> +     * The next TB, if we chain to it, will clear the flag again.
>> +     */
>> +    cpu->neg.can_do_io =3D true;
>> +
>>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>=20
>>      cflags =3D curr_cflags(cpu);
>>=20
>> -- PMM
>
> No joy.  Seems like a very similar backtrace.
>
> Thread 5 "qemu-system-x86" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7ffff4efe6c0 (LWP 23937)]
> __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<optimiz=
ed out>) at ./nptl/pthread_kill.c:44
> 44      ./nptl/pthread_kill.c: No such file or directory.
> (gdb) bt
> #0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<opt=
imized out>) at ./nptl/pthread_kill.c:44
> #1  __pthread_kill_internal (signo=3D6, threadid=3D<optimized out>) at ./=
nptl/pthread_kill.c:78
> #2  __GI___pthread_kill (threadid=3D<optimized out>, signo=3Dsigno@entry=
=3D6) at ./nptl/pthread_kill.c:89
> #3  0x00007ffff77c43b6 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
> #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
> #5  0x0000555555c4d19e in cpu_abort (cpu=3Dcpu@entry=3D0x5555578e0cb0, fm=
t=3Dfmt@entry=3D0x555556048ee8 "cpu_io_recompile: could not find TB for pc=
=3D%p") at ../../cpu-target.c:373
> #6  0x0000555555c9cb25 in cpu_io_recompile (cpu=3Dcpu@entry=3D0x5555578e0=
cb0, retaddr=3Dretaddr@entry=3D0) at ../../accel/tcg/translate-all.c:611
> #7  0x0000555555c9f744 in io_prepare (retaddr=3D0, addr=3D19595790664, at=
trs=3D..., xlat=3D<optimized out>, cpu=3D0x5555578e0cb0, out_offset=3D<synt=
hetic pointer>) at ../../accel/tcg/cputlb.c:1339
> #8  do_ld_mmio_beN (cpu=3D0x5555578e0cb0, full=3D0x7ffe88012890, ret_be=
=3Dret_be@entry=3D0, addr=3D19595790664, size=3Dsize@entry=3D8, mmu_idx=3D4=
, type=3DMMU_DATA_LOAD, ra=3D0) at ../../accel/tcg/cputlb.c:2030
> #9  0x0000555555ca0ecd in do_ld_8 (cpu=3Dcpu@entry=3D0x5555578e0cb0, p=3D=
p@entry=3D0x7ffff4efcdd0, mmu_idx=3D<optimized out>, type=3Dtype@entry=3DMM=
U_DATA_LOAD, memop=3D<optimized out>, ra=3Dra@entry=3D0) at ../../accel/tcg=
/cputlb.c:2356
> #10 0x0000555555ca332f in do_ld8_mmu (cpu=3Dcpu@entry=3D0x5555578e0cb0, a=
ddr=3Daddr@entry=3D19595790664, oi=3Doi@entry=3D52, ra=3Dra@entry=3D0, acce=
ss_type=3Daccess_type@entry=3DMMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:24=
39
> #11 0x0000555555ca5e69 in cpu_ldq_mmu (ra=3D0, oi=3D52, addr=3D1959579066=
4, env=3D0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
> #12 cpu_ldq_le_mmuidx_ra (env=3D0x5555578e3470, addr=3D19595790664, mmu_i=
dx=3D<optimized out>, ra=3Dra@entry=3D0) at ../../accel/tcg/ldst_common.c.i=
nc:301
> #13 0x0000555555b4b5de in ptw_ldq (in=3D0x7ffff4efcf10) at ../../target/i=
386/tcg/sysemu/excp_helper.c:98
> #14 ptw_ldq (in=3D0x7ffff4efcf10) at ../../target/i386/tcg/sysemu/excp_he=
lper.c:93
> #15 mmu_translate (env=3Denv@entry=3D0x5555578e3470, in=3D0x7ffff4efcfd0,=
 out=3D0x7ffff4efcfa0, err=3Derr@entry=3D0x7ffff4efcfb0) at ../../target/i3=
86/tcg/sysemu/excp_helper.c:173
> #16 0x0000555555b4c3f3 in get_physical_address (err=3D0x7ffff4efcfb0, out=
=3D0x7ffff4efcfa0, mmu_idx=3D0, access_type=3DMMU_DATA_STORE, addr=3D183864=
91786698339392, env=3D0x5555578e3470) at ../../target/i386/tcg/sysemu/excp_=
helper.c:578
> #17 x86_cpu_tlb_fill (cs=3D0x5555578e0cb0, addr=3D18386491786698339392, s=
ize=3D<optimized out>, access_type=3DMMU_DATA_STORE, mmu_idx=3D0, probe=3D<=
optimized out>, retaddr=3D140736029817822) at ../../target/i386/tcg/sysemu/=
excp_helper.c:604
> #18 0x0000555555ca0df9 in tlb_fill (retaddr=3D140736029817822, mmu_idx=3D=
0, access_type=3DMMU_DATA_STORE, size=3D<optimized out>, addr=3D18386491786=
698339392, cpu=3D0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1315
> #19 mmu_lookup1 (cpu=3Dcpu@entry=3D0x5555578e0cb0, data=3Ddata@entry=3D0x=
7ffff4efd120, mmu_idx=3D0, access_type=3Daccess_type@entry=3DMMU_DATA_STORE=
, ra=3Dra@entry=3D140736029817822) at ../../accel/tcg/cputlb.c:1713
> #20 0x0000555555ca2b71 in mmu_lookup (cpu=3D0x5555578e0cb0, addr=3D183864=
91786698339392, oi=3D<optimized out>, ra=3D140736029817822, type=3DMMU_DATA=
_STORE, l=3D0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1803
> #21 0x0000555555ca3e5d in do_st8_mmu (cpu=3D0x5555578e0cb0, addr=3D23937,=
 val=3D18386491784638059520, oi=3D6, ra=3D140736029817822) at ../../accel/t=
cg/cputlb.c:2853
> #22 0x00007fffa9107c63 in code_gen_buffer ()

No thats different - we are actually writing to the MMIO region here.
But the fact we hit cpu_abort because we can't find the TB we are
executing is a little problematic.

Does ra properly point to the code buffer here?

> #23 0x0000555555c9395b in cpu_tb_exec (cpu=3Dcpu@entry=3D0x5555578e0cb0, =
itb=3Ditb@entry=3D0x7fffa9107980 <code_gen_buffer+17856851>, tb_exit=3Dtb_e=
xit@entry=3D0x7ffff4efd718) at ../../accel/tcg/cpu-exec.c:442
> #24 0x0000555555c93ec0 in cpu_loop_exec_tb (tb_exit=3D0x7ffff4efd718, las=
t_tb=3D<synthetic pointer>, pc=3D<optimized out>, tb=3D0x7fffa9107980 <code=
_gen_buffer+17856851>, cpu=3D0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:=
897
> #25 cpu_exec_loop (cpu=3Dcpu@entry=3D0x5555578e0cb0, sc=3Dsc@entry=3D0x7f=
fff4efd7b0) at ../../accel/tcg/cpu-exec.c:1012
> #26 0x0000555555c946d1 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x5555578e0c=
b0, sc=3Dsc@entry=3D0x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:1029
> #27 0x0000555555c94ebc in cpu_exec (cpu=3Dcpu@entry=3D0x5555578e0cb0) at =
../../accel/tcg/cpu-exec.c:1055
> #28 0x0000555555cb8f53 in tcg_cpu_exec (cpu=3Dcpu@entry=3D0x5555578e0cb0)=
 at ../../accel/tcg/tcg-accel-ops.c:76
> #29 0x0000555555cb90b0 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x555557=
8e0cb0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
> #30 0x0000555555e57180 in qemu_thread_start (args=3D0x555557956000) at ..=
/../util/qemu-thread-posix.c:541
> #31 0x00007ffff78176ba in start_thread (arg=3D<optimized out>) at ./nptl/=
pthread_create.c:444
> #32 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/=
clone3.S:81

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
