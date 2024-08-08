Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9402770E
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128664; cv=fail; b=qbhtrax1X12bdX5Q9ujQlEOwXwLPQXcdWio/PW8z785KYICu/W7lt3JcQpcPR7by9YN0zpE3KqpV2u+LJBDe+FWYFznY1QfUxUxdTlYC04ibaZFqNgqLuDBf1eeU9H+sD2Yzanjzczslp77vFsDA3f3QZ9/VS6GfpFuEUeGF7t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128664; c=relaxed/simple;
	bh=cEon9t7m3E2X1uP+BYGwp8jNkk5NarRKRX1LIu27wjc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DItVTfdPLXrHMt1SrafJB562s7ldP19yZpRjlk/L7uJWjbMsNx0Ud+SfqeYKtU3hdmvkpzxfkNW24Hi82bh03PiwQkWh+jqH7uhIA6Dz4CQc6eV7zXQy9IjV+O5edh4xnHjvWU5gPWaDHUbY6mk011UnCnR0mJ2OkJDA6WO8yZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAjRTS90; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAjRTS90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723128662; x=1754664662;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cEon9t7m3E2X1uP+BYGwp8jNkk5NarRKRX1LIu27wjc=;
  b=AAjRTS90hWhfUDWIsK9D2EgwtAr+5F3q/vcgZQ3B1fY7JMsMVgUcI8tq
   6nvrlWZ4t3wgc+tKpE/aiZwzUKEMvl42k+oALoe5GMhB26YCSMc8JgUfa
   zrFfqhFMnpxUbSHrs54SQEhHOK25mqlPAzyg5xAZBXfx3buoVyNQbSQBt
   xVvixnp3VIlqH8SyvP6FkRNgPI8yHZLGsvhErhGcxkDP7gjU0DTvzLTk9
   XgUU+WU8MuH0Xm/QUpi/7DsNxM7+u222GFaGbPE+/LqtKKhxKqxxnHcPX
   jgEzzBkcbfRSkSCPRzYwMU7sss0tg5EI6vqCZlA/ceJTBw5nFGs4uvp8w
   A==;
X-CSE-ConnectionGUID: YpwrpbAFQRWzeqOrya6ItQ==
X-CSE-MsgGUID: hm+fukoJRBKfLaMG0Fr85Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38764826"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="38764826"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 07:51:01 -0700
X-CSE-ConnectionGUID: BfU92FwXQDadZy7VfkFl7g==
X-CSE-MsgGUID: lMsi4N8JSta/I52zS6Ersw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="56914851"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 07:51:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 07:51:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 07:51:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 07:51:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBnodTNUsWhIu6GFv/Hf3dHLq47fxOJNRkuwSys0bW414TCNMqUmLUP8kxOxM4eiSOkIrOdTgsdp0yJF1qp7B9l42GsXVo9Ciq8aMFGEF3kp1ekekZLRMULHkVatWPjcYR8GpS6ZsRELBPA0wpB//t5xESX5ekrVN8sWt6ENC67ImVc8m+eWuw5Ek+EbzM5ArKfv18UPGRsB0lUOTOrwdCMB0riSo5OzcBC9XALiloVNs5CrFQbaC6DxetsAMiJ8bdfxUXxWjEDbhX5C4Zn2uvoKxGpgbzq1BicezIiBvc6t1Q86GTjOcCqgURZHpWNxX6GOHCm+uTqh2aQqn2+lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i/p0cxaN6azj8vKJArU9cJ7o2rkeovCawrC7zMDUgI=;
 b=LOMigfHAX4C0hA+4+ypJUit+A5kkwdeIuWsj8qObVpsHuYKIfBEh30BxoecNGzyoHqqvBmGVaL1yVxZnwrw6K8BC2Vtl7+HoK6nCz3ayc+RTie0o1BHwUcEkt1TGAwHHahG7csNhjedVC2KeLA4JIQ2O54yDZ/OEE02kv0jC6XoT7s68TsAfIu7yFo55he95QMaLVC8xUKSlcqE+IXWID/wGced2ke6gElepOf8RFDPAzQrqCy+f70p0S7QuFMWHCJleabm1VO/UwKW3ucqpk68jxiWajGborWogDwMZsLQVQ3YMSPswoM6Pr+xbSmg/XMvkkgBVqRjfN7LdpJbhBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 14:50:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 14:50:59 +0000
