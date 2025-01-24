Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC714A098
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737730920; cv=fail; b=YxukD0OMrHw+WO8Jl9BVSFxKhCIUxJyJHw2wQYDB4DHU3XHFQRuzI9aJUDWW3PTps76g3lcfFtzbsLANX5qJwU1y8FwEOpk81m6K1CRqG6OUA0tSmyvHe8MSZFGoUAWW3ponJm9ZurK61v/suQW5d/5yeasL33NylpIjoezBfmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737730920; c=relaxed/simple;
	bh=67qikbUKQiNMlT6EilBS99eh7KfSZ/8cKgJw6Z9U+w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oWHG+cwFeKNeYMTZdB7yOu1YIx43qrotVwz5Ok3dwtS5yrQU1OHzeAlsSdQY9IhY0VwAmsLxPR8ztdBmf5tqIzonNB5okusTFHRLyOe6sF1zMF+mpxr3UpXfvh4lulhUyhwNp8WDIoZrfR18fB+LgANjTmXIuXEuyTy/Q+1l0Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hPmekUUn; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hPmekUUn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VV9abKnsb08vQz5N+ww2MJXb/hKSzN1fIxPdrSwsqXlUyBz3oHzBYdAT4CJ/geFOQKKympg6bE6fWqbPnyYHiQkgpAUcUZULg+s9nne3sueeOIZzpDJay/7Bn03gpPobAeNVBYhYJ5/77+20yhfWjGeN5a6xOYzI9Y9y0RsskY9/mc/UWV6vkdbHEJzwWp0peZMVAfohPJ5t8H8wABewii2kWODalSFGqgGY0qnO21L6eg/V/tWuTZ8j0ptR49E8k3CkLnpD1sn0LaBlCi+pw61ix3GodghHTirtaq2ED4ccf2u30JC5v/9cj1AwrBDiXbgn+rcnelwqeTvDvEz2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+r8Dj9HeEHk01NYMu+voHp45l6FVoZxOF7gTBro/Pdg=;
 b=F+HYOEpl5l8hmkEPlcfysL+HFeiqarCUsVN49khN2yXz4vluVp4Hh/gpDnZfh7y0x0UuRihyejoFV+7nEFB1Z6E067Wsde7cGnIU0Hq0fswrRg1ZJzpZ3YuBC/Cn8vgKXar/uJJYBTkcQM9OuW3pqF0ZNCmd4K0MWc1k5t2g+Ga2tDH34oUB65ZaeVhIEgod63s+zq35jcVsvKLiBPGg4SWluj1Y3zDZPODXpPBSijr6Aa+F967oJlZrpRwgBRZNNPBcZM+OLQ0TbK8wAXrn71Th0OhzG51kCPCh9FyOo8gOQD+Gfoci6oPoVvKPaBl/1PgUjC1m7fv3o3mg1CcFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r8Dj9HeEHk01NYMu+voHp45l6FVoZxOF7gTBro/Pdg=;
 b=hPmekUUn3q3UjKcDxib0ia9rCk74d8ARY47XdbSu46doiHySuBhPh5qpQBqONzkHYl0pk2AYAVdSzu9lieYcvZBfbQKbmeAcQJrFORe35Z7V1iEqNOJG05lCSz0tg2V72d/IRfdJCT7idluDhAKkCJJ43/w9Ug1nc5mUDyJjmzcIPkWlZvkOZ2xivLSgB2givmVSrD7UIokMueOKCTnimMdP0aLq8c+1B1B/6eKcO61lj+U+bGulFOw2LKXXCjiE27FexmtbKUjfKI+DErZifVDpN1JqdaY2u+nhmQpzgJwnOMC6k0dep8HtMLYW1WVgj5aJ0yMtZ77nvKXYrpOyUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 15:01:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 15:01:51 +0000
