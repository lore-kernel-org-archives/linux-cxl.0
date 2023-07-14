Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB74EB64DC
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 22:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGNWde (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 18:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGNWdc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 18:33:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55572D73
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689374011; x=1720910011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=89rUYhwjrhjtryflX/eX73aWN4AsXJLEQzpWG5Ukd6U=;
  b=Z9Rk893t4ZsWc3P558mxkOxFQaXP+UOwhOX4ro9rexvDDUMEXjeRUPWF
   0qec46dN87RrUsQZvgQFP9J8xVC9T5xFYyKYQhi/syCxdfm26SRQhxJfi
   JDdOHhkN4XzIhrZgNmrt5immDFA3kn3K+gW9RzF2fSTJlhXN+54wl8aUz
   lAlxglYau8xRllcgCw0djuoeITR1b6PJHZVl0ftfnoxsk80tpZheNf2V/
   RY8aMjlQtg97epuRqi3aM1xDj0T/47hlbc8YhcAAd5bXZwzcAZlg65kQg
   xn1wavHnpdmgSLTfZCxh5+6MIrq7XNn+KAHDXSoundlzNviKwK2fw+BeA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="368236109"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="368236109"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 15:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="757719178"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="757719178"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2023 15:33:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 15:33:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 15:33:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 15:33:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 15:33:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVxRvPPb7Kx1oWXQmam47KI0MAv7YO5Hr42C234vtC9K6ns2Iv8R10Ue32MCxW6nvOcb5CKsBIwc1HLZs8SEhNIYEiqNejEZu8pZkM6iwTmUIZ4LbKOp8gYAv2meSxeacZ+50Nvh1Gch2iw6HLxtq3EvVo/uYud01ObzlBQ04klO5e82UghKEsCFEcyNGDrb5Ky0rl0j1m3q5BLoYq60S1le1hKmmzOIxNnxEzX8uYHTfAfCgO6ycfHEgZbev12kFnDMC5P8KN547oK2UiYUB2dAFLajzcYMyX/TyZOKegfNIoYS25y8tUJtOHQxz3sl78oEKKwRZc1HRX1lCkQqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89rUYhwjrhjtryflX/eX73aWN4AsXJLEQzpWG5Ukd6U=;
 b=exRj22fMm6Lq/L7GlnsR4VhghSQQw3ZTX47DpvIugBQit1Uq3K3pT+5LaNzLqYWW+MM61gAmK93zJBs7wZeOZrAxQWBXXyTKSZhf3h45WG1G9L1iIpTikJuzdMgFZEjeJkETjFFjkD2YlB3mP7uTsTiEzJW3lopTUqQiurB5bJdQWxmCSj0JLrIYMxBnbnY5ZyO6B8dSCeVgMWWq93IfBwj94R4t6HcgbMQ32B44uBSMsfmQyRdwisUyuLA1xJ9oq1gWyqnrgqmhPl8onopt55+2AQuFp3sas00emsb5EAduSVYJA67wKbp80PHXgN3de/xneR2jV12AVpo5lrXPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DM8PR11MB5640.namprd11.prod.outlook.com (2603:10b6:8:3f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 14 Jul
 2023 22:33:27 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7%4]) with mapi id 15.20.6588.028; Fri, 14 Jul 2023
 22:33:27 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "leitao@debian.org" <leitao@debian.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] cxl/acpi: Do not swallow errors
Thread-Topic: [PATCH v3 2/2] cxl/acpi: Do not swallow errors
Thread-Index: AQHZtjYXeLXRU8ptPUqHgnBZ/Rs0kq+52fuA
Date:   Fri, 14 Jul 2023 22:33:27 +0000
Message-ID: <bef6ee32461ed5000d0f21b2c33405a9704461c7.camel@intel.com>
References: <20230714093146.2253438-1-leitao@debian.org>
         <20230714093146.2253438-2-leitao@debian.org>
