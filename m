Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A45D3A1E96
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950037; cv=fail; b=nQJu5rXPIEb7H+G0QWmSJhW1oOnTUG3n7s6cZ+UjE1suOPzJ5Fvrsdyd5IIGLi3nCmd/Kb3VFHsww/EyzZYRIBMpPcCgC8mfe1oYUjLXdTe0unlq898N3BhAffAcqHD3xGX3GqTIyhRtjwqiv70kEQ0dr9EUO/6SyejRmOBY5CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950037; c=relaxed/simple;
	bh=FEzRHE9mYpy7yFYtmRIQW9g6cMUESfCezh2AJe7UxXM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kew2ntqnEc8iEos6rst9KKqWC0t8x+vNCYGAGuszMb9POUdLe3yhYj7YdnhDWIU0jYk99Q5YnOLU/6Tb2a9kp9fCUN2TPmizt29tye3t5aQlfbWj1S1ETKdF0H/c7Vv/9nrwGrCZwIH4DTnA4ingXusg5Lz9Lwv5u7vZi76MY0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vBlye+td; arc=fail smtp.client-ip=52.101.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vBlye+td"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4X897e38+levS3GxiXqMAltJ5HawBtj7gNEwKEVaErZXTJBK+aBOm5fkSttrjk3lrN0hIBJmzWoddDu3MFuY4KDZ6xCAaKBeFxpDgGU+jRDgzGwpw6WxwLuGvwumOhMddOTJyb9OhFCP75i3kv+7CuAihdoZ7UJO/5LspPtk3QfuMd5aH52lhBKmv62q/FXfSQuT8kIDqmNlGn/ykFh53gki2eVA8ms/54y7jho+dMLSoshV4vCr0JzqZYxxjRjVqncPbscmEuciWG9lqPuD0CxuTGnAAVaWQsFFXNVxD2p97i/JyMlRsQu4MtlBp9Pr0+h7qARCwHHsyrVw+BCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8bMWcSh8Tx62IBoHwZCf+66ft9uR62u7yUBUaDiigA=;
 b=r1ntO5QYjrbl946sywtWbtnXLMAsDhl0y2QtDqNzwKQ6mnWYRIKxo8nD+19hj2WgmDrEzAaHVGwppujeTppr5ptOyF8xIJolNP1Kj8w/3PsQ2fuGX8ex/kVQ42ynY1nj4fRqIWUr0hPNkLAuFdMJYUv3ow43ixzV0Rurp5JF/wfvsEL8CSW9R2TrQRtFpaI7JkmL0flLSaKS+k0j4vr/aYus9tWPh2uJHLpgqeIjIHf6UrC8dCCNkIev4B1nPSE5XK+Wnsgq4CO3BJeUzwH3Xk2th9epAuLPp68nArvFVJY50C45WoH+EOyrGHvnXlJhcKmpBFHJfrvlSIOkqykavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8bMWcSh8Tx62IBoHwZCf+66ft9uR62u7yUBUaDiigA=;
 b=vBlye+td9cNiif90cSWRYjkRBBiIZWp28KCN7WASYZGpCw5CqYCwtBFfr0/cRL8sGjrg2Vi93dD5+vH2juxkI8HT06clI0rr5G8K4QDyjSWbTirVn73Ujj3z8NMjkeO3xWy85soZQK4iVGLqsRWu2/VrznTwAeHbFS3r4YvVtQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:20:31 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:20:30 +0000
