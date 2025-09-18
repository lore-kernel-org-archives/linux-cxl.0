Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250871E51E0
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226602; cv=fail; b=AntjqdOC9YgG3b9UqP4JjKOFuegTI2Re+KPJC+kF7fqshraySOIeOF08m2I9QeIBvgb+OBW8PA4Uupci7UwOBRbSB8FPTCaNCXwg8Kp+jFA1pHMAanZhbbV0X0gbw1FH2OdS2Oywc+4ZBAln2WKJSxMk0NbPeTBe5tNewLP449I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226602; c=relaxed/simple;
	bh=EZdDvdnKm3wkAE4KJbmJ0DSImDM7gy+PlRRzvqmhJ24=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=SVNK8A52YPCImAoXpDPHwH+1LSPHQR0RJMg8LBqWYvL8lOwt5qhVVMONp9b3PdVxF3L0TwSwftJTdIpUnb77qQcet+sDJawVBoMuRzwiIPgHA2yBCqBiMXuq883B8xX1re3d712TehwT+xAI9NrdKcWIoYZr4tC5Q0BptW33EA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pDer+w1K; arc=fail smtp.client-ip=40.107.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pDer+w1K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6QPw/oUFw9E/2+yBSOnKqt3y81ip6k4jOqtTId9f6/EeS8W9Yu6Apm5GUB1Ad9PvjHHK4VFhuSpqIokyRiJXUlEDCb1F3EWpVDGfSPnPJpWodXWl546OdoyDsl6WmooTxoNvyAHtMipcIdwYWyqb4mIZT8ZMLk8ZsfX+iO4fBCrmaL8NWzKyV28D9JawFfHXzeFhnwPcat77vbufu+qGV+rCUnz9Q2LiXBHWyEE+dL/7BJYoYX2Gthd2WfCTpW9a3APQdF1krqkgarVXVz5utMynMnUjuNNM9MJfxu1qTOIwbbzq4PKaW2pb0NCXQkB0EPm5Cyrakkbfqb/tP8z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsRppgGNqFfzffstd+5SKp11ouS0AxBlQQfYFO0sOs8=;
 b=gCTqz/BBiAxuTQtviBZnzDlik4zoJ22azqT2xOuHS+KAwvXWnFMiezpQunBunN4inyEaVkE+xgVjKm2oLGerSIFV3jTFDq1Wz1HeUDN6rU5rEgTZEJFO7mHdSGrdSeU3rI9gASBlSk4dnHjFfgaGRVjOXcYJgWqMyLjMNE3vTjZR+T9lXF+yKAPHtwr/CwDa8eWs3HKfIkqLWAsmQcBNjBSnYwZDQpQ0Z5T+5lg8K524tdDCMX0AdJWERxXZjBuspnd2v93Jq46Nqw3hnonoUWTT7Qo6m4jJOVoBGPa3lQudBuTnkmYobYT0a+1zy2ws5oNayPERcccrrU9xqLlkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsRppgGNqFfzffstd+5SKp11ouS0AxBlQQfYFO0sOs8=;
 b=pDer+w1Ks0rar9ToC0hPpxUGgOj0KewRaur2Mp6YzwUs4waJROcq0g3Wdip2WZaSVe8QSMT56H4cFt8EADbJB6+aSxd1Ly9LSAvgl7376xhirgp8+qZsb9gYkdQCnGM2x6q2hPYmSyXSbCEeamgbXgMyU3cq/V+G622MFUKoMEM=
