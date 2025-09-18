Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20B72625
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226583; cv=fail; b=DCPobVjK14Qp6XBb15jHxvXF5iWx4tjBri57qKAnAqA3kU39Almd1jsO8hLY710DPsKaIF2D3GkDzY6JSGva5F57RoXf0TPSjyhFwL+xOOynsI7Z+N2bCgzLpcPH3hup8KkJUIw/rhe4Ozv6U7rrMGQSK3CYoKMWD8lwdTWfWlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226583; c=relaxed/simple;
	bh=e9d57D95Md70jbDZUhEpx8Ny1g0EgmiT6PGT244Bg0Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Z0bSKNkgG6IBfs1L6JJ+vBYUZ6PrzkbnpRRoIJthaC9UwF6Jaifn1dgquAVR6sRVZYMPiOYqeON68YfSlHdVeJyLbaVLZ+EO/fJ2c5NKf525AAL3TNKoLc6Sq+XodQmoluCAoD52SwKgHohStaVoiqJFcel7PGZPDUnux3z/AfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fgkrhy3l; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fgkrhy3l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfjbWLlCL/nNTD34yywziy9BfvQ0MhTYXVh+KzWNz9EB3lWxWh4iSrS+y13nnJ5mo2zQ3BV1L+S8jMLcFXvsMZbCsl1O70Xe+/hCV3Oia3SSGOJe6NqJUVdEklGm1znWUqxM+/sx7ryq/DLaHd3LjnzMF1gpRJDXvW546qBTErqWG3kN+vWryxIpWvY1g6L2R7zKbuS/gf2vh2oa4+qZCmhU1ht3IhpT6sjQHGkRCOe280QF3LolzmkhkDu4G3/atAEuZsuS8CMGF64AIRfEQV4Jo5w4pGjoaQVYZBp7fX7bvG29Q7crZUA/a7cLfoeCDWyefqBNm7iyJXULMHqPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5keOynnkCtGwlByB4BJst41f8enaDVrbnAJqsIlNi64=;
 b=i7r5rNwqf8IHxsBJnGKTWu8Eltoxd8lNyWam6zHmBfyFb4+LaBdH4DwbbaB7CzMdPkCG5QTdluKIXPGVwzmLeUXOkVuu6GmIStE7vl/OGOB/gVYxNKlaigNMwtfgj8rcjTSHjM/LUxP9QEXDyHmMFPc28Wc7AVIFwbE+v+b0c2upVHuu8l1ebIiEjwaULw6ElP/4nZo4TolCDbgs8Uziy9u201RuC75rrbrRpVXH6JPztk/shBPsQ+8eOJk/j1As0F8EgUrovt33bhSOqfAZpMzrgAnoPUPudSLpDtthon1rT3cCPWSMeesb99fZr9SN9A1YaLzxeqyJK/SbVZy61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5keOynnkCtGwlByB4BJst41f8enaDVrbnAJqsIlNi64=;
 b=fgkrhy3l7nlrOL7TNqWvA66fi9kQTZuddiMoim/u9sE/fAvLdyjYFuPlgHpD0K8B9MrIRz1qTqtZuCvp4nxaZOCk0AX234bWlpcWpjYCFXzOAAN7rv/pcKTJm6XTbTfVycYFjfUvFRj9cqfIPSy3P1HsZUJpqN/uEwwZTRDsXK8=