In-Reply-To: <20230714093146.2253438-2-leitao@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DM8PR11MB5640:EE_
x-ms-office365-filtering-correlation-id: 13158608-085d-46be-ce98-08db84ba57a9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xAjfcXE0ZiBpO52jy87+hCXbtQ8UabumBLRwjDtVyb3t2KhGTHauimm2WERqajOYibtzfMk94V+fbb3qT2+NFwkHS4l15kNvinq6rEBWihpgZfjNlBLSsHDAFoNSMY5uDdlHjumIGtM3XauEiqONVAWEF/AUdNBNpTrO3Elg+FXKAsOEwg6Y72QDv5Al17g0I1drlC44PylFbuq6wYuhiTkmCR66DexwJQS9KQMn8+qhFo8VL8fQCotfugSxpma+fXl6FYQxCGgUtjgz07yWo9AjhL9CL9Lmzsac6bnw8O5X7Mb90GTJDGJA2ieEkY4A/5GV/V3aig/vHf8akpDpOjsB7AyMLfPEhXXDOnabySqEkRE8nfqElSKzp/zuHXBAaZn55net4VyhRNt9Pfj9+Dwv/HoNz0RHCf/kxJKhcRio7aKCiSZzqD/I/v6yrqDeOfNsbe8IZtUdm68CXgY4jpZG5dgufkLHvMiVOFifpIIYTY8RgxgNCf1K/+xj7WKlMPEbqYJSwDC8InVSGGP959VIIEAwBOXsAXp8EEBRTS2qgP6rmZq1NWvfOWCMDqNWJBmivrgRpm3MtKq99Ezub+3LB/SQ8lpDeiBWOv1NErGgqRKPkfLA5x2xGof/xYvDRN6jVqbgV1tFq1Tl6AaTDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(122000001)(82960400001)(26005)(6506007)(38100700002)(478600001)(110136005)(54906003)(5660300002)(91956017)(8936002)(8676002)(6636002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6512007)(86362001)(41300700001)(316002)(6486002)(71200400001)(2616005)(186003)(38070700005)(36756003)(2906002)(83380400001)(150783002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzhEZWErOWc0ekt4Y2VBYUE0Q1o3ZVZMSWlXbnB5LzlTb1ptSEhhWlhEUHJX?=
 =?utf-8?B?YklMNmszbk51WGhzMExtZCsyWXlwb3N6VVcrbHIyaFdQbFVZc3pOaVp6T2tw?=
 =?utf-8?B?czlNUHBqSFRxRFhVdTAveU1DaXdJamZWTnRpdVBPUkV2eS82UEJZRjVJUFAx?=
 =?utf-8?B?Y2ZSNjExZEQrL1V5THA4SGE1c3NqS3JrU1FTZTZ2dndsUkV5MjJnYk9ucXND?=
 =?utf-8?B?TWpVM3VIOFhGVHBOKzRmb01LZ1M0b2tTQklSOGorOVBBOGJiVUhNRGNJaGpH?=
 =?utf-8?B?R0hVU2k4bHN0WXhydWxpdWxIRnd0K0pueUg2aWcyV0d2WC9YczRnNUtKdlBH?=
 =?utf-8?B?Uy9wckJUWnFYbmpGZkJURkxPTXVTZ0RmWmV2SmFSelgzQjh6aENYeDZaWWlx?=
 =?utf-8?B?WVNoRitHVFJhNGVUSjN0aXMyMFplZE0vQ2tPOFJCYzRnd1laMWYvWDVpVFFR?=
 =?utf-8?B?cTZRdzhNc0tKK21RZG4rSWdES1hZbGYrT2FGc1A4dXpLc1ozckhSZzI3dXU4?=
 =?utf-8?B?QkNVQWdlR3ZoTFlSOEs0OUlBbGFFVWZTWnh5ZXhtNWtQeCtDNFFjM1ExNFNB?=
 =?utf-8?B?Q0hXYWwwQlBnMmZLckhDSnhSSVVCL3RNRFVnMFNlWjFiKytIMU12RWQrVkZi?=
 =?utf-8?B?QmxDN1VNZEV2aXNDT0JmT2E5b3ZxempNS1NoYXp6TFAxeGJHNzJmcmh4SlBi?=
 =?utf-8?B?ZU1iU25UWkpmdVZHQ21QaHp3Q0JsM29heVJXSHBsdyt6djRjQ1RQNGE2Zmsx?=
 =?utf-8?B?M0d3ZVpXYUVxUGt6RmdtUndrcXo1Z3h2U0dKZFBXWlRZZEdRMFUvU1pTRWo5?=
 =?utf-8?B?RU9NNWs1OHRPT0dsUjdLMzZzNVd2Q3FrelhKUVg5UE1rNC9UamRENjJ3MXR3?=
 =?utf-8?B?d2txaWVkcmhQSXIxdEd3Tm52MDNmbHhReVZzR3pzakRsMzBDL3lhMlJyUzRa?=
 =?utf-8?B?ekdtZjUrYXdUcngwWXU1ZjRJMVU3UVBweUNmaXZSQU1EUTNWM2dHT0htQUF3?=
 =?utf-8?B?SVpaNE1CYk5qMUtodWZ6Q3AwTG1pUFlLMktkWS92ZnFNTG1mWXhvV25rWTd6?=
 =?utf-8?B?eE52WEkvVGRheFlOZDVPaG9EQlE5NE5MeGZqd1dOa0ZmeXVsaUNrTk5Ed0Mx?=
 =?utf-8?B?c0I4ZlhrZmpTWldEQndWcXdPZFRHSXFjVGZScHYrTWJBNWVWZTZjYmgwd0R4?=
 =?utf-8?B?M1JVM014YW8xR2RzeUxGN2g0V0pxNDhWamhEbGFsMmtJeE1TUG1abHFDcFdW?=
 =?utf-8?B?TFpxUXJvZ0NRUU1icllsSkhTRGQ0cXFtYldBQXZWOFZkczg1VEpOWkdSaHgz?=
 =?utf-8?B?Q0tEcFZ4azU1RFVvRGlEVnRMNis4QzNnYy9lZXBURjJyOFByTnRmMXdwZ29P?=
 =?utf-8?B?NjlvSTdjaVJtUVZXWlVMdXB6TEFFemxzcE9ZWjI4cjA0SmdEUThwUjh0c2o0?=
 =?utf-8?B?c1Z5UlN3RzU0OTRjckFiZktKZVFLUkNKQmZFVEwwS1VxQXg2ZzJKVmdEbDlv?=
 =?utf-8?B?dFVMb3NZeWw0SkhZcDYzVm90TnR1M1NtZDh2SWtySlNJRS8wQXREdjRKOUhj?=
 =?utf-8?B?SW1XK1UzRUt0UWFNdVh0b1VWWWZrYWwzRkE1eFk4SWtmQ1FRVzh5YStpbFlC?=
 =?utf-8?B?T3RidEV0UjI5MXpHc1Z3dFlFdWx6ai9WbC9oRGwxT2xxLzgrVktTQkdRRlFw?=
 =?utf-8?B?YXhTVGhLWXJ6cWEyY3FWQlhTbSs2T0RKUzdDRWhXcEFBUURDSFk2Z2lQSVo4?=
 =?utf-8?B?VFR1dE9aa3dkUHpNTDlqSHQ5TkNCeERoYmVTblNxMEpSdmlxTVlPdU50bG4w?=
 =?utf-8?B?ODVRcHFmWjdGM1RieE9XaDZCL281ajJzaDVxb3M1OTViZjFjMkhQaUhZR2ti?=
 =?utf-8?B?V1dESVJLaTk3bmc5YmNhZmNKdEF3QWxRdUhvdnNvVDk5Y3dLb0cyYUs4NjZY?=
 =?utf-8?B?Wm9NQ0pQNkpLTy9vMTlxbEphRGkrbXN5L2xvRGtVMksxRUMzcHJOMEhxVmlz?=
 =?utf-8?B?TEJYVlhOL1NPUG9XVmZWR3BZNlZjOXFUbnJOcHZKMlF2TlpBKzJSSDZNa3pt?=
 =?utf-8?B?NHlLOXEzYkZLMEtWbUZOcWxIckRad1dWR3lRb2xTODlkS29UbVE5eFFCUWRH?=
 =?utf-8?B?ZWRYTTY0b3loUHFoZFRpalBaRmNtZ1loVUx1UmpxZU9sblpodGJ4RnlScXp5?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7631A97071F7794A874C700DC0DB93A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13158608-085d-46be-ce98-08db84ba57a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 22:33:27.2207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x859CcWY1K0jEnUcMcAj2aJ/1NQt0biiS4JhI8ImKnddYwN+mHdplkshRuNI2XWjeMooAWgJHpM9ansKoHcu/13Q4JzJ3To3WeNYA8gRxms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5640
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTE0IGF0IDAyOjMxIC0wNzAwLCBCcmVubyBMZWl0YW8gd3JvdGU6DQo+
IERyaXZlciBpbml0aWFsaXphdGlvbiBpcyByZXR1cm5pbmcgc3VjY2VzcyAocmV0dXJuIDApIGV2
ZW4gaWYgdGhlDQo+IGluaXRpYWxpemF0aW9uIChjeGxfZGVjb2Rlcl9hZGQoKSBvciBhY3BpX3Rh
YmxlX3BhcnNlX2NlZHQoKSkgZmFpbGVkLA0KPiBhbmQgdGhlIGhhcmR3YXJlIHdhcyBhbHJlYWR5
IHJlbGVhc2VkIChwdXRfZGV2aWNlKCkpLg0KPiANCj4gUmV0dXJuIHRoZSBlcnJvciBpbnN0ZWFk
IG9mIHN3YWxsb3dpbmcgaXQuDQo+IA0KPiBGaXhlczogZjRjZTFmNzY2ZjFlICgiY3hsL2FjcGk6
IENvbnZlcnQgQ0ZNV1MgcGFyc2luZyB0byBBQ1BJIHN1Yi10YWJsZSBoZWxwZXJzIikNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEJyZW5vIExlaXRhbyA8bGVpdGFvQGRlYmlhbi5vcmc+DQoNCkZZSSB0
aGVyZSBzaG91bGQgbm90IGJlIGEgYmxhbmsgbGluZSBiZXR3ZWVuIHRoZSBGaXhlcyB0YWcgYW5k
IG90aGVyDQp0YWdzIChQYXRjaCAxIGhhcyBpdCByaWdodCkuIFRoaXMgY2FuIGJyZWFrIGdpdCdz
IHZpZXcgb2YgdGhlIHRyYWlsZXJzLg0KDQpJIGZpeGVkIHRoaXMgdXAgd2hpbGUgYXBwbHlpbmcg
YW5kIHdoaWxlIGF0IGl0IGRpZCBhIGJpdCBvZiBjb21taXQNCm1lc3NhZ2UgbWFzc2FnaW5nIGZv
ciBib3RoIHBhdGNoZXMuDQoNCj4gLS0tDQo+IMKgZHJpdmVycy9jeGwvYWNwaS5jIHwgMiArLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2FjcGkuYyBiL2RyaXZlcnMvY3hsL2FjcGkuYw0KPiBp
bmRleCA2NDI5ODNkYTAxY2IuLjgxNWI0Mzg1OWMxNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9j
eGwvYWNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2FjcGkuYw0KPiBAQCAtMjk4LDcgKzI5OCw3
IEBAIHN0YXRpYyBpbnQgY3hsX3BhcnNlX2NmbXdzKHVuaW9uIGFjcGlfc3VidGFibGVfaGVhZGVy
cyAqaGVhZGVyLCB2b2lkICphcmcsDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmMpIHsNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBhZGQg
ZGVjb2RlIHJhbmdlIFslI2xseCAtICUjbGx4XVxuIiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVzLT5zdGFydCwgcmVzLT5lbmQpOw0KPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7DQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IMKgwqDCoMKg
wqDCoMKgwqBkZXZfZGJnKGRldiwgImFkZDogJXMgbm9kZTogJWQgcmFuZ2UgWyUjbGx4IC0gJSNs
bHhdXG4iLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9uYW1lKCZjeGxk
LT5kZXYpLA0KDQo=
