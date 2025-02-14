Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1F245B12;
	Fri, 14 Feb 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538557; cv=fail; b=Fqk9wUmilVO2UY7sWeYNQNSuPA1ZjlM/Jr+MKIW6on5KR+54pNaga19NuWteLj+NyNdBCmAnez7wujrPFIweWli+7SX4tozydh1Lp26NTj/YHbQQV5d/IIdy3o2qESeierTtBPdjLZTrtMO6mexn2z5NgmGbwU810QLX4fqDwII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538557; c=relaxed/simple;
	bh=fybFoxEZiZGBRnM+XQKndClrQj5A9+d5XzPVVIS9rI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Psex1xCLWeoF/YcSrgP0MBqLErnFYpM98iYt7qNcl1vVCkwJkXiYLzUbG2Ty6K3RUjVLBO2WNa1DH5FEdUO3rUEMEy/mTcdiG8kKv4NpR5X+EVyvlhxycwmoSNY1xL4N+DITae/oLgzoS2FlDjmAy/crlmjYknb02vgscbkcvYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hmiSxcjN; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hmiSxcjN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shnr7B5CS4aWvVhOfYS+Z9H1ptBl1ZZxN9ElLDFFkWyneDC8e292JP2anlOXh73Nu8ueZZpYKWoXoDZFsBAJu1cjLRkvg1ulTUtCf4ChMXuXaYQ6MvsYt3p8S6f6ntcbUJL8AryVE3pW2CVDxzXVH0ZFl/+6uDxOBVXY4o2K0eS/QKRF4FzydvrndbyzE36fa0SBPLbbkAIWdXhzg1nsbx3SvFLO7wK/bMQV/4SiT1lWEutVdJHqc69dByW/CAl6KNUixTEKaHeYmzmPIqX5Al9vXaYCgTpc1dPv0agmI8dMHTH4B56HJz9oBQdX8bfRPcuUVHx0YOH26CseLrGBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcBYSXTTPrA3wOBe6ePGsArn59GoVFuD1wccW7SvTSg=;
 b=H01AzDqUNU47cSBAVRhu2sTjSzqhk5kmZxRKiyz+EbKcq+ou54315HJiIOYI7/pG1+UUarON+9JI/2H1KwQ3XkIMQ0szotQh+NoLMt3lN/Gt8gYBajf+bkmDO73n9W7bWRgmQCixiqRl8oPxhXmhwElQ8H2nCLiy6crDyNnnzIyfhQDZ34U+C9kfPS9k6sB6SDgEuDWseUrUmnbjK+32CWbsH+kPfb9i2HQR+9cAHswaWqeQHYwrQyvi8Thw++04qW8ksU3/MGonvZAzEyjCaRMrRgHxPspuGGQfEduQiNqQh+/LnRy1WDyQzZZezerAqUSVEf7x520vIG3bMKNCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcBYSXTTPrA3wOBe6ePGsArn59GoVFuD1wccW7SvTSg=;
 b=hmiSxcjN8D4XWoeQut66EsRLNvYiz2LDMWj6JXiM16LhU5LTqFeIlGlP3xyJl+5cmEq72/V3ZTUSsLhYBS7qY+cb7ZSpItdZwnUK0c7jU9MyEI5CyVt23hJABgEdCI4fREieba5EYGzx0BH30YokfZ9fDVUOHnDw/fFMPYuwNpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 13:09:12 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 13:09:12 +0000
Date: Fri, 14 Feb 2025 14:09:05 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 24/29] cxl/region: Use endpoint's SPA range to check a
 region
