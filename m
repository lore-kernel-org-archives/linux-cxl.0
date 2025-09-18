Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F99F31CA5B
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226527; cv=fail; b=CI+Hx+kRkHXwrlv9nUjjQK1+Mm12ffroHM0/Yz6KJiy/DQ+3Qh60QuDsCZMh3GqARo5IfuUU5nvuFE0KZ6bm/1l5Yyry8CnHFcpojLsSHuuh26gcUktYeboFliB4S39hMXZMbXONnxWkNB51WhDYv92rMUEHvOmJOdKSAf/moL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226527; c=relaxed/simple;
	bh=PSU3riJTUykzM3wKmy1eNC/kzhWMm3vjYPtTtllEZQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Rze+mN49G4rZV9npr6hChB2jTbPXBOGlUHhN7IXg36TjHLjvHYv9NhQs5ls+MGiVYwPTlmPk2d1MDPcNrBGvFTq0x4iMkwhjXXAil3fu7/X64PXzS/a0cba7paRe0BXhpUEr89PqedtylgxaKH6uIlaNQA6y8SUDF0wcshf+q2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U58E0mYo; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U58E0mYo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktVPdz4OlCXym4As8TGsZj+Yholghy4Ijvv4Z7u6bkpa7JCQv9mC7T1mHB549wHO5xZJRBXpnWpCG4s4m9BqMIgAVAzRSa/CCVtLjkc61J0lfjRLueZCK7WN/1HwH+pQ7Y3zgO5a9VgW45bss4/2avTAiNS6Pkd9DpjsaLBcAV6nFgCvyHIZfatThOmnBKkRP843bYIDDOFDEr22DRLCa8eN6CUgE7OEvSyhvWJIH6hXs8rsULULiIBz0rvZwweKfvDXD6+KcE4dkqxrhk8H+5IDV4H97dZaAEzlHiaSFyQQRS1txZ92yqP3ib6WTXdPyjHz8AYEtBVtpFvx5dKGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhV1H4ci9Y3j4Oi0p0wNi6eHJbN/x1vblRv1c4Xw5Uw=;
 b=tiZxFFTrlcYqKn2uXEgtIiP/voJ4wMdQluIH4IvINVu7sO01TJqRhnUU0OFWpwhoywUD44zFxulpYxZk/FsJP3eX+Iko2iFthwU52K7nC4GLAN/ac0flj0s+n7Ipd4ohrKJN0qjbwQWuagKIh0+1mys611h0aSCSUla7VtpNrgt5nU0NsUTnYxHagbsBcPZ7i8mbxQmJw+A9SrYcP+rL5DyD1z+ySXxgITsCO/qRhzuILnBjAZZCPx9kJ6ecCWbeVAK4jVcFMkY4SVYd04sNVTCIvmYn8zG04k46/2xcRzFMr4zxTHposeehiGh4CS+OwGwyFMLiekbuOzv9+Widsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhV1H4ci9Y3j4Oi0p0wNi6eHJbN/x1vblRv1c4Xw5Uw=;
 b=U58E0mYoxAw+nh1vpoLQ+2InUSWQX27bDpvocXejXPfzOafJoNFnEppQFL0H8M82nxqY3S8gCYg41K3oRdrWKt9MG+GV5yGyc8YT89TsIVwqnoweyx83y2og91ecDHFX/anosuCv7w3jUY1bYNpZBXIYiUYfj0Opv5CMNnXybyM=
