Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04B3AE715
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483727; cv=fail; b=XMcscGiRX08qPjqZfRcSe4SBUGHVnVOIwyjVRkpLxZStIQ1LQxjBPE8EONDBJiznj9x9ZkWJdc/ldYOHrO1GD5QyoEy6sg3v+w2D74ptfdV0VPzmbcnause/JOYrZADHLnea+aMTi4/irNPyYSmAjmZcedMjx7wvsiCzVD5EAG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483727; c=relaxed/simple;
	bh=OLDiENBJjEmXvUtn6/eZRQnKABVcWs+JsJe4H24RiPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DBQ51uX1IXeWlBuBa7kgmAzzqZ2AcpEZacmZVO27kmjfZ0KrFUGWLqWIWcfyAlwRLYjB5MMcWZPGnS9QYXHV33SGEBdLPcyYclgyhXl6+VvQZFpG44ZbNQmfgRprSlTZtMK3noExQMG1/8XvZCfYcbd/FaZBMCjlYcJjocmIDzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dVDr3+hE; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dVDr3+hE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8uGiLht/gvfrB5XtkhWZRRGB1bTQaN2WYAXkKDy7i5TygluhF8Ccgsid0o5c93GSOEOJX6SWlR0jY1UFUBtkmiAVS4cTK7OzOiQ1jlihEYMqsg4iAZa8sd4MTBlNwSMGHVyTttB2nZZ5RfWf9wOGXOhxSM7xPerT7rtCfUXioGhdfztdIHwplBxbuRJfKzGdgX60Rt7Ft+b8eEmk+HF8X75aHwSpyy73xSlAOFa0oQttKGyYdW0CxV2ACLezEEbx+BQ9UxK84KTs5CIFgCdBsGlsyYDDqifVg7H1gLTotu1J0vq4w8cPvC+gMDyxVwAVdRYFVWuwG/GOhUAZnbD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a02vWis+iBpHwPTh50LvZiJHe3HXxWvhsQR2H96nn8=;
 b=GNSB3axn2oJDfcp1duVIn1bd0GnxSJ7aH47SI6NIF2U/5CwbA/CtxQLytQdMM0pkw2WQaBsuUV2x6qA5BM9ysh8D9k4oFg1DWwmTDfpv+FG6JAn+eo45ezQrqGfEY+4DHcFCeymOVEzFuOetv+U0MyG+MkzIWKk5nPyoWh2eAeedyN3bd0Vp+5j4GN1gSOL//tMsJM3mg+3Tw+mH5XqbnoYxCX5S22zFbsw+JgEik5T/4KwWS/d/dWZD/o44tO2XZsLDLBnWt7V8kXG1x92nAR8JvGeSuduPnmwMjpr/CRf+ZX/RppjliQm2BoKgX7zZ7tkNhmpmGzSeQ2bW5rOj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a02vWis+iBpHwPTh50LvZiJHe3HXxWvhsQR2H96nn8=;
 b=dVDr3+hEVQPYKBuOBo51W06YzXCreymmImSSJswIBNNwkFSxijX2sAzn9KPYP2Aop2tgH6fcuA4GveoVdBiemf5r7heE649/MKQpqPGyhsxlJhNQVWWM88pA3arN2mKwLmWEd2iB+3MS5jCW7oQwhg23NRU5MI4LRePmBtDr0mCRaWJ4pOPeG7ted/48Z2EZKxqI+FCKeCFbvP59FhIEvoaxwuG3SJx4mrwhyF8lMIBQLHkZNIb+LAbBRlE4oXPJcnHiNv128pXfrI7BQwDROAT6MBMMUdpLGpo62yPV8j4JOUbF4iDmNjCSs8GD8O2hVne1Pi6U6yhigyNa+cWOWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:42:01 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:42:00 +0000
