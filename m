Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA520EB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885716; cv=fail; b=kQoYfQvMDfehEVmUJ7mDzXu6NVVZ/jKz1YlcX40qEhUoS+uC8upreEKfZKmY+U0hXg/FvPj3xIss0BOyRB/MuTPp44t1wmgLTimlyXoZldGcQNcOlTgY7xPdsu1li8MX/VvnQbwDp1Rdks2CP4I4VVJ+BcUHg8hlo+8cmOB5Wtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885716; c=relaxed/simple;
	bh=ahLaENc/ZDLryJgovJdi2tmQbnQPX+sSWIl3/J4op3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lPqb/ZfYLkyzjKv5PGPQpGo2Ha0+X+fBzFc8yscF1pM5Ff+FwZm0s3AOl3eQRjbObNi/1Pr38f8GSzyXnGhItXKmxvOp+NRue980iqPf0JVd832nFihxBYG8512L4acv8BgjPYq7YZGpmDHtXRcKjjsvgKdD52K4w4SGTW90GkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H8dfpU5l; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H8dfpU5l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olnCcTMZTWETLwUO8HdRL6qP9+yoOG4mg8I0H7cFbehZDwL+Ii5SdYZZvYh1rH2TtStWJMolagzKsxumZmlLuEM7wFeNPapfU1wyUSLZdV5uqFbM6yozLcD8dk+uROqzWdzKzy+uUky5Jq/SCREx/aDMDPAKK7fbK0bnTomUfZEYDGa/MagCQm8k1jBiUfC617QaCwB2DBrTebDGiXs8nsB9fbvNK/IW4pp/8LOdszxG1oOxmWmU/d14Z4FznKQ84MMWd87dAqCsXRWU3o9VHFk8e4e0fLhw4y0Yz4/yqgvj+4BNm0FlBfZMx+/0VAHi5fWZaGheAEQtgrAkJe45oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2weofE6CUtcIUFsONnNi4ne0rMGsN6awD4h8NPb2gMs=;
 b=v/QcQquflM4fxlQN+DfowEw9ujiE/AWA4U2o/wGHK4pAY1AqP9JMK5qGaoKhlEtQPi2HHEzagTi4q47IPbJ7aJxQyU3d6R7eP4/PcxySa0QTEkj2gZ2kna94N0+nXQJbhKNkQz9sM7Ligg6EKOdFpV1zvmegTv/fNn/FSizmOxPcde7UlKTKcKsMhuesaELBfdTyZl9p3cDHJl+yZhXDR+3bn+T59SBo0oBQLK0i2xh5HrLGfn+H8Ih0aSSn3/mN37zi2kZTPsAvrbHntSFUTGgxRzQ6URVi5t/J0SyhsCFVYKUqPsIAQG3UJdIEFqYn2DJymYTZc8lkN9XhVqlUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2weofE6CUtcIUFsONnNi4ne0rMGsN6awD4h8NPb2gMs=;
 b=H8dfpU5l4Gl2kqxhjGoMDHs6Os2X9Ht4g7BQvRRKmj6noE/N+IFaWjZOtQJXEKDC1MqfubVqvPVWoavALMh+qCP32sRfaY1WrDSqy9K6/f+iiBiPtdlnX9WXJgtDIYobYqBcJJX2PcGGZXpGIepfg5wI55KvmCi42VnTkvIqfgM=
