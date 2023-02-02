Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192F0C61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 17:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBBRf7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjBBRf6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 12:35:58 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D9C37F1C
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 09:35:57 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312EUf9W008044
        for <linux-cxl@vger.kernel.org>; Thu, 2 Feb 2023 09:35:56 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nfjrj9mky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Thu, 02 Feb 2023 09:35:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ykngmsa59o3CkRWjEFnZ86VKGwIAGQ3Cp5m9b+NleZEsNIwcrxtG1fiQNHyxVn0T/Td/gVykjnkTXlbecLvfj20BpPDS4p+FgU9XJoR0hIyZxZoWmo+XQJENNKwitN4ZPRI9VqEZoIbzQcE0hJ2f1Irn/0YL5B4QhRzyN0o16ILxIVNekocHtsXYx17GM/izry2ZKv4OC4NG17BNlebHh9XliNEsUrx9NKEk1sDGnMDwpSlbH64ikwOd6xacnTuBlT0zF2n7U5GLk9fx8w3G1rIeS59taM0AKKF9Joe9Uny+SVtD0nXejPFQK35xIPMvOrPCvxfK4VBabrKnvY0dfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUaZrlYyPHlqg/bOuVwYNPHwDbfYjmsFE2hYHh+RRTk=;
 b=d9c43gGxhYOfL6KvisU8PZbLNFbD3FJAfFIMnnxr/bF4YSMleU/JHCcizRr43a/6dN7akgbYFlBJHXbcicStT9FP74ldIxgRdTvL8FsmW87qolHyfQ8kAY4JmxHyVDtvnUlt/O1w1s6oc8KtSCbpWGG9hzIyEAKZtEzQKvZ6Ka9QGBTBGoNfUe2XUpBmlhm7yR2HdTtHgIfH3dGeIHhWQ5//Sa/e3xST+5Em57AQbsEAVz/hZn+6YYMAL21nRUU19MX4axFGqw/cBNZbMkdFq5Zkj655uMZQY8X0bMa66QVCq6xqsygfg8l2FzBtqonaO+c4QDrZfBHbDqhRuRsJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUaZrlYyPHlqg/bOuVwYNPHwDbfYjmsFE2hYHh+RRTk=;
 b=R43dGae6c0bK+pZ6FYLbOOLJLT8kIr/a5deIJnLHysSjZFm+e6UAd5wdxf6eMf9zwyNZdOOqY+b365ONHL3yO32ZuJmqCY2eswnIx+3ELk4J7nVLVDF5fzIWtkSm1LosyWi3eHJkZGoMuT1+0NyKBoF/tSmmiAgWviSJ7S0mOhA=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by DS0PR18MB5395.namprd18.prod.outlook.com (2603:10b6:8:12a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 17:35:54 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::3232:77bb:59d9:ae1a]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::3232:77bb:59d9:ae1a%7]) with mapi id 15.20.6043.036; Thu, 2 Feb 2023
 17:35:54 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: DAX system-ram usage by the kernel
