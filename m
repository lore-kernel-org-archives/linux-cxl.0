Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432219006F
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388786; cv=fail; b=X7VLS0JO0uh54Y5PSgr/uwwB/ZXvmiT8evGFN1K34gpsgaKoqYPjasRzFkJuc2ZWQdW4HriUxr/Yy87vEIxLX9omE3Nqot1yBzqeahyngec0RAwMJC6vL7ZcVCieSiv7E3LbGwnqx2qB0/JxNA0+R6MPnWcWzq8TjLY3DEjgdAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388786; c=relaxed/simple;
	bh=8PwkJDBIieiPXzGY6yd2yls5Ik+M9JsT2a+HsjP7Hds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MWKVvFQMcjzvmqSPUXtte8H6MHEI3mFGXzHVfpqmEsHfuMUxtuTxymYnHB5z6EyTRi7o/chkyoQ7q4MC3gw/1m8SO9obvSB2dC7K6vBGMLnkz4BTgV9QIwlxVZG43XLuldxsH0ntoR9s0RAvWfr0zNHMZjL1wpA80Q4k1YNFEtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fSvLh+ul; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fSvLh+ul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwqYDF2jhwvqf+DkBqA6007d6pttL7oa8H0YC/eIRNqiD+xVwTWMrWovQHUAuOIiK0gFJErRzmiPXUmla+2ibb0Ctb7H624D5JzxVija3GxJ7aTEuEpBveT9dZGe1mWGH20T+gYv7bMK/J4A1vGePTSdty1vjfqIxBadysXvvfzyt43yINFaoYikapu4Mh1PX45h9G/Je7AF4bn4XFL3ZY2vElXj5+kn6VefYCQ2QdFruB8Xz4OGenbDdVcTzrX+8BZ6H98EOKc6HqW7Bu4S2R8w9SxMIX7FT2FvY6gbTAizSMXaUCYNUVVYkfVSvsPXCIF6pc4IGiloB9B9e8ZWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6umWiR/jip7lquBeCbpg50FKH8d6I0nbq87V7mnzxDQ=;
 b=oz77139H/9KgURqrNhH0mP8w45iDw/kkWvTPIjIa+lF+wQohqGNsdeTDYDIXau0pE7XZi968fshThyrGmL8a4PGgGC5Xo+ogPxSeyDxFsIA0rDx9ebpvs+YCx+aKZ09lXS5mcdK1KTR1ZiXT47zg9Q/IpHXdU9Lrqv/v9qCsfZQZ8iRIYepA34UgoV3Tm7WC5ESZPEPa9hYrQ5djv8CR5Uax0/MiX6tWg8WZ/NWBRmgob8qWTt1xHwYK+2vAPDWqG0PklfxIb7u0z7SX81UCBtljY8CbzMXdFdqrgSpEHh1of8gv4bSPz2fxIElfQUuCH/aTLJaJ6cY1FrY+WnWzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6umWiR/jip7lquBeCbpg50FKH8d6I0nbq87V7mnzxDQ=;
 b=fSvLh+ulYWZMILkHUAyQmO7RVXcog+3mle4havuKxuytUSBAWwZOV2oJyqezl7YCGADSHz+mO/BY/JxeRCePjb8ngVCtFCqFMbB97IoG9PC0pabQSDNbY+kJRmiRXJ79+sxKexKPq+2kwLhQPlge7sFAn1ySvR+Gj2EqL38PJcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 23:06:21 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 23:06:20 +0000
