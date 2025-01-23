Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F20288A2
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647391; cv=fail; b=GEj8SfytC4kkmStgmeY2UIcXhddCX179Psj77GXUEB52mc/jIZ7g1ATgrb5dGCORadZzYzxYZ0NuIa0F95KDPYADanmaN57LNn5C4TkrLo3cvYtQ5RrvaOr91J/PJBQ3v1jDH/Wafd/nk+LWa5ij6F6PZsUhuhAQ7NOCgLlpb80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647391; c=relaxed/simple;
	bh=r9p5Ge5e8l9AyCVTZAfAMgIJ1E2P/bkrmBiKf3f2a3o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KDQG7ljQBG6+JgIyejasMEA0ww/1wZunulp9oMkkpDDMeClixT4ZWkc+K/GbtY8hVIfSxzKMZzMmaAcdUGuurtoIZsZ3V6MmxrqV8xEywW78q2Jrbq+CA6yuIXZdeEWRJZUKtfhl4u4N8nctzY1nl+5a6IxCZWRmiaRYiFiyRqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gq/Q9vew; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gq/Q9vew"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Why6JRFY2qzzt49b1Mpi/YtJi7605SyXfC1eAcqKsiP+9hBh8axZIe9QU+VWKyUVhCjR7JJ8NTOufLAEAJ14JA2RabkOZX8WsHES8SOST0Q+J5YS9XmgFp7MbrdhVsItmqEM0ID26oNmywDqIVD/Ze5rWBy12wPIGcPFfv5Gj3wi8arQSNRZvJ6Cx1Y/HK6wja4bRLtCpnOfgxeocLYhPeJd6X9Z9Xywxdsf/xq34G8cH/nE054tkiPmw+XObGTH7O0RRCnrOabGkPYKsxq1SiIO9XFVWMHlgnI759MhUzcFWXpclvXouCHxF81k1M7wvBAOSY/jOBzsp7QzJs+5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1aronFzF2d8PfoqZ8JdyTal6mcp7UakhAP+nqkkDvQ=;
 b=y/6TlqR089a8WrCDbSmj2P67KChEMIcLRZX+9Wsq6Nd3OZfe1fO5bAx06M3Od3b7uHTpLZnGZSodUC7vACFvzOUGNBkmmkWTO+4QDn73m7P56AHKnaK5dlNbpxqf+EL3bKQeKKwdKDiXXZbIifJQnxaqhr9m7/to2FIuCc1v7EpmiLOUobPmRq8EWSaGoQxmIny3rWe11b3rDaJca1Ol9D+dleSG5wVnN6a1j+iPbVCs4KHy4ixLvVN7/KU7cgiBgX9OTOr63IdFuEKBCw/izbrWkI16ybfYMiIoAKpD/C6OCGmXFm34GwhsqfoHZMucMobfwS0ecmWexXlEg70Fhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1aronFzF2d8PfoqZ8JdyTal6mcp7UakhAP+nqkkDvQ=;
 b=gq/Q9vewS6EnnxuRkVjyqqGvHgxkMBi3//1qHDrEQg5ijne/JNz3oYUS7lmHdjyNE2Qhfhd8NfBoFneFlT6gIiOi627U/rUQvjI8I3JWX5MWQBDJi765ZNGB5FRTGicPQ0AnOTDVecBbHUJa8OL5TTcLvVbCZVFrKhgO4hCuyE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 15:49:47 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 15:49:47 +0000
