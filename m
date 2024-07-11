Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972DE8BFC
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731151; cv=fail; b=EwrPYD3LODr+B+xmYzIFloqgDs3g5PeNjNe3e46a1Ts2gwTcrV8jeMNk2tOKUbuMEmJyYXR/fieRqtbeSEmjWJPhs3B2s8E5bjkjQUqOJtUIymuVMeMCFi2DqVBn9UHca8F5QDn358dMzYSgwA8klPgYKLZovTVPAHHhQ0Y7yv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731151; c=relaxed/simple;
	bh=uR0D+84/eyXNJ6gt1I+hnDuCHXa80qWsVh9RVX7xqeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U3/HqCQfDX0Jqwk4DlmQBbMdLUWD42OF2T75gRs/K8FtXaaXgF7eFr9lzHjVOe9g+bjSmnApZy7+RepKiOflywvdWHl523PvUnNVBRcYRv9XLEU5DxYFCZkN9EgiVjmqJiZ0yImNpzk/yS8/6AsImfMD/K6dKNFCReMew6SXIGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JivavSWV; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JivavSWV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxL1/ygm0ietlEBxLx3DXXQjHpfmj1EE73UyHkRBVUFosvVxPNDLDYk1RiqnBefi23xTW804kuQTk8nFJjrb1uK6VC0ik3WhKsnynBfI7oDO9AqvQ8M4DvKIItxKPdMCwGnG0O0WBnkzXhoRZ9ZO7cVSWVTsb2u29F8T/AhBIP3lwdz2hdmp4aC8LqrqUJijIVEQ3/yJUi4i8YtScCjKscGDMSwGqikhTAFRdztMmGAeKYdJeL68WONsVP7tnhWicYfFyF1In3hvnN2+0/xk6Xf+MF6Csy0fLEjQJmigHhN7MUu0rpoq7GoIIo+NNDEOzX1LsEYkGFlWjs+5OnHAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdIZCD8VhKKIYy4NQqG2oXNSUbUEel5wEd6fZnFFbTU=;
 b=Le94RvBXmwvcpU7CpjIzBDl9BY+uQpYgrQnvWfXYk41JX4YWEOVKbmY3pAQb4oYVrKDy+7utaoaR45zuQy3jyE0o7GvYhjmJl1FPT63KnEHFpcEq9SpKtyIR66jZXmJF9rHPYjstpw1rtmrUcubTkDm9k1JzHXwgrOE7ZpIfEsqGNjUA+ylgnSy4pWhboQXwt3mccGB5ALFH+fP+lWWjrdNzuR20zxUvfSHOHuK6OijMO/nhueTvbl9hVqffY9fG58oR9+PSQjck9wS/fthtUL+KL++hCWLLJmBWgcEtBdkQwoK6+sc9uu/nqjLYgVeXCXJMCasUkQox5Tl6NHFTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdIZCD8VhKKIYy4NQqG2oXNSUbUEel5wEd6fZnFFbTU=;
 b=JivavSWVYbU6nf2vfUC+Vi5zzGosHdqSh2kbqMCIc0JkNVdqn3/ZvySZ+ESKebpa2+GU73s1Jc7D57yNTOiCvAG29+Y8RsZY8acFyoQVCdzEMyFrqC/2eUJJgru4EQphoeu5Cukj7WuX5tYaTyg6hs8YSAwq43FMoglGsMVaXEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 20:52:27 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 20:52:27 +0000
Date: Thu, 11 Jul 2024 22:52:23 +0200
From: Robert Richter <rrichter@amd.com>
To: alison.schofield@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/4] cxl/core: Fold cxl_trace_hpa() into
 cxl_dpa_to_hpa()
Message-ID: <ZpBGB8AG1dLN1QIl@rric.localdomain>
References: <cover.1719980933.git.alison.schofield@intel.com>
 <452a9b0c525b774c72d9d5851515ffa928750132.1719980933.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452a9b0c525b774c72d9d5851515ffa928750132.1719980933.git.alison.schofield@intel.com>
