Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A270BC00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiHATpv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiHATps (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:45:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEBC237C6
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659383147; x=1690919147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j4ifFzOigss4kUlpkIvWQpjr3yuLY86yPuhwUw0HjcM=;
  b=kKwgzTL0Ii4i6NMRTAHG2uukKvf+MQLhWr1B6ZKw25lv5N795PQYv2D9
   6VUn/zayLWq+dLz0+cknBOQ4KqYPMMuJp9jl9iki4jX3nePt+fbhoutKf
   YqzfQ6L65BpJpoT5d/W6dXMuPFVVCG/W0aLl4rVxuZ6hh+Q9qYc0yPYc5
   oLiVRhoci+s2l2UOzVMKJFislKs0Vj6msVELgAaPnHQv4krmpL1thvT9a
   +kPM/E2Qb8uEXlNTalEOqMvNECnrqlAdXQ62P2WmnCKkTEJvYPSfVXZtJ
   geHXzwzB+fzn3CVanecDZLu9XrYBjJvfEmYlOnphcKswNf4tSh0w0xwcm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353235555"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="353235555"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="691582786"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2022 12:45:47 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:45:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 12:45:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 12:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtWDs4qGVupF0SzW955BHImPovkhh1au71YrWBLHK4o6tToQGWfEOML9cvd/cD+J2M990aga7W7FVwIuYHV/qII36vPRgzFFUeGAuxtqzp2d+WMfrI2ibkDI/ezRu0uG/+2r5nm4pL3Zts0o1tVqVn7dCOOy7pSQG+4Fzu8lDegBrCQ2DKMIzYITXDx+JFC70nOirPARb8cZAMnuGfH6yaeIJytyobkXms9k+PfHXsSa0UCJxUkAB60ObuLZAJAKfkV+DUYkH80We4dXv3XHxxaUSObDT8wyExM6Hxjcm2v55dX3ZRyBvgcPbkQDertXIDYLBQapWyZrpHNcAiNusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4ifFzOigss4kUlpkIvWQpjr3yuLY86yPuhwUw0HjcM=;
 b=kQQDcC5z3M140eJh71LxRmoda+c8KqcfVqYFZp7KDLhULQL2H7zyiWfC9CV6xPOuoHxgpk6cwMKNDO/fobWvQG4EBage8gfMbOfbZnj0LDF7h5SsdvvpNnm2IVwhDfG0Y/x2CtlDZ8sTylqM5KmlocjN8Wgp61zaahPnAhmhiZ8b72nuSDFfyGqoF6NPZL2UU7BrQ9qvh0ZqNVJG0/qxvpSRyjagUyZhGL1uOOm9EKV0btZAlDTWhA4yzBBhTJzNLmindwYUQPzJyHnVbK96b6Nd/mKVhpRSZqI5BJEiJzKxVa/JU3lN+P6vKMO7xLk/aAqXQshPsOXwT+3AMQ61lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM6PR11MB2698.namprd11.prod.outlook.com (2603:10b6:5:cb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 19:45:44 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4%7]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:45:44 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/5] cxl/acpi: Minimize granularity for x1 interleaves
Thread-Topic: [PATCH 3/5] cxl/acpi: Minimize granularity for x1 interleaves
Thread-Index: AQHYni9Trvj2bqNLd0qeYUWtP0H4s62agjOA
Date:   Mon, 1 Aug 2022 19:45:44 +0000
Message-ID: <0db502f7dc66fdfdfeed41bb95ee13d431d909c6.camel@intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
         <165853776917.2430596.16823264262010844458.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165853776917.2430596.16823264262010844458.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2682fc0-1fe7-4e24-946a-08da73f66c8a
