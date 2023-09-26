Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86D8E7E650
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Sep 2023 17:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjIZRBd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Sep 2023 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjIZRBc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Sep 2023 13:01:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09FF10E
        for <linux-cxl@vger.kernel.org>; Tue, 26 Sep 2023 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695747685; x=1727283685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=24SLyATutR+6wGXBQ7O1dmr2b0OqmsdbqITn/pl0b1I=;
  b=TDyQ0HZiQKNQCCcBQ4jIv24BGf0A8l7tn3dyutXNT1Ym9vGWiwK9B8f1
   9Kmg/0wX6buuzggqZYOdxjBV6LiSng7lXR8qt/i7bDpPrfKdDYWpc0fQT
   hJCB9IjlRk3PfYxL7QR/8osUaemAdEtS9s+IHZZrR+hawT++1tW9pB6z0
   4rSLfp2wNhzTKIVTfXQi1QvrvKjTZdiF/dy6dGyGxw7GwUpma5T8ugvNA
   rjN5KiPS4xwxcBWUW+q6Ur7caHw4UF/jE5MSmeXbq4kIGZNUbtSWPrwaT
   RcrxHs82rW8aad/Ia1gqp7CNC7Ci9HKDoCAMBfqKBoY83ExWg/tFWp8Vp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380486112"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="380486112"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 10:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="228012"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 10:01:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 10:01:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 10:01:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 10:01:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3tBijtZSYRYCePV1/kDJo80BKLZwOlDmgTxo1/lylSKHlaXXf5m6Et6e8WjcS229eETgTit4hDBZVK2yyN3DDFCaGHn7g1f19hNDd+OaEjmwcIi0J7q6HLNTJdzivBRODCpWjsvpn3nQCISnYiZczi3MyDNDadzXthcqoaeDRE6U/imkJfFQIGl8/GTvPSpP53YKq+QtDh11qRkmMT8ijViLelNYu0e05DyUOebXEHHwnnVvu7pfVEKiZrio+4W0CzmU63J4KKDshRGKYrfbPbpRR295/i8FltL0yUcHXFmUrU07AFf0R4Duz+vFVywtBG/12ECLguTrAY12z2Bdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24SLyATutR+6wGXBQ7O1dmr2b0OqmsdbqITn/pl0b1I=;
 b=OfwllV/VlVjGu1cagRW8tq3lczVeyDgpvQVX+zVBAmrHLr2RIa7ZfObzoyk5vjl1aTOvL55kRtPZjtJIMhWmVx/U7iZ2BKqAz8jbAq58VBCNIHiUyLa1FSGzZ2AjHYoo1GB3csPqgrOora6YNeOgVcnDjh68fhN3MK90tyoTtt5nJKAyfvWkO4oTgYk3GyjvNSw4YVu7AZbv6toNum3/l+9pkMU3CL/ukhZ2NK0mIHbeqHyW+AIdCEYvtNU08u3F3nLqu5TDG+LfTGpUL0KGwNGqR0OeRr+zkGErNRCG01ZfmX/A988TfDshYeGRYqmIX+ZR2ugFb0ux8N/H2VvyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DM4PR11MB7278.namprd11.prod.outlook.com (2603:10b6:8:10a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 26 Sep
 2023 17:01:20 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 17:01:20 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v2] cxl: Add committed sysfs attribute to CXL decoder
