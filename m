Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB6155759
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737713714; cv=fail; b=K4qa5nMj6mvP4bYjpzT88aLvM1BQMwsHlh70urOxHb9fq8F2bhbuCIzWHrv+PXH0TLqgS9uNmvXKg1qzXQk5yBkDvzwOxiVIwZapGm8PfkWbzS0VpWwSeYHFnKGLJTUlXfZpcEQLIn11F+0y0cIOtMKcP1AYEe0MMhcFQ6fqca8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737713714; c=relaxed/simple;
	bh=d2GijG5Rl26SlmSjs/O6m4DwbCxdH7PxGPRSOjRr2Y0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZoU1B5NelEkMMXxjFc8+If0zX5cMU3C5X900RTnU3EvJJ5jn53TzoXmbP1k8paaD8FeTYe7XBlAMGjwlGi5AExI4RPyD2emxRqLFWeBTjRmXJbCaszOW/GHH8yztsCNU4G4mqsCLJ8XpMGJQl7lfyjuYa9PDRFMZ0cO8/PQD3aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qTINrsm7; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qTINrsm7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec8zAL3wbBug5KPzAu9BhPR1cZHL++1cF8W1b+7ycFCG5iKS4fXLmsZlRfjBsqesJDFbKZH2rQB/YtoyVUpWXeUxRLuwSaYSDMMlPgvICYVSbNNaoNOEg030DHfxLj8cVnh6xgN6r+jih17+ow0nCnIsBraZvNO/R9yy9YrXL00qI+YPJAdgDpBTMEzqu51KPvQZU4vkWBGy34Vh0GaxKbUb8AdE+trot4pe0zjv1cRIUTg/FFlLkXRcPMztQbAXtAVqTw2qVtWhIWKdozBdaJM04ZIwNxZiYfpBOHUZoNuZGSSpxn8UmKGU7D+nUoKNkDzCcGHOEMiHZOnIku9DlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+rtb8E7fL+ArNVBDLZwpeY2c2ent74vJW2McJWOn/0=;
 b=nGSlhWHfYv/LNa0nD7FNUAUzjFtzdupzJBtqNq0Z5fHGPvCXR13rY9587gMStR7AJ0OMU8ROGC4K+dVfi38LRGT5fD0i1ShQHmSNoXBC6Rgp4NIDp8u/d2rDrsmOLB1OtWIaYKYnP4zTOsXeG789YGLbHepRoJbChWaY1jxI3I0AxK7QuTI5HB7tY1yOkmPvn0ATia2tzn0JvRnmc4aJ0pdupefPjYHNNkQmBBUytCVdZYW3rfxW576xZXLm6U83iuYx5CmlY6syn/gY0TKiipBq8mA/8PMPb5LBIuR8qn3kAXhV97fkVAThOLbk2vksRqN0PAWC+NGJueZmkTQOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+rtb8E7fL+ArNVBDLZwpeY2c2ent74vJW2McJWOn/0=;
 b=qTINrsm7oYuV5sWb6K8yCYb5CaYkdn8YkGPbRVVqwVp/DaZLTWd7ZI8jLw7MzNLFx4J12tB5G7NKyAy5QzOuYSgAENHFwwlIKlUbFusdnHEjX7hJyOOF0O1zdspGtU+mdVkNgwkdHQS7WqzE5BVYkL+B89iELkcH6LJUMOQPw88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 10:15:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 10:15:11 +0000