Message-ID: <5067fda1-c2de-4a20-9025-ebdf90ebba8e@amd.com>
Date: Thu, 23 Jan 2025 09:49:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
To: Fan Ni <nifan.cxl@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, alison.schofield@intel.com, linux-mm@kvack.org,
 gourry@gourry.net
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
 <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com> <Z5CKN57paDmGJH9A@gpd>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <Z5CKN57paDmGJH9A@gpd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:806:6f::23) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 88607533-087f-4fd6-60da-08dd3bc59048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmIwS21kR2ZuNXp3ZHlEM3RrQ3grRlJCY2liMU5sb0JoSWEzVVovMFIvVE1a?=
 =?utf-8?B?L1F6VFpEUlNvenFhd1Yxd1ZWL2MrL3huaUlnamxJc0YycUV5Y3QydDlLbTNH?=
 =?utf-8?B?NHlsVXBRS24wRHU5OVRZbXkxSUNONGRFSkdjbzUzdzZyWXZUNGkybmlXMEJy?=
 =?utf-8?B?RzJnazJQT3NENTYrWnRsOWYwd2kwK1pod2Y5RWl4d29ZcUN0SmlveElWSzhj?=
 =?utf-8?B?ZWIrWnVVU1Z4MmZmT09VSnhnejhkb1YyeHVoUzlWUWNBZUZXbzlENG5xS0dk?=
 =?utf-8?B?UXRyT2o3UUZnYnJvbENMVmVoU3ozVCtMNVQ1MnBVVnhTd3ZCREZRelRuS1Z1?=
 =?utf-8?B?M1BJTFQ3RCtkbkZTM2hvZ2FFT1ExSTNYdVZSZDNEZWtmeW5UdkZSSHd4QkZC?=
 =?utf-8?B?WmJ5RUVtSlVnV0kxdCtqVVM4L3BZMXZLMGFkaElaT1pQcVo5TCtlS25YMSts?=
 =?utf-8?B?WkhGU2huQlRXZjR0SnEvZjRWVXk5TzFqU0ZYQzNBYVJ1ZVdwVmR3ODBpNmN1?=
 =?utf-8?B?NXJTd3NnNEdxcU11UEhXWHNLclkxZ0N0UG45dUNTVyswZHllejdyemVnZlE0?=
 =?utf-8?B?SC9RZCttSEIrK3RiMHdoTnd1V2hwMFdOZDZwd3dUN1VlL3dXeVRCOFBFYXVh?=
 =?utf-8?B?TituNDNKbjVOQ2hLU09JSGdFck84cXN2SHpKaEJNTFl2dXlCMndFUHZYakhl?=
 =?utf-8?B?QzE4Z3p5ZFhaT2U3eDJjNXFsRm5NcTVWbDBnb3BVQnRSUEJqZHhlRHB5Sita?=
 =?utf-8?B?RUxSL0hwTVdTcThvWkZBRHRlcWtOMTRVcGl4NGVtblV0YThiZGwwMjgzN1R3?=
 =?utf-8?B?V25wbXMvbUdIZG1YRG91M29UV2Q5ckNiWjhpaDVGMUtuYnpuMjA4VmM0QUZh?=
 =?utf-8?B?eGlidVhxVXlINU50TjdxZjE4Z0MyNmJuaHUzRnhhUTBOUFFXM3QrZ2IxWGI1?=
 =?utf-8?B?eTh1ckc3VllJZ3I3S3crS2tqQjRxVkdRL1JubENEZ21zb0JDUXB0eG16VmxK?=
 =?utf-8?B?RlprZFUvc1RTUDk5cXptMlk1QkRIZHcwY2l1b1BVODhuQ00zejRtTURJSnk2?=
 =?utf-8?B?cW5QMkFJUkhFcFFhSzJER3ZGcHZaT3FMTGxmVDJOaGtPWjBSblhycXd6Lzk2?=
 =?utf-8?B?NFpucHpEcDFLdnpFZFNVYzV2WFVaaEpsREZIZ3VObnFvN0llV1ljdFpING5n?=
 =?utf-8?B?OGRWZFNDS3ordnRzb1VVWms5NzhHeEFPQisvVjdnYXROT09OKy85bnc5ZEp2?=
 =?utf-8?B?TzZtaU5qdUZpVzdmcWVDVm5KMFVtcitKWm43Tmp5NlNpSUtubnFlaTQyVVBk?=
 =?utf-8?B?NEFtcGdUdWtML0ZHRisyN05KTi90RjMwR1pyQVFGTFl5SjFvRW1xSVdoa1V5?=
 =?utf-8?B?MkdTakgrMUpVOUNoYnpmbVJpRmxrVy9ZZnpCZU9xK1RGRjFHTmNpZ3JSd0Fl?=
 =?utf-8?B?OGZhanR0YmRPTVI5VW54eDV2aFpzeUgwTzBXTkt0V1pRMFVJR2NCTGRFd29K?=
 =?utf-8?B?Y0YrZko5amJESktsSmpQTGhVVWUzTWxaZlBXcEg4ZStpaFgwZjR6OHYwdHAw?=
 =?utf-8?B?dWxVMnV0T1FTTGV5QkFwbGJDVXc1STczelUvMWJFV2VCdXBTRGFjaE53QzNy?=
 =?utf-8?B?cXJCZ0crQW96ZnBmUlZXQ0dLdTBCd2VSSk0wbHp0WG1hWW5uSTUwMnBBL1hn?=
 =?utf-8?B?aC9aVVJzU2w5aFFldm5PNUhmek1ZRFQ1MnhvVUoxbHBvNmVOcnJNc0NrRzdL?=
 =?utf-8?B?M2FKZnJrUG5lK0RjMVFhSDE4NEYwSWlkNERiWTc0TS9jbXc4ZXlLcCtHVGxj?=
 =?utf-8?B?V2c3S1ZSVHVwamc0Q0VmNzRrV3B5Q3FqVStpY01BSS9DdWJ2SXprSWNGK0la?=
 =?utf-8?Q?OtxI2+Gy5Lejv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHA5dTJ6M0VvL0R2UEd5Ukk2dzVLM1VWWXZRaHJOczNmcGZPdld0Z29xOHFj?=
 =?utf-8?B?N0JpaERUbmRQcVFqRUoyYTRqZlJxRFhoM2MyQkY4TTNGSU9ndVlleWFFOGto?=
 =?utf-8?B?M3RFTVk0SnlGQ2VEQ3ludzBuTmdSOUVpck9SOEIwNSt6SEhGY0ppWkFjc2h3?=
 =?utf-8?B?eWRQQ2N4N2xzRHVZMzFNSk9JRWdqelphOE9kNjU2WFVodzFCOC8va0V3ZW1Z?=
 =?utf-8?B?ME55OFRWN3VjYXNTOVgvTnc4bTQ0d09HSTJnaVhTNTZpbTVtWmRISnpUMk9C?=
 =?utf-8?B?R1o1dXZ2cmZCWDM3N01tVzkvMjdHUGoxOUJGZ1NLUmR1SjUzTTI4dS9aNW5N?=
 =?utf-8?B?M0tnZGVEb09DTHR4U0IzS0k2cDJYc1ZlSFlxZjJUb08zeXFXNzZZTHZXMVFI?=
 =?utf-8?B?aFNHZXhvSG9CbElEVTAwRW9pZDNJeUZTRnJKQlo5aTNTYjQ0MW5MQUV6QzRi?=
 =?utf-8?B?Mm01ODNURG1IUHloYlRMMStEb2RtYWJpNmh4a1ZpSWNxcmloTmMyOU0yTWhq?=
 =?utf-8?B?aEZ4QnBHaUxsa0ptd1JmRDlUdnpzZzVORjJNVXhiVTc1LzFjSkFKUTZjamQ3?=
 =?utf-8?B?eDQrS0dUbDQ1Mmd4Uy8rZnAraUVLRDFVaGF0OHAzU2REVmdVVXF1SlJTUkJk?=
 =?utf-8?B?Tk5hdzJWMlovT1dqVHdqMC85TU9qT2liTmVFL2RtYWNnSDl5RGdiNjc2MDla?=
 =?utf-8?B?MCtKSDZaclhwZmJqS2tGK09rUm9FeVVmdExCaXVCVzlaVC9WYXFNYVdJTlBB?=
 =?utf-8?B?MmU2cDB6djBmaW1GQ3hrNVBRc2J3amdOMGpJemRrVFVuNURLS2c2NC9CM3lD?=
 =?utf-8?B?ak9hSEE5SUtTb29YaDR2KzdJTVRQZHM5WWZOM0xmRHBSV1EwRlpaVWxzTW56?=
 =?utf-8?B?bDVrTi9Ja2tjMkFUbGxmQ2laY2VEUC8vd1VHT2JoZnNZZ0REa1AyN3poTnp0?=
 =?utf-8?B?Z0xUbjZzblFpNndVZTkrNUd2Z1NRVHFObHBqckRiMEV6WklvelF1cDNhZVRJ?=
 =?utf-8?B?VUtJekplbVRpemIwajlYVkVBc0RFcUUwRVVLNkp6aFpLdXphRFlPZ0VuYVA0?=
 =?utf-8?B?REdpaVFTNk1HV3JsMThnZThzNXFPZ0ZyVStoajR0OXRDR2NNSEJpa0NOMDdI?=
 =?utf-8?B?UU1CN3o0ZVF1dnNNQmQ1N0l3b3VjS2NWWkNwSEJiZUJaK2JNdkEzektPMngv?=
 =?utf-8?B?bEZxeE54STNEVEVPenR6dnpBaDNBam42a2I0TU9DU2hzSFRNNnVjSVZNQkRu?=
 =?utf-8?B?bHBKZHhaaGQxaFNxZFExMFdQcDRQSHFSUHgwSkY5Z0lqN3ZHaXh2eEZXUURp?=
 =?utf-8?B?VENlRG5uVm9QTENVbGUwT3NXZ3g0ajFTTWE5V1BYQnRCbUlxeEcxTWJTRGNX?=
 =?utf-8?B?V1VHVjMrT01iaUtzRnlWZmlqNFduZ3VVK0hvWlV5WUJUQlZ0ZzloYUZPR3Jw?=
 =?utf-8?B?L0tNaVk1ZFgrU3Bid0o5U0YrbjhseElWYmo1cmQvaHhyZW5lQWhWWmZYRVly?=
 =?utf-8?B?YTlyb2FTUlBSRXVnRmNBNnR5dE11UDBvbGthMkNGS3VNUCswZ01ldlc4UEJU?=
 =?utf-8?B?NjZUc2lOdVB4aFpEWVhEUmF0VDRoellDZ0R3K1BmaFJWa3hHMHp2WHJYVHMz?=
 =?utf-8?B?M2FReUpnNjBHZVFDVEZDWWNmclRTR3NHbFRFWFNJWlZuMEJYZTVwVlFEbnlx?=
 =?utf-8?B?dDM1aFMxcnN6dnhURFZKMFd1bzJNbVZ5d2wvNVo1RUh5WngzRTUxeUgwWW1i?=
 =?utf-8?B?Z1dOOHlSckpyYlFxUTd0WGRrYk5hNWRZL1VLQXR0eUY5bzFNbmZDdGl4cEJC?=
 =?utf-8?B?amdrY1FDdkRqR3hIRk1paWxtNCsrbU1TY3ZnK29oTHhZeXdyeGxUWnV6YTlv?=
 =?utf-8?B?WjQ4NGYrMjhUNFBsdmk4R3lpS1Y2WmFCNlJ3YjRDcmtaNDBESlhGRlUyNGxh?=
 =?utf-8?B?Vys3TVZxZDUyRmExNGt5dVk1MUhQZTVWWVRGMU12dG92WkNUdUpDR2c5cU8y?=
 =?utf-8?B?Z2kvaTBsTXVwUXdBU1hnanlQRmVwb0pwWVlTK2dKRHJNUkZFdlc1ZjQ1d3Y2?=
 =?utf-8?B?Zmg0OEVLODRsbTlqaXYxU1IwRThzOFYrTndSYXU5c0F5YVI0YnZSZVRlVGs1?=
 =?utf-8?Q?/GGwu4rDiV23RqcPROhGNbBnu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88607533-087f-4fd6-60da-08dd3bc59048
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 15:49:47.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmrFDW7x+wDPM8d8rKcGleEVYXf+oRl5N44dJQuFG4RZolmfL8njuEBlulernGayFR1mHnhfKuw/tuoKlQG3mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024

