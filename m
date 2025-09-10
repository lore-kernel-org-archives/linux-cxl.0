Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C671C54A9
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519728; cv=fail; b=O30ip/4Fz6p9GSVBmpaD6NVZL893BN8wrvE4gJi4yg8+Ao7TakLeXpRst0SzzAXfUp+Vk1O6lza/AryX/Wh9kZSRn0EQSbL7lWZ0fpsi1cOQe/ZxBDqqfbMpp5dVz37sC1V+LLKU812dQA5WNgMu6xN9LFvPj5+deh53Jj5RYoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519728; c=relaxed/simple;
	bh=p5KhqWLg1i7N6BhwqgJ7Ue5Ro0gfTyT1Gnzbe9WbIbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sLCiYp95PoYa9136YpBxTMGrgj1bIyQVBb72qtSURClJY3WF9Dn1NOhkIQb3CcYdqmR61dJLNFYAx2Xpeen9TYO+HEFcvamRkApQN07x+QLKm1NVMnXh+7jPeH1c7sy7ULtVFEHPPcXYYYPaiZq/uKnNNB53CigjdtEShkfADBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YNO6HsxI; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YNO6HsxI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+u2LmdCMyTZ9GKXVvCJHivJy4/sqJ4llmP+5o/V4yLtWXPx23fQal1mECIVLbZnh3lSG9ZBu1JXZ5DyP5XEHY2why6KujY4e2RB98DC4mpqItBmxntZeQlkoMNn5hxAGhghp53bo5yG5uv4UFg74L2Qh/qQktGIZcLxd7A4OeVOW1h9abrEuoNFpDvWqJGiPYlgvH53eZoaXd+4ABspfh6PNw9sa0V5UYhqZWYpNrHFnfY19MKVRk0r3tvSBqijxqJscEYQ7JlfZTEhtYchQoQ65yUsae+1cQdkefc25JsncqqNrGABrP7Sg7//Fh3csV3qRen9WLORlDQkqrPbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhELyX4a+iKLrxqlnVUaNQ1mwagw/2u+FQRRE2v20Bs=;
 b=vQguB0K70n2J8EJRqcvv+0oOYurepyTr+w6DEMoitOrG/fDnhB000hphK7g2f7yMk2hodkM/yy2vIu9qckUzVQlpVym+7gM+fzlwDJz8HbaXilomHeOvsuVr5bOE0Z1mC9aPrNvcJPIebQSQWKDt/bg8CAosC0+BQaVUzEeDGUQXl4OJ3NGo9WndfNgZzC9T4zn4DeFaj6QVBcF4f5mR4SmijJlFjeuONhqDDfWrixHY5lhlaX8a5UxsYJM9OV6kzIMwJf6YZuZxomq1Ma0/eB2Fbu1i51UnTH4BSoAdUlSiZD4t+vAD6CTRqNjr7ynSiFZOk4HrCkkdEBbBqIGjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhELyX4a+iKLrxqlnVUaNQ1mwagw/2u+FQRRE2v20Bs=;
 b=YNO6HsxIdaFq1OHacjgMco9AplYQYxGzKqdkn2fwokZOFynRu7gJp0R4PZxYC8HTaWN+laskyJ9X52QyEWt6nKYdOqMvMCstEOi5ydo7+oevyIkyQf978fT6V/h/mOg/ggcVKpTZt8Mf9+h0wwXEHCd9k5NjdL6DZWMgaoeGSus=
