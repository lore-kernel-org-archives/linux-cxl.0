Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F114C433E0
	for <linux-cxl@archiver.kernel.org>; Sat, 13 Mar 2021 00:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BDF64F64
	for <linux-cxl@archiver.kernel.org>; Sat, 13 Mar 2021 00:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhCMA3n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Mar 2021 19:29:43 -0500
Received: from mga07.intel.com ([134.134.136.100]:47282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhCMA3e (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 12 Mar 2021 19:29:34 -0500
IronPort-SDR: v5ZtWYmo8eR3drz+ALJQKEUIy1BxCVqKLPHxNct4zUnG2+CMt3JosaBnc9yv+/jYHKzzQ0WQE+
 Aj9vuogFrLkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252925422"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252925422"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 16:29:30 -0800
IronPort-SDR: f+GoXFb9EBgVmMWAQfZUm98pUS3KDcljOjD2k3ntGounLSaEcb0j+1cJ9j9Dk7vAzqtmMYeGGn
 n93r9LIBA7kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="604122322"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2021 16:29:30 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 16:29:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 16:29:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 12 Mar 2021 16:29:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 12 Mar 2021 16:29:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHcSkeZ1fxoQUilamHGAb1C+SN59vpFhEAPoCbDMNwrjTZpOrX3m6D5b6j54swEsMJ7MdBfRhBAHIyodI6Tiz8aPDkb5DkLglp6at53ghC/Yp2LB6CBzDtAIzZLCmLd6Uh8M9tkzzFjG9Vca7ERmdDRCS4W+cVXe99ZDQqznOABwmwIef5LgcDetOjL5Po1v5kybMJJ9Iu9BXJ7ZlNXOLivoQxQMGmKlzGzT6YByeDe7ylmKQBtlMamnAHGN5lMqS54wy2em52M0YUbM559nw69+pnMTN00y54iWgI4MPA1uawcsgszl7D3tmVPsrTQOI/Ij1RDVEne/gE4BUxvkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMSXg6vALsuIRX4yOUUMvkZdu8mZ2vv4fLePBmLyYZ4=;
 b=K9FH8MyCvVzQsjhFmnjakRAnzH5EAndW7tY4L6kfTvXuuvsOLBLJ3y70SwLv9BOcca8UtXlH9xX3fYLX0bVhXlvcwqW+mnQ0k6nFGmnzIJFJl3q40kPv5ujE/szqjNf82tN9xvTE3BF76RRjotQZZkIHenPkDAebC2NZtMRTzOgqYMggC49aXMRCMwj6qlGISRCYT/Ry/AzTZRW2808neVrzXQBOBO+irbRy0hawzyL2jljAFcM2JkdK4ciyjzgJ3ZtNo4RLjnxcoB7EyZUX3CyfzO6ri5rwkBY0KPu21qbO3LdtXKE25V3vxusYxA5P2U/5JC2FUxsUtEUUfKjD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMSXg6vALsuIRX4yOUUMvkZdu8mZ2vv4fLePBmLyYZ4=;
 b=lDa70CWTo16TvPf6H9XqjM264uEXlAPl8ihpsRpcHuJLqQiU3s1B4oCDjyyRCE8tzANZoxWUFVP6ofChtdFJ7NbSlPWdq6WqNxs5oKzkRPjWYZ42vz23mZ/Nw2dv88FiOOZjV8iwfGy2RwCrAzQKG1AN0ePWkicECh5O+13ZtmE=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB5006.namprd11.prod.outlook.com (2603:10b6:a03:2db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 00:28:54 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3%3]) with mapi id 15.20.3912.029; Sat, 13 Mar 2021
 00:28:54 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "raj.vishwanathan@gmail.com" <raj.vishwanathan@gmail.com>
CC:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Testing CXl with qemu and Linux
Thread-Topic: Testing CXl with qemu and Linux
Thread-Index: AQHXFHO2WBQzxMdRq0KWsIirP2lIFqp/iOiAgAASpgCAAPyJgIAAfrKA
Date:   Sat, 13 Mar 2021 00:28:54 +0000
Message-ID: <947272c24b860ef9ac9609134a6f481874c71219.camel@intel.com>
References: <CA+-5cKfDiDDG6zpnDSg12a=JPD8-FTypi9qA9qdr_CRnkrFuHg@mail.gmail.com>
         <20210312004449.akcgmidgyupzqbyn@intel.com>
         <7f5066f5ec2587229258bf33da84f1275e0d044a.camel@intel.com>
         <CA+-5cKeZKUONViHiQbGJ=sjA43iHHQRxsrsqzT-nG3X6Wo89sQ@mail.gmail.com>
In-Reply-To: <CA+-5cKeZKUONViHiQbGJ=sjA43iHHQRxsrsqzT-nG3X6Wo89sQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.44]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d07e2d6a-af8d-41f3-ec81-08d8e5b6fc02
x-ms-traffictypediagnostic: SJ0PR11MB5006:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB500611A5B250FD1297D3CC41C76E9@SJ0PR11MB5006.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n8kEXkyMFUwEFBJpN4Vt82wCX1dDi+pgZ0kMCMZ1Z9yEQSKIKB5pqeeWWh8mwmsZomwnxJvuMAFYuoLsuJkgoeJSKvgIbl9dKx4mREFyRFLuONhdOq8Ia6zHyiCAjobSszN8X6jgofSyKSDFHadD8LFOJG5QRh40J/75drOVUOZqKGLgGHckj1pF+yVZ1JRIUB6YiLcuQ0TOB5Bl2ovhlSvJE2Qfb3i0imzlizt9tYqdyy9/xwYIJfbBAfe5DhJoedyZdG5IxaXyI/MN7dRaxPccoeIm2LZ0ZWIT0hS4pwFv0ddDz3c11lHVUc5wbVNd386hHklfdp/9ytouPt41bb5qJkdAq+9RN05jqyHZNs4V2i7NJqwltuZGUs1qSlEXaTY5otZORocuYj3n0YZozcLIczgQE7LZzLcElT3ypq15HwoSiqu+yPhtceNySMqA4ZcYYqh8NHo0vIw/B0tSMzSjWQHK2qZxJbkvR/kBN24hukQlIvJUULhM8ss15/KDrOz+2zHXxFloNi+N8mhrkhHThKOT0XvTXfXTbfd9sjDuiNNXo0LkblILPXooLUtWPdOc+4RPjcayYT/rWgOrbV4qmZkbHOiNx9XnV/33eFMJNj5GPyFKckxYnDAHp4iKGBkAikPs10YRh2nIzaiaxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(376002)(396003)(71200400001)(5660300002)(66476007)(53546011)(66946007)(6486002)(4326008)(8676002)(64756008)(86362001)(66556008)(66446008)(8936002)(36756003)(2906002)(6916009)(6506007)(83380400001)(54906003)(6512007)(478600001)(26005)(2616005)(186003)(966005)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dkZsYmxPR01uSjBsRU5FM2ZGb3JCdnRDd3J2WHVrREorNFNNc3VaYU8xbWFL?=
 =?utf-8?B?MEk2VzBpSkRpenZySXc5YTJ4RFNiRzZEd1hsMzBZczZ0dlZKcEhteFNSd0NH?=
 =?utf-8?B?T05OZld6WUR1QlFqNlNDcENQY1FKSHBNWnF3Y1RtOVJXZ05CbGIrYmZ2dUl6?=
 =?utf-8?B?NTZCaSs5WDZZMGxGVFVIczV4eTUzK0tqZjVkTlRTL1AyUHMyWkI0YitaaWEw?=
 =?utf-8?B?YkRvazErbHZZQ2ZkV21yN1p0SVY0d3FlaUdpbGxSanRFOGhmOFlMRnJzM2ND?=
 =?utf-8?B?clpZYnVKUFg1TWtic3dlZjJXcXljaFVxWGlOSHp1THJIT2w5UWxkRXJIeGhs?=
 =?utf-8?B?NEhSZzNiVllVQ3ByU3BLbEJnWUdaZGFROUNFYllBSnErVU5VS0JhemJPdUU4?=
 =?utf-8?B?VEN2Q0JMdGJWWFJ2S2IxYzgwdHhiQlV1UlVJaEJwc2hMSElnNllJSjZhRG9i?=
 =?utf-8?B?aFpFbGVqQ05JWmxBM2wxVlFkTklxZldlY3dqNkxqYlBWK2J6cnFRRGRTQ2tz?=
 =?utf-8?B?Z0NsbTdtRFJzTnA1V1FCZmE4U25pQk1vc2tMYkdIcU1QY2ZlQ2lUMUVKQVUy?=
 =?utf-8?B?N1hnaGlEa3UrSlpZKzBRdGUwWHlDVzMvZWgzcjJTeXFQNlpXa01LZ1laTGQ5?=
 =?utf-8?B?V093KzQ0STFxK0s0VjdRcktiSTVlc3Bxb1FKUVNHRFp3RjBhK0FvOTd6WTNU?=
 =?utf-8?B?c01XU24xazFwUlZQRWRucEVVd0Y0SHdncEJKMXBpWFFCcGl4WnQrbldGK08v?=
 =?utf-8?B?SVcrV3dNTVkzb2tZY2d6cFVFVExOYmV2R1Q1b05IUGtJdEQ0bm1HYmhRa1Ir?=
 =?utf-8?B?cnN1bThxbmk4NEhMTGpaRFdHRVRKamU0QkdrTUE5bU14dTVKNFl6MUNEVlcy?=
 =?utf-8?B?SzZ5Z2k2Z2FaaUNUYzJJTGFXU0dSL25NZUR6Q0RMTHl2Y2NMYVgwMGZ0ZXNw?=
 =?utf-8?B?TTJUcGpnK2RuTGZLdzVBcnJpZFVyQmdNdkZ3MDFoWi9uSS9vSGpJWSt0anNC?=
 =?utf-8?B?cDZ0T0ZoOVZsbE4wNk1kTzhQOHg5ZHlFN3lndjlDd1lQY0VzVGZsRXVocTJL?=
 =?utf-8?B?YUc4b2hmVDRsc0N0d3VkbHlOQk1YeXJUZlFwU3Uxamxkakltc1lBNHQxbzFF?=
 =?utf-8?B?R25JYWM4d0FIRjNVZEJEK2JCOEZ6MGR5ZUxaYlROMzNzQzZmdEcxc2U2aTF5?=
 =?utf-8?B?RGpTUjRVZkpqMjVtcFdka1JRSEFvVm1mdXI3amJNUTRvRnFFamxSRS9qakJ1?=
 =?utf-8?B?KzZ2L1gyakhqcEhZc0xrbUZkTG5BY1hIVmEyM0FkQ2hMb0lCdThvMkFqS1Bn?=
 =?utf-8?B?K2xmWmh4MHM0YjZKVHM0all6UkJXRUNOejFRQ3B3cGVvaGpBRzdKWVBqNjZz?=
 =?utf-8?B?eFROQm1JM2ZhcXczOG1mOXIzcE4xSjBiemIzMVZpVmR2Y1ZNb0Z4Z1pyVG5i?=
 =?utf-8?B?N3JkMGlBRHJzL0JNT2pHZENJZkJHYzlSV2dYQXNLRmVOb2Z4VGlxNE04cnQz?=
 =?utf-8?B?UjFKZmFMcTBQbWIwMDR5QmRRNWJPZy83M3B1ZzlPYU1YRnc5RXNNTTZkbXph?=
 =?utf-8?B?NjhMTDZFL3p3OUFaYURZNWgrMExocEhlTW5nMWR4VXJlRlR0SEZnazdsU202?=
 =?utf-8?B?a29SVXIzS0pSd01mQTl5Q1BzeWV1S2xPVHFYVGJQY2loVHpNK0Y3UGZzTlEx?=
 =?utf-8?B?ZzdIQnc3dnV4MWh4bzN6SU1jRjgwaDZ0OEZER0FiNmJvWlpWSHk1YURaTWtk?=
 =?utf-8?Q?j8LH0YEx2J3TGi1Z+XNNWzp/LC1I8Rod2eU5QYg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA9B61B1C0DDCD4A90A8C024951076FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07e2d6a-af8d-41f3-ec81-08d8e5b6fc02
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2021 00:28:54.6814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CvNJgz9ou3ZN9jAQse/qO1ei+PvJ4RGkvGMRLkI676x7oTEPka8PuTOXrhlJZrQrsduZJGEdVHmc0qytTKqRlAp24LL2CfhwIlKvZzs+Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5006
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIxLTAzLTEyIGF0IDA4OjU1IC0wODAwLCBSYWogVmlzaHdhbmF0aGFuIHdyb3Rl
Og0KPiBWaXNoYWwsIEJlbg0KPiANCj4gVGhhbmtzIGZvciByZXBseWluZy4NCj4gDQo+IEkgYW0g
dHJ5aW5nIHRvIHVuZGVyc3RhbmQgd2hvIGV4cG9zZXMgdGhlc2UgQ1hMIGRldmljZXMuIElmIEkN
Cj4gdW5kZXJzdG9vZCBjb3JyZWN0bHksICBxZW11LCB3aXRoIHRoZSBob3N0IE9TIHN1cHBvcnQs
IHdpbGwgY3JlYXRlIGFuZA0KPiBleHBvc2UgYSBDWEwubWVtIGVuZHBvaW50IHRoYXQgd2lsbCBi
ZSBkaXNjb3ZlcmVkIGJ5IHRoZSBDWEwgcm9vdA0KPiBjb21wbGV4IGRyaXZlciBvbiBMaW51eCAo
IHRoYW5rcyB0byB0aGUgQ1hMIHBhdGNoZXMpDQoNClRoZSBxZW11IGJyYW5jaCB5b3UncmUgdXNp
bmcgY3JlYXRlcyBhbmQgZXhwb3NlcyBDWEwgZGV2aWNlcyB3aGVuIGNhbGxlZA0Kd2l0aCB0aGUg
cmlnaHQgY2xpIGFyZ3VtZW50cy4gVGhlIExpbnV4IGtlcm5lbCBlbmFibGluZyB0aGVuIGlzIGFi
bGUgdG8NCmNvbXByZWhlbmQgdGhlc2UgZGV2aWNlcywgc2hvdyB0aGVtIGluIHN5c2ZzLCBhbmQg
aXMgYWJsZSB0byBzZW5kIGRvd24NCm1haWxib3ggY29tbWFuZHMuDQoNCj4gDQo+IFdoYXQgSSBh
bSBub3QgYWJsZSB0byBkbyBpcyB0byBleHBvc2UgdGhlIENYTCBlbmRwb2ludCB1c2luZyBRZW11
Lg0KDQpZb3UgbWlnaHQgdGFrZSBhIGxvb2sgYXQgdGhpcyBzZXQgb2Ygc2NyaXB0cyB0aGF0IGhl
bHAgY3JlYXRlIGEgd29ya2luZw0KZW52aXJvbm1lbnQgZm9yIENYTCBkZXZlbG9wbWVudCB1c2lu
ZyBxZW11Og0KaHR0cHM6Ly9naXRodWIuY29tL3BtZW0vcnVuX3FlbXUNCg0KPiANCj4gUmFqDQo+
IA0KPiBPbiBUaHUsIE1hciAxMSwgMjAyMSBhdCA1OjUxIFBNIFZlcm1hLCBWaXNoYWwgTA0KPiA8
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIwMjEt
MDMtMTEgYXQgMTY6NDQgLTA4MDAsIEJlbiBXaWRhd3NreSB3cm90ZToNCj4gPiA+IE9uIDIxLTAz
LTA4IDE1OjMzOjQ5LCBSYWogVmlzaHdhbmF0aGFuIHdyb3RlOg0KPiA+ID4gPiBSYWogVmlzaHdh
bmF0aGFuIDxyYWoudmlzaHdhbmF0aGFuQGdtYWlsLmNvbT4NCj4gPiA+ID4gMTo1NSBQTSAoMSBo
b3VyIGFnbykNCj4gPiA+ID4gdG8gbGludXgtY3hsDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGFtIHRy
eWluZyB0byBzZXR1cCBhbmQgdGFrZSBhIGxvb2sgYXQgYW4gc3lzdGVtIHdpdGggQ1hMIGVuYWJs
ZWQNCj4gPiA+ID4gDQo+ID4gPiA+IDEuIEkgZG93bmxvYWRlZCBhbmQgaW5zdGFsbGVkIGxpbnV4
LjUuMTEgKyBDWEwgcGF0Y2hlcyBvbiBhIHJlZ3VsYXIgcWVtdSBzeXN0ZW0NCj4gPiA+ID4gMi4g
SSBidWlsdCBxZW11IHVzaW5nIEJlbiBXaWRhd3NreSdzIENYTC0yLjAgYnJhbmNoICggSSBzZWUg
dGhhdCB0aGVyZQ0KPiA+ID4gPiBpcyBhIDIuMHY0IHRyZWUpDQo+ID4gPiA+IDMuIEkgYWxzbyBi
dWlsdCBuZGFjdGwgIGZyb20gMi4wdjIgYnJhbmNoDQo+ID4gPiA+IA0KPiA+ID4gPiBGcm9tIHdo
YXQgSSB1bmRlcnN0YW5kLCBJIHVzZSB0aGUgbmRhY3RsIHRvIGNyZWF0ZSBhICBtZW1vcnkgbmFt
ZXNwYWNlDQo+ID4gPiA+IGFuZCBJIHVzZSB0aGlzIGluIHRoZSBxZW11IGNvbW1hbmQgbGluZSB0
byBzdGFydC4gR2l2ZW4gdGhpcyBhbmQgdGhlDQo+ID4gPiA+IExpbnV4IGhhdmluZyBDWEwgc3Vw
cG9ydCAgSSBzaG91bGQgYmUgYWJsZSB0byBzZWUgdGhlIENYTC5tZW0gZGV2aWNlDQo+ID4gPiA+
IHdpdGggbHNwY2kuIENvcnJlY3QgbWUgaWYgSSBhbSBjb21wbGV0ZWx5IG1lc3NlZCB1cC4NCj4g
PiA+ID4gDQo+ID4gPiA+IEkgYW0gbm90IGFibGUgdG8gY3JlYXRlIHRoZSBtZW1vcnkgbmFtZXNw
YWNlIHdpdGggbmRjdGwNCj4gPiA+ID4gDQo+ID4gPiA+IEkgdHJpZWQgd2l0aA0KPiA+ID4gPiAN
Cj4gPiA+ID4gIi4vbmRjdGwgIGNyZWF0ZS1uYW1lc3BhY2UgLXQgcG1lbSAtbSByYXcgLW4gbWVt
MCAtdiAtcyAyNjg0MzU0NTYiIGFuZA0KPiA+ID4gPiBpdCBmYWlscyB3aXRoDQo+ID4gPiA+IA0K
PiA+ID4gPiAiZmFpbGVkIHRvIGNyZWF0ZSBuYW1lc3BhY2U6IE5vIHN1Y2ggZGV2aWNlIG9yIGFk
ZHJlc3MiDQo+ID4gPiA+IA0KPiA+ID4gPiBJcyB0aGVyZSBhIHN0ZXAgYnkgc3RlcCBkaXJlY3Rp
b24gb2YgaG93IHRvIHRlc3QgQ1hMIG9uIExpbnV4PyBJIGNhbg0KPiA+ID4gPiBkb2N1bWVudCB0
aGlzIHByb2Nlc3MgaWYgc29tZW9uZSBjYW4gZGVzY3JpYmUgd2hlcmUgYW0gSSBtYWtpbmcgYQ0K
PiA+ID4gPiBtaXN0YWtlDQo+ID4gPiA+IA0KPiA+ID4gPiBSYWoNCj4gPiA+IA0KPiA+ID4gQXNp
ZGUgZnJvbSBjb21tYW5kIGVycm9ycywgZm9yIHdoaWNoIEknbSBub3QgdGhlIGV4cGVydC4uLg0K
PiA+ID4gDQo+ID4gPiBUaGUgY3hsIGNvbW1hbmQgd2lsbCBiZSB1c2VkIHRvIGNvbnRyb2wgQ1hM
IGRldmljZXMsIG5vdCBuZGN0bC4gTm90aGluZyBvdGhlcg0KPiA+ID4gdGhhbiBzZW5kaW5nIGNv
bW1hbmRzIHRvIHRoZSBDWEwgZGV2aWNlIGFyZSBhY3R1YWxseSBob29rZWQgaW4gaW4gYW55IG9m
IHRoZToNCj4gPiA+IGFwcGxpY2F0aW9uLCBrZXJuZWwuIFFFTVUgaGFzIG1pbmltYWwgc3VwcG9y
dCB3aGljaCBtYXkgbmVlZCBtb3JlIGFuZCBJIHdpbGwgYmUNCj4gPiA+IGxvb2tpbmcgaW50byB0
aGF0Lg0KPiA+IA0KPiA+IEluIGFkZGl0aW9uIHRvIHdoYXQgQmVuIHNhaWQsIHRoZSB0aGluZ3Mg
dGhhdCBhcmUgYWRkZWQgaW4gdGhlIG5kY3RsDQo+ID4gYnJhbmNoIHlvdSBidWlsdCBhcmUgJ2xp
YmN4bCcsIGFuZCAnY3hsLWNsaScuIFlvdSBjYW4gcnVuICdjeGwgbGlzdCcgdG8NCj4gPiBlbnVt
ZXJhdGUgdGhlIGN4bCBkZXZpY2VzIGZvdW5kLCBhbmQgbGliY3hsIGhhcyBBUElzIHRvIGNyZWF0
ZSBhbmQgc2VuZA0KPiA+IGEgcGFydGlhbCBzdWJzZXQgb2YgbWFpbGJveCBjb21tYW5kcy4NCj4g
PiANCj4gPiBFdmVudHVhbGx5ICduZGN0bCBjcmVhdGUtbmFtZXNwYWNlJyB3aWxsIGJlIGFibGUg
dG8gdXNlIGEgcmVnaW9uIGNvbWluZw0KPiA+IGZyb20gYSBDWEwgZGV2aWNlLCBidXQgdGhhdCBm
dW5jdGlvbmFsaXR5IGlzIHN0aWxsIHNvbWUgdGltZSBhd2F5Lg0KPiA+IA0KDQo=
