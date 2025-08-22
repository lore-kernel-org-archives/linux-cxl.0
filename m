Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB420EB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885701; cv=fail; b=IbJ8nO3yAyqUXdwLMGfUjSwQjAJXOb+MDtFjJyY5BZ2YA72XS5EJLm3JYMHNtL9bTv9v/9BUoyWure6quW3DVeK5qlRiEeG4TAC9/NvKZowrLyUkR+lloBW/edjDom7eTobtsZ06eZ7QYWXKHI/arslVeTlOAg8IC+ZzRQtN37E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885701; c=relaxed/simple;
	bh=DpTB6CRMV6/fql11DdfvXp1D+7wQcgmFOWkg27mjkVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q2HiICjeT93wsFcnFviFDLHk2A9nJX2mBJ4fATzaoqWzuQvDwSw81/mrioaGDFIvoG74oYOCCAY8ExRohG0iGGTttNYwHqhJ+5qt0U9NRptIL04rRWtU4QXdR8s499PfFdRRVzS2XU389xXIj/VcLJUKYk8SbWHok+8m4r6mIXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gNoe7aDB; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gNoe7aDB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8ZqxDYLeuq+sa6ErNAj2jQuQB0HQXHqWCg06hetMFkAC9CqUUyBwfNLV8pzs3X2ywqiXoy7jUHKLJcXp7VCJl25L61y56JZyV9jDvBk6jKWK67tmpGBZc5Nb0+BS0pVMnRHC/UolWazghSOMWZq9jLWhw4neSqwrfqo1OgYWQ6/RvJAZaVC9XfeWtrj4iho9BXpUSQ/LqN/jwi+he19Qbxu51QMY712s0OvDmUCZ8D6yW7MNazVn+n17a6j/fZOYH8VRs1jUJ59Ss7eRjSzYaWBCsZ6ThZ6m0upr3yUvMYdYnn3Piju32TuKSQKqTuPFm4kHTk1+0et3jrVRO9gqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTfPOnA9belVqQqJpsK8N8ox+K8OarHcglfoKfsMakI=;
 b=wPRRkowPqMemWUnByZhmOWq16KBb1lMvGxaon7s/6C8JNskhJAS/wRpsxFdZMY5RjXH9hywO8RlR0fyLSq7Dn4a5V762PeLIRSi5lKShrvaPGyKUU7K5bvAuB1EUqoCN8Gbn2vlv2njZO+A6pqElZunX9SDP7ZvN9THHXmLo9cIY98DuvT5JxFst3yo7CsNLXcTkO6G+wsZCMZxZ3qdHGoQGg0RXu2HeA8jXEsDAdgIY8HphrExmZ1B4F7ifYDmvBljszaEHuaA8T7I8Vou6ScJttZyTnQpiuTD1Xvhc52T3jonkqqdJDkVcRsgKxtxMiUa1QYJ8inlKNz1PG0U9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTfPOnA9belVqQqJpsK8N8ox+K8OarHcglfoKfsMakI=;
 b=gNoe7aDBMT0X2Yy1faCTBRTdWGv0LQ1l1xJSgSy+GrHdp7jM5CXHQg4Z9pY04EoZizrc4H52+pcYYoxebT8Jk9RCn1VhB5S/0/TKm3e1+zBbiUaGXxhTIEja8fYwEEAnl+GmS9CuIinRFtznVOJcjurIZxl3v1g/FEZeOi0RYtc=
