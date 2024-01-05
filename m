Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9B3609A
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="miAq9Jal"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esH4/sDQ/AfKig4VvMJKS4qJy7YqlplodwwpkyDEWKHuFnK5qWRUfTcWEImK2oRJkYAc3o7RgDWR2K06OCGE3Jp+MTN9EWxYPinjXcGNcXdCnKczqYc8SnINHLZKJ0i3qtf4GeRa1fkRTCjAhRrfY58Xh6oL/NhN6IYq/36k/qVjESzb206JTpHEdnjh0LzdnsGnp21r2GAHxM/38/kYiSUvMUYeAEmSDdyOUdScTUS4gzIq9wPcA3VfEzvxMTWAOkgKEMKCijOFJ0bSvK+6LB4WYG/zVCQQ6TviMTEicQHiyG6Wkkq4ujHnJ7FiGi1uApugPntL3son2o3NkNeRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voQSY7nAJtuLoKrMOTg8tb/nAbNQ/MKQ9VGpZJfGTAw=;
 b=adSJD1AcfGUeiQnJJG6zdoOf4I/caSDiK/3KG8SoGilBJttyATN1pM6Fmh3uWVo5sNLJevwBacIW04gf/EcNfEo0uBfKodhk+Ax3T3LBqEkdyJJhfgEpJIdhWRDkMRd9AuPddy/Sr+V4rMi0nZLTqaE4ccFvb5WzbUM8uQS0cVKzCzzEW2vMiU1pX/pqHN9c20XzB7P9lESLY/2yIa0uwd1lgBEO8HeuZtUJutslUU6+OyxSePcKZv6Mv5dqPT/g6UCtluEBZsMK+txnRFb0yHGqvOE49OvSPuImZHK/WtbFaeJEzy7j//8g4arFNy8+GvZDxFdsuh0WmoIV9eNqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voQSY7nAJtuLoKrMOTg8tb/nAbNQ/MKQ9VGpZJfGTAw=;
 b=miAq9JalbgKFSvSwGJ0Pt8GxWi66fcIrDmzI1cru8vH5QaTRbNpUt5f2Wf+qVRDSgBq3IV9FAefK1tZyOfiXBL7XI8FpH+fmieppRF1+1xnnwSm2XHoPX/Ry7LnnoKZQxDyfqg1QHy5V7/KxpN+bIAjFA4x3ApyqrFNuVhchjLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 23:09:18 +0000
Received: from IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::bc59:981e:e6da:1806]) by IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::bc59:981e:e6da:1806%5]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 23:09:18 +0000
Date: Sat, 6 Jan 2024 00:09:13 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v6 5/5] cxl: Refactor to use __free() for cxl_root
 allocation in cxl_endpoint_port_probe()
