Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE5AC433F5
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Mar 2022 21:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiCFVeo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Mar 2022 16:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiCFVen (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Mar 2022 16:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DF9F4993F
        for <linux-cxl@vger.kernel.org>; Sun,  6 Mar 2022 13:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646602428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/o81uUaCvw4ifhbd7Vct+tArVyBGx1vp86TpIm4MSfU=;
        b=bLWjdY6tSpBScAzf0pZe8NsRaKnTFgBpdbg035YbcTq7X9cUojiDqtBeOhnz7n1bwc7MSe
        zE7SrNg+lVsrBSRjSaPuc4CR13AYWYE6eyV5YI2bx98rjRVPVocIzwK4m20D99REQlP+Lv
        tedDO5071x7tOnk9DakBPm4Pg9BZSAI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-zV_pTs2gN0-KAIc_WabJDA-1; Sun, 06 Mar 2022 16:33:47 -0500
X-MC-Unique: zV_pTs2gN0-KAIc_WabJDA-1
Received: by mail-ed1-f71.google.com with SMTP id cm27-20020a0564020c9b00b004137effc24bso7392682edb.10
        for <linux-cxl@vger.kernel.org>; Sun, 06 Mar 2022 13:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/o81uUaCvw4ifhbd7Vct+tArVyBGx1vp86TpIm4MSfU=;
        b=XTI9Ldb0VwT3Mn8G4WUnxytQNZF3yhtPFvYdGqnW9fN8bL0Do5EVJYCe+grgV3g3Kb
         vd3rJhZZ7JRC9RkhdxPc2wzdGDLibTNcrVcme6MVa8s+peHUxT/lStaE7YsWCA7Ys2Dj
         IUtQr/PkxIeXP+L2zgg4MrUhmQLtIpXZHteNPB7hPdImwYd8JhHhWYOsTSFAoNW5bl4k
         yCYLF/II7wZYz/BBYsQ0l7Xb6RfvZq68nFBE331dPeThY2AcPPCaXNR0sam+zE1kgu8q
         ju5QkIx3A/d/+EU4KwC3AIdpCugunWVL9up34OZNZWLEBsR/RUONNyQes0wdn0ptzvbh
         BfEQ==
X-Gm-Message-State: AOAM532zEkrCJ9Bo2dsXVL430Jw3JFuB2acoz/MRJFJcAaW4+ZOIN9of
        xeBm47SuRe2osLhsUSZuuYIiw150LfEhPhTK2WjcdqRTSoR50XrNnpgwYMoNa3qKaXs8+XPC6E4
        gG7TfFcB8/nR5F1iMt1f/
X-Received: by 2002:a17:906:c107:b0:6da:bd9c:4779 with SMTP id do7-20020a170906c10700b006dabd9c4779mr6830262ejc.715.1646602426061;
        Sun, 06 Mar 2022 13:33:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOeOaZKMs1apMKZUs2VJ/IIPyR2lmsIsQPDwFH/hfzGHrtT985whPaHHKHANBU1EBYFdMNqA==
X-Received: by 2002:a17:906:c107:b0:6da:bd9c:4779 with SMTP id do7-20020a170906c10700b006dabd9c4779mr6830238ejc.715.1646602425707;
        Sun, 06 Mar 2022 13:33:45 -0800 (PST)
Received: from redhat.com ([2.55.138.228])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402268f00b00416474fbb42sm648666edd.19.2022.03.06.13.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 13:33:45 -0800 (PST)
Date:   Sun, 6 Mar 2022 16:33:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linuxarm@huawei.com, qemu-devel@nongnu.org,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 00/46] CXl 2.0 emulation Support
Message-ID: <20220306163119-mutt-send-email-mst@kernel.org>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Mar 06, 2022 at 05:40:51PM +0000, Jonathan Cameron wrote:
> Ideally I'd love it if we could start picking up the earlier
> sections of this series as I think those have been reasonably
> well reviewed and should not be particularly controversial.
> (perhaps up to patch 15 inline with what Michael Tsirkin suggested
> on v5).

Well true but given we are entering freeze this will leave
us with a half baked devices which cant be used.
At this point if we can't merge it up to documentation then
I think we should wait until after the release.

