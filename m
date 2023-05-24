Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8192BC77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 24 May 2023 14:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjEXOrm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 May 2023 10:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjEXOrk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 May 2023 10:47:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AADC1
        for <linux-cxl@vger.kernel.org>; Wed, 24 May 2023 07:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kka4d4v2UQSlI+LPLVXuFTvy09KLPcDpOVMpAAK0P/jKaxQmHe6mtOYlOyFSoSiXjunMtAXbYg7KbwgvKn2/YA2Vc3jEiPPZlPX6Uni36YOn/lnIMl4TsA9ym9t/27XspdPk+N4ZpCRzQBoVBgUnZezB91Hf3h+mSOL2ql5uiHWV5hYqGyFlQP7rTTiXUlo6oBe3ZiQ+M7vzt+RzAFu5SwDZu9avLg/LvzcLZNjuASATT5f8XcRIZI33Qf9G2wj/sZCRFyQCDCqy2PKWAhThJp7l2BKyL9TQeZwlGtwpnRaAqv8T/XiNRIOPim+YEusVcYxzRwDKaL+IQtCyQABSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKFVIXYuu7jWN16BBFGJ2cGADL+5Ui10uigMpon/oZA=;
 b=J6evWMd8+U3HNCg3P4/82moQ3PssWzeYRgNVvH0kmUlKyMoYfm6CWgL3Y5CpfUstnECyyMC/dUhLkdTAFLxXkljhZxug1nm+Vpae45e0hsAx0vguiGyHrdbrQq1TmOSin7wGDJJXBZ2Hh1pE4dUjD1LUIuJg/1qOkIJLaNiniYG4EckMWuYdqUYN9cRZ2vO7X2/QkzIef3xELIIUP4Kq9U8yiVxUrjqNIuEE1FDZrV76JqhnNC0m7Sr3ayoyYrYz+84S0HMEHDsEWrea97n6h8PtRGtxLzuJlQ0OIPST+lMlrHZFO1W4z6ZzIVjkCT3t2ggwB8Fnr3N0RmF8nWRDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKFVIXYuu7jWN16BBFGJ2cGADL+5Ui10uigMpon/oZA=;
 b=QJU3b/+/ELvUKdP5CitQ+XeHc5ouZibo+jVgmh4aHBcEyIzHR+DB9wsEIYIeuy4WLbB9mNjYAawevBtdzrToALPMSTCVSXF1CS7aabONp4bhblck8rYNoHEWp5vZOocTase9RDo0fbWXogYzAxlTiuKjE+eC/+PJIi6P2XnIBKY3LUI9aDG/XMHzCxYz7AVHI6np/sJymCFGUH8pruSRw8kG6rFsIGgrE6goBjerj9cNtBQct9MQf1ol4IVeqPCwgi1zziELrxlPHiEs/qSdMxDO9zIWsTtLthONTnB9YWWdm+SgRGkAF3fjS5MecMI4kMkyuVKUx6vIV0KzJIRMyw==
