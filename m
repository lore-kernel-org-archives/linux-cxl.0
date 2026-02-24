Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644923AA1AD
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951091; cv=fail; b=QjjD8s0VrFS7wmjDSu+4YqR6SFLSWfClWb20Kw7itAc9ADmjY01VYVlhkXdNl4WKUe0rTcvwzD384T9mjFvwsGVDBt/EwGBaOxVlu6XBrVRb7y81JlOo4F4EhYQU0IrpLXlYCJ2Xv6v0DoQocHwkFc4eaRKeD7wyv2C3aF3WtVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951091; c=relaxed/simple;
	bh=xlNStAeSJk5voXFiRmoL3BK1VsnqoXLWSwiJ/VuGLhQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IerbOImXIiPVAhUI77GcngBBaBOk82ykc8hkefW5R7IvcgYigonOwIurXzrD/+Flb68gKSuqsKCs+hAZhERtKmWPeaGUzP0JUK83VvQ9b9Cg3yVTENUN67M5FQX3C7HP8+CNuMFEYJv+rEFtLrZVolWkr+0eGqNRLzGCRT1r8Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v68q1vBd; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v68q1vBd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STtdsEhiS4KWDPUR8q8uTSZi7oHVOevPQB09Bp/q/DQtc6V08l8WVW9NnWE7FH0nSLNLKHbqaIAeFLk8c5cOXoEYptXEcGefyF4dziNDOWn0R3JskfeTKD6d2e/clkBTi7/8ErZC9ApOFdMryKJpWo31llbssaxUXIubxE6g3UnWEgzLgixpO4qga889a3bi5ue9RP2IgbDNDprbPZwDLSoQGi8cDcpDKb3G/cJr9UKEe0ItADxy1fc3FsO2aY4pvgjVFv2J41vffDaILCaXTeFRwje5jnvrLUvuu+d8lJj8UKR/G/37HZAdvjgghMiCrqEQ6qpzACNkvBCQWbC8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFaun0x8c4KQxaJU+23s/zKp83OMGvB0HFUJY8GfIqw=;
 b=eCGfVxyHPbpE4b40S2Bf7Gbodfj7vz1SO3QrIFdWb9rzuJSQhiVwiRL6njzESel5meGx0mjzXVD2edjUd1xzOVabVcd3qDqDwsMqnSkTJLSkSxJVSNo9+hdOMnZ3+hIWNtqmrPhw65sqVedy0Dyhwj0vY5tbVRS7uA76U/KtxTD/S9xS70OyyQXzFDGnzeNszBjwShSJs3pj41RqJOSSGVu4Gy1+n1G1knqCgLBFSSusb2tPcoyzwKbf9iSrCNZqBnDcjuvjGoH1vxayIhINw4brxGlL5thKG2JJrcjP6anxwzFggHsdZxHd0JSj3Rw2SApglU9HDpLef9EzlagTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFaun0x8c4KQxaJU+23s/zKp83OMGvB0HFUJY8GfIqw=;
 b=v68q1vBd+uL6lqTxldB35LuTdqz3T7HEdQLuBa8plTX1Sq2wxlfrBeeegtYWOcEQxyauBB4lj1WzI700OZVqvWjR4qEORp0Ypd2/Pgl0J3Up/MfLBIBXZVuGgYAuUHDJ7w8EAidHee/Bupj+4qY1CB5vMT8NOEBXAInvyqorVUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Tue, 24 Feb 2026 16:38:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:38:06 +0000
