Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F419C636D4
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 23:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjAaXRZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjAaXRY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 18:17:24 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0BA530F6
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 15:17:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWjWNG7oCEhFXwALeStGrGI5DL7ZvwLA3MP3DfCBNhEOm0K4FJxPW0ZDNJkoXgHD/TzwfvNEx06LpCCCDdS7LY2ROymZBhv+GPcK1LUIxnoB8CXX/l1WQ88mep4cwT39M0ghjgGhE67zrILDqx/U9nZOuD0RXevMsmnCrrOzpAjTKVlMdSIfrJ2LLs3RJDJEGLW0sM8NsTKffa8ecCkEsaeJ43ykekhW1q/V4mXnXcSuk26z2HvOqWgmvbG20OPpL/GsxuVZPUaTH286Xit6EYaS3Fc/pyFdZEEdfMKR9KIh0yuOo31Sjn7T85CLUyVU5iewawCw3lVU4QpyCqsoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myJTMim/bWvQrRcH2dls+tSJFYICghIqlk0S/RfjDm8=;
 b=hgqhYb9wfRa2n6u+ssgeB3PnxB3Ym0uCt/Qwy9oHd0zd8fNdXhHQ8zyBjNdeGRE0TJUiqePV4myTeCEQl6T/DMtF2EkrKoFx8mR1ESqduovd9XQqpZzmcsTp8gn/wojBtMT1R1ByqA3Ru6D1UjZzcLHkcHQNbK2cWXdntfCpmbuM7Dm+r2iGdJMopmGy/hkAkHGsiKK/5pdSWNH7xS0BTcxHqao97ZcWo9TI4a0Z63+AKfJ+fjct8AEfC42oIXOrDxgRke6D8scz9QGHpaeN1OHPsG7Ar+pgGgGuBHhA88bWODCMkTPSGMm2MaHGr7qr+ciK3m/4L3U7YpM+Q8bHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myJTMim/bWvQrRcH2dls+tSJFYICghIqlk0S/RfjDm8=;
 b=FTKuEs5035QJVrXlMwyRYbb7UxJgRJiSYZ63mS4k7iduMMRMGEcUONc2ynRLEpyJKAMeI3HG59zfpQBS2+kCIXR6nPOp8y8Svd9tMhPfx0H6pSvAqQT2O+0JOJzfG2XYEVh5t18N8BuTrFPZFP0BbJEBUbXIY1To8AhZiuJTG+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB4471.namprd17.prod.outlook.com (2603:10b6:510:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 23:17:19 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Tue, 31 Jan 2023
 23:17:19 +0000
Date:   Tue, 31 Jan 2023 18:17:15 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9mhe2xPGRE1/7cC@memverge.com>
References: <Y9fRVu+yLza4d5Vt@memverge.com>
 <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9gva49IPFOXYlkH@memverge.com>
 <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9h2VhGuraZfEJfD@memverge.com>
 <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
 <Y9ll5S3Y4BZkakNn@memverge.com>
 <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
 <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
 <Y9meWfDiCGbca4nP@memverge.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9meWfDiCGbca4nP@memverge.com>
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c39860-4faa-4b62-6f3e-08db03e14ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irJN/vuYiBwGlpK8sm+XhrWKU0uROZnY4MuYK3armuLFFjY4fXc0fgp/h6nIRQ+KIMXQdb4DaLG0eFHFoVvoT+VjidmVRTzwBrF+Q82Qndl2mQoNiSTrPKRrMkcE95EGw0qDWnNM74gStWqaI4ylNbUSxrtYzj9ha8K9RhmWWfnU6IN5VS7YKQ33RjuLXfh9o2x5oemc+Bhq6mfgYPRrp+AnTirhklh5X/LChjdKpjI2jKe6Y38Y3IJ+6UK03cINQzU4fE0IKCkBOgqG+bkbodqvzoilId7qtgsGwi/qlMWYB78nQzMySYe/DdIvvfblYnPmKZQSLT892DzjDwdPArD5zzfs0eLBRkkfSScEJG9c9ul8e8KQRJL0599tIrt1+lqvGI3GO/NFQMhxulYFNZ0UQULc3rMMDNnngQ18nTyL2jD8O1uRoMuns0h86dVc0UNIwPsMLUnsg3smm6K8hqkLo/tfcSGgQyrpQJuWl7L0B5+ARhueB0h+7+ewdFBzus4FVKkYjUu3Xz64sFS5+WRMDRCLI3S29z3EfFUeny7DW5TwDJ6PX7WFUEgTkZKE2KxNR3WFYMAfoILljG4Y/yWi0AFKVhD2QY+JERyNu4sEhqTHDeIVsu/lEavw1uJM5CYaqpULzGV6ZTdWv5SDSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(39840400004)(396003)(376002)(451199018)(30864003)(5660300002)(44832011)(2906002)(36756003)(38100700002)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(186003)(45080400002)(86362001)(83380400001)(54906003)(66946007)(8676002)(4326008)(6666004)(66476007)(66556008)(6916009)(316002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8C1qBepUhJeYPLHNtD7gzgz4awK8Ay4RNvvRdslW742nzNtvQXXWcFRHUs?=
 =?iso-8859-1?Q?9hggU00c07mcJWm3m89zCoe6bOiTWQCmzfx23YLa5bJFQnkYUS3SC3cQO6?=
 =?iso-8859-1?Q?KKpfz08vYiFHtNOBrlwOFwh/BbhiGVo9AB0hQCVXBR1N6tb7Bdun3rlSR1?=
 =?iso-8859-1?Q?DRgQAVdd5AKH191KVyP2N3u72mnhJCsEtfKAOYSwBKegNtAYQp1f61N8iR?=
 =?iso-8859-1?Q?jHyQucr+amp2Mmtnp5Rp44LVfg8HTPgAJVWxLLe047jCrcUeqgjRBGyivT?=
 =?iso-8859-1?Q?RsPuIoFiSKx+kZ8RXxbr2MhFFgxO5+4rWN97Cz5Qkc1nFZXi7DASe/vILx?=
 =?iso-8859-1?Q?xS8ShcqpbHB7oKsPL9mIABPC9fN2RDdXjoFdxoe3tpPRA7nMan/NLxBCkn?=
 =?iso-8859-1?Q?YmU5OP+zMa2HVwMpFVdjvIzkwyaE68nz0lkkrcigP71nLgwgXkdqIV2VBk?=
 =?iso-8859-1?Q?DXHfeldzIGJfL8+pEmNow2QMQkR+F2ZWEKAEhPtNwwNnOp/I4qM6M2WTgw?=
 =?iso-8859-1?Q?0K3wPoB5e8alHxERVhXVmRwHqiD4f9UCTrYKNBej2EIcJkZAOkUuVvuBPW?=
 =?iso-8859-1?Q?Pa9XqpqDOuNzMYZezIDZ8OralG6FQlJsh2MjcAyfztcoU2xPePYJgZ82Vi?=
 =?iso-8859-1?Q?3P8EKmGU6uuGnu1RlqaUXdPnKDdW9MWXUvI84p10N25L8HC7u9ORUZ6+nQ?=
 =?iso-8859-1?Q?hdbKivyRYsmGZlTiASVhcb7VOWh8XpbN1QS6mmilPzv8Fhsb91wclmUIwE?=
 =?iso-8859-1?Q?K1Ldu8cvL0s7ckvg/IELyHG4Skcj7g8nAygaulf+5ggTQn4RHfHuEnH1F1?=
 =?iso-8859-1?Q?Z728kAzK9LIYaZ1LTLhrWRUXFDXe8NMdC9Y6B9NwUfu2nFr1OSURigtael?=
 =?iso-8859-1?Q?HsY2EDxMg6fuj3Py3c7rXkmjvYNH+fCy5mw+ZM2y/fq/ch8fVeQl3Og1uB?=
 =?iso-8859-1?Q?oT3sE42RUIH3mfiz9FqtWoQcf2Fi+goxPhPPdFCBWdz1HCh0icsfCSy3HG?=
 =?iso-8859-1?Q?6js+zACm585te1Fy0gAyR251eUNECkghBHRvHaw/dxfxwTldOenpZYTwZ7?=
 =?iso-8859-1?Q?alODedGGlJpzbMM29N84OHi08rn8YMDG5lIhGAUgruL4211PxIeRBubhaV?=
 =?iso-8859-1?Q?3diDIQuYgX7hFfjKizs28ZcsKLRsgiyC9NN9RmOs/uxf5hyT69Z2kvKImj?=
 =?iso-8859-1?Q?bjfLEF/tsRIi4PHHJlOi5MbKW2xWUBZAW8md+DwkHKEEtY9MLfajHBLZCS?=
 =?iso-8859-1?Q?Ko7izqe/WkY4SEL/LIPWTTu2zBsQH8u+GOGX1AhNqJvXT+T0fSru3R/DXZ?=
 =?iso-8859-1?Q?/cgqW5SMqf4buiF2hBns4Shuk8xOLK8e51pRSmkJvz9DJUCh2VrWHFhyz5?=
 =?iso-8859-1?Q?ANUJOLbFmWn0l0yjkLXl7iawqCNvLrIyUrbcfgmpNkKakHNDakHo4Mwq7e?=
 =?iso-8859-1?Q?ltlT3dqsjv8dsqfy6dPH3d6zYtRgaAg7vNDFCWQldkK9RPI0e46JHoqARK?=
 =?iso-8859-1?Q?ecAc7eFsEoh1HUm8aDJBMQElZMFEJF0DzQ6eCU4NcqGepzMGzTa1Yv0hrT?=
 =?iso-8859-1?Q?uVffh4g6ufAkKzk0iHGPvCzC+RDI2sBO1lX2rdKf2xY/bCmmektbNkC0c8?=
 =?iso-8859-1?Q?dUas7A1BGx+befxhSK22IQw4BPz9luWiSbRBhFinA9sESlBs12CoM57Kfo?=
 =?iso-8859-1?Q?ziOkP6qjJ15kgrvUByQ=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c39860-4faa-4b62-6f3e-08db03e14ce1
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 23:17:19.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWDbZE5olSQGRaKtPTZlS0AMnSOn1PNssmP31I/4PDqHTDbEMxQhtCJuWUq1vVJnZ245tP2HOvr7ypgZHogIviLJskx91yc1M1yjTYRFMWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4471
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 31, 2023 at 06:03:53PM -0500, Gregory Price wrote:
> On Tue, Jan 31, 2023 at 08:24:19PM +0000, Verma, Vishal L wrote:
> > On Tue, 2023-01-31 at 19:46 +0000, Verma, Vishal L wrote:
> > > On Tue, 2023-01-31 at 14:03 -0500, Gregory Price wrote:
> > > > 
> > > > 
> > > > Right now I believe this is failing due to the interleave and size not
> > > > having default values
> > > > 
> > > > ./cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
> > > > cxl region: create_region: create_region: unable to determine region size
> > > > cxl region: cmd_create_region: created 0 regions
> > > > 
> > > > 
> > > > appears to be due to this code
> > > > static int create_region(struct cxl_ctx *ctx, int *count,
> > > >              struct parsed_params *p)
> > > > {
> > > > // ... snip ...
> > > >     rc = create_region_validate_config(ctx, p);
> > > >     if (rc)
> > > >         return rc;
> > > > 
> > > >     if (p->size) {
> > > >         size = p->size;
> > > >         default_size = false;
> > > >     } else if (p->ep_min_size) {
> > > >         size = p->ep_min_size * p->ways;
> > > > **    } else {
> > > > **        log_err(&rl, "%s: unable to determine region size\n", __func__);
> > > > **        return -ENXIO;
> > > > **    }
> > > > 
> > > > So both size and ep_min_size are 0 here
> > > > 
> > > > echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
> > > > cat /sys/bus/cxl/devices/region0/interleave_ways
> > > > 0
> > > > cat /sys/bus/cxl/devices/region0/interleave_granularity
> > > > 0
> > > > cat /sys/bus/cxl/devices/region0/size
> > > > 0
> > > 
> > > Ah - this revealed an actual bug in these commits - the size and
> > > ep_min_size don't refer to the region's size, it is the capacity of the
> > > component memdevs. Right after create_ram_region, the region size is
> > > expected to be zero.
> > > 
> > > However the bug here was a pmem assumption I had missed. When
> > > determining sizes, we only look at pmem capacity, which is wrong. It
> > > happened to work in my testing because the memdevs I used had both pmem
> > > and ram capacity. I'll update with a fix shortly. Thanks for trying it
> > > out and reporting this!
> > 
> > I've updated the branch now with a fix for this.
> 
> Progress! But now i've found a kernel segfault :D
> (sorry about the jumble here, looks like multiple issues))
> 
> [root@fedora cxl]# ./cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
> [  170.675334] cxl_region region0: Failed to synchronize CPU cache state
> libcxl: [c x l1_7r0e.68249g6i] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  170.691163] #PF: supervisor instruction fetch in kernel mode
> [o n 1_70.70e3n9a1b6l]e :# rPeF: error_code(0gixo0010) - not-present page
> n0[:  fai led1 7to 0e.7n19709] PGD 800000004d25d067 P4D 800000004d25d067 PUD 4cdf3067 PMD 0
> [  170.725436] Oops: 0010 [#1] PREEMPT SMP PTI
> 1b[l e
> 7c0x.l734 510r]e giConPU: 0 PID: 717 Comm: cxl Not tainted 6.2.0-rc2+ #19
> [  170.739750] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> :[  170.747119] R IP: 0c0r1e0:at0ex_0r
> egi[o n: 170.751110] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [  170.757699] RSP: 0018:ffffb9a3c0e97c60 EFLAGS: 00010296
> [   17r0e.g7ion0:6 f6a0i9l1e]d RAX: 0000000000000000 RBX: ffff9c38e459de60 RCX: 0000000000000000
> [  170.772499] RDX: 0000000000000000 RSI: ffff9c38e42ecdb0 RDI: ffff9c390f11d400
>  [  t170o.77 8e3nab0l0e] RBP: fff:f 9Nco3 8seed38000 R08: 0000000000000001 R09: ffffb9a3c0e97b38
> [  170.783787] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9c393d8c8c00
> uch d[ev i 1ce7 0o.7r8 800a9]d R13: ffff9c390f141c00 R14: ffff9c38eed38340 R15: ffff9c38c1a01400
> dr[e  s1s7
> 0.795938] FS:  00007ff89ca037c0(0000) GS:ffff9c393dc00000(0000) knlGS:0000000000000000
> [  170.802891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.806705] CR2: ffffffffffffffd6 CR3: 0000000024c8e000 CR4: 00000000000006f0
> [  170.817025] Call Trace:
> [  170.818831]  <TASK>
> [  170.820589]  cxl_region_decode_reset+0xb8/0x110
> [  170.823893]  cxl_region_detach+0xda/0x1e0
> [  170.829457]  detach_target.part.0+0x29/0x80
> [  170.833503]  unregister_region+0x42/0x90
> [  170.836813]  devm_release_action+0x3d/0x70
> [  170.840128]  ? __pfx_unregister_region+0x10/0x10
> [  170.843899]  delete_region_store+0x69/0x80
> [  170.847680]  kernfs_fop_write_iter+0x11e/0x200
> [  170.851217]  vfs_write+0x222/0x3e0
> [  170.854141]  ksys_write+0x5b/0xd0
> [  170.856695]  do_syscall_64+0x5b/0x80
> [  170.859678]  ? kmem_cache_free+0x15/0x3b0
> [  170.862234]  ? do_sys_openat2+0x77/0x150
> [  170.865560]  ? syscall_exit_to_user_mode+0x17/0x40
> [  170.870920]  ? do_syscall_64+0x67/0x80
> [  170.874726]  ? syscall_exit_to_user_mode+0x17/0x40
> [  170.879464]  ? do_syscall_64+0x67/0x80
> [  170.881634]  ? __irq_exit_rcu+0x3d/0x140
> [  170.884720]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [  170.888810] RIP: 0033:0x7ff89c901c37
> [  170.891435] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 4[  170.905803] RSP: 002b:00007fff0e843a68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  170.913373] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff89c901c37
> [  170.920868] RDX: 0000000000000008 RSI: 0000000001290ee6 RDI: 0000000000000003
> [  170.931402] RBP: 00007fff0e843aa0 R08: 000000000000fee0 R09: 0000000000000073
> [  170.936639] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [  170.942484] R13: 00007fff0e844000 R14: 000000000041fdc8 R15: 00007ff89cbdf000
> [  170.954794]  </TASK>
> [  170.957649] Modules linked in: rfkill vfat fat snd_pcm iTCO_wdt snd_timer intel_pmc_bxt ppdev iTCO_vendor_support snd cxl_pmem soundcore bochg[  170.980623] CR2: 0000000000000000
> [  170.984137] ---[ end trace 0000000000000000 ]---
> [  170.989062] RIP: 0010:0x0
> [  170.991505] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [  170.996401] RSP: 0018:ffffb9a3c0e97c60 EFLAGS: 00010296
> [  170.999716] RAX: 0000000000000000 RBX: ffff9c38e459de60 RCX: 0000000000000000
> [  171.006146] RDX: 0000000000000000 RSI: ffff9c38e42ecdb0 RDI: ffff9c390f11d400
> [  171.018226] RBP: ffff9c38eed38000 R08: 0000000000000001 R09: ffffb9a3c0e97b38
> [  171.024812] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9c393d8c8c00
> [  171.036512] R13: ffff9c390f141c00 R14: ffff9c38eed38340 R15: ffff9c38c1a01400
> [  171.042400] FS:  00007ff89ca037c0(0000) GS:ffff9c393dc00000(0000) knlGS:0000000000000000
> [  171.050182] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  171.055740] CR2: ffffffffffffffd6 CR3: 0000000024c8e000 CR4: 00000000000006f0
> Killed


