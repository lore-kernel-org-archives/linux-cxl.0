Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E788FFA373D
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Nov 2022 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKAHoo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Nov 2022 03:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiKAHom (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Nov 2022 03:44:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5417A88
        for <linux-cxl@vger.kernel.org>; Tue,  1 Nov 2022 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667288680; x=1698824680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kGfHZO2MQnKPx7OorwZsEUgrZa08tjYPEvYBR5ychKs=;
  b=edx8wjqtPuXDA/d1d6aHONLxtQrkly5Rd8zBCnd+GT1tjqXc0kmp4QOx
   vLAqCYXr5LwNOZLfSBZF7XAa4v8q+oWUBqsVUnCWNmru09YrWROWtz9d2
   6KzatE78xca1uXpUlbMOeHPaM73bLawYtzi5WHIvs1YSWhjxakNzQ8mkf
   3J9HhZz9L3cxZTCOXWhmd9a7TyZEisRKK2f7dhOHQTo7IGHMoIHiIKruP
   oW00N6IALgPS7G5Wox02zRyymM8IUYZDTT7vrtANuguux12/jDKM7zZIv
   dthEgeGNylIQAm0Mw3OiWLu/KKUNuKD4h1EMt0A7PkuOnvWdPgVNtLzcb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="292389618"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="292389618"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 00:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="963053352"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="963053352"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 01 Nov 2022 00:44:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 00:44:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 00:44:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 00:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU4hOE0xZ7QlVdjBAJP+c+4WW4pBAdkltgF86oeJAUvolD5uukxuZrXEZrcUCgIvfN/A9n0l6mVBGdI9jDZi+54MbeUYh9tqv4VnRJSQPelAiLIDtBJK0SJNW2wJ1UysAznWqo+aMGOlzOB2N6jIDdlpQ4EVSW1DpiliE+tP56xRUTYiqVty3tx7cvIpzK5otJz93Cd0nEU4OWJM0ozuD/cvXrj8yS+oHxejelai5Ispjgy72f+nc8WW/eJPmRJpkXlUm4m2G7GWoWDnotxcLeY41dUzpZRloeNEGjKioiSoZz0OCUX+U/HCrGXuc6iaJolItVmH9fQcsGSSlZzRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGfHZO2MQnKPx7OorwZsEUgrZa08tjYPEvYBR5ychKs=;
 b=hECU7icFNv/EQCkmPjCU8CsA1atMRqpgntbUbawyTCQQoC1WYvV3XbysUc6fKvW1OLAD2oe7SZbOy42u11CFQ1mkb29gP7zRYZ/F9ncor6UNX+FISAkAoKuWx0yIvZrZHH53jtwkytKFaAzDr+bdlqulwzH3R5rZUu6T9yBdEdaVLRYCM7Dw3IFIgP1S1dcxGCXtRL2IcBQo73t2F1DXK9SA/JCMm81UTw4D64IEMD+d2JOd/RwojXge6XwnG4Izg+8wvI0b/jJy00ouNrbD+69JpXcU7e6FXhbT6OAIczxX1s0eLYMRFehmooZpQKEfRVBHfxWPNOzmgjbDF7P5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 1 Nov
 2022 07:44:21 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 07:44:21 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "d.bueso@samsung.com" <d.bueso@samsung.com>
Subject: Re: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
Thread-Topic: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
Thread-Index: AQHY6ykWpXsE/hQsVUualGBz0TCrfq4kgNAAgAU0XgA=
Date:   Tue, 1 Nov 2022 07:44:21 +0000
Message-ID: <d90e2d92cd48749b17d162ba330bf49086372cfd.camel@intel.com>
References: <CGME20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b@uscas1p1.samsung.com>
         <20221028235705.32890-1-fan.ni@samsung.com>
         <635c70a8460b3_6be129497@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <635c70a8460b3_6be129497@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DM4PR11MB7328:EE_
x-ms-office365-filtering-correlation-id: 8a08d3f0-ecdb-40ac-8d92-08dabbdce395
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPxLuBFEcjFf08NjKYWZoEuD4Lx4/NgGMiB6KWzQxtZWE8BiLBbpEC3+B3nEmN9yxrY7nmLk12GE/XjbGz+4FReFE97gmGSnXEQN4gGCfidCcC+bu8XhhTW5Y80d1T/1vFLNPP7d4Viw/XqYSWFSXmS0iLAoZ2KzcamfHyU7dxYmCCIImewwb18dy3OsAhMZQrAct4BHiW2gPHPyLbjpNhAduJxYiHvYncZpfRLCL+ei3t1uPxjwGxhp9N6Dl/L3nvAr10nLIORARSAe2xQZUwBReYUTmYZ+DG/slFhMzY+xkhIclxvEwXvIMjgCa0fp4rhBdFltl1H/S/KydLX6DR0K78oqzgfRNyoeojUcalu0nDmFy1A56j5QWboImrdVmDC0M3QtY0piDLVqczxJ/J2XYDYhWjYNW1sN2oezktvPyrXm0haYQjh6WWC5nu11hChBCKAxhAd+omL+sX8/i3UAuc8BXD74CqqLqfM4DvzEYDWgUfUxh/CcEv/s/+IRikUK/MrWM2wGvP91BY4FkdiTbG2UhGOU9/HDjPJyXLN1oUm5O3IbnHRoJNhRQjOe0UzZkIduBwdlQXA058UVu/Vl/yTLFXk4krm62OF1cjC63nihg94CRKQ+6JOw6BnUZvTg3ICnlka8VeMJ7fUwTxE6YLE3OldiI4rVUzoQkDclKjV34DHw2+8qF9Ph8k+xtlCu9t6jm+hwf7zvC1djv6E3vfbSrtLltIdoZSYDrunaLomYWRGTvFFtREsL8jj2VNTWMQaupDMsnJSTeT+OLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199015)(2906002)(4326008)(66556008)(66476007)(2616005)(110136005)(6512007)(54906003)(38100700002)(91956017)(4001150100001)(26005)(186003)(83380400001)(86362001)(41300700001)(316002)(8936002)(76116006)(66946007)(5660300002)(8676002)(36756003)(6506007)(82960400001)(64756008)(71200400001)(478600001)(6486002)(66446008)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkZmUld0allTdGU4cFBwOXF1cnNLZS9RTkt4bmR6NCtoOEFBSGFPT2ZmMlBl?=
 =?utf-8?B?dUpxbjd2N29qcnBrcG1uQXhCSjAxMGZDSEd2MXRzRDNnQzk0SFZVSnhaMFVZ?=
 =?utf-8?B?a3ZIbDNSQmVBWXRrbU1zM1NLUU9qdTdhSmU2T09YVTlwK092ZU1VdHlPUXBE?=
 =?utf-8?B?MDVTMHp2WVlHTjVsVG82VCtTM25LWE5hK3NlbktPSk50WkkvcVQrWUNNdjNO?=
 =?utf-8?B?NXRUM0xyMm1iRW5PNGVBS2tsc3hSZ0laZEpMWEdBU040QUg2dUtpbFdwK1lJ?=
 =?utf-8?B?a0VoUXJuSXU0THZFM0NyeFlsdERYNUxUZFNoM1kwcHVGQnZaWGpMa004bWJY?=
 =?utf-8?B?T3E1eExPZVlaTThQS09YRzBsN0NVeEt6czNTQWhvT3VyaTBRbEY4cXY3cW9Q?=
 =?utf-8?B?enFrOUZyL01ZaUNOazBBMHA1eWFxMGNkdnpJWHQ3WmxDLy9uVmVYV0NMeGI0?=
 =?utf-8?B?VGlOU0g2NWZXTTZtZmNwUkQzVzExeVd0d1RBZ1dDcWY0ckJxRDk5NTRoZXE1?=
 =?utf-8?B?S0NqbFJ4Zis1L0QzMVh0dmtVak9ReXNneTByYVZ1c0RYNm84VkZyYjlOVitB?=
 =?utf-8?B?Q0lXRnowZ25FcmsxMWVQQkMyUG1zSmlhMHlZekJIY20walAxZWR5Y1p6Z1Iw?=
 =?utf-8?B?NnNyYXNUN2hLN1B3OFhpOFdvalp0Q0hQb2Y2L0xYQjcxZkE3NkRaU2cxaEYz?=
 =?utf-8?B?cEhBMDN2WEo1SlMvME5vWEIxMzZlSHVtZ285NWdVcEtzUXR2RmZpZVhRbE91?=
 =?utf-8?B?NlY0MzVuT1NnZzMwdVovalZiWWFkcW9HODlZcnJYVkRpeGZJSTllR0NTYWhW?=
 =?utf-8?B?ZWRyUHFTYTZvWkJ2MmNJb1JnU0E0WmhTbzVwYTV5MTJoZWVaYU1kaUtLU3pm?=
 =?utf-8?B?UFVEY3daeVBEZEhnSFUvbit6dFkwK2R5dGIxN09FcHp3bVBNT0lTRHN0U3RP?=
 =?utf-8?B?cE9nKzgxVUsvY0c4RTU3VkFSOXhGN1NQUXBuVElXNkUxd3lJbFVJbk1YTTlQ?=
 =?utf-8?B?clZ2RWJwM0NTQnB2SXY1NFFmcDE2OGRSSElNWm4wMVFmOUY3R1d3SzNkSmln?=
 =?utf-8?B?MjFrUmxCVzdQeFVIOFhaMkhqU29xT3BVcFdMVnRYc2djbFB1bEcvOFNXVGx6?=
 =?utf-8?B?cU5GVW5SeFdLZjA3RGRNdDBoQXp5WWt3MXIwUFdlcjdPenNDYll0NWxIUVRa?=
 =?utf-8?B?VjcwcWVxZ3haYXhZSDhMUHJYUHo2em95bE1qVEJnN2E2SnNYWjdyNWptdmpt?=
 =?utf-8?B?am1DRjZhVEMxRVdlMElVVHJVb2Zsc1p2SVFPK2F0MTBOczhQV3p5MFpvTjF0?=
 =?utf-8?B?S20rTGlPd2R2L1BiWEE0RmlaQ1JmQ2RqcDJlZktLbkYzQnpIL1laTWgrUE8w?=
 =?utf-8?B?VDQramFVN3ZKQXdyMGdCZkgrUFFOSVg5ZUtiY1AzQm9vWVNnNmRuaXlyb2pj?=
 =?utf-8?B?ZElqU2dLaG91Q1RhT01PSUFuV01ZTmY1QjZXaXV6bGFiTmRhT0lyaks4bG82?=
 =?utf-8?B?YnQzdUdtMmtMa2xWdEFtbmwwVGFGQmRVdlZaRGRGbFgzY01Kc1ExN1U4ODkr?=
 =?utf-8?B?ZkNXSHdGalB0MGdlTUVvRnYvNzJJWHJPblJwS0huOFZHbHhwcmV2MFAxQ2JU?=
 =?utf-8?B?R05icFd6TGFuZzVsVjBxTHNqVm1iZ2VaU3VxZld5VDJOMVErRmNmRlB1SHZx?=
 =?utf-8?B?YVg4Y1l2OWxxM1NtK1NNZElLS2hPK1JaSW5kMHFDN3RQU29NTnA1ZklOVmVy?=
 =?utf-8?B?SGFna1NyV04randpQ1p1NWo0YlJraWNVcE05SnY2ZmFma2xUUjlqWXBITVhC?=
 =?utf-8?B?MHAwQlZMWWtzZE5nbHZaTmtCQVpNYTF0UGlxeXJvR25XejNzK2hhWXZKMEIx?=
 =?utf-8?B?dUtNL3N5MWFSeVdtV3ZGR0xsTUJJd2hTdzFlWGwzL0RNZDk0QXJyK2h1ODFQ?=
 =?utf-8?B?SmJZMUgrRnphQjlMZ1Y3VlllQktxYWIwdmN4VmVCM0dXNjJWSnM4eGk5SVpR?=
 =?utf-8?B?MHpiUzVSRHpUVG9Xalh4NUlZcStkNFpSVVNZY0JEL2EvRlk0b09WRnRaanFJ?=
 =?utf-8?B?VE0vRGpaZ0pIZ1ZveENPNEFSays4Ym85R1FrOGFjNytwVkVlQXdTajJpR0pI?=
 =?utf-8?B?YUFRdmpxOStJRUgrdElUUTJoVXF5SDVWZjZCRi82YjBpOVVkQTZLNnRUYit0?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <107555D8EEFF584EAF6686A5A45A8A97@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a08d3f0-ecdb-40ac-8d92-08dabbdce395
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 07:44:21.1149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URwYfoq5TjJ3k13UYMHneWb2BzjYOLDpUoVlMAfnpaAm6rCkbZuQRrUGoKnsjjsvoQCfv8IoYdz9Svw/IBVWNxpaeHJ1GFW6iXQObDNVR3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTI4IGF0IDE3OjE1IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEZhbiBOaSB3cm90ZToNCg0KPj4gU3ViamVjdDoJUkU6IFtuZGN0bCBQQVRDSF0gQWRkaW5nIGN4
bF9tZW1kZXZfZ2V0X2Zpcm13YXJlX3ZlcnNpb24NCg0KR2VuZXJhbCBub3RlIC0gcGxlYXNlIG1h
a2Ugc3VyZSB0byBkZW5vdGUgYSByZXZpc2lvbiBjb3JyZWN0bHkgd2l0aA0Kc29tZXRoaW5nIGxp
a2UgW1BBVENIIHYyXSBpbiB0aGUgc3ViamVjdCBsaW5lLg0KDQo+ID4gVGhlIGZ1bmN0aW9uIGZv
ciByZXRyaWV2aW5nIGZpcm13YXJlIHZlcnNpb24gaXMgbmFtZWQNCj4gPiBgY3hsX21lbWRldl9n
ZXRfZmlybXdhcmVfdmVyaXNvbmAsIHVwZGF0ZWQgdG8NCj4gPiBgY3hsX21lbWRldl9nZXRfZmly
bXdhcmVfdmVyc2lvbicuDQo+ID4ga2VlcGluZyBgY3hsX21lbWRldl9nZXRfZmlybXdhcmVfdmVy
aXNvbmAgZm9yIGxpYnJhcnkgY29tcGF0aWJpbGl0eS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBGYW4gTmkgPGZhbi5uaUBzYW1zdW5nLmNvbT4NCj4gPiAtLS0NCj4gPiDCoERvY3VtZW50YXRp
b24vY3hsL2xpYi9saWJjeGwudHh0IHwgMSArDQo+ID4gwqBjeGwvbGliL2xpYmN4bC5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA1ICsrKysrDQo+ID4gwqBjeGwvbGliL2xpYmN4
bC5zeW3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNSArKysrKw0KPiA+IMKgY3hsL2xp
YmN4bC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEgKw0KPiA+
IMKgNCBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vY3hsL2xpYi9saWJjeGwudHh0IGIvRG9jdW1lbnRhdGlvbi9jeGwv
bGliL2xpYmN4bC50eHQNCj4gPiBpbmRleCBmZDI5NjJhLi41YThkOTgwIDEwMDY0NA0KPiA+IC0t
LSBhL0RvY3VtZW50YXRpb24vY3hsL2xpYi9saWJjeGwudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9jeGwvbGliL2xpYmN4bC50eHQNCj4gPiBAQCAtNjksNiArNjksNyBAQCBpbnQgY3hsX21l
bWRldl9nZXRfbWlub3Ioc3RydWN0IGN4bF9tZW1kZXYgKm1lbWRldik7DQo+ID4gwqB1bnNpZ25l
ZCBsb25nIGxvbmcgY3hsX21lbWRldl9nZXRfcG1lbV9zaXplKHN0cnVjdCBjeGxfbWVtZGV2ICpt
ZW1kZXYpOw0KPiA+IMKgdW5zaWduZWQgbG9uZyBsb25nIGN4bF9tZW1kZXZfZ2V0X3JhbV9zaXpl
KHN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYpOw0KPiA+IMKgY29uc3QgY2hhciAqY3hsX21lbWRl
dl9nZXRfZmlybXdhcmVfdmVyaXNvbihzdHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2KTsNCj4gPiAr
Y29uc3QgY2hhciAqY3hsX21lbWRldl9nZXRfZmlybXdhcmVfdmVyc2lvbihzdHJ1Y3QgY3hsX21l
bWRldiAqbWVtZGV2KTsNCj4gPiDCoHNpemVfdCBjeGxfbWVtZGV2X2dldF9sYWJlbF9zaXplKHN0
cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYpOw0KPiA+IMKgaW50IGN4bF9tZW1kZXZfbnZkaW1tX2Jy
aWRnZV9hY3RpdmUoc3RydWN0IGN4bF9tZW1kZXYgKm1lbWRldik7DQo+ID4gwqBpbnQgY3hsX21l
bWRldl9nZXRfbnVtYV9ub2RlKHN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYpOw0KPiA+IGRpZmYg
LS1naXQgYS9jeGwvbGliL2xpYmN4bC5jIGIvY3hsL2xpYi9saWJjeGwuYw0KPiA+IGluZGV4IGU4
YzVkNDQuLjFiN2U5ZDIgMTAwNjQ0DQo+ID4gLS0tIGEvY3hsL2xpYi9saWJjeGwuYw0KPiA+ICsr
KyBiL2N4bC9saWIvbGliY3hsLmMNCj4gPiBAQCAtMTI2Nyw2ICsxMjY3LDExIEBAIENYTF9FWFBP
UlQgY29uc3QgY2hhciAqY3hsX21lbWRldl9nZXRfZmlybXdhcmVfdmVyaXNvbihzdHJ1Y3QgY3hs
X21lbWRldiAqbWVtZGV2DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBtZW1kZXYtPmZpcm13
YXJlX3ZlcnNpb247DQo+ID4gwqB9DQo+ID4gwqANCj4gPiArQ1hMX0VYUE9SVCBjb25zdCBjaGFy
ICpjeGxfbWVtZGV2X2dldF9maXJtd2FyZV92ZXJzaW9uKHN0cnVjdCBjeGxfbWVtZGV2ICptZW1k
ZXYpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gbWVtZGV2LT5maXJtd2FyZV92
ZXJzaW9uOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gSXQgb2NjdXJzIHRvIG1lIHRoYXQgYSBuZXcg
ZXhwb3J0IGlzIG5vdCBuZWVkZWQgZm9yIHRoaXMuLi4NCj4gDQo+ID4gwqBzdGF0aWMgdm9pZCBi
dXNfaW52YWxpZGF0ZShzdHJ1Y3QgY3hsX2J1cyAqYnVzKQ0KPiA+IMKgew0KPiA+IMKgwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgY3hsX2N0eCAqY3R4ID0gY3hsX2J1c19nZXRfY3R4KGJ1cyk7DQo+ID4g
ZGlmZiAtLWdpdCBhL2N4bC9saWIvbGliY3hsLnN5bSBiL2N4bC9saWIvbGliY3hsLnN5bQ0KPiA+
IGluZGV4IDhiYjkxZTAuLmQ0NmM1MGUgMTAwNjQ0DQo+ID4gLS0tIGEvY3hsL2xpYi9saWJjeGwu
c3ltDQo+ID4gKysrIGIvY3hsL2xpYi9saWJjeGwuc3ltDQo+ID4gQEAgLTIxNywzICsyMTcsOCBA
QCBnbG9iYWw6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGN4bF9kZWNvZGVyX2dldF9tYXhfYXZhaWxh
YmxlX2V4dGVudDsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgY3hsX2RlY29kZXJfZ2V0X3JlZ2lvbjsN
Cj4gPiDCoH0gTElCQ1hMXzI7DQo+ID4gKw0KPiA+ICtMSUJDWExfNCB7DQo+ID4gK2dsb2JhbDoN
Cj4gPiArwqDCoMKgwqDCoMKgwqBjeGxfbWVtZGV2X2dldF9maXJtd2FyZV92ZXJzaW9uOw0KPiA+
ICt9IExJQkNYTF8zOw0KPiA+IGRpZmYgLS1naXQgYS9jeGwvbGliY3hsLmggYi9jeGwvbGliY3hs
LmgNCj4gPiBpbmRleCA5ZmU0ZTk5Li43OTUxZTc4IDEwMDY0NA0KPiA+IC0tLSBhL2N4bC9saWJj
eGwuaA0KPiA+ICsrKyBiL2N4bC9saWJjeGwuaA0KPiA+IEBAIC00OCw2ICs0OCw3IEBAIHN0cnVj
dCBjeGxfY3R4ICpjeGxfbWVtZGV2X2dldF9jdHgoc3RydWN0IGN4bF9tZW1kZXYgKm1lbWRldik7
DQo+ID4gwqB1bnNpZ25lZCBsb25nIGxvbmcgY3hsX21lbWRldl9nZXRfcG1lbV9zaXplKHN0cnVj
dCBjeGxfbWVtZGV2ICptZW1kZXYpOw0KPiA+IMKgdW5zaWduZWQgbG9uZyBsb25nIGN4bF9tZW1k
ZXZfZ2V0X3JhbV9zaXplKHN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYpOw0KPiA+IMKgY29uc3Qg
Y2hhciAqY3hsX21lbWRldl9nZXRfZmlybXdhcmVfdmVyaXNvbihzdHJ1Y3QgY3hsX21lbWRldiAq
bWVtZGV2KTsNCj4gPiArY29uc3QgY2hhciAqY3hsX21lbWRldl9nZXRfZmlybXdhcmVfdmVyc2lv
bihzdHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2KTsNCj4gDQo+IC4uLmp1c3QgbWFrZSB0aGlzIHRo
ZSBmb2xsb3dpbmcgaW5zdGVhZDoNCj4gDQo+IC8qIEFCSSBzcGVsbGluZyBtaXN0YWtlcyBhcmUg
Zm9yZXZlciAqLw0KPiBzdGF0aWMgaW5saW5lIGNvbnN0IGNoYXIgKmN4bF9tZW1kZXZfZ2V0X2Zp
cm13YXJlX3ZlcnNpb24oc3RydWN0IGN4bF9tZW1kZXYgKm1lbWRldikNCj4gew0KPiDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIGN4bF9tZW1kZXZfZ2V0X2Zpcm13YXJlX3Zlcmlzb24obWVtZGV2KTsN
Cj4gfQ0KDQpBZ3JlZWQgd2l0aCB0aGlzLg0KDQo=