Message-ID: <20d72717-23a2-4996-8abb-4d886147e3f4@amd.com>
Date: Tue, 24 Feb 2026 16:38:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cxl: export internal structs for external Type2
 drivers
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
 <20260223142633.2994082-3-alejandro.lucero-palau@amd.com>
 <aZ0R79N952TTsRcl@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aZ0R79N952TTsRcl@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0440.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 249211ee-8722-4ffc-ddb2-08de73c31666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFVXNC9jRnlpTDJ4ckRndUJBdEZNQjFNRTlWUisxQVg4UWhBc3E2bDk2KzFt?=
 =?utf-8?B?ZjAvNHJNaTZ2YTNBcnNDQWZIN2JTeGg3eFE1KzhUMWYya2I4dFdmYklBb1VF?=
 =?utf-8?B?T2ZWVUVWakRWeVFMMDJEUERyRExMeEhqdlNnaTBQcFRpS1dIYmtkZXF0dll2?=
 =?utf-8?B?NnZJejJ4RjRSNm5CMVkvYXYzZnVmWWdxUWhkNUhRcTdPU1p0bVJEWG1NOXN1?=
 =?utf-8?B?dnRkRDNYckhmeXd0a01udWQ5SWhsc3V5aE1wNjVGcGRoaCtMZ0hWRktmdFRV?=
 =?utf-8?B?ZzhGT3kycWEwbmpjVFVQNDA5eWRaUzB5cnBMNEpWRVg1VFRISlJydldYY1Z2?=
 =?utf-8?B?bVd2SThOOFVTYzhtYXgxeEtjeVFtRXJMM05qNjNITzR3T2NsNktWcGU4OC92?=
 =?utf-8?B?bmNmRHJHR2pGeFJaS3NGZWJ0MmVVY0tpRUlQMG9NUVVRTkoxZXZvUWpmaFY5?=
 =?utf-8?B?VGZ3Z1pxeFVUMVBGOW5hbHZkNEVUc0NMMUd6QmQvU2VqZng0Kzk1VXBnK1hQ?=
 =?utf-8?B?bUYxbkpyRmFncU04M0U0ekdMc0l4Z3cxWXhVR3MySm80bTlYbFE0TFlCTTMz?=
 =?utf-8?B?ZzNhZUZySFpaU2lGRHNxdlpreGtDLzNRVTQ0NmhXbEdpOWtUZjBnRHUyZGx2?=
 =?utf-8?B?TjF4SVN1SnM3OVRLUGhHYTZ1R3Q5K2lsd0d3NGFlYmE5c2xZV2R5WHlqajdG?=
 =?utf-8?B?SmZWZTNSa2NsMXZIVzR0MnVObFZub2pUQmNvL3Z0SitsbllBMGVmbkdaaEgz?=
 =?utf-8?B?NXVTWTh6MDdlU2gvR3F4SUJxVXU3RE5LWXoyMWxlbzdFaVYyc1pvV0lhdkpk?=
 =?utf-8?B?Zkh5eHZia1hVVTFqQWpBamJpckp6dGxpbmdxTTlHaGZINVphNGpjV1NWK21z?=
 =?utf-8?B?Q0RhclhIdmVGRXBMS0RQTGRTcWNJcVFIdndXWThmVWRKYkpQQWsrOEdycjdV?=
 =?utf-8?B?Rk5hTXhBOTFoNW9XcTZhWU1UcG5mT0ZBSGRDN3I5anRIeXd3Z2I1Z29mak1J?=
 =?utf-8?B?RXluZzRBaWlPUlRtdGg5b0t3SGFobkNWNFNqKzJNbkVUNDR2OUwzRDdaZWhM?=
 =?utf-8?B?VlM4amJiR1ZpRUdwellWT3BVdVloS05xbWVZL05Zd2xqRDh1YmZTalc2dHpR?=
 =?utf-8?B?QTdMM0RHRnJKeXF2V2NYcEtid1EvMzdvZklLdkRQTi9sSTVnRk1MQ2RkU1N5?=
 =?utf-8?B?OTFmWjh0OGJXUWdWVzdoRWQ3NUdwUVY3dWZ2Si9qdUMycGVUeXlXYUI0YWpO?=
 =?utf-8?B?UVgwRjB0VXJ4NDV3MDRSRmcvZklOcnhvbExYUzZxMXNuMkozS0RLOFJkU0JD?=
 =?utf-8?B?MlQxbGg2VDZzMnBsaXpVYlM2Tkx4djNpMzRTeTQ5NFhMS09ORjRUaDJ6UFkv?=
 =?utf-8?B?Qm9OUnpmcVNZSTEvazYwMXo0TmttQVJtbXo1dnV5dStFeE5TYWhWZlp3K1h1?=
 =?utf-8?B?ckZjOE5wNHNsdTZENDNxRE96bGNwM3NKcEpmOE8yREd0d2JFWU4zcmhIWEp4?=
 =?utf-8?B?SW9KZDdsMFlvVlA1ejZnOGphY25XRWIvazhxQWdJclJzbVBvN3VqQnBLWTBz?=
 =?utf-8?B?RWNSbUgra1oyTGJuWDdiTUdvcXZkbE9zczJQamIzR0U1TCtaNmxJTDBJT1lo?=
 =?utf-8?B?WHQ5S0huNm1hamU2V3BDdXorTVNzSXBIWis5MktEb2c4dEVGYlVMOWZ1ZGtC?=
 =?utf-8?B?MkZyQnhkTkdKd3EzNnpUR283QW9MYkJvREgrTjRBQ0JCcHl1M0tmN2xlczY3?=
 =?utf-8?B?emdONVRLM2EzcG84azNWS3hhYnRkSjBCVUNhbmwzMDREdjJkd3lZTnd1SzY2?=
 =?utf-8?B?QnFEOGpmaWtZNWt1ZktpV2MxSy9KT2ZnejBiN29SUFdWQmNsUUJ4b1pGTGhp?=
 =?utf-8?B?MHdEd3UwcVNBUTJrUlp3K01Ob3NGaHZwRUQ4UVA2OG4zcnkwcm5UMytrb1lE?=
 =?utf-8?B?OGtOb2haekMxbVRsbE1GVVdWbjAxbkV3TDV4VHR0a2hlRk16QnhHM2wrbEY4?=
 =?utf-8?B?Z2o0cmp5NE1xV3VlY0pLZUhPTG5BYUcreHdMOG1SMjluTmV5SnNiTGg4eHJl?=
 =?utf-8?B?d2ZSNCsxeFQvdHpuaUZPVzZuLy9DRy96UUdzR3dnSE1QMlpucTdVWlZoZjVN?=
 =?utf-8?Q?bsFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGF1cGdPUEgxdXNmcml6eHlrL1FzbG0zTWh6Z2dkRkVXR0RKdGFab3VNWUhJ?=
 =?utf-8?B?eE94TGJGU3dJakRxZHRSSHMrQ3ZUR2hYazJoRGhObm1nNU5PTTgxbGFLcy96?=
 =?utf-8?B?Z1cxTmUzbk0wVGwzamJDcGF0aUtyVjZMMEtwN1RMMjJyZHVxMnFwd3hYeVpN?=
 =?utf-8?B?RU9JbHRjSlhLRWxsNmM2b0NxZE11SzZoNzIzbDNnMXNPR2ZIWDliclRIbzB1?=
 =?utf-8?B?NGNrOXZYaHU4c2hjazhjRmpGaGN2YWZTWGNuWTZaaXcycEVTL2RTcnR4Qlh3?=
 =?utf-8?B?VWlldUoyN3ExNndlYTd2ZW5tZGFWc04rYUgvVVNTZTQ4NDBpVFVKT0NFWGxs?=
 =?utf-8?B?RnIrbjBVQWk3YkVCT2o5SWZUblFFZ3B2dWtWUXdCb0VCYmZHRGQ4YUtxczVk?=
 =?utf-8?B?TmpBSS90SXV0QmhrZldaMDFCSmZhMyt6OGhpK1ZzMzg4UURkZTNaUmxWOUdJ?=
 =?utf-8?B?SzhqMHJFNlAvazRuYnRqQ0JoWHF3dnNOV0RkTXJaUnAvOXdpRWZERisyY01S?=
 =?utf-8?B?UmNqcVptZWhWeFpDMm9oa01LTkJKVnhQWFkvODlxK1E0MzBCcnBJTnJrTVZS?=
 =?utf-8?B?cXBBTzZpc0xqdWoyYlA4TUNUZ1p1ekpCT2FFQnVYNHBKK0FtWG1xWHhQSk1V?=
 =?utf-8?B?L2E0WXNVY1ZPajBMMzBSRUtqcGZrdG1ySEpZM2lsd1ZiWlNTL2E2RkpFaXpn?=
 =?utf-8?B?bW84U2R5NSs2ejR4SVZTd1dHRFFkanN5aUZWTWN3VUJXTGthMndmdWwvT09y?=
 =?utf-8?B?YkxNb3VqN2lkQlVYVmxoNEUxWTA4R0NYY3VCK1JXckZSTjNsSGRmYmpMdFlE?=
 =?utf-8?B?VmV6TVdZREx3czg0c1lKUnBOUHREL1dvZzBPMFlsUVZ6QXQ0WlZUSmNKMFFj?=
 =?utf-8?B?VndRUG54MHFVYi9NblBNSk9MVXdROWE2S0RkT2RsSk9sZUo3YVJZNFZIR2tJ?=
 =?utf-8?B?RFVveUg1c1pNTFpBSlBWYlB4MGxNMjQ1ekJFOSt6U283UjFVUXRGSklIQ1lo?=
 =?utf-8?B?NG4zSU4vYW5RdjJ2MTEzSkljNU1NT2QrTHRBU25TSTBXZ2J2K2RTTDlGbUxo?=
 =?utf-8?B?b1NsaFpobXZNNkZ3SmN0SitUa3NZOFR4dlRvTXVxNjMyajlMM2xlbGZCRElt?=
 =?utf-8?B?V0JEdnpWa25DemFiVUF5eXd5YzFEZDJHcXZlcDJzcThpSnZsTWhxekh5cUpm?=
 =?utf-8?B?WWwwMFJPUHhLaFpLaEtLb3dYWnZmYzNvSHp6Z1VKS01BdjZTeGJLK0VBTVI4?=
 =?utf-8?B?eDN1eEpUN1dTSUx5M2FpSW1PUUtSZTNmU1R0Nmd3STEyTGN3NERYdURjYUd0?=
 =?utf-8?B?eG9sZEhFOVREVC9BRVZDWVhmNXJCNkc1Y0VySWc1aFFMS1ZlT0JTdDc1OGJH?=
 =?utf-8?B?VGJpRHJXWjJEdDNFODM1YzMySHJSZUZ5c2N5RzZ4OEtJRzA1UnVWSEFzR2kx?=
 =?utf-8?B?V29rRkZsOTNqdFo0N09KSFVYRFZ5SjRPUzZULzdxMHFQSVNoU2Z5by9kVVZW?=
 =?utf-8?B?NkdqSG42UGhBUHVzK2xQS0swZldtbG1VcGVyUU5uN20yZENvQ08reDFzRFhO?=
 =?utf-8?B?anFsS2NzSkVtV2xPRk4vNE9EQlp6WFdmRmd5UzVkZ3l0SU5hcHpuSUxENnIy?=
 =?utf-8?B?dHRXNFpiVXV5TzA5aGhJdE9BQWJ5YzJFWFd4S09CZ256NEdpQTY2K0JhWWZs?=
 =?utf-8?B?bTZSTWJjS0twUGs0K2RsWTF2ZzVyVm5EeElRSW5pY2QyZldYRFQwR011ektL?=
 =?utf-8?B?ZzVWUXhLUldYRzJXL2srS1RGTjZFUXFsaVhHRlRNYjdvQVBSc2F2a1A2ektV?=
 =?utf-8?B?bzV2TmkxK0dIMXZ6ZWlaSCtqRTdySk9tS1NzdjlORkQxbmcydDBoWEszMXV0?=
 =?utf-8?B?dVRqOWVFdlB4VjlDNklHcmlEZlltYmNRYWVpWWJmdC9sSlB0VlE3MmkwQlJO?=
 =?utf-8?B?eHRvTFVCTDBGNjNVcjhnVDB2SVY5NmRFWmRGS0R5R2p2a045VWo3anRxV0FO?=
 =?utf-8?B?Nmp3Ymh5SkpJS2d5UTRNMUhsNlhkY29aUEp2akVtcDNtODdjeElyV01PcWt6?=
 =?utf-8?B?OVAyS1A0cUhraVU0c09IWFl0b0pDQVlVNzBMQy9pbHBJaVAvekhvRnpiMjYx?=
 =?utf-8?B?ZFhrVmVJL08xYTcxSnZ0NWU4THc3ZDZxRkU3cW5QdzJPd3J0NnIzcUJWSlgx?=
 =?utf-8?B?TmR6OU5TN2ZmWVlJYWNIK2hSQXYyZ2h1ODl4cFVEWlU5RHRoWEIyWVZnUHhC?=
 =?utf-8?B?Qk9hcm9TWlZvck9Ca1Y2U0p6NnRKRW9SQVl6TGRqMktHRDF4SnBKTnBOSyt0?=
 =?utf-8?B?cTE2NzI5ZEM1WThpbENKOVE3TWhBRDBXUXVmK2RyaytoTTBIWG83QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249211ee-8722-4ffc-ddb2-08de73c31666
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:38:06.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uWbOoo1nyCBXkvC46A97TiBpzguRqIRaiSYBIK+kXmI82kzYv+F+DHp8+toyHCy54b8X4c0L9ihUagMigFG9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741


