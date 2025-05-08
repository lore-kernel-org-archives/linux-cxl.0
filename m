Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D822A80C
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710970; cv=none; b=g1xVM3zszh8/3TcOhZXC1CWOgL19jUWdlV2VGpw6NyhL8hTnOCv8o8A4sorI29cegugHjtwm6ta4rGmUo3LvnCmlj5ryfb/3SXG7QK+W1WU6g0K4/fgWkmcywMTUiO7e1DmvjReUxswiEr1S7OykRUGEWGAU7XPO54LGGZYWgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710970; c=relaxed/simple;
	bh=rX796bG2TzxLADgdKqJGBLB/cjU2nQCU0GKpvjtpYOI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srvicsvhzIN9MGDojE82dqyXvr/M++YY5xZNqmg5n2+768xCOdMrueFIqJRrCkKP+nhmAlMHDU+8Mikb6Tn5bOpdL777JIvHAcOOFBIbZ1qRxlW+wexU81uB9/tEYnbTOS6CXqh7tuq/mRZDj1QIjhvp8Y8cays2FmdyeKbDtlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZtXtC4hQSz6M4Ys;
	Thu,  8 May 2025 21:24:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BCE51402A5;
	Thu,  8 May 2025 21:29:24 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 8 May
 2025 15:29:23 +0200
Date: Thu, 8 May 2025 14:29:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: Alistair Francis <alistair23@gmail.com>, <qemu-devel@nongnu.org>,
	<linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 066/147] include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE
 to slow flags
Message-ID: <20250508142918.0000248d@huawei.com>
In-Reply-To: <04875ca2-781b-4000-b74c-fc338bc6ec4d@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
	<20250422192819.302784-67-richard.henderson@linaro.org>
	<20250425183524.00000b28@huawei.com>
	<CAKmqyKMN5bo12Oh8hrwdiimqJSzHMZwB7JjAquBrEK3PTbtGyA@mail.gmail.com>
	<04875ca2-781b-4000-b74c-fc338bc6ec4d@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Apr 2025 19:43:05 -0700
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 4/29/25 14:35, Alistair Francis wrote:
> > On Sat, Apr 26, 2025 at 3:36=E2=80=AFAM Jonathan Cameron via
> > <qemu-devel@nongnu.org> wrote: =20
> >>
> >> On Tue, 22 Apr 2025 12:26:55 -0700
> >> Richard Henderson <richard.henderson@linaro.org> wrote:
> >> =20
> >>> Recover two bits from the inline flags. =20
> >>
> >>
> >> Hi Richard,
> >>
> >> Early days but something (I'm fairly sure in this patch) is tripping u=
p my favourite
> >> TCG corner case of running code out of MMIO memory (interleaved CXL me=
mory).
> >>
> >> Only seeing it on arm64 tests so far which isn't upstream yet..
> >> (guess what I was getting ready to post today)
> >>
> >> Back trace is:
> >>
> >> #0  0x0000555555fd4296 in cpu_atomic_fetch_andq_le_mmu (env=3D0x555557=
ee19b0, addr=3D18442241572520067072, val=3D18446744073701163007, oi=3D8244,=
 retaddr=3D<optimized out>) at ../../accel/tcg/atomic_template.h:140
> >> #1  0x00007fffb6894125 in code_gen_buffer ()
> >> #2  0x0000555555fc4c46 in cpu_tb_exec (cpu=3Dcpu@entry=3D0x555557ededf=
0, itb=3Ditb@entry=3D0x7fffb6894000 <code_gen_buffer+200511443>, tb_exit=3D=
tb_exit@entry=3D0x7ffff4bfb744) at ../../accel/tcg/cpu-exec.c:455
> >> #3  0x0000555555fc51c2 in cpu_loop_exec_tb (tb_exit=3D0x7ffff4bfb744, =
last_tb=3D<synthetic pointer>, pc=3D<optimized out>, tb=3D0x7fffb6894000 <c=
ode_gen_buffer+200511443>, cpu=3D0x555557ededf0) at ../../accel/tcg/cpu-exe=
c.c:904
> >> #4  cpu_exec_loop (cpu=3Dcpu@entry=3D0x555557ededf0, sc=3Dsc@entry=3D0=
x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1018
> >> #5  0x0000555555fc58f1 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x555557e=
dedf0, sc=3Dsc@entry=3D0x7ffff4bfb7f0) at ../../accel/tcg/cpu-exec.c:1035
> >> #6  0x0000555555fc5f6c in cpu_exec (cpu=3Dcpu@entry=3D0x555557ededf0) =
at ../../accel/tcg/cpu-exec.c:1061
> >> #7  0x0000555556146ac3 in tcg_cpu_exec (cpu=3Dcpu@entry=3D0x555557eded=
f0) at ../../accel/tcg/tcg-accel-ops.c:81
> >> #8  0x0000555556146ee3 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x555=
557ededf0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:94
> >> #9  0x00005555561f6450 in qemu_thread_start (args=3D0x555557f8f430) at=
 ../../util/qemu-thread-posix.c:541
