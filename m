Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8731CEB64DD
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 05:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjGMFig (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 01:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjGMFie (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 01:38:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8C1119
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 22:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689226713; x=1720762713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YCVa8y9u6KNrKzfoUABiZ/LeuuV95T0aVubWEXmmDEQ=;
  b=PsA9TvRQvmRZ+MZSQck9IcgZmeZRpLVFd03oIdkXBoSoJKUpWa/MmbKm
   t7SqYH/+Ia6DzCFMvbh5K3hJKZvYPY09T9ybkIy7XyyoFMhDnMTCU2VUW
   +VdfJ3RBleAREg6TEjBTxtz1ihu1JZMjOzbsjgikljLJDIC03UsH8Pzss
   YJEAdMytE9PB1JLHiSwrNVK4FOVwx93HM1GWBM9p++c/97nB1nymFo+ss
   N98DGvULP9xzNUlYxc2IZgZ9nGBGYhVoYl/NPlpucayBwa21DhboxcCya
   PVw3LhYbhT3g3syJfuIX7hRAb8qn04AJUBrRWmf63HVnWJFlRh7d4uVeR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367718780"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="367718780"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 22:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="757035861"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="757035861"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2023 22:38:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 22:38:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 22:38:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 22:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ20fhD322sZjuGSabp8oIv8VjbXo6eQeaxAPUi7nFEEVTgc7G4J/8oXshRm+tc4aD1foJgWcMalfKICAQdO6TDNB3u4U+6+UWzBXD6zbE4jE7f0BdO1QX8tuNXRW/M3WO4IsejKnhVveI0DxcO8GHM0qM+xoj9Ew/atl3HDzlU3sThja1ardhUQ/3aBIGVxAEGP/bPvurtvQDIxwN9aeLPdxo4Iu1wetbbHlk67z77RcZDzgmhrluT4lOJmDMowfohRzzebT+cOkj2XhooPR3giwCBXYghaLDdIMRXRYLJvoc3kMqL1kZhlWU9Y/4pzbSNzvGkTYLZwJSP5RxE9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCVa8y9u6KNrKzfoUABiZ/LeuuV95T0aVubWEXmmDEQ=;
 b=gBDewKX7IWkQZsu/CAYacaH8hT2ncnRK/FJb0ilkH2XjLqC1R8nX+VTml5qJK2tZmUXyLQrBoCZPkfX0UYm9UdhT7GCXK6HP/4DFcxDKhVEbxIWVaeJ4xgJ0ty2I7TfrEWoHfkiihnVMbRUaIOVbYfqkc9dTsvAvwCZS8cwUsB5w8CmKqawGpU0BXLaoGJdAUSjW8n5hpV58ujciHx18TZQKrMmIEs+NKmdwh+7WhsiFiX5c09TzvWY9ptdVSm94gkxOcp4sKESwyshWEP/fa9wIZmyiNDWozpUdefAm9NO2Zzn3voJy0l6WG5CM8n4FFCv4oFr53IrvRyzx4E9Pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by BN9PR11MB5468.namprd11.prod.outlook.com (2603:10b6:408:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 05:38:13 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 05:38:13 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH v2] cxl: Update MAINTAINERS
Thread-Topic: [PATCH v2] cxl: Update MAINTAINERS
Thread-Index: AQHZtSx0gCdK5kBh8EWOy+utnyAPvK+3LhQA
Date:   Thu, 13 Jul 2023 05:38:13 +0000
Message-ID: <555753d37cd1ef443dc5461a3a1d74b31fc9fe0a.camel@intel.com>
References: <168921298745.190279.14706856880354094471.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168921298745.190279.14706856880354094471.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|BN9PR11MB5468:EE_
x-ms-office365-filtering-correlation-id: ee6acf66-42b5-44ef-8fea-08db836359b2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KFqcYL/+gMRJ3SvIB6QHp54+i1lX2qvXE857oiXoLnL0dAuUMwn9q0v7Qf0jdrTRRPe11bJPdqmditLG0M2QOOwA43F9nMMafScaLcBnVC2QxX2IjwIyUtj37oiznoH6IRARW1mnA5gbU6FfVvTpiMNjrD8bFRGPMRAURrlj/GXs7wPAXQcdLeCWYy+FBpuBfE1JYboKhLgkyPL+Fq6TeCBVoQb2Y8piRX62hUl6iLkykAdUE8qpyOJAL8n+wsCj61y0pTLodihksZhzR+zGDpJ0f2kW90hDyDNJVAhgrkg8/a3lr0AfFKEDolgBtcX43mzDRMwQKMuaidsgjmZJGy+l8nZ1F56tFPrPjthRwv/1RB3+xBe64IEd4obB3neb1mAGTtFgbD1qeXY8xL0XiO6q6Fsfey1r+eAF7OmBQoGCq0mvxu0KMlt84TH8DUvSykNv7CX238RKX4Xs4LdR0/D29KCJ9RRQQATVAgLInv7jMuhZcsxQtEH3ue/kr9XD6c9G/BCEBnUFyP8vzzJrhYsmCAXG/kA8gYaODgAZIjglO5FdL0FRW/RJAggCQvzeevUXDMxNtZQLA690NYz5UUBUqiVK+KzEN7CCe+DL5zEHCS9RM+R9d+YzrcecjZPh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(110136005)(5660300002)(8676002)(64756008)(66476007)(76116006)(66946007)(66446008)(66556008)(316002)(2906002)(4326008)(8936002)(71200400001)(6512007)(54906003)(6486002)(107886003)(26005)(6506007)(186003)(83380400001)(41300700001)(2616005)(38100700002)(478600001)(122000001)(82960400001)(38070700005)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTNPT01BTW8waDEyQTdRUldNaG9WZkI5cXhjaFN0Sy9WK1hlRHNrM2MyOERC?=
 =?utf-8?B?UWYrVytCcThTSytzamZxUUc1M3psdkpwSmlaR3V2T3hKelZZeVhBNVRtYjVV?=
 =?utf-8?B?SVFZRmY4MjBlV01yd2VUV1J2bFN1bWV3L1ZpSTlYM1FzQ3gvSXBPSUNtZUtt?=
 =?utf-8?B?TmdQRkEyQWJTdmR0cEZQRVZGaHpPeGRGcEttT1d0Snpacmp3Rjh0Y1M2b29Z?=
 =?utf-8?B?ekF1NFUra3N2UkhsQTNFeGk2Rzl4TEpkWjdkMDNmVm9DMWRKTmdIMDVKbjRQ?=
 =?utf-8?B?MVF0THF6UjNGRS9CNk10OG80bjNQMHhCYXJwamdXeGhvdUw3VjFWeVNYRG5a?=
 =?utf-8?B?MEpjaGUwNWgxbGdOdS9YczdFY3p5cmtjeHpPQjdIQm1vNWNPL2xyMXkraFEr?=
 =?utf-8?B?TlZ1VktaZjBqbGFUQzBVSGhDVEFHb0hadmN3UGNSZ2dnSTlzQkIzQWhGWFh1?=
 =?utf-8?B?U3RlMmI0WHIvbXJrZ20wakNIUkt0TEFmR1BFOTd6SUJPamJwMXNpdUFtRDdS?=
 =?utf-8?B?RjVSTnZVYXJJS0dBNFdGZW1iMVh4a1d1VHpNYU0rc1NKSHd6bE4wUDRYVDZ0?=
 =?utf-8?B?R2U1bWNEbk5aeTRZRTFwclQvVmVaY2M5ZXErNFFXeUpoazFoT2FaTXB1cjBs?=
 =?utf-8?B?VE9SUzF6dXUrYkhwOXkyUjIvU240TXhkaExkTVYyNVpnMzlOYlg0VGVXd09D?=
 =?utf-8?B?OVhMVXluSCs3Yzh3UVRWcmxIUzFCZXpCRmJhT0MzNksycWxLNEltSHlhYTJ6?=
 =?utf-8?B?K3Iwd0M0TVYra2NoVUNSMlcrZGZHVnAxSzR6UlZQeDdqTURvVTNlSko4bEhN?=
 =?utf-8?B?dmZRWTNDVE9zMisvUStNRU1rRHNzdDB6eTBpNVlXT1E2TFdlamk0b25JbVo2?=
 =?utf-8?B?QUxlRy9SVTQvdDdoTmpsTmp6VFdwUzFPenhPcFQrekdOMGJWT2swUWRZTldv?=
 =?utf-8?B?Z2x4QUZrSnREQVRUUmtnNncwU3FwYUNiRUN3eW9Ydmc1dTNLbEdqRGswdXQ2?=
 =?utf-8?B?Q0UwekEzR2pMN2liSWlKZ2pwWkpTcGMvYmdWK0J0WW8ydGw0MkVEYWZ5dnZ6?=
 =?utf-8?B?ZXZ2UUZEbU1wTWJ1NEpLVjJiSFhnT3M5UmdqbXppN1haMFF0L0hpbU5TTnRQ?=
 =?utf-8?B?MENhZEhmMDhkU29jN2paMU81V3lBdHJ4SjdpOFFWQTBBeTdTUFNnZndqSmQ1?=
 =?utf-8?B?NkVjYzhNMDhsUWVuL1NwaENPWXIyZFVEaWNyVUxlK0FzY2E2RUg4WWZab2VP?=
 =?utf-8?B?WTBydkFydHVoLzB6cmxEN1hiOW1Cc1U2eGNzaFhVRWtlbXEyVzAzem45Sms4?=
 =?utf-8?B?Nk1UaUgxSDVPYzJlWE9tV0xwOXpXNzlMWFNtVkhNKzdaZjBCQVYvcDJaT0wr?=
 =?utf-8?B?MHBuQzMzVE4xMi9lcDh3WDdOQzAwdzkzVTVvK1psRDFvbzFiT09uMzhjSHNz?=
 =?utf-8?B?YVNiMEcvM2w4dzc4K29IdnZETlozUXQ1V1QxOGZzaVpBeXdaTUFlZkFYNzNP?=
 =?utf-8?B?ak0vVFpnUG1DU0h1cDdJZXY0dGh4cE1abnA2dW1OeWhYTlNNNVorUjBMak1u?=
 =?utf-8?B?TGZuVEZyVnFINHVPZEl2WFZqQklwUHlkalZ2aUtNQU9YMkRxVGJ3Ynl5QnJt?=
 =?utf-8?B?cUVXcmhGdmJvK0I0MlZ0ZjJPSzBiNUZZbU0wRHdWbGkxQy81bGRlcWllQUlH?=
 =?utf-8?B?amd6NVFDOUF5a3lhVDUxSEE5MDNrZ0VKUldMekhvZmVTZHpRcVpVRmtTUmJC?=
 =?utf-8?B?eXBrZDJVQmRxTUo4ZjJYakxyWFN3QUZ2SVFpdFpkM21OblFFV0lyak1IODY5?=
 =?utf-8?B?VWlOVHU2NE56b0FWQVB6ZWhySFhPRTA0WHlpcFQyYnZZSW42K3RDUkdtc0Vt?=
 =?utf-8?B?Uzk2SnhFT3VFOEhsbDFwajNveUVBd0VEaFdyYkVHTm9tR2VjSSttaC9uazQw?=
 =?utf-8?B?VjloN1Z0bWpkdEk4RVY4NzFpR29YeXhFLzlyZDYxNjdXUXh6Q2NNa2RwQ1N3?=
 =?utf-8?B?b2U4MHlqbFlWYWpxRnZVVDg4NzZrdmtnblYxdlRoUmI3a2V3TFMyaFllakZQ?=
 =?utf-8?B?Y05LOHJ0OHhSRVhRN2o4Z3ExVlVaQjNNbkh0VGNGdnFJUUoyVUJPa2M1dXlz?=
 =?utf-8?B?K3Z6NmRtbUY2NCtZSjZ6c3BJNHF5RUo5V2dTTFRGMmdhNzRqSVM5Z0xuWTRU?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5E75D826786F7448945A3BDAFDA607A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6acf66-42b5-44ef-8fea-08db836359b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 05:38:13.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fo5z4ssF8VJxKzOiWQSeCfZiARFG+aG9NPfQycFs9jYfAv0SyqH8rNIGPx447Zf0ND2Zh9ZueqMvf6ECYpj+xx04PSmKvisPKsAUSjLyF3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5468
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTEyIGF0IDE4OjUwIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEJlbiwgdGhhbmsgeW91IGZvciBhbGwgdGhlIHdvcmsgdG8gZ2V0IHRoZSBDWEwgc3Vic3lzdGVt
IG9mZiB0aGUgZ3JvdW5kDQo+IGFuZCBlc3RhYmxpc2hpbmcgUUVNVSBhcyBhIHBsYWNlIHdoZXJl
IGhhcmR3YXJlIHZlbmRvcnMgY2FuIGNvbGxhYm9yYXRlDQo+IG9uIHRoZSBuZXcgYWR2YW5jZW1l
bnRzIGFuZCBtZWNoYW5pc21zIGFwcGVhcmluZyBpbiB0aGUgQ1hMDQo+IHNwZWNpZmljYXRpb24u
DQo+IA0KPiBKb25hdGhhbiwgdGhhbmsgeW91IGZvciB5b3VyIGNvbnRpbnVlZCByZXZpZXcgYW5k
IGNvbGxhYm9yYXRpb24sIHlvdSBoYXZlDQo+IGJlZW4gYSBkZWZhY3RvIENYTCBtYWludGFpbmVy
IGZvciBhIHdoaWxlIG5vdy4NCj4gDQo+IERhdmlkbG9ociwgdGhhbmsgeW91IGZvciBnZXR0aW5n
IHRoZSBiYWNrZ3JvdW5kIGNvbW1hbmQgaW5mcmFzdHJ1Y3R1cmUNCj4gb2ZmIHRoZSBncm91bmQg
YW5kIHlvdXIgbGVhZGVyc2hpcCBvbiBhbmQgb2ZmIHRoZSBsaXN0cy4NCj4gDQo+IERhdmUgSmlh
bmcsIHRoYW5rIHlvdSBmb3IgeW9yIGNvbnRpbnVlZCBhdHRlbnRpb24gdG8gYWxsIHRoZQ0KPiBj
cm9zcy1zdWJzeXRlbSBwbHVtYmluZyBpc3N1ZXMgdGhhdCBDWEwgY29udGludWVzIHRvIGNyZWF0
ZS4NCj4gDQo+IENjOiBEYXZpZGxvaHIgQnVlc28gPGRhdmVAc3Rnb2xhYnMubmV0Pg0KPiBDYzog
Sm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBDYzogQmVu
IFdpZGF3c2t5IDxid2lkYXdza0BrZXJuZWwub3JnPg0KPiBDYzogQWRhbSBNYW56YW5hcmVzIDxh
Lm1hbnphbmFyZXNAc2Ftc3VuZy5jb20+DQo+IENjOiBBbGlzb24gU2Nob2ZpZWxkIDxhbGlzb24u
c2Nob2ZpZWxkQGludGVsLmNvbT4NCj4gQ2M6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFA
aW50ZWwuY29tPg0KPiBDYzogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiBDYzog
RGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IEFja2VkLWJ5OiBEYXZpZGxvaHIg
QnVlc28gPGRhdmVAc3Rnb2xhYnMubmV0Pg0KPiBBY2tlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8
am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBSZXZpZXdlZC1ieTogQWRhbSBNYW56YW5h
cmVzIDxhLm1hbnphbmFyZXNAc2Ftc3VuZy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxs
aWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZl
cm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQoNCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6
DQo+IC0gU2hvdyBEYXZlIEppYW5nIGhpcyBkdWUgYXMgd2VsbC4NCj4gDQo+IMKgTUFJTlRBSU5F
UlMgfMKgwqDCoCA0ICsrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVS
Uw0KPiBpbmRleCAzYmUxYmRmZThlY2MuLjgyZGU5OWI2YjM0MCAxMDA2NDQNCj4gLS0tIGEvTUFJ
TlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTUxNDAsMTAgKzUxNDAsMTIgQEAg
UzrCoMKgwqDCoMKgwqBNYWludGFpbmVkDQo+IMKgRjrCoMKgwqDCoMKgaW5jbHVkZS9saW51eC9j
b21waWxlcl9hdHRyaWJ1dGVzLmgNCj4gwqANCj4gwqBDT01QVVRFIEVYUFJFU1MgTElOSyAoQ1hM
KQ0KPiArTTrCoMKgwqDCoMKgRGF2aWRsb2hyIEJ1ZXNvIDxkYXZlQHN0Z29sYWJzLm5ldD4NCj4g
K006wqDCoMKgwqDCoEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNv
bT4NCj4gK006wqDCoMKgwqDCoERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KPiDC
oE06wqDCoMKgwqDCoEFsaXNvbiBTY2hvZmllbGQgPGFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29t
Pg0KPiDCoE06wqDCoMKgwqDCoFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29t
Pg0KPiDCoE06wqDCoMKgwqDCoElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4NCj4gLU06
wqDCoMKgwqDCoEJlbiBXaWRhd3NreSA8YndpZGF3c2tAa2VybmVsLm9yZz4NCj4gwqBNOsKgwqDC
oMKgwqBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gwqBMOsKgwqDC
oMKgwqBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnDQo+IMKgUzrCoMKgwqDCoMKgTWFpbnRhaW5l
ZA0KPiANCg==
