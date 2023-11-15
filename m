Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7+Gw7Cd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6293818B
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 10:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700072416; x=1731608416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PBfYbEiqdyZiARTHeAvjBW9ZtPj7WXbubEUwkfm1ky0=;
  b=N7+Gw7CdZixsnhTql43PIATp8PRw76UMoH0RX5nKx5cFjD0ZH9y9aKjb
   wO144zg1K+ZYT+UXOLSXGil3s3l4UGeLxzkCllKzu3Ult0HgPlxUAdr57
   kPOgS5d++h3DpxkD/9/QriGvleWh8zjIYozJXSU2mUATMEkXIUtr3Dfn1
   aCuvPjsEbFD2kuc3aLNFrWTS/UeWSSh8mTGRrEPtx96T94P8fElC6rOHW
   EOJe1WYfBCvLZWrEAON+mbWsL2q+R2Qbd4MFNpSa4RJlLGx07EOm+UqYo
   hPG8GNQowY7Hid8ojjsgdVmQBIsLOMJQnsCt+M+j10WQqXHQ5tm7uri48
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="12477664"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12477664"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="794235428"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="794235428"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 10:20:15 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 10:20:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 10:20:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 10:20:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 10:20:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cw+qE3pqf8wPde/jB6S7TJNcHWWsRl7yvJKQy7fSg648LlpimwNwKK93A6SgQHoNuLPV9Eebftyyjs7qKEemdtwQ/USI+PaTY5rCWxwBs3zBDbZM9tl51gA0XCtJLOk3dGHZLJ99cKmCAq2wzpeJMkfCGXix+L2pObylvN/u3cCjaxmEHplDqlomQdEWnPix9dYz8PV+KihXaA2iB8X+xeIllN/Hh95gUB5hcepEY1OqioKfLS9olwxHcCaOdCIVuiPmgJi2F9CGUQYbtAax70qKdZ9l9UXBLWVG2giEuRrhkd1mr5fqS73ynWFs3A4QSg7fyxjSBqZdi8xt7sqFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBfYbEiqdyZiARTHeAvjBW9ZtPj7WXbubEUwkfm1ky0=;
 b=U+y/bAHX+9ZPQzF1t0H4icMdXRi1ZdugVSX/EcWx4Rx+nECFgqHqxnPCBFi+QCFypAYTrGuDq3sqykgyxqBUOvjbwR8XsdbVx1GrUJq0lY6JexRhr1viS1rbabkT0699LfX/+/kGQ27LHTLJN9SzpvaCUJ+x0+Bob/QBjLxCOMOS/DjSHT6RCI+rbIFtWSDnkMNW/EJuq5a7OXFoEeqfvJPJ1Mhqp9oEJ0KMJokRu/NgJfadcoLarvepZQccDQyr1sakjBCdNvNbCWnN/nVIQk3S7KfIqPP/IFZ1wW0VaOodSMcmeYDpABZE20O+iWVAkRfLAJ6ziZLWuhKMniMr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DM4PR11MB8225.namprd11.prod.outlook.com (2603:10b6:8:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 18:20:13 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.6954.025; Wed, 15 Nov 2023
 18:20:12 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Schofield, Alison"
	<alison.schofield@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jiang, Dave" <dave.jiang@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Add dev_dbg() detail on failure to allocate
 HPA space
Thread-Topic: [PATCH] cxl/region: Add dev_dbg() detail on failure to allocate
 HPA space
Thread-Index: AQHaFq9PkaqUDn1bok6BHz8MbzSyM7B7s16A
Date: Wed, 15 Nov 2023 18:20:12 +0000
Message-ID: <0f1537ef6a0798d1f59a426834e035e122d856f2.camel@intel.com>
References: <20231114040147.1124696-1-alison.schofield@intel.com>
In-Reply-To: <20231114040147.1124696-1-alison.schofield@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DM4PR11MB8225:EE_
x-ms-office365-filtering-correlation-id: cc611d74-c76e-4851-a9f4-08dbe6078258
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kauuSPU8QpJ2/Cftv6OJzIDvFOwdwazvXDZqnZd9KRSfJtQvazEM/AzkkaPi9RQxEnTn2/ukItQI3m3PpDh8sUI3yogpIBm9+Uf5j3W8lmy1R2clDlbcT8KSupu8JqIbpEkS/F8Jyb8whrGp4wE2WFdakpPSKtxe/JjbKEhLo01J5TbF3IkmMsbMRRzlieSWRGHOgC8yJghDSkKTk1sLM5eerlgTxturwkzyxID3RigMPLrY6sMvnvLp1yU7vnOz0W6zTKHCeV4Z4jFoET0mouDnojcrgQyoHZ1u5uKj6kvHJ1X49wabflqrhgt2UXHuXX+kiTUE4ajbQHMEdBL2zLfCuvN8heH0n/gcanXTvLTFpTEU91CoF9EI2qsc3papRT27KXU8Vk0ubAqMi037JXRlZ8Mw14dIzpVJHMQDMazk1p3tC+o9hpbitd6Rp5JrxCAbZj/fXWgoiAGWU3upd3SvEO9DnU3+Ft7fWICDzHDkBv5kZC1EBWePh+QZN2RcsUTU7csnKk0C/8x1QCb2naSrrXjC5vRTQBWZMNFKW7dRJYgq9RUto9O8pssl6nRoUVaNl5o/qd5h7hrgvAqzXPlJ2bQjwDy2k+7zo3e5NX0vsZzYqFYmA6pwJDxrsRxWjh1Pb2lSSPYtVWfxV0CbDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(921008)(5660300002)(2616005)(6506007)(6512007)(26005)(2906002)(36756003)(83380400001)(66556008)(66476007)(66446008)(64756008)(76116006)(6636002)(316002)(66946007)(110136005)(41300700001)(8936002)(478600001)(4326008)(8676002)(122000001)(4001150100001)(71200400001)(38100700002)(6486002)(82960400001)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGlsQ1NSVkZadkZqS1hjdWVnRUFRZHdpK0ttRWpsdWRGcmpXbGhyKy9QOFVT?=
 =?utf-8?B?czIxVmlyNHlSOENwL0NDQm1pVEM3SVdoZFpZb1p2SXNubDlxSVhBZ3lUTmFu?=
 =?utf-8?B?cStGdGQ1M2ZJVXgxWldoVUk4VGtMVkpkS0ZFQUVraG5HTmFuMXdKYm9vK25L?=
 =?utf-8?B?V3l1dE1BR3dtOUIyU0R4a1JPKzdydWJjUDZtS25vNnRJYzBvZnRCdDJhaEwx?=
 =?utf-8?B?QTRuWkIvQ3RkQkRmUHhiblN4T2ZRUGRQMHY5VFFSSlcvY1dsczdSS05hdjhF?=
 =?utf-8?B?L3lIaDJSbERMYkJGUkQreEc2cXZSTmxyUnVsaEdkOUhoc3FneHl6WTVqZjB0?=
 =?utf-8?B?TDZmK0xMZjFlcE1iWEtEdWJ4T2pNdlg1YVBaMTFWRTN6U3BnRFdIek40dWtP?=
 =?utf-8?B?OEhYVEdwY00rakdhbEN3bEI3TnJqVmQwWXU2clZ5UmFURTVuY3Jxb0w4ZW1D?=
 =?utf-8?B?S1Y4YUpacEdTOHg4cUNkRjIwU29qaUFSNVlUMHJnWHAxUTJjYW1jY0JjVUZL?=
 =?utf-8?B?YjdBby9IbXE0WEQ4SmRHZHBLTFpyTkZnZ2pKZHlIM0lPL2M0ZUJDSDBUcURR?=
 =?utf-8?B?WVp0aHEvK3I2UGwzMjZOeXEyT0Y1VEhxZ3hvYWo3R2hrendQaHpUQzVkOUp1?=
 =?utf-8?B?N0Z2MXVqeFJ3RUphRUdXRUprcm8wOUx1U0RJSkRiNXVhSWkwT05qcGZaQU1W?=
 =?utf-8?B?R2pFSDEwcWZ6NktFQW9UNkdmdWJ4MVl2RHREZzYvT0pIbmFicDBidUhtQTY1?=
 =?utf-8?B?QUJGcUloTm1LVWhOV2NhdmNScDhTMGtxbi9ndlVVQUR2alhibmZKQnRNMnlp?=
 =?utf-8?B?eFI3RkhLN1hhV0FuK1RVQXBXWEVQWmJwQmdRR0MzM1ptdSt2WTJpcjRNRHVN?=
 =?utf-8?B?RTRHdkpueGdDdnRHQmpOVVVyNy8yYldKRkppalBWdXlqNjNGVE9PNEhQZ0JV?=
 =?utf-8?B?QVJxWlVMK0h6Ui9kdVZIYW1SMFlBZy9mWWI3V2lyK0dXQWJUUnovRlJHVDI5?=
 =?utf-8?B?enZJRU9mWlM4d0h0dzVHLy9kNVdQUzhhcHJLUm9OamZPdTQwbVFqNzBmcnh1?=
 =?utf-8?B?T1BaTHhNMjI5U3drU0tBOWswVCtURnJYREdSbXVLdEM2WXoxRWZVMmF4Q2Yx?=
 =?utf-8?B?Q2F5T05xeFVwcVlkVGxOZWV6eVVwMU5HUStZMXZ5eHlqcEhDdG1ibEpTd3cx?=
 =?utf-8?B?RXl3MW04M0pDSE1Ta096cjdnVENibkx5blI4Qjhoc1FnVjZGSmluNkdDTURE?=
 =?utf-8?B?bDFQMWZYNEZmanBPUEFLL2ZOMlUvV0x3cGZDcGdvU1J1N2JUR2FvR2lnejdz?=
 =?utf-8?B?dEJ2aUxSczdUSVdwaHNtTGhBU05ERXhOS0NadG1OckhaQlNjYm5abzQrazFl?=
 =?utf-8?B?OUoraVBoTVNEK1hiSUpIb2tFTGwxMGJYdGdTaGUvektqS204dFBsb05KSFcv?=
 =?utf-8?B?dEQxelVQU3p0c0FvdHFZOXNFNzc0anMwN2dMUVgyV1U0NHZibzlKMmpTYjYx?=
 =?utf-8?B?RWZGUjBCUDV2RnpWSURtN0prWFI4QWVlYzlKTFQ2MXR2UXBSSEVUY25FV0gw?=
 =?utf-8?B?Qm12TEw4UmtZWEhoMUR5aE1KZ0I2VjFVTzFvNis5YjhZNWZJMUtiRUJvYVor?=
 =?utf-8?B?ck1uRlZGeXlaN2FKWjJaR1JTMUFja2Q0YjhnM3JDTkQ4OVM3L21NZG1pZzVT?=
 =?utf-8?B?bmRtemVOT0Mxa2E1RXl6czQwQjZvRWtmRjRibm1vaTVCazlvcWQ3NXVjTW4y?=
 =?utf-8?B?OGZUeC80ZmtFcnlOM2hLNzVJdGo1WDdpalFwZ1BUMnlVY0VuS0RsNGoyRDlv?=
 =?utf-8?B?M1oweW5vUTB0WkFxU0lhUlBkMU0vQnEzSWpiRWZrOEhzMlNSdFhrUEJGeldO?=
 =?utf-8?B?ZURMSnBQTnFiRnVjTFFaWlJ1MFFPNEZqOXZ2T3RrWkw2dFJqaE5yNmY1MnV2?=
 =?utf-8?B?L08vK3JSUndXTm9xdEFKZHY0QTJCUFBwM2NHRlc5ZVpVUHhoSVdNazFmQ2I5?=
 =?utf-8?B?dkk1UlZFOXZwNmZVQUZ1STlXWnUrQWY2Szg5R3ZFR2xiOGNpVVZ2TkpHZSt2?=
 =?utf-8?B?cFo1bzl6UmdpQzl3U2JvVTNlcEYzWFRJMzJXNDlVZTYxQWlDTk5PRUpyWEl2?=
 =?utf-8?B?SlBlMXk0b2ZScXAvazVGREhteFlDTzNuQXgrZlU3Q0duSnBNTlQ2YnEvWVRQ?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D8CE7433715C74194890ACD48203D4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc611d74-c76e-4851-a9f4-08dbe6078258
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 18:20:12.9066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ee8yr05ZVt7HhWgFJkfFBPhsoxWAuIS8rRAlBM8lx6puqRhsiTu84Un7yB+Hl/fVwuUhfhVvlMtJm/X7ZbdOSDA3wEQg0d1XfPU0S6bhXXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8225
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDIzLTExLTEzIGF0IDIwOjAxIC0wODAwLCBhbGlzb24uc2Nob2ZpZWxkQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogQWxpc29uIFNjaG9maWVsZCA8YWxpc29uLnNjaG9maWVsZEBp
bnRlbC5jb20+DQo+IA0KPiBXaGVuIHRoZSByZWdpb24gZHJpdmVyIGZhaWxzIHdoaWxlIGFsbG9j
YXRpbmcgSFBBIHNwYWNlIGZvciBhDQo+IG5ldyByZWdpb24gaXQgY2FuIGJlIGJlY2F1c2UgdGhl
IHBhcmVudCByZXNvdXJjZSwgdGhlIENYTCBXaW5kb3csDQo+IGhhcyBubyBtb3JlIGF2YWlsYWJs
ZSBzcGFjZS4NCj4gDQo+IEluIHRoYXQgY2FzZSwgdGhlIGRlYnVnIHVzZXIgc2VlcyB0aGlzIG1l
c3NhZ2U6DQo+IGN4bF9jb3JlOmFsbG9jX2hwYTo1NTU6IGN4bCByZWdpb24yOiBmYWlsZWQgdG8g
YWxsb2NhdGUgSFBBOiAtMzQNCj4gDQo+IEV4cGFuZCB0aGUgbWVzc2FnZSBsaWtlIHRoaXM6DQo+
IGN4bF9jb3JlOmFsbG9jX2hwYTo1NTU6IGN4bCByZWdpb244OiBmYWlsZWQgdG8gYWxsb2NhdGUg
SFBBOi0zNCBzaXplOjB4MjAwMDAwMDAgaW4gQ1hMIFdpbmRvdyAwIFttZW0gMHhmMDEwMDAwMDAw
LTB4ZjA0ZmZmZmZmZiBmbGFncyAweDIwMF0NCj4gDQo+IE5vdyB0aGUgZGVidWcgdXNlciBjYW4g
ZXhhbWluZSAvcHJvYy9pb21lbSBhbmQgY29uc2lkZXIgYWN0aW9ucw0KPiBsaWtlIHJlbW92aW5n
IG90aGVyIGFsbG9jYXRpb25zIGluIHRoYXQgc3BhY2Ugb3IgcmVkdWNpbmcgdGhlDQo+IHNpemUg
b2YgdGhlaXIgcmVnaW9uIHJlcXVlc3QuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IERhbiBXaWxsaWFt
cyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlzb24gU2No
b2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9j
eGwvY29yZS9yZWdpb24uYyB8IDUgKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2Nv
cmUvcmVnaW9uLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+IGluZGV4IDU2ZTU3NWM3
OWJiNC4uMGU2YTM3OGYxOTEzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lv
bi5jDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gQEAgLTU1Miw4ICs1NTIs
OSBAQCBzdGF0aWMgaW50IGFsbG9jX2hwYShzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hsciwgcmVzb3Vy
Y2Vfc2l6ZV90IHNpemUpDQo+IMKgwqDCoMKgwqDCoMKgwqByZXMgPSBhbGxvY19mcmVlX21lbV9y
ZWdpb24oY3hscmQtPnJlcywgc2l6ZSwgU1pfMjU2TSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfbmFt
ZSgmY3hsci0+ZGV2KSk7DQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKHJlcykpIHsNCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9kYmcoJmN4bHItPmRldiwgImZhaWxl
ZCB0byBhbGxvY2F0ZSBIUEE6ICVsZFxuIiwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBQVFJfRVJSKHJlcykpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZGV2X2RiZygmY3hsci0+ZGV2LA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJmYWlsZWQgdG8gYWxsb2NhdGUgSFBBOiVsZCBzaXpl
OiUjbGx4IGluICVzICVwclxuIiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBQVFJfRVJSKHJlcyksIHNpemUsIGN4bHJkLT5yZXMtPm5hbWUsIGN4bHJk
LT5yZXMpOw0KDQpWZXJ5IG1pbm9yLCBidXQgdGhlIGZvcm1hdCBvZiB0aGlzIHByaW50IGNhbiBt
YWtlIGl0IHNlZW0gbGlrZSB3ZSdyZQ0KdGFsa2luZyBhYm91dCBIUEEgLTM0IGluc3RlYWQgb2Yg
YW4gZXJyb3IgY29kZSBvZiAtMzQuIE1pZ2h0IGJlIG5pY2UgdG8NCnRha2UgdGhlIGNoYW5jZSB0
byByZXdvcmQgaXQgdG8gc29tZXRoaW5nIGxpa2U6DQoNCiAgIkhQQSBhbGxvY2F0aW9uIGVycm9y
ICglZCkgZm9yIHNpemU6ICVsbHggaW4gJXMgLi4uIg0KDQpPdGhlciB0aGFuIHRoYXQsIGxvb2tz
IGdvb2QsDQoNClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVs
LmNvbT4NCg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBQVFJfRVJS
KHJlcyk7DQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+IA0KPiBiYXNlLWNvbW1pdDogYjg1
ZWE5NWQwODY0NzFhZmI0YWQwNjIwMTJhNGQ3M2NkMzI4ZmE4Ng0KDQotLSANCg0K
