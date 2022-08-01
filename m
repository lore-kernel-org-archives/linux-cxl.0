Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06624C00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiHATif (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHATid (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:38:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E02B617
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659382712; x=1690918712;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=GFAJ7pgCHThsvAxQODNLjZLAN33tC5h5IUcFSgP6/N8=;
  b=Oee5eFoiV/XU5fRySTSaENBCGXDV9CvmtaILqhr2zHSCyn8BqgZhPqKa
   vudfAGd7Mv0VM7yhoD8XGIWIV6k4VXJr82b7mMyCkyPYoDonjCWtFUAEa
   S6MH4erX7lNmXnHIZTyYBcs2peIKvh7aAsBsuLGhO2/MRDcaz4g3QGof6
   x4uWt5ykKk6IXSXKGBmFYx3pQuU2kDB50MvksPouL/Rl56nRGlXInQBjo
   6jAPx+6w+YQX81m7nVduZlLvu4Cr5tKE0B0+7CiIBJL9ExT7sVku3C1gh
   9tAXpbOftrv4Hl0ZzYFqnXeZcns4TpwFBbnuyLFGsa4fMb5tTzrHikEXj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290443357"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="290443357"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="847943456"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2022 12:38:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:38:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:38:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 12:38:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 12:38:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCeTOo01/QgPnOahsdf1evjELlX1az+5Bv9L3CxIWI7euT4Nh/I2AexA+3NTcZwo9l57PZVy31wapMl6fQN7bP5t1gOT1NQrYLb73MgLleiCZ6DWB1q15XUz1Ut3+RIxt0YZKUGa9Zpp28snI1Tkx1pc/hLLxKAraWEZQ7gDFZH+A1O7Jg4Yq2ckgt4Cr65R26fqUWVao9MRQtQjxRsLcE2+xvPfEpk1xoFzkhwfGEku4isre8mixVScSmhpMLcnBktqSmr/Pg/vLf1Ow/ot80SrP57vlmbOuCi0X+dP2IdKGqFoYEjaqa6CDRf4D70DrSf20syeC6nNKDYx6g5CXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFAJ7pgCHThsvAxQODNLjZLAN33tC5h5IUcFSgP6/N8=;
 b=MzLApENc/xRGXvn+7jPjHo0qjomBcVBox0JPvkq03E1hoxiirYJtUDv4gCWAiw3X0p3CA779fiAaHwXKrT7n6gDavBV+eCNveYlqpxUrMcs9jBoAUkuwtHgZ2NslwgFiaGjw+05jRcimrSWKFl5ynMJYyu2qhoXMWE5MYiBgbmam8T19d/hH+sxb+UzSsIcjuwl9YncNJ1y99n//ZDqK8D1bfHa9RoKZ0a+j5kuuAub2734BoU8wSGHejGU47pfAimpB/nkyG/ygc4A4i9TS8JwT1YG94hOP9keApDxgO0MzWA2+yEew5Yn8psmxcEJ9EeYCpKj2P/nM/FP89K4tfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MWHPR11MB0015.namprd11.prod.outlook.com (2603:10b6:301:66::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 19:38:29 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4%7]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:38:29 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/region: Delete 'region' attribute from root
 decoders
Thread-Topic: [PATCH 2/5] cxl/region: Delete 'region' attribute from root
 decoders
Thread-Index: AQHYni9PhyQ1cNeAW0Gxm2h8Y+Ktd62agC0A
Date:   Mon, 1 Aug 2022 19:38:29 +0000
Message-ID: <919eb8198e880205b81da7090d6f0535782f0fad.camel@intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
         <165853776328.2430596.4647259305040072751.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165853776328.2430596.4647259305040072751.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 689c81d7-fa6c-40a0-483d-08da73f56950
x-ms-traffictypediagnostic: MWHPR11MB0015:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2QhssKHUYD8YD04mRE9eOa0ADiz6KbQceQHSzEE4FCes0LxhVPPYHeavrRJ8Rs6egEuvudIQW/ZuyOkuJl8ZSfk/jGITotjWIOHU7uia8VNpehGVtkcAaGIsIkxV7rdliCNoAn/0sSeW8Qg2awcISACGbPN8V+4EffzF+Xy/Q8ciHJF1TF3nb+21dk6PIGlmqcWngWHU/YpD5nkMDzBpPZkLRc1nBLMXMyQQ+jyQTntN1sf5UW5X+e6sO0rot2AcdblTpaSICOnV1PIRCNJmi2SRQSv0HP4eozlFo27JIhQ3zU7Kfwm+fNd33PWHF0t/AsizUbm2I0d9MOynrCZlsEVCHZ2UsU9pemYmf14BEof0ZnnqzoFvEAjWP+oKhzZ20mTOAggnv6xz4zPi+drGIsZgbtZtG2QNXgcxygG3w7l6c0GAS3aO7b2DxSoNzmQsevk2rWMx6TGX0AXkIoqHxUmV3x56VwOYNK7+G4MBGMjaaLp8xkIMAouU+MTev7PswVKHQ3OGRVlb+WkcPrJ6VB+9RwVqlo1F2vW45BNtA9xNYwaQxAoLSMeO2mvmR3BBJgyWPx6s+2T0SwReoKYarQm7uXjzlCndcFa51i1T+VyC9Ma6JmsPLD0ThZG9qDX0pai3ceoOCbXuOPPC03x3nxHs6AEMKwf+kpkcS5UT8tWvkBqW/KiQWBUenrt1acR+eHpL/qyjfqbwlA852BYu/by2qN27AET3dcQLCQiKqW3PTrvYqCO47cGFxQwnjJsbxm+79BD9NwDvrkVIWFMInsvfUZMr8uOVTi0E676107gxC/fgX9KjYFb00jQ6JP2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(346002)(366004)(376002)(71200400001)(66556008)(66946007)(316002)(8936002)(66446008)(64756008)(66476007)(8676002)(2906002)(38100700002)(38070700005)(82960400001)(41300700001)(76116006)(5660300002)(122000001)(91956017)(6506007)(83380400001)(478600001)(6486002)(186003)(86362001)(36756003)(26005)(6512007)(110136005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eExURTFzWU5GZ3NjUnhEYi93VngweWRoV1M3SlNwa0JMYlJDTnVmS2c4YjV4?=
 =?utf-8?B?amtQdFk0MERuc1VRamI1UHJMclhGQUpQYzhSNU1NMjVyMDRaaFdkbWRLWm9K?=
 =?utf-8?B?MHFBTnF0K2ZXTTgvTDdkaW1JM1hYQUNjNDFneVVRdWxsR2xsYnk0L0hWZ2VL?=
 =?utf-8?B?MzhDN25Ebit0SFcreVJoa0lrbUE5TjF0bnRhRzIzT2Y2TGdBOUhNb0RhZmxx?=
 =?utf-8?B?MWhIRnErVW9EMjhFYnZXRUdOZDZoU2RLMkJvZm9mQzhxUXRPR093U2R1ekRS?=
 =?utf-8?B?U3FKRm8rSWxJcGFSYXFMOS9IZ09qYXYwQ0hISU94OGs0eFBKM1p2ckN0ZW0x?=
 =?utf-8?B?bEFzeHUzVGpBbzJWTTVROVhqMjVwNXAzOVd1SFFsN2NwTmdqYVdTYXRjUzJG?=
 =?utf-8?B?dHM0ODFLY1Z2ZFVRTG9Ic29zNC9VVnJwVkVjRHNJSnRhU2kyM3RDY0FaeUtS?=
 =?utf-8?B?clI3YWFudGdab0pyOVgxL0pjMm9VYVE1T2tHRHJPK0RHWlJqRCtnNmw1NUtp?=
 =?utf-8?B?MG5EaFVIblg3RGowU2NIQUJmM21tc3dvNklaNW5vc2FQaW1GSU5yL1ZPNEww?=
 =?utf-8?B?MVZzcDNXS3VmNWtvenh3NFZwZDFIc1hCdW5icTFFOHpMYUVWYVhvNVlaRVVE?=
 =?utf-8?B?WHVlTWhwNnpabDdFazUzeGlTU0x3UUpIREQzMkdXRXI4SnVlZFpuU0xtdjV2?=
 =?utf-8?B?d1h6ZkZIc3lGTDNqUEtWWWFLSkt2VEx2dXBtM0I3Y3F3STNRN0NEWFUwK1Fx?=
 =?utf-8?B?ZHVhamhYWGJrRFNnVDlUSzA0UTJXK1VJVnErc0pWZWV0UWxCMVdpd1NPMFlV?=
 =?utf-8?B?SVlTZENRVTIwVzhnRWN0L3FiWHZDTTJpSDJlVXMwa2FRQ0pBTTAwK1FQS2JX?=
 =?utf-8?B?TnZOOVkxdWYwQ0FsWE0wdXB4U1hhWUp1SmxtV2c1T3J3OWorY0psbGRsdGdI?=
 =?utf-8?B?UzNhN2tmczZuTXlpMVNvZmNScHBHWWdSbmZvR0lFb2xLT1ZaeGRoVFNNYzZ2?=
 =?utf-8?B?K04zNGUyTjFlS0xmYWluMlF5ME5wMEl6SUlwMkUwUzhIaFdSZFhuYUhhL2Vn?=
 =?utf-8?B?Vk1nYXR3YzJoYU10STN2dU5MYjh2alVoVmYvYStsSzZPU2xnOFZTd05QUnZD?=
 =?utf-8?B?ZmxwT1FvUzJRQitFVTkwVzRiQkF3SzNxR3Q5bzhqZHNIdWxpM1NRc01TWXhB?=
 =?utf-8?B?N0VPeW90UTBPU3JheThkMlhIempORzFYK2VBMEQwRjZ2MHhBMWx2WmVyTTRN?=
 =?utf-8?B?aHB1d051UWkyOHdDZXpnUmJJOVVVQzNOVEE0MlEzekJMMyswQzVCYU12eFhu?=
 =?utf-8?B?RkcwbjNsNlVmbzFqTUl0cTdubE5Lb0tNUWc5N1ZtcFZuV3NGWDBPMUxsd05r?=
 =?utf-8?B?ZnJxTXY3YklVOG5YcnRDekdxSml0V2hLWjRuSmNMRFRRcmdGUHdNcE9GMitz?=
 =?utf-8?B?VUQwLzcwYXlRZjdtM0RYaEhqUTVvTE1RaC9zdGN0Yk9HYnN4TytIaVQvUjRG?=
 =?utf-8?B?YmVuVUFFRVhEdHh0L094UlJ1UUZjNnA4c2pJOWZlL2lkeTdvLzNmOGZnNTZi?=
 =?utf-8?B?RXNIMS9jSG5pWGZiaUYrTEswWDBvSGxNNWFzQ0txb0hiZzN4bDQ1M0c3TS9C?=
 =?utf-8?B?clVET2xLc0pxL29JcVRKcDFHQzEyN0VTSHJqVjlHdXNyNG5kcy9kMzFBditJ?=
 =?utf-8?B?c1F6eHkxb3BzVW9YeHErNzN0TG1jNWRjNnN3czB2N3RzVnJ4T2hCNXJwRVRl?=
 =?utf-8?B?cG01UnpjNUpRU0I1elhrOFlEWUFFdTdaMUZYRFZhcE5lM2o3a0hMWVgyUGlS?=
 =?utf-8?B?dFkwTlNkVkhjSEh5dkNOOERESWdNWTV6NTVzTXIvbWtubGJUQVBrME9ZQndK?=
 =?utf-8?B?LzBmYlRwa3RNdkdvUE4rNjJVdGJ2eFFQQ0ZrT1IxbEJYQjFScENubzA0V2JN?=
 =?utf-8?B?SS84ZFFEVHQxTTlBYjh3Zy9JMEh6aVZIdVAvMExsUVlrU1RmRUJHS044VXJV?=
 =?utf-8?B?allsdVRVNjE0THRhai84UVlKQWExYlJTenRBUGhqelhqTkFGbHFPYzV4UGRw?=
 =?utf-8?B?MmFiTGRmWnpoUkZCNXdxbzl4aGtHVSt6dStNeXNZY1MzSTlIb2VVZGRXa3Jj?=
 =?utf-8?B?S0VPbnpNajVMNm9mczZqWmJDOC9sbmJkdU9YWEN0UTBPVndIdERLZU5oUXFO?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9213389441B21B46864F5BEB7CA2E4E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689c81d7-fa6c-40a0-483d-08da73f56950
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 19:38:29.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00N1kNkoyZwbWvw9UJ90mU6fXSsDfDvxZlBoUSBdyei4f48oKAgtkvX0PuM+SmLgIBGay5vApeFc4Lc8F0zsEzL0PW5fiW3fjBaN4brZzeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0015
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTIyIGF0IDE3OjU2IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEZvciBzd2l0Y2ggYW5kIGVuZHBvaW50IGRlY29kZXJzIHRoZSByZWxhdGlvbnNoaXAgb2YgZGVj
b2RlcnMgdG8NCj4gcmVnaW9ucw0KPiBpcyAxOjEuIEhvd2V2ZXIsIGZvciByb290IGRlY29kZXJz
IHRoZSByZWxhdGlvbnNoaXAgaXMgMTpOLiBBbHNvLA0KPiByZWdpb25zIGFyZSBhbHJlYWR5IGNo
aWxkcmVuIG9mIHJvb3QgZGVjb2RlcnMsIHNvIHRoZSAxOk4NCj4gcmVsYXRpb25zaGlwDQo+IGlz
IG9ic2VydmVkIGJ5IHdhbGtpbmcgdGhlIGZvbGxvd2luZyBnbG9iOg0KPiANCj4gwqDCoMKgIC9z
eXMvYnVzL2N4bC9kZXZpY2VzLyRkZWNvZGVyL3JlZ2lvbioNCj4gDQo+IEhpZGUgdGhlIHZlc3Rp
Z2lhbCAncmVnaW9uJyBhdHRyaWJ1dGUgZm9yIHJvb3QgZGVjb2RlcnMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gLS0tDQo+
IMKgZHJpdmVycy9jeGwvY29yZS9wb3J0LmMgfMKgwqDCoCAzICsrLQ0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2N4bC9jb3JlL3BvcnQuYyBiL2RyaXZlcnMvY3hsL2NvcmUvcG9ydC5jDQo+IGluZGV4
IDNkMmQwMTE5Y2MzZC4uYmZmZGU4NjJkZTBiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9j
b3JlL3BvcnQuYw0KPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL3BvcnQuYw0KPiBAQCAtMjkwLDcg
KzI5MCw2IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpjeGxfZGVjb2Rlcl9iYXNlX2F0dHJz
W10NCj4gPSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAmZGV2X2F0dHJfbG9ja2VkLmF0dHIsDQo+IMKg
wqDCoMKgwqDCoMKgwqAmZGV2X2F0dHJfaW50ZXJsZWF2ZV9ncmFudWxhcml0eS5hdHRyLA0KPiDC
oMKgwqDCoMKgwqDCoMKgJmRldl9hdHRyX2ludGVybGVhdmVfd2F5cy5hdHRyLA0KPiAtwqDCoMKg
wqDCoMKgwqBTRVRfQ1hMX1JFR0lPTl9BVFRSKHJlZ2lvbikNCj4gwqDCoMKgwqDCoMKgwqDCoE5V
TEwsDQo+IMKgfTsNCj4gwqANCj4gQEAgLTM0NSw2ICszNDQsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGF0dHJpYnV0ZV9ncm91cA0KPiAqY3hsX2RlY29kZXJfcm9vdF9hdHRyaWJ1dGVfZ3JvdXBz
W10gPSB7DQo+IMKgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKmN4bF9kZWNvZGVyX3N3aXRjaF9h
dHRyc1tdID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgJmRldl9hdHRyX3RhcmdldF90eXBlLmF0dHIs
DQo+IMKgwqDCoMKgwqDCoMKgwqAmZGV2X2F0dHJfdGFyZ2V0X2xpc3QuYXR0ciwNCj4gK8KgwqDC
oMKgwqDCoMKgU0VUX0NYTF9SRUdJT05fQVRUUihyZWdpb24pDQoNClRoaXMgcGF0Y2ggcmVtb3Zl
cyB0aGUgJ3JlZ2lvbicgYXR0ciBmcm9tIHN3aXRjaCBkZWNvZGVycywgYnV0IGlzbid0IGl0DQph
bHNvIHZlc3RpZ2lhbCB1bmRlciByb290IGRlY29kZXJzPw0KDQo+IMKgwqDCoMKgwqDCoMKgwqBO
VUxMLA0KPiDCoH07DQo+IMKgDQo+IEBAIC0zNjQsNiArMzY0LDcgQEAgc3RhdGljIHN0cnVjdCBh
dHRyaWJ1dGUNCj4gKmN4bF9kZWNvZGVyX2VuZHBvaW50X2F0dHJzW10gPSB7DQo+IMKgwqDCoMKg
wqDCoMKgwqAmZGV2X2F0dHJfbW9kZS5hdHRyLA0KPiDCoMKgwqDCoMKgwqDCoMKgJmRldl9hdHRy
X2RwYV9zaXplLmF0dHIsDQo+IMKgwqDCoMKgwqDCoMKgwqAmZGV2X2F0dHJfZHBhX3Jlc291cmNl
LmF0dHIsDQo+ICvCoMKgwqDCoMKgwqDCoFNFVF9DWExfUkVHSU9OX0FUVFIocmVnaW9uKQ0KPiDC
oMKgwqDCoMKgwqDCoMKgTlVMTCwNCj4gwqB9Ow0KPiDCoA0KPiANCg0K
