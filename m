Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9D3C54EED
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 16:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjA3Qzy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 11:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3Qzy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 11:55:54 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00913D935
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 08:55:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHMhfMmLQ3QUS3DRqUeARHJbAtW9T+3sl1YZ7/Rxmg1OrEnM3RjIDaJAaknD6WTRyWFhJjQ0C+FPEKV4Uy1QyVTAp9Tg4TuglqmsuHKcw6hluQbTnYfpGHvEB+aGSTFMKRWHnr4ZCte7iBHbamkLqZQxBiYj+eOjs52NWyC0h5R7aKcN6ruTDe0ljuj+nSdofFL+ywn/KpckJfoH7Vf81mUeYCxvLKjlt0xP5syxBMBcOxwZnPhJV7yDcyyjs/TOPLodLjffwXHqxJxDc/Nyof5wzsQTfhDe/5WpvA4sAVWKsVX5e6RMRQcnL7JRhThq4PEZSTTr+rNysfJmkeMU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXsnzZow/TahU7GWCzRblW57avE/RoT7hbYPrfehQnY=;
 b=BzMJWarfvDVivTs5mOpZwR3FOHIJZ4ELtj+zlX/Fg7jKF8UBcQwNcw2VOvaMRa7jm3lPgvCW00yqDSG54kacGNn00NJ0e/g1vs3OLoquFyI9YF6TYXgeYMwHtmZnQCZK3DZRU47z3C34uzIRbaBir2z6mG/Oo9vhFugJQlR6k9lNu3j+f3vT1/yQgTnG4HjwEbkIWeNj/WRM6FL6+UvcTBCqIfJI53k/VImv/L5l5WluOiP7kYU9gLdcaojzwV9BQJIID3CFOL6C1gHmtTguNkGcze6b5433QPvSnpTwVcMjTuh3yTQvL4SMPHrX1uSwC1l5113CvLz6KkzLd9cZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXsnzZow/TahU7GWCzRblW57avE/RoT7hbYPrfehQnY=;
 b=eh0CddjHA3EzBGQIL/kLsCRtmBgypFOKgbP37vQwptug8hpNHPpaJunvsPPDcdXGkoZUl/iUNqSByAfDT3INFmjDZlJMVAyNButTHdJy5A8Nc+ZETEG81DGHH8dBb74d32sjXbj14Zg+q2itBdD+nQz8ZepGt3Ts0LktusA3HjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DM4PR17MB6271.namprd17.prod.outlook.com (2603:10b6:8:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 16:55:50 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Mon, 30 Jan 2023
 16:55:50 +0000
Date:   Mon, 30 Jan 2023 09:16:54 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9fRVu+yLza4d5Vt@memverge.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
 <20230126185025.000016a0@huawei.com>
 <20230126193424.00005034@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126193424.00005034@huawei.com>
X-ClientProxiedBy: BYAPR08CA0062.namprd08.prod.outlook.com
 (2603:10b6:a03:117::39) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DM4PR17MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 1523e416-edaa-4948-26f7-08db02e2d74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0mgijXWZyZ1UglDxj9+Vo5NBAwxP0a4gl3EjD22OpRekumnH6Rxb0s2iNMOQ19Tltit674gl4Qisi4thLX00/eLaNWux27EiknK66mzzQ7vlOeqLgj39yqvpNAQCyzE6+NqZzNcvb8O287NzXkruptII2ufXPpZr+YIJxnOqvpDVmX45+6mEqMHcxLzrtiI13j8qQHU3kKVqmurGgOf8UuvzGzjPbb6oimE7DrM88r5FR66hr6dfUq1QZsxlkk1h/QzeFUgabVu/FV1iyfFH3GrEDyuZ2M1jmTzIvep43ZrEmqVSIsEIEtYoBgZM/czZkepWeYa6anXPLw+mUNTswu4YAlEk059fatxMUB05J8KK/VMMmXrQXU7H3HpBb4hohk90rmLcb0lJjiu9Mumtgp9A2dYOxyNn+KWZvdk1DFVmkcGWbitsBUmZpwSW8i+ss7cyneaAC83Gmo5QmTBj/3SYDFuirmQHpyxG8aOEs4SxT04+LR1816Nsoe/N/DZ1nG8Edf1eKyhm3/kWamEfoIQmF/J3/xBoCX9yuKFoB1CCvBSjPZRiPxriGRi7td6E8HNJOdlPlcOrMo8uLszAu7ceHqyTA+nKetsrcb+v87ZRYOdvUibsRjm+cvEn3sa2WG8bSdG0F5FYb/+T2GiQoRV/xMoS8xhNxDOUNx+C5oJweKLN7CAdLojkN8rfvxV8EUHgDrfjw07xupqPrFGB8H4GiigYjJcdqmxPRi2+0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(376002)(136003)(346002)(366004)(396003)(451199018)(44832011)(6486002)(83380400001)(86362001)(2616005)(38100700002)(2906002)(36756003)(26005)(6506007)(186003)(478600001)(6512007)(66946007)(8936002)(66556008)(8676002)(66476007)(6916009)(4326008)(41300700001)(966005)(5660300002)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?70p+qx7p85GYCW0OtAeX/fui8UR1N6vSU4St6F9GXP8L0ljgrUB3mFCwc8jm?=
 =?us-ascii?Q?dxwu/AoqilQ9x595zx5BrRWxLeN8+JkNic9ShVVJkKJqELOw7afCr7T/7gUM?=
 =?us-ascii?Q?64K0HAEbgweTXsPeP+P4q9y83FMcA6onZvEEbhjMR65vZEQVNeee2zZFW3uk?=
 =?us-ascii?Q?2J/0EnRJpKGPntweznvaBoqojNMFaa+qNWCqp1dMeyTZxnMsF6fvbeBqoU7R?=
 =?us-ascii?Q?22AV0K8tMvKHjS7rqmAza7URglhZg87Z3sIJt38KaUQZC2uH68yNncbFFyMr?=
 =?us-ascii?Q?XB9SbMhG1J80Z8fPxKrbf2QOZLiK9KXMlYl+GCS+tMNQDvnn8/W9eWUQLEm7?=
 =?us-ascii?Q?1NqYZz9aB+La/+RDHqhmmD5/9ovvAiqkmk5xuq05RMXYD52KOQBb3wYiOisA?=
 =?us-ascii?Q?Ot4zY6VN9O0pa3pTMObguixdk/p3nhhM+UrQWLIsTst3JLqy+bfsLfGBdko5?=
 =?us-ascii?Q?mGvzbLkUGD/xsVVnW9aZhNi1pL03hdAWyO6Ema5NMrUQijBWxcNNGlss8r7W?=
 =?us-ascii?Q?La8kUsGV9zpN8XKx5nxgArDcUTs3I8lFSmw+dnOGW8dVjG4fKvhVS24jkPZ7?=
 =?us-ascii?Q?DNFaOf+8gloC1rFKb6U8jCGRp6aV8GvfGGrGraBnvE5VXOnLLvJXTUXz7N5S?=
 =?us-ascii?Q?Aa7JVzjVK8LHzrINc247OL8sxeMbjS62cx098BA2XiBWEmbySxo4yZeEQsM5?=
 =?us-ascii?Q?eeyWNHFBAVMjyAD83zpxqnTM3VPJg8A4WfIsySbrUqKmqXYSkErRCDV4EXH0?=
 =?us-ascii?Q?ZAyXWZjpSyKXCH4l0wgiGStNEoUsfxrqah0BuTaEo8c7qwFpAEppi4GGpoSF?=
 =?us-ascii?Q?kKu1XGS1RKLB6aizBJ6aCNBEpK2x7jZJTnu3zMFNVqL+okqxHsTP7iCq7JnG?=
 =?us-ascii?Q?lY10YpvxgseVCi0RUT3//OU4CcBr5KnvX4saKERdSSWK2jNk6Ti+qCpKeRqh?=
 =?us-ascii?Q?QzQJreGkfMNffNt1XE/Zg3McLnbo+DiyraHByyXY3I4K5nsWnqfKAZBiJzf3?=
 =?us-ascii?Q?4A8dnYPsEDIuzo3LtiHpiRv9HEtDb/H/pUar4KDayySPrk4AQ6nYQbXZMLbY?=
 =?us-ascii?Q?PpOS17SuYPIE3bE221UdJGPfIEmrTJdu3hlODQyUcJaKKXfgszOnO6aqHBF/?=
 =?us-ascii?Q?5KNEmMWHv9jlBVmDc+NAn4dn/z+TNCHh5jZUQh+knMglz4Kb815uJ1JEq5tz?=
 =?us-ascii?Q?YiwHrQ+4dyW9lD7RplODNB2b+VC8aulNY0++O3NIwxX+Q8dKDsw4fnU6ejGa?=
 =?us-ascii?Q?d+pCHU5WRnR5waZ5913OJlN/R91Wzw7hAC08SSUyxKegvKq/rCAwpn4MVYn0?=
 =?us-ascii?Q?Umc46a02c/Zh2c9yTuXsowwSOxgvnHVHtRad/nuTYqyOQ/kfqJOJyzZR7//O?=
 =?us-ascii?Q?5vyP0KfXajIW/sytjXJ995tFk5FxYWMlh8+QxKx3aP3kSv8F44WmfIahatSi?=
 =?us-ascii?Q?3YVxEw6uMbbpZQH1qLO860JzlwlKfGN3BLlG8au5lSJ4ye9fkz1wxdVN+4Sz?=
 =?us-ascii?Q?SdxZXLuyi5H3pp22RgFv91OiP4VvvmEgD8gRHDMsA3RT316T0UuxfulpVh/c?=
 =?us-ascii?Q?3IDRTRvw2w04TsbrAWOSLggIxjrzhf4jUxj2D7JEit9MGut5Y1KEq+u2Z7Qe?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1523e416-edaa-4948-26f7-08db02e2d74f
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 16:55:50.3241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vppZhB7IJwzHsUojXz87XgWdgteM1iMpqC7fDy5eyWgBSKIW2Yz36KHG4nn+1I6sE4SOSzcsH73exVhOV7wcfagiO/oM7j2ny5kBInfkZ70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6271
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 26, 2023 at 07:34:24PM +0000, Jonathan Cameron wrote:
> On Thu, 26 Jan 2023 18:50:25 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Wed, 25 Jan 2023 22:29:15 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > Dan Williams wrote:  
> > > > There are still some sharp edges on this patchset, like the missing
> > > > device-dax hookup, but it is likely enough to show the direction and
> > > > unblock other testing. Specifically I want to see how this fares with
> > > > Greg's recent volatile region provisioning in QEMU.
> > > > 
> > > > I am hoping to have those last bits ironed out before the end of the
> > > > week. Note that this topic branch will rebase so do not base any
> > > > work beyond proof-of-concept on top of it.
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region    
> > > 
> > > I also spotted at least one bug-fix that needs to be broken out and
> > > submitted separately, so reviewer-beware at this stage.  
> > 
> > So far I'm failing to set target0 via echo which is wonderfully getting
> > an error of SUCCESS.  So I think you are returning rc == 0 somewhere.
> > 
> > 
> > Ah. There is a shadowed int rc variable in store_targetN() else
> > 
> > Now to figure out why attach_target() is failing.  I probably have
> > the config sequence wrong as I've just bodged an existing one I had
> > for pmem.
> > 
> I was trying to add it to a pmem region. Oops.
> 
> Can successfully bind the region driver. But not sure how to test
> beyond that.
> 
> Basically I got to the helpful 'TODO hook up devdax' as you mention above.
> Looks like decoders are programmed correctly as I can read and write from
> the HPA using devmem2.
> 
> So far I've just tested single direct connected device.
> 
> This is against http://gitlab.com/jic23/qemu cxl-2023-01-26 which has been
> there for a good 30 seconds. Mostly unrelated changes wrt to this work, but
> it includes a few trivial tweaks to Gregory's patches as discussed on list.
> 
> Thanks for sharing this early version. It unsticks Gregory's series as far as
> I'm concerned (if there is anything broken in more complex tests that won't
> be related to Gregory's stuff that only effects type 3 devices).
> 
> Jonathan
> 

I found the same results.

Reference command and config for list readers:

sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
-drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=disk,id=hd \
-m 2G,slots=4,maxmem=4G \
-smp 4 \
-machine type=q35,accel=kvm,cxl=on \
-enable-kvm \
-nographic \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
-object memory-backend-ram,id=mem0,size=1G,share=on \
-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G


echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
echo 0x40000000 > /sys/bus/cxl/devices/region0/size
echo mem0 > /sys/bus/cxl/devices/region0/target0

Not sure if bug/missing feature, but after attaching a device to the
target, you get no output when reading target0

```
[root@fedora ~]# cat /sys/bus/cxl/devices/region0/target0

[root@fedora ~]#
```

Would be nice for the sake of easier topology reporting if either this
reported the configured target or we added a link to the targets into
the directory.

But this looks good to be so far, excited to see the devdax patch, I
think i can whip up a sample DCD device (for command testing and proof
of concept) pretty quickly after this.


One question re: auto-online of the devdax hookup - is the intent for
auto-online to follow /sys/devices/system/memory/auto_online_blocks
settings or should we consider controlling auto-online more granularly?

It's a bit of a catch-22 if we follow auto_online_blocks:
  1) for local memory expanders, if off, this is annoying
	2) for statically configured remote-pools (remote expanders)
     this is annoying for the same reason
	3) for early DCD's (multi-headed expander, no-switch), the pattern
	   / expectation i'm seeing is that the device expects hosts to see all
		 memory blocks when the device is hooked up, and then expects hosts
		 to "play nice" by only onlining blocks that have been allocated.
		 (there is some device-side exclusion features to enforce security).

Basically early DCD's will look like remote expanders with some
exclusivity controls (configured via the DCD commands).

So with the pattern above, lets say you have a 1TB pool attached to 4
hosts.  Each host would produce the following commands:

echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
echo 0x10000000000 > /sys/bus/cxl/devices/region0/size
echo mem0 > /sys/bus/cxl/devices/region0/target0

and mem0 would get 4096 memory# blocks (presumably under region/devdax?)

A provisioning command would be sent via the device interface

ioctl(DCD(N blocks)) -> /sys/bus/cxl/devices/mem0/dev 
return: DCD return structure with extents[blocks[a,b,c],...]

Then the final action would be
echo online > /sys/bus/cxl/devices/region0/devdax/memory[a,b,c...]

or online_moveable, or probably some other special zone to make sure
the memory is not used by the kernel (so it can be later released)


So to me, it feels like we might want more granular auto-online control,
but I don't know how possible that is.


Note: This is me relaying what I've seen/heard from some device vendors
in terms of what they think the control scheme will be, so if something
is wildly off-base, it would be good to address the expectations.


Either way: This is awesome, thank you for sharing the preview Dan.

~Gregory
