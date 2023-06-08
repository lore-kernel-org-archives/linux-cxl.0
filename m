Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E75EC7EE29
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Jun 2023 23:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbjFHXjr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Jun 2023 19:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjFHXjp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Jun 2023 19:39:45 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D10358C
        for <linux-cxl@vger.kernel.org>; Thu,  8 Jun 2023 16:39:09 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358NXfmL015422;
        Thu, 8 Jun 2023 16:38:37 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3r30eu4p0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 16:38:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDhjj5Rn0aixYeo8gburb9TeoJxEGDrVhDS02WHxIfWcS0b5M2PcAbLGdCqMg70JtH2n14+cvexUtkg6vHl8BhGMoszUEJje2dLXVLzlaYDtIuE4AT25l73s+1yJEOpgszFel3Uq/EMFONsVX5hmnNXdowMK0hXRfVTn5vc8upiSrGD1liUZzalrMypxPhbH9Ai9jORz5lAEmODi5bPLbfK9WtUCfxIiAVY6NqEJYvpSqrNqphx7S2KEYwlOBD58Z7qmUmMuNyaFGn903DacyZsiU8DrZkfGsPQsC4PzRfWuNuhlEdAXokJyg+PYj6aofAMUrp5ePkRyabHeTs4XnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqudU0ZTntfT3B66GtBjQBfppds/44Z7krhtZDpOyKM=;
 b=OGaqL5JDT2VxFL84d2nD01DdwnW3+qcUnOf3KwguRDgK1IjNiIn0kfPTErtRfjTIVO6sknJVOp7tFfYctPW80IS0p+uXnE/B6WWmGoeSl+G+I+YNUgA8BFzbNPlgvsYbjCqaFbOuhD5yt+B9aSyzJYVqzl8SS4+SiqEPMsAtLx79/ByOfpQMrdoyqgKsYP9VbpyOA7ci9Tb5zI3OuT5fHf0+uOtGaCqYT8qX6YGaqXa5TUGsmCocOeZ5YiA0+yCtAy0/rEUNC3YN2fHN+MRBMZbe0gXMXHRacCfeV34APoEffD2ZICCIHG417rIMtkWGk/n8V1Ict3SOIpjSiY9IcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqudU0ZTntfT3B66GtBjQBfppds/44Z7krhtZDpOyKM=;
 b=Qfv5Pl1Q8+lNbIEdrQ/szQHyHDnUIMDFiB850mX91qN0pzy67PhHcHA/f25NG4gKAL9M77xLB9flLUPc1u3WI+wMpYHaU1k/0zrHXGl9zlyEK/KuMMT+NRpsXWDDc6m6CE5XPwKUbTuffdqh0z40vO5nfBLJTk6/p6c9QoX9N+k=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by CH0PR18MB4243.namprd18.prod.outlook.com (2603:10b6:610:ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 23:38:35 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864%6]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 23:38:34 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "<\"qemu-devel@nongnu.org\"" <qemu-devel@nongnu.org>
Subject: Re: [EXT] Re: Concept of LD-ID in QEMU
Thread-Topic: [EXT] Re: Concept of LD-ID in QEMU
Thread-Index: AQHZmZPzuyNYjWTGNkuynwSsq4z6h6+AtbmAgAABTICAANWcXA==
Date:   Thu, 8 Jun 2023 23:38:34 +0000
Message-ID: <DM6PR18MB2844E5BFADF8599A9393358AAF50A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
        <20230607221651.2454764-15-terry.bowman@amd.com>
        <DM6PR18MB2844C099FB0671E864AA953DAF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
        <20230608113153.000033ef@Huawei.com> <20230608113631.00007a53@Huawei.com>
