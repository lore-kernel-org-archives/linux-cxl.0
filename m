Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88763C61DA4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Feb 2023 23:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjBCXHh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Feb 2023 18:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCXHg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Feb 2023 18:07:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406931E5EC
        for <linux-cxl@vger.kernel.org>; Fri,  3 Feb 2023 15:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675465654; x=1707001654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cIQ6X1WSEZvoQk17osMhJ42dQ7VKntrtcUusXDAeAQ8=;
  b=RsC1/1ikOVmnggmaeltWVbjbYQRfQ6YnqbmeoutMBMqoTnz1VcSr8vuM
   fggNwcD/6uaXqplFTuNE7A3XcP7eEBelOarNNPTeXWkeF+rUJo9PUsRay
   q38a0NLjeYZRhWkWUSDg9ZqvsZ+dqT9r+IeMpFlXGZuHR4WfJ96lGBdQF
   TOZYl6+Dtj5iXs76H6zlWCkodGZGWgUdibBxMd88E7h4Yo9ehDhzwZNcn
   Fc2wo8+fnq5/z1j1gwtNQze++B9EH/nM4FPLMJZr+Hn7D5h+CAw5u7A8w
   zcyop6Au4JCrX9slXtA7GE+pnoJ4E1f995n9RAAY7icWGEK6cdmehAlMO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="316878523"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="316878523"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 15:07:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="774496934"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="774496934"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2023 15:07:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 15:07:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 15:07:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 15:07:32 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 15:07:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9MEt8lOpbAM+uY6qLZXAytg3GZVaGnJohYOKmKlFQ2Nbf0zPhmCSomD+gFkdVW6Itg7ZHoKyQ+V0N4qghFb8242d8njwbDZ8WPSo4FA89lVxzr5K/SR/agZyYrEUpMqZkkY9Q0rddFoBuPhYL4gv5H8aitbfb1Kd7Kth5Xg02WzuhNrlWaXSx73jCFM/rzvRuVGiBj3QWy/G8GfU9du+bxjBezjZzwgsWgBVMb/CIwFSbpL7Ce/oukiIbD2En7rcqCOlrFL+Vk4DxKQDAEmqzISJaHrx/URyLi7Yi0d5xLS3iBl9VSq2jAd81191W0LAGJ6krwhvf+OhQyYytVT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIQ6X1WSEZvoQk17osMhJ42dQ7VKntrtcUusXDAeAQ8=;
 b=fdyn05kDxJg946M+aVDSk2IzkThKe+CCaIQALEgq6urbb1T2BZIruSx641K+TgFeagw85dfAxP3I2oBeI0BrqvsnoRa0Y78xMqvSP+9vr38lAeIEpSRD+WmAiHqOgeptNDakgo04zn/ATjhgMokXdIawcxRD7oHVxPyZlsu9hAg5vBr74KQQUMz63biJ8V4KX0Lgv8WrhiKps9I9YgBZz4JrpYPUgMluOO6EeBU/s71fT/U0jXvcFtLsDz1rsZqbgcevq3tUNVgR2J3yowmjQtsVHC8vi/JJxzI1rPnGVReGlfztEKTPV5mc35EtWXgQW/7sq3M8A4IwOyMMzuDEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 23:07:29 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::1ad0:a5dd:2fec:399c%5]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 23:07:29 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH ndctl] ndctl/cxl: Remove unnecessary null check
