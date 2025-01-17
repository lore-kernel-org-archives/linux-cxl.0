Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C924198A17
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128587; cv=fail; b=bjqjqEQAYwqNFpVoHtLUut2d5Poe0GGO6ETeQn95uYt62QQovmE7goss7UjSiTPgS09/3Q5UpfR2FwD54rMjLREMcPcvAX48qcENclZgaVjJIRN7zHBz2myKPIJ7deDKXS1pyeBP7uuclCsfMicKRQPb3c7SGBfCea4ZSeNcubs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128587; c=relaxed/simple;
	bh=vHO6C/VVH+B9Z1BJwHeOWkgIcya0cvkCo2VOIdtAUg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G1iPhMsoM0VyIi7HIhnMIW9/mfrj4mVOojK1Hr/Tq04fGajinBkOch6hBcOx3KXPU3GQ/Gtrp9AI8hLUCIp93jZhiJLMrdhUBKilUfdsBBfg3VaCbC0kGShQOhj5QalN6JlLaagPGbh5CGKVUARqA/VepZT9H2jW3EaZM1vgkYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y4C77I9E; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y4C77I9E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yci4NAaB8jlCMs0N3ssSoQXj9LR5FGfRglh61OSrXr7dQw6YF2Kb5lvaLz5bHYQ4eZua2m+4O+vLSh3jPip4uRSBClkalrn7jAW0ZgCEFDXgR7i6WRTBlwpIaUOuHiThBlCYV5QX9UnbykNDPx4JiT4NCKTbau/C0SK3NXMe3j0+lN7E5aavO+BoOUMc8WuBRqCOFMVNp5H7Ix6Ep+aX7JhglF8a+/3FCBxggYrqsIGZ2Zl3G+Hkxz1rR6fTA7C+LzWXu2OC5x9wv32u+jkX8s/fNQuaanZG1iqLZy9j81uYqLLW/sssYip60eFabkDNwcaAdxabh1UWBRgbejtp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulxbOrjTfJG8+Jl5Ed7bWdOwfiQIzKNhjQbjrKuuL2k=;
 b=gbdNM5xssEvgrunHz3eYNGBxnD8AYvMlAF22divWscrDuJ9AVGuKWvknQn3a/HQ63M9Zky9oJX10yAy+Ib9AIzdu9arf4foWhXCLzW5hfoLdKHsYS8JZzDl0FNY9OdlH7/0AGZ6YheXw9ect+fgfgVdB5bFNZWJ463IG1v2b11WBXpjWdc583wzOu+05C/gImZ9qBtVW/UHVuLeFBEj2WEs7E/nOffM5LIBPJlc4LxAy7Y/ZWA17pXTv5DEPENMF02TwjnvKaAWoTwXuAy3ds4bQoyONtNvxWH6mHYzK2zsTZYyt23opMwIZNRuY8WzGs09+ASuOXwx9qtranmYeOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulxbOrjTfJG8+Jl5Ed7bWdOwfiQIzKNhjQbjrKuuL2k=;
 b=y4C77I9EI7f/nyHJuKXXOf/dlOd8ajJ60r7QxVKORY7F54zqvaKzxuQHD7aQwFjKfim/ZqW/HJXAvKdDL3X/eNHpYgbTTxcJKtklrlem1jinLALT0GJzsRpHLG8mRbcYZhSPa1FAMa/89GuZ2KoDNTnwpDyGiaQsjoNloRl0oEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 15:43:03 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 15:43:03 +0000
