Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143B1F5FE
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GayS5Fbs"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2964AAD
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696612831; x=1728148831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hw1MXL9MbWqSO9WGGXFKvJz2kNtZuxYPHrbniK6iysY=;
  b=GayS5Fbshnk1/HSXGpo5PDPJVOEfcNS2jvAZOBOwBGSimlwnKK958pkS
   tk9288NTYigFAhhQKwq7lmD5y9ZpwDihSdgfIaI7MtdU5ULfKCiuyofmu
   Z/DdNLoxSpSuI4nFPNcPOwyt9VxOcIvWgJJpTLWXHLbFV7G7LR5IW0NmO
   gQ37di85wnGP8cpiiNG0uL1FV3g/mqwWcAMSj59/fZ10oosKaTijU6Gqy
   2gEpK0PvB6RcTmAOYT7TGwL1qk8p+qzgHpv6qnL+0TpjQIygguWsgzJAm
   pmKafkN8wTXiCaJmGOCI3OsZ/2/1jwZnFni92qNNnNtxxbKXY4tk4ZlFS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="470057956"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="470057956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:19:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="752248813"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="752248813"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 10:19:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 10:19:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 10:19:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 10:19:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWGdCS4SOgnvL07MeEfzOOIXZQLpC9fOiKEIfZl55H66lhAStHbmhhuobnufFrFD+ZwgajTAJ9YIlV70TG2jbuy8spUzVsFjLoSlNATw/DfD14XqmKxKt7xoz3+YqSvcB4WzXkdVkUfIH5cPP2z6/6iNnWBI8WUOwU7xXnkySf2+XSqJGybfVEvZ3GBR1BiUssUSjjaJ84VAnDkv/c5jk8WVEEtq83P6lTQsCEtx9CX/uFs2y/Z0vRFBsQDURolgLU7znOmJQljyEWX0LyG2mLpH+NhmQ4PFx+SQUR0ECFIWh93UUtnABt/YxG6miUAZGEkRtj0O9e+rSmIKgjIlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw1MXL9MbWqSO9WGGXFKvJz2kNtZuxYPHrbniK6iysY=;
 b=k+J/NJ3t1qyqSEMzW7OusfyBGsQKSaKA2N587/ybMe6JXiWwBbtS67iRqHl+NMS2rw/1rybuSRDSQFDR8cw+4oy18QBkkaCMUwHlyfeRIzDpkdaFqGrwBH8qBC106e0RiwnEcP/IDaW6DgAnv2y0ZMYEPr0R2Os3Csl8MCvHGF2Zs8j7mYoqli05gb3b9Y/cf7arcSd/triANyu/OtOR7FeCwDpRlbJtqKCus6/3uEJo80bgt4fF7lfp64Ce/xQH246bYk2x3vXiwNNHk1Mi2l8dchbPog0s3ls2A0NJYZkzdgRPBkCidAANDN6hN20Swq8SQDjBSvIKzOOfbO1rnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SJ0PR11MB5151.namprd11.prod.outlook.com (2603:10b6:a03:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Fri, 6 Oct
 2023 17:19:37 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827%3]) with mapi id 15.20.6813.041; Fri, 6 Oct 2023
 17:19:37 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH ndctl] libcxl: don't calculate max_available_extent when
 start == ULLONG_MAX
Thread-Topic: [PATCH ndctl] libcxl: don't calculate max_available_extent when
 start == ULLONG_MAX
Thread-Index: AQHZ+HcNJ3f5Nhx0J0CNVMPUROcjHLA9dDSA//+Na4A=
Date: Fri, 6 Oct 2023 17:19:37 +0000
Message-ID: <e3094bd2d95ba71025c47dcbb8ad7e51a6861c65.camel@intel.com>
References: <CGME20231006170340uscas1p1cb7a65c371984266b3fe06ffce9d7d55@uscas1p1.samsung.com>
	 <169661181914.694957.3925873284580708486.stgit@bgt-140510-bm03.eng.stellus.in>
	 <7E451734-01DA-4B90-B9C9-18FF21D3B7CB@ssi.samsung.com>
