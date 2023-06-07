Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99023C7EE29
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Jun 2023 01:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbjFGBHP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 21:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjFGBHM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 21:07:12 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40909124
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 18:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT2yk/Ea1XYDwAEEyq/Cqg/OVwBS+2RJB0D58tecjp7nYsoxLwPR7gZiP/sX3oZtT81HU+/vjcoELRo/xhuFdHOuf2115Bo1SBZeAQthhMs8a3x4wrsaEfgAwJYJvAyE9sbvQzBBNMi5+os3YkqagmXih8PgoZQ2/aMP2Rs2c4Q6kZj43ToTq63LHRuC8SbRUA+n2wMTZqgZ4RjfhEOstAlUVDrgjETQrZrWuAY6Lz4vs09mL+TCU7ckDJhBhBZfBpy0SgPFSyr8JSQuWpFoLI48qqv9hQnqEkFVyWI5MKRIhC6gyiDYKuZ5I1o0T2ASqMa2gx5zfUn4ynWNKrmvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng6zCDO1++qeh/Ff0ePYOWTkEHDu3MaZBePXBDGm53A=;
 b=DO8Nz/Ng6kWySi7ylQyvT0hPJOAquRrHwJQNpw1Ml14tnyc/Qu5LehHkgYdXTEYk7hYS7E4Yv/i83fzAR5dZyjiEdZBpNbjDR7unmieKFewH96f3+8+SLQIigS74xBMxYvgXwEqvaH2RDrE72R6wm+i6QepCQV3LeDe0UFw1FCcd2gWxwf0nrjhqTJUJDnzlsk6F7yTBKS5LC2oThMldASWf1iiVptXyeFpOSjeATvrRSy+WopAsQS0+Zrd/LYRejVINe95PROUJsrnnWxDYQixpwMMQZJ7Pnc+UkPPp8Ejx8ipMFRwM6PY8iNwAl2NmRhwvPnCFnv1fjBbdMZcqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng6zCDO1++qeh/Ff0ePYOWTkEHDu3MaZBePXBDGm53A=;
 b=k4L6FaP4xVAluI8WHdodQ0MaaDxswPPGYf7aMWPHwnvDfV3/KCabuWMJ4z4F+xbbP38+tDmKvzyTctBz7R2B2By/io8dkD2c+GWuQ8/wPC4b6/X3hBnz+Xy/KtGXJy6UWd7sQg3hVsal3s6Jsr7djlkq2Sl/+7gV5k0u4BU8gpD/5eUuiGR1PknwGgJeZhbchCBGd8CIpbAqKheRRAUw+TV2zHXFGHysI1P/vjlF3HwwHiFGXB+p8mf3Icy2ROuS605q8jTLl34azEo30Jo7l2Vh+GQIGkHV5en08RKZOnLybVzf3TwNvcAnUKt4rzgEKKgi8af6fww6InVAiJYFEA==
Received: from BYAPR12MB3336.namprd12.prod.outlook.com (2603:10b6:a03:d7::26)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 01:06:06 +0000
Received: from BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::561f:3221:5035:6fe1]) by BYAPR12MB3336.namprd12.prod.outlook.com
 ([fe80::561f:3221:5035:6fe1%6]) with mapi id 15.20.6455.026; Wed, 7 Jun 2023
 01:06:05 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>
CC:     "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAABux4lAACwZegAALAMJgAAimUgAAFkB6UAAN+iiAATwrJ1ABULeTAAAISasA
Date:   Wed, 7 Jun 2023 01:06:05 +0000
Message-ID: <BYAPR12MB3336E224E4B3DD50ABDA04B6BD53A@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB3336AB6A519C709DBEA75CB5BD419@BYAPR12MB3336.namprd12.prod.outlook.com>
 <646d8c76811cb_250e29456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <BN8PR12MB3330831F2E666E9BB1319E66BD419@BN8PR12MB3330.namprd12.prod.outlook.com>
 <646e7f96f33e2_33fb3294c1@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB3336F5ADDEDBB6245BC2B48DBD489@BYAPR12MB3336.namprd12.prod.outlook.com>
 <647f9d082eb30_142af82944e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <647f9d082eb30_142af82944e@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3336:EE_|LV3PR12MB9185:EE_
