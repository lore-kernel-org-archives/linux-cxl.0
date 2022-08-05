Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8D0C00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 18:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiHESxa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiHESx3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 14:53:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CF41570F
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659725608; x=1691261608;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Ll/ZzHVIt0pZdPHLpKKp5SZ/pzFgv+t+ToOJWXJdngI=;
  b=RFHaUY4c6EYpnAC8hAu5e5StSMrGOX1o2TReSDxP08RKDypTuR9+yMOW
   XYH7MWuGqJfsSVkFIjNpqoxcC2IIlyghZDAtsAShUWgaQ+689oWYznfQH
   WE7OdRUBtlM1zwkpcVxV4d20f7v5d1nDh/2L4co/PsU6QiFyUuefij2DM
   nl2sYwmyj4+k0aUrH7emdDkWmb/AJMhScWDK68YoT3s9qIl0IJfFB6HlW
   Y4HLp7zKfszKBQT0E8UzlwcAVxzNy+jPV433u5i1+YXiNNxrRIGLjTg7t
   D9UG9rOO5MVj8DfEB42DWWvZuQj7aJAWTzHQ1Du/4R8GMI42YHarKy7An
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289025085"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="289025085"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 11:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="636588622"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 05 Aug 2022 11:53:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 11:53:27 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 11:53:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 11:53:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 5 Aug 2022 11:53:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXw0oOC45twR8o482/YisHssr1k685RJRy1oV6gZUKkBVWmXlNUjIeSMg6knMY6NVEMNpD7ek2134uIRyj6/zgMRjVmGDmYJo8Xi9yVBN9zmIKzNkbMO8Jvma2k8NwVGGYJHglY0T+Aadt3pU2MqdWWIevwYU3rMhBf5v4H85noGGseIFE55CUk93BI/dhKYtH+X91VHODWoRit0cvPKQGIK7JEX7MvbRAfth8LTG1bB3fckQMSmqqSCBFgetz0XIaPIUC2TYbbhAAgyRpUCsu2JGPniN99fLjNPDLghYzu+p279lASoRRhAZzpc3TyGPT7vJj9OTf2CoawsLKsTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ll/ZzHVIt0pZdPHLpKKp5SZ/pzFgv+t+ToOJWXJdngI=;
 b=kRq7Vs31I9SdtW4GSPwUpUlJiWf2UJgG/Og17/BgnQov2ffRftJQVoFHT6wKDd0bkqwZKlLrU8ZXT5BSMzhp+Z4Qc9U+gnut5tmzkm1bJ3jGA2+6OnUo2S9ax4/6ipd6ctZ6gV8QoIu3DDAYTcTz0nkWNMhfBAoc9T+w8cZVHAgxxwSo3De4xYgIAhn6r2ffDeAvxvlF8BTp3SrTn4aQf+cUcSvxIJjFG5UcnPtw917RzYhWe28ticklwCWEBaV0lmSwnpLan6zfdsSWOIzynFA/jFenD6nifTRKVpPa0OEOHS/PYzXTwJH99cSZaSCelLuEFGOFgTgIvLap7khChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MN2PR11MB4031.namprd11.prod.outlook.com (2603:10b6:208:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 18:53:24 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4%7]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 18:53:24 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: reset the cxl endpoint decoder HPA range on
 teardown
Thread-Topic: [PATCH] cxl/region: reset the cxl endpoint decoder HPA range on
 teardown
Thread-Index: AQHYqJeICrQM7dL6nUagmTy0BdlDN62f86iAgAC0b4A=
Date:   Fri, 5 Aug 2022 18:53:24 +0000
Message-ID: <ff456afb0c3d8e7d286e38e130f32d9721e1e5ef.camel@intel.com>
References: <20220805064918.925115-1-vishal.l.verma@intel.com>
         <62eccfc72e340_151ced294d9@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62eccfc72e340_151ced294d9@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33bd47e5-5188-43e2-82c9-08da7713c697