Message-ID: <ecaa87d1-29d3-eb41-5a92-ecd74a9bae2c@amd.com>
Date: Fri, 24 Jan 2025 10:15:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636159.3849855.512949598685608224.stgit@dwillia2-xfh.jf.intel.com>
 <0ebda6db-8431-3ef3-9c24-d19cbec7f338@amd.com>
 <6792aedf7fb0_20fa294bd@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6792aedf7fb0_20fa294bd@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 66630078-5c72-4e2d-9fac-08dd3c5ffc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGh1eFE1Vk1xZjljSU9sMk5EVlkrVUcraStvVHZlU1dzQ2dVOWhZTmhKUjJJ?=
 =?utf-8?B?SVJuS2RxRHpXbTRlL0d3TDc4K2xVdE5qMTBRQ0F4d0VFYmdsV0gzZ05ZNXQw?=
 =?utf-8?B?N3g4dXNmVmwxYnZmUlhNYUZOdE5IcXRweGFzWU5lN0s4Qy84bXE5SHc0OHlB?=
 =?utf-8?B?U01ic28yOEpXU0VBc0hvUGlNajBId2RObWdRSWtBMFVjK3RqZ21YV29jdnE5?=
 =?utf-8?B?dHVIdjJlN1I3NDg2UTdESzhtOEJvdmpueVJUMHlMaVlnV3ZvSXdlVFg2bXBo?=
 =?utf-8?B?OVVHSGdJb0FneTZJLzJkWS83cmtKU25jb2pBSy8vbVVGd0IwcThtRlF4RU0v?=
 =?utf-8?B?b2Nyc2dPUVZzbkcwVGJRQ3B0QmY1L3VEaXFQNHVpeTNjK1RHdDN2NHNCOE1v?=
 =?utf-8?B?VkdCQ3FYNE5mbFdDQTZ0Q2p3MysrRDI0c1F1enZOWFFaL1NGUlk4S3ZEbEti?=
 =?utf-8?B?QVNIUU5odkhxOEtlU1JmNy9aQjZuWmQza3NPRDMrTXdPbFpmK2NHZXZXajRH?=
 =?utf-8?B?WUJPeFVtKzVUcGlFWk9UdEFQWWRTSHVDbjJLWnNURGVFNE9tUExRK3I1N3FD?=
 =?utf-8?B?bDBIYkJRRzUxZnlGeXAwbmxGZGpGeVFqWUJ3ekdZMVNlTVZnN2xHVGkyTFZQ?=
 =?utf-8?B?ZHpXQUZSSVlVZjI2eGhHaVZ1SnRoQkRLSDJlQzIwdUU0eDVZTEVLUE45c2dM?=
 =?utf-8?B?M1pXN3o1UUFkYkVIYkpXR0MzNUIvNi8wcE1FVytwS3BaME0wVlNObE9LM3dN?=
 =?utf-8?B?TVhGY3JicGhYa3QrSEhJMjJOS0tMOE10MkJ6V1VybjI3QjI2akJ5MjRiSUtE?=
 =?utf-8?B?Z0FZZlllS2d0L0NNbFMwaHUyNE5OSmhlakRrSnBhQytRWVBwOWg5b2Q5RnBl?=
 =?utf-8?B?V2pJaHRac0ZnTncya1RQb0c3T0NQZFBGWTgvMkYxL3d2T0Nadi9DT0ovKzUy?=
 =?utf-8?B?U2k1amwzSGJadWdZRHp4dzdHV0Vsd2xPVHE4L1M2LzZmZ1hRQkhnaXFvODBG?=
 =?utf-8?B?OGIwNk9VVkdvaVJLOG5GVXhnbXBVQkk1RzhnR3ZSOEtkVE5Tdy8zZ0h5T2N1?=
 =?utf-8?B?b2I4VTNJVmQ2WGNRaTF2WERheXc4Rm5wOGJrTTVZVHl3Rm5UQkFOQWQwMXF5?=
 =?utf-8?B?ZEVnVXZrUjVZeGYzSFJVVW5hUnVDOFhaeWl3bVhOMmI3anBZL3I3ckpaL0R1?=
 =?utf-8?B?T0xrZGdVV3ljcVVkWmIvVEVva3ZvK3lxRzZsQXJTS3V2V3FqelZhVWtVSUQ5?=
 =?utf-8?B?L2Fsb2YxL3BLQ3IvM3ZzaGNBeEU5dXV2K3dQcGdkcVNsb255bzlpcDRuU0Iy?=
 =?utf-8?B?YXhwWnN2azhoaFcxanI4N016MTNQMHFPcXJuc0tFbmQ0V3dxL2ZIbzczcFZs?=
 =?utf-8?B?cHpCVmFRYW51THE3WGlJK0NqYTZHZFlpUXBPeGJURG5NWFJoSWc2bXFiVm01?=
 =?utf-8?B?UE81RHA4c1hCZG9vMUtmdDFmKy95dWxLbUNSNkhML1pmMjlXTU5mUUZ0TkNH?=
 =?utf-8?B?ZUJNOWNTMjNUa1hURkg2Qk0xVG5uSEJWWU5RaERXbTQ1SlU5U0VxRUpiV1d3?=
 =?utf-8?B?MlIxaE93ZzZBa1o3VG44SnJCd0o4aHEzOHRpMVVtWk5Bb1QzZUxxUkVzNTl1?=
 =?utf-8?B?aER2M2wrcDc3TGRCdEhCbkJiR0hTZVRCeG05dzhJU0trS2xkWnBWMkZtQVNG?=
 =?utf-8?B?VUtRV1pzZ0xGQVpQTSs0d3I5M2M2dUwwNVJxZ3ZQMDhXS2tZNWdDNnR5aDVm?=
 =?utf-8?B?T3hDL3NjbHBQbFpJTjQreXY1ZUxIWUFiZFJGZEtjMElGVTBSaXFLQjNPR0xm?=
 =?utf-8?B?ZHM5dzl1ZGUwd1B2UmJKYXdzUTBPM0p4b0cwVUdEeUoxZWxhc0d2WG00MGdW?=
 =?utf-8?Q?VbYHPrLSDrOlf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDlLNHBwcE5qQnlMTStmZzFBODM2ajRoemVhakNTU0MyNkpKdUtqOGkxU0VC?=
 =?utf-8?B?M0FTYkNRTDVtZzNsQ1RTOVVxa1BKQ0tTRUdMZVpqRGJVMkNibHdFVlRhWmk3?=
 =?utf-8?B?RWdmcFloaXlvaGhwKzVUQUxkK2RhUWt0VkRUYTYyeHJ5TDd4L2xXVWVKbzNp?=
 =?utf-8?B?NnpYOVYzeWV6dlNzZ01pLzFYNXhLRXpLSFV6Z2ZuZEd6a25GVzdVU2wzajZQ?=
 =?utf-8?B?V2VyaDRQcmhtWkpLYklWc3llMGdrK0gvcmRhaWR5VWVaR2RhTGRIcUVld1BD?=
 =?utf-8?B?U204U3NFNzExMzczOWdGbUxsVElVREJrQ3hFWkNOaHF3OGJmcFp0T0tFeVh2?=
 =?utf-8?B?WlRadm9LRDUyU1o5aHpOcTN5bXY2dEdwNE1mamIweXJJVlkrM1BSemFBcGtF?=
 =?utf-8?B?RkdLWnVIK01mVWh2Vi9VT2F2U0dxY2s4WmZmMlZnUUpwWGY2a3VwZ0t5cC84?=
 =?utf-8?B?S0V3cmU2Uko4cmRNTWxPWit1cHhiSGQ0dExEOWFuazh0ZjNFdkxWVS9LRnBy?=
 =?utf-8?B?ZVk3R21LTU14dEIwUStHekR0Y0l0VjFhZGp2WStFREp1TEgzY3FQeU44VWlU?=
 =?utf-8?B?ZEQ3RDdxczRYeFRDWHNuRU5ROU9iK0Y5TkVVOGo2YThDcUxqYjBrTWY1d2JJ?=
 =?utf-8?B?bDFhYTJXNi9PS09vRG5FeGhzYjVteURWWG5aelNVZVZsbUs1SzR6TDkrWXd6?=
 =?utf-8?B?ZkpiME52akZQbXNYemV3UUIrOFNmN3UzTmxFMWRscW1GMTZHdnZIRFBtRk1L?=
 =?utf-8?B?TUw1aEw2MkVEM0hIVUVoZk1QSUZGam1hWll0WHVabXFTQy8xa0FNSmk5TGhS?=
 =?utf-8?B?b056VnBvbE1wUlNTTDFhbXRWNm9hYzEwN0lnY1lkMm9waFNvQkVZQm1yMERO?=
 =?utf-8?B?c3F5VlVCLzRVNmdBNHAxZHVSVU9yaGRjYmMzY2hTeDZsbmtJMHdmRkFldlBh?=
 =?utf-8?B?TFgyNkdLZSt2SW5WUVlMREM1MWZxcXZJTC9mOCsxbW1yaUtKOGRoMGVZS2ZZ?=
 =?utf-8?B?S2lZdUlaeHF6VGNybU84cDlObnFrY0ZzejB3aHdjcWErSWxBeE1lRUw4eWxs?=
 =?utf-8?B?ZjZETUxJaDF4c2t5Zi9uZFlrSytscG5zeEl2RTlqK3ZWaGFMRitUK3hzSVN6?=
 =?utf-8?B?Yk9yUkxsQ0ZEbUFPdy8wSUZLTXpaWFlXVjhYWHpDUHkyUU94VUJOQXdRTUlk?=
 =?utf-8?B?SkU4eWQrOEdHS21QWGZ0a1p0NmFicEsvZGhrcXFNekNGNEdOOFMwa2JBajFW?=
 =?utf-8?B?dW1PNWRBaFBydldlS1RjQWN2Q010d0NCQ3Z1a05ycnNkWDFVb0FBcVRyR0Nr?=
 =?utf-8?B?NmRZZkM3ZVpkbnQvbUN2TEdGcWhuYmxNcnFpdGdWb2RYYUpHV3VTUWxtNXpN?=
 =?utf-8?B?VzhFa2RqMmN3S1lJRlAvbllxSXV6L29OVW9aMmoxOHVtdHN5eGRHVmJNS2Nm?=
 =?utf-8?B?eURWRXNQL1VHTmNyekY4alRUUm04UkxEdHAvQllRMkw5Y292aTVjVE1CL3pU?=
 =?utf-8?B?eHZ0c3llNk9iTUZyakFHU0ZGOTZwb3JnRTNpUlRnNFUrQ0EwM1hpNlBiZlU2?=
 =?utf-8?B?cnpWTkF0NFNpMEZBSXZUMVRwaE5FWXFIRzRGdkpXSXorY0hxYXJ2M0swRWY5?=
 =?utf-8?B?WDdMTENXdWJJSlJpcWxWU05hOXdqVWZFSmtPWmFVQU40UzFvc1FQaUZKMkth?=
 =?utf-8?B?V3hFakMrdmxtUm1lVk5UUmdkSXlDTVRXRytINmxERkR4NGZ4WmpKa0EwbEpB?=
 =?utf-8?B?MVRwRzE4Y1pxMmlKMEd4VmN4cHJ0OVN0REp3NXJSWW81aDJ6Z2tEaGVnUm84?=
 =?utf-8?B?cC9wS3psTWJFSjR0QXRpc0RqZXdzVlV6eWxGY21XZU5jd2ZTME1RWmNTRFNZ?=
 =?utf-8?B?ZkY3VGZnTFp0bGJZL3I2RUZsYTViM25pRGR0SkZYL2RqU0hNUThwNWt0V2E3?=
 =?utf-8?B?LzJYNnFqaHYyV1REbVN5cUhaUDl5MnFEdVk4bmdLaFlVVG52ZXVIZnBvc3JZ?=
 =?utf-8?B?WnZXMStvcHEwR3BXUHdxTmk3ZzQyM3ZEclg4THZibDhBV0pGTytjZzM2bVFV?=
 =?utf-8?B?RnF3V1B0ZUtCNklBVC94K0pqQzQwTS9uZStaMGFBWjcvai9PQ0dySzdET1RU?=
 =?utf-8?Q?bVFBsYmi+pHUgjwH+qv9aEuZ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66630078-5c72-4e2d-9fac-08dd3c5ffc70
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 10:15:11.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL59JgUAdq5prgOsePO95hN1gcJJa7KQpLc9NOnd9Ac3gsvsdr/R9dqIGXJmvBjDYTvOxwwrnOc4feBt7BIpHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736


