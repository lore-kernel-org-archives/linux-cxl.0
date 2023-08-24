Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D02C71145
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Aug 2023 06:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbjHXG06 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 24 Aug 2023 02:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbjHXG03 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 24 Aug 2023 02:26:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78D3DB
        for <linux-cxl@vger.kernel.org>; Wed, 23 Aug 2023 23:26:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso3253896a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 23 Aug 2023 23:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692858384; x=1693463184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJyrLDN7fNEeSqzyBDG99X7dPjfblKHB/jfJCHZfY94=;
        b=nPkAQ/9Gd9UuYOXos2dUttdJTmqvQUuA/eotz7ymf+RhPuCtVfuYPneWDgWg3Rt9Os
         b4RPpc7R068CcZq3sHfftDW84FKD0yqQgEG2Ozv5twMUhV9x24I2ulw3VfRjbF85u7S7
         ARhExip1cr/xItg1l5cfGlVscTyJjXCAKkAn6huVuUGOA+5XaCBc8R/isxb4n3xb1I/+
         PRZqvfaWd95Hc9Y0MXGG+BcUxCrbvBJIiEW/QUqnkon27J/sTnJVcHsLVVyWKbOLwZJv
         lenL7aRC3hG5PPRcSbkBVLynNX9y0Z8rlcJCxmn5IQvISt1UrLvOLWWOuAVRTJLGfeOJ
         Cv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692858384; x=1693463184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJyrLDN7fNEeSqzyBDG99X7dPjfblKHB/jfJCHZfY94=;
        b=iaIV5GApoGEE8Uij68RIpadN2efQm2utmih9XkKpnAYNtYfvFkJP7h0M4SqtUCT5dw
         VzBmpmPEZxxbtMjZoL+L/UP4yzCDq46KKV6zHTQBfQZ1aD02g6/HhEwIUDfV+Io3eMvi
         dfA2P92OKYDyo0lXHAb+JfZ5ZaROZDVQdlLw1LHLcFCtbgzVJTxoNPShd+hNrf2KiQx0
         b4yLlh6mo2vU4tWsD/rCtSF7QG8ehACK/2JclasSVFzrdP72petgJkkqRw+yYfSo3aof
         rkCMhRdwgd7V7JmekoBiG/LmdVv+w+wwmOr5nl98JZI8ASicwS4xtE0XJFY+PqkiiSTx
         fNCA==
X-Gm-Message-State: AOJu0YxnbtVbg1rudD/tR05t9URFJwsnQiUV8LlJXJWpPBA8Z5kUD5ha
        GlZ+AhzM9eAyFFHLyxz5jVNKh9YpkK+PSxIopJU=
X-Google-Smtp-Source: AGHT+IESiuXeYNd0UibVVJknaUiIoqhJlDxGgz7E6hu8dUsBeVyZtUDpLpptBn1+A45DVFTVBsoSipNkhJZeS/p3R2k=
X-Received: by 2002:aa7:cb8f:0:b0:527:fa8d:d40b with SMTP id
 r15-20020aa7cb8f000000b00527fa8dd40bmr10735164edt.26.1692858383994; Wed, 23
 Aug 2023 23:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com> <20230823175056.00001a84@Huawei.com>
In-Reply-To: <20230823175056.00001a84@Huawei.com>
From:   Sajjan Rao <sajjanr@gmail.com>
Date:   Thu, 24 Aug 2023 11:56:12 +0530
Message-ID: <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
Subject: Re: qemu cxl memory expander shows numa_node -1
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Understood. Thank you Jonathan.

