Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352C1E833C;
	Fri, 28 Mar 2025 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743159134; cv=fail; b=GFSM/e4rk0Od1ctps3jIPXBEJosrvc1ajP/Gf0mAZ2UUZukRpYDHFUn1Gtfb/k0T6vQZnNLIwJfvTm+1lLEa6EL32tQM9yHezUPmBw239aSUtAgMsOJU9g4aBQs1L0ZPCF7lea1B4Ew5Cqg+DF14nUU3fqIUoEwSEMAGbhBtV4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743159134; c=relaxed/simple;
	bh=yqTyTVX8Eg4yTltwArmDStthTQddMOUcT0ltbDB1XeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PaCDaR+q9Jx4JL+ytb3xyyWyUf17Ih9GD/Bm64VVQwSVQUtedUvwPEnu8qKJy7x7MI6T+HCa/sGZ8GqGpPoPYjCmSJA287HYBd4xrrfrtMkqkJsGE8zeyrn3tdfAi7uCVZj49+1Am3TPbHbXWLu9zJ9ECQoG6F+89GnWz6I0L50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WOs78xQ/; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WOs78xQ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTA0zwXLHIu2kJXok84c0HDY9uuT6qkDHDi6i2V2+ZlnhuzqIBs54t1gVXkxmyf5EVaTmC8SkgkOy6ixgnlKNMeAGVWM+1AG5OO9Zg++2sbgw9x3Z3zZ37hT3hoYQIDg/+6BSr+Bey84TmSglzYmXl9wM0L8QPTotcCXlsbolP0b1SeI2q8wIe8XnUJ5ErwJYbSb5oQPTiDwFLGTNGo1o2VKBbz2TJOIzIIumdpeVsuq05LdcrGcupNmj/9bmmCaI4mvHNqCU4ukPtxsan7Fa02arqm1YHROc0NBWFJjlhXggIQ4IDDIXPdNxRfAXBMdl2hoscHsLlGeD6ZcsdBPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZneJAkxnZmp9ZLaGchnJlN7k7rHNF0rSofPrHiaNId0=;
 b=gG1FI03A4TuXwydHYv6GXG9KVZMtp7zWKTTrOeXcUmukXi/5OWTfd9KQY75eZHDtoejc8P1TZK7DGrcUfpA/COhu4cpo0Mmz58IhAMHfEhRx2jkTDcmRFnVGR1n0oP5Vb3lYsHmkHBeVbsIqMOmnyDrJj63JXrcdP0qurJAGH44NrEaYmwRncXSnNQgsuKsqX5mf/AfMTJY4ijJpQXoFAmYlSB9WHLYqpi5LwbYNXvuTbhInvYJLLChhu5Adej4G6OBp3ZouV1C4MQomMj/54qQaDB975H06iaibLz8FmXLNXmQeZIYh0au5eC3QvB+LQ6v/Sc8+9X0v+x1Br0PFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZneJAkxnZmp9ZLaGchnJlN7k7rHNF0rSofPrHiaNId0=;
 b=WOs78xQ/762XkjSIEg6r986RaUJw8HLbD9iVihV9EAkB1C4WyAByk9l0emv4aGjFKa7o3dvMHhrsxPUe8Bwa7XjsrJo2gmQWrj95970j6RZiq0p+vxhV3ZMqfXQnrtvzaiGY7v+h7v/j0mgR+HpEgerRi5vC3CdAwqfQ+8FAksI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB9497.namprd12.prod.outlook.com (2603:10b6:208:593::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 10:52:09 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 10:52:09 +0000
Date: Fri, 28 Mar 2025 11:52:03 +0100
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/4 v3] cxl/test: Simulate an x86 Low Memory Hole for
 tests
