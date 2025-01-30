Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52413FEE;
	Thu, 30 Jan 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256018; cv=fail; b=nEvn3IAOobl69cfn57X05eAzP4rdntrqg8hsuMuaBbiYbkqMEpbrbnBymTfTYY52vysWr2uXWJlzssOTeX4Y7faadwOIQW3Pg6V1iEQgx0DQ2K43x5k5lRDuP4OY3v3IrHOKnOG//OU3lVzJHVt9Ncn/fN2Jq4pIyflWmxX+zDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256018; c=relaxed/simple;
	bh=Z1ybt6zQzVxQzI6vCZrQ6TGUe3apSoAqjqXvl//CZbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJdoIdQpu6KZ+SDyqV9y/M6blFsAVygHTmJEfvZzJz3F53P2laGOIsdhYTQvPeJxp4z7nRd3MBnU1xayrrMvPmJNApUDj7SsD4T8FgsuOATY6X2GbKZn0iP9Psu1o9cUx5HJ9mPojyIMPOyim926/XKTZJ6F1WT6jxziRnADkpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gBKOay1B; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gBKOay1B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsqp6uFjDuw3obHKtEJqipsJsgqmuk/ZGf9eiJyFScM2ZWjkd8MOCzNOjqZFZhjvMfydXwQGgHlAtp71WrG9WMQxCi5jnWHCcK1gnWU/trRODEhd5zQF0NGRG4MR9YivIyZMRIU7u255v3hTFgnyhxBQphA1Yl5eBj+48unu1XhJ084viB3GTJoHFQeeDJ46fphtHd5oETXPY7DbnmuI6j7MKGx7/KAcv5EhA7kw/jl2b6O1LDLGoVHiLB1cSVRL5CBnqFYVFU1iYUC7jGXropOtg7xzBX1OJD3YVZBVdkPzim8US3adkCteIKJF2uhe1Q1+5GT+KZ/cMQC7SuNtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0Lud3FXkQkr9XIhZ8gUpZU7iseFBbgX+x9nk9bQa7Y=;
 b=DZSFtnsC0AXN+QWNDXeHqQy3r9ZbEL4/Vmntxzyhak09In2gr6EOktjb/DatpK8+Dm1om3ezRrZVxkuK09YiYNdiBjmC+jOKkrYuWk7tupNJeQeu8QxXDB2KcZVTFoCAV81LiRsLqrfxiIHTAuacNwJEtMcN5GgEzQSILf/FrJ0YtSRw7aEKvSFz9l0TTkWEkTxVHefZkbNyAdqmF4xlNxJTmigpgKoTFMH0s83g8ZdHYA9MBIDzRlWUU9FN3A+25ZExXaeX303r7adduiTi+1+W3Sd1z8CsG0W8yNKsKDU8XGKcorOAujluvWSIlokjHAGt92wGGw0hbTHqfykYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0Lud3FXkQkr9XIhZ8gUpZU7iseFBbgX+x9nk9bQa7Y=;
 b=gBKOay1BkWv4M9LOkbg9Zb5AbiWsEXmNKogTjX8HtvRR2jRMRCeviEI2fuQuFk4f3hDQnbseadvb+bWz0MKf8+W3TzWFX0RveSkUxD/BYXzlMjVUMuASkkDRWsEioqZFzwLI+wIQ0gxUSGInmoXnQ08Of/G/1MTsIkJWthm7/pM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 16:53:33 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 16:53:33 +0000
Date: Thu, 30 Jan 2025 17:53:28 +0100
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
Subject: Re: [PATCH v1 08/29] cxl/region: Split region registration into an
 initialization and adding part