On Wed, Aug 23, 2023 at 10:21=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 23 Aug 2023 16:43:13 +0530
> Sajjan Rao <sajjanr@gmail.com> wrote:
>
> > Thank you Dimitrios. That worked!
> >
> > On Mon, Aug 21, 2023 at 4:23=E2=80=AFPM Dimitrios Palyvos
> > <dimitrios.palyvos@zptcorp.com> wrote:
> > >
> > > Hi,
> > >
> > > Ah yes, I believe you need to enable the kernel config option
> > > CONFIG_CXL_REGION_INVALIDATION_TEST for the region creation to work i=
n
> > > QEMU. The help entry of that config option gives more info on the why=
.
> > >
> > > Hope that helps!
> > >
> > > Kind regards,
> > > Dimitris
> > >
> > >
> > > On Mon, Aug 21, 2023 at 12:01=E2=80=AFPM Sajjan Rao <sajjanr@gmail.co=
m> wrote:
> > > >
> > > > Hello Dimitrios,
> > > >
> > > > Thank you for the pointers. I have the 6.4.10 kernel and modified t=
he
> > > > qemu options, but now I see an error creating the region.
> > > > Is there anything else I missed?
> > > >
> > > > [root@cxl-test /]# cxl create-region -d decoder0.0 -s 268435456 -t =
ram
> > > > [ 4144.982608] cxl region0: Failed to synchronize CPU cache state
> > > > cxl region: create_region: region0: failed to commit decode: No suc=
h
> > > > device or address
> > > >
> > > > Thanks,
> > > > Sajjan
> > > >
> > > > -- qemu
> > > >
> > > > qemu-system-x86_64 \
> > > >  -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > >  -machine type=3Dq35,cxl=3Don \
> > > >  -m 4G \
> > > >  -smp cpus=3D2 \
> > > >  -accel tcg,thread=3Dsingle \
> > > >  -object memory-backend-ram,size=3D4G,id=3Dm0 \
> > > >  -object memory-backend-ram,size=3D256M,id=3Dcxl-mem1 \
> > > >  -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
> > > >  -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D192.168.0.=
9  \
> > > >  -device virtio-net-pci,netdev=3Dnet0 \
> > > >  -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > >  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassis=3D0,=
slot=3D2 \
> > > >  -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl-mem1,id=
=3Dcxl-mem1 \
> > > >  -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > > >  -nographic
> > > >
> > > > -----
> > > >
> > > > [root@cxl-test /]# uname -r
> > > > 6.4.10-200.fc38.x86_64
> > > > [root@cxl-test /]# cxl list
> > > > [
> > > >   {
> > > >     "memdev":"mem0",
> > > >     "ram_size":268435456,
> > > >     "serial":0,
> > > >     "host":"0000:0d:00.0"
> > > >   }
> > > > ]
> > > > [root@cxl-test /]# cxl create-region -d decoder0.0 -s 268435456 -t =
ram
> > > > [ 4144.982608] cxl region0: Failed to synchronize CPU cache state
> > > > cxl region: create_region: region0: failed to commit decode: No suc=
h
> > > > device or address
> > > >
> > > > [root@cxl-test /]#
> > > >
> > > > On Fri, Aug 18, 2023 at 8:31=E2=80=AFPM Dimitrios Palyvos
> > > > <dimitrios.palyvos@zptcorp.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I am not an expert (and not 100% sure if that's what you want to =
do),
> > > > > but here's one way to get your configuration to work:
> > > > > 1. Disable KVM.
>
> Just to second this - don't use KVM and expect it to work with CXL emulat=
ion
> if you are trying to use kmem to present it as normal memory - it should =
be fine
> as long as you never run instructions resident in that memory.
>
> It will crash in nasty ways due to various issues with instruction emulat=
ion
> where it is running out of memory behind the emulated interleave decoders=
.
>
> So far we haven't cared enough to add the complexity that would be needed
> to make that work.
>
> TCG is the way to go for now.
>
> Jonathan
>
> > > > > 2. Remove the CXL NUMA node from the QEMU command.
> > > > > 3. Use the ndctl utilities in the guest to initialize your CXL me=
mory
> > > > > and associated NUMA node.
> > > > >
> > > > > More specifically, I changed your QEMU command as follows:
> > > > >
> > > > >     qemu-system-x86_64 \
> > > > >      -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > > >      -machine type=3Dq35,cxl=3Don \
> > > > >      -m 8G \
> > > > >      -smp cpus=3D8 \
> > > > >      -object memory-backend-ram,size=3D4G,id=3Dm0 \
> > > > >      -object memory-backend-ram,size=3D4G,id=3Dm1 \
> > > > >      -object memory-backend-ram,size=3D2G,id=3Dcxl-mem1 \
> > > > >      -numa node,memdev=3Dm0,cpus=3D0-3,nodeid=3D0 \
> > > > >      -numa node,memdev=3Dm1,cpus=3D4-7,nodeid=3D1 \
> > > > >      -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D192.=
168.0.9  \
> > > > >      -device virtio-net-pci,netdev=3Dnet0 \
> > > > >      -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > > >      -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassi=
s=3D0,slot=3D2 \
> > > > >      -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl-m=
em1,id=3Dcxl-mem1 \
> > > > >      -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > > > >      -nographic
> > > > >
> > > > > In the guest, install ndctl: https://github.com/pmem/ndctl
> > > > >
> > > > > After that, you should be able to see the CXL memory:
> > > > >     root@cxl-img:~# cxl list
> > > > >     [
> > > > >       {
> > > > >         "memdev":"mem0",
> > > > >         "ram_size":2147483648,
> > > > >         "serial":0,
> > > > >         "host":"0000:0d:00.0"
> > > > >       }
> > > > >     ]
> > > > >
> > > > > And initialize it as RAM:
> > > > >     root@cxl-img:~# cxl create-region -d decoder0.0 -s 2147483648=
 -t ram
