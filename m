Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DCC64ED8
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 21:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBWV4O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 16:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBWV4N (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 16:56:13 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3D1196A6
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 13:56:11 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NKgBqj027001
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 13:56:11 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3nwy5h31dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 13:56:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyNTMYJDTtjb/XR6XqtzJhPOVfC8LMzMx3f7uDhgXX2rB+dAIbK5z4RZEQwKN/d7pvVMFZUG4POw3HIZe4tszDGKLrz8ZpEXpZ3HyGa3fKsBDeJdMn8zQFbmvoI8MQEjiKqTC6FpibSlT1IgZTQwLi7/Rypou2mAaL2zTahERvsSuhyFR2VmA/dqJIodO3f4uo90eu3d2Mmw9CwBllaZBEulIyRxud3vooMAV7m4vsY2CfJk0ScoOCv5zgzePYnOW65+VFc/9GcgjQYCr2qUnwna4cs9bP6mj5tVAFjFlYwaXVmxORoozpacSvSb7j/8YBcBg3urDObxGXs+/TVhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mav1mMWQkNdSP16aJhdrWcE6uaI4bXpwl/x63/pxqhM=;
 b=KBNn5Gxu8ZPu3gpfI2NUCe3F/gxYbMbqaGSjCs+fuGlqgpit7UxeCNd97hTtAAQ9Z9jps//5hbdObE9Bdg1PHw4g40d2p0erKAAKWsQw0eixW7fb9h0E5jo2XZRudfEdrwj66fND3Io4SelcHk/ID7pVGGVn2eL4JlAEsD/ufvLnvSPvQDn1jBAq4ChSY8pBA0OrqMoTCTAhq1lfpsUW1u3X//Su/H5af+f0nxpYgW0/OzaZdsFt4l/wxbtOznUwvCevLqpWpR8ulFjVJfSQgYQ4iZfJRhf4GJHfj7kNto7vZsYyhWAL/g9JtFTc6ualfIK1nnMQW/Sc1WvbpqQxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mav1mMWQkNdSP16aJhdrWcE6uaI4bXpwl/x63/pxqhM=;
 b=RxuA6e5BL/0mc/EZrugol+xG36ZpPZAeHydq/OzvRuFFSLtFuVfz72B7h98Y3qP1M2xO3S2v/nmKwt8X+fJm1lONBH7su9cXnj6AalonT4WgWtR50ExjR77SX37O0h76tB1947e+tHG/qS7o5eKsSwn0fr++O1yAlbhcZiR0e9Q=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by SJ0PR18MB4106.namprd18.prod.outlook.com (2603:10b6:a03:2ca::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 21:56:08 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::27a5:5d7c:bd9f:d197]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::27a5:5d7c:bd9f:d197%6]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 21:56:08 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Programming HDM decoders
