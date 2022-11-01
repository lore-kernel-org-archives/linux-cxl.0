Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365CCFA3740
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Nov 2022 01:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKABYk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKABYj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 21:24:39 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAFD167CA
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 18:24:38 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VMPDWh005246
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 18:24:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 mime-version : content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=1fsVpUukojg6+AcRWfVCDcG6Hfik70uU42P0/E4qmRY=;
 b=Gwy1eTiWnFHRqXlbqZ2XdPZQpVzYD1Svs//mtzJlqSGfpM8XrJycQgUGKeRFpjbaChNo
 Te51f67uIkkAp2WfzdZJk8Hxs+y74G+GlIswYIlPRRx17vykbNb7Jx/GkTuMiy3mwPMh
 F164jeoHwpwNkR0zMHsjEIUXV11q7/3br12YLgN/rXP4a6iTpfRqf8RKWN5i/bWEGJdI
 AA3Hietb0ZoonVpvhjQZK/gx4RJYMRgWDNajk5TqbumcJkWTWaEpZoFU/sgKwR6sHSyD
 FOXQsomcyUBTpAvwyckCj58M9/CxQqnQA65VJPrywRfeRmDCJ7i0MTT4HYwV8jvQtRiJ xQ== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kjhkhvcvm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 18:24:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTWElpKkQDTdPbtFTZ2PJedVGnOCIEUgjiHaqOjMB5o1V2KqNZ0yjpRjbPZWflQbO1TvgvOsC6YEAEACegrZz97Nj43KjuMTWyiX95q3Cn7UQI56IRkiURXW7L1N05t/trq7bzKhrsLG0JMmrC6Fi0pdV/DPL4hCMxoCfQwDeXkoPSanFVXSky1TFCpun90axAtBvqDn4Hk2gAWzKsmmNL2CJwTpItuOt3BrTlCH9paGlKqOLufpqwAkaggw6pD3T/lkM6JWowAQtTaB1cTg3yidKLCWPvbsQr6V5i/2VVaw+fhvaR4PGWLEgWhMHvtStMHLLIg0Usm3oTQmRoShBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg+lb8PRTCHk5jgngpM1GNMjCdmOZu6QmU8hl7nrlCk=;
 b=jz+b7+r6q/5m14tQE4xpIrkmgcpPQHh6qsyFP75JyxcZEiWZovphVTwt+JMybrOsPBnZEawooWtLnvQhJQMRgmIDaD6pfRaCMpVWKYvHnwssmIpx+mNxiZmURLNG72MAgPOB9J/YvEoSRc7U1t6yGdwWLPXE27oFq/3ddK0Pa3r2fG+3l8lEv3OnCHmZJ2ArOG/+a0UoHwILMBVJ64P3vSU4jsJuIxtaPxV31Rjrz0hzfqp9gRaA2A8xqX29OrqgHo1cN33zQEntw2iZ6S8qGeJAd3uw1qeWYAIkcV5hhEHS3lc89egC4AQgpl8i2sSzBOOCzPyl2QCGt2TiwjFWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by IA1PR15MB5394.namprd15.prod.outlook.com (2603:10b6:208:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 01:24:36 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::b5fb:53ac:f77d:4f5d]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::b5fb:53ac:f77d:4f5d%6]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 01:24:35 +0000
From:   "Jonathan Zhang (Infra)" <jonzhang@meta.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     "Jonathan Zhang (Infra)" <jonzhang@meta.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        Wei Zhang <wzhang@meta.com>
Subject: Re: [ndctl PATCH V2 1/2] libcxl: add accessors for Get Alert
 Configuration CCI output
Thread-Topic: [ndctl PATCH V2 1/2] libcxl: add accessors for Get Alert
 Configuration CCI output
Thread-Index: AQHY6LJ7fiGi+zR65kWmF41FNfNu/a4o4++AgABQyYCAABPaAIAAB3CA
Date:   Tue, 1 Nov 2022 01:24:35 +0000
Message-ID: <2F5213C4-F9F6-4284-B0BE-1273865A4093@fb.com>
References: <20221025204320.290354-1-jonzhang@meta.com>
 <20221025204320.290354-2-jonzhang@meta.com> <Y2Aaq6dFXlr92W/6@aschofie-mobl2>
 <07E73718-226C-4569-A168-DA90D77F43FD@fb.com>
 <Y2BvFsTiSlOOgGE4@aschofie-mobl2>