Received: from SN7PR04CA0078.namprd04.prod.outlook.com (2603:10b6:806:121::23)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 20:15:23 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::1b) by SN7PR04CA0078.outlook.office365.com
 (2603:10b6:806:121::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 20:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 20:15:23 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 13:15:22 -0700
Message-ID: <ed75d7b9-74d1-4ba7-9001-a94d0e3d4ff4@amd.com>
Date: Thu, 18 Sep 2025 15:15:21 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [RFC PATCH 11/18] cxl/core: Add CXL snoop filter setup and
 checking
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-12-Benjamin.Cheatham@amd.com>
 <6c63dc30-0ec1-4ead-a884-bdc87d07f70f@intel.com>
Content-Language: en-US
In-Reply-To: <6c63dc30-0ec1-4ead-a884-bdc87d07f70f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 686db1ab-ff22-4ab6-f10a-08ddf6f01930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEhDK2RGK1Jsclk3QzRwN253OGU5L0IramVnSmlaWGhWSGJKem0wSTdOTFB4?=
 =?utf-8?B?eE56Z1orQm1hMWNFRUR2SVlycVlVcjNyMEhhZkVHVldXbWQrSEFGaVl1YzNU?=
 =?utf-8?B?bzdiN3owK2xCWTJSNmhzSTRjajNDOXpuYTJhY21VV3VCQU9LZXJyZkVVWHVC?=
 =?utf-8?B?VmNYdTZzckJZN1ZpRmV3Ny84cytWNk5GdlRBOTUyNlM0MHVIbFNUQkZudnFk?=
 =?utf-8?B?alFMTUppdTArTHhzWDM3UlJ4TnpuVFlwdWw4a3hETDBNUGtTOUhiRVR1ZGtk?=
 =?utf-8?B?aHJndzE4cWRiWldtSTk3dnhSOUV1eG1yOFF2a3VEMUF4RFNpMG5ta0JOVEVn?=
 =?utf-8?B?emErbGZVLzltMmdwVGwxbXBNWTdjRWdtekVxOUQxNk10Sjk1NVdtRWlPU0pQ?=
 =?utf-8?B?RHl2bnUxVUtaK0VUQUVPRTkzaGF6L3pWREVNbUNJL0FIM3hMSVlPUjNTR1px?=
 =?utf-8?B?ME80RmpmcnFNb0xoemlEbFpaK1B4bmhZWis4K1dzUmpqR3pTWFB4UllmdmJD?=
 =?utf-8?B?aG9TZWtSY2Z1SkZYc0l5ekhFNVBiM3ZPa21RMitpQ290VkJFS1BEYnp2cFZa?=
 =?utf-8?B?YUtVamRBVm9OZkRPUEV2TzEvUFZsNjZ1bisraXB6T1lMazJxRE1vWjJZNmtQ?=
 =?utf-8?B?OTFlM3ZTem9URXNkT2xtUUpSOWV2RkNFUTlydzFFQ2Y0TFo4dWJVKzZzVzdT?=
 =?utf-8?B?VWUzVVJZVVU4MHB6eDdPVXVBeXdDWmlnMEtBaVFxRVNRaXBJTVdLUzBGd0RJ?=
 =?utf-8?B?QWpCMllrbW9ka0c5YjJ5K1JTSGx1ZElDQll2RnJFcUtldWNsdHZQT2I0S3pF?=
 =?utf-8?B?V1pTWUpDbWk5SjA4VDRPQ0xidFJGYk9ycldPLzdJTUtqYXBRUk9ZSVBxWjBT?=
 =?utf-8?B?NENVUWtXOHprdWVkbzV5VzNHRTZMSXZlWTFJMnJkMUs4UHQrVjRrV2hVTGVr?=
 =?utf-8?B?RnI3SkdHV0ZBb0hDT3hmVExFVlplSVZZbUlVUmtVbG53TjFlenRacmJEMXlP?=
 =?utf-8?B?T3Btalc0MGduYktycEVXVHJCYmNHS3UxVmNoVnZ5bmdVaWlQeHAyNldQRzJE?=
 =?utf-8?B?dzViZVhEdnhmdGxsM2lxcUR6VnRyYlBjc0hLUlpHdjRNdjA3MmJyNEUwT3Az?=
 =?utf-8?B?ZXhiZGdpV0E3aTI3a3FVeVR3RGhvY2taUWdZVXM0aXpRaEp5MEZaSDZJSVNF?=
 =?utf-8?B?TWZJZHg5WE5QYjh2NWQyYzEvM1laR3g1S0s4SDhDNXcxSDB6ODExRlRHMkFk?=
 =?utf-8?B?akFiR1pCWWZtVmtWVEVEbG5vRDVTeTFKK3JraFJYUVpjNEFGcmNPWlFCZXNC?=
 =?utf-8?B?Y3REbFliOXFJRkFBTHVoWHRMQUJkT29YNFk4c1MyZk8wdllEOEZoSzRobGlY?=
 =?utf-8?B?TTFaV3ZrR1AraEpQWlA3UGwyWmFKU01YaTQ5QUNCZG1wZUlURXZTYmZjZTN3?=
 =?utf-8?B?dEJUc2xDQUNIYlU0S0JNSzFDT1RXNm1zWGQ2K0xueEgxa2JDU2NIcWY1QVpr?=
 =?utf-8?B?cEVpdStyV3R2OHZCdmZ5OW02bkQzVU1oUjBMZmZZN2VySFYwWXNlRUgvc2J2?=
 =?utf-8?B?WlAvb3U1V3ZJQ3hmMlpSRVlFWDlxMXdjOUIya0JLbEpqelYwb1kwVUI5OVR3?=
 =?utf-8?B?eXhzNHkyTGQrSGFzLzZuNEVnaWlCM05tT2RDVDhNQ0NOVFgwbmFSZmVYdEQ1?=
 =?utf-8?B?R1Mycm5KTFI3TE1QNkh4RTR4MkovVFBDY0htdk9hR1paVjFYN1ZRTEI2aGtt?=
 =?utf-8?B?NitFemRPQmMrUmV5KzQ3Z2dwNjhhVmdaZ0JHblBmSVBQbE9lQVMvb2lyQXdC?=
 =?utf-8?B?NTRINU5jR25jQ1RDYm0wR2dLMDdVYW9QaU9NbEpFS0tJWU9iRU9rb1ZKWHdS?=
 =?utf-8?B?TFFUYjhiSU41eXZ4eGs2dCtLbS9kekdFMFRFMXhPMzRoSjVEcjE0S2xJSWNL?=
 =?utf-8?B?ZCtjU1hZQlRZajBYTlJTaE5obmpzckZQK2E5QjJ5NE0vd21Idm1QV1hzNXRr?=
 =?utf-8?B?bGF2ZStsTUV6ZUNicE95TG5zRUJYUEM3bVNyNVVRZ1oySUhJODhvTWJwZHdR?=
 =?utf-8?Q?NRXl2j?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:15:23.1087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686db1ab-ff22-4ab6-f10a-08ddf6f01930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368

[snip]

Sorry for the delay, I've been reworking the cache id patches (next 2) and didn't want
to reply with outdated info.

>>  
>> +struct cxl_snoop_filter {
>> +	u64 size;
>> +	struct xarray dports;
>> +	struct xarray devs;
>> +	struct mutex lock; /* Used for filter allocations */
>> +};
>> +
>> +static struct cxl_snoop_filter *cxl_create_snoop_filter(struct cxl_dport *dport,
>> +							u32 gid, u32 size)
>> +{
>> +	struct cxl_snoop_filter *sf;
>> +	int rc;
>> +
>> +	sf = xa_load(&cxl_snoop_filters, gid);
>> +	if (sf)
>> +		return sf;
>> +
>> +	guard(rwsem_write)(&cxl_snoop_rwsem);
> 
> I would move this right before the xa_insert of cxl_snoop_filters. That's what it's guarding right? Although I don't think xarray needs locking?
> 

I ended up rewriting this to get rid of the rwsem altogether. Instead of locking, I just try to add the snoop filter to the xarray and
take the entry that's already there if it fails instead (while deleting the one I just made).

>> +	sf = kzalloc(sizeof(*sf), GFP_KERNEL);
> 
> Maybe you can create an helper alloc function and also a free function so you can utilize __free() and avoid the gotos.
> 

I changed the return type to 'int' as part of said rewrite. I didn't really need the snoop filter itself to begin with, just
whether creating it was successful.

>> +	if (!sf)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	sf->size = size;
>> +	xa_init(&sf->dports);
>> +	xa_init(&sf->devs);
>> +	mutex_init(&sf->lock);
>> +
>> +	rc = xa_insert(&sf->dports, (unsigned long)dport->dport_dev, dport,
>> +		       GFP_KERNEL);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = xa_insert(&cxl_snoop_filters, gid, sf, GFP_KERNEL);
>> +	if (rc)
>> +		goto err;
>> +
>> +	return 0;
>> +
>> +err:
>> +	xa_destroy(&sf->dports);
>> +	xa_destroy(&sf->devs);
>> +	mutex_destroy(&sf->lock);
> 
> Probably not needed since 'sf' gets free right after.
> 

Ok.

>> +	kfree(sf);
>> +	return ERR_PTR(rc);
>> +}
>> +
>> +static void cxl_destroy_snoop_filters(void)
>> +{
>> +	struct cxl_snoop_filter *sf;
>> +	unsigned long gid;
>> +
>> +	guard(rwsem_write)(&cxl_snoop_rwsem);
>> +	xa_for_each(&cxl_snoop_filters, gid, sf) {
>> +		xa_destroy(&sf->dports);
>> +		xa_destroy(&sf->devs);
>> +		mutex_destroy(&sf->lock);
> 
> Are we missing a kfree(sf) here?
> 

Already fixed :).

>> +	}
>> +
>> +	xa_destroy(&cxl_snoop_filters);
>> +}
>> +
>> +static void cxl_snoop_filter_free(void *data)
>> +{
>> +	struct cxl_cache_state *cstate = data;
>> +	struct cxl_snoop_filter *sf;
>> +
>> +	sf = xa_load(&cxl_snoop_filters, cstate->snoop_id);
>> +	if (!sf)
>> +		return;
>> +
>> +	guard(mutex)(&sf->lock);
>> +	sf->size += cstate->size;
> 
> Not sure I understand why the function is called cxl_snoop_filter_free() when we just increment the sf->size.
> 

It's supposed to be freeing capacity. I changed the names to devm_cxl_snoop_filter_alloc_capacity()/cxl_snoop_filter_free_capacity().
