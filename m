Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43095C7113C
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Aug 2023 14:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352983AbjHROWI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Aug 2023 10:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377799AbjHROVm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Aug 2023 10:21:42 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362E444AD
        for <linux-cxl@vger.kernel.org>; Fri, 18 Aug 2023 07:21:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9e478e122so729989a34.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Aug 2023 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zptcorp-com.20221208.gappssmtp.com; s=20221208; t=1692368466; x=1692973266;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=99sGZIKgxCK53DlS6QmRK3Uk9lULewHMd2a4hKrilsk=;
        b=IXJ6iElg4KUVZhI5+f4+NaFLae2QI5q/9+9iM5kT9VJ6P3MRztAf9ZKZS5UfTt2IU1
         lTLMewgubVIAEBWL3Qthl15TWnnvwv/y2yrm9jKErsf5wPfhG8miuGMvHd43zUe6FVz8
         iGSgylDshkUEMkk/d07k1rk1V/3gvnefQokpDmJYA5/6vRB6ezMpUgbGwif4aZWRBXVo
         38ECMsN4gc5rwAYTFsuB6+v3cl12oIt1TgsVJiRm4fCTalLAh4DLo20mKjWcNN+LYr63
         k1PSEAz1kz/HITTAvn0Z75mrAbrWNvOo+rR4KUw/fu2WePL8gGKise39CJYDGL9EdrKu
         kRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692368466; x=1692973266;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99sGZIKgxCK53DlS6QmRK3Uk9lULewHMd2a4hKrilsk=;
        b=hM1LbVi8GpVNWiW/ov/j1AH7N5eZJZelmOVbCIkMff5MZwDry5bWKx5Wk461yFnD/O
         akUSlLAeI5WxxUqiycynOH74flKjqkltRBEhCAXesoNY6zIjTDLMBCt5BL7THOVPgMlr
         oKV7Jn5kGXNkHWQJ+WIbBGvmdEd69UA4Kx3H7+AfSIPVyZweNsFMioWJNrjtpaZ54PFi
         cocblLRvelFBZMqzJDNQhzhjZ2Od/WvBUiEGRGu0r8Do4FDrV2lDYpyYCm57wsB9ONCk
         8pHj6WcThuRWLII/4rL/IqxVY9zy+GfY4goAlsPOYeuzVPZjdTYrwRvLBKyB1BIhLg1K
         Pxag==
X-Gm-Message-State: AOJu0Yy6m2g8AE+zVNu5+7wqFrGx9a4Eb0HK3wqm+9xvgUFIfUPvSZ4n
        ePVz5C+EMv1mzM54m+ScjkW6QKNIj3E3WxHdyDw2woJJCYo49odGH+kubQ5YvUf/oW3R/dSALih
        QV1XT3kIu8+xI4X20AxilO+j6oV3reTqYcJw5A1ooGsc=
X-Google-Smtp-Source: AGHT+IHDdCPJjWKHB4moiYjqJyxPZmhgVD16vkK7gw9N4DHBZKOffHI3Gx8GnNHJbF4dQ9ww3GuWGE4CmbCjdSdVHh4=
X-Received: by 2002:a05:6830:1d47:b0:6b7:54cb:7bf9 with SMTP id
 p7-20020a0568301d4700b006b754cb7bf9mr2772463oth.0.1692368466323; Fri, 18 Aug
 2023 07:21:06 -0700 (PDT)
MIME-Version: 1.0
From:   Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>
Date:   Fri, 18 Aug 2023 16:20:55 +0200
Message-ID: <CAGEDW0dTTvnm-ZzSv_aDLNKj-gZja1A2s3+HKfY8wBn5rX4XdQ@mail.gmail.com>
Subject: QEMU freeze with CXL memory in Normal zone and stress-ng
To:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

I have noticed a system-wide freeze when using CXL memory as RAM in
the Normal zone to run stress-ng. I am writing to check if this is a
known issue and/or if anyone has hints on how to debug this.