x-ms-office365-filtering-correlation-id: 0d296b04-a47c-4313-81ba-08db66f35ee1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NWxZHrH9ItHeyOUCLplJVQEb0wsMcCDuPtaRrIZFLkLlVzSLOnSMmdSzP3IkhAMYRdxz6zkZSzmkugWqtw5sSSwqta3eCZtVDZwEqtE44okf9y2TxROI3Q+KYu+5yJqnSGZzSrw7UOvmFwMDOFUm6QkfPXgMICu/OfDSZI/6gM7CkmDRNjnS2EnuPJ+LRPu+ldJM9LpXZ4XRYB0Ee+XZJ5iRY/CuuAawmVRxiW9+OhxQy8BZx1nOCX/3lJ7vUs/CXl2INOf/pniIgZ/IyEDvSKdJDLgqC6ysz1KqBQs1vOLq58hNzozGs/txCHeifmYaPGsjw4e8k76NcFHlGp1QwO9jpfCKe/MROZiu4ifG/yjPoOntBTHgDS+MT9q0DST+fNNXRklo477ZIQkZrQAThMN8gS8HNp2Y38TUs73DcIBdEbXOqFRtoGKOLirMJbwb2UA1bbe3uDJ4e+xQBlWdjfR/k8+1lUFEMib/A71YaoC2dlOcNNbTbq9XB+J8h5b/WCaGfJF2Jt6ZvJ/vuUUV8ENiSGVkpbIjLb4vudgu7W+hkJ1gXQpKg8e/GXoIxl22CLPfQFlrnoBjUOvMDvU4qGKTHP5gkwXwq8JeyYl+qWJB8TTBcehAZ3We2XR0T4fg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3336.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(55016003)(7696005)(110136005)(478600001)(316002)(8676002)(8936002)(41300700001)(66446008)(76116006)(64756008)(38100700002)(66946007)(4326008)(66476007)(122000001)(66556008)(186003)(71200400001)(83380400001)(26005)(6506007)(53546011)(9686003)(86362001)(52536014)(5660300002)(38070700005)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gzyIn2Q4qCVHBHXmKCTlryWzhPS97E2h2IZgqoPDcK1lkvcXkTiu3AjuCO2u?=
 =?us-ascii?Q?DvdPrABcpyki1IECB/kavF76Q/ZOUlX4gmWVpQrQhiVyc688bXyxC823mcy8?=
 =?us-ascii?Q?x9/3OIwhBzPohfV4UfpKVEzNPlzB33PjU7Q5gxdUK+VJOuFLCamh05cFEuem?=
 =?us-ascii?Q?Gh6k86yfdwyl8ypQtIcrJBwk8Zuw7IyIqRnLl9e/ij0beti5Sw2CkUb5b6Kt?=
 =?us-ascii?Q?1yfj8xyoss+O1VuDmFunx7XILruRXnT2ctSdT7PLcU012LiqCf++QcerqGfe?=
 =?us-ascii?Q?YC4SocP2lYYBE6byIQdEAggbzOr9xA/FWN683BKS16EC1kPmP/RMXbAXDQZ+?=
 =?us-ascii?Q?WY3K0Z2IVsgBindYjKyl/wXlUNNj3L5EYyB7i1pif6YWf6uqMLATM2F4rhuL?=
 =?us-ascii?Q?GJCJVnTO38cJKuCnCBsI770SYU+D3JsAoaDJtQtRXhlFs+PhZOT9vlbPLIJP?=
 =?us-ascii?Q?6xA6r2ufiLCynJ6jdgJV9/sjzTvTV7Ns3RAxf4DVVegnXs40WHRVxEMxdr67?=
 =?us-ascii?Q?BeuAzH9nqSgEMow303CEXOxT42sjC98n2M5jMiY/8ZckwJpRCBWT5c3gWnWm?=
 =?us-ascii?Q?70C95SZkmWxAMi2ej8XvqnzTYaXxLsR06jamJEdJcFp5ALU2uqUNabxDkz/1?=
 =?us-ascii?Q?axQ84AMo9C842i53ZNO1n+MOLNBC+VQ8B7vwwslgWjfRwdDWZr3r4B6GIr4N?=
 =?us-ascii?Q?Gt0YTewzIhGfFpx1WDa89Ve77w/lX2LNuf01WUNHY8VEYLz0PXJTmenFJkO9?=
 =?us-ascii?Q?oGzwXP7kp8GYos+0bNHDM9y8GMjmHDjF5927oAInZ1+IqObySusocPYrC786?=
 =?us-ascii?Q?E1B/800Wx+uzdZ9xMr2JZmK0dmjkovZNqEIKlNyz5UprTZy3JWtqLSbOrPzx?=
 =?us-ascii?Q?dTXxKG3dRTG55YIbT00EH1iUFCkPimwZHuFn4m3qZZZ5XnPyShnw7AicPpy4?=
 =?us-ascii?Q?OkyLomJuvqSKRq1OqIYGnTg2zBJ8S1FaCAOYaXc3slJFK6VBA9xVI7hJYYex?=
 =?us-ascii?Q?jz7+ww4XqF7s9BUa8UksWEe981tEXnm0qr5hZIwP+fVoZQ1ba+Jfp2wza+Yv?=
 =?us-ascii?Q?GJEj7OlFYbLvagTZqOuho3Ht7BEuljv6djs+zdLi7TjFrMReJcakR5WPu43l?=
 =?us-ascii?Q?EMUpuaXvMegC8rl14SvodxxHLiziChEdnyKgR7SHKJMJ1oTR6Q8g3g1BVLgY?=
 =?us-ascii?Q?KBq/TrHPjohA8E/+zrA9WeTcaAg8QhwwBrhmgUkWiMiZcIe4jZYhw4TqlpJj?=
 =?us-ascii?Q?T8SxUjv5WSc6BpR9synj/8VRkFHF844RIsN7Mw+hn3JZGpHoAqJM7n930ZfX?=
 =?us-ascii?Q?Ha5ToA4xgX8xtcHqBVvbm7VbsGoVNSnpPu3jy+cA5zyIGlcKZkKyifTKiIge?=
 =?us-ascii?Q?xorzoFs7I0db6jLV5MeoyXpiDQ1FLOZ3UqSq8SOxYa0IZ+OZ6Gdwh+7glPHB?=
 =?us-ascii?Q?coTQeg7JzeAoAd2Vup/fIwOjoqIHXNKDoP9TTKyQLeBrrGfqg4D2z5vet2tY?=
 =?us-ascii?Q?txz2OsunlPOUvx3y5vwKMMOhkKwSd7cASFpK36CoC8yqYhraHNRrmsL7y1J6?=
 =?us-ascii?Q?JMhycIB723LnDzVSQNM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d296b04-a47c-4313-81ba-08db66f35ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 01:06:05.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: objq2+IqJ3sD7r02engqYEvGI/XuJJyYIi5PJoC4/e9uvOEXqikeOgGvCBQ8yykdPPiZbdNJ9E+LN6WKlOCLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Tuesday, June 6, 2023 3:55 PM
