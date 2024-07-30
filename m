Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C0624;
	Tue, 30 Jul 2024 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319879; cv=fail; b=K0+GkFMhaAoLYKFEfHxUcUXSzyesbsrUD/GFJqTcXkEzrP/Bb14OjaZfUNM0KbZo0yPLYU/IxrBir55ocFlGO0PHrYoz+PyAYDeuOTmXilOy/cDDF2karOhqBuOQRKr9YVcM+k+0TK9SvfEPZ6FoNQ3GouNEixSenTGctj2n4hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319879; c=relaxed/simple;
	bh=W207oYYQGYsgiPf2HcZY3KWoo3DaWR9lf1oFK1YrkUE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IF4AiHUnipDDkhZG8RtGg6vK1VDoedqgcdHYkeJgFSoLkP6LM3i8Xwpdj71pJVxTDw39ckuhe1BfK2119FwfU/R4d4tnLcWDFeUjB7KPLA3cMkVVvlUewlPdsf5hrJ1+z3Q6/68kiv3TT8VS5rOxat3dygy0+d6wMGJiyWVtweI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2OcreHs7; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2OcreHs7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fj9UskWcQ59OEDjve+0JlemXbfDahTv5c8OVmriYQc4UJ8siejczis5KwRFpmPtMjayigJ3LV2zbpPR3eaNVaE/qq3aHejFqoDGDnOtykZIBh4z+CpdTuhTFciUFGybpXKE+MxP1zl/KazUFat66RFsCLg1cRK4afgI1a7KHKQJXCe6KS6OCmWuLLade5hlyviM3XamMitZ60G4uSp6h1xZ6XUn4xChetudM8rcXRDvb8AlPEEYs8QrRN+N1t/3AFtzXuRWec5z5f1JGdIsN4L37QDsUdp15v3hAWBJzVaRNSax5OAfhssSQda+SBILRYX3w3aUiNNLgzeYEImidwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjj0daiLOiJ98+JQaRpr4ujSHLAfJizYrh15OVvxXy4=;
 b=H69KBsPMsXYalDChdEVrCj0j/sUWjzuglJmTxnZnAdic7gulyu1Bkpfsd4FGkbqaZnjAIP2yo/7vtGG5MYsjeQ8E/LdTFv1sc4OgZwLDDDKtsC1fd5uNEGYNN/RgaAhw4k2QeLyVhYRnT84MrncntDC9gCbb4jgaRq6m7GcJ13ZIv/sArTInoUmQorX/jPs9WoK4KpXz5BDaWNI6hOqzJ8y9Av/c4WUGLNuaTDf8qlmasvJkKjFwu8V01pvwQsNgkguCffgZpguegp8L4DVHnbpyNe0oNJAYOwJxhlJXlPJKvDVtVsXmgw1MDhAA91LvDINwOUaIIBj0v0QZUxoQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjj0daiLOiJ98+JQaRpr4ujSHLAfJizYrh15OVvxXy4=;
 b=2OcreHs7BPAtNaOQIDnDkZpVSeKNdpvS+k83rFcMOC+/uTaRhGxzjLj0HnyoA9H7UJGF+uM9XZdy8GMrxUHw5d+UzIbLQptsLJk9kSlQ78dpUe4gd4pv8CoNTf/Oy3FoQzcwC5mW/aCGhdPdl0HhKPdubyr5nMD9p6EHGI0kSbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 06:11:15 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 06:11:14 +0000
