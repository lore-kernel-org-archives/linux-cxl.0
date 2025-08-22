Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E2119E97A
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885653; cv=fail; b=tJDz/duQxipZKMRpOp5iZ4999o5u5XmPmOiECmGw0urZvRJ6WAy0bYvhwNXiQAgDeEeiJ3jsnvBPhcXtXxroVfrIq7AUl03Lb9+UfsMtt1zS7d9QVWhYgwzJc11YTyBTGC2wp6nZmjnbAR/EOL0/WcwPxpdKEzPlmfbijcE98ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885653; c=relaxed/simple;
	bh=pykk2XiM7hV9Mx/TKRcTSJ0HWRT0qYslI2HMmJ6fisY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KKGjDGhcWYVdc8pbcfMNx8SuBtN5KpvMZt+mIOpxPg8EbADQPbaxHi7lhXGgbBRjEP3KvADRwBRa/PPDuGubsk04VyLmFJmxDoZdlMZoFFShMH2VaPo0m2NH8yGgXh5hzsoi4KmoOJBJWwfBL233spx5vTXyn4fKnZQAhtLDCXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jTLbASvl; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jTLbASvl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIxsEUD43ZIvkHxe2eRDbtNna5zjxX/9LRJaRwc/nHH4ptALL7V383HQZdcuRrcrVUvyZlXEon1PdMvfGjHhC7KiuQGbqDJjyEZ49U9amU11Iw6o+Fw4mGCVHmaB2anSyTgYhHoGXZP6NNrfPwd5JaEYLQqmwkLbwgwC6o/mrJLoXy1wrifZIXREYNtbqiXm15HWaggzdvD/kKDZSmdBV+eRSwe9T2xKRvW8mizn1l3MknjpXjDX9SrxHlz8GzFJb3n9ebod1mBPAvUOgSE6QqIjMwX12Fti4C5aDGgtdLerkYysNsQT8jbVvrOJ0hOBMQ9rZtEZxWQlvanIBb8Nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONM4NNVkVirQzzbo7wm+F6hoI6gA5twOzCb9pY3TTVk=;
 b=nSyRe9UAhp7rbnn46DhWSv/YcF6BNYoBmHF+/r+WpU1xtEzRz5bX9cL9BMQssNVpv47lc4zr6f8Q35Jp2elztWYxZDBJP+P47wWrlm3+//PvjfQ9OS+Y4zUAHAdnDi29pHg6UNThoOAgL2aU7/LAIflpNvTouPCJIfjlKE6cxBdKrYr/Qrtc8fthuoHvmMPGJJmnsDQvq72dvoVb5XfM96jyezRNaMhXGTWw5Y3rFOvppKjJ3cnthj9lTpsmAv8dDfoNVX3LYI4fUzmyLFqBLglNObWXA9+o9taXKlgnsNUv5JvkXcphMwMKV+xAs72WRE1eucBJJre80hsQWj1CWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONM4NNVkVirQzzbo7wm+F6hoI6gA5twOzCb9pY3TTVk=;
 b=jTLbASvlIUOOeiMVkS6Z0exWfQX+OVUvjkE6o5nM+NaEKKzC47rIFiTKbGwxs+kLYdis2HWEQ63J6fFZAhfo4NW1hHZ2Dtvq8TYfDIiplXyoZXYWuv3q6V55BhxM6dUKp5jVcXydxeynmlxX/2NC3skL5JmSMk4j5g5XkzGO4zk=
