Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33320C001B0
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 21:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjGMVyw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGMVyv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 17:54:51 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A5F1FEE
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 14:54:50 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DLFcW8006441
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 14:54:50 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rtptx8fjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 14:54:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbBuLMzv7DvUMdhmRZ1REQYZ74NwHmTzBnNsajYfq3ccgVs999vDAHtx/F6Eumq1a/RIYaYZbxkbZYck6xByaTACXlaWUx53AwIGs0M4M2M5Lkc5FntZL7NmYFhJqKY0kk7wPF4r8cU6Np61Zo6+uzVA24jxw58757ipkpE7ZtQWUMcJbyO0VEHDUmmV3003neOiZEHZkuV7pKeNMGgIakoSr2cxHCG2CexUmR1n5Xjy8Nm7UQiDTS9gjxuI6LLjuBXofXXd1LE0/aWJ3tC3tjeEdi17dT2g3AevgOSKrCvngxU9zsfsaXqfmgyN7BppKrndZ/hLbNq8FFQmjtAshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fgvvv75Lx+4AvbXneF9ZaF753PbPFLk9rKqWP3Z/BkQ=;
 b=YfdSpYYq/4loImAGaHPtq1GSLplCX8CufnFPsTbemJ1b6TzJ2orSSfdjEx3uh6UdkBdfWQFPNHMk1m4Xu7A5xqsFGi59mzY/+fpic1z4gKx8bmcxNUFAg2sYWnuN+zby3sVLwxJ61SAZeFpgZsjTh5FGL8RWJfZyHTeVYsTfoc+lnbl96ITsvD/Ar9P0bpJWKgBngk+dnIZm7sZMbI6llDg1Pa/ANHLukavu9TOoDk1f9FZpq0vOySIi5FZ+MtoVKPmshoc4zwepm8ddGrYaksBLkG+2Kf576JkdAM8+rkk33obtvzzbjX5X7FHuz52k8LFlVxGqR/JAcLYw0eo9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fgvvv75Lx+4AvbXneF9ZaF753PbPFLk9rKqWP3Z/BkQ=;
 b=kZEW0y+Fon8rQYCwZ+CqE1Q1f0fno+Hak8sE3AMBCaWMg9AWB/nbx41qrqXIj/2QehoPyqnL8IT4zOsXiDvCTDg6GdFGDZdrKAlJEN/1jhGSaTqm7UX/PqKstp3iW6LiJ1ZUKi/1ApHuKh2p0uHtuLx/eDtxtX6hD5fTIhjhb9U=
