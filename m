Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CB38425A
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351038; cv=fail; b=WihtCSQUbbP5Oej6GTFUQ81y2T40eahsyL5GzXric8ZhTnnfIzgh2ASudp1bED0H4iSVUXrCq9kWeOLTVn2mp8v3KZdlGKL0FxBZFhHsf2z4oGIBX7ndOYDIWKpguFNL1yMKnynSD/4bBKQeifvDcq+JMpQ8/UxznldhI3CCQtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351038; c=relaxed/simple;
	bh=sz6XdmWZwdXw2QvEVlzDrifXtr/2KqcfgxX9NOKFAb8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDrn5HbLVmchjWPdAMPfK5AUmSN0rbO9C9JeMFbCicg9A4j8/hnWRi5RNqbtHAAkSyeqLWDnHdAerOxGsioxS2aoZ4xTE5HeOAs7ltnIwZMbUZ5xuUukZ7BO4tkieaw9l+9I438Edeh7wwzb2N4G3Lg7Xqskc+KKUBsS0HwJYCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJouPQ9G; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJouPQ9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351036; x=1818887036;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sz6XdmWZwdXw2QvEVlzDrifXtr/2KqcfgxX9NOKFAb8=;
  b=mJouPQ9GSV6LXLRYzJjfQlPWR37oTQH6XbjO6ozwb429Daq2CsZYLz89
   oo4f/caJOOVtaSodmwxv7qh16dhF39PZQ7UM8hs/25AY6Y2ZXrPsVIHwx
   tnB0E4Mp+ED/sWADoNCvvCysYcy7yrqAPCF9G6nmnIbS7udnli1XCAeXB
   LDWv6pvUCCDC/5Je3WxBxTwWwTW5/rTP5VB/mI6+EgvZr50xUPgH+KylH
   2R4DrNgpT5oBlVI8V8/gpxIfXRT8r8IiJkKgaFi6kO6ORDb/qdckFTx0y
   2ZhV/pPOuuNnOV3L9LbCO/pKFv2w2t9efvQLHKdekHSkg7inBJT789aK5
   Q==;