Received: from BN8PR12MB3330.namprd12.prod.outlook.com (2603:10b6:408:43::15)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 14:47:35 +0000
Received: from BN8PR12MB3330.namprd12.prod.outlook.com
 ([fe80::7a57:6fad:3c90:b44f]) by BN8PR12MB3330.namprd12.prod.outlook.com
 ([fe80::7a57:6fad:3c90:b44f%4]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 14:47:35 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>
CC:     "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAABux4lAACwZegAALAMJgAAimUgAAFkB6UA==
Date:   Wed, 24 May 2023 14:47:31 +0000
Message-ID: <BN8PR12MB3330831F2E666E9BB1319E66BD419@BN8PR12MB3330.namprd12.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d8c76811cb_250e29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <646d8c76811cb_250e29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB3330:EE_|SJ1PR12MB6313:EE_
x-ms-office365-filtering-correlation-id: 441b15d0-7cbe-4b5a-606f-08db5c65cfb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTm9cCNWHWZcyFFQ1S8p99hIwYkhe/xkXl8Z4060AZbG001YahKOK76RhTEHimlwgV8o/OxAA+GmVCYROrTH8/rnuuwsOngDtRWbsl7m2wTNDvhlCNVh2A9QM2JjDFafNQ65FmgwZDWWwO91H7NnaXBPvxw4lZdMXIMYtvCAI/OrS+PkpxW4rxTJYl4h4IAHWV1RwxMYBkKBVMisVi5riC+lGV1Fbpt9hc89YrilO9c6ePn3lthr44zX+dpwvHS5mDFfVUY30DMnKSo1VQNwSIva00Z9i5NTL4rh8tDVMoA0rZFnhPodWGTOuemkAQUikh2iDpTgpWSGKCiKS+katDDhT4HQm6XtS2aGMH2BUtfzuO+zw+0fFzhIwnK/ajFU4NACAxyZKIFuoKXCtrfC/kLHl0rvW9Ik3sygscQQOUDuNYq7tegXjVdveeV4iQUvugVU7NH7di5x80l07RO34xUfl1jWKHfXTFVmg6FQy3aiWTRHobne3HWOumAJMWXE12XBaTXQKzU3sEIhdHgVDsiAfYDoKpvH38Hdp648MYtvvzxxo4CrPcFLJovNfmdtz0r8muwXHgVmNLByuP1VKkXtCM8TsE2GGV55McePLGX9EVzZd1GRt4zod5tsxpVW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3330.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(33656002)(122000001)(38100700002)(86362001)(38070700005)(55016003)(8676002)(8936002)(52536014)(5660300002)(26005)(9686003)(6506007)(2906002)(186003)(66556008)(83380400001)(71200400001)(6666004)(76116006)(66946007)(7696005)(316002)(41300700001)(110136005)(4326008)(478600001)(53546011)(66476007)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KoreN4k5GecsXAGwjwHjVFG+7GCbiKtMef7lrWw/XhZ27ZHxeqVaO/OfZRga?=
 =?us-ascii?Q?VQykpmC1DyrE/X/ruWNVR/9mHC2qVCUucnvheMNSTTMBb26qRg8BLRXPDzf5?=
 =?us-ascii?Q?U01LwtKbvWJ2f+LdiB+YlQSVJ0mbROptpVkIEgjc8ri03R/57qGdoAvUAjs8?=
 =?us-ascii?Q?my4PgBPu6Nyounc0O8F4fWkMu0uh6EqTlsY7+pPju6DCINvPtNuAJmcZ4iBW?=
 =?us-ascii?Q?831ZFq/D9IZc4CUYakcYUo76Qh2vfesBwWZOp36o3sxHyBCt/7OF73KK6oNo?=
 =?us-ascii?Q?/lmIxHaRiST6las+8oyAFUJAiTvmPq/LttMoh6Z0Lpe081RXr06xvr4Q/xbt?=
 =?us-ascii?Q?YjcxEiV1sVoJ+WBIF80O+vRXLApo7TaoW2O5OIRsSxd6zjWEyNWkU7+q1AHA?=
 =?us-ascii?Q?/pXya0QFhIj1sjL0QtV8Lxu6BRLGjjPWjNQNBhzRxUo4etuOPeZASOhkMsft?=
 =?us-ascii?Q?h8JWOXkLyIMQ4vPzyuzMbOFkV57+2sjV2gD3YKVHKc50GLiXIoh6e9CkCat/?=
 =?us-ascii?Q?xqulA2xLJaKs3Q4fd0yo0Aw/riPoqTq8gLs4nLKlOM4Q3KmZC8dlhSg3s6nB?=
 =?us-ascii?Q?8Au6cVgu7lihTPzP4N9cbKtNhbAv5iZ3qFLFzgaQZGlje3lHfqrj92IZKN36?=
 =?us-ascii?Q?hPWDQi76TJ1CVCSmEanqgqwXF/JVbYZ+4ZPMhrpF9C7wqEtahHv+GjS4Lk7t?=
 =?us-ascii?Q?GIJfgjF8Nv7aYHlBtWvSC1oJKX6hljeBZf5LSjlh07nQm0k/nOh4AFXlgPnZ?=
 =?us-ascii?Q?t4DSwZa720VF6kB/lDv7+Tu+XdpPwe+bG9y8rykMDdUvZ3/1GfD82+tBf9Af?=
 =?us-ascii?Q?VpiN2KzG3obTTp77rbvHC0KODjd6v/q6VP1MnYG+A/keymPVZH1Ky01d8O+d?=
 =?us-ascii?Q?Mbzq1d6q4QHySgl/TMegljU1gWwpojqbubwNLMKyfKZsdVKyOKKpqOAMSZCU?=
 =?us-ascii?Q?muEKl6SiWYfPmr0ymKFUM5JZLHtZhwpMzfuC6hwt3fZsd3LQrV6QJfuAGybo?=
 =?us-ascii?Q?xnTOvicEk+i3DJlJwMhx8soVGp5bHsjgwbEIqExGRY8n3ES9biCJjGykAAuZ?=
 =?us-ascii?Q?pHYG6/NmH7z1t/pN/z0qSrzpQorSvJmcvyheGsh5uC6r3FTQbcTbvcZPCJYJ?=
 =?us-ascii?Q?YcI4uoWnJ2/WLZRqYZmdfAuHVVlX1kMQikNIeL/KUlj9P3MTsFaS71aP+lXy?=
 =?us-ascii?Q?dXi7YqqJBjE/D5CYklYmkEwY46YJVuWO5iN4M8pJlMBg8cS9FdCl43hw7AkL?=
 =?us-ascii?Q?yN6lsZ7N+jA0PVTyP57wceGGuCBkqQaRi8vK4auD71Scx1mCzKrlkjkQQMqH?=
 =?us-ascii?Q?4LopKfjQBaU6K70PT+NP09Y4Silq4Wmi+RKs0UmF1opxO/zy8XoFFh4TsMaW?=
 =?us-ascii?Q?MgCje84TKcUplzksUmjG2SLn5QL+M9YiOhGPEj6iHZkwhEQ6/QFV1mFn+P9X?=
 =?us-ascii?Q?VXhbvjkyUQWXrKhYq73PSFq0GMaQu8ULzRdhCuA/ZZvZIRevGc0XfVxTacQc?=
 =?us-ascii?Q?f/+l41U7BG0lNJDAflCAGnjEibPVoUmsDvdEAiH/mprg0Dat/h4nUnoNmCKZ?=
 =?us-ascii?Q?NmTkVoblYsU5KpAl8rw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441b15d0-7cbe-4b5a-606f-08db5c65cfb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 14:47:34.8970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMSHZ9/AkrRuLpybLb/g8hCIOOoWSnoqit6NUHSP6MvIfMhoHYc4NId8SKlAhv9FvC9/Fu41kmbP7eTW/p6NpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Tuesday, May 23, 2023 11:03 PM
> To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>=
;
> linux-cxl@vger.kernel.org; catalin.marinas@arm.com; James Morse
> <james.morse@arm.com>
> Cc: Natu, Mahesh <mahesh.natu@intel.com>
> Subject: RE: Questions about CXL device (type 3 memory) hotplug
> Vikram Sethi wrote:
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > Sent: Tuesday, May 23, 2023 1:40 PM
> > > To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> > > <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu)
> > > <y-goto@fujitsu.com>; linux-cxl@vger.kernel.org;
> > > catalin.marinas@arm.com; James Morse <james.morse@arm.com>
> > > Cc: Natu, Mahesh <mahesh.natu@intel.com>
> > > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > >
> > > Vikram Sethi wrote:
> > > > Hi Dan,
> > > >
> > > > > From: Dan Williams <dan.j.williams@intel.com>
> > > > > Sent: Monday, May 22, 2023 7:12 PM
> > > > > To: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>; linux-
> > > > > cxl@vger.kernel.org
> > > > > Cc: 'Dan Williams' <dan.j.williams@intel.com>
> > > > > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > > > >
> > > > > > Q4) Current CXL drivers/tools support Hot-removal request from
> PCIe?
> > > > > >
> > > > > >     CXL specification says "In a managed Hot-Remove flow, softw=
are
> is
> > > > > >     notified of a hot removal request."
> > > > >
> > > > > Currently there is a requirement that:
> > > > >
> > > > > cxl disable-memdev
> > > > >
> > > > > ...is run before the device can be removed. There is no warning
> > > > > from the PCI hotplug driver. Which means that if end user does
> > > > > the wrong sequence they can crash the kernel / remove memory
> > > > > that may still be in
> > > active use.
> > > > >
> > > > Is there any notion of a cache flush when memory is removed (or in
> > > > future
> > > CXL reset)?
> > >
> > > No.
> > >
> > > > Generally, CPU caches must be flushed when memory is removed
> > > > because any evictions when the memory isn't present can cause
> > > > async errors which can be fatal to the system or at least to VMs,
> depending on ISA.
> > >
> > > This seems incompatible with memory hotplug. The cache flushing is
> > > only done on the subsequent reuse of physical address range to make
> > > sure that any pending evictions are complete before the newly
> > > constituted address range is put into service, or that any prior
> > > clean cache lines of old content are dropped. See
> cxl_region_invalidate_memregion() for where this is called.
> > >
> > > > If the kernel does the cache flush, it must be done with only
> > > > uncacheable mappings present to prevent speculative fetches after
> > > > the
> > > cache flush.
> > >
> > > This is why the invalidation is done after physical address range is
> > > populated by new devices. To flush any speculative fetches to the
> > > old composition of the address range.
> > >
> > I don't think invalidate on the probe path will always work for
> > devices with snoop filters, including HDM-DB memory devices or CXL
> > type2 accelerators.  After CXL reset or hot plug insertion, a HDM-DB
> > device's snoop filter isn't tracking any lines checked out by the
> > host. Even if those were just clean lines in CPU caches, hosts can
> > send drop notifications in CXL in response to the cache flush
> > (MemClnEvict).  A device that isn't expecting this evict notification
> > can go into error state and optionally raise a device internal error
> > interrupt. So you could end up with a non functional device.
>=20
> I don't understand this failure mode. Accelerator is added, driver sets u=
p an
> HDM decode range and triggers CPU cache invalidation before mapping the
> memory into page tables. Wouldn't the device, upon receiving an invalidat=
ion
> request, just snoop its caches and say "nothing for me to do"?

Device's snoop filter is in a clean reset/power on state. It is not trackin=
g anything checked out by the host CPU/peer.
If it starts receiving writebacks or even CleanEvicts for its memory, it ce=
rtainly looks like an unexpected coherency message and i
Know of at least one implementation that triggers an error interrupt in res=
ponse. I don't know of a statement=20
In the specification that this is expected and implementations should ignor=
e. If there is such a statement, could you=20
please point me to it?=20

Remove memory needs a cache flush IMO, in a way that prevents speculative f=
etches.=20
This can be done in kernel with uncacheable mappings alone, if possible in =
the arch callback, or via FW call.=20
