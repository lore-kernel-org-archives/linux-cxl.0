Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5A2CA9;
	Wed, 29 Jan 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156395; cv=fail; b=fyLAlXa6XUPYHczxiVF4U5szl2wtWrBGUd+VXCYNpY2vyxYr29HFJjvF4AILaMFXmrOvChFHuDAOYZpXCvNJt5auKl0t0u0igUohLP5ynwJMCXTpTigJC+b3MD1FZkPM2+vCDW+mz/yM0Xqb8FY0FKWXMZdOwCa+/r+lO3oAG+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156395; c=relaxed/simple;
	bh=gD7GVZl3oCLxF4NYABJ+YMZF15hUPnwskrbl+tqqoRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r4LuxdO6ym+kN27ipVtt2bf3H/ty6SpFboRqvVQm7nSVULhokcATEdN3bsbuDWTKMpBnk7/j7nbDhBc0ZNqtrmV56bGnZHqQjK35QpWqfjxjjKXrrkV9V4LZ+p3F5plN+RYzIfPY5IX8E8ue0ZsEKGKTODwrMjazlNj72+vaSSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W0qbsToi; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W0qbsToi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWoD34G1xaM2/sqyQ628To87bxWLKnQpNzAFnB9dd7QwaLf8hK7K6hB+j1HVVHIdPHUD3P0z6ETWDzGyv1W2RukXzYOMSmG64s2ia9DocOr5PX2MeKzyLJhIS8vo9889T/jYr6p2lkz1KshcXG9hpYQ8wTP41VPmTtQnmqvPF1SCL+eJ0DbqRYCMuCjRjL/YAzVWeEZooa85PAdDZMqyeUBmSnl48gqUyB2ssNN4+X15gknIghFwC1iWH3cgwa5ukkVv2bqGY2DZJztTt1HPYivaYTtMk2CQjs5u9TKcSxKJ+Cidb/hmqjlWq/cj3/qEBsgTltOlttbGkN+RPYhZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2I5o8kc4yZjl0/p3vbqNBTNNvtIirZ64PNV3cqhwq0=;
 b=VFUeDdLSll/oj/1SUoIQ18GpRIP5L3xfhW+910IbZgDx7AXyZj/Ha2ZrjhArxesXj1LI+6En0Y3D2rSWGCBVKjJtZD7FGVMfLWnStk3VZHId1Ux4cHN9LTViXfIy/EO5r6/qyHWUujYxW+PLZlaEio2q7Zbew4Mnpmm7H+lHnEZgofQ3YKM9Mn5kbALxw5rI7/20KcKsZbCy8lr3oYgjBFgRySx9X/zWUu1D9mlKjJ51Mo3lFGANuxe4OwEHqNOQN269GN23O3KoHKZXdlJcXIiVFIaCAxzamqFfX0QbdaWE/aiXObfjnGClfbia1ZrPTeteXSjj0UD+rC58MMfQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2I5o8kc4yZjl0/p3vbqNBTNNvtIirZ64PNV3cqhwq0=;
 b=W0qbsToiHhFRAt977kjXbqX8I8i/LxQBRTETvzSkS5sjdvFOXytKRCZEhb2OGy3fWP8niJOvEk2ADYwRzA0YvfoLRG8a71XjInSaMn1xPeFhhN0K37gLhgvVBMrVlBjkiTerDoccOPy4dwjdlHiCNKsOkoj1R0YtLdSrh6NFkI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 13:13:10 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 13:13:10 +0000
Date: Wed, 29 Jan 2025 14:13:04 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 06/29] cxl/region: Factor out code to find the root
 decoder
Message-ID: <Z5opYLL3Em4YCyiX@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-7-rrichter@amd.com>
 <20250113165935.000021fc@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113165935.000021fc@huawei.com>
