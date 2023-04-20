Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0126C77B72
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Apr 2023 13:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDTNF3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Apr 2023 09:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDTNF2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Apr 2023 09:05:28 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD131702
        for <linux-cxl@vger.kernel.org>; Thu, 20 Apr 2023 06:05:23 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-555e170df98so39398107b3.10
        for <linux-cxl@vger.kernel.org>; Thu, 20 Apr 2023 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681995923; x=1684587923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE9qxIY42bzgw22EyciifVyxBC3qRkLqJQHHQ8aRT78=;
        b=SgjLYcTqjC5Ljx3Qb3XvReS9PMlTEMS4m8YcE3eE+MTLrVREBkkKhfQFj3nzoD4EGi
         kZQiRhOChaZAHzfyL3byAihjuDApKdRd2UHy1AKC6bhS+pvEnuTQZKTBPRLuWkNeRyUJ
         L2M980hYNDRddOsowD7ZWjNRi3uf2WSHqDs4AQNq1bqQwTH0FIc1RXBKDGtZvtE7qmpg
         SDGEcdrkVtsSlEAj4xeU5s8mvIk9N6Qp95/JBFt+WYcs1TZolOKSlLGFUBW7bwYfW0l/
         IdW6h4sRVK/xv5linpfpoOlUNgUp/8pWBD3T1LpcDuXi2NCj+VtuVKKLVAZG6aMV1B2k
         K8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681995923; x=1684587923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE9qxIY42bzgw22EyciifVyxBC3qRkLqJQHHQ8aRT78=;
        b=GikzAO8FwY22uGHXYjdr1BRj+GLqzz3eU3D1x1UJfthLxSBQPH2f4AmvXuzfJR7HD9
         ciDKxwhQSecsMGO3E7iSkn27B8oxfsBtxKaUUWxm8/Zpddf1CttLew9vokeM6rAvwsh7
         CrcLpcK6lOInZfPIunMfMyUdJ66QojW54aNSzj7CSEATISU8pWg1PVl3PRyvx85QLLS/
         7MrVPD3zDDUR57IfAKDUd/oeoBJIK/9FRGHup+CbdqDXX4ZqlXfGILnZIioE6JEYZNiv
         LNCLvcpvCx9XUAO/v2w/Ze98mdesw8RPmtbHwERXBqfqy14kh99d00P76vHiUuYd/48N
         n+5g==
X-Gm-Message-State: AAQBX9eABorgAHvAbnbvMfHLgx4yumb69yDjNDfrw/vow6Sd/LPo5/J9
        F9AqzYnTB/nozH3B0gHO+HwRFee/GXaw9zuZ0Ag=
X-Google-Smtp-Source: AKy350ZWrtMItfOuwzs/ISHZaFIfSA8izSUhcUpyuaMoRsVrgSFtxSUjT3cztr/bZMejr6uMmHvpq62IVaAu0WAxW2Y=
X-Received: by 2002:a81:5404:0:b0:54d:ea34:c31 with SMTP id
 i4-20020a815404000000b0054dea340c31mr723077ywb.29.1681995922911; Thu, 20 Apr
 2023 06:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWUp4qXXOsFgJu9E__Y9FGhK0ARteOF-mP1P19rd3_5K=mgNg@mail.gmail.com>
 <ttel3hfuygwhdi5ds6zmn27szvaf5holl66rvcbl55myaxarqg@cwgud6xhausf>
In-Reply-To: <ttel3hfuygwhdi5ds6zmn27szvaf5holl66rvcbl55myaxarqg@cwgud6xhausf>
From:   RAGHU H <raghuhack78@gmail.com>
Date:   Thu, 20 Apr 2023 18:35:11 +0530
Message-ID: <CAGWUp4rS8KQ2twr2f6fjcvMzFiFamOZrPw_GViopNhM-ju0zpw@mail.gmail.com>
Subject: Re: Usage of tools/testing/cxl
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks Davidlohr for responding back!

I am able to use qemu to start a guest with following configuration,
which looks more or less same thats available config in "run_qemu.sh
--cxl  --cxl-test"

