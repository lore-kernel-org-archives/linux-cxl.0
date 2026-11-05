Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915662;
	b=3AgNwov5XaIYPgAc6A9zfl/n/1FmXK1T3tM2Bsy8mjb1DVDEOmjcMA4xlK6kZUPGXwC2
	 ov3iguKg71oSFyrNVAR4y3WWe2PIrds9m7yLEFcHFJ2FH4a9pMI3QFpBet8nJI43BVNzt
	 Nh54pf3/YhaBFWGe6GijjzKwm4FiHjSy9lVetFYmlY4XpONGArVsOl0esxuUGrh6y6KAA
	 Pa9p3YxqVkbWgWc/hC19ZE/tg4CTXQm/9U0ziYwrjkpD0cUdYSH2sIcUYGmpbkNmZ+yeb
	 5BA0AxRjme64fRnVmsKrj44YoX0CtehjGtiL6ePFtBJjJ6zF1qBMwfvClFLC3pSGHBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915662;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=f0BXtlO5isR7BWmVVog+NbaRGTqva+7c+4SZBVTPkl8=;
	b=f+JXLmEnlrnvVbO20hi1RiKqUZU1knMGS98c1lqg8ZzhsZrh+Z+vs5ncQx8Jx9hYyZVj
	 UpM8w+cAlbvKqvOqVfjUTx7hQg3Y+MpJt2L9705mj47tNkWgWH5V1EPOZj/uWZBs/nSLP
	 He/K6J24HdC0E5lT0x1dMLI5YM72Ytzqrf+8UxX2goNAqrnu2GOgSyBL1VGoFJ7hISADX
	 nfqZJCWlGibMWeCp2wsZPpgH7nociizy8+aHxbbT3o3JAHApYRr3xEamsKzXO6sAEAs8A
	 2pmEf4EeJYMsSZO+wq/l7USIlE0ylZdGFA9iAAD57sL5aVkCZxrY98T84cr1AZqVcjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ok+z+nHh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE2606A31B
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ok+z+nHh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866191F0089F;
	Thu,  5 Nov 2026 21:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915661;
	bh=f0BXtlO5isR7BWmVVog+NbaRGTqva+7c+4SZBVTPkl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ok+z+nHhRF5vWIv9pcrdntNwrEBoYsNUIa2XugRuNNbRkLX+QrgaK8nMzUZs8i3Bf
	 Hqcq/1rof+ToQNuzmPNBeCzYU8+N2Ixts0RxE3V0AYVodg0gVwgYAzMDOF5kKRJIOh
	 VeiXlBU1ZzFMXz6VXmSxR/CEV8RZlZNft/HjaDUKdj/wncbwSoY/ZvXFkMeFnROH3x
	 YpfNaPQEDtLl1tuFkKK8SGrpOskkwGPMORiuJUALFOAtdNzQiT9kOxK0EYWbhcmn0t
	 YmHxPJOKCrYqxZopcul/7qOvtwS5Xs/qg5l7cRdKWtzSKRg8o8GWWcvsnbullXpjOb
	 v7rOrn1qKauRg==
Date: Thu, 5 Nov 2026 21:54:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yukiya Takaki <fj2110jc@fujitsu.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Anisa Su <anisa.su@samsung.com>, Igor Mammedov
 <imammedo@redhat.com>, Junjie Cao <junjie.cao@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, linux-cxl@vger.kernel.org,
 qemu-arm@nongnu.org, "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
 lizhijian@fujitsu.com, y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: Re: [PATCH RFC 0/7] QEMU/hw/cxl: Allow CXL Type 3 memory regions to
 be initialized at guest boot
Message-ID: <20261105215411.33262db7@jic23-hlaptop>
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Oct 2026 19:03:21 +0900
Yukiya Takaki <fj2110jc@fujitsu.com> wrote:

> Hello everyone,
>=20
> I=E2=80=99m a student intern, and this is my first time sending patches t=
o an open source mailing list.
>=20
> This patch series configures QEMU=E2=80=99s CXL Type 3 devices so that gu=
est operating systems can automatically discover
> and create CXL regions during boot, aligning QEMU=E2=80=99s behavior with=
 real hardware.

Hi Yukiya,

Interesting project.

>=20
> Background and motivation
>   Currently, during guest boot QEMU does not provide the information or r=
egister programming needed for the guest OS
>   to initialize CXL Type 3 memory, so using it still requires an explicit=
 action in the guest (for example, running the cxl create-region command).