Message-ID: <Z5uuiPt9TxGQMxZq@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-9-rrichter@amd.com>
 <Z31yb1WUA-5vEiQr@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z31yb1WUA-5vEiQr@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 63581234-27e3-4f5a-b88c-08dd414ea1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwkUgySzao1BL8DUU9rW3vPeTc2iknlJ5T/a+OQtnnbW50E9tAdmkjECpSI5?=
 =?us-ascii?Q?LMrYHzWmxKMUQ0jsPn/3vyt2NfuQLFDTTHL7/BhAtRxat+mVFP3GBNLq1km6?=
 =?us-ascii?Q?1R67P0EIRfXk8xmWImSPGcXeMlVwefWkkf3UwMcl7Ulf2RXgM0gowjBSkomd?=
 =?us-ascii?Q?LrAgBwc4hBnPGgeq5pr238kErerAvWMLBDV8NW6ApRBoyJnyEqELhEUtt9gI?=
 =?us-ascii?Q?w2RWhwb6KDJ6v6ZJOMkv+1bp+89ri6yIbe3ZziWU4S96ncEGbEISfVvgI7oq?=
 =?us-ascii?Q?v1vypwekHftUJMKZezxOdSHJvOkHFLy7rgZhE7Iaxmw9a53f7cMr0hWINfOc?=
 =?us-ascii?Q?b3Wa6uzSMlfHpT2LGZV+pjlkChLXEdijAFpBWMkxHHZ8ItA/Y5cniQF+9MGL?=
 =?us-ascii?Q?0L+SjH45YV9J+/3F6oKxLDbQMFkajvUjAQ0JwTos5FqLVnpn6bx8Z77NPFf8?=
 =?us-ascii?Q?T2g7uDdpiyiGIBCYIdVYSVqrQM/pjgH03pLFqht9g0hHoM/UN9a7Cg25gz1Y?=
 =?us-ascii?Q?HNSN8Cde3132n74prLs2DRxVU8fUHUwDM3M2bQfgtOY2UoUjDHvKHNtwVjXS?=
 =?us-ascii?Q?3lgE6gF/nV9loKL1WUBd3QWoWw8fcHzeovH6LfX6wGGZ2+EZj6bLNwp9lGb4?=
 =?us-ascii?Q?7Qcsyo1q6VuCLrhAAB0F1FCiHXdjk+5nqmLrTscF+gO0egs8JYVxLnHinNbd?=
 =?us-ascii?Q?HXf7KdPWqEBN9n+FMrwslKRvlNSagDQMoX8lC9VhtlXZC1dradNkSbYlAolO?=
 =?us-ascii?Q?SZIzVTZIQ816QE3AEz5ztBccDhfFfKJocOWqUpSudnEXhyckrDPKptBHiUr0?=
 =?us-ascii?Q?ytNcnnzy29jVuAN2BMxUYfGdLFB33/VenhxESb9jsnbRxkY21hr2IA49inqu?=
 =?us-ascii?Q?+GGtAPwlcxpAMrVZ/V3qMLWucvQR0wpW5LI5n4q+fiUAMnUoZxDqpjx2I+3m?=
 =?us-ascii?Q?hIN5ruaM1ZWvozQEGd8GUf1LhAKPSkEI5zE47631sA6WkiK3EY/JUt5JzD/y?=
 =?us-ascii?Q?iZvRfBgypIac4NEkPZNi+lK6pHM49vcTSGq8nDNCvtbiEA0Ze9D3YdpRgp7T?=
 =?us-ascii?Q?FG0YJhOauKpFhZwOwidCZO7cUKLog1YTB3cv55AWxHW9wOh5NQbtb0fDLH6m?=
 =?us-ascii?Q?sfukcKwapcDHRBCGNmx3vQOM+cW9r56eC1Wjg5K/ggw/6NFCT8TCEccy5nxN?=
 =?us-ascii?Q?MbJzgr88gc31xC8osmuoW6FYvqw1SjAx5v4cuKMtmZebSTI32U2JYzARr+bm?=
 =?us-ascii?Q?hKTN4mDet2zSAd9uCuXXmGGv9pQyvurQrFmRsz0mgA/xUHoSsC3NJQnK4bNB?=
 =?us-ascii?Q?gZksl5SaSz2SVhSBUqduJPTpzIv9XybFOrwS5Fs52tMzhZFhZjeCAj4GineA?=
 =?us-ascii?Q?W9lMJrDH6SHo4okH2OMrL92G6XX0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+f1KSFH3pKtGMmgx1BGovpIYICWNklEOA+LTsdRssEjWCU/SKXgQGw66DUP?=
 =?us-ascii?Q?YUW4Z/kH1a7qyZLoAeSJwptEESauFvFCxW6mzx008TMtpnUydxqeHhq5Jw5n?=
 =?us-ascii?Q?3nt1R5KIGjVzQOC4NHJ9kE7aCN9AuI2GGIzcCK0rsE15OIWWXfIJzoqb4cu8?=
 =?us-ascii?Q?h6ykrGLeRJBDmR5PRBGI94wiFIbtJ/GWC8V1QMMAeg6ZvCvnHuACu4lV1S05?=
 =?us-ascii?Q?cSUUiqM0q4lEj0ffm8mwg8O54yhbe0GfxNQJDb1ciCWtnyXNtydBwl0E9JoA?=
 =?us-ascii?Q?hmcxvOrZmYsO/l9518DEeBY9FLmJ/esdQFis14LQ9Q4gJyv6rA4r+AUXWtoI?=
 =?us-ascii?Q?HVmQHj8RyUY7TBoivArxxre/vUBqMnavq5r5tZSb+j6JcYo5kC7nISq6ht9x?=
 =?us-ascii?Q?tRZiii7WzbHXK9lI9t49g/mZyBG6oR205q+S0aWyjN84OKF78xjHAdJS8lNd?=
 =?us-ascii?Q?ZYTTv3pvI1N2TZ0apvp03X7QDkjwHbxIKw1HlEsSqGoxeSJvmAOZwqHcRZ0f?=
 =?us-ascii?Q?j2snC3I0m+/TiNXrHsdYdvR35KixTxe4u0VL9DFWRHf6Weg3uQ0wmGc2MTMQ?=
 =?us-ascii?Q?I81uOiqHXdXchSWrqsFljXBirNp1Ojmcp0rz904gDDaKIabQtqzg2o5r2+ee?=
 =?us-ascii?Q?Xtp3anhPHDkUoqH5+E1S3cA67YnxDNFnyXtoSchRLlbpFo6wW8S4/TZHIvDk?=
 =?us-ascii?Q?F70nadxZt8a4v3SduNytJzu7n9mDY9mvQsy/XlnHh8DbKsp1to/szPTJe8fl?=
 =?us-ascii?Q?/LQcK3HCDRRhtr+RLWVjuoXoLRZJ49ApoQMJPPAAyj6jHor6I+RmOjC8LvtK?=
 =?us-ascii?Q?999mWj1ZIKxeHJSFfcpnreRgBL8dHyhLFSaixaVXHqEWkODCDhxmmdR+hGst?=
 =?us-ascii?Q?js2hhzfFkIAdREtwAZl4GMkdYW08+cmOfO+d1ubmuykQOljHC0fOySrhin/9?=
 =?us-ascii?Q?ZmvaqV9hasYKPw0/kbOrnMKL1WNK1kwShAC00U9bS1Sy2Gym4ppbCmuPDaAs?=
 =?us-ascii?Q?pAzwRFGQVPBo7MpTqhioqJ8gUfJiW/FnpcCH0zhpDfD64uGYdZuyyT8iOflj?=
 =?us-ascii?Q?fqj+qEnhLgXF+mCxw7BYFE6glZ43QKH+JXGUG00W4KPZgwr0Ywdo3urcE3kO?=
 =?us-ascii?Q?K53OxhWprsVA4CYc0MLjQ0tCLHvUhZT4fBUhToW+TsA239/YeSr0R+/NupW6?=
 =?us-ascii?Q?3Gv0pEGCNbCED1gTheEPH0yAtNmi9Hy2AKizWjNFe3vFCH0oMpZUjvWLqi0Q?=
 =?us-ascii?Q?bb6Q9a+DlPUVCBxFtfUYkyEx+LvIN8S6OpVkVBae71GXYPLSpSLWThywGn0q?=
 =?us-ascii?Q?InwGh5AGVENoHqx0F461TAQr1WWqpshyH2QZoy5hFa9TSG/gprx0RmUatYK/?=
 =?us-ascii?Q?/KH4HdhWhRRIf5iUJv3iB90RfTivOZOs0N0WIQ8yZrbQFreSAVT/Ne2hHIe0?=
 =?us-ascii?Q?Xef20l8hM/oD+hOZKF88LoLAOSajxHK1jRg/UHjJQ6hJAiTvl60ysnuOGpWs?=
 =?us-ascii?Q?BIxC8taFfB5MNMXn2n0oKw/9LumU4QrcmE+aK9e3BYcmt16u1wEvwPmr8L86?=
 =?us-ascii?Q?btqTl2f4DRQlohzYzCGOtnTfI3M3Da322bq4cWgF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63581234-27e3-4f5a-b88c-08dd414ea1ef
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 16:53:33.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnGZQ7s7+ONMg58KIWPcgSC7ioXqbEqjDNifRGrA8SXL8GjJAhqma4HsB+tZVROm9lSMQo1hH1xZQbSvTXFb+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685

On Tue, Jan 07, 2025 at 01:29:03PM -0500, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:09:54PM +0100, Robert Richter wrote:

> ... snip ...
> > +	rc = cxl_endpoint_register(cxled);
> >  	if (rc)
> > -		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
> > -			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
> > +		dev_warn(cxled->cxld.dev.parent,
> > +			"failed to register %s: %d\n",
> > +			dev_name(&cxled->cxld.dev), rc);
> 
> Is it worth differentiating obvious failures here for a better warning?
> I'm fine either way.

If an endpoint cannot be registered, this will likly cause a region
probe failure too. I raised the log level to make this visible for
non-dbg logging. I have also removed access to cxled->cxld.hpa_range
as this is implemenation specific to cxl_endpoint_register(). There
are other debug messages to determine the details of the failure here.

-Robert
