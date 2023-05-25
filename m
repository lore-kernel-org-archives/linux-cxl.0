Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F2C7EE2E
	for <linux-cxl@archiver.kernel.org>; Thu, 25 May 2023 07:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjEYHAO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 May 2023 03:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjEYHAN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 May 2023 03:00:13 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C548E43
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 00:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1684998006; i=@fujitsu.com;
        bh=UiK9uefb5m0n0oKNB5gDZGoNYcV7eIpyZUBX2N8yKIw=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type:
         Content-Transfer-Encoding;
        b=MAObP3cTAiwfmSFqJNTcmguyV8tICM/+95XFA/RbIaopPkRUJkIs00uoCBi0rjdto
         QVmVTuAEFti+6mO0pDoT1rSXph+LJFd4QIyzrqNpjYxrLm4roC/75n2prZQji/ywx7
         Q/lnfBAad+T7A2n6pJOVPho5umKO9Cx1oU25jrr7XPLT18J7b4a9cGtItPgdwQV1LY
         iNLK6rmgjWnsRIz2v+3udkHggpR4PxwIvUv2VEnJ1w/laAe6LVn+asQRbGj12ZM4My
         SpDvCIc6BL9NTMjoyBSZWp6mwBk6RF7+R1l2F3DZg3ehzidm3e6WehcrMcytEeH9O/
         suCP/Hx5Kk7pg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRWlGSWpSXmKPExsViZ8MxSbeMPT/
  F4IeoxaqF19gszs86xeLA5NFy5C2rx+dNcgFMUayZeUn5FQmsGb+bnrIW/DKt+D6pmbWBsVWv
  i5GLQ0hgC6NE18zTbBDOCiaJl50/2CGc7YwSpx4+Y+1i5OTgFbCTmLl+ETuIzSKgKrHn3F0mi
  LigxMmZT1hAbFGBFIkZGxczg9hsAjoSFxb8Berl4BAWcJM40OgBEhYRkJd4f2wT2BhmARuJs3
  9PMkPYFhKL3xyEistLbH87BywuIaAkcfHrHVYIu0ri4vuZbBC2msTVc5uYJzAKzEJyxSwko2Y
  hGbWAkXkVo1lxalFZapGuoaleUlFmekZJbmJmjl5ilW6iXmqpbnlqcYmuoV5iebFeanGxXnFl
  bnJOil5easkmRmAwpxSzGe5gXLHrr94hRkkOJiVRXv29uSlCfEn5KZUZicUZ8UWlOanFhxhlO
  DiUJHi5GfJThASLUtNTK9Iyc4CRBZOW4OBREuF9ey8vRYi3uCAxtzgzHSJ1ilGXY+O9A3uZhV
  jy8vNSpcR57ZmAZgiAFGWU5sGNgEX5JUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvAYsQFN
  4MvNK4Da9AjqCCegI1XnZIEeUJCKkpBqYPPdvOb5DW37N+T8/Z23RfSLUuspV+8/DDS3ffb+d
  iLXVyDNj/vbDosvm/dTPC65uzmv4EawSXzSngEdz1pUq8R0aL0+Lbfts9fxdsN3SbOHn3GE1l
  24H9+sXLnPZMlHx8YntWw4qPRT+ULZF8kmn8VThA70l15jlGR78CrmXtnNrSSqL3uJqH/PvKU
  Ybynq3ffges2+R8ukbjo759fp7957v7c8QOT758hVV88U1Tk+1T26TbeRfzfBD9l7xYY93P9f
  rbHwxLeGkUctqg/fbHdbPOTbjNNvTD0wiC2bvtbp4bv7hupcdtznXLIkSLW+fLqluEmu2aUPA
  sVeL8k32hh2LtuFQyVzIZDfdyj1g2iolluKMREMt5qLiRAAI4yDXbQMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-7.tower-585.messagelabs.com!1684998005!160140!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13319 invoked from network); 25 May 2023 07:00:05 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-7.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 May 2023 07:00:05 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 7DE441000D8;
        Thu, 25 May 2023 08:00:05 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 6F9D31000D2;
        Thu, 25 May 2023 08:00:05 +0100 (BST)
Received: from [192.168.50.5] (10.167.234.230) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 25 May 2023 08:00:03 +0100
Message-ID: <bf7bee13-40c7-9164-9e62-3ab99951c9ad@fujitsu.com>
Date:   Thu, 25 May 2023 14:59:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Some of cxl devices cannot be created when `CONFIG_CXL_MEM=y`
To:     <linux-cxl@vger.kernel.org>
CC:     <Jonathan.Cameron@huawei.com>, <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.114) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi cxl developers,

