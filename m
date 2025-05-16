Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D790282EE
	for <linux-cxl@vger.kernel.org>; Fri, 16 May 2025 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362675; cv=none; b=rj/OZWiFFIWjNW6f0ZjXgdJd/p4JjD0d9I/uLTkxl0Rsotrv9/KgPkxY0eLjiHbpaZP9Yy0V9WLvNgZ0Eb5j4pt3LpFh4XNkkhDOs/cM++7RckJMqSaaBRy2JReoGehIqQMCGM/2b07taHQcAUXYsLiaQyxVKuMuPymfwMnV3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362675; c=relaxed/simple;
	bh=EiTabiftUPTtYwCjjEbYfL+ViLU2pqiVapaRnVKpjg8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SpqC3GHVszORA/Qcm2vrkXgBshXgCUALrHQ5d2gzwH1AzWT1prwYf4l8epAOkaVQMa0/+/0xb+ArZK3SybEX97HdJFnDg+A9UqKeXGgU9TL1OTOfux3YzbH/mzZlisv3FgUIX6wbi2I5/xecKCAXsanP82Nb0rBK5+r0DoFaZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X3WKR2uX; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X3WKR2uX"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747362669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llObsdvYuuWAtpYKes7BnUdKKbN3nveceK2uGee/4CA=;
	b=X3WKR2uXLU047RHFNSA24keiKcIlF/0JpQ0QMnLRq69lFNATZA9Pqggtn1Nj1oPdFtHDIB
	vTYysgCG0+HWTcTKnHI54Vwh0h9LsUOGVglyDOcg+kPeh9wStIeVf7c8e2A6ju2CcTGyhA
	JlepzyUF/fa/L7uoOk6fwO3Jwy+0izk=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v13 0/5] arm/virt: CXL support via pxb_cxl
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
Date: Fri, 16 May 2025 11:30:49 +0900
Cc: qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 mst@redhat.com,
 linux-cxl@vger.kernel.org,
 linuxarm@huawei.com,
 qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DF02466-C91E-461E-B35F-D42CEE9F040D@linux.dev>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT

Hi Jonathan,

