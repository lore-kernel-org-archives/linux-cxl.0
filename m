Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FD20EB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885689; cv=fail; b=tPki4fjhEtGXwdkAextnN0XpPNuUFnLpDe1DQuSYFT+KF+zNatME37z6gMNQ/rT1B1NnjZoXQpVtC9kFrkFkSaodlLxQVHclBjwmmweOHVC0Htd4efObk++B7aj7mevOb6XY//6U6sck1KDU6e0lJFLdEKX6Ezi3X+q4i5gCmqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885689; c=relaxed/simple;
	bh=C7C6K99KRR9/CPT9EqpegkIyhsf67Y3bEPLKkGWt5/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UpOnrMX5AzTIO+Ats/4PhESDkUs/xhIOaUXUHWLB+IsLW/oXFGZLCvIzp7U5zMk+iLeH6qXh9YadPpzSLxHZIO3sUNs3cQ+47G0kOrTQE5zX1CuD/ZZucURvyJwhkSJpQWNHKBEr3DmOB/mVrIu26kU15DTBo2I7PFQ7A5+Khqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TLtXEy4M; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TLtXEy4M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYMiXq+tq3IDv0mgrYEcL5Kb6sJh+iwfvf5gma+oSMpGca+D49Sn15RG96aPBkCIkVTraaijMSsRK8e7FRNXA1Slx63zQuROayXxwLCxQNIaP3+Zlua4cg0r5ahOVhxaP9ZB26MRwfltoItzQFlF3svx/HdOPs2Z9rx2LlOOqeKB86WxtBuxhfbd4sEvMmThrJ6si/zsv30jnERSUaAlSgCYoIY5SB7Y+A+xl4Ol5iZd+dYwTTy+aVp1VexKDJ4N0V1lzkrlNV20vtniR480aJucU+XU3Kb7Cq18eLs6RiqzEhasYqC1EHEyrPZsZ5Gh8iXMj36FUDnAXtr4xLNTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52x4+eq/3yFcMl+6cNgCSavOBw4Y5kDDLGM6/UTl+Fo=;
 b=oXETosNJK4Xn7M5W5XS8REIZ9O9RQ6udN/e8mdCr7zJ4s2BKPsc9fP23clYcbXSEhjKyNxnOdB9iwmyLuObKfUeLh+spU5sTJ0XixLn73cNZQGmpeE/olCf8rknp76eH4sU6A2qqT7ii0hZYJuI34VXF2ho1NoyocAk71v+39N6y5+LwtubZZgR5al4xoObeTw/SB3iSYPiGuZ6Uw5fI8Ex01XQ7mAIth7VOHP/OQa+jjBvpeJttPy+y6isUnpMBFwlucE3B3GjNGwK9J/a+e1rcTz+LM3lENzXF8/oyK4KwKieZ7wvZUfvKJPnV9mzNHq1hu+zVn3PdRqK67CUwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52x4+eq/3yFcMl+6cNgCSavOBw4Y5kDDLGM6/UTl+Fo=;
 b=TLtXEy4MI01nb9g4uAp2uYBZaYHCKaLJYZLGXn4OJUwdEEfzCFeGsdBWi14qtACeIQsJeyMf7xECMAoEz/dgWfga/tKirHVLSIfc4Lky8YKReavOmgp4NiSvZLqJoMoBJb1jKL20i7uv9SB+wzB1EgP0paU0rT3SvoIx6fT3owc=