> To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>=
;
> linux-cxl@vger.kernel.org; catalin.marinas@arm.com; James Morse
> <james.morse@arm.com>
> Cc: Natu, Mahesh <mahesh.natu@intel.com>
> Subject: RE: Questions about CXL device (type 3 memory) hotplug
> Vikram Sethi wrote:
> > Hi Dan,
> > Apologies for the delayed response, was out for a few days.
> >
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > Sent: Wednesday, May 24, 2023 4:20 PM
> > > To: Vikram Sethi <vsethi@nvidia.com>; Dan Williams
> > > <dan.j.williams@intel.com>; Yasunori Gotou (Fujitsu)
> > > <y-goto@fujitsu.com>; linux-cxl@vger.kernel.org;
> > > catalin.marinas@arm.com; James Morse <james.morse@arm.com>
> > > Cc: Natu, Mahesh <mahesh.natu@intel.com>
> > > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > > Vikram Sethi wrote:
> > > [..]
> > > > > I don't understand this failure mode. Accelerator is added,
> > > > > driver sets up an HDM decode range and triggers CPU cache
> > > > > invalidation before mapping the memory into page tables.
> > > > > Wouldn't the device, upon receiving an invalidation request,
> > > > > just snoop its caches and say
> > > "nothing for me to do"?
> > > >
> > > > Device's snoop filter is in a clean reset/power on state. It is
> > > > not tracking anything checked out by the host CPU/peer.  If it
> > > > starts receiving writebacks or even CleanEvicts for its memory,
> > >
> > > CleanEvict is a device-to-host request. We are talking about
> > > host-to-device requests which is only SnpData, SnpInv, and SnpCur,
> right?
> > >
> > I was referring to MemClnEvct which is a Host request to device (M2S
> > req) as captured in table C-3 of the latest specification
>=20
> Ok, thanks for that clarification.
>=20
> >
> > > > looks like an unexpected coherency message and i Know of at least
> > > > one implementation that triggers an error interrupt in response. I
> > > > don't know of a statement In the specification that this is
> > > > expected and implementations should ignore. If there is such a
> > > > statement, could you please point me to it?
> > >
> > > All the specification says (CXL 3.0 3.2.4.4 Host to Device Requests)
> > > is what to do *if* the device is holding that cacheline.
> > >
> > > If a device fails when it gets one of those requests when it does
> > > not hold a line then how can this work in the nominal case of the
> > > device not owning any random cacheline?
> >
> > I didn't understand. The line in question is owned by the device (it
> > is device memory). The device has just been CXL reset or powered up
> > and its snoop filter isn't tracking ANY of its lines as checked out by
> > the host. The host tells the device it is dropping a line that the
> > host had checked out (MemClnEvct) but per the device the host never
> > checked anything out. Seems perfectly reasonable for the device to
> > think it is an incorrect coherency message and flag an error. What is
> > the nominal case that you think is broken?
>=20
> The case I was considering was a broadcast / anonymous invalidation event=
,
> but now I see that MemClnEvct implies that the line was previously in the
> Shared / Exclusive state, so now I see your point. The host will not send
> MemClnEvct in the scenario I was envisioning.
>=20
> > >
> > > > Remove memory needs a cache flush IMO, in a way that prevents
> > > > speculative fetches.  This can be done in kernel with uncacheable
> > > > mappings alone, if possible in the arch callback, or via FW call.
> > >
> > > That assumes that the kernel owns all mappings. I worry about
> > > mappings that the kernel cannot see like x86 SMM. That's why it's
> > > currently an invalidate before next usage, but I am not opposed to
> > > also flushing on remove if the current solution is causing device-fai=
lures in
> practice.
> > >
> > > Can you confirm that the current kernel arrangement is causing
> > > failures in practice, or is this a theoretical concern? ...and if it
> > > is happening in practice do you have the example patch that fixes it?
> > Yes, it is causing error interrupts from the device around device
> > reset if the host caches are not flushed before the reset.  It is
> > currently being worked around via ACPI magic for the cache flush then
> > reset, but kernel aware handling of the flush seems more appropriate
> > for both hot plug and CXL reset (whether via direct flush or via FW
> > calls from arch callbacks).
>=20
> Makes sense, and yikes "ACPI magic". My concern though as you note above
> is the cache line immediately going back to the "Shared" state from
> speculation before the HDM decoder space is shutdown. It seems it would
> only be safe to invalidate sometime *after* all of the page tables and HD=
M
> decode has been torn down, and suppress any errors that result from
> unaccepted writes.

