Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC8C7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 15:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjFHPVp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjFHPVo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 11:21:44 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A05E2D56
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 08:21:41 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358ErvTQ021076;
        Thu, 8 Jun 2023 08:20:21 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3r30eu33yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 08:20:21 -0700
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 358FCvqb023906;
        Thu, 8 Jun 2023 08:20:20 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3r30eu33yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 08:20:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjZlwuN77DkA2K2Brdyr91METojyzU6RmfDIIivHdAtDPnuoAdTebr/H8EbEwy2Saf28cOI5ZrV5lV1IFnmg7ipHD4LXdRrnFmwcnnYNak2bkxGj0BHFFLraDUrc3yaFAYhezR52z2vyWZV7UnojkeHaMmxhtd7lMtaEEsV6w/Zdeu2e1wYwZhDhTyMlKcqAO/G1COaxHB2B6Iv6uAnwiDU26oooK9phyHa4PqyzoZsNCAv8oJZrvQkRpThZF7L7c4GIWNBZ0VwqEibx+t1NemvYxndYV6vtrBjKeSDE+YSKJPsvtUbufdXdXIgdDogiZcskCsyIWzfPud6NCDfDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbG9O9am0XH9e0kSxCeWCnq4jLgCZj6BB8e2DsN8qyk=;
 b=b+5Rk50FgpYAlfzhAoll9NHJ5M2m1MMj5vpfrIdcAQRobMJ/M75Uf1shAQopwqCf3/hBqn6FLpV7iI8VgJaj6P4NNBeIyKmW106evu4WwZo5nhAfi9qZbxh1LUjAYqwu+1Fb1lteFWtTcabk5SVyO6rnbWjggKbaOYxdadHQskJw2547tK8rBJ48isdrX03Ld7Ay3/UZFszc9DqHVuGMmrjrG9LNDvBxDOnZR5wz5ILVv4aF3FuBr1nud7PPlpD2GuakSTZFXNKrOG9YryHBN9sKlXA1C0hgKHQz9XkVb7G2XcjLKbPvJcSfeYskhKZe3JhwZY2SLsRKEgJw4q3prg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbG9O9am0XH9e0kSxCeWCnq4jLgCZj6BB8e2DsN8qyk=;
 b=tP3y6RIVIdncZoVeYnksw+mnW4ZO7FkgSza3RLM44J91dl6sdGPmyKaAwiljKRnYKxIeK/C1bJ86eGjwJPlWQoGtVsk+R301fm3UFc/DXmBCyy9+ZMZK61h1U2L2nlT0Mr6NmkIoQpq4jxoF7/l0eLeJldUl/bxqBRRcBvhe8tk=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by CH0PR18MB4370.namprd18.prod.outlook.com (2603:10b6:610:d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 15:20:16 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864%6]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 15:20:15 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOK98n/AAgAAEVoCAAymO8IAABjkAgAAFXhKAAPmEAIAAXICD
Date:   Thu, 8 Jun 2023 15:20:15 +0000
Message-ID: <DM6PR18MB2844B37EE5A5AB7005EECCB3AF50A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
        <20230511175609.2091136-1-fan.ni@samsung.com>
        <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
        <20230605175112.GA2290821@bgt-140510-bm03>
        <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230607183059.GA2354376@bgt-140510-bm03>
        <DM6PR18MB284486E36310719093C8A6D6AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230608104322.0000632f@Huawei.com>
