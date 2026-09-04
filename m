Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22137BE81;
	Fri,  4 Sep 2026 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487740; cv=fail; b=VO6v1k14XZUE0NnlHpsQo6XD80Os/pW7QVtjwCKthsImOxFkbVjCt/woLBl6xxHXH/zA17FPRnLNJmY19VA9zMmBRZFFIvDJ5YyYxVFRx9v+kP6YW4dve1uxcuUIJNxKL7fqJ0wKUmXvi/UJjZuDlSW56sKxBxefjQAICYsRrY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487740; c=relaxed/simple;
	bh=n+AYSYYXSIPF59MbouI8xN2VyP+/e9S8QrGMz8yOl1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fLlF0nflVIdmXOVTz/DNkHEf4JCtKoUvSolFBhfTOpQYJedvD76wHV5xpycZ++A/l1FgUeNbdz/HeGco7aEQXSeMnKyyqvA36GsV2yxgQFaZ8YiS9iuZuYcmOQRiWZontHARAVs/WPUsdvEqVK7gO8v8HiJ4TIyrxNx44JX33ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OtQh/aiJ; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OtQh/aiJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/LHxE7gtgD1p8cSIk6f1LeAUA9wfYuJsTbXrVvfpxTFWbaaLHJQ09ePoIEuqSzLD1YMf2KuTJQhABOY/zoosrFc/RXIW70Qo79tyoA84qcu6O+c+I2JbYcC+JFOPJ/kuY3RzQUTghH17/alB+TpD/y/Lm8VxnN8kTdx5Xn0fmyJnZ3/Fs72WF2J68/nxc5Q7ecKKO6l29Pb6Xdl+1OakQw8JNmOpkpS7yKlWE5x0GBTbUKFsAmYFDAfcrdQd6Id3Bqv8G18gjTKR6OPrZ/SeZy6cUq5snOypcbEuAYGjXARWp2CA9541LYsouRhAURnnC0YQxGX/CjUlkZbX97k4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIMFHij73oMcM4AoiC7akAgWloWq5QLHqpUtIcl0sm8=;
 b=HspLsDs6YySzA2Z/wd2ZCOrVU+CVJXIBlpm++cxXlBYfNQdmbDwFfsb63BvTzvUIChctltJu2jRWcWYrKxxzRK0IrDkdgcW8nsBAYdkNcgvexMLr7AFnY9n1VLRg85/mfQGYY/8TLQXklXTQrLKI1KrfD1vpWkhxpZ/GZZXSt/vrumUINhUjCzoGV3J/Fj3er3d0I9SPgMtGcH/h95DLnO/4Z38fcJDZRsS4RAk8s06XK3rWXztTnMCq4Y2tOuHJXC/f/HPDqVTASziifc3m4tdlACKXzE9mFITotVN3JX2t5YbxmG5mH/5ILH4gc1AqPrDc+Htg1o/uuZut05Bjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIMFHij73oMcM4AoiC7akAgWloWq5QLHqpUtIcl0sm8=;
 b=OtQh/aiJ9jf2//3T/edANPOZx9Ko73V9kZ1FAn6QQpZMhBnKPcFnaAXbzskUaKK2syYJVlMvSXo+o06HSLd26ehrZ2Co9H1k0mb91/eyTq4qMmZf/cGUJCbRM6yzo+E4Mc02BUG/IXObsBKfycD6x2iS0b1CEQs+cF6VYx6CJJUNG8bTlu+9lVznuiGLPw5c9HjvU0i/QFTxBzr2FM42n+j3PFE8SZRVDoZeSfSDfm+7JWN0BQ0TNPRn47Bk7xKE/Tkt+5/p3E+Ag44jxuhIYKNo8kAA7Xf4mLwkfxyBAzRnab2wM7OfNKKSgPINUt1ie2QgzbZ+McKUFs0CIzcfcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 02:08:54 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 02:08:54 +0000
Date: Fri, 4 Sep 2026 10:08:47 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add Richard Cheng to CXL subsystem as a
 Reviewer
