Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E50EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 14:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjFVOsD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjFVOsC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 10:48:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB70E57
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 07:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zgeoc6reF0Qb1eSCtO4K+TDftS/78K4Zg4W0CUniI6iQtPawPVKl4mTiQvDQYTA6X0k6LakDcioV9C992krlWz/B0lGuXQGKCdnvEJCkOehh6H+tpjyFZb2E7fDS7GVV4LlKYgrj5d9I+MxjsQnA9bzDZal6ptr1/Gm2fx95aiqLgl7/veL7zeW+N/SdSxA26dcZUNC6I0lyGM9L0en/5y/6AKLtAHfn1m/GP4Jh+fWDRCZ2wWvG08Y8Kw/+VFDV6EaYCHfgaF5h5yxDXfLriAO09ikUHTPrFZkf3ftQQaLvWNgcdHf5LE8SrKF5x8xSrrShsHUu+ke7OB26l7lMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N80inuAPRLZpq4Bt1J+5VpDMA5RTD1sc6vkmzZxbMwA=;
 b=VAA6n6JvvitsCCRttny88prtxi0xVwYrxui+CfvcOTAk4vxBjkK5WQaF0g12+dpW/FHeI0sf8WOX6ClJccGNOP+c1DIXDrHH0aTHZOZ3AvUKnuVknz07Cq+8leSF/V4uP2y3LIYwHckwWBRNl8Vi4JV+du93ubpYt+0KNNld20deX5UWp84EiOsGTTK96CSt34F7BeDwo7b5Kjc7spLuUndHJiGBgOrm/1VMhq7Neq8leaI5uNPyuxFuX8DRLYl5JiqvqfU8bmkxGrlh2Kysn9LiSxBMrVqTAoYEf6gO0h7Pdlnzw9oh3wYjlF2mN5Hy2TRZZ6g3RSjkFvsZ+Je0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N80inuAPRLZpq4Bt1J+5VpDMA5RTD1sc6vkmzZxbMwA=;
 b=y2M0zz0QKE1grBae7HxUIWdLAeeGrAJi77+WYbuO7TwfV7VaZZi2Zsa9Q7buSF4GraxPgGrY+aTHVEgaF0Eobmfqzada06wD4cyKFDN01uMK2NQW6kNrIHzgO/vmI44oksB+uaSncVpMI25+Jic8PTfdUTaMKxi+lLWstT8MSZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6624.namprd17.prod.outlook.com (2603:10b6:208:3fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 14:47:56 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7e82:eb7d:47cd:2ebc%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 14:47:56 +0000
Date:   Thu, 22 Jun 2023 10:47:52 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [BUG] Root port fails to match with port driver on non-RCH
 topology
Message-ID: <ZJRfGMOp/inWDK7J@memverge.com>
References: <ZIs5Ra+9SGGbUZoZ@memverge.com>
 <ZItcdaq3j8kW+/Sy@memverge.com>
 <ZItdoWTyOS5YSPzz@memverge.com>
 <ZIuUL/hKp+RdhTna@memverge.com>
 <20230622104820.00005249@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622104820.00005249@Huawei.com>
X-ClientProxiedBy: MN2PR19CA0037.namprd19.prod.outlook.com
 (2603:10b6:208:19b::14) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfac564-72c2-469d-9d5d-08db732faa66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sw842abgtjbgGztyfAjRfhACF343EtxIWQUCGnoRPgBwQ66zzSxqHG5gL/X04npWFLnYinEPQ/3Ju57NmO6FmvzDUjeRND6kLs7Zc1dYRhihKG0xy1JdYWGyb49i5Cu2BZyEuU9ap2vN4LYKLUT75lDILIuSBjk2ObG34dWW8zE3t8zUSMyEbs6lScqR6BQJxDjXszq3Lm3OAhxcBeQo8SPIVRrokSO3AAegE7SPSR2ZPABXSj2TnubfbJvh6dbQxNUq/O35AJb01icJs1WK/rqeGEWlKgOnnGrTJi8YnF7/3bY5EDCJSEhg5kETTJUSykNEfLn3NZZpB6gll/Qenw3YPHakPi2BtpwE6r2SjsZyXwInTrjmWtURmXEFeqkG4N/DFKpUfd1QDOz0KduFbDwHrs9G0E3ChcN942eh1K/GjfTolj5t8cH8VB4VNuzJxJw2fjYxmeNUSuwPxIXqaB4btrIAU+ej368m187Qtlz/8EgAoXHEQQ9YJpFDACDa8BMVTTgXIsaYEOfO1CHvoNxYf/MZ9tiZ3o7t3B02FaEQysEcOXvwHY4d3odJyXbj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39840400004)(346002)(396003)(136003)(366004)(451199021)(38100700002)(26005)(83380400001)(6506007)(186003)(6486002)(2616005)(44832011)(5660300002)(2906002)(8936002)(8676002)(41300700001)(6666004)(36756003)(478600001)(66476007)(66556008)(6916009)(66946007)(4326008)(54906003)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3s/6O8PZi8pXw0ww4/UbbiSFyszA9BW5unwaPufKzw4ZOnEXU419OGf6Yjb?=
 =?us-ascii?Q?VNCDEZkyZf0w7J49fQQNXlKzAVAhFvUnPL+2XeLsMiX2ktJGqTveeSpj0IND?=
 =?us-ascii?Q?7EL8qt5YRElTaKe6OBgc8XryJck+3nPGG1am1U4wGiL0C/dqsL42htOXPyOz?=
 =?us-ascii?Q?Oxnyn53yA/WY0UO2BSOFr7txruXXirJWZnbzpu0iV6ODZphly484ls/L2yu+?=
 =?us-ascii?Q?7k3QdtNmmlKaur7HvjYcQtZcjisFaUjbP2PTaHoc9FiRSFcp4wG/dGwTUgay?=
 =?us-ascii?Q?0D+y0rO2fu4hS5Dz1HiL7X+EdG3BZcsR411BYKPTmt3hJCNqa+PsLp0muKQB?=
 =?us-ascii?Q?MaAcDd+Y1nTeRnSM41OdMCXM40uP3GQ64sRhpgp7OE0b0Ww/kTagdOZCbvyG?=
 =?us-ascii?Q?BJ6tIqEHC+6yfjqA6MesFyjI2iu6etPRJIFAPdE0s8Ec/zf+zQXT3tjf0zTs?=
 =?us-ascii?Q?/UvmeGXbyIXpkA16gLfUzoeBtGVurAksDkgeHfHGbB9qUxbOZDDMdxzC8jNv?=
 =?us-ascii?Q?rAEzVHAwu4Lw7NzhcM6u/TDD9778XKw2Q6tYlOrZ31NHD3ycUANYzCqt0cy+?=
 =?us-ascii?Q?m2mJlLi/whrOLT3BG0foIl7tS4mOJ0aDGESa3K/28JTmLFsxvHg3EE/OB6N+?=
 =?us-ascii?Q?VsD4jUc0Tb4OjpwL9iJAQxBt2riWSehMJWzXm0x0yiwWh1RLRs4Lwt9V0afS?=
 =?us-ascii?Q?flztEQzScEyYsCM1xSeyxGdNrvgBChT/d56ZyPzbdXLgxKHjlqi1xPm//djD?=
 =?us-ascii?Q?7o0q6mMmBf9DM1JO/x3/F0BapDB0EGeGrO9iA9ihcPR46b5hyzDRhFimeGj2?=
 =?us-ascii?Q?9n9wUDUSbKUKvxNWPgQ8nJUlSNtwOKIZhF3cz+f98TGVF49JDD+B6U+ZuRzj?=
 =?us-ascii?Q?j5PAbuCYdEg9IRYIKRF3tvcFC7ElU/HDuLqyyQMM9G3+OmZYt6E02bsUvzzu?=
 =?us-ascii?Q?dh2OKESF7NbMk/+GiZhHrH7sQWezdgy2FV0tEzzQlt8sAnuODhp3bIP7UED1?=
 =?us-ascii?Q?+PXTpxzfjzjTlCDOtlGZqz3Gu45e3hHg4KE49r3IEPyNnDyVzt4mjXPaFH/m?=
 =?us-ascii?Q?W/7ZR8z2A0kmRPwaB7vFh59e58JA2GvfgciUR3WwWwvN2QjCHYLUx+Cq6Ust?=
 =?us-ascii?Q?VS38BFZ7DaSKDklTKYcCGCT6r1Z63cgrfld7goFqSNi8R72SWjv2mLwxtY4d?=
 =?us-ascii?Q?L9k8mu3Dr/NPpw4oX9I0xLHhpojHN3qEzobLR1hhgKfY7fv3u//jpDAtiTkV?=
 =?us-ascii?Q?AMLM8ZTKq7BnbWtABN28Zq5rwi08hjb3g7FlACnEsRSz89R8dZSTz+KhgkOA?=
 =?us-ascii?Q?iP813J5zKG1R6U6tvZvM8O6XUbEtIDf10Ly+QJ5/S82DKVjPQ0UTWlGczJFw?=
 =?us-ascii?Q?hSWQkj/GCfT3vDPdsEDbnpdOJUqGOlbxRiSmYLN8q9diwOCJBxyQu7bVBfN0?=
 =?us-ascii?Q?inxsAexDv0/cNbQkI6QDFBONdgB9lYhgUMfBRCRC80frTTsg+qMqhIqY2CMk?=
 =?us-ascii?Q?yUFF8qzhZfGLrgpqOWTSibDP8QNqQs3ZlUWZh8Jiv5aRIm+filCmUR3m8MAa?=
 =?us-ascii?Q?Z2NNr5u/WJtoQroCum2cl1Mos/Z6YKodf5j97skK8pxsor5tyHkS9MnAEgj9?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfac564-72c2-469d-9d5d-08db732faa66
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:47:56.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6dHC9xpmSJ2OciWB5LR/GEyiaxK8Mqt0YXUaUr8uChRXxu+JSxfpzzg3yQfuw5ez8Wq5VMjFDlg32XrgH5+U2FsppYGFX1nX25QcICORNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6624
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 22, 2023 at 10:48:20AM +0100, Jonathan Cameron wrote:
> On Thu, 15 Jun 2023 18:43:59 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > On Thu, Jun 15, 2023 at 02:51:13PM -0400, Gregory Price wrote:
> > > On Thu, Jun 15, 2023 at 02:46:13PM -0400, Gregory Price wrote:  
> > > > On Thu, Jun 15, 2023 at 12:16:05PM -0400, Gregory Price wrote:
> > > > follow up with more context, there is a subsequent error on
> > > > cxl_port_probe which causes dev->driver to remain NULL.
> > > > 
> > > > 
> > > > [   15.561313] cxl_mem mem0: CXL port topology root0 not enabled
> > > > [   15.561315] cxl_mem mem0: call_driver_probe failed  
> > > 
> > > wrong prints here, this should have read:
> > > 
> > > [   15.549316] cxl root0: driver set to cxl_port
> > > [   15.549732] cxl_port root0: call_driver_probe failed
> > > 
> > > I confirmed that call_driver_probe sinks down to a call to
> > > cxl_port_probe and that is failing on cxl_port_probe(root0).
> > > 
> > > Rest of the commentary below is accurate.
> > >   
> > 
> > 
> > so cxl_switch_port_probe fails on this stack:
> > 
> > - cxl_switch_port_probe
> >   - devm_cxl_port_enumerate_dports
> >     - cxl_port_to_pci_bus
> > 
> > int devm_cxl_port_enumerate_dports(struct cxl_port *port)
> > {
> >         struct pci_bus *bus = cxl_port_to_pci_bus(port);
> >         struct cxl_walk_context ctx;
> >         int type;
> > 
> >         if (!bus)
> >                 return -ENXIO;
> > ...
> > }
> > 
> > struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port)
> > {
> >     /* There is no pci_bus associated with a CXL platform-root port */
> >     if (is_cxl_root(port))
> >         return NULL;
> > ...
> > }
> > 
> > 
> > I presume then that for the root port, we should just return 0 to note
> > success?  The rest of the devices should register themselves correctly
> > with the root as they're iterated over - i think?
> > 
> > What I can't figure out is why this doesn't happen on QEMU, which also
> > presents a similar topology.
> > 
> > Still not sure what is correct vs incorrect here, will need to dig
> > around in the spec and system settings unless someone has an idea.
> 
> Interestingly on QEMU we never get near the path that's failing on root0
> as no driver is associated with that particular device.  There are plenty of
> child devices with drivers though - just not the top level one.
> I wonder if a rescan or something similar is causing the probe on your
> system but not qemu?
> 
> Dan, should we be seeing a driver binding to root0 or not?