I agree regarding cache flush after page table mappings removed, but not su=
re that HDM decode tear down is a requirement to prevent speculation.=20
Are there architectures that can speculate to arbitrary PA without any PTE =
mappings to those PA?
Would cxl_region_decode_reset be guaranteed to not have any page table mapp=
ings to the region and be a suitable place to also flush for a CXL reset ty=
pe scenario?
>=20
> I.e. would something like this solve the immediate problem? Or does the
> architecture need to have the address range mapped into tables and decode
> operational for the flush to succeed?

The specific implementation does not require page table mappings to flush c=
aches. I'm not sure that simply suppressing error interrupts for any writeb=
acks or MemCleanEvict that happen after a device insertion/reset is good en=
ough as devices could view that as a coherency error.=20
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c index
> 543c4499379e..60d1b5ecf936 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -187,6 +187,15 @@ static int cxl_region_decode_commit(struct
> cxl_region *cxlr)
>         struct cxl_region_params *p =3D &cxlr->params;
>         int i, rc =3D 0;
>=20
> +       /*
> +        * Before the new region goes active, and while the physical addr=
ess
> +        * range is not mapped in any page tables invalidate any previous=
 cached
> +        * lines in this physical address range.
> +        */
> +       rc =3D cxl_region_invalidate_memregion(cxlr);
> +       if (rc)
> +               return rc;
> +
>         for (i =3D 0; i < p->nr_targets; i++) {
>                 struct cxl_endpoint_decoder *cxled =3D p->targets[i];
>                 struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled); @@ -=
3158,8
> +3167,6 @@ static int cxl_region_probe(struct device *dev)
>                 goto out;
>         }
>=20
> -       rc =3D cxl_region_invalidate_memregion(cxlr);
> -
>         /*
>          * From this point on any path that changes the region's state aw=
ay from
>          * CXL_CONFIG_COMMIT is also responsible for releasing the driver=
.
>=20

