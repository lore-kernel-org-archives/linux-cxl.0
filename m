Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31541503BD8;
	Fri,  4 Sep 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540827; cv=fail; b=RaDqDxxwIaQ21xc3PTN2ppqa0R2jw2UcGy6P4V8NL6Gc0TCMxGH8EJukRDwcl7X+ZVbaZV1mO+Hy6+q6aX2xYOpFbtUNkgsm3hvlUPo+vcJ8jh3xOLQSzAUu4d0bXPZE6rSCtiMbMjDLvHuLjGDu3aTVwU+68264C0c4rolgijA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540827; c=relaxed/simple;
	bh=wdDI8N2JgQ6lE/BsYyc4DYpgwIWvBNNVhvQsu++CsP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyxEJ8rqRgGPXKoLXj4UqRgozVjlpTHxpe+V68O76/kTvYbThEkQ6rIhDxO0xzthRojHwPSS0762Yd3UhlMlWHnKzJfpkJrtGgf9skbQTpDMrU4RdqKGQLy/LiLnXBlLzhsUKAv4YAIbsTxsSjoFSlSMe1+sH7WyI4bg30wDQk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcsfQaw1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcsfQaw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788540825; x=1820076825;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wdDI8N2JgQ6lE/BsYyc4DYpgwIWvBNNVhvQsu++CsP8=;
  b=LcsfQaw1E5nBS/2N2A3OQOorqROv6HivTsWjOxJpxwzbbUi1BDiQQnbD
   29hqeoisO6FjB35THyBTKHuGC9Mc/zvqDws5Uw33CXMnPtfWyH4INBfUu
   wC4keHnPVQcshK+nuOMD1CVfYL/D48teOePDEtVVaOhHc02gkotWutPr/
   pjGAgrKFSWBU1aUy/CEyV2N55L4KxSznQHWMUo89/WbeMyHle9nY76UxU
   HeuRo8QxJwzjEwB9GgoWpNAuM9/Sz793aAh6dlY+OA3afnpDA7n9qwLGv
   upP4OgEdjRaWDhBkyHnRC3ZYyNcxSk7jv9PU4SwrriHeSbQXGAIib51zC
   w==;
X-CSE-ConnectionGUID: vKIW1qDWRIKyVpX7mhaLHg==
X-CSE-MsgGUID: uyvuVNbIT9e/EOPJvY6OnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88926297"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="88926297"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 09:53:44 -0700
X-CSE-ConnectionGUID: Ge0qra/3SMW0eEiFjl2nHA==
X-CSE-MsgGUID: QvMk9Yh0TRG7wb58UHcftA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="265735065"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 09:53:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 09:53:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 09:53:43 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 09:53:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZmPSptEHFvMzBCn7s8D9uhpb42drqNUiZ19BN3v9bKs8WzT5M/F6IOoW0hvTvSiVhN5/YheyfG7fuqf/ZxR7FIJtQOjS/Clbje5jQS2j77s+wjWQzIuJ+7jFxTrs5qCr2Ah8v0yFNKuc4fsrSfgIhkVBh2Z0uPeRVfgI98ynixjpRzH6hQQuWhkyep17cqeTJsQcGxkvGE8mbwUK9i1iteABDdXAnG05jaProapXeQ5Ioj7LFzVOnT6YvKKPHI8FzbDUqO93uKUFOue6tDWchnSOUsSaG/ffAyMYaYZF1LdKVkLQlgW1GYJbWYmyAx8QInAlUKxvokCglVjOfmBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie2YmEbREKUXw5J9rhF/T2FqtWbtEzRtzFxPjc/vCZY=;
 b=ETG0TrlPImTlrsnd5FU02mKGi4hT+o8uaZSXLR9j1+BpB1D9qGFEI40OYDTQS7Gx+CMzJZ2aBJsCS62oAjNcfsZzRdwkQ/wovCcsor5sRPkwA0FI4GPbAtEvbjcys/jdbNtwidWo33WKIVSRtuyVRFy8mGWMoLSsyECZYCeXboP8is4vhI9Rwr4jEfA2Ba0G5pHAdD2Vge/7//zBGoiVB0W7j+hsMq2rj+2b6JkaVDWDwnccg7MS9p5ykowOeyqaw05r2+AcagOj2W5HhDZ4XC4RQl7TKriFWMWOut4FdLFiIwMXbapjqAE1QADruUcfijkT3VhiGQb1FGp51UrLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB6016.namprd11.prod.outlook.com (2603:10b6:8:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:53:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 16:53:40 +0000