Thread-Topic: [PATCH v2] cxl: Add committed sysfs attribute to CXL decoder
Thread-Index: AQHZ8I5SqZt6pFbgUEiA+Qab8rHCzbAtVQUA
Date:   Tue, 26 Sep 2023 17:01:20 +0000
Message-ID: <74d1280689e2860b08ff21f4ebfa92e8f072a687.camel@intel.com>
References: <169574219129.3884437.11954592650115343944.stgit@djiang5-mobl3>
In-Reply-To: <169574219129.3884437.11954592650115343944.stgit@djiang5-mobl3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DM4PR11MB7278:EE_
x-ms-office365-filtering-correlation-id: b175be1e-6b42-4cd3-8bf9-08dbbeb234f1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Z4dKedbY+KUnABN1iLbFhueQnhyOPkAL2OqxBWuK5ZpKjU/VZIV2psTdoOkjp5aUPJu/H2h7v1c8sxwR5UMGugkzD9cHTYqMiqRohgXX1CxZjIrA/61yYNNSFmJ8YzMfvi2p9yoOG5bCu3DhR9UDOH9FDL4x8RbMvsWmfgdZlFnI+TQbVFzA8MGm1VpIDNQFLr91cpgddxG5UZ2q+JBTqFHYmopBtspMMG826wnLbFE+44rYXQ4HL4br3Z+k3kBPkx/aWJGUJAANtXrzDVidVLtbUJEJbtzV8JUvZuxOQLT/NJriXgpSji8MdLAOS861Z+OKFWBE9NjN5jItBDSVAeFCzaeId0Za89dhBItIRJw4dZnEGqMEZrxJBEWdjEUo4twa0rH8GYsK4EiJcC0wQwW6xSo8a5Bb25JEmj2lEau6jVCPOTKjbtLZRGoR82d6c5yb99auZivzZme/Szk75BJr6vKU2NUY6kM63WGFGXTlSf9v7XOln03wQjp+JzRKK6lgoQJ+G44Rlo9PBDUWhx2oy6Lw27U0R5BDMg5EvhyyN60KPjJS7s9Pkz/MOTwBo3ESo+l9Qf3AUFNtp4wpgvj7BK9+GekB5sNGytBUOVJzBScE9LEEEjtj+5mE8b2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(230922051799003)(451199024)(1800799009)(186009)(66946007)(122000001)(5660300002)(8676002)(4326008)(8936002)(82960400001)(83380400001)(38070700005)(38100700002)(41300700001)(66556008)(107886003)(316002)(76116006)(54906003)(64756008)(110136005)(66476007)(66446008)(26005)(2616005)(86362001)(6486002)(66899024)(6512007)(2906002)(6506007)(478600001)(71200400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXh2Y25XYnIvcUJpQmw5cTM5bmo3M2VGanJXY01tL1AxYU50amZUejRqVkdm?=
 =?utf-8?B?N0NUYWdQYllPS2xmZUpQQ0F1L3lvSENRdkpNdWNya3AzVnI3QXZ5YzR5bWJl?=
 =?utf-8?B?aURIMGZXTXZZUWszQU83TFljcExaY2pxUjd5UkRUTzh2aXlUL1ZRY1prSTZV?=
 =?utf-8?B?cDAzd3RDYzA0NjFwRHdwZWVjSzh1RjhCRkJCMFVaM0Ezdm56aXNxTlpac2dx?=
 =?utf-8?B?NjRYQ1RWY09LUWdnZ09NVWJ2WHJEU2NieUNhbXdBeXJJM0twTUlTZGovRU1z?=
 =?utf-8?B?d2xweUV5L0J1ZnZRSnJMZHdUQjZub1VLWEhMbzhkdThycUhTRVg5Qi9WdDRn?=
 =?utf-8?B?K0R1NUdOWk9uWm5hemEvYk1rc3dNRGpEMzRON3pmMVlNUHZHR3RmTUpJWUYv?=
 =?utf-8?B?QXpKUU1QdFFNeUl1czRFTndYUDBsc3d1TkJLOWs2VW5qLzZTRGRsNHF5OXpn?=
 =?utf-8?B?YW9VVDlBcURoQnJUalNsTWlzN21EeFBKaFNPRU9NVGJqVTJHM0xZNUdFNVoz?=
 =?utf-8?B?Z3NyNHNlYk5sVnQra3BXSWlrSFRMem1CcitJUmlEd1JlQzgwdmhlTDIwUDA4?=
 =?utf-8?B?V2RHeEI0bUozVzg2U2k5MDlzU21rYzNNektWelVUSlZQcnBJcnpsdGpZZ1dl?=
 =?utf-8?B?c3ROK3ZHT1JXbm1ZZFg5Rjh4NGZJcDczWVBQWjJ1TnUrS3grSEtNTXpjTXhI?=
 =?utf-8?B?N3VMNllQRmRhaWxocXM0S01HZVNSK2NvR216NGpTczY3M0VSQXhqQVpNMEZs?=
 =?utf-8?B?cWhSMk5YNnpDalRmQ2syUC9lck5rSEhHSEI5czlJTFZnSkFqK20ycVlMVXFH?=
 =?utf-8?B?YmtkZC9yYVVtWTNjOE92UXRBMUErY2V5ZndDYTY5UWlIT1JPbXJYZjZTNkhX?=
 =?utf-8?B?b2M4U3dJVGdBQ0RDOW0rWThETDRBdVJwRlJwN0cxc3FrOWNZNXl0cFcrbzlr?=
 =?utf-8?B?enUxbkRyY2RUVDhWeUhlRkNKVCt0NFV0bmFCYWQ4OWJmTGFOdVlhVTRuamZT?=
 =?utf-8?B?OG94V0k1eWN6RUFnMFlMMURlSHJ6K29WQnM2ZVd1WEI4S3AvajMrZUkvckww?=
 =?utf-8?B?YmNJNnc1SEY5UlpUdmhINjRyeGZqdForeXBJSm5HbXlLeVUzamNMNG1NRGw2?=
 =?utf-8?B?OG5qY1NOOW80eFdTQmZUZnl2WmtEdm1zYVJvNE13cUxQTG5LekkrS2pzVzFG?=
 =?utf-8?B?QU15NFZ6VkdtMTNHS3phNS9FUndPZzJESjlvSWljUXFwMDZ1MW9SWmFTZEh1?=
 =?utf-8?B?RkQzTTVkbWF5M3ZYRmJiNm5YWUlzSWlaVzhWNzBMSjMvcFd1YVJZQ2ovVWM2?=
 =?utf-8?B?a2ZjWm1CUnNNUy94ckJSdjVFbzREVE4wTkVxZ2JXRCtIRURRR3o2c0luSUJr?=
 =?utf-8?B?aW5oS0tDaURVeWVtcDZtRXVkOHl4QUFvRzFKSGtpQmYwMm85bXFmVjF2SWsv?=
 =?utf-8?B?QzhnT2JpN0VFd1VXeHdWVTdXTER5Z1NBZDVmMk16c2lQNWd0eFNnczUza2xp?=
 =?utf-8?B?TTFNS0IvMGUvNUtpVTA0cXhldjRhNnhVeGJmcEF2dHMwdW5vN2RBUjI5OHFy?=
 =?utf-8?B?NDFGVGN4T0xYQ2tRV1RpREtQSlUwalF2eDkxbkdpQXIvdzZNWTA3bVNhMnZl?=
 =?utf-8?B?blFvcHRkRGdQakdraHVBL2trSytuQWRoU200RnNMdTZDcElySDI1OFhqOWhU?=
 =?utf-8?B?dDBFdExpQ1l0K0xyZGIvNktrR3VQTjU0YkQ2UmorSXZVaTRXSGNIWjFHcXY0?=
 =?utf-8?B?SzRaM1ZVNXdpeUFxNTdUcUFtb1I3ZWlTUGlWT0x3QW9LSHg3cElGNGkxZzlC?=
 =?utf-8?B?WHQ1T3hNbEIwdWxOZFpQYlZpSG13MlZTTEpuQklzNVhpSkFmVW9SOHpic1ph?=
 =?utf-8?B?c3RiaWRJOCt3ZVdod2lwaGxxTENvcWZtR3QwSGN2ZE9xemtjaVJ1bkhWaTU3?=
 =?utf-8?B?dFgwdFBWVFNZa3JKQXRGN3drc05sbng3NURkMXY0eTJzenlkUkNQdXNWTENF?=
 =?utf-8?B?MnF5dkJ1QUNvanB0a1FxT0hJYmt3UGM1QXVpa1RvSmxuS25WeGJWeE5zeXVT?=
 =?utf-8?B?UEF0K21mbGNrVm9CdmVGREpSWVFxY3BPWjBBemZ1TmZaNUFaUE5aam5lNEZL?=
 =?utf-8?B?WjdSdjFMb2V3RnpRMldDVVFCWmJ0RGM5MWNmcnNhcmlhRHpKZFE4OUlvUVlv?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC4FE06075341B41967C9F23724234F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b175be1e-6b42-4cd3-8bf9-08dbbeb234f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 17:01:20.4407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVB3rdcXii+aJLSARcJXiA8/tLRhBoLTjX8xJHybt56IA1SQYG1mIodJSdHOA8PiQHSeWd/iUIfIjjo+Q1M0U/EzLQ19FM0qEgygUWm3zmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7278
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTI2IGF0IDA4OjI5IC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOg0KPiBF
eHBvc2UgdGhlIGNvbW1pdHRlZCBzdGF0dXMgb2YgYSBDWEwgZGVjb2Rlci4gVGhlIHN0YXR1cyBh
c3Npc3RzIENYTCBDTEkgaW4NCj4gZGV0ZXJtaW5pbmcgYXMgYSBzdXJlIHdheSB3aGV0aGVyIGEg
cmVnaW9uIGlzIGFjdGl2ZS4gT2YgY29ydXNlIHRoaXMgaXMNCj4gc3RpbGwgYmVzdCBlZmZvcnQg
YXMgaXQncyBhIHNuYXBzaG90IG9mIHRoZSBzdGF0ZSBhbmQgbm90IGF0b21pYyBmb3IgdGhlDQo+
IHVzZXIgcmVnaW9uIGRpc2FibGUgb3BlcmF0aW9uLg0KDQpBIG1pbm9yIG5pdCBoZXJlIC0gDQoN
CiJTdXJlIHdheSB0by4uIiBpbW1lZGlhdGVseSBmb2xsb3dlZCBieSAiIHN0aWxsIGJlc3QgZWZm
b3J0IiBmZWVscyBhDQpiaXQgY29udHJhZGljdG9yeS4gV2hhdCBhYm91dCBzb21ldGhpbmcgbGlr
ZToNCg0KVGhpcyBhdHRyaWJ1dGUgYWxsb3dzIGN4bC1jbGkgdG8gZGV0ZXJtaW5lIHdoZXRoZXIg
YSBkZWNvZGVyIGlzDQphY3RpdmVseSBwYXJ0aWNpcGF0aW5nIGluIGEgcmVnaW9uLiBUaGlzIGlz
IG9ubHkgYSBzbmFwc2hvdCBvZiB0aGUNCnN0YXRlLCBhbmQgZG9lc24ndCBvZmZlciBhbnkgcHJv
dGVjdGlvbiBvciBzZXJpYWxpemF0aW9uIGFnYWluc3QgYQ0KY29uY3VycmVudCBkaXNhYmxlLXJl
Z2lvbiBvcGVyYXRpb24uDQoNCj4gDQo+IFN1Z2dlc3RlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4u
ai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxK
b25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERhdmUgSmlhbmcg
PGRhdmUuamlhbmdAaW50ZWwuY29tPg0KDQpFdmVyeXRoaW5nIGVsc2UgbG9va3MgZ29vZCAtDQoN
ClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg0K
PiANCj4gLS0tDQo+IHYyOg0KPiAtIFVzZSBGSUVMRF9HRVQoKSAoSm9uYXRoYW4pDQo+IC0tLQ0K
PiDCoERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWN4bCB8wqDCoMKgIDcgKysr
KysrKw0KPiDCoGRyaXZlcnMvY3hsL2NvcmUvcG9ydC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqAgMTIgKysrKysrKysrKysrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxOSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGlu
Zy9zeXNmcy1idXMtY3hsIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtY3hs
DQo+IGluZGV4IDA4N2Y3NjJlYmZkNS4uZWYzZmM5ZmU5ZDBkIDEwMDY0NA0KPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1jeGwNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9BQkkvdGVzdGluZy9zeXNmcy1idXMtY3hsDQo+IEBAIC0zNjksNiArMzY5LDEzIEBAIERlc2Ny
aXB0aW9uOg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByb3ZpZGVkIGl0IGlz
IGN1cnJlbnRseSBpZGxlIC8gbm90IGJvdW5kIHRvIGEgZHJpdmVyLg0KPiDCoA0KPiDCoA0KPiAr
V2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvYnVzL2N4bC9kZXZpY2VzL2RlY29kZXJYLlkv
Y29tbWl0dGVkDQo+ICtEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgU2VwLCAyMDIzDQo+ICtLZXJu
ZWxWZXJzaW9uOsKgdjYuNw0KPiArQ29udGFjdDrCoMKgwqDCoMKgwqDCoGxpbnV4LWN4bEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gK0Rlc2NyaXB0aW9uOg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgKFJPKSBJbmRpY2F0ZXMgd2hldGhlciB0aGUgZGVjb2RlciBpcyBjb21taXR0ZWQuDQo+
ICsNCj4gwqBXaGF0OsKgwqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9idXMvY3hsL2RldmljZXMvcmVn
aW9uWi91dWlkDQo+IMKgRGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoE1heSwgMjAyMg0KPiDCoEtl
cm5lbFZlcnNpb246wqB2Ni4wDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9jb3JlL3BvcnQu
YyBiL2RyaXZlcnMvY3hsL2NvcmUvcG9ydC5jDQo+IGluZGV4IDcyNGJlODQ0OGViNC4uZmM2NWVm
NTVkYjBmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3BvcnQuYw0KPiArKysgYi9k
cml2ZXJzL2N4bC9jb3JlL3BvcnQuYw0KPiBAQCAtMjc3LDEyICsyNzcsMjQgQEAgc3RhdGljIHNz
aXplX3QgaW50ZXJsZWF2ZV93YXlzX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiDCoA0KPiDC
oHN0YXRpYyBERVZJQ0VfQVRUUl9STyhpbnRlcmxlYXZlX3dheXMpOw0KPiDCoA0KPiArc3RhdGlj
IHNzaXplX3QgY29tbWl0dGVkX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4gK3sNCj4gK8KgwqDCoMKgwqDCoMKg
c3RydWN0IGN4bF9kZWNvZGVyICpjeGxkID0gdG9fY3hsX2RlY29kZXIoZGV2KTsNCj4gKw0KPiAr
wqDCoMKgwqDCoMKgwqByZXR1cm4gc3lzZnNfZW1pdChidWYsICIlZFxuIiwNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBGSUVMRF9HRVQoQ1hMX0RF
Q09ERVJfRl9FTkFCTEUsIGN4bGQtPmZsYWdzKSk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBERVZJ
Q0VfQVRUUl9STyhjb21taXR0ZWQpOw0KPiArDQo+IMKgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUg
KmN4bF9kZWNvZGVyX2Jhc2VfYXR0cnNbXSA9IHsNCj4gwqDCoMKgwqDCoMKgwqDCoCZkZXZfYXR0
cl9zdGFydC5hdHRyLA0KPiDCoMKgwqDCoMKgwqDCoMKgJmRldl9hdHRyX3NpemUuYXR0ciwNCj4g
wqDCoMKgwqDCoMKgwqDCoCZkZXZfYXR0cl9sb2NrZWQuYXR0ciwNCj4gwqDCoMKgwqDCoMKgwqDC
oCZkZXZfYXR0cl9pbnRlcmxlYXZlX2dyYW51bGFyaXR5LmF0dHIsDQo+IMKgwqDCoMKgwqDCoMKg
wqAmZGV2X2F0dHJfaW50ZXJsZWF2ZV93YXlzLmF0dHIsDQo+ICvCoMKgwqDCoMKgwqDCoCZkZXZf
YXR0cl9jb21taXR0ZWQuYXR0ciwNCj4gwqDCoMKgwqDCoMKgwqDCoE5VTEwsDQo+IMKgfTsNCj4g
wqANCj4gDQo+IA0KDQo=