> >> #10 0x00007ffff7750aa4 in start_thread (arg=3D<optimized out>) at ./np=
tl/pthread_create.c:447
> >> #11 0x00007ffff77ddc3c in clone3 () at ../sysdeps/unix/sysv/linux/x86_=
64/clone3.S:78
> >>
> >> I haven't pushed out the rebased tree yet making this a truly awful bu=
g report.
> >>
> >> The pull request you sent with this in wasn't bisectable so this was a=
 bit of a guessing
> >> game. I see the seg fault only after this patch. =20
> >=20
> > I see the same thing with some RISC-V tests. I can provide the test
> > images if you want as well =20
>=20
>=20
> Yes please.
>=20
>=20
> r~

I'm guessing Alastair is busy.

I got around to testing this on x86 and indeed blow up is the same.

0x0000555555e3dd77 in cpu_atomic_add_fetchl_le_mmu (env=3D0x55555736bef0, a=
ddr=3D140271756837240, val=3D1, oi=3D34, retaddr=3D<optimized out>) at ../.=
./accel/tcg/atomic_template.h:143
143     GEN_ATOMIC_HELPER(add_fetch)
(gdb) bt
#0  0x0000555555e3dd77 in cpu_atomic_add_fetchl_le_mmu (env=3D0x55555736bef=
0, addr=3D140271756837240, val=3D1, oi=3D34, retaddr=3D<optimized out>) at =
../../accel/tcg/atomic_template.h:143
#1  0x00007fffbc31c6f0 in code_gen_buffer ()
#2  0x0000555555e23aa6 in cpu_tb_exec (cpu=3Dcpu@entry=3D0x555557369330, it=
b=3Ditb@entry=3D0x7fffbc31c600 <code_gen_buffer+295441875>, tb_exit=3Dtb_ex=
it@entry=3D0x7ffff4bfd6ec) at ../../accel/tcg/cpu-exec.c:438
#3  0x0000555555e24025 in cpu_loop_exec_tb (tb_exit=3D0x7ffff4bfd6ec, last_=
tb=3D<synthetic pointer>, pc=3D<optimized out>, tb=3D0x7fffbc31c600 <code_g=
en_buffer+295441875>, cpu=3D0x555557369330) at ../../accel/tcg/cpu-exec.c:8=
72
#4  cpu_exec_loop (cpu=3Dcpu@entry=3D0x555557369330, sc=3Dsc@entry=3D0x7fff=
f4bfd7b0) at ../../accel/tcg/cpu-exec.c:982
#5  0x0000555555e247a1 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x555557369330=
, sc=3Dsc@entry=3D0x7ffff4bfd7b0) at ../../accel/tcg/cpu-exec.c:999
#6  0x0000555555e24e2c in cpu_exec (cpu=3Dcpu@entry=3D0x555557369330) at ..=
/../accel/tcg/cpu-exec.c:1025
#7  0x0000555555e42c73 in tcg_cpu_exec (cpu=3Dcpu@entry=3D0x555557369330) a=
t ../../accel/tcg/tcg-accel-ops.c:81
#8  0x0000555555e43093 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x55555736=
9330) at ../../accel/tcg/tcg-accel-ops-mttcg.c:94
#9  0x0000555555ef2250 in qemu_thread_start (args=3D0x5555573e6e20) at ../.=
./util/qemu-thread-posix.c:541
#10 0x00007ffff7750aa4 in start_thread (arg=3D<optimized out>) at ./nptl/pt=
hread_create.c:447
#11 0x00007ffff77ddc3c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/cl=
one3.S:78

Need one patch for my particular setup to work around some DMA buffer issue=
s in virtio (similar to
a patch for pci space last year).  I've been meaning to post an RFC to get =
feedback on how
to handle this but not gotten to it yet!

=46rom 801e47897c5959a22ed050d7e7feebbbd3a12588 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 22 Apr 2024 13:54:37 +0100
Subject: [PATCH] physmem: Increase bounce buffers for "memory" address spac=
e.

Doesn't need to be this big and should be configurable.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 system/physmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/physmem.c b/system/physmem.c
index 3f4fd69d9a..651b875827 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2798,6 +2798,7 @@ static void memory_map_init(void)
     memory_region_init(system_memory, NULL, "system", UINT64_MAX);
     address_space_init(&address_space_memory, system_memory, "memory");
