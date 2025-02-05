Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928902144A6;
	Wed,  5 Feb 2025 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738745328; cv=fail; b=K+CxIka/zlNE5idcjWm4zXp0hA25JEPhtEg2vCTdnvpmtnisA3x933rFNrOCGLxSESoxzJhe6MxU6zG6xodowRElvo69p0tjduXNxHZwbaxqo2amq1Jdx+JdDAvOJp9nOjdPubE0WMQBHiPPvb163jy72Wxdj8yj7vxlYkTYdeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738745328; c=relaxed/simple;
	bh=+IG/uLRjYfO56VKpV0d5OCLwCj63ncmg6rvDgcdxqAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BYMHkgMVGz1jlzREVvVXj5QcZeEs8ARJPCJgO3K8ivndIseWKN98ytiBW70knAXYyiU6w+KZ3IN/YE14y7QWGR7feFq1LZzE6b1jQsQ4sAPW0k2NLJCkTN9ao0EUjps1J8hXa4OGq+7a55ReZdIc04SleQqxF1HFHeNlR6LKDO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WXsj5S1G; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WXsj5S1G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ris++/QEcHP2eeI6TL9R3/JMmR/WHcqmtcur0ucRf1QKzVoK+xfsaFqGp1TkRAohwVCgzNIG8mcQhLpyssdqU2EpHwlJVsD4TfSCwjOcuvHgHS8WMhB51ATfCdT1ukDboCmPHQXJ2F3/8gpmVTJ1BGPw6e3eehMgimCgaWfSMNwIX5CxL/ZO6uTKAuRvI01jSlPdmZXW/ZbOHn4yuQ4TJfqn0XQuo8MWgWwLSfhV3OGHrODp9cdNWa6mM3aY7Vz8RYT61/0m9BJah55vlfJId7BnfI0qU0NquZM9e6I4au85p9QjaYFSP8gtr9VNUnW2+799IQeu1+/8lKNnRkE+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtjOHLdMUFCmQ7fTsGl5Qhw1TCg/kKqqqzF8oP5fJU0=;
 b=zTA4u8X6/SUF3klnwleL5S/Q4mrRMeTU/Aw4l9k2tO9gxZLxq5tmaWJJufIM8qE4EW/vsj84NRf9sLaXUDU/77tpUrZpilCS7E3kSA0l9XXH3W+MtavsyHUGB4Uz0EQVlV1ZEkvDvSBosdYQgv2qKDaJBuaUcvDK/NBm0uBMt22NA/HHEdPwt7ook/tGaBzJed/t3JsuXEFxQsI5CYV8xXc/RCSpWOeKIFElDfKPSS6bOX8NR3bMNnnnSm/EUC2P0bCqNj0BJ3P8pOpKedvGRh05tmnTmt0lUIRgGOln5P4mNuerdc3877AHKc4ptEft0swbB7bSA3nujVNs7HzfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtjOHLdMUFCmQ7fTsGl5Qhw1TCg/kKqqqzF8oP5fJU0=;
 b=WXsj5S1GiRAylMmzJNiJeS4Q6NIaoxWLwYpOq26l3x5LTNwTDRQrTb79eQQX33NoD8We8+IgVQYuzM4fOzObfOw+6QpWqgMvPFRHy9n7YRf4pOHLk0uYWAVXy8ADuSNlm0fMi7K33YyvYhm0hETiiSx0YsVTspAwgLe+ImaZTJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 08:48:44 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 08:48:44 +0000
Date: Wed, 5 Feb 2025 09:48:38 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 15/29] cxl/region: Use an endpoint's SPA range to find
 a region
