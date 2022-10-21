Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A6FC433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Oct 2022 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJUHfN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 03:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJUHfM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 03:35:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7155CA52CB
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666337710; x=1697873710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FZGukhj0xexvaK/GenzOVFjucx64/OpzEm7AOafRbxk=;
  b=VEaCst/AZhcv5V2pG3NtT8jUiZOXDYSsjTJA+dtPA321i9gMfoAihQAB
   nMVpOjtuNk5QS9RJRSisnsj5Y4qN2TydWm06d0ey6rQUBx4xwPUkNjhpk
   po8vYnWw4hVtMo52F2ghIB0GEBzLibyBh+2/baDnyM66u6Pz8Ie+mfGCp
   YuryBpHaIH145Rir58CER5pX0P0YdrVg3ihf17LHIaTLD/r08BwklhZ9G
   JLzAbMPAchNa10FkWO5hXtbbxRfGTo+6NOcVUktcOmcQt2X575eDhbBTS
   oBntU2JGDTPXrGJs9suB79/+xfVsCwX3RkfebhgVinHP9yOEqokWq+zVV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287341351"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="287341351"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 00:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="661455203"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="661455203"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2022 00:35:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 00:35:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 00:35:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 00:35:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 00:35:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbfsaHNAnq872E7QVdHhW37cNNGnqUMlPN7uNXyyXwkZoe0wTAuzIQQMVYAyps1uviH1f5rmHjSJin9EVLsbaSJ+rVzLUU6+iVa/0hS/cJXNz7YmKojjPYJvcMGXx6LaY6xWNvq5qGCpmgmH4YsZbyVfr9mfLyNbT6fdcUdFfE6QDOWD8lQXEFysaujlpyHS69Iy5BfQAMeXfA2m013tbbU/siR+8SEJFiSkh2RSbs99LNhWpmoLBFR0uMfyWNiy0WEasiTtfGFZKWZ9UiT4jTTkxEBhsBBP0esZBeqNpBqgWzV4w9RFCPmBaMlPceRwYNhANppyj8fWhiIXdLRKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZGukhj0xexvaK/GenzOVFjucx64/OpzEm7AOafRbxk=;
 b=DJSXUFrBLaHNNuBAaw4gh1sZxdz/vTb5g9eYyw1ePGC40StrN6ToPMQC2idAJDB9I2UgBbADEAwj3Ksi2G+qinAToHRIdwEee7C/UVO7tF+8tYxHSqeLidpmVuJR/Nri5Y0ncSsl+nOjTEyYYx0gSODJagrW1Vpxdx2yQxoavbmGrhTAucM5+1IxqBMrhm+AbnWkY0WSBKn+8kTdepS3YMJwbPvFqHKsMqa1DF0hOwlrrRitboQSivDQNrMclWf4WlmijkTPbykaHQAd3SLFgLGwiv3tcwO36cD9P9wE8Lo8zNuxe04OnbVgHN8r7+HSwXFWQtVndA3nM2T48snYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM4PR11MB5389.namprd11.prod.outlook.com (2603:10b6:5:394::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 07:35:02 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 07:35:02 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "wzhang@meta.com" <wzhang@meta.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Zhang, Jonathan" <jonzhang@fb.com>
CC:     "jonzhang@meta.com" <jonzhang@meta.com>
Subject: Re: [PATCH 1/2] libcxl: add accessors for Get Alert Configuration CCI
 command output
Thread-Topic: [PATCH 1/2] libcxl: add accessors for Get Alert Configuration
 CCI command output
Thread-Index: AQHY1381cSl/DxoslEWB+TO24VAPpa4YjvWAgAABTYA=
Date:   Fri, 21 Oct 2022 07:35:02 +0000
Message-ID: <5943c29225376a17f293ee737187db2e04582dd9.camel@intel.com>
References: <20221003232306.1326511-1-jonzhang@fb.com>
         <20221003232306.1326511-2-jonzhang@fb.com>
         <653c03ca1601bae7b3490458a48c5d6ecbe69982.camel@intel.com>
In-Reply-To: <653c03ca1601bae7b3490458a48c5d6ecbe69982.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DM4PR11MB5389:EE_
x-ms-office365-filtering-correlation-id: 5e232d49-76fb-48f6-ff70-08dab336c417
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1icCnvfpMUnFOjJJZeRkMYMq6PmEnbldAjJ23GzPyqVLJHQmcyOu1VZHGWqPc9i8kNeGEpujN5M1/MBKd6obzMR6sot1i96EKxj3jsQAzZTX+ICaF77gZX1mYONGY4boS2DGpfFGNqG7Rm2CnpBN9Gz2Ax/AaeIX8VDOG7H9o5XWuOHDDcMKxrI93JFLs+zjqNx5+3lmwlHz4021Su5MD4QW1LnwDClW7iehletJK056uq15fastcun+hIeatawajiqtKFCCthbdppmeAhD2bmyfrLFVALQISWLM/TnaZmb9+CNmTYjfAgEI4ENnsOKsMfuZ5adkbXjoUJugb1XJKjosMiuHrMreByx7RBvcWeEmupiKQ5ttVj9VJvjovvhht7+ENqcJVhdYtQiLxEFRPJluut+IetCPqNEtfo+Qjadt8i1EfgPEzeANstDW0Flh+Iomx8ipDMxZ4ta7tgrem+VdBY7B2vhNPJ0XynFtmA0DEOi0Mm/U+CsqBzANXkxAAlLTOK6nSH7h2Xxmc1FzgflKRYCZdAInZfiqow/K/8RPSPibLHgBYvOoZ+BCN+rz5Vu0AFz4g80yd/WjdgivfFEuLEs2Vg+xQ2hNkZbJSHO6aX/wrVv1g7IVk0RvxyaNm3xSWHW7wa3gitTQ8MRoWzxwbCLYGH6x6ekBIWYYCUAfVQ2rLFIKGCeXX463PJHnFgn5tqlqTLSKedsbWHVBdtJCPdYHeVd35ofsLjEXOx/EqwR6p9bQ6DPbRfD2Paj0+nL3C4eQWt1PAUhLtdy8Hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(41300700001)(83380400001)(66446008)(110136005)(64756008)(66946007)(8676002)(66556008)(36756003)(4326008)(316002)(6506007)(2906002)(6512007)(86362001)(76116006)(26005)(5660300002)(66476007)(8936002)(82960400001)(186003)(4001150100001)(15650500001)(2616005)(478600001)(38100700002)(91956017)(71200400001)(6486002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTlVU252R3BUVVlrTFdiNTFlTVdUUENhYzVrNkdDSVN3UUtuWU9neHFlV3o5?=
 =?utf-8?B?M0c0TmhaQVF3S0NpOE83cHcySUR1Tm1NcGpSaCtsdkI2Y0hRSGVQUklOZ3ZV?=
 =?utf-8?B?a2FJc3k5NWU5aFFxRGNiOXhjKzFLOEUyM3U1d2ozRnlCNU9XelNRb2Z3WXBx?=
 =?utf-8?B?YUpuaGFNdkZMcXRSUU5Fa1BPajN5Zk4zVmUzRThUd0hUSG5BZzhMcm5sdzk4?=
 =?utf-8?B?OGw1L3pqaE1lUmxVUnFpR3gyU2d1U2RMc1U0cis5aXA0QTVQOXpxTW52aHE2?=
 =?utf-8?B?ak1vcHh6UHkwQ3lpVTVYQ3Y2T1BHZE1TZnlPZ2p3MkpUWTZzU3RIRVJWNnpG?=
 =?utf-8?B?M0Z6RU5sa0VPN1ZyeFdmRURnY25VejYyT3M1UFA0QmIwZm9jUzcvbldKK0hC?=
 =?utf-8?B?OHhYT1VmTHQrVkU0Y3Y5OFhFR3I0VUhic0pOWDlYY3UzQjVuQWdNejNaMWpD?=
 =?utf-8?B?T3NLbFo3Ky92TDlvRFU0RXVYVzNjTjMyaEFyWUlnTWJFdWZjenBmQnVqVE9x?=
 =?utf-8?B?VEdyNWhOVm1sUEg5L1BsR2F0QlNCR3BCbG9xU2lNWjBSRk5EWVdtMWJ3VVZ1?=
 =?utf-8?B?WnczNDhsTnZIdFNUeVMxYnpjblpBNEpKZTAzSnpGdlhiNG5rbCs3U3A4Q3J1?=
 =?utf-8?B?eEpnT1hGWG1oOXZOMEQ3NThRZytPTVl4VzF5alUwaThhUVQyZ2JYMHFEajRI?=
 =?utf-8?B?WlpTY0pxSGprZGZjcGF1YjlWT242UDRta2dFNGZEKzUwZUY5dkxtWkoyYW1l?=
 =?utf-8?B?WDd0RjZ1QkxwZkt0S3c5RDhlS25DejRoMjFtRUVrMm5SMWxybS9MOFFqNW0v?=
 =?utf-8?B?MTRiMmJJVHRaOWxHbWJjbmExMTZaK3BOb2ZZU3A1WGV4NVRPVFh1STBpa2Jk?=
 =?utf-8?B?TnB5SHQvd0ZlRzZPZ1kzS0VzcXhEQ0Jpek1TTWg3SE10SCt3d3FOaVlzcUY1?=
 =?utf-8?B?clZQKys4b0hUNzU5d2FaY1M3cC9iTUI1MHg1cU5FNkxKUzZQOXc2NXZrTkdl?=
 =?utf-8?B?MSt2cjJ2UHY5RFVyQ2ZIRUp3UE02b09iRUxNcVJRTWRRMk5TRFU5UFVEL2ZY?=
 =?utf-8?B?REpMeU9UMVJaRTV2cVJRZHFlM2pudUo1ZVdoM1YzaGkzVEgycWpnakVHSjhU?=
 =?utf-8?B?RUQ4MFoxV3F2UXkwUDBLbTMycXVxZnd6cjBpeWlVMWpYa01tcjJ6ZFhLL0da?=
 =?utf-8?B?Z1BuMDVoM2VveHBkMVgrbGxIWk5WM3kxUWF0TTk3UW15T09iYjFhYWZHWkRS?=
 =?utf-8?B?ZHBVL0FPa0tTVU9QQkFqUUhYemJvZVNVdzMzUjJ2eFU2Mnl1RlI2YzRINGY1?=
 =?utf-8?B?RU9TdGVyN2FEWjNoMDljM3g3dHBpd2ZSYTZlTmZuS0Nsa1VIK3ROaUFuWTVy?=
 =?utf-8?B?bzdXNyt2dkphM3hSSUpFL0JiRzAyUndOMkhmZDFZb013b2NDQ3gvZ1EwZzgx?=
 =?utf-8?B?MXlsalIzOFMzV3NzZjJoUkk5SE53M1FoK2FZVHJsMXVjM3ZkQ2V0UnNtdnVk?=
 =?utf-8?B?MERodHh5NlBxVEdMT2ZLckd3RzdxUXVaaGxTN3dlMlFLVUtQSGk5eW80eEtz?=
 =?utf-8?B?QmFId2JGbisxWmVjWGFJN2hoZzZMRWxrVkc0L1VORmxZWjFTdGg0NjhyQTRu?=
 =?utf-8?B?b21pd2xOOHJaYjVxTmh3NUJ5U3ZKWC8zL2JxTjl2eWRBSzBHR3YyYnRSTjlk?=
 =?utf-8?B?SnpNSE05TEtMVGYvQUd2OE0xUmlya3VVMnR1cVR2ZlFqSnU4UTg3ZzFyNXpq?=
 =?utf-8?B?SlExVDVzeFJldFA1ZFdmU2xsYWNEbFRab20wYlErOWZLbGZzU0NoTWRwdmZU?=
 =?utf-8?B?bzdHMVpkTm45UFlHaFZ5TXd2YzJKb1JHT0ZTcm1KNmYwODV3Skh6TjQ2TkJq?=
 =?utf-8?B?RjRSckJLTGpFSlNjVi9ZVk1YVUtNemVmL3liN1NtNUpBa0V6ZTI3TFo3aXUv?=
 =?utf-8?B?TUNrMGNkZzljM0M1SHk1T0dYVWNvalR2RFhlUkVEM2ZhU2MxV2RvWlNUaXl1?=
 =?utf-8?B?aU9paE1Yd3dFeXpaMlc1LzlpZkROWmtpK2VUTWtXd3lHNUtsQS9aQUFBd0g5?=
 =?utf-8?B?UzgwaW9ZKytSUUtlN1J3MzVJRUh6a2R5OTNVTTNkOXM0ZksyRjdod2U3WXQy?=
 =?utf-8?B?OTVTMUFOd1lac2RGWWw5Kzk1eUU0ZUxqNWVQbGhRamRXbi9oNUNvWHhwK0Er?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B585D14072B5F14192777632DEF3381F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e232d49-76fb-48f6-ff70-08dab336c417
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 07:35:02.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyoSAZ5wnrmSwm9CYG0R5gQFjg3Z+PGWSBfj2SRsYLCBhBXBcLucn79fIBaW0SW8GzBXKaMAcdoZs101qY1ZyaoR8U7ytzbmntzeVoB246g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5389
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTIxIGF0IDA3OjMwICswMDAwLCBWZXJtYSwgVmlzaGFsIEwgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyMi0xMC0wMyBhdCAxNjoyMyAtMDcwMCwgSm9uYXRoYW4gWmhhbmcgd3Jv
dGU6DQo+ID4gRnJvbTogSm9uYXRoYW4gWmhhbmcgPGpvbnpoYW5nQG1ldGEuY29tPg0KPiA+IA0K
PiA+IENYTCAzLjAgc3BlYyBzZWN0aW9uIDguMi45LjguMy4yICJHZXQgQWxlcnQgQ29uZmlndXJh
dGlvbg0KPiA+IChPcGNvZGUgNDIwMWgpIGRlZmluZXMgdGhlIGdldC1hbGVydC1jb25maWcgY29t
bWFuZCB0bw0KPiA+IHJldHJpZXZlIHRoZSBkZXZpY2VzJ3MgY3JpdGljYWwgYWxlcnQgYW5kIHBy
b2dyYW1tYWJsZQ0KPiA+IHdhcm5pbmcgY29uZmlndXJhdGlvbi4NCj4gPiANCj4gPiBBZGQgdGhl
IG1ldGhvZHMgdG8gaXNzdWUgdGhlIGNvbW1hbmQgYW5kIGdldCB0aGUgZmllbGRzDQo+ID4gZGVm
aW5lZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBaaGFuZyA8am9uemhhbmdA
bWV0YS5jb20+DQo+ID4gLS0tDQo+ID4gwqBEb2N1bWVudGF0aW9uL2N4bC9saWIvbGliY3hsLnR4
dCB8wqDCoCAxICsNCj4gPiDCoGN4bC9saWIvbGliY3hsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDEyMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gwqBj
eGwvbGliL2xpYmN4bC5zeW3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyMyArKysr
KysNCj4gPiDCoGN4bC9saWIvcHJpdmF0ZS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAyOCArKysrKysrKw0KPiA+IMKgY3hsL2xpYmN4bC5owqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTkgKysrKysNCj4gPiDCoDUgZmlsZXMgY2hhbmdlZCwg
MTkxIGluc2VydGlvbnMoKykNCj4gDQo+IEhpIEpvbmF0aGFuLA0KPiANCj4gU29ycnkgZm9yIHRo
ZSBkZWxheSBpbiBnZXR0aW5nIHRvIHRoZXNlIC0gYSBmZXcgc21hbGwgY29tbWVudHMgYmVsb3cu
DQo+IA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2N4bC9saWIvbGliY3hs
LnR4dCBiL0RvY3VtZW50YXRpb24vY3hsL2xpYi9saWJjeGwudHh0DQo+ID4gaW5kZXggZmQyOTYy
YS4uZGVjMzY0MSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2N4bC9saWIvbGliY3hs
LnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vY3hsL2xpYi9saWJjeGwudHh0DQo+ID4gQEAg
LTEyMSw2ICsxMjEsNyBAQCBpbmZvcm1hdGlvbiB0aGlzIGNhbGwgcmVxdWlyZXMgcm9vdCAvIENB
UF9TWVNfQURNSU4uDQo+ID4gwqBzdHJ1Y3QgY3hsX2NtZCAqY3hsX2NtZF9uZXdfcmF3KHN0cnVj
dCBjeGxfbWVtZGV2ICptZW1kZXYsIGludCBvcGNvZGUpOw0KPiA+IMKgc3RydWN0IGN4bF9jbWQg
KmN4bF9jbWRfbmV3X2lkZW50aWZ5KHN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYpOw0KPiA+IMKg
c3RydWN0IGN4bF9jbWQgKmN4bF9jbWRfbmV3X2dldF9oZWFsdGhfaW5mbyhzdHJ1Y3QgY3hsX21l
bWRldiAqbWVtZGV2KTsNCj4gPiArc3RydWN0IGN4bF9jbWQgKmN4bF9jbWRfbmV3X2dldF9hbGVy
dF9jb25maWcoc3RydWN0IGN4bF9tZW1kZXYgKm1lbWRldik7DQo+ID4gwqBzdHJ1Y3QgY3hsX2Nt
ZCAqY3hsX2NtZF9uZXdfcmVhZF9sYWJlbChzdHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2LA0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IG9mZnNldCwgdW5zaWduZWQgaW50
IGxlbmd0aCk7DQo+ID4gwqBzdHJ1Y3QgY3hsX2NtZCAqY3hsX2NtZF9uZXdfd3JpdGVfbGFiZWwo
c3RydWN0IGN4bF9tZW1kZXYgKm1lbWRldiwgdm9pZCAqYnVmLA0KPiA+IGRpZmYgLS1naXQgYS9j
eGwvbGliL2xpYmN4bC5jIGIvY3hsL2xpYi9saWJjeGwuYw0KPiA+IGluZGV4IGU4YzVkNDQuLmVk
NTYxNmMgMTAwNjQ0DQo+ID4gLS0tIGEvY3hsL2xpYi9saWJjeGwuYw0KPiA+ICsrKyBiL2N4bC9s
aWIvbGliY3hsLmMNCj4gPiBAQCAtMzE0MCw2ICszMTQwLDEyNiBAQCBkbyB7wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoFwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuICEhKGMtPmZpZWxkICYgbWFz
ayk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBcDQo+ID4gwqB9IHdoaWxlKDApDQo+ID4gwqANCj4gPiArQ1hM
X0VYUE9SVCBzdHJ1Y3QgY3hsX2NtZCAqY3hsX2NtZF9uZXdfZ2V0X2FsZXJ0X2NvbmZpZygNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9tZW1kZXYgKm1lbWRl
dikNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBjeGxfY21kX25ld19nZW5lcmlj
KG1lbWRldiwgQ1hMX01FTV9DT01NQU5EX0lEX0dFVF9BTEVSVF9DT05GSUcpOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICsjZGVmaW5lIGNtZF9hbGVydF9nZXRfdmFsaWRfYWxlcnRzX2ZpZWxkKGMsIG0p
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgXA0KPiA+ICvCoMKgwqDCoMKgwqDCoGNtZF9nZXRfZmllbGRfdThfbWFzayhjLCBn
ZXRfYWxlcnRfY29uZmlnLCBHRVRfQUxFUlRfQ09ORklHLCB2YWxpZF9hbGVydHMsIG0pDQo+ID4g
Kw0KPiA+ICtDWExfRVhQT1JUIGludCBjeGxfY21kX2FsZXJ0X2NvbmZpZ19nZXRfbGlmZV91c2Vk
X3Byb2dfd2Fybl90aHJlc2hvbGRfdmFsaWQoc3RydWN0IGN4bF9jbWQgKmNtZCkNCj4gDQo+IEdl
bmVyYWxseSB0aHJvdWdob3V0IHRoZXNlIHBhdGNoZXMsIGJlY2F1c2Ugb2YgdGhlICh1bmF2b2lk
YWJseSkgbG9uZw0KPiBuYW1lcywgdGhlc2UgbGluZXMgYXJlIHdlbGwgb3ZlciA4MCBjaGFycy4g
Rm9yIGNhc2VzIHdoZXJlIGEgI2RlZmluZQ0KPiBmb3IgZXhhbXBsZSBjYW4ndCBiZSBicm9rZW4g
ZG93biBmdXJ0aGVyLCB0aGF0J3Mgb2theS4gQnV0IGEgbG90IG9mDQo+IHRoZXNlIGNhbiBiZSBz
cGxpdC4gV2UgaGF2ZSBhIC5jbGFuZy1mb3JtYXQgZm9yIHRoZSBwcm9qZWN0LCBhbmQgdGhhdA0K
PiBzaG91bGQgZG8gdGhlIHJpZ2h0IHRoaW5nIGluIGFsbCB0aGVzZSBjYXNlcy4NCj4gDQo+IDwu
Lj4NCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvY3hsL2xpYi9saWJjeGwuc3ltIGIvY3hsL2xpYi9s
aWJjeGwuc3ltDQo+ID4gaW5kZXggOGJiOTFlMC4uN2MxZTI2MSAxMDA2NDQNCj4gPiAtLS0gYS9j
eGwvbGliL2xpYmN4bC5zeW0NCj4gPiArKysgYi9jeGwvbGliL2xpYmN4bC5zeW0NCj4gPiBAQCAt
MjE3LDMgKzIxNywyNiBAQCBnbG9iYWw6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGN4bF9kZWNvZGVy
X2dldF9tYXhfYXZhaWxhYmxlX2V4dGVudDsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgY3hsX2RlY29k
ZXJfZ2V0X3JlZ2lvbjsNCj4gPiDCoH0gTElCQ1hMXzI7DQo+ID4gKw0KPiA+ICtMSUJDWExfNCB7
DQo+ID4gK2dsb2JhbDoNCj4gPiArwqDCoMKgwqDCoMKgwqBjeGxfY21kX25ld19nZXRfYWxlcnRf
Y29uZmlnOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGN4bF9jbWRfYWxlcnRfY29uZmlnX2dldF9saWZl
X3VzZWRfcHJvZ193YXJuX3RocmVzaG9sZF92YWxpZDsNCj4gPiArwqDCoMKgwqDCoMKgwqBjeGxf
Y21kX2FsZXJ0X2NvbmZpZ19nZXRfZGV2X292ZXJfdGVtcF9wcm9nX3dhcm5fdGhyZXNob2xkX3Zh
bGlkOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGN4bF9jbWRfYWxlcnRfY29uZmlnX2dldF9kZXZfdW5k
ZXJfdGVtcF9wcm9nX3dhcm5fdGhyZXNob2xkX3ZhbGlkOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGN4
bF9jbWRfYWxlcnRfY29uZmlnX2dldF9jb3JyX3ZvbF9tZW1fZXJyX3Byb2dfd2Fybl90aHJlc2hv
bGRfdmFsaWQ7DQo+ID4gK8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9jb25maWdfZ2V0X2Nv
cnJfcGVyc19tZW1fZXJyX3Byb2dfd2Fybl90aHJlc2hvbGRfdmFsaWQ7DQo+IA0KPiBJIHRoaW5r
IGZvciBhbGwgdGhlICd2YWxpZCcgYWNjZXNzb3JzLCB0aGUgJ2dldCcgY2FuIGJlIGRyb3BwZWQu
DQo+IGN4bF9jbWRfYWxlcnRfY29uZmlnXzxzb21ldGhpbmc+X3ZhbGlkIGlzIGEgcmVhc29uYWJs
ZSBBUEkgdGhhdCBhc2tzDQo+IHdoZXRoZXIgc29tZXRoaW5nIGlzIHZhbGlkLiANCj4gDQo+ID4g
K8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9jb25maWdfZ2V0X2xpZmVfdXNlZF9wcm9nX3dh
cm5fdGhyZXNob2xkX3Byb2c7DQo+ID4gK8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9jb25m
aWdfZ2V0X2Rldl9vdmVyX3RlbXBfcHJvZ193YXJuX3RocmVzaG9sZF9wcm9nOw0KPiA+ICvCoMKg
wqDCoMKgwqDCoGN4bF9jbWRfYWxlcnRfY29uZmlnX2dldF9kZXZfdW5kZXJfdGVtcF9wcm9nX3dh
cm5fdGhyZXNob2xkX3Byb2c7DQo+ID4gK8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9jb25m
aWdfZ2V0X2NvcnJfdm9sX21lbV9lcnJfcHJvZ193YXJuX3RocmVzaG9sZF9wcm9nOw0KPiA+ICvC
oMKgwqDCoMKgwqDCoGN4bF9jbWRfYWxlcnRfY29uZmlnX2dldF9jb3JyX3BlcnNfbWVtX2Vycl9w
cm9nX3dhcm5fdGhyZXNob2xkX3Byb2c7DQoNCk9ubHkgcmVhbGl6ZWQgdGhpcyBhZnRlciBoaXR0
aW5nIHNlbmQgLSBzYW1lIGNvbW1lbnQgaGVyZSBhYm91dCB0aGUNCmRvdWJsZSAncHJvZycsICdw
bWVtJyBldGMgKGZyb20gbXkgcGF0Y2ggMiBlbWFpbCkgaGVyZS4gQWRkaXRpb25hbGx5DQp0aGUg
J2dldCcgY2FuIGJlIGRyb3BwZWQgc2luY2UgdGhlIHJlc3BvbmRzIHdpdGggYSBib29sZWFuLiBT
byB0aGlzIGNhbg0KYmU6wqANCg0KICBjeGxfY21kX2FsZXJ0X2NvbmZpZ19jb3JyZWN0ZWRfcG1l
bV9lcnJvcl9wcm9nX3dhcm5fdGhyZXNob2xkX3dyaXRhYmxlDQoNCj4gPiArwqDCoMKgwqDCoMKg
wqBjeGxfY21kX2FsZXJ0X2NvbmZpZ19nZXRfbGlmZV91c2VkX2NyaXRfYWxlcnRfdGhyZXNob2xk
Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoGN4bF9jbWRfYWxlcnRfY29uZmlnX2dldF9saWZlX3VzZWRf
cHJvZ193YXJuX3RocmVzaG9sZDsNCj4gPiArwqDCoMKgwqDCoMKgwqBjeGxfY21kX2FsZXJ0X2Nv
bmZpZ19nZXRfZGV2X292ZXJfdGVtcF9jcml0X2FsZXJ0X3RocmVzaG9sZDsNCj4gPiArwqDCoMKg
wqDCoMKgwqBjeGxfY21kX2FsZXJ0X2NvbmZpZ19nZXRfZGV2X3VuZGVyX3RlbXBfY3JpdF9hbGVy
dF90aHJlc2hvbGQ7DQo+ID4gK8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9jb25maWdfZ2V0
X2Rldl9vdmVyX3RlbXBfcHJvZ193YXJuX3RocmVzaG9sZDsNCj4gPiArwqDCoMKgwqDCoMKgwqBj
eGxfY21kX2FsZXJ0X2NvbmZpZ19nZXRfZGV2X3VuZGVyX3RlbXBfcHJvZ193YXJuX3RocmVzaG9s
ZDsNCj4gPiArwqDCoMKgwqDCoMKgwqBjeGxfY21kX2FsZXJ0X2NvbmZpZ19nZXRfY29ycl92b2xf
bWVtX2Vycl9wcm9nX3dhcm5fdGhyZXNob2xkOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGN4bF9jbWRf
YWxlcnRfY29uZmlnX2dldF9jb3JyX3BlcnNfbWVtX2Vycl9wcm9nX3dhcm5fdGhyZXNob2xkOw0K
PiANCj4gVGhlc2UgYXJlIG9rYXkgdG8gaGF2ZSB0aGUgZ2V0LCBzaW5jZSB3ZSBhcmUgZ2V0dGlu
ZyBhIHRocmVzaG9sZCB2YWx1ZS4NCj4gDQo+IA0KPiANCg0K