Message-ID: <aponqZfnoB9WU1K-@MWDK4CY14F>
References: <20260902235348.3563444-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902235348.3563444-1-dave.jiang@intel.com>
X-ClientProxiedBy: KU3P306CA0004.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e437b98-3ecd-4eac-8a37-08df0a297811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V2SKavl1fZpaLr4PMis8X5WjmzxPe8iFw4kO4rVHPzkTXfMQloISVyp/TPvKb31x2/PEgMYjhkZ5a1h7Ts7ca7QQrjhrVQgoZM/urf34Tw28H8kz7nGdKChL/BK2xO9bfR8+Yxfkchj5zA8cR8IVJ3ZKHt60ChQCosdVHzfVcW5vWHAH+19193aYM8ijUIiHioOQpXoz4bsjmMgmsJE8tmGQiYvOJLcg6tsII/Bc3+iPKz3KWi0oFP4dELe7U3PJ3TYvGhfUfGcbpJsZwLP3XEIyOWwrYypKAey6xfQB5+xbImLcNjz+ddp6vx/WcNq8/4J6myo+UsUoVmA6xKJ2QnoR37F/o5VKtz+AjJi45oR1ugjzmQcrJfL8URUcZxqPOQGl0+H0J5BJ40FmSMAPIs+aDiOsGtbTQ3MZ9QmYMChixta3mrq+I2k/9ZVjZmlRmweWPhcniL+APSEtfvPtBRGe13CUCz76qz8GdEh8c3ep3vdhQEY3NtNdJUzf1ckDwGBMahLlzNl4DTCBayc0Dbg4lpMQ16WOBB1BpBDe4vFfzEMN6rI/C9FWNA/Tww6RPCBKu7jVaHNGAHFaVc3pg3N/4ZrJtzGaBKjiCpmENNlGvSK3qb56aBk0ezfS8NPn2Hiu+op3TLQlvrAmWhL7aCdPQhRgh0/zhmP/C4tO7ws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fcJk1z79DvS/7Cvj+DdCCb8GLTQl6Cmu+Z5LwarnzYgRrnKkPB8nexkQFQpV?=
 =?us-ascii?Q?q+HWhkDIrNY/Yi5mv58OFpX+/u1hqVRT0SsSbtu6xqORXjKI5xfUwJP3Ne/b?=
 =?us-ascii?Q?0LHTXABaJkhNwJDK49PIQqZbzBKhSwgm3DpfAv132J/J3aDbvBld8aoBnfuL?=
 =?us-ascii?Q?nBbygsab5kKZWAoBvloz2in+vR4LNlzslMoQzzyAXn6PZxwSV24QGRjWx2Ww?=
 =?us-ascii?Q?Y9Z1RNFSLYlieDSeKdokQ5SgXWxwCmNG3zhrrnIN++KbsQSVfNsDCNvpfHnn?=
 =?us-ascii?Q?AeUv6dursp7emjzl1yRQQWTctdjKQtDPnOG5af3PrrLfjzGQvRKHazLGfaL4?=
 =?us-ascii?Q?hAbYm9G6N6rzCN1uzdzJ4vOf4p6K+CAe2LU3iGRrY1eYYmnafCTRIUuN3u/v?=
 =?us-ascii?Q?s83PFT+URRHfOjaS6zbzN8ka2cQrVk365Qs3Zd1qyDVPSphomSielOIoxYm+?=
 =?us-ascii?Q?uVL5wcpNyq24McG0sz6z/yiAj6utRpA3W0ShFlCcsNlI3DwmgG5N5h2BCshZ?=
 =?us-ascii?Q?1oY8i+grWlBuyr8yyGbvP9mJ33l8CVnMxyaYRlF0ABo7ToaV8S20xuEvkpQI?=
 =?us-ascii?Q?H+neolUqoQu8DJVSjmnABbesbktVSoqri5TOnxc9XOp3NLk8AHdisMRlKt/+?=
 =?us-ascii?Q?TCYbWu+meUkuwJ5/rQ2GeghkyNrnOf2TxdyiPkw6su7m3npYnzYVn34G1A6G?=
 =?us-ascii?Q?0ZL2stOe6zaKDTiLokANZvhv9jxVETcrtLwq5MPFO+dFSVlyYQECCiynsFoZ?=
 =?us-ascii?Q?6QMnKb9JlPfOMloyN8jh68wjf3Us1mPud7pdTXnO0fobUCvrVBCel7PLOD3f?=
 =?us-ascii?Q?qhsHRih4py9ZGWuztvsPFYcA9tg7C+Za/aD3H/OwG/jfWdcG0EHn0WEMsydj?=
 =?us-ascii?Q?SMuMmggUl0pxCgDQsGPrh6qK7Zr0hkRrsPpLRGZwUNLeadszagAWcEA7L9Zu?=
 =?us-ascii?Q?hW+pSM0SAx94dzodek2FRXIFHt9M8BA6nvx4e93lfb9Mf8XZyuqyR7Aw1jWI?=
 =?us-ascii?Q?V0VPQi+cKpCgvMrfbptIVYtWNnlm9/sBaP2P8e+iG78s8nPhYUudDGKyrjw2?=
 =?us-ascii?Q?R4bbRTeePMNn6cUVGPzwA+ka4Emw7kZg8TCeLQvTxfhfoykFv42fn0Bt32qx?=
 =?us-ascii?Q?pB14ax/s0XSOHsU+EmVBjsqdgQfTKukpBSGBfIuXe+/WzkQePO8WGg6AInZX?=
 =?us-ascii?Q?TmBAPBBFKzwMqm0+9mO0bO3BfhjBAJkTfQvzsEg+LwWVAmpwIAi5H4RoFbVW?=
 =?us-ascii?Q?rWW+3tBfQFz8PNLK2nicbdz26Ntcr1A0hiXRLDVV3n/3xXp9ZiW8SR8SS7dm?=
 =?us-ascii?Q?fQSkHb41IehEk4UzF61ubxz3QiozfEPqfwfVLoJjb/ROFd6nhaTHW4y+w+Bv?=
 =?us-ascii?Q?4SUbxkmzqDPo3n0Oqjf6lCkeVIm9BPZaZav+hz5RvKif83LFlh+crim2PQPY?=
 =?us-ascii?Q?V+m1fmlqLvAPNYFZsmdl0GLzSwpLeSnVbsru3r4yn8dviRs6Pd+h6dGtn5BQ?=
 =?us-ascii?Q?sWi5ZHC0X1lZrM8P3/4nFoo8ePoP6/DPGPAcIsU82r4/+/xferkaf4/nSCvj?=
 =?us-ascii?Q?uoq/JH3YRCEJm4rCcFsDx+lR0FekdELSYN0Jg/o41NNmVUTAHgNCgIajqiP0?=
 =?us-ascii?Q?Rt5CPv+HicNjvEPFU0t0JTyzsw6cuBZamDdlZs7OksL004qhC59NNlIx0FMq?=
 =?us-ascii?Q?tR+4IaB3SOEKAy9S9AQfaVKVBYSJfSxVQQo+DXcFAlnUqlMwRPbho0ka+Js4?=
 =?us-ascii?Q?92wjHoiTOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e437b98-3ecd-4eac-8a37-08df0a297811
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 02:08:54.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4H+/cqmHVI+m+48sEhN6VIkyEd3ILVBj6quTtm7PiqYinKsYOLqCFnru/DLwxvCVIUCcQGo/N99o/ZnsSaFxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856

On Wed, Sep 02, 2026 at 04:53:48PM +0800, Dave Jiang wrote:
> Add Richard as a reviewer for CXL subsystem.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Richard Cheng <icheng@nvidia.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a19da74d00c..25d61ce9506a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6567,6 +6567,7 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Dan Williams <djbw@kernel.org>
>  R:	Ira Weiny <iweiny@kernel.org>
>  R:	Li Ming <ming.li@zohomail.com>
> +R:	Richard Cheng <icheng@nvidia.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/driver-api/cxl
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> -- 
> 2.54.0
>

Really grateful for the acknowledgement, I'll continue to do my best to
contribute to the community and keep learning from you guys, thanks !

Acked-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng.


