Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CC6C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Oct 2021 22:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF15B60EB6
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Oct 2021 22:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhJGWxr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Oct 2021 18:53:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:42440 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231825AbhJGWxq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 7 Oct 2021 18:53:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213332956"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="213332956"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 15:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="657579306"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2021 15:51:51 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 7 Oct 2021 15:51:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 7 Oct 2021 15:51:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 7 Oct 2021 15:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zru3mCmINSxv/mjpnjG6htKli3NgHUE3EbmwcjmObsbLobuFD84cdM6hY8VqALEtzwlr44Sj0jjBUA1HQ51D6fFHzCMKjfOBNwOco2yhWplIRXGsGEutILgo8QSibR4KVkTJR8aUzjRHZzDezLU/wOS6h8UcGkXb7+hV/NHM9Ih/9SwLPH9uSyyU5Xz9mIFUTzD5ILTqBONlCK6hfiV1evJLTwZlihHpdYjYsvWgelFP9cbtdpjplHCUSSIDvinRWC5QIbhFdNIVQa4xi7Ztyi7/094azf3iOvdblP86ih9tyG/hnYncdVtA9xncjUVX39y8DO/7ajBDnuC2+Lue+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxX3KDyhANW5waWknVHN0ZgKCmBsr/Y266p1+IESPe0=;
 b=QsumeLB1z9NoVd37Dxhfb0q1XZaUYnazG8dVw/wCEOO79tQ2lN0hDAWzbqkzLIANM0In8Bscg3RDUJ6oQJ6R4hNgOS5B3eDNwFlGWslbJ44Ajbnsafjl3cWh3JKQYgBbKghwIoSsAeDJUSVI71JIXA9Yo/ni5a3OUnBzYHVxWX8R/5EIppy9uN94MlrmXj2bgK6u8qUlPDVm9ySN02C+o4mL1Xe0xqJbaGl/FaH+oz3MxKnKK5sOHrKTvAiXpfDbdPe9tCdW96q/QDY8E8fTmkSsA+cV9LdQcxSXSvAwkRKjc/nRdxwZcEShAeVah5ZXQITafe0SAxrcC9ac77h1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxX3KDyhANW5waWknVHN0ZgKCmBsr/Y266p1+IESPe0=;
 b=aQn+se5GpHZicljAOH3DWU4rDRjP0yol28XOOKoqkSjJsmcK9K2v49F8ztZOIDyOF6qEzl/zkO+7+AExMCOM7qaJu7aD9QuuW3zN0f1tF0WT/JDaHw/Q0EMUJ1bv4Hi4BzDQQce8aZf57JXETre9et5LgoXFx7KShnfb70Y2d/I=
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by MN2PR11MB3869.namprd11.prod.outlook.com (2603:10b6:208:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 22:51:49 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d8a5:47b2:8750:11df]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::d8a5:47b2:8750:11df%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 22:51:49 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Do not fail cxl_acpi_probe() based on a missing
 CHBS
Thread-Topic: [PATCH] cxl/acpi: Do not fail cxl_acpi_probe() based on a
 missing CHBS
