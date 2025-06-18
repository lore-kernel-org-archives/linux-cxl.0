Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF7204F93;
	Wed, 18 Jun 2025 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266704; cv=fail; b=XRDug90HLKsDjfU9KaoNuU7hpZ7IuE7KCiPwTAVAFvUHq8FRyrZqE2aJW5YS1ta5a1kR1nbFsH8RR/jllZQGCkC2RmHBEGyQN9jQyNGQL0RyMCotOYIKo/eoAfhyHDnZamFSX8nOvMm8gV04gMRpXTWaPQWE7Ytq1VgpIBAkro0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266704; c=relaxed/simple;
	bh=nmVqtSYD6nxoTkhB/6JtUvWk7/c9gNfo9QMc4CfFY3o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fhueU31GJrLtEQF929c8MYvGHNDpOCTGqVC7peU1kxEBxgpjAlVtomFF6VXN0VoYQlzzdsD89D63gSHyNjXsPhRsvsIYKvHekAQuH/B9KwO4fgmZUfsrgLwDoteJGiwIIdxndcB0W76cC32PVNwFoSA6yFHZ2gmt16y3j5ONeUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E4IdtgFM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B7+oCG6B; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E4IdtgFM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B7+oCG6B"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IGQY13022076;
	Wed, 18 Jun 2025 17:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3hbg6QKIKYU7Bj3Z7jhFBOTJUDQwrGLo7EdASr8H7mM=; b=
	E4IdtgFMsLmMeKkx3mo6mJtphAIO2xEVFN+isXo3kl3viv2VZ9/uURWWLYqouRxG
	SrB8s4o5KLlbKK7H0GN6eCXw1hFM7nRJMVFDaB5YvjPakppqD0YKCibm5nQX8Ksh
	RNWB+oFYNXLtyvsn4Vxi1o7e7mJKVAdXkke+3PBe/GhSKXlqsrYoCxMUeol4odR5
	A+0QLRqx7Za1yNxnoCwBzk+KfIep3rx9w4HcQfKDgjN/LoAwuGyrintKlaoMCQKs
	zZJ93+YHneG4BLsiH40NcbENkb2++S0naNuMtSm4ptR7Gi01bzzz0ylsdUjSITGj
	Pjv7vNpyrotb3ID6HMRrpA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900f0b9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 17:11:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IFel2r001502;
	Wed, 18 Jun 2025 17:11:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhawsn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 17:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grWQJNDbnAbpUeD1Lkn3zTjpEPKsjcmLMV3R/bb8gO97lCgHrnNEjasM3Y5fQqiyaUm5c9Dil4ugbVxMBAPUhzE2DpoCkcfhfwlW7vzkiPhp9jqeFK9CJI2mnLJ0W+pix6pMGEBPtmRamTQuT4ojMJ2vlbXuQWh54P6CRyjBNKkccmX16+O6aOObuiK/49CyGljxEB7zyoD6FHXW4D738rYkBjlvLO6fxWBgugkGsi9v02FhX27lAbnflk8OSOIIf/NrkEWgvKUVWgHpXPYOKJvVDcoxmXVJVJJgeGYOkdh4fBqYnAsBVcxTdJxLj3PszNUjdXEETACl4nNA6xF7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hbg6QKIKYU7Bj3Z7jhFBOTJUDQwrGLo7EdASr8H7mM=;
 b=mm33ixyZc2sga/gzg0q35J0P9eEWJNhE6bjoOxWVZyh+OTmWFxbxKHTLOwRN2FjOj1W8wBLFxqdFbRYfmoHLDHPMjO4gzKxwn5AD340hdodMH51J2dbM/9P7vaP5MpZ4yr+LFHSSgLi8ZvpvMoViH1sTL1q7cwE7GRTCMmM3DhjENt7KS4H7C2bRISf+YrVDGtkJG91jqrrQSqmPjI6VLG5v86If2puhBPnR1BAZRqL/Ho+ivPHDpNq+dLezwL85FLCVrwtTaaGYmdHy6xaJD1y4U6Vr0szxmTq26deGLVdk1h7bvnCrFYGo1EgqFtmVkXRQwImcSjv2LjMggbF3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hbg6QKIKYU7Bj3Z7jhFBOTJUDQwrGLo7EdASr8H7mM=;
 b=B7+oCG6BVqorQx8Fs2dA5uMYV50rwtDpTP2LWhxO+XPgYrZSevl+D3g8jPKbyy8Oar+99tKsuzFijAmp/zMkJWzpKKv/4SZ7sZp/U1j7MH48F77rWfK2/7MU+jCSEmvFV+rIsfxspymwbdMN3FNcwjlucH8vAZuuI555m19nkfs=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS4PPF80E5E852F.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 17:11:15 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 17:11:15 +0000
