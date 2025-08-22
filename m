Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDF420EB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885677; cv=fail; b=Dauom7CFnH/4/ah45nQxRPmbo67qirfurAbO+gPo8z7djuKDxompnyl7Xno2oaTk0Y5AOEfrzF1wyMResYZc+QBnyCl3yi2k4Cm3RTt6BmAO2ic+ObxlGMJqOI+4fkOS/fHklf3YugWW7KrfYh0yyHabbPOn/CwofLgGnJ0e/XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885677; c=relaxed/simple;
	bh=eBoGP3H2KvPM8axbAB6hTzSFSeSNeOc+GdWkEMfJmAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aJhUb23Ut+b6UjuNOZfbP3vS9w9JryAazs283ZLtTSNwH+CMvStmUCkdq0AklNbHoz2Qq0aeBh125uHMSOQ05XISlo0yid3+cP+gqcDvc93XNZK2z8XH8fuQEayGiG6Xb1SiF7RxMOe6pQHQ31PLeNbP69mbFL1rwTKFESfm+u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V55UTBB2; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V55UTBB2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIT4W070J1EAPs3RHLYsNgSMmy4iHGex4qIpHGPwV3V6Z7hQzKYczkC/ec/iyNUiSjZpBv65TQLpyKdql358bK545k29sVxLuCU3xBQwrNXac+pluvAnerPRrmQzQTY0YHnnD+kP9lzi09gLzaKyCK4Xf96gziMliF08phZJRDHw4xgzZ/MkcOygC3gAHb7k6XZlgVDdHonc0LF8r0e/Xu+80D7XGBDAraqkTqVGrcNBvOYMvK5emBYfmwnAjon5548pu/IWrqfJ5+jCqTGiqEfLyJT6l9L7ABv560fre7eMYXXnY3d9es3YNeuxbPYP0rkTuYC/AOIFCc42XrJHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kVYAwdl5fsqXsvSjrXx2ykPJzJbQus/BU510YEmvIc=;
 b=tKExy0rNalTFkdgcQ0qn0HXO9h9gKX7Txu9M198Wj6h0LOt4/MiCotZtzo4XoxDPDLpJLUNZGstGHgIywMvde8iD66u5sWoa7VK/T9WWi3MI9kQYJbIOlx/FoLs3VBrFdiSU3C4FCku5lJ2O7XIfhGSwbFwiCtchg5AoQ7mWxj1deqFHti8x3LZn1pKSXGR5Pz3gMY49ZdSXHql68YuUymS/TzpYqtlNFodSWFjVJM2p6q/cen4DYOlzT3Ut+AJcKYcVPejJCjKwUyy44g4tRCN4yd3ArUUM9FFvyvjaE5LCs52tG1Ex70B5jpZ6K9ctoMsvAxdEvPZ58IILMSuTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kVYAwdl5fsqXsvSjrXx2ykPJzJbQus/BU510YEmvIc=;
 b=V55UTBB21KQKbt3/QiNLXG1LKfaBtNjcUWIlDySBqReGKGfUWPzEHqIpyCgpEQJSbjsC1jy0rVJO6p+dmbB6K8D2iDSXT3BVZQgVemfJpTPChlVKKoOwA5lRczx6A3Lw6J8UZbq/60nNmOl54eacPg2kQDuUr/2WkTUmDUBXEv4=
