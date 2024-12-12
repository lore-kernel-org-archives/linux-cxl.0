Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85764A29;
	Thu, 12 Dec 2024 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733965371; cv=fail; b=bhgUVKK8TKDor3j5BeEeWHJhaKNObSwELsITuFqogHAsr0ky+LI3QdWu3AZMK+fpxzSoTQHnisg7iw1zpnEeB1yCa7h/bGS6Mgueu565kjnIh7X6WbTk3wUJsD19nNmfIk0KfbwPFTPhnY7pi++vH65R2pFJwaiBSt+IMmx2bsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733965371; c=relaxed/simple;
	bh=/uRSvWN+ZQqG84r4XXUhwPNtzYKvTRauystimK5fWzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EEwERx60dwSwtrbuFFkKHc3RVVSZMiFdksZV/mr8BSE2wccXSydyMCzyu571cyK7kZp7PGJtWoS58fPKVHg0XiSylqHiEFSxJcNN+Wodw5HHqEGDc8KQvgVf2X0kaMjQK5hIUoLc9IQO9MU+P/gZf8JQz5Lp+KwCMUhcUoC/s7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u8eFXGu7; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u8eFXGu7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GV6cbIvhqkeK7V9VX8VEysiiqAau2J9h2+E5TJnd9l91xcpCQUdRhv19ax3wrnPFSEEfe7aTbWMbyXKrEzAhTuSRxkWT6k99MNbM65TeJv3P95xmN2DUzoOwrJ8fdBxXUuORH4Rz7KfNqQBNYiG0Ilw1wlpGQZJ5bQZ0OHcYzoHjqYljeY9goJS5bGjvF4uuLQc49UR3vjP7Qa1r0zfqbPwWF+CdXTPKrSCaaSF5/usF637Z+4BreBB7NOTSL0hx0tIcbMmKDxMX2m0x7WzfxqKOevS+wqWcjCfeYtPDGMdWnlAT4WpwZLvUeSnChhzwan4vltz71ZHc2SPB2ileaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMJxUHzbACKPKKWH/+gdjrWwH8FFuv8eLHe3TU57CB0=;
 b=Alf2REmA3q21m62YQEP0RcFNA1oJh4HNawRCwLwO7AIkjivKyQ9H/NMGAEYes2hi1Qm5Ooon03XyipgCnlsa0vy0DuL94h/E2UKInhrH3oS+xBg5hhqMb05n3N54TYnnxrvNjNo53OuYjHaasvfz615LUkfeQpl2YJX3JsLMLb4JGbHYy2HhCQZNk5HRL4YfbSN3LYPQHFu05UuNkUFhm2pSjfz1y4UnqQX6b7NDiiCLffdh3He9sK/HJUvUx8PkmR73SxTDmYQnjZn6Upej+2RY65AnMpM+dlB2/vem1BxteL+G+Mq3d2l4nPL58wUWR5Xo67t+KwEhKNipNn+xBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMJxUHzbACKPKKWH/+gdjrWwH8FFuv8eLHe3TU57CB0=;
 b=u8eFXGu728dAUaOFNWtwpiL4lZwWejKG5GpYb7f6egsU/lD1+S9vZnRorXV+2IYDuizJSMgcTU86TrcXKuaiuJMLp4uwdKn5G5cWAEnxHo4lUvf/K3jorcZ1sbQX4suScNDrmbldOnLGgMabIA6oE9GhtoPyD0lCqE6p+eR5F1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 12 Dec
 2024 01:02:46 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 01:02:46 +0000
