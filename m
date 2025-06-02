Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF71DF268;
	Mon,  2 Jun 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871144; cv=fail; b=uyJzEUecc1XRNDxh6/g4+edc99PSaLN0YC2HMUEuBybep20JTI6jFlFa4SqbqXzTe/rc92dbL3VVcjV1LWAw0gXplfjY5iKsPgWtFEDjgt0Wo9GwDBnkNc+tAHa9+ctXNqeaFV+nwhsxfQWGLKoNssv0NGtVCqEKBqcSuJuN0Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871144; c=relaxed/simple;
	bh=XMPJ5GFjz+V9RP9Alu5JYTolK+JJVdJ2cJBiuH3QcBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kmBGNnR3HU2UWkRPcU+6hpwzgEPKzGBYv/YSdBU9n+meZj6LeH1GLPXyv2qIC/b+wbOXslVh7AvEzXX09EXoO7GWeSFzu8vFq89LOdiKA6MJi4nHcv2biJjv/rTm7F4KLCve6HhkBIKY0oPaeNEsD/G0xoI6/hwVrg2TmwHGrXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TlE8AgNj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FiRtU8Yu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TlE8AgNj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FiRtU8Yu"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552C4YBS027391;
	Mon, 2 Jun 2025 13:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/KqevWLOCXNtteXp2odqI7Sqt26iHcl/cPkpQdTVKac=; b=
	TlE8AgNjQrvOMtgQSXQYyn7enbtwWM74UlekfZ1g6phhR+/BlbjVyA1y1TonHYIQ
	1SOJeA4+HRQV1jPueKnvi89mOKNxKwWbdpevPiUWdJm8p+tXQXW1lGIkvF52MEN+
	eonLzHcv4PYqajMfaZmu9e9iXJ4FdAGji44xqU+NF1y99yQOuBBYrDaVam8OZMgY
	FshrcM/coLxbKkHxbBAcnNiKUG1V/qBwvpeabcbfQxGcyecAW3fFCBjLEbb8vv/6
	hnOaggYtjf9eF7PPBjaaZpef9l4qfDG/REbaA9+1Ge/V5HEjThTQ27Ab3IXc9V/6
	FjhP8kjg7lmCLwkPjJ9w1Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrc42mjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 13:32:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 552DSSsP040691;
	Mon, 2 Jun 2025 13:32:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr78819k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 13:32:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPsnc437r8JMwNyPpc/s8aWq9n2KqIeh4t7loBUuDwDSR8HnIuUbdjI1V2ujx286tBS4Q6Qt5CR/I+53QvaKvBb+CbkCsFiOAke9ZOIQstp35r8e3ohCCvB2vnWO1+dGARhIJ0Y2QhykLtWTEwFfKlP5qtoWoA1ZBpOpJfKlzRtOwdH1LNDALQ0jMvMRmFTs1SPAeSX/6/U+gWWv0NAjIFAF4RP2W0QIKYJd7UuNCW4LrnsbGpDCKPCwZv5e7mWRXjy/AZJwSeblnzfYTdDFfJDadi0HV16YXcX9tdREUXDr1QnQ0JJTKkpB2dXU7Iaxg/JZod7FZP1i3moKf5/y6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KqevWLOCXNtteXp2odqI7Sqt26iHcl/cPkpQdTVKac=;
 b=op69QzdzYYa8786e3ZccWJoe9zQudrLmR9bD16Go0EeWsQT0N+B0qe9frPhQwCLrM1yqZKS5apCr2NWbxVu4yTRAy89hfPW/YvWvA9HKtKOTkmfbbbmGQI938qWKCbV8Ttnnm4um/f7m3r91a4JXTC44RIDMzEYvkdp/vgFXQU+H0QR8pF4yiOaIKTCCTwEG19yoQUG0GfLMG4tKr72m1rcVL1b1hAgNVBDEkfctW/+du4JFcOrc3O7jeAG+J2vVvP6kSvsv3thtxiCu7jELODP/b0MP9Ej6robu8yQkkkMHqV1d0afsfric3LnAOiXwZLHbW2cj1AZV/jayJnavUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KqevWLOCXNtteXp2odqI7Sqt26iHcl/cPkpQdTVKac=;
 b=FiRtU8Yu/riQFvvNVRxJLDk8/J/odSVsIMQCx7DFA63N+fq29xf+udhkh4sH4bUCp7ZUUVCjPSygTGqEfJM7bF7dFpolifEKYYELvlcmzChDurgwGYPOXNVkV83bp/MS+Cd1LDklw3U+0uijLjqlRx23VlU8b2qzOJWaNCImNug=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BN0PR10MB4951.namprd10.prod.outlook.com (2603:10b6:408:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Mon, 2 Jun
 2025 13:32:08 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 13:32:08 +0000
Message-ID: <5f50fd5d-a3e0-4f71-b530-b8dfe6fa22c9@oracle.com>
Date: Mon, 2 Jun 2025 19:02:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: cxl: fix typos and improve clarity in
 memory-devices.rst
To: Gregory Price <gourry@gourry.net>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net,
        linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250531075209.3334261-1-alok.a.tiwari@oracle.com>
 <aDzipGmldaeje43H@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <aDzipGmldaeje43H@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::27) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BN0PR10MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9d023e-bfb0-442b-ab83-08dda1d9df19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlliRTFISkZUOUFraWFkbEk2WWNvdmNGSmFYZnk5akFUUk9XeTFqL2tvLzhW?=
 =?utf-8?B?ZTBkM2dxUW1iYnJuaDNJQWxPSkZHaUVoOXhPeUw2YzBxNnhSdUlXTXU0Z2p1?=
 =?utf-8?B?YUR1emkwVFJUUkJybmRMcXp4Z3R5NHBlVkFJK3pJN1hjZXU3SEsrMHZnZTc4?=
 =?utf-8?B?OGszT2xJUUU1MEZTTkJXSnhJU2JaWTRpV1JnQnpkK3UzWUlOKzJRQ3paVjVB?=
 =?utf-8?B?NGlCWWNkUHRCYUl0bTlwU2lTSDIvV2p6VVprR3U1SmlEbys0aFV3TkZiV2VZ?=
 =?utf-8?B?eElqYzFOVE11clo4RmVWY0NiSGcweittWGp4Smx1NGJsTWFqTWlwMXRKbDZP?=
 =?utf-8?B?NGJDUnFDWjI2ZkU0dnFteWJzWVIwcndLa2wydWQzV2t5d09Zcm9rcFBKcTVH?=
 =?utf-8?B?ZUM2cEZ4MmZ0N2RrMTJwZWhJc0RUM2R6TlV4elhkYjEzb1RwQVY2dDkyVkZr?=
 =?utf-8?B?bTVWMWZlZXRMZzZxYnJlM3lKUkxhU0JkbmxhL0hBOXJpNnNHNHRITkNWRjAw?=
 =?utf-8?B?QWx0WjN2d2ZyN2xLWEpWQkhjd0NlZ2VQdDlLcEJpa0xPY1B2SklxbEZKZ2pQ?=
 =?utf-8?B?cUw1TjdCZXA1M291cmgvWXFEdE4rR1J0UFB0M1BIZTE5WGRSeGJ0L1JVVnpr?=
 =?utf-8?B?NU4ySVhwbFZRa0wvYjJEV2pwNTJMV2dYd05FVjUzVHFoYXFBaXA3UUFSOTRM?=
 =?utf-8?B?Yk1UVDExUEpBTGNzdy9kbENlaGx0MHUrZFV2Z1NnSlptSW9VaUIzc3dKZWN3?=
 =?utf-8?B?cERRMFJBUndiYUszUWdmVWtNOGNlT1FMdVVNOGc0SGJFY1dwSVYvUVVROWhV?=
 =?utf-8?B?SjB0VjVrbC9UT1M3WUZQWVQySDk2RnlrRzJrL1VvTWhFamI2UVorMHI5bDFx?=
 =?utf-8?B?MGpwYmR2UzN5S0dJVklhTDh0SktsODZhRTJUcEpMMk1yS3gyTzZKbHdmMDJ3?=
 =?utf-8?B?UndIcm9TUWlxemhDOU5YZVllajVKZWh3MmtFa3hUbEZYemJsbkVYc1BMUzVn?=
 =?utf-8?B?NHVKdFAxb2VxR1J3Z3dybzF6aWlQbnErVjBtOUhkZWNxbVExZ1Y0b0tIOENR?=
 =?utf-8?B?YmJMOSsrMEJDcFErS3ZUUTZuNDRBVnVYRDVUYXNtK00yQStTQ2Jka1JYV1Vk?=
 =?utf-8?B?MEdIUWFIdGsya2ROeWw0cEM1REhPLzN6aGRvWk5aTCtaZHN6WmhGaVozSmw2?=
 =?utf-8?B?UGVEd3NYVHl1MlFvRnhlb3A1c2NGSnRwSFJsNzJTTGR3Zm90bDVIZGNtcXdW?=
 =?utf-8?B?TTUwZi9uTkVnU1Zjd2JzZEJOaFl0TkVLSys2ajYzbmNxQUtnRysreG1IdE9I?=
 =?utf-8?B?M2FrVzNiU1dObk9wdXNvUDZuckVKWEVINDVsNWxSMVZWcUltcCtSVU1lTGxh?=
 =?utf-8?B?eHJFVFlNS1U4ZFc3Y0FFc3J1elRIM01remRkaXV4cm1JQ2l2N0Noa056MDdx?=
 =?utf-8?B?cnAwSVhhR0hDR1I2ZHNKQ2NXbDRtRHQreXFPaUNLbzd3Q0NmZ1o1ZGlVcCtG?=
 =?utf-8?B?SG8zWDNmMlNleS9nczB0OE5JTHZDN091SUp5R2FpWFcvN0tubEpiZkxIODF1?=
 =?utf-8?B?OWw2TmZJZWpkQTJCZjZuMS9udzBPYXhLd0ZlMlRhanNKR3Awb3hIbWhsRElQ?=
 =?utf-8?B?cHZ2ZGIrOVVwcWR4ejFEb3hzMnpsNm5ibytXT3pCK3Z2TTBjbndsZmY0b3do?=
 =?utf-8?B?NDNKTTFMcEdrbWtXdkk0OTFsMWhLUStiampCZjMrTVhuM1lHRDBOcTZ6Uk0z?=
 =?utf-8?B?aEtzSEYzOThHOFNhMGprZnlKc0NPeG12RTdBcHNadG9UVFJIb0dXTHpYMU5o?=
 =?utf-8?B?amlUN3k3b1ZydUJoWW9RR1JkbGRPMkJSVEZ5blhOMnBuaElUdnlCeW5yeDc4?=
 =?utf-8?B?T0JsMldPWGIvbzZBY3BSRUZ6eWMrZ1dYSklmM2wvSm1PTHZXeGZaRUpDNXVH?=
 =?utf-8?Q?5sYQ+FXnGmc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk1SWCtIZTk0M2lXL3lQUVI0VEhSYTRPVW16aS9GNW9VSVJNK3VSNUZDMVF6?=
 =?utf-8?B?QTA5bW9MSGJydWZEeEVYQ3ZTd0l6c0xnTGU1am5KU0IrWW9pMCtmUjlXV09m?=
 =?utf-8?B?eUlHZUJ2UWpaVUdxdnp1Y2JwT29Dait2RmJ3Z3JPSEt3UTZGT2NQTVk5TTlY?=
 =?utf-8?B?K2ZsNzFDYTRBWWNtNnZQSjd3aHNUV3pDNFRJVnU1RlpTbmlIS013TTBuL1NP?=
 =?utf-8?B?cEtvbzl6bHc4UWgraTdDWjl2MVR4YWFmNXFUamFVWmNVTVVaZFZOdVc3MUJF?=
 =?utf-8?B?dFFWVHVuaklFSTdFcmk2ZWpkQW1BRTZXUVNhZ0dKUkRwN3phclcxMEFTdkxG?=
 =?utf-8?B?YzVOWmlKNzJQeWZ6U0dlUkJ3eXJTRjRxaHJHYVAwdlpOTTBYakQ1WWZUMHdu?=
 =?utf-8?B?YUpFZkQwcjdJbVo4dGswcUVEeHhmcEtzK1N2NjIzd1FHaVJTbkJlOFVSSGhK?=
 =?utf-8?B?RytubmM1Y0U2Mmpja3NEa3lqT3lTRjdYTWorSzFIdW5hM3U4bEJyZFBOUU5H?=
 =?utf-8?B?S1dyY1JLZHhUK1FSS3Y0MmxiL3pyTHVabHNjSVdGUGp2SHBEUU5BZnpwS3RB?=
 =?utf-8?B?TlZOZjkwRzFMMklBLy9ubXNDNlEwYzkyWDVCN0VhV0J1SFZZQnJaeTRNOHJY?=
 =?utf-8?B?cWFCQXMwY1VMRVZvY1RVVlh0WlJJR2RhMUM3a1dyKzVWQWhiUTdYY0RKamZL?=
 =?utf-8?B?ZjNUc3JJSUlpVFdFZHlkR1lKcUt6Z0N0VkJEVGU1bVJDNjZ5R1BvZ3h3T2Mw?=
 =?utf-8?B?NEpiVkNXenZadFo5UTFGNXFaUDVWZTlJZndidFMwR0ttTHN6RVpnYVlzVWd1?=
 =?utf-8?B?dnAyTnBkb01ENG9Feit6U0hpeHdNcXlxWHZQQWg2bWdnTmZiRDFmRTFVclJq?=
 =?utf-8?B?bnV3QVowOElOUitXVnNNaXcwWHpscGozOUNWQnRFQStnUU1JdVlHdEV2V3pD?=
 =?utf-8?B?RnBxaTRpVzVXME05UVI1US90RmczOVZ4eGJNOUs3eDZXalB4U3RiR1VwbVNK?=
 =?utf-8?B?THcwNGo1WGU2WFJnemZPdnBibGd6eGo2VFQ1Q3k1TFI5TjRidzhzMytseUJ6?=
 =?utf-8?B?azhqUTB6KzRNTGU5UWM3UWZNVEVsVFNKMkRZU25lbENYOWpGRmdxRUtTdk40?=
 =?utf-8?B?S2xybmlCcGJza1MvbzZXZFNNZlpPaDZJL010YkpEdFphZDFEbmlFeW90a3hr?=
 =?utf-8?B?bndXTFc2b09aQnhWOFdyY1FacCtjREFtS3NJUk5aU3ZFdG12TkRORVpHbmZt?=
 =?utf-8?B?Q1ZrdGl6NzRQV2dPckRlNDl3anVaalJrdjZGQVNXbllyT1pmTk5rcEo3dnFs?=
 =?utf-8?B?WEJ1S2x1VFd1K0c5c0w2UTQxSVhaVTJzczM3aUlrOWdsMTVRTDVBMHdNanhP?=
 =?utf-8?B?UzU5VnhERUx1bHJ3TmkwTFlJT01QUm8ySHlwcUpjbmV1eE80Nit6WWVxM3JD?=
 =?utf-8?B?L01CRE1ST3NrQ3ZqY2NuU0JuMHJseVRqTTg3dS9qZTRSbkl2RnNkQ2VDRFA3?=
 =?utf-8?B?Z1l1U2xMMGlWQlBUOXYrSlY2a3Q3ZVFkYVRWUmFLaXFYUlhrbiszeGFEM3cx?=
 =?utf-8?B?WUs3Z0tsMkhKRm44N0luZ0M2K25aZDVLY2VaSFpydlAreGJWZGUzUXAwRTln?=
 =?utf-8?B?SnlXRmtZa2piNkEyK2EwcEdmcTdGclFndDJOREZpVGFBRU80Y29rd0xKZ2ta?=
 =?utf-8?B?NXhHbE1IVGF0TUxSYUxEeWdwL1ExOGxROE5sa1luSmU3R1JQWHRwKzBHY0lN?=
 =?utf-8?B?Mm0xNlBDU0hXM3pHY1VTSE5RNFZ5QjhjZEhvc3R5emw2OHY0Qm82ckNwYjYr?=
 =?utf-8?B?R1NkbVR5bHVlQ2E4c2g0bHkrREVQaHFuL2RsdHk2VEtVSVhIK2ZUZWpuWW5V?=
 =?utf-8?B?NnNyUHhvYk12bXdQS2ZOcXlsR1VYOElEa3J1alVDWkEvVzRQcWN0WFZiT2FQ?=
 =?utf-8?B?MVk2RmlMa3lCcFRWMGdTZzhhZ2ZiTDFEY1JjdVdMZzhvbWV1bFpkcTdDVmZw?=
 =?utf-8?B?RXVCUEszQjl5OWtMUVdnZElHcDdnTUE2ODc0QU9mbjE3bVp4TytIUTgzZlF1?=
 =?utf-8?B?UnZqZG03N24zMGVFVWxJUlJSbktWZjJyNnc4TnpwMVNBRUZrcnR4OXQ2OFgw?=
 =?utf-8?B?Z2lEYnE5VFM1WUg1TXRjU0NrNDRuMDNsbmliM2s1SUhCSjV0ZkZzTjVYU3cv?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	psiXFhPG0rwXj5mTGZNYid345Bj2RHgoO2rkIzosnxLKHEmNK0Eiu+vafy0oNCFZuF4+WimUnAsm5AxdhOJsKoVGE95woGuO3H9bpnJ3GAh7Ir+p07hpHJG/JfaQdM0eG/AJqjJuMTraWET8sG7aTwb+2iCkgQ53eTqDYyyQYw0x5hVSh04epx70D49DGPr1zCjCVCZ7M++aGqlQB09DlBg+I77H/77AWvL75Uvt1xShGg5PTZ7/xAzQruL8hYtfL42FjhonmNR20WylxMxsmXUxrX0qN4qapvgcUv17Ov7hCFAbYpXGfyHAXhUMPUBHf0/Oa2zM0sG8FqTH2oOEsoDm/QTYG/AkZ7PnAWF5cytmHya7gv0NvTnboM2iAkNrXKZ+gHl6o9UGPcnQ4l3LZSDso1WhfPoGt/6ppZqWG+Q0h87r487M8ZogeQmOTeMN8QIULM6K5HwEkQoqlzQKiCDYThQX8cg6AyrL0DFH49pw4wFhDFO2LL+xMKsTzjVF5/v4ZWmw8etpxWTdfkntyCv4vmqP3AxA+e9jOIa/0ESt0o1MiK4Z83SP0f6UjZh17FBjnWul5SkMTCpnkcD2TRvLuGd07kuOIM16NNQZEgI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9d023e-bfb0-442b-ab83-08dda1d9df19
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 13:32:08.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+UOEkM6kUpbZ2wb5HLEkKMOSUZDhpyy473u+UkPUzK8Yabq7PbzcxLAWqOhBancLAc0l8LWg6T8mI8QhsfX7pt5K+Z4RFxkj+KOpcBlJCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020110
X-Proofpoint-GUID: ZTd3mIubQ4P1MGqBYOn67kSscz5gW6Iv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDExMCBTYWx0ZWRfX1vZT3Jf6+O8j IqysBMdfyGxKGcOvC0rnbcOxLdNukVezaLcgD+zDba30CFmbtsXRqfrW9yY/ErBdj4UTb+oVkQJ 4bcrc8joQakDVBDiSXJhlJamKCNb0VHdxsc8joXS5M/rvsG9hbZri45T4XnqoPVzLKrADLy78S9
 fa8dFvPSyB2cJhZLtOp1celfajADdbWYS6fgduK1mIgRXqb1AJdjF6PViClqgXlNnc/6VLI1kLK Nim1r7Q6Il7eBVqTUhKorH7G0XxdHEohGBz81SDG1DblFOaXk4/p1InLJY3vFVt83o3LoDafrFe YqvGehQn4kJDJj6gdCjgEOd+nVX43r96qzRMpch3OC/x6UlKrASagSiX5ZJOFOIq30dvzY7dLmu
 b4BHaOeDXOmGxKGoakANNEX+YJdlHFzQFXSgEk2bjk2lg5OBd+PlHWdsYadhmibCqkGzis8g
