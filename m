Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0510167270
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177393; cv=fail; b=shOZSGpLKdoX4RbIIEP1NZq6gVS/yLROU3p6Un3WnTunllaAqjwdashChnJ9zOYvx29n6BodAnJe1rS5ZmbOB+FdetvDqVq5VcjTqI95Wt06PPZZ77XGnWZBGcX04fGOx+HstcKfgElPnuzvnOOL6FfWnxmVgg+zxcRhlOBuk+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177393; c=relaxed/simple;
	bh=skfnU6l7rYchEPxEapvLG/XSgIuU+vFx7PKJqdKT19Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZoshdfFJ9Z4MGOEq3H6gZ5mf/RO2pMDy7FjJ2ZwBLdNgkV6w53wBywH6KckUrmdj09rdcW36tixFeE5IBt1KTG5wWqBFaANW5G4KJxG7HlVLsIfbezsV9Tf7wdA5sHW4pnfNB60JBwBP22cep+XQXZ5PWxPxXUViXhJhgDokBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ak5mejik; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ak5mejik"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec1fgMAigPQvk3C5CO+8nWPs9EFhtt6Gc5qpzdcu/v7hGHZF44lVyDt7ruxKuIjfBM56t0Ei1qflnM9UXMwOVWvFzK9lmWGzs9pe5SrTiOTz0wSjb28+79dpg3JoZUp6vDWrJfehQt/dM4eImhKAlyTCL6HJ+6cas3w+91V4LMRBKIlwAuzoRs3B0PKwOl9mQGylTCgKy6ABc1dYysEfiKURLSVgeQN2FtFNQKEh3VadrTXl0xNJfKa9jK3uBNIhLZLBZ2P+ap4SVdO6WAHAC+4zbS4tPRDphKMTIl02CUmiB96KX3zMc2PyVq8qaePe6GAELYth66z5/IXvvr5H2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIAEEWAQQA51UXWnnmxJAVAFkkPUCBa5j3HPVaRzboQ=;
 b=bAKfMk8S9mNKYE/1BvGLBXLplbyIxOOZhbgrT0quyV0G9PrKZutOUsJno1uTem/KXKqJcFEQrjClMPBtRP9FQGyUnI9qNkOPRbhCh+i6QjK7MAukIYv7v+c4xJBpE2NVPfvh1HtvorvuuKqnuMQgq6Nbrw6LMqE+4vxS6QII7RC+dPavc/z+xz7ABxTtQ5iofPU26mFHJA6Hl1RdVMnyPXIYf1E2bxrTYaxz700+l5PghR+h1nq57DS6i/wj4fd3OyXVbbKkazY3gwwklOC7w/nAO7Lvb2dPVXS2yb0b7S6fnJjGGV/4Y5jRquce7dYdIYrdLmlm5DravGGjjNNZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIAEEWAQQA51UXWnnmxJAVAFkkPUCBa5j3HPVaRzboQ=;
 b=ak5mejikuZpL1j6iDf1xxGSuYm1lgW9+jtJzUrV4ltNWqNJBV9hL7/4eT637HXrN2bXo7v/9pPlU8Ld3mDLv3uJf6TEeCgu+BnSr44jTXsmIeZI4dT/H9DI8WF1CqA4ofzl+N3e040tyvdoEgE6YoaTS5wBcvLws6Dc0CJR/Ny0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 07:29:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 07:29:46 +0000
