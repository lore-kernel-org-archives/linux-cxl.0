Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B9EC433B4
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Apr 2021 00:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F12610FC
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Apr 2021 00:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhDQAzD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Apr 2021 20:55:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:40568 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDQAy7 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 16 Apr 2021 20:54:59 -0400
IronPort-SDR: mSQayFWPUrrMl5xyAmZ25+e0Cj9s79vKE7Gt+4uqPVUixWTmFT/5iRDRo/upZvwVh9BUDennYM
 9qYP1bnFzrSg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256449505"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="256449505"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 17:54:31 -0700
IronPort-SDR: sgmUTx1XDBdxTshLO69hj3Q1pRaPKeuF7ax3/WMMjMDdsv9oGtIq9OU1ptYDkzQ0HpiK8Pqmb5
 fC7GmsaAtHhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="444650954"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2021 17:54:31 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 16 Apr 2021 17:54:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 16 Apr 2021 17:54:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 16 Apr 2021 17:54:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmsh2uXmF/L+9akqwlzGz0ynKafYxGao4enDOo2uxCRy4hFKmJRL4OqcGQcH6Ke/taN/7dRfTOvy30YmPuTnpepT6Lc8971/HKLMZKxKK22WenXm6bPFgNKdBojpDb0VjlROXMT0SKqgMZJ28Da6KPvx3ZM6rwgzaWv/J88OZBtRYRrCmkogrVQqyeZSzljqzTW6a9USIHAvxnaEJMsZ40ZlNtb6riy7TAxyk4Lyou7pXXA17KA+Jr0dLN83QpoJxFC54WX458/MAqA3nDoeCR7nmfX5DhsT01TNNg7gSA7TQuPFn80YQ6nRt3C6ZJVRiyeYTlfSxRubdZkGqwUT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYlaFsr1P7cv59JwxHgBX0ILTTtfK0RTFV22KLNeyVc=;
 b=XuUUgGMBS/NlJltG+rxdfbrVJt4n7r2a8PwP0hLSp1SScwoTWk1pmMUG5qz8se3GdX3U2Ja7DLwtnRfgSR1eRe2mUvD/yXJjhqtqw8P5fQErX71KX3BYApZmurDSa5FN/aKkv/fe9yQDzuAfXEg5bOxLlBlvQ1nAvmL1hom8zg6MnDN/5BS4jSCvQnEurpJk1mFUZ5EFo26A96/QRQLYZY3fxCY4kZw9lcG75IbSsqvXvDteEGTbXsiH3LGCl+HIF8ywPUqAPPZJsRx45WBjRyiFt6aB3j+x8AmKutzcz7/4WoVUJ3NOAk9hgjNpMmIqGGdvDbyDuT2t/YQgG5qwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYlaFsr1P7cv59JwxHgBX0ILTTtfK0RTFV22KLNeyVc=;
 b=t+asaL7y3yT8y0/Ia5ZSUB5Wwk10raVKdMO06U5uFEkFUAbep1tD4LuXXo+j9PBDqDU1/h1caNOR2gRY7aT+wTPggOQEMrVN2L6x8hLMYftDRA20vBsLRTiDG+nD4dg0xEDxGvyHbIpMHvH/RsHytq16LTNh40LPv+0Ruubesa0=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4814.namprd11.prod.outlook.com (2603:10b6:a03:2d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Sat, 17 Apr
 2021 00:54:27 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc%5]) with mapi id 15.20.4020.025; Sat, 17 Apr 2021
 00:54:27 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mem: Fix memory device capacity probing
