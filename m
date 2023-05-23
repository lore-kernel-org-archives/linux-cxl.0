Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A32C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 22:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjEWWIi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjEWWIi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 18:08:38 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469CBF
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 15:08:37 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NKKx93029256;
        Tue, 23 May 2023 15:08:27 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3qrm46mw43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 15:08:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMRzv32L2KX9AvwtBU+mCa/rnzot43dsWNohESPzxo5Rlg91LhLpJFbku0GWtoxm4DWaa+30/U/qRVZ3yNIYknu9m/A/Juu+kHtHePp0b6st2Ij1ioqxkJeC+bAH2KXPLMcDQyFUjiJFD/lN7MZ4UVWJHwBTiG5mHzCp6euxch+mdWKCp/4cjP8HQgN4W9pFMUjPr/tWaAvqu8cjm3+MsPsBrKAXT1EAJEHI0EshW1DWw2pt+hIgpGcTP8t/m5IlD+qWgtug6isobDPjvWnzyVLe5oDs+YqRM+xpuPdI0m7Yv/pbUNjztO3L9Bd8xA/6FEOp0h7SKsXSAyApjB8wSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlY3pzhg/Sz8EQqtoGc6Uht8E57fCRMk36JBcsXmlQ0=;
 b=JvGD2c8hU/dj3SkTxDS7flLPu9fVvnLS6h+drETBihCUIM00Wsdj9yBSY5ckAUJs/WWR7ap+rNarBzyNitNN8bEXoV5bZbZv0ysOPCU6jPk5x+hs4Zzq7UT7vxQGFCk/j0dRFRIjC91s0l0OUr8Q1D8kup8QHDK/BlWVu1kvr693aLZ8OUOW50WpE6sk++rCxi++mQfE4Vfg8ohFMeS2igptU4ClJ1BUa6u/hde9CmFOGacJbQgsC3frjrRxhynkddWOPOAgRsePIXcqMa8MAiYNyx0NIV2Yj87jNc1lQQ13BxqG1pwbcMcmSSWjn1nIWRtcLALs/lsKPjBF+AwdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlY3pzhg/Sz8EQqtoGc6Uht8E57fCRMk36JBcsXmlQ0=;
 b=Nsf15oLGBtp8IVKJ7oasI8kFPAti6WWS97Eq0G+pow0zFmpjsPWzcnVo8cb+TaVWL0SD00P5iaA4lA367AJGiPnb/kNO+m+/24+qCGnF8Hew6zXVK7j/zEuhuuMywc/Ji6B3yEXzlp+4OlPPizeImBViwOjhEWsvJYNwb5mcok8=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by SJ0PR18MB5162.namprd18.prod.outlook.com (2603:10b6:a03:439::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 22:08:21 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::ca52:1038:43b4:2fdf]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::ca52:1038:43b4:2fdf%4]) with mapi id 15.20.6411.019; Tue, 23 May 2023
 22:08:21 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Thread-Topic: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Thread-Index: AQHZiomHd0qPqIKI60KGfLR7fTfylq9mYfCAgAIOkUc=
