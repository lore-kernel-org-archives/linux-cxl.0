Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C365EC433B4
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 20:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C81261355
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 20:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhETU4f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 16:56:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:17764 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhETU4f (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 20 May 2021 16:56:35 -0400
IronPort-SDR: kKYINynf/rBFHxsEUr8tpbFkZpMPeO6dcDn2NhlAoqISv3nBwa2BPOQfejv9apQM4cLIqdnE2c
 UAfjK+SWc0qg==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="265248876"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="265248876"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 13:55:13 -0700
IronPort-SDR: AHFH9rODGCKQysqw/nlJERHjHm0bZh6KoIqCA9p0+8chSf9e1BFHTb93B5jXEgoW/TGodFZCYw
 Zi/jQaQFj8lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="628351116"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 20 May 2021 13:55:13 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 20 May 2021 13:55:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 20 May 2021 13:55:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 20 May 2021 13:55:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 20 May 2021 13:55:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlMAbx4dlw1wPBx9jDzi/RVVzaQw3XqdWhENReUUuH/1XxYdfQS+WnRyreDjRjDogKnoVHpSuMs9aAga7iC6Ntja+P9ieGYRWqwdG2w7qwv2a1hd+Qi8D83gvWyz0PTaU2qu58krLufDId5KMf5RwLw3VJSLoxH3gCyDDgkP/ZrJ+zj8PzZxAlwbYZMNL9H/WwGMIfru6Tt1Ufmm/d40VyM2QM3AL7qplWACDB0VgdFpHsciY4mCs6+fpPrLSYNJlkTobNlv4aqZojyukrgA8bhl98uPV0y+R4pzcy9y9Z2T7xPMSoq9U4Hthu8M9EMufUT/vuMkPjCQvyGa6MjQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqBadgU+MuyWPW1BOfKk4gLB9LIM77XUpD9SMhy3+O8=;
 b=oShpguF4PqBHRKA4a9M85t6jWIY37L0unA4melcazC4stLrQvZYciwmeFAGXk/omSQ3H/AG0c1lxmlMpf9JByBcfkZCe14GCG1DUTSDUck2jSVYfNNFNk8rCGFVZksPkNq2KQz+OlJuYlCkSxCADPGjpO8rXE2Ah6Q7C2+hBky4DnlWyGFU7mpA6hdTzSs9iC9X5NIaV8eLJl4ddSJItvCBvZR9OrrIIB/dT9ZFd9YlIioJdeQGp/pw3HrF042tbaA0JWb2czCoh0AdlAkKMMa6GMWEjGuHaovVNULttiPko5/qxdb+rGcDr6dEJuGiAqIMZ4CruBmCwut1xlCmFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqBadgU+MuyWPW1BOfKk4gLB9LIM77XUpD9SMhy3+O8=;
 b=yE9eGbXrNkr653h+KBZRd57Z7+QgEcn4maM+P7ucByrbwBakM7PP6ER1FqrebP9TBdJbmvf4IyZc8fLX8d41fKomr45xcOpp1zXF8W+pKHCL/SsxS26CJM3ptkm908mgpvpuJqEYrPvxLrXkRADFSvzjMrKx4SFpPD3tqb4lIKQ=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2679.namprd11.prod.outlook.com (2603:10b6:a02:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 20:55:02 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc%5]) with mapi id 15.20.4129.035; Thu, 20 May 2021
 20:55:02 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/mem: Demarcate vendor specific capability IDs
