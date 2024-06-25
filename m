Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7116C685;
	Tue, 25 Jun 2024 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325794; cv=fail; b=Zg7Hg5LpLg56A/mjGf8Cec+9bs9OElhB4MIPijgd7MuUbVW0pJNqeu6fjODTErlPeev8tuBC11hw6CsWlkZm02rSmdQplIFECU5TEo0HVTEz+GAeBumb/nqCmg6N4A0Aaf1OPjxucU37kh6zlAyxep+ehnJmd5h8fOKMUBOQHZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325794; c=relaxed/simple;
	bh=LWXA1APFcyPBArOra51jATN4mjZNpuDrnHi2lMFkw7U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rs6wXwydxZM8hRKQ5ZS7YrLYa5l11nJvRTLb+Rvavv8Een7FXaBA0bAkKld0smU8FvGv5VvkZgUyAhzA8l+mhUlRx+AdrssYZQ+zcFJrctpCu2VpFdCIQiOe5x2CDZ4RY3V/ORwWW/BtJh6D24/XCaufBMRsZ7oTPK6Wa0ZxN0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oD/JAdJt; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oD/JAdJt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGCYmHdqkNytggSAqD2HQzCKnSaQ4OsylMGY425jINDrrFkJxDw0Wv+osoNNlhH384oHGiU81AshMHqYo6gzRr2e3m9X5ZKgqFF32ghqMZK9sYi5GbtIUJJC19KA2SMXm6DbL/Pv769LGvs0fHiQy1+reR7WxMmhyZ46dHJBnTKUU35w8Qr1lOmkvACvlkZsssnuAlTHaX2FxsLaB8YaPbEwjmlMBBAqMIfpDzd3HTg7OLLj+s4mpvmaDrqoPzpXCLhgnScWv5wmCb6MTqgJGb8uzrYuP8eocsa2YTGYmA3Pfus6LsiFtZXN6bFslMkaM13NoOAsVJItIdhaRszmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5iYGxqP1d/S+XDkkT9GdX+KvZFEX8+ZZ8Xb2jSND6s=;
 b=B/zoQGsG0MeEd8YXfsvxjhoxN3YI6zr9TCPolW9jppY4J2BgLrHmcIjMH7jW4gH13MubSwVVn6/LjjytYXiE0ox3oDsiNurGSlleSkyWaDEMH7x6zo+fn0w6JuJCkTu1pkg7sfW0/fMnrfMgn1Di9wj9pu7QvhOrO5J8l2pVDU916p04o3NT7pe2rzfavoBKt+DOCcv9vXVh8Ympm2EYPuGSpKKzTKkAdWnhSuIUl/xbDTkVrR3JGfMOfj7LZ0PkmsmFlpxvZS+mx/88wDUUI+GjAzhefVFMnYBHgZJryc3fkljk47VAMM5E+/EjCKg1oraJSeC2KXosDGXIVN7i5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5iYGxqP1d/S+XDkkT9GdX+KvZFEX8+ZZ8Xb2jSND6s=;
 b=oD/JAdJtVBDHcpwD6YWTA0YpQ0O4hfRrrOmhSyn1RsP8KimtqI5Gji0x2QJXd3hVd8YxBFK9t4vDeHvoMki0NgJjSzn8yA/1zJcdJaHD/mNp1BIg2JPFjhAeFEVjWx4L5D0cE8lxWk6ApJ10qxzVuIR9cOdaGUbQnyNpyG4e7uA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Tue, 25 Jun 2024 14:29:48 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 14:29:48 +0000
