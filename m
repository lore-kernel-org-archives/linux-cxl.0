Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F818E750
	for <linux-cxl@vger.kernel.org>; Fri, 11 Jul 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247067; cv=fail; b=q8O3RT+UMffGwE2u7zftoNqsjB6FlPj6Ct+IcQfB6y5133vLmKwt/sz2DAqZ1rPDnp5jFyGwKQ0Q/ItRZIJ3GGnyGLAGI2HGESVAUaip6b3WMQ6tnW5EEB251lmMmPwXH9JCwxjdTuEi/OQSifGCyTr7FJNqhle4nnWjn9t7mAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247067; c=relaxed/simple;
	bh=B5/cxcI6Xv4oSrNucMiy6DfljZB6yorcU1dZSPB8Xno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mJkagt/4gRndON/ZlTUzZHqeR1FTsdfWAiB4s/7JPwCXLVoW8Fv2P70cZ+md7my/I2NQ8bsTySRtUxMY7YzHtARew5Df6hpm+cospyN8f2szQo9UuaE88OJnP1D5B7IRWyh5rHXhlP3/8uf87MUG9tk0Cq9XiEFzn93w3hweLTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tUA1yITL; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tUA1yITL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvmXdScr4OY0eNPwqJbPKysmmEhnyLyVmROK5VYEuH04USoyKCN0G6Y/ze8VDepV9eJ1xFfqV1gor3QTtowOQ6LwxDDRP70GC2SBrULdD8r99JCBQk2iOfux06TtyTQSI5U1FIxtjH/sO4FYyEhkL7oEYEbwV3zGRFnDEacCRsLXANX0lD49KL0OjXXKFJ368okGvwBVCVckMYFlbI1WVenwntR0u3/GbpLoYUy2oyULVNhJj3KjAz8aPB9KDYJrCY6Tr6rcQxVV5jUyiaLhPcP82BdpinvlR1Jo5EP7iEPJ5prpc5AijK/Ovxgs3RA4BuHVo1auW88bDWJjyF9l2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl9MyRUGPkVAwWVV5HgfZMAePnoFEg7itx7/zwkEEeg=;
 b=rj8kXdU8AP4kSKBFoZ7xlRqnTQyQHkwtZhcV0YEz3WQccWaI7IkbMrPvGB8MWw5UFey8NXdYBcWTJLFaQDSHvAxYQVANJjtqROSyk65amMrRNvw189/hO0pf5AuZXAZgZrgFhlmH32T1Df9Cp0tlshEAjtC4gLTjaOOFBVIhk86Lg9lZHYaDco4nbmvakD8cxOhj77Upowex3Zpeu5rRIlBRB3StDeWkaCC5EeWTn9s9uS4jRJjiS61824mqnE2a0ZPg+iQPqcleNSmXSEm59BoJ11l6pQFWEQ3rUX5Nq1pLyF3SyGjF/7Qme7YyTqNM9kAIszGEejPN3x+9mQnrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl9MyRUGPkVAwWVV5HgfZMAePnoFEg7itx7/zwkEEeg=;
 b=tUA1yITLrTM9ZoQ80uWVEvpaCswkj/vqTpf0KnquRDhFYoXmd/WQAJf/hbzeTo65SXraxelB8IzI/AR9iSA4NUWwuJL3wh/WhNb0NE7nddj0V4rc+5TC9aY2qIZ2GwA97g2JmKawsVFGMyAVqvrLLWaOBlxJUB0KslSr7ADi1NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 15:17:43 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8880.021; Fri, 11 Jul 2025
 15:17:43 +0000
Date: Fri, 11 Jul 2025 17:17:38 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [REWORK][PATCH] cxl: Remove core/acpi.c and cxl core dependency
 on ACPI
Message-ID: <aHErEhDLelis87j7@rric.localdomain>
References: <20250610172938.139428-1-dave.jiang@intel.com>
 <5282f0d4-a25b-4fc5-9890-9f50052bd4df@intel.com>
 <aHD3cDOZ4R3Vm7YA@rric.localdomain>
 <108cc808-ff36-4386-bc63-6f38a13dccbd@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <108cc808-ff36-4386-bc63-6f38a13dccbd@intel.com>