x-ms-traffictypediagnostic: DM6PR11MB2698:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nipzC9LyyKD8rniDdt5MSiiZTkgbIvKluB/HI8v+Mgd138mjJqpBX8XvkfGbKoAsktPiNhbtaKyFVWMySvFuCW0FKJQzhbgK+hYy3FLM3lry+FBKq+d+5ecPvifFVyKbfVtl7K4pPbd9NLd2hBCBwPykLYVZXFfOexsZ0B0bMmG/I77a2D0JtcAppUBoejyORVWMAOkpNQq+hKMk7E2QOGl6XV2EfR7qLL7zK2/SOeWuZ35vNUlCv2zaV+Jt0rS1qGSh8x6y6AMZkoMDX0RzHIvfxQFqP3mabUchHDabS/Um+BaGPFP+2ulVn3oBMYqCvsL8FHqKxhQwe0u2XYPwpny8Z177e6KUxKkAvYgQNxzitv8OsoD5rMBOdlsrqkkJb25oEIM4xGIHbbEt5egW2RH+yZaDv+AMlSjQOJH++fJ3il8NrHjfOeoFxBvFCgzS4mxSxSniJBFTriZzQdfsN/lpjXEoYHHaOkvdStavfWOlqRrQfxGex/wM+t6l7GnB18YAr8ZIPz8ttk1uRoyNKaPEUN9yJ2y963wIa98w8IKRX1/iVxON23or1ANibbg5Mf5vc5b9xTgAbkCI8DdyC12sJ+d7mnff+9dNpCeGvKyIyAoty0zAHQpUXeMlmUGwZViVHJPcrlgNvnxUngDw1HaqVvk0i5jM21UpcrBEmR9SGY96SyiHC/wVGOIPz883wtOzIeNEgxYrPxYj25VwxGNeN4jb2BgYmUmHJCU4q1APh0UenH/a3nklsias2Tb14k/MJuoHNM3dCzzM6f2+RlNr/WYbKH4eW1aR2fGLokJyzqgv1se9EcPe1uQNx3Nj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(376002)(396003)(346002)(38100700002)(38070700005)(86362001)(82960400001)(71200400001)(41300700001)(6486002)(478600001)(110136005)(186003)(2616005)(316002)(8936002)(4326008)(6512007)(6506007)(5660300002)(26005)(122000001)(2906002)(91956017)(66446008)(64756008)(66476007)(66556008)(8676002)(66946007)(36756003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzFOUEFwOUwzRXd1eTNINC90RWNCUFV2WU8xVTlnZHpmcTdGUkZRZnVUanBQ?=
 =?utf-8?B?ZngrRHdEZTBVUWFhbjNEWVFvS2JndHdNWmhabHBVL3dwMTJvVVkyV1c5K3lL?=
 =?utf-8?B?ZUlvejV5L0xYc0RIdzRnd1JIM3FpdFJSS21XV2FXM1BiV3U0dytnRUNXUnNu?=
 =?utf-8?B?ckhpb29QbkhDYmt4Z0tGOUdLMTJ5VXdqTzFqWVpucWNpVG9aaWdHYWYzM3Rl?=
 =?utf-8?B?VzcxOFl4cEJlRVR4NEp2QmpxcFBuc05ZUWtlWG4wRUZQR0hUNDZsSEZ1bjBH?=
 =?utf-8?B?OXAvUjVPTS81V0N2MXI5eFhtUEUrY1NQbXFpWnVZV0RKWiswR0hZSUp0QjFT?=
 =?utf-8?B?K0hpRUhldkZMZWI4SmlMMldndndPbTF5WjJRQnBIay9oeTV0bUhmRWFDYjFH?=
 =?utf-8?B?N1RkSmJvRWNHV0RibGczNjFBa1kzQzliZnFGd1IzQjAzTWxLcTVkOUJ2SXVY?=
 =?utf-8?B?TUdoWXhISUZZNzF1cVpjSGlHOGJtZUhFdnR0REFQam9IcTZzNXJHV25WVXZL?=
 =?utf-8?B?Wm5RYTd4aWJJdTlPU1lKOEFuQkNzZTlXcUlFUFdkRUxwZVBCWW1HRWkreDdC?=
 =?utf-8?B?OVJBd2FqbWUxeEh6RS9lSTh3aGNhVXBLYjgzdFpHRnk4MU1sQ3FrSVlHMDhC?=
 =?utf-8?B?alU0THVjbDArR1NjQWEybFpQKzI1cXlYaE9TYnJPbGxEQStLTGx0VjlUK3NK?=
 =?utf-8?B?cjB2dCtSV1Q4OWc0Y2JYNXl0ZGJFUndpbHprc1NyS3dIaFNEd2FoRmg4SXR1?=
 =?utf-8?B?ay9Bc1ZwWnQyYXdzUzlVS3dBWGwrTWZuS0xBcWxhbVdic1dYZStKUUZpVHRY?=
 =?utf-8?B?bE1UeHZqZkczejBLNmg1LzRFUUR4Mmk4U3g0djNtOE9ReTNxMnlvUkhZdGg1?=
 =?utf-8?B?QWF5QTU0eWN1Q0F3NEtFSmo3dTVETTV3cWZzUUZURFU2eHlTZUc1UTFSbzYx?=
 =?utf-8?B?OGwyTWFtUjA5ZTRqdEtXQktaYTlRdjU1YnVPdDJzeThlYXJQSk9KSUJnUmow?=
 =?utf-8?B?bVpRRlFMcDd1TFlYNEtsYVZmTGt4MlovRjZyUFFLdm93bWNtWm9hZHVjUkFX?=
 =?utf-8?B?UG5wNW5HZXQ5K0dTY3JodnE3T1pwdkhuWlFsYk45Q1lsc1dkaUNOWTU5R1cv?=
 =?utf-8?B?M25DT0R6QnQycFVhZmV0am03a0FmK29aQW5jNSttTzEyVFRtRW9jY2dMR0U2?=
 =?utf-8?B?ajVlSDdXbzA0V3dWdjAxbU94NUVjOWdiYXF6WkRIdktJL1c5RHBkdU44Ly9r?=
 =?utf-8?B?T25raEJna05SM1paNlNRMnovVzIrUnRaWExZTlJQOUVsR0Mzam95TGhFb1lM?=
 =?utf-8?B?b3pPZUJuZk1OT1JhWGJQRDl5RFlKQ3JIZE0xOTZ3amorcnpjcjBaMnFObG1w?=
 =?utf-8?B?aHp3alZGZkZjMFI4eGQ1M2lyYU50UnpzOXdTYlZCcmgyZFJlUFJKTy9md2tj?=
 =?utf-8?B?d01aMmlFaVNwQmNld2lrV3JYbFpEcjlZdlhmS3VQUDIwbGVWVnhmbFlDVW5w?=
 =?utf-8?B?THlYeWlHR3F2SDNUczhwbkxDeXRhUmtpdlZML2dJK0xuL09KTHVkbGMwNTFZ?=
 =?utf-8?B?L1kwcHgrbHI3NXVZSHVsZi9ZbWdreEdTTWdKZHRGRm83aFhyOVpGbVl4UDhm?=
 =?utf-8?B?MzR1ekd1RjZKSXdMajhmQ2JhcG9MMDErKzBvOXVMR2trd3RqT1lKMUtVSmdh?=
 =?utf-8?B?VFhJRG55ZkV1RjNqNVNrR0FGRTdmTWhjNnFBR3g4MXVuZmU2UEFubFl3NFJn?=
 =?utf-8?B?TVRLbmVvTytvaC9waDV6OWpEN3oydmRnL096bTdHVkRGczdkTWFCTEhxVFU2?=
 =?utf-8?B?bHRoRGRqN1pjY0xEekZBeHBta1Zaa1dadzRVNEliYWU5S0FXaUdYYlhjdFZK?=
 =?utf-8?B?NzZLTGdUdXhDRUdOYytuZTNrbzNoUmN5bHdCMkw2VGJ1anBuei9naU5jc3dO?=
 =?utf-8?B?cWNieDd2ejJuRE9rUzlhdk83aWF1T212VmlqL3VPMzAwYnpodVpCKy9xK1lt?=
 =?utf-8?B?T2VzWmMxUXhXaVJ1Qmo1OTArb296eENEUWN3ekx3RjNOdXNITDlmYXF0L3U5?=
 =?utf-8?B?eGhGWjJvNWN0K3hXV0c4V1B6Vmx6WncyeE9YZldDNGJ4Y2JHNjM1WTRBWTNL?=
 =?utf-8?B?K24zR2FJY3MydVM2Z2tBV3UyUFZxcStRSC82dWpzdWZhVTVtbXNSa00vc0ll?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5DBAF1B361BD8478C325E560970BFBF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2682fc0-1fe7-4e24-946a-08da73f66c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 19:45:44.6204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3xupVJsiqxHkFa4d5EtaLAOC8tgigi5Sf4EXoBdihYlxZHXTb7zqzoeCuBoxLevcpmpLdDUoyI/x7ZNljafY5U1yhJRYQY4YX/AuVISK/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2698
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTIyIGF0IDE3OjU2IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFRoZSBrZXJuZWwgZW5mb3JjZXMgdGhhdCByZWdpb24gZ3JhbnVsYXJpdHkgaXMgPj0gdG8gdGhl
IHRvcC1sZXZlbA0KPiBpbnRlcmxlYXZlLWdyYW51bGFyaXR5IGZvciB0aGUgZ2l2ZW4gQ1hMIHdp
bmRvdy4gSG93ZXZlciwgd2hlbiB0aGUgQ1hMDQo+IHdpbmRvdyBpbnRlcmxlYXZlIGlzIHgxLCBp
LmUuIG5vbi1pbnRlcmxlYXZlZCBhdCB0aGUgaG9zdCBicmlkZ2UgbGV2ZWwsDQo+IHRoZW4gdGhl
IHNwZWNpZmllZCBncmFudWxhcml0eSBkb2VzIG5vdCBtYXR0ZXIuIE92ZXJyaWRlIHRoZSB3aW5k
b3cNCj4gc3BlY2lmaWVkIGdyYW51bGFyaXR5IHRvIHRoZSBDWEwgbWluaW11bSBzbyB0aGF0IGFu
eSB2YWxpZCByZWdpb24NCj4gZ3JhbnVsYXJpdHkgaXMgPj0gdG8gdGhlIHJvb3QgZ3JhbnVsYXJp
dHkuDQo+IA0KPiBSZXBvcnRlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJv
bkBodWF3ZWkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9jeGwvYWNwaS5jIHzCoMKgwqAgNiAr
KysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jeGwvYWNwaS5jIGIvZHJpdmVycy9jeGwvYWNwaS5jDQo+IGluZGV4IGVi
NDM2MjY4YjkyYy4uNjcxMzdlMTdiOGM5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9hY3Bp
LmMNCj4gKysrIGIvZHJpdmVycy9jeGwvYWNwaS5jDQo+IEBAIC0xNDAsNiArMTQwLDEyIEBAIHN0
YXRpYyBpbnQgY3hsX3BhcnNlX2NmbXdzKHVuaW9uIGFjcGlfc3VidGFibGVfaGVhZGVycyAqaGVh
ZGVyLCB2b2lkICphcmcsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmVuZCA9
IHJlcy0+ZW5kLA0KPiDCoMKgwqDCoMKgwqDCoMKgfTsNCj4gwqDCoMKgwqDCoMKgwqDCoGN4bGQt
PmludGVybGVhdmVfd2F5cyA9IHdheXM7DQo+ICvCoMKgwqDCoMKgwqDCoC8qDQo+ICvCoMKgwqDC
oMKgwqDCoCAqIE1pbmltaXplIHRoZSB4MSBncmFudWxhcml0eSB0byBhZHZlcnRpc2Ugc3VwcG9y
dCBmb3IgYW55DQo+ICvCoMKgwqDCoMKgwqDCoCAqIHZhbGlkIHJlZ2lvbiBncmFudWxhcml0eQ0K
PiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHdheXMgPT0gMSkNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlnID0gMjU2Ow0KDQpQcm9iYWJseSBub3Qg
c3VwZXIgY3JpdGljYWwsIGJ1dCBzaG91bGQgdGhpcyBiZSBhICNkZWZpbmUgc29tZXdoZXJlPw0K
DQpSZWdhcmRsZXNzLA0KDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJt
YUBpbnRlbC5jb20+DQoNCj4gwqDCoMKgwqDCoMKgwqDCoGN4bGQtPmludGVybGVhdmVfZ3JhbnVs
YXJpdHkgPSBpZzsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoHJjID0gY3hsX2RlY29kZXJfYWRk
KGN4bGQsIHRhcmdldF9tYXApOw0KPiANCg0K