Thread-Index: AQHXu8H5oH2Q3wxsQ062IjgCOCfwIqvIJE0A
Date:   Thu, 7 Oct 2021 22:51:48 +0000
Message-ID: <7e44a7bd8701a6926fbcb6150dd20ed8557d88c4.camel@intel.com>
References: <20211007213426.392644-1-alison.schofield@intel.com>
In-Reply-To: <20211007213426.392644-1-alison.schofield@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d4b9dc8-aa13-42d9-9dd2-08d989e50bf7
x-ms-traffictypediagnostic: MN2PR11MB3869:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3869464C4EC32EB0210CC7DBC7B19@MN2PR11MB3869.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:285;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nl0zr8z6S62yhWOjYwDlwh205kUP0J5rfvpbrFibb7rp8lnaRE+npN6rViADxJd1wBl0rcT+aRoymGChqahbQuKXFAMBeEZ10QQqu0rVXjkkX7/bUoVB9f3QHOhldREQ9URs9CbGLx0/qnGpwQTHevdsRPRFaRzQdCPuY83xRY3+aQSJ12cxC/xaysPmuuywtWPgV2CxFmrMEjlpVRX9NEiJ2NpHBD/iE+z3dMArbm265XzmapAoK98s4ypQO38g6HkOj7YPLJyazcnBwdyR5kqpZwK/Bt6kEJTCPvEJUCTZRGDTAQ4VOXVbxgHGaIHmfsNoN8WHguQLZU+RGMpDLLX4o0G/KHuvIzdQFQ2DLQygeXya79GUHLS8b8w7BrB1UTm4wmn/YKw6k+mhTFBNGRpuOjIMKwVmHMW4tj/8bgjUFFPok+ZoNJrVthhvzxj1fJzJsXWfCpr/A+lkCrz3m30I15A/9WMwHDwQ7SvEdxwjoOFNKQOVVZ0NXJ3iF89hpps7bXcr0NKH3A4I8Bg6V72nA1jZ3iFd4U2ueJsKj0auzIKTF8dj3XW4+9kh7su/ufKMN8WC0HZ5jqnloqDQ8xW9iZR4EDCxKbzetZmAOrri71sHUkZrecIpk5582CbBL96s4UElcAQHTxiIAtNU7vDvLYSntdgTF08UPtfAivNUGx/KWuDSBt/GdXGS7s3C4Qi8YCwBJokkGa4khoXtdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(83380400001)(66556008)(64756008)(71200400001)(91956017)(26005)(186003)(6512007)(66476007)(66446008)(6636002)(122000001)(66946007)(76116006)(6486002)(316002)(110136005)(508600001)(4326008)(38100700002)(2616005)(86362001)(38070700005)(8676002)(5660300002)(8936002)(36756003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3cwOW9tYU92bjRwNnNaamVZSElMTzBrQzdMQyt1cVdrb2l2TFd5RzUxckFy?=
 =?utf-8?B?UWc5b2FaK0hmbGtoZzdOSGgzV21KS0pLekRDbVdzSDdRSkhVbkp4SXFwaDlL?=
 =?utf-8?B?UkZTOHFWZVhSc21qd3FFTkRYaDZoWlM2T3hTQmlFVzBhRTJiRVdESENlcXRi?=
 =?utf-8?B?ZnJGK3hEVG1ucjhSNE9zSjQvVDI3MFF5bHp3ZHFWTzRJZkpPdW1wTG9qWTFa?=
 =?utf-8?B?M0xTV09IZW9KREZIc2RKblQ3VGh0b2ZZRzV5Yjg0VzVNc3IyQW1Wa3VUcGdC?=
 =?utf-8?B?c2JQb3AxTFNOb3grNzRhc3dEaVlqWVlRSVgxWG5keXBrL2JHMHlqNTRXZU92?=
 =?utf-8?B?WE9sUGlVNkN2Rjc3eE1qRmpHMmltNWdzWWJadWx5c3E0eVFHSHpMRS9nYW04?=
 =?utf-8?B?K1pBaG0zYjNBcVVWcXowbXRLSXNwT0p0OXFUNDY4Lys0bTRwa21ETDliZEV3?=
 =?utf-8?B?dEVLOG12cUdnZUhQUjk5V2ZhRVVqZ0lxQ1BuNk1HOHREdGdNUEVhcFc3bUhS?=
 =?utf-8?B?eGFLZlBFUG5kcUUrUkxpZDMzT3ZmSjM1bzZ3UExnb0p6anVZZktuOWpoclVK?=
 =?utf-8?B?WjlwbjVBd1duaXh3ajVVZ1FQK3pOaEJMQ2lKd1RQMWNUdTYvTTYyQldqcHcr?=
 =?utf-8?B?cEJUTktUdW5KNEpWbnRGN1NUZTNvVGNCdVRtbHJ0VlJpNDUrYndPSHp6QzJD?=
 =?utf-8?B?dTlJUVY3RG04bjY2VW5tMjJGekJMNVBacDFWZldGZWpPWEp0aE5TREVJKzlS?=
 =?utf-8?B?RW84Nm5kallKSk9YU2NNQm9MeTFMeFJXTGR3MEc2T0ZleDN1Ukc2MXVsbmNT?=
 =?utf-8?B?STlJWUZoVzdCdHMvZlA2WExhQVNCcGg1OFl0cGd1cW5oY2VPK0FHdmVpZEdx?=
 =?utf-8?B?SVB6V2tTZ05FcTc4RWlVRW12ZW1lL3B1YlVaNEFyM1R5UEdGOFc2aGxGSllJ?=
 =?utf-8?B?SEkvVDgyRmtmbVhvZTlzZmVzZUxCY1YrZ0xYWTUwSHNFNlBQRERISXgvZXVB?=
 =?utf-8?B?MU8rOUpvZ2ZpYnF0LzlNSk5vY082YWFIQ3pHbmhYYUFLUUVQV3d2RHIxcGVp?=
 =?utf-8?B?QUFEa0ZUdWtXTVQ2YjhId1MrTlpITGl6MWJzUW5aOWRnUmVHUkkyemJHU0V3?=
 =?utf-8?B?KzRYOC9pL2t1aGpuR29nb25vL0h6S2dnM3E4d0JsWVdNTjEvWW91Vnd3ZFNt?=
 =?utf-8?B?OXhLNXBTcHZ6QUZZSVhEYTNzQVdxK3RHZ0N4VFh0ZHVTdTBuL3FNWnVqQUE4?=
 =?utf-8?B?TXQrTHZGSy93ek50Z1o5UXN0VExkZTdJeHBNMnhsWVU5T2RHWkpoYXIzZkQ0?=
 =?utf-8?B?cEl1ejJocUJFbWhiT2w5Tk5ldGVYNXE4VGl0Q0FTSVJldEkvUmtpWDd0NkF2?=
 =?utf-8?B?eEpmbUJEcDZEd01aWTY2c0xXTlNRYVo4UTgrcis1L3AxamVBOTlyMlIxRVVt?=
 =?utf-8?B?NXFzNmNzVEN5bWN3TnkwazRBY2FyMjgwc05rQzdCMHV0ZVVxa2x2ZHNQanRa?=
 =?utf-8?B?L2tTamRSSno1NTQ3QXh1UkhxYytyVCtEOCtuYnV2NlVud0o1clBXb0ttekww?=
 =?utf-8?B?dnZRcjR3WjJ0YzA3aStvZFoxZis2NTN4djVPTW1mMEN6UlNIWHFYTzJPeEox?=
 =?utf-8?B?aVYreHpody9heG1NTnhFT3BUdW1qbk9LUGt0MGdqMWlUSEMrbkxMN3RYT3B0?=
 =?utf-8?B?emQ2YjJKZjBwUjBBRkZtRGQwNjNyNFVvU1VyeEJqMU5oQ1Fld1hJN0R0Vy9Z?=
 =?utf-8?B?dU53SkZoZVBWZnZNOXNBKzVsSjVpQUJzRW55b0RsRit2TnEwN1dYQ1dpZG5S?=
 =?utf-8?B?Yk0xTWJiOFI4UTNYUEhwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67547E2150E76543A7419536EEC7967F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4b9dc8-aa13-42d9-9dd2-08d989e50bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 22:51:48.8800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsEcYpaQ2wcg0qyd/xlylwlFcWJXHX8TQFNsIn3EJM85u7lXQ9dxahCgYmAhJCvN42q2FZ4YHX66RmIm4PQJyk/7dvIlL3DInMWtchgZ0uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3869
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVGh1LCAyMDIxLTEwLTA3IGF0IDE0OjM0IC0wNzAwLCBhbGlzb24uc2Nob2ZpZWxkQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVsZEBp
bnRlbC5jb20+DQo+IA0KPiBXaGVuIGFuIEFDUEkwMDE2IEhvc3QgQnJpZGdlIGRldmljZSBpcyBw
cmVzZW50IHlldCBubyBjb3JyZXNwb25kaW5nDQo+IENFRFQgSG9zdCBCcmlkZ2UgU3RydWN0dXJl
IChDSEJTKSBleGlzdHMsIHRoZSBBQ1BJIHByb2JlIG1ldGhvZA0KPiBmYWlscy4NCj4gDQo+IFJh
dGhlciB0aGFuIGZhaWwsIGVtaXQgdGhpcyB3YXJuaW5nIGFuZCBjb250aW51ZToNCj4gY3hsX2Fj
cGkgQUNQSTAwMTc6MDA6IE5vIENIQlMgZm91bmQgZm9yIEhvc3QgQnJpZGdlOiBBQ1BJMDAxNjow
Mg0KPiANCj4gVGhpcyBlcnJvciBtYXkgb2NjdXIgb24gc3lzdGVtcyB0aGF0IGFyZSBub3QgY29t
cGxpYW50IHdpdGggdGhlDQo+IEFDUEkgc3BlY2lmaWNhdGlvbi4gQ29tcGxpYW50IHN5c3RlbXMg
aW5jbHVkZSBhIENIQlMgZW50cnkgZm9yDQo+IGV2ZXJ5IENYTCBob3N0IGJyaWRnZSB0aGF0IGlz
IHByZXNlbnQgYXQgYm9vdC4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogSXJhIFdlaW55IDxpcmEud2Vp
bnlAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlzb24gU2Nob2ZpZWxkIDxhbGlzb24u
c2Nob2ZpZWxkQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2N4bC9hY3BpLmMgfCAxMCAr
KysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KDQpUZXN0ZWQgd2l0aCBhIG5vbi1jb21wbGlhbnQgc3lzdGVtLCBhbmQgd29ya3MgYXMg
ZXhwZWN0ZWQgKHJlbWFpbmluZw0Kcm9vdHMgYW5kIGRlY29kZXJzIHN0aWxsIHNob3cgdXApLiBZ
b3UgY2FuIGFkZDoNCg0KVGVzdGVkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGlu
dGVsLmNvbT4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2FjcGkuYyBiL2RyaXZl
cnMvY3hsL2FjcGkuYw0KPiBpbmRleCBhZjFjNmMxODc1YWMuLmRhZGM3ZjY0YjlmZiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9jeGwvYWNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2FjcGkuYw0K
PiBAQCAtMjg4LDcgKzI4OCw3IEBAIHN0YXRpYyBpbnQgYWRkX2hvc3RfYnJpZGdlX3Vwb3J0KHN0
cnVjdCBkZXZpY2UgKm1hdGNoLCB2b2lkICphcmcpDQo+ICAJZHBvcnQgPSBmaW5kX2Rwb3J0X2J5
X2Rldihyb290X3BvcnQsIG1hdGNoKTsNCj4gIAlpZiAoIWRwb3J0KSB7DQo+ICAJCWRldl9kYmco
aG9zdCwgImhvc3QgYnJpZGdlIGV4cGVjdGVkIGFuZCBub3QgZm91bmRcbiIpOw0KPiAtCQlyZXR1
cm4gLUVOT0RFVjsNCj4gKwkJcmV0dXJuIDA7DQo+ICAJfQ0KPiAgDQo+ICAJcG9ydCA9IGRldm1f
Y3hsX2FkZF9wb3J0KGhvc3QsIG1hdGNoLCBkcG9ydC0+Y29tcG9uZW50X3JlZ19waHlzLA0KPiBA
QCAtMzc3LDkgKzM3NywxMSBAQCBzdGF0aWMgaW50IGFkZF9ob3N0X2JyaWRnZV9kcG9ydChzdHJ1
Y3QgZGV2aWNlICptYXRjaCwgdm9pZCAqYXJnKQ0KPiAgCX0NCj4gIA0KPiAgCWNoYnMgPSBjeGxf
YWNwaV9tYXRjaF9jaGJzKGhvc3QsIHVpZCk7DQo+IC0JaWYgKElTX0VSUihjaGJzKSkNCj4gLQkJ
ZGV2X2RiZyhob3N0LCAiTm8gQ0hCUyBmb3VuZCBmb3IgSG9zdCBCcmlkZ2U6ICVzXG4iLA0KPiAt
CQkJZGV2X25hbWUobWF0Y2gpKTsNCj4gKwlpZiAoSVNfRVJSKGNoYnMpKSB7DQo+ICsJCWRldl93
YXJuKGhvc3QsICJObyBDSEJTIGZvdW5kIGZvciBIb3N0IEJyaWRnZTogJXNcbiIsDQo+ICsJCQkg
ZGV2X25hbWUobWF0Y2gpKTsNCj4gKwkJcmV0dXJuIDA7DQo+ICsJfQ0KPiAgDQo+ICAJcmMgPSBj
eGxfYWRkX2Rwb3J0KHJvb3RfcG9ydCwgbWF0Y2gsIHVpZCwgZ2V0X2NoYmNyKGNoYnMpKTsNCj4g
IAlpZiAocmMpIHsNCg0K