Looks like some error is still occuring, this happens when attempting to
delete a region after it has been configured

[root@fedora ~]# echo region0 > /sys/bus/cxl/devices/decoder0.0/delete_region
[   97.186328] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   97.190754] #PF: supervisor instruction fetch in kernel mode
[   97.196754] #PF: error_code(0x0010) - not-present page
[   97.201108] PGD 0 P4D 0
[   97.202585] Oops: 0010 [#1] PREEMPT SMP PTI
[   97.206085] CPU: 1 PID: 688 Comm: bash Not tainted 6.2.0-rc2+ #19
[   97.215215] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[   97.224247] RIP: 0010:0x0
[   97.228516] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   97.233852] RSP: 0018:ffffa30000d23d20 EFLAGS: 00010292
[   97.236704] RAX: 0000000000000000 RBX: ffff8a2fe44fb120 RCX: 0000000000000000
[   97.242904] RDX: 0000000000000000 RSI: ffff8a2fc2c5f6c0 RDI: ffff8a2fc1f29000
[   97.250537] RBP: ffff8a2fc3395c00 R08: 0000000000000001 R09: ffffa30000d23bf8
[   97.260478] R10: ffff8a2fc35adc00 R11: 0000000000000000 R12: ffff8a2fc1272000
[   97.276617] R13: ffff8a2fc3329c00 R14: ffff8a2fc3395f40 R15: ffff8a2fc1f29800
[   97.285277] FS:  00007f195be24740(0000) GS:ffff8a303dc80000(0000) knlGS:0000000000000000
[   97.295175] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.300566] CR2: ffffffffffffffd6 CR3: 00000000249e6000 CR4: 00000000000006e0
[   97.308856] Call Trace:
[   97.312137]  <TASK>
[   97.314095]  cxl_region_decode_reset+0xb8/0x110
[   97.317937]  cxl_region_detach+0xda/0x1e0
[   97.320694]  detach_target.part.0+0x29/0x80
[   97.326437]  unregister_region+0x42/0x90
[   97.331169]  devm_release_action+0x3d/0x70
[   97.334957]  ? __pfx_unregister_region+0x10/0x10
[   97.338434]  delete_region_store+0x69/0x80
[   97.343526]  kernfs_fop_write_iter+0x11e/0x200
[   97.348950]  vfs_write+0x222/0x3e0
[   97.352273]  ksys_write+0x5b/0xd0
[   97.354592]  do_syscall_64+0x5b/0x80
[   97.358291]  ? exc_page_fault+0x70/0x170
[   97.362739]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   97.367268] RIP: 0033:0x7f195bd01c37
[   97.369719] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 4
[   97.386808] RSP: 002b:00007fff8a2320d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   97.394208] RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f195bd01c37
[   97.401547] RDX: 0000000000000008 RSI: 0000555fd741b550 RDI: 0000000000000001
[   97.409231] RBP: 0000555fd741b550 R08: 0000000000001000 R09: 0000000000000000
[   97.416149] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
[   97.420784] R13: 00007f195bdf9780 R14: 0000000000000008 R15: 00007f195bdf49e0
[   97.429142]  </TASK>
[   97.431741] Modules linked in: rfkill vfat fat snd_pcm snd_timer iTCO_wdt snd intel_pmc_bxt iTCO_vendor_support ppdev cxl_pmem soundcore libng
[   97.456189] CR2: 0000000000000000
[   97.461271] ---[ end trace 0000000000000000 ]---
[   97.466464] RIP: 0010:0x0
[   97.468599] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   97.476231] RSP: 0018:ffffa30000d23d20 EFLAGS: 00010292
[   97.482910] RAX: 0000000000000000 RBX: ffff8a2fe44fb120 RCX: 0000000000000000
[   97.488445] RDX: 0000000000000000 RSI: ffff8a2fc2c5f6c0 RDI: ffff8a2fc1f29000
[   97.496227] RBP: ffff8a2fc3395c00 R08: 0000000000000001 R09: ffffa30000d23bf8
[   97.502543] R10: ffff8a2fc35adc00 R11: 0000000000000000 R12: ffff8a2fc1272000
[   97.512213] R13: ffff8a2fc3329c00 R14: ffff8a2fc3395f40 R15: ffff8a2fc1f29800
[   97.518303] FS:  00007f195be24740(0000) GS:ffff8a303dc80000(0000) knlGS:0000000000000000
[   97.526884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.533142] CR2: ffffffffffffffd6 CR3: 00000000249e6000 CR4: 00000000000006e0
