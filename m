Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE62FFDCB
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187127; cv=fail; b=BeHv6maSbCp/JYjHK3M1nd6uP8Z02s9D47+x7CmcRZfFcoOtoUhHHMwJXMM/7mJimjja3vGXbea1pc1P2kvvanHYX9Kgup0DrCiDrs7HFCe8XnQNRU43ZtNoXDRRfL5Um4ByCGVbZieS4fEgCVuDny79So0W435AgJF0MDUi6eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187127; c=relaxed/simple;
	bh=GXzoFXiWyEjJdBnYSyifrqY+MIvA7lrquT8lEKkXpNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o/mnDCDUlb5JpTFulSWxDiMhlRs/StO/lEZUV/6XfxtH97Vq1R6TSlQ215Y0vl41ksG6XTCA+bmFlCM5/ot5fIoAk15SsB+zju47KqRfxiBvxDmi1uy1CpBn7dKOGVX99yIi3zqeO91jx4qB1nTxqBmf4XJ5mjXvZ0coDRd9tyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nAYU/Jo7; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nAYU/Jo7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwgE797giN3S3b4K+N5VqkHTv1TTa5Y+bxDcZcB3/V0tY1YEy6yoJ4XhIg4PuyqWIyIOrzas1T9+HS0ocmp6DmL2VuK25k1d64UMToy1GfuFYiITZSvdglkMQb+6bxmMx9IKvUVU9FEQ/5lIq9BjCPQ7w2CDKf54xxhkzr6CtV2LcEGzjju7vX0dLkg5qwF/mKdA8n7bGI01xawRYy4P0H6gzRHNs+I2zB/gXxMMzEfXB+BQAuQIKWyEboUE0z5yN4sNYtolc/b1LV1pOTeRmadZSEAh5ZwAnuSnIIgthXOebCsZHesN+nNg3ful9b8h49Bu7sWhOdYdLEctPuEkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLOQo8ptPX3DCQ2Pqxl24gIQmr3TdLBQbUmWXLUxrGk=;
 b=Ym7qcTDmMUuSPGyrxDbw8Zq96+8q53/cKIEA2B5ejbaB5NupWFPyVj3VcjweOGv+mZeF6wwCF9SP1sqZ5vBab8EFXk1i/78IgLNlTDXj5WUe8lTyUvUYOUH5QClGDiv2JuBc0Yk2pS0FIwGQtygH3jSsSDN6SHPKEDFOwjg3s5r/tdbexWm9uQi3gdQkVwFLgQ9efDMWbpFzair9H4LPFC+/n/Nx3Ahpzev+t+qR3gD3at117GOnbB+hixkxbG4uOKj2yv90BL20pk5QZLZ+4o1OsSmxkfvu1ahnEYLMI5uUGKWEYIcogTCtotsy45ycOfG1R9dyNRkv3G58d2RAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLOQo8ptPX3DCQ2Pqxl24gIQmr3TdLBQbUmWXLUxrGk=;
 b=nAYU/Jo7otO6wDZhVSndF7Uoj7pSDaNR3ueZqSLNAtS7Ap5k4a1Ktnde/UyU4kUK4dfIxTMqknWIsYHpdqNQjz+y9iuJVIxM0nfWBW32lz2NWRPp4bHY/Y+ySVAJzYuO0cOBGOAWeGyMom7PKiZVo3QDTwos9Y7g9ncPqRnfBKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 09:18:42 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 09:18:42 +0000
Date: Thu, 18 Sep 2025 11:18:37 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v9 05/10] cxl/test: Refactor decoder setup to reduce
 cxl_test burden
