Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF4248869
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760513; cv=none; b=gDeYqtIbcvdrLl5bDiRGjQDbDQBruUuwAqTmWr/SmITpY5icxZrmJOANFUztHys2hCkO4RllZ0q+rvAKeECIjEas4OwDXRIcMlLghlBtgmbcfNqbYc3Fwsi4A9E2mbqxhGyBY5+sdXwuXK8tUaX8nDF0FKKd0NlBW6a959tNPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760513; c=relaxed/simple;
	bh=wCPt2sU4NNWC0VDrWl0waDeUYGHUxxd2He6zz7PK5sc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyxeKMeDWXeiXWk9vEegtShp8gCkg9d6YOqZ+JrgcB6m0sGVGXCE4EHBVCGI0TfUdKSu77tWMZXf+ZI21U4luH+6sv2tttL4OkK/UI2UcNkD7ENw7+ebS3/mWseRLvXfiUIETPEOsK8slZBmQW4BQrA1bV5BeI0m/aCs9XCim2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b21605ph5z6L4xD;
	Wed, 21 May 2025 01:00:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 87774140373;
	Wed, 21 May 2025 01:01:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 19:01:47 +0200
Date: Tue, 20 May 2025 18:01:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Richard Henderson <richard.henderson@linaro.org>, <linuxarm@huawei.com>
CC: Alistair Francis <alistair23@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 066/147] include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE
 to slow flags
Message-ID: <20250520180035.00004142@huawei.com>
In-Reply-To: <20250508142918.0000248d@huawei.com>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
	<20250422192819.302784-67-richard.henderson@linaro.org>
	<20250425183524.00000b28@huawei.com>
	<CAKmqyKMN5bo12Oh8hrwdiimqJSzHMZwB7JjAquBrEK3PTbtGyA@mail.gmail.com>
	<04875ca2-781b-4000-b74c-fc338bc6ec4d@linaro.org>
	<20250508142918.0000248d@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 8 May 2025 14:29:18 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 29 Apr 2025 19:43:05 -0700
> Richard Henderson <richard.henderson@linaro.org> wrote:
>=20
> > On 4/29/25 14:35, Alistair Francis wrote: =20
> > > On Sat, Apr 26, 2025 at 3:36=E2=80=AFAM Jonathan Cameron via
> > > <qemu-devel@nongnu.org> wrote:   =20
> > >>
> > >> On Tue, 22 Apr 2025 12:26:55 -0700
> > >> Richard Henderson <richard.henderson@linaro.org> wrote:
> > >>   =20
> > >>> Recover two bits from the inline flags.   =20
> > >>
> > >>
> > >> Hi Richard,
> > >>
> > >> Early days but something (I'm fairly sure in this patch) is tripping=
 up my favourite
> > >> TCG corner case of running code out of MMIO memory (interleaved CXL =
memory).
> > >>
> > >> Only seeing it on arm64 tests so far which isn't upstream yet..
> > >> (guess what I was getting ready to post today)
> > >>
> > >> Back trace is:
> > >>
> > >> #0  0x0000555555fd4296 in cpu_atomic_fetch_andq_le_mmu (env=3D0x5555=
57ee19b0, addr=3D18442241572520067072, val=3D18446744073701163007, oi=3D824=
4, retaddr=3D<optimized out>) at ../../accel/tcg/atomic_template.h:140
> > >> #1  0x00007fffb6894125 in code_gen_buffer ()
> > >> #2  0x0000555555fc4c46 in cpu_tb_exec (cpu=3Dcpu@entry=3D0x555557ede=
df0, itb=3Ditb@entry=3D0x7fffb6894000 <code_gen_buffer+200511443>, tb_exit=
=3Dtb_exit@entry=3D0x7ffff4bfb744) at ../../accel/tcg/cpu-exec.c:455
> > >> #3  0x0000555555fc51c2 in cpu_loop_exec_tb (tb_exit=3D0x7ffff4bfb744=
, last_tb=3D<synthetic pointer>, pc=3D<optimized out>, tb=3D0x7fffb6894000 =
<code_gen_buffer+200511443>, cpu=3D0x555557ededf0) at ../../accel/tcg/cpu-e=
xec.c:904
> > >> #4  cpu_exec_loop (cpu=3Dcpu@entry=3D0x555557ededf0, sc=3Dsc@entry=
=3D0x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1018
> > >> #5  0x0000555555fc58f1 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x55555=
7ededf0, sc=3Dsc@entry=3D0x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1035
> > >> #6  0x0000555555fc5f6c in cpu_exec (cpu=3Dcpu@entry=3D0x555557ededf0=
) at ../../accel/tcg/cpu-exec.c:1061
> > >> #7  0x0000555556146ac3 in tcg_cpu_exec (cpu=3Dcpu@entry=3D0x555557ed=
edf0) at ../../accel/tcg/tcg-accel-ops.c:81
> > >> #8  0x0000555556146ee3 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x5=
55557ededf0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:94
> > >> #9  0x00005555561f6450 in qemu_thread_start (args=3D0x555557f8f430) =
at ../../util/qemu-thread-posix.c:541
> > >> #10 0x00007ffff7750aa4 in start_thread (arg=3D<optimized out>) at ./=
nptl/pthread_create.c:447
> > >> #11 0x00007ffff77ddc3c in clone3 () at ../sysdeps/unix/sysv/linux/x8=
6_64/clone3.S:78
> > >>
> > >> I haven't pushed out the rebased tree yet making this a truly awful =
bug report.
> > >>
> > >> The pull request you sent with this in wasn't bisectable so this was=
 a bit of a guessing