Received: from BLAPR03CA0143.namprd03.prod.outlook.com (2603:10b6:208:32e::28)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 18:01:24 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::d2) by BLAPR03CA0143.outlook.office365.com
 (2603:10b6:208:32e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 18:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:01:24 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:01:23 -0500
Message-ID: <a792b5ce-fcf6-45b1-b994-55f99d09c18f@amd.com>
Date: Fri, 22 Aug 2025 13:01:23 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/18] cxl/core: Add CXL snoop filter setup and
 checking
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-12-Benjamin.Cheatham@amd.com>
 <20250819151826.00000aab@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819151826.00000aab@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: ff675bd1-0c46-4951-42a1-08dde1a5e88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWJLQStsR0xXVnJ5Z3JKb3hRS0pWYVdoVnhDcXFxOXhaeDdFUDhUUVZsSjFv?=
 =?utf-8?B?YlgybFJWL2xRZTRuWW1PcHlYR295eElUZWJsbDJ4ejRSKzEwdWRxUEg2eERB?=
 =?utf-8?B?ckdaNm5VVlNHRWhvTVh0cXRab1hBWlBJcGZtUmprenVjclczTjA1eTNtMHFU?=
 =?utf-8?B?MytqbG9sMkd2V1lDMmxzL3QwaGVVVlhhMlZjWFY3b3djcmRXK2lzM01WOWhK?=
 =?utf-8?B?YkNMRWVMcXZTRU41b0hwZFkxWm9uWDEyTGZFRXhsQWcxckk3OUNLUFpXM2NC?=
 =?utf-8?B?d2E1S2cyRG9aUncvUnBFY3JETG5pMHhHNHl6Z3RCdmN0ZlZvV29kdzRXdHJO?=
 =?utf-8?B?UEl1LzUxSlQyZ1ZBbWM5Qm9oRXVXUUk3OE5YUTNDTm5iVyt6VkFSc2FFeTFQ?=
 =?utf-8?B?Y1YzY21QN2FidFkvSmdoV2xnbkxtcE5JSXVmZEtRYUY0RW5nQzFmTmovRXNx?=
 =?utf-8?B?OElFd1Y2VGpuSkhBZDFVSGRyS0srRlJhWURDR2V5Y2xCNFBwb3RaUTd1UFpt?=
 =?utf-8?B?eWRNUFNyV01WUy9PdXNFajUxemI5TjBYK1dkakhlb1pjRGJ2U0dMLzFWbUox?=
 =?utf-8?B?Y2ExVStqMG13V01wVnVqMmhvTjdlRHRreHEwQXRVbWpVRTZqZzMrL1RDWWMz?=
 =?utf-8?B?Mncrb01tVUZkTUdHSHJyc1FDOHozOHVqQTNLdU9YdmFjQjUvOE55Sm1wbVhY?=
 =?utf-8?B?U0U5SEEyT1Ivc1Y2R3M3bE5DUmJ1R0hrY1BMd1pwd3piNE9QRzdWWTgzK20z?=
 =?utf-8?B?S214elNhYTdvUnBFb1hRLzBPR0lDYStYNlBVRXdKU0F1ZHcrUGdiajRFNDIv?=
 =?utf-8?B?UWVGTk1iUWkxTVZicTFRSGxTeU1HR2pWRVFIM3FtTW5JOThRYU50RHhoQlZx?=
 =?utf-8?B?NFR6NXRDYWs5QXpNTGlmaFAyY1FOWUtkZXM3S1JSeXZWSm1SUndvTEVWenQy?=
 =?utf-8?B?REFPM2ZRUFB5TEdFdDZITUR6YjFRVHZmUkhSTGZNSFNtak5OYW5EWUhNUWpq?=
 =?utf-8?B?Yzg1blRGV1lRaEpoM29Pa2lHaCtCRUZCQnlOMCtsaUJoeWJENjhlUlZ3alRz?=
 =?utf-8?B?aUNVL0t1cDNZRC80WEVrSkxYN3BNZWRnRFVjaC9aOEROckpYNzFBRTZXWWEy?=
 =?utf-8?B?Tm9mQTBTbjVHMEtrbUI1KzdIK1JBTGlHa0p1NmZqcFpVeGlnZVNDNkpaVktj?=
 =?utf-8?B?RHptdkNqclRSZUVjenFFSWJJWEJ6SWV2eDZmWEZPQTArS3dhelU4VjBoZlFC?=
 =?utf-8?B?VlVub001eExqcjd0TzhlejJuQldFVVZQeEU4SXhOU1I2eE8rSWE2MUp2cUZG?=
 =?utf-8?B?M1NGUkFvUDRqNXVvQllnbXVTcTZzTnpoMGx5eTRnTW42a2I4TCszdDdzaHRR?=
 =?utf-8?B?WkpMN3dSVmhacFEybUQvdUFLeGNQQXM0NmJlbndLUWk4dWlwMTlhZ2NIMzFm?=
 =?utf-8?B?NnJpYlRzRnZWMWcrdmtrVFBucUVGUFAyQ2tKV3cwOGhMeU1GY2hjK3ZoVlVW?=
 =?utf-8?B?czJXTHhJdVJuYlkwVCt0MjQxS2NGazRyWWlVeHZ3WUdmaEpIa0Nvdm41SU42?=
 =?utf-8?B?N2tOTjNaR0lGYUZLSktOVHpwUTkzbEVvM3d6RnJCUWtrNFNVdmpKOGpXNUZa?=
 =?utf-8?B?VFRrZXVKemRRQUNhWktlMFd6TWJCOWJ4R1RVZXFRTkp1UlUraWhhcFZHZmFX?=
 =?utf-8?B?QWRweE9iNjhjbkxZNHJCem1CcHUzemFzUklUTWZmbys0aXU3WWVBL3Fhak5m?=
 =?utf-8?B?SjJKaTZUSnB6TWpzbGx2dFR4cldoRzhQSTJPOXdUUWNpK2x5MGhWb29DOUVU?=
 =?utf-8?B?T1RvS3FGZzJ1bXNhWS9KeVFVWjAyakhmbWk2SytNcFh1VGtzREpqbit1ZGxV?=
 =?utf-8?B?dmxTNVFHbEZtZEd4eE9RUHlQQjZScWNEZUdpYVRpaFVIUS9KeWJ3djJ2R2RL?=
 =?utf-8?B?aGM2M1hIeG5EbGE2M0UyYUVyTnE4K2EzTmdSZlA0SFJRUlVDOUtkRVBvMDhC?=
 =?utf-8?B?M1lNbmlUdXVqcU9wZitYa2NJS3c3YVhUZUswWi81U0c1R05CRXlHMHpuaDA5?=
 =?utf-8?Q?MMinjt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:01:24.3349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff675bd1-0c46-4951-42a1-08dde1a5e88b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681