Sorry for disturbing.

I am trying to simulate cxl pmem with qemu (master branch) and kernel 
(v6.4-rc3).  With help of Jonathan's patchsets[1] for qemu, cxl mem 
devices can be successfully created.

I am using run_qemu[2] to do the simulation:
   $ run_qemu --rw --cxl --pmems 0      # see the full cmd-line here[3]
This command will simulate 4 cxl mem devices on 2 cxl ports, each port 
has 2 cxl mems.  The pci devices look like this:
$ lspci -tv
-+-[0000:00]-+-00.0  Intel Corporation 82G33/G31/P35/P31 Express DRAM 
Controller
  |           +-01.0  Device 1234:1111
  |           +-02.0  Intel Corporation 82540EM Gigabit Ethernet Controller
  |           +-03.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-04.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-1f.0  Intel Corporation 82801IB (ICH9) LPC Interface 
Controller
  |           +-1f.2  Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 
port SATA Controller [AHCI mode]
  |           \-1f.3  Intel Corporation 82801I (ICH9 Family) SMBus 
Controller
  +-[0000:35]-+-00.0-[36]----00.0  Intel Corporation Device 0d93
  |           \-01.0-[37]----00.0  Intel Corporation Device 0d93
  \-[0000:bf]-+-00.0-[c0]----00.0  Intel Corporation Device 0d93
              \-01.0-[c1]----00.0  Intel Corporation Device 0d93


Then I found an issue:
   Some of CXL mem devices cannot be successfully created when CXL 
related kernel configs are all set as build-in:
```
CONFIG_CXL_BUS=y
CONFIG_CXL_PCI=y
CONFIG_CXL_MEM_RAW_COMMANDS=y
CONFIG_CXL_ACPI=y
CONFIG_CXL_PMEM=y
CONFIG_CXL_MEM=y       --> If set to `m`, all cxl mem devices are good
CONFIG_CXL_PORT=y
CONFIG_CXL_SUSPEND=y
CONFIG_CXL_REGION=y
CONFIG_CXL_REGION_INVALIDATION_TEST=y
```
   But if CONFIG_CXL_MEM is set as module, all 4 devices are created 
successfully.


Here are some info which might be usefull (when CONFIG_CXL_MEM=y):
$ cxl list -PM
[
   {
     "port":"port1",
     "host":"pci0000:bf",
     "depth":1,
     "memdevs:port1":[
       {
         "memdev":"mem0",
         "pmem_size":268435456,
         "serial":0,
         "host":"0000:c0:00.0"
       },
       {
         "memdev":"mem1",
         "pmem_size":268435456,
         "serial":0,
         "host":"0000:c1:00.0"
       }
     ]
   },
   {
     "port":"port2",
     "host":"pci0000:35",
     "depth":1
   }
]

$ dmesg | grep -i cxl
[    0.714094] acpi ACPI0016:00: _OSC: OS supports [CXL11PortRegAccess 
CXL20PortDevRegAccess]
[    0.715533] acpi ACPI0016:00: _OSC: OS now controls 
[CXLMemErrorReporting]
[    0.762537] acpi ACPI0016:01: _OSC: OS supports [CXL11PortRegAccess 
CXL20PortDevRegAccess]
[    0.764720] acpi ACPI0016:01: _OSC: OS now controls 
[CXLMemErrorReporting]
[    0.811590]  pci0000:bf: host supports CXL
[    0.811883]  pci0000:35: host supports CXL
[    1.169575] cxl_mem mem1: scan: iter: mem1 dport_dev: 0000:bf:01.0 
parent: pci0000:bf
[    1.169577] cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:bf:00.0 
parent: pci0000:bf
[    1.169584] cxl_mem mem1: found already registered port port1:pci0000:bf
[    1.170141] cxl_mem mem0: found already registered port port1:pci0000:bf
[    1.170362] cxl_mem mem2: scan: iter: mem2 dport_dev: 0000:35:00.0 
parent: pci0000:35
[    1.170370] cxl_mem mem2: 0000:35:00.0 is a root dport
[    1.172024] cxl_mem mem3: scan: iter: mem3 dport_dev: 0000:35:01.0 
parent: pci0000:35
[    1.173517] cxl_mem mem3: 0000:35:01.0 is a root dport

It seems `add_port_attach_ep()` (cxl driver code in kernel) failed when 
attempt to add mem2 and mem3 devices.  Because I am new to cxl, not sure 
if something is configured wrong.  If you need more info, please tell me.


--
Thanks,
Ruan.

[1] patchsets:
  1) 
https://lore.kernel.org/linux-cxl/20230522145029.6370-1-Jonathan.Cameron@huawei.com/T/#m086c379a6ac9020e8e4e0a77ceea564285c0da0f
  2) 
