Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984DCC19F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiHATSl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHATSj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:18:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BD726A
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 12:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659381518; x=1690917518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n+4H7thnkXzuYQMCeGNqYLv5ykF0BkKc4281kYB9KYk=;
  b=RiLiNSOeVkNh0TcjptMIWINy4x6TN5frgPTRwXN9nSMI9Xch9wqYIEGH
   F3H1UkwPpPy+z3uPFviDcrBOwpl7O2iETFPDEOK2sco/GJlPX1wg0FQeb
   GTWEwFDor1akc5/vyt0/qR4Dds3nJhae/QUiRxz/ZwwNol+XFsudtA50L
   cFWOxo0CitiU2TCNo6HSfyhZhOfTc9dcynFFgPGHWItqGY8PZszd5M00T
   LquQUwuETKIr6st6ZNqx1C+vBIsHejf5p1q/w1n7fxTw1P7qTlriJHAlj
   WoCI/ALVWMvUfFN7V3AGvW8/NEqkZ8+akWVlKKF0F7fL8iDntJQXt15Zn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="289239899"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="289239899"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="661283667"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2022 12:18:38 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:18:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 12:18:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 12:18:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkxojuVp77QDSLvRaGNXUsE+cGRvW90EfbEpuWwiRMK+XbWfvPAF9m3dFcRISMUiReNEPMoeSdHlIVWLGrR2NsNbPHV3pT25cQEPk0CvPQsOQG1tXZ+dNeSBnXT75qw/cm3WvKWsuOPSSgr0hx6pwyQcHQ/R+YkhkBp//nsmd5MkAaIszsjTcbU2amcO7VlqGiqv/ff5iVvI/MbGLwDIKYz8MtOO63yo/Niry/7Uw/v7aPA+1xWXIX32yjZ9vJDF6UEx7lneYHnDhycmnkPUkLj9AX259DQwBjfLm5udAhMIVjFm0PQ0yXf+4aPrSoV/i4+EQRWIMyOziLg7KO2YAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+4H7thnkXzuYQMCeGNqYLv5ykF0BkKc4281kYB9KYk=;
 b=iwNWGkZa7t7Z1Z3Q7BIyZUSak+kkTryCyhb+dp+LZzgB3Uim9+GRro0vJPsMqfWBm0ptJvMvIpwyz64CW1Qu2G2AZVeblJqq7v3TlLvPUOgtW0O12OzB1MOX29zwfWiGLsDXeYxRXM0rV1NfODiN804wdM2aCrlkNGBk8iRaDiY/YnfySk31HJ0yZiABRg1FScbIvfhWjyeiaYdBpHMqhPxwD5vxEZ4sgxkhQ9xJ4e2/+zKa33koijDQt4kp870hp1UYuZorQhy8c2s8cFjTN+HvWgq9Wot0Ya8/MqTOY2qIhMjB9KKxmaMqK5u6i8HrNjzF16IUvuT6cC3Rt5snxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.16; Mon, 1 Aug 2022 19:18:35 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4%7]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:18:35 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] cxl/hdm: Fix DPA reservation vs cxl_endpoint_decoder
 lifetime
Thread-Topic: [PATCH] cxl/hdm: Fix DPA reservation vs cxl_endpoint_decoder
 lifetime