Message-ID: <Z6Ml5kirvUK38PQ-@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-16-rrichter@amd.com>
 <Z319Bj1Nk5LAZoL0@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z319Bj1Nk5LAZoL0@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR5P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f5e553-f142-4e13-c114-08dd45c1e5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iBYCWJRVila+FbfTOByb0XSBZJ7iL9Bc9HcfOiH+/y8kGJuJ4ULNwEAcsynm?=
 =?us-ascii?Q?0qoikMTZ753hlctnV75Pz0PaiSTGhDZY9vTBq2fMu9tmIjffyXof9Yo1h0eL?=
 =?us-ascii?Q?FL73WO6ZyDmEanAAJvvAf1oCWVFt/C8zDNbou/+5Jzf3PDGxCoK/dIzR3Ifp?=
 =?us-ascii?Q?nxFn0NcqPQaSXcm9xS9qu30rpQTY2BHAncAv+UqBITLhYSjWanbPOGhMsTdX?=
 =?us-ascii?Q?Md6+NwKJng3Qqji0wBaKEbYh9qlxzBK4C7Fh0cH+VjZ3xYYM95W9zG8Mj95A?=
 =?us-ascii?Q?0v4N0UzZR3cNPgrBtc0FufcSG2mcIJAPxBPTTFpG6kBcNPVmsodqm1lIDELa?=
 =?us-ascii?Q?KZNqHMWcw7oQ5A0icwXxN7d3S163UcihIRx8wMUd6wFkjZhPettqIvPQ1mpE?=
 =?us-ascii?Q?mCAQuG7aZIvz5a/ppinmZnXjSbwgkUIJtZ4oW8dywEXlkiS7qmm+owOI7RMY?=
 =?us-ascii?Q?eE8fj88/sDoBE7rRjuZn9KINyTpM3qzceuvVayYkkmiCvFOCjKxfObuvQXgN?=
 =?us-ascii?Q?DsHvuKK9zHqxdoywZ7798BchrB39tFJ8fm1pW0zobRPIOTnnUNMpEhUuIuCK?=
 =?us-ascii?Q?bRwnT1kBUXnlJKT3H/Rtp72p2R/J+HKkQZpoTq35mDbMsGPDdywPXanxbHMD?=
 =?us-ascii?Q?AhId3J6ZYH8nGRFD8Z3pclJqI5gJkNmEiJoCqMXnNTSlzQeJ+wtqEs4jLz6B?=
 =?us-ascii?Q?OetDM8bwU0DBE4bmJRFaussw7YOBe7DJXiD+ofRGRQiUrfkgmOD70QY2WGwG?=
 =?us-ascii?Q?4x/Cs3lOWNezjzBacKLbvnpmZuqjADbp/gX4Wo3uYFvyYSlW5IKALQmrtWw1?=
 =?us-ascii?Q?HJapKsX6yNgtv7hJTfZYg4gP4LiFO0yovrc6C7720R2EQ+f5kztN9vgrA4Qs?=
 =?us-ascii?Q?Y154O2HiWKLq+IdMJiTQmGGEzSzU3feV6hDNDAysXW6Rsyy9grjPWIyP7ykX?=
 =?us-ascii?Q?WcEWPh1NKri4z8cnDvTaqjAtY0XY5K87QGxdaaADtzTMmdGCkXEpno9UOSSW?=
 =?us-ascii?Q?pifGhrLIanZm10CLMd36KLAVpN8pWgJNxKv+XuWig4OhjvDPlmx7Vv0EpXY0?=
 =?us-ascii?Q?BO9UQionBg4QJj3bno24/fGtwv4NSghviwEyPiyrR97KODks+5NgafazNfsQ?=
 =?us-ascii?Q?cHsnJkEEgQYLFuB50BK8BFykcE/LQElvDyXRlT3BfNMxE84mmV0OPYwdVs0W?=
 =?us-ascii?Q?IYtUw990mQ/a1qytFfzL0PejM3wOrJRMJ3i4VJHhWf65yE9iDITBI5wYbY08?=
 =?us-ascii?Q?MJnjQTNHpKS9jLUaHMUjj9u0WdvOvb9zMpM9X6RiDJEWcJJ3fnWcRuOtS/wz?=
 =?us-ascii?Q?wgf4DCjnCU9q9EB5y/b+aoUX4HFg5x9238wGLDQc/Fa5dB+vsHNd7tKC+JxA?=
 =?us-ascii?Q?8P8m+v3aRtgmu/eGem0pvrlBFAZ1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1McAdM/9dUOR7SLzUoxpg54B5zI8xUGWZbzhk6sez1hLKhHgtsgd4YWnilBW?=
 =?us-ascii?Q?Wv53wdvnwF7Gbv6DRkHr5bsJdetnGMcWPiRUnWoIGklJvHS2kfdX/RqCD0Wv?=
 =?us-ascii?Q?6m5VXbHM95hy426OQrXNjS6UoVDVBc7ADO/po2j8mxD3d0mqJuV+eIgLpAuB?=
 =?us-ascii?Q?JbA6FEsigQPpent5IfRRrpOh3JupwyIiq7xQnIPPETxmedInwaU7NNX4DRZe?=
 =?us-ascii?Q?HiBkbOEjN/IY+bEjPXvSEvxnqEoQZy4rgAL8IVy1+ZmL8UcfG3abezo6WerG?=
 =?us-ascii?Q?5NkDLRe1xvEs5wzM4x2IwDVLSp850dvzRrnTbTghSL13mc5OxadogV2JDmb9?=
 =?us-ascii?Q?sskPoXjVhPAYjwkfFVpt+fGHmOyY8a788tRzL2cCJukXXBUmeiTEcoD5wkth?=
 =?us-ascii?Q?xMcNr2C/zf09H/faOO5yvTOa/5Acv3GAmMJfLUdSmU0kFpFfMkly15zhtzEZ?=
 =?us-ascii?Q?4e04ppuIkRyktZ7aX7Oo+RP4EqeGVbIAbyEgvOjsvWDutwu+Oq/2U2i74Jsz?=
 =?us-ascii?Q?zwzOwKbDAIMBxuDDDatDTmnnyZaJz7YaLCoO5qk4AwqofxoFUP8s85+87q8f?=
 =?us-ascii?Q?7jUacdnRUFqVhpJw9zlWhJ1frWzxSZ2+a0NEQ+B/hCmW98ymApDfjjyRjyHd?=
 =?us-ascii?Q?fjWgzLnpeOSo5+lllk/gMMY8hciCgmfw1zHTC8q23Dupj2+Pws+tOTY21dV3?=
 =?us-ascii?Q?MJo9bHm+nD9EryQgBOCrUKiRsjP8rhw7yMLS/8PbXLTV2wI5z+eZLTtSLj3+?=
 =?us-ascii?Q?V30BgPM/Xg5KhrZaFTz67rxcTR2eljXwBOKk2xRzn5bhKFeDaxyCk06sJPmv?=
 =?us-ascii?Q?Tr/yrWhKASgS6+f9kWQziEuDXDYr9Jg+zWa5n1JEwe93ohDbUg57rKaJ1+rC?=
 =?us-ascii?Q?aXx+K7SIURIGLwLFT3Z7wuTSEqUnkDNsJU/it6ikxuS7CugIcifyV4uMsqTi?=
 =?us-ascii?Q?m4dCJLPOcEDxpxMgV2s3RsQTl4p9zcdcidyWqZeMcP2jZ0sPTZ92/buL/vqQ?=
 =?us-ascii?Q?ZpfnGU7wVOhIPSAEQzprWqyLvWXVGNhskWAmqcpk6NLQcZZdgWBjS/xOwBom?=
 =?us-ascii?Q?ccjPwmVU8BhsozOkVuSFko1VPMzqFDs6FlLTECZcSC/8eaHdI979JWaY6eEh?=
 =?us-ascii?Q?WDRC/rEwi6B4egoO9OoiMw9NextMEv0qiTfkFr6D9nhiEKYMhKgi1seQhi1M?=
 =?us-ascii?Q?IfMX0vSnvFBLLf58Fgg7xHPeeL9m80tAdJ4vemyVNZOcpokuFbjOqiLh/ry2?=
 =?us-ascii?Q?bxlhY2L1+YPOiF1BqR/f3Taah05cC78xCDk7RyxS7LIl9TIIFulC586lrSJM?=
 =?us-ascii?Q?Z+ts2QxcqXlw8/v71tW15weHrmPxzvAwL0IJTvWRzWWy+JtX/yWo8lowOPGM?=
 =?us-ascii?Q?tBxt17ONeKjr47Np9I5BstHw8YU+VLB3/XVjWyBkmCOHHOBrHOJiHsPz74Od?=
 =?us-ascii?Q?qXvF7m13OIbpUj6b5y8U2y85MKv25BJfkdjC4oRa7IfwMmLLJYaCpbMMEwjC?=
 =?us-ascii?Q?k7ExpHbhDIOMkVWbSKgnWcEODj1BeXhsWP0Tx7Ey5l6XVOKK+28KvL6VWLLX?=
 =?us-ascii?Q?cYYwLVKu/gNbmiN0yW8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f5e553-f142-4e13-c114-08dd45c1e5cd
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:48:44.4739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MD/R57xVabejzMGM/k0tcKI8G6LxNKE42VIYC9p76j0gXnhZJdKs8rCNiq+5zqbmrWMvh8/dkZsgPNSw4Y4Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120

