Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DAD148316
	for <linux-cxl@vger.kernel.org>; Mon,  3 Mar 2025 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037200; cv=fail; b=Uu7P6cNMJbR+s4F3yrVkPbq1HTC6xImbrkutr2CQf4tU5xz49K1QAx5EgbFUP4CWbwK1Rbsm96tzTVPUxWq2Rd5HmgC5LzyHqbM10dHuMbDPY7NhSawigeAEvfBfjOeLoY/23WCHguKACyXQ6cRa2N+j7meLXRg+JPtCUwnA7Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037200; c=relaxed/simple;
	bh=oRQ4vMImDZ+wELVqYW4JllB9AIgCrHuwtmwXT3BCQ+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lOX275KZ0X5dCvBaKnYCZ5UgpPNi8UtNElJ2N5DLXzHVhnklOAQrDgwuiSiogbXel2aBu2eA5Nx9dcbokiC5EtQRnnVpRnfEfUTaU6Soa+SNv213N38uw+tkkjAcOWY3xeOF5k4q9AzxEzt4+PtTj3j12ieuaYGC4ucMSkPceKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yREKmcqC; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yREKmcqC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjthNF3j7VEBzI0nD2SJMaY+KHMzmIo6IdXSwoz4kXKJVS4036eMF5V6GHE6LNdbEhBsok1ZvHf3DlezSj9H01iFAxp/+x7Ne6iT1psapJGQibnVh8b4E9/hb736WI0n/oFfBnPgqu+9/kHUuSlzhLSgQIr6jMinY8lb1ymhdoHJz+WQjnkfdzl4Qbrg/jEnv6d2j6riOrX27dytVmR0jgLYeeJ+12cGpB4/QGVobxXKjfIcWt/ggzROoAiY8lu4uh8X4DczqWo0m2Fvj/sz35ItQPV9TSeelfG0DoIvJ4LkSkjo/U50krk8/jqmrw3ZZw1WTbTdR21Wnrd905JmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kah0odLgECQkFiPFrRvdTMGp5qUmrXdGcV7xHs6cMWo=;
 b=qBEXcXYDjp1AxG1KzsYkZiOqwSBC1VzHCriC2EmkaYJAu9758qqTz7xGnbIRIdMlHMXB8kE7X0UfAnLbVXjzjOlBPFDNC4OoebJ9eCQNP2enThLnrznyoYXeV8fDjpgtvuvRSoGkfwla3cpw4bYzRRouQiZsKXmSaGFU7IxNmpCvTev9eNdE9E4OL6fSyn/FvP11LahbYALJWsEVHU/Ul3AuMMXaJx1D2u8exeq2rV27K1A46aKn6FLzOTRgluS+f3bZigWvTxjgSucMc/8piIYtFWQU75zj+7xax9SD2nvBDGQeJWzjxM2F3y8DWFSlJUoNA/uBAMZIf+KuSW2n+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kah0odLgECQkFiPFrRvdTMGp5qUmrXdGcV7xHs6cMWo=;
 b=yREKmcqCdSHRkS8njm1wAErvMc6e6J9/Jfy9V9F/tmqylMHwnupPluWHvkJlD0L9dgJH4cdS4ytocsVohKVu3Xv83ue4N1ezVTDW7L6mHtRz1hgFlfUqQ6Qw2Yp25ov7T9GuFt/bjUCkFIdW0Pz1siQpBtucC13MH3timZzmS/U=