-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/tmp/cxltes=
t.raw,size=3D256M
\
-object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/cxltes=
t2.raw,size=3D256M
\
-object memory-backend-file,id=3Dcxl-mem3,share=3Don,mem-path=3D/tmp/cxltes=
t3.raw,size=3D256M
\
-object memory-backend-file,id=3Dcxl-mem4,share=3Don,mem-path=3D/tmp/cxltes=
t4.raw,size=3D256M
\
-object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/lsa.ra=
w,size=3D256M
\
-object memory-backend-file,id=3Dcxl-lsa2,share=3Don,mem-path=3D/tmp/lsa2.r=
aw,size=3D256M
\
-object memory-backend-file,id=3Dcxl-lsa3,share=3Don,mem-path=3D/tmp/lsa3.r=
aw,size=3D256M
\
-object memory-backend-file,id=3Dcxl-lsa4,share=3Don,mem-path=3D/tmp/lsa4.r=
aw,size=3D256M
\
-device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
-device pxb-cxl,bus_nr=3D222,bus=3Dpcie.0,id=3Dcxl.2 \
-device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D2 \
-device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,id=3Dc=
xl-pmem0 \
-device cxl-rp,port=3D1,bus=3Dcxl.1,id=3Droot_port14,chassis=3D0,slot=3D3 \
-device cxl-type3,bus=3Droot_port14,memdev=3Dcxl-mem2,lsa=3Dcxl-lsa2,id=3Dc=
xl-pmem1 \
-device cxl-rp,port=3D0,bus=3Dcxl.2,id=3Droot_port15,chassis=3D0,slot=3D5 \
-device cxl-type3,bus=3Droot_port15,memdev=3Dcxl-mem3,lsa=3Dcxl-lsa3,id=3Dc=
xl-pmem2 \
-device cxl-rp,port=3D1,bus=3Dcxl.2,id=3Droot_port16,chassis=3D0,slot=3D6 \
-device cxl-type3,bus=3Droot_port16,memdev=3Dcxl-mem4,lsa=3Dcxl-lsa4,id=3Dc=
xl-pmem3 \
-M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.targets.1=3Dcxl.2,cxl-fmw.0.size=
=3D4G,cxl-fmw.0.interleave-granularity=3D8k


[root@cxl-test ~]# lspci
00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Contr=
oller
00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
00:02.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Conne=
ction
00:1f.0 ISA bridge: Intel Corporation 82801IB (ICH9) LPC Interface
Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH)
6 port SATA Controller [AHCI mode] (rev 02)
00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev=
 02)
0c:00.0 PCI bridge: Intel Corporation Device 7075
0c:01.0 PCI bridge: Intel Corporation Device 7075
0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
0e:00.0 PCI bridge: Intel Corporation Device 7075
de:00.0 PCI bridge: Intel Corporation Device 7075
de:01.0 PCI bridge: Intel Corporation Device 7075
df:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
e0:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
[root@cxl-test ~]#


Maybe I am wrong here but I thought I could use some of the test code
in tools/testing/cxl to understand the cxl support in kernel & qemu.

Regards
Raghu




On Wed, Apr 19, 2023 at 10:29=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.net=
> wrote:
>
> On Wed, 19 Apr 2023, RAGHU H wrote:
>
> >Hello,
> >
> >Please pardon my ignorance, but would like to understand how to use
> >tools/testing/cxl to understand the current kernel implementation of
> >cxl code base & test framework(tools/testing/cxl).
> >
> >I have tried "make -C tools/testing/selftests run_tests", but it's a
> >bit of a stretch and executes all the tests which may not be related
> >to my quest for CXL.
>
> Historically this sort of mock device comes from nfit, and it was origina=
lly
> the only way to test anything afaik, before qemu came along - and now it'=
s
> mostly useful for simpler unit-testing approaches.
>
> To properly use it I suggest reading the run_qemu.sh usage for cxl_test:
> https://github.com/pmem/run_qemu/blob/main/run_qemu.sh
>
> run_qemu.sh --cxl  --cxl-test
>
> Thanks,
> Davidlohr
