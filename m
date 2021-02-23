Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7799EC433E6
	for <linux-cxl@archiver.kernel.org>; Tue, 23 Feb 2021 19:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BD564E09
	for <linux-cxl@archiver.kernel.org>; Tue, 23 Feb 2021 19:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBWTYV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:24:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:42560 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232014AbhBWTXt (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 23 Feb 2021 14:23:49 -0500
IronPort-SDR: 4lnHeM5D79bWVRbgib3draxlW/2LfS8XwKGUzzZ8+ip6Y7iqvRUYZJ03RPlLGPD2/s8yt4cpt8
 ZINSXbWEF+lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="164143862"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="164143862"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:23:08 -0800
IronPort-SDR: hAeHrrmNtPANrzFvd2tgKiX8lqpBmDlZiqa774CnchUUXL2f/2NMDkgntoTijtRvyYyjnB5BmD
 ZxC35Cm3AB6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="423754023"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2021 11:23:07 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 11:23:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 11:23:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Feb 2021 11:23:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Feb 2021 11:23:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYYrSb+99QbNM5tY8oFEF82RpUFKKu8E9g0bS3w5Ogl/O88ddW+eCJia632dOfthdqKCX75MdJWJYE/GMqzGSBxU6F5O94GWMeSNbUt1I7OmgMvT/7CnDuXMXya/SzW5hvbQ4fxZizuOPk5wIRAmjCLpe0vuC3xhFkC/D2ZdVKmnei9OF/SLogrhQgcFXBJJ5/aH/9YXIBdkD21GBRSXVMN9EHvSehf0EnOzcZud5W2KbpXbugok/PAv0EkuTVH2TJ1Jt0z1fqZy804HRUv/TgI82jqWigi8KcLxGgRU9IlhV2qdqhuTrF33jAkeyy6W2IX/IxhDI7FoPXr7ArphZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5rSyi9Xd9TPL93HfI0nXibB4UrxIQDRilvYUwn9o3E=;
 b=Gu7GrV2OChrigx5V/RFWPoX0fSNUzwDEKIaBYFAJqJw7Lfcv2fAVrGrXhIJxiHpdvYJKEsM+YCIc6ZsvwIonGqw8eljRbpA/e7h+On+OrSqiy5I/x+/nK4i5NZ0yDoqLzUUVg1OCRbhSho6v1Y5bzQricz/T+7w/wBVXjqTrU3f7qAkYit0tsY0Gn83+Eahmd839ICLw3FAHlBvghlOZJa4FNturxLRqugk+fl1H1lND6x4DZKpAa+RctNJg3E0qqJ0+edXutTEDvSKz+byfwcHBDdPCfdRZbBrxiEhgBCTpgWKXalBrVNGVZ0X1BZCuWq6M8qkQK/pKw3GEB1QO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5rSyi9Xd9TPL93HfI0nXibB4UrxIQDRilvYUwn9o3E=;
 b=XEoS6WOF4RwrhYtDxQAtVAF0DWgyUOT2Y/RvgHWew2Pi89YdKXuMeVoYvj7AS2VowZr5E4fSPsaoCrtdPmfjyHq7EOkb8ROh0Iw8qwC/oZySDejgHtk5QRTzmYX87C5ZeqJdRH5AUQUYqt/hJ2Mlyrun9mvhvj8UY4ikt0+mzXU=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3559.namprd11.prod.outlook.com (2603:10b6:a03:f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 19:23:04 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3%3]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 19:23:04 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH v2 01/13] cxl: add a cxl utility and libcxl library
Thread-Topic: [ndctl PATCH v2 01/13] cxl: add a cxl utility and libcxl library
Thread-Index: AQHXBmN+rAutzLBwd0if/n3TQcDzFqpkuLeAgAFtHAA=
Date:   Tue, 23 Feb 2021 19:23:03 +0000
Message-ID: <f62d4e8dd4cd89f68c733b0b108b5b3464908862.camel@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
         <20210219020331.725687-2-vishal.l.verma@intel.com>
         <20210222213615.lwjansmxclewb3xo@intel.com>
