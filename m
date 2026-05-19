Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA734041F;
	Tue, 19 May 2026 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196410; cv=none; b=NCvJwtqumtHtgVJC3iEJOYN9d5oYuVWTEJjNq1qV3P1QgyReserIiyCOKkmqtA5hiTxdwaivlj+IXdsb7kHDAlByi+Lv5Y+ZvDf7XapTVjT3QviRjthZHboleLbL7wWNWarZOYuHGKof6lxp3l8lJYoM1pPAyILAzQk2M8VhOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196410; c=relaxed/simple;
	bh=D8gjAVbdbrG6Z9lKQi7hVCEYxhwYV/YGXCYHSkLsbJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAyKxb4NFPWZeyZqzYNRcyuPo0UzybFSvSKPACl9JIa1nYj5DmWQmY+cz1BkAD4vZ7gUH9/2IzGNC8S+OLVRil7enSxhu+CcINz5/gSDR04ddUEVJifY3yP4iCytjQFXi9ihV4RVcDkhNxEYgbo7FspugkmCalbFejiE/sb8ruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4yNoEJg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4yNoEJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FA7C2BCB3;
	Tue, 19 May 2026 13:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779196410;
	bh=D8gjAVbdbrG6Z9lKQi7hVCEYxhwYV/YGXCYHSkLsbJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j4yNoEJg7QuAkAvMofwploWnLBYR+j9sHLfufOKZUiFZdPCgi6w2SSjtkQN6DXPUF
	 RAxCNsxJZHZiQimb/Fd16SKVR/smqt28jHi8ghhRmKtcIvuMHGtKfnUy2WAaPXWBW2
	 IS/tobdOy1jngJhL2YQmQwvhXHbxe+TXFDIMFvaC2+tz8ohfelFdK5j+cgSQ6PVKhZ
	 xZ+kl+VH4P39YWYGqnEiclbJ0SNsiwGJnClkkwJ5IxL4SKraTPeJIYt992WSWITNJp
	 PyLUjSpD+oGqZpEwfpah08wvpaKgeJTGd08fpOh8Ywua5g7jOM0ICBf9MO6Cf3wviO
	 1eXMtvrh81gcw==
Date: Tue, 19 May 2026 14:13:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>,
 <ankita@nvidia.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <anisinha@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <clg@redhat.com>, <cohuck@redhat.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
 <zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
 <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
Message-ID: <20260519141314.3eda68bc@jic23-huawei>
In-Reply-To: <20260427181235.3003865-1-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 23:42:26 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> This series adds QEMU-side support for passing CXL Type-2 devices
> (GPUs and accelerators with host-managed device memory) to VMs via
> vfio-pci.
Hi Manish,

Having read this description I'm not sure I really understand all the
constraints this is operating under.

There are two basic paths to getting safe virtualisation of CXL.mem.
1) Lock down decoders etc against preconfigured mappings.
2) Constrain the more insane stuff via topology care - basically direct connect
   only for now and let the guest program stuff appropriately.

One possible constraint is making it all look like early CXL host stuff
where the bios does the heavy lifting.  I don't mind if we have to do that
today but I'd like to understand if it's a long term requirement or not.

I think this is currently doing a mix of 1 and 2.  You lock endpoint
decoders but ignore host bridge ones.  I think we need to handle those.
Maybe I'm missing a check that a pass through decoder is in use
(there is a commandline control to turn that on / off for single RP HB).


> 
> It pairs with the kernel series "vfio/pci: CXL Type-2 passthrough"[1]
> posted to the vfio mailing list. Patches 3-7 need that kernel series
> present to do anything useful. I am new to QEMU development, so please
> forgive and point me in the right direction for correct infrastructure
> decisions.
> 
> Background
> ----------
> 
> CXL Type-2 devices expose device memory (CXL.mem) through HDM decoders.
> The kernel vfio-pci driver shadows the HDM Decoder Capability registers
> so userspace can observe and control decoder commits without touching
> the hardware register page directly.
> 
> Without this series, the guest never sees the device memory range and
> the HDM decoder goes unconfigured. The device shows up but its memory
> is unreachable.
> 
> Design decisions
> ----------------
> 
> CXL.mem is exposed to the guest as a dedicated GPA window declared in ACPI
> (CEDT/CFMWS) rather than a PCI BAR. The HDM decoder BASE must match the
> CFMWS base and remain stable; BAR assignment is not stable.

Note a lot of my thinking here is based on the related but not identical
question of how to do CXL type 3 emulation for virtualization cases.

My thinking for type 2 is we'd do similar tricks to for memory in constraining
the topology so things like interleave don't cause us problems and CFMWS to
particular device mappings are fixed (though in theory offsets with in CFMWS could
change). 

I may be missing the point entirely but why does HDM decoder base (here the
GPA address where the routing is configured to put the DPA of the EP)
need to match the CFMWS base or for that matter remain stable (i.e.
Guest forced to put it in the same place)? Is it just so the type 2
driver knows where to find it?  (There are easy ways around that - or
is this something baked into an existing driver?)

