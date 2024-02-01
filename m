Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD725D497
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798170; cv=none; b=MFDK6uu7upo83qJe/8CLeNGaW6YjU6+CzO8kox1AL8JXFF0ky12aVXMot9H+kI2PLg6WJLNZ97t7Ujzwqw2xzCIrVGz4fYxZbU9rN1FI09kREAhqSKixVQ2UCKWf8kbVsQ8DZANRwQ6hk1Qtm9jqR7NJ7+CCsRRIICVtOrYHRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798170; c=relaxed/simple;
	bh=KRwNbXCZrkZPNmhJdPl0CoAU+E0BE1wNA8W5QsA8BF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6c1EdQUVwIJspyKvZhF+jZElE5scBwkDH2JMmYmX21jT26klTrtlemtA6z4PpgtxTVWbq1EjDKMt6ns+lU5KFw+BCctuxo/UrFVbNYhDfcAOXCujiBtjR+5I/ZmeH7HWfD/TU9fixl9SilxbT3VW0dedSiCDFEYVeoZI48p6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EMcFmaU6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMcFmaU6"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso1402622a12.3
        for <linux-cxl@vger.kernel.org>; Thu, 01 Feb 2024 06:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706798167; x=1707402967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Oqj8byilzWau5Z8Gm2D8U0OPajJSZThxnSWrA9epyE=;
        b=EMcFmaU6X4BlY9S46iNuU2lBeLBwqyXYCkbYYPEZVii7b96vCVQ0G8z4tfhRhpGwBz
         AwKa55QutBYdfm/kxxkiDtNTsOspYwb8276eFdks/+MzuWKTr7QHTtp9DvZ1SbvngQv/
         qipYVrhQjwDn87opJIFD6kyXTqU2oPWVdZ5tqF77uRFxTYzGnkQeSMGcJ+1+GfZT2uIT
         pacsNZti2yBd1U1YbiCX1HsgdK4XFUJ/C/1yRHvmJH+pxOz2sDqAtyX1FkqMFEwvVWJk
         v2eZUSc+Mu+9W9G86NreIfpWdNMvf5fKbvnij/SX0P1tUc2q2VTKkHOrcKa8zaYnYfL8
         jQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798167; x=1707402967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Oqj8byilzWau5Z8Gm2D8U0OPajJSZThxnSWrA9epyE=;
        b=vtA26KbF2wzN5SFfCjSP+z8nRFLXE/vPwPTWdNTeXZx9lTf9X1jCvQTfDKCedmPFoP
         4qVrdKRndwU7DBhlJDYgKjxWwH27f/vfd9pmfRek3auIT+fK+Riq1hTZF9aYCvdeAe68
         /JEkungZhBN586PAm8+GsNkw1c+Y4pf+c+6PuPoQc/xsE3kz/J8nW8iLBJI1M0h0m7hZ
         Ziuar/uJm+soDETGYyUEecD1NKSrEr7I7g6lazjFh/LYGzASCo47aXdBQO6r7UjkxdEY
         q0H0tIn3jNNAs0MeEIFJc/LahHJ5G04dzhDFuCSWWkWQ9pNXzYKX2x3fn1+faqrsEgZV
         IMZg==
X-Gm-Message-State: AOJu0YxKzkxAyq+Oqg7lAh4bzCfVThPawNcQV4az3gSVqz69lTEIMEVg
	OO4IfOoLiR1s81YcE81g480ifGdhtsXi8gMYtByiRqyttkEnlIjRsfR2ywjedG41a4YIXHr/ZCy
	05a3BcLg8Do0mljufwzstISztzZR22+Ftn/+wYw==
X-Google-Smtp-Source: AGHT+IGYtDe22QnfKjmFKY8vtp2Pxpjb6bmXSsnNKBz726OvWj5FMSyFyoaudS4lLjKeYOb5+NiTuuqBcUuVrC1gp/w=
X-Received: by 2002:a05:6402:40c8:b0:55f:adc6:4ee7 with SMTP id
 z8-20020a05640240c800b0055fadc64ee7mr2203583edb.32.1706798167061; Thu, 01 Feb
 2024 06:36:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com> <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com> <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com> <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
