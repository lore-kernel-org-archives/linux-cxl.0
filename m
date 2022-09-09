Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71258ECAAD3
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Sep 2022 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiIIVlP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Sep 2022 17:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIIVlN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 9 Sep 2022 17:41:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE47133A18
        for <linux-cxl@vger.kernel.org>; Fri,  9 Sep 2022 14:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662759672; x=1694295672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3Rt2Rpcc8ARzW2qhkAObh/jGuYphRMKRM6Zdb1ieXJM=;
  b=DhsBFDUS73pT/gOsMfz3aj6SBMNLFhVRiG8SrSc6VM0uDEob8Fi2gPf/
   MUunUzvdU3XG8GMr1tyIoys6rVb+kJJ5Y2ftyWT8ZpRuj+gFtxhq9/Kti
   RqTePBuxLpVFtbxZ944lLcqwR45Igam6+ICX9GG6X3wHmJEoKJ7vOIeY4
   DiU0WcvFNvLUQ+KtQ5HCJ43BfXaTwh4lhyJ92b4hNKfq2hM64yUVmBW1x
   ny2Eq+PUUnFROmehsZvFjDpInBZ4QQSsfu9In93aj9AzPEgzcp53To4mk
   9fN2n8MAB/VA0qTr8uu+svNgqsp13dimJ+bUi7IzG35WzRFf9v1D9JfC2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="361530051"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="361530051"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 14:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="592758158"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2022 14:41:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 14:41:10 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 14:41:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 14:41:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 14:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnTNlfWk9gtZZjGUfWRGq/eoYHsq5JdJIoHG/mxdCCj8k3yapuzO2Zx7IvN0Fc4rCjfJYOQV+KkAzPsph6SrERXbz79iwUtDruQoHwglIpIDORMohv/LOkhfG5fzp9rj5OFJTOXKToflhoBKroH+SyeJ3kdwNdFSST7E/oCpmZLtJpMgScUz6SqPdqerzNsePIDQX11SOoqXieCsirz/YfzSH6N+HeCVAohoTibxjFeKZ/FLTHvphoChC/w2vDVpKtRnIS+GIkWA/UT/ZRhPKQqE+wviAD/fflpvUlWwGpWotEwxV5T9JXP8yyhYfr4r9N2Clh1OQquVsstOL1lR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Rt2Rpcc8ARzW2qhkAObh/jGuYphRMKRM6Zdb1ieXJM=;
 b=bgB6uIakJKQHq6gUtQpRK9EkL35CqmSnSfaPRe2C/zHlxR/FvYdY3cTWX3iiT/Xs4NEAI6APmqQuVYrCCqu5LJQkwYn73t3FeEgADZlpG4cGqCzeTqncxAfbwNhIR7lkvWtOq6ZvWkOTDxnjSQMkYZTW/GfvK/Ui5dl6rR/Qm9k6oei1BmnrVO9DXuv1C8eOonxn8SCBq2zjhxkujn67jl72E3o8fnI9SSITH87v8rDT4halt6elVV84AW0Nq0OewnjFuU3axZqmzfIAIIWL8ADkWOQUVGvpof3fmztaT4xIdXHpgtEAdnFtcT1D0o05srS+w35km73M03J6TtFpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BL3PR11MB6410.namprd11.prod.outlook.com (2603:10b6:208:3b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 9 Sep
 2022 21:40:53 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::25be:c4fc:f59b:8dd9]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::25be:c4fc:f59b:8dd9%6]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 21:40:53 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [ndctl PATCH 0/2] cxl: Add cxl list image, image-from-file
 subcommands
Thread-Topic: [ndctl PATCH 0/2] cxl: Add cxl list image, image-from-file
 subcommands
