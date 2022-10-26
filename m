Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E576EC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 20:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbiJZUJw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiJZUJv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 16:09:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511A8FD37
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwpwyKsACYRYsjfeDfUFCrKcZFAmAvr25EWpNzv9YPFzcoXGj+4SSdOdWCxVqGl4zSwAUQq1NQFfQQCzhqMrWQOwEW4xFc0pQeulbdUatyuxKflSD7wzZQc2Pk2c4XCFnSKgsUnLL5D833ffqykHxr0l9RcJUr/Ogl7FWgBu1XvPv2N2lHcbqAO+QEXVKRFfy7hd+3UToPY79zTqkp6v5OVUne7xsibd5/r9tOPqqpa4091/WKYk0TiWZNmuio9Qga5CanYsklT1citq79F84wEhxpeM6a06jNqHl3lVDA3VsInM/0zc8icyd/AdIXy6XBvosIA+qSA1j8U9+j2Wig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DVo/TrrNNdxxPAVU1rQf7Nw7Qn2M67MGvLopOJO0tw=;
 b=fCfI0iGS79Jvp4IqQIPjLtuoDPcIMQQX7qdqIqBgswhzuiDFzms5sQsiD5liKacE0xBfz6JT6zhvhkKQ8OO3QD9nhZfgGOrLsBv4Tjixpt0knnZPtAkvkmC1lIzEiL5ntIJX7JKBNnfeCzG4JBI6p+CSVivSJsnG9OpChroyGp81yKf7C6kSL0KXMDDEv5h2R5A1xcg/JC294ZGo0MxEhQBTKy2MCqNveqIyCa5uU/6UIaYIY4+q2bIQonV+RV8j4NfSTmTVpp4gAESWAaJhjwCEtuAVCEAkoPx/PfxHt2pcGTHGNQ5PqiKskxrqHlY3iqdPsXXk2tVvQvNIHSAGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DVo/TrrNNdxxPAVU1rQf7Nw7Qn2M67MGvLopOJO0tw=;
 b=fObf21Ych1+ZtlDYrzF0hf7TUl8L1E1Zs8XexRfm3fuLBpweLMPbUljcqR82MFRkWn1zwbEUEKX+clXj6O3xMfxGRmHqkJ4AjCqkQvqqNFoCsTw3c86xwZC3XIFzt+qjMz6u3xMIzM9FlEyZW5Y5EDwTHqTwKhD1wZOjQwkyQ+c=
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by BY5PR17MB3729.namprd17.prod.outlook.com (2603:10b6:a03:238::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 20:09:45 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::138a:e3a2:9ec4:a18%7]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 20:09:45 +0000
From:   Gregory Price <gregory.price@memverge.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Gregory Price <gourry.memverge@gmail.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>
Subject: RE: [PATCH 1/2] hw/cxl: set cxl-type3 device type to
 PCI_CLASS_MEMORY_CXL
Thread-Topic: [PATCH 1/2] hw/cxl: set cxl-type3 device type to
 PCI_CLASS_MEMORY_CXL
Thread-Index: AQHY2dyhXNFG87maXECtUmPyzlmJGq4hORgAgAAAc5A=
Date:   Wed, 26 Oct 2022 20:09:45 +0000
Message-ID: <BN6PR17MB312197C4CA958ED267BB576683309@BN6PR17MB3121.namprd17.prod.outlook.com>
References: <20221006233702.18532-1-gregory.price@memverge.com>
 <20221026160545-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221026160545-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR17MB3121:EE_|BY5PR17MB3729:EE_
