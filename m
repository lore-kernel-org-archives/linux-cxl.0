Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17428C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 13 May 2022 10:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379304AbiEMKQg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 May 2022 06:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379055AbiEMKQg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 May 2022 06:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 495F420F79
        for <linux-cxl@vger.kernel.org>; Fri, 13 May 2022 03:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652436993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EDLIGqUvxLscF18BRA5NT4AupZcRH/HNS3C6KO6Fhpo=;
        b=IPZOBreuR4KiZR+6RAnL5ZMuwsCVHn1994MpEb3p6c7O/mGlOMcfgvZGayo/jrpSmw06Bg
        P1Poi1p7vn5VjvWFdJKl2r2/j2dZWlp8NziN+cOgdtDnREgXMGp3iEjdakaTb1Hma5hyCk
        ruq1JZ16Y/qg1pwQPq7cTlYBwa4IvYY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-TAcCMV20POCbQZJqJoLsNg-1; Fri, 13 May 2022 06:16:32 -0400
X-MC-Unique: TAcCMV20POCbQZJqJoLsNg-1
Received: by mail-wm1-f71.google.com with SMTP id k35-20020a05600c1ca300b003946a9764baso5766121wms.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 May 2022 03:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDLIGqUvxLscF18BRA5NT4AupZcRH/HNS3C6KO6Fhpo=;
        b=EL8IgctWIyu763m9wgezmXqb/1qUUK2yyMlDuKPSqLuFYhTG5G+qsQi377TrviKrSy
         EB+Bp4SfV3kYMXhzU9LFS909/f8Zj33n3+tXnXbbZaKRJv8qgskzghcnQUgvksafr//L
         RCk+v8B17UutCa/GvLReasKvnGYm5Ka9YC84eNgdW77kIkbEPSwYoOF6kU9zjyGta1Mm
         10Zw1TZWDiErkWCOkr9qq7yh2xXOYLDxi42eDPcrMt6P57dLfxsQy8na6lD6p2mt3pRi
         qbRoN62bEr0+sR/kFfJQMa4FG1gD0GyJDlW1wB2vxQb3aNfuSWDAx1gRQv2OT/8gHDoK
         LUFQ==
X-Gm-Message-State: AOAM5319tYjIVckGI8W9G0YehZKyP9WuX6e7DAu+57DwzlWuhVMTkVox
        hWC9gtvCr15U20TkF6KwrubHxs1fGYLW09tK73kEGhn25jr2U8HZIEzt9ju17TNXA7ztsqjbov2
        KMg1Bgzo4Ex4silwlDw6f
X-Received: by 2002:a5d:6d0a:0:b0:20c:b640:45b8 with SMTP id e10-20020a5d6d0a000000b0020cb64045b8mr3250535wrq.708.1652436990847;
        Fri, 13 May 2022 03:16:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP1F7OFay75NlzsOQMUbeSKQbDk4RnfnqDVRhqVzt9tyFJZWPWggKikZcpMhNCqptf1Q122w==
X-Received: by 2002:a5d:6d0a:0:b0:20c:b640:45b8 with SMTP id e10-20020a5d6d0a000000b0020cb64045b8mr3250499wrq.708.1652436990472;
        Fri, 13 May 2022 03:16:30 -0700 (PDT)
Received: from redhat.com ([2.53.15.195])
        by smtp.gmail.com with ESMTPSA id z18-20020a7bc152000000b003958af7d0c8sm1884129wmi.45.2022.05.13.03.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 03:16:29 -0700 (PDT)
Date:   Fri, 13 May 2022 06:16:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linuxarm@huawei.com, qemu-devel@nongnu.org, alex.bennee@linaro.org,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, f4bug@amsat.org,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>, k.jensen@samsung.com,
        dave@stgolabs.net, Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v10 00/45] CXl 2.0 emulation Support
Message-ID: <20220513053724-mutt-send-email-mst@kernel.org>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 29, 2022 at 03:40:25PM +0100, Jonathan Cameron wrote:
> Note that due to a bug in the kernel handling of Mem_Enable
> in the CXL Device DVSEC a fix is needed to sucessfully use these
> patches with Linux.
> https://lore.kernel.org/linux-cxl/CAPcyv4gFWw9s6r9kUoL-_P9qnaZSJBMz+EcmfY+0g1NHrJQx7Q@mail.gmail.com/T/#t
> 
> Note the issue was detected using this emulation.
> 
> Changes since v9:
> 
> Thanks to Tong Zhang and Markus Armbruster for review of v9.
> - Fixed return of all 1s on HDM decoder not matching.
> - Off by one error in an assert for register writes.
> - Write masks for both PCI config space structures and
>   registers in MMIO space. These were partly queued up
>   for a future patch set, but after review comment from
>   Tong, I decided it was best to put these in place from
>   the start.  Note I was a bit undecided on whether to drop
>   review tags for this (it's quit a bit of code, but very
>   simple).  Alex, and Adam if you want to take another look
>   at patch 2 in particular that would be great. 
> - Tag from Markus added.
> - Fix for wrong setting of Mem_Enable as described in the
>   thread linked above.
> 
> The series can be applied in parts if that makes sense:
> 
> Possible partial sets:
> 1-15 (end with the test of the pxb-cxl host bridge)
> 16-22 (end with the test for root port and type3 device)
> 23-39 (end with tests on x86 pc for CFMWS including BIOS table updates)
> 40-41 (arm64 virt support + simple test case)
> 42 (documentation - we could pull this forwards to before the arm support)
> 43-45 (switch support)

