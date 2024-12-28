Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801214AD2B
	for <linux-cxl@vger.kernel.org>; Sat, 28 Dec 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735386264; cv=fail; b=UQmMUpkzr+TFV8VVxpql+qAfjuipxFKVEptnMz0CUERsoHIn+QGrM/8hu6yyVtlaPJqlyaNMweaOdvLEYJkXfK1Fkdk5J3uS9i46r76mavzSCtdFKySQUKckYzOSNAISC6b8xN4W5hKBG257f9M/udqun1Y0s0N47u/Y9uxBuKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735386264; c=relaxed/simple;
	bh=dgIXU2r98qNUD5fNgDdfZNZcRppRID2b1r0loKunagc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mOuEytKLdjzoCxCw8X4xPaD5rtQyk6NKe4ZM442FGqgv2+KwaTogkKqe8NmLBwYaafwOCNbkQAyV6KN+XJDiM6jenjaK17yLyYy5AxJA7TCm5BwchrKnLD4HdfiEqu9R/NQXepzj3yv4T/fQTl/75Vp+nTkKP23w89cxgvY0c2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KJdWJ9K5; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KJdWJ9K5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMbNbXvG5nSqWTpDBgtywg4xhX9HC74lkFhtGQ6wq66DB7Eitt+y/K9Cg8vvUz5LsG/7tSCBezP0msUVrO5BcmKquNvultrlEjvKdCEtnnYkDQUKar8resCIwimTY/jfm8EGdKDC1i8k7m+5XAotwUfe3txVSD4KfdvB8WFakMlU2iy+QpPks6vENmv2FcV9gDOQO+7/iJ5gMOFan2hq6KaOApmbEBKc3lcNbfxbUXfmnwwz1clZEzU+WfbQjj5FnDocXAl196+p/LxZo3jUIvHrt5Fn7wgywtGHTMFn0Tj+CuKsLbKTY6PQh8Us444AtZxeCQlBClUNHS9o9BEXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgIXU2r98qNUD5fNgDdfZNZcRppRID2b1r0loKunagc=;
 b=dUSMOS3nde3HuTBNVru3lmH/FBbqweGkw0C8YoAHJi34kB2dMJHAKi9ssPZ58HMPzah8wsa6pahKRimjvI78mfZKaa3cHc+ppuWQBXMLd10x7YhToh5z2Zme76d2lAFLzrXyD9gezrVx6swqoRFC50EtukbpWydzTNZ0Fu1TA7hg8yjjNr1wcrGX9nZX8dh82cKlSSPeCGcV5DjdKznpbENfjhB581mvvg3H0Lu9HPkog2TsrgjO/wtFlnywx5LgSl1PCPRaZm1xHktboy86jwHEDIW011TLy3PcuawwfVg/WPgMVaS0MaZ4+66bmBTQUVsG31mQRfUon8CQxdzhwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgIXU2r98qNUD5fNgDdfZNZcRppRID2b1r0loKunagc=;
 b=KJdWJ9K5eTKiEWh3DXCa/zu3zhU3tSrqtBP23Ob0fEY2uZC3O8nVrZwzzWHxF3MPdIKdHYLGoq2i3/BnEuHFVAUdUzQxndiwVnRkOd/Htoq1+9qeauMEp6L36oVPgKfKBqQbAqVTPH71f5XQpl5NwOuYE8ZOmNOsnraqFGA6X9n6hx49OAg5on8ZygMD2f6P9u53pd/UxL9xlO0PtGMnWkHcCGMV94t2o2fTtur8FmbrY8JVOUso1Tq4YAI7vype9T+a20XHhgvAaKoiiGyqE8If+DFObyLY/keeVIDcxMog0ns2GUcvSR3yYUNGJBL457YedhtAfQXH2tfWDeMqgQ==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 11:44:15 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%4]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 11:44:15 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, Andy Currid <ACurrid@nvidia.com>, Neo Jia
	<cjia@nvidia.com>, Surath Mitra <smitra@nvidia.com>, Ankit Agrawal
	<ankita@nvidia.com>, Aniket Agashe <aniketa@nvidia.com>, Kirti Wankhede
	<kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	"zhiwang@kernel.org" <zhiwang@kernel.org>, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v2] cxl: factor out cxl_await_range_active() and
 cxl_media_ready()
