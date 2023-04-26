Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E005C77B78
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Apr 2023 18:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjDZSTo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Apr 2023 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjDZSTm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Apr 2023 14:19:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2D883CA
        for <linux-cxl@vger.kernel.org>; Wed, 26 Apr 2023 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682533182; x=1714069182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ixHb/FhJbBT3SKeXhIcjLBsEs5EMRxNw5dWi6Kgb53g=;
  b=UjiMARwFJNrjrYJi7QQhpiUWmxhXVdztyWyGvxqH8+xufxvgyq9k6XeK
   +UttC/1d1zuZc8NUm6bCnnBKfcg6x/fJj0QcWRYxKgU4o4yyDpVwXgbLU
   soRdEYeeaSc5uLovHnls268PWSA2wa6iZIj5/4Y74U9W058+KMoOwFBu4
   oPewxYWn1YIqn00b8c5zbjV7bvxJ64I7zz8p0yY1lcVCuXta5nAjuzutR
   b4r+KiIWodr6ckh0fzRc62dcFpPMbSlQL6kRhW6EMBPl5+saXy1EC7+td
   ao27KeihOJyO6F4fMriBs7qHU4eaj41g3JwIaBTYWMHjvr28Q7ZKcZnKA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="433484011"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="433484011"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 11:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="783428551"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="783428551"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2023 11:19:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 11:19:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 11:19:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 11:19:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHAEVdcrQDipVucTxKzdESjcmqZ3LlxkVIq0AGvX99eB+9LniojOvMp0KFPBUq7QE6q09dWqzf95SXHtKynomTQ1taChrsnj9sLvLBzBTiKiccgL9fLoxAf0t8+l1oMeH5neYAOCm4N793rCAEFzd8KX+b1eJ3af+Zj5KFrCcgAG8Y/2vg9E53B7ZNVFbx34SYnhG6HaW/pXVgK5bYmzfPZgPRg8mbXaw/Njj/0fdDU/EtgYXwFgQ7M/gvyEdOZOB23TJF+yWaq98+y/pnSGipkcTmieCoe2yIzGnXUWWB3DR6mXTp2K7Hi8CIl1B45UQg3jcnrt8pT9W85YEaL90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixHb/FhJbBT3SKeXhIcjLBsEs5EMRxNw5dWi6Kgb53g=;
 b=DZHlIGkk7j0d/Y/7Ipl0aY2vxYH6RhZsVYTaKKwyaxcaz9gLQmp04zjOz/UEQezSwB7AnM2MEVRHaGuKQ6XEdhA2DPGhs0RrAQXB/CBHSWOn6ruWLSc8/7Pq656aeJT1OtoM9Dcv4BSfIlwipnwfqLfsGs4h38kC1pD/B7GRGJHVq0Ui7IvhexDbiphmfcgnb8DHaOiDUIePTdiJFlaiVFDHkfs5eELyI5ZgS6XSU7UCBKeDEYtDyo/3b4te3hQ5toHWm8kYH/z4lUQNnUbQHQ9hqtW/JBNgZdqdAWFaxMcj5BOV6kSp/yomeCuVWljiJZtcP6gY7lbTx1Cs3J9LRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by LV2PR11MB5975.namprd11.prod.outlook.com (2603:10b6:408:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 18:19:39 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::3403:36be:98a3:b532]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::3403:36be:98a3:b532%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 18:19:38 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "dave@stgolabs.net" <dave@stgolabs.net>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/memdev: Introduce wait-sanitize functionality
Thread-Topic: [PATCH 1/2] cxl/memdev: Introduce wait-sanitize functionality
Thread-Index: AQHZdYuv/yX//gAh2kijNclYcEGXc6897DgA
Date:   Wed, 26 Apr 2023 18:19:38 +0000
Message-ID: <a1546a23259826fa1e1e469e7d9de902ae914e7e.camel@intel.com>
References: <20230423015920.11384-1-dave@stgolabs.net>
         <20230423015920.11384-2-dave@stgolabs.net>