Received: from BYAPR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:c0::25)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 20:16:15 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::49) by BYAPR05CA0012.outlook.office365.com
 (2603:10b6:a03:c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 20:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 20:16:15 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 13:16:08 -0700
Message-ID: <2a87a0d4-9333-489e-8059-7a0809b7aa83@amd.com>
Date: Thu, 18 Sep 2025 15:16:07 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [RFC PATCH 15/18] cxl/cache: Implement Cache ID Decoder
 programming
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-16-Benjamin.Cheatham@amd.com>
 <34f46935-6842-42ac-867f-bdb6c1ce8040@intel.com>
Content-Language: en-US
In-Reply-To: <34f46935-6842-42ac-867f-bdb6c1ce8040@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f50e6e-2910-46db-5301-08ddf6f0383c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R25OQ3kzWEo3c1Qxb3ZoWXFnQmViWjZGUndmY3JWU1lQNWNGTnJsWXlqOWtT?=
 =?utf-8?B?SGZoVGp2NjV0SkpyRDMwaTEzUDFrUm55OEY3bGhIaG1DWGZuNE9WcDJuRkNE?=
 =?utf-8?B?STRQbWQ0SUNQL2FCVEdwTHhzMGlvbERWT2J5d3crZ2pEdHZMT1l6WWs4VUd1?=
 =?utf-8?B?bmFZOHlLeGk0NkMxemFDL1l6WjZzeEMreEhScThIYmxLMVQ1RDZpWEFVRkl1?=
 =?utf-8?B?YnVCY09tclp1RlIvYkpVOVVQb1g5dnNlNVNuWlo3SjR5SWFjNjZ5alovTnhD?=
 =?utf-8?B?N3ZzaGQ5UWw2N1l2NWtNVU5LWklrcWdrSjZJOExSUWhLUTFzc3E0TUpTRlR0?=
 =?utf-8?B?YmNPYnNFc2o1TDcwaWt6K1FjMENUQTNaYTJCMWJzZHZQRi9wczNNUmdvRjND?=
 =?utf-8?B?WjRjZ1FpT2tadjcwOWFTUlFpSTdHZzEwUmlOdVFud2NLOGo2RERLMm16NjRD?=
 =?utf-8?B?ZUFNakROOW1ITWg4dVVFdHg5MHdSVk1WMS9SY2M5NkYzd1pzcTBtclUzdkVV?=
 =?utf-8?B?Uzk3ZnJDYnpEcGpHR3Y0cmRZVmlGNEdZbWpYemk0TXpINzdnOWJCd0xKTnpS?=
 =?utf-8?B?bk1WN2ZWcHVUTlFvWGxaSnduWEZtZ09mYVRONVEveUlEZnQwL3ZCYnFmTXBj?=
 =?utf-8?B?MGt0TWhKMmlLQlpWRmRoeHpGa1RDSVNXOXFZRU1CMmM5SkhQMi9XUlliT01u?=
 =?utf-8?B?aTFwcFZUVzFjcjhuQkFYRldPVlVUejY4cFhxa1pxODZNa2NPbHZYQjJTY3kv?=
 =?utf-8?B?K0RsWTJpazlic2tZMEI3NUhqNHUxbjRJYzQ1WmhEUmIxYWxaVVdRb3R4UlRX?=
 =?utf-8?B?TVJlZ0kxdDZqSzloSVBlTkwvbWFKb2NBVUltNE9xS1I2WnhMVkVVVUVOZDlq?=
 =?utf-8?B?VmRhNm41SXU3V0oxVVdnMzRLMUppeHYxbGhHM25CTFNsOVRocGg1UHBuRTBn?=
 =?utf-8?B?VFhveW01ZFNiaUxZcWQ2S1VVa3lpTzF3anE2M1ZhUXVoZTVkZXVCcGMrVFJt?=
 =?utf-8?B?Wkp2bEJnTXVyS0VYRkc5SDZkL3NocnlpYXovUWlIbE1wU0dIT1lLRExZWEVZ?=
 =?utf-8?B?bitjckFhbmVSdWFRdElXQXdMSlRCYUZ2cFJQUVNVTlAzOU85N09nY01yaU1h?=
 =?utf-8?B?djhLbVpmN3hCaTdsMTlQaXRKcmlnQnE3SkUwSGVvQkxpUzB0TEwxMGpEMnox?=
 =?utf-8?B?ZHF0ek1BL2piUlhNbERmd1dWNEJmckVFeGpFV0YzaFB3bU55dGxVMCt6T2xq?=
 =?utf-8?B?VjN0TG8zVjFPSFJ0Q3k4aW40NmdicUR2aWpOSlVXdDRlbzAwMjRaSjBSdzFJ?=
 =?utf-8?B?VHpualo5cnYyb1dmeHp6cXJ1aU5uWEJORTl5bjI1bVhWYUNKa0hhTXNCcWl5?=
 =?utf-8?B?UTdFWnBrSDduNDliNTNudHhQeHBNU1FTVjA4Zkc3NXZROUkvc1FiRWJ4YjQ3?=
 =?utf-8?B?M004OTUweW1hQzVVcXo0TUMyMVVFMTFqbmxwbnRNN3hYY0puZDNzWGxFUzFu?=
 =?utf-8?B?bFppVW9UdnRHNm5sMXBZNm1CeDZOKy94WlpxRjBmaUdWUFFKbi9LUUpnOEht?=
 =?utf-8?B?anB6MVN3anhINStCUFlDRDBwL1ZvaWs4ZjlWYXNySWtlYlJxbll0bUl1WGxC?=
 =?utf-8?B?VXZ4ZFZ1dFdSdkxhaTBxYVp0V2U4anVOdW9vc2FtQWFjcXpkTlpwTXBocVNO?=
 =?utf-8?B?Sks2dk53QW1PQ28xL01rZWtRbW45MHptb3hYMEZnTGphdDhmalA1eEJWZkxZ?=
 =?utf-8?B?K3NlcjlLUEhaNjNFdWtKdWRnZ1pFNnFOaHZvc3R1ajcxeUZ3UGNkOTJLcno2?=
 =?utf-8?B?cEMzZ0ZZVHRKR1BrRVg5OUJ4WHYwN2Vob21iTlNDdHk4RWxFMjVVbE9zV1Y0?=
 =?utf-8?B?R3VjKzBudXY1NnBpQWtPNkp3Y0tQa1NzcDFzQ01wZXpUQXJxSnRCamIzVDNE?=
 =?utf-8?B?SC9Md2VBd2hOdnJlRFBUbUhmdFdWSFdyN3NGUG5CYU92amdXQ2FHR2ZmNVpp?=
 =?utf-8?B?b3NFK0RKc1hDUURsQjdXMU1YK05sOG1IcnA5MkI0dmtzMjFwUE9zSHJpZ0Zw?=
 =?utf-8?Q?1ZtkLl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:16:15.1073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f50e6e-2910-46db-5301-08ddf6f0383c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

[snip]

>> +static int cxl_cache_idd_alread_programmed(struct cxl_dport *dport,
>> +					   struct cxl_cachedev *cxlcd)> +{
>> +	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
>> +	u32 ctrl, status, cache_id;
>> +
>> +	status = readl(dport->regs.cidd + CXL_CACHE_IDD_STAT_OFFSET);
>> +	if (!(status & CXL_CACHE_IDD_STAT_COMMITTED))
>> +		return 0;
>> +
>> +	/*
>> +	 * The decoder is probably already committed by BIOS, validate
>> +	 * the configuration
>> +	 */
>> +	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
>> +	/* TODO: Check for 68B flit mode */
>> +	if (dport == cxlcd->endpoint->parent_dport &&
>> +	    !(ctrl & CXL_CACHE_IDD_CTRL_ASGN_ID))
>> +		return -EINVAL;
>> +
>> +	if (dport != cxlcd->endpoint->parent_dport &&
>> +	    !(ctrl & CXL_CACHE_IDD_CTRL_FWD_ID))
>> +		return -EINVAL;
>> +
>> +	cache_id = FIELD_GET(CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK, ctrl);
>> +	if (cache_id != cstate->cache_id)
>> +		return -EINVAL;
>> +
>> +	if (!!(ctrl & CXL_CACHE_IDD_CTRL_TYPE2) != cstate->hdmd)
>> +		return -EINVAL;
>> +
>> +	return 1;
> 
> The function gets messy when it's detecting multiple states. Maybe split it out to 2 helper functions.
> 
> is_idd_committed() and is_idd_valid()

I agree, I went ahead and did this.