Message-ID: <Z-Z_U7rBJFKeB33A@rric.localdomain>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-5-fabio.m.de.francesco@linux.intel.com>
 <Z91CgQjzXzKWNXPX@rric.localdomain>
 <7393617.eO5KgaWL5Y@fdefranc-mobl3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7393617.eO5KgaWL5Y@fdefranc-mobl3>
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d988dce-5085-4cf2-8d97-08dd6de69662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2xpMjlqWFZIeHBjdmxkMTJCd3NwZkFYN3FXTGdFSU9sTWQ5Z2FuQi9hUGVS?=
 =?utf-8?B?OE94QURaYUc0cE8xcys5aVVhYnBYQTNWdWxPeWI0UnUrMnhxSzlCN3ZhMi81?=
 =?utf-8?B?cG1xWk1WMzcyb3U4YUJDZmpXa0ZFSENEbnVOdGdHanpGUGM1eThiU09hZ001?=
 =?utf-8?B?R3pnVmo3VmFSRG14Q2V3YmxDTlVFeVpPQ0FBSmhlNHBmL3hPd3lBcVhTQUc2?=
 =?utf-8?B?UzhBR2FrRU9RWndqNUduS200VG0vbExTdXlvVCszSGJGNUlYaEpCcmJ6RCsw?=
 =?utf-8?B?RnVSNmtqNmZmaUdHayt6amo0Z3JkcDRQUEQzRXdRL3gwbnpLald1QUdyQ0s0?=
 =?utf-8?B?Sm52SlZnTU83ajZzZmJ2QzI2MkViU3l1NHpRNmlFTWtIRFVYOFBPSi8rdDc4?=
 =?utf-8?B?SUlDSms1OFV6cEgyMHpQWkIxOTRZZURsTitRK2xlcVpLYVhMREJ0WXRidVRQ?=
 =?utf-8?B?WUJjWVFicGE1b2V4RE1wdDlScjZZajNnVnJxQkphRkpkRkZkSWJVSFR0czdn?=
 =?utf-8?B?RzhQYzdiV2gxV3g5YmlkeXdEZ3Z6MXBQVCtNWnM4cThlTzZ4M091c2FhbFdX?=
 =?utf-8?B?TjBOYjlOcVZXaUp5dDE4UUNNdTVtKzl2SlB4eDFZMkY2WWtSNVEwN1Y1T1pn?=
 =?utf-8?B?d25ZWFRCNUJhbXcyQkNuRzc4RVgxUjBJRFEwM05KUG9uUS9wUUZNYjN4RUlu?=
 =?utf-8?B?SmRtTWE1bE0wWGxMZ0lKUElaeUlWdlhMb3N0MzBGYTcrMVhQMHk2QW1MQjZu?=
 =?utf-8?B?T3N4SEhadHhmMm10MUIxTC9NazFJaS9aMVp3V2RhcFZydkV2OEJ4bkh1VlhP?=
 =?utf-8?B?RHJiMVVzYk9MRG9pZkhDVU9rNEJGalFjbUxVczJNcjQ1THBIeURIODZOMTNm?=
 =?utf-8?B?Z0VRcGIzK0NVZW1WME95NWhoWmRRM2FkeWdtL2w5blJRMWxwdTBSbE9mc1BJ?=
 =?utf-8?B?cWRXRm9abWVYdnhJV3YxN0JoMUZPZFNWcTNvOGFoZGhqUTd0UW1LaDZ3cVF6?=
 =?utf-8?B?VHB3b3VPVUg1R0dIaGhRdmFITS8xeGxiT01pRUxRN0wyQXRuY01iR05PZ3NJ?=
 =?utf-8?B?QW1HSzR2dlBPc0FtNytNaXBuK1had0JZVnZNTUc4dWpFUmpjVU9INXJ4WTQ4?=
 =?utf-8?B?czBPVlhadGxWZmxhWlh6ZlZDbEJhUkIvL3ptOHlGL2xIQjFDNU5SNWlWQjh2?=
 =?utf-8?B?RFhvWU5wUzM1dHUzVHRyMXNLSHpMb2ozWitVT3luR21INUQzV2ZHR3VXWTU3?=
 =?utf-8?B?YkM2MGhKOWhHY1htY2UxSFZxczloQzNBUUhSTzJjdWM2S29NaWMwUGdjUUZV?=
 =?utf-8?B?L2M5SVZIdlNyM1NDa3BQNkI4T0NqZTdRaFlBaTM0UUVOc1pSNjVmcEJVY0hB?=
 =?utf-8?B?ZFdqQVc1dUdZWWpPYStQSEVBMFdQWXQyWHdHczdtWW9HbWZkOWQzdFROZjRs?=
 =?utf-8?B?dHF1Mk9vUzlWS2E5QlJvY1RKZ1R0MS84UmNYc2R6SUppeWdTSFNzRi9nZWxZ?=
 =?utf-8?B?OHZJRlpoTFQ5MHpNNXltT0U3bTVRVGJES1ZRZ3kxL3dzZGFac3J4YWl4TUVj?=
 =?utf-8?B?N3B5b3ZnNFIxb1pJK3B4U09XTEJBUldhN29Nc3piVzIxQ2c4WFhsYmNGVWtw?=
 =?utf-8?B?L1dnSEU3VVdKcytzYXBoZElncDJCZWg2YVV4ZEYxU1VTOHlzNTl4Ylh3dW5P?=
 =?utf-8?B?dzlCQlY5cmpGdGZIRFdZdUt4ZTZaQkpObFB4aHZMV2Q4ZVMwckk3d1pSbVV4?=
 =?utf-8?B?U24xeEtvN05LcFR2UExMVWtmdEtVVDVUVTBBNDBHVEVacXJ5TGNVaXpJcUIx?=
 =?utf-8?B?eDRZb0Jza290L25WTnVORUQzSjhvYk9yTGVrT09NZ3E5UDRSaHlKUWtnR1NM?=
 =?utf-8?B?VXo0em1NYTlhWXU2L0pyVUg2WjJQV1NTU1REWkNNS0pMZXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnhOVlhnM1p2cWtWVVFDcEJvWkZDL08xY2VxOUZzVzNPa2lHTHQ4d2htcHNO?=
 =?utf-8?B?Wnd3aFlBREIvSVhvODNEZHg3OVVNdElrY0RlVEZlZjhtTHVJUTlKZUNhaVM0?=
 =?utf-8?B?OERFWXpJS0pYUGNlOFNURE54Y1Z3dlVtOVI4Uy94MTVtdTU5Qk5PdDJ3Y3JJ?=
 =?utf-8?B?OXkrN0w2S2NTcm1hSHlZU2hTWXcyeUcvajJ5SXRwRENBSFMxejdlTDV3QlFz?=
 =?utf-8?B?eXk5NTd2TFNQUkpFMGUrZUtwYlljRU44SUdwdGdkdWlINjlWcUh5N0UyOEw4?=
 =?utf-8?B?bXlaSmFIMmh2V3p1bWZ0emFLNmZYQmdYeGdHK05WcVZvRStCOFFzSmo0NGYv?=
 =?utf-8?B?aXgvTnV0L1pya0grZ0dWcHBTTjIvTkhxcWw0YVE1WWNGanRFdngzLzBhRU9i?=
 =?utf-8?B?d3AxUklTRjZiRUtLYmcrQ3FaK0lzT1dMMHlGM1haZ2dFWmRUNmxMRUF1dlRV?=
 =?utf-8?B?Nk9NSzh4QjJEM0FMbGNMOCtuZ3kyZ2pGbUFyTlFuZVBwejJKa3lvK0FVR0hv?=
 =?utf-8?B?VVVqYjBENVNnTFZMc0o3TTNTN3dwRnl5K0tTZm1MbFFhdmFxZVNxM1ZDY1BM?=
 =?utf-8?B?MDNqMFZNbmFXanVodjEwbi9HZTBQQ0NvNEJCandFU3o3eDhLSjhpcjJVZG5n?=
 =?utf-8?B?bXJjNjQvZnBiWkhURHVSaVVlaytiSWQwMGM3c3BSWDFJNk0wcHg1dVQrdWow?=
 =?utf-8?B?Q1ZtNnVkWTNqN2J0M1EyeFcrRk8zV2FtZ1B0UTE1K3FYV3JhVnp0QWNWQVNJ?=
 =?utf-8?B?MFpRdkI2Tk0vTk9Fb0xPMFlNcjY0eklZK2Fna3JVS0dXK3Mra0I5QUI0OVJu?=
 =?utf-8?B?eEF6bEpWN3U5NnJrWXM2dTYyS2tVdE9LeTA2YTJKZlBlRFdQVkYxOVZzSndX?=
 =?utf-8?B?RWVPcTJJYTFHeDJOc1FqM1pnUFVVVFZhM2Z0czRxVy9la0YvVkQxeThpRHVN?=
 =?utf-8?B?QThGVHRmRHNHRytWQTNST0xTUjZjSm9kVU5vTTVpOHB4OVNERnJFQVAxazli?=
 =?utf-8?B?TlYrUEw1TlVnTFllSXVFK3FXdWMyclRoSmFiMEZHb0pGK2p1R051ZEZVbjJV?=
 =?utf-8?B?M28vQ1YrWkwxTFFPMUhBRVF4NWZsWkFQVnBUZ2tXZm5rT2FkVUJLRTNYYzIr?=
 =?utf-8?B?Y1JlTDY4ZG9EMjZYUU1EQXFqK09yMVFBcUNvd2dWWEMwU0hDMDhRUzBad3lx?=
 =?utf-8?B?VDczWUdwZzhERnliVTNJVm10Y0pXbnNPNWRpOVkybXJhbmlEOVo1Zy82OTI5?=
 =?utf-8?B?TTdrb1plUUpBakN2SUNxeGcvaGlnQVkzZkJNRzhpUmt0ZEZHSTZDcy9HOGlV?=
 =?utf-8?B?QXpJZVBtOEFzS1lMWWdOUGhYOEh3b2k4dWE3ME9JRUJ6WkNpMy8vZU5RSmR1?=
 =?utf-8?B?ZnJ4VFZTdDZzK3lhWDM2N3ZYWmFKT2IyZjU5VEwxaVlYbTY4eXRmNFBKNW5V?=
 =?utf-8?B?UnNEbVZ2U3BFbVVqbUhJYTgvZnowZk9Pb1c3TG8xaU9BaXNaTno2bS96QXE3?=
 =?utf-8?B?Nzh0cnhBZnQvY1lXZFVkVzhnUjY2ekEya0Z4WFJKYlI1V00vWDNSY3NQZmlP?=
 =?utf-8?B?bGMvR3BPanVBOUJmbzNuMHcxM0ZkcUY3cmUwYkpsNmY5c2NZVEdMQVJ5WE40?=
 =?utf-8?B?Um5vUFc0aXZUcWgyWFhiR0hES3ZzTGVtNUJFVmh5RWpGUitNT3QyNE9aZDZq?=
 =?utf-8?B?WkFkb3NIQUVRUmFEakVQOFJGRjk3MldzVlpibTkrQ3FueFVkZzZjREljSXRt?=
 =?utf-8?B?R1N0dW8xTVJLekxYQXlXdnJNU2czYldoL255N2dxMlhSUFFvZWdqUGphUStO?=
 =?utf-8?B?RlRobDRXU21UOEdDNFY5cHk3WWpYTlQ2R0c2ejZRR2I0dmJScG12N1l4N1Zw?=
 =?utf-8?B?T3ByTGpITXZWbkk1WTdCcXFQMFpRcjFCRko4VmVTVHdTbGpKd0pHRmtSM3ZQ?=
 =?utf-8?B?YkFvdmJnNjd2bUYyQXJWclNpdlc0WHRBZ25NQUVmTlFqam1ZcW42N0RnMlBh?=
 =?utf-8?B?c2xYdXhTYk5rS3Mzb2dPS1NYdnpreGpHZWpScnB1UDQwZ0V6Qld5RVFoUHN1?=
 =?utf-8?B?UkNtVTFhOGk3cDZHMC9HOWRBYlBFL0RyRXpGRHhCOXFjdXQ3SzZVdlEzbjFq?=
 =?utf-8?Q?7fNaDbQvY5C2IpZgV+OjPfv+I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d988dce-5085-4cf2-8d97-08dd6de69662
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 10:52:09.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7rUIB1X0LUg1aOUxB7bOEVSPY7bhlx3X9Mns/drZGpEcOFiqfwF1sIWZXj3F6cCIyyvyGjUzSFIWAY2TvVhTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9497

