Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26480C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 23:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjFAXIO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFAXIN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 19:08:13 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552371AB
        for <linux-cxl@vger.kernel.org>; Thu,  1 Jun 2023 16:08:09 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351M8FpJ026965;
        Thu, 1 Jun 2023 16:07:57 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3qy3uyg5bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 16:07:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlOOQHWTE/iL4Rgns2DBhukERbSKujz1qxsDvm3YIvOClBKsYK5oI31/kSjpY9Zscl6Oze8GL1+okuYZey4zPqyIjYJp2HGkJBcdzpEw5eTIVQsh59wtfS0NkB6Egx5oBKQNJB8e427ulIArym2gs/3+hyHRchLgbvh0QWdGxRytO+qby1YG7DC08WTKy5WjPUj7UGMgdmzWjv/LzIYL72+b/1NJ2wuMlCM7EORdrPN5ZRPSahmXnhhl4gW61NrDtfYEEC16YpGxE24pLVYqQVyBqLvTjgTE2FZ7/CBYrRRCjIxX0Ty8CaHVtwToJ7wfgwPKbgJHkr/fFxNija9TPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNIXlHd4ICEQgD6dLi5NQwoiUWR5VNJCnCaphRF4p2M=;
 b=dZolIgcXb61w7VEFOIbb6bhjy1Pz5CN0HUiso3XouORmNF9XF7s1+b8vI38rdeM2bXWRHvW9fY+ctkufW1WoF/ta8tzL1/90wgfxLzgD4Uzko+7iEL4IePXnipm+jvcvKsxJIDsIGsUFiQ8MoSF/aMVsQbBgL/wFU89prBDNzn7I/mvyEpfqPuU7SzDIhvtDD8Hj4P808N7k2pRXnkgWF5ATcpH+WOK2Ty1S4fyFMpPfd7oFilnDfEUVgLAtpVNWiRnmg6j007r/m28yTmzAKYefGtIUiJSOnw9/z0FKGS4Scm/F9S2ahbX0IlJGbUnHMzB9sf/iG3kE6G6rWYWpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNIXlHd4ICEQgD6dLi5NQwoiUWR5VNJCnCaphRF4p2M=;
 b=RgZVV2Relam/saJBybv+SgQWI5bsuWtmhCwInvXrdPXJl632BO6imqAfyRjevqrhXQYUBB15zC6XwZcP8AfnOWh1dpZxE9lWVqJkHm65GTaKJyVoE96PTR9164zjP+vaGw3VQyoMUvd8wDVDQ2xCJhMp4A/4g3jkUij3IN1xU/c=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by DM4PR18MB4206.namprd18.prod.outlook.com (2603:10b6:5:391::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Thu, 1 Jun
 2023 23:07:55 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::51a6:1c8f:d997:8d45]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::51a6:1c8f:d997:8d45%3]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 23:07:54 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Thread-Topic: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Thread-Index: AQHZiomHd0qPqIKI60KGfLR7fTfylq9mYfCAgAIOkUeAATcUAIAAEvKDgAF6xoCAC3DpNw==
Date:   Thu, 1 Jun 2023 23:07:54 +0000
Message-ID: <DM6PR18MB2844DA254DE3754A3E07AC92AF49A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB2844C8CDBF085BE599F98EBEAF7C9@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230522154135.00002be3@Huawei.com>
        <DM6PR18MB2844ED837509545D7BCE93D2AF409@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230524173938.00002d7e@Huawei.com>
        <DM6PR18MB2844EBEBA8D10343B6DB763EAF419@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230525172307.00005a8b@Huawei.com>
