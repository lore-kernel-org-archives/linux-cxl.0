Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA7DC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2006054F
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhJVSjd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:5577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233841AbhJVSjc (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528922"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528922"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:14 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854585"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:14 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 00/28] CXL Region Creation / HDM decoder programming
Date:   Fri, 22 Oct 2021 11:36:41 -0700
Message-Id: <20211022183709.1199701-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Because v1 wasn't reviewed, and I quickly asked people to ignore it in favor of
this version, I'm not going to bother listing out the changes. I've only issued minor
edits to the original cover letter. If you already read that, feel free to move
along.

I don't have plans to send further RFCs until I receive feedback, good or bad.

CXL region creation
-------------------
An interleaved set of devices is known in the Compute Express Link [1]
specification as a region. In addition to a region being comprised of devices
that can be configured in a variety of orders there are other properties that
define a region. It is expected that a region may be created as part of
provisioning by the hardware vendor, or interactively via operating system
controls. This patch series implements both the interfaces to create and
configure a region, as well as the algorithm to program the HDM decoders to
enable CXL.mem traffic while obeying those configuration parameters. The series
stops short of storing the new regions in the Label Storage Area of the CXL
devices.

Some version of this functionality has all been posted previously, with the
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

This driver is also a logical place to migrate certain functionality from
cxl_pci. That is saved for later.

cxl_region
==========

Region verification and programming state are owned by the cxl_region driver
(implemented in the cxl_region module). It relies on cxl_mem to determine if
devices are CXL routed, and cxl_port to actually handle the programming of the
HDM decoders. Much of the region driver is an implementation of algorithms
described in the CXL Type 3 Memory Device Software Guide [4].

The patches for the region driver could be squashed. They're broken out to aid
review and because that's the order they were implemented in. My preference is
to keep those as they are.

Why RFC?
--------
While I think most of the architecture is sound, I don't believe anyone but
other developers should use this branch. Where I'd really like most eyes:
- Locking and device lifetimes. I suspect I have many bugs in this area.
- Region configuration. Should values have a default, should they all be
  explicit?
- What should/shouldn't be in core. I like how this ended up, but at this point
  I'm fairly biased (CXL.cache pun).
- What to extend to cxl_test.

What's missing
---------------
- CXL 2.0 switch support
- A full topology lock for programming HDM decoders. I'm looking for feedback on
  the best way to do this.
- Check that HDM decoder programming addresses are correct (must program higher
  addresses only)
- Volatile regions (or BIOS configured persistent regions)
- Connection to libnvdimm/labels. This includes many aspects, not the least of
  which is saving the region into the Label Storage Area so that it can be
  reestablished on reboot.

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
lib [6]. Eventually this will get absorbed by ndctl/cxl-cli/libcxl [7]. Region
deletion isn't implemented yet.

To get the detailed errors, trace-cmd can be utilized. Until a region device
exists, the region module will not be loaded, which means the region tracepoints
will not exist. To get around this, modprobe cxl_region before anything.

trace-cmd record -e cxl ./cxlctl create-region -n -a -s $((256<<20)) /sys/bus/cxl/devices/decoder0.0

Note: A minor bugfix is needed in QEMU if testing interleave configs. I've
pushed that to my v4 branch.
---

[1]: https://www.computeexpresslink.org/download-the-specification
[2]: https://gitlab.com/bwidawsk/linux/-/tree/cxl_port-v3
[3]: https://gitlab.com/bwidawsk/linux/-/tree/cxl_regions-v4
[4]: https://cdrdv2.intel.com/v1/dl/getContent/643805?wapkw=CXL%20memory%20device%20sw%20guide
[5]: https://gitlab.com/bwidawsk-cxl/cxlctl
[6]: https://gitlab.com/bwidawsk-cxl/cxl_rs
[7]: https://lore.kernel.org/linux-cxl/CAPcyv4joKOhTdaRBJVeoOtqhRjBvdtt9902TS=c39=zWTZXvuw@mail.gmail.com/
---

Ben Widawsky (28):
  cxl: Rename CXL_MEM to CXL_PCI
  cxl: Move register block enumeration to core
  cxl/acpi: Map component registers for Root Ports
  cxl: Add helper for new drivers
  cxl/core: Convert decoder range to resource
  cxl: Introduce endpoint decoders
  cxl/core: Move target population locking to caller
  cxl/port: Introduce a port driver
  cxl/acpi: Map single port host bridge component registers
  cxl/core: Store global list of root ports
  cxl/acpi: Rescan bus at probe completion
  cxl/core: Store component register base for memdevs
  cxl: Flesh out register names
  cxl: Hide devm host for ports
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

 .clang-format                                 |   3 +
 Documentation/ABI/testing/sysfs-bus-cxl       |  63 ++
 .../driver-api/cxl/memory-devices.rst         |  28 +
 drivers/cxl/Kconfig                           |  28 +-
 drivers/cxl/Makefile                          |   8 +-
 drivers/cxl/acpi.c                            | 132 +++-
 drivers/cxl/core/Makefile                     |   2 +
 drivers/cxl/core/bus.c                        | 437 +++++++++++-
 drivers/cxl/core/core.h                       |   2 +
 drivers/cxl/core/memdev.c                     |   7 +-
 drivers/cxl/core/pci.c                        |  99 +++
 drivers/cxl/core/region.c                     | 453 +++++++++++++
 drivers/cxl/core/regs.c                       |  62 +-
 drivers/cxl/cxl.h                             |  85 ++-
 drivers/cxl/cxlmem.h                          |   8 +-
 drivers/cxl/mem.c                             | 162 +++++
 drivers/cxl/pci.c                             |  69 +-
 drivers/cxl/pci.h                             |  48 +-
 drivers/cxl/port.c                            | 491 ++++++++++++++
 drivers/cxl/region.c                          | 629 ++++++++++++++++++
 drivers/cxl/region.h                          |  57 ++
 drivers/cxl/trace.h                           |  75 +++
 tools/testing/cxl/Kbuild                      |   2 +
 tools/testing/cxl/mock_acpi.c                 |   4 +-
 tools/testing/cxl/test/mem.c                  |   3 +-
 25 files changed, 2806 insertions(+), 151 deletions(-)
 create mode 100644 drivers/cxl/core/pci.c
 create mode 100644 drivers/cxl/core/region.c
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/port.c
 create mode 100644 drivers/cxl/region.c
 create mode 100644 drivers/cxl/region.h
 create mode 100644 drivers/cxl/trace.h
