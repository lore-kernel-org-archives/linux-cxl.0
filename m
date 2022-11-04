Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E81C4321E
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 05:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKDF54 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Nov 2022 01:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiKDF5r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Nov 2022 01:57:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A951CB32
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 22:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667541463; x=1699077463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=saSlNrGZHiy0gsBkdU6a508swCrN4tzkN0ZmJTOwu7w=;
  b=dW7AWTTDfHMcVNmlmR9/Cvg1BQEwsojS5iEc9kE4iofrHWfBdHn0cSHR
   rpaW5aFu2lZ3nAwf/EWzBu8gNRok3WH9ZWYUEFFZhm5YvDjVoAfOJrfa4
   r9Ny8oLj0k6yma4rK6/RSrGgDy61At24Utl2wxi2veh2CT+KZZ+RiAFeu
   xoltXthvZJNWZHUw5Q6/mvz8maIiITywctTZWj9Xvsk7SHuim5YXNsD8m
   bWPfCGJzRmHoAPdYizM3ezBTy/n9GUlIOATD/9LVs0iCfAIAEhLqRIfye
   jiayhmLJqdbVTZ0/Oa6P62fwNTxMVmApl1alxQpZDneGSrWm36E/mvPm3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290276732"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="290276732"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 22:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="740502207"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="740502207"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2022 22:57:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 22:57:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 22:57:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 22:57:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 22:57:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbGMbJBcXfIFqV+XgQzREMrjvnckUPj6+mlgr4hlEuJeY74HuxxNOcnhieoMPIiZKnALdBfUA3Wsjieip+y5DsdA+N0d8nCeWF+uJNrXCoULtagA9zON1kgmlEePbCvQYA2l98+h+8ugZD0qdtYYfWeZ+Cnf5iL0NP93kMZ2RuqgsOPNsV9O3zywLIRHpU90ASF7meGMS5JpLgexcX2yhItTwnK/Rb1wJz1vhD++GKWrM3njYMZhgRHiCEwoflEDnlJ7P7eRh5DccffZez6OgxG6yrP7rZXvGpc2d059iXfh7MW/PoE9mKvnf/n4qBedIHqk2S4VAkaozvH7QG1x3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saSlNrGZHiy0gsBkdU6a508swCrN4tzkN0ZmJTOwu7w=;
 b=Fj+wNiHQlzspjzasPQPXJuE+5M+QUKf02zQFEIkkkzrSang4yefT8bXOq7nLL9RsHT4l80SY5DH8rqTar4HoQwT59/Cnp0X98hZ2uti0ZncLLr6PDMGIazYr3mlq+DJGAqik0B1URZz9A65vesd9Eust2FFHaoh3CPIgUrJ8Ha13y8wLNnrD41b/AZPIA3K01lwBB+d8KXuaptNFKlaEx7LZR8e1AW5fksiKHua6+5RpU6ePBSCXfZRMls52FGhcBQVw4+fSTWN4CNAsppvKZxc2ifuq3w03AaDTAsVJezPzVgJGQywwVLmhN3ITHTcZPPD91cEZZHsCI3Z6O2EM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Fri, 4 Nov
 2022 05:57:24 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 05:57:24 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Schofield, Alison" <alison.schofield@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 4/7] tools/testing/cxl: Fix some error exits
Thread-Topic: [PATCH 4/7] tools/testing/cxl: Fix some error exits
Thread-Index: AQHY7+Sz7oOUb5RNlkydWavEGW9TUq4uRNSA
Date:   Fri, 4 Nov 2022 05:57:24 +0000
Message-ID: <4793e5e64652e50c52a62a37699e2e9b1421c65e.camel@intel.com>
References: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
         <166752184255.947915.16163477849330181425.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166752184255.947915.16163477849330181425.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|MN0PR11MB6229:EE_