Date: Fri, 24 Jan 2025 11:01:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [PATCH v1 04/19] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <20250124150150.GZ5556@nvidia.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-5-dave.jiang@intel.com>
 <6792df1982a19_20fa294db@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6792df1982a19_20fa294db@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN0P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad62aab-0fed-4cf3-c3c7-08dd3c880855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NV1EIahukpAaw91HWF0c3hZ8SZ8fHaCgMGhBFqCGleF/hRKV6790SO6p4S9L?=
 =?us-ascii?Q?q38kbwqk6c0KdNMwo7xhHxJf2U1uBW3hPICDIIqOThzkNY5AERSgDNtGuk06?=
 =?us-ascii?Q?6yxSrvkjED5lSnR6VRiQo7ozKpWE2YCgiT+sKjSTwlqgATYRmn8v4G27+5Wq?=
 =?us-ascii?Q?8EA9BqNbxUDY3sVEvUX0zkWMHlOnI89McgJhl5eT8+09FlU+yhtkJGbxrh52?=
 =?us-ascii?Q?F7oQeU8hqzHkAT8xBRb0wjEbQ+ku0+DTs4LPo1v4tClF1bGJebRjZFAw8UJB?=
 =?us-ascii?Q?fcx2JAiMyZ8x9NJm+5N/UxupHgwzbsQQPpDHlqtvVzEcrS4PMDZrfn0WQ4BH?=
 =?us-ascii?Q?ZaQkQtAJu+Md0y85s06373YkK0MKx+T/RYv1qPdc7Gt2thUhBcDfFDUZn93A?=
 =?us-ascii?Q?YKoCAk4KW2qYU5XkooQUynViYTOwLvpil8JPUsxzqKMVYhWEuQwGe6tQpwtf?=
 =?us-ascii?Q?Oxhfg2MmAT4hcDJW9X1rHTPjYydXlH63FEIMpSvABR59dELw2lP3O1OabCFP?=
 =?us-ascii?Q?6jtPK1+orQ4opxeX+rINbqTonba1SkTbV+lmFDpKcaQJUpYnogXX6xqdZOoI?=
 =?us-ascii?Q?NC0mFKJkeP+w8Ri6SpRzJEOhy5OBK6iOU9ibTZP9fM8u/1tF5ze2CVFqbrCT?=
 =?us-ascii?Q?JF12htNLrsaN37oGjY8IIZJG1y2FGqPp7/Sv+GMYGp4RFLGktpMB6hBrUVIN?=
 =?us-ascii?Q?De/FoCcPYYh24wDwQZnNAL9WjnYvAZoDC34my9DoWq38RhlYx+qyJOplqtGs?=
 =?us-ascii?Q?kFOCbWcx6JWmXY/UVPNFIHUVg3xDLE1PBUY4a8SazA9r8PaP2OebWExAh95E?=
 =?us-ascii?Q?HCfxFdYVMRlMM9HvcjuhQbcjfUKyHEOUMGL7qVRueulEnWCirx6LamZ0rsNC?=
 =?us-ascii?Q?t3w2yxGG0moCuTcovbqYcgm+3srrzab+sJ1Li1tv1UsZ7N8UAA5+BlHYxRAQ?=
 =?us-ascii?Q?J6Mz5ESaEKicxwLkRbArhh3tjaYha1cx4lr6xUy8lLuro1kyLHz+ZQsQG/++?=
 =?us-ascii?Q?qs3O6NcGjIAknw8Su8C84D1HuFXA7nzAjzfqECGdwv8Nwrdoxo0Mt6sX/tIn?=
 =?us-ascii?Q?+0mV9M/VNOGzzvFwS/3fksYkFk3eC2ovG8yW8QcQ/LANlAK38EASRSkpaW2n?=
 =?us-ascii?Q?3cRIZQkoXnE2Z2FC8h9w7+lUS8RpRBGAaMiJb3Td7HZkPnbT6Sy8DLcj1/pm?=
 =?us-ascii?Q?n6n7INwnq5GjIHx7uFuepTC7YumM9ByylqCIQ1VyHI/Ym/RjBFMw+kASEXqu?=
 =?us-ascii?Q?TywqI2aN4QtbP4pes+GX6EzVwKAKwa2+KzD0WGxBQgrc2GWsTntomI89H2K6?=
 =?us-ascii?Q?rnLBSl2QYJ0kU0R3Zy1FvlPugt8IEo5Q7XOjy7YOwb20GU55Crufl2UN039Z?=
 =?us-ascii?Q?z6ShLTYfNlmSQb74Bk9ZGrt0LBwD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtsOygEbh2bVYSwQeBxIiAEt8WAK0yLjRUwKGhy8OPwPY/d/lUSZujF/NVP6?=
 =?us-ascii?Q?E9ScxPsEct5Cdii6VZ0ojQ62ktrY2Nx4oOYV0VT1OqiQi1FKUnrmXX6lrFdO?=
 =?us-ascii?Q?OTlJ9jisOk2eahK4HswD5gsPePKZLed5QlFF05IqMhWRAX6OBMrp53TNsCdm?=
 =?us-ascii?Q?v5ZMBkiz98gDgOEhlsh9AKxMbaWJZ5KWUl9WPaVe23oh2vVEIJ6oVmjlrBJ6?=
 =?us-ascii?Q?LcqnhHwNH9NgIj6eh7bWODbNjguo7TPz2fD7XQOrs05wXXxzA5wg8O7MW7LE?=
 =?us-ascii?Q?nXhsmDGXm3UvvnZ0tY7JVAgUH+HkAs8Kge5kIpjwhxJ3o1v6sSIxtZlwsjAj?=
 =?us-ascii?Q?mqrzpc54Y5su3RIWF0CHUoZ+sDP5h3sUAJ6tqvewO8qOHUjV6n+gCY/XuPxP?=
 =?us-ascii?Q?9xdUCcoemarBvapGkMkDJJcUG2m+vGtV5ZNQ8jYoDgodIIs0mHUkWi6yRNcw?=
 =?us-ascii?Q?RxhlYYhrgX0fxvIwN8qJHEngJID7YnWjqopHRcvexyVhP+Nwsbw4L7Snpr2H?=
 =?us-ascii?Q?a38bmmvewUkgwC/p3PU2dXZM3NreejlkSYR/oWHW8Mu0DcnU6TRhC2z7z0EU?=
 =?us-ascii?Q?1k8U6WkDvkP51FSwffdORlZGZraXqE5XSBPOGgN7DlhO21TFIFqjBLIaWy6q?=
 =?us-ascii?Q?XUdrdcLeaOOnaDeF2ykdPeNqOX6jXlQmNPPV0EoZRU1WdWkRS/2wnc8WMezT?=
 =?us-ascii?Q?IFrHXwRaeS3vvlcrz12BoI76JI1dGCZFRSD+cFwkkeAP9xR+pcI/u4TKszld?=
 =?us-ascii?Q?xwelYgfKJfVJR/LSBJyl0WteJcASoJZavwZJ+9rToIEVDBk7VdjF17w8O0/X?=
 =?us-ascii?Q?r+fwFew5DZhyzhB3gG5VbQDxF5EoyJGZSgfaPc+B1bjEm6A+evrgzNWEQzmb?=
 =?us-ascii?Q?vmrXBqtWt1ZPK387FAz1qeJHuMs5Y/ELa2BZhVfbkyY6fSFtEOvJEWEFRYih?=
 =?us-ascii?Q?S3CVXXftHvwK1PQCz/RXq9cP++G2o6l73+PIrIhx9IEYhXHkZRSFv5Y2ciR1?=
 =?us-ascii?Q?oYJQ5sg/+tO9fNCdCMrAb1DaShPSkihYHbo40Qwli0mT1OlJvBzYQ69rgZMx?=
 =?us-ascii?Q?hHw/sn04jNTTP5J9/PB80DZBbJ3g3zWAoJQjHGIgw7Ju5UO+2RyVyrru82GJ?=
 =?us-ascii?Q?vOk1JDGhhB5GY9VU/cjnJ+yngNG9IF326QiyqERM/8LTf/ltmF/EYAJpyfj2?=
 =?us-ascii?Q?CzBLEk4NWZX2vcAzNoCETk8AkQhENimYhIE0bWchLLevzUH+BjifexBlgrrd?=
 =?us-ascii?Q?hZreDyt00zLn2y+uHaI6GnII8OSU8uhpNanuIh22ueA9MRi50sWWbKMw93Dg?=
 =?us-ascii?Q?SxyVEIddiWjqLoU5FlbJDSQrH5fP7DOWFhVT8i5LW20k2LgJNqkk631Jj4Pl?=
 =?us-ascii?Q?/4HG8UuVVbRnoi2LwoPQIEaeJ7gGOfUOiO4XG+9tuABuIi7DYYaUkGiLeE2Z?=
 =?us-ascii?Q?HxvKghiUSHdRjecHJijX2q0kJeb5CrvwZZpYF7JdY9qFTT94U6op5vs9h9tc?=
 =?us-ascii?Q?DjV6VgZ5bigirXnAcTM6TfGZY6P2ByG4i9JZYq2BJ1+czdvLvIo5U3eaKcWf?=
 =?us-ascii?Q?wjJeGYmC+iBx1Poh7VmgbnQIohOQ4TSksmX+zgvo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad62aab-0fed-4cf3-c3c7-08dd3c880855
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 15:01:51.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLNSHiYhiwbs+Ro+hRvAS6jTtibIIDFlTTrCipD1cVBb9uvX1MSORAdH5+L5jraE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231

On Thu, Jan 23, 2025 at 04:30:17PM -0800, Dan Williams wrote:

> > +struct cxl_feat_entry *
> > +cxl_get_supported_feature_entry(struct cxl_features *features,
> > +				const uuid_t *feat_uuid)
> > +{
> > +	struct cxl_feat_entry *feat_entry;
> > +	struct cxl_features_state *cfs;
> > +	int count;
> > +
> > +	cfs = dev_get_drvdata(&features->dev);
> > +	if (!cfs)
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> How could this function be called outside of the driver being enabled?

+1

I hate these "defensive" checks. Either your API is always called
under a properly bound driver, or your caller is horribly wrongly
locked and the above does nothing but hide bugs.

defensive "can't happen" assertions should be marked with WARN_ON(),
but I wouldn't use that here - the oops on NULL backtrace is
sufficiently clear. :)

Jason
