Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E6DC433F5
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5798B61108
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhJPFRp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:1732 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhJPFRp (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489588"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489588"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743222"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:36 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 00/27] CXL Region Creation / HDM decoder programming
Date:   Fri, 15 Oct 2021 22:15:04 -0700
Message-Id: <20211016051531.622613-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL region creation
-------------------
An interleave set of devices is known in the Compute Express Link [1]
specification as a region. In addition to a region being comprised of devices
that can be configured in a variety of orders there are other properties that
defines a region. This patch series implements both the interfaces to create and
configure a region, as well as the algorithm to program the HDM decoders to
enable CXL.mem traffic while obeying those configuration parameters. The
functionality is realized via a few drivers which are added and described
below. In addition to those drivers, cxl_core grows new functionality to support
these drivers.

Some version of this functionality has all be posted previously by me, with the
exception of the actual HDM decoder programming. It's probably wise to forget
those exist, and take my apology in advance for not addressing feedback you may
have already given.

There are two branches I am using as development branches. The branch for
port/mem driver [2] is fairly solid. The branch for region creation [3] is less
baked.

cxl_port
========

The cxl_port driver is implemented within the cxl_port module. While loading of
this module is optional, the other new drivers depend on it. The port driver is
responsible for all activities around HDM decoder enumeration and programming.
Introduced earlier, the concept of a port is an abstraction over CXL components
with an upstream port, every host bridge, switch, and endpoint.

cxl_mem
=======

The cxl_mem driver's main job is to walk up the hierarchy to make the
determination if it is CXL.mem routed, meaning, all components above it in the
hierarchy are participating in the CXL.mem protocol. It is implemented within
the cxl_mem module. As the host bridge ports are added by a platform specific
driver, such as cxl_acpi, the scope of the mem driver can be reduced to scan for
switches and ask cxl_core to work on enumerating them. With this done, the
determination as to whether a device is CXL.mem routed can be done simply by
checking if the struct device has a driver bound to it.

cxl_region
==========

Region verification and programming state are owned by the cxl_region driver
(implemented in the cxl_region module). It relies on cxl_mem to determine if
devices are CXL routed, and cxl_port to actually handle the programming of the
HDM decoders. Much of the region driver is an implementation of algorithms
described in the CXL Type 3 Memory Device Software Guide [4].

Why RFC?
--------
The code is pretty raw. I haven't spend much time tidying things up. While I
think most of the architecture is sound, I don't believe anyone but other
developers should use this branch. Where I'd really like most eyes:
- Locking and device lifetimes. As time wore on I definitely took some shortcuts
  there.
- Region configuration. Should values have a default, should they all be
  explicit?
- What should/shouldn't be in core. I like how this ended up, but at this point
  I'm fairly biased (CXL.cache pun).

What's missing
---------------
- CXL 2.0 switch support
- Testing on anything but x1 interleave. While QEMU does support multiple host
  bridges and root ports, it isn't well tested.
- A full topology lock for programming HDM decoders
- Check that HDM decoder programming addresses are correct (must program higher
  addresses only)
- Volatile regions
- Connection to libnvdimm/labels (Dan is working on this). This includes many
  aspects, not the least of which is saving the region into the Label Storage
  Area so that it can be reestablished on reboot.

Here is an example of output when programming a x1 interleave region:
[   23.959814][  T645] cxl_core:cxl_add_region:406: cxl region0.0:0: Added region0.0:0 to decoder0.0
[   23.962972][  T645] cxl_port:cxl_commit_decoder:248: cxl_port port1: decoder1.0
[   23.962972][  T645] 	Base 0x0000004c00000000
[   23.962972][  T645] 	Size 268435456
[   23.962972][  T645] 	IG 256
[   23.962972][  T645] 	IW 1
[   23.962972][  T645] 	TargetList: 0 -1 -1 -1 -1 -1 -1 -1
[   23.965529][  T645] cxl_port:cxl_commit_decoder:248: cxl_port port3: decoder3.0
[   23.965529][  T645] 	Base 0x0000004c00000000
[   23.965529][  T645] 	Size 268435456
[   23.965529][  T645] 	IG 256
[   23.965529][  T645] 	IW 1
[   23.965529][  T645] 	TargetList: -1 -1 -1 -1 -1 -1 -1 -1

If you're wondering how I tested this, I've baked it into my cxlctl app [5] and
lib [6]. Eventually this will get absorbed by ndctl/cxl-cli/libcxl [7].

To get the detailed errors, trace-cmd can be utilized as such:
trace-cmd record -e cxl ./cxlctl create-region -n -a -s $((256<<20)) /sys/bus/cxl/devices/decoder0.0


[1]: https://www.computeexpresslink.org/download-the-specification
[2]: https://gitlab.com/bwidawsk/linux/-/tree/cxl_port-v2
[3]: https://gitlab.com/bwidawsk/linux/-/tree/cxl_regions-v3
[4]: https://cdrdv2.intel.com/v1/dl/getContent/643805?wapkw=CXL%20memory%20device%20sw%20guide
[5]: https://gitlab.com/bwidawsk-cxl/cxlctl
[6]: https://gitlab.com/bwidawsk-cxl/cxl_rs
[7]: https://lore.kernel.org/linux-cxl/CAPcyv4joKOhTdaRBJVeoOtqhRjBvdtt9902TS=c39=zWTZXvuw@mail.gmail.com/

Ben Widawsky (27):
  cxl: Rename CXL_MEM to CXL_PCI
  cxl: Move register block enumeration to core
  cxl/acpi: Map component registers for Root Ports
  cxl: Add helper for new drivers
  cxl/core: Convert decoder range to resource
  cxl: Introduce endpoint decoders
  cxl/port: Introduce a port driver
  cxl/acpi: Map single port host bridge component registers
  cxl/core: Store global list of root ports
  cxl/acpi: Rescan bus at probe completion
  cxl/core: Store component register base for memdevs
  cxl: Flesh out register names
  cxl/core: Introduce API to scan switch ports
  cxl: Introduce cxl_mem driver
  cxl: Disable switch hierarchies for now
  cxl/region: Add region creation ABI
  cxl/region: Introduce concept of region configuration
  cxl/region: Introduce a cxl_region driver
  cxl/acpi: Handle address space allocation
  cxl/region: Address space allocation
  cxl/region: Implement XHB verification
  cxl/region: HB port config verification
  cxl/region: Record host bridge target list
  cxl/mem: Store the endpoint's uport
  cxl/region: Gather HDM decoder resources
  cxl: Program decoders for regions
  dont-merge: My QEMU CFMWS is wrong

 .clang-format                                 |   3 +
 Documentation/ABI/testing/sysfs-bus-cxl       |  63 ++
 .../driver-api/cxl/memory-devices.rst         |  28 +
 drivers/cxl/Kconfig                           |  28 +-
 drivers/cxl/Makefile                          |   8 +-
 drivers/cxl/acpi.c                            | 117 +++-
 drivers/cxl/core/Makefile                     |   2 +
 drivers/cxl/core/bus.c                        | 346 +++++++++-
 drivers/cxl/core/core.h                       |   2 +
 drivers/cxl/core/memdev.c                     |   7 +-
 drivers/cxl/core/pci.c                        |  99 +++
 drivers/cxl/core/region.c                     | 453 +++++++++++++
 drivers/cxl/core/regs.c                       |  62 +-
 drivers/cxl/cxl.h                             |  78 ++-
 drivers/cxl/cxlmem.h                          |   8 +-
 drivers/cxl/mem.c                             | 161 +++++
 drivers/cxl/pci.c                             |  69 +-
 drivers/cxl/pci.h                             |  48 +-
 drivers/cxl/port.c                            | 490 ++++++++++++++
 drivers/cxl/region.c                          | 626 ++++++++++++++++++
 drivers/cxl/region.h                          |  57 ++
 drivers/cxl/trace.h                           |  54 ++
 tools/testing/cxl/Kbuild                      |   2 +
 tools/testing/cxl/mock_acpi.c                 |   4 +-
 tools/testing/cxl/test/mem.c                  |   3 +-
 25 files changed, 2688 insertions(+), 130 deletions(-)
 create mode 100644 drivers/cxl/core/pci.c
 create mode 100644 drivers/cxl/core/region.c
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/port.c
 create mode 100644 drivers/cxl/region.c
 create mode 100644 drivers/cxl/region.h
 create mode 100644 drivers/cxl/trace.h

-- 
2.33.1