Thread-Topic: [PATCH ndctl] ndctl/cxl: Remove unnecessary null check
Thread-Index: AQHZOBpqKB5vxeDPrE+6IkQY12qc96692FyA
Date:   Fri, 3 Feb 2023 23:07:29 +0000
Message-ID: <2c861e6cc1ec27d016d66c98affb6def552fb800.camel@intel.com>
References: <20230201-update_query-v1-1-4dd3de2d35c1@intel.com>
In-Reply-To: <20230201-update_query-v1-1-4dd3de2d35c1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|SA3PR11MB7581:EE_
x-ms-office365-filtering-correlation-id: e71b10ef-e055-4615-4aef-08db063b6c32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bdEmOScBtiIPTZptwj1cavV0+nUHriUG4/w92I49gMinX2tu/gaMML0pdbnhx0E0R3Ki8DJgwSrpgiufkyLAgZsVc9h2OuGllIhfqHChvDhehji1nDvjJBZyJ6nx39lqK6nDpgx6/Cs+2Q2s7DchctEQn3Py9bCh7vazaVM6II3dVH+AwS8T7I7s6xA3r1sIYYN/ThKGkmAGUUWrWItUmHBiZktG8nrbzEK+VpqF7LHY/nBXtTdvX/F7qB4Yr2UN6r8ZBPvvf8CJoFfz+tTTDs/aYAdA8EwjFYj5YyYnUVQ3vesPB30cBOLiy+Ph2XbSdWmcsMSVfUdf/XdBedaV3nWPA/YkWPn6qnOuaUyHlNJ/KCewVDRROnXnqHSGD1rPs/nCps3vt9q1dpAaeQ1TQP3+ODtR6Dtwv8B7YD/1SdUGE6TcmIhxOfHgz/uy6/Zw1bgj05hGi2wvUwvfbbnKCATiSFuFXkn0nFAod9leKQ4oIHcz3p+W9F0l9GgOvGOyxLDPt/iY39KBlzPVSqlTcI9QBAzRiWcY/vG5hcTCcWV4rkCBpz+7IH/VkUATFm1KfiIcIurXLhMXyf0pEVJiVuS1xhJJUJg9DcLpCjUA6LBklq7YPEgw4apiRN6nxO30igl+1QOND6yR71FJCpwT5d69l3+/rFolArsT3AQ5YY1ZTB88lVfQ3Kzi2e/pUXt5iOJFpHrecDEzDUcYwvdKFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199018)(6636002)(37006003)(316002)(36756003)(478600001)(38100700002)(86362001)(82960400001)(122000001)(38070700005)(83380400001)(26005)(186003)(6506007)(2616005)(6512007)(8936002)(6486002)(6862004)(5660300002)(71200400001)(41300700001)(2906002)(66446008)(64756008)(4326008)(91956017)(66476007)(66556008)(76116006)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3BPNWZFeWo4UW80SGIxT3lzOEFCUnVQZk9YaHVCOUhQZ2NObmt3bGpXOXVp?=
 =?utf-8?B?R24zdTlyQkNVYkdtbitlL1hLd2ZKR0hjaHJhSjVhTkhGR2hNTHhYNkhiZ1VD?=
 =?utf-8?B?ZkhPb2Z4bjdVdXNsa2FZOG1VaGtBdDNYd2xqSzllc3c0TXpCQjFzanJVWnV4?=
 =?utf-8?B?MjR1akRaN0hwaWtzZkt0ZTExNXIrY2I4NVM3TGpFOUxOK01vcmdOR29DQjlm?=
 =?utf-8?B?M0oraXRMdEV4M0FYWHpuK1ZyZ0EvQUdkbnY1ek56cUowbklFZUU1cU5oYnVQ?=
 =?utf-8?B?R0tYbThGdWlKMEE5cUhzY2xPLzRyYUd3eUY5WURIbDVkZ1NJendmOFZWRm1I?=
 =?utf-8?B?dm9uSXpvV1owV0FIbTZpWmFDcDd5Q2UxLzhwWmw1azd4SmlwbDA3SE9Lc09U?=
 =?utf-8?B?Z0JYT0lsMzR6ZkNiM1hwbnBHL0ZYdUFsZm1RWklIeGJkNWtkaFVRZWlIQnNo?=
 =?utf-8?B?dWtJZmN2bWQyTU9FSVIrRmlJamdMVjYycTZLRDZjUXVuSWw1RlcySVJWb1Qz?=
 =?utf-8?B?ZHdYTDFPT0Y3eVcvOTVyYlRwS09NWXN0VXU2Z2lXczB5b0Q0N2NiNFNId2ZM?=
 =?utf-8?B?QkQ0UTJZNDE1aUpuS0pQcVZ0UnhwVWlsKzRnRFh6eWtEWEt6NGJ0ZDNUVGNQ?=
 =?utf-8?B?dXU0bHp3SlNWeWNqQjRvcHcyWm85ZEZKTlpodHlML1FMUFdXTTJVYzQ3Sncz?=
 =?utf-8?B?SWgvOEs5ekoyMnUzSDVwbFBnYTJBVm5KMGViVWx4TVFpK3BWVEFBK0pJbnVa?=
 =?utf-8?B?b282MFEzQXEwUWkyUExEY3Z2OHp4Vlg4WEs2WjdQUC9JcFlDOVpQMHVPQkJG?=
 =?utf-8?B?dURWbWdvMzlvdTVLWTVZOTI3L2RqN1RQSXV6TUlSU1Q4Umw2a1RUcXRxS1Ey?=
 =?utf-8?B?S2dpb3UwUGFTZzF3WFZES2x6Q1FEZXlRZk5MbWxXQkNySG00aWFqK1pNUnZU?=
 =?utf-8?B?WXFDOW5mNDVFNm9BRG14RHMzUWxTK21vZzFabXl1byswdmNQUkpZbHphZVhE?=
 =?utf-8?B?eHBzTTlMRlZ2NTExM1BHZlQ4TjN3RVRiSmVRUUlGWHJ4ZDV1cEd4enJiQThB?=
 =?utf-8?B?R2ZmUVMwRWY1YUpuc1RoWXR4NjdQZjhqZDRreGE2QVd6UFVjTmxqclExRXFU?=
 =?utf-8?B?MVRFK3BoM2VaMXhCcXZyMG9uNEM3blZFcEhxdmw0cXcrZHgrcVR4eWt1bzMy?=
 =?utf-8?B?d0MrUThSVjAwclZSYW5sN01FaGgybiswYVVaUHJWanVLN1JXUVFWQnh0aHZ1?=
 =?utf-8?B?QS9IR2xIN21mUDQzS2NESHVBNFV3TlEvc3VYWGwvU09CUW1DTHY2RjNCc0dU?=
 =?utf-8?B?MWFKRm16dXd1RHdBeTZyeHdVUkRFdG80aVU2eExpM0tkNklwcW42YU8yclVI?=
 =?utf-8?B?dW42ZXZxblJvNkFsVDFIdnpkOUI3VDdtaFJDTGZIMzl2NTE5Sk1wRW5ZYkNV?=
 =?utf-8?B?MHUyTnpEOE02SUZiMXNzcDRxdklzdjV6YUxlcVRFWXhaM1djZzFKZE5BUWhL?=
 =?utf-8?B?QW9uNml4NEFaZkhGZk5OUFdpYXF3M1pmMWorWGdMby82cE1XdG5yTlNGcUM0?=
 =?utf-8?B?MXNSTGViREo5NkEzT2hnbGdrME03b0pXUXBmZ0RTNWkzc3RVdHlEWTNZUGhQ?=
 =?utf-8?B?QWd2bUh4WUZ1UlB0VzBsc0ltK000a0UxakJIVkpEMTBMUlZRTDVnZEVLa05O?=
 =?utf-8?B?aHN5NDNoakVOMGVSdWtyR3h6T2d6YmJQZW1Ka3NXemF6dkR5NTE0YloyeEcv?=
 =?utf-8?B?dE5Rdm5JS0loYklKNnNOYmZuWjBxZGhTWmpOMnZsbXFYeTlvSFZlZEJHbllQ?=
 =?utf-8?B?WDM2MUhVYndwNUJzOC9QSkpTbFpTbGxMMzFhU3dnbjV3RWFzUWZYZjlWTmRw?=
 =?utf-8?B?Vzd1NUNoSmpOYmpaODNlVXErVjF1OHpRSDhkc3M0dE0yTEQvaXpwa0hYaTJM?=
 =?utf-8?B?Y2N4MWhqTEs4RmZDMzR0N0pESkVwcDU2dURvQk5IR3FsajA5V2toUmhjSyty?=
 =?utf-8?B?ZnA0YzdLUFFOYmJUczYvU1Q3UkR5dmhRMWwvM2xBZ2xwNStoaGkxMmh6Y2sx?=
 =?utf-8?B?eHpuRm1uUkhOMHVQVmNTMUZ3TUV2a2J4MlJtK3FrNUdnMll6R0FjUSs3U3Zn?=
 =?utf-8?B?L0F6cG9nVlpreDkvVHJWTFVodUVFN2Q5bGVTZWxmL29aWmxNenRkaVdVc0hS?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E43783126036A04ABFD0AE770AEB932F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71b10ef-e055-4615-4aef-08db063b6c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 23:07:29.0817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdtAgDeUi1esKiUDVJWe8g5BbhbqnDD4s78A1W6bcMmC/rPsrKIgaroUt169dXEyTNx+991EDsOGAOU9f0BxhcVI13R6zKPudKWNDocAAC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTAzIGF0IDEzOjU2IC0wODAwLCBJcmEgV2Vpbnkgd3JvdGU6DQo+IGNt
