Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C4C71155
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Aug 2023 15:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377915AbjHRPBq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Aug 2023 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377938AbjHRPB3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Aug 2023 11:01:29 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA3ECD
        for <linux-cxl@vger.kernel.org>; Fri, 18 Aug 2023 08:01:27 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bd0afbd616so852424a34.0
        for <linux-cxl@vger.kernel.org>; Fri, 18 Aug 2023 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zptcorp-com.20221208.gappssmtp.com; s=20221208; t=1692370887; x=1692975687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Kje/PV1xglcggGamancPzKU941PuqAntqW1KXqMmmM=;
        b=49/W4fouQKW2VTKcDkIzv5a+6QwkSox2NIaX0nvZsFcZiJJnhaJGGV1XdAjAERvVKh
         dgLRePBtHQvHC3yGcS1B23Q2rLuCxHfxdBd1x45NM8Ln1ol02qM8zdPnnccBswD6R/Xg
         CfWaJFymLjbbZxWHNFRcuLIzp2unFNbfRJmHCTye9qblx0nXfUQzYd/Pw8g9ApNaRZwN
         jTDyYcYcbxWWdffw3GvVx2dN/9SpBt6TcwG0Us1nieCqcSdUpPwXh3SgJ7Wr3stINluX
         Tc4IXbxn+D6SQX+9gV73Trgg5RFkcTggF6tXqH82aofmHqJxy2143AC93Tes0EJIpFp7
         OYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692370887; x=1692975687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Kje/PV1xglcggGamancPzKU941PuqAntqW1KXqMmmM=;
        b=UdmvIty0SGG81fR/3oS//e6mgMUFkaaSakxc8W6Eda4QRCsj1YlNRhoG+PcyzsJhAR
         /i3FxiIvBTqGdE0/BkQSGgS8Ti3Qa5xPBGlc9mt2WpLFNuHdBKkEoRuLOIpMi82a9jhY
         5UfOxQXK1usvIayOw/xNRKce/VMs/xPsJdeFjFdinFf6Fv8qBEU+BTF5U0VRWuXxdkzT
         K9Pgv/JMq+J1I1CIGcwpDB9meBcSLQSTVUy4KTP8BEGDFhV7Avc0nc4CKk86PH3mcFWi
         m28P58qVEjvPXaba2okC0T6gbn10Fw1k+xJx8k3wXt2FSJakSy2oSau6pWoWVXh//E82
         H95g==
X-Gm-Message-State: AOJu0YyRm3O87LfTH9gkbq6cqfozpcDC1F45FmQVJOw3uZc2utuwhPFg
        8lfrrFyKTSt0c1QXcoBF04Dx26RUt4KXmcKKtcQKDaf0PnJWMlVMRKZFXfcjlRuHViQ2pzi0esL
        vHc8GU3OSohXiePzxKe1oe7ENh17D5jf5+SY3kijV
X-Google-Smtp-Source: AGHT+IExbWFGOiSmGJviT1YFZ8O5IMRVDMqA6foYBWIUO8proNm6fVkIZVAtbQxwMZj5myTIHO6pJKW9eOonKbQ98sE=
X-Received: by 2002:a05:6830:1d95:b0:6bc:f6d0:87d2 with SMTP id
 y21-20020a0568301d9500b006bcf6d087d2mr2455379oti.38.1692370887136; Fri, 18
 Aug 2023 08:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
In-Reply-To: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
From:   Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>
Date:   Fri, 18 Aug 2023 17:01:16 +0200
Message-ID: <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
Subject: Re: qemu cxl memory expander shows numa_node -1
To:     Sajjan Rao <sajjanr@gmail.com>
Cc:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,