In-Reply-To: <20230608104322.0000632f@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|CH0PR18MB4370:EE_
x-ms-office365-filtering-correlation-id: 22c14f73-3842-4272-d0ac-08db6833dca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoTu4Atv9lfGjPOHfO6YAHkoy0MtkQq/ZnkM0ilFcrB2mBDqKJMNXIhvI6NNm8w6unErh0tZTVsSsoMnL82HtVgw05ew7kiRvrGOl0O91LlTJkXiPSdmfsxhiE68KBFLxDUSSawMaltuDFVMOBI2vlJiFJ4BmkL2/84nf90p1q1iJs/GZ0o7zL0gpliY17JLwpExP1VnyWItI/GQuiN1pxKGzKCxY1CJhLdQL3XWJqIASmPn4VgJzIaWeewLGx8voFjcPvtwYoqxRPqrMPGmEdknwLhOtApKHJfM/Ld7a1AqN/551SKOMIcnH8YtPtzY2i3J56qNWxXUT8NP21U4kGkzDkPRFC3G6FTvwxsoU+OzbjNGUGTrybnejLDdlacYoNbmfFtz+HBmnZ5KzhDo8GygLmm19zLYUsfdI0ZY0tf/xdZXDyInIOPqU5LxtIxSPAXJ7nnHnvP4kwdRuKAY1zs/QxA6YrFA1wpohsrwm3kutke9O+b9LTC/EP3Z3u76qCVkBELivoAEg6iUUFZ9vIeswf+wL/ct0hqsaIsCHYVxRjaIgAs9fQg/P5o3nTW9WcrqqJIBx1tAwIpQ7vpO4jPH9/gVYjrEAdRiutNvO2OmvWFKHPkSHi5kbo8D2czKYa4JLQHbxi8yog5aXjjkZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(54906003)(66476007)(71200400001)(45080400002)(478600001)(52536014)(6916009)(5660300002)(8676002)(7416002)(38070700005)(86362001)(33656002)(8936002)(2906002)(30864003)(4326008)(64756008)(91956017)(122000001)(66446008)(66556008)(316002)(55016003)(76116006)(66946007)(38100700002)(41300700001)(83380400001)(26005)(6506007)(9686003)(53546011)(186003)(966005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cP3VNRHdnkCwCCODWpNrw8HE9w7XO9KS4DDwjLKyXgckKq0t0TGse4+EMD?=
 =?iso-8859-1?Q?AzQGzzfbW43kQy0YWXMrxaO0AY2r272omBH7gM0snRWivsYwz+KwEYr6cA?=
 =?iso-8859-1?Q?enfmzJLyT4yALa/HG0xWIzw950LTqsk56Ev85rwi/+SB2+sMVpTfwvoHcX?=
 =?iso-8859-1?Q?SHzpiqBSV/iED2QMRpPrVH4MTaa8SD+ykHN1wvCXOOdNjWrznZynrluWKv?=
 =?iso-8859-1?Q?qV/BtA5ha2JRzLVIAsi0LBfoMBZSlIl91fnyT42n2xmKHQMAPsP63OpjUv?=
 =?iso-8859-1?Q?0gnG/HB5kAxFzhaZ8ZS4JwODhbrV1KL6H2rKYgEW7SRrGiXMV1KycswIRO?=
 =?iso-8859-1?Q?UKPIFn2Yzo9fRRVm3KkhHMFaDwkVOsVwgkPqqZsvG8o20XTincphmV7O/P?=
 =?iso-8859-1?Q?bFzes8JFurTiVsV8w3+p/muFuD1UrmvQphbsN2cEf9eeKYb/lsr1ODdt61?=
 =?iso-8859-1?Q?BHNWiyC6LLfNQm6Iow2EvamR8v/ht2AGLcDMLFGaRljmiPegO5RrSuif2Q?=
 =?iso-8859-1?Q?Y8xKoXFL44ZvFAT4GqaimzNl/Q2S9y6JR2q11y4QzwYPP0PvoglqO8MQfe?=
 =?iso-8859-1?Q?x/WPCsF1rTQd0gZOBcVFMMLqXCZF1FdmvDJeOii2TRtSM/G1ezGjcEd12I?=
 =?iso-8859-1?Q?sZksUmgMPjhReUeQeB0cjmMNxtjdgVl1k1lbcvHNuq/XYlmJiG9mX/i+Ik?=
 =?iso-8859-1?Q?EIp8h1jBfZjOFU2cgVd1j/3qmjpf8+/9FSWWuztwnh2F64iREYw17mmYYU?=
 =?iso-8859-1?Q?/GLT0T0JiORJoKINgzrfjRxZer3ki8kXCvnPYymZCW2yapfcp2Kn9wTwV7?=
 =?iso-8859-1?Q?EEQ9ieQPJII7IGQN9j57tM0Q45cWSXuoKdvW873J/DzHbMqmfs0qyg9hqb?=
 =?iso-8859-1?Q?yGZ/8N4ozK0uhO0luxLaW7fZFicpkcfoFKAuOoXfSdV/4b0JcjJWuh4IBY?=
 =?iso-8859-1?Q?dYTz+zP7mRc22LH0U4W8rILGS0tChCws0woKEJpbBZ9R8PI8LNU9B8L8Jn?=
 =?iso-8859-1?Q?sCu5QO3BQHC/MLq+cuDJVfM/u0W55wAAT4peey1Ugala6McgZZ7lz0zApd?=
 =?iso-8859-1?Q?ZBCs5fFX9WWwo0HVDK3cdJ6SkkW6k0R+VEPXcDHy6dOLotNdtOMkzfhXOE?=
 =?iso-8859-1?Q?4Divb0Db4Yuct0AteirlytyDAS+5bTYBgG6+HOnzRlMuBhvYiMBROq44BF?=
 =?iso-8859-1?Q?327W18Y0wRp4asyLeqJNiGyJ7SRzxnUWAVF71G08UPhkmzxrIjclGp36dg?=
 =?iso-8859-1?Q?UXgC45aiyjYudtcLCpaQB1TlariGuAFvz/6opVS8nr7BM5RyM2bzzeXtUp?=
 =?iso-8859-1?Q?lXhRbxf5YkoAKlxO4Ar0LVFCT3kMAW8NKwX8uwjgrr+2qbB4ceMJtLIeTu?=
 =?iso-8859-1?Q?NU5QwEdo3tFsaWMATcWjpwz/ekc+pDGTcU56POjoPfEdPhoR6hRqyuBXmN?=
 =?iso-8859-1?Q?tM1ov9y4XFy/fdS73RfEV3yET9tFoVZjtlYi/QG/vb7yiyYw4FFKDd8YHM?=
 =?iso-8859-1?Q?UndIX2WU6OboIwWoW2y08cqZD8uSxUy9MtI3TELVBKZ++qTSNSjzpHmaKg?=
 =?iso-8859-1?Q?2raOeO+RtVY7rvCrMil3p8a+xJSFqoJjxwUwTibJajj5VQInpIV1rXI6lG?=
 =?iso-8859-1?Q?T/kEoneoRjIM0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c14f73-3842-4272-d0ac-08db6833dca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 15:20:15.7142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jP/o9F9u4/PppssvOthBrV4uo3ZHLT5kC7vgyxAEMPxiDaICTLYDbRmT0dP13BkJXM9IYgRvkeNYU7lnMQT5iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4370
X-Proofpoint-ORIG-GUID: cS7JNnRAagZPlvLGFpz8vfoX8cMGj6BP
X-Proofpoint-GUID: i0wW3mH_SPsuoiUCxD-gkhavMdvtylx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_11,2023-06-08_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Sent: Thursday, June 8, 2023 2:43 AM=0A=
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Cc: Fan Ni <fan.ni@samsung.com>; qemu-devel@nongnu.org <qemu-devel@nongnu.o=
rg>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>; gregory.price@m=
emverge.com <gregory.price@memverge.com>; hchkuo@avery-design.com.tw <hchku=
o@avery-design.com.tw>; cbrowy@avery-design.com <cbrowy@avery-design.com>; =
dan.j.williams@intel.com <dan.j.williams@intel.com>; Adam Manzanares <a.man=
zanares@samsung.com>; dave@stgolabs.net <dave@stgolabs.net>; nmtadam.samsun=
g@gmail.com <nmtadam.samsung@gmail.com>; nifan@outlook.com <nifan@outlook.c=
om>; Ira Weiny <ira.weiny@intel.com>=0A=
Subject: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu =
=0A=
=A0=0A=
External Email=0A=
=0A=
----------------------------------------------------------------------=0A=
On Wed, 7 Jun 2023 18:52:14 +0000=0A=
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:=0A=
=0A=
> From: Fan Ni <fan.ni@samsung.com>=0A=
> Sent: Wednesday, June 7, 2023 11:31 AM=0A=
> To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>; qemu-devel@nongnu.org=
 <qemu-devel@nongnu.org>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.=
org>; gregory.price@memverge.com <gregory.price@memverge.com>; hchkuo@avery=
-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-design.com <cbrow=
y@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@intel.com>; A=
dam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <dave@stgolabs=
.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; nifan@outlook=
.com <nifan@outlook.com>; Ira Weiny <ira.weiny@intel.com>=0A=
> Subject: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu=
 =0A=
> =A0=0A=
> External Email=0A=
> =0A=
> ----------------------------------------------------------------------=0A=
> On Wed, Jun 07, 2023 at 06:13:01PM +0000, Shesha Bhushan Sreenivasamurthy=
 wrote:=0A=
> > Hi Fan,=0A=
> >=A0=A0=A0 I am implementing DCD FMAPI commands and planning to start pus=
hing changes to the below branch. That requires the contributions you have =
made. Can your changes be pushed to the below branch ?=0A=
> > =0A=
> > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-20=
23-05-25__;!!EwVzqGoTKBqv-0DWAJBm!Vt5uIqwW-L4c4gh02ulI4M762JNQ3_aE9k9lb6Qlw=
E2xm6T23ic7ig7Y77i1VN7l_RX_ySIQhre_z7Q0JA$=A0=A0 =0A=
> =0A=
> Can you push changes to the branch directly? I think it is Jonathan's pri=
vate=0A=
> branch. However, I can fork the branch and rebase my patch series atop an=
d=0A=
> share with you the new repo if that helps you move forward your=0A=
> work.=0A=
> Let me know your thought.=0A=
> =0A=
> ss - I saw commits from others, so assumed you can. Since it is Jonathan'=
s private repo, I will step back and let him answer.=0A=
=0A=
I tend to apply stuff in manually rather than given more people commit acce=
ss=0A=
to that particular gitlab tree. =0A=
=0A=
Easiest option is to fork on gitlab and share the path of your own fork.=0A=
=0A=
I normally queue reasonably mature stuff up on my tree, but that's about ma=
naging=0A=
the series sent with intent of being applied upstream + providing a fairly =
stable test=0A=
branch.=A0 It's not intended as a general place for stuff in development (t=
hough I might=0A=
sneak out an extra branch myself from time to time if I want to talk about =
it :)=0A=
=0A=
Jonathan=0A=
=0A=
ss - Thanks ! I have forked Jonathan's repo on Gitlab and will work of cxl-=
2023-05-25 branch. I will apply Fan's patch manually and continue ..=0A=
=0A=
> =0A=
> Fan=0A=
> =0A=
> > =0A=
> > =0A=
> > From: Fan Ni <fan.ni@samsung.com>=0A=
> > Sent: Monday, June 5, 2023 10:51 AM=0A=
> > To: Ira Weiny <ira.weiny@intel.com>=0A=
> > Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jonathan.cameron@hua=
wei.com <jonathan.cameron@huawei.com>; linux-cxl@vger.kernel.org <linux-cxl=
@vger.kernel.org>; gregory.price@memverge.com <gregory.price@memverge.com>;=
 hchkuo@avery-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-desi=
