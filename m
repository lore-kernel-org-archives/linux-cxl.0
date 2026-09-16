Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D650AC13
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568165; cv=fail; b=cLGXva3TxwlDWN/S3N4M03PjtCC8HzqkgTN1kXJdi7kz8JcAGJ+Lj8WIRqnExMuPXj8I5O9GvPQR31h0doTK83iRYxRhmtAwXEZLsKP1kuspe3+Xshe74EdMU7/vxsAXuw1t5Q3aBFRk9HRvfAr+GutzNGI5Crcj0jjwuATdB4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568165; c=relaxed/simple;
	bh=FFGBNzor1rIxqfuj0KKESembbEJFdAEygtO47ktC6sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pTAz04uxfn7Drk46L0CQjl0OguEwfwzMFgtai/NFXv4SSSOjQ2+7Yp85CvMs3Zy/SohHAF0SWet/6s7xHoxZnYQPP9SeFZo/PrttrhldcjzokxYo2bMge7Ub0f2OAmvZBI+DgIVR8JzH8ksTU6q0dDIrv6WvIVrVpp6+h8cprfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ggHgLn0M; arc=fail smtp.client-ip=52.101.46.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ggHgLn0M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeMo/CGfn8mEmrPr/m8+UhOQm9A9L6+r3WGnEzvDrjD7/l6Mrv4jLO8/eY27jUekMZaaduv+HDanUVqtxAzG0KstlKCaZKACkN+kPj/a80WU+YVMMgNZ52wMabTpzNroLKkPrO4x2chmWzmRG1h+RPv6saU3aAuNE4VtcMuG3AhgXHEeqBVU+9ppxFy/Xrfo/jPBSsO71uE0NVpoOu377Xt7gRDhx3s/7v3JccPlMPiCV0WNKhPC0wwZZindf7DBkzt5gcVqDg61bD73E9HMSr0QUb/u1OMNqGR9yLbm3+d8sNMoh98Fwalb030o1dUSms/zucMY6vP4xyaLpKFDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brL31mXnWQVBv7AoNNs9NjWm9aGM8C8dQz2mkRbV008=;
 b=aZKtuFKtWE8ytwTKYjTRInBxmTAg3QgY+dcncrQX5d7ZEW47ynss8sNoV6FmqG8bUJxLW0sRUmshbe4EWSgEaGCtyU2SsLJr4tDIY21cIJvfw5ysAtsedv6oG19aKR2cL9cc/3kL0+HI13oCXLITkNYYF+Kdxkkyr4j3kqyGd+VmNTNEZ1cLDl2k93BwfdzaSdKwTL9N3hW5u3sw/ZiFrsZcvaRqwlF1HwJPnWZZdOO7tj1878mvEyB2SAUf/PA59Kv8Qqd0wKO+sZK9kzwwsAT/OgBxeORjxTjgm4M1gMQE0kzae6Rgy2pSJiRgeUkogEMWkTTxqKtI7bzZJchjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brL31mXnWQVBv7AoNNs9NjWm9aGM8C8dQz2mkRbV008=;
 b=ggHgLn0MOrrUbYFS1r6qoUs1bv+dSujtlzVII424W1lEmnP5DD/s4jBzByB85VQ5GMSclGyx60rjxXBrYTuIYraC3hW2xviYwYmc9J9Qzm4i56A+Ogqr6qAbEaX2gklyqp9cgEM2ulZu0KyClBxbi/ocF+ewyTJ3t1HorXOw6gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 14:15:59 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:15:59 +0000
