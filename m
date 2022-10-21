Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809F7C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Oct 2022 07:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJUHal (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 03:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJUHaj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 03:30:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B2337430
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 00:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666337438; x=1697873438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HP9Fx+niBlEVyZBczDM9Vc8Bk4KVkVeyUPSxg/pxn+4=;
  b=ksrri6duDSD4y0RFC5IuKvvaVOOean4AG9BefSw6j28I5XEJsb4KyhTd
   M595IhcfMx/N9QnIZlk62DMLc5F/LdL1Vu0NU5VR4DceqgC6fkqvdlHnL
   +Lxvqfc9jIJG2EKAsMXWa1oAumN5ZeSx7QDYpt17yOMDdqDSkRtamA8zq
   dXSCLaVXrxJ8LsCgSTM0+x2Mnp8l2NLzwvFl1nLbdQqephrcQo0SlYpsW
   E6H1VGxL+V2oKjcGV0SEc6a9COprMhDUA/8BmQRecTesNtXWv6yu/QnvR
   KuYaMumGh+QceYJWabGsgW7rQJVyp7vsfQ28NM3vQXK7DKnGd4gYcNEpH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="368986331"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="368986331"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 00:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630343471"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630343471"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2022 00:30:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 00:30:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 00:30:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 00:30:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 00:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT5Wou+0b4TtkCbKu4LLycqm/5J0tN6tEsrXM4O3p82Hd8IR6HMoaWS2RxDP9DCUxsEuadnwsIELTfHE5dNRls57V2mWUC6G7XS3iSiB6NhwM+IYYazsU9W7cm8SSNamYWlh8BN4rNzOsgcCH7HKtbkFrJQxP6YTMGO8z9d1Vwq2tujVXxcQeaOXIDnSBJ+bNQD5jdNeg2kZNdaDmMfLtkeuSyAelHC5w7iUXiIgmTCaSHsXYcz/7gkHrUHjfC2mMeY27ru2wtjZzTrF9+BcUA3JfdqqVM+y+jXOyUjjwTjEWE01gAQsE/bKziJLDzVtDuhS6IfgrzEW1+dgpWc79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP9Fx+niBlEVyZBczDM9Vc8Bk4KVkVeyUPSxg/pxn+4=;
 b=lqQ070elfi+vSr/zJOAChr1DgnsDo+jP9kGu/LGhw4boBOkhxd2nyaS+3Cq7vJzciszcXkJDrbAMGjVcn8IPxm+gsGw4fBeMR1o0gdyBfOZ7DiCAmb9L6TgaLNwkOJuDJC7LH8v1D97ySewKA2AvFfo/1YlggSGq4K+o9VWVCZTmfXwEW38VyADx0cV/1ze59EROoyeUZD7uGC4xqeGjWyIxAEpWFtQ3e2Unk+2/MNL/fCABKA+dbFFk7rCVP7nI/NMXvx5OfKBti1MrJ/TdD8XO1Yhii8JPzpmc4K5wcOsC9E57WB+LPBFVLDXjFWgfPlQboYgpBHrMcHJqDNINSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by DM4PR11MB5389.namprd11.prod.outlook.com (2603:10b6:5:394::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 07:30:22 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 07:30:22 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "wzhang@meta.com" <wzhang@meta.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Zhang, Jonathan" <jonzhang@fb.com>
CC:     "jonzhang@meta.com" <jonzhang@meta.com>
Subject: Re: [PATCH 1/2] libcxl: add accessors for Get Alert Configuration CCI
 command output
Thread-Topic: [PATCH 1/2] libcxl: add accessors for Get Alert Configuration
 CCI command output
Thread-Index: AQHY1381cSl/DxoslEWB+TO24VAPpa4YjvWA
Date:   Fri, 21 Oct 2022 07:30:22 +0000
Message-ID: <653c03ca1601bae7b3490458a48c5d6ecbe69982.camel@intel.com>
References: <20221003232306.1326511-1-jonzhang@fb.com>
         <20221003232306.1326511-2-jonzhang@fb.com>
In-Reply-To: <20221003232306.1326511-2-jonzhang@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|DM4PR11MB5389:EE_
x-ms-office365-filtering-correlation-id: 56fde152-d7e0-42c2-2411-08dab3361d1e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZImo5X/kdqfuKG7bekVQpjkIpQ/yH9NjLUX9MNwNadJ2mLJc9boZk4Y+UtPRGodL2DZJXaGCffL2wTY5mlvScaC1O5vTqANYKjNZXoVKu4g9IwCVZXSMaCm3ocv6ke/Jls9riKBBpZacOzRNlY0DmruAC1AnHwPnnbA/RamxAShoQweivcszdp/En+qTZ7W85Hy6X4PlhQtFa3N8wF5j1RVOvLCV325hYrWDmOJDtDom9xkIAMf9V+GTX16w4fRQCzcyGQUQXUVH2UH4KFyNz6jbHEk5rUCTRBdOKaauNg1p/gMju003NiIvuUUKq8pCUbY/IYDBpI3ehSu9Xd2m8o36GIAMF3ak7j6b6/piFvOL7hCcJnHSY5oW6LCyfRSPXBrx6L0zEKvsbPsUnSRXG71kmJR0YRDTtFIAVZPcPMa/+mYmuZ5rzALfEOpqaoDqlvbta64SDDr314M8JunN8keU7TVT/FAPbNBr6fPjTuSaa/c53r8tLcy+7IQJuwkhhzCYcu13XWTiry8Af8r5RiuGUrGLij3VXcc+tlCLdbzvCVjgFI1humc5zyD8d69LbCmvhIz75Te4Nm8floydGpSNi/qvGwMOLHOLmwh1tl7ifJatlGqqFd+id1JNxZma+xMfzkl/K0puDjnLLkC9gwiLuyEdNFuS7REZssv69Tq/hXd1MHb6Ezfk9svC/Ymj04bmYWko6QPDXR4vys1pq3wpS8HSi9X0xCEUUNT+sW5/8FJl3TNOEXn/wUTtic/zvH/c1w/CL0xqWRw/N2ZToA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(41300700001)(83380400001)(66446008)(110136005)(64756008)(66946007)(8676002)(66556008)(36756003)(4326008)(316002)(6506007)(2906002)(6512007)(86362001)(76116006)(26005)(5660300002)(66476007)(8936002)(82960400001)(186003)(15650500001)(2616005)(478600001)(38100700002)(91956017)(71200400001)(6486002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWo5R3hNVUlaSW9KWXVUSUZGazZxaFZwMHk4aDNUc1BUWVhyanZyc2pzNmM5?=
 =?utf-8?B?cnNKSjZ2dTBWL1BEY3R2c0gxR1oxZmtmWEQ3K3NhYXZJbzAwaEZCSk16dkZ6?=
 =?utf-8?B?L09ZdDNMS0tHMUxqbStlUmt3Uk5yaVpST09zcFJCc3N1SzJmcmZxa1RoUFZv?=
 =?utf-8?B?NGpwcHFvVjQxNEx5aEh5bFZhNmwrN0NpUzMrQzBTQVVTWThYOW5NVGpWU0JT?=
 =?utf-8?B?NW56bVhsaEVjVXVXSE5lcG1oM29BenNGT0pZbWJXU2FsdnRqUHY2d056emxq?=
 =?utf-8?B?VWppajRFZTBCZUd5MDlXekg3citTSm1FRVp6VnNpWDBnZWZxdlVEYnkyQ2R2?=
 =?utf-8?B?UnhURUtPelYrU2tpeFlqcWUxa3JwcHFvd3c5SUhyeHh4NnJVd2NoeldSWC9K?=
 =?utf-8?B?TU83a2owc0xkTjdoYU52OGg4WmV5OFZZSW51Z3Zybkc3TFkxR3U4RVFwTE92?=
 =?utf-8?B?ME1nV25WazM3MDlKRTVHem1CMlRWeTdmdFdwME5DTnNNZjE1cEZZU3Z6V2V5?=
 =?utf-8?B?S0VadEtEODRmbjlTNk1TSzVXZFJSdjZWU0VWTmJ6bEJPcE1mMjE3UzRkTVlv?=
 =?utf-8?B?bEJFeVF2QTUrRXJVT1lPd2NNeGZKeUljRGVOczhuZ1ZzSGZpdXdEZkJ0Nmtp?=
 =?utf-8?B?dU9iSnNSZU1hc1Z5S0RoL0tYSDdmSTJUcW1TN0pjamJzQjVwUEZlRTliMHU2?=
 =?utf-8?B?OUpma0ZZK3RPbkEvRTdLNStVYkZhTmdBeW0vNGpmdnpRZHloRVY2L0FsZUFx?=
 =?utf-8?B?dEhUQm1icW82TjVxVmVsWTA3aG5lU2VJV0Q3VXdzWW9FcDBIK0VRcFBFRTFw?=
 =?utf-8?B?Q3JBTmtzc0xkWWRFOFRlNk9IM2lZSXI5ampuczhNaTFDSVZQZEdhMWxSZlRB?=
 =?utf-8?B?dGh4WVJxTTBTTFpBdzNOWUF5dG5qTnR6NXJJaWdIKzF3RXp1ZVh1QVV4Vzg2?=
 =?utf-8?B?ZzFsVjBLQTRxMEdZV1p0by8zQlJjSGNaenpWWENpemEyekJ2eFVQOFBNc25C?=
 =?utf-8?B?RFg4T2J0R1M5bjdWeWNPS24vaHRLTnJQa1ZORlBtamRGK1M3OUo5MStOWXJ0?=
 =?utf-8?B?ekxWNHJuc0Izb01QRFNwVlltMGFzeEc3ZW04dXBJazdiT1IvSkpITEVWQ0tO?=
 =?utf-8?B?TEh1Vzd0OGM4anVHUXBUTDdDbnoxekFOUGpZbmdlTDc0QmJ4OWlNbFJlMGNR?=
 =?utf-8?B?Q1E1WGtURU1uUEppRHFIRlJqZW13REhpU0hhOEd1Zjc0SnZOWTdNQm1yOHEz?=
 =?utf-8?B?Y05DNjZMZWh0ZzdITEQ1NnVuSS9SSnJ0Z2I4Tk9Na0VyWm4rN1BNMUluVXdy?=
 =?utf-8?B?cXBRSFNjbjF6V1lMbW04Tzl4Z3lEQS9IOUN4Qk56ZWZMbDZkOW9OcjBvTHFq?=
 =?utf-8?B?dHFJWUxKRUpqQ01BbkM0allzVW9xZ29hUGxzcFBKOHJ6SmNFbnBKbFVETERL?=
 =?utf-8?B?MW9sSXV1blF4YXIwbHlHVG9FemN1bDUzeEZpckFkQmgvSGRQQkwvdlVVVS9z?=
 =?utf-8?B?aGtETW1aNUdOV3lPSGtWQkxBblJhMTlHeHdHTm42eTBaM21PSW9tcTI5aVIx?=
 =?utf-8?B?TTVEUmtVU2UzZ1JqNWJ1RVFlMmp4WVVIUXVrQS9OeXJseGdnZlU2eTNJaUVs?=
 =?utf-8?B?M2x0enp6blpEbzU5K3RGc05hQWluTVRGbkp4cmhXSkRGSXZQZWplZ0VyYWJ4?=
 =?utf-8?B?RUdXNUtrKy85dm5nVVpsdW5wMnVHWlFtUTJidGxVamx4aDVIVUphU0l6UC9x?=
 =?utf-8?B?VTlUVk9YeFFGK1lhN1BSNjZpQUVYSGhsRUwxRlN0T0JhclFZYVdIWm13TTVn?=
 =?utf-8?B?OEMvZ0twYm9NWFFDMVZZOUhSejNEVHpqS2tuSnQ2VEJXY1BOaTFyUVc4VFNV?=
 =?utf-8?B?c1RvUjRCTGluUWh0SmdXNi9IdUFIVjFTV1RkNE1IQTdRWGorLzZCWTQ2Y3Fw?=
 =?utf-8?B?U2o5Y3ZRYklGRnBiNnJBZjhhQ1ZXanUzZHd5ekt2VmFkbVdRcHVJYnVRcnBV?=
 =?utf-8?B?RnNRMFdQQXgwZTVHMzhsWC9GM1dnSHpUT1ljeDdLTS9lLyt6azI3eW0vUG11?=
 =?utf-8?B?T3Npa216MlFwSklERERJVXZQV3VUOC9IUEpkdWd4TFg2MU1leE13Zng2ZENt?=
 =?utf-8?B?OE9RV0V3dGxVTll5YTBDNy90THB0L2Y4V1ZhaHcrUFVTMTV6QjQycHR6RlhL?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <526750758F715542A74359B58B0EFD21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fde152-d7e0-42c2-2411-08dab3361d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 07:30:22.4310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7n95SBRQVugB5EkXuFiBLYIecpyH/KmbFsGsWStbmYCUJWWV8HITo65AEyVm5UdG8Bfq2YpanylH0W5iO7MwNaBQRpxosGlixB+ab0DZNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5389
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDE2OjIzIC0wNzAwLCBKb25hdGhhbiBaaGFuZyB3cm90ZToK
PiBGcm9tOiBKb25hdGhhbiBaaGFuZyA8am9uemhhbmdAbWV0YS5jb20+Cj4gCj4gQ1hMIDMuMCBz
cGVjIHNlY3Rpb24gOC4yLjkuOC4zLjIgIkdldCBBbGVydCBDb25maWd1cmF0aW9uCj4gKE9wY29k
ZSA0MjAxaCkgZGVmaW5lcyB0aGUgZ2V0LWFsZXJ0LWNvbmZpZyBjb21tYW5kIHRvCj4gcmV0cmll
dmUgdGhlIGRldmljZXMncyBjcml0aWNhbCBhbGVydCBhbmQgcHJvZ3JhbW1hYmxlCj4gd2Fybmlu
ZyBjb25maWd1cmF0aW9uLgo+IAo+IEFkZCB0aGUgbWV0aG9kcyB0byBpc3N1ZSB0aGUgY29tbWFu
ZCBhbmQgZ2V0IHRoZSBmaWVsZHMKPiBkZWZpbmVkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0
aGFuIFpoYW5nIDxqb256aGFuZ0BtZXRhLmNvbT4KPiAtLS0KPiDCoERvY3VtZW50YXRpb24vY3hs
L2xpYi9saWJjeGwudHh0IHzCoMKgIDEgKwo+IMKgY3hsL2xpYi9saWJjeGwuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTIwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiDCoGN4bC9saWIvbGliY3hsLnN5bcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDIzICsrKysrKwo+IMKgY3hsL2xpYi9wcml2YXRlLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDI4ICsrKysrKysrCj4gwqBjeGwvbGliY3hsLmjCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxOSArKysrKwo+IMKgNSBmaWxlcyBjaGFuZ2VkLCAx
OTEgaW5zZXJ0aW9ucygrKQoKSGkgSm9uYXRoYW4sCgpTb3JyeSBmb3IgdGhlIGRlbGF5IGluIGdl
dHRpbmcgdG8gdGhlc2UgLSBhIGZldyBzbWFsbCBjb21tZW50cyBiZWxvdy4KCj4gCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vY3hsL2xpYi9saWJjeGwudHh0IGIvRG9jdW1lbnRhdGlvbi9j
eGwvbGliL2xpYmN4bC50eHQKPiBpbmRleCBmZDI5NjJhLi5kZWMzNjQxIDEwMDY0NAo+IC0tLSBh
L0RvY3VtZW50YXRpb24vY3hsL2xpYi9saWJjeGwudHh0Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9j
eGwvbGliL2xpYmN4bC50eHQKPiBAQCAtMTIxLDYgKzEyMSw3IEBAIGluZm9ybWF0aW9uIHRoaXMg
Y2FsbCByZXF1aXJlcyByb290IC8gQ0FQX1NZU19BRE1JTi4KPiDCoHN0cnVjdCBjeGxfY21kICpj
eGxfY21kX25ld19yYXcoc3RydWN0IGN4bF9tZW1kZXYgKm1lbWRldiwgaW50IG9wY29kZSk7Cj4g
wqBzdHJ1Y3QgY3hsX2NtZCAqY3hsX2NtZF9uZXdfaWRlbnRpZnkoc3RydWN0IGN4bF9tZW1kZXYg
Km1lbWRldik7Cj4gwqBzdHJ1Y3QgY3hsX2NtZCAqY3hsX2NtZF9uZXdfZ2V0X2hlYWx0aF9pbmZv
KHN0cnVjdCBjeGxfbWVtZGV2ICptZW1kZXYpOwo+ICtzdHJ1Y3QgY3hsX2NtZCAqY3hsX2NtZF9u
ZXdfZ2V0X2FsZXJ0X2NvbmZpZyhzdHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2KTsKPiDCoHN0cnVj
dCBjeGxfY21kICpjeGxfY21kX25ld19yZWFkX2xhYmVsKHN0cnVjdCBjeGxfbWVtZGV2ICptZW1k
ZXYsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgb2Zmc2V0LCB1bnNpZ25l
ZCBpbnQgbGVuZ3RoKTsKPiDCoHN0cnVjdCBjeGxfY21kICpjeGxfY21kX25ld193cml0ZV9sYWJl
bChzdHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2LCB2b2lkICpidWYsCj4gZGlmZiAtLWdpdCBhL2N4
bC9saWIvbGliY3hsLmMgYi9jeGwvbGliL2xpYmN4bC5jCj4gaW5kZXggZThjNWQ0NC4uZWQ1NjE2
YyAxMDA2NDQKPiAtLS0gYS9jeGwvbGliL2xpYmN4bC5jCj4gKysrIGIvY3hsL2xpYi9saWJjeGwu
Ywo+IEBAIC0zMTQwLDYgKzMxNDAsMTI2IEBAIGRvIHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+
IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gISEoYy0+ZmllbGQgJiBtYXNrKTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoFwKPiDCoH0gd2hpbGUoMCkKPiDCoAo+ICtDWExfRVhQT1JUIHN0cnVjdCBjeGxfY21kICpj
eGxfY21kX25ld19nZXRfYWxlcnRfY29uZmlnKAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgY3hsX21lbWRldiAqbWVtZGV2KQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0
dXJuIGN4bF9jbWRfbmV3X2dlbmVyaWMobWVtZGV2LCBDWExfTUVNX0NPTU1BTkRfSURfR0VUX0FM
RVJUX0NPTkZJRyk7Cj4gK30KPiArCj4gKyNkZWZpbmUgY21kX2FsZXJ0X2dldF92YWxpZF9hbGVy
dHNfZmllbGQoYywgbSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcCj4gK8KgwqDCoMKgwqDCoMKgY21kX2dldF9maWVsZF91
OF9tYXNrKGMsIGdldF9hbGVydF9jb25maWcsIEdFVF9BTEVSVF9DT05GSUcsIHZhbGlkX2FsZXJ0
cywgbSkKPiArCj4gK0NYTF9FWFBPUlQgaW50IGN4bF9jbWRfYWxlcnRfY29uZmlnX2dldF9saWZl
X3VzZWRfcHJvZ193YXJuX3RocmVzaG9sZF92YWxpZChzdHJ1Y3QgY3hsX2NtZCAqY21kKQoKR2Vu
ZXJhbGx5IHRocm91Z2hvdXQgdGhlc2UgcGF0Y2hlcywgYmVjYXVzZSBvZiB0aGUgKHVuYXZvaWRh
Ymx5KSBsb25nCm5hbWVzLCB0aGVzZSBsaW5lcyBhcmUgd2VsbCBvdmVyIDgwIGNoYXJzLiBGb3Ig
Y2FzZXMgd2hlcmUgYSAjZGVmaW5lCmZvciBleGFtcGxlIGNhbid0IGJlIGJyb2tlbiBkb3duIGZ1
cnRoZXIsIHRoYXQncyBva2F5LiBCdXQgYSBsb3Qgb2YKdGhlc2UgY2FuIGJlIHNwbGl0LiBXZSBo
YXZlIGEgLmNsYW5nLWZvcm1hdCBmb3IgdGhlIHByb2plY3QsIGFuZCB0aGF0CnNob3VsZCBkbyB0
aGUgcmlnaHQgdGhpbmcgaW4gYWxsIHRoZXNlIGNhc2VzLgoKPC4uPgo+IAo+IGRpZmYgLS1naXQg
YS9jeGwvbGliL2xpYmN4bC5zeW0gYi9jeGwvbGliL2xpYmN4bC5zeW0KPiBpbmRleCA4YmI5MWUw
Li43YzFlMjYxIDEwMDY0NAo+IC0tLSBhL2N4bC9saWIvbGliY3hsLnN5bQo+ICsrKyBiL2N4bC9s
aWIvbGliY3hsLnN5bQo+IEBAIC0yMTcsMyArMjE3LDI2IEBAIGdsb2JhbDoKPiDCoMKgwqDCoMKg
wqDCoMKgY3hsX2RlY29kZXJfZ2V0X21heF9hdmFpbGFibGVfZXh0ZW50Owo+IMKgwqDCoMKgwqDC
oMKgwqBjeGxfZGVjb2Rlcl9nZXRfcmVnaW9uOwo+IMKgfSBMSUJDWExfMjsKPiArCj4gK0xJQkNY
TF80IHsKPiArZ2xvYmFsOgo+ICvCoMKgwqDCoMKgwqDCoGN4bF9jbWRfbmV3X2dldF9hbGVydF9j
b25maWc7Cj4gK8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9jb25maWdfZ2V0X2xpZmVfdXNl
ZF9wcm9nX3dhcm5fdGhyZXNob2xkX3ZhbGlkOwo+ICvCoMKgwqDCoMKgwqDCoGN4bF9jbWRfYWxl
cnRfY29uZmlnX2dldF9kZXZfb3Zlcl90ZW1wX3Byb2dfd2Fybl90aHJlc2hvbGRfdmFsaWQ7Cj4g
K8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9jb25maWdfZ2V0X2Rldl91bmRlcl90ZW1wX3By
b2dfd2Fybl90aHJlc2hvbGRfdmFsaWQ7Cj4gK8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9j
b25maWdfZ2V0X2NvcnJfdm9sX21lbV9lcnJfcHJvZ193YXJuX3RocmVzaG9sZF92YWxpZDsKPiAr
wqDCoMKgwqDCoMKgwqBjeGxfY21kX2FsZXJ0X2NvbmZpZ19nZXRfY29ycl9wZXJzX21lbV9lcnJf
cHJvZ193YXJuX3RocmVzaG9sZF92YWxpZDsKCkkgdGhpbmsgZm9yIGFsbCB0aGUgJ3ZhbGlkJyBh
Y2Nlc3NvcnMsIHRoZSAnZ2V0JyBjYW4gYmUgZHJvcHBlZC4KY3hsX2NtZF9hbGVydF9jb25maWdf
PHNvbWV0aGluZz5fdmFsaWQgaXMgYSByZWFzb25hYmxlIEFQSSB0aGF0IGFza3MKd2hldGhlciBz
b21ldGhpbmcgaXMgdmFsaWQuIAoKPiArwqDCoMKgwqDCoMKgwqBjeGxfY21kX2FsZXJ0X2NvbmZp
Z19nZXRfbGlmZV91c2VkX3Byb2dfd2Fybl90aHJlc2hvbGRfcHJvZzsKPiArwqDCoMKgwqDCoMKg
wqBjeGxfY21kX2FsZXJ0X2NvbmZpZ19nZXRfZGV2X292ZXJfdGVtcF9wcm9nX3dhcm5fdGhyZXNo
b2xkX3Byb2c7Cj4gK8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9jb25maWdfZ2V0X2Rldl91
bmRlcl90ZW1wX3Byb2dfd2Fybl90aHJlc2hvbGRfcHJvZzsKPiArwqDCoMKgwqDCoMKgwqBjeGxf
Y21kX2FsZXJ0X2NvbmZpZ19nZXRfY29ycl92b2xfbWVtX2Vycl9wcm9nX3dhcm5fdGhyZXNob2xk
X3Byb2c7Cj4gK8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9jb25maWdfZ2V0X2NvcnJfcGVy
c19tZW1fZXJyX3Byb2dfd2Fybl90aHJlc2hvbGRfcHJvZzsKPiArwqDCoMKgwqDCoMKgwqBjeGxf
Y21kX2FsZXJ0X2NvbmZpZ19nZXRfbGlmZV91c2VkX2NyaXRfYWxlcnRfdGhyZXNob2xkOwo+ICvC
oMKgwqDCoMKgwqDCoGN4bF9jbWRfYWxlcnRfY29uZmlnX2dldF9saWZlX3VzZWRfcHJvZ193YXJu
X3RocmVzaG9sZDsKPiArwqDCoMKgwqDCoMKgwqBjeGxfY21kX2FsZXJ0X2NvbmZpZ19nZXRfZGV2
X292ZXJfdGVtcF9jcml0X2FsZXJ0X3RocmVzaG9sZDsKPiArwqDCoMKgwqDCoMKgwqBjeGxfY21k
X2FsZXJ0X2NvbmZpZ19nZXRfZGV2X3VuZGVyX3RlbXBfY3JpdF9hbGVydF90aHJlc2hvbGQ7Cj4g
K8KgwqDCoMKgwqDCoMKgY3hsX2NtZF9hbGVydF9jb25maWdfZ2V0X2Rldl9vdmVyX3RlbXBfcHJv
Z193YXJuX3RocmVzaG9sZDsKPiArwqDCoMKgwqDCoMKgwqBjeGxfY21kX2FsZXJ0X2NvbmZpZ19n
ZXRfZGV2X3VuZGVyX3RlbXBfcHJvZ193YXJuX3RocmVzaG9sZDsKPiArwqDCoMKgwqDCoMKgwqBj
eGxfY21kX2FsZXJ0X2NvbmZpZ19nZXRfY29ycl92b2xfbWVtX2Vycl9wcm9nX3dhcm5fdGhyZXNo
b2xkOwo+ICvCoMKgwqDCoMKgwqDCoGN4bF9jbWRfYWxlcnRfY29uZmlnX2dldF9jb3JyX3BlcnNf
bWVtX2Vycl9wcm9nX3dhcm5fdGhyZXNob2xkOwoKVGhlc2UgYXJlIG9rYXkgdG8gaGF2ZSB0aGUg
Z2V0LCBzaW5jZSB3ZSBhcmUgZ2V0dGluZyBhIHRocmVzaG9sZCB2YWx1ZS4KCgoK
