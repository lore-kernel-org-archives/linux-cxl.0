Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC71FA3741
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Oct 2022 23:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJaXrB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaXrA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 19:47:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D99EE00
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 16:46:59 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VMPDEa006475
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 16:46:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 mime-version : content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=AzLP2JnmEmqjBb4XmcJ8rQw2cuAifHT7zEQEkq35ILM=;
 b=A6TGXCPpvFlmU4f9QmVbXQsgaeIaeBCtv1ANUdjfzSF8ddKuaJoyvm6YANIfSm/O3G8q
 mHS0Yj8NkUnOqylr6Pewwq4K2JSP9WiIGWaHa9ZQEqowVophmJRZnbUYJ4UEYml7L3UM
 ItyBd3eb8CJ1NU+Csg7YVXOg3CJ7tHOMJckHQaME2X7ZR0GzXIjTATge/QlKGnadoGn7
 jrs0e894Grpf+MdLW9EBl3ACeToak/cDfNkui9Y1MIHRwHHJ1m27kXutmomHxBzu42st
 6meOgYFbZIXStGBSrPP1BL7JMA4+TJPIIPX7cCEZbZ6u1FnpfAJOenq4EtYNvpWWqtEJ 1Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kh07pc089-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 16:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY7cYhR0X0DdtehzPJn6CFpaXYb50lLTMDDedFF/z78afX5H/w3KXPgwRbQ33ah6utGIuoeZ+XOEgVR1EDNgjgYJYtWiXnL930LZiGhz1MPeXk7Bu0Yva64OmmXNXwVFNTxJ8caulzFT8IuO/30XHY/sQmK9i6Hyk837FWo1XKICr9781qRI8xm8WGx55NGmuDQBd6Z/1ITzaee4HhtDQfpj4T1VHOx2zz+Oe+cLzOHAMpOHhKCtM4FauFTd2fld+PIVbN/fV3oZSj3EmesxQX3syEpwI+4YPwnUOnYPPDOszvQSwa5hZ1iGU/bt+T05R6PYPNJt7HPoqKZWXO1yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=900exIk10QEMJwSRiuTKeBH5/1Lqo81LMHW8E/9oAEo=;
 b=KXZzrY326/9NbhPrYUIc1Ah0alzH3dVK9W7L0f6AO8spOF47HXDvsuF4KRPio1maR+VesrWTM/XLhcxaSM0MxxgkfAnPYWpLbTukeWvRm+tSgEN81/0ouoY9q3MuORoux2PDGfnlardstEi8+Ye3KE/ngL/JTFku2huQ5IhUZq8Dg8aq6hr+knerBKGqUymfqegGFBb6oPGPT8WA0nes/lENUWiQstN4pQ4D3QGuBV+lVCoY6QAtGAB1Wgsj/X0dr2s3b8YQb/zEygWyQn3jdnyEexuBjFw/jqjnU4a+gN2oql7UPSUdsxqrYxj2/f+thI6P0fWYTK/o8CNC/Y1yYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by DM6PR15MB3991.namprd15.prod.outlook.com (2603:10b6:5:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Mon, 31 Oct
 2022 23:46:57 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::b5fb:53ac:f77d:4f5d]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::b5fb:53ac:f77d:4f5d%6]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 23:46:56 +0000
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
Thread-Index: AQHY6LJ7fiGi+zR65kWmF41FNfNu/a4o4++AgABQyYA=
Date:   Mon, 31 Oct 2022 23:46:56 +0000
Message-ID: <07E73718-226C-4569-A168-DA90D77F43FD@fb.com>
References: <20221025204320.290354-1-jonzhang@meta.com>
 <20221025204320.290354-2-jonzhang@meta.com> <Y2Aaq6dFXlr92W/6@aschofie-mobl2>