Message-ID: <53ef6364-4523-05bc-4fa1-8a2110f5fe54@amd.com>
Date: Fri, 17 Jan 2025 15:42:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709425022.753996.16667967718406367188.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173709425022.753996.16667967718406367188.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::44) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 8412c896-a390-4c68-d1b0-08dd370da0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE9oWHVXYktwb2c3TXpNSVRvOExoYTVIL0pwbExiUzBHTUlkdDVmbXpuVk55?=
 =?utf-8?B?U2ExR2N4bGhEQklaQ29tTlpGeWd5V2lnUk5qZGVXK0FWY1lWblRMd2hHaWI4?=
 =?utf-8?B?RTQwaEpIeHhFaFhNTEUrdm44TlpnS1k1U1ZSay9VdFFVYWd4NjNBRkZyU1dv?=
 =?utf-8?B?ODVEeVBjLytuR255b29KQ2Rlb2xsTEoxY0R3VUI1RFp0QkgzR2ZpaU5ZWmJt?=
 =?utf-8?B?Q1BXdjhwWW5lakxlSjJtTFNCV3JvNi9DOVpaa2x4cElqdTRhdEZlbjFzNGNy?=
 =?utf-8?B?K0RUaFI4Q3d5TmhyUTZTbmZMcTM1RFdLdXdkclhGZkR0dXY4eFk4a1FuT1lu?=
 =?utf-8?B?bkN1b1pqdW45U1VBcHRYdzA4eERaSm45Q3VHV3J2cGlmSDFLbU41ZWxiTmVT?=
 =?utf-8?B?ZTk1WDBDMXR0ZVF6UE0rK05ENGtObHBaSzdnaDNWS2RONWFTLzRqM2RBR2Fy?=
 =?utf-8?B?TWVjWGdDVXFkdTAxNThuQjFJRm5aSVFIai9CTU1tR1hjZDRWTmNRa0F2czJi?=
 =?utf-8?B?N3JCditXMUp4VDRrSVRCRll2SVdRRlkzUnZFNEpBL0Vud1NrUENJeitqSysv?=
 =?utf-8?B?N0daQU5kME9NaW5NUUhxclZITDBVaXhqb1RGaTMwNmY4S0ZhZUtabElhZ3hI?=
 =?utf-8?B?T0IrV3R0dHNVc3doTmRHd3pSUk9CM1RuUGU0aWlzcVFnczUvdTY2WFhOZmVR?=
 =?utf-8?B?N1ZxZHRmb0FlVkRBWFhzMGJoUTBsZFR6UGE4bDN6ZFh5enAyWHAwWU0yMjRj?=
 =?utf-8?B?VFlBUzdib0QxeUQ3MXJyTFFzY0Jib1lwa0hBNlQxRS9qTWhTUWxlTFg5MjZH?=
 =?utf-8?B?cytaUXJ0V1pWbEV5V1pvUTNDOVh1Y3hJa3oxUms4cmdLL2V2d3krSUNZaXNv?=
 =?utf-8?B?VXhJOWNOTEJvVHczWVJzclBTRVhRSTdPWDAzY2tTVmJqREhVa09XZmxobEJr?=
 =?utf-8?B?bTE0K0o1UHhCc3FMLzVEbDVhTFJIWVRpTlFHOGtpalZZZjNYZER6RXpPV2JU?=
 =?utf-8?B?ZVlvMmFNQVpqSkNmdE11N0pGaXA4eVNtNnFkZ01VQUpwQWFsam90RGNSL3o0?=
 =?utf-8?B?QjFrNWxGeXRvNkdZVFFESFI3ODJ1SmY3YnJmbFRLZkZRWk1VWEprNE8wWCtB?=
 =?utf-8?B?ZFpyNURRcGN6RnlBUktNblJGZnhaREVsN0ZHNHYwSDhHRWJ0bUhocDUrY3FK?=
 =?utf-8?B?TDBwTjZzNHZFUkx5VFhpV3gwc2VsMmU4WngxK1ZycTRwYkw3S2V3Q2tXc3JR?=
 =?utf-8?B?MlB4bnk5L1hlamhCZ0hHRU8wcksxZGJJeVhLTm5vcTAzazF6cksxNXQzOEkr?=
 =?utf-8?B?ejEwc1RmQWJNWVlGMjhra1haNkRpNHY1YmRrSXhEWVVtQTJQU3ZtRklBSW5x?=
 =?utf-8?B?N0I5WmhLcnB5enBjSEh1RDM1cWh4MisyQ21rbjVlaklOQnh4VmovZHlzcXR0?=
 =?utf-8?B?bWtqRHV4U2k1bzdTM05zd3RDdTNrSkd1MVExbzhnY3UrVTIrMEhTTUh6bUhi?=
 =?utf-8?B?YlIwb1Z3cU9oNXN0WHhNK1RBUk5ieHlaOW1QUU9idmRqajVaYkprVk8rVHNz?=
 =?utf-8?B?VUdCNHQ0SXoxY0pSQ2VtVG1INVRTNnpxNVdEcUFEdDltSWJIdnhmaXJnVkFG?=
 =?utf-8?B?V2o3cHVvaVFkOUJaUXU5Vm1VZjc4akRXcHcvRmQvZjZ1YXhjM0IvNVZiYXVl?=
 =?utf-8?B?SndTUWdtdUMvYTVyNUsvM2NIeVRwclJKZ2tRMlZqbFpjaTFoazQvM2ZUeVhM?=
 =?utf-8?B?bG01WkIva01lTlpJNXRWWEZybld4elNQS0lPNEhXdVlUYjlTTUJSOVV1aGFR?=
 =?utf-8?B?TVdvb2M2SWgvOTU4TWdyelduYmNwcVFqNTBrYUpzN013RkUrNkp3V2wvTG5C?=
 =?utf-8?Q?z+h3h2+5YMv3u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2RJTHl4WGVTWDJBQ0tIOEdlekNFVndLQU5CbEpyODR5SGpnWXNjZ3c0S3lT?=
 =?utf-8?B?MUJLV01tVnJKMW8wdjN1bHdzOGNwUXVzem5OMWxzQUtmTEl1T2lYcEhJRG9k?=
 =?utf-8?B?bU42OVMxYWY1S25tSXdqN3diSnBqRHMrSGp1MDVtVG00U0Q5SzJpdjhxQ1hm?=
 =?utf-8?B?cVRWVzg0WnpQd1dON1VRUi8xUlRCM2c0RkxrdzhaKzZpUHZ2YVU3aW1MZGZD?=
 =?utf-8?B?VjNNZkNkL3BtUW1aWUQ5Z1VnMGYxT0J3bm5EZXhRMC9UQkJ4WHBFY2l6Nmlt?=
 =?utf-8?B?eXRGUmpOWmVza3ZxeFMxcVNnOHdTU3BsZTgvd0swRUJ2WjZQYndzcGlOcDFh?=
 =?utf-8?B?NEE0UlFIZFZYNVluRHpxRS9RcU5KWE9ldk5vZEowb0ZncEpYNjRwV2ZEbXZK?=
 =?utf-8?B?SDNCR3J4YmxMcW45eGhSa2YvVFFCVVg2Q3V4L2ZxTHEvRi9hWjgyejhKd1Rh?=
 =?utf-8?B?dzd6QTkzcVB5RWp4UUd4RUppaklUUTdrL1V2ekxmVGd6V2FYWkhGS24vNlJF?=
 =?utf-8?B?aExuVDJPcXFWWU1QckJMaGVaeVEwTVFTcjRJd3FMY1BkUlZvRUdWYUJ2Zmcv?=
 =?utf-8?B?NnVjK2lNSkV6VjcwUmd2dUI1OTZVSldaZlNTKzZjVlE5WXp3MTV5RmJSeWxD?=
 =?utf-8?B?UjdxNjM3NnhCclZWQzZBM3pMVHhGaTlPcENJY0tyL1B2elkxeXN1NWZkYUo0?=
 =?utf-8?B?NzhBSWxDdXNSUlUyN2tMWXZYMjFHT3hVT1cydkp6a2NNb0Z1VE45NlVRaEJN?=
 =?utf-8?B?T0ZtNkJaSmhYaXNlZTF5Uk1zeUh3V0RjTFRHM1cvOCtSWDRHK24zMCtCS0U2?=
 =?utf-8?B?RUVTbXpWTXA2TmxLaXZaeHhSaG9tVWtFRVZ0M1FPOWpTZ1hSalVaK1orKzRP?=
 =?utf-8?B?TnI5ZGZGWENsZEVIVTVndjFlSExscDk0WVpIR2ZyN21PTCtUaTI4V2UvOWVY?=
 =?utf-8?B?ekFmMVYxcENvOGtvRVhQeWg5dkJncmhISUJCd2xpaTZtOHh1cVR6ckZ2QnF3?=
 =?utf-8?B?QlkwT1UzOC9TVS9QRjR3ME5vQUVLM0QxUDkrL0E4cTVRdGdPeTdMc3lOUUZB?=
 =?utf-8?B?QlEvRittNkJheTBUdE1hcmJLZWVmQkZBUnRhMXhoV1VhMjVNRi9wUzE4QStR?=
 =?utf-8?B?c0FWVmkyUDRyZEJnZWpEVmsyalMrUjdZclNEQk9NN2hPVm1mNEZiN3NuK0lR?=
 =?utf-8?B?eGNiTUdsN1hCZDI5OFRWZG05c0JZeUI5eWpWdE9hdGZoM1BNcWhPeCt3M0w0?=
 =?utf-8?B?OWVFK0l2U1VzZFJLb3AwQWZnNjBtMkNUbzRNR2tQZk15SFducUpINDZxWEdN?=
 =?utf-8?B?dXJHQnIwUmYvYjFXcnFGV1gvN1c5YU9Ia2l6TmN4STQwY2FTQ0R0NkxSSHZE?=
 =?utf-8?B?QmF2bjdUdUtpWDM2SXloVk1sZGJqNCsvRTFDV1YxaGUrSlgrNlh3dm90T2px?=
 =?utf-8?B?SUk2L05XRXV2MElkZEhPR2NrazZHRXo3VkI0T2ZnYjJPTG5Dc3N5d0NMbURR?=
 =?utf-8?B?R2x5cXNGSEVNSTNxRUxCVmJOMWg0b0FHNEV5dEF6M01RVTlwQ2Y4eWVEYVB0?=
 =?utf-8?B?b2FPU2hqVENWblRvR3dUSlRCSXdScHhZaUJPUzg4THpvRzBndm9VcFZxcXdD?=
 =?utf-8?B?bDRvU3pBY3k1eVdYWm4xZjh2VFA5NkxyWVhObG1pSzJvNXRBM2F6cW1vUGFQ?=
 =?utf-8?B?dW8zUDNxVlpQLzBPd2NVc3ptcng4eGxVbEFIRjRROUtwclBXNTQxUFFCdDhX?=
 =?utf-8?B?TC9vSDhTR0V0eCtNNkRZUlo2NXd2SWU4VkNzdGxyTFJnRGRZQTBZUVJKSVU3?=
 =?utf-8?B?NmxxRmFkZHNkc3lvRlBGUE1YZGVIRlYrMlBXS212Y3A1OFMvYWRyVnpMOTFi?=
 =?utf-8?B?Y1d5ckVCYk9qLy9MdlhzQ2FXQ1ZST3luWEFsUWhjZEg5VDNUZmM2Vnl6VURI?=
 =?utf-8?B?TTlieE8zVkR3MEY0bGtpTmR1THFXSGZidFBCNklPNGV2QUxraU9Rc3V6aXVu?=
 =?utf-8?B?Y2JEK1JPb3hLL1o0MUI5WVE5TlJ4RkVMeEYrUEVUZW5aL0pKeDl4aG9LY3l6?=
 =?utf-8?B?TXZSSGEyZE9sdHRNOFJrMW1NelVseXU2djdjRlhKcFhtZG1xODYzbDJKT2Y1?=
 =?utf-8?Q?A5GLWie7YAgE6Vaw7iMXSVWFB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8412c896-a390-4c68-d1b0-08dd370da0d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 15:43:03.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcepAFn1lslra2aVtFbDLWDbuQ0x+MacmUlwiGCwTiKeMmE5SgZMSu3Ym3CiTCCs2pNpNeJw6fqjbJuY7+2tvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888


