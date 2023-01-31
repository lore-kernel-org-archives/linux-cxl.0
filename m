Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD418C636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 23:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjAaXED (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAaXEC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 18:04:02 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CA346727
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 15:04:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxdY9V4zvRDYBPJUgr/ntxjFlut+ax3T9L5ZDlr8ws7K954jRCM9LdmfAqHlWVR2gdQa93GPGY3jRacT5L3aJyu2rXQE2/RNNq7WQwYly6zdsIsU8zvDXghr2AZKmoV2L2bBut0NBKhbH9Q17I2Ag+1c9l7afrmyXs63w0x6FIlLTf9vdWusjG+mj3KLSdtsqPCSQlNRF3zlUIKcQgvT28TODIE+oLusYk7Y/chF2TaJ17FAD1yAiXA2+8WuQHJx4AGNumX3plKpY+Bq1lYqMhU3UUa7ZE898iQ4EHRQ2xIAHtZlgslf/OFsCMdiSiCDH3SAZyRKWMw8wCe31+/prA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c+mrFoqtvzEQ6zgc7C2freFiQGNOzqfev6Q4k2YFVE=;
 b=N9lYB6sUk3Z0CGOJT/BDNG0/q31O2AnpKaZtj3ZhcQrPBoytwTtCSQXQM67NyN/y3YRxLvwOsf9Ya7GFJPitv7lcWszL3rRHg0EeHceLayLhNJu0HH+Nyfdi1bmoenfAQq3Q+v4ccWW60BbmfwLfWr3WD9FCzdhvZJBEKNrIEd6yxlXiS+eyOJRlB55BE69mX/YWcqCfSTQsI0y33Nw4Cr9IPI6tZoFG2j6jeIViOdTAQKF7oenaKc/rTO2V1UPRGixnW+oCqj/Sb8psNhgaOP3oNjQKvqc50iDel6OBKqfKdsNUhobDw0htYOHsf0uLfhXXSx3zX9U8rTPz9Hal8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c+mrFoqtvzEQ6zgc7C2freFiQGNOzqfev6Q4k2YFVE=;
 b=TEO7yld9MHzWNtDk7Vbo24BCMd2gT84MzrT4Vy3T+WQ7RpkzEYT+7Jso7MDtCWmSj9PmfVClk/KniTy56ew7jpHVdxzqOiUPVeTz45Jlo5IisEGUW7+M1SEOVHg9iC1BAWmi6qFc1dDCY1ctl5HtUbCCFDwXRfU/NQhB9Rx8PaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH8PR17MB6785.namprd17.prod.outlook.com (2603:10b6:510:238::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 23:03:58 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Tue, 31 Jan 2023
 23:03:58 +0000
Date:   Tue, 31 Jan 2023 18:03:53 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9meWfDiCGbca4nP@memverge.com>
References: <20230126193424.00005034@huawei.com>
 <Y9fRVu+yLza4d5Vt@memverge.com>
 <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9gva49IPFOXYlkH@memverge.com>
 <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9h2VhGuraZfEJfD@memverge.com>
 <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
 <Y9ll5S3Y4BZkakNn@memverge.com>
 <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
 <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73ef066b15c5551087da3667398f462d427d3204.camel@intel.com>
X-ClientProxiedBy: BY3PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::31) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH8PR17MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 763d5cc4-18b1-4492-f415-08db03df6f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hF4wMnYFdSZbHheyRIZnFekA3R34qtbkleK9OZFg/pce8oLNnX6KxuqKPm/g2GE0JsTrgG0HO3kEAVxVzVMhGa2x8O9R8091T85q1zSHsZk9d2q6d2yVg9LocxK0Bo/YmCoMT74gtNL5MI2OOnYWV6cRfGSZqG+rbXTLTJsdQsiwy3PWOB59GEniDt+x5uikxBFpBVuWBpLd3srYmcwkcA3ZfWbvvMaXW+t3qJemVOHmHSV7xvsh+dP6CqE4NWxL8boHO8np09gVdlhsjaxwdWLZkwz3JFKra6al0nmiY6X48RqkG044OV7rDyyMLDBA2/fedLlMQqiGLJol1LR2DIZ8q+e0IRC8xNqZ7pvlUHy1AiNz+DkmuCclm5yd9M6znRiLgCmK8AwW8OBL0+NUhGuaJTCzbD0mYBbJRUg14V4bl11akh8NxNmmOJ+QlDbOhAtasWrKRx1D6B+z3e5nIPvGGdkjMnwIW7Qh+Vf977BdyqTmUtl6WefkkmeXPk4Z+zD478zUcmIPh+176k/UnXIqV1hz9YJzP1RBemz7Z8uzA+Apf/gIx+BybQbO7nN2p9UhryXI0znVqH8suB8atBx+HXDdB944R7pX+HD3TnCpTzQDSRhAyR+nUXRFO4qUveHbsAdK4PVdJYGa8yrCVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39830400003)(346002)(136003)(376002)(451199018)(8936002)(2616005)(54906003)(186003)(6512007)(6666004)(6506007)(26005)(5660300002)(41300700001)(66476007)(36756003)(4326008)(66946007)(6916009)(8676002)(66556008)(2906002)(38100700002)(478600001)(316002)(44832011)(45080400002)(6486002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gwXrSmT9ThnTU6V1rHd9dN6lGcfu8tyb2Pb4Hof5ZAEiY/Z8G6ArnFJDYv?=
 =?iso-8859-1?Q?T+hjzjSnVoMMAvpN1Sppv8K5LL1iVa1H2sagspfWqmTqUF9fcXYDyE77kp?=
 =?iso-8859-1?Q?MXqkoJAEbfTt1jay6ETGr7mUQmLS+OMsP9Rs8iHWIpsL2PA+UKLSx+v8WC?=
 =?iso-8859-1?Q?JB6aCXnIFQ6yqUkZywWihYA00oGr5tFW1MBFt431aOqaclMPudRbmf/1mX?=
 =?iso-8859-1?Q?PD8/bFwBmyBEOdAOnWRPspS4jg+fJ0zCq6dKBDVRMpSKqCOCWBLz88tiKm?=
 =?iso-8859-1?Q?3dNzq3Vq12KywFlTPxOMBtpP+5YfYDb2vaRs9qDxnl3kJbCnNqpX80ShMe?=
 =?iso-8859-1?Q?qwpn5DeeMrzcTiQoAWXPI2szKYNrTLpxnXTaJo1QPnexzYyuqpTpbOtB68?=
 =?iso-8859-1?Q?Y1YMgEGAI9FuNOAN4udCKGNwymJHOJ+rzRSOamMEMwK+UI4t8wdx/PCLbo?=
 =?iso-8859-1?Q?8HUeczO2YZNDDpT6eUXYRTnVX7bJCk+UbS0QKDwsvyK6p4Yi566PWfwR+y?=
 =?iso-8859-1?Q?BojcL5+dvIjU6M9pyr0zkdZ+IYpqd65mZndqrJh5UYhNaIXWx/+0ja7SnT?=
 =?iso-8859-1?Q?U7MRrJTf9AaIPwNC093v2YqS9T5XgYqXA//zFPoJmwOwpjUKGmWwRvwTMn?=
 =?iso-8859-1?Q?WQZPIIOWW0T8y6kH9cSP9A1fwGvbfkoKnOusSvzEJpRj6BhkBDIPMTIADi?=
 =?iso-8859-1?Q?GM7LvWrbw9fjL33nYn7EBcbJ93reTe36zT0JAvUPFQjYR27vfr8y+NCg9o?=
 =?iso-8859-1?Q?v5jU9BgSe38AkpyRVZRPFk/IM2JfNb2jngKtxlBQkn2HeE4P01S5ITs85A?=
 =?iso-8859-1?Q?jE6XLwB9bRWGZIkI5MGR5yVFy+U4kTdpsudocuem9+BJBa7GPBM9R8jsHD?=
 =?iso-8859-1?Q?wMDbSSrfaro+A9wOwb9Wk3lYDG9HMedp4PQic5ufikrmiopJIkg9ZyL5vk?=
 =?iso-8859-1?Q?Ib2D5nhRbOCaoFdp6rn0CLnAFiSFHA9gjsYbyiZ7qZ5a9geqklo3Qerfif?=
 =?iso-8859-1?Q?SnxhH0NfssbccIo/soIdidfrFS5G5NLevxvbZdjWyGjIz5FXKHyJrqIc6S?=
 =?iso-8859-1?Q?8n3CSgFwstEQwxvjhZsLPvHVOnubip3izSzCVvQvtGLDxwtLkZRowP/vZl?=
 =?iso-8859-1?Q?EFkELblZVcXWnVz10yNPTWl6w0uvdBbPsL0oZPa+aBLnUFp0mtpVSFeg1F?=
 =?iso-8859-1?Q?evpBwzTKZvhsPmijQq5eYcEfXOltcxNqJdh2CcO1uQd56NDqiTXKWuEJ5d?=
 =?iso-8859-1?Q?S+hMdfiP5UEx5ON/COE+6NW55wqCIzwrc4ZEY9X7rFbUW8BKHLM8g+tUVA?=
 =?iso-8859-1?Q?8i+NxNngkFDL+O/KHPgkjAIGCLLqVWA+LJTXGmsuiczVniBn8dvSMTHVNR?=
 =?iso-8859-1?Q?Jfb7a5lpQC7JdSDclg0xS7YQQIMde+vlTcU/4ZROtsWTRfDPmlwsvzM9zV?=
 =?iso-8859-1?Q?sFYFFPjdK3ZLlwoSK5RUDIvOBAPaEy6UjYjYH/iC7JfIgkwcedQpIHchrQ?=
 =?iso-8859-1?Q?auO8fhSLR1IBG/gaIb5Tqukr3o9OR3II6WogbyoSWTIOJTrXi0FEBLE4bM?=
 =?iso-8859-1?Q?zt96lafVosqrnUhbR7Jep0GxC27B21tSrMLIkMWP9kLINpPbbEk1yfOu0+?=
 =?iso-8859-1?Q?GWpC3FE6TvmbD9QXkB8xsMro0cvlw2xogbewfdI1KOBam1ZGuUgQwjMrki?=
 =?iso-8859-1?Q?sNc2Z0h70OVieaJ+8j0=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763d5cc4-18b1-4492-f415-08db03df6f14
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 23:03:58.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUPP1tP2IOETgNcJtyqm29N3NZ9OjOCPtL0+8MUtoixx6zEcxYXnltUxnoT8XVuJC6KO28fJL5FNVm9A2erNw4YhTPID+jwZaCwc/mWq23Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR17MB6785
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 31, 2023 at 08:24:19PM +0000, Verma, Vishal L wrote:
> On Tue, 2023-01-31 at 19:46 +0000, Verma, Vishal L wrote:
> > On Tue, 2023-01-31 at 14:03 -0500, Gregory Price wrote:
> > > 
> > > 
> > > Right now I believe this is failing due to the interleave and size not
> > > having default values
> > > 
> > > ./cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
> > > cxl region: create_region: create_region: unable to determine region size
> > > cxl region: cmd_create_region: created 0 regions
> > > 
> > > 
> > > appears to be due to this code
> > > static int create_region(struct cxl_ctx *ctx, int *count,
> > >              struct parsed_params *p)
> > > {
> > > // ... snip ...
> > >     rc = create_region_validate_config(ctx, p);
> > >     if (rc)
> > >         return rc;
> > > 
> > >     if (p->size) {
> > >         size = p->size;
> > >         default_size = false;
> > >     } else if (p->ep_min_size) {
> > >         size = p->ep_min_size * p->ways;
> > > **    } else {
> > > **        log_err(&rl, "%s: unable to determine region size\n", __func__);
> > > **        return -ENXIO;
> > > **    }
> > > 
> > > So both size and ep_min_size are 0 here
> > > 
> > > echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
> > > cat /sys/bus/cxl/devices/region0/interleave_ways
> > > 0
> > > cat /sys/bus/cxl/devices/region0/interleave_granularity
> > > 0
> > > cat /sys/bus/cxl/devices/region0/size
> > > 0
> > 
> > Ah - this revealed an actual bug in these commits - the size and
> > ep_min_size don't refer to the region's size, it is the capacity of the
> > component memdevs. Right after create_ram_region, the region size is
> > expected to be zero.
> > 
> > However the bug here was a pmem assumption I had missed. When
> > determining sizes, we only look at pmem capacity, which is wrong. It
> > happened to work in my testing because the memdevs I used had both pmem
> > and ram capacity. I'll update with a fix shortly. Thanks for trying it
> > out and reporting this!
> 
> I've updated the branch now with a fix for this.

Progress! But now i've found a kernel segfault :D
(sorry about the jumble here, looks like multiple issues))

[root@fedora cxl]# ./cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
[  170.675334] cxl_region region0: Failed to synchronize CPU cache state
libcxl: [c x l1_7r0e.68249g6i] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  170.691163] #PF: supervisor instruction fetch in kernel mode
[o n 1_70.70e3n9a1b6l]e :# rPeF: error_code(0gixo0010) - not-present page
n0[:  fai led1 7to 0e.7n19709] PGD 800000004d25d067 P4D 800000004d25d067 PUD 4cdf3067 PMD 0
[  170.725436] Oops: 0010 [#1] PREEMPT SMP PTI
1b[l e
7c0x.l734 510r]e giConPU: 0 PID: 717 Comm: cxl Not tainted 6.2.0-rc2+ #19
[  170.739750] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
:[  170.747119] R IP: 0c0r1e0:at0ex_0r
egi[o n: 170.751110] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  170.757699] RSP: 0018:ffffb9a3c0e97c60 EFLAGS: 00010296
[   17r0e.g7ion0:6 f6a0i9l1e]d RAX: 0000000000000000 RBX: ffff9c38e459de60 RCX: 0000000000000000
[  170.772499] RDX: 0000000000000000 RSI: ffff9c38e42ecdb0 RDI: ffff9c390f11d400
 [  t170o.77 8e3nab0l0e] RBP: fff:f 9Nco3 8seed38000 R08: 0000000000000001 R09: ffffb9a3c0e97b38
