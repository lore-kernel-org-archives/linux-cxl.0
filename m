Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB5179BC;
	Wed, 29 Jan 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141695; cv=fail; b=OJGRU+8IAe8EtdwUYIqDUgHE7pqRZbuBiTGjQN8ZEUoecONToKJ4KiuNasuLCobzjf+wTsT26smFdsW4AaWtKLilTMiXwD1DinXnmcq7xBz7lnvxdQpat6e/KmIPpQY+AoN44xVaitsnqKvCFEjHgVVpYLiVVr4VgCOF07ufCFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141695; c=relaxed/simple;
	bh=07Dso12fTIXv6U6fFLo24/6QF4EDE05qOiOJVJyY9q8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eSVvReJ6BOeyCwT5FEshWY/f9yHMZ6PSRIccqgN9CL43SGr+5Ugdg78KUFmynW/Xb2hCLfZt0FNPxcTHsuVe4loGixo+L4zi+0ku5uO+TXG5o7eNMxwHdOH5bqInwXLDOspoEK5aG/aBPoWnRk5HFcEd2ZRXgVDBzLPXGsR1PQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ikc3Fgab; arc=fail smtp.client-ip=40.107.96.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ikc3Fgab"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llxtCJfXVpGLg/Z2O8OyvSFY/1GSvXqMIp+j9d/2IOs1vD0jbMUelED5AUT4FYsMwtztNiNE+hZL95qdalaw/vlLIDNadXlQwF1RoAtEhmmvW0MuqQp5yKnEOvkQFeMzB5eO/duukNq2/2dtIcnAuLlw08yImmU2RRpMm6snvVTUXFE8d48EkyDal0ytYFcjvkRWj4fKs508pokzqux2jtMU/OX+fLUpvXjPEYuBd5gZQaRW3RLJnMHU7WXGaY72AEIvF/w8zQ9/p6LbUYz4zG9kPHhRAFp5VTq3dBP4L3s9GfF2ohfoEqDAXQucKbMGYSiILn2mZSqlOs3HSrIGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RWGbH/iN52+DPEcetq+rRh943N9oUId/qlIVq4WHYs=;
 b=vYN61w8HnqociITJSnpWz+j6Vj8PaVbzfaIueRB8T1Tzo8jZtv89kiI4C2SnpNsny2/zkJRX9zp74SfZ2V04Kj2jJn+2B0kHsGXSPMHTB3hCgI9/mufa+ukOecvY5aqvDFaZ4J0n7jJkF6rxo3kET0qmN79wTWr0lKkz6srdUrqPaCU785y8A2xXcydM+/YoAAhfJsVqxal+/Xk9Bq7Tl7AWCfpmbxxKOekIJyCDDEkIXDApB5DBYwkKHJ6o6ReVnCntqg6dvWPX3E0JC+MeiOtUVJaOVtos5rMJstQq8+9gRoWKmMnyZmJ4bYWDAP32NEFXqiGgu6zpsueOaUYqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RWGbH/iN52+DPEcetq+rRh943N9oUId/qlIVq4WHYs=;
 b=Ikc3FgabHa4TlFrpjCqatsILlLFo/Z2j6egfvK5W6KpKEsvzP43Rk/IJgwDPuWjkJ978FheohVcQHMOmbHdZsk0PH7JF+U3qe3ApGD+SUhJLGn3aJ3tNVqkk0Ba9eelW71JMZ4SeFKD5qnWFj/rBi/BVbnA9c6PYV2TsV6Vx/PQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 09:08:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 09:08:12 +0000
