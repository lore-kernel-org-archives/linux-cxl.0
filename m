Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF13009E4
	for <linux-cxl@vger.kernel.org>; Mon,  3 Nov 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169165; cv=fail; b=CIJ/5oV/xgPQAvtUBB49V+4hBcjt+hwPLLL9ZhePh7MGPzrjV8MS8qFKn2WJAsI//aT0rhcqPFj71mzncJjZwMzNzNhewwEVVxVxVUtTdIWaM0LnE6aWSvNZ5xA3LY5R+PVzRWz6shtMvHNa/LeGy5TfS89XZX0uhLSAr+IoB58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169165; c=relaxed/simple;
	bh=uKtG9kzNxGGW3RjQ1ytmQHP9bDLcvPzAIJ1YgRaDFmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OXmqz8/XaD2ynHs82P6Ht3Hk/JGTi/1FTc4/3kW6qmJxYySzA0XOk3Pkw2MGqdEJtV570hsya8Bcy6s+U9IkAqsD6Bn6voL9/5kfuIqnzYOhIxN6BjPQX3xPEH//14k+JDkbZlFn5tgS/KgI9aeuwnq5O0OVGF+NGGFWZ0Lmw1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t8cYbnyT; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t8cYbnyT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwzHcveO7/ERD2m+EcHRZJ++hFExAwKQQ8Jb7JSdlSFe4G2Z8s5pHw6vlU+Z34RTitefgEDcEy9jTG0QlePDDZg38xad+kgu7hBF1IdOOJq/BsG4V2SMm+Hwt+LxJ+uhT4HYAHMd4yEZtrNefykfXlsvZze8eMn5MNgNL7UL8Okxk6lq7sy8FM5KIisEoEiDCkoZkKoHuLlSX9dlApbpH6Wfrqg/OnO3Nh+I0OVo3/VgPOoAnuN8EqmC7xoh0Ucp4QzKcaV8NSdSbdNBr6gp79yxybr9ZmVbXwcctr/zzRENNyhEwwu2eZ6bg44rY4GNsB7bmmEyOBiPYmR4peIXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocM80QBD/m6tyjVjU4ATeKk9FS5RL4QQYQ0F2CgwK5w=;
 b=HODi49ZNJP9fiHXXLsafi94FSfDEpf4Sa/B4LKUr0WHIU+j0+9chBv1lBNJUZQnPWGnqMUfHApMFdE/aCCFmqQ+s6G8hklds/2cqsckqRb4i6CkFeotJXnO1pP5Aq4eH997T2OjUc9VRkSgo6H1FHe4Zl/eFv8mE5LEQjBwxLXc7pypuvRKs9Yc3KNLYmzW/Nu9+RY9kM3Qkf1sxm3wIx+2SXhsUrrrqBkmlmR6XJYTuC99AGPjIYMIGd/uMKEf/rbjCg1XQOwAnN8PqwIupbY5jh9aj0V9vcHIDX6MKijaJ/75C6R/py7n8bNjv+BYWmWwQFV9IRK04P/xCexNbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocM80QBD/m6tyjVjU4ATeKk9FS5RL4QQYQ0F2CgwK5w=;
 b=t8cYbnyTABgEBkAIeUy1gcA20hQJJftDg+JbVvdFl2IaVAArHyeJdT/uDPDgb6TyqPrdpx8/F8WB/TQcF2O2fjrjhBufeWFgNSQuogJNbX9z2oKQenQ0kD7cR2ggp6wuIT6HjWL6bxwOKHaUpDnWKxXilBZnRbR1FltfJuoP+wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 11:25:56 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 11:25:56 +0000
