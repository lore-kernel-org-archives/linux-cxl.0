Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0AC7EE29
	for <linux-cxl@archiver.kernel.org>; Sat, 10 Jun 2023 00:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjFJA3u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Jun 2023 20:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjFJA3q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 9 Jun 2023 20:29:46 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA571734
        for <linux-cxl@vger.kernel.org>; Fri,  9 Jun 2023 17:29:44 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359Ef627026529;
        Fri, 9 Jun 2023 17:28:35 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3r462d1u94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 17:28:35 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35A0PpwD019776;
        Fri, 9 Jun 2023 17:28:34 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3r462d1u92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 17:28:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em8bzvyINFTCkxOTd/81bJc1CQaywW9m+3rVFcQ//AO8N6KJGXfMXjNRRFMqH7vmeLpKiypXnTLicXHV757AwC7jYewhPuQIhd9pGAWLR5By5or+uqWT2o7YNfYlWrg59Pn/gMbIqnpew402fX6RESHlr8kiUcFdnB2Vmcgy7hoAsk2+XJjQy5FTad8BIVCua6Mf2hoxLhdD65IJZclKwXAaVVZR5n/0qbtVZMYLL/xsWJ7bFwNGFeqDPDs4P9bDr5oRd8tj4uhhPd7qprMnuGROmpgu78j+vgtHqHlec+Xb9VorUslIMPZlrvjEpy6+rJpQxOyxXZhisv2sJ1RPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRecr593fS6PMmE3kMIp9F/XNaP0KigsCmAU8LJyO+s=;
 b=FpP0nG0n1e+q3Q596fwORYib5xrtIxbyvUcP3w0DiUjU06qVjrrsbzvR8DWXpiolIMPaYSdc8RwUINcbI03Rni1Z1yZtM5Ycz41e/mkd6enK6GFlR2rYJqXl8Y1yoc4YeHHQZ6mTdL1BJOPELy5bf+1QM5M+4niguVP7Io10SFEKRPS5AD0jU4mdlrmlbrBfBRVGh1vSd2iEPks3S+tU69z97r32rIba/iZIaFvnPB3GIPAl/UaXetiTRiggLoUyV7AsyIaqnTFg8E7/Lpb+WrGpIAYf69z0Cw4ZeBLysUv9NgoV5AXsv5dPein+yAW6N8kb/i3BoYgnXKfyIwhylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRecr593fS6PMmE3kMIp9F/XNaP0KigsCmAU8LJyO+s=;
 b=V1ZqdpivYinZo2Mhc79V1K4IZJwtfpc07d5Z7gutvi3f0OY5rR3Mp2swmoR7x4f63JhZ5TAiZsyX2Lv2cVaqo0J9qSum/IZD1gdvuDSWzmuEsQHCeUOrNjhtxijvoPKL46vXJ7j1cYNTmRlJXaFp2IiWe5hyYIjb0cAxvODZRoo=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sat, 10 Jun
 2023 00:28:31 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864%6]) with mapi id 15.20.6477.016; Sat, 10 Jun 2023
 00:28:31 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        "nifan@outlook.com" <nifan@outlook.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>
Subject: Re: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOK98n/AAgAAEVoCAAymO8IABaaOAgAApGQCAAcOuAIAAN6Fj
Date:   Sat, 10 Jun 2023 00:28:30 +0000
Message-ID: <DM6PR18MB2844046EB9F1FDAC6116A188AF56A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
 <20230511175609.2091136-1-fan.ni@samsung.com>
 <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
 <20230605175112.GA2290821@bgt-140510-bm03>
 <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <6481f70fca5c2_c82be29440@iweiny-mobl.notmuch>
 <SG2PR06MB3397ED98E693C77C97345792B250A@SG2PR06MB3397.apcprd06.prod.outlook.com>
 <6483946e8152f_f1132294a2@iweiny-mobl.notmuch>
