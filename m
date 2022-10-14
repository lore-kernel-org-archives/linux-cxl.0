Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B03CC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Oct 2022 00:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJNAU5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 20:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJNAUX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 20:20:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F787A503
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 17:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjMLqdIyesnfHrUcB0Rr9MuTj08E7Rkj+0hgnf+tTc/Oro9FDB1qX4v2GUq3fm2w/XW7O3qJKsxtt7NV+4FAteP3gKJEQ5ULcjHKiFt3buvjH87hSECBRTGm/tLl/QnLC2YmFdbM5Cd3yAfCPWjILKFSFSYJAlFGB6mmN+kl3BqNMhO/qjQ83XpPBpi+KuWQa6g2rALl1k5neW14kQeCvNix26EbWMrmBcriMKBu7M+9xx++kSNtq7HdO8YbEo97C+dGJPoG6sG9WcmKrsGYoTihq1NcpxemhZ5fVlYk2jyumh/tAc3DiAxBwfVxru92CX17WGnuZXiXTFpW6GG+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiFeUCBLecNzFyn5JMprLQQCTHKWzg0uPUMg4B1xfCg=;
 b=cj7Q95rBJl1/g3BjKMIKOFES5IbpbgVO6focFYEpSWbkwTQGYAyOS5uywAtUXUnKxGJpLd1xkBJJ94iu3/qJ61vULngxbQ53MnM7kR1rGIyrftQvW5piXcl3oiY9BHOwgiEBBPT9/wzwXbZc0xMx4Aaez21C6+cQSUV9b8AFpYetJTkJF4JtXuAqY80N8OThBxhu/qZ4afQHHh34LX7lfeoCZ4IAlU0Cu0+4sPn0uKLrqvO57idfqic8GXeIm12vSfDs21cvVDjE7uL8LI4yYEcfl+m8waU+/qfu6o6qFZWGLsfIBlKbWw1TbaV3pPeLE9IMMArceNUN5ywiJmVA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiFeUCBLecNzFyn5JMprLQQCTHKWzg0uPUMg4B1xfCg=;
 b=rgGRgECODjuwKQdwGgpoGuqL3VWg+NTja8HgcrSdKrbpg0RSRfSsaieVkcc4TBuIMHh1t6qVIgTciFBDszfhfcK05q+vV2+OCdsZhDgkl89NxawJPV9CbbKtxkj9p/SB1+f6oXfdv0CXYhdUwg4xg6EGKxJyNRX20bYNm18/trE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DM4PR17MB5897.namprd17.prod.outlook.com (2603:10b6:8:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Fri, 14 Oct
 2022 00:19:58 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::655f:bfa9:e33a:5af4%5]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 00:19:56 +0000
