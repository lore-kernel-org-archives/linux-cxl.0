Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E82C38A02
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Oct 2022 19:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJ1TqL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJ1Tp5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Oct 2022 15:45:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B7229E60
        for <linux-cxl@vger.kernel.org>; Fri, 28 Oct 2022 12:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666986356; x=1698522356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w2bTNO/9D3gBInnBg8Ve3sErEE93rlgkZrsoMLQ1bTY=;
  b=g0moRgmwu9ISaZy8mhmn2cb4lAUL+59dqwxK3sFaAP1VgKf06NXLj9rk
   0knAZ0nqoJXO2dngOgGrQutKlhjKzUSfJuTeWt4/Q/nGZyH4v5VJ6XiVr
   7pp+hIsW6tj9otix6dXxjVWClXYiatrRLQBK1/0yODYT9axJbJnYryog/
   pQ0gd+PP2mx9dKa3HuTQqBPF2x7rDPwO15gZ3j3V0uPhvHb8wbySA1t6y
   qgnHcrg8Ngb6pPDLFz6RaHfEYLWK28oNmWYV7ZcilruQ0lTHg5Zd8jy19
   kiKdGAGYllAYzQwKQ6DvruG7b5vbZd7MqyJg59+nhh97uvloTh3VCZmRU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="372787816"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="372787816"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 12:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="758199804"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="758199804"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 28 Oct 2022 12:45:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 12:45:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 28 Oct 2022 12:45:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 28 Oct 2022 12:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz32TWfgOSkEcBSWXkQ2ALexB+0cF0u/tf1mc/z9RO0lSoVeq6zKhfM5if+me1v0eqG5X0b7M1Z1KfuqP+gI7Kn+WkyOIeEC0u6wiTAQbDomD7V4spwJ0debO2c3YhzMfNb6WssTD7aHhTNE12GaVTn5SNtlnGizughe/vEoaNNmr7vbd10oM+/Iq+0s72QY2aRK9ogFRRDiz7euOmetiTtEZHB2FZ/5baQ5jp+7sjsR9iNdpCNQiWLDEyoqoiZ8BDQAqb15JoDsxwVJ/bxvVp4oR/aENcH7dR/U9QqccU+lBxHmnXrH9Rl5ghPVsqlml0I8+bpg9XPYwqRwrgNvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2bTNO/9D3gBInnBg8Ve3sErEE93rlgkZrsoMLQ1bTY=;
 b=jZAbQ7vZaVZUNUaNaQNDPNGYBH8ShULn3ZmFMDVuDyndTe9rpkijotnpd7XASjoIFgrifx0M1U7SqvcZAE2UTZRQQ9QLr4dW98SP90YbYiKAW9bjdx/WHbDI3iqV2Iob7HwFpM/UQ5MjjYyY4x/aaG1WJ6x2LLZCpDxFu2lMmeSwNZJJEAxflrdNF1S+pw9AWydA6mNNw6xLKNn+WU2L/8yvT1qz/vCbqdt3rU3CoMaPz9LkvL1ETRTKvoZCH+FQLh7QoCDHHTWNy9y/dbeIpGu6042BUcn0Q4BDAdcTd7c2fzYKxtYDB12xTdT4hutKBLI+PoIvKzBTzbZYf9Qjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR11MB3988.namprd11.prod.outlook.com (2603:10b6:405:7c::23)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 19:45:42 +0000
