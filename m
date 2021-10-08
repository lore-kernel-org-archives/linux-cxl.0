Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2FFC433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Oct 2021 20:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8751361040
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Oct 2021 20:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhJHUWz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:22:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:60890 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhJHUWz (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 8 Oct 2021 16:22:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="207391262"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="207391262"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 13:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="546326061"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga004.fm.intel.com with ESMTP; 08 Oct 2021 13:20:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 8 Oct 2021 13:20:57 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 8 Oct 2021 13:20:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 8 Oct 2021 13:20:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 8 Oct 2021 13:20:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3IO0hEUo3Xl7mjSrUnXzxXoWMGe0emfxP2UZIYNS6SUNBGSDnxa79l8gu8CBBoJX+MwhqHfLrReTLVP6MvFG7PT1AbNJNSHaQxRxh+arza78V5/KRYLwYVRXXXgPBqzUIkShDCj9JpYBpX+PVPgh1lfdMUbuoLgwEaDpQfzs3Eyi8IgsgCEKVw2q0Fk2oZD47iFEiia/vwCwCUhnny03a1G9GWxQi2VKwoB1xjJiHJBrDosoMYIvf4qvKEk7/Dmo+6bcrXmsJw4LsbrZzf8AWct+2+UyCmj/0CYLuerL3WWM/41TnSoLAyU1TWsjNoJG/POH2vUSzx6w5J22pwmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMDl5tjBJxh85GoUJG1RLduE0JjVomehl0IMt1LCLrg=;
 b=bAa03qm+47DSHFdApRbu8ZA8r23eE+7XIQYwmoR8bH1QojujXXUsTmZpsyuFBSQ35sxiw0hCEXpCc7AQztf/pJdIxMLdx/nxvYHb4+aDtoamAVQNKb0+xLuSl1cdi1qkXA49b3OMT7X9gawGAiyAnKMxNCSwQk7jpIB6JNCBWfgGPEXgcHKMuQQM26A1icnjJRdpPjSvfaIdHRAV2sJ8QlfZ9Que6Gbu0qsQ3/+YmoztUGaU4O/maSsv58mTx92yFnYQqQOFE9QvQAQdNzMmoi9Kp4RFU/1vWqJ1mptgYR7bCauqqKkp29j3+7zprEZE4csm39oc2COBM1gnFaXr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMDl5tjBJxh85GoUJG1RLduE0JjVomehl0IMt1LCLrg=;
 b=KqZAuzReDeGm9FK2RzM3DiKtokTNyRDClylT14UtE+rLCmLN4ejh25iROUwNyiAPBzDWNMu0n6MBzo9Wv55/3hXirIy1W/YA/enNJe5xxF4B3iW0AoIBLiGlvboZvqtQYqM20j+9uGy9v0h/FQ3F4bIEzeTZm57bLgpMAvFx7W0=
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MN2PR11MB3677.namprd11.prod.outlook.com (2603:10b6:208:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 20:20:53 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d8a5:47b2:8750:11df]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d8a5:47b2:8750:11df%7]) with mapi id 15.20.4587.020; Fri, 8 Oct 2021
 20:20:53 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "john@jagalactic.com" <john@jagalactic.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "johnny.li@montage-tech.com" <johnny.li@montage-tech.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "jgroves@micron.com" <jgroves@micron.com>