Message-ID: <3ed69bb2-3c93-42c6-9f02-9519482b112c@amd.com>
Date: Fri, 7 Mar 2025 17:05:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "Fontenot, Nathan" <nafonten@amd.com>, David Hildenbrand <david@redhat.com>,
 Fan Ni <nifan.cxl@gmail.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "gourry@gourry.net" <gourry@gourry.net>, PradeepVineshReddy.Kodamati@amd.com
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
 <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com> <Z5CKN57paDmGJH9A@gpd>
 <5067fda1-c2de-4a20-9025-ebdf90ebba8e@amd.com>
 <9b0fa1f7-4133-4111-9142-143c36c42f8d@redhat.com>
 <69701a1b-8cec-42e5-90dd-1b1c67c91823@amd.com>
 <b5f46e35-c3a8-42f1-ba30-b7c43d2bdd89@fujitsu.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <b5f46e35-c3a8-42f1-ba30-b7c43d2bdd89@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 9335d738-76be-43a8-c86b-08dd5dccac71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2hSRmZSVVJuWjJua1h1Yk56L2ErYzU0M0wvaU9lL2dieEtIRU9CL2p3NHpy?=
 =?utf-8?B?QVNBczFZa3gxelgwMmpmQ2RLeVBiN2lCQVNEVDVlZnhqS0tyOVIreFBKcER3?=
 =?utf-8?B?TDhNV2dWdmRvSUVaZ3kzNG9XNGdSdHpoQlZlbWFuaWphMTlXellRZENBcVFl?=
 =?utf-8?B?QXQya3lXZ1dsTklPblIxODFjUy9MSW5GbGhyWk02amVJeVVwb21KeEtxZlBC?=
 =?utf-8?B?OFkveUFJRUdPdllkSmlFU0EvU1NCRkZQMUlYaEh0RURQWTJ6U0l3SGV0L2xt?=
 =?utf-8?B?WUo4bVA0R1hnRmhXYTNUTDQ3VnV2N2ljcUNOWmN4c0RLT20xaE1OMFZ4cjZE?=
 =?utf-8?B?K3lHb3JEYU1sZHNIYmpONCtlWmNiL2dxQlE2SkUwUElHaERhamw3cTFNekRV?=
 =?utf-8?B?dndpNnhXRE1kYWpOeGliR1BCcDdTeld5ZjFveGlVcnFydHBwQUdJdTQrUmZw?=
 =?utf-8?B?RllWYTVabDhqR0daWGl6OTJ4ZktTQzJxYmZEcWppN2ZLM3N0eUNQVzRWSmln?=
 =?utf-8?B?NWRuM2dkOWpXdHhPRnFRWUlzNk5XMnNxZWREaWVHbWNncnN6T2xZMmVPSmxC?=
 =?utf-8?B?MTlvODdrUFVMTHgwcVh3UldjdEI4NXRxY0tLWTJRMW1ZdEdHRW1zZ3UxMS9k?=
 =?utf-8?B?WnFuMVJFTUZmQ2FQNDI2d2FZVS9MT2JEUy9uOWx6bExtMWd4RXM0bnBqQno2?=
 =?utf-8?B?Zk9YL20wNVZDSkh0NjE2WmpwQ0dpQVR4WmczUk10L2NVU1FIQ3JSeGZnNk1k?=
 =?utf-8?B?UkZYM0Ruc2FETWkzTFVBTmJtdC9Ea09VYkJMSTBZRWR5akQ0aytYK3pJVnJV?=
 =?utf-8?B?R0dkNHhlWklCUUVZMGxQdWNEMnkzL090enhibXZid3U5UVM4SE5rbThRZURT?=
 =?utf-8?B?cDhNUmtkQXJvODZXVHJSNGM2YllXTUh3OXNKSGZRMVBNU3dUcEZGbStLdWx1?=
 =?utf-8?B?VkJGcGFUc0VsdVhUV3dCdXB5cFpLN1lkQVNTcVJCQlBKaEkvM0N3Umo5YUpD?=
 =?utf-8?B?Rno2R2hleEovK0t2bWpKaHA5UWI2N3pLaWcxNFBXOXR2RWlqaFRzV1pla1B3?=
 =?utf-8?B?anBuSWFBQ3FWQTFZTEViR042NHhxbXhSRnV5dGdxY1JGM2tGd01SNnBveVYz?=
 =?utf-8?B?bHNUSGdGeUVVbnhTYncyeHQ2bnRkMWZxejFqeVIzbUxiN3RkN1FRczJZcURx?=
 =?utf-8?B?dGVHYnBOK0YwUG1IMXJYWmlUdkVmK214cTU0cGg5c2Uwc3lWZUJjWVkvaFVx?=
 =?utf-8?B?UHlQV3J1QThwYnE5QWxrbEZDRGhFb0ExbGVwRHdtVW02b3puWDcxeTJUM0NQ?=
 =?utf-8?B?cG9NcCtDRUxlTXdsTTRYb2RMNWRCUk9kdzhEZDJtYWNHYmlsUHgwVkxWeHNu?=
 =?utf-8?B?OFdIWmxDaVB2MVBJZngyNW9VaGV5S0Vwd3NDOUpqcHlzMk03M21PTWpwNnVC?=
 =?utf-8?B?OWFKSTlLa2RiVUVHVURscXlqUzI2YzJHMVRHRVdBOVdqZi81WUFqSWRDSnl1?=
 =?utf-8?B?RmdyaFBNWHJNWWYvWElMaXlna2NyMjVNbjFKcVhDS2Vtd2U1dXJaWDYrQXEr?=
 =?utf-8?B?U3phc3I0OTY2WlFyZk04RHJOeGpYUUY0WTNlUHJjVXBrdEFQT3FlZkhHakNB?=
 =?utf-8?B?eEROeVcwWHJpWnZxWHJZR0N3NHZMdzJ3aDExT2wwT1pFeldKYk9WckEvMnpD?=
 =?utf-8?B?NGVxL3AwRjFUSE5MV3BIVGlnelc0ZmtwT0dEaVZ4cldtR3YyMW1mcXZIbXRt?=
 =?utf-8?B?bEsyUWpHN1lFdzY0T3R5bzg5UThJdEhzVUJBZnE1ckN6bS9iWklYMTF3MFFQ?=
 =?utf-8?B?UkFxOTJYTjVjY2c4VTk4bDlndFMvWW5yVUNwOXhjaE1zd3plTjNvTW1tdUxi?=
 =?utf-8?Q?qhJwUe0YvOprj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGkwUzd6MTlQYXlVdTlSeEJ5ckwvOEVhdUh6NDJMUWF5dWpGczU5WEpWM2Mw?=
 =?utf-8?B?WUxhajh1R3VqSXN0cmpGMVo3bTNuVjVLVmNWaGVES0dHcmcvN1ZsLzBjbEZ6?=
 =?utf-8?B?VE1TUHdFVUhDZ2J6emVabUFHZ2xwZm1Pblp4QUc2V1FDdGMwZGN0NWxRNlhF?=
 =?utf-8?B?cW1NV0x3TkVPcDQvSXE0QnZnLzAxSDhLNFRQaHVxZW1UWWcvdmhVWGFNdUxq?=
 =?utf-8?B?UXA3cU5nc0ZmZnJkZWQyRG5FL0lkTUZWbXN2bFEzUHhKZE5HVENNcE5PNHFB?=
 =?utf-8?B?ZTVsRHhwYnBTRnZyYUpQRjhWUWxtN3A5ZnhrdjY5SDErU3lENHdrMHhYejB4?=
 =?utf-8?B?eUtDdklPQ3ppZE13SkVWOGNFUkNHRURoY000eE1uN1o5cnVMU3lUYUxLVjBz?=
 =?utf-8?B?RVpzMUxuOHJiTk9SQlo2M3FBNnVxc3VRQmdpVnJvOTZXMkpTV2FFaW95UmN1?=
 =?utf-8?B?ZmFtMmlMcUdJMmZ6UFYyZUhLSElJRGZVbEEycGhVTzF6a2dmK3JZNys3QXU3?=
 =?utf-8?B?VDVVUHBGclVYV3hiQW50RUdDeHJocXd0clVZR09jWUdad3NCN1pEN3BSVmhE?=
 =?utf-8?B?VlZLa2hhUEdWenRKVGdLWHR2TjhiZzQrTzdUTnFPV2IvV1VZeHpZR1J1TTlE?=
 =?utf-8?B?Z01HOXZTRnl5ckEwdU9udzNQSTN3ZGVSVkZtdGxtTmNaVHVTMlR0V21aWVpn?=
 =?utf-8?B?MXhFUW8xSUJPL2Z1Q0JIdUpYSENHN2t5eFJ0UUh3NFM4cnNZbmRFaG8vQjBt?=
 =?utf-8?B?RytGWkNhc29hVFV5a2FYWklBNitpY0dMTG1DTFNzcVhxSXNNL1JMN3FxSnda?=
 =?utf-8?B?enJHejhmeGNhc1lwNUUzWWg2MlJyQzIwVkZOaWFRc011VkZLSHk4VlErL0Nk?=
 =?utf-8?B?bEt2U0gzTnFwU1MzVlg3UElYT01ra2I1OVdqUDh0TGVTaVhKSWhiKytNWGpQ?=
 =?utf-8?B?NS9LNlprN29vdEpnWmxGckNDb1o1SVVGbGM4UERhMnNIcjl3RnBRcWo1OFQ5?=
 =?utf-8?B?RGpHN0pCSGJINWVKQnVDazVEekpKZWxzc3I5R01McEl4MWV6STJ0QUJXcjg0?=
 =?utf-8?B?dXBFV1pnR1B2V0phUHpYQ3Z5aEhvSWtIQk55cTAvNWsvZllHcWwwS2VDaS8w?=
 =?utf-8?B?MVhLa0M4R2ZodXpyK2U5eG9VKzh5SUZ0M0MrM3BodmVuR3BOYkFod2RmaWZO?=
 =?utf-8?B?bUFJK0JaUnNhMnRSbk5rdVpna0o4Y1VRSVZkcXp1QlU1ZUxjalBsOUlaNFdZ?=
 =?utf-8?B?b0dNa1BpWU9kcFhpOS94bkdWWVlhenJVY1crNGNOK2tEb1dOYXdiclBFT0VS?=
 =?utf-8?B?NTNjWk5NK3BITVVNRkczL1BiZXlUR2dXTjg0ejF4blFRWGNKbklzeTFXVmMr?=
 =?utf-8?B?NlNHQUY5ejJNQUJiMTZiMjN3ZGJ0Z3FhN3JvZk15c1QzU2xJMEQyK3hGdEVP?=
 =?utf-8?B?WDEyeDJkRUZGS280YkxETTBNM0ltdmhiSXlRT016bUY4Vi9vUzJtVCt2R1lC?=
 =?utf-8?B?d01qTlBobHVHRjE0OWZ1RDB2NWRITUFjTHUxV3JFUXJJb2Y4eXFka081SnZ3?=
 =?utf-8?B?SG5LaUsyMUx2Mi94MU12TFJFSmhXQ3MxRlhudnNJVktMNEJnU3dDSWVoN2lX?=
 =?utf-8?B?T1BKWGUvcHhFbmtlcFNlMWtEREJlRjdMc20zT1BSK1o0WDFPeHQ0TnI2aU9s?=
 =?utf-8?B?VGJnMlVKUzl4eStwdEFRR0FqbWNuR0FwQmtKN2JvdWc1aEIwTThRMit1ejl3?=
 =?utf-8?B?LzNET1BvKytRTTQycEExNDhHWG1lRG1mbjBRcHJHUGRVQlpUblBQVU95amh0?=
 =?utf-8?B?WEtURWNKVmF0T0pNRFU2MkFZQUViMExYK1Q5eEd2ODdLWkRkYTFUZjRBRWJC?=
 =?utf-8?B?WmhDaEVUY0tIcGl6VWZ1WjRXNmY5d2hJMWhRQm9jaXFhYmNKem5QTWdsNlcx?=
 =?utf-8?B?M0QzV1dmMzgxb1dscXlHU281NUJ6Wk51VWdDVWp1Q3FtTlFreFRtL0xNbXRQ?=
 =?utf-8?B?NHcyNWpPQmNsNzlRdkFJOVRJNVh5ZjVlM2tqS1lSN0craUVPWGt5VkNDM3VR?=
 =?utf-8?B?NitIaDVCMDZDSnRkV0JKc3ZZMUdFMWt5L1hFbXl0WHNCalB3NVlHTklOdlhx?=
 =?utf-8?Q?e42OT//7bKd1yQ3skxa6VQagV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9335d738-76be-43a8-c86b-08dd5dccac71
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 23:06:20.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKP8GLfvoFEAVoAr03Ltz4XUh2SSEYFw3I/8zOp4vNRXnKIh70CVkwnIX5a4FmCVoVbNOA3/KSRzVJ800OXnxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

