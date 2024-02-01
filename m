Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722EC5F48C
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800678; cv=none; b=L5Vf75L8e4SZoohbPnSa4wIcff4xDaHgLa47uWc5sRkiMQguzoZhMoP4ZgOw+qDOI0aDmBwUEMLPX7UpodRFASohD4iuadYcp/zfX2wvd6CsFMfTUMo7TVtnDzCgHUTYoru6t7nYJLAjBjXSNLoJ8EIufpGAMNqL8TDwu6ODGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800678; c=relaxed/simple;
	bh=UO7kArbBb3tMppKbSuY7w8ht9GIpb1EKi3YCkbRCnfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CSS7ZxlsTVlHSyeYb1HI04SknhEGTccW9ia+zxLeWyOTtsqUwwxlxUYtW1xwlOBQkbOCg9c1/WBXdljaqp7o3Ie8Qee/lqkKux0hFCUa9BlbkppokuUOTdiP9Z8OX1gj4jQX2REQ/IuWyFyJRnpSoe7OWSCLK7EQqm+jMrxLfzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H4IjAjjN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4IjAjjN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso8785395e9.3
        for <linux-cxl@vger.kernel.org>; Thu, 01 Feb 2024 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706800674; x=1707405474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUJvKbgUShvcNix3bLT53w7WZVTT9v8XQDwDHAtkVak=;
        b=H4IjAjjN35JF6raEhs4Yfy4vzhiTEv3MWb1fMCdZHor9fdIdEWnBN5RlBTXT4QQaUd
         Lzrr0HDR9nOKTKjDzCxGAHdz1D9toxgJu6YjbKuxiqjBlY8pGwCGhkw0cneD/DJv/Mf7
         S3eO7pa5ypFIfpMkZKNXaU0HzyFGGCqFLsqqP6EOLt9w2OYqvPrtr9rCybBNXRKBncKc
         MFSMCmM1XKExVM27OC0FUAaIo3UlJ9G9C7/1C5F5dWOkIYYmtwWtbGV+4r0ZSBBtSwjV
         wzLDqmf2edZ+C+JiSxhV4MCQ3CwLFEaZeyTCDVXaylpJaLFi4Hz5iyjMpLsQFw3Ggjhb
         GXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800674; x=1707405474;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FUJvKbgUShvcNix3bLT53w7WZVTT9v8XQDwDHAtkVak=;
        b=vc8aLV+OWjj3h/pD5Qk9oFRrNgz74psQM1gJG5kRvE8rknhNwoh27H9ya0Ko48VuCH
         rw1H6P97sj2o1XfiruVhod2n7pPzwKnn49Aska7yDtP9rdRrZ9gHO4yfH65EBawTVAF+
         +deTDTnmss6M0kWCNattKYrl0qy43q/2Zc4Limr+kHTkg5PMS2YWX+x05wg0VqhPAmGm
         pEov1lTk8S/P5yxAGobI+fRGRLUOQHaL2J4PBHAhOZPdt+NF/fS3p6PT/8n9jnKVOjcj
         K26x9RlkEj0ilja+lywhFEpd9bLM3yAsFX3f4PRBVi+gxY0F739OoRQujOF43FJdP3J/
         QT+Q==
X-Gm-Message-State: AOJu0Yz234aMAmKX3UH6ucrlw1W+AYAF4lW2+RAEvtFfFAzJM4VGArTX
	tEKd0yEeFy6GYBzL0/foR1YGGkiw4dsb/W+VpIH4ULlfrFhgoMiR6qhjeB4Xywk=