> On May 13, 2025, at 20:14, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> V13:
> - Make CXL fixed memory windows sysbus devices.
>  IIRC this was requested by Peter in one of the reviews a long time =
back
>  but at the time the motivation was less strong than it becomes with =
some
>  WiP patches for hotness monitoring and high performance direct =
connect
>  where we need a machine type independent way to iterate all the CXL
>  fixed memory windows. This is a convenient place to do it so drag =
that
>  work forward into this series.
>=20
>  This allows us to drop separate list and necessary machine specific
>  access code in favour of
>  object_child_foreach_recursive(object_get_root(),...)
>  One snag is that the ordering of multiple fixed memory windows in =
that
>  walk depends on the underlying g_hash_table iterations rather than =
the
>  order of creation. In the memory map layout and ACPI table creation =
we
>  need both stable and predictable ordering. Resolve this in a similar
>  fashion to object_class_get_list_sorted() be throwing them in a =
GSList
>  and sorting that. Only use this when a sorted list is needed.
>=20
>  Dropped RFC as now I'm happy with this code and would like to get it
>  upstream!  Particularly as it broken even today due to enscripten
>  related changes that stop us using g_slist_sort(). Easy fix though.
>=20
> Note that we have an issue for CXL emulation in general and TCG which
> is being discussed in:
> https://lore.kernel.org/all/20250425183524.00000b28@huawei.com/
> (also affects some other platforms)
>=20
> Until that is resolved, either rebase this back on 10.0 or just
> don't let code run out of it (don't use KMEM to expose it as normal
> memory, use DAX instead).
>=20
> Previous cover letter.
>=20
> Back in 2022, this series stalled on the absence of a solution to =
device
> tree support for PCI Expander Bridges (PXB) and we ended up only =
having
> x86 support upstream. I've been carrying the arm64 support out of tree
> since then, with occasional nasty surprises (e.g. UNIMP + DT issue =
seen
> a few weeks ago) and a fair number of fiddly rebases.
> gitlab.com/jic23/qemu cxl-<latest date>
>=20
> A recent discussion with Peter Maydell indicated that there are =
various
> other ACPI only features now, so in general he might be more relaxed
> about DT support being necessary. The upcoming vSMMUv3 support would
> run into this problem as well.
>=20
> I presented the background to the PXB issue at Linaro connect 2022. In
> short the issue is that PXBs steal MMIO space from the main PCI root
> bridge. The challenge is knowing how much to steal.
>=20
> On ACPI platforms, we can rely on EDK2 to perform an enumeration and
> configuration of the PCI topology and QEMU can update the ACPI tables
> after EDK2 has done this when it can simply read the space used by the
> root ports. On device tree, there is no entity to figure out that
> enumeration so we don't know how to size the stolen region.
>=20
> Three approaches were discussed:
> 1) Enumerating in QEMU. Horribly complex and the last thing we want is =
a
>   3rd enumeration implementation that ends up out of sync with EDK2 =
and
>   the kernel (there are frequent issues because of how those existing
>   implementations differ.
> 2) Figure out how to enumerate in kernel. I never put a huge amount of =
work
>   into this, but it seemed likely to involve a nasty dance with =
similar
>   very specific code to that EDK2 is carrying and would very =
challenging
>   to upstream (given the lack of clarity on real use cases for PXBs =
and
>   DT).
> 3) Hack it based on the control we have which is bus numbers.
>   No one liked this but it worked :)
>=20
> The other little wrinkle would be the need to define full bindings for =
CXL
> on DT + implement a fairly complex kernel stack as equivalent in ACPI
> involves a static table, CEDT, new runtime queries via _DSM and a =
description
> of various components. Doable, but so far there is no interest on =
physical
> platforms. Worth noting that for now, the QEMU CXL emulation is all =
about
> testing and developing the OS stack, not about virtualization =
(performance
> is terrible except in some very contrived situations!)
>=20
> Back to posting as an RFC because there was some discussion of =
approach to
> modelling the devices that may need a bit of redesign.
> The discussion kind of died out on the back of DT issue and I doubt =
anyone
> can remember the details.
>=20
> =
https://lore.kernel.org/qemu-devel/20220616141950.23374-1-Jonathan.Cameron=
@huawei.com/
>=20
> There is only a very simple test in here, because my intent is not to
> duplicate what we have on x86, but just to do a smoke test that =
everything
> is hooked up.  In general we need much more comprehensive end to end =
CXL
> tests but that requires a reaonsably stable guest software stack. A =
few
> people have expressed interest in working on that, but we aren't there =
yet.
>=20
> Note that this series has a very different use case to that in the =
proposed
> SBSA-ref support:
> =
https://lore.kernel.org/qemu-devel/20250117034343.26356-1-wangyuquan1236@p=
hytium.com.cn/
>=20
> SBSA-ref is a good choice if you want a relatively simple mostly fixed
> configuration.  That works well with the limited host system
> discoverability etc as EDK2 can be build against a known =
configuration.
>=20
> My interest with this support in arm/virt is support host software =
stack
> development (we have a wide range of contributors, most of whom are =
working
> on emulation + the kernel support). I care about the weird corners. As =
such
> I need to be able to bring up variable numbers of host bridges, =
multiple CXL
> Fixed Memory Windows with varying characteristics (interleave etc), =
complex
> NUMA topologies with wierd performance characteristics etc. We can do =
that
> on x86 upstream today, or my gitlab tree. Note that we need arm =
support
> for some arch specific features in the near future (cache flushing).
> Doing kernel development with this need for flexibility on SBSA-ref is =
not
> currently practical. SBSA-ref CXL support is an excellent thing, just
> not much use to me for this work.
>=20
> Jonathan Cameron (5):
>  hw/cxl-host: Add an index field to CXLFixedMemoryWindow
>  hw/cxl: Make the CXL fixed memory windows devices.
>  hw/cxl-host: Allow split of establishing memory address and mmio
>    setup.
>  hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
>    pxb-cxl
>  qtest/cxl: Add aarch64 virt test for CXL
>=20
> include/hw/arm/virt.h     |   4 +
> include/hw/cxl/cxl.h      |   4 +
> include/hw/cxl/cxl_host.h |   6 +-
> hw/acpi/cxl.c             |  83 +++++++++------
> hw/arm/virt-acpi-build.c  |  34 ++++++
> hw/arm/virt.c             |  29 +++++
> hw/cxl/cxl-host-stubs.c   |   8 +-
> hw/cxl/cxl-host.c         | 218 ++++++++++++++++++++++++++++++++------
> hw/i386/pc.c              |  51 ++++-----
> tests/qtest/cxl-test.c    |  59 ++++++++---
> tests/qtest/meson.build   |   1 +
> 11 files changed, 389 insertions(+), 108 deletions(-)
>=20
> --=20
> 2.43.0
>=20