On 07.01.25 14:14:14, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:10:01PM +0100, Robert Richter wrote:
> > To find the correct region and root port of an endpoint of a system
> > needing address translation, the endpoint's HPA range must be
> > translated to each of the parent port address ranges up to the root
> > decoder.
> > 
> > Calculate the SPA range using the newly introduced callback function
> > port->to_hpa() that translates the decoder's HPA range to its parent
> > port's HPA range of the next outer memory domain. Introduce the helper
> > function cxl_port_calc_hpa() for this to calculate address ranges
> > using the low-level port->to_hpa() callbacks. Determine the root port
> > SPA range by iterating all the ports up to the root. Store the
> > endpoint's SPA range and use it to find the endpoint's region.
> >
> 
> Some comments/questions inline.
> 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 85 ++++++++++++++++++++++++++++++++-------
> >  drivers/cxl/cxl.h         |  1 +
> >  2 files changed, 71 insertions(+), 15 deletions(-)
> ... snip ...
> > +	while (1) {
> > +		parent = parent_port_of(iter);
> > +
> 
> I'm always suspicious of unbounded while loops.  Should this simply be
> 
> 	while(iter) {
> 		...
> 	}
> 
> Instead?  Given the rest of the function, I don't think this matters,
> but it's at least a bit clearer.
> 
> > +		if (is_cxl_endpoint(iter))
> > +			cxld = &cxled->cxld;
> > +		else if (!parent || parent->to_hpa)
> > +			cxld = cxl_port_find_switch_decoder(iter, &hpa);
> > +
> > +		if (!cxld) {
> > +			dev_err(cxlmd->dev.parent,
> > +				"%s:%s no CXL window for range %#llx:%#llx\n",
> > +				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > +				hpa.start, hpa.end);
> > +			return -ENXIO;
> > +		}
> 
> I also think we should be able to move this check out of the loop on
> various break conditions (iter==NULL, cxld not found, etc).
> 
> > +
> > +		/* No parent means the root port was found. */
> > +		if (!parent)
> > +			break;
> > +
> > +		/* Translate HPA to the next upper memory domain. */
> > +		if (cxl_port_calc_hpa(parent, cxld, &hpa))
> > +			return -ENXIO;

We must check for !parent before and it is clearer then to directly
leave the loop.

That is, using

 while(iter) {} 

does not improve the loop because that would introduce duplicate
checks. It is not possible otherwise to break at the beginning or end
of the loop, as there is code to run, either
cxl_port_find_switch_decoder() or cxl_port_calc_hpa().

> > +
> > +		iter = parent;

> >  	}
> >
> > +	dev_dbg(cxld->dev.parent,
> > +		"%s:%s: range:%#llx-%#llx\n",
> > +		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
> > +		hpa.start, hpa.end);
> > +
> >  	cxled->cxlrd = to_cxl_root_decoder(&cxld->dev);
> > +	cxled->spa_range = hpa;
> >  
> >  	return 0;
> >  }
> 
> Overall good, just think we might be able to improve the readability /
> safety of this loop a bit.
> 
> Stupid question: I presume a look in this iteration is not (generally?)
> possible, but if it were to happen this while loop as-is would go infinite.
> Is that something we should worry about it?

It is safe, this kind of iterator is used elsewhere too.

-Robert