Date:   Thu, 13 Oct 2022 20:19:56 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: [BUG] cxl,i386: e820 mappings may not be correct for cxl
Message-ID: <Y0irLOclCJDT9KEH@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BL0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:2d::23) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DM4PR17MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: a48af3cb-2a6a-457e-d4e2-08daad79d2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1IXileS//ZnFcQY5HwHjJUg3FXmnoSSDSCnbjAK+EovgYxA+hlQVS1A9M8bdNF5tHGCwnSZytBC6+c1MIjQkxhYW0DFYrPDVG6mHTURytlIFVpzVtEY+CcrrlLxvIJ4vz3IcL6FVMXfR+42gae4EixJYdDERtiUqWNGYG5gAY44uBIj66vL4t/3YHi8hkrVC9sQuJtuRzfcr3T9VPTyZbvwj7+3HIUax1GfuJg7LJd77e+LSCqUjI+/t9dgJwjLa1NVMwvuOU2J/0mecQvM0pmwsYcAh+/eW2pcHGjYq/2PG3EiryF9l8q+1l+jMfqNJX5DuEnRK/NUhkzfvODQeCvgVPU/ZyWzUdLwfTR572tmawac5s0RdBLz1P3l3MXx06JYhQZbqjGfrEUNMWrbiLQejxC9ujuSKBHp3bwJWv04j6f2nAaIzvuH9tyE9Lz60IXaKS4YZgtJ3rKEt7Sb3v8HhCxPlMyX9Cm+dxdxoO0gtxwZmHWYg4S68+yxbEzaZa+rv1CFHyJpbRl8mbkUmPUU4pE5YUsEx53MoKDI/L0wzEXSz1aKUHGYl+LbopA8/OdZJo3vQsHaFc5lIVLqOsmUPFZWi3XZTDo/9Hf6GlmGr27lGHk7LCNu34bv51Nt92jUt9ovyjYXJkwphoeACLh61lBSZb2C+8J2sJvttKXEnkX7X0oAzDPvnXfk+ddykxKmULRa1J0GVP9RdTQYIc5SEVfLDoLBiLbdtGCQrbuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39840400004)(366004)(136003)(376002)(451199015)(2906002)(41300700001)(316002)(66946007)(8676002)(8936002)(478600001)(6512007)(66556008)(4326008)(44832011)(6486002)(966005)(5660300002)(6916009)(54906003)(26005)(66476007)(86362001)(36756003)(2616005)(83380400001)(186003)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ZmoUZbn2QGb4oiI2CgeW3P9iovObK4l75Td6dbLWqrpTytZNMkHXQHlnk+e?=
 =?us-ascii?Q?/fzBgf4BfLY9jLE9MSdhhGHPQUzFxQFfpf/kVaGHbht0zodTmq1FnkrMi0YR?=
 =?us-ascii?Q?3+nFCtcoO4pvnO2JqEyV3GTEK2GzWfHrY/m/jzm+ZthgGaUOYHWKJMreOrK2?=
 =?us-ascii?Q?pgPq7sDZ0fV5busvn5CDeTJ6p718eaegRVLn1S3fQvzeGM1rZUQl++bgEpfY?=
 =?us-ascii?Q?2nxowRJMTrMZ0xOh/iZLoV5PnmjEDbMexIP+hL4t7N/CeID8BELxJtNvAlOQ?=
 =?us-ascii?Q?wXkddci/yFHiCoDwRDZe6ZpjbOKrAYde2HSGgfGFEeo5FJ0q0aeOXLVWvYql?=
 =?us-ascii?Q?j4tHtmbyxISf6u5C34pHNp8fyapWi6wmDhoIrCg/wPkOiYbGOzF5fqNBAQhf?=
 =?us-ascii?Q?zEZ6U0wKlmFFpA5JOGCk7ehyvNsFMQZEnDEV8CKCHlMoTy23xVbTJkGSNU4E?=
 =?us-ascii?Q?V1BZ5I4B+Gp0uQ2DcrfDnKCuD8dDffhXXM0fgAhcwjMIZt9U9Uwp92m4E4Gl?=
 =?us-ascii?Q?uZqVSk16BRvTfO0Cqxiv11eZYKamENMK9SHfWtFbq4dPlTEqiA7VleCfXKI1?=
 =?us-ascii?Q?xOl5gCtS7Uoba7sKtbLfg3LmUZGuSjA+kjiH5HklV92vVadW53oLStO1c/H9?=
 =?us-ascii?Q?k3ZeJkR69p2mvqTyo9h7P9jlizCD3VApkbPwCta/Mn93XeBiO0ZG/z9MDppi?=
 =?us-ascii?Q?jlRmfas4GcZdcw18BWFp6yqY8iBCk9TTKG9OBFLj3P1PbxwuAH9L67uZcbfB?=
 =?us-ascii?Q?d1yGzv1K6IwgRKm2C7rcmYsOChT9B6n83ih3F+QMmJhLxiV1q6rbSVrTjEJT?=
 =?us-ascii?Q?2kzjnAWIObxSboYM4GgDweQobTnvJWbF1+HPqHX84SouNUXZFqd9SdGRKoOf?=
 =?us-ascii?Q?gvOLpynV+ppOmrMB2UWoZKCrOWRTHzavf8UP1dmOBxah6mn17VPeAYJnkfQ2?=
 =?us-ascii?Q?LRw/2A0usRR9bYtrvZs8LsAmu6V3Ap7Nmf/ZA35rsj6kX94G631dJ3UV6UOY?=
 =?us-ascii?Q?Uz9gPToFcYF++SbdoccM2TuhMygJ7tqzh13ISI075zgP3g9Xz/lLc934JCNx?=
 =?us-ascii?Q?MDTikCEWH+GYlcXyUfEbTlUtwswWRAxg+GhBOpsmbDjtkBuEISAdN0+WskT4?=
 =?us-ascii?Q?Y8t38jG5LlT6zPgCnFWWx8xANV0V5brgQhpoNMeloXukqIfIjiOVL2PPVRNu?=
 =?us-ascii?Q?Ctc3j2BzG6GgjryAG0wfRN5VBd7ggWbfc1peRuspaRl784wEdgRrBAoSfqQK?=
 =?us-ascii?Q?ZijTe1MA0DqJiVWwvs8BWaZUZWXKr9NlVteBeBo0eestqNTjZKY+SERrzkHH?=
 =?us-ascii?Q?v3puR+j4IqMcdSB8Z41Zv3FyV+zi/57lz/ggeYJnxCrUUXAuE7V+7YEFgdMn?=
 =?us-ascii?Q?tZV5DGZVvutnZe0I9NZ5d0weNH9M5FOnZpBZCuvsn0sY6hjrnzSgdeE9Ta4h?=
 =?us-ascii?Q?+PcimPlKJ/y94iIaV+SfT2xTqxTR1QPteg9TIn+KaEnMY4+3XlVDVHjXoUGc?=
 =?us-ascii?Q?GfIIgQEiACL4RcUPGVKbbjbbjUqWHjlXeogDppIIzkTc0kOV4+9elVi8ahED?=
 =?us-ascii?Q?Koh+fgwB6oloiYMiiOoEgA0wJJtr3kPF+QeH7d82EDX6RAj7ar9KQPmHD/Z+?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48af3cb-2a6a-457e-d4e2-08daad79d2f1
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 00:19:56.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnwKrwTobpG9xTEEX+4vDtaB/RFQT0xfis6jxOBPGPd8tXGEuuH9nwyzz7Ly4ywbvAK7Ild1e5K3/CHfkoDdaveyO6tZs794AvHTIPn1WyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB5897
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Context included below from prior discussion
    - `cxl create-region` would fail on inability to allocate memory
    - traced this down to the memory region being marked RESERVED
    - E820 map marks the CXL fixed memory window as RESERVED


