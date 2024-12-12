Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A1D22370C
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027183; cv=fail; b=eUjP0DFZ8Q994kVPxxtFgNGaJ0TMK7S8NHhssPyx1KvH2kYD7LUD8+t7moa1qWgQq2SXHjEWAX6+ifh4MGmCS96swETJsAjIa2cVdqP+HTUoVvULTi/utmzBEXp/XvAZIsaNTJklDRFLXf8z8WXsiuz67E6RK4G1Cde+60ijXI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027183; c=relaxed/simple;
	bh=IRuBGI5i18TLGb2nMrWDT3RImB8gEjZOIJMYXMJHpW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P1F9EffOTq4cV5Cg1dCpvs9lMNa3sSwjuO3IjSHNAcrzW9FKgsDHEmVdo0RCL63aU0aUWlWPp/QiF/JWEQeooOc/3VcwFPBRRA2Z6GPq4k6lc/1JydO3OnvDeHMZkkoD6zINV8FCLaim2hFFbOBp8cxVgJ85GE5T54BeV41LWn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YBnmzmKP; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YBnmzmKP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doHjfEyJm7NW5l9in4MyxuuHhM27iqGWjRi2jyFL3i48Tch9+nAwSqDLakNwxd2DErpFkaHyhF60N127YGnrxyn9lDaPpndPIcEE0BxWV5cxo3BFUChHitHEqqSvhVWhR48Ak66Vl0r8rpxA+3O/PdtTBRs4vwAmwa0uedX6azlVp00BC28LysOxP3CufO9hXjwFl5pVQLCCMB5f0TppIvhSVbNJY3bfLAomMMMqUzqNrfdk7fUn7iLBPxP31UxSqHQqu7V7G0yAJEqvatbAQVLgQPNDPXcMOA4W8+uyoL3cJueLAEsAwaRwiX2CEqHX9tEPSvmGuhDXFrFHQzSFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p209SNfOA1DC93DaDg7zuJBV6u9bz8DtAeE1ste4OlE=;
 b=fOhY8sih0+BOM9N10T+Moutp8NOuTdRePzgzJMQje3onueEGUvaTySJTAZgGXQKXEFJfT4KOjiYEyC1drWSayA3dlh6FaD5d4yN8VeLGURBAR9Ns596UZpZ6Ab/ba9p3N1zWzY2aCzC4ZBAt1vanJn4kFLxSbR4D+g4q3syySqHIZp8UmNAfMU7Q6EMU4lR33CzFTI2tZ7SiXtf7bobJAxX48d6DWDnTvweqN2XAcO+acMOibGipCO8s+PASiyxiftDy1H9Y5ZZYdOmETNKEqLxxrOghjg8e2IeznrjzLK/l5os9LRzzgQkCWjMyy1VVYGrNNB3y0qEXWqfcMZGsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p209SNfOA1DC93DaDg7zuJBV6u9bz8DtAeE1ste4OlE=;
 b=YBnmzmKPpfoHhl4EBk82Hix2An7owCYPDY2GkUVyI30lDcjv8+gVeAsjnCDJwU+GBnJ0Qj3Yukh0UYjxpyvsK3NIE+ngtDC8TuOcxrsvS+gEV8Bv1tPxyt1/FeBhFy+u1/2I6d1kZWpTQlJKA58SBAMhRU++qzrJlbXy/R8d3XU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 18:12:57 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%3]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 18:12:57 +0000