https://lore.kernel.org/linux-cxl/20230522150947.11546-1-Jonathan.Cameron@huawei.com/T/#mfd5061217d19689924f129218be51ca017d8e692

[2] run_qemu: https://github.com/pmem/run_qemu

[3] the full qemu cmd-line created by run_qemu:
qemu-system-x86_64 -machine q35,accel=kvm,cxl=on -m 
8192M,slots=2,maxmem=12288M -smp 8,sockets=2,cores=2,threads=2 
-enable-kvm -display none -nographic -drive 
if=pflash,format=raw,unit=0,file=OVMF_CODE.fd,readonly=on -drive 
if=pflash,format=raw,unit=1,file=OVMF_VARS.fd -debugcon 
file:uefi_debug.log -global isa-debugcon.iobase=0x402 -drive 
file=root.img,format=raw,media=disk -kernel 
mkosi.extra/boot/vmlinuz-6.4.0-rc3-pmem+ -initrd 
mkosi.extra/boot/initramfs-6.4.0-rc3-pmem+.img -append selinux=0 audit=0 
console=tty0 console=ttyS0 root=/dev/sda2 ignore_loglevel rw 
memmap=2G!4G efi_fake_mem=2G@6G:0x40000 -device 
e1000,netdev=net0,mac=52:54:00:12:34:56 -netdev 
user,id=net0,hostfwd=tcp::10022-:22 -object 
memory-backend-file,id=cxl-mem0,share=on,mem-path=cxltest0.raw,size=256M 
-object 
memory-backend-file,id=cxl-mem1,share=on,mem-path=cxltest1.raw,size=256M 
-object 
memory-backend-file,id=cxl-mem2,share=on,mem-path=cxltest2.raw,size=256M 
-object 
memory-backend-file,id=cxl-mem3,share=on,mem-path=cxltest3.raw,size=256M 
-object 
memory-backend-file,id=cxl-lsa0,share=on,mem-path=lsa0.raw,size=1K 
-object 
memory-backend-file,id=cxl-lsa1,share=on,mem-path=lsa1.raw,size=1K 
-object 
memory-backend-file,id=cxl-lsa2,share=on,mem-path=lsa2.raw,size=1K 
-object 
memory-backend-file,id=cxl-lsa3,share=on,mem-path=lsa3.raw,size=1K 
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=53 -device 
pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=191 -device 
cxl-rp,id=hb0rp0,bus=cxl.0,chassis=0,slot=0,port=0 -device 
cxl-rp,id=hb0rp1,bus=cxl.0,chassis=0,slot=1,port=1 -device 
cxl-rp,id=hb1rp0,bus=cxl.1,chassis=0,slot=2,port=0 -device 
cxl-rp,id=hb1rp1,bus=cxl.1,chassis=0,slot=3,port=1 -device 
cxl-type3,bus=hb0rp0,memdev=cxl-mem0,id=cxl-dev0,lsa=cxl-lsa0 -device 
cxl-type3,bus=hb0rp1,memdev=cxl-mem1,id=cxl-dev1,lsa=cxl-lsa1 -device 
cxl-type3,bus=hb1rp0,memdev=cxl-mem2,id=cxl-dev2,lsa=cxl-lsa2 -device 
cxl-type3,bus=hb1rp1,memdev=cxl-mem3,id=cxl-dev3,lsa=cxl-lsa3 -M 
cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k,cxl-fmw.1.targets.0=cxl.0,cxl-fmw.1.targets.1=cxl.1,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=8k 
-object memory-backend-ram,id=mem0,size=2048M -numa 
node,nodeid=0,memdev=mem0, -numa cpu,node-id=0,socket-id=0 -object 
memory-backend-ram,id=mem1,size=2048M -numa node,nodeid=1,memdev=mem1, 
-numa cpu,node-id=1,socket-id=1 -object 
memory-backend-ram,id=mem2,size=2048M -numa node,nodeid=2,memdev=mem2, 
-object memory-backend-ram,id=mem3,size=2048M -numa 
node,nodeid=3,memdev=mem3, -numa dist,src=0,dst=0,val=10 -numa 
dist,src=0,dst=1,val=21 -numa dist,src=0,dst=2,val=12 -numa 
dist,src=0,dst=3,val=21 -numa dist,src=1,dst=1,val=10 -numa 
dist,src=1,dst=2,val=21 -numa dist,src=1,dst=3,val=12 -numa 
dist,src=2,dst=2,val=10 -numa dist,src=2,dst=3,val=21 -numa 
dist,src=3,dst=3,val=10
