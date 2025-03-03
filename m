Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106191F03C4
	for <linux-cxl@vger.kernel.org>; Mon,  3 Mar 2025 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037194; cv=fail; b=byBHRI1a9bl/vb3gwPq36wO+4UQFYAJ95QdJYpzeHord+MNNzYAwzGt+JFk1HJBNxP65Mqlx2Tj1Ad4Nd1D5CWgT8SEMTbBeOG1Oer+1b+eDl3CyuoBcSHsbRTQSRRQiOE1goURj71BWZabqyNew2mEcMnwLqfsIVBKDbdSSlBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037194; c=relaxed/simple;
	bh=/qO3icOs8rWdouferYxPmCh+CqV8VrwIQEPLoqDuK0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b7K+oGhhw6wNMR9aklPhEL9/Cm7DYLiuHcsvHaKxQ1lY5rWfFUi1ozjve0g5p1FTPshZHxweG/Fmb0CkOfleZdGbaGxfxG1663YqV2o3mBy7bt5DDfjNpkMpbYciTNKw8w9Hc2yyNf8dbSO8+S9PLoUJMGUpQTCoH88gKQWzM90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iy7eFn+W; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iy7eFn+W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0/59x1ywKrYueNfLhH2ULE0k7Uc9OSNQ3ZeasytaJmPaqpWnD/NNBeGgcaujYwmBJV+3TAGMAxIDhidtq9FpCIrVi3SAxROdTiaYsqwgIWgmFd32/ZSknKCcvrxOeT4foeZameGaxQwGf2j2eOgI1Rn/8B9zleu3GEsiwCBCrDXvoG2JwifGRJeW0NUNORrFE+WSzAGrmUTlIB3jGRES3bSGdArbMeqG+cbXpUA6OwM4hF7mVltGPAGOpepV8EC6fLwHw+coiHe5gqigkvgcY7nvHy4kUqyZLTeZEFPHqPflUF6dnkCyQERGRg2sQCWPsfjEwqq41UQVqPbBONfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFL2lnZMlfqf0t/9KG/Q0mFNyCmQy7HUBV0GpHBudIg=;
 b=d3TKMaaH152h3ppI/G+bC9OAMjxAguhhZ0KAMdVk9Bh7cZfhwYdv/qHWMPCmO/Vp1yNGq6HaxVNpSD/nItrfErcYCRzH/jBCyltDQ2+29gAf7D88Hk/k5cFT+c17AxJOWnBn+4WiEc3e4ydBrZ0KmAbYnPBePooBRKF9eCEDtUpD2nMGtHYSpxyT4kRHMBljip/OOqSaNqY3WYfMAiRZvxqvooLr5zWfihEIQow5a685MB1SHU1RxF7nZj2iFKuZ9a/84zT+9AZHZQLt7EXoxfD2RuSJU6tQ1RmSyjAOhyrKjKBQEu5OeZz5oXOoMCMPI0KSJTumGOMhAKNhjv9fHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFL2lnZMlfqf0t/9KG/Q0mFNyCmQy7HUBV0GpHBudIg=;
 b=Iy7eFn+WTiltwCFGJ/ur+UFj6Evefe+PA1/i6EJ6+3nh48sQxXjCJdEscQnUg9p/RU9QC3AYhaLl6t8oUC7l3TLQ0bZIyn6ofuvmzLCRMDnGhpXly1gyCLmwlvbvWRGTVHfbP5S1PXrhRDg5HZSq8eBttX0jgOvrgrSEl1k9bYU=
Received: from SN4PR0501CA0013.namprd05.prod.outlook.com
 (2603:10b6:803:40::26) by SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 21:26:30 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::76) by SN4PR0501CA0013.outlook.office365.com
 (2603:10b6:803:40::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.13 via Frontend Transport; Mon,
 3 Mar 2025 21:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 21:26:30 +0000
Received: from [10.236.179.218] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 15:26:28 -0600
Message-ID: <9de17a5d-3f2d-4417-b45b-78f9d55ae8d1@amd.com>
Date: Mon, 3 Mar 2025 15:26:24 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC type cxl initialization 1/2] cxl: add type2 device basic
 support
