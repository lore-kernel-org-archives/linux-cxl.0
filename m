Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA510E5;
	Tue, 11 Mar 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709291; cv=fail; b=BHXKOuetjdDj1o6KLUpdQPny2N0QsVCQiiv0Hs+U3SOQJYBjWe4x5wkHzJ37u3/V7V+ehVnWS7U86EcImqUDSMc3aAkkkg121IDj5ZETB99GbDnZwSJAky12Rw1w75HdTHa9AiV3HMDeavHAKJD9tS/IQR4rxe+AFiHNMYPrsMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709291; c=relaxed/simple;
	bh=jtkuuebUjzdv4cTYwnj581jRKRMNJalYfafMkblVlds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CjbMsjxG62GUIVP71cG1kpzrWNZpiKMszJHc2l3GQzb7bpWsqL34rqjfYDK2SkzQkAvAa957KT8R6hUGM/B6FttfmaYi+VxXUJNzThPBC9bZ9r/T3SZAcWV1K80UyE919DkBacbSYFDRFnuyBllxQsqaHgxOsI5bcbFuORZup88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h/LyCMxV; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h/LyCMxV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnVBfNOEOq4ejXWJbNe9XDBWNCsbdzsn6USCruBCZgza6bqBXvBn/lj1p2+HVv5s6Bu50vY8Yr3jMRYAMRpyv/MzNQsu67sOOev/5NpPu5bCIZYKw7H+ykjspFgQZyeQQXuJ+4yU2k4P7qIYaNpQMNEpM5E2cHBzgBkPXJpvbCwVJzQJcXV164QHVCpJZYxaZ/0OBE3RFmT/uUrTkufWydlBd5PE0L8dI/amY8czAX70Bbk4BGAdP6w7u0STKu4pcqJ71M2fMi60nZvAmfnSNEG5VnsbKp8VYMxivi4qb/s/7FrWmtFldR0OPSpgp6X+l8d+ACLMwFYLFhid0Fr1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/rjwdr7B3BKMjtpzt/ryDf63xctjzs49MO8ZKl++yI=;
 b=T/mIhuiroH3q9TQN++BOIHKT+wT8QPf7UyrOjKtVgQ6XGVPYRbqOvLUa4Pz8sRGrDJtIu3TJ18IxCeVILwcahJd6Wkps91fC/Yv1tP4RNZXHg20fizyxPoYNrWrlZU9XlTIOZWgyUofkzaluXuRGh6Z8DYZl6cstuLPZVmOngm/5+WYFB9STquQz4Ysg1q0NzZ9LWBxZbEdZCCDgtzrMXw54CJTpUvH5KZ3hON90kSaoVzVPFVrdM45QZgi7GrTx5hOXNw2u91alH5AG1PMYa9llHOFBk2XKwE4Y66tyw+ox9PkLUNQgRqlKBcOAbTuUGjkWIXs7mQA1Y5O6qv6YhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/rjwdr7B3BKMjtpzt/ryDf63xctjzs49MO8ZKl++yI=;
 b=h/LyCMxVToIkJXuzMHPQl4JK0dFac0kHc9/lwEQiyPBnZNvKCyxYQps7dOxZB/EMftqfp8CQlYLL2IqZfLdwBLziPi1/HECappeGyL67Ie7c0DPleUG3F8xYspVT+1DmKndmfZ1mI18I3wYjQBqmrczljePDb/JlOOzdZW5OngiplPn6xwM1A1NmR+PKg3KTi8eGgGaCLePFZ5ziENMwdjg6E/n9CzVk1dOrt0Z4LXfUPWQiROCaJr9g5nYnVFf4Q0bvJ+8kZW4G9Xj5qJJkcGd7Bac3TNXJxGAiDA0dHVzannj1/EHM5mJqw5tSiknVRpb2fN7Mnrp1H4+EvhJMXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 16:08:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 16:08:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Date: Tue, 11 Mar 2025 12:08:03 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <7A60A7B1-0BFF-45ED-8A11-06F0D5286723@nvidia.com>
