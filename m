Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F972628;
	Wed,  7 May 2025 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616223; cv=fail; b=Eyd9QN2MAeQbHrOROTiDhI5B9x8J6l90TP5sVvyA0jXMhJAD/aijEbIDQwvyYeXDOnyYKMhZB7pr9Z6tjqIM6j/O9DJF4ew4UVhgse6m+F3qLEdA8TVo/d8NJVww8nH183N3KL/ppknJIb83GZEHS7b3SivSlPC8xjlITSeL+HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616223; c=relaxed/simple;
	bh=AGaDVN2eS9dCQ34ECNdzaehbAu9zgHegjGMJnN0ZrOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e/b21JFVFLJhh0yQopmQLUqP3VH4fAQMat/WT0dT9kTOooUbaa+zXb2X6/IQWN5DC7vKSfO/4Rd0a6Sbew3krsnb/QVSrrrOoEYAfyAUnlzDAaF2mndDVO8AYO9D2ePPtExl4cfcZaiN0kr/E9/4Ep5ykpybvw1HQBYqhLkZ+C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vDn/LfVB; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vDn/LfVB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6vTRW4XLg1cYarTPj0mDESEm2Rc8ncQt0PxGdqZ+9UkMDNA/+ZdPyZnPnfL1G0yrAUjR3AkM2/vHsXa+FWjrt4s/K/qc5oIwGfe4fs5PZDtGPEvonCkhx3vkTfyHolIbFPUEhUcM2eEXAjthkKOToSl8yBVa14aBAQcxtIiY1e+UHNre5kI7Lkc6JYIDI89h4Lwx17u0scxLpxbzt8lS+tIYbNNQsxi/9aEqr/wSn/8ubraQhVRYqnr1fqzgaHg6vzc3szhT/RpuZINaMWrZV0EGpZ/eUouRAXICodW8p9NT/vh3Zipd7A+CZoXtrrgKDaGPfp52GzAoXNRZ5DB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRzDi+cQPw1BH2O3iJjJLmFG7nw8XuYPfiIWtP6BKvQ=;
 b=ER+NjPNHLhbtwr4Jd5KrJ32UGVnfbe7lPkjzPyCrqJf1Ihh52T2k151/pUN4oy+DFx2U/MKHx/JARoLRZ4ZYZCAP4tNQ8IVgfDiPrUpiFUJ+iDabXFdaT2tMJXx6CI+UwVZGR6oO2bqkyk5ZD+mDWf0t1E6H6ziFLfFlLOEWCFT9KW3MNZarb+DZzYI3klYyi2pTc8r6bvMbfGpZEnXXtlWcSV5zgvmtX3LI6CDbQjoJpULhpfY5Ce+wN6JefeYBtzPifQkJbCLZ95hS4gcVggYjpnxvypwbd1SNccrkYzxbQqDJE9f/YUqZwdRM1W+qCP3S8Jx7B6syZirORqJyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRzDi+cQPw1BH2O3iJjJLmFG7nw8XuYPfiIWtP6BKvQ=;
 b=vDn/LfVBLmIc9w/nSiVdC5rRLo2sbxCOTXs+ybcnesCxGIB3CKjiRn8mSK3BgsFxX3GU40mQ8MbMGRooMllKy4xArWE+bkzVrSqMOhQFs0ezvoXll+ZiHWVPTomDO4r0ZT00FPR2idyuZ4cyk9Tj/1dcW7TGRdPAcgw/BttCHEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.35; Wed, 7 May
 2025 11:10:15 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 11:10:14 +0000
