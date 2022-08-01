Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0470EC00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiHATkQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiHATkP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:40:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661CB10E3
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659382814; x=1690918814;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4sfyAqabIXEEHuZ/Wryu4arhnOLbuXxRJOYOUPj9nhA=;
  b=lE2Ks0rX6IpylsbJqfLMvBbItSX/c0YriPPA0Mq1p4zqEyWjQDj+Le8x
   1GMNBqDD8w+RCurb95jGIOxYcZBqfLUUHjbSQf6LECjaX1RmpGRS8Y/Z1
   fLHILnytRKEDb5CvO+ZZiHB2mSjsdf8Qg85oDvGqof+7bv+MVl03mkstw
   1JnBdzhaMJvccbQDuKCmB6VUyl77MfTJk5iJoK9Jz+bimAbbTX08c28h2
   4Jfnl4uy8JLs8OxwDsOTJLoKr5wqly7s7dHrkfJ9ybN++BQ7jMwSUTIbd
   J2oX6yb0+LQC89KFchS/v59Jrv4mymGkz0MdatLSOVq9brC/idd5S9fe9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="375532494"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="375532494"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:40:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="602152713"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2022 12:40:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:40:13 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:40:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 12:40:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 12:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxA2/Fprs5jaVxpastkTBvVNlyGg64QcKD1x+1Gy9S1Vcw82HyGm7hya+NpU0cu4TE5v/Vo3Pr0OdQLzoHIhJYqZnY4qJHXygG/3O0Z8VlawJlGc3gsJtyI3mdUikodLFLQ3pdCmfFoSjiOe+KCvDp7hgTmSQ3KV783LyPVHTq67/Nwrgwll0FkfJ9PqPnd+4oYXJbKXWBE6MObVEvxdGjKHaRVcPC9pQHkcayDRwJ2Rj633ABNSOL2zVOWB02416V3fHft31UsTLFwynf8zWecwTqtCCW0btLlDqSCO0BqzVRG/j+8csWdRxAAn2lV1lUv8ifWD7ZWb9AYxaqSnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sfyAqabIXEEHuZ/Wryu4arhnOLbuXxRJOYOUPj9nhA=;
 b=TuzeF9J/eJPiIYrVwOXvYBL75ThBzU2zaaBERH1wV8MJbSUZQn0S335XM4Qo+mwpR6l/Z+V5Wa1PjS2NGv0QNM1pjjnFBlX02UVxEa9n+LuWTymSXAdW9frX/YjWLWWd8K1myZI301K22UzlGv8ZTBDCr48FONyw4IZMwuwQrrku+6Qt+8hI2Mg6xEhLIsm9cEILV2vrSur4eCIdwRUAjiHDgi6t0H/0G+Nog0TQWIIIvS7/PpOREW3uPCcHjp8BgSnW9545pjYV49wChfgj0pbcT1FYXYqMZ26N5596u0hJi8pF+DfNza6d86XP+shSD5dKCI4X5n77rOn7sbYkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MN0PR11MB6134.namprd11.prod.outlook.com (2603:10b6:208:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 19:40:11 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4%7]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:40:11 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/region: Delete 'region' attribute from root
 decoders
Thread-Topic: [PATCH 2/5] cxl/region: Delete 'region' attribute from root
 decoders
Thread-Index: AQHYni9PhyQ1cNeAW0Gxm2h8Y+Ktd62agC0AgAAAeQA=
Date:   Mon, 1 Aug 2022 19:40:11 +0000
Message-ID: <d0c2044b096d8a79c98501a5178cc9b7dca422ea.camel@intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
         <165853776328.2430596.4647259305040072751.stgit@dwillia2-xfh.jf.intel.com>
         <919eb8198e880205b81da7090d6f0535782f0fad.camel@intel.com>
