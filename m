Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0078BFA3740
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 19:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiJXTNL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiJXTMc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 15:12:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3843B18E29A
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 10:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXCnoytyE2yrFUgWaccZE+9R39LssX24vYpJzR6rOuUJN8e742cxdGoCPOffhnq4y/yEzAYH4YKTOJTRLKsnFTdRgvNIdFMBIQaZaxkFRkFS4TrGsI2+52O3qFuh0yLq2cdpOqqKHyVghrhxKyR3pH6NdNYeh2fXJtGDE032fJWUflauurirF+nj5UPfh6YgaODUIVZGE/TrEvuxwdPqswCv7/gcVw7+ehvBHpcQoY70IPXe8SNT1KbxSf8z44/9Gsu3A9XF1fz0rPxmr+P8S8/5j3C0pgIhwW9KUBK/jVErq7awqz5RqYe/1vvJHtIOatNe+QejUot26AIVxGAXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRduR32tXDSllLna0wFatC5f2GK+KpG6E8/o2ntC0Os=;
 b=oVn5eBPst5xxouCb5+beZJ+lpimvYoUeDE65LpsVo5E2WkSV8NWUJ/spC2CP0DCA4qMumlDzQzQEa1B8eU7f2qA3ocjG7WwbrK4R6btg0AQpAl6uPDUUNNtbcBUCHHV4Y3EdY/mNs3HYTH0E85+pygRLz69bpJC4flRyYWNmwibqBTBR8LmL35QxveSbLFsgEHhsqQAvNTBypKyowiZJVkU+b+QwRZrD81FpxNx1Ie7Q7qzft5fYDzv9f7X9OycqgubIh5mzP/9fKO3+JkhiM7+j+3uif7sm7jytAR1y3Qg4Y+rUAHutAPrN4L9tYn/jmrKQIoVer2LAyzuKkFwEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRduR32tXDSllLna0wFatC5f2GK+KpG6E8/o2ntC0Os=;
 b=i4ldl/UbEXP4TduLSWVgHEafleW5dQNNc0z6+3uSMVjUS6CmuuPGrTYNJD1uFbAzvQmILN3q7gEIh3WM8oz+Dlx0zDX9YW+urZ5BEJz2t+aZo5QIE0tHm5phnogJm1cjEgi84wELtKKbjiPD/oWZkVeT9ynsFZCnTt1lEd7oagk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DS0PR17MB6173.namprd17.prod.outlook.com (2603:10b6:8:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 17:43:01 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18%7]) with mapi id 15.20.5746.028; Mon, 24 Oct 2022
 17:43:01 +0000