X-ClientProxiedBy: FR3P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 4163027d-f84c-491f-e4dc-08dca1eb5f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7YhzsP+BZIoMQa7s7MNDSjSoIu/qPaVMroorOTzqa7+Iny/3CyNnrDdLJkua?=
 =?us-ascii?Q?RpMe7K7cxcOj+T6DoDsz3NXZhc/Br5aD9EOQLbMIboCuyJoLZoeNhnmH51HR?=
 =?us-ascii?Q?F8LRDZCzXbLy8SddpFQ0nwESxZm1zx6ukvnKu6Ry+yF2d4Bm6ASChfV3tyNJ?=
 =?us-ascii?Q?KOP0Na0by5t6UnNZnC6BS6KA7cq3mJlMYPB4uJul3CBJ/nTPJkM8J7+PhtBY?=
 =?us-ascii?Q?msOxrue87yv7li1m1+rSf99nnsq/AzwGM9xIhMpb+ueiW11fkmxAi6IvcRVh?=
 =?us-ascii?Q?OUaPL/6g5RiM9GqQItstv7Hpnxu+DPkn5VKlnpeE7EIMwnkYuXlyjgZJn0xx?=
 =?us-ascii?Q?D6veFgNpmHJCWnemcMSF0WQbAUVPYF6PciWsf8jhIqXsBZUZARbNalRPncoU?=
 =?us-ascii?Q?OkVK4KRGLCVSpa9h6xnRhnn//Fu0l2unkOFBQqc2e8XZydCZqZmqaRpU8pCC?=
 =?us-ascii?Q?E4StsPsgeQmMgJfBt+5IizQDartW/Eh3+PGwO0BqQYjekCXn8W7q2J5E/RqM?=
 =?us-ascii?Q?KgYz71DvAC3RTpOw70U+BTlmQC+pzxCQFvXKWxhBj/wmXdQYZEGnSwJsb5qM?=
 =?us-ascii?Q?ltyggVeJmqlXy+IOOETvnVwPh7JCWVmIXd8YYaa+jPgkCWh5V5hO20sRcKx4?=
 =?us-ascii?Q?3wqiyJ4pKwo5+boG9cbPe5mlveEX6Kgtnxj9jieoRcnUCxmuHbF4z/nfs7NQ?=
 =?us-ascii?Q?RYcMbVcn7utfQktDss4vlkwMgd3RnYyg7LaLPOaT1rtL86EW+D2EaU24YvUj?=
 =?us-ascii?Q?z/Lsuglp/uHll5pUNxT5gbprBYziVXzfRIiFj5JO3IZ+1tf0Bw9rUTRnpk37?=
 =?us-ascii?Q?+G9eTdIc1KQ9z/JIs59QVUJ0HkxRJ1OwsJpfkezH/vsRWBpkrf+NvyfMRTXO?=
 =?us-ascii?Q?qGhJ/Sehop9rxOo7kgZJBiKPvSJwl2BgG+E/w1K9SWSv2MMCkMGtvPjxyEIc?=
 =?us-ascii?Q?nO/4Ltk7w9dKminTaG7lAWUrajqGLTM3UJmG3n/L9H0UAHB9vFGrA5HLRsib?=
 =?us-ascii?Q?/cnrO+3JceQc4lKJsRRXTue+yxghUQG8J1m78x7lsba1vxy5a+Xmu1wOkr/L?=
 =?us-ascii?Q?7Y9wAq3M4e4oAT+qVnrThXIqoXF8/SQVl4Efe9zAyAWlJQYe+/6vc4QUAEsT?=
 =?us-ascii?Q?QSDUFVVQB0juobRU4CdvceE/+urSPT2t97YHmzRbW2ODaBWd2Ls0iGrUYiTb?=
 =?us-ascii?Q?Ht4w3m8XAZFSq6VtdGta+l82uTS+tfjrvxuHNBx1bfnbglFfuwwEnQfuKpoP?=
 =?us-ascii?Q?ha+EcR2hnbXXRXZWuQwjSt1MEpXDGTx5rlT4Z82t9dglpQcaZqmaxsGVUcAa?=
 =?us-ascii?Q?h346Q/ou7lLo3tO5t5YiMAD/LDCwAAvqEwAQ1fjvUV0UTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fgg37ZaLMuq03HkkjQyAPE077iiWCP6cg98tpge3Ew3YbkMfSiURVsb+sBDn?=
 =?us-ascii?Q?ErgABtzjybllGS4JsiDMWAkpF0y7KB1devSKkU6gNoLzGhhtrBCZoWW41hhW?=
 =?us-ascii?Q?AM7DSPQEWYeMcDznwEyJnibHKQEdmYTq/FSf+b/c9sBbHIuKG28npI3ktB0i?=
 =?us-ascii?Q?2nI+rWxHfcoPqyXuL4XpX49qgOR6C7DEV6W3bHjc7ovxkXT0JHMdbmyJ8tCk?=
 =?us-ascii?Q?kLryCxdA4LG4SxCO0dupF2xOSltWpjPpzwF089HHvAgLP+Gk4HwKcaM24xMG?=
 =?us-ascii?Q?iY6dqmhl3IPcLmcOWndYlzfdO5yeadhPISeEtJaDRvzlf38UAXUm4xVPVe38?=
 =?us-ascii?Q?vb07BM/9gizoFSVVT+BIZzWWhoV5EzxXbn+IyhYlNcgh/IJbfkhVFSqDMyRZ?=
 =?us-ascii?Q?HRbnHgg/toC2UObuxXKDbFNb6jBVzYmJMlx97wyeRlkcWNpoOm0LF9oB4ncy?=
 =?us-ascii?Q?a7c39FpEvDARha9XaQTAMPmFvXRiHEgXUonz7lRC2Oz6O1CJv2y7bNgFr2S0?=
 =?us-ascii?Q?fvR4OaMgiaoS0WvBQ5egtjpNnsyjsz8gjw2lcnX51CqYK/UI8hRtM7UDJjeM?=
 =?us-ascii?Q?3AD7dmp52a3cmSMJEUm8BVAuNNmLI104td8OfyaLIC5b3k2vtWv86EI13iVk?=
 =?us-ascii?Q?c6bYwNzy195JOKYDEVnT/z2Sr8hejsXW7smJFOEe+MTdoEd+nQrto02DNgSy?=
 =?us-ascii?Q?Tl2cIpYr38efM8huHxPc1KfixwNEozVMjjG4qxnUwtIkEI/jR8+AzCULKvy6?=
 =?us-ascii?Q?w0wQesu7a0uRBFCyubwmEBja34svFFTSL59gHtMk4X1z1xr+fKS1f1ntUUpF?=
 =?us-ascii?Q?/vdakhLcw4nnNle5jIaSAzqeogGyfg9Cwh9Q8M8jFVuV5w9dJQ3KRLbppnLT?=
 =?us-ascii?Q?L6Akg3ILhfNm9yPSgw3Y0t6Px4HEMWp/NleFP3e3cpYxw72HjTUC0356snaS?=
 =?us-ascii?Q?nKPNZhJBhztNRRxcycRhykmFqcAHZSzLmeeFsq4CoeiCLocbQdjh97zU83A4?=
 =?us-ascii?Q?WAeG30QjkJyQR1G9im+5mvGC5FCwjJNN6rYbXj1DW2qEJYj4fdPXfxNzU3kq?=
 =?us-ascii?Q?wdGwnPWObACWsZ17fXdsuy3KcxVwSHttZknWd7zNl8FE0pgXySyvPWwK0b9b?=
 =?us-ascii?Q?JKLfVlZhSifiDfYW3enUSGNZccodCHMPk26lqvoc5wYHBK7evUi/06zjuz0z?=
 =?us-ascii?Q?fKKoQKXw2TNL8i33LFgmHbuH44obTPUwVVMfoZXt9dn9wIhiTTcjEmrNxCNK?=
 =?us-ascii?Q?Qlgx7cI/V8rwv1XwPgZHXD1zuiXnxB+baV73Bd1uyYlth1fQ3hVkYxfscrYR?=
 =?us-ascii?Q?Gn8T3MUT7b/6sjJgfpvm9L+DJsxcRnUofsn2MTROUuDcQZxcQJuy/MFNKLH+?=
 =?us-ascii?Q?9GT3JRlO2ImGT3GsliUnUZxPeykuU/4hqGJ5AvTOKdgVxN2nezqj/XDFARW7?=
 =?us-ascii?Q?7Gut1XeBWyJDo6mZ6TQ+9Fu/aSjbFqBrnRGCdqAq7iK7Pje3BNQKIkIUdJ7s?=
 =?us-ascii?Q?s05IFh0A2XBlYj6rmRhR92qAyqQw8XkrH9eRbsVs7kORgYUgx1GAF+St4c7+?=
 =?us-ascii?Q?T38MgtLpkm8kuUWTYolW5Z0t0ZSqFeMJRy6qAB3C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4163027d-f84c-491f-e4dc-08dca1eb5f72
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 20:52:27.1992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oFc7a7N+nnzPud1sgKG1g2XES9mSDjj8fu5Xzo3kt7LnubP54aHW0W7a4cn/EZKs8gY7ki3Js6ZDtzNBTuQGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

On 02.07.24 22:29:49, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Although cxl_trace_hpa() is used to populate TRACE EVENTs with HPA
> addresses the work it performs is a DPA to HPA translation not a
> trace. Tidy up this naming by moving the minimal work done in
> cxl_trace_hpa() into cxl_dpa_to_hpa() and use cxl_dpa_to_hpa()
> for trace event callbacks.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Robert Richter <rrichter@amd.com>

> ---
>  drivers/cxl/core/core.h   |  8 ++++----
>  drivers/cxl/core/mbox.c   |  2 +-
>  drivers/cxl/core/region.c | 33 +++++++++++++--------------------
>  drivers/cxl/core/trace.h  |  4 ++--
>  4 files changed, 20 insertions(+), 27 deletions(-)