To: Dan Williams <dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, <linux-cxl@vger.kernel.org>
References: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
 <20250220200041.3891165-2-alejandro.lucero-palau@amd.com>
 <602d20fb-ab1b-41cd-9f51-98ca690b18c8@amd.com>
 <67c61643c3cfa_1a77294b9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <67c61643c3cfa_1a77294b9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3ba833-72fd-4345-2d14-08dd5a9a104d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWNJOTdDT0Z0SXBEU3ZXYzg1Y1lrRXNIcm1yVmU3akJmZUdwby9TNi9pbzRq?=
 =?utf-8?B?enpwOVlIeXZrQi9JYkpUYXdQVURSZXpuNW4zU2JGSEJLenNFYWo0ZldyV3Rw?=
 =?utf-8?B?T2lScWRlYWRhQlhad045VUY3MVk5NlFHTUdnRzRNMHJSV2lPT1lqaVhDdTRJ?=
 =?utf-8?B?OXRxUlY2dHpsak43NzR1cmc5azVEZm02a1QreFpCRFJMTVJRRTBHU3pvei82?=
 =?utf-8?B?R0Z4OHRXMUdvYjFnb1lON3RTVnZPQ1paVHdqYU9la3E4V2ttZXVBdTlGUkVK?=
 =?utf-8?B?eVF3RjNCQjVYeWpuaTI3K215bnpTRk1Ec3Q5RGJoOHJmL1dKWi93aVdpV3pB?=
 =?utf-8?B?cUQwZmRTLzBtVUtWV3dQZzRURllYeXRqYkhuU0RaMW45ZldHdXg3R2FEWkVU?=
 =?utf-8?B?ZjN5Z29LdjB2cFEySVhrL0hlWEFoSHRGb1REc2NVQVl2L1JKTHhNb3ZtRDZ5?=
 =?utf-8?B?NUoxQkNkLzFwSGZxNmV4VWtTTVZUbmJ5LzlZYXBGRko2STRJQzdKSkVxaGcy?=
 =?utf-8?B?TUtzTDVCQWpvRVZVRk5oYUIvenNmWSt0NTRIRERhQ0dqQXN3RHFEdWNiSjFw?=
 =?utf-8?B?blJhTnp3RDdwWk5qZTlBbHhGMHAwcTJOL2NidVlPblhYYUZOcFZYMCs0dHNB?=
 =?utf-8?B?c1lhM2dhTFJra1RzQlRiNVNZTmdyWml2MmZsWGtzK2JjMk9sbUFtL0pQM3Jv?=
 =?utf-8?B?UXRweks3WnZCVEc0TS9xNm1wY2pIVnU1Sk90MGQxTFY4T0huWU16Q2R1L2tB?=
 =?utf-8?B?eTZXTkFqcWY5MTdERThuZ3RjbDZhNXN6ODB3aHVNS1FOUFJkeWxtYUppT0hZ?=
 =?utf-8?B?a09Fb3pXQVk4OW9lY1VPZ3p6eWEzY0FIN0tNNjJYYW53OVBicnJ6dG1rSitp?=
 =?utf-8?B?bkREMHhOYkJWK3JoaEVQOGpFSEVxRzJrUVNjVmdpYUtWZjFMaWk1amNvSVpp?=
 =?utf-8?B?S2xUNnBhMHFiOE1jbE5iNTM2OFVtWDdFUzRFYkpuTVNNSkNNTE1uSTEyaVhj?=
 =?utf-8?B?ekVhVmtiaDJTS01BTU5QTFNJU3JmNXJLcThXVEE1cmZGd1RMdzRGRFBvR0dS?=
 =?utf-8?B?Q2NnMGtIRld0Y243MkpoVTNkWkZ0eTZZeWNNRnB3SFhkU3RrOHBNNnhkcnZW?=
 =?utf-8?B?ZFN1R2llczE3ZW54dUIxbzVDN0tWNm1vbUxEQ0ZFZmEveXp0UjZwSEFJM001?=
 =?utf-8?B?Z0xSZ0RhVDdPRHE5Y2F1d0VSbUxKVk5raWZ1dGdzb0UyOTROYm9JeXMvbmZw?=
 =?utf-8?B?dWEvNEQwcVdIL1pCdVRvdDBqVE5PMi94TEJWa2p0eWVvYXFoWVJMcXlNdVhT?=
 =?utf-8?B?dDVKUGljWHVLZXJ0OFJpVWJwMnZiT2VTdys4VFVNZFJ4NFQ4RkRBTCtjYUdi?=
 =?utf-8?B?b2N6TXgvcjVDVVZyQ3dtWmNXbWRIazgyYThBb0dsNlZYY2VZMlJtKytHU3gx?=
 =?utf-8?B?UlNHRzh6SHk4UGxHVzNVUlJ6SUMzTURCM2thK3Aza0ozc2pwY3h0NWpJZkJY?=
 =?utf-8?B?cFVZbmRRNlc2UCtyRm9IeUFETThSeFVQSEs0b3BVVW1ReFFURlJBRWdTQ3Fi?=
 =?utf-8?B?bFUrZUk2T3pWaWtJamNpcVhLd1cyUjBtblZXQ0VGMSt4QzZPeitTMFNTMEht?=
 =?utf-8?B?eHpOdWg0WFF6OUowWldjY3B6cWdPdWdlbXluY2tHbmczNW8rM1EySmZGb0NR?=
 =?utf-8?B?bU9GdTZMME5ZSGxjRlBscyt4aFlyNDJQSHJlMnZkaU5mYmgxNWY1NGZ0NTJk?=
 =?utf-8?B?Y1hUNk92RDlmODU2M2o2dHR4Yk14RCt2d2xnaU1IY0hsTXNmU08yZm9TODZ2?=
 =?utf-8?B?UTZkSFQxeEE4WEo4SjBGOUJSWndNcEYyRGNpMzUxZ0lvcEtXdUFTUXRMV1g0?=
 =?utf-8?B?QlAybkg4cFBudjB6OWNxcHd4djA0eC9qcFd0Nk1HTkVnZmp1MWFlRE9EcEVU?=
 =?utf-8?B?MUthejlsOFJIZVB4SjJlOENpN05qY0J5VHcyeVgxK2Z2RmVvbXc0K0NNbXBE?=
 =?utf-8?Q?tJuW2prBcCYALmwXeWJP3vviRxrw44=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:26:30.0653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3ba833-72fd-4345-2d14-08dd5a9a104d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739



