Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B191A9F86
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995952; cv=fail; b=CzM9mDL3dCCVZ5s7mA3HhnmUd5+VT3cx66H9QZdQ+an5LIhIb+uO2I63MslE5N/E4tXGzcu4XISaPR1ElMeEpjCJH2fkrsoBDyIj04X88uA+niFRw+CjeG5YHK9YFN0D6lCILZlRgKIXLihSLvpuUXZtk4GdV43cWpf7zK6vJhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995952; c=relaxed/simple;
	bh=MapE2FIuaV1EW3ikRhiYBnGOz0oRnNmZdnGAelZz3qA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=lfmMv3RLvgY6O0+eDy0fQvE+uXSv7GF+aXcgn5M+qfCTGu+E8myqwv4GLjWBTqBFwNrwU7gI/z0V/o4MO1S8T1yoRTlioJpHZynfLgrt/qkTvgRE+JlAAIBwY8wOenjHc0OB8sBiCDMgeZaU9nPkuH0QAykHPXHrTKb4rHqo6lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lO6yq2Uz; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lO6yq2Uz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyJBZ3Ds38H+QvY/aauFA+NSXyyApQVTZKenB2B81pgnL9FqKXo0JRjIpJmui4n8ofZ3Ray8x/MYGUorhnwZMc0FM5WOCUCuajXT/NT4yo7DlFu6As2aVtp/oWNKl59YuNDwztrrNOsUYXCaCADtWtrK/d+tk/ZrhZE/smWIVWLLOumwyGA7bOOQYOH75RBSVOOUa1BPpTQ4zK7QbyD0oek+5ItgxwIDN7xNp5+qcGJcYRW1psHEz10SLkF0ssUfjGBxHt/59izVB/xj0O7noAsxawbI7K6Rkh6SaxPFLHMzgIZpZoTauCIrzI1PUtl3hxUTsRUfZdQX/raity3+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUDn/Jt6DSkmjkrEK2+5+ozG4YvuHpL5o+Lbmi92qWM=;
 b=D+/RAlufamWcHK8lT+1rf4J/ucHYD63XhRWHb15k8yFg+a3QjXenCUZh66gNOvrVL5IPFnS6dBqrdXBLGxR4rcxbgvhfjVltUAQf3DnktDccWGZpobDXCrLOpxNu9oaZ3MGTUG3QRdTRHnTS8F+EvTh2JKna4C/9R263HlOaeQdm0HPkVu8j/ruWboBzcDifqIOAw/vk+beLzjxe90ra6CXEIN1XT5VMp2mY9YvCozpeCm/9RlliC4P7OazVi8UdFjFnr3fsog9cVJuq0fxhKOs2wv0yWsUKPwMM3RGJG1b8xPeCP9qs1Q5Y2e5phykcz5nSWSnzuql2O0G8xX6RRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUDn/Jt6DSkmjkrEK2+5+ozG4YvuHpL5o+Lbmi92qWM=;
 b=lO6yq2UzAqUnrKTnZJFGEAWDj1076p3+pZIF39ziBbqcAiuDEW3hkRbsT6Oc9o3WL0OGE83qZLQpvoN6fq9yLt13alENpgNe+0IADiHiq4K9Fqh2F8DMGmKPOXJb+WxT3b9IhZ/FVIrjyfuebZig4ltb9e7ecYDymrx23Uzb6fo=
Received: from SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:10:44 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::a0) by SN7P220CA0022.outlook.office365.com
 (2603:10b6:806:123::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 18:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 18:10:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 12:10:37 -0600
Received: from [10.236.188.135] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 10:01:59 -0800
Message-ID: <816dd75e-cf22-4e8e-bcba-a88c48ac1185@amd.com>
Date: Wed, 17 Dec 2025 12:01:59 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 06/17] cxl: Replace cxl_mem_find_port() with
 cxl_dev_find_port()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
 <20251111214032.8188-7-Benjamin.Cheatham@amd.com>
 <20251217161839.00002a11@huawei.com>
