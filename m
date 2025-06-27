Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4D12E1C46
	for <linux-cxl@vger.kernel.org>; Fri, 27 Jun 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033681; cv=fail; b=j9Pz/ck/MfS1CZVcD8Ypb83I+FPSOb5YJuoX0oGkF8uPOzw1XL85Q9eciJy0+fdEYsquX1JEbItv1f/1ln9EuU0XOFrf3KzndZWTsKSwqUUTnGKK3KJX02IoHZVHqUmxnGFcb24JJ9ahk8Vwnhu1PtZK4N+5au5rcA0crULPo/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033681; c=relaxed/simple;
	bh=/WlS83PoaO13sLD8EwlNQHPb0AdKWES8jr+si2PLGDA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QOkPgCKQosaOVtDF8mxKs8Np+2tSnxuhRr2Qw9QXkO1IZvKdPlv5vF66TGFIJCMgVP6Q+NsgJQQs1mWYJZWg/LCyY3KbCe6lT+M5QZ+1xZLku+RQ8OXXfyVxo/C9xEM4IqsxToeXWFofJSkFZtTuerzdN0LXQCuC9IKWmERuUvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B6nXosmk; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B6nXosmk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUiIQ7VnidPy1A1TsWPUa5+++UybijXHNpfzudTGljlNUoAQI4DIy8diS6U7bqApztkcvRPhSzQg1/FX8xsaeaFDVaSSwHhRZwcSJ+IXFKSQtPMtq3BJouZDZjch/Em2RZQ9JNHTLUscdZRFrMQDGOyX3rIwBL/8zqIAIOCgEe3RpMkaj1pDOXoWjNqtJNtMsX6LTiIfy9C80xfp0aaf/mjTbAKMfYlK4CAeVBGBh6/Xhcaursjk2hM7+igFb60ZgA02rDeKtZQPKlK2mRLOzFbJ8M4i9k/D0TeH5lnUKpZhmWiEZ0yH89aHf0lTnGsjhz8nv2hgH8OUCAHnkP0phQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcKy6ZgUQEJon5LV6Nnq2MDkhetAs20r8rmMfO/eI98=;
 b=DSosf0Q8DVgjS6JmnV2epkV7fJrvRVgtHXKvx1X2nZTFkl2nFReCHKbow1XfTZPt9ZeaRSzduPjtNB3C42ghr8h/ECOYlUqXmdDApe63m+97X+xQN/9ZMH2Ec7ZHYg2Mf2YoO2oaY+BNB08OH4EeZIuklYLfAsJP+zYzwcT3P/tfEREJBWgqxrhtuP5ALba9erhjHH8+jewH8of9jBmaLhThRv+SNd9W8jlXqzkFYTZui2BnkAwGsmy6GW2zBWWyzQoNTX0Q61OyNcRUgdgfjCYkWDWO6EXxNAAMVK/k9zMGjhq6D0lCBSu1GPRmDQ7409VoHlF8zBsFwaOR583WEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcKy6ZgUQEJon5LV6Nnq2MDkhetAs20r8rmMfO/eI98=;
 b=B6nXosmkoeCi61ST31EQCOnnQBGJooryZT1IfxibFww32eeb1CoIQvn6YgGvp4WwXrujtOotzmmBBTCh4VubSecf6VckfKIGxG/5n6k9Qr/7DE3eKcPXa8i5ZVZvjbkam25uYu/3aArsOl5/0IqFzk7zDyP+cMFafGonwoBL7eI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.16; Fri, 27 Jun 2025 14:14:37 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8835.027; Fri, 27 Jun 2025
 14:14:36 +0000
