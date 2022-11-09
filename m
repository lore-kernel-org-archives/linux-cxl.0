Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A082C433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Nov 2022 00:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiKIAsZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 19:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiKIAsY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 19:48:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01550250
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 16:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667954903; x=1699490903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FN4sJxaTUcwCNxd2bN6icGscZJCfxuEBXerfVjjJyoU=;
  b=chPzW+vOTMq+HSCbrbedimZmpC8uN2f1l+FVNDX+efZrHjLJA9E5UjPX
   MM+3eRb/lL4W2lB62LKPJoCqemxhD4bNqNsoUL6nHTX9OYXJP9QdE6KUg
   elGvBATpV5P3oqVZ7tY3xCEFKmVcu6FWNg4Mo7AfNxvwT4aMmLUK5jw0x
   TK4jDANm+/SVJa2nC8subwjpL06B7Ht7ZiUHlgvLRj2aiNVyYAWV8bEXq
   u8G1U4n6gYbPypPnL1HiNNLJm6e6iH5NvnR70kJomiv4Wgp8+v+HJsi9e
   qQwvZEeWgOj5DB9bELnDcwup47m2y/u688NcQYms5zDPqYmfiYYqNSi9C
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312645293"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="312645293"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 16:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="700141427"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="700141427"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2022 16:48:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 16:48:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 16:48:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 16:48:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 16:48:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYZ6GFpJdNEIHmBQpr1DY2oYhJzBmtHqMFytppbV+sNEzS2QUVdLz39hYxvu2MKo6R6vz5KaW23QeqSS22DpaSr4HebbvcgyJHxZ+FbturW60nr4Mj2zukYjQ8qYKpdvZ/5r5dgnejGEzexKbnQfZYOQH2Y0qAS12XFESFTgvZTB+/FvL3tJGn+VL9VwpFOCeUCsr2MDTsUnzE3g63/f89VPNX7migLPIOlOj8d2GiPU4Rk6KVd5vxBy2Z0lBYAOAJWszO3s7W1JG1zx+0UgHqbHxe8MbkW7++DxEzO3t2Gy2K9bpE0is+n6g2lr7yOUUcM7vwv6J6phm4sCgK7g3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN4sJxaTUcwCNxd2bN6icGscZJCfxuEBXerfVjjJyoU=;
 b=XfQ85MrilFkBeo3F1/gAKgWphsEUoJ5qSU3gVrMmghzKqMIfEVfkR0pKZDGo3Lxm5LQKCzrZlo//ViEIr2jynsNr6boi8D2RFRFW0I/Qru+/1NVPUijyaCHWjx4GznRvMH8tQ8DVTrCC3WvMpPgZeQNlvx1cHODTN8ckcczTsXR5YHuw5oB7VUF4a4UykTvZGiff+TLkA3IPYjsTBptpnRPC/P/hPf0NUJmdntmQwkuf06m7XeRAPTtTysGTJ6GFlHuBvrDkxqVhvK4cJvgcycAn6RRNF8WK9kNFs2hhGFhfN/GAyLzPRNZRk0cVA5Ex8rzXaIZZGfSaMRlGDwuOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 00:48:13 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 00:48:13 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 08/10] cxl: add an optional pid check to event parsing
Thread-Topic: [PATCH v4 08/10] cxl: add an optional pid check to event parsing
Thread-Index: AQHY86A9OTi4G2NMKkCy9AXqbj/g9641wqGA
Date:   Wed, 9 Nov 2022 00:48:13 +0000
Message-ID: <7668b03a0b6fd5b92128446654833f643ada90ce.camel@intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
         <166793223408.3768752.4466685754838805704.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793223408.3768752.4466685754838805704.stgit@djiang5-desk3.ch.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DM4PR11MB5328:EE_
