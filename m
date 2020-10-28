Return-Path: <SRS0=0jUc=ED=vger.kernel.org=linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8A8C4363A
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Oct 2020 23:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8316C2076E
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Oct 2020 23:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UW5phaDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbgJ1XGT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:06:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17976 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387689AbgJ1XFw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 28 Oct 2020 19:05:52 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99f9520002>; Wed, 28 Oct 2020 16:05:54 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 23:05:50 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 23:05:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE4lrCOg84gxFPvCSRI0eQ8hyz+wRnayJ40jW3JW9RPY8SJzteJLa0OXwvj1Q6gZ1QP0n7DNO6gAW4CG9fQe7zgzqD97Lx0d6K+IYB06jrlzF86GReqrupHAZBSRIqDgPuIBHT+NdLMPeKwrdwz6ya0r47Tdc4oMnWb6hNgqAXVUCRwXHA7HQrqebKalzTK2xtjBsGoY0iafAxH75GxHVZ0C0nTS0pY9bKqvp0KcRQKZVlfPVBHrLd11fkhgMlraSaTOtMmMTa89dhjurq1tEDOUnnseyZ7xDJHkuzj4EIVIKRd0pxaK0ylz6KQG1PEkAhpN6kZIX/KgPo5WfQg+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg7lZafS/sJRihulsXzgJBiwbm7ElbbUJJWwL0mBbgQ=;
 b=mbGOr6lxvHu5xKy7VIXM16L3Z0UJnOT7pRzovB5rQkmuW92WnGT4z93HD8cDtvbI+WPdBlyCSJAtACRYcr0KpAsXqryzXU9GRDmZMWCNau9sfliyjTKjXj/h20HlhzhPA3FXF44fsPQST5e+ZOjYZT7ttp4L/fKcIB178z6T0RuzYoU9U7vLD1A457JcyvP8nZBnW8U9i7YZ899bukgomLjemnXMhbuzqH0kUz6DpowJZjmmPQR+4cWZk6gnoAGIe3lFK6H168/Kfui0k3ORtFrJgAaNRq6X7xBaykcoZVlSj8HuULBf9FVoiTa1AkQVU9Xz8hsWeDuL0d4uec5yvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20)
 by MN2PR12MB3662.namprd12.prod.outlook.com (2603:10b6:208:164::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Wed, 28 Oct
 2020 23:05:49 +0000
Received: from BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::a078:c548:edac:b867]) by BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::a078:c548:edac:b867%3]) with mapi id 15.20.3477.021; Wed, 28 Oct 2020
 23:05:48 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Vikram Sethi <vsethi@nvidia.com>