Message-ID: <6ef2bf5d-b78b-490f-b64f-30dec3197df5@amd.com>
Date: Tue, 25 Jun 2024 09:29:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] Add RAS support for CXL root ports, CXL
 downstream switch ports, and CXL upstream switch ports
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
 dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 ming4.li@intel.com, vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <6675cece52eaf_57ac294ea@dwillia2-xfh.jf.intel.com.notmuch>
 <f4dffe22-b383-4118-bd3b-a3afb2df835e@amd.com>
 <6679dc345fd4c_5639294a5@dwillia2-xfh.jf.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6679dc345fd4c_5639294a5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:805:f2::49) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 268ab72d-0738-4501-1e73-08dc95234443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|1800799021|376011|7416011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2lSSzNhaHVwS1dtVVBvanZNdVFDcXhydUl0dG5TbWc3VkphcWFwLzMrODU3?=
 =?utf-8?B?YmdqVXZiK1R6cG5kaFkrNDNWaXhHNWY0T2pTRk9RZDJuNElwZXhvY3ZXelE0?=
 =?utf-8?B?eHJFNXE0US8zZGthTzI3Vi9XQzdnTmp0bm4zdkkvdzNsNC9VcC81U0tWSU5S?=
 =?utf-8?B?TWJKMDVjbEkybm82ZGgvakRLcERuNDRJTEtlSFFwRzFtblBaSmhjaHpEdmk5?=
 =?utf-8?B?bmoyTXFBLzJHQTM1OW5KTWU0dHp0NlV1L0RPL1BKYUlSYVIrbnRMTjVCV2Vh?=
 =?utf-8?B?S2s5T0VteklDc2gvYzMzby9WbjJwM3Qvcm8vQlVvOWxsWWRDVXZyMVZTUTEv?=
 =?utf-8?B?aDhtaGoyTVJ5TEJ2ZWkvQWdJaFZBUFhPT3hWVWxYS0xxNEg0R3BiaHBZRmVD?=
 =?utf-8?B?QzNFRHltQndGb0dHMEVhSHYvMm9JOG5DVFNQUjJreEZmY3B0eTBtS3VpUmVQ?=
 =?utf-8?B?bGo1dFlhVk9rVjdWMFhvNmlxeGxsTHVTeGp0RnV0d1ZGdWhkR0hZaEIzOFpQ?=
 =?utf-8?B?cjFKUzFPRFpRRjVVK2V5QlBsSUcxYmpGZFMybEZSYXNZckczU21VcERRR2FV?=
 =?utf-8?B?Mm8yMEp2MUM5VEttN1AzRFlMaEk2aHpZa1AwQXRhNGd6ZXplRWtIcFBWL284?=
 =?utf-8?B?K1J0T2ROaVVraWlZbmNpTnVUbVJvcDNIYlp0UVUwN1ljWm1KMGNIbWJucnBT?=
 =?utf-8?B?RWV5T1FBYXJFK29HUXdjQkJhSVZBbUhsYmJRb3JkL1RHN0NOSTZCN05Sb3Yz?=
 =?utf-8?B?bVhudGNxU1NxS21mM0pJTFc5STBYMy9GbW5WQU9mWGdlUDRHNVgvdnN1Ly81?=
 =?utf-8?B?L1dnSCsxQVJIQnFYTFl2RURFMHJYWHFzZ2tRZU1yYXlPejBYeWRKS1FWWHM5?=
 =?utf-8?B?VHdBVDdiaDdHMHQxakgyVWRyVGx4aStXajdnZVA0V0FjblMwQno5RnhYcEdF?=
 =?utf-8?B?QlBkeFpLY2VYWDQycFNPZ2hSSDJJeVIwVzdVTXBRb2c0MWFmZDNsa0xGTFpX?=
 =?utf-8?B?eUh3ajZFQVg5c1VlV2NkZW1KTS9pa2JqZ2k4L2k3OHRhRjEzcXhlR3Q3Z3dq?=
 =?utf-8?B?Y0JqUkZvckw4WjVUdm5RL0JBd2lhcjZpd3NBTnZlU1BmMWxVK2lHcjJWOGRy?=
 =?utf-8?B?VklpZllmYnoxbkhQamR5My9NS0dLM0JYMjJsbWo0MGVwUmhLaHNidUt6clZk?=
 =?utf-8?B?bkVFczJCd2daNWZZWmZaL3pBb3diNVF2cDlLSVltU09pVHFkdlRhdWRFMGNk?=
 =?utf-8?B?VzJUSFBJOW5ybXI2YnU4dUpMQ1dnQ3BWVC9uZzk4U0JiLzFHYnFRd1NjUjZC?=
 =?utf-8?B?Tjdpdmc5NTl4blBLaW1DUEZOTmZ1ZkgrNG9FVEs2Q1RjRENJZzNueDM3dSs1?=
 =?utf-8?B?OXdQZnNONmUvTk1vK1BVVnVYZ3NRYmhBS2k2Vk4wVVJGcFhqUDN2cjhMc2xt?=
 =?utf-8?B?VTQ4dFNYZUlLclVBTkZzRHlTeGpxSGh6YWpPWll3R2x4N3RrR3BxbExoSzkx?=
 =?utf-8?B?Vkk1MG5yQUJBV2wxL0dLaHdwVlZFbkRGaUQ0SGJzb0hlVG1IWTNWUmNRWWNu?=
 =?utf-8?B?bkZKM2hjcGZjZ0QrWURoUUFYMmFWVjk5UTlmampqYVVEWUIyOHhkVFNSVExm?=
 =?utf-8?B?M2FYOTJXZWJuN0lOUytITEcrbmVkUFUxdndoRmE1Sy9LemFPU3g5Z3Jhckw0?=
 =?utf-8?B?V0RxSlFndWF3QzNCbmk3SzlpZEVCdjV1d01oQ2xJcG9YazVNY25kcHN0TkN3?=
 =?utf-8?B?QjB4OC85SHMwWmFWSm16R0ptU2hwN2l1dHkvaG1tZzI2ZjBJLzZPdE40ZzN3?=
 =?utf-8?Q?y+0za5P+qtWvImJJNljXcfj4rtLRbNk20jXT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(7416011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEhNanpwTVhWVzdReU9Ic0pmekszNlVhZW1IckVkWWk1cUsrcWEyQW1BdmFV?=
 =?utf-8?B?UzVpYjcwYXVWNUNFdmU0WWFqRTdJT1RzcXluWERjZHZWc2xxNFlaVGFtMUtO?=
 =?utf-8?B?d3hsdk4xUXZkcUtCUHZSRHM4aEhsNDMvb0pEVHpJVHpRUlc1dHdydTVYYnlG?=
 =?utf-8?B?QkU0RVpsNk8wemh0aVY4UDBpMlNSNThscTFiVkEwYk1IQnl1UFE0TFAyVDA0?=
 =?utf-8?B?OGM1ZnVSd0kzemJVTWR0SXpGRkM0Z0JIZ0IwakRkdnZlNFEvOFZTUk9HaWx4?=
 =?utf-8?B?TDVHMnRQYzBMT2RLNkRJc2F3UkU1SHI4dDJlbXZBbDBRTkNFSEdDb0Fqb1dE?=
 =?utf-8?B?cUo1TGU2d2FZc1RXNDg3Y2dIdlV5NkN3Skdra1pGL2o4SVNlQk1oSFFlRlpt?=
 =?utf-8?B?TUtmOERUYjNzampPbFkrdllINEpnMTBlUHMxWVRJc1JOTEJ4ekhhTmxTRWs3?=
 =?utf-8?B?dzhPQy9BaDFGc2VBTzZ2bGtQZmo5R2RqMWhXZ0JUOWsrSnlCWFhsbVp6TTRy?=
 =?utf-8?B?dmFpRmpPUUxqemZxb3ZJQ1htc1hTRkkwU0tQdjBQbTFBbU55bklwdU0wMmdY?=
 =?utf-8?B?dDc5emlPRjVCUHlEQzRsUkV1elBna2hHMjNJTUlneFVlVnVyZkg3YjBHS0kr?=
 =?utf-8?B?OGlobURiNVpiS21Xc2RhWjVtWStwUlBkb2k5T2FHK0Q0YUgxTXJnU3dZRHk3?=
 =?utf-8?B?Mko0bnFXWHMrOUZyWHR6Q3RVS1M3SzhEN0RrcDNydlM3QVR5YXQ0Sm43UjJu?=
 =?utf-8?B?UlJTb3VtRWxIM01kZ1FRSXVjcXB6UEV5V1NWeTFFaTRtdTYwUkpLUlBIdW05?=
 =?utf-8?B?c3dZQkJ0N1RaRkdCV2dXU0VwWGJQdUswdDdJWUVRdzRYbTU2aHpINnhiS1I4?=
 =?utf-8?B?MTYrSnVXZkRvQmg1eStXMFJ5eE04TWM0NkhjYndlb2tVVVBQSWtnNmxISTJU?=
 =?utf-8?B?clF0YlR4dE01aklLU3ovdVk1SnI2MXpKbUlyblZPbUIwSnM3MDJCN1dicWxR?=
 =?utf-8?B?M2NWNUx4WXZHZms5ZFlabzRLWVBwVlBndjZOcFdkc2xXaDQvR29Cak4xd1M4?=
 =?utf-8?B?RHVvblhvR05icm01cERyQkkybmxOb21ENUJaMlZXSUVEbEpkdUtKVjdMeVQ4?=
 =?utf-8?B?QjhLM1lscldUcTZ3OHVYa2NUTXhyL3FFVWRDYU51S2NQdUpCekVrRTBZUXIv?=
 =?utf-8?B?Mm5ERW5IMWZRRFNOOStRUFZuM2tlSWtpWGIrSjVxL2NienZCbUMwT2VFWG12?=
 =?utf-8?B?NEFwMjE0M0MrWG5MbWhPYnhZS0RMK3p4OGF5VGxkZUZzWHp3TVovQll2WWlI?=
 =?utf-8?B?SDBOS3pZTUxwWHlsdmRqeVVydmh2U0hDK0R5SjBGR3VWRnBkNHdMZVpkdUF5?=
 =?utf-8?B?MEdvN1gyTDNkRWdZN1p5TG5IQ2RXUmdUR3c5TEdQanhDSnZ3M000bkM0Snp2?=
 =?utf-8?B?Qmp5cUVoUm02bWhNMDY3TkN3RmhSdE5TM29UZnJUS0VuNEJDSXVDcjlhUDV3?=
 =?utf-8?B?NGpUdW5HOUs5VzhiNVg0T0FDL2lqRHRNN0wycUVtaVA1WXhlL2wraG5JSjlR?=
 =?utf-8?B?WlRoKzZlUDRHTktLNzVnUW1mM2txSmk2OEV6UFhCem5RNnpsMFpKbGtSQTMx?=
 =?utf-8?B?ZHJIK1FXb0RYKzNHZ3VYcXZsVjRNalE4SDlCN09OWkRIVXRiVnp6bG9WWTY2?=
 =?utf-8?B?dDJxQ2Nnck5OTjRLQ2gwb2UyTFRiUyttQzJhWXE0QTAzOGY5ZFVaYkwxcEN0?=
 =?utf-8?B?SktweVIxZzlVR3dwWk03ZUtaVmtQMDVrWkhNN2VXMGlXRVRZYmtxUFQ2RnF0?=
 =?utf-8?B?dnZoMUR0OTdlY2VrSVIwbjZsaVY3cjExbUc1bVdqWU5SU3pLZlgxblAvVkxo?=
 =?utf-8?B?YjBHTGx2dWQzR2lsTWUxVVdJUFhYYUZPNGZySjAwTnFvcjUraFBBVkUzV3Ro?=
 =?utf-8?B?UmVSb3FuM0lsQVpWN2ZDV1VkWERicWJ6dHJFN2NNOTkzbzJJQ2tmVmNqelVn?=
 =?utf-8?B?Y3h2VU0rMTdVb0ttc0owQk9ZRWlOelVJdzZWdTNZV05VWi94ZVVLc3ZXR2hM?=
 =?utf-8?B?REo0Z3FJbHV5eWRXakhyM1JYNk9hWHBmMW0wVy9BUkNoUGhaTXZLa3FtWVlX?=
 =?utf-8?Q?XErmobqGDy48ZrIVuDGNUGlmD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268ab72d-0738-4501-1e73-08dc95234443
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 14:29:48.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtaufGVTEaJt36/HN862fJLLKByqXHPF671JO0KrGu7n6gtqiOtVYQ6Y8LGu5j3pnvzFpyTyuQb8489EyIyTsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145



On 6/24/24 15:51, Dan Williams wrote:
> Terry Bowman wrote:
>> Hi Dan,
>>
>> I added responses below.
>>
>> On 6/21/24 14:04, Dan Williams wrote:
>>> Terry Bowman wrote:
>>>> This patchset provides RAS logging for CXL root ports, CXL downstream
>>>> switch ports, and CXL upstream switch ports. This includes changes to
>>>> use a portdrv notifier chain to communicate CXL AER/RAS errors to a
>>>> cxl_pci callback.
>>>>
>>>> The first 3 patches prepare for and add an atomic notifier chain to the
>>>> portdrv driver. The portdrv's notifier chain reports the port device's
>>>> AER internal errors to the registered callback(s). The preparation changes
>>>> include a portdrv update to call the uncorrectable handler for PCIe root
>>>> ports and PCIe downstream switch ports. Also, the AER correctable error
>>>> (CE) status is made available to the AER CE handler.
>>>>
>>>> The next 4 patches are in preparation for adding an atomic notification
>>>> callback in the cxl_pci driver. This is for receiving AER internal error
>>>> events from the portdrv notifier chain. Preparation includes adding RAS
>>>> register block mapping, adding trace functions for logging, and
>>>> refactoring cxl_pci RAS functions for reuse.
>>>>
>>>> The final 2 patches enable the AER internal error interrupts.
>>> [..] 
>>>>
>>>> Solutions Considered (1-4):
>>>>   Below are solutions that were considered. Solution #4 is
>>>>   implemented in this patchset. 
>>> [..]
>>>>  2.) Update the AER driver to call cxl_pci driver's error handler before
>>>>  calling pci_aer_handle_error()
>>>>
>>>>  This is similar to the existing RCH port error approach in aer.c.
>>>>  In this solution the AER driver searches for a downstream CXL endpoint
>>>>  to 'handle' detected CXL port protocol errors.
>>>>
>>>>  This is a good solution to consider if the one presented in this patchset
>>>>  is not acceptable. I was initially reluctant to this approach because it
>>>>  adds more CXL coupling to the AER driver. But, I think this solution
>>>>  would technically work. I believe Ming was working towards this
>>>>  solution.
>>>
>>> I feel like the coupling is warranted because these things *are* PCIe
>>> and CXL ports, but it means solving the interrupt distribution problem.
>>>
>>
>> I understand the service driver interrupt issue but it is not clear how it 
>> applies to the CXL port error handling. Can you help me understand how the 
>> interrupt issue affects CXL port AER UIE/CIE handling in the AER driver.
> 
> Just the case of the AER MSI/-X vector being multiplexed with other CXL
> functionality on the same device. If the CXL interrupt vector is to be
> enabled later then it means MSI/-X vector enabling needs to be dynamic.
> 
> ...but yeah, not a problem now as we are only talking about PCIe AER
> events and not multiplexing yet. I.e. that problem can be solved later.
> 
>>
>>
>>>>   3.) Refactor portdrv
>>>>   The portdrv refactoring solution is to change the portdrv service drivers
>>>>   into PCIe auxiliary drivers. With this change the facility drivers can be
>>>>   associated with a PCIe driver instead fixed bound to the portdrv driver.
>>>>
>>>>   In this case the CXL port functionality would be added either as a CXL
>>>>   auxiliary driver or as a CXL specific port driver
>>>>   (PCI_CLASS_BRIDGE_PCI_NORMAL).
>>>>
>>>>   This solution has challenges in the interrupt allocation by separate
>>>>   auxiliary drivers and in binding of a specific driver. Binding is
>>>>   currently based on PCIe class and would require extending the binding
>>>>   logic to support multiple drivers for the same class.
>>>>
>>>>   Jonathan Cameron is working towards this solution by initially solving
>>>>   for the PMU service driver.[1] It is using the auxiliary bus to associate
>>>>   what were service drivers with the portdrv driver. Using a CXL auxiliary
>>>>   for handling CXL port RAS errors would result in RAS logic called from
>>>>   the cxl_pci and CXL auxiliary drivers. This may need a library driver.
>>>
>>> I don't think auxiliary bus is a fundamental step forward from pcie
>>> portdrv, it's just a s/pcie_port_bus_type/auxiliary_bus_type/ rename,
>>> but with all the same problems around how to distribute interrupt
>>> services to different interested parties.
>>>
>>> So I think notifiers are interesting from the perspective of a software
>>> hack to enable interrupt distribution. However, given that dynamic MSI-X
>>> support is within reach I am interested in exploring that path and
>>> mandating that archs that want to handle CXL protocol errors natively
>>> need to enable dynamic MSI-X. Otherwise, those platforms should disclaim
>>> native protocol error handling support via CXL _OSC.
>>>
>>> In other words, I expect native dynamic MSI-X support is more
>>> maintainable in the sense of keeping all the code in one notification
>>> domain.
>>>
>>>>   4.) Using a portdrv notifier chain/callback for CIE/UIE
>>>>   (Implemented in this patchset)
>>>>
>>>>   This solution uses a portdrv atomic chain notifier and a cxl_pci
>>>>   callback to handle and log CXL port RAS errors.
>>>
>>> Oh, I will need to look that the cxl_pci tie in for this, I was
>>> expecting cxl_pci only gets involved in the RCH case because the port
>>> and the endpoint are one in the same object. in the VH case I would only
>>> expect cxl_pci to get involved for its own observed protocol errors, not
>>> those reported upstream from that endpoint.
>>>
>>
>> The CXL port error handling needs a place to live with few options at the moment.
>> Where do you want the CXL port error handlers to reside? 
> 
> I need to go understand exactly why cxl_pci is involved in this current
> proposal, but I was thinking it is probably more natural for cxl_port to
> have error handlers.

Ok. I agree, cxl_port is a better location for the handlers.

Regards,
Terry
