Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61214F98
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jan 2025 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024881; cv=fail; b=C1/SjL53C48bgZAJQbg5VCUkut5VJVFdReyGSmxkxdPTvD1v1F/yxQmrrb1TfYkMv6I5J/ewJIAOl8yOhNaFUUv03BNgg46QqtfelDg7UoNt+ojDR6meHxcby3fp8OJu/UM6uaQYTLcOVFvZKqS5JDudpjWRguzoFZJbf4ZvYQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024881; c=relaxed/simple;
	bh=4Ru4CyiZIpax7a9bg+6fgnDEArb1X+kMcIza92rYd6M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=puc8nl3pCvCGNNjon9u9Dw1JI3nDTUtDcOGdNfO5QwBeOwuq2/hDGZiZgL8aldPuCPwWsWTIfwaq3rhvuJwipkyfefIssBARfuajlWwpXcwSK1emdI7a/q9EZ46avcA+zuYUqYa8Z0VxAHp5wQ0iKe52VXqx+FN/Ge9/VtHe1fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cp3WuCZQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cp3WuCZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738024878; x=1769560878;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4Ru4CyiZIpax7a9bg+6fgnDEArb1X+kMcIza92rYd6M=;
  b=Cp3WuCZQ/KB+8onJXvEZXVZRUOKh6vTAjaZGgyDzBP63Llfwd6M/csvT
   dEiLAc1Op+QaeE7u39c18goMZ6HdEl9tzLIpOECS6+luj0j2HjRlqoVpq
   pJWOHPk5Ov/sQl3ASXut5ug1pxUkl/Q9jK14RiNwOzmf5nAX4cNsBdJaA
   fIyfCutLck705D1jx14n4fOSMA/qVP5E1GDybFya/IUFHKESPh042ga4h
   sK760ckPkuJHyUfffEuyEtQ+vP/t4F0V887a/foD+HKlHf/3By5fM8pru
   y5OrlOmEvoyu43EX7IQcsZIc7vsWwXN1h+6phkctM+HRQVipKPYCL0koL
   Q==;
