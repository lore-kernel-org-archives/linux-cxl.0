Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A01D5178
	for <linux-cxl@vger.kernel.org>; Sat, 24 May 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748097718; cv=none; b=Sos8LqBn7qiz7Y5pHDgk6CZRWJnQ5rT7vIj5y2fDsVo3377JjbcyelSEo4la1fyM6I/pr/bJcABu13y42t+pv1kF1O5pUzjRMaVN51rYLz8gq9HqLnyY3LzVHHM9fU8ppm/87EusehWrjzZCKsqZ0bZF3kGjfWtPR+Fvph6ZjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748097718; c=relaxed/simple;
	bh=3yk4kv5Vua39U0oEQdYRIW5/0QgeuqhS4bv8/jzMGuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqaHtnMNz6bzZYJ/IHpeyvNVe3Z6cYrZSPuPx1EM+6tUVAYI4dy3jhloqxHoqaIu9qoboMYtuZmleGewLr3R/O2uB6oGaBRoLHx07yTlICWV6YVm4NUXZZV1Nxukzr5jluCUZusrhMBRSfUjMf3q9ROXf0lXWdpPVbC/QK5BiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JBQTxU9J; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBQTxU9J"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-601dd3dfc1fso1650673a12.0
        for <linux-cxl@vger.kernel.org>; Sat, 24 May 2025 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748097715; x=1748702515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X00GC3Z/p6aWDzGGqhVH3t/681NDinTLeQwjLaoVPps=;
        b=JBQTxU9JATE80QbD8q4Jo+BCO4LoWPyxVGin9q/GBbYnXIG0kQ28dVEnLj0yb5K9U0
         XimnKxXNmurfX6Cdqhh7cf3UAfYaECTNlL1oM6mxhhpjhrG8h9fKE0p5CGg6l8nlO/GN
         2SiT3xOBwuMpi8yNZ0/94jadXdS1Cf/DRayhAfAdXfB76V7CBS20MzgDC5zN0bapcajB
         cGQbsY0rGXoE5oD1acgs/waOI5GC+8QQDb+AVlyuKDWrrLqA4SNrF0E4pOmyqpYWhCfZ
         a4UtgH1QzNMQCz/gi9YJFcgbLIYfaRH/7nMLXsuxA9J4Sv6FT9KysyI2lKNrQ/kS/ILo
         627w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748097715; x=1748702515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X00GC3Z/p6aWDzGGqhVH3t/681NDinTLeQwjLaoVPps=;
        b=k2dOXasnk806ycxMBJ6/Cbc6IWTuwkrZPqLbT/eyFCmrTVPoPTUpWrg9K4C9YVK1vM
         PD6BQOmcuaHDqiBqFJElE9LH/Pl0BNZwq9liFMk21DmUZJ72Isn3a4nHovYcb1ZHAsTw
         Wm+Bx1cHBJZDO6cA/ij96YNEv2uJ9r6gLfD/fYoEg+WVdZ3Gq/84O6ha6LGPpvVY/ZG9
         vNRE9mmrWGO5HSPL/gdOIPClhaBeSUdNhYNhFBqtmrAWHbqpjV0C0rcCFXE1yp4vb9r1
         0nIv7dP1jWlwOuf3ceuLtp6pJCmP/JXJmquzG6HttsBm7nplbj2pfacw5GE9Fa1ZBm+9
         v15Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRrCD5/Lda+5A5g86osUNcF6mLUVaSWT0tVOo4j2pPGoNZNmxcRHqzBGYSin9cUvRmTz5zHJ72wLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvifZp57Bk2lv4Yy0JOU/kZj1DKBg2/lqQAaBXZqOZRu7Ae9PF
	vM08EfOGzBNFJXzhGvNPj2PFYRHURN2LFKwhWGJ7aAgx22jvbJDSRosx4E7C2iKrA8E=
X-Gm-Gg: ASbGncuULdKsIHbtrXIDWg7YQZ9ks414Wrh0tmY5j3jdEVFaPWloyZqb+JfenLLhf09
	207GBsky1gZ0SkBy4I3oQfZF3EgT+9PYaebuD4YKX/CasbZa+Rlhxxv+K27ESQXi6L/l4WgIiJE
	oNsnd5gQFyHGE7crh7EM242ty9EyQG0a6RiZhTSq2JURK5J0ZCMt+E/CDKP5esDQRa/mO/gkVSM
	IHcytJyuwHAUa2lNBUs1huW7igHfnsrB0dBPIQG1l12h9eL2Hxqh9cHa7ZvW0RxkzOG6Lpe07VO
	bSkQXaElauP6rd9fhJDZavJO9MGYUP9oP25/8GveNze/qrQx+pUV69SCQJ6LjKljeDhdiCSSi+B
	c
