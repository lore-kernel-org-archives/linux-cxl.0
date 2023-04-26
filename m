Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D756C7618E
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Apr 2023 22:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjDZWGL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Apr 2023 18:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjDZWGJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Apr 2023 18:06:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF10710DC
        for <linux-cxl@vger.kernel.org>; Wed, 26 Apr 2023 15:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682546768; x=1714082768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PBQUEYoKF4jX2UYg/jAOIWmHnYdLgSD6TJw+UUDV9cY=;
  b=PEHMyL/5FAmTDvF2MWYvJwNL3Kzsvx/ti/T6b4++ZGVGg6fYxpoXrKHl
   DG2ZrBVsi93RTbl2K5GRjaT1TmdkZ7swOKZSpvHQyIl3HyJ/KCYC9bCd0
   BsBk1gh0m99gKPYCd5a6IUK/PWuqwnWjlLc0Y/GoHY9M8MllbpNwzzLBP
   e/HjeYZ187FFlR2kZpt7WRqyiFADn0g/1VvIe8tzXI6b2kyW68z+y68ci
   qWHFKohRWpbF0v3KzM8u521bPeXxGeEMp2fxVdrj5kqWZTu1ntm06aM3q
   umS67FExBU5bFoQpb0wKCcFs/408H3dAkVoYT07VeleaxrGtWKKhH7akE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="412573624"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="412573624"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 15:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="671503683"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="671503683"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 26 Apr 2023 15:01:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 15:01:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 15:01:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 15:01:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 15:01:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYhCLmFmWdt3HHMXz4K7RMMMCdR4uEO4RFI8HtjXRCiC4BlWLtXir14d/2lUW72diva25RrCIujpkLudNHcQnG0wBJA0JNtQPv0fLxCsSGIoBLsRgRoNtlAQFtJyvb8ete5HkqRT5LwcnYNDxvHFApmo9fT43s+1YZcQfdCAphMOKSKLPHiOgPLasgZX6J9jL9R1Z4Jl8AfhPQqk7+BhKZlVGsReONYK8ZzSqoTWYtrUBlt8HQmyQ8uG8SaPVNqwFX4Jt7wmcGSBf1xxpcjneIkezdsYBqo736b6eUxxMjUYuWuFn/fZgGhgeGDn1OfSC8YD8IlmmYK7OF2kfn7EXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBQUEYoKF4jX2UYg/jAOIWmHnYdLgSD6TJw+UUDV9cY=;
 b=OVtbe8bdJPeYYNXC9guOtsQ4DsEvZc9gnhFhmUjDTBw4jqV9+dM3CIDAv4DIck0R9JZsL3+YwX2QcAhRDA/Ogpa80/SLUHu0WDVlP7M8oEuSZ0/eWSbIqQs7f28shBwXw5HmikpcyLziJ9Wr5Nfd6Y0x3V6dx7oOK/nYJ8OJC1G07mKfPe3KjYjsBfXv5x4LVVW2ESasZ8yBZfIcQXriclYsLgCS1jK8EcmfdcCsJjw1RLF899mHwikSXNlgn6ypHOE7mSJ1VQ0B+X5KLjzWlfOo0wjLUpybsAlIGesCKBNEBb0yXo9L55vVhhQLOHGHPvqbluCFqESjZCH8aPg1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by CY5PR11MB6463.namprd11.prod.outlook.com (2603:10b6:930:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 22:01:10 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::3403:36be:98a3:b532]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::3403:36be:98a3:b532%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 22:01:10 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "dave@stgolabs.net" <dave@stgolabs.net>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/memdev: Introduce wait-sanitize functionality
Thread-Topic: [PATCH 1/2] cxl/memdev: Introduce wait-sanitize functionality
Thread-Index: AQHZdYuv/yX//gAh2kijNclYcEGXc6897DgAgAABi4CAADxZgA==
Date:   Wed, 26 Apr 2023 22:01:10 +0000
Message-ID: <5c61fcd5b226b12abc5f22104a6034f60173363e.camel@intel.com>
References: <20230423015920.11384-1-dave@stgolabs.net>
         <20230423015920.11384-2-dave@stgolabs.net>
         <a1546a23259826fa1e1e469e7d9de902ae914e7e.camel@intel.com>
         <qfnmbur5kofs6tyje7e4xyui6jyifv4lt3oyydre5n2z5igzsm@wgwqdb4hbazf>
