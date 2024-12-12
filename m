Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3C25948B
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032511; cv=fail; b=Ej+AupKZJ4/UyOoVRbOe1fK9tUyYvzLP095qslB0a3v8REBwq4bqLWTuVuQTuehX1T4cqeQKQIx3jW7alhNKG/qbAR0A4ZLVATKzDUNrPdTeFYJhIpP8JEU2wk7ummjsl4Rpxz5NmprS58ymkGtM4etApnqrHHqnqYWLJtEr7WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032511; c=relaxed/simple;
	bh=nPVJszz5ADYJxnvoB1id9jS11vRjImUGDMlMH1V8fiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=igajbsCVCfWlCfrGfxKV2bTVzx5hubapPG219vbRBLoqHpZbqsZ4v8sEPXYYKDH5IEu6ArzrKS1XovrNcWqtKBZa816H/FTr70fvERKC1GOGlse1szPsRq7zDuFHpSz8+8UixXgrGrP3wXGFyUXyw4YIlvujcE0hQGlmdFJ9db8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g4yzj6YC; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g4yzj6YC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE5G7FH00jdkKm3NhsHfxhf4g6uKJrUmWoTUjuF7DfO34IHaCKs5djyM9O508K+hFerS6aWbDDcXD6ffzciIplDD7O5e9uwH1CV1PTCbw9uvpR+Nm4Py6GdYu7x9n1Dp0rfK1zFW8jgBr26uWEeXnHWxVeuqQSHHhSq8BiqV5HlGnvP43ttaZ+MPAdEgkJqcFAuRqh2qmooIU/ocrmQvXau7MDMAsFlSK1JuklIACj+sRpkvCPyhBPzmxaVZjVf1aAAS1X6g2g1tznu0aSoPUc7NOruwttohOTK6fOJ3eh8YdieF3ws8A9o3o+0jqCQOqsdCKTVzRFDJpUq8CdNp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPVJszz5ADYJxnvoB1id9jS11vRjImUGDMlMH1V8fiI=;
 b=Osj8AYDoZ0huSA1ETU/7vNuHmsTBcQmqXVrA0nBxzoOSmp/0u9Yu70ywqAooDkeK62P3ZvLNuTEOCJiDWtpN9KF7YcvOpO2k2RCr7vFvsvzNiFrEHpKnvtia5DT0hvAP7BMO7Y5wbYwcDNG50Dp9xRQsGPIMUdBligqWM/PNW3AtA+rbaXj25WhW1KnWQecwwTYLj03rGRoNG9yccvGm9sJYr7yowrclEM2Km/aAfssd6YEj30R5hMoDa2UJ02IC7gk39bo+TOmEav5iOIqPLRaI7l1Rq98cbMFZskrA8SzUH6T7VmD8U1CRYalaZO9+3XUYvi3Bq1B/yCD0TZZVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPVJszz5ADYJxnvoB1id9jS11vRjImUGDMlMH1V8fiI=;
 b=g4yzj6YCPgtgAUOxWMiuT95mTwzH27mLPXEzmGA0tDR8wZd6hR8oMrDYD88QPQJK8AhbZJBXodDio3W55ZT/x8V6lvq1aeIOmx4luuHa0SJHAMkFkxXm/MlDE0mNiS/JK9nSPcTaTcLCSb7nae5DQSCZXTPVGIJGHcxL5DyXclysHV5bYkUF5pSe2mvsSQr+M/u05AoIXsCNmvUV8WtDhNp3as1WB8uLmgmbOvm2bEsxSeCqGphdrhKL4TX3g7Ze68AZbrn/thC7Gka2PbJieYx635s2qMBpVMZvAtxS345yTlCiaKhR3L9+GI+tpkZwhe2hBj6h62gAksE5FxzrKA==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 19:41:45 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%4]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 19:41:44 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, Andy Currid
	<ACurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>, Surath Mitra
	<smitra@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe
	<aniketa@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, "zhiwang@kernel.org" <zhiwang@kernel.org>