Date:   Mon, 24 Oct 2022 13:42:54 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>, ira.weiny@intel.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v9 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <Y1bOniJliOFszvIK@memverge.com>
References: <20221014151045.24781-1-Jonathan.Cameron@huawei.com>
 <20221014151045.24781-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014151045.24781-5-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BL0PR1501CA0014.namprd15.prod.outlook.com
 (2603:10b6:207:17::27) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DS0PR17MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 672a2903-ebe0-4ece-1cef-08dab5e731fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6ElR3xQsRr25gZpe4igseAeydwQ7wyTP6B3KDHPbKZTqvGRPZhsNLGHqLLwJOiTZue508zrSkFxz7a1KC3b5Qn+ou5Y8WKwGrXuGshhJ3VcfK83a2o9Xld7Pd9B4fPs8GF+idPJoytAM/04eBFPnocRq4WC3oV0W4cUHC4+D/UHwaS8wlR2f5FSy3KcXEisev81eW5qT5kY4+WPsaFti1bqkEtLV4hc0nU92SHpjWrFXJz6vJlDYABciEdHdR0/I4U6hxWzeKOQIHb70lBJcXvMlmdIaLlFpa1KcmkqoXDp33EkZ1oS1aph2UbQtNfd8Mg4jsWiQx9/fm8M0v5pO6eZQe0UqDR36FVHFIniV71yRM0XmOGu1LyhXvXUP7Do5QrKvPIEuuefiydkOs0hiqG7KS5YeVtb86RMEkiwkcWREuNaRWALRoBIlriWIzQNzqlxoDj6EVIZpT8p9qQiXUkC1KAOlyT2dAGFWPc/VaQIlN3186ais9U2pb/3msMRg/MZ1M5H0kdKjWY8oYmsKHYSKEuxlOvj8s41lfHqK7cJYz/2V+QZZXwNm80W+JrmEpm02hi0FlMtT66F3A8PdQ4DaVmnY9sJ2UOPvswnc1sX5KFcHKnrDaN67VgLXdPdMXu9vCq1qK5l+qeWLP2zc/hcjF5fsId7RV1Yq0IinsiHkIKjezoq5VznrPjPVvKr0oMJFAIaG1i3m74GsJvwjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(346002)(136003)(396003)(376002)(366004)(451199015)(66476007)(66556008)(66946007)(8676002)(4326008)(8936002)(2906002)(86362001)(41300700001)(316002)(6916009)(5660300002)(54906003)(45080400002)(44832011)(30864003)(38100700002)(186003)(83380400001)(6486002)(6666004)(478600001)(2616005)(6506007)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOLhB+Aa0mZ0vJ6FSb2ohQcW7fsHuQEjXoe58NZweE2As7nqISFnJF3D2EAH?=
 =?us-ascii?Q?/iIaZjuo2GNkPfzKEe04JbIQ+cSeYae8ploFnxsCUgOjRBbtSQ+hXestQrXd?=
 =?us-ascii?Q?h4FMYueWMXqg9MvFuRTEpfUS9+/ZHW0D+XSJSoRkzaFrCbjkevaUZYQYsFuq?=
 =?us-ascii?Q?+Ev/30fgyY7wW0A5GTtfvuVGu0HQlGI1bnPasLN9DB9g7/ONCyxiQ/nRVVFb?=
 =?us-ascii?Q?lenTF03eB7NcAhxWlhfryiFvcQejOHuX1mAwRo+W93ZO03XIVHyt+vDJ26Ct?=
 =?us-ascii?Q?1ytSLWVG9ey1qTEtjMUekZvVtoeBgp/3PJo0CxvPtFJdJcpLr8an4sd6tjW2?=
 =?us-ascii?Q?s1zZ9Exz3dELL65eyDXcdrXMy0Ac1/o+JL9YJRA/InLYX7xpp8WrFCBC2eSt?=
 =?us-ascii?Q?QqP/KvrUcAYPlpFTvbBE/dfz/Y1WdMd6726ZKfsWlL9/W6Qh4vX3aNP3FLfT?=
 =?us-ascii?Q?BiUG0ZXG5adEpjujr16KcdCIY2MGkDoWxVQoXK3fsIejRdQpYsYJAbMFc0Vq?=
 =?us-ascii?Q?8tV+Fvi3gMdF9nAXFor4HiPqy4U8eGFxn+JtgvAgMl+mDAkh3hP2W1aNLLIT?=
 =?us-ascii?Q?RWYzlkDk74g1vtauXBMkN2p71mieMGdAyYazUzMpFGslu7y3WmO+aBW2QCrp?=
 =?us-ascii?Q?DNVvdCefZnmsk+TfhEwS4GXYaA+O+kVA6bgeyLgjTyTOV9PbG9UZYBBpLD8h?=
 =?us-ascii?Q?MiTOzBL8hOr8a+20RdsZ0g3ND+syCXUPavfCaYyRH/g6zaxU4gFah+hwAoQ1?=
 =?us-ascii?Q?Pl5TuGcHgs5Cl834ytlNtOLlHJESOtFbHvnXNE0UghWZS9iFMKOuSo+XPBOh?=
 =?us-ascii?Q?g/xhuZgnbjtRwVd2N7eGrzwAzI20dpFh0PCaxUJi2kasCeV+ky6XR0JmOnCq?=
 =?us-ascii?Q?HHwi2yPS+7AQOVRZein/TtHRRw+HgyT2HaszhW92mImpKXrJz6LZTN+5t+/H?=
 =?us-ascii?Q?pFh4nspeCue1haXLxXEEmyChtEIDS80+eeWqlphc+H7lyy/hVedk+cwntAqX?=
 =?us-ascii?Q?OxK8tZSS/lBAD3NQMpVjdB2If/FPS71vXmsumS2P/jXUypVVdLTtcR+zH/N5?=
 =?us-ascii?Q?AV/AE4oScbnC+A1X2zXS+Gy6kYRIvdOybHSbSUiXWXiF9aHZw1H3of/V5QDK?=
 =?us-ascii?Q?svl5OIqiQrkBRUMX7YhzPLDyiaC5BdtXs+oE1j1D7mWS77isjeVja1rxZpqw?=
 =?us-ascii?Q?cnQ0yQi6wAnuByAOfdoynKLW9F1rW4HNJJiuPvpkYgCS+WmTh3nwW6e9+OFi?=
 =?us-ascii?Q?iN5RJ0kRjWaxdysjv/6/5vEUGXch0IcF3zglnm9c6bEqHqlClMMB/go8AFO5?=
 =?us-ascii?Q?OLSLs44QIfz5RJfE5uaFz0lf/rY/VXqSD4TUREtlvII4l1pGVnT5o6mMbYx0?=
 =?us-ascii?Q?/tONKKMDRF91jNvGEHMLaukC1iRKMG+EZmdj/MW+0ICWKoVlFsVSDGkt2AVk?=
 =?us-ascii?Q?OXMTj+2HsfKHh1aAPxnyGnK4xutzLvpqJeyH7eYDCsX1N+fS66lOkxIBjezA?=
 =?us-ascii?Q?v1D3QQdSxhDSVmPRtRSwv9DBfxjic8Xtu7BjJaP5gljflQvwOOgmEC7fmrix?=
 =?us-ascii?Q?SzdBZDzFP5yQp10or+zQOh/LjTzdKW4Ub7jNKHUnoBLg1aic4CgEZjZf9FWR?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672a2903-ebe0-4ece-1cef-08dab5e731fc
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 17:43:00.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spayw+U9eKlgruW5MR2MdtjIoZ6oHAZCzwunxu2oxu0xtOrn6HehorRExjXZqrPUKdLNzD9C+5DER+zfpA4SkGRyyAbmjhieR0q9XMiRRg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6173
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 14, 2022 at 04:10:44PM +0100, Jonathan Cameron wrote:
> From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> 
> The CDAT can be specified in two ways. One is to add ",cdat=<filename>"
> in "-device cxl-type3"'s command option. The file is required to provide
> the whole CDAT table in binary mode. The other is to use the default
> that provides some 'reasonable' numbers based on type of memory and
> size.
> 
> The DOE capability supporting CDAT is added to hw/mem/cxl_type3.c with
> capability offset 0x190. The config read/write to this capability range
> can be generated in the OS to request the CDAT data.
> 
> Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> Signed-off-by: Chris Browy <cbrowy@avery-design.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

