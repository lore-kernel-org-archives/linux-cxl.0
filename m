Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6123815C6;
	Fri, 13 Mar 2026 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773396348; cv=fail; b=cKWR8Y/6Cz48X5DZl6PZo4+wXV8itNQF1ffseRjXYQ1Vsnxhyg9pqGz+PmDIwUE1LcG2Uf3WZb1e3NoRHhm84ZkDeqhSKFPYeQXivZIbB3nRSNLNFCXV6q3gmnH7umpMx0nKWZs5QvVSO7iGJ76S1mx2qx7zClI8oKeFZBA55Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773396348; c=relaxed/simple;
	bh=5osVDBA7N4c5uOOA8s3zmxk0PhoSvih4O2HNh5Yj2eI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BdK5hmPtjKtw7+mjds1f3diqViKJhKetBQw/0sM4oGe0ace4gUFG7eJkiYzJZ8k7/DUoaTNRwgD7G2eKCPXZ3fJHCX+q7Qp6PRmAX+1UY46tCvSz0yls1G9mFYm3cdQL32E2AkcSeVUXW3KlreGj3aK2KGcGLNjYakW7s3zno1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fpHCXlZj; arc=fail smtp.client-ip=52.101.48.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fpHCXlZj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pa+eNfcMawsYRKjiXDdeB8s0hugabPbuHpABWqBpoe+8lVc6M7CdvqDyx8bK/yFro0Kra8XThRPAjK5WWt+EW7ioSmmQFeSEwtN1ZVXyaPO9jsc9kjbrDLzT/PE8bM+XsCEa7iIioD2HvU/mh1HLLdMWI9dYCvipMVA4BUWsRLupMZgjSv5ZdOE+dyBjvJ+dgo2+lmtjhZet84mLEFaqLCvSrMMCPUZws+aJLwviVMcQnRnMcxDFHt0oGUsz231LsAqlmuHStu2R4Y+zgWtrhoEbriVPKiHAqTJEFRiC0LZPXClqmXyIewWeToCWwgDjEd6iUo3wI7gUJS1tM0zlSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5osVDBA7N4c5uOOA8s3zmxk0PhoSvih4O2HNh5Yj2eI=;
 b=DhIefFcLcWBEf8jD4tM1kc+QGhK+0E8/VB4X8d1zS6PHwtY5tmzI7WRdQ1CgHRaLa66Mxdaej7nJNT3Wz7iTnfzhg9Xdl334XiD7EWVZ+fbxpd+UNI6EtrIzhokkqDSh6OvP1d0W6bFCUvOaIzmrhr9gZYAmaNjRCD7ZndVOnzs/sHGxazWllpNdP+7Pit1Pb97sIgQTV7q/sBb/W1lZ7sowDmGfKWS+p6Jz1wcSmErPEq51uYLQmEY82tmyPyEsBo9gUDW/BFIcBqUvS6uQi3JahNiYTafRvZZE/rZ/eu1h4sueJwMFTh5Wx429CdoyODjw2zban7RGU9dPuhuxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5osVDBA7N4c5uOOA8s3zmxk0PhoSvih4O2HNh5Yj2eI=;
 b=fpHCXlZj2wlJSVeCygTlSmGolJUD8Liv2n/szYKTVwEhaUdwh6cNi7CQa9xi1OJKNklyYOBR2nKZBFK5nnFFGbpFp43ZZnjN5E/TuyJ+gNAhT3yYfZVRIp6eXIw7bWlHUhKUb8yXGyQxuaye3bU7hBsiA5CVlGc03KsC2p+LR8UU7Wp+fm5EzCbfB6Uaj5zP3NPn76bx6T2jkO/do8IUMy/9oAnuLs42BYoEJrWhwpLgJhZi8DRmabtWETnB92ASGK9b0GKSJdQ+R2BE9O9qMnuvxU6ZIloVGr3hqA29WFZhvRlrOKqi+OjyqjEmdoVxU8U/sErhZCye95MrLLHv8A==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 10:05:43 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 10:05:43 +0000
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
Subject: RE: [PATCH 04/20] cxl: Media ready check refactoring
Thread-Topic: [PATCH 04/20] cxl: Media ready check refactoring
Thread-Index: AQHcsZapi/mZfnKVbUWuFBNmyKtT8rWrWp0AgADj84A=
Date: Fri, 13 Mar 2026 10:05:42 +0000
Message-ID:
 <IA1PR12MB90303563C37CD59B48787252BD45A@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-5-mhonap@nvidia.com>
 <6ea7cc03-59d2-489e-9506-65f8759dfdbd@intel.com>
