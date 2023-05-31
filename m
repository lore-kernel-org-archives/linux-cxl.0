Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0920AC77B7C
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 04:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjEaEZl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 May 2023 00:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjEaEZi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 May 2023 00:25:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B9124
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 21:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU29EDiYMbHZhE+74QJCTWuNMu8h6oTW1rN61SoEwJ9W74aelySXxoWaIUm+r2Er7WI8d4+fhJNxs4YhDnfg1tJoJk8iR3UODztivA/t4wJPfmxtsJmqBRIU7jQICOdVHATa3gQUBURJLyAo0nIPGLWzrg1/hjOKKIlwU0TNxXKtKgu9Y+j0wzU1qqPBz6R5PVC31yPJJB3YaFq5Uz0B8kEuLAu2nXxzOLNr4OAIP6uzt3+qX+8l+8D04BqLIkYAVJ4l6AXt9tAQuSJ28poDeBhR515BNMtnX6YOQfIeYKk/fJcUS8fyoCxnczps0ayLEQ6VFqc19EaU824jnvVvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ9sZgo9JDCfI32VY7NJ49HEwwY6+UCWFKkKXUICj8A=;
 b=a6fWL4IrGok/jMmV0mXNdIbjzMMuUDbQcnWWEc7smcerC8UNdUVfzDSvx4YqFUsVcUC0KhnJqva/KaA+gh+LPCBg3RUVhCSIToa6rGIED2aUU1CR3eJyAhVVNknGQYEAeBA9P5LNwDzGpB77Y/XJmKFECyS9MKnT5mtt1N0VpEr76lglYdEnVaLOS/A4TlG2nSHMudHMqu8K4117peOx1zFLPPHvpmrHyB6U2VLBjLadzK3wufmi2PoSeoElXVB+E14sr4SLrGFg+86JJbgRowyOVBDr85JZ9Esv7mJGxY91GNJkDmkpo6hA7H8aKGMzNRsx1Pgvcv2GiG421T51DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ9sZgo9JDCfI32VY7NJ49HEwwY6+UCWFKkKXUICj8A=;
 b=g8PQaf1r57KHNiPqcmZmBo1ur/TegsVawEaZFY/WLFaUJCMjkjPbV7wicjhr8G/WuAEI777URQqFtblnRjUvldKnu3hZaMdM815sSlJu7eDjq7vBUERBuZu+m3A70ULUq1vleCRADvlAtV5X/tj9qeHx0eBHTP3K1wAv1uZNwtr8JrK42kiu8ayCQZS+hwMByz9niQ4j6DH4VbnJXCb7Vdj/zyMWjLAht1IAiFBBm6xxY+GBCgSzjfz2pV2qPgwb/HYHU2KX67Rm2Y3aQcOv8xYpEnP1W/wgdV6U6ov/8p7F7OaVV4nD5kwRTpsrp1OW8pscoCFrTd6ZYzJaxMn0Sw==
Received: from BYAPR12MB3336.namprd12.prod.outlook.com (2603:10b6:a03:d7::26)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 04:25:28 +0000
Received: from BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::afbb:5c01:350a:1273]) by BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::afbb:5c01:350a:1273%4]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 04:25:28 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>
CC:     "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAABux4lAACwZegAALAMJgAAimUgAAFkB6UAAN+iiAATwrJ1A=
Date:   Wed, 31 May 2023 04:25:28 +0000
Message-ID: <BYAPR12MB3336F5ADDEDBB6245BC2B48DBD489@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d8c76811cb_250e29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <BN8PR12MB3330831F2E666E9BB1319E66BD419@BN8PR12MB3330.namprd12.prod.outlook.com>
 <646e7f96f33e2_33fb3294c1@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <646e7f96f33e2_33fb3294c1@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3336:EE_|PH8PR12MB7028:EE_
