Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA20241D234;
	Wed, 12 Aug 2026 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533306; cv=fail; b=Upy2mZgYKkyf65IbRZwjMT0ysdweGDU0jURwW4NON8uwn+NUtv1FTRpWRZXlBh4NgfzYQxnwIoZ8QMqA77Vu9sVMfB8j8So69Yk/YYDdwG6mkiqvW4gRDdxS2td4S+N1svkMOc9jH3KlWQuGq/xKgDus94TZxY5GA+6ltWvRmVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533306; c=relaxed/simple;
	bh=Xh8fmhbpM2ljNCBoLJ+vgvxsAfj5Au+uvgqG7N1WZBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SVYcgJKPIxFQQARlEPbHm4Buiz0KE61DuOglfcnR9RjxYi+S7N46KkOa+y6uUspwzF2R9JvQ6xVZP+ajMpzT2yfQo9ji39ncm44Frz7wOVW45T6ySHTmx0M2EntBJK8/tcTVjqQTRXQqlZ2Toc8PPm79Hj/7+8JwTSlseoP4JWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WEUKoi25; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WEUKoi25"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRHn0E9K9WSY1IoX1f01P2xr+jjl7DBXmc0k3DLDV8m7d32IXaI+A0BfLLfLOkANBNN8IfNeDFVQ7MDf0aqEzavbVMqgaWuq0waB5YSjdSiTHrI4JrON6Z1M+UMnmNs2C7cEQH3Al+Yj11l0OMnjpNXtqKSg8b8Iyd7LYWuaFsJQo805SHbfe1BDJugXJdlpXaWrSMgei2P5p6rNMpYNTYMZCxmmuUsvVMgrDOVUxkxyFjlrD7CpSwzFpWPbMUihSCYLku85B5AkgnVHYgxHJZfpnphdRjKfg32+Xn24vh6LOOPCew+GOkq7BDWVWdsTyjpaZtaei5L3uHfluDlyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6Dvgeeb9UXh4jSzyoaMFQCSFsKSWHDLabx5X2AY63s=;
 b=quuoh92TORFkXVXld3ts5XVjqJ0YTWrxXqiP+m/wIeXsB9dLfqgqzvO/Kl5wJP5nrEJmeiOuREoi0LzMYu4fr1VdiehI4CywhkDwYAt6XT/nY0U2tzaj9zJRv700yB5/AVyz40F2xDVH/UUH6ekR7WXDAZYdkNq5gp/5ZetRB2EEKQYpOtXPvW++h6bwJqFwX0OtKfqQaMYDtWInynyriUGPpsklL39TCzKpBfqrERAywH0TG8ULE2WWE9xNsjulEHwi/9UzNcfGARAhyYrbgTS/oVHPtFA9gVun99e2ZtSMWeh1zYiEFWv7jA3cbLnIhCcwlTnXekO+leW7rYsVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6Dvgeeb9UXh4jSzyoaMFQCSFsKSWHDLabx5X2AY63s=;
 b=WEUKoi25q1VNYY4FthdCbL4OR1SoiHvtFzA/kj2l2EOZvIX42ytm23imAvUlk/KtYVhe203UrN7/KGLoNCnQla+hYuIVBEitV6L348UXuyColURrW5R4fdzyyN9JxU7rMKlJ8XbnzCB0t9TJBP85En6ijYY4p/grabD6f2Kltvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Wed, 12 Aug 2026 11:15:01 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 11:15:00 +0000
Message-ID: <be3a83e9-8606-4a0e-80f9-20cc8293c009@amd.com>
Date: Wed, 12 Aug 2026 12:14:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] cxl/region: Auto-create a region for memdev
 attach
Content-Language: en-US
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 djbw@kernel.org
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com,
 kobak@nvidia.com
References: <20260805074042.30173-1-icheng@nvidia.com>
 <20260805074042.30173-3-icheng@nvidia.com>
