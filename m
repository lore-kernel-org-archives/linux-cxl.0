Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F572625
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226593; cv=fail; b=kMk4JbNfzRe93DcjzZJqClYX2kPVDHM4JVL3N3m1TubmbVub6BHIQu9YyYzzBmBXYJSOmMWYRfZMGk2prol4Nja75T6vLejULYrbfU6mRFDnY//bfBOwtTTx5ojElH4ubn/iq2WYGYdSBoRSFrhtOZhDUtoD9WfG0TQfmXDwfzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226593; c=relaxed/simple;
	bh=+OywupY5630EabepHRnygLU3RMWqYDelgryUA4jpFd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CQMmQznUmVbRXXQEA2InNERR29fVhKcbvvgUncYH66mEy/0K4IaRLmG3JoT6qaqyr0c989EImdkonByNNstqJikdDvphHJs11NLm5hK+iDMm1W12g5QJlPuHnmzaRYzGjoc4ERByLGays5K6OU5pAYy+VtMTzOKVfhs0sf42qD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FZSfVoh6; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FZSfVoh6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k241cKF2U7YxCj+wFMmLHK0jfsCLwZC6lJzwrWQ6CK6KcPvhItf11UP7r2R3xhWHaM0886vX5GKpjD3qEdpZQESv6XaVw7Ip7NKud0eQlNyrdRudt37EC856mgP8Prc308hVtrzyc+L/Baz49m2H94nawn4IilsaSbTgzq0MRAEbMjXL5B2Hh24hnYFkqTz2Bici6N1ZDlp4JCPJtLzQkGvmf989WDWULjPz6r1r60Sb3oOwWmmK+SnFVxCH15Wee7fsyRVj2F0pCszT+MoUY6XaN6orOncd/TjWjzACCZlwKMwEvbUmIFmppsd/3p7sQwjDFUc/Y3IlXx2AatZfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqdpOSUOgVCRto9cr/f4Ky1x5gFdzWrOwXB3QJnRTt4=;
 b=cEW+QzMfEvr3Vz20bueUUnymD3TihwWcY8rvP+WXpJAJbA65OkJcfdYJuPfEP9jqKU4kvz/s15t7cg93/6sAISvava/+EsbLmsj/Jl7E67/tOkCXxoP9PFdaW2GjgcJZ6HqQxURuJ9i/DyyxEOuMpUkQvQZHCbC9QXE1ywkSM60TVwovsc8g8gZz2XAueMMgsm9r2+Mhr2TOQh2sl4o5c5t52cFdgylFeetM027U8yhWaobozzm9Vj2btoKC2G9XdKYV6/r8+2XOt2IUai1YLEiH5nvmoN7CEXJ24nlRB3vDMcaV1TiJKPZ8C+FKKENqGvTOh6QK1hF7h1W+omfOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqdpOSUOgVCRto9cr/f4Ky1x5gFdzWrOwXB3QJnRTt4=;
 b=FZSfVoh6pQ1ETr3dUXdvr+TUh09JTPX47glTmbbp45PI02b9XlEp16OneYYg5GfyG41TtD9KD4ud+P71Jf+xTBYS93LrceKrT29e+wKWiQffivCIRrR8CCYgQC4PjeqfUAxwZnF9Mdev+8Smaa5NIzQU5o4eIf46vDCDd0ipBUs=