Received: from BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::30)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 18:01:52 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::f1) by BN9P221CA0008.outlook.office365.com
 (2603:10b6:408:10a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 18:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:01:52 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:01:51 -0500
Message-ID: <063a72a6-b0c8-401f-a969-1ed8b88c11e5@amd.com>
Date: Fri, 22 Aug 2025 13:01:50 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/18] cxl/cache: Add Cache ID Decoder capability
 mapping
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-15-Benjamin.Cheatham@amd.com>
 <20250819151258.00007ed8.alireza.sanaee@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819151258.00007ed8.alireza.sanaee@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 04149eca-ed30-4440-d496-08dde1a5f91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE5WQ2F4RHhSd0k4QXJOTWRmRFI5Ny9zMTY1cGVnWVFMcm9PRDVNMXhDU0NC?=
 =?utf-8?B?bDMyN1VidWNwZ0lmMFdRaTR1d2pmbXNMK1pmaTZoVk5seVRXZ0hBL0JTbXZz?=
 =?utf-8?B?eGx5WW85NUx6VC9DWWp5dFlUdkxEMkh0TlhHNmkyOWdkM0hIZFBQdjdWOUtG?=
 =?utf-8?B?eUVCWFp2NVl5U2ZITkd3RWNwaGt4UU9jLzFzbXU2THk5YzAzVzBOckdncHJX?=
 =?utf-8?B?YjNkVjRXNHlLb3JXczlhSVdyUU5EYmZFODE4RHBwMDFvTmwzOVdIYnpLejk3?=
 =?utf-8?B?aFNLNmJMbFBBalBQSG1nSXFzRUVEMGFXTlRYRlA0WVNTYmUxTXRHMXNWWnBt?=
 =?utf-8?B?emtrN3ZzdnAvSXIzekE2Mm1xcVlGYjlyNi9FclRxYkFyMWFUdDROclUyMC84?=
 =?utf-8?B?MVhLUnhZVUYyT1NJVHBKOGxaZGtORzdyOFd3VzJCWGFxQ3ZwM011QzNLUlBp?=
 =?utf-8?B?cnFsZ1RMTUo3OUZHU044RzBxZERiWm5NS0JiRHR3N2JEWEtjNVZHR2kzRXJu?=
 =?utf-8?B?b2xMMmFsM3FOc1B1LzM3TWcrRUoxbGJSWENQb2ZCT0lmV216TU81enZ5cWdW?=
 =?utf-8?B?SEtwYUxWcVd4YUw0Tm1VV2FzVFFhSjJaOHVXTHhvcTFYRG1KVnkvTlUrQlFW?=
 =?utf-8?B?QWFpOFcvRDBQUXEreTRLYzRZcVljbHhxdkk5L1RoOFlrdFF0RjZjUjBNZkFZ?=
 =?utf-8?B?emV6aXBWRUlDNjFHNjQwYkkyWDNxMlc2NldESzRQM0FZNEE5WEthWlBNMWMy?=
 =?utf-8?B?dkY2SzdXVVhLcitxN3ZvSEVZeTUwbkdrNUIxUzJQK1lucnVvdkZaQmxZRlNN?=
 =?utf-8?B?OFFlRFV2clRMQUZmalhxcUFtZkpiOFVhWjRmL211b2ZlQWNONkZaZm83V29I?=
 =?utf-8?B?TmVBZ1lBRHk3c3RYVE1BdG9lOHlDWk5XN2NaRXdXWjNIeW9teWM4N3NOdE1O?=
 =?utf-8?B?elVzS3JXN2xnd3h3R0Y4ejM0VUZiUHBWUS9JSU9CRVU3SXNvdCtVL0k2TDNW?=
 =?utf-8?B?MVZTUk1FS3IvcTYwdDZFdVVNQVVpRU02ZERLUzVKMXFLdkdPS3AxUWVzWG8x?=
 =?utf-8?B?WnJQdHdCempkdklxeWd2c29IUFcyK3J4R3lHVUVXdGZLbGZGOXYwTGxQQ0JN?=
 =?utf-8?B?aWRGODJUbExOS1JpMWtmeGpPU0xWSzVjcmZzQUIwZnlwVTlMenpsbDN2QlZI?=
 =?utf-8?B?ZkNNVGN6VDRqU3ZCMUZHSlNQdVZqN1B0eklSenRobU1ad2tuZnArSnVxdUhv?=
 =?utf-8?B?NkU1cXF3QUxKRDNzU3Q0TUFGTGNOd01uTDlkeDVzZE5MVTF6ejVGdGgyTVUy?=
 =?utf-8?B?SkhMSTZWaHF1MW9GeExDRTlMdmI5Y1YxUnBRMjJaRGh3WTdITm4ybkQwSnFP?=
 =?utf-8?B?d0JqZkRhUCs4ZEtObElWYWpVS1VROGRMcVdBNWFOeXlaN3BIUGxNUnV6TzJ0?=
 =?utf-8?B?N3lzZ3hxYzFwSldhMENDZVM2TWR5bXdkeEtYRW04UGFtWEF4SXM3U2tIejhR?=
 =?utf-8?B?eG9OMGtZcGsvU0tiSEs4UEozemFpSldYcGMvRnRmeEgrMFhTZUg1bGozQm1X?=
 =?utf-8?B?Q0N2clhPNU5kVlRIZkhXMk9NRy95Rmh6UzBhcjVjTlhOSW9kQzh3NmtmL3Ft?=
 =?utf-8?B?blIrUXduVnd2bWhkd2tndWkxT0NCZnVIY2JTdWpMWlI2c3oxRXhtQWVlT3ZT?=
 =?utf-8?B?amlTYVNqTlFYb1ZaaTNCSVlnS3JVZVI0MDc4RkpKbHE0NFNGNmVEQlByWW5V?=
 =?utf-8?B?anA4RTNlNzJnaEpZTEI3OXU1TjAvM0Z2ZVF0cnd5NjRKRGdrY1lqKzZHTUFh?=
 =?utf-8?B?ZDNhMk5hSjA1V0d6ODhWTmt0RUUxTUM1MmFzVWhuMHZuZ1REYjFGdjQwdU1Z?=
 =?utf-8?B?TXlNZ3lvaHR2aGg0T0xjQkFMS25yeG9ueE82RTE4bkpwTmxicExzdDR4cHlt?=
 =?utf-8?B?a0hXcUpZQnhRTmJQSWxtUVU2NklCbFd1d252cWZVOGtKbDdmcG9TVFp4cTlX?=
 =?utf-8?B?ZXFwMHM1a3cxOVpaa1RDMXZaY0xvK0ZTc21uWTQwOVdiVXhKSEg1Mk4xWWdx?=
 =?utf-8?Q?mlk0WN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:01:52.1329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04149eca-ed30-4440-d496-08dde1a5f91c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211