X-CSE-ConnectionGUID: PVub6SzrTsGCdXgaTwt/sQ==
X-CSE-MsgGUID: DcRTQcwCQRypf5JklaKqWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="87022870"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="87022870"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:23:55 -0700
X-CSE-ConnectionGUID: EXhQMGHKQBCaCIChD+m4OA==
X-CSE-MsgGUID: czcVnxGuSGu8HB5cNrdDMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="269942421"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:23:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 15:23:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 15:23:53 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 15:23:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOiRPpgbZEPMg0CfZsmdj0ubB/2vEl2R5oQJ9bj8s2K8+pnuEDuCUolzVgdqEcWjWNJT/Xjo1nq4m6ZrnUmSOuvXI2JtwI9mqBiZJJYY8Kr6OTYGARdY/8qbV5E3dayEtxKsnrKSwoqiWOzkjREi2CcGRi8bT+WloUWnCOm6iASop3jkGjdyo1v7VctYE37g4tbgYBV/3lV29ZOnYCGs/mIVACurEmRXUpt8APyXToqsGR6JWUuPypc86C30WYfNpunzppEaXsapEQ99aYzyOq76FwlTYN1wkYF/WS5vEh3/3lAxcTgquzheb8pCFSXygalymeag7rFnPa0ypl0WRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JTJwVtDgvxBvYLvTPchtVXXBSIuoWiINcqAOtE9j/I=;
 b=GmW6JKUKenciG1+O+KnL5x2igR2UdWZnunGYgClfPjBqCn337PQVIBHQ903ih3A1hk8mLQAH9uPrTqJlKZTA4Jt6CxNVFdFGw6QyHeEKFQB0OxKH8xkmNkvS/csQ4dzfbKvugIQ/FouVZ1ro1/JtWgD/UoUR6x0EkTPALDNAOY1bkaZrQY9gVTvnc+UrlIFkaaThhmca/e7PIutdT8qM8i0QdJ8LZFDVgHK7lC4G+a9q1ZA+QIVkE6De4XMY1Ywfeah8ExzY7vWUfGuw5w/EkLY8rBIDQNVTQV15TKUmNc0wuCJhKyepMQ8heAypxpBO8sn1DAfS873PSR+n46EV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PR11MB397228.namprd11.prod.outlook.com (2603:10b6:8:50d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 22:23:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 22:23:52 +0000
Date: Fri, 21 Aug 2026 15:23:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] cxl/region: Support mixed-granularity auto regions
Message-ID: <aojP9fdv4HQE2g6J@aschofie-mobl2.lan>
References: <cover.1787255388.git.alison.schofield@intel.com>
 <465a9a3e68144a41af45ca1cdfa642e7af553c4e.1787255388.git.alison.schofield@intel.com>
 <20260820234320.18C561F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820234320.18C561F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PR11MB397228:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c00f34-c1d6-4d4b-b283-08deffd2e139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: kBmnav+jCppt9Tk1kw+E4su27RPSLfwqlNOnVttda6+Jrq9lKsaI23wzeu7b1/7RyqoeCVK+hJRbXIqcRSOKKs3tcrEO/t/3fDviKSbU8JSDd8/34PAfe7JwS73D0Fw3u9QkaFOmPeuLBcWzF6+t2KhM0TvDt3T0FCIkJuPUAszkD2D69oxE6WQql+mT3GvK7ynfq9GbRcqiESX9glBWobdiWVRoaqejJCLMigZ39utK8fAm5qTfu7685BtksVik4eTZaPmgqgaHccHrtKFspGe8u/xqwBQhU0Prl4xeDicUcCJxlS4IPxiFmuva4KS2ZBaxlntRQ+23+BvZosM+JxdnohqpHl6ifC5WvKtlW8B9fUMROQ4Jr+ylYqzixsl4sphBLU3rDc/Hk51/HAuU7+rIQcRcppgewPmGay+QrkC86cue2VjdERJpb4MoBdM480klgNqFXtW8ie4Rzvw1lLrumUGWyicPi7vUSccamyIP23z4E7UEFb58AAqceC8oTw521wQfg3BKOkLxsNSuiIFwQdDVITb2v5zNBTeFyxqf3jWOy5/sTytxdPS1vic4AW6qBN5lVsO21ScLjwwIQ0C2+JSA0LjmfZyqMdxKQNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2M2OcCsZ226viA4tZ9cg/T9R7pdFSOtOOWjPoFYJF3GBEOMKmjTFKQOwRw?=
 =?iso-8859-1?Q?eRJ8LplC0qcb8FhV1afsfrA7IoNFzCPtFl2UAR/sj/lGw1PrIn1oLRoFE4?=
 =?iso-8859-1?Q?zeA0X4YaueeMC986Kec0rpYM1gEvqAcIEbqT3IumWkt12BXJdy6zIS1z9D?=
 =?iso-8859-1?Q?6CvlYQ8CPb/ifwjyNq0eF+S/Syr5am+qlwteylCo+d4tc2CBOE3vfCBE8v?=
 =?iso-8859-1?Q?YXcKBgJZ7Req5ISowFHjY86uOJPgAQ8p7NrLg3QNWNDhC0av0KTX4OUzxO?=
 =?iso-8859-1?Q?h920ORYYH46ovwIp9iPzPjZtN96Fb8/z0ZtiNiIHO0TPwqsFWFxQC7d0fa?=
 =?iso-8859-1?Q?YhjRhbUfBD4lxFOze3HLmfsA5Mj6N4qXENbp4PVwK99RhZX+Mxpe1VaSZo?=
 =?iso-8859-1?Q?oc8j18Em8hvlH4DSTzZGM9LGUFi1pmP68aifyXkuoTz5tAl1H4nMeYahXL?=
 =?iso-8859-1?Q?3sNQJo1wws7d/YOcawYjTbUJakSYMB78FLC95upmIKGWwR8e/6uwaOEq2q?=
 =?iso-8859-1?Q?eCIlvdDCCMMVMA2KNJt7c4FSgPxY7eMwg2xjYz4eyMIksQZzHuq+G9jA03?=
 =?iso-8859-1?Q?zI4a4mb4qUNGMLoE0zKt49+xOVKYmGD57kCbTBS9suyVu/BVpJJ+nSnzFC?=
 =?iso-8859-1?Q?XS5SjzB8Gg/nSWpXQT59BxS3hw/Fk3MTubpO1P4y1+M2BzudJt/m2ng1tA?=
 =?iso-8859-1?Q?3F+Ka5xMFS10Ieb+Jrq8B85WnPUFzklWCkoYLTSsTx1OlbA2ywBK+ogxZI?=
 =?iso-8859-1?Q?Kftm7mrD5qCzN6D2iFUT/5MUvriVprNCdf1COpQ+W3Cw6rIhmhNevBQIFS?=
 =?iso-8859-1?Q?G3arqwoxQexSMOy2zrApg+Fsu4KcMjNp6s+IMX6rgTa0zRFHT/nOJhVXsZ?=
 =?iso-8859-1?Q?USPSZc9/udzdQ/FA3/qDSl8J8kmpAuLOcu1d+LNslH+Q4G+QQaI9D48lqh?=
 =?iso-8859-1?Q?cBORLmCn4ROFTd+078Ow8pzbUS+z0ACOk5UsXXdt5mclv4Mgp0pVGWyT4d?=
 =?iso-8859-1?Q?CgcGX9EoGTNcNtgGUFHjIuXowmN2fgI7i60kqXk/kkoU2UG/nrElY8Pl92?=
 =?iso-8859-1?Q?JFKtyTZILhhI0UA82jLuYlyy6czgUlL8FNqpp7bpzeAEKyxKLJPxWZ2ofi?=
 =?iso-8859-1?Q?bENboSaxXGHdvAg5AZFw6BhJoa3Aw1FT/IB4lURpT8FFYbXwbguod6p8Q5?=
 =?iso-8859-1?Q?+jTMCxF8856nVQ7RKaCNg2AkRRLbEZwg/ub8GBeyEMrvwwFP2UDHrl8b82?=
 =?iso-8859-1?Q?VqA8OUh1PYOdk8B92VCddmYu4h4Uq36qkgn2tXEMcYmYpmMpM9ngtQy6Xe?=
 =?iso-8859-1?Q?ITozSoMxyJQAVGbzgaaE8OGGxekYDWATxgVk2ryHtZzFIzZ/wUAv4WRRv8?=
 =?iso-8859-1?Q?3I4vwQwLGySoU9Vqv9j74o1ERppBK6qjly8uSzL/IhXBT89yAkNlfP/MsW?=
 =?iso-8859-1?Q?Tv086qzOX+Lc8BqVe145G5MSzQfS+G59AqsJW2rsi+zdQdCWsxNQiDrdin?=
 =?iso-8859-1?Q?Gv+Jo8tq5W+oJjlGY+XO7r6bKRylKw8rhfEBjIpe2fyjsD32oONSoouO4R?=
 =?iso-8859-1?Q?w7Tmdefrc+QbXNg6DOqrieOSr2MnIJOnli45v4cimLbBkhY0M37OOWyAS7?=
 =?iso-8859-1?Q?OsCKqretO6vUiMqS8kd/XCdqd2nDJ4/viTTTzc2HMnDOguS980rrCduQ4n?=
 =?iso-8859-1?Q?klqCreyj8+kSrJYz2ULqslTS83KvuDeKfZN3Gfj3dzOXg5EgNG3kOnxuNu?=
 =?iso-8859-1?Q?K9L0uwwkSnvLNSwdmi6CcKi1M6P95G7rZEqcD7DYt6wLa5g9xM/xB3bKVu?=
 =?iso-8859-1?Q?aV+CVtygPMhLGmYZToRHuSNrZ8iaUJ4=3D?=