Versions tested:
- linux-stable v6.4.11
- QEMU from https://gitlab.com/jic23/qemu/ - branches cxl-2023-05-19,
cxl-2023-05-25, cxl-2023-07-17 (cxl-2023-07-17 also tested with linux
v6.5-rc6; haven=E2=80=99t managed to boot with cxl-2023-08-07)
- ndctl v77
- stress-ng, version 0.15.06
- Debian GNU/Linux 12 (bookworm)

To reproduce, start QEMU with the command:
    qemu-system-x86_64 -drive
file=3D/images/debian-12-cxl.qco
w2,format=3Dqcow2,index=3D0,media=3Ddisk,id=3Dhd
\
    -m 2G,slots=3D8,maxmem=3D8G \
    -smp 4 \
    -kernel /linux/arch/x86_64/boot/bzImage \
    -append "root=3D/dev/sda1 console=3DttyS0 serial" \
    -machine type=3Dq35,nvdimm=3Don,cxl=3Don \
    -object memory-backend-ram,id=3Dcxl-mem1,share=3Don,size=3D1G \
    -object memory-backend-ram,id=3Dcxl-lsa1,share=3Don,size=3D128M \
    -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
    -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port_cxl,chassis=3D0,slot=
=3D2 \
    -device cxl-type3,bus=3Droot_port_cxl,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,=
id=3Dcxl-mem0
\
    -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D1G

Initialize CXL region as RAM in zone Normal:
    cxl create-region -d decoder0.0
    ndctl create-namespace --region=3Dregion0 --mode devdax --continue
    echo offline > /sys/devices/system/memory/auto_online_blocks
    daxctl reconfigure-device --no-movable --mode=3Dsystem-ram all

Running "ls" on the CXL memory  (NUMA node 1) works fine:
    root@cxl-img:~# numactl --membind 1 ls /usr
    bin    include  lib32  libexec  local  share
    games  lib      lib64  libx32   sbin   src

Running stress-ng in CXL completely freezes the system. No interaction
with the guest is possible after a few seconds:
    root@cxl-img:~# numactl --membind 1 stress-ng --vm 1 --vm-bytes 10M -t =
10s
    stress-ng: info: [238] setting to a 10 second run per stressor
    stress-ng: info: [238] dispatching hogs: 1 vm

Running stress-ng in NUMA node 0 (not CXL) works fine. When the VM
freezes, the QEMU monitor can still be accessed, but the guest kernel
does not seem to respond to any external commands, e.g., (qemu)
sendkey alt-sysrq-c. Then, QEMU also freezes when trying to quit it.
I have tried to debug the (guest) kernel using gdb (starting QEMU with
the -s flag) but, after the freeze happens, gdb reports that =E2=80=9CThe
target is not responding to interrupt requests=E2=80=9D.
Debugging QEMU works but I haven=E2=80=99t managed to find something
helpful that way. Also tried (briefly) kdb with no luck there either -
the kernel does not respond at all.

Patching hw/mem/cxl_type3.c functions cxl_type3_read() and
cxl_type3_write() to count the calls shows that CXL accesses happen in
both cases. In the "ls" invocation, I see around 100k reads and 100k
writes; in the "stress-ng" case, I see approximately 4 million reads
and 2.3 million writes before the VM freezes.

The issue does not appear if the CXL memory is initialized in the
Movable zone instead, i.e., when using the daxctl command without the
--no-movable flag:
    daxctl reconfigure-device --mode=3Dsystem-ram all

The issue however appears when using a volatile CXL device and
initializing CXL as Normal with the command:
    cxl create-region -d decoder0.0 -s 1073741824 -t ram

Any ideas are welcome, thanks in advance!

Kind regards,
Dimitris

--=20
**CONFIDENTIALITY NOTICE:*
*
*The contents of this email message and any=20
attachments are intended solely for the addressee(s) and may contain=20
confidential and/or privileged information and may be legally protected=20
from disclosure. If you are not the intended recipient of this message or=
=20
their agent, or if this message has been addressed to you in error, please=
=20
immediately alert the sender by reply email and then delete this message=20
and any attachments. If you are not the intended recipient, you are hereby=
=20
notified that any use, dissemination, copying, or storage of this message=
=20
or its attachments is strictly prohibited.=C2=A0*
