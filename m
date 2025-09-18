Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F72D7DEC
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226543; cv=fail; b=eKJrmmt8eg3e3p225+dqIatT5kDc5rG9VlnTspj6lfCFNPt9S7oW694c9fztse7GG/Cheq/4jB7RtPY2OODB+Kf6QPRHYU2ceX0zwHbwdT+3ydY1nY+qKm25cs0Cfqr7vLOGmiDsd2YSexHvuy3pgpJcFRFoFNOdLJW754UHCOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226543; c=relaxed/simple;
	bh=5Yo9dqSjvDBXD1xEqFk1thLWfVgVLuW8o3iSk0ctt2o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=AMt001/GJdbwk+auV9Q2ETc64QDcOEfFikl75tbTrf98KVvu0qKwmP7lzYOg0sp/+9qJcdn8cmrS7RQT+sz9z+Ui17NFsxtmle41AZolSK2AWBSyOBqg/oCqxkXa577zFIS/vWLA5B3zH8nUYuDbR1bY06AroYAXlO8PUjF6LW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BnyeyBzP; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BnyeyBzP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqkZdmzN8+4ARuyG1enJPWWR2H10mWYKMaSMTI/V1mHFvGfB/4DMz881ZGsXohUGPUhKeN/LSEpyTInLMMzMxXAL7P7nJxzFhKKsKnQtHlEp0ahm9Bs2IiVxxOKjW9Idy7Oi6XozSjJu0rKoBJo9jKWK9YrmzIMzLCGeykustZDxck6EQ8VwxoiII8ygOwxP3bdJ10SoPkLXgrtexyMPMbrYX+2aEJ3xfe+FpSihwT8HwZVcuhifonORZqmaHifwHX28HUFZvlvvvjoDbHDKbChQ9fVTxbMQrqwULGToxAiIreZSNu/LqWwDwBtFgcPB+H1tpA4mRyc8DdZ1KcjP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijyAtOyAEL8tStmis2wKa0Gn38VIgo5RMn5gDbrADFg=;
 b=IolwgnSWm2iAJE7s5r0fcr+4NvwZQ8QSveruKax7wRpN44sTCtCwVJqI4j3GQpaq76q2EGL8YE1+ED6L+te53OJSokxMLz/mXjnI4AGvpzmNujDKZts+nn+SrZixYZBb/9h04ho7U6ZEP5nsBlq0/FlEaj0sI2ko0sqC3dxfdcnbd/sZsbimnT4oVPuCS2U7LhVhI81dHwf7QmTZ5d26uAXT4h4Xoc4HqskwhWfsNcXa0EsLzYoWcnlbzfFDlO47hFjOEZxf3c0vJ3ztnlf7NGUOYK4SyH2oVp826Gp9NgXyQXsYM02CWiIGQrK+9CnaYnch+8vHNsxEcaKZBdzmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijyAtOyAEL8tStmis2wKa0Gn38VIgo5RMn5gDbrADFg=;
 b=BnyeyBzPMJwBBG/b/9vBVwUbNsDJhd+oQ0Fek5xbpI3BcZf7dMNFsmrRjG00FxppAtIscnkCp8CWebBqhHHw7vWHlCv2U3nqfMmwhs7DHbijCa3ONSgTUuD/yBlpD8zl7gf4JoGx0LYnot4xt3rXRyQJBYeufEsNWlcMse1mT+c=
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 20:15:37 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::64) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 20:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 20:15:37 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 13:15:36 -0700
Message-ID: <91bd9d26-d824-4bc9-ae42-ef1ca73a044d@amd.com>
Date: Thu, 18 Sep 2025 15:15:35 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [RFC PATCH 12/18] cxl/cache: Add CXL Cache ID Route Table mapping
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-13-Benjamin.Cheatham@amd.com>
 <e9c93671-5e4c-4ca2-a521-608fe6544a21@intel.com>