Date: Wed, 16 Sep 2026 16:15:53 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 3/7] cxl/region: Generalize endpoint position mapping
Message-ID: <aqqkmU98Hpv5xZ9m@rric.localdomain>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <16d749d4eef2f6f142bbf6c48e4210e0587e466c.1788475206.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d749d4eef2f6f142bbf6c48e4210e0587e466c.1788475206.git.alison.schofield@intel.com>
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5d3f3d-33ed-4117-3864-08df13fd07c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|5023799004|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ehoWlntcRcTIC5CoBc8T5EH8CBCbeehLQIssLK0edk3MG2uWyYLl2If8sMDIn5kA/Bh+vPJTAjlrXVcPeyPH5FRuOPHeuQqlgbdkNLjANnnZp0bE/w48x6fYmbVUj0Xl0rVHF+kilumIXUPAA5RkLdW9QTLnTyjLU7ARW5TnH7J8DhO0d/RRdbQmfGXh3pWSiyf1w0ti9zgLHhbSX5+AWRKkkrJmdA/ffDYpuB3X94W5TbOdPQOd4DisvtmTvvwWUzA2D9hhSF74wLWU295U6/e0hEEdxQq742qh8zloyVJAafRl17DR5Um/fpremovesJL9gk81Pl2KJR7D+j0lW8/IbiFfRO4jr/Ksx+/frKlgQV2YGZn36c/tYNRjeShabWFqK3wPCXEZvaNe8hRD+WuKAw+jF3STmbgkZ9Fa8DXLy24pc9MUw4BudsD/nFuPUQugJgxhFAopX1K0CDXTi/esYwPi3tPCvMrPUt0aOPfp5Gie4EG2EjyKp1K+pDTdH0JueG4p5Ne4KWqUEmZm3wFVzqKUKm9iRUdmiG2z8FgVikosDGcAeM11vfyz5w3Tka53PnQIhnXHQD30tJmijOCEIY6xHO4cmNY52IpmGFHijYpnfZQSY5ikzN2oFxJRCU4CWUvz8XwilytjL+Rj4E/Oz9yAvPdji1L7fOUdWQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IT0aEeYPt8JkKL/ok+yCARQOIj4+B1EwlWlZPRQ4MgNbVK+D0poj8Tvw4n+s?=
 =?us-ascii?Q?jvDxJVtzIqAkhYgu8VYgfxBaLo/RtzPLDPjH1m78dYxMk3rtiPDf+1Rf6+4+?=
 =?us-ascii?Q?mKScYs/fngqPZ9hAfHhL2KeEm8o42S2xBWh9HEPGKw2kXDHK+NCwJwGxJ2K7?=
 =?us-ascii?Q?pMZUlm2xwJ0OmrAejzu0d35svQ3o9smqVq8a4s0TakqfCN5tkQw1ST810nV5?=
 =?us-ascii?Q?Va2yR7tQjN+aeS/OioFekgMOBDcZwaMumKfwV/I0XDFMB26Jurz0Wjt3DSuI?=
 =?us-ascii?Q?OL6wGFmpYLtSa83IEwm7QRBIbfJjmujVuuC7aWbEqZYloL8oH9syrA03fha1?=
 =?us-ascii?Q?ryzAIST0nyf8+Y1RizD/tIw0SVS5cez0Xw4KXigVVuQ/JMmHct+IA8ap9L//?=
 =?us-ascii?Q?a7VxCCjjaNuLAEGR5+5ZsNiuTznoOBHm6xmiskYFve5G8REmCvRxUeEiFWvk?=
 =?us-ascii?Q?7tPuHMFzpUWTHJiV0K85umgA4sTm3knre+eFNKgK6mP2UWhQqzvnZSBIRn4Y?=
 =?us-ascii?Q?fqhbNv2YE5clpybxgIHJkazSVA8L5qWohsI8PhoiYIq9bC5KeF084ktFGUAw?=
 =?us-ascii?Q?zMQWhKkgZz4TkwxZJpk6G/ACUcrPw3jAWu75aV7uIPqdw25shIM0WdCgBd9l?=
 =?us-ascii?Q?VAc9JDbSkRneXkosGlVfY4KggTdlVnfV+rQgoC69OB/K/9jGpeNPe0LPBsur?=
 =?us-ascii?Q?Ulp44wVJZRnGwSws5CvJtB/Mp5JqQzPkI+OJIFt4lXnT+q+haUASuL11oVaJ?=
 =?us-ascii?Q?vnUlJcXjVRMM2bd7yQYvFFSKqboezezdQEPdb11qHB32/X9ugC6EhK7sOu55?=
 =?us-ascii?Q?4xM/FsFzJ7T8bjt8IPNsuq2cpMevYXSuFu3W1HCvlJw+v3CSWfoaEXAwpm/s?=
 =?us-ascii?Q?+WZGJOtFJYcFQLdJ6QaxVqYj6NTCuLX6z0qDDNm50hRjmlZVB/3ERVKQl+Os?=
 =?us-ascii?Q?VSaB7V/CTsKJ+0BAn9m5ORWHlM8VztUdiACtFkZAYRvMErqpQS4I3V0E78o+?=
 =?us-ascii?Q?CaFFtAFSvCbpD+QCv/dx3cjSIkhZTT1xiwlQNODKWwTH1sjFVfbOoKmiyF7w?=
 =?us-ascii?Q?o/SD9JUCfip5IsT+t+wkwZt/j5tuu2WjyDLoIEOfXmg8Ngb71s6a8Oa/pVYP?=
 =?us-ascii?Q?p+S5HY5UXudGCmMyJY4y9VfuxQ1mJCrQOzk5hvT3ESDKYDHHumpZ4nOPN+7k?=
 =?us-ascii?Q?0xCRB+CFQNeT+y6L8bKVXkInwsNj/M0c5vx4wHT3yt6X0hDVj8NcOGObkIB7?=
 =?us-ascii?Q?12V495PimvIBWXm1+Ozuly4ykQeita0yKV8GQlm7Sw0rVQj+iiJfbTT3QwCw?=
 =?us-ascii?Q?HbzOla4i08xtlEiJMbOeEbqRbwfFN6Ooy0lzMCrefbypNc7RGcTKuFojESyj?=
 =?us-ascii?Q?+h4igKEVDV/3vJ4YQyuQh3l8n+fRAOXkVs5W6ar2hWKHfjV9/NtCcio2LlxA?=
 =?us-ascii?Q?Toq120fWrgJDPUYMakQtZF/kAjOCmzq9L1ack2aiXV9br67tqDoDSEYSf53a?=
 =?us-ascii?Q?4L0GU9FS/NQpS4Nrbeud/76GPMkOCOvffx9kftzBIXDGeex7fcvbM8naiDoA?=
 =?us-ascii?Q?4uiT2NL4T1Zz+XN37lLDyz5tvKxp3B/Q43GMsuH1Q77kgy6uQI7Gm7e1p3R2?=
 =?us-ascii?Q?CNgqmr6gj/ujPyAXDIjRIZJ6g+VDRnT68qV46ThDX4bdpkl4ZlVUr2Jpj7BZ?=
 =?us-ascii?Q?pa2wEsLLjI2RKv2YyKnZw2cIsKD2qSBeZA8TEs5ut+TGuvns?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5d3f3d-33ed-4117-3864-08df13fd07c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:15:59.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sze9GAIASW9LMzVLaDir28E8/sd8gzpYvMkpAc88qIJqJZNYRFwdiBrOOrnbu+Ft3BGY3jDQvp3adAV1zLMKAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287