There are a few easy ways to constrain things to reduce flexibility (e.g.
we don't want interleave to be possible etc).  If we absolutely have
to we can also lock decoders. The only reason I was avoiding that for
type 3 device was that it isn't needed + can get complex fast!

I think you are constraining the topology for this to work to PXB with
1 RP with pass through HDM decoders and no switches etc.
That's fine for now but I didn't immediately spot the checks that enforce that.

Can we have a command line example in this cover letter.

> A separate
> VIRT_HIGH_CXL_MMIO window in the ARM virt memory map carries this GPA range,
> independent of the existing PCIe MMIO slots.

I'm not immediately understanding why the CXL.mem path isn't via exiting
CFMWS support.  Why do we need a new memory window?  Ultimately you
seem to map to normal CFMWS regions.  Also note you need to be very careful
adding stuff to the memory map as bunch of other stuff above that will
move - so it must simply not be there by default to avoid breaking migration
of existing VMs.  Maybe that is fine, I didn't check carefully

> 
> The Component Register BAR contains two distinct ranges. Accelerator
> register windows are passed through as direct hardware mmaps via
> VFIO_REGION_INFO_CAP_SPARSE_MMAP. The HDM Decoder Capability block is
> excluded from that sparse list by the kernel and must be intercepted by
> QEMU to track decoder state. A single priority-1 COMP_REGS overlay
> placed at hdm_regs_offset inside the BAR container wins over any
> hardware-backed alias at the same offset, with no per-window aliasing
> required.
> 
> The guest has no mechanism to remap host physical mappings. QEMU programs
> decoder 0 with the CFMWS base through the kernel's COMP_REGS shadow at
> machine_done time, after all devices are realized and before the guest starts.

Ah so this is locking down the decoder?  I'm not necessarily against
that but would like to understand what the constraints are that lead
to that being necessary as opposed to guest programming them later
(and late set up of the MemoryRegion like we do for type 3)

> The notifier is registered only for devices the kernel reports as
> firmware-committed (VFIO_CXL_CAP_FIRMWARE_COMMITTED).
> 
> The CXL.mem MemoryRegion is a mmap-backed RAM-device region backed by a
> VM_IO|VM_PFNMAP VMA. The VFIO MemoryListener would attempt an IOMMU
> DMA mapping for it when it is added to system_memory, which always
> fails: pin_user_pages() refuses VM_IO pages. No IOMMU mapping is needed
> for these regions - CPU access goes via KVM Stage-2 page faults and
> device DMA to RAM uses separate per-RAM-section IOMMU entries. The
> listener is extended to skip the mapping attempt for VFIO-owned
> RAM-device regions.
> 
> pxb-cxl bridges had no _DSM method. Without _DSM function 5 the OS
> defaults to treating PCI configuration as reassignable.

That one is annoyingly controversial. I see you have Shameer's patch
so he can go into history of why. I tried to land that in the past and
I was far from the first.

> On machines with firmware-committed HDM decoders that reassignment breaks
> the CXL.mem mapping, so the _DSM is added with preserve_config=true for ARM and
> false for x86.

What has that got to do with CXL.mem mapping?  It can move the
BARs around but those aren't related to the CXL.mem mapping.

Can we break this description up into two separate parts as it feels like
BAR mappings and CXL.mem mappings are getting confused.

1) Deal with how the configuration stuff works - bars etc.
2) Deal with the CXL.mem mapping into a CFMWS.

> 
> Known issues:
> - The bios-tables test will fail due to the _DSM addition.
>   A fix will be provided in a follow-up round.

Unless I'm missing some checks, a whole load more than that will fail
as device memory / memory hotplug region + probably the CFMWS regions all
move.

> - VFIO_CXL_CAP_CACHE_CAPABLE will require additional handling.
> - Devices with multiple firmware-committed HDM decoders are not fully
>   supported.
> - Non-firmware-committed devices are not supported.
> - linux-headers sync is manual and temporary; once the kernel series is
>   merged, this patch will be replaced with script generated update.
> 
> [1] https://lore.kernel.org/linux-cxl/20260401143917.108413-1-mhonap@nvidia.com
> 
Anyhow, seems like a good starting point for discussion.

As we evolve the CXL support into including real virtualization use cases
I'm sure we'll also throw up random corners around resetting etc.

Note I mostly skipped the VFIO stuff on basis others know a lot more on that
side of things than I do!

Thanks,

Jonathan

> Manish Honap (9):
>   hw/arm/virt: Add CXL FMWS PA window for device memory
>   cxl: Add preserve_config to pxb-cxl OSC method
>   linux-headers: Update vfio.h for CXL Type-2 device passthrough
>   hw/vfio/region: Add vfio_region_setup_with_ops() for custom region ops
>   hw/vfio/pci: Add CXL Type-2 device detection and region setup
>   hw/vfio/pci: Wire CXL component-register BAR with COMP_REGS overlay
>   hw/vfio+cxl: Program HDM decoder 0 at machine_done for
>     firmware-committed devices
>   hw/arm/smmu-common: Allow pxb-cxl as SMMUv3 primary bus
>   vfio/listener: Skip DMA mapping for VFIO-owned RAM-device regions
> 
>  hw/acpi/cxl-stub.c         |   2 +-
>  hw/acpi/cxl.c              |   4 +-
>  hw/arm/smmu-common.c       |  17 +-
>  hw/arm/virt-acpi-build.c   |   5 +
>  hw/arm/virt.c              |   7 +
>  hw/cxl/cxl-host-stubs.c    |   2 +
>  hw/cxl/cxl-host.c          |   8 +
>  hw/i386/acpi-build.c       |   2 +-
>  hw/pci-host/gpex-acpi.c    |  43 +++-
>  hw/vfio/listener.c         |  14 ++
>  hw/vfio/pci.c              | 411 +++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.h              |  15 ++
>  hw/vfio/region.c           |  15 +-
>  hw/vfio/trace-events       |   6 +
>  hw/vfio/vfio-region.h      |   3 +
>  include/hw/acpi/cxl.h      |   2 +-
>  include/hw/arm/virt.h      |   2 +
>  include/hw/cxl/cxl_host.h  |  10 +
>  include/hw/pci-host/gpex.h |   2 +
>  linux-headers/linux/vfio.h |  18 ++
>  20 files changed, 570 insertions(+), 18 deletions(-)
> 
> --
> 2.25.1
> 
> 