X-ClientProxiedBy: FR5P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: b90d1b07-ea23-4998-7449-08dd4066adc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ybe5Y184bAdDOKmK6QjZO0yONtUSWCfNqqI3Tr9GaqlNTK+coP9mPLNdqw9J?=
 =?us-ascii?Q?GoJdJ7CMxJEKBgWZEPpisfGxq2tEUJLFCdNUyE8VxisfKHX/V38ulZwfsCwQ?=
 =?us-ascii?Q?3SryHTJ2OnCeLQtXx3h/z7esu3fg1woio7Cot5juTq1c9kwyHzm5tvtHdRfn?=
 =?us-ascii?Q?px7igGPe+/+4zRtHZ2xEmt0X7qLYuRuO31jBMW/ftiCxUjIQUxckp3uEyZJb?=
 =?us-ascii?Q?NmdMWmLevXpw5bd5qdwwNbIVwNLLd6jFQ8s/kbWUg25DUY8vcPuP8SinqsCc?=
 =?us-ascii?Q?J5LQLJdAGgen3YIx8Db7HfAoJQGfrOiJcjqPJCjLdtayHtdcQwufU5scSpBv?=
 =?us-ascii?Q?VM9DqOOGvIPIzpJfHyfVAcPj0ylkeiyu+A6v7AhaLwxRKTzNy8CHHfsGzfR3?=
 =?us-ascii?Q?PP3ZDS66cHfE0TCdyZuCrvaBZerxiKrfCcb/wCuXOqBwqJBGpzd3g21hP6CV?=
 =?us-ascii?Q?OiseCXbv11Hxsb3kOsSG++Qq/uGFYWTCO7KYuSVJUW3npYtAQPg8f9rSMg+i?=
 =?us-ascii?Q?njZblZzE5dqlrOkWmxoWdGXz5TNxGAI9ga4zGscp00gXdx2QKh0lLfHjdBy6?=
 =?us-ascii?Q?6BuSIf5ZR9UOzoqUndSID+dBSPGErZVkAB2tEnBamPHCtm3eNqlQ0AFJ+jUA?=
 =?us-ascii?Q?kVU5agZiiZEeViOrvpyoQE8GzBMxIZo3/U+s9g11/S12+FLzg7hAgo0vvr76?=
 =?us-ascii?Q?gw7/U2mVXFFXrmIXPkEePm5fVLOHTtVypq98IQfAh6FJkHY2GG7sGEmaxZ6y?=
 =?us-ascii?Q?lmHdxmx0QX5RQd107SyENS5nRScSZ2uhUtQpa6+94XctAYFoDdkGwVMr9fHv?=
 =?us-ascii?Q?SYr6/QXUfmaWP7lByi1cl+1IJdfw/lHtbcG/gwvJc2ePatM2qiH/Q4BnMGFJ?=
 =?us-ascii?Q?0XTlJ+ITFXmlVdjA3fIzd7HbKoqzc32CQ9ycjoJRwGkYr09AEa+Cg9D410Ch?=
 =?us-ascii?Q?4b7WoyDUMJtucRTTffxg2TJ5KL0l66Rnmr9MzM9MqOSxFhwjXd5udzDveHm+?=
 =?us-ascii?Q?T4DRAXCu/Lv03du1c5cySrQ+6u1oacBtHS50934KxAsS+kxkecy2JcUxcJgn?=
 =?us-ascii?Q?QBzOZC6W88G9w/lOyDc0F2C5iDUqATCHWWdhOKg3Ppk11yLWyI8VtVNFjCD7?=
 =?us-ascii?Q?tVvUjoh/36D+DY7x4+2YuF4jdCmGh21w/kiAnGj7iCbtMUr5dLAzAXtTYC0I?=
 =?us-ascii?Q?uaBVctxC1AztfngpJGGdYdCFVVWJZNV2RRmrKoDpoLvyBgmn3t08sWL7Howp?=
 =?us-ascii?Q?lcmsnM02ryKSc/rvw5H9TRXdAGgEhG2Pb6P5ULY/Fz/Bq9l5rBlh87ZwHGCD?=
 =?us-ascii?Q?HVhlGOAFY7cQLF2uT8g8+kdu+CEgHZM6hqe+HEtup29Kji8La9yXkG3+3qtj?=
 =?us-ascii?Q?XoWqEnadB7ZKoi0emQ5c+l9xcrNo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XExhigacBXZ78O+f5YyAwD16NSIDHKWLZSADpNs6HQPVWNYCE8afZ5b7sMoR?=
 =?us-ascii?Q?EbOTA2JzN9IBC05d0gNo2oOB/81VcbVJNFUGs5vAcO4qqmKoPaTomgFWZPsh?=
 =?us-ascii?Q?qU+3NcxMZsoiPILdJnTesXr0ySDf1ccH1XFNSvMQdjRWZ01j9JbDVoZ66ylU?=
 =?us-ascii?Q?NyuHJExs2AZROX2VB2CK6m5lFSqY5AGf2fTxr08ABdaokoVLPpyPLfOCAQnk?=
 =?us-ascii?Q?1Qe0WPbeOAiBOpU0MX6bOmVRNf6KU3cLUA0TMGJnYK54SUdTj1D0z5n9orGe?=
 =?us-ascii?Q?+p0jvNysEKNWkznx/yMpPHmKPG4m7ljkShoIdnyaHPVG9R77Z8NAMziRYBhs?=
 =?us-ascii?Q?U07s+Kkh3t/ANtVZ34deqPoZtkXw5YxgUafu2QPu5tFryRneSvZGZFkGQtnW?=
 =?us-ascii?Q?o1/TykAFfhKxtV4g13IxreV4FAtOoTCnzaTm4620oM+kSF4fO7ZKU0oRuRyS?=
 =?us-ascii?Q?piZTd/MPBQM3ohAc2v2yThqQ0GHnS/esczyA0QxgSrCagBG00ygfNIVOmfON?=
 =?us-ascii?Q?1EoENqzRTyS2E9QvDIaCQtmQuLATSMC9W4g2cabDxk6H/CB61r+e+UbnoLx8?=
 =?us-ascii?Q?NtyIOVED7MeUxVBp7cmfVvWTDLTfAZXK665DVMaM0Dm/gyCmudNsc0vOHI5i?=
 =?us-ascii?Q?6CcvFXfmcDPd1AY6miKDWeN8pJBzH0DKcU9luEARpj4SymEM/oGoYTetv3uc?=
 =?us-ascii?Q?btxU0ZTqQd6GG3bltYztiQCHOkLz8O+xYqdXSWQ0anC3WgHuR3YtCyDsF1Ja?=
 =?us-ascii?Q?TvBoOlCq1WqVGcME58RQ1DK0N+zZBQSUN2gswrJxGRvGr38r0Y3ekuPNpewV?=
 =?us-ascii?Q?zu7wY76SNkWONYLm57ZbjHbEzLOgdKIL+WnIj6qYQXQKKmQ8GTKWDwCl6ctR?=
 =?us-ascii?Q?JcjvZ1vk5rE4OYatMqJ/7dTFNPXDg5G3A81rSyKEruFm6acqWyxHTAZR34XH?=
 =?us-ascii?Q?DALfyOiG24zE6hZSYOPv4G/8BMpP9yNFBsSBIIIno7jMq+7sQXVncox0wqZK?=
 =?us-ascii?Q?8x0ott6bWpP9pkaPSgrqMaZG3gEKwmCwiy7ug28Is27lv8XqVGJQWRFfIOfw?=
 =?us-ascii?Q?UVSBGnGdX3pq0hE0oa0FjvhGv9c/nrM0eE+ee7BpqpuVlGvJMVrGiVJfLmlv?=
 =?us-ascii?Q?IgaKYTFB4dPsmgU5An242ZkuEI7xCNwcUVq8YDe77ae8NsWgevPgsLMEZVeM?=
 =?us-ascii?Q?YXMML6ROxZSsHL1agq0JWHyfUhHOS4fGpukQ/WRze7uuImqIxq2NDx79kv1l?=
 =?us-ascii?Q?QlRWQgyKX3ZQCfyVw4QsxKjgmayaaWHKHLZprIXgV24tlmmXmzL0NSjSynz3?=
 =?us-ascii?Q?4Uam1X6Jqv0Pxg7sgNti64uh1wZauOl3smL+h5s68w1MFXyRJu5LH0CKqZwN?=
 =?us-ascii?Q?Ew74bL/Tj96L8zVQ+b5h56Brgmq2mc+p1QzqrEd1O4PNkzEvKOWJOKGp5mpy?=
 =?us-ascii?Q?t8Fuhr9d35oocKcOukr0GV5RNb3nn7ByKRE0lxVvf+EJF37AMN7sSCXMVq0p?=
 =?us-ascii?Q?BA+k2FaU5/lPiSnuyoqGSPa9yJBBXo47U8WkHTwZkT9p+Z+PDcoGNw1qvdye?=
 =?us-ascii?Q?+mWPs5NV89VXPa3k8zwLnvK2CFwa/VKdNSJmi+b3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90d1b07-ea23-4998-7449-08dd4066adc4
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:13:10.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8U9dDyKd40dIbm+7EQ4hX+mY6vDvkc/EVYIxzwUwxyRefhyJLt4GZqHVF6jsUpEbS4YszLXteC5BM2z6KSE02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036