Date:   Tue, 23 May 2023 22:08:21 +0000
Message-ID: <DM6PR18MB2844ED837509545D7BCE93D2AF409@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB2844C8CDBF085BE599F98EBEAF7C9@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230522154135.00002be3@Huawei.com>
In-Reply-To: <20230522154135.00002be3@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|SJ0PR18MB5162:EE_
x-ms-office365-filtering-correlation-id: 01f4f08c-cd50-4c6e-5312-08db5bda386e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d47xK0VrJgfsqGOQ/GvP6o4mi96q4FEjtU106rmBz7xnWynhaIvoc1UCdY+Ay1Hfhpu+IywMLNBsA0Lr65PrmCoQgCJD4EWy1G5yNN4TmrtmYRrRPuEzRsjaXlXYTdBZCXSs1U/92Ikulg3eZp92BFFlqA6cYnL1yLi4F8tk7W77UAD5RI5od0wi2dERGiP4lvT4uvTrztLq+UZq/HD5n40DlcZPFn7vF+G6MQV9w/amXoDt6BBgtHHSFvdgRMLSlqgpsyTtg8ra9eYO07eWLljIFoGLDDiCIRh4kk27kge5o1gp/7D0XI27VF59bw1xeJLVtmcft/2wV6k4TMMhGwXvWNqOBLPn3zlg+08i5w6qXeLnp5AW1IpgH4DxVb9OgOL6YiwzLfUDMtCOO0HdTfzUC7OpDPVJm4PjsnQs70XWGDYLId7NHPZsK6PGMQnIdcsWaC4I+X15iXjvhC04/R3Koq6zvikVkxEnEeW0hsHhlF7kVmYEcQruu6Ba3LnCaRSUFoAlheU7GG2nLTqTvac1KrZP21eMe5Qo8H3YRoVtZvAVye6h/EIBYiqbmG2HcPdOKQab99xh52EV88skQ/kGAQdZ/CkT+qxA9sx0EDO5cnixYc5EbBqJgfZmgxnY4zNC2z63pxqsu9/lPJ0i2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(84970400001)(2906002)(5660300002)(52536014)(478600001)(8936002)(8676002)(41300700001)(64756008)(66556008)(316002)(91956017)(66446008)(66476007)(66946007)(76116006)(6916009)(4326008)(71200400001)(33656002)(7696005)(966005)(55016003)(6506007)(26005)(9686003)(38100700002)(122000001)(86362001)(186003)(53546011)(83380400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oGdOZif3zrQpChlpQZQLkL6sEK9STAybvdUNH20uap2WMt8TjdYkxijl/K?=
 =?iso-8859-1?Q?ZvxhkjaFRriHBn/3saMlkYdFQ3tEHvhmNo84KMLckMWzjxHu+mRG/4slhD?=
 =?iso-8859-1?Q?B3Gb4GOS3loxewb/hxV/N96cgcjikbkSKvxwkwRg8QjX4SeJZIaRpOkxek?=
 =?iso-8859-1?Q?dm2BscI3UU+GOVaoC0zZywGQdzCRjsHvJy9oICr8xpftmzYG7SCx67+RTv?=
 =?iso-8859-1?Q?rDsTQFMzn/6u13e0qg1oFLYpLs2vNJ0i371h76zHRLDAEQmCi4mRAtRCtS?=
 =?iso-8859-1?Q?LYyGLhkZHATUcaqzKAw3TWLiXRwt7+oWjpi2zuttmXBxegeKuUgY+2Rb4x?=
 =?iso-8859-1?Q?QxZ/6d8EBuh0+GiBQ0NNz6vgJvtHFW1GCTRQ6Ui3jVPAcplAhdWXkOqUdT?=
 =?iso-8859-1?Q?koAmDspyhTIripmuG5zzUEavmYA/3JTelBTw0k+oh/oWKt5do+HCB94MtP?=
 =?iso-8859-1?Q?LKhxmjPgDx+5dLJKYRDM9qoq1fwEVGmiLE8IVnV2wRHel/U16IYq+d+GEw?=
 =?iso-8859-1?Q?Ne5+qw5T613I/8CCIXYneEiZMVoAIYqV5jwLKdvqT/AeEAiBXrZj1M6WQU?=
 =?iso-8859-1?Q?xOCrWWjz4CYx2u78ndFStJ/yOxIsIseeVji2BBc7f+m6npmHJCoYCAg6Z7?=
 =?iso-8859-1?Q?PmqTbQdeunZh51vlpqW/zkmsilmZJn6SiIf5TxZujfmp5I9apJcftauht6?=
 =?iso-8859-1?Q?/kBoyv/zBC1hjm2sHeZBywGuSM2IjmQnxS683r16XmrfdczbxwXEZFxVTI?=
 =?iso-8859-1?Q?hf/p2Ct26771LO7yFJfyECSpeLzwqOb20W2MGzYNGXuwNwp0UHzgCPz6Rm?=
 =?iso-8859-1?Q?UlaJAxEkjJX7VrnWS9GLFYICmDD501FXepJd/hdULE54RR6UqQUs4CQCYw?=
 =?iso-8859-1?Q?ZzgjE0jpVW3KuG46ev5FTqDjDNUhSDVt7U5skI7Xj1VAIWPKRnQZwRIaZh?=
 =?iso-8859-1?Q?xkOTYVSqrNWcw0uIyG5GHkfXcm4FXyjG55ukYtNb0D4l9jlDRlIc32H46A?=
 =?iso-8859-1?Q?9JkvZuTMqdtKrh8a58X4dNinbdJv8okNaVwJu302HMZp9YAPZYYn4KyRsi?=
 =?iso-8859-1?Q?fFGyYhtSv/AxjfYVT0vu7rOYUwEo2+ZQHD3eXvAfiJ2xFzQ0SRTic+TvpV?=
 =?iso-8859-1?Q?KSWDNHccNiTb4hjW7tz2//GDbP+aMI+4n7NaK+lwhB2T/uZtNcHlVrsjLm?=
 =?iso-8859-1?Q?gytMwxpc92sqyG3ZSqycNQw63UsntPXQTGfc/oWHcebRCJErxRCrwuVVJ/?=
 =?iso-8859-1?Q?DFU7SWhxNm6aW96RureTDDLroNqCz3rkpsjqwhfRAoybq34pwFIHXDd7EQ?=
 =?iso-8859-1?Q?ppKGwF1egzayurJbzH5Gn5JrGDznrPxq0mDKguH1x77jlU1UMQOETwjRRm?=
 =?iso-8859-1?Q?JwzzmpVpU5LxDLkyx8iUi+3iJiibD8MhOTVRlKiKKNCf9s2SC/gzaJzGAz?=
 =?iso-8859-1?Q?hH9US/jN/dfdO4FWofRIMqEng0MuCqzxr2PoKZn3vns6vhRaH2LtGJCMrE?=
 =?iso-8859-1?Q?iwz/U0p/1JUm6H5U5eamnZ0+TeTS08XsavI/pSzDMgEG7EWtLpIPq1PK/g?=
 =?iso-8859-1?Q?NwfDUlP7km/4VeIvpKjhHbLSRtTXNkmOvoSgN8FlQ3VS4RXj5yvb+H+j6e?=
 =?iso-8859-1?Q?unBWzZzeVngfM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f4f08c-cd50-4c6e-5312-08db5bda386e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 22:08:21.0690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YN3Qn9JaInZB+BDm0zYcJBHWyb77dvplBun6xOK+VkhzXeQhW8B/i+6QYln3T0xtSlTEsqLUg2GPtvT5EtL15Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5162
X-Proofpoint-ORIG-GUID: 0oak1cjhg-ujXdc-g4gYwHqmyMN62pwb
X-Proofpoint-GUID: 0oak1cjhg-ujXdc-g4gYwHqmyMN62pwb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Sent: Monday, May 22, 2023 7:41 AM=0A=
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>=0A=
Subject: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU =0A=
=A0=0A=
External Email=0A=
=0A=
----------------------------------------------------------------------=0A=
On Fri, 19 May 2023 19:43:25 +0000=0A=
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:=0A=
=0A=
> Hi,=0A=
>=A0=A0=A0 Is there any implementation of I2C Multi-master and Controller S=
lave Mode in QEMU for x86 ?=0A=
> =0A=
> What I want is to create CXL-I2C device that can exercise DCD commands vi=
a FM-API. For that I need a bus that can support both master and slave on x=
86. Is there one available ?=0A=
=0A=
I have a side project underway to make this work.=A0 It will be a little 'u=
nusual'=0A=
as it'll bolt an aspeed-i2c controller with the right support onto an x86 h=
ost.=0A=
Might take me a few more days to get that working.=A0 I have it up and runn=
ing=0A=
with ACPI on an arm64 host (a few minor tweaks needed to the aspeed-i2c ker=
nel=0A=
driver which I'll also post - mostly upstreamable but there are a couple of=
=0A=
hacks for now).=0A=
=0A=
Currently that aspeed device is the only i2c controller that supports MCTP =
that has=0A=
some patches on list to do everything you want.=0A=
=0A=
SS: I was able to get MCTP working on openBMC + ARM. But I was interested i=
n using MCTP on x86. I will look forward for your patch.=0A=
=0A=
> =0A=
> The second question is, can qemu-cxltype3 device be used on ARM ?=0A=
=0A=
Yes, but you need the out of mainline patches from=0A=
gitlab.com/jic23/qemu Use the previous dated tag though as latest has some =
issues=0A=
(bad choice of base which turned out to crash :)=0A=
=0A=
I'll be putting together a fixed version of that in next day or two.=0A=
=0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gitlab.com_jic23_qem=
u_-2D_tree_cxl-2D2023-2D04-2D19-3Fref-5Ftype-3Dheads&d=3DDwICAg&c=3DnKjWec2=
b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3DHjxYTjP=
nn1_sL7TKjONiz2tjg7Wgb2SHDpdPWugtqp91xBPuXM8apydEWLy-PNOA&s=3DKPl9oVgiVvYj9=
UcBRp7CohPsuEPicbpQzsFLV7uieOw&e=3D =0A=
for now.=0A=
=0A=
That includes support for the aspeed-i2c controller but with dt only which =
isn't=0A=
that helpful if you want to also use the CXL drivers.=0A=
=0A=
Anyhow, it's a watch this space for now. Hopefully I'll get the PoC code in=
 a shape=0A=
to share later this week.=0A=
=0A=
Do you mean to say, if I take patch from gitlab.com/jic23/qemu, can I boot =
linux on ARM and use CXL kernel drivers ?=0A=
Thanks=0A=
Shesha=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
