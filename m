Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4519EC001DE
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Aug 2023 09:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351191AbjHRJjD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359356AbjHRJiz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Aug 2023 05:38:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EBE3C22
        for <linux-cxl@vger.kernel.org>; Fri, 18 Aug 2023 02:38:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so828043a12.3
        for <linux-cxl@vger.kernel.org>; Fri, 18 Aug 2023 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692351498; x=1692956298;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XGyW10KDeWv0/D6IJlqRND9upwd8u6YJY2ow3DYdhJQ=;
        b=QjA473/zzfGb7EtOrsiTJEMt11BUztebcxDndq0hb6FusLEFneCgXTqfhQoqb88CHl
         I/UII4/c1FWTPWueU6UDif2F1XU+PsMWfp8ekM4lFlVNLLNn62jUPY7DSaA2oAJX/3jG
         F3KOQ4bLAg3e/Pc5dlmeUroj1v5k/ko/h/xKwBfl3KjOthjuAEMlZKKbyLT161FMf14q
         /6few/eIrYFAE+fP+fxudJwHIhnojCf3GLGsiPUfgHfgywONKxxMNX4oKmUxNq8Ifzof
         nILI2gv66jpwWtqOh2RFZHofd194ic3aoFBBdvfZ9khSU5/Vze1wwFL85t277Plp/BSd
         kyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692351498; x=1692956298;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGyW10KDeWv0/D6IJlqRND9upwd8u6YJY2ow3DYdhJQ=;
        b=OvmmsSoPf2M1m3PydwEu+TyyLep5seJNnU9a7FBDhP2heV/gNTKuxNLwAWYFmBFL5B
         5tbgR3hICXk4bOmslFH3gFHmRmk27t3ySF79fyiBXkEAJPTNl+Ym9Prujo0Kv/I/q/9t
         mG/IvAuL4AO0BfdSYcdf0IczsM/u4KasavsCZ6ZGaKy/CQxCCIcP0eIi7bsa1lY5XXfO
         Vm3q/fft+6iVOGp/CWk6sOWOl8ppP11T5/w3HLtGisTNfzQP8eOc9yuZ9Im1vR5cU1gB
         L/VNkhJi0xGQyJPvHj+4n5TSE/CBeR0q3JWyZM8Zuqh8XHsqoz/4XMNgORDZ3ZrmRcUB
         RZdQ==
X-Gm-Message-State: AOJu0YyljFZvVSpgNCKywSvrk5RoCOSG8+rxvN+Hj31GTB6TD5YhY/W8
        4p/0eisL7Oi7uOlQ0zNHdj780RU2izw3XRsVg9OQnAOK93w=
X-Google-Smtp-Source: AGHT+IH+zFmOS74m5R8eKmZ1sJhIUyCYO4AbXWD/QTfiScY3jbQ4vE4k6i7Hvf5SRf/DvxWe6I/CAkCuZaE3157+a6E=
X-Received: by 2002:aa7:d4d9:0:b0:522:4dd0:de72 with SMTP id
 t25-20020aa7d4d9000000b005224dd0de72mr1720242edr.27.1692351497817; Fri, 18
 Aug 2023 02:38:17 -0700 (PDT)
MIME-Version: 1.0
From:   Sajjan Rao <sajjanr@gmail.com>
Date:   Fri, 18 Aug 2023 15:08:06 +0530
Message-ID: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
Subject: qemu cxl memory expander shows numa_node -1
To:     linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,

I have a qemu + cxl configuration coming up with one configured type 3
device. My goal is to generate some cxl.mem traffic in this
configuration.
However the numa_node is always showing as -1. I have tried various
qemu command line parameters including to explicitly set numa_node for
cxl devices.

Here is my qemu command line
--------
qemu-system-x86_64 \
 -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
 -machine type=q35,accel=kvm,cxl=on \
 -m 10G \
 -smp cpus=8 \
 -object memory-backend-ram,size=4G,id=m0 \
 -object memory-backend-ram,size=4G,id=m1 \
 -object memory-backend-ram,size=2G,id=cxl-mem1 \
 -numa node,memdev=m0,cpus=0-1,nodeid=0 \
 -numa node,memdev=m1,cpus=2-3,nodeid=1 \
 -numa node,memdev=cxl-mem1,cpus=4-7,nodeid=2 \
 -netdev user,id=net0,net=192.168.0.0/24,dhcpstart=192.168.0.9  \
 -device virtio-net-pci,netdev=net0 \
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
 -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
 -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-mem1 \
 -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
 -enable-kvm \
 -nographic
-----

I see that the cxl device is listed in lspci output
------
#lspci | grep -i cxl
0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)

#lspci -s 0d:00.0 -vvv | grep -i numa
#

-------

sysfs output
----------
#cat /sys/bus/cxl/devices/mem0/numa_node
-1
--------

numactl output

------------------
#numactl -H
available: 3 nodes (0-2)
node 0 cpus: 0 1
node 0 size: 3910 MB
node 0 free: 3776 MB
node 1 cpus: 2 3
node 1 size: 4031 MB
node 1 free: 3927 MB
node 2 cpus: 4 5 6 7
node 2 size: 2011 MB
node 2 free: 1785 MB
node distances:
node   0   1   2
  0:  10  20  20
  1:  20  10  20
  2:  20  20  10
-------------------

The numa_node 2 is expected to be mapped to a CXL device, I do see
some activity in numastat output, but it's unclear if this is really
mapped to the CXL device since the device itself says numa_node is -1
(expected to show 2).

Has anybody seen this behavior? Any help will be greatly appreciated.

Thanks,
Sajjan
