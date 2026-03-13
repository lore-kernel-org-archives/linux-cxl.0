Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FED38839F;
	Fri, 13 Mar 2026 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773396309; cv=fail; b=dSRZ+Iy3wB+0Bg2cBP1h+mjq0cz6Xj9gaie21w2lIgeGJlRhG7/K47sv3HP2T2FvMNiw4tc/S6v2Af81Oi+ap1T9Fv8KEYHEHxSDdISO5lAPTeHXV5FbSgFhTaHojTsK0kbn75QuId6fXnq1HooMLA1jBuSP5pmneNF5FJDwHmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773396309; c=relaxed/simple;
	bh=0u3OHTXBVIv9/M5Cy6dwHP3il6kz+leLDz9RoOFKMl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t+fpXON3/RQFS4ldeWGt0GZyh4VIDvzIRLGEcpB1lDV5Kst0feE6UeWV+p/tvhixcOpsVO5VvSoGpXiJNYRnwCnhDgb3qTqf3pC9X60xHH+9Ug5jw6sote//2XqXEJZj0JeUVVfLCqrkT2aYqEWdvcHtqaGqverzcy8yiv0Zsnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L1Y7D0ME; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L1Y7D0ME"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmFRaVn+zHt0RWi5U+b/3aMMydrVmh/CcqwMwa8vL7XeGTA7FxwbDAl94KoWcIfuMmlZ958W9NGuZPh5TDjloNIqCEreVsVbUocmT5jXUle98h3UGx5w9qxuA0R2QMvYbB9685W+q9273TGxVUCdvEy/lF6bhT4GwdyFqjevLK7dPLhD+y/7nsOf9XY5p4dmuY9vHMRk03+Wkm84xAVD64kLWFwyyl1HEmLLje1IbAKacg/MRDmDW4tl/ONI2PipQlxGmEdZr57U5tGi13dcCsp9yBmLuh70JCuhIrMaLiOIAPB1RMxTHceUYhud46XrOxYLQHqSNRbt5U5UySgG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0u3OHTXBVIv9/M5Cy6dwHP3il6kz+leLDz9RoOFKMl0=;
 b=hmYIO9ASdCPK4JZNn3zfixik0efky6F1FTpCWYbgfd92qNOYidHIAHo08KQF62auaaETW8JJ3SIJfofud3984dOHoKJqc5jiaM3tJgJx/gdnW0p5rh1qmDwSgi0jqhFOuqFUGArm8XxpItm0byP46YBCEMKJEwA75ctw3HR30xPMQDcuflm96SQcbHAhDsoUlKwLJpQJBR0NKd2rhlE3PxmLUajZY564LdBdDiZpHWZecomhY0vEuXzmT+co4LliGxr1SNOnMH3EmZ1vqJ47sFeKIPeB8fJXhAo4BhFDjVMkAeI2P99VwATOoPhjhMQE0DPqj8KwidM3aEnN0bjrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u3OHTXBVIv9/M5Cy6dwHP3il6kz+leLDz9RoOFKMl0=;
 b=L1Y7D0ME1RzdqwMHRkEOLP2LMSIsGt0F/Dqa/FHGCuim0dcZ4o28dbpkeFlS219ffJ5suhT89tx361EIJ20CxSx/53wzNXve6rvreJaUK/2y5+qTTva0b2SV8NJjBXX9u0I8pQS2IM0zOBcUlq3V8NirqdoZaEqHyqnwxDCws8GHP+kDeviQ+OmvwFRKMLmNx2a6BELP5xvfB6cYqv4LSm73/e+fqkybMIEFi1qt/ky+prYWz98xTst1MAxuLAJcO7fsMutM7e97Vem738DosxGb2LuXBTZ5zHBGiIXfrZdnbx/6He71FQ/YJZyuU3dwLKMIbJjN9KAbOExXOfYPsw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 10:05:02 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 10:05:01 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, Aniket Agashe <aniketa@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alwilliamson@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Matt Ochs
	<mochs@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>
CC: Neo Jia <cjia@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH 02/20] cxl: Expose cxl subsystem specific functions for
 vfio
