Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C34147C96
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653043; cv=fail; b=IxTh3v3dKk3z63onD0/mezOOJosUv+rAaCTjvqbWXKKl95Og/Eru8QO8NrcTVAkMPOiQ1c2v+FYIsXLOzHQqzYnk4vEGAEMOsdo6K0/l6Iy0Mkga5c1G2/zMUL9IyHEIqWtjJ56wCaF6wupt2sybzzDBYk9zB9MBiC2sCS4xOMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653043; c=relaxed/simple;
	bh=xoixu7/Ebf5yHHbVBH4tWVZGhu3YUaZfEEtOo3/6bf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BcOV6RrtgEYNV0SBR2PTVxfK4fg9stxh3+BDVE51aRgmk7nlso2hszZMWv8c5Z5WbCPvQeupN0mMI7YqM4bfgUkdmP7YVgUlju+4yAS+MHYiS6oMAlHZ5vkbEA/z9oD42KoBJp+0bbMsPfnguA8WR0ZPrep/xO44HwZy8GWDZvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GdEs7mt1; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GdEs7mt1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2FkHGA8wYzim+1EJqFxrbUpvT52SSpveIqK34eM33a10HPbxPgGjINbfex9Kf+ypHxp1l6KJ53zIjZCRj2PT9vYAFjW00+r7IhnPMSjXXcDevQHCJHM+qGGP77i7Nz6gKLwpAZOf4//M9Zbm6PuqeQhTblB/vZ+gv5Mk/5tC3e38+cxTBmnQHpsQkhI3b5TaQX3MDsNM6PB+cmRNukZSK/LUCvCFlA3Nszg6RD45WWWzZNEBtbA6bk/a9suYMARVLGpX3EQknmpA1HolKwywEflDXpeMge8gHqa+vZHA2RdromMfUSDgaMCTXf55JrXjG1fp4dAk0jGGymUoRZ0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2R2U1N5Uw5sCyTUOtvO4qyCRdE0NvruFHqQAodMOv4=;
 b=wNzuWDFldxnLg5OMpEPpmwpiUy5+wMHxvgP0nP2ecEU8zHCufZvVYFVn/BpGfAN6PU3SL34Jp34eoU6kpVqceBXjZ+oHMuykUHFypuP4PcC/R/6l3pBfVt/te3+eiyePLjnqTVevfr70RXbYY038yV7iA3uryxSs3DJO16RF0Ak/1KIKfDCPI/ixffaByMqu9+zidivcT8620gfVopjr+8+Q+JwJq5qgUs5lO031kdnB+64dEB6nFADR0JWHlmWfiP6ws5NA5mQCSkaqvzPMxsoD5uzJIKqIe1+4VR5NOBELsSFrkGfbGEV3CT2egb+Up7tfjGq75mI9/F74Tr73vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2R2U1N5Uw5sCyTUOtvO4qyCRdE0NvruFHqQAodMOv4=;
 b=GdEs7mt1y9eJ8QBzatgEl2abXGl0VzRJvyOp9FhYJRsqeptJ3R6LYs3UcoM+OOp/lnlrSHM50lw5eiXNCA3BmZa3EzX3mRhd42+RTziWY5jPgD0Z1mYdeoibnUb/CdRbFohZcLxx6Y8JXaNFdmMhHALUEQqWgcagURW7/jVJGIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 17:23:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 17:23:58 +0000
