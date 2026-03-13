Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282C1DD525;
	Fri, 13 Mar 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404030; cv=none; b=TAZKk7kDTx6+oIjndsbMzN0kp6Qoqawo09sASrDdbD+HpeYpdiBWgS9s7T80HGbUYH9U6LJfAfHb4TuoKSVhwmnoAeXjyAA1ArUz5Mncq8z4zJX1poEEBOwde50IW7K48CwNyoWyt8rHReTyWf0aDr69Daximc4AZLFBKcX7FAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404030; c=relaxed/simple;
	bh=4OUga/qL11/hK1Tvm52+ivix8F2qnNTJ7H51oiLZql4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s55hL/W7k9HTwPYV1wJteoWDBartA6hQ9IN6kkSrLIbwrmBU450aabvT42tKBCwVYWvik60o5N24V40d7vEPmuZrvj/XOa2NO3FcLY7W9l8Mwmjml0kKWBgiamRizoaXG3eIPNoKbSQ5ToFID/egDPoW8wE5O+pwdB4/TwK2GrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fXNgJ3fMxzHnH5h;
	Fri, 13 Mar 2026 20:13:32 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1749F40569;
	Fri, 13 Mar 2026 20:13:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 12:13:43 +0000
Date: Fri, 13 Mar 2026 12:13:41 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <mhonap@nvidia.com>
CC: <aniketa@nvidia.com>, <ankita@nvidia.com>, <alwilliamson@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
	<kevin.tian@intel.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 18/20] docs: vfio-pci: Document CXL Type-2 device
 passthrough
Message-ID: <20260313121341.00001bfa@huawei.com>
In-Reply-To: <20260311203440.752648-19-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-19-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 12 Mar 2026 02:04:38 +0530
mhonap@nvidia.com wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Add a driver-api document describing the architecture, interfaces, and
> operational constraints of CXL Type-2 device passthrough via vfio-pci-core.
> 
> CXL Type-2 devices (cache-coherent accelerators such as GPUs with attached
> device memory) present unique passthrough requirements not covered by the
> existing vfio-pci documentation:
> 
> - The host kernel retains ownership of the HDM decoder hardware through
>   the CXL subsystem, so the guest cannot program decoders directly.
> - Two additional VFIO device regions expose the emulated HDM register
>   state (COMP_REGS) and the DPA memory window (DPA region) to userspace.
> - DVSEC configuration space writes are intercepted and virtualized so
>   that the guest cannot alter host-owned CXL.io / CXL.mem enable bits.
> - Device reset (FLR) is coordinated through vfio_pci_ioctl_reset(): all
>   DPA PTEs are zapped before the reset and restored afterward.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>

Hi Manish.

Great to see this doc.

Provides a convenient place to talk about the restrictions on this
current patch set and how we resolve them.

My particular interest is in the region sizing as I don't see using
a locked own bios setup range as a comprehensive solution.

Shall we say, there is some awareness that the CXL spec doesn't require
enough information from type 2 devices and it wasn't necessarily
understood that VFIO type solutions can't rely on the
"It's an accelerator so it has a custom driver, no need for standards"

It is a gap I'd like to close.  Given it's being discussed in public
we can prepare a Code First proposal to either add stuff to the spec
or develop some external guidance on what a device needs to do if we
aren't going to need either a variant driver, or device specific handling
in user space.



> ---
>  Documentation/driver-api/index.rst        |   1 +
>  Documentation/driver-api/vfio-pci-cxl.rst | 216 ++++++++++++++++++++++
>  2 files changed, 217 insertions(+)
>  create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
> 
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index 1833e6a0687e..7ec661846f6b 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst

>  
>  Bus-level documentation
>  =======================
> diff --git a/Documentation/driver-api/vfio-pci-cxl.rst b/Documentation/driver-api/vfio-pci-cxl.rst
> new file mode 100644
> index 000000000000..f2cbe2fdb036
> --- /dev/null
> +++ b/Documentation/driver-api/vfio-pci-cxl.rst

> +Device Detection
> +----------------
> +
> +CXL Type-2 detection happens automatically when ``vfio-pci`` registers a
> +device that has:
> +
> +1. A CXL Device DVSEC capability (PCIe DVSEC Vendor ID 0x1E98, ID 0x0000).
> +2. Bit 2 (Mem_Capable) set in the CXL Capability register within that DVSEC.

