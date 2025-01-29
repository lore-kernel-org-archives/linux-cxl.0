Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A842D627;
	Wed, 29 Jan 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141128; cv=fail; b=pBOnnC15CvUiEnv9jfT/WpOhrkkDXSj0X9xLwbnTAsk4K9ryH7uqTyV/yTAyZXCy6C5n8HEuGWgqwcZmCsLbXJ8RoHqlQVOe7BhviIsaZyHBQQ1UdGwKAyy5Y+N8JtqpqJlbp/blptKoUOOKezCcwg6nbrK42OY0F4RLTaF+rVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141128; c=relaxed/simple;
	bh=0keQI1vliK8/qA/fAPW0y8UXm2HiliqidbNDKtOn1Xw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PT4fKQZ+cZfRFOwMc2Qc0wcKHoZK0H2jFAafkGRHE2IxfRVBnIUSQLj6kDfygsFX7TG7XBag5J9YuJWdrxQNvZW2dz0DVzIn+4/S1w5LOhqLbGzGAncwxSUr6Nuyxx/+LRtojLYgPStgoTOupbpS/eQf+rUfO6iGSDKpnK/5Tv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wJojzGJg; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wJojzGJg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WykCYA208c0Q4JdRuffKUC1bbCFb5JPuM5cZFax4I2hJtEMwPc7oF+CxkoHi8f6I1SJvVb0miWzFS15qu2d919SnTCpIlNhuSF5RZUQc5wBGRJx4CJkmiqOb9BKDpGwybpEfP8CL7xBrkAZ6vsHh6Ut5ZZe4uF2obo12+6mb0v2u8w+szj6pdpeRri4s2ZlNzYrKGW2HSxIBdHlYYdYBr+dyC+d1ztLr0zB7fOZg4fkXAIclteMUO//1sg7j1qErDIIKlh8JxHSLHIUeBg5ZeZaVIGUfXzIeloxn+qnm9PJcP2JdI9PXYpbeJUy58yF0m/g5mvnMlw4e4rlMVaHMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue7kGwHuIvKO52MwLno/s6BajBXs0sSMQtxZLmTVpbU=;
 b=pAlPz4BzY0/8muWzxqrZE7QpV8Ll+ghJpoLjgh13b3zgwa4T2M/nfEx69R6aFr6ZHQFpxoHK2xrrBMNpQeBHlyv6E3OpshywMsWFOn35lZgmuW0hvHlpykyUmdpzHvWZgXIot8oEG3DPqSA4kijied1Xa8wIDTEC1SWfgXsRQ3dGoWuKxDVD8Qlq/xsDqaP72KiRa6GKav5mXhnsyowGDovEZPgGsqPqBCWPwt9HmTXebpKZpDclw4Xb9LF4A24VJae7D9lHZUGX0Q8dL7EPLXwAI/SuxtYwERzM+InLw3XZ7OUD+ko1mdK0O34bP/pbttbwEGa/NCWqSue2D5IJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue7kGwHuIvKO52MwLno/s6BajBXs0sSMQtxZLmTVpbU=;
 b=wJojzGJg8d1BtVRscUXJFazYOntIRh0odXWPuY5BtSmTuLraSKrkXRjmtBU2hN9jV7a6h3qsII3+S8Z9sGNQWbRavbtzLg4m3Vac4XQgydDAfpa2yw/P+sdPBjmXSBo9nqBxTra5nRXOr2S3QT8OFyHmh2XJ97Iuc+AUzH1V/Gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 08:58:44 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 08:58:44 +0000