Message-ID: <aMvObT0Ui69EaRsf@rric.localdomain>
References: <20250829180928.842707-1-dave.jiang@intel.com>
 <20250829180928.842707-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829180928.842707-6-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0356.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a602c3-2606-40f3-6c67-08ddf6945c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S3tT4fdP0WW7fYuQB0jaJe4AZ1OEuU4YgYfCuyfeOCzgV99bBNaZiic7xO5u?=
 =?us-ascii?Q?vmEgtCPQsT2TKKHBZtxGh0C+txazoD07O9wweky8+6OCjcOFW+Q2qoyQI6u+?=
 =?us-ascii?Q?FLv7aZliSFxVLlseKIHKrXAWFJ+8c6ELEteNgan60qynPTFnzfnS+1VZ9vd9?=
 =?us-ascii?Q?FIUjWwDCUMOOR4I2lYm77J0H9OGu9rbhVgchEsemUEDIevVD7WWwSEgmXAzI?=
 =?us-ascii?Q?Sh0f5SMZ8QLj8zfX29MwrVlCemC7il5/6jbfqc4yq5Rm091LAEeTTCZrgx5r?=
 =?us-ascii?Q?rgB3HsbjzPs5fE96q0LaG7d4uiPXSaKpOgtQWhrHmh+H+gbMYRN+N76Hj3+T?=
 =?us-ascii?Q?q+Ebo3e/kNnSyxwMgwkBbAnvf9G0mpm8q3hPbvU2rYrfMfKfim3tmPP+C8TE?=
 =?us-ascii?Q?qzCmFUkuZB1QfncCxvPVhTgEsEYXgBvLrqE1+3GEg3dqs6I2FGfLJHjIDnXg?=
 =?us-ascii?Q?syk1b6C+qKbdiQQipS1+gayuYeHpGCqs8vvGeAPFqeApd0ycY3QV9LoqL6QX?=
 =?us-ascii?Q?aoJm8gcoRrjkzooJd2hFoXufhLml2ynUFixEItvbolYoboJjLuTHhaK6h6+M?=
 =?us-ascii?Q?ywd/xS6+FjjhP3S7qaw5Z5O0dZM13/EB4rgTEHu4SnNY2EAxZeBCj+EBxZDg?=
 =?us-ascii?Q?LcOtBPjnjdwHAn1OqvN+BO/MeE5YR0/1fTAjkf6YCsMjNaMyxTTd79d7Zt1s?=
 =?us-ascii?Q?yDETxme9tiN7ZdZCwc4NBmaeASrCqGfWAk8j5dNA+fFmuESM9z653xGnCb9n?=
 =?us-ascii?Q?enKAzXjuOmr6u/U4FEREkzk6CgNLGsWUOjMTioOJBwrrAkFW9NjcPA8Uj2Kc?=
 =?us-ascii?Q?lhqlcQTO7sovLqPtnPLoMQMesmAPpva7TqXqS32l18i7PxxYgfD0wiDaQ1q4?=
 =?us-ascii?Q?z2XNvrMAoebAwXwb4IuTkUEd3Il2nmX3LUJlEJvABhi8XfIP5zjO60Gwe87w?=
 =?us-ascii?Q?LgFrkaoyy0WJ/Y94BoXcUSf2RjxVsKfwGTwBc0UpF/ASHv8uI39lnG4aBjY6?=
 =?us-ascii?Q?auz2iGkfJNME1G4dr2RXcqMMalnqBR6s06VXpBtLg5Q23X4+BaJU5CAwDvNM?=
 =?us-ascii?Q?Wl+6DkO5bbCQd/2VWFL3+37XgkvnbkG/ZkTnOHtffsQmLPhfj7BxIPQSD7IB?=
 =?us-ascii?Q?RrNk2JZz0ZoLpU1IdCRpWpl3zRDO5Z1CaJQus8/J04l7OcQ1cGhm/4OaW5ZE?=
 =?us-ascii?Q?RgLeuQilfObxDs0LrZ0XdmhQQoYgCzVW8JDyZDr3p/wVA8Z3RKmvD8SZqRf1?=
 =?us-ascii?Q?w7pE4aHe29JyTwfeqByvLIIWHt1Mz6QoChmeTiUyu6H5juc0G0uEyD0haEAN?=
 =?us-ascii?Q?AeSKpOFFRBpz/79g6heFGZCsvRxp7DmFZu/nKIoCMFf3ewXa18EMjwyAqk4c?=
 =?us-ascii?Q?5myLQPTFQPzMQ2i9IFNZnqnumzozL8Epd/aM8dLRhemXDGVtgBJsK1Z2H4YG?=
 =?us-ascii?Q?BlYondtvpIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qBYa9lEDxv5laK/S5TA//aF4cBMekYdtsY0VZDwY73KLUESFpTQaBVhQ4rP8?=
 =?us-ascii?Q?ZnMN6fnP9kPL6JyBjkzs7oOSkxxM7KvHVYdtkt4jpMEL/37JacpdzZl6Ms7/?=
 =?us-ascii?Q?v9/ZJUdcYbPDxJbKdS7+RYZf04Xe6azSvd5HjhTtjIDnLF8ekJY9Hay+QXCR?=
 =?us-ascii?Q?tDp3XTVLm7EEhz31ZBRtvo2jY37DWF8ZbvCMorttSE2qcU6f2EzWBS73qdeC?=
 =?us-ascii?Q?pnoiADMOBLqDVWESQ+qlucIofcMfiZa3rBejjloftIIFCGmMy8s8xDdydamI?=
 =?us-ascii?Q?dJ8jrkizVehi0AIWNdoloNy7Pk3zWOnOfgHr1UL3Usv6SZsspnXBrA23CLHE?=
 =?us-ascii?Q?NLsU0ek5V46F67tzNBhJ8+xqzNoza+byy4+toAZOq4JbIvy4fbr9lmm8PaFP?=
 =?us-ascii?Q?P+XRqLrVjBEkNcAaa+Ot9Alui1zIx8eNE5WfOSBHeFJxiyOzzXWh7LNEM4br?=
 =?us-ascii?Q?QISgdR8SHtwmuCEwX+4Cbx6FVxflM6TulpxcTJ1tfJNR84aK1SccGX2lauHA?=
 =?us-ascii?Q?Tg5ravGL7orNDNnQyBlKTDOj6l3xPj3cxHONdhT2bR/JHWwMDEdmtNzD1hSz?=
 =?us-ascii?Q?wIKGZGS3OHDi2/a8AUpDPe3vJdiCeFvuTUUhHxA3tZ69dPJBp/0P9MRMhbKk?=
 =?us-ascii?Q?dI30MzzYLt+WBFUvMQ73f66EcY4wFmwIBgCQPiev6D2yh80Q2D7zDMGc9x2y?=
 =?us-ascii?Q?kurl0WZNKDm0CkWpkSFYkYs+CrzoS0cLNGpWr/pv6YgxdoxdVe7BYj8HyiN0?=
 =?us-ascii?Q?lOwU68nCoPK7CrifSvvJ5ag0cubdQeVBV+ESYWYKJUuuc0uKf2VUYUZNDiVU?=
 =?us-ascii?Q?dHSW3C65iPJpYmhJt76ykXSMD42hr0BgyhW+fC1MdtKp/iz2lqxecfuJ/73U?=
 =?us-ascii?Q?/zeOROgDTogqyWzkQ7ux8dMcKjnpFifAWIFMreDP4gzwNxbtwC88MLgMJSAv?=
 =?us-ascii?Q?TQfI3ppYEpYqjnc+64TFus2NtUxa8022C2Ryty/0ZhQLsQWyEOnhYHH0sWvd?=
 =?us-ascii?Q?+UM6IMKDOmOjV5+OTg9Kgbd6vZ73DpikgGmvWL4d2RZgiRmwUw/ErsP64D1c?=
 =?us-ascii?Q?DKZXDqQPV9wNheVTaNlrnbD2EeEJvzHxLA0ryXHkEmX8F+YWpbzko51TpAlJ?=
 =?us-ascii?Q?47iKx/AfrlsPEWD6sZy5ETsRHD+v41X/KzE0Xh2JcwEBglgY55sFfodsjyvc?=
 =?us-ascii?Q?nUtoR9DJcfiB7LI8Z/hrFFtBSarzNDdr2XCdsI1qvjQpISUIaooy8QCmNihk?=
 =?us-ascii?Q?9mN5o7JMEN0v1HpJwOAJDJt5sj6I3r+rHjH5R1T7v+sdW0NSKW76N1zGY02e?=
 =?us-ascii?Q?fXwLgnBZdhB+cO2zhgwWwDa4AcbZsDlfm/JWPLjk9cCSasFL3t06NrihcXvs?=
 =?us-ascii?Q?NcFcePfzOlbU+uoVtWF9agVQpvOupJhEPhHX4JeQhidwwl+yCfNmZXhloBLI?=
 =?us-ascii?Q?80qjMi53qscksZ8hgM98qFjg30xgqd09MEX1Kj5H6Yr9CCkLHDr4ktJeEjJU?=
 =?us-ascii?Q?l1EeAnOf+bsw9MdGkPx6fm+FxuPQ5TFoQA4fZNVaCkDMrGLyO3wnk/eM4hmM?=
 =?us-ascii?Q?WeU24EhaHCI1uowUsL2kqwK9RvdFyNKiQIHirokR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a602c3-2606-40f3-6c67-08ddf6945c29
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:42.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXrlDRpuk+fZH7AAOI0Nn07JBfzsaqmWuE/F7JSNqEdP5Y6nToVYL4tmdeS7+KraFlHrBwGFx+Rj/uyKrxQLvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801