In-Reply-To: <Y2BvFsTiSlOOgGE4@aschofie-mobl2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR15MB4969:EE_|IA1PR15MB5394:EE_
x-ms-office365-filtering-correlation-id: cb2ca46a-0e3b-4230-9e96-08dabba7d682
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAZpdbF0tH/ZU23EbslgAhJlwHpfH08zZCIO0EiRZYEuh/wcWXf3S4D8c6JYKguUWtN3JBYqGb40UhuW/2Se4qQkRN8vFUasokcIo1SyvkjIklStWW9fAs0BL0bnOYMTIiIBCJs+BDD93ejEMmLOTKDhG7LpxhOeXEfZ/NILw8gz/GimQ/9xVgBHadncr5oUIo/IFegcTiwkCEz2pZztfFcRc3DOLgM8sj1WRo88jztXoOenBWB8i+LTcbKkVKqgbzvW+KAndvpdu6qz44M0yGquLcujEDT56banT4MAB9tTnvnJokCcu7XlOQEciZYNfWUl7hs6ClQglDLx5E9VG2GiH78ox0JbJIMVTleXwvJDiZZ1/gBK25ovXyXwnFyD7vWv3oHOW/O5Lm8KFyC2dgf4bXAEd2iwsm3Z6m42XrJzqlkmCi5yTqGKE5fbDBg8kdQmxEZgLdJRaSpXKKBdZ+OanoVcibqN8GqBrONZN1g+Npl0JIXl6WevdiO8ZY1DVFQ4PeT++XJsJFR1XOXXLTQlnqavkZWDlMc4jMMwIeOCvrScQtGwaSxGOge0xMWLFvZ86nZiHBsleO5YN3khaOuJVhnhJcHiaiPnykO/hkj95yxtCoOd+GpMsHRQ3Zl/KQzvGq9CsSGUsl4NUricMuxU7Aw7MyXazWEXUXGVZZHLJ464H4SYbylDyh/LigczSdj/up+NAhh/3BcZjmZRJKfTceXsoPDB/ocvwIm+ssyZtmkPnzWqam5E8oJVWRPB3t76MTm2FMlReeHlTnxo3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(66946007)(66476007)(76116006)(64756008)(4326008)(66556008)(66446008)(54906003)(316002)(91956017)(6916009)(8676002)(5660300002)(33656002)(71200400001)(122000001)(15650500001)(38100700002)(6486002)(8936002)(2906002)(107886003)(6506007)(186003)(53546011)(6512007)(9686003)(478600001)(38070700005)(86362001)(83380400001)(41300700001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sykVhE9ssRXzGn0drI9+XS01jszsMXh8EvCwZr6bRvzp84HW+62WZCAF/ykT?=
 =?us-ascii?Q?7TsuPUQFvrIoHQlfRX+Hs1ANzXztQDXlIV61o7JQ3wD/K7s7JVDJUbp0B9hM?=
 =?us-ascii?Q?wFEn6d2yQtN97rJxf1M9blKj1HGivvv6735fCeZVjGngeCxG64ahxNhZ2ymU?=
 =?us-ascii?Q?3wC2H3afcLR8lk9Ez4x35/7Zuo5WLy9ni6rbVVJoiTEf7m/yW+yRXha3ZnAz?=
 =?us-ascii?Q?ztMKVPdiIgAVuU8xrs29Q+l7ZHDrcce6Tuyte5g4dzmQ8Uc37kMHckFYz5wI?=
 =?us-ascii?Q?wbC/TH5SNFhc20M04Pj+9sdAzW+nYKjQqo94Xv5xGJl6DMIySnEyW55vHMVx?=
 =?us-ascii?Q?nE3WeVUvt+gdjs9oKIuAdNwAh+Rt0aWpoW8mkoWB+RrrnbKN6VFXOz7A7Qo0?=
 =?us-ascii?Q?9mTMcPuP7bEkWYI1w7Q+V1+gdanQTSipMCEhDPE8TzHqr86zoGdTkamal1so?=
 =?us-ascii?Q?dezgZohOSJGz2KOuVAEj/H/BJN9PxuMq8DBIHDM6zSHuuXIgr6JrTthTZvHw?=
 =?us-ascii?Q?1/0vLgnULnovDQ5vWeCVq6BzPwd/C2iT10K+xDtmqYnDevwq725HiYwDTUf6?=
 =?us-ascii?Q?3pBX/XcjeLu7FFB06/xkHFrhAqwYDPbGU7JL0q+3Nvm92ouEtGS+B4HgMomx?=
 =?us-ascii?Q?hrrDiVJ0/Poj7qcXlvEUaKd+6Ix6/f3Uezt/19t0UyHkcIKnq7fLprKv4PfH?=
 =?us-ascii?Q?llJqB1Rzs/wGbm+Lylot1AbjwplBSwiXyTwpFb8prpSh2j66uWaPSBem/297?=
 =?us-ascii?Q?Qb388iWSix1hi5W7pm3eKWvHq/i4GnqZWAT4slPIZnRrUDzVPRwPwm7EYD77?=
 =?us-ascii?Q?i+tWA0evU3Xy9N5dJ5uvH67pSpd4Xp6h4nufirhTy8PL8sw4fKTRFyRQPZIQ?=
 =?us-ascii?Q?jokO0Faj7bPGIerIedaYYM0EUzN9rca2nmckK4ezIEHs9drkyrOB+YUGkE4g?=
 =?us-ascii?Q?Ur+9iEV+epq/Bl37plEqnjRIXnjribr3V53GYLtu6TwWz+0lqu4RkW9pIZJY?=
 =?us-ascii?Q?wSqYi0vOKE8IShSezW+NO3n3T57xt5RXUDt7OSNbBKtng2QP/QqCJqAq8cAJ?=
 =?us-ascii?Q?pnccRjZtXwHwcIjftYPdsZ9/jaQNH5Tom54EzZkcqS7dRH8zGtxwABad9Z13?=
 =?us-ascii?Q?yJHmi9VhOnFGecFZ/xN3lhV561ZRyoSv92EyD0aNpLHUZWRim685unWSc5Nj?=
 =?us-ascii?Q?L36zZDfK6GTHAXK7MNiJ8u3U9AbwkjdFZwG20+N8h7y3WNvjHOu/KzTbtc5r?=
 =?us-ascii?Q?kmML2BnSAUOxOBzKOpOaKhh7af6GFkKTVdYm7EYuYQ9rrfGwngu6NtI5UGt0?=
 =?us-ascii?Q?DU3+y/LxOn+mR2VvpIskdBNAvHvq2CbTmtdxNs5DTEWdFlhpkCy38qa0Inm7?=
 =?us-ascii?Q?dJXM2u0P4uA5fcyNmaO4GLDC+3NgbLZY1XlTJwLe08pjnMzUQVnrMLI1ca8Q?=
 =?us-ascii?Q?oWbbKSAsbv5Tcs+4pECY3jmCLLhssomvLB+GMc7oDRD6B0+oPd73jvGMifQK?=
 =?us-ascii?Q?9az36pd7IDVmItyp8fLaNgCvtmGraWxQ978oAMBY187UxchFoN6LNy1eWiiR?=
 =?us-ascii?Q?xTplVloonatI+WZ6lAv1PhAdF23vzhwLk0GdaP1w46Xl9ZRF17ids2lyVBfx?=
 =?us-ascii?Q?frSgnzRBU9oDVwbTZDGD2zY=3D?=
Content-ID: <6D1B156EA391F5439BCC6775AA896EE6@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2ca46a-0e3b-4230-9e96-08dabba7d682
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 01:24:35.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKerCuZj/dLKOoVMG1r2EWRDfPqEkfboE0T5PDWz6lnEANwn8o2NXNXABmyN6E4gWKBFWlHPgW6P0iLtCKC5ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5394
X-Proofpoint-GUID: RD3HccoFee79zBpPEp_ootL-leXz82oP
X-Proofpoint-ORIG-GUID: RD3HccoFee79zBpPEp_ootL-leXz82oP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_22,2022-10-31_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Oct 31, 2022, at 5:57 PM, Alison Schofield <alison.schofield@intel.com=
> wrote:
>=20
> >=20
> On Mon, Oct 31, 2022 at 11:46:56PM +0000, Jonathan Zhang (Infra) wrote:
>>=20
>>=20
>>> On Oct 31, 2022, at 11:57 AM, Alison Schofield <alison.schofield@intel.=
com> wrote:
>>>=20
>>>>=20
>>> On Tue, Oct 25, 2022 at 01:43:19PM -0700, Jonathan Zhang wrote:
>>>> From: Jonathan Zhang <jonzhang@fb.com>
>>>>=20
>>>> CXL 3.0 spec section 8.2.9.8.3.2 "Get Alert Configuration
>>>> (Opcode 4201h) defines the get-alert-config command to
>>>> retrieve the devices's critical alert and programmable
>>>> warning configurations.
>>>>=20
>>>> Add the methods to issue the command and get the fields
>>>> defined.
>>>>=20
>>>> Signed-off-by: Jonathan Zhang <jonzhang@meta.com>
>>>=20
>>> Consistency in typos are trickier to detect ;)
>>>=20
>>>> +CXL_EXPORT int
>>>> +cxl_cmd_alert_config_life_used_prog_warn_threshold_writable(struct cx=
l_cmd *cmd)
>>>> +{
>>>> +	cmd_alert_get_prog_alerts_field(
>>>> +		cmd,
>>>> +		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_MASK=
);
>                                                 ^^ LIFE ?
>=20
>>>> +}
>>>> +
>>>=20
>>> --snip--
>>>=20
>>>> +#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOL=
D_MASK    \
>>>> +	BIT(0)
>=20
>                                               ^^ LIFE ?
>=20
>>>=20
>>> --snip--
>>>>=20
>> Thanks for the review. For the above snippets, I do not see any consiste=
ncy issue though.
>=20
> I'm sorry for being cryptic in my review comment.
> Alison
Hi Alison, no worries. I do appreciate your help!

>=20
>> To save space, I have been using following abbreviations:=20
>> * prog, short for programmable
>> * err, short for error
>> * warn, short for warning
>> * crit, short for critical
>> * dev, short for device
>> * config, short for configuration