Message-ID: <ZZiMGYXZTrxobIoe@rric.localdomain>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170449247973.3779673.15088722836135359275.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170449247973.3779673.15088722836135359275.stgit@djiang5-mobl3>
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To IA0PR12MB8746.namprd12.prod.outlook.com
 (2603:10b6:208:490::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8746:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3d36e4-40b1-4e2d-a1c1-08dc0e435811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	18yV1WUZ6XrD33po2xJRE/Mfpt/f5V8wa3Tact7WP/vpWx/5pzdyoqa+y+xfCCKfOrhWABpFmeINlB+n5IVxwXfR7yKBfITwtaCcyhuMtgxL2ybsLyEGe46UJhQS964A+x3hVVCLhLA3sjiPgSdmMjMYXP43DLhtGfoItupj6mJhEcrWVPIwbfozpXLrPmehwBl3oL0GkvBwmydgt0hqpGdkEgWYe6a7lUAzNcsS5lCmqIB3RM4knVRB1F02azpC+FAYLZ1Hs2ihR6FuSzxyxBF8RtmGoaSmSMdHvO3CBuj54CMU51qSsS1vGxY5g7dDH8koYwl/ONU4FScFY+XpcpS4IHW8zD1f32FrPQgDi2wIRrBKtKaCGfXsBqpeec5dZxchL9er4l27wTdrrr7djKgj+f5u2Et8DwYued+oB5xwU5ddG+W6Fpq1+DTEEK1qtjoka1sZg/q+hOGf4Z1oWH0vT8p4X6IXTOROEODAv/Qn36amURJFKrwNFOk5Br1jxs1P6ejpzI1nVihyLF9i34QrcIAHpomuzOnpsvdKcAnm2Lr1Chtjigek4t4VXXBi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8746.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(9686003)(26005)(53546011)(6506007)(6512007)(6666004)(83380400001)(4326008)(316002)(8676002)(5660300002)(2906002)(6486002)(478600001)(6916009)(66476007)(66946007)(66556008)(38100700002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UrVoxTA7KSUe242gZwwcF41q6T3np7yZYRi8Ke+ZJxGi1uJQgW7nZFFm88Gb?=
 =?us-ascii?Q?Gi7XBqgnD9YTcqe9K85m2mJpEveTIuaeZsWYJLAzzMk5rmdW4QcrR8PdwyTT?=
 =?us-ascii?Q?bxXW4CUFo8538dvLAQNG2humytoL3TS1Olr64N+DzbN2bvvaIrP6HKIltkqH?=
 =?us-ascii?Q?w0tAXtRwwG36ML/a9TDubp5pwhQ+4j43T5CPOAY7BjbXs4wei0MNLkvOKKuJ?=
 =?us-ascii?Q?sDGS2kJCdpdc71tHE+/HT3jJ/Mbj+TUdwK7aQHe9DXH7l2+USC7rY+pO4ucx?=
 =?us-ascii?Q?qUf0pKiB2LKJvJZ0H4SuOQa5NKJe+EMLnWUEwK6LKa8WCqPOpuKOOAL3p1Tg?=
 =?us-ascii?Q?EPChXikrpMes0tYb4oxLuwKa2dOgpVrBr6I8u79drkR8IDNDPx87QDrBYRac?=
 =?us-ascii?Q?04bh9+Poon9rJlXDTPU5QCDCx7SARMdV4JgAwgkZvKfi2zMva9aYqpCgMpz9?=
 =?us-ascii?Q?xSIFdDtyu1u9aeovzXyoYyes6IkPlrqLOrFD6ZFxPeuNU/ZQ2ohwBaGQXlm+?=
 =?us-ascii?Q?ivyRP5CvPenmSzFrbOXBCt3IluLvjKmhoobzq8MK/4x0JKBnfBr3WOLWFeQC?=
 =?us-ascii?Q?1FrDXzfzG3J8zc/IurKcMUor6CgfgncBjvoGU2ueXgyv64zqr0RUzwbUK5tr?=
 =?us-ascii?Q?Nm2e/AiMTzdpHCzWqEEmyBi+NkHw7ePLHxXgvC5rYkGbvkoj+HBxUFuzPaFQ?=
 =?us-ascii?Q?WMSX51YDURGBa35e4dLi+Jriao6i0rtSvL3a5xdrahomOf+yXLZEa+iX/ZzI?=
 =?us-ascii?Q?1ydwI/n5tChfe7R7acbIYtLgdFzEFaCmY5MJMmA9PiyeYqrqMdw3r/zp6YCy?=
 =?us-ascii?Q?Dfh0AtySOArKNwH5BtezSxgljfNHf1Fv6UHoH+Y+M+40Hw+BYY+zkXs9phAh?=
 =?us-ascii?Q?DnhFS/BiUeHPe999HRlVFOo4z4UmBgSt8Ot/5bEwfu0LDfFenZaInJERyrxS?=
 =?us-ascii?Q?rZdIR00Pg/B+lI1ct9+fK6Is3bopgAkQbtwu0NRrUAMe+OkXPIS+9oGkWVTU?=
 =?us-ascii?Q?vfi4JzMXmL2ErYu3W5/zKw+f7qbmM4kT50obnrtPzDbQzdudoPtZt5vvlpzD?=
 =?us-ascii?Q?pXGMQzKn1+2PhEiyYjL1YLz38WLmFFFPPAExNPSkrmjoGxXG3/wzpb+SC4II?=
 =?us-ascii?Q?Q0XpQ2va8LMKtO5JpAmMyLjZSk8/zUotohntbydHWy+ibSLDGy2UaQXDm/ZC?=
 =?us-ascii?Q?tP2eVncVeyjq8US+7IV5MjCNEJlYsSU3SfTR+rPd+syXr0mjmZ523p+6+ZCe?=
 =?us-ascii?Q?4Pe4BFrnfQ9/dSaogIaepXhm3kvNYkjbXKNWkdweNcGTFoQHOcfAItVHf5eh?=
 =?us-ascii?Q?HXLA3cO+goctJeiEwRU0H+w41VNBWqnk7+jyBD/m7RtsAE4+bYSt5L5etiJ3?=
 =?us-ascii?Q?7sVhN1rf/2JuDlCY58mp+9vxMH+scaRi4HjCAXULmNBwMuhq48ZgpGxiPmci?=
 =?us-ascii?Q?vu693giDJfDBN4N1KsFF8YPOPzmYu1g/Ihgi50bNT+Eb78wyOGdpRRVOZZfI?=
 =?us-ascii?Q?G70nHpWBrNbE1WZv+IxmQM7A2yEh/CS1RF8nHL2xNZjawZ6KHtW5wsQp0h2H?=
 =?us-ascii?Q?uOmsCLQ3ztu3yTVgfrM5CNUEU1Uxxw/wunDJVn83?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3d36e4-40b1-4e2d-a1c1-08dc0e435811
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8746.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 23:09:18.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hq0p1YRkizLLu4LX0L3+5wEUhUzkwE0sjBgFV09myF0jrfZUsT7bPho0vI0s9lhNV9FmwtYsLXhpdwUAjGvalg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432

On 05.01.24 15:07:59, Dave Jiang wrote:
> Use scope-based resource management __free() macro to drop the open coded
> put_device() in cxl_endpoint_port_probe().
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v6:
> - Cleanup put_device()
> v5:
> - Update commit log (Dan)
> v4:
> - Don't check return value of find_cxl_root() per comment. (Dan)
> ---
>  drivers/cxl/port.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 4f3a08fdc9e9..97c21566677a 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -94,7 +94,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	struct cxl_endpoint_dvsec_info info = { .port = port };
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_root *cxl_root;
>  	struct cxl_hdm *cxlhdm;
>  	struct cxl_port *root;
>  	int rc;
> @@ -131,7 +130,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	 * This can't fail in practice as CXL root exit unregisters all
>  	 * descendant ports and that in turn synchronizes with cxl_port_probe()
>  	 */
> -	cxl_root = find_cxl_root(port);
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);

Same here, definition is not at the beginning of the block.

> +
>  	root = &cxl_root->port;

root var can be dropped.

-Robert

>  
>  	/*
> @@ -139,7 +139,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	 * assemble regions from committed decoders
>  	 */
>  	device_for_each_child(&port->dev, root, discover_region);
> -	put_device(&root->dev);
>  
>  	return 0;
>  }
> 
> 