Subject: Re: CXL 1.1 Support Plan
Thread-Topic: CXL 1.1 Support Plan
Thread-Index: AQHXjeOyDbo/H0Y69E21FQB9XsVm96ts2ugAgDVln4CAAEkWAIABn6OAgAAG9ICAGUX1gIAK8xOAC6QrG2v/pF2dgA==
Date:   Fri, 8 Oct 2021 20:20:52 +0000
Message-ID: <b9fddf71e17902af1326b3242d4f3d899754e674.camel@intel.com>
References: <YT9kSHU+P5wrnm2S@BigDog.local>
          <CAPcyv4gY7UvT7fkCcvxGwe7-s6r40rFExwLN2oc7xBtMGdRyAw@mail.gmail.com>
          <0100017bdf9fcce1-400920ad-2274-4d39-b45e-45410426db50-000000@email.amazonses.com>
          <dd56f465-560e-9408-d7e6-9f8de59bc792@jagalactic.com>
          <CAPcyv4hjD=1EEAkjx+r3DRxASCGpF45kOyOZVULsMDekyG6TYQ@mail.gmail.com>
          <0100017be5e140c0-cedfdc46-26b6-4009-899f-8dfb2268af2e-000000@email.amazonses.com>
          <CAPcyv4g-t_kY84TSq6WbWP96hjOupXx1KYtB9XznQ4y2NooXWw@mail.gmail.com>
          <2093cae0-ff0b-1d6d-2ff2-ba1bb41510af@jagalactic.com>
          <0100017c38c8cbb1-c0632347-44dd-44a4-b6c2-4e33c2ba85e8-000000@email.amazonses.com>
          <8a9b94becf407e218a544d3d0d9286ec4c698099.camel@intel.com>
          <945a5996-961e-a159-2168-8da355b6d945@jagalactic.com>
         <0100017c61378e14-5efea3be-ca28-476b-bc64-4512c44dba50-000000@email.amazonses.com>
In-Reply-To: <0100017c61378e14-5efea3be-ca28-476b-bc64-4512c44dba50-000000@email.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: jagalactic.com; dkim=none (message not signed)
 header.d=none;jagalactic.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81441a5d-9569-4edc-ecc6-08d98a992091