x-ms-office365-filtering-correlation-id: 6937814f-8dd0-4a00-570b-08dac1ec14cd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aRIQTWkAKiWTAlg7lTKM3tSEAyJwLNxB2C23LxDWBPHsOX+uelrQ7OORMfg/hdegRDgb9UX/JtMIyaIXC2c7xXZNl2B9HCU2zROKDyv7TaW4JW0+MjGw6ZleUm+GcsD0oPsbeJC0OQjEXAkNl9o7PjIkV+4p5A0iIuqv5g0frj5DM59DY5poDMt9gUz+Sf2WgNO/b8qh1lo8fSdT/xWAro07AoebqOH5lMPvBNefQnF+PTY97jIRMSp7EgjtJpbXaRygdc+RhfiDM+LtYVzrK3x23cTMZ3xIV220ZwSuIacEhaw1Gx+03DqPa5XK1diGOOiUKvA4ayv7mo1vJOa/av1XxGJf7Z4zVW9wyFek4IJDoJVNA+ul5gGMqrpV/tVTD0mBd4PBLw0qmoZ5EqBKAhCuLga4sTOl/Ks04c74Afq/YTsvQUg9vmKpuMJJBQRU2lH36arl/YndFPpqk3Fhgx6moHYGfOjK5/NYk9C3Ln0J7H2zn7vlU4SSA1K9nS7t1MnrsxsSbM93VcgWh3n5L1Zxsi267tDFPmvFMV+vEiqOxPnPgRtkbjMCFqKIGMwT47ZfcwD6R63BS1lRwkx+Z2/bCT7QFoqewX6ZeT1UfZxw54fLw8mBUjxQceMayX14b/St7CDf5sOcuHIGK+bAg+LJ5mhFKkkZecYT47hiSXg4sd7aU02UyLYrU6BjGY6gDUBxBSNU6gU4f/a8cZ5d1XUcQNX7KlBjedKQLT7Bq89arj0udRF3MWqvyyYpRQ++vvO3Rfqfmcf1mesVBSdNow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(2616005)(6512007)(122000001)(186003)(107886003)(6506007)(26005)(83380400001)(38100700002)(2906002)(110136005)(316002)(76116006)(478600001)(54906003)(4326008)(6486002)(71200400001)(5660300002)(91956017)(41300700001)(8936002)(66946007)(66556008)(66446008)(64756008)(8676002)(66476007)(36756003)(38070700005)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RytudlkweTNWYk03cjNoNkpCNFlZZDdFQ3ZRVXU0TGFNZ1dzTnMwVXZmQ2pP?=
 =?utf-8?B?UW1CY2g0dGc0b000QTgwWW9LeDZpSk8vTUg5TUxUMWNRRndVcTQyTGkyemc1?=
 =?utf-8?B?S1FFOVFDamZYdlhpZ0ppT0s3alFoMDlmVmNDck1YbEZYT1J6cXV2dmhZMkVQ?=
 =?utf-8?B?L3JubVQ5STl2WURwcFd4b2hUYmt5d0VBS2hubVB6UXpGQVdxWDErT21JcjZL?=
 =?utf-8?B?bXk2VzJ2SlJnSzIycDVPdy9uT0hqenBOWk9JUUNXckw0M1F3b2N5czk4c2ZJ?=
 =?utf-8?B?c2hXeldCdUNtZlFjUUlxRWJUa0ZBZHRuM2cvYmxwZDhMeHMwV2lrUzRnVmhk?=
 =?utf-8?B?eHE3VzUrNExSZDZNVC9oTkV0cnRqUnlvYWxxRjl5T1hHMGUrVWZpaHdnV2Vh?=
 =?utf-8?B?ZUt6bEpoM2V0UUkrUzBjWTBtQXNjTVcybXRjNkw4WnBlUWVSZFRvb212RHpu?=
 =?utf-8?B?c1RsWWttVmN4UUxhZnczMU1hNGlzSWlUaHNVMXBBZWpJZkVKcjJ6WldWOE5V?=
 =?utf-8?B?WnF6SEFRcHM1dGJ5S1FYM2UrZk5WTHJGSDcrSU5XM0VvVXJrR3FZRkZySkZB?=
 =?utf-8?B?YjN2T05tMjIzLzJ5eVJ3QXNWM1ZEditvN2gxbnZRb0RnVTJramo2eGFlMnhX?=
 =?utf-8?B?Q3dhUkhxaHVUU2JvNmRkcWtoUEdicnkrRE9hMG5IRHhUTENlQTlIaUJDQXMx?=
 =?utf-8?B?d0d5cU52eVR5Qlp1YlhrNjBQQ0VPT3dyWFExYWxKUjlUcURjT3NSanNjSUk4?=
 =?utf-8?B?VWFPVEtvSjJvRFFEVGJiQTkvcUFhWDhFazZnM2xHQzBSaFE0ZDBZQkt2cnpj?=
 =?utf-8?B?d2YyN2RwOXNUdmxsRS9QK0V2Z2w1MGJYTm9ybEVRc3pFVlhZNXYyejJjTmRT?=
 =?utf-8?B?Y3pWcTZzZTNMQ1ZST1hkbGZveDdWa2liTlNtcmZyaDBOb2E4U0tuTnJTTE0y?=
 =?utf-8?B?YkM2T0xYdGNoQ291UWhWVzlGN0oydmVXY3cyUzZyb0E3Q3kyS1RINm5pdFlK?=
 =?utf-8?B?K2oxOXdqc0FWd294cE9jTjdQQ2tCQkd0RzdleEZpVVU1S2U3d2V2MDF0RmpC?=
 =?utf-8?B?a2NDMWgxSDZSSzFlZXlEYi9OcnFydUVZWnpPclV2c3N3eHJNR1lnWUJLUVRm?=
 =?utf-8?B?VnRUcHFXUWJTTTF5TWFqVjhpSDBZYzZGTWFqTG5oVFFWZkhLcG1kZk9PTGtQ?=
 =?utf-8?B?cmk0YkMweUN1TjYvcGpGdWMzZGZ0VFBpamZZV2hNSmRIQXg1Yld6VUw3ZVlV?=
 =?utf-8?B?N1FvbDltZWJwRlVoOWU0VG02RER6VHIxQVBXRmFiVk1PZ09lNXFxOTdNaHdM?=
 =?utf-8?B?M0lDUFJJZ3czcWt4bE5jUzVYcC95WlJRb21BbFY2WlFEK3ozeE5MM1hzdThs?=
 =?utf-8?B?VFNMS0MxY2U3VGp5eHF3OUpyWDViWHdNQ3NLU3k0RHhtMlZINlp5bE4rSExq?=
 =?utf-8?B?WlZHcVAzenQ4ZHM5a1dOSUlxQzhUbkdBUjQ1VjVuWVRlbWNqSVNXNnZ3c3A3?=
 =?utf-8?B?OUxoY3djZEkxTDJEYW4yemxYWkVhYmxQWEg4eWx3eHVtNVFOeW9BQStjU0hm?=
 =?utf-8?B?b25wNStFTEt4dFBvKzVtSVFpMlM1Z2FzOHVxcVJwRnkyWFhRU0pUakIrMGJ3?=
 =?utf-8?B?MXVMNkN3ZkV6MVhoa1QwRjN5NUpVUHpqTjVQZm5hUkZSbGcxUUFSTXZFekFw?=
 =?utf-8?B?M1Z1VFlpR1JIQm8wMExJWXFvUFBWRmc3Ky9MbkhIUCtUNm8zbHVFR2xLSGhZ?=
 =?utf-8?B?TlZJdDRubzJ5V3h5K2MxajNHU3pkR21ZdHJiZ1pYZE5VZVZac0U4a2dFNTZ5?=
 =?utf-8?B?WS92MHhIL2ZHYzFFYkJ0Z2t6dXd1bUNuRVRMMVVvNityVUNrQW5ZYzF1bVdl?=
 =?utf-8?B?K1NVZXF0cU8xejQyWlBlUy9ZWTZ1ZXM1VmFPbm93VlJET0ZtYTBWL1lVbExh?=
 =?utf-8?B?MVdvNHlURUpWY2JDSEtWL0FzNjlvdmVoUXFCeldjeEdJTzc0cndHK0lCaWFX?=
 =?utf-8?B?VlZCS29TVjdvRGdvbDlheHQvbXV2NjRXQzMvUWUyem84d1BFejlHOStFc1I4?=
 =?utf-8?B?ZXc1ZmZBZkZEdy9ucUdaclBDTmNGeGh3a21pVzNMUnIydUU1ZGRaMWxQN0VB?=
 =?utf-8?B?VEhVSXpWOUF1SDBHVUM2L1djeFE0THVkd2Q4T010YWFtVSt2MmdrWlhTMk5M?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF1130D3B0BCEF459F2A4F15EDE18478@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6937814f-8dd0-4a00-570b-08dac1ec14cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 00:48:13.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlY1+Fh8f1BlcBMSHDAxvfdGgQdq89KuqZv/s8FlWQ+9P246V8xSiGFz1Rf/L0k4n3BrQbOG4JKRHX5uDs1bdrVfDFSEsab4n/jar4ejAxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDExOjMwIC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOgo+IEZy