On 1/22/2025 12:03 AM, Fan Ni wrote:
> On Tue, Jan 21, 2025 at 12:57:19PM -0600, Fontenot, Nathan wrote:
>>
>>
>> On 1/21/2025 2:19 AM, David Hildenbrand wrote:
>>> On 16.01.25 18:42, Nathan Fontenot wrote:
>>>
>>> Hi,
>>>
>>>> Introduce the ability to manage SOFT RESERVED kernel resources prior to
>>>> these resources being  placed in the iomem resource tree. This provides
>>>> the ability for drivers to update SOFT RESERVED resources that intersect
>>>> with their memory resources.
>>>>
>>>> During boot, any resources marked as IORES_DESC_SOFT_RESERVED are placed
>>>> on the soft reserve resource tree. Once boot completes all resources
>>>> are placed on the iomem resource tree. This behavior is gated by a new
>>>> kernel option CONFIG_SOFT_RESERVED_MANAGED.
>>>>
>>>
>>> I'm missing a bit of context here.
>>>
>>> Why can't we flag these regions in the existing iomem tree, where they can be fixed up (even after boot?)?
>>>
>>> Especially, what about deferred driver loading after boot? Why is that not a concern or why can we reliably handle everything "during boot" ?
>>
>> That's a good question and one I should have addressed.
>>
>> The goal is to prevent the dax driver from creating dax devices for soft reserve
>> resources prior to the soft reserve resources being updated for any intersecting
>> cxl regions.
> 
> Not an export. Can you explain a little more here?
> What is the problem if we only flag the resources as "soft
> reserved" in the iomem tree without creating a separate tree, and
> process the "soft reserved" resources only when needed? 