In-Reply-To: <6ea7cc03-59d2-489e-9506-65f8759dfdbd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|MN0PR12MB6174:EE_
x-ms-office365-filtering-correlation-id: fda6dfec-d3e3-419a-b27e-08de80e81672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 QoQzJAvefq7D76w6WaRCe69HtZVVVwUhGYP9HMJUub01R1Ucc1SEkyBIOeOugq8E1BurNljHRHJ/ixnEtwA2Ss3g2c+J5WVwymkYru1g3nkfSmv9PO2rjbLCFt6qOpcj97vbiFM5fXd2L8q1Ma4dksFjZ64IrXKUYZxfPHajoBGksto2DtgdPc1HKyHW7kNr62thksvJRGi/TO5wI1WzAdOcaek9mrMhn8Ad5XXsylX46u7UEVitin8q+iCdNCAE3mMNZTEYFgIV1yJBwloR2AvIXr8YRH0gmsuJQosn87wG7i4b2rDVoM1dvDfDkIzV5F6ItXY+TJxNVsPD3eZYLjJ9q8QbMhCgWaiD7oFDbv29cBi5Ao/jTF1mokehLA2WeZUAqfJU+Y9DusCf+a3nnunqECW8srzgDXrSLsof7ZahKYueO/2840nd+DiHLdXvhb8TeefxTquN7y5tE6ibZ97CGFjW/XN2HZ848L9qlm/N12z99lwZo03zAJsxFeS0a5B2dFuHtDEW2N5fIdk+hxy5GVDPiX2fOgyLK/HHDisujMh6n97PoWTFrIFuBgJpV5xZuckm2qoTvWCwis5XpXLS+cQ1jWc0cWbS1spII5DJl15Jl6yyVGFZwKDr/X+QFjdo3qDkHurRv89ZXemet8C9yUH53gz6el5DQ8pIZyvfyLaixanvAkvy5G4bdygAnwxKVdEREQYzQxlPySLI8tZneZLSDlmg+g9811FzG3baOMZDRE80ZjVMtA1XYdyKhUBfzxvNxGk4PPqupk247H8WcS76KJM7RNsfDUjl8ILVy9P2ogH+3SqixR++HxaV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDVnc2VsNEtqWmN4OXZQcUtpVThWcm9HdGRNbjVCZXhxd0dpMUNqeHc1M21q?=
 =?utf-8?B?bmR0QUpIdGdybG5tMmdheGNtMG94OCtVMFFBSDVXS3dvd0ZvbHEwNnFtQkR6?=
 =?utf-8?B?NXNCbzJkWU13cW5QY3oyNWJqYnB0dThjNHBtUUxwOVBXRDJ2Y1d6RlJDaDIr?=
 =?utf-8?B?eTdXdzdMd21LTS9EUHlQL1JjZ20yZnFycHM0emFYRWdVSjFWWDVPTUJSS2JZ?=
 =?utf-8?B?dnZhbWRZbWlWSUdCRmlJV3J1dFZFSDhiWG9oYnV4NUwzQzFQSjlhYkFXK05l?=
 =?utf-8?B?R2FHQWhmQ3JmSXUrdElQeFduKy9lNzZITEJhT09QU1F5Z1pUUC9ucWJ3K0FT?=
 =?utf-8?B?d0pGR2dnbU5SaDA4RDJQczlxbXQzMUhiT08wKy9iOXFrVlBxaG9IcXhvYUdj?=
 =?utf-8?B?YS90aGI1ZFc1SmI2bGlNcmRxNjZ4YzdHaU40eGh0ZHBacWxHOWNNN3ZpWTJM?=
 =?utf-8?B?WkFaUyt4RXNNMkZPS3VMVnE1d2FaUFRMQ1ZFMWYySndEWElteExKRUtSaFVZ?=
 =?utf-8?B?TDlsYUVvNXBodmQyWHZTZC83cGNRY2tjZUduekR0dWR5aXA5czJoQ3B1T1M0?=
 =?utf-8?B?UitwczdqU2ZLNWRwUmhYdER0b0NKWlQvUk1NcDBDYzV2S2xWaUdmM1lvTGh2?=
 =?utf-8?B?RW9iRkdHNXJpblFWeHZRMmRJbXgwa3A2aTllZkVGWlZHRUh1YXFvVFdBM3VO?=
 =?utf-8?B?QVBXRm9HY0c1WmQ3cDM2eWQxUXZ5bW84UUcvbHhNZWJhWnhSUWlLcksvZ295?=
 =?utf-8?B?dlVyZk4vOW5KVXVmWWJmME16SlYvYjZvMDAxOVAxWVNrQkZJMCttc05nb0JF?=
 =?utf-8?B?c25FdWI4b1dyaUt4NU9hK0loaGVrK0xXYXZzc1YzLzB2RkR1M0FFZ2hQZWl0?=
 =?utf-8?B?OXRlWjJDamZyZmo4dDFEMGh0b0NCemRMeGJNcUhBMkhDWDl4d2FkRnlIeWdn?=
 =?utf-8?B?TmE5ZmkyNmdabU95ZWlNM0xNTVptRnhUcmw2SkZNYnB4K2o1cFdvUVVHSzA4?=
 =?utf-8?B?VjB2UUNVemlUaGlOUTRBc3FvcWl6L0ZMcnYyb1h2OGV4OVYvVWhHQkRGa3BO?=
 =?utf-8?B?WXFxOGhmMmwzYk9wQW1CRG9WZ01GcVlPa05zYnF4MHdsNlFoaW92RmlZdGdh?=
 =?utf-8?B?b0Q1NFdreU0rSm83NGUyaTBreG5jTUJ0UmVxNmFsOUh6dTJuWm4wNktjVS82?=
 =?utf-8?B?UnhyeVUxdTlaZ0h6RVc1S1FtdnV1SVJDQ3V2VUZOTFhDckhTdVFxdXFtUWxK?=
 =?utf-8?B?MW5LWHRWcmpkWXpVV2N1OStVdWtFbE9UcXgveG8vYTE3V2NNblQrV3BZN0VM?=
 =?utf-8?B?WXA2QkVwd3Q4ZHBkbkphV1BpYmhySjJ0VFBZQ0xsZ0huL3o5cDNVWFhLMmp1?=
 =?utf-8?B?TTdwV01tVU8zeitSRmQvQWIxSkdoQXJGeEYxMGRaMERsUk5oVzBnWVJ0OVJX?=
 =?utf-8?B?TzlvcWtMeWVxVm1zS2h4ZG1tS3M1QVRsY2F5WHpHajBMMzVlYVBaMWtEWGVs?=
 =?utf-8?B?am8zVi9vcFZHcWVaTVJWMWdVeVMvYjFPRjJyOU50V2hQM2FZUXFXZFhYeWNF?=
 =?utf-8?B?N0FaaHJTRkw0N0ZmVGFSSDVYKzViMzB5RnVTcmk0YThyQ05LTzdTNmlmZkEz?=
 =?utf-8?B?N1JmclJqSlNkVnFOZ3J0eFJrVUM3SHN5NEkyZUtGVkMvVVkwZyttSlJweW42?=
 =?utf-8?B?amZ0dlRwN2VtakhLLzdwZlRkSHBqc2RFcG9rdVYvOU1DbWZxUjlaYkxrcjhO?=
 =?utf-8?B?QndDWTNiaTQ4TmE1QS8xSlViMHpRSFE2Vm5pV3llR3BPTExRdDMybW00RG1E?=
 =?utf-8?B?T1BiVXFXRVAzTVJBTEZIZU5nQUw5WWczeVRHYmgxOEZBaktKK3hweVRDTFo2?=
 =?utf-8?B?YkVoOTJlS2hJWVMwQzd5aFg2SEM4MTZrK005V0J2dE1nMi9uNW5Vbm5jSjV4?=
 =?utf-8?B?ajVHTEd1czBUYldjaHJlUGQwaGNlcldibnkrYm1LaWdocTNXdWZCQm5TWVZy?=
 =?utf-8?B?MmdHWjVIeE15QjkzbjJTbjJrM085WTEyYzZNd3ZkNkdqcWNVZDNGdEh0YW96?=
 =?utf-8?B?R2xQS3dYcFY0cExEQkg3RUtINEwrSlYzT0dzb0dJNExQTkVGK1NaZ2k2ODR0?=
 =?utf-8?B?OTQxMnAvU3RndTEyRzRXZk5xSFZ4djdBdys0WityT0JyRFh4K2x4M2FxL1dJ?=
 =?utf-8?B?U1BzSk9RTEJWMzZOaWp1eUR5NktXNE82YU9PVFFNRXFjSVRTNyt5UTNvQVBK?=
 =?utf-8?B?K1FyREhYK1lQODZ2RFdTMWJTQlhRVitmRm9OWmJrZmVLYUhTZURITWJ0ekpp?=
 =?utf-8?Q?vEIkaxfyLtqA0+UHxB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fda6dfec-d3e3-419a-b27e-08de80e81672
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 10:05:43.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9GNEmgcEx4DFi7oEIGjQbw5NtaSp6xGKsmbHM4mN8yWmdO6E9dXV5m0B/Yi/lcWNMGOY7pQ1TSFhw6QWUAC9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBKaWFuZyA8ZGF2
ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6IDEzIE1hcmNoIDIwMjYgMDE6NTkNCj4gVG86IE1h
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
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDQvMjBdIGN4bDogTWVkaWEgcmVhZHkgY2hlY2sgcmVmYWN0
b3JpbmcNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9y
IGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMy8xMS8yNiAxOjM0IFBNLCBtaG9uYXBAbnZpZGlh
LmNvbSB3cm90ZToNCj4gPiBGcm9tOiBNYW5pc2ggSG9uYXAgPG1ob25hcEBudmlkaWEuY29tPg0K
PiA+DQo+ID4gQmVmb3JlIGFjY2Vzc2luZyBDWEwgZGV2aWNlIG1lbW9yeSBhZnRlciByZXNldC9w
b3dlci1vbiwgdGhlIGRyaXZlcg0KPiA+IG11c3QgZW5zdXJlIG1lZGlhIGlzIHJlYWR5LiBOb3Qg
ZXZlcnkgQ1hMIGRldmljZSBpbXBsZW1lbnRzIHRoZSBDWEwNCj4gPiBNZW1vcnkgRGV2aWNlIHJl
Z2lzdGVyIGdyb3VwIChtYW55IFR5cGUtMiBkZXZpY2VzIGRvIG5vdCkuDQo+ID4gY3hsX2F3YWl0
X21lZGlhX3JlYWR5KCkgcmVhZHMgY3hsZHMtPnJlZ3MubWVtZGV2OyBjYWxsaW5nIGl0IG9uIGEN
Cj4gPiBUeXBlLTIgd2l0aG91dCB0aGF0IGJsb2NrIGNhbiByZXN1bHQgaW4ga2VybmVsIHBhbmlj
Lg0KPiANCj4gcGxlYXNlIGNvbnNpZGVyOg0KPiBBY2Nlc3MgdGhlIG1lbW9yeSBkZXZpY2UgcmVn
aXN0ZXJzIG9uIGEgVHlwZS0yIGRldmljZSBtYXkgcmVzdWx0IGluIGtlcm5lbA0KPiBwYW5pYy4N
Cg0KT2theSwgSSB3aWxsIHVwZGF0ZSB0aGlzIHdvcmRpbmcgYWNjb3JkaW5nbHkuDQoNCj4gDQo+
ID4NCj4gPiBUaGlzIGNvbW1pdCByZWZhY3RvcnMgdGhlIEhETSByYW5nZSBiYXNlZCBjaGVjayBp
biBhIG5ldyBmdW5jdGlvbg0KPiA+IHdoaWNoIGNhbiBiZSBzYWZlbHkgdXNlZCBmb3IgdHlwZS0y
IGFuZCB0eXBlLTMgZGV2aWNlcy4NCj4gPiBjeGxfYXdhaXRfbWVkaWFfcmVhZHkgc3RpbGwgdXNl
cyB0aGUgc2FtZSBmb3JtYXQgb2YgY2hlY2tpbmcgdGhlIEhETQ0KPiA+IHJhbmdlIGFuZCBtZW1v
cnkgZGV2aWNlIHJlZ2lzdGVyIHN0YXR1cy4NCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTogWmhp
IFdhbmcgPHpoaXdAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGkgV2FuZyA8emhp
d0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hbmlzaCBIb25hcCA8bWhvbmFwQG52
aWRpYS5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRl
bC5jb20+DQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2N4bC9jb3JlL3BjaS5jIHwgMzUgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAgaW5jbHVkZS9jeGwvY3hsLmgg
ICAgICB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvcGNpLmMg
Yi9kcml2ZXJzL2N4bC9jb3JlL3BjaS5jIGluZGV4DQo+ID4gNTJlZDBiNGY1ZTc4Li4yYjdlNGQ3
M2E2ZGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jeGwvY29yZS9wY2kuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvY3hsL2NvcmUvcGNpLmMNCj4gPiBAQCAtMTQyLDE2ICsxNDIsMjQgQEAgc3RhdGlj
IGludCBjeGxfZHZzZWNfbWVtX3JhbmdlX2FjdGl2ZShzdHJ1Y3QNCj4gY3hsX2Rldl9zdGF0ZSAq
Y3hsZHMsIGludCBpZCkNCj4gPiAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gLS8q
DQo+ID4gLSAqIFdhaXQgdXAgdG8gQG1lZGlhX3JlYWR5X3RpbWVvdXQgZm9yIHRoZSBkZXZpY2Ug
dG8gcmVwb3J0IG1lbW9yeQ0KPiA+IC0gKiBhY3RpdmUuDQo+ID4gKy8qKg0KPiA+ICsgKiBjeGxf
YXdhaXRfcmFuZ2VfYWN0aXZlIC0gV2FpdCBmb3IgYWxsIEhETSBEVlNFQyBtZW1vcnkgcmFuZ2Vz
IHRvDQo+ID4gK2JlIGFjdGl2ZQ0KPiA+ICsgKiBAY3hsZHM6IENYTCBkZXZpY2Ugc3RhdGUgKERW
U0VDIGFuZCBIRE0gY291bnQgbXVzdCBiZSB2YWxpZCkNCj4gPiArICoNCj4gPiArICogRm9yIGVh
Y2ggSERNIGRlY29kZXIgcmFuZ2UgcmVwb3J0ZWQgaW4gdGhlIENYTCBEVlNFQyBjYXBhYmlsaXR5
LA0KPiA+ICt3YWl0cyBmb3INCj4gPiArICogdGhlIHJhbmdlIHRvIHJlcG9ydCBNRU0gSU5GTyBW
QUxJRCAodXAgdG8gMXMgcGVyIHJhbmdlKSwgdGhlbiBNRU0NCj4gPiArQUNUSVZFDQo+ID4gKyAq
ICh1cCB0byBtZWRpYV9yZWFkeV90aW1lb3V0IHNlY29uZHMgcGVyIHJhbmdlLCBkZWZhdWx0IDYw
cykuIFVzZWQNCj4gPiArYnkNCj4gPiArICogY3hsX2F3YWl0X21lZGlhX3JlYWR5KCkgYW5kIGJ5
IGNhbGxlcnMgdGhhdCBvbmx5IG5lZWQgcmFuZ2UNCj4gPiArcmVhZGluZXNzDQo+ID4gKyAqIHdp
dGhvdXQgY2hlY2tpbmcgdGhlIG1lbW9yeSBkZXZpY2Ugc3RhdHVzIHJlZ2lzdGVyLg0KPiA+ICsg
Kg0KPiA+ICsgKiBSZXR1cm46IDAgaWYgYWxsIHJhbmdlcyBiZWNvbWUgdmFsaWQgYW5kIGFjdGl2
ZSwgLUVUSU1FRE9VVCBpZiBhDQo+ID4gK3RpbWVvdXQNCj4gPiArICogb2NjdXJzLCBvciBhIG5l
Z2F0aXZlIGVycm5vIGZyb20gY29uZmlnIHJlYWQgb24gZmFpbHVyZS4NCj4gPiAgICovDQo+ID4g
LWludCBjeGxfYXdhaXRfbWVkaWFfcmVhZHkoc3RydWN0IGN4bF9kZXZfc3RhdGUgKmN4bGRzKQ0K
PiA+ICtpbnQgY3hsX2F3YWl0X3JhbmdlX2FjdGl2ZShzdHJ1Y3QgY3hsX2Rldl9zdGF0ZSAqY3hs
ZHMpDQo+ID4gIHsNCj4gPiAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYo
Y3hsZHMtPmRldik7DQo+ID4gICAgICAgaW50IGQgPSBjeGxkcy0+Y3hsX2R2c2VjOw0KPiA+ICAg
ICAgIGludCByYywgaSwgaGRtX2NvdW50Ow0KPiA+IC0gICAgIHU2NCBtZF9zdGF0dXM7DQo+ID4g
ICAgICAgdTE2IGNhcDsNCj4gPg0KPiA+ICAgICAgIHJjID0gcGNpX3JlYWRfY29uZmlnX3dvcmQo
cGRldiwNCj4gPiBAQCAtMTcyLDYgKzE4MCwyMyBAQCBpbnQgY3hsX2F3YWl0X21lZGlhX3JlYWR5
KHN0cnVjdCBjeGxfZGV2X3N0YXRlDQo+ICpjeGxkcykNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJjOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgIHJldHVybiAwOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfTlNfR1BMKGN4bF9hd2FpdF9yYW5nZV9hY3RpdmUsICJD
WEwiKTsNCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIFdhaXQgdXAgdG8gQG1lZGlhX3JlYWR5X3Rp
bWVvdXQgZm9yIHRoZSBkZXZpY2UgdG8gcmVwb3J0IG1lbW9yeQ0KPiA+ICsgKiBhY3RpdmUuDQo+
ID4gKyAqLw0KPiA+ICtpbnQgY3hsX2F3YWl0X21lZGlhX3JlYWR5KHN0cnVjdCBjeGxfZGV2X3N0
YXRlICpjeGxkcykgew0KPiA+ICsgICAgIHU2NCBtZF9zdGF0dXM7DQo+ID4gKyAgICAgaW50IHJj
Ow0KPiA+ICsNCj4gPiArICAgICByYyA9IGN4bF9hd2FpdF9yYW5nZV9hY3RpdmUoY3hsZHMpOw0K
PiA+ICsgICAgIGlmIChyYykNCj4gPiArICAgICAgICAgICAgIHJldHVybiByYzsNCj4gPiArDQo+
ID4gICAgICAgbWRfc3RhdHVzID0gcmVhZHEoY3hsZHMtPnJlZ3MubWVtZGV2ICsgQ1hMTURFVl9T
VEFUVVNfT0ZGU0VUKTsNCj4gPiAgICAgICBpZiAoIUNYTE1ERVZfUkVBRFkobWRfc3RhdHVzKSkN
Cj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2N4bC9jeGwuaCBiL2luY2x1ZGUvY3hsL2N4bC5oIGluZGV4DQo+ID4gMjdjMDA2ZmE1M2MzLi42
ODQ2MDM3OTlmYjEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9jeGwvY3hsLmgNCj4gPiArKysg
Yi9pbmNsdWRlL2N4bC9jeGwuaA0KPiA+IEBAIC0zMjMsNSArMzIzLDYgQEAgaW50IGN4bF9maW5k
X3JlZ2Jsb2NrKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBlbnVtDQo+IGN4bF9yZWdsb2NfdHlwZSB0
eXBlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGN4bF9yZWdpc3Rlcl9tYXAgKm1h
cCk7ICB2b2lkDQo+ID4gY3hsX3Byb2JlX2NvbXBvbmVudF9yZWdzKHN0cnVjdCBkZXZpY2UgKmRl
diwgdm9pZCBfX2lvbWVtICpiYXNlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgY3hsX2NvbXBvbmVudF9yZWdfbWFwICptYXApOw0KPiA+ICtpbnQgY3hsX2F3YWl0X3Jh
bmdlX2FjdGl2ZShzdHJ1Y3QgY3hsX2Rldl9zdGF0ZSAqY3hsZHMpOw0KPiA+DQo+ID4gICNlbmRp
ZiAvKiBfX0NYTF9DWExfSF9fICovDQoNCg==
