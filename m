Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E115199A
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828069; cv=none; b=J4PPwIAs2+Y9DMWSjWT3/TP47pl3UA92dXFIYC7lBc2s0iMMCyh6jU+kGfcYyBzvxVu/XkrrufFFpTLF5SN6/S5hyderK4VsJ+VzQbB2SE7cUFbZCAykwsH52oANLBQVo++kSBig/u90N9fEv7bHP4GWVwMWWJR6p3JL7nEWiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828069; c=relaxed/simple;
	bh=noyEUoDAVt8nQaBRqmmNFbBr1BZI2wEs/JZdQ4vXveM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRH9kwtrBcldC+7DMn0zjJE9M4pyMf9vUtK70CIQlnlvB8akt0AFonTB8ZnUOcd+nvl1DM8HLllr9NhEfDqP+zikovE4m5CFN/y23el7lvxs+/Ikzczw3CMOgiDo9s0RcD0p3n2qi57KsyJmrDQk+lSP+oZhZ+hfKKRFw8FJ3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJjfR2Fhbz6L5DD;
	Fri, 13 Jun 2025 23:16:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A821140393;
	Fri, 13 Jun 2025 23:20:56 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 17:20:55 +0200
Date: Fri, 13 Jun 2025 16:20:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v15 3/4] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
Message-ID: <20250613162054.000003cf@huawei.com>
In-Reply-To: <CAFEAcA-J+vAGfEV67PezA72rUiqpuqTBT=8hJLc1sw+xo3XHWQ@mail.gmail.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
	<20250612134338.1871023-4-Jonathan.Cameron@huawei.com>
	<CAFEAcA-J+vAGfEV67PezA72rUiqpuqTBT=8hJLc1sw+xo3XHWQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Jun 2025 13:57:39 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Code based on i386/pc enablement. The memory layout places space for 16
> > host bridge register regions after the GIC_REDIST2 in the extended memm=
ap.
> > The CFMWs are placed above the extended memmap.
> >
> > Only create the CEDT table if cxl=3Don set for the machine.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > ---
> > v15: No changes.
> > ---
> >  include/hw/arm/virt.h    |  4 ++++
> >  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
> >  hw/arm/virt.c            | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 67 insertions(+) =20
>=20
Hi Peter,

Thanks for reviewing.

> Can we have some user-facing documentation, please?
> (docs/system/arm/virt.rst -- can just be a brief mention
> and link to docs/system/devices/cxl.rst if you want to put the
> examples of aarch64 use in there.)

Given the examples should look exactly like those for x86/pc, do we need
extra examples in cxl.rst? I guess I can add one simple arm/virt example
in a follow up patch without bloating that file too badly..

Is the following sufficient for the board specific docs?

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 6a719b9586..10cbffc8a7 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -31,6 +31,7 @@ Supported devices
 The virt board supports:

 - PCI/PCIe devices
+- CXL Fixed memory windows, root bridges and devices.
 - Flash memory
 - Either one or two PL011 UARTs for the NonSecure World
 - An RTC
@@ -189,6 +190,14 @@ ras
 acpi
   Set ``on``/``off``/``auto`` to enable/disable ACPI.

