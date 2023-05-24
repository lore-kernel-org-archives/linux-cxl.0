Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D127C77B7C
	for <linux-cxl@archiver.kernel.org>; Wed, 24 May 2023 17:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjEXRs6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 May 2023 13:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjEXRs5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 May 2023 13:48:57 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328AF123
        for <linux-cxl@vger.kernel.org>; Wed, 24 May 2023 10:48:55 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OCLNZ1024229;
        Wed, 24 May 2023 10:48:40 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3qsh90hfrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 10:48:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCu75O0EUSnO4Qsaij8iJeWi07Tlg8e4AdblnqSBLPM+fk6g2tlzhWAv1/QMbbuTkzj6/SEGsdCR/6izpyQeEdBc1CPSQm+JUiJtQm9E0BhSbl9Tn09BNjtQkWKV9ag5VkY9JPuu/LMYPS2c8P3D2O6xHFu0MxY3ASptUm2BFgvnjOIEBUd4nsdRiEGEc1n7Pzu8SQqlhcFgeuv0AABW4GNNoOtiygm20j9Vg01EifVMjE7a3DSO3OVzLdwzn+4moYHn4CIX0Y0zbzPntqEeYbB5hDeJ17n3kZE8B2yA5l9IA6dL8WoaMUpg7Eo4Pnmd2UKQO95dsXX1AOZckFpb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMxFemn/uaJys/0Laf4IxBWKMlWnkZ71QKpT0YiuM9Y=;
 b=kVT05F3fg+dW78YBJkw8S4z75iRMVm9+1rpjyGFKoKBiD1T/Pw5lbQY8AQtEMsADA8rqpud6C1esF6vJQ3VgsARDebqT6wiz6oGFe1kQ/XMwT8fFn2rz3P4OfvDATUPNwxzDrNcTHNSaA6Kpq9Nauh9H2iUcwzTYIcnITs4hyfYnPvxDPvtI0Jxr9e24OX5PF5BSvVteKwFt5KmnW99MJZJGORJ2ybkFRNWJdZawbUaJUJf6b0RdRL99zQoonLgL1babJww9OTGT1qBCSOjhDtRUezQ4v6jBJtA0lq+72FvVYeQH7T5mnaBWaR+H9g6fVUyN524V6T2lriNxKYmtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMxFemn/uaJys/0Laf4IxBWKMlWnkZ71QKpT0YiuM9Y=;
 b=mu/lsXusmnTCDagwSlQ3WDCLQ8TVq4jTLz6/AE1TGZ5zo0QloneoNAPEl6XMLus/2geBRox+7dGyu05lwi8M6S4TXQAHmizPa2IRR1zLhTZZQvyV94xfTwBLh6FyO7VySpY141eE5L8YkInVgPy8uAevA7u0TaUaLpYisNIRZ80=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by PH0PR18MB3942.namprd18.prod.outlook.com (2603:10b6:510:28::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 17:48:35 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::ca52:1038:43b4:2fdf]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::ca52:1038:43b4:2fdf%4]) with mapi id 15.20.6411.019; Wed, 24 May 2023
 17:48:35 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Thread-Topic: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU
Thread-Index: AQHZiomHd0qPqIKI60KGfLR7fTfylq9mYfCAgAIOkUeAATcUAIAAEvKD
Date:   Wed, 24 May 2023 17:48:35 +0000
Message-ID: <DM6PR18MB2844EBEBA8D10343B6DB763EAF419@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB2844C8CDBF085BE599F98EBEAF7C9@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230522154135.00002be3@Huawei.com>
        <DM6PR18MB2844ED837509545D7BCE93D2AF409@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230524173938.00002d7e@Huawei.com>