On 3/6/2025 11:56 PM, Zhijian Li (Fujitsu) wrote:
> Hello Fontenot,
> 
> I hope this email finds you well.
> 
> Thank you very much for this patch. We've encountered the same issue in our product,
> and your patch works.
> 
> We do hope this issue will be resolved in the upstream kernel soon.
> 
> 
> On 28/01/2025 02:46, Fontenot, Nathan wrote:
>>>>>>> I'm missing a bit of context here.
>>>>>>>
>>>>>>> Why can't we flag these regions in the existing iomem tree, where they can be fixed up (even after boot?)?
>>>>>>>
>>>>>>> Especially, what about deferred driver loading after boot? Why is that not a concern or why can we reliably handle everything "during boot" ?
>>>>>> That's a good question and one I should have addressed.
>>>>>>
>>> Sorry for the late reply.
>>>
>>>>>> The goal is to prevent the dax driver from creating dax devices for soft reserve
>>>>>> resources prior to the soft reserve resources being updated for any intersecting
>>>>>> cxl regions.
>>>>> Not an export. Can you explain a little more here?
>>>>> What is the problem if we only flag the resources as "soft
>>>>> reserved" in the iomem tree without creating a separate tree, and
>>>>> process the "soft reserved" resources only when needed?
>>>> The issue we currently encounter is that the dax driver consumes these soft reserve
>>>> resources and creates dax devices for the soft reserve resources before the cxl driver
>>>> comnpletes device probe and can update the soft reserve resources to remove any
>>>> intersections with cxl regions. We do not want these soft reserves consumed prior
>>>> to them being updated.
>>>>
>>>> If we were to put the soft reserves on the iomem tree we would need to have the
>>>> cxl driver provide a notification that it has completed updates and others (i.e. dax)
>>>> can them go process the soft reserve resources.
>>> Would there be any blocker to that approach?
>>>
>>> Adding them all to the resource tree and flagging them as soft-reserved, to then have a signal that allows DAX to work on these, sounds cleaner to me.
>>>
>> You're correct that this does sound cleaner. I've been thinking about how this could be done
>> and have started working on a version of the patch that takes this approach. If this works
>> I'll make it part of the next version of the patch set.
> 
> 
> I noticed your earlier discussions about designing a new approach to solve this problem,
> which I'm pretty excited about. Do you have any idea when you might post the updated
> version? We'd love to help out with reviewing and testing..
> 
> If you run into any roadblocks and need a hand, just let us know. we'd be delighted to help.
> 
> As far as I know, this issue usually arises on Real CXL machines, but for ease of testing
> and validation, we modified QEMU to simulate the intersection of 'Soft Reserved' and
> the CXL region, which would aid in verification.
> 
> 
> Thanks
> Zhijian

Hi Zhijian,

Nathan asked me to finish the patchset submission in his place. He has the 
v3 iteration ready and I plan to send this for review next week.

Can you share the QEMU changes for simulating the situation? Using QEMU 
would be very helpful.

Thanks for offering to help test and review. 

Regards,
Terry