Thread-Topic: [PATCH] cxl/mem: Demarcate vendor specific capability IDs
Thread-Index: AQHXTbmXorLRBWUvckuN7dT1FcmRBKrs2VmA
Date:   Thu, 20 May 2021 20:55:02 +0000
Message-ID: <f4872a54444d3eb8857b704f14517b530b803c33.camel@intel.com>
References: <20210520204852.1070780-1-ben.widawsky@intel.com>
In-Reply-To: <20210520204852.1070780-1-ben.widawsky@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 (3.40.1-1.fc34) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01fc0752-7444-44ff-e05c-08d91bd189ea
x-ms-traffictypediagnostic: BYAPR11MB2679:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2679173A3CA21947470AEEEAC72A9@BYAPR11MB2679.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GIWNErP9ELPumTQ53p/AcuBzEpT/J//3kTZHy+2KnzF5Wfw+aubO+cylRLDe62yWi7ItRNOscPqwM3N6A6Begr+E5lrVnt4JPajF16KNDEpwNbQEuoYxno17ZnbJsYruGmgYrIuZwxr9EE4FMoNQ/MAnBDWSdmgC/9rwmyPkZI//3IV1HYe9GbxeO2rRICG5M1TyPegAxpaFqL4/7Zc0rG1FdNo8QGe2fKXZ88yKE8FDYFYDILfExNubsPXiUFTEr99g8VXw4H8BIbpyH46vN712JKv19gO02fAxaPiHRsfWIjvzjFxpKru0CG/fXfDFfg54RBhkHVvS5OMbE5YJoaFs665V3darS7Ilc8xNstUZNTIceZ3BeYbDZgPMQ6KTFbo+v6TYwfDSl3iiCV14PN/UwEPzEFJuQV89YD4YdkQCgr9+WzVySFXojDUehcj3G+w2+7O4Hrr+KKK/F65vIPZq7NCaJKp3TJ4QBKwOQDMU3tAH7/uMzUg3bOF3XmXnu1g6B9cLL71jjRPJvJ3fu+V0WUTE9U6X+8hYHELaQUVybQEXGbI1HKNUo/vM+AmxNSjHpivqNVhuwgYmQ+xtWk9dJ/IHcYd/XsHcBSmxV4c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(39860400002)(376002)(2906002)(6486002)(478600001)(86362001)(66556008)(64756008)(186003)(26005)(66476007)(36756003)(83380400001)(110136005)(66446008)(6512007)(54906003)(38100700002)(2616005)(66946007)(71200400001)(91956017)(8936002)(122000001)(5660300002)(316002)(4326008)(8676002)(76116006)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?azZyTWNZeWM2dHlmbUJuVVJCLzl6U1AybW0yOWRaVkwrWU0rczJXWHhGNXRG?=
 =?utf-8?B?MkNraWF1dkNKWm5tRWM5a1FQZWQwTTdldXk0akQvYWs5RS9xMU1Oa3Mxakpl?=
 =?utf-8?B?RlpTN0lFWUpGK29yakQ1Y0U3K2k1NENQbTlxUElhSEFtNllQaTZINDBuSlI4?=
 =?utf-8?B?WjZld0JzQThLOFlVV0dVYWNXM1ZUTnV1Y3MwVDV3d2QxTXJMR0tLYmlpQ01C?=
 =?utf-8?B?OHZhd3pNQzB1ZUszRVRpbkNzdW9rUUZJOXVYbUlWUXM5Qm1HWXQ1R0haZ0k2?=
 =?utf-8?B?cmNUNG96R1YyWFN1d2RONkR4KzE1by9sS2lnN01NeWxjUExyREFwV1Y0b1lO?=
 =?utf-8?B?QTZzbEU5N291T3pkLzdHclZQYTdnbUxiNUlENERLRllXbGF2KzBoTFU0TzRH?=
 =?utf-8?B?R1MxYkZIU3lENFN6NTZmdWtVb09ML3BLTW9jaDN2aFBJTm5CZnV6RXVUZ2tt?=
 =?utf-8?B?aVlsOEFiZGI1VUxhc1FNaHVLYzdKYmwyRFJ5MkdpdmdmSGhxUnA4SS91Yllp?=
 =?utf-8?B?TVNEOERQNUZYTFBPOFRsaytzNkxCMnFkcE85RktRdFZGUlZDVDI3Umw2TzV1?=
 =?utf-8?B?WXhwM2U3OWlmLzc2NEk1OWlQZ294ZTJEMDQzUlorRTVDb2h0clNGZVdjK04z?=
 =?utf-8?B?UEhaMXdQTm1tRWd0cWZJcDRScUxseXFCNjBOVURWNmtEV3lZVkVmUStmVUpv?=
 =?utf-8?B?WWFRUStHVGdNVXpHbE1VQ1A4akhZbmUvQnpJVXNLSUhFOUdETm5abk1wNmh5?=
 =?utf-8?B?YW9NNmFmK21ZOTRWcEdCTmtzNlBlMG95MFY0cVozS29hU2txUE5WSUpVVzBF?=
 =?utf-8?B?bWNvVUlYTE9nZTFaNU9LaDhkNXlvRzdqUVJVVkpTOVFtOFlpa2RmeGh5bFpB?=
 =?utf-8?B?c0tTQ3pkVUtpRWRTZjJYc3ROaGRpWnQ4WENqNWhIaS9NNDB2REVmS2Z4Zkx3?=
 =?utf-8?B?UzBCWTYyZWo3RzdXYzRzanVVNTB3ODZTK0prU0lDV2V6SzJXSEpRclBwN3RU?=
 =?utf-8?B?SFk5UmxuU3NKaUlIRmZmc0V5MkRJOFg0NngvcjEvR2ppaXdzRmk3RGp4d3kz?=
 =?utf-8?B?WjlESzJaczhKS3hpRHByMkZqOVBpRWlON2FEM2JrTDBCZFdpQS9tUHBHTTdL?=
 =?utf-8?B?Z1pBTHpTejJaS2RzVG9SSlFSRWlaR2xBNXlBMGI2ZWJCOGhLSEQzNmh4bm1E?=
 =?utf-8?B?bmlobU5la2hTNzFCVmxPNlNQMEp4YVNhT252NXZLMU9TUDZvVEpBbVdlUHFs?=
 =?utf-8?B?MFdhSjBLUFVNMjhMam00bHMrVGtoWlJCV1hVMjlUNmI2dXZQb29UWmIyTDlP?=
 =?utf-8?B?YWtHOTdkVTJ1ZDYyY1Y3Q0xuVTRQbERuTmw5VW5VZEhKWVVBaXViaCt6dkEr?=
 =?utf-8?B?MnVDVU5nYTZGbFFZVjBvMXJtdmVHeEh0SUlPYUN5bzhxb3NkUDgvcFU3M1J1?=
 =?utf-8?B?d3V0T0t4Vmo2bVZoRldWS2hZQnVnclZVcUhJekx0aDU2d1R5NnNTY21ESDY4?=
 =?utf-8?B?TGZUdzQrODcvRUNlRjR2ZmNuaitxY2FLK2N4UXIwc2pmNi9aNFhpYWlqTU51?=
 =?utf-8?B?RmhQYkM3L1lwNVkzUFcyMjZBbDlWYXVJKzdBM0ZhNk52UnAxaVhzbmdKeno1?=
 =?utf-8?B?bHYyNnFtSmhXZFdoQ2k2eHpFQUE4cWhCTHZJUlNZZUw3SzhJeXAyTEtmeEcz?=
 =?utf-8?B?aUY1Qlh5WmJpZnZwU1B6SXBkKzh1c1Vvb1FkVlh5dElVdGhkWWRMekQyQjRu?=
 =?utf-8?B?ZDR6Q2hERU5QZk1oN2oyNHNhSXZ1eW1GSGVXMEYzSzc5Y054T3ZURUZ4U2Rz?=
 =?utf-8?B?WFBEUXNGeWdZSitTNzBRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD01B8AC6AC3B9419B02A796BEFAEDDD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fc0752-7444-44ff-e05c-08d91bd189ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 20:55:02.3913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdUHAZL6c9Bo5qiqtM12l+noeq4YV3zIdjGQSIo8OJ8unsXtDLGPrIOXNxWlWKfiZZ77iZai0W/TsQeMveoz2BgeMCHUNrNKXS17caiOvkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2679
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTIwIGF0IDEzOjQ4IC0wNzAwLCBCZW4gV2lkYXdza3kgd3JvdGU6DQo+
IFZlbmRvciBjYXBhYmlsaXRpZXMgb2NjdXB5IDB4ODAwMCB0byAweEZGRkYgYWNjb3JkaW5nIHRv
IENYTCAyLjAgc3BlYw0KPiA4LjIuOC4yLjEgQ1hMIERldmljZSBDYXBhYmlsaXRpZXMuIFdoaWxl
IHRoZXkgYXJlIG5vdCBkZWZpbmVkIGJ5IHRoZQ0KPiBzcGVjLCB0aGV5IGFyZSBhbGxvd2VkIGFu
ZCBub3QgInVua25vd24iLiBDYWxsIHRoaXMgZGV0YWlsIG91dCBpbiB0aGUNCj4gbG9ncyB0byBs
ZXQgdXNlcnMgZWFzaWx5IGRpc3Rpbmd1aXNoIHRoZSBkaWZmZXJlbmNlLg0KPiANCj4gVGhpcyBw
YXRjaCBpcyBhIHNxdWFzaCBvZiB0d28gZWFybGllciBwYXRjaGVzIGFuZCB0YWtlIGluIHNvbWUg
bWlub3INCj4gc3VnZ2VzdGlvbnMgZnJvbSBib3RoIFZpc2hhbCBhbmQgRGFuLg0KDQpTaG91bGQg
dGhpcyBiZSBpbiB0aGUgY29tbWl0IG1lc2FzZ2U/DQoNCj4gDQo+IENjOiBWaXNoYWwgVmVybWEg
PHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBCZW4gV2lkYXdza3kgPGJlbi53aWRh
d3NreUBpbnRlbC5jb20+DQo+IC0tLQ0KDQpPdGhlciB0aGFuIHRoYXQsIGxvb2tzIGdvb2QgdG8g
bWUsDQoNClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNv
bT4NCg0KPiAgZHJpdmVycy9jeGwvY29yZS5jIHwgNSArKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY3hsL2NvcmUuYyBiL2RyaXZlcnMvY3hsL2NvcmUuYw0KPiBpbmRleCA4NGI5MGRiNTc0MjAu
LjM4OTc5Yzk3MTU4ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS5jDQo+ICsrKyBi
L2RyaXZlcnMvY3hsL2NvcmUuYw0KPiBAQCAtNjAsNyArNjAsMTAgQEAgdm9pZCBjeGxfc2V0dXBf
ZGV2aWNlX3JlZ3Moc3RydWN0IGRldmljZSAqZGV2LCB2b2lkIF9faW9tZW0gKmJhc2UsDQo+ICAJ
CQlyZWdzLT5tZW1kZXYgPSByZWdpc3Rlcl9ibG9jazsNCj4gIAkJCWJyZWFrOw0KPiAgCQlkZWZh
dWx0Og0KPiAtCQkJZGV2X2RiZyhkZXYsICJVbmtub3duIGNhcCBJRDogJWQgKDB4JXgpXG4iLCBj
YXBfaWQsIG9mZnNldCk7DQo+ICsJCQlpZiAoY2FwX2lkID49IDB4ODAwMCkNCj4gKwkJCQlkZXZf
ZGJnKGRldiwgIlZlbmRvciBjYXAgSUQ6ICUjeCBvZmZzZXQ6ICUjeFxuIiwgY2FwX2lkLCBvZmZz
ZXQpOw0KPiArCQkJZWxzZQ0KPiArCQkJCWRldl9kYmcoZGV2LCAiVW5rbm93biBjYXAgSUQ6ICUj
eCBvZmZzZXQ6ICUjeFxuIiwgY2FwX2lkLCBvZmZzZXQpOw0KPiAgCQkJYnJlYWs7DQo+ICAJCX0N
Cj4gIAl9DQoNCg==
