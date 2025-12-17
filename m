Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94828D8D1
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995922; cv=fail; b=jK0vC5/UHHz+TAjGXqBPKywOtht0f5JsYctr61EseKvJs/aZjzD0Y0mRN7OvCvhSOVXRVvcBUVTslDGtsxQtDfQ3iyyJKeNl8KNkAcYMOA0Syp8F5rR4I4Tu5v1+IGQiNDnQ0Fmv2mVpSRxL1aR+TXxuRGhlN5rvkoh20lfOSF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995922; c=relaxed/simple;
	bh=Kz56s/M7EkhnDZXNe1cPKA+UIGUCnseATLT0dtPnQUI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=nGxdG2K1njXPzhTUcdeD0wc7w4aN52/1TiiBFRy+x2PBjbQ9CpjjUKLQCkCsIQUclvvioHlBVvXncWONkxqTTojjiCWQRmC8PodXyWGSxm+k1XzSUkyK8nso99oW0QW2BGMDEGiJfa1FQUoCt6PZ4TZVCx0FwvF//foS4YW3qv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=twgpvwr9; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="twgpvwr9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htjWkbP/qPa1YOXrtTqEq48ZumyaIzP5dWROc+D0euOXFV9uznD5JSwJAUo5AQrCjea5x7+kJLzIGXd7pggPwGHTbn+yOA/YHJ494fzpZFsJ46xgelAivjcqGxlSHjKa9b5fgb3gqCWDB1DZpoby22p5/UADdmNZCxHNuiuYzvhbmT3oG4/ZXI7lnI/YlI3j/3f5cb6komlXKuZUjjHkxps2cud47in3h0R8+vYc+zqoNWfYi6ns4DUWZO4+JkEo1iYFXCoKJla4/emp9pBxMh/SIEElaqIeZEmOubMr2iCY8aFk3REJ/bxzTk4JXzMN0oMFpvjk2UCM75iFqQ6NdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeiJy6mtN8kLeZ1qbgBfH+4FqkTBYOVZMJCKxkg8/GE=;
 b=MkyvoT20mMLBgFUUD0ipWuPHE+1At5FLPQ2HpfIIxsxdqKda0D+KPEqyP3n8IXwRgZFyTnZfrSvVsuMBj2tyFuV+ZLe/PSkK41RkHMl9wbcO2DSw6mhyQkRj2GQpj9aL61p7L5hpM/FhAOkUGpwtDYI8ugHnrCftksIFvMxVzX2MhWRnOifaLtfupqLj4+/KuJzfamIxbUz1ydS92ydm23FkRUlERSaiAp9eQ4K5MinhqOLrf+/ILDge25dRtrBLlIS6/fl3PcyFBqPiET6RYCCpvF3AkZMQrlQP8Qn73mLWPK6F6jlNYgsi+D00TPNdk6ByVunY3jgJPWmJEa6UsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeiJy6mtN8kLeZ1qbgBfH+4FqkTBYOVZMJCKxkg8/GE=;
 b=twgpvwr9tqxVJt6UTNm6pks7d0McEDYMdGA2VlL/tagWDBbbxpZoUAB0F4HUjS2qKDx9A+XM81/XpTtjQFJmnQqxP+DdGjEJfMw4Fb6P512Xse50y8Y4Wy6magxA9FJWD7M88aXqPwIx/rMvcTQGwOCeZysvqTKl3vbIMMtb2rU=
Received: from SN7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::18)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 18:10:46 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::c8) by SN7P220CA0013.outlook.office365.com
 (2603:10b6:806:123::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 18:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 18:10:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 12:10:38 -0600
Received: from [10.236.188.135] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 10:02:45 -0800
Message-ID: <56ccb77b-5fcc-499a-b4e2-aa3979508c6b@amd.com>
Date: Wed, 17 Dec 2025 12:02:45 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 16/17] cxl/core: Add cache device attributes
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
 <20251111214032.8188-17-Benjamin.Cheatham@amd.com>
 <20251217161201.0000067f@huawei.com>
