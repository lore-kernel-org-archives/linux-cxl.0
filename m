Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9707BC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 23:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiA0Xj6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 18:39:58 -0500
Received: from mail-mw2nam10on2101.outbound.protection.outlook.com ([40.107.94.101]:7521
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236183AbiA0Xj5 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 27 Jan 2022 18:39:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy49oXs9LE+j25uMLTGtkJd59MP+r8AIxG/VkquvcYATpJrE5rL2ZAcv0tu353TWSvwKO8nJlE+2CjrS7/jWx2667wYAJEXm1qbSIUlTPXrXqX63pPdY4rn0SzgyW9q8icFMEYomZeNlaxgiNUoDpISYeXi4s77sAWlNMM8Z4jGGc9VTRMiSOSPCM3KOcIoiH2/jJe91SuomSDiR76+z+qRJBEvy+drflGGCCnpsjH2kzxnycnBUV3bKtRANq/FVlYrYdtzDQrvx9tEmNH9NBfE52/uzhyhyznw1xk4CvytatpkBBcm+2B5xc+WlaO+vRaA71fS8Xx0fWYU0fqzPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH7TsvambkVzyO0gncaJZpNX6PUTvBd2QgJUbMhBP5c=;
 b=NRnHpuP0HoMOqooPQPXcWV/CJPfXUAh5dPZNV8XZvlKCokPYAaSiiO3C6fjiFgwda0zILQvqX48Kn7Skk0I3snhKz0Ai7OwHMiIeBlpsFbPTEjB60bPgUJDAVLmqBnf2PU9xgk4iUIOH423FIAXuOUSeZOgGPs2xM36N8E9sV4qZIeojxslVF2EUoRNQ4PqucTSIxarCc1E3caX0JDpNFaV1L8VrX6zgQfBumWS2J/mM+wOHX83fbH7zE1BdIkVX/k8LUe7zyliSA2j1tpXWc0Sda/SvTIgrWaSeYdPEM3t8xaMZ7IpEo/qOnbI/HE2CPWgVj0PUcCDNZs8FSlZW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ADVANTEST.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH7TsvambkVzyO0gncaJZpNX6PUTvBd2QgJUbMhBP5c=;
 b=LSFk5qP0fPZT0oetnG63XUbm3P3X54r+vf1vGqIpsByFvBJ8zB81pgaEqGTZz9xy09XiwMN5SoZ8LJQxyYQH/IwgWruzlTCdGNRbJt+Is+0pjK9jEuWkFVwaMEsmgRHngOWwEtLp6kpmgxsfL68ry1XAsI3Q6ksKJl7QpLslJLPxF9+oQWn/GEPYeKmKawDduNGO/mX5v7YTSawyU6PntbbMOto5XLZNpoU+wiLKkTXIKjokKlxM6vGnZe/DbF4HZE2zoojbdmm1N48kLEuacdOh29t88CiBkuF7/G11coh8iFPQXzVuE21YJujfyujtQAanocG6R2DMfkL1PLeEqw==
Received: from SA1PR05MB8015.namprd05.prod.outlook.com (2603:10b6:806:1a5::19)
 by SA1PR05MB8142.namprd05.prod.outlook.com (2603:10b6:806:1a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8; Thu, 27 Jan
 2022 23:39:54 +0000
Received: from SA1PR05MB8015.namprd05.prod.outlook.com
 ([fe80::9893:58d8:4df9:b92b]) by SA1PR05MB8015.namprd05.prod.outlook.com
 ([fe80::9893:58d8:4df9:b92b%6]) with mapi id 15.20.4951.006; Thu, 27 Jan 2022
 23:39:54 +0000
From:   "Treon, Justin" <justin.treon@advantest.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Treating CXL Type 3 device as a block device
Thread-Topic: Treating CXL Type 3 device as a block device
Thread-Index: AdgT1EtILrDrPlH6R52tS4rhimYvGw==
Date:   Thu, 27 Jan 2022 23:39:54 +0000
Message-ID: <SA1PR05MB8015E5AC7D6F6D028D5FD8F48C219@SA1PR05MB8015.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=advantest.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b06e44b3-3716-4dc3-74d6-08d9e1ee5212
x-ms-traffictypediagnostic: SA1PR05MB8142:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SA1PR05MB81421EF2928349BF00835D8D8C219@SA1PR05MB8142.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ilYye+b65Y0XaWqfA3c+IBAx7ibotlC+kvgsU7vRyN5QSTm4BrtSltabsDQ/a67W2UF/TjNMq3bx+DsbsLq/i2ZMCWcROzx3NqfzmMspS/WKoLqcAwAdxvh9kDGAgPzV1Q81uOlX7GH4elQqLrtlqR7LFihEXF69rmMXtegbv9BdQs+07l1y9RJ8xsRxbqraxge30lK0qVrUYZTMu/Wv5F54uCYin/fYF2EgOBE/og/vCLid6vKRo7IP5Ok2kVUaL9nnFchhSWC0sYLh81Yh+4AmZZJqdueqYKy8Z43pa9PP4dssKpcTXm6YYLHdI24KQHWWWNM8+RWbdpsSVpJxcZNNQgCifQGpFVJ6fqSqiOec2NPmurTD2NWVjsy2VaayV9yK9PDTNeFwTfiA2d+mtx1GBx4+0MOzoWJYH+XnWgkXZ+VNHlbQWgnom+5GAvy9mBsfNzkYP+mK2NJpopd6a39y5HHpyVlRpr0Z2yfRvnIIZHPwtOLx0BZ5pHaBOQ8QwV7PvVy5zGmIUDveOWjdUQYE5ypfJwZaanZs1gf8xn2ZmbP8xwsYVBKgIYjzQJw1SA1JxCnmlzmjckObmvILOnBL7PKg/nHZ3VuMJx0XpOIGbG2ohhCP08CDwybevq8qJtmgDgtAk+xCWe40bH2hZHCad7VOigHmTA55AtAJDi5xawUnxeOs+ti2KpjOiiOZ6YzS8b6FOK0RuynNjFk1JM4xMQ5qWYGRLBP9lZbOaqownN2y1HAUNgQp2aNA0kDM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8015.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(5660300002)(38070700005)(2906002)(55016003)(6916009)(33656002)(71200400001)(316002)(83380400001)(38100700002)(52536014)(66946007)(86362001)(186003)(9686003)(7696005)(6506007)(122000001)(508600001)(64756008)(66446008)(76116006)(66556008)(66476007)(8936002)(8676002)(26005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yJiGHobJX6Q5ttg1e97wItWZ/35xhICYyzPovn2opBhd1hn5vlxs0eBi2j?=
 =?iso-8859-1?Q?yYnmnhNkcRDw/CEnF8gjoV35iwdIAZ33vOPbwhHNz34cPDCtQzip1RC85s?=
 =?iso-8859-1?Q?kBWBBG5smFjEX8Y5tDdxDsf/tzz5gB4bn6oPPMT/bEuet0n+I23kc9cm6Y?=
 =?iso-8859-1?Q?rp3HuRyh6RAu0CzYaV4G1k9wjy0gYyd5a3T0RgssTKbspQWqdcnJDrsTL2?=
 =?iso-8859-1?Q?nmLpUJgGQbxjdh+nsUqxt92GTpiV1DqQtsNisiGvtlKCU8ebBCnO7VvG65?=
 =?iso-8859-1?Q?/mHC4a5m5z8DiUpBf7n36cT9AD/Mj+J20w9ubqY8va8OU/+na05MYT6JeP?=
 =?iso-8859-1?Q?IwiBv6UurgF+/EKsQbOOVqhk61n+wP9cSFow+tfPV4b+annnG1tRfaK7wk?=
 =?iso-8859-1?Q?nFLrb98UiaaosRJUWuLf87RyH+xictfGp7gxzmRC6+Kogxkay32MQEkVSi?=
 =?iso-8859-1?Q?ETGFGycX/+WVK+8FNxa57Bn6YXdN0tujnbuamIVPkr1JRzoZpYlRdeRP+M?=
 =?iso-8859-1?Q?8TqB3WyuFYmUjHGiYSIIIwOEOhQtRyg86QUsutg8pYIAeE0xDgEGDsi60k?=
 =?iso-8859-1?Q?x3OG/DI6+htFt38CQTaChOfHpmgilBZqHKiNNyx7IEKeHGDbl5f54x8x9s?=
 =?iso-8859-1?Q?RNlkS43JNM6Rs6iGNqqoY/gWzMgWHx7Cmo3TWKO53pGmfBHgcnpU7d/+LF?=
 =?iso-8859-1?Q?EoiLx91+6cOebvj5NOc8nAlZQ64JsNhWyDRQ7KxpxD/ToabMQ68kkhbzl8?=
 =?iso-8859-1?Q?7hFiSVuQvaqfRgc+hwfGsB/eVllYaidH6WL84OStRJfspWLCWTvB9KrdZR?=
 =?iso-8859-1?Q?6Dc5Jp+AzsMEk2LuBJdLwB5BKEywSqHFnLKrFUs/sG7J6biVe6xIaH5goW?=
 =?iso-8859-1?Q?8CyyV7UeMJ//41/ntrAWHGsam2PYPcYRH+ZMTvpi0IaRCO4+yFAqXaAewK?=
 =?iso-8859-1?Q?eaxBfYRxrxWzPx196/ajpjZD/I8hi6WJzPqruR3VuyFd4dgDYM1/NvpZCZ?=
 =?iso-8859-1?Q?JybY5Mbnrm3KgvoNEkUMJkYzQaHW1wT2Ie+Uo5YFRmbehkpL/PnTpdGEvs?=
 =?iso-8859-1?Q?40o1Fcdwcdk4x3bUjsOHd1uRV7YbiUTMn0ii8pnv2AeNHsfrr7t4xX/sID?=
 =?iso-8859-1?Q?tnPDxDZC1dqEodc9iMFBqoBnbGDblUyOYkV4kDce7K1KEaLWA/CzhdZqxp?=
 =?iso-8859-1?Q?hjLgCsJn5JtW4B5rE5eC1RXjGqNELS2PfRTB8gcJSGemn6UDLbGARv1kFe?=
 =?iso-8859-1?Q?KFMp0lBvbRw81+cEZI8BXUXhaop6jtiFGOYD/FEjXz0tOIjT3r53k4rLYG?=
 =?iso-8859-1?Q?tpm4RCwQ0BNrYpAwx1B8WXhQIPYzIogBAD8SM7pD9Y0gb/EGkT2qR0Dos4?=
 =?iso-8859-1?Q?YxgRYvKrEUN8KIrkmlQUDXMt+6yABxglbBambhjB5qHr1Hnt4IE4QSl1Hp?=
 =?iso-8859-1?Q?XEKPN7E64GU+4jkvgLtUWE/iR1FYvuAebU/RndJvjfsiFwGuTnUf73zHy9?=
 =?iso-8859-1?Q?sbtgy+vgfMPXpFScthtntoZM/Deidaap6oIm2zQYzIwpk9JCm8AJMSaxjN?=
 =?iso-8859-1?Q?v7+BJc0Od+hkSE2TVmN4R+KF4j5uhE9SSw50tSkgL7topYQwWy0buVXJCJ?=
 =?iso-8859-1?Q?IIldXFDwMGx8FomfqyyqZsE2HKFtnyf0CC0/8WsSt4iqNXhUGDHD+W68KZ?=
 =?iso-8859-1?Q?/55jl5Ym4qZ7+pSPuBvY52TQEjHxOce2HakTjfoHsBzocKUYP8Ax7YDx3V?=
 =?iso-8859-1?Q?JJag=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ADVANTEST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8015.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06e44b3-3716-4dc3-74d6-08d9e1ee5212
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 23:39:54.3638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b0de9dff-4833-4d4f-b442-1e0dbfae2ec8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwNPDuG/yJs1LkMKRaraUqWchrgs2E2fEfXjzRaZsQ+rEbvRes7SA8fpNYl7ytMaHZNMC2PpjuF74unETLNTIKP9KAD4XAhmKnqy/nMpqz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB8142
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The pmem.io blog lists directions to make block device from pmem with 'ndct=
l=A0create-namespace -v --type=3Dpmem=A0--mode=3Dfsdax'  Is it possible to =
use ndctl to create a block device from a CXL type 3 device with volatile m=
emory to so tools like fio can be used for testing?

Is the 5.16 or 5.17 kernel required or can the 5.15 kernel be used?

Is there another way to make a cxl block device?