Message-ID: <a37fafb3-ba2d-49ce-9270-e0a082652b45@amd.com>
Date: Thu, 12 Dec 2024 12:12:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
To: Dan Williams <dan.j.williams@intel.com>,
 Nathan Fontenot <nathan.fontenot@amd.com>, alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org, linux-mm@kvack.org
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
 <675a12a3d09d7_10a083294c0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <675a12a3d09d7_10a083294c0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:806:23::30) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: ed09e2c4-8fe0-4918-2311-08dd1ad89ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0JwTjRLL1F5RlU0VXdRRng5cUxETnVuUklsTUV1Y2QrREYvL29hL1JkL0t2?=
 =?utf-8?B?Q1JYVnl3YWhYcDV2b3RkQVB0djh2bVl0NXFmNlp1MU5NYUdtdDd6V2pHems1?=
 =?utf-8?B?eDFJeEJLZ3VyRnA0dzVzZ1FYYVI5T2RCYmVMVGpvZFpkUGV3cXo1MDBnSWlT?=
 =?utf-8?B?bEtCdEtRYWlEK1Zqbm41Nnc2ZVpkOGllRzRIK0tXdCtBM3FjOVZrRGRUZDEw?=
 =?utf-8?B?ZndzT3ZSS0k4Njg4elRaODI3RFR1L1p2ZmhSeC9sMlV5YVRPZVpURWNmcmlv?=
 =?utf-8?B?VGlPcnFad3dHRkJRaFk4ajloK0tjanQvUzZEbGhJT1VTdGRpdDBPUkdmTDhi?=
 =?utf-8?B?QzhVT0hKLzN1TnJoYjZYZjJuNTdUOHJjWU9ERzdHOCtVN3R4OThBZ0MxQVpD?=
 =?utf-8?B?VTJMZzQvU1VJNGpWNS9ad2NqOUxIZitzMlM0aStYbEhKMHowZUVLV294ZVVJ?=
 =?utf-8?B?WmpoSkxVeE1NVTNjYitONGN0R1NLSHozdDBpN0w3R0VoWVVWenNuc0xkdmJ5?=
 =?utf-8?B?ekVlV3JiZ3B5L1d1VmZRMXlXKzUzTkdMUzllRjZDN00vbXBRMkJ1NmpUd2hj?=
 =?utf-8?B?cEM3MERUNFVKSTJmOWorMkZUOFJOeFpVdVRUUWJsVllPcHh6b0N2bFVmaVBY?=
 =?utf-8?B?TlYvb2dEREpQaFp2ajJUV1JtcXNuVzBuRW1OWGltVjI3YjRXbThxKzhhWEYr?=
 =?utf-8?B?MndOODFRRjN1OXVTb2ZobjlneEtqS09qcW1sM2RLV2JRRXU1bW0xaWs1VFBI?=
 =?utf-8?B?Z1V5S2ZDdTJyTDZjZzVHdkJLZ0lFL3lEMy9mdEZsaDBsWGY0ZkRuRmQwM3RL?=
 =?utf-8?B?QVBwLzBJVTN0eTBveldHLzdsWGRzc0o0clZxNlhMNEREQ2VXQWd6aGJjeGNL?=
 =?utf-8?B?azVHZkhyc1k5RzYwK3dSZk5xZ0FCVjZ2NHJQbjRBZzZRR1pPbkc2bkVZdkZ5?=
 =?utf-8?B?MXFZOFZDenl6ck9QQnVqOVB5WHVOZy9QR3ZYMWlMd2FyY3dJMXh6MUd2TFVU?=
 =?utf-8?B?TGF3U2hBM0cwNE5oNmdaSFBKQVkrVW1aVjNFc0txQkU5SS9tMytwOHNRcEdo?=
 =?utf-8?B?QmN4UTg1czNyRUFHRzNNK1JTUkJsNlRhSmdMOU0zK3lZeS95RDlMbnlhdzBh?=
 =?utf-8?B?WDRsMjZhWW8xaEdTMlNzb3llTEJZanI0allvUEs2eCtNc1lKMUdTOGdtUFNi?=
 =?utf-8?B?dEpHQVlFamtHeGorLzMrbXo5UEt6UXJ6VFM2MGJGS1dubVUvQTkrb3dUNDRP?=
 =?utf-8?B?clZIcXpLakREV1NPdDBMdTNxYXpJWkl2M3R1UUFsdHFleHhKYWlmWVhmVWkz?=
 =?utf-8?B?djc4bUFrR3dUQTFKcHV6OUI2cGd0b051KzU2WTFld216RnNXYmt2WGViRWFi?=
 =?utf-8?B?aUQ1ZWtHQ0E0NkhSOFk4WG42VVhPeTVkdHZGSWZ5bWZOWHVpM05oUVMxb2JG?=
 =?utf-8?B?ODVuSnhSd25wZXhZejdxQTRjSndNVWV2cnRLRmpuUHJPNG15cVpjK05CeHF1?=
 =?utf-8?B?d1dkQkRHNTBQNjlBNGIxbzFJNWZsSEg4OGNFSXBaSkNLVDBaMGNZRkpiNzEz?=
 =?utf-8?B?OGtpczFRclh2czhhTlgyTDN1ZHpod00xakN3aExjazZDTGhDSHhZaEFabG43?=
 =?utf-8?B?UldJa2g2K2I2Y3NVUDZnU1JWeXVYd2ZkWE4xR2hXOXRNakF3OHJ0YUdGLzYz?=
 =?utf-8?B?MWd0Zk1jSFU4bjMrU2g3dUtnby9rRkxZUTdna3R6YVFQWVRzT3NzOVJ3ZDRy?=
 =?utf-8?B?cUN5b09oUThHZ0E0NTh3M0dkTE1XSFhEZ2FBRW1lQ2p1aTd0WW5tT0g4Unp5?=
 =?utf-8?B?cEVmVXdQbGtzYXlkQmFyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkY1dDdGVGFhOHFnU1lnS3VxU1BFbnRyUSt4UzZWSlErVU1Ta0xrbUozSWVJ?=
 =?utf-8?B?Q0t4bVlPc2dSRS8wQW5mSUpzUjVoWkd1dzZoc1VNUHlIa0F0QTV3SE45Vnlv?=
 =?utf-8?B?dmViNGd0Yk5sTUp4aUZnc3FiRlNWcWVzdThEbWVqQjFIU25nMVVqTitOeTY3?=
 =?utf-8?B?azM0cnp0TWo3d2tNTURsV2RIV2crZFJWaG1Cc3RWRjJVekdUS1RRZmpEM1VH?=
 =?utf-8?B?bXEyUTR4cWNIbUlXTzIrOERXZW9EbmpsRW9GVXQxeDQ4bytrQUFWV0VmbHg2?=
 =?utf-8?B?ckVhTWxhSmREeGtwVU9kNzE3bHpZdE9ENVVuVVozRS8yTkN5YXpyN0J5b0Ja?=
 =?utf-8?B?VkVtSGZvTG5wSHN4N1R4aVVYdnlmOE5ydWVjYlZ5WGh0VFZITjlsWDJ2MU9w?=
 =?utf-8?B?Z3BYQy96SnZ4UDByakFMUVhSZjg4TW4zdnA2MVV3aUVmQUFOQWMyY1J5RER2?=
 =?utf-8?B?RWh2eG9GZ1d1ODJlWjUvSlVja2RrTkNUcUUweC9HRlF5T2FXdzdlSVlrbzJn?=
 =?utf-8?B?eitHbHBDeTVVWlJsQzFCalVsdGlwSk00Zm5VTy9zTlpTc09RMmVQU1pVc0pT?=
 =?utf-8?B?N2VFazE0b0hDTGVRTXdNeGNkK1BmWkZ3bGJ0QjU5RHhHTEJOdW8xWWt6RUl2?=
 =?utf-8?B?ZWVFdHJVaTQ2enhpVnBmcmcyQkl2aWN2NW8yUlJtalJNWkpPVndqakhoL2ox?=
 =?utf-8?B?WFIwY1ovam9hVWc1YkhQU3dSUUpPREpwWVZYVW9BaUY5Q1VLWldwdVhUM1VY?=
 =?utf-8?B?amV2aFlONVpNTDExN1dBVEtrcDA1YzFzWWdXb2JBOEhRUG4rSXhOVjlWL1gz?=
 =?utf-8?B?eUVvT0VEWGdaeUgyVlVUWU4xcWNxNTlIWWxsa1dxcHcyejhIMmpBOEJhMDNI?=
 =?utf-8?B?bVY1ck9URGlwWlB5dGVUQjIzWWp3cWJKaXFuNlJBZjRETTlKcjZVNG9TeE13?=
 =?utf-8?B?ZWFTb0xDa0xYU2lwOElWZElDZFRubk1uczFxOWdTbTM5S0dRNGJXSDRuS1k4?=
 =?utf-8?B?aFRoU1Y1Nkl5UC9RcmhmNit3VnRESWY3aC9kU2tIQlBTaVc4ZkdOeWxuaUdz?=
 =?utf-8?B?YzQzR2pnYTdEUWxKNzZxeW56Tnoxc1ZhU0lYMmc5UXRISXh0VFBaaWdDb3hR?=
 =?utf-8?B?a3JYbUR4d3lIV2NiZlB0eXV5NFZMeEZsOEtoekpScFhkK0F5V21SdVBJdjFG?=
 =?utf-8?B?WndtdktEVzNLVWVQeStqMkJTTDJwc2l3cHE4U2R2bWZIZkhHWWR4NEtiemFs?=
 =?utf-8?B?K1l6TjlobkNmcm85cTIyZC8weVRWRWllN0ZTN0JsOUYxancyY09RaEluc0hs?=
 =?utf-8?B?V1o2SG5MY1BxNlA2Y1FHdVBqOFcxSTViQkxmR3JFYkhrY0ttMnZHQ0orc285?=
 =?utf-8?B?ZUpWZFJ3eVBtQ29kcUFqak1seEs3VTM4Uzl6Z2pjc2RGS21mSVdiSTNhbC9n?=
 =?utf-8?B?aTc0d0Zsa0JmNk9WYVNLSE1zUDZDTmF5cWtuaGVqQmpqb2h1VkgzNkpBZmFR?=
 =?utf-8?B?MnJXcFFCZy9zNFNGTGhuRFcwcVB4bzJNa0p1dXF0SlRZK3FPQ25Jd2w5RlFp?=
 =?utf-8?B?aXRaN2U2dmlmenFPM1V3cE92VTREZ1B1VzZkUS8vR1B3cGJmYW8vYjF0R24z?=
 =?utf-8?B?UDFVc2hoblRSTEJzbjY1SkU5aW5TY0hCMHB4STdwamxXZnBHV09zM3liU0tp?=
 =?utf-8?B?OFg0WmVlempVa3prSGJ6Zk1lQnBLaDNzWmRPbTdWQnB2NGppOFhlb3Fjbzlj?=
 =?utf-8?B?K3MxbFRmb251VlFjOEtBcGRYMFEvQ1pmaUVleDNrYzZabXpLNnJ6bDY0QThP?=
 =?utf-8?B?WXRBUXRFTjE0V3UxY1hjTFNScGt6bkwwVXQ1UGFnNExtZGRFL1dKUmxIeHdU?=
 =?utf-8?B?WDF5bTZjTkFjWVhuYzdTNFRURTd3Uk1pWEpOdG9kbnZXbXF6MU8xZ2ZGLysy?=
 =?utf-8?B?eitBM04yd3JidjVFRmxzcWo2bnU5YzdkcmxQTWt4Z0FQOGZsUE4ySVFrdCt0?=
 =?utf-8?B?MU9oa2pEUzF3aWNyWnhIdFVBNlk1clpuSWY1NHBmenpFWkVORUw5d3dZZzJ2?=
 =?utf-8?B?blNpb0ExUC93S0NzbGNYZEZKMmtzdnArcmpXOTVaWHhrMU1IMGdTTnhJYlZU?=
 =?utf-8?Q?hPoQA1c9z6Ilz5q39aQhYiA3z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed09e2c4-8fe0-4918-2311-08dd1ad89ae8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 18:12:57.2020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRyHSTzd4AT/IJtw+qNawK6WLz/H+g3KTWTSnhUrQ2S1EW+dbj4BDmzdIjRWUFY5qGxB9hEY3cPdbEuiFPVr1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472