In-Reply-To: <7E451734-01DA-4B90-B9C9-18FF21D3B7CB@ssi.samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SJ0PR11MB5151:EE_
x-ms-office365-filtering-correlation-id: 7a42463d-b0cc-4149-2464-08dbc6906af5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gNoTq85KgQd1CGXiCncaWetEX+g2KE2c+s503ks9hi1y0VCDeDLR69lQDHufXQC82E3AdzNGkigvRT7+1KjyaqwtR4bEej/qHubzY08dk5cjPD/Kz+qSArg5ReiXo/YA2VeQ4jyznDNTy/CcmhXKbWMcoYQnCUjSgroW5gZ9m4RDYzrP+RIA44w8LudlX+3HwDoH9sm+X6wL/zwbD8umw/r3OhbXyA26daxtb6w5UvFIs3Dedpv/g+t22ZztrZ8hGNvz5EksTvEz99E2HOILQCwg7domxnLrN9GyCNeiWAPhiPi5236H5eAhupdMbEWCciU7WbHCM7kzEp4jQEzKP7M8zDg2GwQXBf4acts1UP6ADrzN4Q3G2x3EHvwhUqqoxkWW9xbEVHiy0bwLUKqpHqjqchkfv0oi4OkeAe+il6hAMQxgCrv+fXLJr6pQYqp35hJgJhwl5nucDkp6Pougyr0RDK6u3q7Buo1oPP7rhkeb9EnHhpofxAM8+iLtMa0Ww084T0Lmh+w4DKrKQKwi0boAZMlggY6LRsKuCLYz2oUF2XjZFWaS3MbxMoY+Wmi5QniZGKKiNGVR7AKw6dTqT7QtqlXg01kFA7XJqvL0Zl4DEPy9cGSigblfBUaylw+v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(6506007)(6486002)(478600001)(26005)(71200400001)(2616005)(4744005)(2906002)(316002)(6916009)(64756008)(66446008)(66476007)(76116006)(4326008)(8936002)(66946007)(8676002)(5660300002)(41300700001)(36756003)(66556008)(38100700002)(38070700005)(86362001)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1NIbTdqc0VxU3Nrb256UTBkQ2JiOGhwV2NLV0FXeVhUQ0g2VkhhTUxOaFU0?=
 =?utf-8?B?OXYrM0xBbWdFT3hza0FsSWdTYmRkd1ZvcEY2ZWRtM2F6MTlyc0J3Rm5ubER5?=
 =?utf-8?B?M2FWRUhoenpxS0hrUTlhcDM3Q0FVS2lmSnZhay8yenlvd2pIY1FWcnYvd2V1?=
 =?utf-8?B?czVjbFVlK1ozY0JWazFHRUxteWNCVmRmTG5sdHo1QWI5WHV0dDBTeFJGbWRp?=
 =?utf-8?B?em9oWWVaWlFsMXArVG9GQ3cyNHFsZFo0bkNFQVk1SnhpTXZCbktCek9CM2R0?=
 =?utf-8?B?ck45UWlSYmFiWlJ6a2tFM2ptRWl2NnBwZko1dUdhTnNCSTg3UU14YnFwZDNw?=
 =?utf-8?B?d3VFSHVNUWdkdVFxVlNiblpQVE56bXdHbWdyS2tmT2lhVXAvTEd5U3hkOGxQ?=
 =?utf-8?B?NTM1V2d3TUxnR2xYcmtxeEtwZ1hXaGVjbVZBU0UwSVVzYkR3ZW02TXdzZmU0?=
 =?utf-8?B?OFdXNnBqcGk0TlJ5U29xZkdISDZDOCt4LzB0WU91N1FWZWRwdWJkeUVvM0VC?=
 =?utf-8?B?cmRwMFJneWRlck9FekhtVjltLzdzKzUzWEp4MjFxdEZjbnFlVDRmbGcxU01v?=
 =?utf-8?B?M0RSUWwrR3EzVExkRzhFV3NSK2lhVWVyVFJKUUlTZjVDckVQMFhXTndFUkVy?=
 =?utf-8?B?MlEybGhPb0srSytjd3VSTi9kZDNPYVptM1BIK3JteWdOUjIrOHZMTXYwOFNM?=
 =?utf-8?B?QWp3ekhuNmM5dnlZVlU1V0xPajZMNTAvRDZsUGtiTTk4YnNDRWxQYUMxR3U3?=
 =?utf-8?B?QlMzamZ1Q2s0dkV2TWs0Qlh3NkorSmMxM3R5UzZQZW5oRXNCMHo4dTNZL1Ft?=
 =?utf-8?B?aWttaU5qNlQ0bHJ0VUdJYzEwcWFUbHVlOHdtMEdUbHI0RTVHalB5QzlsUlJt?=
 =?utf-8?B?NXBHY3gyNEljTkxwRElsaWV4dW5XdFNVbE5mT2p2VUl2MVBTalo0b05DRVJC?=
 =?utf-8?B?YisyVHRVLzFlM2JYQXBPcTl0UUhpQ1F0cm83N3VVd0U2NmkwTDZhdy9ERUk3?=
 =?utf-8?B?VmZOVVNUcnUyYkhTU25Wc2xrMW1SMWN3b05NZmRPV0FBWkd4ekZZR0FXOXd2?=
 =?utf-8?B?ZWh0SzBkRG9xT2t2UDIwRnpEai9VaElVcUsvVjNGd0VpS2VTbXNvSlBHTHFN?=
 =?utf-8?B?Q2E1aEFNRG5McEp5eVZzeE1ONVBrVGZvd2oybk5XWExKU3JTVm5ydC9jM3hM?=
 =?utf-8?B?Rm9WcWZhMTJrZGwyaWFZTFIrSlRFUmJZOGJjc1YzMUY5VFdzUzFtd29WMXNW?=
 =?utf-8?B?QVc0K05yM0dQaWw2cTVtRlREYmdZbHEyU3NicG04RkxUMjlOOEJWZEY2RGp1?=
 =?utf-8?B?UUJUejhrSWRuQTloMElKOU8yYk8zUnhxdWRFQUZhajFBRDRDY0lwTEpnVWJO?=
 =?utf-8?B?MXVQQ0JGVkJ0YTBlTmFSSHY4NVNkVVgxMk9WeTc3ZWUycytOUkpPUjdTcEVR?=
 =?utf-8?B?eGNVSmhqVWtSRjFpK0VtYmF5NmtEUUNNTlBTSzFxQURIZ1dQQlJQRVZVV0sx?=
 =?utf-8?B?SmVUMHJ5R3ZLbTlnSDljYlpkVDRxMFZUcmZ1SFJER3JkeHJqbWd6eTVjVVFx?=
 =?utf-8?B?RjFWVk1hRlFCMzBFWVl3K2VPQlFaYTF4OUhUT3R6N1p0Z2RJZjlnSVpGOWVM?=
 =?utf-8?B?U0EvL3hydE14MG1yRXlTVHJOV0RUL1E5WFNSMDFIa1FlVEpabCthWVhQazVK?=
 =?utf-8?B?Z1UxcUVvQXNPbXlpTDJKOURBZ2NMNWxNYVdDbmFLU2FZZWd2YjQva0NvUjBR?=
 =?utf-8?B?b0o5NWt0ZlBIRTQwRWdlVFUwRTYrZmRWNWRhM0RRbmNLVHljVzJla1BYNHcw?=
 =?utf-8?B?TmY4MmpucGNtQVRVUkN6cEN5TC8rZU9KN0Q0YkVkVFFKQmp1bXVMNGVxS09i?=
 =?utf-8?B?V2FEVW53cE5JZ29Obm1vSFdXZmt2Rnhrc2pHTFFJeWtRWVMyUXZUWVBXd3VZ?=
 =?utf-8?B?bVR5aENlTVZZMXJoUXcwZUd4Y1dVTitOa0pDQlE2cGdNTDZha3pPR3NRRm5l?=
 =?utf-8?B?czhtVktKa1RyeUsxMmxCWm4xZnVrOURYMGRQTG1GMitBY1hZak95VTdoQ3lQ?=
 =?utf-8?B?YituYjlKZkprdTVEVHV3cThraHlJajN4a3Z4M2ZISEF2a1NsOVFDTHZOdnpU?=
 =?utf-8?B?YlNNYjFCRXE3ZjlwdG1GT1Q1b3ZSa0NCRGs0WjFxNEVFTnVOOTVKcW1RbGZM?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B11F8B8EB0008459016EFF3151A2AE9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a42463d-b0cc-4149-2464-08dbc6906af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 17:19:37.4633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yT1iZbbHGW62PCKRDKEbuW1QWFR6FbEJBb67r+o7bbIJqW8btQaEl528mlzWeoB0oJCMlB9Y6jVelANQjR8rQwOgKTVdqq6NkycCmdAcLEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gRnJpLCAyMDIzLTEwLTA2IGF0IDE3OjA5ICswMDAwLCBKaW0gSGFycmlzIHdyb3RlOg0KPiBJ
