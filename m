Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DC20EB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885728; cv=fail; b=QTUUM1sfwlnIz5SwD+QaH/YL7hTKnJQJn50lJ01S5o9EsPr+s/k0zOHgoXlINAzEo7EgtizDAPR5RlJsIsfb/WGTavhsW6Tq4FPWUSKp7Mc216wD94vo/4SGtixTpcRKYgeaKRFX5j6qMGgoUulZ7HbMhTlGPMDMRqvVUU59W7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885728; c=relaxed/simple;
	bh=/DlJZJmyxfRKeH5IK8KsIqFi9X7LfVhxyzY0qVTPTYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L9G1y96YAxEbpTRq8tT1wC0vZ8s1iNVw1V3mQCfg/GGYAgkXBqwiscjjCYNKkV2UbIef3tS5Qme4YbAD1ZLv4yjnqqT8bwM1u8/Npy87CDWfmjAQDo9EaD/a4hhceewauBXznvHOWdILV+SFXMGoYcK533fQOjpuW4yWVKSiLus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OppyLnwS; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OppyLnwS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppT/9PKUSbyqJN1w1l+a6EBCo4MkArT/wc2Gs98r/ZC8QuqfEc8iQqNrqO8FLLvsxMKN3blUqJouSKireb3RaFPD8V7FpIhSuK8kXyDNL4EgqOuqihS0LGmECPyPLA2TREY6F3C89VSCEXvn2Z4u8KVrTaNwx+B1/HL3jZP58wtnseusiBLafh06Q6j6Zbwqi9v0XBwVdR/sDK+oGRpqa1UzVVvQakJyCm1bxy9age9LIghKWpmOFRBO+YtQHyCktRxPQ4K94GX5d3tyjOC5y+GqyWayBQYSFa5raRaVGmWH4c/cec9plzrUPiQscc7Bhc9O6Cnk0TnvSnNWFmDcOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIuo9saTmHCeGZXZG6RH5I2vWx45TXYyY46wsjUjdS4=;
 b=O9sv6rZTyEIc4TRxVGxpCJNb/Xz4Xovd9Pq6oKFCexbcpzzQee/FH1p7g/7MFFpnLWm2MUeh/kyjE4QBGrkB5ZsnvIi1PqkBk0C1/kjeUroeHQLSTt9SX9leLWOU8cuWQAbDnRjNP3hQJJNI9laGl56pXHCbEUdwU1XXD3VkeMmu7cWgCxvd+jSEPYIAMrsZD8aZaza9BYRm+/7MVLgb7xldlXdsrtAQ2iA/L8DKyieu87CMlm0RF6K1FWSnRHeWO/1wStu7Dt4g2E9w5DXbBmECfla4jFF5gatCGf4e54dp+yDJowaCkAIV/XF3KJ3spRYr3lqPvtgcZDsTBB8OhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIuo9saTmHCeGZXZG6RH5I2vWx45TXYyY46wsjUjdS4=;
 b=OppyLnwSIa15XYtJlCrGM9l3O4jlXh68jETV1pJ2WlwnSflkTye5nYZQq1lj9z/zeB9ZiPyvcMP1J0cewESkZYcGK6N2QgT+etxI07aO3pfeYtUlwH/FHS+ifY47oHtylDSimlDYVdCb2fsWxyCmrpfOKMXvIhZzs99TCvh7hHU=
