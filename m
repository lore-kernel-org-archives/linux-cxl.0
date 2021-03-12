Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0816C433DB
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Mar 2021 01:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D66E64F90
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Mar 2021 01:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhCLBwK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Mar 2021 20:52:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:17842 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhCLBvn (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 11 Mar 2021 20:51:43 -0500
IronPort-SDR: Kn+/x+xYm2Nc7pUWeuR4DeylqilHrRw1OICFTIOa1xKQ/6LjmRItZjy6QEQyn/PSWmepW+InJl
 xMrvCe9tUWKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188864814"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="188864814"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 17:51:40 -0800
IronPort-SDR: Xbv7EGkMBDl+8WJ/cYP/7xK6hGTAL7y+O4mX37Uic0ziBysbmrMTDnReE0/qyO48FVvfKG3plR
 zc76VFarGIiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="409696636"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2021 17:51:39 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Mar 2021 17:51:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 11 Mar 2021 17:51:38 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 11 Mar 2021 17:51:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bzhgksqw3jYvCs7a3UVacDWacKnd77sU1MFbh8oUz9qpgbOv2XWYa1r58R+0UhTzp0OOsreJbc8agoVd6Th6YQwt1M9j78R4VfRUX/Gtc697n/rumpUurVK1r86mkxXJaQjmbPKy8ON3FhUKlWTYg2LdcAKTYbkd+7HTTWEdBm/5AXBHRi/5G50IYiG96/K3dFaGxGsxDSxBh612+UCtuF9ZM5FZK4AuuywtUpRS8+Q4fWi03TQQ9Fvwr5hITNcvfS/bsmm40IMigggd16ciL2ozTzoy9Xl8BLv9GFJr6W1ZGR+AZxZvkzM94Dve180zAYwbx+APsuso5LQGBG7LCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuqgaAA7dKmf7wMgiMBP16w2ek3aEWfXuiZpZIQ6VAA=;
 b=GaigauWSRYHD7Sca2diXA59HSc+143x5DawxM80erXvt5rpiTySYg9hRqNlVmZljuP2lEVhWzDad3SKpbBwWc4Sc8eNN1tCYZrItTv4sqM3EVkYM8YxZMeFlCgNP6iPrSw9F/fuZ60Y5xkKoKadNXm44j6Rg9QmruLmCFP170kYALl69QzI3Xzp8AxGLgAVb+/yN5ZZnqTjLRos6yJOJvLV0A2zho/mcNA9FDpc9lTmeuIVbmIrTPiJEowC6KIXp5J2JHKIhHG7FbYCaip4HoaP303FaoigGiADj4o9MUnBITBQ9bMgB4r+BGtgkrS12KGmk7FwFdGTiWur6EMefYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuqgaAA7dKmf7wMgiMBP16w2ek3aEWfXuiZpZIQ6VAA=;
 b=jUdZCqj/ltBVEMWfjjvqQ1XXXjmihiUhXEfaFijiHgqc3OCFKXn6p240PPT0d+kuDSVFSB7ZfEKccJ6qbGTWimMEsQ38FGYOAn8L+iuOf6y2GVNtkR0t5qnEkjdmULHkkYI9XarajPfHZdNsCfR4ocUIgGWrga+PozOk0hEZJ/g=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4928.namprd11.prod.outlook.com (2603:10b6:a03:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 01:51:35 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3%3]) with mapi id 15.20.3912.029; Fri, 12 Mar 2021
 01:51:35 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "raj.vishwanathan@gmail.com" <raj.vishwanathan@gmail.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Testing CXl with qemu and Linux
Thread-Topic: Testing CXl with qemu and Linux
Thread-Index: AQHXFHO2WBQzxMdRq0KWsIirP2lIFqp/iOiAgAASpgA=
Date:   Fri, 12 Mar 2021 01:51:35 +0000
Message-ID: <7f5066f5ec2587229258bf33da84f1275e0d044a.camel@intel.com>
References: <CA+-5cKfDiDDG6zpnDSg12a=JPD8-FTypi9qA9qdr_CRnkrFuHg@mail.gmail.com>
         <20210312004449.akcgmidgyupzqbyn@intel.com>