In-Reply-To: <20230525172307.00005a8b@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|DM4PR18MB4206:EE_
x-ms-office365-filtering-correlation-id: 272eae72-11fd-4c65-bfe9-08db62f50807
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EtZLKz/vLipj8iH4oAl1e3XBNsF9K6ZBma5wp1W2Fw+FF1hGtuUFCHBNphgG+mR/nZpTVyT9t0lCi8RUZgFSIiK8qEZYvczDvX3LO4Odw+0IhJtH031SUVSaxcSvOMzQzk99cnt9AafEHfiR3xWoASaVYsPjQkFbHjmML3eso45tQqrJoI1lHK7EeE9Um5cvm4k0hZFLe2A0+voy5ezSYRm7KLadfKCj83RSo/1OfuOdAVCnHqDaA924QO/OIob/U3rIS5WdOgHo2WAnNja1y2/q76HbtsJyN9C3lPKrx2UXNRwXfVv9nX55VeABBv2k29cCzAhBA20jglo5v1VdKXx2u7CoiTpgLjUxvglFyOWsccurdxPRvCFpKqcNelyY7zDnDT1FnELqQO7iHOWTO9MEP66wMkIOoxSVRFeT4pI9sTeoUIcXhb1Sfkux0UVUUxoHXRft4aQnp0xE6mqKrKmRJuWdu73lITaHZSwKXY9/TFM1iifd+qLrcBEokuwMZC2HPEJ8YZtGmkDDkD2uKXMrilr3Maysci4oipOcFyHxaYuGaezQINNzKj+VGqeO6Sy8/xrkNYAObdTdlyhfr1bBJ6yYAm+EJNAzeBOhO/4FKak2Xf3+XCmnSapFgUzw99zngFPvzcnBEOALaXhBHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(966005)(4326008)(38100700002)(122000001)(26005)(9686003)(6506007)(53546011)(86362001)(2906002)(5660300002)(52536014)(8676002)(8936002)(186003)(7696005)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(38070700005)(41300700001)(83380400001)(91956017)(478600001)(33656002)(55016003)(6916009)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m7k5cKqSSIioK5kmYya+xJ7cvI9tjuXTttAowLpawI+/wTfPmZ9TB6SmdR?=
 =?iso-8859-1?Q?EkA87E4iQpz0Iy4Sl4p+MmRo6uNAQyj2o9qJVNoqr/CiNiD/+UJHW3M7/P?=
 =?iso-8859-1?Q?FqwXWnF687WdPHqIgmJQ5qVuQx21wvEvI9H43xaIgRGj/LGEJ7ntcHu0pn?=
 =?iso-8859-1?Q?rjqZaDfjTy1pEFTQkDMhqK7uhqqwCOrfa3tULwSjU0y9jrmpkjJVKqa/Jd?=
 =?iso-8859-1?Q?qpeuMok0Ct0GBRJ5V6k8UYXtdqsyDjFnPbBODfzYZxHypuoXORbhJ1raQc?=
 =?iso-8859-1?Q?P9UTt9TRUnfKSQdPX/VsMiIc+MlSEe8S93aKvb2ZWloC5rwaq4B8CVJmDm?=
 =?iso-8859-1?Q?76SD5Rn/bZwXUsUflHWuEjQgaboSBQVuUY9N0zDgouurcTFbkhwwBcXTZf?=
 =?iso-8859-1?Q?t0O1b4Acw4n2rPEPDVPxSfmoqWgSlIo7UomnTd8HuZAIem7UnvAZn8NqK9?=
 =?iso-8859-1?Q?ASVqN0pe9xT4bmVTQ/45bkI75u0H7omst1zg46I4rO2bPimPdVDUBYjnA7?=
 =?iso-8859-1?Q?E5ePImQWJ3aI3XfzKlITeru4S9oTxrTaAQ6JA5xvnpteJREKxrg/Xy3dfu?=
 =?iso-8859-1?Q?60V0dHCGd5JqsUjynY3zibhXLQwmKShZ0/xB0RITtjgRnEL2TYI+yDUw9p?=
 =?iso-8859-1?Q?PGoEBkikKH8EP27DThjOVuag4M5yqIRuE1fWkTsqhlXjXui50i/SuHM0xU?=
 =?iso-8859-1?Q?7r0ChItp05l0Dwy118EUn+hhTSsTia3SyD+zbk8s7l0g98qO/ZjqDLGhQ0?=
 =?iso-8859-1?Q?/MuYV6VfsG76HUkxvUyKYSNlZT5c1gAEoWtB0k4rzPwFtTwM4eBdKUwQUA?=
 =?iso-8859-1?Q?GjCPHeql2SZzBG6wqsM+cdLPP1Ev10MfoTq4orPsR8SN/t27fSjrxSo29q?=
 =?iso-8859-1?Q?cmQG7Skk3r7onkPhBmTXmb61xWT9gxnxw+rsgALnsBhXiGN8fv8FDQ36aA?=
 =?iso-8859-1?Q?xAP+rwmwm4m7GllWK01eKmnoz902Xf1qO4I7Cra7QNFbkd6K2NhNPuloFn?=
 =?iso-8859-1?Q?QVnihtPOYi8uZ3hGGC6BTjGt1zBes9qKUoV7E4U+xqJ9Bm1juVX7Ad0OxN?=
 =?iso-8859-1?Q?l5dGJSWMypm/nuq1aoaWZnOQw6R9QGTctGyjeJY1h8HXSKsDL21cL+zIWq?=
 =?iso-8859-1?Q?a8apKRRdFtwCr2HtFd08csf23rOhsZQX9G3zmEge3/r+oJCUu9cdT7t9Oo?=
 =?iso-8859-1?Q?2hJtgkCcJUg16nLYrUuqlsvQVhk6sF+2ia8CbhjA6IdHdMIc4MmTStYxB3?=
 =?iso-8859-1?Q?z2MTByYt4rjs4gNF9UL1csk+X9eTZqijwzGbeOYYPwOu0nWwmpoujq2qX6?=
 =?iso-8859-1?Q?aKjmEZd603XqnSk6OzarLLWQMEuAq/S8PLzCORbaBhpBxK8Bjt9Uyops7L?=
 =?iso-8859-1?Q?d9lMrd9ChDJd/FZZEA7BJeTulTwRKWJsxbHOv2mxNEQYjYhA+xvbCzapV4?=
 =?iso-8859-1?Q?hafzV/KHgNP5R9NNKfI3ZoaT2EcSsZSx2vryZI/FoCsx2YEK8F13jVwZZ6?=
 =?iso-8859-1?Q?fFyTTfTZaPFrWBVv7UOolCwPXNmgEonprhsTWiPegEmdmBWAuKJwMVjn3U?=
 =?iso-8859-1?Q?nNzOEYPMVPFsyYDHspVn+I/bLsc29jAbqR6bSn3FPKlsXB5KmfHWi8ipfU?=
 =?iso-8859-1?Q?qF7Yay5oxyWgo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272eae72-11fd-4c65-bfe9-08db62f50807
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 23:07:54.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8KAths+gaps+vpcN4QO3oTtnI7cvxVoOPpMsScYXtGP1pjMCG4wHDS/J9OCSGrFcxziniL3CvON5U90kejPaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4206
X-Proofpoint-GUID: -YVkTgptom42TFRaUVzeHMYjZZXBMfEk
X-Proofpoint-ORIG-GUID: -YVkTgptom42TFRaUVzeHMYjZZXBMfEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks a lot. It works. I am planning to add more CXL commands, especially =
DCD commands. Are you or any one working ? If so I will wait :)=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Sent: Thursday, May 25, 2023 9:23 AM=0A=
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>=0A=
Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU =
=0A=
=A0=0A=
=0A=
> ss: Thats great ! Can you please share the code, both QEMU and kernel dri=
ver ?=0A=
=0A=
QEMU:=A0 https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__gitlab.com_j=
ic23_qemu&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr=
8KklkMRPn7Z_Qy0o4unU&m=3DUQ3dgvJg_i34v2qxPCBlB3FuVUmLQ37oHw2LKVGYimsevbBm75=
NKu_2xDhtZ3LxL&s=3DDWzpkbi44uasdoDv_GxAR2to07vEd_Cr7eaKz0lpP6E&e=3D=A0 cxl-=
2023-05-25 =0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_linu=
x-2Dcxl_20230525160859.32517-2D1-2DJonathan.Cameron-40huawei.com_T_-23t&d=
=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z=
_Qy0o4unU&m=3DUQ3dgvJg_i34v2qxPCBlB3FuVUmLQ37oHw2LKVGYimsevbBm75NKu_2xDhtZ3=
LxL&s=3D3zV1e3KB_3wAesmu5jsYP7YodFFgzjydMl0vICy6Tis&e=3D =0A=
Kernel:=A0 To enable ACPI support in the aspeed-i2c driver used.=0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_linu=
x-2Dcxl_20230525152203.32190-2D1-2DJonathan.Cameron-40huawei.com_T_-23t&d=
=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z=
_Qy0o4unU&m=3DUQ3dgvJg_i34v2qxPCBlB3FuVUmLQ37oHw2LKVGYimsevbBm75NKu_2xDhtZ3=
LxL&s=3DtPmsOiZy9jqzAIFK46Nj_WIzpX7WNf5bxge2uZUa2Yg&e=3D =0A=
=0A=
Other than enabling MCTP + the aspeed-i2c driver, not much special needed k=
ernel side=0A=
(all access is from the MCTP socket interface in userspace).=0A=
=0A=
Have fun.=A0 It's pretty minimal at the moment.=0A=
For switches it pokes at the number of ports (the port status is all lies f=
or now)=0A=
For Type 3 devices it just provide Identify.=0A=
=0A=
I need to do a little more spec diving to check I've enabled them for the c=
orrect=0A=
MCTP bindings.=0A=
=0A=
Jonathan=