Message-ID: <783abee1-e06d-45bf-2dc9-920c729978de@amd.com>
Date: Wed, 29 Jan 2025 09:08:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP265CA0527.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:18c::21) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: cec06366-cab1-4ab8-6c9b-08dd404474da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2Vpelh6ZjVBRTUvcEpGZnQ1QVdxVk5lc2VnWUhmWUU4d29jejl3Tm5WRGZF?=
 =?utf-8?B?RHBqbDZpdVV4c3RlWnRnQmZVVDF0cml5ZkRRZUErblhKSHIzSHZmeitTbUh2?=
 =?utf-8?B?eDR5dEV1cmp0RUp1N1pLcWswaERyWC9UcnQxNGg1Z1NteEljQ0ZZTkErMFh1?=
 =?utf-8?B?UGd0dDVNb3NOc3FhWmtYa200ZUZJNHRSZFFUYnM0bEQ3NStzcHViVWkxaFB3?=
 =?utf-8?B?ODB5dXp4Z2t3Qm1odEFsRHRQbUxFaXk3eGF5K3poYzlnNWZrNXpIbHJpenFi?=
 =?utf-8?B?cUFwNlN0QlVneVJwREpacFlJOXdpY3RSSTlsbFJRT1B5cXNpeTRMVkY5YTRr?=
 =?utf-8?B?TDZsS3VLZlJ3dG4yQkhHK1VqRnB2RXRyaXVpSUN4dEw1aVd1M2UvcDRUK2NR?=
 =?utf-8?B?aVBXelVkUkRvRTdUUjM3SmFjRmRWd2pYT0p1bzM0aUQrMXFBYXc3OWNnMlV4?=
 =?utf-8?B?dXB6QVFWZkExS21hdzRNVWZQdU1jSmtDMFR0eWhKZEtGcmUyTThpOXBSMnEx?=
 =?utf-8?B?a3M4MmlZYU1oWU5tQms4cWlTRmUwRHM0UlpjNEZMSXp3aWZldU5pNGpZTHZK?=
 =?utf-8?B?bk1DTXc2YUg1ZHAwZkhvQlpTRGFyVk45U1JlVHo4ZWZlUmhuZkwyUFBaVTV2?=
 =?utf-8?B?TDMwS1JPQkoxNnp4TjB5QkszK2ZvWUZvNzVJcXgrVkVYczRXT1g4T0NIeUtH?=
 =?utf-8?B?b0M1MC9oV1JFYWxveFBZazl1eHJZeWNNblBqaTFjb24yVjZEYUpCa2RMeVRP?=
 =?utf-8?B?MEliVnVaR1RqODlzRldIcWhsKzd6NVl5dG51NXVGTFp2T0kraHV3WTNHWHRl?=
 =?utf-8?B?cDdyTGFFeE43NElpeUZXNmJYUkpQS0VLMnZxdXhBMXFKNEhTQmdjY0VyblBP?=
 =?utf-8?B?L29GejI0TTRtRnlNTlcvRGUxMmFsQ0Rmd3VEUE9UcnMrMWovME1NVGVvZnBq?=
 =?utf-8?B?WGdYeHdKL0d1TkYyRHBWL3g5TEJZSTdLRWZPRzExYzM3NkhQUnpmY2lPRTVy?=
 =?utf-8?B?UWEwV29ieXRpaTBBK2t1MzNCUkFaTXR3bklTS0dNZkx4eEdiWGRlVVUyNUNl?=
 =?utf-8?B?cTJRWkpmYnFuTGlTM2M5VUlzRGkvWTdBUldVWDhHWjYycGh5NzA3OFMyUzdq?=
 =?utf-8?B?R0xtVE5JTlVsK3ZtVkpKdDd2SU90cXk4K3hxRXhNcyt5RHZSNUZkakYxdGNp?=
 =?utf-8?B?N2kzS1JmYWo2cVNmN3V5S1V2d1pVRlY4c2tvbWVYNEN2WnFhUnRwbWJXcnh3?=
 =?utf-8?B?SUJoTWdtVElMdFNzS2dnRkxFb3NaV3M3MUtSN0tQbDQ0NlVyblNab3ZwV2hy?=
 =?utf-8?B?TFNLdnprT1JyTUhqbGlQOXA5R0JYcU50SXNhZHlyaER6cEphSHpwUFk2S0Yy?=
 =?utf-8?B?Qm9Hd3JzSjhqSTFLaVMzbkxkSVA1aGp4QTI4YW5uQWZJdTRYMWJIWGo5NXh6?=
 =?utf-8?B?WHRmbUVxNmx5dDQwRGMzMkR0MzZBZEhocEFqc2NhSmY2NFVLTWhic0JKRGNX?=
 =?utf-8?B?VjFpT2lBd1cxWnNhWDZYYW1CUzZQeC91amxuOVUrblhiNDBMWS8yQUhHY1JX?=
 =?utf-8?B?bzdpVVlHS210SjNvL1B5NXE2b1crTk5jMFoyVGUzdU96NVF3REhsUUMvRGhP?=
 =?utf-8?B?blBPNXEyZ2Q3cU16eWV5VmwwenJmZmlZWUUyaDROYklsVHoraDFiYUZvWlht?=
 =?utf-8?B?eW5IZXhlRGhGM2Y1OHg5eVl5TzJ4VVlzenhBSzJnTzVPdUNHcS9vNnl2M3NY?=
 =?utf-8?B?WWE4Mk45WjhpOU16Tk02S3dSa0ZodnZJd1M4K3N0a0JPZE9BSkhUUjlqbHVv?=
 =?utf-8?B?WVAxenQrRzVlSGZuazhLUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzJjZERURGphck9MUnBKUUFwTDRrRld6UHpnbkp3QnZ2TnJ0YS8xUkxGQTVE?=
 =?utf-8?B?ODhaUW9EQ0p6WGl1Q1ZPYlU2MldpVGg5RFJwZmpkTFZvRTRqalZFcVVUMGdY?=
 =?utf-8?B?N1Z4MXBac3hBWDBXc1U5bXdHd0Z0Q2Rla1YyYXhhZld4NDI1bldSR2UzZ2x3?=
 =?utf-8?B?K29sc2UySFUwOUlPZzBDUlp6cUpaZy9tem54U25JaGFFM0tSRlcrQ1pKSHNF?=
 =?utf-8?B?ZnhCUGF5YStpdVo5cTd1Yi9yVzdYbS8wTUhtby8rWWtrOE8xMENyS042MVZu?=
 =?utf-8?B?dkwxUDlReU9HOGxoSjg3V1lMMTFiSUtMOVk0aGs4YmpiUDVvODdTNGFoU2hL?=
 =?utf-8?B?UndEYk4raHgwcW11d2E4aUMrMkxyM09HRWZBRnUwMW5sM2IvZ2RSYVF4MCs1?=
 =?utf-8?B?STY4NU9KM0VmUlVsL2FnMnJDMDFxdUNDV3RHMG9zcnc3anFudStFeFNTUExw?=
 =?utf-8?B?eXFjUy9zWHNOYkorRWtHRFNIaTVFYmlUR2tiMERaVzdnTUZ4RDM0MU54ZFY3?=
 =?utf-8?B?ZUh1d1pWZFZOOHljc1o0UlVucGI0VGNSVDBpTHl3MURJU2VWaXoxaEI2emFt?=
 =?utf-8?B?cEZwcEljN25yM2RtZDBQQWpkK0xFTkhWTG82am9haVJ3WTNTVG4vR05oeXVV?=
 =?utf-8?B?TDMrZ1RzL0xZTXpFUE9qc3RGT09BK3d2Q2pVMEx3bnlTOCtjOWkrcW5RNkZh?=
 =?utf-8?B?eDJvcGtWR3J4dWJEeUlMVXpWQzlkUGplNmZXYUZrbm5zK1lRdlRpUkczT3RR?=
 =?utf-8?B?enAvRkRCaEVyWmVOazY0U1YrS2FEM3NtWS82b0x4WUd6Y0J6N2xiSXNtSlNX?=
 =?utf-8?B?WTBjdHdqTks2dUNLRVh6TnpoMFRnWThLRFJSdVp5NGtYQjhnWDdFR1ZLUHVw?=
 =?utf-8?B?NHczRkhFcktYcjRIT090WUppWWFjRnJFSTZnQzV5RVJ5QUVZVmtETUk2TGpJ?=
 =?utf-8?B?MHpyQ2NSZzVCbWZES1p1cTdWTnMyZjhMcXdnelp6ejYrMnVBdlpYekYzaEhO?=
 =?utf-8?B?MldLa21SMEhSeFFKM1F2NzBCREhzY0dUcFJsQ3dCZ2xrY3hndVRyV2VIMTFp?=
 =?utf-8?B?Y01Id3dhZm9VdHpTWVN6a2RnNGtLbEVyeGxLUFRXZGtaWnhmMy9NbmszMEZh?=
 =?utf-8?B?RU5TaGRicmVzZldPTk9ReGF0WWtJYXJiSCtHZU15MGh3TkxPK3BHZG5vUlp3?=
 =?utf-8?B?ZitrSmFpMVpwUlg2YlNZNDlFd0EwcmxjZVFyazZ4cnhZMk9pb0hlYmdPeEdH?=
 =?utf-8?B?SlRFQVRaT1dqQllLOXp4RkQ4VEYwbEs0NGFXUU1INHFCSUUzMndpbUU4V25u?=
 =?utf-8?B?KysvelFKcG1hUmorcFRJWFZxdmRna21CNy9CSVV1VG5ramdOQ2NmSWxMQ0dW?=
 =?utf-8?B?TzZzZ2t2T0FZOTBlZWdOUWt4dVY4dStQTEFOV21uL0VLYjk0K0dHQ1l4b1RX?=
 =?utf-8?B?QjNCYVRoT2cvVnVPUXoydGsxLy92dEF3V0lreWFWZTloNVVxZ3pUcTB4Z0Ux?=
 =?utf-8?B?bUI5Nm9MSGdMdllidzIyeE9nbG1sZkxDQnRCYVpzVEo1RWlkTkZhNWVoWHNL?=
 =?utf-8?B?S05mSS9xTkgza0JaSWN2Uyszb2lDTUE1Z0pscGNoTFYySEpzWXkvT2swVi9p?=
 =?utf-8?B?Z0VBMUg4b094VzZLK05LV2hwUGFqbXhIcmxZNmxMbUtlNE1kL2RXc1I5MHV5?=
 =?utf-8?B?ZXk5TWFucDJ2UUovODA4aUhrdExNbUZXcktSVTNSZ0JRUnRoTzFSUUt6RnlG?=
 =?utf-8?B?OWlleFJKTVh0SWVKVGRNYkJUc3lyYnc3R0NIc1l5cHhxUDJwb05QN0Q4T3h3?=
 =?utf-8?B?V2pjNzdQc1VaektYaytpZ2MwMFlsc21VcUpXUlVJOFBxSzllWWo0d2tLSjZy?=
 =?utf-8?B?UnFSaGNObjNYcW0rL0ovR3lkckh5NmM4S0wyVU1lMWptdmdFU0pscW1scS8x?=
 =?utf-8?B?NWJzNnVNM2MxTjJOUytMa1lPQ0RyRkV4RE9uMUVsZ3VMVDFQMDFDWExjRGlz?=
 =?utf-8?B?ZmxLbXZuUVA2eHpIbURUWnl1cmJlMWJYUk5jaXRsQUFna0pIOVVWYWRsR0ts?=
 =?utf-8?B?WW9qQStuWHk1Y0dwRXAzLzNyMVY0Q3dmRlFBK1pTeWJTSi9NR0NpUlBGblhS?=
 =?utf-8?Q?7unLHK2ybkoXAK3D/BocarTxb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec06366-cab1-4ab8-6c9b-08dd404474da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 09:08:12.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg7HBgSjFoX3YgwSdx4LwmjlF8ER6QwMukbl0Z8xC5T7/9Jb3nOJQ2X39X7jEltSaaxTAM5+ux5FWt6TVL9syA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167


On 1/28/25 18:51, Ira Weiny wrote:
> As was mentioned by Dan[1] cxl_memdev_state stores values which are only
> used during device probe.  This clutters the data structure and is a
> hindrance on code maintenance.  Those values are best handled with
> temporary variables.
>
> Adjust the query of memory devices to read byte sizes in one call which
> takes partition information into account.  Use the values to create
> partitions for device state initialization.  Take care to separate the
> mailbox queries from the initialization of device state to steer the
> mbox code toward taking mailbox objects rather than memdev states.
> Update spec references while changing these calls.
>
> Link: https://lore.kernel.org/all/67871f05cd767_20f32947f@dwillia2-xfh.jf.intel.com.notmuch/ [1]
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


FWIW, I had (as part of current in-progress v10) similar struct than 
used here for Type2 initialization when there is no mailbox.


I had added a specific function for initialising that struct, but my 
idea now with this change is to have cxl_mem_dev_info initialized by the 
driver before calling cxl_dev_state_identify, and inside that function 
checking if total_bytes already != 0 for avoiding call the mbox command 
for getting the info. This will support both cases for Type2, with and 
without mailbox.