Message-ID: <01769786-483d-4142-9b8f-f03f20998fe2@oracle.com>
Date: Wed, 18 Jun 2025 22:41:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: docs/driver-api/conventions resolve conflicts btw
 CFMWS, LMH, ED
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
        linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250618161907.1008564-1-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250618161907.1008564-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS4PPF80E5E852F:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9ba90c-28ef-48fc-4d81-08ddae8b21b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0VaeEcva2Z5cmI2SzNKcHF6M2NOajJIOUxBZVBYQTZYWksvWmlSKzlqSkVF?=
 =?utf-8?B?S2FzaGFkUTZhZHNQZEloc2pZUWdLanFBWDFaRWI2VUh6dzRUbWRVM2gxaHBm?=
 =?utf-8?B?cDJ5MVZOQ3pTVUhnaGdLTThZNDY1ZTNNVnFYVDhMUGxHS3lZenRLWllaRkZy?=
 =?utf-8?B?ZGd3NzNXa0xESnZYZjA3d1pxcWpUSzFtVXVXbVJHMlRXUDM3QzFxeDhzR2JG?=
 =?utf-8?B?ZjVGRWl2TVFGc3RJMXFDRVo4K3dNRFViZVdsNUJMTVFuQmRoM2kxYmdpem4z?=
 =?utf-8?B?M3cwTHNSeVh1U1RadTNmbW5aQTJqbUxJZkxIeVFaMDBmS0RHU1dqblVlSit2?=
 =?utf-8?B?c2w4Vm0zQ05MTkUvcjNqbkF6aDFrK3RCZExaSkpFaGxhSmdZZ1FLRDhDaHgx?=
 =?utf-8?B?WFpqVGxhWHVKdXhZSUVSREdCaGRqRFYydjI0eG5vU0Y1cDQrWXpHcHpYZVZF?=
 =?utf-8?B?amxYeDlrRnpFRTlucDlCNHlIZFMxdStDQ05vZXM2eUVzcU0wU1MvZlZPNDdE?=
 =?utf-8?B?bUtJQXdObFVLY2hJa20wUjFPMnJTaDRqMHdqMitpSzRnUHFkZEpDZ1dDeEVB?=
 =?utf-8?B?ZVcrRDBXNVlucTFpK1hJRHBkU0FUQ05hVUlrczhkcHYzK2ZZeHRjOFU1dW4r?=
 =?utf-8?B?dlR3QVk2cjJHVVh6MUdpMkZSQk9tc0FCdnl1ckR3TTRBVk4rdytXbTNJaFZK?=
 =?utf-8?B?ektzdndQYUtIc3R3Sy9yUnRCb2ZLVmUzYnREeTVZeURzS0Z1cks2eFFPZnpp?=
 =?utf-8?B?ckpMUzBYWlhqcDA4YnFCeWhtY2JMcmRTa0tWUFNJU3RSNFBDbFNsaEFlZDVP?=
 =?utf-8?B?S1ZJN0g3cnNwS3RHSFlGWXk3ZjMxUTJmekdlNVRjNEZSU2hOTXY5MS9KcElP?=
 =?utf-8?B?Wmd3b25WVkdUVUQvREhPSGpLWC9DMFlCYjdzRDdQN3o2WXBDSGRNQzNPTzll?=
 =?utf-8?B?dFFiVzlUWEthS1JKci9nZlhwVjY3cnltQWRFVjBsM0NDNDlLdVRpSEJibHh0?=
 =?utf-8?B?US9kSG41dVRGZUNlSnFJdnlKR3RFY3JWeHQ5VllDVThXWk5YcFpoaVNhbE5p?=
 =?utf-8?B?eVZnRnFwdm9HQXBtemxGNGxpaC9QbTJudno4MjQ5bjhTOUxPVmFiOE95MmFj?=
 =?utf-8?B?NTNwQWlKR1Z3a2lVeHdzbFdGVWlBQTQydXNaNG1QZEttRW9qdGt4c2dKNWxH?=
 =?utf-8?B?ek9BWE01RnlCeUN1ZGxoV2V0RGU3MzQxTENmZVN5d2x5VmdXbnRzM1lJamRF?=
 =?utf-8?B?QXhwQ1ZOakRDVGNDdHpXZWxXSkhMQkxCSlJDUWlvVEpqSldNTE1Xa2ZhZWdS?=
 =?utf-8?B?ZFVWV252SXVKTnljaS9kU2xpK0hJZk5aNHYzWVRSNk9Jb0V5V2E5cmtHRWds?=
 =?utf-8?B?NndDaWN1VlNxaVh4NVhSTEp2M3BuNWdJTGtSQUxtanVZSEJoTit2UThkZlli?=
 =?utf-8?B?ZVN1QTdTWmdSWnExRWZpYnMzSXA2RlFEbGsydXJZTGh4cCtUcXd1M3pMRlUw?=
 =?utf-8?B?ZnlySnhkSk9EYTYvcXVteUJMdE9tMUZFUjExa3lLYVhvTm1neTlHSjRlYVhQ?=
 =?utf-8?B?YUcrOHRkajlJOEFqODZlMGcxLzdtei8wMnFjNGd4N1E3VnZPalhJME80R1ZD?=
 =?utf-8?B?S3BiekJwVGRYcExpSDZaRWlGM21PdkVCQ0tDUXJSSktuQUFYb1crOWlhWWRr?=
 =?utf-8?B?UStBd2xzb3dLcG52NXAwRHlEMlpOeU5lTENJYW96ck95UGMyMHNKbXdqR3Bk?=
 =?utf-8?B?a1loME9EOHlYb29DeXJmQXpmSzJMUk9OOTJ5TGtIalRvOXBINmRyVzJNbThI?=
 =?utf-8?Q?Ym8AWRaHjIBQIiXZPxvkiP5C7+tQK6+5m86Nk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGVDc28vc0puaCtWbnpFQUJ3ekhNeEZsbXNrVW9YczU0djgxYXZrYmJGaWg5?=
 =?utf-8?B?QmkwQWF0WllRTkk4MGJ3Y0s4dHB0ZHdwamg1WkJIOGRsZWtTY2FoWUhzQ1JS?=
 =?utf-8?B?bkttcUZyRTNUT1ZxT0N6cW84L2hCZm0wcDIrV0tRdDYyemhlaHVzbkM4VExU?=
 =?utf-8?B?ZzFNYVlIQkVZNGxQU1lyWjRKQjNzR24wcFVIcEhXdzBHWlE2bmVPVCtqbHgv?=
 =?utf-8?B?RFJjVGJIZGZnRi9vNGRuTUpLSDIvTHI4eGd6cE5KZ3A3cVJYbEFCb3plZGhm?=
 =?utf-8?B?MXdDSXJEcjZraHhoQVJLTEpGdU5LS0JXbEJuT2xXejlJNjRsWi9GSE1XZXQ4?=
 =?utf-8?B?eFU3NlJjTlU3V0V4N0FUUkpsVFh6Sk12Um9aVFhXOCswN0NDQkpzTDFyVDFm?=
 =?utf-8?B?M3c5UXhyb3F4K3c0THpZYXRXdkFISlRhMkxDTVNFUWtOc255c05ZQnZYS2xl?=
 =?utf-8?B?YlJiS3I1L1pCZzRBck4rdFpOMnFtWm0xNzNvTjFMSEgxSzl5azJSaVAzUEZT?=
 =?utf-8?B?K0xGVEdCZEVoakplNnE3dFR3ZUZLYUQwcDYxNFhVTjZRUktIMGVYNlhHdzlR?=
 =?utf-8?B?WDFnN0VtR0J5eERYWEJ0WU0wQ283dnlNalhVVGdsdWpiUlJKUkNOVDdJWmN4?=
 =?utf-8?B?d2hKbVpnMXBGelkrMENMeStPKysrcEF6WmlhdmxHNmxobmhlS3Q4RSs1ZnJ5?=
 =?utf-8?B?dUtBVWVKL2ZCc1orVkVBV25vVk04eE9tMHJTVzNONlRubmxybHdUbXFIRU82?=
 =?utf-8?B?NDAyUmw0VDYrQ2crUFhSNTRpTlErUXZZWDNvWXJYSFN3by90SDRCZE1PQU9S?=
 =?utf-8?B?NFIvaE9oOVNXUDBjdlFiNE1vZGNRLytFWGptcXFkYkV1Zm5JY0pocHRVdmdy?=
 =?utf-8?B?c0F5SVMxT0NpMWgxWGdLS2NybjVUanZsSWY2MmJzZm5QVG5xcTZGekcrNHQr?=
 =?utf-8?B?VkgxODVnM1JXNUZUZHdJek0zdDI5VTNWT043Y29uSDZuMVIyN0RCaDlDTXNP?=
 =?utf-8?B?bE50bzlSMndpU0ZoOEdabmJ0eTcyanV6M2tEN3BQRDdvazZWVTNDNEZweFpX?=
 =?utf-8?B?U1VDRFV2RVdNRm8rNlRPY05yUlJrbEs3c2haTlUzcS9rL2ptN0VLT2taNXNK?=
 =?utf-8?B?bldqUWFHTS9TeGJLQjE1TFhjSzFDOUVxQjlFdFVGZ0F2M05HL0JHZ0hEcGxW?=
 =?utf-8?B?V2o4b1JCT1M5ekZINmt5Vll6QlAzZVdhL3pTaEtHd2VidThINndmVDE5ZEdv?=
 =?utf-8?B?bHJ5VkVaaEFxaThZQitVQmJxeTZoYXFDKzZ4MHlnNkJldnczSm1BdytuSUR3?=
 =?utf-8?B?L0tseXpiaDN1NGpCTUJWdGRvdEdRbU5uRE9wRUJvMGk1UU9pZ1NPenpNY2Zz?=
 =?utf-8?B?VDJPeWU3QzZXSGptbjZIWTFvVUs4UTdPVkRkM2UrdkpZTit2NVVjbnJEOWxr?=
 =?utf-8?B?cyt6R1NhYzhmZlQyVGNTZXFtbVBiT0pxY01mWW90L3FFbXh4UXB4c2Q5bHNk?=
 =?utf-8?B?Y21maGJKd0U3QVdUQWZYLytsNm9mb3lmR3BXeHdka0FXcTNxZk1NRmtDRkJh?=
 =?utf-8?B?MzJsMVorRERUakhQWWtVeHhLMXBGVlAybEVZOUphR2VRYVc5Q0FyRzhSUzdL?=
 =?utf-8?B?SS9NTURuTGxyR1kxcDkyL0Rnb29sT1BVWlpKVHFETWRhWFBkUDk5c0d0ZTll?=
 =?utf-8?B?aGtJVFlOUGhyYVljU21BMVptMWVrWmhhZHpwZGRkTGt3V091ajA5VlJraTY5?=
 =?utf-8?B?VWFBbndCK0Y3NjdpeGZBdmpya1V4RGppM29BUWRhWEdTdlNIUWJESHVNVi80?=
 =?utf-8?B?TjB2NTNHa1V6NEljZllMcDNTL0lxeVBmWjk1Q1F6djkwQSt4UncwZG93TnFs?=
 =?utf-8?B?M2hJR3c0SjBRK1A1NjBiTjB6VFBhUHpwUXdSUllVL0xNS3l2Q2twZ05xRzZL?=
 =?utf-8?B?MS9zSytUamx6SHdrNTNEanhWV1kwM0xVdXM1Q3FieTg2blk1OWZCM0w5TE5L?=
 =?utf-8?B?UW1ZL3p2RVZFSG9RU2JiMnBqNzdmdk5pUHE1VkxqY2pzQjI1WUU4M1BIaFBk?=
 =?utf-8?B?MngrN1ptV2dHbXpRUlpCaWFkSTV5T296aGh1bnIwaDZQdFp2bzB1M0s4c2Qx?=
 =?utf-8?B?Q0ZsaGZmMnRQeUpmSFNYbS9kb0VuWHl4dUNFTFJpdTAvSnM1M2Z1SC9qakZS?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/pO66kHo8qTiupQp2+08+zfOy5Q/x2wo06og6uHQLUp2v8nd2oQRjO5jCbfDwOn+8IVasCLLj74XRYeuWdWRMqEaoEvHVEWADzUr0Q9vUqAXUH1hPexTtXLDcBgi/krQn2wYwpGrH5fiWL213fcORo5cakaYCx4EqtYnE2frdlR7y5M6gDUKIIPDQibgy3/4jTbXL5cK58OY9yzJHLqv75Jhfjz0e/I+Rh9EfI4P3rXurVbxKwdmGVc8oc6Oxg/p9yjOzs53Ae/UYkumixEvoUCKvpDNq2d+6JtkfH9CVZlezl7MTGXd7VuMx34IhqZdK08iL7cwZn/hV4Pey+QS9Fdea2ARHEjcq1Y7vTpdF0257GxwXLAcrSwi0nKPcxoj2+1rQHwSQzsNSDUUvYPP2mbV3lKYVT9Cwo2zW6DorKiD7HfLBbYnGj5bLat/aFIZ3CzdGbxUJN3K3g3KToTw/aCgBB8+bTbfiNgOAoxVRu/fynAcLncKqdVMlJfQS2/xdWYzMAivPzpp9mcPxOUJLKiYQLn++XQ2YE13qETKvaq7ljZCkehWnedYSo3piUAilX4/lr2z3ENzA0k1WASMNvlJly2jRY7m3j3s9UmP6JU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9ba90c-28ef-48fc-4d81-08ddae8b21b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 17:11:14.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRP4Uo8fsn+8u+vctmohjKMS8cEqGDlw/UxRDFNyAdWoyDgcLL1+3SE9aDHUNn+wQeiQePKEta7ee9ctaZMDNZNIZ4j9BWftJ6VV3PVGQgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF80E5E852F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE0NiBTYWx0ZWRfXwYiDdTt59r8H C2w2FazKSc9kcDeb/rkJtv85OrSLm4Cavbhdgg3eLf7exz6jWvnqL/B70gY1m109teugXTpdDg/ f7Eet6cSuKALtjeV0AE0QkyWhpkZ1GfB/nkdZGjIcUoR/uwIyqg+HdIduw88eOdoFd628q15Y0K
 Ifk4Zx0nF9vi3WPwWmvj975vPdVF0SbjNqQLeRALG8I5+gAdVIgVtcr71XWVHc6YcEY2C5Ei8Ja xpwA2t4tMlz1WNO27S/erCFRA5qkUdRZcl2pzrG2RV22Z2ZlhYgmUp/XPN+ggyiQp+mQkvlmuql yiDIm7Oi1VDcT8/kAuczX+sRKrTF52L0tb1XjfBOKS2T7rw2OwhUPbnprWYoITP7jCbhUPCoBWm
 k+YW3oEoqTU3oMUIa4tTgBDOv5XUo0IJsGEsxjnkCFyoYpcHDTLPAfnre6dSVv0VKpd1JOml