In-Reply-To: <20230524173938.00002d7e@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|PH0PR18MB3942:EE_
x-ms-office365-filtering-correlation-id: a1a11b6b-ef48-42a1-0589-08db5c7f1910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N+O9VS5KO9Vg2+5CT1nsBhl0VjfnLhWKpbvvKY5HxCtljsTOHyNutu1DYPrBZZm8wE+9sqR8e6zYtve/L/9BqbJKCTZXwa5k4/oFnCg0and9PMJr0VGuR284u+3C8sJoK7dqDGdjY8GWGPWhEbxg+GMtoEEudgIuTMUacYZ8Y4Al8i25PcG/UC+GjGGlGI/fRaerzuarnZf2bt+gipyvCv3mrqJQt03XmOMZQ1ekctzZY+ee3MNJBHiTP+hA47qj2Psv4TrUBPpRXIudrLUucu4AACyfcBozl0xYXlwk3h5dNXb1EEuJDVUfyKviERxULrxown6XqM/qxb8ttZuMx6Q/oYfpWYPIUT6SCTzVAFtOLV6fv8iUje2f+NCqxjhX8yQeDSgxiOFGCpIAXZRFEEovH512R8kuCizMpNbrC4joH1FGweResmD4XZmNCH5K/pmsGwCBNg1t51ylXQ7ymJWdeJC9mfGkXaP8fBLJ5ZXqT3/tOPxB2gvzqa1KTIOazyrf3hjSBDa5b7xTiyHgLTynt3LFR8HAagCpIGf3RPwfp16kEOdgZl/EOV/osTpIDLlI2NKit9zwrd6LZncgio6VO6z56LIx80BTh8g6c3U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(83380400001)(6916009)(4326008)(91956017)(66946007)(64756008)(66476007)(66556008)(66446008)(7696005)(966005)(9686003)(76116006)(6506007)(26005)(478600001)(53546011)(186003)(2906002)(86362001)(8676002)(8936002)(71200400001)(5660300002)(33656002)(316002)(122000001)(38100700002)(38070700005)(41300700001)(55016003)(52536014)(84970400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rRhsxtYIhtnncc4zGXG6IXjJwewBNficP6ggDYneuA4dXb4zS6o+QALeQM?=
 =?iso-8859-1?Q?rhHPs5eVdnhEauyE3Jhnqy9DYL4zFQYUdpruxyBtgWRv2pOQic49MXH+7i?=
 =?iso-8859-1?Q?MmTzuwdxvD7z7ffXcJvH4AsmOg4gvWhQj+jF3YW/p9uNooaiYUBf/8P83B?=
 =?iso-8859-1?Q?M2noMClKyD8em7bsgAtbzDNT94c2UOOb9qMxYYWytBkH7lt5QqDnmq+WX+?=
 =?iso-8859-1?Q?kwkpzRWGjNWUf8QdwW2KfiRpxIUcuFTQhZJubZHZ6q8H8dTsr7pTwF0vun?=
 =?iso-8859-1?Q?L1PXPdbe1jE5meJ3+1YeOqs9k1QclTaZLyWMpSCXIIE3WZmlKonCL3eEbT?=
 =?iso-8859-1?Q?Xrc5aKm7+aNHz5x1bWxp1ceLHrnRt9P7tka3ukqylPIMw21BpmFC3hDuJb?=
 =?iso-8859-1?Q?WFsNHFcIO/CfCFydoMyTP17nOawf6hUqdO/bpuPPfXmPIjgcWVVS1i2ibq?=
 =?iso-8859-1?Q?I8kfCjCtsI73yPdbozUiokf/XVwpTiHGV3ednS1qRaMHXDkgNGNkYeDjkt?=
 =?iso-8859-1?Q?5wwSPZKxqBYy5hoPI1sG6KPFDbfxRog7M7TeW8vo2Py8KK5xZbON4TRl7Q?=
 =?iso-8859-1?Q?x9miMSfP+6TGoke9DlYKojPLjiAdPxVte/y07KpI0d6cS4yth5rvgD13HK?=
 =?iso-8859-1?Q?LJZFqjNYQzGkgBiCi8ATi3GjrWrFb5v0E8fFKciEAgDn+frbEOyjJKIR4j?=
 =?iso-8859-1?Q?W0vjSGZBsvXY3pufHvvsgDGeBK0nne5/XwoxwZTkDo2GS3vBUYBgjlj+Ch?=
 =?iso-8859-1?Q?ZMZN2RbYl7FRearn7MXdqNc8RG53K6la6LHqGDCsdI1d1AKlljNxdjoIYk?=
 =?iso-8859-1?Q?mIczPZzmMwCw7H9g0/Wk6F0FNZeofN40Zr0jX579ku93N4Kn3tOr0TsxRf?=
 =?iso-8859-1?Q?wMW0W50yKe1H3sVfG12OdKrDjBr++UbsWmvPX2sAAnUkaP7y038jRxPbnM?=
 =?iso-8859-1?Q?j4fTgtdBZT7vOtqEfqza+JCb+V4emvmc+l2hrnGxmEJFROK4RxDQbWDWNP?=
 =?iso-8859-1?Q?3Etq9gL1wfqZfDc39J87uwc/gtBKPGMV6zvR7qqGW3MfSog5jFFFtAINwH?=
 =?iso-8859-1?Q?SCV1/RsQZ9MZDjwICCthxQHCzL7JfXE1WlU21+UN6oFQo/BYjYbMsdhJAv?=
 =?iso-8859-1?Q?ivSk34Lsk8IdC/s+tgumJlatlm5vOitnln2/zZr31+plPC44vL3CYKFQ3Q?=
 =?iso-8859-1?Q?Chvozdm5JC2wGuRalZ17q5edxHhucYtS1gEuTgE4KymhLdABVjLWVpG0xq?=
 =?iso-8859-1?Q?f6QfM9q45NNyWX2jR8pes7H5S2YY4Il5WF4aXhAPTrKWx8FQ3QR6VRzz98?=
 =?iso-8859-1?Q?KEb4IuI9jNWd9um5SMk6CfunBd5m+L01ToMdsydwYZFHWWkVQA4UGD86H3?=
 =?iso-8859-1?Q?RH/rwEM1Psc0c5+dW81MoCa8k4aYp1lgMmtcCcMKggKcG206qb7UKczT+d?=
 =?iso-8859-1?Q?JeAtxfSFZvfXvqDit4nJoc71AZI7veyoEECSvO4lXWcIsInJTNYs+y2puD?=
 =?iso-8859-1?Q?ftXfB60fiNSNCXXVkSNaS5LLC6bLp7cBT0CYQNuBWVu054ruPlIAuTOuC6?=
 =?iso-8859-1?Q?08kzl6YRCcXUzihj3bxH8xEw4SBFNJGfAbz0/aVQTx0P/sAoMuknpoqe7W?=
 =?iso-8859-1?Q?DtOIM4SC6Y7HA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a11b6b-ef48-42a1-0589-08db5c7f1910
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 17:48:35.3537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4p2eq/wUH3+MTk0M/Ogoh0IVNiNuS4w0LdY70CJTt3Fwa+3uIVe24L7CunJnVXW6zqzwB5I8vDgskV01FKnzTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3942
X-Proofpoint-GUID: Oa25a5KNg0sJDEPJKMra9jevfaWtsAzH
X-Proofpoint-ORIG-GUID: Oa25a5KNg0sJDEPJKMra9jevfaWtsAzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_11,2023-05-24_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Sent: Wednesday, May 24, 2023 9:39 AM=0A=
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>=0A=
Subject: Re: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU =
=0A=
=A0=0A=
On Tue, 23 May 2023 22:08:21 +0000=0A=
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:=0A=
=0A=
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
> Sent: Monday, May 22, 2023 7:41 AM=0A=
> To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
> Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>=0A=
> Subject: [EXT] Re: I2C Multi-master and Controller Slave Mode in QEMU =0A=
> =A0=0A=
> External Email=0A=
> =0A=
> ----------------------------------------------------------------------=0A=
> On Fri, 19 May 2023 19:43:25 +0000=0A=
> Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:=0A=
> =0A=
> > Hi,=0A=
> >=A0=A0=A0 Is there any implementation of I2C Multi-master and Controller=
 Slave Mode in QEMU for x86 ?=0A=
> > =0A=
> > What I want is to create CXL-I2C device that can exercise DCD commands =
via FM-API. For that I need a bus that can support both master and slave on=
 x86. Is there one available ?=A0 =0A=
> =0A=
> I have a side project underway to make this work.=A0 It will be a little =
'unusual'=0A=
> as it'll bolt an aspeed-i2c controller with the right support onto an x86=
 host.=0A=
> Might take me a few more days to get that working.=A0 I have it up and ru=
nning=0A=
> with ACPI on an arm64 host (a few minor tweaks needed to the aspeed-i2c k=
ernel=0A=
> driver which I'll also post - mostly upstreamable but there are a couple =
of=0A=
> hacks for now).=0A=
> =0A=
> Currently that aspeed device is the only i2c controller that supports MCT=
P that has=0A=
> some patches on list to do everything you want.=0A=
> =0A=
> SS: I was able to get MCTP working on openBMC + ARM. But I was interested=
 in using MCTP on x86. I will look forward for your patch.=0A=
=0A=
I now have it running on both ARM (ACPI + DT) and x86 (ACPI).=0A=
=0A=
Needs a few hacks on the relevant i2c driver in the kernel and unfortunatel=
y at least=0A=
one of those probably isn't ever going to be upstreamable.=0A=
=0A=
However, that aside it all works nicely.=0A=
=0A=
ss: Thats great ! Can you please share the code, both QEMU and kernel drive=
r ?=0A=
=0A=
> =0A=
> > =0A=
> > The second question is, can qemu-cxltype3 device be used on ARM ?=A0 =
=0A=
> =0A=
> Yes, but you need the out of mainline patches from=0A=
> gitlab.com/jic23/qemu Use the previous dated tag though as latest has som=
e issues=0A=
> (bad choice of base which turned out to crash :)=0A=
> =0A=
> I'll be putting together a fixed version of that in next day or two.=0A=
> =0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gitlab.com_jic23_q=
emu_-2D_tree_cxl-2D2023-2D04-2D19-3Fref-5Ftype-3Dheads&d=3DDwICAg&c=3DnKjWe=
c2b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3DHjxYT=
jPnn1_sL7TKjONiz2tjg7Wgb2SHDpdPWugtqp91xBPuXM8apydEWLy-PNOA&s=3DKPl9oVgiVvY=
j9UcBRp7CohPsuEPicbpQzsFLV7uieOw&e=3D =0A=
> for now.=0A=
> =0A=
> That includes support for the aspeed-i2c controller but with dt only whic=
h isn't=0A=
> that helpful if you want to also use the CXL drivers.=0A=
> =0A=
> Anyhow, it's a watch this space for now. Hopefully I'll get the PoC code =
in a shape=0A=
> to share later this week.=0A=
> =0A=
> Do you mean to say, if I take patch from gitlab.com/jic23/qemu, can I boo=
t linux on ARM and use CXL kernel drivers ?=0A=
=0A=
Yes, though use a slightly old version for now as I think the latest one cr=
ashes for=0A=
reasons that I never tracked down (think it was just an unlucky base).=0A=
=0A=
Once I have done a tiny bit more tidying up of this MCTP stuff I'll get bac=
k to ensuring=0A=
there is a stable branch at that address and put the MCTP stuff on top.=0A=
=0A=
It's minimal at the moment:=0A=
* Identify from CCI command set=0A=
* A few FM-API physical switch commands,=0A=
=0A=
However that should be enough that it's fairly obvious how to extend it to =
add=0A=
lots more commands and hopefully others will jump in at that point.=0A=
=0A=
Main job I still need to do is write some docs on how to bring it up + user=
space=0A=
tooling to use etc.=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
> Thanks=0A=
> Shesha=0A=
> =0A=
> Jonathan=0A=
> =0A=
> =0A=