Received: from SN4PR0501CA0030.namprd05.prod.outlook.com
 (2603:10b6:803:40::43) by SA1PR12MB7442.namprd12.prod.outlook.com
 (2603:10b6:806:2b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 21:26:29 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::7) by SN4PR0501CA0030.outlook.office365.com
 (2603:10b6:803:40::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.13 via Frontend Transport; Mon,
 3 Mar 2025 21:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 21:26:29 +0000
Received: from [10.236.179.218] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 15:26:27 -0600
Message-ID: <e1af2fcf-339e-4cda-8c0b-88f540499518@amd.com>
Date: Mon, 3 Mar 2025 15:26:20 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] type2 cxl initialization
To: Dan Williams <dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, <linux-cxl@vger.kernel.org>
References: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
 <289fc275-43b6-424c-8c0c-28c5d527ac35@amd.com>
 <67c615da5dd98_1a772947d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <67c615da5dd98_1a772947d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 15480e7a-53c4-43be-6dc4-08dd5a9a0fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0loM3psMHpBTU5sUk0xWm5odEg2OEZYMzNpcmhCTkVGMjJJVSswS3pQbFls?=
 =?utf-8?B?N1ozM3h5MDBza1M2VzJQeHZRRFBJblRxbU1DRTBIazJWQ2FZSUVOK2ZDb05J?=
 =?utf-8?B?b0s5Wit0OUIvUzhQRFhmMXZuV1FCUjVSRXkwb2lYZFVWRDFVU01nZldGME5z?=
 =?utf-8?B?bklYQS8vaGxhNERwb2gxbk14aWw4dkJabk9FL0FZeXcvUjZJbmQ0NjJMaWt1?=
 =?utf-8?B?NkNpbk1EWW12Z2E0cFZqb2FPaHo4cXlveUNyUldkTHV1YlFIUjRPNWFsN1ow?=
 =?utf-8?B?Q2UzY2NsYnRlTHJLMEE2SmdiZnhwdW8yMjlXNHhqRUF4SjVQMzlvUkRtZEho?=
 =?utf-8?B?dWxQOWlFU1hDREo5MkVoeWtHaCtEeTBuY1RmT0F2L1R2djVkQ1ZOdWdoNXZH?=
 =?utf-8?B?dTJrblB6WEJmWTM1K08wWjBSejdUeWdWS0FhNEFpRi9EaExnTTExL3JyZlVG?=
 =?utf-8?B?VjhiQUpSalFBLzVqaVlBTVZrdlpDYnVrbDQ0ZlIzSDFIL0d0SWxGNlZ0d1Fv?=
 =?utf-8?B?MjMxMXpKcml3SHZOWTBlaTRCZXVHSzEyWkRiT0FpeUpsZFpEalRBM1JBeW1L?=
 =?utf-8?B?UjdXaG52NDJRL3VPemdDaERid1BObmpGSTIwc2xvczNvU3c0dUpubXZNYzI4?=
 =?utf-8?B?Q2NBMnJyY1Zpd0x2TnFQNTNqZFhvUm1iSkI0alp3amlpQ0haWGlCdlpsUHNk?=
 =?utf-8?B?TEFFc0FDL3pGVjZWQmlleFc4cTZxWmlLRms0eEd1S28zNUEvMnMva0l3bXlI?=
 =?utf-8?B?elgrSDJzd1l5cWpxdVg5ajVpUjVHSlQ5YVFNblZRckQwZVA1Q0xHWU1McWR1?=
 =?utf-8?B?WjN3REFLaUVHNHJ1b0xpQ3hHRVlVTllaK1lReS9zSk1va3hhWnpKQjNFSTlM?=
 =?utf-8?B?YVpPWWs4YWJvUVJQaUlwMk93ODhubFMzNEFZRUFqZzRyVUNVVCtqOHpqSk1p?=
 =?utf-8?B?M3oyVGRLeWZuMGt3Mjk0b3dWeVZOdTlBM28zV1RoWUlLanlJUmxGcnV3cUVv?=
 =?utf-8?B?dHd6dm8xWDdVVXlFaFIxMTk1VUFTRUk5SysrOW1PM1ArejBEcWYwWVY4ZkVL?=
 =?utf-8?B?R3JicTd4eVN1U2Z1WmJXZHFvVmZuVk13WlFlbVJJNFFSUVVqaG43RWtlREVv?=
 =?utf-8?B?S3RMQjRxc2JFNkkwZ1dGYTQzRlM5M1dNNUNxOWpXMURVaE9VbUhTcHJCZUo5?=
 =?utf-8?B?ZFAxWUJPYmQwbVcvSnVoUGp2OXhJTjBpZ0U0b2ZFMmF4UW8vMCswYVJidEhX?=
 =?utf-8?B?b2N0bzJzand4Z1lCZ2UvL3NDU0NsOXlGSG9ROFU4WExyNDkzSlNPZ2tBNXh2?=
 =?utf-8?B?YzNFTytmaW94cnBUbTNlZG1HYk81VTRKVU1UOU1rNkFiTk01Y0tJUHIvZ3Bq?=
 =?utf-8?B?empncE5oQ2ZCc1BOVW5MaUxhbEJaRFAwVVFKL0xhcytlVjJ3Nk9ZTm9iV3R6?=
 =?utf-8?B?VURUL0ZYNm5xNnFTYXRxd3lqM01DeGV1UEV3UHhqeVZ4YllESThzRllhdjNI?=
 =?utf-8?B?ZFVYZE5McVJXWDQ5dlg0ZmYyUyt2RWdmcTA2QkxxaUlMeHRZVllsanZlclJL?=
 =?utf-8?B?WmM3L2RZQWIzQlUwa3R1NTJZdU9OclhON2NXSG13QTlLRGNMSnF4WlBPVXVC?=
 =?utf-8?B?TzhweitZWHNyb201d2h5anJ6aGRlbVl4bkRJb1N2K2hvRzNYU1p2QkJBUTR3?=
 =?utf-8?B?S3NsdzRwSlNzc1RRWnJHQkZWcXd5QWZmL3lQQlBhSHA0dlpZUVd1MmxlQUhu?=
 =?utf-8?B?L2w2QWZnM3crdW0vMzNickZCY0pUcHJacnJqMTNFWkMxZk9FdDdINzNxRVVG?=
 =?utf-8?B?UldLV1ErYlNIWUxMYjNQNGNrQU1iK09NSjQwdmVwUndpTU05VzhCekF4YU10?=
 =?utf-8?B?bFBVOHFtS05CVnJ0czA2LzFwMy9kei9SazhnT01ZVndYbFdYT0ZEM05PaGk5?=
 =?utf-8?B?blRPTytZbCt1T0w3QkpOc3hPNk44V3JnbTJHTkdNcWFpRWVoUjc5c0RtMVhX?=
 =?utf-8?Q?WV67CgPCX1R0sS1gOI7uH76uz4A5vc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:26:29.2216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15480e7a-53c4-43be-6dc4-08dd5a9a0fcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442