gn.com <cbrowy@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@=
intel.com>; Adam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <=
dave@stgolabs.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; =
nifan@outlook.com <nifan@outlook.com>=0A=
> > Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu =0A=
> > =A0=0A=
> > On Mon, Jun 05, 2023 at 10:35:48AM -0700, Ira Weiny wrote:=A0 =0A=
> > > Fan Ni wrote:=A0 =0A=
> > > > Since the early draft of DCD support in kernel is out=0A=
> > > > (https://urldefense.com/v3/__https://lore.kernel.org/linux-cxl/2023=
0417164126.GA1904906@bgt-140510-bm03/T/*t__;Iw!!EwVzqGoTKBqv-0DWAJBm!RHzXPI=
cSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21LzAGN=
Ok$ ),=0A=
> > > > this patch series provide dcd emulation in qemu so people who are i=
nterested=0A=
> > > > can have an early try. It is noted that the patch series may need t=
o be updated=0A=
> > > > accordingly if the kernel side implementation changes.=A0 =0A=
> > > =0A=
> > > Fan,=0A=
> > > =0A=
> > > Do you have a git tree we can pull this from which is updated to a mo=
re=0A=
> > > recent CXL branch from Jonathan?=0A=
> > > =0A=
> > > Thanks,=0A=
> > > Ira=A0 =0A=
> > =0A=
> > Hi Ira,=0A=
> > =0A=
> > I have a git tree of the patch series based on Jonathan's branch=0A=
> > cxl-2023-02-28: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
github.com_moking_qemu-2Ddev_tree_dcd-2Drfe&d=3DDwIFAg&c=3DnKjWec2b6R0mOyPa=
z7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3Dw6dicn5kXEG4Imk6=
TpICIjdA6KJ-xt84dtHui-Y0fv5H13bijtzEvjxECKE5MHYf&s=3D3yeO9RN5FY3gPfO2y19X05=
7YeqRTTQTQNfNA-Gfir_Q&e=3D .=0A=
> > =0A=
> > That may be not new enough to include some of the recent patches, but I=
 can=0A=
> > rebase it to a newer branch if you can tell me which branch you want to=
 use.=0A=
> > =0A=
> > Thanks,=0A=
> > Fan=0A=
> >=A0=A0 =0A=
> > >=A0=A0 =0A=
> > > > =0A=
> > > > To support DCD emulation, the patch series add DCD related mailbox =
command=0A=
> > > > support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory =
device=0A=
> > > > with dynamic capacity extent and region representative.=0A=
> > > > To support read/write to the dynamic capacity of the device, a host=
 backend=0A=
> > > > is provided and necessary check mechnism is added to ensure the dyn=
amic=0A=
> > > > capacity accessed is backed with active dc extents.=0A=
> > > > Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is no=
t supported=0A=
> > > > , but we add two qmp interfaces for adding/releasing dynamic capaci=
ty extents.=0A=
> > > > Also, the support for multiple hosts sharing the same DCD case is m=
issing.=0A=
> > > > =0A=
> > > > Things we can try with the patch series together with kernel dcd co=
de:=0A=
> > > > 1. Create DC regions to cover the address range of the dynamic capa=
city=0A=
> > > > regions.=0A=
> > > > 2. Add/release dynamic capacity extents to the device and notify th=
e=0A=
> > > > kernel.=0A=
> > > > 3. Test kernel side code to accept added dc extents and create dax =
devices,=0A=
> > > > and release dc extents and notify the device=0A=
> > > > 4. Online the memory range backed with dc extents and let applicati=
on use=0A=
> > > > them.=0A=
> > > > =0A=
> > > > The patch series is based on Jonathan's local qemu branch:=0A=
> > > > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cx=
l-2023-02-28__;!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOI=
eUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21OO3UHEM$ =0A=
> > > > =0A=
> > > > Simple tests peformed with the patch series:=0A=
> > > > 1 Install cxl modules:=0A=
> > > > =0A=
> > > > modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem=0A=
> > > > =0A=
> > > > 2 Create dc regions:=0A=
> > > > =0A=
> > > > region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)=0A=
> > > > echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region=0A=
> > > > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity=0A=
> > > > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways=0A=
> > > > echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode=0A=
> > > > echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size=0A=
> > > > echo 0x10000000 > /sys/bus/cxl/devices/$region/size=0A=
> > > > echo=A0 "decoder2.0" > /sys/bus/cxl/devices/$region/target0=0A=
> > > > echo 1 > /sys/bus/cxl/devices/$region/commit=0A=
> > > > echo $region > /sys/bus/cxl/drivers/cxl_region/bind=0A=
> > > > =0A=
> > > > /home/fan/cxl/tools-and-scripts# cxl list=0A=
> > > > [=0A=
> > > >=A0=A0 {=0A=
> > > >=A0=A0=A0=A0 "memdevs":[=0A=
> > > >=A0=A0=A0=A0=A0=A0 {=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "memdev":"mem0",=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "pmem_size":536870912,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "ram_size":0,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "serial":0,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "host":"0000:0d:00.0"=0A=
> > > >=A0=A0=A0=A0=A0=A0 }=0A=
> > > >=A0=A0=A0=A0 ]=0A=
> > > >=A0=A0 },=0A=
> > > >=A0=A0 {=0A=
> > > >=A0=A0=A0=A0 "regions":[=0A=
> > > >=A0=A0=A0=A0=A0=A0 {=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "region":"region0",=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "resource":45365592064,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "size":268435456,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_ways":1,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_granularity":256,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0 "decode_state":"commit"=0A=
> > > >=A0=A0=A0=A0=A0=A0 }=0A=
> > > >=A0=A0=A0=A0 ]=0A=
> > > >=A0=A0 }=0A=
> > > > ]=0A=
> > > > =0A=
> > > > 3 Add two dc extents (128MB each) through qmp interface=0A=
> > > > =0A=
> > > > { "execute": "qmp_capabilities" }=0A=
> > > > =0A=
> > > > { "execute": "cxl-add-dynamic-capacity-event",=0A=
> > > >=A0=A0=A0=A0=A0 "arguments": {=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "path": "/machine/periphe=
ral/cxl-pmem0",=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "region-id" : 0,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "num-extent": 2,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "dpa":0,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "extent-len": 128=0A=
> > > >=A0=A0=A0=A0=A0 }=0A=
> > > > }=0A=
> > > > =0A=
> > > > /home/fan/cxl/tools-and-scripts# lsmem=0A=
> > > > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE=A0=A0 BL=
OCK=0A=
> > > > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=
=A0=A0=A0=A0 yes=A0=A0=A0 0-15=0A=
> > > > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=
=A0=A0=A0=A0 yes=A0=A0 32-79=0A=
> > > > 0x0000000a90000000-0x0000000a9fffffff=A0 256M offline=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 338-339=0A=
> > > > =0A=
> > > > Memory block size:=A0=A0=A0=A0=A0=A0 128M=0A=
> > > > Total online memory:=A0=A0=A0=A0=A0=A0 8G=0A=
> > > > Total offline memory:=A0=A0=A0 256M=0A=
> > > > =0A=
> > > > =0A=
> > > > 4.Online the momory with 'daxctl online-memory dax0.0' to online th=
e memory=0A=
> > > > =0A=
> > > > /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0=0A=
> > > > [=A0 230.730553] Fallback order for Node 0: 0 1=0A=
> > > > [=A0 230.730825] Fallback order for Node 1: 1 0=0A=
> > > > [=A0 230.730953] Built 2 zonelists, mobility grouping on.=A0 Total =
pages: 2042541=0A=
> > > > [=A0 230.731110] Policy zone: Normal=0A=
> > > > onlined memory for 1 device=0A=
> > > > =0A=
> > > > root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem=0A=
> > > > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE BLOCK=0A=
> > > > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=
=A0=A0=A0=A0 yes=A0 0-15=0A=
> > > > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=
=A0=A0=A0=A0 yes 32-79=0A=
> > > > 0x0000000a90000000-0x0000000a97ffffff=A0 128M=A0 online=A0=A0=A0=A0=
=A0=A0 yes=A0=A0 338=0A=
> > > > 0x0000000a98000000-0x0000000a9fffffff=A0 128M offline=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 339=0A=
> > > > =0A=
> > > > Memory block size:=A0=A0=A0=A0=A0=A0 128M=0A=
> > > > Total online memory:=A0=A0=A0=A0 8.1G=0A=
> > > > Total offline memory:=A0=A0=A0 128M=0A=
> > > > =0A=
> > > > 5 using dc extents as regular memory=0A=
> > > > =0A=
> > > > /home/fan/cxl/ndctl# numactl --membind=3D1 ls=0A=
> > > > CONTRIBUTING.md=A0 README.md=A0 clean_config.sh=A0 cscope.out=A0=A0=
 git-version-gen=0A=
> > > > ndctl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scripts=A0=A0 test.h=
=A0=A0=A0=A0=A0 version.h.in COPYING=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 acpi.h=0A=
> > > > config.h.meson=A0=A0 cxl=A0=A0=A0=A0=A0=A0=A0=A0=A0 make-git-snapsh=
ot.sh=A0=A0 ndctl.spec.in=A0 sles=A0=A0=A0=A0 tools=0A=
> > > > Documentation=A0=A0=A0=A0=A0=A0=A0 build=A0=A0=A0=A0=A0=A0 contrib=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 daxctl=A0=A0=A0=A0=A0=A0=A0 meson.build=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rhel=0A=
> > > > tags=A0=A0=A0=A0=A0=A0=A0 topology.png LICENSES=A0=A0=A0 ccan=A0=A0=
=A0=A0=A0=A0=A0 cscope.files=0A=
> > > > git-version=A0 meson_options.txt=A0=A0=A0=A0=A0 rpmbuild.sh=A0=A0=
=A0 test=A0=A0=A0=A0 util=0A=
> > > > =0A=
> > > > =0A=
> > > > QEMU command line cxl configuration:=0A=
> > > > =0A=
> > > > RP1=3D"-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-pat=
h=3D/tmp/cxltest.raw,size=3D512M \=0A=
> > > > -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tm=
p/cxltest2.raw,size=3D512M \=0A=
> > > > -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tm=
p/lsa.raw,size=3D512M \=0A=
> > > > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \=0A=
> > > > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,sl=
ot=3D2 \=0A=
> > > > -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa=
1,dc-memdev=3Dcxl-mem2,id=3Dcxl-pmem0,num-dc-regions=3D1\=0A=
> > > > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interl=
eave-granularity=3D8k"=0A=
> > > > =0A=
> > > > =0A=
> > > > Kernel DCD support used to test the changes=0A=
> > > > =0A=
> > > > The code is tested with the posted kernel dcd support:=0A=
> > > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/ke=
rnel/git/cxl/cxl.git/log/?h=3Dfor-6.5*dcd-preview__;Lw!!EwVzqGoTKBqv-0DWAJB=
m!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7l=
r21q5Iza3M$ =0A=
> > > > =0A=
> > > > commit: f425bc34c600e2a3721d6560202962ec41622815=0A=
> > > > =0A=
> > > > To make the test work, we have made the following changes to the ab=
ove kernel commit:=0A=
> > > > =0A=
> > > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c=0A=
> > > > index 5f04bbc18af5..5f421d3c5cef 100644=0A=
> > > > --- a/drivers/cxl/core/mbox.c=0A=
> > > > +++ b/drivers/cxl/core/mbox.c=0A=
> > > > @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CX=
L_MEM_COMMAND_ID_MAX] =3D {=0A=
> > > >=A0=A0=A0=A0=A0 CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),=0A=
> > > >=A0=A0=A0=A0=A0 CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),=
=0A=
> > > >=A0=A0=A0=A0=A0 CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOA=
D, 0),=0A=
> > > > +=A0=A0 CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),=0A=
> > > >=A0 };=0A=
> > > >=A0 =0A=
> > > >=A0 /*=0A=
> > > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c=
=0A=
> > > > index 291c716abd49..ae10e3cf43a1 100644=0A=
> > > > --- a/drivers/cxl/core/region.c=0A=
> > > > +++ b/drivers/cxl/core/region.c=0A=
> > > > @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_regi=
on *cxlr)=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cxlds->dc_list_gen_num =3D e=
xtent_gen_num;=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(cxlds->dev, "No of p=
reallocated extents :%d\n", rc);=0A=
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable_irq(cxlds->cxl_irq[CXL_EVENT=
_TYPE_DCD]);=0A=
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*enable_irq(cxlds->cxl_irq[CXL_EVE=
NT_TYPE_DCD]);*/=0A=
> > > >=A0=A0=A0=A0=A0 }=0A=
> > > >=A0=A0=A0=A0=A0 return 0;=0A=
> > > >=A0 err:=0A=
> > > > @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *c=
xlds, struct resource *alloc_dpa_re=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 dev_dax->align, memremap_compat_align()))) {=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D alloc_dev_dax_range(d=
ev_dax, hpa,=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resource_size(alloc_dpa_res))=
;=0A=
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=0A=
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rc)=0A=
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=
=0A=
> > > >=A0=A0=A0=A0=A0 }=0A=
> > > >=A0 =0A=
> > > >=A0=A0=A0=A0=A0 rc =3D xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_da=
x, GFP_KERNEL);=0A=
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c=0A=
> > > > index 9e45b1056022..653bec203838 100644=0A=
> > > > --- a/drivers/cxl/pci.c=0A=
> > > > +++ b/drivers/cxl/pci.c=0A=
> > > > @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_st=
ate *cxlds)=0A=
> > > >=A0 =0A=
> > > >=A0=A0=A0=A0=A0 /* Driver enables DCD interrupt after creating the d=
c cxl_region */=0A=
> > > >=A0=A0=A0=A0=A0 rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settin=
gs, CXL_EVENT_TYPE_DCD,=0A=
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_A=
UTOEN);=0A=
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT);=0A=
> > > >=A0=A0=A0=A0=A0 if (rc) {=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(cxlds->dev, "Failed =
to get interrupt for event dc log\n");=0A=
> > > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=0A=
> > > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_=
mem.h=0A=
> > > > index 6ca85861750c..910a48259239 100644=0A=
> > > > --- a/include/uapi/linux/cxl_mem.h=0A=
> > > > +++ b/include/uapi/linux/cxl_mem.h=0A=
> > > > @@ -47,6 +47,7 @@=0A=
> > > >=A0=A0=A0=A0=A0 ___C(SCAN_MEDIA, "Scan Media"),=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
> > > >=A0=A0=A0=A0=A0 ___C(GET_SCAN_MEDIA, "Get Scan Media Results"),=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> > > >=A0=A0=A0=A0=A0 ___C(GET_DC_EXTENT_LIST, "Get dynamic capacity exten=
ts"),=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> > > > +=A0=A0 ___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),=
=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> > > >=A0=A0=A0=A0=A0 ___C(MAX, "invalid / last command")=0A=
> > > >=A0 =0A=
> > > >=A0 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a=0A=
> > > > =0A=
> > > > =0A=
> > > > =0A=
> > > > Fan Ni (7):=0A=
> > > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to outp=
ut=0A=
> > > >=A0=A0=A0=A0 payload of identify memory device command=0A=
> > > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dynamic capacity region represe=
ntative=0A=
> > > >=A0=A0=A0=A0 and mailbox command support=0A=
> > > >=A0=A0 hw/mem/cxl_type3: Add a parameter to pass number of DC region=
s the=0A=
> > > >=A0=A0=A0=A0 device supports in qemu command line=0A=
> > > >=A0=A0 hw/mem/cxl_type3: Add DC extent representative to cxl type3 d=
evice=0A=
> > > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add=
/release=0A=
> > > >=A0=A0=A0=A0 dynamic capacity response=0A=
> > > >=A0=A0 Add qmp interfaces to add/release dynamic capacity extents=0A=
> > > >=A0=A0 hw/mem/cxl_type3: add read/write support to dynamic capacity=
=0A=
> > > > =0A=
> > > >=A0 hw/cxl/cxl-mailbox-utils.c=A0 | 389 +++++++++++++++++++++++++++-=
=0A=
> > > >=A0 hw/mem/cxl_type3.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 492 ++++++++++++=
+++++++++++++++++++-----=0A=
> > > >=A0 include/hw/cxl/cxl_device.h |=A0 50 +++-=0A=
> > > >=A0 include/hw/cxl/cxl_events.h |=A0 16 ++=0A=
> > > >=A0 qapi/cxl.json=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 44 =
++++=0A=
> > > >=A0 5 files changed, 924 insertions(+), 67 deletions(-)=0A=
> > > > =0A=
> > > > -- =0A=
> > > > 2.25.1=A0 =0A=
> > > =0A=
> > >=A0 =0A=
