Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B208C11F66
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Jun 2021 12:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F09A61D97
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Jun 2021 12:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhF2M2E (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:28:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3329 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhF2M2D (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Jun 2021 08:28:03 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GDk5B3gbtz6G99L;
        Tue, 29 Jun 2021 20:17:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 14:25:33 +0200
Received: from localhost (10.47.24.170) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 29 Jun
 2021 13:25:32 +0100
Date:   Tue, 29 Jun 2021 13:25:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     <mst@redhat.com>, <armbru@redhat.com>, <ben.widawsky@intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <f4bug@amsat.org>,
        <hchkuo@avery-design.com.tw>, <imammedo@redhat.com>,
        <ira.weiny@intel.com>, <jgroves@micron.com>,
        <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <tyshao@avery-design.com.tw>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH v1 QEMU CXL modifications for openspdm 0/1] Testing PCIe
 DOE in QEMU CXL/PCIe Device using openspdm
Message-ID: <20210629132520.00000d1f@Huawei.com>
In-Reply-To: <1624665723-5169-1-git-send-email-cbrowy@avery-design.com>
References: <1624665723-5169-1-git-send-email-cbrowy@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.170]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 25 Jun 2021 20:02:03 -0400
Chris Browy <cbrowy@avery-design.com> wrote:

> This patch series provides an implementation of the the Data Object Exchange
> (DOE) for Component Measurement and Authentication (CMA) of the Security
> Protocol and Data Model (SPDM). 
> 
> This patch is based on 
> [1] [PATCH v1 openspdm on QEMU CXL/PCIe Device 0/2] Testing PCIe DOE in QEMU CXL/PCIe Device using openspdm
> https://lore.kernel.org/qemu-devel/1624665280-3595-1-git-send-email-cbrowy@avery-design.com/T/#u
> [2] QEMU DOE: [PATCH v6 cxl2.0-v6-doe 0/6] QEMU PCIe DOE for PCIe 4.0/5.0 and CXL 2.0
> https://lore.kernel.org/qemu-devel/1623329999-15662-1-git-send-email-cbrowy@avery-design.com/
> 
> Openspdm is an emulator composed of an SPDM requester and an SPDM responder.
> The default SpdmEmu usage have the requester and responder communicate with
> each other via a TCP socket. 
> 
> However to test PCIe DOE support in QEMU PCIe/CXL device directly, the openspdm
> requester is modified to use pwrite/pread for MMIO access to the
> QEMU CXL Device DOE capability (hw/mem/cxl_type3.c).  The openspdm
> requester is run as user application targeting the CXL Device.
> 
> Follow the readme.md under [1] to build this enhanced version of openspdm.
> 
> The QEMU CXL device is extended usig the "-spdm=<bool>" option to turn on/off
> the DOE/CMA capability. Once the option is turned on (-spdm=true) the CXL
> device can communicate with Openspdm's responder to get the data object of
> SPDM/secured SPDM.  QEMU and SPDM responder communicate over client-server
> method.

Hi Chris / Hchkuo

Thanks. I've gotten it up on running on my normal ARM64 emulated
on x86 platform. Very useful indeed!

Next step for me is to get a kernel implementation up and running.
I have the basic version negotiation etc running already, but the
cert handling will take a little longer I think.

For QEMU I'm thinking that it will be 'interesting' to upstream emulation
based on the current strategy of opening a socket to the openspdm test
app.  Definitely works for now though and lets us get on with the
OS side of things :)  If nothing else the spdm build approach of
having to checkout other libraries inside the spdm tree and it linking
statically against them (I think) is not exactly standard practice for
userspace software.

One note below.

Jonathan

> 
> Build the QEMU with patch series applied to [2].
> 
> Now run the system as follows:
> 
> 1. Start Responder process:
>     ./openspdm/Build/RELEASE_GCC/X64/SpdmResponderEmu --trans PCI_DOE

If I run it like this, it fails to find the certs.
cd openspdm/Build/RELEASE_GCC/X64/
./SpdmResponderEmu --trans PCI_DOE
finds them all.  Same is need inside QEMU 'guest'.

> 
> 2. Start QEMU process:
>     qemu-system-x86_64 \
>     -nic user,hostfwd=tcp::2222-:22 \
> 	-machine type=pc-q35-4.0 \
> 	-smp 8,sockets=2,cores=2,threads=2 \
> 	-m 4G \
> 	-boot order=d \
> 	-k 'en-us' \
> 	-vga virtio \
> 	-drive file=<path to qcow>,format=qcow2 \
> 	-drive if=pflash,format=raw,readonly=on,file=<path to OVMF_CODE.fd> \
> 	-drive if=pflash,format=raw,file=<path to OVMF_VARS.fd> \
> 	-object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxl-mem2,size=1K \
> 	-object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxl-mem,size=512M \
> 	-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52,uid=0,len-window-base=1,window-base[0]=0x4c0000000,memdev[0]=cxl-mem1 \
> 	-device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0 \
> 	-device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M,lsa=cxl-mem2,spdm=true
> 
> 3. Next copy the openspdm build into QEMU qcow
> 
>     scp -rP2222 openspdm qemu@localhost:.
> 
> 4. Next ssh to QEMU emulator and execute the requester user application
> 
>     sudo ./openspdm/Build/RELEASE_GCC/X64/SpdmRequesterEmu --trans PCI_DOE -s 35:00.0
> 
> hchkuo (1):
>   pcie/spdm: PCIe CMA implementation
> 
>  hw/mem/cxl_type3.c              |  31 +++-
>  hw/pci/Kconfig                  |   4 +
>  hw/pci/SpdmEmuCommand.c         | 319 ++++++++++++++++++++++++++++++++++++++++
>  hw/pci/meson.build              |   1 +
>  include/hw/cxl/cxl_device.h     |   2 +
>  include/hw/pci/SpdmEmuCommand.h |  21 +++
>  include/hw/pci/pcie_doe.h       |   2 +
>  7 files changed, 377 insertions(+), 3 deletions(-)
>  create mode 100644 hw/pci/SpdmEmuCommand.c
>  create mode 100644 include/hw/pci/SpdmEmuCommand.h
> 