OK, I picked up 1-39 and 42. Let's see how it goes, then arm
people can apply the arm bits.
I did my best with review but my knowledge is limited.

> gitlab tree at gitlab.com/jic23/qemu cxl-v10-draft-2
> 
> As before that tree has additional patches on top that will form
> part of future postings. This time it has SPDM support via
> a socket connection to DMTF/spdm_emu / libspdm. I'll send an RFC
> on that topic as it's a discussion that can go on in parallel.
> 
> Several people have asked about contributing additional features.
> As those come in I'll apply them on top of this series and handle
> rebases etc as necessary whilst we seek to get this first set
> of patches upstream.
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
> TODOs:
> 
> * Volatile memory devices (easy but it's more code so left for now).
> * Hotplug?  May not need much but it's not tested yet!
> * More tests and tighter verification that values written to hardware
>   are actually valid - stuff that real hardware would check.
> * Testing, testing and more testing.  I have been running a basic
>   set of ARM and x86 tests on this, but there is always room for
>   more tests and greater automation.
> * CFMWS flags as requested by Ben.
> * Parititioning support - ability to change the balance of volatile
>   and non volatile memory on demand.
> * Trace points as suggested my Mark to help with debugging memory
>   interleaving setup.
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
> extensible platform.
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
> Jonathan Cameron (21):
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
>   docs/cxl: Add switch documentation
> 
>  MAINTAINERS                         |   7 +
>  docs/system/device-emulation.rst    |   1 +
>  docs/system/devices/cxl.rst         | 386 ++++++++++++++++++++++
>  hw/Kconfig                          |   1 +
>  hw/acpi/Kconfig                     |   5 +
>  hw/acpi/cxl-stub.c                  |  12 +
>  hw/acpi/cxl.c                       | 257 +++++++++++++++
>  hw/acpi/meson.build                 |   4 +-
>  hw/arm/Kconfig                      |   1 +
>  hw/arm/virt-acpi-build.c            |  33 ++
>  hw/arm/virt.c                       |  40 ++-
>  hw/core/machine.c                   |  28 ++
>  hw/cxl/Kconfig                      |   3 +
>  hw/cxl/cxl-component-utils.c        | 396 +++++++++++++++++++++++
>  hw/cxl/cxl-device-utils.c           | 265 +++++++++++++++
>  hw/cxl/cxl-host-stubs.c             |  16 +
>  hw/cxl/cxl-host.c                   | 261 +++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c          | 478 ++++++++++++++++++++++++++++
>  hw/cxl/meson.build                  |  12 +
>  hw/i386/acpi-build.c                |  57 +++-
>  hw/i386/pc.c                        |  57 +++-
>  hw/mem/Kconfig                      |   5 +
>  hw/mem/cxl_type3.c                  | 371 +++++++++++++++++++++
>  hw/mem/meson.build                  |   1 +
>  hw/meson.build                      |   1 +
>  hw/pci-bridge/Kconfig               |   5 +
>  hw/pci-bridge/cxl_downstream.c      | 249 +++++++++++++++
>  hw/pci-bridge/cxl_root_port.c       | 236 ++++++++++++++
>  hw/pci-bridge/cxl_upstream.c        | 216 +++++++++++++
>  hw/pci-bridge/meson.build           |   1 +
>  hw/pci-bridge/pci_expander_bridge.c | 168 +++++++++-
>  hw/pci-bridge/pcie_root_port.c      |   6 +-
>  hw/pci-host/gpex-acpi.c             |  20 +-
>  hw/pci/pci.c                        |  21 +-
>  hw/pci/pcie_port.c                  |  25 ++
>  include/hw/acpi/cxl.h               |  28 ++
>  include/hw/arm/virt.h               |   1 +
>  include/hw/boards.h                 |   2 +
>  include/hw/cxl/cxl.h                |  65 ++++
>  include/hw/cxl/cxl_component.h      | 223 +++++++++++++
>  include/hw/cxl/cxl_device.h         | 268 ++++++++++++++++
>  include/hw/cxl/cxl_pci.h            | 167 ++++++++++
>  include/hw/pci/pci.h                |  14 +
>  include/hw/pci/pci_bridge.h         |  20 ++
>  include/hw/pci/pci_bus.h            |   7 +
>  include/hw/pci/pci_ids.h            |   1 +
>  include/hw/pci/pcie_port.h          |   2 +
>  qapi/machine.json                   |  21 ++
>  qemu-options.hx                     |  38 +++
>  scripts/device-crash-test           |   1 +
>  softmmu/vl.c                        |  47 +++
>  tests/data/acpi/q35/CEDT.cxl        | Bin 0 -> 184 bytes
>  tests/data/acpi/q35/DSDT.cxl        | Bin 0 -> 9615 bytes
>  tests/qtest/bios-tables-test.c      |  44 +++
>  tests/qtest/cxl-test.c              | 181 +++++++++++
>  tests/qtest/meson.build             |   5 +
>  56 files changed, 4753 insertions(+), 27 deletions(-)
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

