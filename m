Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0B253951
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757454226; cv=fail; b=XiWxboC4ODCza0esxzHz42o6Onm2rP5V8RoPqPRhrRyJHiFI5+dddfsi+AG5qH+sg8fp8d/w7v2M4zY8Er0CLQFNRlsgUw8Ot8cWAjmyPkEHHgZxTlZ2W+hFzCVZpjHzgpPgFgD6exXc6RqcXklQZT2hEtEZDUAQTMfTrGDW7fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757454226; c=relaxed/simple;
	bh=UpfCJfqUpHVQeb8yeISHpGTbBvt8SPK4pMmjO4+Pz9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mIFeIqVGDfF9kEflXP4TN3pNbsS8+KP3fSBBD/N14ip6vX615zECRsXbFE5ZeGUK8XdBHeMSHLeP46PuQBlCFouvSbXMuultbLA3TVJD/WskUuj8wzdmixcXdq5JWxhrFrvYTP3fr+iMkQiZQ1dGWJMUWD2wemu0di4u2IbkcuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JaYDwq+u; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JaYDwq+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757454224; x=1788990224;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UpfCJfqUpHVQeb8yeISHpGTbBvt8SPK4pMmjO4+Pz9g=;
  b=JaYDwq+ukOXdwHI9yZ0leoSbiqqPr2hpJNQ+tUrpx8eDeJetzTHwX0Ui
   oYFbl4Fnu3M/snBLieFKFzCDpgOGtWIosZQT2Rve5Kfr5lI2oHz0Zfo2Y
   auxiBmIHBFCzi0TB0M6ogOQFkBKEnjZPo7RfGcRORN7MAHoi67Y+qFAz3
   nFZJTAKS2ECPEaOiChxSVfGCbz8Sa9w+s0rJq8/EP74WvZLGBbx3UvEOh
   Gaa2kysQ/Ia4UngDBqT/g8gXY7exkQd1dKOJcUrxxN0drHoyY3A4KlL0t
   uTnRxBEmJtBk2ncaarpmLy40+rg1r3YdMFxQyN5iO6DXW3WymPRLIba4k
   w==;
X-CSE-ConnectionGUID: diNy2VcUSVKmdYjNL356eQ==
X-CSE-MsgGUID: LeXxG16KQ9Oad2PM0qPNlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="47326451"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="47326451"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 14:43:44 -0700
X-CSE-ConnectionGUID: 0Tf3X8lBTK+6e/+/10eCBg==
X-CSE-MsgGUID: aOfmPhKCRtS3NIbVT9wiSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="172486401"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 14:43:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 14:43:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 14:43:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.55)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 14:43:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBCE85TaTk7U7p00Sw2CktDnS9nTb5OBQpX5gQe8JtGooixFOUW6MeNTomKyEXCpn+AjsHjbnd/x2hah9YJYfxJDRZ0h+wswyN2ngh+dESs90ZPm9kFIMZ+xGmLX53mIJckUi5aTE5Wj2ZcjCui6XEDJVKfMlOGUrMkrqWgjt24fUAGJsx9GTMN/ReSW/jOwWf4XBFoDOR8yjwvErcVy8kO5WtNWXqFqBfntuH5AaZb+95zyReD4q3p5pUGQn3rbwrpehF3IetmQ0QACZWZxbXGNqhdyv6CuvtDVa62ML2BeMqT80wIJHgW1neSV2h4qxYxwikaJlMAAK+m8q354wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwiFshl7Uxh7TWaAOq9g3CQjGTg8R7wKo5ww58a46hU=;
 b=HsM+f6ve0LXd4N+19isj67wR6oErgn6XkeqyQVGPCp6YokXBCmYVsPxsuWMfVwHBm2YEyZiwYZx++5V6/KXe1NnMs5W7+YtOovnwZSkn4QcmCghxXovdbwD0z3UKMWccjVx8Le650DCtUcNH9sddqVQ+XKQrKsgltXhsxVti7/yoIVqrltUE4h85/CuUs5aGJgVIF0p86JcjmZnZAR7oaPzXTBgLzaKPTF7LqhPzJ6+XeXZMggsOiR313a0UQ25ApUj36RqwvDUyd1rczhVlWNQ++QWcNsXcP22IpopZ2FSDXcgq0jdI/sO0wKBomSLvemvnEd5dKl3jhCCYnCZkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 21:43:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 21:43:34 +0000
Date: Tue, 9 Sep 2025 14:43:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/acpi: Limit XOR map application based on host
 bridge ways
Message-ID: <aMCffjilTbkXT9P5@aschofie-mobl2.lan>
References: <20250813032918.2899852-1-alison.schofield@intel.com>
 <d18a9fa9-ccd6-4fe8-83d1-e9838b15c5dd@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d18a9fa9-ccd6-4fe8-83d1-e9838b15c5dd@intel.com>
