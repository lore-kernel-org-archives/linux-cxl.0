Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89605C7EE29
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 23:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbjFBX6S (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 19:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjFBX6Q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 19:58:16 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847D21A6
        for <linux-cxl@vger.kernel.org>; Fri,  2 Jun 2023 16:58:15 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352KsuZT031127;
        Fri, 2 Jun 2023 16:58:05 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3qynhvrtgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 16:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJAvRUMYor4OBeBhWM6i1V/IuPLz3VvZVw8EI+XurtLP3faXNAlqunLKFiLNA6xAXBN1k2BOuHBcqiwG5obELZmKqqs0HEtpQLSIUTlPPaJcWKb7iqmYl0KNRfkOgMBKb2agxu/MvXY9IXNlVFTAtB31V8BqWkH0z3wbAfMpFztJIR5eb4I9HT8AZVXOZ86b2l+zGDTTDg8RDA3JFyjYz5WUYq77nqYbT+xvsQjd42cy3TFSJUZuA0ZTjdZ9QyAKcOXJFdvK9oPDzUoKqdC4JB6iwXJJm/8rmhy4eUgDY/DBS08gidue2776V/KKLGB7okwjxYmenXDEVeNY2nP03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uf2FON16hauORaQ+uqa/iQ39RTya3jZFtWaH2DDncw=;
 b=nAkPVjvftLmbemBg9/ajYqpRsu0Ou8bEfhdbN4+fwkK/L5U0jwMBaEae/LEwfwXQ+P/rtlqBNNDkN3C3uimJm7qOUOvYrGy65eNT6EzGI9SBWw8egFpzWX0GdgcG0PMtGB9BNenv04A/uEQ7v1/TsFFQpodVtwHzYSZUZzMIz2LckqKvKCK7Q1OshMGpK9XIv6jK4qlzF6Xx4DZOAhNNYR6oHi9FwJkKp05wCFPMFEjl+R/udu9rt0VloYNJEdYbxq+9HU/O2W5uV+fdFBOrSntnBqnt7fRedtMLte0PFxfOE/9Yk2K9Paz/zUmcMVJk/hOPvB1PQJttRCKtYSoD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uf2FON16hauORaQ+uqa/iQ39RTya3jZFtWaH2DDncw=;
 b=lUKq9LPXYkaE982yYz1KBih7I3B8rhD5UdOgWYavKgklBE0NUqmc+v/kgrRDDNHuKHViMxQj4vTuNpTlX7pUtvfESia+OeBAmJMTmyOEAaPpC/gWl+IexvlMDB025y2OPAWcD7ReD8IeKDHaUKjhKt6JJ2c5UDKPKajySQKJn4I=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Fri, 2 Jun
 2023 23:58:03 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::51a6:1c8f:d997:8d45]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::51a6:1c8f:d997:8d45%3]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 23:58:02 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Thread-Topic: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Thread-Index: AQHZiomHd0qPqIKI60KGfLR7fTfylq9mYfCAgAIOkUeAATcUAIAAEvKDgAF6xoCAC3DpN4AA30qAgADBL8U=
Date:   Fri, 2 Jun 2023 23:58:02 +0000
Message-ID: <DM6PR18MB2844D384AB1123ACC465A212AF4EA@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB2844C8CDBF085BE599F98EBEAF7C9@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230522154135.00002be3@Huawei.com>
        <DM6PR18MB2844ED837509545D7BCE93D2AF409@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230524173938.00002d7e@Huawei.com>
        <DM6PR18MB2844EBEBA8D10343B6DB763EAF419@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230525172307.00005a8b@Huawei.com>
        <DM6PR18MB2844DA254DE3754A3E07AC92AF49A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230602132517.00006793@Huawei.com>
