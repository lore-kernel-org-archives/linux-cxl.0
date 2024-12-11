Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006396DCE1;
	Wed, 11 Dec 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733899231; cv=fail; b=mmAqt4XnLhSKiOpzMxy5ahf0lvi/EKfBFE/w1ahnWOi5Psz/xo3RzhatkA7+NcVK+PjDUImUxV4x3ZPZwusvKLfRk9898sUp8W/lktZKZb+a1RhSYZXYEdsVacPLvi+n6TDbk16cWYtyilr2KZ/DJrbK5rlpqQi0KUDjjqvEu0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733899231; c=relaxed/simple;
	bh=VYgSJgC6kVFqUevDZOanxtxuc7P21xTFJf29SO+8ZZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OSBDHuEIeZBh0KK2fbRVYzMKKTd1sFxREm6WWNur5wGqYwKkegIjZzSwhGYX3yYsMH28HLUxeTgKeMZD7/7gNk3X5sX/E7v//F0tH6Cps14u1O16gQHaDgwxYqhd7y2LrCTnaPbHDNYoINk/3k7qHquE1RbL2QXFMtNIR+Cdxrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2R6rVc0L; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2R6rVc0L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvxD77ivedByMoSqW0GlBnrv7hrOhFXDtcW30jm6TPrjwuwkGzY5wpIO34uiFhikn6IvJrbt/qbjQFy85BA+BH1QcKFujDNAWk2qFwD6BkrE5B6B7ix9pjMXnjsg81w+zCWfNW4s2fhYiG3OvNrEJXSFgZpkkHESZmWucH/nMbs3wZIgEgX6bkdyHokcf0Smt24c66kVL1XyorKpkhtLMwAQZT5nP07jarh321ZZPahvE0LZ+doLBVJtGpDjcu/+y0Awb1hK0lbzEAWfXEbecFiLPmAtMfswLjRrarjRJ1DDmgUsumgrwMDc/MdQPQC6lTWkgTHNwpGf6I7cLDPOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2CuFoW8waQq13+OCY4YEZemOGfpF5wXchdUh0LPv5g=;
 b=DhD647vAJd8X5Avr8llj1kR35Hyr1VoXcceabbustcrjVM/Whjrobt0kdt/wWAKwrMlzNjgUEgfcNvE+sMR6rQvMc3FcHmLWokjO+oJrNy/SStHzutC5Z/rOyHlTWxx+rmXqOdJG8x6IFTrhtcaYCf9Xv4MSOvIGGouXdBlNUlrEZzg/u6/30TAC9ieDorQXHhNdb4pWzxoYSpHJHpHiYAZ3zWYNdAO8oJ98+DImxojz0gs81gg5h/tzwoeNXY+74r0NoxWYtRf2E/gxZKKkNX4UrlbYjaNEa72d3DLa0BdYrY6BUGJUzzpK+HB05nV6lMFe2UxYHzz5Z16ykhs8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2CuFoW8waQq13+OCY4YEZemOGfpF5wXchdUh0LPv5g=;
 b=2R6rVc0LSu/oGXx9MrVugRSrFeFWVhgaYKzn/dxfhYYEL27jVrbL+1wbyU6kY/rfeE7822zU3PYZH9njludRpd4YozZcjuH4EMOrGbLsbtn6vlkBPPXgtLTqBfjGOSjM2R29UAZx+Dx8rlR5xEm6X++IglNrnfBC2vRQK6FVc/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) by
 CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Wed, 11 Dec 2024 06:40:27 +0000