FWIW to be type 2 as opposed to a type 3 non class code device (e.g. the
compressed memory devices Gregory Price and others are using) you need
Cache_capable as well.  Might be worth making this all about
CXL Type-2 and non class code Type-3.

> +3. A PCI class code that is **not** ``0x050210`` (CXL Type-3 memory device).
> +4. An HDM Decoder block discoverable via the Register Locator DVSEC.
> +5. A pre-committed HDM decoder (BIOS/firmware programmed) with non-zero size.

This is the bit that we need to make more general. Otherwise you'll have
to have a bios upgrade for every type 2 device (and no native hotplug).
Note native hotplug is quite likely if anyone is switch based device
pooling.

I assume that you are doing this today to get something upstream
and presume it works for the type 2 device you have on the host you
care about.  I'm not sure there are 'general' solutions but maybe
there are some heuristics or sufficient conditions for establishing the
size.

Type 2 might have any of:
- Conveniently preprogrammed HDM decoders (the case you use)
- Maximum of 2 HDM decoders + the same number of Range registers.
  In general the problem with range registers is they are a legacy feature
  and there are only 2 of them whereas a real device may have many more
  DPA ranges. In this corner case though, is it enough to give us the
  necessary sizes?  I think it might be but would like others familiar
  with the spec to confirm. (If needed I'll take this to the consortium
  for an 'official' view).
- A DOE and table access protocol.  CDAT should give us enough info to
  be fairly sure what is needed.
- A CXL mailbox (maybe the version in the PCI spec now) and the spec defined
  commands to query what is there.  Reading the intro to 8.2.10.9 Memory
  Device Command Sets, it's a little unclear on whether these are valid on
  non class code devices but I believe having the appropriate Mailbox
  type identifier is enough to say we expect to get them.

None of this is required though and the mailboxes are non trivial.
So personally I think we should propose a new DVSEC that provides any
info we need for generic passthrough.  Starting with what we need
to get the regions right.  Until something like that is in place we
will have to store this info somewhere.

There is (maybe) an alternative of doing the region allocation on demand.
That is emulate the HDM decoders in QEMU (on top of the emulation
here) and when settings corresponding to a region setup occur,
go request one from the CXL core. The problem is we can't guarantee
it will be available at that time. So we can 'guess' what to provide
to the VM in terms of CXL fixed memory windows, but short of heuristics
(either whole of the host offer, or divide it up based on devices present
 vs what is in the VM) that is going to be prone to it not being available
later.

Where do people think this should be?  We are going to end up with
a device list somewhere. Could be in kernel, or in QEMU or make it an
orchestrator problem (applying the 'someone else's problem' solution).

       | locked after Lock register bit 0 is set.  |
> +
> +VMM Integration Notes
> +---------------------
> +
> +A VMM integrating CXL Type-2 passthrough should:
> +
> +1. Issue ``VFIO_DEVICE_GET_INFO`` and check ``VFIO_DEVICE_FLAGS_CXL``.
> +2. Walk the capability chain to find ``VFIO_DEVICE_INFO_CAP_CXL`` (id = 6).
> +3. Record ``dpa_region_index``, ``comp_regs_region_index``, ``dpa_size``,
> +   ``hdm_count``, ``hdm_regs_offset``, and ``hdm_regs_size``.
> +4. Map the DPA region (``dpa_region_index``) with mmap() to a guest physical
> +   address.  The region supports ``PROT_READ | PROT_WRITE``.
> +5. Open the COMP_REGS region (``comp_regs_region_index``) and attach a
> +   ``notify_change`` callback to detect COMMIT transitions.  When bit 10
> +   (COMMITTED) transitions from 0 to 1 in a CTRL register read, the VMM
> +   should expose the corresponding DPA range to the guest and map the
> +   relevant slice of the DPA mmap.
> +6. For pre-committed devices (``VFIO_CXL_CAP_PRECOMMITTED`` set) the entire
> +   DPA is already mapped and the VMM need not wait for a guest COMMIT.
> +7. Program the guest CXL DVSEC registers (via VFIO config space write) to
> +   reflect the guest's view.  The kernel emulates all register semantics
> +   including the CONFIG_LOCK one-shot latch.
> +

Can you share an RFC for this flow in QEMU?  Ideally also a type 2 model
(there have been a few posted in the past) that would allow testing this with
emulated qemu as the host, then KVM / VFIO on top of that?
If not I can probably find some time to hack something together.

Thanks,

Jonathan

