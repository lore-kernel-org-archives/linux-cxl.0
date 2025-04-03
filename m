Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AFA95E;
	Thu,  3 Apr 2025 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743642755; cv=fail; b=WNqhy9rpKc8oFAXDeE+Ld2ZOMjePJ0mtCDnsOOqN97FW0XCYm8lKLrOrPoHHj1aBBDvGTDGWNzJM9BR9PRDqnvCCrMJTURzRPsx4fg+zjJG1fEzfQQGt1HKQW5ECmWlcDI+7txknnOfx5gKoi11NyoHmIVBgc17HJdklw9CTjxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743642755; c=relaxed/simple;
	bh=rR/arrr6aDCzH+k3pa88pIeln2VpZxHeI2FcRpmlGME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mwyUxN35QsaNCAMnUQQeRNXRrO/fpJ6DQzSVpuyDfdG3Vb9gOZyItf4ELeylbHX+g1JpxM1hmWe3Nhr5PxISOjRcqPu26uBpHDuZwnOgzT6NV54UmNENB5YIK/WAUjinx0KLJyabz7X4re+abMasUsT/OiFb2sRybbvI2r30PbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=P/dgVlea; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="P/dgVlea"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743642753; x=1775178753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rR/arrr6aDCzH+k3pa88pIeln2VpZxHeI2FcRpmlGME=;
  b=P/dgVleao6JKff2831UqmsFCpPY5170c/gud8ObWtffx8UgDh184RUxE
   xg7BpZCF4SD9Xj4URiNtW091SnXKTYHzoNGhVGuUBQhmWzbYneSwdK6kR
   MW2qgfl/Ca0NsCo/K403AdYOzp5HNyElK5XVS0Tig2pzCPdf+V6u8+sIU
   dd7qKtQAWUUB/Orcyw6q8/xiigrScbW5gaJK3qZJ6dLUuG9bnU28sQj7N
   YRuKNuIvul9fWHSU5zCQogaxIguGgpqsbmXc4DyCOMNPWe+RLLNkn1YzK
   afFkc9mMILelicgM7cVNCth70JC9jdjRJ52XuhCYp9tbbftBzjN7W78Sp
   w==;