On 13.01.25 16:59:35, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 15:09:52 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > In function cxl_add_to_region() there is code to determine the root
> > decoder associated to an endpoint decoder. Factor out that code for
> > later reuse. This also simplifies the function cxl_add_to_region() as
> > the change reduces its size and the number of used variables.
> > 
> > The reference of cxlrd_dev can be freed earlier. Since the root
> > decoder exists as long as the root port exists and the endpoint
> > already holds a reference to the root port, this additional reference
> > is not needed. Though it looks obvious to use __free() for the
> > reference of cxlrd_dev here too, this is done in a later rework. So
> > just move the code.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> One trivial comment inline.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++-------------
> >  1 file changed, 37 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 752440a5c162..448408918def 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3202,6 +3202,38 @@ static int match_root_decoder_by_range(struct device *dev, void *data)
> >  	return range_contains(r1, r2);
> >  }
> >  
> > +static struct cxl_root_decoder *
> > +cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_port *port = cxled_to_port(cxled);
> > +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> > +	struct range *hpa = &cxled->cxld.hpa_range;
> > +	struct cxl_decoder *cxld = &cxled->cxld;
> 
> Flip this and the line above and you can have
> 
> 	struct range *hpa = cxld->hpa_range;

Changed that to:

	struct range *hpa = &cxld->hpa_range;

-Robert

> 
> which is both shorter and matches original code save a few moments of
> thinking.