In-Reply-To: <6483946e8152f_f1132294a2@iweiny-mobl.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|MW4PR18MB5244:EE_
x-ms-office365-filtering-correlation-id: 8bcf865b-08cc-4bf7-8326-08db69499e2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFG3sKPdF0j6guWqa0PGsOOzSf1fAyvIK1NdWxjEwlkx44G2+itlq5bY4nS22jS/hGm0VSmNP7B18vpWVpRJkd4/TYhKPJLXcNB1CJxCkr4uXDoloIdvX/DOPLTetDAGjz5Nzug6CPseIK+fMuk9VcU3vf0biK14wyrtSnJnMA7jCpx1TiNZgpvqybEgsMOjWBIbgol6W8xuhVsiL/X7+AiBh+mney6srUYo8kuKJbcQsQFiDmGtXz9TeKbWtw3HK1Ra+brWgxCukYZ0fIbpVDujcE7mMWU35fIylHiRHuQTRaNlE68UbcyG4jLwsMdzbEDXGJ/KOZXIuQ+w3ndGShfBKfMotNZJl75To63YzP0HbLdFyocR09kDbK63L3HoqxdYd9QnBwgzAISHPj0ttXllNmAaaP8CviNjUYSJU5HMhz7FkyUze9EetGs0Ili7zJn8vd/FGixYoc97KiLS8JTyCe5vt7idRBJdlrLyVGrIU02K4TH8VVXw+O3CXokPwFtyPCchBf5aZ93O+Cnl8kqaOTf1GxGstN83jaMe7rQMTVx0s/99oTPRFZKW8UXEp/W7ywSIECOxvW9BZESAKFPHP7jLf2d9ejux01XHOoIYGWyevK9mTxk/Fbi7Jf52OoMtcF85XO2DfZg3mgQO8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199021)(55016003)(122000001)(316002)(110136005)(54906003)(91956017)(478600001)(8676002)(8936002)(45080400002)(4326008)(66946007)(66556008)(76116006)(66476007)(66446008)(64756008)(41300700001)(38100700002)(186003)(83380400001)(71200400001)(7696005)(6506007)(53546011)(9686003)(5660300002)(966005)(26005)(33656002)(86362001)(52536014)(7416002)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Jnjn8AgHMFa4xLAKSpozDRcLYni/HjsEV2OzQ5JhNc1zuG10VZX9O1QkfX?=
 =?iso-8859-1?Q?RlARwX93rrGiXMH7SRUTBG1oeMbnL0/MSCkHDGYLklSQ6U+YN1VBala0wZ?=
 =?iso-8859-1?Q?BMO9296PsS4fcxP0vB//xtKSwFzu/bt8eegB0gCjeQac2KQjzqYwFIRmQc?=
 =?iso-8859-1?Q?U5Yx2Tx+4EWYZTIV3jITZiTJmIAISO0+1lhclK7uDrbboTIoFHxBTobZdf?=
 =?iso-8859-1?Q?nvPZHVRBAiynZBQzIq/U6Amr2rQKT8bJrm5+Qqr7N8o6HvC6pEha0Cb4R3?=
 =?iso-8859-1?Q?KPBcgQGSgSwQ6zFFEo/WFF84lrlZyjroB7yvPirLTchAFTqH8UNZMZwKOP?=
 =?iso-8859-1?Q?O0R0wvHH4cd6dY6DoT4bPqIJBLfpQ9B8aA1Pq7t5qs/lVhgjuzVf9FlZJH?=
 =?iso-8859-1?Q?Jv8+R2t0HLPG+MoZSRVoFN7LGtXC7bZYNMCb+pqRGEHNJ/LOiW5ysG9gau?=
 =?iso-8859-1?Q?zpoT9zjwsxN3BETOrL+wzHTK2mr9Er0J/fxsi0VG45aLushZhLTkKCOU/w?=
 =?iso-8859-1?Q?8MC10gbGep1kUkPmX/ufNStXfWZOo5VSujqPloZ5GnZeankjNkPwO9CHqs?=
 =?iso-8859-1?Q?442W/er+Z/2kn+uxS4JSmr827jJj/bQ68CXptFhy66xNJKlO2gC1LRouky?=
 =?iso-8859-1?Q?vy7SpACV6LroPdeRTCxeA4xDXzV+LrghyaUolZzmOwN2wuYhDV6tmZUAwN?=
 =?iso-8859-1?Q?hshv8+owFIuCkIm0O5YuGxr0v4BloEakNPJiPJJqsJUMtawP6XZou65tko?=
 =?iso-8859-1?Q?4JZ5+zK0a8WAM1I8XCRhgMrGWAuoi2nugdKBAg54aCf5RQTSDxlwo6n8/l?=
 =?iso-8859-1?Q?rgZMGihGbF/pVrMb1FwU+YmNljyHJrVc4C7SD8akcDPWgssTdOdfCZcYDG?=
 =?iso-8859-1?Q?RMyJigaAQknv+2x69HsePDMQG7hPl0CpFZOHHh7yqQGzz//ldUoWr3tchi?=
 =?iso-8859-1?Q?9FENFN0DnDNc8zyFNO/9BVllGZTH+2Rm9A+BGLzBarHnbmNngaI/oQpwi/?=
 =?iso-8859-1?Q?LeRokcxECQ1WnNbQ2oKVMp/mf5F7CZMFx+k0kTnbqGfaxPI7aPO4i7Ka37?=
 =?iso-8859-1?Q?MDD9+++kqS+jRPnr3N+kWi+9jmz5NPHK3YCyRT9yCzP8eWDnBEjnNkS+MH?=
 =?iso-8859-1?Q?B3B5Eo1S4AuUuakQDT3Jzs0MhcvtMcAfTcBSexK1kHBNuwFeMknA09uTCl?=
 =?iso-8859-1?Q?12gVaiIxYFjn3YlfkwTMKi73YNPf2uVlpNCc3gWMC0e2Vthko4Wkp0GQUr?=
 =?iso-8859-1?Q?sD8by8+GgU1F4TlNKg3/2XDnC1lJoKcUVUdAmVEbICA2Pm1eo6ZVY7IM5O?=
 =?iso-8859-1?Q?uM9gogWvPJ021iG+ZkIOlprEidg9schqA5cX71isTj/MnZux7BFwqSkh5s?=
 =?iso-8859-1?Q?NpDY5+F1kdNOjkna40W9TkCJuK4+SrKWC4KwSSviz87kSpj7Qt05E7aY89?=
 =?iso-8859-1?Q?ypxNazGgm5OiTGYaMRbWyjEC7I+vmhvqD0dFiDyCo7E1jdfUfcuxmmwaia?=
 =?iso-8859-1?Q?peis7rVyRvVcUOagbTRv6KCDZfq4yxiAq54crNrbVcg6AuArf4voba4+ly?=
 =?iso-8859-1?Q?E30KSutkIN/VvNDg3sNl9TSKTeImCztUL4a6tTpBRAfvmDEoqz9UgtMcDA?=
 =?iso-8859-1?Q?N/c46HF32IBp8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcf865b-08cc-4bf7-8326-08db69499e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2023 00:28:30.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjO4zq0/Mw5gONpCqnyUOVfk7NxThBfpshkwKbBH/NIp1/xggxA2xfwLw/1cUikWLXfOgWnzSSTu+dLN9ZGVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5244
