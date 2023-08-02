Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A32C001DE
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Aug 2023 05:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHBFTn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Aug 2023 01:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjHBFTP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Aug 2023 01:19:15 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F635AA
        for <linux-cxl@vger.kernel.org>; Tue,  1 Aug 2023 22:18:40 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3722274A008019;
        Wed, 2 Aug 2023 05:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=cLfiq/PMOoVp5Im+WHxGEc0LSq3YGqMmqsV74LYMoIU=;
 b=jz/Z0rezBaPbdeATFJizkvA47y3AEGBDIG0A3b77d/lQh3ID3wtLAhpn3BY9fhzinP/V
 nWzUe8R93aKZoNOp13GCmDZNnHlkMcRHlnAaxpKSIVuv8OkQbP4nMCOz6pJ7PBdG+F44
 zhxauP3UOnb/FYfENxQHAhqOfrDrpUCHsHSde6QTL9mfQXU0xOne76hRZ7xnsNDkzL5h
 n3Tq3piHHHAmm6ZzsnN4/paAdpaQDvJLYsIAael3GYjjC421bDSsvDlYynViLp34ZwoE
 fPqH1Anno4ZU6noSQ0qG+l10hDZ2CphIGURAa47DUn1TKMNSlFN6W8/9lNBlU1eNX7e0 VQ== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s797c36bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 05:18:12 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 16C39801709;
        Wed,  2 Aug 2023 05:18:07 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 1 Aug 2023 17:17:55 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 1 Aug 2023 17:17:55 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 2 Aug 2023 05:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0uf/G8Vqwc2W4u+Gc+04cymTVBlJgZhxDNu9NQgGkHvGpidn4sdNw6rkN2H9j42oQPdUxDsYoyGgKUhOl08sUVXlzBx6rT+YFDKpd+ogOl863lfppCWoGJfz1BOGcWogZrROjd0AF5vwt2dUefnMRY2AJK5BUTKg2Dl4s1TnEY+fn5VW2SjvbmdNLe/YhIZezOhhHSg0+VTaYU8G93pq/047oNTAxVRfR7DzL0slozML95kpEEWb77Y5aKOzO+/eKe1AGuxGfvMRDi8H/Nyy4ZGAgtMAhAuBpeedi8um03xzp9ei7XVv/b05BeKVO0ZwG+rNLde633XOWpON4d/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/9ZnzXSZnI2JSCNUIm2TgKGzMTYCcS8v5cakFdj/08=;
 b=YSSTswRlNfxmzxD9C9JnEnKy+1K9//BgY8Q/SAxz1RDJOzbBCmyL+L6SQnrGU5C+m8pzkJUKS2p574RmzrQlN6uA0Dh34JavTroO+twOZ4GKbhTjG0CKiHvOw6dxUcnn8Ag/PRy02WR7eYnn5UDvUFOUDm2HF/o85oYDFgsvWZEeQjVUASdyMpjjIitLGBcOv7W3O6ZkoPBqPiFWj8E5ir7EK18e8Hyt43yqnbuYYOUUwk4heQSF4YiQ6zYm0EupsMs9X3bVbGIGKas6EqEk8glG0uY7Y4Q94+6/V9adsoFJC7yhUgqaXRpbB5akoA2QgXHdZbhnuUjnLlzFTpTj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:151::12)
 by SJ0PR84MB1483.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 05:17:52 +0000
Received: from PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9d82:c195:aed6:e7f]) by PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9d82:c195:aed6:e7f%5]) with mapi id 15.20.6631.042; Wed, 2 Aug 2023
 05:17:52 +0000
From:   "Parthasarathy, Mohan (HPC/AI and Labs)" 
        <mohan_parthasarathy@hpe.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "\"Parthasarathy, Mohan (HPC/AI and Labs)\\\"
        <mohan_parthasarathy@hpe.com>\"@domain.invalid" 
        <"Parthasarathy, Mohan (HPC/AI and Labs)\" <mohan_parthasarathy@hpe.com>"@domain.invalid>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "shiju.jose@huawei.com" <shiju.jose@huawei.com>
