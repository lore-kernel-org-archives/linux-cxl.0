Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E98C7EE2E
	for <linux-cxl@archiver.kernel.org>; Wed, 24 May 2023 00:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbjEXACg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 20:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjEXACf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 20:02:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78497B5
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 17:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amU8ezgE74MqojqsXgAjU85BMWOhHGkHeECe/iLt7tXzWR1qApdOfncopzz64maZ9l++3n+PHQV7bv69roe0ezsDJhAdwOVNHY3e6XY8EumY0u37jnHISuxVS7j+uzj6IQI9aDIgatAMys4nuoYbXEvLVxkTMgdiOSfuz/z1js+Sq+CfO78Yag1gCtJLjrVXAtv3xrFKA2bFau1G/UD33EXHTYBuJ+aGEgbe/9SOlZG6Na4cIjVq3QNicCNd6i9Yso/NjtOWdKYEyrm4A2Z90fwY0GdtZFAMf9q2F37uAvRFmpdrjEF6Mr05YTOdzKqZpJr2mWsGoA9lBIL1JM5xEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIouanlpMwFZgNdg9YKxgZAt6R3IS4QJdC2LW6z0dpI=;
 b=JMERCsRzzRoQ7Y+B60dl0WWXf6MAVTf8JHvBaNOw3Ba12tVbrGkbSHC2cVzj+k94q5RGwA/rVIPmuMSeXZIQzi1fV+QT+VRUUBLsDZNd0m5CueOMqry3D2UOmCquVvJ+iqwuPximm9HjLP1nyel/L+dHjZ0xY3GxeOxjvJgC2MQKG4eppo4MmNqcfe3jMWXWbUq3nvN+sylEMGvKdYEP+RQbmV5MORzuhR1Nel9UoqQogTW8PS3Api8kgpFuXv8Cbu2Zd+OJA7fqgpzXjsP4enehx75/HA7CRaqNXgYAqvX2bYiL2DsNASAyVOltYKkTyTsGJ2YqHEyqxe2KndNN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIouanlpMwFZgNdg9YKxgZAt6R3IS4QJdC2LW6z0dpI=;
 b=M3q+7O+UBlMMi/pWHa5p3kBU1aKZmJlMV50L398OhwzvrAy5nJW2fVs7JMceBxORy7alhsBZJbcONYGI7GkE66WUDfr0vqsjZN8MLvoNspb8GkfUg4PLHjZW4nGDUyjE8GmWlL3f9/RW3CU2bBqLLHDXE/KzkG3Fo2I5yIWy1TcJw5Oxa20M6RXrgQEcaXGvKrt/AdzYXkZwPY97TG0RT6Dgi18iDHv0EgZX6RwelZVJae86b8IdjUmnHzZKBOFbstw1YqitTbWcM0em+fYcVSK6OWLBTsS9vIBc/Fhxsis69BtdCRRGT7xOUQvavHx7oLBRm40hkJjrKHNGhS0UCA==