x-ms-office365-filtering-correlation-id: 4f8d0a6d-5c22-4f9e-d65c-08dabe297203
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S04Jn9SSgG3bl5m8XRb8oOa/69WdclAMJqjOFG6eH/TyKb0irm/VfquX04IQTy6C7hFmvsfPOVElJO99zBXE36Jl5PFOxmqcRwj5ZVn9s7PrguxKuEq7UeV8Mt6ZvtVPfudsnaNIFyujVEF+pzEHGynOAbZ7Cyzd6npGIFBZjiKFdagpOlqmD+KDKCP6dU+Q/Tc7/FUSC6NAdiFmTSQddirjmlZ8IVdXw/p/efcd4/Kw+5lqPEw37B4c9tYtMjrulsSQgFmkAxNgpgmCQbC8pVtGUhYjDb+PSTT2fqU99vG7/kTG0NG0KF/ImPJkPn1oq/+iP6UnGnoohoclHHcKQBSMb+Vp7S8yv2fmNIOJA6uThgoK+3FOKbG4sOwljdP/YV8m/+8t0uriYNM8btCUshi1UVWaWSr6cY4m980DCHIIFC+rRWc3oHZu8yqF3LWaYDcqHb15qhh9WEZHCPO6SA7pbZIDBq8QUPJ58DE1WjLZ+t4mszjbN8x4ah2uYYINSyhOsfF8L3jFjfGB/aaMsI+v8DnNzjIyU3kQTUlaLP7eM8WCWRquFqVj7wzeaEVvAcSG8t2Tit3IKrwy4HUodn9utTZXjw8Njv1JpdGF4ATcceovSxP8OpLoEAH59r1QYEbc5on6HOHhma9Y7yY2DPAa1WP1IERwqj9HVx88jgA9/iatrWawWFF8FOL1wiXWFPKlcXGsDU2OTPuXLmkFeFWyKyK1OCsf4nSJUJ0Z8acCJc54PebXubEtUvk89uxW8vd0/zRTmTUMLebIgNoRMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(186003)(83380400001)(110136005)(107886003)(86362001)(5660300002)(2616005)(6506007)(4326008)(4744005)(41300700001)(54906003)(6512007)(76116006)(36756003)(66476007)(66946007)(8676002)(91956017)(66446008)(26005)(64756008)(8936002)(2906002)(316002)(38100700002)(66556008)(122000001)(478600001)(6486002)(38070700005)(82960400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkJmL0R4dy93RmpUWFFsWFY4cElTZzhZTGVnajU5T2prMmJVMGVqY2xlbHFX?=
 =?utf-8?B?OFM4NE5PMncxMWpVV3VMMG8vSVBjT1FmOHBVZDNQUWgrMmFKV2U1cXdsZDRM?=
 =?utf-8?B?RWlNR2JVTzQvQ3c2T2Q3K3Y4WVhvbjFUT0xrVkEyelMyOFhRTmVRMVozOSts?=
 =?utf-8?B?SHRVSEFPR3Y2Q0NxWmREcXJoRU91NnpLSTExNWJtWElRWWp5alBqdU9TczFz?=
 =?utf-8?B?K2MrOThYTXA2SlNTclBtUWIwYmVWLzBNcFI0aElHYjdqYWFXVnFjWk9KOEgr?=
 =?utf-8?B?aUxORWl5Nm9DbVYvS2xoOGo0SWtSTEFwOHpRMytwblRrQTUrR2dHaDI0TnBZ?=
 =?utf-8?B?cTBTSGtabWFZWUs1bzNkakkyUTdlczJkRm9mRVJvSDRlSUM3WkErZFpaRXRR?=
 =?utf-8?B?eEU2Wm9EMlNqamdWS1lBbXltL3RWUU85NTduTDdkTzR1a256STNYVHMvUHdM?=
 =?utf-8?B?dFVEdVZkaXFaUnRNVGFuRmNmNHluTHUyaHZaTFAwNjk3by9mUVU4NTQyVy83?=
 =?utf-8?B?K0diNERtWW9VbjYzSTdnMkhOQVJuK3VHZVpDRzRSVXdYMkFFMjZ5TFdQS1dm?=
 =?utf-8?B?dFVWMGc3MHpBOSs2ZFBxREZrVHRjcVU5cVZEY1UyMlBtUTFvNkJhYlcwSlRj?=
 =?utf-8?B?Q2hFQmRUMUVFSTZvNUlUK2VNOVEzUUNiL241OGpYNlFEMXRnQTZYMUFiTDhF?=
 =?utf-8?B?K3VmVmFUOHhDUUl5NkErR2MvMEU0Y0htWWIvbDJjZkMzNGZUTXZRbU9JY1h4?=
 =?utf-8?B?V2Q3TkNJUFlodElDbjEyZ2ZVWHM4VUV5SDg2clkvTGlCVEViUDdGN0VCK3c0?=
 =?utf-8?B?SEhRcExTMVVjTFIydU9JNGJaeWxjMTVVbDg3YVlpcGJuZjFhNzZCRkU5bHlo?=
 =?utf-8?B?T05BWFQ3NHUzZmRqQnlSS0FQL2h5QXk3TjdHM015dmhnUXJaTzVwL1lZZStt?=
 =?utf-8?B?Z3BzQmc3ZEVMRWZiT3BxME8ra0RrVWcrQzduTklUcVBOLzU0VVpyTWxlLzEr?=
 =?utf-8?B?L0tkTmJJSi9WVWVNc0xZMW9oNExWdUFoTzJNQmNpYVFSODBwUDl2NUs5ZmJt?=
 =?utf-8?B?MlBreXU3ZHIwWDFaM3FKS0NTMFFSUjYvck1JQ0pUeDBuMmZqelhkbUVLSTZP?=
 =?utf-8?B?cnhseXNMMldURDNXVDkyY0U2THV3UkJyaHZ6bTNRR2JoaFNFb2pVNVpMY3hy?=
 =?utf-8?B?Y2lCUGF4Lzd0NEM2UmU2TjYzOHI2YzZyNXNScTVhQ29qY2xzeGVWSEpISXZK?=
 =?utf-8?B?aDc5RDdEVG0xUkRVVGJpRVpPQ3dMdlRuRlBZTXA4Zkhjc1ZvSmRxT3A1TTVH?=
 =?utf-8?B?YlovWnBPS2dYbTRuRmRGbi9JaHlqT1JtSXVrQnlhWEJEZEdTNlMyQWs1SW1O?=
 =?utf-8?B?RE10T3NQYzhiNFVGajl6Q1U2QkpmbStUVHFYNG5wWUVFU1RsV3hRbEROTEdP?=
 =?utf-8?B?UzVlVWk0MHRoS1FNMW9TdzJYOGFCbEpINjNMdFRTbjBwRWNOQkE1NjdKQUxQ?=
 =?utf-8?B?OXZldjRxLzZ0ajlCMGZnMWlpTmZlYkdJYkdyQ0FRdmYrc3NxaW1DUHQ4OUFz?=
 =?utf-8?B?OFYwdDJHRndjMm9iSUMwZ2pCM2dTazV2VVBjRTFQekxYOS96ZU9OR1ZVa2Fw?=
 =?utf-8?B?NFBtbGJWc1hpUjJQbTNRR2NQTnFyVWxieDBKZFhzR0p3UFpteGI0YWxQVURW?=
 =?utf-8?B?SUtpMU1kczc0ZTNHbTJtV0lXWWJTTlBwM2hVYWNONS8wbERFNC81SDY5aEh6?=
 =?utf-8?B?NGovempoWTZUVWJMKy9BVWtBNG1keTVPMm9mMWFsYVBvM2w4SEg3MklJaDdk?=
 =?utf-8?B?QmdyS3hpMUtmN2YwbEVvYlZPbEpkdmpZNUhkNEJzYmtybk9rVGZ3VUhKSVBn?=
 =?utf-8?B?dU9jbTRGckZSWm93WkNlNHRhSExoWVQ1dHphc0FNRTNPZXhlRFNPMTZjWkls?=
 =?utf-8?B?MnBsN3FsU1N6TEdnZ0U4bzU1Yis4S01tUDdRVktjc01oWHpQN1FZT3QzeDk3?=
 =?utf-8?B?ZCtIUk1vVUFyU0plaWVTU3dOTHNteCsvQjA0b21rY2RZbkduMGxIVnQ1RlVu?=
 =?utf-8?B?NzlWOW5xWFlKd1VjbmtQb0lKVlNhNkkwdWxmZTVLRzhMd05IMzh4clQxQkRX?=
 =?utf-8?B?Zzl5aUR1bHV1ZDVoN2cvaE8xdEl0UHJQNC9EcjgzeW1hUnZXMFgwQTFEWjkw?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5347E0C40126484785182746D3733954@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8d0a6d-5c22-4f9e-d65c-08dabe297203
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 05:57:24.1512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVmN+GC9Fib4hi+NuDSMyEkeWczVjSG2Y/hro5iGBv/JsL2nutfy+MNuar+DC5BZiPDwf+/s00cAdPwvnViw5c/iFJbtU9u+OSMpFjclfQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTAzIGF0IDE3OjMwIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
Rml4IGEgZmV3IHR5cG9zIHdoZXJlICdnb3RvIGVycl9wb3J0JyB3YXMgdXNlZCByYXRoZXIgdGhh
biB0aGUgb2JqZWN0Cj4gc3BlY2lmaWMgY2xlYW51cC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW4g
V2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KPiAtLS0KPiDCoHRvb2xzL3Rlc3Rp
bmcvY3hsL3Rlc3QvY3hsLmMgfMKgwqDCoCA0ICsrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpMb29rcyBnb29kLAoKUmV2aWV3ZWQtYnk6IFZp
c2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPgoKPiAKPiBkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9jeGwvdGVzdC9jeGwuYyBiL3Rvb2xzL3Rlc3RpbmcvY3hsL3Rlc3QvY3hs
LmMKPiBpbmRleCBhMDcyYjJkM2U3MjYuLjEzM2U0YzczZDM3MCAxMDA2NDQKPiAtLS0gYS90b29s
cy90ZXN0aW5nL2N4bC90ZXN0L2N4bC5jCj4gKysrIGIvdG9vbHMvdGVzdGluZy9jeGwvdGVzdC9j
eGwuYwo+IEBAIC02OTUsNyArNjk1LDcgQEAgc3RhdGljIF9faW5pdCBpbnQgY3hsX3Rlc3RfaW5p
dCh2b2lkKQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZGV2ID0gcGxh
dGZvcm1fZGV2aWNlX2FsbG9jKCJjeGxfc3dpdGNoX3Vwb3J0IiwgaSk7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIXBkZXYpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycl9wb3J0Owo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnJfdXBvcnQ7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZGV2LT5kZXYucGFyZW50ID0gJnJvb3RfcG9ydC0+ZGV2
Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IHBsYXRmb3JtX2Rl
dmljZV9hZGQocGRldik7Cj4gQEAgLTcxMyw3ICs3MTMsNyBAQCBzdGF0aWMgX19pbml0IGludCBj
eGxfdGVzdF9pbml0KHZvaWQpCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHBkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfYWxsb2MoImN4bF9zd2l0Y2hfZHBvcnQiLCBpKTsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghcGRldikKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyX3BvcnQ7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycl9kcG9ydDsK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBkZXYtPmRldi5wYXJlbnQgPSAmdXBv
cnQtPmRldjsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmMgPSBwbGF0
Zm9ybV9kZXZpY2VfYWRkKHBkZXYpOwo+IAoK