Subject: RE: CXL RAS flows on Linux
Thread-Topic: CXL RAS flows on Linux
Thread-Index: AdnDdQ/HkPSCwFRjR96+kVl3igVdZwALg8mAAFdWmeA=
Date:   Wed, 2 Aug 2023 05:17:52 +0000
Message-ID: <PH7PR84MB15824E0BBD613DB10848F87D880BA@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
References: <PH7PR84MB1582BBE2FB47C45DC4BFE78D8805A@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
 <20230731123535.00002d5c@Huawei.com>
In-Reply-To: <20230731123535.00002d5c@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1582:EE_|SJ0PR84MB1483:EE_
x-ms-office365-filtering-correlation-id: 68794657-ccf9-4856-040e-08db9317d260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: em44V2pSjJ3lscaHpfAqnXr9GurNpqlFib5AW6Ac7GQEzqFEXGLLXTKEU8awmj+7v0tB6wbza128wWHAmewo/WzemWR1ITFJokBMuPG5dvf2htYFlHM5fv4mk7edmfmHdXWllculqE2JqQamaEwC0RyxGQ/IDov6cwRJaiKUeWZReO5KOZ1emD3VaAmjdo+xRluumOEV+0HfGdz8JymnELlBN5OpmXOwzuQMIMkdNxprgp767UXPcV7eIjjAsRhL9hj1rsf8IAzNhWK8fHR2yWtUUr5Gk+1irRvun4mE/pVWfX9dD3qyfceaXYgJbkdjGNUZcKRO3SfwY932r4bwGCBRvTf3P3OVlUS7I6CifF2aqSntF76ZdIwD/vFSx2WfCOiLBAtupKmoCvcpBkc5t7Q7dJVPgfen7atoWbnkGfViZZhghcCgF0TjDkqrhQ1c5Ebkfsc7uYFTdcbmg4+/6GftqliRn+6Hgn9bwSIvtW7V0r/emzHfT7VRbYeWduYknMlu3dH2KLKYmdLoCl3ui6ZOT0lEdO15BQcEMdX2Ps0MTjFmn62ngmsAZRqxDNjjx61E/8codSj85sMKjHsENjQ+FhwS+ORBuLiectGCSyRa1v1q0qQkZnwxvLwZaEhIhSJUf3DRGbdD3GxG4WAFDVMmKxmx4a7HMe+2+3hECZk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(64756008)(66446008)(66556008)(66476007)(4326008)(52536014)(66946007)(76116006)(2906002)(38100700002)(122000001)(82960400001)(53546011)(186003)(6506007)(26005)(38070700005)(83380400001)(110136005)(54906003)(55016003)(86362001)(478600001)(33656002)(9686003)(966005)(71200400001)(7696005)(41300700001)(84970400001)(8676002)(8936002)(5660300002)(316002)(2611002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XA1azuTa+AfFHkFRRXnT5eTvirIIMZk7AUvsbEHxr0T2QQ0px15pa98DxbSn?=
 =?us-ascii?Q?QSKLwV5/kSXNZ87wl7hgAOl1YjSDDKcY6SM8xJsXkEaK1pVAxXCc/J5G5QAh?=
 =?us-ascii?Q?/IBzfaz2HpOtqbAKolN8tRCqOzJTcTkee8LjnbPab/8eSjOJaYuJq7ciq0+W?=
 =?us-ascii?Q?E7ir0INM1oJwCIQuKj/PfzT7utzW6+M0Z/nlGDkH+pH5NnHpFMhnSnf/0fG7?=
 =?us-ascii?Q?3q8UcC2pltiGwSl2EfuL74c7iamaA+Jsg6n+xXLi+C9DGYDQYY+zcxPpReIw?=
 =?us-ascii?Q?HauXewVBc1pj6xq1vx2LrrhuAR5Njh1x9X2AFGCd3T8mzOXVOlDf1OAOfN3E?=
 =?us-ascii?Q?mKOtRuAYs1XmoXSYvI3itYQCwYTtQbOx6G2u1VBKqgAzSMDhAAl9FzG/SMRS?=
 =?us-ascii?Q?SxJ4W272YKNdD0D3esHXqtsUurVl5fWICZBQ/sKsqI10AsXC4diC7kzcwCgv?=
 =?us-ascii?Q?LMQCzzmgUTM0B76ocRDyzkNn+HXYv5sNcLQrKlXbRtbRWaoiSQ7qQP9hLNJU?=
 =?us-ascii?Q?gcghcVuzxtgYudXaoGwH9hf0fuOwsMofVOJFWyMzjwMXMnn5XGXRlSTmIXVB?=
 =?us-ascii?Q?Mkqw52Yu7j2dZ4EBLOqPLXv8YrvlSRThaxjaSvJ9u+f0GGaBrDRCPGuqIo3H?=
 =?us-ascii?Q?Xf87JJwAPRCh76W05M4Mm1n2AQgDhFH/NW3EYenfz1sT18RbLaZUKo63YdWx?=
 =?us-ascii?Q?60z5I8rtsjS+5qNh7TOijZEcJ2UheCQ15r+mMZIC1Fa+zPTiXBeHMiT0iv7d?=
 =?us-ascii?Q?m5KdarqP13gqnyMfDpDPjku9WI7NbJ+ssqS1qxQ0eBNJlyh5kADLZXGE4w3f?=
 =?us-ascii?Q?K+bkNih+X7xwYS956jePwwuzpyMFYALB56dnHFUNLB5PdgQoCMAw5oddxX5w?=
 =?us-ascii?Q?k+RQsuDUd2gzQxQcAnDCwlH0JIqZeAavlD3zYr6ZnT6TB8q1zpO1vzp7vYDn?=
 =?us-ascii?Q?WNP3cC3VO3K0p2NaJpk3qM68SMEa5jQBhhmWsQsJV9NDyE/6bnAzuWvRRMIY?=
 =?us-ascii?Q?uOe7qAwOgX2QMMYmK17AYeSSxXOWuyxcZeRfyBdcE4XUBCNpveyGZW5hycGw?=
 =?us-ascii?Q?Xv+wT/iVvX+cjChIIgQ/aAxABLEl41PRuYmaHqXFohCSNNeztSXxnzcK7n22?=
 =?us-ascii?Q?lP3YkYoXKW84TokmAjG90fUqKn6+Su7jC8RNrGk+RDxyVqh+B0D5ljFEMgWI?=
 =?us-ascii?Q?gpHmDrm9YYkmCllueW+WIVHPfPgp6H1urb2vErKmRX96PagfXM7ZrHItz94G?=
 =?us-ascii?Q?JLK5K1LEPQ8Kc2GFEZJnJ2UVHyd4CoX9a+bzJJ9/MO+u9fYb2CX7zIq6+hKv?=
 =?us-ascii?Q?wZeKAX6yeBuwW2LWUL3uNsciKqIQWf0S3B/hf4/UqhCtXpRS6K/nxTIvxySk?=
 =?us-ascii?Q?J0D1fa+YcdZhrTwcLE0vjSKOKsCKIAJM8sd6Wnuou23CqypynmQMBxwsylge?=
 =?us-ascii?Q?kjM81k2fag7dJNgbkrXdstFb87KLxE8vmbjBBcqlCHIxEgKVPUMOz/PBe8F6?=
 =?us-ascii?Q?i7INVwun9vaD63L54WcCeL/or44C8dnKp0Ov6NaFh/Ss1fx4c/FKK4TE1mO1?=
 =?us-ascii?Q?j+eAjHFLajUhtCh1GkFR77AAgTrH0OFz209ROHkcFb/1MA1ck7OZ1MT9Gs2E?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 68794657-ccf9-4856-040e-08db9317d260
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 05:17:52.6091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W71l1ja8M30CjWfBa8j6ekxc5rhf40Jx75KP/Jn98A8qZ6+FabUC3Jq4rGk1BdbyaCrThYJwHv4uBhCbEZetUgYErOgJSxXYcAUmu56+6/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1483
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 9h7GW2iqXS0XeWFegbfE66FLMlDp_MKN
X-Proofpoint-GUID: 9h7GW2iqXS0XeWFegbfE66FLMlDp_MKN
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=859 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308020047
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks, Jonathan. I will look into your suggestions and get back if I face =
any issues.

Regards,
Mohan


-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=20
Sent: Monday, July 31, 2023 5:06 PM
To: "Parthasarathy, Mohan (HPC/AI and Labs)\" <mohan_parthasarathy@hpe.com>=
"@domain.invalid
Cc: linux-cxl@vger.kernel.org; shiju.jose@huawei.com
Subject: Re: CXL RAS flows on Linux

On Mon, 31 Jul 2023 06:06:27 +0000
"Parthasarathy, Mohan (HPC/AI and Labs)"         <mohan_parthasarathy@hpe.c=
om> wrote:

> Hi all,

Hi Mohan,

Great to have more interest in this aspect.

>=20
> I am very interested in the RAS enablement for CXL on Linux. Is there a R=
AS project for CXL/Linux ?

I'm not aware of a separate project, just mixture of work in the kernel and=
 standard tools such as RAS daemon.  You'll find all the relevant stuff in =
the archive linux-cxl https://lore.kernel.org/linux-cxl/

We are definitely only part of the way there for RAS flows - have reporting=
 but beyond that there is a lot of work still to do.

>=20
> 1)	Do we have a design specification somewhere on the RAS interfaces on L=
inux for CXL that I can read on this ? Any document describing the correcta=
ble and uncorrectable error flows for CXL.mem?