x-ms-office365-filtering-correlation-id: 75ec2902-7848-4a9e-04b3-08dab78e06b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cEyZ3IwQ0Ol1vpMxKeDmWx/vw4cgeMtrvImhEFGwC0eJGiTLrECAgoKWFujXCvIh8Oz7fYsAVynt3ek0YdQ+Qs7RCPXhZhbKZ34ZQHMKTsTj00Yxej+AB5q4NH38WzhdYirUd0+pdfyo741Wm/Al/IwuM7AZCTd8zoGcZnumdyJ1L84S10cVJffjuW3o8aF9dumEOhLflVgN8BVfQErp/78Ui2UTUxxPkXWS7SPiPxhEa7zutNe0kDJEpo63LhgA4AV88u+SLIm0N5LfNY2tNS59zLq/TQpIOnVgYyeFRRC7nzvFnaQCz2XsGUoeKJaIyPNl+ttu1rIbq/VUB4/0LGvCYzerJR0kgPir3awpkKpTpw10HipU2fAlkE3iubNyqbJ28BV3mnmtjGp78FiLyLDxt1erLKvBaNz4stomnH4urnV4ANysfTM5gIP96X8zDtTdf4AiAOeuvhJT1I6XFFRzmZv0rxE7qN6X81vjFvBCs3RHz2zdF8/IBQiq598YYHrfWvQ/cfdBaov1/N9RV7iAF6A3qdaR7J7UAeHMUtAp279alI5PmThV2tHxJaQUyL7DmbGlZCUKkt1RdWdROz6GmfXSBWk2O/8xWdYRny06pJ8r0d2vsiWNxQQynKobiiCMGKeGrS//oD1Kt2j3xBQFDvCjey7srWWjCGkAclebtbf8lLV5qaY810x/3CTSvydy2aVu6muRRANED8WX9Tm1ZFt3q3ETcfNWWvzjuh4NHVAjSi/WBzoQtvnQow/RgZ41UfhsyQWouw2QYcS/Gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39830400003)(396003)(136003)(346002)(366004)(451199015)(64756008)(52536014)(122000001)(8936002)(33656002)(5660300002)(66556008)(76116006)(38100700002)(66476007)(83380400001)(38070700005)(66446008)(66946007)(86362001)(54906003)(110136005)(26005)(71200400001)(478600001)(186003)(9686003)(55016003)(316002)(2906002)(41300700001)(8676002)(44832011)(4326008)(6506007)(53546011)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2z2W5wW7ZX35yAFg3zCfpAFZzcb3EDFRg3Ukbggt8PjjlDJqAC1lSkfaFpnt?=
 =?us-ascii?Q?kcjvJRoFsLnMdyrIvHutu9ewUjuUvBXllBljWoBWlk0B6JOb1CrsAhH4onuC?=
 =?us-ascii?Q?C6WPdA9dfTjTb5ujyN0SVUSnsDdQ9Ej4vj8xKblDhJtaBQipNwoiF87u8KEL?=
 =?us-ascii?Q?sfLn8wXQ4cT8UnoJ6+K2ZlibJs5oE3h+43GhsgE5Q8A8WT7+dnzbbOrCAhO9?=
 =?us-ascii?Q?IPySw6Z3jgeHFq+QEeiO+X0+3IJG3RnkZSIc3SHq8RsvfYfdhTEZQiIN0/bO?=
 =?us-ascii?Q?OHWqXMmtd1ISOI/cKYeuOdq4PuwaTltv9fGiF5R23Ayi+kQ4ao5Xz841sTDW?=
 =?us-ascii?Q?Z4+pQZX+I9Auppxa0MDb+QVshHfoS8dREUqTmVY/WfIHjIpD9AlKpTEqMZ7c?=
 =?us-ascii?Q?X8SqsnBezk/AP4sU0u6eValW48nJv6z0SreA89sQe/UjrN9CpHj0alGcAJBW?=
 =?us-ascii?Q?bYFpKV6hb30WdkRQ0ewG/RsYX7dMo2XUlhvj8qj0jR9XPD8Oby16NkBMiit/?=
 =?us-ascii?Q?O3dIZ/5AYcZBWuWt0daNdrx8ii7qkyVV34icfaKBPhE8gp+5bu/AMf+QQ+hy?=
 =?us-ascii?Q?+VNdtmz+GDfLeQRe3CEHD4YeVLw9cSWEORCnghsrqS8PbrzGOOHU2HZlQ3Ak?=
 =?us-ascii?Q?w4Zn1b+gSk/U+46rmoaOTfY74AX5VRxopLicrXubbynHKAe9IdNx9MGiUHpx?=
 =?us-ascii?Q?P6AYdPclcXNv/vGyFbev7EwDn2YhHIwf0DKNBF5KWyj9kQGfsmFamB5RaaJ6?=
 =?us-ascii?Q?Y1lOsnkjuc6UahtXnOmfblWMA5FeOtdqdNpRMgMM1JRb7MSCz4VnDLsdBi+e?=
 =?us-ascii?Q?iDd4/wjulj3a8zmAVqIrXuu8iwhQSj3YDbO8lJhmcKZ056j/tBp/nI19giQ8?=
 =?us-ascii?Q?woG+0DOSGeDlxwACi2GqGxKD2oLOjBQWrTCh1q0dmSw9HUFWZt4h0rS2FDNd?=
 =?us-ascii?Q?AJ7tMfMcqf2e4/Hy7RNZki1L7iyC36t/zK0Do9ES431IZWCU4f7zx659b/rN?=
 =?us-ascii?Q?8cHfH6NoYmer5pfAh4h/REDVONeWDVEKqvTkm4MZmCeGn9a4vae6PHlSiwFI?=
 =?us-ascii?Q?/nox4DBzcVFphI4EEcQ95eBdAZKTs03kiRxEIHibjyuqD/Q3hMQzOrpr4KuC?=
 =?us-ascii?Q?p4/HrVs5+uDt2J7i+XxkYRNNW7bKhcEgEdSCAY4yzGYXiU1ndShs5PSjnNxp?=
 =?us-ascii?Q?CwT+aQa1snKR8kibqFdkMXc1Ni+wwHA7wvvorVXUG1xD7++/KsByGPU5iG35?=
 =?us-ascii?Q?Q9oWa5UgON5NafcoRBpHUSc4O9sjryHhFoXTxfio9bZN5/EM6gasqfUkvQ2p?=
 =?us-ascii?Q?L5sSlMwKpC9TIUpYx1MSXVehKEI8S3EpDwPt0BLzRr8U5i1b9dMly/wtUUmZ?=
 =?us-ascii?Q?VDd03bYyG8/LW9BPvj4zEcM1p4zmzdX5Pf0yQlcAbu/woLqM4ktDiZwP4aue?=
 =?us-ascii?Q?HR1jvKJ9EjUp0BO/+y4gbn8I+sUoe9abh6uGRk4oXbc55qVJcmL0jkBg0Rkg?=
 =?us-ascii?Q?AZtgxp9vAMcx10Ql5T/Zlt/40lBjmSG8U6iM3Wv8pprbkRHBifvlJkqsDVpu?=
 =?us-ascii?Q?zYpGlgqhuGoJHJCjmw2Z/HFzzACJeJrAR62SVG5k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ec2902-7848-4a9e-04b3-08dab78e06b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 20:09:45.1839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhX29p3XXC5tkv+HFjOSXt5uW6q1YeSIh4lz6+aBR+BcAgH/nMJpy0Q/ZqSMG3WtlI75jgFjfsH0sScetLH2+NN/EHXOh7E4NCkZ7cicpf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3729
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