> > >> game. I see the seg fault only after this patch.   =20
> > >=20
> > > I see the same thing with some RISC-V tests. I can provide the test
> > > images if you want as well   =20
> >=20
> >=20
> > Yes please.
> >=20
> >=20
> > r~ =20
>=20
> I'm guessing Alastair is busy.
>=20
> I got around to testing this on x86 and indeed blow up is the same.
>=20
> 0x0000555555e3dd77 in cpu_atomic_add_fetchl_le_mmu (env=3D0x55555736bef0,=
 addr=3D140271756837240, val=3D1, oi=3D34, retaddr=3D<optimized out>) at ..=
/../accel/tcg/atomic_template.h:143
> 143     GEN_ATOMIC_HELPER(add_fetch)
> (gdb) bt
> #0  0x0000555555e3dd77 in cpu_atomic_add_fetchl_le_mmu (env=3D0x55555736b=
ef0, addr=3D140271756837240, val=3D1, oi=3D34, retaddr=3D<optimized out>) a=
t ../../accel/tcg/atomic_template.h:143
> #1  0x00007fffbc31c6f0 in code_gen_buffer ()
> #2  0x0000555555e23aa6 in cpu_tb_exec (cpu=3Dcpu@entry=3D0x555557369330, =
itb=3Ditb@entry=3D0x7fffbc31c600 <code_gen_buffer+295441875>, tb_exit=3Dtb_=
exit@entry=3D0x7ffff4bfd6ec) at ../../accel/tcg/cpu-exec.c:438
> #3  0x0000555555e24025 in cpu_loop_exec_tb (tb_exit=3D0x7ffff4bfd6ec, las=
t_tb=3D<synthetic pointer>, pc=3D<optimized out>, tb=3D0x7fffbc31c600 <code=
_gen_buffer+295441875>, cpu=3D0x555557369330) at ../../accel/tcg/cpu-exec.c=
:872
> #4  cpu_exec_loop (cpu=3Dcpu@entry=3D0x555557369330, sc=3Dsc@entry=3D0x7f=
fff4bfd7b0) at ../../accel/tcg/cpu-exec.c:982
> #5  0x0000555555e247a1 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x5555573693=
30, sc=3Dsc@entry=3D0x7ffff4bfd7b0) at ../../accel/tcg/cpu-exec.c:999
> #6  0x0000555555e24e2c in cpu_exec (cpu=3Dcpu@entry=3D0x555557369330) at =
../../accel/tcg/cpu-exec.c:1025
> #7  0x0000555555e42c73 in tcg_cpu_exec (cpu=3Dcpu@entry=3D0x555557369330)=
 at ../../accel/tcg/tcg-accel-ops.c:81
> #8  0x0000555555e43093 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x555557=
369330) at ../../accel/tcg/tcg-accel-ops-mttcg.c:94
> #9  0x0000555555ef2250 in qemu_thread_start (args=3D0x5555573e6e20) at ..=
/../util/qemu-thread-posix.c:541
> #10 0x00007ffff7750aa4 in start_thread (arg=3D<optimized out>) at ./nptl/=
pthread_create.c:447
> #11 0x00007ffff77ddc3c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/=
clone3.S:78
>=20
> Need one patch for my particular setup to work around some DMA buffer iss=
ues in virtio (similar to
> a patch for pci space last year).  I've been meaning to post an RFC to ge=
t feedback on how
> to handle this but not gotten to it yet!
>=20
> From 801e47897c5959a22ed050d7e7feebbbd3a12588 Mon Sep 17 00:00:00 2001
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Date: Mon, 22 Apr 2024 13:54:37 +0100
> Subject: [PATCH] physmem: Increase bounce buffers for "memory" address sp=
ace.
>=20
> Doesn't need to be this big and should be configurable.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  system/physmem.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/system/physmem.c b/system/physmem.c
> index 3f4fd69d9a..651b875827 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2798,6 +2798,7 @@ static void memory_map_init(void)
>      memory_region_init(system_memory, NULL, "system", UINT64_MAX);
>      address_space_init(&address_space_memory, system_memory, "memory");
> =20
> +    address_space_memory.max_bounce_buffer_size =3D 1024 * 1024 * 1024;
>      system_io =3D g_malloc(sizeof(*system_io));
>      memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io=
",
>                            65536);

Hi Richard

As discussed on Friday, I've put test kernel up at https://gitlab.com/jic23=
/qemu-debug
It's just a build of mainline as checked out today. I'll commit the kernel =
config as well
for information.  Nothing particularly special just a lot of stuff built in=
 so=20
you don't need to fuss around with modules in the root fs / initrd etc.

The readme.md file in that repo has instructions to replicate with a typica=
l setup +
shell scripts.  Only thing you'll need to install on the mentioned standard=
 debian nocloud
image is numactl. Otherwise all cut and paste scripts.

Let me know if this either doesn't work for you (should segfault) on numctl=
 -m 2 ls
or there is anything else I can do to help debug this one.

Thanks,

Jonathan