[  170.783787] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9c393d8c8c00
uch d[ev i 1ce7 0o.7r8 800a9]d R13: ffff9c390f141c00 R14: ffff9c38eed38340 R15: ffff9c38c1a01400
dr[e  s1s7
0.795938] FS:  00007ff89ca037c0(0000) GS:ffff9c393dc00000(0000) knlGS:0000000000000000
[  170.802891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  170.806705] CR2: ffffffffffffffd6 CR3: 0000000024c8e000 CR4: 00000000000006f0
[  170.817025] Call Trace:
[  170.818831]  <TASK>
[  170.820589]  cxl_region_decode_reset+0xb8/0x110
[  170.823893]  cxl_region_detach+0xda/0x1e0
[  170.829457]  detach_target.part.0+0x29/0x80
[  170.833503]  unregister_region+0x42/0x90
[  170.836813]  devm_release_action+0x3d/0x70
[  170.840128]  ? __pfx_unregister_region+0x10/0x10
[  170.843899]  delete_region_store+0x69/0x80
[  170.847680]  kernfs_fop_write_iter+0x11e/0x200
[  170.851217]  vfs_write+0x222/0x3e0
[  170.854141]  ksys_write+0x5b/0xd0
[  170.856695]  do_syscall_64+0x5b/0x80
[  170.859678]  ? kmem_cache_free+0x15/0x3b0
[  170.862234]  ? do_sys_openat2+0x77/0x150
[  170.865560]  ? syscall_exit_to_user_mode+0x17/0x40
[  170.870920]  ? do_syscall_64+0x67/0x80
[  170.874726]  ? syscall_exit_to_user_mode+0x17/0x40
[  170.879464]  ? do_syscall_64+0x67/0x80
[  170.881634]  ? __irq_exit_rcu+0x3d/0x140
[  170.884720]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  170.888810] RIP: 0033:0x7ff89c901c37
[  170.891435] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 4[  170.905803] RSP: 002b:00007fff0e843a68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  170.913373] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff89c901c37
[  170.920868] RDX: 0000000000000008 RSI: 0000000001290ee6 RDI: 0000000000000003
[  170.931402] RBP: 00007fff0e843aa0 R08: 000000000000fee0 R09: 0000000000000073
[  170.936639] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  170.942484] R13: 00007fff0e844000 R14: 000000000041fdc8 R15: 00007ff89cbdf000
[  170.954794]  </TASK>
[  170.957649] Modules linked in: rfkill vfat fat snd_pcm iTCO_wdt snd_timer intel_pmc_bxt ppdev iTCO_vendor_support snd cxl_pmem soundcore bochg[  170.980623] CR2: 0000000000000000
[  170.984137] ---[ end trace 0000000000000000 ]---
[  170.989062] RIP: 0010:0x0
[  170.991505] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  170.996401] RSP: 0018:ffffb9a3c0e97c60 EFLAGS: 00010296
[  170.999716] RAX: 0000000000000000 RBX: ffff9c38e459de60 RCX: 0000000000000000
[  171.006146] RDX: 0000000000000000 RSI: ffff9c38e42ecdb0 RDI: ffff9c390f11d400
[  171.018226] RBP: ffff9c38eed38000 R08: 0000000000000001 R09: ffffb9a3c0e97b38
[  171.024812] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9c393d8c8c00
[  171.036512] R13: ffff9c390f141c00 R14: ffff9c38eed38340 R15: ffff9c38c1a01400
[  171.042400] FS:  00007ff89ca037c0(0000) GS:ffff9c393dc00000(0000) knlGS:0000000000000000
[  171.050182] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  171.055740] CR2: ffffffffffffffd6 CR3: 0000000024c8e000 CR4: 00000000000006f0
Killed