x-ms-traffictypediagnostic: MN2PR11MB3677:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB36778EBCF88EA01E3DCECA15C7B29@MN2PR11MB3677.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pO+jzP25vlwdoth8jFkHRETyDJQFMucWzsiHNi3L7zONIkUQnKZpAO4MBGFoS5qwWbOcLiXnZD0SlsjgDarBRCUE1BuK+Z6Y6Qa+43423Yi14hwd9BIhIGljbCetXSHdFv4geDoYnkiKviakKnU3Auxfz8uoGUSr9gtp25J9a0IaX020MKx6Zo6uQTpGuSNoFhGUJ+tHZnKw0h9RPT2SlWr29OEQpYLt8x7gcR4yqp0+gcIkelsHmne56ReC5D84daTy8FYnYkzaNzrUXE3gXDx0rMQp5ikRtOI8zcxHeE/CyuCYPKBCK/+NfaH3iT9pAmXQR76KTf1Ap5eMuLHCU5u70UCLSm7vmJ9ZnOpUeYu2OBCE1bY66iknM32nUT5TSLNWW3w+mI8X1CjMATZ7yh0faWfb7GTJPn8ewgjWWP54sO6KTJJ3AI9xo5+Dk5XiuP2gO0nQdW4+WfJOUYPDcKD2E9jQeyUMHvYRGhNegFmb8TchA4j+eoLtMCusAgeGJX9MXkXVHOLVAKjZuOk7royvIWz2Pf0MNXdAloUp8YG7KxHmgHxj+MEOrsvCHqVh0XQ+up65ciWICINtCBKHSxWkEQ/mgwsXl6vCjguYYXc4yukMB73jhuO6p6idSizTE2uypFK1qMVC9U6HnnNlUbpu9eiUbHb3riA+c6mqtvBFGE3DGUjZC0sasWd43InL2jmTEZEX7tIVJu8LYReEjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(76116006)(508600001)(8676002)(83380400001)(2616005)(4326008)(38070700005)(6506007)(7116003)(5660300002)(26005)(6636002)(54906003)(6512007)(122000001)(86362001)(38100700002)(66556008)(8936002)(66446008)(66946007)(6486002)(64756008)(53546011)(186003)(71200400001)(66476007)(36756003)(2906002)(110136005)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1lReVdnc0hZaXpYUXdLT1hjK25BYy8xRklsNStHYzQwT3hKZ1JNV3lVekx3?=
 =?utf-8?B?K0x2Rk51VzNHTDlmS2xHK2FCMnhYSGw5cG9haTNxUnA3N0tyc085bGpiayth?=
 =?utf-8?B?c3RoQjB0azFJbk9jTElPbFVyeWpWdHMyUGtSUTNYTHEzWTUrTm80WEMvcStt?=
 =?utf-8?B?RHk4VVFoNCt3QkRKcVRUVGV0K0Y4TGxxaW5adisvTUwzQklnNzhDUXdBN0tF?=
 =?utf-8?B?d3k1ZStIamRjYm1EOU9EOHNJS1pxYmdUV0hoeldQWGRPWUpMYmlwaWhYYWtU?=
 =?utf-8?B?Z1JlL0I0Rk5NRXNndGdmU2t5UFlEOFNnQlFKTDlScEpvbUxxWVRFeVFVcFpo?=
 =?utf-8?B?dzZwdzBsTGVvWUdIbUFCMUEvMVEwYXYvbzhUeFJuMTFhNmdQUFBsR1ZKNXcv?=
 =?utf-8?B?ZmFHQmhZc1FmQmlkcmxjQXo0K1pENkFtMFBFUlhUd1BuK0dadWJ0cTNWNEhN?=
 =?utf-8?B?RGV6Nk5zZ2FIdE80T2VBcXpmV0EwdHN4ZkxsT1p0Wk5nNEZHTVQ2YmNvcGFp?=
 =?utf-8?B?SDJwbmJub2lRaU1USHZIcFVTTFYvYlkyaFBCM3FqNUFSZHk0T1pPRCs5bUxC?=
 =?utf-8?B?MXNZaWJBc2Z3bkQxcWl0Rk1JL0tSR0RZWnhUbFNkVXByUUduZEVVQTZqOHZo?=
 =?utf-8?B?NzdNU0JSTUxCbktZd3B5Ulo5Nk9HaU5PU1F5Z0htUytRVC9kWnAyREc5eEsy?=
 =?utf-8?B?eDdRTTBMOHFPWkNzZkcyZ2tIRy9qZlRzRzgzL1N6UGhTVUpWNS9mSWJwQ05F?=
 =?utf-8?B?WEpWSFB6REVQcSszT0MweS9LN21UYWlvaksyRFBhVUE3YUdwUmNZUVkxQ1pS?=
 =?utf-8?B?Q2VDWU9JdU8vME5jekE5M1RMTVZTaUUrRXRpSUhiRlRBVkkxTTZBQ1J0R01l?=
 =?utf-8?B?VXNaQWVaRjMvOUNJMWw5QS8vWW5MOXhMc2xGK3RpY2g1dGY3ZWJXY3V6bUdQ?=
 =?utf-8?B?ZlJHcFMzbUJ3bVpiS09TWUQzdG5NWXludjhPYjFnL3BkMk9QbHFXL0lmazR1?=
 =?utf-8?B?bTFFKzB5V2RQckNHZzRXMzNISU9JeVVTajFhVTdtTWl1Zit6OFduSGxPT3li?=
 =?utf-8?B?NzRVQlNyQkUzTS9EQVE3SVB4NjhiSkpRS1EvY3J6VlVDUU9tOVNnY21VU0RB?=
 =?utf-8?B?WkVrNVZUUkkwanRHbWVtdTlUN1N3K1R4ckpFY0ZwNUViNzB1U2JwMmJ6MU5v?=
 =?utf-8?B?TmplTzdCUFRsTzBjYWs1anNrZEhyZ1NqaklzYmVEWXp2WEtEYnp1UFF2Zndh?=
 =?utf-8?B?L1kxOE5vODIrMEMybWx6U0lnTStBY0h3aFg4NUo4SkxWNFJSRndYczh4dGhv?=
 =?utf-8?B?cU5sdktwN0dUVWZEN0VNVFgrRzQzTzA3RHE1S0p2MWJXODJiTnBXR2ZtcVUx?=
 =?utf-8?B?dDh0U01iV3VRc3NzanR5TDFjblIxM2FoeFpwNVZlV2ZiZ1c0S0xpdUx0WW1L?=
 =?utf-8?B?bGlKakFsakhnV3h1YWFoUzRUaHRVWnhMQ3pNVWNLV1dKc1FxWEN5VVBHRWFT?=
 =?utf-8?B?WEc3cUtLTVJRVnVlcG9YN2pEOFozQkFGK04wbUxyditKWTFjTm5YNU1yL2tW?=
 =?utf-8?B?a3ZUZ3RlaG15S1BSeWU1UnNiNDFDNFEzaVJBOWxPeUpCMFNIWC9uRlVzUHNM?=
 =?utf-8?B?Y04vR1FZTDZZWjN5SWZ1QzZVcTk5bnZGOFo1b3g1Qm4wL2hjQStycStkQnF1?=
 =?utf-8?B?QnBqd3dhT3ZkZHRFOGpwdmlQdFRac2IrQVo2ZmU0VkZYdnd4SXJ4Y2lvQ3la?=
 =?utf-8?B?am1WNXVRdGVPMmNKNFRPUk5rOE9yR1hTRHZxZng0VW95eFN5SHh6WUhKdDM4?=
 =?utf-8?B?L0pXRnZpYUNuVlRyaEVidz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB18FFF0B1E80C42A888140803E096C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81441a5d-9569-4edc-ecc6-08d98a992091
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 20:20:52.9470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqEN+STOIKcyFYRT/DmQVz7igB2Rj2SyY1k28R2kmQP3GRPc9qdwNG206zdab0lKAOJ+BkzmUYi/g3rzYzhskQ2jpnoRYCEf1qkEdD4EyZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3677
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTA4IGF0IDE4OjQzICswMDAwLCBKb2huIEdyb3ZlcyB3cm90ZToNCj4g
T24gMTAvNy8yMSA0OjMwIFBNLCBWZXJtYSwgVmlzaGFsIEwgd3JvdGU6DQo+ID4gT24gVGh1LCAy
MDIxLTA5LTMwIGF0IDIyOjE3ICswMDAwLCBKb2huIEdyb3ZlcyB3cm90ZToNCj4gPiA+IEkgZG9u
J3Qgc2VlIHlvdXIgZG9jIHBhdGNoIHlldCBpbiB0aGUgbmRjdGwgcmVwbywgYnV0IEkgcmVjb21t
ZW5kIG1lcmdpbmcgaXQgdGhlcmUuDQo+ID4gPiANCj4gPiA+IEEgcmVsYXRlZCBxdWVzdGlvbjog
ImRheGN0bCByZWNvbmZpZ3VyZS1kZXZpY2UgLS1tb2RlPXN5c3RlbS1yYW0gLi4uIiB3b3JrcyBm
b3IgbWUsDQo+ID4gPiB3aXRoIC0tZm9yY2UsIGJ1dCBnb2luZyB0aGUgb3RoZXIgd2F5ICgtLW1v
ZGU9ZGV2ZGF4KSBmYWlscy7CoCBCdXQgYSByZWJvb3QgcHV0cyBpdCBiYWNrDQo+ID4gPiBpbnRv
IGRldmRheCBtb2RlIHJlZ2FyZGxlc3Mgb2YgdGhlIHByZS1ib290IHNldHRpbmcgKGkuZS4gLS1t
b2RlPXN5c3RlbS1yYW0gcmV2ZXJ0cw0KPiA+ID4gYmFjayB0byBkZXZkYXggb24gcmVib290KS4N
Cj4gPiBPaCwgSSdtIGEgYml0IGNvbmZ1c2VkLiAtLWZvcmNlIG9ubHkgYXBwbGllcyB3aGVuIGdv
aW5nIGZyb20gc3lzdGVtLXJhbQ0KPiA+IHRvIGRldmRheCAtLSBpdCBvZmZsaW5lcyB0aGUgbWVt
b3J5IGZvciB5b3UuIFdpdGhvdXQgZm9yY2UsIHlvdSdyZQ0KPiA+IHJlc3BvbnNpYmxlIGZvciBh
IHByaW9yICdkYXhjdGwgb2ZmbGluZS1tZW1vcnkgZGF4WC5ZJyBzdGVwLg0KPiA+IA0KPiA+IEdv
aW5nIGZyb20gZGV2ZGF4IHRvIHN5c3RlbS1yYW0gc2hvdWxkIG5vdCBuZWVkIC0tZm9yY2UsIGFu
ZCBJIGRvbid0DQo+ID4gdGhpbmsgZm9yY2UgYWN0dWFsbHkgZG9lcyBhbnl0aGluZyB0aGVyZS4N
Cj4gDQo+IEhvcGluZyBJJ3ZlIHN1Y2Nlc3NmdWxseSBkZS1tYW5nbGVkIHRoaXMgbWVzc2FnZS4u
Lg0KPiANCj4gSSBkZWZpbml0ZWx5IG1pZ2h0IGJlIGRvaW5nIHNvbWV0aGluZyB3cm9uZy7CoCBI
ZXJlIGlzIGEgInR5cGVzY3JpcHQiLg0KPiANCj4gIyBncmVwIGRheCAvcHJvYy9pb21lbQ0KPiDC
oCDCoMKgODgwMDAwMDAwLTEwN2ZmZmZmZmYgOsKgKmRheCowLjANCj4gDQo+ICMgbHMgLWFsIC9k
ZXYvZGF4MC4wDQo+IGNydy0tLS0tLS0gMSByb290IHJvb3QgMjUyLCAyIE9jdMKgwqA4IDEzOjE0
IC9kZXYvZGF4MC4wDQo+IA0KPiAjIG51bWFzdGF0DQo+IMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqDCoG5vZGUwDQo+IG51bWFfaGl0wqDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoMKgMjY5ODk0OQ0KPiBudW1hX21pc3PCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oMKgMA0KPiBudW1hX2ZvcmVpZ27CoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqAwDQo+IGlu
dGVybGVhdmVfaGl0wqDCoCDCoCDCoCDCoCDCoCDCoMKgMTQ1NjUNCj4gbG9jYWxfbm9kZcKgwqAg
wqAgwqAgwqAgwqAgwqAgwqDCoDI2OTg5NDkNCj4gb3RoZXJfbm9kZcKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqDCoDANCj4gDQo+ICMgZGF4Y3RsIHJlY29uZmlndXJlLWRldmljZSAtLW1v
ZGU9c3lzdGVtLXJhbSAtLXJlZ2lvbj0wIGRheDAuMA0KPiBkYXgwLjA6IGVycm9yOiBrZXJuZWwg
cG9saWN5IHdpbGwgYXV0by1vbmxpbmUgbWVtb3J5LCBhYm9ydGluZw0KPiBlcnJvciByZWNvbmZp
Z3VyaW5nIGRldmljZXM6IERldmljZSBvciByZXNvdXJjZSBidXN5DQo+IHJlY29uZmlndXJlZCAw
IGRldmljZXMNCg0KQWggeWVzIC0gc28gdGhpb3MgcG9pbnRzIHRvIGVpdGhlcg0KDQogIENPTkZJ
R19NRU1PUllfSE9UUExVR19ERUZBVUxUX09OTElORT15DQoNCm9yIA0KDQogICQgY2F0IC9zeXMv
ZGV2aWNlcy9zeXN0ZW0vbWVtb3J5L2F1dG9fb25saW5lX2Jsb2NrcyANCiAgb25saW5lDQoNCmRh
eGN0bCB3YW50cyB0byBvbmxpbmUgdGhlIG5ldyBtZW1vcnkgaW4gWk9ORV9NT1ZBQkxFIGJ5IGRl
ZmF1bHQsIGJ1dA0KZWl0aGVyIG9mIHRoZSBhYm92ZSB3b3VsZCByYWNlIGRheGN0bCB0byBvbmxp
bmUgaXQgaW4gWk9ORV9OT1JNQUwgLQ0KdGhhdCdzIHRoZSB3YXJuaW5nIHlvdSBnb3QgYWJvdmUu
IA0KDQo+IA0KPiAjIGRheGN0bCByZWNvbmZpZ3VyZS1kZXZpY2UgLS1tb2RlPXN5c3RlbS1yYW0g
LS1yZWdpb249MCAtLWZvcmNlIGRheDAuMA0KPiANCj4gZGF4MC4wOg0KPiDCoMKgV0FSTklORzog
ZGV0ZWN0ZWQgYSByYWNlIHdoaWxlIG9ubGluaW5nIG1lbW9yeQ0KPiDCoMKgU29tZSBtZW1vcnkg
bWF5IG5vdCBiZSBpbiB0aGUgZXhwZWN0ZWQgem9uZS4gSXQgaXMNCj4gwqDCoHJlY29tbWVuZGVk
IHRvIGRpc2FibGUgYW55IG90aGVyIG9ubGluaW5nIG1lY2hhbmlzbXMsDQo+IMKgwqBhbmQgcmV0
cnkuIElmIG9ubGluaW5nIGlzIHRvIGJlIGxlZnQgdG8gb3RoZXIgYWdlbnRzLA0KPiDCoMKgdXNl
IHRoZSAtLW5vLW9ubGluZSBvcHRpb24gdG8gc3VwcHJlc3MgdGhpcyB3YXJuaW5nDQoNCkkgZ3Vl
c3MgdGhlIGZvcmNlIGRvZXMgd29yayBpbiB0aGlzIGNhc2UgOikNCg0KPiBkYXgwLjA6IGFsbCBt
ZW1vcnkgc2VjdGlvbnMgKDI1NikgYWxyZWFkeSBvbmxpbmUNCj4gWw0KPiDCoMKgew0KPiDCoCDC
oMKgImNoYXJkZXYiOiJkYXgwLjAiLA0KPiDCoCDCoMKgInNpemUiOjM0MzU5NzM4MzY4LA0KPiDC
oCDCoMKgInRhcmdldF9ub2RlIjoxLA0KPiDCoCDCoMKgImFsaWduIjoyMDk3MTUyLA0KPiDCoCDC
oMKgIm1vZGUiOiJzeXN0ZW0tcmFtIiwNCj4gwqAgwqDCoCJvbmxpbmVfbWVtYmxvY2tzIjoyNTYs
DQo+IMKgIMKgwqAidG90YWxfbWVtYmxvY2tzIjoyNTYsDQo+IMKgIMKgwqAibW92YWJsZSI6ZmFs
c2UNCg0KVGhpcyBpbmRpY2F0ZXMgdGhhdCB0aGUgbmV3IG1lbW9yeSB3ZW50IGludG8gWk9ORV9O
T1JNQUwuDQpUaGF0IGNhbiBtYWtlIGl0IGhhcmQgdG8gY29udmVydCBiYWNrIHRvIGRldmRheCwg
YnV0Li4NCg0KDQpbc25pcF0NCg0KPiBTdGFydGluZyBpbiB0aGUgc3RhdGUgd2hlcmUgSSBsZWZ0
IG9mZiBhYm92ZToNCj4gDQo+ICMgZGF4Y3RsIHJlY29uZmlndXJlLWRldmljZSAtLW1vZGU9ZGV2
ZGF4IGRheDAuMA0KPiBlcnJvciByZWNvbmZpZ3VyaW5nIGRldmljZXM6IERldmljZSBvciByZXNv
dXJjZSBidXN5DQo+IHJlY29uZmlndXJlZCAwIGRldmljZXMNCj4gDQo+ICMgZGF4Y3RsIHJlY29u
ZmlndXJlLWRldmljZSAtLW1vZGU9ZGV2ZGF4IC0tZm9yY2UgZGF4MC4wDQo+IGxpYmRheGN0bDog
b2ZmbGluZV9vbmVfbWVtYmxvY2s6IGRheDAuMDogRmFpbGVkIHRvIG9mZmxpbmUgL3N5cy9kZXZp
Y2VzL3N5c3RlbS9ub2RlL25vZGUxL21lbW9yeTI3Mi9zdGF0ZTogRGV2aWNlIG9yIHJlc291cmNl
IGJ1c3kNCj4gZGF4MC4wOiBmYWlsZWQgdG8gb2ZmbGluZSBtZW1vcnk6IERldmljZSBvciByZXNv
dXJjZSBidXN5DQo+IA0KPiBlcnJvciByZWNvbmZpZ3VyaW5nIGRldmljZXM6IERldmljZSBvciBy
ZXNvdXJjZSBidXN5DQo+IHJlY29uZmlndXJlZCAwIGRldmljZXMNCj4gDQo+ICMgZGF4Y3RsIG9m
ZmxpbmUtbWVtb3J5IGRheDAuMA0KPiBkYXgwLjA6IDQgbWVtb3J5IHNlY3Rpb25zIGFscmVhZHkg
b2ZmbGluZQ0KPiBsaWJkYXhjdGw6IG9mZmxpbmVfb25lX21lbWJsb2NrOiBkYXgwLjA6IEZhaWxl
ZCB0byBvZmZsaW5lIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMS9tZW1vcnkyNzIvc3Rh
dGU6IERldmljZSBvciByZXNvdXJjZSBidXN5DQo+IGRheDAuMDogZmFpbGVkIHRvIG9mZmxpbmUg
bWVtb3J5OiBEZXZpY2Ugb3IgcmVzb3VyY2UgYnVzeQ0KPiBlcnJvciBvZmZsaW5pbmcgbWVtb3J5
OiBEZXZpY2Ugb3IgcmVzb3VyY2UgYnVzeQ0KPiBvZmZsaW5lZCBtZW1vcnkgZm9yIDAgZGV2aWNl
cw0KDQpUaGlzIGNvbmZ1c2VkIG1lIGEgYml0IC0gSSB3b25kZXIgaWYgJ2RheGN0bCBvZmZsaW5l
IG1lbW9yeScgY2xhaW1pbmcNCnRoYXQgaXQgaXMgYWxyZWFkeSBvZmZsaW5lIGlzIGEgYnVnLCBh
cyBhIHN1YnNlcXVlbnQgcmVjb25maWd1cmUgdGhlbg0Kc2F5cyAnZmFpbGVkIHRvIG9mZmxpbmUu
LicNCg0KV2hhdCBpcyB0aGlzIHJhbmdlIGJhY2tlZCBieT8gTW9zdCBvZiB0aGUgdGVzdGluZyBJ
IGRpZCB3aXRoIHRoaXMgd2FzDQp1c2luZyBhIHBtZW0gZGV2aWNlIHRoYXQgZ2V0cyBpdCdzIG93
biAndGFyZ2V0X25vZGUnIChpLmUuIHRoZSBuZXcNCm1lbW9yeSBlbmRzIHVwIGluIGEgbmV3IG51
bWEgbm9kZSBvZiBpdHMgb3duKS4NCg0KSWYgeW91IGNhcnZlIG91dCBtZW1vcnkgdXNpbmcgbWVt
bWFwIG9yIGVmaV9mYWtlX21lbSwgSXQgd291bGQgZW5kIHVwDQpnZXR0aW5nIGhvdHBsdWdnZWQg
aW50byBhbiBleGlzdGluZyBudW1hIG5vZGUuIEkgd29uZGVyIGlmIHRoYXQgY2F1c2VzDQpwcm9i
bGVtcyB3aXRoIHRoZSBob3QtdW5wbHVnLiBMZXQgdGFrZSBhbm90aGVyIGxvb2sgYXQgdGhpcy4N
Cg0KPiANCj4gIyBkYXhjdGwgb2ZmbGluZS1tZW1vcnkgLS1mb3JjZSBkYXgwLjANCj4gwqAgRXJy
b3I6IHVua25vd24gb3B0aW9uIGBmb3JjZScNCj4gwqB1c2FnZTogZGF4Y3RsIG9mZmxpbmUtbWVt
b3J5IDxkZXZpY2U+IFs8b3B0aW9ucz5dDQo+IA0KPiDCoCDCoCAtciwgLS1yZWdpb24gPHJlZ2lv
bi1pZD4NCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmlsdGVyIGJ5
IHJlZ2lvbg0KPiDCoCDCoCAtdSwgLS1odW1hbsKgwqAgwqAgwqAgwqAgwqDCoHVzZSBodW1hbiBm
cmllbmRseSBudW1iZXIgZm9ybWF0cw0KPiDCoCDCoCAtdiwgLS12ZXJib3NlwqDCoCDCoCDCoCDC
oMKgZW1pdCBtb3JlIGRlYnVnIG1lc3NhZ2VzDQo+IA0KPiDCoA0KPiANCj4gSSBoYXZlIHRvIHJl
Ym9vdCB0byBnZXQgYmFjayB0byBkYXggbWVtb3J5LCB0aG91Z2ggaXQncyB2ZXJ5IHBvc3NpYmxl
IHRoYXQgbXkNCj4gW3F1ZXN0aW9uYWJsZV0gZG9jIHJlYWRpbmcgc2tpbGxzIGFyZSBhdCBmYXVs
dC4NCj4gDQo+IFRoYW5rcywNCj4gSm9obg0KPiANCj4gDQo+IA0KPiANCj4gDQo+IA0KDQo=
