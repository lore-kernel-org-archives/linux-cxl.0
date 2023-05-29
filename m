Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071C5C77B7A
	for <linux-cxl@archiver.kernel.org>; Mon, 29 May 2023 08:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjE2IJP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 May 2023 04:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjE2IJO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 29 May 2023 04:09:14 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 May 2023 01:09:07 PDT
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A56BB
        for <linux-cxl@vger.kernel.org>; Mon, 29 May 2023 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1685347747; x=1716883747;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=uMaLgFn30QOspXiiMcUT+u7uER3VZM1lE2ypRAXwP4I=;
  b=ztF9N+lii4xkTgAiMg/Ds21wdZU7bDwDwJ4qmr9e6QhGbb5MAjrKE+r3
   kaGkAlToj3mR/RMpJDXILSvj/J2g0I2iFyRW4KymsWYyK+jNm8zz/NAYI
   KeGTRYmquxN1pckR7k0d8DpHEeORo5Zen5msNSwDxGsqM7oq2LuYxO1YN
   RFqa24C6msjRLX0eysgYIjcOwIJRI/SjJ9DVSCzxjBrAZOOz75fGecVAw
   Meu0j77a0ygKnUYfiBkwr6QKIGZ8voP9pYCrLmLuFtJSUrnIUXAdQNsVQ
   S+7LkNbkatPm9qdomPaDzDKMoLe8EWS8FrFFMvdALCq4sMN1HBBY23sR2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="93664833"