From: Alejandro Lucero Palau <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260805074042.30173-3-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0232.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::21) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 243d1a8f-2a17-4fbb-ec78-08def862f313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|6133799003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Q2sLpxiW9GBnDh4ygWS82xBu0ZScfpG4uCX/woZt3V0gpcici0shO/DdUHvoQPGWSYu0IPz7Psnw3AzpN4lAhTsVWMJmtFKuywSDP3a+DxV3HkL0U/LqqmTi20WjzWdWA/rmlol9cqITJNxk6i41dhp3AahDYkLQl6CXzs796otITJ8SMWmaabYQNxIX0n5zgIjypx1RyV8Jj4PXI6vMStj8lR6gatxN9b1M2y8S/4QcRtVE1K9AmPFNKZ/JqvwXYuPdtK5m0Nbx++5uMgcCJnJWWbvHHHhuYniVPdsOPKsW2S83CU9sQFD6595DwijoyB61mOYIfwrfGSlTR1YxZylz+XDCQw0Lhk+Y5AtupZJ+fD8OpAQAA6U6Mi8xm8f43MbBbuRdsV+fosu72jCXR856uzfNNrqln9DvhE2XkyjrDXRjgjl59uMETbXqUFlKw3jIfkZsN1+PUIwSxLLkz2kGlMmHkDQaAhr83f0L2YJDi5JffZMcwoy1WFJcA6R8wdsn+1DVN/Z8OwjodLSC6kGA51ks8nxY81p5E+hDrFafsRHix7ZPkIMfXYUG4mId+GnJcTPQLgdcxj38uidK+D8Xzrzxk7C2BifyyvlYAzw4+8BVQGd/J8+93wVhjPnSpKBlxLVCrSyFvMFqgB6zG38aUrFPiIzscuGxIJFE4wE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGhobkVyUmF3aG1VcC9qKzF4NHdCSWFnTTNtQ1NyWWN1Q3NpMjBwNE1JdFhu?=
 =?utf-8?B?TGhFa2hEczg5OGUwY1hMc0xWczdGblB1UDJwZHJnRzZlOEZlKy9oN0FNRUdJ?=
 =?utf-8?B?d3RGWGphV3d4R3Y1bFhJNzk0dmVhTkVtOVdVZklBaDRvRDFiZHlkM0FQaWp3?=
 =?utf-8?B?OHZ3ZnVYU2tKalQ4MDBkakx3MnZNVzVXRG5vVFRydmlGdytkN2J6TDBPQjBh?=
 =?utf-8?B?eUF4QXlCb3gwVU1NYTd3NUZCd24weHRPdmVicStET3JhaHZ2TzMreHNBVHE5?=
 =?utf-8?B?bFR2eEp5UWhqanVoV1MrSjRZdy9ERm1oMGlDdVJ1MGIyRkFhd1p4U2twbHdp?=
 =?utf-8?B?Z2s0TFFnZm9EcHBabUdPaDF2U0d1MllqVitrYzZYTVBncFFBVDhaWm1VZnFQ?=
 =?utf-8?B?Uk9oclNPNW03ajZPV3Bicnc2bm1qZEk3T0N6cG5rUEtraithK0pQRzNMbEpp?=
 =?utf-8?B?VFdLOTVBdWkrMW5zcDI4RTdiQjZIazhRRmZ1bTlDdnNmNHJzWFhGOXlkS3ls?=
 =?utf-8?B?Q3VvZTNyWW9kdG44bUZ4VDB6K2pPNzF2MnlkdnpyK1JhbXNtOGU5aEFIbUJ6?=
 =?utf-8?B?NWlZUVFaUVlydWZvY3o3L0N0UnBVejJWR01FUzdmUWo3dDBrVEUzUDE4K2hv?=
 =?utf-8?B?UnJGQUwrV0N2RCtDUmp2OGVGK2E3cmVSSDBVSjA1Zzh0SWpSaTFscDJCSGFR?=
 =?utf-8?B?RlgyWkkxclpZOHBFNlZBcjgxZ2Eyb3RFZGxxdWI4dzZTWGd1cmVWOEIzTjg4?=
 =?utf-8?B?WlRhMklwczhjZS92ZEt0bDc2N0Z5VUtCcFhoMkgvRXhLTEtMcXVHYTJmMFpG?=
 =?utf-8?B?VVB3V0NxU0pkTWg4N2piWFluNkpYNjJwdkpGWWhWZ2YyZkQ1RzdDRjdmKzFl?=
 =?utf-8?B?QjBqem42RFVYa2VGcnlZaTVjOXhlWnNZN21sZlJ4WXR4NEJkcEh2RHlEc1FO?=
 =?utf-8?B?N1hDQTZHZFZhRlFMMjRPcnI4TjNmMlg0L3NldWtFSmhReUlTUkNOL0lBeENI?=
 =?utf-8?B?ckF5TmNIM3V2dGsreXJXNWJydVdxU3VzdkY5Z2lITWlZbzlocWEzdnQxc3Za?=
 =?utf-8?B?dkY2Y3JYMVhWcFJzamRMWTBsZjN6bUxGVVdDeGdqelFIZWJ1UUlqR1lJUlNp?=
 =?utf-8?B?TFJ6UDZsd3hsYVA0MWhRNU15Q1BJYUp0dGJoMkE3eW1DMWQvblV6cDN0RFRt?=
 =?utf-8?B?cHNMb21xUVhwR2RwS2RNSzYyWmdHdWh1U1JZQU42NXhkOTltZDRUTGRkRXkz?=
 =?utf-8?B?YSsvcG1RWnBQLzVPUGE4SGF0VG9DdkRPcUtZbTFOUzQydW12N0NWeDg0aUtH?=
 =?utf-8?B?SEViUUtxaVJPN3ZxTjdWQzBEK2Q4SkJRU01tOWMrU2tOS2Z2RXN1THlFcGhp?=
 =?utf-8?B?Wk0remVhdmVIdmpPcHV1M21MOUkxdkNjVDdOSWRkNCtBT0ZrZURKTWdFbEcz?=
 =?utf-8?B?Z2VwenNQakkydEw2UThPVlBBckZEUnpRVnlOcXJZSUVXNkgwdS9NNDNuVVp1?=
 =?utf-8?B?eldTNzZERTB4T1JDQXp5YlMrM3ErcUJDYjlnQ0tmakxqTmxjOGVYK3A2cFht?=
 =?utf-8?B?K0JpcnV4UDVZODIyVExyUkJhZ2kyc0tNY0FacnlSUmJFbXAzK1pKMDhsbFc3?=
 =?utf-8?B?dXVNT2xkWjBtc1QrM0g0cjZUUXJhZUFYZXYwRHJvOFZ2eWtYNXo0MHUzYWZ2?=
 =?utf-8?B?TFRKMHY1eG5KM3RTYjRwQTRrWHVJSEdKUytFQ25tV0JvU0I4SlJZUFB0NmpG?=
 =?utf-8?B?RUduY3pZTjNKdnQ2Y3JTY0Z2eFFhNmVFNnozYlFVWVZMVUI2RTY2RE1LWW1K?=
 =?utf-8?B?U0xSQXRLR2xGZkJiL2Zxc1RvUFN5bEpwbWlYTlZ6VlFCZ0tKdXN6NW9nZ21l?=
 =?utf-8?B?ZUM1L2FZLzRVa0JXbk02cjBHU1I3TTlXY1dVWDJtS3dTUDAvNi9mUHJKT3c4?=
 =?utf-8?B?ZXltcFBBanlhMlkwcnFqOUZ5QXFCU1RVaGJkcVRXb01qSWdhS0JJd3hRQXBK?=
 =?utf-8?B?dHNScFpIZmN1alpNQjBHdTdNc1I4SlhObWFjQUJWMXdBWXlsSHhVQ3dhTHho?=
 =?utf-8?B?NVBEOC9xN05tNlpaRWNoRnQzSjFITTBGOE1aMGl5UmMzRi80WllLVWNYZUw1?=
 =?utf-8?B?UHkrcjAycUY4U3FRVFlRRm41dE5TSjdkSncyTDF2VlBBdk1Sb3pnOHZsVm8v?=
 =?utf-8?B?SHhXcllLMkNQZWU2R1pnUS9zUmJCQkMvcGJud09EOFF0S0FNRHdTYTVEaS9W?=
 =?utf-8?B?dEl2V2tnTWozN3lscFdEVC9GQXVwY2RwUXhpQnl1VmpEay8zWTZJdHJxS1JM?=
 =?utf-8?B?RDFTOElmUlBTakRlckdyOXJ0eWFGVXdxYTJ5UUNHWUtRWW5yUy9XQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243d1a8f-2a17-4fbb-ec78-08def862f313
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:15:00.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNXi2/b6xJnQWeQoc3VQzOFpGJCF0WrIHbhWgIiGpWiEqNesxTtyunbMcxq99avTgSqiasPjkeK8WHU2GkPfMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

