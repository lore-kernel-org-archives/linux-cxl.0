Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB92356B9
	for <linux-cxl@vger.kernel.org>; Fri,  6 Jun 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749213772; cv=fail; b=b7gdLdwME875E/YQANGnt/y2/xYqW7/t4Zu5xuoXLJ1DIHa5tAmT8YfRO9tFigEVfulVyhXZmmvP/dZohG6iq1nc4oO+Lkujqvj79aD/6LQ8WcySB5FCsqXUbYncOENUOe44+iH9gDrFG3UuGInHoNDMLgAW+DOOfBTmciBNcOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749213772; c=relaxed/simple;
	bh=1g3Md2dPn+DLfcez8VEz4Wq97PBdVv2YoLAOIqN2fpY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SOp/ffV1jLu97ZrxefMUVgQzb4ymLPfBa1gB8EDEp7mw8qhcGYDif/QN0PxiMUc7s6Wa097lcDshdeFXJxgo5vKZ2xDAD4kK6tXEEIG62XZTzJ2QrEHZTCzKnKczOX+znaTJR/yoK6jzwHniJehC418uhF5irw33zb10H+dkzmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LOCnDc1n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zqwl8y0l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LOCnDc1n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zqwl8y0l"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5565Ndfk003840;
	Fri, 6 Jun 2025 12:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=I7rbaIjoTiDUKF7rnavNQZvvceyFK/N4VxhmYxnohck=; b=
	LOCnDc1n10toOVtc8YGTaDaFSPz0jTmWmP2n/Lw9+BcF5k1oySouK2T4mb4g03Rk
	8XWtMMALn3yL5a9FFzTzzJ/+IYJquPKpTB1mPM5Y0ho91szbR6taDFNKDpvxGiqN
	/LHHaT8mtDXRxMX7jLgVN4BqIozs5cWdwPm+YhrruPzzhxhMy6TBnmgjNU+ip8HZ
	2Dyk+Hpby/Q2sx9qVg5LH5O9SflGZhWTXtbHrM8SbNN+b8DTe9gHgM+5LMpqklO2
	rsbF2FSmFAcPQ84eOLsrKvaQXafNd/6rwYSw1A0bSUPYE5hTsRnL7dtOB9NPIPcO
	RxCNlkCxrJLT1aS4T1XZVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gahg10v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 12:42:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 556BKPdO040638;
	Fri, 6 Jun 2025 12:42:28 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7dfuuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 12:42:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvjY4AI8QG4kJfQgrYrQ0cUXhoIAyUAyr1i0H0F/++D0zrSAlV3skmAA+MltXCXbUdZAHBIHsrJmfGK0homSxk/dgN1Kp8quoTOj/8lLRDcwUpX12tXTzOG+QZ4x6HOVsvjcRaiMX/aUt4HtVX9PfOH/CXVRixdwGOpyuaA79bv2grWbgey9GTe5/J3+SX+3V1iRrjN6WZi1S9koVUJ3TIN8LKmlgqmeVgnV18ZVyunWZAE80ou8BXwy6vqmRM1dNp/XakbMyP8ZU351k4o8MsxxPw/lTyuq1qIZpq/XXIXtUq+VYpFd6/hGrk188k5GYGD/jAM2i7mIN0QDzfutGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7rbaIjoTiDUKF7rnavNQZvvceyFK/N4VxhmYxnohck=;
 b=aCrVOkid01+EStbhSB8Twn2Fyp9/roaIixLXNWBtAxOTm+4paTpPLgMDmyvODLzgilj7euaQ+ImZ/1qZX8Qo46ZdKsiILp/G9pQicHDrrb+dbd0tdeeUKuCERfleTBOORSYALdhLeXJ+8V4xvOGojxMtLozUcFBreS35PM6O80oBPQJ4v555A2NQxBy0JAT6NNsDZP2WpeEHWlnH2FgS834aOP+/5j6KScMNsbpXuAEMadL0N6UnKGmTRUBq1gk1jcGrdCQswTCcnY+0ByW9qFPy9Pf50D23bv2VZuWFE9Bk0+9KERyc96iU/rkTaDccCYdp0jB8+ndWLh3aZpSmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7rbaIjoTiDUKF7rnavNQZvvceyFK/N4VxhmYxnohck=;
 b=Zqwl8y0lqSaXQE9FzBOrL8ZosSaZaQXFoQ4zLK/m4YLjl+ooOL+MRMijor9s9GnDEka7q0lB55R9tvxfHn5uX/nhetsu0Nc1JmB7DMLMDyS5D66HTiYjQKRzBH7TFBxBYO9Q1+tXhnKAEjur4rSRMACg5URx/Uq/1k1bblIbkYI=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB7390.namprd10.prod.outlook.com (2603:10b6:8:10e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 12:42:25 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8813.022; Fri, 6 Jun 2025
 12:42:25 +0000
Message-ID: <09aea84f-8c3f-4321-879d-35c8956b3573@oracle.com>
Date: Fri, 6 Jun 2025 18:12:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU PATCH v3 8/9] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC
 Add
