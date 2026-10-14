Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685C414418
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970074; cv=fail; b=MotxxrEebSjZKWVSal6z8gFwBw7XNSMqnv6OVIyfmztOi1EunXFcLhG0w8ZfXRsq4aqx6VWCH7zMG+cHrzatyzh+mW32TuxyaV1FHHOUJo/AvzfocroFl16fXYZZ+iKYFouw6Dln45qPm79g0pAM8D5NPpJIaCbcxq3uZJOkgNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970074; c=relaxed/simple;
	bh=V/MDBEGqwdAHfcclcqask3ogu3XnR9FCliyj0hO8GXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sP5HLMCBHakR0jzQoKPQ6BD6R0VTx0GWw2UnCbITEN9HA7nyLrX6yupd0SbbzOeqZihxtGahe/vpBiiXCJB6vsBPae+/tQHXEL8ftItoqow1gEjyGE6ToCQg/VCU18JTKkXQI1jpxprmZMVO4UtYwfhXoFl8sR+PEDM8u1re7Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uPfiKvaJ; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uPfiKvaJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWxb64At6ldYkT4OWURrVoc8HLo09q94QJ/3KfqQbkAAmDFClP+RG1Z/pibhYJH7BATYub5v/fbASCREaOcYpZ+9JRGG5Nj14T6Jk2AMeOsIou4EkV+oXX2sU9+rcWItu5TrISr9lrIpdsXkj23VnuawSmkIJwWRWoUmQnizytm3EvygZICeXiKWoE2eAnKxIFWaCPgwOZ7SIowKWIAzdPFcin+9Z95huRq1fN651jRNnEGHpsFzmHcTGRHoSD4dHXSH3+4BMvRosKiqjvIEOPPLrwxURRSTAGoOELKgQJ24u1fpO6iEIemfxfhT1K6sphKp5pMfZoN/DoWfGtAhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y22crjxsC/nndyKIiANTQ8AneTrljGg53jaXMv/8Vm0=;
 b=Eta2sZXCttOywTmiU5ZG6IAFE1naNzOEWgc4l1c3mWSU47kBslcFHPbil2ERJX4Snu/aWTzl7gsEMKsKBCdfIOM66yfUnzoYnjUWtxRukh1J/9LqT/XrTWNnZjdFPEHhTcqzo8537dG0xhpRTMaloV/TcOk/cc0/7nV/KWmZrOCW9YunVYFNSoAPu5gOwDP2FamzXx9Mz/tSYHpZ9fm00s8R3B7UiqTIIEZQCvIVBdOH0hNQ/+r5w98CGtoDonluWGiKDGXFdCH6p8BPdLlNNDvibzy4PIFhZiJR8brYWmomemadNKXg7mWojR3/u0JQzLjEM3QLP9ZX3YVvsAtElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y22crjxsC/nndyKIiANTQ8AneTrljGg53jaXMv/8Vm0=;
 b=uPfiKvaJ/DAkrwFtBn9HPSQXjzL9o1Z+4MofJYMxpIFtTlS80tQC8IMYcFTqejLL1DDtNLyRHfKclqlrs7spySPXKC2AMVOkdgtKJ69VFP03Uj+a18pOvZfXo6Nsaagn4aAZ6BHZ9TX2nCcFSZrUL6TSh0wB5wLg4ur6Zt3nYzrAG9JBOzoHX1DIb3Ze/4uIhHGyVDZcUx1Dhfk1wXWYw1sTmtoOscjGVsvgNz/3t7bh2oViFrt9eUNPv3k2q0EILsJEgokQXYCyxdIny9nOIxLisarfPzLbIbjXrJ3kgXVaCDJL/CNFNpIlOLNiUz1cPOPxHvrDBTnS2Xv4u9Dmkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Wed, 14 Oct
 2026 09:27:49 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.020; Wed, 14 Oct 2026
 09:27:49 +0000