X-Google-Smtp-Source: AGHT+IHqNwbRTDKuNiWXp7JHfZveH2s2JcoTDYTaoUHFAp2OjWDl1l6e2VV1HDTAk/opSHtq1uXvtA==
X-Received: by 2002:a05:600c:358b:b0:40e:af03:5f8d with SMTP id p11-20020a05600c358b00b0040eaf035f8dmr1847495wmq.8.1706800674616;
        Thu, 01 Feb 2024 07:17:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwc5clXq2gzWSAW4WkBMQ3Rd7Wh/mSXpU5AAOkNNm4b3xrwJaIRZUQMBRubhJk87/NO5ZUUkLzSB6nJCH+rFR9OcohTIhDWN1TDdVk4QgFbQxF4lhlFfpgtzi5pWljpmOBobzfqnWJBFfSW+xMC+5p0UVXLPSkZ8I6ZPGYH0D5uAW3y+Km0jk+vhYgk3wDqqkEJVYOtWAAuENEx1Swrw0pJCIA4ETONZ74dRAeEAAcATVjAcVP5b9IBAaOGV1rDaNE02SUAjE3qcUNh/U=
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id m39-20020a05600c3b2700b0040fb7695620sm3086165wms.0.2024.02.01.07.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:17:54 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id CCD655F7AF;
	Thu,  1 Feb 2024 15:17:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Sajjan Rao
 <sajjanr@gmail.com>,  Gregory Price <gregory.price@memverge.com>,
  Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
  linux-cxl@vger.kernel.org,  qemu-devel@nongnu.org,
  richard.henderson@linaro.org
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
In-Reply-To: <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
	(Peter Maydell's message of "Thu, 1 Feb 2024 14:35:56 +0000")
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
	<CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
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
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 15:17:53 +0000
Message-ID: <87msskkyce.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 1 Feb 2024 at 14:01, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>> > Can you run QEMU under gdb and give the backtrace when it stops
>> > on the abort() ? That will probably have a helpful clue. I
>> > suspect something is failing to pass a valid retaddr in
>> > when it calls a load/store function.
>
>> [Switching to Thread 0x7ffff56ff6c0 (LWP 21916)]
>> __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<optimi=
zed out>) at ./nptl/pthread_kill.c:44
>> 44      ./nptl/pthread_kill.c: No such file or directory.
>> (gdb) bt
>> #0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<op=
timized out>) at ./nptl/pthread_kill.c:44
>> #1  __pthread_kill_internal (signo=3D6, threadid=3D<optimized out>) at .=
/nptl/pthread_kill.c:78
>> #2  __GI___pthread_kill (threadid=3D<optimized out>, signo=3Dsigno@entry=
=3D6) at ./nptl/pthread_kill.c:89
>> #3  0x00007ffff77c43b6 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps=
/posix/raise.c:26
>> #4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
>> #5  0x0000555555c0d4ce in cpu_abort
>>     (cpu=3Dcpu@entry=3D0x555556fd9000, fmt=3Dfmt@entry=3D0x555555fe3378 =
"cpu_io_recompile: could not find TB for pc=3D%p")
>>     at ../../cpu-target.c:359
>> #6  0x0000555555c59435 in cpu_io_recompile (cpu=3Dcpu@entry=3D0x555556fd=
9000, retaddr=3Dretaddr@entry=3D0) at ../../accel/tcg/translate-all.c:611
>> #7  0x0000555555c5c956 in io_prepare
>>     (retaddr=3D0, addr=3D19595792376, attrs=3D..., xlat=3D<optimized out=
>, cpu=3D0x555556fd9000, out_offset=3D<synthetic pointer>)
>>     at ../../accel/tcg/cputlb.c:1339
<snip>
>> #21 tb_htable_lookup (cpu=3D<optimized out>, pc=3Dpc@entry=3D18446744072=
116178925, cs_base=3D0, flags=3D415285936, cflags=3D4278353920)
>>     at ../../accel/tcg/cpu-exec.c:231
>> #22 0x0000555555c50c08 in tb_lookup
>>     (cpu=3Dcpu@entry=3D0x555556fd9000, pc=3Dpc@entry=3D18446744072116178=
925, cs_base=3Dcs_base@entry=3D0, flags=3D<optimized out>, cflags=3D<optimi=
zed out>) at ../../accel/tcg/cpu-exec.c:267
>> #23 0x0000555555c51e23 in helper_lookup_tb_ptr (env=3D0x555556fdb7c0) at=
 ../../accel/tcg/cpu-exec.c:423
>> #24 0x00007fffa9076ead in code_gen_buffer ()
>> #25 0x0000555555c50fab in cpu_tb_exec (cpu=3Dcpu@entry=3D0x555556fd9000,=
 itb=3D<optimized out>, tb_exit=3Dtb_exit@entry=3D0x7ffff56fe708)
>>     at ../../accel/tcg/cpu-exec.c:458
>> #26 0x0000555555c51492 in cpu_loop_exec_tb
>>     (tb_exit=3D0x7ffff56fe708, last_tb=3D<synthetic pointer>, pc=3D18446=
744072116179169, tb=3D<optimized out>, cpu=3D0x555556fd9000)
>>     at ../../accel/tcg/cpu-exec.c:920
>> #27 cpu_exec_loop (cpu=3Dcpu@entry=3D0x555556fd9000, sc=3Dsc@entry=3D0x7=
ffff56fe7a0) at ../../accel/tcg/cpu-exec.c:1041
>> #28 0x0000555555c51d11 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x555556fd9=
000, sc=3Dsc@entry=3D0x7ffff56fe7a0) at ../../accel/tcg/cpu-exec.c:1058
>> #29 0x0000555555c523b4 in cpu_exec (cpu=3Dcpu@entry=3D0x555556fd9000) at=
 ../../accel/tcg/cpu-exec.c:1084
>> #30 0x0000555555c74053 in tcg_cpus_exec (cpu=3Dcpu@entry=3D0x555556fd900=
0) at ../../accel/tcg/tcg-accel-ops.c:76
>> #31 0x0000555555c741a0 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x55555=
6fd9000) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
>> #32 0x0000555555dfb580 in qemu_thread_start (args=3D0x55555703c3e0) at .=
./../util/qemu-thread-posix.c:541
>> #33 0x00007ffff78176ba in start_thread (arg=3D<optimized out>) at ./nptl=
/pthread_create.c:444
>> #34 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64=
/clone3.S:81
>
> So, that looks like:
>  * we call cpu_tb_exec(), which executes some generated code
>  * that generated code calls the lookup_tb_ptr helper to see
>    if we have a generated TB already for the address we're going
>    to execute next
>  * lookup_tb_ptr probes the TLB to see if we know the host RAM
>    address for the guest address
>  * this results in a TLB walk for an instruction fetch
>  * the page table descriptor load is to IO memory
>  * io_prepare assumes it needs to do a TLB recompile, because
>    can_do_io is clear
>
> I am not surprised that the corner case of "the guest put its
> page tables in an MMIO device" has not yet come up :-)
>
> I'm really not sure how the icount handling should interact
> with that...

Its not just icount - we need to handle it for all modes now. That said
seeing as we are at the end of a block shouldn't can_do_io be set?

Does:

modified   accel/tcg/translator.c
@@ -201,6 +201,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *t=
b, int *max_insns,
         }
     }
=20
+    set_can_do_io(db, true);
+
     /* Emit code to exit the TB, as indicated by db->is_jmp.  */
     ops->tb_stop(db, cpu);
     gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);

do the trick?

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
