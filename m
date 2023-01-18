Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86294C32793
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 19:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjARTW1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 14:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjARTWX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 14:22:23 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7910853B33
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 11:22:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAyQqU4kHLhtNHByFNaJC5/YWbAL1Z8si2bySuD6GWtPvDnbwvJOb1mS5TKyO8jNnUlYKxHJj+3KsPOyasP7HQ7qr22HCjKUf41uOtgWxPcW8csii47ZxLJ4GzR1M4+6Ej9qgj041jub9mf2FXWicTmsGpGUG4DHYChfiKgfqnu9PouwDKkVo4VYOpS0tVkHqiEk4XZt2+LNK/PMQV1GmlFVPkOKm1AHP+GCOMfK7Z6VrvoeAwO4/Srqg/CCW/3cBBtwSPyRtyCif6YZbKtYEOPmnsBA4om1rrf15tz6LEYZDg21+sXxmMWAa65gPFVfh79OqBAZWVGk8RpsBnR4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWbogzutPyancKoCF6PKTmYO5jZdv45t/4wlNyI7PME=;
 b=Mh3CYs80LhjG7rtkeiaof2L1f3fxIj4Mi/YhH9J5r6PaPTfFt0mBsQ1UosxKt/naVpTx5JAEiii7tNFoM8PyGNdy9j2gSLLWLzMONlg8/HYa5aEAj1jrRLzYiGr/9Rwtdw/hMdDxVBHanf8VYGRF9O+C4ItiGLpRmEpJN5+NFWh+k8X7y0kGi2HjNuXgaSOpd9HwygMbMBbsakaU5RKUIJHeYr8tUz/zxaJ+mFI+BWRPkKxz9YH6cZO6lyqEdmgtojUWmJx1BiNTlue0fYapzuH/yVxHUw6tXZga58E6tWvakZ9t7eoYjo3CRFpdh9ocu8P+DkiMJPRM3lR2V561hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWbogzutPyancKoCF6PKTmYO5jZdv45t/4wlNyI7PME=;
 b=qjnzaRW2v/+CVfFAawHy8fNGlyVZMFqgT4fJeivs7Ll8+OA9g9rgqylTfDNENEwufBCZAxlDqMhLauZQT8uar5kcv0iuqLVfi/TelYWLIclKEkby88RmgFtlZ/AVOriBAlMM2/dvqecIbjuiIeWnERjK4GABnzn1moZNV7gKwAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by BY5PR17MB3762.namprd17.prod.outlook.com (2603:10b6:a03:239::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 19:22:20 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 19:22:19 +0000
Date:   Wed, 18 Jan 2023 14:22:08 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <Y8hG4OyJL7l9oD2f@memverge.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <Y8AppXP+eP9cEz+i@memverge.com>
 <20230112172130.0000391b@Huawei.com>
 <Y8CNw/fZT5fZJZcK@memverge.com>
 <20230113091213.00002146@Huawei.com>
 <Y8Foj/12QNl0C96o@memverge.com>
 <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113151206.GA20583@wunner.de>
X-ClientProxiedBy: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|BY5PR17MB3762:EE_
X-MS-Office365-Filtering-Correlation-Id: faf0ff5f-1d56-4bd4-e993-08daf9895131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2g+/O8SBrQaLjs6IzR4ct6CRq3kURVOPKMO50Vx1ZalNEw5ZPPeIjf6SAJGHSACfNdr/dCbCAn5QC06NmUFvsZ4pj4G5NCw0AjNaElxIhBYFTn3jZPJTmZRuh76n2nvqW5CUfuYqGaGba+yReg0rZsW3k//JVBsYCkUlazvumYeBpDhV0GDhZjEHbTMCkW6OE9pH/Xe5bNK1JpiUSkQ9x2jWQfA9wV7pG3QgtVVluh6yUwxFofEen6+Zcez9HTWZUnfIWS7/JE7Hz08ZwSILKJZh1peRvjpUnnUgTqtN4DPeA44Ry+sf6KT5vgNCao5B8d5Rd/kEJvKtLaNRnk654TTbEc3mEbSniAA/+Q13TeZeAzlrhv6lEf9hfTFu3IDirReM1Bk1HJlIxvkcDrVuo6fxONleIRTw+0jO0OjzGeUgC3RLsFvlhLad25SCD82VGe/6fVb2hXc7sgZJCC7L0onPpgK1Fnr/7HHlXzWo/wQGTNB7f9oh3N6a9xIavC8xb5bRcGE+TZnrOVVIilhoYP/dDVrYCL89KHwvI7gFtJC6TyKy5z0z65yrQbT55E78k1DMVE5cSK8/Z6oepQRz81cbStbVOCYwv+VjupXpXrEYM+nUSpu3GV1sEUm8DfuVQ5x961D5/SzG72JEUFS1sU7CHbMyAulpfgnv3X+lJBTlqEvEmSzCeCT54+L7mOH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(136003)(396003)(376002)(366004)(346002)(451199015)(2616005)(66946007)(66476007)(186003)(8676002)(26005)(6916009)(6512007)(4326008)(66556008)(41300700001)(36756003)(86362001)(5660300002)(8936002)(38100700002)(478600001)(54906003)(83380400001)(316002)(6506007)(6666004)(2906002)(45080400002)(6486002)(4001150100001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?soLJHl0WTVd8DI4h+5L/kSkJNXkKXEnZgnqPB2aLouB66V5cheQkg3UQ36AB?=
 =?us-ascii?Q?ioeACnFIKXvf4bFqXNoD6X+eCQnRUorYfU8U0ol/audGSMozahz6pebX9KlE?=
 =?us-ascii?Q?a18Cr2JfwtLJH+F8vsyPq5QiRO2p7uosLCZXuWLdsIrxg1SLxlZNYndLcZSS?=
 =?us-ascii?Q?ZEI5RVtG+puMR4wsI/9VZw9YF8VIQQDNxzalzT3mePkGzqBxuTHDjjIDZHbY?=
 =?us-ascii?Q?+VWPKtSFE6ZjpUAPzIm32A0bFEz947RJ7Qs9y3E+NAlvgF78yBByBERf3/Qd?=
 =?us-ascii?Q?TLJnR1Lu6bbGjq3otVk9HQfe/52ykBcAXDS7Xc1FyrfaXa5MOS3tloo1YrQ3?=
 =?us-ascii?Q?9c1l0iAgQmFaj4n5RKO7gjh80QeTAJBlzk2afwhr3BhVJ+EfkPK+67hDvw8i?=
 =?us-ascii?Q?op8DKbCHAt/Vlfw2Ag8wkxFF6QBU7vUUkn6XI4hwEAotk2RxpMoZkNSIs5Yp?=
 =?us-ascii?Q?cjCxViquGX1ppV41Pxv9inImL7e0wwPUzw/Kw2P4t2RtO8YEF04RTnzhagMT?=
 =?us-ascii?Q?56EbV2bgAsLVgVL01frRksBWCM/AZHzA1RHE/x3tjKcQWjpizOba6H3cUqsG?=
 =?us-ascii?Q?OzvzEIwXHy2dXTCkkD+dLdl5nFVPU9vLvcI0ITts3NQIg0YqqRVQVtVwim4D?=
 =?us-ascii?Q?757QH1cr4e+e2SGJvsyISWGbTXXztws/lc8SrDnWH1c5Z7wqzazERC/rM2eb?=
 =?us-ascii?Q?VqABh7IGd590z2y8TQ2K2QkBb3T7zigOAU0RTDIVT0XI6kXFDoGpB9mK2PPu?=
 =?us-ascii?Q?fFnTS7GEFAvbmgrfjmYwysAOnb4NJRqLwYPu2rC6P6Ri0HYNCSJQ0JMTDum5?=
 =?us-ascii?Q?GC0ky+Ophw95bLcUXqfrthQecA+I7A+3ge5VHM5tQcwtVqohsbXskn7VICHX?=
 =?us-ascii?Q?2txmYnrCchcD1+R3A/VMA8+Ctpo+1lICxf0S6qStC315lG1ShzYw4b5o5hSg?=
 =?us-ascii?Q?OFeC+4E0G2vO1u0FTPfdO4HGsI+P8/kK7xrf4CTiwAoCwCTv2k+gMUaf0wun?=
 =?us-ascii?Q?ikPUuPXaObve/4IR8LdqddmYk4Q1ykGMI2PtfdgxjLzCByNpdALeXHvAy3Gk?=
 =?us-ascii?Q?+MMb8MKdgvRzf9ZgZYCEazbMqWzniLV5NLlYT7hKJxXF8LUlI+inTsDse7nZ?=
 =?us-ascii?Q?Crju2odhA+kH/VAV9GtSgYH05sviAC6FJp2HmwZ8oDhjgUZ1kUdjMP+9HKwk?=
 =?us-ascii?Q?uihp8SIcUFZIcbJzXOHqeNE+jBd/CCrHXg4zD0yOINyv5lGhYZXUgHkWTwlb?=
 =?us-ascii?Q?UkVASdgB5+08XqpPMCB08Y7htnc1Fo7eLLh/STLpcgeXsd7H6NtSZZD1BG8v?=
 =?us-ascii?Q?4vLDHIx4/ikBIdBw6f6H4UQW1JhUgZTe65tANdTVldB4DK+EAr0D3jshBGQR?=
 =?us-ascii?Q?ttKy1a6jGSYcQn53tAk8wlOx0b64sjta8eOWFx9aWx46z2JMqLXi4kE3JemJ?=
 =?us-ascii?Q?05PaE4Yj46ycmOAdC+86fh3q9UsA+lTFo0eDnX4B2g5kjshOYkLWaAQodfKi?=
 =?us-ascii?Q?jIYJh+5cG5lKEBrBQ8Rhp9/ToXahp/wzz8e9d3uRwE7CfcS9klH5VSyxk7W1?=
 =?us-ascii?Q?9VOpv87BuvttX2/GqAxlFEutLiXhohRcyj9Sgl2JoFfk96uVkFoCTDhPt5n/?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf0ff5f-1d56-4bd4-e993-08daf9895131
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 19:22:19.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9H3WKk9eDd5Ss/XQS0MIUv1GxxpzOwvJ7tdizMG6cJ9aFdMwS9M1IO0NhAJU6DylM7uKOzgXlorpi92G9a8miXLRlilMj1JzUgQQfQQeUwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3762
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


1) No stack traces present
2) Device usage appears to work, but cxl-cli fails to create a region, i
haven't checked why yet (also tried ndctl-75, same results)
3) There seems to be some other regression with the cxl_pmem_init
routine, because I get a stack trace in this setup regardless of whether
I apply the type-3 device commit.


