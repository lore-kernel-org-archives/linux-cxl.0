Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57644C7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 14:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjFHOfH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 10:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbjFHOe6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 10:34:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBE030D3
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 07:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=negakKIBVqdKelzyhANypS+XkrRAXZqLwrZc+Q8SFqU32GZTLJ8iBZ/kdO7ZeMtzFZ6GRqm2NlY06hftTx7bKBqYuxeNSewxA8JdT01/wx55KknPXtb04wvxiN79FnWlAM/V6S1n6K4ZVxPt6/tqR4x33C0tRgx4b+gY16V4BHDoP0AIu7PIIhCj82SfoG8r+bj2Er1nKu4vVnsibR/zbfXHaUeQkxkf7bM/wQ/WEJ725oYA7F34j7Rvs9gczCZePDklj0gTy7Uup6x2nce/NIyObxqGtXSv23tWdfmtDrZgHASEEO9y0tHRZMzG1tIaGEn4swAL8CWFG2C0o0+xKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWTgkQh6WxEYsJXBStjtIkVFbjeOSlAE3hRvOlVzEG4=;
 b=baUMCscPj1KYiMywqhDwgScYWPnEZoWCT7rB7RRGukhSkWVClqv9gMBCKIf1Uqg3+HZX0dGyNRS+SX7VBmGS0vv8xTUQIW0XkqkOQ3pqqaFtaYcu42NjJZMws5lCMiX1X4qMfARPP/ev0rM7F/Q8skosJ14TDfE8dAheBxNXEzsTVkwaFaj7TpomSYqoRJhOrZ8CvvdacToxDmzBNMiGwzaoMnU8j8dIfK2ZRPue+fgf53/qj0bGfllV7AH9geyG5SQRDyGhS3pPf0h0zX6kxLfWBiHKLA8P7zNl+pn0fbNb4fCmVPQ/NxqL5wDaCbDUdTHqd4u16nsC/t/a8DW+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWTgkQh6WxEYsJXBStjtIkVFbjeOSlAE3hRvOlVzEG4=;
 b=CPARSBCFtXzcGU/L4uc+foHVzuQ/TmX+EglF+nBizrbq3rCEz67qJw8aRB615vstKXDwb+yyaM07HkuvB6eofc7ZcqIiHYFPd6WNDaneQKt0/KMuajYAErxKV6JHhGSPIdLCkhmVv/nf2na8ySPBzhgEBusfuOLdN/hIQOGDHjjKDL1AtMVWf3ylw53AP0j7Qbr/3C7HruWZOTp2x7bU9chYZgyS+P7b68bBsdgziEdJXLfal1HaEynKhGPu+IfB+wvnQ3UR3mAOrDyRamBOlIc0yGKXB+iOSXIy7MSNV3s62ibtCTNCubSG7Gwf4J3XBxWYTvwTEfXMHjxxuw9DaA==
Received: from BYAPR12MB3336.namprd12.prod.outlook.com (2603:10b6:a03:d7::26)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 14:34:48 +0000
Received: from BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::561f:3221:5035:6fe1]) by BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::561f:3221:5035:6fe1%6]) with mapi id 15.20.6455.026; Thu, 8 Jun 2023
 14:34:48 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "navneet.singh@intel.com" <navneet.singh@intel.com>
Subject: RE: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator with
 local memory
Thread-Topic: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator with
 local memory
Thread-Index: AQHZlzz49tXfr2SrQ0OPZfE9JRiNBK9+it3QgAIz0ACAADyt8A==
Date:   Thu, 8 Jun 2023 14:34:48 +0000
Message-ID: <BYAPR12MB33364671B3FD0721174A3F49BD50A@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com>
        <BYAPR12MB333690E529D339194795EF50BD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
 <20230608114710.000058e8@Huawei.com>
