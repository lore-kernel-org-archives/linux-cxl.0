Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B17C43334
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Jun 2022 10:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiFGKbv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiFGKbt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Jun 2022 06:31:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442C7E5284
        for <linux-cxl@vger.kernel.org>; Tue,  7 Jun 2022 03:31:47 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LHRP25Cd9z6879r;
        Tue,  7 Jun 2022 18:27:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 12:31:44 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 7 Jun
 2022 11:31:43 +0100
Date:   Tue, 7 Jun 2022 11:31:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 0/8] hw/cxl: Move CXL emulation options and state to
 machines.
Message-ID: <20220607113139.000038e9@Huawei.com>
In-Reply-To: <20220606173338.g2cligo2t5pugh7l@bwidawsk-mobl5>
References: <20220601164235.2117-1-Jonathan.Cameron@huawei.com>
        <20220606173338.g2cligo2t5pugh7l@bwidawsk-mobl5>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 6 Jun 2022 10:33:38 -0700
Ben Widawsky <bwidawsk@kernel.org> wrote:

> On 22-06-01 17:42:27, Jonathan Cameron wrote:
> > Changes since v1 (thanks to Paolo Bonzini)
> > * Update 'description' of cxl-fmw as suggested to mention it's an array.
> > * Add a wrapper cxl_hook_up_pxb_registers() to cxl-host.c as it'll be common
> >   for all machines using CXL with PXB.
> > 
> > Run through the CI at:
> > https://gitlab.com/jic23/qemu/-/pipelines/553257456
> >  
> > V1 Cover letter:
> > 
> > Currently only machine with CXL support upstream is i386/pc but arm/virt
> > patches have been posted and once this is merged an updated series will
> > follow. Switch support is queued behind this as well because they both
> > include documentation updates.
> > 
> > Paolo Bonzini highlighted a couple of issues with the current CXL
> > emulation code.
> > 
> > * Top level parameter rather than machine for fixed memory windows
> > 
> >   The --cxl-fixed-memory-window top level command line parameters won't play
> >   well with efforts to make it possible to instantiate entire machines via
> >   RPC. Better to move these to be machine configuration.  This change is
> >   relatively straight forward, but does result in very long command lines
> >   (cannot break fixed window setup into multiple -M entries).
> > 
> > * Move all CXL stuff to machine specific code and helpers
> > 
> >   To simplify the various interactions between machine setup and host
> >   bridges etc, currently various CXL steps are called from the generic
> >   core/machine.c and softmmu/vl.c + there are CXL elements in MachineState.
> > 
> >   Much of this is straight forward to do with one exception:
> >   The CXL pci_expander_bridge host bridges require MMIO register space.
> >   This series does this by walking the bus and filling the register space
> >   in via the machine_done callback. This is similar to the walk done for
> >   identifying host bridges in the ACPI building code but it is rather ugly
> >   and postpones rejection of PXB_CXL instances where cxl=off (default).
> > 
> > All comments welcome, but the first patch at least changes the command-line
> > so to avoid have to add backwards compatibility code, it would be great
> > to merge that before 7.1 is released.
> >   
> 
> LGTM overall. I'm not thrilled with introducing another [sub]scronym "fmw", but
> otherwise, no complaints.

Agreed, it's a less than ideal compromise :( 

Spelling it out now seems too long as it has to be repeated a lot in a given commandline.
I think cfmw is too vague for a QEMU parameter and for CXL only the ACPI "structure"
(hence the s) has defined acronym of CFMWS.  The underlying actual routing hardware
is impdef so never given an acronym (there is only one direct reference to the
window itself in the CXL spec and that's spelled out as "fixed-memory window").

Jonathan



> Series is:
> Reviewed-by: Ben Widawsky <ben@bwidawsk.net>
> 
> > Thanks,
> > 
> > Jonathan
> > 
> > Jonathan Cameron (8):
> >   hw/cxl: Make the CXL fixed memory window setup a machine parameter.
> >   hw/acpi/cxl: Pass in the CXLState directly rather than MachineState
> >   hw/cxl: Push linking of CXL targets into i386/pc rather than in
> >     machine.c
> >   tests/acpi: Allow modification of q35 CXL CEDT table.
> >   pci/pci_expander_bridge: For CXL HB delay the HB register memory
> >     region setup.
> >   tests/acpi: Update q35/CEDT.cxl for new memory addresses.
> >   hw/cxl: Move the CXLState from MachineState to machine type specific
> >     state.
> >   hw/machine: Drop cxl_supported flag as no longer useful
> > 
> >  docs/system/devices/cxl.rst                 |   4 +-
> >  hw/acpi/cxl.c                               |   9 +-
> >  hw/core/machine.c                           |  28 ------
> >  hw/cxl/cxl-host-stubs.c                     |   9 +-
> >  hw/cxl/cxl-host.c                           | 100 ++++++++++++++++++--
> >  hw/i386/acpi-build.c                        |   8 +-
> >  hw/i386/pc.c                                |  31 +++---
> >  hw/pci-bridge/meson.build                   |   5 +-
> >  hw/pci-bridge/pci_expander_bridge.c         |  32 ++++---
> >  hw/pci-bridge/pci_expander_bridge_stubs.c   |  14 +++
> >  include/hw/acpi/cxl.h                       |   5 +-
> >  include/hw/boards.h                         |   3 +-
> >  include/hw/cxl/cxl.h                        |   9 +-
> >  include/hw/cxl/cxl_host.h                   |  23 +++++
> >  include/hw/i386/pc.h                        |   2 +
> >  include/hw/pci-bridge/pci_expander_bridge.h |  12 +++
> >  qapi/machine.json                           |  13 +++
> >  softmmu/vl.c                                |  46 ---------
> >  tests/data/acpi/q35/CEDT.cxl                | Bin 184 -> 184 bytes
> >  tests/qtest/bios-tables-test.c              |   4 +-
> >  tests/qtest/cxl-test.c                      |   4 +-
> >  21 files changed, 222 insertions(+), 139 deletions(-)
> >  create mode 100644 hw/pci-bridge/pci_expander_bridge_stubs.c
> >  create mode 100644 include/hw/cxl/cxl_host.h
> >  create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h
> > 
> > -- 
> > 2.32.0
> >   
> 