Received: from BN9P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::32)
 by BN5PR12MB9537.namprd12.prod.outlook.com (2603:10b6:408:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 18:01:37 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::8c) by BN9P221CA0020.outlook.office365.com
 (2603:10b6:408:10a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 18:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:01:36 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:01:35 -0500
Message-ID: <f26581ad-05e3-411e-ae8b-8563b8604dfc@amd.com>
Date: Fri, 22 Aug 2025 13:01:35 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/18] cxl/cache: Add CXL Cache ID Route Table mapping
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-13-Benjamin.Cheatham@amd.com>
 <20250819160931.00000ed4@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819160931.00000ed4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|BN5PR12MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2a3428-954a-483d-5198-08dde1a5ef93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0pjZ3JVNVpoaDFVMzRLNFAvUHF2TjZHaVZZNzNjNVg1R3FmaDRPLzQ4cisx?=
 =?utf-8?B?cjlodFgzTlA4Tmh4V1ZXaXFqSXRPSmRhdWswd3ZQWWhMdndpTWpwM3lDT3JJ?=
 =?utf-8?B?bEhmaW9PcDJ0MHEvTXN5VkhVYWN4MVBuUXBUQXFmaTBuTWNZbmgvd1QvcUhI?=
 =?utf-8?B?QW1OYlAzUXRVUjRXQmVEL21LRGg3RXBrdG1uMElkV1JzdEhkZ1JrWm5yaEk2?=
 =?utf-8?B?VWh4bW5XTitFSlNvRVFyUUp0S1o3RlFNV3lmVEUwQXUrY2U0bHRTSiswcGJG?=
 =?utf-8?B?RXFpZ3hsZmFIN0RvUWxYVmozRlZnaVFzaEIrUDNqYlNRUHErTThzQ25Ka2ZM?=
 =?utf-8?B?dVNCOGlsWlNKQTk2TkordVJvYWROZGx2RW95cjVnQkxNZmQrdStqS0oyNkdw?=
 =?utf-8?B?NUpvelJqVE93TmNESitZQkYyUE92MEh1YlZoUnRKeWh6emk2N2JSR2pZeGo4?=
 =?utf-8?B?ekN1bnhSSHoyVVRxZUxmdFQ4bWxHeHh5L2wzdzlvbUZWVzRBeUFyYnd6Zlps?=
 =?utf-8?B?Tm1ZNTQ2ZW0rdEpDYkJ5NDV3UVhPRzNmOW9iYy9VMm9ZZ2tqS2dINlVDUkx1?=
 =?utf-8?B?b1hab1AzRk1ISVdBdFdpS0FHdTNYZFNCaG41cWw5UlRicjlSOWZ6KzFwUXFw?=
 =?utf-8?B?R2xPTTRUV0lEOW4vWFVhU3E4MWlwb0h0Rm1NYTA5U2xkQ3U3ODI5OUdZNm85?=
 =?utf-8?B?c01lLy9ZWjVmejE0blE3Ly95Z0dzekE3bFNCdnVvY0ZwNkl4M1E0bTFFdDd6?=
 =?utf-8?B?VFZUcURKSXh3cHB2NHNBMUlLVEN6RmJHYVZrVTZqaER3dFZkK3FVaG9PWkt5?=
 =?utf-8?B?dXRwTWhoeTNDTHZrai9LeE5EZll1VmFRVFlEYTVpeXJjTVVqM0RiQmZHWDJ1?=
 =?utf-8?B?TVpuODRhRWpaTmIzYjJHMk84YXFla3ZSVVNIOUxnZTlEUytENnNwb3A2TUtE?=
 =?utf-8?B?d3puZk92WHRlcHpaT1lSMHpob1pjQ2pBUWNwSDg0NFhaOUhiTHlxSTlrU0ZS?=
 =?utf-8?B?OUY0SUdFWGtScEpOK0pBVWRVdzRhNVljR2VEL0F5dFdnMmFtVjZUUmFscm5C?=
 =?utf-8?B?NG1xQjFRak1VODlBNjdzb0N0Nld5ZmNTWjRxc1MrdTVmNmxPUktjbjBGVlBj?=
 =?utf-8?B?VDVnWjhoOVVMcGoxeStmY0QrSHpJV3Y4c3psUDh4ODdaNFJHcnE4aHk0eklq?=
 =?utf-8?B?Um9jM1ZvaEFiT0J5SWZ4d0ZyVXF4Ri8yY0Y3QTFxWXdPdm15QVJjdkl2WnZ5?=
 =?utf-8?B?Qkd5SXkxVTdrMS82aTg4aTlmRVZ5dUVBR0NlSnVLeW1jYmF5YkxYbXR5S0VP?=
 =?utf-8?B?QzN4c09nSU9keC9BMXpGUElLcDl1QTU2VE51TUN5K1FOSjcxc0JmQmp5Y0ZD?=
 =?utf-8?B?R1Q5UEJ4aldqSEJWc0RaZFpwM3RDTS9YZ1V5U2p6ZjRITnNieE9TWXB0ZmlX?=
 =?utf-8?B?VE5DTEo5RWJTUStFWExWOFpvRHBUb2FCdC9wcDhEMkR1WVcwOTk1MTlWbFBW?=
 =?utf-8?B?WmtVeXNwODNpaUl4RURIU2tiQmFHSkF0T1lzaFdWMUNMRUNJY1NZK2F1TG80?=
 =?utf-8?B?Wmc5MHFVQ0k5R1MxNXNPbUZxcnptNnZMOVVzWGFXMjZadSs2RStaVGpMaEp3?=
 =?utf-8?B?eGlVaTVEaVdoZENvQ0kycEoxcTlsMGRZM2RPWEszVVNZQTVQR0s4aWlIeVNF?=
 =?utf-8?B?YXZpVWNyS2RLSUVqcHZFQXR3ZHJSMnJSWEYwbzY1L2djbnEvUFBZcEdkMUhh?=
 =?utf-8?B?VTN4VjVUd3Y5L29jU0tDK1ZodW5TaTdPV2E2NFFNRzM0QkN5TVRnN3V4ZXo2?=
 =?utf-8?B?SkJmSmhzcDN1QTYzRUtMTlVSS3RkaVBtQUFTTDk1RFRwVjhOM0h4eEhBTU5M?=
 =?utf-8?B?WFNDTGJ0Q3p1RG1hSlN1QnFOTnYxdm11V3JHNG8vdDlEV0l6WXh0UTdQRlNa?=
 =?utf-8?B?S1hkOXBxSzFub01QRWpWbE43NkR5amExbHM1ajBIajY1MFFNOVBmRkxGUkd3?=
 =?utf-8?B?VStZaXZJY3VzeXlkWDU5T2NSdVJtSi8rTUdQNUxVVWYzNFJjYlNkSGZOYWNN?=
 =?utf-8?Q?vOTvra?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:01:36.1309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2a3428-954a-483d-5198-08dde1a5ef93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9537