On 2/24/26 02:50, Alison Schofield wrote:
> On Mon, Feb 23, 2026 at 02:26:32PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for type2 support, move structs and functions needed by
>> external type2 drivers. Differentiate between public and private data to
>> be preserved by type2 drivers.
> I would have enjoyed a mention in the commit log of what was needed.
> When I saw struct cxl_dpa_perf, struct cxl_dpa_partition,
> CXL_NR_PARTITIONS_MAX, enum cxl_partition_mode, it wasn't so clear
> why those were needed (as opposed to the cxl_dev_state defines)


Well, this is what Type2 drivers support will end up needing once all 
the functionality is added. So we know it because the type2 full 
patchset and the idea here is to put all that in the new file visible to 
external drivers. I know the standard is to see how the changes are used 
by a client, but if I do so I will be adding all the type2 patchset ... 
So in this case, the cxl core code will use another header which will be 
visible to non cxl core, and the commit says it ... although maybe some 
rephrasing could help like:


"In preparation for type2 support, move structs and functions needed by

external type2 drivers. Differentiate between public and private data to

be preserved by type2 drivers. Refer the new file by those cxl core files

needing the moved definitions."

Would this be better or too much twisted?

>
> I was a bit concerned that new cxl/cxl.h had dependencies, so tested
> that it compiled all be itself in a completely separate module.
>
> Tested-by: Alison Schofield <alison.schofield@intel.com>


Thank you!

