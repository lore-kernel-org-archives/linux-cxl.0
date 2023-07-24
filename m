Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5578EB64DD
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 21:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGXVjd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGXVjc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 17:39:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82010E9
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690234771; x=1721770771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QCNsk4/JKg807ON90FLePbjp7K/H8gVEMLuCNElicuI=;
  b=RE/f+h5LnkD4JxBuV5LQDqHlOIqB9Au+YrrBYBcDgJOaiWunjJNETMWr
   gqce8XauKkOEtGjSSYLg3w03VF+QNDja4HkOplESUwfXNIJJDj+j8320i
   juEDSDdPIN86NQcHfoRiQRYqmpwNcVbCnhFpt+HAmWbfaXDXLN+0TH5gv
   pfhwG31Zgxvi8F6ykvgH+fgdhltiIe9aVWu5CIrhjs+nmmVVFpgXz2/65
   kKuXIKOW9uQA/aAKaN7CyNPWI2rAN8g6k1OgBU0x7edC0H/6S4u1fBM/8
   sNajaSm6cVwJ/jQWOjWFoSl36wlPkuS4uTMjMaDwm4ZZEoG/LNJaqoGcx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347833557"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="347833557"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 14:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719819013"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="719819013"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2023 14:38:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 14:38:59 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 14:38:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 14:38:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 14:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSNiLUt0TFcTRIQJEdU/oc2tdMALJV6nFYMmVz/K4uJTaXDU+pgM/A9gk2yB2jO1YjF/Qio4cIiRL81uRxRjX/OXX6j/oQaNX7p+iDnnhAVxVyaeZM9LgV4zYj4AZrNeAygdbtzDoBXoRzC3eMoq2AhK5EriVsZ+MZmFGJzvmbCSUIanQCIR9T0d8IoXXdYlQdipSy/lO/xMOWgrUenJk9P0y4sRGVUbW0ViQad2KX+wxleTlJ2d7XUK6RFfWBuqwxlCWEXL1aLEFa0UTwFtaWGvXqo6l0w/0ykF3CRcoOHdpmU46XQHFNF+c6aalQEFE1dADbOY4YMI7vy/PZbqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCNsk4/JKg807ON90FLePbjp7K/H8gVEMLuCNElicuI=;
 b=mOYPQV9hY8qOIe9FcmNodx6d1onGBj85BXvj/nTg+L93u6GIJUZf7YrSYmPzI4ZhHnkJLOquD41OmPhmNw6DmfTUXh/gn7xD1gIN476FGfqqmstFF5O27DEcOXGoqWzvd54+aENbLmjoNnAUNriqnVzLOPamxWjp5Z87x3Pj1KvPolzzuGHwGD21cxvh6BJbLIqHW4ctWPNog1H7jvLIN3/c69h40pBLd0gyctBTBJpcqS8nnQeSkdReHvIFewTq2O4rsnsmdjmaXH+fBSwwBj64ftZpdCHKE/WLoKEuCSpvcnFeojMGgSETZ/Mhh+h0dn0ihebcQUl3z7Kp80QM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Mon, 24 Jul
 2023 21:38:57 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::e527:d79c:2bb3:e370]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::e527:d79c:2bb3:e370%2]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 21:38:56 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Schofield, Alison" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH 2/2] cxl/memdev: Introduce sanitize-memdev functionality
Thread-Topic: [PATCH 2/2] cxl/memdev: Introduce sanitize-memdev functionality
Thread-Index: AQHZtckd2NBOPi/HD0aSNcqmRSBQZq+4mc8AgADCioCAADvqgIAP6qiA
Date:   Mon, 24 Jul 2023 21:38:56 +0000
Message-ID: <1e8553e21fca8fe46171f4753274cb2b63b9f62b.camel@intel.com>
References: <20230713195455.19769-1-dave@stgolabs.net>
         <20230713195455.19769-3-dave@stgolabs.net>
         <ZLC/6mWTE+2WxcGd@aschofie-mobl2>
         <72wb3boxuugrb35cz2riexiyfszzc4pc43v7i5ufct7kszjoso@x4gjsuohw4kc>
         <ZLGVXQnn63mImOTY@aschofie-mobl2>
