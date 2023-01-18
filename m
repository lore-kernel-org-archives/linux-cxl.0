Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2308AC32793
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 19:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjARTeU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 14:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjARTdl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 14:33:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32621618AA
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 11:32:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CETJX/hrkSZMOI2+jlQDMlLysGs2gpjKCac2Vy5PLNgY92xCKFsPpKnjAGm5C2ueY/N7rlBm1tF55abUBgSAxVASTSWkl3g+dWR9i4u8nxoR+RSN4q83EhbKGaWQ+RjS3EFPvf0Abi494++0LyMZ1o+rXfSEJLJFyB1OT6PVoMgbdO+WvXZtHUL6gTYLJhdP9yILCbXP2/iwbNDYgNLOzuSUFHu4pYfoKnYKPbMopU+Vu9tF4h4ROqaFrF5lYyWkZYgxlcJdggSVIg8UuP2Q18q5I7JH1EIYdKfLYoUSceK1pbRc8D6wQSCwok54CpUGMmHHccF2t2j9cJq/M8H0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+N6VC0a6EWKmbObTSzB8/C5KPE0gpLF1oP6LYZesgY=;
 b=FLmfZatWl2XkRQLMXvmXiBbqpDfz3Wp8hCnRe8DdNyJN5Gh420FdHiE5xaYbYafT1IUqa+QZ96FshICgGZ8BgOYgV2oNgeVt3SbmME2AYWCbzYFFJhigXMSwVQPjbwlIog38jc1Bp1tMJn/2EdWry+RoLWIQ43XID5/710E/2ZX4Ps4fGyFelvFddNnBqTBlir6tZEqrFiNa+ZApVMAbp2HteRGWu2M9JMMobj5Oe7wgBZM/cvHr8U+vpLSwLnYtCV76TtsC9TFGpi96wtnYPXf1H+czsu9xN02bI4D196XLilZHclAy9XCjKj6IOKfsPoi12lV3nRMFPIe6pfHAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+N6VC0a6EWKmbObTSzB8/C5KPE0gpLF1oP6LYZesgY=;
 b=MdfYgryxRzZA81tYLQJLOjn5Atx1Cxw1Afq0YUDp8/4izVgr8KNI1o1hLTDQbgjw/NOmwVkTcZocnACScygCD352Dg69QGewFw2I55Wqb24FeFD+sEhOl3lWcZi5Rvc45AA01dl5jUHIcJ3TzdkikCuOEhJPi/tAUWBFnh7u+nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB4390.namprd17.prod.outlook.com (2603:10b6:510:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 19:31:58 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 19:31:58 +0000
Date:   Wed, 18 Jan 2023 14:31:53 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <Y8hJKcy1993SFLLJ@memverge.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <Y8AppXP+eP9cEz+i@memverge.com>
 <20230112172130.0000391b@Huawei.com>
 <Y8CNw/fZT5fZJZcK@memverge.com>
 <20230113091213.00002146@Huawei.com>
 <Y8Foj/12QNl0C96o@memverge.com>
 <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
 <Y8hG4OyJL7l9oD2f@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hG4OyJL7l9oD2f@memverge.com>
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fe0ace-62b6-4ebb-6859-08daf98aaa13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3MY9oLajlQ11aASixzBf4EFrwf/2AXbKEgRuFp0uM1VCALSIBeRrcAe/XgjClgCUWhuLkHZ7f5jwjPytCfaiwx1WT2efyYpxR2ufSaTKO93btLP7/jghO3S0k7yy3nx/axPKeJWOzwJzQRqIkR3skcp0dzTSnCXTg8P0A0MSfrcc+huwAw1kevu6Nn8y39c+JoXSfIABWnL+/JzEmVh9H6hTvsndAr8q8Mvj6ZWVOdB7YHpxCgmrL6DX7TRTog2ykjaGwkK5dN19gsyd+C58Wu5pt88ki92QWhklhbVON4xtNyjrXdQ5qnhyKJDM7Td4lgm/oz9Xa4m3djJYZBTIKw/fHW8mZIM0sbckE8ba6oa3OhMmZae/Ad8C/SAOv8auVrDhvia8dyziBZVaWKAJPgETH4nQVr8zDMz/Px+p07mIag5y79/PndGE2sMGFog3XjWU+oau+1KYzTxkVrs1vLia6UgGpDPLjGVPmsXRbX92LFZNK1Fw+3DaWF+duAnJfwl8R495OsqZJMtCAiW4MsvTO9v0rzSUwwFO0GK551C+3XiDxSZwoBcJp6HjjsyNCgkMHfD73uyG8ogvGpAXkRyHXhLu/4+E9v5MKw5EWM+Ul2145JH0J0xIlaraFIaXQxCerDpVx4quQ0NqW79DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(376002)(136003)(366004)(396003)(346002)(451199015)(86362001)(2906002)(4001150100001)(44832011)(66476007)(66946007)(66556008)(5660300002)(8936002)(38100700002)(316002)(54906003)(6666004)(45080400002)(6486002)(6506007)(36756003)(478600001)(8676002)(6916009)(4326008)(41300700001)(186003)(83380400001)(6512007)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nfCTiiUl8WgYTU2EogUroMp5dp8xwsptTrwhKXlt+uAXZaeS2n8QXyeeeQS/?=
 =?us-ascii?Q?mZofJh342Nl1fvrNGSiRXHNHp0EtH/H+Dbmjn8L8y66Z/Y/RlP2eF6Xl2ZvZ?=
 =?us-ascii?Q?8xXdDWgCpEDyRgcqHywKKC36f7LzbJ0kQw+4uPpn81vljro1O4+r8BgIJH3a?=
 =?us-ascii?Q?nHikK2OueTD8+45SdYbgJ/9guNMhT4+z5GwUJZBCyOtb5S5lihTbbkHyo3qr?=
 =?us-ascii?Q?8nBI4IjkoJu4EuTq4xqiFHu21JNqCCVGtHt3i6/86hKWYjJBrAl2nZ4Zt9vn?=
 =?us-ascii?Q?e+2feZRWWst6Ae96W+6cGJeja5xR+a/dWWWrO+itHUAgW9ima1iX9AN2alJq?=
 =?us-ascii?Q?Rp8P6NwB3z4fdxKVUWnPImXLBkWCS1kDK1/J711X5JymPzZ+52xzwrSQtFVf?=
 =?us-ascii?Q?69faCmWQ3CvPcCowdby1jkSM4a3ii2uBfgej801QxdphyvHbmLmsGHY1qeqX?=
 =?us-ascii?Q?MNE+m9dueaLZturJ4wkQSu+2MCu/uVompKb1BGzUH5wlXfu5jQ6RyayhuuHK?=
 =?us-ascii?Q?2FESn72BamC1FcZnBW6DKRhpsedaswEGrYXRHz/lw2OnNJWJYO0tOUXFH8tc?=
 =?us-ascii?Q?USZNDcaQyLd7jthcKl3d3kyVbCscDFXZO1WC+eeH0gzBBSdBQN8U3UZaymCH?=
 =?us-ascii?Q?TqFDyIbpSpkuC5ZwzQ8n2yP3PsF6MwoXnoKQeV/E5HqQQNSBy5nNWt2BTtZn?=
 =?us-ascii?Q?FdFozTdf9l4mPi+a2+Xa23yMVq393uQZiBmSV/FRoNfO9oup8UElLHRBTRtr?=
 =?us-ascii?Q?BF6+OafGSgGKKTONiS/zJq6XScU4QToCOlUyfjsrefkNDNhveTxp+7D350dq?=
 =?us-ascii?Q?mObj2jQAN3W4GEDXyZULbPNbKHYdk70Kz5PzQ9L2Y9aiFxcJGP3kh9D5PCdL?=
 =?us-ascii?Q?75Zbatg6WuZjugGHKwQVHDk6qPt4P0eu203URBmiXNz19L7bTduok7rU4ycF?=
 =?us-ascii?Q?xju/ucJYsfA9WLqr+N/51VbXY5OTNrLdLb0VEyvLjElsPKPxGxj4CRSzRVXB?=
 =?us-ascii?Q?MJUOSpxKxYJ5yvy8u00eewKVu1mfJx47jDy3SWIzCdqA3uKNptQcGz2F2v7q?=
 =?us-ascii?Q?g/fw7IzFOCFhjuL+CXoqJcaKwmWfcqJBMP41aUvQ3VT6EVxWCiSlrwGbaMfj?=
 =?us-ascii?Q?HDMY1deeMb0+FCaOR+2ZQ/gFHSJbUCcKOx21xIKG/H4G3QYREO+lgXswrKgW?=
 =?us-ascii?Q?1hdV73YT167kl/zEp/Ewc9nUUO0CnPq2UhXcVqqLwAaM8ZZQd5/wkZCvojH8?=
 =?us-ascii?Q?pOC9V3vOe3pxdAwKFQHuwvsmoHMGEB6KuL0Lll9Mb+xoDYJgVy/PaW4NogWh?=
 =?us-ascii?Q?qQ1+TxuqBwgTGw5GvUKbcXa92hdxeRqhW5yk5ben0XNZR/18Jvb16nykY0ov?=
 =?us-ascii?Q?AuO/Vs+/++RqFL6Shc5D1p0vxObFQvau7pFy3rnCWOxz+LpAC1jhmAP/i2F3?=
 =?us-ascii?Q?62MMIvf46dtL8Q7hf4GGNLHRMo8OiKM1LZJlnYl1G/qAWJhE/185CmddEPWz?=
 =?us-ascii?Q?aTHvxQXBkdFoBOoP2nfJ9ypiTkdhM+o/M9WWl2UI/EdmhsZ+SRZTgy0lqZ9Q?=
 =?us-ascii?Q?AHbqioxH3/kH44aDxNtduXHq8O4e4mxLnwg/nKG/283O4whFx0iOvJ21Tm26?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fe0ace-62b6-4ebb-6859-08daf98aaa13
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 19:31:58.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zF6iX3mQOCtO5ZN/Cp4cUP9RqpyWk1UaTjCzWLfgZlNSNws9Bjo628wNTNKwtZhxfeUY5mjTdugNgivgOtWFTt/4Z9KhZhXhszWn1mYJ0pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4390
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

I apparently forgot an intro lol

I tested the DOE linux branch with the 2023-1-11 QEMU branch with both
volatile, non-volatile, and "legacy" (pre-my-patch) non-volatile mode.

1) *In volatile mode, there are no stack traces present (during boot*)

