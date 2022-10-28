Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B72FA3740
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Oct 2022 21:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJ1VKS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1VKQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Oct 2022 17:10:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F68036DC5
        for <linux-cxl@vger.kernel.org>; Fri, 28 Oct 2022 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666991413; x=1698527413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U3dGjJuNtMVR672wrERfjaQSILLVelcpbxgwWotHnw4=;
  b=WWONLUfJr+CSXQn7y/HDMTiYdmZQBA8pePkbcyDFOSYUDbdiSNjUpTTE
   sXH99jtTAt8sGsKt3qJGvphNSUJWsymK/j8W6gw3Y2V6YROoEnwssnzwO
   +t0TEqTkwDKj2x6IdbvyL1Z0Gz/Vx3AfI3xrg8zAy6QiFJn39bQ+OGsUz
   EyuMwWZodoqnplmysRUOaNZYPOUURLkcCUb1U40YKbFwFfxzf4ScroCVL
   U4GGkV539eKRk/lkOl9kDkAYD14t0JPZtACDs7OmNEKVuGqo4wX7K6QCd
   45I5TqyfJC4kLo+XbG/Q5+QKJty+jtjvZKsMI9KHsXGp5gIr4b22MEjqw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="288986034"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="288986034"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 14:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="758224366"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="758224366"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 28 Oct 2022 14:10:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 14:10:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 28 Oct 2022 14:10:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 28 Oct 2022 14:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5Rd5OJTVi2pRz4ivJc2q4PoP5kn/J+bJzbr9iYR764iAHNpeQyjhe5Y2x/7CXO7DZzDDh9KD4TU41F5D/AhlvWoWyEcDGHHfwdm38iDYg4CjZFxIT1jjiMsEocdePprmRUTXsh7RR9Esb1kqzA6t88LFo0UB+h8sKZfMZESb1XBmlr/UGmAjx3qUqXpax6SHROnBhosY/PTM8UWz0LlQASw+uEH6oYtcSCTusPCuRYWUiaRubsWTb5YQHcuRm4NktWFcimiMh91aHysrkAQCW6a0MOA45I5cnr12/H1CFXmjN0fpnfP60hwBG42LxaENKi9VtIOJjxGIKN0jjKMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3dGjJuNtMVR672wrERfjaQSILLVelcpbxgwWotHnw4=;
 b=kA58Jx8nGUhVA+3mO5ImAzP+EyzbAjGJjuBOtwJdTgS5dKQSJX6lsLOwzcEUppN1J+dbmm6Q7zNg3x/y6iMO6frcsEvD2IELsHDOMGDD8xNDNVcHHeWArNWVeo2exr/xYtomek+MQP+hoB44uKOyujWO7LnefJtxggdtJXZDXYuVbrHc3c/QMYhbGzazgjkTjaWBOvewzrUliMTyEsnK2nmW1KbddOn6BUib1aLHS4wlMcfUDaXQ8labnKy6JVKtONAXILgaJxRVyiiA4zrVkOwEfBuWxc8F86ES2n2Dpuxg+Ddcn+IxGzHMMy93IvehDHFGEbH18DR81EZ90PmHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR11MB3988.namprd11.prod.outlook.com (2603:10b6:405:7c::23)
 by BL1PR11MB6049.namprd11.prod.outlook.com (2603:10b6:208:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 21:10:01 +0000
Received: from BN6PR11MB3988.namprd11.prod.outlook.com
 ([fe80::c6b6:7a14:4d38:8623]) by BN6PR11MB3988.namprd11.prod.outlook.com
 ([fe80::c6b6:7a14:4d38:8623%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 21:10:01 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Schofield, Alison" <alison.schofield@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/region: refactor decoder allocation for region refs
Thread-Topic: [PATCH] cxl/region: refactor decoder allocation for region refs
Thread-Index: AQHY6wRDiVT1sfk4QUided0Z0m3MRK4kRZ+AgAAHnwA=
Date:   Fri, 28 Oct 2022 21:10:01 +0000
Message-ID: <89acba4011d03582a1f81feb376915b826020cee.camel@intel.com>
References: <20221028193351.408950-1-vishal.l.verma@intel.com>
         <635c3ec3b3eab_6be129441@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <635c3ec3b3eab_6be129441@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB3988:EE_|BL1PR11MB6049:EE_
x-ms-office365-filtering-correlation-id: ff69b267-89b1-4120-4281-08dab928c6ff
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IpArtrGxGQOKR+14bP3E4K6739f6wsDzCFf5RInlBwkaOdFgcH5mbqihrB99P2+GV3VEKlNSEyx/iXzWMOaLEfvrxJf8+tVPTF6KaEc+f4uXSAQVkO161wScuHv/fRyr1W7rrISM5oR6FxHrL7ToD1umGgXWhwjVGaaqCSjWnEcu9niSmLiH336EiqFimRcoj00kxvGFdNze0oXKsUP7ZsfpIa0/SZxX39F0p3qRpCVxOCW2CYi/UnVdOOx6ZIfF4D1Qf7bEAHg6Stay47tSEuzYiQVrMoDVXcb6qYnyFIqBBNSYeCVF5zNywpfSL8t4WtU88le6LeYkJNdSaE6QarxaAKfi55rZy3ilS1wD6OAZds2ED/rzsD9zd7XL2zBuiHwZ+MbZ0N5StHDsa1AmHzEnPW9XLQI15bYY3VZS3psxKaddQZdzmHk/I+8WGMfhD8jG4/pHtylCiav2vUsh7PnE9Rq8GHtZyDUpOil9Ao4EzsFp4E5otIc9p+lfPEmqP1gJhOm5gFQgI2Q7MdhM/k7B5JMncBW6R28UGtm7BCVZrvxWO9J1HCGyU5r6rYrjegQiLjOc+K3361fFtBvv3zLieoY2W00VTZNNTRrcOB6FYdq4q1PJRPyvLS3esLuaILvT6kX57NkqALJjHhF0OJzc9qsji2YnnZStqHoASqyHTr8H0lYKiSeYVfuMWtD1Ermkrmngr2wrDNrzfWlKIhbvIOY2xo43x9Q6GJCcLglfR9XciHMEBg1bSSl4PubDPWKqd/Sz40iUXiRZ2fBElw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3988.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(107886003)(4001150100001)(316002)(110136005)(91956017)(54906003)(8936002)(5660300002)(8676002)(4326008)(2616005)(186003)(64756008)(36756003)(66946007)(66476007)(6506007)(76116006)(66446008)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(2906002)(38100700002)(6486002)(71200400001)(478600001)(38070700005)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkNlemNuUTcwQU1hekx1R2x2UkZidXJTVVFGa2xsaGhCYkFQWk91WmRSYytI?=
 =?utf-8?B?SnZPSk1hakF6azNwVUo1TjZTOHdyTHRmNi83ejFTZFVmVFpzOE1IVlJVaGRH?=
 =?utf-8?B?SXg3V1drTU9Yc2xxTTFRc0FUSldnUVgvcG1QWHlNSXBiYzlwUlBwZUQzR1VB?=
 =?utf-8?B?QkZ6TEplYkpNMVM5L1VWb3p5N1B1TVhHckNQdGY4ejhxZ1UrRXVub3lGaVlu?=
 =?utf-8?B?T1gvQVNLR2oxR1dUTDZXZDEwcTZvUEVGUlRyQnpVUUMydGN6Vlh0U3h0TUp2?=
 =?utf-8?B?czJXaFZUK0kwY3dOUHpuYXpieG1YSmNub0VlVmVpQW1WTFZQVGkyOERDNldy?=
 =?utf-8?B?MG5HaXZEYm40MlMyV2c2VDJPZlROZ0N0WUtVRDFSQWdNMFFUU0o1VDRjV3Nh?=
 =?utf-8?B?WjN0RzRmZkRxRldKWWtybWFHZ0crdlNhbmlacUp6cDlOSVphUEdxUlZBWDZW?=
 =?utf-8?B?NS9oU2NBcVVRNktJdVc0N1hsZCtUUndiOGZBTVFUTFZLUzh3VjV1R0VmQmI2?=
 =?utf-8?B?Szl1ekFvRFYvazNSemkrU2xlNDh6UWhMaEVvTUxNcEYrYnNFVkhBVXdjTVZC?=
 =?utf-8?B?SzB6T0J6UnZ1Z2hEWTBiSmMyMUFUaFpYQkF6YjBOeEZJbzNnWFlWS0F2NXg4?=
 =?utf-8?B?TEtPUmRrSE8wZ04wdUwzZm5uQm1uQWV0TGlwZlcrUHBvR0Z6TkgvNnVsSVlI?=
 =?utf-8?B?Y1labk14QWlCMXRXOFJ4ZWEwWFI4azljWnNlRUM5a01NcGNxUkRKSWFlM1lN?=
 =?utf-8?B?aWZyMnZOUkZpV3UvZWZya0Mya3NTQ3BRNWZkRjJWdzlkbDRuNzhwNmRJWUNt?=
 =?utf-8?B?NVNtM1BoS0ZVMnNvLzMxS3JXeGN0MnFKZlFrcVBnK1dzZ25oQWNtMmlyM1JV?=
 =?utf-8?B?Wis1R0NOUE9aVjcyZ0NieWwrUXY3YzQxak1Za1ZQbWVLK3lHd2ZrMFR0c1VE?=
 =?utf-8?B?VCtqQzJCbTl5bFJMQkYxT25jY3lYZ3NRRXV0d3RqMmlITTJYNjd6dFh3VGtD?=
 =?utf-8?B?WXM0Yzh5Sy9QazdnV09ZTEdkR0FtUU1YQlRybGgzRGRoQkNDd0RaUk51UytH?=
 =?utf-8?B?RmtNOWVMbGUrOGlEalkxOFRndnNCZWp6NGwxMUZJQ3htR1NSaU1TNDV0Wkcx?=
 =?utf-8?B?RjJhV0N1YTJMQ1ErV05TbnptdzZ5RmdEaUd3M1dGcmpablYzZmc0b3huczNp?=
 =?utf-8?B?Um5KS3ZZUU9VbHlLd0NkL3JMRTZZbzlCT2Vrb0FwcGk3SDYvV1ZxRHdrZmlm?=
 =?utf-8?B?MVEvU2pyTmg1ZTAzWHdpQ0M1YUZRd1RVU3YzTzNqQzBQTHBZQm04Zjh6QUwr?=
 =?utf-8?B?cHEybkgvYjd1N0RhNFNmM1kxNmJLRXpidlJlY2xxK21GNllMVjZvT0tsTGxk?=
 =?utf-8?B?Y0o5ZU1EWldVUUYvdGF5TzlWMGtsWDVDR284UUNNZHlPS09BZmViWmJuQWhN?=
 =?utf-8?B?ek9UKzhPVnBlZWY1Q0FudmxxWkhiOTRieDUrVFpoaWFYQjZkMml1S1VIdnRa?=
 =?utf-8?B?dUI5M25jKy9MbXJwVGFMRmFrRmpNVlZPUjFyNVBFVFVNMjhpSXZCbjV5UHVh?=
 =?utf-8?B?eHpYL2k5OXNlajNkM21wUHV5NTJxRVBWMi9VLzc2dDBuQjNEb3JUMCtRdUY4?=
 =?utf-8?B?cnhYSVJ2ZVgyQklaWlN2S3gyc1Rkd0xBT3U0ZHgwZ241NTZ3djFHU1RhL3hV?=
 =?utf-8?B?OGJYcWVSbUNLK3lmL2NELzdFdWNjajBpelhNUEwwZWRRbXp2c1V4SVB5Wisz?=
 =?utf-8?B?YUdZamlaS0tVVGtGYmRleDJzMXprZmp6NUFmUzRMTytVd2F2OURkdmMyRkRN?=
 =?utf-8?B?SEpTZDdLeFRsZnp3L3lSRW01dStqbUp5bjl1RnV6SUhsU2NSMzJHUFcyM01Z?=
 =?utf-8?B?RExQRWgveHIzZTR6T0s2dk0wT2FqN1FoQmo2QnNQSkFpK2ljQ0FxZFJqMEQv?=
 =?utf-8?B?K1JYZTliQ24zVkZPcVQvSzdzck40MTJYcXhiWDFrM1ZsaEdEUUZsMUhTcWxW?=
 =?utf-8?B?TndqY2Q4aFpjY3lxbGZNY0h1M0dlUHBXWnk4Y3MvSDlOOGNkWkZCblRpUkcx?=
 =?utf-8?B?UTMrYVJ0TGp6N2JUcE42bWVwNFlJT2I3Y2xxRkxZVW9ib0R1L1dUOC9lbk9Z?=
 =?utf-8?B?UnU4MDVzM1dYR1BtN3hlUmJhTXQrSlRqTzBVelNwUEk5blBHcC9Ub3I3TUY3?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A713EBF2FB05745AF6FE7E6A7A9D5BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3988.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff69b267-89b1-4120-4281-08dab928c6ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 21:10:01.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04+P12049HCVRKncL/5pUOCX2ZoZufhbjaanW4fgFrUhiiG07sWj6z4TLpgYC4t7fU/CXU70D0rRm1EICzhkg+QQFJOwZJvI8f5DQJuBKmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6049
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTI4IGF0IDEzOjQyIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
VmlzaGFsIFZlcm1hIHdyb3RlOgo+ID4gV2hlbiBhbiBpbnRlcm1lZGlhdGUgcG9ydCdzIGRlY29k
ZXJzIGhhdmUgYmVlbiBleGhhdXN0ZWQgYnkgZXhpc3RpbmcKPiA+IHJlZ2lvbnMsIGFuZCBjcmVh
dGluZyBhIG5ldyByZWdpb24gd2l0aCB0aGUgcG9ydCBpbiBxdWVzdGlvbiBpbiBpdCdzCj4gPiBo
aWVyYXJjaGljYWwgcGF0aCBpcyBhdHRlbXB0ZWQsIGN4bF9wb3J0X2F0dGFjaF9yZWdpb24oKSBm
YWlscyB0byBmaW5kIGEKPiA+IHBvcnQgZGVjb2RlciAoYXMgd291bGQgYmUgZXhwZWN0ZWQpLCBh
bmQgZHJvcHMgaW50byB0aGUgZmFpbHVyZSAvIGNsZWFudXAKPiA+IHBhdGguCj4gPiAKPiA+IEhv
d2V2ZXIsIGR1cmluZyBjbGVhbnVwIG9mIHRoZSByZWdpb24gcmVmZXJlbmNlLCBhIHNhbml0eSBj
aGVjayBhdHRlbXB0cwo+ID4gdG8gZGVyZWZlcmVuY2UgdGhlIGRlY29kZXIsIHdoaWNoIGluIHRo
ZSBhYm92ZSBjYXNlIGRpZG4ndCBleGlzdC4gVGhpcwo+ID4gY2F1c2VzIGEgTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlIEJVRy4KPiA+IAo+ID4gVG8gZml4IHRoaXMsIHJlZmFjdG9yIHRoZSBkZWNv
ZGVyIGFsbG9jYXRpb24gYW5kIGRlLWFsbG9jYXRpb24gaW50bwo+ID4gaGVscGVyIHJvdXRpbmVz
LCBhbmQgaW4gdGhpcyAnZnJlZScgcm91dGluZSwgY2hlY2sgdGhhdCB0aGUgZGVjb2RlciwKPiA+
IEBjeGxkLCBpcyB2YWxpZCBiZWZvcmUgYXR0ZW1wdGluZyBhbnkgb3BlcmF0aW9ucyBvbiBpdC4K
PiA+IAo+ID4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgo+ID4g
U3VnZ2VzdGVkLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KPiA+
IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPgo+
ID4gLS0tCj4gPiDCoGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgfCAxNjQgKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDk5IGluc2Vy
dGlvbnMoKyksIDY1IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
eGwvY29yZS9yZWdpb24uYyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMKPiA+IGluZGV4IDQw
MTE0ODAxNjk3OC4uNzgxNzZmN2NjZmYzIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9jeGwvY29y
ZS9yZWdpb24uYwo+ID4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYwo+ID4gQEAgLTY4
NiwxOCArNjg2LDI3IEBAIHN0YXRpYyBzdHJ1Y3QgY3hsX3JlZ2lvbl9yZWYgKmFsbG9jX3JlZ2lv
bl9yZWYoc3RydWN0IGN4bF9wb3J0ICpwb3J0LAo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBj
eGxfcnI7Cj4gPiDCoH0KPiA+IMKgCj4gPiAtc3RhdGljIHZvaWQgZnJlZV9yZWdpb25fcmVmKHN0
cnVjdCBjeGxfcmVnaW9uX3JlZiAqY3hsX3JyKQo+ID4gK3N0YXRpYyB2b2lkIGN4bF9ycl9mcmVl
X2RlY29kZXIoc3RydWN0IGN4bF9yZWdpb25fcmVmICpjeGxfcnIpCj4gPiDCoHsKPiA+IC3CoMKg
wqDCoMKgwqDCoHN0cnVjdCBjeGxfcG9ydCAqcG9ydCA9IGN4bF9yci0+cG9ydDsKPiA+IMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciA9IGN4bF9yci0+cmVnaW9uOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfZGVjb2RlciAqY3hsZCA9IGN4bF9yci0+ZGVjb2Rl
cjsKPiA+IMKgCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIWN4bGQpCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDCoGRldl9X
QVJOX09OQ0UoJmN4bHItPmRldiwgY3hsZC0+cmVnaW9uICE9IGN4bHIsICJyZWdpb24gbWlzbWF0
Y2hcbiIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChjeGxkLT5yZWdpb24gPT0gY3hscikgewo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjeGxkLT5yZWdpb24gPSBOVUxMOwo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwdXRfZGV2aWNlKCZjeGxyLT5kZXYp
Owo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICt9Cj4gPiDCoAo+ID4gK3N0YXRpYyB2b2lkIGZy
ZWVfcmVnaW9uX3JlZihzdHJ1Y3QgY3hsX3JlZ2lvbl9yZWYgKmN4bF9ycikKPiA+ICt7Cj4gPiAr
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQgPSBjeGxfcnItPnBvcnQ7Cj4gPiAr
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciA9IGN4bF9yci0+cmVnaW9uOwo+
ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgY3hsX3JyX2ZyZWVfZGVjb2RlcihjeGxfcnIpOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoHhhX2VyYXNlKCZwb3J0LT5yZWdpb25zLCAodW5zaWduZWQgbG9uZylj
eGxyKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqB4YV9kZXN0cm95KCZjeGxfcnItPmVuZHBvaW50cyk7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKga2ZyZWUoY3hsX3JyKTsKPiA+IEBAIC03MjgsNiArNzM3LDgz
IEBAIHN0YXRpYyBpbnQgY3hsX3JyX2VwX2FkZChzdHJ1Y3QgY3hsX3JlZ2lvbl9yZWYgKmN4bF9y
ciwKPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+IMKgfQo+ID4gwqAKPiA+ICtzdGF0
aWMgaW50IGN4bF9ycl9hbGxvY19kZWNvZGVyKHN0cnVjdCBjeGxfcG9ydCAqcG9ydCwgc3RydWN0
IGN4bF9yZWdpb24gKmN4bHIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3hsX2VuZHBvaW50X2RlY29kZXIg
KmN4bGVkLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgYm9vbCAqbnJfdGFyZ2V0c19pbmMpCj4gPiArewo+ID4gK8KgwqDC
oMKgwqDCoMKgc3RydWN0IGN4bF9tZW1kZXYgKmN4bG1kID0gY3hsZWRfdG9fbWVtZGV2KGN4bGVk
KTsKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBjeGxfZXAgKmVwID0gY3hsX2VwX2xvYWQocG9y
dCwgY3hsbWQpOwo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9yZWdpb25fcmVmICpjeGxf
cnI7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3hsX2RlY29kZXIgKmN4bGQ7Cj4gPiArwqDC
oMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGluZGV4Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKg
Y3hsX3JyID0gY3hsX3JyX2xvYWQocG9ydCwgY3hscik7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAo
Y3hsX3JyKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGN4bF9l
cCAqZXBfaXRlcjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnQgZm91bmQg
PSAwOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogV2FsayB0aGUgZXhpc3RpbmcgZW5kcG9pbnRz
IHRoYXQgaGF2ZSBiZWVuIGF0dGFjaGVkIHRvCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogQGN4bHIgYXQgQHBvcnQgYW5kIHNlZSBpZiB0aGV5IHNoYXJlIHRoZSBzYW1lICdu
ZXh0JyBwb3J0Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaW4gdGhlIGRv
d25zdHJlYW0gZGlyZWN0aW9uLiBJLmUuIGVuZHBvaW50cyB0aGF0IHNoYXJlIGNvbW1vbgo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHVwc3RyZWFtIHN3aXRjaC4KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB4YV9mb3JfZWFjaCgmY3hsX3JyLT5lbmRwb2ludHMsIGluZGV4LCBlcF9pdGVy
KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
IChlcF9pdGVyID09IGVwKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChlcF9pdGVyLT5uZXh0ID09IGVwLT5u
ZXh0KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBmb3VuZCsrOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBOZXcgdGFyZ2V0IHBv
cnQsIG9yIEBwb3J0IGlzIGFuIGVuZHBvaW50IHBvcnQgdGhhdCBhbHdheXMKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBhY2NvdW50cyBpdHMgb3duIGxvY2FsIGRlY29kZSBh
cyBhIHRhcmdldC4KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWZvdW5kIHx8ICFlcC0+bmV4dCkgewo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjeGxfcnIt
Pm5yX3RhcmdldHMrKzsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgKm5yX3RhcmdldHNfaW5jID0gdHJ1ZTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBUaGUgZGVjb2RlciBmb3IgQGN4
bHIgd2FzIGFsbG9jYXRlZCB3aGVuIHRoZSByZWdpb24gd2FzIGZpcnN0Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYXR0YWNoZWQgdG8gQHBvcnQuCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgY3hsZCA9IGN4bF9yci0+ZGVjb2RlcjsKPiA+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3hsX3JyID0gYWxsb2NfcmVnaW9uX3Jl
Zihwb3J0LCBjeGxyKTsKPiAKPiBUaGUgcmVnaW9uX3JlZiwgJ2N4bF9ycicsIGlzIGJlaW5nIGNy
ZWF0ZWQgaGVyZSwgYnV0IHRoZSBmdW5jdGlvbiBpcwo+IGNhbGxlZCBjeGxfcnJfYWxsb2NfZGVj
b2RlcigpLCB3aGljaCB0byBtZSBtZWFucyB0aGUgJ2N4bF9ycicgc2hvdWxkIGJlCj4gcGFzc2Vk
IGluIC8gYWxyZWFkeSBjcmVhdGVkLgoKQWggeWVhaCBtYWtlcyBzZW5zZS4KCj4gCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKElTX0VSUihjeGxfcnIpKSB7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9kYmcoJmN4bHIt
PmRldiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCIlczogZmFpbGVkIHRvIGFsbG9jYXRlIHJlZ2lvbiByZWZlcmVuY2Vc
biIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBkZXZfbmFtZSgmcG9ydC0+ZGV2KSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBQVFJfRVJSKGN4bF9ycik7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCpucl90YXJnZXRzX2luYyA9IHRydWU7Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHBvcnQgPT0gY3hsZWRfdG9fcG9ydChjeGxlZCkpCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGN4bGQgPSAm
Y3hsZWQtPmN4bGQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjeGxkID0gY3hs
X3JlZ2lvbl9maW5kX2RlY29kZXIocG9ydCwgY3hscik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKCFjeGxkKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGRldl9kYmcoJmN4bHItPmRldiwgIiVzOiBubyBkZWNvZGVyIGF2
YWlsYWJsZVxuIiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9uYW1lKCZwb3J0LT5kZXYpKTsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTlhJTzsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKGN4bGQtPnJlZ2lvbikgewo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZGJnKCZjeGxyLT5kZXYsICIlczog
JXMgYWxyZWFkeSBhdHRhY2hlZCB0byAlc1xuIiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9uYW1lKCZwb3J0LT5k
ZXYpLCBkZXZfbmFtZSgmY3hsZC0+ZGV2KSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9uYW1lKCZjeGxkLT5yZWdp
b24tPmRldikpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gLUVCVVNZOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0K
PiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjeGxfcnItPmRlY29kZXIg
PSBjeGxkOwo+IAo+IEkgd2FzIHRoaW5raW5nIGN4bF9ycl9hbGxvY19kZWNvZGVyKCkgdG8ganVz
dCBiZSB0aGlzIGFib3ZlIGJpdCBvZiB0YWtpbmcgYW4KPiBleGlzdGluZyBjeGxfcnIgYW5kIGFw
cGVuZGluZyB0aGUgZGVjb2Rlci4gVGhlIGZsb3cgd291bGQgdGhlbiBnbzoKPiAKPiBhbGxvY19y
ZWdpb25fcmVmKCkKPiBcLT5jeGxfcnJfYWxsb2NfZGVjb2RlcigpCj4gZnJlZV9yZWdpb25fcmVm
KCkKPiBcLT5jeGxfcnJfZnJlZV9kZWNvZGVyKCkKPiAKPiAuLi5zbyB0aGUgc3ltbWV0cnkgaXMg
bW9yZSBhcHBhcmVudC4KClllcCBzb3VuZHMgcmVhc29uYWJsZSwgSSdsbCBzZW5kIGEgdjIgd2l0
aCB0aGlzLgoK