The issue we currently encounter is that the dax driver consumes these soft reserve
resources and creates dax devices for the soft reserve resources before the cxl driver
comnpletes device probe and can update the soft reserve resources to remove any
intersections with cxl regions. We do not want these soft reserves consumed prior
to them being updated.

If we were to put the soft reserves on the iomem tree we would need to have the
cxl driver provide a notification that it has completed updates and others (i.e. dax)
can them go process the soft reserve resources.

-Nathan

> 
> Fan
>>
>> During boot the dax hmem driver walks the iomem tree to save off a copy of all
>> soft reserve resources. The dax driver then later walks this copy to create
>> dax devices for the soft reserve regions. This occurs before the cxl drivers
>> load, create cxl regions, and update any intersecting soft reserve resources.
>>
>> To prevent this the soft reserves are set aside on a separate list during boot
>> so that they can be updated (if needed) and later added to the iomem resource tree.
>> The dax driver is then notified of any soft reserves added to the iomem tree
>> so that it may consume them.
>>
>> Hopefully that answers your question. I'll include this in the next version.
>>
>> -Nathan
>>
>>>
>>>> As part of this update two new interfaces are added for management of
>>>> the SOFT RESERVED resources. The release_srmem_region_adjustable()
>>>> routine allows for removing pieces of SOFT RESERVED resources. The
>>>> the merge_srmem_resources() allows drivers to merge any remaining SOFT
>>>> RESERVED resources into the iomem resource tree once updatea are complete.
>>>>
>>>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>>>
>>

