Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6661CC0015E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jul 2023 17:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjGLRjf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGLRj3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Jul 2023 13:39:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D981991
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689183568; x=1720719568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g7xnWuHOSSelD612G8l7bUawLRO9x+xSZYCBxD1dK8g=;
  b=mOhevOsdP5C0/6+Vq3kZSurqspKBiGGHhV0XW3BXrtQ8dtef7i4qAy2X
   Nyme+DsE1aG4+CdsWIL6J3u5fXNf90DNVs6UxjJ6Wa4Rh407OuuWUSww0
   QBDye3fOzp3N6sSdwQkW2RpZ0heGwfK8DrkgvMJdwu927fSnhHU+EzZoK
   FU4Uyr89yrgrPzUAgvGv6ZFtmXhhZcIGhUq5xMapRYf6UHK74v8ejNakg
   F6GK5M5WBjteIJg+TxEdVHw2gU1if+m5m/Qgqsrjw8NvUbKK1gSfBC/Zp
   PR4P1hRq5D5Yb3gRODehKdkkV90seBvExmnDAV9cOTDLE0hcN7+dBsEuv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="395757084"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="395757084"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 10:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="1052273270"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="1052273270"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2023 10:39:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:39:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:39:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 10:39:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 10:39:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEB0LTUgSf/5kenr3wwaAOR8q32f+VvnOs5XXthkiED1K0H9MtNFM2hiJR5+Ihh9mk7OabqhULgZB+DroAsTf4+xCcdtcnkppAoTK1Q4xMh+zDcQb0LBq9cooudt9qlPTW858B9rbl4Th+lSCtmH2aTM8V67bWd+KsdX/yVjZF/7qFkcBOSOKKFsHV3UaE0cl+3XGjm+SUfjdFD3ZD3sqU+Z5lsjr25EyQRcDxWt/h/pJ9IKxy6SzbG1vUNHcG2rHOJFT6/tVXgtZigRsViDAZBaWoCQH4nMWTV06YjypzMwJ3YZE6REzDhFGp1kECSl1qHQXhLZBMIXxgsONhOG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7xnWuHOSSelD612G8l7bUawLRO9x+xSZYCBxD1dK8g=;
 b=kTJH8TkT8zvjP9PgRcaut4ej9Tt723zhoUXNOpLqPJY3Vkuk5qYfUsRz1zQwJj9UlDbDjzV6iSJv8SkdqX5nG1MVf2vVi5EkGZrBpmVujLKDS3zq1KkyvbocsnmxAXOLsh0ksL36JZP/oYuWXq41yJkThD4MnaOlSpUjMBPxKyolX3L4xzguDy9Nv6uYV3d4ZD6NEk7/ZFt4Wa3Ot9LlBKPfQoa5LafkcGnt7toLxXnbfvvvvZrE9JAjqCoWomkyOKkEPmFG3ZmDTSXDg5v4HYf1A15Grv2yKxJFQrSLIRel0+MJwiLs/0bYN+/k5f2wPARxQi9c8O3BWIR7+PogmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:39:25 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 17:39:25 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "fan.ni@samsung.com" <fan.ni@samsung.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Fix double shift of CXL_FW_CANCEL