Received: from BN6PR11MB3988.namprd11.prod.outlook.com
 ([fe80::c6b6:7a14:4d38:8623]) by BN6PR11MB3988.namprd11.prod.outlook.com
 ([fe80::c6b6:7a14:4d38:8623%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 19:45:42 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "d.bueso@samsung.com" <d.bueso@samsung.com>
Subject: Re: [ndctl PATCH] cxl: Fix some naming typos
Thread-Topic: [ndctl PATCH] cxl: Fix some naming typos
Thread-Index: AQHY6vcF3+3pzDpW2kC/Zp5jFYLl5K4kNcqA
Date:   Fri, 28 Oct 2022 19:45:42 +0000
Message-ID: <54c31beb1bc124f5cb2e79660d311453760fcf1e.camel@intel.com>
References: <CGME20221028175929uscas1p1c78e5cd1b684f0b9a79302b8bc769a4f@uscas1p1.samsung.com>
         <20221028175752.27879-1-fan.ni@samsung.com>
In-Reply-To: <20221028175752.27879-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB3988:EE_|CO1PR11MB4769:EE_
x-ms-office365-filtering-correlation-id: 4389a821-9fec-4f6e-e1e9-08dab91cffb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: diiY3tqDtY6DZbSuoAw3sLuoghtkdVzc63jnIHlWdNG6Wi41Vp9VH0o0s4Vu/m8/tAMblpDY0h4dC/JBFudg3Y9erpRqec7XuumgFXxC6zas4D5CmWjuKPP6IPwj6W2VCJfl3Eark8C8wRe90oSTrWwYsU0NMOB6oAiQTwlIq1CqWPr0Keuca3wgLaX77mNjLdMAcApY6uzQeiYAJyD9mHB9Gx8OGYAb/BNbAO3EmwdsVq130sT2BNUW/3ezeZnFMr8vGwSXewgCqq06S9c+X4D15vNJh7nOMZqB/tYuehMeeHhEP31yiH/taHziewZ/I61EdJN6u3w9gNt4O2uOHyp1pAlBMnRU2wOXdy4ViQE8i2UBDe/dHljlO3rLe5z9Oe/9CV3DckxC72gzGfvHQj1pAQMupouMa+f8ZaP1ox/HGPjhuWAIqfJ8vPs0IH0kV1RI+XzE53Q0H7eg31Sgg77QId6S1oT4CHQ7CHpc7No/7hugFiiKZWMo6Qudp4nUFB3XSnsKCm8A3dnLwIHlOmI4qEC6VLxW6TFXKfyVTxLQnvVbRT7T5/WLkzFZXW3rgk363SXG7bpDSOpo44qOde+SVIF6ddibqJiSn5wjqoiGZBsbJdJ35WIZjGWAWet4YzDg3KjXrmhM9pW2dQkQeDO3qFiODMPj7lQ7ZNlC4uYKM324KTfMMvCBwRQG8h21R1NrIy6LEtUOGz7+1K9hFIMkAJ/CoZDowaMq6ioYBdiXm5khrVTmP+dL0IWoTR76qyc4i09DlQ59Od5N+sUdSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3988.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(4001150100001)(316002)(110136005)(91956017)(54906003)(8936002)(5660300002)(8676002)(4326008)(2616005)(64756008)(186003)(36756003)(66946007)(66476007)(6506007)(76116006)(66446008)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(2906002)(38100700002)(6486002)(71200400001)(478600001)(38070700005)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alBDd1FzQk0wWXRJWlM1Qmo0MEVzWnFtQlVFcVBhWkxDZ0Q0bVBpdTNvUEpM?=
 =?utf-8?B?S2FWcmtTRWlXbmE2M200SXdKWnZPdEZtbHFibW82eVN0OUZhbGZXemhWMWZP?=
 =?utf-8?B?TXhncXZ6ZmtJelp4T2lLaDllK2tZWVNiZDV1OE02clR6YVZPU2JxTGdGZ3N6?=
 =?utf-8?B?UWF3Vm9NQU1YZDNVemxQVmRPNERuZmhuc0FSWGphRkVQdk0weDZuVE1sUTVI?=
 =?utf-8?B?NEF4UmEzVlNMSTh0UFJjMXZYVGdxVk13dFd6Vy9VMTc2Qk9TNHhRMFRnVEJP?=
 =?utf-8?B?ZVdySkpBMFhld3grck5RSXY2UnZJQXJKamJYTWFrRGZOZWMvUUQ3eGpUUUdv?=
 =?utf-8?B?UWNoTWt0bjVPVUVkenJFSWY5U041LyswOEg0S0hiRDdlRnZSeVluNHdLZmRS?=
 =?utf-8?B?YnMwdWkwNHpQL3hTVlpCSms2V0tJR1hlbkdOOHNHSmhIMWswSDlhdmJsRFJD?=
 =?utf-8?B?OEpTcDRWWHV0SjAzQjE3a21oU1NVZmIwV0l5ZW4vc0lxMkdYeFROdTZqQ3A1?=
 =?utf-8?B?bXQxeWlJUjFybHBRSWpYdEphZzkvZHhTZDVZdkNTdm9CR3g0eHVWSlNhbWJI?=
 =?utf-8?B?RzZvQmJxNE11V0Fkc3djRW9VbkRTMTFLZ2pFZWRqWDZ0ZEgzYjJud2ZkWEJu?=
 =?utf-8?B?Y1NvV25KR0lzZ0Fnb1N2SDVDaDBCM0FHdnhFQWt5Q3NzQ1VIUDBCVFE2OFlL?=
 =?utf-8?B?NjhJUHVOa1pnSWVvOXZoRExKNlgwMWpPT0FYZDFLM3RaUDM3K3BPVUhwZ05y?=
 =?utf-8?B?MkhWMkl3YU1xcEhtUE9RVjJuSjNyTk5ubjM1UjBqZ3JwYjFrOTZKK3I0bkV2?=
 =?utf-8?B?VWxXMmpFK0U0WnJmY0hadjNOZDF6UUpBeVZYTjE3RFFEZmRnUXg2Qm9zT0xh?=
 =?utf-8?B?TVh1TVVSaVlURHdCRGtMV0lIeHl0MThyZ2l6SWtvcGppcjZHbUd1N0czMDVU?=
 =?utf-8?B?ZStDL0N3MzRrNWRDR1pySTdpdm9LZ0J5TDU5Q2pRdkEvbTJqSFV4ZWpCYzQw?=
 =?utf-8?B?WndOc1c3YlEvdHFoN1F1M1d3bGdYS2lPbnNNU05Yek9YU01BWTVmS1Y3ZnJp?=
 =?utf-8?B?RnBsNU9PZ3dKM0p6OVJOUEI5MXhuQzJVVHNMK2Rzc0pia3NUOWNBRHZvVDR4?=
 =?utf-8?B?NHlmdnRBL25qd202TWg3dHU4cEFTb21FUVRtR2JWTExvdGVKblpmYTRJZWp1?=
 =?utf-8?B?aEttU0RwTGlueUlFamluQmxHMlZjcFYwWkVGN0grbVF3SXJJbkFCVXJrNlY4?=
 =?utf-8?B?VkdhWHBRMVJtbUdVSUNjZlVrNm4wMG9kbk5nYVJSU2xUUUl1VHhlS3V2SVdr?=
 =?utf-8?B?NTZPN1RobVZGdnRSbUZFTFBoaDRuOGFpREp3NmdCOXhDOWRpRDRubDZJRkRv?=
 =?utf-8?B?dmhJVU11dDVabXhjVjVzSXBaVnpqSDdNbHVVYVdTeDF3Q2JhVzQ5b2V6MmFl?=
 =?utf-8?B?Sy9XVkNPSExZa2R2M2s0YThaOU9SREVadnR6SVZFNmhiUFFCVUZPTExqVmtz?=
 =?utf-8?B?WnYrV290Q09PRitKQlNjZW9hY2JGakZDQTM1MWx3S2lkRFhObXJBemJqTmdm?=
 =?utf-8?B?a2dRSFZ3b2tOV2k0RWM2Vk1ZZWVZalRqdXhiOGZQMVJLS2lVK0N2MTJFYTBO?=
 =?utf-8?B?bklsTXBSU3FYUGx6OXEvZ0E5d2hmeWg0cnlaeVJ6dm1LOU9DYVUxNnlxRWR2?=
 =?utf-8?B?L2NyU2pNcTZoSVc1Rk1UTUVrRS92MVNaRDNZTlQ2alFjd2hubUlSb0Nwc2lH?=
 =?utf-8?B?SFFrMU5pWmJTUVdQUDN1K1FiM0I4d040Qk52ZGZUeHBwOWZodm4ydjRMVWNC?=
 =?utf-8?B?MlJZZ2tvK2lTUjZGSEFneDU4WG5lZENINk5IOEt4RWxsbmtRNmJwWm1zZ1J3?=
 =?utf-8?B?VXYrNzFVaTJONUQ1NWNuWFRmUXNza004TDBTcVIwa2JRMDQzakdCZDNCYnNq?=
 =?utf-8?B?b3hOc2EwQlpFV1VzcHM5QVVGSUVNRzU2cVlESkNwaEtYS3ZYTDQ1ME5SMzUr?=
 =?utf-8?B?c082U29oUExyVFZkUjZrNmxpRHplZDlXbExkSlptTnFKdVNvYmRVc2UzalIx?=
 =?utf-8?B?MjVLZE9ZNTdSRTlCK3RHdlVtVTdnelYvZStaMHA1dm5RRG9XNXRVQUNYOGZh?=
 =?utf-8?B?VkpuZFdyUkJkMk5sY1F5bHpJcHMvZ2xpc3hRWGEyQitTd3VZd3NFUFhOZ0dS?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <864458D1F042804AAA7F71E97065950D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3988.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4389a821-9fec-4f6e-e1e9-08dab91cffb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 19:45:42.6260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WP+xLcpnieE1Df0TG23dnRROsdB/rcgG3h+YU9vqlBXmMcOwHt6Wjs8dbGh7Dn2+k1sOQvewkbMzBpN69GQqU2ICpoZbD7SrbQxoAQaiqfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTI4IGF0IDE3OjU5ICswMDAwLCBGYW4gTmkgd3JvdGU6DQo+IFRoZSBm
dW5jdGlvbiBmb3IgcmV0cmlldmluZyBmaXJtd2FyZSB2ZXJzaW9uIGlzIG5hbWVkDQo+IGBjeGxf
bWVtZGV2X2dldF9maXJtd2FyZV92ZXJpc29uYCwgdXBkYXRlZCB0byBgY3hsX21lbWRldl9nZXRf
ZmlybXdhcmVfdmVyc2lvbicuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGYW4gTmkgPGZhbi5uaUBz
YW1zdW5nLmNvbT4NCj4gLS0tDQo+IMKgRG9jdW1lbnRhdGlvbi9jeGwvbGliL2xpYmN4bC50eHQg
fCAyICstDQo+IMKgY3hsL2xpYi9saWJjeGwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMiArLQ0KPiDCoGN4bC9saWIvbGliY3hsLnN5bcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAyICstDQo+IMKgY3hsL2xpYmN4bC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDIgKy0NCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCg0KSGkgRmFuLA0KDQpUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMu
IEhvd2V2ZXIgc2luY2UgdGhlIHR5cG8gaXMgaW4gYW4gZXhwb3J0ZWQgQVBJLA0Kd2UgY2FuJ3Qg
c2ltcGx5IGNoYW5nZSBpdCB0byB0aGUgcmlnaHQgc3BlbGxpbmcsIGFzIHRoYXQgd291bGQgYnJl
YWsNCmxpYnJhcnkgY29tcGF0aWJpbGl0eSwgY2F1c2UgYW4gc29uYW1lIGJ1bXAgKHdoaWNoIHdl
IHRyeSB0byBhdm9pZCkuDQoNCkEgc29sdXRpb24gd291bGQgYmUgdG8gL2FkZC8gdGhlIGZpeGVk
IHNwZWxsaW5nIHZlcnNpb24gb2YgdGhlIGFwaQ0KYWxvbmdzaWRlIHRoZSBtaXNzcGVsbGVkIG9u
ZS4gV291bGQgeW91IGxpa2UgdG8gdGFrZSBhIGNyYWNrIGF0IGRvaW5nDQp0aGF0IGluc3RlYWQ/
DQoNCk5vdGUgdGhhdCBmb3IgdGhlIG5ldyBBUEksIHRoZSBsaWJjeGwuc3ltIGFkZGl0aW9uIHdp
bGwgbmVlZCB0byBnbyBpbnRvDQphIG5ldyBzZWN0aW9uIGF0IHRoZSBib3R0b20gaW5zdGVhZCBv
ZiBhbG9uZ3NpZGUgdGhlIG9sZCBvbmUuDQoNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2N4bC9saWIvbGliY3hsLnR4dCBiL0RvY3VtZW50YXRpb24vY3hsL2xpYi9saWJjeGwudHh0
DQo+IGluZGV4IGZkMjk2MmEuLmVkYzg1MmQgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24v
Y3hsL2xpYi9saWJjeGwudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vY3hsL2xpYi9saWJjeGwu
dHh0DQo+IEBAIC02OCw3ICs2OCw3IEBAIGludCBjeGxfbWVtZGV2X2dldF9tYWpvcihzdHJ1Y3Qg
Y3hsX21lbWRldiAqbWVtZGV2KTsNCj4gwqBpbnQgY3hsX21lbWRldl9nZXRfbWlub3Ioc3RydWN0
IGN4bF9tZW1kZXYgKm1lbWRldik7DQo+IMKgdW5zaWduZWQgbG9uZyBsb25nIGN4bF9tZW1kZXZf
Z2V0X3BtZW1fc2l6ZShzdHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2KTsNCj4gwqB1bnNpZ25lZCBs
b25nIGxvbmcgY3hsX21lbWRldl9nZXRfcmFtX3NpemUoc3RydWN0IGN4bF9tZW1kZXYgKm1lbWRl
dik7DQo+IC1jb25zdCBjaGFyICpjeGxfbWVtZGV2X2dldF9maXJtd2FyZV92ZXJpc29uKHN0cnVj
dCBjeGxfbWVtZGV2ICptZW1kZXYpOw0KPiArY29uc3QgY2hhciAqY3hsX21lbWRldl9nZXRfZmly
bXdhcmVfdmVyc2lvbihzdHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2KTsNCj4gwqBzaXplX3QgY3hs
X21lbWRldl9nZXRfbGFiZWxfc2l6ZShzdHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2KTsNCj4gwqBp
bnQgY3hsX21lbWRldl9udmRpbW1fYnJpZGdlX2FjdGl2ZShzdHJ1Y3QgY3hsX21lbWRldiAqbWVt
ZGV2KTsNCj4gwqBpbnQgY3hsX21lbWRldl9nZXRfbnVtYV9ub2RlKHN0cnVjdCBjeGxfbWVtZGV2
ICptZW1kZXYpOw0KPiBkaWZmIC0tZ2l0IGEvY3hsL2xpYi9saWJjeGwuYyBiL2N4bC9saWIvbGli
Y3hsLmMNCj4gaW5kZXggZThjNWQ0NC4uYjdhZDI2MyAxMDA2NDQNCj4gLS0tIGEvY3hsL2xpYi9s
aWJjeGwuYw0KPiArKysgYi9jeGwvbGliL2xpYmN4bC5jDQo+IEBAIC0xMjYyLDcgKzEyNjIsNyBA
QCBDWExfRVhQT1JUIHVuc2lnbmVkIGxvbmcgbG9uZyBjeGxfbWVtZGV2X2dldF9yYW1fc2l6ZShz
dHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2KQ0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIG1lbWRl
di0+cmFtX3NpemU7DQo+IMKgfQ0KPiDCoA0KPiAtQ1hMX0VYUE9SVCBjb25zdCBjaGFyICpjeGxf
bWVtZGV2X2dldF9maXJtd2FyZV92ZXJpc29uKHN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYpDQo+
ICtDWExfRVhQT1JUIGNvbnN0IGNoYXIgKmN4bF9tZW1kZXZfZ2V0X2Zpcm13YXJlX3ZlcnNpb24o
c3RydWN0IGN4bF9tZW1kZXYgKm1lbWRldikNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gbWVtZGV2LT5maXJtd2FyZV92ZXJzaW9uOw0KPiDCoH0NCj4gZGlmZiAtLWdpdCBhL2N4bC9s
aWIvbGliY3hsLnN5bSBiL2N4bC9saWIvbGliY3hsLnN5bQ0KPiBpbmRleCA4YmI5MWUwLi5mZWJi
Y2E2IDEwMDY0NA0KPiAtLS0gYS9jeGwvbGliL2xpYmN4bC5zeW0NCj4gKysrIGIvY3hsL2xpYi9s
aWJjeGwuc3ltDQo+IEBAIC0xOSw3ICsxOSw3IEBAIGdsb2JhbDoNCj4gwqDCoMKgwqDCoMKgwqDC
oGN4bF9tZW1kZXZfZ2V0X2N0eDsNCj4gwqDCoMKgwqDCoMKgwqDCoGN4bF9tZW1kZXZfZ2V0X3Bt
ZW1fc2l6ZTsNCj4gwqDCoMKgwqDCoMKgwqDCoGN4bF9tZW1kZXZfZ2V0X3JhbV9zaXplOw0KPiAt
wqDCoMKgwqDCoMKgwqBjeGxfbWVtZGV2X2dldF9maXJtd2FyZV92ZXJpc29uOw0KPiArwqDCoMKg
wqDCoMKgwqBjeGxfbWVtZGV2X2dldF9maXJtd2FyZV92ZXJzaW9uOw0KPiDCoMKgwqDCoMKgwqDC
oMKgY3hsX2NtZF9nZXRfZGV2bmFtZTsNCj4gwqDCoMKgwqDCoMKgwqDCoGN4bF9jbWRfbmV3X3Jh
dzsNCj4gwqDCoMKgwqDCoMKgwqDCoGN4bF9jbWRfc2V0X2lucHV0X3BheWxvYWQ7DQo+IGRpZmYg
LS1naXQgYS9jeGwvbGliY3hsLmggYi9jeGwvbGliY3hsLmgNCj4gaW5kZXggOWZlNGU5OS4uYzNj
OTliOCAxMDA2NDQNCj4gLS0tIGEvY3hsL2xpYmN4bC5oDQo+ICsrKyBiL2N4bC9saWJjeGwuaA0K
PiBAQCAtNDcsNyArNDcsNyBAQCBpbnQgY3hsX21lbWRldl9nZXRfbWlub3Ioc3RydWN0IGN4bF9t
ZW1kZXYgKm1lbWRldik7DQo+IMKgc3RydWN0IGN4bF9jdHggKmN4bF9tZW1kZXZfZ2V0X2N0eChz
dHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2KTsNCj4gwqB1bnNpZ25lZCBsb25nIGxvbmcgY3hsX21l
bWRldl9nZXRfcG1lbV9zaXplKHN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYpOw0KPiDCoHVuc2ln
bmVkIGxvbmcgbG9uZyBjeGxfbWVtZGV2X2dldF9yYW1fc2l6ZShzdHJ1Y3QgY3hsX21lbWRldiAq
bWVtZGV2KTsNCj4gLWNvbnN0IGNoYXIgKmN4bF9tZW1kZXZfZ2V0X2Zpcm13YXJlX3Zlcmlzb24o
c3RydWN0IGN4bF9tZW1kZXYgKm1lbWRldik7DQo+ICtjb25zdCBjaGFyICpjeGxfbWVtZGV2X2dl
dF9maXJtd2FyZV92ZXJzaW9uKHN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYpOw0KPiDCoHNpemVf
dCBjeGxfbWVtZGV2X2dldF9sYWJlbF9zaXplKHN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYpOw0K
PiDCoGludCBjeGxfbWVtZGV2X2Rpc2FibGVfaW52YWxpZGF0ZShzdHJ1Y3QgY3hsX21lbWRldiAq
bWVtZGV2KTsNCj4gwqBpbnQgY3hsX21lbWRldl9lbmFibGUoc3RydWN0IGN4bF9tZW1kZXYgKm1l
bWRldik7DQoNCg==
