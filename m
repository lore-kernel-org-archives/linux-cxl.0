Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226621FF3F
	for <linux-cxl@vger.kernel.org>; Sun,  1 Feb 2026 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769982355; cv=fail; b=WD48MCNyqeJbY3Nyi2DftSFn11JS6guMPMwPd1g9CRsamUfFt5MtNcBRYROImhJtEBV+A0ukb9NKHTub8vcFHh611YGZG2Q+Pn9Rgc7XpO5/mSr4JglATMrPbiJVO3uEt6/BpAdlh1iaHS18/k+Gy/6YQSSOxyzxgMDdm0un0kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769982355; c=relaxed/simple;
	bh=g27DPB3zxKkCMr6chMY3cw5o6jjd3SESLf8gs5w3xRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sq6uj7G8z9T6VzeYIpnRk2RVNzand+30uRGL5Qx8VRxpunWdHrDkYoFA85r+5mQy9FMoh3gGS53fTy3MuePpEAGQy9YrMDXFvpjhZyfB153PQFJlAB8CXXFbHAy7pfjB/218oPjpSyuYZY1M8A/CS9/fim1ZWyHB4BqzGEZzr8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aeQ/Vg+n; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aeQ/Vg+n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwhN2CP/oQ6rgW0qQSxFGSlwIuFzKXE1wAqyzDVVWWJydy5hrUhowEyJJTd1ZzNWnsGo7nhjkBxbn/pIFyY97LAkU6bKM1a6Qh7qPqPR0P0mDW6oM9NBLpgfuRxBga1YnDpeZMOBLOtckYpS4Eksl+45/l/wDeT9wvnzwr6bHfsbvU1QWyGEwwnvv58wsZpfPoJipjLUXht0B7Y5dGz2uQVs/ZNnRp6+C5bx4ogfXjlPBHl6R3YlO4yEYhXzHOhOBIiXJOqiQv5UpZd7AUBTyC5LV02C1yHJDAWnqWcmBcDLWkcRhLcKLiHK55R93c71uRGEQ5lUYiC/2yw6nRjDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2TD0ry4k48Bn9aXfDYf7/CN0FOxaf4gtN9TDEjDhig=;
 b=xPmgcjbM5ojbGFs7b+nwfNxClpz/Q6Sv9v7r+J7o3Bzd9fO7XOsCDhBfBCfhHLaCB+BKSt/vYq1C7lVnB7RCk+weQAL5N5gIz4mfHYp+LKRNGyEBWJB5BGbzbZQLGrU6ibZ9aIaCObTEG2MLlU9WpdvnaHuS9aPPCR1ULl9LdR3YsRikrp74w9Q51ezWNPhfDG9vAijeNLKfDlTts8P0Eg99byogY6OPaLzsnFaA+TPV2LzNqoKcJ7mfgyNYTs/6J8qHPoaxhiRue2/a8tlk1jaf8DwrgxO5WYIrD55jppIbkT3eIZWoSbSkNjPa9ImTfljMLe7JMJI+vzU0DHeB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2TD0ry4k48Bn9aXfDYf7/CN0FOxaf4gtN9TDEjDhig=;
 b=aeQ/Vg+nK5w1BsqcRVTbtdG2eeW1+FGlkROoO7EpJ2E4w/zI/AUbukOOBV3FP+ShLquMYwdLbrwrT9xFvD8tpKRcZP28Rl9Paf99vGyQphQWczlPjLEwydKP2E9M8WM8hnQNAi1hRfUtkGYAgDSWPZDg7RvMtsvT+3pKgBW5N3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 1 Feb
 2026 21:45:49 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9564.016; Sun, 1 Feb 2026
 21:45:49 +0000