With your series applied on top of upstream QEMU, the -drive option does =
not work well with the sane CXL
setup (I use run_qemu.sh maintained by Marc et al. at Intel) see below:

/home/realm/projects/qemu/build/qemu-system-aarch64 -machine =
virt,accel=3Dtcg,cxl=3Don,highmem=3Don,compact-highmem=3Don,highmem-ecam=3D=
on,highmem-mmio=3Don -m 2048M,slots=3D0,maxmem=3D6144M -smp =
2,sockets=3D1,cores=3D2,threads=3D1 -display none -nographic -drive =
if=3Dpflash,format=3Draw,unit=3D0,file=3DAAVMF_CODE.fd,readonly=3Don =
-drive if=3Dpflash,format=3Draw,unit=3D1,file=3DAAVMF_VARS.fd -drive =
file=3Droot.img,format=3Draw,media=3Ddisk -kernel =
mkosi.extra/boot/vmlinuz-6.15.0-rc4-00040-g128ad8fa385b -initrd =
mkosi.extra/boot/initramfs-6.15.0-rc4-00040-g128ad8fa385b.img -append =
selinux=3D0 audit=3D0 console=3Dtty0 console=3DttyS0 =
root=3DPARTUUID=3D14d6bae9-c917-435d-89ea-99af1fa4439a ignore_loglevel =
rw initcall_debug log_buf_len=3D20M =
memory_hotplug.memmap_on_memory=3Dforce cxl_acpi.dyndbg=3D+fplm =
cxl_pci.dyndbg=3D+fplm cxl_core.dyndbg=3D+fplm cxl_mem.dyndbg=3D+fplm =
cxl_pmem.dyndbg=3D+fplm cxl_port.dyndbg=3D+fplm cxl_region.dyndbg=3D+fplm =
cxl_test.dyndbg=3D+fplm cxl_mock.dyndbg=3D+fplm =
cxl_mock_mem.dyndbg=3D+fplm systemd.set_credential=3Dagetty.autologin:root=
 systemd.set_credential=3Dlogin.noauth:yes -device =
