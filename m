Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795025741;
	b=TH4Pb713jKTOMu2XOIhZeWBiXGLfgxB2R/XKA9fkiLNkcFQYxUoae7zJtnwQ0zllcHBO
	 H8hyTiZCIdrRH5i4PsspvXvXsKQytO6ezplTujDbW8Y7QAaFtyM8Jqfb15vLIfSkSiF9u
	 rMe5BjqNhVOUP+D1K3819Qf9ibDLH0xEs2DNvINaM+lmemE0OW6PZ3/IlN02NhgY5Rv8p
	 7HYlTpC1b8FtrZa6vm9mkOqCsZj5Zw7fOgOWSXIbyLKUJUP8tXrXGfHfSASYyre08HPsb
	 i5o9vtuaV/Dt1H4lR3WPLFOt/JdAvm+c2sYs3PWlW6Likorf9C/eBebEuI6a+PPEnLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025741;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oYfQZSZ4rU41tyj1yiviiuyJBZdj8z0mGlbOhsssmD4=;
	b=nuRoJVyLJVM3VH7H75/viOdsp4j847HXsaP0FeNGDXzvOPCuNNgq8fXph3Gis4+9uGBs
	 zjszSbCXyPSwgF/byHkBc4TgPYAGEU3kZ5eq5RYOIPjLUBCYQYxagckoQwncdqUUTOr2X
	 eyVaEQg17qAcPMrE20Xk3IuEapvXoOrRYVkryNuaL+g27ijCVl5OiEoD3icx6ZmlvcJXi
	 xccHkfg8STA5Ljlg6QYjmzZRKn6cr4m+w1y963JZgHJGtEqpH+zQ+MwXHDYwVUS8/nbk9
	 BcTYtFHyWdiwlUMOB4EtMmeARlRbNCibE7y49eH75/wUBZVVH8+vbg3t40cK99EwNdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HaRF4ZM+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.68
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318F60A2603
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 18:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5318F60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HaRF4ZM+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skTwFlcOeij/TveQYUffXQJWslqtkx/fUBFnlpS16TXCkiDosqAxwhvqdwOo5xF9A57re1qXB5zZZ/+vtOFYOsmoJykJfomzBXClD7VogzTOCbcI5kNtgdhKzpbIIK1SuCdW8DVowYRlCVdj0tYi/Ns3MEbXn+Z7w4ojIer2r9iwLF7GQt+9hzTzyCZ1mPF2dv0P1LKkcHudVqsKSNRq0oLEhy91lOog+/KUdEIXFoNDFxCrmN2fLUzQGSPYul2apSsmD3sT9uELcL3qGjJmpK03kwhUzQmgO5Uw7EkKkgF66JYec3MzIU88fP9HjnTPnJVmH7qLD9d1rLExy1Gl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYfQZSZ4rU41tyj1yiviiuyJBZdj8z0mGlbOhsssmD4=;
 b=bkVeFbt0oJuKbvPLjzf9z+2o7huVsrd9QCmnYvlgqmP9n4npgON2/XFRmgb34HlC4Wl9tn4EF9gF6WO4SDiLw0RqO5EIYw8HBuQwcActQ6x0fbIywyekvM+pte63cQMowV/00ypjWsmuzzcur3iik3W4f1thUWHLYsK/oYF0BGT3sc8cxDh6nMxpsUmzuceSG+ZWC4eSRP7g041CWxU6cI9CcRMjKipMfrEucylTNgyAcaTjPSxrr/OFP52IeF9L8YJ4DYmd63FtuhmZUU2ZrL+mjypw0OIchO9NQalTmXeHYVTMgmB2HNrK5O9TZcLp3kPF0x8Xis3W+Hj0vo08lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYfQZSZ4rU41tyj1yiviiuyJBZdj8z0mGlbOhsssmD4=;
 b=HaRF4ZM+83Q/8aGgqiEk/7cfzkA+fvAC79M6RNCy74s8d50m2e/vSmPqy9rmF8dc1qPYJEM25z1BzOIOhNU1c3OwepIIMAFtGyT0e0VFG7o+Tb0jq+eVPq356+Ggm3Glf7jXsNIwmQVWRYLxUpycIxlb1ioRqzkrNjYhEmbcMV4LkZCMCG1FAGImj9tTKrVQfQBnrqlrp8eZkPgIyPz1s3/wQOOyUTLJl/QMkab6DQ1cs4nuEC6QnB5A3Aoc5/tRj01vkKZidC0DqojgMEOpbUx8fheHVgHHtVbkQMkY0LEUEeWin1BkqLP11A8gVeXkw+RXTuSVgzJ6CWYVehirEA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Wed, 18 Nov
 2026 18:15:36 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:15:36 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Alex Williamson <alwilliamson@nvidia.com>, "clg@redhat.com"
	<clg@redhat.com>, "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, Zhi Wang <zhiw@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>, "pierrick.bouvier@oss.qualcomm.com"
	<pierrick.bouvier@oss.qualcomm.com>, "junjie.cao@linux.dev"
	<junjie.cao@linux.dev>, "anisa.su@samsung.com" <anisa.su@samsung.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Ankit Agrawal
	<ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Shameer Kolothum Thodi
	<skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Neo Jia
	<cjia@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Yukiya Takaki <fj2110jc@fujitsu.com>, Manish
 Honap <mhonap@nvidia.com>