On 1/23/25 21:04, Dan Williams wrote:

<snip>

> xa_for_each(dsmas_xa, index, dent) {
>>> -		if (resource_size(&cxlds->ram_res) &&
>>> -		    range_contains(&ram_range, &dent->dpa_range))
>>> -			update_perf_entry(dev, dent, &mds->ram_perf);
>>> -		else if (resource_size(&cxlds->pmem_res) &&
>>> -			 range_contains(&pmem_range, &dent->dpa_range))
>>> -			update_perf_entry(dev, dent, &mds->pmem_perf);
>>> -		else
>>> -			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
>>> -				&dent->dpa_range);
>>> +		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
>>> +			const struct resource *res = partition[i];
>>> +			struct range range = {
>>> +				.start = res->start,
>>> +				.end = res->end,
>>> +			};
>>> +
>>> +			if (range_contains(&range, &dent->dpa_range))
>>> +				update_perf_entry(dev, dent, perf[i]);
>> This is checking if range contains dent->dpa_range.
>>
>> I think it is just the opposite.
> This looks like an equivalent conversion to me, what am I missing?


I guess I was confused with dpa_range in dent and assumed that was the 
full device DPA. But now after studying the code in more detail, I see 
it is right ... but confusing :-)


If I'm not wrong again, that range_contains should really be ranges 
being equal, what range_contains does also cover ...