Content-Language: en-US
In-Reply-To: <e9c93671-5e4c-4ca2-a521-608fe6544a21@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 4520d3a6-3cab-46d8-0762-08ddf6f021bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHhQU2htZmh1QUZXTUNxL08vSjhKQW5jMlVuY2NMeUZjNy9WQWtJelhIcU5H?=
 =?utf-8?B?bDVkRXduYWwvUy9rVHV2MkhiWEoyYzAwZzNNK3h5L1NiNWVvVmwrUjdPV1pW?=
 =?utf-8?B?Z3NKL3p3N2JMOEZsQ1BFdXRjZ1VzbTB0a2YwelFzdHFDMm1GM0xiN3I5STBK?=
 =?utf-8?B?OHZ1RGFZckJUREp5MWdITFRFMkI5bUxibW9pajF6VzdtTFZEeHVQT1FVc1R0?=
 =?utf-8?B?QmE1VkNHdWdFaloxZzBpenpxM2JoZXZIcnNrclk3SmhtYjN5MG1WVFN5Ny8v?=
 =?utf-8?B?Z2NTejN2Zmlzd3AySGpvdDIrRnR4M0NsSkkrMkxXbVNmU3psRVpTWnR6VmlY?=
 =?utf-8?B?SE96Mmg1SURWOHZudkdOYnZ0amRzRncrN2JTM1ZwSmFMY1BvQ2dhREp0Z1dH?=
 =?utf-8?B?b2hZa0pDNkJhMS9pdVFpWHBRbmVnMitTK0Y5QUVQbENScm9KT3dOV0RRR1lw?=
 =?utf-8?B?MlhhdXNQMVJRYVlaM3ExNEpLWWhCRXJTbzk3VzV2TFYxalNSMlZZcmM5WEQ2?=
 =?utf-8?B?UmFabTdhSlZHcmVSeS96K0tXYXhjMjZ6dmdabFRLRW5ZdXdYL2pCOXhPcXBZ?=
 =?utf-8?B?T1FpalRDWnk4amI5SldmcXo4OG53c2tia2c4R08ycUlJL3NkUDdCSEdwQW0v?=
 =?utf-8?B?RVo1ZnYvQ3FCZEd0K0dsZmttckR6MEdZNmh1TmE3Tk5XNk9IV0RLcUVoc1F2?=
 =?utf-8?B?TWRmVk96aG9aaU51aC9LcFQ2UWl0ZmN2eTNUWXROVHpmMGxmbEk3ampNZXQz?=
 =?utf-8?B?WnpaVzNUYk1HWGw5UmE0SmVnelJUOWVDeTdBZlkzelFmS1EzbWxQM3BNUGhh?=
 =?utf-8?B?eGVBaHRkN3ZsWnQ1WEhqdzM5cnJEQ3ZheExEa0xVdG5UK2JabWdncHk0aC9n?=
 =?utf-8?B?TllpT1p5UkNPQkd0ckxFc2xuRkVKMGluNjlzSTdlWGVBak1Tc3lCYmRLWDRl?=
 =?utf-8?B?Y1FQQlpJck9NY0h0Ynk0bXhzRXZXVmsrenY3bzY5VzFGMW9RT1hIbjJoWE15?=
 =?utf-8?B?ZUFHSnluYzZzZCsveUlUcjRJS0RacGlZUWpaMmIyL1ZlOWNTekRhN2NVS1R2?=
 =?utf-8?B?UVdnVU0vNzJqQnk3U014MTdTZ2R1MHVKa3dnak01a25EYkJnYVBsWHEzaXE0?=
 =?utf-8?B?NitubWp4VmVSd2ZQRGFuZVFPN0J5QzROOUs2WmpqeEt5VlZMNXFzMFpSOEVL?=
 =?utf-8?B?ZVE4M2ZoMzJ4aDRwSit1MXlycUMxRGdSaFQrTmlCdUVPY0MvUXl4U1NmdUxG?=
 =?utf-8?B?MExGa0U4amtPVHUra3RGTEFoUmEySWs5dllRL3RCSXV1anNZNmFHai9wM3lk?=
 =?utf-8?B?eDRoZzY4aU1pRGErNkg0Lzk4Z3pvc2p1aGc5dUd4Mk5MUjNicXJJQmNxVzVW?=
 =?utf-8?B?UGpKQm9VSHY2Y0EyY0h6WC9ydC9BTjh1czM2Z2F6ZXFhdEpNVmJyNGNUWVE0?=
 =?utf-8?B?VlNDUUdkakpVOENBVUNBeTk2MVpHUkFzOHBLa0N5SnozSzBkZTltZ0ZlK0tT?=
 =?utf-8?B?MHJuaW9Kcllmc0pqdE9INTVpWjA2Z09TZEh5d21sdE80M05lOXZjZVNsdTNj?=
 =?utf-8?B?VjkrNkZoWnUvdEJZZzNLdGxkU0FycUp0N2RDb2p4SjJUUC9RWllSUldNMmJO?=
 =?utf-8?B?UC9PeGduSmRWeVpFTm1FancxRWJyQWt6N0RFSTAvRDE3RWxxbTlUVEs5ajBC?=
 =?utf-8?B?TFFjYVJMSHd3dHlwWFdNVGhHVHBUb0RIQzJnOENIcmMyck4yNVVwOXd3MlYv?=
 =?utf-8?B?QnpoeDYrL0txRzhJSUd1OWJ3K2RmVnE2VmZYUUt1N0JTVk9ORWRMdnR3dnVU?=
 =?utf-8?B?SUczRk1FMnBOY0x5SkZ0TFlvMi93Y0MwTHRPRlowNWZlSTNlOXZRZTROMEl1?=
 =?utf-8?B?Z2V5ZGl4S3E3WFk1R1V1ZStLcDlMSE9QL1RJL09sbkRza1lxK01IaTA3YTA5?=
 =?utf-8?B?eVdGUnVNMVFHSEtPY1pVUklJT2pqbHFKYnV0R2NaMGZQVEltc3VJUXBITHpi?=
 =?utf-8?B?dXdIekt1N0o4SWswN09MN05OemhtNjZsR0hZTTN4YWtWOFR1eVVQVi84TUxE?=
 =?utf-8?Q?YRY+WY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:15:37.3686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4520d3a6-3cab-46d8-0762-08ddf6f021bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

[snip]

>> +
>> +static int find_cache_id(struct cxl_cachedev *cxlcd)
> 
> get_cache_id()? since you are returning the id.
> 

Sure!

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
>> +
>> +	for (id = 0; id < count; id++) {
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
>> +
>> +	cstate->cache_id = id;
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
> 
> Would it make sense to map this once at enumeration instead of every allocation?
> 

Yes. I ended up changing cache id assignment/programming to be part of the endpoint port probe
for cache devices. It makes more sense to do this there (imo) since it's technically a port capability
and not device dependent.