Thread-Topic: [PATCH] cxl/mem: Fix memory device capacity probing
Thread-Index: AQHXMyKz6i1We8fItkeRxz2/UNZbIaq34icA
Date:   Sat, 17 Apr 2021 00:54:27 +0000
Message-ID: <210c82923820c9923bebbb7671333659d6ab7494.camel@intel.com>
References: <161862021044.3259705.7008520073059739760.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161862021044.3259705.7008520073059739760.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 309d11f7-f1d1-448e-4982-08d9013b59f9
x-ms-traffictypediagnostic: SJ0PR11MB4814:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB48146EE4C7184C8D97CFF6C6C74B9@SJ0PR11MB4814.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdmh8vGOhaxAntzY/kMnpljYtyWT0jVobAV/xD6Q/Dx0OszbBA3+ax7dRuF8oP+FFVhTbdpfcifVWH60zeL0loRO5MSLWoNiQebBLu4fIv3fnxfW8rgUQxMgj5TG/7nENyKcAPZIXBjh9UO4BCrq+nQZHzAEpXAKzs/oEWbVxEAwiAmpPDXrrSYUuXAP45TMFEBBjvANCCLyoodztdVbNJTOwFF0ZN2hvWTK1nc/oaT8WSRCu2VsFHCrSk/SwdnDYSiyMrfMtNEUIBYpC8+pkptMuB9ds3jIkOX3OErKmHN+eEE60/4IJlxRQNOmbh+S5Zzkjgv18COT+1YmeVDJLXOsXZVmCQTHXgaz6l3viBYnfryJuqEOGTQtF/XIye7QCRK1b3XSoelZBFczLPkZ+QivvGkKVw548VGZGXdnaa31kOejNhQhoU5WQJDPoA/5triiZoO2kyn6BLRJPvI1Tx2zi3pKqnWMZyDWrgizfZbhoVNeswEizevf7rrV9iCgeDB0Q2pgrC08qVJmslzJQ9BxwwKhOnOZjf9vAsVO/JhibY6jgKjk8JFp5lel+W5cXB0Cj5HDfgQh5cd9rfiYS+AtqACZ1zNCPd/Jv8TK4RA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(376002)(346002)(86362001)(186003)(6512007)(76116006)(38100700002)(122000001)(36756003)(66946007)(83380400001)(2616005)(71200400001)(26005)(66556008)(64756008)(66476007)(316002)(66446008)(110136005)(5660300002)(4326008)(54906003)(6506007)(8676002)(478600001)(8936002)(2906002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TUNLUkZ5Nk50enYwVVNOOWQ1NWlyZmtMVXppY1J2MHF6VWtCY2pBUktJNWFD?=
 =?utf-8?B?UlRJb3l4TnlmUi81VUpzVWw5Z0pOOXhjVW4yR2wyQ1pxZHVXWWpmZ3RRcmlp?=
 =?utf-8?B?Nm9nWWtVUmpzYTkweVh6bkRzZUd2ZHBtdCtGd20rd0tzTml6SHgyTVJmMi81?=
 =?utf-8?B?QkZWWVUvYjAycGdlS1pKMlpnMGpIQ0k3Z3BKK1QwQmlGTE1xTmFkbVBnWENk?=
 =?utf-8?B?a2w1ZUVrOUhVZ2R0Vlpod3NPa1hIVDVwbkFTRUtOanFCU1ZDaWFEZEpFZURJ?=
 =?utf-8?B?UDA1SlQzaG9LSXRrSUNyRXlmRVZmMVNCUGc4YVduWUt3QWFXR0JYaFFRbWJS?=
 =?utf-8?B?QlRSZzJpYk82bEFsRnFtVDVMZXkwTEhpOTd1MnNkR3p3SnhpYUQreFhCQmZU?=
 =?utf-8?B?ZWpRRXJZMCt2OUd2R2JXTVlvMEtIUm1HZE0xbWN1ZmoxMVpkU2pPZWxDSy9p?=
 =?utf-8?B?aVFXU2FQZmFlQjNTelROVXMwL0wrS1pYZDRoMGF0aVk3TUlNelpJTTllTWpv?=
 =?utf-8?B?RzNyak5CcjRDbFFvbXdhL1Iva1RlY1ZMUVFVL3Z4dWROaXNHblhQU3l1NE1p?=
 =?utf-8?B?a3JuT3UyWjZSeGxhcGYvbnpZdG1TOURxQ3ZRZUxhcVduRzRPakFCN0lEMzZV?=
 =?utf-8?B?STlmbkdrVTYweFVnVEdvV0x3cG4vY2dwUW5EOU1teEVIK1JoaDgzSzkySG5F?=
 =?utf-8?B?K2ZHVGFGQlN6VDFsVEthTkYzMFVQZjZpZGFtZWF6eTdPY3haeS9uSUlCTU0y?=
 =?utf-8?B?THo4WjdEL0s0OXpQT0RUZ1VXdUNRQlkyYnp5WDZPUVMwbUZHNlMxYjBGVkdt?=
 =?utf-8?B?bG4wVHU5QWx6UXZ2UlBmMmRyRGhIV1V6RnR0dGZEMTRDNFlKMGhaTGZIVDFH?=
 =?utf-8?B?c1c1VjZsN2lLSGdQUWU4WWxXMUVpRnJVWFZHeXZxSzgwa0lzTWZpYU85NVJG?=
 =?utf-8?B?em5QMk9jYlAzSGRIQnNPWVNIT0s3NjVGdmxucGZqSWJXZ3UzLzdNRHYvZVBO?=
 =?utf-8?B?VG5wdjFJSXZFRzl1QlBncmJaZXJlK0hKUzFHOWZSWUh5ZkdBNThHYmdvL1U4?=
 =?utf-8?B?MStta2J3dThDOE5TNkEyWVFuU2tvK1Q3TzdWYnNKNmtmTnpFL3ROL3lqcG1n?=
 =?utf-8?B?Y0ZhSEtONElHcmpvV3RHdFQ1YWJyZUxBY1p4V2lMeGFOODFrSUlhWmxYTHVl?=
 =?utf-8?B?cnBjS3N4Rm40clZ3K1V3MzFacmNGUUlhVld1bGxTVllHSjB5OXV6WHdlTVBB?=
 =?utf-8?B?ckRTS0hKQ096bENoR3R5VFhrRlA4SGhZU2kzNDZnOXdFRTI2YVliNmg0YWhC?=
 =?utf-8?B?b1Z4YllvMGFIbXF1MTBJc0x3c1BHQmQxanJUQ3h1UU13eVhmT3NPWXJvVTky?=
 =?utf-8?B?UDZaNGZQNDNkMmpXdTBjUitaaU1XVGxDRVRuRGNDVW9NanhaNjVRRWxqNHY2?=
 =?utf-8?B?THJtUDJiMm1Yb3czenhjaTZsbllBYkllUmJNcHgzaG9QSW9JVWYzSVp6aGR6?=
 =?utf-8?B?L09kUVpYSHFaVHRvbitsOWhWWUhMMW00S1RXVG5XSktrWU1jVENNL2FHOTA4?=
 =?utf-8?B?azB4bTc1b29uM1o0NDVKMnFoa0MrRUp1UkhsRmpERkVQSXlralJ0SlJFWk5m?=
 =?utf-8?B?Z001WU43dDBwcm1RMjJxVzJOUHBma0o0a0F5bFQ0SURmejl5dE4zTTdYS1ph?=
 =?utf-8?B?c2tidFFXSFlkWWl3SFhYWVlod2dkbmFSdXJhbkRXT09OYURmR2ZERzE4ZHp1?=
 =?utf-8?Q?gfDMxWEbmUurIi2HxPAFs2QaA6epIETRkryxa38?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F31C07A2DA7A74DA76695749218F571@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309d11f7-f1d1-448e-4982-08d9013b59f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 00:54:27.0875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Qy75HgV9dDq+J7/Qs5cejfKnTS/bKMq1m3k3IIpnVSbhLDCPYxrSMlL2LF559offR6qwLFrGdo48t5CP+kiGZMViE8RNAB/XiO2bA/EXMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4814
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTE2IGF0IDE3OjQzIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFRoZSBDWEwgSWRlbnRpZnkgTWVtb3J5IERldmljZSBvdXRwdXQgcGF5bG9hZCBlbWl0cyBjYXBh
Y2l0eSBpbiAyNTZNQg0KPiB1bml0cy4gVGhlIGRyaXZlciBpcyB0cmVhdGluZyB0aGUgY2FwYWNp
dHkgZmllbGQgYXMgYnl0ZXMuIFRoaXMgd2FzDQo+IG1pc3NlZCBiZWNhdXNlIFFFTVUgcmVwb3J0
cyBieXRlcyB3aGVuIGl0IHNob3VsZCByZXBvcnQgYnl0ZXMgLyAyNTZNQi4NCj4gDQo+IEZpeGVz
OiA4YWRhZjc0N2M5ZjAgKCJjeGwvbWVtOiBGaW5kIGRldmljZSBjYXBhYmlsaXRpZXMiKQ0KPiBD
YzogQmVuIFdpZGF3c2t5IDxiZW4ud2lkYXdza3lAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gLS0tDQo+IMKgZHJp
dmVycy9jeGwvbWVtLmMgfCAgICA3ICsrKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpMb29rcyBnb29kLA0KUmV2aWV3ZWQtYnk6IFZp
c2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jeGwvbWVtLmMgYi9kcml2ZXJzL2N4bC9tZW0uYw0KPiBpbmRleCAxYjUwNzgz
MTFmN2QuLjJhY2M2MTczZGEzNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvbWVtLmMNCj4g
KysrIGIvZHJpdmVycy9jeGwvbWVtLmMNCj4gQEAgLTQsNiArNCw3IEBADQo+IMKgI2luY2x1ZGUg
PGxpbnV4L3NlY3VyaXR5Lmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4NCj4gwqAj
aW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc2l6ZXMuaD4NCj4g
wqAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvY2Rldi5oPg0K
PiDCoCNpbmNsdWRlIDxsaW51eC9pZHIuaD4NCj4gQEAgLTE0MTksNiArMTQyMCw3IEBAIHN0YXRp
YyBpbnQgY3hsX21lbV9lbnVtZXJhdGVfY21kcyhzdHJ1Y3QgY3hsX21lbSAqY3hsbSkNCj4gwqDC
oCovDQo+IMKgc3RhdGljIGludCBjeGxfbWVtX2lkZW50aWZ5KHN0cnVjdCBjeGxfbWVtICpjeGxt
KQ0KPiDCoHsNCj4gKwkvKiBTZWUgQ1hMIDIuMCBUYWJsZSAxNzUgSWRlbnRpZnkgTWVtb3J5IERl
dmljZSBPdXRwdXQgUGF5bG9hZCAqLw0KPiDCoAlzdHJ1Y3QgY3hsX21ib3hfaWRlbnRpZnkgew0K
PiDCoAkJY2hhciBmd19yZXZpc2lvblsweDEwXTsNCj4gwqAJCV9fbGU2NCB0b3RhbF9jYXBhY2l0
eTsNCj4gQEAgLTE0NDcsMTAgKzE0NDksMTEgQEAgc3RhdGljIGludCBjeGxfbWVtX2lkZW50aWZ5
KHN0cnVjdCBjeGxfbWVtICpjeGxtKQ0KPiDCoAkgKiBGb3Igbm93LCBvbmx5IHRoZSBjYXBhY2l0
eSBpcyBleHBvcnRlZCBpbiBzeXNmcw0KPiDCoAkgKi8NCj4gwqAJY3hsbS0+cmFtX3JhbmdlLnN0
YXJ0ID0gMDsNCj4gLQljeGxtLT5yYW1fcmFuZ2UuZW5kID0gbGU2NF90b19jcHUoaWQudm9sYXRp
bGVfY2FwYWNpdHkpIC0gMTsNCj4gKwljeGxtLT5yYW1fcmFuZ2UuZW5kID0gbGU2NF90b19jcHUo
aWQudm9sYXRpbGVfY2FwYWNpdHkpICogU1pfMjU2TSAtIDE7DQo+IMKgDQo+IA0KPiANCj4gDQo+
IMKgCWN4bG0tPnBtZW1fcmFuZ2Uuc3RhcnQgPSAwOw0KPiAtCWN4bG0tPnBtZW1fcmFuZ2UuZW5k
ID0gbGU2NF90b19jcHUoaWQucGVyc2lzdGVudF9jYXBhY2l0eSkgLSAxOw0KPiArCWN4bG0tPnBt
ZW1fcmFuZ2UuZW5kID0NCj4gKwkJbGU2NF90b19jcHUoaWQucGVyc2lzdGVudF9jYXBhY2l0eSkg
KiBTWl8yNTZNIC0gMTsNCj4gwqANCj4gDQo+IA0KPiANCj4gwqAJbWVtY3B5KGN4bG0tPmZpcm13
YXJlX3ZlcnNpb24sIGlkLmZ3X3JldmlzaW9uLCBzaXplb2YoaWQuZndfcmV2aXNpb24pKTsNCj4g
wqANCj4gDQo+IA0KPiANCj4gDQoNCg==