Received: from DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::ec83:b5e5:82dd:b207]) by DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::ec83:b5e5:82dd:b207%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 06:40:26 +0000
Message-ID: <de22dd6e-00a3-4183-a123-15cc7c53980f@amd.com>
Date: Wed, 11 Dec 2024 12:10:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
To: Dan Williams <dan.j.williams@intel.com>,
 Raghavendra K T <raghavendra.kt@amd.com>, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 regressions@lists.linux.dev
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <674fd2b4942f1_3e0f629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <33b4b93b-5ab6-4a3b-b3b2-c9b3cbc9d929@amd.com>
 <6752acd92baf0_10a08329424@dwillia2-xfh.jf.intel.com.notmuch>
 <2b5bb8d8-6a7d-4a58-bde7-ce42d0a23f61@amd.com>
 <675918b414c17_10a0832943b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <675918b414c17_10a0832943b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::17) To DS0PR12MB6439.namprd12.prod.outlook.com
 (2603:10b6:8:c9::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6439:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d38c21-b6f2-4e7a-5f9f-08dd19aeb24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmdRQmY3bDVIbWlFcjU4OHBBbE5PYTl0LytZaTVteVZ4dTBJK05KWEF6U0E1?=
 =?utf-8?B?MWpqNlorQUpibzRJZ2RscC9EWUpRQnVoazFKZEVRK0NBenJhVE1vSXdlcEI3?=
 =?utf-8?B?U2s2Y0owSHZGMko2OFZoUytCaEQwS3VFZmkrblo3d3ZVSGpYUWo3RmlkLy9Z?=
 =?utf-8?B?ZGJlYkhkTVJzYzFxYWZHaFVmbjM3K2pQazl1U2pPV3lDU2p5Z0l1ZWxHWlFS?=
 =?utf-8?B?WXVKa2QwWU1wbDQ3S2NITFdybUk5QWo1T3pCMWg5bVhzK2s5U0tOcEg0T2Vp?=
 =?utf-8?B?d2FVN1Z5UEtUWTRxU2toZEZmMXNGSFh4dnRVb1liYkNabWtyTW4vUmlZYmd5?=
 =?utf-8?B?OHRIQlBtZ2htakN4RDRnSVVVWU9FMlhKdkkrT0FRbXpMRktFTTJSQTRzMkNC?=
 =?utf-8?B?MFg0TytOR2JOdGNQa3VJcmF3Ujl1Yks2UTZ6bEM1S2RzN09MRWdDMDBicm52?=
 =?utf-8?B?aW5SWWlVSVZaSGE5dStJbEYyTWR2N3JqVGs3RWxrTlV5ODBHM0NCSTlqMFJp?=
 =?utf-8?B?TThjNktGSllkMGxQTW1MT2pzT25qZkpIK1RFTko1VTlpVThIZFBjWjEzb2FZ?=
 =?utf-8?B?TWtjeE1ZRWszWWE4NmhtWFRXOTJHaXY4VWdpcDJMWjE5U0ZqL1phUGRCY3ZI?=
 =?utf-8?B?MFBoQVBXNk55VndaUkRlR2FpMm1mVXduYUJmeEl2Vlp5T05hUmdDRlUyTlo1?=
 =?utf-8?B?WGNQa2dmTU9SYkhtaDZ0Wlh3TDIyeVp3MitDWGJRVGFJYWcwTGdtdTVjdXhY?=
 =?utf-8?B?MGtGVGwvOTAwWXBxZnBxZ3lhVEtjRi9MbVFsMTQ5NGp5VGRBMUpvcTlqdXJJ?=
 =?utf-8?B?V3pFVnZlMjVXOFNOZklya0xkaFBBQjNQUmxvejdTQ3E0emtDVDRUS1dhdEVy?=
 =?utf-8?B?S1VMNzJvcWlSTUNhUmlrL2NCRWhmRTlGTlozTG9Nd2cwanJFL2NrZzhkUkMr?=
 =?utf-8?B?d1BrTEI4cHVRbFB5Ly85cmU4S1Q2TitsMHYrNnRIVFlRSWxWbFI4cXhaU2JQ?=
 =?utf-8?B?ek1qRkhSdXRnYVliczg3RHpoZ3p1MVpTYmxJNEllRVI4VzhOUVJITGt0RnhJ?=
 =?utf-8?B?QzB3a0dRVXNFQk5jR1hlcU9GUiszaGU1VFBieFJxeG9JVXVRTEV3cmcvbkRi?=
 =?utf-8?B?aUFBcDJ0ZHNCcWErR2FCZmZSR2VLcUlYL1RXcmFVZDVUc21mblF4MnZoeUtx?=
 =?utf-8?B?RjJtOFNFdUxCd2VOaEdzMVBmMi9GYTdUQ1J1SjF4VnE0cmVNNUpVUVRXbUg5?=
 =?utf-8?B?ODlIcm5XZ2IvWkpUNUs0VU9KR1VFQUdRRDBWVThVL2E0SmJHUzhJcGFaMEM5?=
 =?utf-8?B?eit3ZUg3T0F5VGhiRXNLUGRySjJCQWovQVNwa3ZTVGEza2l6VEQzeHd5aEU1?=
 =?utf-8?B?RmFxMm8xUzRqUDFZSktUSzFyc3RtK25WYnlVaVB4NmRha1g2dmdWWHhESVhF?=
 =?utf-8?B?Z2Z1OGpCK1VJaDViVkd1QXRWWDQ1dWFTbWdYVHlxWUdkZHJOUTFvNGZoR3BT?=
 =?utf-8?B?YnJBZVNPTXp3NG16dmpNdmRHMGE3VFlweHpybW9sWW1EQTFIa1l3anhvbjUw?=
 =?utf-8?B?ZHN2UENIcTgrK0Q2MjVvRGxxNmd6am1iTTh3OG5ENGtIVm5DaUdSVWtSbC9n?=
 =?utf-8?B?Qy9SS09DcUlHaUg2S2tLUzJSclVUcU9ySUpteElsZWgzTVFwYjdjNUlYV29v?=
 =?utf-8?B?YVNmWTJmckNEODNlM3hGUUxleDJrYUxWelgwb0FuQjVRbHlKMWtmNzBGQTVv?=
 =?utf-8?Q?gyiO3y4RMVeDSHXG5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6439.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnY2cXpEdWxRS1k3TUxYYisyd2ZUNlprTElQTlZVM1lBZkZxYjM5Wk01YzNz?=
 =?utf-8?B?dDd6ampzWlhrcStqT1VjVUdtVmE0VVFtWkdIWDlKLy9lblI3MVFPN2I1SkMv?=
 =?utf-8?B?WmhYNkFzOGZXbWhKbjJUOHNGVmdYUUFVQXl2NTFHM1lkbmp1d0hGeHVqTzN4?=
 =?utf-8?B?U2pyZFF6eHg4aTJhc1pEb252MmNaNHlMZ1lldnBSYmt3T2tlR2JrY0RuWER6?=
 =?utf-8?B?VXRWbzdQT3VjazhkNHg2alZ4WlExRHQ1bHFRMUpVM09ucTRuSm93MzZFRm5p?=
 =?utf-8?B?U3ZoUjN4SHlEZ1dYdnAvb3pEclY0dmY0VGdBVjFYdk53d1NIWnVhN2FNNGI3?=
 =?utf-8?B?WkZRMXJXeEM4R1l3LzhKNk9Ib2dmK0s3WGhPTkEvRDFjWTlrdE45Yk8yLzVt?=
 =?utf-8?B?VVFBbFByd1QrdFFiekVNeHpXMy82RDh3aUg3YURmcTJZZU1UVDhOMThKUjNC?=
 =?utf-8?B?dUJMZmIvMmdpamVJNDlxa0c3U1YyUFE5cE9DSHU0YmxRdVZuVkEycSs0SzRu?=
 =?utf-8?B?ODlWakZsT01UV2hzOGNDamx0Umo3eW5SNHdvQnBHRDRyZVg1NFpxTytVT0ox?=
 =?utf-8?B?NG9jMElOTVZGa2F0VGlrZ0JRNmxRVlY5dWZjdEdNZUN4Qk90YStmNlBaOUVS?=
 =?utf-8?B?ZHBQTHQyUVBYOGUyTDRDOEsyOHRoUHVjdGVNZG14OFNiTVZVSkNyQ0pWZzlT?=
 =?utf-8?B?emJvVURsZ2VaS3lMR0NrRHhMeGY2WE1xandKK1NxZlpISEhRWTFxejl0Sk5I?=
 =?utf-8?B?ZXlEV2tVT1dOQitQL0dYaGZKR09tY09rbitHS3A0VnZncEZNK1ZrdEZ4NUln?=
 =?utf-8?B?MlpielZCYUVncHN2eUNSMmo1NVJZOGt5bEgycnFBOHUzT09rNU5TTHo5ZWkx?=
 =?utf-8?B?a2gwUVBwSDVjc05zVWZqZzdDUkJtLzk3UExRYjIwcTF2enBxWUdSSzFYVVJl?=
 =?utf-8?B?SnA4dGR4UE5Nd0VMTXlWZVBQUVpxbzZDa0M5bThaQWRvSWR5TFdnbUpEc091?=
 =?utf-8?B?Q1R4L1JwYm9BaUtzV3pJNStQcVBEcWpLYWNRNTg3L3dsNVdDK1FkWlo2M3NG?=
 =?utf-8?B?d2E5VVRneDN5UnRQRmxwbXMvbjkwNXE1aWJOb3p3ekVHN2FWYnNqdzJvVWxl?=
 =?utf-8?B?SzM4aXoxdjRMTHVPTk0zbGpySDVvRDd4VFVWdjQzMW9JdzdCK0ZMTHlwU08z?=
 =?utf-8?B?TGhteDVGMk0wVTlUN1MrWXBubzR3ZU9NenJQYlJIV0JwNHRvNFVhbmVYUzRu?=
 =?utf-8?B?Y2RyMzhXeXBiU2VOVjZ2emhuYk5iTUt2WTRJVkJTTEZrdHFZMW96SmlMdGQy?=
 =?utf-8?B?U2VmZkhMeHBXRXUxWlljaU5uSW5GZlBtTHFla2xsc1hUNFdydUZvcEd1QU5D?=
 =?utf-8?B?ZWlCWnhBYTI2WUE3OGdtV0kyVVExZFNCTjExVDVvZ01PUlJENlBLT3JJRFky?=
 =?utf-8?B?dW83bXB2blR6UVgybHUzbjlsWkVMT3hhczFqRldsVHNwUlNpU0RhRFdPdnpK?=
 =?utf-8?B?ZTRsZmFEOWs4bmMwUG9ZNTNzZEVSRGt3VVA2YjdKbTBWdkhQT0ZTU0RkNHBx?=
 =?utf-8?B?Z2FqM2llR1cxNlpyeUt6T2FQa09EaXJNa3RRTm1vVDdkVHdlbUpnemxSVEx1?=
 =?utf-8?B?bWJFL0VVbGlQNHBWbWNWVWRodExGZTJUT0Vjb2ZDWVdNV0lVZ2orWGdlNzI3?=
 =?utf-8?B?WEY4OXEzak9BVXFmNDlsRTU3WG9iQ3Uva1BGT0x4eTZJSDdGdWQwRCtmaHRL?=
 =?utf-8?B?b1dkTXhqNXNqd2hzNkNWaGVLcnBocTlNK3pnN3MrN1h6UVhPNzBFNkZKNXBk?=
 =?utf-8?B?UkNlWnlZRW1ZUndDNUJmQ3l5VjdLWnp6UWR4ZVdUZUk1RlpNdUZlcWpMb01S?=
 =?utf-8?B?dEZNNzkxVjhKRXVrMzU4TnZoWTB0Yk54eHFTdTBadkZlZnJpUGhPYXRVOEVv?=
 =?utf-8?B?V2NuNGJBSDJ4aU13YVNOc1hiYzJ0dTdBN0N1bDNGc3o2OE52UEFsMDRETjNJ?=
 =?utf-8?B?V2Q2MVFJalk2b1gySFphcTVKb0twUkhDNWxPZ1lUc2NCdVQ2K2NpbXZpOXJp?=
 =?utf-8?B?amxtRGFCZisrTFNVK0E4OEZKOTJmYzRwOG13TisvRlRRR2ZtNmVFbW8rYmlV?=
 =?utf-8?Q?16xw4sh7GG6De5y7KpMTRJnve?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d38c21-b6f2-4e7a-5f9f-08dd19aeb24d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6439.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 06:40:26.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4J+B7JucEFjjxo6bPk+YcDMfKnYCCeisVItxGKnHutVs4Iod6PGLQYUaOke7ptefsQDpiP8QJYwg3RCBkX0dVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262

On 11-Dec-24 10:14 AM, Dan Williams wrote:
> 
> I was able to reproduce a similar set of conditions with the cxl_test
> environment:
> 
> f010000000-f04fffffff : Soft Reserved
>    f010000000-f04fffffff : CXL Window 0
>      f020000000-f03fffffff : region3
>        f020000000-f03fffffff : dax3.0
>          f020000000-f03fffffff : System RAM (kmem)
> 
> 
> ...but that did not result in the bug. So there are some other details
> missing. Can you proceed with providing the dmesg from the good and the
> bad cases?
> 
> gist.github.com is useful for this.

Sorry for the delay in providing the data. The system wasn't available 
for a while. Now I have put the good(6.11.0-rc6) and bad(6.13.0-rc1) 
dmesg and iomem logs at

https://gist.github.com/bharata/4a57db11e044fd1d313035f3dd5f763b

What I see is that in the bad case, we hit the below shown dev_dbg 
message (not seen in the logs that are provided)

static int hmem_register_device(struct device *host, int target_nid,
                                 const struct resource *res)
{
         struct platform_device *pdev;
         struct memregion_info info;
         long id;
         int rc;

         if (IS_ENABLED(CONFIG_CXL_REGION) &&
             region_intersects(res->start, resource_size(res), 
IORESOURCE_MEM,
                               IORES_DESC_CXL) != REGION_DISJOINT) {
                 dev_dbg(host, "deferring range to CXL: %pr\n", res); <--
                 return 0;
         }

With this, it appears that dev_dax_kmem_probe() won't happen for the CXL 
range and hence CXL memory doesn't get detected.

Let us know if you need more debug data.

Regards,
Bharata.