Received: from SJ0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:a03:3a1::7)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 20:16:24 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::87) by SJ0PR03CA0362.outlook.office365.com
 (2603:10b6:a03:3a1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 20:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 20:16:24 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 13:16:20 -0700
Message-ID: <7b506a45-6bc9-4717-b966-56d37d200a4c@amd.com>
Date: Thu, 18 Sep 2025 15:16:19 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/18] cxl/cache: Add cache device counting for CXL
 ports
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-17-Benjamin.Cheatham@amd.com>
 <57c45f8b-2abc-48a7-a14f-2857c1fd8df1@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <57c45f8b-2abc-48a7-a14f-2857c1fd8df1@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: be4a08a0-5d40-4c82-059b-08ddf6f03d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm1zRUMzVmdueUxyQVZPN0VXYk9uMEk1SmZnck9sT1JvcnBldFFKMHlYS1Nl?=
 =?utf-8?B?QXhmN3dkWE56RDVnSE1GQkR1b3R0SW10TkhPVEl0QzZWeFJWUXFDUkRFOGVL?=
 =?utf-8?B?NmNHTDVRZHppWm9HUXZYWnFXVEkzaTNaNlRRNFJZS0ZscGUxaXNsbUh1MjRi?=
 =?utf-8?B?UmV0TDdGWDZzSVByeGJubmhzakVWQ1pqQ2xFZDllRjJteXc3VFNFTlpYcDRi?=
 =?utf-8?B?ZFZmd0s0bHUvQ3diclhSNUMrRmN2UXpPK1d6bGNkRHBKZE1kc1FzN3BzakpN?=
 =?utf-8?B?d1B5UG8xMEtWUzNyRGdoVVBqL3R0MU8wNFlFam9hZzF5RlZ2WUdjamtEWEw1?=
 =?utf-8?B?aFdSU0ZadFZ4YjNZam9DWXE1VytLa1ZHRnN4MXczSTVHOVRQVEhlemg3WmdF?=
 =?utf-8?B?L0dadFNSaFRhTjZueUwwUjFiS2IxYUhiOWdYUUJNUE52S21yRDhKcTd5UVpU?=
 =?utf-8?B?N2t6eEx1dzFMaVhaWVpLWlRjN2VZTjdZa1hteHgvVDVuNWd2T0hIZVRuTXJ2?=
 =?utf-8?B?NTQwVmlITnFyZmhXa1Z5eVhtT2hCTytnNHljRy85NUczTVFjZU1XQ25vY3JW?=
 =?utf-8?B?ZnNvVHNyUThGTFFvbGZJNHRYQjRIUXFESzhqNGp0TFJVazk0azNnK01wRENm?=
 =?utf-8?B?MlNMUmF3VjBjNFNuc1lrRlNnNHM3ZWNOb1Zlek8yNXB3VUtIQ2hBdytsS1lX?=
 =?utf-8?B?SlJic1BYdHlzcExpL2JEeDJIamtEc2NDMnkvNFcyclJLWUVCTGdDdXBjSTlv?=
 =?utf-8?B?Mk1qdWJycVE3a0ZmTXhOU1RCYUphRDlGQjdzMncxcXpvdlN2SEppb29LbU5y?=
 =?utf-8?B?dVhSR2YyR3JocVVPUG1HRnFkR2IwUjRobnFsdWVLMUhEYVBSaTdTV3JzY3hr?=
 =?utf-8?B?VElBWUFkYjlIbnRoN0x6L1dzVHp5N0dHS0xDcnJSTVorNFhwSmVDTGxMZzBa?=
 =?utf-8?B?alprTXZjZGpPbW51MjBGOE9YMVZFcjRYelhPR3V5Y3lMZ1VHdlQ2c0hNS2Z6?=
 =?utf-8?B?ZFppbzBJMENqNXo4bGgrUnhOb3FsYzRYbEs3T1MwRXRwakZ4VW5xcHFMVWhp?=
 =?utf-8?B?MXFZNVdmNjJWV0dIc3V1VFpTOTZINXJXTW15OVRUNUU0WGNpS1dhUUxDZlU5?=
 =?utf-8?B?eUlONy9uN3Y1VUZVMWdUUWZWaElOWUlLOXJnazF2REd2NTdxYTdHUEFqR3JV?=
 =?utf-8?B?d2hqM2VhYTArMG52TWE2SjVVb0tibkZIREJrTlhDQ0VTZVJ3WEgvOTlZUVc0?=
 =?utf-8?B?bGVZa3pQT2dKc3VLbitKV0J0QXVIOHY1cHQydHAva2dZR3BQL3B5bytRR29G?=
 =?utf-8?B?SEZYWTZMVzQ1RTdZanl1dlNsR2NQQzZaZVg4T295RkRwTVVEZ1BQOXdDenda?=
 =?utf-8?B?aHNFOW54bXJYejM1SStzY3NWTGxDM21lTlpKMU5kdlduSXE1emhwQUVlZWh2?=
 =?utf-8?B?YkdjZHpLY0t5SGF1VEpUbEZ2dUxEakNDTXpMOWdhTkoyYXJsdGZtd0NkVlVP?=
 =?utf-8?B?RnVWUFhTc2YzZDF6S2VQRkVOMTBvemNvWmZrUEtJeVR0UDNYWHMxVXRZSTV1?=
 =?utf-8?B?RU9qME5nRENqaGdtTG5lUXhSMEZ3SEpXbHo2S2Q3QWRlWUhDemE0cmEzZzhF?=
 =?utf-8?B?aW9JN0o3YjFUdFVZc3U3Qkp2dWFaZTM4Wk04QklIRkdmSjIyZDhwTjhhenR0?=
 =?utf-8?B?YktkM0g2ZWxHNHZZSjVPQXpRSGdUVFV0c0ltVUcrMEFNdTBLMW02Mjd4YkRS?=
 =?utf-8?B?N0YrZ2JIWTUzVklOUENQWVVtdDRFcm5iZjJMdEpYbFMvYmxPNkVhQjhhaUFR?=
 =?utf-8?B?WVlWdktZTFBSSlp3cnl5UFdSZVBJbnRzcW56V3dPVjBWS056c3pOQ1k5ZGts?=
 =?utf-8?B?YmF4MlZlQm16YVBSZTc1b0Z0ZW1hRDg4dmMwSzFVcmQ2ZVhPMHRYYkdxcDV4?=
 =?utf-8?B?WkN4azFEdVVSM2Q1aTNJNWVpSFBWbWN4VFJpdlA4QzAwTTNEMVdtV0pmeE1Y?=
 =?utf-8?B?TzVzUkJoL215ZDVUcDlKSUx6WjB3dGtFTER5UGllWVpLVG9yUlZGQ3RrNE92?=
 =?utf-8?Q?j/t+Sj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:16:24.1293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4a08a0-5d40-4c82-059b-08ddf6f03d9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