On 8/19/2025 9:18 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:14 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add functions to set up and validate the snoop filter configuration of a
>> CXL-capable PCIe Root Port (struct cxl_dport). Allocate space in the
>> snoop filter as part of cxl_cachedev probe.
>>
> 
> Any thoughts on how to handle allocation policy, when combined with Cache_SF_Coverage
> hints or indeed just overcommiting the snoop filter and relying on snoops
> to clear space.
> 

I'm not sure. The coverage fields are described as performance hints which makes me think
that devices may not pay attention to the fields to begin with. If it's common for devices
to ignore those field, it seems rejecting devices based on snoop capacity is the way to go.
If it's expected for devices to pay attention then I could try to come up with an allocation
scheme, but I would rather be conservative to start.

> The spec is rather ambiguous on when these can be used as opposed to
> just rejecting devices if we are out of space.

The spec is ambiguous on most things relating to CXL.cache in my experience :/.

> 
> 
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> A few comments inline.
> 
> Thanks,
> 
> Jonathan
> 
>>  
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 5144ddac7145..26ea22a2638c 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -35,6 +35,9 @@ static DEFINE_IDA(cxl_port_ida);
>>  static DEFINE_XARRAY(cxl_root_buses);
>>  static DEFINE_XARRAY(cxl_root_ports);
>>  
>> +DECLARE_RWSEM(cxl_snoop_rwsem);
> 
> static?
> 

Yep.

