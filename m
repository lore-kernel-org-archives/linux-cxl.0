Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298EF4F8
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891615; cv=none; b=uzDjOyxczwh+DNoUTcULHyHMhSOkqDsvMRHnu9loowMcmjFHW/5aSeHbrjBpjTULjNOt0G5rKgffZHKhx2upbGpnpnZ9TXnp0jr3Qg6f0biaEnuhbdX5/oC6r/IGRPOwq0Ri+xuEADb9SdXWPMGFyZh9IURYt5mWvV752cVBWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891615; c=relaxed/simple;
	bh=op/tp/PFVDaabAhC5yhQEkOiRvaJKl8TUwsCfhubPls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzYNoTZuw1dmrw06QRLhbtVAGMQsHedzvvrHdoYtEnE7l9aR59Sai03xViHJwN9Odd4C00t1bpp2Y73+1/iRznV2Rs8N+WfPX+senWkF+7qgiRfLiIqdzifW67ES5NsfrVk1nQQB5r3a6P7GoQCVqNxs9b1KmbvqP1fGQO2SS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DG326wLs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DG326wLs"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso3027993a12.0
        for <linux-cxl@vger.kernel.org>; Fri, 02 Feb 2024 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706891611; x=1707496411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9LdZ7rTnVWaosibzs/+L1FpeFFK86dFXb7hh0F2lbe0=;
        b=DG326wLs+W5Hl4bXkSjhA2u+3RZghoz1zrl7OAPzfQfj+YZKLDqS1ubKhoon4LTdeg
         Mu7D/1E7j/fTqQZhr28SnfniuFxGgUsvT6Ru7/d0ggEsG+rAU33UlyP0+k7NpeNBNsP6
         BEx1mtaw/6LYhiWtZNMfxvw6zbbxAiHKKYNwZRu2Hwqj/sR2DQTbpalZKYeyvwcxrcAz
         D8ZhV8xHq77M75FehsnOXv7qpTmpU5fIchO8ulGdpHmpcVBrwM9S39yXJ+zqx6vAXs3a
         2iqJare3/Cdc4rUx3wVO7WbQyYGu5d+SSP6c1soIU7hY9ThGZHYmi1Wu3ThBB44+7N61
         xuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891611; x=1707496411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LdZ7rTnVWaosibzs/+L1FpeFFK86dFXb7hh0F2lbe0=;
        b=E3KOUV0C/2NI+91TG2wPjc7LVcwYhUCHuxupNyKMeXnIp8ivGHvkODbg/pNWU1hHj4
         oaqUP0sFskpPzUY+dgw1B5zKnx5zqCbWHfs23aktwCSi0QF5glqA1BKqclFi+rSEKAUt
         KCs7yUmwQwQH5OHlNAuvfv2ZXfwMUttboLwiScG/FB2UWrzaKKHM5hLCMFdqlSbFvaj7
         O2O2fzUvsHmzvpDIIPQAxOHwme3gT3KDUMpGkiOrvAhuTBkQ6gZwOXh6a8vtB/sCVVVp
         9AQLh2O6Um5BsqjV8OkWRyNFgYpDZPTda43Y5lwiUfiW6j/oJ1A09/zaxy1eBFQRV2n9
         B90Q==
X-Gm-Message-State: AOJu0Yyiy4Y9rYCo8O+rrKrgAUxwzT8EwM8Tva8+qPB3JcH2XEOcAOkW
	bWdodrVbT1qLxx724pT2BZIUydGOOwEokmNtZRYXthmQSf0m6P8T6kzDPJ4rTg0Cs4N4ZqMG+1j
	KA5psUocznoej7+p9lPdOOL9Vw7f2r0QIrjz0zA==
X-Google-Smtp-Source: AGHT+IEkuQlF2nzi7pqzt6rtEWIlxA9lyO3nPuKmyFQIY/i7wWrNdMAS4XMS4MFp2yEFCWNSw9QDPeR5Y8FvIiylZl8=
X-Received: by 2002:aa7:d71a:0:b0:55f:fd77:7b2d with SMTP id
 t26-20020aa7d71a000000b0055ffd777b2dmr141937edq.5.1706891611313; Fri, 02 Feb
 2024 08:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com> <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org> <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com> <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com> <87r0hwjdvl.fsf@draig.linaro.org>
 <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
 <ZbvpSaOXzZkqDd6c@memverge.com> <20240202162633.0000453c@huawei.com>
In-Reply-To: <20240202162633.0000453c@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 16:33:20 +0000
Message-ID: <CAFEAcA-32--EmbzewL8WfAPanoWQ-eRpkjKuDLc5uV04wpOCpw@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregory Price <gregory.price@memverge.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, 
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, 
	richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 16:26, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> New exciting trace...
