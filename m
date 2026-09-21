Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F52EB5A6
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988109; cv=fail; b=pdzshpxlYaEOV53j+bocHgVwuAbfCa3BTGbtCgMPsnaVJxoH8i0NWf4Df6R7vpkEL5ood7TBIDehRJ6AP7g9DbhkH+sXUzZGohUJNCoWXAKEOofWoB/7XDUse2IDllb2vBtSdGls/suucG7n1GgzKB/vOlyf6+lKBP7swAy6r3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988109; c=relaxed/simple;
	bh=58ToUaOmsJ5qFcWgz/mB06LVXwsTky6r/SpybYdnMhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g3ntEpP88ITvtnN/4GORJ+Lf/VMuHOuQzgl8wZMG4rtvKzjbzx9N+b4wN3MdpOC2FM67gLPCojf5p4e5VtoIEHMVbnHeGJXcqDIVSvqKtlKUpEbYBNaIhrpIeXbW0G4K1zyu/CKA1zmLEUz9tfk+MrGCNj1+wPWcqyRvyL8uT2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MbuVYGW8; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MbuVYGW8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CchrcoRu2x+xMo8B1FqqjCVmf1o/cH3oefFnqNO098IsCWS0UNl0EfCi0mtM989ZCHi9/MVyRZFhIVqTwKI9UJW2ZhTWWGB5RYJWQm4F6KQTxJ7EPhnfRrjNdOT/+Njtsxb3679ZhV7wCQLgXXlO28meKQFpoRDH/klkYHWQDK9XqWQ/bKDeNfxHISpiy8EghjKUdW1bQ9Zeda9pfEXBi67LvkaP27b16FbT7wZg8yVaOXLhyh5DXnganKUyf28rKCwm9uSeSnhvneqccOCUXAWBzEuwaZjnRjJ2wHc6dT/kQ/syyAmd97Xv+f53upqr4F1WCzsIgd3kmQxsXlksAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58ToUaOmsJ5qFcWgz/mB06LVXwsTky6r/SpybYdnMhE=;
 b=DPfHfkdptCcNsPHzrZyyOoymYhRMCdhhGPQmrBQHZn61cCLV/+0YIhijaryV3wcR1r3zQA3HWvbfUwetgrPcme9EIEKkP9vG992kGWnKS/B5e8NL55jz5A/HDYLhgTNud83djOhExZKXI6RleeRruCF2Jo0xw0gAHoNBPCn+EETL4G77thb+MFrPhgu+xh/Ko8eHk9KDu08bICM4ejqwuRZL3ypalami68JgFglIfEvvpA+Z4lQce4ot9NqJpH/Drp1uLyLjqThEEGv05icRepatQF+66HYA9r1Fpwiwym6sc6ynuKHoceh9kOjsEa76MWBOEdfomNDwgkzmCzzddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58ToUaOmsJ5qFcWgz/mB06LVXwsTky6r/SpybYdnMhE=;
 b=MbuVYGW8wKziUNZIt1VQ3OxdLbuK/hrl68BcvZ34x14/7q6GLak6kjhNBOrBlBlLGsfU38B8l+Aur8Cf90xpO7gExqhsMhOeqJzwr3bgYlEgsdAky7l51SsdAx6uSb2mxz0Ju7fXibQ9PIEahGnfQh+UbgTJzEIj9wpC8F3AqI+gCgYwnfp0MXCyRakMfs6kthSIjbwhbvce6zMa22eZ6qzsDTXLlXuDwGaNR2dmD7zt/GpZRrzhzuheHmosyjP//vc30lSCOWuDMPl9DGaAznK0WuStOByjgjf60imOQDbETDSYcv6NljQEhaUV2UkxRtUZoibxZqXwMuCklmQWyg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 10:55:03 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 10:55:03 +0000