In-Reply-To: <20230608113631.00007a53@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|CH0PR18MB4243:EE_
x-ms-office365-filtering-correlation-id: ca8bde74-2c6f-4d0a-e770-08db687979cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K13NI713BEDpCQr+WRNHA5lR4sN4y/hQ5Cb+ZB39q9WIn4TarsZITM7OAMx/4gImRgnYteEy43m5EaZor+Br3rDLU/sLpJ9Z37vm1Ya+NUPFkoKYBSisyNjLG7h144FJXVqq3tbXjvKK/YItOHbVlmPAMKiVEVhS50xy8Qzj9kzK10RXmWNxhyNNg5YxUdqDEuJiC1Q4mNeOLqJn0adfTbxjkRXkmUh84svyRE3/MSeH0g0PnP+H2ffaF9eCRPzaAMqMDFhAQGKZz4df6U4LUSppON7ccGxIs0LmK34WtR2LgMNFBexD3s7HWdbAkRiqTx2wdZWzk5WvKTgPSPqGJjx2OFdp4hzynm4mTYvP9PRv17dOhs+nE6RnAWT20IXvYD3JW4Eb8M/QIdi89lANmiLpBwsugGmCAY+e10+kJ5GgDgiHNKwz8MznqwiKvwcVxVQOwXYs7ovuundxYI+AGnTLwuGVdBYnQBHY5NS/OV7kS+7IlxwVvXGil6cMuH94Un+quOYo1YRhKrRdzWU0QaYGUd0VgZcoFD/rRdFQbHh+ljSe2dCwVM+MtV3IGAQ0MgSNoDhD3SjEEHSCVhByRhw7R/YIz6i3YJgRxXCISUg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(55016003)(316002)(122000001)(91956017)(478600001)(8676002)(8936002)(4326008)(66946007)(6916009)(66556008)(41300700001)(76116006)(66476007)(66446008)(64756008)(38100700002)(186003)(83380400001)(966005)(71200400001)(7696005)(6506007)(26005)(53546011)(9686003)(5660300002)(33656002)(86362001)(52536014)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fy2HFXfXU+4Xg981lDQcSAgwqJ0uUWu7foGoGAHpkEE1S5Rg+zyGzjSRWd?=
 =?iso-8859-1?Q?44EQ4TopBXXqd8XDsp7PlOTcBzxHbQolKODX7Didb3AdIMe/aCNLqz+17D?=
 =?iso-8859-1?Q?v4dl0mmjqSm3/CmafBSMCpxA/e1ScFzB5uDqSOdGZbgUoYWDLghOf3IROI?=
 =?iso-8859-1?Q?bIKoTJkJHaOaZ1GjjO4jBg6Vb6ajy9RgCVvvECJ30XhStuFHNm4PPiJ22Q?=
 =?iso-8859-1?Q?PFgGiatVWjm15qPIy/4iOKeVLtc05LKgn63dT68UcKr1XeUoQMDzK4VcQV?=
 =?iso-8859-1?Q?eP64hXdlayGareugLF0c27iu37yuSoFd5xr2r9XKQfy2/A1c6oT9M/M1iZ?=
 =?iso-8859-1?Q?FRYAdWhdzZvBRcplc7OHRKQKDRYEE9DebJde7l2VgOxZyXmOLtKjGQaUca?=
 =?iso-8859-1?Q?Kugzz87GGI/LYFw851YJuQuD7x7cS9O715ECv58tJJE4+5N84n51R6gy3Q?=
 =?iso-8859-1?Q?W53Yo9m7z5ixT2EYirreh25gZhGlzhQtWESFO24Lmg9pmHRxhQehC2d/F+?=
 =?iso-8859-1?Q?Z6lE05JiR3/MbOJGYaTy8uxdead5h5PRnQ0VIfxCBM5gflF3ripa8fruLt?=
 =?iso-8859-1?Q?kKWk4uuEJzUpw01d3oNgjSc3tCf4g3m6Y/zwZWhiG+s4nMGE+DmWSVpAbL?=
 =?iso-8859-1?Q?TFVa3eWa37/4tJWIYUqUgHx9HpVtnPcr/Tmhmh19WqUsWX0aj+hQW9b9W6?=
 =?iso-8859-1?Q?WOANpxy3VMV180hkkec0ojB32f0o79AJiWmfCihCJTXSc8DkoDH/6DE+ER?=
 =?iso-8859-1?Q?NHtx9Mp4wsRcQB8Um6R6W+vSauW/LOn3UDn2nLlwBQvbfTugFLsTw19Z1D?=
 =?iso-8859-1?Q?M6nb4GK2I4gOvP2VDy8m2AqI2R2BDsp734IqC2v3FqmgEq8dvvACb2nEdk?=
 =?iso-8859-1?Q?QwKmDll25YMT07H9XMsu0ACb/YZiABVKJAJ0r6LHTNOhlUrkXUqf+h6WB6?=
 =?iso-8859-1?Q?3RYQoblt9jDzebSOHFZtHKRJ5K/SOLHi8EYkprRRxpsi8Fz1ThtZtfkKz/?=
 =?iso-8859-1?Q?ZPLbCzvmHIFw8kLHzdLxDv4p/mPEAoBI/GL6/Pzp8/jVR8U1wygY1IVm/g?=
 =?iso-8859-1?Q?AGs5xyDn7eM0otSXblVFbEAjN/NuK0u45Fnav09RjMKTeAC32i9DkjOC/C?=
 =?iso-8859-1?Q?W/uCZaCWgDGTNZ0u8OH0/JvzTY4dLaYsBzzfMgRlx67ZN0K3cfXZeuc1vY?=
 =?iso-8859-1?Q?Z5Rra6FqFXh2R3x79Kn46aRM6/A+SNIxg90HakuDochIuPhKdAiM2FWNpb?=
 =?iso-8859-1?Q?bF3mfr00yfUrvXV/TkuAiP2DR621vK1m7MCeXDcWOBI15MDsqBIfNhxAJa?=
 =?iso-8859-1?Q?BZXB9nPjBx6gFWs03HyH9KXdMHHhNLvOwuG/B3Ov8XszlCOflXwkzGPUZ8?=
 =?iso-8859-1?Q?RcuevyxncgEQtHZJ7dCoSbXlMqxzMdnKIJRIlN265qweE/VsCHeGPxBh7u?=
 =?iso-8859-1?Q?s6uqpGECVMxs7CfA9VknRMxwEeUd1TYRrDIrnKLwRFDDsxArxx2FcSs6/n?=
 =?iso-8859-1?Q?KzWIcdjpG4S1bvjHbgI1ljejkYrf5Ej5MxnfnFbG1vDmvg5/TvyKCwBda3?=
 =?iso-8859-1?Q?RSLkN/S11GQU+tqKqfRjBUG1QxBSR2rHDcwC4dIdqmJjQHkYpI1UskQw5u?=
 =?iso-8859-1?Q?mGdaoQFI9970U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8bde74-2c6f-4d0a-e770-08db687979cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 23:38:34.6452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbXSmWBWJpIznka+cYtohUMw3XkRYJON3mpr0OQVYHb38bajzQTzKUTGXxsNuELJ4Txk7BPyE7cmY/xQwxqTgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4243
