Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFFCC00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiHATrN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiHATrL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:47:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D283D2E9F7
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659383229; x=1690919229;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=NP1fAs2ISf4Yvv/bWlY4SoRxJv0vtGJ6b0kYzE+PVeU=;
  b=TPyPU9ujBxXPpEEVgQEpa4B6ZW74szf6kLgLztmS2aNmbqsuKvWtQXSP
   5oTv6dbUcewkhg7Z+n3JH8Xjy/sgm1nNbelMGJGqWCvnsG1h/paufXdI9
   vF/Ohf7VboauaDpziMGBojcrhFXQneyaemiI0+JfU+6bXVM3cw5C0v3Tm
   iRrHWmuTe7vNVv4jVkchwDC20/SBeCT0z8a5Mj4wDpkE6q79bpe1KGrn0
   k+PiNcFgG2gZmmR/yH22WS6YTaRFAIIvBl6M37K96GzRgitttSH7gaWXu
   alspjmIWIrbCcvKbL6oQ7EZfZLSH3KeSC0JZAjXKQIan60qIuri9yoyt+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353235717"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="353235717"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="705094651"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2022 12:47:09 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:47:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 12:47:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 12:47:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgetMbcXd/j19EsAOU4zgDdnu+r/5ez+kRykFAbZ6hWr2dqHtCY6wRyto3F3gjdJV8s2w52oBe78F01dhdoHafv/7AvNhkeWAPHxy1b5AuXfmQNOC12FD6QDvzNoe5GGfC4/2aOW6nn62d7nVRmFN4NJWNl7rYB0Q9c+AsxjYDtjIOHoYRg6s3A1fKQ2jiz79EndB8HsZpbLgFMdrjjLxrRk5jhB3eBs6WyGlGKMc8okezD1j/V+mTD2M7xDqhUGJlB4tH12DtN4K2ZelyGjBTgTpGgm5aSv1r8yRuhMrzR9eO1gNcrdIDf7GKxn7xG/+3m4QtG6e7Y9fVvbXuSyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP1fAs2ISf4Yvv/bWlY4SoRxJv0vtGJ6b0kYzE+PVeU=;
 b=eZ++SFQq1bRbE2ZXrq5bUM6huQ/g8xKAinB05Ef6VfW5YS9hMp/FIsVQbsv7f3NKvRzbYED2JYuMgyQyIV2qhDweQObNvKHQ1JkalvNFz2MnjAxjWbvbS/oaLyVS6LLI6P6CWLp1WCUuuJ/INfVzNLbcTJ86zuiwaRP8Ab4ShiiH8gCVFuFnfhx20mBpdIbtJjxJ3wRb3sqIXRW6tzObT1z+2Dif6WWmzLJYgujxie0iC13SEWJbHMX4TJXVbPY9O4kxN8cwbX3X2wD8+plkd9mTAsTbLSPf5EmhXpu55VGMD+SgR89HzTrkV0RpY26rphBAslKBq5pSVwr0O5O1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Mon, 1 Aug
 2022 19:47:07 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4%7]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:47:07 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/region: Stop initializing interleave granularity
Thread-Topic: [PATCH 4/5] cxl/region: Stop initializing interleave granularity
Thread-Index: AQHYnjF0Io9Rqqf7kky9GMqg6RWa+K2agpGA
Date:   Mon, 1 Aug 2022 19:47:07 +0000
Message-ID: <1b477195b619aeb0601cb0e16ed2d7b05ba463f5.camel@intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
         <165853777484.2430596.3423921169034844397.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165853777484.2430596.3423921169034844397.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39286132-5698-4072-68b2-08da73f69dc9