=20
+    address_space_memory.max_bounce_buffer_size =3D 1024 * 1024 * 1024;
     system_io =3D g_malloc(sizeof(*system_io));
     memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io",
                           65536);
--=20
2.43.0


Anyhow, other than that you need any random distro image (I tend to use deb=
ian nocloud images)
and a recent kernel build (mainline is fine).

Then a config along the lines of (obviously this isn't minimal)

qemu-system-x86_64 -M q35,cxl=3Don,sata=3Doff,smbus=3Doff -m 4g,maxmem=3D8G=
,slots=3D4 -cpu max -smp 4 \
                                      -kernel bzImage \
                                      -bios bios \
 -drive if=3Dnone,file=3D/mnt/d/images/x86-full-big.qcow2,format=3Dqcow2,id=
=3Dhd \
 -device ioh3420,id=3Droot_port1 -device virtio-blk-pci,drive=3Dhd,bus=3Dro=
ot_port1 \
 -netdev user,id=3Dmynet,hostfwd=3Dtcp::5553-:22 -device virtio-net-pci,net=
dev=3Dmynet,id=3Dbob \
 -nographic -no-reboot -append 'earlycon console=3DttyS0 root=3D/dev/vda3 f=
sck.mode=3Dskip tp_printk maxcpus=3D4' \
 -monitor telnet:127.0.0.1:1235,server,nowait \
 -object memory-backend-ram,size=3D4G,id=3Dmem0 \
 -numa node,nodeid=3D0,cpus=3D0-3,memdev=3Dmem0 \
 -numa node,nodeid=3D1 \
 -serial mon:stdio \
  -object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/tmp/cxlt=
est.raw,size=3D256M,align=3D256M \
 -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/cxlte=
st2.raw,size=3D256M,align=3D256M \
 -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/lsa.r=
aw,size=3D1M,align=3D1M \
 -object memory-backend-file,id=3Dcxl-mem3,share=3Don,mem-path=3D/tmp/cxlte=
st3.raw,size=3D256M,align=3D256M \
 -object memory-backend-file,id=3Dcxl-mem4,share=3Don,mem-path=3D/tmp/cxlte=
st4.raw,size=3D256M,align=3D256M \
 -object memory-backend-file,id=3Dcxl-lsa2,share=3Don,mem-path=3D/tmp/lsa2.=
raw,size=3D1M,align=3D1M \
 -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
 -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port0,chassis=3D0,slot=3D2 \
 -device cxl-rp,port=3D1,bus=3Dcxl.1,id=3Droot_port2,chassis=3D0,slot=3D3 \
 -device cxl-type3,bus=3Droot_port0,volatile-memdev=3Dcxl-mem1,id=3Dcxl-pme=
m0,lsa=3Dcxl-lsa1,sn=3D3 \
 -device cxl-type3,bus=3Droot_port2,volatile-memdev=3Dcxl-mem3,id=3Dcxl-pme=
m1,lsa=3Dcxl-lsa2,sn=3D4 \
 -machine cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interle=
ave-granularity=3D1k

Then after booting into linux, bring up a cxl region with:

    cd /sys/bus/cxl/devices/decoder0.0/
    cat create_ram_region
    echo region0 > create_ram_region

    echo ram > /sys/bus/cxl/devices/decoder2.0/mode
    echo $((256 << 20)) > /sys/bus/cxl/devices/decoder2.0/dpa_size

    cd /sys/bus/cxl/devices/region0/
    echo 256 > interleave_granularity
    echo 1 > interleave_ways
    echo $((256 << 20)) > size=20
    echo decoder2.0 > target0
    echo 1 > commit
    echo region0 > /sys/bus/cxl/drivers/cxl_region/bind

That should bring up a small amount of memory in node 2. Interleaving isn't=
 actually
in use here but we haven't upstreamed the bypass optimizations so this is s=
till
mmio space to QEMU.

Then numactl -m 2 ls=20
boom.

A few relevant bits of kernel config (also not minimal)

//dax stuff to ensure we get memory as normal ram.
CONFIG_DAX=3Dy
CONFIG_DEV_DAX=3Dm
CONFIG_DEV_DAX_PMEM=3Dm
CONFIG_DEV_DAX_HMEM=3Dy
CONFIG_DEV_DAX_CXL=3Dm
CONFIG_DEV_DAX_HMEM_DEVICES=3Dy
CONFIG_DEV_DAX_KMEM=3Dm
//memory hotplug
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
CONFIG_MEMORY_HOTPLUG=3Dy
CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_MOVABLE=3Dy

Any hints welcome!  Also happy to provide any additional info as necessary.

Jonathan