On 12/11/2024 4:30 PM, Dan Williams wrote:
> Nathan Fontenot wrote:
>> Update handling of SOFT RESERVE iomem resources that intersect with
>> CXL region resources to remove the intersections from the SOFT RESERVE
>> resources. The current approach of leaving the SOFT RESERVE
>> resource as is can cause failures during hotplug replace of CXL
>> devices because the resource is not available for reuse after
>> teardown of the CXL device.
>>
>> The approach is to trim out any pieces of SOFT RESERVE resources
>> that intersect CXL regions. To do this, first set aside any SOFT RESERVE
>> resources that intersect with a CFMWS into a separate resource tree
>> during e820__reserve_resources_late() that would have been otherwise
>> added to the iomem resource tree.
>>
>> As CXL regions are created the cxl resource created for the new
>> region is used to trim intersections from the SOFT RESERVE
>> resources that were previously set aside.
>>
>> Once CXL device probe has completed ant remaining SOFT RESERVE resources
>> remaining are added to the iomem resource tree. As each resource
>> is added to the oiomem resource tree a new notifier chain is invoked
>> to notify the dax driver of newly added SOFT RESERVE resources so that
>> the dax driver can consume them.
> 
> Hi Nathan, this patch hit on all the mechanisms I would expect, but upon
> reading it there is an opportunity to zoom out and do something blunter
> than the surgical precision of this current proposal.
> 
> In other words, I appreciate the consideration of potential corner
> cases, but for overall maintainability this should aim to be an all or
> nothing approach.
> 
> Specifically, at the first sign of trouble, any CXL sub-driver probe
> failure or region enumeration timeout, that the entire CXL topology be
> torn down (trigger the equivalent of ->remove() on the ACPI0017 device),
> and the deferred Soft Reserved ranges registered as if cxl_acpi was not
> present (implement a fallback equivalent to hmem_register_devices()).
> 
> No need to trim resources as regions arrive, just tear down everything
> setup in the cxl_acpi_probe() path with devres_release_all().
> 
> So, I am thinking export a flag from the CXL core that indicates whether
> any conflict with platform-firmware established CXL regions has
> occurred.
> 
> Read that flag from an cxl_acpi-driver-launched deferred workqueue that
> is awaiting initial device probing to quiesce. If that flag indicates a
> CXL enumeration failure then trigger devres_release_all() on the
> ACPI0017 platform device and follow that up by walking the deferred Soft
> Reserve resources to register raw (unparented by CXL regions) dax
> devices.
> 