In-Reply-To: <20230602132517.00006793@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|CH0PR18MB4339:EE_
x-ms-office365-filtering-correlation-id: 383feacc-782c-46be-c532-08db63c5338e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MWxy0XeXWYTXjEE6Nhl8bxVZtXIu5Kr470fe9MQUkMdfbCuRTlgcwKwm8ViR2z+fchQD3C7M3reBjnjN1QY7eCkfYP/jiDh6SP2ys4zOP78ZH8HUSTcGMTPzW18rM/pSIfHG0ZR1DR6OH2o5bDApBv7SSHfBgn4iQpxgCdWD3w5VGGt+chdOpvUSq0xm7flJ9PQBWygnQd/BAEoLmW6u3wqTv8lXPa7PnWhHgIb2wYPctxk5r3+hvOoh+Rzlins+A9EOF7dYzAKfB/G5bmEXLbgHIeTPhx+vEJKJ0/uRqvpcUhOQSzrnGyBMK/2LP2lICBrFCD/COI5IzM2bVQzjQPY+H/Z73kQOFQ4b0+fd+zR/GKGpF9xgBdu9rgTMj8DkMga357ulxZcF+0gFvrXSbSANepaQCRQV2d0cFBrcXiep8D+8sVhc+axbSVgA5jjqTbngAxH6kcYGTuxFYT1qf8JaMlmsFkQE+bx5VHLbqtmoQ9VoaW82QsiMmWd4ei4kAzObUAs2C6Lw4jlJzqh1yFdf+3pJ5FDVbEWAtafGDt39/boCc6w2ABDZBD1ebZjOJmbjdzcVyX2HV9agdKNk4rQhZWvXkzOTpnRQupwLTbot/r6weFAW7qZXZCixPWyHVlLqnSwT1MMb93NYnEqyKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(316002)(66556008)(66446008)(64756008)(6916009)(66476007)(4326008)(66946007)(91956017)(76116006)(8936002)(8676002)(5660300002)(52536014)(41300700001)(966005)(2906002)(6506007)(26005)(53546011)(9686003)(186003)(83380400001)(7696005)(71200400001)(478600001)(38070700005)(33656002)(55016003)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ozgnGqFwuJrrWoB3MzQXjxPkvfxwOflaJkFHEfyW9w3WynQw6STvMFdq/v?=
 =?iso-8859-1?Q?EWxBI4S0ftOOKnhOnB3o9uLJxXsWimJUhBZAf9seLjmmri4xmpNvwVc4x9?=
 =?iso-8859-1?Q?Unrn6G7rYHtdbXyt8Brmvm/HGAo1UwkPOthUFcdpaT6CQemJ1OmIvuczzi?=
 =?iso-8859-1?Q?7ufjATnpCFELlLXwp2OirFf6QLtgnGk8gLzTXEaQr9fe4BEt1MEZIfny3a?=
 =?iso-8859-1?Q?HwcVKj+QdU7a/tBVwxWlBWJzjWZL9DlmQfE4Jc1y1ZDpgcu6IokT2CqZuu?=
 =?iso-8859-1?Q?cHyFq8vxR1vys0Z4Y6dMCkcRyyhouuCidChVfakjpoS8KGGMKhvcyYuxhR?=
 =?iso-8859-1?Q?uniAzIjI9iCW0SuVLBuYIJh8hXR8MGSmnarHm2deFnEVdhM176MY97QFJh?=
 =?iso-8859-1?Q?o1wMMw01sKBwI1u9tXe7YYkw7cBOF85T3Q7kr5+6UurLx7M83M2986ZQxK?=
 =?iso-8859-1?Q?CIQ7/ac2Y5BSHlohXwSkVhN9fOSesHA/tKnLVZWg9WaIjnzTcJNhm0D88S?=
 =?iso-8859-1?Q?teRv4cQr6rX1C+KyvE+a26KVpvSmghcLHdmYgEfIcecup9FzPdjPCSl8Pn?=
 =?iso-8859-1?Q?SiR36tgd3nM+cPPcjaStvkHZ0ox0GyiORJPIiNS75fEbybr4WO5jnn08zg?=
 =?iso-8859-1?Q?fvGwWkWtpjo2pLBlPzi5HDQ1Nrtsbtb8Y+j2Yw9S3gBspPdgwWj/xqB0XX?=
 =?iso-8859-1?Q?NNZLHr6TdfRit6yoje6aplqVdo5gVrWSqKFEt1t6nNdfjuKvc+iz0uIKBj?=
 =?iso-8859-1?Q?0cuFSq8VXPLqtiVfYI9Uk3RM10zHuYE4NuOuA5UdOW6biowF2Jl+NJUM12?=
 =?iso-8859-1?Q?rE8LTc7qNxRy7l6Q9gIB776qjp4pytNBpedn5paja7z8X4meBB6S2juz1D?=
 =?iso-8859-1?Q?t5GUWDEKeLMKtpt1cX7mFhpuEnu6c/k5lYge9Yw/Sn37kzHifmj98hKc7G?=
 =?iso-8859-1?Q?MipzBtg5903Yp+cCVaPoUO4o90/3U2vDqoi+mf5FZx/ZIAdrrsiQFxnPKB?=
 =?iso-8859-1?Q?YKGfKf0tx7HM5Nq5eW6DiyJ/4qk3GS1PpxrXTlTPVWEEiap1vxMRV1pEdW?=
 =?iso-8859-1?Q?ZQBNt3XEuArGcjgiZ72D8RLK81VXXUas/mhBHFz0ri4AMl7yhepVGJDwfM?=
 =?iso-8859-1?Q?cbBwcgtOqlsWglWPMp/e3ML5e1wtpDHVTRs7M8af0N4uTCqExP0EhO2B1B?=
 =?iso-8859-1?Q?UkpG7a1aQh8I+0VikImRPaaUxVaRZMM48f4HidhcLLpKIL9I9W02o9NpY9?=
 =?iso-8859-1?Q?YK9iwpQQau4bcDozhTdL2JZYpZldDSzpdtRlOXlQUY9EKnY+4E5yzb1kXS?=
 =?iso-8859-1?Q?uK+BN5KCk9sZpskGdrkE4XN9taxhreGsWmgzohGqVyK4P/6os08Ws9SnZ+?=
 =?iso-8859-1?Q?8xrqHpEBFZPO7+ChtD5Spo7WGp61fs+T/lzJNrvKce2hP8p2Mg/EL7Weij?=
 =?iso-8859-1?Q?2pDf6CgrGMt/R/xCiBunHQl6ur4ZCRDNlOMHFrOp2pYcMkTS6CHTcgyCmb?=
 =?iso-8859-1?Q?m0exSjzHSi4noiWxL7oYjwIt8HiUPIKlT2w8zk8P2idIcAj9QGlohRKZP8?=
 =?iso-8859-1?Q?UBS865tYitK+sWk6j0uoMVXbZyFRMK/jzpg4DUkdY7dVA0spQGupBwGdVP?=
 =?iso-8859-1?Q?fiGfzSDKEeqM8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383feacc-782c-46be-c532-08db63c5338e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 23:58:02.7388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNhfPSa427c4vS0q0BRk8TXk/icrBABfuqDEIAYvokvHKjKTEsAKqWYHgoK5UOk3/ELlE9S6eqrqPoTsj1brCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4339