On 29.08.25 11:09:23, Dave Jiang wrote:
> Group the decoder setup code in switch and endpoint port probe into a
> single function for each to reduce the number of functions to be mocked
> in cxl_test. Introduce devm_cxl_switch_port_decoders_setup() and
> devm_cxl_endpoint_decoders_setup(). These two functions will be mocked
> instead with some functions optimized out since the mock version does
> not do anything. Remove devm_cxl_setup_hdm(),
> devm_cxl_add_passthrough_decoder(), and devm_cxl_enumerate_decoders() in
> cxl_test mock code. In turn, mock_cxl_add_passthrough_decoder() can be
> removed since cxl_test does not setup passthrough decoders.
> __wrap_cxl_hdm_decode_init() and __wrap_cxl_dvsec_rr_decode() can be
> removed as well since they only return 0 when called.
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Great rework. I saw you applied it already, but in case you rebase
again:

Reviewed-by: Robert Richter <rrichter@amd.com>

One small comment:

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 87a905db5ffb..2139b0935500 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -812,12 +812,10 @@ struct cxl_endpoint_dvsec_info {
>  	struct range dvsec_range[2];
>  };
>  
> -struct cxl_hdm;
> -struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
> -				   struct cxl_endpoint_dvsec_info *info);
> -int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> -				struct cxl_endpoint_dvsec_info *info);
> -int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> +struct cxl_port;

cxl_port is already defined here. It can be dropped.

Feel free to fold the change in. On top patch fine with me too.

Thanks,

-Robert

> +int devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
> +int devm_cxl_endpoint_decoders_setup(struct cxl_port *port);
> +
>  struct cxl_dev_state;
>  int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info);
