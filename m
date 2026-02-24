Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AF374160
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950069; cv=fail; b=uTm10vT+hRvCl5AKKUzfaxa7vXl+aYyRPBA7qZF8f5XwKZPGj7l4ND/9D9PsKE1LF9z89nZm7FedQTeRBjNGZxwPcNoyU6pVgFXw8R3BcOpHlrf/5BUgESfM1bnINcsxAhF8zLCd3MoBi6pmSyN0joyJ28j6rJ08wecU5sRYhYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950069; c=relaxed/simple;
	bh=GJRot1+fdw2bJuXH4W5y09AAghwRKJnkqRj16uPQVLo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YglJfIYKZLaWgRQKsA1XrVoklP1YOb/BLQd2+auEc4AaLmfQLmX1IGppI1l1gsjjGX8fJ7P9nYIC/GB5Yv7ZdrjWEvwiM987rj1VxF7mOrBS0vF3XD/TOBZGNwZLS3FosmzBysKdIWKBGn0xZdM/lbVHJFhAg8STHho0Cs/N21I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hrjgW7RO; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hrjgW7RO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFx78JSmNkeKa3FVi973hjy7NSh/gfVgGWZjeiwDdcqN6/leuA3jf9djs04PMcLy4B7ZvcZ1poDc/UtfG+VBER8KrEMtslURhZ0qtryiSQ8IV4Qx2WidwtpO+UmVnG1IXVfSNY3LCzI7ER8QjOTWUmFOW3SYsxOSf7u9iCKNoqEIL+OTPZ4H/Wk6MUIw3uGuA3zba0oTq4XWvIUVyyzsN8enB3VKGSyDk3zozWMYHPAEEpMPOVL6IeGNTL6joqi5L7GguqHRva7wVKMEiSgDeg10+z7UVvik7y5fgB0K0VMkHKXJ/TctuTJz8WaBpBUeNbvGjOcziyGP4lZqmtZplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTfH/tMohBQTJBdqzUZURXE39V5EV1WGUrQVPZwaFZE=;
 b=QycP8E5TIuKyZxDpCd1oP2CGrOmXNYOW+tBgoLEH7DqKaAwRyZKoprBuJ9EJemZDBZOFScp68LXw1LHVyTZnxX11h83SyT4BMSKJLiMMES5F2Ki6YfSKnjkx9iF7lyS+ja4e5PZOKHmAPumdaXohKyLvmwDij7O/185Ogyal0d76MFa3yqA110vZeyq11MwFfHxnEt3GqS2rgMkBACF2CpCU4qVqLurFj5rhOVDOVD9YD3q/u7VGsJvgZysqg9XVO/2yeN6z4b7OBy/GnNVxC85iulrYDFmPnwtFiGkPwK8/MuotbHAr0uciIwBVZI0gIqKGXz/9+9w49llRcsgobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTfH/tMohBQTJBdqzUZURXE39V5EV1WGUrQVPZwaFZE=;
 b=hrjgW7RO23+uOfmMgnu6Jz7XwfYeLz/96z1bB9d9848hP6d8tUfm7zwRv9ikHgVzhM/YZZjQsF/7ehzUtr2jcJ4dN0D0iIZj3AXtF85OgfVrUHTJMWOHoqm2SwdxIFDURcI9DpyAIqahKPkqwlJPGcHAkAIaWmEmrL+nNoQUlf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:21:04 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:21:04 +0000
