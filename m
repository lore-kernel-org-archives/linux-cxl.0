Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E71C27
	for <linux-cxl@vger.kernel.org>; Fri,  5 Sep 2025 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062122; cv=fail; b=nlge+ztCUEqBjIE/o0V3yhxNlqJRdIpgWWOgd20XZX/9m4j042wG+aod99tgBhsLXY8qvpM7q35f0rD2GRIox23ftXfpTeU68cW9Xt8AzqZrciKtnA+a8Y56fmIKeV/OC0Tf+M/3gB/rS+ZrSew5yto+hXBhS/CDJHOeSJvFrPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062122; c=relaxed/simple;
	bh=r3Tv+7AuLLgviDPhPMDFLpyLWAi7C/0qFW9j7ZVr4kI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TBRlz8hMHRLHTOA4CtvRuv1NUBtQ+Tao3v8+XpM3q3Rfno2OkmywtDKdVER1SaadgVj/OzsEOe6Hqs7IlppJ0duC2ZE7iS01VrfEkV/3UlGDpbz+NlZeEOelPYmCRCHznCATzrq0uEuv219+BTLdshvUrVCwB0zzjRpefe8VXOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vn2LF64/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f1VHxXMf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vn2LF64/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f1VHxXMf"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5858Tl5P009759;
	Fri, 5 Sep 2025 08:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7kf7KgC/Dem9Q05y0mtZJ5NN5FmYyTnqt8WqOf/6hls=; b=
	Vn2LF64/hIgW6PSAZjNPlwLqhOxyJsOpbUx9MpNS+hpRsvhT/938AAhhkAU1HG/R
	FUFtn0trAw4DfkVY5Xu30D6vZB7r4Nl8SRPWjj/rGXVmo4qC/hiSnW5Yefb243md
	C0p/sSarb9o6IBg5zUagrGi8mMj0OjYoC2O4N6LT8AfneUM+QXqYLLHoeqf8Q6Uc
	s5AshYWITW7TCTzyNmDNhWDaSoK61NwnDLfxH4PNSYDs7NyImZr4QjpqHNBWaLcB
	dU5clD54UNdHpSHSrTHqRSIR5YhCaKN8/uTDQ67Hvi4Ys1YglmohUbxRtLUfsNkL
	dtxI3O0m2ERnodewZfiPLQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yvd8823w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 08:48:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5857pcFC027087;
	Fri, 5 Sep 2025 08:48:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrjyare-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 08:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WynmmwYO9O1A3ouk2gs/fkdx/CgmfwFccrm5IULPp9+uxoirsEXnFxeEcVSx/xy6EztyI1NsVYQlYTLfGRezSGYRzh3hZNPhlfDodxidKW0UB6yw/Kbok+JytJ7qNqtuzbfgPqqyk5w6hB5W8RBlV4Q/4c20+g0B2xNvB/hI2SnEGDaL45vuQcgDDcQLESKImy36CVIP08t02kUgaLsmlStRvvVb0CXwcEPgaHlLmmczLxzwlWVYg29D/euubwHYL/LJRg27LLboDxtYGitEiVu3qO8aZgq7CFN1Hc98t0O8gX0xVVNkGYDrkOw8OPm1aS+s+mv8MzL0s/oeOhR4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kf7KgC/Dem9Q05y0mtZJ5NN5FmYyTnqt8WqOf/6hls=;
 b=HNVevbUNjE5fAxQy53Z9KywuCEV4lW5A9T0eU+9vFmVIA6wmMJMBZaAtpdsilFq1t+RHNDuCnVctvhW1SzHpsxTiE04L3I0c+40RoN5P2C/974ApFZTjeufFYLKGEms9Kx9eK1Way/d6NosCilmofdaYmPWZuQ7fBEEUlQP3lAR+7/pWUeEwCTQhr1/T1AQZ+DB4Pz87t4akpB2+yVKF6ZZu1W/vjHMgdtymmMSO3QRgACvqoj+IYfsFJ9XGMzOgCLHPEBADMylFJYL7B+yPLn06p4TBLL/P+1PY+XXdBzxcvxDBES6564YgBd/T2PWvP+ClEpqYTZkIvRjcH4EFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kf7KgC/Dem9Q05y0mtZJ5NN5FmYyTnqt8WqOf/6hls=;
 b=f1VHxXMfCLjp+AaHb+fSSJMyRDGHgHKzYVPMVaGn8NBMSr0onaN027355CRh+EQE41aTlbGV43jdzjpOscvoyiz7LNaQffVqU632KliEcd41bTFOKK3qBs2KxeV2CB3OqXRurf4bhmBozPjGJGsC56h3jvPCp8sym1FN/kLxxzk=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CY8PR10MB6755.namprd10.prod.outlook.com (2603:10b6:930:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 08:48:16 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 08:48:16 +0000
Message-ID: <2d731c30-bf0c-49c6-b519-4b558d794b08@oracle.com>
Date: Fri, 5 Sep 2025 14:18:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
To: Arpit Kumar <arpit1.kumar@samsung.com>, qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com, vishak.g@samsung.com,
        krish.reddy@samsung.com, a.manzanares@samsung.com,
        alok.rathore@samsung.com, cpgs@samsung.com
References: <20250904131904.725758-1-arpit1.kumar@samsung.com>
 <CGME20250904131944epcas5p351c0e073a975b1347c4a61aa0dd511f3@epcas5p3.samsung.com>
 <20250904131904.725758-3-arpit1.kumar@samsung.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250904131904.725758-3-arpit1.kumar@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CY8PR10MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: e03f676e-c611-4804-30b2-08ddec58f4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dStVQ3RDN0oxZCtmL1BudW5RLzQxQml4VjBjSUlvOVNIVzhyajRGcWFoc2d4?=
 =?utf-8?B?dTZmbFV4MzhjUjkyWGExczdXbTJjSXV0ZytCV1ErckVGbHhLSXFzYklyODR1?=
 =?utf-8?B?dW11RkpPUWpjOVF0WmlZWGp6Nk1DaU9tNWl5eHRWVzNGK0pJZW43ZXIyRmNo?=
 =?utf-8?B?dzlYVFlpMVpHclZsQVNTQ1pqYy9oMysxM0QwVFJCUmJnZGtRM3dUbkFGSjZB?=
 =?utf-8?B?a2xFRnlUalozNnNpK2dhVlpDQ2VBcVhVaGNQQ0grTzU3UXdMck9STmtzSi80?=
 =?utf-8?B?WDBBeEVDUi9rOVdKdjZ6S250NVZJV3Rkd1ZDQ2FvanJPQjRIaFRNQVZ0bktw?=
 =?utf-8?B?Mjc1aG5ZKzQ1d25GRWd6d0JnbS9rTjhtUndXWVlMY1JUNzR1My9hUTdldnpx?=
 =?utf-8?B?QU9ocXZFRWZpZWlJVWdmeVBQV0tqWDU4L2pSS2JqVTF0MkdZbEFscnNlK1NJ?=
 =?utf-8?B?Rzlab2t6enJHZXUwRlM4T0MwVXVxY1RBUFdoaWlUS0I3eEEzYnVaOEdQZTQ5?=
 =?utf-8?B?YWZwT0prMVFtSTU4YTJUVXUzWFJXUVN3R25LUFBLT0FRRXJJSDE2N1NBTTJP?=
 =?utf-8?B?Y0FTM3ZEZWxvRkRXOEJZRkNNMW44bEYxc0lCRnlWRXM5b2M2YWhCZ1hzT3RP?=
 =?utf-8?B?UEExN2tvZCtPaGRaLzVoaGVaeExWUzZDZmo5U0tHZ2ZkaWEySXVRM004aW5S?=
 =?utf-8?B?WG0reDZkRERaY1V2NGNLQUIzcWp2MXJYa09pcUZjTmR6ZG9TRGV5NWtaZHoy?=
 =?utf-8?B?Y2pKL1pKcitueUd0ZnhRNnVjOTFieGI1cDVydVBtbCtwbThFa3JDS0tNNW1m?=
 =?utf-8?B?TS94YS9MbEJ4RldtdmZlZzhCaG9pNTZQQllqWElYREdsQ2ZNZW1TYXZuS29C?=
 =?utf-8?B?WTNDR2lEM1ZRbEtHbCtWbm55bW9WZkpaYmpWdnBOR3FCM0lGZGZ6SVIvYnQz?=
 =?utf-8?B?cmpTd3ZZRTFvWnNoTTFPS2wrTWFKTjFINC9ZUmh6UmhLNzRuc0xsRndIVTZJ?=
 =?utf-8?B?aWNjdzVlOWRaNjNCSnYzZVBMVTlLNEdncVA3SGsyQjZUKzVOMCtzVHFUT2Uy?=
 =?utf-8?B?WDdVMzMvVHI0ZTI2b3h2SVhUc3R5K1dQaW54SDEyczZiRmMrMU5xYlNxU3Bn?=
 =?utf-8?B?YktpRFNscTIzMDhXbnpHL1ZkV0tha2VqcThzbkRmYm1wdTJXQ2RsSCtxNGlR?=
 =?utf-8?B?cGVxZTJGRHVqdG5ON1ZHRDBrV2RTVlpPK3BhWnRMZU5TcnVxOURBM3o2cjkz?=
 =?utf-8?B?T3RUYVY3c0pLTnVqNVdsN2VnalErT3k1WVVsQm9iUWJ0QXg3OXkrQ3NjNGpn?=
 =?utf-8?B?VWlhdHZ5V2MyWGErWTZyT2RTNVBIT2ZsMlZ6aHN0Q01LZE42bFZqKy9ObUNI?=
 =?utf-8?B?UjJ4UnFZTDN2TVF3WEswSEQ5bVNXakpNWDAwaHlIR3pzcmxKRFVCNndUS2RD?=
 =?utf-8?B?UnQ0SlVrS2Vqc3JhSSsyTHJPMmo3anNVaUw0c3dDVUVNM2dUZ3pUYUVUZFNz?=
 =?utf-8?B?QXJYaTdNb1RQV2ZWQmNEK040TFdXdXV5dXNEY0tDbEhkSVppSVcwSUFOMTVQ?=
 =?utf-8?B?VWs0UUtIUjhYZGg3WVVTaXRjUVFDVzdxUlJTeWluZnVDSVUyRk5Nc1VQcTNT?=
 =?utf-8?B?SUkvN2lMa3B3Q1pKQzkyZnZGdjRzZ08vZjVkMndPU3lDajIrY1dCNEpNOFJQ?=
 =?utf-8?B?dTd5a21KdWJNMnlmMmZWaitDL2Ira1FuT2duSlZScUtqQ3hEM1N1dmQ4VUEv?=
 =?utf-8?B?dmFrUytBMDhrRnBQNE5vMXZxKzQ0ZWorb1ZSc3N2TU1ydEl4VnNpOHhCZEha?=
 =?utf-8?B?ZjZ3amhUTUh0MWJvYzdoOGdpMWk1SkFUUFJFVEpEUnVhNnZCeCs0YWhiVDBr?=
 =?utf-8?B?Um9XdTNsaHZoMzRHNExhMFdrVDEwQjZDd0V0TzN0YVRBL1kzdkhPS3N5QmtR?=
 =?utf-8?Q?5IDM5QxxPRg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjVzdlcrazZJc2dZRlAvaTd5c3hOWWdxN2xrV2dEaEtsVHlNL2xBZFZzR2Nz?=
 =?utf-8?B?L2tERmJaUVhuWEI2M3YzR0lwTDFEalk0dFc1YUNqNTB0QXhuekVWcWRiOHh0?=
 =?utf-8?B?NWV1YkhjNVJzODFBU1JZWVJtK2VLZGZ0aWZvTElZVi8yMVk4S01BandXREhI?=
 =?utf-8?B?VUYyMlNNQkoyS0R0dW5UVFFIRGlIK0lremRqQUxXaDRPdmhyU2llY2duMmwr?=
 =?utf-8?B?RWErb0pzU3VkbVU1T2phNXVXMlJtY1k5Zzc5RTZSQ3BTUC9XbjhuOEU5M0JH?=
 =?utf-8?B?dkZqYU5CU293RGFEQWZDL05lWGFDQ3F6SlNVcUVtRFN6WlIrT2gvTy9LVXhQ?=
 =?utf-8?B?eWpSRnIxZnJpaTJOdlNlakx6Tk52UzdmRWR4aUxTNFlQSTRsd21sbkJZbVNN?=
 =?utf-8?B?bC9iSjNaUHN0Tk1ncmhHWlByenlyT2Z3cllQRkdDN0piVm0zMzRsYTQ0WFoz?=
 =?utf-8?B?VXI1cWxzNXVNUVNpa0hhTnVuWWFMR050Z0tXZjI0NUcwaldCTTRLejJxNzhV?=
 =?utf-8?B?REVuQkljSTlKdFVFUjVWQWVGODBTUXIzM0J1Tmcrb2NCT1ZIRGRIVGhpMVc3?=
 =?utf-8?B?blg4SGtQMll4Z3REOHBCYzdRQlh3UENiWFNDUkZCNGJyMitZMWZhbkt3Z1JC?=
 =?utf-8?B?K3FnT0lZY2lsWVdnN1ZzQmFCZVlNa2x3RUJGMGJLVmtySHZrT3NhUnkrNHlp?=
 =?utf-8?B?S28zUVlDVTcxSHFLZ1JLSVJDTFFFbXczQUJrTXdRcFo4Ri9tY3NRdThWZ0t4?=
 =?utf-8?B?NTBFUTJSK2UxY3ZzUEljbUFNMFRXMTJsWmw5R3BvY3VqZHp0MUxuNS8ydUFr?=
 =?utf-8?B?YXgweVVXRFRlbll2bWUxOEdFNm1ObGovam5Iak0wK0RlZThqV0JiN3dzMmZQ?=
 =?utf-8?B?TzVRT2kwY0dhZnZiaUxrMHg4OFBweHFGUzlTS2xTRnRBaFlRRi9UUFZQQUJt?=
 =?utf-8?B?N3NyUURGdXpZZkUxWWc3UlU3cmlQRHZvdVBMRmJHV1FhNS96ZnI2OFNFaC81?=
 =?utf-8?B?MlFOaWhFKzJDNnd2bEpsV2VYdnhTVzc3MWh5N21qRm5TRThUcGpDNERrUTVn?=
 =?utf-8?B?a0k0MFYvVmFqNnU2bkNOQ1EzMVM0dGV4cUZDVC9TTzBZWHYrMG54SXU3aERD?=
 =?utf-8?B?QlpBdlZxc2VyVXhReXduK1RvUDJjN0hyMnpBckxtV21UYkVqd1ZlQWtNMi8y?=
 =?utf-8?B?QlMwbW1CWEtHclhCeHdTSk16bWY1ZGxNVSt3cDFRaDBrbnpsS2x4enhqMHBJ?=
 =?utf-8?B?NmkxNU4vOEhwQ0hYSXZHdXpjSWFkZW9malQ1VEU5VHZoaDNzTVRQSVVBUExR?=
 =?utf-8?B?Tno5RGllWFdtQVNkbyt2dHNTNjB0OEcwb0d6K1dVcHFob0xNN1lTUjNjUnRB?=
 =?utf-8?B?TXU3SjVvNkNMSGo5MkhwNlpQcTE5NU5aYU41MFNiNHp3THFRN2tHdXQ5SG5C?=
 =?utf-8?B?a2JVZlVBQitFRE4rWmlFY0cwRzgwSVVudDZhTzVuMGVmeTJBemxMeUl1VWU3?=
 =?utf-8?B?WmdLQzd3NDlmVVRuODlGRTdVZkVaRUl1WHQ4VERtNTBsejBWdk1YcFhwSzNq?=
 =?utf-8?B?ZldROU1iU1g0cnA0WmtZVmc5NWRMTzJybzMwWnRma2xRZVcwdENnS2FnbTdx?=
 =?utf-8?B?V1BYZWhaNmlxMzF4SzRYeFlLZko5YWFvMjBZTDZ4TU44clRaRytCVHdtVUNR?=
 =?utf-8?B?ODhLcU4vUE93dDlTTGgzRTBUNi9VVzhvUkFLLzVCRFo2OGtVUTdUZWVwWk5R?=
 =?utf-8?B?L1owVnQxV1E2TzV1ZFgvZFZQaGdqMEVSdTlFckVWcUxnNDB4R2FEeUFrVkt1?=
 =?utf-8?B?SmQ2VDFXOWttL3hzRnVBc0lwL2RGL0lJR0VQVHp2dm1TRzB6dXhscDNyVk5y?=
 =?utf-8?B?dmpXenhQTGh3NUprbC9xRldLZEM5S0x4ZlR5TnRzQ1pVbkZDc1cwamxGbFFw?=
 =?utf-8?B?MW51eXNRNi8zZFVXeTNDclQ1anBTU3gvaTQxVDBQT2tLSnZ6MkFWRUxvV3Rm?=
 =?utf-8?B?TFZGa0FmYWE1ZVpLdHpsU0JONUF6djFWWW5xVTN1QWR4R3l1NnNHOFQwNElL?=
 =?utf-8?B?V01lYnBZU3dlQndnQ254WUg2QTVWOVNnNTdDT1ZSVUJMWW0xOVlkVmx5aHBL?=
 =?utf-8?B?SXhZNit3dHMrMzM0Y3BEU1U4OVlaaGNZd3ZLdTgvTG5YVkJGV2VhS1FybjVs?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DJ6IP5/UeI4nW1xUHXjlYTpycTqlIPEqigjJFuLZc4ECmy9pwYy2ANeVRhRobg3dIxPM+Maonyc+Gy8x0ukcW6QEkX73mGAdQZhRdva0ZgiSCYoUmZ5w3N80LDFfc1GkQohfnoLSidw354bD5+9dGBu/1uhvqL66nUIoflPJPzPg5UH1DNS5xZvjucEOzJp2w5eamnM1St1V124t25OqAkzOREpfe18fWqstl469EB/T2J74ypigIKXMa4YF8jvfBl9rvSFLAPjl6UuDT9qNf4900KJKbnO3iUjHxdBfEjqkG+7W29FcvnCNNucAzu1uCXNbcqdmFGeXuUWWqkBnod7QgPKpvizh03j5+aGeS4s4FtaTpwcROpXDj3byAARYadRb/G8UH/P3kbgeP7s6L6c6G6LycqwcWLMzCaqwMOU+xwbx9PEmKgD53rbkx0rVfeQpBWljBfX4pqanu3SObfyWjj2XNqBI4LJGNmlZuAMVRGc3juaxfcXaND0qrlepRi6E8U0T5t/mbdx1P3Z5KSD9+LYoCASKA4712dsqbQmWW8mUalgJysEDnDmSNpuMNaNG5ZRPJfC/Fvbwlc+nggHfZsEhnUwLhXuPkjmb9Os=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03f676e-c611-4804-30b2-08ddec58f4b3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:48:16.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc6H3jzLaoRwV5KiHr9ogZ26vtsS4UNi0MSoQ1Mtn45w/m+mEtnaANC5LPNGcwdecKcjDLEa2e0GF/OfEefop6GebFRThtKgCcqlexTYiIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDA4MiBTYWx0ZWRfX+cCfQ6svo0Yi
 m9gXoR1qm9c3xK4tXmgSdMwAlVF2PHAxtJWWm37PDhMFSrJrb/G8zIrnje4CjAoffGf2b+lwt8u
 SE/r4TiaPt7spzA0jYgN8CATqfPc8dlSMPJCDaoWNFnmGFRiP4C8v9oo/0VJA11lvbAWdwAJqeb
 6XD3wMfjVJltLLzjIUbfcZYaya0KWnmMeSVOTFHxRP4EpBqV11H2CAb6CaYdefgb9yzTpKXfPFC
 ym0ygBRBfHk0oQb9MT/l38mdgFeCJi9BlhIbXbVfgqoHaHjAoZnoHRlK+Pxd0jd/M5WgDQTgRYI
 YSHvIAcpPjqTlYtegnFzWFlOnLO7BIsLoyz7jNQqESDgh/iKSKb0YSlYTb/LGsACQ8exs9b7kpt
 q8aayCkC1Oe99oyuCAYjNDUxTmpLWg==
X-Authority-Analysis: v=2.4 cv=fOo53Yae c=1 sm=1 tr=0 ts=68baa3d3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=FCE0kyX7174R-4GrllwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: zUWx4nBocGuXTIYmc6t8JAj-jjoKNQ10
X-Proofpoint-GUID: zUWx4nBocGuXTIYmc6t8JAj-jjoKNQ10


> @@ -4791,6 +4907,28 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>       cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
>       cci->d = d;
>       cci->intf = intf;
> +    CXLUpstreamPort *pp;
> +    int pn = 0;
>       cxl_init_cci(cci, payload_max);
>       cxl_set_phy_port_info(cci);
> +    /* physical port control */
> +    pp = CXL_USP(cci->d);
> +    for (int byte_index = 0; byte_index < (CXL_MAX_PHY_PORTS / BITS_PER_BYTE);
> +         byte_index++) {
> +        unsigned char byte = pp->pports.active_port_bitmask[byte_index];
> +
> +        for (int bit_index = 0; bit_index < 8; bit_index++, pn++) {
> +            if (((byte) & (1 << bit_index)) != 0) {
> +                qemu_mutex_init(&pp->pports.perst[pn].lock);
> +                pp->pports.perst[pn].issued_assert_perst = false;
> +                /*
> +                 * Assert PERST involves physical port to be in
> +                 * hold reset phase for minimum 100ms. No other
> +                 * physcial port control requests are entertained

typo physcial -> physical

> +                 * until Deassert PERST command.
> +                 */
> +                pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
> +            }
> +        }
> +    }
>   }
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 9fc720ec10..033d9bf11a 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -130,6 +130,7 @@
>                     (1 << 16))
>   
>   #define CXL_MAX_PHY_PORTS 256
> +#define ASSERT_WAIT_TIME_MS 100 /* Assert - Deassert PERST */
>   
>   /* physical port control info - CXL r3.2 table 7-19 */
>   #define CXL_PORT_CONFIG_STATE_DISABLED           0x0
> @@ -196,6 +197,14 @@ typedef struct CXLPhyPortInfo {
>       uint8_t supported_ld_count;
>   } QEMU_PACKED CXLPhyPortInfo;
>   
> +/* Assert - Deassert PERST */
> +typedef struct CXLPhyPortPerst {
> +    bool issued_assert_perst;
> +    QemuMutex lock; /* protecting assert-deassert reset request */
> +    uint64_t asrt_time;
> +    QemuThread asrt_thread; /* thread for 100ms delay */
> +} CXLPhyPortPerst;
> +
>   /* CXL r3.1 Table 8-34: Command Return Codes */
>   typedef enum {
>       CXL_MBOX_SUCCESS = 0x0,
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 5c918c53a9..5c31023590 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -88,6 +88,7 @@ enum {
>       PHYSICAL_SWITCH = 0x51,
>           #define IDENTIFY_SWITCH_DEVICE      0x0
>           #define GET_PHYSICAL_PORT_STATE     0x1
> +        #define PHYSICAL_PORT_CONTROL       0X2

use 0X2 -> 0x2

>       TUNNEL = 0x53,
>           #define MANAGEMENT_COMMAND     0x0
>       MHD = 0x55,
> diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
> index 3b7e72bfe0..4b9da87d77 100644
> --- a/include/hw/pci-bridge/cxl_upstream_port.h
> +++ b/include/hw/pci-bridge/cxl_upstream_port.h
> @@ -30,6 +30,7 @@ typedef struct CXLUpstreamPort {
>           uint8_t num_ports;
>           uint8_t active_port_bitmask[CXL_MAX_PHY_PORTS / BITS_PER_BYTE];
>           CXLPhyPortInfo pport_info[CXL_MAX_PHY_PORTS];
> +        CXLPhyPortPerst perst[CXL_MAX_PHY_PORTS];
>       } pports;
>   } CXLUpstreamPort;
>   
> -- 2.34.1
> 

Thanks,
Alok