I added a local patch to associate the root port with the port driver
after observing that the association was failing:

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c index 4d1f9c5b5029..7f99e4f790d8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1853,7 +1853,9 @@ static int cxl_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)

 static int cxl_bus_match(struct device *dev, struct device_driver *drv)  {
-       return cxl_device_id(dev) == to_cxl_drv(drv)->id;
+       int devid = cxl_device_id(dev);
+       int drvid = to_cxl_drv(drv)->id
+       return (devid == drvid) || (devid == CXL_DEVICE_ROOT && drvid ==
+ CXL_DEVICE_PORT);
 }

This is what is causing the probe, that's not what i'm mostly concerned
with.  The core issue here appears to be that the driver is seeing the
root port as the endpoint parent:

drivers/cxl/mem.c
static int cxl_mem_probe(struct device *dev) { ...
    if (dport->rch)
        endpoint_parent = parent_port->uport;
    else
        endpoint_parent = &parent_port->dev;

    device_lock(endpoint_parent);
    if (!endpoint_parent->driver) {   <---- endpoint here is root0
        dev_err(dev, "CXL port topology %s not enabled\n",
            dev_name(endpoint_parent));
        rc = -ENXIO;
        goto unlock;
    }
    ...
}

I suppose the root question may be whether an endpoint_parent should be a
root port, or if there is topological error occurring somewhere (missing
port in the topology).


> 
> Jonathan
> 
> > 
> > ~Gregory
> 