Message-ID: <Z69AcT2NXH77K8h2@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-25-rrichter@amd.com>
 <Z4VPfGtDiP5sYiIM@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4VPfGtDiP5sYiIM@aschofie-mobl2.lan>
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f18934a-94d8-4d0d-ce3a-08dd4cf8c697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F8o2tAeS7SfEZcDjyrrXPyKZdFTV3pUKt0lP4CdjrpkX+1uBrQWJo6OFqTdq?=
 =?us-ascii?Q?+qFtuwuYmrlRhzGxfJZeeSSJtiwNgmR6BK+8OxPV9GeUwUOTQEV88qgVxehS?=
 =?us-ascii?Q?JDKgMsi9noPLXVQ7rv5t5yVt/7feAdKZ9KvpaFobp13kNTSos3ILW0KLrUxH?=
 =?us-ascii?Q?6wKcTbD7LtnxJYNg/NILQYtQ1OcO7CHovJbJKYjee0qXHDLXduWcS5NxiSZ4?=
 =?us-ascii?Q?T2w+7A7LbvQozfCzMNSn5g66lHoTdZJuBuOkBLL025jIrcHRl1ayVPsWcEMz?=
 =?us-ascii?Q?fpI32XBjpQ6FbFSP4CBVzE5gJg9eP1Noaw0jB2H+fAKDbnCP/U1wcTC3Tjj+?=
 =?us-ascii?Q?4sxt2ODXFpxFtTpymCV2TTFBOAabgiyOs5nd185CVMbhPuW9R0D/asHKn0Kv?=
 =?us-ascii?Q?LTo4p+2ub0HinrhTKvBcWRZzWlt9pJy0oKauN3Y2DOWg7E4wJIsqC5iArfEn?=
 =?us-ascii?Q?TFTuo8qc8v2q7ccwMnMGP5xd+SJ8sOzDXviw5FQgdt335gCDOTSBdMic0PPC?=
 =?us-ascii?Q?zbK8STqkcDq0+XuBnvsXvFK15fc3sXcLf4aCYtfP2etQwoUfwdUAhIVrLVWS?=
 =?us-ascii?Q?x5DFqiFLJ2LOZkiXcqkJIAq5jKtiDo6K7GxuB8bWxH0Li34rpSFT9PENjeXT?=
 =?us-ascii?Q?qlAkD4cgTO2Sqa1Z8xO9AaO98f4AsLK5eETG0mEd3DbqV7hbJpp2buUSb27G?=
 =?us-ascii?Q?ohhnEQ52ZKaFLEuHhOlEDa0O5DyIzVOJ5xbg+sD0bgb8uZQubm/hPqMGWFiV?=
 =?us-ascii?Q?3KzdYg85+QOv1llvrpvymA2y71ZS+eXEKkoNlTGlrt8CNh5H41jYtJaoGA63?=
 =?us-ascii?Q?R9K5wgRMn/sIJgWnH5PukGlYvkJI6K1eWrWDjnKgnF3mSN7o47pTLTyHHPSP?=
 =?us-ascii?Q?cVaF5wjz4vWyiTnUF+e9/tP8X90TjNnDT6NIZ942wrmSXMetdvb/0RU/u76B?=
 =?us-ascii?Q?YxaMCXyidtMhqin8Q2rAif8hAUsIGPchO1+tXFY/nWYf2BjNhjZZfomEUVvf?=
 =?us-ascii?Q?9Yu+ZOlU+Gt6fVYpxxHvh/Y4pISMI+/3//4Rc15+7kTnMvoPBk8yE94u5+5w?=
 =?us-ascii?Q?/6XO4A+ZLmMsZvTtLw2BmhTOVenbQXgb6V3PfJ19IaGQlH3JDDGNQNHw1CXx?=
 =?us-ascii?Q?swYH63+6pfwQqD0fOuBLquwE86z0BOK2aIlpp+mpFPlWnhi5zrM+Y8qzWaln?=
 =?us-ascii?Q?/KXd5D+cFepHVs8c8teZaEI0RGDxztVfK2r6uEMbxWAu5/7JemcYdls1OHrB?=
 =?us-ascii?Q?gkXWbH2PDqemc83JERoGUjnAwS5rhqrRsDfYrHseKCC6bOsQxTPF72++ch4y?=
 =?us-ascii?Q?430/0hv2LedT4KBYKH/yL5OIGz6lX4RljO5kcXMPSntx2oUH/GD0SXVcQQsf?=
 =?us-ascii?Q?jbtquB3A4TaS9ii9g9Prxli2m8PV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ohjqnF+/kMBr9hNxim0IYQ5PMIeAwzjhX4AvtwzzzTFgF8cPok09OSRy9oPR?=
 =?us-ascii?Q?cecT8SpfvFMOcxhl7RRPtzyuAd5gMal7XK408B4g0obs9mgsrAZ2Zzjypy3u?=
 =?us-ascii?Q?Ec+rkCILydrQCzHfIbDMCT28p0V+RxC/fZOI9CIrX8A0i4eYU+CZeN4+SLO+?=
 =?us-ascii?Q?VeCBQ5O/D9PpHC7lA7ky12OcgXhoYpU6XsjgRvIQiH8ig77SJFJvpMMIZc1E?=
 =?us-ascii?Q?iXP3zaOYLc7XIWOSWFq6WWAG34lSEV8aG+YKkXJqEMta9yvhIQ6jUSTG/JF3?=
 =?us-ascii?Q?XZmsCxNBacQuHYg6j1RruewYqEjNT3wMT4uuKSGNKq6H5zYtmdhO8FDKUs0s?=
 =?us-ascii?Q?V5oF/PGUYXWYXQfnpwLEfTd9ev0V8JlMpbQ6xl+WzEctcIo+NDsnDM6pnGr6?=
 =?us-ascii?Q?TuVh/0TJkQUSzgWTqMhsIojWqRWMbzdBNAWunnZhB1/5I8p4DPCD71TePZPC?=
 =?us-ascii?Q?jrl+XAOC2ThDiaq5uIuqCn02umM27Z1yxhI0cAQ09z2Q7Wjzi8OacwkiUiXC?=
 =?us-ascii?Q?VkaIHKHW6wjAnAvmxSaKMyetXLx/GjJ/FKh2NV3UxmPc8MouKoUH4kd6jPzR?=
 =?us-ascii?Q?83nM1CAclphHphy9n0xOYQiHMU7cRduzmvjye9v5sDC6usiuC9onkwMDf73E?=
 =?us-ascii?Q?fzwHLNlhjBS9/Jmr+yhfe3RBugLF5kFkAX9qZz27RTN1E+elvu1QOSOk1mkt?=
 =?us-ascii?Q?72+bTkc9GFTYXfHOxtbD0DkPdad74RI2WiipcCqopexI5wYatJ/BoBJitBok?=
 =?us-ascii?Q?fz1nrTnc0b87aalp3TyYglWdw4ywPRgq5Cah7rAwKpJ3lnGYKjU5MtDD4gsm?=
 =?us-ascii?Q?qECfbE5JXZrDdhG+K8YH4gngx7J3hSdqIa4aWR0VoHtH8Ri0nhg9blZ5+gFK?=
 =?us-ascii?Q?1Nyi/FuLcmrcAF/coexd8cpwSUkVSoqCCudIejjKqz25vPY7TpN86s1krzPq?=
 =?us-ascii?Q?d0I5LwujpaT0CHCFuWv4nMHhzIdPYVPAbx2Zvx6HKaacH4Dqgl3B2dQGsRzv?=
 =?us-ascii?Q?4/58oRN5APV6RrMOox37Ns9UoscK/I+lcb57UIlSjoVsHWzuuiwKJIAwNHTU?=
 =?us-ascii?Q?oaUS6zDP62xF+h9VVjwBUm7/J4JF9HEi1ccttI8aXVfAmw9ZEtu2x4p8TVF7?=
 =?us-ascii?Q?OGjyhdSOXCmam5ppox05I6cF1WnMHa+BnYcv98K52IlmgwMicq12Bc6y5XOL?=
 =?us-ascii?Q?WGMOo8oPqrtodIpQ687dz1S7WAcdNW21qqOll8CeyhOz0fHCpdC5cm47zQGM?=
 =?us-ascii?Q?OzHJ3l+TqKRNch/yqG1b3DA3CIL0yXeb8GwiSKXrkHDseGp6s2kXDRqOedkC?=
 =?us-ascii?Q?q+oFoWza/yMDBznIujerovSwSnM6+b2+ZP9cOn+/1c3/6C2Gw+jccn6MgplA?=
 =?us-ascii?Q?Tl8lr7A/LT0koTLZuNIgNUnrTsLmquCdOPyomlP0Dcpk5hm79ucGBcI1eoEY?=
 =?us-ascii?Q?IfgZIcrM5NVrEtFjNO7dCJNvX1d84sswpGJx2zbMN0PWj44GdyljYTZowiG8?=
 =?us-ascii?Q?29B3WXngERdmUPaljy5+cFfiyP13qx/mToorBC4x2pkoVKvXsQlJHF2Q2T88?=
 =?us-ascii?Q?8w1p/oYxxTv7G2eWkW+EnLcHKUusQp13JqUPmvuv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f18934a-94d8-4d0d-ce3a-08dd4cf8c697
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 13:09:12.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5M/W4OiLNx4OrNC57hQWYerM0FmUiHtamkb2eJfxtDS+QhOr6H3g6HLSU4UHUzPprAKXXwbbmOe7faTG9fqgsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393

On 13.01.25 09:38:04, Alison Schofield wrote:
> On Tue, Jan 07, 2025 at 03:10:10PM +0100, Robert Richter wrote:

> > @@ -2051,13 +2055,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -ENXIO;
> >  	}
> >  
> > -	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
> > -	    resource_size(p->res)) {
> > +	if (range_len(&cxled->spa_range) != resource_size(p->res)) {
> >  		dev_dbg(&cxlr->dev,
> > -			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
> > +			"%s:%s: SPA size mismatch: %#llx-%#llx:%#llx-%#llx\n",
> 
> The cxled->spa_range is only set in the auto region path, yet this
> path is taken by both auto and user created regions. User created regions
> die here.

The original check at this point should still work and .spa_range will
not be needed then. Fixed in next version.

-Robert