Message-ID: <b69304e8-d43c-940c-9ee0-d2345ef7b99d@amd.com>
Date: Tue, 30 Jul 2024 07:10:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] cxl: Preparation of type2 accelerators support
Content-Language: en-US
To: Huang Ying <ying.huang@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20240729084611.502889-1-ying.huang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240729084611.502889-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f9ea12-bee9-4ccc-5ccd-08dcb05e6aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDdiOUVQT0p1eGZRQXpLZFlsSXFnWlN4MURyTm9FVTYwZkdDQ0RKK2lYRm9K?=
 =?utf-8?B?VWxMS3lJVTNlN0RlYjdiUVpGK0hDZlhpZFpOa3NYN1B2Zm56dHd2Sy9lOHpC?=
 =?utf-8?B?RFpwaUNrRHF4NzZ1cyt1Q2owQSt5ZThLbG0zQkRyczFzMnZlRDhodzBNbWRp?=
 =?utf-8?B?aGErcWdReEtvK0dIM3JKWkZBaUIwdDVQQVVLbkxYS2c1WTJrOTZyclBwaXNt?=
 =?utf-8?B?Z09ZS2h5MitsYWt5VWZUY3EzYmJsT1FadHNBd1E4cnlHUG1jdEpvbmcyL3FI?=
 =?utf-8?B?cTBJVTlQczJLU05TTmJaWHFabzBLelpETllSeGJUc3ZJcDYwZlp1cHdFL3ZD?=
 =?utf-8?B?cXB2RUNrZ0xMTjJHb2tMS0RpTlZsM2VDMFp3alFEc2o2YXl2ajEyMkRoOWhS?=
 =?utf-8?B?ODVWd1dUbndEbDNZajE1YzVDUDZUZXhQR2RqL3F2V2xrdEE1akw0bjJtTW9P?=
 =?utf-8?B?Zk9pZHdTVzFCbnFMYjVJbm9Hd3dCWFNMWTg3Q1FkKzRkZjdWa0lEbHJBKzZU?=
 =?utf-8?B?V3FvVWtJMnNKcnYrMlRpVFU1eDNIUU1QeVpvNUFHRXhzeldoUExwZlpkY20z?=
 =?utf-8?B?UUdVNVpvYituOUVoTFdoSnVZVW5FeHZNc21RSExiN0dFQUphRlBCbXlxblYx?=
 =?utf-8?B?aHpmMkFscjZobEpKUEEzSGN6VzBXZUVwOFAxbTlrT0VNYXBWeTdSTXBSdU5Z?=
 =?utf-8?B?Q2ZJRFFiM2Nabzg5VEo0UUdIaytPdWxKR096WUIwTzRZOU9SU0RjcytuV1o1?=
 =?utf-8?B?TFBXWkRZT0RPemlhYmF4TDVJdU9UbWhaK2pXRlgxOTdWZi9xTmhxZCt0M05y?=
 =?utf-8?B?enEyS2ZIZ2h1dWZ2WUo3TjJqcVcrS2lISURrczdZZ2xGbnlScUZCT3VJNVRj?=
 =?utf-8?B?Vk9lUCtDb3M1S1B3Kys5ZTZiek5PRlVOdjVnU3hxSkRvRndyQTAra296bjht?=
 =?utf-8?B?TEVoWHl4WWlOM3hGZlVON2hiSVVzODcrYXA1bDFsNEFycFFRZTBsaUk0dnAz?=
 =?utf-8?B?RzBRR0o4K1BhTkJoQ2svSC9QQ3pCbDlRb1cwc0VybWRKV3BNZ2daVE1FUGtH?=
 =?utf-8?B?YXhJck9WTm03THhzcm90V0xhOXo5dlVuU0hrVmFUNVMvZFZsYStxVGR1c0g3?=
 =?utf-8?B?UmxxUjBKNlcyalZuY01kS3BOOUtJT2lsT3ZRYmwwMjErcThMS05heHQzUU92?=
 =?utf-8?B?ZVM2ME96VXVaQ3o2dzhYaTI5OWkwam1haW90NzVUZjNNTHBRUEhvWGp2anF3?=
 =?utf-8?B?ckVYREdMRXNGa3JXalpLNVBtY1IxMHYrNXZNeFdSMklpTkIyNXNVdkZDSEZu?=
 =?utf-8?B?RjBva0FEeDBMN25HOUdRV3pza1VFVFM3YkZ2TWtkeDc4eCtXT1ZOZWNDS1NQ?=
 =?utf-8?B?MmIyOEVjWGk2cHpjcDM2a0Nla2pCa0o1K1p2dlVtNG01eWJWRVYwY0dnK1NL?=
 =?utf-8?B?b2tsMm1jNWFtcVA4YVJWa3NTRkVSNXRNUURyK29oay9lQ2VnbExhaktGNzE0?=
 =?utf-8?B?VlBHeXFmdk44K1R4QVkxSUEyUi8zNVJaM3VaMzJpNVprY2ZLeGJIeDFIWThw?=
 =?utf-8?B?M2ZxRkROd2J6S3hMbHg1UTBOU3UyTzlwcGlLQXBoby81QXNwclBDSmZvbzhn?=
 =?utf-8?B?ZDRPb2NzdldLTVVHYUhkVWJTT1dTekYwOVNCaFkzSTI4MFRkcGZBaTZHL1lM?=
 =?utf-8?B?YlpveXNKd09iQXFFT3BGckcrT3dGTVpLZDU1dEpFbTNpeWZ5bFNydG5SOGZx?=
 =?utf-8?Q?7fiTxTfRkYrtK4BsGjKJ8I62K6Yn6ZbtBiscp2f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmxqNGpDNjFTSFAxOS9YT1BmdnZOTzdOZUVYOXdlZVg1M3NRN3JJUUN4cklz?=
 =?utf-8?B?Q3VycXBPc09KRXJFSEpGTWViZzhiUnVJZzVQTW9peXYxOVRsNTg1RUptWWNU?=
 =?utf-8?B?dEduZlV2dmR4U3hkazlGSUJsY0RJZzAvNlY5WDQ4aTF2cmZ5L2ZEZlcxMEEz?=
 =?utf-8?B?VDNBSTM3eVJvYzN0YTlSaEhUQU1VaTdTa01kNlliNk1VZEZLZk9nVUZhRGRn?=
 =?utf-8?B?VjE0b1JKL2k5ODgyNk9rNGdoeHNtU01nQzU2TGdyTGJnUnhxTU9OU1RNYm01?=
 =?utf-8?B?UmQ1Z3p1TzRQRU5ndmhpVU5Jd0VtaFRHYk5KUy9uWUdOOWQvN2N5QU9PRDBO?=
 =?utf-8?B?NVRDQkdSVzU2RERqRDJvUkVDVG1ka2JQa2VLdVNsSjUzR04wZnZ0QkpNa0k1?=
 =?utf-8?B?YURjQzI1MTJocGExbTRoeWZQbllQdFJPeFBNWW1iUk1Ud3NSeDBxd1lNU2g1?=
 =?utf-8?B?cHJDd1puaTZEYXBjcU9jSmtEbm10STlpSVZlUEEvUHRnSUFqZ1lPb3FmNnFK?=
 =?utf-8?B?THEreEVpaEx1WlFXTFAxejhqdFIrYVZtb1YyMWtEcU1Fc0o0QXRFQnFwVEZp?=
 =?utf-8?B?c0ZhRHBJandmN3QyYjFpTU9vQnA0TFhrMmdKU3lETXZ0MjFFRU50bjBtVXBz?=
 =?utf-8?B?R0RHeERlS3YyQ0s0YlNSczNKT01McUhDTksrMFlhd0x5NGR3K1pDY2VNbjhO?=
 =?utf-8?B?amhQZW9McG5tVXF1MGRjY0xicDJZSkU5Y3AydUlIaHJPOHpEYkJta2tOSm5M?=
 =?utf-8?B?UXpLT25SdmZGd003bU5xcXFoaEIwNDd3d3RDRjlzQ29ack16Y1FxWmhzMWZW?=
 =?utf-8?B?ODVxWVF5UmgxTVRoVWlPSkNPdmRKbkJzNTFYUHhWUjNnK1pYVmhucDZwVHhi?=
 =?utf-8?B?NlpYUVBrdnA4bXFWSFRGbXgybFVZK084Qm0wdFdFd01Rd28rSWlEZFBZcnNW?=
 =?utf-8?B?aHNuOU1IZ0VJNW9XdU9lVGZvOWJER1VxejArRkN3MlZlam90WWlGdUM2S3Q1?=
 =?utf-8?B?NHZoVXFzeGowZ0lBOUk3T0F3SGZQSEo2Y0xnL0g5VS9ucm9EQ0VVMkNJeElk?=
 =?utf-8?B?OCtaVGl2TnhsdHJmbllVOUExWWdmWG85SUFOYTR4bm9tZVkrUDVIZEEyRWw0?=
 =?utf-8?B?K3JzMlpCa3lMblEyQnZQWUlyeERhZHZ6VEMrREV3S2ppZkl1TEU0OVpwYWxI?=
 =?utf-8?B?Z2lpSm50d3l2ZmxhYVNKdUVWWjBLcC9Rby9EdGxaMjJqdlIvbFBNd2hjeWNx?=
 =?utf-8?B?OGFobFZtT3pYR0FFeFoybnZxUFprK2NweWorTXYwRVFtaTE4Y0dCY0F2MjdV?=
 =?utf-8?B?SHRJcFpQL0pNYWhMc1hOSTlQVko0YzZNam42cDV2ZERDd2pFOEQ0bTJRcysw?=
 =?utf-8?B?RGNONEJmT3lFdjBjSU96OUZ3S0NEUXd3WjhZTFpGSG10dk5mOGcxVWFuN1N1?=
 =?utf-8?B?Q0pobjdKRlNNYnA4S2RscVVIL1liRGlBU05DbGxPdXBGcE9ZL1FHdzMzSUZq?=
 =?utf-8?B?aWh3VWxnc0FrZFFiQWljc3VIQ2RhdDN2WXBpd2oyQ3VUZC9YeWNHK2pubXp6?=
 =?utf-8?B?RmM5eVRTQjdzQkZCWTFjd2ZXVTBIRVpzSWFRa0tvVC92Mi9OT0NBWU1SZ3hD?=
 =?utf-8?B?RENIVTNOR3BLSGU5Y3BYRVZpMy9MQ0liSVA2S2hza0wvRjY0SS8zQ3lWTUpL?=
 =?utf-8?B?dEVrRWVvOWxqbUZ0akszVEN5WVJrOWI3Y3REVS9vQ24rNzJlS2dFL2ROaHMr?=
 =?utf-8?B?NzJqM2ZwK1NJbFliVjdSeC9jQnN2Nk1rcHBTaUgyQmtPMHNFU0hBc0pscmhE?=
 =?utf-8?B?aWpGNkU3d2F1T2FhMWcydGpnOGRGTWNCbk9yeVBieVN6TUxEbUxoQXdnVzV4?=
 =?utf-8?B?cDM3OWlLNkxsdUVNV0tqZzdja2ZOSm1jam1hR3hkaW5rakZ1a0JCWU4vSzRX?=
 =?utf-8?B?ekF1RmN4NXo3Mm03WC9tMnFWdDUyRGhlbjFod3h2VUlGanljNG5jdk84M0N3?=
 =?utf-8?B?U3M1ajY0QzRkWWZsbVpjS0ZjSVVjMy81Z0VjcVM5OC9LaXhLUzBlZ0k0Zy82?=
 =?utf-8?B?TnRiUEtSNDF1Y1c0Q0VxN1hBd0RCbTFFd01vK0xrQWxnMGFxSUdwWitWRUNT?=
 =?utf-8?Q?pvWOusAXl85c2H+OhECSkxLPe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f9ea12-bee9-4ccc-5ccd-08dcb05e6aa7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:11:14.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OtQJjH45Mz0L0D3HeeRWfobpOn0TU3W+ukWR6xH2KH7gjkWO8qpFXkWnOedsoiVNIQVJMPYIPtD3i8+t5b8KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