x-ms-office365-filtering-correlation-id: 8a1570be-cbd4-4c88-4664-08db618f103a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xs8+jUOteF7rnNJl2SEvbJ0EbB1bNkMgB8hd1x8wwSFQEJKjjGtEa7oXaJ+4jjL16pbsNZuN3k7xbxjDhrmKz9pVuuVQt+3F20CW+3WuFDbs1t2PH8MDVHhEr9O+/ReO2oSL/miOYsXFwNyU29MDAwGYOlf5d3gZWYxntc7hjs5OGBXxjMbAT9tp2NS2ZGVqnSKeTYibgtXa64DvqsrdBMBPOpPxBtaiKnc6mosgPgCh3aZ0EHmpZwWf3f+RkO47o7Lp46dcKBvgNpzvzjnRWtBusc/+OlTFSTS/lgryq1dfMWGZtU3/gKcfzNiO3SbzLsSsjAcUvFJEJ4R89T+X+/0GVdAZzfA/Vak8cOoQPBzhepK/m2ZQK3FCfgknRiH5Bb/BcObqi1Ro9M2FGWRHaN6uUo8ZujwtrOBNF0Zi0gfWan3DmNgQj3rE0zg7byNMc7FMRxwTv4fsgpIZ/053c8rRUPCZOtMzayZOiYr/eglUmJskgjU/b+sl3fw+zKXaDJtL/wAhXEQqsNx9CIb9dGOzoXVvHVDn4cQrbaYFn2aXThlwoaTK9JcIHL777gJhyOIVg3dteAMrRAdvA3GAaGrrHZo8vvGM79enWdFYfWgz0Y5x4xbkBcyz4eNNejKo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3336.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(6506007)(9686003)(186003)(53546011)(2906002)(110136005)(478600001)(26005)(83380400001)(7696005)(55016003)(8676002)(41300700001)(38100700002)(122000001)(8936002)(316002)(66476007)(64756008)(76116006)(66446008)(66946007)(5660300002)(86362001)(71200400001)(33656002)(66556008)(52536014)(38070700005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kk8T80K4MhB8xkTBjzGCkRoGGztl14EPfx6t5ES/61FSiPQ235ZXeZDGw7iF?=
 =?us-ascii?Q?LfNgii+zUu5d11gffzvlBXlxOV+J0iJFMx+yP7uY+IQ9HC7kAA3OcmtQ4QRp?=
 =?us-ascii?Q?lT6HoWCcWlrZAxrweU5pwy0AFydqJ6FnBKUk+e5OMy3Ykov0S5/XAB4BiD8R?=
 =?us-ascii?Q?ypIYEmuSV0ILWQYA4wvydiBXanwssx7UTER9idMalhhrgmEJcY5MRaV96Vo4?=
 =?us-ascii?Q?R7a8yp2tzeXPbsfgQkQnC1sxW0wQxKMYRlqE40a3H0TNekBvIWT+qp/kBNgm?=
 =?us-ascii?Q?54RlA+MJNOiHqXDwx7k9ZLokDIjCRGnNilSgrlz0XBOjC9XoJ48dMulhj73u?=
 =?us-ascii?Q?mKGR+bfHNGqBrG+Rt/TvEvwa6ZxFEO715kyHZ+mKyOtBAihZgvviAXRdxiWl?=
 =?us-ascii?Q?TOAbDq0r83HzT8iIByCTJsn/nB4meJIjSdfewnN2vjuuTMWjSmzR3CXbE4go?=
 =?us-ascii?Q?z4PgkrGTIHiLGnZVvhdVhdEQluAhIV8PNPDBbsgadVhVdZ4Co+mZWYuXrlf/?=
 =?us-ascii?Q?EHU3brv6X3KLHboP1MZeoc0A2sToWm5YIog0hn3/7QdYI8YmZLjaC3IAZDBG?=
 =?us-ascii?Q?JgWUEdarW+ZN0OXDixuai5a1vI2v+tsXhegi1eXCv8cicmfQft/bwc51QFtR?=
 =?us-ascii?Q?ziNmQcYVM9bUqAph6sQkPPlPJwib+lOotnr5UfbJ3npM/p9RvIts4qDmr4M7?=
 =?us-ascii?Q?/atAHEj7GJ8lF8TKz9Vj+tlv0+Op9y8a9SywVVUmBpqeXRHN4FljczWMRP/3?=
 =?us-ascii?Q?C0uaMrmlYqU4ZmmCmVM/ZUhO4mUCpjbtAPwGqZhVhCt7RAAQXgZamuQrUjQi?=
 =?us-ascii?Q?00v2zDq39dM/EQC4EcOVyPygsgJnFP5ShIMe5nCVSfRTAfQ3noOI54SmQqQ+?=
 =?us-ascii?Q?pnEt47YX5TMhrwbGVWrArdyXCl7fg2H6yQJpCkqXscZcoXwc5s3HKxsFxC1N?=
 =?us-ascii?Q?HTs96E3WHZR8Z0WYebL+zgfGfnM3iSEPPmwptt9zJ/5bN5auudV6bmFLE8YL?=
 =?us-ascii?Q?R/dn0qQX9CEkIey1onZ0sYy//gzOxM1xSZCTNI0Zj+G19y4u91dVervNj/ar?=
 =?us-ascii?Q?cKZWnX8QBN1cvWvDyq1Ias2O1Kum84e4A64jvhPrU/BDPiagOesktCPATh5u?=
 =?us-ascii?Q?v6iVrbvrExOv6FuYA1rfc1tRRfG608bgJ7kxQj7Ke6AV6XT7wyqgeCrAbqjY?=
 =?us-ascii?Q?4gPoANPBh+SYDJY9YZbCgoo8tc6m+KjPbmpq0be/KhDewNkDFG3KL8gXzxel?=
 =?us-ascii?Q?J3N5G/eMLq0w5ya0ucybCSpblao4ukrav3I7SsoaeVrupJhzMr46fKo1KNKq?=
 =?us-ascii?Q?cXthfPxj4hwyyDrM6F0klEqb0TpA/BL3xTikyKGAmm49uOscAgQeDSs+gKD5?=
 =?us-ascii?Q?Awuq6p8tb8G3LcKjnB9ayPHpq3GoW7jPHEOLNOwVfbyxUN0nopkbLk3U+9sD?=
 =?us-ascii?Q?Mr7eN11yqYuSYuEENl16fNmZEV4HfkjHoRMeZuLsSlMGdDQ78X+6IAGnkm0Q?=
 =?us-ascii?Q?PV1Jbfw0stuYCCkivMWx+wJTneZBq0TzorBamqe9v5zQNuv/uvWph6+YdVjD?=
 =?us-ascii?Q?SlyeemG8io1iFIG75bgx0aTcJRxqWNHyDynm81UG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1570be-cbd4-4c88-4664-08db618f103a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 04:25:28.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxfg53gZ0xv6XAEjqZyBn7TENlBlC8cGPZCXcdW2qD9b+8upagCzAsgZF0jpW/EfqKDEUURKpgImhcIDWbE31Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Dan,=20
Apologies for the delayed response, was out for a few days.=20

> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Wednesday, May 24, 2023 4:20 PM
> To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>=
;
> linux-cxl@vger.kernel.org; catalin.marinas@arm.com; James Morse
> <james.morse@arm.com>
> Cc: Natu, Mahesh <mahesh.natu@intel.com>
> Subject: RE: Questions about CXL device (type 3 memory) hotplug
> Vikram Sethi wrote:
> [..]
> > > I don't understand this failure mode. Accelerator is added, driver
> > > sets up an HDM decode range and triggers CPU cache invalidation
> > > before mapping the memory into page tables. Wouldn't the device,
> > > upon receiving an invalidation request, just snoop its caches and say
> "nothing for me to do"?
> >
> > Device's snoop filter is in a clean reset/power on state. It is not
> > tracking anything checked out by the host CPU/peer.  If it starts
> > receiving writebacks or even CleanEvicts for its memory,
>=20
> CleanEvict is a device-to-host request. We are talking about host-to-devi=
ce
> requests which is only SnpData, SnpInv, and SnpCur, right?
>
I was referring to MemClnEvct which is a Host request to device (M2S req) a=
s captured in table C-3 of the latest specification
=20
> > looks like an unexpected coherency message and i Know of at least one
> > implementation that triggers an error interrupt in response. I don't
> > know of a statement In the specification that this is expected and
> > implementations should ignore. If there is such a statement, could you
> > please point me to it?
>=20
> All the specification says (CXL 3.0 3.2.4.4 Host to Device Requests) is w=
hat to
> do *if* the device is holding that cacheline.
>=20
> If a device fails when it gets one of those requests when it does not hol=
d a
> line then how can this work in the nominal case of the device not owning =
any
> random cacheline?

I didn't understand. The line in question is owned by the device (it is dev=
ice memory). The device has just been CXL reset or powered up and its snoop=
 filter isn't tracking ANY of its lines as checked out by the host. The hos=
t tells the device it is dropping a line that the host had checked out (Mem=
ClnEvct) but per the device the host never checked anything out. Seems perf=
ectly reasonable for the device to think it is an incorrect coherency messa=
ge and flag an error. What is the nominal case that you think is broken?
>=20
> > Remove memory needs a cache flush IMO, in a way that prevents
> > speculative fetches.  This can be done in kernel with uncacheable
> > mappings alone, if possible in the arch callback, or via FW call.
>=20
> That assumes that the kernel owns all mappings. I worry about mappings th=
at
> the kernel cannot see like x86 SMM. That's why it's currently an invalida=
te
> before next usage, but I am not opposed to also flushing on remove if the
> current solution is causing device-failures in practice.
>=20
> Can you confirm that the current kernel arrangement is causing failures i=
n
> practice, or is this a theoretical concern? ...and if it is happening in =
practice do
> you have the example patch that fixes it?
Yes, it is causing error interrupts from the device around device reset if =
the host caches are not flushed before the reset.=20
It is currently being worked around via ACPI magic for the cache flush then=
 reset, but kernel aware handling of the flush seems more appropriate for b=
oth hot plug and CXL reset (whether via direct flush or via FW calls from a=
rch callbacks).