Received: from BN0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:e6::6)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Fri, 22 Aug
 2025 18:02:00 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::22) by BN0PR03CA0001.outlook.office365.com
 (2603:10b6:408:e6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 18:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:01:59 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:01:58 -0500
Message-ID: <6476d7e7-9456-4f7c-b982-b2450ca76d06@amd.com>
Date: Fri, 22 Aug 2025 13:01:58 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/18] cxl/cache: Implement Cache ID Decoder
 programming
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-16-Benjamin.Cheatham@amd.com>
 <20250819162634.00005f0f@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819162634.00005f0f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 9528998a-2856-45bb-b2af-08dde1a5fd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2NjUXVqT01GeHJyTWZWYkloY2VURmE3UnYzNHZkeVUrQ2lBY3VqR1krd3hk?=
 =?utf-8?B?Q2dmWWprd29vUHJBNTFDSnJndlhPeDFLUTNVelhKTmFsZ3NHcTdoRUdBbUdn?=
 =?utf-8?B?dXozMk9vdjk3b2dCQ3AzWDdwUHlYeis2ZzNFWWJkc1ZOOXgwUm53ZXZZQnA3?=
 =?utf-8?B?c1NkOTN4dXVuQmIwcHg3UVpRQnRpa1JIRUZ1cEZJbVNKTkMvUFBmZEpDT3hF?=
 =?utf-8?B?Vm9xNDZBdjYxUHFMTFJLU0JMZmorcllON05HTDVoalhDcXhOT3F2YnowcXMx?=
 =?utf-8?B?dkpzbllnZXZ5S2VrQ2dtakg1Qm5BUDcxL1hYZS9GU2E2cWVMSnpuai8vOGla?=
 =?utf-8?B?QjBrUGdrTGxKSWszd3dDZG1ZYlFpbmFreGhJbjNLV05MdlEvT01uY0IzR2dO?=
 =?utf-8?B?NEUrc1RzSmoxSk5VN2dMVit5aGZmQjh1N2loY3R0aEM0cTFudzg4Mk9INnJH?=
 =?utf-8?B?a0pNOStnQ0g0cC9GVDNMMVBEdy8wajdFNzJWa3VOdTQxT043cEk3UjhlWWpR?=
 =?utf-8?B?ZEQ3YXI2L2RLb3Q5VUxCdU80TEtJVklEVVA3UzBtTmpYS04raHdjWDFGeVND?=
 =?utf-8?B?YlNVSTAvNGt2eHczMEkvQkNKRDJSOCtKUStQVWVLbk1tS2VGb1drWmZEbHpl?=
 =?utf-8?B?anVOQzlpZ2pBY29JeUlKY3B0QzFjcmRCeTVWSnVaT3JLWk1HRHdzT1JuajQx?=
 =?utf-8?B?VlVBdlM5NmEvTjNUZ1p6Y2dCcUZnQzBKQ1NBNkJqWUp4WXlxd0hWL0paUUtM?=
 =?utf-8?B?RkgyRVBXeThMM1BIMUtLL25OdDJkZk5DQ3pIRFF1aUpudmRtZjk5Q0EwYytn?=
 =?utf-8?B?b0t0bVBUK0E1VWxRaE1acGhqQlBFcG9XYUVlejJ6MGFMKzNkeFpBV3QzbjFj?=
 =?utf-8?B?NnRidUtPNExHc0ZCcVlEQVIwemxDUXQ0Z013N2k3TnVHbUtNamlLRzZBdzZX?=
 =?utf-8?B?OFNCbHQyZDdmQTdpeXRJQnFDanZWZUtVR2NDYXBUd0Rsa2hEdExERTJRYnVR?=
 =?utf-8?B?anQvb3R3WGdDRm42dmtxLzFXTUxFdzBSMGh3eXJuNGQ5dkJDVXkxbXB1Ym1t?=
 =?utf-8?B?dzlNYjVsSlpSRDJ0WGQ3aWc0QWdYQmJoUVRnRWRYNkY5V2hkSVJKbllIZW5z?=
 =?utf-8?B?eHF0SXo3aDFpYS9tNkpCZTZCbWRBeE51cmIxVWdVaHY3em1tU0hyZFpsR1Yx?=
 =?utf-8?B?TXUySFB3eG13Y0pBTGlzb2hWK2RjNVQzYVJKWjVvbWFaTkxCMnFXaW5iUlIy?=
 =?utf-8?B?MlVHbW9idDNWZW1VRE9qQjQ3ZWRFVzQ4MVRub0NlMEhCL3dmVFliQlBRNkFs?=
 =?utf-8?B?SXQ2Q3g3dkR3WHFZSU5pd0ljZWpKQjNnbVcyeko2U0RIY01qVU90Vk54aWJr?=
 =?utf-8?B?RHZrczJjWHFqVkp2MnFKWDR4dlZ6ZXlzRkVGZWVGM20yQUpjSlh3MUFZVGZT?=
 =?utf-8?B?VXdZeHBCczROQ0tNS0tjZzFZbzJjZFVBcTdSRXVueGN2bUEyZ0NtR0hWMzl2?=
 =?utf-8?B?YWQ5Y0RGZllxbWpscGhpaHNXVEdGaTJ0dW15QVM5V1hVOVVvNzRudzZ0RVRm?=
 =?utf-8?B?ZExmNlZpVU5GbCs4VmxFK0hQRHZJSXNFQm4vMGVyS3JQTUkxV0dUL2NlQmpG?=
 =?utf-8?B?Ykh0OHJvYTRyVW5zeEdsc1czUkpNL3RLY1B5OHpiZThEMmE1NFpBT2V4QTJG?=
 =?utf-8?B?VHVtNjZCQVQ3TEdBT1dXRTRlQmhXMHM4VTRyVnkvM3ZGY3o5NzlkMXJpb3Az?=
 =?utf-8?B?U2dOQ1hlaDE3ZG16MjZlcFBjUzhHbE9RUG1TdEUySVljbG4rOFMxNUVDd0dJ?=
 =?utf-8?B?RXdFZlJ3QTBHZXgzV0FkeE9qdG1DZTFjcEZ0Ui80dExnZk9FTzRtWUtNYXNU?=
 =?utf-8?B?VmJQSVl0Mkg0YkVVa3VJdEIyaTdkb3F2SFlEc3lWRVNBNXdUWWVtMlptZWtK?=
 =?utf-8?B?aDBCMkoxdTB4azkraTRGeTdGQ0FEbEkzbmdSMHhSRE5sYUNsQ1lKRG0raVRL?=
 =?utf-8?B?K2gyQld1dTZLUk8yK1ZtTlByaERwYnpEQWlHaTdrNmg1L2Zxbmk4bngxWCtm?=
 =?utf-8?Q?EWY1vu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:01:59.3516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9528998a-2856-45bb-b2af-08dde1a5fd6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113