Message-ID: <6904e489-2039-4e18-b9a0-8177df1d0a83@amd.com>
Date: Mon, 3 Nov 2025 11:25:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Add handling of locked CXL decoder
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251021205055.2081800-1-dave.jiang@intel.com>
 <0884302f-8713-4d97-9a08-56091985a5d1@amd.com>
 <031a0108-6d30-4dab-b615-03a261eee18b@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <031a0108-6d30-4dab-b615-03a261eee18b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: a047d383-65ca-4183-c3da-08de1acbc16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFRzTzNWME5wcll3YUw5dFlzUHArV2hkTkx6eE83a0JXbVdPOWNWaTJoVlVU?=
 =?utf-8?B?dWRoK1NmMHRYc3J6SVc1OWQzeWpmVVlZUGJDbmdSdEs4OEphSkZ1VklXeDBE?=
 =?utf-8?B?LzVFTGpqcG01ZUdNMmJ2TjFHMmhNQXdKbXVPUzBzUWxJQ1l5VlBTRGNoK0VX?=
 =?utf-8?B?c2pYczZCa3ZyMXFxdERXbXFSWnpSZmpjQkpUOCtZbytkODlFTUVqV0VpSGlO?=
 =?utf-8?B?bXlkWmxZVzVzQVpER0crL0dPVXY0c1BJNTBiWWVnc00xYlNVSWE0YndCNkVW?=
 =?utf-8?B?dlVsdVpkYWxQTFNhOFBQelZ5UmExN1IvRHN2K0I3WEJDYnIxK05Sb25aNmR3?=
 =?utf-8?B?Y2o0TDZDNWhNWFpsN29DaTUwVTExbyttSWtYYkNXTGNrQUdvK2xFcFl2Smhv?=
 =?utf-8?B?cUlKVzdldFAwMUNNUDVpcWUxSTN6UlBJd1pyZkJaWVAwUHFDM1pZVFlFWWpB?=
 =?utf-8?B?eHk1UHp4cytxRG5LWU1XMVdVakxGS1pXQUtsUkQyazZmdmM0ZUh5WWxVMGc3?=
 =?utf-8?B?Vk91RjN6WlFzNWRjeVAxak13WW5JaStpWTFPeUFxcUl2UUZvc1BQOTc3UFNa?=
 =?utf-8?B?TWdtNWpEZ01yTVZNNytiTWVXMEFLSGRKUnQ3MzZIWVA0azBucWo4d3F2dnNS?=
 =?utf-8?B?bWd2RnhNNHJXOStEcDlnS0NpMEQ0ZlNGalBaVEJ5dFY2YVpsYlozUDhZY3lx?=
 =?utf-8?B?WjVmc0xxMmM5SVpianBkQUJBblZTMmRBZkpEU1ZCbmI2NldTMUtzRE0yNWgw?=
 =?utf-8?B?QS84UlgxYnJvVkVqUXQwZTRWZlVCRDZSeGg1S3kxY1BiajZycnVxV045QkEv?=
 =?utf-8?B?TGh6dmhsdURnbjlTRlZadmVLKzNqRi8wcGdUNmlzVnR2VGt5RUIrN3lQZXVD?=
 =?utf-8?B?VjB2MzBUOC9uMTVNZmthbVhWVFdBQ1hnend6L044eGN5RmF3bEd5TEoya1pQ?=
 =?utf-8?B?VjN2Nk1XQ3lMK3QvUit5d2k4bnlXc25Mam5IK3NoRnludGc5dzcrM0dYdWNj?=
 =?utf-8?B?dkJNU2FseGVEdTd3NnNOblh4VmFWZ0czcnJ5WFZqYXI2WVFXUFU0WGFpUDVq?=
 =?utf-8?B?VFVqS1pYR3VhUWpQbWpBVmNGVS9uOGZiU2NTaklNYy9oQmQyTzNWR0FQYVNY?=
 =?utf-8?B?VzEwTE1Na3lCNUc4WTY5S21vN0x6c21zK1QyVFFuMDNSK0Q0dDFvOW5kUTZw?=
 =?utf-8?B?VG1OT0VydzV3cVFkYk94eGhQa3BpOWxXV2dkQXAxTUFVM01lNFY0SjlXL1Bu?=
 =?utf-8?B?QVFxRzhiMnZDOGpha1c4YVZBVUszSEk0ZlJFMkNGeFdRMXFzMnFXeTlXa3Vt?=
 =?utf-8?B?a1g4T1lXYjJUeEJTUmtydzUrQjA5TTl2M08wOFJkV0xXamhveEJQbXpuYW9J?=
 =?utf-8?B?Sk45MVpMcW9vbkhEV2ozdWFuRDZ4TDlLcGtmYkpVOHkvY3hRS0s3S0xTZ3BY?=
 =?utf-8?B?REpSaG5YNktVRU9UQjdpcjI3SmVTbEpWMTZPZnpmQWUxMWNWcDNKb2twZkNR?=
 =?utf-8?B?RElQTU9hSHZDaG5OZHNHZEhjQjA5Q1R6SkhPN3N6M25JZm0ybWY0YUlWOWM1?=
 =?utf-8?B?QTQ3MUpmMlU4eGRqYloxOHg3dGJLUWI0TDBjaGtXdG5kMUFvWEVIUVlBUHlt?=
 =?utf-8?B?Q1djc2pidGdUK1NwZmdTZXB6b0t5bmFpVzlUK2Y2N1VxOStRcGlobXV2S1gw?=
 =?utf-8?B?dVlFbVZLQlVieUI2TmRwTVl5UVNkNlpoUUQ0TWF3cUlIU0VSRGF5WU13SEEx?=
 =?utf-8?B?RVhUZHZQU0lxZ2d2Z0VYWTVzYVIyaG5ZdFBCSWgwYWRGOTM1endETXRxc1c3?=
 =?utf-8?B?YlNmemVHYW9GZ3d2KzdYa2xjZHdONkthb1NWSU5CclBxK0tDWGpzVldkekRa?=
 =?utf-8?B?cEVMU0tyVEVycEZpb1hSWHowQ2JDS1UyeXVQSG84QUZEdjVOQnBMWm5XRy9K?=
 =?utf-8?Q?Yf0u5qrnT43tdCuOFds86ivz2YCrqQp0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE1SWDc2dnpSZDJBd0p4TjQvZWJFcmk0dlE0Y0xuY2xML09NdHdLSGR0dlEv?=
 =?utf-8?B?a3pLNlpQZmZyRDhtQm5YQzl3QnVDeVJOWVNHcXdiQzVVSDVUQWdMaEhMNUNz?=
 =?utf-8?B?SytqQ1g3QVVLVW0vVmYvYnQ1YWhKem90WDZXaXlWWk1oQTVhQXdJQVhHbTFY?=
 =?utf-8?B?RjJBMExoMjlyQjk0SDZ6MU5RZi8wNEFNUHpNNW8zSWYxL1lkNjR0aVluVmNQ?=
 =?utf-8?B?MTltR1JyTk81bXpxK3pkUWNXUU1CYlQzNFUwdlFERWdVRmdabWlVUW5GaGJi?=
 =?utf-8?B?K0hORW1hUDN4RmkrL0FSdUdZRHMwL2IrYVRCejQ5M0FGZWUxUjlCdWxrbHpy?=
 =?utf-8?B?Z3pVNUUwRGRZOXFMUHFMZ3IyWTFpendFVlA5d3lqKzcvQm9mbklWcGYyaEw5?=
 =?utf-8?B?M3lLMjZoNTRtTmVPZXFTWmk0VFBpWW5EQjJsQUJpR01jZDMwOTVVVnZNN2RY?=
 =?utf-8?B?dEJ2dXNrRzZibEtGVm9aS3dxWE9uQkRNakZjbjRpYUlJcEd6emw3NXBFWU81?=
 =?utf-8?B?TGtPcjE1Uk9JMTdtdVdVc0JwYWk4ZmkzQXphV0s0ZnF1YncwVUQ1OXBGK3o4?=
 =?utf-8?B?a3NnY25BWWc2V2NESW0rbmNrMHprRlBucHp0VW1iNS8wV2pWVWlZUi95ZXdB?=
 =?utf-8?B?bGo5NXI0NXcra01RbmtUUkRLUlBoRy9kd3lHeGZyb285bEZFR05UMzhHa3Zy?=
 =?utf-8?B?ajlBTkRhYmgwcVB5WU5oQUVMRlZiRHQ1YlpYZGdBZXJSVjVicmw1cEJqN1FS?=
 =?utf-8?B?WC9qcEhpdXBkeWJueFlBbVRmSjNZVko3QlZHVU8wWDUxMy9xVWN5RWlCUlpQ?=
 =?utf-8?B?Tk1RU3BNOFM0Vkd4RDZFYXhBQloyR2pWR0l6QVdwM0pnYmpCZ25XOTVCOXNW?=
 =?utf-8?B?T3NVWXF3TkNRV2pGN1dUZlZ0aWtkT0hNVEZIOFowV0lYZE9yV0NwcjArNTlX?=
 =?utf-8?B?UmtXdDlHM01uOXlmbFlsL2REL1lrQ1JzNjZnOUN4V2JVVi9hS09qMFhSWUhJ?=
 =?utf-8?B?bHVaVmlwN0NGdGZZaE5mWHY2MUNqM0NYTXVvTGkrejdZQ0Y5T1ZCT3lUQy8r?=
 =?utf-8?B?ZFh4SXRvT0cwVDZqVXhIeGx0YlVHUzE4K2RBbkN5YWRwdUU3Zk9pMWRYNnZr?=
 =?utf-8?B?VkpSQlBpU1lIelViSmdiY3BkaWlyNDFUY2N6UXpKenArdHlIT2dwMGVhZWFj?=
 =?utf-8?B?d0xhRUhTNkhsWWFGNmIrUjVQaDBMTkphUU1YRXpOU2ZxdmdWWXN0ODJQeml6?=
 =?utf-8?B?a1BjZGJ2aFNkTFRqSnVRV3dpOUxuWkQwdGxaVVphcUNGTDVhazhRT1dhNnpE?=
 =?utf-8?B?ZFJzNlRXcWk3d1RsQktTS2dVeHkzUkVzMmlFb2ZTdHJuL2dQSE5pWnNyd2p5?=
 =?utf-8?B?RnArcnJwTEwvcjNVMDZVNkZad0pTTkNNVitwQkRMUzhDdy9TamluZkNrMDRB?=
 =?utf-8?B?WVhzejVVRFhhL1hYM3ByVHAzazhlYjZUeFRUazlxMXpQWFJGM05LejFSeW1i?=
 =?utf-8?B?Um9DbDJja0xocTRwck85TkdPODVOWXVtM0NRSGVKK2lJdHUrbXhIWjUvbStj?=
 =?utf-8?B?NkVNS2pNcnM0Q0hkRVVOODZlc0RKZ3haaWg5TEVYbi93ZVJ6Q2J2RFlBcDJR?=
 =?utf-8?B?c050cFdIa1pOTGdSNUVCeU5GTG94Y1hYZlN3WGcyVFdoL0x4bWgxdG9DUUlj?=
 =?utf-8?B?c21SNTZUN0hVT29tVG41NEt5UEZZZDNBcnNTNy9pZHlBSmR0SUJBekRDZWVU?=
 =?utf-8?B?ODVzOWZ4bC8yclpFdkRQSGFZYjYvN1Jhdld5Y3J6VzFLeGtTWjZUTlhQc3Rh?=
 =?utf-8?B?N3NyY3VkYnU1V2w3b0d3a3h0TENaRDkvTitQelJxdU9qTmtsUnc4U083bXhC?=
 =?utf-8?B?QTgxWDM1ZDI3cVA1eDlzN29yOTVCTzAyT1FseHFxdllHRXdENDhHNnVWZ3lo?=
 =?utf-8?B?WnhuSkMvL3hPMEdSNWhJSXNQekZTQ3AwaEVjU2c0Z25NV3JuNVZ3b1luUktS?=
 =?utf-8?B?bE1YR2FkbC9WaWhVNUwwT3J2VTZmc21kMGZhMW14azJmS1pGUXh0cVp5QmNm?=
 =?utf-8?B?SWh5L1FINVlZb2FOVWI4WkV4UmNtQnhrQXhYQWw2Mm5DbDlRNVVKT0kvTDFL?=
 =?utf-8?Q?94GM32E2Gkx+ORL6og9EogtfZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a047d383-65ca-4183-c3da-08de1acbc16c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 11:25:56.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3JIk8DwKmbmyfZCWbInp9iLbh0oZU7xWKGHCGO0TXmjLYAzVz3KGfBoLxeMqLFLKOHf2Gyf/DN5bHuRCAeZUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061