In-Reply-To: <20210222213615.lwjansmxclewb3xo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: feb5c6d9-8f2d-4deb-7ca7-08d8d8307113
x-ms-traffictypediagnostic: BYAPR11MB3559:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3559C6F21869F64AEA8F573BC7809@BYAPR11MB3559.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5XimI2DeR5yIeg9Y4jGHIqJYLyrev3f9kYzrKilwq1JynoxHfnnW4vPWBJZ9XRTZ/i5fk4l3tKZ5R7gB9BpRell4aRXRsTRcjn80njYUjq429k6LHpj9xbYQS4eJabddaCmg83B73aAhYxvR20EZUuxbl5vZAFAv0XgoaWTSBMAZWw0Ax99+WQiY5FMWMRghL0JToR8uHlUolYqTLnpODzZV5ZB9jzFy3sqg4C4/GcFltXY/JKBYp8Osr0OOHp+HLIwb0aHfEWhuX+Mpvz6iOaewn0d1LVZ57726ty0Qae9j9Fid++ozL03i+qVCqJxN6CxmN6nf+gu1+T9ivYQ+XGB8NEoJQU2u+6TeNDjAwYCLD/iMbBejtXZdC5noJmlmdVAN/2EjkasbX1xFvNe5XwQfFZyUzMe74H9fytnk2J1cS33uTzBq+RO9zgABLWcpupB1ZO2vngEyBJgzzKk3kDq81WfaC4HAWVdjI+ClwlaagE4Q0Kv5D57CvEjpd8pMXkPmSBLMTrzW1NVjM8Sqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39850400004)(396003)(136003)(6636002)(66556008)(71200400001)(26005)(5660300002)(478600001)(37006003)(2906002)(186003)(66446008)(316002)(4326008)(6862004)(64756008)(76116006)(91956017)(86362001)(6486002)(8936002)(6512007)(8676002)(2616005)(36756003)(6506007)(66946007)(66476007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VEs2blRQTy94TUE0bkNnbHZ5OVZ1OHl3OUNMdG9qcXBtN1NOZFJjTk9LQlo1?=
 =?utf-8?B?a1hoUzh3aDhZOVU2SHRyaW1ObTFGZFdaZ25QQXFXWE1FZWdhNzhzaDFnQ2p2?=
 =?utf-8?B?clVha0xRUGMzaDdrM3RlQk5RK3EzdEJoUkYwV21rOFM5VDQxS3dnS2ZncXc5?=
 =?utf-8?B?NC9MWnpLUXovYWJCMWtBd0xWcVdOQXdLR2M3R1Z6OEdRNmFYMU04Y2xWaUV5?=
 =?utf-8?B?R2ZjWGRLdktYUDlKRTVGM2Q3ZzN3ellmVUFadWtGWGxSQ0JnQ29zSlY2K2ZN?=
 =?utf-8?B?TTF1ZW5VdWdiOGk3M0o2amNlK3JObnp3K2MwTWxsZGhjbkQ1b3lVVlFVbGFx?=
 =?utf-8?B?ZFU5WlVyQ2pRVXdoSXI4anVGYjdoV1g5K2gzMTByUm1MNGYxUVMzZkJXOW9x?=
 =?utf-8?B?cEU4cmJBMmlZYkhsaHVUa2tjSmVYQW8zbHUwRy9zYnpHY0dxMkY3NXJqaGw4?=
 =?utf-8?B?ajA0bTR6WElPQjdoU1MrSzVlbWltd1d2UVd5QUxKNXlrWWlpdUJpM0tFbWFh?=
 =?utf-8?B?d0d2U3lISVZybTdua0pKQ2ZRb2lOM29VRmIvOEQyVE1OZkxqZG5aNkUzN2Yy?=
 =?utf-8?B?TmtjSWZ1cVRMVkFpbHoxZW95aFZ3dU00NVJoWC9Ob1ZIR1hvNnpSNERtWENM?=
 =?utf-8?B?d050Vis2YmpoUmxlMjlyYUNsWDlGRmhxOXJQcWhRMi9GOEFoVXhINmI1MUZK?=
 =?utf-8?B?OUx5a0ZFLzg0R3FySGp4Vjhtb3ovN3N0Q3FWSlRqVlZiV2U0UkVjOW1lZ1JP?=
 =?utf-8?B?OEJwZk14cUphQXFnTWFiVW1MRnZVUVFDTjdqVit6c1FZWVBqaU9oNTJRUUFo?=
 =?utf-8?B?aEJmc2pHR1d1NkVxM29kZTNUY3ptblFZK3RTZjRDcWV6MEI3d0VTSFp6R1dQ?=
 =?utf-8?B?b0x1eVU2eXVoU2g1djBBTkRZZHErTE50NGFqcVJZUmIyM0dpdzU4N2xoYVlI?=
 =?utf-8?B?SFdyZjJ5QUd1V1Ayb1Q4WGU3Ym1PSDNFMHhnaUE5ZHM5ZGRaTDZyanRTMUMv?=
 =?utf-8?B?Y3B4YW93MjdiREx3Q0lYNlBCMndkN0VQT3hJQUJTTFMzLzdIa2hEdmpTR1Rt?=
 =?utf-8?B?VVczdEdrS1djc2g1b3dOeE9XN1NKWXczeDR4S1FGcStyNnRKOTJrVG85TWhE?=
 =?utf-8?B?bFVwYTE3QThJWHVEWXUxR0Q5dHo4bkQ3WDd0Y3JlcktaL3BMTGIzMWpuTTRK?=
 =?utf-8?B?TzZPYjRHTmt1UXRRYjA1SlE2VTg5czJCTVBqWER4aWF4YktYb3loU0NTOW9x?=
 =?utf-8?B?T0IxZ1NHWEZ6enFHK08xM092NnpqRW5EbitCSndvSWYzdzUxYjdqRUxXRXZ1?=
 =?utf-8?B?VlFvTlg0WFJQdkVINzNJOUl6aW1QTjBhN0l4eVNJM3JLTE9UbWFxdml5eFh1?=
 =?utf-8?B?OGNPKzN6cWU4SzhjMmhDRzRES0xyQWVoY2pFRmxVUVg1STNybXhubnRpZTBM?=
 =?utf-8?B?YUo4SFpKU3N5UVBUK3hTTVgyZVBUdDFxZm1UamZScWhBTkp6RXlJOTkyQW1P?=
 =?utf-8?B?NDNLZmRpdUdZbWdLWFFmTldLVERHUTY5RE5wcWNNejFpV2F0am1QUFdUV3R5?=
 =?utf-8?B?L2NncXNYdUM4N2gweUgxcWt3ZG91MnRCOU1ISGlsQTA3MnFjT0pVRU8xaHBU?=
 =?utf-8?B?bGZyK21MVm82bHl4bi8zZlQ3cktSM2R6VFU0RHRHWHE5aHJNR2lIczZ4OWt3?=
 =?utf-8?B?ZEdoRDlyaWJSdTdjVDkzZUxmQnZQUVVyYXJyRXA2VVgrelc5cFVVVE41c3M5?=
 =?utf-8?B?QVY1aDEwK01ld2ZsdTRPdEl4Y2xmMTRVS0hlY3dtRXhoS0gzTDc2ZHBZZ0o1?=
 =?utf-8?B?NmxwU2ZKZWJWQ2xkdGhUdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6DA11342C3DAB40A6BFE4737DCF0D83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb5c6d9-8f2d-4deb-7ca7-08d8d8307113
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 19:23:03.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2jOhEZHFoQyb9DHrVGlhh+6lOMlhiD+9KjnOQHPBDxbXwJRzwPwiU/nDlGCkbGDT6tra0VvSwKO+7AZ7wugmNG41VUX0qq77Ku84UHHbEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3559
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTIyIGF0IDEzOjM2IC0wODAwLCBCZW4gV2lkYXdza3kgd3JvdGU6DQpb
Li5dDQo+IA0KPiA+ICtTWU5PUFNJUw0KPiA+ICstLS0tLS0tLQ0KPiA+ICtbdmVyc2VdDQo+ID4g
KydjeGwgbGlzdCcgWzxvcHRpb25zPl0NCj4gPiArDQo+ID4gK1dhbGsgdGhlIENYTCBjYXBhYmxl
IGRldmljZSBoaWVyYXJjaHkgaW4gdGhlIHN5c3RlbSBhbmQgbGlzdCBhbGwgZGV2aWNlDQo+ID4g
K2luc3RhbmNlcyBhbG9uZyB3aXRoIHNvbWUgb2YgdGhlaXIgbWFqb3IgYXR0cmlidXRlcy4NCj4g
DQo+IFRoaXMgZG9lc24ndCBzZWVtIHRvIG1hdGNoIHRoZSBhYm92ZS4gSGVyZSBpdCdzIGp1c3Qg
ZGV2aWNlcyBhbmQgYWJvdmUgeW91IHRhbGsNCj4gYWJvdXQgYnJpZGdlcyBhbmQgc3dpdGNoZXMg
YXMgd2VsbC4NCg0KR29vZCBjYXRjaCAtIHRob3NlIGNhbiBiZSBhZGRlZCBpbiBsYXRlciB3aGVu
IHdlIGhhdmUgYSBzeXNmcw0KcmVwcmVzZW50YXRpb24gZm9yIHRoZW0uIEknbGwgY2hhbmdlIGl0
IHRvIHNheSBqdXN0IGRldmljZXMgZm9yIG5vdy4NCg0KWy4uXQ0KPiA+ICsNCj4gPiArc3RhdGlj
IHZvaWQgKmFkZF9jeGxfbWVtZGV2KHZvaWQgKnBhcmVudCwgaW50IGlkLCBjb25zdCBjaGFyICpj
eGxtZW1fYmFzZSkNCj4gPiArew0KPiA+ICsJY29uc3QgY2hhciAqZGV2bmFtZSA9IGRldnBhdGhf
dG9fZGV2bmFtZShjeGxtZW1fYmFzZSk7DQo+ID4gKwljaGFyICpwYXRoID0gY2FsbG9jKDEsIHN0
cmxlbihjeGxtZW1fYmFzZSkgKyAxMDApOw0KPiA+ICsJc3RydWN0IGN4bF9jdHggKmN0eCA9IHBh
cmVudDsNCj4gPiArCXN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYsICptZW1kZXZfZHVwOw0KPiA+
ICsJY2hhciBidWZbU1lTRlNfQVRUUl9TSVpFXTsNCj4gPiArCXN0cnVjdCBzdGF0IHN0Ow0KPiA+
ICsNCj4gPiArCWlmICghcGF0aCkNCj4gPiArCQlyZXR1cm4gTlVMTDsNCj4gPiArCWRiZyhjdHgs
ICIlczogYmFzZTogXCclc1wnXG4iLCBfX2Z1bmNfXywgY3hsbWVtX2Jhc2UpOw0KPiA+ICsNCj4g
PiArCW1lbWRldiA9IGNhbGxvYygxLCBzaXplb2YoKm1lbWRldikpOw0KPiA+ICsJaWYgKCFtZW1k
ZXYpDQo+ID4gKwkJZ290byBlcnJfZGV2Ow0KPiA+ICsJbWVtZGV2LT5pZCA9IGlkOw0KPiA+ICsJ
bWVtZGV2LT5jdHggPSBjdHg7DQo+ID4gKw0KPiA+ICsJc3ByaW50ZihwYXRoLCAiL2Rldi9jeGwv
JXMiLCBkZXZuYW1lKTsNCj4gPiArCWlmIChzdGF0KHBhdGgsICZzdCkgPCAwKQ0KPiA+ICsJCWdv
dG8gZXJyX3JlYWQ7DQo+ID4gKwltZW1kZXYtPm1ham9yID0gbWFqb3Ioc3Quc3RfcmRldik7DQo+
ID4gKwltZW1kZXYtPm1pbm9yID0gbWlub3Ioc3Quc3RfcmRldik7DQo+ID4gKw0KPiA+ICsJc3By
aW50ZihwYXRoLCAiJXMvcG1lbS9zaXplIiwgY3hsbWVtX2Jhc2UpOw0KPiA+ICsJaWYgKHN5c2Zz
X3JlYWRfYXR0cihjdHgsIHBhdGgsIGJ1ZikgPCAwKQ0KPiA+ICsJCWdvdG8gZXJyX3JlYWQ7DQo+
ID4gKwltZW1kZXYtPnBtZW1fc2l6ZSA9IHN0cnRvdWxsKGJ1ZiwgTlVMTCwgMCk7DQo+IA0KPiBG
b3Igc3RydG91bGwgdXNhZ2UgYW5kIGJlbG93IC0gaXQgY2VydGFpbmx5IGRvZXNuJ3QgbWF0dGVy
IG11Y2ggYnV0IG1heWJlIHVzaW5nDQo+IDEwIGZvciBiYXNlIHdvdWxkIGJldHRlciBzaW5jZSBz
eXNmcyBpcyBBQkkgYW5kIHRoZXJlZm9yZSBhbnl0aGluZyBvdGhlciB0aGFuDQo+IGJhc2UgMTAg
aXMgaW5jb3JyZWN0Lg0KDQpIbSwgSSBmb2xsb3dlZCB3aGF0IGxpYm5kY3RsIGRvZXMsIGJ1dCBJ
IHRoaW5rIHRoZXJlIGlzIHZhbHVlIGluDQphY2NlcHRpbmcgdmFsaWQgaGV4IGV2ZW4gaWYgaXQg
aXMgdGVjaG5pY2FsbHkgJ3dyb25nJyBwZXIgdGhlIHJvYnVzdG5lc3MNCnByaW5jaXBsZS4gSG93
IG11Y2ggZG8gd2Ugd2FudCBsaWJjeGwvbGlibmRjdGwgdG8gYmUgYSBrZXJuZWwgdmFsaWRhdGlv
bg0KdmVoaWNsZSB2cy4ganVzdCB3b3JrIGlmIHlvdSBjYW4/DQoNClsuLl0NCj4gPiArDQo+ID4g
K3N0YXRpYyBpbnQgY21kX2hlbHAoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBzdHJ1Y3Qg
Y3hsX2N0eCAqY3R4KQ0KPiA+ICt7DQo+ID4gKwljb25zdCBjaGFyICogY29uc3QgYnVpbHRpbl9o
ZWxwX3N1YmNvbW1hbmRzW10gPSB7DQo+ID4gKwkJImxpc3QiLCBOVUxMLA0KPiA+ICsJfTsNCj4g
DQo+IE1vdmUgTlVMTCB0byBuZXdsaW5lLg0KDQpZZXAuDQoNCj4gDQo+ID4gK2ludCBjbWRfbGlz
dChpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIHN0cnVjdCBjeGxfY3R4ICpjdHgpDQo+ID4g
K3sNCj4gPiArCWNvbnN0IHN0cnVjdCBvcHRpb24gb3B0aW9uc1tdID0gew0KPiA+ICsJCU9QVF9T
VFJJTkcoJ2QnLCAibWVtZGV2IiwgJnBhcmFtLm1lbWRldiwgIm1lbW9yeSBkZXZpY2UgbmFtZSIs
DQo+ID4gKwkJCSAgICJmaWx0ZXIgYnkgQ1hMIG1lbW9yeSBkZXZpY2UgbmFtZSIpLA0KPiA+ICsJ
CU9QVF9CT09MRUFOKCdEJywgIm1lbWRldnMiLCAmbGlzdC5tZW1kZXZzLA0KPiA+ICsJCQkgICAg
ImluY2x1ZGUgQ1hMIG1lbW9yeSBkZXZpY2UgaW5mbyIpLA0KPiA+ICsJCU9QVF9CT09MRUFOKCdp
JywgImlkbGUiLCAmbGlzdC5pZGxlLCAiaW5jbHVkZSBpZGxlIGRldmljZXMiKSwNCj4gPiArCQlP
UFRfQk9PTEVBTigndScsICJodW1hbiIsICZsaXN0Lmh1bWFuLA0KPiA+ICsJCQkJInVzZSBodW1h
biBmcmllbmRseSBudW1iZXIgZm9ybWF0cyAiKSwNCj4gPiArCQlPUFRfRU5EKCksDQo+ID4gKwl9
Ow0KPiA+ICsJY29uc3QgY2hhciAqIGNvbnN0IHVbXSA9IHsNCj4gPiArCQkiY3hsIGxpc3QgWzxv
cHRpb25zPl0iLA0KPiA+ICsJCU5VTEwNCj4gPiArCX07DQo+ID4gKwlzdHJ1Y3QganNvbl9vYmpl
Y3QgKmpkZXZzID0gTlVMTDsNCj4gPiArCXVuc2lnbmVkIGxvbmcgbGlzdF9mbGFnczsNCj4gPiAr
CXN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXY7DQo+ID4gKwlpbnQgaTsNCj4gPiArDQo+ID4gKyAg
ICAgICAgYXJnYyA9IHBhcnNlX29wdGlvbnMoYXJnYywgYXJndiwgb3B0aW9ucywgdSwgMCk7DQo+
IA0KPiBUYWIuDQo+IA0KPiAvbWUgbG9va3MgZm9yIC5jbGFuZy1mb3JtYXQNCg0KVGhhbmtzIC0g
bGV0IG1lIHNlZSBpZiBJIGNhbiBxdWlja2x5IGFkYXB0IHRoZSBrZXJuZWwncyAuY2xhbmctZm9y
bWF0DQpmb3IgdGhpcyBhbmQgYWRkIGl0IGluIGZvciB0aGUgbmV4dCByZXZpc2lvbi4NCg0K
