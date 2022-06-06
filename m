Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CF0C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Jun 2022 17:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiFFRdn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFFRdm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Jun 2022 13:33:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7661B1CD0
        for <linux-cxl@vger.kernel.org>; Mon,  6 Jun 2022 10:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6295611F9
        for <linux-cxl@vger.kernel.org>; Mon,  6 Jun 2022 17:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A23C385A9;
        Mon,  6 Jun 2022 17:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654536820;
        bh=c7sTXPMA2eAWH6wjM1wkQAqaH6pZtjiRkXPAQ5EavlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfLL9+WVyWAx8yJgG15jxIZwEa/xMZ0ehpeKJEnLVTszFc+mwQYx/P7j8O1JU6nLI
         oLvYdhRATC2ADMcp0tHucVms/Bw6TswAQcXFiNGj26fG36FrRG5T1Vv0X5rN6/k+Be
         NmnKC6Jw9ojamzxV8/l2ks0V894CtybweLh4y/0wvqk5g7jlMfJiEj09xwXccUw2dd
         OOdi74YKcQ7hG/leNb2BGwzy2wBSOMeTSHm4Q7P/j/SXlPpOgl6urn8LzlpvTgVcHa
         P9JKduVDxhtC/PK4L/qbqjbNoSfCF8HFUH4jSuT+wcgnhI+TUdej1Iz3HvEOve/doP
         sK0CUvmNS3F9g==
Date:   Mon, 6 Jun 2022 10:33:38 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
        "Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, alex.bennee@linaro.org,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 0/8] hw/cxl: Move CXL emulation options and state to
 machines.
Message-ID: <20220606173338.g2cligo2t5pugh7l@bwidawsk-mobl5>
References: <20220601164235.2117-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601164235.2117-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-06-01 17:42:27, Jonathan Cameron wrote:
> Changes since v1 (thanks to Paolo Bonzini)
> * Update 'description' of cxl-fmw as suggested to mention it's an array.
> * Add a wrapper cxl_hook_up_pxb_registers() to cxl-host.c as it'll be common
>   for all machines using CXL with PXB.
> 
> Run through the CI at:
> https://gitlab.com/jic23/qemu/-/pipelines/553257456
>  
> V1 Cover letter:
> 
> Currently only machine with CXL support upstream is i386/pc but arm/virt
> patches have been posted and once this is merged an updated series will
> follow. Switch support is queued behind this as well because they both
> include documentation updates.
> 
> Paolo Bonzini highlighted a couple of issues with the current CXL
> emulation code.
> 
> * Top level parameter rather than machine for fixed memory windows
> 
>   The --cxl-fixed-memory-window top level command line parameters won't play
>   well with efforts to make it possible to instantiate entire machines via
>   RPC. Better to move these to be machine configuration.  This change is
>   relatively straight forward, but does result in very long command lines
>   (cannot break fixed window setup into multiple -M entries).
> 
> * Move all CXL stuff to machine specific code and helpers
> 
>   To simplify the various interactions between machine setup and host
>   bridges etc, currently various CXL steps are called from the generic
>   core/machine.c and softmmu/vl.c + there are CXL elements in MachineState.
> 
>   Much of this is straight forward to do with one exception:
>   The CXL pci_expander_bridge host bridges require MMIO register space.
>   This series does this by walking the bus and filling the register space
>   in via the machine_done callback. This is similar to the walk done for
>   identifying host bridges in the ACPI building code but it is rather ugly
>   and postpones rejection of PXB_CXL instances where cxl=off (default).
> 
> All comments welcome, but the first patch at least changes the command-line
> so to avoid have to add backwards compatibility code, it would be great
> to merge that before 7.1 is released.
> 

LGTM overall. I'm not thrilled with introducing another [sub]scronym "fmw", but
otherwise, no complaints.
Series is:
Reviewed-by: Ben Widawsky <ben@bwidawsk.net>

> Thanks,
> 
> Jonathan
> 
> Jonathan Cameron (8):
>   hw/cxl: Make the CXL fixed memory window setup a machine parameter.
>   hw/acpi/cxl: Pass in the CXLState directly rather than MachineState
>   hw/cxl: Push linking of CXL targets into i386/pc rather than in
>     machine.c
>   tests/acpi: Allow modification of q35 CXL CEDT table.
>   pci/pci_expander_bridge: For CXL HB delay the HB register memory
>     region setup.
>   tests/acpi: Update q35/CEDT.cxl for new memory addresses.
>   hw/cxl: Move the CXLState from MachineState to machine type specific
>     state.
>   hw/machine: Drop cxl_supported flag as no longer useful
> 
>  docs/system/devices/cxl.rst                 |   4 +-
>  hw/acpi/cxl.c                               |   9 +-
>  hw/core/machine.c                           |  28 ------
>  hw/cxl/cxl-host-stubs.c                     |   9 +-
>  hw/cxl/cxl-host.c                           | 100 ++++++++++++++++++--
>  hw/i386/acpi-build.c                        |   8 +-
>  hw/i386/pc.c                                |  31 +++---
>  hw/pci-bridge/meson.build                   |   5 +-
>  hw/pci-bridge/pci_expander_bridge.c         |  32 ++++---
>  hw/pci-bridge/pci_expander_bridge_stubs.c   |  14 +++
>  include/hw/acpi/cxl.h                       |   5 +-
>  include/hw/boards.h                         |   3 +-
>  include/hw/cxl/cxl.h                        |   9 +-
>  include/hw/cxl/cxl_host.h                   |  23 +++++
>  include/hw/i386/pc.h                        |   2 +
>  include/hw/pci-bridge/pci_expander_bridge.h |  12 +++
>  qapi/machine.json                           |  13 +++
>  softmmu/vl.c                                |  46 ---------
>  tests/data/acpi/q35/CEDT.cxl                | Bin 184 -> 184 bytes
>  tests/qtest/bios-tables-test.c              |   4 +-
>  tests/qtest/cxl-test.c                      |   4 +-
>  21 files changed, 222 insertions(+), 139 deletions(-)
>  create mode 100644 hw/pci-bridge/pci_expander_bridge_stubs.c
>  create mode 100644 include/hw/cxl/cxl_host.h
>  create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h
> 
> -- 
> 2.32.0
> 