Thread-Topic: [PATCH v2] cxl: factor out cxl_await_range_active() and
 cxl_media_ready()
Thread-Index: AQHbTUtEj+eLJEvKE0KmtMKr5N98ArL1o+UAgAX9F4A=
Date: Sat, 28 Dec 2024 11:44:15 +0000
Message-ID: <bedbfc9c-93ea-4cd3-815a-839df5accb75@nvidia.com>
References: <20241213103906.378950-1-zhiw@nvidia.com>
 <20241224161652.000067d6@huawei.com>
In-Reply-To: <20241224161652.000067d6@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|CY5PR12MB9056:EE_
x-ms-office365-filtering-correlation-id: a4a02a8c-680b-4968-4d53-08dd2734f4c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlV5bVBnZDVWSWo3TkZUc2RTcWJmWkozRkNGajRLNVBMN250aHdrTGZjTlFp?=
 =?utf-8?B?bEtLbm11T0Z4MldocHZTMk1ZV0JRcG5PdGpIZFBGOTQxaUk0ZnA1Z05DN0tL?=
 =?utf-8?B?cjRZL1g5NXZSNWg4VUZldEl2aldzYTR1cmZRdTd1dS9WUmhnSEc5ZjUyNDJH?=
 =?utf-8?B?VDdiZUN1bTJlcDNpUTFzT1J3Z3krSDAwS2xrcVFrOTBHL1JGQ1dpUTFIbUxj?=
 =?utf-8?B?S0M5S1ZMTWxiTnJyNExWRFZ6UVZtWnRqTmZMdk5DM2ErNVRRa1hOQ01LRE1m?=
 =?utf-8?B?d09WOVZ6cFpNNVlaRmprSElVL1NmRTk3WGVWK1pFZHp3YzhKVkdkZzBUbklJ?=
 =?utf-8?B?Wk1TZnBhU1YwR0tnZ0JKNVBDZHM2RjB2dUtiSHVHa3k3VWdGT0RXUnFxTHo0?=
 =?utf-8?B?WXVkdzNMTUVQY2tkdVNmR09kU3dPeUJsNk5zTGVYcFg0YmZPUkx3NmgrWVZW?=
 =?utf-8?B?KzVYZ3pwbHBFK1VYS1BmNDZDejRnai9KcEdCdkFZMlFKckFkaVBBZ2JZZlZL?=
 =?utf-8?B?K2piYkRZYlJkazJpVzF1RU1OSDNwWjEyYVZsOXRyYWd0OFgweDhYQjZZRGYr?=
 =?utf-8?B?U05kdkh1K3phdW1TandxZE1DQVU4MjZWelUvU0R5Z1kyc0J0Vmx0dVRQRWlv?=
 =?utf-8?B?aXBHRlhQdHpoV1FQS2FQU2IxcWo1VlVPVUp3aCtxaDlMeDNhbVlzQ0pObDUv?=
 =?utf-8?B?V0VZcjVmaFRRVWN4S0RpTWU5UVdaSmR2cmVkRzN2Mm56dlF2bk8zVDdMTlNo?=
 =?utf-8?B?emRycVFaMzdrdytMQnZzTm5wK1BoVGxZYUpvcnNiL1FwRXZuajJsWFh4bHpP?=
 =?utf-8?B?a0w5ZHBqVTdXYThIbHNrc1JVVDVueW95dlAxUkh5OFoxRU1zWURYWjYxRlhL?=
 =?utf-8?B?MUs5TVY3K0xHdTYrcmhwWWwybWhkb2R5T0s0dTB1N0U3NFhZUVU4MEY3V3JO?=
 =?utf-8?B?MEFxRHlzWUlHYUtYbDNrWThJeDRlVVdOWW1QRjJOTjRETmtZTDVUcitIbkNR?=
 =?utf-8?B?cXpmYUFUMG5jc2FHY2RsT3ZiOXdOZE53b1F5U3BzU2pvYmo2QW4xc2I4bXh1?=
 =?utf-8?B?TUw3NVFXS1lCWXZHbkNuM0tEeGVVdWtNTEF3dnFReWdtajRpcjRVb2hzaFFk?=
 =?utf-8?B?aWtpRzFreDNxc2kwbVlaVnlBU213TW9DME1iV1prM3ZwRUhxZE5YZFdEN0wv?=
 =?utf-8?B?N2tIZU1WdERhSTlKZ2ZQZlVPaWlQTm1JcTJGdE5IRk9yaytoQTZnUEpMU1RW?=
 =?utf-8?B?dGlSWWNhTFFtZ1N3dkdCdllqMjMrQWROSzlVVUZjenhOR29KNnlXV2Z1Z094?=
 =?utf-8?B?MVYveTR5c0FFc0pXeFlHZlpLZ3pMWGxMbGMxQVdzRnJvS1FxTVQ5SFR6b3N6?=
 =?utf-8?B?ZkUzR3Q3OHREYW5XOGNDZm5YN1JjR1hodUpPT1oxWXliejVJR0RMWmNDaU9C?=
 =?utf-8?B?OG42SnlITHE3UkFLRlZ1SWxna3M4bjlqS2NhNWxoR3RMeWxQZHRNNndUOWVh?=
 =?utf-8?B?MGcrNWp0Z0VSWC81Y1A5R2Z4TEpCSEd3WVAxcFJWMHQ1ZURRb0pkR08zUFVR?=
 =?utf-8?B?eEZyNENwK05VSjVDL2lGeGpBZFhIU1VsWEp6QWlNejVPcGtJQnY3UjlpWGVp?=
 =?utf-8?B?L2hpMXkxOTRmTUs0Um4xdHNyaU9HSjhKWk8zQW0wK2ErQXZWRXVYcWNKQm0z?=
 =?utf-8?B?dmx6T2tWeHQxVzBmaG5TYlNPOVh4OFd6a0ZTQ3h5TldaRDBMWWdZU0kyR2xF?=
 =?utf-8?B?eldSMU9yRW90M0Fuck5HZzJrTExFWU92R1hNcUNNUXBrTkVoRFVvSkNWRC8x?=
 =?utf-8?B?dU05NnViTWlSQW9xa2gvUGtqM1ByWmtJckhOMTdqbmJzV0ppT0F1NmRkbEl6?=
 =?utf-8?B?ZGczU3YwaTQwTStKSFhOcjNQemhWc08xZlcyRVFkSVRYaVVrdFgyN1hQZG9a?=
 =?utf-8?Q?2vAne4NIqt+sheRgLXfEBFG7SODdKcbF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkNYa2tzUGZ6N2RkaFovcUtxZHYyRHNjRlRkd1dDcXJHbi9WWnBJaWRkUUlK?=
 =?utf-8?B?UTRNYndTS0Qvci9YbGZIcE1vazlTbXVhem92VDFaeCtWVEJOWnkrcFdzVGxI?=
 =?utf-8?B?d0ZTdlBHaDBMcHdhYVV6b2QxZUxVUnlYUWdKbXRmdytVT2U2VEtSUWZZbm81?=
 =?utf-8?B?a0l1eGk5MUMwbmg5Qm5nbytEZnRlQU84TXcvZnNacHFFZmZqdlNLZ3FVQkti?=
 =?utf-8?B?aXhGK0lSSlJPdlRRREM4eG1BZ2c2dWllNVNFc1QzMlhPNFFKMVlncHo4d1hU?=
 =?utf-8?B?R01uYXNiaXBoUm1QOW5ncnNsT3pxaXJ4NUVRM3FNaDdWaStsNGc0eGVEYUNq?=
 =?utf-8?B?cld6R0lRL2M1SW9keXZGYXpoVWNhbDZ6WFJ0RVh4UE5oeGF0ckhXNzY0Tzhy?=
 =?utf-8?B?NmRSbmZZNnBLam5RY0tNYW5iSFh6TEViaEF1djA2VlJnUmE0NVpQQ2tzNW5B?=
 =?utf-8?B?QktYZ2NPR3hVNklTRzJvcGgzcnZKWW9LMFZWdlFhL2hNN1NOK2dYMldteTA5?=
 =?utf-8?B?VFpHZGtEaE1QVjMvb1kzVElmR2dvelo0RUtmM1FJaEdoMVVmaXYzd1Q1VTVy?=
 =?utf-8?B?WXZXMlMrZ1dRQWxmMWd1TGJjQnVET1JvYTRxQW9wTXdrWHo2S3BWWHBSS0or?=
 =?utf-8?B?ZG9QOU1yRGxWb0R5UmZYMXR2bHF5VnhQMXdJL1Z2YUFRK0wxaXIxSTFEcE96?=
 =?utf-8?B?YWZMWXN1U0YwNHZiSkRGZGcvNkJGLzFZOWJ2SXM4VW9XZElDTHVaRXpIZ0NL?=
 =?utf-8?B?T1Uxc3dHeVV2cTVoQlBEczdDa3Nic0gvY0pUa1gydndpQTJFd3BoemVQVkMy?=
 =?utf-8?B?YXM1SEorcnRpc1NTRlVpaU4vdEZEU1pHSnpvVmhDcXJNN1FyUTJZOUREVldO?=
 =?utf-8?B?WkNNT0thUFlYRFhTODN0eFVMaWZtVUFXaVVMOXdOSzhVdTJyb0lrN1lVVHE5?=
 =?utf-8?B?aHE0bE01NGd0WUcxa2FGS3Q2Z0w3K0RjQ2J0Mm1lQmVobFZaOGxTOTBPSHNi?=
 =?utf-8?B?d3FqaUJQbWtoTFI0REdxc2JpOXdHdWkzckRHcDdGYm4zTW9YdmVVTnRJNnU0?=
 =?utf-8?B?QnMycFYyK1RMNUFNR1BjY29OdnJiTDNxMURzY1pQOUM4Y1EyNE5TcG80Tm9l?=
 =?utf-8?B?K0c3SkZKWTAxUC9tSk80cEEwMmR6SEJlMktySnRJdE0rck5iQjhWL3VLVkl6?=
 =?utf-8?B?cjlGSDZveWtDdkZYd2ZvVm9LdExYeVVmTW8vM084OS85ZE1xMmhZUEkrSWw1?=
 =?utf-8?B?NCtRWmN6MUkwWGZYc3VuNTNYRm5ud3ZWUHhBc2JRTTBpaXNqbUgxYnZWdktk?=
 =?utf-8?B?QmYwTmkvM1ExZW80dmEyNFBRdVI0VnMveTF0dWdicndvei9sWmVLQUdSWTNZ?=
 =?utf-8?B?Q1VpYWdlT1l0QThrenNhV016UUxyUzZkekwwSnpmS0M3MHJRMXh0MHhjNkNP?=
 =?utf-8?B?UWM2QVVVbU5CYjc5S1Ztc2JIZDRFWXZwaDRKaHU2NEJLODJ6REJDRmZqZmFj?=
 =?utf-8?B?bWZzNlBHZkZ3YWFQR0RpeFJuQUNXMFduSThUZzY2eWtBZXRqMXdOYlFSNUNQ?=
 =?utf-8?B?VHRpeERJY1RjNlRIQ3pUMkJUMEwxNDlvRmxRM2J2K0RkL05OWmJJNGFzdlVk?=
 =?utf-8?B?UEVwR3JxWjdXRXFaZjJIeHJhNkdlZ0FzSnU4Z3JlSEdzR0ZXY3FGVzRmbnBD?=
 =?utf-8?B?RXBsalhDNjNBZGN3R1U2WnJta0ZwU2pFdVplRUVnOVQyTWF6aU1vQk12cFVH?=
 =?utf-8?B?M0pkeWtJVzdpUmU2RGU5bzdEZEU0M0dRVmEweFIxNGJkcUdrSi9pa0NRc3Js?=
 =?utf-8?B?NjhGZU9lRnhjUGdZTjQrMklPRXg4NzM4eXgvMUlGRWNqcHAwc21YUUE5K1dy?=
 =?utf-8?B?c2NsamFEcTFadzlwWk8va0VzYkFDNkp4NnFTUm1ienhlRnphVWt5WFY4NERS?=
 =?utf-8?B?dTdzOWxPYlJ2bWlBck9MVGF6OExYWm9lYkhDSGRaSWl1Wk54TGMwb0FGOXQv?=
 =?utf-8?B?Z2ZlYkRzbXIxMXYyK084ZmtJWnVpeUZWU280THN1cGJ5ckNLNHFCa1BYUUkv?=
 =?utf-8?B?d0E4a0pvQ052aHdZTTlmOXVyLzVDaVRBeTFNWmsyTnNEdWM4S25VakR6U2dV?=
 =?utf-8?Q?YXBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C404F13AE17944BA93BC56DCF1B40B6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a02a8c-680b-4968-4d53-08dd2734f4c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2024 11:44:15.3914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sjpcjkVitlmkoAz7yxXviCx1I6/CG/T3uFzQk6Eyj3hW8SQ3B6ud55rxpKUF0sr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

