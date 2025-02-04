Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140821C9EC;
	Tue,  4 Feb 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738705207; cv=fail; b=P+lEsMzoyy2fQoqmvB6x6fpUFoKH4EMkrLDcUW7nRnicc9kizvmxwbSJv1MlEdYTuizAsO3XYkjnHzm5MxS3aRlGlFY8n7r8bSloyfLM5IZg8jBny1Jgx928KlXBZ3bAeTnvOjy4uV3Rw3jo15RR+HkUK8tc52zYMtP2xpCn6XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738705207; c=relaxed/simple;
	bh=G+WJexaydyJggxGTugGdfjLtYQQvtu2tEoFhqDvQgAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gqlZfp7iJAPWZL5kPCtu+sn1Ybqeuq0JHven8yUTvUvGH1BvVrytmzjgVUPUAOw8DViq95W3cYeI3tu0pJwAawLe7bXdbk2M3bedj1K00bmU/Y+3PFikpKNvLTgGzgiAQBhXnNFYqMALVOtbkdkMyMoLcs3cUcbFLED6Jr6birQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vkgf7I4E; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vkgf7I4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738705205; x=1770241205;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G+WJexaydyJggxGTugGdfjLtYQQvtu2tEoFhqDvQgAk=;
  b=Vkgf7I4EwwplZLoVoKYGjMViOiRji7zdhijcYxQKhqFLiI4JZHArikI4
   u82nA64ZVF27Tk6VyY2siMa9ArxPhwXk8LAoU/a+XeeCqlOHVvNJGTde1
   pP2NRqXx4MBj4AqWUNhl4NNxiZ0zob2/nz21/uoR0iEL9xe/TSE75yq7C
   4qloTRsRkNJHu/lCxkSSnlfSZtGdf5Fa/9FasNsTlky7o5OpHuf3y+Qfr
   rzjNFcCpRC8gnQKosQ7QLsFW8BfRCgaEzwCnLTK+q+2wpcdqJgI21Llbv
   QKQbHN+0fh+aFHjRTrnOdKcCGR9x18dJTdrGIKipc0khc3vJqnXU5rh8f
   w==;