>   By contrast, on some physical systems the firmware automatically alloca=
tes CXL memory ranges and exposes them to the OS,
>    allowing the Linux CXL driver to discover and create regions during bo=
ot.
>   This patch series is a first, experimental attempt to reproduce that be=
havior in QEMU.
>=20
>   Some parts of this implementation are based on Li, Zhijian=E2=80=99s wo=
rk in:
>   https://github.com/zhijianli88/qemu/tree/program-decoder-v2
>=20
>   I would like to ask for feedback on whether this approach makes sense a=
nd whether I should continue to enhance it.
>=20
> Approach
>   This patch first adds a program_hdm_decoder option to cxl-type3.
>   When program-hdm-decoder is enabled on cxl-type3, QEMU will:
>     1) program endpoint/host-bridge HDM decoder state,
>     2) expose Type 3 ranges as E820_SOFT_RESERVED on x86,
>     3) create memory-only NUMA nodes for those ranges,
>     4) emit SRAT memory-affinity entries mapping each Type 3 HPA range to=
 its node ID
>=20
>   On real hardware, HDM decoder programming and memory layout are typical=
ly handled by firmware, so they would ideally be managed by SeaBIOS.
>   However, in the current QEMU/SeaBIOS model, E820 and SRAT are built on =
the QEMU side, and pushing HDM decoder programming
>   into SeaBIOS would introduce additional complexity and risk inconsisten=
cies.

So, did you explore doing this in a similar fashion to PCI enumeration?

That's done the bios and is very similar in that there is a mix of
policy and rules in how it is configured that we really don't want
in qemu.  With that ACPI tables are then built in QEMU that contain
values read back from what was setup. The main thing I'm thinking of
here is the PXB handling that relies on the bios having done the
PCI enumeration first rather than doing it in qemu.
The arm code is here
https://elixir.bootlin.com/qemu/v11.1.3/source/hw/pci-host/gpex-acpi.c#L103
x86 probably this:
https://elixir.bootlin.com/qemu/v11.1.3/source/hw/i386/acpi-build.c#L1038

My immediate instinct is that would look more like a conventional bios
flow.  It would also have the significant benefit of putting the enumerating
and configuration code into an open source bios, something I hoped would co=
me out
early ARM work on this (see linux plumbers - I think this is right session)
https://lpc.events/event/16/contributions/1254/attachments/1113/2136/CXL%20=
Type-3%20device%20discovery,%20configuration%20in%20firmware%20and%20prepar=
e%20ACPI%20tables%20for%20kernel%20usage.pdf