Message-ID: <cce50089-99e5-4618-a8bd-ae957f37549a@amd.com>
Date: Fri, 27 Jun 2025 09:14:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/17] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com, linux-cxl@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-4-terry.bowman@amd.com>
 <84cc6a77-bdd8-4e62-998f-7e065f90115d@linux.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <84cc6a77-bdd8-4e62-998f-7e065f90115d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 396757b4-fbe4-40f5-b56f-08ddb584f262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkVNdXc2bk4rR2dYWktUYzFmekd4ZS9SU3VpZ0ZkQTRnZGhFY0NCY1YxZENu?=
 =?utf-8?B?V2lXOXdMV1lsd01aVDZkUDF3T1dhRDQ3LzRFTUNwc29iUUNQZUVNTUVpTEhL?=
 =?utf-8?B?TnRoUVg5WTZlWWpnOFJUaFIwSDJMS0NabGZGTi9pUTVhcEYzaXlXdVdsMlVs?=
 =?utf-8?B?dGMvajBFRVh0VVJDSVlON2dvNDNtbjdqNjUwQmROSVUyank0WmErMG84dGVB?=
 =?utf-8?B?eWRoaTJLQmFoK2pjYXFQdzJJN1Y0MHZGR0dvTk81TjdjRyt5U0lJKzRnd3Vj?=
 =?utf-8?B?anpPaytQS0VPNDR0d0I3TWV1T2lFaFo4a3dDQ0FpUEkzdlUwQzIrMUtQTkxx?=
 =?utf-8?B?RXNBK1lXcHBWak44WFNlcFpmQmUrRm1kak5aUWZoVzJxa2Fzam5DTEJ4MjAw?=
 =?utf-8?B?d0JTL3VnY0RrVTNJTElna0dEMmNMS1FNUnpLZkxISEVlaHQ1NjFDd0krSUds?=
 =?utf-8?B?UUxESjhmaGtkaU5sdE12OXQ2TlZjdS9hTEdxdzJzNUdWV3hjdVhVdW1sL3Zy?=
 =?utf-8?B?ODlseUF3L3ZBaWlsam5NMW9wOVdlZnRST0FYL3pWcjhLRnp0QmF2NHBjSmMr?=
 =?utf-8?B?RHpZY1piTlM0bDl4K3JKWUdTbm5yTFR0NFVYTFBOK1RmbFRicUFTd3V0amNJ?=
 =?utf-8?B?ZjBWbXVzTWFPSjkyNjNaUHJRWHdKQ0JZM3N3U2F3MnRLYVIyYjBuVU42ZDhj?=
 =?utf-8?B?aGwvRUZrd0Mvc1lHcHp6ZExxUmRhTEdzQlhNSFYyb3dOM0ZZemlKcGxtQ2FJ?=
 =?utf-8?B?RWIvT2JWamQ0OEYyN3luTWNIYk1kUzBoS0xBbXRCaktIU0Z1SHdhdkUwWkhG?=
 =?utf-8?B?TTA4MC9IZXFJUGFwV05BMWVnSkt2emJVbjZGSStMUU1OMVVNVWJjemhXbGFj?=
 =?utf-8?B?VGoxRC9aRTB4azVUN2NWU1hSbFRTK1N5ZW5PRjd5ZklsODVrQlNKWlZPMHV3?=
 =?utf-8?B?d2t5YUZRY2RudkZ6MkpOVWxDb3BSZG1oNE40R0VMZTZZNW5ENk93NkdYcFhi?=
 =?utf-8?B?N3ZHZ29mRE9XZldudnZTNXdvUnYvRFR2Q3VDMDd4STRaZkU1R252MUxBSEN4?=
 =?utf-8?B?Y1JqMjkvMmE2aXgzTkx2OVQ3cTBWVWF1d1hOMHA2Tk51ZzNKa0YxREU0T3F3?=
 =?utf-8?B?OUs0bVFMV1VLbkZ3a0cvcHQwTzNtQUhoTWlCVHY3TDZRdG5XK2Zja2t6WWxr?=
 =?utf-8?B?eTRQV2l5a2d1ZmtEQ0huSkpycHBtS3RlQUlhajJFaDdycFBpOE1udlVBV1lr?=
 =?utf-8?B?bk1ReFI2cXdrazZSOThwanVqR1RrNTlXTlVRRHJmRUpVc25CbGFQY0hTZjFs?=
 =?utf-8?B?YndQUGJBclNjR1ZGVTJtemsycXdpeGszc1BTangyK1lwYTZKb0xYNEZySUR0?=
 =?utf-8?B?UXRHOGVUTHZsY3RvZTRNaEFNQysxUXpISnlwTzRuSjRnMTB4SlUzUTdHaEVC?=
 =?utf-8?B?Y3d4Q0QzSmlhNHRjbXpsWFErTSt5YzBZdldxMUg0VFcrV25sakpoYWlaL3Za?=
 =?utf-8?B?V3ZsL0V0S3I1R0EzdzVvRStzRGFOVUtjZWh5aDRpZ1laR3J6K0NISDB4N2hW?=
 =?utf-8?B?Y25yZU5IamREa1R0Y3draEZSSXBjbkVzTWpST1luVEljcEt4QnQ0SkdqMyt5?=
 =?utf-8?B?L0JVWENKRk05QUVydzJ6R3hDZ3YyNWpZd2hJR09LVCtDeU9QUEhDTVRoa255?=
 =?utf-8?B?dVp4SFRoM3Q3dC9tTHA1eDFOVXJvY2QrVlVMUnB4MG9scnVnMUJGVjZMOXlB?=
 =?utf-8?B?RWc5c3FCL2k4amtXQXlrZFlLd0hPa3MxbDJ2ZmJCb0tDTnFYbmRuQlFKaUND?=
 =?utf-8?B?VnM3ZkxrZUxSYVovRDZuU3hjanFMQUpOV0xGTmJmeWNsNFd0MW91UU5hVWVl?=
 =?utf-8?B?NWFyZDlVbE0xS3lHNWFYejI5K2hGUlRBdGlUVENUbUZIbmlWVitqbUZ4Y1N2?=
 =?utf-8?B?S3FVckVuNGJYYzMybElyeEZwQjdGbGs2UWx2TjdYUDBoWkpXYk5JSWlnODVO?=
 =?utf-8?B?OTFvOFhqVE5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDk1a1NmVzVxR1lHT3Q1ZFdJZytvdEZ6cXJpMWZzTWhGem5yK3UrZll0eXUw?=
 =?utf-8?B?MTYwZGN4V29iUkhyekt1K0U0ODRMalBmN09DdWUyNk55MngvUHQyQnFZYWNC?=
 =?utf-8?B?RVdHRlAzM2U2ODdHRmZZeGk4ZGRyeXE3UzdvbzkzbFRMaFlPZWRDVjNpRDl4?=
 =?utf-8?B?ZTlOdUYvR08wWnZVQmFlSFgxa3ZCdlAxTkMxOVhVSFpnT3pzSzU2SGFuRTM2?=
 =?utf-8?B?b1N0Q0RFdGVZN3JSL3FmUWZweGp5T2FTSktnTElyalM5TzJVUmJNZzVGVXdP?=
 =?utf-8?B?UmF4YmFPdTdJME1uYW5STkwyS3JFSUNWYnIzQ2o5WjN1bWJRMTFYZG95ckln?=
 =?utf-8?B?MGF0eFdYbU9YNEk1MDZ6TTVVNE9EVisrbW9TZTBHV09QY3k4blVETDNIakZl?=
 =?utf-8?B?MXZhM3J3RjhLVEh5ME0vSFdmUVpwVXVXWDJ6KzNrZFNjREU3R3dLNi81TVc5?=
 =?utf-8?B?M3hhZHB1bE4ycXNHOW5CYjVhUGtWMHdzOUJDUkk5ZVRGaENxR2FPVTRySVNz?=
 =?utf-8?B?Q0xsRzViZlFYbUdWWVhoQk96OW8yRXZIZVYzNzR4Skt5eVF4bDBkOVlLUS80?=
 =?utf-8?B?Z21HV1h0V0xMb2tlaCtqQlBoeEZsVUNhRTVTbDVsRzE0azZEVWxNL3c4a1RF?=
 =?utf-8?B?N1VSMjR5cHRNOWtZM2Fia01kWm10bkl6bmNoTGFPQk5JaXplUFFKTndVT1gy?=
 =?utf-8?B?RGFrdGdRTUR1V2JqeVBHYVA2WDgxNlcySWowOGZsR2lnMjRNanJLMHVNWFQ1?=
 =?utf-8?B?UWNQcW5ycGhQZU9YUGl6Q1RMcDZldlplaDBoZUVCMUE5VklwcGpnZVVZUkY4?=
 =?utf-8?B?RDREQnFhN2NUelVPY29maG14SnhhTmdkMlZGRnhWZmN0OUF3Sjkwa2tiQVFD?=
 =?utf-8?B?WGpWenpuMmlBMjUvMVlpcjQydTVPeDZHaXhqQ1dMeEZDbHE5cTRSQ3hINHVM?=
 =?utf-8?B?L1FTb2puYWdNVmVzenZvOEZCekU5UDZscUV1TXdPWGl1VmN5UU5vQ2RFOFRm?=
 =?utf-8?B?amVzMTBJVjhSUTFWOGNIYnFqM3E5ZGprY24ycWFCc3dWNEhCemFHdXZOMk5y?=
 =?utf-8?B?NUZra1pxSkxyVndEUzJDdUhURHMxL2V5Z2dNM216bkV5YzZFTm9qMGdyYkpw?=
 =?utf-8?B?WHhaRmFwZ1Z2S2lvbVUwZjdaSVljS2RCb0wrQmp3RjRtcGpBelVxMmQvUjVp?=
 =?utf-8?B?RXdQL3JPWHVMc1U2c3R3WmFhbStReXkzZFprUUJmRnFvUlpxMlArQkNnWCtw?=
 =?utf-8?B?cWV2dzFVektKQ0xPUUljWGZFQ3FHM0p4cWtIUlJFdHhXRUFrektiekFabTJr?=
 =?utf-8?B?SEUrMmdSMXZuT1RjR2t1VDNhL1UrWXJIaWkyNXJwcjNJMXgwczhoQUpSdHYv?=
 =?utf-8?B?MTlzbUVwa2kwOExKKzNYdzNLbHk1a0RISmZMVVNlWGtBZUVVdHE4NS9ZaVY1?=
 =?utf-8?B?cVlsZXFEd2FDeXFWaXJxOWdsLzZHS3N2SWoxK1JFWUNmd3luOUpLR1gxeVhm?=
 =?utf-8?B?MXpJYkRldzJmL3FUZmhVN3RIQ2dScVRZYitqb3VLN3VTUGk2bzMrci9IL2NS?=
 =?utf-8?B?S1QyOHRDQW85SC80eHNocnFvYW1GRVpDUUFGbG0vZkNhS0lRYkMwekpWYnBU?=
 =?utf-8?B?eEpGcFBxNG9WRGJEUVJhODUyMTFlb0NobW1VRjV1T0RnalJXb3JYbjJ0Lzl4?=
 =?utf-8?B?UUxOOEdHSHpNTm81SkxoeDZ3Q3FVL01NY1NDVlUxcGwrcmsrQWFzUlJDTGNw?=
 =?utf-8?B?cVVQMXllK0lOYmMwalhtWlFNM05TSU9kUjFPTytjNU9Vai9SdDM1Z1Fxakdz?=
 =?utf-8?B?d1h5ZFM5SVBoVnU1cUsrVXFmODhPV21hVUxjUi9HdllmcVAzTkdkclFsNGI3?=
 =?utf-8?B?ekVlaFVLbW16VlhHYnhpQTFrVG1WdHg3WDk5L2dmQW1sVFh1TzVGclV1TnVB?=
 =?utf-8?B?cTBrRXlzSlU2aTAvUTFyK2xiN3ZPUVZuVFZjMmFLM0R0dk5MUmk1MDU0SlEr?=
 =?utf-8?B?UENUOGRHZ2lhUnJHQ2hPbys1M2FSL0xuUWdrZGsvSUVpMHJndkhINEc3c0xh?=
 =?utf-8?B?aEFQR3hRd3BJdHdhcDhldmtKWENsYW5ubk9Kc1ZDUWluY28weXNnZE5yZ2Rn?=
 =?utf-8?Q?+Eg3mySfOaVh3zXwjRXBiDdJM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396757b4-fbe4-40f5-b56f-08ddb584f262
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:14:36.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiEsC7Z7zpMj3fElQDRbKr/pkvkXkhrXYodgd5IuERQRc+/mzSL0OiclBqIStAa7cBJ18d5+VYH0SE7bWAAdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728



