Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A864CC433E0
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Mar 2021 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C82C64FE0
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Mar 2021 19:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhCKTH2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:07:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2687 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKTG5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Mar 2021 14:06:57 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DxJDx0vv0z67nPW;
        Fri, 12 Mar 2021 03:00:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 11 Mar 2021 20:06:49 +0100
Received: from localhost (10.47.26.221) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 11 Mar
 2021 19:06:48 +0000
Date:   Thu, 11 Mar 2021 19:05:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <armbru@redhat.com>, <ben.widawsky@intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <f4bug@amsat.org>,
        <imammedo@redhat.com>, <ira.weiny@intel.com>, <jgroves@micron.com>,
        <mst@redhat.com>, <vishal.l.verma@intel.com>,
        <tyshao@avery-design.com.tw>, <hchkuo@avery-design.com.tw>
Subject: Re: [RFC PATCH v3 cxl-2.0-doe 1/2] Basic PCIe DOE support
Message-ID: <20210311190535.0000745c@Huawei.com>
In-Reply-To: <1615323835-17521-1-git-send-email-cbrowy@avery-design.com>
References: <1615322029-13038-1-git-send-email-cbrowy@avery-design.com>
        <1615323835-17521-1-git-send-email-cbrowy@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.26.221]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 9 Mar 2021 16:03:55 -0500
Chris Browy <cbrowy@avery-design.com> wrote:

Hi Chris, various specific comments inline but a few important ones
to watch for next version.

1) Always read the final patch you are sending out. Last minute rebases can
   result in picking up a bunch of unrelated stuff like here.
   That basically gives a grumpy maintainer a reason not to read your patch.
   If I had maintainer hat on I'd have kicked this back to you unread.

2) Please add proper descriptions for each patch - I know it's an RFC but
   it feels like it is getting there so good to get that element in shape
   as well.

3) Split the patch up. Some stuff in here will be coming in via other paths
   (headers are picked up by a script in some cases).

4) To my eye far too much debug in here for code at this level of maturity.

From actual code point of view looks pretty good to me.
Drop CMA until you have it implemented - right now it's just unwanted noise
in this patch.

Thanks,

Jonathan
  