Date: Thu, 8 Aug 2024 07:50:56 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yanfei Xu <yanfei.xu@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Alison Schofield <alison.schofield@intel.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming4.li@intel.com>
Subject: Re: [PATCH] cxl/pci: Fix DVSEC ranges validation to cover all ranges
Message-ID: <66b4db4ff3730_c144829418@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240807131908.303600-1-yanfei.xu@intel.com>
 <ZrPEoBbeV0BBdn8n@aschofie-mobl2>
 <116108a3-f974-455e-b530-1e55e4f98758@intel.com>
 <20240808100810.00005f5d@Huawei.com>
 <aabdadb7-0281-46e2-8b52-6c87f1d8a49d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aabdadb7-0281-46e2-8b52-6c87f1d8a49d@intel.com>
X-ClientProxiedBy: MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eceba8f-13a4-4045-cb98-08dcb7b983df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sdzoGRJWemjurADup3dBIpjCKchJNK1P8boHbP5MLISQCJki3QvUA3JIu6aW?=
 =?us-ascii?Q?CAZ59YsqUtcV9KPRYBTKcpMNkCfWa6KNykETYN5jV+LJ3zoyUClybdOIwzLi?=
 =?us-ascii?Q?iWMJgFKbOQzLA12eBBjv1Vg1F8pkUXdq32X5RdYleWKdcykeQegK2VJVDOW7?=
 =?us-ascii?Q?tLGcahZ5NFPZSQxMH2C22PrphRE2tH15eO0aiE/ttIfJLlKLml8hKBvsn0Dl?=
 =?us-ascii?Q?MUHgevrCI0YMHEbNvm3GXgOGirLZ8StWARZxgtZm/caOHiNgiuggGVZfvhUW?=
 =?us-ascii?Q?rJ8iV1E0TBM9KDbWv6GwsNwiGGBhudrryrMmgCK5cShVSQ85iNqNaPRjFeDn?=
 =?us-ascii?Q?QQXkGyB2II408vCLD2Hy7JmYJmsB+1IjeEwF7UOj4TeE1oD5hA1TugBW3hRl?=
 =?us-ascii?Q?zD3WQujEFVfw617tbG/0oP2UnR2Rd7dZHolatqrhkL8Ogp//Qx1FiXHwke2d?=
 =?us-ascii?Q?bS+JYRO3Cav+CzOPaaIRGo6wytKeBif63Mnp1BIvw8/S4mStQXU5I0mYwi4l?=
 =?us-ascii?Q?JpC0TQtfsX6+mAho+GenX7hYG8HJJMN+sBM2QJziaGlZmj5mGJg+g+seC/6q?=
 =?us-ascii?Q?24EsGXzBKFQBOXV2X7UaKByicQdawO4o7rQ3uGuJyug6dlEzed9+eeLXxbQj?=
 =?us-ascii?Q?9PuuJbT0d43aJyU5lVH7bnIxSxGoAOqtVzQv6i7Ao05vibUyZAhZAJ3CMIOW?=
 =?us-ascii?Q?yXkT20f7r4yIa1NGyCoOjmlkE4GBjIDmiJwVVDZot5gi9lAYk8TrfF119Pii?=
 =?us-ascii?Q?nHNV6ei/PMRT6gexYOBdfIJf1xiuQ4RQblBVEkd5ENaoo2TCXm3L1m2y86Gq?=
 =?us-ascii?Q?ODWSV8/sTNnaCqHhpGWpS6NOCrDeSn57ewQq6DzHs/5k+vht0Dbeo8DduykH?=
 =?us-ascii?Q?0nl4/ZCkCk5LDakZJh/kdTkENEkoJ+hQ7zeCBwCfSx+UjMVsBSlZ3YD6koP+?=
 =?us-ascii?Q?tg8No+BUpXB1MKZ4IOf7z9TA5CGipCgHGqVYnw6bWKKKAxNX85m+ZPe9Q7v5?=
 =?us-ascii?Q?mTkKFTmjur1IpDyZo9LUteQFOU7hF0tJgyJhgu0sgDP7TzHPIfnZYFMzUfpH?=
 =?us-ascii?Q?C1JP3zPG1utvxCUiIivpO+dfWtU0XWWyIcHjMtnJJBHPJoPomxbyNVbhsGzv?=
 =?us-ascii?Q?ONkzMjYCyVNY8++yCZbXKy/yE+5Z1OVlNzv/9xJpp0NFfNDM8Gyk2MRDow3S?=
 =?us-ascii?Q?dtSqMeh0iwx71o7u/ilP1abEnGmjTX8NHvFXKeR11Zx+nLQlx9sK/Ck/+b+o?=
 =?us-ascii?Q?+ajx8PCdqxCuxpGbouna9S1smj3Xj8wLtMoV7KdZCPVsbJ1teqCTtEZ25lDu?=
 =?us-ascii?Q?37fgKkLy34+EOYjZXasCIL15L7LbNyvl0wGFVkU7oe1ONw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGrNv7qPz3zkvMbi/9Pmg1cfexN3ZI674x26Lv2OfJezxDEn74zkaQKdktqW?=
 =?us-ascii?Q?jDQ0BRixDltXxm62IKdNWPbI6K1jZU0zaHAEW2v3GqtKwvxQSPtqH29VSNci?=
 =?us-ascii?Q?QkgbnHITVaMPVQ3d4j5RVhlCwW7k2KB2WilGnKyzJByJp39xdM2SEKK76GWY?=
 =?us-ascii?Q?lZ3T9KwumF7eJowbz4NDivdG8o5czlcYss4wA44xp7d3QB8qRC2bWwwV/zzw?=
 =?us-ascii?Q?88XanJ+cISqKAgg4l2bXU1DpeAy9QkEYqk+NAmVrIwOf/hy2OVKIhoneUPUZ?=
 =?us-ascii?Q?vT837+Ib5FjYz5CYJRknVqOAvCij9wCf71GzVzgi4q/zwje/yDIE/eurLckP?=
 =?us-ascii?Q?X1u3kt1f7W+ZqJ4e/WgXbalgt4FASjf30A5Ax20NiRkbpN9uE0mxY3EL61+O?=
 =?us-ascii?Q?N2fou3Syd67kz8vLoSrY9v4zwrbfsKLtM2ndxIhO5dsiotzCltWycrOBUMhK?=
 =?us-ascii?Q?4VlwbGnFwJh0UREoCC6TJQMeaiau84WMj97ONTRmN0kmL1h4MCPONIluycLb?=
 =?us-ascii?Q?W0mttaIkKgX+ayQxxp4s1l4PGfiO0FHM/c3TdMVAoAaCm0kWI9yGt8G0Iyyk?=
 =?us-ascii?Q?ijZDh2w4k5XxHWQ+Y0zLJvON6lhkAqJNvxS9w2R1yae03g/15ZXNzVSRYezD?=
 =?us-ascii?Q?IGDNj8OToGt3T1TquUJGI6jdLXgjaPG4PTj3HBL6zCO1P6fVreOW8znN9RcO?=
 =?us-ascii?Q?OlrZKOn8MTYELk/2//faKGROIPfMvfk9ZMmuM4gh/YulqN43UzE1tL10cSVG?=
 =?us-ascii?Q?e13JUTiTemS22YsGyfDKCcflUidig8c+BF0Mmvg19cXR79ByMBmsCbxdx8VA?=
 =?us-ascii?Q?Oy9dm4bhRbq80sMw+4c2FwgEnYF0ZwW5l8mmoIne9vlwJNkfBIIk9LQAyT6w?=
 =?us-ascii?Q?6XBTAnFtF+sn+0OQp7OeKWWpY/qOlZyDGlic0XN/3+vb3c/PyxfqBd3O0z+S?=
 =?us-ascii?Q?oDgvxlll0Blg8J5tv4OAUrwLy11hZfjf+stYO3bIDj0mk101F2vyrKBQeQrd?=
 =?us-ascii?Q?fGpfWEKBCjKZyB29v1WhVNh4nWkaJJgu4x7dFmra8uXCBez6DhC9LgB6ECMe?=
 =?us-ascii?Q?r6ilUaEmUdRcO84o8PtlsNVP4l6TccdPhTixt6xPrIFmBZEKsCet2qskirH0?=
 =?us-ascii?Q?pYyJOEx9L+vLGqdr72JeVU3iI6YWuJsXB5s41XV3MOmkLyNCNExKgaoT9AXi?=
 =?us-ascii?Q?yL2Qj/1UMglnvfvqzR6HEWNepNZ/lPz02x9sAUEyb2UciwZHrkWD0io8sFtm?=
 =?us-ascii?Q?Q5brC9RYpN2nj2S9Ogu243cNvt1GaTPAoBZen2glHd/Gb7PgC4VAUel9td/S?=
 =?us-ascii?Q?WbCbceYyDliWwnJxWtJBcMelTxNku5tGjCztwRzhEY9TV7PBNS+WAJ9SYOOl?=
 =?us-ascii?Q?FuOLLFDeIsb/DOD/6xZTqhlAvax3f1EwmjXHBTadtJgGEGeo/1N35L/pwUDB?=
 =?us-ascii?Q?elO2Rnztn8Xr09C9LQJgnQ5MXnX/6RY0QZwQayqZMn9TWOGIyatovwcaYytq?=
 =?us-ascii?Q?o4VNp9R4lyMuhU0oj6fopmABFyQA6zYyYvIayxxgi7FpcS1AtUQCdUWU0I1l?=
 =?us-ascii?Q?ObcI7lVubgxlm0P+TyxE0whxw6N6Xqn2vBBWOh6py9YJjypSsZKoZlPNHIWj?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eceba8f-13a4-4045-cb98-08dcb7b983df
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:50:59.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpsfW8xuXGeNagaBjFVEP1+A6HLDgr9O/hmrDlubBHw0KTQg5fXF8vKDe4tamQUNzekjf22dNutV5ZV9Hvt9xce2J9JmPF7C/MuE9HZctw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com

