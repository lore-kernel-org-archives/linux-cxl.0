Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE743C433ED
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D75611ED
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhETTzn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 15:55:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:54196 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231917AbhETTzn (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 20 May 2021 15:55:43 -0400
IronPort-SDR: wFUBxE5z7tgLLVF0EksIks8Sl5axJmhGPu5CqT8JQMT/QP0RoF/iM41SLuJh/kKMijiFUZc9n4
 qROR5eEz91iA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188450579"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188450579"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 12:54:21 -0700
IronPort-SDR: WALWlsWk35+fNdEO1rg2mebXy+NpXX7GDZtVLlOAK7JN6VO2qps3wcXEjICj/5f/3sN/2q2fZ/
 e0tTt4Xbx4cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395028255"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 20 May 2021 12:54:21 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 20 May 2021 12:54:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 20 May 2021 12:54:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 20 May 2021 12:54:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpH9BqoSNxsM0KIxC0ogrC4JAeQ0xq+HXbAe00b5PxU53Zm5DNUvAkXJhytwP818PrMVJIVLUYL5Qmj1IZ3RKOc2sQSDEtnfYKNdN5fD/h9/9t+HXruPpi5JkdCyZJPvji3s2Nh9MPUI9onlJ76jhcs/DHEl4feNQ6m4HgcXXJ5px9nRScKyzObmxT28Wat9cF101W3Xx7ib1Bq5gk46Mwd4ZxIqVaWE9bLDxOd2MBsOs0dIDVziaunEZBrLl7zm/LQXRQcg5/OddlfF4Go/EcJ0sReKAZxya+8oAx4xKSj/24u3usHBYpTuTdMnnkZE/yPgoMJZq+cBBK9KiuK1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE8+8SsX74qjumOUxl9EmPdqlyWOV1P8FD+saXfgcz8=;
 b=PnZ3jfpPk11Fr3uGdVwtFNcUM73lTR2aTsfJ08KnhFzCHDY1iD3qwdal2eiRsKxpqq60ekg6oDSwvtqhcDKE+67YUc2KNa2iJHDIaiMdimGbsWseqn+X1iuN9yWwaxFbkSngl63W5BolixFqOYGONlmTLF6oH2O7sTYKi8tY24xic17d7IHkE1RPgh2rsJoNzxGY1yKwW3tuPeBKe+WBsty1WftOuBJ6JTLGR32Z745VgBw7NQCOKeJaHXF27NlOMqyF2plVnzrj/YYaWQ8f5vnHhwtMiO5arWtaLJ0plbMy8HIdnA/AoinrzvV4U5Tsh8Cx+ipw0xqWELMTGcWqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE8+8SsX74qjumOUxl9EmPdqlyWOV1P8FD+saXfgcz8=;
 b=fk8qVgok+Ho783G9+rWa8eAlObq1ea5iZZ0sJTDkLnds9E6EyswfubXqHcuGJH1BAkciT01CCOwd5EtWdwWSDeIGrHQuJGlmCvMZvsVPjHN1I1Wo2tXad6GeEq5cWrcW/nDjRGduvTk1x9jdswfIO+rAR9aGcS289ldXsRnQRBc=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3303.namprd11.prod.outlook.com (2603:10b6:a03:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 19:54:07 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc%5]) with mapi id 15.20.4129.035; Thu, 20 May 2021
 19:54:07 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] cxl/docs: Fix "Title underline too short" warning