> > > > >     ...
> > > > >
> > > > > root@cxl-img:~# lsmem --output-all
> > > > >     RANGE                                  SIZE  STATE REMOVABLE =
BLOCK
> > > > > NODE  ZONES
> > > > >     0x0000000000000000-0x0000000007ffffff  128M online       yes =
    0
> > > > >    0   None
> > > > >     0x0000000008000000-0x000000007fffffff  1.9G online       yes =
 1-15
> > > > >    0  DMA32
> > > > >     0x0000000100000000-0x000000017fffffff    2G online       yes =
32-47
> > > > >    0 Normal
> > > > >     0x0000000180000000-0x000000027fffffff    4G online       yes =
48-79
> > > > >    1 Normal
> > > > >     0x0000000290000000-0x000000030fffffff    2G online       yes =
82-97
> > > > >    2 Normal
> > > > >
> > > > >     Memory block size:       128M
> > > > >     Total online memory:      10G
> > > > >     Total offline memory:      0B
> > > > >
> > > > >
> > > > >     root@cxl-img:~# cat /proc/iomem
> > > > >     ...
> > > > >     290000000-38fffffff : CXL Window 0
> > > > >       290000000-30fffffff : region0
> > > > >         290000000-30fffffff : dax0.0
> > > > >           290000000-30fffffff : System RAM (kmem)
> > > > >
> > > > >
> > > > > Then you can generate traffic in the CXL NUMA node, for example:
> > > > >
> > > > >     root@cxl-img:~# numactl --membind 2 ls
> > > > >
> > > > > Note: The above is with linux v6.4.11.
> > > > >
> > > > > Hope that helps!
> > > > >
> > > > > Kind regards,
> > > > > Dimitris
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > On Fri, Aug 18, 2023 at 11:39=E2=80=AFAM Sajjan Rao <sajjanr@gmai=
l.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > I have a qemu + cxl configuration coming up with one configured=
 type 3