On 8/19/2025 10:09 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:15 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> The CXL Cache ID Route Table is an optional capability implemented by
>> CXL host bridges and CXL upstream switch ports. This capability is
>> required for having multiple CXL.cache devices below a port (CXL 3.2
>> 8.2.4.28).
>>
>> Add mapping and allocation of cache ids to be used by the cache id
>> route table and decoder capabilities. It's possible the id has already
>> been programmed by BIOS, in that case use the preprogrammed value.
>> Programming/validation of the capabilities by the OS will come in later
>> commits.
> 
> Fine to leave this for later, but I'd not set the cached value to
> something we haven't written.  Just leave it unset or error out until the
> support is there.
> 

Makes sense, I'll change it.

>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/cxl/cache.c     | 87 ++++++++++++++++++++++++++++++++++++++++-
>>  drivers/cxl/core/regs.c | 13 ++++++
>>  drivers/cxl/cxl.h       | 16 ++++++++
>>  3 files changed, 115 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
>> index 7ef36e4bbce8..fd2ae1fa44bc 100644
>> --- a/drivers/cxl/cache.c
>> +++ b/drivers/cxl/cache.c
>> @@ -55,6 +55,90 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
>>
>> +static int find_cache_id(struct cxl_cachedev *cxlcd)
>> +{
>> +	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
>> +	u32 cap, count, entry, portn;
>> +	struct cxl_dport *dport;
>> +	struct cxl_port *port;
>> +	int id;
>> +
>> +	if (cstate->cache_id != CXL_CACHE_ID_NO_ID)
>> +		return cstate->cache_id;
>> +
>> +	dport = cxlcd->endpoint->parent_dport;
>> +	if (!dport)
>> +		return -ENODEV;
>> +	port = dport->port;
>> +
>> +	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
>> +	count = FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap);
> 
> Need to do the clamping dance for when operating in 68B flit mode?
> Described in the register field definition in 82.2.4.28.1
> 

