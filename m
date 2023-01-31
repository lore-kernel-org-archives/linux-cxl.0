Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC65C636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 19:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjAaTqM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 14:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjAaTqK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 14:46:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C112568B2
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 11:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675194365; x=1706730365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R/IxumMaW7QUorC5n2TOJ8URosr6qLv6mOhl7TReDHk=;
  b=hytZ6/1U0ua1miLtmYlV0/uZRrA7pQf6bbcyiydcdtViD7BZXjKGKc+1
   I3nL3mdO0J0SQ/TJTyDXxGKRa9/Drbnia41Pc09w6iIuXoZYOjg9sIeqI
   MNEho9UPi02Nfo/obZQJGd9pM/y5X3X1TIZP6m0FMIPXyr05Y11ucbcMc
   6h3Ntz+4/FO5jvzdXqMViCcY8XsijL9kcYskZtVDjnEriwb3MS5jnMz0b
   wru/hVMw71MTHRBvMJKkGpK8fFx/j1TB7ULphCdi+ulutg2i1GATG32SX
   g2s0ZnY+OImanQgIlwbjDakIodD+LIcrJOUbEkDE2XGhJvLIdvHVQ8V/H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="355266581"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="355266581"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 11:46:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="753356900"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="753356900"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2023 11:46:04 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 11:46:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 11:46:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 11:46:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDBiNpORwAqVlnelXhspnkrobCCSEQDZmRMU+ztrLqCPpACMzrdhSLHyJ1oqapt8p7Upl7kJQJtRWYPnllIJYUS5efSvhUXheg/YEnbts91jdf0xo70zSwQcTxG/UcNcNgFj4S92ZGvJVOrzS7lTaYFIrVZenA1IMhjZguE9wDC7UpKHlRNtj+Aw/Qzi1HD+tmmUujR1MmTkFXuD6dhx0aBLTXLDwSzO0lm824daQZXNHi82IbDNR38wryy+fG2xhkr+mTchvw04zGuq8fow5m3Stmj3USTAWj9q09dHA/CMEYOhhT+5ialYOU96jwLCmdRfyGWYYGLglGekoVDtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/IxumMaW7QUorC5n2TOJ8URosr6qLv6mOhl7TReDHk=;
 b=aDxZr2fKs6srqkfksBjFPze4RPTKKJHZcEofDsEpdoK+aX+AgziLmWv2ih4tfkuiXY//f/0+Ff5tUmni4zHI4vLKu3AEieZctlLa2lot6wSMP+URuuD8iNX1Yqyt8bVOsb8yXONJhihxVZdkg8D8jChsFG606/ah1YUwyGVZ9OhUpscTUnH71Dp/1SrptVBqfQgR36N7Ex+6Q7XyhXIQ7nSLNhmqiClgD+cCstrghb3bG/N6H/Yyho95miyUpJSyFojayUYUxrHeLO9iODaFLtBMcBKsZenYCSqJRjrtxna88PxjfAFUdgvx/zLae+Fm6ymQzfuvI2iOT/U6m1ExWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 19:46:02 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c%5]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 19:46:01 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "gregory.price@memverge.com" <gregory.price@memverge.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Thread-Topic: [GIT preview] for-6.3/cxl-ram-region
Thread-Index: AQHZMU8Tzl/mI+opREuUxaim5hiM666wPGeAgADPFICAAAxKAIAF8J4AgABisQCAAA13gIAAJzQAgAAtVgCAAQvNAIAAEceAgAAMAAA=
Date:   Tue, 31 Jan 2023 19:46:01 +0000
Message-ID: <5b6cbfda865010219a6cfa79b5d52679cc0b8a4e.camel@intel.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
         <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
         <20230126185025.000016a0@huawei.com> <20230126193424.00005034@huawei.com>
         <Y9fRVu+yLza4d5Vt@memverge.com>
         <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
         <Y9gva49IPFOXYlkH@memverge.com>
         <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
         <Y9h2VhGuraZfEJfD@memverge.com>
         <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
         <Y9ll5S3Y4BZkakNn@memverge.com>
