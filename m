Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDA23B62B
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343872; cv=fail; b=qZAYv4rc5aaAxzY5Mzsf+J2ea5GQxQOypSEdoDUS2GrgINw8xBoaBxvI73jPAL/EQlR5RYMnB3i4JWHl0vTdaL+FP48k4jiOYLIFGsnIMxJIoabYBQsR+wOjCSPpJzeWaSd7ihDg2a11QsMJdxBRNFIhjkRnlEpgxE9kCy1InV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343872; c=relaxed/simple;
	bh=okG5T7D3Lbsg4FS/V+32SRp4JGH2N5GtT9kvOGibks8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=owIiGMNtZJA/c1X5huZNyW7lSxYlYnJG5MCSYhO8M1P27/iTywoEneaLGN+Tp8GEDI507VU6SrL807VCxzvHBYvnt0JjqJE5We4ws2HI3XCjoIBvlBGc5p4lf66gRXT72EAhKzI0fELAaaPQBV6HyKOtjCMBuVogoCSIKLPne+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p87avsnT; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p87avsnT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qK79PZsf6o45h9XVpzwgL8OF2jZIhDn23VEZC+UQMjUbItdOK/KHUNmlWLjwItulunXS2/avzrd1WBpXNtua1rNDfIcBdL1mPzocfN6vKvGrYXtRQ0BDmVlEVq9n1r9UdLu4tfuPnGhcnGUi2YU0wifGXhOkEn1tlmyqCAkWcmyh55E1x9A5BUuiKgW7lQrVr2WjsA2ItWEz4/ad9V+vzXc/lk44EAsXMfXWdf5je90R84bxtcEWyQNUd5jiEFvVc/6x3zdZsuds5j/A8lrNhbqhCL6rdSfaJKG5ZcLzE4hcP7cBZ1jPH5PJlcfoIqM621RcFdelcwqcGGPi6Wac5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYrZugzYAJa9wbF+8fyFDE32trkvPAlnEzux8eiB5fE=;
 b=m97Ag6aWurB4QwejL72/mu8OQKF5I7tUeEwgpJXEhWjsaOQu153dMIYrE0+sdSNU3tcIra8fAiV4X6ZG11HYLgHXz7pdg3kOM4jjQyh8Nir8R6FyYC3MvcV6BqAMFoqRG+jbEMuRSQmQ/IyMOI6XSri1o14zRiNElAjPtuME/YxvhRKN9bHIMtU1rfuo31oddsNDUb7BzVxOYtjbTBAMsLlG122nej0jPqlebtcAvm/XftxvL9x7yalrnC1NVK1Y+y5qVH3UtyYDyHr1Ln4lxv2U8r+l302iwgacxeC53WmrSVkLTtKDKy8r0CFCdeqOh/1GIXqXmzdENbbmcjbHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYrZugzYAJa9wbF+8fyFDE32trkvPAlnEzux8eiB5fE=;
 b=p87avsnTJRMRBSWrDQ5y1gP4fPZL0EnP9v0LJAf18n+2FfmYinIXgKOpyfcRqX8ohspAgMSMRcPtBA+8PQusLzo4iHzR+E20YY2b1q5Vq2B0HlGTCo4L6asBNnEo6Y+DLLHPdg758lmcAs/a5n+zNi5sbJlQVpwoXKYCjZjNrYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 21:44:26 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 21:44:25 +0000