Received: from DM6PR18MB2844.namprd18.prod.outlook.com (2603:10b6:5:16f::29)
 by CO1PR18MB4538.namprd18.prod.outlook.com (2603:10b6:303:fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 21:54:48 +0000
Received: from DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::2062:be85:326:f267]) by DM6PR18MB2844.namprd18.prod.outlook.com
 ([fe80::2062:be85:326:f267%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 21:54:47 +0000
From:   Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Region ID in Initiate Dynamic Capacity Release
Thread-Topic: Region ID in Initiate Dynamic Capacity Release
Thread-Index: AQHZtdNYoBbsqj5G/UeS++gHMfD/fQ==
Date:   Thu, 13 Jul 2023 21:54:47 +0000
Message-ID: <DM6PR18MB28445F66E323501519D4861BAF37A@DM6PR18MB2844.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2844:EE_|CO1PR18MB4538:EE_
x-ms-office365-filtering-correlation-id: 940ccda3-823b-4fe7-d4bc-08db83ebc68f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8XLCw5bqb3ZrSIbaNGq2yuNUISjgews8zQoa4oLxjh20Z5e2Vy/eEm0LEklNBO8RcvQtp3lyWn2Xatylg7fAkJcr94DHqDjSFLKXtemJAaJd45XbQSOtz2XQqA0mEM4GRnmdh7E/U4lTY5MXM2jSDJxQC7658KIYleVGEdzKDMwFViQlg+HetyV8F2qZlocPGKw2VBHWKbtuyel2b1sDYcW/U5Us+Ec5sw13xe1yX35z0RW/isy2eZHP6qDGlaLKlzrF0OR8ZlJCA0FpVGImSyN2gPSZ1HOe4h9zMa1HZaO1Av7NlQenXZ19xSb163A30kexfEvbo9jH9c5GqU0I3sVYfxAVQ0zMPsU7WGEc3W3yAIanu+2x7IvlnflQE4bWL51poedmWJMdbq7Aq28oHjV6h9iRGPOYe3Kr0gG52yszK3Wl2LW1wpY+gSBbYkTdFUI0kYk8j8WBjEf+P4SAdufgjhGlKRwCJI1IA/hvoxNYA3y/GL6Q9darteAFYC66NZ9Kf5LogO7b2X8/Q/oFIzityZcNAZ2b7AW6iP9C3Su7FlCPjSPokb3sctLuFHvLl2Gspn43ImZIxiC0FbggF9SXFNh5QlwDILfhezFVS7aHhm/kAQzeluHlb5e4hFFz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2844.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(186003)(41300700001)(316002)(66946007)(66556008)(91956017)(76116006)(64756008)(71200400001)(7696005)(66446008)(66476007)(6916009)(9686003)(478600001)(8676002)(8936002)(86362001)(6506007)(26005)(52536014)(5660300002)(55016003)(33656002)(83380400001)(38070700005)(122000001)(4744005)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XurJzTYmYbUhq/diTos5Vt1pTtuuVTmK3aG0sbS3Tvdz11A6kj8t6Y/j86?=
 =?iso-8859-1?Q?Sc/3vhiwDO/JQwyXubcjzF5sO61AIwN/v/rpy/oPoKA5DCoouDxAag5w/k?=
 =?iso-8859-1?Q?ClNPYkgi53I8CMVfx1vN5rvTSrJ+INNq8OSA2Ke9nKJ0umIBviIcoLIQvA?=
 =?iso-8859-1?Q?wD1gBf0iFpnElaYr7dHyeHY/BmCNDBQNqF54/YGFzrLgr5GiNP4Eb4F0DO?=
 =?iso-8859-1?Q?bkuCS0WktiifOr2PXSNPDDQF3o6JVDjdzXbt5GwaHywbmNarF+kNGtA1Yz?=
 =?iso-8859-1?Q?RCtZHQMT+C+UpCmQHEGoLsyHAmNkiUFBrJO3eDsetJVo1wH6XNh9MKGMJ2?=
 =?iso-8859-1?Q?SnYg8G/+jT9EFaI4r4+goYY4PSj7yJSoGd4YQcZb7sFV/+ZDN6pca6u47E?=
 =?iso-8859-1?Q?eKihcspoOG1SVPB4TDHm0HYYO7bv/OUCaN4Z2L1FVF6m/M5BuAfH+ZjbHX?=
 =?iso-8859-1?Q?mF2kNrrn202Brvez0VgJutCLm7vlcyw0JIPUy3RCdDKQUTjxBVrNxvdx9M?=
 =?iso-8859-1?Q?SEw3RfoRxVpYW3BYzh/WXqkZPHI0FK0waV0zPYKbcrydO4RxXiyrPLesXq?=
 =?iso-8859-1?Q?qEdP3INCuAr/YPWzOnrDNFoQ0VB7OuYx6BoV5Uy7gPUHPqV2KSsN0bMRB1?=
 =?iso-8859-1?Q?69afnOA1pFFCOyRsbIiXfP6iEyDfz3NdChSNr9aK7xMrBvqvghm6nzODCj?=
 =?iso-8859-1?Q?BdctMJXRCPGj+m2ifTcEjBCPfG9g3MvuAjVYysQ+Kqh2Q+hl2Gfj+cUMPW?=
 =?iso-8859-1?Q?baQIkNIgqHwUPAIFslu1ElbkQ5f9z0UHdk+kLRx/GYjNNm2biFsKuvmemF?=
 =?iso-8859-1?Q?hebAPlm6qrUajLuszXZ/cIOpdUJXlod+2hkpIJzPzWB5oJB2yIVCnXRsH1?=
 =?iso-8859-1?Q?0/WHVJ+ihvkpxNlrRF+zMdU/Eps95W/oKNQHkvwlE7MPH1+hht8/atkWdm?=
 =?iso-8859-1?Q?XMvGsglNjy2IcfpDYkWkTSLuXRPlX44IhIY84IpH7ge+AnKw4trCqKonKP?=
 =?iso-8859-1?Q?TcRaCmoVmC+v9odmALZUDY2yqvp7fbVjZJwG0HMK1qO4AmKVft2APxpEem?=
 =?iso-8859-1?Q?jjiKJViK0Z23pHuwRMS4xd4JJY57RMdU7pja2czLmPq+6xPKg9TDNytW2U?=
 =?iso-8859-1?Q?ukX6LknXf3U9TObN0pjZR9DkVXWIbtHiNVEEMewP2lacYk8YpjbaU+li6v?=
 =?iso-8859-1?Q?TXCkFkGxom4momQTSO1KYeVcG5n6rs9HxH5soqyYYhoAnwhyiQ2Pzu6fKo?=
 =?iso-8859-1?Q?bhwugKDnV9A26lXrTHyaYzxIGEb7noQsIItyV9NZukga+dCj4Mcoa9NaQg?=
 =?iso-8859-1?Q?Gmj/F6M+/2As3nLG8dkFe4ZTM9Rqvjb+OBlCsd61G6Sr8FOlQU5NiHKH8x?=
 =?iso-8859-1?Q?yXHr8kIXNzB1MCdTWg0fdOqvnYfJ793edZfi614lcMzFuckWGxJXwh9IgS?=
 =?iso-8859-1?Q?XTMAIPgCx0vyaOpDTIuGyuQcl/uqUUgtn8smcbgCQo5WXx9hkbCkHfcLyF?=
 =?iso-8859-1?Q?Ze+1RC4frwv8W9PC9PHaGdPijNou8O8N+/pzqNzrYmLTRVo7N0qy/kFXX1?=
 =?iso-8859-1?Q?0sjOtMilV89BG44SQQmKm9ZbyKl+q8tNf4MlZWj9KvdxWu1m/sHWwk42O/?=
 =?iso-8859-1?Q?7xtgiP8Qm3LNI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940ccda3-823b-4fe7-d4bc-08db83ebc68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 21:54:47.4683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4L6N91I5nlZxJPi8TVfTMQDobrB+HrVTqpNXi+LVxMe0571QSS5L4bDvd4ChLZA3MsSCUuOUTHnUZB1GWEKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4538
X-Proofpoint-GUID: gSYMPRhNIS_HCPBJpvETq2cOJjH4AZ8T
X-Proofpoint-ORIG-GUID: gSYMPRhNIS_HCPBJpvETq2cOJjH4AZ8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_10,2023-07-13_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello All,=0A=
=A0 =A0In "Initiate Dynamic Capacity Add Request", LD-ID and region-id to w=
hich capacity is added are specified. However, in case of "Initiate Dynamic=
 Capacity Release", no region-id is specified in the request payload. Howev=
er, specification says that f "Initiate Dynamic Capacity Release" command f=
ails with "Invalid Input" if invalid region-id is specified. Is this an err=
ata ? This is true in both CXL3.0 and CXL3.1 (draft).=0A=
=0A=
Secondly, can we add capacities to 'a' LD from multiple regions, meaning, c=
an "Initiate Dynamic Capacity Add Request", be executed twice on the same L=
D, with different region-ids in the two calls.=0A=
=0A=
Thanks,=0A=
Shesha.=