On 26.03.25 17:58:50, Fabio M. De Francesco wrote:
> On Friday, March 21, 2025 11:42:09 AM Central European Standard Time Robert Richter wrote:
> > On 14.03.25 12:36:33, Fabio M. De Francesco wrote:
> > > Simulate an x86 Low Memory Hole for the CXL tests by changing the first
> > > mock CFMWS range size to 768MB and the CXL Endpoint Decoder HPA range sizes
> > > to 1GB.
> > > 
> > > Since the auto-created region of cxl-test uses mock_cfmws[0], whose range
> > > base address is typically different from the one published by the BIOS on
> > > real hardware, the driver would fail to create and attach CXL Regions if
> > > it was run on the mock environment created by cxl-tests.
> > > 
> > > Therefore, save the mock_cfmsw[0] range base_hpa and reuse it to match CXL
> > > Root Decoders and Regions with Endpoint Decoders when the driver is run on
> > > mock devices.
> > > 
> > > Since the auto-created region of cxl-test uses mock_cfmws[0], the
> > > LMH path in the CXL Driver will be exercised every time the cxl-test
> > > module is loaded. Executing unit test: cxl-topology.sh, confirms the
> > > region created successfully with a LMH.
> > > 
> > > Cc: Alison Schofield <alison.schofield@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> > > ---
> > >  drivers/cxl/core/lmh.c               | 35 ++++++++++++++++++++++++----
> > >  drivers/cxl/core/lmh.h               |  2 ++
> > 
> > Can you take a look to move all those changes to testing/? This
> > indicates the interface of your mock functions need improvement.
> > 
> > -Robert
> > 
> > >  tools/testing/cxl/cxl_core_exports.c |  2 ++
> > >  tools/testing/cxl/test/cxl.c         | 10 ++++++++
> > >  4 files changed, 45 insertions(+), 4 deletions(-)
> > 
> Your comment is not very detailed but I think you are suggesting to 
> override the lmh functions in testing. If that is the case, I don't think 
> that any function which is exported from and also called by cxl-core 
> can be override by testing with the strong/weak mechanism. 

I think you need to modify cxl_test to create a LMH hole (register a
mock bridge and root port with the necessary parameters, etc.) and
then run cxl_core unmodified.

-Robert

> 
> But I'm not an expert of linker related topics and not even sure that I 
> understood what you suggested.
> 
> Would you please elaborate more?
> 
> Thanks,
> 
> Fabio