Message-ID: <2ba859ca-4125-4acc-af4a-0ed0abd3f42e@amd.com>
Date: Mon, 4 Aug 2025 16:44:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250730152519.125601-1-dave.jiang@intel.com>
 <f921b707-f7d9-4b36-9f15-8eea099bde72@amd.com>
 <f7b15a63-bb3d-41c5-81ea-dd1d4bcd569c@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <f7b15a63-bb3d-41c5-81ea-dd1d4bcd569c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:806:d3::19) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 475672d8-8c1b-4ec4-7c91-08ddd3a014c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmliaU1VQ0RyZFBZc25sT3I1bG5pM2srM1pDbDVMMEIvZ00zYUR1dzJMaDNs?=
 =?utf-8?B?OVoveVdaVmVXUTRSbjhRM2NKdTZ6N3RVVDdlbUtqSWtqaTdnNlEwWjEybUVK?=
 =?utf-8?B?cWVNcHVxNkJpcUZIQlpQalZXM1lFOUtJTlZ5ZzJxY2VNL3lkSmVoeFZNb2R0?=
 =?utf-8?B?cm4rcU10akZzdkZIM3ZkNXpUZEp6ZllrVlNKZGt0V2ttZTl3cUVJejk0bUZN?=
 =?utf-8?B?R2NIanJodHliM3JtNy96YmsyV2FSRFdYUStVU2YzeGZuekZpRkxOZ2tLQ204?=
 =?utf-8?B?NUJmd1g2K0F4b2owNFRIeXBhRHpPN0NJMlUyUDRYekM5bER3a2dLNVpLb3Uv?=
 =?utf-8?B?QmpYZnNPdldQRXJ4VVZpL2NVREp0ZGplbWYvWHJBTGU5a2hjNWJwRXRzbXFs?=
 =?utf-8?B?Q0M5YWMyand4SFlMbVh6b0VpOG1ZcDlFNHRINnJSQWJRTnJZcU5uU3pOOGhR?=
 =?utf-8?B?OFMvMm1abzZMeUtwOGRWVGtwYm9iNXZmak9PdlMvSG4xV0N3Z1hTSFRvRDhi?=
 =?utf-8?B?VHI3MTNFMk9PYmZxaUYxbzlpbVY5OVJZbFY2QmhIUHlTajJ6YUVLaEtwLzFa?=
 =?utf-8?B?Z2NMSUdjSWllK1FKbzVGU2xFT2FmNHhrTkJYWVhLeEt6VFNHaU5Ma0NuaURM?=
 =?utf-8?B?N3hiZTBrVzRubjQvbktWcGZrdUxkSThuOFhQSURvTzdVcitzdHNiOXV1RmNr?=
 =?utf-8?B?TmVvQU1xcWhNd2JNU3psTUkwNkhNVjAzSkc0YzlqYWVYaFIxbm1LOHNnZTVQ?=
 =?utf-8?B?SlIwTWZRSGVHSGliYldoNjArcERER2FaNjB0Yi9selV2ZmxacHNKUW44aWsz?=
 =?utf-8?B?eTlVVmxSdmxaRTA0eWxkb3MrUHJYMGJLTExJb0poRkQ5VTh6bzZ5UWw3WHAx?=
 =?utf-8?B?TDBSVmhYdjhlRDJwbTJqVFUrVGhxc0VkL2MwRGh1dzIwM21QUzNxSUdTbS8x?=
 =?utf-8?B?K3FjcnpreFB1Rzd6ZXhPVEc3OEpVZGYwcE5GcmFmdkpwYnZTdE5Qd1FZdEpa?=
 =?utf-8?B?ZTc4RWZNVWxDeDZJREF5K0xWZVdpS0ljUjFGNHMrd2FVRFNJOXJpSXdYcWlI?=
 =?utf-8?B?VmhUYUM5UWFscHFWekVKSXd6VXlXQWtQSDVYZ2liNkZBN2hrM08ydHRSdE5x?=
 =?utf-8?B?eFNGTlhicUY0UGs3eVo2YVZkQzA5NjhMWDBPdVJpemY3SUl0MnlOcGJIbngy?=
 =?utf-8?B?WmdDRUNkOXF5NEwwdk1EZHV0Kzh6QUNQUURlYnYrZjlqajNJVVNSSmVsczdZ?=
 =?utf-8?B?TzJkd2tJMHArbFpQUUxJMWhpbGo1MlYxcGVWUDdsOTBhWFZoQ1h1UHE1R0M2?=
 =?utf-8?B?NXdPdlJ1ZVJEK0ppMnlyWG9mSzZCbW9CeXNscC81SmRMRUZ5ek5uenRsQmdo?=
 =?utf-8?B?MXpBZlo4VE9aWlpvUStSRE0yL08zN0tSZTYvVFloRXRxMDNNRFRPSGRPblk5?=
 =?utf-8?B?WHkvVk1oQXc0WTYrTHA1OVYzRlFtcmhSQ3VvYVl3THgvS0djUUs4ZXkyc0Ny?=
 =?utf-8?B?cjV5VXJ3cStRK0x3R09aeDFUQStiZGV1dEFWYjF2YTBCNkNweGdjZlczYWts?=
 =?utf-8?B?WHE3K0l6M1JKWkx2N1R6RW4xeUVRbDlaaFdVcDRiRnB2WFE1QTM3UndLbnZ0?=
 =?utf-8?B?VklERmxCOHFIbFdBbG1ONTY1L0VZVDc5RVlneS8rSlA4a1FWQ0xjbWtvazEy?=
 =?utf-8?B?UVl5SkpsaExOWjFidjZNTDFnZnVON3NSOTl1RHV0Z3FXUkswekJTYmpKemt0?=
 =?utf-8?B?emlsREJVUFN4NHRUTFphM3o5TTcxZjBnaW1INEIvRG9iQVgvOUVqdWJXd2s2?=
 =?utf-8?B?d0VTV1N0dHdMK2k3UzNNVi9uL1lBRzlGR2VrUWNTeHZLaG42Nk9oMjh2eWU2?=
 =?utf-8?B?NEhxNGg0RldpSE5oVUZoalMzRytOT25QM2VSL29NZ3UzdDhaZGxNTW1VVWsv?=
 =?utf-8?Q?jrN7CK2uXTs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJGWkdQeElMNHF4emN5SDdTRGI2aUZOd1p2dm1USk0rbHJ5UWJsNTBLMjBV?=
 =?utf-8?B?eENmM1R4Y2puNzRTY2N5VEZIeUdHb3I1MG45NWp1YTJMb09menI0RElCVWJS?=
 =?utf-8?B?eVU5U2YzVENiQVd4Q3BXeENQc0ppR3V4NzlQYm1jU0JycnJsRUNYY2R0N1lL?=
 =?utf-8?B?Zzh3dm45YnJBNndSSHVmVW00Q0xxc2Z1VExzZWVjOCtlMitaTk9oUHJsMllJ?=
 =?utf-8?B?amh6RVlzU1dOemhTa1AyNFhMWS9ZaC84MXg4bnJ5YVF6QUNLNXN3V2R2bTVz?=
 =?utf-8?B?dTJ6TWZERHhwTWhnK0VFYzN3K3FyVG9SV3JPbnhLTWg2NzNwT1VzOW5tWWc5?=
 =?utf-8?B?ZDM1SndYaFpoTVllQmZzaGpucFptbXFhN01IM0ZmM1V5V1luWEJqbXc0QXlZ?=
 =?utf-8?B?bEdlalVaUWdUbkNLSlNQSEVGSithRVVydFo2N0haS3BtK1FTMW01UGNsc2Z1?=
 =?utf-8?B?UWQxVkJwYzIyZU1YVHQ2Y3paNFhXcXdnUHJSZVRDNjNsZjg2NWc1RjgweCty?=
 =?utf-8?B?ajVFVk9TNmlPdVJacC9QdjM2Y0xUNzFrUUhwWlBmSXh1bGh2UnFoaFpzdmxB?=
 =?utf-8?B?VjJmckdpL3BZUEtvMVJsb0hzWXpsbzJVR2tVenA0aGRMUGlGeFhiZFJsbkRk?=
 =?utf-8?B?ZURXd2dPMG82OHkxWFZnUnR4RGgxcnBZOUdZRXNNWXVGRG01UndTRFY5MVR3?=
 =?utf-8?B?bXVBK2pxbm1ZMmNuM2JtMytKSVZtRXIxRExXOFBuOCs5ajlhRW9kQ0JlSVp6?=
 =?utf-8?B?bjJRV3RKQ0RMT3MyKzQxTW8yaXBXR3kwdG0vVERmYzlFMVcyN2pzV29oYlFj?=
 =?utf-8?B?U0ViZjhlMjRXc0Q1cXQ2cGpjMG41YUw4U29CSHZmMkdPU09leURiWWpvNHN5?=
 =?utf-8?B?bit4RG4xQXhxbFg0T29lN1gwVndvdXBvS2pkOStOWlhTY1hlMWV2ZnptMWdY?=
 =?utf-8?B?REJIK1lHYy80QzVwNjAvMUhTUGE3NjdpYUNLcDhzQzRnaXRvWCsyQTJ3MkZy?=
 =?utf-8?B?N01GVFFMbmgveStURUNHZ0FRZGMxWitvV096NW5wbGdzaU9Ib1ZLQUdwcFVq?=
 =?utf-8?B?clhXS2VnUzBtWWZsUytZRkplaUNBTC9hMDdnR3hreTZxcDBsY2dMZ0RWVy84?=
 =?utf-8?B?YkQ2a3lxUUhJeWJOQlNOSTIxWnRyam83RHEzdVg2QWFyUmx2R2FtK1lQTlc1?=
 =?utf-8?B?WHRGL0MzV0FheEV2TnU0eVNuOGg5eWxXeW1MTmtFYitTUk5uNnh2STNybmU3?=
 =?utf-8?B?dlNwSkUrb2g4NXk1L21RMFY3c1VPVDFMWWRyN3JhcGRQZVJPRWJBbkVDamdC?=
 =?utf-8?B?MDdRSWJwNGRNZ2JhekhraE92UEgzdkRhQTMxU3RQTUVVL0JORW1qUGd4VVRO?=
 =?utf-8?B?U3haWk10UnNWWTRjcTQ5WmRzUE1VUzI4ZWYxRjhBcnpOYUpMSFY2b2FvVm9S?=
 =?utf-8?B?aVJ5U1IydHJmeXh0MTZLd0xYM3orbms0VnpjZTNNZTFtV3E2VXg0MU9NbFUx?=
 =?utf-8?B?QzhCMmhQaW41S1VGM1hRNDh5UU1pZHNwYWl1Q3JQRGxxY0FsYk9zdktDbFJQ?=
 =?utf-8?B?dy9uVzZjVUM0ZTJFZTQvYTgrYVI5NWxlWWRkdURoNUptQmhlRFk4eUdFVEVt?=
 =?utf-8?B?UzgyZ09GMEJsaUszRHVoZ2V3RUdsVXJFTWhtN2RTeHNZLy9wdnNSYU45S2Ji?=
 =?utf-8?B?SDFXazl6b3p1Vkx0OC9RQTBiMk94K2RtNWZSdEdEV3lqK2Q0NVp1MzNUMXpU?=
 =?utf-8?B?OWx6SDEvUDNhNHRjQWJ1T0hVd2Y1WlVTcGxkNE55dzQ4M204VlN4QjBtS3Vp?=
 =?utf-8?B?bEp5ZkpGdWFMY0FaN0pySk15Z1J3cUFOSGJoNWJyT0YvUGVoejhMcUNUNjR0?=
 =?utf-8?B?K3lpbmhNYit4Z2d5VEd6THduMjRIRGE5VGlzK1hCYmdKVlg2YjBURVdEdkdj?=
 =?utf-8?B?ZjFIQVRwSXN3azNEYUF4Nmk1bncybXA1cmZpTThET0V0bHlVaDRQRnFyL3N4?=
 =?utf-8?B?RGcrK2F4MVMxOUd0dTl2QXNsVDBFQ2ZNVS9wb1ZLMW9zbCtGbUdBK2VWeWl1?=
 =?utf-8?B?TXdaS1A1aFdSQkF1K0d1S29jT0JlRUhSUldQRDdCOThPQU9aQ2dKb0FmNzVi?=
 =?utf-8?Q?9hiv/rIomqYKo6DMbvcqMTEHD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475672d8-8c1b-4ec4-7c91-08ddd3a014c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 21:44:25.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjDzHfu6BLjPbZRqGgfi0CCZPrJ3tzOdJ8Oo7g1JGluD2oTJPTOM1pgRNPELN2iuTmfnFd0FxStOMO7NQKvLpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163