I am not an expert (and not 100% sure if that's what you want to do),
but here's one way to get your configuration to work:
1. Disable KVM.
2. Remove the CXL NUMA node from the QEMU command.
3. Use the ndctl utilities in the guest to initialize your CXL memory
and associated NUMA node.

More specifically, I changed your QEMU command as follows:

    qemu-system-x86_64 \
     -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
     -machine type=3Dq35,cxl=3Don \
     -m 8G \
     -smp cpus=3D8 \
     -object memory-backend-ram,size=3D4G,id=3Dm0 \
     -object memory-backend-ram,size=3D4G,id=3Dm1 \
     -object memory-backend-ram,size=3D2G,id=3Dcxl-mem1 \
     -numa node,memdev=3Dm0,cpus=3D0-3,nodeid=3D0 \
     -numa node,memdev=3Dm1,cpus=3D4-7,nodeid=3D1 \
     -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D192.168.0.9  \
     -device virtio-net-pci,netdev=3Dnet0 \
     -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
     -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassis=3D0,slot=
=3D2 \
     -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl-mem1,id=3Dc=
xl-mem1 \
     -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
     -nographic

In the guest, install ndctl: https://github.com/pmem/ndctl

After that, you should be able to see the CXL memory:
    root@cxl-img:~# cxl list
    [
      {
        "memdev":"mem0",
        "ram_size":2147483648,
        "serial":0,
        "host":"0000:0d:00.0"
      }
    ]

And initialize it as RAM:
    root@cxl-img:~# cxl create-region -d decoder0.0 -s 2147483648 -t ram
    ...

root@cxl-img:~# lsmem --output-all
    RANGE                                  SIZE  STATE REMOVABLE BLOCK
NODE  ZONES
    0x0000000000000000-0x0000000007ffffff  128M online       yes     0
   0   None
    0x0000000008000000-0x000000007fffffff  1.9G online       yes  1-15
   0  DMA32
    0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
   0 Normal
    0x0000000180000000-0x000000027fffffff    4G online       yes 48-79
   1 Normal
    0x0000000290000000-0x000000030fffffff    2G online       yes 82-97
   2 Normal

    Memory block size:       128M
    Total online memory:      10G
    Total offline memory:      0B


    root@cxl-img:~# cat /proc/iomem
    ...
    290000000-38fffffff : CXL Window 0
      290000000-30fffffff : region0
        290000000-30fffffff : dax0.0
          290000000-30fffffff : System RAM (kmem)


Then you can generate traffic in the CXL NUMA node, for example:

    root@cxl-img:~# numactl --membind 2 ls

Note: The above is with linux v6.4.11.

Hope that helps!

Kind regards,
Dimitris







On Fri, Aug 18, 2023 at 11:39=E2=80=AFAM Sajjan Rao <sajjanr@gmail.com> wro=
te:
>
> Hello,
>
> I have a qemu + cxl configuration coming up with one configured type 3
> device. My goal is to generate some cxl.mem traffic in this
> configuration.
> However the numa_node is always showing as -1. I have tried various
> qemu command line parameters including to explicitly set numa_node for
> cxl devices.
>
> Here is my qemu command line
> --------
> qemu-system-x86_64 \
>  -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
>  -machine type=3Dq35,accel=3Dkvm,cxl=3Don \
>  -m 10G \
>  -smp cpus=3D8 \
>  -object memory-backend-ram,size=3D4G,id=3Dm0 \
>  -object memory-backend-ram,size=3D4G,id=3Dm1 \
>  -object memory-backend-ram,size=3D2G,id=3Dcxl-mem1 \
>  -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
>  -numa node,memdev=3Dm1,cpus=3D2-3,nodeid=3D1 \
>  -numa node,memdev=3Dcxl-mem1,cpus=3D4-7,nodeid=3D2 \
>  -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D192.168.0.9  \
>  -device virtio-net-pci,netdev=3Dnet0 \
>  -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
>  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassis=3D0,slot=
=3D2 \
>  -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl-mem1,id=3Dcxl=
-mem1 \
>  -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
>  -enable-kvm \
>  -nographic
> -----
>
> I see that the cxl device is listed in lspci output
> ------
> #lspci | grep -i cxl
> 0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
>
> #lspci -s 0d:00.0 -vvv | grep -i numa
> #
>
> -------
>
> sysfs output
> ----------
> #cat /sys/bus/cxl/devices/mem0/numa_node
> -1
> --------
>
> numactl output
>
> ------------------
> #numactl -H
> available: 3 nodes (0-2)
> node 0 cpus: 0 1
> node 0 size: 3910 MB
> node 0 free: 3776 MB
> node 1 cpus: 2 3
> node 1 size: 4031 MB
> node 1 free: 3927 MB
> node 2 cpus: 4 5 6 7
> node 2 size: 2011 MB
> node 2 free: 1785 MB
> node distances:
> node   0   1   2
>   0:  10  20  20
>   1:  20  10  20
>   2:  20  20  10
> -------------------
>
> The numa_node 2 is expected to be mapped to a CXL device, I do see
> some activity in numastat output, but it's unclear if this is really
> mapped to the CXL device since the device itself says numa_node is -1
> (expected to show 2).
>
> Has anybody seen this behavior? Any help will be greatly appreciated.
>
> Thanks,
> Sajjan

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
