Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF72F83CB;
	Wed, 18 Mar 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856477; cv=fail; b=j49lOaZAKwtcEtDwXo//LdOxg4GcVb1gaH5kGFjIOC2H8gp9DwloreV8tHeli2SPZ4iLMqYwrbBOxelDOdnzr+vjMYYcjmUFOCJ2oBwYqCURCA3bym1S+T4kRnsXba6iXHgMxd8dK9l6tohK0c+Ce1hbTeT0LBLdz+53E2c/igw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856477; c=relaxed/simple;
	bh=Kh4hDIZGS/N2Rk46/If/Fo/rcnV3LPWnkIZKYZWvb3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZEXQrWGBPCFX/yMP/yNjBJkPG7jgyIjDE0paDqhh1PvP08qmwv2KPSBcupzZ0vOSJZkBuj/DwOqw7raatk3doL+oMy9trxYhPywtmSr1p8Qs2waCfRosJfjTh17PW2UM8h95iArdnIRTALnTOUs3c/CrMnBYI5jtxWWjoJwqXBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kRUo7S11; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kRUo7S11"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7pjq20Jlqsr14lxWrGjDzCI6fUvb/v08EPjym5UTHzUwgE0zhmLSJUdDuKvExozu/sg2I559arcww6w7C8tNGNfZ2KuHsL9MCTIULa62j9lXXZw3ObGn0hY9ziWNJ4k1cU8JybvePHc+tEuRDLwzxR60QKI3W+OCkJXatX3vXaEw+gPaxP2OgOd63cF/WKDoJ6UU+4k5fB5iZvlJQSXVh8O8HDkIxP+D5IK4nTvsK6TtP4pZpLfFyLmf77DGHWb7/I6Mgk9SzOZj58fRGv48rvEJgl+N+f9PXxVXsaExhatUf3ODTWKpWZfqFK/RGjaxH88BIRirHYftgk3HztZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh4hDIZGS/N2Rk46/If/Fo/rcnV3LPWnkIZKYZWvb3Y=;
 b=SiBellO+Qx+tsC+KCTQNMSYHJ4iQrKJiGux3zFJklvWIemvboNgMbLvGuRJnZKh/6W1/h99chF2PKUnERoOg1a2Bp6rEW5G/ld59ItfPCwmmgAHf9J2xFtZ/PbTk4hld4inyfmYKDgH9QfO/Ba9lEIrlc2Mj63mPtw2CUzjebA1tNfcs0dp9ZPsxNtiNilP76p8EKmIa2hSPDUui2S6QkaIQ0oteqQ3a8Cn7WXowwGm0M11n5wy3Wn7asmI0Z0AhG+2NcOj+RKRzSwXkeOboKeRJddQKcGM0HIxVFkq+bOeJxcFkGX6SVLF8etAETpSKMmZJRDupA+QaROz5R+mJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh4hDIZGS/N2Rk46/If/Fo/rcnV3LPWnkIZKYZWvb3Y=;
 b=kRUo7S11PnpTUFCYHR+03XP77hToVyE/9z7AByXTC5HIXxanxxe1ka/IgBvuB2QafZr588nu0p8XAdvZCgFplx61NB+pio8ZSPgpvNAc5ShmBVd5vIfW9pfgvmq17rPE2k0jmnUgq2criWHFtjezdGdyx9ppCKE5Tv5PYi3eLFq+ZaKNi8KBWF0JxBuLpK9F6x+y3LzZUcVxrbQ7EGbiKsCqZm471w8cjK8x649f8qWwpVmxNAxFJcrAUK2OMTJMZXEjvQiVDDbVGAEXmqi+Nb2QnLB29L+wn+FeZGnwo6AiAvJAOl+M9WRZIpYN3oNt5hTrAf3eOPfdMhiBWg0mpQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 17:54:32 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 17:54:32 +0000
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
Subject: RE: [PATCH 11/20] vfio/cxl: Expose DPA memory region to userspace
 with fault+zap mmap
Thread-Topic: [PATCH 11/20] vfio/cxl: Expose DPA memory region to userspace
 with fault+zap mmap