Content-Language: en-US
In-Reply-To: <20251217161201.0000067f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 80118011-a2a5-4559-0dab-08de3d979994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnFvWG5nSUNOWTlBZGVDOXNtOHVzRXZlSDJ6Rk1vZ093VWYyZ2o4dTZ2SjB2?=
 =?utf-8?B?Mjk2eUdhbmc2aUdYSDlXUmtrR0FzUWdlVnlwdHROUDVvS1BWU296dEJ3RC82?=
 =?utf-8?B?T2Z4OFVuQXg4TC9ZSEJjakxDbkVKSXRYQmhrRzNVUFhnQUtrRXREdHZvbnhp?=
 =?utf-8?B?K0VzODcrTU92eUpuY0pFWmtYOElnNGRSMDA3RmRsbWtzTnEva0pEdENXNEcx?=
 =?utf-8?B?dVAzYTg2NXNUS0pMbkJPdlU2RDJQNDV0eE0wNS9pdVEyOEN4Rzg1RS9jUUoy?=
 =?utf-8?B?ZTIvbUQvMy9hRUMyR01UODZxMnd5UlBsbUV4aEkrWGpreXNtekxBMFhLRWtW?=
 =?utf-8?B?SjRRUlFsUzhUSkRCRHIydnN5YlF3aXc0NVZ0MVZ1Y1ByTlIrRHBkMDVhVWgv?=
 =?utf-8?B?SmFEblBhdWNrUGpGZXVva2FHOVpra3dTL0VQUHhITjVZS3FZT1pITHhZMkNC?=
 =?utf-8?B?d1lITC9Uc2l4b0ZlaHBYRFlkcW54K05aM29SWUZRWm5YbnpBWDkrLyszTkxs?=
 =?utf-8?B?MHkrakNhc1hMb05qRE1SYzhYUmlCbHB4bk8wMElIV1ZaM2FUL1ptaUlaRG1Q?=
 =?utf-8?B?NEN1SjY3MWE2Q1BONGJxNFVZbjV5TURMcXN6VmpQdEtNS2RlV1RDUGl3dUdp?=
 =?utf-8?B?VW95N0M4QkNJQUMvZGdzT2J4ak5ocndmcWJFeHVYSGFRUzRpZnRaRjFTZE12?=
 =?utf-8?B?TDU3TlBzeU00b2N1dzJvdHdOYU9OVWlNZFJlcW8rN0c0TXFYYUlYU3pMNHls?=
 =?utf-8?B?RXA5ZStmR2Nja2c4eEVRODhBV3FwUm83aElQVk51RXQyYlRkc0hsdit6STdz?=
 =?utf-8?B?MHd3STR5MTFXMEdVVzNHVTdSdTRyTnJDeVlQa2RkSEt1K01RMjQ5dVRuSlBr?=
 =?utf-8?B?cDNsN2xqcUFCU2tEK1RYVlFZQXU0eXRFbTBtR3p5Z0dML2hCcFFVbTFxZHJT?=
 =?utf-8?B?bkxmUUQ1WmVCVUduY1hKWVorMTRybEgzY1dmRlZZVFIrTXR5bUVncXZpR0xl?=
 =?utf-8?B?My96ZStDK3FtVnpIU2N3Q3pnM2FhNGJnSlEwbFJ5WjZ2cjhHTzVIb3VRVlFG?=
 =?utf-8?B?M0I2WE4rSFFNYmo1bXY3bW50aExyUlliZjVhZFhoSmcrb3VmUjloRU43alFp?=
 =?utf-8?B?Q2pKNGppbWhzNld1aWs2aDdpTk5CUmorNzZWYkluSEUvbEYrZmY4bU9MSUt0?=
 =?utf-8?B?ek41NlNmeEVlTmRIWUpSNWRkR1ZxdE8vS01LcDc2Y1ZxZHNLd3pyYmpzTzhl?=
 =?utf-8?B?Yk45bWE5Z1ZNaGFhYjFrRUs1UHE4ZkYxOFRwZTRlMVgyUU9sYUlNZkh4L1RI?=
 =?utf-8?B?VENFMCswM3JKcnREd2ZZYnZyZ2VtT3pwV3EvT0NYOERCYzFyYXY1dVgyOURW?=
 =?utf-8?B?QWZCc0xEZGl4Y2poOGx4RTJLQ2NmT01HUVB0SXYxdjhUajhEbkFDNWdlTE9T?=
 =?utf-8?B?QksyWFd6Ynl1QlVhSlpGTmNLK1ZHZ2orS3Q4ck9Ib29xZ2JpZGFNQ1BwZVpI?=
 =?utf-8?B?Q2VUKzFXSVBlYUJwelZsWWE5RW0wMVVIT1FDTzNCZWE2d0d0ekpqRVlJTGQ5?=
 =?utf-8?B?NmV5bXMra3N0ZlI0MnJKTTl6S2EvQzVtbE00VjJ2QjUzUWFTdE13eFJHZ2ZS?=
 =?utf-8?B?OUFHWjlFMFlZdTlMU1o0RnF0eXBXZXkxVlBkM294TXphbWlrV2xwUldPSUlt?=
 =?utf-8?B?cFIrKzlGRGxCWHNQQk9ndm5lOFJlWFhrQXBBZEN2eHBJWGxhUmExSit2THBr?=
 =?utf-8?B?SnptOVhmVGErd3R4L0RYUFFWNEt5OTdnUkU4eUtLM0orVWcwS0FHSjBqOEw3?=
 =?utf-8?B?MVhaVFJZNHN3bnpaUUZOMkFCQmlBUkx0VFpIU0x6blhPaU1JZ1pZVVJzWnp2?=
 =?utf-8?B?YkxLa05VSi9VblNodkdwSVJUTXBoTmYrK21xYmQwcjRPdVJsOG5Tb2I4Sm15?=
 =?utf-8?B?ejhqOG55WkJaTm1DVElZL2swUE4zSGYzUHhGM0R6VENmQ29obzdsYTIzMmF4?=
 =?utf-8?B?cDdxbFhFRlJvMnF1YjJ5Tm9tVHFDajB2YXFaYmh4cGk0NVJXRzI1eWdzUVFS?=
 =?utf-8?B?K1NXQTV2eGdFR3lzcGVvdmZuYW9KeVFKUTlydHRnNVFDbGlvM1J6cU9zMEFp?=
 =?utf-8?Q?XujI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:10:45.8562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80118011-a2a5-4559-0dab-08de3d979994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356