Thread-Topic: Programming HDM decoders
Thread-Index: AQHZR9DB9NbY4zr+00WMLNQ3qkFcWg==
Date:   Thu, 23 Feb 2023 21:56:08 +0000
Message-ID: <DM6PR18MB28449FE11B645FB3A3CD3243AFAB9@DM6PR18MB2844.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|SJ0PR18MB4106:EE_
x-ms-office365-filtering-correlation-id: aaee2dce-f34f-4051-82fd-08db15e8c4c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDrm4etG7xH087NfWFqgjixBP+lfxSKe9FmMCQQMK4G5m3MD6ROO2WmD3izoRaTEEu0GqQwyMnJ1lR15HSzbprhbBHxeTCOm/jfIxLJN0buYgAkwJ4ol4tCh/2pQXNB6ybIHMJbQmb9K+y6oQUmSVg4rxATXFpOZ6OKzxsDl4Xkoqp1Pmme14B/CbsGOp6yzP+FF8QzhR5bjrgz24QKGtFzfF8pQQC6OFvgN6zjFiCClcxtDtQ9r7W16muje/nmHuxs2dxTsuHPKWB5gGNvfqsZaJ9wtd4Oxu6VIvdUk3j5AH7RkauQ7hH2WCWk4FB7c3c/x87Sg9GYcmVX75uR9sdn1oMuGT9PorJJKJI7hyRYPwmcKTQTRTEs/qBGUMYLL2HhG36dkUhUIw0EOxid/WQbu/Gubx+9hBk0gANskNcM2Sd8eE4tz5X1KoIs9k2Ed8cmz/0RJmC1O7NdlLFDWvaxfPLdhWeGES4BrjAFa/bWF4/WhdjUVb3oOlXywwX4nOtfN+jRClNAelZnJFyvrRVGSLQGiH5jZX+7gPai56rKEIRGJuGFA3axXIkrKr1+kJL36ZQiT9qDZC4l7B/ehgkdApBE7YDbi4eAhNNBDJymuEfUZobFM+fFPTEyvC8y+ZN2W0tqkQ6psxh7G83jRnkOvtZ+zF0+jE6hG3x+k3KVQ0yHlnDaeDpGtYWZlz7mPzfVPCsUSGPmUJ858V/BUSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199018)(5660300002)(4744005)(52536014)(41300700001)(8936002)(3480700007)(86362001)(55016003)(7116003)(33656002)(38070700005)(2906002)(38100700002)(66946007)(122000001)(478600001)(7696005)(71200400001)(26005)(186003)(9686003)(66476007)(6506007)(316002)(66556008)(66446008)(64756008)(76116006)(91956017)(6916009)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?83X4QmD9AgNbeqq05HskHHe03zI1DtDPVoinw47seR/4p1bIMGBFTaaB?=
 =?Windows-1252?Q?5G1PfrYGBXTBEUUmxz8v17/W98/RbIBGtKkeFJU4HFs0wCOxd3bCjFoi?=
 =?Windows-1252?Q?Jwnkxpnm3H6I6JQ6SVvsWM1q0hq6jOSo2DnJ6Uhiiz9LQSn9ExMHqA/M?=
 =?Windows-1252?Q?ghnRYG5dqpRFgWkImTjnFPY431q5kjIfusMTHTqwTS3kYl3ksMO62xda?=
 =?Windows-1252?Q?14Drx/oQCOQFe25MqgSpZ/zABbDNWKfpoIaFWz2Vs3JH1PrKthtFAVah?=
 =?Windows-1252?Q?KfS3hpTczbCvDVK1jkaDx3s65qyKEHCzEQLchlVGdpgQk7B+akVEDcjF?=
 =?Windows-1252?Q?89mBr+fOxyVJ1lJQ2gpRMQFoyp7CNjT4mRwvbZwOjvDgv3vCH56HAwB1?=
 =?Windows-1252?Q?yAnT757JRTAiFFI9ZAbOKS0wSnBC/UKBAuI4m3AL9VeSJv+CAyv8tRgj?=
 =?Windows-1252?Q?5ufxZPZTt94asSM0sc8dkkgjrb/7sPpun/2ZeuDCvOc8GFMJG0NCsQ+e?=
 =?Windows-1252?Q?3lfc5TMmAjTFaMfDkOsu81Ny124rVac6lc3OZRFXlQav7YQzBjUo238e?=
 =?Windows-1252?Q?gTtqLMtJwZSU8LGmE3WH9iEahU3QpbVHZhgfkcWXi7UMpnSZgkm6WMsg?=
 =?Windows-1252?Q?4t5nnUDhcPuS4xaIyI/i92hLCV7jju0xaM3b2PKQ2i/CMCoOaSBQ2NpM?=
 =?Windows-1252?Q?2glRC47si77MoCoewPzcELhAH1oXm9M10ZANM7ahQ15dL9kWL2FHJXdf?=
 =?Windows-1252?Q?v21ibxT3GwxmyZXKi360BLOgYm2ZANwrh48g2Q10t1Qqzz+UvgJLoCBQ?=
 =?Windows-1252?Q?ryKbmn8YsybkJtEADnpcUdlJAymn9EUc083o/Q4KF3hUAoNYtll9mzF9?=
 =?Windows-1252?Q?yTfD70WXqVDFKNJKadFQpcW+xU1xfthQs96P7kvCwWqR3bYYpLH2Ea+l?=
 =?Windows-1252?Q?rS+B7U486pVvcA2F5Ayccp0AR7XJmpCSe+0JNkWxURFcfc/7ouzG/Jk4?=
 =?Windows-1252?Q?M9rfIR2IO4LD1fw9Y6F3pnjFqFLp6HL7KxhJNIjAEkSLKl48l7Vd4owU?=
 =?Windows-1252?Q?fnYVvxPMFAqwUBZtaaFhn867Y5COtip0ViEApOrhT0pLqqg3ojMFJntO?=
 =?Windows-1252?Q?U+CROi4v0vL4UNk6I3yhveRtQJRnCTsOm1PmUCW0FH6cO7yMaiA+EIL0?=
 =?Windows-1252?Q?+35j65jvO5xt//wT5oS1mxQKiyUK/QUVNQCYg0tdKC/7HwKponNx8DI2?=
 =?Windows-1252?Q?BzKLe4E6CWZrAlwzg/Xk7Sdrq66scrB7ixXDIsa2PwgE8Oc5jqYeW57A?=
 =?Windows-1252?Q?THeKNCuJUudmyxEWFuR//PLIMaFjPIerysX0/Q1oxYS+v/wI+7Y/HUgF?=
 =?Windows-1252?Q?24GM4WDkPhUekNKm4Sc2ouelnbwPBU9CmowHU7PC/KnLw6lsJaaIKbn7?=
 =?Windows-1252?Q?gi7RsCnnyEH4RTcHpPUGGVA3UMaUTEsp+0ZPZhYjmenpxIKGxaXV0+IS?=
 =?Windows-1252?Q?WOVdDAGz9py4D3OqU/5OYdWC0exzkO04cYOMDPmLvEZ29ZFgeFl+JJp/?=
 =?Windows-1252?Q?MTpqKPMw/QR6OlWKNm6LwsoVawQwhw5FagSQqrupWCn/N8OVPRxyTx26?=
 =?Windows-1252?Q?/RfZpLEojZeWyYA7pvuvVbFwVvTNLdhq5uQFcSry5Qf03RJ4kjADMxpO?=
 =?Windows-1252?Q?Ctcf5PU13t26wSK04gdl+a9iZ1XO81d8?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaee2dce-f34f-4051-82fd-08db15e8c4c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 21:56:08.0422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OlyQHJuAOsCUMsOTZmQb8fhE1cryU7xoqVzRY9zl3nX0lXtzBlPNcXGKxKuN8Rvcs/BFpzkwjoCZF4dGze8fVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4106
X-Proofpoint-GUID: DVrfVS6EMjBWrDYX_r6W0tcsOreFJmnz
X-Proofpoint-ORIG-GUID: DVrfVS6EMjBWrDYX_r6W0tcsOreFJmnz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello all,=0A=
Section 9.13.3 of CXL3.0 says "Program the HDM decoders appropriately for e=
ach region=92s base and length from=0A=
Get Dynamic Capacity Configuration data" and "Get Dynamic Capacity" which c=
ontains the start DPA and length of the extents. How is this DPA used in pr=
ogramming HDM decoders ?=0A=
=0A=
Thanks,=0A=
Shesha.=
