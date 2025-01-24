Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31611C1AAA
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737678990; cv=fail; b=g4pfvDplyVViT4crX+7FrjLpHF4EJMEQfw7SUqBbWq1SlV2Mt1SmTARe0rYIcC/fzQutbifaOJhBX7onjgDms9eza1FRMmcfdZeN4QbFN4VwcI2swvBwNBTAVOu18akqwnOH6MxvNvtxeu/AKo19dm+GoYC7x5kSWKL8kUeHtUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737678990; c=relaxed/simple;
	bh=dSmw2qH5/Q8r/1SzDl49WHz/wr9dUYkozCEVbbnNwsE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E/EehRH+4CKOvihQUHEcyWRcTeh3n3qmDFXtrefPft3Z0W9pU3chpXfPKzDO5gtttXIRqGTtYuoH02bbaEoIjT4IHClT20P890SYXm6v+U8zyzydKn2bNnqNrUKHDrvsocU0yuMZEQvVGWjdFdAkF/02Ii3ZSgop5TI+o/cwAaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSfclYnA; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSfclYnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737678989; x=1769214989;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dSmw2qH5/Q8r/1SzDl49WHz/wr9dUYkozCEVbbnNwsE=;
  b=FSfclYnAg9wgnz5JkHxqhvdsk7Otot904WA7T9WkdnWkBTGdZEgfEIMN
   B+lObh0VC3gFIm/V1WbEsJ9bRGIWZmzqAzyi/BAQ814SVB7paINJRbT7v
   9NODBE/bSyXEmTIsqH0OAuaNI9TDkSsyhV0zQIe9/kv0vCjBXa2HXaKal
   1oMmQFTfhaCn4peUNWGmp4v5OlCeZ1wF3s3mqrooI8Dh1BjVuPmOGqYpN
   pWLlfKTXViHKJ99JowtuCskRIWhL/W9l0vHlIknmKbKP1gaM00sJe1wKi
   paG6NRPmFkyj/tSwfj5uby1U6ssSvOv2tW6LhZUnzyWuKlVF1Zfg6hyZP
   Q==;
X-CSE-ConnectionGUID: KXLPLcHPRcicE47kiyeU7w==
X-CSE-MsgGUID: zCGDgZruRPKPvAn4yWmsRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48795004"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="48795004"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 16:36:28 -0800
X-CSE-ConnectionGUID: zHA5BEIcReeR0gCKOFNF0g==
X-CSE-MsgGUID: Kf5ay/JlSMGtNHQA2yhCzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112582296"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 16:36:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 16:36:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 16:36:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 16:36:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmGvZo9lLekSbH5w+LTcphx5v189Tg5+mCPXVd3GIPDW2hM9p6nSlRL1CJkuHTZUoDqVmSKFtmaM1MI4NMiWGFXEJDvZjrepJS4Ud9fps+YHeLeGSSK2muT8hp4hRZXcWEqO6VkpeAGAMg5Yd0y6UwKN6OB7Y0Xa2u/s4wlRaGiAXZplEjBlU2i8uvXWdzfWDS9jrw3ifEXYDlYC73yo8xjjry1+8dsw6FDhd5QO53jfXz1UjPWO008j0w/7nBySY6tXxr98ZPBtP/qA4WpnIqn5E9SWwt0h3TNz8WPc6WGLXUBcKR+nKeSw04qee8pWI+UO9kNH3J2P2RZErYQkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQH7oet5Hr8pa4qIeIm2NVgzK3N9tX9w6+Di3H8Zazc=;
 b=H8HnzJWuT5P1OpU5VFlfzZW8YVb45OUqmpQVgoNGEqt5ERZOVX1gsfVVUh9KTpSNLZ7X0iG/rqIb/EvN4cMubJZeNmWJlnKDo0LTNGqzZ3ZdHwBLK+c1GLS9dHd6zN4kbGhiGd9yjnSzNSumnC4ltbgQCBWhZNHvDF7P6Yma9phDG7rHiWdmnkeznn8wUZpMq885ENQbPi5/04Bsj/bpogEj7Ozss4YkhXJqB2gAwkmFK3K1DJSjR567TdoNU1KHTlIlEd4IzRKY9w5JQVZdFJYbgrIoLL0DsVtklcSXEpMfsG8of2awYxEzN2c8zijGxfbSz0wCV8dZjVvh0a7F1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5320.namprd11.prod.outlook.com (2603:10b6:208:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 00:35:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 00:35:44 +0000
Date: Thu, 23 Jan 2025 16:35:41 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 05/19] cxl: Add features driver attribute to emit
 number of features supported