X-Proofpoint-GUID: 3MdnWi-9qpG1dYq94hBOZmlOxynIea1m
X-Proofpoint-ORIG-GUID: 90GfZGEmVtcGVQjQS5Ye_QukWdUs19Dr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_18,2023-06-09_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

=0A=
=0A=
=0A=
From: Ira Weiny <ira.weiny@intel.com>=0A=
Sent: Friday, June 9, 2023 2:06 PM=0A=
To: nifan@outlook.com <nifan@outlook.com>; Ira Weiny <ira.weiny@intel.com>;=
 Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Cc: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>; Fan Ni <fan.ni@s=
amsung.com>; Jonathan Cameron <Jonathan.Cameron@huawei.com>; qemu-devel@non=
gnu.org <qemu-devel@nongnu.org>; linux-cxl@vger.kernel.org <linux-cxl@vger.=
kernel.org>; gregory.price@memverge.com <gregory.price@memverge.com>; hchku=
o@avery-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-design.com=
 <cbrowy@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@intel.=
com>; Adam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <dave@s=
tgolabs.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>=0A=
Subject: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu =
=0A=
=A0=0A=
External Email=0A=
=0A=
----------------------------------------------------------------------=0A=
nifan@outlook.com wrote:=0A=
> The 06/08/2023 08:43, Ira Weiny wrote:=0A=
> > Shesha Bhushan Sreenivasamurthy wrote:=0A=
=0A=
[snip]=0A=
=0A=
> =0A=
> Hi Ira & Shesha,=0A=
> FYI. I reabased my patch series on top of the above branch and created a =
new=0A=
> branch here:=0A=
> =0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_moking_=
qemu-2Ddcd-2Dpreview-2Dlatest_tree_dcd-2Dpreview&d=3DDwIBAg&c=3DnKjWec2b6R0=
mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3DSvyB_49EIFU=
T8-ZEVgIEYYjU6-zGTX4wb30kuNLUhkTSHYZK5-C0Gxr7uvefhtj4&s=3DMFD7qlSaTuy-w6aDm=
avIMbSP_aeaqZmSML7IVOX5jLs&e=3D =0A=
=0A=
Thanks!=0A=
=0A=
> =0A=
> It passes the same tests as shown here:=0A=
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_li=
nux-2Dcxl_6481f70fca5c2-5Fc82be29440-40iweiny-2Dmobl.notmuch_T_-23m76f6e85c=
e3d7292b1982960eb22086ee03922166&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D=
Zta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3DSvyB_49EIFUT8-ZEVgIEYYjU6-z=
GTX4wb30kuNLUhkTSHYZK5-C0Gxr7uvefhtj4&s=3De-fQOi0RzSZXxfSz37Bpz1sKtp7Yy0MWq=
onZnswK0RU&e=3D =0A=
=0A=
I've not gotten very far with this testing.=A0 But I did find that regular=
=0A=
type 3 devices don't work with this change.=A0 I used the patch below to ge=
t=0A=
this working.=A0 Was there something I was missing to configure a non-DCD=
=0A=
device?=0A=
=0A=
I don't particularly like adding another bool to this call stack.=A0 Seems=
=0A=
like this calls for a flags field but I want to move on to DCD work so I=0A=
hacked this in.=0A=
=0A=
I am working on the DCD FM-API commands here -=0A=
https://gitlab.com/sheshas/qemu-fmapi/-/tree/cxl-2023-05-25=0A=
-Shesha=0A=
=0A=
Ira=0A=
=0A=
commit ed27935044dcbd2c6ba71f8411b218621f3f4167=0A=
Author: Ira Weiny <ira.weiny@intel.com>=0A=
Date:=A0=A0 Fri Jun 9 13:56:33 2023 -0700=0A=
=0A=
=A0=A0=A0 hw/mem/cxl_type3: Exclude DCD from CEL when type3 is not DCD=0A=
=A0=A0=A0 =0A=
=A0=A0=A0 Per CXL 3.0 9.13.3 Dynamic Capacity Device (DCD) when the type 3 =
memory=0A=
=A0=A0=A0 device does not have DCD support the CEL should not include DCD=
=0A=
=A0=A0=A0 configuration commands.=0A=
=A0=A0=A0 =0A=
=A0=A0=A0 If the number of DC regions supported is 0 skip the DCD commands =
in the=0A=
=A0=A0=A0 CEL.=0A=
=A0=A0=A0 =0A=
=A0=A0=A0 Applies on top of Fan Ni's work here:=0A=
=A0=A0=A0 https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com=
_moking_qemu-2Ddcd-2Dpreview-2Dlatest_tree_dcd-2Dpreview&d=3DDwIBAg&c=3DnKj=
Wec2b6R0mOyPaz7xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3DSvy=
B_49EIFUT8-ZEVgIEYYjU6-zGTX4wb30kuNLUhkTSHYZK5-C0Gxr7uvefhtj4&s=3DMFD7qlSaT=
uy-w6aDmavIMbSP_aeaqZmSML7IVOX5jLs&e=3D =0A=
=A0=A0=A0 =0A=
=A0=A0=A0 Not-yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>=0A=
=0A=
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c=0A=
index a4a2c6a80004..262e35935563 100644=0A=
--- a/hw/cxl/cxl-device-utils.c=0A=
+++ b/hw/cxl/cxl-device-utils.c=0A=
@@ -288,7 +288,7 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl=
_dstate)=0A=
=A0=0A=
=A0static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }=0A=
=A0=0A=
-void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)=0A=
+void cxl_device_register_init_common(CXLDeviceState *cxl_dstate, bool is_d=
cd)=0A=
=A0{=0A=
=A0=A0=A0=A0 uint64_t *cap_hdrs =3D cxl_dstate->caps_reg_state64;=0A=
=A0=A0=A0=A0 const int cap_count =3D 3;=0A=
@@ -307,7 +307,7 @@ void cxl_device_register_init_common(CXLDeviceState *cx=
l_dstate)=0A=
=A0=A0=A0=A0 cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);=0A=
=A0=A0=A0=A0 memdev_reg_init_common(cxl_dstate);=0A=
=A0=0A=
-=A0=A0=A0 cxl_initialize_mailbox(cxl_dstate, false);=0A=
+=A0=A0=A0 cxl_initialize_mailbox(cxl_dstate, false, is_dcd);=0A=
=A0}=0A=
=A0=0A=
=A0void cxl_device_register_init_swcci(CXLDeviceState *cxl_dstate)=0A=
@@ -329,7 +329,7 @@ void cxl_device_register_init_swcci(CXLDeviceState *cxl=
_dstate)=0A=
=A0=A0=A0=A0 cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);=0A=
=A0=A0=A0=A0 memdev_reg_init_common(cxl_dstate);=0A=
=A0=0A=
-=A0=A0=A0 cxl_initialize_mailbox(cxl_dstate, true);=0A=
+=A0=A0=A0 cxl_initialize_mailbox(cxl_dstate, true, false);=0A=
=A0}=0A=
=A0=0A=
=A0uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)=0A=
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c=0A=
index 93b26e717c94..80e9cb9a8f04 100644=0A=
--- a/hw/cxl/cxl-mailbox-utils.c=0A=
+++ b/hw/cxl/cxl-mailbox-utils.c=0A=
@@ -1526,7 +1526,8 @@ static void bg_timercb(void *opaque)=0A=
=A0=A0=A0=A0 }=0A=
=A0}=0A=
=A0=0A=
-void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)=
=0A=
+void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci,=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 bool is_dcd)=0A=
=A0{=0A=
=A0=A0=A0=A0 if (!switch_cci) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 cxl_dstate->cxl_cmd_set =3D cxl_cmd_set;=0A=
@@ -1534,6 +1535,9 @@ void cxl_initialize_mailbox(CXLDeviceState *cxl_dstat=
e, bool switch_cci)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 cxl_dstate->cxl_cmd_set =3D cxl_cmd_set_sw;=0A=
=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0 for (int set =3D 0; set < 256; set++) {=0A=
+=A0=A0=A0=A0=A0=A0=A0 if (!is_dcd && set =3D=3D DCD_CONFIG) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;=0A=
+=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 for (int cmd =3D 0; cmd < 256; cmd++) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (cxl_dstate->cxl_cmd_set[set][cmd].=
handler) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct cxl_cmd *c =3D &cxl=
_dstate->cxl_cmd_set[set][cmd];=0A=
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c=0A=
index 329e8b5915b3..e6e6e125990c 100644=0A=
--- a/hw/mem/cxl_type3.c=0A=
+++ b/hw/mem/cxl_type3.c=0A=
@@ -1276,9 +1276,11 @@ static void ct3d_reset(DeviceState *dev)=0A=
=A0=A0=A0=A0 CXLType3Dev *ct3d =3D CXL_TYPE3(dev);=0A=
=A0=A0=A0=A0 uint32_t *reg_state =3D ct3d->cxl_cstate.crb.cache_mem_registe=
rs;=0A=
=A0=A0=A0=A0 uint32_t *write_msk =3D ct3d->cxl_cstate.crb.cache_mem_regs_wr=
ite_mask;=0A=
+=A0=A0=A0 bool is_dcd;=0A=
=A0=0A=
=A0=A0=A0=A0 cxl_component_register_init_common(reg_state, write_msk, CXL2_=
TYPE3_DEVICE);=0A=
-=A0=A0=A0 cxl_device_register_init_common(&ct3d->cxl_dstate);=0A=
+=A0=A0=A0 is_dcd =3D (ct3d->dc.num_regions !=3D 0);=0A=
+=A0=A0=A0 cxl_device_register_init_common(&ct3d->cxl_dstate, is_dcd);=0A=
=A0}=0A=
=A0=0A=
=A0static Property ct3_props[] =3D {=0A=
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h=0A=
index 1ccddcca7d0d..4621bba4f533 100644=0A=
--- a/include/hw/cxl/cxl_device.h=0A=
+++ b/include/hw/cxl/cxl_device.h=0A=
@@ -233,7 +233,7 @@ typedef struct cxl_device_state {=0A=
=A0void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);=
=0A=
=A0=0A=
=A0/* Set up default values for the register block */=0A=
-void cxl_device_register_init_common(CXLDeviceState *dev);=0A=
+void cxl_device_register_init_common(CXLDeviceState *dev, bool is_dcd);=0A=
=A0void cxl_device_register_init_swcci(CXLDeviceState *dev);=0A=
=A0=0A=
=A0/*=0A=
@@ -280,7 +280,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CXL_DEVICE_CAP_HDR1_OFFSET +=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CXL_DEVICE_CAP_REG_SIZE=
 * 2)=0A=
=A0=0A=
-void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci);=
=0A=
+void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci, b=
ool is_dcd);=0A=
=A0void cxl_process_mailbox(CXLDeviceState *cxl_dstate);=0A=
=A0=0A=
=A0#define cxl_device_cap_init(dstate, reg, cap_id, ver)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
