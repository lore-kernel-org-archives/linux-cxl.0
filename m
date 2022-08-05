Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EABC00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 21:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbiHEVy0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbiHEVyW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 17:54:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E57CE1
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659736457; x=1691272457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IX3FtoqyalMX2x3CIm5utnumSgZ1c/3bX7vJ9M5P+28=;
  b=hrYOIbYP/tnu7Tvx7aDw0DRYqmVdiIN+NVBmbzFByUeEVwaj0VhJkZnR
   tq4HRpBNirjg3DpLVwajaJppox7eIbQQZY9NXoX9ds3I3Npv+wPwxz1Gd
   mkW/KbQM1cMu0ZWK3lMxwp9A1oXFszQQtnJb+ArXCYwDphjYetHA506Gv
   S5EWMVNnBQ7Tc7CPqaGM3ljf1KbBBxjQagpvQK/49jABKW0MxpvPPUo5x
   v9iOjdbagNCAxpGf6NwJL36nwHOFx7htLyJL0x63hIh+G5QtlgqlNuCFj
   nYosvw9vjTNhz3RsRHr3z8C2UwXspGHrAZ+m5Mbx07yXMMKfMrya8Sby/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="287863568"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287863568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 14:54:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="636634917"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 05 Aug 2022 14:54:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 14:54:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 14:54:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 5 Aug 2022 14:54:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdUSDFE3Uk+TbRWw0ECBPbgQy4W7+JR+imKPmEsJZqkOFpK6auC6VZFd0oFYAP9ta90ErUJAN3CXV26aYUgzvOdKovblOhituwft1fW3DlyqIVrrt6g9ik8JzafixCgy/L9Tu85m3i59R2FCO0ifonTzY665MD9feL5TfMju+WOsFSB9Lx0JoUEA8hBFtU/uD8vrWj3S8/knBDqxwG8zDKXs4UowleHeUmN8KeM5Uvu9LT8j7eBmVmTjFsp5AlPqU3GlQFCrTHDU28cfVyNu2gCygLkZqVxfqkRe98KgC9//+4rOSbgosRC4BbWJhl2aM40vQDboabMKRCWlHArHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX3FtoqyalMX2x3CIm5utnumSgZ1c/3bX7vJ9M5P+28=;
 b=ltx7r/F9YbQc3487fVsT11IfeHVht+qw5LIuN+ipb4iy9rz3vWDdf65HIze4iVK1pKS3wc/Wyrxz2qGVXaLQhTICeEJv7le8ajXuc5b8nqNcRg6FzkkNhw/Z7QyGIMp2OvrEWSLhZVPhxr0W6M7d0h9xHemf2Ijja9/Uq8PSwuN+nH3IECXwXHX2kxZGiArJU0D6uF3KWomTFKE5dYtpBtFuQde02auYk8PZhZMZe+Fd2rCRrvX/5bwlaCDgCVtW9uL7BSs/t0+OXZ2adeOrxbhCjraEWg6THzKrhCT7WiENqz8qpwPslDUkRWrwpY9KfOFEj9v+jNezTRi+U0+kNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BY5PR11MB4420.namprd11.prod.outlook.com (2603:10b6:a03:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Fri, 5 Aug
 2022 21:54:12 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4%7]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 21:54:10 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Schofield, Alison" <alison.schofield@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/3] cxl/region: Fix x1 interleave to greater than x1
 interleave routing
Thread-Topic: [PATCH v2 2/3] cxl/region: Fix x1 interleave to greater than x1
 interleave routing
Thread-Index: AQHYqQnX6oLIBEUKqEOC6ylyoQlqPK2g2bSA
Date:   Fri, 5 Aug 2022 21:54:10 +0000
Message-ID: <b149b97b20dcfd4e3c0c59174926b749c2c474f8.camel@intel.com>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
         <165973126583.1526540.657948655360009242.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165973126583.1526540.657948655360009242.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b13d836-5ade-43f8-846e-08da772d0727
