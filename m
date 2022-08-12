Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A550C00140
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 20:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiHLUE5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiHLUE4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 Aug 2022 16:04:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C2913D41
        for <linux-cxl@vger.kernel.org>; Fri, 12 Aug 2022 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660334695; x=1691870695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MirVw6ayjVMv/T33dbIj+6IbTUoFmTuZTWku8ULBII4=;
  b=KPhATFo64KZdz2HReLavVxdEnEyRPGKGp+IhyuS08ssRK7Vx0jyOf2+A
   tHu22zM6lJdD6yS3zwcGbXuUyIhiusIjRP7PVR8GSz+w9W9muse+A5ovn
   rMKPGrb8KuLG1bI8Ed28w2uChkna2RfRB2lfFlowc154rhEIlGyLsTo9v
   m4DZ/31FG4lj0BH5Ywd00FFAs71ysspu+H5AgijyRS5AV14p5pUYwoQKp
   h9B+hDyAeaTsUqIa9YfwrOHLRzq8sDFnPKuMpQNP8MtcD6Vu/xYSWaGp7
   +HPxTlKVLNOrBN5lUww3a8zYrqNP9LaZ0lzsn2WakNSQISoMTsVvjiJXM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353420780"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="353420780"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 13:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="674206499"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 12 Aug 2022 13:04:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 13:04:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 13:04:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 13:04:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 12 Aug 2022 13:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS8ickz9rdz4xHli+y04Sr3lF9Y1Yscgh1LBWLSOde0v9lUxj1+UF9VCcxCphQdDk8SItT3edFOF/t6Db8aH1qfZKwrkIFIakwZ2xU0pGTQqXfMCly+l0PfXh3dgWIHvoCLgsEaJXftbDu+67UdkWXsjqzIJR4LbBgwccFh3VDcJ/6GDVOs/J598nibMXtEsMHNMg0tzLbIbBynQbhtc/FZzZu7WbSQM7JRHAgCf5OogYUyzh5mp6HOJqJowdDgM9bd6RUuAR2xbCXmulNSgGs/Sfn4EnJOk0L5UOQGWbe26xazs3thw1bKmrGTNHqo1fyaae4ax3Dy10Flx8VTAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MirVw6ayjVMv/T33dbIj+6IbTUoFmTuZTWku8ULBII4=;
 b=LKJdMlwSbEB/2bdCIQJDsSheoXtHusrDgDewVQ2nONzgWBPgFYshaJChnK7EdBInsU90H9TrKj1bj3WLS/9zScX7Sm8HsZFEGWRjMT7igemr9JaFpSxh9k7V+nEQ0lwUKq1dAaX7ZXmcoacOxSnhZi+XI4HIlqSUh38P+89pUoIj1DobWlnVqguHvST9/1SFKEhuXBBM3ZtrQcZ0wJj1GRVA1LrzHDKHg/MgHngveKCrHvTwxWFbuQ4XZhKsbg9BxcziQfiSHyjx6Lzm7IbO3f+kUR/CTbi/K1wjjKaKjgB1xI1y6QEV3krSUy6vu1QR2WT/PGOCyFaxWOeqs3qsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by PH7PR11MB6747.namprd11.prod.outlook.com (2603:10b6:510:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 20:04:49 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1c88:c1bd:6295:cba4%7]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 20:04:49 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [ndctl PATCH v4] cxl: Add list verbose option to the cxl command