Message-ID: <a6887977-ed5c-4d4b-b09a-630cab9107f3@amd.com>
Date: Tue, 24 Feb 2026 16:21:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cxl/region: Factor out interleave ways setup
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, dan.j.williams@intel.com
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
 <20260224152645.3441489-3-alejandro.lucero-palau@amd.com>
 <0e6a60ab-8b7b-4432-b22e-336c68b328e5@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <0e6a60ab-8b7b-4432-b22e-336c68b328e5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0260.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::25) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f240245-7593-416d-5a5f-08de73c0b505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWY5SUpqMHRsN2hScERIZzBUclN5Y0VyM0h5MGh4S25VeHo4enZSU0dzNEVY?=
 =?utf-8?B?QXAyaHRIeENyZ3JGTFYxV0FsMWdlbFhveXFKcWRYUWZoNGFDMkh0SVpORjM0?=
 =?utf-8?B?ZXF4NWorZGRiSkptd25hdmZOM0xIenVZbzE3OXVzQ3RQWVp4TDhrbkdBMDRz?=
 =?utf-8?B?OE1IUDN5ekg4SkNLOEtnQ29VK0RnUU5jZzNaQ2FXSDE4c0hZb3hNcy9YRy9F?=
 =?utf-8?B?bWQrdXJwK1N4ZmptQkNGQzV1bldSaVhna3pzdEZMdmlucS84Q2cxYUNSZE96?=
 =?utf-8?B?L2w0VW43UDRLVzlWRjNNSEhuNERYRWM1aU8xZ3FZZEh1a3JtRm9peXJ2TnJJ?=
 =?utf-8?B?NTV1ZUZVRjNNMXpMWGNCUElCWi8xTmdxNVUxT1B2cTBiY0lOMVBhK2lzaDls?=
 =?utf-8?B?SWRFNkRxVnh4SVE4bEVNS2pqM3hibFdlbHF5M2M5SDE2RitScnRMVGU1NHE5?=
 =?utf-8?B?ZlR2MUorQUYvK0RJTThud0FUVVFrY2c5ZWtwMEpUSnMzS2xtVUhHSHhJdmd5?=
 =?utf-8?B?NkgvSTVSclFsckg5emxRYmhUaWs2Z2hVVUNGbXhuNmMyV25ZZW9BekJqT3Ay?=
 =?utf-8?B?V2lIOTh3MlZYVEdFcmYyWE8vMHZDQ2JWMUJGU29TTzhQZW8rMzlYak9QZlZa?=
 =?utf-8?B?R1dkcy9Ib1JRMUxEVXI1bmtKbk12Tk15RTByYmhGMGhVWEdjOHFHYlJXaUlo?=
 =?utf-8?B?UmUwdHZDL3R5K2JyRktjZHNqbE1hbVFFMkwzUWNLN3p2SklocVNvdm93MURu?=
 =?utf-8?B?NStaUE1jQ2hIRFo3cTliQ1FSMXdyRkQ2MVEweERianVsSTJvdVFRMDdGZEJJ?=
 =?utf-8?B?UUNDWEZCbGNDbGhCOEY4SHhtMUM4bzNWNkZPd3JrYWNtSlRJM2p6alZERDhM?=
 =?utf-8?B?VXhJSk1pVEZjSmlMZisrdDhQdVorYWRHNVhCOUhsOVBwVkxWTk5sZ0lTeDVB?=
 =?utf-8?B?UmlqbkljUGlUL1pEL3N4Y0gzK0dvU0JxOFpEYnRQMTFTKzY1ODBlZll5ZUdG?=
 =?utf-8?B?SzZEdmlyREtRSkxXQmtTcndrWGhWNE9aZ3dLUUpFeGJjd3hxMzNIaGJoTzlj?=
 =?utf-8?B?aUFseDFka3ppVGlrc09za0JzcVZ6a3IvN0dGUExaVWFaN2tITDdXblRxS0Vu?=
 =?utf-8?B?VUpPNEZoM0xLRGRSQ2dGUEEvTDIvMlB3MEdPbFVQeUQ0eExuL29OWE55ZHNp?=
 =?utf-8?B?NkJnUXNkckR2c2MvcVI3UDRMZDhTNEl2aGQ0eGNtcG5Ra2FJNm9wUmd4RHhw?=
 =?utf-8?B?bExzTC80YUFpalFYVW96SldCMTM5dTlpRVcyNlAvdEVTSGZ1SC80UFZwdndR?=
 =?utf-8?B?bUZrZmtUdGp2UzdDV1FQZUhMM0h3Sm03ZHdpZmFDRzV2SVR3akVCOE1vQVY1?=
 =?utf-8?B?Qi80dnhiMklkTmNNeHhKY0ZIMzJ4OU12UGE2MFFtYjhXK0piNHZPTFFVUzN5?=
 =?utf-8?B?YzBoVnVsS1VxMENob2k3U3lYSmpJcXJpSWdCK3ZKdXB1UEJ3UGJVeE42VVpu?=
 =?utf-8?B?VzA0VWN5TjBBMVVuU1VNWGRnQXZ2b0lFZktqaTVPZ090Y3cxR2ZZTjNES1pN?=
 =?utf-8?B?dHRYVkwwblFMeThvUzlRaGJZdEFTZnFOb0ZObVlaTmNta0toTlNqRlovZHdo?=
 =?utf-8?B?RDRiRlU1ZTROUEMxMDc4TVdJZ3hnKytQMmdpUHRBdVFmTmNIWjlRSUhacElt?=
 =?utf-8?B?dFFSYytEYXl2SkFyQnd0NzQ5dE02elhQOFdkWWZZZWRKRGNBRUFlTWoreUl6?=
 =?utf-8?B?NG51YmFMTDIydnBKTDlGWHptK1FkdDdIWmtpRUxFQW43a3ZWNHpGdFhEM0cz?=
 =?utf-8?B?UGF6NlRpRTAzbjlFdTlyc1pMOWJwaEMzR1J3WlI1SjlkTUdSeXRvN1d0amFN?=
 =?utf-8?B?U2txMGlkazE3TkR5MUZzL29VVCs1T0tzTmJhWGZTZTFWY0tLRW5MVkJrdUt6?=
 =?utf-8?B?SmExbGx3WlRXTEV3cURiakUvZGRad1RSN3lwOVR3c1E0bTN4Zk05eVdsWi9O?=
 =?utf-8?B?MVVoNTIyTVRmN0ZWYXZhNDdZSkdPVCtYY29xVDc2cTF5RllPWnU2Nk5HUGNW?=
 =?utf-8?B?TWcvWWdGQnAxeE54dUNlRnhZcmU2UUhhWjhjSlluWk4xUkFldVRmMEczYWZS?=
 =?utf-8?Q?DUh8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ti9mODR2MHJ6NWZEbWRQZVhxSlFLaTd1MXBCWUQ0REZPQnhHTTA1NFJKeHFy?=
 =?utf-8?B?bFVuOHpOci85SUJrVTZMaTM3YzJhYWVqWWJGRTNXdlNLSW5pMWp3Qm5RWEZ5?=
 =?utf-8?B?bldtOHY0dExsaU1lSzBLazZPVzhMRGF5NG50STRJeWN6M3cyaTFGdWVBeko0?=
 =?utf-8?B?MkdqWUhVREdGSlVGYlBDeC9oUU1mek4zRlRqTDBXWnVEYS83a1hmU3QxQW1W?=
 =?utf-8?B?MTZNeDBJMHp2cHNsZ2k3VDZ3alBiT05TNStqL0pSUlRKMUVuNTdHcXgvQWxz?=
 =?utf-8?B?dTlsV0hIMnFVL0JqWklUd2NDSzlvTkhmTE04ZnNRZmJSblhkNDdmN2NXNlkw?=
 =?utf-8?B?SzQ4R3ZweDhGZTZ0TEdXZko2ZjJOYXF1RW1iYzQxb0JMKzhuaEs4Z2dubUwx?=
 =?utf-8?B?Qng5WDZOVzVwQmRpa1BYeDk3bFY1RVA1SG96ZjNQbEFZdkIyYmM5R2JiekVy?=
 =?utf-8?B?bG9KaTRSZEJqYzFLYjFVaS9kOENucDRPNG1ibWV4REtQOHlRUlZTREd5T2wy?=
 =?utf-8?B?dkRTb041Z1BUVUhzUEExd2RIRjhHdHN1dmgwWkxBcjNOcGR2SXlqdjFPcGxE?=
 =?utf-8?B?M2VpQ25sMDJtbHAySkNJQTNZd0VFd2s4a3pXVDB5R0NheXQweW0xTjF5MXlF?=
 =?utf-8?B?ZjlBbzdwd3JYM2Fsc0NtaFNVMGZvS0pnMjEwR2JtOTdYb0ZqeFlWL01IYkhh?=
 =?utf-8?B?Q09CTVBmZ3AvTHRkS3h6dmdiL01QS0VDNHpCQmxDWHNnci9kUzgzSGtxTmNn?=
 =?utf-8?B?akFpckNZMkEyY05UZnF4SGl2SDJ2U0lwaURlZFJVUzZCMUhETmxiRFZ6THV0?=
 =?utf-8?B?dzl4U3dJTlhYenpKVVFHem5PNGRudkVCTmR1LzVzYm9XTGRUcnVpektiOVNI?=
 =?utf-8?B?T1RzaDFyZHlxa2E5NzljeXg0Y3ZUYUdJR2dpV01ZUGZTaktPbmNaZGJpc2lH?=
 =?utf-8?B?S1QxbWdyYWpjNis5Yy8xT3g0aGRRSFF0Q0Rrckt5blptYzVCcmhMdzB1bWlW?=
 =?utf-8?B?QTlFbksvOTd0ZmFIa093UDd5RmxpVmMyaWk3TUZtV1RvcTJPajE3OWtOMzhK?=
 =?utf-8?B?RjdhSlFIYW1pR09TZzFMbmxUQWowaHVBbTl2anQxS1VocmYrSURta29IbWJP?=
 =?utf-8?B?cGRCUEdpSFhnWitnQjRVNGhjam14akFUd3JXT1R1a1E5ajd6ODRubmR4M1NX?=
 =?utf-8?B?eWEzZGJNb2pwRExXVWRKZ1k0b0RjL092empodDBkYm1QbzlhZ0wzV25vWjB5?=
 =?utf-8?B?bkRNNWJEdWxKTFNGNCtjY0x3TVdyZ2ljeVIyQ2JkdlNYclBsb3c0bTRFZWVw?=
 =?utf-8?B?VVFtS3QwL096VlQxb0RBbU0rL2V1ZzI2aXhlVjJNVVliUkVBNmJNODd4TXhG?=
 =?utf-8?B?ZFdlWjdlVTVtdFYxaGUzY2IwZStoVGxzbHp5ZGJNZk5XMVN4SGY5OFUzS09V?=
 =?utf-8?B?Y1hBMEVuQzFsNW1Va3BnV1ZiZUt6OERscDlBMG9Ud2Y0QVhjNjdrMzlnZHdD?=
 =?utf-8?B?TnE3Y1h1VUpXdDltSWJNQXYyYkgyb0l5cXFybjRyTnRZNW83ZXRuYjdpQnll?=
 =?utf-8?B?T1MrWTJDTXNOalhPaUVqU2tWQmxNRWFrOWR3S2dEbHZzMTNkVTdpenAwbnVZ?=
 =?utf-8?B?Rkh3MHg1d0lseWVFR3hQUCtXeVAzZ2c3NmpCUHlSYzhOUmdHYktwNnJTcGk2?=
 =?utf-8?B?WmlLSWlwMXRBOU1pRWxLM21CMWs3djVvbVprWHcwWmdURFBMd29pa0dhN2cy?=
 =?utf-8?B?RHhzYnloK2xYck0zMFFPdXhpQmRJRldXMmdkeFl5SWxJSm9NUExSSlEzYU5D?=
 =?utf-8?B?NGwxc3g4ZVl3cThpL29mdGV3dHAwaFVPRmlyemFoM2xUL0JnWWNMRUh5b1lR?=
 =?utf-8?B?dWxvby91a3RZdTJpYk0zaDBteVkybnZZcENiUUYzdVQ4R0czdzZlUllGOWZS?=
 =?utf-8?B?UEg4bzlDeDlpeEVwN1llKyt1djgvT2tLeXZ5Y0p3UXA3eUtiSzZZcS9KcXZh?=
 =?utf-8?B?WU40MzlnL2c0eklOdVUrMFNGd3RFZHpUYnBHU1E3cm5BK0JOWU84K01Kb1Bw?=
 =?utf-8?B?K2F6cE5hbThsV0ZOQ25aYWhFS2RIalk1TkpKTGMvWlpLSHdmSGg5cVJlRGg2?=
 =?utf-8?B?bDg2VUhwMEdvWkxOZjhuNkZWbE12SUxJTlVqSDZiREFwWTNXQ0xZR0lwMGtP?=
 =?utf-8?B?WFJHZzZNS0VwUXhUUlNlUVVxYjBCZVRlQlljRkZxQlBoZElVNzY2NWt3NmE0?=
 =?utf-8?B?NUQwZjBJSDM4MTU4YW1scEhJS2d4UU5pTFIxa0ZrZXZQWU14RHd3dmFQSjVN?=
 =?utf-8?B?SHE2RkpvdG9YSDc5eWgzQzByUUNnVnJOdGRVOEpIU09qc2ljd0Vidz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f240245-7593-416d-5a5f-08de73c0b505
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:21:04.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vB3zmDlS1gpMQQzvMLx5vN24NSNjfYixqzVIyGgTVfZDMRsuiVC2FxiV5fk9TqnFAtNa6nOBK1cCbRQI6m/3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107


