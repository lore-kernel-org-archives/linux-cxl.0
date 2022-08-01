Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF46C3F6B0
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 20:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiHAUzr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 16:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiHAUzq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 16:55:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A2C12AC5
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 13:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659387345; x=1690923345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h48+r8RSIA4VFIM1lCFDUOuqECK+IBBfTUlh+dPqjuI=;
  b=A0XPPoPMcqWQ49SqTmfXMuyIMuYbKucsbfM+0/mLxrIWxkS+DqtpddMb
   T3fGu898vcQyR7Q6n4ZpyhqvCoNuW41ZIK7S/CwqxJOHvpX/d5s0aummb
   wxxxeDPeHU6HjVzKaWOMgDm6UAOgmgt/X8xVjqvPYemh41/U8cjuCE+58
   V1mSiY2VBeiNtNvdrhNRoA7S2PRtDcGx+3WkMUEcKYR9T8bVCaZjhOJK3
   e35DJEaAb6Syd0FBgUZ7nlDIkRWetcnuf7V2JtU4IPLINbSBKpcjXfupa
   yPg1h63ZEJmW0xtQOkxZ0GU9NOpDs55e6vzxMmBE6UgQLyZkTJQnrz64y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290462201"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="290462201"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 13:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="577935300"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2022 13:55:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 13:55:44 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 13:55:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 13:55:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 13:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/roMLDL4fYic4kU7/rmb65Y6hAteAsQS8KjtQTNA5hXcA2CVvW8X6d7RCaOiTxrM9tXoNKJ0zF0L1OXnq+HQ7QFn26mlPPOjZYqQyNIGva8+jBWOAzbHWCCh37kzi41N90zehYYU7gKs3tPk4CN7dNABC/LVh5n4lHe9vDRC6xsonuC8EABz7pXLwCJHPgefTcVjqavAKoSwMuWKN6621hNLTk1L7dWUNx0ZA3GJfhF5LVgeZNqkDEwEO6CWG0n8836Kudlm0/25nVAl5pA6u+c7j8byjqkjwq+Sgz8DuUocvJzf1ZvbZ3aoShe3mdBF5tQSXDLuzzRbbPGOkbuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h48+r8RSIA4VFIM1lCFDUOuqECK+IBBfTUlh+dPqjuI=;
 b=IdKWp1ZTk+udhJcyH4HfDAsHfvI/kHTw2SUOwIicxEL01MFDw/N0gTMIBssHHn62ErF/xXqzn/wWZu/n76JERgIrwwxWEeK7LyricjGr+v6ZNGQb4i6cFNmpp8Hd1hMwCCZosxpEXIlThlk5bMmxIBBb9I6bspOaAXsFPA38tl4tI0WUm7UPljbbEjVMnoCit2+qt6L2Ihf1n7kByq+6aKJri5TzXc0bV1EuYe2uEqVD3jk4f5mkChvzDtIL00j5oaoOU/5vm0jkINXfunUBaZ6BkKBJmyKx/RACMzQTLFv5eA1iJbeKeV/HLOHtPrVHWtgoKkvujWQihzSMz+sRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BYAPR11MB2904.namprd11.prod.outlook.com (2603:10b6:a03:87::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 20:55:06 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4%7]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 20:55:06 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/5] cxl/region: Constrain region granularity scaling
 factor
Thread-Topic: [PATCH 5/5] cxl/region: Constrain region granularity scaling
 factor
Thread-Index: AQHYni9aYJCfvukT1ESY9jJPtvt0c62alZSA
Date:   Mon, 1 Aug 2022 20:55:06 +0000
Message-ID: <35ed902a167296cb5766f02580c39cc583885b57.camel@intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
         <165853778028.2430596.7493880465382850752.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165853778028.2430596.7493880465382850752.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8db9fff-3a43-4fa4-7cd7-08da74001d26