In-Reply-To: <Z9BdwFZ-ZRpMSabG@gourry-fedora-PF4VCD3F>
References: <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
 <0C5749C4-B3EE-4393-A8EA-AA56B399E9E3@nvidia.com>
 <Z9BdwFZ-ZRpMSabG@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: ad892dcd-63e1-4543-98d6-08dd60b6e96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YktvRmRGV05NWWZhc2YxTjQrWEtORVJtanRwaHZnU1liT3BIWURjaWVLT3F3?=
 =?utf-8?B?MHZwMG56Y09pMk9wcVUyNTFOMzJnNnhyWnZyMS9mYWpRTlpIczRQZ0NNeitQ?=
 =?utf-8?B?aXNHbWx5YXcyR3Y4cTZxR1oxbFQ3eDJQemV5VzZPb3BsZDBSQ0JGSTUwZU9k?=
 =?utf-8?B?c1dGM040dDdGUzNwdFh0T2JlUlh6cGVOaFdlUVJuK3NUYm4yUVUwc3VpZkZz?=
 =?utf-8?B?bkRzVGJDdS9pR3Y2VFRwaXhzeHBoTHNLTjdyTU9oZkk3TVhMUTJnMWFRbUor?=
 =?utf-8?B?UlB6WEhoSjVoUmUxTGphdzc4aWRVK0pzMFpwdm52a1FYZ3l3bTVjR2tRNjlZ?=
 =?utf-8?B?N1VsK2xwNVR2dCtoV21aOSs2QUJQVldZeXVENzRnQU9OOUtDRWZWSXRQeHJ3?=
 =?utf-8?B?Qmw0ODJiK2cyR05RTDVEeTVSSXhPWnRzdnJZdEVNYTdnZ2lEbDdwbitjTUV4?=
 =?utf-8?B?eU9OMENBTmgrcERLcTd5cVlhUUdkWHNtMkxVY2J1b1pjUGxuMVg5UEhmTWU1?=
 =?utf-8?B?cmpPSUUxMjZlQ25CRnY4SXRSeGo0b3pJNitKQkpEaTVzMEdGaUJDZmUyU1hW?=
 =?utf-8?B?RFkvdjNrdFJrWmpPZlljdUFpV0RKMUxIeTB5RWtCRzJOekNNWm5Cbmo2SUwv?=
 =?utf-8?B?U2E2aDRwQnBaajNJZGdFS21WTVdHcWJKNlBYNGpZTjN2L29YaVhzc1RjK0Zx?=
 =?utf-8?B?L2tNWGN2Q3JpU0ltb3ZlSk8yMVpXd1hrbmR3UFZYanA3TG5kdUYrYXM0M3B5?=
 =?utf-8?B?OUJwcmtyTDZDblpQdFIxdGJ0aDNmQkoyZXRnR29Jd2Q0R0RIOXNDei9zdTlL?=
 =?utf-8?B?Q0dnNStoVzBwbUcwZU1qek9iaFk1ZDBHSGJqTktnRHpuZGhCT3dReUNnVDhi?=
 =?utf-8?B?cWlaVWdjdVpKbHliVlpzZ3pjeHpOaTBxWmxsMklKZGhtMHBwdWIwemJqUERk?=
 =?utf-8?B?UmdLMjFyU2JGMnc0V1J6dDM2NG5ROERoQSs5SlJuU05WTnJGY1dwZ3BQNzlB?=
 =?utf-8?B?YSszOWw3bVMvVFFZY3pFOXhXWnpFZ1orY2VHMno4MGt1aXRjbEk1cHE3bnpr?=
 =?utf-8?B?WWhMbmFzUzNobXFIZ090Yk9tcFNqYi9XTStrbEt2U0RobWpCZnhHcHczczFj?=
 =?utf-8?B?b0xRZ280RHlWOEdSaFNVOXk3UzFUcFJjbTZuQ1d2SkNVTXZlejByVlg3UkVs?=
 =?utf-8?B?ZUt3L1o5WU1KQkRpenZxb2wwSUpYQkxNdWhST3d6Nm9YdW1pSndZc1JtR0NS?=
 =?utf-8?B?K3drZ0hPSC8xRndMM1FHdFNoSjU5Snk3UFdHMVNQWVlUL214OUxBK253TDQy?=
 =?utf-8?B?QkpwUGhKZFdEdmgxS3NXVmU4M3NKNGpmZlU1TGRwQisreVlIcUw4RU5vdk1I?=
 =?utf-8?B?RFBFczJuNkVSbEFkZjdpK1dEVWpZOHZKcEIzUzROV3lXSTBCRWR3OEUrYyth?=
 =?utf-8?B?QVhEWkZ6R2hqblRBcklZelpidnhMMlZtL1plZVNqZXlCcFlhTnU3Y3U4TTlx?=
 =?utf-8?B?dlJGeCthS1VlR2RWSWFhRW9ZcHMwd3BGU3RlVWRlME41Ti9Qc0NOVVNjU2NN?=
 =?utf-8?B?Yk9VZFY4ME5rNjJ0dldwMGw0Vk9wemdvOFg2a1pqK2VyeWVQZlVIdWlsYnUy?=
 =?utf-8?B?UUtEcTYrQ0ZWVmE0eXNKNnhRTitqTkZzMHlIVHgyQTBFTzdUT1Zhd2VnSzFj?=
 =?utf-8?B?cDgyLy8rajF2Umo0NlJOREsrZWpGaFJXY1B2MGg2L1l2NkV0R054Z2UrMk1V?=
 =?utf-8?B?eWFvQXMyUS9OS0VVWHNqZEhQWFJqdWtLVnU3TkZKRzBmZ3Rhbnd4RlExNkpy?=
 =?utf-8?B?TXcxUVhEUUdqeFVYYnZZSDVZNFkxVXdDSmxIYUJveFdwNlNLRHo1cFk3QjI5?=
 =?utf-8?Q?xY3TORHJWAWrX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVFxVDlMMzZPVTdpaFdBT0JDUm0xamtoY3pYV21CNFRFL3JZclJOMDByZUNq?=
 =?utf-8?B?anRNb00xOUNjOURSRWlIOGFvMDhTbGI5cWY5TXdhMENyQlJRNm5JaW1RR0hu?=
 =?utf-8?B?Y2dHQXlraEJKdHRvd1J3MTdTNC9UVHlLT0xITGRxNEpRK0I0Sm5WSExsV3lF?=
 =?utf-8?B?Y2VsckdPbHhqY0hZWEI3WDNvSEZubUVTWlhwbS81Y1RsdnM1ZFE4bExMZWgr?=
 =?utf-8?B?SUpHTWJhVmZlaml4SFkyZ3V2YzQ2VXBvMXl1ZVVVUXZXRU5lU1FwaEJoclZ3?=
 =?utf-8?B?anNvYU8yYXRoY1NpR0JaWVF4SG5qN3dQSUl0VTgyUzhZd3NEdEc0MFRCY2hL?=
 =?utf-8?B?cWZDcitqaExOVlg3SXc4WE10QjZDNzJXMFRSV0tpc040bkJ1S1lxdHNRMXV1?=
 =?utf-8?B?Zk9MdDRxczRrUGNHSVREWmE4WHlob2JCSWJJWUY2QUdkaldoRGJWZHN4Yjkr?=
 =?utf-8?B?VktrZW1VdmhyNzBpYWRjVllKSXZhM0ZYV1JnWmExQUdvTFJ0c2FOTXduSnl6?=
 =?utf-8?B?M2lXb1N4dkd5TzE5RDEzdmh3dW40aVBHbUpPUDczZGpKREtPa0hzZHlLODdR?=
 =?utf-8?B?cGd0ejR6bHNUVEgxYStQNTd2dVlESVU2RWNCeHUxUGtzVkxuTDFUaDQ0Q0RC?=
 =?utf-8?B?aE5lSFo4dnc0T0hwbnczUXNmMzZjMFMvRnF6U2V1ckdPUC9DNVh0STJVNG1M?=
 =?utf-8?B?ak5RdGRYeUlrUEZtVzllUTh0b1huLzhMSWJvS0V6cDFkeWwzN3NFcGVpaTRt?=
 =?utf-8?B?WUxqcTFBaENQZkkwRk04cS95SmtLcnBML2RCVUhTVHBxa1JudEQyNE5tYWRh?=
 =?utf-8?B?U3VaTjlBNVdhZWx3RmxFUGhNZ3lPK2R6a3YxeE1ROGVJMFZIZ3g1U0NiV0VC?=
 =?utf-8?B?YmZGRFIxSXNXc2g1Z1NlZUQyQXNXUHdvM3BxTmZpN3hGWHZ1aHNSMjJkbjJT?=
 =?utf-8?B?Vm1DbHZLSjZhT1R0Tkp1SS9yYU5UR3JVM0p2V2h1UXVkT1RzeDJVK2FqU1c2?=
 =?utf-8?B?a0J0TVRzMVdlZ1I3bFd1Ymw5bVh1ZHl2RGIxWGxHRzZNSFpRYlN4bHVKRzVG?=
 =?utf-8?B?TjFaSEpmWVNlME81SHZPc3NUd0t6Si9UUE1nYlozamJMOFRab2plTFc0TENn?=
 =?utf-8?B?eWdmVktnc3dqbElTTWxPVlpncTJncVJ0K0NKMTZGK01VeUkzZ3VMdmxqSVZj?=
 =?utf-8?B?UXhrdFVSOWZaaDZIL2ZPeS9CVUgvcGh3UzNNaVI2OHN0MUJjYzZCbFZUMm1G?=
 =?utf-8?B?cjdUY2QxaitsSlNBZE1aU1M3VjhOQ2V0QXpySjhuaXJaUlRad3pmdTdQdGVR?=
 =?utf-8?B?Z09nTnArMU05Y3UyOC9ZRCtYSDdEKzlETjFCS0duYi81d3kzT0tpZWlyeU56?=
 =?utf-8?B?ZTBwUzRJTUpiTU9nL2VZMFIwVGcrWWROdmsyY3ViajZiUUxiUWVhM2NHUzY5?=
 =?utf-8?B?dE1ZWUlldWFzSnFobWdUdjBxdUhGQ0swc0lrK3QvSy8wZGVsK3BDRHUvR0U0?=
 =?utf-8?B?dzJvS1JiVHNBaVFLMDFmOU5xMTJ6YnYyQXd4aWlBeFE3eDRLZ3NuV1lmRXIx?=
 =?utf-8?B?T25sMzZycno5dGhxc1NtVGNpZkJkL0c2NC9GSEFMZVpISzhReEhNL0kzWDEw?=
 =?utf-8?B?ZnFuZU1Fay9QbzcxSDJOd2hwck9WWmR3WlV3YWxiTmJjaGtYZkV0d2RyK3FT?=
 =?utf-8?B?ZGNOWkM3R05KQ3RIZ2tOMWhpcTFzSG5lOUs0UW53ckJjYXlKc2xnOFRreFZC?=
 =?utf-8?B?UWwyQU9aZ1JQQ0JCNExTb25iQ2NEYnZkNUdKblhWYUsrZkFBWlFES1hxVzBo?=
 =?utf-8?B?REFkWVRTWlVFemI4R3dxYXBoZVRCSGtuZjZ6MDQrN0ZxdWtwYjNtOHlCSFZ5?=
 =?utf-8?B?SloyZWRUSHFXL3E0emFZMTZWZ29SU1A1OXVTMVRGM0RVNUIvL2FFUGFCRUIx?=
 =?utf-8?B?cW9aeTY4QnVDT2hSeTkxMVloSkgxZTl1ZG1RYWxtZmQ1Ync0cmJRaG9lbnZD?=
 =?utf-8?B?UVMvTEFuSE5VQjlTRzIxL3BUMnB0d1ZUaW5LbW56cW9XZDhYdi9KTXRSbUxH?=
 =?utf-8?B?NldxMDUxQVZRNjZHWlRyYjBtU1FrNnVzVEwzdlJkM2tzcXYreTVMTWNCa3RZ?=
 =?utf-8?Q?NpK8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad892dcd-63e1-4543-98d6-08dd60b6e96d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 16:08:07.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ai1RcQ9WA88giwZ/U6BE7tSRI8zubnJOYgqYiYxtg4B8gh5A4hJxOnsBdJgYiZKH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907