e1000,netdev=3Dnet0,mac=3D52:54:00:12:34:56 -netdev =
user,id=3Dnet0,hostfwd=3Dtcp::10022-:22 -cpu max -object =
memory-backend-file,id=3Dcxl-mem0,share=3Don,mem-path=3Dcxltest0.raw,size=3D=
256M -object =
memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3Dcxltest1.raw,size=3D=
256M -object =
memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3Dcxltest2.raw,size=3D=
256M -object =
memory-backend-file,id=3Dcxl-mem3,share=3Don,mem-path=3Dcxltest3.raw,size=3D=
256M -object =
memory-backend-file,id=3Dcxl-lsa0,share=3Don,mem-path=3Dlsa0.raw,size=3D12=
8K -object =
memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3Dlsa1.raw,size=3D12=
8K -object =
memory-backend-file,id=3Dcxl-lsa2,share=3Don,mem-path=3Dlsa2.raw,size=3D12=
8K -object =
memory-backend-file,id=3Dcxl-lsa3,share=3Don,mem-path=3Dlsa3.raw,size=3D12=
8K -device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D53 -device =
pxb-cxl,id=3Dcxl.1,bus=3Dpcie.0,bus_nr=3D191 -device =
cxl-rp,id=3Dhb0rp0,bus=3Dcxl.0,chassis=3D0,slot=3D0,port=3D0 -device =
cxl-rp,id=3Dhb0rp1,bus=3Dcxl.0,chassis=3D0,slot=3D1,port=3D1 -device =
cxl-rp,id=3Dhb1rp0,bus=3Dcxl.1,chassis=3D0,slot=3D2,port=3D0 -device =
cxl-rp,id=3Dhb1rp1,bus=3Dcxl.1,chassis=3D0,slot=3D3,port=3D1 -device =
cxl-upstream,port=3D4,bus=3Dhb0rp0,id=3Dcxl-up0,multifunction=3Don,addr=3D=
0.0,sn=3D12345678 -device =
cxl-switch-mailbox-cci,bus=3Dhb0rp0,addr=3D0.1,target=3Dcxl-up0 -device =
cxl-upstream,port=3D4,bus=3Dhb1rp0,id=3Dcxl-up1,multifunction=3Don,addr=3D=
0.0,sn=3D12341234 -device =
cxl-switch-mailbox-cci,bus=3Dhb1rp0,addr=3D0.1,target=3Dcxl-up1 -device =
cxl-downstream,port=3D0,bus=3Dcxl-up0,id=3Dswport0,chassis=3D0,slot=3D4 =
-device cxl-downstream,port=3D1,bus=3Dcxl-up0,id=3Dswport1,chassis=3D0,slo=
t=3D5 -device =
cxl-downstream,port=3D2,bus=3Dcxl-up0,id=3Dswport2,chassis=3D0,slot=3D6 =
-device cxl-downstream,port=3D3,bus=3Dcxl-up0,id=3Dswport3,chassis=3D0,slo=
t=3D7 -device =
cxl-downstream,port=3D0,bus=3Dcxl-up1,id=3Dswport4,chassis=3D0,slot=3D8 =
-device cxl-downstream,port=3D1,bus=3Dcxl-up1,id=3Dswport5,chassis=3D0,slo=
t=3D9 -device =
cxl-downstream,port=3D2,bus=3Dcxl-up1,id=3Dswport6,chassis=3D0,slot=3D10 =
-device cxl-downstream,port=3D3,bus=3Dcxl-up1,id=3Dswport7,chassis=3D0,slo=
t=3D11 -device =
cxl-type3,bus=3Dswport0,persistent-memdev=3Dcxl-mem0,id=3Dcxl-pmem0,lsa=3D=
cxl-lsa0 -device =
cxl-type3,bus=3Dswport2,persistent-memdev=3Dcxl-mem1,id=3Dcxl-pmem1,lsa=3D=
cxl-lsa1 -device =
cxl-type3,bus=3Dswport4,volatile-memdev=3Dcxl-mem2,id=3Dcxl-vmem2,lsa=3Dcx=
l-lsa2 -device =
cxl-type3,bus=3Dswport6,volatile-memdev=3Dcxl-mem3,id=3Dcxl-vmem3,lsa=3Dcx=
l-lsa3 -M =
cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleave-granu=
larity=3D8k,cxl-fmw.1.targets.0=3Dcxl.0,cxl-fmw.1.targets.1=3Dcxl.1,cxl-fm=
w.1.size=3D4G,cxl-fmw.1.interleave-granularity=3D8k -snapshot -object =
memory-backend-ram,id=3Dmem0,size=3D2048M -numa =
node,nodeid=3D0,memdev=3Dmem0, -numa cpu,node-id=3D0,socket-id=3D0 -numa =
dist,src=3D0,dst=3D0,val=3D10
qemu-system-aarch64: -drive file=3Droot.img,format=3Draw,media=3Ddisk: =
PCI: Only PCI/PCIe bridges can be plugged into pxb-cxl

Plain upstream QEMU aarch64 target vert machine can handle the -drive =
option without an issue _without_ those cxl setup options added. I think =
the error was seen with your previous cxl-2025-03-20 branch.=20

Thanks,
Itaru.=20=