In-Reply-To: <20210312004449.akcgmidgyupzqbyn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab6ddc05-ef48-41a8-6d00-08d8e4f95e5e
x-ms-traffictypediagnostic: SJ0PR11MB4928:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4928CF76C5ECEA0328105D39C76F9@SJ0PR11MB4928.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqxHPWgvod7LM+GJhA0D0tqi5yt3Y5kxhIfw/Ub8nhafXTsOAWZ+CMMZ+bGJtkNYo8qoH0zJAbE7rna/dJdFNSjCzdtq2jyZtBtE6N/HPGkqz2N6X61ubqTyvKBxJ5MKm2gHv0Hbxk94sdhI6CTIbjl/ONkauYEj6E/NJ2B7KrOS81mDjEqSsmzwEKPo3z8I3afCOcznWII7lPBs8WLy5Ja7JjkGdvOHVGeoDOfiLD5JTD/4o51Obd52bWTYTJK6Z46/c303kv51MlnKHhXKapVKPSZbdXNMgzag3hBgnPb1QmIuRVejr/DOfx9alc79y2pDH+t1v2CP3Xq3AKmxMz6yOKVCWECvBkHcOserpyS3nIkXu/b52Fi+wgJ1ye0CaaePntbzlYH59I1BbgLAdSPQkeZC4uHPRyF3GseEnWJ49tLvaqY0+YaVaez2UFBZeyPeymPXxozHfBercwlevTgBkrurMgguhAMEORtYLWP8bRtLOHzzLP/1XqCASfFSXuFp++XW42fZavmA6IiTzRIxSCNdlBCB0xfnJNOulVwa4nqflVNehopSnOmzQ2L8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39860400002)(26005)(8676002)(86362001)(2616005)(2906002)(316002)(110136005)(8936002)(6512007)(36756003)(186003)(478600001)(83380400001)(66556008)(4326008)(5660300002)(66946007)(66446008)(66476007)(76116006)(91956017)(71200400001)(6486002)(53546011)(6506007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dmFES0xVLzAvRGVrckhCVStEdGhjSFArd0NPMEVxSy9aMFJiZHNqeXBKY1RU?=
 =?utf-8?B?eHJNa2lodXRaS28rbTJJWmZJdUVNaWR4SmliRDJ6VUpKK2toclNXdzgydkR6?=
 =?utf-8?B?Vmg3SGYrTkxteGUrQ2NibStzdTFWMWJuTEVVMEVxSGRrNE54R05TYnZ6eXhw?=
 =?utf-8?B?aS91ZEMyWVd5akJvMXdtdVV0cnhDU1hUeG9saFhpUEFTU3hUWkNydk93Qmlp?=
 =?utf-8?B?QUpHK3pSSUh3WnpQVXVoa2ZOSWpoV1N5L0RoSE9CUUV0dTA3VlFlWjFNenpS?=
 =?utf-8?B?N2NwM2M3cG01REpkVHkyNWRydDJTTFByL2F0a1FDSFVjSTM2Rm9Qb2lZTlpG?=
 =?utf-8?B?QUlwL3lYVi92Mjh2VDErT2xjN2t3YThhdGJVLzh2cWo2dHAwR0hPV0xhSXla?=
 =?utf-8?B?am5DNG5xQXJTdFdJY1o2QlI2eEh5clltanJkSk1KaGd4eUtPcFRuYlZVQlJF?=
 =?utf-8?B?WjV6MmhTOE40ZWZ0N1djYlhpYW9YRWYzOFdEaHp4Uk1UbXo4R1o3NUtmMG9l?=
 =?utf-8?B?TzhpeVovQkNWZkhsSDNFQkNaeTVmbWExUTRlZzZyY1hSRG4vb0lVclBuT1lP?=
 =?utf-8?B?QzdIeFEwWGJScXRpNzNYRHJYL1BGakNqdDRsaVNveTJuUlB1dTJ2QUhSRUxi?=
 =?utf-8?B?Qlh0eGZQSDlOdzR1Y0VoT0wzZ0JtL3JydXF5ZGpCdVdhNHk0TkV1YjFuNm1a?=
 =?utf-8?B?SXBRZmVqSkZxelBjZUVlT2hiNGxiaXBSSXNuWmhvVmZkaTIrUWhiakNxQUdy?=
 =?utf-8?B?d0o5V29xNGF5RmRHbWZmdUI5bGF4VUVSU0tJcTZSYUpZR1kzRDB1NEw2VU9N?=
 =?utf-8?B?NDhqVTQ4N3JzQm9sNkpkRC8vNjNabExiUC9laThIWXliTVJ3RWV2K2psd2hB?=
 =?utf-8?B?dW0yZjl4VC8rdjQrQmxyUTBRSks3MEkxZ0duZGZQNW54bjc4WGJUZS9VTHdj?=
 =?utf-8?B?eXZSdGs3NkRJc2FzaHh3dnJqL291amdISEF5VTlFT2FrenJZOEhPMVpzNXZz?=
 =?utf-8?B?Vk12dy9wWFpWSElMdnpPT00rWEVsUzFVSy9YczN1QUJWVzBFNGRuVng4cmZE?=
 =?utf-8?B?eGY3U1JzelVFL1ZwWjNMZkY2RzkvbzFtZ1pySGRray82R0ZTSjNDdXBBMExo?=
 =?utf-8?B?Q1dUNnE3Qk1VeXoxcEJaNjFsYU0zUFlDRGNjTzZOZ1dLOXBCRElzb2IvS1Jx?=
 =?utf-8?B?Skt6c201Vis2b2FrMFd3Y3E5Vm85RTJQNjFMQ1JVVTBlcGlzd3I3aVkyYzZk?=
 =?utf-8?B?TkQvRFFjNUo5UDFjVzBZY29zRGpqZnZmdU5VS29zdkpNZUtHMHV5S0hFL1Iv?=
 =?utf-8?B?dTNHaW5BMGtwbmF0Y2Y3bXJ1UkQybTM1Y2NUa2pWM3VjL1pMMHpIUnNvVHdh?=
 =?utf-8?B?NkRkWlBiRXVGdVlneUVHSStGbTJtUFJTcDVMYkYzZ29xTUpTVi9KUjlnck5O?=
 =?utf-8?B?NTRQZFFZbk1zeW1TeTFLcVlxRklNU2htcTV3VnVwdzVuOWg0aE5ZQVZJZUo2?=
 =?utf-8?B?SHhyckYxVVRCaXI0dnhMTkFIK28wWWNJVjk0MlV6bzNXdHNuem1ZQ0RsU3dS?=
 =?utf-8?B?cXUra0ZYLzJVRVVHalJBOHA4R2k3N09zSEtCWjhuV05KUXpWTXFud1Uzbnlw?=
 =?utf-8?B?eG5JMkhGOWhXek5kQWdORE1PVFQwWjRPRzhWTmNQeHdSaFo0MXR4ejJmMWFP?=
 =?utf-8?B?S3owdjNrb1VkOTF2V3J5ODhKaU55NEFMZGZQd2dJN3d1L0hjbXJ3VTRyV0s3?=
 =?utf-8?B?d0k2V2hpSTd3OWZNbUFLUGZHb0pnTHFpQVcyUHR1YnRSKzFNK1dqaDNGZjh0?=
 =?utf-8?B?YlA5Nlkvd3hHdTM5Mmg3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0A21F1E5116F341A02372C3AB932720@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6ddc05-ef48-41a8-6d00-08d8e4f95e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 01:51:35.3191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6JBp7oa3yY0Hia2w26GOdriHYSsyCbJ7ua+joVC6J4zYCdaKMwwMPPoB38iA8ovnZ/MsECxPw4fi0lYS35ZHjGAhhGFaDCJmyfLILcbOo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4928
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVGh1LCAyMDIxLTAzLTExIGF0IDE2OjQ0IC0wODAwLCBCZW4gV2lkYXdza3kgd3JvdGU6DQo+
IE9uIDIxLTAzLTA4IDE1OjMzOjQ5LCBSYWogVmlzaHdhbmF0aGFuIHdyb3RlOg0KPiA+IFJhaiBW
aXNod2FuYXRoYW4gPHJhai52aXNod2FuYXRoYW5AZ21haWwuY29tPg0KPiA+IDE6NTUgUE0gKDEg
aG91ciBhZ28pDQo+ID4gdG8gbGludXgtY3hsDQo+ID4gDQo+ID4gSSBhbSB0cnlpbmcgdG8gc2V0
dXAgYW5kIHRha2UgYSBsb29rIGF0IGFuIHN5c3RlbSB3aXRoIENYTCBlbmFibGVkDQo+ID4gDQo+
ID4gMS4gSSBkb3dubG9hZGVkIGFuZCBpbnN0YWxsZWQgbGludXguNS4xMSArIENYTCBwYXRjaGVz
IG9uIGEgcmVndWxhciBxZW11IHN5c3RlbQ0KPiA+IDIuIEkgYnVpbHQgcWVtdSB1c2luZyBCZW4g
V2lkYXdza3kncyBDWEwtMi4wIGJyYW5jaCAoIEkgc2VlIHRoYXQgdGhlcmUNCj4gPiBpcyBhIDIu
MHY0IHRyZWUpDQo+ID4gMy4gSSBhbHNvIGJ1aWx0IG5kYWN0bCAgZnJvbSAyLjB2MiBicmFuY2gN
Cj4gPiANCj4gPiBGcm9tIHdoYXQgSSB1bmRlcnN0YW5kLCBJIHVzZSB0aGUgbmRhY3RsIHRvIGNy
ZWF0ZSBhICBtZW1vcnkgbmFtZXNwYWNlDQo+ID4gYW5kIEkgdXNlIHRoaXMgaW4gdGhlIHFlbXUg
Y29tbWFuZCBsaW5lIHRvIHN0YXJ0LiBHaXZlbiB0aGlzIGFuZCB0aGUNCj4gPiBMaW51eCBoYXZp
bmcgQ1hMIHN1cHBvcnQgIEkgc2hvdWxkIGJlIGFibGUgdG8gc2VlIHRoZSBDWEwubWVtIGRldmlj
ZQ0KPiA+IHdpdGggbHNwY2kuIENvcnJlY3QgbWUgaWYgSSBhbSBjb21wbGV0ZWx5IG1lc3NlZCB1
cC4NCj4gPiANCj4gPiBJIGFtIG5vdCBhYmxlIHRvIGNyZWF0ZSB0aGUgbWVtb3J5IG5hbWVzcGFj
ZSB3aXRoIG5kY3RsDQo+ID4gDQo+ID4gSSB0cmllZCB3aXRoDQo+ID4gDQo+ID4gIi4vbmRjdGwg
IGNyZWF0ZS1uYW1lc3BhY2UgLXQgcG1lbSAtbSByYXcgLW4gbWVtMCAtdiAtcyAyNjg0MzU0NTYi
IGFuZA0KPiA+IGl0IGZhaWxzIHdpdGgNCj4gPiANCj4gPiAiZmFpbGVkIHRvIGNyZWF0ZSBuYW1l
c3BhY2U6IE5vIHN1Y2ggZGV2aWNlIG9yIGFkZHJlc3MiDQo+ID4gDQo+ID4gSXMgdGhlcmUgYSBz
dGVwIGJ5IHN0ZXAgZGlyZWN0aW9uIG9mIGhvdyB0byB0ZXN0IENYTCBvbiBMaW51eD8gSSBjYW4N
Cj4gPiBkb2N1bWVudCB0aGlzIHByb2Nlc3MgaWYgc29tZW9uZSBjYW4gZGVzY3JpYmUgd2hlcmUg
YW0gSSBtYWtpbmcgYQ0KPiA+IG1pc3Rha2UNCj4gPiANCj4gPiBSYWoNCj4gDQo+IEFzaWRlIGZy
b20gY29tbWFuZCBlcnJvcnMsIGZvciB3aGljaCBJJ20gbm90IHRoZSBleHBlcnQuLi4NCj4gDQo+
IFRoZSBjeGwgY29tbWFuZCB3aWxsIGJlIHVzZWQgdG8gY29udHJvbCBDWEwgZGV2aWNlcywgbm90
IG5kY3RsLiBOb3RoaW5nIG90aGVyDQo+IHRoYW4gc2VuZGluZyBjb21tYW5kcyB0byB0aGUgQ1hM
IGRldmljZSBhcmUgYWN0dWFsbHkgaG9va2VkIGluIGluIGFueSBvZiB0aGU6DQo+IGFwcGxpY2F0
aW9uLCBrZXJuZWwuIFFFTVUgaGFzIG1pbmltYWwgc3VwcG9ydCB3aGljaCBtYXkgbmVlZCBtb3Jl
IGFuZCBJIHdpbGwgYmUNCj4gbG9va2luZyBpbnRvIHRoYXQuDQoNCkluIGFkZGl0aW9uIHRvIHdo
YXQgQmVuIHNhaWQsIHRoZSB0aGluZ3MgdGhhdCBhcmUgYWRkZWQgaW4gdGhlIG5kY3RsDQpicmFu
Y2ggeW91IGJ1aWx0IGFyZSAnbGliY3hsJywgYW5kICdjeGwtY2xpJy4gWW91IGNhbiBydW4gJ2N4
bCBsaXN0JyB0bw0KZW51bWVyYXRlIHRoZSBjeGwgZGV2aWNlcyBmb3VuZCwgYW5kIGxpYmN4bCBo
YXMgQVBJcyB0byBjcmVhdGUgYW5kIHNlbmQNCmEgcGFydGlhbCBzdWJzZXQgb2YgbWFpbGJveCBj
b21tYW5kcy4NCg0KRXZlbnR1YWxseSAnbmRjdGwgY3JlYXRlLW5hbWVzcGFjZScgd2lsbCBiZSBh
YmxlIHRvIHVzZSBhIHJlZ2lvbiBjb21pbmcNCmZyb20gYSBDWEwgZGV2aWNlLCBidXQgdGhhdCBm
dW5jdGlvbmFsaXR5IGlzIHN0aWxsIHNvbWUgdGltZSBhd2F5Lg0KDQo=