On 3/3/25 2:49 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> On 2/20/25 2:00 PM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Avoiding to send the full type2 support patchset until there is an
>>> agreement about how to do the cxl initialization from accel drivers.
>>>
>>> Using the idea from fwctl for embedding cxl_dev_state in a private
>>> accel driver struct and a macro helping for the allocation and
>>> initialization of such struct.
>>>
>>> The main problem is the amount of internal cxl structs which need to be
>>> public for accel drivers which we tried to avoid since v1 of the type2
>>> patchset history.
>>
>> I have a suggestion or two in the next patch, but in my opinion the only
>> potentially problematic exports are the cxl register structs. I'm assuming
>> allowing accelerator drivers access to those may cause stale values in the
>> CXL driver, but I haven't looked. The only suggestion I have there is to
>> use pointers to the struct instead, but I imagine achieving could be a
>> non-trivial amount of effort.
> 
> Hmm, say more about why you think those are a problem. Those are
> "write-once at init" things, why would an accelerator driver have any
> reason to play with those post init?
> 

I could see a scenario where an accelerator driver tries to do some concurrent
setup with the CXL driver and may cause an issue. For example if a type 2 driver
tried to do something with HDM during setup, but I think a driver touching
any of these registers when the CXL driver already does this stuff is pretty
unlikely.

So that leads me to think it's better to not expose this at all, but I think
that would require more work than it's worth.

>> The only other member that may be a problem is the DPA partition info,
>> but I don't know enough about that to comment.
> 
> I think it is sufficient to mark the bulk of 'struct cxl_dev_state' as
> private and then move things into the public space as needed, something
> like:
> 
> struct cxl_dev_state {
> /* public */
>         struct device *dev;
>         struct cxl_memdev *cxlmd;
> /* private */
>         struct cxl_register_map reg_map;
>         struct cxl_regs regs;
>         int cxl_dvsec;
>         bool rcd;
>         bool media_ready;
>         struct resource dpa_res;
>         struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
>         unsigned int nr_partitions;
>         u64 serial;
>         enum cxl_devtype type;
>         struct cxl_mailbox cxl_mbox;
> };
> 
> ...but otherwise let accelerator drivers see the full definition of that
> struct for constainer_of() operations.
That's fine by me.
