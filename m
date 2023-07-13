Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61735EB64DD
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 12:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjGMMzH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjGMMzG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 08:55:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26188199E
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689252904; x=1720788904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AolYHkj+uURSxTtlOXhV6bQyvDIUxemstL/nXOEL0as=;
  b=NGtYtKjPu9Z7Hh6fjpPE040krykDOtFHjdVTKnYfdJxsw/L0aMcdqVNZ
   nRqzvnNOxjb+Vj/FKXsYWjadyFju6UrjcUAowpnXyfKiZgL4yyRLzkH9Y
   wzSvjBhkYEplqNWIchWBZ6PrsPbXKcjfLcg48y7xRd53uWfhhpS9WH5g5
   uFkh2jHQhQEXImuNIBQIW7crLeh9Vtb23JcGhY4s4ajdK36rd3zTfV7To
   jO6cDnFZSpZMEPJZa2HLDZpPjqRAzH62SUtdCOZX70p1z7muG8GO3FZ8z
   uLE28TW5ir2C8xXvGCMaGdQ6O1I8cxG/+jU09vfM0OINGaodss8x0ujf3
   A==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684771200"; 
   d="scan'208";a="242614597"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2023 20:55:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsOqWnguSVufyTnMqK5BbMml5G6iUe9+NHhb1J18vxTXGrl8ZP2pI2UG1jwWidWmEf5A9lCz5mWLwhzzaG4jdyVGiGze1tJ9TAARDN8QpMj6LwuD2jkwg/yOOUEk9Qm2LR5ZB6gvlaqHU5NfQP/TllMfWfZ7efakMhRuUbsip6oBQ6qnYNvd7Z4G9OaBZ29RT0U8lVquU87hpgqdJfAJxmtS7/JY4cGA6i6uzeoltAcaRm6X8Lnl+ZnXDHwm8aL6Bk2sr9JV8QfjQ3tFyhwtUhoR0FDlTAmRGvGtyp8cHdMoR8E/S8l8TwDfV8deDT+4Rh+sRDRQgPgNTD9iBaffNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3CXeT8ypPOYuIKvKwFZuz50/wdLUmzviE4bfSyB4jk=;
 b=ceCxxC2t1f5/GQtF4KEtWrnct45n6PLIV5KrGNtCED1jFvyFPYSC2gWZ70zAWS6gg08Dp5ClAqmSCW28BblU+hymnpJNbuz7AWQaFUSHccM51egzteY8MU9kx6eWiTUhnD4kffncnjdApztHk4Ej++/aTVGZUkRLdqqo4r9wNnZAPcERPzhv/yUul3EgcmeqmnCBgiBAGdI/ThY4yAZK0xhEYP1J1wjgmDeqY70XlXP0h9vEjC8nQmUs5lOKCuYoo4hE/S0y9TMZXuaVg2jh72WzZq4Cv+9gFDFMXA/Jty92Khf4nw5Nm32UUzdBbx2g6aCNG1X5R3BOWEflPV1Jeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3CXeT8ypPOYuIKvKwFZuz50/wdLUmzviE4bfSyB4jk=;
 b=n8n8UaMOIVKy3ehGk/+wg01ADGJXZ8LwsGLOGmWVZz4OGRAYXBUjPjRC4dQ2oUwvDDefN20OOkhF6cErFh9bTLyhZgArzO7beY45K5YKvEY4ahMqrObeoS72ShXDfciead2KI+Xa1qZPlc93sIyucxxY7oIDRz3W4menQcPu7+M=