In reviewing this patch under a debug kernel, I'm discovering some
warnings / tracebacks that I want to get a sanity check on.  They appear
to be warnings, but i'm not 100% sure what to make of them.

I get the following stack traces during boot (on the x86 machine).

Removing the type-3 device from the configuration prevents the traceback
from occurring, suggesting it's something to do with that code in
particular (which tracks with the patch here)

configuration:

qemu-system-x86_64 -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
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

==== trace 1 ====

[   30.607343] WARNING: CPU: 0 PID: 23 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
[   30.688367] Modules linked in:
[   30.703848] CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 #1
[   30.794232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   30.862301] Workqueue: events_unbound async_run_entry_fn
[   30.890460] RIP: 0010:__debug_object_init.cold+0x18/0x183
[   30.917120] Code: 0b 48 89 fe 48 c7 c7 e0 a7 9a b6 e8 50 74 fd ff 0f 0b 83 c0 01 48 89 ee 48 c7 c7 d8 a9 9a b6 89 05 f9 d7 bd 03 e8 36 74 fd 0
[   31.019141] RSP: 0018:ffffbffb800c3a90 EFLAGS: 00010246
[   31.043604] RAX: 0000000000000050 RBX: ffff9bbec8f7c1b8 RCX: 0000000000000000
[   31.103764] RDX: 0000000000000001 RSI: 00000000ffffdfff RDI: 00000000ffffffff
[   31.134239] RBP: ffffbffb800c3bb0 R08: 0000000000000000 R09: ffffbffb800c3938
[   31.188841] R10: 0000000000000003 R11: ffffffffb7366368 R12: ffffffffb6440940
[   31.218418] R13: 0000000000130b50 R14: ffffffffb9c33b58 R15: ffffffffb9c33b50
[   31.273389] FS:  0000000000000000(0000) GS:ffff9bbf3da00000(0000) knlGS:0000000000000000
[   31.315480] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.352369] CR2: 00007fcd1cd57c08 CR3: 0000000049228000 CR4: 00000000000006f0
[   31.397279] Call Trace:
[   31.412605]  <TASK>
[   31.424189]  pci_doe_submit_task+0x5d/0xd0
[   31.459591]  pci_doe_discovery+0xb4/0x100
[   31.478560]  ? pci_doe_xa_destroy+0x10/0x10
[   31.499449]  pcim_doe_create_mb+0x219/0x290
[   31.516835]  cxl_pci_probe+0x192/0x430
[   31.532501]  local_pci_probe+0x41/0x80
[   31.549181]  pci_device_probe+0xb3/0x220
[   31.587266]  really_probe+0xde/0x380
[   31.601778]  ? pm_runtime_barrier+0x50/0x90
[   31.618854]  __driver_probe_device+0x78/0x170
[   31.656184]  driver_probe_device+0x1f/0x90
[   31.675865]  __driver_attach_async_helper+0x5c/0xe0
[   31.692896]  async_run_entry_fn+0x30/0x130
[   31.707297]  process_one_work+0x294/0x5b0
[   31.722375]  worker_thread+0x4f/0x3a0
[   31.741028]  ? process_one_work+0x5b0/0x5b0
[   31.757448]  kthread+0xf5/0x120
[   31.770179]  ? kthread_complete_and_exit+0x20/0x20
[   31.806496]  ret_from_fork+0x22/0x30
[   31.831317]  </TASK>
[   31.840206] irq event stamp: 1597
[   31.853893] hardirqs last  enabled at (1611): [<ffffffffb518e8de>] __up_console_sem+0x5e/0x70
[   31.908805] hardirqs last disabled at (1624): [<ffffffffb518e8c3>] __up_console_sem+0x43/0x70
[   31.965293] softirqs last  enabled at (354): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
[   32.000551] softirqs last disabled at (345): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
[   32.121265] ---[ end trace 0000000000000000 ]---