X-ClientProxiedBy: BYAPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:a03:54::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: de7433b3-299e-4534-14c2-08ddefe9ecfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?juP6c0R+3nCZeTEs2n08EYAihNByTsUWOBmLoibgxRifv8td2E9CdOZKbAYG?=
 =?us-ascii?Q?3Hobf9hiBsUrN+0tjwZB7HAg5pFoXyfr1tKE8FAnnaMRcKNRwqdw/ZrZk3gi?=
 =?us-ascii?Q?UVztQJG3o+WBcOmx4OxZGHUH88Ajzqi90+sDig48wggBeg+TyArwaJIiyySE?=
 =?us-ascii?Q?VGltW/cP5pOoxDTeordcEPFcM6705zc+VRDwYUSKWUopvdTd7i9urG6u7ETw?=
 =?us-ascii?Q?x20a8v58QkOZk4Hw9o/vOlnoVf/Sdr3prVNq3A6cxrEGxA04nDazlafT1io/?=
 =?us-ascii?Q?LAjRr1iwiTZeiIfAPo9iL8xYe6G4DLUWhawEypRE0q426xYAFCA3IN8WPPS3?=
 =?us-ascii?Q?rXZdylkmNRMD+xAxI141Bw7puHyC6SkHlVNtotLjK1ZJhJlCBu2kDHVK1s8A?=
 =?us-ascii?Q?0+TQjXLp5wqZ3U6faP9/1MhzySEdPmznDf8QyTng89ZdtCm9FZD1+qxIp0ki?=
 =?us-ascii?Q?/Aul285mYns77ofbNDgBIT4L0I6yELCjDkBtTOcSzccRMaCOI3HaO0Pf7IyW?=
 =?us-ascii?Q?TpmO1LKkhWFH6R6RXeSxTJfC93xMQ9u6M2JNozoKPi+HbeaEzAmSq4T+HdEm?=
 =?us-ascii?Q?dt132a4MA3KlhYX13pFMlfs95DdACmAhY1+zZfaJD7iaQyuvlSRy2uY5hRLz?=
 =?us-ascii?Q?U+TJASBjwfabWsojDApC2FxGDv97djZb9zQveI1eF6LiVwawKFjfNIeLn+/Y?=
 =?us-ascii?Q?DzDjUv889FfqLXYoIncLTNPooMPIpQSMzvlWdJL9yD+YwTSqIYvk3HoWrR1J?=
 =?us-ascii?Q?+pcsjcNg4XGfB336tO620dahm1zXdn2gRbx8DCuoURE3bP4/lce4cahb+4Ye?=
 =?us-ascii?Q?Lynh3m/UR68EaHwApcTDYA+iyaOCs7m+LpZt7Uje99Wvh9MaUmr9tfhfX+Fn?=
 =?us-ascii?Q?/ntmEv+RM7+6kQ3HhqMqCptD4e9o2ppzMEA0tnuJX1qgqPgC7r0/cfVCEds2?=
 =?us-ascii?Q?EczwVV+dvjYDS61unHjyFttm0QLPAJOYOdnTcwOYdsWfGYcLMUDbZqGqO0p7?=
 =?us-ascii?Q?isFkXmz+3yqSbASqtHJy55+UyVST9ftvqvagJ4rwfWTQG+SYdlA7ept32+Em?=
 =?us-ascii?Q?kGAlfTYuX3QOrI1HBzCG3UL0Voiqt8d51g/N9JuKOVCVxYl3xNZG7lffN5n8?=
 =?us-ascii?Q?CIND5jKlNKQoXyWE/Es24p7NJmTqKYYOszzUWDkxrNlMyOFPvohMSqPFzc/t?=
 =?us-ascii?Q?RZ4eQMfr4Iv/XxPuopYnyFBSeImq2bdQJxjOQ4ZNJ/xMo/epJa3ZMxSg9O3Q?=
 =?us-ascii?Q?yVY4axhDjOm07Mz8KjKVVHne7t/h45PDXV/+OWoNpk+T+X4yll0nt5t/0mKm?=
 =?us-ascii?Q?u2Vhv+tqVwPEXQTgegQ2G8PJLtrQk2K6ROF6hVf9aLpngljkvETN8gyzdTpM?=
 =?us-ascii?Q?Cz0KDaxPwMSxQxvRGHVSxcyv2lz/nYli2FQzEJM1KTdvKKHbtSqL2zj8fq7p?=
 =?us-ascii?Q?yUpkbwFVfz8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dCWRTFgN1s6tNDblUc/aFBL1GKmHy+1htZtGbM5pfTxJWq3wJrg8INtSNHqE?=
 =?us-ascii?Q?AlnICMXrzPs1YqCH3RcipZzpuLTSoT3wtBGswmwyRwkUrQR7Ynv88o+PYEBt?=
 =?us-ascii?Q?kyjEam1EBgz0LHtI5/2DypCM/7ke78UtPt2eo3FbJNVeEAJ1OIvbtIdlvDEA?=
 =?us-ascii?Q?wgXm+sMq+B15qBXc7xvfAFX7kTyu3v/bPwHRQKL7jW74xpSDbRDOVbP/WZLd?=
 =?us-ascii?Q?rOzAF3R+cMfy3ET+1Q/y7Cp86wvUMkiUgE0YbQgBxJ+ZxiBlrJRWmPSSeRiV?=
 =?us-ascii?Q?vWNe8od/nj96RnUeRC6N3tPeCQaJgQeDuhjRDkJHxujIbVvsaWDJaUI4fcGT?=
 =?us-ascii?Q?whIYHwKpGUo7Mwwp1jhFuRzdHLF0NoUvkRR+V7Cnn8fl36LY+ElFMUUvHusE?=
 =?us-ascii?Q?whH8gSr8x54AhKDauzLrB9RxQp2a+ze+NlA0imCskWNfOBXGeXey2frP6Z+x?=
 =?us-ascii?Q?b2zM6iQ0aqy9z5EtfbB+AfkncpAkXeODRVchOJ/QvBv8H2z/wKLBWwfwxQmE?=
 =?us-ascii?Q?IZ9M8pdRgNaKch0EJguQ2S4kz32MN+yfNDxD3Sy5eWMMkbLRrSUlZlIIGk68?=
 =?us-ascii?Q?dZ7WnCJqqC+fiyh3j5LYFFKaqLtBuRz2QFegQR4vjmkumdAjaxn3gpgysrXY?=
 =?us-ascii?Q?wHywvwb3lZ/A07E6JvOcj/BWLBEsa8sZ1auFgZOsqLLVfl00HLrIT8Oj9gWk?=
 =?us-ascii?Q?3AMF/T0hgvvEc7EhAk1Kez9s9vsVoiI7BxfJCmpz4U+Q+9qCBr+AsQi3PPZF?=
 =?us-ascii?Q?MbeF8kirECMKXK56kd5yT2BBEZqbBa66vsmuDYDbrYaX05qKLHwxiG3A82tw?=
 =?us-ascii?Q?6isTh7CfB15jKT+T+c07zcMTj4rRg8ml+OGln3HwGv0TjZquIGR1sMmWhbaT?=
 =?us-ascii?Q?sK/3QCmefDbTta7+Eu19648GpTiYcGaOq2SyHP6wy4PcCbDRNSZmrD38FQnA?=
 =?us-ascii?Q?4OpX9wyD1CwbiImP0CmYa4Td9bWVRn0sG9/E6bKDiczkTC/GEsxvlQwA7TEw?=
 =?us-ascii?Q?KsceZW2Tt87ubKe5TplBl0vIXgrqYfXHRYmT+K3p7dJUw/xwbCU7s8OMtQjV?=
 =?us-ascii?Q?Mvs/Tzs39QvfzEvawImETbAKkuRjyRAfntuX6S+ORf6LczupVOhpxqVLh8UR?=
 =?us-ascii?Q?idXYeYYI26dnG0X7r2h/pbk6iT4wjFDJD7a7LMRUHlYxXuxp+6nFiqXGe24l?=
 =?us-ascii?Q?PbBEwGz3UIudBzfA0pa/j7E9epTLy4ZJqqpK2eJRQffamVl1NbCslT9ip/2J?=
 =?us-ascii?Q?3teAWyVWAfpdwQAH8SamzKhiEbHjgx61yhkEX/fxBDBFsnr8mR2xgTz1PeTi?=
 =?us-ascii?Q?ttqJH6VPSZpfTSHraw9/0XXGaTErjB6+oDzwPJgWsCLtI2RucFQSwesGkTU4?=
 =?us-ascii?Q?tfWihCyTYp1U8PkAC+a7/6J4oy1bvLMTNXIwsMAg7F070v7B37lLA6MWfoEG?=
 =?us-ascii?Q?wWa9Es2dMsOmPdruSNsshSQTgdBVYqtLsRAw4slQE6nhLhBnsOSztfqNsprU?=
 =?us-ascii?Q?GY7k+bzqXh7Wl3/tT7fabhD01JAfft7m51CvI3c4U8DJxdVDaAt86+bn1UtZ?=
 =?us-ascii?Q?coqBfQcVekWtacThJ8E8Q+8DY2B8nw8olVIS2OSWoLqK0vniVHZYke2nuUv3?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de7433b3-299e-4534-14c2-08ddefe9ecfb
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 21:43:34.1016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XgEObVTLrcdDhMRste591c84n/+NDm6d0mUHu0uTzQq+QqWLloulMY3JVIml7+ektpjjsul/Q3uaFqptU8ToAb/yIj9kJCdv4MS/DqpCzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com