ZC0+cXVlcnlfY21kIGNhbiBuZXZlciBiZSBudWxsIGluIGN4bF9jbWRfYWxsb2Nfc2VuZCgpLsKg
IFRoZSBvbmx5IGNhbGwgY2hhaW4NCj4gaXM6DQo+IA0KPiDCoMKgwqDCoMKgwqDCoCBjeGxfY21k
X2RvX3F1ZXJ5KGNtZCk7DQo+IMKgwqDCoMKgwqDCoMKgIGN4bF9jbWRfdmFsaWRhdGUoY21kLCBj
bWRfaWQpOw0KPiDCoMKgwqDCoMKgwqDCoCBjeGxfY21kX2FsbG9jX3NlbmQoY21kLCBjbWRfaWQp
Ow0KPiANCj4gQW5kIGN4bF9jbWRfZG9fcXVlcnkoKSBlbnN1cmVzIGl0IGlzIG5vbi1udWxsLsKg
IEluIGFkZGl0aW9uIHRoZSBsb2NhbCB2YXJpYWJsZQ0KPiBxdWVyeSBpcyBhbHJlYWR5IGRlcmVm
ZXJlbmNlZCBieSB0aGUgdGltZSBpdCBpcyBjaGVja2VkIGZvciBudWxsLg0KPiANCj4gUmVtb3Zl
IHRoZSB1bm5lZWRlZCBudWxsIGNoZWNrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSXJhIFdlaW55
IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiAtLS0NCj4gTWlub3IgZml4IEkgZm91bmQgd2hpbGUg
d29ya2luZyBvbiB0aGUga2VybmVsIHNpZGUgcXVlcnkgY29tbWFuZC4NCj4gLS0tDQo+IMKgY3hs
L2xpYi9saWJjeGwuYyB8IDMgLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0p
DQo+IA0KDQpNYWtlcyBzZW5zZSwgYXBwbGllZCwgdGhhbmtzIQ0KDQo+IGRpZmYgLS1naXQgYS9j
eGwvbGliL2xpYmN4bC5jIGIvY3hsL2xpYi9saWJjeGwuYw0KPiBpbmRleCA0MjA1YTU4N2QzYmIu
LjQ4NTliZDVlMmZiYiAxMDA2NDQNCj4gLS0tIGEvY3hsL2xpYi9saWJjeGwuYw0KPiArKysgYi9j
eGwvbGliL2xpYmN4bC5jDQo+IEBAIC0zMDkxLDkgKzMwOTEsNiBAQCBzdGF0aWMgaW50IGN4bF9j
bWRfYWxsb2Nfc2VuZChzdHJ1Y3QgY3hsX2NtZCAqY21kLCB1MzIgY21kX2lkKQ0KPiDCoMKgwqDC
oMKgwqDCoMKgc3RydWN0IGN4bF9jb21tYW5kX2luZm8gKmNpbmZvID0gJnF1ZXJ5LT5jb21tYW5k
c1tjbWQtPnF1ZXJ5X2lkeF07DQo+IMKgwqDCoMKgwqDCoMKgwqBzaXplX3Qgc2l6ZTsNCj4gwqAN
Cj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFxdWVyeSkNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAtRUlOVkFMOw0KPiAtDQo+IMKgwqDCoMKgwqDCoMKgwqBzaXplID0gc2l6
ZW9mKHN0cnVjdCBjeGxfc2VuZF9jb21tYW5kKTsNCj4gwqDCoMKgwqDCoMKgwqDCoGNtZC0+c2Vu
ZF9jbWQgPSBjYWxsb2MoMSwgc2l6ZSk7DQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIWNtZC0+c2Vu
ZF9jbWQpDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGI3M2U0ZTAzOTBhYWU4MjJiYzkxYjhi
ZjcyNDMwZTZmMGU4NGQ2NjgNCj4gY2hhbmdlLWlkOiAyMDIzMDIwMS11cGRhdGVfcXVlcnktYWQy
ODQ1YmExOTdhDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQoNCg==