Subject: RE: [RFC 00/18] hw/cxl: Add a CXL Type-2 device
Thread-Topic: [RFC 00/18] hw/cxl: Add a CXL Type-2 device
Thread-Index: AQHdbaNI9BestQseBkmfHNtrqrfRx7cptaCAgAqAeBA=
Date: Wed, 18 Nov 2026 18:15:36 +0000
Message-ID:
 <IA1PR12MB9030985CC6D7060CC7511C10BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
 <20261112015219.55bb312a@jic23-hlaptop>
In-Reply-To: <20261112015219.55bb312a@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|IA1PR12MB8263:EE_
x-ms-office365-filtering-correlation-id: 7f963814-5f9e-4ae8-38d4-08df459ff1be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|4143699003|11063799006|260925021311599003|56012099006|260925021911599003|260925022911599003|18002099003|22082099003|10067099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003;
x-microsoft-antispam-message-info:
 iAHihCLzSV6E4h41+lDEx/BOCe0m/GFYehYiEmSJ6Y5RL2ZCxyBvg6+ra9Ae8Nz/3aM89wJOe2tQuO/CmfnMuT1wHkmAUzECMCgFu2gmxQ/LbQR27nB0paHL3RqVTUcCOnnA+GEIIsmv/eO3IxMPK8iohGzSvpSkBWJ8DkjkoP5PSIBJsy+wawy2T7KM/j3YDUyJTVf/+lhXfjnCOfkQ1OSGLMs0mQLl+BhCUNNJlDfX9A1kdMYkKGNA6qk280yFi6l/EIPUYTcPVlRTE3XXnrOchRdwr+l7rm9XQOfNNMZqhIGwVjIpeA8aIWg7c2MiJfrClrRs+4yw8CH67mVraYs20xOEs0sy5en6qZF6q7stT5XsohF4DpSZAedu8xosQp61abZrsbae4tIhyVtIQTM7Cyu/rArexId8U0/FW3e9IEvAYyRg5yDuTkqxWZlM1lSTtdYO9g90GcpWLjWv5f09wLy35cLu1YKV4s7QyMfOmMNGo7Mt0lIBxQt4PSu+zdkGW0o0/ql/zPRwVn2dSboC4b/pg9DSjVK6T82psSFIOLZFDIJUDDoM+pPa95L7TTGhgPucas7sycQ1YdaXlKVC1AIPwdRGD5Yt0hIhtsQyus9FU5XeAsMRLTVLfV9gwzt5eBfaLkihHa7fhNxFfrUF1OP5ek7ix+fdkjgbPeHosernU6dZXxdmc5o8zUAJJ+cJytZE9CwpNb49kKDhDqud49feeihXHYQDsCxvB88=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(4143699003)(11063799006)(260925021311599003)(56012099006)(260925021911599003)(260925022911599003)(18002099003)(22082099003)(10067099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDRBNnhKMmVqTHMrZWxFMENJTFBNa2gvaDRpbGxwNmVDbThtV2xveUtNU2px?=
 =?utf-8?B?UC9OallhUXJhcFhGbUU3c1JYSGpJaTNaWElrWk8vRTRnQ1BWK3g4bUtlQThK?=
 =?utf-8?B?azdaT3BuTlBzVFBSL2JkNEkrLzI4Um1sOVFHK3RSYmhyZk91WjJaSVErNjNX?=
 =?utf-8?B?YktLS2Z2NUFmN2RxMFVJTVlISE1QcFV5djdBeE5keTdHRkNWWGpxTmFWenln?=
 =?utf-8?B?Kzdhb1E1Y3cxVVZ4Y0hrRXk2UWdpQVkycGZOTVNiN0JLU0YrNENneFQ1M0d1?=
 =?utf-8?B?b3A0MlVpdEpEeElUUWxMbFJlRkg4ZVlzVnNtWmwyQTZ4V1lxVmhHUTdGZG9z?=
 =?utf-8?B?VC9sRjRGRzlBVWZ2b3JpZmZxb1dEM1hkZHdGY3EyNFE0MFQzcjFMQk55d2xu?=
 =?utf-8?B?UzVaYlQrSGJYZkV5QmFZb3lDdkw1QzAzVE5BV1VRRVo1L0dkbmpSQ2F3bmpa?=
 =?utf-8?B?OG9laWRsS21IN2VtbWhFZVdqWkRmMitzTXRhZnBnWk50SndxOGxQeVVDUjVF?=
 =?utf-8?B?UU9McG0xT1IzczE2ei9ieVgwb2REY0I1SXZLUFNtUGRSZ1N5dFNWWkhsZ0Rm?=
 =?utf-8?B?YVRCV0NNM281WVJKWERFUUs5d01MbWZUTkFoR1A5NENDN0hYTHc5dUI2dlE4?=
 =?utf-8?B?TnUzYzhZZXhqc3NSc2UxQXJNNndxaENqNmt2aU5lTGRZZ1NDaG9uT05LR1dG?=
 =?utf-8?B?Qy9jdlZ1b242YWtBVlZpWjBXNk84Mk1ZY1krUjhUWEhnNTZMZVJyK1JNb1kv?=
 =?utf-8?B?TFRZQ2tBRjJ2WGVMempTTXZ2RjUvcFo0T0JJZHJIeTFQVE9ZSWxyRUdQeUo2?=
 =?utf-8?B?amYxUzRRTW9jVVZQQWRPeVJmbThKMHFQaUlnZ2RKTVhLeTdjbW5ZT0JGbUxZ?=
 =?utf-8?B?UUpPemlOK2NBWWRsbExkMFZOZE5oYnNjb01yWU5ldE5MY3JrNWFFZGFRa2hx?=
 =?utf-8?B?M1g5OWpRdGhUOXdWTGN6V3poN2toZERLM1BJYldCZHpEUDdtRUtjblhlUDNI?=
 =?utf-8?B?bTI0d3NwZGFKc3dxSmFOSnFnRThqTnFtOWxudHRqdytlSGZOTDBaYTZDTG80?=
 =?utf-8?B?c2E5NDU0NkUyaVhkUms0KzZxV1RyUFBFNmYvenZyY3dtbnZpTC9yOExud1A1?=
 =?utf-8?B?dlZndFQxUCtwUU1MQUt6MVdiRDVCTmIzUlNVa3lUQjk3QWV2cGxQdHFJM0hP?=
 =?utf-8?B?b1lBNUZsWDlrUy8xaDMrZ0tvaHlrMVdBMUQ1RHlvaElPYWhVMGJiK3ZObmVK?=
 =?utf-8?B?b1hLWFRDZEErRVdKT205SWo4c0JvTlhWYk9lamJSSHJHQW5LakIzNmdnRW9x?=
 =?utf-8?B?NTNBV1h3RjUrRnk0WEEyK3VmZkM0UisyczYzbVZ1MWFjMGh6TVp1OXFscUdh?=
 =?utf-8?B?c21VbUVvWXVzcDdyZEU5SUZqTGFtV3BJc2txN3pzaFJ0eEdXcHJOdDdIQWRp?=
 =?utf-8?B?Ui83Rm9XdW5NK3IvM3pTcW1jS09ZN3FnRnA2Q3liemYrRExtakF4dGlRV0pa?=
 =?utf-8?B?UlZId1lrTVdVejAyb2d6TFpVV3RUWlNLeGE2aXFYT3RDeDFXUlNHTnRDaWNx?=
 =?utf-8?B?SEhKaHNTQmVPVGJ5dzBSQytnL1l2YWJJS3ZRQmNvejdUSFJNbjJsaDVycnN3?=
 =?utf-8?B?ektOUFM1aUJxdG9Xb3NqaHJjYXlDaUtObHNzYjJTUVdFTWxGNFZVTlpxempX?=
 =?utf-8?B?MFhGbVVhNk5wY0g3dFZDOFZ4VkkzSWxOUmNYNTdCYk5CY3A1TzlVQ1lHdi9X?=
 =?utf-8?B?RS9wWkZwaU1Gb09IMVZrZ01jdm1CVFFlTDF3T2tDZXdraXZIalR6bCtRSjYr?=
 =?utf-8?B?TjVyNUFxWnR0Y0hCMVptYmRab0xyeGQwMEJCZVFCQWVFYmQ1dWhnSFFlVS91?=
 =?utf-8?B?VnNJUDNiTHVNVUY5Y3FyenAzTnVuOS9DNlVTMi9wQWJxczRDLzQydHNyUnpK?=
 =?utf-8?B?bVlOZ3RYWUxsOWhtOFVzSUwzMUk2Z2UrYU5zbmVIL2dpU3EvZm5XVUdTbDJr?=
 =?utf-8?B?UWxJVDViRTMvTWpRUWZ1a3VpYjRZYVhIK0ZXT3dVY2g5RkFxa1pleVg4UXph?=
 =?utf-8?B?a1hIWnpVWG1zK3lUc3d3MURtT0RWV1ZIcmh3R2ZySmwzTmNYZXVWeHVQcE1q?=
 =?utf-8?B?WmhwK1JEdU0ra1QyUUhrVmRwZVAyWTFsMk1xQWlBeUlJUWVQM0hqcWMydTdV?=
 =?utf-8?B?T1NxekJIeDhQVjE1UXJLQXFHck8xa0pSbjE5S0syMEpMVnFNREVUQmhpSW9G?=
 =?utf-8?B?TG5GaW95RGxvT3pacldrYW1sZDVzc2x2TmUxWU9RdExjbXd3WklIbnp4S05r?=
 =?utf-8?Q?9OsVRYvPIkl7gu5SAw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f963814-5f9e-4ae8-38d4-08df459ff1be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 18:15:36.6744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOnetP69a5Hn/u1IO92nWP2vQ9CKA2SUFIEULkwOKqP73cx/GgkRsPLOH8DrUGe403gSumJL91UO96DlbKAsRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDEyLCAyMDI2
IDc6MjIgQU0NCj4gVG86IE1hbmlzaCBIb25hcCA8bWhvbmFwQG52aWRpYS5jb20+DQo+IENjOiBB
bGV4IFdpbGxpYW1zb24gPGFsd2lsbGlhbXNvbkBudmlkaWEuY29tPjsgY2xnQHJlZGhhdC5jb207
DQo+IHh1ZXNodWFpQGxpbnV4LmFsaWJhYmEuY29tOyBpcmEud2VpbnlAaW50ZWwuY29tOyBaaGkg
V2FuZw0KPiA8emhpd0BudmlkaWEuY29tPjsgbXN0QHJlZGhhdC5jb207IHBpZXJyaWNrLmJvdXZp
ZXJAb3NzLnF1YWxjb21tLmNvbTsNCj4ganVuamllLmNhb0BsaW51eC5kZXY7IGFuaXNhLnN1QHNh
bXN1bmcuY29tOyBwYm9uemluaUByZWRoYXQuY29tOyBBbmtpdA0KPiBBZ3Jhd2FsIDxhbmtpdGFA
bnZpZGlhLmNvbT47IFZpa3JhbSBTZXRoaSA8dnNldGhpQG52aWRpYS5jb20+OyBTaGFtZWVyDQo+
IEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IE1hdHQgT2Nocw0KPiA8
bW9jaHNAbnZpZGlhLmNvbT47IE5lbyBKaWEgPGNqaWFAbnZpZGlhLmNvbT47IEtyaXNobmFrYW50
IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IGxpbnV4
LWN4bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IFl1a2l5YSBUYWtha2kgPGZqMjExMGpjQGZ1aml0c3Uu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyAwMC8xOF0gaHcvY3hsOiBBZGQgYSBDWEwgVHlwZS0y
IGRldmljZQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mg
b3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiBGcmksIDYgTm92IDIwMjYgMDk6Mjg6NTMgKzA1
MzANCj4gPG1ob25hcEBudmlkaWEuY29tPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogTWFuaXNoIEhv
bmFwIDxtaG9uYXBAbnZpZGlhLmNvbT4NCj4gPg0KPiA+IEhlbGxvLA0KPiA+DQo+ID4gVGhpcyBz
ZXJpZXMgYWRkcyBjeGwtdHlwZTIsIGFuIGVtdWxhdGVkIENYTCBUeXBlLTIgZGV2aWNlIHdpdGgN
Cj4gPiB2b2xhdGlsZSBkZXZpY2UgbWVtb3J5LiBJdCBpcyBlbXVsYXRlZCBpbiBzdWNoIGEgd2F5
IHRoYXQgYWxsIHRoZQ0KPiA+IExpbnV4IGNoZWNrcyBhcmUgc2F0aXNmaWVkIHNvIHRoYXQgQ1hM
IHBhc3N0aHJvdWdoIHVzaW5nIHZmaW8tcGNpDQo+ID4gKHZmaW8tY3hsKSBjYW4gYmUgZGV2ZWxv
cGVkIGFuZCB0ZXN0ZWQgaW4gYSBndWVzdCB3aXRob3V0IFR5cGUtMiBoYXJkd2FyZS4NCj4gPg0K
PiA+IFRoaXMgc2VyaWVzIGJ1aWxkcyBvbiB0aGUgVHlwZS0yIG1vZGVsIGZyb20gWmhpJ3Mgc2Vy
aWVzIChjYXJyaWVkIGluDQo+ID4gQ8OpZHJpYydzIHRyZWUpIGFuZCBjYXJyaWVzIG9uZSBmaXgg
ZnJvbSBTaHVhaSdzIHRyZWUuIFNodWFpJ3MgdHJlZQ0KPiA+IGFsc28gc2V0IHVwIHRoZSBkZWNv
ZGVycyB0aHJvdWdoIGRldmljZSBwcm9wZXJ0aWVzIGFuZCBzdHViYmVkIENYTA0KPiA+IFJlc2V0
OyB0aGUgZmlybXdhcmUgc2V0dXAgYW5kIENYTCBSZXNldCBoZXJlIGFyZSBuZXcgY29kZS4NCj4g
PiBDYXJyaWVkIHBhdGNoZXMga2VlcCB0aGVpciBhdXRob3JzLCB3aXRoIGEgbm90ZSBmb3IgZWFj
aCBjaGFuZ2UuDQo+ID4NCj4gPiBUaGUgZGV2aWNlOg0KPiA+IC0gUENJIElEIDFiMzY6MDAxNyBh
bmQgdGhlIHByb2Nlc3NpbmcgYWNjZWxlcmF0b3IgY2xhc3MgMHgxMjAwOw0KPiA+IC0gUENJZSBE
VlNFQyBmb3IgQ1hMIERldmljZXMgd2l0aCBDWEwuY2FjaGUsIENYTC5tZW0sIG9uZSBIRE0gcmFu
Z2UsDQo+ID4gICBjYWNoZSB3cml0ZS1iYWNrIGFuZCBpbnZhbGlkYXRlLCBDWEwgUmVzZXQgYW5k
IE1lbSBDbHI7IFJlZ2lzdGVyDQo+ID4gICBMb2NhdG9yIGFuZCBGbGV4IEJ1cyBQb3J0IERWU0VD
czsNCj4gPiAtIENYTC5jYWNoZSBhZHZlcnRpc2VkIGJ1dCBub3QgbW9kZWxsZWQuIFRoZSBkZXZp
Y2Ugc2VuZHMgbm8gQ1hMLmNhY2hlDQo+ID4gICByZXF1ZXN0cywgYW5kIGl0cyBtZW1vcnkgaXMg
aG9zdCBSQU0sIHdoaWNoIGlzIGNvaGVyZW50IGFscmVhZHkuIEENCj4gPiAgIGNhY2hlIHdyaXRl
LWJhY2sgYW5kIGludmFsaWRhdGUgY29tcGxldGVzIGF0IG9uY2UuIFRoZSBjYXBhYmlsaXR5IGlz
DQo+ID4gICBzZXQgYmVjYXVzZSB2ZmlvLWN4bCB0YWtlcyBhIGRldmljZSBhcyBUeXBlLTIgb25s
eSB3aGVuIGl0IHJlcG9ydHMNCj4gPiAgIGJvdGggQ1hMLmNhY2hlIGFuZCBDWEwubWVtOw0KPiA+
IC0gY29tcG9uZW50IHJlZ2lzdGVycyB3aXRoIG9uZSBIRE0gZGVjb2RlcjsNCj4gPiAtIHNsb3Qg
MCwgZnVuY3Rpb24gMCBiZWxvdyBhIENYTCByb290IHBvcnQgb2YgYSBweGItY3hsLCBtZW1vcnkg
aW4gb25lDQo+ID4gICBmaXhlZCBtZW1vcnkgd2luZG93IHNlbGVjdGVkIHdpdGggZm13LWluZGV4
LCBjb2xkIHBsdWcgb25seSAobm8NCj4gPiAgIGhvdHBsdWcgb3IgdW5wbHVnKSwgbm90IG1pZ3Jh
dGFibGUuDQo+ID4NCj4gPiBObyBMaW51eCBkcml2ZXIgY2xhaW1zIHRoZSBkZXZpY2Ugb24gaXRz
IG93bi4gY3hsX3BjaSBkb2VzIG5vdCBiaW5kIHRvDQo+ID4gdGhlIGFjY2VsZXJhdG9yIGNsYXNz
LCBhbmQgc2ZjLCB0aGUgb3RoZXIgZHJpdmVyIHRoYXQgY2FsbHMgdGhlIENYTA0KPiA+IGNvcmUg
VHlwZS0yIGludGVyZmFjZSwgbWF0Y2hlcyBvbmx5IGl0cyBvd24gZGV2aWNlcy4gQSBndWVzdCBi
aW5kcw0KPiA+IGN4bC10eXBlMiB0byB2ZmlvLXBjaSwgd2hpY2ggaGFuZHMgaXQgdG8gdmZpby1j
eGwuIFRlc3RpbmcgdGhlIENYTA0KPiA+IGNvcmUNCj4gPiBUeXBlLTIgaW50ZXJmYWNlIHdpdGhv
dXQgdmZpby1jeGwgbmVlZHMgYSBkcml2ZXIgZm9yIDFiMzY6MDAxNyB0aGF0DQo+ID4gY2FsbHMg
aXQuIFRoZXJlIGlzIG5vbmUgeWV0Lg0KPiA+DQo+ID4gUUVNVSBoYXMgbm8gZmlybXdhcmUgdGhh
dCBjb21taXRzIHRoZSBIRE0gZGVjb2RlcnMgb2YgYSBDWEwgcm91dGUgYXQNCj4gPiBib290LCBh
bmQgTGludXggYXR0YWNoZXMgYSBUeXBlLTIgZGV2aWNlIG9ubHkgdG8gYSBjb21taXR0ZWQgcmVn
aW9uDQo+ID4gKGRldm1fY3hsX3Byb2JlX21lbSgpKS4gU28gUUVNVSBkb2VzIHRoYXQgc3RlcCBp
dHNlbGYuDQo+IA0KPiBKdXN0IGluIGNhc2UgeW91IG1pc3NlZCBpdCwgWXVraXlhIFRha2FraSBp
cyBsb29raW5nIGF0IGJpb3MgcHJvZ3JhbW1lZCBmbG93cy4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL2NvdmVyLjE3OTMwMDM5ODMuZ2l0LmZqMjExMGpjQGZ1aml0c3UuY29tLw0KPiAN
Cj4gTXkgaW1tZWRpYXRlIHRob3VnaHQgaXMgZm9sbG93IGEgc2ltaWxhciBmbG93IHRvIHRoZSBv
bmUgSSBzdWdnZXN0ZWQgaW4gdGhhdA0KPiBwYXRjaC4gRG9pbmcgQ1hMIHNldHVwIGluIFFFTVUg
YnV0IHRoZSBQQ0kgZW51bWVyYXRpb24gaW4gdGhlIGJpb3MgZG9lc24ndA0KPiBzZWVtIGxpa2Ug
YSBzdXN0YWluYWJsZSBtb2RlbCB0byBtZS4gSSdkIG11Y2ggcHJlZmVyIHRvIHNlZSBhIGJpb3Mg
ZmxvdyB3aXRoDQo+IGp1c3QgdGhlIFFFTVUgZ2VuZXJhdGUgdGFibGVzIHVwZGF0ZWQgaW4gYSBz
aW1pbGFyIGZhc2hpb24gdG8gaG93IERTRFQgaXMNCj4gdXBkYXRlZCBmb3IgUFhCcy4NCj4gDQo+
IEFsdGVybmF0aXZlIGZvciB5b3UgKGFzc3VtaW5nIHlvdSBjYXJlIG1vcmUgYWJvdXQgYXJtIHRo
YW4geDg2KSBtaWdodCBiZSB0bw0KPiBqdXN0IHVzZSB0aGUgU0JTQSBtb2RlbCBhbmQgZG8gdGhl
IGZ1bGwgZW51bWVyYXRpb24gaW4gZmlybXdhcmUuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5IEkgaGF2
ZSBxdWl0ZSBhIGxhcmdlIGJhY2tsb2cgc28gbWlnaHQgYmUgYSB3aGlsZSBiZWZvcmUgSSBnZXQg
YQ0KPiBjaGFuY2UgdG8gdGFrZSBhIGNsb3NlIGxvb2sgYXQgdGhpcyBzZXJpZXMgKG9yIHRoZSBr
ZXJuZWwgb25lcyEpDQo+IA0KPiBKb25hdGhhbg0KPiANCg0KVGhhbmsgeW91IEpvbmF0aGFuOyBJ
IHdpbGwgdGFrZSBhIGxvb2sgYXQgdGhlIHN1Z2dlc3RlZCBzZXJpZXMgYW5kIFNCU0EgbW9kZWwg
Zm9yIHRoaXMuDQo=