On Wed, Aug 20, 2025 at 08:44:34AM -0700, Dave Jiang wrote:
> 
> 
> On 8/12/25 8:29 PM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The CXL specification defines one set of XOR maps per Host Bridge
> > Interleave Granularity (HBIG), but the number of maps to apply
> > depends on the Host Bridge Interleave Ways (HBIW) for each region.
> > 
> > Currently, cxl_xor_hpa_to_spa() incorrectly applies all available
> > XOR maps regardless of the region's host bridge interleave ways.
> > This causes incorrect address translations when multiple CXL regions
> > with the same HBIG but different HBIW's coexist.
> > 
> > Example scenario with 3 XOR maps defined for 256-byte granularity:
> > - 4-way interleave region:  should apply 2 maps (was applying 3)
> > - 8-way interleave region:  should apply 3 maps (correct)
> > - 12-way interleave region: should apply 2 maps (was applying 3)
> > 
> > Per CXL 3.2 Section 9.18.1.4 and Table 9-22, fix this by using
> > a lookup table to determine the correct number of XOR maps based
> > on host bridge interleave ways.
> > 
> > Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Applied to cxl/next
> c7ad33d50282168fbfed1c6662503b0d979a67c8

This patch can be dropped as there is nothing to fix.

The story above is true, but I missed the piece that came before. The
CXL driver actually stores a customized list of xormaps per root decoder
(see cxl_parse_cxims()) so there cannot be any extra maps in it's root
decoder platform data (struct cxl_cxims_data).