Date: Wed, 14 Oct 2026 17:27:44 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 5/7] cxl/region: Factor out cxl_port_calc_interleave()
Message-ID: <as9K-y3zG8D2rFa8@MWDK4CY14F>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <bb60900fd7e57b8494b93b3ca5cb7960b31ae8e0.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb60900fd7e57b8494b93b3ca5cb7960b31ae8e0.1791860305.git.alison.schofield@intel.com>
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB9734:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4f41ca-19ad-461f-4d0e-08df29d56a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|11063799006|22082099003|56012099006|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5le7LXakERDwO+zQLWfBbHD1YtDCfmJGiACvlDj/IqWYLMO+kmK0z/bIcI7ywqiTxP16u8SOlr86pBD3m6Mx3L8flhrnneiN/V8bzpjI5uQ7eiiLuPxJslDd8EmxhQ3wkmk+y8dJnMzkpt8cwMnPBmiq1ce90T2GWFxBZBrOqTm1UzFNRbEUbQTIWC5hfBEDugBmzj5cPh9PvhVPMs2c+ceacp4l9bygQuosSbJS3SODc3CaXNKYg0wEZZtHD+YqvPa6nni2KUwz0Gu6/x8RtduPhpleScgiiyGzT1jSeFoHHvEkRnGLMJWR4gg9hNxcJYDC1QVsEspPhNlWZeHp9XlQcKEllQsKN4lFltjypYkCfZC6gT9m88enhHjl3Wz09dY42WQkBPoJaJ08kGMPMnEcDepy9U6LDSLl8Leby26AUeor2XP3A5NKmmyh8CdAbKYMXNmxztYKuKrOSKNgtqGaSMfnxHYfGr59lmOynYYUaabke/3eDCjCHkPKXhoUvJlWUptoxH3dutAJY4C4UG0VR7EQfTIN1kgV+NsUo6RpMGb9WObmCrWG2sORd622yZyi9awAQqmZm4jCBsyS4CO1P1jEZFQZSum1Ah8SRuFanEWGk4NE+lHwEm1rDAkPcYuQ/vTNlMCNRTNgTxMYgqN0TE4bes0R19e6d+FnRYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cnLIfXvKuP15vvDAlFcaC9YJaXfk7WXyu8OMmObejaFmDbMDm3IZDMUSJjAP?=
 =?us-ascii?Q?kRR/RIgGpJjf11+4LMsSZZaAjbRZzakk00223uxGQ6SxTPrqFCBOVAbf7HjC?=
 =?us-ascii?Q?x2hIhW9O1zgBcaR7qSXudvaPFcR+WwMFTC4DgpNSob8JbsPesFAScuKA6VTk?=
 =?us-ascii?Q?q6QztpMQSDxT9bM/RrMGbBN6/eFbv0CX1bqtViWfqFzlo8eW+0wBwPGCgnlr?=
 =?us-ascii?Q?m1o+eMfiRqagEOnHhb15/cE8ocogrzP0rx0afx4U6JtWHmRzwQDBnE0+qoZG?=
 =?us-ascii?Q?cyB0QaeuaVmhTfq/rj7IMTFr7Ncgzt7BBQIx2j2C4W4yWeIvwgDIgMOLKuwm?=
 =?us-ascii?Q?0lUHoPz9xnWq7Cu4qgdALuZPIprmsvNfmNAmfDgixsMk0d/9bkJqsbFNGvQ9?=
 =?us-ascii?Q?HWFs5lQgsrEOskmLpsqdnin4NMg2n/+ooh8xlc42c1rZ0mQb2Q1ygLBjmcmO?=
 =?us-ascii?Q?fxCWufmqw+AwMD854F7jnAO6keSjE4b1H9CmsADMSTCX4r3G1IYOTD8NUH8I?=
 =?us-ascii?Q?jXF33Tbx+bOUnDM40xoKRT9fjmPlAFvghpEi9JomAgwiGFLgYE8N7xdPcTMC?=
 =?us-ascii?Q?SNOi42ulZp3mVPV6oGZopFG1uTlOLm7IxYfvFXkebOLvJarKAalwlmDLehSJ?=
 =?us-ascii?Q?FG9cyjwKKo9zIF6rGvvHjAuEkDyWxOYUyUvGzB8Mej/uAV8ocjQFaKWVzfO5?=
 =?us-ascii?Q?OflXvgDLp4q+HLBxEcIwR8gdbDktFYW5b16zUjaW/sYsgSc789PhDusjD83y?=
 =?us-ascii?Q?wevSdWmi+/+VF9spKeGlUyCte7hhmefYom/cImIiPLYQzQmYlI+vGk7dL2cx?=
 =?us-ascii?Q?tf9MdVuPiPGjqXuo9/RBXLZVR0hjUuTCVvji07xMDQ6SsaLPOxEQQ1DHbow9?=
 =?us-ascii?Q?zXrlss120oEfX7lu/8XtU5zW6x/8B1M1FeIWGyudV/BgHYp3J2mAaNFUx04h?=
 =?us-ascii?Q?b4cT78ogYz8Kmuf3DBHABcf00iNDIMLDMD924SRYt42UoR1Z1Phf4EhHwfnB?=
 =?us-ascii?Q?KrIaNchTQG3r+AVLDHO3BvfKHHDFO5ztm+/VX2bNMvI/o+aT+jEQZaUnxbsp?=
 =?us-ascii?Q?DocBba17WiEl0L/fequpkemOMDeAp/ioJ6JyIzUmZxFT1UTMCAyVxSPQ0Xxr?=
 =?us-ascii?Q?oMtvmAMCCSRSu2k+ph+32GG2T6RVvj4EIQE0Ebn7mah4U7AcPstmproRlZRU?=
 =?us-ascii?Q?UAXmUi0bJl4wr7DD4H3gN/pNB0tytEQrzYVtV36ntP+tkRgjBSHESP5MuoEH?=
 =?us-ascii?Q?3jh02sI+GSRDBnR9DRd30UlDemNaDXGwIL8+aJkrk61c0wbmuA+oTRI3Ua1c?=
 =?us-ascii?Q?9uGhfCHDja3maH7cDZIpGvE+X7yqMjbY0acBcPjVfYR43AFGyc58Y4ud4MnZ?=
 =?us-ascii?Q?/Rv5H0264jYUOVKR30SCdwaSH5en3YDJ+eqykG6f9AMyarLNdlkxnkgqWL+W?=
 =?us-ascii?Q?msp9eaD/ltm8eIYqyWBBYu0u8ydx143YSikPRS7XaJaR22mAQJZFCll90aCJ?=
 =?us-ascii?Q?zrfd9bCi7cP6XlBMO70dfpmBN7+9WGh6dJTH5qaW+0fLuYdv4FcFPNtQw06D?=
 =?us-ascii?Q?WZjhbZYh2pjA+6Dy4Ze0spWLE8l50QBWxRB8K3pnvLRTS49byVhVcPF+5e2B?=
 =?us-ascii?Q?EVCSS+kxXtmgf7TQhsuhvH1D3HmQ3PLQCiKI8/3AJo/2BKlcxLV1VM6haeq/?=
 =?us-ascii?Q?muaXBNzGOejs7xgtKQdvbCn0T9SKu4ecC9obwlhyr72MCwYxZomj0lI8q5Em?=
 =?us-ascii?Q?z8U5TERXhg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4f41ca-19ad-461f-4d0e-08df29d56a23
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:27:49.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzNzR6YmMJUM2ZLheZvn1swEHEYv3QHX6s7Y0As/AvR9ktxlBQxYNbIrj28b8QRSt5GB4ruX7qWkurwvquvSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9734

