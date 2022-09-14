Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB28EC6FA82
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Sep 2022 23:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiINXET (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Sep 2022 19:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiINXEQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Sep 2022 19:04:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824BA86C3E
        for <linux-cxl@vger.kernel.org>; Wed, 14 Sep 2022 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663196655; x=1694732655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kQvWrbzP4JVUWZnUEhAqeMGD60r6x3e0iQSs3v1bvro=;
  b=OXc8JBylBhw2nS1MQGZLJSis9u+vbxIEaQVcBUKqsd6n0AoFLR52/3Lq
   4aBbmTbp3NZh015/8732G9aRwJi15arIerlfkwdStMbFD92+PrDKxtFtQ
   h6Vk3rNTimC3HBdTQJ4VYpHVcTIbpJOYSvVxS+FQzyQnGRUwvrAXJzcFv
   F872Ta/9ZOGgEqYPf4OTL1lR8W9dd36ynpCy1f7Ay/IcifVBJ4dhNp/a3
   8Rah84gxclJ1ibsv1KQtEcG61L0th4erpw2mFVTipAUzfkRtlMEffOtVD
   YinL7yzjQeX+95B+FT/vjqNnu2a05LI8Egb0A7wMK2nf+j+3uySSlbYsh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298558210"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="298558210"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 16:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="568191716"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 14 Sep 2022 16:04:14 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 16:04:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 16:04:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 16:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHn/Ym+c5xzMCQjmqs27/PwKoO63YYpxCkoj2zION9ECFBFO1t2I55wXn8L+tXN0b31eOLMJxNqhvsnPFAQN+j5ccxL86nQEJSyQAxdfuJg23ByhLvbj6Ss3laD+Nt2Rry1Fazccm+QSxftz49qpp1suDqVmf0/DNhsW2Gcdi41gQ5237Afte//94gKGnMrxYQ10gDNz3WNJ8zsKj+QiikFejnOjkHroEhJ4N9TSyqPK5IH5Rbkx2TYVJMJlhq2F54Ser8G9z2VaPqzgV3AAMzJJHwnA2MugTAcngnDVtcFG6VI0dgSsEtpcBGPnLW0ALbLBgfR1ji6ieuUxBtvWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQvWrbzP4JVUWZnUEhAqeMGD60r6x3e0iQSs3v1bvro=;
 b=i/ewR5IDE6X25UEP8r948stAQm0N4fJbr3KJt9xFv94Q1ut9p1GMzkx3PFpVC0nT9/HmW5I11TtEa2TUYUrjipt2vjF/IIU6b00YXKkhKBijqlfkMIfeN7xWknykU3koHlZSM3z7E2nYVtSeeE00Smwri4FaGzUoO2qiD1KX9QgZvxhYemG7GFCz6uQgCAmhMZf2eQg6jY4F90ZFOd3ukAeTQx16hfLDQPgOzFBAhrTBrfanVvgMPgpbfHB1VUnCQPXKe7I+wQxlQ9oLUxZOcP2NEH5qN4i15jC5spMHl2Qs4y4OyexeHPcTenld3ZExKiRUhKAh+ed+fjgyHWhsQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by PH7PR11MB6053.namprd11.prod.outlook.com (2603:10b6:510:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 23:04:11 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::25be:c4fc:f59b:8dd9]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::25be:c4fc:f59b:8dd9%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 23:04:11 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 0/7] ndctl: cxl: add monitor support for trace events
Thread-Topic: [PATCH 0/7] ndctl: cxl: add monitor support for trace events
Thread-Index: AQHYyHtC4PR0zb3Ogk+PAkQ46kAlrK3ffz6AgAAMZAA=
Date:   Wed, 14 Sep 2022 23:04:11 +0000
Message-ID: <c651fa1ff2366679d6d05a044178c7d6557568e4.camel@intel.com>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
         <d4ccbf2d-e068-d686-ca6d-2d6ecc25d17a@intel.com>