On Wed, Jan 18, 2023 at 02:22:08PM -0500, Gregory Price wrote:
> 
> 1) No stack traces present
> 2) Device usage appears to work, but cxl-cli fails to create a region, i
> haven't checked why yet (also tried ndctl-75, same results)
> 3) There seems to be some other regression with the cxl_pmem_init
> routine, because I get a stack trace in this setup regardless of whether
> I apply the type-3 device commit.
> 
> 
> All tests below with the previously posted DOE linux branch.
> Base QEMU branch was Jonathan's 2023-1-11
> 
> 
> DOE Branch - 2023-1-11 (HEAD) (all commits)
> 
> QEMU Config:
> sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
> -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
> -m 3G,slots=4,maxmem=8G \
> -smp 4 \
> -machine type=q35,accel=kvm,cxl=on \
> -enable-kvm \
> -nographic \
> -object memory-backend-ram,id=mem0,size=1G,share=on \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 \
> -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> 
> Result:  This worked, but cxl-cli could not create a region (will look
> into this further later).
> 
> 
> 
> 
> When running with a persistent memory configuration, I'm seeing a
> kernel stack trace on cxl_pmem_init
> 
> Config:
> sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
> -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
> -m 3G,slots=4,maxmem=4G \
> -smp 4 \
> -machine type=q35,accel=kvm,cxl=on \
> -enable-kvm \
> -nographic \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device cxl-rp,port=0,id=rp0,bus=cxl.0,chassis=0,slot=0 \
> -object memory-backend-file,id=cxl-mem0,mem-path=/tmp/mem0,size=1G \
> -object memory-backend-file,id=cxl-lsa0,mem-path=/tmp/lsa0,size=1G \
> -device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> 
> 
> [   62.167518] BUG: kernel NULL pointer dereference, address: 00000000000004c0
> [   62.185069] #PF: supervisor read access in kernel mode
> [   62.198502] #PF: error_code(0x0000) - not-present page
> [   62.211019] PGD 0 P4D 0
> [   62.220521] Oops: 0000 [#1] PREEMPT SMP PTI
> [   62.233457] CPU: 3 PID: 558 Comm: systemd-udevd Not tainted 6.2.0-rc1+ #1
> [   62.252886] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
> [   62.258432] Adding 2939900k swap on /dev/zram0.  Priority:100 extents:1 across:2939900k SSDscFS
> [   62.285513] RIP: 0010:cxl_nvdimm_probe+0x8d/0x130 [cxl_pmem]
> [   62.285529] Code: 85 c0 0f 85 90 00 00 00 f0 80 0c 24 40 f0 80 4c 24 08 10 f0 80 4c 24 08 20 f0 80 4c 24 08 40 49 8d 84 24 b8 04 00 00 4c 89 0
> [   62.285531] RSP: 0018:ffffacff0141fc38 EFLAGS: 00010202
> [   62.285534] RAX: ffff97a8a37b84b8 RBX: ffff97a8a37b8000 RCX: 0000000000000000
> [   62.285536] RDX: 0000000000000001 RSI: ffff97a8a37b8000 RDI: 00000000ffffffff
> [   62.285537] RBP: ffff97a8a37b8000 R08: 0000000000000001 R09: 0000000000000001
> [   62.285538] R10: 0000000000000001 R11: 0000000000000000 R12: ffff97a8a37b8000
> [   62.285539] R13: ffff97a982c3dc28 R14: 0000000000000000 R15: 0000000000000000
> [   62.285541] FS:  00007f2619829580(0000) GS:ffff97a9bca00000(0000) knlGS:0000000000000000
> [   62.285542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   62.285544] CR2: 00000000000004c0 CR3: 00000001056a8000 CR4: 00000000000006e0
> [   62.285653] Call Trace:
> [   62.285656]  <TASK>
> [   62.285660]  cxl_bus_probe+0x17/0x50
> [   62.285691]  really_probe+0xde/0x380
> [   62.285695]  ? pm_runtime_barrier+0x50/0x90
> [   62.285700]  __driver_probe_device+0x78/0x170
> [   62.285846]  driver_probe_device+0x1f/0x90
> [   62.285850]  __driver_attach+0xd2/0x1c0
> [   62.285853]  ? __pfx___driver_attach+0x10/0x10
> [   62.285856]  bus_for_each_dev+0x76/0xa0
> [   62.285860]  bus_add_driver+0x1b1/0x200
> [   62.285863]  driver_register+0x89/0xe0
> [   62.285868]  ? __pfx_init_module+0x10/0x10 [cxl_pmem]
> [   62.285874]  cxl_pmem_init+0x50/0xff0 [cxl_pmem]
> [   62.285880]  do_one_initcall+0x6e/0x330
> [   62.285888]  do_init_module+0x4a/0x200
> [   62.285892]  __do_sys_finit_module+0x93/0xf0
> [   62.285899]  do_syscall_64+0x5b/0x80
> [   62.285904]  ? do_syscall_64+0x67/0x80
> [   62.285906]  ? asm_exc_page_fault+0x22/0x30
> [   62.285910]  ? lockdep_hardirqs_on+0x7d/0x100
> [   62.285914]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   62.285917] RIP: 0033:0x7f2619b0afbd
> [   62.285920] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 8
> [   62.285922] RSP: 002b:00007ffcc516bf58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   62.285924] RAX: ffffffffffffffda RBX: 00005557c0dcaa60 RCX: 00007f2619b0afbd
> [   62.285925] RDX: 0000000000000000 RSI: 00007f261a18743c RDI: 0000000000000006
> [   62.285926] RBP: 00007f261a18743c R08: 0000000000000000 R09: 00007f261a17bb52
> [   62.285927] R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
> [   62.285928] R13: 00005557c0dbbce0 R14: 0000000000000000 R15: 00005557c0dc18a0
> [   62.285932]  </TASK>
> [   62.285933] Modules linked in: cxl_pmem(+) snd_pcm libnvdimm snd_timer snd joydev bochs cxl_mem drm_vram_helper parport_pc soundcore drm_ttm_g
> [   62.285954] CR2: 00000000000004c0
> [   62.288385] ---[ end trace 0000000000000000 ]---
> [   63.203514] RIP: 0010:cxl_nvdimm_probe+0x8d/0x130 [cxl_pmem]
> [   63.203562] Code: 85 c0 0f 85 90 00 00 00 f0 80 0c 24 40 f0 80 4c 24 08 10 f0 80 4c 24 08 20 f0 80 4c 24 08 40 49 8d 84 24 b8 04 00 00 4c 89 0
> [   63.203565] RSP: 0018:ffffacff0141fc38 EFLAGS: 00010202
> [   63.203570] RAX: ffff97a8a37b84b8 RBX: ffff97a8a37b8000 RCX: 0000000000000000
> [   63.203572] RDX: 0000000000000001 RSI: ffff97a8a37b8000 RDI: 00000000ffffffff
> [   63.203574] RBP: ffff97a8a37b8000 R08: 0000000000000001 R09: 0000000000000001
> [   63.203576] R10: 0000000000000001 R11: 0000000000000000 R12: ffff97a8a37b8000
> [   63.203577] R13: ffff97a982c3dc28 R14: 0000000000000000 R15: 0000000000000000
> [   63.203580] FS:  00007f2619829580(0000) GS:ffff97a9bca00000(0000) knlGS:0000000000000000
> [   63.203583] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   63.203585] CR2: 00000000000004c0 CR3: 00000001056a8000 CR4: 00000000000006e0
> 
> 
> 
> Next i reverted the QEMU branch to the commit just before the type-3
> volatile commit and used the old method of launching with a type-3 pmem
> device
> 
> Config:
> sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
> -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
> -m 2G,slots=4,maxmem=4G \
> -smp 4 \
> -machine type=q35,accel=kvm,cxl=on \
> -enable-kvm \
> -nographic \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 \
> -object memory-backend-file,pmem=true,id=cxl-mem0,mem-path=/tmp/cxl-mem0,size=1G \
> -object memory-backend-file,pmem=true,id=lsa0,mem-path=/tmp/cxl-lsa0,size=1G \
> -device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> 
> 
> Result: Similar stack trace
> [   29.850023] BUG: kernel NULL pointer dereference, address: 00000000000004c0
> [   29.882400] RIP: 0010:cxl_nvdimm_probe+0x8d/0x130 [cxl_pmem]
> [   29.957485] Call Trace:
> [   29.959067]  <TASK>
> [   29.962176]  cxl_bus_probe+0x17/0x50
> [   29.964940]  really_probe+0xde/0x380
> [   29.969065]  ? pm_runtime_barrier+0x50/0x90
> [   29.973419]  __driver_probe_device+0x78/0x170
> [   29.977183]  driver_probe_device+0x1f/0x90
> [   29.984212]  __driver_attach+0xd2/0x1c0
> [   29.988463]  ? __pfx___driver_attach+0x10/0x10
> [   29.992379]  bus_for_each_dev+0x76/0xa0
> [   29.997040]  bus_add_driver+0x1b1/0x200
> [   30.000368]  driver_register+0x89/0xe0
> [   30.004579]  ? __pfx_init_module+0x10/0x10 [cxl_pmem]
> [   30.012403]  cxl_pmem_init+0x50/0xff0 [cxl_pmem]
> [   30.019394]  do_one_initcall+0x6e/0x330
> [   30.024028]  do_init_module+0x4a/0x200
> [   30.029243]  __do_sys_finit_module+0x93/0xf0
> [   30.034943]  do_syscall_64+0x5b/0x80
> [   30.039844]  ? do_syscall_64+0x67/0x80
> [   30.045163]  ? do_syscall_64+0x67/0x80
> [   30.049729]  ? lock_release+0x14b/0x440
> [   30.054055]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
> [   30.061039]  ? lock_is_held_type+0xe8/0x140
> [   30.067625]  ? do_syscall_64+0x67/0x80
> [   30.071909]  ? lockdep_hardirqs_on+0x7d/0x100
> [   30.079037]  ? do_syscall_64+0x67/0x80
> [   30.084537]  ? do_syscall_64+0x67/0x80
> [   30.089091]  ? do_syscall_64+0x67/0x80
> [   30.094174]  ? lockdep_hardirqs_on+0x7d/0x100
> [   30.099224]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   30.104446] RIP: 0033:0x7f000550afbd