Thread-Topic: [ndctl PATCH v4] cxl: Add list verbose option to the cxl command
Thread-Index: AQHYrncttk35MtKDpEKTbIHFMVF/Xa2rsJ0A
Date:   Fri, 12 Aug 2022 20:04:49 +0000
Message-ID: <5454fd62ff977826d8f741377c942731e861f626.camel@intel.com>
References: <20220812181224.89722-1-sunfishho12@gmail.com>
In-Reply-To: <20220812181224.89722-1-sunfishho12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ab9b867-96f0-4c28-acf3-08da7c9de956
x-ms-traffictypediagnostic: PH7PR11MB6747:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 870/MM5emX5w/W153/+6C+2WFI47y/i/FP4HDhxZLkPdWMHScFtE5PWzcEkVkUchl1IqpHjiIRxum+6vSXHdcXOKI4xGlGT6Xk2rQsT7XNKMVUuuGohgpFZbiP+ToPUBiy1fxT9kvAPr0NX55h3D6lOoVGkS9LqC8f1fUBIqK8VUDyF3ivelI/Myucv/P2Tzg/vnILe10eWS/iWvEW6mtEkpX7fmFs32EYIklp+y9aEULUSJQ4k7lhcCPpGcoh0LoellJayC7KsIw+GeCqxlaOy9f30TcGIkyEyx5NYZPyeHpLY0ypItxMfCxT2ggyYedtxsxA2Z9wG8nkrPgGlQZvdPtpbIvwBQoRbCdPbAtVhef3XhvWG831qYChBMbhzqeDmVjVo69karJw9NEDuHeXeIlu+WeumjNqe44cgf4CCXVubEEuLdOsyX1+TAb5RfpgINQBVIafUN+KdqoslE5eq6LLhi2O5d/Ay6MgQdZ1cEfy8ZjMufIK/KmDv+qLQ9Xv0/lyMepxu/btwBV+ItRcxY+4Rujhu2x4H6hVpwfVYNXsFr/MY+zGulhK25Eko3j9tXHkRI1uD6uKWfeg2BH4z8uOjqupb72AcN8StiMO95bunpuYee95rtJITtBwe3Cughc9liSKS12diKe24YQGKCaXm/zoKy3IahyegReuy+K+lUflI/PnFXi+bOHTduTcBjFgvl/LgDlBrfwaYTGPMyo3c7nDUsv/ixQfThQ0l8t0O1Zi1O2fEh032rLb0zUNgEQr0SzNmviQzO2hKFONQW3nq+fX7hXU08of7W547YA54oCj/3E/UcZq5OtmgRBA1ej6uR7s32EqGAG1qN/VI4WZ1AGGAiv6ZZLuvIlVG8qmd2KO+yGsSIgodIjm+0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(376002)(346002)(366004)(26005)(2616005)(6512007)(6506007)(41300700001)(186003)(8676002)(91956017)(66476007)(66556008)(66946007)(76116006)(4326008)(66446008)(64756008)(2906002)(8936002)(5660300002)(478600001)(6486002)(966005)(54906003)(71200400001)(110136005)(83380400001)(316002)(38070700005)(36756003)(82960400001)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVp0NFRVR05La2ZiVDF3dCtGYityOHpnMFUyUzJQNjFPcVJCb3pKOVV5ZW5S?=
 =?utf-8?B?NXJjbFJocTRrdU5RTzgwRHp0ZmUwLzJsa0Y0K3YvTXRrRjNtNzBYNmh2bWxH?=
 =?utf-8?B?c1FLUE0xcFVLUitsZVVxcXZLcUFaTko3MHRUT1o1NEJ6UjFLeFFITE5nZTRW?=
 =?utf-8?B?b1VHcHN2SUR0Z0xGMHNzWkRDL2Z3akRNaTVNQXB1eisvTFY4S3k4SDEwbklM?=
 =?utf-8?B?SExLSkpsYjY2NVFyRjNZOTZkRXdwMEljMzhQdlZDckR6QXVTdWFydURlTHAv?=
 =?utf-8?B?Y1kwWHpCRDBiQnlHZm5BQkxqWVMwU2syelpLL0V4QTI0THFjOTJRQmxDNjh6?=
 =?utf-8?B?RWRsWm5RMXpPT3hVVURncXlrZXRpNVp6K1IxTjNGYnNrRFZNRHV1dXIvOEhi?=
 =?utf-8?B?RTNjQkdsNmF6Z3JQY2ZKdExUWmR2VWlmV0ZkTzM1T09ubDUyNjEvNEd4TldE?=
 =?utf-8?B?T1c3Mk9oZ3NNaU94WnFHbjZTY1Z2elJrdjlDTHppL3dtNmhxSzlzL1Jsc0Z0?=
 =?utf-8?B?azNZMkJJK0NzNGx0RTBSYTJCYjYxZmxLNGxrTUtjRHByUDJ4WGppdFZJM1A3?=
 =?utf-8?B?R0J6TjIwaDZQNlVqU1NNTEFPaVQxVnB4RTJ0bTgydmdaalBVUC8rRlhqZ1lx?=
 =?utf-8?B?dlN0WEVDN0lXM3Rxdnk4U2RLNkVRdm02UVh6QWhUd1RYTndXMGliWjRBVkQ0?=
 =?utf-8?B?d3hwNVV5MGRHOWpaY3lHaENWTXljS1FiZVhpbVd4WmNkSkJGbDhqenRoenlx?=
 =?utf-8?B?dVUwampVdCtRalZaN3NOaktuY1ErRmdJSU5Rb2VmclNrbjV4eG5lVnU1QTV3?=
 =?utf-8?B?UW52U0pCbFBoNy8xZE0rQStBcWx4NlNIaW5iRWVYZk9pK3JqVjgyTktZUEFT?=
 =?utf-8?B?RGh6bjduRnErdFpBUExZSWRnY2RqdTAzTGlWclFtMllDWlU1UkpTRWowaGVk?=
 =?utf-8?B?R29xL0ZQcnVyT1R6bVdsWDA3ZkR0aGtKS3JhdlNUWlZUZ1hscjJKTzdPU3J5?=
 =?utf-8?B?VEJMOTBmRSt4L1pENUdkNmU0aHIxbmg2OVo0S053R3RhdERHVnVOYWwzb0Iw?=
 =?utf-8?B?QlM0aGVQdjBIUUdwQmZvRWxqYVh5c1NodHZ3NVNtaGZKNFJFWUFidnFlVWZ3?=
 =?utf-8?B?UXVPNUNwbHpKRWFUakpYYUR3R2FVUHFUbGQwME45WmFYVkFPenk1SFdyT2R0?=
 =?utf-8?B?UTJPQmI5b0szdFVvTHdIcjlaN1U1UVFlVTFSNWJxRUxLdktEVkMwZGFlTUZ6?=
 =?utf-8?B?UzhQMCsyZ3NiNjZiMXI4a2c0ZmRQMzlUUzhrQjFBekFUNk5JWDEwZTNCUnJz?=
 =?utf-8?B?WFRqSUJBL3poWTZZcnROdDEwdzhvY01TcWdCaHR3UzNVQnR1THJFamNQMzMw?=
 =?utf-8?B?d0p2Mk9VME5JUEtLMU1hQ3dvVk9TeGJnVEcvQ05PdythRWY4eEFnSGg3R0N5?=
 =?utf-8?B?ZTFQc2hCcnY1S0FZNmptaWVLSXRUN3dPOUtNQXZremJLYlZDR0RvaFRvaFJh?=
 =?utf-8?B?blhuemhyY0lkK2Y0WENwVkZWNGNiNlRubjM1T2pDYkJYaHVqRXRCcERnWHhU?=
 =?utf-8?B?SitCamhXQmMvWUFnVjhTb0xnK0JDdWNKbFNKdjR4b3dJZkhtVnc5cWREOGc0?=
 =?utf-8?B?bERXT1lTYTQzR3lTTm52Y0VObmprZGxnWFJ4N2FVYXBaWDJzRWF2MlFOd1ZT?=
 =?utf-8?B?dlNUdlNWTDhRUm5tam1sazJiRThnVE92TXp1M0ZITWZaVWRiNlA4UE1GT0tn?=
 =?utf-8?B?RUxzbjFEQjY5eDkwcmJIajB5UUFxeXlXa0dsZDJKQlBiNUxidUp5c0czTDhk?=
 =?utf-8?B?NlpPbWN5WWdrQXN0M3JuZ1BWNnVNNEwyckxIdUpZd1NXUERyNXNFZ3NkZVU5?=
 =?utf-8?B?WnI5WUlvR0N3OHdCU0NDUEcwREdrS0xBRVRaRG1paFdPeEJBZ2xhYWs2ZWN3?=
 =?utf-8?B?ejZjWlozWUJxdDE3SlVOU205d0hWMEhPYmxTU3hmN3NQdWVOT3dPQ2lONVI1?=
 =?utf-8?B?bW4reGo5cXgzbUxnc0h3R0VTcXgvWDB6RDliMUMzSUhRSnJOY1BSN1Q5aDRM?=
 =?utf-8?B?N0tNemo2cU43M05OWXcrWXluQWJwbzFWbXNoMVZYQTVKa2FpRlkySnlmanVi?=
 =?utf-8?B?ZkhjeEFJRlRjNk9sM05NMHhGdzZYSVZQZ1hnSGRlMUU3L1FoMG1sSTQzK1Ni?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA02FD54B1B9664ABCFCA4266D95213B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab9b867-96f0-4c28-acf3-08da7c9de956
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 20:04:49.2359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S2fYWAC3dYPHe2cu+fr2C4rOKIvOGblohckPDorX1lz9XIX3ryXGDlWWQksW7a6bl+rNSFhRnLGSGMIPOjJze3HK2Ng1AhjePsZZm4IHC/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6747
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTEyIGF0IDExOjEyIC0wNzAwLCBzdW5maXNoaG8xMkBnbWFpbC5jb20g
d3JvdGU6Cj4gRnJvbTogTWF0dGhldyBIbyA8c3VuZmlzaGhvMTJAZ21haWwuY29tPgo+IAo+IFRo
aXMgYWRkcyB0aGUgbmV3IHN1YmNvbW1hbmRzIGN4bCBsaXN0IC12LCBjeGwgbGlzdCAtdnYsIGFu
ZCBjeGwgbGlzdCAtdnZ2Lgo+IAo+IGN4bCBsaXN0IC12IGlzIG5vdyBlcXVpdmFsZW50IHRvIGN4
bCBsaXN0IC1STUJEUFQsIGN4bCBsaXN0IC12diBpcwo+IGVxdWl2YWxlbnQgdG8gY3hsIGxpc3Qg
LVJNQkRQVGksIGFuZCBjeGwgbGlzdCAtdnZ2IGlzIGVxdWl2YWxlbnQgdG8KPiBjeGwgbGlzdCAt
Uk1CRFBUaUhJLiBUaGVzZSBhZGRpdGlvbnMgbWFrZSBpdCBlYXNpZXIgdG8gbGlzdCBhbGwgb2Yg
dGhlIENYTAo+IGRldmljZXMgd2l0aG91dCBoYXZpbmcgdG8gcmVtZW1iZXIgd2hpY2ggc3ViY29t
bWFuZCBtdXN0IGJlIGFwcGVuZGVkIGZvciBlYWNoCj4gdHlwZSBvZiBkZXZpY2UuCj4gCj4gQWNr
ZWQtYnk6IERhdmlkbG9ociBCdWVzbyA8ZGF2ZUBzdGdvbGFicy5uZXQ+Cj4gUmV2aWV3ZWQtYnk6
IEFkYW0gTWFuemFuYXJlcyA8YS5tYW56YW5hcmVzQHNhbXN1bmcuY29tPgo+IFJldmlld2VkLWJ5
OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBNYXR0aGV3IEhvIDxzdW5maXNoaG8xMkBnbWFpbC5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBzaW5j
ZSB2M1sxXQo+IAo+IMKgLSBGaXhlZCBmb3JtYXR0aW5nIG9mIHBhdGNoCj4gwqAtIEFtZW5kZWQg
cGF0Y2ggdG8gYXBwbHkgdG8gbGF0ZXN0IHJlZ2lvbiBkcml2ZXIgcGF0Y2hlcyBbMl0KPiDCoC0g
QWRkZWQgbWlzc2VkICJBY2tlZC1ieSIKPiAKPiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWN4bC8yMDIyMDcyMjE4MzcwNS4yNjkzNi0xLXN1bmZpc2hobzEyQGdtYWlsLmNvbS8K
PiBbMl06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWN4bC8yMDIyMDgxMDIzMDkxNC41
NDk2MTEtMS12aXNoYWwubC52ZXJtYUBpbnRlbC5jb20vCj4gCj4gTWF5YmUgdGhpcyBjb3VsZCBi
ZSBhZGRlZCB0byB0aGUgcmVnaW9uIGRyaXZlciBzZXJpZXM/CgpIaSBNYXR0aGV3LAoKVGhhbmtz
IGZvciB0aGUgdXBkYXRlLiBJIGludGVuZCB0byBwaWNrIHVwIGFsbCBwZW5kaW5nIHBhdGNoZXMg
aW4gdGhlCm5leHQgd2VlayBvciBzbyBpbiBwcmVwYXJhdGlvbiBmb3IgdGhlIHY3NCByZWxlYXNl
LCBhbmQgSSB3aWxsIGluY2x1ZGUKdGhpcy4KCk9uZSBjb21tZW50IGFuZCBzbWFsbCB0eXBvIGJl
bG93IC0gb3RoZXJ3aXNlIHRoaXMgbG9va3MgZ29vZC4KCj4gCj4gwqBEb2N1bWVudGF0aW9uL2N4
bC9jeGwtbGlzdC50eHQgfCAyMCArKysrKysrKysrKysrKysrKysrKwo+IMKgY3hsL2ZpbHRlci5o
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiDCoGN4bC9saXN0
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjEgKysrKysrKysr
KysrKysrKysrKysrCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykKPiAKPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9jeGwvY3hsLWxpc3QudHh0IGIvRG9jdW1lbnRhdGlv
bi9jeGwvY3hsLWxpc3QudHh0Cj4gaW5kZXggMjkwNmMyZjZlZjRiLi4wZTc3MjdjYTE2N2YgMTAw
NjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9jeGwvY3hsLWxpc3QudHh0Cj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9jeGwvY3hsLWxpc3QudHh0Cj4gQEAgLTMzNiw2ICszMzYsMjYgQEAgT1BUSU9OUwo+
IMKgLS1yZWdpb246Ogo+IMKgwqDCoMKgwqDCoMKgwqBTcGVjaWZ5IHRoZSByZWdpb24gbmFtZSB0
byBmaWx0ZXIgdGhlIGVtaXR0ZWQgcmVnaW9ucy4KPiAKPiArLXY6Ogo+ICstLXZlcmJvc2U6Ogo+
ICvCoMKgwqDCoMKgwqDCoEluY3JlYXNlIHZlcmJvc2l0eSBvZiB0aGUgb3V0cHV0LiBUaGlzIGNh
biBiZSBzcGVjaWZpZWQKPiArwqDCoMKgwqDCoMKgwqBtdWx0aXBsZSB0aW1lcyB0byBiZSBldmVu
IG1vcmUgdmVyYm9zZSBvbiB0aGUKPiArwqDCoMKgwqDCoMKgwqBpbmZvcm1hdGlvbmFsIGFuZCBt
aXNjZWxsYW5lb3VzIG91dHB1dCwgYW5kIGNhbiBiZSB1c2VkCj4gK8KgwqDCoMKgwqDCoMKgdG8g
b3ZlcnJpZGUgb21pdHRlZCBmbGFncyBmb3Igc2hvd2luZyBzcGVjaWZpYwo+ICvCoMKgwqDCoMKg
wqDCoGluZm9ybWF0aW9uLiBOb3RlIHRoYXQgY3hsIGxpc3QgLS12ZXJib3NlIC0tdmVyYm9zZSBp
cwo+ICvCoMKgwqDCoMKgwqDCoGVxdWl2YWxlbnQgdG8gY3hsIGxpc3QgLXZ2LCBhbmQgbGlrZXdp
c2UKPiArwqDCoMKgwqDCoMKgwqBjeGwgbGlzdCAtLXZlcmJvc2UgLS12ZXJib3NlIC0tdmVyYm9z
ZSBpcyBlcXVpdmFsZW50IHRvCj4gK8KgwqDCoMKgwqDCoMKgY3hsIGxpc3QgLXZ2di4KCkknZCBz
YXkgYSBzaW5nbGUgZXhhbXBsZSwgb2YgLXZ2IGlzIHN1ZmZpY2llbnQgaGVyZS4KCj4gK8KgwqDC
oMKgwqDCoMKgLSAqLXYqCj4gK8KgwqDCoMKgwqDCoMKgwqAgRW5hYmxlIC0tbWVtZGV2cywgLS1y
ZWdpb25zLCAtLWJ1c2VzLAo+ICvCoMKgwqDCoMKgwqDCoMKgIC0tcG9ydHMsIC0tZGVjb2RlcnMs
IGFuZCAtLXRhcmdldHMuCj4gK8KgwqDCoMKgwqDCoMKgLSAqLXZ2Kgo+ICvCoMKgwqDCoMKgwqDC
oMKgIEV2ZXJ5dGhpbmcgKi12KiBwcm92aWRlcywgcGx1cyBpbmNsdWRlIGRpc2FibGVkCj4gK8Kg
wqDCoMKgwqDCoMKgwqAgZGV2aWNlcyB3aXRoIC0taWRsZS4KPiArwqDCoMKgwqDCoMKgwqAtICot
dnZ2Kgo+ICvCoMKgwqDCoMKgwqDCoMKgIEV2ZXJ5dGhpbmcgKi12dnYqIHByb3ZpZGVzLCBwbHVz
IGVuYWJsZQoKVGhlIGFib3ZlIHNob3VsZCBiZSAtdnYKCj4gK8KgwqDCoMKgwqDCoMKgwqAgLS1o
ZWFsdGggYW5kIC0tcGFydGl0aW9uLgo+ICsKPiDCoC0tZGVidWc6Ogo+IMKgwqDCoMKgwqDCoMKg
wqBJZiB0aGUgY3hsIHRvb2wgd2FzIGJ1aWx0IHdpdGggZGVidWcgZW5hYmxlZCwgdHVybiBvbiBk
ZWJ1Zwo+IMKgwqDCoMKgwqDCoMKgwqBtZXNzYWdlcy4KPiBkaWZmIC0tZ2l0IGEvY3hsL2ZpbHRl
ci5oIGIvY3hsL2ZpbHRlci5oCj4gaW5kZXggZDIyZDhiMWY3OThiLi4yNTZkZjQ5YzNkMGMgMTAw
NjQ0Cj4gLS0tIGEvY3hsL2ZpbHRlci5oCj4gKysrIGIvY3hsL2ZpbHRlci5oCj4gQEAgLTI2LDYg
KzI2LDcgQEAgc3RydWN0IGN4bF9maWx0ZXJfcGFyYW1zIHsKPiDCoMKgwqDCoMKgwqDCoMKgYm9v
bCBodW1hbjsKPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCBoZWFsdGg7Cj4gwqDCoMKgwqDCoMKgwqDC
oGJvb2wgcGFydGl0aW9uOwo+ICvCoMKgwqDCoMKgwqDCoGludCB2ZXJib3NlOwo+IMKgwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgbG9nX2N0eCBjdHg7Cj4gwqB9Owo+IAo+IGRpZmYgLS1naXQgYS9jeGwv
bGlzdC5jIGIvY3hsL2xpc3QuYwo+IGluZGV4IDVmNjA0ZWNkZGYzYy4uOGM0OGZiYmFhZWMzIDEw
MDY0NAo+IC0tLSBhL2N4bC9saXN0LmMKPiArKysgYi9jeGwvbGlzdC5jCj4gQEAgLTUyLDYgKzUy
LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvcHRpb24gb3B0aW9uc1tdID0gewo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJpbmNsdWRlIG1lbW9yeSBkZXZpY2UgaGVh
bHRoIGluZm9ybWF0aW9uIiksCj4gwqDCoMKgwqDCoMKgwqDCoE9QVF9CT09MRUFOKCdJJywgInBh
cnRpdGlvbiIsICZwYXJhbS5wYXJ0aXRpb24sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgImluY2x1ZGUgbWVtb3J5IGRldmljZSBwYXJ0aXRpb24gaW5mb3JtYXRpb24i
KSwKPiArwqDCoMKgwqDCoMKgwqBPUFRfSU5DUigndicsICJ2ZXJib3NlIiwgJnBhcmFtLnZlcmJv
c2UsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiaW5jcmVhc2Ugb3V0cHV0IGRl
dGFpbCIpLAo+IMKgI2lmZGVmIEVOQUJMRV9ERUJVRwo+IMKgwqDCoMKgwqDCoMKgwqBPUFRfQk9P
TEVBTigwLCAiZGVidWciLCAmZGVidWcsICJkZWJ1ZyBsaXN0IHdhbGsiKSwKPiDCoCNlbmRpZgo+
IEBAIC0xMDYsNiArMTA4LDI1IEBAIGludCBjbWRfbGlzdChpbnQgYXJnYywgY29uc3QgY2hhciAq
KmFyZ3YsIHN0cnVjdCBjeGxfY3R4ICpjdHgpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBwYXJhbS5tZW1kZXZzID0gdHJ1ZTsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IAo+ICvCoMKg
wqDCoMKgwqDCoHN3aXRjaChwYXJhbS52ZXJib3NlKXsKPiArwqDCoMKgwqDCoMKgwqBkZWZhdWx0
Ogo+ICvCoMKgwqDCoMKgwqDCoGNhc2UgMzoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcGFyYW0uaGVhbHRoID0gdHJ1ZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cGFyYW0ucGFydGl0aW9uID0gdHJ1ZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LyogZmFsbHRocm91Z2ggKi8KPiArwqDCoMKgwqDCoMKgwqBjYXNlIDI6Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHBhcmFtLmlkbGUgPSB0cnVlOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAvKiBmYWxsdGhyb3VnaCAqLwo+ICvCoMKgwqDCoMKgwqDCoGNhc2UgMToK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFyYW0uYnVzZXMgPSB0cnVlOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYXJhbS5wb3J0cyA9IHRydWU7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhcmFtLmRlY29kZXJzID0gdHJ1ZTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFyYW0udGFyZ2V0cyA9IHRydWU7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qZmFsbHRocm91Z2gqLwo+ICvCoMKgwqDCoMKgwqDCoGNh
c2UgMDoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gK8KgwqDCoMKg
wqDCoMKgfQo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgbG9nX2luaXQoJnBhcmFtLmN0eCwgImN4bCBs
aXN0IiwgIkNYTF9MSVNUX0xPRyIpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoZGVidWcpIHsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGN4bF9zZXRfbG9nX3ByaW9yaXR5KGN0eCwg
TE9HX0RFQlVHKTsKPiAtLQo+IDIuMzQuMQo+IAoK