From my initial reading of this are you suggesting we tear down all
CXL devices for any single failure? That seems a bit extreme. If I'm
reading that wrong let me know.

If you remember I did try an approach previously using a wait_for_device_probe()
in the cxl_acpi driver. This didn't work because the wait would return before
probe would complete of the CXL devices. From what I saw in the
wait_for_device_probe() code is that it waits for drivers registered at the
time it is called which ends up being before the other cxl drivers are registered.

This was the reason to switch a deferred workqueue approach. I do agree that
this can become a guessing game on how long to wait and is likely to not wait
long enough for a given configuration.

I'm open to suggestions for other approaches from anyone on determining
when CXL device probe completes.

> Some more comments below:
> 
>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>> ---
>>  arch/x86/kernel/e820.c    |  17 ++++-
>>  drivers/cxl/core/region.c |   8 +-
>>  drivers/cxl/port.c        |  15 ++++
>>  drivers/dax/hmem/device.c |  13 ++--
>>  drivers/dax/hmem/hmem.c   |  15 ++++
>>  drivers/dax/hmem/hmem.h   |  11 +++
>>  include/linux/dax.h       |   4 -
>>  include/linux/ioport.h    |   6 ++
>>  kernel/resource.c         | 155 +++++++++++++++++++++++++++++++++++++-
>>  9 files changed, 229 insertions(+), 15 deletions(-)
>>  create mode 100644 drivers/dax/hmem/hmem.h
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index 4893d30ce438..cab82e9324a5 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -1210,14 +1210,23 @@ static unsigned long __init ram_alignment(resource_size_t pos)
>>  
>>  void __init e820__reserve_resources_late(void)
>>  {
>> -	int i;
>>  	struct resource *res;
>> +	int i;
>>  
>> +	/*
>> +	 * Prior to inserting SOFT_RESERVED resources we want to check for an
>> +	 * intersection with potential CXL resources. Any SOFT_RESERVED resources
>> +	 * that do intersect a potential CXL resource are set aside so they
>> +	 * can be trimmed to accommodate CXL resource intersections and added to
>> +	 * the iomem resource tree after the CXL drivers have completed their
>> +	 * device probe.
> 
> Perhaps shorten to "see hmem_register_devices() and cxl_acpi_probe() for
> deferred initialization of Soft Reserved ranges"
> 
>> +	 */
>>  	res = e820_res;
>> -	for (i = 0; i < e820_table->nr_entries; i++) {
>> -		if (!res->parent && res->end)
>> +	for (i = 0; i < e820_table->nr_entries; i++, res++) {
>> +		if (res->desc == IORES_DESC_SOFT_RESERVED)
>> +			insert_soft_reserve_resource(res);
> 
> I would only expect this deferral to happen when CONFIG_DEV_DAX_HMEM
> and/or CONFIG_CXL_REGION  is enabled. It also needs to catch Soft
> Reserved deferral on other, non-e820 based, archs. So, maybe this hackery
> should be done internal to insert_resource_*(). Something like all
> insert_resource() of IORES_DESC_SOFT_RESERVED is deferred until a flag
> is flipped allowing future insertion attempts to succeed in adding them
> to the ioresource_mem tree.
>

Good point on non-e820 archs. I can move the check insert_resource() and
add checks for CONFIG_DEV_DAX_HMEM/CONFIG_CXL_REGION enablement.  

> Not that I expect this problem will ever effect more than just CXL, but
> it is already the case that Soft Reserved is set for more than just CXL
> ranges, and who know what other backend Soft Reserved consumer drivers
> might arrive later.
> 
> When CXL or HMEM parses the deferred entries they can take
> responsibility for injecting the Soft Reserved entries. That achieves
> continuity of the /proc/iomem contents across kernel versions while
> giving those endpoint drivers the ability to unregister those resources.
> 
>> +		else if (!res->parent && res->end)
>>  			insert_resource_expand_to_fit(&iomem_resource, res);
>> -		res++;
>>  	}
>>  
>>  	/*
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..c458a6313b31 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3226,6 +3226,12 @@ static int match_region_by_range(struct device *dev, void *data)
>>  	return rc;
>>  }
>>  
>> +static int insert_region_resource(struct resource *parent, struct resource *res)
>> +{
>> +	trim_soft_reserve_resources(res);
>> +	return insert_resource(parent, res);
>> +}
> 
> Per above, lets not do dynamic trimming, it's all or nothing CXL memory
> enumeration if the driver is trying and failing to parse any part of the
> BIOS-established CXL configuration.

That can be done. I felt it was easier to trim the SR resources as CXL regions
were created instead of going back and finding all the CXL regions after all
device probe completed and trimming them.

> 
> Yes, this could result in regressions in the other direction, but my
> expectation is that the vast majority of CXL memory present at boot is
> meant to be indistinguishable from DDR. In other words the current
> default of "lose access to memory upon CXL enumeration failure that is
> otherwise fully described by the EFI Memory Map" is the wrong default
> policy.
> 
>> +
>>  /* Establish an empty region covering the given HPA range */
>>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  					   struct cxl_endpoint_decoder *cxled)
>> @@ -3272,7 +3278,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  
>>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>>  				    dev_name(&cxlr->dev));
>> -	rc = insert_resource(cxlrd->res, res);
>> +	rc = insert_region_resource(cxlrd->res, res);
>>  	if (rc) {
>>  		/*
>>  		 * Platform-firmware may not have split resources like "System
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index d7d5d982ce69..4461f2a80d72 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -89,6 +89,20 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  	return -ENXIO;
>>  }
>>  
>> +static void cxl_sr_update(struct work_struct *w)
>> +{
>> +	merge_soft_reserve_resources();
>> +}
>> +
>> +DECLARE_DELAYED_WORK(cxl_sr_work, cxl_sr_update);
>> +
>> +static void schedule_soft_reserve_update(void)
>> +{
>> +	int timeout = 5 * HZ;
>> +
>> +	mod_delayed_work(system_wq, &cxl_sr_work, timeout);
>> +}
> 
> For cases where there is Soft Reserved CXL backed memory it should be
> sufficient to just wait for initial device probing to complete. So I
> would just have cxl_acpi_probe() call wait_for_device_probe() in a
> workqueue, rather than try to guess at a timeout. If anything, waiting
> for driver core deferred probing timeout seems a good time to ask "are
> we missing any CXL memory ranges?".
> 
>> +
>>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  {
>>  	struct cxl_endpoint_dvsec_info info = { .port = port };
>> @@ -140,6 +154,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  	 */
>>  	device_for_each_child(&port->dev, root, discover_region);
>>  
>> +	schedule_soft_reserve_update();
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
>> index f9e1a76a04a9..c45791ad4858 100644
>> --- a/drivers/dax/hmem/device.c
>> +++ b/drivers/dax/hmem/device.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/module.h>
>>  #include <linux/dax.h>
>>  #include <linux/mm.h>
>> +#include "hmem.h"
>>  
>>  static bool nohmem;
>>  module_param_named(disable, nohmem, bool, 0444);
>> @@ -17,6 +18,9 @@ static struct resource hmem_active = {
>>  	.flags = IORESOURCE_MEM,
>>  };
>>  
>> +struct platform_device *hmem_pdev;
>> +EXPORT_SYMBOL_GPL(hmem_pdev);
>> +
>>  int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
>>  {
>>  	struct resource *res;
>> @@ -35,7 +39,6 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
>>  
>>  static void __hmem_register_resource(int target_nid, struct resource *res)
>>  {
>> -	struct platform_device *pdev;
>>  	struct resource *new;
>>  	int rc;
>>  
>> @@ -51,15 +54,15 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>>  	if (platform_initialized)
>>  		return;
>>  
>> -	pdev = platform_device_alloc("hmem_platform", 0);
>> -	if (!pdev) {
>> +	hmem_pdev = platform_device_alloc("hmem_platform", 0);
>> +	if (!hmem_pdev) {
>>  		pr_err_once("failed to register device-dax hmem_platform device\n");
>>  		return;
>>  	}
>>  
>> -	rc = platform_device_add(pdev);
>> +	rc = platform_device_add(hmem_pdev);
>>  	if (rc)
>> -		platform_device_put(pdev);
>> +		platform_device_put(hmem_pdev);
>>  	else
>>  		platform_initialized = true;
> 
> So, I don't think anyone actually cares which device parents a dax
> device. It would be cleaner if cxl_acpi registered the Soft Reserved dax
> devices that the hmem driver was told to skip.
> 
> That change eliminates the need for a notifier to trigger the hmem
> driver to add devices after a CXL enumeration failure.

ok, I do like this better than the addition of a notification chain
added to kernel/resource.c for what felt like a one time notification.

-Nathan

> 
> [ .. trim all the fine grained resource handling and notifier code .. ]
> 
> The end result of this effort is that the Linux CXL subsystem will
> aggressively complain and refuse to run with platforms and devices that
> deviate from common expectations. That gives space for Soft Reserved
> generic support to fill some gaps while quirks, hacks, and workarounds
> are developed to compensate for these deviations. Otherwise it has been
> a constant drip of "what in the world is that platform doing?", and the
> current policy of "try to depend on standard CXL enumeration" is too
> fragile.

