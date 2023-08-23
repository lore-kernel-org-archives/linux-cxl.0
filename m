Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15211C27C40
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Aug 2023 16:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbjHWQzd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbjHWQzd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Aug 2023 12:55:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521CFE5C
        for <linux-cxl@vger.kernel.org>; Wed, 23 Aug 2023 09:55:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RWC4N2vMkz67Q5S;
        Thu, 24 Aug 2023 00:54:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 17:55:27 +0100
Date:   Wed, 23 Aug 2023 17:55:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: QEMU freeze with CXL memory in Normal zone and stress-ng
Message-ID: <20230823175526.0000368e@Huawei.com>
In-Reply-To: <CAGEDW0dTTvnm-ZzSv_aDLNKj-gZja1A2s3+HKfY8wBn5rX4XdQ@mail.gmail.com>
References: <CAGEDW0dTTvnm-ZzSv_aDLNKj-gZja1A2s3+HKfY8wBn5rX4XdQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 18 Aug 2023 16:20:55 +0200
Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com> wrote:

> Hello,
> 
> I have noticed a system-wide freeze when using CXL memory as RAM in
> the Normal zone to run stress-ng. I am writing to check if this is a
> known issue and/or if anyone has hints on how to debug this.
> 
> Versions tested:
> - linux-stable v6.4.11
> - QEMU from https://gitlab.com/jic23/qemu/ - branches cxl-2023-05-19,
> cxl-2023-05-25, cxl-2023-07-17 (cxl-2023-07-17 also tested with linux
> v6.5-rc6; haven’t managed to boot with cxl-2023-08-07)
> - ndctl v77
> - stress-ng, version 0.15.06
> - Debian GNU/Linux 12 (bookworm)
> 
> To reproduce, start QEMU with the command:
>     qemu-system-x86_64 -drive
> file=/images/debian-12-cxl.qco
> w2,format=qcow2,index=0,media=disk,id=hd
> \
>     -m 2G,slots=8,maxmem=8G \
>     -smp 4 \
>     -kernel /linux/arch/x86_64/boot/bzImage \
>     -append "root=/dev/sda1 console=ttyS0 serial" \
>     -machine type=q35,nvdimm=on,cxl=on \
>     -object memory-backend-ram,id=cxl-mem1,share=on,size=1G \
>     -object memory-backend-ram,id=cxl-lsa1,share=on,size=128M \
>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>     -device cxl-rp,port=0,bus=cxl.1,id=root_port_cxl,chassis=0,slot=2 \
>     -device cxl-type3,bus=root_port_cxl,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-mem0
> \
>     -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=1G
> 
> Initialize CXL region as RAM in zone Normal:
>     cxl create-region -d decoder0.0
>     ndctl create-namespace --region=region0 --mode devdax --continue
>     echo offline > /sys/devices/system/memory/auto_online_blocks
>     daxctl reconfigure-device --no-movable --mode=system-ram all
> 
> Running "ls" on the CXL memory  (NUMA node 1) works fine:
>     root@cxl-img:~# numactl --membind 1 ls /usr
>     bin    include  lib32  libexec  local  share
>     games  lib      lib64  libx32   sbin   src
> 
> Running stress-ng in CXL completely freezes the system. No interaction
> with the guest is possible after a few seconds:
>     root@cxl-img:~# numactl --membind 1 stress-ng --vm 1 --vm-bytes 10M -t 10s
>     stress-ng: info: [238] setting to a 10 second run per stressor
>     stress-ng: info: [238] dispatching hogs: 1 vm
> 
> Running stress-ng in NUMA node 0 (not CXL) works fine. When the VM
> freezes, the QEMU monitor can still be accessed, but the guest kernel
> does not seem to respond to any external commands, e.g., (qemu)
> sendkey alt-sysrq-c. Then, QEMU also freezes when trying to quit it.
> I have tried to debug the (guest) kernel using gdb (starting QEMU with
> the -s flag) but, after the freeze happens, gdb reports that “The
> target is not responding to interrupt requests”.
> Debugging QEMU works but I haven’t managed to find something
> helpful that way. Also tried (briefly) kdb with no luck there either -
> the kernel does not respond at all.
> 
> Patching hw/mem/cxl_type3.c functions cxl_type3_read() and
> cxl_type3_write() to count the calls shows that CXL accesses happen in
> both cases. In the "ls" invocation, I see around 100k reads and 100k
> writes; in the "stress-ng" case, I see approximately 4 million reads
> and 2.3 million writes before the VM freezes.

Long shot, but can you add code to print the address and size of each access.
There might be something nasty around edge conditions that we've gotten
wrong in the emulation - I thought I'd poked them all but maybe not.

Right now I can't boot QEMU x86_64 TCG to due to an unrelated crash (nothing
to do with CXL at all but is present in 8.1.0 release) so hard for me to
try and replicate :(

Jonathan

> 
> The issue does not appear if the CXL memory is initialized in the
> Movable zone instead, i.e., when using the daxctl command without the
> --no-movable flag:
>     daxctl reconfigure-device --mode=system-ram all
> 
> The issue however appears when using a volatile CXL device and
> initializing CXL as Normal with the command:
>     cxl create-region -d decoder0.0 -s 1073741824 -t ram
> 
> Any ideas are welcome, thanks in advance!
> 
> Kind regards,
> Dimitris
> 