Message-ID: <709bd377-6f16-fc1e-4c54-29c196a21213@amd.com>
Date: Wed, 12 Jun 2024 08:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 09/13] cxl: add cxl_request_dpa
Content-Language: en-US
To: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-10-alucerop@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240516081202.27023-10-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0432.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::36) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c95be7a-0fd6-45f0-2d2d-08dc8ab16f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THdmdG0rcUZDZWFkVjBzUXNNYUtyMnJwbExObktCSlBpNmhIWHNQKytERFZt?=
 =?utf-8?B?a0hQN04zdHZ0Y1ZPYmpYQnBuQjRMdHkzVVQ4aTAraVdobkhUYUVaeHFmMkoz?=
 =?utf-8?B?UlpUQ0g1dkNZZlV6S1l3djVKYnhzWjZUMk9DbmVtS1ZQdzBKVVRIb1Q3bHN1?=
 =?utf-8?B?RU9kclFxSnBRblltRW95L2hFSnNTQ0ZVMEQ5LzNXd201VDJRNXVIbC96aThy?=
 =?utf-8?B?MThUUVBrcHRDK0FSckwrd0tWNWZ3eVJHdmhOcTgvZmFVRHVaUGdUWmZ0YVlk?=
 =?utf-8?B?TnNpWTZqY0NmN1J1UjROd29QRWhsb3NHeDVTd0VtRE84NlJQbm5XWFJpaHRt?=
 =?utf-8?B?eG1mQmdYcWRJeTJ4T3pvWW50cTZhSDc4MjZXb0x6RG83NmNRd1A5V3FYTDBm?=
 =?utf-8?B?NFd2dnEzSTIxSEhxbDY2SEdKVGk2RDM1UEVBY3FlOEx6dmVHbUtIYlI2bFhy?=
 =?utf-8?B?QWZNa2hsL0lNYndwNk1Dd2l4Q1BiSjZhUVhxU0t2ckQvTjdMbXBZSFFRaVN6?=
 =?utf-8?B?NFc5UXhncVJIa1UzbVRmUWJUS3BEOG1kQUpZVC8vckpwaDc3cVJ6T1BBaGZh?=
 =?utf-8?B?a1JraFo4Y1dYNkU4b3dCZmdxL1JsekdiTS9jVmcxNTgzUU1IQ0xybThYak4v?=
 =?utf-8?B?TXZEdVNFcVJ4MGxZQkp0UVpERmVXZEZLbHJGYW5CeFVUSFU5a1pZQjdVNi9w?=
 =?utf-8?B?TzhoS2VwQlZVcndCc2RTTWsyZjI0VHZBdzFSUWlHMHN2cVNjOGVycmtMSTNx?=
 =?utf-8?B?eXFabW8xY1ZnWDdwenBDTXVnMjZPTU5zQkQ2VWswWEhuL2FaNE95aW83Y0dz?=
 =?utf-8?B?dkVzVE5tMzB3UWVyQXRFbno3R3VzY2pMK1hoRHdReWp0SnEwdTlrZ3hFSC92?=
 =?utf-8?B?RUJDU1o0TVN6NWIwWmcxM1RqRkg5RHJQVWlNb1loT2llc0ZzdW81bU96d3dX?=
 =?utf-8?B?WHUzbUxnL3k1Z3pPNUF1ekpFZi9hTHVhOEdEZW1udDAyczBLUnRtTG9SbEl5?=
 =?utf-8?B?WGowQ000bDRhbDhBdVJueUtLenpYbG5aVThOTzlGaXJBY05uS1NhRDMrZ3Vk?=
 =?utf-8?B?Umh4S00wMmplY3VpNzA3VCtTQW5GNzMrdFEwaFhna1Uyc2ZJU3Q2Z1BRalc3?=
 =?utf-8?B?MlFnaHpETXJJYmhoNTlycWs1QUxiTGJxaHc3VEJhUGJHN1BCK0ZrKy9WYTZ6?=
 =?utf-8?B?eWd0TW9rMkhMaXpEQm94c1RhTWFya25yWUx1UnNmWXlwYU5Qb2pQanVvSnAr?=
 =?utf-8?B?aHFqbU9aY0xCWWdsdWdtOTJQMVRPQjVmM3RHblVEc2RBUnkvSEdobDQ0Uy9B?=
 =?utf-8?B?ZlZmYUdEcEYrcEdXZGpBQWVqM0crOGtFRjJmdWZHR3NwaFB0Sk50VE42VkFz?=
 =?utf-8?B?a0JySHdWYVlodW1uS1BjNEdhWjd6QmtGK3hnZkZIRWRtV3dKTlo5MGhDd0VY?=
 =?utf-8?B?NUlNU1VJMXg4aFFNK3FiSWRvdU9LV1FEQmdVeGdoY0dab01YRzd5UXIzd0Za?=
 =?utf-8?B?UXc1SVdpOXhHL0RKZVFRNWtSRmRtODBWclcrQ2NISmcvR1hhcWlOQlJObWFP?=
 =?utf-8?B?MFV0d2U3a08rZzNnQ0JaNzVLbXVWcTcxdncyRHUyRXJLb1JRRlpXMnBUbHFF?=
 =?utf-8?B?Q2NHLzVDdG9xNFV5QklSc2JLWkRRdmlDNDJsdnRyMEpWKzFaUWQ2NWppTHNk?=
 =?utf-8?Q?rQPwyl0tL7MqLGWOHV6K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sy95ZjlPRUN0amZtbjBYc1dvS2RZQzR3TTdudi9ENHAxbzlheUlza1JlYURu?=
 =?utf-8?B?dkM5Q0t5OG1md0ZvTGpnMVp1a1UvaGg2aG9sWWZmMFRqanZ4b1FyUEE1WnMz?=
 =?utf-8?B?dXdOcjdQNU5obllDdjRQQ1R3anc3V1k4L0h4WENvdUY0c2NkOEtxNWNTQi9j?=
 =?utf-8?B?anBua2hnUkJFamI5ckhheGd4cE9jZ2grSit2MlVESFlkZW5JcEdZVzI0YVJX?=
 =?utf-8?B?ZHpwL1lwd0U1QjN0ZTA4TCtEeVFxWndlOVYwekJ1ZDUreVpqbUkyeGZZTnMy?=
 =?utf-8?B?cmI0Qm8rYTZQRzJVUDJnazdXdVpOYkRKWXcvcUhIcEwzOVlJOXcxays1RTR5?=
 =?utf-8?B?N01ubXZ0MDB3dXk4Zm9TMzBxZjNUS3N5cytpcVBZVnZ3bjBaRXl4aDRZNERl?=
 =?utf-8?B?RGJ0WlowRXRiWEpHSTh1eUt0MWxrRUt4S1lvWE5ycFlQZkRSUjFJTm9xdjBo?=
 =?utf-8?B?Nmt0cENJVng2YnNSK3hQV28wQVJsVXhvWm5rQTFRUGEyRy90UktSRFVUNTNJ?=
 =?utf-8?B?NmlCUVpFTmNmZ2VueStLQzJOMzJySTdua3FvUTUySHYzWUJ6TmRMdkJhTHFL?=
 =?utf-8?B?SkJnb0xLOW5JL3ZNUDdqV2l0VzE5VHVNQlE3cFgzL1FhZEdlS2o0NVdjTTBN?=
 =?utf-8?B?WjEzNDZBZy9tN0pvWit0L2xsQTlrOElWejVBb1lyU09kSkplbmRNRWFEclBT?=
 =?utf-8?B?dWx1aXhaOUg4NmxMbUxhRWlWWnhuZXhRc2pLN3pCUEttNkZVQXNNNkMvWlNZ?=
 =?utf-8?B?RVNlUndveHFNVnlvK1kvUFZBUXZxOHdtSTN1NUdJKytpN2NCb2VsNTl6VTdl?=
 =?utf-8?B?elhHVnZ3cy9SWFh4ZmZYTHF4WWg3ZG41QjhqYlFiZ0JPOVhRVUxGbkNYdzds?=
 =?utf-8?B?Uloydmx5VUxITldMcEFKaUY2WTZQdU9rVDNZUTZRdDYvVE9SWG5RN1RzN2lD?=
 =?utf-8?B?a3Q5VmdHQkxkd3l0UVY5QytrUlhzTlA0bElBVjIzY3VIS2RpQzFQaDQvUHJ6?=
 =?utf-8?B?cHRSMTU5N1JiNmxVbnowYXRBOVRGdVNoL1NScll0ejNhd3B3VFNxS2lsY0Rz?=
 =?utf-8?B?cU9iamViemwybjVJcnJlVVNOTXVZRXRtT3RRdFdQRjkwQUZ3aEcrdm1TL2xR?=
 =?utf-8?B?U1hqaW55RkxoUVlYTS9mYW5sWk12NHA1SUNUOXUxdTkyVWROOUJtNWZXQW9L?=
 =?utf-8?B?VnZxWmlMYTYzOG9yZloxZjVKYXhwcVVxLzI0QnpOOUI4dkJiWllFZm1MWTJr?=
 =?utf-8?B?QmI5U0w1elBUWEQySXFhQWJEN1N0akJDbmxxSGFJMjZUVXpYY25obEpMT1FF?=
 =?utf-8?B?Q2cwMGw2NDdsMForNTlIWGN2TXgrcVU2eFVpVEY1QnJiTlVSb3JaeW9SYkNS?=
 =?utf-8?B?L3dIVFZwTk5HTnNPK1g5ZkppZ0lndE5qS0NwSXNqUDlISDZoNEx3d3laVjN4?=
 =?utf-8?B?SWtqZUM5UnM0TjNZZ2Z0dExxNC96WUhqWGhZa0FuZE9LYjlrMllMcFVhbldz?=
 =?utf-8?B?SU5WZWVCZE80ZU5PMk1rVW1uL2RnQVhiTTFlUStxN2Yxa3pTWEYyZEx3YTlQ?=
 =?utf-8?B?WSt0SDBRcXBJbGZKUkxhaVVWYUlTZHhad2c1SjFtSTRtdVVhRk9hMEYybFRJ?=
 =?utf-8?B?U05HTjhCenhRaGhuTldHN3V1V2N0cjNLd2tpYTc5VWE1Q2ZwTjFnY3diVkli?=
 =?utf-8?B?YkdtUENSM1lMcmY3R3JPK2xUNzRYTElBeFV4dkl3aVhDU3NVNlNLdURrNER2?=
 =?utf-8?B?U2hKVkovQ3ZaWGtIMWJheURVL1dNY2orOFBaVUtTbUFIci9aWDdyWTltelNZ?=
 =?utf-8?B?Q0ZHemo2NklzRWVyV3Jwb1RnbktVdVAvTTNVUm1wR0FaUEN5a3FIUVVDeW1p?=
 =?utf-8?B?c252NXMxejZlM3FEbXhTaHhCbGZZVitvVTBKbkdJc29YUHhDMVU3OHlVS1B2?=
 =?utf-8?B?ODlJcGdnazhMaE5wSDZBS2d0a1ZXRDZZR1VOVWUycmNzZjlXT2tMZVNBSW5x?=
 =?utf-8?B?QjBobjBMZFpzYjJRVXBjN3hWR2xGMjh6aXlPbmtKWVNQL01QeTNuVHpXMDhT?=
 =?utf-8?B?NU00Q0JKbk96TjRmeDVDMENWNlRLelVIYnpDMUV6eFFWUzM5MEw0M0ZzaHZM?=
 =?utf-8?Q?Qp65Zo52zNUl1SlNYV46czIYp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c95be7a-0fd6-45f0-2d2d-08dc8ab16f9b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 07:29:46.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6+DaALYhs5lmloi/SPu7U1VNbDu9bogg1gI5lokIdsP5BTD1kOxWN4dr99pHwbTVLmSrpUchP8pdW7+/yAHQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446