In-Reply-To: <Y2Aaq6dFXlr92W/6@aschofie-mobl2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR15MB4969:EE_|DM6PR15MB3991:EE_
x-ms-office365-filtering-correlation-id: 285618ca-7cd4-4fb1-24a9-08dabb9a3222
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nuf0IUIN3eGYiQvfGpSDR9tkniHVJqkZT4YX0r9pg1BDnEQuBimF0DXiCtoIPCQD4d1FWh2rppITkkur6x6w0u4dNJTfjXfejR2+QHIZ3o8XICvfTl1u6leB4Hc9cLj4in/OSYjNx+su1ERfjrPzWpdzex2vNAja4MKa15hmt6TqyQh0Bi78K1aTa9B83Hdro6j/Ky09Lsijg61nNRe/dYEn6Q2DRxr0EMzgF1kFNZEz445JzbWKoQUCvyuJl4NRm4t7QWAMf4HTakQxwcZEkuGfgzx60gnz19gbp4GVNGyeuGf5S5S7GT+GGAHrBafdiJFEJlzusBTZ6mQhWX6eNSBhrwtQwZ87qjbk9MAyGayiZURbrf5juCL3zczTXWfzshPzv/4Siyh055aVkBeAi2oGb2E6xR16uBLXELKtV9Nn57RR8YWfMKzfT03YEocKUT2MX9trd5u7uckruMNYWHcKXty30kkU+D9M1UZMqfW6VkRW1FnwjJMIcjW6QMwQbfXBbPl/aGUombxfKe/HFXKNL5/atKmMJC+PRNdrZEevJRvzIwi9hFBbl/kzE/1FulGvCZ/j6P31X/XowMzWXI5fknsyBZ1UNVDqD+kNob+mEdGamWlDHIzYrEy7es95Xy5547j6MARKoITx57kRxdK+iV3N05imRPYEmvtQwx6emu8A7nXmGigMMv+sa9e4WrEUiX5zIPGePu21XvICVEelTsq9uRS7ruDtd7EmRaOjcyJFQLjG7TCLubZqqHZ3+emyPDjWtepUn+6I+d4ZIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(9686003)(6512007)(186003)(478600001)(107886003)(53546011)(6506007)(83380400001)(2906002)(15650500001)(6916009)(316002)(54906003)(8936002)(6486002)(71200400001)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(5660300002)(41300700001)(91956017)(4326008)(8676002)(36756003)(86362001)(33656002)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZH1DsxWA+6ZGXVfzi3iRKr5yjW+IXoo2OeMnE6c4mEQgJKMoPTpKID83KWPB?=
 =?us-ascii?Q?ggGraRHwFWynYwKo9kxt1W/CvRp+YIpOIiAS9QLDnlJmNkAu6lJUkjwIDkPS?=
 =?us-ascii?Q?/2cRoNU+3RZ4biwaOKZmEHe9G4iN4B5EDh1/vHmk5gOw/PkiTSLolpLAqTvs?=
 =?us-ascii?Q?XCd8/nHbfzdaN8Sqz/vT4emUdaQhBdBTDebY3SFshE+xDltkwFEEDfnOD16L?=
 =?us-ascii?Q?Y9OF2Y3fV0I4D2HlHkwdqy+pKMHbSe+WQAiAIz2bWNnxL03UnYIBBRnQpfxc?=
 =?us-ascii?Q?AbLbpLiH8YT0GG964zfk0Ji66SRdPGyRR8WwWlz+1kJzAF0rQ6X4oVhIe8KT?=
 =?us-ascii?Q?6GThEGKw93TP+Zgdl1oVUDhzhUnTeHPCPiTBZqDR7pZAHZq9Gc2LP89+IT5K?=
 =?us-ascii?Q?SQUDUhuXps8dXOEB9B26L98FDEzm/vRfygBZDXxtZtRzoQ+YwN4kgm24h/Rf?=
 =?us-ascii?Q?SRVe1d9hkB1SSHi+5Sqr1GSzNk5SJpJQ6Dbzg6p+XVsnadcoz+FEFy6QKsc9?=
 =?us-ascii?Q?qXn+ua81MK6xOgxHI0u8IWizlgjHYl42so3RbXpmMUlN9dShSLg4SmOIGhMx?=
 =?us-ascii?Q?0gzoiB52jyKh2kt86tjIGDq0YbwudSoUtN4GPYM+KRhotcQI3S4VUEh7h/Lh?=
 =?us-ascii?Q?v9EBss36NPIicvZwGalWzQKgPGK7L1cnuQMfS7HSZIRCH4O9ozfc8nLcyrmo?=
 =?us-ascii?Q?CVtpyLjoTZwgpFe9qcaCNXd0+IVOQKmV1KyX1f6XtKUHkrkifm12FruwASLd?=
 =?us-ascii?Q?ldI4piZ4h3nbpoGVQD4cprjwQ7qJ4fGZw8sislBM27tRoPvJrvyAEb6HCD06?=
 =?us-ascii?Q?WS1WKxDzDquIWQlG/LtlK4IcpxK4XTqTaEVPfhItxefoJpmRR6ZC/f8MdG6E?=
 =?us-ascii?Q?4s/hzArRe+/iSVMlDPTEGabSFQ2EwaOTk9jlSY3K2GtLvZpSmJ3WkqmaVa/D?=
 =?us-ascii?Q?u+Y6U8EILGhJJHxhcQhRo4VrXZqSTQSek5wOnnGkb/nV+/nTd0AhbNEeNCyz?=
 =?us-ascii?Q?s8ruXkQ3rOjJsWe1lsV+Tvs+msraibnfVODJtSvg3mo28wf6lOb4Mz87tCBp?=
 =?us-ascii?Q?XpytU5XMe6hoIABfZfAFP0mqmOpGvuycQWaOGRzCVxIeyohPfrZAkbHq0q+b?=
 =?us-ascii?Q?fEez+et4U1OtGjqhp70fzQVzhy5ifzRieqk9xnHk5yR2Sbh3FDj+ulMTuETF?=
 =?us-ascii?Q?RKbspKO3y1ECAzbndcm+MrvyhCrSIQm4oMGSJy/gmh8Njm2g8WP2WnD+P+qf?=
 =?us-ascii?Q?LQlKIEi6RygyhKBU17iUDHXHoLRApte+YAdTIT7GOfUl7qnTF4e/lDGp8VKv?=
 =?us-ascii?Q?xCgJeFycKMR7U9xa36kl17EVBi1O9qinIILY8wv2WVhZGk8AHcdaEeXudh3n?=
 =?us-ascii?Q?cO+hW6DYvnuvT84d1ZUUryXNyQsvxxhRKpTSweMtvioVZ9jNGfhtgi6a9BNV?=
 =?us-ascii?Q?WaCczAZ3FhKakhMYw/8E0/qj6uHSmA3knmeTt8CDUJb6U9uKeOO096y5vSby?=
 =?us-ascii?Q?vc/F27Dz8PSOwqnEjkNgPT9II+XPh9ZoYd5gnrATud2SaYncoyqd+4JXjfjC?=
 =?us-ascii?Q?tAJA7wKjk5bx3CuSfJxMD5AziT7fz/voZkJUM/qw1igNtXZSZkFB9fV+52Dh?=
 =?us-ascii?Q?QSw+X1jYxeH+NFgRFr9fTTk=3D?=