Thread-Topic: [PATCH] cxl/docs: Fix "Title underline too short" warning
Thread-Index: AQHXTbGqC/d5baEeXU2vo+31MqmkpKrsyGWA
Date:   Thu, 20 May 2021 19:54:07 +0000
Message-ID: <5b04533c45f14b3d4902265551f077ded546e2c6.camel@intel.com>
References: <162154034053.1995075.17047445540000243300.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162154034053.1995075.17047445540000243300.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 (3.40.1-1.fc34) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68e8104a-677c-43fd-a2e4-08d91bc90799
x-ms-traffictypediagnostic: BYAPR11MB3303:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33030F36EBF69BA8A3FB4344C72A9@BYAPR11MB3303.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AKfI6t1Gq8lRZmGovttQ4n3yI4TfNLvs1oGYYXr1LyP9PRgCn/9wkPcjJkiwgMRRfvkBsCdxYghF41MKnItzDnTQcvltFZcEMa99n2BSZoKEnnD50nI3+gY8ucVWsCxW+l/cT2RgySJU96lqbF8jHgNkXI+3FIGTYgM7aiNAeA2JsKGJOpSWj0orc3boU29JHk9B5EvO0tOZl1XnfQsp9oZh5uGbd3CAvA+w66crkWxXO3sWZ5SncZT4XfZBRGdTCRnbK4NWlI+YdgFiQjD9JXhK/qUkhYAUYfEkO1yUWBj00CBLTOepm6JByptTfRDFfZeuD9JCU3fc2hChUGdSoWZ9hK+4YNmAyhRaUlNujKZfhUa7CWXoXI4iJ3W6QHRo6Fkvg0Vo0emBOW1LjFNQPOiNLdvIpGjoj1bVv+1i31ATtv/zxmk/Q9OtMDuPN7BDDU8cuDie3572zff7cKhPwNggRSnBMZ9elv7ucdKsVry7VoPouCI+e+8xGwyk0rLs3BV/y2tyQO8ZzQZbJtg3m8lC51gT4vCxN60ZJ/vdorHfyAts2xtE8mBbdXlTc+hTpU1rEEjytQBnqdm1n0Ug2yaboqjcAalYVjmeRHNYOKU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(396003)(366004)(136003)(38100700002)(83380400001)(4326008)(86362001)(6512007)(122000001)(66476007)(76116006)(66946007)(66556008)(64756008)(91956017)(66446008)(71200400001)(6486002)(4744005)(110136005)(26005)(6506007)(2616005)(8676002)(5660300002)(8936002)(2906002)(186003)(36756003)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?clZ5M00reXgvSEM0TUk1SHFzT01iczVUdGVldlZuWGZNajg5ckhvNVVqdExV?=
 =?utf-8?B?YnhsQ0F0c09nV09mdFIwczQ3QWZmSDA2UkVCK1RWOWxNSXVvbnlmYlRiSTFv?=
 =?utf-8?B?bkJ3ei8wNzdQL2NxcUNjbnhUVVJWWnN0OWlrM3hudzYxUWlwZndJbzhuSytu?=
 =?utf-8?B?OGhjc0w3V0NjcERuZ2FWT2VWdll2S2ZVUlBRaEEzSWtUVkJPRjY5VzJhMWFK?=
 =?utf-8?B?ZWtYUkduN2hVRzF0aTJsbExGMVJaUkRHbENCY0ozQmpIa0gxbHZrT1lCZTdp?=
 =?utf-8?B?c3d5YUR3a210YjBqT2wzZkpIVjJJUGRhQkl4UTFHanZXTFE1VTFhNW40LzEx?=
 =?utf-8?B?UlcvWGFhSjluVHh5VkEwbW1OMnNpN2IyTU5KV2tYbjcrVlMreCttMmNNN0Vi?=
 =?utf-8?B?TWVDRHdlSVRrVW1CTkovcExBbWRHeFUyT3JxS3dmU002ajV5NmFqQmp3cXVI?=
 =?utf-8?B?Zjh0RnIvOTZsaEx2NFlTWFJlZTNtSTMzK2V2NG1oWHJzamxVWHM0SzlCSE9L?=
 =?utf-8?B?bGFsSnpLNW1xSHR5OEFYYzJ4MVpOMkFhdytkcHQxYUR4NC9lNUg4Tk9JOHg2?=
 =?utf-8?B?dk4zZkpqVDJLZEdySWh5UmxIYXF2U0l4SUJia0dUZXl0bjNHWE5LbVlrOVpI?=
 =?utf-8?B?U3QxbElrNnVFdjRiTVNvMjU0VGxHczc5aFRqNVpYMkg3UFE0MGRIWnU1VFZB?=
 =?utf-8?B?UTlNWG9WK0pxZmdZc3JzZEVBa0pnNFMvNDY5OWt1cWlPazFkZUg4M2piNEVD?=
 =?utf-8?B?UHRURGpVTktIQ1lHQ1BoZ0xmaUh1SFZ4U3ZqV09zbTdROFNodE1jTWlJS0Vq?=
 =?utf-8?B?S1JJakdlSTJkUmdZOU02VFg4SWxRU3RJVHFmbDRGL3JiajJvbjBrTFBNSzQv?=
 =?utf-8?B?aldXb2xPRXdmNEQ3bjNmWjArcjRaVmt4cFBPcHFFTjlHZWpnYXByeG4vWU0y?=
 =?utf-8?B?dUFLeDB3ZE9NWm5xdzFIYXJoejJKekxmOHdQZFkvMGp2WGRJUzZMRklNNWVT?=
 =?utf-8?B?YkhqekFBeE00bjYwVGg0emQxcnRkWlRmeFJOUncxRytMT09UdVFtcXBRY21L?=
 =?utf-8?B?bVNueUI4OTN6aWdaMkRlcXNsaEJUOGVIeDBRRlJCNGIxNi9MbkRWcFZtUm1h?=
 =?utf-8?B?ZjdzNzV3ZmNZWXVOVFRuWmxBNjNBNmJxSFZHY3RzbGdEUG5IMlgrU1diR1Fp?=
 =?utf-8?B?Y2dnc3ltNFM0WnpIejhvMGlDNWtyRzZha2xRbXdWQnNLL0xaeVAzL2FudWxt?=
 =?utf-8?B?emFlQU1MaHlFcFNOeCsyQ0gyY1lkTmxBUlhqN1BjTi9xeHYwOVpqL3l4VVhz?=
 =?utf-8?B?YVlIdW5lZ3orRVV1NFV3SjdpM0N6WTBxRHdibkhhV2ZZWG9KakhQYlltYU1o?=
 =?utf-8?B?V05Pd1pDT1RYZnNxTzhrWEJlRjloRkxmTWljZWJjRXg5TUx1aW43Q0xaeGFs?=
 =?utf-8?B?QnZJNWNRb1FBaGpmblhUWG5ERklDU05ob2JrMGdzYTlTV0paUnRteXd5aUdP?=
 =?utf-8?B?T1gwbnFHb09oc0Nlb1FvRXB6MWFDNlNIWm5aUFhuNk5DSGdkbDBnaUJ5VnBC?=
 =?utf-8?B?Wk5Dakw5SEtqN1NhZ1JsNStZNXY4UjBCZm1qNit2UUE1d3ZkTEhxbFNWM2tJ?=
 =?utf-8?B?cm1uNXRYRTVZWUppK2hDVDRHSUduV2hXVmtZZWVvZHRpSktrWlRJcDRqc3RQ?=
 =?utf-8?B?Tno1RUlsMzlycFJJViswRlZqaUVYWDkyMG1ldU0zSFI3T1Ywdkw0QU5MRko5?=
 =?utf-8?B?UGlSWFd6Vkk2Yzhaai9US3B0TnAxWTUvcFR1Sy9vOURmMVhBYmM5ZXA4RGhl?=
 =?utf-8?B?QkJOL0Q5d1lmYVA4bTcwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70917701D586E948994FA41C1C7B01C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e8104a-677c-43fd-a2e4-08d91bc90799
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 19:54:07.8721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVujHbBE3xSJvNJmaxDeM+43s2E9zDpZ1QHUu6YTqaFrgTMvW6aESNuLF9gEGa8SdEG08DFmoBfMl01+X6F9N2k0mxZFDoo5oTrzHESTO/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3303
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTIwIGF0IDEyOjUyIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFdoZW4gIkJ1cyIgd2FzIHJlbmFtZWQgdG8gIkNvcmUiIHRoZSBoZWFkZXIgdW5kZXJsaW5lIHVw
ZGF0ZSB3YXMgbWlzc2VkLg0KPiANCj4gUmVwb3J0ZWQtYnk6IFN0ZXBoZW4gUm90aHdlbGwgPHNm
ckBjYW5iLmF1dWcub3JnLmF1Pg0KPiBGaXhlczogNWY2NTNmNzU5MGFiICgiY3hsL2NvcmU6IFJl
bmFtZSBidXMuYyB0byBjb3JlLmMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRh
bi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QsDQoNClJldmlld2Vk
LWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg0KPiAgRG9jdW1l
bnRhdGlvbi9kcml2ZXItYXBpL2N4bC9tZW1vcnktZGV2aWNlcy5yc3QgfCAgICAyICstDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvY3hsL21lbW9yeS1kZXZpY2VzLnJzdCBi
L0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9jeGwvbWVtb3J5LWRldmljZXMucnN0DQo+IGluZGV4
IDcxNDk1ZWQ3NzA2OS4uNzNmNmIyNDZjNTgzIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RyaXZlci1hcGkvY3hsL21lbW9yeS1kZXZpY2VzLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RyaXZlci1hcGkvY3hsL21lbW9yeS1kZXZpY2VzLnJzdA0KPiBAQCAtMjksNyArMjksNyBAQCBD
WEwgTWVtb3J5IERldmljZQ0KPiAgICAgOmludGVybmFsOg0KPiAgDQo+ICBDWEwgQ29yZQ0KPiAt
LS0tLS0tLQ0KPiArLS0tLS0tLS0NCj4gIC4uIGtlcm5lbC1kb2M6OiBkcml2ZXJzL2N4bC9jb3Jl
LmMNCj4gICAgIDpkb2M6IGN4bCBjb3JlDQo+ICANCj4gDQoNCg==