X-Proofpoint-ORIG-GUID: nGvU9dSSjkDgBDAGsG2NGKnGjylnDcog
X-Proofpoint-GUID: nGvU9dSSjkDgBDAGsG2NGKnGjylnDcog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_17,2023-06-08_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,=0A=
=0A=
Thinking a bit more, LD in CXL are PCIe endpoint functions. Therefore 1-1 m=
apping of cxl-i2c device per PCIe device is sufficient, and we use function=
 number in BDF as the LD-ID. Does it makes sense ?=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Sent: Thursday, June 8, 2023 3:36 AM=0A=
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>; <"qemu-devel@non=
gnu.org" <qemu-devel@nongnu.org>=0A=
Subject: [EXT] Re: Concept of LD-ID in QEMU =0A=
=A0=0A=
External Email=0A=
=0A=
----------------------------------------------------------------------=0A=
=0A=
Shesha,=0A=
=0A=
You've sent an email with the 'In-reply-to' set to one of Terry's patches.=
=0A=
Please check why that happened and make sure you don't do that in future as=
=0A=
it hides your unrelated thread in email clients and the archives!=0A=
=0A=
See=0A=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_linu=
x-2Dcxl_20230607221651.2454764-2D1-2Dterry.bowman-40amd.com_T_-23t&d=3DDwIF=
Aw&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4u=
nU&m=3DZMaAF9tkNCKfk8gYXMiPERZeIhavaQ7MdKtqCbShRF6w5ISrgHqAl6XDOONYbprZ&s=
=3DERVX40JlAgnvRvPLm8sYZalsYDbpUU7YAqI0Ol0faPI&e=3D=A0 =0A=
for example=0A=
=0A=
ss - Apologies. Will be careful.=0A=
=0A=
Jonathan=0A=
=0A=
On Thu, 8 Jun 2023 11:31:53 +0100=0A=
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:=0A=
=0A=
> On Wed, 7 Jun 2023 23:01:11 +0000=0A=
> Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:=0A=
> =0A=
> > Hi,=0A=
> > For DCD sideband there needs=A0to=A0be LD-ID. Is the following approach=
 acceptable?=A0 =0A=
> =0A=
> QEMU question so +CC qemu-devel=0A=
> =0A=
> > =0A=
> > =A0-device cxl-type3,bus=3Dswport0,volatile-memdev=3Dvmem0,dc-memdev=3D=
vmem1,id=3Dcxl-vmem0,num-dc-regions=3D2,ldid=3D0 \=0A=
> > =A0-device cxl-type3,bus=3Dswport0,volatile-memdev=3Dvmem1,dc-memdev=3D=
vmem2,id=3Dcxl-vmem1,num-dc-regions=3D2,ldid=3D1 \=A0 =0A=
> =0A=
> Those will be PCI functions at this level so you can't do this until we h=
ave more advanced switch support=0A=
> (it has to know about multiple VHs - right now we only support fixed conf=
ig switches).=A0 You could connect them=0A=
> to different switch ports - effectively that will be what it looks like w=
hen we do emulate a configurable switch.=0A=
> =0A=
> > =A0-device i2c_mctp_cxl,bus=3Daspeed.i2c.bus.0,address=3D24,target=3Dcx=
l-vmem0,cxl-vmem1")=0A=
> > =0A=
> > With this configuration, the same i2c device is handing both LDs and in=
 FMAPI commands we use the LDID specified above.=A0 =0A=