In-Reply-To: <20230423015920.11384-2-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.0 (3.48.0-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|LV2PR11MB5975:EE_
x-ms-office365-filtering-correlation-id: ea1b0d0e-8d55-4a9c-1496-08db4682cc2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMVujgWL4P7oWiQY/a9S/LNWJ2t6CRlMmASw4TSvbaGyL0FAAIjMtvEiGhzhsFFMufk7gf2pUJosJa2MsEfSAc/zPf7C6SJQVwhjkaBDN2pWToSMLIbs+s41bKruu3Ahi4vochxCDvKaviW/3XPcQuNkea1klLR/Gx6tfOPktjyAENsvZqG680kzK3X3aei/3nnf6p/zIC13FR9PI2WeB2jX8RDDVYvgSk7MJaCul7IQs+b4J/MWxgPGR4c+EnS8iybCI/0KR08MMoeStPzNrsfOM9Suj9IRz9SnIg3206OqXFFKlR+m1AEgjmoyDULLl1sGHLDDamk5tS4paojECByjs1pCcasbWbMy66HrOapxOa3Z5NnDLBYNPZBWY0jmK8oAP24wa6vS7YMjbkB5UH/gOVjqgFVpzLqzioQueqNBsJzqYUtYi0d73Dmq5euVyq9QH5A6mV078WCZwTO4o6/4rl5dkRogTjuLF2oKoVpmQlAviOXUlWyW2GKr40SEThL+XUKXMi5WS5Z8Fj4/XUGy04vn77jEEwCn+sPV6eV0cmCxllOYYunG8N1nBF5GY8aeRv1ZHcYZBEKTXOm7PMEtyziPM9xp7M0NmjeQVRXl7FMgmyCuAyehzGKeI3hd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(82960400001)(316002)(64756008)(66446008)(4326008)(6916009)(38100700002)(41300700001)(122000001)(5660300002)(8676002)(8936002)(36756003)(86362001)(2906002)(38070700005)(66476007)(66556008)(2616005)(71200400001)(6486002)(6512007)(26005)(6506007)(478600001)(186003)(91956017)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVFyMmtQdVAweEoyQU5FWWNlbkVheVRpNDNVZG1GQTVxQVQzNkxWKytiNmhY?=
 =?utf-8?B?NFBON3djWXFYNTJSNlRqU005NHZNVmRMRTFVQ01PWkljTEVybThFbDMvSHB6?=
 =?utf-8?B?YVJoa1UwMnJyQmlrWk5YcHJZbld1R1RoRmFTY2F5blBGcnVTNkQ4RHEwTi9j?=
 =?utf-8?B?Si9hMjExbm1BUmljSUFkUUJ1cFZidUVFR1kyLzdqSFZMdGRpWWxsNmNKaHRy?=
 =?utf-8?B?N1lLWDNoandFUzI4MFJxSE85d0RzVjI4VkdoUGh6VE9EU3NWVjdaWElydmc3?=
 =?utf-8?B?VmI3aFVhZW1INU5tNUt6aVFLV3o3ZlV3enNBamhsTUZoN1FSZDlseDRnNzZ6?=
 =?utf-8?B?eTdnb2UzYUtHUzY1dlJmQjA2V2NNOXpQbFBOTmg2L0dMOWJ2bVdPeGI0Z05D?=
 =?utf-8?B?UHZMZ2pMZ2RZTDMvQzRITE40a251dVk0UkVnUGxwbHZnTUp6bjM4U2ZTeEpt?=
 =?utf-8?B?ZDVrNzFBQ2kxTVZGLzhqMmxaZGVNQUFrb3Brd3RyU0tjbU43RVNVditCcWJB?=
 =?utf-8?B?NkhRbFBJMkR1b2ttM21OUXgycGg3WDdVTUZnMExRc1ptMkJWanJ0VDBRNHF0?=
 =?utf-8?B?RVpJY1VrOFRvZHBxVDJKWnZCZit5eCtBZU5JeHBpUXJWV1B0d040Zkd6Mnln?=
 =?utf-8?B?dTYrWG5PNkhETk4vK1lYM2tibmhOQWQvcFlSSXFaZVhPR0xXRnYybmt0VUlm?=
 =?utf-8?B?OGJqZi9HQTEwV3lzY29Xd21FclhKQUV1aXBUREFSM2xVZWREVFE4R3VtZ29N?=
 =?utf-8?B?cTZrUXdybHJJeVp2SUQ3S29UaXR4RTV0d1BTTHFTT0hRRHRkV3hMZEk3MTM4?=
 =?utf-8?B?RWtzbDhsQ0w5L291dHdKQWcvTmxVZzhlM01yMDFyYlY5cjBvWXBCV2FsYWF0?=
 =?utf-8?B?czRuZW1yNzdkZ3RQekZQdHpVK3JFRzI1dUM2eGpHayt4WXhxdy83V052UzM1?=
 =?utf-8?B?Y1JFa3ZZSGVqSSsxc2pUYytRVUd3TUZUWFc5bnRMd2RKMzlQNHhpVy9JKzQ0?=
 =?utf-8?B?enlqVktZQ2FVRDNVSXM5YlZ1TkVIajNpQzlXY2NROVR3MEJNcWtpdExOK2xa?=
 =?utf-8?B?TUoxWmVSbFVIZ0dBTzhwYXNmVUgwZ1R2bndTL2FwSHlSYzdGaHU2ZHlqL2R5?=
 =?utf-8?B?NWtZVmFCU0pGT1RyMy8wYUJDYnA0Mk1JQmlFYW04aGNJelZuZThORjVrdDhp?=
 =?utf-8?B?OTFiaTZRVTJhd0l1V3pTVUdGTjRIZ01wbkVaNDhVRWxmb1pSUjVScmJiMzRI?=
 =?utf-8?B?UXF4YlZvSGVVN0VKRGlmRnkwZythOHNNaHNsQm5vSTl2TFRMUmpEZ2pJN2V1?=
 =?utf-8?B?MTROMlBlcHJkME1wMkpQRzZOdGR2Yjh2YVg1TlN1SThid29NNHlXVjJQSGFM?=
 =?utf-8?B?Z0JXZmlsOFRtTlZBcGFhbHZNdVZqWnFLbENYUUZJdHRrWFFObXBKNVhRWmtr?=
 =?utf-8?B?L2F0a0xVR0dqeFBhK1hySWROQVpscVFuS0FVc3AvWXAwZGFXN0xQVnNZZnFw?=
 =?utf-8?B?MG1scTFXUmZ1MVJyK3YzNHNMejI4UzRqTFV0TURMcHdVSEhtVzhLVnlna05o?=
 =?utf-8?B?MWVSeDUzSU5ENmhmaEZTWERsQjBXSjNBSERzR0xnZFdUZURGYWxEZjlHazFv?=
 =?utf-8?B?Y1dMTDJ3RnVQc0g1WnFtYXpPVlFiNVVUKzk0a3lQNDZGejdrSFE2ZncxY284?=
 =?utf-8?B?dU9hMkFDM0pxeThJUUxLTlRqaDVleDh3c2xKd0M5bjYyVnFiT3VuRnlrUmIw?=
 =?utf-8?B?UkxlM1ozbU5jdEh6d2FoeWdQM2JJeThtMERTSk5DdERSMHAzZDVjdHBZWHp4?=
 =?utf-8?B?YmJUeGdWa1dTQjJaODBwN3MvampuREhiT1VERUZMQTRHeFRYSWRNc3lIbFVK?=
 =?utf-8?B?NUZrVzFxclVhSzRDVUoybHIyMkExZXZaZlBIQjVTUFFlZUk1T0JmTkJxSnk1?=
 =?utf-8?B?TzRsbys2RW9BRmpnU2VWZi9OT09tZzBmZTdleEY3T3ZEV2tlMVl2WG9GU0g3?=
 =?utf-8?B?WkxtWHBMQktqZTlMWW9za2diZUJVbHhxTVVMMG1rbTF6MVZIcUhPaUtsc1Z2?=
 =?utf-8?B?OGE1Q2JTdGM4MjVNN1g1Wk9MdUxFSHhIUmFlcnM3UWo2clhxWktROVFML09R?=
 =?utf-8?B?WDNDSmdJR0tjMlNuTG13ek56M0FRSDVyMk04TnBUSTU3ZnZrY3Z5dFhYRU5m?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EFA7E3B1ED09949B8D3CC8933E80E87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1b0d0e-8d55-4a9c-1496-08db4682cc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 18:19:38.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGyv/icBrqYCtmb3OBUdFC0k0q958FI3zQNt9sfQihzPcgNos7ADQc1rfLIlgl+3cpITsXk/KytNJ8GR8nHcUqvdsnAEJPTnUf8YQLe6TTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5975
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gU2F0LCAyMDIzLTA0LTIyIGF0IDE4OjU5IC0wNzAwLCBEYXZpZGxvaHIgQnVlc28gd3JvdGU6
Cj4gQWRkIGEgbmV3IGN4bF9tZW1kZXZfd2FpdF9zYW5pdGl6ZSgpIHRvIGxpYmN4bCB0byBzdXBw
b3J0Cj4gd2FpdGluZyBmb3Igc2FuaXRhdGlvbiBvcGVyYXRpb24gdG8gYmUgZG9uZSBpbiB0aGUg
YmFja2dyb3VuZCwKPiBpZiBhbnkuCj4gCj4gVGhpcyBpcyBhbmFsb2dvdXMgdG8gJ25kY3RsIHdh
aXQtb3ZlcndyaXRlJy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZGxvaHIgQnVlc28gPGRhdmVA
c3Rnb2xhYnMubmV0Pgo+IC0tLQo+IMKgRG9jdW1lbnRhdGlvbi9jeGwvY3hsLXdhaXQtc2FuaXRp
emUudHh0IHwgMzUgKysrKysrKysrKysKPiDCoERvY3VtZW50YXRpb24vY3hsL2xpYi9saWJjeGwu
dHh0wqDCoMKgwqDCoMKgwqAgfMKgIDEgKwo+IMKgRG9jdW1lbnRhdGlvbi9jeGwvbWVzb24uYnVp
bGTCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArCj4gwqBjeGwvYnVpbHRpbi5owqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArCj4gwqBj
eGwvY3hsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDEgKwo+IMKgY3hsL2xpYi9saWJjeGwuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA3OCArKysrKysrKysrKysrKysrKysrKysr
KysrCj4gwqBjeGwvbGliL2xpYmN4bC5zeW3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDEgKwo+IMKgY3hsL2xpYmN4bC5owqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiDCoGN4bC9tZW1kZXYu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDI2ICsrKysrKysrKwo+IMKgOSBmaWxlcyBjaGFuZ2VkLCAxNDUgaW5zZXJ0aW9ucygrKQo+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vY3hsL2N4bC13YWl0LXNhbml0aXplLnR4
dAo+IAo8Li4+Cgo+IGRpZmYgLS1naXQgYS9jeGwvbGliL2xpYmN4bC5zeW0gYi9jeGwvbGliL2xp
YmN4bC5zeW0KPiBpbmRleCA2YmMwODEwMTUyZTAuLmJmN2QzOGY3ZTZmZSAxMDA2NDQKPiAtLS0g
YS9jeGwvbGliL2xpYmN4bC5zeW0KPiArKysgYi9jeGwvbGliL2xpYmN4bC5zeW0KPiBAQCAtNzAs
NiArNzAsNyBAQCBnbG9iYWw6Cj4gwqDCoMKgwqDCoMKgwqDCoGN4bF9tZW1kZXZfemVyb19sYWJl
bDsKPiDCoMKgwqDCoMKgwqDCoMKgY3hsX21lbWRldl93cml0ZV9sYWJlbDsKPiDCoMKgwqDCoMKg
wqDCoMKgY3hsX21lbWRldl9yZWFkX2xhYmVsOwo+ICvCoMKgwqDCoMKgwqDCoGN4bF9tZW1kZXZf
d2FpdF9zYW5pdGl6ZTsKPiDCoGxvY2FsOgo+IMKgwqDCoMKgwqDCoMKgwqAgKjsKPiDCoH07CgpI
aSBEYXZpZGxvaHIsCgpUaGVzZSBtb3N0bHkgbG9vayBnb29kIC0ganVzdCBvbmUgdGhpbmcgYWJv
dXQgdGhlIHN5bWJvbCBzY3JpcHQKYWRkaXRpb25zIGluIGJvdGggdGhpcyBwYXRjaCBhbmQgdGhl
IG5leHQgb25lIC0gIFRoZSBkaWZmZXJlbnQgTElCQ1hMX04Kc2VjdGlvbnMgaW4gdGhpcyBjb3Jy
ZXNwb25kIHRvIGEgbGlicmFyeSByZWxlYXNlLCBhbmQgYXJlIHVzZWQgZm9yCmxpYnRvb2wgdmVy
c2lvbmluZy4KCk5ldyBzeW1ib2xzIGluIGEgbmV3IHJlbGVhc2UgYWxsIGdvIHRvZ2V0aGVyIGlu
IGEgbmV3IHNlY3Rpb24gaW4gdGhpcwpmaWxlLiBlLmcuIHRoZSBwZW5kaW5nIGJyYW5jaCBoYXMg
YSAnTElCQ1hMXzUnIHNlY3Rpb24gZm9yIHN5bWJvbHMKZ29pbmcgaW4gdGhlIHY3NyByZWxlYXNl
IChjb3JyZXNwb25kaW5nIHRvIGtlcm5lbCB2Ni4zKS4gQXNzdW1pbmcgdGhlc2UKcGF0Y2hlcyBh
cmUgdGFyZ2V0aW5nIHY3OCAvIHY2LjQsIGl0cyBuZXcgc3ltYm9scyBzaG91bGQgZ28gaW4gYSBu
ZXcKTElCQ1hMXzYgc2VjdGlvbi4KCgoK