Yanfei Xu wrote:
[..]
> > That way we can use the bitmap iterators (even though it'll be very short).
> > Alternatively carry a info->range_offset through all this code
> > and iterate from that not 0.  That only works because there are only 2
> > range registers though so is non intuitive. I'd prefer the bitmap.
> 
> Hi Jonathan,
> 
> Yeah, bitmap can work. But how about only recording the non-zero ranges 
> into info->dvsec_range[]? I think it's no need to match the index of 
> DVSEC range with the info->dvsec_range[], as the "struct 
> cxl_endpoint_dvsec_info info" is temporary variable during probe. If we 
> only record the non-zero range(even allowed range), the meaning of 
> info->ranges and info->dvsec_range[] can match.
> 
> The patch is like:
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a663e7566c48..afef524e8581 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -390,10 +390,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> 
>                  size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
>                  if (!size) {
> -                       info->dvsec_range[i] = (struct range) {
> -                               .start = 0,
> -                               .end = CXL_RESOURCE_NONE,
> -                       };
>                          continue;
>                  }
> 
> @@ -411,7 +407,7 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> 
>                  base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
> 
> -               info->dvsec_range[i] = (struct range) {
> +               info->dvsec_range[ranges] = (struct range) {
>                          .start = base,
>                          .end = base + size - 1
>                  };

Yes, this is the minimal fix, because the range indices do not matter.
The code never considers the range index after this point.

I would go ahead and make that second hunk:

@@ -411,12 +406,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
                base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
-               info->dvsec_range[i] = (struct range) {
+               info->dvsec_range[ranges++] = (struct range) {
                        .start = base,
                        .end = base + size - 1
                };
-
-               ranges++;
        }
 
        info->ranges = ranges;