On 8/19/2025 9:12 AM, Alireza Sanaee wrote:
> On Tue, 12 Aug 2025 16:29:17 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> The CXL Cache ID Decoder capability is an optional capability present
>> on CXL downstream switch and CXL-enabled PCIe Root ports. This
>> capability is required for having multiple CXL.cache enabled devices
>> under the same port (CXL 3.2 8.2.4.29).
>>
>> Add mapping of the capability as part of allocating a CXL cache id for
>> an endpoint. Implement mapping/validation of the capability in a later
>> commit.
> 
> Maybe you keep ID or Cache or Decoder consistent everywhere in the
> commit message.

The initial mention was to match the spec, but I don't mind unifying it all.

>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/cxl/cache.c     | 25 +++++++++++++++++++++++++
>>  drivers/cxl/core/regs.c |  8 ++++++++
>>  drivers/cxl/cxl.h       |  6 ++++++
>>  3 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
>> index 24559b9ba8e8..f123d596187d 100644
>> --- a/drivers/cxl/cache.c
>> +++ b/drivers/cxl/cache.c
>> @@ -69,6 +69,27 @@ static int map_cache_idrt_cap(struct cxl_port
>> *port) BIT(CXL_CM_CAP_CAP_ID_CIDRT));
>>  }
>>  
>> +static int map_cache_idd_cap(struct cxl_dport *dport)
>> +{
>> +	int agents;
>> +
>> +	if (dport->regs.cidd)
>> +		return 0;
>> +
>> +	/*
>> +	 * A missing Cache ID Decoder capability is only an issue
>> +	 * if there are multiple cache agents in the VCS
>> +	 */
>> +	if (!dport->reg_map.component_map.cidd.valid) {
>> +		agents = atomic_read(&dport->port->cache_agents);
>> +		return agents > 1 ? -ENXIO : 0;
>> +	}
>> +
>> +	return cxl_map_component_regs(&dport->reg_map,
>> +				      &dport->regs.component,
>> +				      BIT(CXL_CM_CAP_CAP_ID_CIDD));
> Less relevant to this patch. It looks like cxl_map_component_reg
> receives redundant parameters, both regs.component and reg_map comes
> from the same structure and other occurrences in the kernel also grab
> components and reg_map from port, so not sure why two separate
> parameters are there.

I *think* they used to be separate and it's a relatively recent change to
store the parameters together under the same port/dport. Good point though,
someone could probably take a look at the usage and simplify things accordingly.

>> +}
>> +
>>  static void free_cache_id(void *data)
>>  {
>>  	struct cxl_cache_state *cstate = data;
>> @@ -138,6 +159,10 @@ static int
>> devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd) rc =
>> devm_cxl_port_program_cache_idrt(port, dport, cxlcd); if (rc)
>>  			return rc;
>> +
>> +		rc = map_cache_idd_cap(dport);
>> +		if (rc)
>> +			return rc;
>>  	}
>>  
>>  	return 0;
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 0924127bd8fd..1362f4156ee6 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -110,6 +110,13 @@ void cxl_probe_component_regs(struct device
>> *dev, void __iomem *base, rmap = &map->cidrt;
>>  			break;
>>  		}
>> +		case CXL_CM_CAP_CAP_ID_CIDD:
>> +			dev_dbg(dev,
>> +				"found Cache ID decoder capability
>> (0x%x)\n",
>> +				offset);
>> +			length = CXL_CACHE_IDD_CAPABILITY_LENGTH;
>> +			rmap = &map->cidd;
>> +			break;
>>  		default:
>>  			dev_dbg(dev, "Unknown CM cap ID: %d
>> (0x%x)\n", cap_id, offset);
>> @@ -231,6 +238,7 @@ int cxl_map_component_regs(const struct
>> cxl_register_map *map, { &map->component_map.ras, &regs->ras },
>>  		{ &map->component_map.snoop, &regs->snoop },
>>  		{ &map->component_map.cidrt, &regs->cidrt },
>> +		{ &map->component_map.cidd, &regs->cidd },
>>  	};
>>  	int i;
>>  
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1a2918aaee62..04fde1a994d0 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -42,6 +42,7 @@ extern const struct nvdimm_security_ops
>> *cxl_security_ops; #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>>  #define   CXL_CM_CAP_CAP_ID_SNOOP 0x9
>>  #define   CXL_CM_CAP_CAP_ID_CIDRT 0xD
>> +#define   CXL_CM_CAP_CAP_ID_CIDD 0xE
>>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>>  
>>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability
>> Structure */ @@ -176,6 +177,9 @@ static inline int
>> ways_to_eiw(unsigned int ways, u8 *eiw) #define
>> CXL_CACHE_IDRT_TARGETN_VALID BIT(0) #define
>> CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8) 
>> +/* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
>> +#define CXL_CACHE_IDD_CAPABILITY_LENGTH 0xC
>> +
>>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
>> @@ -241,6 +245,7 @@ struct cxl_regs {
>>  		void __iomem *ras;
>>  		void __iomem *snoop;
>>  		void __iomem *cidrt;
>> +		void __iomem *cidd;
>>  	);
>>  	/*
>>  	 * Common set of CXL Device register block base pointers
>> @@ -285,6 +290,7 @@ struct cxl_component_reg_map {
>>  	struct cxl_reg_map ras;
>>  	struct cxl_reg_map snoop;
>>  	struct cxl_reg_map cidrt;
>> +	struct cxl_reg_map cidd;
>>  };
>>  
>>  struct cxl_device_reg_map {
> 