Hi,


I'm a bit "surprised" by this patchset. As you rightly say in this cover 
letter, there is a patchset under review, and I have not seen you 
commenting there on the concerns stated in this cover letter.


I would say that is the first thing you should do, at least, to comment 
there, suggest to do other way, pointing to other needed changes, and if 
things do not go well for reaching an agreement, then a patchset like 
this could make sense exposing another way.


Anyway, I think a CXL maintainer should say something about it, but 
after 24hours, I had to say something.


About testing these changes, I wonder how did you proceed. If you have 
used an emulated Type2 device, as I did with the first patchset version, 
you should trigger some of the problems I found, what makes any Type2 
initialization for getting a memdev and finally a cxl region to fail. In 
other words, testing these changes can not be a partly initialised Type2 
but a complete one. This does not mean a patch fixing a known and 
obvious issue for supporting Type2 should not be approved if not tested, 
since the Type2 support is not yet there, but mentioning testing makes 
things confusing, at least for me.


On 7/29/24 09:46, Huang Ying wrote:
> There have been 2 series to add type 2 accelerators support in [1] and [2].
>
> [1] https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
> [2] https://lore.kernel.org/linux-cxl/20240516081202.27023-1-alucerop@amd.com/
>
> Both provide relative complete support, but both are long too.  To
> make it easier to review, some preparation of type2 accelerators
> support is implemented in this series.  More complete support can be
> implemented based on it.
>
> This series has been tested with cxl_test via mocking a type2
> accelerator as in [1] above.  Because more type2 accelerators support
> than that provided by this series is needed to simulate the device,
> the cxl_test patch isn't included in the series.
>
> Huang Ying (3):
>    cxl: Set target type of root decoder based on CFMWS restrictions
>    cxl: Set target type of region with that of root decoder
>    cxl: Avoid to create dax regions for type2 accelerators
>
>   drivers/cxl/acpi.c        |  5 ++++-
>   drivers/cxl/core/region.c | 11 ++++++++++-
>   2 files changed, 14 insertions(+), 2 deletions(-)
>
> Best Regards,
> Huang, Ying
