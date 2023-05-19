Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B55EC77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 19:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjESTna (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 15:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjESTn3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 15:43:29 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D78186
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 12:43:28 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JI6mNp003818
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 12:43:28 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3qpe3r8c65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 12:43:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHtDHpay5tr2sCCqwtYE81Z2IfntjqT7+7SieOAsaSC8aIciacGtw16asmirGTHwmkAf35u/AE5Rw92yXElAOsF39eF/EO6VmcHNX9WkhOFyTLANyoGIn+i4SF3vnpQlHI2N1TjwW6jlK7b+KFXUGF3gv1ySLwGdKBkXej36FJGfZdhKgPWUBVl/pByrBMhNihkzZbXKaYvY8X6jUNowIFERgEoNypZgZi6K/pkO4Ibv3+q1BAK2uxZwPvh9fRYM/o3XBfVIOCfKH3jMjcpkH7ZeI5tM71Bb5zgmWJWbOG73dHY2k51mVHhCybH3i2Mw71wTpIRQ0gvK3m2vJX+9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l0VHSRwt8Ivw47QiZz786p66Vn3jkZ2p1RU6qrfNvI=;
 b=U6PL2qEjPmSS48bOarEJKbFgkjH/gDeqaT08BRY0s5hpwDorCFWtVuVQ47IBIfS+3YcRQZxguhyA3tY1ND9iwiCXvSiqgwfImNuoW0a97bRHx5ZdUicz77IPVEJonUmcaaZ5NCN7gDQobiyfa7BXbop6rWn4aaHI045RPSfK0oJJ2zBl8GoH9M3G1pEMiV+T7/STlxEDbNHzxsMP6rEP7sYMefwG387rNp2m7mXz1X6tlZjxRug9FblmjGm5zMTKNCR/KSKz/Ie0D2eqtnA/11wF0KzQzJKglJfzZry28Aq5HK++P8MKSso5mgUQGFLqwBf3CKEslKo1FC80AEoi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l0VHSRwt8Ivw47QiZz786p66Vn3jkZ2p1RU6qrfNvI=;
 b=UZ9mHiEmndTmrCMXYPlOekwj4VLRdPvxsjE0X98oySsmCaEq9WthEEPVYzlk941BOOF38s0Ugf1URPamaYLLxtypq8dKdQupzHLWsgGkbUVS/woX1xcZIaYyYgXpNOHgy0aEwJM8tX/BvRySK/+oXlMbAu7fAulJp6ioLAxvcbI=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by CH2PR18MB3253.namprd18.prod.outlook.com (2603:10b6:610:2f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 19:43:25 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::ca52:1038:43b4:2fdf]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::ca52:1038:43b4:2fdf%4]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 19:43:25 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: I2C Multi-master and Controller Slave Mode in QEMU