On 8/19/2025 10:26 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:18 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> The CXL Cache ID Decoder capability is an optional capability present on
>> CXL downstream switch and CXL-enabled PCIe Root ports. This capability
>> is required for having multiple CXL.cache enabled devices under the same
>> port (CXL 3.2 8.2.4.29).
>>
>> Implement cache id decoder programming. Validate the configuration in the
>> case BIOS already programmed the id(s).
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Comments from earlier on how the timeout is calculate apply here as well.
> A few other things inline.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/cxl/cache.c     |   4 ++
>>  drivers/cxl/core/port.c | 109 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h       |  14 ++++++
>>  drivers/cxl/cxlcache.h  |   3 ++
>>  4 files changed, 130 insertions(+)
>>
>> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
>> index f123d596187d..fa3223165a18 100644
>> --- a/drivers/cxl/cache.c
>> +++ b/drivers/cxl/cache.c
>> @@ -163,6 +163,10 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>>  		rc = map_cache_idd_cap(dport);
>>  		if (rc)
>>  			return rc;
>> +
>> +		rc = cxl_dport_program_cache_idd(dport, cxlcd);
>> +		if (rc)
>> +			return rc;
>>  	}
>>  
>>  	return 0;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index f491796f6e60..3606ad557bfb 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
> 
> 
>> +static int cxl_cache_idd_alread_programmed(struct cxl_dport *dport,
> already?

Yep. Could probably do with a rename though, it's a bit weird...

>> +					   struct cxl_cachedev *cxlcd)
>> +{
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
>> +}
>> +
>> +int cxl_dport_program_cache_idd(struct cxl_dport *dport,
>> +				struct cxl_cachedev *cxlcd)
>> +{
>> +	u32 ctrl;
>> +	int rc;
>> +
>> +	rc = cxl_cache_idd_alread_programmed(dport, cxlcd);
>> +	if (rc)
>> +		return rc < 0 ? rc : 0;
>> +
>> +	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
>> +
>> +	if (cxlcd->cxlds->cstate.hdmd) {
>> +		ctrl |= CXL_CACHE_IDD_CTRL_TYPE2;
>> +		ctrl &= ~CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK;
>> +		ctrl |= FIELD_PREP(CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK, cxlcd->id);
>> +	}
>> +
>> +	/* TODO: Check for 68B flit mode */
>> +	if (dport == cxlcd->endpoint->parent_dport)
>> +		ctrl |= CXL_CACHE_IDD_CTRL_ASGN_ID;
>> +	else
>> +		ctrl |= CXL_CACHE_IDD_CTRL_FWD_ID;
>> +
>> +	ctrl &= ~CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK;
>> +	ctrl |= FIELD_PREP(CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK,
>> +			   cxlcd->cxlds->cstate.cache_id);
>> +
>> +	writel(ctrl, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
>> +	return cxl_dport_commit_idd(dport);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_dport_program_cache_idd, "CXL");
> 
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 04fde1a994d0..9c475d8c1573 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -178,6 +178,20 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>>  #define   CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8)
>>  
>>  /* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
>> +#define CXL_CACHE_IDD_CAP_OFFSET 0x0
>> +#define   CXL_CACHE_IDD_CAP_COMMIT BIT(0)
> 
> Similar to before I'd name this something to indicate it's about
> it being explicit / required by this device for things
> to work.
> 

Yeah, will do.

>> +#define CXL_CACHE_IDD_CTRL_OFFSET 0x4
>> +#define   CXL_CACHE_IDD_CTRL_FWD_ID BIT(0)
> 
> 

