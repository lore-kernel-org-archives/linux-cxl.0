Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC60C7EE23
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Jun 2023 18:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjFGSxi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Jun 2023 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjFGSxh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Jun 2023 14:53:37 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EAF1FE9
        for <linux-cxl@vger.kernel.org>; Wed,  7 Jun 2023 11:53:33 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357I71eQ019896;
        Wed, 7 Jun 2023 11:52:21 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3r2a75bwks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 11:52:21 -0700
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 357IlNWM011285;
        Wed, 7 Jun 2023 11:52:20 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3r2a75bwkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 11:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/0P6OLIEefTXn+ZIwA7g/SEhi4czSiRzEszghKJv5i5NuiloKZGPiE6eV6VPv0Uk8OtkEChq0AZr7rk03MMhsmcMMziEfmbiAi69qRfRHVTD/LNiNJZ9mKz4c20q4FFH7sObsrWvHem42/lgBTsKBWQFS5NT+DNfghgTi0632v7EYRWZ3UIqbenu161A3dRnCOzzeMwdWa5wg/A9Ss1V/LqhCtoXLE2VMd1hUH66iSjyCXko5o1XFwmM//kN7PLk85Xclyi1MoaaPYpeA5fLVgcaQSDnrq0jw6Aeeq82dIwoqoDPGtzJpB9jAfYbba9l3GgLweyPv9Hs0xTmfSdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcZWpz/VPxsxHy71F0pqJBtCL0c+ZN//F8E/UnBe8Jw=;
 b=AXIKl8FFarQEyjv2Q+Ryo4ym2+M2OLclfK1Tv5V0tfvNoHkWIYjVbe+i+KO3laTMPYHnRhvP8Nsd4iCyAT49wWNRsUDFSPaWz4GRM5v6V06FKoETsTv5KCVwWUqZQYPWqEMb8ej4DQsPBPYZvwyiJ+NvphUV+zaWwOzQQ7zL0kMkGLNpUCbCjb4ZvjlnExsXzBLrasdKTD/XfdnwHXxJdr0e5r6hMuuDTZNgH6nCykEbLJvTVAC23cz01Hy0qH8wOZMQgJDsqnrTF8M4VCaopBc50QTIuE9REW12djxAru8NKahOI9ap8CfFbXavaJHi9pvMzjIbABhIXqVJNbca2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcZWpz/VPxsxHy71F0pqJBtCL0c+ZN//F8E/UnBe8Jw=;
 b=oXBeutEQvoCodAGKgGo6lN416eutTPaJHgFyjOu4QZXQlkrCDnxxSxvxHK2UvFzmqtSwrLj8DuJNiMIlFecAYRDMylcoANfDILgyUQ8DSF5Y7ju2zrT90qXf9wiB0LlAp8PYoLIrBFRui9Y7lpMiINhCOXuIiiBImdr6UdXQp4s=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by SA3PR18MB5392.namprd18.prod.outlook.com (2603:10b6:806:2f4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 18:52:16 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::cd6c:c34b:dc45:b864%6]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 18:52:15 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
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
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOK98n/AAgAAEVoCAAymO8IAABjkAgAAFXhI=
Date:   Wed, 7 Jun 2023 18:52:14 +0000
Message-ID: <DM6PR18MB284486E36310719093C8A6D6AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
        <20230511175609.2091136-1-fan.ni@samsung.com>
        <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
        <20230605175112.GA2290821@bgt-140510-bm03>
        <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230607183059.GA2354376@bgt-140510-bm03>