> > > > > > device. My goal is to generate some cxl.mem traffic in this
> > > > > > configuration.
> > > > > > However the numa_node is always showing as -1. I have tried var=
ious
> > > > > > qemu command line parameters including to explicitly set numa_n=
ode for
> > > > > > cxl devices.
> > > > > >
> > > > > > Here is my qemu command line
> > > > > > --------
> > > > > > qemu-system-x86_64 \
> > > > > >  -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > > > >  -machine type=3Dq35,accel=3Dkvm,cxl=3Don \
> > > > > >  -m 10G \
> > > > > >  -smp cpus=3D8 \
> > > > > >  -object memory-backend-ram,size=3D4G,id=3Dm0 \
> > > > > >  -object memory-backend-ram,size=3D4G,id=3Dm1 \
> > > > > >  -object memory-backend-ram,size=3D2G,id=3Dcxl-mem1 \
> > > > > >  -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
> > > > > >  -numa node,memdev=3Dm1,cpus=3D2-3,nodeid=3D1 \
> > > > > >  -numa node,memdev=3Dcxl-mem1,cpus=3D4-7,nodeid=3D2 \
> > > > > >  -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D192.16=
8.0.9  \
> > > > > >  -device virtio-net-pci,netdev=3Dnet0 \
> > > > > >  -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > > > >  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassis=
=3D0,slot=3D2 \
> > > > > >  -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl-mem=
1,id=3Dcxl-mem1 \
> > > > > >  -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > > > > >  -enable-kvm \
> > > > > >  -nographic
> > > > > > -----
> > > > > >
> > > > > > I see that the cxl device is listed in lspci output
> > > > > > ------
> > > > > > #lspci | grep -i cxl
> > > > > > 0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> > > > > >
> > > > > > #lspci -s 0d:00.0 -vvv | grep -i numa
> > > > > > #
> > > > > >
> > > > > > -------
> > > > > >
> > > > > > sysfs output
> > > > > > ----------
> > > > > > #cat /sys/bus/cxl/devices/mem0/numa_node
> > > > > > -1
> > > > > > --------
> > > > > >
> > > > > > numactl output
> > > > > >
> > > > > > ------------------
> > > > > > #numactl -H
> > > > > > available: 3 nodes (0-2)
> > > > > > node 0 cpus: 0 1
> > > > > > node 0 size: 3910 MB
> > > > > > node 0 free: 3776 MB
> > > > > > node 1 cpus: 2 3
> > > > > > node 1 size: 4031 MB
> > > > > > node 1 free: 3927 MB
> > > > > > node 2 cpus: 4 5 6 7
> > > > > > node 2 size: 2011 MB
> > > > > > node 2 free: 1785 MB
> > > > > > node distances:
> > > > > > node   0   1   2
> > > > > >   0:  10  20  20
> > > > > >   1:  20  10  20
> > > > > >   2:  20  20  10
> > > > > > -------------------
> > > > > >
> > > > > > The numa_node 2 is expected to be mapped to a CXL device, I do =
see
> > > > > > some activity in numastat output, but it's unclear if this is r=
eally
> > > > > > mapped to the CXL device since the device itself says numa_node=
 is -1
> > > > > > (expected to show 2).
> > > > > >
> > > > > > Has anybody seen this behavior? Any help will be greatly apprec=
iated.
> > > > > >
> > > > > > Thanks,
> > > > > > Sajjan
> > > > >
> > > > > --
> > > > > **CONFIDENTIALITY NOTICE:*
> > > > > *
> > > > > *The contents of this email message and any
> > > > > attachments are intended solely for the addressee(s) and may cont=
ain
> > > > > confidential and/or privileged information and may be legally pro=
tected
> > > > > from disclosure. If you are not the intended recipient of this me=
ssage or
> > > > > their agent, or if this message has been addressed to you in erro=
r, please
> > > > > immediately alert the sender by reply email and then delete this =
message
> > > > > and any attachments. If you are not the intended recipient, you a=
re hereby
> > > > > notified that any use, dissemination, copying, or storage of this=
 message
> > > > > or its attachments is strictly prohibited. *
> > >
> > >
> > >
> > > --
> > >
> > > Dimitrios Payvos-Giannas, PhD
> > >
> > > Software Engineer
> > >
> > > ZeroPoint Technologies
> > >
> > > Remove the waste.
> > >
> > > Release the power.
> > >
> > > --
> > > **CONFIDENTIALITY NOTICE:*
> > > *
> > > *The contents of this email message and any
> > > attachments are intended solely for the addressee(s) and may contain
> > > confidential and/or privileged information and may be legally protect=
ed
> > > from disclosure. If you are not the intended recipient of this messag=
e or
> > > their agent, or if this message has been addressed to you in error, p=
lease
> > > immediately alert the sender by reply email and then delete this mess=
age
> > > and any attachments. If you are not the intended recipient, you are h=
ereby
> > > notified that any use, dissemination, copying, or storage of this mes=
sage
> > > or its attachments is strictly prohibited. *
>