IHNlZSBJIHNob3VsZCBoYXZlIHNlbnQg4oCcbmRjdGwiIGFzIGEgcHJlZml4IGluc3RlYWQgb2Yg
dmVyc2lvbi4gTGV0IG1lIGtub3cgaWYNCj4gYSBzaG91bGQgc2VuZCBhIHYyIHdpdGggdGhlIGNv
cnJlY3RlZCwgb3RoZXJ3aXNlIEnigJlsbCB1c2UgdGhlIHByZWZpeCBuZXh0IHRpbWUNCj4gYXJv
dW5kLg0KDQpIaSBKaW0sDQoNCk5vIHdvcnJpZXMsIGFuZCBubyBuZWVkIGZvciBhIHJlc2VuZCAt
IGluIGZhY3QgYjQtc2VuZCdzIHByZWZpeA0KaGFuZGxpbmcgYWxzbyBkb2VzIHRoZSBzYW1lIHRo
aW5nIC0gIlBBVENIIG5kY3RsIi4gSW4gcHJlLWI0IGRheXMNCiJuZGN0bCBQQVRDSCIgd2FzIGlu
ZGVlZCB0aGUgbm9ybSwgYnV0IEknZCByYXRoZXIgdXNlIGI0IGFuZCBsaXZlIHdpdGgNCnRoZSBm
b3JtZXIsIHNvIHRoaXMgaXMgY29tcGxldGVseSBmaW5lIQ0K