Message-ID: <f12240f3-636a-4bda-89e1-42f4cf866248@amd.com>
Date: Wed, 7 May 2025 12:10:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: Allow reprogramming misconfigured hdm decoders
Content-Language: en-US
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Gregory Price <gourry@gourry.net>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250430012915.295136-1-lizhijian@fujitsu.com>
 <aBGIMglj8r5MNAmN@gourry-fedora-PF4VCD3F>
 <082de146-d5ed-4b49-ba0f-d6f018436e5b@fujitsu.com>
 <200f8614-34ba-42b4-aa8c-560d3052e496@amd.com>
 <8f7019ed-a7a2-4cc8-9a8b-e7f96cf5c8d7@fujitsu.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <8f7019ed-a7a2-4cc8-9a8b-e7f96cf5c8d7@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a75a380-9f3b-4352-1fed-08dd8d57be0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHpwN3Btd0VYaHduc21NdkFpdVBFYWxSb2s1TStnMGJqeE5tWnJHYlBDdFk2?=
 =?utf-8?B?VjhINGtWa2NhUXJWelEwaTJJalVQOHcza2o1eHN3d21OeWkyelpSN2dzZFVO?=
 =?utf-8?B?b1IrcGV6SVlkaGxVTmJvckU2TFNVZlBPdHFIaDJQSlVBbFhjN2RwYnppc1Fu?=
 =?utf-8?B?clZmYXJ5VFpCUGhpVCt4Qm1xVVdueHYvUjRmN3RKcDIxWExvVklMelpIcGZv?=
 =?utf-8?B?NW5yd2kzM0E2MXBwU290Nit3aFM1RjY3SmoyM1B1NnlYWkFnMjczSTFMSjFI?=
 =?utf-8?B?OTZhbWtzRGV5MzV2N1ZTdktLZjlTR3M1VmlMbmpON2hXekJBYmtsN1dIYXZR?=
 =?utf-8?B?TUhPdmg1SVRKc2lYa2ZyR3NnNFhidGNWalZSSXpHNTN3VU5HcnBhWjVnNm9N?=
 =?utf-8?B?d3FjVThnU2RhSXFZa2tYemxFSVNnSEJKUGloa0JvYWxaOWY1Ym85VVNlalZx?=
 =?utf-8?B?aXBrTk1kRm51bmgxb1lyQjZHRXhKVW0zRWE5ampWYm1IUE5raXU1OGw0dTFz?=
 =?utf-8?B?WGtzcHdzcDg1aElnMXBOdjFENHNHemJBUDdoN3k2WUo1UEI4Y0U3TlYyRjZi?=
 =?utf-8?B?TkpCZ3kwWmRBSGRpQjhqaXR0cjhWRjhlNlIyZ1RlR3NNNG5VRkQ1cmEwNjEx?=
 =?utf-8?B?dkhnMTl3dmJnb2RhYnFSQnBCWiswOTF4eDVvdmozMjhXUklNTnFNYlFVbFh2?=
 =?utf-8?B?bmVGUjhOWkRwbDY0NXFhbWd3Tnp6R1A5OGZuS1diRjR6b0NBRC9vSEhXRG1J?=
 =?utf-8?B?aGtyR1ZWNlRscGRWamhQQ1BGUVNvZXZRWXhMY1dmMWh0ZHh3YVE4UnhNZ3hv?=
 =?utf-8?B?aXYrWVJBNlhrUGNHbGFFUmRweTZneDQxcVd5c2ROSjRia2VCNHNQaFF6YTZC?=
 =?utf-8?B?ellwMWVNYnVFNVJ4Qzl2b2NEM1RtRlVvN3NQbGdBRjA0eDh5MEtUQlJiRlBx?=
 =?utf-8?B?WWh2Mm0wdGMvS0ZuSEdOVm1tT2hYMkQvekRNelRWZTVkUmh5UUYyTlIxeVpQ?=
 =?utf-8?B?ODI5SFIyemhPRENwRFVucUhpenh6OEdibHNLMVpFcWJZbmZGUzNUSU5MZlFV?=
 =?utf-8?B?MVcwVFhaYXN0eDBDZ0hvck9XWmNPWUVMRzNjSENVYXhEQjh4dGdsTmtxMTBl?=
 =?utf-8?B?a3U0OUJZaWFhMUFYSlRjeXV5YXZ5L0xubXpzcVFFTlliaVppU1JoWlpHeXE3?=
 =?utf-8?B?aHdEWGpWa2xXbXZsTDhOQWZjMXl1bWJEbWg4UXMzSHFTc3JGRksrMlRZVW1W?=
 =?utf-8?B?SXdZU0t4U2I1aFhrOHl1bVVRY3R3eU1raUdFRVlwS1BIU3ZXb2x1K0V0Tm1O?=
 =?utf-8?B?bkJwNThTNk5qZDl2Sk9PdmorZTIzNDQwWWZocHVJdXV6ZjhYakZhK3QwKzFY?=
 =?utf-8?B?TVRNWVpmQkpUSjJ5cER1UUZyajJUT0VtcHlOKzBUNENyZ05XWDFrclBmdGh1?=
 =?utf-8?B?NG9ZU1cxdGErb1VodFNKN0gwak1Ha0tDeE4vV1gvbDFLcHpnYVNsV080WmM5?=
 =?utf-8?B?RGQvZ2ZiRVpIZEc1blFBcldiQjlEMFdLc3hXRFhLQkJkdUNBUzd6YW5VK2hu?=
 =?utf-8?B?UWZlN0xUanhteFAwR2pRR3E0T2g0cUhlTS9XS1l5SkN3dTROZGRCQ2JBbW41?=
 =?utf-8?B?UlMyNjJaN2pEU0VMNFZyd1RBNEdLdjVhS3dTbmNYVUxobVFUb3JOWVZCN21Q?=
 =?utf-8?B?ay84QlNPbnVkMXdyTFJ3ZW8zMDJ2T2RQOS9OczdmYVJhWmthd3hXVjl5VVdz?=
 =?utf-8?B?aGVYSk1Ya3Uvd1B5WjBON29zMG1wRzhxNXdaUHhKZ2lwMjdxdSs0S29CSmUw?=
 =?utf-8?B?QjRHZDNubGx1dWdOZWpyWGRscnd0OURNbjNRaWpPRzBVSXRjOEtLMWpUM2lW?=
 =?utf-8?B?VEEzL2UrUHJqb3R1T0lWV0g3V3ZudTdubzNKckpLbnpXakFFNTEraytaaDB6?=
 =?utf-8?Q?uj0WGDsk8b0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTlvamFCV1F5OWJha1FqdzMzNStFVTVyZ3lxYnBJblFUYWpoaEpReFJWMCtK?=
 =?utf-8?B?QVQ5YjI4MlRoZkxLQ054RmNUa0dXeGRHbUg0QS9tNW0yY2N2Y3ZPYm5JcklP?=
 =?utf-8?B?eVkrZTZYUVJzNXNWTENHVFVpQmhDOEYrNnZzYjRyWFpRZ0N4ekI1L2Rhd1ZY?=
 =?utf-8?B?TmJnWjlrY0ZyUDNqQzhhVG82dkVhWTI0UHZsYUVDWXN5VDI3S2oybnlEL3M1?=
 =?utf-8?B?M0FQNlRMU0VUWndQVG9pQ0NveVpzWFlCOEFrZWRMR3NVV2J0YUFmQ05Jb3Ix?=
 =?utf-8?B?TC9nVzZmRkcxQW1xMlMrSElBcHN0V1NzTk9RdXhTMElSOVZoZEdlU0s2ZEJU?=
 =?utf-8?B?aGtkNUNuejVUQlNyWU5PeEVTOWg4REZNazZyTVE4dHNTZ3lsWkphbXhhR3da?=
 =?utf-8?B?RFhVQ3JCb3ZmY2oxYnJMaUE4OVRDL0dxRnBRdkMzTnhzTmFyeUNYMmdXVFRF?=
 =?utf-8?B?blo3NFN1U0kzUnRoeFlNTGtBL2pCNHZuVDVzSjRJc2U3NTU3blRPcEh5N3pi?=
 =?utf-8?B?ckZTdVM5c0ttRHVRU0t1cTNVUS9rOVBjeU0yYng5WlExK0FVeG9jMFg2dXVt?=
 =?utf-8?B?S1pObjN1UUhqYnNabFZmTWhMSGJLbnYrdjQ3aElpVUlJMW5MRUJobWd6TXdz?=
 =?utf-8?B?YWdjWk9yWml0VlZuMllEZVlXcUt4VSt5ak01V1RPb3RsQkFkR0J4ZGpDd2VW?=
 =?utf-8?B?dkVtclVBMmZENGpEdlVjK3JsR2pzcXpIb1dES3B2YWE4TXRtSTJ4Y3JiREJy?=
 =?utf-8?B?ZlNZSGR5RE9TYWxTdVlKSVdVOGNUY05TWC9TRVN1cmtUbFVMdEtuWm9kb2M0?=
 =?utf-8?B?YUFHVUR0UjRsQTBTRkR1ZGlJaXZTZUUxeXFtOHV2SU40SFpEK2pxT3AyZkpC?=
 =?utf-8?B?d2lXYWFnTk9HNXdKR3ZUeUkwUWNWNXhJbjIzeVFzNWJTWEk4SEdDakRyTkVO?=
 =?utf-8?B?RmFHdGl3aTFkVFJYUW5vdi9tZERPdy9IUXF1YXRLYlRqWFZRMXUxdXpmb04z?=
 =?utf-8?B?ZU5BbW1GcXh1RlA2WGJUTVJVcExWNFR4ZjVDb2twUlcwVkRhbnFzNld4Qm9Y?=
 =?utf-8?B?N0p6dnM4bWFkSFhHZFBJdytFblpiYnhqM2FxQUYxeUI2ckovamd5ZFYvSUNl?=
 =?utf-8?B?aGRnaWUweDlBRmNzaFV4ZlpOUkNYSVdWRW5SRkVzOXBVcnlJS0wrVzgydFc5?=
 =?utf-8?B?WFE0NU5qQlBLVk90THVrc1NNT0p5emh6UTV0TFA0ZjZyK1N2QkpGMk96Q3VD?=
 =?utf-8?B?VDVQYTlIaFRoNmRoRjY3cFovbXJFTVJWVkcyZ0E3NDN1a0JnUGRGRlFta0Zo?=
 =?utf-8?B?WGxGUUU0TVZwR3p0OUpycUZEcndPeFZadDdlRHpBY1RvTUVWZXAzaVdJSU1P?=
 =?utf-8?B?Rm0vak9Xbkh0UHI3RjBHOTZ5bWZoWStScG5LVmV0TENCeEFkeWM3S2tFVW1T?=
 =?utf-8?B?V2hjMUtUUUU3ek9sazd4WlgzenVNYmYrUWxsMkNpWVhKY2tOcWNKdStsajhT?=
 =?utf-8?B?YVBCYTlnNVRKa1FXbHB4Ri9RRDBCRE1HK2FCTVlYVjlRNzUxTS9SZE1ESklD?=
 =?utf-8?B?OGdEcFRGTFQ1QUpKSnNiK3NRSlR1RFA2bGZ0VmpnSzkwb0haQkMyMldCdWx3?=
 =?utf-8?B?QzE4VzZoSExUa3pNaUVzYTlRT2YyY090MlJwVWIyL21SL2lBeUxkSWh1SHRp?=
 =?utf-8?B?SHptZ3pmcTAyeHRISC9oUDI5NUNSUjd6cldSZTJYT1BORHk0SDhCS0dPZFl6?=
 =?utf-8?B?cjAyZmMyRW40VzI3NVBpSVVsWlBIZ2QvLy92Q0luOGR2S2FsMUhFZG9ybyt1?=
 =?utf-8?B?L21ZYmJpSnpzZGp6UlNORHI5a2tQV2FuT0tlQ2VhVXRkZERNMHM5SmZpbkJB?=
 =?utf-8?B?YW1aSngxUW5mVk43RENOM3BjUUhqVjdyVzRKOUpuSkl0ZTBnV0NEWU9CMXlZ?=
 =?utf-8?B?S1U3aUptWE00d3lxMW85Y3lXMnZRdWt5MHZUYWcwUzJZSTZua01rYkV3QTRu?=
 =?utf-8?B?RXB5S0pjWXlNU2lIUkcwM0hTZVdFR2hoaFcrZ2dHYWwzTWdHT3ZpK3liUXlO?=
 =?utf-8?B?UDU0TDA2VUxxeG0vQUZabDJQQ1RxSEdBWURrQ1FEeTBBUlRZeFZNUUlOdlp2?=
 =?utf-8?Q?eKp62bt3LOOxA9JB+jgdZqO9u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a75a380-9f3b-4352-1fed-08dd8d57be0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 11:10:14.9045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vX5VZtDUewMxIK6L87cSgZmQ+JBEZoysbL4AcsGogNVN9pNMM6pqharh377tAq5Irc3wmVwsEx2402BWH6H5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495