On 1/17/25 06:10, Dan Williams wrote:
> cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
> allocations being distinct from RAM allocations in specific ways when in
> practice the allocation rules are only relative to DPA partition index.
>
> The rules for cxl_dpa_alloc() are:
>
> - allocations can only come from 1 partition
>
> - if allocating at partition-index-N, all free space in partitions less
>    than partition-index-N must be skipped over


In my view, you are mixing the current code with the new code in this 
explanation. It would be better to say the current code assumption is 
just two partitions, ram and pmem, but DCD changes the game.


> Use the new 'struct cxl_dpa_partition' array to support allocation with
> an arbitrary number of DPA partitions on the device.
>
> A follow-on patch can go further to cleanup 'enum cxl_decoder_mode'
> concept and supersede it with looking up the memory properties from
> partition metadata.
>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/hdm.c |  167 +++++++++++++++++++++++++++++++++---------------
>   drivers/cxl/cxlmem.h   |    9 +++
>   2 files changed, 125 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7e1559b3ed88..4a2816102a1e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -223,6 +223,30 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
>   
> +static void release_skip(struct cxl_dev_state *cxlds,
> +			 const resource_size_t skip_base,
> +			 const resource_size_t skip_len)
> +{
> +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> +
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		const struct resource *part_res = &cxlds->part[i].res;
> +		resource_size_t skip_end, skip_size;
> +
> +		if (skip_start < part_res->start || skip_start > part_res->end)
> +			continue;
> +
> +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> +		skip_size = skip_end - skip_start + 1;
> +		__release_region(&cxlds->dpa_res, skip_start, skip_size);
> +		skip_start += skip_size;
> +		skip_rem -= skip_size;
> +
> +		if (!skip_rem)
> +			break;
> +	}
> +}
> +