Subject: Re: [PATCH] cxl: read MEMDEV_STATUS register iff the device has it
Thread-Topic: [PATCH] cxl: read MEMDEV_STATUS register iff the device has it
Thread-Index: AQHbTJMDKHZ13n+zOk23VC1bSF2LJ7Li/5WAgAADBAA=
Date: Thu, 12 Dec 2024 19:41:44 +0000
Message-ID: <4f2e1930-bdef-410d-a9b1-3fcf6c46424a@nvidia.com>
References: <20241212123959.68514-1-zhiw@nvidia.com>
 <675b39f177675_3e0fe29471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <675b39f177675_3e0fe29471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|SA3PR12MB8045:EE_
x-ms-office365-filtering-correlation-id: 23e16c4b-b997-4d70-d2cb-08dd1ae50281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjdRQUpVeUkxNVNWbnZDMmZ6cTFFN3lqcTRvdTFVZG5TaFpjSXU5NVBZRmJx?=
 =?utf-8?B?RGJiSlRzeko2Y2J2d2ZMc2M3N1h5WFN2VTZrOVovQ1BxYm11K01KYUNnNHBp?=
 =?utf-8?B?MFpmTTFjTHFONzlUSmNxZzJhZzlhZWxERjZGU2hINEFsNHlDQ2JQbCtuY05Q?=
 =?utf-8?B?U0szbTlaMDI4Vnl1YWZpRUNlMm05QkhvNXZFMGhnNVVlT2Q1ZE1LanhhMGk4?=
 =?utf-8?B?UGZ6VURWK1lKQ3JmZmp1cUVNVXZJZVAwU1dSK0dwSU1BSThlZUlnWEF0YzlC?=
 =?utf-8?B?WjBrUE1iZEV6SEVJOUROTWZaV2ZBLy96MmQ4Z1VTNkdvMGhwdWo2eHRURFJ1?=
 =?utf-8?B?L093TVljVTRWRGdIcWRQSUZBQlU5cloyV3p1SU9Fdy90UkRWZjRTZHFmNEsz?=
 =?utf-8?B?b1VvVVgrdWV6L1ZZZTdvUm5FOE5YZ2lQL2dIRC9mdExwMU53K25BQ1dYcEVB?=
 =?utf-8?B?VExHU3BHcVJFUHczMldRNGdTellUdWk5WDJMVWhqWVlqSi9TTGNtbmw5dTZr?=
 =?utf-8?B?bzhyZmpKYkJFWGNjVzA2WStTNU9mR3pjRlQzSStselNGWFlpYjlHNXdKdkIv?=
 =?utf-8?B?WDF6bENJVlhsTFpTMjJXNDk3MXcwRVlhUFlpL0c3Q3MrcWxhNlJyVXVOLzNV?=
 =?utf-8?B?RjFOT0d4SEswajdiWVlyRkRzZXE5dU01ejhvNGJWZjk1RGhxdWlZSGJOVTRV?=
 =?utf-8?B?L2cwQkxkUXRaNjdHT3JzSVdqRjVMc3ZSWDhFa04wQ3RUY1pzd2VjejBWUU1K?=
 =?utf-8?B?YmMwaUJ5M1ZpT0hsL3o3RkVoaU8yakR6WERqRjhqcGs3b1pUb0xMekQzK3o3?=
 =?utf-8?B?OFoxNERMZ1o5NHRZKzh5c08rZWx0b3AvSVBoNlo2ZUxSTkpwMGhhRjNOS0E3?=
 =?utf-8?B?R2JOd1NibnpaT3BSOXNTb2ZCWnFlZmNNdDhpbFZLOTNHUFVxTGs4SUZvV2dO?=
 =?utf-8?B?eGZsUmRIOUNwdm5ManZsMExzb1B0V0Z2M25LMlBqcmRHU1BsajVlVTIzOVpN?=
 =?utf-8?B?NEdaQ0hxZWYzUG91eTE4UDBGcUJIMlNKLzIxRThRT1J0WExuK0hzZkpiM2Zx?=
 =?utf-8?B?S25yamNEMnlOWVJmVCs1bnBtS01teTJPQmJoRHNUVzlydnprejQyeXYzK05Z?=
 =?utf-8?B?NzZIakkrNUNvbVVqQTRnWGx4K2Z2Ymp3THhGZCt3TkpNZVlaMm13MkFaSWUx?=
 =?utf-8?B?ZG5zT09OZnBPYTJYdm1IZUlueVp3eDhTYU02Sm0zVGlQZGhzd3FBaGpid2d6?=
 =?utf-8?B?SS9YbkkrTWlXZWlCZ1lrOUpVYWVubW1sVUZYUGEyVHQvdWdOUm9KRXlqTVR0?=
 =?utf-8?B?OXU5a3o3SHl0R3N1anpaRnRHUVJrTDUyL0srRkJ5ZW1vOHZaelh2K3dFL1hV?=
 =?utf-8?B?REVaL0dBbTZwTys4ekwrcWtoeXJBWnZiYWR6L3pQb0VKdmFNaFNlYmd3MXE1?=
 =?utf-8?B?T1B5TEduVjNmYjlkdlJSbW9ZMUZiT0VrOUZhMUdIZmNyV1VJZjd1ZU11ZWtC?=
 =?utf-8?B?cDBxQzJLZ2lzbEp3VEUrWUZvMnAyZFl5UldkbHdvVzdBcWEyb2FEdUJNNU15?=
 =?utf-8?B?dVh1N0Q2MFhPT2NCdlZLZmJIb0pBeTZyR0hxSFBDTTVabG5VZksrL2pvSUF1?=
 =?utf-8?B?a2k4RFVuVHdzVUVBNWZFN3plK1JtRmppS2liTU9xdTNmc2ZKcHRjb2pMNUtn?=
 =?utf-8?B?d1Jhc3VlWHYyTVUrWkxtY210WjJaSlBoQVg3YUpRRjZFbDNMUi81QUR5Mkoy?=
 =?utf-8?B?VW5Oeng4eEVkZ2xLY0h3dGNHS3lJeXh5aXprNWwrQTZON2N4YXZmcHYzSytT?=
 =?utf-8?B?UjlZSUFaRDJHcWNyaXN3Y0YvZTV0c0ptd3UxOEtxd0IycEU1NHVzdEdGeWpF?=
 =?utf-8?B?T1RDLzhvMHkrakVGb2lpc2c4ZFpRYnVld0QxUGRjRUkxRnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWxPNTZXSEtIMm9STFFBSXlSdDVDem5mdWltRytJNHpwTnlMR1UrYXJjcS9u?=
 =?utf-8?B?YTFRbU51RUZDcm1GM0dVRUNUdHRldHFrWm96RTJCWHM5NUJGUjMyL290V3gv?=
 =?utf-8?B?MlppbGpGSW5ybXltdjl3dnphMGdhbEpNcXRTcUFsU3NGdTRYWGlRNC93dDdM?=
 =?utf-8?B?QUtJSkJJSWgzWU1BempSQ0h3TC90bDY2VFZZd2I2SmVYbklBUXd4aXk1NG9Y?=
 =?utf-8?B?WWhEczAvOGtObHVHeXAvMFNzUHI5RnQ1ak9vNi9QSjJXTlBtV0pnR3JDSjNk?=
 =?utf-8?B?L25nclRvTWpQVXc0S2hnVnB5ZStoMXFLMVJtd0JlWGdiQWw0TkNzR2RvNHVS?=
 =?utf-8?B?Y1gyUXM2cHRmMmZacThsSkd6MzlrODMzNy9SeDVtOFZVZjNiVng3ZnlHemhu?=
 =?utf-8?B?N3U1TXZjMlhYNzUwYXVhcFlhdHp6T0R1WUtGbGVlSEZ1MjM5bzQrTzg2S3hp?=
 =?utf-8?B?WnhLQ2htMUVGdjl1dTAycWozcXo1QXZZUTJpTGp4cFlFb3NXalQ4Z3p0bjB6?=
 =?utf-8?B?dnhoNFdjVHlkNDNBSTRnSjlaNVN1TUV5Y0VmVk5Ecm9qZ2ZCdUR3K0xJTVRJ?=
 =?utf-8?B?N0ZGZ3VZUytEdnF4SDcySzdJYzdjdXpqeFRaVlQ3TXBXV2ozN3VNa05RQVcy?=
 =?utf-8?B?K09veUxXdUEwOFVCQWhtek9UVGNyMWxRL3lIT0prSEhNaHpwSFVwenFYb1c5?=
 =?utf-8?B?eHlWckUwMWFsU2xpUWhuUWZuV2Rmai9WTDMvK1dJT1BaNG1mNm9QZld6M3Vk?=
 =?utf-8?B?c3U5ZFJGY2dtcUJqVG1FK0h6ZEQya3ArTU4wMTNLS3BBT2N3OVZXSmEzVFFo?=
 =?utf-8?B?VzFTbDJoc0ZDWjZ5OFBxa05rc0owN1JnUjF0SGptSW5DdnBwcS9NRXl0VHNB?=
 =?utf-8?B?NnpHd0lkQk9EU0tGRmpoSjhtOE04dVRZZ2E4QmVmVmtlUW1MSW1SM3ZpMDJ3?=
 =?utf-8?B?ak5ERFFldVdySU5OUmNSY1hRaUxtbGRBbkVadTZuRXZTQ0ZseXNQQStsdXVP?=
 =?utf-8?B?WFJabGlDeHZMS3NQNXhDY3hId0VkMU1ocnp3RklFVnY3QldFUWFFcEgvaG1Y?=
 =?utf-8?B?RksvSFV6ZmpySXBjVTVmZlJmT3BkQ3FLM3BxVU1RdVliZmtDNlAwYWlqSndr?=
 =?utf-8?B?WGNiSFVuMWJMR2pnQlpZVmZ6R0kxQWNCNGNzYmlKeGFFZEtKaFJIRU50cHIy?=
 =?utf-8?B?ZlZLRDhlc3hwclFIZ25pbXFrVU80NmN0M3UrZVEzR2h4K3RQTG9NSHFoTTF2?=
 =?utf-8?B?NHo1dVlTQUV4MUh0M3hCdU56RmhnbTIvV3htVXk3bERFUnRETkJueW8wcFp3?=
 =?utf-8?B?STBTYTM1emcwY2dSUHpuWjhxT3FCcHFpbm93Y1VUeUJpRUs3aE81QUM1b0hp?=
 =?utf-8?B?OXdHMkQxVGNFQ3Vic1ZvWGw2d0RiUTgyM2ZkRjNDYUVzMGNlZmM4N0V6eFNo?=
 =?utf-8?B?NFFtU2lZbDBUNUVNcnl5MENzR0pTVytQb0JzZW9BK3hkZm9ydUZVYzdTN0tT?=
 =?utf-8?B?ZEhlUURaQVpkakFHd2VVeFFmWnZqajU5dmpiQUx6KzRhTFRwWjNhK3F0bUNH?=
 =?utf-8?B?VDNVdktTZmFoYVNYRlIveUx2N1d1MTBOZlFoVGMxaTNiMXVka2poTDQyNmNW?=
 =?utf-8?B?TjNRb2lXcmV0V1FlelEwdGNNTjhmSG00OTVXMndaMlZVUitvUGdUeWJ0SkNy?=
 =?utf-8?B?UFRkcDZ4OHVSR2prOUUraGN0RWRYTnRLSG4xdGFsZm5Rd2ZqMlZIZTNPQnFi?=
 =?utf-8?B?bW9ySjd2azB2eTc1dTlYczhjeDVGVk1PSEV5R0xYMS9LWXhtTXZtaHEwMTJK?=
 =?utf-8?B?TGJETnV4a0I4Y2Z0QVhDMzhSQ1ROWE1LdHFuLzBnT05obWx3MmxNMjIreHhs?=
 =?utf-8?B?V2Q5ODgrbmc2VXVsUEYvVW84NkNkTWhNc3BnaFdTWjlIMjFKc3ZrMDd1ZTEx?=
 =?utf-8?B?b1RvYm52eGk4R3BFTGJSQ3NVUHNQUVk4N1hYOXFCZ3VOcWVTbUJaeVVWR3pt?=
 =?utf-8?B?WGZhK2Qzb2cycERxUitydDc5N0swbUNFeHI4aFltd0V4TysvVXBaa1l3eUNt?=
 =?utf-8?B?cUN0K3BpTk1GT1p4d2J2a0t1VVpVL2NWNHZDemJQVmVWMGZzdmNxVnVlNXVR?=
 =?utf-8?Q?02hk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C05B149958771A4DAAE89A605C9B868C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e16c4b-b997-4d70-d2cb-08dd1ae50281
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 19:41:44.8158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzaEplDeXOQ2FuE3wsBDq8V+TFilMroRF4cPeB8PnCvJkZVy9Xipmi85Z9Q+RELS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