Content-Language: en-US
In-Reply-To: <20251217161839.00002a11@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: ab59d13a-f76e-41d3-75dd-08de3d979859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFpvQ1ZRemEwV3o5enUrSTcxeGhzQmlRWEVNalBmVDBoWmRRWWJ5RzZ0d1pQ?=
 =?utf-8?B?MHVwU2ZwUDZXd1lnVi9hTUU2NjNueVY1MmlKYUtUMVJFOTB5S1BvdVVta3hz?=
 =?utf-8?B?MHRCbGJ2aXBodUo0QmtuMm42WXFzWWcrNUU2Y3E5ZXA5clZJQVNhUEFWSFdn?=
 =?utf-8?B?Z1BpZmZocDdnM3R1TUQzM3FsN3JGZ0l3NlV0bFdlZHl2N3hJS2lnaXlWZXR3?=
 =?utf-8?B?WnNuVUk1M2Q3d05iTkIyWDJUeFY0UVRqd3pMMnIyeUxibzJwcjA2ZTY2aFdH?=
 =?utf-8?B?UHVicmpnSmVLVi92dlZRV1ZpL01nUUlBR1ZQS2NHKzc0QWdmZW9HdDNzdHUw?=
 =?utf-8?B?SmxpUURURUEvd0ZGRlpNQTJiSHdyV3dKSkVDb2gyQzg4MXpOS21yOEhzMW05?=
 =?utf-8?B?clhwakIwZHFQVC9aQ0gzUHRRdG9PNU4zZFBsTGZGSm84eWxNTUJiNENOS3hX?=
 =?utf-8?B?ZjBkZk0wQU5VcGRPZkhXN0hRUDM0cU1lZ0ZVYVUvVWVDK2ZQWkF3MGdNL05u?=
 =?utf-8?B?WUlhSVdCRVRvKzRBbnVXSmoyWTlScUlaUlB6bXJMWTBUTkNTUG1nVWFkemlE?=
 =?utf-8?B?d3prbTA2TzZrV1lCVUQ5SGpSY3VVajEyUXlCS3MrTzhkYTg4MVlCTXl4bnZk?=
 =?utf-8?B?cllOK0ZkMmlnclNzSFNYTlQzblFUV2FnaWFDY29oeVlhSEJxU3JwZ2ZFa2dw?=
 =?utf-8?B?aHFBQ2pDaTFOL3h6cXBxNkcrV2FNbyt3Y2tNN3lOTEZhU2o3R3dyM0V1d1JE?=
 =?utf-8?B?bm84Z3ViWGJNZmZ4WFVjUm9iT0VyTWtpZVZtQ2JLcW5EZTBYaWEzeDJDdTFl?=
 =?utf-8?B?RWw4am9vZGpxdGt2SXB1cEVJREVkTlFINDZzekluaERiUFlUV2hyczc3cmN2?=
 =?utf-8?B?ZE1iTUluVms4MjRCcXAxYmhUY084TTdKSlJtNmdnVHpuSzlDL1JRRHZlUm82?=
 =?utf-8?B?TGoxV0YvNXV1K2lsRytscFNDYnNVTkFwdG5zZU5laEpzZkpDeWZQaVQvbUsv?=
 =?utf-8?B?R1VrVTU4cnhTb1F5RkNieEJtWEtwbzFnYXN0Z2lrQTgxNHRnMEVPV0ExMVRx?=
 =?utf-8?B?MjF0ZzRvblRLTXlJQW4rSTBsUFA4Z0xwMXFod3dJMmhmb2lhNWlPNUJBallu?=
 =?utf-8?B?VkYzdk9XNHdBOGJYZHM2bFBVbjNKZVJ5d1RzSmRjOWp0MDE3M1BmeTltWjhO?=
 =?utf-8?B?U0l2UW5GclZGdHowT25zbFhGdGNWNG9YcWU5UWdMNy8vc0MxWWljdlgxcUkv?=
 =?utf-8?B?YlNiVE9kSXluZWJqOTgyNWo2ajFIWVJUOVFqdWo0cURpWVhrRmZxR2krOEhw?=
 =?utf-8?B?bW0vOU9RcWRQRSthMncxeUgzRFp2Wis2Uk5kQmRlN2Rzc251L1NBaXUzdmEw?=
 =?utf-8?B?eCtJUHRFVHZkRWMxNVRjOW5FVUZuclN5cjFJaVYzQlNjZ2J6djNadDBFbWNC?=
 =?utf-8?B?dTJ4Qm9VZVpEeEozejZuL2pxNE00dnpEeCswR0hxS3VKVERPWSs3Qk82RnRl?=
 =?utf-8?B?dDZpWG1sWnltWitkSEVSbHMwaTJCWG9wTVZYNzdjZjRhVTdHbFNiZ1NNR0hj?=
 =?utf-8?B?U3VOTk1wckE1NWZjVjVyM3E2QU9tSWptRWRoM21iUUc1bGh4NUZxdktwbTRm?=
 =?utf-8?B?SnJOOHljMGFzajhYWlNHUTZUUkRnbjNWaXpFR2hvUlJZcWpCSDU3clN6TUJj?=
 =?utf-8?B?Y204ZkxSRk40QVRzQUhZNHUxTVcxN3BCbXVpbU4zMGZWdmY5NGNvMTZIZlhE?=
 =?utf-8?B?Nk8wRVFyMURab2V0M1hpQjVaR0UveXRzRURMc3NUT2RCZnkxY2U2Rmh5ZXB1?=
 =?utf-8?B?ekJKQ3FrUEpQWUp5bHpZSHNtRnZBUkc0ZlRuNiticExJb3pMZUhwM1A0SmIw?=
 =?utf-8?B?UWhXUmVUUjljY2lXTUE1OThTb1hiQ09LTWZqYXhTaEFYQTJhNVVoa0ZjZU9x?=
 =?utf-8?B?QUt2QzdmZkRhQVViNE5lTVhEbTl2WW5aSkFuNU1reUhEcC9lRVhhSWNSdjEx?=
 =?utf-8?B?ak1CcXNPcWJNYUhpWXdPZnlyQ0pyVFJHTVgreTNkdVdGSnc2N01hZFNMbkI4?=
 =?utf-8?B?dVV5V3U2SFErcHU0N2JIS3NhV3dvUW1za0pMNzlEQWxpdisrVnNwZE04UWdG?=
 =?utf-8?Q?H/PA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:10:43.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab59d13a-f76e-41d3-75dd-08de3d979859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102

On 12/17/2025 10:18 AM, Jonathan Cameron wrote:
> On Tue, 11 Nov 2025 15:40:21 -0600
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Change cxl_mem_find_port() to take a struct device * instead of a struct
>> cxl_memdev * in preparation for adding cache devices to the port
>> hierarchy.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Maybe we'll bikeshed the name in a future version though.

That's fine by me. I don't particularly like it but I couldn't think
of a better one.