Message-ID: <6671561e-e8bc-6787-3948-6e6cddc4256a@amd.com>
Date: Wed, 29 Jan 2025 08:58:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 1/2] cxl/memdev: Remove unused partition values
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CT2P275CA0108.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:25::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 485495f9-06f1-4081-9f02-08dd40432248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NS90YUtpaTdOYndGMitVZlBQNDlxVlUyN3BHaFk0Nm0vRHF5M3YxK0NFSTJm?=
 =?utf-8?B?UEVmQ1dnNVNLb29XRkswYitiUnE0VFg3b1BOMFRwcnRkd0FRRG5jTnRwWGl0?=
 =?utf-8?B?OVd3eVJrV2xLTWt0SS9CY0RBUDRKdnFrVXQ5TUV4VndLZDg1N2hvSHFwSm5p?=
 =?utf-8?B?VXlTU1NDN1VKdTFldStobTVtTnlPb2liS25NNWVOS2ZDaFk3UEZlUSt6M2xY?=
 =?utf-8?B?SWNBWGh0a1JoRWJaL1VoZTdwaE1jZUpBVzMyS3B1YXdhZHR4RVBvNk1RR2Yv?=
 =?utf-8?B?bGZrZkw0c2J5RENIcWdYRHFkOSs3VHF6dXJoWlhsZjYyZTM2V3YrOEFYc1Iy?=
 =?utf-8?B?U0tUUHBCdW5BNWovaWVjVTZXNVNicEV3VG9QMUtVN29OUVpFTE5uMTA4TFZH?=
 =?utf-8?B?d0ZEdkZqbHBFTCtrQkhicS8yaVhibmE4bmY0ZldUc1hMa05VV004Y3NKNlR0?=
 =?utf-8?B?eFg5cFp0Q3hoRkJqS2ZHbkl0ajNSMlZXQ25udFROM2YrN1NCejZwTDhodGRs?=
 =?utf-8?B?NHF4MS9Zd0hrbTlGS3U5NERVUGgrYWZpeExBa1BQcS9pelBsRDdOTzd0ak14?=
 =?utf-8?B?QWU2QyttSmQ2L1lsMURXNkkxRHAraEg4UGh0bW43MTdIKzN4d2lyOURiOVF4?=
 =?utf-8?B?a1JaV1U1dDJydFVNbjY2OWRaT1U4L1h6cDUvYlFzTkthZ2taZjNmUG4rL2pl?=
 =?utf-8?B?NzN3ejFkc0lxdU9Fa0plckdmV2g0YklubWdJTHp2MXprWlhFTURGV2FsQWlt?=
 =?utf-8?B?VWNIK0d3SmlySFVVeCtKcFZBTUVRQWQvRVJzeGV2amdCaFpVVTVsYUVMM1dC?=
 =?utf-8?B?YzdVaWpFUWdoWjhWZVQ3a2ptWTllV251KzNwcjArWktHa2hDbGpQYXlFVzlH?=
 =?utf-8?B?UDN4djdLODBFeEpWQjE1bHBpSHRpZzJTa1hxYkp0Z0ZjZnJ4K3lpVmc4VklF?=
 =?utf-8?B?L0Fka1dnVEd2WVZPWlNIR1RIeGJ0RUR0K095cWpxM2lBdHZOWkdNNmxpcXpV?=
 =?utf-8?B?dE9IZXRSdGlxV0hna1pjcVNxd0lPTlgzZmFsbmliTWlsRk90QUhvaFV1RFl1?=
 =?utf-8?B?N3VNRkQ2cENKZTQwZmNsS2RIR0k4M09MSUljenBSeDVDRU5yTmVzOXZvL1Nl?=
 =?utf-8?B?SnJWNzBReUgyd0RKYlg1OS8wRGMzZTVlZUwwdkZBREw3Ty9HaHJEeDFvekd6?=
 =?utf-8?B?bEZwaHcrWWhwWHZtSGU3NnFGOUphalVvMVVDV1VEeXc5VytFUVNUMWJNeXAw?=
 =?utf-8?B?WlpNZUJUZUNIUmxucmFVdXUxSFRMOUtBZXdCaE9DSkpTanRaMkh0Wng4bzVj?=
 =?utf-8?B?U0hEdnF5Zlp0V1NPTG5MbE42VmFEbVBTRWRGMVM5d3VLNVdOaWhvVWRBTlVF?=
 =?utf-8?B?UklmWVF0clpZN3NHNDB5Sk5NZGxPRFhZL0pza1IyWkNsTTFDcC9hYmdkYm9N?=
 =?utf-8?B?cUxEMFV0dU1UQ3B2bW5ZMmd0R1p6K3FBRGtvOHVMUmxSV3dqQWs0UUdkc2Er?=
 =?utf-8?B?V3ltTVNMSVE4NzhSeG44UVFDV0hjMGFoTk1OT1BtL0J2dlNCbnZtdXdUaS9S?=
 =?utf-8?B?TlRTeHd5ZVMzbkNUYURVdFRqM1JIRzRnVE0wbDBlcUxsdUovdG1BN0FxdTZE?=
 =?utf-8?B?ekV1K0NUcWJWS1JNV2NRejVvZVhvWlNEUUJzcjlvbHdrWWh1TzhqbmVGdDhE?=
 =?utf-8?B?aVZta3pIY0hNd0RsSjl3bERpNmd2UE1RS1ExL2tQZEJnQTluUnFlVlFVYWxY?=
 =?utf-8?B?MkN2d3BaQzU0VHJGN2NBUzhnaGxEUCswR1ZjQnV2dTN3a3JzVnBpSGhHQkJD?=
 =?utf-8?B?ZS9Sb0k4WFQwMEZqU29hK2QzWjRuWWZDbUF4NVJJbDBHc0V1ejVYNFdudGFY?=
 =?utf-8?Q?aA/xquiWwqcKJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDhmRnV5NENCd280Zjh6MzNpc1RJM25JcElhWHpPOFpka3JTRWJlbFNhdHpL?=
 =?utf-8?B?bFNmZWZEc3BmRHEwRElrbERDdVVyZ21UYUpkRUV5SlYzQlphRFlNVGZFK2k1?=
 =?utf-8?B?Y05Kb1BZV1dEL2lDM3hKdzJ5RCs2SStMaFVGVDFWTm1WQ3g5RXF5Skczc1px?=
 =?utf-8?B?S25tTmwzUzBVZU5wOVRJOGFkN0R3VTNKSzVYbHQ0UkFJV0tjeVdjMlh5S0wy?=
 =?utf-8?B?NkI1blJkRk5DMGhocGVhaWtSQ3NqaFYwalp0OUVrcy9KRUNyeld1MnJHOHVx?=
 =?utf-8?B?dmF5MGRXbDR6MlpDOFBZcUQzYmxvS2JQS1NBNWRZWTRrOElaN3VIUmQ0ZzNz?=
 =?utf-8?B?K2dtcG5ESG4velZGZVlIakZOSU1md08rVExkNVplYXJUQ2V3WGphak9JZlNW?=
 =?utf-8?B?cXlrUW5GRjNtdWphKzJ1K0t0d2l6NjNuRC9KNzVYWjhBV1lmM2hmdFdjeFZn?=
 =?utf-8?B?SEZzd3JJTWRPclZSZ3dOTVZ3RzFPUENlSldXRjc5SEFtWDRMaDAveWNWRHRt?=
 =?utf-8?B?dDliVVhPWW9ZV0dDaDVTeGp6U1pPZzkrUUtkbWVmNEs3NkJXY2RLT2RPaEox?=
 =?utf-8?B?ZzFKWnVKVGszdlJCWjRpMnhzQ0JVdUQ0bk5ETlV0cVlJYUVvL0I3SFhGb0tS?=
 =?utf-8?B?a3RVbFh0dFB4M3RLZFZSMGhiejJKdFp2TUtkNEh3SXVCRlhHdEhrd2Z2NnBn?=
 =?utf-8?B?cTJEQWxJYWRKUndEVjFGSzBPYlRSTFQwb1IrZ3doemJESlpUSnB0YVVMU2ww?=
 =?utf-8?B?NHVIMWV1dkVkcWl3OUhoZWsvWHJkeXdoL0hOYzNJcnFJR0tCOENMdDRVZmYw?=
 =?utf-8?B?Z09FNXR5eG9WNXBsbjgzZE5aVDZCa2RmeWNQYWZUWktBaHNNTktTVWMzZ0Yr?=
 =?utf-8?B?Nk84RVFLSXA3ZW9DTUNnZ1JzNE5Cb0JZU2g0RmhMNm1ncHV3RHlWbmJmV3Zq?=
 =?utf-8?B?N2RjTS9maWNramwwR1FYUTErRFdUMjlvMGpwRThpbEVEeUorRUxnYWFyNm9z?=
 =?utf-8?B?L2xKei9hZnYzcFROcXpGMzJSWXl1L0JzTC85UFhiVVJ6TW1tRXBZc05ZN2lY?=
 =?utf-8?B?Uzg3SVRWYU13NzdQSFd1Y01Bamh2aUpPVkxHUWJmUkZ1TkdVOThzK1BjM0Fx?=
 =?utf-8?B?WUQxNmtYb2MvRnpUMjdVUFgxRkNzdzhtWTRpVThsckJyZFlBUFZHRVpVM3Bh?=
 =?utf-8?B?a3hFOUNlVVZuOUk0NVJxTElTSGpuK0RPa0dmOFNIbGsyR05mRCtuUWtBVkRB?=
 =?utf-8?B?ZTZ1TGswZmozS0VwWjJBZmRoM3ptSXdXdnpubjNQR3J6Qk00azdsY1Z0NENr?=
 =?utf-8?B?aWcySFJxa1Q2TUxnaUFja3B5VTUvK1FZL0FPek9zSklpd1lxejh5bVhLNTlM?=
 =?utf-8?B?Ym52TFBaL0pMOFhQRktyakdHUFViMFFOYUgzK1lvTmRtWDlWZmhZanZJNS9h?=
 =?utf-8?B?QlQwemprVjVVMlZVckNPU0o3d1VwVTNLQ21HZDZXWUR0bzdWL0JtcHh2eTZK?=
 =?utf-8?B?KzEzZUxwY2JlcWJPTWcydFVyYStILzUyMGFVa0VNL3Z4N3BTQS9XQmx5eC9V?=
 =?utf-8?B?N09DNm9qRzdJR1hEZW9WVUJtTlVLaXJHUTZCcDRKcFp5R0lrNjJ4azljbkhr?=
 =?utf-8?B?UGVWMEM2cUZ2TFF1WTVZQm1KMm1ZM3FLelptUUlHSy9oMVZ1UnEvYWdDbTRG?=
 =?utf-8?B?b1c0VitrRjUxeUhkZFZMTXJoYmRheGh3bHd6cWt4Vlo5NHJud1RSanNMaXZD?=
 =?utf-8?B?MVIwdW54cm4zSVp6QldMNU5wSVZjVnpiLzdyN0ZnbFNBOWlRQmxZL2FDcVh2?=
 =?utf-8?B?NnZjeXBZTmFvZUF1ZWNzY1pLeHlGZHV4NGFyQVQ2WmU2UzdBMi9vSzkveXhu?=
 =?utf-8?B?V0ViRW5zQTNVcC9lY28yNlROdjNDbnNJQWRRMUJFSlYwcEFrcmhqbUVhM2lj?=
 =?utf-8?B?WisxRUQ5M1RiVjJFMGltUU8wUDBlblJYUVprRmx0dTdwa3NrbTJTQ3U5VEpu?=
 =?utf-8?B?UEZhdldLN0ZmZXh3NWxCSkhROXNwVnRoWWF2L1pDdFpoM0hlMUxaNnpzV200?=
 =?utf-8?B?L1Vjc2lNcm8vUEVmbjJpMHB2UmxhRG5aemkwN0V3cm5JZi9ic2dKdDFOTm9n?=
 =?utf-8?Q?0H9H/aM2mIVFRMmp7jP3FMt/+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485495f9-06f1-4081-9f02-08dd40432248
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:58:44.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpjS1cRSV7bjyGIT/oTOVxD4sCHK3NngEzruGhKUqFFa24Z80yqFf37b1uvj4RZ1QbGdsI6U0NuXsIte+WyegA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562