On 5/7/25 07:42, Zhijian Li (Fujitsu) wrote:
>
> On 30/04/2025 16:42, Alejandro Lucero Palau wrote:
>>> Hi Gregory,
>>>
>>> Thank you for the feedback. Based on current CXL driver behavior, user-space tools
>>> can indeed reprogram firmware-provisioned HDM decoders in practice.
>>>
>>> For example, after a successful boot, one may destroy the auto-constructed region
>>> via cxl destroy-region and create a new different region.
>>> This indicates that the kernel does not inherently lock down these decoders.
>>>
>>> As for the locking rationale you mentioned, platform vendors might enforce their policies
>>> through mechanisms like the *Lock-On-Commit* in CXL HDM Decoder n Control Register
>>>
>>> While platform vendors may have valid considerations (as you noted), from a driver and
>>> end-user perspective, depending solely on firmware updates to fix transient failures
>>> is not smooth sometimes 🙂.
>>>
>> Hi Zhijan,
>>
>>
>>   From my current effort trying to get a Type2 device properly initialized by the kernel after the BIOS/platform firmware doing whatever it needs to do, I really think we should have a wider discussion regarding this sync, and maybe to have first something from the kernel expectation of what the BIOS should and should not do.
>>
>>
>> If this makes sense, I could work on a initial draft about the outline or points to discuss about this.
>>
> Hi Alejandro,
>
> Thanks for sharing this concrete pain point. Your experience highlights a critical gap in
> "defining clear handoff protocols between firmware and the kernel" for CXL device initialization.
> I agree that we need a community-driven effort to establish these expectations.
>
>
> I’m happy to see your draft or thread for deeper discussion.


Hi Zhijan,


Great. I'll work on this and hopefully something to share in a couple of 
weeks.


Thanks


>
> Best,
> Zhijian
>
>
>> Thank you