[snip]

>> @@ -71,19 +75,11 @@ static int map_cache_idrt_cap(struct cxl_port *port)
>>  
>>  static int map_cache_idd_cap(struct cxl_dport *dport)
>>  {
>> -	int agents;
>> -
>>  	if (dport->regs.cidd)
>>  		return 0;
>>  
>> -	/*
>> -	 * A missing Cache ID Decoder capability is only an issue
>> -	 * if there are multiple cache agents in the VCS
>> -	 */
>> -	if (!dport->reg_map.component_map.cidd.valid) {
>> -		agents = atomic_read(&dport->port->cache_agents);
>> -		return agents > 1 ? -ENXIO : 0;
>> -	}
>> +	if (!dport->reg_map.component_map.cidd.valid)
>> +		return dport->port->cache_devs ? -ENXIO : 0;
> 
> This bit is a bit weird for the series. Where did cache_agents go and why not use cache_devs to begin with for the series?

You're right, this is an oversight on my part. I've reworked this section to make more sense.

> 
>>  
>>  	return cxl_map_component_regs(&dport->reg_map,
>>  				      &dport->regs.component,
>> @@ -136,6 +132,19 @@ static int find_cache_id(struct cxl_cachedev *cxlcd)
>>  	return devm_add_action_or_reset(&cxlcd->dev, free_cache_id, cstate);
>>  }
>>  
>> +static void cxl_deactivate_cache(void *data)
>> +{
>> +	struct cxl_cachedev *cxlcd = data;
>> +	struct cxl_port *port = cxlcd->endpoint;
>> +
>> +	for (port = cxlcd->endpoint; port && !is_cxl_root(port);
>> +	     port = parent_port_of(port)) {
>> +		scoped_guard(device, &port->dev) {
>> +			port->cache_devs--;
>> +		}
> 
> I think you can just use guard() here since it goes out of scope of the for loop each iteration.

I thought that might be the case but couldn't find a definitive answer on if guard() worked this way in loops.

> 
>> +	}
>> +}
>> +
>>  static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>>  {
>>  	struct cxl_port *endpoint = cxlcd->endpoint, *port;
>> @@ -167,9 +176,17 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>>  		rc = cxl_dport_program_cache_idd(dport, cxlcd);
>>  		if (rc)
>>  			return rc;
>> +
>> +		port->cache_devs++;
> 
> Does this need some locking for race protection? Maybe the port was already locked in this function earlier....

I think it was already locked from earlier. I've added a cache id rwsem for all of this in my rework of these past couple of patches
that takes care of this.

> 
> DJ