Date: Fri, 4 Sep 2026 09:53:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <jic23@kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <kaihengf@nvidia.com>,
	<kobak@nvidia.com>, <vaslot@nvidia.com>, <mochs@nvidia.com>,
	<newtonl@nvidia.com>, <kristinc@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v9 2/3] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <apr3jMIDDqYeZdK5@aschofie-mobl2.lan>
References: <20260805055524.22311-1-icheng@nvidia.com>
 <20260805055524.22311-3-icheng@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805055524.22311-3-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 13eeb1f4-03fa-4a2c-b4b8-08df0aa51270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rHn9QVpQLVYFrEfGwcy3wBumAd8oSL8xMf9ChlpBxrnk6yGNVDkNuld5k1yDhVC+8M8BCjpNwHE7Te1LlUz+jHHj1SoDOs2gH5moCyfAaNqsqrqzFxLwiibRolgnxS/lKCpEFqdK3bEFzm7FJwZhfEcTL6o7uUkUWBIKfSVXfBXEN0QatGRrvP/kAqMn3twfcrKLYq+/Z/BqiYl0w0znX1B1K+maKpqBc+YcOxXhVzTIEJ0O+bdrD2jtO73VsTWTPuMgOgZwmlnUBQ2IBJOW9gts9vrBXA1+eN95o3MB5uuJtQAzJjCaivB/YoL7UXl39eSraSmld1yMVREvvWm2xpm29BDhyZ6CfZ9uKjNRAjJN4wAtJ6EWVaaSBdZ6b4T2+wKE99CmT4I6FO3aErx2urhn0zOCVjhJQqyyiI/JeZDAMciBnKxsCU/TA7cHvFbRnFTMahL4d6TfTKke0vrv3dywfejw3lCKEZUYDWKWRuyjwvPlpSKKgqnhT9mFo/oZkvyFdD9fTzBt1wo6YGJVzFpyQWxuIFQbQ7OBnbF+0f5acev3hi/K11mOib0MYuEmWSp4M0XExiye+3BfZ9o3ymDy10BER/OHyxS5sQqdex2T1aqoBEr/QlIdZFHvulYwoxkW8V8M5dGGRtG2uRbPsClUS14tQtC5GTTT+27RDGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4NQ8l1bCE2zDPZgcW1lTKfze0kXUvKkMixn8fExXde1dEyjLAi80U6RejZ?=
 =?iso-8859-1?Q?Q9ghYwP0v9lzXeu45LbIFCFS0cKda6aviirDDrQA1TUPJMYH1dUqYlrbqc?=
 =?iso-8859-1?Q?fZxN4IQ78PEo7FCPHHgTc5/r3rKg6++imK1qGLABIBuSKk1rhXm3q3mvLA?=
 =?iso-8859-1?Q?nVl13OHaqgqob8++ncf7ZLE6P0W2Htto0suM5DDau11mk4fIUh7lTaq/Wb?=
 =?iso-8859-1?Q?BiWSI8jJW9GzYiKbEplU3K5ZLgNiczXPu7kQydsRC0xezjca3ZLJPGZsW4?=
 =?iso-8859-1?Q?UW9Z1Y8XxiJAh+F4Wz5wExXsxa9I64IQTzvpn52AbGQFnEuK5KfCGFwplc?=
 =?iso-8859-1?Q?zoKh+UwqZdBVwLmuzS3qz9PCGUAw3eaLSAt6RWxMXzPEgPyPggXzU2+KmT?=
 =?iso-8859-1?Q?kPZssShAMe5u1YxwUh2nPqlOx8cOYbNgRfOGCEET5/ayXSP2G57DsBpeY3?=
 =?iso-8859-1?Q?C+e0LLS//u5j71L1rfEdH7GAQKYo3WYFqHU6Uc3L25Zt7UHGT6WirnNjYT?=
 =?iso-8859-1?Q?ooH4ndCKRdqBxYKW4CLvi0ay+ML+n8T0xSQC7KHZtD3O+MazlyRlRsjWKN?=
 =?iso-8859-1?Q?vpre17t5uOp3Cl3vMb7dBiWosAaO/wOCQzb5YjaPoAhXVq/WbEeuMpyLTM?=
 =?iso-8859-1?Q?dMpmKbRL3G79GgYt5n+guY+2fjyXKG5KqZOGaTbX/3sikVY4sCro9w98+m?=
 =?iso-8859-1?Q?B3ny652sppIcash81h7fNJrKtO2RSMDle51KQ0TjChSvlJLde7El0Pf1cH?=
 =?iso-8859-1?Q?eFr3Dd/q9DC/7R1OZjxAM8YsVs1/2edFQBwd7UvwX12gKgjy6UMh7hSqmX?=
 =?iso-8859-1?Q?GvsYS6lBcYuYZTqNhlPDt/DSjJqmNYCPsRH0/oYspO2YiLpGjReypxm7lQ?=
 =?iso-8859-1?Q?8RmV7iXw0amBEHZ1aMORHvKDTrUe9Ct5zPbcWpmznKs6HDmY2DBqF/16se?=
 =?iso-8859-1?Q?TPoFDp03uXyN5IdnsIjscXxZq7u9gUK6/LlXAtWjwxujPmOUbIHBnhPEGQ?=
 =?iso-8859-1?Q?9W8F2Tb8bW4Orn1ac08IvDl7jK5DGdlz7dmV29cHylGIWXjKtmwhoBT2hu?=
 =?iso-8859-1?Q?3OWW3bUvOQXxwZtqrCP6TE/M+K0N1U246s006aoRmfDeI8JpTVH9GoPYz5?=
 =?iso-8859-1?Q?VPiYXCbXwsVVojgvHAEwQeAjJx59Jh5bW1SFRJAziEARfHGSVkhdJ1VQRw?=
 =?iso-8859-1?Q?JJc4VIVQivRohS6XMKjK86GowJTR1HhcAkqtRxXILh+ezLnRMT3oufksVd?=
 =?iso-8859-1?Q?kWEKsHKd9WEQ7MZ2jRuK9VRUWgUST8aDnLO1K63UXe1guz62gnaaqIMYHL?=
 =?iso-8859-1?Q?3AfCiOaSpmUAJoeOEhZHPoow5hbrxXdUJce7Abwm1i4Li1A1GjBNq/zz0D?=
 =?iso-8859-1?Q?bzUZWxwLk+nfcFHwQvnAdvg0Lkd9IEgSgA7tZ27QzdnLhPCDRzGL61dgq2?=
 =?iso-8859-1?Q?+E850PG9Z8W406Ug9CUH4vGuOEdtloVWue+oGUpQZt9y/Pmx3eEd2FM3r6?=
 =?iso-8859-1?Q?EkDIpK74wvLvnm8xraFKyGTyUVUJdt38kxKTGKWuPXbFoEO+CLB2oNaYC8?=
 =?iso-8859-1?Q?rodwEVfSgVDyhsIkQ2LPste+sf3WvHdmAlRODSt7dEZ7KxbD+FfvS6QhMt?=
 =?iso-8859-1?Q?SiXK8mC/tlMrKqbSjHp5gLR8eywrtFQX/YCDg/WEdBahoEZPE0k85+PZGh?=
 =?iso-8859-1?Q?wRDIdF5+mCLXGgiUbvljYNi4WMDBdJpSFuUv8/LcwCJcpCE9xLtOnbtH9Z?=
 =?iso-8859-1?Q?U3Z7T8TsxfzUnvRXe2yG1OZFG2Df+KGRDjsz/+Ohaa3GPvTTOxwBZzMsAR?=
 =?iso-8859-1?Q?wZPOS0GUZRmPp5StDyhn2pquiTk5Fow=3D?=