Thread-Topic: [PATCH] cxl: Fix double shift of CXL_FW_CANCEL
Thread-Index: AQHZtOT/oGqj8GKjs0ynR9hbVo3J7a+2Zc4A
Date:   Wed, 12 Jul 2023 17:39:25 +0000
Message-ID: <e3e0c38c3efaa59be3b39a90727454b15d785ed4.camel@intel.com>
References: <20230712164224.31891-1-dave@stgolabs.net>
In-Reply-To: <20230712164224.31891-1-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|MN6PR11MB8196:EE_
x-ms-office365-filtering-correlation-id: 861d90fe-45e4-41fc-2c68-08db82feef75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lfvwo8ryWOkT37gUufPW1A4CDuc40VL9qKoUE0XUf3h3TBzlBmWAZM+4ziXNr3nlwJchadH2Gymi1S85iXMHA2W+s3qb/Oz8qiZJyrTN+pvxnm7v9RxZBpvYejrOKaYmIAvTNil8fY6TjS/i9S/9BGUNupZI//dqAHaUKnRRJTYhkA9GijdHX/EhwlWGK6GPY9lvxQ707V3hhs8UsWnBlyLXKu2YGok7jeKN+1g5KLUavsBK4gfe39SWMxbDq4ww2wOl3eduNUdojEnr2cxRWvU7Y+cxKZpUkTVVsOEDdpkgQpRJTxlFFgOAVrwf946szAiKtkiSWc3cpeJhxPPDly2TZbaoKJ51JLJBKDwJCm6Mv9E2rM+PYaOM9Vwk24YDDdMUhi6RQzAAiXZPw+hiM9oEnqiNKVUXTb8qAT7plra/VcUan0b88uMf6beaRpw4slhdAueejUR3MtqbndfjobRDiCgSM7nyWbfR0KNMpyLCfQjdkcjZw545bHvclG2B0786CueGgnf9XrGJ2byaI0mjHGrDhij509VSq8P0SzhtfBISlnRhetaOLx1QdL8V5vfqxgHpTk7ZHcs0EswR7aOnUMs8/F3vxBAERcJrTfGAPN1ctxXl37wxoa8A9Z+G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(41300700001)(82960400001)(316002)(6512007)(5660300002)(26005)(36756003)(6506007)(8676002)(38100700002)(8936002)(83380400001)(86362001)(38070700005)(2616005)(2906002)(4744005)(186003)(122000001)(71200400001)(54906003)(110136005)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6486002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGZWOWxBclphMzJIdjU4TGtRa25kNFBHVk9DV0ZnWGE5S2NmUG5PNXV1a1Zp?=
 =?utf-8?B?bXM5dmNLMWFySFdOejdPTERmWHBRRUJpVlR1ZDZtekZXdTYwcnpPR1RLVXF6?=
 =?utf-8?B?eVV3ZC9KajlsdUdaNHRJK0lpMDZXOW44OUdBWWMrM2JaM3NWNzI0ZWd5bjZk?=
 =?utf-8?B?VjlLZXpWZUwwbW5VSU55SGlFWVEza0VXN0JmLys2eXJ2Nmh6bFNnOThoV2NN?=
 =?utf-8?B?WUhQd1d2YjlTbEMwRHl6SXpPV3dCdVdLMmVVRGsyZ1Yrd1J4ZWk0WGJGek5z?=
 =?utf-8?B?UVY0SWZnVGZ6ODBiR1BoRjRDb1F6Q0VtdFV0QTZXWXNKdk5xaFZIU01xSjll?=
 =?utf-8?B?YmtuNDJnR1ViRkFHcjZxenpTcG9UNlFEM25XSm1SUkt6dXlUZ3dML0JFbzcw?=
 =?utf-8?B?cllTN0E1YTZZQm9zcWM1dXlvQXpBMlV3YklQU0tqbnhuMzZjVlJocW85YW5Q?=
 =?utf-8?B?b1NBcy9neWx2elBDaFNKUjg5SUN6bWxEMTJHV0dNeFJRcDhjZTlja3dWT3pK?=
 =?utf-8?B?TldPZkUyc0E2a3JnMUk1em8vRGo4bWxtaUJpQzJwK2o1SkFMZnRiWHRpYWMz?=
 =?utf-8?B?ckkxTGtBQXBXOERwTElhZVU5TnRnaTB5bnpNd3dMTERjUG9OOHErTUFwQW56?=
 =?utf-8?B?dHUycEpKSmtKd2pRK3U3UW93UjF5dFJJWVRJMzVnVjZIa2NETGdMYlFIbm9N?=
 =?utf-8?B?NXhuQnJFZ25MMXNNQU51MGw1MnVSVFFCa0o5VzFHVUpTT01vTWFyVDhkNzAr?=
 =?utf-8?B?VURrMEN0YzEwbnJJMFNuelFmdGVhZm9lRksvd2crQ0JRWDNMUm9LMnlFWkFI?=
 =?utf-8?B?eTl4SzRtSVVyNXpFajRFRkpXalNFQzZzd2RUblo5RWVRU2krcTBKTWQrQWhY?=
 =?utf-8?B?UExaRHExbTZuNUZYbFNDSUxSY2c4T2ZBZ3c1clN1TUdiNlJjV2xrM01ZMTVL?=
 =?utf-8?B?cE1rUE9aSVorWlhvTnUyUi8rR2lXZ0wvazZwM0ZUYS9hdkVERlRtcWt0b010?=
 =?utf-8?B?S2YxdGZKNkRseWhoU3oyOHpTdFJPc1krUTEyMEQrM09LRFo1ZC8vYlhNdFpF?=
 =?utf-8?B?amsxSlZkeTQvQTVzV205eVVjaUtSMnh6OW1zcEt5TExUWTVLRzUyRGhuRWVh?=
 =?utf-8?B?M0ZwZXJtaVVJeTYxSjBiRzlVY00rVTdvSzJ5SnNvTldIbk8rMDJHbmVCUzd4?=
 =?utf-8?B?MXBXSCs0UDdnOU40QndvVGtXVk94SmRrOWxhenRRd0RydGhLcmlLZFk0WFNT?=
 =?utf-8?B?VTJzU2NBcEtTbVdyU1FaVGpSZHZLaGNhZlpkT1JNWkx1cG1KM1hVQmo0QWZu?=
 =?utf-8?B?YU41U2ZmRDFnU1BxOWZBUzFrWUR4akt4TnFCeTh6ZkllelVtVnBHY1czRWhQ?=
 =?utf-8?B?d0N0VWZ3OTB0VkpObU9CM05OMjNFZEZQY0N5YmgydExCZGtocElDeVFvNVB5?=
 =?utf-8?B?RDVUbjZ6QUtqVWFMSnZEVVNsRGVUL0tYSVQ3Vnc5d1FGYlpCVTdIZTFKVnFH?=
 =?utf-8?B?K2Mya3VHQjIrT3NyVmFGaWk4aC8wZkxHMmlwV1lQbFdXS0hGejVxQ2xyeDhX?=
 =?utf-8?B?S0ZiR2s1alM1OW5yM052VmtCSEJ4aVdkaWE4N0s2aENvR1R6ekJaWWo2UHhn?=
 =?utf-8?B?MmZQMThvNFBnSnN1alNLcnJaMDc2YlJPdHFJb0RLQXN2WGVkVjhOcXNNcmlY?=
 =?utf-8?B?d2lRL1doRkpCZDE3aHdlM3pXOU1GL2dBU3Fab0V4ODlHS3R5dmVVN3d3WkRO?=
 =?utf-8?B?YWcwdHBFdldBdngwV1pab1EwOU9icXNwaEF3LzB1bGdwWTg4dkRJQ0NzYUNw?=
 =?utf-8?B?TEF2NGpMSFFNaENvZFVkQkphd2l2SkZjZ3Y4M2crdVZ0YUlpUkZMbU1VNW9C?=
 =?utf-8?B?a2ZROXhVT3BmMVVDSmVDTUlhY1dqVzc0Qno3SWtLVkkzR0N5Q1hGUUtOOGx5?=
 =?utf-8?B?djhkQmZ1VmlsR1JrOVVNQVhlWUhQa2g3Q1NjcFE0MnlDa2RNRVhDOGNKSUEw?=
 =?utf-8?B?UmNRQlA5Umx4RVhpcVhDMmt5NS8xYWl3UnFoZDJpSkIva3FjK2JwOHRwQzdt?=
 =?utf-8?B?SXQwamc2UWt3N0gwb3ZsMG1WQUJuZGZqUHdYL0xRY0U2S3FaNWdOUWNETngx?=
 =?utf-8?B?c3Y4QlQ2TjlSWWl3VHhLejI0K2hJYzR5YjUrSzhHZERaK0hKcE1wc3d3OExx?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C6E5B415BAC4141AD43452719EB511B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861d90fe-45e4-41fc-2c68-08db82feef75
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 17:39:25.3284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8T8ux8/2+/4MsHsh6xqYQoQDe/nF90bQ3KdqfCq48Y3JKL8T4/OoG7iKL2nR9CW8REv8rGRnCn/HYYLAfun1x6PjaA31xbVSuZlLB/J15I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTEyIGF0IDA5OjQyIC0wNzAwLCBEYXZpZGxvaHIgQnVlc28gd3JvdGU6
DQo+IERpcmVjdGx5IHVzZSB0aGUgYml0IG51bWJlciBmb3IgYml0b3BzLCB3aGljaCBhbHJlYWR5
IGhhcyBhIHNoaWZ0DQo+IGJ1aWx0IGluLiBUaGlzIGJ1ZyBpcyBiZW5pZ24gYXMgaXRzIGRvbmUg
Y29uc2lzdGVudGx5IGFuZCBpdCBkb2Vzbid0DQo+IGNsYXNoIHdpdGggYW55IG90aGVyIGZsYWdz
Lg0KDQpBaCBnb29kIGNhdGNoIQ0KDQo+IA0KPiBGaXhlczogOTUyMTg3NWJiZTAwICgiY3hsOiBh
ZGQgYSBmaXJtd2FyZSB1cGRhdGUgbWVjaGFuaXNtIHVzaW5nIHRoZSBzeXNmcyBmaXJtd2FyZSBs
b2FkZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZGxvaHIgQnVlc28gPGRhdmVAc3Rnb2xhYnMu
bmV0Pg0KDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5j
b20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9jeGwvY3hsbWVtLmggfCAyICstDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jeGwvY3hsbWVtLmggYi9kcml2ZXJzL2N4bC9jeGxtZW0uaA0KPiBpbmRleCA3
OWU5OWM4NzNjYTIuLjQ5OTExMzMyODU4NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvY3hs
bWVtLmgNCj4gKysrIGIvZHJpdmVycy9jeGwvY3hsbWVtLmgNCj4gQEAgLTMyMyw3ICszMjMsNyBA
QCBzdHJ1Y3QgY3hsX21ib3hfYWN0aXZhdGVfZncgew0KPiDCoA0KPiDCoC8qIEZXIHN0YXRlIGJp
dHMgKi8NCj4gwqAjZGVmaW5lIENYTF9GV19TVEFURV9CSVRTwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoDMyDQo+IC0jZGVmaW5lIENYTF9GV19DQU5DRUzCoMKgwqDCoMKgwqDCoMKgwqDCoEJJ
VCgwKQ0KPiArI2RlZmluZSBDWExfRldfQ0FOQ0VMwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgMA0KPiDCoA0KPiDCoC8qKg0KPiDCoCAqIHN0cnVjdCBjeGxfZndfc3RhdGUgLSBG
aXJtd2FyZSB1cGxvYWQgLyBhY3RpdmF0aW9uIHN0YXRlDQoNCg0K