From: Manish Honap <mhonap@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "alex@shazbot.org"
	<alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>, "pierrick.bouvier@oss.qualcomm.com"
	<pierrick.bouvier@oss.qualcomm.com>, "mst@redhat.com" <mst@redhat.com>,
	"imammedo@redhat.com" <imammedo@redhat.com>, "anisinha@redhat.com"
	<anisinha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
	<peter.maydell@linaro.org>, "richard.henderson@linaro.org"
	<richard.henderson@linaro.org>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: Krishnakant Jaju <kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi
 Wang <zhiw@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v2 05/10] hw/vfio/pci: Back the CXL memory with a
 RAM-device region
Thread-Topic: [PATCH v2 05/10] hw/vfio/pci: Back the CXL memory with a
 RAM-device region
Thread-Index: AQHdRguTzdJjoQl6l0Gpct+MExxJ/7bSzIKAgAYVNZA=
Date: Mon, 21 Sep 2026 10:55:03 +0000
Message-ID:
 <IA1PR12MB90309EDFAF33CB8DFEB51560BD842@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916184412.3825713-1-mhonap@nvidia.com>
 <20260916184412.3825713-6-mhonap@nvidia.com>
 <0991dccb-a123-471c-8a72-e4194da6c596@redhat.com>
In-Reply-To: <0991dccb-a123-471c-8a72-e4194da6c596@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CY8PR12MB7413:EE_
x-ms-office365-filtering-correlation-id: 12cc0fbb-78cb-488b-b9ff-08df17ceca23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|56012099006|4143699003|38070700021|10067099003|921020|22082099003|18002099003;
x-microsoft-antispam-message-info:
 kV+ni6Oihm4aO2bSCg67VWd/YS0YZr7/W+orApKyQodc//s1EOdOvZFHt2JH0FuZdmEddKl5CF5BHgwgwTdNbRcsgA+D7ocIvgHwyAMNGMOgCYSOZvqpVK6k/5ZEK2FlZmJRFTY7uE/nLm2BIZF6VbU2NfZrXSR1VE4gke3kbqD7LSFU69xEI4ZECmpOZtEDYYAG1GFtuXa6IOQ0thQ70QBxDJet8WonOOzcjLz9t+EgNt/nshVd0+byNqKLSkr2pBN99q7iBJui9e4ud/La4trnRBnvNsUeMweRmENJG2S7KCoXEzyX3/hIz/wPlaWcERVU1coqxJc8BoydobWJ9vHOAf6tpMN1/SxxMOdoEzVdmPXl1M4I8r2Q50TChm+zEY34LlV4W5URP1Dcg5bt1Vca/lPsvHdPMxJwetz/C6IhQELtMxX8637nYgqCi2HUsPV5SCSmGNXR6ZvCcdHmHlq/CwfQRdibJNkYE7MJsJyKWtIJayUQWs+DSUuzvnxV6OH9c71Bf9Am9NY9pjahYw3oswvrQm7c1dQRYVikEIC10ET7g0zV2cjVbrSDrms5yK8PInSwHVPf1pEHP2sUOCGPjnb53aausGs84v36re0lhGsufOPogbA2xmBRnqbU3dgp7KBmH3CUv4SCK7mISxrDnTMmLK+xz2uzWQXKM3EIHOO3W3hu7BKrZJmHNMHmDOHWMFff4KUivI11GMthENa77qmsnmgRJPj+ElmZ74YH30GHJhtq6ruvbK4Xrsz9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1Y4aWlKSktWNllUQkNYb2FVUXRibEZhWXlUYjJqQnZ3ejhucm4rZmhhTjRo?=
 =?utf-8?B?dWpzT3R1bXd1Y0lhZjc4WVdUVWRPZGhZN1hVa0pzdXZhbjJIZjdDMXRIR0Nz?=
 =?utf-8?B?ajlqTkYzd1pNSm9CcEw2YUJwTUk4ZEZxdGRHTjluNGtzU3pWWklVTnlHVVR4?=
 =?utf-8?B?QmMybEVFQVRzR0pWY3NDS3VOdkRjMjIzVS96QVg2cGtSZDI4UUt6QnIzN2U5?=
 =?utf-8?B?SVUvaklkeGUzWWlHa2R0NkZhY1FNcG1mdXJNaEtBRVZGWStnVlZmYlc1djB3?=
 =?utf-8?B?L2Z0Mm91WkNaNlFkYmZyTlNMZDV2NlZKQ1NHbm95WDVESFVKdGRXMUFZa3RQ?=
 =?utf-8?B?NTNVaGJzRy9sVEhLc01sMGNlR0ZaRTBiNGlIYllqTXg5blVNb3BNUjYyNFR4?=
 =?utf-8?B?ckhOaDJYQllWbW1DYmFWcGpweEtDNWpoazRtWHFVZ3ZTZkQvTWM3dWtncjBi?=
 =?utf-8?B?RXVwNHk5SkxxKy9QMXp6Yk9CS1JVTGI2VTVBaWxKMlNuM3VNTHVTeEozSUdN?=
 =?utf-8?B?ZFZSUjM2a0IwSXNrTkN0bmVOckRraEFsUnVFRWduZHdXWWt5UjNtejFrWHJq?=
 =?utf-8?B?U0VBR0lHZzVDdlJuTUpaZmxLcGNSZklsRWJ5b2VINlZoTk1FdjZRUjdFdVVT?=
 =?utf-8?B?RjI1WHRJbjE5YWNheFd2bFQyY2ExVk9ydHdCUzRQclNpbTBPYStraGpKVFZF?=
 =?utf-8?B?RG50VWsvTFRZYWUxUWhUVTdydG0zYXdWNGZhY3pVZURMcUJBNnlmMDdOSHR6?=
 =?utf-8?B?WWdFUGJIU1JWQzI3VnFONFhvc1ZvNitkdk1Qa0NIbkFSdDRkZHl0Y3JpMXI3?=
 =?utf-8?B?QW9OK3NiRzU2RkYxZVVvS0dSTGdzbUJ3anpUcmxtVlp6dVpMN1JWdDB0Z1M2?=
 =?utf-8?B?aTVzZnB4WkRYblplOWs1MDhmM01aa3lJVFFadDd2Mlp5RlkxL2hDbUNyWnhY?=
 =?utf-8?B?UEFHMTBoZTdnOGdlTWR0OC9nNjgvWXVYOHBBcGJmVCtKNlFueDZsNkt2WkJv?=
 =?utf-8?B?b1JzUWNPbjYxci9hcEdXWnJHTDFzZFMyU2pIZ1B6eTVwUlZINzB2ZXFiNzgz?=
 =?utf-8?B?ZDI1TkdnbzR3cGsyckhzUGNGZkI3a1FObU1FOFZ0Z3l5Tmh1WmgrOFJDY1d1?=
 =?utf-8?B?bjROOElXcXgrMHIwTmRjdG01Qk95TmhZZmd1WDFDVlMwWGNzMkF1MTVhamRF?=
 =?utf-8?B?dFh6VE5GQXJDMnROczN4OHZWNm1pRDJSbHkwTGxyanpPb1BQSlpJN216Ky9W?=
 =?utf-8?B?Q2YweWhNWDdzNW9VVWVHS2h4aFZIS0pIYmR5TTZVZ0dzbGh4dllMTnZDSUw0?=
 =?utf-8?B?alJYcjFTWUF2T1JsYTZJTWxJS0k3K084bEdTNWdMZDUwNUlETWdOSmhoVUk3?=
 =?utf-8?B?STgrUXhoZW80eDlQeEZoZFdSbXdjSjhVOWNCb3lZSGFMRHQvOThnT2NyMFhr?=
 =?utf-8?B?a3JFQVFCaGtMcFRIdVZHRUJ2TWp1OCtHVURTbnlUVjFic3BWRzlDZ1lKRHVB?=
 =?utf-8?B?bkJPYzRkR2VVUkdpOUpFTDJ0ZUQ0Ynd4TTQ5KzZMNTRBajdoSjhZcGRxS3pt?=
 =?utf-8?B?TGgzRUNUZlZicGFkMU1UUmhKblhnTUVxNDVoenA0VGhMVXRCbGNNT1BOamlm?=
 =?utf-8?B?TGxDMkg1Qm5HQU5KTmxMaDVIZWJwR2JOcVFKNkoxaTZQMGZsTzkwdzFkV2RB?=
 =?utf-8?B?M0hBYWRsMllCL1p3Y0lIVlJjTE0yTmNKcy9oUUsyU2w1bVA5ZHJjSXpHOW1y?=
 =?utf-8?B?b2Z1a1YyMm5UcmdMdU5YTmpCMmZIbHlqYUFQcGRuclk5dFl2SmxEY1lCa1Zj?=
 =?utf-8?B?RmhqK0cwNlJycjlhanVkU1habG1yUlRuRytnZlRQUVAzTVUxVTU0bVBvbkQx?=
 =?utf-8?B?TEczZU53VklVSnN5aTBFeWFvUTZUSjVsTzRBR3BTeVFGMGlBUXUzSWc3OFIx?=
 =?utf-8?B?bjc1UkJod2ZCenkyRDIzSk1KRDN6MUt2a1RsUnk4LzdqMkl2bVpESmRBNm45?=
 =?utf-8?B?VWxmUFVqRWxCeGY4M0xXWmdiMXFnclUvS0xPRE1FWm1zNGNQa2srY2xpSE1M?=
 =?utf-8?B?WGdjbzIrODJvOFAya0ZMUVhISUFjQklvQ1Z6c0xxMXZtSXpkdkFqaWVhRHNi?=
 =?utf-8?B?eUszTVoraVdVWDBCMVZZZEN1alhpamUxeXNQNU9tVUQxbkFGaHVxUUVuanhr?=
 =?utf-8?B?ZHJqZzBkdnJNUUFjK2xsaXNvZGZPTHgvbG10b3grODV4ZWdacHl6d2dYenEx?=
 =?utf-8?B?UUNsVmRWL1pvck0xRGFqN1hFb2Zmb1piNnFHUDJENDhoZGhrS3hOUk5rWngw?=
 =?utf-8?Q?fjjb2ntitlKYoLKHVs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cc0fbb-78cb-488b-b9ff-08df17ceca23
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 10:55:03.1114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1+F9KysHBA161Hg4Aq1ZkQp9wXGdDCjwciFXLwrmt7Jc5pCmz/b9BnhU3aOHBTgYZQ/EmEpyNQ+4drRrdso3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE3LCAyMDI2
IDc6MjYgUE0NCj4gVG86IE1hbmlzaCBIb25hcCA8bWhvbmFwQG52aWRpYS5jb20+OyBhbGV4QHNo
YXpib3Qub3JnOyBBbmtpdCBBZ3Jhd2FsDQo+IDxhbmtpdGFAbnZpZGlhLmNvbT47IGppYzIzQGtl
cm5lbC5vcmc7IGRhdmUuamlhbmdAaW50ZWwuY29tOw0KPiBhbGVqYW5kcm8ubHVjZXJvLXBhbGF1
QGFtZC5jb207IFNyaXJhbmdhbiBNYWRoYXZhbg0KPiA8c21hZGhhdmFuQG52aWRpYS5jb20+OyBw
aWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb207DQo+IG1zdEByZWRoYXQuY29tOyBpbWFt
bWVkb0ByZWRoYXQuY29tOyBhbmlzaW5oYUByZWRoYXQuY29tOw0KPiBwYm9uemluaUByZWRoYXQu
Y29tOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsNCj4g
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsgY29odWNrQHJlZGhhdC5jb20NCj4gQ2M6IEty
aXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+OyBWaWtyYW0gU2V0aGkgPHZzZXRoaUBu
dmlkaWEuY29tPjsNCj4gWmhpIFdhbmcgPHpoaXdAbnZpZGlhLmNvbT47IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNS8xMF0gaHcvdmZpby9wY2k6IEJhY2sgdGhl
IENYTCBtZW1vcnkgd2l0aCBhDQo+IFJBTS1kZXZpY2UgcmVnaW9uDQo+IA0KPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+
IE9uIDkvMTYvMjYgMjA6NDQsIG1ob25hcEBudmlkaWEuY29tIHdyb3RlOg0KPiA+IEZyb206IE1h
bmlzaCBIb25hcCA8bWhvbmFwQG52aWRpYS5jb20+DQo+ID4NCj4gPiBtbWFwIHRoZSBrZXJuZWwn
cyBIRE0gbWVtb3J5IHJlZ2lvbiBzbyBpdHMgaG9zdCBwaHlzaWNhbCBwYWdlcyBiYWNrIGENCj4g
PiBSQU0tZGV2aWNlIE1lbW9yeVJlZ2lvbi4gSXQgc3RheXMgb3V0IG9mIHRoZSBndWVzdCBhZGRy
ZXNzIHNwYWNlIHVudGlsDQo+ID4gdGhlIGd1ZXN0IGNvbW1pdHMgaXRzIGRlY29kZXIgYW5kIFFF
TVUgbGVhcm5zIHRoZSBHUEEgdG8gcGxhY2UgaXQgYXQuDQo+ID4NCj4gPiBBSS11c2VkLWZvcjog
Y29kZSAocHJvdG90eXBlKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hbmlzaCBIb25hcCA8bWhvbmFw
QG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gICBody92ZmlvL3BjaS5jIHwgMzQgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaHcvdmZpby9wY2kuaCB8ICAxICsNCj4g
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2h3L3ZmaW8vcGNpLmMgYi9ody92ZmlvL3BjaS5jIGluZGV4DQo+ID4gMTBiMTNmMjAwZC4u
NDcxNjI2NjU5NSAxMDA2NDQNCj4gPiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+ID4gKysrIGIvaHcv
dmZpby9wY2kuYw0KPiA+IEBAIC0zMjIxLDggKzMyMjEsMTEgQEAgYm9vbCB2ZmlvX3BjaV9wb3B1
bGF0ZV9kZXZpY2UoVkZJT1BDSURldmljZQ0KPiAqdmRldiwgRXJyb3IgKiplcnJwKQ0KPiA+ICAg
ICAgIHJldHVybiB0cnVlOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIHZmaW9fY3hs
X3RlYXJkb3duKFZGSU9QQ0lEZXZpY2UgKnZkZXYpOw0KPiA+ICsNCj4gPiAgIHZvaWQgdmZpb19w
Y2lfcHV0X2RldmljZShWRklPUENJRGV2aWNlICp2ZGV2KQ0KPiA+ICAgew0KPiA+ICsgICAgdmZp
b19jeGxfdGVhcmRvd24odmRldik7DQo+ID4gICAgICAgdmZpb19kaXNwbGF5X2ZpbmFsaXplKHZk
ZXYpOw0KPiA+ICAgICAgIHZmaW9fYmFyc19maW5hbGl6ZSh2ZGV2KTsNCj4gPiAgICAgICB2Zmlv
X2Nwcl9wY2lfdW5yZWdpc3Rlcl9kZXZpY2UodmRldik7DQo+ID4gQEAgLTM2OTYsMTEgKzM2OTks
NDIgQEAgc3RhdGljIGJvb2wgdmZpb19jeGxfc2V0dXAoVkZJT1BDSURldmljZQ0KPiAqdmRldiwg
RXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICAgfQ0K
PiA+DQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogVGhlIEhETSBtZW1vcnkgaXMgaG9zdCBwaHlz
aWNhbC4gU2V0IHVwIHRoZSByZWdpb24sIHdoaWNoIGluc3RhbGxzIHRoZQ0KPiA+ICsgICAgICog
ZmQgcmVhZC93cml0ZSBwYXRoLCBhbmQgbW1hcCBpdCBmb3IgZGlyZWN0IGd1ZXN0IGFjY2Vzczsg
aXQgaXMgYWRkZWQgdG8NCj4gPiArICAgICAqIHRoZSBndWVzdCBhZGRyZXNzIHNwYWNlIG9ubHkg
b25jZSB0aGUgZ3Vlc3QgY29tbWl0cyBpdHMgZW5kcG9pbnQNCj4gZGVjb2Rlci4NCj4gPiArICAg
ICAqLw0KPiA+ICsgICAgaWYgKHZmaW9fcmVnaW9uX3NldHVwKE9CSkVDVCh2ZGV2KSwgdmJhc2Vk
ZXYsICZjeGwtPm1lbV9yZWdpb24sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgY3hs
LT5tZW1fcmVnaW9uX2luZGV4LCAiY3hsLW1lbSIsIGVycnApKSB7DQo+ID4gKyAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgaWYgKHZmaW9fcmVnaW9uX21tYXAoJmN4
bC0+bWVtX3JlZ2lvbikpIHsNCj4gPiArICAgICAgICAvKg0KPiA+ICsgICAgICAgICAqIFdpdGhv
dXQgbW1hcCB0aGUgcmVnaW9uIGZhbGxzIGJhY2sgdG8gdGhlIGtlcm5lbCdzIGZkIHJlYWQvd3Jp
dGUNCj4gPiArICAgICAgICAgKiBwYXRoLCB3aGljaCB3b3JrcyBidXQgdHJhcHMgZXZlcnkgYWNj
ZXNzLiBXYXJuIHJhdGhlciB0aGFuIGZhaWwuDQo+ID4gKyAgICAgICAgICovDQo+ID4gKyAgICAg
ICAgd2Fybl9yZXBvcnQoInZmaW8tY3hsOiAlczogZmFpbGVkIHRvIG1tYXAgdGhlIEhETSBtZW1v
cnkgcmVnaW9uOyAiDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgInBlcmZvcm1hbmNlIG1heSBi
ZSBzbG93IiwgdmJhc2VkZXYtPm5hbWUpOw0KPiA+ICsgICAgfQ0KPiANCj4gdmZpb19jeGxfc2V0
dXAgY2FsbHMgdmZpb19yZWdpb25fc2V0dXAoKSB0aGVuIHZmaW9fcmVnaW9uX21tYXAoKSBiYWNr
LXRvLQ0KPiBiYWNrIHdoZW4gb3RoZXIgJ25vcm1hbCcgQkFScyBzcGxpdCB0aGVzZSBjYWxscyBh
Y3Jvc3MNCj4gdmZpb19wb3B1bGF0ZV9kZXZpY2UoKSBhbmQgdmZpb19iYXJfcmVnaXN0ZXIoKS4g
SSBndWVzcyBpdCBpcyBmaW5lIGZvciBDWEwgc2luY2UgaXQNCj4gaXMgbm90IGEgUENJIEJBUi4N
Cj4gDQoNClllcywgSSBhbHNvIGhhZCB0aGUgc2FtZSByZWFzb25pbmcgZm9yIHRoaXMgcGFydC4N
Cg0KPiA+ICAgICAgIGN4bC0+ZW5hYmxlZCA9IHRydWU7DQo+ID4NCj4gPiAgICAgICByZXR1cm4g
dHJ1ZTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCB2ZmlvX2N4bF90ZWFyZG93bihW
RklPUENJRGV2aWNlICp2ZGV2KSB7DQo+ID4gKyAgICBWRklPQ1hMICpjeGwgPSAmdmRldi0+Y3hs
Ow0KPiA+ICsNCj4gPiArICAgIGlmICghY3hsLT5lbmFibGVkKSB7DQo+ID4gKyAgICAgICAgcmV0
dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgaWYgKGN4bC0+bWVtX3JlZ2lvbi5tZW0pIHsNCj4g
PiArICAgICAgICB2ZmlvX3JlZ2lvbl9leGl0KCZjeGwtPm1lbV9yZWdpb24pOw0KPiA+ICsgICAg
ICAgIHZmaW9fcmVnaW9uX2ZpbmFsaXplKCZjeGwtPm1lbV9yZWdpb24pOw0KPiANCj4gSG93ZXZl
ciwgdGhlIHRlYXIgZG93biBzaG91bGQgYmUgc3BsaXQgYmV0d2VlbiA6DQo+IA0KPiAxLiB2Zmlv
X2V4aXRmbiAodW5yZWFsaXplKQ0KPiAgICAgZHJvcHMgbW1hcHMsIHJlbW92ZXMgc3VicmVnaW9u
cyBhbmQgcmVtb3ZlcyByZWZlcmVuY2VzIHNvIHRoZQ0KPiAgICAgTVIgcmVmY291bnQgY2FuIHJl
YWNoIHplcm8uDQo+IDIuIHZmaW9fcGNpX2ZpbmFsaXplIChpbnN0YW5jZV9maW5hbGl6ZSkNCj4g
ICAgIGZyZWVzIHRoZSBNZW1vcnlSZWdpb24uDQo+IA0KDQpva2F5LCBJIHdpbGwgbW92ZSB0aGlz
IGFzIHN1Z2dlc3RlZC4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gPiArICAgIH0NCj4g
PiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIHZmaW9fcGNpX3JlYWxpemUoUENJRGV2aWNl
ICpwZGV2LCBFcnJvciAqKmVycnApDQo+ID4gICB7DQo+ID4gICAgICAgRVJSUF9HVUFSRCgpOw0K
PiA+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5oIGIvaHcvdmZpby9wY2kuaCBpbmRleA0KPiA+
IDdmZGQ2OTU3MDQuLjA2ZDE1ZTgwN2QgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdmZpby9wY2kuaA0K
PiA+ICsrKyBiL2h3L3ZmaW8vcGNpLmgNCj4gPiBAQCAtMTM0LDYgKzEzNCw3IEBAIHR5cGVkZWYg
c3RydWN0IFZGSU9DWEwgew0KPiA+ICAgICAgIHVpbnQzMl90IGNvbXBfYmFyOyAgICAgICAgICAg
ICAgIC8qIGNvbXBvbmVudCBCQVIgY2FycnlpbmcgdGhhdCBibG9jayAqLw0KPiA+ICAgICAgIHVp
bnQ2NF90IGhkbV9vZmZzZXQ7ICAgICAgICAgICAgIC8qIGJsb2NrIG9mZnNldCB3aXRoaW4gdGhl
IGNvbXBvbmVudCBCQVIgKi8NCj4gPiAgICAgICB1aW50NjRfdCBkcGFfc2l6ZTsgICAgICAgICAg
ICAgICAvKiBzaXplIG9mIHRoZSBIRE0gbWVtb3J5IHJlZ2lvbiAqLw0KPiA+ICsgICAgVkZJT1Jl
Z2lvbiBtZW1fcmVnaW9uOyAgICAgICAgICAgLyogSERNIG1lbW9yeSwgbWFwcGVkIGF0IGNvbW1p
dHRlZA0KPiBHUEEgKi8NCj4gPiAgIH0gVkZJT0NYTDsNCj4gPg0KPiA+ICAgc3RydWN0IFZGSU9Q
Q0lEZXZpY2Ugew0KDQo=