Please add my reviewed-by:
Reviewed-by: Terry Bowman <terry.bowman@amd.com>


On 8/4/2025 4:31 PM, Dave Jiang wrote:
> 
> 
> On 8/4/25 12:46 PM, Bowman, Terry wrote:
>> On 7/30/2025 10:25 AM, Dave Jiang wrote:
>>> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
>>> the config. The config will depend on CPER or PCIE AER to build.
>>> Move the related RAS code from core/pci.c to core/ras.c.
>>>
>>> Cc: Robert Richter <rrichter@amd.com>
>>> Cc: Terry Bowman <terry.bowman@amd.com>
>>> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>> v5:
>>> - Make cxl_handle_rdport_errors() static. (Dan)
>>> ---
>>>  drivers/cxl/Kconfig       |   4 +
>>>  drivers/cxl/core/Makefile |   2 +-
>>>  drivers/cxl/core/pci.c    | 319 --------------------------------------
>>>  drivers/cxl/core/ras.c    | 312 +++++++++++++++++++++++++++++++++++++
>>>  drivers/cxl/cxl.h         |   8 -
>>>  drivers/cxl/cxlpci.h      |  16 ++
>>>  tools/testing/cxl/Kbuild  |   1 +
>>>  7 files changed, 334 insertions(+), 328 deletions(-)
>>>
>>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>>> index 48b7314afdb8..b36bb0cabe58 100644
>>> --- a/drivers/cxl/Kconfig
>>> +++ b/drivers/cxl/Kconfig
>>> @@ -233,4 +233,8 @@ config CXL_MCE
>>>  	def_bool y
>>>  	depends on X86_MCE && MEMORY_FAILURE
>>>  
>>> +config CXL_RAS
>>> +	def_bool y
>>> +	depends on ACPI_APEI_GHES || PCIEAER_CXL
>>> +
>>>  endif
>>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>>> index 79e2ef81fde8..1c652e575aaa 100644
>>> --- a/drivers/cxl/core/Makefile
>>> +++ b/drivers/cxl/core/Makefile
>>> @@ -14,10 +14,10 @@ cxl_core-y += pci.o
>>>  cxl_core-y += hdm.o
>>>  cxl_core-y += pmu.o
>>>  cxl_core-y += cdat.o
>>> -cxl_core-y += ras.o
>>>  cxl_core-y += acpi.o
>>>  cxl_core-$(CONFIG_TRACING) += trace.o
>>>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>>>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>>>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>>> +cxl_core-$(CONFIG_CXL_RAS) += ras.o
>>
>>
>> Hi Dave,
>>
>> By moving ras.c into conditional compilation under CONFIG_CXL_RAS the 
>> cxl_ras_init() and cxl_ras_exit() will need conditional definition stubs. 
>> I dont see them here but I may have missed.
> 
> Must've missed them. I'll add. Thanks for catching. 
> 
>>
>> -Terry 
>>
>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index b50551601c2e..a3aef78f903a 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -6,7 +6,6 @@
>>>  #include <linux/delay.h>
>>>  #include <linux/pci.h>
>>>  #include <linux/pci-doe.h>
>>> -#include <linux/aer.h>
>>>  #include <cxlpci.h>
>>>  #include <cxlmem.h>
>>>  #include <cxl.h>
>>> @@ -664,324 +663,6 @@ void read_cdat_data(struct cxl_port *port)
>>>  }
>>>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>>>  
>>> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>>> -				 void __iomem *ras_base)
>>> -{
>>> -	void __iomem *addr;
>>> -	u32 status;
>>> -
>>> -	if (!ras_base)
>>> -		return;
>>> -
>>> -	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>> -	status = readl(addr);
>>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>>> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>>> -	}
>>> -}
>>> -
>>> -static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>>> -{
>>> -	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
>>> -}
>>> -
>>> -/* CXL spec rev3.0 8.2.4.16.1 */
>>> -static void header_log_copy(void __iomem *ras_base, u32 *log)
>>> -{
>>> -	void __iomem *addr;
>>> -	u32 *log_addr;
>>> -	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
>>> -
>>> -	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
>>> -	log_addr = log;
>>> -
>>> -	for (i = 0; i < log_u32_size; i++) {
>>> -		*log_addr = readl(addr);
>>> -		log_addr++;
>>> -		addr += sizeof(u32);
>>> -	}
>>> -}
>>> -
>>> -/*
>>> - * Log the state of the RAS status registers and prepare them to log the
>>> - * next error status. Return 1 if reset needed.
>>> - */
>>> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>>> -				  void __iomem *ras_base)
>>> -{
>>> -	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>> -	void __iomem *addr;
>>> -	u32 status;
>>> -	u32 fe;
>>> -
>>> -	if (!ras_base)
>>> -		return false;
>>> -
>>> -	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>>> -	status = readl(addr);
>>> -	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>>> -		return false;
>>> -
>>> -	/* If multiple errors, log header points to first error from ctrl reg */
>>> -	if (hweight32(status) > 1) {
>>> -		void __iomem *rcc_addr =
>>> -			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
>>> -
>>> -		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>>> -				   readl(rcc_addr)));
>>> -	} else {
>>> -		fe = status;
>>> -	}
>>> -
>>> -	header_log_copy(ras_base, hl);
>>> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
>>> -	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>> -
>>> -	return true;
>>> -}
>>> -
>>> -static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>>> -{
>>> -	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
>>> -}
>>> -
>>> -#ifdef CONFIG_PCIEAER_CXL
>>> -
>>> -static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>> -{
>>> -	resource_size_t aer_phys;
>>> -	struct device *host;
>>> -	u16 aer_cap;
>>> -
>>> -	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
>>> -	if (aer_cap) {
>>> -		host = dport->reg_map.host;
>>> -		aer_phys = aer_cap + dport->rcrb.base;
>>> -		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
>>> -						sizeof(struct aer_capability_regs));
>>> -	}
>>> -}
>>> -
>>> -static void cxl_dport_map_ras(struct cxl_dport *dport)
>>> -{
>>> -	struct cxl_register_map *map = &dport->reg_map;
>>> -	struct device *dev = dport->dport_dev;
>>> -
>>> -	if (!map->component_map.ras.valid)
>>> -		dev_dbg(dev, "RAS registers not found\n");
>>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>> -		dev_dbg(dev, "Failed to map RAS capability.\n");
>>> -}
>>> -
>>> -static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>> -{
>>> -	void __iomem *aer_base = dport->regs.dport_aer;
>>> -	u32 aer_cmd_mask, aer_cmd;
>>> -
>>> -	if (!aer_base)
>>> -		return;
>>> -
>>> -	/*
>>> -	 * Disable RCH root port command interrupts.
>>> -	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>>> -	 *
>>> -	 * This sequence may not be necessary. CXL spec states disabling
>>> -	 * the root cmd register's interrupts is required. But, PCI spec
>>> -	 * shows these are disabled by default on reset.
>>> -	 */
>>> -	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>>> -			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>>> -			PCI_ERR_ROOT_CMD_FATAL_EN);
>>> -	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>>> -	aer_cmd &= ~aer_cmd_mask;
>>> -	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>> -}
>>> -
>>> -/**
>>> - * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>> - * @dport: the cxl_dport that needs to be initialized
>>> - * @host: host device for devm operations
>>> - */
>>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>> -{
>>> -	dport->reg_map.host = host;
>>> -	cxl_dport_map_ras(dport);
>>> -
>>> -	if (dport->rch) {
>>> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>>> -
>>> -		if (!host_bridge->native_aer)
>>> -			return;
>>> -
>>> -		cxl_dport_map_rch_aer(dport);
>>> -		cxl_disable_rch_root_ints(dport);
>>> -	}
>>> -}
>>> -EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>> -
>>> -static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>>> -					  struct cxl_dport *dport)
>>> -{
>>> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
>>> -}
>>> -
>>> -static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>>> -				       struct cxl_dport *dport)
>>> -{
>>> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
>>> -}
>>> -
>>> -/*
>>> - * Copy the AER capability registers using 32 bit read accesses.
>>> - * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>>> - * status after copying.
>>> - *
>>> - * @aer_base: base address of AER capability block in RCRB
>>> - * @aer_regs: destination for copying AER capability
>>> - */
>>> -static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>> -				 struct aer_capability_regs *aer_regs)
>>> -{
>>> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>>> -	u32 *aer_regs_buf = (u32 *)aer_regs;
>>> -	int n;
>>> -
>>> -	if (!aer_base)
>>> -		return false;
>>> -
>>> -	/* Use readl() to guarantee 32-bit accesses */
>>> -	for (n = 0; n < read_cnt; n++)
>>> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>>> -
>>> -	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>>> -	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>>> -
>>> -	return true;
>>> -}
>>> -
>>> -/* Get AER severity. Return false if there is no error. */
>>> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>> -				     int *severity)
>>> -{
>>> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>>> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>>> -			*severity = AER_FATAL;
>>> -		else
>>> -			*severity = AER_NONFATAL;
>>> -		return true;
>>> -	}
>>> -
>>> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>>> -		*severity = AER_CORRECTABLE;
>>> -		return true;
>>> -	}
>>> -
>>> -	return false;
>>> -}
>>> -
>>> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>> -{
>>> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>> -	struct aer_capability_regs aer_regs;
>>> -	struct cxl_dport *dport;
>>> -	int severity;
>>> -
>>> -	struct cxl_port *port __free(put_cxl_port) =
>>> -		cxl_pci_find_port(pdev, &dport);
>>> -	if (!port)
>>> -		return;
>>> -
>>> -	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>> -		return;
>>> -
>>> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>>> -		return;
>>> -
>>> -	pci_print_aer(pdev, severity, &aer_regs);
>>> -
>>> -	if (severity == AER_CORRECTABLE)
>>> -		cxl_handle_rdport_cor_ras(cxlds, dport);
>>> -	else
>>> -		cxl_handle_rdport_ras(cxlds, dport);
>>> -}
>>> -
>>> -#else
>>> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>>> -#endif
>>> -
>>> -void cxl_cor_error_detected(struct pci_dev *pdev)
>>> -{
>>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> -	struct device *dev = &cxlds->cxlmd->dev;
>>> -
>>> -	scoped_guard(device, dev) {
>>> -		if (!dev->driver) {
>>> -			dev_warn(&pdev->dev,
>>> -				 "%s: memdev disabled, abort error handling\n",
>>> -				 dev_name(dev));
>>> -			return;
>>> -		}
>>> -
>>> -		if (cxlds->rcd)
>>> -			cxl_handle_rdport_errors(cxlds);
>>> -
>>> -		cxl_handle_endpoint_cor_ras(cxlds);
>>> -	}
>>> -}
>>> -EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>>> -
>>> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>> -				    pci_channel_state_t state)
>>> -{
>>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>>> -	struct device *dev = &cxlmd->dev;
>>> -	bool ue;
>>> -
>>> -	scoped_guard(device, dev) {
>>> -		if (!dev->driver) {
>>> -			dev_warn(&pdev->dev,
>>> -				 "%s: memdev disabled, abort error handling\n",
>>> -				 dev_name(dev));
>>> -			return PCI_ERS_RESULT_DISCONNECT;
>>> -		}
>>> -
>>> -		if (cxlds->rcd)
>>> -			cxl_handle_rdport_errors(cxlds);
>>> -		/*
>>> -		 * A frozen channel indicates an impending reset which is fatal to
>>> -		 * CXL.mem operation, and will likely crash the system. On the off
>>> -		 * chance the situation is recoverable dump the status of the RAS
>>> -		 * capability registers and bounce the active state of the memdev.
>>> -		 */
>>> -		ue = cxl_handle_endpoint_ras(cxlds);
>>> -	}
>>> -
>>> -
>>> -	switch (state) {
>>> -	case pci_channel_io_normal:
>>> -		if (ue) {
>>> -			device_release_driver(dev);
>>> -			return PCI_ERS_RESULT_NEED_RESET;
>>> -		}
>>> -		return PCI_ERS_RESULT_CAN_RECOVER;
>>> -	case pci_channel_io_frozen:
>>> -		dev_warn(&pdev->dev,
>>> -			 "%s: frozen state error detected, disable CXL.mem\n",
>>> -			 dev_name(dev));
>>> -		device_release_driver(dev);
>>> -		return PCI_ERS_RESULT_NEED_RESET;
>>> -	case pci_channel_io_perm_failure:
>>> -		dev_warn(&pdev->dev,
>>> -			 "failure state error detected, request disconnect\n");
>>> -		return PCI_ERS_RESULT_DISCONNECT;
>>> -	}
>>> -	return PCI_ERS_RESULT_NEED_RESET;
>>> -}
>>> -EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>>> -
>>>  static int cxl_flit_size(struct pci_dev *pdev)
>>>  {
>>>  	if (cxl_pci_flit_256(pdev))
>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>> index 485a831695c7..2e203a07786d 100644
>>> --- a/drivers/cxl/core/ras.c
>>> +++ b/drivers/cxl/core/ras.c
>>> @@ -4,7 +4,9 @@
>>>  #include <linux/pci.h>
>>>  #include <linux/aer.h>
>>>  #include <cxl/event.h>
>>> +#include <cxlpci.h>
>>>  #include <cxlmem.h>
>>> +#include <cxl.h>
>>>  #include "trace.h"
>>>  
>>>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>>> @@ -117,3 +119,313 @@ void cxl_ras_exit(void)
>>>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>>>  	cancel_work_sync(&cxl_cper_prot_err_work);
>>>  }
>>> +
>>> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>> +{
>>> +	resource_size_t aer_phys;
>>> +	struct device *host;
>>> +	u16 aer_cap;
>>> +
>>> +	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
>>> +	if (aer_cap) {
>>> +		host = dport->reg_map.host;
>>> +		aer_phys = aer_cap + dport->rcrb.base;
>>> +		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
>>> +						sizeof(struct aer_capability_regs));
>>> +	}
>>> +}
>>> +
>>> +static void cxl_dport_map_ras(struct cxl_dport *dport)
>>> +{
>>> +	struct cxl_register_map *map = &dport->reg_map;
>>> +	struct device *dev = dport->dport_dev;
>>> +
>>> +	if (!map->component_map.ras.valid)
>>> +		dev_dbg(dev, "RAS registers not found\n");
>>> +	else if (cxl_map_component_regs(map, &dport->regs.component,
>>> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>> +		dev_dbg(dev, "Failed to map RAS capability.\n");
>>> +}
>>> +
>>> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>> +{
>>> +	void __iomem *aer_base = dport->regs.dport_aer;
>>> +	u32 aer_cmd_mask, aer_cmd;
>>> +
>>> +	if (!aer_base)
>>> +		return;
>>> +
>>> +	/*
>>> +	 * Disable RCH root port command interrupts.
>>> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>>> +	 *
>>> +	 * This sequence may not be necessary. CXL spec states disabling
>>> +	 * the root cmd register's interrupts is required. But, PCI spec
>>> +	 * shows these are disabled by default on reset.
>>> +	 */
>>> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>>> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>>> +			PCI_ERR_ROOT_CMD_FATAL_EN);
>>> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>>> +	aer_cmd &= ~aer_cmd_mask;
>>> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>> +}
>>> +
>>> +/**
>>> + * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>> + * @dport: the cxl_dport that needs to be initialized
>>> + * @host: host device for devm operations
>>> + */
>>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>> +{
>>> +	dport->reg_map.host = host;
>>> +	cxl_dport_map_ras(dport);
>>> +
>>> +	if (dport->rch) {
>>> +		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>>> +
>>> +		if (!host_bridge->native_aer)
>>> +			return;
>>> +
>>> +		cxl_dport_map_rch_aer(dport);
>>> +		cxl_disable_rch_root_ints(dport);
>>> +	}
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>> +
>>> +static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>>> +{
>>> +	void __iomem *addr;
>>> +	u32 status;
>>> +
>>> +	if (!ras_base)
>>> +		return;
>>> +
>>> +	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>> +	status = readl(addr);
>>> +	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>>> +		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>>> +		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
>>> +	}
>>> +}
>>> +
>>> +/* CXL spec rev3.0 8.2.4.16.1 */
>>> +static void header_log_copy(void __iomem *ras_base, u32 *log)
>>> +{
>>> +	void __iomem *addr;
>>> +	u32 *log_addr;
>>> +	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
>>> +
>>> +	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
>>> +	log_addr = log;
>>> +
>>> +	for (i = 0; i < log_u32_size; i++) {
>>> +		*log_addr = readl(addr);
>>> +		log_addr++;
>>> +		addr += sizeof(u32);
>>> +	}
>>> +}
>>> +
>>> +static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>>> +					  struct cxl_dport *dport)
>>> +{
>>> +	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
>>> +}
>>> +
>>> +/*
>>> + * Log the state of the RAS status registers and prepare them to log the
>>> + * next error status. Return 1 if reset needed.
>>> + */
>>> +static bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>>> +{
>>> +	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>> +	void __iomem *addr;
>>> +	u32 status;
>>> +	u32 fe;
>>> +
>>> +	if (!ras_base)
>>> +		return false;
>>> +
>>> +	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>>> +	status = readl(addr);
>>> +	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>>> +		return false;
>>> +
>>> +	/* If multiple errors, log header points to first error from ctrl reg */
>>> +	if (hweight32(status) > 1) {
>>> +		void __iomem *rcc_addr =
>>> +			ras_base + CXL_RAS_CAP_CONTROL_OFFSET;
>>> +
>>> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
>>> +				   readl(rcc_addr)));
>>> +	} else {
>>> +		fe = status;
>>> +	}
>>> +
>>> +	header_log_copy(ras_base, hl);
>>> +	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
>>> +	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>>> +				       struct cxl_dport *dport)
>>> +{
>>> +	return __cxl_handle_ras(cxlds, dport->regs.ras);
>>> +}
>>> +
>>> +/*
>>> + * Copy the AER capability registers using 32 bit read accesses.
>>> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>>> + * status after copying.
>>> + *
>>> + * @aer_base: base address of AER capability block in RCRB
>>> + * @aer_regs: destination for copying AER capability
>>> + */
>>> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>> +				 struct aer_capability_regs *aer_regs)
>>> +{
>>> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>>> +	u32 *aer_regs_buf = (u32 *)aer_regs;
>>> +	int n;
>>> +
>>> +	if (!aer_base)
>>> +		return false;
>>> +
>>> +	/* Use readl() to guarantee 32-bit accesses */
>>> +	for (n = 0; n < read_cnt; n++)
>>> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>>> +
>>> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>>> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +/* Get AER severity. Return false if there is no error. */
>>> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>> +				     int *severity)
>>> +{
>>> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>>> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>>> +			*severity = AER_FATAL;
>>> +		else
>>> +			*severity = AER_NONFATAL;
>>> +		return true;
>>> +	}
>>> +
>>> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>>> +		*severity = AER_CORRECTABLE;
>>> +		return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>> +	struct aer_capability_regs aer_regs;
>>> +	struct cxl_dport *dport;
>>> +	int severity;
>>> +
>>> +	struct cxl_port *port __free(put_cxl_port) =
>>> +		cxl_pci_find_port(pdev, &dport);
>>> +	if (!port)
>>> +		return;
>>> +
>>> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>> +		return;
>>> +
>>> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
>>> +		return;
>>> +
>>> +	pci_print_aer(pdev, severity, &aer_regs);
>>> +
>>> +	if (severity == AER_CORRECTABLE)
>>> +		cxl_handle_rdport_cor_ras(cxlds, dport);
>>> +	else
>>> +		cxl_handle_rdport_ras(cxlds, dport);
>>> +}
>>> +
>>> +static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>>> +{
>>> +	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
>>> +}
>>> +
>>> +static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>>> +{
>>> +	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
>>> +}
>>> +
>>> +void cxl_cor_error_detected(struct pci_dev *pdev)
>>> +{
>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> +	struct device *dev = &cxlds->cxlmd->dev;
>>> +
>>> +	scoped_guard(device, dev) {
>>> +		if (!dev->driver) {
>>> +			dev_warn(&pdev->dev,
>>> +				 "%s: memdev disabled, abort error handling\n",
>>> +				 dev_name(dev));
>>> +			return;
>>> +		}
>>> +
>>> +		if (cxlds->rcd)
>>> +			cxl_handle_rdport_errors(cxlds);
>>> +
>>> +		cxl_handle_endpoint_cor_ras(cxlds);
>>> +	}
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>>> +
>>> +pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>> +				    pci_channel_state_t state)
>>> +{
>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>>> +	struct device *dev = &cxlmd->dev;
>>> +	bool ue;
>>> +
>>> +	scoped_guard(device, dev) {
>>> +		if (!dev->driver) {
>>> +			dev_warn(&pdev->dev,
>>> +				 "%s: memdev disabled, abort error handling\n",
>>> +				 dev_name(dev));
>>> +			return PCI_ERS_RESULT_DISCONNECT;
>>> +		}
>>> +
>>> +		if (cxlds->rcd)
>>> +			cxl_handle_rdport_errors(cxlds);
>>> +		/*
>>> +		 * A frozen channel indicates an impending reset which is fatal to
>>> +		 * CXL.mem operation, and will likely crash the system. On the off
>>> +		 * chance the situation is recoverable dump the status of the RAS
>>> +		 * capability registers and bounce the active state of the memdev.
>>> +		 */
>>> +		ue = cxl_handle_endpoint_ras(cxlds);
>>> +	}
>>> +
>>> +
>>> +	switch (state) {
>>> +	case pci_channel_io_normal:
>>> +		if (ue) {
>>> +			device_release_driver(dev);
>>> +			return PCI_ERS_RESULT_NEED_RESET;
>>> +		}
>>> +		return PCI_ERS_RESULT_CAN_RECOVER;
>>> +	case pci_channel_io_frozen:
>>> +		dev_warn(&pdev->dev,
>>> +			 "%s: frozen state error detected, disable CXL.mem\n",
>>> +			 dev_name(dev));
>>> +		device_release_driver(dev);
>>> +		return PCI_ERS_RESULT_NEED_RESET;
>>> +	case pci_channel_io_perm_failure:
>>> +		dev_warn(&pdev->dev,
>>> +			 "failure state error detected, request disconnect\n");
>>> +		return PCI_ERS_RESULT_DISCONNECT;
>>> +	}
>>> +	return PCI_ERS_RESULT_NEED_RESET;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index f68a9414da26..ddf0ee46b116 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -760,14 +760,6 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>>  					 struct device *dport_dev, int port_id,
>>>  					 resource_size_t rcrb);
>>>  
>>> -#ifdef CONFIG_PCIEAER_CXL
>>> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>> -#else
>>> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>> -						struct device *host) { }
>>> -#endif
>>> -
>>>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>>> index 54e219b0049e..3959fa7e2ead 100644
>>> --- a/drivers/cxl/cxlpci.h
>>> +++ b/drivers/cxl/cxlpci.h
>>> @@ -132,7 +132,23 @@ struct cxl_dev_state;
>>>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>>>  			struct cxl_endpoint_dvsec_info *info);
>>>  void read_cdat_data(struct cxl_port *port);
>>> +
>>> +#ifdef CONFIG_CXL_RAS
>>>  void cxl_cor_error_detected(struct pci_dev *pdev);
>>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>  				    pci_channel_state_t state);
>>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>> +#else
>>> +static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>>> +
>>> +static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>> +						  pci_channel_state_t state)
>>> +{
>>> +	return PCI_ERS_RESULT_NONE;
>>> +}
>>> +
>>> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>> +						struct device *host) { }
>>> +#endif
>>> +
>>>  #endif /* __CXL_PCI_H__ */
>>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>>> index 31a2d73c963f..4cc8099bbcd2 100644
>>> --- a/tools/testing/cxl/Kbuild
>>> +++ b/tools/testing/cxl/Kbuild
>>> @@ -68,6 +68,7 @@ cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>>>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>>>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
>>> +cxl_core-$(CONFIG_CXL_RAS) += $(CXL_CORE_SRC)/ras.o
>>>  cxl_core-y += config_check.o
>>>  cxl_core-y += cxl_core_test.o
>>>  cxl_core-y += cxl_core_exports.o
>>>
>>> base-commit: 6e130ce1dfd47a1ef953d0be127934760aecb769
>>
> 