I believe this was dropped from my line because Jonathan carried a similar =
commit on his branch.

Happy to push it up again as a separate commit if that is what you want.

Noted for the future on upstreams

-----Original Message-----
From: Michael S. Tsirkin <mst@redhat.com>=20
Sent: Wednesday, October 26, 2022 4:06 PM
To: Gregory Price <gourry.memverge@gmail.com>
Cc: qemu-devel@nongnu.org; jonathan.cameron@huawei.com; linux-cxl@vger.kern=
el.org; alison.schofield@intel.com; dave@stgolabs.net; a.manzanares@samsung=
.com; bwidawsk@kernel.org; Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 1/2] hw/cxl: set cxl-type3 device type to PCI_CLASS_MEM=
ORY_CXL

On Thu, Oct 06, 2022 at 07:37:01PM -0400, Gregory Price wrote:
> Current code sets to STORAGE_EXPRESS and then overrides it.
>=20
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

If you expect me to merge it you need to CC me.
Also, do we need this separately from the series?

> ---
>  hw/mem/cxl_type3.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c index=20
> ada2108fac..1837c1c83a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -146,7 +146,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **e=
rrp)
>      }
> =20
>      pci_config_set_prog_interface(pci_conf, 0x10);
> -    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
> =20
>      pcie_endpoint_cap_init(pci_dev, 0x80);
>      cxl_cstate->dvsec_offset =3D 0x100; @@ -335,7 +334,7 @@ static void=
=20
> ct3_class_init(ObjectClass *oc, void *data)
> =20
>      pc->realize =3D ct3_realize;
>      pc->exit =3D ct3_exit;
> -    pc->class_id =3D PCI_CLASS_STORAGE_EXPRESS;
> +    pc->class_id =3D PCI_CLASS_MEMORY_CXL;
>      pc->vendor_id =3D PCI_VENDOR_ID_INTEL;
>      pc->device_id =3D 0xd93; /* LVF for now */
>      pc->revision =3D 1;
> --
> 2.37.3
>=20
>=20