In-Reply-To: <qfnmbur5kofs6tyje7e4xyui6jyifv4lt3oyydre5n2z5igzsm@wgwqdb4hbazf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.0 (3.48.0-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|CY5PR11MB6463:EE_
x-ms-office365-filtering-correlation-id: 6438514d-726d-4728-3618-08db46a1be6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xkv+KSdm6jdU46PX7AeGpCbbqyGNB16lFkOknj9UF20uRsoyMX+RDadTasx5XX7tPypqdAYmrMpt2OsoaeeRSgBfwYZtsSNTSdtzlqA08aIJO7DuvtWQn5OyTZXbdwERdh7fFB3fx1n9EnNtV8Nk1XyMGy3vTZQhH+wGFxjZicu2y9cHLqLXUPBDsQ0SQ/hGLxentTtoQTbSZXn7whEigubjIgfwI7DUxN0GAfvxmUe1kDzpWCj5g3fBGmmow6TFomqYd9JFDC30pj9/6CrwLWF8kh0tFO/LiqsF5Ug6Ezyf6wKJZOAjEY/2nt0vxbRzv0A+duDKL+nMEDj1heXGJLJ9XEAEVJJmK+esqh3GatLOQezqPb01cMJaXuIJO5vujMLF4dXGmKdp39WIc7lOY2gdsW6SLZ3maeXE1hLDl7nXdSdv4YMfVr/AD3O/TWQxvLiyueSPDoxfuQ5tCxL9HlUKnPslxD+IKSOZAXh7ABTFX8CsJxcnpTjTZPwzZKL1sO5hlobO2jCDQ31B2b7ChHOVIfpCfZ0uhx4EA/BpeajnisY+YfhNumTxKNXzxDTeV5FA41yZGdD46UZPTBMgn4ri/Spi3a3wpJ9uQiLA0gQ0ioxbDyVxS/xYlFgnAyE6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(6512007)(6506007)(26005)(186003)(478600001)(5660300002)(8936002)(71200400001)(6486002)(8676002)(36756003)(2906002)(38070700005)(41300700001)(66946007)(4326008)(66476007)(82960400001)(6916009)(64756008)(66556008)(316002)(66446008)(38100700002)(86362001)(76116006)(91956017)(122000001)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlEwSnVqSTBlZlAvbURFcXFocFoyRHNjY2dHeUJyYlNKMmdtWlpuVGFDVjQx?=
 =?utf-8?B?bkQ0UXpVakl0L1VHaTh2RW9VZGFaeWE0OXNzQUl2N1BDaHpNY29PMnFwci9o?=
 =?utf-8?B?TndTME9jNjRnLzJLWnRCbG5QYWZrMGpPL1VzenN6Mi9TQmVyb3ZzbUVmMkIw?=
 =?utf-8?B?VzBDRXptajQrRHhTNXMrSm5Kb3hiQi9iRXZmT2lVa0N4bEV4UjhmdEl6d1pX?=
 =?utf-8?B?TUVvaDI3TFJseU5XbG1rTVBSYmhhV1gzMkFIQUxRTm5lTVhBSUFLVlB2SWRV?=
 =?utf-8?B?d0ZOMDBmcklnazJVMlNuRXBTVDhpUWs2SVJMRjgwejJSYkM3RjlpZnlad1ll?=
 =?utf-8?B?UU5SU05UbGE4T1hQZmpsLy91OGNieWtobEhZVzJDTDZ0QXA2M3NxQzVTQ0Vy?=
 =?utf-8?B?ZDIyNHp3QU1UWUo1RHRuNCtwWEJsRDI3SjFDS3hZYnZyaFBFNXplV2cwVERE?=
 =?utf-8?B?UXdwRTFVdEhNcS9NbkN0QWwwd1RUd2V6djY4WFFxL2IrU0d1WWd2WFBuelN0?=
 =?utf-8?B?c3JpQXo2N1J1RU9YUUpVVVkvTVRMMDNuL2V0RjFZS3V3NnNsb0I4RWJqeUg4?=
 =?utf-8?B?ZVlYKzlSOUJGc3c5WUF4T05tTURjVTRJV2ZyWEU4bng4TU5CL0NkNHJvNnRo?=
 =?utf-8?B?VmgzcFJCMmptS2sxa0JTSHBmeFNhNXk2MEVubHQxeS91RkkvWVBCSEdYS2Q2?=
 =?utf-8?B?dFZCZ01sNERCZzRpNHZ2SCtyVmdvMmtmREw4Sm04TWk4ODlpV2RsWTBUQ0l2?=
 =?utf-8?B?NzVWMi9mUFNsZytidVgyVXFvVmxpMXA1L25sMUt4L1hiZWVNYmU2SWtzSFpO?=
 =?utf-8?B?cGloVDN3b0l5WE5sam1tQ05GQXBhZzAzaXdxMVVLaEdBdUFhemhORVhhdXl6?=
 =?utf-8?B?K0FxNCt0YWNNcTF2ejFkZkU2SFdaUVg3LytTc2FrbzVueDhUQUYvc3cra3hQ?=
 =?utf-8?B?aE1tWkFMdHRnNnBZcys1UyswKzJZWEhFRmpyUVJ6M2w4RDUwSWRMb0ZQMG8v?=
 =?utf-8?B?dTJ2eVZIV2NocEoySjJ2VXVHTDhEdTRkL1FySUNtYWdOTkdjNW11cTVHWHJY?=
 =?utf-8?B?ZFlOR0VIcHlPSkc5c29qR2ErYnV5N1Eybm90Sk5XdUFaMjdibTFWVGFBWlBU?=
 =?utf-8?B?OHJwVkJhTkcvNDEyNG5LbEdSblU3M2ZTdEEveVlMUmxiSURPVXlxUXlFU2pZ?=
 =?utf-8?B?b0pPMWxKOVUxVzlEejlrZHNNR3JoMjFtcElOOHJQVGdrS25Vb3YvSnhmRVFa?=
 =?utf-8?B?YkdxR0d4SGZMNVc0VlZCb3lkd2pLSThhOEh0VnVqUmxoVzFRYWs3T3Q1L05U?=
 =?utf-8?B?bTRzSmc4ekd3YWVRMyt1RmNOSTQ4N1JNaSttbjFQTTRCamhxNTRjV0VCckFE?=
 =?utf-8?B?MWswa1RMWHZBSDlHUVhtTFk2bXhuRmh1QkZCY3JYVmFiRDRtT3dPU1ZUWTls?=
 =?utf-8?B?SDR4NlduZVRJVk90dENnaG1zWGJub2R6emlCQzMzaVR2b00wT0U1OFZCQW1t?=
 =?utf-8?B?ZVVrbjRoRmUrdFlEb0J3bkdrSVdNQ3l4T2FuOGtNajlONVNGOEFYeFhvWVE1?=
 =?utf-8?B?VTZkUU5jdjdlYmlpRzRucEhqNGlYU2xIOTFqTU5wQjBqaEpVZ3RZY2tlQzRt?=
 =?utf-8?B?Mmhtb3pwRFViMkY3L0V2aERzaDl2MzN5T3lEN2JNZ3l3Rm9EcVVrQTZIUGhP?=
 =?utf-8?B?T1Mvd3QyQ1BGb0FWazFBWGtVSUVsejVram9tdHVNeTJMMEZvenNFN09hcncw?=
 =?utf-8?B?QWxTeDJsZnlyT0t5WGpGVE93S29CeDRES2ZTUDNLSmptaVRWMzE3dG5XRTVL?=
 =?utf-8?B?MllnMTF2a05mZW9aaWxZUHJySm9YVVk4UFpGb3pOTG1lUC84RklwQXRIbnBD?=
 =?utf-8?B?MWsxdDhaZlV2aUp5ZmdIMkQ3QWpKNW94bXpVeU5rZllEd2wra051dUVlaURK?=
 =?utf-8?B?TlRHQlMwS2lXKzAzMWdwcXl2UFNzeTdYMURIQlJ5andwc2JFSThxcSt0bklt?=
 =?utf-8?B?OElPaEhrM0lPUHpac09HTXllbnN1Z2NqSGFON3NMS3Q3QTJMRHBqaHZ5dVZh?=
 =?utf-8?B?RUl2Zmt2a3JBUG1rRVQrZWNvZW9sSEVtWWFHS1dJTGN4WE5LZWZpRmRrTU04?=
 =?utf-8?B?eFh1ZTdqaXJnQ01SU2NPQkt3RzNmYmxyUlNhbUtyekYyajVFM2FxbVA3cFZw?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <338ECCE41E117C4DAB9ABE4F7A8FC51B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6438514d-726d-4728-3618-08db46a1be6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 22:01:10.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ia7h6sL9m2lfd6bLZFPyYr8VxC+QMA782J32URqOUX8ecUUtbw5oleQvBxUiaECn9Jq68Z4QzU+N2p8CX1nIqVUHRulkXJDFyrDW/5bMuGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6463
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gV2VkLCAyMDIzLTA0LTI2IGF0IDExOjI1IC0wNzAwLCBEYXZpZGxvaHIgQnVlc28gd3JvdGU6
DQo+IE9uIFdlZCwgMjYgQXByIDIwMjMsIFZlcm1hLCBWaXNoYWwgTCB3cm90ZToNCj4gDQo+ID4g
VGhlc2UgbW9zdGx5IGxvb2sgZ29vZCAtIGp1c3Qgb25lIHRoaW5nIGFib3V0IHRoZSBzeW1ib2wg
c2NyaXB0DQo+ID4gYWRkaXRpb25zIGluIGJvdGggdGhpcyBwYXRjaCBhbmQgdGhlIG5leHQgb25l
IC3CoCBUaGUgZGlmZmVyZW50IExJQkNYTF9ODQo+ID4gc2VjdGlvbnMgaW4gdGhpcyBjb3JyZXNw
b25kIHRvIGEgbGlicmFyeSByZWxlYXNlLCBhbmQgYXJlIHVzZWQgZm9yDQo+ID4gbGlidG9vbCB2
ZXJzaW9uaW5nLg0KPiA+IA0KPiA+IE5ldyBzeW1ib2xzIGluIGEgbmV3IHJlbGVhc2UgYWxsIGdv
IHRvZ2V0aGVyIGluIGEgbmV3IHNlY3Rpb24gaW4gdGhpcw0KPiA+IGZpbGUuIGUuZy4gdGhlIHBl
bmRpbmcgYnJhbmNoIGhhcyBhICdMSUJDWExfNScgc2VjdGlvbiBmb3Igc3ltYm9scw0KPiA+IGdv
aW5nIGluIHRoZSB2NzcgcmVsZWFzZSAoY29ycmVzcG9uZGluZyB0byBrZXJuZWwgdjYuMykuIEFz
c3VtaW5nIHRoZXNlDQo+ID4gcGF0Y2hlcyBhcmUgdGFyZ2V0aW5nIHY3OCAvIHY2LjQsIGl0cyBu
ZXcgc3ltYm9scyBzaG91bGQgZ28gaW4gYSBuZXcNCj4gPiBMSUJDWExfNiBzZWN0aW9uLg0KPiAN
Cj4gSSByZWFsbHkgaGF2ZSBubyBzcGVjaWZpYyB2ZXJzaW9uIG9mIG5kY3RsIGluIG1pbmQgaGVy
ZSwgYW5kIGZvciB0aGUga2VybmVsDQo+IEknbSAidGFyZ2V0aW5nIiB2Ni41LCBzbyBubyBodXJy
eSB3aXRoIHRoaXMuIEl0IHdhcyBtb3N0bHkgaGF2ZSB0aGUgY3hsDQo+IHRvb2wgc3VwcG9ydCB0
aGVyZSBmb3Igd2hlbmV2ZXIgdGhlIGtlcm5lbCBiaXRzIGxhbmRlZCAocGx1cyByZWN5Y2xlIHRl
c3RpbmcNCj4gdG8gZXhlcmNpc2UgdGhlIHN5c2ZzIHBvbGwoMikgc3VwcG9ydCkuDQo+IA0KPiBX
b3VsZCBpdCBtYWtlIHNlbnNlIGZvciB5b3UgdG8gdXBkYXRlIHRoZSBsaWJjeGwuc3ltIGZpbGUg
Zm9yIHdoZW5ldmVyIHlvdQ0KPiBwaWNrIHRoaXMgdXA/IElmIHNvIEkgY2FuIGp1c3QgZ2V0IHJp
ZCBvZiB0aGUgZW50cmllcyBpbiBhIHYyLg0KDQpBaCByaWdodCAtIGFncmVlZCBvbiA2LjUgYXMg
SSB0aGluayB0aGF0J3MgdGhlIHRhcmdldCBmb3IgbXctdXBkYXRlIGFzDQp3ZWxsLCA2LjQgc3R1
ZmYgaXMgYWxyZWFkeSAnZnJvemVuJy4NCg0KRG9uJ3QgcmVtb3ZlIHRoZSAuc3ltIGVudHJpZXMg
LSBJIHRoaW5rIHRoZSBidWlsZCBtaWdodCBldmVuIGNvbXBsYWluIC0NCmJ1dCBpdCBpcyBhIHNh
ZmUgYmV0IHRvIGJhc2Ugb24gdGhlIGxhc3QgcmVsZWFzZWQgdmVyc2lvbiAodjc2KSwgYW5kDQp0
aGVuIGp1c3QgYWRkIGEgbmV3IHNlY3Rpb24gZm9yIHlvdXIgZW50cmllcy4gQW5kIEkgY2FuIGZp
eCB1cCB0aGUNCmluZXZpdGFibGUgbWVyZ2UtY29uZmxpY3RzIGFyaXNpbmcgZnJvbSB0aGlzICh3
aGljaCBoYXBwZW5zIHByZXR0eQ0KZnJlcXVlbnRseSBmb3IgdGhlc2UgYW55d2F5KS4NCg0KPiAN
Cj4gVGhhbmtzLA0KPiBEYXZpZGxvaHINCg0K