Received: from BYAPR12MB3336.namprd12.prod.outlook.com (2603:10b6:a03:d7::26)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 00:02:32 +0000
Received: from BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::afbb:5c01:350a:1273]) by BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::afbb:5c01:350a:1273%4]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 00:02:32 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>
CC:     "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAABux4lAACwZegAALAMJg
Date:   Wed, 24 May 2023 00:02:31 +0000
Message-ID: <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3336:EE_|MN2PR12MB4392:EE_
x-ms-office365-filtering-correlation-id: 53e76802-728c-4d42-1d92-08db5bea2be1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sAjSS+rM7CvlY0oSU9UesEQnDM6JIiZVCnUoMPsZSe/prsQrCkoxTgTwUorh9uUzfv28kqk/T8nAxGRs8DcofLGyzR90ombhWo3kiEJg8jAftQ8J+jHfEZDFVQuyfEP7dfS3LT5k+3LKWcjR4WoxdnEVNVoXxqSe4fz554JWjGpN6LL5GwG1rsGXRu37o7Gh6VzsGM5fyEcgjx/mn9GrTmk2m3zximeGaLEBYeuWN3/LbK/0rYmTtgO/kb9r5RAxZcVHdzE9yfJmGgsApfoFP64OtPb4DWQ7AEnM9sfFcG8drrE3WWmw926W6HjQZbAraTBq5Ej12k+NsF3HbOctM/4zwdLtdw/+SZv2qoRDXj/fPTLsgM1I8ZsHh3UzoHaQ5PIt8Db9dU6CTLNck81qDrLKLU3IZeG8445qE9T2QIuZiAElEN+o+vKHyFIyWbw+hiQwjEoKpokhrGKq+UlktAfuY+4doH2XX73c0u2wK2zYmN0dNgu82i7ateY0RfkVoEkcNoAz0iE+YcK3pH9I0pSV1HpJ9vzt3vKJrmuPubr0iBpPJDSN9ImTnhnEjfmciiUvxYKpTPgEDdlRYVFaQNuXb5Z1LyJLZ3wKj4oEH2vfRQi77Y4YA9RJMb9BS5yPN60wnnVOuBbO+TDHbTq1CctgkTCCq+abC5XTP78VQck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3336.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(8676002)(52536014)(5660300002)(2906002)(8936002)(316002)(66946007)(4326008)(64756008)(66476007)(66446008)(66556008)(76116006)(478600001)(110136005)(33656002)(83380400001)(71200400001)(53546011)(186003)(6506007)(9686003)(26005)(41300700001)(55016003)(38100700002)(38070700005)(86362001)(966005)(7696005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OGP2p52QxSuLepyAxeHrfm2KZ1vIt5GBBMvmA19PaV88lIUNL7kIxqo+uDtF?=
 =?us-ascii?Q?r76YjVrRQs3bwX2F7rDuax/RYPGM9F1tRx7E4pF47VJzefxeKsUwthM4drTq?=
 =?us-ascii?Q?h7DP58dZYzmEGOT128XnX/HVR6IgFFS/rN4FxbfVMVzsWNdfNR8YbOU8X7s8?=
 =?us-ascii?Q?FHrL0FHs4LDbN5ul4Nxb8texsHCo3qQyNPjPZtbFSlyqchh2mILx2Gv/d6HP?=
 =?us-ascii?Q?biBXQg5aq5Shht+aV14LjManGTUC0+6lxASx+GOOAahi3vivYe5EHTl8O3ot?=
 =?us-ascii?Q?zEa4uQXIQ2YKGcneNb5f6w4aquBxDWjwSZAw2qe7ehxRIWquNRQubd5bfmVV?=
 =?us-ascii?Q?NscSBGU+aV8EJ1sQggjvlOh8E4oxDad8Qdhc6emk0eCjwyaEOejORTYOzZke?=
 =?us-ascii?Q?VZQ6VUAsidxmJ3jTtije7Ocr2o8Yq92WC4tUHsG3Lz/Lefld0AuAPKxekSMK?=
 =?us-ascii?Q?dtR22NJKNRBu/zR20Cdtj+O/qNWq9MTxk1PJmdsYYAE3Tw9vpA47jVWJj3Qz?=
 =?us-ascii?Q?rTP/X1E14zMFgpxDlhKvoxRsYsYDQ42PvKv8j29TfCZXisuNeORID6vfijb0?=
 =?us-ascii?Q?q1PXojHTsq4OOcow/IA9wO/cUrZoPbhEF3ZaJkU+8Fkyplb+4OmyBsif++BN?=
 =?us-ascii?Q?kv97u41jlIYFEZ3M8WVQqduU7PhcWmqxQgNjNXZX4o8JUwMAcXRy4G9EjLM1?=
 =?us-ascii?Q?v0eXDQxrprsqozRIub628ZUrm6pVACPPNfktwSbFnwOms6JLoguCHXdKrdEE?=
 =?us-ascii?Q?FYh9/ohJ/pG76YEuZVMb+Nkh8t65Chr96wP0ho+EbzPvZOCsUxaK339u7l9s?=
 =?us-ascii?Q?v8L4SY+EGCsMlHttCtS88E+e9p3unHSgEpcZxLmHoDIJ950bwHChFybQvMCn?=
 =?us-ascii?Q?d69/sV+dP7Eq3cqd2nsvfPtyn1EJxBW50wWJ1GsrSb/KNcjeKxAdq48HalDN?=
 =?us-ascii?Q?nZL//l2z58gVgsXOOUPLYjCsf26FZ1uUYalqUCKvFYE728ccFfAgnk2KiQxR?=
 =?us-ascii?Q?RwNlKQXZpOdEljDsBWo3IoUu1U2J6yWkuLKlPJBoP+nqN9lvWCZvEk+s89Ef?=
 =?us-ascii?Q?nXvYLx44PO8zwoHxfB8vOQ+zA0V8SiIYb7SlaHVW4mbP803Pl90BWq+rF3gd?=
 =?us-ascii?Q?SMiqUKhKpy5PRCX6odjaUDO/ZLLOw81PsNyWznd1zjjjqZ1cR31+1epTIPFD?=
 =?us-ascii?Q?QyPXNDrQwiboFpQKP/qPJC1yn5dpZtVGwvrlv7cPK+AdB097lDCHDFNfj7SC?=
 =?us-ascii?Q?UUIbwdABVP+MQCtXqxLqDWRNj7ZoVnFj+7rEkBRCoYoTtGYSQmutDKjKgonE?=
 =?us-ascii?Q?6yBLXBtFQikRgvCF0jbC/HFhdii7HrMjCIvamjtQ1GN4tOfoypgEMen2UsbO?=
 =?us-ascii?Q?9JAMkp/SQLkOAl7GTllthVvLY4+rxWs3Hsj4je3J2BBM6fOmHk8rVzgpWvWC?=
 =?us-ascii?Q?Orgt4YQFXvd+jD1mfG0Uw73BIgNtGGLpPn/sbw92MCueN1TogDD6t4tGVccq?=
 =?us-ascii?Q?Q9P5Qd2INbnKrtOeGv06cgzVANgqV9jodvhNfMhA0zjHln9Gf8AU23eIgk/W?=
 =?us-ascii?Q?Q5iiCITIt5fDotvLxlE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e76802-728c-4d42-1d92-08db5bea2be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 00:02:31.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8Cl9PUpGamC7Ii8x2mit3Kpb/hLySlvYPtRi3HJQDbFk/Kyh9h2i0nfhx5ghRxgieYS5q4WrY1GgVAr0obZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Tuesday, May 23, 2023 1:40 PM
> To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>=
;
> linux-cxl@vger.kernel.org; catalin.marinas@arm.com; James Morse
> <james.morse@arm.com>
> Cc: Natu, Mahesh <mahesh.natu@intel.com>
> Subject: RE: Questions about CXL device (type 3 memory) hotplug
>=20
> Vikram Sethi wrote:
> > Hi Dan,
> >
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > Sent: Monday, May 22, 2023 7:12 PM
> > > To: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>; linux-
> > > cxl@vger.kernel.org
> > > Cc: 'Dan Williams' <dan.j.williams@intel.com>
> > > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > >
> > > > Q4) Current CXL drivers/tools support Hot-removal request from PCIe=
?
> > > >
> > > >     CXL specification says "In a managed Hot-Remove flow, software =
is
> > > >     notified of a hot removal request."
> > >
> > > Currently there is a requirement that:
> > >
> > > cxl disable-memdev
> > >
> > > ...is run before the device can be removed. There is no warning from
> > > the PCI hotplug driver. Which means that if end user does the wrong
> > > sequence they can crash the kernel / remove memory that may still be =
in
> active use.
> > >
> > Is there any notion of a cache flush when memory is removed (or in futu=
re
> CXL reset)?
>=20
> No.
>=20
> > Generally, CPU caches must be flushed when memory is removed because
> > any evictions when the memory isn't present can cause async errors
> > which can be fatal to the system or at least to VMs, depending on ISA.
>=20
> This seems incompatible with memory hotplug. The cache flushing is only
> done on the subsequent reuse of physical address range to make sure that
> any pending evictions are complete before the newly constituted address
> range is put into service, or that any prior clean cache lines of old con=
tent are
> dropped. See cxl_region_invalidate_memregion() for where this is called.
>=20
> > If the kernel does the cache flush, it must be done with only
> > uncacheable mappings present to prevent speculative fetches after the
> cache flush.
>=20
> This is why the invalidation is done after physical address range is popu=
lated
> by new devices. To flush any speculative fetches to the old composition o=
f
> the address range.
>=20
I don't think invalidate on the probe path will always work for devices wit=
h snoop filters, including HDM-DB memory devices or CXL type2 accelerators.=
=20
After CXL reset or hot plug insertion, a HDM-DB device's snoop filter isn't=
 tracking any lines checked out by the host. Even if those were just clean =
lines in CPU caches, hosts can send drop notifications in CXL in response t=
o the cache flush (MemClnEvict).
A device that isn't expecting this evict notification can go into error sta=
te and optionally raise a device internal error interrupt. So you could end=
 up with a non functional device.

> > Even so, kernel VA based cache flushes will likely be slow, so may be
> > better to have the notion of an arch callback that can invoke firmware =
to do
> the cache flush.
> > Perhaps arch_remove_memory is the right place to invoke such a cache
> flush/FW call?
> > I think the CXL specification should also address the need for cache
> > flush when removing memory or doing CXL reset.
>=20
> Seems out of scope for the CXL specification, this is up to each arch to
> handle.
>=20
> Here is some discussion of what ARM is thinking about in this space:
>=20
> https://lore.kernel.org/all/40cd479b-f0f8-5dba-0e41-
> 4cef73693927@arm.com/