Received: from SJ0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:a03:3a1::24)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Thu, 18 Sep 2025 20:16:33 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::78) by SJ0PR03CA0379.outlook.office365.com
 (2603:10b6:a03:3a1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 20:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 20:16:33 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 13:16:32 -0700
Message-ID: <9002a2f5-6319-405f-9fb4-22c841ae0191@amd.com>
Date: Thu, 18 Sep 2025 15:16:31 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [RFC PATCH 18/18] cxl/core: Add cache device cache management
 attributes
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-19-Benjamin.Cheatham@amd.com>
 <29b9953a-8367-4545-a783-dfabbfa488d7@intel.com>
Content-Language: en-US
In-Reply-To: <29b9953a-8367-4545-a783-dfabbfa488d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 72037aa3-da7b-41a5-ecd3-08ddf6f042ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFRUVXMzK3YzSGwvZE9aRFkyeExIQ1dWQzdmMi9ubWprSTg0d01mNWN1dEhG?=
 =?utf-8?B?bDRiQTBxUG4yRnBFMWExWXZSS3Ayd0RnKzBHYjFuVDgrV09kM3ZmdkI0SzZ5?=
 =?utf-8?B?VFpIYWFoTmNKelNZWnRDbEFydmlNajhSSDVyQVNhdEFIMUcwOHovQzZTRVlE?=
 =?utf-8?B?eGpnRnZjUGZnVlE5UEFhYnl6MGNWY1o3ckxabmNlSFRZRy90bXFEMzhSK0JN?=
 =?utf-8?B?bUFFSDNsR2ZVNTM5ZVJzTTdpR3hJRjdRa1hXMWFMcTRNSFNUbUpHcHEzQUpn?=
 =?utf-8?B?azNzUlZZWUYrZ2dOdzQ4ZWE5VmRYcVpaaE8rSjZuVUcwem5GaVF3QTlyK09l?=
 =?utf-8?B?aW8vbzBIZWEwVTZkOU4xMk1SakpsQjBuN3RiQXpXNDc2Qk82RGQ0cUh4Q2N2?=
 =?utf-8?B?cXhXMzlyK3FPQ3MvNGlvSXFKRzlBVWVKWStObjVWT0RjMHFLVGpQMjQwSzVQ?=
 =?utf-8?B?enhjWGF2YjVkRFRDWW1BYXVnelpPOGVTMTRPR250dlN4alYzRmN6ZStsbkt2?=
 =?utf-8?B?am13ZVlKNFlLNWV3Q1hKMTN4QlFZWnhsdEU3Z0JtWUZlM0FkT0g0RFFsNGVv?=
 =?utf-8?B?SGF3TVE4ZXlBYVkzUFNPMkpkT0Z0bE4zMDQzVWg1a2hJQWRKYlQ5TzNXTG5i?=
 =?utf-8?B?UDVBQ01SdlcvU0FiWSt6ZTBydmF5R0xCTEVKZU8zMlBnbFp2VTIwM2RwRVVM?=
 =?utf-8?B?M3pXcFNPUVdGV1ZkaWgwZ0VDWCtvWkMycDVYUTRKQS9WOXBlblNNOW5Bb2k4?=
 =?utf-8?B?MWFjMGdJMkI1alhudTFETk1wcTUvRDRTbDZ5OWpDcmdRVU9rWUtkbkZ4U1ha?=
 =?utf-8?B?TW9HL0NjTlNZMG5aTHp4ajROckdRMWo5VXpQNDZvMUNsOG85WWY3ejJJTFBH?=
 =?utf-8?B?cG04NTN3WGhkZUdpUU1PdEFraGpZMmRscm0xdkYycEYwNHVVU21lcC9mUFZS?=
 =?utf-8?B?RStaVitDMHJPMi94YnV3SUVaZkdmQTZ1QjlEbXpuanZRayt0L1hOVUl0V1Nq?=
 =?utf-8?B?UWxKaTliNGxJRE5UL0FzTXVFbFQvOHNsZlMxVXJ4YWxpa0d5bWpXbGFaM0Fw?=
 =?utf-8?B?K01DWTZxc1FRajFKWS9XdFJqblE3TzF0Vmt5bzJVQ2xyU1R0YnJ2VGdCSWd5?=
 =?utf-8?B?dG1YNnVPVDdGME16OGpYMVo4QUdFV3Z6YmNhNGVXZGZ4eW44YmJhdmxVUGZp?=
 =?utf-8?B?Q1dqUHBuS1NXSktGN25RS1FrT09TWDk5VXZjdjZhM2d0SHcrUzJleTJrd0Rx?=
 =?utf-8?B?YjVUNXVaTVFtN0NwbTFhaVhHdXJsWWM5SE5pbjRCTndERm9EeGlRdEcydC9G?=
 =?utf-8?B?V2FsQm5uZG1xSWtGUWwzUkUvcGwrVDNtRjQvd05wQTNJU3lpYThraURFcTVa?=
 =?utf-8?B?d1BrVWQxYkQxZXllYlV5djJZdTlTTDFTcEhSVk5haWFtYW1hdjIwQzNTa1o0?=
 =?utf-8?B?WFpRd1d5RHhpQW9xSUxpeVFDcEF3YUlPazRkSVVvT3RkREdBaE1zc1lHYXVy?=
 =?utf-8?B?Vm5Ob2dTcUhjMWpUK250TVVBWit4ejh3NUZTeTFFRGxYbUdWSUdNYlBoZm1I?=
 =?utf-8?B?MHZ6b2d5UDBLc2JodGxJVU5LT2dFN3lqdFlsQzJWbCs2TTdwZGJjOUdmODFM?=
 =?utf-8?B?bWZ1aDAzUmJ4OWVRVCtlLytJMmJ3N2RQTTJVYnRHR0o2NmlUSU5nOG1RVWtR?=
 =?utf-8?B?SXpkbHVmbnBZOStFSGZPeWtYdEZGTk1GZzI0VGM5VzNFVmZmdHBlcE1WenVU?=
 =?utf-8?B?ZnBrczNSSE5LQThOVVl3cEkvL1FQcnNDV3ZmQlVrWmNiejYyZGtVWGJLaFU3?=
 =?utf-8?B?clJGYW5WM0NPODhLYzZVZ1ZGeE4wNENlYzh6azhtVHUzYWJqZ0tVb2xkNWxW?=
 =?utf-8?B?QkdneHRmL05JbVJXYmtibm9lVVJXeGJBZlVtbVNTeS94MGNpR0oyZEN1aEV0?=
 =?utf-8?B?QXM2eDNWZEhXSzZGOXRtWHF3ajcxd0pIcXZXSEtUOG9nV2ZicXVZbTl1WTQ2?=
 =?utf-8?B?K2hmdnZrZThSMmw5NTBmUHlxaFFJMCt0Y2djSmpQZWlBb1V2SHIvTVQvNTRK?=
 =?utf-8?Q?4ZecPY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:16:33.0743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72037aa3-da7b-41a5-ecd3-08ddf6f042ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110

[snip]

>> +
>> +int cxl_accel_caching_disabled(struct cxl_dev_state *cxlds)
> 
> why not just return bool?
> 

If, in the unlikely case, pci_read_config_word() fails. I can change it to bool
if we aren't concerned about that though.

>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	int dvsec, rc;
>> +	u16 ctrl2;
>> +
>> +	device_lock_assert(cxlds->dev);
>> +
>> +	if (!dev_is_pci(cxlds->dev))
>> +		return -EINVAL;
>> +	pdev = to_pci_dev(cxlds->dev);
>> +
>> +	dvsec = cxlds->cxl_dvsec;
>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return !!(ctrl2 & CXL_DVSEC_DISABLE_CACHING);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_caching_disabled, "CXL");
>> +
>> +int cxl_accel_set_cache_disable(struct cxl_dev_state *cxlds, bool disable)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	int dvsec, rc;
>> +	u16 ctrl2;
>> +
>> +	if (!dev_is_pci(cxlds->dev))
>> +		return -EINVAL;
>> +
>> +	guard(device)(cxlds->dev);
>> +	dvsec = cxlds->cxl_dvsec;
>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!!(ctrl2 & CXL_DVSEC_DISABLE_CACHING) == disable)
>> +		return 1;
>> +
>> +	ctrl2 &= ~CXL_DVSEC_DISABLE_CACHING;
>> +	ctrl2 |= FIELD_PREP(CXL_DVSEC_DISABLE_CACHING, disable);
>> +	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_DISABLE_CACHING,
>> +				     ctrl2);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_cache_disable, "CXL");
>> +
>> +int cxl_accel_initiate_wbinvd(struct cxl_dev_state *cxlds)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	int dvsec, rc;
>> +	u16 ctrl2;
>> +
>> +	if (!dev_is_pci(cxlds->dev))
>> +		return -EINVAL;
>> +
>> +	if (cxl_accel_caching_disabled(cxlds) != 1)
>> +		return -EBUSY;
>> +
>> +	guard(device)(cxlds->dev);
>> +	dvsec = cxlds->cxl_dvsec;
>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
>> +	if (rc)
>> +		return rc;
>> +
>> +	ctrl2 |= CXL_DVSEC_INIT_WBINVD;
>> +	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
>> +				     ctrl2);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_initiate_wbinvd, "CXL");
>> +
>> +int cxl_accel_cache_invalid(struct cxl_dev_state *cxlds)
> 
> return bool?
> 

Same idea as above.

Thanks,
Ben