All tests below with the previously posted DOE linux branch.
Base QEMU branch was Jonathan's 2023-1-11


DOE Branch - 2023-1-11 (HEAD) (all commits)

QEMU Config:
sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
-drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
-m 3G,slots=4,maxmem=8G \
-smp 4 \
-machine type=q35,accel=kvm,cxl=on \
-enable-kvm \
-nographic \
-object memory-backend-ram,id=mem0,size=1G,share=on \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 \
-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G

Result:  This worked, but cxl-cli could not create a region (will look
into this further later).




When running with a persistent memory configuration, I'm seeing a
kernel stack trace on cxl_pmem_init

Config:
sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
-drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
-m 3G,slots=4,maxmem=4G \
-smp 4 \
-machine type=q35,accel=kvm,cxl=on \
-enable-kvm \
-nographic \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,port=0,id=rp0,bus=cxl.0,chassis=0,slot=0 \
-object memory-backend-file,id=cxl-mem0,mem-path=/tmp/mem0,size=1G \
-object memory-backend-file,id=cxl-lsa0,mem-path=/tmp/lsa0,size=1G \
-device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G


[   62.167518] BUG: kernel NULL pointer dereference, address: 00000000000004c0
[   62.185069] #PF: supervisor read access in kernel mode
[   62.198502] #PF: error_code(0x0000) - not-present page
[   62.211019] PGD 0 P4D 0
[   62.220521] Oops: 0000 [#1] PREEMPT SMP PTI
[   62.233457] CPU: 3 PID: 558 Comm: systemd-udevd Not tainted 6.2.0-rc1+ #1
[   62.252886] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[   62.258432] Adding 2939900k swap on /dev/zram0.  Priority:100 extents:1 across:2939900k SSDscFS
[   62.285513] RIP: 0010:cxl_nvdimm_probe+0x8d/0x130 [cxl_pmem]
[   62.285529] Code: 85 c0 0f 85 90 00 00 00 f0 80 0c 24 40 f0 80 4c 24 08 10 f0 80 4c 24 08 20 f0 80 4c 24 08 40 49 8d 84 24 b8 04 00 00 4c 89 0
[   62.285531] RSP: 0018:ffffacff0141fc38 EFLAGS: 00010202
[   62.285534] RAX: ffff97a8a37b84b8 RBX: ffff97a8a37b8000 RCX: 0000000000000000
[   62.285536] RDX: 0000000000000001 RSI: ffff97a8a37b8000 RDI: 00000000ffffffff
[   62.285537] RBP: ffff97a8a37b8000 R08: 0000000000000001 R09: 0000000000000001
[   62.285538] R10: 0000000000000001 R11: 0000000000000000 R12: ffff97a8a37b8000
[   62.285539] R13: ffff97a982c3dc28 R14: 0000000000000000 R15: 0000000000000000
[   62.285541] FS:  00007f2619829580(0000) GS:ffff97a9bca00000(0000) knlGS:0000000000000000
[   62.285542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.285544] CR2: 00000000000004c0 CR3: 00000001056a8000 CR4: 00000000000006e0
[   62.285653] Call Trace:
[   62.285656]  <TASK>
[   62.285660]  cxl_bus_probe+0x17/0x50
[   62.285691]  really_probe+0xde/0x380
[   62.285695]  ? pm_runtime_barrier+0x50/0x90
[   62.285700]  __driver_probe_device+0x78/0x170
[   62.285846]  driver_probe_device+0x1f/0x90
[   62.285850]  __driver_attach+0xd2/0x1c0
[   62.285853]  ? __pfx___driver_attach+0x10/0x10
[   62.285856]  bus_for_each_dev+0x76/0xa0
[   62.285860]  bus_add_driver+0x1b1/0x200
[   62.285863]  driver_register+0x89/0xe0
[   62.285868]  ? __pfx_init_module+0x10/0x10 [cxl_pmem]
[   62.285874]  cxl_pmem_init+0x50/0xff0 [cxl_pmem]
[   62.285880]  do_one_initcall+0x6e/0x330
[   62.285888]  do_init_module+0x4a/0x200
[   62.285892]  __do_sys_finit_module+0x93/0xf0
[   62.285899]  do_syscall_64+0x5b/0x80
[   62.285904]  ? do_syscall_64+0x67/0x80
[   62.285906]  ? asm_exc_page_fault+0x22/0x30
[   62.285910]  ? lockdep_hardirqs_on+0x7d/0x100
[   62.285914]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   62.285917] RIP: 0033:0x7f2619b0afbd
[   62.285920] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 8
[   62.285922] RSP: 002b:00007ffcc516bf58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   62.285924] RAX: ffffffffffffffda RBX: 00005557c0dcaa60 RCX: 00007f2619b0afbd
[   62.285925] RDX: 0000000000000000 RSI: 00007f261a18743c RDI: 0000000000000006
[   62.285926] RBP: 00007f261a18743c R08: 0000000000000000 R09: 00007f261a17bb52
[   62.285927] R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
[   62.285928] R13: 00005557c0dbbce0 R14: 0000000000000000 R15: 00005557c0dc18a0
[   62.285932]  </TASK>
[   62.285933] Modules linked in: cxl_pmem(+) snd_pcm libnvdimm snd_timer snd joydev bochs cxl_mem drm_vram_helper parport_pc soundcore drm_ttm_g
[   62.285954] CR2: 00000000000004c0
[   62.288385] ---[ end trace 0000000000000000 ]---
[   63.203514] RIP: 0010:cxl_nvdimm_probe+0x8d/0x130 [cxl_pmem]
[   63.203562] Code: 85 c0 0f 85 90 00 00 00 f0 80 0c 24 40 f0 80 4c 24 08 10 f0 80 4c 24 08 20 f0 80 4c 24 08 40 49 8d 84 24 b8 04 00 00 4c 89 0
[   63.203565] RSP: 0018:ffffacff0141fc38 EFLAGS: 00010202
[   63.203570] RAX: ffff97a8a37b84b8 RBX: ffff97a8a37b8000 RCX: 0000000000000000
[   63.203572] RDX: 0000000000000001 RSI: ffff97a8a37b8000 RDI: 00000000ffffffff
[   63.203574] RBP: ffff97a8a37b8000 R08: 0000000000000001 R09: 0000000000000001
[   63.203576] R10: 0000000000000001 R11: 0000000000000000 R12: ffff97a8a37b8000
[   63.203577] R13: ffff97a982c3dc28 R14: 0000000000000000 R15: 0000000000000000
[   63.203580] FS:  00007f2619829580(0000) GS:ffff97a9bca00000(0000) knlGS:0000000000000000
[   63.203583] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.203585] CR2: 00000000000004c0 CR3: 00000001056a8000 CR4: 00000000000006e0