To: anisa.su887@gmail.com, qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-9-anisa.su887@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250605234227.970187-9-anisa.su887@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 839724eb-15c4-4a5a-dc96-08dda4f796d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDRoamt4TTFya1haaTdneVBydmQ1Q0NibVVXWjVPd3ZkWFRrUHhVdHhha3ZQ?=
 =?utf-8?B?Nkxid1ZaRGlNZE9mUnNQY3REUkRvMGRPRDEreWFXc2REMXdqNStYTW5Eb095?=
 =?utf-8?B?ZEE4ZEQyVVNuM1lKTVVxd2Fad0RNdGFHNC9CQlJpMFJ3V1VHK2dXZTUwaVho?=
 =?utf-8?B?cU1FOXBuU1JlMU5FQmptOEpWbjdDNEtCNEJMTEx5UnJ0Nm1qUlRBOE5ENkJV?=
 =?utf-8?B?WFFSbWI4bzNVOFhWcThEaFdyN1lFcmpERzFUdGd5aVMwYWt1MmpiK0syOFR0?=
 =?utf-8?B?MkJCOWZNeTM3Ujc4RVpPVTVtcldBS2U4aTJHU2hXeGxBVm5KamF2U1lpbmVQ?=
 =?utf-8?B?RjBhck1IL21BMlFSZm5qME5sSWR1cnYza2pSV3lETWRNWWM2Qm1OUEQ1ZWpR?=
 =?utf-8?B?a1lqSTVPZjBEdXJudktLeUhhMUxBUDhLRVdhaUd6M1ZSTDA1S21HUU1Za1pD?=
 =?utf-8?B?Z3VZUDV5SURKK1I3UDNGbXVUOVFic2xZOGJGY3czcDQ3OG4vU2FVYUxaZEFt?=
 =?utf-8?B?TXd2WGZzV2VNQlh1UGlyaUtPRS9BUG9VUXR5REY5RUVrQmFJR3ZCQlV6Q1ll?=
 =?utf-8?B?NkdqR3FOMzFGc0ZidlIvM0dvNVNMZzhXV0phVFRTNmRNU2FwSWY4bUlkUVpz?=
 =?utf-8?B?b3F5ZUNpQWNyM0xCVmVEMkFDTitqOVNrY0VpbkRVZDZrcG1RZjNjTEVlYWw4?=
 =?utf-8?B?cXU5WklqcXBKcVdDUkxQc25QN3pQSitocmZ3bWhlaDN0OFU5YnQ2cys0eVNr?=
 =?utf-8?B?cGF1R2trb1VMblhwT3AwcFBVU1JFQzFkRm5IZExCczdLQXRLMVl2d0hVWVRq?=
 =?utf-8?B?UUhZSjBBLyt2eGRqaHlRaVFHd0tnZk5iNDZncHZWUk5QVUZBMGNxRGZuT2hS?=
 =?utf-8?B?QzRVWkVtRmt6M09PaWI3Y240SEhjcGtwcFVnVVMxSzk0N0d5M3JNNFBpZlNs?=
 =?utf-8?B?RkxVTGZTdWVLU0VvUkdUamUyVmk1Sm1XQzZnRm5ZT1hNeEVSTXZzREV4aXcv?=
 =?utf-8?B?dlNyQzZheVE3aGRGRDc0dEtvUkd0VnYzQnlZM3AxRmpmTjhDcXVHUjFHcWdl?=
 =?utf-8?B?czY0Q1kxSk9ac0Q4NXlGQkFqU1MzdUhkVXpOdnc1WDdic1Jxc3phWEFGRTdE?=
 =?utf-8?B?OE42NFh6VVVJMkdSSVRNQ3pjTHh5SlkwS3diNzhoRHJuM1FqanZLbUM1K1M2?=
 =?utf-8?B?TWV1VDdIUnNKSHZNeEt1ZExpN2tLMXZWQ1F0dGJxaFBDRXlhakFCWTFWUnJ3?=
 =?utf-8?B?Yjc1bUl5aCtJUEQzSlpWMityNHNMVGgrN2g3dmY5TXo3QlVmcmYrUXhuR2o2?=
 =?utf-8?B?dUlETllNTzZwaWZTTGU5S3RZTWFGRkVaNU95Q1ZwYnBRNkRaM3JFN1EvYUNs?=
 =?utf-8?B?ZHNrdjMrNlZTdjRHYVhEaHk2WUQ1aGxDemkzWWtlb3R1V1AraVpHeU5Wclgy?=
 =?utf-8?B?Y1J1d1ZhYW5ON01UTWw0andKb2VhaDJTVXB1dUhrNFFITHFBK1k1WSt1WENl?=
 =?utf-8?B?djdGNmlQZ2xjZkN2cURvR1NkK2NtL1BqLzFTWnhuVEthMnVGNFZBa0ZDOG8x?=
 =?utf-8?B?d1I1VkJBUUZ3L2UrOWo3ZSt2UFR0SnB5MG94ZUl6WEdoaU9qSkFodEpjRjQ3?=
 =?utf-8?B?dEdEalY2TXlKQWdsZTR4VGxLbHNKNTQxbVZWNlRhUzYwRXg1bXE0OUlsdlVL?=
 =?utf-8?B?c3IwalczY2RkSkhQT0tYTkloTWJUdFl3YjlvOXN0VFZkc0dkSlhyRjNNdlRZ?=
 =?utf-8?B?WDF5MVhhUnRQc0hseXkreTRpMm9PbmtMaUkzczNNT0dnQnFEQmhsRzR3Uloy?=
 =?utf-8?B?eUFHUnJrUTNzb1BDeUhMMG00RlNZbWFEclprTGpWMlBVT1liM01CRXZXakpD?=
 =?utf-8?B?cStNYnFsL3JMZ2lLQzQxK2pwZ3U0Z3ltdDNabVNmNmUvaUVkT0NOblBmWVJw?=
 =?utf-8?Q?a5FfNMczLlU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk0vbDNOMU8rVUNEM05iTDNpMGZNaHBHSGFHUkVPN2FFcG5Yd2ZNUVJma3g0?=
 =?utf-8?B?aW1ERzlmVTBzKzhYTEdoM09UK2RkTngrRkZwKys0SzZ6TFVhMkNDMlpZbCtv?=
 =?utf-8?B?bWFGY1hsZnJQQ29MMUo2bXpSSkJaWHJPMktVcVNoYW9pZEdHZGZVR2FHRzNj?=
 =?utf-8?B?dXhJRHMyYUdhM2N2SURPdmUzUThuWTlOMXBIOVpRanF6c3NxSmdpbDNBV3FW?=
 =?utf-8?B?NUpKTHRUTmVlMWJhWk05clhELzhlMlMya2xlWVdncFp1ZlJOc25VQ1VweldD?=
 =?utf-8?B?UTBtakFqY1ZMc1FIbVV5MGtFb0ZHUGhmNUNQUm1OSEhPbjBKWUtCVFl3c3Br?=
 =?utf-8?B?QVhjM2lYSndQeDA5R01tZ2Z0RWJWaVJlUlFPZmVVeHpHaFdYcHZRamQwbUJD?=
 =?utf-8?B?TFA4UEtEYzBlVythOGxGVllEMGZkSTZvNjk2VFVJKzcvYi83ZDlJbXU5eGpJ?=
 =?utf-8?B?LzBxNW4xREtCUGlVOGRzd045L2FCblVJSDdjem94VDNveEdIYVdhTWhrYVZT?=
 =?utf-8?B?REtxaVZESkJsMlhyS1VwMDhnN1M3eGxKc2NRMjRZVVF0aU5kemVVSnpjWEQ1?=
 =?utf-8?B?NTFRNnFrTzZ5NThOeUVYMDdHb3VBM2ZtUGJ0UXZSM2tPY3BFR0piVll5L2tE?=
 =?utf-8?B?WHhhMlc4bkhhQkVDNG9ONG9IbG9PbEppbE9xOXRKMVU3d083QU8wYWMyZkR3?=
 =?utf-8?B?aWFkSUJqRlJJeHA0aWJlZUt3YngxeGJ2QkdlcTdPbzh6eHc5ZVhGNXNtQUIr?=
 =?utf-8?B?V3pncVBxem5WaW5TbWE3VWtkb3ZWZnVvK2MzSEo3dGtpcEJLbGkwYnZCckJ1?=
 =?utf-8?B?WEw0L2hrdGNGNXpWUUszcGdNZHdyM09jb2VibExOcm9BUm1lTXY1QVp0anVm?=
 =?utf-8?B?ZmkvQktpamVVQ1dEdFZXTi9BaWhKMktxZTRYM1FUb3hqbEpnVnJ6ODVndm9C?=
 =?utf-8?B?Vkh2RTg1R2ZrM0pqM1UwakFOM0xWWHM0eFhHNVl3UmRLYzRXaVkzSzB1UG96?=
 =?utf-8?B?V29WN0U3VXVVSlRiakVZMjBLa1Vwd3VoNU9uQW9DS0RyWHJjVGRCUldZSmM4?=
 =?utf-8?B?WXlmUTU0ejVneE55d2w2bWVEMXhXMTVVQ0Vwa011bGZ3ZDhKRXJvemtXWmxJ?=
 =?utf-8?B?ODZPRnNlTmtUQUMwbi9UeVgxWTFCenVTSlpTR3JEY0NGaGJIbGlTT3F0U2pI?=
 =?utf-8?B?L2w4UmtYQ3NLUEtWa0FwQVR0TGhtQS9uNDBsbllRandpNThJSVh6WjBWYkRl?=
 =?utf-8?B?eVQydFJOeXh4UU1pR0RvdXZ2cEg5MnJoUGRxSFhrR1JqekQ2akE5U3NQVjdm?=
 =?utf-8?B?U3dyaFJDaWg4dXlkVE9XQVZDNDFLa3ljRE9pSmVIUmdHUkFDRDlFRHV0eU9q?=
 =?utf-8?B?MXVCditjUzNyMjJqMURhemthZXE4VVhpNmY5OWJtWDhpeCtmdzN2V0VFNXRQ?=
 =?utf-8?B?dnNmM29rZjZPdnUycUxGd054QWhlU3FQNnRVY1hSeU8wYUxhYWgxQ1JsN3V5?=
 =?utf-8?B?SHFHWUtzMVJ1aWVOUlF5TzRlNWlFSTBDSG1hWEVLTlZPOFN3b3dHSU1NTFVB?=
 =?utf-8?B?NDJaZldiQkhhZmpROGxtUCtUNDJybVhJN3dNUVllWGVDUksraGR4a3ZId3Vx?=
 =?utf-8?B?d29STElYMlc4TlhVQlN5M1MzeXIyYkxRT3Y4cjQvdGlrRVNaSjNBWk5MdGhL?=
 =?utf-8?B?MzdjcDVFTGFqbGY3aGtSYUt1bStvZXRMQzFXTStiMXdCYjRzRFBMbG1Dd2Z0?=
 =?utf-8?B?YkNnNk9vVGh2Y1pkVmk2U3FqSGZXV2tTZVdHdC8vdkdTVkVRRTI2Yms1cGhj?=
 =?utf-8?B?TFl1OExxV1BtT1BwdGcvZmtlUksxNmIyZVlKNE80K0Q2eHFPeC9PV2VCdWJH?=
 =?utf-8?B?RTdGVzNUT09XSkFBd2FGZzF2NHVrR3lEQWVtWUJYU2hKa1ZmS0xZc3ZIbHY5?=
 =?utf-8?B?dGVaYlNYNjQyUnE3Mzgrbm4xZ2QwOWQzVzRXUUhTZ3FZUGZXMm55bkN2bWU1?=
 =?utf-8?B?VzdLVllWcjA2eVhSY0pRRElBaU1xMGVlelNVaGgzVFY3VGRyM0ZnUFJjSCtQ?=
 =?utf-8?B?NjdjajcvaDRyY2NKL1FXVGFITnJha1dRS0lkMmhpSC9SNWUrakRuWCtuQ0pL?=
 =?utf-8?B?MkxRT21vdEFoY1lBQzBSYVZRRnNrU0hESHB5dDllSHNqUUIxSWU3U0JZS2Nr?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QKZpg7QrycAQyQuiSNRPrnCnn/9oU7reNE3npqCmFNylttCl9wHhykshkxhLttaWZVQ8qPRWP7iZUvDZI/fyBsSeFuj0jtOBH/2fXQKausH/G+dRadxtn3eQJBoRgHTf0KPbwFZkp6O8Y5LxtKt1O8jyeaENVhlS90/unTsiPrW5QICxAljV92Pndqqu2VbGC/kwcrLnT4rLnc9CUNMToY+ImXBM2wkKhzbiBjViC/8Fayfn/WGnPJwMz9O+R9s8KbQilvWHLWBgdOLiLS/9fXJht8pkxtQiMt8Sf9I8Y66QaSlO1jJccXeMfCbMlFdlOwSYPiQ2tLz4TFDoIG4viODfnK27GN9iN8GFEYWzG+uGDDecbjtX5ipTcbcIbPUynY6fPYHzN6ePQaUFI5UZhD9t2aEMlvnJyKiO7gLMrdZ+wzWvJRlyvvx4n56zKIg4tYOn0mvOe/hQQu1PXwZD10vQL/W4a/X5a+SLG+hgdvqID0pbrSiOZG3T6DR24bkRGPBt1tyl32LEBvwjkxktmHrlGphmMzlpeQ2NfoPvRQQCORPnstanhl0I4VD0p+oY+qlYDsqyC3+OvT8Nu8hDa1KexJ7OqRUgLDgTjWHjkSQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839724eb-15c4-4a5a-dc96-08dda4f796d5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 12:42:25.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToteRIrFm9HotQoYmUtpPohWI6uc7Vo9YWK+DpuN/lwF5j5cdAQGFzfopYaAkR0/ufmg0y+pvtAcH0DOj4S+9Ri58m4ZC+WW4L0uLR/R2ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506060115
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=6842e234 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=hD80L64hAAAA:8 a=DrAQ8POq5_-BKBUsKt4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: f1F9VicWq7pOzZ7Pzz61aXFup0Cn4xD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDExNSBTYWx0ZWRfXx7MjTK6kfAh3 +HOIPRgWFikUecBLdRWUOcvdV5mFCFt9vmURgC7FfW31CtcmNrd+oB3IcB5hmk8HBf5tKliM3Dd calJVCkB+7CnLIoQXMcBj3ba8g9GBa/WGJeCk2SSuwGEjrX+xpoZRjYPV+GQG+tFFAEdI0EUTpI
 mY13aR/wbw61HRahx95CnfXFztLpD/+DC/VY2G6/GtufVvrn8dcRbtLvEziB6xehqSBNFhL10yC vgHQzk97S3txFoNjaeR+pbVTiWkxPjdztghwlmeqmmbqE99VXhJj7LFjCMJIe6BDxrwhz1gp5ai MWcJyw5cMWwTXIKadTi8xFQPnwsCTv6JaWGWvxlRRIgYmHH/Y9fC69VbehM8A4lB0wTsJtYxSvo
 PU6hGPNigYmwjfE3wwtZEgO8vZLl/8u0Ev7W1YOiRPkWwP49r75C82UnS8EqADffWdMGxWw8