Received: from CH0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:610:119::32)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:55:21 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::19) by CH0PR03CA0363.outlook.office365.com
 (2603:10b6:610:119::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Wed,
 10 Sep 2025 15:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 15:55:21 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 08:55:20 -0700
Message-ID: <ae6bdbe5-1689-47b2-a210-eac7cee7ff6b@amd.com>
Date: Wed, 10 Sep 2025 10:55:19 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/18] cxl/core: Add function for getting CXL cache
 info
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-10-Benjamin.Cheatham@amd.com>
 <62bc178e-5c13-45d1-af9c-502b18625153@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <62bc178e-5c13-45d1-af9c-502b18625153@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5d440e-fff1-4a5c-64ac-08ddf082726e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEZyOTNPbkllRGdZMnlJWUxEUmlpUnhyWGN2ZlhFSlQ4U25XcjJwcUdNYmF5?=
 =?utf-8?B?THBZWXJkV3plMkRtek5Wd3ZmNkRhalFzSm1mSXdldVBYN1lnbXVLUnppTi9o?=
 =?utf-8?B?RVBTQWhQN3k4STgzTWY4UlUwUjVmUTNOUzBFMVR6WFQ1Z2J2T09PbFE1OWNI?=
 =?utf-8?B?M0R5c2FkTS9vNzIrT2NMd0hFTk4wYXpDdnBFRWU4UEFUbEgza05vN3dia0Zy?=
 =?utf-8?B?akZ1Vk5BR05OUFh6M0g4ZmVvYlBiWWZzQmhXMExVM1FEL3Nuc0NkcmpUc0k5?=
 =?utf-8?B?aGdrUzcxSnliTVVjYkQ4MzdSaE9Hc1ZDZWJDN1diaFoyZHExWkQ5RTNOR3B4?=
 =?utf-8?B?NHBHWC9xdXVvQTBPUzRJRG9BcEYvWGMzemxmUGpmSVpiR1orbDJObFl4ZnI5?=
 =?utf-8?B?RlVhVE9qL0d2UXF2d3lNQ2ZKSDQzZDVIYmhyS2xKbnhPWUdUMkJMb3doSDVr?=
 =?utf-8?B?NkliWVpTejJrNTJ0VXl3dDdCZnIxV282eE9JZFZNU2o4OTNOdHgvZWtyRGg4?=
 =?utf-8?B?dGJwK3ZNWDFEMmJPSnNuVjFONU9WYVNvNGJkeDlCMkRiK3dsbWd3SktBd0hm?=
 =?utf-8?B?L3JUVUZINVpSVU80ZlM5RU1XdnllTytyTFZEcDZUSG9ORllOVXFZS1BqY0pr?=
 =?utf-8?B?NzR3YXlaalhZR2tkS3Nrekg5eDVnbTJGdGg3V2o4aHY3T0g1UGVjOVRvbEJJ?=
 =?utf-8?B?ZVRBMHdnNkppd1JORWIxVkllZHV3ZXZMdnhYWWVuU3lPNzNLQkFHejdURUJI?=
 =?utf-8?B?N3lJdnUvVW9laHp5YWpVdTkrd0Y4dVhRclBCakhnWVk3OWZjYUhDVzRTZGE5?=
 =?utf-8?B?RVExeW9SQWdMNmkyV1UvK2dkeGhYeTh1bFdubUMxTk1WTm05cnBrcSsydnNu?=
 =?utf-8?B?Q0xNS0VuM3F2dDM1LzlyOURuNmNERVRPTlRsZlRORGkwM3NhaGFDWStRelJr?=
 =?utf-8?B?QkxXeklWWlpIVDhkV0ZvQlZZZXI3bmFvbG5zTm5JYkdPR2E0cTZMZGJ5c1VH?=
 =?utf-8?B?WWVxSWdYNFJGM0txNDl2TjZSY3NHOGhHN0QwY3Y3Z1I0ZkE1TXpPTUl5TXNV?=
 =?utf-8?B?L0hvVGw3blNKNGJWQUFQQnBkbCs4ZkJuY204UEMxUVU3dENrWFVlbnJPa3Jr?=
 =?utf-8?B?S0cxUlFoVzdJbENCa3NIeXkzaDU5OGUxNHZaeFZpWFdBZGpxeGU1ejRCRXli?=
 =?utf-8?B?TkhyQU5xclVlUTEvNnFJNjB0Ykx1WE1INXB4L2dnejB1YkwwNzlvWjRpcllE?=
 =?utf-8?B?NXFiQ09DaU85TEpIZUhPWGNMVmJSeVU2aG1aMkJ0ZTRpZmVXbTYrZHp1dmtG?=
 =?utf-8?B?OUxPT0FxWFl2NFgzTGVLQ3IrYlBackFyaHNYMmRzNTR3UjFybEZKTVJNZkE2?=
 =?utf-8?B?Tm1DNEVBSEFlSnBKd0xoU0hPV1BSWHAxVjkwMTJPZ0g2S2UzNCt2RUdrbFlL?=
 =?utf-8?B?WEZXNHNFWlFXc3liSVJzTU92MzY1YXJueEZqUkdudW9OeTZ0MWtNNFprNTV1?=
 =?utf-8?B?U2l3VUVsMk5YNlh5Zng5T3drZEt0bFdVWGtLTXJYQjZBT3A0dnZMYUc5dy8x?=
 =?utf-8?B?MGhXK1U5S3d0N0VleGpreVBzOEE0bHBDSEY1UFA5eW5hUlhOVTUxSUhkRm5z?=
 =?utf-8?B?czJ3eDZuQUhPVGs2VzN6SnhXNk40dXc3YW5wYzNLZGVRZFMvcWxZakozVWdk?=
 =?utf-8?B?dk9hZUNTSDdRTlhzci9CMERMdEpsKzd2S2VIcVNRb2xIZkUvZGdRQmdnNHI0?=
 =?utf-8?B?Y2NZNFhlQ3N2NGFSTTlQUjdVekovTHczQ1IzOWNTK0llTnkzNlFJYzNFMmhX?=
 =?utf-8?B?aGxqMGxpWnNYcWVjSi96U2pZZG5WZk96SkliakRrUm9ROTZKKzNYRGNNWWRq?=
 =?utf-8?B?OWZPemkxamFCcVFCeUF2SXFIendSY1hkanpwNmZ0NUwyYWRWSjV3V2kzc0xO?=
 =?utf-8?B?R2tGZ1ZjTVNQZ3NWQkNrNW9nMURxR3E5YnVSczN4bndSdENsa2Jjc3JpTE5M?=
 =?utf-8?B?MHJxSHpOcXFpekRweVhLdmczaVhBUWhvUFc0VHNia1QweVRPSU1nNzJZVWdO?=
 =?utf-8?Q?PXEggH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:55:21.1906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5d440e-fff1-4a5c-64ac-08ddf082726e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255