Next i reverted the QEMU branch to the commit just before the type-3
volatile commit and used the old method of launching with a type-3 pmem
device

Config:
sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
-drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
-m 2G,slots=4,maxmem=4G \
-smp 4 \
-machine type=q35,accel=kvm,cxl=on \
-enable-kvm \
-nographic \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 \
-object memory-backend-file,pmem=true,id=cxl-mem0,mem-path=/tmp/cxl-mem0,size=1G \
-object memory-backend-file,pmem=true,id=lsa0,mem-path=/tmp/cxl-lsa0,size=1G \
-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G


Result: Similar stack trace
[   29.850023] BUG: kernel NULL pointer dereference, address: 00000000000004c0
[   29.882400] RIP: 0010:cxl_nvdimm_probe+0x8d/0x130 [cxl_pmem]
[   29.957485] Call Trace:
[   29.959067]  <TASK>
[   29.962176]  cxl_bus_probe+0x17/0x50
[   29.964940]  really_probe+0xde/0x380
[   29.969065]  ? pm_runtime_barrier+0x50/0x90
[   29.973419]  __driver_probe_device+0x78/0x170
[   29.977183]  driver_probe_device+0x1f/0x90
[   29.984212]  __driver_attach+0xd2/0x1c0
[   29.988463]  ? __pfx___driver_attach+0x10/0x10
[   29.992379]  bus_for_each_dev+0x76/0xa0
[   29.997040]  bus_add_driver+0x1b1/0x200
[   30.000368]  driver_register+0x89/0xe0
[   30.004579]  ? __pfx_init_module+0x10/0x10 [cxl_pmem]
[   30.012403]  cxl_pmem_init+0x50/0xff0 [cxl_pmem]
[   30.019394]  do_one_initcall+0x6e/0x330
[   30.024028]  do_init_module+0x4a/0x200
[   30.029243]  __do_sys_finit_module+0x93/0xf0
[   30.034943]  do_syscall_64+0x5b/0x80
[   30.039844]  ? do_syscall_64+0x67/0x80
[   30.045163]  ? do_syscall_64+0x67/0x80
[   30.049729]  ? lock_release+0x14b/0x440
[   30.054055]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
[   30.061039]  ? lock_is_held_type+0xe8/0x140
[   30.067625]  ? do_syscall_64+0x67/0x80
[   30.071909]  ? lockdep_hardirqs_on+0x7d/0x100
[   30.079037]  ? do_syscall_64+0x67/0x80
[   30.084537]  ? do_syscall_64+0x67/0x80
[   30.089091]  ? do_syscall_64+0x67/0x80
[   30.094174]  ? lockdep_hardirqs_on+0x7d/0x100
[   30.099224]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   30.104446] RIP: 0033:0x7f000550afbd