Then we'd regenerate the SRAT, HMAT etc before handling to the OS.
(I'm not sure this works for e820 having never touched that flow).

There is a lot of policy involved in CXL configuration and I'd not
want to replicate that part in QEMU. At best we'd want to pass
some hints to the bios.

Flow wise that would mean adding to acpi_build_update() some code
to do the necessary srat and other table updates.  That would
definitely work for the actual ACPI tables, but I gather e820 is
rather different...  However, e820 real table is I think
actually constructed by seabios so can that just make the
necessary updates after programming the CXL decoders etc?

Now if you did this on SBSA-ref and arm you'd have to do it
all in the bios (as that generates everything) and the whole
problem would be much more standard.

Given we have that option on arm/sbsa-ref I don't currently
see a reason to explore the bios flows on arm/virt.

I also gather (from asking an LLM so might be wrong) that there
are options that boot qemu on x86 with tables generated
by the bios, not qemu.  Legacy path in seabios, coreboot and
and ovmf path used with xen.  Maybe working with them avoids
the extra complexity of bounce backwards and forwards between
qemu and the firmware (though I think I'd probably avoid these).

Anyhow, interested to see where you go with this.
Definitely useful for those of us working with platforms that
never do the bios programmed flow but have to test it when
making changes!

Jonathan

>=20
> Testing
>   We ran tests in the following environment and confirmed that CXL region=
s were created at boot, NUMA nodes were set up,
>   and E820_SOFT_RESERVED entries appeared in the E820 table:
>=20
>   - BIOS: SeaBIOS c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf
>   - CXL memory: 4 GB
>   - CFMWS: 4 GB
>   - Host bridge: 1
>=20
>   The following is the startup script.
>=20
>   sudo /path/to/qemu/build/qemu-system-x86_64 \
>     -name guest=3Dcxl \
>     -nographic \
>     -machine q35,accel=3Dtcg,nvdimm=3Don,cxl=3Don \
>     -cpu max -smp 4,sockets=3D4,cores=3D1,threads=3D1 \
>     -m size=3D4G,slots=3D10,maxmem=3D20G \
>     -drive file=3D/path/to/image.qcow2,format=3Dqcow2,index=3D0,media=3Dd=
isk,id=3Dhd \
>     -bios /path/to/seabios/out/bios.bin \
>     -nic bridge,br=3Dvirbr0,model=3De1000e,mac=3D52:54:00:b5:4e:7c \
>     -object memory-backend-ram,size=3D2G,id=3Dm0 \
>     -object memory-backend-ram,size=3D2G,id=3Dm1 \
>     -numa node,nodeid=3D0,cpus=3D0-1,memdev=3Dm0 \
>     -numa node,nodeid=3D1,cpus=3D2-3,memdev=3Dm1 \
>     -device pcie-root-port,id=3Dpci-root,slot=3D4,bus=3Dpcie.0,chassis=3D=
0 \
>     -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1,hdm_for_passthrou=
gh=3Dtrue \
>     -device cxl-rp,port=3D0,id=3Droot_port13,bus=3Dcxl.1,chassis=3D0,slot=
=3D2 \
>     -object memory-backend-ram,size=3D4G,share=3Don,id=3Dvmem0 \
>     -device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,id=3Dcxl-=
vmem0,program-hdm-decoder=3Dtrue \
>     -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interlea=
ve-granularity=3D4k
>  =20
>   Furthermore, we conducted the experiment in which we added two CXL Type=
3.
>=20
>   - CXL memory: 4 GB =C3=97 2
>   - CFMWS: 4 GB =C3=97 2
>=20
>   The following is the startup script.
>    =20
>   sudo /path/to/qemu/build/qemu-system-x86_64 \
>     -name guest=3Dcxl \
>     -nographic \
>     -machine q35,accel=3Dtcg,nvdimm=3Don,cxl=3Don,hmat=3Don \
>     -cpu max -smp 4,sockets=3D4,cores=3D1,threads=3D1 \
>     -m size=3D4G,slots=3D10,maxmem=3D20G \
>     -drive file=3D/path/to/image.qcow2,format=3Dqcow2,index=3D0,media=3Dd=
isk,id=3Dhd \
>     -bios /path/to/seabios/out/bios.bin \
>     -nic bridge,br=3Dvirbr0,model=3De1000e,mac=3D52:54:00:b5:4e:7c \
>     -object memory-backend-ram,size=3D2G,id=3Dm0 \
>     -object memory-backend-ram,size=3D2G,id=3Dm1 \
>     -numa node,nodeid=3D0,cpus=3D0-1,memdev=3Dm0 \
>     -numa node,nodeid=3D1,cpus=3D2-3,memdev=3Dm1 \
>     -device pcie-root-port,id=3Dpci-root,slot=3D4,bus=3Dpcie.0,chassis=3D=
0 \
>     -device pcie-root-port,id=3Dpci-root-net,chassis=3D5,slot=3D5,bus=3Dp=
cie.0 \
>     -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1,hdm_for_passthrou=
gh=3Dtrue \
>     -device cxl-rp,port=3D0,id=3Droot_port13,bus=3Dcxl.1,chassis=3D0,slot=
=3D2 \
>     -device cxl-rp,port=3D3,id=3Droot_port14,bus=3Dcxl.1,chassis=3D2,slot=
=3D4 \
>     -object memory-backend-ram,size=3D4G,share=3Don,id=3Dvmem0 \
>     -object memory-backend-ram,size=3D4G,share=3Don,id=3Dvmem1 \
>     -device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,id=3Dcxl-=
vmem0,program-hdm-decoder=3Dtrue \
>     -device cxl-type3,bus=3Droot_port14,volatile-memdev=3Dvmem1,id=3Dcxl-=
vmem1,program-hdm-decoder=3Dtrue \
>     -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interlea=
ve-granularity=3D4k,cxl-fmw.1.targets.0=3Dcxl.1,cxl-fmw.1.size=3D4G,cxl-fmw=
.1.interleave-granularity=3D4k
>=20
>=20
> How to use
>   Specify the following parameters when starting QEMU:
>=20
>   - bios <SeaBIOS binary that includes commit c2a33ad9ad1452e23b41c4ac44a=
3bc6be8ebc4cf> to ensure that E820_SOFT_RESERVED entries are exposed
>   - Add hmat=3Don to the -machine option [1]
>   - Add program-hdm-decoder=3Dtrue to each -device cxl-type3 option
>     [1] On Linux, the kernel first checks E820_SOFT_RESERVED ranges. When=
 multiple CXL Type 3 devices share a contiguous HPA range,
>         these ranges tend to be merged into a single region, so the CXL d=
river cannot reliably initialize per=E2=80=91device regions based on E820 a=
lone.
>         SRAT entries for CXL memory are therefore needed, and the guest s=
eems to discard SRAT when `hmat=3Don` is not specified,
>         so HMAT must be enabled.
>=20
> QEMU base commit: bddb785e791e415db38884848d068457e226f5e3
>=20
> TODO
>   With the current implementation of this patch, the following configurat=
ions are either not supported or have not been sufficiently tested.
>   As a result, automatic creation of CXL regions in the guest OS may fail:
>=20
>   - A CXL persistent memory device is included
>   - Interleaved configurations
>   - Cases where the memory size specified by CFMWS does not match the siz=
e of the CXL Type 3 backend memory
>   - Configurations where CXL memory is attached via a switch
>   - Multi-target CFMWS environments
>   - ARM environments
>   - HMAT does not yet include information about CXL memory devices
>=20
>   The following behaviors are also provisional implementations and may ne=
ed further refinement:
>    - A new NUMA node ID is assigned to each CXL memory device. This shoul=
d be improved either to reflect more accurate NUMA distances for CXL memory,
>      or to allow the NUMA node IDs to be specified by the user.
>    - Assignment of CXL Type 3 devices to CFMWS address ranges. On physica=
l systems, platform firmware typically generates CFMWS entries
>      based on the detected CXL topology and its address-space allocation.=
 In QEMU, however, CFMWS entries are configured explicitly
>      through machine options. The current implementation therefore has to=
 infer which CFMWS range should be used for each Type 3 device.
>      This selection logic may need further refinement. Possible approache=
s include improving the selection and validation logic,
>      adding an explicit option to associate each Type 3 device with a CFM=
WS entry,
>      or generating CFMWS entries automatically from the configured CXL to=
pology and devices.
>    - HDM decoder reset sequencing and state reconstruction.
>      The current implementation prevents the host bridge HDM decoder conf=
iguration from being overwritten later in the same reset
>      by moving the common initialization of the host bridge component reg=
isters from the reset path to the realization path.
>      However, ideally, after the registers have been restored to their re=
set values, the host bridge HDM decoder configuration
>      automatically programmed by QEMU should be reconstructed as part of =
reset processing.
>=20
> Thanks,
>=20
> ------
>=20
> Yukiya Takaki (7):
>   QEMU/hw/cxl: add program-hdm-decoder option for CXL Type 3 devices
>   QEMU/hw/cxl:add HPA offset tracking for CXL Type 3 devices
>   QEMU: hw/cxl: add helper to get HPA range for CXL Type 3
>   QEMU/hw/cxl: auto=E2=80=91program HDM decoders for CXL Type 3
>   QEMU/hw/cxl: expose CXL Type 3 ranges as E820_SOFT_RESERVED on x86
>   QEMU/hw/cxl: Create NUMA nodes for CXL Type 3 memory
>   add CXL Type 3 memory ranges to SRAT
>=20
>  hw/acpi/cxl_type3.c                 |  30 +++++
>  hw/acpi/meson.build                 |   1 +
>  hw/arm/cxl.c                        |  10 ++
>  hw/arm/meson.build                  |   2 +
>  hw/cxl/cxl-host.c                   |  63 ++++++++++
>  hw/i386/acpi-build.c                |   7 ++
>  hw/i386/cxl.c                       |  11 ++
>  hw/i386/meson.build                 |   1 +
>  hw/i386/pc.c                        |   2 +
>  hw/mem/cxl_type3.c                  | 177 ++++++++++++++++++++++++++++
>  hw/pci-bridge/pci_expander_bridge.c |  13 +-
>  include/hw/cxl/cxl.h                |   2 +
>  include/hw/cxl/cxl_device.h         |   6 +
>  include/hw/cxl/cxl_host.h           |   3 +
>  include/hw/mem/cxl_type3.h          |   8 ++
>  15 files changed, 334 insertions(+), 2 deletions(-)
>  create mode 100644 hw/acpi/cxl_type3.c
>  create mode 100644 hw/arm/cxl.c
>  create mode 100644 hw/i386/cxl.c
>  create mode 100644 include/hw/mem/cxl_type3.h
>=20