On 6/26/2025 6:25 PM, Sathyanarayanan Kuppuswamy wrote:
> On 6/26/25 3:42 PM, Terry Bowman wrote:
>> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
>> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
>> Type' for CXL device errors.
>>
>> This requires the AER can identify and distinguish between PCIe errors and
>> CXL errors.
>>
>> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
>> aer_get_device_error_info() and pci_print_aer().
>>
>> Update the aer_event trace routine to accept a bus type string parameter.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> ---
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thank you. -Terry

>>   drivers/pci/pci.h       |  6 ++++++
>>   drivers/pci/pcie/aer.c  | 21 +++++++++++++++------
>>   include/ras/ras_event.h |  9 ++++++---
>>   3 files changed, 27 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 12215ee72afb..a0d1e59b5666 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -608,6 +608,7 @@ struct aer_err_info {
>>   	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
>>   	int error_dev_num;
>>   	const char *level;		/* printk level */
>> +	bool is_cxl;
>>   
>>   	unsigned int id:16;
>>   
>> @@ -628,6 +629,11 @@ struct aer_err_info {
>>   int aer_get_device_error_info(struct aer_err_info *info, int i);
>>   void aer_print_error(struct aer_err_info *info, int i);
>>   
>> +static inline const char *aer_err_bus(struct aer_err_info *info)
>> +{
>> +	return info->is_cxl ? "CXL" : "PCIe";
>> +}
>> +
>>   int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>>   		      unsigned int tlp_len, bool flit,
>>   		      struct pcie_tlp_log *log);
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 70ac66188367..a2df9456595a 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -837,6 +837,7 @@ void aer_print_error(struct aer_err_info *info, int i)
>>   	struct pci_dev *dev;
>>   	int layer, agent, id;
>>   	const char *level = info->level;
>> +	const char *bus_type = aer_err_bus(info);
>>   
>>   	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
>>   		return;
>> @@ -845,23 +846,23 @@ void aer_print_error(struct aer_err_info *info, int i)
>>   	id = pci_dev_id(dev);
>>   
>>   	pci_dev_aer_stats_incr(dev, info);
>> -	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
>> +	trace_aer_event(pci_name(dev), bus_type, (info->status & ~info->mask),
>>   			info->severity, info->tlp_header_valid, &info->tlp);
>>   
>>   	if (!info->ratelimit_print[i])
>>   		return;
>>   
>>   	if (!info->status) {
>> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>> -			aer_error_severity_string[info->severity]);
>> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>> +			bus_type, aer_error_severity_string[info->severity]);
>>   		goto out;
>>   	}
>>   
>>   	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>>   	agent = AER_GET_AGENT(info->severity, info->status);
>>   
>> -	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>> -		   aer_error_severity_string[info->severity],
>> +	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
>> +		   bus_type, aer_error_severity_string[info->severity],
>>   		   aer_error_layer[layer], aer_agent_string[agent]);
>>   
>>   	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>> @@ -895,6 +896,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>>   void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>   		   struct aer_capability_regs *aer)
>>   {
>> +	const char *bus_type;
>>   	int layer, agent, tlp_header_valid = 0;
>>   	u32 status, mask;
>>   	struct aer_err_info info = {
>> @@ -915,9 +917,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>   
>>   	info.status = status;
>>   	info.mask = mask;
>> +	info.is_cxl = pcie_is_cxl(dev);
>> +
>> +	bus_type = aer_err_bus(&info);
>>   
>>   	pci_dev_aer_stats_incr(dev, &info);
>> -	trace_aer_event(pci_name(dev), (status & ~mask),
>> +	trace_aer_event(pci_name(dev), bus_type, (status & ~mask),
>>   			aer_severity, tlp_header_valid, &aer->header_log);
>>   
>>   	if (!aer_ratelimit(dev, info.severity))
>> @@ -939,6 +944,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>   	if (tlp_header_valid)
>>   		pcie_print_tlp_log(dev, &aer->header_log, info.level,
>>   				   dev_fmt("  "));
>> +
>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>> +			aer_severity, tlp_header_valid, &aer->header_log);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>>   
>> @@ -1371,6 +1379,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>>   	/* Must reset in this function */
>>   	info->status = 0;
>>   	info->tlp_header_valid = 0;
>> +	info->is_cxl = pcie_is_cxl(dev);
>>   
>>   	/* The device might not support AER */
>>   	if (!aer)
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index 14c9f943d53f..080829d59c36 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>>   
>>   TRACE_EVENT(aer_event,
>>   	TP_PROTO(const char *dev_name,
>> +		 const char *bus_type,
>>   		 const u32 status,
>>   		 const u8 severity,
>>   		 const u8 tlp_header_valid,
>>   		 struct pcie_tlp_log *tlp),
>>   
>> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>> +	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>>   
>>   	TP_STRUCT__entry(
>>   		__string(	dev_name,	dev_name	)
>> +		__string(	bus_type,	bus_type	)
>>   		__field(	u32,		status		)
>>   		__field(	u8,		severity	)
>>   		__field(	u8, 		tlp_header_valid)
>> @@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>>   
>>   	TP_fast_assign(
>>   		__assign_str(dev_name);
>> +		__assign_str(bus_type);
>>   		__entry->status		= status;
>>   		__entry->severity	= severity;
>>   		__entry->tlp_header_valid = tlp_header_valid;
>> @@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
>>   		}
>>   	),
>>   
>> -	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>> -		__get_str(dev_name),
>> +	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
>> +		__get_str(dev_name), __get_str(bus_type),
>>   		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>>   			__entry->severity == AER_FATAL ?
>>   			"Fatal" : "Uncorrected, non-fatal",

