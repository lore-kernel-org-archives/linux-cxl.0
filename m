Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E9CC433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 23:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKHXrg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 18:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKHXre (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 18:47:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D3653EEC
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 15:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667951254; x=1699487254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vNCTlAxEuYxt8eDI2N5DjaRBvsFc0gBV/8DNhEKCWQk=;
  b=TGL3ymqC0o5vutFXun8k/+Ld8O/estV/OjwumCnIMFSYeQxoRwOonWo9
   wo0vXONmaWq5u3zesjNGrMvvYnHv4kmaYhtRVKJKIW84zTECaGWreSLiz
   dBdkfx+TS2+t3lyRujXfocJJdLtdDAVRt/YecPe+w7zqBTHL+p9AZqH22
   7HisyzvRN982bpc7Kucnb8H1wBq7H39c/swWwUf1+du7mDGh3FN/9Lh5l
   gsxXvuSIkYZH5JZeyl9aHS8ECMrv+w3evU7rvQ9fScCrLtz3yuJqNwctp
   HVmQKw/t0nW2xcsNiXc/XCORxsjjWWP0J1TohptIOgWedpVZpk+9qs2iL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="310835958"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="310835958"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 15:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="811418228"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="811418228"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 08 Nov 2022 15:47:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 15:47:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 15:47:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 15:47:32 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 15:47:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHV6Twk8x/31L0MkDe4+3B0fqe+q7siHq4Y0HmrF9eYLx33BHJ6G1PzE6o1EOJq/c9q5NGwPiv57SMGRAeEmQQ6xRr4yViUz8KpAQaequYfLV4WEofiye6UvBe9l9mbhMFVag7GkYp62Q8PxpI7FhRFlvOSupBQM0LaqRWXVeQfm+AlRrNJTeC6ttnNlnE1pjZgR82lGn153gVqZS8riBKeKuMo35tl9ZvFbQwKshMcb7DrTg5QV4OSYKJUGMDJqtjlx/1ZB8GKjVuQHDOQU1yiABnPIuP8ZH9nzqRHEFnUbvYdDQO11HcPlLHTjCSqK68yCmLw0aTTqX+BHooQqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNCTlAxEuYxt8eDI2N5DjaRBvsFc0gBV/8DNhEKCWQk=;
 b=DbWtZ5XHL1Hrp/A6eNrJ7MhpdID9qV6sni87Hyl73DZQj3JR79hXUS1pqg3uhdl7hHf3EGenR8LwdLx2tTvPussQezVdPcrWhq7kvgWjMj7RR9Nj9UhEjmNyFAsAJI+mM/l4hAXmK74dncCsToKXQP2Ye2KtU+dEB+M+EcZIXMohibthqouV8ct+T1RJTes+2dN4GDiTRI6D8tbu/5r54Uh5OJ7aGvyocrhKNrRhRvBV5CGp5SgWQMumSSAYFtFjJapddUlYz1Dq5SzSLNo/dmM9QuQu3mcB4/6dBY/k0cqD7CeAt/CkxhXG4yq5dNdCDBL8kkjxrwmCYuH0p/r9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Tue, 8 Nov 2022 23:47:30 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 23:47:30 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 04/10] cxl: add common function to disable event trace
Thread-Topic: [PATCH v4 04/10] cxl: add common function to disable event trace
Thread-Index: AQHY86A5mrxyFltn/0aB3Pi8+13HEa41sayA
Date:   Tue, 8 Nov 2022 23:47:30 +0000
Message-ID: <c85d3ee717b3fac27b08b6b1cb2aa8836f071cc5.camel@intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
         <166793221113.3768752.2422093575535918509.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793221113.3768752.2422093575535918509.stgit@djiang5-desk3.ch.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DS0PR11MB6374:EE_