On 12/17/2025 10:12 AM, Jonathan Cameron wrote:
> On Tue, 11 Nov 2025 15:40:31 -0600
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add sysfs attributes for getting the numa node, CXL cache unit, and
>> CXL cache size for a cachedev.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Documentation is king for ABI.
> 
> Documentation/ABI/testing/sysfs-bus-cxl probably.
> 
>> ---
>>  drivers/cxl/core/cachedev.c | 85 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 85 insertions(+)
>>
>> diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
>> index 0b7430450b4e..d8bf18ec0579 100644
>> --- a/drivers/cxl/core/cachedev.c
>> +++ b/drivers/cxl/core/cachedev.c
> 
>> +static ssize_t cache_size_show(struct device *dev, struct device_attribute *attr,
>> +			       char *buf)
>> +{
>> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
>> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
>> +	struct cxl_cache_state cstate = cxlds->cstate;
> 
> Why copy it?  &cxlds->cstate;
> If there is a reason to copy add a comment.

It's a typo, it's supposed to be a pointer. I'll fix for v1.

> 
>> +
>> +	return sysfs_emit(buf, "%llu\n", cstate.size);
> 
>> +}
>> +static DEVICE_ATTR_RO(cache_size);
>> +
>> +static ssize_t cache_unit_show(struct device *dev, struct device_attribute *attr,
>> +			       char *buf)
>> +{
>> +	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
>> +	struct cxl_dev_state *cxlds = cxlcd->cxlds;
>> +	struct cxl_cache_state cstate = cxlds->cstate;
>> +	char unit_buf[32];
>> +	int rc;
>> +
>> +	rc = string_get_size(cstate.size, 1, STRING_UNITS_2, unit_buf,
>> +			     sizeof(unit_buf) - 1);
> 
> This reflects back to comment in earlier patch.  Do we care about unit
> other than as a means to establish the size?  I'm not sure they have
> meaning beyond allowing that register to express a larger range than
> if we did it on 64K always.
> 

I'm not sure. I don't think it matters functionally, but it would probably be useful
for debug of cache devices. I don't think that is a big enough deal to warrant a
sysfs attribute though so I'll remove it (and the cxl_cache_state member). It can
always get added back later as a debugfs attribute when someone wants it.

Thanks,
Ben

>> +	if (rc <= 0)
>> +		return -ENXIO;
>> +
>> +	return sysfs_emit(buf, "%s\n", unit_buf);
>> +}
>> +static DEVICE_ATTR_RO(cache_unit);