X-Proofpoint-ORIG-GUID: f1F9VicWq7pOzZ7Pzz61aXFup0Cn4xD7



On 06-06-2025 05:12, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c  | 152 ++++++++++++++++++++++++++++++++++++
>   hw/mem/cxl_type3.c          |   8 +-
>   include/hw/cxl/cxl_device.h |   4 +
>   3 files changed, 160 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 004e502b22..7ee5be00bc 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -123,6 +123,7 @@ enum {
>           #define GET_HOST_DC_REGION_CONFIG   0x1
>           #define SET_DC_REGION_CONFIG        0x2
>           #define GET_DC_REGION_EXTENT_LIST   0x3
> +        #define INITIATE_DC_ADD             0x4
>   };
>   
>   /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3540,6 +3541,150 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>       return CXL_MBOX_SUCCESS;
>   }
>   
> +static void cxl_mbox_dc_add_to_pending(CXLType3Dev *ct3d,
> +                                       uint32_t ext_count,
> +                                       CXLDCExtentRaw extents[])
> +{
> +    CXLDCExtentGroup *group = NULL;
> +    int i;
> +
> +    for (i = 0; i < ext_count; i++) {
> +        group = cxl_insert_extent_to_extent_group(group,
> +                                                  extents[i].start_dpa,
> +                                                  extents[i].len,
> +                                                  extents[i].tag,
> +                                                  extents[i].shared_seq);
> +    }
> +
> +    cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> +    ct3d->dc.total_extent_count += ext_count;
> +}
> +
> +static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> +                                                         CXLDCEventType type,
> +                                                         CXLDCExtentRaw extents[],
> +                                                         uint32_t ext_count)
> +{
> +    CXLEventDynamicCapacity event_rec = {};
> +    int i;
> +
> +    cxl_assign_event_header(&event_rec.hdr,
> +                            &dynamic_capacity_uuid,
> +                            (1 << CXL_EVENT_TYPE_INFO),
> +                            sizeof(event_rec),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +    event_rec.type = type;
> +    event_rec.validity_flags = 1;
> +    event_rec.host_id = 0;
> +    event_rec.updated_region_id = 0;
> +    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
> +                              ct3d->dc.total_extent_count;
> +
> +    for (i = 0; i < ext_count; i++) {
> +        memcpy(&event_rec.dynamic_capacity_extent,
> +               &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +        event_rec.flags = 0;
> +        if (i < ext_count - 1) {
> +            /* Set "More" flag */
> +            event_rec.flags |= BIT(0);
> +        }
> +
> +        if (cxl_event_insert(&ct3d->cxl_dstate,
> +                             CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                             (CXLEventRecordRaw *)&event_rec)) {
> +            cxl_event_irq_assert(ct3d);
> +        }
> +    }
> +}
> +
> +/*
> + * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
> + * in order to reuse cxl_detect_malformed_extent_list() functin which accepts

typo functin

> + * CXLUpdateDCExtentListInPl as a parameter.
> + */
> +static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
> +                                CXLUpdateDCExtentListInPl *extent_list,
> +                                int count)
> +{
> +    int i;
> +
> +    extent_list->num_entries_updated = count;
> +
> +    for (i = 0; i < count; i++) {
> +        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
> +        extent_list->updated_entries[i].len = raw_extents[i].len;
> +    }
> +}
> +
> +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */
> +static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t selection_policy;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLUpdateDCExtentListInPl *list;
> +    int i, rc;
> +
> +    switch (in->selection_policy) {
> +    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
> +        /* Adding extents exceeds device's extent tracking ability. */
> +        if (in->ext_count + ct3d->dc.total_extent_count >
> +            CXL_NUM_EXTENTS_SUPPORTED) {
> +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> +        }
> +
> +        list = calloc(1, (sizeof(*list) +
> +                          in->ext_count * sizeof(*list->updated_entries)));
> +        convert_raw_extents(in->extents, list, in->ext_count);
> +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> +
> +        for (i = 0; i < in->ext_count; i++) {
> +            CXLDCExtentRaw ext = in->extents[i];
> +             /* Check requested extents do not overlap with pending extents. */
> +            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> +                                                     ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +            /* Check requested extents do not overlap with existing extents. */
> +            if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> +                                               ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +
> +        if (rc) {
> +            return rc;

is list free not require ?

> +        }
> +
> +        cxl_mbox_dc_add_to_pending(ct3d, in->ext_count, in->extents);
> +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> +                                                     DC_EVENT_ADD_CAPACITY,
> +                                                     in->extents,
> +                                                     in->ext_count);
> +
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "CXL extent selection policy not supported.\n");
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;

CXL_MBOX_SUCCESS, this is unreachable

> +}
> +
>   static const struct cxl_cmd cxl_cmd_set[256][256] = {
>       [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>           cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3667,6 +3812,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>            CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>       [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
>           cmd_fm_get_dc_region_extent_list, 12, 0 },
> +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> +        cmd_fm_initiate_dc_add, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>   };
>   


Thanks,
Alok