Message-ID: <5b45ac9a-255c-4c74-8231-bc91c87cc0aa@amd.com>
Date: Thu, 12 Dec 2024 06:32:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
To: Bharata B Rao <bharata@amd.com>, Dan Williams <dan.j.williams@intel.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
 ilpo.jarvinen@linux.intel.com,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Fontenot Nathan <Nathan.Fontenot@amd.com>, Wei Huang <wei.huang2@amd.com>,
 regressions@lists.linux.dev, "Huang, Ying" <ying.huang@linux.alibaba.com>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <674fd2b4942f1_3e0f629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <33b4b93b-5ab6-4a3b-b3b2-c9b3cbc9d929@amd.com>
 <6752acd92baf0_10a08329424@dwillia2-xfh.jf.intel.com.notmuch>
 <2b5bb8d8-6a7d-4a58-bde7-ce42d0a23f61@amd.com>
 <675918b414c17_10a0832943b@dwillia2-xfh.jf.intel.com.notmuch>
 <de22dd6e-00a3-4183-a123-15cc7c53980f@amd.com>
 <67594f90a7b87_25073294f0@dwillia2-xfh.jf.intel.com.notmuch>
 <d8d2c310-2021-431f-adbe-71ad0a17896a@amd.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <d8d2c310-2021-431f-adbe-71ad0a17896a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067F5.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::36) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|MW4PR12MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 8668efa5-c40c-46fe-b7c2-08dd1a48b062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVRjcFFLbU4rUXQwSElmL21lQWh6YW5wN1o1UkNRcTVTcW1IbmI5cFhBemhZ?=
 =?utf-8?B?N3B0ZjZySFFvWWJJL3Z2eWVrNk4zeTYreUQxV2c0RkxyMlJMWWhYQVlWQnZQ?=
 =?utf-8?B?Nm5pRVRjNDFIV0N0cDdGSGx5UUJGVk5WR2dVSnNVU0FOWGl1S3AvN1ZxNnNJ?=
 =?utf-8?B?V3dyVk9xa1dtTHNDUVhIOVFLcExzWmRuTjg1TjRzbUFvdThjU1ppeFV5akZC?=
 =?utf-8?B?ak5IOGhHOHhDOHovU09ldEFFUFBwZVVlOXRUWi8wZVVra2JVRHR5cTh0NjQr?=
 =?utf-8?B?SS8zbGZsR0xLSW5nSlROb3ZTd1VOMThVallFbnZzREdrZTVrTzduZG1lbjdN?=
 =?utf-8?B?ejJtNis4akE2Wm52b2dLaUJ1azFQOGxUSHRJYmh3OEZacDJLWWx2cHpscDdp?=
 =?utf-8?B?M1VsNTc4NjNya1RoczJuMEh4ZzBraFlORERKMXRJS0Nkd1RCaFRXcUtGLzI2?=
 =?utf-8?B?dG5RKzZNQ1BYc01XNk9OQ1BLTzVYOWRGNHBER0ZOQkd5VU1UMWR5dHM5dEk0?=
 =?utf-8?B?Umo1dXNGYVM4M1ZJR3BXbkxqdVVmU3VSWGMxamliRWErcHlQZjdoOFV1WGVG?=
 =?utf-8?B?enVZM1JicVl1TjMxTXkvNTBBcDZuUTkzOGRKdFFySkJrRFZBQnhQU0VUak5y?=
 =?utf-8?B?M00yWE9hcDh3RnVDRk9aYU91bVR3dm5oZFUyQUliUEdKRmZsVkZnYjNsM2sv?=
 =?utf-8?B?bTdQUnViSXJhd3djbjVzTi81NGlMZkl2ak1KZUxoZzlIYnU2cXNhRDlRSWY3?=
 =?utf-8?B?bThwdlJGWktRWkJtdGdsRGtoNjh0bWpHWER4M0dCby9yYVFMbDlqSy9TeVpt?=
 =?utf-8?B?TFJRVWVhVG90d0t2SHB5d1cyTWx0MHQxdER3SERBeTZIZkRadzFxWmMyNXA2?=
 =?utf-8?B?SkFkZnpiazV6dWxaaGlZa3ZrOG9FZG1XaUgweVVFYjVlU1Bzcmg3emkzZFZT?=
 =?utf-8?B?My9GaTVoK003YUU0ZUxnV25rdGYrbzMxRmpHR3pqVElycWdIVlF4UGFBRWli?=
 =?utf-8?B?SVkwb203MDMvTDBEZG5IK3c2Zk9hdGUwS21FT3djSC9YM3RxRXY1d3diaGZL?=
 =?utf-8?B?UWhhVFpNc1RtdGFEbGxMbDB4M3hUMUN0amlmTGk3UTBTVFhvT2RkMStYYmdC?=
 =?utf-8?B?WHV4alliMXhOek9hSFhzeDRtR1JHMk5UQTVoL2dMOEVmWUpSZkhJc0x6RVd1?=
 =?utf-8?B?S3Y0cDBwekhBbGxuTnB1N0IvbU9XdXNSdlRCL0l4WTFJekZPL21YWGF1YUlv?=
 =?utf-8?B?ejdEbncrNllBdSt5SzJQcHNJRmNMNHk3UlVBU25mNG04NEhzNmNTVktDTmV0?=
 =?utf-8?B?ZFc0K09zc2FXd3A0VzU4bUdqYitqdysyWVZINzd6b0J3cENoblNoQzV1M3pW?=
 =?utf-8?B?MUp3dUE2UVpwLzhPRXN1U2o2YnUzTlV4NzhmNDZ1VEExa09udDNUMitpclB0?=
 =?utf-8?B?WWQvYlNBNE8yRUtjaW82YzdYRkVTMnIyNC9XQmdFd0ZVRXc0ZWdVd0pxVnpu?=
 =?utf-8?B?ek1XYUlBV3JuZzR6UW5UeXNMZFpncmhDNFJOb3hBeHdJQkVmUWF3ZjdOWHNj?=
 =?utf-8?B?dnhENU9vS2E5YTJIU1dydzlTc3dXOGlCU3dqckJrUjFCOE5OYzFwcGhzVDVz?=
 =?utf-8?B?OFNsQWZJTTdaNEJXRmJPZlBIVi83WFpXYWYwMmQ2cDNIMUd4blBSOHBUcHU4?=
 =?utf-8?B?bzk4Q2ZpWDZGWWt4OXF5OEF1eENhNXhaN2MxN3ZqbmJIY3hxZ09XTmFlYnlt?=
 =?utf-8?B?dUt6VlhiQldzcE1JdnNqT3VWNEZnLzc0UzVTbE11aGRicDhwZitCYnNuRW8v?=
 =?utf-8?B?UW9sdzlxUHYzZWtoUjhiQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWpuUnVVVVJiNXVVV0s3WUdlSGt6UVBYZXdoVmM5U21ma2thd3hMVlZJb2dV?=
 =?utf-8?B?MU1vbHFlWjI5MWtUeUN5SzNMOWFQNE9malc0WjExSkM2aWp3ZFc0bTZLMTZH?=
 =?utf-8?B?V1F0Z3BsUFlScVRHK3lOZHFFaXVweEtOQU5mSFdiT3p5YWpJSDEzQ0Y2UFFi?=
 =?utf-8?B?b2xET0hENi9QaEpMMkNFRnhjeWF3QUdyeGtlYlgyREdkL0hEVytVNFpFLy94?=
 =?utf-8?B?dWFYR1Rnb0JoNk8rQ0ppaXFLQm9weVdtY2Q3UEJMRVlPZ3h2a1p1dCt0aXB6?=
 =?utf-8?B?a1F6cE0zL1J1MlhjUUN6UnE4Q2p6Z0w4TGZ3VmZMVmVCbE9VOCtMNHV6ZlVS?=
 =?utf-8?B?c2tScTNWVE1uRUVFM0VhK3RLQTlnY2F6bml4aG9BVGE0OWVoK3hqV0phdFFO?=
 =?utf-8?B?K002T1NNaERMTlZxQWxGSFQ4ZHlmSWt1bEZTOE5zTTJ4TVJkcGlMdkVSWDBH?=
 =?utf-8?B?VGdtcVorMDRUemxtMEN2RDlja0Z6MGZpVjlJM0hoeHpOZGk1TVhOK3dEdmRi?=
 =?utf-8?B?YkZuMVNDNktvTjZGSmd4Q0VsM3pUdldaMmZvTEcxSUZTK2NEUnVPV2ljWG5S?=
 =?utf-8?B?d3dxSXNyMXQwS2xKOGJxc2VmMGcxaXVMSEVXZzFvY3Y3anFJZEU2VlljVjlp?=
 =?utf-8?B?N1JYLzdCcmt2VWVXVG53ci9tR09qWkFic3RXRTZCTElqeGNCSmlWaXpkc3Bp?=
 =?utf-8?B?RWYrRTQrR2pma0cwc29oT2t3RTgzMGQyQjFjemcxVkJHTytjZzdHOSt5dzFx?=
 =?utf-8?B?VHUrOW51Nk81dVlrYlNQSFRNN3lSUGlLOUJSTU5JaXY3a2ljTmpLeXFCa25q?=
 =?utf-8?B?UE8wQlIzOVljT0M1Q1RxOWp1RUI2V1Y1UTcwN3MvdlpBQS9LV0VOZ2NpbGtZ?=
 =?utf-8?B?QmFpQStxUUoreXJEM0pCUU9DempEaStIRi9VMmJkZ3ptT3hGYjNrTGw4YWJs?=
 =?utf-8?B?VG9JM3RaT2JmZVlseVJoZkVSY3A5K29EcGdsczBNbzZRYlBKRjk2UWU5R3Iz?=
 =?utf-8?B?TVhMa1FxLytWTFV3ZDZKRXNjOVVCSFJBQjlVaE10S29yOVBER2dRVE1aMnM3?=
 =?utf-8?B?QmcrSTlSM1pidS9hR2ZEdjVxS01nZHFUUmtZYkNTUlZqTFVPM1doQjdhcUdV?=
 =?utf-8?B?NmJXcUlxMC9mNUREQkVkRUh2M3hDcnQ2Ym9FNUo0NHp5WU5YZGlMTXhINngy?=
 =?utf-8?B?ZHVNUFJZTkk1SXVzUFc2aldyNEZHSzVuNFFpWlAvQzhYRkJLODl2NDhPaFBs?=
 =?utf-8?B?TXBZSXpoYnNtWkxyMkhhV0x2RXRkeVZ0Z1FQOEZxUjQyc1hBMU1pL0poelNJ?=
 =?utf-8?B?SzdIbDI5WnBUTHRNd08vRURvM2RwZis5T1FGMEJWU3lLcVEzc0RWVXJNR05s?=
 =?utf-8?B?YkxvNktYMVNHRFJsaGNuVWowT3pmdHNRS242VjRPVUFPU29UYXdyRU1WWFFK?=
 =?utf-8?B?WW5Kd2FyeHdoSzVzek96UTl6SU5WSzBQamdOSlVicVZUMkV6Nmp1YUVKK3Z3?=
 =?utf-8?B?RjB2akJId0dBTUxkZlRKYWZmQThNYTUwdkV6WFB4RnQ0ODdzakdxNlk5dzk5?=
 =?utf-8?B?L09OamRrVHVhZ1dvNHhqNWI0ZDFDb2dkUVp0NGNaVXl6Y0RHUEVUMmcxNGto?=
 =?utf-8?B?VnNlUy9DdDRkQnJEaWM2VkVQaFRwaHlGaTJjYTJiTXJYc3J1R2IvOGVwZE9t?=
 =?utf-8?B?alp3Z3QwWk1pazFSaytZWHorRkJHbVdDVDBjN2dJMXRPMlhWODg5ZitwT2M4?=
 =?utf-8?B?dUN0ZitDa3dwSjQ0UXhxNGl4SE81WTY4ME9heC9pTHdHMG5MNnBYR052T3l4?=
 =?utf-8?B?emJDN1FPbzUrMFd6ZnRyQ3FJVmFxdUFFejdxNGVySFV0UEc3OEFGQmRNbzVm?=
 =?utf-8?B?eSsyS2JPb1JKRUdCSmxOT3ZiZExlWEdOQ1dlaVVwUVdJUytVSy9SNTR1OVUw?=
 =?utf-8?B?QkdzVWZkUXRjb1llVnE2RXZpQXVEWm54WG9RTjZ6WHhONTEvN2hBQWRKRW83?=
 =?utf-8?B?clBoQmVVVlR0Z2ZNanRndE8wdzFxRzhVK1YrMXZNRzAwakxZMG03TTBKNXdN?=
 =?utf-8?B?V1N2Zm9tQWVtNzNqVytLOWdGQ2JKTDhqM1ZNVWtra0RIODkyVUZnRzlYQlY0?=
 =?utf-8?Q?08GsyK7ZKfXBpm/MrACNYSs3+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8668efa5-c40c-46fe-b7c2-08dd1a48b062
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 01:02:45.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4bBEvcxhidLFH3ylxKXZwpfs/LTk5KTbdGMnOjELzvnw8Lfg9GFTOZ6UHlHoj6LnIIOPq7fmDVzTb5kDT3S0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381