X-Exchange-RoutingPolicyChecked: gYYuBIteheiYQjH/5KGdS6kAdhLGtdSPRg0LtECPGC6MMWstkrckePBeaZ1B9as7cEQSuvHkshdh0ZRVGIvUcoZT5KiHAUlyOBJzH9dBmFkcBOx/Ic+e7AYTocUQpVDd9sTSRZrDSXFSinsX3tkc0vq+k087zF9j+LQEcq2I63UdASheMDbf+4Pv6kcHjthgs/g8yVInvWxVBTdtq233sJ5cEuTEKgVtdvrkjE+dRhx19B5HZOB2A9/9fqUMOwgObZYZ3vRWKyPO38wkQ6NxxSDzddTH+Evncml2ZwtXD8NkiqIOa5BxP0Lfki+3QRuP8FRtFdfXyEEe8Y7SUpA9Pw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c00f34-c1d6-4d4b-b283-08deffd2e139
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 22:23:52.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApxXnc4n9bOqweBO09dMtuTodpEZ7lOJ+DFaTAXvss7AyqBYzDFDhMm7D/x2lbIciGkSOYpvweaTWNpYWPJXfvO7b2i04T7lRpCrI1FZtOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB397228
X-OriginatorOrg: intel.com

On Thu, Aug 20, 2026 at 11:43:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Incorrect distance calculation for non-mixed-granularity regions with non-power-of-2 root interleaves causes a NULL pointer dereference.
> --