x-ms-traffictypediagnostic: BYAPR11MB2904:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOQFhQfcxw4MKHde8tnuwsIKF29nk9CtB+sm5BVcG3a4BYIqzgDCrpjxJauRQC5U3NWZPCOrT3pL6b+CBMDMMwWO5ELCfqhQWmYLes6HOf+JnpwuFRry86d8HOMvAhB3rUJNQLLOb16S1w18J5JDI/b2Sh5VkuWST/YUKiUxI6XAUywwD0jP8Zi1kERtcHMCuOmIq/W5tNeLyvChgyGXDMeyebIixCWgHoffVXgGbzvmceQNyWa8ob+ltHwp6cNR9bJiFviiGfC7yxMYGkBJLscAlKhSEYDpENIcsmthkw0fp6R/VAgMBb+aW1roL91bPv9maehQJp4kZx1dTOnou54NoDfO1F1ehiaXFFxXnnItpJfN+HJ1RIxHS7Kgo9JLUFfbQN29r/UK/WfPlFG9XmDSmolGEZrPukS3wLXO1Cy/4HYuTsGRLWiQgwfAIM4c6SKgcsMkqLoCayfe1YUtpOaDPuLFW4tAvn4v4ruwh85bz64rWkXj/hy3YavUQ+9OLUpfcveIDs8YFNoUjZx6E6jigFVbQAGDE5ECRg31dSmXmgQiYz/jL4iwJQ5YfVEGAUj3qf9SXQBvRH/v70Roz2JKN9DCi2ZC0WvI6PRu3/4lT96vWmKooqAsSQPcY2p4QVDUmMIygI1Mi9pR9+QCGVSmvv3hE0ABKgBFC2mQZM1CeOg7UIm156WA0PHjufBE6Mf3qhVfSn9/e42AC+smczbyVZitmPWD4QlwP7KkQhDkWuRXY2y6RwtywJjsYvFaZw5DJdxlPPGMMA6gH2YPS2GmVKQx/hsa5fLEQ0bYmj5IWVZmyuTusHucWjBhVCvx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(396003)(376002)(366004)(186003)(2616005)(83380400001)(110136005)(6506007)(36756003)(26005)(2906002)(41300700001)(6512007)(86362001)(82960400001)(122000001)(38070700005)(6486002)(66476007)(66946007)(8936002)(478600001)(316002)(38100700002)(66556008)(66446008)(91956017)(5660300002)(76116006)(71200400001)(4326008)(64756008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3FYRWczYWZVNUtXMjZQNHFraVdRbXFyOWJ5OXZmYUI4ZGkyQTNpVkRjZWdC?=
 =?utf-8?B?ZmdhZVl6QzBYK0FtYThSNDZselMwbVhVakdleGwvVEVjLzhaOVd3QWFCd3cx?=
 =?utf-8?B?QUpMTmQ3NDRNMUJPaDhvanRiNGN6R1NoKzJFYmVpMTNsNnQ0WVpOYmVTRWVI?=
 =?utf-8?B?TksydFA5QlZhU0tRS25aeC9KZTBOdHFRSngvTytFcFFiU0NMMGM3NTZmaG91?=
 =?utf-8?B?dzdhLzZseDFIVDJrL01vQTc5NVdCaGlxZHlGeUhjeWlKV3A5YzQvUE4vTDJy?=
 =?utf-8?B?YlFyVHpvMDlBZDFkSXNEbnM5YlI5RWpaL3R2VEV4SWdObk42a2NnRUR5dERK?=
 =?utf-8?B?WmZ0THlVVDEzMU81eDUycnEvTlIxdTBLZUIzSGczZll3RFMyNTdYNnJRU1ZJ?=
 =?utf-8?B?eG8vT3ptUVJqeTA5YW1GRkpOKzBhUVJua0JUdkpqd200UUtpb3NYTFY3T1Bm?=
 =?utf-8?B?TUg1VERGRWZibUkrdGRDaTJrajB0RmE2OS9pcnkwc2lqa04xaXFkbGE4eXFK?=
 =?utf-8?B?RmlqbHhkelI5QWgzZ0hvaHdxMzFId2ZLSEtsS21tV2tZWmdxQ0sxR1pxR2hx?=
 =?utf-8?B?R0cyc3JEb0lJNmJjWlorWHhOTklsNm5UZDZGSzZGUjJpZ2lsNS8zaWFURzl1?=
 =?utf-8?B?MG0xNE90MmJqbmtrd0U3QjdGWStiY3YwUWpIZDBBdSt5ODZKWFVyVWxRYjB5?=
 =?utf-8?B?cXQybWt2VnR1NmVJclROdGJybmFMMEJidVNWdGdrMlRxcHJIYXpGbHUxblpY?=
 =?utf-8?B?MjNGbWNaVXF6YmJOdUJmQkpJU0pFTDV0NEFvSXBSNzErOUR1NGpEcElac0wz?=
 =?utf-8?B?VDdyeTZzSy9YWlphZk05VklaeFR1UytrTU5TTlRoWmpJeVBNUVB3SURFWjdk?=
 =?utf-8?B?aVNXRGQ2Ym1PS0IyN1ZTNThsQ3ZIeC9qMnZLeDVQaGM3ZUJmMEZ3QktGeUNx?=
 =?utf-8?B?cmd5WlZ2WG5ocUZoTkJoR01xZHFhQ2xtU3dsUWsxU3BuTFB3azRHNXJ2Rmx3?=
 =?utf-8?B?Tk41RzlDRHErdWQ0cUczcEM2MUZiRTZteUxtZEZPek9WZVY1OUJSVzA4UnZ3?=
 =?utf-8?B?ekNESjljVm1zWGk3eXVUWUlMSFhZVmszb1lERHd5ckMwY05IbGlTTFh0amdO?=
 =?utf-8?B?QVpObVJodmF6bkU5NkRhd1RIQ2x1UmZKWTh2TFdvVThuSEZvUGR2ZStZZGJ1?=
 =?utf-8?B?QnhIc2JmRzAvTXRxdnZ2UHhLVGVXMlNOK0hpTUxvODFvdmFBUkZ2TEFjbW5o?=
 =?utf-8?B?R2tjZ25SMXlZeUtmZ1UxdWs1OE9ZVjZMWVN1UGpPRm1BZWZGNW9TaUNEWktM?=
 =?utf-8?B?NU9YL0RoNld3TXVPQlFPOXFMSUJuMlF0ZHYrMkE2WXhGVWdjZ3lPN2dBaXJV?=
 =?utf-8?B?UkxHOGcrcnhtcytybm8xMjZmU1F5WjNJbFo5YTlhbGNNa3p1dzgxNXA4VlJm?=
 =?utf-8?B?ZWovMHFjbFZDNU1McDIyNHVrdmN0bkIzOS91ekNrSkM1TXUvYS82TitUVGx1?=
 =?utf-8?B?L0F6UjFOeCtIa2RYUnhOZzJpdERxZDZDRXh2QnZVWFZhaGE5TzFjNTZvZWJH?=
 =?utf-8?B?K1dxQnpKU214L2VFbkJ5ZGJvRWhmMytlT3F0bDJUZ1JlU29JMzJvd09hS2ps?=
 =?utf-8?B?OVdvRVVZVjRiVGRSYjljeVpGbCtOOUFEWld4T0tGNzZrS2NMNm1uMVpGNkRP?=
 =?utf-8?B?OWhBYUNlYmpxNEZMT2szbDNXb3pQUTZGalRJc1dyY1dibG9TZzRvYlpBaHZq?=
 =?utf-8?B?eGpqNnlyZmppUUM5dlI0NUR2TWNvVnVJYzRrN0c1SWVub3I2cGF2UHZYTEtG?=
 =?utf-8?B?OHJDVTdSN3dtN3lERWkvT21PUXN1REdTL251R2I1amY1Vm8vVzBEd1BYYytm?=
 =?utf-8?B?ajFOYmtseC9lZjFsN0MwM3FpZldsTnFaNzhQTW5pQlkzeWIxNVN1a0Nac1py?=
 =?utf-8?B?M2xhNlhPb3QzemVrNlhBSHFQUHJwaXE0RVF3OEsyeUVTM2g1V1NGRS9rQzJm?=
 =?utf-8?B?SEJsb2sydmNBaDU3b04rQkIvS2lBdTR2THJ5MGJ0amhYTUQzVTlKTU9YcWEz?=
 =?utf-8?B?R3U1OUlFN0cwdnRHdXlPQy9oRnBYb2UwbXBtdFFXMVEvWkpMWVVJQVA2WHlM?=
 =?utf-8?B?MThXNGhrUmcrakJicHJ2d2dJeFFNMjJCdmJ3YmhwMUNPYVlRMm5GeG53N2hu?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E676EC8303C6B4EAFC9764A02C69164@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8db9fff-3a43-4fa4-7cd7-08da74001d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 20:55:06.3917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVu5EKtEqT+k+myXnbncvmLLJA2YgNst7hyj71W2dhp4hoRDOyxiiH41lq6utsYtaQjodvrm61j8GTXdU7ZxB4wwdKkVo2PslWSdrbkelOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2904
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTIyIGF0IDE3OjU2IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
Q29uc2lkZXIgdGhlIHNjZW5hcmlvIHdoZXJlIGEgcGxhdGZvcm0gcHJvdmlkZXMgZm9yIGEgeDIg
aG9zdC1icmlkZ2UKPiBpbnRlcmxlYXZlIGF0IGEgZ3JhbnVsYXJpdHkgb2YgMjU2IGJ5dGVzLiBU
aGUgb25seSBwZXJtaXR0ZWQgcmVnaW9uCj4gZ3JhbnVsYXJpdGllcyBmb3IgdGhhdCBjb25maWd1
cmF0aW9uIGFyZSAyNTYgb3IgNTEyLiBBbnl0aGluZyBsYXJnZXIKPiB0aGFuIDUxMiByZXN1bHRz
IGluIHVubWFwcGVkIGNhcGFjaXR5IHdpdGhpbiBhIGdpdmVuIGRlY29kZXIuIEFsc28sIGlmCj4g
dGhlIHJlZ2lvbiBncmFudWxhcml0eSBpcyA1MTIgdGhlbiB0aGUgaW50ZXJsZWF2ZV93YXlzIGZv
ciB0aGUgcmVnaW9uCj4gbXVzdCBiZSA0IHRvIGtlZXAgdGhlIHNjYWxpbmcgbWF0Y2hlZC4KPiAK
PiBIZXJlIGFyZSB0aGUgdHJhbnNsYXRpb25zIGZvciB0aGUgZmlyc3QgKDQpIDI1Ni1ieXRlIGJs
b2NrcyB3aGVyZSBhbgo+IGVuZHBvaW50IGRlY29kZXIgaXMgY29uZmlndXJlZCBmb3IgYSA1MTIt
Ynl0ZSBncmFudWxhcml0eToKPiAKPiBCbG9ja1swXSA9PiBIQjAgPT4gRFBBOiAwCj4gQmxvY2tb
MV0gPT4gSEIxID0+IERQQTogMAo+IEJsb2NrWzJdID0+IEhCMCA9PiBEUEE6IDAKPiBCbG9ja1sz
XSA9PiBIQjEgPT4gRFBBOiAwCj4gCj4gSW4gb3JkZXIgZm9yIHRob3NlIHRyYW5zbGF0aW9ucyB0
byBub3QgYWxpYXMgdGhlIHJlZ2lvbiBpbnRlcmxlYXZlIHdheXMKPiBtdXN0IGJlIDQgcmVzdWx0
aW5nIGluOgo+IAo+IEJsb2NrWzBdID0+IEhCMCA9PiBEZXYwID0+IERQQTogMAo+IEJsb2NrWzFd
ID0+IEhCMSA9PiBEZXYxID0+IERQQTogMAo+IEJsb2NrWzJdID0+IEhCMCA9PiBEZXYyID0+IERQ
QTogMAo+IEJsb2NrWzNdID0+IEhCMSA9PiBEZXYzID0+IERQQTogMAo+IAo+IC4uLm5vdCAyLCBy
ZXN1bHRpbmcgaW46Cj4gCj4gQmxvY2tbMF0gPT4gSEIwID0+IERldjAgPT4gRFBBOiAwCj4gQmxv
Y2tbMV0gPT4gSEIxID0+IERldjEgPT4gRFBBOiAwCj4gQmxvY2tbMl0gPT4gSEIwID0+IERldjAg
PT4gRFBBOiAwICEKPiBCbG9ja1szXSA9PiBIQjEgPT4gRGV2MSA9PiBEUEE6IDAgIQo+IAo+IEdp
dmVuIHRvb2xpbmcgaXMgYWxyZWFkeSBiZWluZyBidWlsdCBhcm91bmQgdGhpcyBBQkkgYWxsb3cg
Zm9yCj4gZ3JhbnVsYXJpdHkgYW5kIHdheXMgdG8gYmUgc2V0IGluIGVpdGhlciBvcmRlciBhbmQg
dmFsaWRhdGUgdGhlCj4gY29tYmluYXRpb24gb25jZSBib3RoIGFyZSBzZXQuCj4gCj4gUmVwb3J0
ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KPiAt
LS0KPiDCoGRyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgfMKgwqAgNjMgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNjAgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCkxvb2tzIGdvb2QsIAoKUmV2aWV3ZWQtYnk6IFZp
c2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPgoKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMKPiBp
bmRleCAwNWI2MjEyZTYzOTkuLmEzNGU1MzdlNGNiMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2N4
bC9jb3JlL3JlZ2lvbi5jCj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYwo+IEBAIC0z
NDgsNiArMzQ4LDI1IEBAIHN0YXRpYyBzc2l6ZV90IGludGVybGVhdmVfd2F5c19zdG9yZShzdHJ1
Y3QgZGV2aWNlICpkZXYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91
dDsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgLyoKPiArwqDCoMKg
wqDCoMKgwqAgKiBJZiByZWdpb24gZ3JhbnVsYXJpdHkgaGFzIGJlZW4gc2V0IGFuZCB4SEIgaW50
ZXJsZWF2ZSBpcyBhY3RpdmUsCj4gK8KgwqDCoMKgwqDCoMKgICogdmFsaWRhdGUgdGhhdCBncmFu
dWxhcml0eSBpcyBjb21wYXRpYmxlIHdpdGggc3BlY2lmaWVkIHdheXMuCj4gK8KgwqDCoMKgwqDC
oMKgICogT3RoZXJ3aXNlIGFsbG93IHdheXMgdG8gYmUgc2V0IG5vdyBhbmQgZGVwZW5kIG9uCj4g
K8KgwqDCoMKgwqDCoMKgICogaW50ZXJsZWF2ZV9ncmFudWxhcml0eV9zdG9yZSgpIHRvIHZhbGlk
YXRlIHRoaXMgY29uc3RyYWludC4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKg
wqBpZiAoY3hsZC0+aW50ZXJsZWF2ZV93YXlzID4gMSAmJgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oCBwLT5pbnRlcmxlYXZlX2dyYW51bGFyaXR5ID4gY3hsZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0
eSAmJgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBwLT5pbnRlcmxlYXZlX2dyYW51bGFyaXR5IC8g
Y3hsZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0eSAhPQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdmFsIC8gY3hsZC0+aW50ZXJsZWF2ZV93YXlzKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9kYmcoZGV2LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIndheXMgc2NhbGluZyBmYWN0b3IgJWQgbWlzbWF0
Y2ggd2l0aCBncmFudWxhcml0eSAlZFxuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHZhbCAvIGN4bGQtPmludGVybGVhdmVfd2F5cywKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHAtPmludGVybGVhdmVfZ3Jh
bnVsYXJpdHkgLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGN4bGQtPmludGVybGVhdmVfZ3JhbnVsYXJpdHkpOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IC1FSU5WQUw7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gwqDCoMKg
wqDCoMKgwqDCoHNhdmUgPSBwLT5pbnRlcmxlYXZlX3dheXM7Cj4gwqDCoMKgwqDCoMKgwqDCoHAt
PmludGVybGVhdmVfd2F5cyA9IHZhbDsKPiDCoMKgwqDCoMKgwqDCoMKgcmMgPSBzeXNmc191cGRh
dGVfZ3JvdXAoJmN4bHItPmRldi5rb2JqLCBnZXRfY3hsX3JlZ2lvbl90YXJnZXRfZ3JvdXAoKSk7
Cj4gQEAgLTM4Niw3ICs0MDUsNyBAQCBzdGF0aWMgc3NpemVfdCBpbnRlcmxlYXZlX2dyYW51bGFy
aXR5X3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGN4
bF9kZWNvZGVyICpjeGxkID0gJmN4bHJkLT5jeGxzZC5jeGxkOwo+IMKgwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciA9IHRvX2N4bF9yZWdpb24oZGV2KTsKPiDCoMKgwqDCoMKg
wqDCoMKgc3RydWN0IGN4bF9yZWdpb25fcGFyYW1zICpwID0gJmN4bHItPnBhcmFtczsKPiAtwqDC
oMKgwqDCoMKgwqBpbnQgcmMsIHZhbDsKPiArwqDCoMKgwqDCoMKgwqBpbnQgcmMsIHZhbCwgd2F5
czsKPiDCoMKgwqDCoMKgwqDCoMKgdTE2IGlnOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJjID0g
a3N0cnRvaW50KGJ1ZiwgMCwgJnZhbCk7Cj4gQEAgLTQwMyw5ICs0MjIsMjkgQEAgc3RhdGljIHNz
aXplX3QgaW50ZXJsZWF2ZV9ncmFudWxhcml0eV9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4g
wqDCoMKgwqDCoMKgwqDCoCAqIGdyYW51bGFyaXR5IGxlc3MgdGhhbiB0aGUgcm9vdCBpbnRlcmxl
YXZlIHJlc3VsdCBpbiBuZWVkaW5nCj4gwqDCoMKgwqDCoMKgwqDCoCAqIG11bHRpcGxlIGVuZHBv
aW50cyB0byBzdXBwb3J0IGEgc2luZ2xlIHNsb3QgaW4gdGhlCj4gwqDCoMKgwqDCoMKgwqDCoCAq
IGludGVybGVhdmUuCj4gK8KgwqDCoMKgwqDCoMKgICoKPiArwqDCoMKgwqDCoMKgwqAgKiBXaGVu
IHRoZSByb290IGludGVybGVhdmUgd2F5cyBpcyAxIHRoZW4gdGhlIHJvb3QgZ3JhbnVsYXJpdHkg
aXMgYQo+ICvCoMKgwqDCoMKgwqDCoCAqIGRvbid0IGNhcmUuCj4gK8KgwqDCoMKgwqDCoMKgICoK
PiArwqDCoMKgwqDCoMKgwqAgKiBMaW1pdCByZWdpb24gZ3JhbnVsYXJpdHkgdG8gY3hsZC0+aW50
ZXJsZWF2ZV9ncmFudWxhcml0eSAqCj4gK8KgwqDCoMKgwqDCoMKgICogcm91bmRkb3duX3Bvd19v
Zl90d28oY3hsZC0+aW50ZXJsZWF2ZV93YXlzKSBvdGhlcndpc2UgaG9sZXMgcmVzdWx0IGluCj4g
K8KgwqDCoMKgwqDCoMKgICogdGhlIGRlY29kZSBhdCBlYWNoIGVuZHBvaW50LiBOb3RlIHRoYXQg
cm91bmRkb3duX3Bvd19vZl90d28oKQo+ICvCoMKgwqDCoMKgwqDCoCAqIGFjY291bnRzIGZvciB4
MywgeDYsIGFuZCB4OSByb290IGludGVyZWxlYXZlLgo+IMKgwqDCoMKgwqDCoMKgwqAgKi8KPiAt
wqDCoMKgwqDCoMKgwqBpZiAodmFsIDwgY3hsZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0eSkKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4gK8KgwqDCoMKg
wqDCoMKgd2F5cyA9IHJvdW5kZG93bl9wb3dfb2ZfdHdvKGN4bGQtPmludGVybGVhdmVfd2F5cyk7
Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKHdheXMgPiAxKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmICh2YWwgPCBjeGxkLT5pbnRlcmxlYXZlX2dyYW51bGFyaXR5KSB7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZGJnKGRldiwg
ImdyYW51bGFyaXR5ICVkIG11c3QgYmUgPj0gJWRcbiIsIHZhbCwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjeGxkLT5pbnRl
cmxlYXZlX2dyYW51bGFyaXR5KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodmFsID4gY3hs
ZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0eSAqIHdheXMpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9kYmcoZGV2LCAiZ3JhbnVsYXJpdHkgJWQg
bXVzdCBiZSA8PSAlZFxuIiwgdmFsLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGN4bGQtPmludGVybGVhdmVfZ3JhbnVsYXJp
dHkgKiB3YXlzKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiAtRUlOVkFMOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4g
K8KgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHJjID0gZG93bl93cml0ZV9r
aWxsYWJsZSgmY3hsX3JlZ2lvbl9yd3NlbSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyYykKPiBA
QCAtNDE1LDYgKzQ1NCwyNCBAQCBzdGF0aWMgc3NpemVfdCBpbnRlcmxlYXZlX2dyYW51bGFyaXR5
X3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdvdG8gb3V0Owo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqAv
Kgo+ICvCoMKgwqDCoMKgwqDCoCAqIElmIHJlZ2lvbiB3YXlzIGhhcyBiZWVuIHNldCBhbmQgeEhC
IGludGVybGVhdmUgaXMgYWN0aXZlLCB2YWxpZGF0ZQo+ICvCoMKgwqDCoMKgwqDCoCAqIHRoYXQg
d2F5cyBpcyBjb21wYXRpYmxlIHdpdGggc3BlY2lmaWVkIGdyYW51bGFyaXR5LsKgIE90aGVyd2lz
ZSBhbGxvdwo+ICvCoMKgwqDCoMKgwqDCoCAqIGdyYW51bGFyaXR5IHRvIGJlIHNldCBub3cgYW5k
IGRlcGVuZCBvbiBpbnRlcmxlYXZlX3dheXNfc3RvcmUoKSB0bwo+ICvCoMKgwqDCoMKgwqDCoCAq
IHZhbGlkYXRlIHRoaXMgY29uc3RyYWludC4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKg
wqDCoMKgwqBpZiAoY3hsZC0+aW50ZXJsZWF2ZV93YXlzID4gMSAmJiBwLT5pbnRlcmxlYXZlX3dh
eXMgJiYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsID4gY3hsZC0+aW50ZXJsZWF2ZV9ncmFu
dWxhcml0eSAmJgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBwLT5pbnRlcmxlYXZlX3dheXMgLyBj
eGxkLT5pbnRlcmxlYXZlX3dheXMgIT0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHZhbCAvIGN4bGQtPmludGVybGVhdmVfZ3JhbnVsYXJpdHkpIHsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2RiZyhkZXYsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiZ3JhbnVsYXJpdHkgc2NhbGluZyBmYWN0b3IgJWQg
bWlzbWF0Y2ggd2l0aCB3YXlzICVkXG4iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdmFsIC8gY3hsZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0eSwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHAtPmludGVybGVh
dmVfd2F5cyAvIGN4bGQtPmludGVybGVhdmVfd2F5cyk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJjID0gLUVJTlZBTDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byBvdXQ7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgcC0+aW50
ZXJsZWF2ZV9ncmFudWxhcml0eSA9IHZhbDsKPiDCoG91dDoKPiDCoMKgwqDCoMKgwqDCoMKgdXBf
d3JpdGUoJmN4bF9yZWdpb25fcndzZW0pOwo+IAoK