Re: x86 errors, I found that region worked with this patch. (I also
added the SRAT patches the Davidlohr posted, but I do not think they are
relevant).

I don't think this is correct, and setting this to E820_RAM causes the
system to fail to boot at all, but with this change `cxl create-region`
succeeds, which suggests our e820 mappings in the i386 machine are
incorrect.

Anyone who can help or have an idea as to what e820 should actually be
doing with this region, or if this is correct and something else is
failing, please help!


diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 566accf7e6..a5e688a742 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1077,7 +1077,7 @@ void pc_memory_init(PCMachineState *pcms,
                 memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
                                       "cxl-fixed-memory-region", fw->size);
                 memory_region_add_subregion(system_memory, fw->base, &fw->mr);
-                e820_add_entry(fw->base, fw->size, E820_RESERVED);
+                e820_add_entry(fw->base, fw->size, E820_NVS);
                 cxl_fmw_base += fw->size;
                 cxl_resv_end = cxl_fmw_base;
             }


On Mon, Oct 10, 2022 at 05:32:42PM +0100, Jonathan Cameron wrote:
> 
> > > but i'm not sure of what to do with this info.  We have some proof
> > > that real hardware works with this no problem, and the only difference
> > > is that the EFI/bios/firmware is setting the memory regions as `usable`
> > > or `soft reserved`, which would imply the EDK2 is the blocker here
> > > regardless of the OS driver status.
> > > 
> > > But I'd seen elsewhere you had gotten some of this working, and I'm
> > > failing to get anything working at the moment.  If you have any input i
> > > would greatly appreciate the help.
> > > 
> > > QEMU config:
> > > 
> > > /opt/qemu-cxl2/bin/qemu-system-x86_64 \
> > > -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=d\
> > > -m 2G,slots=4,maxmem=4G \
> > > -smp 4 \
> > > -machine type=q35,accel=kvm,cxl=on \
> > > -enable-kvm \
> > > -nographic \
> > > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 \
> > > -object memory-backend-file,id=cxl-mem0,mem-path=/tmp/cxl-mem0,size=256M \
> > > -object memory-backend-file,id=lsa0,mem-path=/tmp/cxl-lsa0,size=256M \
> > > -device cxl-type3,bus=rp0,pmem=true,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 \
> > > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=256M
> > > 
> > > I'd seen on the lists that you had seen issues with single-rp setups,
> > > but no combination of configuration I've tried (including all the ones
> > > in the docs and tests) lead to a successful region creation with
> > > `cxl create-region`  
> > 
> > Hmm. Let me have a play.  I've not run x86 tests for a while so
> > perhaps something is missing there.
> > 
> > I'm carrying a patch to override check_last_peer() in
> > cxl_port_setup_targets() as that is wrong for some combinations,
> > but that doesn't look like it's related to what you are seeing.
> 
> I'm not sure if it's relevant, but turned out I'd forgotten I'm carrying 3
> patches that aren't upstream (and one is a horrible hack).
> 
> Hack: https://lore.kernel.org/linux-cxl/20220819094655.000005ed@huawei.com/
> Shouldn't affect a simple case like this...
> 
> https://lore.kernel.org/linux-cxl/20220819093133.00006c22@huawei.com/T/#t
> (Dan's version)
> 
> https://lore.kernel.org/linux-cxl/20220815154044.24733-1-Jonathan.Cameron@huawei.com/T/#t
> 
> For writes to work you will currently need two rps (nothing on the second is fine)
> as we still haven't resolved if the kernel should support an HDM decoder on
> a host bridge with one port.  I think it should (Spec allows it), others unconvinced.
> 
> Note I haven't shifted over to x86 yet so may still be something different from
> arm64.
> 
> Jonathan
> 
> 