The arithmetic observation is correct. For a modulo-3 root, the formula
does not account for the factor of three in the positional spacing.

However, that case cannot reach check_last_peer(). A same-granularity
region below a modulo-3 root must match the root interleave width, which
places one region position per host bridge. No dport is shared, so
check_last_peer() is not called. The mixed-granularity cases that can
share a dport take the distance = 1 path instead.

Rather than add arithmetic for an unreachable case, I will add a comment
to v5 documenting that invariant.

Separately, the report exposed that a missing peer mapping is
dereferenced without a NULL check. Posting a standalone patch to
guard against that so a future violation fails region creation rather
than causing an oops.

-- Alison



> 
> --- Patch [3]: [PATCH v4 3/6] cxl/region: Support mixed-granularity auto regions ---
> commit 13bc48fe2efef1744b5bbf29c756bd07f400ebe3
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Support mixed-granularity auto regions
> 
> The CXL driver currently assumes the interleaving root has the same
> granularity as the region, with each successive interleaving level
> becoming coarser toward the endpoints. This patch allows the CXL driver
> to assemble an auto region where the root granularity is coarser than
> the region granularity.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 4f367feaf6c84..637d1b60a570b 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> [ ... ]
> > @@ -1463,26 +1472,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	}
> >  
> >  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > +	iw = cxl_rr->nr_targets;
> > +
> >  	if (cxl_rr->nr_targets_set) {
> > -		int i, distance = 1;
> > -		struct cxl_region_ref *cxl_rr_iter;
> > +		int i, distance;
> >  
> >  		/*
> > -		 * The "distance" between peer downstream ports represents which
> > -		 * endpoint positions in the region interleave a given port can
> > -		 * host.
> > -		 *
> > -		 * For example, at the root of a hierarchy the distance is
> > -		 * always 1 as every index targets a different host-bridge. At
> > -		 * each subsequent switch level those ports map every Nth region
> > -		 * position where N is the width of the switch == distance.
> > +		 * @distance is the spacing between region positions sharing
> > +		 * this dport. Mixed-granularity regions place those positions
> > +		 * contiguously.
> >  		 */
> > -		do {
> > -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> > -			distance *= cxl_rr_iter->nr_targets;
> > -			iter = to_cxl_port(iter->dev.parent);
> > -		} while (!is_cxl_root(iter));
> > -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> > +		if (cxl_region_is_mixed_gran(cxlr))
> > +			distance = 1;
> > +		else
> > +			distance = cxld->interleave_granularity * iw /
> > +				   p->interleave_granularity;
> 
> [Severity: High]
> Does this mathematical distance calculation correctly handle non-power-of-2
> root interleaves?
> 
> When configuring a CXL region with a non-power-of-2 root interleave (like
> 3-way or 6-way) and multiple endpoints sharing a downstream port, this
> formula seems to calculate a distance 3 times smaller than the true
> topological stride. This appears to happen because parent_iw is divided
> by 3 for address routing, which scales down cxld->interleave_granularity.
> 
> If the distance is undersized, check_last_peer() will check an endpoint on
> a completely different host bridge:
> 
> drivers/cxl/core/region.c:check_last_peer() {
>         ...
>         cxled_peer = p->targets[pos - distance];
>         cxlmd_peer = cxled_to_memdev(cxled_peer);
>         ep_peer = cxl_ep_load(port, cxlmd_peer);
>         if (ep->dport != ep_peer->dport) {
>         ...
> }
> 
> Since cxl_ep_load() returns NULL when selecting a peer on a different host
> bridge, will ep_peer->dport trigger a NULL pointer dereference here?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1787255388.git.alison.schofield@intel.com?part=3