T24gMTIvMTIvMjAyNCAyMS4zMCwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBaaGkgV2FuZyB3cm90
ZToNCj4+IEJlZm9yZSBhY2Nlc3NpbmcgdGhlIENYTCBkZXZpY2UgbWVtb3J5IGFmdGVyIHJlc2V0
L3Bvd2VyLW9uLCB0aGUgZHJpdmVyDQo+PiBuZWVkcyB0byBlbnN1cmUgdGhlIGRldmljZSBtZW1v
cnkgbWVkaWEgaXMgcmVhZHkuDQo+Pg0KPj4gSG93ZXZlciwgbm90IGV2ZXJ5IENYTCBkZXZpY2Ug
aW1wbGVtZW50cyB0aGUgQ1hMIG1lbW9yeSBkZXZpY2UgcmVnaXN0ZXINCj4+IGdyb3Vwcy4gRS5n
LiBhIENYTCB0eXBlLTIgZGV2aWNlLiBUaHVzIGNhbGxpbmcgY3hsX2F3YWl0X21lZGlhX3JlYWR5
KCkNCj4+IG9uIHRoZXNlIGRldmNpZSB3aWxsIGxlYWQgdG8gYSBrZXJuZWwgcGFuaWMuIFRoaXMg
cHJvYmxlbSB3YXMgZm91bmQgd2hlbg0KPj4gdGVzdGluZyB0aGUgZW11bGF0ZWQgQ1hMIHR5cGUt
MiBkZXZpY2Ugd2l0aG91dCBhIENYTCBtZW1vcnkgZGV2aWNlDQo+PiByZWdpc3Rlci4NCj4gDQo+
IFdoeSBpcyBhIHR5cGUtMiBkcml2ZXIsIHRoYXQgc2hvdWxkIGtub3cgdGhlIGRldmljZSdzIGNh
cGFiaWxpdGllcyBsaWtlDQo+IG1pc3NpbmcgdHlwaWNhbCB0eXBlLTMgcmVnaXN0ZXJzIGNhbGxp
bmcgY3hsX2F3YWl0X21lZGlhX3JlYWR5KCkgdGhhdA0KPiBoYXMgdHlwZS0zIGFzc3VtcHRpb25z
Pw0KPiANCj4gVGhlc2UgZmVlbHMgbGlrZSBhIGJhbmQtYWlkIGZvciBhIGhpZ2hlciBsZXZlbCBp
c3N1ZSwgbm8/DQoNCkkgdGhpbmsgdGhlIHJlYXNvbiB0aGF0IHdlIHdvdWxkIGxpa2UgdG8gdHdl
YWsgY3hsX2F3YWl0X21lZGlhX3JlYWR5KCkgDQp0byBiZSB1c2FibGUgZm9yIHR5cGUtMiBpczog
ZXZlbiBhIHR5cGUtMiBtaWdodCBub3QgaGF2ZSBDWEwgbWVtb3J5IA0KZGV2aWNlIHJlZ2lzdGVy
IGdyb3VwIGZvciB0aGUgTUVNREVWX1NUQVRVUyByZWdpc3RlciB0byBqdXN0aWZ5ICJtZWRpYSAN
CnJlYWR5IiwgdGhlIHJlc3QgcGFydHMgaW4gY3hsX2F3YWl0X21lZGlhX3JlYWR5KCkgYXJlIHN0
aWxsIHZhbGlkIGZvciBhIA0KdHlwZS0yLiBFLmcuIE1FTV97VkFMSUQsIEFDVElWRX0gYml0cyBp
biBEVlNFQ19SQU5HRSogcmVnaXN0ZXJzLiBBIA0KdHlwZS0yIHdpdGggSERNIGRlY29kZXIgc3Vw
cG9ydCBzaG93cyB0aGUgIm1lZGlhIHJlYWR5IiB2aWEgdGhvc2UgcmVnaXN0ZXJzLg0KDQpaLg0K