Reviewed-by: Alejandro Lucero <alucerop@amnd.com>

On 1/28/25 18:51, Ira Weiny wrote:
> The next volatile and next persistent values are unused and are
> cluttering the cxl_memdev_state.
>
> Remove these values.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>   drivers/cxl/core/mbox.c | 4 ----
>   drivers/cxl/cxlmem.h    | 4 ----
>   2 files changed, 8 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 62bb3653362f5325cfdab7812633328eac50ab30..998e1df36db673c47c4e87b957df9c29bf3f291a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1097,10 +1097,6 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>   		le64_to_cpu(pi.active_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
>   	mds->active_persistent_bytes =
>   		le64_to_cpu(pi.active_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
> -	mds->next_volatile_bytes =
> -		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> -	mds->next_persistent_bytes =
> -		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
>   
>   	return 0;
>   }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f218d43dec9fd89f950af667ff033d0802084345..29817f533e5e408243d361c46ddbf0c295b4fda4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -548,8 +548,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>    * @partition_align_bytes: alignment size for partition-able capacity
>    * @active_volatile_bytes: sum of hard + soft volatile
>    * @active_persistent_bytes: sum of hard + soft persistent
> - * @next_volatile_bytes: volatile capacity change pending device reset
> - * @next_persistent_bytes: persistent capacity change pending device reset
>    * @event: event log driver state
>    * @poison: poison driver state info
>    * @security: security driver state info
> @@ -570,8 +568,6 @@ struct cxl_memdev_state {
>   	u64 partition_align_bytes;
>   	u64 active_volatile_bytes;
>   	u64 active_persistent_bytes;
> -	u64 next_volatile_bytes;
> -	u64 next_persistent_bytes;
>   
>   	struct cxl_event_state event;
>   	struct cxl_poison_state poison;
>
