Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B78BEB64DC
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 16:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjGNQab (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGNQaa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 12:30:30 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99F42723
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 09:30:29 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ECFMwA006926;
        Fri, 14 Jul 2023 09:30:15 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rtptxb570-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 09:30:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWTgcXNQQWwug0kYhy34dd2M8ic2j9zYE7ueTSWIzhbjZDEeQM9Du0GVIOdNoUd2fTfs1Z0FS7tP+tyUFkYKysxnOJogCjdsW/rQpAsFqvGyDspfZW82i+87TyWOJ2uXJEc6rP6aD4QqdQWmcraN1u425DuaXGUQ2h345QIE1/qsnC1c7CNclNX8XLJf8upS3e6X1eusp/OZ3vfYmaVHXm9c+RbDd4LdkuVEBxkFUIanqmofk6Hz8Pr1ZrQQbP83teyLInEGw7FCKgNpoR3y/vHhxMtgIo18LgrkCienrNdjQDw+AY9uYNxov740tJKgqXFIw6qXnGvtSsuXN7bpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPwIhupVYyGFTWSwqoGzLgp4lSWxZanFYoK/0uLEOqE=;
 b=AviKUu8l4U3fKMYHKDEVLi07Gcat2tbNNsS1ZhZYmZJRc8MmT2QhLWPgDNqBqUIvC3HVzbrhp/42SuU6dgwMpu9FJ0umd8Xu7qnofghJpCYl5aciiX67pgY3NTsAyFArcYhs4gsZqCGxKj4vQFQIwISvbV0kQ+DKIAPCDPJT/s3QqVnPM3ZEt+jw29w3mMI5uVaNPKmE422n6NlbM2/VQlFbe3eNOcs5YD7ojaZS/FE3RHGxHx4CWZ7CRnQ+uHbRaHpWIahMBrGr5H5kZrJ+Mvn/NvPWF2myAMpNLP3wIvz8QfmXban0kjfKWkgBCVzFYbkYgt8Tjw72zdFxt8XPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPwIhupVYyGFTWSwqoGzLgp4lSWxZanFYoK/0uLEOqE=;
 b=G8lfdkudsn8iWzNJ59dwZdWUJ32WU7JM+5x0Azk4L4VNPq13KDJQz8bjuvuZD+Gge9DNwMnnSCk3EdpnUiNXEuM13qC8uRS9ASO4uGtN6ui+WiPgKrJf7T5fncDICoYTh5lha3kzG2ND/3lZ8pEeYBwKI2+xDDop1ultDrcUSeo=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by DM6PR18MB3588.namprd18.prod.outlook.com (2603:10b6:5:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 14 Jul
 2023 16:30:13 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::2062:be85:326:f267]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::2062:be85:326:f267%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 16:30:13 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [EXT] Re: Region ID in Initiate Dynamic Capacity Release
Thread-Topic: [EXT] Re: Region ID in Initiate Dynamic Capacity Release
Thread-Index: AQHZtdNYoBbsqj5G/UeS++gHMfD/fa+5I2YAgABQYgM=
Date:   Fri, 14 Jul 2023 16:30:13 +0000
Message-ID: <DM6PR18MB2844ED1B34E4E54C3D00EAFCAF34A@DM6PR18MB2844.namprd18.prod.outlook.com>
References: <DM6PR18MB28445F66E323501519D4861BAF37A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <20230714123710.00004140@Huawei.com>
In-Reply-To: <20230714123710.00004140@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|DM6PR18MB3588:EE_
x-ms-office365-filtering-correlation-id: 05296006-7a14-4cc1-7599-08db84879958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iFMS5H4YBFYV/2mXqnkz0Vj2/joaHbi2UrLC6Jq5sUc3ZdFhJtZqUEcHaD/j6/ksuZrnMybHFofW64icBcCjQXi4VRoqDlMzf6SDMbKTLzrxMMnCuyyBMGwmSonr08uthEIBekp/UH46Fbp910/CCYvwUjT3miDxHFOaAqG+Cgl8F6vXq83Vb8y1qNup0lCVszqAnlYc2/9TRB76DdaOXKD4WjOMkmDWONTA4AYwicrfLxYa9+dPlYcM8SqlDaO6qsMMic4emCPQYNsbKQFL9wREzYrx3DJArXkcdkwqsJKFR+zz95lQdJeJwJsuvhGGCTxY4szYhhbY/tA0GKGZHZujWPuIHA/WdyQN+5SpjxTXVpM7Zqvgq4kVM6WmJT3KMNXhrRTnki4ulaiP3FAZR0zjpsHl4sdY3DBi0gLBUuCGt3U8RyYMW9FOKjC4I9V9LN5rZKb0TEtxZvUDA/ARNymJKUj1DFWkPqBpvfHO0SJpYsVM9wbX8wGAVmzxVLVYlu4zkFDcK7rhAXsBsgbiqRr+sJUyBNh+gExMEKRM3PzyKKgk9WlS8CJ3ORLglxTamsqFeD298wvG4c/uTfZ/g3atJHtZG6RSLesND++A3oKR2WKiOAH+RtYIfxZ3OGHM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(55016003)(41300700001)(33656002)(38100700002)(8936002)(8676002)(52536014)(71200400001)(5660300002)(478600001)(9686003)(7696005)(4326008)(316002)(6916009)(122000001)(91956017)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(86362001)(2906002)(83380400001)(53546011)(6506007)(186003)(26005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3hcAslQFw//ohPLEjv0Qg4cO0f+7l3WRfPQJkHLbOAkMLNMo/2f58RWxRP?=
 =?iso-8859-1?Q?3N/2E0pldwVFc8igDM8WGWeopqW+HAtwBNyf1CmN4SBZfbVeJT3AM4CEuM?=
 =?iso-8859-1?Q?lYCJyI/ABlYuUCM7UR6msTZR01tNozgzxe8tshQ3NrE4APQWi7MolFnd5u?=
 =?iso-8859-1?Q?Al8jWhgj5nt8yVQcRpxZdsrU5WFwoNUkfj8V1G1PyOrOTm3Qdr0TScotr7?=
 =?iso-8859-1?Q?9jhZ6lPlwSGb2aIRZBwkV33k7IbRUj/6ok27RGng5YZ0OnbhtnuZS0Ssxa?=
 =?iso-8859-1?Q?T+bnO4Y7MfHvobCJbSdwfpIMVGV3CMs39mDhaaSnYDjSWtV96twBsS1BjZ?=
 =?iso-8859-1?Q?g09HrFadTuH7oAPOk4xUX1O9wknqxlVHiN4wqsJvH13keFWF4QH+bn6gRR?=
 =?iso-8859-1?Q?cl2ZnfqrOe7cbaKpI5o38X/vqbvCPxC+1SIiFWTDmssJw3c37o/qt9rAZe?=
 =?iso-8859-1?Q?vsuLlMSyK5CKS8206o4G0zvSeYBczr1QlDFDCtw+MEGlj3ZY5yquukWA1k?=
 =?iso-8859-1?Q?mjJWjfjWMjAXH47n1ZIGmqiXWQhtopimPql/6o9jlPSSC71QonVx8dIdl9?=
 =?iso-8859-1?Q?3Uk3Sbtgl+wWlMtvNqIfv9i4dyfFSNbNsmyx9XXsB7WsOUEiPv1DjnNL2d?=
 =?iso-8859-1?Q?nTEPbTu9asiIMmfLQuwf1sTy4fA4UA1KApxuhetXrMa35XlDSuRHLyeGBd?=
 =?iso-8859-1?Q?WNYh96auRaLiOBhhoX+QHF507iXo1qFoH2zc7dWBMpKOYOFSA/QZFXhsRj?=
 =?iso-8859-1?Q?XsWtxQ3ZkXj++93h+lxnZilHd/5AQBmWvZ6nal1jLeUIeGIsLNI/Owxu3+?=
 =?iso-8859-1?Q?8Mezfn4N+UehDg+wayKcpit2j+iqEtilNp0ylXzU1x2WW0NV+xDywx2vlm?=
 =?iso-8859-1?Q?/0XvW1FDlV8ABZxRmxmxIRymfLLD9RO0+L/V27m35h7AEU9duZop/Nndan?=
 =?iso-8859-1?Q?/Y72Aff8aDeDJSpStAgPPi1qXrtFuzYCjzZtI8h5VmjiGn9R2yrO0Jhi2D?=
 =?iso-8859-1?Q?aFe8SDw4jjGHxHJQQXfqjh8A1xd7zGzHfDRsulTu7ksoiOLue4wmGmJoxZ?=
 =?iso-8859-1?Q?CXfwywHZM18ZZDmlIWFqJZzN2VN4ZRVa79lse1Cp5zafVRevTz+qu4XsVu?=
 =?iso-8859-1?Q?hhz+AL1bHCPEcppc4Ba9DoFN82/N61qqr1f44RG0j5BsfN5ZQ9Gjy6QhPN?=
 =?iso-8859-1?Q?E8gjywSIcnSHN3K34KxNXj4PuDH43/hH/XIUedMq/Sk1UbGdZfS56MHmzu?=
 =?iso-8859-1?Q?7o+BtPrrOtpf5GTgw2MnNscf9eJwwRfBbZxkdj3MIAetoLxDfVUwn4j6Qj?=
 =?iso-8859-1?Q?PR6jkCLz7GotIH4qSl1PEGgSFJEb1W7SXPiq4mrGS9q/piWGmuWxiBGWMh?=
 =?iso-8859-1?Q?WQczVCrto8Spr6KLO0UiJJpThU0902c+bGSABHk7S4BNtOdbCK4B6qUAA0?=
 =?iso-8859-1?Q?Zvry8eKRORTbQtl2ei6dV9F3zTnRKER5CIGF0qP9hEj8tXgbwlEIlt41Kx?=
 =?iso-8859-1?Q?uWtHCvgWsdOU3mwA5aAM1Soe7L7bqUeFpVWA9VBhLWNvpnP0vZj++kb7sO?=
 =?iso-8859-1?Q?UCjZdX4+TONKdM835h3YaD3w6PIBu83iVIXpkvQc2tYc5kJBZHkMZFUi8M?=
 =?iso-8859-1?Q?8qwkOhhOT0thUHXiUc8Lf49O0/2Hn5R1Yq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05296006-7a14-4cc1-7599-08db84879958
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 16:30:13.1080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5p9mT0lYJWM/+mxXHs7EnOA+Ob14M9dhOEuGwa/lZ4liUc/NWXud/wSgVVJ+1XOGFu5MmeWz038bUL+Ox5aaXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3588
X-Proofpoint-GUID: 8G7fMG_EgtsWJ-nLDqMx3jMKhNubRGV5
X-Proofpoint-ORIG-GUID: 8G7fMG_EgtsWJ-nLDqMx3jMKhNubRGV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_08,2023-07-13_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
Sent: Friday, July 14, 2023 4:37 AM=0A=
To: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>=0A=
Cc: linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>=0A=
Subject: [EXT] Re: Region ID in Initiate Dynamic Capacity Release =0A=
=A0=0A=
External Email=0A=
=0A=
----------------------------------------------------------------------=0A=
On Thu, 13 Jul 2023 21:54:47 +0000=0A=
Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com> wrote:=0A=
=0A=
> Hello All,=0A=
> =A0 =A0In "Initiate Dynamic Capacity Add Request", LD-ID and region-id to=
 which capacity is added are specified. However, in case of "Initiate Dynam=
ic Capacity Release", no region-id is specified in the request payload. How=
ever, specification says that f "Initiate Dynamic Capacity Release" command=
 fails with "Invalid Input" if invalid region-id is specified. Is this an e=
rrata ? This is true in both CXL3.0 and CXL3.1 (draft).=0A=
=0A=
Hi Shesha=0A=
=0A=
Please do not discuss consortium draft documents on public lists.=A0 Here w=
e can=0A=
only talk about those that are published.=0A=
=0A=
SS: Sure, what I have mentioned above is true for CXL 3.0. =0A=
=0A=
Also, these questions are probably better addressed within the CXL consorti=
um (SSWG) anyway.=0A=
=0A=
SS: Okay, I will try finding out how to contact them. If you know please le=
t me know how to approach the consortium. That would help.=0A=
=0A=
Jonathan=0A=
=0A=
> =0A=
> Secondly, can we add capacities to 'a' LD from multiple regions, meaning,=
 can "Initiate Dynamic Capacity Add Request", be executed twice on the same=
 LD, with different region-ids in the two calls.=0A=
> =0A=
> Thanks,=0A=
> Shesha.=