Subject: Onlining CXL Type2 device coherent memory
Thread-Topic: Onlining CXL Type2 device coherent memory
Thread-Index: Adatfla1CkojzXe1QXKddAzhdTnQ8Q==
Date:   Wed, 28 Oct 2020 23:05:48 +0000
Message-ID: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=vsethi@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-10-28T23:05:46.6794377Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=3e24c003-12e2-459e-98a5-9a5ad07ec804;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [12.97.180.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f06c1c4a-fe89-4600-cd4d-08d87b960245
x-ms-traffictypediagnostic: MN2PR12MB3662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3662B4B170C4BFD5FF66C0F5BD170@MN2PR12MB3662.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cxLJZ57HBKy937FipC+eVgOAnGIIum0su4NwvBYOZTHoLQcmV+XhiJIfnT9XQeocJnyRXUNM2zy8f8Ws0vMufdK6b4xqNIjQg0U0gyrS90S+7b7QoQq0EGYyAhHRwvwlWgT1qaS7ccBoa96BAjvjvjFfU5m9mU5Z929AAE4YN9xm6O33+/81jr8l2mea0hlfYzk3z5/285rVhe4LBD1qBpRMBMH48BbUrA1D/AVCI5AOfe4AiFHWk2uad/b7j/G4uhjdcKetjQ9g6jpJrxlf2KtLTfMm+rmRsqfhb6ZUPp44LBQaTou3qWIMyfB9083o2Iv2EAJtsBr3hz/V8QZBYBVvjT3nrZuuLzanWxsMsVk+1oloqK4sCt6Z+HVKrXCIYMH/JmgnM+e6aWRnVaHiBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2532.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(7696005)(66446008)(478600001)(966005)(76116006)(6916009)(86362001)(26005)(4326008)(54906003)(9686003)(8676002)(8936002)(107886003)(55016002)(316002)(66946007)(52536014)(6506007)(2906002)(186003)(71200400001)(64756008)(66556008)(5660300002)(33656002)(66476007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EgzvGCnPcIS8eY9D7AQxMxQqovsAjupFZWv5V6H2j7aR048biIvU/VG+MqfB4Wlu/Wtca8Yk2fYj6FX3rdoohiIzpz8pgsLWcsP5/SPhHwVl/VBsdlDyFjHX+qA0ZgDAXn14nERKbwk3dF5ir8ZoVVLnJRGaQpjAS3gpO9IUAezAgjmT6aFWubkXn1yj8zUlHmMj8zulKU8QkiXhxLsJcf6M3aQDfcjEml8HuRAFKiwLUYbZo+m5QWpwc2xmKYDFWUN1D9+8FYRywNjLOVo7Cp8X5zY5qhf2m1JiqW5bUT/RF25xqzG3hrdwN/GbH0SHGicSGDZNH+OvaP/eVdivjtMOT4KkH9b7kxEQK+INMiykKohJDDcHVPaGjpp2D5wMp8ut2sa1pYGeSJGrv9N7vFEV5OvrwO3NsmzgXfehrg8J6vR2bxnQdzV9mHzVzz/RQzggk6+wCZoCoRgEUN+/BKYWEHaM1L0viSnCa4UupWh0gPAmKnV1/zb//aRh0yLvYz+b51lOVzE1n3HEb7r+qeRKmTMXN6+Z6oa7oVVSQcZse2DijSy2xxB9XJsjF+lERSOpxceyjnNlgo7VprXcYS5czvOhzSLo/Z4a9I8TuaBM3utuUxwO1M2VxTuD1jbUg3MitMYUL1R5Cr7iO9CINA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06c1c4a-fe89-4600-cd4d-08d87b960245
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 23:05:48.5015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvBzVCDFECH8QD4DJd0yXs58H9G2kG5mPqque7hbXMH8koEL2cM8kQ5cmZLEry5KGU7ULwPvjSRCimjnfxbT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603926354; bh=hg7lZafS/sJRihulsXzgJBiwbm7ElbbUJJWwL0mBbgQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
         Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         Content-Type:Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=UW5phaDEwZDEZXRoiiY2TUB7cdmLOJqYEH+hSIq37lDWciiEsaraONUeoF3K0M8sw
         JKKOzRZrj7kNBRJUGyHHc//ptlv2DfmQtv6rrTO9DxAysJGeRv3XT2jp4An5JDFvMi
         td1dGkkiMfVC2UNAJwiWa4X+dlSZEajAg5r6322Mx7dbpGS3kxpeKhOsTf835CGb+j
         dGWFgziJa9UDKvTjMC8ZlWwF7d/nJcFQsU+iuMfU/gDgpVVvTwwB7Y7UY5KOXFrDuD
         ggbv9LVJ+CtmvdyLZ9gw493d0rSXZP3GWapIMBaxVOfOxeXiZD56KgzMhghPkj8mlP
         3k00GuEgHYriA==
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello,=20
=20
I wanted to kick off a discussion on how Linux onlining of CXL [1] type 2 d=
evice=20
Coherent memory aka Host managed device memory (HDM) will work for type 2 C=
XL=20
devices which are available/plugged in at boot. A type 2 CXL device can be =
simply=20
thought of as an accelerator with coherent device memory, that also has a=20
CXL.cache to cache system memory.=20
=20
One could envision that BIOS/UEFI could expose the HDM in EFI memory map=20
as conventional memory as well as in ACPI SRAT/SLIT/HMAT. However, at least=
=20
on some architectures (arm64) EFI conventional memory available at kernel b=
oot=20
memory cannot be offlined, so this may not be suitable on all architectures=
.=20
=20
Further, the device driver associated with the type 2 device/accelerator ma=
y=20
want to save off a chunk of HDM for driver private use.=20
So it seems the more appropriate model may be something like dev dax model=
=20
where the device driver probe/open calls add_memory_driver_managed, and=20
the driver could choose how much of the HDM it wants to reserve and how=20
much to make generally available for application mmap/malloc.=20
=20
Another thing to think about is whether the kernel relies on UEFI having fu=
lly=20
described NUMA proximity domains and end-end NUMA distances for HDM,
or whether the kernel will provide some infrastructure to make use of the=20
device-local affinity information provided by the device in the Coherent De=
vice=20
Attribute Table (CDAT) via a mailbox, and use that to add a new NUMA node I=
D
for the HDM, and with the NUMA distances calculated by adding to the NUMA=20
distance of the host bridge/Root port with the device local distance. At le=
ast=20
that's how I think CDAT is supposed to work when kernel doesn't want to rel=
y=20
on BIOS tables.
=20
A similar question on NUMA node ID and distances for HDM arises for CXL hot=
plug.=20
Will the kernel rely on CDAT, and create its own NUMA node ID and patch up=
=20
distances, or will it rely on BIOS providing PXM domain reserved at boot in=
=20
SRAT to be used later on hotplug?
=20
Thanks,
Vikram
=20
[1] https://www.computeexpresslink.org/download-the-specification