Thread-Topic: DAX system-ram usage by the kernel
Thread-Index: AQHZNyvkJf6njRN2RkywZ+9fiejneA==
Date:   Thu, 2 Feb 2023 17:35:53 +0000
Message-ID: <DM6PR18MB2844FB8086757984EA312AE3AFD69@DM6PR18MB2844.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|DS0PR18MB5395:EE_
x-ms-office365-filtering-correlation-id: 1d6cdab0-fb36-43a2-f204-08db0543ef56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGZAGsS43syDUZNeL9bP+bcFiO/Jjort1Ynf8QOGWGhgfV4NquDTURW4PymUHkWburyeI3uu+BP97cFDDphq1UlZRaGHK4gc8xpOA37Mc7deOPSoutqJsEtRYP7cmIduNl/Gg7cxvLDCVXMHTb1Gi7pBqq4Vl/VSM6dQFcfE3jxNsTpfZJlrYgMba35CDV6oHAtaYtsrzYj02PDHu/Un2/GtXfhkVyR9tpabHQ18t+g73/OETi+s2JWMyEyugD9a3kmN7ZlmXKhY1Thl6yLM/yWqCd2dt6ylc8LTmht0FybDEn8BJk8ThruuZZeJU4FkerUuTKx6RWYn+8Juz1aZZW7Ho6fBlwZa5sRw2GXjJkA7u2/23lxsMfG5rHPMZm0Ygw7BnVqafrXSxDDzOfqCn3Ehu8JdkRn349iiRv71XTyvTN96+SEcrX2BOYXhF0+CIsujaBd8UrKW8J24QKw7BhGoWynBI3ZR/3in0NC97BeDpOsmJMQ34uOKmrIzdNquABWfGRNAP0WY6fua8jpml2adBhsIEWaHmC9TI+n5ffCC270evGxdLPuJfveQ3dPxX9V5VWnqyVXQ7eny/wDsZIYpuMhm8HzFsnCBGgaHEL7WenWJiLggI+RDWBhiywL905RaCfZIFOoLjHXRUp7/osRGGGz52UIYG9c7nmuWLIlEhTfPvq0CEC3R+/HiNIOlOe1d7yK6UuFyOTbLEvJ09w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199018)(33656002)(558084003)(38070700005)(86362001)(38100700002)(122000001)(66946007)(6916009)(66476007)(91956017)(8676002)(76116006)(71200400001)(66446008)(7696005)(66556008)(64756008)(316002)(52536014)(8936002)(41300700001)(5660300002)(478600001)(55016003)(2906002)(186003)(26005)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H7EomrYHP7EIcKfGvgbjSP5oeDbSnkVPdPWgPPtgH1Nv0ngDZNqDQSCvs9?=
 =?iso-8859-1?Q?EJjBzPVB0EGJaNQg+5EtQxCeRlYO2GrfKGk6CrefAfT7mktUwGXicSLIat?=
 =?iso-8859-1?Q?KvZq38FFoHlY049pc2buoz5X9A8Y8qZZobJX5lNPYu16b8BkrNIuDW3Xej?=
 =?iso-8859-1?Q?5qSHf/Ts5Ccfx/dLgiIsepct9bMIriS5y9WGqo0bLm5fCmrJWH/bA9jZcF?=
 =?iso-8859-1?Q?FAkZyFN1VGTOSnuG0aCy/Y313etNA2wrvAuQdlySuiieK+tjFKs8Ro+q6y?=
 =?iso-8859-1?Q?GXNTVguPJCP2TtHSH5qHjlIy0YrrOpSbqXrqI2qOTh6Sagd3w0Ay22IYUE?=
 =?iso-8859-1?Q?LNWoxSPUsyEVqt0VMG/FjldjAM4woyptwfMaO9K7vOeo2nEHgacAxuqA6B?=
 =?iso-8859-1?Q?9DlngAGGjk8XU3Yra2YbVX8nAp9gYu+CaIrTbwlc2mjFIW5YycViVW7Rwl?=
 =?iso-8859-1?Q?rWKAwGRE0+rbetCb3cyX1eRFoujoqKWgN8b+ajNzHvNsvOK2BJB+1O+uP2?=
 =?iso-8859-1?Q?j4dKnkI4FTCcFrWmx534iaKEl+Woh00sinRDnvoyjhVFe4SskZGchpECYL?=
 =?iso-8859-1?Q?c7oRA2D0BJM8szoc4JIxPm3zAx7Xyw1gQhVaNKRLGf/b6w9y9tDQ+5kV18?=
 =?iso-8859-1?Q?1UvVp+HA7Z4Xbdw6zC8kl6NeiXs0rPVGzMMy7bXCC6ESyB0noFe8jzd4Yt?=
 =?iso-8859-1?Q?2k8nJg28lwKISJEwExpRE2nMoVpb8XmzUaSNROrT2vsAS3wI07IWKdL7n0?=
 =?iso-8859-1?Q?Ll5GYAO1n7WxmWeVwTY8VSaxuwYOtPDJxq047fHlWo5myKAzIyAdspA8IH?=
 =?iso-8859-1?Q?+Kf8ICkGOUwYi3ZspcKPheLjWA/ADRZr4tTFnF7Gp5NPdRM0uR5UNyoNbk?=
 =?iso-8859-1?Q?YRo9RQZvp9ebGjqc0F+9+7mm5IbkpZIVINhl6dwprbjc4Bpi3Gt4z7Az0p?=
 =?iso-8859-1?Q?stHPjMnNAFb+AOFYluI2MoDONFY/EkikUsC80Cdig4lzhd2wyEfUSoIdJi?=
 =?iso-8859-1?Q?mfskiB/XgLUmdohxPKrREyrztaDXfmvf+jVrwt9U1M3Z92Uucfm+uK9RZV?=
 =?iso-8859-1?Q?xU/eoOpCwXBGLSpXMEMqeV1NGXkJv2Qeb6g1Djb/5Ty7QUmXLpzlQpgaGn?=
 =?iso-8859-1?Q?oM5n2FPCKfs5losi322L9b4UhZNmJ5lIVntxl3hwEaNB7lhqVhvHw4sFEb?=
 =?iso-8859-1?Q?8sVyOTo+BWSId71DWvFIOdGXNuGhh4lhvL1mcp+9kGrlzBR/MCVaHkQqYW?=
 =?iso-8859-1?Q?n3ENQyZ6PZJAw26C97qvPJKf41p9HDMVmbZ9/ecYnjEqL+7j70sbe3RPHV?=
 =?iso-8859-1?Q?tj8+Be0A8eZzKL5COOd494wOH2KuOcMPGmJKwGAEXtxKF+dLkavEHGUd8N?=
 =?iso-8859-1?Q?U+IVmivO0i4RWdTU9YufK6WBaZrXNOaEdd2k2LV0P0eQzL+L4SnzqOSZS3?=
 =?iso-8859-1?Q?Y3YOL+kc3UU0oISZUtUu2+NHvBK80aNPdElln0JVVi1Z80SI217/W3zRrc?=
 =?iso-8859-1?Q?AgwWQKPJjw3YTjVPIkPJVZCoeptfs/s+SscNVadVCiA7vlzh+Bj7b6mCPQ?=
 =?iso-8859-1?Q?vZmUIdCyH2TazNrsSWvIfkN7tuKTbOfc5cmPwcdYO799CedTKu0gCtVvSf?=
 =?iso-8859-1?Q?3eoVefPlisG28=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6cdab0-fb36-43a2-f204-08db0543ef56
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 17:35:53.8832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtXzfUudfzSGxeA1QeBd/hoTxFhunYYN77zOi6RQCLBL21lYjzkkXOkSuBdQks94xRakSNkSxk+LYYnw41SNWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5395
X-Proofpoint-ORIG-GUID: v1TJKa9TrmfgrB1-BsE5cMYszGDGOw6h
X-Proofpoint-GUID: v1TJKa9TrmfgrB1-BsE5cMYszGDGOw6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_12,2023-02-02_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello All,=0A=
=A0 =A0 When a CXL memory is assigned as system-ram using daxctl after boot=
, can kernel allocate memory from this memory range which cannot be moved a=
nd prevent this device from being made offline ?=0A=
=0A=
Thanks,=0A=
Shesha.=