In-Reply-To: <20230607183059.GA2354376@bgt-140510-bm03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|SA3PR18MB5392:EE_
x-ms-office365-filtering-correlation-id: 754734a0-dd6c-4afa-b23a-08db67884f7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4oQjpSeI3Udabn1hVJ8vkTQ6TjLYb0I7IGsL1JzGHoLxQ2A/b8aaPEtjh6VDK1NKVxBjknDjMOMWS4Rlo1yz/FqmBUDsbBHtr/1cxMwOxZcvWtoNgdN+PunOK/TaxQbRg+yTivaZQs9o6HmL3PjDntBGHXrYXVNXTx5nK0KYADycU5TW+7Qd+7O5KH3vKbSP98XQU+CqpYEbGm1WWNj0xoTM0+v7jChc/StK2eKG2HopuBwOfwJLU4FwN+iGj2+zTXes2t0vZQ+rtJy6ujL6/4Bllnd2Cw0xM2y9isdA4z39PeYxdlHC5rU9jCsRRe5L2LJF+NY65leXtrc11J6oMxkdfTe9mWQ9bg38O3Dhb9lvGdbU90IRG1DoivcyUqIQyE7DpetuEbfbKOaBNMSFzNCFGpE1kcC+99Kv6pmQ2EryWr7ZHL8c8meXK6FbQmhWUnftTgvbwKDjMk+wBwPu5sILizi7PVWtvIQVf1kAbSTuFaw99MtAOtF6WCBpPtLcGPPOYJvThk0QXbi3glousSlXRRz/FkZgTH8hPTc61XeFjh3aIgaLUEWpX/frG7mv9wCTcbW3Uiu1bzKk/LwDcU0rQnlDjMv7Y3TiktP8aAIeX0Mg3McItrLLYzaNOKRRFbauRMDbbzURGLfK4BReGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(478600001)(7696005)(45080400002)(71200400001)(186003)(54906003)(966005)(26005)(6506007)(53546011)(9686003)(2906002)(30864003)(7416002)(66556008)(33656002)(83380400001)(55016003)(38100700002)(4326008)(6916009)(122000001)(91956017)(66476007)(66946007)(76116006)(52536014)(66446008)(8676002)(86362001)(5660300002)(8936002)(64756008)(316002)(38070700005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?abUutJ5bGnJte9m8hsg1z3O0e/PEk0dYf59DQORkARIoWcdreTEr6FtceX?=
 =?iso-8859-1?Q?ZnKda7vwtJxFdGc1CpZQgs5EDScrPaeVZcFHH24ueMP4ETLhrAjL+e8+aL?=
 =?iso-8859-1?Q?MXkUae21fdf1757gVwjuSI1rn62DHvm7OZ0mKGDfySbmX9tsa4r0IWSIWL?=
 =?iso-8859-1?Q?Al3nhnVO0oTG4M0x+3pTVRtIvVqIojh8KZWYrhoXWfTj/Z9FCuTAaTVa5D?=
 =?iso-8859-1?Q?Zqin7v7qKQK5te6gGC8eljHfyL/IRhQ0PlKBhx/m1lU8aJuvU4R9mlI2+1?=
 =?iso-8859-1?Q?4FlH43L9lj3pa+vcjiFEhRjmk3+2dRNJTZoA7S/YUl7uWvsOY0T6xxMw95?=
 =?iso-8859-1?Q?McEsrFhHxmXdARcZ2LdRFmqBVHESvCIy6+fZUHOUKoIA6gXHYwLK1pwaOc?=
 =?iso-8859-1?Q?6z3zO9WT8sq55O8EB4AG/QT/9tSX8PNRfEAD0RO1atm1znXIXBw8lqY7bn?=
 =?iso-8859-1?Q?RNJz7JhcSFQqWqUb3XITKlZ+h6x5aSniTTK2Lz0EMrG3idG6CJ2Z2fR39p?=
 =?iso-8859-1?Q?H4YS0d/wTdcYbGma8aHQu3SQ07vAiVP43cmhAwp7rqGgVUP/9tSKhkD78h?=
 =?iso-8859-1?Q?13FmsTosqkXP7vBYUDJ1WgoUnLNYMynMbfwEWj1zP8y6wrwVu0GnshH6ZN?=
 =?iso-8859-1?Q?rzWNnZQg8cp+YKCM4eVHnZq6eNFdTtIbxtx4jWQs8YJM3Ef4Ssyai2Sgii?=
 =?iso-8859-1?Q?98fuqz8ePYWlcfh0urcab28abBUKiH/ITDeoSLoxi/rc3e6J2X7I6nnMMt?=
 =?iso-8859-1?Q?K7jCdpYDKY7lkVTyWLWXNOUt5Ewn+kImRcpqNwLEnofiLG0bnvDNdyeuR0?=
 =?iso-8859-1?Q?YS8npLAI24YkzOZKbWHY5g0gYbHA0LcnrOQkWPzRGVcNuomZL0CIHX4duK?=
 =?iso-8859-1?Q?04f6gNU+VzfSOgd1LQO8hvA8nx1EOgXBEp/aUY46gxWK9OLmjA5ehJBhEA?=
 =?iso-8859-1?Q?LL7g5qU2VMMH2cVN9A4aNjZ9Xf3iXDcge/9vUiPE+9qxcUwMzQsxzI/2OK?=
 =?iso-8859-1?Q?7HuBWWAPgRRH6+3oelb1QRlIxCpk3sXrIz0HjZkexXOSGtLFlhvvuc7wW4?=
 =?iso-8859-1?Q?3/7jRm2ltcXP/2yGegQqWv1hrBfsNb5krstQkgV1mbzzWEIdTQfvY1Eiak?=
 =?iso-8859-1?Q?Vg6c1k3O7nkc6apCJ4dWakZRGYWei2tzk9f081FNG1LSiXfzZBstEv1vA6?=
 =?iso-8859-1?Q?Jb8aA3/BYNb1RrStSrT7VJZlbIOwOHt5Mwj1/zPMjZV5RpT+cZxhGnK0gV?=
 =?iso-8859-1?Q?Q90bNhBnSNnScmD3m9NER29DlwTdvxhQcDeT1BBIDMgyMBzv7FXjylBFXB?=
 =?iso-8859-1?Q?vTD43ueg5JkQCfdt5FyidWdT6I+3J5kxj2S6rzr/CS9E32a2m0z35KoMLV?=
 =?iso-8859-1?Q?OESHBXPUXQntzDJonrtUIhcY/8+2+XjMI7/eN0JFPMAle78ohLf7NBALIP?=
 =?iso-8859-1?Q?TZXR9sdJGOWFktGHzu7PnPoSd1GZEZEAK8GAuG/e8/sLclplk+iW9DNSKv?=
 =?iso-8859-1?Q?UGapKcvUkE91TUMN/ocJpLgS3K8TXI3U5+tlOAJKGhwX8cPVsOmLsXP5GN?=
 =?iso-8859-1?Q?OI1FOd81BvKhPmhorShezhzHLf8mDTQTaTvpLEMVqj/uqOtdlISNWVtrBA?=
 =?iso-8859-1?Q?xDkN8Br6Mjdro8fTL93rsvPB95mjXoLnr+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754734a0-dd6c-4afa-b23a-08db67884f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 18:52:14.9393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpRMCUj0cnQEXdnz1xqHbeUbHpkJGTMPQlkCpjJ24aszNlnW251y5+7sZ5QEmY5rfk1iy/Q3Hs4ykPHyGGcwsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5392
X-Proofpoint-ORIG-GUID: zZcFSZ2jsmOJIsk4N7ith8KUWbcFpzZ4
X-Proofpoint-GUID: Soffke7rSpYedCNNTteIREYQoUSbNJzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_10,2023-06-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

=0A=
=0A=
=0A=
From: Fan Ni <fan.ni@samsung.com>=0A=
Sent: Wednesday, June 7, 2023 11:31 AM=0A=
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>; qemu-devel@nongnu.org <=
qemu-devel@nongnu.org>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.or=
g>; gregory.price@memverge.com <gregory.price@memverge.com>; hchkuo@avery-d=
esign.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-design.com <cbrowy@=
avery-design.com>; dan.j.williams@intel.com <dan.j.williams@intel.com>; Ada=
m Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <dave@stgolabs.n=
et>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; nifan@outlook.c=
om <nifan@outlook.com>; Ira Weiny <ira.weiny@intel.com>=0A=
Subject: [EXT] Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu =
=0A=
=A0=0A=
External Email=0A=
=0A=
----------------------------------------------------------------------=0A=
On Wed, Jun 07, 2023 at 06:13:01PM +0000, Shesha Bhushan Sreenivasamurthy w=
rote:=0A=
> Hi Fan,=0A=
>=A0=A0=A0 I am implementing DCD FMAPI commands and planning to start pushi=
ng changes to the below branch. That requires the contributions you have ma=
de. Can your changes be pushed to the below branch ?=0A=
> =0A=
> https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-2023=
-05-25__;!!EwVzqGoTKBqv-0DWAJBm!Vt5uIqwW-L4c4gh02ulI4M762JNQ3_aE9k9lb6QlwE2=
xm6T23ic7ig7Y77i1VN7l_RX_ySIQhre_z7Q0JA$ =0A=
=0A=
Can you push changes to the branch directly? I think it is Jonathan's priva=
te=0A=
branch. However, I can fork the branch and rebase my patch series atop and=
=0A=
share with you the new repo if that helps you move forward your=0A=
work.=0A=
Let me know your thought.=0A=
=0A=
ss - I saw commits from others, so assumed you can. Since it is Jonathan's =
private repo, I will step back and let him answer.=0A=
=0A=
Fan=0A=
=0A=
> =0A=
> =0A=
> From: Fan Ni <fan.ni@samsung.com>=0A=
> Sent: Monday, June 5, 2023 10:51 AM=0A=
> To: Ira Weiny <ira.weiny@intel.com>=0A=
> Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jonathan.cameron@huawe=
i.com <jonathan.cameron@huawei.com>; linux-cxl@vger.kernel.org <linux-cxl@v=
ger.kernel.org>; gregory.price@memverge.com <gregory.price@memverge.com>; h=
chkuo@avery-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-design=
.com <cbrowy@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@in=
tel.com>; Adam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <da=
ve@stgolabs.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; ni=
fan@outlook.com <nifan@outlook.com>=0A=
> Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu =0A=
> =A0=0A=
> On Mon, Jun 05, 2023 at 10:35:48AM -0700, Ira Weiny wrote:=0A=
> > Fan Ni wrote:=0A=
> > > Since the early draft of DCD support in kernel is out=0A=
> > > (https://urldefense.com/v3/__https://lore.kernel.org/linux-cxl/202304=
17164126.GA1904906@bgt-140510-bm03/T/*t__;Iw!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcS=
iGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21LzAGNOk=
$ ),=0A=
> > > this patch series provide dcd emulation in qemu so people who are int=
erested=0A=
> > > can have an early try. It is noted that the patch series may need to =
be updated=0A=
> > > accordingly if the kernel side implementation changes.=0A=
> > =0A=
> > Fan,=0A=
> > =0A=
> > Do you have a git tree we can pull this from which is updated to a more=
=0A=
> > recent CXL branch from Jonathan?=0A=
> > =0A=
> > Thanks,=0A=
> > Ira=0A=
> =0A=
> Hi Ira,=0A=
> =0A=
> I have a git tree of the patch series based on Jonathan's branch=0A=
> cxl-2023-02-28: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_moking_qemu-2Ddev_tree_dcd-2Drfe&d=3DDwIFAg&c=3DnKjWec2b6R0mOyPaz7=
xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3Dw6dicn5kXEG4Imk6Tp=
ICIjdA6KJ-xt84dtHui-Y0fv5H13bijtzEvjxECKE5MHYf&s=3D3yeO9RN5FY3gPfO2y19X057Y=
eqRTTQTQNfNA-Gfir_Q&e=3D .=0A=
> =0A=
> That may be not new enough to include some of the recent patches, but I c=
an=0A=
> rebase it to a newer branch if you can tell me which branch you want to u=
se.=0A=
> =0A=
> Thanks,=0A=
> Fan=0A=
> =0A=
> > =0A=
> > > =0A=
> > > To support DCD emulation, the patch series add DCD related mailbox co=
mmand=0A=
> > > support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory de=
vice=0A=
> > > with dynamic capacity extent and region representative.=0A=
> > > To support read/write to the dynamic capacity of the device, a host b=
ackend=0A=
> > > is provided and necessary check mechnism is added to ensure the dynam=
ic=0A=
> > > capacity accessed is backed with active dc extents.=0A=
> > > Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is not =
supported=0A=
> > > , but we add two qmp interfaces for adding/releasing dynamic capacity=
 extents.=0A=
> > > Also, the support for multiple hosts sharing the same DCD case is mis=
sing.=0A=
> > > =0A=
> > > Things we can try with the patch series together with kernel dcd code=
:=0A=
> > > 1. Create DC regions to cover the address range of the dynamic capaci=
ty=0A=
> > > regions.=0A=
> > > 2. Add/release dynamic capacity extents to the device and notify the=
=0A=
> > > kernel.=0A=
> > > 3. Test kernel side code to accept added dc extents and create dax de=
vices,=0A=
> > > and release dc extents and notify the device=0A=
> > > 4. Online the memory range backed with dc extents and let application=
 use=0A=
> > > them.=0A=
> > > =0A=
> > > The patch series is based on Jonathan's local qemu branch:=0A=
> > > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-=
2023-02-28__;!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeU=
FdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21OO3UHEM$ =0A=
> > > =0A=
> > > Simple tests peformed with the patch series:=0A=
> > > 1 Install cxl modules:=0A=
> > > =0A=
> > > modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem=0A=
> > > =0A=
> > > 2 Create dc regions:=0A=
> > > =0A=
> > > region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)=0A=
> > > echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region=0A=
> > > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity=0A=
> > > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways=0A=
> > > echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode=0A=
> > > echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size=0A=
> > > echo 0x10000000 > /sys/bus/cxl/devices/$region/size=0A=
> > > echo=A0 "decoder2.0" > /sys/bus/cxl/devices/$region/target0=0A=
> > > echo 1 > /sys/bus/cxl/devices/$region/commit=0A=
> > > echo $region > /sys/bus/cxl/drivers/cxl_region/bind=0A=
> > > =0A=
> > > /home/fan/cxl/tools-and-scripts# cxl list=0A=
> > > [=0A=
> > >=A0=A0 {=0A=
> > >=A0=A0=A0=A0 "memdevs":[=0A=
> > >=A0=A0=A0=A0=A0=A0 {=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "memdev":"mem0",=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "pmem_size":536870912,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "ram_size":0,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "serial":0,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "host":"0000:0d:00.0"=0A=
> > >=A0=A0=A0=A0=A0=A0 }=0A=
> > >=A0=A0=A0=A0 ]=0A=
> > >=A0=A0 },=0A=
> > >=A0=A0 {=0A=
> > >=A0=A0=A0=A0 "regions":[=0A=
> > >=A0=A0=A0=A0=A0=A0 {=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "region":"region0",=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "resource":45365592064,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "size":268435456,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_ways":1,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_granularity":256,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "decode_state":"commit"=0A=
> > >=A0=A0=A0=A0=A0=A0 }=0A=
> > >=A0=A0=A0=A0 ]=0A=
> > >=A0=A0 }=0A=
> > > ]=0A=
> > > =0A=
> > > 3 Add two dc extents (128MB each) through qmp interface=0A=
> > > =0A=
> > > { "execute": "qmp_capabilities" }=0A=
> > > =0A=
> > > { "execute": "cxl-add-dynamic-capacity-event",=0A=
> > >=A0=A0=A0=A0=A0 "arguments": {=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "path": "/machine/periphera=
l/cxl-pmem0",=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "region-id" : 0,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "num-extent": 2,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "dpa":0,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "extent-len": 128=0A=
> > >=A0=A0=A0=A0=A0 }=0A=
> > > }=0A=
> > > =0A=
> > > /home/fan/cxl/tools-and-scripts# lsmem=0A=
> > > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE=A0=A0 BLOCK=
=0A=
> > > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=A0=
=A0=A0=A0 yes=A0=A0=A0 0-15=0A=
> > > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=A0=
=A0=A0=A0 yes=A0=A0 32-79=0A=
> > > 0x0000000a90000000-0x0000000a9fffffff=A0 256M offline=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 338-339=0A=
> > > =0A=
> > > Memory block size:=A0=A0=A0=A0=A0=A0 128M=0A=
> > > Total online memory:=A0=A0=A0=A0=A0=A0 8G=0A=
> > > Total offline memory:=A0=A0=A0 256M=0A=
> > > =0A=
> > > =0A=
> > > 4.Online the momory with 'daxctl online-memory dax0.0' to online the =
memory=0A=
> > > =0A=
> > > /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0=0A=
> > > [=A0 230.730553] Fallback order for Node 0: 0 1=0A=
> > > [=A0 230.730825] Fallback order for Node 1: 1 0=0A=
> > > [=A0 230.730953] Built 2 zonelists, mobility grouping on.=A0 Total pa=
ges: 2042541=0A=
> > > [=A0 230.731110] Policy zone: Normal=0A=
> > > onlined memory for 1 device=0A=
> > > =0A=
> > > root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem=0A=
> > > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE BLOCK=0A=
> > > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=A0=
=A0=A0=A0 yes=A0 0-15=0A=
> > > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=A0=
=A0=A0=A0 yes 32-79=0A=
> > > 0x0000000a90000000-0x0000000a97ffffff=A0 128M=A0 online=A0=A0=A0=A0=
=A0=A0 yes=A0=A0 338=0A=
> > > 0x0000000a98000000-0x0000000a9fffffff=A0 128M offline=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 339=0A=
> > > =0A=
> > > Memory block size:=A0=A0=A0=A0=A0=A0 128M=0A=
> > > Total online memory:=A0=A0=A0=A0 8.1G=0A=
> > > Total offline memory:=A0=A0=A0 128M=0A=
> > > =0A=
> > > 5 using dc extents as regular memory=0A=
> > > =0A=
> > > /home/fan/cxl/ndctl# numactl --membind=3D1 ls=0A=
> > > CONTRIBUTING.md=A0 README.md=A0 clean_config.sh=A0 cscope.out=A0=A0 g=
it-version-gen=0A=
> > > ndctl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scripts=A0=A0 test.h=A0=
=A0=A0=A0=A0 version.h.in COPYING=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 acpi.h=0A=
> > > config.h.meson=A0=A0 cxl=A0=A0=A0=A0=A0=A0=A0=A0=A0 make-git-snapshot=
.sh=A0=A0 ndctl.spec.in=A0 sles=A0=A0=A0=A0 tools=0A=
> > > Documentation=A0=A0=A0=A0=A0=A0=A0 build=A0=A0=A0=A0=A0=A0 contrib=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 daxctl=A0=A0=A0=A0=A0=A0=A0 meson.build=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 rhel=0A=
> > > tags=A0=A0=A0=A0=A0=A0=A0 topology.png LICENSES=A0=A0=A0 ccan=A0=A0=
=A0=A0=A0=A0=A0 cscope.files=0A=
> > > git-version=A0 meson_options.txt=A0=A0=A0=A0=A0 rpmbuild.sh=A0=A0=A0 =
test=A0=A0=A0=A0 util=0A=
> > > =0A=
> > > =0A=
> > > QEMU command line cxl configuration:=0A=
> > > =0A=
> > > RP1=3D"-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=
=3D/tmp/cxltest.raw,size=3D512M \=0A=
> > > -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/=
cxltest2.raw,size=3D512M \=0A=
> > > -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/=
lsa.raw,size=3D512M \=0A=
> > > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \=0A=
> > > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \=0A=
> > > -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,=
dc-memdev=3Dcxl-mem2,id=3Dcxl-pmem0,num-dc-regions=3D1\=0A=
> > > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interlea=
ve-granularity=3D8k"=0A=
> > > =0A=
> > > =0A=
> > > Kernel DCD support used to test the changes=0A=
> > > =0A=
> > > The code is tested with the posted kernel dcd support:=0A=
> > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kern=
el/git/cxl/cxl.git/log/?h=3Dfor-6.5*dcd-preview__;Lw!!EwVzqGoTKBqv-0DWAJBm!=
RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr2=
1q5Iza3M$ =0A=
> > > =0A=
> > > commit: f425bc34c600e2a3721d6560202962ec41622815=0A=
> > > =0A=
> > > To make the test work, we have made the following changes to the abov=
e kernel commit:=0A=
> > > =0A=
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c=0A=
> > > index 5f04bbc18af5..5f421d3c5cef 100644=0A=
> > > --- a/drivers/cxl/core/mbox.c=0A=
> > > +++ b/drivers/cxl/core/mbox.c=0A=
> > > @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_=
MEM_COMMAND_ID_MAX] =3D {=0A=
> > >=A0=A0=A0=A0=A0 CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),=0A=
> > >=A0=A0=A0=A0=A0 CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),=
=0A=
> > >=A0=A0=A0=A0=A0 CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOAD,=
 0),=0A=
> > > +=A0=A0 CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),=0A=
> > >=A0 };=0A=
> > >=A0 =0A=
> > >=A0 /*=0A=
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c=0A=
> > > index 291c716abd49..ae10e3cf43a1 100644=0A=
> > > --- a/drivers/cxl/core/region.c=0A=
> > > +++ b/drivers/cxl/core/region.c=0A=
> > > @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_region=
 *cxlr)=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cxlds->dc_list_gen_num =3D ext=
ent_gen_num;=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(cxlds->dev, "No of pre=
allocated extents :%d\n", rc);=0A=
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable_irq(cxlds->cxl_irq[CXL_EVENT_T=
YPE_DCD]);=0A=
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*enable_irq(cxlds->cxl_irq[CXL_EVENT=
_TYPE_DCD]);*/=0A=
> > >=A0=A0=A0=A0=A0 }=0A=
> > >=A0=A0=A0=A0=A0 return 0;=0A=
> > >=A0 err:=0A=
> > > @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *cxl=
ds, struct resource *alloc_dpa_re=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 dev_dax->align, memremap_compat_align()))) {=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D alloc_dev_dax_range(dev=
_dax, hpa,=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resource_size(alloc_dpa_res));=
=0A=
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=0A=
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rc)=0A=
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=0A=
> > >=A0=A0=A0=A0=A0 }=0A=
> > >=A0 =0A=
> > >=A0=A0=A0=A0=A0 rc =3D xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax,=
 GFP_KERNEL);=0A=
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c=0A=
> > > index 9e45b1056022..653bec203838 100644=0A=
> > > --- a/drivers/cxl/pci.c=0A=
> > > +++ b/drivers/cxl/pci.c=0A=
> > > @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_stat=
e *cxlds)=0A=
> > >=A0 =0A=
> > >=A0=A0=A0=A0=A0 /* Driver enables DCD interrupt after creating the dc =
cxl_region */=0A=
> > >=A0=A0=A0=A0=A0 rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settings=
, CXL_EVENT_TYPE_DCD,=0A=
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_A=
UTOEN);=0A=
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT);=0A=
> > >=A0=A0=A0=A0=A0 if (rc) {=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(cxlds->dev, "Failed to=
 get interrupt for event dc log\n");=0A=
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;=0A=
> > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_me=
m.h=0A=
> > > index 6ca85861750c..910a48259239 100644=0A=
> > > --- a/include/uapi/linux/cxl_mem.h=0A=
> > > +++ b/include/uapi/linux/cxl_mem.h=0A=
> > > @@ -47,6 +47,7 @@=0A=
> > >=A0=A0=A0=A0=A0 ___C(SCAN_MEDIA, "Scan Media"),=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
> > >=A0=A0=A0=A0=A0 ___C(GET_SCAN_MEDIA, "Get Scan Media Results"),=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> > >=A0=A0=A0=A0=A0 ___C(GET_DC_EXTENT_LIST, "Get dynamic capacity extents=
"),=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> > > +=A0=A0 ___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),=A0=
=A0=A0=A0=A0=A0=A0=A0 \=0A=
> > >=A0=A0=A0=A0=A0 ___C(MAX, "invalid / last command")=0A=
> > >=A0 =0A=
> > >=A0 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a=0A=
> > > =0A=
> > > =0A=
> > > =0A=
> > > Fan Ni (7):=0A=
> > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output=
=0A=
> > >=A0=A0=A0=A0 payload of identify memory device command=0A=
> > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dynamic capacity region represent=
ative=0A=
> > >=A0=A0=A0=A0 and mailbox command support=0A=
> > >=A0=A0 hw/mem/cxl_type3: Add a parameter to pass number of DC regions =
the=0A=
> > >=A0=A0=A0=A0 device supports in qemu command line=0A=
> > >=A0=A0 hw/mem/cxl_type3: Add DC extent representative to cxl type3 dev=
ice=0A=
> > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/r=
elease=0A=
> > >=A0=A0=A0=A0 dynamic capacity response=0A=
> > >=A0=A0 Add qmp interfaces to add/release dynamic capacity extents=0A=
> > >=A0=A0 hw/mem/cxl_type3: add read/write support to dynamic capacity=0A=
> > > =0A=
> > >=A0 hw/cxl/cxl-mailbox-utils.c=A0 | 389 +++++++++++++++++++++++++++-=
=0A=
> > >=A0 hw/mem/cxl_type3.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 492 ++++++++++++++=
+++++++++++++++++-----=0A=
> > >=A0 include/hw/cxl/cxl_device.h |=A0 50 +++-=0A=
> > >=A0 include/hw/cxl/cxl_events.h |=A0 16 ++=0A=
> > >=A0 qapi/cxl.json=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 44 ++=
++=0A=
> > >=A0 5 files changed, 924 insertions(+), 67 deletions(-)=0A=
> > > =0A=
> > > -- =0A=
> > > 2.25.1=0A=
> > =0A=
> > =