On Mon, Oct 12, 2026 at 09:26:01PM +0800, Alison Schofield wrote:
> cxl_switch_port_setup_targets() calculates the interleave ways and
> granularity of a port's decoder from the parent interleave and the number
> of targets below the port, then validates the result. That calculation and
> its checks are open coded between the target search and the decoder setup.
> 
> Move the calculation and its checks to a new helper,
> cxl_port_calc_interleave(), so that the interleave for the port's decoder
> is calculated and validated in one place.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>


Reviewed-by: Richard Cheng <icheng@nvidia.com>


> ---
>  drivers/cxl/core/region.c | 81 ++++++++++++++++++++++++---------------
>  1 file changed, 50 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c14ac041c4ac..ee9e615a9a4c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1513,11 +1513,58 @@ static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *
>  	return 0;
>  }
>  
> +static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cxlr,
> +				    struct cxl_region_ref *cxl_rr, int *out_iw,
> +				    int *out_ig)
> +{
> +	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	struct cxl_decoder *cxld = cxl_rr->decoder;
> +	int parent_iw, parent_ig, iw, ig, rc;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> +	if (rc)
> +		return rc;
> +
> +	iw = cxl_rr->nr_targets;
> +	if (!ways_valid(iw)) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Interleave granularity is a multiple of @parent_port granularity.
> +	 * Multiplier is the parent port interleave ways.
> +	 */
> +	ig = parent_ig * parent_iw;
> +
> +	if (!granularity_valid(ig)) {
> +		dev_dbg(&cxlr->dev,
> +			"%s: invalid granularity calculation (%d * %d)\n",
> +			dev_name(&parent_port->dev), parent_ig, parent_iw);
> +		return -EINVAL;
> +	}
> +
> +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	if (iw > 8 || iw > cxlsd->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s:%s: ways: %d overflows targets: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> +		return -ENXIO;
> +	}
> +
> +	*out_iw = iw;
> +	*out_ig = ig;
> +
> +	return 0;
> +}
> +
>  static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
>  					 struct cxl_endpoint_decoder *cxled)
>  {
> -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> -	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	int iw, ig, rc, pos = cxled->pos;
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> @@ -1551,38 +1598,10 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port, struct cxl_regio
>  		goto add_target;
>  	}
>  
> -	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> +	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
>  	if (rc)
>  		return rc;
>  
> -	iw = cxl_rr->nr_targets;
> -	if (!ways_valid(iw)) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Interleave granularity is a multiple of @parent_port granularity.
> -	 * Multiplier is the parent port interleave ways.
> -	 */
> -	ig = parent_ig * parent_iw;
> -
> -	if (!granularity_valid(ig)) {
> -		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return -EINVAL;
> -	}
> -
> -	if (iw > 8 || iw > cxlsd->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s:%s: ways: %d overflows targets: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> -		return -ENXIO;
> -	}
> -
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    (iw > 1 && cxld->interleave_granularity != ig) ||
> -- 
> 2.37.3
> 