==== trace 2 ====

[   99.902268] WARNING: CPU: 0 PID: 530 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
[   99.921567] Modules linked in: i2c_i801(+) cxl_mem(+) bochs(+) pcspkr(+) drm_vram_helper i2c_smbus drm_ttm_helper ttm parport_pc(+) lpc_ich pg
[   99.956391] CPU: 0 PID: 530 Comm: systemd-udevd Tainted: G        W         -------  ---  6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 1
[   99.978561] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  100.000618] RIP: 0010:__debug_object_init.cold+0x18/0x183
[  100.011232] Code: 0b 48 89 fe 48 c7 c7 e0 a7 9a b6 e8 50 74 fd ff 0f 0b 83 c0 01 48 89 ee 48 c7 c7 d8 a9 9a b6 89 05 f9 d7 bd 03 e8 36 74 fd 0
[  100.047919] RSP: 0018:ffffbffb80c6b770 EFLAGS: 00010246
[  100.060167] RAX: 0000000000000050 RBX: ffff9bbec9448b40 RCX: 0000000000000000
[  100.080397] RDX: 0000000000000001 RSI: ffffffffb698ef83 RDI: 00000000ffffffff
[  100.099485] RBP: ffffbffb80c6b918 R08: 0000000000000000 R09: ffffbffb80c6b618
[  100.116927] R10: 0000000000000003 R11: ffffffffb7366368 R12: ffffffffb6440940
[  100.134762] R13: 00000000000ec680 R14: ffffffffb9bef688 R15: ffffffffb9bef680
[  100.151144] FS:  00007f485962c580(0000) GS:ffff9bbf3da00000(0000) knlGS:0000000000000000
[  100.168115] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.181757] CR2: 000055f120bfa028 CR3: 0000000009598000 CR4: 00000000000006f0
[  100.196873] Call Trace:
[  100.205142]  <TASK>
[  100.211998]  pci_doe_submit_task+0x5d/0xd0
[  100.225314]  cxl_cdat_get_length+0xb8/0x110
[  100.237607]  ? dvsec_range_allowed+0x60/0x60
[  100.251315]  read_cdat_data+0xaf/0x1a0
[  100.259359]  cxl_port_probe+0x80/0x120
[  100.270131]  cxl_bus_probe+0x17/0x50
[  100.280874]  really_probe+0xde/0x380
[  100.290308]  ? pm_runtime_barrier+0x50/0x90
[  100.301589]  __driver_probe_device+0x78/0x170
[  100.313626]  driver_probe_device+0x1f/0x90
[  100.338204]  __device_attach_driver+0x85/0x110
[  100.357875]  ? driver_allows_async_probing+0x70/0x70
[  100.367909]  bus_for_each_drv+0x7a/0xb0
[  100.376261]  __device_attach+0xb3/0x1d0
[  100.384565]  bus_probe_device+0x9f/0xc0
[  100.403420]  device_add+0x41e/0x9b0
[  100.424240]  ? kobject_set_name_vargs+0x6d/0x90
[  100.437082]  ? dev_set_name+0x4b/0x60
[  100.452290]  devm_cxl_add_port+0x27b/0x3b0
[  100.477464]  devm_cxl_add_endpoint+0x82/0x130
[  100.506916]  cxl_mem_probe+0xc4/0x11d [cxl_mem]
[  100.525895]  cxl_bus_probe+0x17/0x50
[  100.556013]  really_probe+0xde/0x380
[  100.567388]  ? pm_runtime_barrier+0x50/0x90
[  100.604187]  __driver_probe_device+0x78/0x170
[  100.623848]  driver_probe_device+0x1f/0x90
[  100.643793]  __driver_attach+0xd5/0x1d0
[  100.655270]  ? __device_attach_driver+0x110/0x110
[  100.668906]  bus_for_each_dev+0x76/0xa0
[  100.684247]  bus_add_driver+0x1b1/0x200
[  100.694768]  driver_register+0x89/0xe0
[  100.706379]  ? 0xffffffffc03e7000
[  100.715846]  do_one_initcall+0x6e/0x320
[  100.726612]  do_init_module+0x4a/0x200
[  100.738882]  __do_sys_init_module+0x16a/0x1a0
[  100.752941]  do_syscall_64+0x5b/0x80
[  100.766652]  ? do_syscall_64+0x67/0x80
[  100.779569]  ? asm_exc_page_fault+0x22/0x30
[  100.794089]  ? lockdep_hardirqs_on+0x7d/0x100
[  100.813769]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  100.829029] RIP: 0033:0x7f485991253e
[  100.840991] Code: 48 8b 0d e5 58 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 8
[  100.904842] RSP: 002b:00007ffd96d322b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[  100.936376] RAX: ffffffffffffffda RBX: 000055f120b724b0 RCX: 00007f485991253e
[  100.971138] RDX: 00007f4859f9643c RSI: 0000000000002dbe RDI: 000055f120bdd000
[  101.016019] RBP: 00007f4859f9643c R08: 000055f120bd47f0 R09: 00007ffd96d2ef1e
[  101.042435] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000020000
[  101.073437] R13: 000055f120bd4530 R14: 0000000000000000 R15: 000055f120bd4860
[  101.120278]  </TASK>
[  101.132024] irq event stamp: 102985
[  101.153401] hardirqs last  enabled at (102999): [<ffffffffb518e8de>] __up_console_sem+0x5e/0x70
[  101.184098] hardirqs last disabled at (103014): [<ffffffffb518e8c3>] __up_console_sem+0x43/0x70
[  101.236473] softirqs last  enabled at (101888): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
[  101.294275] softirqs last disabled at (101757): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160