x-ms-office365-filtering-correlation-id: 3994c837-92cf-49a1-701b-08dac1e399a8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xC525u5pLUpN9Vv8Hww2y1B4lzFvt8uXBY64jkx5jzI0FfH5fqpOkTu1gYrFHpwgwm8mGZYFuz/Gtmx/vTW0FBXo/Ajgm8RrLlrd8b5QMo22WNOoeb5KbHpGIDTx6Zt+Q0qErHUp3zXpDLaTTWsfY2wCSQmzMb8/1pQnBVBJ7R9StXPQTYm8VxCEDMluP8dslZUgRmJQMQFFRHISdTCu7YMz4wvjXdR0+LWJqOGAXabiPx/QI2DU2S7A0LR6+vR49u6+ClmXW6pFVbVjK2BV9t1gJ+2lUF51ycw/nJuypWMX12KU8nA2IH8k98KXzdaryVCLe+mzNd73MTQNUTXs3gk48C0ybcwxFPIeNWPeJdDAuJY/IVX2MjirJdQS7JUbcJgTCRb0P9+D9lsVCPeHWdc5UeXOcCdme23fZpzWI0e2N4SdBFIuQpkvstqHzByv3d15nIQ6OqmYFVm9a5O6ydnLiuZtMk3rRm4TWke4FTqbJ8oNz2mPRsqr3TIhLcI6ic3iM/kJeGnW350Tsf1NYBUdBdcBp+oFjv0cLN8Q+zN5XLTVVUvNqDoj22jPmV9c6DDl7pbImpfOtyliLzpDvQpAysa24wOvIEumoFUwxeGl2QzAU6mb0nWP1XnvxNcA/JJG2/gGYjTawCpjVgl82izBr9ghoxQIlwvy4S7v1ne8G9Xrk/P2P2d2EdcCDZerNa0kj6fksNYtisiymM8kVOaSiIe1/QAIhUqCgSBtzRXRVCPYyS1LgVQBkClPaeB38c9CTgnOfiqSaGkOjf5GdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(71200400001)(316002)(54906003)(6486002)(107886003)(110136005)(4326008)(66556008)(64756008)(76116006)(66946007)(8676002)(66446008)(86362001)(91956017)(478600001)(41300700001)(66476007)(2906002)(38100700002)(122000001)(26005)(6512007)(82960400001)(6506007)(186003)(36756003)(38070700005)(8936002)(5660300002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXdKc2NPZ282NUtSK1hnTE1ibjBMMTdCSDA0bmVaUHZycVJZQTFYUWJpeXlX?=
 =?utf-8?B?UlN1QnN1c3d4RCtoVmdnZWhKZzBITnVKOTNZdkQ5T3RFOGNKc2M4YWZqSHhU?=
 =?utf-8?B?QlBFZFFzU2NiU2VwTTl3S1ZzY0QwTGF4Z3BGaUEzb2d6MnpyM01pZkxySm9z?=
 =?utf-8?B?NzNFMlFHemJXMEhnb1J2TGh1cGFHMkRKMEUxaEIzblN2ejhiLy85cVRmazhj?=
 =?utf-8?B?VE1JdFRrdHdLdFBZRXRreHZGcjFjd1J1cDZWZ3JwMm5HUkdQM0sxTGdac1U3?=
 =?utf-8?B?OEs0TVNVUXYrZE95RHl3STBnY3VkQWNkbUtzd2JNeVlPbm9JMGFib0VsR3RH?=
 =?utf-8?B?QjFCM0t5cndpMUxUb2lRSGZIamNhVnpVSENYNkJIN3FsZ1hhV25GbUJuYWdq?=
 =?utf-8?B?T1NockxlbHZPdlFCYkQ3RFd2NFRscGQ4UXRjeWFlL1FSMldDWmswazcwVlYy?=
 =?utf-8?B?WVVPRWJOaTI1cDJ1SHk0Z25vR01CK3EwcUtIdjNyaGFxblVJUGVlVzIwYWU4?=
 =?utf-8?B?T0x2VjFuS2VhOG9jTVB0TVFvbi9TdW1oUDB0RUVqN09meVA0U21YM0FqQi9H?=
 =?utf-8?B?Ykwvc3Uyd2FmWEp0SFBiYXdReDdIVkQzYzlUMGpFQ201UkI1d1BSSEtkbkRG?=
 =?utf-8?B?eDJJWDZjbk9Jc0NyTDFPU0FsOHlkbWFlZ1Y0aWlIZlpTOGpXdUVIN2F2cmcz?=
 =?utf-8?B?UGpDTDVidDg4U1JoRzN3RmhqWVBteFFRZDc2NTB3QTkxMnN3UUxjUFVuNU01?=
 =?utf-8?B?RHYxN0RaUWdKSWRxbzdEdk9Qd285b3FzVm4zcEJDMHRKZWlhVE5ES0JnTVQw?=
 =?utf-8?B?RjhFT1RFYk03SU1QOTl1aG1ZajVRWHUvcHVyT2t1a0tSV1hnQzFsU0dyR3Bn?=
 =?utf-8?B?MnBPUUtqcWxuZ1U1Q205SS81TXRCNzg5dnZkM0hLZW5PRHM3Sm5nTXVIYnRU?=
 =?utf-8?B?dzJpcWxhSWdKMXlhc25DdVZHR0NxU3hOUFMrNitRcUx5TS9YZWtoUXVIY2NB?=
 =?utf-8?B?cDlCV3NNYmlFdEhqdEZOZCtIZTNnZURVZm5pOEZNQXJrS21GSWkyWGJFVkg2?=
 =?utf-8?B?TDhidkJ5c1JrVHd1RmJaU05Lb2MzN1E1SUlSb3JYc1JvT0lYQ1NjQ1BSclVm?=
 =?utf-8?B?V29SckkvdmYxY2Q4UmpiUE1Jb1NOeXhlNXJLSTBtdWVxVlRiWXFGUXl1QUMr?=
 =?utf-8?B?VjRSQ2RRckhwM1dVL2xZeS80N3ZHVEpLckFhcXVxUUR3cHlGZjloc0YwOVU3?=
 =?utf-8?B?SVlleHdyNHk2UUFqVGlGRHU2ckhBMFdhQWFzbDdadWdWVlVmVS9CZnlNQ3B2?=
 =?utf-8?B?ZFNiNEZ0Ymk4STFCdUpJS3JXaXRhNmFPTndLS3M4NlBsRnByQVlRdVpBZWVa?=
 =?utf-8?B?SlFMSFg2V1haTnJORXlESnRaQUtLc2lYMzRKZDZNZmdYWmxWVlIvaGtieFlK?=
 =?utf-8?B?WjZkY0l5djdIQmpLcUhaci82VFVnczJvOXlwWnNnT0ltb0psNVpvT2M2eEt5?=
 =?utf-8?B?WVo1d0hKOTRYZWJzbXBpY1pnL2xiSzF2VTUrSVR0N3dkdlNqV2pWckU1cVdy?=
 =?utf-8?B?ZjBEdHZta0pIZWRlbWwyL2dXYU9ZK2dBYjVveWVnT1JHOUlldHZWc09nS2l1?=
 =?utf-8?B?dzh2dVhMUHByNy9HdjZhVlh3czFtSlM1QlFyWEUzV09IMnpuUm05WVBHdUUz?=
 =?utf-8?B?R3lpV3VIYW1SRGs4ZFdjOEpkN1lkTTFrWnBUMExQUlkwa3dKRkRIUDJlUFpX?=
 =?utf-8?B?YlFiWVhtV0xVTktCL3VMbWwrVlByd2pTU0NxdE9iU0ZBOGtYTjBDckxBbzlz?=
 =?utf-8?B?UmM3ay80N0RlM0VaaEIyU09kU2lsZ1VLQjhSdVN2U2MxQ3c1OXlBZExkYS9T?=
 =?utf-8?B?S0RUZ2Z1akd3dFFUMXRETlVMcm1HWG1mVy9JZHhiVjBHN2p3WGNiQS96VWwr?=
 =?utf-8?B?Qm9LTUxmekRobkxjV0NtZk5oTWMxN1l6OWRZZitkLzBUQ0JJdlp1bUV3U09k?=
 =?utf-8?B?bE5zekxiaGI3UFB1WW1yZjI3c2gyeDgvTE81VWJra2VTeFhSNVovcm1qbUdK?=
 =?utf-8?B?NVUzOE5XdTZKWmY3L1FCcEhaR0FFZmtHc1dYWHh3OEVVOU5zZzJ1NW5MSWZT?=
 =?utf-8?B?MWJrekFvRXdLcFdqU05BaElCRnE3Zks0T2hDNnYzaEpCTElobXJWSElwT3Bl?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA49515654F91B4080E56847F5CC7A3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3994c837-92cf-49a1-701b-08dac1e399a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 23:47:30.5567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZsnlahuoyXHJRZ/6Ulv8BraIccQadaM0A+HS5CUt1HzcJHW1I+64a4V3G3Ryo9K0aUq4+38ek54Asm1TMGV2LnQ7qI1xS/LMOU0OdrMXbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDExOjMwIC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOg0KPiBB
ZGQgYSBjb21tb24gZnVuY3Rpb24gZm9yIGN4bCBjb21tYW5kIHRoYXQgZGlzYWJsZXMgdGhlIGV2
ZW50IHRyYWNlIGZvciB0aGUNCj4gaW5zdGFuY2UgY3JlYXRlZC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBjeGwvZXZl
bnRfdHJhY2UuYyB8wqDCoMKgIDUgKysrKysNCj4gwqBjeGwvZXZlbnRfdHJhY2UuaCB8wqDCoMKg
IDEgKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNClRoaXMgYW5kIHRo
ZSBwcmV2aW91cyBwYXRjaCBhcmUgdmVyeSBzaW9taWxhciBwcmUtcmVxdWlzaXRlIGVuYWJsaW5n
IC0NCkkgdGhpbmsgdGhleSBjYW4gYmUgc3F1YXNoZWQgaW50byBhIHNpbmdsZSBwYXRjaC4NCg0K
PiANCj4gZGlmZiAtLWdpdCBhL2N4bC9ldmVudF90cmFjZS5jIGIvY3hsL2V2ZW50X3RyYWNlLmMN
Cj4gaW5kZXggOTViMGNlMDcxMTY2Li40OTBjMzBlMWRiZmMgMTAwNjQ0DQo+IC0tLSBhL2N4bC9l
dmVudF90cmFjZS5jDQo+ICsrKyBiL2N4bC9ldmVudF90cmFjZS5jDQo+IEBAIC0yNTEsMyArMjUx
LDggQEAgaW50IGN4bF9ldmVudF90cmFjaW5nX2VuYWJsZShzdHJ1Y3QgdHJhY2Vmc19pbnN0YW5j
ZSAqaW5zdCwgY29uc3QgY2hhciAqc3lzdGVtLA0KPiDCoMKgwqDCoMKgwqDCoMKgdHJhY2Vmc190
cmFjZV9vbihpbnN0KTsNCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPiDCoH0NCj4gKw0K
PiAraW50IGN4bF9ldmVudF90cmFjaW5nX2Rpc2FibGUoc3RydWN0IHRyYWNlZnNfaW5zdGFuY2Ug
Kmluc3QpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiB0cmFjZWZzX3RyYWNlX29mZihp
bnN0KTsNCj4gK30NCj4gZGlmZiAtLWdpdCBhL2N4bC9ldmVudF90cmFjZS5oIGIvY3hsL2V2ZW50
X3RyYWNlLmgNCj4gaW5kZXggYWVjZjlhYTk2MTg3Li44OWU5OGNhZmIzMjAgMTAwNjQ0DQo+IC0t
LSBhL2N4bC9ldmVudF90cmFjZS5oDQo+ICsrKyBiL2N4bC9ldmVudF90cmFjZS5oDQo+IEBAIC0y
Miw1ICsyMiw2IEBAIHN0cnVjdCBldmVudF9jdHggew0KPiDCoGludCBjeGxfcGFyc2VfZXZlbnRz
KHN0cnVjdCB0cmFjZWZzX2luc3RhbmNlICppbnN0LCBzdHJ1Y3QgZXZlbnRfY3R4ICplY3R4KTsN
Cj4gwqBpbnQgY3hsX2V2ZW50X3RyYWNpbmdfZW5hYmxlKHN0cnVjdCB0cmFjZWZzX2luc3RhbmNl
ICppbnN0LCBjb25zdCBjaGFyICpzeXN0ZW0sDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY29uc3QgY2hhciAqZXZlbnQpOw0KPiAraW50IGN4bF9ldmVudF90cmFjaW5nX2Rpc2Fi
bGUoc3RydWN0IHRyYWNlZnNfaW5zdGFuY2UgKmluc3QpOw0KPiDCoA0KPiDCoCNlbmRpZg0KPiAN
Cj4gDQoNCg==