Thread-Topic: I2C Multi-master and Controller Slave Mode in QEMU
Thread-Index: AQHZiomHd0qPqIKI60KGfLR7fTfylg==
Date:   Fri, 19 May 2023 19:43:25 +0000
Message-ID: <DM6PR18MB2844C8CDBF085BE599F98EBEAF7C9@DM6PR18MB2844.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|CH2PR18MB3253:EE_
x-ms-office365-filtering-correlation-id: d9c492e7-938c-4e45-ff98-08db58a14fc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AaNAOIRADYlxluWdrFY0d3CFZh821e38E1CN0v77zKztQL3+kD+I0gF/NkYuKwVmDgd2idOGLJp4kG/uRt7ljHUp7G4J5ZFpHwT5+27j67py4vQomuQgkkBolm1abGNXgnxOlROL/+2n5FrdCU9tuUConijYKA7Z7stAjVtomtz0fpQXskyGtf9c+10kT/lVQsfN6NkLOfBRLOEWzq4Cq1rg32CZ1bs2bwy8VXZjVr/eHpqyPSHSSjXAWfe6gw/VjgXWzErYH8oBN/HMgovOTA8v8IKHuPmzo/QRsyvyc+VcOzPlmTVRXpzs8yh282nCOthBfBNH9VEqDnTv1dXjY5oROPvKMB2vUennK1rm6Xis+Jb6qFkkX6aOxQAMmCW++dp3JXnYFpDHByvFAZw8CdlpL03kZRZOvTD9zLoF7AEYRmg4exuJZFu4vkKxjRagvkhqriOMIIR3Pw8SK6l18jh+wkAycnMw6ulW0lhAGB5W80CHNwuJoEkhiLj4tMwkg0W27GRY7qb1Y0vqknsvwf0RU/eKNR7JTlQAXYWx1QZFdYcyxJJbdY449ODtPfkfzZHNb4SxJ/LkzEai35FzUEP5dBKkJsiXDnp79pNqiH302H8HH6TzQSJnAbzk/UK+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(2906002)(4744005)(316002)(52536014)(478600001)(41300700001)(8936002)(6916009)(8676002)(5660300002)(71200400001)(76116006)(66946007)(66446008)(66556008)(66476007)(64756008)(91956017)(7696005)(26005)(9686003)(6506007)(38100700002)(186003)(122000001)(55016003)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tr/IvmKbbzRJ1yRNqN3WwWcv5LtKIRet06MXMbF80hXJW+6NSjc/f0KKqu?=
 =?iso-8859-1?Q?x4kismpGsvTcyOxE5+cP7sjwCLfXRq6gB3q7dO0vd8C25SLVLpt9BwVTxG?=
 =?iso-8859-1?Q?BC+tykPIcb3CK7ngkuczlHVEJTRJmVt9bLsi9diDDehrR2z3nEKLey4+Ky?=
 =?iso-8859-1?Q?17eizQ5LyQw9FgEljzG24WAVwDZZWaJ/A+txpK0i+vSQ/z0CUjuIDHOF7v?=
 =?iso-8859-1?Q?RJ0Z6jm9lE1W0fksXnDwvtnswHtUSND04nOQwl+AzA2906Uo6YyQT0p7sh?=
 =?iso-8859-1?Q?OeQ1zom1OgOb4/yYFSeXkLtFC5CIFh1Kxd80xCCtjoDaAbXPBhM2tOTUNb?=
 =?iso-8859-1?Q?RUidHYGA29u0mtl29S9cN8wNIvnqetn5Lje8e6RBO+Sg0K2KYoJl5hMZBV?=
 =?iso-8859-1?Q?JIA1k6UsYLHWhJnVGw4SyzYfOYa9d9HFN+M/aSGVI0h16NkXjT+tFSM7TN?=
 =?iso-8859-1?Q?8FCEiErRHdILNNgvAXqkVCi81VInlhdeRYLANJGuuR7s/6aXMTbwhG4LBR?=
 =?iso-8859-1?Q?K7ncKug+WrY4czReGfLVcH8k0aWB2F7+Gk88RaEujyowZaBbAfUbz6Txi1?=
 =?iso-8859-1?Q?FDq/lM9urr0gsenn7DaUgN5mX5zczNymyjf8pzejmKseZkxPW6a/0Qz+um?=
 =?iso-8859-1?Q?MSguhWbTnizu7bs4D5Ldj7YZ3pZN5DVVXMU/4rkl2Ehz/2eYzsJARZbIAy?=
 =?iso-8859-1?Q?aa/UK2QAu4fAMCBqpbLdnG0Y0dZ9QLN7N1Orl0o2Igjbh3Fte1w1z8Qryd?=
 =?iso-8859-1?Q?gW5PHp045WZOp67FTQACizPpJFum0yUrPIRs5H1zGfAkgXP141mx7NOUNy?=
 =?iso-8859-1?Q?pCdKTgChdDr1WSOmbHMTdy3AsWkou5dMmiRprFDb1AYyoQYuin/xJPBWW3?=
 =?iso-8859-1?Q?xinqX0a5IJ9s2dqIhyblXU6Ky4f9zOaiXoBLRjB4ZTNY+UtoFkmuf5woH3?=
 =?iso-8859-1?Q?KbrSDN2SPZjXU6TEo2TW2fxhBM8W3U05b0zVG9219axSRCbpKFIQni2cw/?=
 =?iso-8859-1?Q?A5acE+wuI62q73RY1QY71XpTCCB9UJD2iPtpE0GtqvUgqTwbiFLlleaKc/?=
 =?iso-8859-1?Q?J7U1gbvqFPITt6vCq0y3rABfwUSLeErTpiUZxEC1t1CqqoaCYsukwXYArL?=
 =?iso-8859-1?Q?beeTIW+7hzT1AQelcX6xU4+uUsiZyUJ8QR5JD7yOD4JFM7JulCrO0CUAMN?=
 =?iso-8859-1?Q?lh1T9WRb3lBsrpCS5nfL9Y1oubSvDx9MZ9Uqrjpaq6x2rhe1zlhKNtcvw5?=
 =?iso-8859-1?Q?u3QqqiSw04v10u6Rk85dQsoRZ+PlTOxMYaNaYAhBzL7eeMEFhV0bbOKxb8?=
 =?iso-8859-1?Q?iW2kKKGRjQVbDkXOdnrqObTnBRjGcDoUiA1FkvpyMrfo3D14MW2fm9oMiw?=
 =?iso-8859-1?Q?pXXhmBwQ8KojWlBSLj8+rDIrIWYwgxINGNHDDL8xD7q58O2NNbfEJl+5yd?=
 =?iso-8859-1?Q?mhXAXxSWGuTDueoRncIisUYZMT999EYRKXwTwD1lpA/JlW6/plWr1JpwnU?=
 =?iso-8859-1?Q?dssScUsZq9OK10bY+ZLPhhAmHxpGVSQnxWcvsDoHCu4Z3EBN46fJgbt5uA?=
 =?iso-8859-1?Q?WrRRUHH+sizaWDoGMnaT7MqoZd+HdQ4HSQmRRCAC6k0VViONmFlp+eeMwC?=
 =?iso-8859-1?Q?1d1Pdki3LGad0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c492e7-938c-4e45-ff98-08db58a14fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 19:43:25.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDR5dcnHcsyk6ziIa3O2GEQM25wjDSjdIfqZ0nYA48Pa2LtpLvz0owpFzn1W82JIopXr6+na0gxfl3vO4z8yGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3253
X-Proofpoint-GUID: JtvTGgBvGnGA2sNkC-18ZLm5U92GV9zq
X-Proofpoint-ORIG-GUID: JtvTGgBvGnGA2sNkC-18ZLm5U92GV9zq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_14,2023-05-17_02,2023-02-09_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,=0A=
   Is there any implementation of I2C Multi-master and Controller Slave Mod=
e in QEMU for x86 ?=0A=
=0A=
What I want is to create CXL-I2C device that can exercise DCD commands via =
FM-API. For that I need a bus that can support both master and slave on x86=
. Is there one available ?=0A=
=0A=
The second question is, can qemu-cxltype3 device be used on ARM ?=