> ---
>  MAINTAINERS                               |  49 +--
>  hw/pci/meson.build                        |   1 +
>  hw/pci/pci.c                              |  13 +-
>  hw/pci/pcie_doe.c                         | 416 ++++++++++++++++++++++
>  include/hw/pci/pci_ids.h                  |   5 +-
>  include/hw/pci/pcie.h                     |   1 +
>  include/hw/pci/pcie_doe.h                 | 142 ++++++++
>  include/hw/pci/pcie_regs.h                |   4 +
>  include/standard-headers/linux/pci_regs.h |   3 +-
>  9 files changed, 591 insertions(+), 43 deletions(-)
>  create mode 100644 hw/pci/pcie_doe.c
>  create mode 100644 include/hw/pci/pcie_doe.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f9097ed9e7..8c5a9690a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -87,7 +87,7 @@ S390 general architecture support
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Thomas Huth <thuth@redhat.com>
>  S: Supported
> -F: default-configs/*/s390x-softmmu.mak
> +F: default-configs/s390x-softmmu.mak
>  F: gdb-xml/s390*.xml
>  F: hw/char/sclp*.[hc]
>  F: hw/char/terminal3270.c
> @@ -188,15 +188,6 @@ F: include/hw/cris/
>  F: tests/tcg/cris/
>  F: disas/cris.c
>  
> -Hexagon TCG CPUs
> -M: Taylor Simpson <tsimpson@quicinc.com>
> -S: Supported
> -F: target/hexagon/
> -F: linux-user/hexagon/
> -F: tests/tcg/hexagon/
> -F: disas/hexagon.c
> -F: default-configs/targets/hexagon-linux-user.mak
> -
>  HPPA (PA-RISC) TCG CPUs
>  M: Richard Henderson <richard.henderson@linaro.org>
>  S: Maintained
> @@ -239,7 +230,7 @@ R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Odd Fixes
>  F: target/mips/
> -F: default-configs/*/*mips*
> +F: default-configs/*mips*
>  F: disas/mips.c
>  F: docs/system/cpu-models-mips.rst.inc
>  F: hw/intc/mips_gic.c
> @@ -263,7 +254,7 @@ S: Maintained
>  F: target/moxie/
>  F: disas/moxie.c
>  F: hw/moxie/
> -F: default-configs/*/moxie-softmmu.mak
> +F: default-configs/moxie-softmmu.mak
>  
>  NiosII TCG CPUs
>  M: Chris Wulff <crwulff@gmail.com>
> @@ -272,7 +263,7 @@ S: Maintained
>  F: target/nios2/
>  F: hw/nios2/
>  F: disas/nios2.c
> -F: default-configs/*/nios2-softmmu.mak
> +F: default-configs/nios2-softmmu.mak
>  
>  OpenRISC TCG CPUs
>  M: Stafford Horne <shorne@gmail.com>
> @@ -367,7 +358,7 @@ F: hw/xtensa/
>  F: tests/tcg/xtensa/
>  F: disas/xtensa.c
>  F: include/hw/xtensa/xtensa-isa.h
> -F: default-configs/*/xtensa*.mak
> +F: default-configs/xtensa*.mak
>  
>  TriCore TCG CPUs
>  M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> @@ -1038,7 +1029,7 @@ AVR MCUs
>  M: Michael Rolnik <mrolnik@gmail.com>
>  R: Sarah Harris <S.E.Harris@kent.ac.uk>
>  S: Maintained
> -F: default-configs/*/avr-softmmu.mak
> +F: default-configs/avr-softmmu.mak
>  F: hw/avr/
>  F: include/hw/char/avr_usart.h
>  F: hw/char/avr_usart.c
> @@ -1067,7 +1058,7 @@ HP B160L
>  M: Richard Henderson <richard.henderson@linaro.org>
>  R: Helge Deller <deller@gmx.de>
>  S: Odd Fixes
> -F: default-configs/*/hppa-softmmu.mak
> +F: default-configs/hppa-softmmu.mak
>  F: hw/hppa/
>  F: pc-bios/hppa-firmware.img
>  
> @@ -1183,7 +1174,6 @@ F: hw/intc/loongson_liointc.c
>  F: hw/mips/loongson3_bootp.c
>  F: hw/mips/loongson3_bootp.h
>  F: hw/mips/loongson3_virt.c
> -F: tests/acceptance/machine_mips_loongson3v.py
>  
>  Boston
>  M: Paul Burton <paulburton@kernel.org>
> @@ -1373,15 +1363,6 @@ F: include/hw/misc/mchp_pfsoc_dmc.h
>  F: include/hw/misc/mchp_pfsoc_ioscb.h
>  F: include/hw/misc/mchp_pfsoc_sysreg.h
>  
> -SiFive Machines
> -M: Alistair Francis <Alistair.Francis@wdc.com>
> -M: Bin Meng <bin.meng@windriver.com>
> -M: Palmer Dabbelt <palmer@dabbelt.com>
> -L: qemu-riscv@nongnu.org
> -S: Supported
> -F: hw/*/*sifive*.c
> -F: include/hw/*/*sifive*.h
> -
>  RX Machines
>  -----------
>  rx-gdbsim
> @@ -1468,7 +1449,7 @@ F: hw/s390x/
>  F: include/hw/s390x/
>  F: hw/watchdog/wdt_diag288.c
>  F: include/hw/watchdog/wdt_diag288.h
> -F: default-configs/*/s390x-softmmu.mak
> +F: default-configs/s390x-softmmu.mak
>  F: tests/acceptance/machine_s390_ccw_virtio.py
>  T: git https://gitlab.com/cohuck/qemu.git s390-next
>  T: git https://github.com/borntraeger/qemu.git s390-next
> @@ -1681,6 +1662,13 @@ F: docs/pci*
>  F: docs/specs/*pci*
>  F: default-configs/pci.mak
>  
> +PCIE DOE
> +M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> +M: Chris Browy <cbrowy@avery-design.com>
> +S: Supported
> +F: include/hw/pci/pcie_doe.h
> +F: hw/pci/pcie_doe.c
> +
>  ACPI/SMBIOS
>  M: Michael S. Tsirkin <mst@redhat.com>
>  M: Igor Mammedov <imammedo@redhat.com>
> @@ -1764,7 +1752,6 @@ F: hw/ssi/xilinx_*
>  
>  SD (Secure Card)
>  M: Philippe Mathieu-Daudé <f4bug@amsat.org>
> -M: Bin Meng <bin.meng@windriver.com>
>  L: qemu-block@nongnu.org
>  S: Odd Fixes
>  F: include/hw/sd/sd*
> @@ -1859,7 +1846,6 @@ F: fsdev/
>  F: docs/interop/virtfs-proxy-helper.rst
>  F: tests/qtest/virtio-9p-test.c
>  T: git https://gitlab.com/gkurz/qemu.git 9p-next
> -T: git https://github.com/cschoenebeck/qemu.git 9p.next
>  
>  virtio-blk
>  M: Stefan Hajnoczi <stefanha@redhat.com>
> @@ -2904,13 +2890,13 @@ F: accel/tcg/user-exec*.c
>  BSD user
>  S: Orphan
>  F: bsd-user/
> -F: default-configs/targets/*-bsd-user.mak
> +F: default-configs/*-bsd-user.mak
>  
>  Linux user
>  M: Laurent Vivier <laurent@vivier.eu>
>  S: Maintained
>  F: linux-user/
> -F: default-configs/targets/*linux-user.mak
> +F: default-configs/*-linux-user.mak
>  F: scripts/qemu-binfmt-conf.sh
>  F: scripts/update-syscalltbl.sh
>  F: scripts/update-mips-syscall-args.sh
> @@ -2930,7 +2916,6 @@ S: Maintained
>  F: docs/devel/tcg-plugins.rst
>  F: plugins/
>  F: tests/plugin/
> -F: tests/acceptance/tcg_plugins.py
>  F: contrib/plugins/
>  
>  AArch64 TCG target
> diff --git a/hw/pci/meson.build b/hw/pci/meson.build
> index 5c4bbac817..115e50222f 100644
> --- a/hw/pci/meson.build
> +++ b/hw/pci/meson.build
> @@ -12,6 +12,7 @@ pci_ss.add(files(
>  # allow plugging PCIe devices into PCI buses, include them even if
>  # CONFIG_PCI_EXPRESS=n.
>  pci_ss.add(files('pcie.c', 'pcie_aer.c'))
> +pci_ss.add(files('pcie_doe.c'))
>  softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
>  softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
>  
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 9d834facba..8d95c3fd25 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -132,13 +132,8 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
>  static void pcie_bus_realize(BusState *qbus, Error **errp)
>  {
>      PCIBus *bus = PCI_BUS(qbus);
> -    Error *local_err = NULL;
>  
> -    pci_bus_realize(qbus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    pci_bus_realize(qbus, errp);
>  
>      /*
>       * A PCI-E bus can support extended config space if it's the root
> @@ -2158,8 +2153,10 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>              pci_qdev_unrealize(DEVICE(pci_dev));
>              return;
>          }

Please do a quick review of any patch before you send it out for unrelated
stuff.

> -        if ((pci_dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION)
> -            || (PCI_FUNC(pci_dev->devfn) != 0)) {
> +        if (!(pci_dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION)
> +            && (PCI_FUNC(pci_dev->devfn) == 0)) {
> +            qdev->allow_unplug_during_migration = true;
> +        } else {
>              error_setg(errp, "failover: primary device must be in its own "
>                                "PCI slot");
>              pci_qdev_unrealize(DEVICE(pci_dev));
> diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
> new file mode 100644
> index 0000000000..fab58eb897
> --- /dev/null
> +++ b/hw/pci/pcie_doe.c
> @@ -0,0 +1,416 @@
> +/*
> + * PCIe Data Object Exchange
> + *
> + * Copyright (C) 2020 Avery Design Systems, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qemu/range.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_doe.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/msix.h"
> +
> +/*
> + * DOE Default Protocols (Discovery, CMA)

CMA is absolutely not a default protocol. If it is there, some other protocols
cannot be.

> + */
> +/* Discovery Request Object */
> +struct doe_discovery {
> +    DOEHeader header;
> +    uint8_t index;
> +    uint8_t reserved[3];
> +} QEMU_PACKED;
> +
> +/* Discovery Response Object */
> +struct doe_discovery_rsp {
> +    DOEHeader header;
> +    uint16_t vendor_id;
> +    uint8_t doe_type;
> +    uint8_t next_index;
> +} QEMU_PACKED;
> +
> +/* Callback for Discovery */
> +static bool pcie_doe_discovery_rsp(DOECap *doe_cap)
> +{
> +    struct doe_discovery *req = pcie_doe_get_req(doe_cap);
> +    struct doe_discovery_rsp rsp;
> +    uint8_t index = req->index;
> +    DOEProtocol *prot;
> +
> +    /* Request length mismatch, discard */
> +    if (pcie_doe_object_len(req) <
> +        DIV_ROUND_UP(sizeof(struct doe_discovery), 4)) {
> +        return false;
> +    }
> +
> +    rsp.header = (DOEHeader) {
> +        .vendor_id = PCI_VENDOR_ID_PCI_SIG,
> +        .doe_type = PCI_SIG_DOE_DISCOVERY,
> +        .length = DIV_ROUND_UP(sizeof(struct doe_discovery_rsp), 4),
> +    };
> +
> +    /* Point to the requested protocol, index 0 must be Discovery */
> +    if (index == 0) {
> +        rsp.vendor_id = PCI_VENDOR_ID_PCI_SIG;
> +        rsp.doe_type = PCI_SIG_DOE_DISCOVERY;
> +    } else {
> +        if (index < doe_cap->protocol_num) {
> +            prot = &doe_cap->protocols[index - 1];
> +        } else {
> +            prot = NULL;
> +        }
> +
> +        rsp.vendor_id = (prot) ? prot->vendor_id : 0xFFFF;
> +        rsp.doe_type = (prot) ? prot->doe_type : 0xFF;
> +    }
> +
> +    rsp.next_index = (index + 1) % doe_cap->protocol_num,
> +
> +    pcie_doe_set_rsp(doe_cap, &rsp);
> +
> +    return true;
> +}
> +
> +/* Callback for CMA */
> +bool pcie_doe_cma_rsp(DOECap *doe_cap)
> +{

Umm. Really? Please don't leave a stub like this in place. Just don't
support CMA until you are ready to do it fully.

If you can share plan on that it would be great though as it's on my
list of things to track.

> +    doe_cap->status.error = 1;
> +
> +    memset(doe_cap->read_mbox, 0,
> +           PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +
> +    doe_cap->write_mbox_len = 0;
> +
> +    return false;
> +}
> +
> +/*
> + * DOE Utilities

Generic comments like this always rot (become out of date) over time, so
don't bother.

> + */
> +static void pcie_doe_reset_mbox(DOECap *st)
> +{
> +    st->read_mbox_idx = 0;
> +    st->read_mbox_len = 0;
> +    st->write_mbox_len = 0;
> +
> +    memset(st->read_mbox, 0, PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +    memset(st->write_mbox, 0, PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +}
> +
> +/*
> + * PCI DOE functions

Same with this one.  Make it clear by naming of functions rather than
a comment that will probably end up in the wrong place in a few years.

> + */
> +/*
> + * Add DOE cap to a dev
> + * Initialize its protocol.
> + */
> +void pcie_doe_init(PCIDevice *dev, DOECap *doe_cap, uint16_t offset,
> +                   DOEProtocol *protocols, bool intr, uint16_t vec)
> +{
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_DOE, PCI_DOE_VER, offset,
> +                        PCI_DOE_SIZEOF);
> +
> +    doe_cap->pdev = dev;
> +    doe_cap->offset = offset;
> +
> +    /* Configure MSI/MSI-X */
> +    if (intr && (msi_present(dev) || msix_present(dev))) {
> +        doe_cap->cap.intr = intr;
> +        doe_cap->cap.vec = vec;
> +    }
> +
> +    /* Set up W/R Mailbox buffer */
> +    doe_cap->write_mbox = g_malloc0(PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +    doe_cap->read_mbox = g_malloc0(PCI_DOE_MAX_DW_SIZE * sizeof(uint32_t));
> +
> +    pcie_doe_reset_mbox(doe_cap);
> +
> +    /* Register default discovery protocol */
> +    doe_cap->protocols = protocols;
> +    for (; protocols->vendor_id; protocols++) {
> +        doe_cap->protocol_num++;
> +    }
> +    assert(doe_cap->protocol_num < PCI_DOE_PROTOCOL_MAX);
> +
> +    /* Add 1 for Discovery */
> +    doe_cap->protocol_num++;
> +}
> +
> +void pcie_doe_fini(DOECap *doe_cap)
> +{
> +    g_free(doe_cap->read_mbox);
> +    g_free(doe_cap->write_mbox);
> +    g_free(doe_cap);
> +}
> +
> +uint32_t pcie_doe_build_protocol(DOEProtocol *p)
> +{
> +    return DATA_OBJ_BUILD_HEADER1(p->vendor_id, p->doe_type);
> +}
> +
> +/* Return the pointer of DOE request in write mailbox buffer */
> +void *pcie_doe_get_req(DOECap *doe_cap)
> +{
> +    return doe_cap->write_mbox;
> +}
> +
> +/* Copy the response to read mailbox buffer */
> +void pcie_doe_set_rsp(DOECap *doe_cap, void *rsp)
> +{
> +    uint32_t len = pcie_doe_object_len(rsp);
> +
> +    memcpy(doe_cap->read_mbox + doe_cap->read_mbox_len,
> +           rsp, len * sizeof(uint32_t));
> +    doe_cap->read_mbox_len += len;
> +}
> +
> +/* Get Data Object length */
> +uint32_t pcie_doe_object_len(void *obj)
> +{
> +    uint32_t len = (obj) ? ((DOEHeader *)obj)->length : 0;
> +
> +    return len & (PCI_DOE_MAX_DW_SIZE - 1);
> +}
> +
> +static void pcie_doe_write_mbox(DOECap *doe_cap, uint32_t val)
> +{
> +    doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
> +
> +    if (doe_cap->write_mbox_len == 1) {
> +        DOE_DBG("(Capture DOE request DO length = %x)", val & 0x0003ffff);
> +    }
> +
> +    doe_cap->write_mbox_len++;
> +}
> +
> +static void pcie_doe_irq_assert(DOECap *doe_cap)
> +{
> +    PCIDevice *dev = doe_cap->pdev;
> +
> +    if (doe_cap->cap.intr && doe_cap->ctrl.intr) {
> +        if (doe_cap->status.intr) {
> +            return;
> +        }
> +        doe_cap->status.intr = 1;
> +
> +        /* Interrupt notify */
> +        if (msix_enabled(dev)) {
> +            msix_notify(dev, doe_cap->cap.vec);
> +        } else if (msi_enabled(dev)) {
> +            msi_notify(dev, doe_cap->cap.vec);
> +        }
> +        /* Not support legacy IRQ */
> +    }
> +}
> +
> +static void pcie_doe_set_ready(DOECap *doe_cap, bool rdy)
> +{
> +    doe_cap->status.ready = rdy;
> +
> +    if (rdy) {
> +        pcie_doe_irq_assert(doe_cap);
> +    }
> +}
> +
> +static void pcie_doe_set_error(DOECap *doe_cap, bool err)
> +{
> +    doe_cap->status.error = err;
> +
> +    if (err) {
> +        pcie_doe_irq_assert(doe_cap);
> +    }
> +}
> +
> +/*
> + * Check protocol the incoming request in write_mbox and
> + * memcpy the corresponding response to read_mbox.
> + *
> + * "discard" should be set up if the response callback
> + * function could not deal with request (e.g. length
> + * mismatch) or the protocol of request was not found.

I think this comment is out of date?  What does "discard" being
setup mean?

> + */
> +static void pcie_doe_prepare_rsp(DOECap *doe_cap)
> +{
> +    bool success = false;
> +    int p;
> +
> +    if (doe_cap->status.error) {
> +        return;
> +    }
> +
> +    if (doe_cap->write_mbox[0] ==
> +        DATA_OBJ_BUILD_HEADER1(PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_DISCOVERY)) {
> +        /* Discovery */
> +        success = pcie_doe_discovery_rsp(doe_cap);
> +    } else {
> +        /* Other protocols */
> +        for (p = 0; p < doe_cap->protocol_num - 1; p++) {
> +            if (doe_cap->write_mbox[0] ==
> +                pcie_doe_build_protocol(&doe_cap->protocols[p])) {
> +                DOE_DBG("(protocol = %x)", doe_cap->write_mbox[0]);
> +                /*
> +                 * Spec:
> +                 * If the number of DW transferred does not match the
> +                 * indicated Length for a data object, then the
> +                 * data object must be silently discarded.
> +                 */
> +                if (doe_cap->write_mbox_len ==
> +                    pcie_doe_object_len(pcie_doe_get_req(doe_cap))) {
> +                    success = doe_cap->protocols[p].set_rsp(doe_cap);
> +                }
> +                break;
> +            }
> +        }
> +    }
> +
> +    /* Set DOE Ready */
> +    if (success) {
> +        pcie_doe_set_ready(doe_cap, 1);
> +    } else {
> +        pcie_doe_reset_mbox(doe_cap);
> +    }
> +}
> +
> +/*
> + * Read from DOE config space.
> + * Return false if the address doesn't hit the range.
> + */
> +bool pcie_doe_read_config(DOECap *doe_cap, uint32_t addr, int size,
> +                          uint32_t *buf)
> +{
> +    uint32_t shift, mask = 0xFFFFFFFF;
> +    uint16_t doe_offset = doe_cap->offset;
> +
> +    if (!range_covers_byte(doe_offset + PCI_EXP_DOE_CAP,
> +                           PCI_DOE_SIZEOF - 4, addr)) {
> +        return false;
> +    }
> +
> +    DOE_DBG("%s: addr=%x, size=%x\n", __func__, addr, size);
> +    addr -= doe_offset;
> +    *buf = 0;
> +
> +    if (range_covers_byte(PCI_EXP_DOE_CAP, sizeof(uint32_t), addr)) {
> +        DOE_DBG("  CAP");
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_REG, INTR_SUPP,
> +                          doe_cap->cap.intr);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_REG, DOE_INTR_MSG_NUM,
> +                          doe_cap->cap.vec);
> +    } else if (range_covers_byte(PCI_EXP_DOE_CTRL, sizeof(uint32_t), addr)) {
> +        DOE_DBG("  CONTROL");
> +        /* Must return ABORT=0 and GO=0 */
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_CONTROL, DOE_INTR_EN,
> +                          doe_cap->ctrl.intr);
> +    } else if (range_covers_byte(PCI_EXP_DOE_STATUS, sizeof(uint32_t), addr)) {
> +        DOE_DBG("  STATUS");
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_BUSY,
> +                          doe_cap->status.busy);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_INTR_STATUS,
> +                          doe_cap->status.intr);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DOE_ERROR,
> +                          doe_cap->status.error);
> +        *buf = FIELD_DP32(*buf, PCI_DOE_CAP_STATUS, DATA_OBJ_RDY,
> +                          doe_cap->status.ready);
> +    } else if (range_covers_byte(PCI_EXP_DOE_RD_DATA_MBOX, sizeof(uint32_t), addr)) {
> +        DOE_DBG("  RD_MBOX");
> +        if (doe_cap->status.ready && !doe_cap->status.error) {
> +            DOE_DBG(" (ready, off=%x, len=%x)",
> +                    doe_cap->read_mbox_idx, doe_cap->read_mbox_len);
> +            *buf = doe_cap->read_mbox[doe_cap->read_mbox_idx];
> +        }
> +    } else if (range_covers_byte(PCI_EXP_DOE_WR_DATA_MBOX, sizeof(uint32_t), addr)) {
> +        DOE_DBG("  WR_MBOX");
> +    }
> +    DOE_DBG(", val=%x\n", *buf);
> +
> +    /* Alignment */
> +    shift = addr % sizeof(uint32_t);
> +    *buf >>= shift * 8;
> +    mask >>= (sizeof(uint32_t) - size) * 8;
> +    *buf &= mask;
> +
> +    return true;
> +}
> +
> +/*
> + * Write to DOE config space.
> + * Early return if the address doesn't hit the range or receives an abort signal.
> + */
> +void pcie_doe_write_config(DOECap *doe_cap,
> +                           uint32_t addr, uint32_t val, int size)
> +{
> +    uint16_t doe_offset = doe_cap->offset;
> +    uint32_t shift;
> +
> +    if (!range_covers_byte(doe_offset + PCI_EXP_DOE_CAP,
> +                           PCI_DOE_SIZEOF - 4, addr)) {
> +        return;
> +    }
> +
> +    DOE_DBG("%s: addr = %x, size = %x, val = %x\033[m\n", __func__, addr, size, val);
> +    /* Alignment */
> +    shift = addr % sizeof(uint32_t);
> +    addr -= (doe_offset - shift);
> +    val <<= shift * 8;
> +
> +    switch (addr) {
> +    case PCI_EXP_DOE_CTRL:
> +        DOE_DBG("  CONTROL");

The density of debug info in here feel too high for a code that is pretty close
to ready for merging.  I'd think hard about what actually matters - I'd suggest
just unexpected error paths, but perhaps a little more if it's really useful.

It absolutely makes sense to have this debug in there whilst developing, but
once you are done it's not really very useful + makes code less readable
and bloated.

> +        if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_ABORT)) {
> +            /* If ABORT, clear status reg DOE Error and DOE Ready */

Fairly obvious comment and it doesn't mention the reset mailbox, so I'd
drop it as unnecessary and incomplete.

> +            DOE_DBG("-ABORT");
> +            pcie_doe_set_ready(doe_cap, 0);
> +            pcie_doe_set_error(doe_cap, 0);
> +            pcie_doe_reset_mbox(doe_cap);
> +            return;
> +        }
> +
> +        if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_GO)) {
> +            DOE_DBG("-GO");
> +            pcie_doe_prepare_rsp(doe_cap);
> +        }
> +
> +        if (FIELD_EX32(val, PCI_DOE_CAP_CONTROL, DOE_INTR_EN)) {
> +            DOE_DBG("-INTR");
> +            doe_cap->ctrl.intr = 1;

How to disable interrupt?

> +        }
> +        break;
> +    case PCI_EXP_DOE_STATUS:
> +        DOE_DBG("  STATUS");
> +        if (FIELD_EX32(val, PCI_DOE_CAP_STATUS, DOE_INTR_STATUS)) {
> +            DOE_DBG("-INTR");
> +            doe_cap->status.intr = 0;
> +        }
> +        break;
> +    case PCI_EXP_DOE_RD_DATA_MBOX:
> +        DOE_DBG("  RD_MBOX");
> +        doe_cap->read_mbox_idx += 1;
> +        DOE_DBG(" (incr offset = %x)", doe_cap->read_mbox_idx);
> +        if (doe_cap->read_mbox_idx == doe_cap->read_mbox_len) {
> +            /* Last DW */
> +            pcie_doe_reset_mbox(doe_cap);
> +            pcie_doe_set_ready(doe_cap, 0);
> +        } else if (doe_cap->read_mbox_idx > doe_cap->read_mbox_len) {
> +            /* Underflow */
> +            pcie_doe_set_error(doe_cap, 1);
> +        }
> +        break;
> +    case PCI_EXP_DOE_WR_DATA_MBOX:
> +        DOE_DBG("  WR_MBOX");
> +        pcie_doe_write_mbox(doe_cap, val);
> +        DOE_DBG(" (offset = %x)", doe_cap->write_mbox_len);
> +        break;
> +    case PCI_EXP_DOE_CAP:
> +        DOE_DBG("  CAP (no effect)");
At least sometimes, qemu is built with checks that require explicit fallthrough markers
	   /* fallthrough */