Received: from DM5PR0401MB3574.namprd04.prod.outlook.com (2603:10b6:4:7d::22)
 by MW4PR04MB7155.namprd04.prod.outlook.com (2603:10b6:303:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 12:55:02 +0000
Received: from DM5PR0401MB3574.namprd04.prod.outlook.com
 ([fe80::786c:6d23:6624:ee51]) by DM5PR0401MB3574.namprd04.prod.outlook.com
 ([fe80::786c:6d23:6624:ee51%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 12:55:02 +0000
From:   =?iso-8859-1?Q?J=F8rgen_Hansen?= <Jorgen.Hansen@wdc.com>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/mem: Add support to handle DCD add and release
 capacity events.
Thread-Topic: [PATCH 4/5] cxl/mem: Add support to handle DCD add and release
 capacity events.
Thread-Index: AQHZnvU8Jt8cbaJX3kqKdWQ2KjCDlK+31IuA
Date:   Thu, 13 Jul 2023 12:55:01 +0000
Message-ID: <0B672FBD-3026-4A62-88CE-D7C9EE6E036F@wdc.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-4-71b6341bae54@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-4-71b6341bae54@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR0401MB3574:EE_|MW4PR04MB7155:EE_
x-ms-office365-filtering-correlation-id: c613cfa3-bd84-4022-9d99-08db83a05f24
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Zt4KEXUzEFvT5j8i7COchbrsJXbsntmuXji7DkianFtgun05tr+FMlsviznlPxZB8dvThcv3YeOgss/vcg0E2qP8NfgjANEUUPcS0cqn2WzvfhRLvXRKYAHefZqj/RIRRuPXZhaSEWg9hXXDwD80D0bpBTWTnSjTXxETZsd96pV6O51nF/ho6qerV0qtGzqC0Pi/GgoxwgC9kcZkufOIITcivuYcgXWjzjTniL8eXFvx2OqvpeYF/CVQl5QXQZy01H7qM8SNTcunEjLlHGSGZGTWbct/1gKUGtT/H8Eev/OdOKD2trWbVa6OcSfeVQKthme4dqQGi1Y8OaZ0/CNxLlSL12xcd8BuPIwJ9E+FOSM/QSO4kpVlryO8D+HtaUqi9kx5K0xgU6Umm8Xwo9/rdZrGFLdYybCDlzC/CUNqrek615xYKflHVVp17J9jHjs/Jn6Eq83AZ/ko3u4p70Cvc03e/V4y5OAobNltGYURdnvLO5hBtpTCsQkhsgcDVVVuknBdFynbHH3s2FIVW+nnNZ0f1LaiG5kz6vXqEMhqo0+826Rc4txW19Gj344xslj+x7f4MS8fXgY0lLhyL6vqCxmBilw1rubbWF7K3g3zodw1Jt+JfmzsK244t8u2jZ3yRiRtf084ZOTW+KnxDyK8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3574.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(38100700002)(122000001)(82960400001)(86362001)(36756003)(33656002)(38070700005)(8936002)(26005)(5660300002)(6506007)(54906003)(8676002)(41300700001)(186003)(2906002)(2616005)(83380400001)(316002)(6512007)(66556008)(66946007)(91956017)(76116006)(71200400001)(4326008)(478600001)(66476007)(66446008)(64756008)(6486002)(6916009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KsSao3N2dl74Q65xD66PSOEzXmwAQuvu54jUOb+chU6/34iIfmHCdo/B4O?=
 =?iso-8859-1?Q?4FXiVkKCrvzR+PWGtk2HyNi+JWkRz3vORj8Q45TyG1lv7YCarjfS4cLbIL?=
 =?iso-8859-1?Q?N1/JYHI0hclyReE3kRsKb37sqvoirHkWnASYKrsPEo/2DXI5OCjqf327VC?=
 =?iso-8859-1?Q?lSrNhdWrKKpCu0wMefunKIma7Mpxesj9qR0De4SuiDI31g9t8+8Azz3EBp?=
 =?iso-8859-1?Q?TpQqXMsE8tx/ipvk3xrIHw05liPmk8HqwY4c+/mLbkog09d6OwzwuyduYD?=
 =?iso-8859-1?Q?U4rXXbNhtp3LDKDhVRVKlO3eosQN3o85beKlPsfQCZDRHGu13307b3AsZn?=
 =?iso-8859-1?Q?f4LVXOKz+PTpVlfv83yJgoldadh1syr1TNk76KF4EFdWr3Fq1yI1Rrvid4?=
 =?iso-8859-1?Q?PDDfImgIFFvLZpLKOTkBWuiiQ0jTyW3vRyCRPATf5+2nAXHsmhBfZ/tW7T?=
 =?iso-8859-1?Q?M/vmwn/SoBxRWIRVxCvSS9RuP12g/1VQW/qhD/2+CtFMFIkLP22R/JLlaO?=
 =?iso-8859-1?Q?k7cdzCSYactM1F1oT1c7Lrn22gKyOqH9osEqQHRX6yU5TS+P1R9+VrqcvK?=
 =?iso-8859-1?Q?mINl1e1ZUSFgBWwLIKGvVlQYX7MVIAG7FRjZPqimIKMSbibH7OQaOhk8iQ?=
 =?iso-8859-1?Q?bkaA0TBQHgQa/7HfjAB2A1Nh4SFQZeeIhz+INuHRjfRc+JeqvXlvgFQ1Dp?=
 =?iso-8859-1?Q?IWGdBFNuf0DC63RE4YmFYScEckWvDP4GO4fyrSIC73xv+H9FDbkP0QktB9?=
 =?iso-8859-1?Q?GkL/DOcwYPICIb4UsVDuJ4fWJ1SA+DjsbTV0oYfEiWrrlEGrJ/avIzk1IL?=
 =?iso-8859-1?Q?H6BgBWBJfuCkB839aZLJezvhm1vCDJX+3CgSJBA/8KDBNYwhAt1IDOire3?=
 =?iso-8859-1?Q?e25gZOXUNpOMwSNhbMG1bbDspZyOkzGIY4Jsa/dldw55daURh0hfTNovnh?=
 =?iso-8859-1?Q?LuO7YlHAD/lQ7kzCV0bFYIEujkT3wrbTjMYN/fndbyk6x67KClHcibslyv?=
 =?iso-8859-1?Q?3I6p5OBE6DkylMRJxASlIOyzRIIZ60TohqA/ZwNA9f99julG4XrqnUs0Pm?=
 =?iso-8859-1?Q?CDA7qDlIv+t67OVLuXyjE31ZkGzZDJxgty4Cl5EFZCtPz8eyRuC1HoBZlU?=
 =?iso-8859-1?Q?bVfwzilyIKIiaiEznnIxwJON707WtJJ5A6QznHaszOx9e9pgGgotmDD8C0?=
 =?iso-8859-1?Q?VFuo1QdjjvKC8iSRur31WpTWErXnz1InTWffuaHIKL0FvStTfJjp/wCPhu?=
 =?iso-8859-1?Q?anvvlDENOloXifYnwfTaP7pJhmLyujzzrWBDgoo2tEcbyVqlmRatnLFdLp?=
 =?iso-8859-1?Q?XRrrmi90m8v+9ceNbUPGcVbHGNQyllBA9ZMOMj7u2448e+kgHyu2b6/pg+?=
 =?iso-8859-1?Q?zWBQXKULgT5tC6PbEcTgFB0tx3QTf1z71MrQ0PrCvXpCuEV7FWpApksSR4?=
 =?iso-8859-1?Q?0Ka4XX8AJVN1MVGE2shvJaDdnDgK5yHwC8YObPgierE7NrUqOhyfZK0lJW?=
 =?iso-8859-1?Q?rpwwNex9qXiouJ/MEex9mmLaN6LnAPm4uI80S5z/gpIQOGqI0WBVRaK+zb?=
 =?iso-8859-1?Q?tDBYOvzr4CpP04xUpX2NJPSgVVUsv/+wuCZuE/+DTm/4K42jS9E2XUyzre?=
 =?iso-8859-1?Q?3kxg5nMnD3lFTvp7jXuvV3xs3jlBsAcYfryDkaIDGdFyjhqJXZDiIVEw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4DA63D023E3FF94D8A858E0D54274230@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u0h5dfZXVCBdN3WYuAJcXaff2ejQ3FjzInIkJrzv3Wo8o4AyyU6vMbug0o9B7xjAfaqtAJV9FRpAuMEHogyD418zKzyDWXFLt70Rh46GDMek2nVzDLutq8ioCOX3ZayA/C7ZvHRDkNCH5U//HPsEG3sTggZdk3MaA3MtCzzMsK3wkcFvJJycjdvRXEf0dzxFZYu9wqrBCTny3Di5mLrUNOsR37AJxq9u6AgRUIFrXk5cQKCPy3Zi0JfnD9VxyT2v2u3pQSdyiGS2r9SzihmF2by6k3LAp0y6o4KSj7Ph8J/s0JRyqJSjFta6ILG8W7QBnYzJLt6HuI6fn444x45hhCo6YoZ8yRkMgV+OuN/QhPvabjhWVA9IfAouNaZ3UeRdtKTtFFoVNR/br+06I0S893X/4Vini96yMBrF+QRrvPKiUFYOwJwSqJpbIqeQbmx+sGA1f8uSTsNSgMVMYPFTm2nbrhENxkCCZmtb+Z6FBz13gbrHlF2SSaGvnLmzuiBbEuSQdDM7Y43gfvRSacIQc9FyR3EPbwkEZCmQIcbWCJjlF9JQJ7se2A2f47Lz29rh8BOAHmz5azYWt2VCsBl5+iDeZbG1vMb4YufLiVOvBjLx0N4ApC1Wp3/FzYmncso9GmniofSY71gRHLWOLyBScb3Adlegb6fNmblHqIahIDrvWAd+UjFAJstqYgDlN4nvJH+RfgQedL7wM5IDKhh7zfRTAg9iA8T05nViF4zldVhr/EStQEbCuucf2zmKdY4cBx4Dc09cc5BI3kbnbTWkb7UzypFFLSmv0RhHXwBj+udh/1xcX4voe+beluXTGj8ppgDXaextOnyb+eeba7lRSuBnENmw8Hui3rOzGwbfA1yTh78/g+W3ZwF6HN2cVj+g
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3574.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c613cfa3-bd84-4022-9d99-08db83a05f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 12:55:01.6735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAj8ewGLLwjBwVAGVWN3ENNL4FbWqH+sUCLvJ2naPgGJSt6folOyxAeQy9r0I/cYhqOPtzmMWjWpCYB9qRENCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7155
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On 14 Jun 2023, at 21.16, ira.weiny@intel.com wrote:
>=20
> From: Navneet Singh <navneet.singh@intel.com>
>=20
> A dynamic capacity device utilizes events to signal the host about the
> changes to the allocation of DC blocks. The device communicates the
> state of these blocks of dynamic capacity through an extent list that
> describes the starting DPA and length of all blocks the host can access.
>=20
> Based on the dynamic capacity add or release event type,
> dynamic memory represented by the extents are either added
> or removed as devdax device.
>=20
> Process the dynamic capacity add and release events.
>=20
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
>=20
> ---
> [iweiny: Remove invalid comment]
> ---
> drivers/cxl/core/mbox.c   | 345 +++++++++++++++++++++++++++++++++++++++++=
++++-
> drivers/cxl/core/region.c | 214 +++++++++++++++++++++++++++-
> drivers/cxl/core/trace.h  |   3 +-
> drivers/cxl/cxl.h         |   4 +-
> drivers/cxl/cxlmem.h      |  76 ++++++++++
> drivers/cxl/pci.c         |  10 +-
> drivers/dax/bus.c         |  11 +-
> drivers/dax/bus.h         |   5 +-
> 8 files changed, 652 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c5b696737c87..db9295216de5 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
>=20
> @@ -1244,6 +1452,140 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_=
memdev_state *mds)
> }
> EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
>=20
> +int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> +                             unsigned int *extent_gen_num)
> +{
> +       struct device *dev =3D mds->cxlds.dev;
> +       struct cxl_mbox_dc_extents *dc_extents;
> +       struct cxl_mbox_get_dc_extent get_dc_extent;
> +       unsigned int total_extent_cnt;
> +       struct cxl_mbox_cmd mbox_cmd;
> +       int rc;
> +
> +       /* Check GET_DC_EXTENT_LIST is supported by device */
> +       if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> +               dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n=
");
> +               return 0;
> +       }
> +
> +       dc_extents =3D kvmalloc(mds->payload_size, GFP_KERNEL);
> +       if (!dc_extents)
> +               return -ENOMEM;
> +
> +       get_dc_extent =3D (struct cxl_mbox_get_dc_extent) {
> +               .extent_cnt =3D 0,
> +               .start_extent_index =3D 0,
> +       };
> +
> +       mbox_cmd =3D (struct cxl_mbox_cmd) {
> +               .opcode =3D CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +               .payload_in =3D &get_dc_extent,
> +               .size_in =3D sizeof(get_dc_extent),
> +               .size_out =3D mds->payload_size,
> +               .payload_out =3D dc_extents,
> +               .min_out =3D 1,
> +       };
> +       rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
> +       if (rc < 0)
> +               goto out;
> +
> +       total_extent_cnt =3D le32_to_cpu(dc_extents->total_extent_cnt);
> +       *extent_gen_num =3D le32_to_cpu(dc_extents->extent_list_num);
> +       dev_dbg(dev, "Total extent count :%d Extent list Generation Num: =
%d\n",
> +                       total_extent_cnt, *extent_gen_num);
> +out:
> +
> +       kvfree(dc_extents);
> +       if (rc < 0)
> +               return rc;
> +
> +       return total_extent_cnt;
> +
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extent_cnt, CXL);
> +
> +int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds,
> +                          unsigned int index, unsigned int cnt)
> +{
> +       /* See CXL 3.0 Table 125 dynamic capacity config  Output Payload =
*/
> +       struct device *dev =3D mds->cxlds.dev;
> +       struct cxl_mbox_dc_extents *dc_extents;
> +       struct cxl_mbox_get_dc_extent get_dc_extent;
> +       unsigned int extent_gen_num, available_extents, total_extent_cnt;
> +       int rc;
> +       struct cxl_dc_extent_data *extent;
> +       struct cxl_mbox_cmd mbox_cmd;
> +       struct range alloc_range;
> +
> +       /* Check GET_DC_EXTENT_LIST is supported by device */
> +       if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> +               dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n=
");
> +               return 0;
> +       }
> +
> +       dc_extents =3D kvmalloc(mds->payload_size, GFP_KERNEL);
> +       if (!dc_extents)
> +               return -ENOMEM;
> +       get_dc_extent =3D (struct cxl_mbox_get_dc_extent) {
> +               .extent_cnt =3D cnt,
> +               .start_extent_index =3D index,
> +       };
> +
> +       mbox_cmd =3D (struct cxl_mbox_cmd) {
> +               .opcode =3D CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +               .payload_in =3D &get_dc_extent,
> +               .size_in =3D sizeof(get_dc_extent),
> +               .size_out =3D mds->payload_size,
> +               .payload_out =3D dc_extents,
> +               .min_out =3D 1,
> +       };
> +       rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
> +       if (rc < 0)
> +               goto out;
> +
> +       available_extents =3D le32_to_cpu(dc_extents->ret_extent_cnt);
> +       total_extent_cnt =3D le32_to_cpu(dc_extents->total_extent_cnt);
> +       extent_gen_num =3D le32_to_cpu(dc_extents->extent_list_num);
> +       dev_dbg(dev, "No Total extent count :%d Extent list Generation Nu=
m:%d\n",
> +                       total_extent_cnt, extent_gen_num);
> +
> +
> +       for (int i =3D 0; i < available_extents ; i++) {
> +               extent =3D devm_kzalloc(dev, sizeof(*extent), GFP_KERNEL)=
;
> +               if (!extent) {
> +                       rc =3D -ENOMEM;
> +                       goto out;
> +               }
> +               extent->dpa_start =3D le64_to_cpu(dc_extents->extent[i].s=
tart_dpa);
> +               extent->length =3D le64_to_cpu(dc_extents->extent[i].leng=
th);
> +               memcpy(extent->tag, dc_extents->extent[i].tag,
> +                                       sizeof(dc_extents->extent[i].tag)=
);
> +               extent->shared_extent_seq =3D
> +                               le16_to_cpu(dc_extents->extent[i].shared_=
extn_seq);
> +               dev_dbg(dev, "dynamic capacity extent[%d] DPA:0x%llx LEN:=
%llx\n",
> +                               i, extent->dpa_start, extent->length);
> +
> +               alloc_range =3D (struct range){
> +                       .start =3D extent->dpa_start,
> +                       .end =3D extent->dpa_start + extent->length - 1,
> +               };
> +
> +               rc =3D cxl_add_dc_extent(mds, &alloc_range);
> +               if (rc < 0)
> +                       goto out;
> +               rc =3D xa_insert(&mds->dc_extent_list, extent->dpa_start,=
 extent,
> +                               GFP_KERNEL);
> +       }
> +
> +out:
> +       kvfree(dc_extents);
> +       if (rc < 0)
> +               return rc;
> +
> +       return available_extents;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extents, CXL);
> +
> static int add_dpa_res(struct device *dev, struct resource *parent,
>                       struct resource *res, resource_size_t start,
>                       resource_size_t size, const char *type)
> @@ -1452,6 +1794,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(st=
ruct device *dev)
>        mutex_init(&mds->event.log_lock);
>        mds->cxlds.dev =3D dev;
>        mds->cxlds.type =3D CXL_DEVTYPE_CLASSMEM;
> +       xa_init(&mds->dc_extent_list);
>=20
>        return mds;
> }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 144232c8305e..ba45c1c3b0a9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1,6 +1,7 @@
> // SPDX-License-Identifier: GPL-2.0-only
> /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> #include <linux/memregion.h>
> +#include <linux/interrupt.h>
> #include <linux/genalloc.h>
> #include <linux/device.h>
> #include <linux/module.h>
> @@ -11,6 +12,8 @@
> #include <cxlmem.h>
> #include <cxl.h>
> #include "core.h"
> +#include "../../dax/bus.h"
> +#include "../../dax/dax-private.h"
>=20
> /**
>  * DOC: cxl core region
> @@ -166,6 +169,38 @@ static int cxl_region_decode_reset(struct cxl_region=
 *cxlr, int count)
>        return 0;
> }
>=20
> +static int cxl_region_manage_dc(struct cxl_region *cxlr)
> +{
> +       struct cxl_region_params *p =3D &cxlr->params;
> +       unsigned int extent_gen_num;
> +       int i, rc;
> +
> +       /* Designed for Non Interleaving flow with the assumption one
> +        * cxl_region will map the complete device DC region's DPA range
> +        */
> +       for (i =3D 0; i < p->nr_targets; i++) {
> +               struct cxl_endpoint_decoder *cxled =3D p->targets[i];
> +               struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +               struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlm=
d->cxlds);
> +
> +               rc =3D cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
> +               if (rc < 0)
> +                       goto err;
> +               else if (rc > 1) {
> +                       rc =3D cxl_dev_get_dc_extents(mds, rc, 0);

Hi,

when playing around with DCD, I noticed the following mismatch for cxl_dev_=
get_dc_extents. In the function
implementation above cxl_dev_get_dc_extents takes index as 2nd parameter an=
d cnt as 3rd, but here they
are swapped so count (rc) is supplied as 2nd parameter and index (0) as 3rd=
, so this should be:
                      rc =3D cxl_dev_get_dc_extents(mds, 0, rc);

The prototype in cxlmem.h needs to be updated as well - see further down.

> +                       if (rc < 0)
> +                               goto err;
> +                       mds->num_dc_extents =3D rc;
> +                       mds->dc_extents_index =3D rc - 1;
> +               }
> +               mds->dc_list_gen_num =3D extent_gen_num;
> +               dev_dbg(mds->cxlds.dev, "No of preallocated extents :%d\n=
", rc);
> +       }
> +       return 0;
> +err:
> +       return rc;
> +}
> +


> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9c0b2fa72bdd..0440b5c04ef6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h

> @@ -826,6 +894,14 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd=
);
> int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
> int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>=20
> +/* FIXME why not have these be static in mbox.c? */
> +int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_=
range);
> +int cxl_release_dc_extent(struct cxl_memdev_state *mds, struct range *re=
l_range);
> +int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> +                             unsigned int *extent_gen_num);
> +int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds, unsigned int cn=
t,
> +                          unsigned int index);

The 2nd and 3rd parameter for cxl_dev_get_dc_extents should be swapped here=
 as well to match
the actual function.

Thanks,
Jorgen