On 3/3/25 2:51 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> On 2/20/25 2:00 PM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>>> (type 2) with a new function for initializing cxl_dev_state and a macro
>>> for helping accel drivers to embed cxl_dev_state inside a private
>>> struct.
>>>
>>> Move structs to include/cxl as the size of the accel driver private
>>> struct embedding cxl_dev_state needs to know the size of this struct.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> [..]
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 2c49e33851b2..14d7f93e4584 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1484,24 +1484,31 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>
>> +static void cxl_memdev_state_destroy(void *cxlmds)
>> +{
>> +       kfree(cxlmds);
>> +}
>> +
>>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>>                                                  u16 dvsec)
>>  {
>>         struct cxl_memdev_state *mds;
>>         int rc;
>>
>> -       mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> +       mds = cxl_dev_state_create(dev, serial, dvsec,
>> +                                  CXL_DEVTYPE_CLASSMEM,
>> +                                  struct cxl_memdev_state,
>> +                                  cxlds);
>>         if (!mds) {
>>                 dev_err(dev, "No memory available\n");
>>                 return ERR_PTR(-ENOMEM);
>>         }
>>
>> +       rc = devm_add_action_or_reset(dev, cxl_memdev_state_destroy, mds);
>> +       if (rc)
>> +               return ERR_PTR(rc);
>> +
>>         mutex_init(&mds->event.log_lock);
>> -       mds->cxlds.dev = dev;
>> -       mds->cxlds.reg_map.host = dev;
>> -       mds->cxlds.cxl_mbox.host = dev;
>> -       mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>> -       mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>>
>>
>> Looking at the above, it occurs to me that it may be good to either:
>>
>> a) Have a devm version of cxl_dev_state_create() or,
>> b) Have an init macro (in addition) that takes a pointer so that you can use an
>> allocator of your choice
> 
> The caller can always wrap the result with devm_add_action_or_reset().
> No need to force comsumer drivers into an allocation regime.
Sounds good to me, figured I would suggest it more as a convenience option
than anything.

Thanks,
Ben