X-CSE-ConnectionGUID: /1LVpzuYSFGVb1FoNFXPsw==
X-CSE-MsgGUID: 3BSSLSn5Sbij3/kfHqNehg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="158092279"
X-IronPort-AV: E=Sophos;i="6.15,183,1739804400"; 
   d="scan'208";a="158092279"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 10:12:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZw/mHekPgYrIFt5dfa/MQ/oh9AHaRq99oRBMZHVp+3jhg3qezs3RFA/t3ZuhWUtVjrpaj0nHidRqIzgLRu6kKQsXIjRb+iw6z4eOrrsVnjDk7qpl7hxbomvNuPc/j08nm27z2nA2X+FpF+87P0rzWy6tjCRHA5VhcQBdNAVUXq7V4XEfhDMrUNsFn9sSbYUHSzr2X2/pnQbl3RHsX5thkkPeDGH1PO1xfo/bdP6hw5g31ILRfs0T4f7GySJuA5DrgAMxKXXxEg3c/zGF+JMOA5+Rdts98kc2HFK8O+sPJJIJ0mz+XSvyEdzcQOneNT81qK3iZvsvrVDLyrpLr+X+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR/arrr6aDCzH+k3pa88pIeln2VpZxHeI2FcRpmlGME=;
 b=VbWllNZjDvbmwubrvzi4RNWT889uPlzLT9D/59YILeJ3Sw8z+9o5G0hEo5/S/PZ0N1Svw+/qlM/ELbFeQRFvNLIF9sMUDL8+KpkxvJ3IIIic5WXPrz4cbnPWsa8A7RtqAdAUWZ0Vea/rKU1BjvSS9qDAfdvwl0VoQRhS34dFlAABtEe4gBCDRnwVpz8PyS1h2xY76fipK1LOkdyTJUYvY99fwiII/2+YECehW96lWEdhB7/CspqIHc1L4lZfOIH5HMu0rEai3EKLtpDllks6HAhuPPn0s7qD9fR/5HOvRQBs+MIkO5+njYTDdvn2iNOE6hs6/fr27CB/XAURw7REMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS9PR01MB13951.jpnprd01.prod.outlook.com (2603:1096:604:364::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Thu, 3 Apr
 2025 01:12:13 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 01:12:12 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Gregory Price <gourry@gourry.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Thread-Topic: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Thread-Index: AQHbpCaxQHh+ea79DEe/ckQgeqDMvbORIosA
Date: Thu, 3 Apr 2025 01:12:11 +0000
Message-ID: <2ce69e60-8a13-4e9f-b28f-1b30162a1ada@fujitsu.com>
References: <20250402232552.999634-1-gourry@gourry.net>
In-Reply-To: <20250402232552.999634-1-gourry@gourry.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS9PR01MB13951:EE_
x-ms-office365-filtering-correlation-id: 5e07b70a-cb60-43f1-0435-08dd724c904d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1R6YmQwcVNVUW1CcnNuK3V1U2hLTGJsK3NtNDNGV0xFM0JDeDdSUGFXYWY0?=
 =?utf-8?B?bGREdTNxU1N3RjNqVXkramNnWEtLSjB3RFQwZU5tYmxTMDJQWXdKSGR5TWp4?=
 =?utf-8?B?ZXZtR2cvOXl6TE9GYUd6VlVpZmI0djRXVENGZGxEYi9HRjZKclZwZFNPT1lG?=
 =?utf-8?B?cU0zdDhVSm1nR0tNZ3NJdnY4REo5M0lHQ2lrTGpZejB0N2lxN002VFJNSW9j?=
 =?utf-8?B?UVd0dlBqaTV1ai82d2dBYkNqQnhiZGxYZXFSZVVNUE9RSlRDNkhUZmZuMjQ2?=
 =?utf-8?B?TEN3SkQ2RlQ3OFNNVVgyODZXbk1ZUndnWlExR0t4QTJxZzhSTVQxTXZRU3NO?=
 =?utf-8?B?YTZNMklTcGxqeEFvT0k5ODU3bFFvQnZYZU9FdjRiVmljWHUxbDY0U3BzcU43?=
 =?utf-8?B?VmJGNTVjaE1KM0srSzJyRy8wZEIwK0pobFR2UVo0c0I2TGJhWm5qYUs1LzVp?=
 =?utf-8?B?bzdWRVhveTRGR2s3STJ4ZGhHV2t6ZFppR3E2YjBKOHZrZGNDZWpqbGdGdGZM?=
 =?utf-8?B?Q2ZuVTdZTFM1c1N3V256NDJxM3djY0dtKzZPKzk0NDZYcFlkQnpITUVkN0hR?=
 =?utf-8?B?QmVuZkhjaWNFVWRBTngyQ2dxa2dqWkhQcHpGYWZzUGJkZVVJTkIyelU4b3NL?=
 =?utf-8?B?a0R6Rlp5Tm8wYlFldU15NUZjK0wwVmp2YVQ2SGN0UUhYL1VlYXY0c2pQbXEv?=
 =?utf-8?B?TXBSa1B0VVhMZmM3RFh1b2hrbHhlY00xYjcwQTBSdDJhU2RhV2wxbkdZSWVW?=
 =?utf-8?B?VlRvRnM2T09BREhWM2wxZFB5Nk9OVzEwMTFESDc1Y2xkdTNRank1eEgxYWtL?=
 =?utf-8?B?a2NtYXdMRmhnanJab2p2Snp6cmZGVDdvVFFsSEZadHBDcFhpRHllUU5aUDlR?=
 =?utf-8?B?Nm5Sd21CSGhNMUtiQk5zcTZxV3pheUdiOTk3VEswaFhEbHYzWWNBSnRsUHI4?=
 =?utf-8?B?cmp5cDdzYUpESjFESWwydkNUYWI4dU1KZGo5SE4vZGp3SGxyU09TOFYzMzZz?=
 =?utf-8?B?MjMrbDRPejVLZXo0bG8vcE11WEZJV0NvTTdjRlFaRHY1alhjMmlQT2dKbVg5?=
 =?utf-8?B?SGVaR0xOcWZTa1lxbjgyalhVNzUrVHVsZlhxd0pCeDRxcXVyck1sQmNrdTZ4?=
 =?utf-8?B?a1pmL1BKNTNySnBvbHhMaHBLaXBzbWtqZmJqSHFPZWFBVDdrUmZwNFhxaHhQ?=
 =?utf-8?B?UWc0UFNmKzI1WSt6UHozQ25jcUdIQmFRWk9CR055S3djOE1OTmg0NDJkMHhK?=
 =?utf-8?B?a0hmS3dIRk83aUFjaVpXMEhsdzF4c0JOdmVOY1ZLTDMyRHNHVHBJbklBWDZI?=
 =?utf-8?B?TS82QURocXA0RExGRGhlVEFDQVAzUzFIUndxK0hWczZiaENpaHpSbUd4VXcr?=
 =?utf-8?B?SkV0cTBKM00yOWp5Qmc5VjRxTTl2dDFUUVhWYlFqa3dma3JoYXdjZlFkRTZz?=
 =?utf-8?B?eUcrTUZBczlUbFJTK0N1a2dpNmVBSVhrbzczc0pNRU4yOWlOczBsTzJzQjdj?=
 =?utf-8?B?Z0R1ajA0NXpOeEpHYkpRMGlTd0FFWEhacnRPaklsei9Mb05wMy9RZDBnZiti?=
 =?utf-8?B?NjBTOWQvZDU5V09FYmN4OUVORU1CblFmcVJURTRMQzRISUdWRU4zcEZkTXQr?=
 =?utf-8?B?eUpSUTZkMVU3bmRGd2E1ZHkySDJ3QVJDYTYybjRFSUNDL2JCcERjenBBUWls?=
 =?utf-8?B?cTlXLzltSUNkV3ZDT0dFcndTYnByU0dqcG8wUGR4M1NBQyt2MXFJZ1NLS3RM?=
 =?utf-8?B?ZjZFT1pjOERpMG00TVYwdjc5S0dUZU1HL0d4ZWxRUUdleDlEdTlYQjRnMWpQ?=
 =?utf-8?B?ejkxZVlnWlNpOFo1SWt6RXFCbHZIclQvTTJXbHVrNGFDNWtkQjhXM1JCL3Vl?=
 =?utf-8?B?RjhOekFmRUZtZDd4aStZQ25qRlVWT0swcGVweDJoVUt6U3A0SzdhdTFQWWpQ?=
 =?utf-8?B?NE5rNWJ3T0ZUdyt5MUdXVHZNd1hMdWFCcXNVSTJlMHl4cTVjbFFaYi8zQ0Zp?=
 =?utf-8?Q?3ZxuRFqDhivPrZFx2HZOqmbD8mnfAY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUROMFc0R1ZIOEszVHNTczJqRzFNZFZSYkdIOG9yNEcxM0lrT1FwUUsyMGNL?=
 =?utf-8?B?YUxkQytRTXZ0RmU3QjdSRnNxSGlDdlJNUTZTSzMzMnpoQU50V01QektjdkQz?=
 =?utf-8?B?YW9La2kyT2tGZzZuWDY5aDYzWWQ1SU5mUUtPYnFjQmFlVk9mUjJ3dlFabjlR?=
 =?utf-8?B?OUFpc2FLYXRIZzhNb2RDQ2tQaitTLythTm8zY0hmK3VRTGRuSGNUOCswWW9t?=
 =?utf-8?B?UHNQUTZHU09UUkM2YjE5d25DeXVlamx1UkI1b2txOEpPeDZTUUZsWk9LR3Aw?=
 =?utf-8?B?RUg3WUx6RjNmdy8yd3BmTlRlYkg3ZVBBcFdjNWlGVktSeGZTeWlDenhNRDRp?=
 =?utf-8?B?SEhkNGFRcHBWM3RhMmhMbzNPcUNCRm9TcmxabTUwVzMwTU4zTHZ5N3lDUlFR?=
 =?utf-8?B?ZnM4NTZXVGI0d0lCNXV2T2l6eXZhOE9vdmxtQ3pVdmhQZ0JUMmFFWkp0RHFz?=
 =?utf-8?B?YjNKRVdZRUpSVmdzZWVEd2N1ZnVORHB2TVhiSVQyTXBXMmlwSHRJUVFhL0Fa?=
 =?utf-8?B?NXpWTTd0YUxRV2ZLeFFGWjdlL0MyS1BweWlyWTlTclFIK1R4cmNlNVF2VDVQ?=
 =?utf-8?B?RUxCY0FoQlJWNGFsVEJYdVRSbHNkRjNLMFAzSnlOa3ZJVXJuZng3cDZRR2Zt?=
 =?utf-8?B?d3VzREpMQjdjK2RwS2YxemRNNDAwdVJUdHNvU0VzMytPUnBlS2lWUVBpcVlY?=
 =?utf-8?B?SFJ4Qk5ZdTYwVHZWMjNncDJHMit4L3JMcnlxNnVwamNlL2FFTHFNU1BNUmdy?=
 =?utf-8?B?Qll3MTZjS0RYTERld1VMYkNHaFVmbVlNR0lNa1hJbHF1d25oY1M0RXl6Wkpo?=
 =?utf-8?B?a3pkOVRLNmRwNndjV25rNXI3dFVTeGFrajRsQ284azlBSDhrSjlpV2YrZnYy?=
 =?utf-8?B?V1NaVEVoQ3F2NHc0clBmV0dnVGFSTWpJcWNNR1hlZmRWTjk4T3p2MzlhSVVh?=
 =?utf-8?B?dzBSODRrME9GUjhHbXRDNEQvNitmUk4xTFI2Ky9wRmJZdEw5SUZhd3VCNjZ2?=
 =?utf-8?B?ZDkyNVJXSllSUUJMaWVoU0g2N1p0L3VCSVAzeTFUeEp1cVQ3YThtdG8vS09p?=
 =?utf-8?B?Ty9wcVVSTVkxdFU3Y2RhVDZsMG9Jd3Q2V0R3azgxWGRpQkVRNW05aXhNOGRI?=
 =?utf-8?B?Z2QzdHBvaHBsV0xhTmlCZ1hVWkt3aFlCMDBmVEJycUdBRTRrenJNNHlMRmV5?=
 =?utf-8?B?eXgzU20zaEhBS3lGOWp3bllBQzdvVlMrNERyVmJxc052R21NaHJSMGo2UE44?=
 =?utf-8?B?cEozNXozYllUL25oSWFEVk02eG1uL0I2T1cvTWNpQ1dxWnM1eUpqOXVLMzQy?=
 =?utf-8?B?WlUwWnh4My9ESzNBT3dnMkxGWUhNYU9HOUVleVM3bTE2QkhUL0RxTCtjVlNS?=
 =?utf-8?B?bTlieDFxTWVoaml5VTI5bWFCMHRrWU1qbUVmQzE2TktNcEdWaExQRnU2dDBh?=
 =?utf-8?B?VUM0Q3hBdGJkM0wwTm10RnM5WDlna085VWZJNGFldDgzZXNYYVNndmpaaTA3?=
 =?utf-8?B?VFAzNDZZOTdNdGFlclhtSjlSZ1p5eUEwcnN2aDdoZnA0clNkQktsVUJUSE9C?=
 =?utf-8?B?TVppUHZ2bkF6djZ5eWF1TXlFV1BxTjIwYTlQODNkTHJ3d1hncmo5Y2VFeDgv?=
 =?utf-8?B?VjA2Tm5Lc2tHeXFYZFg5OTZpU3E3dWdJSTVJODZmZ2FnR1RWb09VRkVsd1Ro?=
 =?utf-8?B?eG1BNXlBb0VVcHl2OHpUZGNtMUdpd2s1QXhhMUdQaDJLcDViVjJ3cXFyRWVN?=
 =?utf-8?B?T3h0eHVLcEoxU08wZTZnUWZ0VEpsODg4aUZBSXZOQ1FvMytLSGoyYVVZdzky?=
 =?utf-8?B?MDNNcWdiMkdPamhQWndra1BDNE5JVkZybVdRdWhmZytPZEQxWk8zdDlPQ1R2?=
 =?utf-8?B?NEJlSXZ1elltUWZPcE5wY2laY1NsTGE3K25sLzFxVjZuWStOVmtQbzk4a2pH?=
 =?utf-8?B?dDRzZ0J6aHh4MnU2RUZwUEdCS1BSTE9zaktCeWpYbDh4V2N3djk1WTUzelAx?=
 =?utf-8?B?VStrNmNWRWZGTHJ4YmJXTm9wZkJYRHVMUEhSb2dvZ1ZSa0MwQmJYZHdDUVI0?=
 =?utf-8?B?MXdNWGtyUEZJU21DTEIwdnZoK3pRQjRxOHBvOURaam9pc20vWUpjYlJMb3Zx?=
 =?utf-8?B?eC9HM3UrSk9NRHB2M2ExcUY3d1dpZk9IbWpyemwrdnlPTVNSYzB3SXhQeXlx?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1843B8AB7437F4487557235193BB41F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CUykHS/pHi29z1g4nbJpRzQGI+/A66cCtoAJS7K+siNJiCnW/HnpSXuWnSDJym9ocwdDYZM/TFdul6HhlPuRjp4mf+8lH9qapU4xS5WHVjJUMO9fJYL+psSkuRPONWQIgnTnW1CVMhfUknM+GGVpxncj/mXb0qSDaENhoWAV/53T2aSArwM3N+7AxF2bqTsnsLQtOPQRVGJ/MFWlBCr8MmckMiOs0iTzzzHutndRStm2jL6lxcMNPNQc0oBQtfhouhtu0O+bRanpgSJsEPesqppE3hSpv/Na4qqoR9YnIOPCEfL/PJDFpz+Lsi7G6w9XdIG/OHREJAAk68sQbOhiRxjXD7NTs/1mD1PWYkaPIM3p1O5W5IAO4zrcaJjTPdU0mTPnhIk6/19zh4HRJJ6Cp5MOhYWnUVavA0yV9Vj6Fb44kopzHPX3hNZ7LU7idek401a5T4glfSXqNnJFib2Mjq/zIiX5ehAAcIgYugs01H6jQPKHBPmKXo1Eee0jH3SFM1EpEV1BFfOVZxIJ/y/b+dIp+NdgUIapSWNYafmd8/ydL1yW4gUd/eCjVcrnnqF08MT1SodTc5vjPcAUgp8Idu9OqzMr3N0mfaWwa1lsF7MeKojjxDvmz29Ppa0nF6h6
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e07b70a-cb60-43f1-0435-08dd724c904d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 01:12:12.0213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ORHUNJX0ozJFU73oiD9LwXymNYRvHYGi+2vy86taVkeEihTM4I45DJeiEWqeCb2FPrb8Ofn++6QQBHK5xnCNtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13951

SGkgR3JlZ29yeSBhbmQgQ1hMIGNvbW11bml0eQ0KQ2MgR290by1zYW4NCg0KV293LCBvdXIgcGxh
dGZvcm0gaGFzIGVuY291bnRlcmVkIGEgc2ltaWxhciBpc3N1ZSwgYW5kIEkgYW0gaW50ZW5kaW5n
IHRvIGNvbnN1bHQNCnRoZSBjb21tdW5pdHkgcmVnYXJkaW5nIHRoaXMgbWF0dGVyLg0KDQpJIGRy
YWZ0ZWQgc2ltaWxhciBwYXRjaCBsb2NhbGx5LCBidXQgSSB3b25kZXIgaWYgd2Ugc2hvdWxkICJp
Z25vcmUiIHRoZSBJRw0Kb3IgInByb2dyYW0iIHRoZSBJRyB0byB0aGUgZGVjb2Rlci4NCg0KTGV0
IG1lIHBvc3QgdGhlIG1haWwocXVlc3Rpb24pIGZyb20gbXkgZHJhZnRzIGluIHlvdXIgdGhyZWFk
KEkgaG9wZSB5b3UgSSBob3BlIHlvdSB3b24ndCBtaW5kKS4NCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpbUXVlc3Rpb25dIGdyYW51bGFyaXR5IGlzIGEgZG9uJ3QgY2Fy
ZSBpZiBub3QgaW50ZXJsZWF2aW5nPw0KSSBzYXcgdGhpcyBzZW50ZW5jZSAiIGdyYW51bGFyaXR5
IGlzIGEgZG9uJ3QgY2FyZSBpZiBub3QgaW50ZXJsZWF2aW5nIiBpbiB0aGlzDQpwYXRjaCAiW25k
Y3RsIFBBVENIIDIvNl0gY3hsL2xpc3Q6IEFkZCBpbnRlcmxlYXZlIHBhcmFtZXRlcnMgdG8gZGVj
b2RlciBsaXN0aW5ncyIgWzFdDQoNClRoaXMgcmVtaW5kcyBtZSB0aGF0IG91ciBwbGF0Zm9ybSBw
cm9ncmFtZWQgYW4gdW5tYXRjaGVkIGludGVybGVhdmVfZ3JhbnVsYXJpdHkgaW4gSERNIGRlY29k
ZXJzDQpiZXR3ZWVuIGVuZHBvaW50IGFuZCB0aGUgaG9zdC1icmlkZ2UsIHNlZSBiZWxvdzoNCg0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENYTCAgUm9vdA0KICAgICAgICAgICAgIENG
TVcwICAgICAgICAgICAvICAgICAgICAgICBcICAgICAgQ0ZNVzENCiAgICAgICAgICAgIGRlY29k
ZXIwLjAgICAgICAgICAgICAgICAgICAgICAgICBkZWNvZGVyMC4xDQogICAgICAgMTI4IEdpQiAg
ICAgICBJVzoxICBJRzoyNTYgICAgICAgICAgIElXOjEgIElHOjI1NiAgICAgIDEyOCBHaUINCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwgICAgICAgICAgIC8NCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBIb3N0IEJyaWRnZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLyAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgICAgICAgZGVjb2RlcjUuMCAgICAgICAg
ICAgZGVjb2RlcjUuMQ0KICAgICAgICAgICAgICAgICAgSVc6MSAgSUc6MjU2ICAgICAgICAgICAg
SVc6MSAgSUc6MjU2DQoJICAgICAgLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQogICAgICAgICAgRW5kcG9pbnQ5ICAgICAgICAgICAgICAgICAgICAgICAgICAgRW5kcG9pbnQx
MA0KICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0K
ICAgICAgICAgIGRlY29kZXI5LjAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZWNvZGVyMTAu
MA0KICAgICAgICAgSVc6MSBJRzoxMDI0ICAgICAgICAgICAgICAgICAgICAgICAgICBJVzoxIElH
OjEwMjQNCg0KV2l0aCB0aGlzIHNldHVwLCB0aGUgTGludXgga2VybmVsIGF0dGVtcHRzIHRvIGNy
ZWF0ZSByZWdpb25zIGZvciBFbmRwb2ludDkgYW5kIEVuZHBvaW50MTANCmJ1dCBmYWlscyBiZWNh
dXNlIHRoZSBlbmRwb2ludCBkZWNvZGVyc+KAmSBpbnRlcmxlYXZlIGdyYW51bGFyaXR5IChJRz0x
MDI0KSBkb2VzIG5vdA0KbWF0Y2ggdGhlaXIgcGFyZW50IGRlY29kZXJz4oCZIElHICgyNTYpLiBJ
ZGVhbGx5LCB0aGUgZW5kcG9pbnQgZGVjb2RlcnMgYXJlIGV4cGVjdGVkIHRvIGJlDQpjb25maWd1
cmVkIGZvciBJRz0yNTYuDQoNCkN1cnJlbnRseSwgd2UgbGVhcm5lZCB0aGF0IHdlIGhhdmUgb25s
eSBzcGVjaWFsIGhhbmRsaW5nIGZvciB0aGUgcm9vdCBkZWNvZGVycyBbMl1bM10uDQoNCk15IHF1
ZXN0aW9uIGFyZToNClExOiB3aGV0aGVyICJncmFudWxhcml0eSBpcyBhIGRvbid0IGNhcmUgaWYg
bm90IGludGVybGVhdmluZyIgaXMgYXBwbGllZCB0bw0KYWxsIEhETSBkZWNvZGVycyhpbmNsdWRp
bmcgcm9vdCBkZWNvZGVyIGFuZCBIRE0gZGVjb2RlcikNCg0KSW4gY3VycmVudCBjeGwgY2xpICwg
aXQgd2lsbCBub3Qgc2hvdyBhbnkgaW50ZXJsZWF2ZV9ncmFudWxhcml0eSBhdCBhbGwgd2hlbiB3
YXlzPT0xKG5vLWludGVybGVhdmluZykNCiQgY3hsIGxpc3QgLVBERSB8IGdyZXAgZ3JhbnVsYXJp
dHkgICMgc2hvdyBub3RoaW5nIHdoZW4gd2F5cz09MQ0KDQpQZXIgdGhlIENYTCBTcGVjIHIzLjEN
CklHOiAiVGhlIG51bWJlciBvZiBjb25zZWN1dGl2ZSBieXRlcyB0aGF0IGFyZSBhc3NpZ25lZCB0
byBlYWNoIHRhcmdldCBpbiB0aGUgVGFyZ2V0IExpc3QuIg0KUTI6IERvZXMgdGhpcyBpbXBseSBh
IGNvbmZpZ3VyYXRpb24gd2hlcmUgdGhlIG51bWJlciBvZiB3YXlzPjE/DQoNClEzOiBEb2VzIHRo
ZSBJRyBhbHNvIHJlcHJlc2VudCB0aGUgZGV2aWNlJ3MgY2FwYWJpbGl0aWVzPyBXaGVuIHByb2dy
YW1taW5nLCBzaG91bGQgb25lIGFsc28NCmNvbnNpZGVyIHdoZXRoZXIgdGhlIGRldmljZSBzdXBw
b3J0cyBpdD8NCg0KDQpJZiAiZ3JhbnVsYXJpdHkgaXMgYSBkb24ndCBjYXJlIGlmIG5vdCBpbnRl
cmxlYXZpbmciIGlzIHRydWUsIGhvdyBhYm91dCBiZWxvdyBjaGFuZ2VzDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYw0K
aW5kZXggNzVjZDVkYmI0MWU0Li42NDdmZTJjZTE4Y2EgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2N4
bC9jb3JlL3JlZ2lvbi5jDQorKysgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQpAQCAtMTQz
NSw2ICsxNDM1LDExIEBAIHN0YXRpYyBpbnQgY3hsX3BvcnRfc2V0dXBfdGFyZ2V0cyhzdHJ1Y3Qg
Y3hsX3BvcnQgKnBvcnQsDQorICAgICAgICAgICAgICAgaWYgKGN4bGQtPmludGVybGVhdmVfd2F5
cyA9PSAxICYmIGN4bGQtPmludGVybGVhdmVfZ3JhbnVsYXJpdHkgIT0gaWcpIHsNCisgICAgICAg
ICAgICAgICAgICAgICAgIGN4bGQtPmludGVybGVhdmVfZ3JhbnVsYXJpdHkgPSBpZzsNCisgICAg
ICAgICAgICAgICAgICAgICAgIC8qIHByb2dyYW0gSERNIGRlY29kZXIgKi8NCisgICAgICAgICAg
ICAgICAgICAgICAgIC4uLg0KKyAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAgaWYg
KGN4bGQtPmludGVybGVhdmVfd2F5cyAhPSBpdyB8fA0KICAgICAgICAgICAgICAgICAgICAgY3hs
ZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0eSAhPSBpZyB8fA0KICAgICAgICAgICAgICAgICAgICAg
Y3hsZC0+aHBhX3JhbmdlLnN0YXJ0ICE9IHAtPnJlcy0+c3RhcnQgfHwNCg0KDQoNClsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMTY1OTczMTg4MzAwLjE1Mjg1MzIuMjIyOTg4Njg1NTUy
OTgyODcyLnN0Z2l0QGR3aWxsaWEyLXhmaC5qZi5pbnRlbC5jb20vDQpbMl0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzE2NTg1Mzc3NjkxNy4yNDMwNTk2LjE2ODIzMjY0MjYyMDEwODQ0NDU4
LnN0Z2l0QGR3aWxsaWEyLXhmaC5qZi5pbnRlbC5jb20vDQpbM10gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzE2OTgyNDg5MzQ3My4xNDAzOTM4LjE2MTEwOTI0MjYyOTg5Nzc0NTgyLnN0Z2l0
QGJndC0xNDA1MTAtYm0wMy5lbmcuc3RlbGx1cy5pbi8NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCk9u
IDAzLzA0LzIwMjUgMDc6MjUsIEdyZWdvcnkgUHJpY2Ugd3JvdGU6DQo+IFdoZW4gdmFsaWRhdGlu
ZyBkZWNvZGVyIElXL0lHIHdoZW4gc2V0dGluZyB1cCByZWdpb25zLCB0aGUgZ3JhbnVsYXJpdHkN
Cj4gaXMgaXJyZWxldmFudCB3aGVuIGl3PTEgLSBhbGwgYWNjZXNzZXMgd2lsbCBhbHdheXMgcm91
dGUgdG8gdGhlIG9ubHkNCj4gdGFyZ2V0IGFueXdheSAtIHNvIGFsbCBpZyB2YWx1ZXMgYXJlICJj
b3JyZWN0Ii4gTG9vc2VuIHRoZSByZXF1aXJlbWVudA0KPiB0aGF0IGBpZyA9IChwYXJlbnRfaXcg
KiBwYXJlbnRfaWcpYCB3aGVuIGl3PTEuDQo+IA0KPiBPbiBzb21lIFplbjUgcGxhdGZvcm1zLCB0
aGUgcGxhdGZvcm0gQklPUyBzcGVjaWZpZXMgYSAyNTYtYnl0ZQ0KPiBpbnRlcmxlYXZlIGdyYW51
bGFyaXR5IHdpbmRvdyBmb3IgaG9zdCBicmlkZ2VzIHdoZW4gdGhlcmUgaXMgb25seQ0KPiBvbmUg
dGFyZ2V0IGRvd25zdHJlYW0uICBUaGlzIGxlYWRzIHRvIExpbnV4IHJlamVjdGluZyB0aGUgY29u
ZmlndXJhdGlvbg0KPiBvZiBhIHJlZ2lvbiB3aXRoIGEgeDIgcm9vdCB3aXRoIHR3byB4MSBob3N0
YnJpZGdlcy4NCj4gDQo+IERlY29kZXIgUHJvZ3JhbW1pbmc6DQo+ICAgICByb290IC0gaXc6MiBp
ZzoyNTYNCj4gICAgIGhiMSAgLSBpdzoxIGlnOjI1NiAgKExpbnV4IGV4cGVjdHMgNTEyKQ0KPiAg
ICAgaGIyICAtIGl3OjEgaWc6MjU2ICAoTGludXggZXhwZWN0cyA1MTIpDQo+ICAgICBlcDEgIC0g
aXc6MiBpZzoyNTYNCj4gICAgIGVwMiAgLSBpdzoyIGlnOjI1Ng0KPiANCj4gVGhpcyBjaGFuZ2Ug
YWxsb3dzIGFsbCBkZWNvZGVycyBkb3duc3RyZWFtIG9mIGEgcGFzc3Rocm91Z2ggZGVjb2RlciB0
bw0KPiBhbHNvIGJlIGNvbmZpZ3VyZWQgYXMgcGFzc3Rocm91Z2ggKGl3OjEgaWc6WCksIGJ1dCBz
dGlsbCBkaXNhbGxvd3MNCj4gZG93bnN0cmVhbSBkZWNvZGVycyBmcm9tIGFwcGx5aW5nIHN1YnNl
cXVlbnQgaW50ZXJsZWF2ZXMuDQo+IA0KPiBlLmcuIGluIHRoZSBhYm92ZSBleGFtcGxlIGlmIHRo
ZXJlIHdhcyBhbm90aGVyIGRlY29kZXIgc291dGggb2YgaGIxDQo+IGF0dGVtcHRpbmcgdG8gaW50
ZXJsZWF2ZSAyIGVuZHBvaW50cyAtIExpbnV4IHdvdWxkIGVuZm9yY2UgaGIxLmlnPTUxMg0KPiBi
ZWNhdXNlIHRoZSBzb3V0aGVybiBkZWNvZGVyIHdvdWxkIGhhdmUgaXc6MiBhbmQgcmVxdWlyZSBp
Zz1waWcqcGl3Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3JlZ29yeSBQcmljZSA8Z291cnJ5QGdv
dXJyeS5uZXQ+DQo+IFJldmlld2VkLWJ5OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNv
bT4NCj4gLS0tDQo+ICAgZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyB8IDIgKy0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24u
Yw0KPiBpbmRleCAwNGJjNmNhZDA5MmMuLmRlYzI2MmVhZGY5YSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiArKysgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5j
DQo+IEBAIC0xNTUzLDcgKzE1NTMsNyBAQCBzdGF0aWMgaW50IGN4bF9wb3J0X3NldHVwX3Rhcmdl
dHMoc3RydWN0IGN4bF9wb3J0ICpwb3J0LA0KPiAgIA0KPiAgIAlpZiAodGVzdF9iaXQoQ1hMX1JF
R0lPTl9GX0FVVE8sICZjeGxyLT5mbGFncykpIHsNCj4gICAJCWlmIChjeGxkLT5pbnRlcmxlYXZl
X3dheXMgIT0gaXcgfHwNCj4gLQkJICAgIGN4bGQtPmludGVybGVhdmVfZ3JhbnVsYXJpdHkgIT0g
aWcgfHwNCj4gKwkJICAgIChpdyA+IDEgJiYgY3hsZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0eSAh
PSBpZykgfHwNCj4gICAJCSAgICBjeGxlZC0+c3BhX3JhbmdlLnN0YXJ0ICE9IHAtPnJlcy0+c3Rh
cnQgfHwNCj4gICAJCSAgICBjeGxlZC0+c3BhX3JhbmdlLmVuZCAhPSBwLT5yZXMtPmVuZCB8fA0K
PiAgIAkJICAgICgoY3hsZC0+ZmxhZ3MgJiBDWExfREVDT0RFUl9GX0VOQUJMRSkgPT0gMCkpIHs=