Received: from BN7PR06CA0071.namprd06.prod.outlook.com (2603:10b6:408:34::48)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 18:00:48 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::11) by BN7PR06CA0071.outlook.office365.com
 (2603:10b6:408:34::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 18:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:00:46 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:00:45 -0500
Message-ID: <57a32de9-02d0-420d-8b22-feddfaee7d30@amd.com>
Date: Fri, 22 Aug 2025 13:00:44 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/18] cxl: Move struct cxl_dev_state definition
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-3-Benjamin.Cheatham@amd.com>
 <20250819123332.00004cb5@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819123332.00004cb5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 00bcbfa9-60f3-41b8-50b1-08dde1a5d239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vis2UktoRXY2SmZLeHVyUng5em1tMW5aMkVjZmF3L0JxaG1kRDQzT0RXcVhl?=
 =?utf-8?B?eFFuL0RDUnovd2MyYUZXNlhYMVREUHZTa2dKVmRQRjhUWm4vT2lpUlg5b3g4?=
 =?utf-8?B?TzU3clA2cWxteFcyVU9rZUk2K2s5djFXdThFQnBWMVh4QnlLd1pJaXhpOWtQ?=
 =?utf-8?B?eXkwb0JKSzgveWl6SDliQUFiRzQycXR1dnpHYlUwNnpXbmg1S3h0cDBmbDdp?=
 =?utf-8?B?Y1N6dC9tWmRKN1lQRkxyR2ZETGtKQkVBbVl2QVAybWtyNFlNRGhpZGM3bWhC?=
 =?utf-8?B?WmlIbjhVdCs3MWhiY28rQTFOdHB2ajhXbVlyNXZlV0xHbW5tcGFwMWJ3cUJt?=
 =?utf-8?B?MTJFNDR3a1NZSFZraElUWjJKWmR6anZVcEpCWFUrOFdPZXVVSFZSU0dUTC8w?=
 =?utf-8?B?MFM4Zmp6WGhoVzdBRGxlY05paEk1SGROUG1rWSs1MVhlWHRzWTgxakI2YWwr?=
 =?utf-8?B?dDJYR1J2a25weHdieGlwelZ0WmJDaW5iL3NmS2xvNXR5Sk1QbWtYNVFJT3Qz?=
 =?utf-8?B?N2d2Zmhwbm5Sb01Pekh1em5NMFk4UnpoTmtmaVZoVEJ4amlnNnpJNnh5SURu?=
 =?utf-8?B?MkYwQXpBOWNlTkZCVW16ajUvSUFJK0xXWm5WdTJtcTdCM0pLUXF0dFV5MlBW?=
 =?utf-8?B?U3VQcmNJSkFqNHQ4d0JXSlVFQlEzL3RwQVJ2b3pVUXpOYk9aYzF1ZkIwR0cz?=
 =?utf-8?B?OFI1cUlMOE1NY1prNUJtM3pmakNLYkR1OGtNa2hES2tEc1dZV1pHdndHSzk3?=
 =?utf-8?B?NmJXVHJNMFZHMnlRclJhb3Y5YWVTOHRXblFHNHV1bktjSmFnOENVZXRZblV3?=
 =?utf-8?B?SXlyR0o2dVMxYlNTY3V6SzV2OXdlNmhsYzJlZTFQWWh2emZ6QU0xME9SL1VU?=
 =?utf-8?B?ZWJ4TU04R2ZCYmtTSzBiZEh6NEUydVBUbDR1NWdPRjA1WXVERFByWHJvSVNU?=
 =?utf-8?B?elJVOVJPQlJqZmZkMU5nM08xWnp0cDVBZGk4ampnZ1lWb3VONGdySTFSQ09X?=
 =?utf-8?B?QVArRGRSVzZ2dmxmV3JxM01wb09XdzZJRzBuL1g1MUlCRGIxdHR2em1JWWRU?=
 =?utf-8?B?OHd5WDd2eWJuQ0NRbW9wdnpOOXRIVE5hQytxNkVuenJ3a2FPNFhPREd4TnFB?=
 =?utf-8?B?OGJZTmJ3QzJtMm1BY1d4RmpBZEZXV2c2S3pDV1l2TGhKSzVkL0RSOEVmclc3?=
 =?utf-8?B?Um1HRVUyU2R5bHNwTnAwdzVkZG9VTWQ0VUVodk1PYnFCMnh2Zk4zSlNLWVhi?=
 =?utf-8?B?SE53Y0R1ZDNPa2ZISDVtc1ArMGhSaEJrVDRneDFzZjRJcjA0QTI1NkhEZWl1?=
 =?utf-8?B?WFpOK2NYVUthTmExNXdBSVdBaXpZc2hDY01wUGRKZXVYMWlJZFpkeTNUcER3?=
 =?utf-8?B?UmVqeEd3YlJTdk9FVmZ2TGF4K2l2MDhGWFFYTGVWMFU4T1hQdjB3a2h2SHNl?=
 =?utf-8?B?R2kxcE9aTmJ5bmdvVk9oNTBNN1BnUnoyWnkyZ0l2aDh1Z1kxQm1JVS8weW0y?=
 =?utf-8?B?Ym9EeU1hYVJ2RzdrMU42MTROUVVtclRFZ0NlWWVNdDdWdmR5bk5EWElRK3Fu?=
 =?utf-8?B?Mkkza3NUYTRJTjR1MHUwZmVabURZekRiNVU5QmdtYVBkN0NIQlFqdGMwZ0Zn?=
 =?utf-8?B?MkFSUU1PR2JhYXA5YWpybG1hNm5hdU9DbXA2N2pKclJCYlp1c1YrdzI4Znpm?=
 =?utf-8?B?WW1maVFMT2NUREUrRmhmUFExcFhqYlA3dlR5b3J6T2F6NFNSTmM4R0ZQN21v?=
 =?utf-8?B?bExnL0pRSEFlZFFCSFZ3ZWlvUXc3ay9FZ0ZLMlJhazc0SVliNmFNZzVIaHZB?=
 =?utf-8?B?ZzV2Zlhyc2xyUGx2R2l6UTE4WVYwRnNFdU9GWlA4bHdJdVdPMXJIT2JEUld2?=
 =?utf-8?B?RDFXSGczV0VIZTg2cWtDRWFWU0dPcmdvSmg1RDF0b21HK3RsSTJnU3VHalhG?=
 =?utf-8?B?L3BKMFQ3RXRSZUQ1WmFtbmRqaHVpUlhaWEsvczk1M01HSHJhLy9OT1EvSHBw?=
 =?utf-8?B?elE2TkZ5L2JRVVBMbFFYbnJ5MUk5NDl5bkVic2xNdi9yRjVxZGMyc0RZTE5E?=
 =?utf-8?Q?6OIsoB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:00:46.8403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bcbfa9-60f3-41b8-50b1-08dde1a5d239
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