Message-ID: <6792e05dba40f_20fa294b8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-6-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-6-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: d4772776-8ab3-4219-ed0e-08dd3c0f09df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k+C0+nrgx489MBnL3wfK98zDQTG8CkkC78Ezwv1gmYNGavY3CkmLnvoY38xF?=
 =?us-ascii?Q?Eo7fNNKrU70BZMFfp2jUOMbbvp2x2xaw0jx784eXcnA+n1cmkZ5993x/r4tg?=
 =?us-ascii?Q?wv/D58AzBEXs62wNhMAQrR6tfo3jKx+eBbSn8AQ3PvUAoNuoWBDSTaY6NqI2?=
 =?us-ascii?Q?nq8p6LLrb9Rk9R8qG8UHEBTUAgXtxJHpjCbgnQLv8xf85J63sA/dAEGfCkyZ?=
 =?us-ascii?Q?mhR41gfKxBGCqlMkReI5397b8Gm/YZuFjZDI3HHqJfZ5uJzspkDXcVvDLFyg?=
 =?us-ascii?Q?eIsJCOtQqTRN+HMuqSRn7y1Qog+Fzixf5lJjs5Xfe880uMw2TExT6iz62z+u?=
 =?us-ascii?Q?yyHBiT5B+Hd3hFr079TWvqmXYVWkIxhaitZw1qadOoXpNCfho5TpQQQvQFkf?=
 =?us-ascii?Q?1diCJvO9esabM+EyvdBtPyhmSsjFTjJlpVPweQeAwe1xxYFCte/S8x3piM6S?=
 =?us-ascii?Q?oqc0RQ/f/rGsOM0HTud97ul6Vdl6uotMGXOEUR4W5M0ENF0rh1hMQiOruJ3Q?=
 =?us-ascii?Q?K3sOzPux1k5FUNxcGlXedHeQq3MbEVMEzqWiNi3DaRFQqYqbwV/r8ZpCAhNm?=
 =?us-ascii?Q?s6rmLVCPGrbw9XqwIAXWfHVNelDgTJZRajaznYMfnXg+XHC9+o/9XKj79DQ9?=
 =?us-ascii?Q?/qJBTymHqluRdR8ebsn7bEmOnygxKU3/iuE+hwdilhAj1H1QvqzwffvVloRb?=
 =?us-ascii?Q?imtBFnraiWj0oLt0WXQBZL+lAPTVhqxgRN51+MeG/ubjLfM4MU8/7gXjiaIY?=
 =?us-ascii?Q?j5Ye/eT09orgIKEUpRtEUh2LqBACp6xIubFuAge55A6Uoy7Lqo5GGVH0UumO?=
 =?us-ascii?Q?jc1e6jwMfvclSHw5ONzwQUVHiGjG13B/nPXFE3eks3OukrWzrXaQ/HymEzAI?=
 =?us-ascii?Q?IlNGo8aZ57xu27ylnmHlp44aMqpbU/zlhvLC+6XCJ6FHBzdtWDEm+VcMKBYe?=
 =?us-ascii?Q?kCCTUwIPkvS5c6cjq3k8BkLW9bOp2EAqwvGME7QloCt0dUJG5n+WNte7LE97?=
 =?us-ascii?Q?noN4MOqvcbz27co2CtbEbsqnjVuJaBW7m36IVr4hH0aJyKzbMivxDZUYSHJb?=
 =?us-ascii?Q?cpAYUwRtaZUVn9p2N26co6iKwtTGrPkhWDNwc9A1dio/Mc16om0KxmzxPGZR?=
 =?us-ascii?Q?uVPcXtbwiMY8+69h9wETPY0xA5q9512yHOfbbkfozCCiFEyYsF4wDJKfT+u5?=
 =?us-ascii?Q?MhSAgA/0I8LpiE59kdLl6xuQ0ifRt8wH7+Bt0pZfRORxBpgpW+sRU0sY1WsV?=
 =?us-ascii?Q?21m1YEgLK2qAWZf2NF2cYQ1zgOZV5TEFVslRCYK2WLJ0xfhBbAxxwESJsgBi?=
 =?us-ascii?Q?rFcSzJbwDpefCJmcArTcjDzc6RiTAXb4xWSalvcbs3Rtf2dDzYvSyOX+U7DU?=
 =?us-ascii?Q?gNfnx5fH2rK9keqeoundJ6OyYY0F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ACXA9y0lLnr39GsEnLCO1OAvtEuYe1lIPEXsw/tBOT/I2MyuwRjptnKB4DC8?=
 =?us-ascii?Q?zMFXCyVJYNNYaU49a2npfOYNYn8+w3xeQ0AO4UpATb347QJi48rhRkn+emlY?=
 =?us-ascii?Q?ItKOb2ivwDWW1AGqOY7WXEd+X8AFeerCjGcKk3E0TxEqKQ9j7kqmBgKQ27z1?=
 =?us-ascii?Q?ojJgtPpkVyFE01k0sDL3/AROTQdHIYboky3IyIER9vSSJ4ZRbl27A9OEx9rr?=
 =?us-ascii?Q?fal7Z1J/Y9UWynB4GTWUACFbBepX70Hbg2+z/0STA5QdQkepj4qE4YJzPJa/?=
 =?us-ascii?Q?7ZqZOxWkr2scm6XP3DocFK/RGz0+L34c42e5vd8w+DRYrygJFhfoaOK8XRTd?=
 =?us-ascii?Q?mdrZxnltyeDfqEHSfl8raZSyW9sKSDvrByIqySBxKwyg4X6/F2oG0K9WKZV0?=
 =?us-ascii?Q?dDOGaS2/h/S/mlLTrZ6M8uSwuvhKsXLA/dVOz1w3J2pxrcEVsSeKa5rACege?=
 =?us-ascii?Q?FQHlotWgtTjrUWTpIQ2sA0qYLBzXr0mZut6ayEDarUpHdggQUYKwnolos5Oj?=
 =?us-ascii?Q?9qnj6eE4/Dp4wbrn08Qfb1PQdvVEgDcPTSxQ3sL7QAV5Ec1kAZaWNYBYPJOG?=
 =?us-ascii?Q?Dis9NS4MGAxtQsBoFneoNI503ysnU8x6gxSylpOPscnyjQvSk4d2KdZ0ea1p?=
 =?us-ascii?Q?FsHcSchBHBoCT4yY8dZa/souZvetFkP5DC3OGCoZtviRA2RPsqMimscBMvCD?=
 =?us-ascii?Q?F0EDxzTCmKOXjpShn3EoTuAJxZyx8J5L5BxYPAfrKaJ/Dg5Y9NunuyFn3HGq?=
 =?us-ascii?Q?fE6xFTx8oQjzpIyArYToM25g0ztO/KjkkZaR13LJE3BGWeGMHGtGWaiX2+ON?=
 =?us-ascii?Q?SEdAo/T7RGznqJuI1DHm+EcJ66ePFknK6qsRY9lSvJWwRqh1cN2Gd4LtSplu?=
 =?us-ascii?Q?+O2ZLR0iM97Yl7G9pjexxGn1fILpuXFfZ8pvAWeFwvUtPylQKeoG+7WBMbxG?=
 =?us-ascii?Q?/Pgio7CJlCQrsx5gq9PAJCHE6zofnA6++p9dOsO+7RrmAVLkWYKJOd8e3hRc?=
 =?us-ascii?Q?N+KBYj0wPYlVseCqeGTXTXJ/tOeZHXLjq6sRA2+MAwoUafwkwSdiIMUHRhHP?=
 =?us-ascii?Q?89iXYp7VlNUvG7ZiAyKF/M2Bm78BFak8HYtSnzsWLcG1R2p2yyxFXbJaGEn9?=
 =?us-ascii?Q?JkZxX5UNhz5KYnRoWAEAxnG+oHtyG8HkGTSc8zKzsBFht6CtTNn0zLgzzSbN?=
 =?us-ascii?Q?/NtTnW7cBDeAahS3tRR0WVt1r6tZhxKCbQTojti5aRrMBdLkzTgp+faE/VxH?=
 =?us-ascii?Q?ixenyfSBaRMbE21cyDekKWyt0xDr+yOA37nRv8Q8qofignwkt6y0KiVSfu1J?=
 =?us-ascii?Q?XM6PGMH+6z9w8q9iAgTRNoqQfTSatg475vGzNnWCTi0UuoiujSY+i0EidESA?=
 =?us-ascii?Q?zr3Omr9wdJHR7BsTwguPrNxCAy4Mjk7veiZg1DP28FUapELth05a0S4XE7UY?=
 =?us-ascii?Q?hIHZXEKY6+rkG2aAQFi04CgXxBro2ao4N03dqQm9iBynoCzcVUPXkvZO22aK?=
 =?us-ascii?Q?SNHNFAGu9BkiyQETZn89A//gWxtr94dxoQP3W3vQKGQz+souz2L8m3LaQHC0?=
 =?us-ascii?Q?twLRNWqXuMydUBm7oeIu4G7m0WfEWuiWBgUphxYRJu1MT03H/6MDF3tJnfOy?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4772776-8ab3-4219-ed0e-08dd3c0f09df
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 00:35:44.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lOa8XM5CfK2d7AtFUOcDQ+/V7P1Znb5BeBVLTSib0ccYaJer+qp48kA0sL19nhutTWWXiGTtrEOkXa061bH45Oob+oyTEHhg2CvI+l6L2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5320
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Enable sysfs attribute emission of the number of features supported by the
> driver/device. This is useful for userspace to determine the number of features
> to query for.
> 

It would need Documentation in Documentation/ABI/ for userspace to even
know it is there, but I am not convinced it's needed given we do not
have a similar sysfs attribute for CXL commands.

Is not the expectation for userspace to call Get Supported Features
itself?
