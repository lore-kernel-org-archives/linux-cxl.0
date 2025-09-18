Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC165303A1D
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226572; cv=fail; b=jp9VuzdHIiMQtVgFX6T+gijjBnZT2n6l4vK/y1QWphEuj3MJJsO3hxquatD+/toZb5QwSiLPO/K9nvcN5ChNHvw14KSkWc9xWwxlk22s9NeankbAllpyA/no1RHatg6NaxRGk6m27hJe6xpexMdJfahLBmotV4PFkDj3NYmeyvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226572; c=relaxed/simple;
	bh=1sFnUXvP1HIyKqFK1uBRTTlua1OBjS+qDQdxKk9VD8c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=pqZQ/J+OyGYHPAOev67hgwg67CVCxQZh3A1q7B7quA9rP/R/qDCrBWWN7AO2l9X/9vlLpk2AcksThlQrQKsA/WupRF1yXarLGIM2qblyjBNsBQ3NRsIj/CaQe2P6VpvUONxXBzaGY+EebHrLoIWW4jA3CXEcH6PiGumcVzvTFuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GO98VMGF; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GO98VMGF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML+bv3ICBQPo+1hx54DKbtvTy/asQ/AHdwAfY6j4ruxZn44f1uo3ARFg9JprjPSNeHzWy8TxDZupiml8qGo18F92KL1oHjjW0I8gH9pjQ8fjoMhGWcblfEHx2KKCQyABhJN+2aKJTHN83WyZUCZmFCRPbNHZytK1za6JAR160Jlt+pjsMnUBiIYkZGpWW94AhUTfjK2gxkB4P1Zj8SNBWEmfuVqF4K19xw0bQQT2EUZBDpnSrLF73POLZx86kUk+aWvfFEkwBNssWoXtgUrP/lM0Yua9y8P2O4F38rsLzap9jfancBLErpRLzF1N2sKbWAJcHM0l4clgiO8yn2FEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXiKUggUw8dg7Xkf4cyJbMjOrEpO/Ia9WwhiSGr8GSY=;
 b=E29ojeCIT8z2eavH1+R+Z2FtQ26cLkyr5QFSDAW04OVUSbpLVReijI3uiO1lfeRjUk1bapW5TJLjYzY6x8sotKZzWPwcyd+oWbY2wzkj8R6fSSjPmISMHnIF4ftPDWtG4xjWTKhnjRUP3sPAoBv8h8MIjLK0rg8g780o+8UxekfzSLFCEJB1feqeZXoMkm5q3JLtOa+Iu6Lb5XL2FJfH1LEgnQRVWArBLmjoGBF1ZelGcVOjFimEGd2KTP69fPyBdDwQvHw63q9ptr/Lic2miBKV/JDTMEqPEs+4UBwNUbifJzGA8Nn5A43XwYiiinXzfkT9d2Pc6kLacc0i6yjJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXiKUggUw8dg7Xkf4cyJbMjOrEpO/Ia9WwhiSGr8GSY=;
 b=GO98VMGF930pl5FZ87SMJ/gpGMRGkCu6jbnrQW1RJuoRBpx/BF+t7WqvzMTOzBgJmAKNn9mDnt2O5tzTpcD2u44DYGxboLqRP1tBCg7HzrvJJ5/pS5vpZJSzXDnGYYXRfx5H00AjiBlCDZVxmNDQkBGafGgMuM49uMzovUeEdBE=