Received: from BN9PR03CA0656.namprd03.prod.outlook.com (2603:10b6:408:13b::31)
 by CY3PR12MB9703.namprd12.prod.outlook.com (2603:10b6:930:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 18:01:14 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::73) by BN9PR03CA0656.outlook.office365.com
 (2603:10b6:408:13b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 18:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:01:13 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:01:12 -0500
Message-ID: <7fa7bc20-42ef-4582-a586-4b9fed289671@amd.com>
Date: Fri, 22 Aug 2025 13:01:12 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/18] cxl/port: Update switch_port_probe() for CXL
 cache devices
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-9-Benjamin.Cheatham@amd.com>
 <20250819130353.0000659e@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819130353.0000659e@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CY3PR12MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dd7a76-bf9a-4e0c-22f1-08dde1a5e202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RE5vbzNNRzM5ckg1MlpKL1grMGNFTVBWYW41SzlKQW1ET2Mvc0dSQlJBbW1L?=
 =?utf-8?B?V1FiRTRjR0pMNVoyQzJOUWYrbHkwMWpUaTFoRFNteUNWSlBraHY0RmdYQ3Nu?=
 =?utf-8?B?V2I2SmJ5WENKa1NSMzhlTWpuTEtrRmZwWmNrU01LN0FMVVk0dWhzTndUand2?=
 =?utf-8?B?VTVOTmRsWFVmajFYbHRSZXRMTG53ajE1Y3dHZ2NUQTI4dXVMc2NncVpZcGd6?=
 =?utf-8?B?ZVcrU1ZrRi9RbWdNYmRnSis1K3Vjb2FBNzhETkNDZFpqN3V4MVkydW1McFZF?=
 =?utf-8?B?OWVMRU0xUkdBYzU5cXBKdW9HL05hdXhUZDh5WU84TURzNDN4NjFPc0pLcWVq?=
 =?utf-8?B?Z2ttM05IWElkY2pZMFBLU3RyZkJjUEt6eDJnSTU4RDEvOThzRnZlWC9yc2tQ?=
 =?utf-8?B?cWxvWTdHWW84bGcrRmhDSk9vS3pYeE9jNGVBdENQeUsrN3F2QWdpU3BNdGxT?=
 =?utf-8?B?K21yVmw5Y252bzhmZVVnbWxkbnNwUmVHUC9iV3Q5MytkU1ZVZjVvUjBOZkg2?=
 =?utf-8?B?dTE2NVRIVHN3cFZQekZvdU1qenBnSnU4bEUzQ2lJc1g2R1orbHc2eHVDa0xk?=
 =?utf-8?B?bFRhdkpNNitNODJjTTdXbGJTVDdtbzB4dmJPSGFTQXNDdFpGSmtZeXhpVHVI?=
 =?utf-8?B?RlYrK0trQ0c3VHhIdzIwclloMXdXMGJKcWRPcmROVlE0T0lKb1NJaytEMVZw?=
 =?utf-8?B?RmJPZWhkODdSQnVDN0RVRWdhZFY1VkhMWXJRZGM4alIzelpOZ2xpZ2s4aDJQ?=
 =?utf-8?B?aXpHZHJhNXk2V3lYZXRLTEZrWCtJc1NMMmZ6MFM2TnlENE00VExCZmc0MVNL?=
 =?utf-8?B?Sk1tNFRmcUZvYitMM3dKbklTdDQ2ajBoVXp0QkZ2YmRNR28vb29OV2JYc1I3?=
 =?utf-8?B?L2poZ1c2dzFPNGhDQ2pjUjkwSnovSFhPeU5kS1VRblJEQW5yWUl2QW1qZ1pR?=
 =?utf-8?B?V040MkRuSVBvUkR4QUdlMStjWkU0bUxLZU9SSmE3WHl1SCtJaXl0RlhZWTFv?=
 =?utf-8?B?S3V6U1JsQkt0ZDNmUEV3bm5INWpQaXVwa2ZZM2hleVFObm4xUGNld1BpUnBm?=
 =?utf-8?B?dHJvOU1LQW9mRWxMRDhZcE9zcGxFelN3bkVuSnlhZkxpdmpHZHZ5dElGcFV0?=
 =?utf-8?B?Y0VOemFwQ3ZQQzVaY29zeEM1MDJCSk1yZDAwQjZVQ1NvYXFoZElJQU90TUsy?=
 =?utf-8?B?M1FkVVF1OEF2aWVYOElxSmx6Sysxaks5bXJVTXdjQU15bHp5ZlFNSmZmNk1m?=
 =?utf-8?B?T0lVbW1oL3dZZW04amhwK0oxTTk4ZTd6MjVrRjFxMjZLUjBOcXdsVDBzaGRT?=
 =?utf-8?B?UlJXbkxyanIzUmVzSTJmRk9Xbmc2UzBqNXUyVTB1Tktldkt3cElpbVdpZmZz?=
 =?utf-8?B?dXFpMzQ3SUhFNUNCdlV4enNIZGc1RGlXTEpORWEyYjZxYXJaNFB5OWRYNWVu?=
 =?utf-8?B?NnNja2kxbVYveSt2ekl5MlNzRlBJVkFmSlB5VkpNbE10Qk1rZlZxUVZzTkF3?=
 =?utf-8?B?dC8yVW9ZckloZ2c3M2Zva2xNUVdDQ3ZLVHYxWDdCZkFkWHJKU2g5RU9IMEZK?=
 =?utf-8?B?ZEl1MkRlWHhuUEh6bVpBclNaZzZzS3IvcHdNam12bXdRNFJXRXFzZUNhOUxn?=
 =?utf-8?B?amFJOUxIYnozTzZmNUdxNEZ3amNQRExUdTBHa3hqQm9OM0lRUFhiL00xaVNM?=
 =?utf-8?B?Rm9XNXVBUGVDbzFTWTFzTkxsc3dKbzcyaG50VWVEV2JlejQ1WEtxdDM0eGxP?=
 =?utf-8?B?RkplUi9rRWVxMXVnY2xrOTlaeXk1STZHd0xQME82OXBLckdIMTBZRFRTRTFp?=
 =?utf-8?B?cEQxMWVSUWRCVVFVaFphVFpXTTVwa2ZnNE5nc1BYbnVsclBhNCtHQmpJaGJ2?=
 =?utf-8?B?SFhJQXlXZWZVOVp6R2lST3o0ZVNTNkxIaE10Q0JpNTBaK3I1SFNTMGU0Q2FB?=
 =?utf-8?B?OHhLV2VxL21xS0dPamJLSTZIcDRjZUozOVZ0Z0FoUXNmcERwTytDZUVGV3h5?=
 =?utf-8?B?SUdvcENxbkxXbVZ2L0oxNURXMDZpbTMybyt5bG55Y1pGRTA3WXl5aUlTS2Zt?=
 =?utf-8?Q?PegCce?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:01:13.3699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dd7a76-bf9a-4e0c-22f1-08dde1a5e202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9703