Message-ID: <8dffea35-d62e-44d3-acf2-e0ddd2acabc4@amd.com>
Date: Tue, 24 Feb 2026 16:20:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] cxl region changes for Type2 support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, dan.j.williams@intel.com
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
 <b785af3a-3c78-46eb-9ced-9dd0723f3ba9@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <b785af3a-3c78-46eb-9ced-9dd0723f3ba9@intel.com>
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f98d620-c6c0-4a5a-929c-08de73c0a120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzVFMmJheFE5bXBOUWpvQzlCWTVsQiswV3Nyd0wrbGZtbHBESCtUTWsxamxL?=
 =?utf-8?B?OGROU2U2VmZod0JYT3htZC9uQ1QyeHpVVCtpTmovZW9xaWtpK0JwY3pTM01u?=
 =?utf-8?B?TG9CVENuanNNSitJRHFkcS9ISGoxOHpQZGx5cXB2MzdZcEY3TTUrSTN0UStQ?=
 =?utf-8?B?VUtuSkF1S2FaajhLbzB5OWgrMlpiUk9WVHVaMEEvc1VhbmorZlpBOHA3MVFH?=
 =?utf-8?B?bFU3UHZKS3B6R0F0djZ6R2NqYWpOc0xqbjgyaE9INGMyM09TcS9xcFlGM0hI?=
 =?utf-8?B?RE9HRTFnVzVWY1Q0bWJBa3ozcDd2L3lqSUJZQmkvU01mWEk1WTZrbVBpelN4?=
 =?utf-8?B?MXJNcDBtb2NKbEF3ZjB4TXBsNmM5WlpuU3ZVMjBuZGswaHV0R0hIbllxSGxQ?=
 =?utf-8?B?a1BQai9wU0sxQmJzeHloUjZIYjlEVjlZR1VvUTkvSWhnWjBwbndlSjZ4MzVN?=
 =?utf-8?B?Sjd6K2l6SW5nbzM3OWZLRWVlY2hPaHIwRnhia2NpSXhQOHM2TGNGTkRnUlZn?=
 =?utf-8?B?aVlyYWFWK1RiRERqa3RpUWhMU2huTXR4eTBrQ3YxaTc5Q1d1T1BQeFZZOThu?=
 =?utf-8?B?clBBaVA4emw3QWl2VVdKWEQ1UkhBcEN3K1VhZHpXcUd0WGM3NDFMd1ZRQ3Q1?=
 =?utf-8?B?ZHpvSjEvVCtWd2sxSmV1YkZZV3U4QjgvVTB2aWFweHgyU3YwdmRIakRDeVFH?=
 =?utf-8?B?M2hXODNTTS9INmEzM2Y4SW9kbTU1NkhFblhXeGJEVnRvcEdRRjh1ZURNT0Z6?=
 =?utf-8?B?ZTJUQXlHVS9KTVhJVVRsL2lDSGJIbU44ZTk2REhhMjhrckk5aHRLdDZGVTJi?=
 =?utf-8?B?T29jNWRzcjFXaGYyVUo4VnBiNDJ1QU4yZEFwT0FTeHcvYTFwM3F3cHZtem1F?=
 =?utf-8?B?MGJ3bWhMM0xoU1NQNEVFWFJNbXQ2NThXaDVXOHBaMFJibkI4MGN0OGR6bWRU?=
 =?utf-8?B?OE5sT20xTCtkQUR4bWlUTmVUYkpxWFZNZkV6eGYreCsxREkycEFSUzlrU29X?=
 =?utf-8?B?Qnkrc2ZaZ3oyekl5V212ZGl5RTVkbkxUa05KUjk0Tk1MZTJpWHUwM1d1RmZz?=
 =?utf-8?B?RmNQKy91TFZTSTBYKzZTckZiRTI3VFl2VDhUZXFKMlhLSUh1SkxPdE9XMUs3?=
 =?utf-8?B?ZnRzUXMveEVIVkxVeUdtaG95Ny9FWnB2WUxZUTV1UEpRa2tVY2RieFVSVkRN?=
 =?utf-8?B?SUIwSzhnOUpydUN1aGpvUFhLS0MrdnJybWx6Q1V1ZWF2ZzFOTlJqNUkxWktC?=
 =?utf-8?B?dDB1QVFreEwzM1I3b0ZXNXp5MS9pNkw1dDN3M2ducVhJR0FqSllPc0hNRGtR?=
 =?utf-8?B?ZEw0MGhNMXZFdDNqZWtjcW55Ly9acUxKR0RGbFlsak10QVpYODJNaFBENHZ5?=
 =?utf-8?B?RnYrblovRkU2dEdRZnc3UUYyemIvdUlZaFhUMm9jOHBWQzdzV3FsV2Q1L2VK?=
 =?utf-8?B?NXFPTStCV3Vid3p4UDJsR3lpeFhUSmFsWkNYNUR1ZTRYNVVjSW1sVlZ5SDdq?=
 =?utf-8?B?RkxCQVYrS3krOUo5STJJS1Z0SVJZNjZYTWtlWGhYS1BkR3hheml6d2VoVVVp?=
 =?utf-8?B?c2I5WWhJMTJpaEdTT2NPZ1MxYkFVN3BkK3p5cFNidmlkWmx4SVJDbXQrOWN0?=
 =?utf-8?B?elVpOVZCb094bVA1c1g1VUFhaUNMN1FicVJzeCttY3FqdEpiTjFVQWhTQVBa?=
 =?utf-8?B?VHhPQWtWay9NVzdmNThEbS9zb25FK2h2M0YxVDhRcjAvU0NvOFZGQnpnTTJS?=
 =?utf-8?B?RjZVRzdDWERJaXRRenFnSHhEbWJxNHVnQ0FrdHNOcWJhaXlxR0pGRERwaWFJ?=
 =?utf-8?B?Nk5JTDk2LzE3d1hTUkpMdmRNYUk2R2Jxb2tpNlYzQUR0WndBNy80NytPOHRw?=
 =?utf-8?B?Wnp1Z0FZT1QzU3c4SkJSRWxnWmpTLzZLRGJkTGRpaEZldlJ3eERudzBsY3k2?=
 =?utf-8?B?TkNpQ1NUNjV2UDJwK005RUVDNEpPT0FQUnJBeTFUSGt3cVpGT2hiRko1N05X?=
 =?utf-8?B?OFZNUU1ncUVjRVN5cEoyUnJ3V1pFeHRIYmxtbHhhUTRpT0xtMUNqcXZseXZi?=
 =?utf-8?B?YXF0MmxuOFNwbGF0cGc4UWs3cUUvR0pzVHJkelhwSG1RamU2M2I5ckhvTGxY?=
 =?utf-8?Q?KfJnE+6rH9xhn8WV5OxE0X6Yg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlhWSjlqOGhiT0xyVWhuM2RLdURIdzRkOGVET1hDRTJXVmVVaTVITFJnZ2F6?=
 =?utf-8?B?TnZGMWQvY05nbGJSWWZEN3BINHUyaVJVSkRZS1NXZjZSUEVjc2tveUdYd21o?=
 =?utf-8?B?ekx2WDhKemxaaTFRSSt6a0MxRnFMQkZCeWlLNDk2aXF4T1IveFVnWXM0QTlB?=
 =?utf-8?B?cDM3Rk1VZ2o0dzF5VDRBSGFBZ2lPNC9FenRWUFlQL29tTmc4WUFldGQ1KzNr?=
 =?utf-8?B?dWtUUS92MUtoMzVTdGF4RE9tQnhCSGNJSVoveElxWmt4TFpZWUxORjJ4QUFE?=
 =?utf-8?B?cU9IL0llOXZOR3pkMkFJNjR0V2RtZmMyUXdRUmhMZityMlNMZ3F1ZzdOZEJt?=
 =?utf-8?B?dnA5VEd2THZabnhvSmlWN2hFQmJUZVdTVzkxRDZNdk5VdmFhcGJ2S1RBdERX?=
 =?utf-8?B?ZUdxYnlTUHBzMkJnK0Rhakw3RzYwLzdyV0MzbzB2bW9RZmFCeUUyMDRWYVpI?=
 =?utf-8?B?WkIwcXF2YlRJWUNWaFJFQVVUaEFNSFpKbE0rclBBUWlISHk3cDdPT0xDdzVm?=
 =?utf-8?B?V0FoU3JINHlwdHBDUHl6MGhWNzZrc0xwcEp2WVduenQ5TG5odm9qRVlrdVhJ?=
 =?utf-8?B?WEF5T0d0WUlOSnFWOFV0a1dpckFEZmJjR1RYbmRxRTR2V0JHdEozbk5CSXlV?=
 =?utf-8?B?ZFQrdTIrM3RXKzcyMVlNWWdNUTFoTFEwTFFhaG9UTElya0U3bXJSblIxSlo2?=
 =?utf-8?B?ekc1M2tjWWdjYnJvUGxNdHJMZUZRQi9WK3lIbjYyZEgzdHNyeFlkZUxHeGh5?=
 =?utf-8?B?Wis3bncrMnR3UWZnK3U0MVdkMmVJZXdZZkt1ZXJFRzFOK2dVMVVndWNJbmpT?=
 =?utf-8?B?ZFZaVktvN01EWWhYZXErK3ZqWFRCdm9CS3R6QUVDYVcyTjVEaE1xOXVhNWl4?=
 =?utf-8?B?U3RBSlY1UnU5U1BaTDV5REUwR1pldDhWcDRidXEwVjZORk1jSllvV1IxZVZm?=
 =?utf-8?B?K3RnVTdDVERmK0VYbGVLdUJ2MXk3R1FDTlVjUG1TQUVscndKaFkwOURmZ0tV?=
 =?utf-8?B?eWVRT3lIaWhYS201eVArK09iY1R0d2tKeGZpR1FvdDB6endZTjFZV1BiNnNF?=
 =?utf-8?B?b09pY3ZybS9Gc0xKVytONy9HOGdrV1ZhYmFKRkJwVlM0L1ZINFFTQkVNMHUw?=
 =?utf-8?B?djk4UUlwZTM5OGhUbmg0cHVrdEc2UmdjRlhKcU44VUg0d01QNER3dysycjlS?=
 =?utf-8?B?SWtLT2FwOWNhdWp4UlFldlUzUzJCK3NqZkRHUFUzZm5OZW50czNMVVJvOWUz?=
 =?utf-8?B?azBaeFFOcWpuNTZvWHVEVnlieXhLOFhqMmxBV2MzN3lzMTZVK1U4RkZVUFE5?=
 =?utf-8?B?a0cwMVByOVlPYzNzZTBsUnZoaUtkMFc3SFhZYXZwWnhnTXBETXNqY0lKTEhN?=
 =?utf-8?B?L09zQS8yY2l2UjhuN1NZZFJnT2ZjYTZ0TkRLS1pPTlY2UFB3bVVQRDF6QUlP?=
 =?utf-8?B?c0tNMXptUGF5WG82K2Urejh4YnljMVl4dGJtdmEyVXZPbDA3blhLYk5KK3Bl?=
 =?utf-8?B?UGRTTGpQdnVwUHV4MEJsSCtWdUdGSHd1TVVDS2dGY3F0cm5qbkZOQm15MTZp?=
 =?utf-8?B?QmRsYmpuTEUzTkZRc200S3hBVS9kWVNvelJIN0Q0QnlVaStUVnlDeUg0clJs?=
 =?utf-8?B?cngzRjhnV1BneDN2dkQ2SVdZRjJrL1JnWjIvYThqdjU2TUxUK1QrUkg2SXdH?=
 =?utf-8?B?NVFoTXZ0SklDQUhxSUV3Ym51QWxFMmNId3JDRDI1eHV4MnZIL2hySXdJOTc4?=
 =?utf-8?B?MTkyYW93UURMQ2VzanJXdFg0bWh1R3dES2lxanczYXp1V0wzM3ZGV1NYaEhB?=
 =?utf-8?B?ZFNENWlUMTJSL1hKbTFGc0VwZ0oyM0pvOTg2T0gwZDNBYlVZZTVDbHlPK1FU?=
 =?utf-8?B?SC9KOENxeVZ5ckZZTlNqOGl1bTFyU3Y2QlFqVW9udTJ5Sk1TQnBDaTVjd0Zy?=
 =?utf-8?B?QndwcWsrSWUyR1BLTmd1SWF6RndDbXJvOWkvMEY3VWkwNndvYUtyMVR4T3dT?=
 =?utf-8?B?K05CdlpwUXlkK2xISFZvUEZyNU13TkJ3aEtESDZTa0ZidnlEQk1ucDVnRjhU?=
 =?utf-8?B?akpZZEpHYnIvSmxsdVJ4Vnh3VXNYN1R4djA5Ty9RTlVUTW9hTEpWS2dEc1ZS?=
 =?utf-8?B?OStjTHFTREZSbGxyV043aHZpZkgzVWIwQ3N0YnROd2pqdFhpRGtTWXJVVVdJ?=
 =?utf-8?B?ZXE4aXVzWXRlaklzeXo2dUNFWkc1ZVNHakVyc0RLeGJ5RTNuN3d3akZZcUoy?=
 =?utf-8?B?akpZTUxNVHdWbWdSVlFlc1d1eHhqMnhhTkxkMkxNdEtueTlkVVFTSmtpYVRq?=
 =?utf-8?B?M1BnY0xhQ1Jrai9USTBYZ003SkdmckpOeUFzbzZqaDNBTmJQMGRhdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f98d620-c6c0-4a5a-929c-08de73c0a120
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:20:30.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTFfCG/g9VwgKSVwrZyteyrc7Fiuawfq6YkBk1xLKowhDmbJrRNeAY0uIhj8BteRVBJR7UXtWplU5CnMypkrRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017


On 2/24/26 15:39, Dave Jiang wrote:
>
> On 2/24/26 8:26 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for Type2 devices/drivers support, these next patches
>> adapt the cxl region code for required Type2 functionality preserving
>> current functionality.
>>
>> Alejandro Lucero (3):
>>    cxl: Make region type based on endpoint type
>>    cxl/region: Factor out interleave ways setup
>>    cxl/region: Factor out interleave granularity setup
>>
>>   drivers/cxl/core/region.c | 87 +++++++++++++++++++++++++--------------
>>   1 file changed, 56 insertions(+), 31 deletions(-)
>>
>>
>> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> Does this set depends on the preparation set [1] or is independent?


Hi Dave,


It is independent, but it applies cleanly on top of the previous ones as 
core/region.c is not modified by the other.


Thank you


> [1]: https://lore.kernel.org/linux-cxl/20260223142633.2994082-1-alejandro.lucero-palau@amd.com/T/#t