Received: from BYAPR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:c0::32)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 20:16:02 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::6a) by BYAPR05CA0019.outlook.office365.com
 (2603:10b6:a03:c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Thu,
 18 Sep 2025 20:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 20:16:01 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 13:15:59 -0700
Message-ID: <eb67da64-b848-495a-8ffc-4a70f0b28396@amd.com>
Date: Thu, 18 Sep 2025 15:15:58 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [RFC PATCH 13/18] cxl/cache: Implement Cache ID Route Table
 programming
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-14-Benjamin.Cheatham@amd.com>
 <9e075ab1-5a5a-43da-a2a2-6af65f4ba935@intel.com>
Content-Language: en-US
In-Reply-To: <9e075ab1-5a5a-43da-a2a2-6af65f4ba935@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: 0863690b-9c4c-4bda-f858-08ddf6f03024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkJRaU5sUlIxTm9xNDdkYWlOOU1zZTR0U0g5cHFRZGpvRDBTOXk0NDdLeHFK?=
 =?utf-8?B?MTl6ZXhySHVmcGpxQU9OcytqRy80WjR6KzVLOEl0VmJMckNiKzg4MkFnakp3?=
 =?utf-8?B?RzFCazQxdUtmUFpZNG5lNnJSdi91M3JqSFc2RVFUajNyR0h3L0dRaU9HZzVy?=
 =?utf-8?B?OWNvTVI4elRyOEtERGFjeXBhbUF4S3d4MHI5dUNLcWc1eGR1OFB3MEJKUC80?=
 =?utf-8?B?a0ZLNEJ5c1IzRDRYcXgzekFYTWhjZFlrS2lKWkttRE1pSTdicXdZNzhTbnhG?=
 =?utf-8?B?MlYzOVBqd1pBbiszekRLRUtSM0hzVjh5RXRvYkRPZGpZNm5OMm80amVmS3Aw?=
 =?utf-8?B?T2lsSE85S3g2Qm9xdVJHQmFPV2dXOU5JNGtLU1N6TExJSE5TT2VRMVlGUUtU?=
 =?utf-8?B?anVXWW9HRFJZdXl1NzBWM3lRWWdwV3Blb1F2ZkJEOW9qZ0Q3bVQzRTdUNWNE?=
 =?utf-8?B?RnVmWmpPTkFqOE1STGxhZFd0aDlhVDNTSEFFRVJocVozSk1WOVhoVmNkOE92?=
 =?utf-8?B?aUdBa2FuOGNqK0pkcnFlS2lLdFZvTVFaSlpHeGhRRVdWRVF0VWdoUG5NTkY1?=
 =?utf-8?B?VkF1L0hQRUpERkxBekVRKzkzUUNkZXFGVXhGSjhvNHNJanlDSk1lUVFMb00v?=
 =?utf-8?B?V29hOVlkWm96U29TOVRDWGVoM1psbmJUUExSUmZ6dEVuQWNQSitNdW9FR1dP?=
 =?utf-8?B?ZjJXZFlLS3d3UGpmUUZCaXdLTlA1NU0yVGJaL0hjaklERWVzRWpLTmt2UWFT?=
 =?utf-8?B?VXMzVmVTQkZVYkJ3ZXJ4bzQ2OG5RY201c0VyWXVVSU9XWDNhMG1TTUVIVGVL?=
 =?utf-8?B?c2hXRWhhYmtOSWRuSXJ3Yzl4d01jMlZHMG1oUVQ3WlpFTFR5eG4ySllxUXZN?=
 =?utf-8?B?WnY2Z2toR3FuM2VmbmxIV1ljQkRNOWFVY0dWZWJGVm5Ia3o1M1dUUTh3NWx4?=
 =?utf-8?B?OTYwRFljZU1jZ0Rqa2Q1RC9lU1U1QXFCVUhWSFhrU2hlTXV3OHdiUlJuUmxv?=
 =?utf-8?B?YStGZThvU0NjOFhkV3N2UmpZcThUbUtiTVEvYjJ1ak94ZmRHZmhDRGZkc0NK?=
 =?utf-8?B?dk5TK21nREJrUkNNazlaZkx1NWZxZXdXSVlidGYxS3JvWWFlcUFSVjdvN0ZQ?=
 =?utf-8?B?WGN0ekp4d1lVSDB0eG9LbzZ1U0c2WEdRdVFKeGZWUmhoaktEcWNIV09nenhC?=
 =?utf-8?B?REQwRDBPMjU4VDRVd0hzOG1uVTJLdXByU3ppNnI4Q3VlNU01Y0QxN2NPbjdy?=
 =?utf-8?B?ZTFaMG8xeC9oRmY0TUE1eGIvNTFxRk5zc0U0VFg2Tmc0UUpXVnJuSjNkQmRk?=
 =?utf-8?B?L0d0elFsaExudDFpSTZUckFYeDRaUGlGQUJjbXJqTGg1bVpQclR2Z28zYzlX?=
 =?utf-8?B?N0dLQm81NnFVcTYwMnI1NWY1RHRUS1hwZlBnVGwvQlJhRE5jUVNHRFZEYmlJ?=
 =?utf-8?B?NHk4RVNESGs5U3dKampraHlZYkxSelVJY21qZWtjMGk5WjlBcVcraWJ3ZGdZ?=
 =?utf-8?B?Ti8yMkttZklFUGRndXpFK1Rtay9QcUVSYzZEcFA1VUhKQWljT3lNVHhnbmtm?=
 =?utf-8?B?N3JnTkxFdjRxUUVTd3VON2lxUlFoSmkvSVFHb1h5WXFsUTNQZFV6TGZjbjRK?=
 =?utf-8?B?bnB0SVVlWEgwS0N5V1Mxb0NNS0pzcTIzQUNPQjBVYWNRazhSZGdXRGRqTlFF?=
 =?utf-8?B?TkFaWmQwNUpsTi81ajBtZjFtUTBXUG1la09OV000eFVSMyt6SlQ2U0dkanBS?=
 =?utf-8?B?NTl6N0pFazhveVBwYzQ1ODZTellYQXdKS0xwdDh2YUswT3oxUE9wNHcyeEV0?=
 =?utf-8?B?RVRQYXZnUmtXS2NFTndDazZVS25Ob0xoTlZMb0NnWVJ1b3o1eGRLNnJKaCtu?=
 =?utf-8?B?dUhZQ1FJdk1Lb2JUWHBSY0g1NXV1SWlDTFNkS21IaDFFSnlUQXNUUXFuN2tM?=
 =?utf-8?B?bnJlNklCdHdlcUcxMGNEUys0WlJLLys1NDQzSW0zUmtUY29UeWE3WmJCdy9W?=
 =?utf-8?B?QmIwVk5PMTVuSFg2aURnTzNablV6YVZaYVdYZGN2em9OblkvK25LcU1BQXlP?=
 =?utf-8?Q?ROzCde?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:16:01.5444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0863690b-9c4c-4bda-f858-08ddf6f03024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0

On 9/10/2025 4:37 PM, Dave Jiang wrote:
> 
> 
> On 8/12/25 2:29 PM, Ben Cheatham wrote:
>> The CXL Cache ID Route Table is an optional capability for CXL-enabled
>> upstream switch ports and CXL host bridges. This capability is required
>> for having multiple CXL.cache enabled devices under a single port
>> (CXL 3.2 8.2.4.28).
>>
>> Implement route table programming. In the case BIOS has already
>> programmed the route table(s), check the configuration for validity.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/cxl/cache.c     |   4 ++
>>  drivers/cxl/core/port.c | 135 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h       |  10 +++
>>  drivers/cxl/cxlcache.h  |   4 ++
>>  4 files changed, 153 insertions(+)
>>
>> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
>> index fd2ae1fa44bc..24559b9ba8e8 100644
>> --- a/drivers/cxl/cache.c
>> +++ b/drivers/cxl/cache.c
>> @@ -134,6 +134,10 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>>  			if (rc)
>>  				return rc;
>>  		}
>> +
>> +		rc = devm_cxl_port_program_cache_idrt(port, dport, cxlcd);
>> +		if (rc)
>> +			return rc;
>>  	}
>>  
>>  	return 0;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 26ea22a2638c..f491796f6e60 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -945,6 +945,141 @@ int cxl_dport_setup_snoop_filter(struct cxl_dport *dport)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_setup_snoop_filter, "CXL");
>>  
>> +static int cxl_port_commit_idrt(struct cxl_port *port)
>> +{
>> +	unsigned long timeout, start, end;
>> +	u32 cap, ctrl, status;
>> +	int i;
>> +
>> +	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
>> +	if (!(cap & CXL_CACHE_IDRT_CAP_COMMIT))
>> +		return 0;
>> +
>> +	ctrl = readl(port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
>> +	if (ctrl & CXL_CACHE_IDRT_CTRL_COMMIT) {
>> +		ctrl &= ~CXL_CACHE_IDRT_CTRL_COMMIT;
>> +		writel(ctrl, port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
>> +	}
>> +
>> +	ctrl |= CXL_CACHE_IDRT_CTRL_COMMIT;
>> +	writel(ctrl, port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
>> +
>> +	status = readl(port->regs.cidrt + CXL_CACHE_IDRT_STAT_OFFSET);
>> +
>> +	i = FIELD_GET(CXL_CACHE_IDRT_STAT_TIMEOUT_SCALE_MASK, status);
>> +	timeout = 1 * HZ;
> 
> timeout = HZ?

Will do.

> 
>> +	while (i-- > 3)
>> +		timeout *= 10;
> 
> A bit of magic numbers here. Create some defines to make it easier to understand why >3 and why *10. 
>> +
>> +	timeout *= FIELD_GET(CXL_CACHE_IDRT_STAT_TIMEOUT_BASE_MASK, status);
> 
> Maybe some comments on explaining how the timeout is calculated
> 

The numbers are arbitrary; I just chose a second as a lenient cut off. I'll add comments and a #define.