On 10/31/25 23:16, Dave Jiang wrote:
>
> On 10/29/25 9:17 AM, Alejandro Lucero Palau wrote:
>> On 10/21/25 21:50, Dave Jiang wrote:
>>> When a decoder is locked, it means that its configuration cannot be
>>> changed. CXL spec r3.2 8.2.4.20.13 discusses the details regarding
>>> locked decoders. Locking happens when bit 8 of the decoder control
>>> register is set and then the decoder is committed afterwards (CXL
>>> spec r3.2 8.2.4.20.7).
>>>
>>> Given that the driver creates a virtual decoder for each CFMWS, the
>>> Fixed Device Configuration (bit 4) of the Window Restriction field is
>>> considered as locking for the virtual decoder by the driver.
>>>
>>> The current driver code disregards the locked status and a region can
>>> be destroyed regardless of the locking state.
>>>
>>> Add a region flag to indicate the region is in a locked configuration.
>>> The driver will considered a region locked if the CFMWS or any decoder
>>> is configured as locked. The consideration is all or nothing regarding
>>> the locked state. It is reasonable to determine the region "locked"
>>> status while the region is being assembled based on the decoders.
>>>
>>> Add a check in region commit_store() to intercept when a 0 is written
>>> to the commit sysfs attribute in order to prevent the destruction of a
>>> region when in locked state. This should be the only entry point from user
>>> space to destroy a region.
>>>
>>> Add a check is added to cxl_decoder_reset() to prevent resetting a locked
>>> decoder within the kernel driver.
>>>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>>    drivers/cxl/core/hdm.c    |  3 +++
>>>    drivers/cxl/core/region.c | 16 ++++++++++++++++
>>>    drivers/cxl/cxl.h         |  8 ++++++++
>>>    3 files changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>> index d3a094ca01ad..1c5d2022c87a 100644
>>> --- a/drivers/cxl/core/hdm.c
>>> +++ b/drivers/cxl/core/hdm.c
>>> @@ -905,6 +905,9 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>>>        if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>>>            return;
>>>    +    if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
>>> +        return;
>>> +
>>
>> This is correct, but is it enough?
>>
>>
>> Would not the region teardown imply also the reset of those decoders in the path from the root port? Can we assume those will also be locked or should we add some sanity checking here?
> Would checking the region the decoder belongs to for lock flag be sufficient?


