Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCADC61DB3
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Jan 2023 22:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjALWrI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbjALWqt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 Jan 2023 17:46:49 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042FD5EC30
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jan 2023 14:46:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFqfmVpIT8Mpep7uZqnYavdJ1RdQI1f3MrbLuXpRYVP5O3Iw7qDNguqv3I/v58I8P63UP8Bd3WaJ1iqIQFaTRrtAzVwh7oTtOv/KNQvg4/7E3CeRldkyv/NWZBEQXwxv7rd3yPqVesTdvbVfJJhKz/Yif/8phauEoaQk4yG2dod5iXBu/wcng+K7DVcZmGEf9aIwooe/ZAVQ3X2IZtvXJgHqIIZ3hGOprjF5/kmsu9JidRA1HAzyTZYV6fE3i3lyjMFV42aIhqe0O68u1Z1C6HqUB58ySzhMB2lhrcaYBZFtcifDP6d9hCFSQXKwS5whAUrqAVHZ1aUsmigmbju0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tsOanl++S5GcbCuyrL9sMAG50Um6/jmM1C3//EBPzU=;
 b=f676PIiTkc3vr+ruFiEfHtd1JqvAYWIYnb9F7TucqZ1oXIvxrCDgHVqLeF3jbOs/eecROn66GljD1NVPg+UA9Ev2RBDRoStCIo4EkTVu3E2Z/fNVKZUtR8lpWCLPP/7JqeyFWFZ5bc106HqnDG0uu5UAs95FpCy5yAClKI+Lx60Wr4F/vSNZ3sQOKEVVZiDZ/TpWp2Tz2yiUV7tIq3p17NpmiG8oI2nCuhdrec8Xm/WqXIMNBV7wQufogXz9t1X2xtMss+HZgSV48PYs5se2TW65ruGfNUryIvv4THssQq2AWR1ikzl7C/TrYTxkg4dTGA9wfyGHR7g8qHocE1j9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tsOanl++S5GcbCuyrL9sMAG50Um6/jmM1C3//EBPzU=;
 b=y9M3DgaPW4e+sIUOueCWhRESnjwf+0ttCu12dEZlhAhrCL+AhRTk02JjLspSOGbOEa4ydkrKvGG1h2MGHvDamnhCaovPd8PunZk4GITrbOwW6xDyavLVGf3Ju+WlPDoK66Je9Bur83eJqw0ufvzDWmS4yktju9nbIdGoIoZ8ul0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB4816.namprd17.prod.outlook.com (2603:10b6:510:8c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Thu, 12 Jan
 2023 22:46:37 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 22:46:36 +0000
Date:   Thu, 12 Jan 2023 17:46:27 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <Y8CNw/fZT5fZJZcK@memverge.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <Y8AppXP+eP9cEz+i@memverge.com>
 <20230112172130.0000391b@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112172130.0000391b@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a1a6e0-38cc-42dd-fd64-08daf4eedc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYVdZuffdSSZ5cU9AeAKUejavUhtHmIiTCCxpiJ5J4MBwvLwaCeAzBKTCScojicbqfaa8kT4SVDSf5CJ/GiKm0uQGr2FmwB8ZTJ+cJ0iIk980+/3B41BYlzcnfG1YlXxj8IAsh2g2faprSRPPaVhw2DO2G6gkvxmEQxGpTUBGoeJm7zfzkdSugdH2rEnD4PX4meTT4yAXx1eBAcJdj7aDHpf8m9xToi+xI/T4qszCRgdF+81IkyPTjZT4nJe2tdmD2NQo89Z45ffXGkoDfZmkeFpvIveE8EI9tcy8QvQzEMIhhfOaM6+q7JbOIdr08jZvVY+qoggOsULcm3Rg+GPVB04RsxEzukqtXzF0IzFot9zBRx13brxDNPrr62Plp71AxEGpunxwXvxKh1ePug17RIM1LPdhHvf9v0y9mTTtUujwJCoM+xp9N8ywR6RRrl9NkpYROzn/zTe2K/SVFApGyR/WaaZvcMFxMvNW20aKCzFUT4fs3C+vyDMF1+NoqpYMC9gYnFN1mVA/K/Q4HDJxFrPLJ1GzQTYr1vcqcmEj/YlLIfSKKSpcs0AP9pI+7kI6AjLdmQ6pCv19aVDuM8NuyQNH6JZnCjMtT3FI4mNgqnqhXgINInWXhbIfjOOx4JxMgwiwPZWYguvbGHOROoKLLfCGwX0HIMr5X1ZlqOyn5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(39830400003)(376002)(346002)(451199015)(41300700001)(36756003)(44832011)(186003)(8936002)(5660300002)(26005)(6512007)(966005)(2616005)(6486002)(6506007)(478600001)(6666004)(83380400001)(316002)(54906003)(86362001)(4326008)(6916009)(66556008)(66476007)(8676002)(66946007)(38100700002)(66899015)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4uGcJOCU4l/KOGkePAA8dfs3lOXXgrTFuPqxnvX37WNYUAzqngJGWx7zb1h?=
 =?us-ascii?Q?pqU5q9U8QJE3yT88U4RlekT9/e4Uce8erfFNugZXKKpMIB/8bpCL3E2feWxc?=
 =?us-ascii?Q?ttHbEG4sseKHRIQTsi4UX2T6p35exC/G88gNZ7BclRKHpW4S+2vlZc50CinL?=
 =?us-ascii?Q?DjD0Jve5q5UgKAZlS/lg7RGcM3Clr3WhEHyVBJIKnOhbCRiP252K86ZWCkTU?=
 =?us-ascii?Q?1XykRLSgszJkoLOlpVZYPKJoILBGRcOYv14bw5+I1zqktHwDB/l9ge8nfrjX?=
 =?us-ascii?Q?K9aB/OkMTf49JDK8EvBGtvScPTsTQJEsPTupfMT4S3SAoQZQw2ZNXqcr22g1?=
 =?us-ascii?Q?k6unyszNMBTI9wGIxhFoPctI0YGgIBsln6l74/Aakti9MOENwqVl5blqD6LL?=
 =?us-ascii?Q?qOsSATQS3/9+XaNe6K7jmiPy1oqH+EQO9pQcRubHfJodLLcoQ+esqIT9yr1K?=
 =?us-ascii?Q?NeiVbuunmOYwzdlO2/d0sZY0sJXV9uLUQAPkL/GetjC5lMUrqpsV3eXUsWAv?=
 =?us-ascii?Q?dpJZBAQz6FHE/AEgn4fXprC8rRFGx1svAuBC6AtxBR2/9w1KEOlAHGsFWeox?=
 =?us-ascii?Q?2TlioHwBu2IxC19/vJL/iWQFzaPCesQBIEQvvq6+ySHMD5+7n4dL3s2ZVrWh?=
 =?us-ascii?Q?lMx7FcboIenTrZQlZErmgW8tSJktQLmw8TRaWKVMs/id93zLMDtu+22xyR9f?=
 =?us-ascii?Q?ISwQFgVdRyrgKU6L5n37CSGZlL2T4dwHvlsIbEN8tXnOKet0ZaUc74XDlrZA?=
 =?us-ascii?Q?2BjsK9XYl6C+8MvEgddQ/vhzLcZG4cT92QVOYz+5zjbTHurlOb9vo8odseaq?=
 =?us-ascii?Q?yNLQE3zDb0KcIv9FbrlfXsAGeP8PvmsTP/yPYjYOqBjPrtCsTL5zjq4Av6Xv?=
 =?us-ascii?Q?JUEM46QuhBfewVNSB/gw3vnCRQotDZijBIoVm9ZhZw2rwuCsiTUs/UqZRiaw?=
 =?us-ascii?Q?CWp9YRFirPFjBfdGqZdWotXcpbuYHDbBVOTjPg//oIK83P47z6K+Fgmca+qL?=
 =?us-ascii?Q?wv6KdsLG6gzKURquD3650CJrMFTM6o8CcHLL6daBoNHYL4dDXtD/bAyf8AiP?=
 =?us-ascii?Q?CHkHZzZMltqrUTayJtzsCt7SX//0if7SL5Vh1LEg24b0uLI2h3iDmSWluEL3?=
 =?us-ascii?Q?B0Itx7LlpKcAQFj1uXlusD5W0k5lNO7jdoKY4WvnBRvuk8CiIr0YbHlPz+Mb?=
 =?us-ascii?Q?c+9009pd3XGKNs2fuO7HF4Yuf1Qjq9TArbyOpS2CBQMEi8qwc3C9Ho2SF4YM?=
 =?us-ascii?Q?QAVmna50RJIhMmWfUFpgDZSPoWLMLrEjXGX7FC4N9qiaFJJYvXLKCHz2UQll?=
 =?us-ascii?Q?2mWFtw/F1/rQArerplkrliWaHugrY4pLdCi4xbFqZ3XYqge5piyA7m5uRk9V?=
 =?us-ascii?Q?NSSiw0copHb2nhboWKR+E+CQNoLFRT6Cf8Xng5E4pVlc1Si5r8SAZUFjel0U?=
 =?us-ascii?Q?iHNZuJuw0D7pMWK+miNoYG3Qa1kCXoFF68OoYgyaed9umOX0X1hZcNjIVq7V?=
 =?us-ascii?Q?fTa/jPOPVNpjcG8ulHjrZTu1K9AnEl7Rs0HkptifvXHnF2lvhXdN4VLvLRKm?=
 =?us-ascii?Q?sv7OrAZHccVSTjLgUd9b4C9vEWE14ysEeAMi2DPUwyeuPJ7MiOPVZmQLeA3z?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a1a6e0-38cc-42dd-fd64-08daf4eedc74
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 22:46:36.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtIReeLO37E7e2RQRuPkvj5VdVGAOKgjIn6OR2oVioFiYME3xVqm1Mn/sBrPvctUs88b2BM86ul/X9wD3GNDPaz4SjaJI9GrEu/BViBH2LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4816
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 12, 2023 at 05:21:30PM +0000, Jonathan Cameron wrote:
> On Thu, 12 Jan 2023 10:39:17 -0500
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > On Wed, Jan 11, 2023 at 02:24:32PM +0000, Jonathan Cameron via wrote:
> > > Gregory's patches were posted as part of his work on adding volatile support.
> > > https://lore.kernel.org/linux-cxl/20221006233702.18532-1-gregory.price@memverge.com/
> > > https://lore.kernel.org/linux-cxl/20221128150157.97724-2-gregory.price@memverge.com/
> > > I might propose this for upstream inclusion this cycle, but testing is
> > > currently limited by lack of suitable kernel support.  
> > 
> > fwiw the testing i've done suggests the problem isn't necessarily the
> > implementation so much as either the EFI support or the ACPI tables.
> > 
> > For example, we see memory expanders come up no problem and turn into
> > volatile memory on real hardware, with the same kernels with just a few
> > commands.  My gut feeling is that either a mailbox command is missing or
> > that the ACPI tables are missing/significantly different.
> > 
> > I haven't been able to investigate further at this point, but that's my
> > current state with the voltile type-3 device testing.
> 
> My assumption was that all shipping hardware platforms were doing the
> enumeration and bring up of memory expanders in the BIOS / firmware.
> Those are then presented to the OS already set up exactly as if they were
> normal memory.  We could do the same on QEMU but that means a lot of
> work in EDK2. Note that it makes no sense to do the enumeration and
> creation of ACPI tables in QEMU itself though could hack it like that.
> This stuff is done in firmware because that enables it for legacy
> OSes. Everything is more or less presented to the OS like you would
> present RAM (EFI memory map, ACPI tables etc).
> 
> Firmware enumeration doesn't typically support hotplug, so if we add
> support for hotplug of volatile memory type 3 devices to the kernel
> we will also be able to do 'cold plug' and have the kernel bring them up
> in a similar fashion to what we do for non-volatile (for non volatile there
> is typically no real support in firmware as there is a bunch of policy to
> deal with that doesn't belong in firmware). (simplifying heavily ;)
> 
> So I don't think we are missing anything in the emulation, just in the
> software layers above it.  Could be wrong though ;)
> 
> Jonathan
> 
>

I'm not so sure something is missing so much as something seems
incorrect in either the ACPI table structure definitions, the mailbox,
or even the doe emulation.

I took your branch and reverted to just prior to the volatile patch
refernce: 59a59ef725699e0efb3e9e31a7f8d246de7286ed


QEMU configuration for boot (Please let me know if something is wrong)

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

After boot we find:

[root@fedora ~]# ls /sys/bus/cxl/devices/
decoder0.0  decoder2.0  mem0            pmem0  root0
decoder1.0  endpoint2   nvdimm-bridge0  port1

[root@fedora ~]# ls -al /sys/bus/dax/devices/
total 0
drwxr-xr-x. 2 root root 0 Jan 12 22:44 .
drwxr-xr-x. 4 root root 0 Jan 12 22:44 ..


During boot, I am seeing three separate call traces, all of which appear
to be related to PCI DOE and/or getting CDAT information.

[    3.916900] Call Trace:
[    3.916906]  <TASK>
[    3.931217]  pci_doe_submit_task+0x5d/0xd0
[    3.936609]  pci_doe_discovery+0xb4/0x100
[    3.936627]  ? pci_doe_xa_destroy+0x10/0x10
[    3.942675]  pcim_doe_create_mb+0x219/0x290
[    3.950506]  cxl_pci_probe+0x192/0x430
[    3.960248]  local_pci_probe+0x41/0x80
[    3.966564]  pci_device_probe+0xb3/0x220
[    3.966579]  really_probe+0xde/0x380
[    3.966583]  ? pm_runtime_barrier+0x50/0x90
[    3.969158]  __driver_probe_device+0x78/0x170
[    3.969167]  driver_probe_device+0x1f/0x90
[    3.978264]  __driver_attach_async_helper+0x5c/0xe0
[    3.983953]  async_run_entry_fn+0x30/0x130
[    3.991084]  process_one_work+0x294/0x5b0
[    4.004458]  worker_thread+0x4f/0x3a0
[    4.012612]  ? process_one_work+0x5b0/0x5b0
[    4.019114]  kthread+0xf5/0x120
[    4.025133]  ? kthread_complete_and_exit+0x20/0x20
[    4.031327]  ret_from_fork+0x22/0x30
[    4.038969]  </TASK>

[   16.047704]  pci_doe_submit_task+0x5d/0xd0
[   16.047713]  cxl_cdat_get_length+0xb8/0x110
[   16.047779]  ? dvsec_range_allowed+0x60/0x60
[   16.047803]  read_cdat_data+0xaf/0x1a0
[   16.047814]  cxl_port_probe+0x80/0x120
[   16.047824]  cxl_bus_probe+0x17/0x50
[   16.047830]  really_probe+0xde/0x380
[   16.047835]  ? pm_runtime_barrier+0x50/0x90
[   16.047843]  __driver_probe_device+0x78/0x170
[   16.047851]  driver_probe_device+0x1f/0x90
[   16.047858]  __device_attach_driver+0x85/0x110
[   16.047881]  ? driver_allows_async_probing+0x70/0x70
[   16.047884]  bus_for_each_drv+0x7a/0xb0
[   16.047896]  __device_attach+0xb3/0x1d0
[   16.047907]  bus_probe_device+0x9f/0xc0
[   16.047913]  device_add+0x41e/0x9b0
[   16.047918]  ? kobject_set_name_vargs+0x6d/0x90
[   16.047928]  ? dev_set_name+0x4b/0x60
[   16.047944]  devm_cxl_add_port+0x27b/0x3b0
[   16.047970]  devm_cxl_add_endpoint+0x82/0x130
[   16.047982]  cxl_mem_probe+0xc4/0x11d [cxl_mem]
[   16.047997]  cxl_bus_probe+0x17/0x50
[   16.048003]  really_probe+0xde/0x380
[   16.048007]  ? pm_runtime_barrier+0x50/0x90
[   16.048014]  __driver_probe_device+0x78/0x170
[   16.048022]  driver_probe_device+0x1f/0x90
[   16.048029]  __driver_attach+0xd5/0x1d0
[   16.048036]  ? __device_attach_driver+0x110/0x110
[   16.048040]  bus_for_each_dev+0x76/0xa0
[   16.048051]  bus_add_driver+0x1b1/0x200
[   16.048061]  driver_register+0x89/0xe0
[   16.048066]  ? 0xffffffffc056e000
[   16.048070]  do_one_initcall+0x6e/0x320
[   16.048091]  do_init_module+0x4a/0x200
[   16.048099]  __do_sys_init_module+0x16a/0x1a0
[   16.048132]  do_syscall_64+0x5b/0x80
[   16.048138]  ? lock_is_held_type+0xe8/0x140
[   16.048148]  ? asm_exc_page_fault+0x22/0x30
[   16.048156]  ? lockdep_hardirqs_on+0x7d/0x100
[   16.048162]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

[   16.054601]  pci_doe_submit_task+0x5d/0xd0
[   16.054610]  cxl_cdat_read_table.isra.0+0x141/0x190
[   16.054660]  ? dvsec_range_allowed+0x60/0x60
[   16.054685]  read_cdat_data+0xfc/0x1a0
[   16.054695]  cxl_port_probe+0x80/0x120
[   16.054706]  cxl_bus_probe+0x17/0x50
[   16.054712]  really_probe+0xde/0x380
[   16.054717]  ? pm_runtime_barrier+0x50/0x90
[   16.054725]  __driver_probe_device+0x78/0x170
[   16.054733]  driver_probe_device+0x1f/0x90
[   16.054739]  __device_attach_driver+0x85/0x110
[   16.054747]  ? driver_allows_async_probing+0x70/0x70
[   16.054751]  bus_for_each_drv+0x7a/0xb0
[   16.054767]  __device_attach+0xb3/0x1d0
[   16.054782]  bus_probe_device+0x9f/0xc0
[   16.054791]  device_add+0x41e/0x9b0
[   16.054798]  ? kobject_set_name_vargs+0x6d/0x90
[   16.054811]  ? dev_set_name+0x4b/0x60
[   16.054831]  devm_cxl_add_port+0x27b/0x3b0
[   16.054843]  devm_cxl_add_endpoint+0x82/0x130
[   16.054854]  cxl_mem_probe+0xc4/0x11d [cxl_mem]
[   16.054869]  cxl_bus_probe+0x17/0x50
[   16.054875]  really_probe+0xde/0x380
[   16.054879]  ? pm_runtime_barrier+0x50/0x90
[   16.054887]  __driver_probe_device+0x78/0x170
[   16.054894]  driver_probe_device+0x1f/0x90
[   16.054901]  __driver_attach+0xd5/0x1d0
[   16.054908]  ? __device_attach_driver+0x110/0x110
[   16.054912]  bus_for_each_dev+0x76/0xa0
[   16.054923]  bus_add_driver+0x1b1/0x200
[   16.055204]  driver_register+0x89/0xe0
[   16.055211]  ? 0xffffffffc056e000
[   16.055215]  do_one_initcall+0x6e/0x320
[   16.055237]  do_init_module+0x4a/0x200
[   16.055245]  __do_sys_init_module+0x16a/0x1a0
[   16.055277]  do_syscall_64+0x5b/0x80
[   16.055283]  ? lock_is_held_type+0xe8/0x140
[   16.055294]  ? asm_exc_page_fault+0x22/0x30
[   16.055301]  ? lockdep_hardirqs_on+0x7d/0x100
[   16.055307]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