On 2/24/26 15:54, Dave Jiang wrote:
>
> On 2/24/26 8:26 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation based on Type3 devices is triggered from user space
> s/is/can be/
>
> Since there's also auto region creation.


Ok. I will send a v2.


>> allowing memory combination through interleaving.
>>
>> In preparation for kernel driven region creation, that is Type2 drivers
>> triggering region creation backed with its advertised CXL memory, factor
>> out a common helper from the user-sysfs region setup for interleave ways.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>


Thank you

>> ---
>>   drivers/cxl/core/region.c | 41 +++++++++++++++++++++++++--------------
>>   1 file changed, 26 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index cac33c99fe6a..3ef4ccf1c92b 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -485,22 +485,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>>   
>>   static const struct attribute_group *get_cxl_region_target_group(void);
>>   
>> -static ssize_t interleave_ways_store(struct device *dev,
>> -				     struct device_attribute *attr,
>> -				     const char *buf, size_t len)
>> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>>   {
>> -	struct cxl_region *cxlr = to_cxl_region(dev);
>>   	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>>   	struct cxl_region_params *p = &cxlr->params;
>> -	unsigned int val, save;
>> -	int rc;
>> +	int save, rc;
>>   	u8 iw;
>>   
>> -	rc = kstrtouint(buf, 0, &val);
>> -	if (rc)
>> -		return rc;
>> -
>>   	rc = ways_to_eiw(val, &iw);
>>   	if (rc)
>>   		return rc;
>> @@ -515,9 +507,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>>   		return -EINVAL;
>>   	}
>>   
>> -	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>> -	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>> -		return rc;
>> +	lockdep_assert_held_write(&cxl_rwsem.region);
>>   
>>   	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>>   		return -EBUSY;
>> @@ -525,10 +515,31 @@ static ssize_t interleave_ways_store(struct device *dev,
>>   	save = p->interleave_ways;
>>   	p->interleave_ways = val;
>>   	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>> -	if (rc) {
>> +	if (rc)
>>   		p->interleave_ways = save;
>> +
>> +	return rc;
>> +}
>> +
>> +static ssize_t interleave_ways_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t len)
>> +{
>> +	struct cxl_region *cxlr = to_cxl_region(dev);
>> +	unsigned int val;
>> +	int rc;
>> +
>> +	rc = kstrtouint(buf, 0, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>> +		return rc;
>> +
>> +	rc = set_interleave_ways(cxlr, val);
>> +	if (rc)
>>   		return rc;
>> -	}
>>   
>>   	return len;
>>   }