Yeah, it couldn't hurt. I think the "extra" entries will just be marked invalid,
so no point checking them in that case.

>> +
>> +	for (id = 0; id < count; id++) {
> 
> I'd pull portn, entry and anything else you can into this scope
> 

Sure

>> +		entry = readl(port->regs.cidrt +
>> +			      CXL_CACHE_IDRT_TARGETN_OFFSET(id));
>> +		portn = FIELD_GET(CXL_CACHE_IDRT_TARGETN_PORT_MASK, entry);
>> +		if (portn != dport->port_id &&
>> +		    !(entry & CXL_CACHE_IDRT_TARGETN_VALID))
>> +			continue;
>> +
>> +		cstate->cache_id = id;
>> +		return 0;
>> +	}
>> +
>> +	id = ida_alloc(&cache_id_ida, GFP_KERNEL);
>> +	if (id < 0)
>> +		return id;
> 
> ida_alloc_max(ida, count - 1, GFP_KERNEL) 
> probably to avoid allocating an ID off the top.

For sure

> 
> If some IDs were programmed by the BIOS, but not one for this
> device (maybe it turned up late) do you reserve the relevant
> values in the ida?
> 

I don't think I did, oversight on my part. I'll add it.

>> +
>> +	cstate->cache_id = id;
> 
> Having this half state at the end of this patch makes things complex
> to reason about.  If you really want to split it then return an error in
> paths you haven't handled yet.
> 

Ok, I'll look at either squashing the patches or adding errors ends up simpler.

> 
>> +	return devm_add_action_or_reset(&cxlcd->dev, free_cache_id, cstate);
>> +}
>> +
>> +static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>> +{
>> +	struct cxl_port *endpoint = cxlcd->endpoint, *port;
>> +	struct cxl_dport *dport;
>> +	int rc;
>> +
>> +	for (dport = endpoint->parent_dport, port = parent_port_of(endpoint);
>> +	     dport && port && !is_cxl_root(port);
>> +	     dport = port->parent_dport, port = parent_port_of(port)) {
>> +		guard(device)(&port->dev);
>> +		rc = map_cache_idrt_cap(port);
>> +		if (rc)
>> +			return rc;
>> +
>> +		if (port == parent_port_of(endpoint)) {
>> +			rc = find_cache_id(cxlcd);
>> +			if (rc)
>> +				return rc;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
> 
>>  
>>  static struct cxl_driver cxl_cache_driver = {
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 0c8962fcad9b..0924127bd8fd 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -98,6 +98,18 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>  			length = CXL_SNOOP_FILTER_CAPABILITY_LENGTH;
>>  			rmap = &map->snoop;
>>  			break;
>> +		case CXL_CM_CAP_CAP_ID_CIDRT: {
>> +			int entry_cnt;
>> +
>> +			dev_dbg(dev,
>> +				"found Cache ID route table capability (0x%x)\n",
>> +				offset);
>> +			entry_cnt = FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK,
>> +					      hdr);
>> +			length = 2 * entry_cnt + 0x010;
> 
> I'd drop the leading 0 so 0x10 that will bring it in line with the macro below.
> 

Yeah, it's not supposed to be there. I'll remove it.

>> +			rmap = &map->cidrt;
>> +			break;
>> +		}
>>  		default:
>>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>>  				offset);
>> @@ -218,6 +230,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>>  		{ &map->component_map.ras, &regs->ras },
>>  		{ &map->component_map.snoop, &regs->snoop },
>> +		{ &map->component_map.cidrt, &regs->cidrt },
>>  	};
>>  	int i;
> 
> 