X-Google-Smtp-Source: AGHT+IEmEMCSFw1PCkzy76eKNiIdrSzFH9IGCtAmMsLkDM+vCWkR9vZLn8RjaJmWXpAhZ5PbN3z5yg==
X-Received: by 2002:aa7:c312:0:b0:602:f026:7cf0 with SMTP id 4fb4d7f45d1cf-602f0267d74mr1243303a12.21.1748097714902;
        Sat, 24 May 2025 07:41:54 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60451d367cfsm437358a12.22.2025.05.24.07.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 May 2025 07:41:54 -0700 (PDT)
Message-ID: <42c3669d-0d04-4f6b-b1f7-5455beaeeb38@linaro.org>
Date: Sat, 24 May 2025 15:41:51 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 066/147] include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to
 slow flags
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linuxarm@huawei.com
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-67-richard.henderson@linaro.org>
 <20250425183524.00000b28@huawei.com>
 <CAKmqyKMN5bo12Oh8hrwdiimqJSzHMZwB7JjAquBrEK3PTbtGyA@mail.gmail.com>
 <04875ca2-781b-4000-b74c-fc338bc6ec4d@linaro.org>
 <20250508142918.0000248d@huawei.com> <20250520180035.00004142@huawei.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250520180035.00004142@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/25 18:01, Jonathan Cameron wrote:
> On Thu, 8 May 2025 14:29:18 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
>> On Tue, 29 Apr 2025 19:43:05 -0700
>> Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>>> On 4/29/25 14:35, Alistair Francis wrote:
>>>> On Sat, Apr 26, 2025 at 3:36 AM Jonathan Cameron via
>>>> <qemu-devel@nongnu.org> wrote:
>>>>>
>>>>> On Tue, 22 Apr 2025 12:26:55 -0700
>>>>> Richard Henderson <richard.henderson@linaro.org> wrote:
>>>>>     
>>>>>> Recover two bits from the inline flags.
>>>>>
>>>>>
>>>>> Hi Richard,
>>>>>
>>>>> Early days but something (I'm fairly sure in this patch) is tripping up my favourite
>>>>> TCG corner case of running code out of MMIO memory (interleaved CXL memory).
>>>>>
>>>>> Only seeing it on arm64 tests so far which isn't upstream yet..
>>>>> (guess what I was getting ready to post today)
>>>>>
>>>>> Back trace is:
>>>>>
>>>>> #0  0x0000555555fd4296 in cpu_atomic_fetch_andq_le_mmu (env=0x555557ee19b0, addr=18442241572520067072, val=18446744073701163007, oi=8244, retaddr=<optimized out>) at ../../accel/tcg/atomic_template.h:140
>>>>> #1  0x00007fffb6894125 in code_gen_buffer ()
>>>>> #2  0x0000555555fc4c46 in cpu_tb_exec (cpu=cpu@entry=0x555557ededf0, itb=itb@entry=0x7fffb6894000 <code_gen_buffer+200511443>, tb_exit=tb_exit@entry=0x7ffff4bfb744) at ../../accel/tcg/cpu-exec.c:455
>>>>> #3  0x0000555555fc51c2 in cpu_loop_exec_tb (tb_exit=0x7ffff4bfb744, last_tb=<synthetic pointer>, pc=<optimized out>, tb=0x7fffb6894000 <code_gen_buffer+200511443>, cpu=0x555557ededf0) at ../../accel/tcg/cpu-exec.c:904
>>>>> #4  cpu_exec_loop (cpu=cpu@entry=0x555557ededf0, sc=sc@entry=0x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1018
>>>>> #5  0x0000555555fc58f1 in cpu_exec_setjmp (cpu=cpu@entry=0x555557ededf0, sc=sc@entry=0x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1035
>>>>> #6  0x0000555555fc5f6c in cpu_exec (cpu=cpu@entry=0x555557ededf0) at ../../accel/tcg/cpu-exec.c:1061
>>>>> #7  0x0000555556146ac3 in tcg_cpu_exec (cpu=cpu@entry=0x555557ededf0) at ../../accel/tcg/tcg-accel-ops.c:81
>>>>> #8  0x0000555556146ee3 in mttcg_cpu_thread_fn (arg=arg@entry=0x555557ededf0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:94
>>>>> #9  0x00005555561f6450 in qemu_thread_start (args=0x555557f8f430) at ../../util/qemu-thread-posix.c:541
>>>>> #10 0x00007ffff7750aa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
>>>>> #11 0x00007ffff77ddc3c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
>>>>>
>>>>> I haven't pushed out the rebased tree yet making this a truly awful bug report.
>>>>>
>>>>> The pull request you sent with this in wasn't bisectable so this was a bit of a guessing
>>>>> game. I see the seg fault only after this patch.
>>>>
>>>> I see the same thing with some RISC-V tests. I can provide the test
>>>> images if you want as well
>>>
>>>
>>> Yes please.
>>>
>>>
>>> r~
>>
>> I'm guessing Alastair is busy.
>>
>> I got around to testing this on x86 and indeed blow up is the same.
>>
>> 0x0000555555e3dd77 in cpu_atomic_add_fetchl_le_mmu (env=0x55555736bef0, addr=140271756837240, val=1, oi=34, retaddr=<optimized out>) at ../../accel/tcg/atomic_template.h:143
>> 143     GEN_ATOMIC_HELPER(add_fetch)
>> (gdb) bt
>> #0  0x0000555555e3dd77 in cpu_atomic_add_fetchl_le_mmu (env=0x55555736bef0, addr=140271756837240, val=1, oi=34, retaddr=<optimized out>) at ../../accel/tcg/atomic_template.h:143
>> #1  0x00007fffbc31c6f0 in code_gen_buffer ()
>> #2  0x0000555555e23aa6 in cpu_tb_exec (cpu=cpu@entry=0x555557369330, itb=itb@entry=0x7fffbc31c600 <code_gen_buffer+295441875>, tb_exit=tb_exit@entry=0x7ffff4bfd6ec) at ../../accel/tcg/cpu-exec.c:438
>> #3  0x0000555555e24025 in cpu_loop_exec_tb (tb_exit=0x7ffff4bfd6ec, last_tb=<synthetic pointer>, pc=<optimized out>, tb=0x7fffbc31c600 <code_gen_buffer+295441875>, cpu=0x555557369330) at ../../accel/tcg/cpu-exec.c:872
>> #4  cpu_exec_loop (cpu=cpu@entry=0x555557369330, sc=sc@entry=0x7ffff4bfd7b0) at ../../accel/tcg/cpu-exec.c:982
>> #5  0x0000555555e247a1 in cpu_exec_setjmp (cpu=cpu@entry=0x555557369330, sc=sc@entry=0x7ffff4bfd7b0) at ../../accel/tcg/cpu-exec.c:999
>> #6  0x0000555555e24e2c in cpu_exec (cpu=cpu@entry=0x555557369330) at ../../accel/tcg/cpu-exec.c:1025
>> #7  0x0000555555e42c73 in tcg_cpu_exec (cpu=cpu@entry=0x555557369330) at ../../accel/tcg/tcg-accel-ops.c:81
>> #8  0x0000555555e43093 in mttcg_cpu_thread_fn (arg=arg@entry=0x555557369330) at ../../accel/tcg/tcg-accel-ops-mttcg.c:94
>> #9  0x0000555555ef2250 in qemu_thread_start (args=0x5555573e6e20) at ../../util/qemu-thread-posix.c:541
>> #10 0x00007ffff7750aa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
>> #11 0x00007ffff77ddc3c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
>>
>> Need one patch for my particular setup to work around some DMA buffer issues in virtio (similar to
>> a patch for pci space last year).  I've been meaning to post an RFC to get feedback on how
>> to handle this but not gotten to it yet!
>>
>>  From 801e47897c5959a22ed050d7e7feebbbd3a12588 Mon Sep 17 00:00:00 2001
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Date: Mon, 22 Apr 2024 13:54:37 +0100
>> Subject: [PATCH] physmem: Increase bounce buffers for "memory" address space.
>>
>> Doesn't need to be this big and should be configurable.
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   system/physmem.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 3f4fd69d9a..651b875827 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2798,6 +2798,7 @@ static void memory_map_init(void)
>>       memory_region_init(system_memory, NULL, "system", UINT64_MAX);
>>       address_space_init(&address_space_memory, system_memory, "memory");
>>   
>> +    address_space_memory.max_bounce_buffer_size = 1024 * 1024 * 1024;
>>       system_io = g_malloc(sizeof(*system_io));
>>       memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io",
>>                             65536);
> 
> Hi Richard
> 
> As discussed on Friday, I've put test kernel up at https://gitlab.com/jic23/qemu-debug
> It's just a build of mainline as checked out today. I'll commit the kernel config as well
> for information.  Nothing particularly special just a lot of stuff built in so
> you don't need to fuss around with modules in the root fs / initrd etc.
> 
> The readme.md file in that repo has instructions to replicate with a typical setup +
> shell scripts.  Only thing you'll need to install on the mentioned standard debian nocloud
> image is numactl. Otherwise all cut and paste scripts.
> 
> Let me know if this either doesn't work for you (should segfault) on numctl -m 2 ls
> or there is anything else I can do to help debug this one.

Got it.  I failed to reconstruct tlb flags properly in the cmpxchg path,
which causes a crash for cmpxchg on mmio.

r~