Thread-Topic: [PATCH 02/20] cxl: Expose cxl subsystem specific functions for
 vfio
Thread-Index: AQHcsZacZjfcqSYPsUin8KxB8aNkPrWrHRUAgAEhHPA=
Date: Fri, 13 Mar 2026 10:05:01 +0000
Message-ID:
 <IA1PR12MB9030EA5E6B67408A31A59EFABD45A@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-3-mhonap@nvidia.com>
 <81141774-89c5-4cb8-a7e7-52ae8c55ca25@intel.com>
In-Reply-To: <81141774-89c5-4cb8-a7e7-52ae8c55ca25@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|MN0PR12MB6174:EE_
x-ms-office365-filtering-correlation-id: 6345cf13-6cd3-4376-3a47-08de80e7fdd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 JqR294h4lhORKoIaXfNk/0Nu6Bq5LPGCLGhOAWRSplQeo+p80voahnXS+ZKqO3EMIGwOAoLZ+S6aJOTn8qUXRl8An9T6qs+7oURIDJAKMjwB9n5Wce0JzellRMLyTq58QekojGw6wE+Cw0hv2LZsgm+fHmQQ6VdUM9PsRffVYgp0r2CYp9E9GX1YahfT8DwHNe7HHgWVzT412WBaE/PwMg3swZy3VsofMQj6dDFkRghikWSEQFSpINu+UnPKpyHI1e+4GQBbro9BsCn5Aphs8SZgQUstQKnwZ5eRX85FGFxSlONj1yfrM+LW38kHEZEYGPKkZU6Ng4pSM/cTuhPqsp3qMFfftOt0eTgp6tFthgZfcoQo2Gkeei+HRIOi/hAL7pjHz3WY25W66t3a+Wbhx4ruz3souWi/C4QllL7jl93FHQNgs+p8G9U6pdHfwKcMABzWaqXUaphQdp1zazULEvJ5g15PtxKdUifG49hHWUChW4ub1EksHwk9oOrqD+l4JUa6yBeoGtX2IOjY5Bxr2QT/JbzbloiW1Zn3hrKlHcNdHT2pBLRxmVLSgHelCjIGRD1Ctnzh2+0+2n6ZJK9magvE7ESRrqbjLpjqVL7NLA9c6EEbAJMdZAjsXyPJ/sTt6IuDBaZzh3y19Dh6i7PAHaTu5RjEj9whJy89t1Ej7K5/jG97823Se+rG72RBtNgimZEzT12Nc3soFk4PIKRmCGp7uGcxUm3+XGOwwO5StUHUJ+B6HG7IVRPdezRfIqx9GUf8PQ70CXoy2rAKQC88O+PJKQv0V7MplWK/Mr/14L+UvqZXsPfPVF7zaUH6ul8u
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWlIV3BRNXowalJESDZvaDcxQ1NjUzdYZ2lYZTdZVmhOVHpKTzhpbFAwdjls?=
 =?utf-8?B?MExnOGRmY29hZVQwWkZmL2YwcTRhNkpOSjJNaXd1dW1lNVBKTk9IMmQ3QWZh?=
 =?utf-8?B?ekZaY1l1UEl2aFRkUzlsc0Z2MHc3S1BBVXFLZVNPWmZBdzRCYVhRb2JyZ01i?=
 =?utf-8?B?Q3FqYXo4QXdrZmo3ZFM1LzdLKzV0Nk55K0dEYUoxN1V1cVRJbG5PeG01QWRO?=
 =?utf-8?B?b1BLYzB3ekRHMzdNR2JHVGJqVFFIcTI5R0ttWFAveDAwMWdNMUdzQkhZWTNC?=
 =?utf-8?B?Zis2cU1aTGRvMFAyQnFqdCtrWUhLQnB0ZG94NTJJNEdlcFBwelNMZHA3Tmh6?=
 =?utf-8?B?dVhsbVV0d0tZQ1RvRitIcG53SkJnWjd1ME9xN2UrYk84ODI0amwwZkw1dW95?=
 =?utf-8?B?ODJlejRzbEtGLy9uMjRZOVh3c0NSVWo5SjZMS1NRRSsveElXNUxZMVNsUW4r?=
 =?utf-8?B?ZTVheHd3QnRQMXU4Sjd6RUpvWUtrR3dRT2RWWHpweXRsK2MwL0o0aDIzaTMz?=
 =?utf-8?B?UTRHNjV6Y2VpdDg4RjF2Mk1udnFmMUdTcWljbW5QQkt1WFJVSmlCamhtZ0RS?=
 =?utf-8?B?eFl6QnRtTWhjVks2RGF2Z1VMaU5zQThUSHZDRzlkcERleXhVYytDYkVvaXQx?=
 =?utf-8?B?M1pLa2JDQlBaMXZmQlpldlVXcEdwWmNYejMwYm9tYUM3YnM4U2x1S2VUM1E3?=
 =?utf-8?B?NXdYSzIveUU5VmZ1NEZVUHZ3MTVTS3pVN09ZNW1wMEhES0tOWUJWSHVSa3pX?=
 =?utf-8?B?Mm1Xc3hqZENjNGJtT1FsaXIrZnhrbFhQdnNyMjMyQlc5aFNjUTlnTm4xSFk2?=
 =?utf-8?B?V1F2N1lUcEpzdlZIU0dmb3o3UlUwekVVd0xrcEF3VG9OVlZsTzd6YVNHWkJC?=
 =?utf-8?B?V1AzMlVDOEpKZnYySzJ4K21jZ3VySXBWSmdYb24vM0ZNcnFMaFBJTUU4a21N?=
 =?utf-8?B?Q3lsYWpqcXlvWGdBc0t4T3BXaWUvUEJiVDJWRjh6cTNBMjZ2QTFadWN5Qzlz?=
 =?utf-8?B?NkZPM2l1dnN5cVgrbGdwMmdqMVFHMDg2MGxNT1lIVG5tWmxRR0ZyY3dDRzRW?=
 =?utf-8?B?ZU9xL3JZWHV2Vnpac1BQNUduMVltRzVCZjZvWnJYWVRlcHhUV2YyMTVvUkIx?=
 =?utf-8?B?RWMwSUFXeVVXU3R2d21vQ2k5Zyt1MGRoM1RuTnZuYjgxZllwUStrNDk5TFRW?=
 =?utf-8?B?ZnVOcTZUSitlbE9uQWdjZHFsK2hNMitZZDFjZDdSYzhGaEJldm1iMDlTZmRn?=
 =?utf-8?B?QzhQaVoyTlZwVmw1aXdmNXZnOFBPN1N4anJIY0swaHBmTk4zWTZaRWMrQnZZ?=
 =?utf-8?B?NnJVUW5keWNGUEtsN3Q1cGlMRjkyQWNyTjl5dTZnVEF0VjdZWDMwd1JVV1Nj?=
 =?utf-8?B?VENXNmxWZTF2YlpKeEtYVmd6T081V1YxdWpaZERENzA3MnFSbjN3c0huTnFO?=
 =?utf-8?B?d1p4UUhUclZHSU5sY2ErODNGQXRKNEl5R0UrbEJMbXR6V3kvSXg3Y2k1d2JH?=
 =?utf-8?B?dmtIb2FsWW9oSW84VVhibEo1RUFUOXlFQ3NTaFQ5ZENhNHQ2NVhBTUZ3QjNX?=
 =?utf-8?B?azFUQUJEUWx4Qk02bEJoS1F0U0VDc0N5aWNXQ0xVN3ZSNzJmTUExQmhWWGZ2?=
 =?utf-8?B?R0V1NjVUbnpxM21RU3ZwSmh6amh5TFpEdFRHbjJ3QmxqdG5ZeENyRE5JaHJJ?=
 =?utf-8?B?V0grYUdnOG43OFlvWG94V1dKU0t6T3RPUG10Q1creXd0cS9ERkJXZXZEWmlI?=
 =?utf-8?B?aktpeHJyNFY0NnFoWWsxZk14Ymx0NXdHT0g5YnZWbmVSb2QyS002QXhJUzN5?=
 =?utf-8?B?ZkpRbWM4TStEY2ovRTlSZUdDeXY1bTFsaGU0c0lSemVnRFlBV1Nwa1dZWnhs?=
 =?utf-8?B?Wlo4bWVuc1dDSXA4eHI3K2xkQnoyMDI4TmZSTlpGM3p2VFZ2YVNGZ3VjTjNG?=
 =?utf-8?B?K2tNY0J6aWlHc0hoc1hjbnBIY05pNFd3blhBQmo2QkUyaW5WOEZHV1BJN2w1?=
 =?utf-8?B?NzIycldmWEJlQWxDSEYrYUpWOGVHVVNGWVpZbkFRNHFVYXQ4RFdYRUxyOFFS?=
 =?utf-8?B?QjBIS2hJeEVaYmRhRGpoQmQ1MC8zSEFtdEhYSDdITjdUaEpYTkRacTRTRXZT?=
 =?utf-8?B?eUlIOGtMdHcrN3d3MFJDSlZFdmF5T3ltaXlDNWZQdEt0L0FUVzFrWlZEK0pp?=
 =?utf-8?B?ZGFwcHh2N1VUOGFxVkJPTWtiTGdnckJFRzJqWWhxdnQ5OGYzRDdzRmhqSHJm?=
 =?utf-8?B?dkdMeFR6ZEZWR0w3U0s4Y2Q1a0g3MHZtdkhRd2dVZVNUdHRPQ2FPMnRxaXQ2?=
 =?utf-8?Q?+I0mPtXT/OW4pjl707?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6345cf13-6cd3-4376-3a47-08de80e7fdd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 10:05:01.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/ObMPfHVNpM5cGavg6FTpIncfNbq0cHtCOdUpU5FFLSO2Ykb0tAnoZIOkTgDEtMxVLIUG7BOh6ajhiGxIwlHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBKaWFuZyA8ZGF2
ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6IDEyIE1hcmNoIDIwMjYgMjI6MTkNCj4gVG86IE1h
bmlzaCBIb25hcCA8bWhvbmFwQG52aWRpYS5jb20+OyBBbmlrZXQgQWdhc2hlIDxhbmlrZXRhQG52
aWRpYS5jb20+Ow0KPiBBbmtpdCBBZ3Jhd2FsIDxhbmtpdGFAbnZpZGlhLmNvbT47IEFsZXggV2ls
bGlhbXNvbg0KPiA8YWx3aWxsaWFtc29uQG52aWRpYS5jb20+OyBWaWtyYW0gU2V0aGkgPHZzZXRo
aUBudmlkaWEuY29tPjsgSmFzb24NCj4gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE1hdHQg
T2NocyA8bW9jaHNAbnZpZGlhLmNvbT47IFNoYW1lZXIgS29sb3RodW0NCj4gVGhvZGkgPHNrb2xv
dGh1bXRob0BudmlkaWEuY29tPjsgYWxlamFuZHJvLmx1Y2Vyby1wYWxhdUBhbWQuY29tOw0KPiBk
YXZlQHN0Z29sYWJzLm5ldDsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiBhbGlzb24u
c2Nob2ZpZWxkQGludGVsLmNvbTsgdmlzaGFsLmwudmVybWFAaW50ZWwuY29tOyBpcmEud2VpbnlA
aW50ZWwuY29tOw0KPiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IGpnZ0B6aWVwZS5jYTsgWWlz
aGFpIEhhZGFzIDx5aXNoYWloQG52aWRpYS5jb20+Ow0KPiBrZXZpbi50aWFuQGludGVsLmNvbQ0K
PiBDYzogTmVvIEppYSA8Y2ppYUBudmlkaWEuY29tPjsgVGFydW4gR3VwdGEgKFNXLUdQVSkgPHRh
cmd1cHRhQG52aWRpYS5jb20+Ow0KPiBaaGkgV2FuZyA8emhpd0BudmlkaWEuY29tPjsgS3Jpc2hu
YWthbnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBrdm1Admdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDIvMjBdIGN4bDogRXhwb3NlIGN4bCBzdWJzeXN0ZW0gc3Bl
Y2lmaWMgZnVuY3Rpb25zDQo+IGZvciB2ZmlvDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDMvMTEvMjYg
MTozNCBQTSwgbWhvbmFwQG52aWRpYS5jb20gd3JvdGU6DQo+ID4gRnJvbTogTWFuaXNoIEhvbmFw
IDxtaG9uYXBAbnZpZGlhLmNvbT4NCj4gPg0KPiA+IEJlbG93IGZ1bmN0aW9ucyBmcm9tIENYTCBz
dWJzeXN0ZW0gd2lsbCBiZSByZXF1aXJlZCBpbiB2ZmlvLWN4bCBmb3INCj4gPiBzdXBwb3J0aW5n
IHRoZSB0eXBlLTIgZGV2aWNlIHBhc3N0aHJvdWdoOg0KPiA+ICAgICBjeGxfZmluZF9yZWdibG9j
ayAtIFRvIGZpbmQgY29tcG9uZW50IHJlZ2lzdGVycw0KPiA+ICAgICBjeGxfcHJvYmVfY29tcG9u
ZW50X3JlZ3MgLSBQcm9iZSBIRE0vUkFTIGNhcGFiaWxpdGllcw0KPiA+DQo+ID4gTWFrZSB0aGVz
ZSBmdW5jdGlvbnMgYXZhaWxhYmxlIHZpYSBkZWNsYXJpbmcgdGhlbSBmcm9tIGluY2x1ZGUgaGVh
ZGVyDQo+ID4gaW5zdGVhZCBvZiBzdWJzeXN0ZW0tc3BlY2lmaWMgaGVhZGVyLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogTWFuaXNoIEhvbmFwIDxtaG9uYXBAbnZpZGlhLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9jeGwvY3hsLmggfCA0IC0tLS0NCj4gPiAgaW5jbHVkZS9jeGwvY3hsLmgg
fCA3ICsrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY3hsLmggYi9kcml2
ZXJzL2N4bC9jeGwuaCBpbmRleA0KPiA+IDJiMWY3ZDY4N2EwZS4uMTBkZGFiMzk0OWVlIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3hsL2N4bC5oDQo+ID4gKysrIGIvZHJpdmVycy9jeGwvY3hs
LmgNCj4gPiBAQCAtMTk4LDggKzE5OCw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IHdheXNfdG9fZWl3
KHVuc2lnbmVkIGludCB3YXlzLCB1OA0KPiAqZWl3KQ0KPiA+ICAjZGVmaW5lICAgQ1hMREVWX01C
T1hfQkdfQ01EX0NPTU1BTkRfVkVORE9SX01BU0sgR0VOTUFTS19VTEwoNjMsIDQ4KQ0KPiA+ICAj
ZGVmaW5lIENYTERFVl9NQk9YX1BBWUxPQURfT0ZGU0VUIDB4MjANCj4gPg0KPiA+IC12b2lkIGN4
bF9wcm9iZV9jb21wb25lbnRfcmVncyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgX19pb21lbSAq
YmFzZSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGN4bF9jb21wb25l
bnRfcmVnX21hcCAqbWFwKTsNCj4gPiAgdm9pZCBjeGxfcHJvYmVfZGV2aWNlX3JlZ3Moc3RydWN0
IGRldmljZSAqZGV2LCB2b2lkIF9faW9tZW0gKmJhc2UsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBjeGxfZGV2aWNlX3JlZ19tYXAgKm1hcCk7ICBpbnQNCj4gPiBjeGxfbWFw
X2RldmljZV9yZWdzKGNvbnN0IHN0cnVjdCBjeGxfcmVnaXN0ZXJfbWFwICptYXAsIEBAIC0yMTEs
OA0KPiA+ICsyMDksNiBAQCBlbnVtIGN4bF9yZWdsb2NfdHlwZTsgIGludCBjeGxfY291bnRfcmVn
YmxvY2soc3RydWN0IHBjaV9kZXYNCj4gPiAqcGRldiwgZW51bSBjeGxfcmVnbG9jX3R5cGUgdHlw
ZSk7ICBpbnQNCj4gPiBjeGxfZmluZF9yZWdibG9ja19pbnN0YW5jZShzdHJ1Y3QgcGNpX2RldiAq
cGRldiwgZW51bSBjeGxfcmVnbG9jX3R5cGUNCj4gdHlwZSwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBjeGxfcmVnaXN0ZXJfbWFwICptYXAsIHVuc2lnbmVkDQo+ID4g
aW50IGluZGV4KTsgLWludCBjeGxfZmluZF9yZWdibG9jayhzdHJ1Y3QgcGNpX2RldiAqcGRldiwg
ZW51bQ0KPiBjeGxfcmVnbG9jX3R5cGUgdHlwZSwNCj4gPiAtICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBjeGxfcmVnaXN0ZXJfbWFwICptYXApOw0KPiA+ICBpbnQgY3hsX3NldHVwX3JlZ3Moc3Ry
dWN0IGN4bF9yZWdpc3Rlcl9tYXAgKm1hcCk7ICBzdHJ1Y3QgY3hsX2Rwb3J0Ow0KPiA+IGludCBj
eGxfZHBvcnRfbWFwX3JjZF9saW5rY2FwKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBzdHJ1Y3QgY3hs
X2Rwb3J0DQo+ID4gKmRwb3J0KTsgZGlmZiAtLWdpdCBhL2luY2x1ZGUvY3hsL2N4bC5oIGIvaW5j
bHVkZS9jeGwvY3hsLmggaW5kZXgNCj4gPiA4NDU2MTc3YjUyM2UuLjYxMDcxMWU4NjFkNCAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2N4bC9jeGwuaA0KPiA+ICsrKyBiL2luY2x1ZGUvY3hsL2N4
bC5oDQo+ID4gQEAgLTI4Nyw0ICsyODcsMTEgQEAgc3RydWN0IGN4bF9yZWdpb24gKmN4bF9jcmVh
dGVfcmVnaW9uKHN0cnVjdA0KPiA+IGN4bF9yb290X2RlY29kZXIgKmN4bHJkLA0KPiA+DQo+ID4g
IGludCBjeGxfZ2V0X2hkbV9yZWdfaW5mbyhzdHJ1Y3QgY3hsX2Rldl9zdGF0ZSAqY3hsZHMsIHUz
MiAqY291bnQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICByZXNvdXJjZV9zaXplX3QgKm9m
ZnNldCwgcmVzb3VyY2Vfc2l6ZV90DQo+ID4gKnNpemUpOw0KPiA+ICtzdHJ1Y3QgcGNpX2RldjsN
Cj4gPiArZW51bSBjeGxfcmVnbG9jX3R5cGU7DQo+ID4gK2ludCBjeGxfZmluZF9yZWdibG9jayhz
dHJ1Y3QgcGNpX2RldiAqcGRldiwgZW51bSBjeGxfcmVnbG9jX3R5cGUgdHlwZSwNCj4gPiArICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBjeGxfcmVnaXN0ZXJfbWFwICptYXApOyB2b2lkDQo+ID4g
K2N4bF9wcm9iZV9jb21wb25lbnRfcmVncyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgX19pb21l
bSAqYmFzZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGN4bF9jb21w
b25lbnRfcmVnX21hcCAqbWFwKTsNCj4gDQo+IEkgZG8gd29uZGVyIGlmIHRoaXMgbmVlZHMgYW4g
aWZkZWYgb2YgQ09ORklHX0NYTF9CVVMgZ2l2ZW4gY3hsX2NvcmUgY2FuIGJlDQo+IG1hZGUgYXMg
YSBtb2R1bGUgb3IgZGlzYWJsZWQuDQo+IA0KDQpPa2F5LCBJIHdpbGwgdXBkYXRlIHRoaXMgc2Vj
dGlvbiBmb3IgI2lmZGVmIHByb3RlY3Rpb24uDQoNCj4gDQo+ID4gKw0KPiA+ICAjZW5kaWYgLyog
X19DWExfQ1hMX0hfXyAqLw0KDQo=