On 9/9/2025 3:58 PM, Dave Jiang wrote:
> 
> 
> On 8/12/25 2:29 PM, Ben Cheatham wrote:
>> Add a function for getting common CXL.cache information. This
>> information will be stored in the struct cxl_cache_state member
>> (cinfo) of struct cxl_dev_state for easy access by endpoint drivers.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 45 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h      |  7 +++++++
>>  drivers/cxl/cxlcache.h |  2 ++
>>  drivers/cxl/cxlpci.h   |  4 ++++
>>  4 files changed, 58 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 717e25131db7..2279c2690c59 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/pci.h>
>>  #include <linux/pci-doe.h>
>>  #include <linux/aer.h>
>> +#include <cxlcache.h>
>>  #include <cxlpci.h>
>>  #include <cxlmem.h>
>>  #include <cxl.h>
>> @@ -1187,3 +1188,47 @@ int cxl_port_update_total_dports(struct cxl_port *port)
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_port_update_total_dports, "CXL");
>> +
>> +int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds)
> 
> Maybe cxl_accel_read_cache_info() since the function doesn't return the cache info.
>> +{
>> +	struct cxl_cache_state *cstate = &cxlds->cstate;
>> +	struct pci_dev *pdev;
>> +	int dvsec, rc;
>> +	u16 cap, cap2;
>> +
>> +	if (!dev_is_pci(cxlds->dev))
>> +		return -EINVAL;
>> +	pdev = to_pci_dev(cxlds->dev);
>> +
>> +	dvsec = cxlds->cxl_dvsec;
>> +
>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!(cap & CXL_DVSEC_CACHE_CAPABLE))
>> +		return -ENXIO;
>> +
>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP2_OFFSET, &cap2);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* CXL 3.2 8.1.3.7 DVSEC CXL Capability2 for encoding */
>> +	switch (FIELD_GET(CXL_DVSEC_CACHE_UNIT_MASK, cap2)) {
>> +	case 1:
>> +		cstate->unit = 64;
> 
> Do we need to keep the cache size unit around in 'cstate'? Maybe use a local variable for the size calculation later? Also, should this be SZ_64K and SZ_1M? The cache size is off by 1024 otherwise when it gets calculated below.

I don't think so, but I'll double check.

As far as the size, I was planning on storing it in KB since that's the smallest unit the spec uses for these registers. I don't mind switching
it to bytes though.
