Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CDEC001B0
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 01:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGTBnj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Jul 2023 21:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGTBni (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Jul 2023 21:43:38 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1510E1739
        for <linux-cxl@vger.kernel.org>; Wed, 19 Jul 2023 18:43:37 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JGGus4001794
        for <linux-cxl@vger.kernel.org>; Wed, 19 Jul 2023 18:43:36 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rxj62a5bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Wed, 19 Jul 2023 18:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaWzW9spwVWfEgA4SkNYw30bkmJRyCx8UjnF1NKa9X8x3B0z/iG9nIjZN+3FANN+fmu2DwUAK/6QlgfFSjDe0HwXpPj3UEVtboZCDXhnMuLxNMNdRaUCag+QSgTXeegmNVhxx3rTy7icoHJzjEzbNPOVIUDDlfUM7Nb0dS+JsibOpLDfQggwyf1KGxrzpDLcAVkgn9xbrfEu2FD6YKn8xPkeJFO9PYGPDiVRThxgULHpYCsGLtzzEZlNvQlMf2oNb1NbvZmw/6dD53XjBQxrlYd2tJZbYZwO85CXE+1Cvtu1VDO6NK8MftdUD1YaNF6Y1/fm5+fpoctGNks4S96qMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pej6ylWrikE24Yxeyz+dAUPAqa4rPS5xm8yKXEoHBNU=;
 b=MdJpjXljWBW7si0mhlaFuDqIoJGzg5hXa1gzSgZ1Evhy79x47WizHGh3k23mbhUwpKRGrrJRtT0Z99sJKpiNucrMLR947Rl30Mv8VJ/SE31GduskaTCLEUun3TDCvPJ1laA+3WIHeq5FAYNacRdQ2l9SMD59zf+8Xhdr+Tf8yT5rk6A8Mo0v11TMbUcUtLYVX2APD5ZrkSagn2s6iCVMkXf1+WOR2Gmg8RzIZ/VvFapaEAUoDok1YtA1QaAFYps9jOkk4/3WjaemFmfPpbPDGVtKlc5nt6IBcGgFKP4rtR+i141DgoDjUPhhqSBx/VxatUyC+t7ZUU7VwJDXaRB0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pej6ylWrikE24Yxeyz+dAUPAqa4rPS5xm8yKXEoHBNU=;
 b=Qpz8HmT0r91ZpRVLr4cdX8499GvnqsfnThNL4IJXpmOySJXR8RpyG1ymXccxdLfk5cAaoqd6qQuJLkO05rb8KL8K1QV1nsc1xnInFEUA+l5sIzMmeHlTvCvoy7DqneLcaiX0VdS/zp/RNHapmSKl0k6i9v4Ri2ejsv1e9F3/QHU=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by MW4PR18MB5181.namprd18.prod.outlook.com (2603:10b6:303:1b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 01:43:34 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::1f9f:7a1:807e:6141]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::1f9f:7a1:807e:6141%5]) with mapi id 15.20.6609.022; Thu, 20 Jul 2023
 01:43:34 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: DCD region base address