Hi Richard,


Some comments below. Just conceptual ones, except maybe a bug at the end.


Thanks!


On 8/5/26 08:40, Richard Cheng wrote:
> devm_cxl_probe_mem() currently fails when FW has not committed a region,
> even when a Type-2 accelerator has usable CXL.mem capacity.
>
> When no mapped decoder exists, select a pristine manual DEVMEM decoder
> and the first compatible unlocked Type-2 RAM root decoder. Create a
> non-AUTO, single-target region, allocate HPA and the full volatile DPA
> partition, attach and commit the decoder path, then return the resulting
> HPA range.
>
> Use provider-managed reset for partial-commit rollback and unwind
> region, HPA, DPA, and partition state in reverse order on failure.
> Preserve the existing FW-precommitted path.
>
> This support is limited to decoder 0, IW=1, and first-compatible root
> selection.
>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>   drivers/cxl/core/region.c | 312 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 284 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 7fcaddc61180..4ceabdfdd3b6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -363,7 +363,8 @@ static int commit_decoder(struct cxl_decoder *cxld)
>   	return 0;
>   }
>   
> -static int cxl_region_decode_commit(struct cxl_region *cxlr)
> +static int cxl_region_decode_commit(
> +	struct cxl_region *cxlr, enum cxl_region_reset_context context)
>   {
>   	struct cxl_region_params *p = &cxlr->params;
>   	int i, rc = 0;
> @@ -405,7 +406,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>   
>   err:
>   	/* undo the targets that were successfully committed */
> -	cxl_region_decode_reset(cxlr, i, CXL_REGION_RESET_DEFAULT);
> +	cxl_region_decode_reset(cxlr, i, context);
>   	return rc;
>   }
>   
> @@ -427,7 +428,8 @@ static int queue_reset(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> -static int __commit(struct cxl_region *cxlr)
> +static int __commit_context(struct cxl_region *cxlr,
> +			    enum cxl_region_reset_context context)
>   {
>   	struct cxl_region_params *p = &cxlr->params;
>   	int rc;
> @@ -452,7 +454,7 @@ static int __commit(struct cxl_region *cxlr)
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_region_decode_commit(cxlr);
> +	rc = cxl_region_decode_commit(cxlr, context);
>   	if (rc)
>   		return rc;
>   
> @@ -461,6 +463,11 @@ static int __commit(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> +static int __commit(struct cxl_region *cxlr)
> +{
> +	return __commit_context(cxlr, CXL_REGION_RESET_DEFAULT);
> +}
> +
>   static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>   			    const char *buf, size_t len)
>   {
> @@ -4177,45 +4184,271 @@ static int first_mapped_decoder(struct device *dev, const void *data)
>   	return 0;
>   }
>   
> +static int first_attach_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_port *endpoint = (struct cxl_port *)data;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_decoder *cxld;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxld = &cxled->cxld;
> +	if (cxld->id != 0 || cxled->state != CXL_DECODER_STATE_MANUAL ||
> +	    cxld->target_type != CXL_DECODER_DEVMEM || cxld->region ||
> +	    cxled->dpa_res ||
> +	    (cxld->flags & (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)))
> +		return 0;
> +
> +	if (endpoint->hdm_end != -1 || cxl_num_decoders_committed(endpoint))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int first_attach_root_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_port *endpoint = (struct cxl_port *)data;
> +	unsigned long required = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_RAM |
> +				 CXL_DECODER_F_ENABLE;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_decoder *cxld;
> +	struct cxl_dport *dport;
> +
> +	if (!is_root_decoder(dev) || !device_is_registered(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +	if (cxlrd->dead || !cxlrd->res ||
> +	    (cxld->flags & required) != required ||
> +	    (cxld->flags & CXL_DECODER_F_LOCK) ||
> +	    cxld->interleave_ways != 1 || cxlsd->nr_targets < 1)
> +		return 0;
> +
> +	dport = cxl_find_dport_by_dev(cxlrd_to_port(cxlrd),
> +				       endpoint->host_bridge);
> +	return dport && cxlsd->target[0] == dport;
> +}
> +
> +static struct cxl_root_decoder *
> +find_attach_root_decoder(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *endpoint = cxled_to_port(cxled);
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +	struct device *dev;
> +
> +	if (!root)
> +		return ERR_PTR(-ENXIO);
> +
> +	/* First compatible x1 Type-2 window is strict v1 policy. */
> +	dev = device_find_child(&root->port.dev, endpoint,
> +				first_attach_root_decoder);
> +	if (!dev)
> +		return ERR_PTR(-ENXIO);
> +
> +	return to_cxl_root_decoder(dev);
> +}
> +


All these new functions are what v15 and older ones did but a bit 
different. Likely you did look at them, but for what is worth: 
https://lore.kernel.org/linux-cxl/20250514132743.523469-12-alejandro.lucero-palau@amd.com/


My main concern here is what I mentioned about the need for this being 
generic expecting other clients requiring same/similar functionality. 
Although these previous ones seem generic enough, I pointed to this 
specifics below.


> +static void restore_attach_decoder_part(struct cxl_endpoint_decoder *cxled,
> +					int old_part)
> +{
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	cxled->part = old_part;
> +}
> +
> +static int select_attach_ram(struct cxl_endpoint_decoder *cxled,
> +			     int *old_part, resource_size_t *size)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct resource *res;
> +	int part, rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +		*old_part = cxled->part;
> +
> +	rc = cxl_dpa_set_part(cxled, CXL_PARTMODE_RAM);
> +	if (rc)
> +		return rc;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	part = cxled->part;
> +	if (part < 0 || part >= cxlds->nr_partitions)
> +		return -ENXIO;
> +
> +	res = &cxlds->part[part].res;
> +	if (res->child)
> +		return -EBUSY;
> +
> +	*size = resource_size(res);
> +	if (!*size || !IS_ALIGNED(*size, SZ_256M))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static struct cxl_region *
> +create_attach_region(struct cxl_endpoint_decoder *cxled,
> +		     struct cxl_root_decoder *cxlrd, resource_size_t size)
> +{
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	guard(mutex)(&cxlrd->regions_lock);
> +	do {
> +		cxlr = __create_region(cxlrd, CXL_PARTMODE_RAM,
> +				       atomic_read(&cxlrd->region_id),
> +				       CXL_DECODER_DEVMEM);
> +	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> +		/* Single-target IW=1 is strict v1 policy. */
> +		rc = set_interleave_ways(cxlr, 1);
> +		if (!rc)
> +			rc = set_interleave_granularity(
> +				cxlr, CXL_DECODER_MIN_GRANULARITY);
> +		if (!rc)
> +			rc = alloc_hpa(cxlr, size);
> +	}
> +	if (rc)
> +		goto err_unregister;
> +
> +	rc = cxl_dpa_alloc(cxled, size);
> +	if (rc)
> +		goto err_unregister;
> +
> +	rc = attach_target(cxlr, cxled, 0, TASK_UNINTERRUPTIBLE);
> +	if (rc)
> +		goto err_unregister;
> +
> +	rc = __commit_context(cxlr, CXL_REGION_RESET_MANAGED_DETACH);
> +	if (rc)
> +		goto err_unregister;
> +
> +	rc = device_attach(&cxlr->dev);
> +	if (rc <= 0) {
> +		if (!rc)
> +			rc = -ENXIO;
> +		goto err_unregister;
> +	}
> +
> +	get_device(&cxlr->dev);
> +	return cxlr;
> +
> +err_unregister:
> +	unregister_region(cxlr, CXL_REGION_RESET_MANAGED_DETACH);
> +	return ERR_PTR(rc);
> +}
> +
> +static void cleanup_attach_dpa(struct cxl_endpoint_decoder *cxled,
> +			       int old_part, int setup_rc)
> +{
> +	int rc;
> +
> +	rc = cxl_dpa_free(cxled);
> +	if (rc)
> +		dev_err(&cxled->cxld.dev,
> +			"failed to clean up DPA after attach error %d: %d\n",
> +			setup_rc, rc);
> +	restore_attach_decoder_part(cxled, old_part);
> +}
> +
> +static int create_memdev_attach_region(struct cxl_memdev *cxlmd,
> +				       struct cxl_attach_region *attach)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct device *decoder_dev __free(put_device) = NULL;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_region *cxlr;
> +	struct range hpa_range;
> +	resource_size_t size;
> +	int old_part, rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +		guard(rwsem_read)(&cxl_rwsem.dpa);
> +		decoder_dev = device_find_child(&endpoint->dev, endpoint,
> +						first_attach_decoder);
> +	}
> +	if (!decoder_dev) {
> +		dev_dbg(cxlmd->cxlds->dev,
> +			"no free manual DEVMEM decoder to auto-create a region for %s\n",
> +			dev_name(&cxlmd->dev));
> +		return -ENXIO;
> +	}
> +	cxled = to_cxl_endpoint_decoder(decoder_dev);
> +
> +	rc = select_attach_ram(cxled, &old_part, &size);


Previous partition/type selection is likely good enough for only Type2 
auto-creation, but a generic solution for this happening not at probe 
time, therefore not using the attach option, would need to support pmem 
as well ... and the label management.


> +	if (rc) {
> +		restore_attach_decoder_part(cxled, old_part);
> +		return rc;
> +	}
> +
> +	cxlrd = find_attach_root_decoder(cxled);
> +	if (IS_ERR(cxlrd)) {
> +		rc = PTR_ERR(cxlrd);
> +		dev_dbg(cxlmd->cxlds->dev,
> +			"no compatible Type-2 root decoder to auto-create a region for %s: %d\n",
> +			dev_name(&cxlmd->dev), rc);
> +		goto err_cleanup_dpa;
> +	}
> +
> +	cxlr = create_attach_region(cxled, cxlrd, size);
> +	put_device(&cxlrd->cxlsd.cxld.dev);
> +	if (IS_ERR(cxlr)) {
> +		rc = PTR_ERR(cxlr);
> +		goto err_cleanup_dpa;
> +	}
> +
> +	hpa_range = (struct range) {
> +		.start = cxlr->params.res->start,
> +		.end = cxlr->params.res->end,
> +	};
> +	rc = devm_add_action_or_reset(&endpoint->dev,
> +				      endpoint_unregister_region, cxlr);
> +	if (rc)
> +		goto err_cleanup_dpa;
> +
> +	attach->hpa_range = hpa_range;
> +	return 0;
> +
> +err_cleanup_dpa:
> +	cleanup_attach_dpa(cxled, old_part, rc);
> +	return rc;
> +}
> +
>   /*
> - * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
> - * simple case of single mapped decoder per memdev.
> + * Attach to a firmware-precommitted region already mapped to the endpoint.
> + * Return 0 on success, -ENODEV when no region is present (the caller then
> + * auto-creates one), or a negative errno for a present-but-unusable region.
>    */
> -int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> +static int find_committed_attach_region(struct cxl_memdev *cxlmd,
> +					struct cxl_attach_region *attach)
>   {
> -	struct cxl_attach_region *attach =
> -		container_of(cxlmd->attach, typeof(*attach), attach);
>   	struct cxl_port *endpoint = cxlmd->endpoint;
>   	struct cxl_endpoint_decoder *cxled;
>   	struct cxl_region *cxlr;
>   	int rc;
>   
> -	/* hold endpoint lock to setup autoremove of the region */
> -	guard(device)(&endpoint->dev);
> -	if (!endpoint->dev.driver)
> -		return -ENXIO;
>   	guard(rwsem_read)(&cxl_rwsem.region);
>   	guard(rwsem_read)(&cxl_rwsem.dpa);
> -
> -	/*
> -	 * TODO auto-instantiate a region, for now assume this will find an
> -	 * auto-region
> -	 */
>   	struct device *dev __free(put_device) =
>   		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
>   
> -	if (!dev) {
> -		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
> -			dev_name(&cxlmd->dev));
> -		return -ENXIO;
> -	}
> +	if (!dev)
> +		return -ENODEV;
>   
>   	cxled = to_cxl_endpoint_decoder(dev);
>   	cxlr = cxled->cxld.region;
>   
>   	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> -		dev_dbg(cxlmd->cxlds->dev,
> -			"region %s not committed for memdev %s\n",
> +		dev_dbg(cxlmd->cxlds->dev, "region %s not committed for memdev %s\n",
>   			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
>   		return -ENXIO;
>   	}
> @@ -4226,10 +4459,10 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>   		return -ENXIO;
>   	}
>   
> -	/* Only teardown regions that pass validation, ignore the rest */
> +	/* Only teardown regions that pass validation. */
>   	get_device(&cxlr->dev);
> -	rc = devm_add_action_or_reset(&endpoint->dev,
> -				      endpoint_unregister_region, cxlr);
> +	rc = devm_add_action_or_reset(&endpoint->dev, endpoint_unregister_region,
> +				      cxlr);
>   	if (rc)
>   		return rc;
>   
> @@ -4239,6 +4472,29 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>   	};
>   	return 0;
>   }
> +
> +/*
> + * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
> + * simple case of single mapped decoder per memdev.
> + */
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_attach_region *attach =
> +		container_of(cxlmd->attach, typeof(*attach), attach);
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	int rc;
> +
> +	/* hold endpoint lock to setup autoremove of the region */
> +	guard(device)(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		return -ENXIO;
> +
> +	rc = find_committed_attach_region(cxlmd, attach);
> +	if (rc != -ENODEV)
> +		return rc;


If I'm not wrong, the previous call could find a region therefore not 
needing the next call. Does it? If so the function name should change 
covering the two possibilities.


Thank you,

Alejandro.


> +
> +	return create_memdev_attach_region(cxlmd, attach);
> +}
>   EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
>   
>   /*