In-Reply-To: <919eb8198e880205b81da7090d6f0535782f0fad.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1594923-4b4a-4c00-569d-08da73f5a61b
x-ms-traffictypediagnostic: MN0PR11MB6134:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nmOLVq+xH/kc3VYs5cy+OsWjwXqDhFYiAhKmXVuF0sfBWkVf6eWPU+IHcxOYud9PawiFVt8lDeKBciHF3RtVLKYa/OXkb9mqJWAnu1qommXnnoxEhJtlWERS3brrAwFmvFi6QYQMIztyG0sgeWxLAdXr/0E9ySr1tbqtkPScetNjh3Ys6BdcLVB662PZCNESdKv5wEEnw0iicJwdjNc1+iM1NKxU1gjFvp+g5dgu3z2d9C+scGiZX1NrkgwVOwU0pwS2yE+ldHMm+XhocebxZVR4txLrEuv3N0n1C2w8uKhnvqPmqPHthGn/L6UlDB9mYZelQFykBn8Hz6mzL7f15nH4Fk4kAqtnKUjGL1JfT/B8edPEEnnBUDM/ZyRE6IVaRxwsQMQdpv6OqcqIONTu3Po96chMVfxm7leix6SaEr+Ug4HjJNx1vfUyuoSI6gLS7IRYSs7/A5oZibDYf9G2mc8TTXN7ZxCvGzmK+QGy5lAUPEA6GYKmylBULijDziVlCjY+mHg/KN/cXaBUSF2Ik2et+SnVEwbCCCn4eJYrKW/rcjIr9otTsl1MM/vqJtaDhSutpQOAWgJDL9LkTlWZunZAvS2bqBKNOqKe3eewoQh4y5jDIdnJTcNYOGHxJyd2xmHewR5NmNATjvckUYbMSa0HQZ4MKjhEMJ20BOT8vTGaqeG0N/ifbs38ZtL/rXx8q2mIGkNZDAKxk4Dm1P/6tujG06INgQLastuFcvsIqxRbZX0l49EXg29eRPw9EE9Ir2Pp1g/UwpzHifRRLz7JtOqZlqljCchKBCyEuNW8VWj8APUqgvoXdDUZDF0e56Lg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(366004)(136003)(396003)(110136005)(82960400001)(8676002)(6506007)(316002)(6486002)(478600001)(36756003)(38070700005)(26005)(71200400001)(6512007)(41300700001)(64756008)(66556008)(66946007)(76116006)(186003)(66476007)(2616005)(86362001)(91956017)(2906002)(66446008)(8936002)(122000001)(38100700002)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFpUSGc1MjdTM09FRVNhTXFNWG9nSVFtUHlkRS96YXdLcWtMODRVOTdTTWh4?=
 =?utf-8?B?TVNMakVOQ3k1cTBpUWViZnNPOTVwRzc0SW5qUGpyVUZPdk1TQTNua3Y3TUZr?=
 =?utf-8?B?RThJVVEyQWJwMFdoeGs0WndQSWpoOXBjMHdvTUZpUFhhRW1abnQrSmNyeDZT?=
 =?utf-8?B?d0gyWERlSXI2akVhUGxoWlN6eCtGWG52TEFJZk5Wa2RTZloxbFg1cjdmTERI?=
 =?utf-8?B?bXZPV2ExVXBzSHBDb1VicWdQeUo5TS9iT2QyNmV6NVdtSzB0aVhsL0p1MDl6?=
 =?utf-8?B?bVhpQnEzaVZHeU1laDZZTkVFUiswY21JWTNuVEs4UDltc3ZCMWRPWlFCMy80?=
 =?utf-8?B?eCtFRVFmM014Y09hU2d5NHh4SDg5NXhnNWVMTXdNaHZLT1V4SkJCeHF5OXFy?=
 =?utf-8?B?ejhwdlEybnJEZnI3bWU5d2RWOW80bEJPUERSRDAzeENudnRHeHpGOUFCQWZE?=
 =?utf-8?B?V2ZTS1JLRVNDZ0pKRG5NdFFsUmpMSkovdzEzRmFxUUkwZlBJRnFzWmRYeE9X?=
 =?utf-8?B?ekd2MTcrMXZ3RkZybzR1TW92d1NiNGRCRTh3SFo2WmJBbWtXcE03cUJENE4x?=
 =?utf-8?B?aHpNNzIrdmVLaEtOQWVlWDRKbmV1cXNnOXZ1alFNU3FOeDZaaEJpN09LMEhN?=
 =?utf-8?B?cUhXVXppa2t6cUxNMHNJS09keENDNURVYnF3Nk1mSjljWldBdW91MzRyTEIx?=
 =?utf-8?B?czZQWC9pWHU1WFdRQVU5dUpGNjg4UHBiVjZzR2hUcVBZcEZ2MnkwRUR3VUhz?=
 =?utf-8?B?Wjd5VWJDMERHd0lCRVV0TTR3ZnZod2VaejVDbi9VN0o5dUJ6R3NBem9FdEdW?=
 =?utf-8?B?elBtMTN4T3loQ0pISVNiNDNsK2x6b0Fkc0pCN3NoR0FKSElUUUhkb20vQ3Vp?=
 =?utf-8?B?VmxXV3pDdUFISml1dUswTVlNZlIxSEFWQytjVnZub3RBdGRkZ3FXdXNQMXZ3?=
 =?utf-8?B?RFFiMGdvbXRBa2lRQ0VneElwQjYzZitpTW5Cb1NZTk1xVHdGaXQrWmZlSXdk?=
 =?utf-8?B?SUh5NytLd2RYMHk4cDB5dS90d2Z2SVZpNEtJbXZuUmVadnZ2Tk1tQUlzZ2Ix?=
 =?utf-8?B?bWExbXpFaXcvWm1LY1BZS0hoUkFIcUM0U1hpWjdycVJwUllNMFdWb0FZWTE0?=
 =?utf-8?B?YStUVG5teFBjakQ5bHhaY1RqT1dDMjhWbDJaM1dTYVg0Z3FkZHhWWHZ2cmtE?=
 =?utf-8?B?Q0JCWk0reGk4Y2p4eHBRZjlnRm11NzIzWDJ3VkczdmJyQjJGd01kdTkrZzA1?=
 =?utf-8?B?OGFYRzVvUzViM3MvU0s1aXNvbmQyaHRsU2l6aHRBUjg1T0ZIelJnU2dqbkFl?=
 =?utf-8?B?U0lQQXpkYjFUNW5RQU5DbXBTZ1lwQlA1cmd5c1J2anVTRWViaVpZL3lKUjJJ?=
 =?utf-8?B?SDV1eEd1QW1KZWswL1JvbTU1R2VHS2QzMjFOMnlMYmdsQXdtMVZRT1lzTy91?=
 =?utf-8?B?ZE1QMXFHVjdPUzlCY05vUmVtbEZIQmFCSDR3UDBad3NhMFl0WThxckpkWFl0?=
 =?utf-8?B?eE1tSVhYeDNOY1VTZndKODAxK2dmV1lITm15OTNCSjJSWFVwWS9aemRUNnd4?=
 =?utf-8?B?ZE5zQjVZVTcrdXp6UUhYWUZyd1M3Mk9ITS9JMEVsQ2htdHlLOHc1a2xmbjFs?=
 =?utf-8?B?NFliem5OMmx4RWVSbGNzb3BNNm0reS9BdE9jUXlZWXhHSDFYYWxNV3k5TWU5?=
 =?utf-8?B?VW92R3dFNDVVdDdIOVVkNnFjbWpRRDZtMVZDMmhvQVBLYVQvcXkwM04wYTlN?=
 =?utf-8?B?UWxPd1FxZTZDcVBmQ0ltalNZZHhxQ3U1cU5tZ296cTVoMTYraVUvT0I5Nisy?=
 =?utf-8?B?MTZ4L1JuTXRYWmRHZ2RnYWp6ZUlCVlM4aEM4ZTRSR3RxYTczeEhTVVVxVUd6?=
 =?utf-8?B?UnZxMEVONFRvajNNQUVmVFVvbUVMVVZwWGxFMzYzWnF2cXpmM0lDU1hpY0N6?=
 =?utf-8?B?UFFXSFdwdVVjUTB3RWVXSXVjTFJudVluYnFmV0FHNU1zbnhRSk5xaVk5L0th?=
 =?utf-8?B?Z1hISWR6cExMRkF4eDBVSUxMMW5uUVltNTFNaG5nbmJWM2ltdCt4eDcxeWVp?=
 =?utf-8?B?SzFiQ1BIZnc3QmdrOEZweVp2UWtkWjZ6cC9OQkxRcUhjSTc0cnZXMzh1QXlw?=
 =?utf-8?B?UG5zcjQzUVlKendIVGM3S2dnTlMwRG9RU0xXZjZkcU9vVTNDVWk5YWFxTE5t?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE2550F652D4F44E8546A0031BC8C19F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1594923-4b4a-4c00-569d-08da73f5a61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 19:40:11.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHLLpU2qhXIvUr5QryNZlo4JE6+YaUedmlRYkhQ2H8LgvJvExU2kPqSx7baGE5owxaiLHvlbsO2SfFBzWZkWkPRIiqfhN/gOjaE3V20MDAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6134
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTAxIGF0IDE5OjM4ICswMDAwLCBWZXJtYSwgVmlzaGFsIEwgd3JvdGU6
DQo+IE9uIEZyaSwgMjAyMi0wNy0yMiBhdCAxNzo1NiAtMDcwMCwgRGFuIFdpbGxpYW1zIHdyb3Rl
Og0KPiA+IEZvciBzd2l0Y2ggYW5kIGVuZHBvaW50IGRlY29kZXJzIHRoZSByZWxhdGlvbnNoaXAg
b2YgZGVjb2RlcnMgdG8NCj4gPiByZWdpb25zDQo+ID4gaXMgMToxLiBIb3dldmVyLCBmb3Igcm9v
dCBkZWNvZGVycyB0aGUgcmVsYXRpb25zaGlwIGlzIDE6Ti4gQWxzbywNCj4gPiByZWdpb25zIGFy
ZSBhbHJlYWR5IGNoaWxkcmVuIG9mIHJvb3QgZGVjb2RlcnMsIHNvIHRoZSAxOk4NCj4gPiByZWxh
dGlvbnNoaXANCj4gPiBpcyBvYnNlcnZlZCBieSB3YWxraW5nIHRoZSBmb2xsb3dpbmcgZ2xvYjoN
Cj4gPiANCj4gPiDCoMKgwqAgL3N5cy9idXMvY3hsL2RldmljZXMvJGRlY29kZXIvcmVnaW9uKg0K
PiA+IA0KPiA+IEhpZGUgdGhlIHZlc3RpZ2lhbCAncmVnaW9uJyBhdHRyaWJ1dGUgZm9yIHJvb3Qg
ZGVjb2RlcnMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53
aWxsaWFtc0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL2N4bC9jb3JlL3BvcnQu
YyB8wqDCoMKgIDMgKystDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvcG9y
dC5jIGIvZHJpdmVycy9jeGwvY29yZS9wb3J0LmMNCj4gPiBpbmRleCAzZDJkMDExOWNjM2QuLmJm
ZmRlODYyZGUwYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3BvcnQuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcG9ydC5jDQo+ID4gQEAgLTI5MCw3ICsyOTAsNiBAQCBz
dGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqY3hsX2RlY29kZXJfYmFzZV9hdHRyc1tdDQo+ID4gPSB7
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCZkZXZfYXR0cl9sb2NrZWQuYXR0ciwNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgJmRldl9hdHRyX2ludGVybGVhdmVfZ3JhbnVsYXJpdHkuYXR0ciwNCj4gPiDCoMKg
wqDCoMKgwqDCoMKgJmRldl9hdHRyX2ludGVybGVhdmVfd2F5cy5hdHRyLA0KPiA+IC3CoMKgwqDC
oMKgwqDCoFNFVF9DWExfUkVHSU9OX0FUVFIocmVnaW9uKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqBO
VUxMLA0KPiA+IMKgfTsNCj4gPiDCoA0KPiA+IEBAIC0zNDUsNiArMzQ0LDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXANCj4gPiAqY3hsX2RlY29kZXJfcm9vdF9hdHRyaWJ1
dGVfZ3JvdXBzW10gPSB7DQo+ID4gwqBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqY3hsX2RlY29k
ZXJfc3dpdGNoX2F0dHJzW10gPSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCZkZXZfYXR0cl90YXJn
ZXRfdHlwZS5hdHRyLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAmZGV2X2F0dHJfdGFyZ2V0X2xpc3Qu
YXR0ciwNCj4gPiArwqDCoMKgwqDCoMKgwqBTRVRfQ1hMX1JFR0lPTl9BVFRSKHJlZ2lvbikNCj4g
DQo+IFRoaXMgcGF0Y2ggcmVtb3ZlcyB0aGUgJ3JlZ2lvbicgYXR0ciBmcm9tIHN3aXRjaCBkZWNv
ZGVycywgYnV0IGlzbid0IGl0DQo+IGFsc28gdmVzdGlnaWFsIHVuZGVyIHJvb3QgZGVjb2RlcnM/
DQoNCk9oLCBuZXZlciBtaW5kLCBJIG1pc3JlYWQgdGhlIHBhdGNoIC0gaXQgYWRkcyBpdCB0byBz
d2l0Y2ggYW5kIGVuZHBvaW50DQpkZWNvZGVycywgcmVtb3ZlcyBmcm9tIHJvb3QuDQoNClJldmll
d2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg0KPiANCj4g
PiDCoMKgwqDCoMKgwqDCoMKgTlVMTCwNCj4gPiDCoH07DQo+ID4gwqANCj4gPiBAQCAtMzY0LDYg
KzM2NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlDQo+ID4gKmN4bF9kZWNvZGVyX2VuZHBv
aW50X2F0dHJzW10gPSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCZkZXZfYXR0cl9tb2RlLmF0dHIs
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCZkZXZfYXR0cl9kcGFfc2l6ZS5hdHRyLA0KPiA+IMKgwqDC
oMKgwqDCoMKgwqAmZGV2X2F0dHJfZHBhX3Jlc291cmNlLmF0dHIsDQo+ID4gK8KgwqDCoMKgwqDC
oMKgU0VUX0NYTF9SRUdJT05fQVRUUihyZWdpb24pDQo+ID4gwqDCoMKgwqDCoMKgwqDCoE5VTEws
DQo+ID4gwqB9Ow0KPiA+IMKgDQo+ID4gDQo+IA0KDQo=