Message-ID: <60205c5b-3e44-36de-632b-91410b496663@amd.com>
Date: Thu, 23 Jan 2025 17:23:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/5] cxl: DPA partition metadata is a mess...
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0373.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 9609bf3a-0fe5-4cfe-df8f-08dd3bd2b8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG11bU9tMWtpb2t3OWN3dkZwL1dsaTVwMmtLeTdneVNEOW9CQUUvN3hKSEZV?=
 =?utf-8?B?QmVhVlZkUGRSdlptV2xuQVBESURSVzJyYXk5QUdWUExUTWZsK2RtU0dhL1BH?=
 =?utf-8?B?Y0V5OU1ndG1aRTJ2eGk4dG05UURqR3ptTVcrUnBkUnBIakxqcUhsL0srbmN0?=
 =?utf-8?B?NVRsbHFwaFIyMzFELzlBUlQxQXdnRkhpRzNIN2VPRkk3K3NHeHI5WW5LVjNC?=
 =?utf-8?B?NFA4TFgyaVkrTXVnb3lDcEpOTlNrMkxIRmJDdENjbUx0ZFZSWkNoQ2p5SzVS?=
 =?utf-8?B?L29rT2xrS3dJY09SbGVrR0NYU2xSekFUZTRVeXhLWm16b045QnZNS3BUUnhJ?=
 =?utf-8?B?L2svSXpDTjZ0YXQzc2ZQZzk0bmFNZ0ZuaUFDeVFLdUo2bjFxSXpFbm5QNitu?=
 =?utf-8?B?V29RTzc2VEozcGtMOUx6a3Y1cUNsazhqUWJScjBMTTBNRUlGWUNiNThTV3VW?=
 =?utf-8?B?V0VFeUMrSm1tRXJZTDlOMW5FMzVrbjdtZDBLdjNXUitBajcyOElocVhoSHNX?=
 =?utf-8?B?dFZDdU1CWnlNK1EwcmZTcUo4cjRpeWlGZ0hsWVVzSndRSmFlVFdCQ2dXbU9H?=
 =?utf-8?B?cHN6UThPaDc1Mi9UeVo0c1JONG1vSjFZc2c1ZGthaEZJNVcwNlFGSjJ5OHhr?=
 =?utf-8?B?dkdtOWU4QXlQL3QwQlhkM1B3ME1zSzEzWDNPYVFRUEw1S3Z6MWozdkNMVEFR?=
 =?utf-8?B?YjVKc0ZCdHViWUlROVRoUWhTem1EcndzMStyMlNtTlRaUy84MEZTL0FhQmtW?=
 =?utf-8?B?SGNRbzlQMCtodEptbUhCRFlrblhmRTdFNE9UU1NtRWpQUHJYTzR6ekxKK0g4?=
 =?utf-8?B?RGNuY0krN0ZWSWFEUmtTNEJJVzY2TkttOVpEbUVsOFV0ZUk5cUFWZzBQWmRH?=
 =?utf-8?B?anpUQjg3K0cyYUVBNXZwRHNoQ3h5MjV6blJ4YnFDUzg4dFRCNTNVREZzdXU3?=
 =?utf-8?B?bk5rS203QVEya1E0YTEwUTVDck9uQ0FlbURMdDcyYXZoTG5lU2dsVmdzWHpz?=
 =?utf-8?B?b3MwVDZpUVQ4c2RENUxiZmpNSlpoNS80dnoxeWk4RVJuVlRGa1lXdlNLM3Nq?=
 =?utf-8?B?OWtscVhZZkZlNFhXL0dXREFiYlc4aEYvbUlHd3RPOXZnWFJJMFVjWGVTM0lB?=
 =?utf-8?B?RFRPZUY2U20ya3FDK0VuZ2dFT25HdnpXT29YN016R2gzQjNWZWxsV0krdlph?=
 =?utf-8?B?M3M3Rjk4YnIwQU4wOFVDeE1NVG9OQ2JqcVdmSi9USkdKWDVPRE85ZlhIeGxS?=
 =?utf-8?B?NitZS1lGeWFrSTFTdWQ0MkpDOGl0SlpXZ01sNXJ4VWd6MmFPa1BRZjhqb1dS?=
 =?utf-8?B?SGdLd2Y0VmVNdXdzQy9UZUM3K1dHSmRieS9icGZQTThFRUhvM1RGMDJrTUdh?=
 =?utf-8?B?RWZLc0syUXgyZjc5NjJUcW5PY1FaK3lERmNXU2hROE5tNkFmbUtIdjBTNUNr?=
 =?utf-8?B?czFxa1YvL0Niem9ZUnNIRncvTVpjakc3T2dSZkQ1T3hYd011U3c0Q1hZTFpV?=
 =?utf-8?B?UEtMRWcveVRVT1FaRzlvUEhHNXgxdHlVc1JvaHg5eUpTVnhtNFpxVFNjejFv?=
 =?utf-8?B?WTdPc0ttclhUUUY2bDJuZWRLb3RMdkxjc0hacUxKQ3BnaWRsam42UHllazNV?=
 =?utf-8?B?TW4vY3kzdURBcWdESnR1MVlGTlp6Rkc3MDBxMmpnR0xxQ2tnUFZhZlJneTl4?=
 =?utf-8?B?VkcvUUtubEdLNW9vdHRMS3pnVXZGV0lsaDBwTXd5bTFSbWFjczVlblRUMU1G?=
 =?utf-8?B?RTBqOHpXekQ4NFdmNEFxWmhEMnFlQXZ5WGo2ZW1tQzBhMGhXeWVQRnFPYTNI?=
 =?utf-8?B?VGtLVlQ1VXhOV3U4UlZrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkdyQjdJa3NmSnlEOU5tVW5UK2F6cGwrR1ZhaXQ1YXFYWVI5aGk3UzNNVmYx?=
 =?utf-8?B?MEhOcnBEemFMVWtiR3hpMU1mOHpPeVhjd3pIN1N3TDhmQnZyUURRSGxxVFlv?=
 =?utf-8?B?QmZZSzYvbUNFdEZmQjAvdzg2V1htUkc5NVhyZm9BOGNsLzUxL0E1QXhzNHZr?=
 =?utf-8?B?cWczYjlFRjk1VXJEQ1hDbnJlZjJTU3ZZZC81dXhDUEtZcm1BS1lCWVg1anM1?=
 =?utf-8?B?VVhMS3BaN0c1TzdrOTlpZ2ZLcWdxTjdSZ2VyaWxXMzBVVVRkS09oRnhvRHdS?=
 =?utf-8?B?Y2ZvV2RhaXpsUXFKZDk1OU5aM1JnSjl1VHhDWk1nR0JmbEI1dkdpeHg4d1Yy?=
 =?utf-8?B?QUlyRHp0N01Hb05hT3Z5Z1FYM1ZPTzIwdG9Wb21ZdzFValdzSkl1WG10QUlW?=
 =?utf-8?B?TTVSM2t6SXE4VlR0ZjZaUGFYNDRkcDAzdWFWMUo3YlNlejF3UURrQ0hWS0s4?=
 =?utf-8?B?Wk05My9DQ2xQZVNIM05oTTRqUzdyVGxVVGZmOC92TkVET0YyOVRzUkExeXAz?=
 =?utf-8?B?c0h0SDlveHZnZm5BUUoxOU0zQWdSU0NRdWM5SUlkWmkrM3I5ZmFOR2tMNzA2?=
 =?utf-8?B?RWhDNGM0TGdRR01GUm9kaktYZGgrTWpEQWErc0VkejgxSlZhNStXYXNGVG9H?=
 =?utf-8?B?djZhZ2FJQzlZdVJNTXhpU2o1MGF4KzdnUmZpU3JpdlVaZ1Q1c3BRZHdwdE5p?=
 =?utf-8?B?RVllakFIRTFuclFQODIxQnp2aExERmtkOERZQVBDRk9uREhONjlUWjZaYkxM?=
 =?utf-8?B?U01KV0FQeWFGYnpBMTdUWTlVaGlxeUhkcDF3cXJJbUdtK3ltalFqVDVBVG5L?=
 =?utf-8?B?RDVmNVhoS1JGNmpTejdlRTZmdTdZcitUcEJCeXBtY3JaUzFsb3RpUjREdytJ?=
 =?utf-8?B?Vks0Wld1SzE4UkxrcTdmQVR3SnJlSGhibjFOMGZjVXZzOUZxSE9UOHhuUGRP?=
 =?utf-8?B?dmNXczJkUU1HS3JkQ2hFTDhxVC95OEtXT2RUNk03Qk5UNVhzbk00QVY0VXpP?=
 =?utf-8?B?VElYblFxNVQ2VlZCelZNUVZ0cWU2ektwSWxwVnlZWlJYdjlYRW9lM0U3eU9U?=
 =?utf-8?B?UFkzcUtNTEFhdFlGR1FlSXZjeHFqb0ZQOXlTVFlhdEJoenBnSVQ0ZGdnOWZR?=
 =?utf-8?B?R3U1dGh2ZVVvdUxETUxqNDhIQVYxV21Mc2JwUDRIYjJIV2JSZVQyZjE0M01Y?=
 =?utf-8?B?T1lBQ3diUXZWSldleFZqZ09CbWRXNzJTSnlsTldjdjB6SHlxejZHNzhBWm1D?=
 =?utf-8?B?ZVpUd3FSdkd5aW9OWXV1Q2YzSWZ4STZ5dlRZVmJnUmFvUEdaWWdtU0YvUVFO?=
 =?utf-8?B?R0FZWTVzSHg5YUpMQUJiUXEzcHJjOWJlNTJUd09LNml1Nnh3UUF3OHVyREpi?=
 =?utf-8?B?cW93aVBvSGRJSVBORXMvM2xQU0ZUdzNGU3d1SGRpZlNCMEFXY1oza0RJTjdk?=
 =?utf-8?B?aHRpT3M2M21jSlNXM0t1QkpCM3Nnc0Ezd2Q3MTZWZ1NaanhydUo2bUJHRXYx?=
 =?utf-8?B?UTZ6eFM0NmZQNzZ4OVlROWtzVjdUTjBHUGxyNTlvMHV0N2tKNkZVMFdoYmFm?=
 =?utf-8?B?d3MzdXFkL2o2R0dxclZaNkxSOWlmRW8vcmREalgvV3RNQlRZV0hTSEFRZmxs?=
 =?utf-8?B?anZ3UWFFM29oQmVpc1dRTjFCNUhGaGtFNmpPUzFyajg4TkhPaHZwbVR6b0tG?=
 =?utf-8?B?VThiTWM4SHJBcFVKQkRtN1lsYitUa2V2eC93VU9US3hrZGgyWTN4TjkvalZ5?=
 =?utf-8?B?cmcwVklBTXdjdEc3aHZUZ2NENUNxQUpLS2Q3cG4vZUtJR3FuVFg0eDdDUDVE?=
 =?utf-8?B?c01HbjdEcnJ6b0N3Z3doWVJ5d1Y2ZlVFSVdGeThGVU5SQTBtM1dYQlMydjg1?=
 =?utf-8?B?NUZVT21WV3FEdVN2UU5TYkVIaStTZ3lINVNVbk5TM3JnNGV4VVp1akRDalVa?=
 =?utf-8?B?ZDBxUzJDcUk1YjMvcTNTbUIrZ2VJeTh2ODhvbkhGdVRDTERtbmJKUVlzS3FF?=
 =?utf-8?B?WkQ5R09DMGRUZnNSeTNWVW5NNlFlYWlMbEFiNk1KRmR2Wmp4M0pkUlc3K3Jj?=
 =?utf-8?B?TzNUd242MVFZZzVPV0gya3RVcTJkclBoTXpsTTJLYlBCTWUzMmhMdE1wUkIw?=
 =?utf-8?Q?SG+HzNv2sumDbWKJOKKpAQhls?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9609bf3a-0fe5-4cfe-df8f-08dd3bd2b8d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:23:58.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeLDygVu0s2zS/1AldnsJ9feVwpahzb7ed2LbObCbWG+aVA+D6fDWVU0Nu4BGuq1PZGzhL4ts/HaM6yY8M1qtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124


