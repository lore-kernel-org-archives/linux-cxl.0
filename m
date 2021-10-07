Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53208C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Oct 2021 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D5061139
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Oct 2021 21:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhJGVcL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:32:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:23862 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbhJGVcL (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 7 Oct 2021 17:32:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="312565955"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="312565955"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 14:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="524817220"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2021 14:30:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 7 Oct 2021 14:30:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 7 Oct 2021 14:30:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 7 Oct 2021 14:30:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTwTNMEpNHPpXjeB8o+fnuqAQc6Zphnynl4PD7CvGFZoRbq7Yj7q1RBN5qk3aTkx/JlbiUI7+MhvjtnaCYlyXkL/8kGsNChSGlgeuNhaT6W7ig/Al6TfgfiZyQEkS06KGZ1+HvkLCBxdaKHVnJhAqU0SiKGgZJffWk03yLCVbHYlAtxSHbfCJMP/vZ3yCgLR9MwizAkSSpUen1kqUVkem2Xo2LDNOwi7xcKXPUCk84ZUcWLijBQkrHLY0GcfsByvhRWkBHbzjaiICLwwFEZgBQ05K0TYyBpjgNg9XbHQf5LNst5TW2BZlzPZ+g2vkCzQK385ISH6THmHd58jqsLm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrARHbXrmHhIriXKXC28DCmSo22edDSNUULpuokO6jc=;
 b=F3oKTTwNbJ9KKE+JI+436RS7DRzpBR4Hdb4WA4GnpTWi1Q8oj1sS6oYeWC0uMPsY64mevBPr7ZKCXOL4ynW1N74kUWl9clTfw/XUp5g3HlV1wlAG8jZucrCaOzQ+6/cH3trfYzmmNLppTHNdzBGiDg/X81NprZGGHT2jFkgaXvvd6RkHeRhrfdDTb+cwoclcI1ojcjawOjbjmlaeyIrl1BrMFpCkJHRG24bf/PU4Kj09AX3Qpu1Kz5eFr5uCYm7iwW5X796XiEVhX7OS+gY0F4ajILGrZKuSmx+T8b5XTkufjhxN70qUiePdtOLI+qcpSWaWti3BoM4l5X3LHgG/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrARHbXrmHhIriXKXC28DCmSo22edDSNUULpuokO6jc=;
 b=HCZ0h49j+fDhip8Z+XMFWth04xRas1stptG8ucr59LCrz+9IIy3x1jP1rk/SQsw6wTwMrMLTsJ/BGlvRdOr2KIcKzA6ZaJyeV1toLDxuXz4fDBSdZg1NFDg2uIQUPdFdN5sIF3PY8kgo6C4fBUqKZ4FRcjoe2swdTtBFdqGu9Ko=
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MN2PR11MB3552.namprd11.prod.outlook.com (2603:10b6:208:ed::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 7 Oct
 2021 21:30:12 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d8a5:47b2:8750:11df]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d8a5:47b2:8750:11df%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 21:30:12 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "john@jagalactic.com" <john@jagalactic.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "johnny.li@montage-tech.com" <johnny.li@montage-tech.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "jgroves@micron.com" <jgroves@micron.com>
Subject: Re: CXL 1.1 Support Plan
Thread-Topic: CXL 1.1 Support Plan
Thread-Index: AQHXjeOyDbo/H0Y69E21FQB9XsVm96ts2ugAgDVln4CAAEkWAIABn6OAgAAG9ICAGUX1gIAK8xOA
Date:   Thu, 7 Oct 2021 21:30:12 +0000
Message-ID: <8a9b94becf407e218a544d3d0d9286ec4c698099.camel@intel.com>
References: <YT9kSHU+P5wrnm2S@BigDog.local>
          <CAPcyv4gY7UvT7fkCcvxGwe7-s6r40rFExwLN2oc7xBtMGdRyAw@mail.gmail.com>
          <0100017bdf9fcce1-400920ad-2274-4d39-b45e-45410426db50-000000@email.amazonses.com>
          <dd56f465-560e-9408-d7e6-9f8de59bc792@jagalactic.com>
          <CAPcyv4hjD=1EEAkjx+r3DRxASCGpF45kOyOZVULsMDekyG6TYQ@mail.gmail.com>
          <0100017be5e140c0-cedfdc46-26b6-4009-899f-8dfb2268af2e-000000@email.amazonses.com>
          <CAPcyv4g-t_kY84TSq6WbWP96hjOupXx1KYtB9XznQ4y2NooXWw@mail.gmail.com>
          <2093cae0-ff0b-1d6d-2ff2-ba1bb41510af@jagalactic.com>
         <0100017c38c8cbb1-c0632347-44dd-44a4-b6c2-4e33c2ba85e8-000000@email.amazonses.com>
In-Reply-To: <0100017c38c8cbb1-c0632347-44dd-44a4-b6c2-4e33c2ba85e8-000000@email.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: jagalactic.com; dkim=none (message not signed)
 header.d=none;jagalactic.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6734c25e-7750-46ee-c3f9-08d989d9a52f
x-ms-traffictypediagnostic: MN2PR11MB3552:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB355265D0DCDCDE246BDB7B37C7B19@MN2PR11MB3552.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LuaHjqG44FyDdFUywFOvqeFjiSZoY8djlRF43E4oCtdCEXapN3ql4c4h6AQOWGs6ofYA/HIbkGKnLq2791kFHT3RNWqKEDQI4CHvtorVn45PA/V2rNBM7XAa/+NCC1FlrpddGDiq8Ja8ur2OshbAuVJ8IMHWLwsYcEIfzIEVmP0XGIfFXCa3kQ5DkjeNfwg7+6ISdkgCf2QgiNWjmCMoWO+VnT2Ask7wlokfjXqDLxzyMuvkGrgy6SUT++iiYr/YMSC4lZA629R9b84nenYQhEFAZ3It3pfROIovUH+ijwTYnu6HrErJEVIOIEbK4mgahK92ui6Ix22GYKKgU/WMjbBEPidRfwniaZeO1uP/ZAmS++pybhj0AjF1RZyspaMlIGgKfwfdnTq0LlEBfE8F9MkffJrsi9XqAKXZn1puzTOUas2r2Gb6soBTXAc7uLMA5xYwvC8bIptqivMnOYrx3khhXwYSszsmEv9V4K/aGwn9JT+9ePzO3e2+DUojC5U7GMBO1eRziohwLTMho1tefzS4QFEmAg4ii0UXCoeTqiy3NQhBD2BBAomutNzFxMiv9IDSuNcr/beURF4XnQF4MLIEy43eQ68BFTHsDzkvNJT0MPH8EMSpA8lzR7j68ex4t+crN4armnMt1zxObyaXtjR1EDLqGZqYBU8jv4NbAuAVJxOEcepnRAGa1b6rYQbdzcy8J2ZNfQQfr0YQw0M6bmLFq2Yh5Hg3KB+lLHYePUQILerZMxiwOmtghkT+XZIDlXmBEIyO0DnxqmOhzVoew3Ogkyy2PrtlqlLsqFq8yyGnRhKEvKFlZZM9gT1d6fJgmzwNXsg5sZE80RyjwlYhDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(38100700002)(122000001)(26005)(6636002)(110136005)(54906003)(186003)(86362001)(91956017)(64756008)(66556008)(66446008)(8936002)(66946007)(6486002)(71200400001)(66476007)(2906002)(36756003)(6512007)(76116006)(2616005)(83380400001)(316002)(966005)(508600001)(8676002)(38070700005)(4326008)(7116003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Umh4WkVvWURmLzY0SFNENVk5Y21nYmFhNjlDZHRTdEh1WExkNjk0UHYvaHk0?=
 =?utf-8?B?SWpKczRFUE1QU3BuNHZvNzg3dDFNMWh4UGJaWFdHemxSZGhKVkMrbnJwSjRE?=
 =?utf-8?B?aTU3NFFqSW9jR3hzaDRKMlhlT0FsRTJoTkppYjRZazE2c0MydjF4UVBFWE13?=
 =?utf-8?B?dFR1N29ZWlYxZXlOdnRMdXVSSUhFREdHd3l0SUNJMlNzbmVlc0NmZjA5OHJI?=
 =?utf-8?B?enBHNEpJYVQwY2ZCUmtXdWZiWnh5TG9qNU41WC9kYjAySDFWK3YvWTFKOXdE?=
 =?utf-8?B?eEwrdHRtTkNuemZZajNuM3R2VVlxdTg2aDMzSDJWYWpscHBHWlljcC90Q3NB?=
 =?utf-8?B?QURPdEpsc0dvRW10UFBkZDdudmJuSEQ3WkJYeEVqemVOd0JwSTdCdjFHZXdZ?=
 =?utf-8?B?alVBcFR5Qkx0R244SnBaNUpUeGhxT0luYllCV0c3K1FLeFo0anVlVmlUUlQ2?=
 =?utf-8?B?clRWcUdic1htQ3VUZ28ra3dJY3pEL0dKU0o3Y09oZlhTdHdPSU5BaVM0TnEw?=
 =?utf-8?B?ZGVuZFR2a1F2Y3Zxc3YycTMya3Q0RGJmbG50VXhoNzdTMlExQ3NCaWdpTXNY?=
 =?utf-8?B?UGZnU3p6NXM4RDQwOXhmV2puQnNTenZCOWF6bEN4b3Rtb000dmE5dDZZMThv?=
 =?utf-8?B?QlRGRUxDTGlWUWRHOGlJc1JneVRjMWkrbURKZ0dlcWQ4Yk40WDlCQTh4b0tI?=
 =?utf-8?B?MFNEdkJqRytlZjRxSkttbERyNzJmVFFkSWVKUjRJbjdEWjRnMWtCdWRpT01F?=
 =?utf-8?B?czJrbGw4U1VTdWpZL2JkWmp1ams4MExwbVVMK3l4Rm02anR5ZnRZcG5uNGtJ?=
 =?utf-8?B?VzB3K0dWVjcrRmZnc0xTeG9RTUtxL0EvV3NnQm1lVEQ1U1A3bXRHL1lLRStr?=
 =?utf-8?B?SUZrWnlmR0lHa1dHR0ZPcmh3S01VZHVWY25pRUthREZZTzJ1c2xzcTRiNHc0?=
 =?utf-8?B?R1Y3OXoxeElXM21QVXpsM3NiWlFCT1pCWEVEbisrQUphSXhNdllpd1ZwNkdn?=
 =?utf-8?B?QUhCWDhxZkdaTEZOQUR4cVBwbnphQ3JGZW1ZL1hGYk8vYjdFVk1abm1sRkFK?=
 =?utf-8?B?OVlad3Q1dTh5RkVMWTBJVkVLaVlKRkI5alZEYXFiYVR6U0VWODh4OHljUGVK?=
 =?utf-8?B?bTlzWC9Md3hrR2YyQng2UU5uZEdIQ2pkNVV0M0pZQnYzQm1wWlJXaDl2a1Jw?=
 =?utf-8?B?SVRLcFFTTGVwdm1EOW5zWGErbmhyL2ZjdnlCWloxNzFEdkRDNWxtR3lJUXEr?=
 =?utf-8?B?b2UwdmZtRDlLNmhUTWsxTFZ2alVDamVKMnE0UFJjMzdQeHVKNXUzV2VqYXJ4?=
 =?utf-8?B?OEE5LzVXcmtxYU1IMEpseVcydU03SGZpWTkyRnUrUksvdi96bE91NGVjZ3VW?=
 =?utf-8?B?bS9Mc0NQemtKN25zeVNhT2Z0S05Ya0tkYVh5VnhJYUx0VVU0ZCtkU1k3ekdp?=
 =?utf-8?B?bHJnUUJKZnRyQU4vMFBQK2ZRTmEyeFhUWlhDemtVUWZoVjVLYzEvUTcwV04y?=
 =?utf-8?B?OWVIM0NmVHpxYkNGZ09nQkx0NnE2MW5KQkEyV3Q0RWFMb3NCajNNMGxDcTVL?=
 =?utf-8?B?Qk9SRGxYdXFsUUpHdFBoT0pwWS9uZ0hIVEkxbGEyalFJc2UwRzF3cG04NVc5?=
 =?utf-8?B?OWl5L3RobzhkNzI5MW1qcUZvNkdnVTJJMVAyL0NEVkdDL0xVbmxJSHZGWFdN?=
 =?utf-8?B?Y05sSm1sVVE2eGpRMm9NTXY3UnZyQXdZdHFGZTFObFpiOGJvM1JjeDZhUHQz?=
 =?utf-8?B?RHZuMHArSnFrdkVpNmxORXgvaFlJcE1zcmhPdDZmcEFZVEdGTDFDekJhZDB6?=
 =?utf-8?B?M2xNR3B5bHJXT2RaV2xndz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAF27D2776A7C249921FBAAA6B61DD6E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6734c25e-7750-46ee-c3f9-08d989d9a52f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 21:30:12.0316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kN1SwfrHrQhnKtY9y06JJBmPB1Xow7hu2U5nNneJkmz2RFKMOY/LG5GIF0lhnCMFmZhXT9Vqqm/bLr1IxHmSNG4hGY0USSKFClUO62DIzlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3552
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVGh1LCAyMDIxLTA5LTMwIGF0IDIyOjE3ICswMDAwLCBKb2huIEdyb3ZlcyB3cm90ZToNCj4g
PiA+IA0KPiBJIGRvbid0IHNlZSB5b3VyIGRvYyBwYXRjaCB5ZXQgaW4gdGhlIG5kY3RsIHJlcG8s
IGJ1dCBJIHJlY29tbWVuZCBtZXJnaW5nIGl0IHRoZXJlLg0KPiANCj4gQSByZWxhdGVkIHF1ZXN0
aW9uOiAiZGF4Y3RsIHJlY29uZmlndXJlLWRldmljZSAtLW1vZGU9c3lzdGVtLXJhbSAuLi4iIHdv
cmtzIGZvciBtZSwNCj4gd2l0aCAtLWZvcmNlLCBidXQgZ29pbmcgdGhlIG90aGVyIHdheSAoLS1t
b2RlPWRldmRheCkgZmFpbHMuwqAgQnV0IGEgcmVib290IHB1dHMgaXQgYmFjaw0KPiBpbnRvIGRl
dmRheCBtb2RlIHJlZ2FyZGxlc3Mgb2YgdGhlIHByZS1ib290IHNldHRpbmcgKGkuZS4gLS1tb2Rl
PXN5c3RlbS1yYW0gcmV2ZXJ0cw0KPiBiYWNrIHRvIGRldmRheCBvbiByZWJvb3QpLg0KDQpPaCwg
SSdtIGEgYml0IGNvbmZ1c2VkLiAtLWZvcmNlIG9ubHkgYXBwbGllcyB3aGVuIGdvaW5nIGZyb20g
c3lzdGVtLXJhbQ0KdG8gZGV2ZGF4IC0tIGl0IG9mZmxpbmVzIHRoZSBtZW1vcnkgZm9yIHlvdS4g
V2l0aG91dCBmb3JjZSwgeW91J3JlDQpyZXNwb25zaWJsZSBmb3IgYSBwcmlvciAnZGF4Y3RsIG9m
ZmxpbmUtbWVtb3J5IGRheFguWScgc3RlcC4NCg0KR29pbmcgZnJvbSBkZXZkYXggdG8gc3lzdGVt
LXJhbSBzaG91bGQgbm90IG5lZWQgLS1mb3JjZSwgYW5kIEkgZG9uJ3QNCnRoaW5rIGZvcmNlIGFj
dHVhbGx5IGRvZXMgYW55dGhpbmcgdGhlcmUuDQoNCj4gDQo+IElzIHJlY29uZmlndXJlLWRldmlj
ZSBjYXBhYmxlIG9mIHJlbWFpbmluZyBpbiBlZmZlY3QgYWZ0ZXIgYSByZWJvb3QgKGluIHdoaWNo
IGNhc2UgSSdtIGN1cmlvdXMNCj4gaG93IHlvdSBwZXJzaXN0IHRoZSBpbmZvIGlmIHRoZSBkZXZp
Y2UgaXMgdm9sYXRpbGU7IEkgYmVsaWV2ZSBpdCdzIHRoZSBMU0Egb24gYSBub24tdm9sYXRpbGUN
Cj4gZGV2aWNlKS4NCg0KVGhlIGJlZ2lubmluZ3Mgb2YgdGhpcyBhdXRvbWF0aW9uIGFyZSBpbiBw
cm9ncmVzcywgYXQgbGVhc3QgZm9yDQpjb252ZXJ0aW5nIHBtZW0gZGV2aWNlczoNCg0KICBodHRw
czovL2xvcmUua2VybmVsLm9yZy9udmRpbW0vMjAyMTA4MzEwOTA0NTkuMjMwNjcyNy0xLXZpc2hh
bC5sLnZlcm1hQGludGVsLmNvbS8NCg0KVGhpcyBpcyB5ZXQgdG8gYmUgZXh0ZW5kZWQgdG8gdm9s
YXRpbGUgZGF4IGRldmljZXMgYWZ0ZXIgZmlndXJpbmcgb3V0DQp3aGF0IHByb3BlcnR5IHdlIGNh
biBrZXkgb2ZmIG9mIC0gb25lIGlkZWEgaXMgdGhlICd0YXJnZXRfbm9kZScgZnJvbQ0KQUNQSS4N
Cg0KPiANCj4gQmFjayB0byB0aGUgcGF0Y2g6IHlvdSBtZW50aW9uIC0tbW9kZT1zeXN0ZW0tcmFt
LCBidXQgaXQgbWlnaHQgYmUgaGVscGZ1bCB0byBhZGQNCj4gYSBtZW50aW9uIG9mIC0tbW9kZT1k
ZXZkYXgsIGFsb25nIHdpdGggYSBtZW50aW9uIG9mIHdoZXRoZXIgKGFuZCBob3cpIHRoZXNlDQo+
IGNoYW5nZXMgYXJlIHBlcnNpc3RlZC4NCg0KVGhlIHJlc3Qgb2YgdGhlIG1hbiBwYWdlIHRhbGtz
IGEgbGl0dGxlIGJpdCBhYm91dCB0aGUgbW9kZXM6DQoNCiAgaHR0cHM6Ly9wbWVtLmlvL25kY3Rs
L2RheGN0bC1yZWNvbmZpZ3VyZS1kZXZpY2UuaHRtbA0KDQpEYW4gLSB5b3UgaGF2ZW4ndCBwb3N0
ZWQgdGhlIHBhdGNoIHlvdSBhdHRhY2hlZCB0byB0aGUgbGlzdCB5ZXQgaGF2ZQ0KeW91PyAvbWUg
Y291bGRuJ3QgZmluZCBpdCBvbiBsb3JlIC0gd2Fzbid0IHN1cmUgaWYgSSdkIGp1c3QgbWlzc2Vk
IGl0Lg0KDQoNCg==