Thread-Topic: DCD region base address
Thread-Index: AQHZuqnZkDv72afMtEeOHX1a65KePg==
Date:   Thu, 20 Jul 2023 01:43:34 +0000
Message-ID: <DM6PR18MB2844A8A869CFB8932782DD67AF3EA@DM6PR18MB2844.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|MW4PR18MB5181:EE_
x-ms-office365-filtering-correlation-id: ade98cf0-b871-47f8-d523-08db88c2babc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EonNWGENo0KDGxCJMa6q6XVDXa05oAyT7agzuxySMyPpaDvCZA+nGfMNV3JaCBljFFkpb4jR4nTOGSeu+CIqSTNY8aRoeFA0g0KO/3QgOHlYtEcr4nt0TPxvbF4VffSDbBwjLE68hkUu7a8nh+Qi+5dBWexxqhDL/0DQGuuJVEEjVQDWq4KxfEgeVk8JacKgydtnyNn0SXC9mMY7iQmOmGhPcYicpfFZJhQsj5raNws9L9/eUjXuEaAIfY4Z5He08fnNB/84c3gRlO+SQtqkhRd8x48/Z/MJs56OLpQn501TLIRcr15+kvVWyGkBbOpAQuaoN1M3XCN1vSrwvHGK0GURye7bLQmrnHgUMdQ35LLTqPg55uyC8XhjFsmoMIwE/lBV/lPpAelo0KHgJT2HUDkR9h7hG+Ei5rn95MEe8jNO3QlXgsPDpqt3AQdb9ARsefYVXLBTEdJ3HsVhFQHIhHiHh5fXHcc5MQJCj3UfjibVncFci7myeLgAQW1WON4qkf96m9u+/iJbWGfw7cStMebsF5rKFuzurACNsF1D2AYPQce16ayJJXisBiEPqGJYJgNrMiItvK9YuslFPy9HAFiADoe+mo1ENarhvAaSqIpK6xvKSyV+VtjD4mYeIJhv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(2906002)(316002)(38070700005)(41300700001)(52536014)(8936002)(8676002)(5660300002)(86362001)(33656002)(55016003)(478600001)(6506007)(122000001)(186003)(9686003)(71200400001)(3480700007)(26005)(7696005)(38100700002)(66946007)(76116006)(91956017)(64756008)(6916009)(66446008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3l0UmttZEhxM01ZZTRxSW81V3FNZVFWR05pYlpZR3E4U0ZWNmNyVE5maTA1?=
 =?utf-8?B?bStOZDdPYmk2NjYwMDdnNUZ3aHhJUnhBUDhoaTRHWjVCZ1lTTXpxWE9zZi9x?=
 =?utf-8?B?bWJ1NW5laFlXZWR5U2l3Y3pPOWMyWDl6bmFUd1c0WFljU1czM2JwL0lsZERY?=
 =?utf-8?B?QmoyZE56VVRQZnFoUkpVZk9CNk9qT3NaRENLQndURXd3R3paU01vdWxJQ0FV?=
 =?utf-8?B?ZTBBUTd4MDhPTGs2ZE50eUVPbTRlNDR6MUdXb25QWkVyZEhlNjdxZDh6L08y?=
 =?utf-8?B?bVU2c0lmTStiY0tkUUhsMDBLUkw4L3dVek1UZnIxeTVoZklnSmVCNHE1Vnlx?=
 =?utf-8?B?T2t1cEowbXVMT2w3OFNPRXdxeUVLeDFsMFI2WkxZQ0JtQTBWVFlWZmk3NzBF?=
 =?utf-8?B?SWd6aDRlMlMxS3lMUnFrdFNQZjhUVUVhcXJvUU5CNzFaeUl4Rk9mYmN5TUtv?=
 =?utf-8?B?V3o5NGZ1N2kwT3Q5WFB2bXVjTGorR2w0S1c2cGhYU1FubVBtanRlUVVvSDJx?=
 =?utf-8?B?RHZnRzZ6VTk4MTJicDRxOUpyOVE0SEExSjVITTFoNzFlQkxvUHY0QWxGQ3dN?=
 =?utf-8?B?QzMzNkNKSG9LTzhYbUJVeS9ERjZCcDlUb290RG91Um5pbXpqTUc5amJUMzdl?=
 =?utf-8?B?cTkxQk5YWWVvTzViWENuUEVrV09pWUQrdWs0Yk1hSWtNRit3UjZoRUd3YWJ6?=
 =?utf-8?B?RHkxVGxjVDdubVNmQkxUT0x4NitKcG1KYzAyS2RkNWJVU0NmMTE0aU85TUll?=
 =?utf-8?B?OTlMOEo4UXg0bzV2eEduWVJRcXRrZnJjazR1R0MwN2FDVTZ2dHorR29PTDVY?=
 =?utf-8?B?Q1V1d0s2NUczYzUxRWRRN1lGWGtCbG8xV2pmTUhBcFVETFYwdzR5TWdTL0Z0?=
 =?utf-8?B?bUJJRDR0bFpIWGtTcWJ4MkJCSVZ3LzQrUnRWQTJtMTg1YmpCc2JBRHRJam5x?=
 =?utf-8?B?Uzl4Y1U5RTJESGxpRHhjWWJRUGVnenNlbWhLWWpHMGtVcHBRcXUwQWNRd1F2?=
 =?utf-8?B?YjBJd1BLMnoybjB2MVB1bnNKcDJZazFQZmFQRjJ4ZWJWd2FyRkYyWXNsMjV1?=
 =?utf-8?B?ZUlCb3RGS0JBSFk2Y2w5bEl2VCtGUVI4UUNXTnByVjRQLzQrclFRVDJUN2tL?=
 =?utf-8?B?c1Y0KzhQZjc4RmhPL2RwQ0hKc3JML2Q0eTNMN1l0ZVYzZno0NURBY0Q3blZ0?=
 =?utf-8?B?c2RBaGxmSzFHSFdpMVJNcXZOeTV5T3RhRHBCQ1RmeDlpRHFiTWRERG5NMUNJ?=
 =?utf-8?B?eWc5NlArQ092R0svdjAvSTZoQVRlREEwbVJCY3l6eWk0WEpEK1hvb2NvblBG?=
 =?utf-8?B?S0lJQ2ZZWXpuVENwQ1VvS2VubUt0WGhZNm84clJtZzdDYUU2S0g5MTVLbEZo?=
 =?utf-8?B?TWRPNDlSNTk1M3hWeGpMNXJiYnI3YnR3bXRxNkc0STN0VWJ2OEdraCtlSzQ0?=
 =?utf-8?B?VlEwc1liaklSVW55Skp1VmFjQllPYUplWHJmSUM1NzVCRkVwV1N5Q1NheUoy?=
 =?utf-8?B?NkhKZlZkSDZ5aGpKdDZyWXVLOTF2NFMrV1JMaUZFaEh0VWh0MUxRUzVrN2x0?=
 =?utf-8?B?Y0hzTTU3WE1MYWZJaWxWbFVSR1NhNE1aK0REQ1ZuVlgwUGZNZ1RaU0hpRFNV?=
 =?utf-8?B?dDNYdEs3ZlgvVHQ2VUJmdkNlL25sUmpZRm9RcHNrRTl1TSs2cWtyVlFCQXFX?=
 =?utf-8?B?YXZxc2Vab1QxOUk1MHQydngvY0dtRzdmbFhEakI4aWk4L2RRQWlpUTdrbksr?=
 =?utf-8?B?WHVuMSt3OGRkTEFGUTNUMk4zLy9yc2lXNmNOdjJ6bkhHMnUwMVVvaFd1ZG9I?=
 =?utf-8?B?VEhLYVc5WDE1Z2xNMmJEV0VieWNzODd1UWZaUlV1clBJZHBtSGxQR1Q2R1RG?=
 =?utf-8?B?YnlGNFVhQjlDdXJhc0JQQThDTUF5MVlWSktjUGtyT09BT2RLRmxHd1NRTFdh?=
 =?utf-8?B?K0tXNmV2RHBnZzhhZHNPcTBKNjZmaVA1ZU1tcEhSVFcwNzloaWFmNGViU0ZG?=
 =?utf-8?B?M1YxZ2g4eGZyMHNaL3JMUlNha1oyaVZ1V1hiazQ5MGNpNWRjRFM2YW5IY0ZW?=
 =?utf-8?B?ZUg5L3RlaWxKUTM3Ukwzckx6TVVCY2xWNmNEcjZiWVBmVXpOMmZsQkF2N0Iy?=
 =?utf-8?Q?dEhIgSkpNMWJCHFCqCsy+02AZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade98cf0-b871-47f8-d523-08db88c2babc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 01:43:34.0685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvwDqOpPRLQAo5MchwlvbS7Yvgl/SfwRRZhJIVv6eErcEmcJPibEdKbgXeL8EOnti+Qd3dhQRsihxI+crufsXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5181
X-Proofpoint-GUID: uBWPMX6nmEYBP8ymFCSeF7avge2RpmT_
X-Proofpoint-ORIG-GUID: uBWPMX6nmEYBP8ymFCSeF7avge2RpmT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

SGVsbG8gQWxsLAoKSSBhbSBhZGRpbmcgRk0tQVBJIHN1cHBvcnQgdG8gYWRkIERDRCBleHRlbnRz
IGluIFFFTVUuIFRoZSBjdXJyZW50IGNvZGUgaXMgbm90IG1ha2luZyBzZW5zZSB0byBtZS7CoCBB
Y2NvcmRpbmcgdG8gQ1hMMy4wIHNwZWMgKFRhYmxlIDgtMTI2KSwgcmVnaW9uX2Jhc2Ugc2hvdWxk
IGJlIHRoZSBEUEEgYW5kIG5vdCB0aGUgc2l6ZSwgZGVjb2RlX2xlbmd0aCBpcyB0aGUgdG90YWwg
cmVnaW9uIGxlbmd0aCB3aGljaCBpcyB1c2VkIHRvIHByb2dyYW0gSERNIGRlY29kZXJzLCByZWdp
b25fbGVuIGlzIHRoZSB1c2FibGUgbGVuZ3RoIG1lYW5pbmcgYXMgZXh0ZW50cyBhcmUgYWRkZWQg
dGhlIHJlZ2lvbl9sZW4gaW5jcmVhc2VzIHVwIHRvIGEgbWF4IG9mwqBkZWNvZGVfbGVuZ3RoLiBT
byBzaG91bGQgYmUgMCBiZWZvcmUgd2UgYWRkIGFueSBleHRlbnRzLsKgCgpUaGlzIGlzIHdoYXQg
aXQgc2hvdWxkIGxvb2vCoGxpa2UgaW4gbXkgb3Bpbmlvbi4gQW0gSSBjb3JyZWN0ID8KCi0tLSBo
dy9tZW0vY3hsX3R5cGUzX29sZC5j4oCC4oCC4oCC4oCCMjAyMy0wNy0xOSAxODoxODo1NC4yMTE3
NDg0NzUgLTA3MDAKKysrIGh3L21lbS9jeGxfdHlwZTMuY+KAguKAgjIwMjMtMDctMTkgMTg6Mjc6
MTMuNDY4NjAyODI1IC0wNzAwCkBAIC03NDcsMTAgKzc0NywxMCBAQArCoHN0YXRpYyBpbnQgY3hs
X2NyZWF0ZV90b3lfcmVnaW9ucyhDWExUeXBlM0RldiAqY3QzZCkKwqB7CsKg4oCC4oCC4oCC4oCC
4oCCaW50IGk7Ci3igILigILigILigILigIJ1aW50NjRfdCByZWdpb25fYmFzZSA9IGN0M2QtPmhv
c3R2bWVtP2N0M2QtPmhvc3R2bWVtLT5zaXplCi3igILigILigILigILigILigILigILigILigILi
gILigII6Y3QzZC0+aG9zdHBtZW0tPnNpemU7Ci3igILigILigILigILigIJ1aW50NjRfdCByZWdp
b25fbGVuID0gMTAyNCoxMDI0KjEwMjQ7Ci3igILigILigILigILigIJ1aW50NjRfdCBkZWNvZGVf
bGVuID0gNDsgLyogNCoyNTZNQiAqLworIMKgIMKgTWVtb3J5UmVnaW9uICptciA9IGhvc3RfbWVt
b3J5X2JhY2tlbmRfZ2V0X21lbW9yeShjdDNkLT5kYy5ob3N0X2RjKTsKKyDCoCDCoHVpbnQ2NF90
IHJlZ2lvbl9iYXNlID0gKHVpbnQ2NF90KW1lbW9yeV9yZWdpb25fZ2V0X3JhbV9wdHIobXIpOwor
4oCC4oCC4oCC4oCC4oCCdWludDY0X3QgcmVnaW9uX2xlbiA9IDA7CivigILigILigILigILigIJ1
aW50NjRfdCBkZWNvZGVfbGVuID0gY3QzZC0+ZGMuaG9zdF9kYy0+c2l6ZSAvIGN0M2QtPmRjLm51
bV9yZWdpb25zIC8gKDI1NioxMDI0KjEwMjQpOwrCoOKAguKAguKAguKAguKAgnVpbnQ2NF90IGJs
a19zaXplID0gMioxMDI0KjEwMjQ7CsKg4oCC4oCC4oCC4oCC4oCCc3RydWN0IENYTERDRF9SZWdp
b24gKnJlZ2lvbjs=
