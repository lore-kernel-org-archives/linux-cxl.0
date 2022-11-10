Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ECFC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Nov 2022 20:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKJUAd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Nov 2022 15:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJUAc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Nov 2022 15:00:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1A0B4B8
        for <linux-cxl@vger.kernel.org>; Thu, 10 Nov 2022 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668110431; x=1699646431;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=V/bwC5F7T3BURbn7m1WLjRDBiw58MBAw0SBhGO12CE4=;
  b=IhE8tVS0l33BJ2NeCUcY82xw+EyS5D4MXbpeJkrZJ/7heCRtPtvF/DOr
   8hpyUAWLev8vxKF8H4RC5+GONrRVGwKHu56RCI4G7LaEYFP3l+aohUDSs
   W3r2mY6gRqVTCJVY747oxYre9lFy4/jn+MFQWN8icp+EK68+JPWy56kko
   n03wRysPk+/dgL76QVMpfiyGDCkIeD0Ed+ZgVnSqJPNgI75fUqxie0w/s
   hFulNDrSkKRxa4YQshloWyElbn60uoDj17c/rdJ+sNW+UmzHow0aoDFp3
   nu21iHYNAgGO8Nxq3M8HC4rLQhgiSP9hJnJ6l95fumWKPHwZtfDd0Jza0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="311432246"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="311432246"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 12:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812184530"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="812184530"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 10 Nov 2022 12:00:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 12:00:27 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 12:00:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 12:00:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 12:00:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhuG+CGptUhxASsnANZXwTJTp3o4IOy1CVNbzW79KirNmeIbRSloqEgzfVscux0S26TmwpSLD7rDsdPBZlDbGY8XlpGmoAJhCgII5KNPEevyaL7nvzfC+pJJkcUUmEEFaIKjlSTR0sZ5fylJHYQ++VFTdBQIMcPQjx6HMVjdbL4dinNWIe7NNaHVLYJRHq6280vstsEJMcUut81n0RCtJFDInW343InKBGOswvNtspMFY6LQ5dXkk41GzIfVMQWvXt1NzN9EVTcGCsQue4CGe+KxTzWXVaSPEufi0b+1HzUrlXCVSmNuH6H+BkKbd7TR30hNAEr9Ajinz7wEy2z6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/bwC5F7T3BURbn7m1WLjRDBiw58MBAw0SBhGO12CE4=;
 b=ZPvvZQerrOSftonz41uZuZVptXr3jn9QzUDFURWtL6zYzg+rXD9J7s/cfsOS6vqcOyfQNFpUfJbS4q/UZyC/+bQ8xG2S622rly7+5ZOzEN9NmxeTZIzVg5Wqc8QdaYe961FHll/mQwzT3ZgDmXrOyPRyRGfVhyGPZFTG9rcj+hwjVxue3DE3cJjwI5oN3SbS18Jcaccw8w2bIvb3JpItj6n3zKSMPXdb8gibXiyr0T42IzR9RmBPY1ouPQDXPOJbFn5eQ3BMMBExQ0aI1C43boI3sTxRu8fkArMNbdgRWqj9ukmYdxSFn+J8u2PsnrhjijNvys9BxYDXQottIjh3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DS0PR11MB6327.namprd11.prod.outlook.com (2603:10b6:8:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 20:00:23 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 20:00:23 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "wzhang@meta.com" <wzhang@meta.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Zhang, Jonathan" <jonzhang@meta.com>
Subject: Re: [ndctl PATCH V4 0/2] add support for CCI Get Alert Configuration
Thread-Topic: [ndctl PATCH V4 0/2] add support for CCI Get Alert Configuration
Thread-Index: AQHY8wImkKcBxMRja0mDe66Y4RocAK44mB0A
Date:   Thu, 10 Nov 2022 20:00:23 +0000
Message-ID: <465befdeedf0cd97e4bbad814e5890f75d262461.camel@intel.com>
References: <20221107233842.3553784-1-jonzhang@meta.com>
In-Reply-To: <20221107233842.3553784-1-jonzhang@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DS0PR11MB6327:EE_
x-ms-office365-filtering-correlation-id: 0b3a7df9-2bd8-4de1-f63d-08dac3563425
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FBsrbXHl2Rmpqalq/Zj5oSNyPRHX3aCtvtJrzqk31sAsKoIrhMH2VhBqVTsRXeiJFMTGwE2aA57XqkeoDuYM9BJ8N8LFNzmSXzvp5ICuZnmu1+6WtgmU+fG/0Vpz5RD7TirozvyssqHzKnSsQxN6zyBALLws7vHsSMYPhBMLHW2ANdHRDDF5wOkH8QSOumgIsqq2iT4FW12mq+v/HRaPp2s7XiTTDDmkU+cdZR+uj7Wm/te9nsdTITYeEzH8Y2ojPr42hzF9NkBiH8OMHIV9OwlVlUvYFdm1DlPlQqDkOwrUYJUiUzzYxMRCvo0m0JYsRZgvugiOyuPCLC0s6c84sKSLCdXHwfq8TvgRu7ZXrtZIkPGqhwDo2mAp0HarMhEiZWqVnzGz82IeeQ3iOJQKv8fXOMuMuns4XcE8qcnwhn03xKxuZvMrOSUKw88mX/xknvWICKWx/JEGR4JotpjZN19wp4ZNNpoQB5jdrNvzhQayhb47UMU7yfJTB+2Vl6DLWeLNQg1hK7VbW0rWNqEhZZrcSU+8l8KOG6N/ebj/oWKC+yPDjypTqFyRow15qmx9L74jQqyqws0KBLtHRNxWuSd3dlApvyT9UW5rDk1TCOPwdSkZfRTckxeBB/GWaLtJefmNzLNn9NDsmT3n6NFmvmYNd6bEDpqRDDi1PNSxP1L4/SgIcf5b6TvIOLcStbj/SqRzr4Ahu09JP8v/7uDAe1davi6KmQKMHx/Q4lToOMu5grt1CtY7g2Mtp11hlwYM1yz5psdIFD0jiU487UAlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199015)(36756003)(91956017)(86362001)(38070700005)(316002)(38100700002)(82960400001)(122000001)(110136005)(76116006)(71200400001)(6486002)(2906002)(5660300002)(8936002)(15650500001)(41300700001)(83380400001)(186003)(2616005)(6512007)(26005)(6506007)(66476007)(8676002)(478600001)(66556008)(64756008)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c295UXdOVzZnaXY3cU1MYnVZRmRDaXVVcndoWmdoamppRHpLQVBVa1BKb0xC?=
 =?utf-8?B?ajh3UDhIYzQweEVGMlFmd1U4bnJPWHlvVlZsSStFZ09PNVcrWndkZUpsTVdO?=
 =?utf-8?B?SmNYN1dIZ3hCa21QRDlzREQ2VXM0UHBpV1BZbU1YL2ZXYkxGellRMEpLRWVD?=
 =?utf-8?B?U3hwQWFrVFp0bVUrcHIzY2pPdGR5QjNjVmRmd3IzT3ZUUEM3czFpbVY5T210?=
 =?utf-8?B?Z0hzQUh0dk9oOExFV2RTVmVtQmtWU0hlS1pCVUh2L0dZN2thWVpKT3RwR01h?=
 =?utf-8?B?bXJsVjlqNWFDdGpESGxGVmoxNnp5OXYwcnpxdnBBZGV4SmxpTy8wNkpCakpO?=
 =?utf-8?B?SkpCczhNZzJhT3ZKVzJZRktqV2JaTkFKeHVtL1k4Z1RpQTNwUlpVeHNtNnl5?=
 =?utf-8?B?czRQenppRG5EdUNkY2dWYkV4WHZBb2hJNmZzWk1qMWs4OGRXay94N2p1US8w?=
 =?utf-8?B?SEN4VitOVXR2bHJtRkhIL1ZUa01ONTZseHRHdE9vQi8xRzVMNUN3T1J5WUpz?=
 =?utf-8?B?aDUyMldaOGROMzVDWEM5eDA3cVoxai9UOFU2L3d4RFlzTkhqL3o2OUxJWnZy?=
 =?utf-8?B?RStwdHJnZzM5aVg0aEg4U3JyaGZwWXhGdEppazhJb2dIUEZPcEdJdmxtU3ZC?=
 =?utf-8?B?WWZFb3FXL0greHBUaTNia0VDdjZPUzEzN2JOOGQwTk5YcHo0d0d2Ukh5TUdn?=
 =?utf-8?B?c29MbWFVWExjdGNNQjJTYXAzUkI0V1BPZ2krV2Y5WnduVEZpak54UDl0cVdX?=
 =?utf-8?B?MEh1OFJlaGltMGp4Zk1nenlScGlQWGUzODZPRFhQYWdPd0htS2Vmd3lHS2x6?=
 =?utf-8?B?NVIwaWU1Wlk0YTdMdDlZVXNES0RvR25JQzZhMFUrTDFBcU0vSStTcjVQV2Uw?=
 =?utf-8?B?V05JaWxPUjVFT29BNDdkc29QT0NhelZJeHhlY1JrdU5PK0k4cmF1Y1kwM2Zy?=
 =?utf-8?B?WElaeitxL1RaVitiK1QydzEwRy9hM0xYSlFIWHYzQ2RqZXVTWm1kaEE3Rks4?=
 =?utf-8?B?ai9iemx3cDhQendVSDdOTFFNendzSXRlQUR6TE9tWVpTM3hJVU94SjRCVldK?=
 =?utf-8?B?c0tPV25UcCsxajdVNXc1SUxCYVJYeG15ZDQ4UDFpTWYrYjREQ01sc0o3SThl?=
 =?utf-8?B?eE1tUkQ3SjkrcVlaUnRqOTNnZ3NwWVo5eU5NTDlYeFdpWC9RdzNDd1VaT3Rs?=
 =?utf-8?B?by9yd3lTeE53VzNraWRRK1dncmM4SHJIVUppZHRsam0wMnRFdnNkU3psaE1M?=
 =?utf-8?B?Kzkrb2l4ZExRbldGWjgrTm4xN3dJbmxjVFZ2YTNHVEMrUDU3b1ljYTVoWVl4?=
 =?utf-8?B?ajdvczcvZkRnMGxWTG0yaXpEamVtajcxa3FrN2VydFZZdit3YmZlQnVSRDE3?=
 =?utf-8?B?RGlxQVY5NTAzeklFeWtSa3I1QWFqMjBXb1N1R0prQ3Y4cWV1Ri9QSzJmbDZL?=
 =?utf-8?B?VWh2OEZkTGFwa2kyWFdlKzREQWY1ZWo1NGVOQXRJQ2YydldsTEcwaHZBc3NS?=
 =?utf-8?B?bXVJZ1hFQ0VBcjVVelVVU0JudTVWQmtZamJkbWhEVGovS05kVytEUmJib1ZL?=
 =?utf-8?B?SUk3RG43U1dMY1RTM2pSNzVFblhKYUVTeDA4ekFJSHVwclFGb2FsV0dOM0dP?=
 =?utf-8?B?dEEvdXNrT2c5cmpXYjZCTlFoaXdCSitoWElIcHRZV2VMTWd6QXMvdHlQTWth?=
 =?utf-8?B?SVRraXE1NENCaGQ5VmlBaHRJdEovNE1raVJGRW14aTFGUHg4T0ZVeWY5enVm?=
 =?utf-8?B?QThTbUp6eDMybUJYaExYN2NyNkZuZVJ2SWJvUW5peDAxSG9VN0REVHQ5UmxM?=
 =?utf-8?B?ZGlucUhVVlVEOGZ4SEV3NEJHeFFLcW9BL1JRZ3oxVTkvQnFGM1ZCQUZ6VXhO?=
 =?utf-8?B?cU1aL1lPODdhWWQ2bEN5ZmNvZjJlYnFoYjdEazdJaEtUVGwrQ3d3QTZ0d0lS?=
 =?utf-8?B?akRHcjJmRi9oN1BHV2VoMmZVM2Zyd25OUDFlM1ZqM2xpM2diL1lwbTh5Mlps?=
 =?utf-8?B?cVBac05OYVZ4WG5kMEloSVY2OC9IR3lMQzJVVzQ2ZzBlM1N4ZDNuenp6TTJH?=
 =?utf-8?B?cFh2bElXNXc2a2RsNlFjUDdxNVp4U1k3ak5jR0NqSHU4OFA2T1FRbXZjeTZ0?=
 =?utf-8?B?RmlyMGJ4d2RLQnJBenJGK1Q0RnE5S05nSWVHWUZ0Y3dpWm1mZnl2aUcrVDRj?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9971F941D747674EB4857FBF9A9945A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3a7df9-2bd8-4de1-f63d-08dac3563425
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 20:00:23.5384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6cuOEIHshNIFVFxS3UIhCzPVBZK56kaiIjwFOL5nr/NM+7kmsjqrCTL/9CRKtLypTY47eHH+fOppXdwDpg/FaMXTE7Sxjq6Leyk8zXkb/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6327
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDE1OjM4IC0wODAwLCBKb25hdGhhbiBaaGFuZyB3cm90ZToK
PiBDWEwgc3BlYyAzLjAgc2VjdGlvbiA4LjIuOS44LjMuMiBkZWZpbmVzIENDSSBjb21tYW5kCj4g
R2V0IEFsZXJ0IENvbmZpZ3VyYXRpb24uCj4gCj4gVGhpcyBwYXRjaHNldCBhZGRzIHN1cHBvcnQg
Zm9yIGl0Lgo+IMKgIAo+IHY0Ogo+IC0gRml4IHRoZSB0eXBvIG9mIExJRUYgaW5zdGVhZCBvZiBM
SUZFIChBbGlzb24pLgo+IAo+IHYzOgo+IC0gVXBkYXRlIG1hbiBwYWdlIGFuZCBKU09OIG91dHB1
dCB0byB1c2UgImFsZXJ0LWNvbmZpZyIgKEFsaXNvbikuCj4gCj4gdjI6Cj4gLSBDaGFuZ2UgdGhl
IGNvbW1hbmQgcGFyYW1ldGVyIGZyb20gImFsZXJ0IiB0byAiYWxlcnQtY29uZmlnIiAoVmlzaGFs
KS4KPiAtIFVwZGF0ZSB0aGUgZm9ybWF0IGJhc2VkIG9uIGNsYW5nLWZvcm10IChWaXNoYWwpLgo+
IC0gVXBkYXRlZCB0aGUgbmFtZXMgdG8gYmUgY29uc2lzdGVudCB3aXRoIHRoZSBleGlzdGluZyBj
b2RlIChWaXNoYWwpLiBTdWNoIGFzOgo+IC0tIHBlcnNfbWVtIC0tPiBwbWVtCj4gLS0gdGVtcCAt
LT4gdGVtcGVyYXR1cmUKPiAtLSBkcm9wICJnZXRfIiBmcm9tIHNvbWUgZnVuY3Rpb24gbmFtZXMu
Cj4gCj4gSm9uYXRoYW4gWmhhbmcgKDIpOgo+IMKgIGxpYmN4bDogYWRkIGFjY2Vzc29ycyBmb3Ig
R2V0IEFsZXJ0IENvbmZpZ3VyYXRpb24gQ0NJIG91dHB1dAo+IMKgIGN4bDogZGlzcGxheSBhbGVy
dCBjb25maWd1cmF0aW9uIGZpZWxkcyBpbiBsaXN0IGNvbW1hbmQKClRoYW5rcyBmb3IgdGhlIHVw
ZGF0ZXMgSm9uYXRoYW4sIEkndmUgcXVldWVkIHRoZXNlIHVwIGZvciB2NzUgd2l0aCBhCmNvdXBs
ZSBvZiByZWFsbHkgbWlub3IgZml4dXBzLgpJJ3ZlIHB1c2hlZCBhIGJyYW5jaCBvdXQ6IGZvci03
NS9qei9hbGVydC1jb25maWcKCj4gCj4gwqBEb2N1bWVudGF0aW9uL2N4bC9jeGwtbGlzdC50eHTC
oMKgIHzCoCAzMyArKysrKysKPiDCoERvY3VtZW50YXRpb24vY3hsL2xpYi9saWJjeGwudHh0IHzC
oMKgIDEgKwo+IMKgY3hsL2ZpbHRlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAyICsKPiDCoGN4bC9maWx0ZXIuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gwqBjeGwvanNvbi5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxODUgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwo+IMKgY3hsL2xpYi9saWJjeGwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMTYzICsrKysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgY3hsL2xpYi9saWJj
eGwuc3ltwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjMgKysrKwo+IMKgY3hsL2xp
Yi9wcml2YXRlLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDM4ICsrKysrKysK
PiDCoGN4bC9saWJjeGwuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDM1ICsrKysrKwo+IMKgY3hsL2xpc3QuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKy0KPiDCoHV0aWwvanNvbi5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgMTEgZmlsZXMgY2hhbmdl
ZCwgNDg2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCgo=