> =0A=
> This effectively becomes a partial implementation of either an MLD or an =
MH-SLD=0A=
> To manage the actual memory access, those will almost certainly need a bu=
nch of other shared=0A=
> infrastructure.=A0 So I'd ultimately expect the i2c_mctp_cxl device to ta=
rget whatever=0A=
> device represents that shared infrastructure - it might be a separate dev=
ice or a 'lead' type 3 device.=0A=
> =0A=
> So I'm not sure how this will fit together longer term.=A0 We need same i=
nfrastructure=0A=
> to work for a mailbox CCI on a MH-SLD/MLD as well and in that case there =
isn't a separate=0A=
> device to which we can provide multiple targets as you've done in your pr=
oposal here.=0A=
> =0A=
> So I think we need to work out how to handle all of (I've probably forgot=
ten something)=0A=
> X marks done or in progress.=0A=
> =0A=
> X 1) i2c_mctp_cxl to an SLD (no PCI Mailbox definition for this one)=0A=
>=A0=A0 2) i2c_mctp_cxl directly to an MLD (your case)=0A=
> X 3) i2c_mctp_cxl to a fixed config switch (single fixed VH no MLD capabl=
e ports)=0A=
> X 4) PCI mailbox via switch CCI device that fixed config switch (no MLD c=
apable ports)=0A=
>=A0=A0=A0=A0=A0=A0=A0 Even with this simple design some fun things you can=
 do.=0A=
>=A0=A0 5) i2c_mctp_cxl to a configurable switch (probably a separate as ye=
t to be defined management interface - that messes with hotplug)=0A=
>=A0=A0 6) PCI mailbox via switch CCI to configurable switch (again to defi=
ned management interface).=0A=
>=A0=A0 7) i2c_mctp_cxl to an MH-SLD - probably to which ever device also h=
as support for=0A=
>=A0=A0=A0=A0=A0 tunneling to the FM owned LD via the PCI mailbox.=0A=
> X 8) PCI mailbox on MH-SLD tunneling to the FM owned LD.=0A=
>=A0=A0 9) i2c_mctp_cxl to an MH-MLD - similar to above - this one isn't th=
at much more complex than MH-SLD case.=0A=
> X 10) PCI mailbox to MH-MLD - similar to above.=0A=
>=A0=A0 11) Tunneling via the switch CCI (then over PCI-VDM - though that d=
etail isn't visible in QEMU) to an SLD=0A=
>=A0=A0 12) Tunneling via the switch CCI (then PCI-VDM) to an MH-SLD and on=
 to he FM owned LD.=0A=
>=A0=A0 13) Tunneling via the switch CCI (then over PCI-VDM) to an MLD / MH=
-MLD=0A=
>=A0 =0A=
> Current i2c_mctp_cxl covers 1 and 3=0A=
> I'm part way through the tunnelling support for (8 and 100) - need to rev=
isit and wire up the switch CCI PoC=0A=
> properly which will give us 4.=0A=
> =0A=
> 2 needs MLD support in general which we could maybe make work with a stat=
ic binding in a switch but that=0A=
>=A0=A0 would be odd - so we probably need to emulate a configurable switch=
 for that=0A=
> 5,6 need configurable switch=0A=
> 7 needs same as 2 plus tunneling part similar to 4=0A=
> 9 again probably configurable switch for the MLD part to make sense=0A=
> 11 is fairly straight forward - but not done yet.=0A=
> 12 also not too bad, but needs the MH-SLD part to be fleshed out (some wo=
rk on going )=0A=
> 13 needs pretty much everything defined.=0A=
> =0A=
> Trying to get the command line interface and device model right until we =
have PoC code=0A=
> for a few more cases is going to be at most a draft of what it might look=
 like.=0A=
> =0A=
> So in short, lots to do.=A0 For now feel free to hack whatever you need i=
n to be able=0A=
> to test the FM-API side of things, we can move that towards a clean comma=
nd line definition=0A=
> once we have one figured out!=0A=
> =0A=
> Jonathan=0A=
> =0A=
> =0A=
> > =0A=
> > Thanks,=0A=
> > Shesha.=A0 =0A=
> =0A=
> =0A=