It would help some comment explaining what the function is doing with 
the information coming from two different sources, one being the device 
CDAT, with potentially performance numbers per partition, and the other 
being the mailbox GET_PARTITION_INFO command.


Anyway, apologies for the noise.


<snip>

>>> @@ -567,6 +578,9 @@ static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
>>>    		.end = dpa_res->end,
>>>    	};
>>>    
>>> +	if (!perf)
>>> +		return false;
>>> +
>> This change seems to be an improvement or hardening. Not against doing
>> it, but seizing the change, the function can be simplified using the
>> parameter without any local variable.
> No, it's not pure hardening, it is actively avoiding NULL pointer
> de-references introduced by the new scheme to not track empty
> partitions.
>
> I.e the new to_{ram,pmem}_perf() helpers return NULL when the partition
> is zero-sized. Previously this code path would do range checks on empty
> partitions.


That's true.


But I do not see the reason for using that local variable that I know is 
not related with your change.


<snip>

>>>    
>>>    	if (!cxlds->media_ready) {
>>>    		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
>>> -		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
>>> -		cxlds->pmem_res = DEFINE_RES_MEM(0, 0);
>>> +		*ram_res = DEFINE_RES_MEM(0, 0);
>>> +		*pmem_res = DEFINE_RES_MEM(0, 0);
>>
>> This is a good example for the discussion about the  patch hardening
>> resource_contains. The initialization seems fine but IORESOURCE_UNSET
>> not used.
> To the contrary, I think these changes are an example of "updating
> resource_contains() to check for zero is a band-aid that does not fix
> the root problem".
>

I agree, but it does not preclude some resource initialization as you do 
here not containing the IORESOURCE_UNSET flag and some other code 
triggering the same problem I faced, so the hardening of 
resource_contains still useful, IMO. But I'll tell Bjorn Helgaas that 
patch is not required anymore for CXL leaving to him the decision to 
apply it if he considers so, following the concerns you expressed there.

>> it could be argued the resource is set, but it is a zero-size resource
>> leading to problems in current CXL code.
> I challenge you to find problems in current CXL code after these
> partition reworks.


That's an unfair challenge ... you removed resource_contains ... :-)


Let me think I got some credit for that after my heads-up ;-)