On 1/22/25 08:59, Dan Williams wrote:
> Changes since v1: [0]
> - Stop requiring PMEM to be at partition-index 1, i.e. remove empty
>    partitions. (Jonathan)
> - Document the assumptions and implementation of
>    {request,release}_skip() (Jonathan, Alejandro)
> - Kill 'enum cxl_decoder_mode' to cleanup remainder of hard-coded
>    expectations of a static PMEM partition always being present
>
> [0]: http://lore.kernel.org/173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com
>
> ---
>
> As noted in patch3, the pending efforts to add CXL Accelerator (type-2)
> device [1], and Dynamic Capacity (DCD) support [2], tripped on the
> no-longer-fit-for-purpose design in the CXL subsystem for tracking
> device-physical-address (DPA) metadata.
>
> In fact there was no design at all, just a couple of open-coded 'struct
> resource' instances for 'ram' and 'pmem' and a pile of explicit code
> referencing those resources directly.
>
> See patch3 for more details on the specific problems that caused, and
> patch4 for the eyesore reduction of making the DPA allocation algorithm
> partition number agnostic.
>
> The motivation with this effort is to make it easier to land the Type-2
> and DCD series.
>
> [1]: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com
> [2]: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com
>
> ---
>
> Dan Williams (5):
>        cxl: Remove the CXL_DECODER_MIXED mistake
>        cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
>        cxl: Introduce 'struct cxl_dpa_partition' and 'struct cxl_range_info'
>        cxl: Make cxl_dpa_alloc() DPA partition number agnostic
>        cxl: Kill enum cxl_decoder_mode
>

FWIW, I'll adapt the current CXL patchset as in v9 for testing the 
changes in this patchset and report here in the next days.


Thank you


>   drivers/cxl/core/cdat.c      |   74 +++++-----
>   drivers/cxl/core/core.h      |    4 -
>   drivers/cxl/core/hdm.c       |  310 +++++++++++++++++++++++++++++++-----------
>   drivers/cxl/core/mbox.c      |   66 +++------
>   drivers/cxl/core/memdev.c    |   43 ++----
>   drivers/cxl/core/port.c      |   20 ++-
>   drivers/cxl/core/region.c    |  138 ++++++++++---------
>   drivers/cxl/cxl.h            |   40 +----
>   drivers/cxl/cxlmem.h         |   94 +++++++++++--
>   drivers/cxl/mem.c            |    2
>   drivers/cxl/pci.c            |    7 +
>   tools/testing/cxl/test/cxl.c |   22 +--
>   tools/testing/cxl/test/mem.c |    7 +
>   13 files changed, 511 insertions(+), 316 deletions(-)
>
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