In-Reply-To: <Y9ll5S3Y4BZkakNn@memverge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DM4PR11MB8132:EE_
x-ms-office365-filtering-correlation-id: b8bc39b8-2b6b-4781-6b99-08db03c3c867
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9lMydSO4DgQ1rlXbxAWBjZ91haOncynAXlxJ4++s74ZZQkQ16ppCfOHEGYDXJkfGVKgFqVdhJ3gWIJAGfFW6fMxvGLkrT7qLNPNhJ5LB+3IKpYJzCeWYiyQ77avjMfZUz24KSzURtqPfhwGQPvjuIJMgR2R8bSuuQspWCd1hQLb5bD1I69nt4qNPUgsrfpGyOOou6ZaKP1g3JZh/Uep0AHzbyTqPgW5KOrV354ioyx1fUq+jbnV5PRxpWzbFJBYSDNOQOt5qfYrOgaonEl+zk27NADIOI+AAOmeuxbra08UTyexHCr8oaEXAvJS8ZKfYWx5p6Fvqh8Oe9G5Pak4Kj5yEiKSEBCtQqCfEg+o14qbBlRCshGcefMCLGabtcgxbfxENXZkYQU6GamFW/+G7wX1C/h2N8Hur0F3NuW/r/oz28NzGg9J8LtXwff/98Ea276ma+TnS5yNulV253HVSJD19j0W9u2vBY/ta43bJ11migy+uN902/lLTP7BdEIoiVbgPuWJVTFTQEcx/DILLbhIS1/knHnortdZ/H3e4ZcfIOU4zidVGYllfPJy3BQyVAoRWUCAzP284m80EeEGzeo3BnRUQxr+aPFcBAG70LTaLgbgzvuQIjb4XwZ9W1Yb3qhXYVdK9F6ldiCAyGS/a6THk5HZbxWwMaRkh9iHwT3vuor0LTNqQiUshPQpzeEodEwYXayZrI1AW/Z6I55uvdJXtH+/ILmBTJ+rNQ3FohfE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199018)(36756003)(5660300002)(2616005)(54906003)(316002)(83380400001)(478600001)(6486002)(966005)(71200400001)(6512007)(6506007)(26005)(186003)(41300700001)(82960400001)(76116006)(8936002)(86362001)(38070700005)(66946007)(66446008)(66476007)(64756008)(8676002)(38100700002)(6916009)(4326008)(66556008)(122000001)(91956017)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTY1RHV5UysyeTc5WEg0NjJKN0xyRW1tdythWVd6akxVWXh0NzFmNWE5MUl5?=
 =?utf-8?B?bVNVWk9GRWRKcVBFYXhQc042T2RRZWNBNmhKQzIxbkx2NmdSRlFWdkV4L1J3?=
 =?utf-8?B?VzdMR3c0OTVvejZZRkZvMTdYVnFmVHJxckZuQkRwUXRtMFQ4YjdCR1ZCZmZv?=
 =?utf-8?B?T0xlYWw0TzdxZCtPSzhWMngvcjhTa0JkRE1GbmZHdXUwNXp5bTJLdWhnalZC?=
 =?utf-8?B?b3lsaGx0UW5LZGs0bERBWUlLZVVuTWFoYVdwSHZUdmV1Z24yaG1IS1B6ZTlm?=
 =?utf-8?B?ay8vaFN5ZVhhTCtvb2lQYXBPaTJmaWZoODk1TUpWMi9XRGxZR3RzU3AxbDBl?=
 =?utf-8?B?TlV3bjZVQUJpUXRrajBIek0xUEt3VERxeWtwbHI3bkdzOVZDYlZGeEgydlNI?=
 =?utf-8?B?SklXU2grbkVqb0lzL1Q5R3Y3ZThhVzZYTm1RbmdVdHEvZWlyTTRWYlkwWjdC?=
 =?utf-8?B?NzBHRis4aDlHamRhWTI2MHRobDNnSlpWbFYwb1EwMU9YRGMyQWFrY3IxZzdm?=
 =?utf-8?B?NlIyMktnbFk3RUY5cXdNei9ncm12WVVVenVaRHdxQS9pWFdFalRZWlcrSDlw?=
 =?utf-8?B?TXZDMkJEUXRHSDE1ZHUyMkhZTUxyUUJ1YnRQQk1NcFhrcFNFNGMvWkRiRWxN?=
 =?utf-8?B?OVY3UTNLOFV6Y2NDRFYyMlhvYXRGN245RWFVbklHY0dZUlp1L3RoMEdxalRh?=
 =?utf-8?B?cTVOU3YvWnBhdkxSeWlNY1FtUUUrQk14aVZJdWhuREFPeUxQTS9nR01ROCt0?=
 =?utf-8?B?cG5vZU1lcXYvVTdSSU5YRTZ3SHorLytsekRiekRBSUtIQzhGWlQ3WmJyTEJ1?=
 =?utf-8?B?cWRLUGZMdkNFY3ozaFdQOXo2Wkh4TGJ2VnRIWXhwVlh3dVhGNHpkd3dRQlJm?=
 =?utf-8?B?UGNDMGtGZDl5YXN0a0kzTUsvb0FyejVaaTNacUhGdUJUWHJ1dWtVdkc3RHov?=
 =?utf-8?B?RENHR1hKM2haN1RzTUpGVlpIVnhnTnJ6QmlCbi82NUlCekp5dlg0ZjBoTUdu?=
 =?utf-8?B?b0UvZG5zaFNjSDl1djlsaHVNMzF6OHMxbWl5OUtERXRpRFNJWmpjQVZVOEtR?=
 =?utf-8?B?RlA5SlZ0bjlUOEVZUWdIZjU3VzJvRk9FTyt5SXNzT3NTY0JPbFdEUjlSNG1F?=
 =?utf-8?B?b09Hb0xFL3g5d2MxV2hDTFpWdEs1c0F4Mkg4OEkvVGVTaXRkSWtQcW1MNk5D?=
 =?utf-8?B?VXl1cmJVYTRnbnZDTnhnakgrbnJGbjNRd1FyZi9OUExJYlBtY0pVbnZIT2or?=
 =?utf-8?B?UWF6c0RxR013SHNuSmtaSFNmMzRUc0dzN21CSS9BUlkwQ3h1OEczK3N4dUFx?=
 =?utf-8?B?dWdnY2t3NmZoYVlYMHpPYndhbUtha3pRMVFWcGFxNmdTdGV5Y2FZYm5TMFR0?=
 =?utf-8?B?dzJxbEUwVDFGdWd0US9wSmhJTGw0cElxOHlzVkpxRXdDYkNULy8za25RZkRT?=
 =?utf-8?B?dTlNdlFNT3R0NTNoTnpLcUFzZWdSK1FtUnp6bTI2R2gvK29KMlJkS2ZvK0Uz?=
 =?utf-8?B?dVFSd0J3Q2RLYWZEVlZUN0oxSzZBQzBuUGZGSkFNMkVMNEtNUW80ZGRQMEFq?=
 =?utf-8?B?dHNKNXd4OXh3WTN4VWV6WCtuOGhZVTRJWkJXWVpRQjBtcjBkRGttS0x2YnNG?=
 =?utf-8?B?RU5Db1h6R0p0VFV2NU1ENDRNR3dNRFJvRzZIRlBsRzdjS2RnTWVndXh5bDAr?=
 =?utf-8?B?elNSV2VMRDU3a0NTNDk1bU9tUnVScGNkaWFNb29GYmRDaUJmdnNPU3RZVmVK?=
 =?utf-8?B?UktDOHhjT0I5ZUpXOGJKQ3NJOWp0NG9KcDR6eUxVd0srbll6UGhOR3Fnbk5v?=
 =?utf-8?B?ZGgzUFpuUDdvdUFGZlM4NnJsN0xqZDZHd3VveTNLZWxZUENieElvQXR4dVB4?=
 =?utf-8?B?bGVZbWVVbG9vT1NRMlZCTzlxMUgrdmFQblREZTd3ajlNSE5UcWdGZ0hyelFE?=
 =?utf-8?B?MlA5bFBtVUpyVFRXYm5oYWtGU0lwTUNVck0rOVdDQ0xoZ0o4NXRpYjBpQlYw?=
 =?utf-8?B?YnhoUVQzWXYrUGdKMEdOWWNUVGR4STZkc1dsVnd3NlV2VUFWeUQvbGpRWHRP?=
 =?utf-8?B?NTNER1RYeWtFZVVqS2xzamhibXRUS1E0R2xjWXNlMmlaRm95citKR0pkbUI1?=
 =?utf-8?B?NkxYZ1EvaWtZRzFuQXFtaFBwUndpMUwyTGxud3BLZkpwK25XT0M1QUs3MEYx?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADBD5C314A60D6438867E94D60265C29@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bc39b8-2b6b-4781-6b99-08db03c3c867
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 19:46:01.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6xv1WgZsyVfXYk1OKldN2ihya13csr6ciizQww3mpoiJmE3+c467lXCn2Vpv5bXI08RwiDR6kGmnB4gt4q9dyvIXiFbN/YsEbRwchH3u0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8132
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTMxIGF0IDE0OjAzIC0wNTAwLCBHcmVnb3J5IFByaWNlIHdyb3RlOg0K
PiA+IA0KPiA+IEkndmUgcHVzaGVkIGEgY3hsLWNsaSBicmFuY2hbMV0gdGhhdCBpbmNvcnBvcmF0
ZXMgdGhpcyBmbG93LCBhbmQgYWxsb3dzDQo+ID4gZm9yOiBjeGwgY3JlYXRlLXJlZ2lvbiAtdCBy
YW0gPG90aGVyIG9wdGlvbnM+DQo+ID4gDQo+ID4gRmVlbCBmcmVlIHRvIGdpdmUgaXQgYSBzcGlu
IQ0KPiA+IA0KPiA+IFsxXTogaHR0cHM6Ly9naXRodWIuY29tL3BtZW0vbmRjdGwvY29tbWl0cy92
di92b2xhdGlsZS1yZWdpb25zDQo+IA0KPiBSaWdodCBub3cgSSBiZWxpZXZlIHRoaXMgaXMgZmFp
bGluZyBkdWUgdG8gdGhlIGludGVybGVhdmUgYW5kIHNpemUgbm90DQo+IGhhdmluZyBkZWZhdWx0
IHZhbHVlcw0KPiANCj4gLi9jeGwgY3JlYXRlLXJlZ2lvbiAtbSAtdCByYW0gLWQgZGVjb2RlcjAu
MCAtdyAxIC1nIDQwOTYgbWVtMA0KPiBjeGwgcmVnaW9uOiBjcmVhdGVfcmVnaW9uOiBjcmVhdGVf
cmVnaW9uOiB1bmFibGUgdG8gZGV0ZXJtaW5lIHJlZ2lvbiBzaXplDQo+IGN4bCByZWdpb246IGNt
ZF9jcmVhdGVfcmVnaW9uOiBjcmVhdGVkIDAgcmVnaW9ucw0KPiANCj4gDQo+IGFwcGVhcnMgdG8g
YmUgZHVlIHRvIHRoaXMgY29kZQ0KPiBzdGF0aWMgaW50IGNyZWF0ZV9yZWdpb24oc3RydWN0IGN4
bF9jdHggKmN0eCwgaW50ICpjb3VudCwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBwYXJzZWRfcGFyYW1zICpwKQ0KPiB7DQo+IC8vIC4uLiBzbmlwIC4uLg0KPiDCoMKgwqAgcmMg
PSBjcmVhdGVfcmVnaW9uX3ZhbGlkYXRlX2NvbmZpZyhjdHgsIHApOw0KPiDCoMKgwqAgaWYgKHJj
KQ0KPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmM7DQo+IA0KPiDCoMKgwqAgaWYgKHAtPnNpemUp
IHsNCj4gwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IHAtPnNpemU7DQo+IMKgwqDCoMKgwqDCoMKgIGRl
ZmF1bHRfc2l6ZSA9IGZhbHNlOw0KPiDCoMKgwqAgfSBlbHNlIGlmIChwLT5lcF9taW5fc2l6ZSkg
ew0KPiDCoMKgwqDCoMKgwqDCoCBzaXplID0gcC0+ZXBfbWluX3NpemUgKiBwLT53YXlzOw0KPiAq
KsKgwqDCoCB9IGVsc2Ugew0KPiAqKsKgwqDCoMKgwqDCoMKgIGxvZ19lcnIoJnJsLCAiJXM6IHVu
YWJsZSB0byBkZXRlcm1pbmUgcmVnaW9uIHNpemVcbiIsIF9fZnVuY19fKTsNCj4gKirCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVOWElPOw0KPiAqKsKgwqDCoCB9DQo+IA0KPiBTbyBib3RoIHNpemUg
YW5kIGVwX21pbl9zaXplIGFyZSAwIGhlcmUNCj4gDQo+IGVjaG8gcmVnaW9uMCA+IC9zeXMvYnVz
L2N4bC9kZXZpY2VzL2RlY29kZXIwLjAvY3JlYXRlX3JhbV9yZWdpb24NCj4gY2F0IC9zeXMvYnVz
L2N4bC9kZXZpY2VzL3JlZ2lvbjAvaW50ZXJsZWF2ZV93YXlzDQo+IDANCj4gY2F0IC9zeXMvYnVz
L2N4bC9kZXZpY2VzL3JlZ2lvbjAvaW50ZXJsZWF2ZV9ncmFudWxhcml0eQ0KPiAwDQo+IGNhdCAv
c3lzL2J1cy9jeGwvZGV2aWNlcy9yZWdpb24wL3NpemUNCj4gMA0KDQpBaCAtIHRoaXMgcmV2ZWFs
ZWQgYW4gYWN0dWFsIGJ1ZyBpbiB0aGVzZSBjb21taXRzIC0gdGhlIHNpemUgYW5kDQplcF9taW5f
c2l6ZSBkb24ndCByZWZlciB0byB0aGUgcmVnaW9uJ3Mgc2l6ZSwgaXQgaXMgdGhlIGNhcGFjaXR5
IG9mIHRoZQ0KY29tcG9uZW50IG1lbWRldnMuIFJpZ2h0IGFmdGVyIGNyZWF0ZV9yYW1fcmVnaW9u
LCB0aGUgcmVnaW9uIHNpemUgaXMNCmV4cGVjdGVkIHRvIGJlIHplcm8uDQoNCkhvd2V2ZXIgdGhl
IGJ1ZyBoZXJlIHdhcyBhIHBtZW0gYXNzdW1wdGlvbiBJIGhhZCBtaXNzZWQuIFdoZW4NCmRldGVy
bWluaW5nIHNpemVzLCB3ZSBvbmx5IGxvb2sgYXQgcG1lbSBjYXBhY2l0eSwgd2hpY2ggaXMgd3Jv
bmcuIEl0DQpoYXBwZW5lZCB0byB3b3JrIGluIG15IHRlc3RpbmcgYmVjYXVzZSB0aGUgbWVtZGV2
cyBJIHVzZWQgaGFkIGJvdGggcG1lbQ0KYW5kIHJhbSBjYXBhY2l0eS4gSSdsbCB1cGRhdGUgd2l0
aCBhIGZpeCBzaG9ydGx5LiBUaGFua3MgZm9yIHRyeWluZyBpdA0Kb3V0IGFuZCByZXBvcnRpbmcg
dGhpcyENCg==