On 8/19/2025 7:03 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:11 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> CXL switch port probe currently assumes there are only CXL.mem-capable
>> devices below the switch with preconfigured HDM decoders. Now that
>> CXL.cache devices can be added below a switch port, it's possible that
>> they either have no HDM decoders (type 1) or the CXL.mem capabilities of
>> the endpoint haven't been set up yet (type 2).
>>
>> The HDM decoders being disabled (if present) is no longer a gauranteed
>> failure condition when only cache devices are present below the port.
>> Knowing what kind of devices are under the switch port isn't possible
>> until the endpoints are probed, so delay HDM setup and validation until
>> endpoint port probe.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/cxl/core/hdm.c | 31 +++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h      |  1 +
>>  drivers/cxl/port.c     | 23 +++++++++++++----------
>>  3 files changed, 45 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 865a71bce251..6e04f1f4c166 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -205,6 +205,37 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, "CXL");
>>  
>> +int cxl_validate_endpoint_hdm_setup(struct cxl_port *endpoint)
>> +{
>> +	struct cxl_port *sp = parent_port_of(endpoint);
>> +	struct cxl_hdm *cxlhdm;
>> +	int rc;
>> +
>> +	for (; sp && !is_cxl_root(sp); sp = parent_port_of(sp)) {
> 
> Might as well set sp as loop init rather than earlier.
> 

Yep, will do.

>> +		cxlhdm = dev_get_drvdata(&sp->dev);
>> +		if (cxlhdm && cxlhdm->decoder_count > 0)
>> +			continue;
>> +
>> +		if (!sp->reg_map.component_map.hdm_decoder.valid || !cxlhdm) {
>> +			dev_err(&sp->dev, "Missing HDM decoder capability\n");
>> +			return -ENXIO;
>> +		}
>> +
>> +		if (sp->total_dports == 1) {
>> +			dev_dbg(&sp->dev, "Fallback to passthrough decoder\n");
>> +			rc = devm_cxl_add_passthrough_decoder(sp);
>> +			if (rc)
>> +				return rc;
>> +		}
>> +	}
>> +
>> +	if (is_cxl_root(sp))
>> +		return 0;
> 
> Could move this test into the loop, alowing the loop condition to be simplified
> to just sp;
> 

Sure!

>> +
>> +	return -ENODEV;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_validate_endpoint_hdm_setup, "CXL");
>> +
> 