Thread-Index: AQHcsZbER7TZ5nrm1EW4e19R2TgzkrWstKKAgAfoknA=
Date: Wed, 18 Mar 2026 17:54:31 +0000
Message-ID:
 <IA1PR12MB90307C0CB30F8BB1D45A04D8BD4EA@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-12-mhonap@nvidia.com>
 <4168a704-e9ec-405a-8e66-80c7e854d7c1@intel.com>
In-Reply-To: <4168a704-e9ec-405a-8e66-80c7e854d7c1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|MN0PR12MB5978:EE_
x-ms-office365-filtering-correlation-id: f161b9b8-1322-4039-a13c-08de851768af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003|921020|38070700021;
x-microsoft-antispam-message-info:
 7U6bjxIp8j5ON6c4AZi2i5U26ANFSXEapnVsQL7Q3WS61nSvuFcW+OyZrV06H+hrxsFs8C2C1/0X7cffSSAao8ES6ilfoVLXdyDE7YVJgGpuKcZc++QeMJgcidHA1j4kvs9jwQwwolNDLRDdegJrNo2JN8VzHT7HXpIwOp9b8cOJarzpFQd0asX5iJr89Ijn6DC4BkJ86+0spDthl/yFUCdOSC/9Hnd9qiT842rpiiEr8u4zTG5T6+6W1bi15ZSpHKtmTjfYMiXeJe5RDoHm8RYmYhbTW2TTJ2E6f0YU7/szhMe1OCeY7eT5BMgoQBtqP1scqlQx9+9LSYtMVQ9oDMAkfDyVaq1Y9Pc4E8iFq3eVKIeyFlFuY2f2Mo2TzNUFJIStXrB0zvG9CQ/GpNInZVCyyPuZFbGY4Z02jcNmgdcgTeTB000YexuBUI7FR/0s+MTbw79FcegU6ozPv/FRUccB/iSzzUWrh3Jgk6syoQkxvatoCKnraJgB2yMPoNS2DGPxKpvGerTO5dldK1BSuvjlcgy0GDkPgJQuBzk1AP3L7cWWSzF1mmpICcd9c8XP1eo+g5QBr5PLdAgh4xy7zDrjpwLVmg86uGC4v8SamvbDa233ySU7BkSxsONwLuALslAmwoVio45/f0A9z8xuJ+OugRrJUiIz2vmTg4GmVJCo9/Gaud6uB5UuLvgZjK7El5G5KbeQuVua4U6j74XSkSrTAlX/zGlfv9rEnYJ1GnIZUOJnleUg0OSc3kDtMD4xYfBAMNdCiMYI2b13nbhjq/hoF4yhVcVqjqaC2NoDoYMMwz6ZIw2yHGLilwCnqhBI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlhnY29Jclh4SzQ3NUV5YStRc3hhUzJHZnVHb2JIR2dBMjRwRkN3Q3RLcW42?=
 =?utf-8?B?eWlCd1hnZVdrV0lSc1JHSGlRVzlxVDREclBPYk9xVmc0NlFKTjl3RUN1aFc5?=
 =?utf-8?B?dEhpUEV3ZFgzWnI2TUtaaU1wWW5PWVVhelA2OExKTHF5cVpOT3VOYVg4eHNo?=
 =?utf-8?B?OS9ERVZWSGdaeUJZQU1DNTV0bXJhZjZXbTN1K3lkNTliT3BqdHVka1lScThF?=
 =?utf-8?B?ODNVZkVzWXVJaHRNMjJFeDFjWEV1SDQ5MEhpTVZqVTBQbVYvdVpuQVNkYlZm?=
 =?utf-8?B?dDlRSDI3TStXaEc1SkVicHhXck1aOVlNU1BwVCtGdm9RejFWZUhldyt4YVRL?=
 =?utf-8?B?aXhiR3BRc0RXekQ0TDVnSWxtYzV5a1F4U1NONmRWK2xkd3ZURzhWTDh0bmNr?=
 =?utf-8?B?bXZXWnpidTd3ZVhDV1FRWjdMcUljbmN1cXVvQ0pUY3g0cE9HU0piZE9DL2dn?=
 =?utf-8?B?YXVsVUgvTXBDUTdQZnpvbmNzbDVLL04yMlVHdkJnN3NZc1hUOXIrT3JuM1kv?=
 =?utf-8?B?OUV4aDFCRW9RTzVEL2d0K241QnkvOWlGZDNLZXpNQ0tRelV3MlFnZ3gvYUIv?=
 =?utf-8?B?K2lIVUdleEk5Y2pVMnlhUGd2Ums0QXQrQWxaMFkxc21uNEdka3dITGxuL3Ez?=
 =?utf-8?B?N095RmpCNUQxeVEzR2tWZUdJNDJwNUdRSjdPRUlNNGpRT2N6aUVTMUhYZFE4?=
 =?utf-8?B?Z05aNFV1bmV5VysxSm9zUllDZGFQZ2t6SUxUaGQ5dmIrUE1leGorZ2tQaVpP?=
 =?utf-8?B?b1kwWDhIYkNiendOZTgveGhGc1lrZzVmcEZNRHdlNnUxbjE5NlBaS2dodFBN?=
 =?utf-8?B?Q3Jjd2p5eHduSGhKTS8yMVRsY3BBdHJwWXRjQXZOclN5a0docUV6MkJqUDMw?=
 =?utf-8?B?enJNN1c3bGszNTZ2OHpZclZPZnQrYzlCa0JFNlc4TmJhSjRsZXBmT3lieXdI?=
 =?utf-8?B?OUVFem9MMURvcjBNQjJVcVBmK1duRC91WXJiK1VLSG4rSnkxTFhKTXh0ejdw?=
 =?utf-8?B?L3VWVkM4QXNlWWJlTTRGNUluYU5xYzMxdldwUUNSc09xci9VZ01ZQkhQdzZT?=
 =?utf-8?B?Qm1oQ2JIM2oxRTRaSWVOTnU1aUdBclRNaHBOb1dxTjZGaXJmWS9TUEtlRS84?=
 =?utf-8?B?WUFuL0Q0N295Z2NjaGIwYThjeGlsMkg3VjJxYi9yakV1S0lLYW1mMHJMdWNM?=
 =?utf-8?B?S1QwSlArV25jUDBKVkkzbExPN0dYc3JqL1BQT2pnRXZnNUlNWDhZRE9kTHB1?=
 =?utf-8?B?MFBHUVNvYUJNYnVTcnF3YkZQMXRieGhMbWFtcnFDRnJtNVV2Y3drMmhmQnNv?=
 =?utf-8?B?TmxuZGtpMHJEd0JKNHc3TjlETVVCUE9yQWZMYnVrTmdLUXNYMEc0MDdHcU5H?=
 =?utf-8?B?d1JwYlppV1JKQmVVMEh6QUZSVkJwVEdFMUJFSjdGZFpzQ25qcEtYS3VyTkRW?=
 =?utf-8?B?QldZcVhSU21ieWF1S09rS1NQOVVhaVQxalRaL0M1Z2l4NURyRURscEpEUnUv?=
 =?utf-8?B?NHpkbjJ4VWVMVG9BRTlwVGxydVZMOWN6REIvanlEM1hibXlsbFhMVnZUaGFD?=
 =?utf-8?B?TXJBR0R4ejJGVnQ1eUVncHJOS2tKOXE1bHlJek9LTmtyVHd4eit6V1ByTDBW?=
 =?utf-8?B?YTRBM1RGbG4wSWdqb09EaDN6MkI4M1N4blFKdGcvZ3YxTkNKMU5JMURWbUtL?=
 =?utf-8?B?ci9QN0U1VktjSE0vUDRNeDRSa21LVHBwaXhwQ29uaHJmRnd1ajAvYmdadVhr?=
 =?utf-8?B?UG8wYmplS3ljbHp5RkVkR2YxUlZiN2hqaENKa1FPZmdWVzFxcHUvazkxZits?=
 =?utf-8?B?bTN6SWRzeGttUmRKd3lNWDQwbC8zdjVuY0l6a3ZWSzZ1a1NjRUI2KytNY212?=
 =?utf-8?B?S0JWM29yUDVuWGQzODgwdjkxN2Jxak11U0llbDdpaGlwTXdnWXJIa0JzMmV1?=
 =?utf-8?B?alBDQXg5SjdjdENIUldQdnJJc3A4ZllXQzB1ZUpDazVvWlZFNHFTNzNXN0R1?=
 =?utf-8?B?T1JDRHFSMlZHa1haS2dYcHd6RlRoS1R5Y09uVU1pN0x3M1BBT2d6aVZvcTlF?=
 =?utf-8?B?TUxzdDNkZ1FKZUMxamNScnNlY2xFRUZ6QjlaY1Z6Y2ovdWQ4dHNsSDFVMSs4?=
 =?utf-8?B?bER3LytOdGZJOXlMKzVKOXNQOERZSUwrR3VRUmpHWFFvR1NqTHFLV0hkb2w0?=
 =?utf-8?B?NklOaUE5d2xZVGJDVDY3b0UxaFBydDV2REZCV0duRU54RjFPODVIZnE1cUp1?=
 =?utf-8?B?SFFlUGE1MytpS2dlWGtoMi9FbTRiTkgxaUtGSk9VbGRiSUozWWt5VVBndlYw?=
 =?utf-8?Q?T56eFNki1qsMbdJpAU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f161b9b8-1322-4039-a13c-08de851768af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 17:54:32.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ST9xjSdXIeKgi12pNEYZlkAMcKB/HiMWpBe/bcqygZCm8mlepqxqQwQsHvDEj/Wneu8cyp6LYUuBUiBzpkwmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBKaWFuZyA8ZGF2
ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6IDEzIE1hcmNoIDIwMjYgMjI6MzgNCj4gVG86IE1h
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
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMTEvMjBdIHZmaW8vY3hsOiBFeHBvc2UgRFBBIG1lbW9yeSBy
ZWdpb24gdG8gdXNlcnNwYWNlDQo+IHdpdGggZmF1bHQremFwIG1tYXANCj4gDQo+IEV4dGVybmFs
IGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiAN
Cj4gT24gMy8xMS8yNiAxOjM0IFBNLCBtaG9uYXBAbnZpZGlhLmNvbSB3cm90ZToNCj4gPiBGcm9t
OiBNYW5pc2ggSG9uYXAgPG1ob25hcEBudmlkaWEuY29tPg0KPiA8IC0tc25pcC0tID4NCj4gDQo+
ID4gK2ludCB2ZmlvX2N4bF9yZWdpc3Rlcl9jeGxfcmVnaW9uKHN0cnVjdCB2ZmlvX3BjaV9jb3Jl
X2RldmljZSAqdmRldikgew0KPiA+ICsgICAgIHN0cnVjdCB2ZmlvX3BjaV9jeGxfc3RhdGUgKmN4
bCA9IHZkZXYtPmN4bDsNCj4gPiArICAgICB1MzIgZmxhZ3M7DQo+ID4gKyAgICAgaW50IHJldDsN
Cj4gPiArDQo+ID4gKyAgICAgaWYgKCFjeGwpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVO
T0RFVjsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFjeGwtPnJlZ2lvbiB8fCBjeGwtPnJlZ2lvbl92
YWRkcikNCj4gPiArICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiA+ICsNCj4gPiArICAg
ICBjeGwtPnJlZ2lvbl92YWRkciA9IGlvcmVtYXBfY2FjaGUoY3hsLT5yZWdpb25faHBhLA0KPiA+
ICsgY3hsLT5yZWdpb25fc2l6ZSk7DQo+IA0KPiBTaG91bGQgdGhpcyBiZSB1c2luZyBtZW1yZW1h
cF9wYWdlcygpIGZhbWlseSBvZiBjYWxsIHJhdGhlciB0aGFuIGlvcmVtYXAoKQ0KPiBsaWtlIGhv
dyBEQVggZG9lcyBpdD8gQ1hMIG1lbSByZWdpb25zIGFyZSBub3QgTU1JTyByZWdpb25zLg0KPiAN
Cj4gREoNCg0KT2theSwgSSB3aWxsIGNoZWNrIHRoZSBEQVggY29kZSB0byB1cGRhdGUgdGhpcyBw
YXJ0Lg0K
