Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E81C77B75
	for <linux-cxl@archiver.kernel.org>; Tue,  9 May 2023 18:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjEISqB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 May 2023 14:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEISqA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 May 2023 14:46:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1CD2690
        for <linux-cxl@vger.kernel.org>; Tue,  9 May 2023 11:45:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ad9f2926adso14919861fa.1
        for <linux-cxl@vger.kernel.org>; Tue, 09 May 2023 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683657956; x=1686249956;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdslXKb0e2MCTKERiSB58qFvN/JLW//H8+9KPDoDy2k=;
        b=LeAXifmBdA3ie4WEE3y9jW1HDAjyMkdXwAFUKmLFrgqu0PbDPbmYcRiBQIhz+obvrF
         J6fURLgZH4yhHzUOyVShGE6RRAc9Y7Dnn28zfQGezeofciIygh9EQxY7Tz5BTxLIF/Pn
         GUyvN0TXiCRcbjZyd2UNKJTFSO6/OSpOx6AnXS4tqHXAa/GZyB3OecPYIFpwbnf2Tgvj
         nlnh2HE3a8Bg5MsVFQenws8nygjSlzPcJQPqrYZ+H+1oI2J4uCbIi+VcvdIe+IwVJdNO
         BbFrlvN5+lVLgc/gQE9iSXgTFUI1+bQ9aHfqwUMWtGMM6lbQDvsn1oZj50N/WJ1AEGhg
         tF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683657956; x=1686249956;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdslXKb0e2MCTKERiSB58qFvN/JLW//H8+9KPDoDy2k=;
        b=Mx1t0Mzcs2R5AhZjvbqIdJkwdu6HNbT5Qqp6J56QOXzp/cfhF+KWVNfQjgHBDqM5SD
         ao3RecRd4/KCm8sKjx7alcm4LfDg0uHLynyY23MBQqxvaZy9chEqqu1Akg0j85cDZwSG
         2ewzjgapS990C4jrJGlpjgIkC2CwyYTuiFJjjICMv5wy+ShyYWQ1hGkN5xppTjtLDWbm
         /IcIEy5cwv1vNl7yjeFGuQR3Ou3ZmgTazfFONAseW4+gVM1wRdvdMuHkTET3tohMsc9e
         0kTwsuy6nliTkpwZpZ7H0is7tVZTZAiWb79FKrQR0AHlwp+P05+qSoiLgbpg5wqM7ofp
         9+/Q==
X-Gm-Message-State: AC+VfDy1h7YsF6jmdZ6+XD1MOzpgIBF0ZjOlFcsRR9dfhBueeYjHmy3Z
        yFxffA0M77U+IvdmDg2Lr8PGod7X2zlVUgEZ61I=
X-Google-Smtp-Source: ACHHUZ7rTz0nhvAbnz1Cw3/6dEYU1ydBszAnoeN/SEYgXVSAIaozvKIJtSOsLZ1jSDnP4UvYASyYL/FowOzqqeAZKwM=
X-Received: by 2002:a2e:9c86:0:b0:2a9:ebd4:1c42 with SMTP id
 x6-20020a2e9c86000000b002a9ebd41c42mr1103168lji.11.1683657955900; Tue, 09 May
 2023 11:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230414084120epcas2p37f105901350410772a3115a5a490c215@epcas2p3.samsung.com>
 <20230221014114.64888-1-ks0204.kim@samsung.com> <20230414084120.440801-1-ks0204.kim@samsung.com>
In-Reply-To: <20230414084120.440801-1-ks0204.kim@samsung.com>
From:   MTK <kim1158@gmail.com>
Date:   Wed, 10 May 2023 03:45:45 +0900
Message-ID: <CAARenATFs8rPcmjy7Zo4SSm5WH=ODwOcG6ip8_jTthT88PKGLg@mail.gmail.com>
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
To:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        mhocko@kernel.org, "david@redhat.com" <david@redhat.com>,
        willy@infradead.org, sj@kernel.org, ks0204.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello all,

I appreciate all of the feedbacks and questions while my session at
5/8 13:00 PDT.
For those who are interested, please find my slide at [2].
My apology that I failed to manage the time slot so that I missed some
contents prepared.