X-CSE-ConnectionGUID: M4GFnkD1QUScBnjvZWMJPg==
X-CSE-MsgGUID: Oge81z5/TW2LIh3EZMVfJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="60973410"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="60973410"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 16:41:15 -0800
X-CSE-ConnectionGUID: bRkntZ5zTdm91cD/TNaY2Q==
X-CSE-MsgGUID: Ve8tCt6GRS+oLMGp/tbvSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113722658"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 16:41:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 16:41:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 16:41:14 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 16:41:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j04HwZs7j0QDaHGljKG0QSmP9Wt564lGK50y91dGfY/dUcqn+99kJ6ZToq2VUaZsmveSCFaev39sc8j6GknfVarAYnD5D4TrdmsLNuE7myNcLLRBkKIZ3xse5cv2RHugKm6DpYZu+lLc+t7uvElUGxrSVknl4l0PLOujMLNF05t9CyjIymLoFS9nXqqZAh5EPJ9fZEosyeUwEwzqrbn3eHqUuuy5zm2OOsGs/EcIPKjWyVYiOiMAilg/l63ZbjzXmT+zWSZGDN/SWbYqEdRK8roEw2Lwvfv78JbDAmTSz5AWPYFVlaR5i1KujlC1Wrz+EstH47/qGp4NdlQkUAtS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXtX3rZg+HRsoBqUb4MF4RhhfWbKqj9XVh5bsnzFZY8=;
 b=TWYFTKTKdmSnH7Owdc4z8eHx7VKur25difZnwR7vLYqd+fLdC+zUQHlwHctxDeyHXW2eWipTDu0yQuzBwO69+t8u1mmopmi+ASMuCfiRsCaZsCpeQo1vL+ZoeiDGjAMFVEowchrLfg+5Vk1uAWqjrI35INSxHCEtPdhUOkyA7Ox3KwqaZpAq0wofUt3Kh+jCCkxL+8m/JC7/qd0EcnbEST06pcX2ZugGxmP33uVoMHWKM0yXS8OXMOXCIksC61TiKlZr9dsnt+rjUyYecnMEoeu0pyPNU6c6s7jguh+SFqvS9GyHOfZ+w9DZtqsyLYCsvnn9jomPou4FYXAW/GMIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8422.namprd11.prod.outlook.com (2603:10b6:a03:542::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 00:40:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 00:40:51 +0000
Date: Mon, 27 Jan 2025 16:40:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <67982790e13d1_2d1e294b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-15-dave.jiang@intel.com>
 <6794478dd8026_20f329455@dwillia2-xfh.jf.intel.com.notmuch>
 <20250127105132.000072dd@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250127105132.000072dd@huawei.com>
X-ClientProxiedBy: MW4PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:303:b5::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 84580a7f-6c86-4195-7dc8-08dd3f346a4f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BHxfVy+V+1BZrZqUd9gzdVO4G8P2Ge1KJoQdHDPYvX9lTFjB41X4+4VLN+rT?=
 =?us-ascii?Q?SKAKMu/DJ5i63/nqoS/Y4D+c57blaJUWWhmH6eYon/53Zzbs8HCq2HD+laZw?=
 =?us-ascii?Q?35popYBaWBIjuFrEMDmeg1W4sjysDuBQ929eZY5CKaFDXKRDr7Z+L8BA72nj?=
 =?us-ascii?Q?cVwtBdEEb/OgqCPZqMApHSe6ks71dhLZIcXGDyKwzCkJlbUyJrxYWiTpRbAN?=
 =?us-ascii?Q?XEZ2wj8lX8GFgQqHWC07lgt5nS88SxojTbtE2m4Ve42OygGBQml2hH5WgUWv?=
 =?us-ascii?Q?YFyUB5cxrbvhMtEm5ZURc+9mn/rLAw/kwfSF/HB0EZ2LqdEDbwespDI5Ga2q?=
 =?us-ascii?Q?oesJWQm93ReWnd7X8VDaLeD9vfFAmKlzOiipRPK5AgbUJIcigs0Suv5QFW4f?=
 =?us-ascii?Q?H2KC2owP3dMQqlJfV99pwx3ml53Dtcx3Vg95YAlf87jOHraaaqVSJTlsWVEi?=
 =?us-ascii?Q?fsTkpzC1262Pq938JV0liyrkOmMHC0MSSZGr1hNe1lkOAH6uKrzrjXwfCl9I?=
 =?us-ascii?Q?A22zfav8IFx2bY0nGwcNTlNx+CwxkpY2Zp8SH4AKZRzHxvWf5CxF9uFntxFc?=
 =?us-ascii?Q?IBS8BwpJHuj9v1M/ArTrFi5a455UZCUK+SROBvwi8ywfvVPDdi/i9wgIFTtC?=
 =?us-ascii?Q?IHpGjaB1KBnXDNwYSd+p7dwcAQoNIqeYgJwQNi7xUkWdDShdXFKPA98s23kJ?=
 =?us-ascii?Q?YJcaTmNmfPe+VrVWMr3bGJyFAvZmjPtKkk+w2cPFBEic5OY09E4D1kZWG+Vo?=
 =?us-ascii?Q?WG8JI249TE6W9N5zig51kHa1gJO5rBMhF7pay0o3u5sH8gJL0zI/AG4lGoyV?=
 =?us-ascii?Q?uQxK1iVJ7ykVyS98H0LWo8F0NBViuKp4Fy+23z0NqpsPDZW48gNBnU4tf6Lj?=
 =?us-ascii?Q?zdyLKMsO+bLkuVGIBivErCi8IcvEU5i+FL6XI+eA7qV6CSkAzvgOd38Y3bdS?=
 =?us-ascii?Q?d6nPF3+nMK11WGgZo37GOIkr8f5kELZdQDlHcs4v6VZmubn6vosamoZtAnpE?=
 =?us-ascii?Q?pwOUWTy+dZnqyzgVmq/6ofAt0U4vn+EVLG2Av0pS+tyRH0xo2tidMXK2sSwc?=
 =?us-ascii?Q?lpZoDvEBsrqLiYafs7Tv9ESwekhk3Pu5TvPobhJ0ID24r66GCFacwYXFjlDb?=
 =?us-ascii?Q?vlSIcLARq4ZKMUTz6tyZsLY0nPjEHB1/YHodnoG98DflemHInHVCstxG9VUv?=
 =?us-ascii?Q?iXiuDZV2Manl1ZSQ4WeU8OM9j+lCcSgOCbQcki+D0QIGWFDbCo/Z85MTpoZ6?=
 =?us-ascii?Q?BClkmOvu5iTl1XEKCiuiQcNc+BAmWyojnYhMOTvcbm2g7EIDpGp26hnKNdX7?=
 =?us-ascii?Q?/k6WgjjJ+jr+UL+b193iHzzRqBoKVGbVL2KaEyjP6aUMeJuR7tAiEQOIhqRb?=
 =?us-ascii?Q?k7yuZARQLqT0X2nbM8XxcS7GbQS3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3S1HFpP0Z8desnoN/e+EWUxEqRSlU/17ONC0iPbMN58yByV12MuUU91byod?=
 =?us-ascii?Q?Uw7QerJfvvJxPZcIJuz2YvIMH0uaObWE91N0AwbgPWststOLaSQLdVzxNax2?=
 =?us-ascii?Q?dBgajmfm0etZ8C41Y/QkJewOuPpm4SlpDU1b3caXtMlQZjdnXQHIeBz36Ul+?=
 =?us-ascii?Q?d6tXOHOeIZGOgDDH3NMMBg3/G97TK7B2zbKYHzyaviHICpM92m+iRZz7bok8?=
 =?us-ascii?Q?FBMfKFJ9GrplQXKl0d5Bt6pGKV24ooOl18Ywbk3i0Ma/z5eHVzTnDrBmHqel?=
 =?us-ascii?Q?4WYF2XYaSVv2DiLqkWXQVQOVuaDkyrWDbyHBpkpVtSF/hCXMZ3UVmWJO2K52?=
 =?us-ascii?Q?2N3KP3t8+qsqv/SUqnKXUDHAwGwym95oIHbw/TUpIZRUVJXktPBjC5CK/jOd?=
 =?us-ascii?Q?2VnXoG+mpq6BIc/Jp8HKcqLbvOUffMGrpf+e37EtuxLmaw6vzEgYN7Uzv3H1?=
 =?us-ascii?Q?3DrtHmaMhP/rTiZwRkwqVlrTOZqu3zDN8IgJnR1hGTpZ8mxejHOyhlc7dsrE?=
 =?us-ascii?Q?sdDgIL9olGMFTqnOd5jl4e4f3iVU/HN9hT32DCHIIRDHUZPrQ568XAH0tth/?=
 =?us-ascii?Q?9lW9QnVuhs7jJsuBCUsIM6EMCCjjY3B7BFpVUsskCY1Hapl3Yqs3d7x28Gvj?=
 =?us-ascii?Q?KPaTso1DXgFS1Uhbp2bVE+Hrj2nrWPffomhOZCX5SVRUA4kwzH2BLOGoK3AL?=
 =?us-ascii?Q?JwK0nHY3lPd1YO7iDeebGT01FJQGWJoNS8T49Be74QfE+HLmXOORXnsxNq7M?=
 =?us-ascii?Q?E7RiJyPN1csHXjuTPdqSfn6JFdSGPcdkvHiHOIzJTRXkCztFkIzTVEAzUuMc?=
 =?us-ascii?Q?1MzZjcX6x3fNNdqY3UKS/GqbTMzxfUjDq4dDouk3eVbLXpbDicrCH5wXbL7J?=
 =?us-ascii?Q?l3Or5Gq26md6QdXMAo1z3NYVYshfyRN04hbVKGfKUWNQ5VhN3UHViaOzACyZ?=
 =?us-ascii?Q?erleiGzYAb4yf6bAySWQtmhH/nE9YHfHZToxjLufZ7ypm/ZHCzEi9LOE/213?=
 =?us-ascii?Q?5ywu1Zy2OJQi1OJDdkceZx/dTdk8IImWmjBeeqAymUyDJnpStH2/Bt75BKG8?=
 =?us-ascii?Q?pW6kWX6bjtBfQt+w7XwtU7+/nZOZ/zQU1tZLYaNY7r6c2EqsdoHrW7E5Uenu?=
 =?us-ascii?Q?1vx10jY+0lwTUC1QT4PofpsPSmWYRZsdcKNhAwEJsQLGDnGVuIaC3/vfehQ1?=
 =?us-ascii?Q?7Fl5+FB5N20dqLmdqlC9j9L3If6q7oIt+jlw13y//qXJt9AadjbbsIK/GTpP?=
 =?us-ascii?Q?gHpXIeLP6O82+Y47s+8kAMfHrBHnVZqmKd4YvPgiV+Uwmlnt+L6TBVfdQ8aR?=
 =?us-ascii?Q?6dNqKYO/+ZI+H5tptyr9685oJznx8vB6nlT/eB8eCd8pDliFj8fYoZIBZ2tZ?=
 =?us-ascii?Q?zuM2FYEjhbhWQWt05IQ34StNodi5bK9pMmOQSe+px7nXu+cBahcNHdroVvmc?=
 =?us-ascii?Q?DFVDNVVHUkh2Bf7/NbWvpX1H45lIGoLM8vO5XHiME0f+tVibBOfj9LEDP7OJ?=
 =?us-ascii?Q?PTVQ5g/QrJYz0zhEJ/ZqDbtfCLLF8tIPXY/6FEeqeHN9ptvXJUDC/D/AekWA?=
 =?us-ascii?Q?+Zu39q1NNe7uAtT3FG5Ci95PpiOU2Nib3PTQ7kEk+A7qDW6I3eB8bSYfJm8e?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84580a7f-6c86-4195-7dc8-08dd3f346a4f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 00:40:51.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOtMFsqmTzQ5/oIRosYwXrrZAk444kt3l2q+yCmwoePJyWtWyj9lCUnIMx85jKycykegozvrl9+DeEA6XZa+fzvbFnUIPvctbhu4xXZsnCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8422
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> 
> > > +}
> > > +
> > > +static void *cxlctl_get_supported_features(struct cxl_features_state *cfs,
> > > +					   const struct fwctl_rpc_cxl *rpc_in,
> > > +					   size_t *out_len)
> > > +{
> > > +	struct cxl_mbox_get_sup_feats_out *feat_out;
> > > +	struct cxl_mbox_get_sup_feats_in feat_in;
> > > +	struct cxl_feat_entry *saved, *pos;
> > > +	int requested, copied;
> > > +	size_t out_size;
> > > +	u32 count;
> > > +	u16 start;
> > > +
> > > +	if (rpc_in->op_size != sizeof(feat_in))
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
> > > +			   rpc_in->op_size))
> > > +		return ERR_PTR(-EFAULT);
> > > +
> > > +	count = le32_to_cpu(feat_in.count);
> > > +	start = le16_to_cpu(feat_in.start_idx);
> > > +	requested = count / sizeof(*pos);
> > > +
> > > +	/*
> > > +	 * Make sure that the total requested number of entries is not greater
> > > +	 * than the total number of supported features allowed for userspace.
> > > +	 */
> > > +	if (start >= cfs->num_user_features)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	requested = min_t(int, requested, cfs->num_user_features - start);
> > > +
> > > +	out_size = sizeof(struct fwctl_rpc_cxl_out) + sizeof(*feat_out) +
> > > +		   requested * sizeof(*pos);
> > > +
> > > +	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> > > +		kvzalloc(out_size, GFP_KERNEL);
> > > +	if (!rpc_out)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	rpc_out->size = sizeof(*feat_out) + requested * sizeof(*pos);
> > > +	feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
> > > +	if (requested == 0) {
> > > +		feat_out->num_entries = cpu_to_le16(requested);
> > > +		feat_out->supported_feats = cpu_to_le16(cfs->num_user_features);
> > > +		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> > > +		*out_len = out_size;
> > > +		return no_free_ptr(rpc_out);
> > > +	}
> > > +
> > > +	pos = &feat_out->ents[0];
> > > +	saved = &cfs->entries[0];
> > > +
> > > +	copied = 0;
> > > +	for (int i = 0; i < cfs->num_features; i++, saved++) {
> > > +		if (is_cxl_feature_exclusive(saved))
> > > +			continue;  
> > 
> > I think it's fine to let userspace see that exclusive features are
> > present, just need to return EBUSY if userspace actually tries to use
> > them.
> 
> To me, a poke it and see interface is really ugly.

That smells more like a matter of documentation. "Doctor it hurts when I
try to use the documented kernel-exclusive commands?"

> In many cases we could let "get" through even if the we are using the interface
> via some other kernel path and have it as exclusive.
> (I don't know how useful that is, but maybe it makes sense).
> 
> If we ever do that, the only way to discover if an interface is available
> will be to try the set interface.  Depending on design of feature
> that might have side effects - hopefully get never does!

I would not put it past some future device to make that mistake.

> 
> Alternatives:
> 1. Flag. Maybe add something that makes it discoverable if a feature is
>    in exclusive mode or not.

I notice that all existing defined Features set a non-zero "Get Feature
Size" in their Supported Feature Entry. I would not say "no" to just
zero-ing out Get Feature Size as a hint that "you might get EBUSY due to
kernel exclusivity with this command", but that still feels like
overkill compared to documentation.

> 2. Query type interface.  So a way to actually ask if a given feature is
>    usable.

Not sure we really need a programmatic way to read the documentation.

The CXL_MEM_COMMAND_FLAG_EXCLUSIVE flag is for cases where the
exclusivity is transient. For these features the exclusivity is
permanent, and I hope we never need to cross that
transient-exclusivity-bridge for Features.

> 3. What we have here.  To me the simplest solution is hide what we can't
>    be used.

It is inconsistent that we do not do this for the other kernel exclusive
commands in userspace retreived Command Effects Log. The ABI here is raw
Get Supported Features payload.

> > > +	/* These effects supported for all scope */
> > > +	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
> > > +	     (effects & CXL_CMD_EFFECTS_EXTEND &&
> > > +	      (effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
> > > +	       effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET))) &&
> > > +	    scope >= FWCTL_RPC_DEBUG_WRITE)
> > > +		return true;  
> > 
> > Looks good for the known bits, but this needs to return false for the
> > currently reserved bits because the driver can not assume a security
> > model for future effects. If a future spec adds
> > FWCTL_RPC_DEBUG_WRITE-safe effects, a new kernel is needed to allow
> > those Feature commands through.
> > 
> > Sidenote: I wonder why the spec wasted one of its bits on an extend bit,
> > but here we are. The 'extend' concept is typically something like
> > "bit15: go look at this other field in this payload as this 16-bit field
> > was exhausted", not "bit9: the bits above this originally defined 16 bit
> > field now has more bits", oh well.
> 
> It's odd but corner case of going from 'unknown' state for the remaining
> pair of bits to 0 means this and 1 means this.

I don't understand. 0 means no effect to worry about whether it is
defined or not.

> Naming though doesn't match the spec that calls it CEL[11:10] valid.
> Would be good to name it closer to that as we may well have something
> in bits 12 and 15 in future and it doesn't refer to them.

Hopefully we can head off another "valid2" mistake, and I don't think
Linux needs to define anything for this bit. That bit's definition is:

   "Bit[9]: 1 is recommended, 0 is permitted (CEL[11:10] Valid)"

...which translates to "useless". If 11 or 10 are set, I don't care what
value 9 has. If 12:15 are set, I don't care if there is a future valid2
bit gating whether or not to use them. Valid bits are for cases that go
outside of what Reserved 0 compatibility rules can convey, and I think
Reserved 0 compatiblity fully covers us in this case.

So, if a device use case breaks because they set 10, but clear 9 and
expect software to ignore 10 then they get to keep all the pieces
because they have already broken the expectations of Reserved 0
compat-software created before 9 existed.