X-IronPort-AV: E=Sophos;i="6.00,200,1681138800"; 
   d="scan'208";a="93664833"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 17:08:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P66bh77lxIVX0hbro/i2Ahuq6A62f1tTs83ddM5WZyGDpF1Ic0WLaMbWOnLwnEz2EHhfMWfIpdvyWnGDa4yiaKuObkKdgWIrgC+xy9Qw4+N2nvhIXoKquSNXmUleUBlmBRttITkHVqrBr7lIokX95pE+oxb9mhiaEXfhbSYq3jTu/bgoob72TirRnoxdl4tHimZT6MOLPaB9UKOonpfGzRXRO71NulvwxvIHLRRCt5LKWtXHnhtnnAv8G3e14Im4FV3jkwHGZeIWynxkHu9i7wRszdqrsh8OHO2jGLd0QMAYSqege7Wa8XHY7paYfqQW1hDyK1z5He0hXG5/TtIAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgN96ZQ9oRMxLNcEXLmZdwrhoG7DF6iHf2Py3w5tYbY=;
 b=gE1m1J+seH+hRF9zc4teAwv9Syv2x1OJpeULRYlSTDDk1mcJjiZ8kBVaZTNNpLjnolQdHjipNcCD4sVUngc/Og+hAQ/XT9zW0lTdVTx7iK7Js7V3r9l8bw4UoWDW708B0TCXHge3Q4JzvmeUBKOXJKPoSsKnXfeIsuJtIFJogp/+3Pawnptg/cSfSE7JkXbbPW8GDAy8JXVhx5/8YFwhfhsVzdn0Csf7qlxjHLVD78dv0UtQY3Dv642zpERw3Nzy7rM1dIGZ8qjFPpZzD83VlZJYVVlLj62hkgVhA+PDPqtQT5hkZEp1tkpDCLuxHGpDmybogMxUH8j4AxF/x0gwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8)
 by TYWPR01MB9592.jpnprd01.prod.outlook.com (2603:1096:400:19b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 08:07:58 +0000
Received: from TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524]) by TYWPR01MB10082.jpnprd01.prod.outlook.com
 ([fe80::4e2c:7c29:6e57:524%6]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 08:07:58 +0000
From:   "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To:     'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Thread-Topic: Questions about CXL device (type 3 memory) hotplug
Thread-Index: AdmMgx3ueFURs12qRVC17Zugj/nYpgAiAciAAAOnngAAINJ+AAAQwYfgAEURk5AAOy5fAACGuOZg
Date:   Mon, 29 May 2023 08:07:57 +0000
Message-ID: <TYWPR01MB100824F6720970B5968E1AF67904A9@TYWPR01MB10082.jpnprd01.prod.outlook.com>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646cf986dd030_afb7729452@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <TYWPR01MB10082A36ECFE209E4A05BA33190479@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <6470c6a44e869_1fc5429435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <6470c6a44e869_1fc5429435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-05-29T07:05:35Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=8f3c8845-0f01-440e-9dcb-43243f3f88e6;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: fc286ebff93f4433af938db02383da25
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10082:EE_|TYWPR01MB9592:EE_
x-ms-office365-filtering-correlation-id: 92c4753b-f39c-46d4-0db2-08db601bd063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMKlY/p5uHbXUIXl8wSfVFuBQcqLD4EMHezMUi3aNXn6Yyee9/+N1BIB3ZhS2uWULLzMlMk54qkcZNTnmO/lNe/k74uJbBHhbeUUJ0Ev2RXO90SGrrS+CetCt36y3Nt/Gq5DVjycyqeeyhQYe4Roir/rvticlEn8QTK1c3Zka4etBvCINTJXV4nBH8ch5aPGkLIFLLlZOP5JGCUCVwmotCFqKRYetasnJt0HQHDYv1GojChJKMWvuA3ENmauf1pTMw4nekuWvH3U1B8ROx6GmUnDZGZ3oHfHxFUg59zh0gw5DH6MTy2AANSoKZekmg43kgIITjqVVn10PNZoKBTpCnZ+/nOauBo5vPEbDTozpkNffR1qORKXJ3ZsIf2gDZ/mnuy68LMvIescCjw8yoIR3CDSAU8/XzYAxPAD0DKA+2q8V0Q9R4Ce/s9MqnsCFMzIxDEVIXQZ35f8AgvjKrLuDyOKPqMnnuUxKCpEQtJ6xmtWbJIWrhNmgv5X4h+oFdOPn28j1W/Xc3OlcAOC2H8bCqcSzdZbfGL2JCthaKgja8pUmgQ4dYJkTRD6CeWXRM7x1x1AdAsyZYC7+jycv51yVwaraBiEtcsf7whS0LqmKIAmM/fSYvYOtORfx/PV7HQyHuAKNS8KYHwZOBdM83kHMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10082.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(1590799018)(451199021)(966005)(478600001)(83380400001)(1580799015)(55016003)(5660300002)(186003)(33656002)(71200400001)(52536014)(86362001)(7696005)(8676002)(8936002)(2906002)(41300700001)(38100700002)(122000001)(316002)(82960400001)(38070700005)(6506007)(26005)(85182001)(66946007)(76116006)(9686003)(110136005)(64756008)(66446008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UUdHV2ZxUnBxSVNzYjQzZnNGSVpZTDRPRDF5SlorTjRQQjZrZ2pzY2FV?=
 =?iso-2022-jp?B?bVoyY0doVGpLNzV0Ri9ZTnBJckYrczlaSjFzNGxpVzkvdXA3UUlCTW1Y?=
 =?iso-2022-jp?B?bDBkVUY4emNqc0ViZEk1OVZCQms2OUU3L1VaQ1VIQ3pvL0Y2SXRvdlJ0?=
 =?iso-2022-jp?B?QUFjOVZYdTVyT2JZa0ZoT2t1anpzZmY5a0dZajV4cDNiTVc4QnovUjBU?=
 =?iso-2022-jp?B?cC9zRjBGRERnS2JpNy90V25NT1k1c2taak15NkFxbVc3LzZJVFBQQ3pU?=
 =?iso-2022-jp?B?VC9adXlMeXIwMEtRVnh6SWNZdmgzSGFGcm9TWmZVZ3NISE4wRkt4ZndQ?=
 =?iso-2022-jp?B?dEQrcHNibzZSMkNkbWNJVDZNTUNOdXd3cS9yRU5KYjl0VFEva2xhY1Ja?=
 =?iso-2022-jp?B?Q0pMUmdWU0ZTWEI5T2toYVdzaFh6Wjk1MWxoNWtOQjNYQlNlWUVOMEpl?=
 =?iso-2022-jp?B?MXVKOFZhSkFyaWFMTEVMUm5ESkR2Zk81ZzFmekZyR0Q3cWgxcldnVmhF?=
 =?iso-2022-jp?B?WHViU2xCS09YZVp3K3MvKzRyeUg2cXYrMitsVnNPcjRhdjdrVkhrT3U4?=
 =?iso-2022-jp?B?aVhZN3VhaGs5dXZDOVl5WGFoZnlpQVNXTnhQcDFyOVlZRExFZXM0MXdw?=
 =?iso-2022-jp?B?YUZDd1NKOTljVmRrTWpFdGpRWEpsN0szdUR2Ym5jS3k3TDMwdHl4ZnV1?=
 =?iso-2022-jp?B?Qm5SaXFHWXlUWk9VTmEwYUxxN0wrMExOR25iNVZ5emh6Y0IyamRQelY5?=
 =?iso-2022-jp?B?cmtLZmxScldueTI2b0IvbllZYWVaSjYrQjd2QzgwVVd4b3daM1VsQVVN?=
 =?iso-2022-jp?B?Tmh4M2lKMXFWY0d1T0Q0V280VG9zc0pQYkpaZkh0aU1FdUdBakZEZFRQ?=
 =?iso-2022-jp?B?eW1KN2ZlL1hjYU5BNUUydUZkanMrdFhYWEJqQVZzeFptbCs1Y2N5UFl6?=
 =?iso-2022-jp?B?N1hwUkxDNERkTDNORjRRVCtkdldVckt3MFo0ZXVBUnZsM3NFcHZFSWJt?=
 =?iso-2022-jp?B?N1BaanVtVThWRDgzUkwxOEY2ZlZXUWthaU9SZGxuWGdteC9yR1FXMGVy?=
 =?iso-2022-jp?B?amoxU1lLeENXODZSL203MTVoeGtDd1FNSWFOak83L0lOQWE5eGJMcmQ0?=
 =?iso-2022-jp?B?UVBzdmJDMjdlalNQNnNsVTFQZlhueXhMRzFtd3dnT2hocUFHWHVsQ3Uw?=
 =?iso-2022-jp?B?RVNwRVljaEl2VFB6RXpqWHFRd1QrOUt1ZXBIazZadzZUYmxiK2lmQ01s?=
 =?iso-2022-jp?B?bTU5QUZtS2x5aGttekt1NTlkcFY0dzZXQzFiRnFQYlRDUldGUllXRGdS?=
 =?iso-2022-jp?B?cWp0cTFjSDFpZVNZVHNvdkhMZlZqcGpaNWZ1dStIS3R0TGhFUFZGRmcx?=
 =?iso-2022-jp?B?REZUQytENUVoRkRjU2hCbXpUY3QzQlRmL09OemFpcjBUUnljSHRiR2NL?=
 =?iso-2022-jp?B?aU5LMlJQZzlUWVA4dFg0dTJlZTNCRmV6b1ZjcDBmV2lXTFdCYk9CbWYy?=
 =?iso-2022-jp?B?dkdOQ294V09OYVE3NEJrN3pNWTRhUUdoZEdjSVZWMXpQZjdZUXdHNWt1?=
 =?iso-2022-jp?B?dHlMYk9xOU00YkVRWmYzNXBTVzFtWUpUSkhKNCtmOG9YbUg2cXJQNEcv?=
 =?iso-2022-jp?B?Sm1ZbGRIMUF4Z3V6cnJTa2JTc1NFNTd3VHA5OXhFRGpMNFoxelNMa0hK?=
 =?iso-2022-jp?B?cGNjY3o1ZU1pNWdVYmJDbnlmM2VuQWNXMjR6dmU1Z0FEcEdETWJCZmhm?=
 =?iso-2022-jp?B?Z2prd3ExeG52RG1tS1dKK1Y4ZnFVSldZWVdndkhMelcyMmltVWZmUUdH?=
 =?iso-2022-jp?B?azJCeHpXTVh6ZFVZYVBocnR4cmRTZXdFVWNJUFBLaFVHUzhJK3ZyVWsy?=
 =?iso-2022-jp?B?TEtFWU9sR01lVzhIS1ljcVZ1d2RKS3lFeGVVNVJiT3NUUmpCdUlCbTNt?=
 =?iso-2022-jp?B?SXEvV1JieXJVYXkzVU94NG1VUXMzaTUyVzJPL1Jjb3ovNnFiaXl0WlFi?=
 =?iso-2022-jp?B?cnJ3ZUNNRUl5TEdqalRtaDN3NmpyYU51OXpKenEya2VYWHZhY1FuWEkx?=
 =?iso-2022-jp?B?U2EyMFZKdytKV0s5WTJYdlZFKzk5T0NlZmFOZTNFNkZONEpvTHpINkJ6?=
 =?iso-2022-jp?B?dHFaT0RrTlpMN25FQlRlQTBtWDhPSFhFYUZtTE9zejl3bXZxWWVBU2kv?=
 =?iso-2022-jp?B?QUV4S2xkc2svbkxha2cvZ3ZueWgvUXEwWWFMTXFDOW1FNlc3SEpxb2tJ?=
 =?iso-2022-jp?B?T0JwWk94RW02MG05bk80TFhTSk4yeXY4ckhTYzdpNVZkcTRkT2ttc2JG?=
 =?iso-2022-jp?B?U0VjKw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VOk65FI+wJ5YtotLPi2qZ/f4PgouXLYFfhmJ0f6TFU54N+fJ3Mv4FSt6qJHt46eEbz1aKDosOBwpf2ZKkrpN2TDCM3rauYmroZYus1zcEnh6e2DXq1wPxiFNPAXb8GoMAk0EL9cGXmm2Tb1Ma4Lxq7BZBht1Zdk5r4r+Od/5Lbp1Dj8MXNMMMNkqjOMQJ8qL7DBUqmmterQY8wLW+KYe1CDsg3JRWo7rJvFTxDJ259TiAryD4fPUNXUlAtYkd0f3+tFPEn9KpsLsRasmqWqiOUwMJsXimjOtjqSiPWflBaGfS5yX+xmUl9aBXBxT6EUpDAVFF8+Zt/jEOS2KGxUdozTeY31hyKlLrsXI8R/FDm5+x6qJmt3P2LhFnbv55IcTUdWa6+Nh7MTSb/RY1MqCRfk+sPVqUIDyGXKa0tHKDaQ0oKqY6mJALojOWWAp1G9IkfLObX9qtPyuXnxginZBwaDTHOuxadrfF1KjXgNzo0KsxDYB3wyfwhvBH4t1cZbgh4cAp6ySBu8em4OXhF3Qm1HYHIqE1PXk398v7kR4uibffx2YgxtA3Rp8YzID6xZ9B1YKXC69R4ONpQ5G42gKo6Vx84f0QgEToIOvcUjVEHUu3o7re89nASFhyOIlNYCmBgf7qD96jxkAoi5+OqfcNMZDdL8aKWwABjvKOecKS/11el/WHec8Zc9SWWqDWqVVkBd1DxX68XfzoQyAZl8Y5yfRSOlqfs8Xb0son05NTVvA/6JCxt4MJP6I/mH6Neq77RilQOT2rh2G20EgRb1F4Qli8IwcDAgAXFayIdFMu0c=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10082.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c4753b-f39c-46d4-0db2-08db601bd063
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 08:07:57.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vji5AOCyUpXOqt5Ay/c2PRUX4LH9TpLJNANxcgKIM/psDBUH9zM+rNnbmlnr9J6HDZ2cor76PQMh+Kjd/dITHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9592
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> Yasunori Gotou (Fujitsu) wrote:
> [..]
> > One of what I mind here --was-- which documentation describes OS
> triggered hotremove instead of PCIe trigger.
> > Because many hardware/firmware developers don't know the circumstance
> of Linux.
> > They may want to implement same system not only for Linux but also for
> > VMware or any other system, and may want to obey only the specification=
 or
> any similar documents.
> > But I found " CXL* Type 3 Memory Device Software Guide: 2.13.7 OS
> managed hot remove sequence"
> >
> https://cdrdv2-public.intel.com/643805/643805_CXL%20Memory%20Device
> %20
> > SW%20Guide_Rev1p0.pdf Then, I can talk with them by it. So, it was
> > solved.
> >
> > My remain questions are the followings.
> >
> > Q6) Are there any way to hotremove from outside of servers now?
> >     Currently, administrator seems to need to login a server and execut=
e
> offline and cxl disable commands
> >     to remove memory in it, right? But in future, something software li=
ke
> memory pool manager,
> >     Fabric Manager, or any other management tools which can manage
> many servers CXL devices
> >     will want to remove each server's devices from outside.
> >     But I'm not sure it can available or not yet now.
>=20
> As far as I can see all of the PCI hotplug state machines just coordinate=
 the
> removal internal to themselves and the PCI bus core without any participa=
tion
> from the impacted driver before the ->remove() event. The ->remove() even=
t is
> too late to cancel the hotplug. So the change here would be either an upc=
all to
> userspace, or some permission request callback to the impacted driver. Si=
nce
> this is a policy decision whether to allow a given CXL device to be remov=
ed that
> leans towards a userspace upcall mechanism.

Ah, sorry... My description of question was not good.
I understand that PCIe hotremove is not suitable for trigger of CXL memory.

What I would like to ask is "Are there any agent or daemon which gets a hot=
remove=20
request from outside of server and executes offline and cxl disable region =
without
users operation?"
I suppose such memory pool manager (or others) would like to ask the agent =
to
execute such operation.
(Probably, the agent need to get the request by REST API.)

> >
> > Q7) Are there any interface to know which block cannot be offlined?
> >     Even DCD is supported, such manager software seems to need to repea=
t
> memory offline
> >     request for many blocks and collect succeeded blocks until requeste=
d
> amount....
> >     It may need much time to complete even if its success rate is low. =
I think
> that "time out"
> >     for such case is not so good idea.
> >     If there is an interface for such application to know which block h=
as long
> term pin pages
> >     or any other obstacles, then it is desirable the above software can=
 avoid
> to wait long time.
> >
> >     If not, I would like to investigate more how to make it.
>=20
> memory_block_offline() can fail and that error code is returned to the sy=
sfs
> operation that wrote 0 to /sys/devices/system/memory/memoryX/online, but
> there is no facility to determine whether a block is long term pinned. Yo=
u can
> only try to offline it, but whether that error is transient or permanent =
is
> unknown.
>=20
> However, one of the mitigations here is that DCD allows for partial relea=
se. So
> unless the fabric manager strictly needs to get all of its memory back th=
en it can
> make forward progress with a partial return rather than timing out. If th=
e fabric
> manager needs guarantees then there is also the option to never online th=
e
> memory. So, we have some flexibility here before it is clear that a new i=
nterface
> is needed.

Ok, I understand.

Thanks,
----
Yasunori Goto