>> +static DEFINE_XARRAY(cxl_snoop_filters);
>> +
>>  /*
>>   * The terminal device in PCI is NULL and @platform_bus
>>   * for platform devices (for cxl_test)
>> @@ -809,6 +812,139 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>  	return rc;
>>  }
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
>> +	sf = kzalloc(sizeof(*sf), GFP_KERNEL);
>> +	if (!sf)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	sf->size = size;
>> +	xa_init(&sf->dports);
>> +	xa_init(&sf->devs);
>> +	mutex_init(&sf->lock);
>> +
>> +	rc = xa_insert(&sf->dports, (unsigned long)dport->dport_dev, dport,
> 
> So the aim here is include all dports with this GID in sf->dports?
> If so why isn't one added if the xa_load() above finds sf?
> 

It should be, I just missed it :/.

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
> Not freeing sf?
> 

Missed it, will add.

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
> 
> I'd put a debug print here at least and possibly scream as fairly
> sure this means we are trying to free something we never had.
> 

Sure.

>> +		return;
>> +
>> +	guard(mutex)(&sf->lock);
>> +	sf->size += cstate->size;
>> +}
>> +
>> +int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds)
> 
> I'd rename this as it is allocating part of the capacity rather
> than allocating the snoop filter representation.
> _alloc_for_device maybe?
> 

Yeah, that sounds good to me.

> 
>> +{
>> +	struct cxl_cache_state *cstate = &cxlds->cstate;
>> +	struct cxl_snoop_filter *sf;
>> +
>> +	sf = xa_load(&cxl_snoop_filters, gid);
>> +	if (!sf)
>> +		return -ENODEV;
>> +
>> +	guard(mutex)(&sf->lock);
>> +	if (cstate->size > sf->size)
>> +		return -EBUSY;
>> +
>> +	sf->size -= cstate->size;
>> +	cstate->snoop_id = gid;
>> +	return devm_add_action_or_reset(cxlds->dev, cxl_snoop_filter_free,
>> +					cstate);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_snoop_filter_alloc, "CXL");
>> +
>> +int cxl_dport_setup_snoop_filter(struct cxl_dport *dport)
>> +{
>> +	struct cxl_port *port = dport->port, *parent_port;
>> +	struct cxl_snoop_filter *sf;
>> +	u32 snoop, gid, size;
>> +	int rc;
>> +
>> +	/* Only supported by CXL-enabled PCIe root ports */
> 
> I'd go with the CXL spec term which is simply "CXL root port".
> 

Yeah I can do that. I wanted to be clear here since "root port" is an overloaded
term in the driver.

>> +	parent_port = parent_port_of(port);
>> +	if (!parent_port || !is_cxl_root(parent_port))
>> +		return 0;
>> +
>> +	if (!dport->reg_map.component_map.snoop.valid) {
>> +		dev_dbg(dport->dport_dev, "missing snoop filter capability\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	rc = cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_SNOOP));
>> +	if (rc)
>> +		return rc;
>> +
>> +	snoop = readl(dport->regs.snoop + CXL_SNOOP_GROUP_ID_OFFSET);
>> +	gid = FIELD_GET(CXL_SNOOP_GROUP_ID_MASK, snoop);
>> +
>> +	snoop = readl(dport->regs.snoop + CXL_SNOOP_FILTER_SIZE_OFFSET);
>> +	size = FIELD_GET(CXL_SNOOP_FILTER_SIZE_MASK, snoop);
> 
> I'm not sure I'd bother with masking when it is the whole register with
> no reserved bits.
> 

Ok, I'll remove it.

>> +	if (!size)
>> +		return -ENXIO;
>> +
>> +	sf = cxl_create_snoop_filter(dport, gid, size);
>> +	if (IS_ERR(sf))
>> +		return PTR_ERR(sf);
>> +
>> +	dport->snoop_id = gid;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_dport_setup_snoop_filter, "CXL");
> 
> Export seems unnecessary given it's used later in this file.
> Maybe that changes in later patches.
> 
>> +
> 
> 
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1771c42a1e3b..2881e0826829 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -40,6 +40,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>>  
>>  #define   CXL_CM_CAP_CAP_ID_RAS 0x2
>>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>> +#define   CXL_CM_CAP_CAP_ID_SNOOP 0x9
> 
> Snoop filter capability is 0x8 I think.
> 0x9 is the timeout and isolation capability.
> 

That's what I get for working on both of them at the same time. I'll
fix it.

> 
>>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
> 
> 
>>  
>>  struct cxl_device_reg_map {
>> @@ -658,6 +668,8 @@ struct cxl_rcrb_info {
>>  	u16 aer_cap;
>>  };
>>  
>> +#define CXL_SNOOP_ID_NO_ID (-1)
>> +
>>  /**
>>   * struct cxl_dport - CXL downstream port
>>   * @dport_dev: PCI bridge or firmware device representing the downstream link
>> @@ -682,6 +694,7 @@ struct cxl_dport {
>>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>>  	long link_latency;
>>  	int gpf_dvsec;
>> +	int snoop_id;
>>  };
>>  
>>  /**
>> @@ -756,6 +769,7 @@ struct cxl_dev_ops {
>>  struct cxl_cache_state {
>>  	u64 size;
>>  	u32 unit;
>> +	u16 snoop_id;
>>  };
> 