b206IEFsaXNvbiBTY2hvZmllbGQgPGFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29tPgo+IAo+IFdo
ZW4gcGFyc2luZyBDWEwgZXZlbnRzLCBjYWxsZXJzIG1heSBvbmx5IGJlIGludGVyZXN0ZWQgaW4g
ZXZlbnRzCj4gdGhhdCBvcmlnaW5hdGUgZnJvbSB0aGUgY3VycmVudCBwcm9jZXNzLiBJbnRyb2R1
Y2UgYW4gb3B0aW9uYWwKPiBhcmd1bWVudCB0byB0aGUgZXZlbnQgdHJhY2UgY29udGV4dDogZXZl
bnRfcGlkLiBXaGVuIGV2ZW50X3BpZCBpcwo+IHByZXNlbnQsIG9ubHkgaW5jbHVkZSBldmVudHMg
d2l0aCBhIG1hdGNoaW5nIHBpZCBpbiB0aGUgcmV0dXJuZWQKPiBKU09OIGxpc3QuIEl0IGlzIG5v
dCBhIGZhaWx1cmUgdG8gc2VlIG90aGVyLCBub24gbWF0Y2hpbmcgcmVzdWx0cy4KPiBTaW1wbHkg
c2tpcCB0aG9zZS4KPiAKPiBUaGUgaW5pdGlhbCB1c2UgY2FzZSBmb3IgdGhpcyBpcyB0aGUgbGlz
dGluZyBvZiBtZWRpYSBlcnJvcnMsCj4gd2hlcmUgb25seSB0aGUgbWVkaWEtZXJyb3JzIHJlcXVl
c3RlZCBieSB0aGlzIHByb2Nlc3MgYXJlIHdhbnRlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBbGlz
b24gU2Nob2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4KPiAtLS0KPiDCoGN4bC9ldmVudF90
cmFjZS5jIHzCoMKgwqAgNSArKysrKwo+IMKgY3hsL2V2ZW50X3RyYWNlLmggfMKgwqDCoCAxICsK
PiDCoDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpJIG1pZ2h0IGJlIG1pc3Npbmcg
c29tZXRoaW5nIC0gYnV0IHRoaXMgcGF0Y2ggaXMgYWRkZWQgYXQgdGhlbiBlbmQsCndpdGhvdXQg
c3Vic2VxdWVudGx5IHVzaW5nIHRoZSBldmVudF9waWQgaW4gY3hsLW1vbml0b3I/IFNvIHdoeSBu
b3QKbGVhdmUgdGhpcyB0byBiZSBwYXJ0IG9mIHRoZSBtZWRpYSBlcnJvcnMgcGF0Y2hlcz8KCj4g
Cj4gZGlmZiAtLWdpdCBhL2N4bC9ldmVudF90cmFjZS5jIGIvY3hsL2V2ZW50X3RyYWNlLmMKPiBp
bmRleCA0OTBjMzBlMWRiZmMuLjg5YzljMmRiMjZhMyAxMDA2NDQKPiAtLS0gYS9jeGwvZXZlbnRf
dHJhY2UuYwo+ICsrKyBiL2N4bC9ldmVudF90cmFjZS5jCj4gQEAgLTIxNSw2ICsyMTUsMTEgQEAg
c3RhdGljIGludCBjeGxfZXZlbnRfcGFyc2VfY2Ioc3RydWN0IHRlcF9ldmVudCAqZXZlbnQsIHN0
cnVjdCB0ZXBfcmVjb3JkICpyZWNvcmQKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gK8Kg
wqDCoMKgwqDCoMKgaWYgKGV2ZW50X2N0eC0+ZXZlbnRfcGlkKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChldmVudF9jdHgtPmV2ZW50X3BpZCAhPSB0ZXBfZGF0YV9waWQo
ZXZlbnQtPnRlcCwgcmVjb3JkKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gwqDCoMKgwqDC
oMKgwqDCoGlmIChldmVudF9jdHgtPnBhcnNlX2V2ZW50KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIGV2ZW50X2N0eC0+cGFyc2VfZXZlbnQoZXZlbnQsIHJlY29yZCwg
JmV2ZW50X2N0eC0+amxpc3RfaGVhZCk7Cj4gwqAKPiBkaWZmIC0tZ2l0IGEvY3hsL2V2ZW50X3Ry
YWNlLmggYi9jeGwvZXZlbnRfdHJhY2UuaAo+IGluZGV4IDg5ZTk4Y2FmYjMyMC4uZTcyYjQzNDcx
NzVlIDEwMDY0NAo+IC0tLSBhL2N4bC9ldmVudF90cmFjZS5oCj4gKysrIGIvY3hsL2V2ZW50X3Ry
YWNlLmgKPiBAQCAtMTUsNiArMTUsNyBAQCBzdHJ1Y3QgZXZlbnRfY3R4IHsKPiDCoMKgwqDCoMKg
wqDCoMKgY29uc3QgY2hhciAqc3lzdGVtOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbGlzdF9o
ZWFkIGpsaXN0X2hlYWQ7Cj4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IGNoYXIgKmV2ZW50X25hbWU7
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLyogb3B0aW9uYWwgKi8KPiArwqDCoMKgwqDCoMKgwqBpbnQgZXZlbnRfcGlkO8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIG9wdGlvbmFsICovCj4gwqDCoMKgwqDCoMKgwqDC
oGludCAoKnBhcnNlX2V2ZW50KShzdHJ1Y3QgdGVwX2V2ZW50ICpldmVudCwgc3RydWN0IHRlcF9y
ZWNvcmQgKnJlY29yZCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBsaXN0X2hlYWQgKmpsaXN0X2hlYWQpO8KgwqDCoMKgwqDCoMKg
Lyogb3B0aW9uYWwgKi8KPiDCoH07Cj4gCj4gCgo=