Date: Fri, 31 Jul 2026 15:41:54 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <amxHLqcwROvNP6Mz@MWDK4CY14F>
References: <cover.1784940306.git.alison.schofield@intel.com>
 <5b1f9970140ad1ea5924de06b7e6879e3b9deea1.1784940306.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b1f9970140ad1ea5924de06b7e6879e3b9deea1.1784940306.git.alison.schofield@intel.com>
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 74387c53-4a9c-44bb-e95a-08deeed734c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	C0mts7M50tT9MTLOkmu0l937M3ITBprHdLP2MuJ/ROaZC6O+M8m0BkCQ5gkQ2Em6DlGoFKEu3TFzShnWVJZ4iFNDLpGmIbV0mbuuBZs6Le1iQWfD/AEC/i+MC/yyi6YXhyihXdy8H0wDS+C0HEOv7wNiTOdlfgLw3A6Y1bHEPCl0+iE6zTu/kkPAR8WYmPMHm7H3AYeYIBySERld5D0aNh39a0LqbNC9kkpqufqsu50SiLV7NETUtTK9tacFFBM+KI6K053WashGnQY+UoSl6IAkZ2qz10HzuD1UFNIGmL9LaX4M3iFBqmDdFYCDkk7/YwzuVIZRB3jjbBBLtGM0OKrEzTHGCmeNxpIqs/0FD/WyEdUmXACEk9TMj3SimlGEGjjHmuN3XZuRlW1pgBWO2qNFQRupenI72nJ5+zBp1st0xv/sX1IM5baFZVQhPZKrZXupieY4C3XprNfmDiPrlALhJSfu1v3OIoMjADGxAfqpCEdUk6kruZQwW0jTj02fIYr6KJWhrlFMUlpUxxuYAgfJSXPWTFSI9xmKHf8mmV39Q45zjXXgHbfIfRHSob9C5vgCfqTOrj9xnG6+zr3+93cGlRAq0WTakMhze1J57eR5CYFhnWi9ZnNiXM+rUfBGYfB6mnI9+gkpTBIrn1pPjZ4EZ07ni3D28EicLfpM+Kk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nROjtlIbju9aJZqO2twPL/vMN9Sx0KIGBgGtG5ZvwrlA2qGojH2oxeBv/0J7?=
 =?us-ascii?Q?wsCrX4gqVW3qG0tiSqINEDQuZU+w2CsO8YR8UKBxiWOzfx7p9ew+jnlQEJjy?=
 =?us-ascii?Q?9I1dBfLuI1d+hocZFKlIaDJ5DhCxq2dJk/q7PFgCf+w/D/TDtuYmUffLda7v?=
 =?us-ascii?Q?WZzBCjDMNrNqHXXhEn/ups2NSEn7T2oi+XeufZisY+eBWnk17IDSa3gtNOwW?=
 =?us-ascii?Q?ZqRURkxwcaltzgx4dST78aDEoP9NI8bpAfmbGyi8W0HzsJurgCUGSExoOfs+?=
 =?us-ascii?Q?xscR1Cx+N3b25DzXcxPS9cPqtsThhxHwzmwaOHELAUyC5uJ71aFkvmL3Jh5K?=
 =?us-ascii?Q?CIxmA3s8WNkNBWJUoAyMhZwJDzVg4O4W5XC7aVrjmRbQfOj2dqcbQkKkTNlT?=
 =?us-ascii?Q?b3EKAEDcqHmF2i5VBROPSwvPbuGmxrVpAi0jF2f7uq4EjTPgEwMusbJva8b9?=
 =?us-ascii?Q?1wCIGhBI5LaJXmPiCB1VxjNafNGfi1VYiT4JN+0C7n45A9KBkQFWYxdJ7hPS?=
 =?us-ascii?Q?LQWVZUDYxuIBnYmwHWY+FFtR/xUkp+yBDkyRIC/sswPFpddB/LQlsrFNZWBL?=
 =?us-ascii?Q?JEwU3rE7BUfZqkGFmZJEv7ehaSJDDb0GE3cZiSCayL6s5YlqreTOfmqJJOp/?=
 =?us-ascii?Q?bJ4DB0LGGFM683dApuyJq1WjpEkD7GbLQ0oU9t/TmW6BQJP4Og+7ucPKxD4t?=
 =?us-ascii?Q?apb4hW3UfNCSxyUsVUNpNaAN+D6rNQIPhkPChnPKkT88p8ErVO8iSMIjfB/E?=
 =?us-ascii?Q?09J/5k/xnU849x5O742Txi8I45iQTnuN4S666m7LbO2VJ3QjyQhlWem4SFAw?=
 =?us-ascii?Q?oljqVpoNZAL69iE+BuDdpakFCx65gFoLL8Wk1wPTZxAU8+/RFcc85Yw12qrP?=
 =?us-ascii?Q?x4w8UwnXH8wNq9jU5ZGi+inEsKiADZ3pZLa5UecOcRxfAY8NEmLqHGPTUk3H?=
 =?us-ascii?Q?9uwt5wPEqCBSQZvsuAxbY+IuQApqJtbZgf9NCVy7knyIv/x83Nu8nCV7uQWO?=
 =?us-ascii?Q?Bdjj0+NcTc09V2ZbLYpW6PMVqlmS8ZBLkH4eab0oX/PUsyi4WUMqjh+3A5Km?=
 =?us-ascii?Q?GP6MdjOKajv4vF8JhB9j9OLKZ62JuvdlwHHAQ+K3ikLneWor/WR1gPrrezlv?=
 =?us-ascii?Q?daqdpjbiNIiLJURKJnRlE9oAtNcldPRuJ4gfZYljgbS1MYhRULTrk2m9gSpD?=
 =?us-ascii?Q?GtV+DLDTcL/S54U8zvTeNIixBkg+wTczic9fq2aLiQUoeJPxsfUk2uiVd+7R?=
 =?us-ascii?Q?eIet7gmUfAvxYpMIIm2fySZFtNuljAwXuJcFbgZAKot2UyPi5+MIZexAx+tD?=
 =?us-ascii?Q?YBVfhiTRoweqDr7VXDeltzLVXolyQRLqTqG69c9J56RcotFMMDOa9tYsrgbQ?=
 =?us-ascii?Q?JyMQFNwVxrK7T/KNm5ac6eVpmTFODzSYTqlvI+yJLfXChsXjj3gp//YFY7jL?=
 =?us-ascii?Q?C+HVk+/o3VFm3ApNajKZTnfhQfDFninT5lWb/cGq72/MpmI0BJb1qhbM4ZJ9?=
 =?us-ascii?Q?VctwISGG1Gzqci/IhGKrLBAdWNSNSkBBRsaaTes3zlZxdZ5La5iD4OSAtcqI?=
 =?us-ascii?Q?5fzOri153F9yiGOGwJeHTh83Apu2Hol6RJEh2T9OZhVkSh2vXgjZOD6C7V8K?=
 =?us-ascii?Q?szpD54jVqGvpdkeXxSZ4u4H1Vjdt6mRGsoSEzlFdlrQSc13xrJQDu0qWGdp1?=
 =?us-ascii?Q?AECoXqrTvmjcwWghdBpC+i8yHE666kqNZYWL3hs7tBUlJgky0rypISFSOmNG?=
 =?us-ascii?Q?IW2ae5C87w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74387c53-4a9c-44bb-e95a-08deeed734c5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:42:00.8520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYfNYEZDlb5VJDTCsN7d1aW1Ly/FhmIS37RWwYqQHkAfUwW9VbYhCZTgoa6muwOSO1yTPIyADkJStY+Jy0Yh5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240