X-Exchange-RoutingPolicyChecked: tri4/QBEkvCWvLm5tuT9iYeCrNDiJQaIV7EKKVIvAIsmCDDFCdvRqxPsbRBSw3P27mG7Zj0HPXneucHDrlJT+ENhPujpz1KpthFVhiOqsWeCdFBqX4wcexan4tKrpzrs7zpG996laINqd/r1LV0T0mzMsXrNAb++XgJi85NPqq0cfa1bupu+MxgJgb0x6aHVSXsXIWn9lt43avLWcY/cjLBbkZCps+H3v4tdW0afUwuGVzxL29ZeegpDBYntWqsu/Yycn2aKQ6+GOOLJSjpDZ/2/hmGfdEX+hadzeKWVSW7bC2sGJJK0uJoBxws82poH5ncg343GtIfNyoTjiXR35A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 13eeb1f4-03fa-4a2c-b4b8-08df0aa51270
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:53:40.7207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Bb92TeALHrB80QM9RuNKtu9j3B2NAG9u7xd1bq8TtCfbo8dSFdWJvtguD6JU0txcZy5uaZNehbYTdJ8BvwHtM/ioHAwLdaRwn/CdLpFR7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6016
X-OriginatorOrg: intel.com

On Wed, Aug 05, 2026 at 01:55:23PM +0800, Richard Cheng wrote:
> CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
> ("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
> with size 0. BIOS may commit and lock such decoders so the OS cannot
> program regions through them, this is a design choice rather than a spec
> requirement.
> 
> The kernel rejected these with -ENXIO during port enumeration and
> aborted the whole port, so affected systems showed nothing under "cxl
> list".
> 
> Treat empty decoders as first class instead of special casing them, back
> them with a kmalloc'd resource, since the resource tree can't represent
> an empty range, and keep the skip and hdm_end accounting intact. Guard
> the paths an empty decoder can't serve, e.g. region attach, DPA free,
> and poison queries.

Hi Richard,

I applied this set to 7.3-rc1 and retested w the new test case in
cxl-topology.sh - all good.

I do have some comments though - see below 

snip...
I'm snipping past a bunch of Reviewed-by tags a bit sheepishly.
Maybe you'll quickly dispute my feedback?

> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..3b3cfa0f2507 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -240,6 +240,18 @@ static resource_size_t __adjust_skip(struct cxl_dev_state *cxlds,
>  }
>  #define release_skip(c, b, l) __adjust_skip((c), (b), (l), NULL)
>  
> +static void cxl_dpa_release_region(struct resource *parent,
> +				   struct resource *res)
> +{
> +	/* zero sized decoders are not tracked in the resource tree */
> +	if (resource_size(res) == 0) {
> +		kfree(res);
> +		return;
> +	}
> +
> +	__release_region(parent, res->start, resource_size(res));
> +}
> +
>  /*
>   * Must be called in a context that synchronizes against this decoder's
>   * port ->remove() callback (like an endpoint decoder sysfs attribute)
> @@ -256,7 +268,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  
>  	/* save @skip_start, before @res is released */
>  	skip_start = res->start - cxled->skip;
> -	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> +	cxl_dpa_release_region(&cxlds->dpa_res, res);
>  	if (cxled->skip)
>  		release_skip(cxlds, skip_start, cxled->skip);
>  	cxled->skip = 0;
> @@ -336,6 +348,26 @@ static int request_skip(struct cxl_dev_state *cxlds,
>  	return -EBUSY;
>  }
>  
> +static struct resource *cxl_dpa_request_region(struct resource *parent,
> +					       resource_size_t start,
> +					       resource_size_t n,
> +					       const char *name)
> +{
> +	if (!n) {
> +		struct resource *res;
> +
> +		res = kmalloc_obj(*res);
> +		if (!res)
> +			return NULL;
> +
> +		*res = DEFINE_RES_NAMED(start, 0, name, IORESOURCE_MEM);
> +
> +		return res;
> +	}
> +
> +	return __request_region(parent, start, n, name, 0);
> +}
> +

2 failures are now collapsing into one -EBUSY 
1) __request_region() returning NULL is a resource conflict.
2) kmalloc_obj() returning NULL is -ENOMEM

Can this preserve the -ENONMEM?  Maybe using ERR_PTR() or handle the
zero size alloc in __cxl_dpa_reserve()?


snip
>  
> @@ -545,7 +572,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	struct device *dev = &cxled->cxld.dev;
>  
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
> -	if (!cxled->dpa_res)
> +	if (cxled_empty(cxled))
>  		return 0;
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder assigned to: %s\n",


Is cxled_empty() the right test above?

The old check only returns early when there is no DPA resource.
cxled_empty() also returns true for a zero-sized decoder that does
have a resource, so this can return success before reaching the
CXL_DECODER_F_ENABLE check.

For a committed zero-sized decoder, that means echo 0 > dpa_size can
report success even though the decoder can't actually be freed.

Can the original !cxled->dpa_res check should remain, or the empty
case be handled after the existing state checks.

This also means I don't think "DPA free" belongs in the commit message's
list of paths that need to be guarded.

-- Alison

snip 