> There is one core memory handling related patch (34) marked as RFC.
> Whilst it's impact seems small to me, I'm not sure it is the best way
> to meet our requirements wrt interleaving.
> 
> Changes since v7:
> 
> Thanks to all who have taken a look.
> Small amount of reordering was necessary due to LSA fix in patch 17.
> Test moved forwards to patch 22 and so all intermediate patches
> move -1 in the series.
> 
> (New stuff)
> - Switch support.  Needed to support more interesting topologies.
> (Ben Widawsky)
> - Patch 17: Fix reversed condition on presence of LSA that meant these never
>   got properly initialized. Related change needed to ensure test for cxl_type3
>   always needs an LSA. We can relax this later when adding volatile memory
>   support.
> (Markus Armbuster)
> - Patch 27: Change -cxl-fixed-memory-window option handling to use
>   qobject_input_visitor_new_str().  This changed the required handling of
>   targets parameter to require an array index and hence test and docs updates.
>   e.g. targets.1=cxl_hb0,targets.2=cxl_hb1
>   (Patches 38,40,42,43)
> - Missing structure element docs and version number (optimisitic :)
> (Alex Bennée)
> - Added Reviewed-by tags.  Thanks!.
> - Series wise: Switch to compiler.h QEMU_BUILD_BUG_ON/MSG QEMU_PACKED
>   and QEMU_ALIGNED as Alex suggested in patch 20.
> - Patch 6: Dropped documentation for a non-existent lock.
>            Added error code suitable for unimplemented commands.
> 	   Reordered code for better readability.
> - Patch 9: Reorder as suggested to avoid a goto.
> - Patch 16: Add LOG_UNIMP message where feature not yet implemented.
>             Drop "Explain" comment that doesn't explain anything.
> - Patch 18: Drop pointless void * cast.
>             Add assertion as suggested (without divide)
> - Patch 19: Use pstrcpy rather than snprintf for a fixed string.
>             The compiler.h comment was in this patch but affects a
> 	    number of other patches as well.
> - Patch 20: Move structure CXLType3Dev to header when originally
>             introduced so changes are more obvious in this patch.
> - Patch 21: Substantial refactor to resolve unclear use of sizeof
>             on the LSA command header. Now uses a variable length
> 	    last element so we can use offsetof()
> - Patch 22: Use g_autoptr() to avoid need for explicit free in tests
>   	    Similar in later patches.
> - Patch 29: Minor reorganziation as suggested.
> 	    
> (Tidy up from me)
> - Trivial stuff like moving header includes to patch where first used.
> - Patch 17: Drop ifndef protections from TYPE_CXL_TYPE3_DEV as there
>             doesn't seem to be a reason.
> 
> Series organized to allow it to be taken in stages if the maintainers
> prefer that approach. Most sets end with the addition of appropriate
> tests (TBD for final set)
> 
> Patches 0-15 - CXL PXB
> Patches 16-22 - Type 3 Device, Root Port
> Patches 23-40 - ACPI, board elements and interleave decoding to enable x86 hosts
> Patches 41-42 - arm64 support on virt.
> Patch 43 - Initial documentation
> Patches 44-46 - Switch support.
> 
> Gitlab CI is proving challenging to get a completely clean bill of health
> as there seem to be some intermittent failures in common with the
> main QEMU gitlab. In particular an ASAN leak error that appears in some
> upstream CI runs and build-oss-fuzz timeouts.
> Results at http://gitlab.com/jic23/qemu cxl-v7-draft-2-for-test
> which also includes the DOE/CDAT patches serial number support which
> will form part of a future series.
> 
> Updated background info:
> 
> Looking in particular for:
> * Review of the PCI interactions
> * x86 and ARM machine interactions (particularly the memory maps)
> * Review of the interleaving approach - is the basic idea
>   acceptable?
> * Review of the command line interface.
> * CXL related review welcome but much of that got reviewed
>   in earlier versions and hasn't changed substantially.
> 
> Big TODOs:
> 
> * Volatile memory devices (easy but it's more code so left for now).
> * Hotplug?  May not need much but it's not tested yet!
> * More tests and tighter verification that values written to hardware
>   are actually valid - stuff that real hardware would check.
> * Testing, testing and more testing.  I have been running a basic
>   set of ARM and x86 tests on this, but there is always room for
>   more tests and greater automation.
> * CFMWS flags as requested by Ben.
> 
> Why do we want QEMU emulation of CXL?
> 
> As Ben stated in V3, QEMU support has been critical to getting OS
> software written given lack of availability of hardware supporting the
> latest CXL features (coupled with very high demand for support being
> ready in a timely fashion). What has become clear since Ben's v3
> is that situation is a continuous one. Whilst we can't talk about
> them yet, CXL 3.0 features and OS support have been prototyped on
> top of this support and a lot of the ongoing kernel work is being
> tested against these patches. The kernel CXL mocking code allows
> some forms of testing, but QEMU provides a more versatile and
> exensible platform.
> 
> Other features on the qemu-list that build on these include PCI-DOE
> /CDAT support from the Avery Design team further showing how this
> code is useful. Whilst not directly related this is also the test
> platform for work on PCI IDE/CMA + related DMTF SPDM as CXL both
> utilizes and extends those technologies and is likely to be an early
> adopter.
> Refs:
> CMA Kernel: https://lore.kernel.org/all/20210804161839.3492053-1-Jonathan.Cameron@huawei.com/
> CMA Qemu: https://lore.kernel.org/qemu-devel/1624665723-5169-1-git-send-email-cbrowy@avery-design.com/
> DOE Qemu: https://lore.kernel.org/qemu-devel/1623329999-15662-1-git-send-email-cbrowy@avery-design.com/
> 
> As can be seen there is non trivial interaction with other areas of
> Qemu, particularly PCI and keeping this set up to date is proving
> a burden we'd rather do without :)
> 
> Ben mentioned a few other good reasons in v3:
> https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
> 
> What we have here is about what you need for it to be useful for testing
> currently kernel code.  Note the kernel code is moving fast so
> since v4, some features have been introduced we don't yet support in
> QEMU (e.g. use of the PCIe serial number extended capability).
> 
> All comments welcome.
> 
> Additional info that was here in v5 is now in the documentation patch.
> 
> Thanks,
> 
> Jonathan
> 
> Ben Widawsky (24):
>   hw/pci/cxl: Add a CXL component type (interface)
>   hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)
>   hw/cxl/device: Introduce a CXL device (8.2.8)
>   hw/cxl/device: Implement the CAP array (8.2.8.1-2)
>   hw/cxl/device: Implement basic mailbox (8.2.8.4)
>   hw/cxl/device: Add memory device utilities
>   hw/cxl/device: Add cheap EVENTS implementation (8.2.9.1)
>   hw/cxl/device: Timestamp implementation (8.2.9.3)
>   hw/cxl/device: Add log commands (8.2.9.4) + CEL
>   hw/pxb: Use a type for realizing expanders
>   hw/pci/cxl: Create a CXL bus type
>   hw/pxb: Allow creation of a CXL PXB (host bridge)
>   hw/cxl/rp: Add a root port
>   hw/cxl/device: Add a memory device (8.2.8.5)
>   hw/cxl/device: Implement MMIO HDM decoding (8.2.5.12)
>   hw/cxl/device: Add some trivial commands
>   hw/cxl/device: Plumb real Label Storage Area (LSA) sizing
>   hw/cxl/device: Implement get/set Label Storage Area (LSA)
>   hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142)
>   acpi/cxl: Add _OSC implementation (9.14.2)
>   acpi/cxl: Create the CEDT (9.14.1)
>   acpi/cxl: Introduce CFMWS structures in CEDT
>   hw/cxl/component Add a dumb HDM decoder handler
>   qtest/cxl: Add more complex test cases with CFMWs
> 
> Jonathan Cameron (22):
>   MAINTAINERS: Add entry for Compute Express Link Emulation
>   cxl: Machine level control on whether CXL support is enabled
>   qtest/cxl: Introduce initial test for pxb-cxl only.
>   qtests/cxl: Add initial root port and CXL type3 tests
>   hw/cxl/component: Add utils for interleave parameter encoding/decoding
>   hw/cxl/host: Add support for CXL Fixed Memory Windows.
>   hw/pci-host/gpex-acpi: Add support for dsdt construction for pxb-cxl
>   pci/pcie_port: Add pci_find_port_by_pn()
>   CXL/cxl_component: Add cxl_get_hb_cstate()
>   mem/cxl_type3: Add read and write functions for associated hostmem.
>   cxl/cxl-host: Add memops for CFMWS region.
>   RFC: softmmu/memory: Add ops to memory_region_ram_init_from_file
>   i386/pc: Enable CXL fixed memory windows
>   tests/acpi: q35: Allow addition of a CXL test.
>   qtests/bios-tables-test: Add a test for CXL emulation.
>   tests/acpi: Add tables for CXL emulation.
>   hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
>     pxb-cxl
>   qtest/cxl: Add aarch64 virt test for CXL
>   docs/cxl: Add initial Compute eXpress Link (CXL) documentation.
>   pci-bridge/cxl_upstream: Add a CXL switch upstream port
>   pci-bridge/cxl_downstream: Add a CXL switch downstream port
>   cxl/cxl-host: Support interleave decoding with one level of switches.
> 
>  MAINTAINERS                         |   7 +
>  docs/system/device-emulation.rst    |   1 +
>  docs/system/devices/cxl.rst         | 302 +++++++++++++++++
>  hw/Kconfig                          |   1 +
>  hw/acpi/Kconfig                     |   5 +
>  hw/acpi/cxl-stub.c                  |  12 +
>  hw/acpi/cxl.c                       | 231 +++++++++++++
>  hw/acpi/meson.build                 |   4 +-
>  hw/arm/Kconfig                      |   1 +
>  hw/arm/virt-acpi-build.c            |  33 ++
>  hw/arm/virt.c                       |  40 ++-
>  hw/core/machine.c                   |  28 ++
>  hw/cxl/Kconfig                      |   3 +
>  hw/cxl/cxl-component-utils.c        | 284 ++++++++++++++++
>  hw/cxl/cxl-device-utils.c           | 265 +++++++++++++++
>  hw/cxl/cxl-host-stubs.c             |  16 +
>  hw/cxl/cxl-host.c                   | 262 +++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c          | 485 ++++++++++++++++++++++++++++
>  hw/cxl/meson.build                  |  12 +
>  hw/i386/acpi-build.c                |  57 +++-
>  hw/i386/pc.c                        |  57 +++-
>  hw/mem/Kconfig                      |   5 +
>  hw/mem/cxl_type3.c                  | 352 ++++++++++++++++++++
>  hw/mem/meson.build                  |   1 +
>  hw/meson.build                      |   1 +
>  hw/pci-bridge/Kconfig               |   5 +
>  hw/pci-bridge/cxl_downstream.c      | 229 +++++++++++++
>  hw/pci-bridge/cxl_root_port.c       | 231 +++++++++++++
>  hw/pci-bridge/cxl_upstream.c        | 206 ++++++++++++
>  hw/pci-bridge/meson.build           |   1 +
>  hw/pci-bridge/pci_expander_bridge.c | 172 +++++++++-
>  hw/pci-bridge/pcie_root_port.c      |   6 +-
>  hw/pci-host/gpex-acpi.c             |  20 +-
>  hw/pci/pci.c                        |  21 +-
>  hw/pci/pcie_port.c                  |  25 ++
>  include/hw/acpi/cxl.h               |  28 ++
>  include/hw/arm/virt.h               |   1 +
>  include/hw/boards.h                 |   2 +
>  include/hw/cxl/cxl.h                |  54 ++++
>  include/hw/cxl/cxl_component.h      | 207 ++++++++++++
>  include/hw/cxl/cxl_device.h         | 270 ++++++++++++++++
>  include/hw/cxl/cxl_pci.h            | 156 +++++++++
>  include/hw/pci/pci.h                |  14 +
>  include/hw/pci/pci_bridge.h         |  20 ++
>  include/hw/pci/pci_bus.h            |   7 +
>  include/hw/pci/pci_ids.h            |   1 +
>  include/hw/pci/pcie_port.h          |   2 +
>  qapi/machine.json                   |  18 ++
>  qemu-options.hx                     |  38 +++
>  scripts/device-crash-test           |   1 +
>  softmmu/memory.c                    |   9 +
>  softmmu/vl.c                        |  42 +++
>  tests/data/acpi/q35/CEDT.cxl        | Bin 0 -> 184 bytes
>  tests/data/acpi/q35/DSDT.cxl        | Bin 0 -> 9627 bytes
>  tests/qtest/bios-tables-test.c      |  44 +++
>  tests/qtest/cxl-test.c              | 181 +++++++++++
>  tests/qtest/meson.build             |   5 +
>  57 files changed, 4456 insertions(+), 25 deletions(-)
>  create mode 100644 docs/system/devices/cxl.rst
>  create mode 100644 hw/acpi/cxl-stub.c
>  create mode 100644 hw/acpi/cxl.c
>  create mode 100644 hw/cxl/Kconfig
>  create mode 100644 hw/cxl/cxl-component-utils.c
>  create mode 100644 hw/cxl/cxl-device-utils.c
>  create mode 100644 hw/cxl/cxl-host-stubs.c
>  create mode 100644 hw/cxl/cxl-host.c
>  create mode 100644 hw/cxl/cxl-mailbox-utils.c
>  create mode 100644 hw/cxl/meson.build
>  create mode 100644 hw/mem/cxl_type3.c
>  create mode 100644 hw/pci-bridge/cxl_downstream.c
>  create mode 100644 hw/pci-bridge/cxl_root_port.c
>  create mode 100644 hw/pci-bridge/cxl_upstream.c
>  create mode 100644 include/hw/acpi/cxl.h
>  create mode 100644 include/hw/cxl/cxl.h
>  create mode 100644 include/hw/cxl/cxl_component.h
>  create mode 100644 include/hw/cxl/cxl_device.h
>  create mode 100644 include/hw/cxl/cxl_pci.h
>  create mode 100644 tests/data/acpi/q35/CEDT.cxl
>  create mode 100644 tests/data/acpi/q35/DSDT.cxl
>  create mode 100644 tests/qtest/cxl-test.c
> 
> -- 
> 2.32.0