On 12/11/2024 10:17 PM, Bharata B Rao wrote:
> On 11-Dec-24 2:08 PM, Dan Williams wrote:
>> Ah, thanks for that!
>>
>> So, it turns out Ying's patch is working as advertised. It is traversing
>> past the top-level entry of the the iomem_resource topology to 
>> discover that a
>> Soft Reserved range is described by CXL. Then the expectation is that
>> the CXL subsystem parses the topology and registers a dax device.
>>
>> I missed that detail in my repro because I was not testing the HMEM
>> handoff.
>>
>> Now, the dmesg shows that the CXL subsystem gives up early on the
>> CXL devices as they do not appear to be meeting the expecations of a "CXL
>> Memory Device" as described by the "PCI Header - Class Code Register
>> (Offset 09h)" of the CXL spec.
>>
>> Specifically these messages:
>>
>>      [    4.449072] cxl_pci 0000:9f:00.0: registers not found: status 
>> mbox memdev
>>
>> I think this situation is increasingly showing that the pace of
>> non-standard quirks being deployed is higher than CXL subsystem is able
>> to keep pace.
>>
>> The immediate workaround to this problem that Linux discovered is to
>> disable the cxl_acpi driver. Can you confirm that preventing the
>> cxl_acpi driver from loading restores that missing node?
> 
> Yes, disabling CONFIG_CXL_ACPI gets the CXL node up with the memory. 
> Thanks for this workaround.
> 

Thank you Bharata for filling in.

Thank you Dan, Andy, Gregory, Ying for your input. (sorry for the delay 
because machine was not available as pointed by Bharata).

This helps to proceed with

CONFIG_CXL_ACPI=n for now in my case.

- Raghu