X-ClientProxiedBy: FR4P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c46e4b-9251-4a66-b6d6-08ddc08e1571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xNL9oMKSvwae2rQ1fIkOoFNy7cWtgP2NcZwxqBvCFmmMGBuzlcczDFkdi3R4?=
 =?us-ascii?Q?5O1f5b17oycpleXJ4H6lD5G+81hw+LuiOecWco8dA+LLOhylCIRNwuYNEl0j?=
 =?us-ascii?Q?T9fzQQw4JewcjZzMM6eM3ushE/rgvQHifiWN+5Ndkrx2YmEJ+ntZ9Z+SIo4a?=
 =?us-ascii?Q?4zMMNmqT4ozp387pXGzfKew5MqzR6uQ5TpH9tCcHK6ffJmbMZBQM4H3EQFkb?=
 =?us-ascii?Q?LQPkH4CBboALhuZewi5akhnz37ME6nnEYLPu12zbaukIHzQfB+7xhAtzsKzb?=
 =?us-ascii?Q?xN6SN8mMuP00AdNHj2lxYDQcB0QUj4CcqcHNPxxoOEtBwYDSHz/+LAIaQwKd?=
 =?us-ascii?Q?kLtLg+MrkIcc4fV24GR2Dm7Ms5tFzgCvEkCrKWP/ky5NmoMfqizqE+IyxPus?=
 =?us-ascii?Q?+bbeXO42z4n9Wa/mPgFswwTU0CgdU1ns0rq+lRXYtWbTiCC/ajRAAe3HchBB?=
 =?us-ascii?Q?VjXGHRd+gOrGhhJJ6SvXxTKu5PlqIolH2zHYpSrev9w7ZmcKHHDUUBQPZfPb?=
 =?us-ascii?Q?fNqi/jRbPSYLHW8qcMJ+pFHZe4flOkRlf8ne3y3m63aMPZtsRPbJ3bZvEYGf?=
 =?us-ascii?Q?J3u/7st460GY1fdDBWmPCTpBGdFLe+8Cet5SNewChCb6KIVTZZLWfaPLHdkx?=
 =?us-ascii?Q?HP2jA8a+KWFfkB7csTqcVa6DDcoSuVVOv33muGAETzDEwu52nETwzPRsmvQ4?=
 =?us-ascii?Q?YTReO9Abw9lnUYSmhNzSSKV18xYzB2W5vLpsPxipMT4LbxxuCbIOcoDNIsdY?=
 =?us-ascii?Q?dWLVuzjY11kZ7yM0rBtvdY18VS2379p1+RG+saKa1fPc/gY59v7YMx9uWGzn?=
 =?us-ascii?Q?bILOqkuPf97RktSPCBRKfaGjtJr9wTTyPN2mDw3ZWvBm656bGt/t65EwdRhG?=
 =?us-ascii?Q?SQhebYxBGwK4I7LKtpJLudgHodMj0qS95bc3++jZdAq0VVMiOlqJsVVWoE/2?=
 =?us-ascii?Q?8yTweKy/9zvEbBdHvSv33wqqnWU0UjH1NZyWjs2dgiESmONG1eRBzpluLGoO?=
 =?us-ascii?Q?aPftRlkv5P4qAGmm7dekQdIctarV5yNIrVhz3CaFFTNC4qOT5PhGLmbh3Dxl?=
 =?us-ascii?Q?bhBqdgzP3D2oRFJIV5/moZuZZqT3s+tkexd/gqlZhrXEyR2hZhEuz+QbOR3C?=
 =?us-ascii?Q?BI/8sCaBhjDIl76fn8yamarafRVyCzutECIMtn4+StHYhahMoZQQDGD6VMOh?=
 =?us-ascii?Q?CuJJYUOIImdOLB/mOMzdC6xP4nqc0OqYC+qR5oxisFRFIr/D0TYPEDQZ7BqG?=
 =?us-ascii?Q?U12kl9Y+UPzedDjrvfO0ujrdbp9pJ1alwU+AHmiwUQTsxv0eAiqs5vGEBL44?=
 =?us-ascii?Q?sh8J5MIxiBTVzkbT4GeC6SevyeTRz7m5tvl9W9/A2U7w2DiMwmz/K4vRMhsa?=
 =?us-ascii?Q?R4Rs0mEjZvxox5QsDvxRYZs/CD4ej01VDLtWh6iMpzNuAGVllCHJ4trtC8J0?=
 =?us-ascii?Q?1abqM/6LEFw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8+vUii6KtIkArhTULOVAvWIQ342n+vc/2W+iGNyjDcNOgoh+pT9aTa0gCWW3?=
 =?us-ascii?Q?WgRd5TakqfKJaQko8o5Grbah1bFvyScCpHZEhXLozXqoMZXGcbapKPfKuaME?=
 =?us-ascii?Q?I3B9mag/8+58AzJ1kTA93iZWSuAgLvHuy2aVQl4LRSeoFOgLtc6boIsaG0k7?=
 =?us-ascii?Q?yCOiSk5tyfCL22dl953PLykF1h74xNkqYaQKXdBu8GH9fRIgF0N5UOCwNPGq?=
 =?us-ascii?Q?Zayn+6//yAIbnYb1iiksDonANB+uhW5QE3chu7jdK9EbS9FsqO4I6AyQ52oA?=
 =?us-ascii?Q?0k2q/wV06vhsyKdEgOJVwF11HsFJNQT4BGF26JwnNA6N+5mVt8DNVK4cVvuW?=
 =?us-ascii?Q?+ET5Hh++bozD6sF9cEShmip9+kKz146V3cYoqY+0EVUDBB2+JApL7jQKFXOx?=
 =?us-ascii?Q?ool5fe2XyXrwqo+nrQIFxV90ihLG5oR5DaxYDUYM5zPIi0Z4agqSe3mbIrok?=
 =?us-ascii?Q?Y95Cwcmcxd25EuLkfZwEc71dNyZUHsp+AYDWtJa+Iu3cXl1GdkxNvjSnGQq7?=
 =?us-ascii?Q?nZA23yYFuxUdIcH7nsULbO8lJJ+HblGRxnBsLiKyBvB7WkqUMbcpoQU6/a4+?=
 =?us-ascii?Q?GCy02fI9KholGLge0nVkTypfDA7rN9VAHJF6kB8J9+iCk4YLRzdANoo9FKcs?=
 =?us-ascii?Q?7LT+ZRn+YpbfCGdvkQ0ee3Cgr0sL+zQaOVEc3dlsTsl71aGJvjkf3TdCEdx/?=
 =?us-ascii?Q?1Tp2/UX8cl3ZHO4EZj+0F3fRSw2Czq1/+pyXDWYGlsI7RweWPoDdabPy6tDy?=
 =?us-ascii?Q?OH5dp5ZhUcNB984vxUOluYn+gEqUdvdbvabDGvTKvkXFWTvn9SVUra/KQAxS?=
 =?us-ascii?Q?OuQ3KbargYOnd0jq50zdcEv6IWIZFxDY6IUst6TLLOrAifP7y9EjGd8bwCCH?=
 =?us-ascii?Q?xGAvgqvXquCYshqHnouo/4bnUpDCnZRdv6L44oo5L10up2kll1w+tTLURA2G?=
 =?us-ascii?Q?2n8QZlBFCzZz9BaWEOsDM5I8bBxg+ERi5ZYjCSSOGiV4MqysyMk6mqGwFF0q?=
 =?us-ascii?Q?kPmRN+/oBRwguttoLQoVebI0qpBAHh41kV5bXccuGvoSXH6vXgn3TbgfTuTn?=
 =?us-ascii?Q?zUJreWtGlYm2L1xjO/GwZHse1gDpHMxhGOPwWS38F7CWS7Mmzi1MXKfoy2Qy?=
 =?us-ascii?Q?enbuSwKV6gE8v6DS09a0lINrfyOlQCZwk6e9RM/AHVFxzJmQ4dZ4B1YrrhSJ?=
 =?us-ascii?Q?ZWQKspmGMm0ELBlnNe9H4M4Dqx3W+MUeSz5dYR+McFHW0aUBy4N6C8o/N9Wa?=
 =?us-ascii?Q?Cfhy3bYLPnPPtmbSQb3B+M/fwvXo6rePjwnP7/XoeXNPzlIWRseJnls25hfu?=
 =?us-ascii?Q?shxByBZU/HumMQOm83n1aob+ZJaGsXwoh4Zjq1Sem0Ohbf2BKcLHg+s7kGYm?=
 =?us-ascii?Q?LaBSCoeRX1hIVbKnhogqsET+jENaYKUK77brDRJ9zQEi/0Yt2X+wSk91tvFH?=
 =?us-ascii?Q?MKIYwu4E/nOfRnJUNh6ShSvqlT6st6ACPTvNnraxBtcH4s0FxXmD4TFIRYq7?=
 =?us-ascii?Q?yt16mmSjRZNlO/+2kRldHhi4I0qbkNZZQo2MlnxoQnaJ6zFHjLprsOIt5VJj?=
 =?us-ascii?Q?SDVOxKNkKQ14//SE568mocFRImxwh30SKhWVjH7R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c46e4b-9251-4a66-b6d6-08ddc08e1571
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:17:43.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isiOSCM2FYZ9IUR6PlBk+lpBJ4uF4WNMGWnY5d/Bx7zuVavuZK3za9LdRKUs9EqY3/DFZKq6bn0EeuHW66AQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272

On 11.07.25 07:58:27, Dave Jiang wrote:
> On 7/11/25 4:37 AM, Robert Richter wrote:

> > Patch below bases on:
> > 
> >  ac0fe6a57317 cxl: make cxl_bus_type constant
> 

> Hi Robert. I do like the simplicity of this. So lets go with
> that. Can you please post your patch directly to the mailing list as
> a stand alone? I'll drop my patch from cxl/next. We still should
> refactor the hpa_to_spa callback function into the cxl_rd_ops struct
> though. But that is a much smaller change.

Just sent it, thanks for the quick reply.

-Robert