On 8/19/2025 6:33 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:05 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Move struct cxl_dev_state (and associated structs) from cxlmem.h to
>> cxl.h. This is in preparation of adding a new CXL cache device type
>> that will also use cxl_dev_state.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Hi Ben,
> 
> I'm just going to take a first (likely superficial look at this) so
> comments may well be lightweight.  I need to get my head around it
> before offering more substantial stuff.
> 
> Jonathan

No problem, thanks for taking a look!

>> ---
>>  drivers/cxl/cxl.h    | 114 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h | 113 ------------------------------------------
>>  2 files changed, 114 insertions(+), 113 deletions(-)
>>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1de4fec5c8f4..751e5860423a 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -11,6 +11,7 @@
>>  #include <linux/log2.h>
>>  #include <linux/node.h>
>>  #include <linux/io.h>
>> +#include <cxl/mailbox.h>
>>  
>>  extern const struct nvdimm_security_ops *cxl_security_ops;
>>  
>> @@ -696,6 +697,119 @@ struct cxl_ep {
>>  	struct cxl_port *next;
>>  };
>>  
>> +
> One blank line probably enough.
> 

Yep, messed up the copy/paste. Will remove.

>> +/*
>> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
>> + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
>> + *			 HDM-DB, no requirement that this device implements a
>> + *			 mailbox, or other memory-device-standard manageability
>> + *			 flows.
>> + * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
>> + *			   HDM-H and class-mandatory memory device registers
>> + */
>> +enum cxl_devtype {
>> +	CXL_DEVTYPE_DEVMEM,
>> +	CXL_DEVTYPE_CLASSMEM,
>> +};
> 
> 

