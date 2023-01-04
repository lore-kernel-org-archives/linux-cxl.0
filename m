Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC0C46467
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 06:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjADG7e (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 01:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjADG7d (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 01:59:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E057F14029
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 22:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672815571; x=1704351571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gEgFM5jF5Bg8PazVmPcKRdIV9YBWdt5IGuH81HjGiaI=;
  b=Ka7W2N1Lct6LFDUuXrGJaQxkszS8/b1q0G72SSHzt+Rq9GxrWPK4FD9V
   HcMesKuA/UH44Yu+M9ka6TDrAOsskN1nyKLPZWBNGSxTPs8fc1c8qcV9K
   dOjFjMaoKDT8DSud8FYq36chqkGH/niZqCm4UjgxNmS93d4WMKAatVF6x
   Nxw32B2E5j57U499nJMamAygjDsudTfn9NYQNjb2liE8pAeaVF2C5nOqW
   g6v2d9YQON9IFzeoP5OAShel70A2dmBeSJIX2UfDeqiEQmct9/CQZ4i5Q
   K2rPklDLUV/eZTUChclRWx9VrHX4UDbBAMjyJTKSY4oiFHxx1hQXGTsnQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320568534"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320568534"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 22:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="779104868"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="779104868"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 03 Jan 2023 22:59:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 22:59:30 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 22:59:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 22:59:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 22:59:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYhKuyZXQ3v9J4nWtLUKpUdsrhw/1uboPtGPtwCfENxwoqCl75FzB8h7+0zBvF8yNpMbZtfLqDn62yaA1klFlzlXcI5CFx6vJ0H7pLiwRxk53bEwwfMChmjhODAl3pQwKmCgR7Meatt45uevnDAxlC8p0AhoxL1Eg3S+nX/tNGBrZOrtTZRPAjKLOz/O40QJe78vW6BQtekAPFlKJLI5zR68XCrtQKS8NI/ffcCwJdq2vy+Qxr03nV1ChSyb+dNzpiC5MrE69EXRvUwudi4ftGUsx5MDFvWx7D3PDZtSWDkJp4zNXK3cHvMBp2awS9IoMelmwTOKvzah+sg+6jJR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEgFM5jF5Bg8PazVmPcKRdIV9YBWdt5IGuH81HjGiaI=;
 b=RFKvxleIWkX77U6CDGMZUPIkEOYP1gkpfbIy2Q4XP2VdWyCY2vdOB+2uKh8NrOPO7mSXirGvlowzHB5yQG2jWibwd4EfkIHkNB6DFpCIrmPvSisi8EInydrfZsNzL9dHjlUgQSVrB6ojpJ5IRv2gEYhlkjGSSRinPoei9zpkUOSKXXmayRNzYnH4AiaU5VmT3EiEyLq6SAbvH8UpNg/SyU8Nfq+/ogfLJDUuum3HySwmxbRu1H5dYHUhruOIh8W6AMtcwgi1v3raRhayH6HVE9/uzFIRhj283JtyZjT7gqPNZvisQFfxvsoFf3xfO0olMgeGYt4grPFIZ6nUeF9eAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BN9PR11MB5402.namprd11.prod.outlook.com (2603:10b6:408:11b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 06:59:28 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 06:59:27 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>
CC:     "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph images
Thread-Topic: [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph images
Thread-Index: AQHZFKCOrtu2YggNCUSipmQFAN4BWK6NI2cAgAAsGQCAAJtmAA==
Date:   Wed, 4 Jan 2023 06:59:27 +0000
Message-ID: <027f79b1d796fd0ad6c43d1e3fd8c02247e990bf.camel@intel.com>
References: <CGME20221220182621uscas1p22da97d084545a7b00f7bf7ea4df7ee3c@uscas1p2.samsung.com>
         <20221220182510.2734032-1-fan.ni@samsung.com>
         <63b47c72a3cc4_5174129497@dwillia2-xfh.jf.intel.com.notmuch>
         <20230103214305.GA2878607@bgt-140510-bm03>
In-Reply-To: <20230103214305.GA2878607@bgt-140510-bm03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.2 (3.46.2-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|BN9PR11MB5402:EE_
x-ms-office365-filtering-correlation-id: 8fe056c7-e8c1-4571-c8a0-08daee2138a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QyZfVLCMHXnC5R9aK/YW9A1yHVu0KpAKMMDE0VXS1mYI2AzgY/9Wpki9p8NW3pme1z7Aeqf0RQ9bH22f2TYUwe/RrPJW3ESSvW5vuqCzgKY3JRFD1wG6Eq9GFLrZPcK+yABopuKyU6ddxjFNVTZ/AenBf2F1Ypt4MsT4tkKCpvUoS6ej0MIIvRhcxpN7Q/jWrIMoYeBEq4wcnGMG4yyFO9nmyuL+BGbU4tc6LYcbsttEWEcva1rwZVI3J387Cqpj033D01imPiuAEmPKd641nQunj6DSVti3xF5jZ9hqbuKAOysjFH8WjKmyEiazBBQbHR+d+WyUPkMOU1JH1jFsWoijZ2nAyySfuOjXezuapiaJ0AH6BEWZQ3f0e55ovHk78y3DogDC0dEC48q66WzEdB1xdPrq99a8ZTvJXnIJGUNumPrLeY6gG+3CXyVgMQ5RznGt+zERucC7+l5Bampp2FDy1Dz12QTaMWOAxs7TXRBDviSiUfFBl6+PjM6wgzFphvRgzTozEhUKXzUFR9bplsPMFiP6YfYhZCJPZhs80VI6zjYpSskptt3uSXLAkRfgSfTzoFGS8e7CIbjrXvv21WfD64UBsyUbJFstz3VTtExA1BS7gjLPpw5tlR72HyWsB5d8HluLDDZIZ1EeOMtp42xMwacwDTUJXXic4XHnul9FCVhjuSRg4r2T9fTGPmH5VfBDJahAuS08XZ+WbLs0Jl/Gdh5/4RK3aruFJ4+npVtZ8Z2N3QxsnrKrWETEbVR3ZNz7+hAag52SY2A72uDcFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(6512007)(186003)(2906002)(966005)(478600001)(6486002)(71200400001)(6506007)(26005)(54906003)(8676002)(66476007)(66946007)(2616005)(64756008)(76116006)(66556008)(66446008)(91956017)(4326008)(41300700001)(316002)(5660300002)(110136005)(83380400001)(122000001)(82960400001)(8936002)(38100700002)(36756003)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clBIaFNuR0piYm5PTkRHMWxkOVpYYnBOa2d6WUl3aHNPOHJNRnhLVHJMQ1pI?=
 =?utf-8?B?WncxZlhORFZseGNYSExDemNGVzVUNld5MmY1UUdOSWdPUmhaMHcxdEErcGw4?=
 =?utf-8?B?UUJjZ00zelgwdXNBUjdBTnJ5RmMwalpqaVlLRFlORUN5OTcrb3hXdjJQaFJH?=
 =?utf-8?B?YjRyNDh0NFVQTlUyREpkMEdDcFRsMmlYN3lKZEtYanFnYklpSXNLQktPN250?=
 =?utf-8?B?SlpTQW5KR3d2SGd3WWEyM0U1aGg3MVBwdnhuS25UajE0WTlCa09tZ2N5VGgx?=
 =?utf-8?B?N2Vkc1k4ZFVYNUN1YTY2ZkNkaTRRYjJjeGNKbHNkQng5Yy9Jc2pDWktUc0Vl?=
 =?utf-8?B?TUNnekNuNnQ0WEd3RlZFajk0d0hIei9zdUtOYVJxTnpEb3hyOVlWMGFGRGcw?=
 =?utf-8?B?TDdlMFlIeUFHOFNKWkFnTU5rOS9EM3RqTERxVlExVGFJbk50YkgzT3ZqVjVK?=
 =?utf-8?B?S1A2RzZaclBzNXg5REhOYjZyanl2Y05aYVk0NjdCTkxFYjZubExEMjNQb0J2?=
 =?utf-8?B?RjVkUHRyV2xwVHJicDY3eDFLZjV0WG5mYkFYUFUwVkVOd3ZtVjJLaVNmSnA2?=
 =?utf-8?B?L0xoaVlOV2Q1MVZRc0FLM2poNWlHYTNSdVhhYTc5SW9VWTZoL2FHTncxVEZh?=
 =?utf-8?B?dHVsajRrdXVTKzUvY1ZtMzhaSkNPU3VVV1htcXBRNXNoVEp1UURYOEVveGJj?=
 =?utf-8?B?dFlkek80anZxNC9wR3NUdmIxTFZYUFF6MzUzb3hIeDJ2L1FHa2NnSytxeCtw?=
 =?utf-8?B?Z0dSc2lKbFBkc2w2UlR4N0hrYjRXaThta0FqOXFycGd5UEV4RytscnpYaVJa?=
 =?utf-8?B?MDk5eXdMWXN4aE40RFBLelZsbks5UEpEODEwVis3SmpEbU9MUzdObE9XY1lB?=
 =?utf-8?B?ZlI5dDFBTnVLSGhTWnh4UzcwNSt2cEV2U1hLMytUK09Mb3dzbktHNU11aTRO?=
 =?utf-8?B?RzF3YTFjQW5oVUo2dko2UEo0UnduL2xpYW5ZSWJNOEo3ZjVFMjUxdjBoT2pr?=
 =?utf-8?B?aXhaWERvOER6dFpEdmVzelh4ODlDbjl1Ukd1emFNM2YvdFdRN2NqLzJiZUVI?=
 =?utf-8?B?dFJSaXhmOHV4R1A0VklBMEo4eVVzaWdadExwR2cwRmt1QVN3K0tpcDNaemlv?=
 =?utf-8?B?R1Q5Y0xWZldTWGRyZXJrOXJtSnhjRjJWbEtkSlJuSkR2b0Vlc0VHNzBoSUdQ?=
 =?utf-8?B?cm9tcmtDK3kyWjJoSENVcWdRNzZPTk5LTytXUTBoa1ZlMEROdU9FNkJmVnhB?=
 =?utf-8?B?T2lHcllla2p2QzhtWmpjRXd2cEl4b1prVXZya1AybSs1V28vSHpOUCt4amFB?=
 =?utf-8?B?UEtBM3poREFvYUdUd3BKb2NqcDMxVmwvcGFnRXprNWRjSlNCWGp6UndjWkxW?=
 =?utf-8?B?bm1pVGt6dXhDK2VTM0VwN0Y2UjQrbGNNdlJtUmlUQTR2VEZTWlJhKzE1VVJ2?=
 =?utf-8?B?ZEcwMFk1WEYvSFY3NWdUR3ZWNFc0YVh2YVJzeCtsbll5ZkdHRUlWV3ZrRGl4?=
 =?utf-8?B?WVorOUkyL2hiYi9zVXAxY3RjRzEwa1NxTzdqZHhXMkJjSXFOVTh2UE80WGw0?=
 =?utf-8?B?Ky9hSjBjRUlPRGtzNWJqd0E2cGY5dFBvaGFmVVU5MTlLdmRVWkVwRTZycU9G?=
 =?utf-8?B?cUhkQjhMSis0WEdpL2NtU2Z2RjVlV3ZCWUltbDlUVmFIWVd0Q3RabXpWb01i?=
 =?utf-8?B?NTF2dFE4U05adEN3YmhIcFNTUmx5eDVucEpBUmVScWpKcmFlSVRNUG9KbTM2?=
 =?utf-8?B?LzNuK2hwTFMwK2lORG0xY1BicytzU0NtY2VIOUEreFVDUnZxaCt2NDNzNFN4?=
 =?utf-8?B?ZHJDOEg4WHRQNC80cGNlWS84WDM4WEowR1NaQk00c1lPd1c3TEQ2ak56MVF2?=
 =?utf-8?B?bDFhUXBYK0p0d3hHcHpwSnZ2bjdBMUhtU3B3N082Z2Zzb3h0bHMrU2xGWUZJ?=
 =?utf-8?B?dU02YXY0K2hhOTdpV2FPOS80dVFlYXVvNDA5OUVuaDZkdkNVY2dSVmxTdGJL?=
 =?utf-8?B?Q2FneFBTOEpaWkNQSjd4eFZtNGV4Wkl2dGUyTVBHOUYrMTJORWp4Q2V3YXlz?=
 =?utf-8?B?QUR0UHNoeWx3Lzl6SkJwajNqTmVKNmR1VXNoZDd1ZThvVEQ3R3E2aEJIQnFW?=
 =?utf-8?B?alpmdWpHSzNNSmJ0Vk03Z2xPS1MrK1cwK051R2Z6cHdtWnZ2UWI1c1R6S3BQ?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F50F9BB8D96DF548BBB87E50A117C61C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe056c7-e8c1-4571-c8a0-08daee2138a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 06:59:27.7220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbvKLew9rTbXR6++aLlDg/oqUw6rT+QQVCHuIiO1WbNJk+TCHWQ19RCR0hpsA6HCfZBoxVPodiWd/wT1/ZXSBg/AbJxHNz3wspOmr2TvKqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5402
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTAzIGF0IDIxOjQzICswMDAwLCBGYW4gTmkgd3JvdGU6DQo+IE9uIFR1
ZSwgSmFuIDAzLCAyMDIzIGF0IDExOjA1OjIyQU0gLTA4MDAsIERhbiBXaWxsaWFtcyB3cm90ZToN
Cj4gPiBGYW4gTmkgd3JvdGU6DQo+ID4gPiBUaGlzIHBhdGNoIHNlcmllcyBleHRlbmRzIHRoZSBg
Y3hsIGxpc3RgIHN1YmNvbW1hbmQgdG8gc2hvdyB0aGUgY3hsDQo+ID4gPiB0b3BvbG9neSB2aXN1
YWxseS4gTWF0dGV3IEhvIGZpcnN0IHdvcmtlZCBvbiB0aGUgY29kZSBhbmQgcHJvdmlkZWQgYW4N
Cj4gPiA+IGluaXRpYWwgcGF0Y2ggYXMgbGlzdCBiZWxvd1sxXS4NCj4gPiANCj4gPiBUaGFua3Mg
Zm9yIHBpY2tpbmcgdGhpcyB1cCwgaXQgbG9va3MgbGlrZSBhIHVzZWZ1bCBhZGRpdGlvbiB0byBt
ZS4NCj4gPiANCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBzZXJpZXMgaW5jbHVkZXMgdGhlIGZv
bGxvd2luZyB0d28gcGF0Y2hlcywNCj4gPiA+IDEpIFBhdGNoIDEgYWRkcyBhIHBhcmVudF9kcG9y
dCBhdHRyaWJ1dGUgdG8gcG9ydHMgYW5kIHR5cGUgMyBtZW1vcnkgZGV2aWNlcyB0bw0KPiA+ID4g
c2hvdyB3aGljaCBkb3duc3RyZWFtIHBvcnQgYSBjb21wb25lbnQgaXMgYXR0YWNoZWQuIFRoaXMg
YXR0cmlidXRlIHdpbGwgYmUgdXNlZA0KPiA+ID4gaW4gcGF0Y2ggMiB0byBnZW5lcmF0ZSB0aGUg
Y3hsIHRvcG9sb2d5IGdyYXBoLg0KPiA+IA0KPiA+IEkgaGFkIGEgc2ltaWxhciBwYXRjaCB0byBk
byB0aGlzIGhlcmU6DQo+ID4gDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6
Ly9sb3JlLmtlcm5lbC5vcmcvci8xNjcwNTM0OTE5MDguNTgyOTYzLjc3ODM4MTQ2OTM2NDQ5OTEz
ODIuc3RnaXRAZHdpbGxpYTIteGZoLmpmLmludGVsLmNvbV9fOyEhRXdWenFHb1RLQnF2LTBEV0FK
Qm0hWGNfdFd0WDBHQnFpb25vcTdKUlF4UTM5TXl0SkVXM2pQLUpjUW5Mcmo3T3A5X3U1bU1SZ19o
VW9VdlFhYkhOVF9JWGkzTWJIRjJkMFR3Q3NpWmNraHZDVG9BJMKgDQo+ID4gDQo+ID4gVGhlIGJp
Z2dlc3QgZGlmZmVyZW5jZSBJIHNlZSBpcyB0aGF0IHlvdXIgdmVyc2lvbiBhZGRzICdwYXJlbnRf
ZHBvcnQnIHRvDQo+ID4gbWVtZGV2cyB3aGVyZSBtaW5lIGtlZXBzIGl0IHB1cmVseSBhbiAncG9y
dCcgYXR0cmlidXRlLiBTbyB0aGUgbGlzdGluZw0KPiA+IG5lZWRzIHRvIGhhdmUgLS1lbmRwb2lu
dHMgdG8gZ2V0IHRoZSBtZW1kZXYgdG8gJ3BhcmVudF9kcG9ydCcNCj4gPiBhc3NvY2F0aW9uLg0K
PiANCj4gVGhhbmtzIGZvciBtZW50aW9uaW5nIHRoaXMsIEkgbWlzc2VkIHRoZSBwYXRjaC4gSXQg
c2VlbXMgd2UgY2FuIHVzZSB0aGlzIHBhdGNoDQo+IHRvIHByZXBhcmUgdGhlIGluZm8gZm9yIHBs
b3R0aW5nIHRoZSBncmFwaC4gTmVlZCB0byBjaGVjayBtb3JlLg0KPiANCj4gPiANCj4gPiA+IDIp
IFBhdGNoIDIgZXh0ZW5kcyB0aGUgYGN4bCBsaXN0YCBzdWJjb21tYW5kIHRvIGR1bXAgdGhlIGN4
bCB0b3BvbG9neSB0byBhDQo+ID4gPiBqc29uIGZvcm1hdCBmaWxlIG9yIGdlbmVyYXRlIGEgZ3Jh
cGggc2hvd2luZyB0aGUgY3hsIHRvcG9sb2d5LiBUbyB1c2UgdGhlDQo+ID4gPiBleHRlbmRlZCBm
dW5jdGlvbiwgdGhlIG9wdGlvbiBgLW8gb3V0cHV0LnN1ZmZpeGAgaXMgYWRkZWQuIEFjY2VwdGFi
bGUgb3V0cHV0DQo+ID4gPiBzdWZmaXhlcyBpbmNsdWRlIC5qcGVnLCAuanBnIGFuZCAucG5nIGZv
ciBnZW5lcmF0aW5nIGEgZ3JhcGggYW5kIGZvciBvdGhlcg0KPiA+ID4gc3VmZml4LCBpdCB3aWxs
IGR1bXAgdGhlIGpzb24tZm9ybWF0dGVkIGN4bCB0b3BvbG9neSB0byB0aGUgZmlsZSwgd2hpY2gN
Cj4gPiA+IGNhbiBiZSB1c2VkIHRoZSBpbnB1dCBmaWxlICh3aXRoIC0taW5wdXQgb3B0aW9uKSB0
byBnZW5lcmF0ZSB0aGUgZ3JhcGgNCj4gPiA+IGxhdGVyLg0KPiA+IA0KPiA+IEkgbm90aWNlIHRo
YXQgdGhlIGltcGxlbWVudGF0aW9uIGVuZm9yY2VzIHNvbWUgaW1wbGljaXQgbGlzdGluZyBvcHRp
b25zLA0KPiA+IGRpc2FibGVzIC0tZW5kcG9pbnRzLCBhbmQgZG9lcyBzb21lIG1hZ2ljIHdpdGgg
bG9va2luZyBhdCB0aGUgc3VmZml4IHRvDQo+ID4ga25vdyB3aGF0IHRvIHdyaXRlIHRvIHRoZSBv
dXRwdXQgZmlsZS4gVGhhdCBmZWVscyB0b28gcmVzdHJpY3RpdmUgYW5kDQo+ID4gbWFrZXMgdGhl
ICdsaXN0JyBjb21tYW5kIGEgYml0IG1vcmUgZGlmZmljdWx0IHRvIHJlYXNvbiBhYm91dC4gSG93
IGFib3V0DQo+IA0KPiBVc2luZyBmaWxlIGV4dGVudGlvbiB0byBkZWNpZGUgd2hldGhlciB0byBk
dW1wIHRoZSBvdXRwdXQgdG8gYSBqc29uLWZvcm1hdHRlZA0KPiBmaWxlIG9yIHBsb3QgYSBjeGwg
Z3JhcGggd2FzIHN1Z2dlc3RlZCBieSBWaXNoYWwgaW4gaGlzIHByZXZpb3VzDQo+IGNvbW1lbnRz
IHRvIE1hdHRldydzIHBhdGNoICgNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzA5M2Vi
ZjEyNmFkNDQ5MjBkOWM3YmZkMWMzMGFmNTA0MGUwYzcwMjAuY2FtZWxAaW50ZWwuY29tLw0KPiAp
LiBXZSBhcmUgbmV1dHJhbCB0byBlaXRoZXIgd2F5IGFzIGxvbmcgYXMgdGhlcmUgaXMgYSBjb25z
ZW5zdXMuDQo+IA0KPiBBYm91dCB0aGUgZW5mb3JjZW1lbnRzIHBsYWNlZCBvbiAiY3hsIGxpc3Qi
IGNvbW1hbmQgb3B0aW9uLCBpdCBzaG91bGQgYmUgZWFzeSB0bw0KPiBhZGRyZXNzLiBXZSBzaG91
bGQgYmUgYWJsZSB0byByZW1vdmUgdGhlbSBhbmQgZml4IGluIGdyYXBoIGZ1bmN0aW9ucy4NCj4g
DQo+ID4gZGVjb3VwbGluZyB0aGUgc3VwcG9ydCBmcm9tICdsaXN0Jz8gSSBhbSB0aGlua2luZyBv
ZiBhIHNjaGVtZSBsaWtlIHRoaXM6DQo+ID4gDQo+ID4gwqDCoCBjeGwgbGlzdCAtdnZ2IHwgY3hs
IGdyYXBoIC1vIHBuZyA+IGN4bC10b3BvLnBuZw0KPiA+IA0KPiANCj4gQ3VycmVudGx5LCB3ZSBj
YW4gZG8gc2ltaWxhciB0aGluZ3MgYXMgeW91IG1lbnRpb25lZCBhYm92ZS4NCj4gY3hsIGxpc3Qg
LXZ2diA+IGN4bC5qc29uICh3aXRoIHNvbWUgY2hhbmdlcyB0byByZW1vdmUgdGhlIG9wdGlvbiBl
bmZvcmNlbWVudC4pDQo+IGN4bCBsaXN0IC1pbnB1dCBjeGwuanNvbiAtbyBjeGwtdG9wby5wbmcN
Cj4gDQo+IEJ1dCBJIGFncmVlIHRoYXQgdXNpbmcgYSBzZXBhcmF0ZSBzdWJjb21tYW5kIG1heSBi
ZSBhIGJldHRlciBpZGVhIGFzIHRoZQ0KPiBhZHZhbnRhZ2UgeW91IG1lbnRpb25lZCBiZWxvdy4N
Cj4gDQo+ID4gVGhpcyBoYXMgYSBmZXcgYWR2YW50YWdlczoNCj4gPiAtIFRoZSBncmFwaHZpeiBi
dWlsZCBkZXBlbmRlbmN5IGNhbiBiZSBtYWRlIG9wdGlvbmFsIHdoZXJlIHRoZSB1c2VyIGNhbg0K
PiA+IMKgIGRldGVjdCBpZiB0aGUgc3VwcG9ydCBpcyBwcmVzZW50IGluIHRoZSBidWlsZCBieSB0
aGUgYXZhaWxhYmlsaXR5IG9mDQo+ID4gwqAgdGhlICdncmFwaCcgc3ViY29tbWFuZC4NCj4gDQo+
IElNTywgdGhpcyBpcyB0aGUgbWFpbiBhZHZhbnRhZ2UgdG8gaW50cm9kdWNlIGEgbmV3IHN1YmNv
bW1hbmQuDQo+IA0KPiA+IC0gTGlzdGluZ3MgY2FuIGJlIGNyZWF0ZWQgb24gb25lIHN5c3RlbSBh
bmQgZ3JhcGhlZCBvbiBhbm90aGVyIHdoaWNoDQo+ID4gwqAgYW1vbmcgb3RoZXIgdXNhZ2VzIGlz
IHVzZWZ1bCBmb3IgZGVidWdnaW5nIHRvcG9sb2dpZXMgb3ZlciBlbWFpbC4NCj4gDQo+IE91ciBj
dXJyZW50IGFwcHJvYWNoIGNhbiBhY2hpZXZlIHNpbWlsYXIgZ29hbCB3aXRoICItaW5wdXQiIG9w
dGlvbi4NCj4gDQo+ID4gLSBUaGUgJ2dyYXBoJyBzdWJjb21tYW5kIGNhbiBwYXJzZSBhbmQgb3B0
aW9uYWxseSB3YXJuIGFib3V0IHRoZSBpbnB1dA0KPiA+IMKgIGpzb24gcmF0aGVyIHRoYW4gaW1w
bGljaXQgZm9yY2luZyBvZiBsaXN0aW5nIG9wdGlvbnMuDQo+IA0KPiBBZ3JlZS4NCj4gDQo+ID4g
LSBUaGUganNvbiBjYW4gZ28gdGhyb3VnaCBhZGRpdGlvbmFsIGZpbHRlcmluZyBiZWZvcmUgYmVp
bmcgZ3JhcGhlZDoNCj4gPiANCj4gPiDCoMKgwqAgY3hsIGxpc3QgLXZ2diAkYmFzaWNfZmlsdGVy
cyB8IGpxICRhZHZhbmNlZF9maWx0ZXJzIHwgY3hsIGdyYXBoIC1vIHBuZyA+IG91dA0KPiA+IA0K
PiA+IFRob3VnaHRzPw0KPiANCj4gVGhhbmtzIGZvciB0aGUgY29tbWVudHMuIFNvIGJhc2VkIG9u
IHRoZSBhYm92ZSBjb21tZW50cyBhbmQgbXkNCj4gdW5kZXJzdGFuZGluZywgSSB0aGluayB3ZSBu
ZWVkIHRvIGRlY2lkZSB0d28gdGhpbmdzIGJlZm9yZSBhY3RpbmcNCj4gZnVydGhlci4NCg0KPiAx
LiB3aGV0aGVyIHdlIHdhbnQgdG8gdXNlIHN1ZmZpeCB0byBkZXRlcm1pbmUgcGxvdCBiZWhhdmlv
dXIgb3IgdXNlDQo+IGV4cGxpY2l0IGFyZ3VtZW50cy4NCg0KSSB0aGluayBJIHdhcyB0YWtpbmcg
aW5zcGlyYXRpb24gZnJvbSBwYW5kb2Mgd2hlbiBJIHN1Z2dlc3RlZCB1c2luZw0KZmlsZSBleHRl
bnNpb25zIHRvIGRlZHVjZSB0aGUgb3V0cHV0IC8gaW5wdXQgZm9ybWF0cy4gSG93ZXZlciwgSSB0
aGluaw0KaXQgY2FuIGJlIHZhbHVhYmxlIHRvIGhhdmUgYW4gZXhwbGljaXQgb3ZlcnJpZGUgdG9v
Lg0KDQpTbyBtYXliZSBzb21ldGhpbmcgbGlrZToNCiAgLW8gdG9wby5wbmcgOiBvdXRwdXRzIGFz
IGEgcG5nIChkZWR1Y2VkIGZyb20gZXh0ZW5zaW9uKQ0KICAtbyB0b3BvIC1mIHBuZyA6IGFsc28g
b3V0cHV0cyBhcyBhIHBuZw0KICAgICAgICAgICAgICAgICAgIChzcGVjaWZpZWQgZXhwbGljaXRs
eSBieSAtZiAvIC0tZm9ybWF0KQ0KICAtbyB0b3BvLnBuZyAtZiBqcGcgOiBvdXRwdXRzIGFzIGEg
anBnIC0gaS5lLiAtZiBvdmVycmlkZXMgZXh0ZW5zaW9uDQoNCj4gMi4gV2hldGhlciB3ZSB3YW50
IHRvIGludHJvZHVjZSBhbiBleHRyYSBzdWJjb21tYW5kIGZvciB0aGUgZ3JhcGgNCj4gZnVuY3Rp
b24gb3Igc3RpY2sgdG8gZXhpc3RpbmcgYXBwcm9hY2ggYW5kIG1ha2UgY2hhbmdlcyBhcyBuZWVk
ZWQgdG8NCj4gYWNoaWV2ZSBzaW1pbGFyIGdvYWwuDQoNCkkgdGhpbmsgdGhlIGZsZXhpYmlsaXR5
IGFuZCBkZWNvdXBsaW5nIGdhaW5lZCBmcm9tIHNwbGl0dGluZyB0aGlzIG91dA0KdG8gYSBuZXcg
Y29tbWFuZCBpcyBxdWl0ZSB2YWx1YWJsZS4gRXNwZWNpYWxseSBjb25zaWRlcmluZyB0aGUgYWJp
bGl0eQ0KdG8gcGlwZSB0aHJvdWdoIGpxIGZpbHRlcnMuIFRoYW5rcyBmb3IgdGhpcyBzdWdnZXN0
aW9uIERhbiENCg0K