+cxl
+  Set  ``on``/``off`` to enable/disable CXL. More details in
+  :doc:`../devices/cxl`. The default is off.
+
+cxl-fmw
+  Array of CXL fixed memory windows describing fixed address routing to
+  target CXL host bridges. See :doc:`../devices/cxl`.
+
 dtb-randomness
   Set ``on``/``off`` to pass random seeds via the guest DTB
   rng-seed and kaslr-seed nodes (in both "/chosen" and

>=20
> > @@ -220,6 +223,7 @@ static const MemMapEntry base_memmap[] =3D {
> >  static MemMapEntry extended_memmap[] =3D {
> >      /* Additional 64 MB redist region (can contain up to 512 redistrib=
utors) */
> >      [VIRT_HIGH_GIC_REDIST2] =3D   { 0x0, 64 * MiB },
> > +    [VIRT_CXL_HOST] =3D           { 0x0, 64 * KiB * 16 }, /* 16 UID */=
 =20
>=20
> This is going to shuffle the memory map around, even if CXL
> isn't enabled, which will break migration compatibility.
> You need to do something to ensure that the CXL region isn't
> included in the calculations of the base addresses for these
> regions if CXL isn't enabled.
>=20

It doesn't move any existing stuff because these are naturally aligned
regions so this is in a gap before the PCIE ECAM region.

> >      [VIRT_HIGH_PCIE_ECAM] =3D     { 0x0, 256 * MiB },
> >      /* Second PCIe window */
> >      [VIRT_HIGH_PCIE_MMIO] =3D     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE }=
, =20
>=20
> If you're OK with having the CXL host region at the end of the
> list then that's a simpler way to avoid its presence disturbing
> the layout of the existing regions, but you might not like it
> being at such a high physaddr.

=46rom what I recall a higher address isn't a problem I just wanted to not wa=
ste any
PA space at all so used the gap.

Chunk of /proc/iomem with a random test case (in first case with the cxl bi=
ts
removed as obvious that doesn't start until this patch is in place).
Need more than 123 cpus to make the second gicv3 redist appear
(I've no idea why that number I just printed the threshold where
it was calculated to find out what I needed to wait for boot on).

before this patch.

13ffe0000-13fffffff : System RAM
  13ffe0000-13ffe1fff : reserved
  13ffe2000-13ffe2fff : reserved
  13ffe3000-13fffffff : reserved
4000000000-4003ffffff : GICR
4010000000-401fffffff : PCI ECAM
8000000000-ffffffffff : PCI Bus 0000:00
  8000000000-80001fffff : PCI Bus 0000:01
  8000200000-8000203fff : 0000:00:02.0
    8000200000-8000203fff : virtio-pci-modern
  8000204000-8000207fff : 0000:00:03.0
    8000204000-8000207fff : virtio-pci-modern

after:

13ffe0000-13fffffff : System RAM
  13ffe0000-13ffe2fff : reserved
  13ffe3000-13fff3fff : reserved
  13fff4000-13fffffff : reserved
4000000000-4003ffffff : GICR
4004001128-40040011b7 : port1
4010000000-4010bfffff : PCI ECAM
4010c00000-4010efffff : PCI ECAM
8000000000-80000fffff : PCI Bus 0000:00
  8000000000-8000003fff : 0000:00:02.0
    8000000000-8000003fff : virtio-pci-modern
  8000004000-8000007fff : 0000:00:03.0
    8000004000-8000007fff : virtio-pci-modern

The extra ECAM is the PXB stuff kicking in and stealing part of the ECAM
region of the main host bridge.

The CXL bit we care about here is port1. Despite the name which is
an artifact of how linux represents the topology, that is
the registers for the CXL PXB root bridge.


>=20
> > @@ -1621,6 +1625,17 @@ static void create_pcie(VirtMachineState *vms)
> >      }
> >  }
> >
> > +static void create_cxl_host_reg_region(VirtMachineState *vms)
> > +{
> > +    MemoryRegion *sysmem =3D get_system_memory();
> > +    MemoryRegion *mr =3D &vms->cxl_devices_state.host_mr; =20
>=20
> This looks odd -- why are we reaching directly into the cxl_devices_state
> to fish out a MemoryRegion and init it?

cxl_devices_state state is really just grouping the CXL host stuff that
every cxl host needs so this perhaps looks like more than it actually is.
Maybe that needs a rename. It does less than used to after patch 2 took
some of the Fixed memory stuff out of there.

typedef struct CXLState {
    bool is_enabled;
    MemoryRegion host_mr;
    unsigned int next_mr_idx;
    CXLFixedMemoryWindowOptionsList *cfmw_list;
} CXLState;

It has two purposes.  The cfmw_list and is_enabled are so that
we can use cxl_host_init() to unify setting up the CXL specific machine
properties.

host_mr and next_mr_idx are for a very simple fixed chunk address space
allocator for the PXB-CXL base registers. This is a little bit nasty but
it allows the PXBs to be initialized with -device and yet have mmio
address ranges. Bit similar to the runtime instantiation of SMMUs
problem Shameer was running into, but a simpler one.  I couldn't
find a way to use sysbus or similar here because we also need this
PXB device to exist on the main PCI bus like any other PCI expander bridge
- it just needs these extra registers in the main memory map that are then
pointed to by ACPI table entries. These are what is known as RCRB in PCI
terms (Root complex register base).

See implementation of pxb_cxl_hook_up_registers() call in
virt_machine_done() that stitches this together once we know what
pxb-cxl devices are present and maps sub regions into this container.

I'd be happy to have suggestions on how to do this better as I've never
been fond of this bit.

One option might be to just make this more explicit by putting host_mr and
next_mr_idx directly in the virt machine state and passing them
as separate parameters to pxb_cxl_hook_up_registers(). I'm not sure
that gains much though.  Another path would be to wrap the region init
and add subregion up in a helper function called from here and i386/pc.c
That would mean the name at least was explicitly shared. Not sure it would
bring much other benefit.


>=20
> > +    memory_region_init(mr, OBJECT(vms), "cxl_host_reg",
> > +                       vms->memmap[VIRT_CXL_HOST].size);
> > +    memory_region_add_subregion(sysmem, vms->memmap[VIRT_CXL_HOST].bas=
e, mr);
> > +    vms->highmem_cxl =3D true;
> > +}
> > +
> >  static void create_platform_bus(VirtMachineState *vms)
> >  {
> >      DeviceState *dev;
> > @@ -1737,6 +1752,12 @@ void virt_machine_done(Notifier *notifier, void =
*data)
> >      struct arm_boot_info *info =3D &vms->bootinfo;
> >      AddressSpace *as =3D arm_boot_address_space(cpu, info);
> >
> > +    cxl_hook_up_pxb_registers(vms->bus, &vms->cxl_devices_state,
> > +                              &error_fatal);
> > +
> > +    if (vms->cxl_devices_state.is_enabled) {
> > +        cxl_fmws_link_targets(&error_fatal);
> > +    }
> >      /*
> >       * If the user provided a dtb, we assume the dynamic sysbus nodes
> >       * already are integrated there. This corresponds to a use case wh=
ere
> > @@ -1783,6 +1804,7 @@ static inline bool *virt_get_high_memmap_enabled(=
VirtMachineState *vms,
> >  {
> >      bool *enabled_array[] =3D {
> >          &vms->highmem_redists,
> > +        &vms->highmem_cxl,
> >          &vms->highmem_ecam,
> >          &vms->highmem_mmio,
> >      };
> > @@ -1890,6 +1912,9 @@ static void virt_set_memmap(VirtMachineState *vms=
, int pa_bits)
> >      if (device_memory_size > 0) {
> >          machine_memory_devices_init(ms, device_memory_base, device_mem=
ory_size);
> >      }
> > +
> > +    cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1, 256 * MiB),
> > +                        BIT_ULL(pa_bits)); =20
>=20
> Isn't this stomping over the HIGH_PCIE memory window (or
> whatever else happens to be at the top end of memory) ?

I'll admit the way that these address maps are calculated has caused
me several headaches.  The intention was to go above everything so as to
avoid any changes to the existing map.

>=20
> Also taking highest_gpa and then rounding it up looks suspicious:
> if it's the highest GPA then anything larger than that is off
> the end of the physical address space.
>=20
> Plus cxl_fmws_set_memmap() names its arguments base, max_addr:
> "highest gpa, rounded up" doesn't sound like a base address.
>=20
> (Looking at our current code that sets and adjusts highest_gpa,
> it looks a bit weird: maybe we're setting it to values that aren't
> what the variable name claims it's doing, and that's why this
> code happens to work ?)

I think highest_gpa is a running value of how high we have allocated
to something, not a maximum that is supported.  E.g. what is going on
in virt_set_high_memmap()

I guess I should update vms->highest_gpa.  I think nothing uses it after th=
is
but they might in future.

+    vms->highest_gpa =3D cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1=
, 256 * MiB),
+                                           BIT_ULL(pa_bits)) - 1;

should update it correctly. In i386/pc.c we already updated the memory map =
top address
tracking so that function already returns the start of the next region (hen=
ce the - 1
is needed - that is similar to the call for virt_set_high_memmap() a few li=
nes up.

I think that will also result in more elegant failure on CPUs with limited
address space than we had before as that is checked in virt_cpu_post_init()

Using an a55 for instance fails (Fujitsu folk ran into this a while back)
as we need more than 40 bits.

Just for reference here's the relevant bit of /proc/iomem
for a test setup intended to poke some of these corners.

8000000000-80000fffff : PCI Bus 0000:00
  8000000000-8000003fff : 0000:00:02.0
    8000000000-8000003fff : virtio-pci-modern
  8000004000-8000007fff : 0000:00:03.0
    8000004000-8000007fff : virtio-pci-modern
8000100000-800011ffff : PCI Bus 0000:0c
  8000100000-800010ffff : 0000:0c:00.0
    8000101080-80001010d7 : mem0
  8000110000-800011ffff : 0000:0c:01.0
    8000111080-80001110d7 : mem1
8000120000-ffffffffff : PCI Bus 0000:00
  8000200000-80003fffff : PCI Bus 0000:01
10000000000-101ffffffff : CXL Window 0
  10000000000-1000fffffff : region0
    10000000000-1000fffffff : dax0.0
      10000000000-1000fffffff : System RAM (kmem)

So the windows sits above the PCI region.

>=20
> >  }
> >
> >  static VirtGICType finalize_gic_version_do(const char *accel_name,
> > @@ -2340,6 +2365,8 @@ static void machvirt_init(MachineState *machine)
> >      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
> >                                  machine->ram);
> >
> > +    cxl_fmws_update_mmio();
> > +
> >      virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
> >
> >      create_gic(vms, sysmem);
> > @@ -2395,6 +2422,7 @@ static void machvirt_init(MachineState *machine)
> >      create_rtc(vms);
> >
> >      create_pcie(vms);
> > +    create_cxl_host_reg_region(vms);
> >
> >      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(=
vms)) {
> >          vms->acpi_dev =3D create_acpi_ged(vms);
> > @@ -3365,6 +3393,7 @@ static void virt_instance_init(Object *obj)
> >
> >      vms->oem_id =3D g_strndup(ACPI_BUILD_APPNAME6, 6);
> >      vms->oem_table_id =3D g_strndup(ACPI_BUILD_APPNAME8, 8);
> > +    cxl_machine_init(obj, &vms->cxl_devices_state);
> >  } =20
>=20
> cxl defaults to disabled, right? (i.e. we don't need the
> machine-version specific stuff to keep it from being enabled
> on old versioned machine types).

It is indeed defaulting to disabled.

J

>=20
> thanks
> -- PMM