x-ms-traffictypediagnostic: BY5PR11MB4420:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3QVqypAyWH7kwJavVfpHfo4LfqyfwDSXxiw06ar3Af7x9gBxOhhBOBHFN9Fjm85ywinD5wHSZoGASn9bsYNQGEkFxBQmtZMSRBFuIyVL9uDFSAHMvJLjqTC4vPHXWWPsOk9qIRcW3bIUrevMlHigZ4q4O0edwD3SkVa9XU+0CBBlldQ5J1fVLAUyEDSMayCXtLgqx1CN7vTu46TkPk1KOsdPAVjweq6uc+/Q0YxM0L+W1OvRs+0vse5tjqOfBLCOI2kPlN95BkQAvxCuk/Bh1giy9wZwkGgc3+7PP9se1m8pIeMFw8aMBXQLn1SupgPbR/vVK1AXztkvMU0xkNdny2eNxH6Z98kg5Wp5VhiHi9BCMlOT5ux9QqoMsNQSbfU+qR0F9w4Mn4agbL3jJKXRWqG9ae0iHsXwwStYMLuA78PIe+C3UpxPcDS0VAzkTPf0vtJnnCsP8o7hRmbE9tCMGNPIKFLj5fPrZ7G9Kne4RkSgn6pIStUMS2hb9NdrpZxT1p3D0S9JDudCXGIGpOj9EnowJ0m5BafY9raoqfw2TFTFY1dLt13sW9oU5HQHB4b0Z3plhch3OpOisStHviGCSiXIEif1Fca7L7pCYDR3Ixc2KGi/q2BAVIYFf2N5rXn5wVXQkGdJ2i4Ui5JVHy7Dkg3r2gNyMnF2Yyoj1XAIbF3OUnHx2wrMRV/LOJepcgdHAqHlhVCiVD3QgcTqtdFF19gEGi89UzG+1jVg91RYDXCX+Ccjmh7/EyP6bsqnEf6BOqwnNTSynkgzOHWdrI4CJz2RHYHYTo0m3X6mz66gpXv0VvRtnT0P5VWf+YIb1Apg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(376002)(366004)(39860400002)(38100700002)(41300700001)(107886003)(6486002)(36756003)(2616005)(122000001)(8936002)(26005)(2906002)(6512007)(478600001)(110136005)(86362001)(5660300002)(4326008)(8676002)(66556008)(316002)(38070700005)(83380400001)(54906003)(66446008)(76116006)(66946007)(82960400001)(6506007)(66476007)(71200400001)(64756008)(91956017)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVY1ZjM2cXpiUU5pdmlLK2FZUUtkejI3dVBWU0ZYZGpqaThMbE11WDlFWlpq?=
 =?utf-8?B?TFMydUl0bFRtNENsTTh6ZXlrUmZvTUNkeFFDNUFaOUs4VUg4b0k2a3BobXhP?=
 =?utf-8?B?RmlkWWJUSzRtZm8vejRUOVNiK2Z3Y20yMnMrTTRvNUxPVEo3OWRnNlhxVzhX?=
 =?utf-8?B?SGJPWXQ4OHQzOEVnSzRaaHN2Y29TZFJTYjR2ZHdJbE1EbUZNTE5TMEVTcm1U?=
 =?utf-8?B?N2M1Z0sxcWNMMWFYRWFNS0toQnBIdXdFRkJkczJuL0hzUVk1bnZCeFB5d1lJ?=
 =?utf-8?B?a25DdVNYSndxWk81UzAySGNuNFIvYy9hMVZCQi9MSG1OdlczUlJ2MXZZaWN2?=
 =?utf-8?B?NnpybE4wSTV6QXd6dWxGaXhOUWxCZDkzS1d5aG5ycFVmYlJuTGR3OGlqQmU4?=
 =?utf-8?B?b1BGaXVsLzFUVUxCNXRqaTlyRGpuRUdUTmsvZkd2OWZNZGwvWVNSZ2NxUGxY?=
 =?utf-8?B?R3FpMFhmTWZleEIrazdJSkVneUhkNGJhbnZGVy9SZFZsV1U3MWU2bHVoTzJB?=
 =?utf-8?B?bGI5UW9adXlrWTFhQU5MYmhYTEUxNXpNMmQzNzZRMnNRMlYxV1NYcUdDdUtp?=
 =?utf-8?B?NGJ0L04yZmgrUlBKQ1BQb2RaTm5PV1JLSHRWOW1lNXlLbUpTQUtKbll5WWk1?=
 =?utf-8?B?YWZrb0VqcU9zMHlDeDZrTnJseXkzaWx5OFdnU0thNjk2VytIL296cCttYW9o?=
 =?utf-8?B?NTcvajc4OWYrc1dvQnR6dDN0L1hzc3B4QTI2cnBYZ0tnTTlWYnFNR2xuQmMw?=
 =?utf-8?B?Y3FieGNLOUZBVWs5VEp5QThkQ1VCOWNrVlNVYXpJU21XYWVoTC9IUnd0N2xr?=
 =?utf-8?B?K1g4eUJvYTIwVktsWVg5Zkt3THFWc1BjbVRXTENqMVZmUmpHQWx5NG1XeUlU?=
 =?utf-8?B?SWhMTGxlL1RiZmgyVmxWYm5BSEFVVkRCRHJKeERPQnNOeGM4L1RDNmcvekdq?=
 =?utf-8?B?Vi9YUG90MHZDeUd0emVRN29SR1ZyY2RodFdLQ0huelU4Z1hNV3FrbThEQXBC?=
 =?utf-8?B?cCtCVGptUWlwdGV0bm42V3p6UUlDS1Rwa2VsMWFnT3BiSE5lMWlTclg3dmsx?=
 =?utf-8?B?Y2NMbmtTWGVBY0Z1dWlDd2hCU2FvdmIrajAzRFVKZ0UrcTlwcHJyWkJob0pn?=
 =?utf-8?B?bUVacjdaR0hHdnBjRjZVUTZFSHFLS05maWUzSm0zbFdycS9aWEhIMjFrclB2?=
 =?utf-8?B?UlVIbEFXR2NqUFcvanU3L2FVQ3Fvck04aEppUUhHRk5yT3dwREp0VHNTZnhk?=
 =?utf-8?B?MmJiVDlZMmhVUk9sUHpqSCtZeENhVjk0YWRkdVhGM2ZhWUdvY0JTYVAwYnFM?=
 =?utf-8?B?eW52SDdyR0IzQlpkeE5Ca1E4dXdMbWYwZyswUFlld29HWktja3dmd2ZVMHJh?=
 =?utf-8?B?Y0xiVC85UTVoaFNhMFVnNGc4MjR2aXAzeU5BemtleUpKSWJ0a3JwVCthbDJF?=
 =?utf-8?B?UkNTZW9IZkIydUE2VGlDYlhBV1YwYkFRMWMzWDFJQ1JUYU9NSXUrcTZHT1ht?=
 =?utf-8?B?VjMvYjF3ZUJnUGlUTlNZNWJCUnd0d1hqa1AxR1A4NnNDbkgrNUsvcHRQVi9M?=
 =?utf-8?B?MFM4NGtia1NJaUxqaGFVNmgwYWFrVDF3S25kN3lDOFhTZU1xQ2g2b1prMUlM?=
 =?utf-8?B?R2RSRnhFYUNmZGtudnBxS2tzVXBsQ216dkxVYmJ6VnVpMnI0am1xV3dqYS95?=
 =?utf-8?B?RWdYNTI2ZVVYaXV6akUwL3UvT1pPTW11dnlPK09GU0tvcEhrWnV1RXg1d1Bh?=
 =?utf-8?B?ZThEVWJqNnJ1MENXdWx6TE5Cd1FBa1F1WWc2SWFYcWRBTVJBanFTdC9HcjJZ?=
 =?utf-8?B?QUxHQnFaUlUwa01Uc2hEUDkxL1c0ckVzcitzTk9aU2oxNGNQNzB3ZmRUN0NR?=
 =?utf-8?B?OU5tYlZYcWdMdlAxZmZ3VFA2QStXV1lRdmM2dW9ZQWR5eHNEN0J6dXl4UlpT?=
 =?utf-8?B?Q1lZSm14QkV4M0p4VGJIbkt0eVBIV0srbXRnRWp2L1ZPTWZQRUo0aDR2TDc3?=
 =?utf-8?B?RVpoTFpMTEYvWVU3a0FJWnJ2WDFWZ2RZUm9RelZybmZ1a2pzR04rMzN3enNF?=
 =?utf-8?B?UEZHRUUzQXJuS1J2NDc3MThLcENVRElxZyt4dmw4RDAwQmg4bklROXpWNTNC?=
 =?utf-8?B?ZTIxU0RwRU1uaytXZG9rWVlPSUlNTU5FS3VSalBrWTZ1OVlSZmE3ZHRReXAz?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <591B84A413ED52458DC322640C05F4D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b13d836-5ade-43f8-846e-08da772d0727
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 21:54:10.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/mheoCUEZY+iTnh1HOyJks3KU95bX2M44FkOW1otzDCbUV67J+IIN/C435C/R2uf1+tna1ApdF/kPoepHmXqWSRwQFoiZS3aTSPYPCQh7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4420
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTA1IGF0IDEzOjI3IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEluIGNhc2VzIHdoZXJlIHRoZSBkZWNvZGUgZmFucyBvdXQgYXMgaXQgdHJhdmVyc2VzIGRvd25z
dHJlYW0sIHRoZQ0KPiBpbnRlcmxlYXZlIGdyYW51bGFyaXR5IG5lZWRzIHRvIGluY3JlbWVudCB0
byBpZGVudGlmeSB0aGUgcG9ydCBzZWxlY3Rvcg0KPiBiaXRzIG91dCBvZiB0aGUgcmVtYWluaW5n
IGFkZHJlc3MgYml0cy4gRm9yIGV4YW1wbGUsIHJlY2FsbCB0aGF0IHdpdGggYW4NCj4geDIgcGFy
ZW50IHBvcnQgaW50ZXJlbGVhdmUgKElXID09IDEpLCB0aGUgZG93bnN0cmVhbSBkZWNvZGUgZm9y
IGNoaWxkcmVuDQo+IG9mIHRob3NlIHBvcnRzIHdpbGwgZWl0aGVyIHNlZSBhZGRyZXNzIGJpdCBJ
Rys4IGFsd2F5cyBzZXQsIG9yIGFkZHJlc3MNCj4gYml0IElHKzggYWx3YXlzIGNsZWFyLiBTbyBp
ZiB0aGUgY2hpbGQgcG9ydCBuZWVkcyB0byBzZWxlY3QgYSBkb3duc3RyZWFtDQo+IHBvcnQgaXQg
Y2FuIG9ubHkgdXNlIGFkZHJlc3MgYml0cyBzdGFydGluZyBhdCBJRys5ICh3aGVyZSBJRyBhbmQg
SVcgYXJlDQo+IHRoZSBDWEwgZW5jb2RlZCB2YWx1ZXMgZm9yIGludGVybGVhdmUgZ3JhbnVsYXJp
dHkgKGlsb2cyKGlnKSAtIDgpIGFuZA0KPiB3YXlzIChpbG9nMihpdykpKS4NCj4gDQo+IFdoZW4g
dGhlIHBhcmVudCBwb3J0IGludGVybGVhdmUgaXMgeDEgbm8gc3VjaCBtYXNraW5nIG9jY3VycyBh
bmQgdGhlDQo+IGNoaWxkIHBvcnQgY2FuIG1haW50YWluIHRoZSBncmFudWxhcml0eSB0aGF0IHdh
cyByb3V0ZWQgdG8gdGhlIHBhcmVudA0KPiBwb3J0Lg0KPiANCj4gUmVwb3J0ZWQtYnk6IEpvbmF0
aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRy
aXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgfMKgwqDCoCA2ICsrKysrLQ0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KTWFrZXMgc2Vuc2UgdG8gbWUs
DQoNClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4N
Cg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgYi9kcml2ZXJz
L2N4bC9jb3JlL3JlZ2lvbi5jDQo+IGluZGV4IGU3MTA3N2JlYjAyMS4uNjQxYmM2MzQ0YTRhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+ICsrKyBiL2RyaXZlcnMv
Y3hsL2NvcmUvcmVnaW9uLmMNCj4gQEAgLTEwMjUsNyArMTAyNSwxMSBAQCBzdGF0aWMgaW50IGN4
bF9wb3J0X3NldHVwX3RhcmdldHMoc3RydWN0IGN4bF9wb3J0ICpwb3J0LA0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYzsNCj4gwqDCoMKgwqDCoMKgwqDCoH0NCj4g
wqANCj4gLcKgwqDCoMKgwqDCoMKgaWYgKGN4bF9yci0+bnJfdGFyZ2V0cyA+IDEpIHsNCj4gK8Kg
wqDCoMKgwqDCoMKgLyoNCj4gK8KgwqDCoMKgwqDCoMKgICogSWYgQHBhcmVudF9wb3J0IGlzIG1h
c2tpbmcgYWRkcmVzcyBiaXRzLCBwaWNrIHRoZSBuZXh0IHVudXNlZCBhZGRyZXNzDQo+ICvCoMKg
wqDCoMKgwqDCoCAqIGJpdCB0byByb3V0ZSBAcG9ydCdzIHRhcmdldHMuDQo+ICvCoMKgwqDCoMKg
wqDCoCAqLw0KPiArwqDCoMKgwqDCoMKgwqBpZiAocGFyZW50X2l3ID4gMSAmJiBjeGxfcnItPm5y
X3RhcmdldHMgPiAxKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdTMyIGFk
ZHJlc3NfYml0ID0gbWF4KHBlaWcgKyBwZWl3LCBlaXcgKyBwZWlnKTsNCj4gwqANCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlaWcgPSBhZGRyZXNzX2JpdCAtIGVpdyArIDE7DQo+
IA0KDQo=