> Thread 5 "qemu-system-x86" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7ffff4efe6c0 (LWP 16503)]
> __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:44
> Download failed: Invalid argument.  Continuing without source file ./nptl/./nptl/pthread_kill.c.
> 44      ./nptl/pthread_kill.c: No such file or directory.
> (gdb) bt
> #0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:44
> #1  __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
> #2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at ./nptl/pthread_kill.c:89
> #3  0x00007ffff77c43b6 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
> #5  0x00007ffff7b2ed1e in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #6  0x00007ffff7b9622e in g_assertion_message_expr () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #7  0x0000555555ab1929 in bql_lock_impl (file=0x555556049122 "../../accel/tcg/cputlb.c", line=2033) at ../../system/cpus.c:524
> #8  bql_lock_impl (file=file@entry=0x555556049122 "../../accel/tcg/cputlb.c", line=line@entry=2033) at ../../system/cpus.c:520
> #9  0x0000555555c9f7d6 in do_ld_mmio_beN (cpu=0x5555578e0cb0, full=0x7ffe88012950, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2033
> #10 0x0000555555ca0fbd in do_ld_8 (cpu=cpu@entry=0x5555578e0cb0, p=p@entry=0x7ffff4efd1d0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
> #11 0x0000555555ca341f in do_ld8_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=19595792376, oi=oi@entry=52, ra=0, ra@entry=52, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
> #12 0x0000555555ca5f59 in cpu_ldq_mmu (ra=52, oi=52, addr=19595792376, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
> #13 cpu_ldq_le_mmuidx_ra (env=0x5555578e3470, addr=19595792376, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:301
> #14 0x0000555555b4b5fc in ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:98
> #15 ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:93
> #16 mmu_translate (env=env@entry=0x5555578e3470, in=0x7ffff4efd3e0, out=0x7ffff4efd3b0, err=err@entry=0x7ffff4efd3c0, ra=ra@entry=0) at ../../target/i386/tcg/sysemu/excp_helper.c:174
> #17 0x0000555555b4c4b3 in get_physical_address (ra=0, err=0x7ffff4efd3c0, out=0x7ffff4efd3b0, mmu_idx=0, access_type=MMU_DATA_LOAD, addr=18446741874686299840, env=0x5555578e3470) at ../../target/i386/tcg/sysemu/excp_helper.c:580
> #18 x86_cpu_tlb_fill (cs=0x5555578e0cb0, addr=18446741874686299840, size=<optimized out>, access_type=MMU_DATA_LOAD, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:606
> #19 0x0000555555ca0ee9 in tlb_fill (retaddr=0, mmu_idx=0, access_type=MMU_DATA_LOAD, size=<optimized out>, addr=18446741874686299840, cpu=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1315
> #20 mmu_lookup1 (cpu=cpu@entry=0x5555578e0cb0, data=data@entry=0x7ffff4efd540, mmu_idx=0, access_type=access_type@entry=MMU_DATA_LOAD, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:1713
> #21 0x0000555555ca2c61 in mmu_lookup (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=18446741874686299840, oi=oi@entry=32, ra=ra@entry=0, type=type@entry=MMU_DATA_LOAD, l=l@entry=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1803
> #22 0x0000555555ca3165 in do_ld4_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=18446741874686299840, oi=oi@entry=32, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2416
> #23 0x0000555555ca5ef9 in cpu_ldl_mmu (ra=0, oi=32, addr=18446741874686299840, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:158
> #24 cpu_ldl_le_mmuidx_ra (env=env@entry=0x5555578e3470, addr=addr@entry=18446741874686299840, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:294
> #25 0x0000555555bb6cdd in do_interrupt64 (is_hw=1, next_eip=18446744072399775809, error_code=0, is_int=0, intno=236, env=0x5555578e3470) at ../../target/i386/tcg/seg_helper.c:889
> #26 do_interrupt_all (cpu=cpu@entry=0x5555578e0cb0, intno=236, is_int=is_int@entry=0, error_code=error_code@entry=0, next_eip=next_eip@entry=0, is_hw=is_hw@entry=1) at ../../target/i386/tcg/seg_helper.c:1130
> #27 0x0000555555bb87da in do_interrupt_x86_hardirq (env=env@entry=0x5555578e3470, intno=<optimized out>, is_hw=is_hw@entry=1) at ../../target/i386/tcg/seg_helper.c:1162
> #28 0x0000555555b5039c in x86_cpu_exec_interrupt (cs=0x5555578e0cb0, interrupt_request=<optimized out>) at ../../target/i386/tcg/sysemu/seg_helper.c:197
> #29 0x0000555555c94480 in cpu_handle_interrupt (last_tb=<synthetic pointer>, cpu=0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:844
> #30 cpu_exec_loop (cpu=cpu@entry=0x5555578e0cb0, sc=sc@entry=0x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:951
> #31 0x0000555555c94791 in cpu_exec_setjmp (cpu=cpu@entry=0x5555578e0cb0, sc=sc@entry=0x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:1029
> #32 0x0000555555c94f7c in cpu_exec (cpu=cpu@entry=0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:1055
> #33 0x0000555555cb9043 in tcg_cpu_exec (cpu=cpu@entry=0x5555578e0cb0) at ../../accel/tcg/tcg-accel-ops.c:76
> #34 0x0000555555cb91a0 in mttcg_cpu_thread_fn (arg=arg@entry=0x5555578e0cb0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
> #35 0x0000555555e57270 in qemu_thread_start (args=0x555557956000) at ../../util/qemu-thread-posix.c:541
> #36 0x00007ffff78176ba in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:444
> #37 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>

Here we are trying to take an interrupt. This isn't related to the
other can_do_io stuff, it's happening because do_ld_mmio_beN assumes
it's called with the BQL not held, but in fact there are some
situations where we call into the memory subsystem and we do
already have the BQL.

-- PMM