In-Reply-To: <ZLGVXQnn63mImOTY@aschofie-mobl2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|PH7PR11MB8011:EE_
x-ms-office365-filtering-correlation-id: 9357e7b5-08a0-4264-f54a-08db8c8e628a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qex6/BggCg5oHS85KHaChe1pufEO+wdNaKByeUffazoIT556WLdxXRm00eiEQfwVADKJcxy+UK+ih1vTkMrpdguGBcyo2y9pxBYYtCzrETX+cPUnfCD4dguZK+oEv5qDuqYzkZx9350sDll087PgTWmwntjzP4PQ1VphjdjA03xuGe8lh7MhI1dkIDOmz/0mrXlAUxiIKPdA0Is3vvaoPJZBn7BK2H4hY3KaV9nqBGbNJcXc2e69fduwG1GlBkiOn7WdbLJLA1g4PzhLaFel1rxA7w2+rZ0LujBTdlD5ZBobOvJc54UwejVJx2rhJ5YjaMn+eZYL5uA/Bz9B7Ccd+4GByE39udbMIPIZoa+abZxPOdx//LozZ8WY5DeNEs+iUsM2iahMeZbTja2rnY44Di8xnwJf0YZF27lF34FTF3FUOhRf7cB9AThrfIWEjsA9QJOrntI7YH+jg39Xmurop9TUgFwN4n17We/sqzKgs5senajbC15MAUJlMq0x6WxhsztkPQEfFXG1DSfyWF8nfOn0MXekCWaQEGpbXnJRevppQrVJo74GYEPBKzh/s35Ji+R00BcWiJ9vK+5c+qqULUfP0YBAmSZnJ4LltJnDYwUycWvFqAG59peEesJ3fkkl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(82960400001)(86362001)(66946007)(66446008)(66476007)(66556008)(38070700005)(64756008)(41300700001)(4326008)(316002)(76116006)(8936002)(8676002)(5660300002)(54906003)(478600001)(110136005)(36756003)(83380400001)(122000001)(6486002)(6512007)(38100700002)(2906002)(66899021)(186003)(2616005)(26005)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTJQdzdQb1FwMFBtYWtPeWdYTDVlaEpmMVVuQ3JrT214QmRMckN3K2JqNUdi?=
 =?utf-8?B?STBUY2JOYW45MUFkTHdBTmxhMm1BcHpIVHdYOG02eU9rTXVyRC9PbEY1bjIy?=
 =?utf-8?B?Z3pSaC9WTFltQjZ6Z1VjYUgzV0ljYk4xa1lrYW1QZ1NyT0pUcVlLVEkrRW9y?=
 =?utf-8?B?YW54SWJlMlpsRm9OdFlZWXNzK0hWb2lTZ1p3MkpNWStyam9uNjUxU1dmZHhF?=
 =?utf-8?B?V0M3eUVVbXFQS3ZYMGliS0JEaDcyMXVpSXkrdzlyR0JDaTdDdkpOUFFaWU12?=
 =?utf-8?B?TDhqZ2RTWDRmdzFBYXIwckREYmhqZG1CVlFUSXh6eDhVMUZtZ05ESHc1Snc4?=
 =?utf-8?B?SER4MnJPQTZQdGt0a25qREwyWGZlenB5K3RPWHFDUGJWOFo1azBucVBCWWpV?=
 =?utf-8?B?amY1aldSTHc2aU92SmRydnBCNW1adnZ6NGRUSDNzL1RJcml6dFkrSUttRmlR?=
 =?utf-8?B?Z2tNT05XTUdCcFR2eUxJS2QrQXdUVklLaFBtZ2tDWlFpRXVLVGZ2OURuV21s?=
 =?utf-8?B?cG9YcEdKTVhwSVdzMWhrZW8zRytkeWdtRWpheUhCL0srLzJDVTljWDZ2RjJv?=
 =?utf-8?B?U3JXMFdaMmZ1SU5YeWZtdHRHT1RSaFZtR01aOW5uMEpqenRNYUxac0h4THZq?=
 =?utf-8?B?emFxZnhON0tNUEE0SXc1SUp3d3pTVFpDNmxyTDFRb0Z5eGJTbk5pNmdUQjV2?=
 =?utf-8?B?UFF3RWhxb20wYTZWOGNIY0VKdVBhekprQTlaaWZ1enB1SGpuOUpac2trZVlQ?=
 =?utf-8?B?ZnV1YUU0a2haeG9IOWJJWjZOckVBWUxOaHBxZG1uQ0R5cHF6S2NzcjlmZHRG?=
 =?utf-8?B?Z1gwTENpekt4aXhEUFNkcFJoWHVLcnYyZnp3cUNyNEVQc0lKcXpTVzhWTHZj?=
 =?utf-8?B?RkFqN3VaUHVuU09qVXJiWmYrNC9iVFhUK1dlSjBYckZhcmdKWmNMZGNYNXRV?=
 =?utf-8?B?Q2VSZDBzbXcxNlB4ZmVGNEJ4cnFmRUFoVjFiMjJHNmIzVUd3SmdubHIyNDRM?=
 =?utf-8?B?bVpkSU01enpKcVd1VEJOTkd0RWMweTN2MzFWRlhRcitNV1VJRlpBVEJ3dnRs?=
 =?utf-8?B?ODNRVWUzVVlKY0pJeGtxdVEzZ2c4WW5tVFg4d1Fxb0thenpqK0VHSUxoVTNi?=
 =?utf-8?B?ZjU0TUtUaWxVa2pDUlZRMTNIeWFDRm5NdTJ5QUZtZ2FSN1VMYWJBQUVqcURS?=
 =?utf-8?B?OS9Va1ZQdmdiZE5FZkkyeDd5MkcyUitaRG05d3o5c25LNWNicXNvelQxZUFE?=
 =?utf-8?B?M0tEeWxXTVRZb1ZKcUZTZ1g1ZHJUYi9GK3FPRTFUSXBseXltRXAvOGg0RFNB?=
 =?utf-8?B?YXV3UUxnQWNRNzBqY2FCSllEVzZ1Sm4zdnRwcXdaMVZsZEU3OHpXdElWeFJp?=
 =?utf-8?B?ZGczVkdGdTA2QXVrMWp6SUd3dkJ3c2QzV2QrNEl4eHdzdWtTV1pTcjBXVnIr?=
 =?utf-8?B?SEk1YjVVQlJMS1M3UFRJNjZZNnpvSzNSejhhaVpuNGs3ODAzQmtvVzBnYita?=
 =?utf-8?B?OFVML0J2a1Q1c3ZCVU1kd3RTTUxNaEZ5b0FMTHI2cXZDbS9Cak9CdmxNcm83?=
 =?utf-8?B?dnNtSFhPd0p0MlZtMldURW4xdC90NDBvT1FtWmxpMlRwVGw5ckNXMkZ1WlFa?=
 =?utf-8?B?TjNBUTg3NUl5VHJpWEMwWXowVjI0NTRjbUg2dWxCZnBick9YK1FRcDhLbDBl?=
 =?utf-8?B?L3NSQWRvL2w4RFVFc1ZXS0xJc1pNUlVtYTR4QjVQS2ZVT21wMlpSR3duUG9j?=
 =?utf-8?B?UGEvdi9sMEtmRDkxeWlQUEpEczgyNzR5UW9GUllkRXVKTWVJUVhBUXlBL2Rh?=
 =?utf-8?B?OHlmelVuTSthMDBWOVRBNUlGbmNwUFpTWDUrR1VqWURSQTBYZWhPcVQ1U0F6?=
 =?utf-8?B?UHB0L3QvK3VWNmVicVV5dWdHMjFPTEJXOVE0UE14UlF2YitRZzJMVnBzRVM5?=
 =?utf-8?B?TXRlWSt1cjhTYS9DZkh0TTNqMWZCQlBZWllweDJGMGVnSERmMTBpTU5YSysr?=
 =?utf-8?B?SDVURm16NStkaTFJaGlaUld1Ym5UWWE2a0hnSFU2cnFBa1ZlcHMrVVJVVWJP?=
 =?utf-8?B?Qnh0eG1JMHdsbjUrUU9iajJ1Z0lZekxaOFAxb2NQNFh0NjZ6QnJ3L0ZPSDZT?=
 =?utf-8?B?cG91ZVlaTU9LclBWakdENjdhb1RubmNYWWdWUmdya0JFZGtlWnVqV0daUlh4?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A283EBA15C49E849897BCFA73DB4B8CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9357e7b5-08a0-4264-f54a-08db8c8e628a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 21:38:56.9133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbjyGQVxcAmT85j1s0dQUb8PvEB5J/zs+MugXU76/xpMV6vQwjfee7ySS/a8pQQb3vx3T2VN9ZJ/0a3YyDbEiyRA++gT2F48QzGye/dlujs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTE0IGF0IDExOjM1IC0wNzAwLCBBbGlzb24gU2Nob2ZpZWxkIHdyb3Rl