On 11 Mar 2025, at 11:58, Gregory Price wrote:

> On Tue, Mar 11, 2025 at 10:53:41AM -0400, Zi Yan wrote:
>> On 20 Feb 2025, at 14:26, David Hildenbrand wrote:
>>
>>> Yes, the only way to get some 1 GiB pages is by using larger memory blo=
cks (e.g., 2 GiB on x86-64), which comes with a different set of issues (es=
p. hotplug granularity).
>>
>> An alternative I can think of is to mark a hot-plugged memory block dedi=
cated
>> to memmap and use it for new memory block=E2=80=99s memmap provision. In=
 this way,
>> a 256MB memory block can be used for 256MB*(256MB/4MB)=3D16GB hot plugge=
d memory.
>> Yes, it will waste memory before 256MB+16GB is online, but that might be
>> easier to handle than variable sized memory block, I suppose?
>>
>>>
>
> The devil is in the details here.  We'd need a way for the driver to
> tell hotplug "use this for memmap for some yet-to-be-mapped region" -
> rather than having that allocate naturally.  Either this, or a special
> ZONE specifically for memmap allocations.

Or a new option for memmap_on_memory like =E2=80=9Cuse_whole_block=E2=80=9D=
, then hotplug
code checks altmap is NULL or not when a memory block is plugged.
If altmap is NULL, the hot plugged memory block is used as memmap,
otherwise, the memory block is plugged as normal memory. The code also
needs to maintain which part of the altmap is used to tell whether
the memmap=E2=80=99d memory block can be offline or not.


Best Regards,
Yan, Zi