x-ms-traffictypediagnostic: MN0PR11MB6280:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ES70HxujhDCwHu+KqVh3KP3SZ48ea/E5iFqXfJNM0SUL0+lzLFIoZ8sI+5u7TH9QNkMQCDDaEiOqx3ATVqFdnSqRLmynQofXFWKJ7OrSSGh7w4T8RE5mAknQpLAgAFYowyOh7lyh0grzvNL7AUGmlEG+6Xnh9C4mDlnbg3Wrl1Pr+TssbewwlUh33l+dKYxU9UorOrw2W4qKzQcpQfhlYU30Jfbm5E+Lm84EmNoYpDBy0+SIhkscE3YzZrr3wZ8roto4/8CbbDqvoaxp/IU5v8HYfoXRNkYrizrrX4LA/qIpVY/lRSndVBCn0vmO7ov7trItjBTnal+05U7kHYr18nThQK7si4M5yW9Z1fHKYK24K7XJ3BFovSPbzPIr6wm1GNcI/tQa3P7KPMZ/En3RKPTxbuvwiXvwUXsWZzhXZ+r7AVTmdHD4SgdLPesW+D+DBpbn+/s/orA1+ndI9NQDe0JuaTkeWn9lhnWtboPgHGX808UJwQfFIJ+rNdGY/+j93YWd6udpZH1ohri23BhTM4gM6x8yP/4WFzt+kJNVyh01Pz2Q5EWRZS76msz5ou+eJsYK/d+FTwZ8ZC5NwP0oqAHNMvfL2oodq6QLSp1+j3vxPAulW2GC6iNaiod8XeiRbDsk4xNipxD8Nhl5C8ChrI4Cy6+MFB2KByNqdAjZEdDvpSzfqrXvDKGl40pe9Axv1T6izRHJvBnbPS+kWGwUeb4Da5bZgrh4I93e84IfVHgtiVtufU7f5Ogxuv/5zTVzyItn/6/+VngMxFq4nVwF/vBKLJHxyXH3LkKPPZtjL+S+3wqijZHxf4dxU5jHxbN/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(39860400002)(376002)(366004)(76116006)(38070700005)(5660300002)(122000001)(38100700002)(71200400001)(8936002)(66946007)(66556008)(8676002)(6506007)(82960400001)(66476007)(83380400001)(26005)(91956017)(64756008)(186003)(478600001)(6512007)(6486002)(2616005)(41300700001)(2906002)(66446008)(36756003)(86362001)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajh1Wk5kbm9hUGYvSEkrMDJENkR4YVN0TFZnNUJ6VVVHWHZYemlwVm5qV3RV?=
 =?utf-8?B?WXNpdHZFR1lpWERwc0R3V2IvZE81TFBqREpqV0pNRjFiOW5Pb1hoNHRXSnNF?=
 =?utf-8?B?SVF2d0hRTnVacXp3M0V4U1puLzFIWnEyaUdqUW0zc01oWklGR1FBeVRUZms4?=
 =?utf-8?B?SUFjM01ZY0JZbm5IS0VudUYvMWk2WkxGa1lETktWQkd3MVFPMkhNeVpDWWF3?=
 =?utf-8?B?UnY1TStES2JZelhKTGtidFRiUytiU2o0ZFEzOHJ1WVc2NWlMekFnaldtWVA1?=
 =?utf-8?B?b3F5YWJuQVFNT0NNQUdFY0dpakdBNE5wWGVlSy9KazRUdE8wekpodUtrdWEy?=
 =?utf-8?B?dldKOFBFYUJtMENEdDJLU09STTQzbG5rek5ZNmE2UUNxRURDQjBQaUZLb1Np?=
 =?utf-8?B?eUJQUTFqTTJlaWEwSmljeDRFL2svMUpaLzcrbmN2S1dkcjc3eGt6WG84cnFn?=
 =?utf-8?B?YmlRRWkzazB0YXRtT3puNTl6eTZxUHJQNXcrNmZCQSt1cG1tM3RJbjliaFdP?=
 =?utf-8?B?dy9oMm5KTmdhbDZFWjhPc1dzWnR4T0VaWTZ4aGpPdUY4amgrVlVDNUYrZUFX?=
 =?utf-8?B?V05mb2lmK0RkbThPb2U1ekVwd0ZpSkJya1p2QVJMM2RjWkJMM1EyNHVsSDh3?=
 =?utf-8?B?akt6SkhuL1RTZUk2d2NUVlhtTjJCTTF0U2pXaGdjU1FKbHVrN0k1blR1REEz?=
 =?utf-8?B?ZXRwMDRQeWp4WmJKRWxzMFFycXk0ZVMzRDlaZ3UvcGI1WjVnUjAvS1JJbXBE?=
 =?utf-8?B?MTFLUnNVTnI2VHVjWGRSaGgwZ2IzY2E1MFJJcFBqYjQrYU9YbjBRRDZPakZN?=
 =?utf-8?B?bkU0Rm53YWp2d3o5aThXS09Xb0lWNUpxYm85QWtPQ1BvVHgwOFVOTldsekth?=
 =?utf-8?B?V3NMY091b0U2Ynp2U0R2Mys5U2VWckNZMm5wNUxoQTRSd05zcXZHMUZNRmNT?=
 =?utf-8?B?L1daYnN2Mm50b0laajRIWEFZTUNJRXdReWdGOG5URkxGVFRnNSswaXJDa2x4?=
 =?utf-8?B?S2NpcGhWVjZMd09YSTJkSWR3Nmx2LytmSXJDaEY2TGFEQ0c1dTc1UVQzTlRQ?=
 =?utf-8?B?d0ZzQzhtM3kwSHY5NkUyZ04zWENSclVoRnVlUUQrM21saHZDWlk4dWFLTUZ0?=
 =?utf-8?B?T0s2SG9EYjdpR1NrZ2RwK3lRREZZdzZoMjJDNmlsVnFpVm00OGhweEtVcVVY?=
 =?utf-8?B?a2xHUi9Oa2ZrRFpiUFJCN1ZYSFlZY1ltWlBlaEVLbGVRZG5laEJTOUNxUU9Q?=
 =?utf-8?B?c0VaMW9UVENsWFEwck16THBmV2l4YllFSjJQVkRzOG1WUjdCQ3lsdG96dUdM?=
 =?utf-8?B?cEdjQmFzYlE5Nnp2VXBqTlhuOWlIUGxDbFFmVmxaUjNhNVJSbzBORlZsTVdI?=
 =?utf-8?B?eEpyaHJaS3lybSswa1ovblVEeFlpV0F2TzR2WlZvMncwMU5GMWt5ckI0aFpx?=
 =?utf-8?B?UEFORVFreElXVUlKZHRsUzNvZXlUUFB5Q1lGSk83V0M5UzV0Q2hSK0ZvUm5u?=
 =?utf-8?B?Ym5hR1VyNU1DY2hCeGdMR3BhSHRRM2d4K1ozMk53SWRiQldoZlhIK0RRaUNl?=
 =?utf-8?B?L0NBUFN6ajhwTEpkWTBMZFowU09NSUJCYmN5S0Z3QllGb1JyQnhKL3dpN3Ni?=
 =?utf-8?B?TjBHaHFBUUx3ak5pbHdwMUdUdTNqR0RHcmVGOTR0V2RWYUpLNzFRaXVOSHNR?=
 =?utf-8?B?Qmd2M0VWRCsrbmtRbUwzR2F2enNTQ3MwZmhocy82bE5Zc2FVWWdtN1dyclU3?=
 =?utf-8?B?UzlmUnRPbVVHNGpnTHdZaHdRSGhrOERiOGR4M3dWQ3o3UVU2Qys3Z0RBZHJk?=
 =?utf-8?B?QWRZaW5LM05LeXpjcmRyY2daWkxvNXpLODRYaU5weGl4RTc3VHVlRUR5Q3hI?=
 =?utf-8?B?UDJZR1dUVFh1SXJQSWNZMDlyUFRSZUt0L3diUzloVjNJdmFYMUp4cDl1ejZ4?=
 =?utf-8?B?cVl6S0N5TnU2RGJZaE9IeXI1S3lqRCt3Q01IQzJNVTVtY3BBVWR1UWNINXd5?=
 =?utf-8?B?VElPUU1uaXMvNXVGOE9EaDdDckVzdHpWRFZQcnJXSTlweWcyRUo1VzMzL3RD?=
 =?utf-8?B?Q0pxaVhCVkMyUTY2WndYMzlqdUhFRHFtRXJUSkg0WWZ4ZEhVY1IrSldiMjZm?=
 =?utf-8?B?L1JFeHBqSFJtUUl1a2t3M3dUY3lJOUIxWklmWks2N0ZOOG1OSndiY3g1TXp2?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <024E9319F2A777469FC243628EFA2EB4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39286132-5698-4072-68b2-08da73f69dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 19:47:07.2249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1YMffKp4WGrGCSGo44fxDtVcwYVHEbirZ4CCXRV+03HCJDZsGWElb+eu8Ln6DaI+v4SNc0w8BhTJsqmmngQHWyT4f/I5aVUByAz0UA4I6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6280
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTIyIGF0IDE3OjU2IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
SW4gcHJlcGFyYXRpb24gZm9yIGEgcGF0Y2ggdGhhdCB2YWxpZGF0ZXMgdGhhdCB0aGUgcmVnaW9u
IHdheXMgc2V0dGluZwo+IGlzIGNvbXBhdGlibGUgd2l0aCB0aGUgZ3JhbnVsYXJpdHkgc2V0dGlu
ZywgdGhlIGluaXRpYWwgZ3JhbnVsYXJpdHkKPiBzZXR0aW5nIG5lZWRzIHRvIHN0YXJ0IGF0IHpl
cm8gdG8gaW5kaWNhdGUgInVuc2V0Ii4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMg
PGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvY3hsL2NvcmUvcmVn
aW9uLmMgfMKgwqDCoCAyIC0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCkxv
b2tzIGdvb2QsIAoKUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50
ZWwuY29tPgoKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyBiL2Ry
aXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMKPiBpbmRleCBkZjM1ZDNjNDc1YTAuLjA1YjYyMTJlNjM5
OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jCj4gKysrIGIvZHJpdmVy
cy9jeGwvY29yZS9yZWdpb24uYwo+IEBAIC0xNTI0LDcgKzE1MjQsNiBAQCBzdGF0aWMgc3RydWN0
IGN4bF9yZWdpb24gKmRldm1fY3hsX2FkZF9yZWdpb24oc3RydWN0IGN4bF9yb290X2RlY29kZXIg
KmN4bHJkLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtIGN4bF9kZWNv
ZGVyX3R5cGUgdHlwZSkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9wb3J0ICpw
b3J0ID0gdG9fY3hsX3BvcnQoY3hscmQtPmN4bHNkLmN4bGQuZGV2LnBhcmVudCk7Cj4gLcKgwqDC
oMKgwqDCoMKgc3RydWN0IGN4bF9kZWNvZGVyICpjeGxkID0gJmN4bHJkLT5jeGxzZC5jeGxkOwo+
IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3hsX3JlZ2lvbl9wYXJhbXMgKnA7Cj4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBjeGxfcmVnaW9uICpjeGxyOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
ZGV2aWNlICpkZXY7Cj4gQEAgLTE1MzYsNyArMTUzNSw2IEBAIHN0YXRpYyBzdHJ1Y3QgY3hsX3Jl
Z2lvbiAqZGV2bV9jeGxfYWRkX3JlZ2lvbihzdHJ1Y3QgY3hsX3Jvb3RfZGVjb2RlciAqY3hscmQs
Cj4gwqDCoMKgwqDCoMKgwqDCoHAgPSAmY3hsci0+cGFyYW1zOwo+IMKgwqDCoMKgwqDCoMKgwqBj
eGxyLT5tb2RlID0gbW9kZTsKPiDCoMKgwqDCoMKgwqDCoMKgY3hsci0+dHlwZSA9IHR5cGU7Cj4g
LcKgwqDCoMKgwqDCoMKgcC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0eSA9IGN4bGQtPmludGVybGVh
dmVfZ3JhbnVsYXJpdHk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgZGV2ID0gJmN4bHItPmRldjsK
PiDCoMKgwqDCoMKgwqDCoMKgcmMgPSBkZXZfc2V0X25hbWUoZGV2LCAicmVnaW9uJWQiLCBpZCk7
Cj4gCgo=