In-Reply-To: <d4ccbf2d-e068-d686-ca6d-2d6ecc25d17a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|PH7PR11MB6053:EE_
x-ms-office365-filtering-correlation-id: 6e69fb44-c23e-480f-fdf0-08da96a56fe3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQxDpIIHQO9E00qbqkQKxs5cpjdsPUb6MDFdoddwKRMS+tijO2AiSWvamkwHwPyHOjhh5y7VqogEGUeEgTrobx6+imFNUIpzlFc6jyC0GEA4fs5MFLc0M8fSgxW9st0f+vtRMLIYQbuhCjVdxpZwvW9bDXTgxXJc06S1whAm8YEOvfBefFbtmiKyx9M1NSTRWSX0OOcJyjfwWGYsdzEoubolZNQSQZwyQVCz3EcHzi8RALWkn4kQ6B+7ujC6a1tPGPKs4trrZEGqkG0DVN2KXPNcWAJvHQhCx5X2C2SUnCDFifaeXPhPc0NcP7s0xMFD5gQ/HAVv19DCD4KCTTFMTyZwjc0gFPbMelSzC6vnByFFOYe9GENJkyoA5AdQZz2GnWQMZ1Is1bTcP/c3BEPKSSSw7jt3ERZDreGyzBx1LCflTW2PUfOw6zeM3MGfb1c0mx9ImQ4qMpjDLpyG8OTD26cz85iu5x4FySch2J8wk34Vmex+7W0pnCtco8CJMIhGCUAHOdwcLcJ+ttEHBTkeliEyVBozGfqQ0MnebNqC8kevnQGg792aGzAnjnpx4Nh+EmtjqLbKQNmMBbkNE2iv9v3uMz5y9nCfbEidd/i4Eui3a5K4U1DjG3+3aIfuOAUPEKiyAebSKt4ZfmPyabeWiASCs0P9yW4dWxw8omDIevjaBXPPpEdC0ImTDXCapA6wIVV96DCJcUbFtStMsWOk6xI1rqd/a1ryIVh2IR8bR7Xo/dARzId9z5ymdPBf20YyVL4qJH9F/NQlq/TYE5JA7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(2906002)(66476007)(71200400001)(478600001)(41300700001)(38070700005)(110136005)(82960400001)(36756003)(5660300002)(8936002)(6486002)(26005)(64756008)(66556008)(122000001)(6512007)(316002)(66446008)(8676002)(38100700002)(76116006)(53546011)(4326008)(66946007)(91956017)(6506007)(86362001)(54906003)(107886003)(2616005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnFmd2hRVUN0Sm4xK3A4REc5NG9OWGJ5WnZ6c0NTaHpiT1ZEQ0lwR016YXMz?=
 =?utf-8?B?VjZjWU5aUXRTU2hTSjliZ2MxVDhUNWRZbFBHaE9BYStCckQxUjlsK29SU2RQ?=
 =?utf-8?B?Rkxja0lUbnBxekdCVmNFNW9zaVRUT1g0b1JrTG54SjlmWWJOWkhFcjMwQ05K?=
 =?utf-8?B?M09qZEo4WUlIbmVOaThjcWc1MjhkV1lWNy9jRlQyMWtidEF3bEpzVUplRkVy?=
 =?utf-8?B?R1c1Q3h6WGVVRk1jNXdIOGpiU0tKQyt1WjRoYTdqbFdHaTZLdTdlRzB0Zkt1?=
 =?utf-8?B?SDFzalZwVmVpaEV1U0tkWUVibHk0STFzZ3IycDV3REFHckJ6QU1wYW1hSVpC?=
 =?utf-8?B?OHpUR3dackMvY0VsdTNBVDloODRWWUtvS0htc2NSclpFcDZ4OXlqZDBEQm9v?=
 =?utf-8?B?Q0l0RGtnOWJyZWhnWjdQMlpRVmtORXZHUkpUMDlRYjVGYWZCamZad2I0dXVD?=
 =?utf-8?B?Q3c1SnpMaDR4dExFSWlyN2RSTHBpV3FZM2djaUg0V2JRbnBnaDBrbkliN21N?=
 =?utf-8?B?UUFJWDlnR21kMTkvcStqQmhkcW93RkRsY3EwQjMyUVZYM2ZIcVJXSWJiTlRn?=
 =?utf-8?B?RHJuUk56UnIzdVhySEFMV1QzL1JESUNzS2RFV1JPRVBTNnVKQklITnZZTVVH?=
 =?utf-8?B?WUFCQm9YbzZxdHNEWXpVYWc3bmtqN1FEaGtGWWxXVTlubVZsRjAvY082dEtp?=
 =?utf-8?B?Zll4cEg2UzRoWVZINEUwVGNrbmlzbFdYT3liWjBweXI5SUNHcFJaNGlVUkVE?=
 =?utf-8?B?cGlxRlZGdDh0cVByM2dOVFF5SklBL0lOTHZFMjI2ZVlSZWxIc2hBZm1XMXBh?=
 =?utf-8?B?YWJqR1B5dnQzZVEvRU1GT0pWNkNWVnNNcS9CaksyWURFbzBXWmJmUmpBZnA4?=
 =?utf-8?B?Y0dwdGFwSVpCNitiNU44SEZiK1Q1K3dwVTlVTnRtbGw1NXpMS2ZmMjRFSjE3?=
 =?utf-8?B?SUFkODFyR01Pa1JpTjVNSjZCR0lrZHI0WWE0RGpUaXhOTU9NSXAwSEswZmFM?=
 =?utf-8?B?cjVjUk56eEtqRC8wemFEYkJkVmR5ZDNmVmt3RituNXFVSEtmNFBBOVhJdWxM?=
 =?utf-8?B?anJhQkYwcDF3UGJhSW9Xa0I2eGNYWENWTmdqK3ZBY1d5bDB4NktpNU9Wb1hE?=
 =?utf-8?B?OEI2SUR1M1h3eE1zczg3clJhclhUQzkzWXlTRzQvWkJWYmg0a2pFTzQwalA5?=
 =?utf-8?B?Z0N6aS9kYUVScmF5bVczMWlQMmkxZVVIcjlVeHhrdUl0UHl1OStreVlBU0tF?=
 =?utf-8?B?dWRQYUNiQXRJS1Q2VkRZNlBHUEV4a1pYSWF1UEpMZGFXZHB0S2xPOHJ3ajV1?=
 =?utf-8?B?WUkvZVJaNnF6SFVxSW1TY1pDMUZQUDB0TXdENkx3UmhUK201ZDlnY2x4aXlY?=
 =?utf-8?B?T1R0YTVEN3dIbWJYbldwNVg3ck9zeFhMdEhmWWVBbFFuTk9oajV3SWVpOHBl?=
 =?utf-8?B?azNxaTBEQUNvVGNOUjZDay9pVEt0M01YYmtTL0huUUZBVXM5SmtCMDB0blk2?=
 =?utf-8?B?Uy9mc2l0NXZWK1htYW51L1BwZHZ0MVpEMVJMcVZGYlpIZEJOTnlDZTd0Sytu?=
 =?utf-8?B?RW9GSDBSOVJTRnNKeVZVZjVTdHJGLy8vSSs5aVhCMXIyaGN3My9ndEJsT2lI?=
 =?utf-8?B?c0s0aWExOEVyeEQ0WXNyczhrbmxZMmFCbjNiS08wKzNwNDdZQ3FlZDZ5Qm1N?=
 =?utf-8?B?YXBYQUtFQS9DS0ZSd2laK3U5R3o2SEVraHdLRGJRdHdjdml5cmp1cTUwSUNB?=
 =?utf-8?B?SVZFQ0lGU0FYRHc4RThHUmttL1p5MDA4WXR3cFFFUkRPWkliOGZPUkgzNFV5?=
 =?utf-8?B?RUwrbWhRdnk4cTZpdmZucVNUZXl6SzVzZlZDZk5BeEMzUnZuVHVjelZZbVVE?=
 =?utf-8?B?dXRrUEpOcHRjdWlyemdVRXBGa2crL2cxcmtBbzM5ZFNGTk5SSm1YQWl4ZTBZ?=
 =?utf-8?B?UGlsaVduS3BSWWhBWkxucGZSemR1TG9vTmdLcTdURFF1OGlhMVgyQW1QTlJj?=
 =?utf-8?B?TWhncklWYktaekdaWjlieFBMZDZ1dXNHY0tOQktEZ1FHa1lzOHBNNTBxeXlL?=
 =?utf-8?B?dVFEcHExOHBocGpoMWxySnd3TllVZHVWR1JqZjNzSjlac3BDaFFlcjJ3RFlB?=
 =?utf-8?B?Y1VkcHh2aXBPNURrSEIySTgzZVBJQ1A2QnYxcTlEUXRsTm9vQ3Y1dlhVTk1O?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A115E1C1BA924E45A3D7F40E98534FA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e69fb44-c23e-480f-fdf0-08da96a56fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 23:04:11.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aMBKcU7kyo+4pxCrEqJ2MQg3YTpT0MpDoIJluPhWOgvO4AgGgBt1hAEF1XJuuB70vYk+d32QdpSNEAO+sdPlXw6Ltc++MivCkPhDUFyxK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6053
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gV2VkLCAyMDIyLTA5LTE0IGF0IDE1OjE5IC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOg0KPiAN
Cj4gT24gOS8xNC8yMDIyIDE6NDcgUE0sIERhdmUgSmlhbmcgd3JvdGU6DQo+ID4gVGhpcyBwYXRj
aCBzZXJpZXMgZm9yIG5kY3RsIGltcGxlbWVudHMgdGhlIG1vbml0b3IgY29tbWFuZCBmb3IgdGhl
IGN4bCB0b29sLg0KPiA+IFRoZSBpbml0aWFsIGltcGxlbWVudGF0aW9uIHdpbGwgY29sbGVjdCBD
WEwgdHJhY2UgZXZlbnRzIGVtaXR0ZWQgYnkgdGhlDQo+ID4ga2VybmVsLiBsaWJ0cmFjZWV2ZW50
IGFuZCBsaWJ0cmFjZWZzIHdpbGwgYmUgdXNlZCB0byBwYXJzZSB0aGUgdHJhY2UNCj4gPiBldmVu
dCBidWZmZXIuIFRoZSBtb25pdG9yIHdpbGwgcGVuZCBvbiBhbiBlcG9sbCBmZCBhbmQgd2FpdCBm
b3IgbmV3IGV2ZW50DQo+ID4gZW50cmllcyB0byBiZSBwb3N0ZWQuIFRoZSBvdXRwdXQgd2lsbCBi
ZSBpbiBqc29uIGZvcm1hdC4gQnkgZGVmYXVsdCB0aGUgZXZlbnRzDQo+ID4gYXJlIGVtaXR0ZWQg
dG8gc3RkaW8sIGJ1dCBjYW4gYWxzbyBiZSBsb2dnZWQgdG8gYSBmaWxlLiBFYWNoIGV2ZW50IGlz
IGNvbnZlcnRlZA0KPiA+IHRvIGEgSlNPTiBvYmplY3QgYW5kIGxvZ2dlZCBhcyBzdWNoLiBBbGwg
dGhlIGZpZWxkcyBleHBvcnRlZCBhcmUgcmVhZCBieSB0aGUNCj4gPiBtb25pdG9yIGNvZGUgYW5k
IGFkZGVkIHRvIHRoZSBKU09OIG9iamVjdC4NCj4gPiANCj4gPiAtLS0NCj4gPiANCj4gPiBEYXZl
IEppYW5nICg3KToNCj4gPiDCoMKgwqDCoMKgwqAgbmRjdGw6IGN4bDogYWRkIGhlbHBlciBmdW5j
dGlvbiB0byBwYXJzZSB0cmFjZSBldmVudCB0byBqc29uIG9iamVjdA0KPiA+IMKgwqDCoMKgwqDC
oCBuZGN0bDogY3hsOiBhZGQgaGVscGVyIHRvIHBhcnNlIHRocm91Z2ggYWxsIGN1cnJlbnQgZXZl
bnRzDQo+ID4gwqDCoMKgwqDCoMKgIG5kY3RsOiBjeGw6IGFkZCBjb21tb24gZnVuY3Rpb24gdG8g
ZW5hYmxlIGV2ZW50IHRyYWNlDQo+ID4gwqDCoMKgwqDCoMKgIG5kY3RsOiBjeGw6IGFkZCBjb21t
b24gZnVuY3Rpb24gdG8gZGlzYWJsZSBldmVudCB0cmFjZQ0KPiA+IMKgwqDCoMKgwqDCoCBuZGN0
bDogY3hsOiBhZGQgbW9uaXRvciBmdW5jdGlvbiBmb3IgZXZlbnQgdHJhY2UgZXZlbnRzDQo+ID4g
wqDCoMKgwqDCoMKgIG5kY3RsOiBjeGw6IGFkZCBsb2dnaW5nIGZ1bmN0aW9ucyBmb3IgbW9uaXRv
cg0KPiA+IMKgwqDCoMKgwqDCoCBuZGN0bDogY3hsOiBhZGQgbW9uaXRvciBjb21tYW5kIHRvIGN4
bA0KPiANCj4gTWlzc2luZyBtYW4gcGFnZSBhbmQgc3lzdGVtZCBzZXJ2aWNlLiBXaWxsIGFkZCBp
biB2Mi4gQWxzbyB3aWxsIGFkZCANCj4gZGVmYXVsdCBsb2cgZmlsZSBwYXRoIHdoZW4gcnVubmlu
ZyBpbiBkYWVtb24gbW9kZS4NCg0KSGF2ZW4ndCBzdGFydGVkIGxvb2tpbmcgYXQgdGhlIHJlc3Qs
IGJ1dCBJJ2xsIHF1aWNrbHkgYWRkIHRoYXQgbm8gbmVlZA0KdG8gaW5jbHVkZSB0aGUgJ25kY3Rs
OicgcHJlZml4IGZvciB0aGVzZS4gJ2N4bDonIChvciAnbGliY3hsOicgZm9yDQpsaWJyYXJ5IHBh
dGNoZXMpIHNob3VsZCBiZSBlbm91Z2guDQoNCj4gPiANCj4gPiDCoCBjeGwvYnVpbHRpbi5owqDC
oMKgwqAgfMKgwqAgMSArDQo+ID4gwqAgY3hsL2N4bC5jwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAx
ICsNCj4gPiDCoCBjeGwvZXZlbnRfdHJhY2UuYyB8IDIzNiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gwqAgY3hsL2V2ZW50X3RyYWNlLmggfMKgIDIz
ICsrKysrDQo+ID4gwqAgY3hsL21lc29uLmJ1aWxkwqDCoCB8wqDCoCA0ICsNCj4gPiDCoCBjeGwv
bW9uaXRvci5jwqDCoMKgwqAgfCAyMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gwqAgbWVzb24uYnVpbGTCoMKgwqDCoMKgwqAgfMKgwqAgMyArDQo+
ID4gwqAgNyBmaWxlcyBjaGFuZ2VkLCA1MDMgaW5zZXJ0aW9ucygrKQ0KPiA+IMKgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBjeGwvZXZlbnRfdHJhY2UuYw0KPiA+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBj
eGwvZXZlbnRfdHJhY2UuaA0KPiA+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBjeGwvbW9uaXRvci5j
DQo+ID4gDQo+ID4gLS0NCj4gPiANCg0K
