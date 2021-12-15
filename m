Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81068C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Dec 2021 17:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbhLOR0n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:26:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4296 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbhLORZU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 15 Dec 2021 12:25:20 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDhtC0gjCz67wqv;
        Thu, 16 Dec 2021 01:23:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 18:25:16 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Dec
 2021 17:25:16 +0000
Date:   Wed, 15 Dec 2021 17:25:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 00/14] Add drivers for CXL ports and mem devices
Message-ID: <20211215172515.000079fb@huawei.com>
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 1 Dec 2021 20:37:36 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Significant changes since v1 [1]:
> - Reworked decoder alloc APIs to be specific to component type
> - cxl_mem handles DVSEC checks instead of cxl_port
> - buggy switch handling in cxl_mem is #if 0'd out
> - cxl_pci will fail if the Device DVSEC can't be found
> 
> There were a few improvements from the RFC, v1, and discussions on IRC (goto
> #cxl on OFTC). Dan has some patches that apply either on top of, or squashed in
> with these. Those are:
> 1. Global root port list doesn't need to exist.
> 2. Port enumeration doesn't rely on PCIe concepts to walk topology
> 3. Port driver should handle enumerating dports
> 
> Here I've also dropped the prep patches which are mostly reviewed. Those are
> here [2].
> 
> What follows is the original cover letter from v1 [1]
> 
> [1]: https://lore.kernel.org/linux-cxl/20211120000250.1663391-1-ben.widawsky@intel.com/
> [2]: https://lore.kernel.org/linux-cxl/20211129214721.1668325-1-ben.widawsky@intel.com/

Hi Ben, I've been poking at this on top of QEMU and noticed
one thing that isn't good.

Probing cxl_port then cxl_acpi fails to find the ports:
[  561.228844] cxl_port port1: Failed to add decoder
[  561.230133] cxl_port port1: Failed to add decoder to switch port
[  561.232769] cxl_port port1: Couldn't enumerate decoders (-22)
[  561.234181] cxl_port: probe of port1 failed with error -22
[  561.237527] pcieport 0000:de:00.0: No component register block found
[  561.238917] pcieport 0000:de:01.0: No component register block found
[  561.242277] cxl_port port2: Failed to add decoder
[  561.244104] cxl_port port2: Failed to add decoder to switch port
[  561.245371] cxl_port port2: Couldn't enumerate decoders (-22)
[  561.246377] cxl_port: probe of port2 failed with error -22
[  561.248140] pcieport 0000:0c:00.0: No component register block found
(The register blocks ones are spurious)
No portsN entries created.

cxl_acpi then cxl_port and everything works.

I haven't chased down the reason as more interested (today anyway) in debugging
the QEMU side of things where possible.

J

> ---
> 
> This is the first set of patches from the RFC [1] for region creation. The
> patches enable port enumeration for endpoint devices, and enumeration of decoder
> resources for ports. In the RFC [1], I felt it necessary to post the consumer of
> this work, the region driver, so that it was clear why these patches were
> necessary. Because the region patches patches are less baked, and received no
> review in the RFC, they are excluded here. If you find yourself unclear about
> why these patches are interesting, go look at the RFC [1].
> 
> Each patch contains the list of changes from RFCv2. IMHO the following are the
> high level most important changes:
> 1. Rework cxl_pci to fix mailbox handling and allow for wait media ready.
> 2. DVSEC range information is passed from cxl_pci and checked
> 
> linux-pci is on the Cc since CXL lives in a parallel universe to PCI and some
> PCI mechanisms are reused here. Feedback from experts in that domain is very
> welcome.
> 
> What was requested and not changed:
> 1. Dropping global list of root ports.
> 2. Improving find_parent_cxl_port()
> 
> ---
> 
> Summary
> =======
> 
> Two new drivers are introduced to support Compute Express Link 2.0 [2] HDM
> decoder enumeration. While the existing cxl_acpi and cxl_pci drivers already
> create some of the necessary devices, they did not do full enumeration of
> decoders, and they did not do port enumeration for switches. Additionally, CXL
> 2.0 Root Port component registers are now handled as well.
> 
> cxl_port
> ========
> 
> The cxl_port driver is implemented within the cxl_port module. While loading of
> this module is optional, the other new drivers depend, and cxl_acpi depend on it
> for complete enumeration. The port driver is responsible for all activities
> around HDM decoder enumeration and programming. Introduced earlier, the concept
> of a port is an abstraction over CXL components with an upstream port, every
> host bridge, switch, and endpoint.
> 
> cxl_mem
> =======
> 
> The cxl_mem driver's main job is to walk up the hierarchy to make the
> determination if it is CXL.mem routed, meaning, all components above it in the
> hierarchy are participating in the CXL.mem protocol. It is implemented within
> the cxl_mem module. As the host bridge ports are added by a platform specific
> driver, such as cxl_acpi, the scope of the mem driver can be reduced to scan for
> switches and ask cxl_core to work on enumerating them. With this done, the
> determination as to whether a device is CXL.mem routed can be done simply by
> checking if the struct device has a driver bound to it.
> 
> Results
> =======
> 
> Running these patches should yield new devices and new drivers under
> /sys/bus/cxl/devices and /sys/bus/cxl/drivers. For example, in a standard QEMU
> run, using run_qemu [3]
> 
> /sys/bus/cxl/devices (new):
> # The host bridge CHBS decoder
> lrwxrwxrwx 1 root root 0 Nov 19 15:23 decoder1.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/decoder1.0
> # mem0's decoder
> lrwxrwxrwx 1 root root 0 Nov 19 15:23 decoder2.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/port2/decoder2.0
> # mem1's decoder
> lrwxrwxrwx 1 root root 0 Nov 19 15:23 decoder3.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/port3/decoder3.0
> # mem0's port
> lrwxrwxrwx 1 root root 0 Nov 19 15:23 port2 -> ../../../devices/platform/ACPI0017:00/root0/port1/port2
> # mem1's port
> lrwxrwxrwx 1 root root 0 Nov 19 15:23 port3 -> ../../../devices/platform/ACPI0017:00/root0/port1/port3
> 
> /sys/bus/cxl/drivers:
> drwxr-xr-x 2 root root 0 Nov 19 15:23 cxl_mem
> 
> [1]: https://lore.kernel.org/linux-cxl/20211022183709.1199701-1-ben.widawsky@intel.com/T/#t
> [2]: https://www.computeexpresslink.org/download-the-specification
> [3]: https://github.com/pmem/run_qemu/
> drwxr-xr-x 2 root root 0 Nov 19 15:23 cxl_port
> Ben Widawsky (14):
>   cxl/core: Add, document, and tighten up decoder APIs
>   cxl: Introduce endpoint decoders
>   cxl/core: Move target population locking to caller
>   cxl: Introduce topology host registration
>   cxl/core: Store global list of root ports
>   cxl/pci: Cache device DVSEC offset
>   cxl: Cache and pass DVSEC ranges
>   cxl/pci: Implement wait for media active
>   cxl/pci: Store component register base in cxlds
>   cxl: Make passthrough decoder init implicit
>   cxl/port: Introduce a port driver
>   cxl: Unify port enumeration for decoders
>   cxl/port: Cleanup adding passthrough decoders
>   cxl/mem: Introduce cxl_mem driver
> 
>  Documentation/ABI/testing/sysfs-bus-cxl       |   9 +
>  .../driver-api/cxl/memory-devices.rst         |  14 +
>  drivers/cxl/Kconfig                           |  21 +
>  drivers/cxl/Makefile                          |   4 +
>  drivers/cxl/acpi.c                            |  82 +--
>  drivers/cxl/core/Makefile                     |   1 +
>  drivers/cxl/core/bus.c                        | 479 ++++++++++++++++--
>  drivers/cxl/core/core.h                       |   3 +
>  drivers/cxl/core/memdev.c                     |   2 +-
>  drivers/cxl/core/pci.c                        | 117 +++++
>  drivers/cxl/core/regs.c                       |   6 +-
>  drivers/cxl/cxl.h                             |  59 ++-
>  drivers/cxl/cxlmem.h                          |  23 +
>  drivers/cxl/mem.c                             | 285 +++++++++++
>  drivers/cxl/pci.c                             | 200 ++++++++
>  drivers/cxl/pci.h                             |  16 +
>  drivers/cxl/port.c                            | 368 ++++++++++++++
>  tools/testing/cxl/Kbuild                      |   1 +
>  tools/testing/cxl/mock_acpi.c                 |   4 +-
>  19 files changed, 1589 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/cxl/core/pci.c
>  create mode 100644 drivers/cxl/mem.c
>  create mode 100644 drivers/cxl/port.c
> 
> 
> base-commit: c19a248a84b950ef53c6768751cc917ec2c6b6cf