This came up during testing when I moved out of tree code for address
translation into the cxl-translate test module. In that case there was
only one struct cxl_cxmis_data, not multiples per region interleave (or
per root decoder) and so I was alarmed when all the xormaps were always
applied by the CXL driver. Now I know that is working as designed, and
it is the test module that needs to change.

My apologies for crying wolf!

> 
> > ---
> > 
> > Changes in v2:
> > - Use CXL_DECODER_MAX_INTERLEAVE in hbiw_to_nr_maps[] definition (Dan)
> > - Rebase onto latest cxl/next
> > 
> > 
> >  drivers/cxl/acpi.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index f1625212b08b..26c494704437 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -16,19 +16,31 @@ struct cxl_cxims_data {
> >  	u64 xormaps[] __counted_by(nr_maps);
> >  };
> >  
> > +/*
> > + * There is one CXIMS, therefore one set of XOR maps, that all CXL Windows with
> > + * the same host bridge granularity share. The number of maps to apply at address
> > + * translation is based on the Host Bridge interleave ways of the CXL Window.
> > + * CXL Specification 3.2 Section 9.18.1.4 and Table 9-22.
> > + */
> > +#define HBIW_TO_NR_MAPS_SIZE (CXL_DECODER_MAX_INTERLEAVE + 1)
> > +
> > +static const int hbiw_to_nr_maps[HBIW_TO_NR_MAPS_SIZE] = {
> > +	[1] = 0, [2] = 1, [3] = 0, [4] = 2, [6] = 1, [8] = 3, [12] = 2, [16] = 4
> > +};
> > +
> >  static const guid_t acpi_cxl_qtg_id_guid =
> >  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
> >  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
> >  
> >  static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
> >  {
> > +	int nr_maps_to_apply = hbiw_to_nr_maps[cxlrd->cxlsd.nr_targets];
> >  	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> > -	int hbiw = cxlrd->cxlsd.nr_targets;
> >  	u64 val;
> >  	int pos;
> >  
> >  	/* No xormaps for host bridge interleave ways of 1 or 3 */
> > -	if (hbiw == 1 || hbiw == 3)
> > +	if (!nr_maps_to_apply)
> >  		return addr;
> >  
> >  	/*
> > @@ -50,7 +62,7 @@ static u64 cxl_apply_xor_maps(struct cxl_root_decoder *cxlrd, u64 addr)
> >  	 * bits results in val==0, if odd the XOR result is val==1.
> >  	 */
> >  
> > -	for (int i = 0; i < cximsd->nr_maps; i++) {
> > +	for (int i = 0; i < nr_maps_to_apply; i++) {
> >  		if (!cximsd->xormaps[i])
> >  			continue;
> >  		pos = __ffs(cximsd->xormaps[i]);
> > 
> > base-commit: d9412f08e25a5b66f9021739c090cc9b8f1089b1
> 