X-Proofpoint-ORIG-GUID: h-RwQhe_ylK2auJt3uGU2gEOCknTKFxA
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=6852f336 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=D4yLe6ciAAAA:8 a=QyXUC8HyAAAA:8 a=DNgt_PDpIn6PqVLORIYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=RJBimmv2CioV9QQA5JKZ:22 cc=ntf awl=host:13206
X-Proofpoint-GUID: h-RwQhe_ylK2auJt3uGU2gEOCknTKFxA



On 6/18/2025 9:46 PM, Fabio M. De Francesco wrote:
> Add documentation on how to resolve conflicts between CXL Fixed Memory
> Windows, Platform Memory Holes, and Endpoint Decoders.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.
> 
>   Documentation/driver-api/cxl/conventions.rst | 85 ++++++++++++++++++++
>   1 file changed, 85 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index da347a81a237..acf2523ae799 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -45,3 +45,88 @@ Detailed Description of the Change
>   ----------------------------------
>   
>   <Propose spec language that corrects the conflict.>
> +
> +
> +Resolve conflict between CFMWS, Plaftform Memory Holes, and Endpoint Decoders
> +=============================================================================

typo Plaftform

> +
> +Document
> +--------
> +
> +CXL Revision 3.2, Version 1.0
> +
> +License
> +-------
> +
> +SPDX-License Identifier: CC-BY-4.0
> +
> +Creator/Contributors
> +--------------------
> +
> +Fabio M. De Francesco, Intel
> +Dan J. Williams, Intel
> +Mahesh Natu, Intel
> +
> +Summary of the Change
> +---------------------
> +
> +According to the current CXL Specifications (Revision 3.2, Version 1.0)
> +the CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> +Physical Address (HPA) windows that are associated with each CXL Host
> +Bridge. Each window represents a contiguous HPA range that may be
> +interleaved across one or more targets, some of which are CXL Host Bridges.
> +Associated with each window are a set of restrictions that govern its
> +usage. It is the OSPM’s responsibility to utilize each window for the
> +specified use.
> +
> +Table 9-22 states the Window Size field contains that the total number of
> +consecutive bytes of HPA this window represents and this value shall be a
> +multiple of Number of Interleave Ways * 256 MB.
> +
> +Platform Firmware (BIOS) might reserve part of physical addresses below
> +4 GB (e.g., the Low Memory Hole that describes PCIe memory space for MMIO
> +or a requirement for the greater than 8 way interleave CXL regions starting
> +at address 0). In that case the Window Size value cannot be anymore
> +constrained to the NIW * 256 MB above-mentioned rule.
> +
> +On those systems, BIOS publishes CFMWS which communicate the active System
> +Physical Address (SPA) ranges that map to a subset of the Host Physical
> +Address (HPA) ranges. The SPA range trims out the hole, and capacity in the
> +endpoint is lost with no SPA to map to CXL HPA in that hole.
> +
> +The description of the Window Size field in table 9-22 needs to take that
> +special case into account.
> +
> +Note that the Endpoint Decoders HPA range sizes have to comply with the
> +alignment constraints and so a part of their memory capacity might not be
> +accessible if their size exceeds the matching CFMWS range's.
> +
> +Benefits of the Change
> +----------------------
> +
> +Without this change, the OSPM wouldn't match Endpoint Decoders with CFMWS
> +whose Window Size don't comply with the alignment rules and so all their