From Linux side of things I'm not aware of any public docs (there will be v=
arious internal ones in the companies are contributing).


> 2)	Are there any error injections tests and testcases that I can experime=
nt with to see the RAS flows with CXL on Linux, using QEMU ?

The infrastructure is there but we don't have any automated scripted flows =
yet.  Note we got some of this stuff upstream only recently so you will wan=
t to build directly from the master branch or wait for the next qemu releas=
e in a few weeks time. My staging branch at gitlab.com/jic23/qemu (cxl-* wh=
atever latest date available is) runs ahead of that for features but I don'=
t think we have much ras stuff in the queue currently.
https://gitlab.com/jic23/qemu/-/commits/cxl-2023-07-17/=20


Documentation is lagging as well, so most of the instructions are in the co=
mmit messages
e.g. For poison
https://gitlab.com/qemu-project/qemu/-/commits/master/hw/cxl=20
For DRAM event records etc
https://lore.kernel.org/linux-cxl/20230530133603.16934-1-Jonathan.Cameron@h=
uawei.com/
Similar for Uncor and Cor events... They've been in for a while, so easiest
is to look at the json files for cxl
https://elixir.bootlin.com/qemu/v8.1.0-rc1/source/qapi/cxl.json

For now RAS Daemon upstream support is lagging though you can see the RAS e=
vents
are there and there is a pull request for the various event queue based rep=
orts.
https://github.com/mchehab/rasdaemon/commits/master=20
https://github.com/mchehab/rasdaemon/pull/104

Injection is all done via the QMP interface qemu provides.

I've not used it but I gather https://github.com/pmem/run_qemu is useful
for bringing up suitable qemu configs to poke.

If no events are coming through, check that the internal errors aren't
masked in AER as I don't think we've fully resolved how to control
that masking in the kernel yet.

Let me know how you get on. We should document this stuff better but
as ever there are too many things on the todo list :(

Jonathan

>=20
> Any pointers for both would be very much appreciated.=20
>=20
> Thanks and Regards,
> Mohan