Content-ID: <6F7CC16737D5D948A9577271D6D5A47D@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285618ca-7cd4-4fb1-24a9-08dabb9a3222
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 23:46:56.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbTIoJPal8ShZGU0bTvL8WF96yzdHgZNYewnX3Bwd+8ZolojO3/SsI4Dc1xp0G59+tcT0SuQoy5Kvng4OhcCnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3991
X-Proofpoint-GUID: oTkJD_yoS728ffc1wcd__IaOle15sBTf
X-Proofpoint-ORIG-GUID: oTkJD_yoS728ffc1wcd__IaOle15sBTf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Oct 31, 2022, at 11:57 AM, Alison Schofield <alison.schofield@intel.co=
m> wrote:
>=20
> >=20
> On Tue, Oct 25, 2022 at 01:43:19PM -0700, Jonathan Zhang wrote:
>> From: Jonathan Zhang <jonzhang@fb.com>
>>=20
>> CXL 3.0 spec section 8.2.9.8.3.2 "Get Alert Configuration
>> (Opcode 4201h) defines the get-alert-config command to
>> retrieve the devices's critical alert and programmable
>> warning configurations.
>>=20
>> Add the methods to issue the command and get the fields
>> defined.
>>=20
>> Signed-off-by: Jonathan Zhang <jonzhang@meta.com>
>=20
> Consistency in typos are trickier to detect ;)
>=20
>> +CXL_EXPORT int
>> +cxl_cmd_alert_config_life_used_prog_warn_threshold_writable(struct cxl_=
cmd *cmd)
>> +{
>> +	cmd_alert_get_prog_alerts_field(
>> +		cmd,
>> +		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_MASK);
>> +}
>> +
>=20
> --snip--
>=20
>> +#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_=
MASK    \
>> +	BIT(0)
>=20
> --snip--
>>=20
Thanks for the review. For the above snippets, I do not see any consistency=
 issue though.
To save space, I have been using following abbreviations:=20
* prog, short for programmable
* err, short for error
* warn, short for warning
* crit, short for critical
* dev, short for device
* config, short for configuration