Message-ID: <47ae1f76-5e87-4e39-9315-16f86d977a68@amd.com>
Date: Sun, 1 Feb 2026 15:45:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] cxl/port: Unify RAS setup across port types
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, dave.jiang@intel.com
References: <20260131000403.2135324-1-dan.j.williams@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260131000403.2135324-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::19) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 018fe7e5-ef7e-44eb-761d-08de61db43ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGxydHM5Zjg2S21yVGkxM3Q0ZE1sa1Vab20yQTFGSmV2MVlxVlhVRlZaQUxL?=
 =?utf-8?B?R0I5RXN3TFFraWdMd2dBK1luT1FoZGtaRkNuWE1tdWFwMS9kWHU2T3V1YS9G?=
 =?utf-8?B?aTQzbVo0ZjYydCs2c0Y5eHhTNGlmbSt4Z2dMcUFnVktWdTAvdWRQaFBlWGZ4?=
 =?utf-8?B?NXVqV0pjWjE5dzlGenNBc2VpaTEzaWRXUXg3YzNPYXlXUVpaWlBlcE55Q1J4?=
 =?utf-8?B?bWZIZDVTYmFaR0xsN255elNNcVJzNldFTWVmNW1wL0RmUWZSRUpFeGZhdTgr?=
 =?utf-8?B?c0lhNWM0QmUvZlh0bXo4SnMvWldpVTB6SGxFeSs3TDNUclByTC80a3IyL0Fm?=
 =?utf-8?B?MWVpRjZDZnNESHI2aDZ2SE5Sd3piWHBjRUROemkxdktBUDUwOTRiK2RXazNJ?=
 =?utf-8?B?Z1FUUUZhbzNSNFcxd2p3MUtHYjUwL2wxL0cyYTVobkNvaTdaMjRxbnF0OGhI?=
 =?utf-8?B?ZytNdDhLQlNacWFMRmRseTdtN1VIUWRPVG5HU3lWek1RcjJwN2VkK29QZC9P?=
 =?utf-8?B?b1dhYTIrTXZKMHJEOEQvZW1FN29Ub3dDOXlrV0lqY0Z6eGt1K3NqNE5xdDFu?=
 =?utf-8?B?eHZBT0NvV0o2K3dubzBxWjBEMlpDNmk3empGQXg4RFhNWGR4TjBpeHovc29C?=
 =?utf-8?B?K0hrdVdJK0JQdVl0cjFWYkYzUTBHTGtuVWxvb1BvSElHQWRSVU1hRUN3SEFO?=
 =?utf-8?B?NnZLYjhXYkF2ODFpYWEvZmQ1dVZBWnhCZHJVb1hXTzh4elVMUVlKQ1cyMHI0?=
 =?utf-8?B?ditEcGYvMG9FMm9PQlQyNU96VHVwVmZ3dXV4UUZRdE1GMjFqZzBaR3hROXdF?=
 =?utf-8?B?UVdZSUJBZVpuRitndlN6UUgxdXdrYWxWOXpyTTFMSWJEQ28wTHVMT1BmWlNM?=
 =?utf-8?B?Q3N2ck5yY01uYVBQZTdJem1GUythV2gzQSswMVR2cGJ4T1V0cGo0aTVIVjdQ?=
 =?utf-8?B?eHRPMWFheGlOajRQKzhGT2pWdWNIeXp3V3p2cmJvcUR2Uk5QM3ZrNzllYmdI?=
 =?utf-8?B?T0w4OVN0Tnlsb0REV3E0QmJuNlB6V2ZQY0JVOUo4cno4cURsNzdEbUpnRXhi?=
 =?utf-8?B?RXg2K2FhM1BqL280UmZ5d1BSVkhya3Y3bUUyTUFCeXd1dUQ2RVMwTVRIbTJN?=
 =?utf-8?B?ZGNTSlVkbVplc0JpSy9hTjEzdXNyWjc2OTRvN1BHT21CTXFyYzVmYTNEVXgz?=
 =?utf-8?B?ZWJuY0R2TFAzSWVoSWdobWtBTHM3UldzaFJPd0VEeWRqSy9ENSsrMVlGb3JC?=
 =?utf-8?B?V0ZNVlh5L0VMdWlLZ0ZuNkJLTjQyRG1MZ1RRaGsyNVl0cW0weVZuZlhtWkFV?=
 =?utf-8?B?VEJxL1QrYWdNMW9OVUp6RXIySWtkVXZHMFhJcitScGNwdkRrdnV0NFVnNkpu?=
 =?utf-8?B?NWl4RERwa1dJTGM0UjhaMXIwWk13bmwxVHVWbmRyd1F0MG5yKy8vZ25uSDE2?=
 =?utf-8?B?R0xxdmJUejN1M2tTWkQ5OUhWeGs1VDk3NjE5aXl6MmtKb2JIMlU3V3Y1UDFW?=
 =?utf-8?B?VmxyWkF6eERYL05nUThDOHk4Qi9yUkt3YVJsMkJUKzVwZ2g0T3gzWi9ENSsw?=
 =?utf-8?B?RGdnSXQ2N1lLenc4L1ZkYXpySnp6MldGbGd1b2JkcXpoZmZLT3haQ1JSN2NY?=
 =?utf-8?B?Z1RnYjd2MzMxTklUeFEvUmhJbmNzVjc4b3RZVUhKckYyazZBdmttaVkraUN3?=
 =?utf-8?B?THVVT1dXcnowb0h6c2RXOVJ0V1QrU1lsRVRtQzBuTE5GMm1QQXg3TTY2ZXlX?=
 =?utf-8?B?YjlHeEpyODdNZ0QwcTY5VGpYQmRwVllTYnNqK0ZySmh3dk4yTjBiTGI1Tjlv?=
 =?utf-8?B?bklGQ0t5UExERUJiSVVzMFVQdTVzODJqanlyNGNKb3hxRUR0dzk3a3ZiV2NM?=
 =?utf-8?B?S0syY0VjLzZQLzU5dTVpWkcvSTJkcm9OVnJnNUdNM3JTcFBVN0NteW54ZDhR?=
 =?utf-8?B?d0pjK25ZeFJneHpsME5MVmJiUk1xYk5ORmZYeVhRUkdUdFhPTTZ0bC9jNHhJ?=
 =?utf-8?B?ai9ZYW9DRmtQMXdyekt6RUhrV0VsMDdIaldNbTYwRk9YZmkzdUVMT3I5OU1V?=
 =?utf-8?B?by9NYy9vYlB5RTRkbHRTSjkrOVplNWpoVXYwVDQzM1ErVStaU2o1Znk5WVhv?=
 =?utf-8?Q?z4SrvtFbhXyAhN16rpJoKuk1O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1BpRE9xZUFtTkdSektmWnRzbjVmNTJGRVY4bmZPYVZNdEhid3owV3haVVY4?=
 =?utf-8?B?U2cySEdHRXBTeHBYdkhMbTAvcjJWdW1FUUNuZ0NQeWRydU54R01QcUdtQ05J?=
 =?utf-8?B?VVJMVFpXNlZlcVcwdG9SK1BaTG0rRENaNU5VNktZQ25KbGdDWEd6T1dFYS9K?=
 =?utf-8?B?OWt4WmNzZnRoc1VleVc3RjBzYnZaNThEcVdxUGRsS0FXRFNnMHNPSHQ2VFEy?=
 =?utf-8?B?ajBUUGU1dnVLNitvZXhadXdNUWoyQnNEQU1EZTQyVE5qemNMQ1lCcTFvS3VL?=
 =?utf-8?B?NGZyejhpUjJ0c0VRa0t4QzlHZTlibWtDcUQwUDZCemhNbFhZWmJFazljQlhk?=
 =?utf-8?B?ZDRVUEZpVkZ6bVhpbDF2OHZ2eVVkUkQwT1pHTkpVZlM3N2FrSFBNZWlpZjg5?=
 =?utf-8?B?MFdKMnZHYk1pUHpqR0MySzFhbnZPUGhiaFo1Vm91OG1MVElVSWlSRHdYeGFO?=
 =?utf-8?B?cC9xMVZJZlhyRm9xVjQwOFJNNkszcTJZbnlUTVNDeGpESUlBaStjMGNBUlZh?=
 =?utf-8?B?Um1sOHZmODVUci9veno5NlZJcWFTdnd0NTh0MGo3TjJrbHpjeUYveTJraXFV?=
 =?utf-8?B?bFBpZFVsU2M4emwydzUzNEkwb1JDUmJvREtvUjU4M0RrS1lVNlpwWEdsSXEz?=
 =?utf-8?B?b05jMzN4UjJJTUdxYXlZSHlsTi9DUUI0ZEVNM3Y0OEkzc2ZKNVUxR21Oa2F0?=
 =?utf-8?B?UitBSzBPbTQrdE1hbk9VM0lXVDMvc0szeDFyaVBJQ2FFTDNXQWRFWGR3a0VD?=
 =?utf-8?B?bE52ekltaHBoRjJVZnBVRG9jekk4RHRGWGVnYWlZYjlsVHYvc1M1dmVYaHd6?=
 =?utf-8?B?M3lqS3lxYXFZK1JQcFRQMGkvUWxKUlpuZUdvTUlUNHhHczJScE8wVncrZTBO?=
 =?utf-8?B?R1kzaTVUd1U3dnB2Q29OQ1BqWXRBT0NNQ0FkemdWTE80dmg2ODNPSFhTTE9v?=
 =?utf-8?B?MXJjdncwSFl0cDEwTDNVOHZDWTF6VGxnM1VVUndJNkZyZW43R3pTVE5kS1N1?=
 =?utf-8?B?aTU2bFBIaU80Uy9FaHZNekh2dEM0ZXlDVmlNNE1aY09zR2pQK1NwcitRT2I2?=
 =?utf-8?B?VGJjUGQrSlY2QThxRnA4d2FEYWNFbUVrcXQ2Tlg1SllOTzZtK05iWjVlNndK?=
 =?utf-8?B?VjFKSmtVZHplL1grZkwrWlpTSlpHQWk5dUxFRWFjVHcyK0dFWVpLa2tDT3Fn?=
 =?utf-8?B?QXlpU1cvZ0djSFRvMmFRR0wxL292WmZUVVYrSTdxQ0IyUlQ3aUdvT0tXSUtn?=
 =?utf-8?B?ZElXOWhDMWY5Vk9xUXhqMTFDeHYzQjY2ZTJlcm1RVElWaEhaeHQzSnIwQUNW?=
 =?utf-8?B?Wnkrejdzc3dSVVRJU3hLL1ZvbzdjYlYvOFVGdkRIY0xIQ1U2VDIwR2xaSTVm?=
 =?utf-8?B?VkFtMG5QTHlWMzlGTXo5cTZRMGFhN2JIL1FsTnpLdzVOOTRBMXQraG93b2s2?=
 =?utf-8?B?eVdHTTRoOGNqR0NRUmxzcm5GUGxsQVZRQU9TNmIwam52U0ZwZFQyNVgzM2dH?=
 =?utf-8?B?ZmZaV0dzOFFEYWxzS0pIVzNvc2ZrTk92UkFIM3hCSnhZdnZsQ3VxVEhIRWRW?=
 =?utf-8?B?RGllNGlZVG5QSURqTG16RnpyWGhwaHdKR1FxSkhBcFZNZElhTHJGOHA4ZmIx?=
 =?utf-8?B?TUhRVW04R0hpTmM2OGg2RGRWWE5vVU1QUDVXS2JRR3ppTk1GbmdhdjQ0OWs2?=
 =?utf-8?B?akJjdkFBdUFsOVpnRFNUVUc5UkNoTHRobkpCNWErd1JLV1RzUk9ISTVGVEIx?=
 =?utf-8?B?bW05SnprdDFvUG53cmFyK2pLZEFORGZBWlArVG0xV20ram1sUVc2cW1pSVBP?=
 =?utf-8?B?eExxUlZzb01GRTZXSFRJV1MwWWsxMWZQVEVXVkFWR3o3bGdVVnhEMW4vQ0pt?=
 =?utf-8?B?YUxjM2p0VjA2YlFxOVBXV3Z1T3ZOZVljNmM3eXl3TVI5cUdpaGJoVTlqdjJL?=
 =?utf-8?B?U1lUNTBXaTliVkMzT2E5K2hYcE83aE1XeUIreVhnUzJtUUdGUGRqTC9aa0xh?=
 =?utf-8?B?dTAzenJzMVg3SGZZUnZvVTdlTHZ5YnAxeXkramg3OEdRV3loeFlEWnJIUGFM?=
 =?utf-8?B?ZC9Kb01GMG52eDlSdlZWSlhZM0h3M3RMeUYwZHBNRkxqczZycU1KQXZBR1pJ?=
 =?utf-8?B?dWhKbW9kVTNTYVV3M0VXYk9XaDFUaFBTUG1FWWlsS0t5V2liS04wMCswRm5i?=
 =?utf-8?B?UW5HYW9NNWZ1UVRPSGNEbWJNWU5nbUpIZnJlMjJ5bUgvYkI4QThHUHZaaE5Y?=
 =?utf-8?B?U0N4eVJBTnlPUXcxblJnVUw1aC9DcEhEUWVSOWswSEgwOTkyTjloUzhkNksr?=
 =?utf-8?B?bW5WVWo3TzVqMHY2WlVRdzVuWUZoUTBQQTRyYVZnMVBiaUozNHRVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018fe7e5-ef7e-44eb-761d-08de61db43ce
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 21:45:49.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/AHskoM0baRqJaG+w4dVzXOMURu7KznAC/u4VSOqEfOcCMhQib+bHleS3K3CidYyUxaphVi2v3yLbA89N3cxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787

