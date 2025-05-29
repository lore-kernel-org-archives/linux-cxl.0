Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2D9226CFE
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527038; cv=fail; b=RMBLEpGdNBdy6jCAN4ocKuS42kaIM89lJLohC14XdCDy028F7brRtgYtVWs9nv7U/bDD/kzNRW9eZc9GGlXQmvNb1vbv+LyCQWFDnivnFBAPPZVVJCNpwyRsKaUm31OoNcMNwwHFvzn/QYTSlKxRndhL9jvmWgBV+5FKP/axb5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527038; c=relaxed/simple;
	bh=J3ZUeHMCqvT9hLMTAWKuykATgYh1GG//YtP2i0OaE4s=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=f6subNlQOP3EPLFJorwQFFJt1veRZD2TJIKjOZ+Gotv2YihRM5EakbUXYIIO7imCD5KpIO+hnwIZEpMYo9y3Xptf6TjyBn1U/8k+fxa41K1rruuEUbXZTpVwt0Ln84bsi7bzw0oRE2WjWy+1D5/htWRn2D7ziW9P6alC+21aThw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n5JvacE6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SGCkUtFm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n5JvacE6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SGCkUtFm"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7tvbQ023188;
	Thu, 29 May 2025 13:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Ls1tSzj6jMMOu5E/
	ZSm1bvcxWjjvcqr1UmK+kq9etyk=; b=n5JvacE6WaZl0Ikrm6ebvDYlkJyfL+2U
	Fpq5WUvuOV5Ort4Pl5/UeU+Ll1lOxqllfgqOXLEpmAkchJncyOvFl56EqG69cLbY
	5SqwFXhBEiZ+PLVwq0hWEy64nmgsKgaCMVeXyYIETNa/6Ae9138/dEQKv1OPs8Is
	fDNyNuaOOJc9WiuZWeSpVDDZhqpaTgMMLnclb1gyx9NG7c/DZNYrY9wjWPxrlCil
	of2fsJPgzQw+iOH/4ZJ8c6NbjR8nUKWEDQI5y2omGT6T0QkNWZ+xid14n7naU03j
	S5ibG8ZsJ/XvF+m2ZAdVt6IjNNARLPr+lUC/DGIf72Kmg3j5LHiJFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33n0a7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 13:57:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDRJ8Z021077;
	Thu, 29 May 2025 13:57:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jj8874-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 13:57:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpPfZGBut+4jiN9Ud1KebED4B0s8F6LeCP5sdkBdH4Vaj2UpQ2vgBl5yHtmCZm6yhQQLUA1IyLnMgJH4b9oQeCIBKNnOYPW27JQJjCXUq5CeyhypbIeJjLgNeUNdm5pSTgEPIoRiPSSp88b/6F2CA/WW9p/JgBj5pGUXKhRTy2hd8pNb821rw5KtiXgOp8ca+RAgcPaVrCPLl5Hs0F7fLUPRGTG0Q/wGk3dTX+td0zb443+4B8VwSLxm0eRSrwePKSfyY85KZStEItu89McJH+ZevK3pjfnuUTSsr4V7AH1NO020aKMLQ7JNgyH7c8ea+ujUA8nSVd/fS8aqzuXd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls1tSzj6jMMOu5E/ZSm1bvcxWjjvcqr1UmK+kq9etyk=;
 b=wRBAvz/gT9PPYbRHIdnlKwfc/L06GkBDVSK50jS9tMHmv3HZMA21bVtuBHFzHKHMfg/nAvHukbFxE9QmnFcs/UQpipoiIJiT+kBbYUicflt46gWFr6dwH1u0BvQF5kJevX+X/HVZqb699Rnu8PwdZ8xoDjg5TJSi5T2++51P3yV0ufVpyl9II4UlPElgfzQLLyW99sf0XJWpYKIFSTH2FJ79Oa0Y5iAEBmHR3SNzXZ9oPOZBvEwEnJIWlk3Ku1yLEy7lUGbg5PGx8Ci/7ZCiKj6qLsPNmlVkXXEXH9euQUEdz3/L9OcOZTreiv0erklULVl6aNZtACROHe4seT9Sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls1tSzj6jMMOu5E/ZSm1bvcxWjjvcqr1UmK+kq9etyk=;
 b=SGCkUtFmMjFtUApnRiQZW4d3X0qCUelVUtCr87etuqz/MwkbVJ8bdbcbgeYUBEq7+6GqfMijoO+2WXj4z5MWk7CCUilebTrpTenW0kcYgJAYve0e6xjh0DET4UoL476B39FBAjbX9bSXNs+VJwVKFATvRIQl8EErAxusx7z7UTk=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA3PR10MB8592.namprd10.prod.outlook.com (2603:10b6:208:580::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 29 May
 2025 13:57:05 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8746.035; Thu, 29 May 2025
 13:57:05 +0000
Message-ID: <0d2af1e8-7f1b-438c-a090-fd366c8c63e0@oracle.com>
Date: Thu, 29 May 2025 19:26:58 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com,
        linux-cxl@vger.kernel.org
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: [BUG REPORT] cxl: Incorrect mutex unlock pairing in cxl_pci_mbox_send
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA3PR10MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: d2db64db-0915-4939-e2cb-08dd9eb8b196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmRXdG14RS9CL1htMEFBaUIyL3FFWGd0V3dUbm5ockxQWjk5RU9STk5Qbnlq?=
 =?utf-8?B?N25qR1lxc1gxL2xhN2U2UytSMFhvdktRdFFFZ0FFakpKcHh2SDRXVjUybEtG?=
 =?utf-8?B?OER0TTBLelRWMXhvQ2laOS96d0tUWjlsT3dQb0hvMUFpUU1LZTQwYUZYSnZ2?=
 =?utf-8?B?NWpFOG5pYVd3MnEzRC9lTFpyYWUvTitSNyt6MGFsV2ZFODZJRG9VWWlraDgx?=
 =?utf-8?B?cVFjUUJNdG5kb1R5bXJZc1lsZTM4dHhNOGJxL05VOXJWQ2UyZmdJeVNGdU56?=
 =?utf-8?B?S3Z6cXNZOFR6eHVqZW9yZUl5Yi81SkVTNk5qVjVPZk1GOEFscWZ5ZG5VN1lF?=
 =?utf-8?B?WGlqcnZPclJsRVZTS3Qrajlnb2hjTlhyTXhPYlNndTZXRk1lU0NvR2FYYThm?=
 =?utf-8?B?b2VuaXVkOXY0dnZsSXFCcUFOaG91ZGJRTU1sV2hySG9TbkRRZjhZbTBTN1BI?=
 =?utf-8?B?TWlNcTJjL0d0QUVWbGI1UnFUNGwzMlBwRUNReDR3R1EwZFZGMGwxaVlWUE54?=
 =?utf-8?B?KzVXTjlMVmdnaFMydDdlbUhyayswdFF4K1VOMEdqUzM4TGZDMTJEVFJSOFVS?=
 =?utf-8?B?eXZoK0Myc3E1Z3hJR1pCeTZBc1liVjVudm4velNrUTgvZU5rOXhhV3RuaDBk?=
 =?utf-8?B?SnFEMm1Gd29sYzR5MXIwVlVuMDdVejByZEVPVm5wc3RrQ2xZR1NOYlpUTzU1?=
 =?utf-8?B?b3k1U25zdVNiMlN3UjBKOGZrQUl1RGhlcnRuQzViUE10d1lXQ0hMVnJNN25y?=
 =?utf-8?B?N283dXZCNDN5dUtTYXF6RjNIdTRINFN0dVRaWExQZUIzWnExNGtKTnlPQjNv?=
 =?utf-8?B?Qm5hU1dtYUR1WmV1cmVUSTRna0xYVDJ0Y1R0YzhZa1NRWHRWRmZIZGNGWnUr?=
 =?utf-8?B?bzVLbkF4YnJiYWFMNlBKNzR5RGs5UFBpRTVKNWpHaUo4LzV3YjFkRGZhdERx?=
 =?utf-8?B?Q1UwUDB4eGtUQ1kyWTk2NVA0Q2RIODgrTy9HbWgwMWd5enZFeDJ0M25hOHpE?=
 =?utf-8?B?MzBhaGxpTE9HWDltSXBjaWZrMGlnTzhCcWd4T2x3WHdpck1pZk1XeXo1RndQ?=
 =?utf-8?B?bXU1RHF5TDZCUXhkUmpoN1c1ZjhaT2dCTG11QmVpeW43aSsvWmdaNXh0K21U?=
 =?utf-8?B?amFMS0ZxOFJ6SnduVE1Wem9memRzQXVadjg1bnpvT1R6b3UrdmpRNmxwRkRJ?=
 =?utf-8?B?ME5aREZzYlJsUUpCZk9Zb1BaYjlOZjlNRzMreTNzeUUrWUs1VEVJTmFlcWVi?=
 =?utf-8?B?d093SW9hZytiQ2VSWFU1VWIvUTh5OHFvWGQ2LytOOS9jUFBGelVjcVl6NlE5?=
 =?utf-8?B?eklxZUtPTzJwL2JRbitZdzdRZmtIVnlQNndZdExMbVZ4R2dWTndEcDhoMmsv?=
 =?utf-8?B?cVpYQVdKOWYvUlVOaElIVmo1dldrNzNKUVpubnM2NmlTZEVhc2VpTWQzWVI0?=
 =?utf-8?B?N2JNVEMydG9tTDNLSy9haFJBaVBiN2NyWlB3QVdUcGRONTc2UzRINTUyVytK?=
 =?utf-8?B?b2RGMWIzSU5mZmlVM0d0YzJOejhudjRmaGZFZ3Y3cHE3MGtVcS9sMzFLb29a?=
 =?utf-8?B?cEFENWtQK0tJUjEwY3FtcFRLVFRKVkRqMkZnVFRJWkd4MnNIL0JveGw5OWlj?=
 =?utf-8?B?eDM0UkI5d1B1ZFVqZGNhSHU3N0pZdVhYdWM4VTFva0hTaldiZjhhM0YvbG9m?=
 =?utf-8?B?WXQ0UXFnRndyRmpXQXYwamxhb2I3d2pjOWhhMWR2bnFLb1gyc2RGb1hwT2tD?=
 =?utf-8?B?K1FzT1FGbm55aWlScXlFLzFDeXhiT2k5L1c5dnpVNmx3UkFZajFpZ01xQWdC?=
 =?utf-8?B?akRROEtWZDkzNUdNWmdQQ2YrMDc0b0t0WWF6MWx1WmlWdmdXWlBMdFJBUGtV?=
 =?utf-8?B?VmhXeTYyYnlQSW14K05HbmlZdXdpeHJseUVvZk5mdmoxQnIxZldVc3poSEt2?=
 =?utf-8?Q?kLG4lCk22e0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW9RbFhReXNJRmFzczcrbHhCQ0hGNDk2TmE4Tlljd1NJdTlwNUtwZ3hSd092?=
 =?utf-8?B?NVJyaXBLMytaSWliR0FHZ0ZIUGs0UHh0bENvdFBTUVhkYXgrQ2x5Tm1oV0xp?=
 =?utf-8?B?T0todHJKdXJKWFpVMTVYN1RVdmdWNGNHcklKVkxBVWVkTEZtd3pFbFZMWTdk?=
 =?utf-8?B?UzJ3bkFLYjhSNE5EZk9OTnVCMjEzbWxrMUpoaDNFVlRabkdNK0RyNFcvaW9w?=
 =?utf-8?B?ZXk0ZDFqZDJyOFdFc3E0TXlqQmdtQVdrQzNUN3ZsQk5WSVNZQ09pOXA3N0Yy?=
 =?utf-8?B?UXFXNlhJaWw2MFNiWUV4VUg5VmFvN0FvTHhydDJrZklWUVR5MEttNGgzdEk2?=
 =?utf-8?B?ZU5pMW5DYUt2RzIzTVFQeE5NRk40bkhKV1l5dlFUemJXYUtJcG5nbkUwQW5N?=
 =?utf-8?B?Syt2UGR4eVFMZytza09xekx1MVpMcmRFSGlKdm80V3FNMHFXLzE3YWZqZXR6?=
 =?utf-8?B?R0tSUnJDY2ZZcTM1dVBRRFNWNWJCaEJDMzhMUEUwalZuSUo0NXlpdW1qdDB1?=
 =?utf-8?B?UjB5M1h4U0lpcmhMaFYySC81VEFLYUpsZ2NOWE1WdTdCY3dRV2MxTnNKUnkv?=
 =?utf-8?B?dFhESGZTVFRoWmJNVktMMnJrZTVhM1RLSDloR3NwNVZBNzZyRnMxWkZ1aUk3?=
 =?utf-8?B?K21nNWxlbXU4czlyaDMzWlZwWDYrMjJZSVRsR0NLMFhLVVVtcWtLKys0cGQz?=
 =?utf-8?B?THdxdWJiU3U1UnQvK0pVSnhRS1BvSjNZVjRjVFRIY3VodHhOdEszWllpMEd0?=
 =?utf-8?B?NVZYWTNMZEFXamt6WmdVYlJxdzIxYW1jZHZCOGc4RkNpQzBhMG9qYTJHY2dF?=
 =?utf-8?B?bXNWekZPQnVsbm91cHp1VUE4ZlJoNVV1eXFsb3FDRFhvVS9vemYxQ0Q2YkVY?=
 =?utf-8?B?aERFSTdBRU1kWmpMamNRdHJVRnNtK283Z2tBU0JVZzFsWEk1V0VkZmpBK2JG?=
 =?utf-8?B?MnptRFRpTkdPbVJDajJXWDdvMjBWZEptVThtTG5LU21uMTBNK21SNXdydVJ3?=
 =?utf-8?B?WnJlMzVJaXlQNFAwQmpySGtwT3VkdnBGci9kWGNkMzh4NnJuK2h1akRZaUZI?=
 =?utf-8?B?V2k5REptOFhHaUtKK3lKK3VKOW1FbzJnQm9ROXo1MUNUUjljNVNFZ1JteitL?=
 =?utf-8?B?R1VnaVNpN0hOYmJuc0ZyaTc4cXp1bk8wNTNTMGlRWXBtMDlJZHZ4L09hdGNC?=
 =?utf-8?B?NFh4aHhpU25GbEtUaStxME82aTE5QllIRFNlaTliUGtwQkExVnpSa3lKOEJF?=
 =?utf-8?B?YU1vTGpQbU9CNmlNaGlaQkdnNFhlQnd0NlZWcldIMEJDWnovVlM3dUVhdVhU?=
 =?utf-8?B?bnl0S0taczEzdXZINjFKYzdMdlJ1dFUyNVgvNXhMM3FYZVRTekIvVFJ0RTZz?=
 =?utf-8?B?cVZmcEZDSHJsTEJZelNxQm9ZUzVsMDRTcTZxVXBjcGtHSHNUdmFXMDhMaEVV?=
 =?utf-8?B?aDlQek5FU3JXek01eWhYZVQ0Yk02MWIyV09sWmp0YnIrb0FRR3g4N0UrSFM5?=
 =?utf-8?B?dHJMbDl2dGlQL3VpYTNJMlpmdGpuOW9mWjlZVHVJZzRFNFRkRnRseENMdEV3?=
 =?utf-8?B?Sm9zNGZ3Z1RDL1A3eVpMM3M1aUZCNTNURVExMzhUZHNOcUNVVk56dHVqbzl1?=
 =?utf-8?B?V2tWQmlDd2JMOGc0MUcvNFZzd2hINVVCRDFuLzlxdEN2Sjk3d0xNOGxzWWhY?=
 =?utf-8?B?cXR0WDBuM0dobWlvSW1kMmxob09qaTdML0dSSmRUV0RXQTcwYjRNWWc2YktI?=
 =?utf-8?B?YjBYSEUrTTFpZS9NZlByaVdKSmIxTXZSMllTZWNoVEgxbzdhaUIvRWlwa2hL?=
 =?utf-8?B?SUtWR3NDZXgxY3JvZ25VMkk0czhub3BiSWhLaDRudnMvb3V0RnZRSGhSWGdh?=
 =?utf-8?B?WlRMUWpURE1zM1hOOGhhSS95OTA0WEFwRTJpRzdhWjhUWlRJNnFQbll2RDZX?=
 =?utf-8?B?UndFbEJ3NW9CdkZkcCsyZlZ4QUFRcE54ZFVmbmE4V1BEQnRyQTRCY2QxZDBW?=
 =?utf-8?B?TTR0RjdFaUNQRmEwVGdZMVBNbGlXdXhMRkx5VHVSZVh1Q0dESmIzYXpVazhL?=
 =?utf-8?B?cm8yUVRlb2szSTU5d3c3UWpsbUk0b3cwK0dNRTI3cDJFZHl1djBLOHZFZkNR?=
 =?utf-8?B?T3djRjVXd1hoV1A1TDVyeVFEbmRpTXplbHRqL2diNXJYYnJTT2thN0I1NVJ5?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bMY5inFdvN24Fx0/3TTnmheo+DQ35L5u9og2Hls4OiKijb4eu3wvBUp2DIfxvoPr611Bm7ulen4ae7zgBJSEDw3xkbM/sscabzHviaVzdtuMIB8D6mQ9xQOy+Ck1TsAwyCol2gOZ/UiuzFY3lUIZxCV8XDNQoCWnU9FlV/9XTsDBSsLrgU23kQeaxGi8TYHwd7ipuXECvHZSDBBj1jREIsueAWLL55OrheWV+luf91iOanMqwL02sQExYaZkIJsAfLsXpRyzg2o9GkPIklBOH+xr3AF8iViYnZNCgO3z8AGaTcvSLtZC1MPu/lhZBs1NkpF4Tximu3us8C0WrJeY7sW94w0/AOoReFfL5VInd5FxAKlqtJ91CxyMObUjmjj/xRqihyg09zUSrWQM74TeelUZk0y0ZfFkCYf8rUhQKs588Rj3MV7YwB7v1rdBEFDKazu5DEAUhx7IKjfvPbr8BC8EvufYdC94jCV47ARApfQISXaHrMj7sI/mxFRljGh/u6ysmmbIRRTrf2JMYtmrSMcfpfH50JRLUf4WQx+N0DxuJITDL3kaCFXvfZxCXLA+O7DxRc1I0v6PAiP/CZUomQoE1cB8GoSxXeJf3g1PfN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2db64db-0915-4939-e2cb-08dd9eb8b196
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 13:57:05.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYnOXAfIsYAH23a5bMeGeLqMWGyN64Fjdkgz9EPHEi3n8d9xpXPRPyNFUlgQWa2Nexr1PZiLGzOtI1aST8o0ZkYzSobUnJcfNLYjKOmMu7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_07,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDEzNSBTYWx0ZWRfX/tkuV0gFZU3w fZZ36bVfdJ+W08+466MjNDustRPCv1nehy5VRrF10iQ+y8kEDhMX8h8Aabvr02Y5mh9jXQyel+2 QOMYMrNpOEpOCpDER9qdCZq+0S2tltPdFwRuRg+vB99e2mx0VRyjY1LM2uLC2nSISxee5z+sn7p
 +5oP3w/1cuYFS7ykmtvs4ZC9Mu/shKkicpXfD30hDgGJKd13edpyt8j0FxBgsrU3/5rb1FoX4/Q A43ofi8fqChEcRAYLImlAy0N0XgRa/a0jcbv0QtRTIcOmzJZ55Tt8FM7udvnPLc8Ad0mYcdiFW6 xFozALjgDrhWx8sTV6QQisK4g5om+mVfxLpv8mRSVbC0KmrZ6K9tBEFq++XinUnLfir3/9ko4ZP
 mvTxzrLUzGiSghHV7oeQ0qX3dnplPnnOKhu9EbMSpgMqczn/3ASudYaG+X6RjkgCKWSudnaV
X-Proofpoint-GUID: WW2EdsX8RKYMSMlLuQO0oxjd6eKy8T1o
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=683867b5 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=sHtopAw-Ml9k81TWExUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: WW2EdsX8RKYMSMlLuQO0oxjd6eKy8T1o

It is locked using mutex_lock_io() but unlocked with mutex_unlock().

drivers/cxl/pci.c

  377 static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
  378                              struct cxl_mbox_cmd *cmd)
  379 {
  380         int rc;
  381
  382         mutex_lock_io(&cxl_mbox->mbox_mutex);
  383         rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
  384         mutex_unlock(&cxl_mbox->mbox_mutex);
  385
  386         return rc;
  387 }

Thanks,
Alok