Og0KPiBPbiBGcmksIEp1bCAxNCwgMjAyMyBhdCAwODowMDo0M0FNIC0wNzAwLCBEYXZpZGxvaHIg
QnVlc28gd3JvdGU6DQo+ID4gT24gVGh1LCAxMyBKdWwgMjAyMywgQWxpc29uIFNjaG9maWVsZCB3
cm90ZToNCj4gPiANCj4gPiA+IE9uIFRodSwgSnVsIDEzLCAyMDIzIGF0IDEyOjU0OjUxUE0gLTA3
MDAsIERhdmlkbG9ociBCdWVzbyB3cm90ZToNCj4gDQo+IHNuaXANCj4gDQo+ID4gPiA+ICsNCj4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgLyogbGV0IFNhbml0aXplIGJlIHRoZSBkZWZhdWx0ICovDQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghcGFyYW0uc2VjdXJlX2VyYXNlICYmICFwYXJhbS5z
YW5pdGl6ZSkNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhcmFtLnNh
bml0aXplID0gdHJ1ZTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAocGFy
YW0uc2VjdXJlX2VyYXNlKQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmMgPSBjeGxfbWVtZGV2X3Nhbml0aXplKG1lbWRldiwgImVyYXNlIik7DQo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoGlmIChwYXJhbS5zYW5pdGl6ZSkNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJjID0gY3hsX21lbWRldl9zYW5pdGl6ZShtZW1kZXYsICJzYW5pdGl6ZSIp
Ow0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqBlbHNlDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByYyA9IC1FSU5WQUw7DQo+ID4gPiANCj4gPiA+IFdoYXQncyB0aGUgZGVh
bCB3IHN1cHBvcnRpbmcgc2VjdXJlIGVyYXNlIHdpdGggc2FuaXRpemU/DQo+ID4gPiBTZWVtcyB1
c2VsZXNzLCBidXQgcGVyaGFwcyBpdCdzIGNoZWFwLg0KPiA+IA0KPiA+IEl0IGlzIHdoYXQgaXQg
aXMuIFRoZSBzZWN1cmUgZXJhc2Ugb3B0aW9uIHBhc3NlZCBhcyBhIHByb2dyYW0NCj4gPiBwYXJh
bWV0ZXIgc2VlbWVkIGEgbmF0dXJhbCBmaXQgLSBpbiBhZGRpdGlvbiwgYm90aCBvcGVyYXRpb25z
DQo+ID4gYXJlIGxvZ2ljYWxseSBncm91cGVkIHVuZGVyIHRoZSBTYW5pdGl6ZSBjYXRlZ29yeSBw
ZXIgc3BlY3MuDQo+ID4gDQo+ID4gVmlzaGFsIHdhcyBmaW5lIHdpdGggdGhpcywgZGlkIHlvdSBo
YXZlIGFueXRoaW5nIGluIG1pbmQ/DQo+IA0KPiBJZiB0aGUgdG9vbCBhY2NlcHRzIGJvdGggY21k
bGluZSBvcHRpb25zIGF0IHRoZSBzYW1lIHRpbWUsIGl0J3MNCj4gaW1wbHlpbmcgdGhhdCB0aGVy
ZSBpcyB2YWx1ZSBpbiBkb2luZyB0aGUgc2VjdXJlLWVyYXNlIGZvbGxvd2VkDQo+IGJ5IHRoZSBz
YW5pdGl6ZS4NCj4gDQo+IERvZXMgdGhlIHVzZXIgZ2V0IG1vcmUgdmFsdWUgYnkgZG9pbmcgYm90
aCwgb3IgaXMgc2VjdXJlLWVyYXNlIHVzZWxlc3MNCj4gd2hlbiBmb2xsb3dlZCBpbW1lZGlhdGVs
eSBieSBzYW5pdGl6ZT8NCg0KQmFzZWQgb24gOC4yLjkuOC41LCBzYW5pdGl6ZSBpcyBhIHN1cGVy
c2V0IG9mIHNlY3VyZS1lcmFzZS4gVXNpbmcNCm9wdGlvbnMgdG8gc3BlY2lmeSB3aGV0aGVyIHdl
IHdhbnQgdGhlIGZ1bGwgc2FuaXRpemUgdnMganVzdCBhIHNlY3VyZS0NCmVyYXNlIChkZWxldGUg
Y3J5cHRvIGtleXMpIGlzIGZpbmUsIGJ1dCB3ZSBzaG91bGQgcHJvYmFibHkgZXhwbGljaXRseQ0K
b25seSBhbGxvdyBvbmUgb3IgdGhlIG90aGVyLg0KDQpEYXZpZGxvaHIsDQoNCklmIHdlJ3JlIG1h
a2luZyBzYW5pdGl6ZSB0aGUgZGVmYXVsdCwgbWF5YmUganVzdCByZW1vdmUgdGhhdCBvcHRpb24/
DQpBbmQgZm9yIHNlY3VyZS1lcmFzZSwgbWVudGlvbiBpbiB0aGUgbWFuIHBhZ2UgdGhhdCBpbnN0
ZWFkIG9mIHRoZSBmdWxsDQpzYW5pdGl6ZSwgb25seSB0aGUgY3J5cHRvIGtleXMgd2lsbCBiZSBk
ZWxldGVkLg0KDQpUaGF0IHJlbW92ZXMgYW55IGNvbmZ1c2lvbiBhcyB0byB3aGV0aGVyIGl0IG1h
a2VzIHNlbnNlIHRvIHN1cHBsdSBib3RoDQptb2Rlcy4NCg0K