On 03.09.26 16:23:45, Alison Schofield wrote:
> Endpoint position calculation currently relies on the requirement that an
> interleaving root have the same granularity as the region. Auto region
> creation builds the position by multiplying by the parent decoders' ways,
> while user region creation selects the root target with 'pos % ways'. Those
> calculations are sufficient under the current granularity restriction.
> 
> In order to support mixed-granularity regions, that granularity restriction
> will need to be removed so decoder granularity can change between levels of
> the interleave hierarchy. The position calculation needs to account for
> those changes to produce the correct endpoint ordering.
> 
> Change the position calculation so each decoder's contribution is weighted
> by its granularity relative to the region granularity:
> 
>     position += target_pos *
>                 (decoder_granularity / region_granularity)

Yes, that reflects the stripped off bits the endpoint does to
determine the DPA. Actually this reflects bit positions of the
selector bits in the SPA:

|XXX...XXX|SSS|GGGGGGGG|

S ... Selector bit (width is defined by region's ways without factor 3)
G ... Granularity bit (defined by region's gran which has the smallest
      size of all decoders)

Position can be calculated using bit logic:

  target_shift = dec_gran_bits - reg_gran_bits
  pos &= ~(target_ways_mask << target_shift)
  pos |= target << target_shift

Assuming target < target_ways and reg_gran_bits <= dec_gran_bits.

Note: the 3-factor part must be added too.

A rather prefer the bit logic here.

> 
> Use the same relationship to select the root target during user region
> creation.
> 
> Weight each level by the region granularity, passed in by the caller,
> rather than by the granularity programmed in the endpoint decoder. The two
> are equal for most configurations, but not when Normalized Addressing
> leaves the endpoint decoder programmed passthrough while the region
> interleaves.

In case of Normalized Addressing, only the Endpoints have different
configurations. Root decoders, host bridges and switches keep the
config as is, thus the region's granularity is still the smallest
granularity programmed in the associated HDM decoders or described in
CFMWS.

The address translation code handles the region detection before the
targets are enumerated. Normalized Addressing should not affect the
target and position setup.

> 
> For currently supported regions, the new weighted calculation reduces to
> the existing position calculation and produces identical endpoint
> positions. The exception is a region wider than a same-granularity Mod3
> root, where address bit routing programs the level below the root at the
> region granularity, so the ratio derives a weight of one rather than three.
> A later patch in this series rejects that layout.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 69 ++++++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6a698f36aa6d..506b1cba1a92 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1806,9 +1806,15 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	struct cxl_decoder *cxld = &cxlsd->cxld;
>  	int iw = cxld->interleave_ways;
>  	struct cxl_port *iter;
> +	int root_pos = pos;
>  	int rc;
>  
> -	if (dport != cxlrd->cxlsd.target[pos % iw]) {
> +	/* Root target selection advances at root-granularity intervals */
> +	if (iw > 1)
> +		root_pos = pos * cxlr->params.interleave_granularity /
> +			   cxld->interleave_granularity;

Use shift right here.

So root_pos is defined as the Nth host-bridge in the cxlsd.target[]
list.

> +
> +	if (dport != cxlrd->cxlsd.target[root_pos % iw]) {

Isn't root_pos always smaller that iw? Better check for this
assumption and use root_pos to directly access the array.

>  		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			dev_name(&cxlrd->cxlsd.cxld.dev));
> @@ -1909,12 +1915,13 @@ static int match_switch_decoder_by_range(struct device *dev,
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> -static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> -			     int *pos, int *ways)
> +static int find_pos_and_gran(struct cxl_port *port, struct range *range,
> +			     int *pos, int *gran)
>  {
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *parent;
>  	int rc = -ENXIO;
> +	int ways;
>  
>  	parent = parent_port_of(port);
>  	if (!parent)
> @@ -1929,9 +1936,10 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  		return rc;
>  	}
>  	cxlsd = to_cxl_switch_decoder(dev);
> -	*ways = cxlsd->cxld.interleave_ways;
> +	ways = cxlsd->cxld.interleave_ways;
> +	*gran = cxlsd->cxld.interleave_granularity;
>  
> -	for (int i = 0; i < *ways; i++) {
> +	for (int i = 0; i < ways; i++) {
>  		if (cxlsd->target[i] == port->parent_dport) {
>  			*pos = i;
>  			rc = 0;
> @@ -1951,24 +1959,29 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   * cxl_calc_interleave_pos() - calculate an endpoint position in a region
>   * @cxled: endpoint decoder member of given region
>   * @hpa_range: translated HPA range of the endpoint
> + * @region_gran: interleave granularity of the region
>   *
> - * The endpoint position is calculated by traversing the topology from
> - * the endpoint to the root decoder and iteratively applying this
> - * calculation:
> + * A region position is the index of a region-granularity chunk within one full
> + * pass of the region interleave. The position is calculated by traversing the
> + * topology from the endpoint to the root decoder and accumulating the
> + * contribution of each decoder level:
>   *
> - *    position = position * parent_ways + parent_pos;
> + *    position += parent_pos * (parent_granularity / region_gran);
>   *
> - * ...where @position is inferred from switch and root decoder target lists.
> + * ...where @parent_pos is inferred from switch and root decoder target lists.
> + * The multiplier is the weight of that level: how many region positions pass
> + * between successive advances of the level's target index. A level that selects
> + * a single target contributes nothing.
>   *
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
>   */
>  static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> -				   struct range *hpa_range)
> +				   struct range *hpa_range, int region_gran)

Better pass cxlr here. That covers both, hpa_range and region_gran.

>  {
>  	struct cxl_port *iter, *port = cxled_to_port(cxled);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	int parent_ways = 0, parent_pos = 0, pos = 0;
> +	int parent_gran = 0, parent_pos = 0, pos = 0;
>  	int rc;
>  
>  	/*
> @@ -1981,20 +1994,20 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  	 *        |    |           |    |
>  	 *       mem0 mem1        mem2 mem3
>  	 *
> -	 * In the example the calculator will iterate twice. The first iteration
> -	 * uses the mem position in the host-bridge and the ways of the host-
> -	 * bridge to generate the first, or local, position. The second
> -	 * iteration uses the host-bridge position in the root_port and the ways
> -	 * of the root_port to refine the position.
> +	 * The region and the root decoder interleave at the region
> +	 * granularity, so each host-bridge decoder interleaves at twice that.
> +	 * The host-bridge decoders advance one target every two region
> +	 * positions, weight 2, and the root decoder advances one target every
> +	 * region position, weight 1.
>  	 *
>  	 * A trace of the calculation per endpoint looks like this:
> -	 * mem0: pos = 0 * 2 + 0    mem2: pos = 0 * 2 + 0
> -	 *       pos = 0 * 2 + 0          pos = 0 * 2 + 1
> +	 * mem0: pos += 0 * 2       mem2: pos += 0 * 2
> +	 *       pos += 0 * 1             pos += 1 * 1
>  	 *       pos: 0                   pos: 1
>  	 *
> -	 * mem1: pos = 0 * 2 + 1    mem3: pos = 0 * 2 + 1
> -	 *       pos = 1 * 2 + 0          pos = 1 * 2 + 1
> -	 *       pos: 2                   pos = 3
> +	 * mem1: pos += 1 * 2       meam3: pos += 1 * 2
> +	 *       pos += 0 * 1             pos += 1 * 1
> +	 *       pos: 2                   pos: 3
>  	 *
>  	 * Note that while this example is simple, the method applies to more
>  	 * complex topologies, including those with switches.
> @@ -2005,12 +2018,12 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  		if (is_cxl_root(iter))
>  			break;
>  
> -		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
> -				       &parent_ways);
> +		rc = find_pos_and_gran(iter, hpa_range, &parent_pos,
> +				       &parent_gran);
>  		if (rc)
>  			return rc;
>  
> -		pos = pos * parent_ways + parent_pos;
> +		pos += parent_pos * (parent_gran / region_gran);

How about squashing all the logic into a function and just return the
positional offset caused by the decoder? Sort of cxl_port_interleave_pos?

>  	}
>  
>  	dev_dbg(&cxlmd->dev,
> @@ -2029,7 +2042,8 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> -		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
> +		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range,
> +						     p->interleave_granularity);

That interface could be simplified passing cxlr, see above.

-Robert

>  		/*
>  		 * Record that sorting failed, but still continue to calc
>  		 * cxled->pos so that cxl_calc_interleave_pos() emits its
> @@ -2214,7 +2228,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		struct cxl_endpoint_decoder *target = p->targets[i];
>  		int test_pos;
>  
> -		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
> +		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range,
> +						   p->interleave_granularity);
>  		if (test_pos != target->pos)
>  			dev_warn(&cxlr->dev,
>  				 "%s: position mismatch: calculated:%d assigned:%d\n",
> -- 
> 2.37.3
> 