On 1/30/2026 6:03 PM, Dan Williams wrote:
> Changes since v1 [1]:
> - Cleanup the diff by keeping the order of dport_exists() relative to
>   the dev->driver check in cxl_port_add_dport() (Jonathan)
> - Drop some repetitive de-referencing with a local @port variable in
>   dport_to_host() (Jonathan)
> - s/group/dr_group/ throughout to clarify "devres group" (Jonathan)
> - Reuse del_dport() for cxl_dport_release_dr_group() (Jonathan)
> - Drop the thin wrappers for devres_{open,close}_group() for the port
>   group.
> - Add a comment and a cleanup TODO for the 'add_dport()' operation in
>   'struct cxl_driver'. (Jonathan)
> - Change patch 7 subject to just: "cxl/port: Map Port RAS registers"
>   since it is only introducing a helper that is later used in the
>   endpoint case. (Jonathan)
> 
> [1]: http://lore.kernel.org/20260122033330.1622168-1-dan.j.williams@intel.com
> 
> Original cover letter:
> 
> ---
> 
> The CXL Port Protocol error handling series grew to be over 30 patches
> which is too much to handle at once given the various topics involved.
> One of the sub-threads of the v14 review was confusion about the new
> devres groups to manage port setup unwind failures [2].
> 
> [2]: http://lore.kernel.org/20260115144605.00000666@huawei.com
> 
> Given that review indicated a need to break up and better explain the
> conversion, do that in a separate patch set. Build on top of the first
> 18 patches of that series [3] that are ready to merge.
> 
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.0/cxl-aer-prep
> 
> The wider goals of the port protocol handling series are:
> 
> 1/ Be minimally invasive to the ongoing maintenance burden of PCIe error
>    handling. Just do the minimal enlightenment to forward "internal"
>    errors for device with active CXL links to the CXL core.
> 
> 2/ Build a framework for any driver that registers a 'struct cxl_memdev'
>    (or in the future a 'struct cxl_cachedev') gets protocol error
>    handling support.
> 
> This "Unify RAS setup across port types" set supports goal 2/. It
> enables a model where all CXL error handling is relative to the common
> 'struct cxl_port' and 'struct cxl_dport' objects and is agnostic to
> whether those objects are in support of the memory expansion class
> device (driven by cxl_pci) or any other CXL endpoint in the system that
> supports CXL.cachemem operation.
> 
> In support of that unification, the setup of RAS registers needs to be
> centralized. That in turn requires new handling for early exit setup
> failures and additional teardown support for resources optionally
> acquired at port / dport creation time.
> 
> The devres group mechanism is deployed to cleanup some open coded
> devm_release_action() calls. The devres group facility also comes in
> handy for unwinding conditional setup steps in the port creation
> process. Recall that ports defer probing their CXL resources until after
> they are known to have a downstream CXL connection. So, early exit during
> setup of a new dport may have more or less work to do depending on
> whether the first or subsequent dport is being added.
> 
> Given probing port resources is a 'probe' action it fits more naturally
> as a driver operation. If cxl_port_add_dport() then moves to cxl_port
> driver operation alongside ->probe(), it enables a cxl_test cleanup. The
> cxl_test approach has a hard time mocking interfaces that are internal
> to the cxl_core.
> 
> The rest of the patches in this set finish off the conversion of 'struct
> cxl_port' and 'struct cxl_dport' to be the only CXL objects that
> interact with the CXL RAS.
> 
> Dan Williams (8):
>   cxl/port: Cleanup handling of the nr_dports 0 -> 1 transition
>   cxl/port: Reduce number of @dport variables in cxl_port_add_dport()
>   cxl/port: Cleanup dport removal with a devres group
>   cxl/port: Move decoder setup before dport creation
>   cxl/port: Move dport probe operations to a driver event
>   cxl/port: Move dport RAS setup to dport add time
>   cxl/port: Move endpoint component register management to cxl_port
>   cxl/port: Unify endpoint and switch port lookup
> 
> Terry Bowman (1):
>   cxl/port: Map Port RAS registers
> 
>  drivers/cxl/core/core.h              |  10 ++
>  drivers/cxl/cxl.h                    |  33 +++---
>  drivers/cxl/cxlmem.h                 |   4 +-
>  drivers/cxl/cxlpci.h                 |  12 +-
>  tools/testing/cxl/exports.h          |  13 ---
>  drivers/cxl/core/hdm.c               |   6 +-
>  drivers/cxl/core/pci.c               |   8 +-
>  drivers/cxl/core/port.c              | 159 +++++++++++++++++----------
>  drivers/cxl/core/ras.c               |  50 ++++++---
>  drivers/cxl/mem.c                    |   2 -
>  drivers/cxl/pci.c                    |  63 +----------
>  drivers/cxl/port.c                   | 122 ++++++++++++++++++++
>  tools/testing/cxl/cxl_core_exports.c |  22 ----
>  tools/testing/cxl/test/mock.c        |  36 ++----
>  tools/testing/cxl/Kbuild             |   3 +-
>  15 files changed, 310 insertions(+), 233 deletions(-)
>  delete mode 100644 tools/testing/cxl/exports.h
> 
> 
> base-commit: 9a8920ca8ebfb99604f639e7fbc681d0d04518a0


Hi Dan,

I rebased my CXL port error handling series onto your series and completed testing with
no issues.

I tested using a single‑switch topology consisting of one root port (RP), one upstream 
port (USP), four downstream ports (DSPs), and four endpoints (EPs). Testing followed 
the error‑handling series test procedure. I injected AER errors using the aer_inject 
tool and simulated RAS error presence with a debug patch.

All CXL devices were correctly discovered and populated in the topology. Protocol error 
tests passed on each CXL device, and I did not observe any regressions.

Please feel free to include my tested sign‑off:
Tested-by: Terry Bowman <terry.bowman@amd.com>

-Terry