==== trace 3 ====

[  111.356606] WARNING: CPU: 0 PID: 530 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
[  111.366842] Modules linked in: iTCO_wdt ppdev intel_pmc_bxt iTCO_vendor_support cxl_pmem libnvdimm snd_pcm snd_timer snd e1000e soundcore joyg
[  111.396404] CPU: 0 PID: 530 Comm: systemd-udevd Tainted: G        W         -------  ---  6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 1
[  111.410199] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  111.422370] RIP: 0010:__debug_object_init.cold+0x18/0x183
[  111.429086] Code: 0b 48 89 fe 48 c7 c7 e0 a7 9a b6 e8 50 74 fd ff 0f 0b 83 c0 01 48 89 ee 48 c7 c7 d8 a9 9a b6 89 05 f9 d7 bd 03 e8 36 74 fd 0
[  111.453462] RSP: 0000:ffffbffb80c6b748 EFLAGS: 00010246
[  111.463194] RAX: 0000000000000050 RBX: ffff9bbec84818e8 RCX: 0000000000000000
[  111.472081] RDX: 0000000000000001 RSI: ffffffffb698ef83 RDI: 00000000ffffffff
[  111.481240] RBP: ffffbffb80c6b908 R08: 0000000000000000 R09: ffffbffb80c6b5f0
[  111.490230] R10: 0000000000000003 R11: ffffffffb7366368 R12: ffffffffb6440940
[  111.499437] R13: 00000000000ec680 R14: ffffffffb9bef688 R15: ffffffffb9bef680
[  111.507544] FS:  00007f485962c580(0000) GS:ffff9bbf3da00000(0000) knlGS:0000000000000000
[  111.518473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  111.529110] CR2: 000055ea819dc228 CR3: 0000000009598000 CR4: 00000000000006f0
[  111.539622] Call Trace:
[  111.543604]  <TASK>
[  111.547146]  pci_doe_submit_task+0x5d/0xd0
[  111.553235]  cxl_cdat_read_table.isra.0+0x141/0x190
[  111.559888]  ? dvsec_range_allowed+0x60/0x60
[  111.566950]  read_cdat_data+0xfc/0x1a0
[  111.572438]  cxl_port_probe+0x80/0x120
[  111.579219]  cxl_bus_probe+0x17/0x50
[  111.586051]  really_probe+0xde/0x380
[  111.592435]  ? pm_runtime_barrier+0x50/0x90
[  111.598580]  __driver_probe_device+0x78/0x170
[  111.604947]  driver_probe_device+0x1f/0x90
[  111.610825]  __device_attach_driver+0x85/0x110
[  111.616997]  ? driver_allows_async_probing+0x70/0x70
[  111.623939]  bus_for_each_drv+0x7a/0xb0
[  111.629126]  __device_attach+0xb3/0x1d0
[  111.634907]  bus_probe_device+0x9f/0xc0
[  111.641211]  device_add+0x41e/0x9b0
[  111.650591]  ? kobject_set_name_vargs+0x6d/0x90
[  111.659416]  ? dev_set_name+0x4b/0x60
[  111.665160]  devm_cxl_add_port+0x27b/0x3b0
[  111.671486]  devm_cxl_add_endpoint+0x82/0x130
[  111.677424]  cxl_mem_probe+0xc4/0x11d [cxl_mem]
[  111.684237]  cxl_bus_probe+0x17/0x50
[  111.690079]  really_probe+0xde/0x380
[  111.695487]  ? pm_runtime_barrier+0x50/0x90
[  111.702526]  __driver_probe_device+0x78/0x170
[  111.710317]  driver_probe_device+0x1f/0x90
[  111.716468]  __driver_attach+0xd5/0x1d0
[  111.721786]  ? __device_attach_driver+0x110/0x110
[  111.728178]  bus_for_each_dev+0x76/0xa0
[  111.736175]  bus_add_driver+0x1b1/0x200
[  111.741584]  driver_register+0x89/0xe0
[  111.747214]  ? 0xffffffffc03e7000
[  111.753161]  do_one_initcall+0x6e/0x320
[  111.759145]  do_init_module+0x4a/0x200
[  111.773055]  __do_sys_init_module+0x16a/0x1a0
[  111.782164]  do_syscall_64+0x5b/0x80
[  111.788480]  ? do_syscall_64+0x67/0x80
[  111.795108]  ? asm_exc_page_fault+0x22/0x30
[  111.803255]  ? lockdep_hardirqs_on+0x7d/0x100
[  111.811142]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  111.818426] RIP: 0033:0x7f485991253e
[  111.824120] Code: 48 8b 0d e5 58 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 8
[  111.873034] RSP: 002b:00007ffd96d322b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[  111.888776] RAX: ffffffffffffffda RBX: 000055f120b724b0 RCX: 00007f485991253e
[  111.913156] RDX: 00007f4859f9643c RSI: 0000000000002dbe RDI: 000055f120bdd000
[  111.931096] RBP: 00007f4859f9643c R08: 000055f120bd47f0 R09: 00007ffd96d2ef1e
[  111.945030] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000020000
[  111.959393] R13: 000055f120bd4530 R14: 0000000000000000 R15: 000055f120bd4860
[  111.987474]  </TASK>
[  112.002511] irq event stamp: 104291
[  112.011044] hardirqs last  enabled at (104307): [<ffffffffb518e8de>] __up_console_sem+0x5e/0x70
[  112.046936] hardirqs last disabled at (104320): [<ffffffffb518e8c3>] __up_console_sem+0x43/0x70
[  112.066433] softirqs last  enabled at (103208): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
[  112.086461] softirqs last disabled at (103183): [<ffffffffb51012ed>] __irq_exit_rcu+0xed/0x160
[  112.107575] ---[ end trace 0000000000000000 ]---