In-Reply-To: <20230608114710.000058e8@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3336:EE_|IA1PR12MB7640:EE_
x-ms-office365-filtering-correlation-id: 26082489-4c83-4756-f27f-08db682d82ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: euyZrVRc1apu1twMl2drojD7vvMv7Bbl8fvOZqA2Kskbx+cybV5KFdWmrDwDcD9cT/lTv5LqjbkYCf2h/BN84GcDLmez5D4QWjKeX6cPM64PCbiyshePy2sfeIL7CEDF9Ov20fbAhofpP6600ZDLFgJAs9Kg+/Oz1AWiXQnIVjLxQT6WZSL/kFMwyVGHgD+0K0STqQM933T2hXrvuLRa3Ti6SUuHxeBC+DNq66QbDlWolDsIXvcBtLEbRs/eUBWOdABRkMJgCYiN5RRkkStYmYXeApztAfbalX70T2aHbhHMaoqg3l2m9VIraqS+t+2xQSTGTtB0NwFtZZkxHJUyD6tAzyA94Aj6L7JA7fjZE1SDhEaS5LeUH5vVpLGg/6RrsCv577jPsv8wfGlLElh4K37KW0AFcy7hqH6kDEDl12Yb+r+mirNJPyYYO9WXqsEneoH2fKIXTCKZsaUR66ygv0iHqqY290Hq3D5XP1u/ux8pmXLps3YEzcDPHDYdVm/o5rI2at9lwVVv7QuxaESwZMraTGMFOUU26a5JYIwCLxjBQWHkQNwDdAfCuSzx7l/RlcPNEsHQK6VbQ4an92rhdnw5ne1sxAjs5Q8H3cEsTOnRigqwP4sFIDWjZCrsJMjs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3336.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(66899021)(55016003)(83380400001)(26005)(186003)(41300700001)(52536014)(5660300002)(53546011)(9686003)(6506007)(33656002)(4326008)(66446008)(64756008)(71200400001)(66946007)(66476007)(76116006)(66556008)(8676002)(478600001)(8936002)(54906003)(86362001)(6916009)(2906002)(38070700005)(7696005)(316002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gpMxAYUBdb2nsc2hwrLWpR0AuoISnF3ZgrCftWju/oDEuwxcg3r3GRWHQ7uh?=
 =?us-ascii?Q?mfn4qRCSzFbFuGDOl7IaSLSefQT5yhrjFymnD7UVEBuHcI7kKPOiK5LGAJs/?=
 =?us-ascii?Q?/3JwyR8UkX+2wG9MbIvMo10BEGyU68M9zCW3ctk32pNZq6sdA6jswU+ftLAl?=
 =?us-ascii?Q?OwQ9U/s67FGnudcnf6cL7iMtHYlymRMRiDJgl9EFkUPzkbTDI6DWkBkP7U1M?=
 =?us-ascii?Q?S87SJ0Q+fNdJyWxxmscrNRZOS5ua7oxbnnkX/zYj/qxf0XMc4VR+J/CxWHoA?=
 =?us-ascii?Q?6bEmw8+sG/XiADL7nUPH3fp2h8jMMZjWTnICpeQL1xju6oht1A7UR7/4naW5?=
 =?us-ascii?Q?tSGBq8xO0rmiPSQDMPTI6QtiEE5F9xE9ZzHCxmDcxlShVx9enVe+8SeQ66Mn?=
 =?us-ascii?Q?9zD259EK29r4bGI3PC16hcLoMNgQNYiMZNop1ar7lN/acYToxixOM62f2Kxw?=
 =?us-ascii?Q?dDZUH3bpSkFvhPMY7drzK8xxyJiboGSb7NwRHo6fQmh9jAjcyhKZhbqRp0Ts?=
 =?us-ascii?Q?6hoIucrFXHuhtHSvilWUBRUQSCOlhrTc7rGSJM0/DANybHH4axdLjWi6IeNt?=
 =?us-ascii?Q?d0GqF0wCcy3EmEnfz50uGPg8+csMKYYoKEnIuzERZMsSA5TdACz8PlBnbalV?=
 =?us-ascii?Q?TPx+5F8nMySh9Yvt8i8N5w+s2QLdR/zBzCuhmrqLNQk0n38nAJAWD9RzCsFi?=
 =?us-ascii?Q?C61ScTBzikTZeS/kZQC5gg44AHuYT+fuNe881P27YX7O/x+nqdNeqzKpEYp0?=
 =?us-ascii?Q?szwdQv92UfIBiAo49UqmdhqEci3OhXnPY4q4gsib6sJJqZq7LV5ADgkUbSNg?=
 =?us-ascii?Q?1L0dXuYuNcUglY9+cHd5OnnRMh2kMNJRA1CaLv/MpgAYvTk8eEw80ZwJh4Q3?=
 =?us-ascii?Q?LrrJXsNLTeH206J/LChLIik24cvBuihkZzxumzYPSogczk+QCmKafOdWlKXi?=
 =?us-ascii?Q?GvH4XeKgBMkWILTDljhzBMEwEtALGMXFz3v6lDGr6SOQ4yAlo/UZ9Mu6+f6j?=
 =?us-ascii?Q?CYAagbhZK6uVbDG1LFYTRWovikwbgRoaIW4II1+y5j4b5SYMJ7Hx+9oF3EtY?=
 =?us-ascii?Q?N0EzDw3V5FJf7HmgboAdzOGa/J+piB6PLPR2ThN4k91f0hERSfwdcG3GJTi6?=
 =?us-ascii?Q?NgjfQNNlZlx5SDDtterif5GRCP1rlstM3+mtVVA0YMDZWzlE/TkbHuvqOzfS?=
 =?us-ascii?Q?aVLtTUmVfOkBBk3EKo/Nw941R+wHtX9hfR4Wq3iACKn8EwOmjF0hU/SvFNgf?=
 =?us-ascii?Q?Ol5NwZD6wmtjUcWV4yivTZbJ8e3K4085VgcFXtZraYwiS9kjSTw1yMakKKz2?=
 =?us-ascii?Q?E3swtIn2QKgo8nN9sekt/s57p1PcefomWAthgtLLMqkC12gRJuTG2UkWaTNb?=
 =?us-ascii?Q?xIYrGJ80kPNUqrj827FvC2UuTxAvIQL6yyCIY8Ey+neqUzl92+pTRxaGV8x5?=
 =?us-ascii?Q?iVQzyidC4ClnErpCBBb4IKxBOxQ5Jx8RuKlW/Aeew9LR0mflpT8uYzMi+UT7?=
 =?us-ascii?Q?ZIZl974nT6s/OWDy1NY3vyUle5WZjc3hSHzf4t46cv27Wk9lVfRsIA4f3aPj?=
 =?us-ascii?Q?4t9z6YZOSV6lMbIm6Dk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26082489-4c83-4756-f27f-08db682d82ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:34:48.3173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mmjxl0WZaqaHkIBSU4izguaTwxcsLPZ9kyASulTX0gr/PHxiiXXSNtYFEjIl8aBZ4rIGIPWyhUJhz2vXXPOStg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Thursday, June 8, 2023 5:47 AM
> To: Vikram Sethi <vsethi@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>; linux-cxl@vger.kernel.org;
> ira.weiny@intel.com; navneet.singh@intel.com
> Subject: Re: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator w=
ith
> local memory
> On Wed, 7 Jun 2023 21:09:21 +0000
> Vikram Sethi <vsethi@nvidia.com> wrote:
>=20
> > Thanks for posting this Dan.
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > Sent: Sunday, June 4, 2023 6:33 PM
> > > To: linux-cxl@vger.kernel.org
> > > Cc: ira.weiny@intel.com; navneet.singh@intel.com
> > > Subject: [PATCH 19/19] tools/testing/cxl: Emulate a CXL accelerator
> > > with local memory
> > >
> > > Mock-up a device that does not have a standard mailbox, i.e. a
> > > device that does not implement the CXL memory-device class code, but
> > > wants to map "device" memory (aka Type-2, aka HDM-D[B], aka
> accelerator memory).
> > >
> > > +
> > > +       cxlrd =3D cxl_hpa_freespace(endpoint, &endpoint->host_bridge,=
 1,
> > > +                                 CXL_DECODER_F_RAM | CXL_DECODER_F_T=
YPE2,
> > > +                                 &max);
> > > +
> >
>=20
> > IIUC, finding free HPA space is for the case where the platform FW has
> > not already allocated it and initialized the HDM ranges in the device
> > decoders, correct? If the accelerator driver recognized that FW had
> > initialized its HPA ranges in the device decoders (without
> > committing/locking the decoders), could it skip the cxl_hpa_freespace
> > call? It would seem reasonable for FW to init the decoder but not
> > commit/lock it.
>=20
> I'd find it a bit odd if firmware did a partial job...
> Why do you think it might?  To pass a hint to the kernel?
>=20
Firmware could certainly initialize, commit, and lock the decoder for accel=
erators that are soldered on the motherboard.=20
I just wasn't sure if the CXL core code could deal with a committed and loc=
ked decoder.=20
I was also thinking about chiplets within a package with new specifications=
 like UCIe where it is possible that chip designers
assigned a fixed HPA range in the chip address map to a CXL device chiplet'=
s HDM. Would it be sufficient for FW to convey this by committing and
locking the decoders, or would we need some new ACPI flags telling the kern=
el that this device's decoders can really decode a fixed HPA range and not =
to change the fixed values?
A similar notion exists in PCIe of fixed BARs called enhanced allocation wi=
th hardwired addresses.

>=20
> >
> > > +       if (IS_ERR(cxlrd)) {
> > > +               rc =3D PTR_ERR(cxlrd);
> > > +               goto out;
> > > +       }
> > > +
> > > +       cxled =3D cxl_request_dpa(endpoint, CXL_DECODER_RAM, 0, max);
> > > +       if (IS_ERR(cxled)) {
> > > +               rc =3D PTR_ERR(cxled);
> > > +               goto out_cxlrd;
> > > +       }
> > > +
> > > +       /* A real driver would do something with the returned region =
*/
> > > +       rc =3D PTR_ERR_OR_ZERO(cxl_create_region(cxlrd, &cxled, 1));
> >
>=20
> > Assuming the accelerator driver wanted to add some, or all of its
> > coherent memory to the kernel MM via add_memory_driver_managed, I
> > think it would get the HPA ranges from the decoder's hpa_range field.
> > But that API also needs a node ID. If the FW ACPI tables had shown the
> > accelerator Generic Initiator Affinity structure, then I believe the
> > accelerator's device struct should already have its numa node, and the
> > same could be passed to add_memory_driver_managed. Does that sound
> > right, or is there a better way to ensure the accelerator memory gets
> > a distinct NUMA node?
>=20
> If it has a GI node assigned I agree that probably makes sense.
> There might be some fiddly corners where it doesn't but they are probably
> the exception (multiple memory types, or different access characteristics=
,
> need to represent some other topology complexities)
>=20
>=20
> > If the ACPI tables had not shown
> > the device as a generic initiator, is there any notion of the cxl
> > memory device structs having a new/distinct NUMA node for the memory
> > device, or would it just be pointing to the NUMA node of the
> > associated CPU socket which has the host bridge or a default 0 NUMA
> > node?
>=20
> I'll leave this one for others (mostly :). I personally think current mod=
el is too
> simplistic and we need to bite the bullet and work out how to do full dyn=
amic
> numa node creation rather that using some preallocated ones.
>=20
> >
> > > +
> > > +       put_device(cxled_dev(cxled));
> > > +out_cxlrd:
> > > +       put_device(cxlrd_dev(cxlrd));
> > > +out:
> > > +       cxl_release_endpoint(cxlmd, endpoint);
> > > +
> > > +       return rc;
> > > +}
> > > +
> > > +static int cxl_mock_mem_probe(struct platform_device *pdev) {
> > > +       if (is_type2(pdev))
> > > +               return cxl_mock_type2_probe(pdev);
> > > +       return __cxl_mock_mem_probe(pdev); }
> > > +
> > >  static ssize_t security_lock_show(struct device *dev,
> > >                                   struct device_attribute *attr,
> > > char *buf)  { @@ -1316,7
> > > +1395,7 @@ ATTRIBUTE_GROUPS(cxl_mock_mem);
> > >
> > >  static const struct platform_device_id cxl_mock_mem_ids[] =3D {
> > >         { .name =3D "cxl_mem", 0 },
> > > -       { .name =3D "cxl_rcd", 1 },
> > > +       { .name =3D "cxl_rcd", CXL_MOCKMEM_RCD | CXL_MOCKMEM_TYPE2
> },
> > >         { },
> > >  };
> > >  MODULE_DEVICE_TABLE(platform, cxl_mock_mem_ids);
> >