From: Alejandro Lucero <alucerop@amd.com>

Search and reserve DPA given input constraints.


Based on: https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m4271ee49a91615c8af54e3ab20679f8be3099393

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>



On 5/16/24 09:11, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Search and reserve DPA given input constraints.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/core.h             |   1 -
>   drivers/cxl/core/hdm.c              | 153 +++++++++++++++++++++++-----
>   include/linux/cxlmem.h              |   5 +
>   tools/testing/cxl/type2/pci_type2.c |  12 ++-
>   4 files changed, 145 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index bc5a95665aa0..c0a2e2c1ccb3 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -61,7 +61,6 @@ struct dentry *cxl_debugfs_create_dir(const char *dir);
>   int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>   		     enum cxl_decoder_mode mode);
>   int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
> -int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>   resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
>   resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
>   
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c5f70741d70a..6459b6ecde88 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -404,6 +404,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>   	up_write(&cxl_dpa_rwsem);
>   	return rc;
>   }
> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, CXL);
>   
>   int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>   		     enum cxl_decoder_mode mode)
> @@ -451,30 +452,17 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>   	return rc;
>   }
>   
> -int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
> +					 resource_size_t *start_out,
> +					 resource_size_t *skip_out)
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	resource_size_t free_ram_start, free_pmem_start;
> -	struct cxl_port *port = cxled_to_port(cxled);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct device *dev = &cxled->cxld.dev;
>   	resource_size_t start, avail, skip;
>   	struct resource *p, *last;
> -	int rc;
> -
> -	down_write(&cxl_dpa_rwsem);
> -	if (cxled->cxld.region) {
> -		dev_dbg(dev, "decoder attached to %s\n",
> -			dev_name(&cxled->cxld.region->dev));
> -		rc = -EBUSY;
> -		goto out;
> -	}
>   
> -	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> -		dev_dbg(dev, "decoder enabled\n");
> -		rc = -EBUSY;
> -		goto out;
> -	}
> +	lockdep_assert_held(&cxl_dpa_rwsem);
>   
>   	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
>   		last = p;
> @@ -496,7 +484,6 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   		skip = 0;
>   	} else if (cxled->mode == CXL_DECODER_PMEM) {
>   		resource_size_t skip_start, skip_end;
> -
>   		start = free_pmem_start;
>   		avail = cxlds->pmem_res.end - start + 1;
>   		skip_start = free_ram_start;
> @@ -506,21 +493,50 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   		 * already handled the skip.
>   		 */
>   		if (cxlds->pmem_res.child &&
> -		    skip_start == cxlds->pmem_res.child->start)
> +				skip_start == cxlds->pmem_res.child->start)
>   			skip_end = skip_start - 1;
>   		else
>   			skip_end = start - 1;
>   		skip = skip_end - skip_start + 1;
>   	} else {
> -		dev_dbg(dev, "mode not set\n");
> -		rc = -EINVAL;
> +		avail = 0;
> +	}
> +
> +	if (!avail)
> +		return 0;
> +	if (start_out)
> +		*start_out = start;
> +	if (skip_out)
> +		*skip_out = skip;
> +	return avail;
> +}
> +
> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +{
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct device *dev = &cxled->cxld.dev;
> +	resource_size_t start, avail, skip;
> +	int rc;
> +
> +	down_write(&cxl_dpa_rwsem);
> +	if (cxled->cxld.region) {
> +		dev_dbg(dev, "EBUSY, decoder attached to %s\n",
> +			     dev_name(&cxled->cxld.region->dev));
> +		rc = -EBUSY;
>   		goto out;
>   	}
>   
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> +		dev_dbg(dev, "EBUSY, decoder enabled\n");
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
> +	avail = cxl_dpa_freespace(cxled, &start, &skip);
>   	if (size > avail) {
>   		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> -			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> -			&avail);
> +			     cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> +			     &avail);
>   		rc = -ENOSPC;
>   		goto out;
>   	}
> @@ -532,9 +548,98 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   	if (rc)
>   		return rc;
>   
> -	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> +        return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>   }
>   
> +static int find_free_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	if (cxled->cxld.id != port->hdm_end + 1) {
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @endpoint: an endpoint port with available decoders
> + * @mode: DPA operation mode (ram vs pmem)
> + * @min: the minimum amount of capacity the call needs
> + * @max: extra capacity to allocate after min is satisfied
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. So, the expectation is that @min is a driver known
> + * value for how much capacity is needed, and @max is based the limit of
> + * how much HPA space is available for a new region.
> + *
> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
> +					     enum cxl_decoder_mode mode,
> +					     resource_size_t min,
> +					     resource_size_t max)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct device *cxled_dev;
> +	resource_size_t alloc;
> +	int rc;
> +
> +	if (!IS_ALIGNED(min | max, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	down_read(&cxl_dpa_rwsem);
> +
> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
> +	if (!cxled_dev)
> +		cxled = ERR_PTR(-ENXIO);
> +	else
> +		cxled = to_cxl_endpoint_decoder(cxled_dev);
> +
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (IS_ERR(cxled)) {
> +               return cxled;
> +	}
> +
> +	rc = cxl_dpa_set_mode(cxled, mode);
> +	if (rc)
> +		goto err;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (max)
> +		alloc = min(max, alloc);
> +	if (alloc < min) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		goto err;
> +
> +	return cxled;
> +err:
> +	put_device(cxled_dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);
> +
> +
>   static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>   {
>   	u16 eig;
> diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
> index 342ccd5486d3..caf1cd86421c 100644
> --- a/include/linux/cxlmem.h
> +++ b/include/linux/cxlmem.h
> @@ -870,4 +870,9 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>   					   int interleave_ways,
>   					   unsigned long flags,
>   					   resource_size_t *max);
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
> +					     enum cxl_decoder_mode mode,
> +					     resource_size_t min,
> +					     resource_size_t max);
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>   #endif /* __CXL_MEM_H__ */
> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
> index deb5eeae501b..6499d709f54d 100644
> --- a/tools/testing/cxl/type2/pci_type2.c
> +++ b/tools/testing/cxl/type2/pci_type2.c
> @@ -4,6 +4,7 @@
>   #include <linux/cxlpci.h>
>   #include <linux/cxlmem.h>
>   
> +struct cxl_endpoint_decoder *cxled;
>   struct cxl_root_decoder *cxlrd;
>   struct cxl_dev_state *cxlds;
>   struct cxl_memdev *cxlmd;
> @@ -99,6 +100,15 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
>   		goto out;
>   	}
>   
> +	pci_info(pci_dev, "cxl request_dpa...");
> +	cxled = cxl_request_dpa(endpoint, CXL_DECODER_RAM, CXL_TYPE2_MEM_SIZE,
> +				CXL_TYPE2_MEM_SIZE);
> +	if (IS_ERR(cxled)) {
> +		dev_dbg(&pci_dev->dev, "cxl_request_dpa error\n");
> +		rc = PTR_ERR(cxled);
> +		goto out;
> +	}
> +
>   out:
>   	cxl_release_endpoint(cxlmd, endpoint);
>   
> @@ -107,7 +117,7 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
>   
>   static void type2_pci_remove(struct pci_dev *pci_dev)
>   {
> -
> +	cxl_dpa_free(cxled);
>   }
>   
>   /* PCI device ID table */