T24gMTIvMjQvMjAyNCA2OjE2IFBNLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiBPbiBGcmks
IDEzIERlYyAyMDI0IDAyOjM5OjA2IC0wODAwDQo+IFpoaSBXYW5nIDx6aGl3QG52aWRpYS5jb20+
IHdyb3RlOg0KPiANCj4+IEJlZm9yZSBhY2Nlc3NpbmcgdGhlIENYTCBkZXZpY2UgbWVtb3J5IGFm
dGVyIHJlc2V0L3Bvd2VyLW9uLCB0aGUgZHJpdmVyDQo+PiBuZWVkcyB0byBlbnN1cmUgdGhlIGRl
dmljZSBtZW1vcnkgbWVkaWEgaXMgcmVhZHkuDQo+Pg0KPj4gSG93ZXZlciwgbm90IGV2ZXJ5IENY
TCBkZXZpY2UgaW1wbGVtZW50cyB0aGUgQ1hMIG1lbW9yeSBkZXZpY2UgcmVnaXN0ZXINCj4+IGdy
b3Vwcy4gRS5nLiBhIENYTCB0eXBlLTIgZGV2aWNlLiBUaHVzIGNhbGxpbmcgY3hsX2F3YWl0X21l
ZGlhX3JlYWR5KCkNCj4+IG9uIHRoZXNlIGRldmNpZSB3aWxsIGxlYWQgdG8gYSBrZXJuZWwgcGFu
aWMuIFRoaXMgcHJvYmxlbSB3YXMgZm91bmQgd2hlbg0KPiANCj4gU3BlbGwgY2hlY2suIGRldmlj
ZQ0KDQpUaGFua3MuIEkgZGlkIGFkZCBjaGVja3BhdGNoLnBsIGluIG15IHBhdGNoIHNlbmRpbmcg
c2NyaXB0IHNpbmNlIHlvdSANCnRvbGQgbWUgbGFzdCB0aW1lLCBidXQgY2hlY2twYXRjaC5wbCBj
YW5ub3QgY2F0Y2ggdGhpcyBvbmUgdW50aWwgSSANCmluc3RhbGwgY29kZXNwZWxsIGFuZCBkaWQg
Y2hlY2twYXRjaC5wbCAtLWNvZGVzcGVsbCAqLnBhdGNoLg0KDQo9PT09IHdpdGhvdXQgY29kZXNw
ZWxsID09PT0NCg0KaW5ub0Bpbm5vLWxpbnV4On4vbGludXgkIHNjcmlwdHMvY2hlY2twYXRjaC5w
bCAqLnBhdGNoDQpXQVJOSU5HOiBUaGUgY29tbWl0IG1lc3NhZ2UgaGFzICdDYWxsIFRyYWNlOics
IHBlcmhhcHMgaXQgYWxzbyBuZWVkcyBhIA0KJ0ZpeGVzOicgdGFnPw0KDQp0b3RhbDogMCBlcnJv
cnMsIDEgd2FybmluZ3MsIDU0IGxpbmVzIGNoZWNrZWQNCg0KTk9URTogRm9yIHNvbWUgb2YgdGhl
IHJlcG9ydGVkIGRlZmVjdHMsIGNoZWNrcGF0Y2ggbWF5IGJlIGFibGUgdG8NCiAgICAgICBtZWNo
YW5pY2FsbHkgY29udmVydCB0byB0aGUgdHlwaWNhbCBzdHlsZSB1c2luZyAtLWZpeCBvciANCi0t
Zml4LWlucGxhY2UuDQoNCjAwMDEtY3hsLWZhY3Rvci1vdXQtY3hsX2F3YWl0X3JhbmdlX2FjdGl2
ZS1hbmQtY3hsX21lZGlhXy5wYXRjaCBoYXMgDQpzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmll
dy4NCg0KTk9URTogSWYgYW55IG9mIHRoZSBlcnJvcnMgYXJlIGZhbHNlIHBvc2l0aXZlcywgcGxl
YXNlIHJlcG9ydA0KICAgICAgIHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZSBDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLg0KDQo9PT09IHdpdGggY29kZXNwZWxsID09PT0NCg0KaW5ub0Bpbm5v
LWxpbnV4On4vbGludXgkIHNjcmlwdHMvY2hlY2twYXRjaC5wbCAqLnBhdGNoIC0tY29kZXNwZWxs
DQpXQVJOSU5HOiAnZGV2Y2llJyBtYXkgYmUgbWlzc3BlbGxlZCAtIHBlcmhhcHMgJ2RldmljZSc/
DQojMTI6DQpvbiB0aGVzZSBkZXZjaWUgd2lsbCBsZWFkIHRvIGEga2VybmVsIHBhbmljLiBUaGlz
IHByb2JsZW0gd2FzIGZvdW5kIHdoZW4NCiAgICAgICAgICBeXl5eXl4NCi4uLg0KDQo+IEkndmUg
bm8gcHJvYmxlbSB3aXRoIHRoZSBjaGFuZ2UsIGJ1dCB3b3VsZCBwcmVmZXIgdG8gc2VlIGl0IGFz
IHBhcnQgb2YNCj4gYSBzZXJpZXMgbWFraW5nIHVzZSBvZiB0aGUgbmV3bHkgZXhwb3J0ZWQgc3Bs
aXQuDQo+IA0KDQpJdCBzdGFydGVkIGFzIGEgZml4IHdoZW4gSSB3YXMgd29ya2luZyBvbiBRRU1V
IHR5cGUtMiBkZXZpY2UgZW11bGF0aW9uIA0KWzFdLiBHdWVzcyB0aGUgbmVhciBjb21pbmcgdXNl
ciBzaG91bGQgYmUgdGhlIHNhbXBsZSBDWEwgdHlwZS0yIGRyaXZlciANCmFuZCBWRklPIENYTC4N
Cg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTIxMjEzMDQyMi42OTM4MC0y
LXpoaXdAbnZpZGlhLmNvbS9ULw0KDQo+IEFzc3VtaW5nIG9uZSBjb21lcyBhbG9uZy4NCj4gUmV2
aWV3ZWQtYnk7IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4N
Cj4gDQoNCg==