X-CSE-ConnectionGUID: aEraKsuGS0yLG9kMPubQ5g==
X-CSE-MsgGUID: 82ieu1T7RZadQfrpfHaIEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64608428"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64608428"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 13:40:04 -0800
X-CSE-ConnectionGUID: ojh6/fhiTRqlrO7nUtlvwA==
X-CSE-MsgGUID: YKcUruQ4SoefAaXs3CZy7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="111290188"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 13:40:04 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 13:39:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 13:39:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 13:39:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUp3h1dmn0kpM7AiT2/EsHJc2lKd2E6NgnxAfZsV88OEN01RmnkYArrVjEw5oDKoKHZmme1mmE7RR79oeIME/F6D0umHq7HNYC23iizoBdQOCxVJqtafkyULst2r5MAwkH/6Se8rXjGV6mcX1L+cX4WG25hF4nlSeLqTLfrZlmZ+Opx6/TnbEaf68yV8d09sTEBhuFMwokng32iRUpDjjtsOk7uhBfN2cjCMoPEuDKRmOQ0mfWAyuYqo6vfiuYhjxiRh2LlRjhTMgIh7gWTChoIrJpuKLxSzFHdOiweBHk+lPn7pk/NrY3LX5YndKp8flBECB8olM3mNI61ea+V6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKhqgzYYjsPfL5bOPEIDJJWEhfRR/DYmo0/zSXX+qxE=;
 b=tkPEfx7NYpCXMFOjLYX1I7URzTQngCB3atJ7DGmPvcTfJ1ey67MW2paR9t0+WSPHPnnxjY3jKFZS8d7aH9Lz/kdJuoKPDvkUfW8/0ss1UZt1G6KJmXhVf6iWft+mEl/1LXVjOWDugl1iXwoB57a5EJa0+IYI8CicW64V4/8Fqe+uOZxwhUAVc0TCjlgLDMM5mPtYnhElWD/kp3hgOpRk8HDH/gY39BNbtVXFCY+WbS4UA43xxSNzrYOxto1YpfX4mN8vqvZgobxU61NGhi65JmcK96m5GsGD1M1smTS5ybcoz5eFzGIUXYQMFeRUqGGRffEyqN7cHgm274PA1Zw4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7264.namprd11.prod.outlook.com (2603:10b6:8:13b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 21:39:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 21:39:49 +0000
Date: Tue, 4 Feb 2025 13:39:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Message-ID: <67a28921ca0b5_2d2c29434@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
X-ClientProxiedBy: MW4PR04CA0356.namprd04.prod.outlook.com
 (2603:10b6:303:8a::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edf3564-67a8-4b83-7e75-08dd45647320
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7j15nplQSLw1k+EsSM6N4y8ZH7TanxotaShSYAiamAHLHM9a7y0q+GSSfUgQ?=
 =?us-ascii?Q?K9fnoQlnIXN6RiDQjAdt7TzqSjnyW7TtIeRUn/SGoIptGnue2DJLRQL4Bx95?=
 =?us-ascii?Q?t8ywcJyzYZvyAovKLajfPRq9ILk6oVZizA9rCjG0u9G/Qbkp0vlhMb3l6Wup?=
 =?us-ascii?Q?gEoGy3mVzxeZafc0ougT+c0QA1atHOtu9wk/00Q7i+0bBOhmcX1uFUCy66XI?=
 =?us-ascii?Q?yELBjBRLeow3/QIEme2j0dvqAYfTedZhMKU/UrZ9gMHmUzOzOS4JnLOTlVXc?=
 =?us-ascii?Q?zKzimZiMU6HBFzyog0hoLvk6OIS0IxQTTjxJD0SumlWliDkWdGW05dXkF8DF?=
 =?us-ascii?Q?U6MwHil7LwPpD9mzeaLU6DEVJp5WmeSVi5L/qdPxatvnrnuuvG65BI5wp6sT?=
 =?us-ascii?Q?/Yk2Kx5VOgYxLHoS2E5NYZvKEve4QL38q/mAjHBD7UEx0cSoXxuTsnft8fmP?=
 =?us-ascii?Q?+SuZxgbPsMkiqo6PCWPKGQHeNIbL9r8Sdyw5pWesl/CsKNoBf9IjI0aV0YGR?=
 =?us-ascii?Q?ybud/1AYyv+hxWA02JlC1BUaJZ8UrjDVE8xneCJRH2wMYTI3d0uzlhCdjruS?=
 =?us-ascii?Q?JY8WgspBR04N0rUI7JkGUj7urwQqrifsBard3aDij73O+irm/99TzyBvjFL3?=
 =?us-ascii?Q?/M//xxZkfwNsS54vI1WQEOMxQOKZ3G3uYX6hfkL7NiHGAQ2gwfx1oCqlk6aH?=
 =?us-ascii?Q?7T2gUmpWhKFHYhcI7rxxYGlpINDf/kkZayTSqO7M5EBsgTqfSF+zkf1hXt1o?=
 =?us-ascii?Q?z/8Magm8n2LjrC+8q9V9VBqP7jQKVMzHQx49dgWXpweMHoU1/g7x0ZGJd+a1?=
 =?us-ascii?Q?Mq42axt+lHD5Y4waPx+EidLFr9Z+ujQ2LZ/u0/FqxgSrrStlusCQi8a4OFq2?=
 =?us-ascii?Q?JSgVOgznH54otxDvM4rgL0RnqCjdZSze6LANx3mBtm6wD1EUjOwkYMjW65ub?=
 =?us-ascii?Q?c5vJJcF4bpGt3WtqGGquNz7Cvr1tIdgcS1YCYxdgMmfuIHoE7+nXphtc8Yzo?=
 =?us-ascii?Q?yC9xbnkL8/cAMxGrJ8aCTJA8Q3ZPtj4UHT70hiRvOMUJGQE7DtXt5joA2urz?=
 =?us-ascii?Q?9bYrkt38zyOhBNjosCjPeTuwjPP2pagnFuqhPI+KuJ0jiTufPF0TSP+FOopg?=
 =?us-ascii?Q?xQ+oqaEogcEdn84C4otE0UGqE5PvA4SvRuKgEyBln352kaoWs5ugGzBcmoDF?=
 =?us-ascii?Q?vuaLQnDwYpmA0jvdDfocx6TBYcB36eyuR1sK4Zc6qCWlWvoCJ7mP62Ajju15?=
 =?us-ascii?Q?tQvUw0t4WCQs6n2cG0DoK++GR2VFBa4iCzIzy6ypCt1d15cZo5GcIEKo9iV3?=
 =?us-ascii?Q?R9PRaWwg9MmsGAEkNVxFEuuptnBTfsUnkjCW1ledxL8oorpxpjv6eqaYRkSn?=
 =?us-ascii?Q?ckMATQ6ztJJNsi1fgOWWZi6hPyf8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D5xtZau9YU7eQKUvqcw1Hkac2QktRtzuiGVmeCEjhWTYiz3wmJ+wEgy8h5kI?=
 =?us-ascii?Q?GkM9BIW44ut34t5sSZbfk5A2vTg2BSDsXVV/Ejx1uDHJU3mJiawTOqhR/+d9?=
 =?us-ascii?Q?uuevLvT2xXVJ7R5r/mLy60JpGQ/iT7gQUc6BlklJsSZVjQEtD4Sgh89TxFeC?=
 =?us-ascii?Q?9UZICih58rYMsxvFjGUw63pn2OV9gYdSTmE6f1m5spyNMma7iCs+izV6hp3P?=
 =?us-ascii?Q?QNuG0xHESu5YmP7F0lBaCpmpleSaBLe6RlDYanOYl4uo//nkMAAaX/sU8mSq?=
 =?us-ascii?Q?/uvZwJC+Zngvf501nhN1yvjle2FiggyxIojvGoaQWRKYd/1NQieUWWJOY8J8?=
 =?us-ascii?Q?/MBk14hLLH9iktqvURSUHtJDxDIeJXopvAXuQjqxO5EQnoGMleuamg0Jd+6X?=
 =?us-ascii?Q?LU+jOoVHfLvOICfwZuARXo7i9gaCHszEb3tnXMD21xzC6X4K/EQfMiXmecn9?=
 =?us-ascii?Q?MSsD+GQM0CF9iDDj+sB25gAkcLKF4jyt79ZgMSSGsOZChFsxtQRohQ4QeDTO?=
 =?us-ascii?Q?CKLbzA0fN+yrqcaWc+ioJcihKjuxtGeCo/FVvDVY+iX1Eju2bcjmyXwYavP2?=
 =?us-ascii?Q?cjlHD/gPVQ9Q/6tCmjr+5GWeGUpwkcr7ks7GKE+muhFCSYVwZOFky/0WbPpT?=
 =?us-ascii?Q?Fl8Qi8swtWqx2xB5Xcl6QMFWWI/g159AdK1z7SE7XEvIQzWMhLCkgeiZfJld?=
 =?us-ascii?Q?Km6J2XILBwEGKKxCGmtIV41W2Fo/n0ZRUczdTxK7ikdAolK/xsf47kl9c1Th?=
 =?us-ascii?Q?1kWAHsjMPjKIRaEHjig/AxIHeby8GnGl4f5rOmFDXlpdUaYaa8X4RD2l8KTV?=
 =?us-ascii?Q?pkUfJoCm/kNKQMwTw2X6cdFZcjewL2jRdCMzPZQ/I7EKO0WK7xaTPgzFzpOh?=
 =?us-ascii?Q?+Ghdfq7dcjScPMOrINOa4HcyGOpBaA8A6w/YoOu2lobIkivjcb5PsI77nuxc?=
 =?us-ascii?Q?qj2d7L7Agg1CFcq1pblKZhXHSesXHvZ385ntpbyjAnbvoRj6g61X+tmAFpZt?=
 =?us-ascii?Q?5r0yXQJ3fK+Wvk4mvyJV2ofVhrNVy9+xMSCCydzf2s4gzRV1h+q5k86vkxIZ?=
 =?us-ascii?Q?J1P3tNMqYEs6Kv8gAmH5waYT5upTR3GlY1Pq6zjZ9mwr/eQ2rRQT4DqDWZcD?=
 =?us-ascii?Q?w3UWoc6FHHkaXQ4s3ZpkOmL4MLV0fFQZPbb8B4GLq9xlf0xs/3fsyywagOxG?=
 =?us-ascii?Q?Jq4cklX4NeqPu82jodNqqkioLaTe645eq1+QF2g8kHgxtK4SxDf2TqWMZc7V?=
 =?us-ascii?Q?N+iP6RtZEgee8S/rHP9iPJr22yPuFLU+sbfym91JCDIKwbxl8DE8qnUUX4ih?=
 =?us-ascii?Q?xAoCP9QaDpJwt8ps5ZyZdxNCfi/Dlz/6RCW+i5qDyalrO7wyNE+pRah0POg5?=
 =?us-ascii?Q?hrdxLfPpjXxXhGjyuClJtTqUANDiiYjWK9g+CTX3jbNhDsn1/vcrVnDype0a?=
 =?us-ascii?Q?5LCrk9UhCxnbFiulyCK8pMBWgRem58o5LltrbzUswdCmxK+LSqnqmTmuX6n2?=
 =?us-ascii?Q?BpAB/j78Gvm454wLSMaXObX4S6Pc8hU2Fc4kdTesYoaAGFohjpMHyK1w+hqy?=
 =?us-ascii?Q?z39SryqqVFXsDff5iS+AMszVjcJGbAkn8LdIB9ZqRoC/SaYQvmPJPqFhcgV5?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edf3564-67a8-4b83-7e75-08dd45647320
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 21:39:49.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujsgfjP212BBDYpcoYKPZxtsFoQW3Vy4aokRhGxTcU6S75YH7b1R8ZyEG5L2xdXH6Ebsinm7oZvtFgiQrX4GnFIu5M98wL+43qacS+YY/Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> As was mentioned by Dan[1] cxl_memdev_state stores values which are only
> used during device probe.  This clutters the data structure and is a
> hindrance on code maintenance.  Those values are best handled with
> temporary variables.
> 
> Adjust the query of memory devices to read byte sizes in one call which
> takes partition information into account.  Use the values to create
> partitions for device state initialization.  Take care to separate the
> mailbox queries from the initialization of device state to steer the
> mbox code toward taking mailbox objects rather than memdev states.
> Update spec references while changing these calls.
> 
> Link: https://lore.kernel.org/all/67871f05cd767_20f32947f@dwillia2-xfh.jf.intel.com.notmuch/ [1]
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

So I am confused by some of the choices here, comments below...

>  drivers/cxl/core/mbox.c      | 77 +++++++++++++++++---------------------------
>  drivers/cxl/cxlmem.h         | 25 +++++++-------
>  drivers/cxl/pci.c            | 13 +++++---
>  tools/testing/cxl/test/mem.c | 13 +++++---
>  4 files changed, 59 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 998e1df36db673c47c4e87b957df9c29bf3f291a..44618746ad79b0459501bb3001518f6b7d2ceaba 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1068,6 +1068,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
>  /**
>   * cxl_mem_get_partition_info - Get partition info
>   * @mds: The driver data for the operation
> + * @dev_info: Device info results
>   *
>   * Retrieve the current partition info for the device specified.  The active
>   * values are the current capacity in bytes.  If not 0, the 'next' values are
> @@ -1075,9 +1076,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
>   *
>   * Return: 0 if no error: or the result of the mailbox command.
>   *
> - * See CXL @8.2.9.5.2.1 Get Partition Info
> + * See CXL 3.1 @8.2.9.9.2.1 Get Partition Info
>   */
> -static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
> +static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds,
> +				      struct cxl_mem_dev_info *dev_info)

I was hoping this would get further away from new in/out arguments and
look at centralizing all partition enumeration into one routine. That
was the intent of cxl_mem_dpa_fetch() to capture all generic Memory
Expander DPA boundary information.

>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_partition_info pi;
> @@ -1093,9 +1095,9 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>  	if (rc)
>  		return rc;
>  
> -	mds->active_volatile_bytes =
> +	dev_info->volatile_bytes =
>  		le64_to_cpu(pi.active_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> -	mds->active_persistent_bytes =
> +	dev_info->persistent_bytes =
>  		le64_to_cpu(pi.active_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
>  
>  	return 0;
> @@ -1104,18 +1106,24 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>  /**
>   * cxl_dev_state_identify() - Send the IDENTIFY command to the device.
>   * @mds: The driver data for the operation
> + * @dev_info: Device info results
>   *
>   * Return: 0 if identify was executed successfully or media not ready.
>   *
> - * This will dispatch the identify command to the device and on success populate
> - * structures to be exported to sysfs.
> + * This will dispatch the identify and partition info commands to the device
> + * and on success populate structures required for the memory device to
> + * operate.
> + *
> + * See CXL 3.1 @8.2.9.9.1.1 Identify Memory Device
>   */
> -int cxl_dev_state_identify(struct cxl_memdev_state *mds)
> +int cxl_dev_state_identify(struct cxl_memdev_state *mds,
> +			   struct cxl_mem_dev_info *dev_info)

This function is tiny, and most of its work is just transfering
parameters from device to an intermediate temporary object (@dev_info).
I would say just subsume this function in its only caller and skip the
@dev_info transfer step.

>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> -	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
> +	struct device *dev = cxl_mbox->host;
>  	struct cxl_mbox_identify id;
>  	struct cxl_mbox_cmd mbox_cmd;
> +	u64 partition_align_bytes;
>  	u32 val;
>  	int rc;
>  
> @@ -1131,14 +1139,22 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>  	if (rc < 0)
>  		return rc;
>  
> -	mds->total_bytes =
> +	dev_info->total_bytes =
>  		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
> -	mds->volatile_only_bytes =
> +	dev_info->volatile_bytes =
>  		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> -	mds->persistent_only_bytes =
> +	dev_info->persistent_bytes =
>  		le64_to_cpu(id.persistent_capacity) * CXL_CAPACITY_MULTIPLIER;
> -	mds->partition_align_bytes =
> +
> +	partition_align_bytes =
>  		le64_to_cpu(id.partition_align) * CXL_CAPACITY_MULTIPLIER;
> +	if (partition_align_bytes != 0) {
> +		rc = cxl_mem_get_partition_info(mds, dev_info);
> +		if (rc) {
> +			dev_err(dev, "Failed to query partition information\n");
> +			return rc;
> +		}
> +	}
>  
>  	mds->lsa_size = le32_to_cpu(id.lsa_size);
>  	memcpy(mds->firmware_version, id.fw_revision,
> @@ -1237,7 +1253,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return rc;
>  }
>  
> -static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
> +void cxl_add_partition(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
>  {
>  	int i = info->nr_partitions;
>  
> @@ -1251,40 +1267,7 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>  	info->part[i].mode = mode;
>  	info->nr_partitions++;
>  }
> -
> -int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> -{
> -	struct cxl_dev_state *cxlds = &mds->cxlds;
> -	struct device *dev = cxlds->dev;
> -	int rc;
> -
> -	if (!cxlds->media_ready) {
> -		info->size = 0;
> -		return 0;
> -	}
> -
> -	info->size = mds->total_bytes;
> -
> -	if (mds->partition_align_bytes == 0) {
> -		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> -		add_part(info, mds->volatile_only_bytes,
> -			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> -		return 0;
> -	}
> -
> -	rc = cxl_mem_get_partition_info(mds);
> -	if (rc) {
> -		dev_err(dev, "Failed to query partition information\n");
> -		return rc;
> -	}
> -
> -	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
> -	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
> -		 CXL_PARTMODE_PMEM);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_add_partition, "CXL");

I am not seeing the justification for both 'struct cxl_dpa_info' and
'struct cxl_mem_dev_info'.

>  
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 29817f533e5e408243d361c46ddbf0c295b4fda4..62e641d69eac975bae023f221c40713ad0317d1a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -542,12 +542,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @firmware_version: Firmware version for the memory device.
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
> - * @total_bytes: sum of all possible capacities
> - * @volatile_only_bytes: hard volatile capacity
> - * @persistent_only_bytes: hard persistent capacity
> - * @partition_align_bytes: alignment size for partition-able capacity
> - * @active_volatile_bytes: sum of hard + soft volatile
> - * @active_persistent_bytes: sum of hard + soft persistent
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -562,12 +556,6 @@ struct cxl_memdev_state {
>  	char firmware_version[0x10];
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> -	u64 total_bytes;
> -	u64 volatile_only_bytes;
> -	u64 persistent_only_bytes;
> -	u64 partition_align_bytes;
> -	u64 active_volatile_bytes;
> -	u64 active_persistent_bytes;
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> @@ -885,10 +873,19 @@ enum {
>  
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
> -int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +
> +struct cxl_mem_dev_info {
> +	u64 total_bytes;
> +	u64 volatile_bytes;
> +	u64 persistent_bytes;
> +};
> +
> +int cxl_dev_state_identify(struct cxl_memdev_state *mds,
> +			   struct cxl_mem_dev_info *dev_info);
> +void cxl_add_partition(struct cxl_dpa_info *info, u64 start, u64 size,
> +		       enum cxl_partition_mode mode);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
> -int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index fa30e763a0ce4fd78441f486ce08c81e21207e29..b69ba756e7f722a327c42fb57f843635cf8367a2 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -903,6 +903,7 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_mem_dev_info dev_info = { 0 };
>  	struct cxl_dpa_info range_info = { 0 };
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
> @@ -989,13 +990,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_dev_state_identify(mds);
> +	rc = cxl_dev_state_identify(mds, &dev_info);
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_mem_dpa_fetch(mds, &range_info);
> -	if (rc)
> -		return rc;
> +	if (cxlds->media_ready) {

Why does media_ready affect partition boundary enumeration?

> +		range_info.size = dev_info.total_bytes;
> +		cxl_add_partition(&range_info, 0, dev_info.volatile_bytes,
> +				  CXL_PARTMODE_RAM);
> +		cxl_add_partition(&range_info, dev_info.volatile_bytes,
> +				  dev_info.persistent_bytes, CXL_PARTMODE_PMEM);
> +	}

Why remove the cxl_mem_dpa_fetch() helper in favor of open-coding these
cxl_add_partition() calls?

>  
>  	rc = cxl_dpa_setup(cxlds, &range_info);
>  	if (rc)
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index ed365e083c8f545b6c1308f48b5f4f7bc51135e8..b88bc3fd8122e6dd2969d525e72f1ea8d5069913 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1477,6 +1477,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_mockmem_data *mdata;
>  	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_mem_dev_info dev_info = { 0 };
>  	struct cxl_dpa_info range_info = { 0 };
>  	int rc;
>  
> @@ -1534,13 +1535,17 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  		return rc;
>  
>  	cxlds->media_ready = true;
> -	rc = cxl_dev_state_identify(mds);
> +	rc = cxl_dev_state_identify(mds, &dev_info);
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_mem_dpa_fetch(mds, &range_info);
> -	if (rc)
> -		return rc;
> +	if (cxlds->media_ready) {
> +		range_info.size = dev_info.total_bytes;
> +		cxl_add_partition(&range_info, 0, dev_info.volatile_bytes,
> +				  CXL_PARTMODE_RAM);
> +		cxl_add_partition(&range_info, dev_info.volatile_bytes,
> +				  dev_info.persistent_bytes, CXL_PARTMODE_PMEM);
> +	}

...and here is duplicated logic that goes away if this stays centralized
in cxl_mem_dpa_fetch().