Program Committee kindly allows me a make-up session to spend a few more mi=
nutes
around 5/10 15:30 PST after MM process: Akpm. Please find the schedule[1].
Thank you Dan Williams and Michal Hocko.

The remaining dialog I keep in mind now is
- more sync-up of CXL requirements to kernel
- what ZONE_EXMEM do for the requirements
- quick answers for the feedbacks I missed at 5/8
- alignment with kernel movement


[1] https://github.com/OpenMPDK/SMDK/wiki/93.-%5BLSF-MM-BPF-TOPIC%5D-SMDK-i=
nspired-MM-changes-for-CXL
[2] https://docs.google.com/spreadsheets/d/1tIDYHgLhhcetoXtgyvcoM6YZWWHcVLd=
NYipBq2dH-_k/edit#gid=3D0

On Fri, Apr 14, 2023 at 5:45=E2=80=AFPM Kyungsan Kim <ks0204.kim@samsung.co=
m> wrote:
>
> >CXL is a promising technology that leads to fundamental changes in compu=
ting architecture.
> >To facilitate adoption and widespread of CXL memory, we are developing a=
 memory tiering solution, called SMDK[1][2].
> >Using SMDK and CXL RAM device, our team has been working with industry a=
nd academic partners over last year.
> >Also, thanks to many researcher's effort, CXL adoption stage is graduall=
y moving forward from basic enablement to real-world composite usecases.
> >At this moment, based on the researches and experiences gained working o=
n SMDK, we would like to suggest a session at LSF/MM/BFP this year
> >to propose possible Linux MM changes with a brief of SMDK.
> >
> >Adam Manzanares kindly adviced me that it is preferred to discuss implem=
entation details on given problem and consensus at LSF/MM/BFP.
> >Considering the adoption stage of CXL technology, however, let me sugges=
t a design level discussion on the two MM expansions of SMDK this year.
> >When we have design consensus with participants, we want to continue fol=
low-up discussions with additional implementation details, hopefully.
> >
> >
> >1. A new zone, ZONE_EXMEM
> >We added ZONE_EXMEM to manage CXL RAM device(s), separated from ZONE_NOR=
MAL for usual DRAM due to the three reasons below.
> >
> >1) a CXL RAM has many different characteristics with conventional DRAM b=
ecause a CXL device inherits and expands PCIe specification.
> >ex) frequency range, pluggability, link speed/width negotiation, host/de=
vice flow control, power throttling, channel-interleaving methodology, erro=
r handling, and etc.
> >It is likely that the primary usecase of CXL RAM would be System RAM.
> >However, to deal with the hardware differences properly, different MM al=
gorithms are needed accordingly.
> >
> >2) Historically, zone has been expanded by reflecting the evolution of C=
PU, IO, and memory devices.
> >ex) ZONE_DMA(32), ZONE_HIGHMEM, ZONE_DEVICE, and ZONE_MOVABLE.
> >Each zone applies different MM algorithms such as page reclaim, compacti=
on, migration, and fragmentation.
> >At first, we tried reuse of existing zones, ZONE_DEVICE and ZONE_MOVABLE=
, for CXL RAM purpose.
> >However, the purpose and implementation of the zones are not fit for CXL=
 RAM.
> >
> >3) Industry is preparing a CXL-capable system that connects dozens of CX=
L devices in a server system.
> >When a CXL device becomes a separate node, an administrator/programmer n=
eeds to be aware of and manually control all nodes using 3rd party software=
, such as numactl and libnuma.
> >ZONE_EXMEM allows the assemble of CXL RAM devices into the single ZONE_E=
XMEM zone, and provides an abstraction to userspace by seamlessly managing =
the devices.
> >Also, the zone is able to interleave assembled devices in a software way=
 to lead to aggregated bandwidth.
> >We would like to suggest if it is co-existable with HW interleaving like=
 SW/HW raid0.