In-Reply-To: <20240201140100.000016ce@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 14:35:56 +0000
Message-ID: <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sajjan Rao <sajjanr@gmail.com>, Gregory Price <gregory.price@memverge.com>, 
	Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
	qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 14:01, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> > Can you run QEMU under gdb and give the backtrace when it stops
> > on the abort() ? That will probably have a helpful clue. I
> > suspect something is failing to pass a valid retaddr in
> > when it calls a load/store function.

> [Switching to Thread 0x7ffff56ff6c0 (LWP 21916)]
> __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:44
> 44      ./nptl/pthread_kill.c: No such file or directory.
> (gdb) bt
> #0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:44
> #1  __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
> #2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at ./nptl/pthread_kill.c:89
> #3  0x00007ffff77c43b6 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
> #5  0x0000555555c0d4ce in cpu_abort
>     (cpu=cpu@entry=0x555556fd9000, fmt=fmt@entry=0x555555fe3378 "cpu_io_recompile: could not find TB for pc=%p")
>     at ../../cpu-target.c:359
> #6  0x0000555555c59435 in cpu_io_recompile (cpu=cpu@entry=0x555556fd9000, retaddr=retaddr@entry=0) at ../../accel/tcg/translate-all.c:611
> #7  0x0000555555c5c956 in io_prepare
>     (retaddr=0, addr=19595792376, attrs=..., xlat=<optimized out>, cpu=0x555556fd9000, out_offset=<synthetic pointer>)
>     at ../../accel/tcg/cputlb.c:1339
> #8  do_ld_mmio_beN
>     (cpu=0x555556fd9000, full=0x7fffee0d96e0, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2030
> #9  0x0000555555c5dfad in do_ld_8
>     (cpu=cpu@entry=0x555556fd9000, p=p@entry=0x7ffff56fddc0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
> #10 0x0000555555c6026f in do_ld8_mmu
>     (cpu=cpu@entry=0x555556fd9000, addr=addr@entry=19595792376, oi=oi@entry=52, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
> #11 0x0000555555c629f9 in cpu_ldq_mmu (ra=0, oi=52, addr=19595792376, env=0x555556fdb7c0) at ../../accel/tcg/ldst_common.c.inc:169
> #12 cpu_ldq_le_mmuidx_ra (env=0x555556fdb7c0, addr=19595792376, mmu_idx=<optimized out>, ra=ra@entry=0)
>     at ../../accel/tcg/ldst_common.c.inc:301
> #13 0x0000555555b18ede in ptw_ldq (in=0x7ffff56fdf00) at ../../target/i386/tcg/sysemu/excp_helper.c:98
> #14 ptw_ldq (in=0x7ffff56fdf00) at ../../target/i386/tcg/sysemu/excp_helper.c:93
> #15 mmu_translate (env=env@entry=0x555556fdb7c0, in=in@entry=0x7ffff56fdfa0, out=out@entry=0x7ffff56fdf70, err=err@entry=0x7ffff56fdf80)
>     at ../../target/i386/tcg/sysemu/excp_helper.c:173
> #16 0x0000555555b19c95 in get_physical_address
>     (err=0x7ffff56fdf80, out=0x7ffff56fdf70, mmu_idx=0, access_type=MMU_INST_FETCH, addr=18446744072116178925, env=0x555556fdb7c0)
>     at ../../target/i386/tcg/sysemu/excp_helper.c:578
> #17 x86_cpu_tlb_fill
>     (cs=0x555556fd9000, addr=18446744072116178925, size=<optimized out>, access_type=MMU_INST_FETCH, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:604
> #18 0x0000555555c5dd2b in probe_access_internal
>     (cpu=<optimized out>, addr=18446744072116178925, fault_size=fault_size@entry=1, access_type=access_type@entry=MMU_INST_FETCH, mmu_idx=0, nonfault=nonfault@entry=false, phost=0x7ffff56fe0d0, pfull=0x7ffff56fe0c8, retaddr=0, check_mem_cbs=false)
>     at ../../accel/tcg/cputlb.c:1432
> #19 0x0000555555c61ff8 in get_page_addr_code_hostp (env=<optimized out>, addr=addr@entry=18446744072116178925, hostp=hostp@entry=0x0)
>     at ../../accel/tcg/cputlb.c:1603
> #20 0x0000555555c50a2b in get_page_addr_code (addr=18446744072116178925, env=<optimized out>)
>     at /home/jic23/src/qemu/include/exec/exec-all.h:594
> #21 tb_htable_lookup (cpu=<optimized out>, pc=pc@entry=18446744072116178925, cs_base=0, flags=415285936, cflags=4278353920)
>     at ../../accel/tcg/cpu-exec.c:231
> #22 0x0000555555c50c08 in tb_lookup
>     (cpu=cpu@entry=0x555556fd9000, pc=pc@entry=18446744072116178925, cs_base=cs_base@entry=0, flags=<optimized out>, cflags=<optimized out>) at ../../accel/tcg/cpu-exec.c:267
> #23 0x0000555555c51e23 in helper_lookup_tb_ptr (env=0x555556fdb7c0) at ../../accel/tcg/cpu-exec.c:423
> #24 0x00007fffa9076ead in code_gen_buffer ()
> #25 0x0000555555c50fab in cpu_tb_exec (cpu=cpu@entry=0x555556fd9000, itb=<optimized out>, tb_exit=tb_exit@entry=0x7ffff56fe708)
>     at ../../accel/tcg/cpu-exec.c:458
> #26 0x0000555555c51492 in cpu_loop_exec_tb
>     (tb_exit=0x7ffff56fe708, last_tb=<synthetic pointer>, pc=18446744072116179169, tb=<optimized out>, cpu=0x555556fd9000)
>     at ../../accel/tcg/cpu-exec.c:920
> #27 cpu_exec_loop (cpu=cpu@entry=0x555556fd9000, sc=sc@entry=0x7ffff56fe7a0) at ../../accel/tcg/cpu-exec.c:1041
> #28 0x0000555555c51d11 in cpu_exec_setjmp (cpu=cpu@entry=0x555556fd9000, sc=sc@entry=0x7ffff56fe7a0) at ../../accel/tcg/cpu-exec.c:1058
> #29 0x0000555555c523b4 in cpu_exec (cpu=cpu@entry=0x555556fd9000) at ../../accel/tcg/cpu-exec.c:1084
> #30 0x0000555555c74053 in tcg_cpus_exec (cpu=cpu@entry=0x555556fd9000) at ../../accel/tcg/tcg-accel-ops.c:76
> #31 0x0000555555c741a0 in mttcg_cpu_thread_fn (arg=arg@entry=0x555556fd9000) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
> #32 0x0000555555dfb580 in qemu_thread_start (args=0x55555703c3e0) at ../../util/qemu-thread-posix.c:541
> #33 0x00007ffff78176ba in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:444
> #34 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

So, that looks like:
 * we call cpu_tb_exec(), which executes some generated code
 * that generated code calls the lookup_tb_ptr helper to see
   if we have a generated TB already for the address we're going
   to execute next
 * lookup_tb_ptr probes the TLB to see if we know the host RAM
   address for the guest address
 * this results in a TLB walk for an instruction fetch
 * the page table descriptor load is to IO memory
 * io_prepare assumes it needs to do a TLB recompile, because
   can_do_io is clear

I am not surprised that the corner case of "the guest put its
page tables in an MMIO device" has not yet come up :-)

I'm really not sure how the icount handling should interact
with that...

-- PMM