This aids static checkers by making it clear you did this deliberately.
> +    default:
> +        break;
> +    }
> +    DOE_DBG("\n");
> +}
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 95f92d98e9..ffa9853247 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -157,6 +157,8 @@
>  
>  /* Vendors and devices.  Sort key: vendor first, device next. */
>  
> +#define PCI_VENDOR_ID_PCI_SIG            0x0001
> +
>  #define PCI_VENDOR_ID_LSI_LOGIC          0x1000
>  #define PCI_DEVICE_ID_LSI_53C810         0x0001
>  #define PCI_DEVICE_ID_LSI_53C895A        0x0012
> @@ -208,10 +210,9 @@
>  #define PCI_DEVICE_ID_VIA_ISA_BRIDGE     0x0686
>  #define PCI_DEVICE_ID_VIA_IDE            0x0571
>  #define PCI_DEVICE_ID_VIA_UHCI           0x3038
> -#define PCI_DEVICE_ID_VIA_82C686B_PM     0x3057

Please sanity check patches for merge conflicts. This just broke a bunch of other
peoples drivers.

> +#define PCI_DEVICE_ID_VIA_ACPI           0x3057
>  #define PCI_DEVICE_ID_VIA_AC97           0x3058
>  #define PCI_DEVICE_ID_VIA_MC97           0x3068
> -#define PCI_DEVICE_ID_VIA_8231_PM        0x8235
>  
>  #define PCI_VENDOR_ID_MARVELL            0x11ab
>  
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 14c58ebdb6..47d6f66e52 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -25,6 +25,7 @@
>  #include "hw/pci/pcie_regs.h"
>  #include "hw/pci/pcie_aer.h"
>  #include "hw/hotplug.h"
> +#include "hw/pci/pcie_doe.h"
>  
>  typedef enum {
>      /* for attention and power indicator */
> diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
> new file mode 100644
> index 0000000000..45fe2d3c88
> --- /dev/null
> +++ b/include/hw/pci/pcie_doe.h
> @@ -0,0 +1,142 @@
> +/*
> + * PCIe Data Object Exchange
> + *
> + * Copyright (C) 2020 Avery Design Systems, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef PCIE_DOE_H
> +#define PCIE_DOE_H
> +
> +#include "qemu/range.h"
> +#include "qemu/typedefs.h"
> +#include "hw/register.h"
> +
> +/*
> + * PCI DOE register defines 7.9.24
> + */
> +/* Capabilities Register 7.9.24.2 */
> +#define PCI_EXP_DOE_CAP             0x04
> +REG32(PCI_DOE_CAP_REG, 0)
> +    FIELD(PCI_DOE_CAP_REG, INTR_SUPP, 0, 1)
> +    FIELD(PCI_DOE_CAP_REG, DOE_INTR_MSG_NUM, 1, 11)
> +
> +/* Control Register 7.9.24.3 */
> +#define PCI_EXP_DOE_CTRL            0x08
> +REG32(PCI_DOE_CAP_CONTROL, 0)
> +    FIELD(PCI_DOE_CAP_CONTROL, DOE_ABORT, 0, 1)
> +    FIELD(PCI_DOE_CAP_CONTROL, DOE_INTR_EN, 1, 1)
> +    FIELD(PCI_DOE_CAP_CONTROL, DOE_GO, 31, 1)
> +
> +/* Status Register 7.9.24.4 */
> +#define PCI_EXP_DOE_STATUS          0x0c
> +REG32(PCI_DOE_CAP_STATUS, 0)
> +    FIELD(PCI_DOE_CAP_STATUS, DOE_BUSY, 0, 1)
> +    FIELD(PCI_DOE_CAP_STATUS, DOE_INTR_STATUS, 1, 1)
> +    FIELD(PCI_DOE_CAP_STATUS, DOE_ERROR, 2, 1)
> +    FIELD(PCI_DOE_CAP_STATUS, DATA_OBJ_RDY, 31, 1)
> +
> +/* Write Data Mailbox Register 7.9.24.5 */
> +#define PCI_EXP_DOE_WR_DATA_MBOX    0x10
> +
> +/* Read Data Mailbox Register 7.9.24.6 */

As below, ECN references only as that's the finalized document.

> +#define PCI_EXP_DOE_RD_DATA_MBOX    0x14
> +
> +/* Table 6-31 */

Not in a published spec I think, so use references to the ECNs that
have been released only.

> +#define PCI_SIG_DOE_DISCOVERY       0x00
> +#define PCI_SIG_DOE_CMA             0x01
> +
> +#define DATA_OBJ_BUILD_HEADER1(v, p)  ((p << 16) | v)
> +
> +#define PCI_DOE_MAX_DW_SIZE (1 << 18)
> +#define PCI_DOE_PROTOCOL_MAX 256
> +
> +/*
> + * DOE Protocol - Data Object
> + */
> +typedef struct DOEHeader DOEHeader;
> +typedef struct DOEProtocol DOEProtocol;
> +typedef struct DOECap DOECap;
> +
> +struct DOEHeader {
> +    uint16_t vendor_id;
> +    uint8_t doe_type;
> +    uint8_t reserved;
> +    uint32_t length;
> +} QEMU_PACKED;
> +
> +/* Protocol infos and rsp function callback */
> +struct DOEProtocol {
> +    uint16_t vendor_id;
> +    uint8_t doe_type;

It's a "data object type", not a "data object exchange type", so
something like do_type or data_obj_type.
Point being the DOE is the means of exchanging data objects, not
the protocol for the objects being exchanged which is simply
a "Data object protocol"
(nitpick but nice to get it all to line up with the spec)

> +    bool (*set_rsp)(DOECap *);
> +};
> +
> +struct DOECap {
> +    /* Owner */
> +    PCIDevice *pdev;
> +
> +    /* Capability offset */
> +    uint16_t offset;
> +
> +    /* Capability */

Giving naming, this comment and similar ones below don't tell us anything
and just look like opportunities for noise / bitrot in the future.
I'd drop them.  When a variable name is sufficient that's great!

> +    struct {
> +        bool intr;
> +        uint16_t vec;
> +    } cap;
> +
> +    /* Control */
> +    struct {
> +        bool abort;
> +        bool intr;
> +        bool go;
> +    } ctrl;
> +
> +    /* Status */
> +    struct {
> +        bool busy;
> +        bool intr;
> +        bool error;
> +        bool ready;
> +    } status;
> +
> +    /* Mailbox buffer for device */
> +    uint32_t *write_mbox;
> +    uint32_t *read_mbox;
> +
> +    /* Mailbox position indicator */
> +    uint32_t read_mbox_idx;
> +    uint32_t read_mbox_len;
> +    uint32_t write_mbox_len;
> +
> +    /* Protocols and its callback response */
> +    DOEProtocol *protocols;
> +    uint16_t protocol_num;
> +};
> +
> +/* Basic DOE functions */
> +void pcie_doe_init(PCIDevice *pdev, DOECap *doe_cap, uint16_t offset,
> +                   DOEProtocol *protocols, bool intr, uint16_t vec);
> +void pcie_doe_fini(DOECap *doe_cap);
> +bool pcie_doe_read_config(DOECap *doe_cap, uint32_t addr, int size,
> +                          uint32_t *buf);
> +void pcie_doe_write_config(DOECap *doe_cap, uint32_t addr,
> +                           uint32_t val, int size);
> +
> +/* Utility functions for DOEProtocol */
> +uint32_t pcie_doe_build_protocol(DOEProtocol *p);
> +bool pcie_doe_cma_rsp(DOECap *doe_cap);

cma is a user of DOE.  Great to see it, but separate patch please.
Absolutely fine for a DOE mailbox to not support the CMA protocol.
More importantly the CMA ECN makes it clear that an CMA supporting
mailbox may not support other protocols. 6.xx.3 CMA Rules
That's then relaxed to allow IDE in the IDE ECN, but that's it
currently.

Side question here. Any plans on OS side for CMA?

> +void *pcie_doe_get_req(DOECap *doe_cap);
> +void pcie_doe_set_rsp(DOECap *doe_cap, void *rsp);
> +uint32_t pcie_doe_object_len(void *obj);
> +
> +#define DOE_DEBUG
> +#ifdef DOE_DEBUG
> +#define DOE_DBG(...) printf(__VA_ARGS__)

Drop the debug or move to debug more in keeping with qemu code.
At very least copy what is in pcie_aer and print to standard error.


> +#else
> +#define DOE_DBG(...) {}
> +#endif
> +
> +#endif /* PCIE_DOE_H */
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index 1db86b0ec4..963dc2e170 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -179,4 +179,8 @@ typedef enum PCIExpLinkWidth {
>  #define PCI_ACS_VER                     0x1
>  #define PCI_ACS_SIZEOF                  8
>  
> +/* DOE Capability Register Fields */
> +#define PCI_DOE_VER                     0x1

Clearly precedence for this, but I'm a bit confused as to why it makes
sense to have a define for a version number given any changes in future
'should' be backwards compatible anyway.

Note this approach isn't universal.   ATS for example just puts the 0x1
in the call to pcie_add_capability(). 
I'd prefer that option myself.

> +#define PCI_DOE_SIZEOF                  24

Hohum. Seems size is often int eh standard-headers  Perhaps I should probably add
it there in the kernel patch.

> +
>  #endif /* QEMU_PCIE_REGS_H */
> diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
> index e709ae8235..4a7b7a426d 100644
> --- a/include/standard-headers/linux/pci_regs.h
> +++ b/include/standard-headers/linux/pci_regs.h
> @@ -730,7 +730,8 @@
>  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
> +#define PCI_EXT_CAP_ID_DOE      0x2E    /* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE

As mentioned before, this header will get pulled in from linux via a script.
For purposes of reviewing patches etc, pull this out to a patch before
this one, allowing it to be dropped once the header is available.

>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40