Thread-Index: AQHYs6jJLKqv+gZFp0OEPMcY1W+Fu63XwlkA
Date:   Fri, 9 Sep 2022 21:40:53 +0000
Message-ID: <b26596c33428d6f606c69206c0384d5fc7466a57.camel@intel.com>
References: <cover.1660895649.git.sunfishho12@gmail.com>
In-Reply-To: <cover.1660895649.git.sunfishho12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|BL3PR11MB6410:EE_
x-ms-office365-filtering-correlation-id: 0f50a502-6776-4c9a-f490-08da92abf88e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 32MqkL7LhAD/U03XfjpTyKOJ+kJpAOM/2+GLc8u+Dv36PviSsk9gHSazDsecd9neZ+x+itgK0EJtUYi5MTT8SMdf/pSb0d7mebTGLu2FPjh+GaxPZDtEpu76cVn9fMc/BlfuDg1tLfistEupKttBuBneZK2fc/YW2q1Kbb9nkuHtS1INjz0+w13sJtLuuMxXe/Qoa6ujW1OXFC1qqeTbeqP1SYsQEfYI4MN9Uhh8HVtb6eCFTYVMqJOLd2/MVTEpg0XYsQ9gTPCZ0gnxOQ3qijGnygXmUxLS8updigBXBCd7QQNukwmCh0ZkhX1lv6P7v0UOEN7/jw9HHjRZsPSNxDqkAZjYhkTxVOfj5p9LwVPiZGqeKMw1VZZvISdL34BTGjynabkxEHxjLiU/eVKD9REt8ZzqptzjBpOM0qGb2+IeUGR4wUTuKpryL4KXmE8B/S0ammoZ6HYU8Elp73sYY9VqFd6eyLBzX1aQTyQoqEhd9n0R5vUdCb3nzqQOpScbue9UjxYaK7l+EI1y6HoKMYEDXAQtrAW95gmnE98AkWXY/BkhK+UV2Dlan0OzZ2X3wkVQhIWarMVvph1KTHhfSrewbkSqJQEC+6GU4nafq9UsCoAm61sH+SauLvothMPpqwjKPCx9ve8cfmEm0JycAIYUW+Y2czvfDY/UJA3j1jGanMZ4T8ddOk0AG1qqsQAXEvf+n4J3JjrUhiDG5jObDdOGejWl0efUQKS9RGvxnmLD5rfRG3vAWbEIZxIBEf/qIR2CaWlh4dQ8FeI+u+Eh4bUjclSLd8VY6u8MOZdNVzg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(396003)(346002)(136003)(2906002)(316002)(8936002)(66946007)(76116006)(66446008)(8676002)(66556008)(36756003)(64756008)(54906003)(6486002)(6512007)(110136005)(5660300002)(66476007)(41300700001)(4326008)(478600001)(71200400001)(122000001)(6506007)(83380400001)(86362001)(26005)(38070700005)(91956017)(2616005)(186003)(966005)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2hLdTBPL0RBcDFPeHdEeWFLTENmSS9zTXFONGhLWE1mclpwRlRscUY1SHdv?=
 =?utf-8?B?NDZGalNEZDhoTzAxaGZUZ0RrT2xrdzBHVTJDVFNoVWJYeFMxOTc0ZytlYTM3?=
 =?utf-8?B?N3FhNW4zWU91UjZydXduRTAxZlFhbEtCYm5kVktBUnlCYnUxZWdVSEhWYjlL?=
 =?utf-8?B?OFcrMDBMUDdoTWNkWGhvOGREamFhZStPcnRYVkF5SEdsS0FiV2oxZjFKMDV0?=
 =?utf-8?B?OFNRdzdrbmswUENxR21QQ1kxTTBzS1lvWEpnblQrRHlZWUQvbGpkTEtsMitF?=
 =?utf-8?B?aEtaWEdKSldoSGcvM0k5UnRvYWVVTE1OQ2RCN2t3R1BaUzVEWTdmUTBSSmRG?=
 =?utf-8?B?UmRaNEZKN2UzQ2JkUCtSUzNpa3VtQ1I5OEc5WTdUcjNWYnl5Q3U3S092RmFS?=
 =?utf-8?B?WWdkOEJlaEZkNFJtTHNEVFJWYlU2bVF4emtoeTEzckl4Y3JmVVdUU21IVXE0?=
 =?utf-8?B?SWNNSkdyVFc5K0JmRUpENG1odjhRM2Jmb3F2TzdtWUxlVitGYS9mSml1dlV1?=
 =?utf-8?B?cW0yVGRISUNHUDA5QlYvSmdNTzcrc0ZWOHFGNGdkNVk4dUlpZGxrUVg4TlhD?=
 =?utf-8?B?bzhnQmFtQnlxVGg1ZTRLbHFBUm91WExoOWpHaTZVWk9aaDlGZ1Y2bTVlaUNW?=
 =?utf-8?B?S09yY0NTeFdMNnNZeGxReVBXcWs5Mmg0RU8vOVZSK0V6SXpDZEFEek96VGVv?=
 =?utf-8?B?NStxMVM0MFZpSnl2OVU0ZitHN1Bubm5jUE5BQXdTRXBhQng3RlQzQ0JQTTBD?=
 =?utf-8?B?bjdBSHB5SXltRS9KQmdpMkNKTU1uTk5IdkUrMktQVkFEZUtpdEdyUjI3QmhH?=
 =?utf-8?B?RTYzUmFEbHVWYS9pM0J5MlJkWHpPNnRTRDZleW10MTdQU0JuRzB2QWZDQllP?=
 =?utf-8?B?c1dwTHhiRHlrc1JzTHlaTjJoVU41QmFFdGZKWmVncEk5NHNCRXR6SEgwOVg0?=
 =?utf-8?B?ZFpuUlVCS29MN0cvNnJBYTU3dzB3T2tDMHIvMG9BUVE3NUtMWnAweXVQa1kw?=
 =?utf-8?B?SXF5ekVDa0JjWXNhTE5aRTdPYS8rYWRCbXRDcStNZkVmUEszeGJEOG9TN2oy?=
 =?utf-8?B?QzBkT0pmZWhQbythT0s3aVBxUXRHeGtlMnlRNFZsQldZSUpLbXMxTTY1aXJK?=
 =?utf-8?B?NVByQ0FmNDdOWk0zYzVHZnFpL0tWb3JrdC9xOXlES0FDK05PMnVKNU1NQ1VW?=
 =?utf-8?B?bjN2UXFmdlIyc1ZWR3llTGVvSWFRSGF0aUczVVc1OW1nZm0yTm5Eb0ZGMUNF?=
 =?utf-8?B?SUhBWENobzZxUSsrQ3RGb2R4WDlMQnpJdFRCbGlVcEI5V1ZqRUN3SEFwRUJh?=
 =?utf-8?B?YzUzZlVkb2hXWUZpQ0lhQXVLRmljZnMzQ1UzdVFXb1UwcXlJTHdYMUlRTkZj?=
 =?utf-8?B?TkRFVHl2TTQwSW1NZGNGZG5VenA3YjhBc091WGViU2dmaHZjUnN3Tm8zd2FE?=
 =?utf-8?B?eXI3RHJnVEpQUmVIT0Q3dlpCWU9nY1J1VGw1QVZVd0tVRWtsc2VCcVd2cFox?=
 =?utf-8?B?Y1lKdnV0cFNra3NWdVNxdGtGaG92V0VnNHhOVUN4SlRZSmQ5UDZIUjVQb2ZM?=
 =?utf-8?B?ZDZPdG5KOW9UZ0ZjM2NIZkk5NUh2QjVXV0MxTGorK3NoSkR4QTdNMFhmTllD?=
 =?utf-8?B?cnRsRHRZNmQ0bWJ3ckpibXZPeWZoZTZiUnBiU2dWNG45V1c0R3dseDB4eENq?=
 =?utf-8?B?SkpYVWY3Mlo0N1oyQnhLd0NNRlc3bVBHblZzMlpDZDMyemZ1VzM1MERhcnp1?=
 =?utf-8?B?bFNpUmRGcVFRSVlNdlNqZHV0V2ZCS1lOd3VFQWs4MnZYMFl5K2htWW9uK1Bl?=
 =?utf-8?B?N21RVUJpUDJnWWxoYnlOV0ZnN3hwV0JCM2JnTnBza2pTclNPek43dkE3dXEx?=
 =?utf-8?B?UTNQWCtKbkt0NWtDSWJUOU5xSFVaMVA5Wmd4QUt4MVlSMVhxUnltU3RucnZo?=
 =?utf-8?B?NXhjNHluM3pkaTRSRGlhc1pVcDZ5TjhZY1NuVktOR0piY0lTTWN4OXQzNjJB?=
 =?utf-8?B?aHZCWGdUSXNNSk1VV29za3RGejNsbEtOTnY0dHZhRGRjTERxdG5GL0c2Tlov?=
 =?utf-8?B?SUxmSnFsSlZ5c2xML01OWGRYRGdnRFRqczJFZHNDdVZtK25jdk5QVGRXR1dL?=
 =?utf-8?B?M25rbU0rL0ZockxURXByWno2eWhUeTMyLy9kR295a1N3Mk1mc3d0Rkl3NW5k?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45219F76FE4A49469189F06FDC5805C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f50a502-6776-4c9a-f490-08da92abf88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 21:40:53.3215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbOoyquqc3/owEGFQmUCOluxMsQJmTJu4A80fy4xUXJ/8AvjCdN35U5+7Qniv/39nM9Q59Q7I9m3iUiJSaZTtKJnPOODFTXVhushilu3/dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6410
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTE5IGF0IDAxOjUwIC0wNzAwLCBzdW5maXNoaG8xMkBnbWFpbC5jb20g
d3JvdGU6DQo+IEZyb206IE1hdHRoZXcgSG8gPHN1bmZpc2hobzEyQGdtYWlsLmNvbT4NCj4gDQo+
IGN4bCBsaXN0IG91dHB1dHMgYSBqc29uIGFycmF5IGNvbnRhaW5pbmcgdGhlIGN4bCBoaWVyYXJj
aHksIHdoaWNoIGNhbiBiZSBwYXJzZWQNCj4gdG8gY3JlYXRlIGFuIGltYWdlIG9mIHRoZSBjeGwg
dG9wb2xvZ3kuDQoNCkhpIE1hdHRoZXcsDQoNCkkgdGhpbmsgdGhpcyBpcyBncmVhdCwgd291bGQg
YmUgbmljZSB0byBoYXZlIGl0IGluIHRoZSBuZXh0IHJlbGVhc2UuIEkNCmhhdmUgc29tZSBjb21t
ZW50cyBvbiB0aGUgcGF0Y2hlcywgYnV0IG90aGVyd2lzZSB0aGUgZ2VuZXJhbCBkaXJlY3Rpb24N
Cm9mIHRoaW5ncyBzZWVtcyBmaW5lIHRvIG1lLg0KDQo+IA0KPiBQYXRjaCAxIGFkZHMgYSByb290
IHBvcnQgYXR0cmlidXRlIGluIHRoZSBjeGwgbGlzdCBvdXRwdXQgdG8gc3dpdGNoIHBvcnRzIGFu
ZA0KPiB0eXBlIDMgbWVtb3J5IGRldmljZXMgdG8gYWxsb3cgZGV0ZXJtaW5hdGlvbiBvZiB3aGlj
aCBkZXZpY2VzIGhhbmcgb2ZmIG9mIHdoaWNoDQo+IHJvb3QgcG9ydHMuIFRoaXMgcHJlcHMgZm9y
IHBhdGNoIDIuDQo+IA0KPiBQYXRjaCAyIGFkZHMgYSBzdWJjb21tYW5kIHRvIG91dHB1dCB0aGUg
Y3hsIHRvcG9sb2d5LCB1c2luZyBjeGwgbGlzdCBvcHRpb25zLg0KPiBBY2NlcHRhYmxlIG91dHB1
dCBmb3JtYXRzIGluY2x1ZGUgLmpwZWcsIC5qcGcsIGFuZCAucG5nLiBJdCBhbHNvIGFkZHMgYQ0K
DQpRdWljayBub3RlLCBJIHNhdyB0aGUgZGVmYXVsdCB3YXMgJ3RvcG9sb2d5LmpwZycuIEknbSBu
b3QgZmFtaWxpYXIgd2l0aA0KdGhlIGdyYXBodml6IGxpYnJhcmllcywgYnV0IGlzIGl0IGVhc3kg
dG8gY3JlYXRlIGFuIFNWRyBmaWxlIGluc3RlYWQ/DQpUaGF0IGlzIGEgY29tbW9uIGZvcm1hdCBm
b3IgdGhpbmdzIGxpa2UgdGhpcyBJIGltYWdpbmUsIGFuZCBpZiBpdCBpcw0KcG9zc2libGUsIGl0
IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBhcyB0aGUgZGVmYXVsdC4NCg0KPiBzdWJjb21tYW5kIHRv
IG91dHB1dCB0aGUgY3hsIHRvcG9sb2d5IGdpdmVuIGEgdGV4dCBmaWxlIGdlbmVyYXRlZCBieSBj
eGwgbGlzdC4NCj4gDQo+IFRoaXMgcGFpciBvZiBwYXRjaGVzIGFwcGxpZXMgb24gWzFdLCBhIHBl
bmRpbmcgcGF0Y2gsIGFwcGxpZWQgb24gdGhlIHRpcCBvZiB0aGUNCj4gY3JlYXRlX3JlZ2lvbiBi
cmFuY2guIFRoZSB0aXAgYXQgdGhlIHRpbWUgb2YgcG9zdGluZyBpczoNCj4gDQo+IGNvbW1pdCA4
ZjA0MzNhYmMyYTQgKCJjeGwvZGVjb2RlcjogYWRkIGEgbWF4X2F2YWlsYWJsZV9leHRlbnQgYXR0
cmlidXRlIikNCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jeGwvMjAy
MjA4MTIyMjE1NTMuOTIyNzgtMS1zdW5maXNoaG8xMkBnbWFpbC5jb20vDQo+IA0KPiBNYXR0aGV3
IEhvICgyKToNCj4gwqAgY3hsOiBBZGQgcm9vdCBwb3J0IGF0dHJpYnV0ZSB0byBjeGwgbGlzdCBv
dXRwdXQNCj4gwqAgY3hsOiBBZGQgbGlzdCBpbWFnZSwgaW1hZ2UtZnJvbS1maWxlIHRvIENYTCBj
b21tYW5kDQo+IA0KPiDCoERvY3VtZW50YXRpb24vY3hsL2N4bC1saXN0LnR4dCB8wqAgMTYgKysN
Cj4gwqBjeGwvZmlsdGVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAy
NzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+IMKgY3hsL2ZpbHRlci5owqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDcgKw0KPiDCoGN4bC9qc29u
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNiArLQ0KPiDC
oGN4bC9saWIvbGliY3hsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2NiArKysr
KysrKw0KPiDCoGN4bC9saWIvbGliY3hsLnN5bcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oCAzICstDQo+IMKgY3hsL2xpYmN4bC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgIDIgKw0KPiDCoGN4bC9saXN0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAyNCArKysNCj4gwqBjeGwvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+IMKgbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gwqAxMCBmaWxlcyBjaGFuZ2Vk
LCA0MTIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQoNCg==