This implies the skip can not be based on the last child end as the code 
implements.


>   /*
>    * Must be called in a context that synchronizes against this decoder's
>    * port ->remove() callback (like an endpoint decoder sysfs attribute)
> @@ -241,7 +265,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>   	skip_start = res->start - cxled->skip;
>   	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
>   	if (cxled->skip)
> -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> +		release_skip(cxlds, skip_start, cxled->skip);
>   	cxled->skip = 0;
>   	cxled->dpa_res = NULL;
>   	put_device(&cxled->cxld.dev);
> @@ -268,6 +292,47 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>   	__cxl_dpa_release(cxled);
>   }
>   
> +static int request_skip(struct cxl_dev_state *cxlds,
> +			struct cxl_endpoint_decoder *cxled,
> +			const resource_size_t skip_base,
> +			const resource_size_t skip_len)
> +{
> +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> +
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		const struct resource *part_res = &cxlds->part[i].res;
> +		struct cxl_port *port = cxled_to_port(cxled);
> +		resource_size_t skip_end, skip_size;
> +		struct resource *res;
> +
> +		if (skip_start < part_res->start || skip_start > part_res->end)
> +			continue;
> +
> +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> +		skip_size = skip_end - skip_start + 1;
> +
> +		res = __request_region(&cxlds->dpa_res, skip_start, skip_size,
> +				       dev_name(&cxled->cxld.dev), 0);
> +		if (!res) {
> +			dev_dbg(cxlds->dev,
> +				"decoder%d.%d: failed to reserve skipped space\n",
> +				port->id, cxled->cxld.id);
> +			break;
> +		}
> +		skip_start += skip_size;
> +		skip_rem -= skip_size;
> +		if (!skip_rem)
> +			break;
> +	}
> +
> +	if (skip_rem == 0)
> +		return 0;
> +
> +	release_skip(cxlds, skip_base, skip_len - skip_rem);
> +
> +	return -EBUSY;
> +}
> +
>   static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   			     resource_size_t base, resource_size_t len,
>   			     resource_size_t skipped)
> @@ -277,6 +342,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct device *dev = &port->dev;
>   	struct resource *res;
> +	int rc;
>   
>   	lockdep_assert_held_write(&cxl_dpa_rwsem);
>   
> @@ -305,14 +371,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	}
>   
>   	if (skipped) {
> -		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
> -				       dev_name(&cxled->cxld.dev), 0);
> -		if (!res) {
> -			dev_dbg(dev,
> -				"decoder%d.%d: failed to reserve skipped space\n",
> -				port->id, cxled->cxld.id);
> -			return -EBUSY;
> -		}
> +		rc = request_skip(cxlds, cxled, base - skipped, skipped);
> +		if (rc)
> +			return rc;
>   	}
>   	res = __request_region(&cxlds->dpa_res, base, len,
>   			       dev_name(&cxled->cxld.dev), 0);
> @@ -320,16 +381,15 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
>   			port->id, cxled->cxld.id);
>   		if (skipped)
> -			__release_region(&cxlds->dpa_res, base - skipped,
> -					 skipped);
> +			release_skip(cxlds, base - skipped, skipped);
>   		return -EBUSY;
>   	}
>   	cxled->dpa_res = res;
>   	cxled->skip = skipped;
>   
> -	if (resource_contains(to_pmem_res(cxlds), res))
> +	if (cxl_partition_contains(cxlds, CXL_PARTITION_PMEM, res))
>   		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(to_ram_res(cxlds), res))
> +	else if (cxl_partition_contains(cxlds, CXL_PARTITION_RAM, res))
>   		cxled->mode = CXL_DECODER_RAM;
>   	else {
>   		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> @@ -527,15 +587,13 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>   int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	resource_size_t free_ram_start, free_pmem_start;
>   	struct cxl_port *port = cxled_to_port(cxled);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct device *dev = &cxled->cxld.dev;
> -	resource_size_t start, avail, skip;
> +	struct resource *res, *prev = NULL;
> +	resource_size_t start, avail, skip, skip_start;
>   	struct resource *p, *last;
> -	const struct resource *ram_res = to_ram_res(cxlds);
> -	const struct resource *pmem_res = to_pmem_res(cxlds);
> -	int rc;
> +	int part, rc;
>   
>   	down_write(&cxl_dpa_rwsem);
>   	if (cxled->cxld.region) {
> @@ -551,47 +609,54 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   		goto out;
>   	}
>   
> -	for (p = ram_res->child, last = NULL; p; p = p->sibling)
> -		last = p;
> -	if (last)
> -		free_ram_start = last->end + 1;
> +	if (cxled->mode == CXL_DECODER_RAM)
> +		part = CXL_PARTITION_RAM;
> +	else if (cxled->mode == CXL_DECODER_PMEM)
> +		part = CXL_PARTITION_PMEM;
>   	else
> -		free_ram_start = ram_res->start;
> +		part = cxlds->nr_partitions;
> +
> +	if (part >= cxlds->nr_partitions) {
> +		dev_dbg(dev, "partition %d not found\n", part);
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
> +	res = &cxlds->part[part].res;
>   
> -	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
> +	for (p = res->child, last = NULL; p; p = p->sibling)
>   		last = p;
>   	if (last)
> -		free_pmem_start = last->end + 1;
> +		start = last->end + 1;
>   	else
> -		free_pmem_start = pmem_res->start;
> +		start = res->start;
>   


As said above, this is not correct if there are holes due to releases.


> -	if (cxled->mode == CXL_DECODER_RAM) {
> -		start = free_ram_start;
> -		avail = ram_res->end - start + 1;
> -		skip = 0;
> -	} else if (cxled->mode == CXL_DECODER_PMEM) {
> -		resource_size_t skip_start, skip_end;
> -
> -		start = free_pmem_start;
> -		avail = pmem_res->end - start + 1;
> -		skip_start = free_ram_start;
> -
> -		/*
> -		 * If some pmem is already allocated, then that allocation
> -		 * already handled the skip.
> -		 */
> -		if (pmem_res->child &&
> -		    skip_start == pmem_res->child->start)
> -			skip_end = skip_start - 1;
> -		else
> -			skip_end = start - 1;
> -		skip = skip_end - skip_start + 1;
> -	} else {
> -		dev_dbg(dev, "mode not set\n");
> -		rc = -EINVAL;
> -		goto out;
> +	/*
> +	 * To allocate at partition N, a skip needs to be calculated for all
> +	 * unallocated space at lower partitions indices.
> +	 *
> +	 * If a partition has any allocations, the search can end because a
> +	 * previous cxl_dpa_alloc() invocation is assumed to have accounted for
> +	 * all previous partitions.
> +	 */


This is right, but the code below is not because ...


> +	skip_start = CXL_RESOURCE_NONE;
> +	for (int i = part; i; i--) {
> +		prev = &cxlds->part[i - 1].res;
> +		for (p = prev->child, last = NULL; p; p = p->sibling)
> +			last = p;


... holes ...


I think the problem here is we assumed ram and pmem being a child and 
likely some free space, but a device with multiple HDM decoders implies 
potentially several child.

The code supported the case of multiple child but I guess we still had 
in mind the simple case. Otherwise I can not understand all this ...