> >To help understanding, please refer to the node partition part of the pi=
cture[3].
> >
> >
> >2. User/Kernelspace Programmable Interface
> >In terms of a memory tiering solution, it is typical that the solution a=
ttempts to locate hot data on near memory, and cold data on far memory as a=
ccurately as possible.[4][5][6][7]
> >We noticed that the hot/coldness of data is determined by the memory acc=
ess pattern of running application and/or kernel context.
> >Hence, a running context needs a near/far memory identifier to determine=
 near/far memory.
> >When CXL RAM(s) is manipulated as a NUMA node, a node id can be function=
 as a CXL identifier more or less.
> >However, the node id has limitation in that it is an ephemeral informati=
on that dynamically varies according to online status of CXL topology and s=
ystem socket.
> >In this sense, we provides programmable interfaces for userspace and ker=
nelspace context to explicitly (de)allocate memory from DRAM and CXL RAM re=
gardless of a system change.
> >Specifically, MAP_EXMEM and GFP_EXMEM flags were added to mmap() syscall=
 and kmalloc() siblings, respectively.
> >
> >Thanks to Adam Manzanares for reviewing this CFP thoroughly.
> >
> >
> >[1]SMDK: https://github.com/openMPDK/SMDK
> >[2]SMT: Software-defined Memory Tiering for Heterogeneous Computing syst=
ems with CXL Memory Expander, https://ieeexplore.ieee.org/document/10032695
> >[3]SMDK node partition: https://github.com/OpenMPDK/SMDK/wiki/2.-SMDK-Ar=
chitecture#memory-partition
> >[4]TMO: Transparent Memory Offloading in Datacenters, https://dl.acm.org=
/doi/10.1145/3503222.3507731
> >[5]TPP: Transparent Page Placement for CXL-Enabled Tiered Memory, https:=
//arxiv.org/abs/2206.02878
> >[6]Pond: CXL-Based Memory Pooling Systems for Cloud Platforms, https://d=
l.acm.org/doi/10.1145/3575693.3578835
> >[7]Hierarchical NUMA: https://blog.linuxplumbersconf.org/2017/ocw/system=
/presentations/4656/original/Hierarchical_NUMA_Design_Plumbers_2017.pdf
>
> Let us restate the original CFP as requirement point of view and the thou=
ght on that.
>
> 1) CXL DRAM pluggability
> Issue: a random unmovable allocation makes a CXL DRAM unpluggable.
> It can happen out of userspace e.g.) pinning for DMA buffer, or kernelspa=
ce e.g.) pinning for metadata such as struct page, zone, etc.
> For this matter, we should separate logical memory on/offline and physica=
l add/remove.
> Thought: a CXL DRAM should be able to be used in a selective manner, plug=
gable or unpluggable.
> But, please don't get this wrong. Those are mutual-exclusive, so it canno=
t happen at the same time on a single CXL DRAM channel.
>
> 2) CXL DRAM identifier (API and ABI)
> Issue: an user/kernel context has to use the node id of a CXL memory-node=
 to access CXL DRAM explicitly and implicitly.
> Thought: Node id would be ephemeral information. An userspace and kernels=
pace memory tiering solution need a API and/or ABI rather than node id.
>
> 3) Prevention of unintended CXL page migration
> Issue: while zswap operation, a page on near memory(DIMM DRAM) is allocat=
ed to store swapped page on far memory(CXL DRAM).
> Our thought: On the swap flow, the far memory should not be promoted to n=
ear memory accidentally.
>
> 4) Too many CXL nodes appearing in userland
> Issue: many CXL memory nodes would be appeared to userland along with dev=
elopment of a CXL capable server, switch and fabric topology.
> Currently, to lead to aggregated bandwidth among the CXL nodes, an userla=
nd needs to be aware and manage the nodes using a 3rd party SW such as numa=
ctl and libnuma.
> Thought: Kernel would provide an abstraction layer for userland to deal w=
ith it seamlessly.
> By the way, traditionally a node implies multiple memory channels in the =
same distance, and a node is the largest management unit in MM. i.e.) Node =
- Zone - Page.
> So, we thought that multiple CXL DRAMs can be appeared as a node, so the =
management dimension for single CXL DRAM should be smaller than node.
>


--=20
------------------------------------------------------------
the person who practices a truth goes toward light.