On Fri, Jul 24, 2026 at 06:08:54PM +0800, Alison Schofield wrote:
> Region configuration rejects valid topologies that contain a
> passthrough decoder beneath a wide parent interleave.
> 
> For example, a passthrough switch below an 8-way root decoder with
> 4K granularity computes a 32K granularity. That exceeds the maximum
> encodable value of the HDM Decoder Control IG field, causing region
> setup to fail even though a non-interleaving decoder does not consume
> the IG field.
> 
> Only require the granularity to be encodable for interleaving decoders,
> both where it is inherited from the parent and where it is computed for
> the current decoder. Keep the computed value for passthrough decoders so
> it can seed descendant decoder setup.
> 
> When committing a non-interleaving decoder, still program the granularity
> if it is encodable; use a don't-care IG encoding only when it is not. This
> preserves an encodable passthrough granularity across re-enumeration, so
> descendants do not inherit a stale value.
> 
> As a consequence, the interleave_granularity attribute of a decoder
> whose interleave_ways is 1 may report a value above 16K. Document that
> the reported granularity for non-interleaving decoders is a don't-care
> value that may exceed the maximum encodable in hardware.
> 
> Fixes: 18f35dc9314d ("cxl/region: Refactor granularity select in cxl_port_setup_targets()")
> Suggested-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Assisted-by: Claude:Opus-4-8
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  5 ++-
>  drivers/cxl/core/hdm.c                  |  8 ++++-
>  drivers/cxl/core/region.c               | 47 +++++++++++++++----------
>  3 files changed, 39 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 16a9b3d2e2c0..3f96e5bf1fd3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -407,7 +407,10 @@ Description:
>  		space this decoder claims at address N before the decode rotates
>  		to the next target in the interleave at address N +
>  		interleave_granularity (assuming N is aligned to
> -		interleave_granularity).
> +		interleave_granularity). When 'interleave_ways' is 1, the
> +		decoder does not interleave and the reported granularity is
> +		a don't-care value that may exceed the maximum encodable in
> +		hardware.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..d2ada82fe3c7 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -691,7 +691,13 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
>  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
>  		return;
> -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> +
> +	/*
> +	 * A non-interleaving decoder ignores the IG field, so an
> +	 * unencodable granularity is a don't-care rather than a failure.
> +	 */
> +	if (granularity_to_eig(cxld->interleave_granularity, &eig) &&
> +	    WARN_ONCE(cxld->interleave_ways > 1,
>  		      "invalid interleave_granularity: %d\n",
>  		      cxld->interleave_granularity))
>  		return;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..5a443551288c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1521,12 +1521,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		parent_iw = parent_cxld->interleave_ways;
>  	}
>  
> -	rc = granularity_to_eig(parent_ig, &peig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> -			dev_name(parent_port->uport_dev),
> -			dev_name(&parent_port->dev), parent_ig);
> -		return rc;
> +	/*
> +	 * A non-interleaving parent does not encode its granularity, so its
> +	 * stored value may exceed the maximum encodable and need not be
> +	 * validated here.
> +	 */
> +	if (parent_iw > 1) {
> +		rc = granularity_to_eig(parent_ig, &peig);
> +		if (rc) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s: invalid parent granularity: %d\n",
> +				dev_name(parent_port->uport_dev),
> +				dev_name(&parent_port->dev), parent_ig);
> +			return rc;
> +		}
>  	}
>  
>  	rc = ways_to_eiw(parent_iw, &peiw);
> @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	 * Interleave granularity is a multiple of @parent_port granularity.
>  	 * Multiplier is the parent port interleave ways.
>  	 */
> -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return rc;
> -	}
> +	ig = parent_ig * parent_iw;
>  
> -	rc = eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> +	/*
> +	 * Keep the computed granularity for descendant setup. Only
> +	 * interleaving decoders require an encodable granularity.
> +	 */
> +	if (iw > 1) {
> +		rc = granularity_to_eig(ig, &eig);
> +		if (rc) {
> +			dev_dbg(&cxlr->dev,
> +				"%s: invalid granularity calculation (%d * %d)\n",
> +				dev_name(&parent_port->dev), parent_ig,
> +				parent_iw);
> +			return rc;
> +		}
>  	}
>

Hi Alison,

Looks sane to me, just that this check pattern appears twice and peig
and eig are both write-only afterwards.
Could they be formed into a helper or macro ?

Something like the following might do ?
"""
static bool granularity_is_encodable(int ways, int granularity)
{
    u16 eig;
    if (ways <= 1)
        return true;

    return granularity_to_eig(granularity, &eig) == 0;
}

if (!granularity_is_encodable(parent_iw, parent_ig) {
    dev_dbg();
    return -EINVAL;
}
"""

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng.

>  	if (iw > 8 || iw > cxlsd->nr_targets) {
> -- 
> 2.37.3
> 
> 