X-Proofpoint-ORIG-GUID: ZTd3mIubQ4P1MGqBYOn67kSscz5gW6Iv
X-Authority-Analysis: v=2.4 cv=RPSzH5i+ c=1 sm=1 tr=0 ts=683da7dd b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=tHa68p0SAAAA:8 a=TeWMaDf-UGNFiXZ2mj8A:9 a=QEXdDO2ut3YA:10 a=ufIsyHvWW7FwcMbVRpPq:22 cc=ntf awl=host:13206

Thanks Gregory,

On 02-06-2025 05:00, Gregory Price wrote:
> On Sat, May 31, 2025 at 12:51:58AM -0700, Alok Tiwari wrote:
>> This patch corrects several typographical issues and improves phrasing
>> in memory-devices.rst:
>>
>> - Fixes duplicate word ("1 one") and adjusts phrasing for clarity.
>> - Adds missing hyphen in "on-device".
>> - Corrects "a give memory device" to "a given memory device".
>> - fix singular/plural "decoder resource" -> "decoder resources".
>> - Clarifies "spans to Host Bridges" -> "spans two Host Bridges".
>>
>> These changes improve readability and accuracy of the documentation.
>>
>> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>> ---
>>   Documentation/driver-api/cxl/memory-devices.rst | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
>> index d732c42526df..e9e2952a967d 100644
>> --- a/Documentation/driver-api/cxl/memory-devices.rst
>> +++ b/Documentation/driver-api/cxl/memory-devices.rst
>> @@ -29,8 +29,8 @@ Platform firmware enumerates a menu of interleave options at the "CXL root port"
>>   (Linux term for the top of the CXL decode topology). From there, PCIe topology
>>   dictates which endpoints can participate in which Host Bridge decode regimes.
>>   Each PCIe Switch in the path between the root and an endpoint introduces a point
>> -at which the interleave can be split. For example platform firmware may say at a
>> -given range only decodes to 1 one Host Bridge, but that Host Bridge may in turn
>> +at which the interleave can be split. For example, platform firmware may say at a
>                                                                                  ^^^^
> If you wouldn't mind, can you also change:                           "at a"  - >  "a"

I will replace "at a" with "a"

> 
> Otherwise
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>


Thanks,
Alok