Yes, so any trying for removing the region failing, but maybe I'm 
confused with this check inside cxl_decoder_reset which implies to me 
such a region is being removed. I would expect a check in 
cxl_region_decode_reset which invokes this other function.


But my point is if we should check, maybe just at region creation time, 
if all the involved decoders have the lock bit set for coherency, 
assuming here the specs refer to such "locking path". Does locking an 
endpoint HDM decoder, by firmware or driver, implies the locking of the 
related decoders creating the path?


> DJ
>
>>
>>>        if (port->commit_end == id)
>>>            cxl_port_commit_reap(cxld);
>>>        else
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index b06fee1978ba..8647eff4fb78 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -419,6 +419,9 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>>>            return len;
>>>        }
>>>    +    if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
>>> +        return -EPERM;
>>> +
>>>        rc = queue_reset(cxlr);
>>>        if (rc)
>>>            return rc;
>>> @@ -1059,6 +1062,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>>>        return 0;
>>>    }
>>>    +static void cxl_region_set_lock(struct cxl_region *cxlr,
>>> +                struct cxl_decoder *cxld)
>>> +{
>>> +    if (!test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
>>> +        return;
>>> +
>>> +    set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
>>> +    clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>>> +}
>>> +
>>>    /**
>>>     * cxl_port_attach_region() - track a region's interest in a port by endpoint
>>>     * @port: port to add a new region reference 'struct cxl_region_ref'
>>> @@ -1170,6 +1183,8 @@ static int cxl_port_attach_region(struct cxl_port *port,
>>>            }
>>>        }
>>>    +    cxl_region_set_lock(cxlr, cxld);
>>> +
>>>        rc = cxl_rr_ep_add(cxl_rr, cxled);
>>>        if (rc) {
>>>            dev_dbg(&cxlr->dev,
>>> @@ -2439,6 +2454,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>>>        dev->bus = &cxl_bus_type;
>>>        dev->type = &cxl_region_type;
>>>        cxlr->id = id;
>>> +    cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
>>>          return cxlr;
>>>    }
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 231ddccf8977..6382f1983865 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -517,6 +517,14 @@ enum cxl_partition_mode {
>>>     */
>>>    #define CXL_REGION_F_NEEDS_RESET 1
>>>    +/*
>>> + * Indicate whether this region is locked due to 1 or more decoders that have
>>> + * been locked. The approach of all or nothing is taken with regard to the
>>> + * locked attribute. CXL_REGION_F_NEEDS_RESET should not be set if this flag is
>>> + * set.
>>> + */
>>> +#define CXL_REGION_F_LOCK 2
>>> +
>>>    /**
>>>     * struct cxl_region - CXL region
>>>     * @dev: This region's device
>>>
>>> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