Size does not comply

> +capacity would be lost. This change allows the OSPM to match Endpoint
> +Decoders whose HPA range size exceeds the matching CFMWS and create
> +regions that at least utilize part of the decoders total memory capacity.

the decoder's total memory ?

> +
> +References
> +----------
> +
> +Compute Express Link Specification Revision 3.2, Version 1.0
> +<https://urldefense.com/v3/__https://www.computeexpresslink.org/__;!!ACWV5N9M2RV99hQ!KMvmUQzFTNqBga7-zQPzxmzSqdYgKZWELM7-GwPfbpk5BeOwvr0WMeZ9UxWW235HbZzpgBfnIUryy_eQSHsLGAt9Z7Abgi_UdiU$ >
> +
> +Detailed Description of the Change
> +----------------------------------
> +
> +The current description of a CFMWS Window Size (table 9-22) is replaced

Table 9-22

> +with:
> +
> +"The total number of consecutive bytes of HPA this window represents. This
> +value shall be a multiple of NIW*256 MB. On platforms that reserve physical
> +addresses below 4 GB for special use (e.g., the Low Memory Hole for PCIe
> +MMIO on x86), an instance of CFMWS whose Base HPA is 0 might have a window
> +size that doesn't align with the NIW*256 MB constraint; note that the
> +matching Endpoint Decoders HPA range size must still align to the
> +above-mentioned rule and so the memory capacity that might exceeds the
> +CFMWS window size will not be accessible.".
> 
> base-commit: a021802c18c4c30dff3db9bd355cacb68521f1aa

Thanks,
Alok