X-Proofpoint-GUID: -V8TKDjR0TXLjvw3Yi0ltEUYIsIW7z89
X-Proofpoint-ORIG-GUID: -V8TKDjR0TXLjvw3Yi0ltEUYIsIW7z89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_18,2023-06-02_02,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Sent: Friday, June 2, 2023 5:25 AM=0A=
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>=0A=
Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU =
=0A=
=A0=0A=
On Thu, 1 Jun 2023 23:07:54 +0000=0A=
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:=0A=
=0A=
> Thanks a lot. It works. I am planning to add more CXL commands, especiall=
y DCD commands. Are you or any one working ? If so I will wait :)=0A=
=0A=
It's on my todo list, but I'm more than happy if you do it instead.=0A=
=0A=
ss - This will be my first contribution, so will be slow, if that is okay, =
I will take it up=0A=
=0A=
I'll get on with something else:=0A=
I want to get the mailbox based tunneling working so that we have that=0A=
path for MHDs as well which is reasonable separate at this stage anyway=0A=
- later on we'll want to factor out some common solutions - I suspect=0A=
a lot of the actual command responses will be done in hw/mem/cxl_type3.c=0A=
and hw/pci-bridge/cxl_upstream.c, but for now it's convenient=0A=
to keep them separate.=A0 The switch CCI stuff needs to be in the mix as we=
ll=0A=
and will likely look a bit like how the mctp CCI hooks into the switch USP.=
=0A=
The old prototype of that didn't talk to the devices at all so was returnin=
g=0A=
made up responses.=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> =0A=
> =0A=
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
> Sent: Thursday, May 25, 2023 9:23 AM=0A=
> To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
> Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>=0A=
> Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU=
 =0A=
> =A0=0A=
> =0A=
> > ss: Thats great ! Can you please share the code, both QEMU and kernel d=
river ?=A0 =0A=
> =0A=
> QEMU:=A0 https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__gitlab.com=
_jic23_qemu&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2O=
Gr8KklkMRPn7Z_Qy0o4unU&m=3DUQ3dgvJg_i34v2qxPCBlB3FuVUmLQ37oHw2LKVGYimsevbBm=
75NKu_2xDhtZ3LxL&s=3DDWzpkbi44uasdoDv_GxAR2to07vEd_Cr7eaKz0lpP6E&e=3D=A0 cx=
l-2023-05-25 =0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_li=
nux-2Dcxl_20230525160859.32517-2D1-2DJonathan.Cameron-40huawei.com_T_-23t&d=
=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z=
_Qy0o4unU&m=3DUQ3dgvJg_i34v2qxPCBlB3FuVUmLQ37oHw2LKVGYimsevbBm75NKu_2xDhtZ3=
LxL&s=3D3zV1e3KB_3wAesmu5jsYP7YodFFgzjydMl0vICy6Tis&e=3D =0A=
> Kernel:=A0 To enable ACPI support in the aspeed-i2c driver used.=0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_li=
nux-2Dcxl_20230525152203.32190-2D1-2DJonathan.Cameron-40huawei.com_T_-23t&d=
=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z=
_Qy0o4unU&m=3DUQ3dgvJg_i34v2qxPCBlB3FuVUmLQ37oHw2LKVGYimsevbBm75NKu_2xDhtZ3=
LxL&s=3DtPmsOiZy9jqzAIFK46Nj_WIzpX7WNf5bxge2uZUa2Yg&e=3D =0A=
> =0A=
> Other than enabling MCTP + the aspeed-i2c driver, not much special needed=
 kernel side=0A=
> (all access is from the MCTP socket interface in userspace).=0A=
> =0A=
> Have fun.=A0 It's pretty minimal at the moment.=0A=
> For switches it pokes at the number of ports (the port status is all lies=
 for now)=0A=
> For Type 3 devices it just provide Identify.=0A=
> =0A=
> I need to do a little more spec diving to check I've enabled them for the=
 correct=0A=
> MCTP bindings.=0A=
> =0A=
> Jonathan=