Thread-Index: AQHYogbJlwo2l0GHOU6iszQSr1tIAa2acu2A
Date:   Mon, 1 Aug 2022 19:18:34 +0000
Message-ID: <ac541d988e13d81362f9cf2056f12dc6d5082e23.camel@intel.com>
References: <165896020625.3546860.12390103413706292760.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165896020625.3546860.12390103413706292760.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c7bdef5-3615-436c-22b7-08da73f2a144
x-ms-traffictypediagnostic: DS0PR11MB6399:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KBd2NdicVrECrSB+uAr/d6vboYAhD/0n3QQWAlCWq8srWQpdPuOtkaS38jLr4CkWtL4Wq2eBhywDSCprHVxKjOJy4w46zEdgkYStN9RqMFHJe1J7lTnZ4F76El0cjJAYUtTB4bnKzaIz82yWSfaPtFQ+22R3Qjtu/ucFSGSqKc4yTDr+7msOpFGCOPypIjAiQtIWWL0xL1HT64gvbvA2sypQSUZYzMswqfYlm/A+8YqSI3NO2xpkEdlafvwbS+HzNCKx5NAx7vijp5TeJwvzbtrKVpXtM6tOXdC5DloFXwip5SZu1UIeCKNSUuSpEE3crp8YP3vj2wvLBJVS3LOS+Dn/TNSViXP/2dqFriM9TfTXW6oG5ONeWjUNGS98EB2CcJMPlWiAlfZUWbfhNi8IBdkmlaFMwAFsZnlOm88B0kshjrN5Id3ATB40iIxPbKqnu0MHhrgi9PN+CLvrw4pvbkmFc0isAnpm7Uf69SAEgdiigXoMnnN62Y9m1y6U6dcn3RYaWR1geT1xBqlmieCd721H5KJ/RN3zloGey1JKuqEP1n+OaVKrKbvTVZETNke0jZp9qtj/7iIeqyKcicMQJX8pBzL+6QfFM3rCjyX281EG1SsjU+g74b2wtQ9Ah6po1QGMWDq8gfsi9nmb5iPnvUu31fMTrBE86QTCEzErHudTy68bAIS6U4I/I/dHC+5gNRpfJPo3J3sx+uPwiwF6L0m40X0VzR4yrMqrXExH5v5tjZVxbBTWEZIPSheL3tXaImHDQDfs8qbOgYVZ3wcNpGLYrILVu8fUkQBenCITR7N9ouPCOW+C736QS2vAYXGk8R6DzqJsv2zZdSzIEbPOvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(346002)(396003)(2906002)(966005)(6486002)(91956017)(36756003)(316002)(5660300002)(86362001)(82960400001)(478600001)(110136005)(6506007)(26005)(38070700005)(41300700001)(71200400001)(6512007)(122000001)(2616005)(186003)(38100700002)(83380400001)(8936002)(76116006)(66446008)(66476007)(66556008)(66946007)(8676002)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzRmK3NkUEVJc1VuSEZ1dktOaTZ2bGJaRzdsTlhoMjUrRkFNQjY1djFTYjR6?=
 =?utf-8?B?aUF0R0pXNWc0OW9Edy91eU5ySHNCSGFUZW1kK2wvYmxtUy80a3dkYjBuTHMr?=
 =?utf-8?B?Mi9wbld0V0JVT0c0QlQwREJ1SUlxU0xBVHNmL0JOOFNjYU9GRXdWMEtNU0JZ?=
 =?utf-8?B?U1o2ek16dDI0ZEUyVDV1V0tMTS9wM214blFyQmhkMXpKMU1OL0NzcktvTDdW?=
 =?utf-8?B?SzVzWGJvYjJpWFpMeUU0SmRvekZyTTVxSUJzb3ZQcUpuOWhMMlQxUnREbzN3?=
 =?utf-8?B?c3RoMVpUa0d1RHZ6RkVqMC94TGZmV1pCYlUzNHJjM3dnRXlJdktDc2ppZGpP?=
 =?utf-8?B?Mjl3b3BudVMzVFcwdDR2NkpTamthN2lhaEFtVnYrMGl3NVhwQVNEYW5yQ3hi?=
 =?utf-8?B?VUtSeXhZRUlzeHFsb1JLVWVlc2o2eCtwdGFWVjl5K1pnQXlTbUtmeEVUTzl6?=
 =?utf-8?B?S0xjTlFseFdTMzVPZjMzQnhEVEJvdWZNWFpYOXQ1UVFsSWhKOGZLaG4rTkQ4?=
 =?utf-8?B?Z2R1dXFOdlo5YTNEdjY2aVBYWDd1RTRqVlUrQ1d4ZTZkY1RVWlpGdjlrR1E1?=
 =?utf-8?B?VHRtRjh0T3JHN2w3MWVhMFA1ZGJCMjE1d1V3QU5qcGx0RGtBL2xMa1dML2wy?=
 =?utf-8?B?U0dzKzRybldHeHlDMGd4WGFGUjNxcGVQd0MwcGpmbTRVU1hJY0NqenFEemVk?=
 =?utf-8?B?VEVlSi91WmE1emFMRXJRUExiTFNuZWZiTm02bmQ2ejB0SGc2N2VKSW5QR2Rw?=
 =?utf-8?B?R1QzRGhTd3d6aTVRbEo0Tm5CalNOV3NmYWtOTzMySVJNRHN5U1lpNmZ0WkVj?=
 =?utf-8?B?V0dhS1gxZDFqMWcyYWxjNWI5NEw4dk40a0huT1lDS3NURW5ES0VWMzBqMk81?=
 =?utf-8?B?dkJqUzlFdVFDRjFWTDZQZ0MydWdUTzE0ZXlGOXhYMEQ2Mit3ek1jZnR1enJ4?=
 =?utf-8?B?Q1BpREplTUdPU09hWnMyVFNGUURiYmFleDJ2bkt5SjBxYUZkbjhNaW5mSU5P?=
 =?utf-8?B?Q3BXdDJOQkxXcE9HRDh3MktkTm51WVNvQlZkMURTSEw3VnZIQUFZckdGcS9T?=
 =?utf-8?B?ZllDdFB3MkM0S0FYUnU4eTBnbVB2R3lhUG1OR3FnbUFQdU9oNUplbXpGODJv?=
 =?utf-8?B?WGwzVzFZZmtDdnlrckJMQjF2Vnh1NWNiWnZPa0JURk9BaHBWSXRzL0RPNTU3?=
 =?utf-8?B?U3JPVGpUdTMxTW9vbDhKcGVheHo4RVZERkdWbTdXbVd0TlpIa2xDQytpdnYv?=
 =?utf-8?B?TVRMRDd3akEwYXNZZVg0RSt0SkNDNWFZT1U0emV5Sk1HUE9acUt5RWd0Y2Yr?=
 =?utf-8?B?Ukhkam1BdEEzdGNJaEEwYzBWc21hbXMxUGxXK2ptajlyblNBMVdQQjYzd0M5?=
 =?utf-8?B?TnRQb0d1UzduUDhteWdQSzkzeXZ2a1pxT2IrdmQxRVA4bzdqNll4d011em5Y?=
 =?utf-8?B?QkdyTnV2OC9teUsvWUdZeXlKMldQM3E4MUduTTdoWTFxd0E3b2JWWE1PZS96?=
 =?utf-8?B?YTJIQ1dWTnNuenU0QldEb0hpekJoQ0VQWGs2L1ZCaU1yWEg5UXNNTkJpQXRL?=
 =?utf-8?B?alV6Q2tQTXovZTJDb3R2NkZhVFNuQ2VkVmREZS9rZktqcDhjUzJsOHJTMSt0?=
 =?utf-8?B?bzNhRFRUSFM0ZlNaT1Z6cDNYblViSFkvSDdneEhJYnpLWFVQOHA1bEIycFRz?=
 =?utf-8?B?UFVBRHRxeVFheXd6V0VxTFpVRlR0N0ducTh2NU02YmFwdkYxbFBuUDFJYjg4?=
 =?utf-8?B?UmFISDVmZUs4UElRa3JWNlhIdlo4M1BIc1VQS3hkRk43MUJMQzNmYlhrVU9k?=
 =?utf-8?B?eEhHS2VjM1g0bi9OeUFNQTRpdFdTb2VIRkQxTEtDVVZOTnpLSGJWc1BaRmhq?=
 =?utf-8?B?OTkxRzd2R2lJZ0VLTUpoRlU4UEdjODFiK1p0SVdRc2hyYWU3OW1qd0U4SnF2?=
 =?utf-8?B?bjYyOUcrYXBYWThST1F4dnZ1MUVpSmVyZjhCS2RXSG1raFVvRmlDcnV0Wk5Q?=
 =?utf-8?B?TEdZM1VQUDlTVDhVcXdhOGhIWllRdzZYRnN4bjREZFhHVzdOVjh5d3JWVFFY?=
 =?utf-8?B?UDRneGhGOWNROG5QQmVyWk5XZlpJKzlMUG9PMCs1Q3Fxblhqd1J4UGlVNHoy?=
 =?utf-8?B?TDlPQm42VWYvK2Q5SHhSdDhBR1JFQ2U3N1Mvb2liUUJIbmpPZHhYRzRWeEZP?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AFDCAAB9528B74C92F73F1A1F2D8A14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7bdef5-3615-436c-22b7-08da73f2a144
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 19:18:35.0754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3s/Kz6Y7bF7qPVJkmywyyAM0vqjxcbtlNPZtL4F3MwdWEGMu/xD5KDJEUTiTjt+nDOaLuqioAWFg1ohj3mfx9yOiIphIAgabEmpTKU2rMy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6399
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gV2VkLCAyMDIyLTA3LTI3IGF0IDE1OjE2IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEFmdGVyIGFkZGluZyBzdXBwb3J0IGZvciBlbXVsYXRpbmcgcGxhdGZvcm0gZmlybXdhcmUgZXN0
YWJsaXNoZWQgRFBBDQo+IHJlc2VydmF0aW9ucywgdGhlIGN4bC10b3BvbG9neS5zaCBbMV0gdW5p
dCB0ZXN0IHN0YXJ0ZWQgY3Jhc2hpbmcgd2l0aA0KPiB0aGUgZm9sbG93aW5nIHNpZ25hdHVyZToN
Cj4gDQo+IMKgZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0LCBwcm9iYWJseSBmb3Igbm9uLWNhbm9u
aWNhbCBhZGRyZXNzIDB4NmI2YjZiNmI2YjZiNmJjMzogMDAwMCBbIzFdIFBSRUVNUFQgU01QDQo+
IMKgWy4uXQ0KPiDCoFJJUDogMDAxMDp0b19jeGxfcG9ydCsweDgvMHg2MCBbY3hsX2NvcmVdDQo+
IMKgWy4uXQ0KPiDCoENhbGwgVHJhY2U6DQo+IMKgIDxUQVNLPg0KPiDCoCBfX2N4bF9kcGFfcmVs
ZWFzZSsweDFiLzB4ZDAgW2N4bF9jb3JlXQ0KPiDCoCBjeGxfZHBhX3JlbGVhc2UrMHgxZC8weDMw
IFtjeGxfY29yZV0NCj4gwqAgcmVsZWFzZV9ub2RlcysweDYzLzB4OTANCj4gwqAgZGV2cmVzX3Jl
bGVhc2VfYWxsKzB4ODgvMHhjMA0KPiANCj4gLi4uaS5lLiBhIHVzZSBhZnRlciBmcmVlIG9mIGEg
J3N0cnVjdCBjeGxfZW5kcG9pbnRfZGVjb2Rlcicgb2JqZWN0LiBUaGlzDQo+IHJlc3VsdHMgZnJv
bSB0aGUgb3JkZXJpbmcgb2YgaW5pdF9oZG1fZGVjb2RlcigpIGJlZm9yZSBhZGRfaGRtX2RlY29k
ZXIoKQ0KPiB3aGVyZSwgYXQgcmVsZWFzZSB0aW1lLCB0aGUgZGVjb2RlciBpcyB1bnJlZ2lzdGVy
ZWQgYW5kIHJlbGVhc2VkIGJlZm9yZQ0KPiB0aGUgRFBBIHJlc2VydmF0aW9uLg0KPiANCj4gRml4
IHRoaXMgYnkgZXh0ZW5kaW5nIHRoZSBsaWZlIG9mIHRoZSBvYmplY3QgdW50aWwgYWxsIERQQSBy
ZXNlcnZhdGlvbnMNCj4gaGF2ZSBiZWVuIHJlbGVhc2VkIHdoaWNoIGFsc28gcHJlc2VydmVzIHBs
YXRmb3JtIGRlY29kZXIgc2V0dGluZ3MgYmVpbmcNCj4gc2V0dGxlZCBieSB0aGUgdGltZSB0aGUg
ZGVjb2RlciBpcyBwdWJsaXNoZWQgaW4gc3lzZnMgKEtPQkpfQUREIHRpbWUpLg0KPiANCj4gTm90
ZSB0aGF0IHRoZSBAbGVuID09IDAgY2FzZSBpbiBfX2N4bF9kcGFfcmVzZXJ2ZSgpIGlzIGF2b2lk
ZWQgaW4NCj4gcHJhY3RpY2UgYXMgdGhpcyBmdW5jdGlvbiBpcyBvbmx5IGNhbGxlZCBmb3IgY29t
bWl0dGVkIGRlY29kZXJzIGFuZCBuZXcNCj4gbm9uLXplcm8gRFBBIGFsbG9jYXRpb25zLg0KPiAN
Cj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL3BtZW0vbmRjdGwvYmxvYi9wZW5kaW5nL3Rlc3Qv
Y3hsLXRvcG9sb2d5LnNowqBbMV0NCj4gRml4ZXM6IDljNTdjZGUwZGNiZCAoImN4bC9oZG06IEVu
dW1lcmF0ZSBhbGxvY2F0ZWQgRFBBIikNCj4gQ2M6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFu
LkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4u
ai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvY3hsL2NvcmUvaGRtLmMg
fMKgwqDCoCA3ICsrKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KDQpMb29rcyBnb29kLA0KDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1h
IDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2N4bC9jb3JlL2hkbS5jIGIvZHJpdmVycy9jeGwvY29yZS9oZG0uYw0KPiBpbmRleCBlZTUzZThh
YzVjOTYuLjgxNDNlMjYxNTk1NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS9oZG0u
Yw0KPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL2hkbS5jDQo+IEBAIC0xNzgsNiArMTc4LDcgQEAg
c3RhdGljIHZvaWQgX19jeGxfZHBhX3JlbGVhc2Uoc3RydWN0IGN4bF9lbmRwb2ludF9kZWNvZGVy
ICpjeGxlZCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX3JlbGVhc2VfcmVn
aW9uKCZjeGxkcy0+ZHBhX3Jlcywgc2tpcF9zdGFydCwgY3hsZWQtPnNraXApOw0KPiDCoMKgwqDC
oMKgwqDCoMKgY3hsZWQtPnNraXAgPSAwOw0KPiDCoMKgwqDCoMKgwqDCoMKgY3hsZWQtPmRwYV9y
ZXMgPSBOVUxMOw0KPiArwqDCoMKgwqDCoMKgwqBwdXRfZGV2aWNlKCZjeGxlZC0+Y3hsZC5kZXYp
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgcG9ydC0+aGRtX2VuZC0tOw0KPiDCoH0NCj4gwqANCj4gQEAg
LTIxNCw3ICsyMTUsNyBAQCBzdGF0aWMgaW50IF9fY3hsX2RwYV9yZXNlcnZlKHN0cnVjdCBjeGxf
ZW5kcG9pbnRfZGVjb2RlciAqY3hsZWQsDQo+IMKgwqDCoMKgwqDCoMKgwqBsb2NrZGVwX2Fzc2Vy
dF9oZWxkX3dyaXRlKCZjeGxfZHBhX3J3c2VtKTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoGlm
ICghbGVuKQ0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHN1Y2Nlc3M7DQo+IMKgDQo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoY3hsZWQtPmRwYV9yZXMpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkZXZfZGJnKGRldiwgImRlY29kZXIlZC4lZDogZXhpc3RpbmcgYWxsb2NhdGlv
biAlcHIgYXNzaWduZWRcbiIsDQo+IEBAIC0yNjYsOCArMjY3LDEwIEBAIHN0YXRpYyBpbnQgX19j
eGxfZHBhX3Jlc2VydmUoc3RydWN0IGN4bF9lbmRwb2ludF9kZWNvZGVyICpjeGxlZCwNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3hsZWQtPmN4bGQu
aWQsIGN4bGVkLT5kcGFfcmVzKTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
eGxlZC0+bW9kZSA9IENYTF9ERUNPREVSX01JWEVEOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiAt
wqDCoMKgwqDCoMKgwqBwb3J0LT5oZG1fZW5kKys7DQo+IMKgDQo+ICtzdWNjZXNzOg0KPiArwqDC
oMKgwqDCoMKgwqBwb3J0LT5oZG1fZW5kKys7DQo+ICvCoMKgwqDCoMKgwqDCoGdldF9kZXZpY2Uo
JmN4bGVkLT5jeGxkLmRldik7DQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCj4gwqB9DQo+
IMKgDQo+IA0KDQo=