x-ms-traffictypediagnostic: MN2PR11MB4031:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXZXm0I+LVJ8sOi/RyOCtLpUS3Wn9IVhzDCYJEmcBbf2FDS33+avm4uj8aNlcsylJlPxfphLzzVzn8+F/dHw8Fj0FFwAtCo36AJ+wm+06y/mN1dtB80YwiPAinKScec4hNogyofdK67/HRqLVNegkoggCqTV4XtEw1RBm0y0u7R7+kIbM6bG4E2NVIq0eI4t5A9/W07Mg6TQakimvdLccIKKWKMqHfbAN3kTkZ0RW7F45fu7ftV3EuOlVpvDi/DTRV/a02TkVJmFtQlQI7yCLweEMy9wtzJZKYfIkflmpRS5gvKKH5THUCaNhO5v+QsBYDq/l7sXZOqoow3+uJNs1E2zY5kIb11SIioqn7rRI1IUTpE4pXRIEAOX9TJV/HYSqVhXDlC9v4nwHUMgz1vxZxp2qwPBf3ZgqxSLFX5Nzi9f0dJvzbY4tf8TL/2GXQXpnC/FmOF1WoPHKtVs/kh0F5GIQaRDiZYCu2kajksUOSUYt7ag9AYQoSR/RVyfoXYPTBzVDhF7CtzK3ujzaal0vEUH8+nKHZAiU1pSaYA5qvrq3hsjeMfHYAulVW01CTXV36e8x7yMoYZeWpG9681TJRq9bBfbAi/Vj66AbTHMxEr3uFHyKL4CBhNe/e/jyIg8RHsxSykByirkDjgWPirVvN47c42qaoZYJ2pWjGoTPLGaG/iA8rXoALYj1VhdScc4CBA3ycsuXypdBHH6/mIawjA8O3Z9OWgp/1Kq9Uv+8zYdgQ83yzdoM0hhJpkESCc5VCAZ1FvKvjD8tdbye8NCnouudhEvFX1/6kkdDGnuU9g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(346002)(366004)(186003)(478600001)(2616005)(66476007)(91956017)(66946007)(64756008)(66446008)(76116006)(8676002)(316002)(66556008)(86362001)(82960400001)(36756003)(5660300002)(41300700001)(71200400001)(6506007)(6512007)(26005)(38100700002)(122000001)(8936002)(2906002)(38070700005)(83380400001)(110136005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjcwdThJc21MMjQvQ0V0TjlXMWM3NFM4VmtwSkIwRlNjSWwwVnNlZ3VHNkN5?=
 =?utf-8?B?MmJUZzRGUEVQWENWU1MxZlhnVC9jR1RERHdpZFZBREtGYzlHaEtwMEJaWVRl?=
 =?utf-8?B?ckxOaU5BVlN2V3FSZnhBTkNlMDJzbmVscHdPZmNWSUVEMHZuNVNGVEF6VHBh?=
 =?utf-8?B?NXArMGYrUENVWUo3c1RiVHZsQlVrZ2xQa2NxRU1JMEhKSWRFRTBsYUVKMzhj?=
 =?utf-8?B?WE5mbDFWM1ZjUFVVaDhXeEV0bGlQM3VhRmoxbmhQSFhMQzdSbS9BNlRTZHVt?=
 =?utf-8?B?V0dwVFNrck9uTjd2Qk1PM2dVZWJDSG5xaFRGREFwbEN6TDVtck1jRTIyV1Jh?=
 =?utf-8?B?bGxYTWpjcjMrTHZVL253L2hrRlZIbDhKazAyS1BqYTh5cTVxRDhwMExteWhO?=
 =?utf-8?B?RnBqeTNXeU1nelE1UmVqSG9mMWU5UU9HYndpT3JnQ3EvWnpsOEJkeHBzTjZ2?=
 =?utf-8?B?aXRDWnVNRC93RmZLa2Vqd2VqRWpVU0s1eHlzYzQvdHF0MzB6eUJ5eGhQdk5a?=
 =?utf-8?B?YkpVQ0tUSWo0THhCUDBHYjNpMWp6VlRlanlQNXhhVnVpcDBhcjJJS3dOYXpP?=
 =?utf-8?B?alhPcTdwWithRzk1aVNWQTluOTB6dzNyODVMOC9td1dSaWNKYWFtOGdUeFBT?=
 =?utf-8?B?U04xUlZiS2NvQTFTek1sV1pQZWIyRkdQa2Y1U1loVTJPZUpwdlhoY0szK3kw?=
 =?utf-8?B?QUdLYUdCR3J0QWl6KytaVitmK3RYdlJZZnFjVkk0YXcxYjNmZ2E0SVhQbS9E?=
 =?utf-8?B?LzRURDhjTVZFUEdPNGpaTXRKZjZsRWphSndCTVRLVS9SdkU1VTI3K2xmODBw?=
 =?utf-8?B?UllOTFRIakNlRTc1UUdneEs2UkswUCtHN3FDZGRGMlNaeWNiTllhMmo2UjBl?=
 =?utf-8?B?NHRxTys4ZVFjbldjYnFWTXYwekRLMDlFVE5CakgzUUJLL2FzMjVQQXVURWlh?=
 =?utf-8?B?ZTlWTGpSTTdkMlRYSGFKdHNkMHpGYjRhbDc4TDF3M3lDYzRVNEtvSDg0UFow?=
 =?utf-8?B?NW90SW9NM0piVUlVdytWYW5YUjFvZVBtWGw3ZXY0RHZoeTlYVjZLT0Z3TmJC?=
 =?utf-8?B?ODlQMTYvM3phRjZhRVFOdzJkUlQyOXd3aVdNdy9kNkQyOE11UnM1akZTWjFz?=
 =?utf-8?B?ZWlaS0kxTDg0RGJNd3pXTFd3Z1NpOTZRYXh2T01aR1BMb25pYVZYTDh1RkpH?=
 =?utf-8?B?UEZ5SlA0d04rL0RUTzdVK0FwRis0c3duaHp2Q1lpZUdFQVlrNm9VdXlEYXFq?=
 =?utf-8?B?REZFTnBseVo4dzlJbDFwcVRqM3RpKzViK1NoT01PN0RNZkFxMVdVdVVwdTdo?=
 =?utf-8?B?Yk9hdFU4U0tieERnMUJJMzlqaWQwVDFwQi9PKzBaMUNOWS9IUEdxTHpaVjVi?=
 =?utf-8?B?ZHd4WFc2ZWpZOEFsaU04Yyt3MDc1M2lEWFNNMndJWjVyc1NodDh4bWx3dm13?=
 =?utf-8?B?QUU3UlllZ2tucVJKMTFDMGhabUdVWmUwcThpU3BMNThlbWpDQm9IRTBVZURy?=
 =?utf-8?B?eXhnZm5wcWNmNkh4QnROUFhhQmFvcm5ndER3L2FlQkhHQU1CNUpSb1ppSGp4?=
 =?utf-8?B?SVVCYTc3eEpiYlJlbFgyaFMyNTFHVnlkblNVL1BuK0swSnNuUVBWbnM5OElx?=
 =?utf-8?B?bmtOTnZtdWtRR3l1MkdtOTc3dDRWUzlaK2tCK3FwVGdSNTRNSGJ0cHZKejBO?=
 =?utf-8?B?SlNkNkJYVWk5RGtjblhtcExuS1lCek9sU1dGMXZIUmQ3QlhyZnRMbVYybWtx?=
 =?utf-8?B?RVg4c2lOQzNNdWY1UGhhV2RMV3VqMWlCNjI5LzlCSlZoVjl3RnFsUmhSZUMx?=
 =?utf-8?B?azhuZG55TER3NWZaZkNPR1ZWNmlXT3NFZkdkNWR5MGIyMlJCQ2NEdkM1VnFh?=
 =?utf-8?B?c2owN0NILzNSVmhkbFlndTl4N0U1S0NqaVBvZXhuSnovUHBtT3dZM0xoTWVh?=
 =?utf-8?B?eHR3SkVmcmpnRXpRb0FjTkZRVFgvWUJDWlFNY0ZLYURGcDZwU1pVMk9rWDQ0?=
 =?utf-8?B?RXpyckZ1TEJEb2lpS0JyZXVTSFFoRHhpMnViMW5FMCszTXRJOTU3djlQa1dz?=
 =?utf-8?B?S3NwR1QwZlJ6NDVkQlNCMDduditubUNzaTZWZ2RpUEIwSkIyTnl5NGplQndu?=
 =?utf-8?B?N3ZkaGVpRXc5cldxajlaZmhsdWIrc2pvSUpmaVpIU2pHOUN6cjFLL0pMWTRm?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D27C91E419C9247AB5F44AF0DBF45B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bd47e5-5188-43e2-82c9-08da7713c697
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 18:53:24.5779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmoZ4nfpIfXZv/BhCMTc3yfjhpX0FSNwI6r0DibrUgef0Is/KBZQyFJ48USA7wv/MX/ge7DpTU03LeEtTOMnEJ/vVnwASORLZCbTJpdpHwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4031
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTA1IGF0IDAxOjA3IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFZpc2hhbCBWZXJtYSB3cm90ZToNCj4gPiBUaGUgZW5kcG9pbnQgZGVjb2RlciBIUEEgcmFuZ2Ug
Z2V0cyBzZXQgdXAgZHVyaW5nIGN4bF9yZWdpb25fYXR0YWNoLCBidXQNCj4gPiBjeGxfcmVnaW9u
X2RldGFjaCgpIG5lZ2xlY3RzIHRvIHJlc2V0IGl0IGJhY2sgdG8gYSAnZnJlZScgc3RhdGUuIEFz
IGENCj4gPiByZXN1bHQsIGEgY3JlYXRlLWRlc3Ryb3ktY3JlYXRlIGN5Y2xlIHdpdGggdGhlIHNh
bWUgcmVnaW9uIHBhcmFtZXRlcnMNCj4gPiByZXN1bHRzIGluIHRoZSBzZWNvbmQgY3JlYXRlLXJl
Z2lvbiBmYWlsaW5nIHdpdGggYW4gRUJVU1kgd2hlbiB0cnlpbmcgdG8NCj4gPiByZXNlcnZlciBE
UEEuDQo+ID4gDQo+ID4gwqAgIyBjeGwgY3JlYXRlLXJlZ2lvbiAtZCBkZWNvZGVyMy4yIC1tIG1l
bTQgLWcgMTAyNA0KPiA+IMKgIGN4bCByZWdpb246IGNyZWF0ZV9yZWdpb246IGRlY29kZXIxMS4x
OiBzZXRfZHBhX3NpemUgZmFpbGVkOiBEZXZpY2Ugb3IgcmVzb3VyY2UgYnVzeQ0KPiA+IMKgIGN4
bCByZWdpb246IGNtZF9jcmVhdGVfcmVnaW9uOiBjcmVhdGVkIDAgcmVnaW9ucw0KPiA+IA0KPiA+
IFNldCB0aGUgZW5kcG9pbnQgZGVjb2RlcidzIGhwYV9yYW5nZSB0byBbMCwgLTFdIHRvIG1hcmsg
aXQgYXMgZnJlZSBpbg0KPiA+IGN4bF9yZWdpb25fZGV0YWNoKCkuDQo+ID4gDQo+ID4gRml4ZXM6
IDI5MmJkYzZhZjhmMiAoImN4bC9yZWdpb246IE1vdmUgSFBBIHNldHVwIHRvIGN4bF9yZWdpb25f
YXR0YWNoKCkiKQ0KPiA+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVs
LmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgfCA0ICsrKysN
Cj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBIaSBEYW4s
DQo+ID4gDQo+ID4gVGhpcyBpcyBhIGZpeHVwLXRvLWEtZml4dXAsIGFuZCB0aGUgY29tbWl0IGlu
IEZpeGVzOiBpcyBvbmx5IGluDQo+ID4gJ3ByZXZpZXcnLiBGZWVsIGZyZWUgdG8gc3F1YXNoIHRo
aXMgaW50byB0aGUgb3JpZ2luYWwgZml4IGlmIHlvdSBzbw0KPiA+IHByZWZlci4NCj4gDQo+IFdp
bGwgZG8sIEkgdGhpbmsgdGhpcyBhbHNvIG5lZWRzIHRvIGtpbGwgdGhlIGN4bGRfY2xlYXJfaHBh
KCkgaGVscGVyIGFuZA0KPiBjYWxsIGluIGN4bF9kZWNvZGVyX3Jlc2V0KCkuDQo+IA0KPiA+IEFu
b3RoZXIgcXVlc3Rpb24gLSBzaG91bGQgd2UgYmUgcmVzZXR0aW5nIHRoZSBlbmRwb2ludCBkZWNv
ZGVyJ3MgbW9kZSB0bw0KPiA+IENYTF9ERUNPREVSX0RFQUQgd2hpbGUgaW4gaGVyZT8gSSBub3Rp
Y2UgdGhhdCBhIGZyZWVkIGRlY29kZXIgc3RpbGwNCj4gPiBsaXN0cyBtb2RlOnBtZW0gaW4gY3hs
LWxpc3QuDQo+IA0KPiBUaGUgREVBRCBzdGF0ZSBpcyBhIGludGVybmFsLW9ubHkgaGFjayB3aGls
ZSB0aGUgZGVjb2RlciBpcyBiZWluZyB0b3JuDQo+IGRvd24sIGl0J3Mgbm90IHZpc2libGUgdG8g
dXNlcnNwYWNlLiBQZXJoYXBzIGp1c3QgaGlkZSB0aGUgbm9uZSBzdGF0ZQ0KPiBhbmQgZGVmYXVs
dCB0aGUgbW9kZSB0byAncmFtJyB3aGVuIG5vIERQQSBpcyBhbGxvY2F0ZWQ/DQoNClllYWggdGhh
dCBzZWVtcyByZWFzb25hYmxlLg0K
