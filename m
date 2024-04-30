Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE038BF0
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443163; cv=fail; b=uW37BeIN2Ul7i2QLWWSOgNtPt8h5De3Yx9iXgEV+3RoE1hkHPhf6FHtlcM/L7UZw8qphk6bNwwGAJWxZuWGUfTZscxAknVOqtUCSyEwiDsOhp2fTUPqo1LVoLFgmzeyBLKDlShxw1dhDXMMQsFrWL9EkLD3CYROL1kywk9xQbYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443163; c=relaxed/simple;
	bh=t+z40SE7Xp2eEU9K0PbLoVyBdesd0dqtai/Qug9A7gU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mPuH3HyH61Tc1AJ453X8V7oFCSFnJjxbgEXTNhWDcd25OEnG3oW019vYWuJUq32YKcyatvIIV027jeQk5/7MAt7vKZq3t1NFthte/eYCjPmtumijZOpsMoQSr9P+jaVt5V/6cuAXxgp4SN7xp8ESnbCvBnOAGTMq4y+PP92W8FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYcevKUM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYcevKUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714443161; x=1745979161;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t+z40SE7Xp2eEU9K0PbLoVyBdesd0dqtai/Qug9A7gU=;
  b=bYcevKUMXKq95nVK34jKHSL/AyZK+FdX7SR2uzpX+JZFdQMwjbKHR+0U
   +UcOfcGcEe0c5yEGnJPnYEi0IKKzrAYFCI728woBxogbd3Kt3hzzfBIwf
   wtBaI0gbtKjqlBvVQgxWgEVXNJdIjMVqSBHFRuWThxOeVXxpUbvEfkhp4
   vviVzXI3Ld74+ON6hGgVo1ln7rwm37bk+VTIPnzn9FOeK2PMo54Fk4eww
   L3tm7an1Gr1le7tJYNeX+CO5ziPc2x9nzCtkVmWUNA1EXmdqjkkQ5Aobi
   IEA1pc1AvH5g//1lX6s3pMieBWw+kybPzC/XpDs7sdVrqd7JNTNxZlkdL
   g==;
X-CSE-ConnectionGUID: JEDYnHWWQ2ufrU9DqvAxZg==
X-CSE-MsgGUID: /s+xd0n2SUOnCXfG6WAIvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10346357"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10346357"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:12:40 -0700
X-CSE-ConnectionGUID: J2S+X/KMTDmfT+Ag9XLKLA==
X-CSE-MsgGUID: JRyArubvTki/R1NOU1RmcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="30936101"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 19:12:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 19:12:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 19:12:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 19:12:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 19:12:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtJLcmxl8NNXUQQdnxYD45sD5/jobmxmpbUzvx5nf7CI64MYRhAkJfOsW/EEGP8JPrFL/tZ1wnSyUhPOTPkHy7fyjep6Ox9FVkcmJo3NLgXfuquX6ptWHrDtmdMK4CRyOKUmIowyJKBDBysmlKEsMFTwGk0oSrGIS6TQMH6XIgzKxnnHCIif3H2naNW9RWaKSqQILhTy1ql6AGaWL/DZvAc758vAbGxlAPiiseCjGE/xNSuN9IPgKU6os23yXhvt6FDbBhF6F84Ze1qqv2y2FmD2RNfR1deYzdObMNUm1ctO9xfuBcbmJrKv29hgDG1OMCkhdTBZlvJUYcB5n8XVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75H9q92wIcCG9gvtyQYNcAWFtNKJO3Ikr/DFT8HCWck=;
 b=e9wxqtSfkWJ0WHGkiSNmAcQbJtlStrs1d8w4wsTRgiSZlYc5yoqpEkamV3XqBBNnRnh18/AqVBd4d3zrm2nIqC3CAgXC893NEjN280/JPchDVzoFliF0QW8KU1b1r9CbbUYXd7WZ3ywhsvD5z1+/hlEnLvzgapbqTJmO31hDgeYfJJgomQ6zEerHfIpG2sWsVaihLqxRTl4qI6jjyUEFhP8+Q6X9UuLBYa5aW2N6R7sb51sLV16NaTLMIvVxUuSwMSRXkKAWcLfiETxCwnoHrYRssNxIsd0I6d69hc2MK6bwSGjMkkaF4d8Hfm9Enw+1KfN+Qyh7nPVouCeSRqo0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 02:12:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 02:12:34 +0000
Date: Mon, 29 Apr 2024 19:12:31 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Shiyang
 Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v5 1/4] cxl/trace: Correct DPA field masks for
 general_media & dram events
Message-ID: <6630538f3fe81_1b13712949b@iweiny-mobl.notmuch>
References: <cover.1714435815.git.alison.schofield@intel.com>
 <23671305ae3cd299aacb3be61d90504d6918a7f8.1714435815.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23671305ae3cd299aacb3be61d90504d6918a7f8.1714435815.git.alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 40af9eae-f0d3-44c3-c0ea-08dc68baff97
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gJoYOR8KkaEBjXbB83mqoXA+rxHt2LABzCoDW51bhJAM3fObUaytFOYEO/LL?=
 =?us-ascii?Q?cP0M8T014r7qQS7vt+7/FdftLlIBT2FOTAQ9iPWtEJjchvMu7rBdwT+z7Ea7?=
 =?us-ascii?Q?pxiPhou4ZWChxZZ/Z93MtApheQ0GN0KnRccG/R8UEvLGvqLDeyutd9TuKwpD?=
 =?us-ascii?Q?eUYQ0RyZt68NVeap7Xy0Ld58W4v1rCGZUUhM26rBFaVzqbCc4t0QMxV5wp41?=
 =?us-ascii?Q?mYCaYXrjRPdjgFKV5MmrdqrBtAnyPKeIFyCNLfN9BX9OYGwaI8on1rk3FR0h?=
 =?us-ascii?Q?EkcPpnlCcHdy7ax4q3GW3q3tn8riLb2/0k4zMY0Ke6+ojGPRpKkWnH+zibbq?=
 =?us-ascii?Q?FpID0GQQ8yB2ohZBB+mP5aLdqXXzpqEmqA9nuRYqTQcWrV5Xn/wMTU+IaSIy?=
 =?us-ascii?Q?QGwQn0W2Gq9tNWvSXc1UTmxQXxraaxHb4k1+I4KvkZt7Zr8p5AIwPjv2dBRU?=
 =?us-ascii?Q?ap9JvX61OwAoCBTNcnkI7zCwTuHlfrGuuUm+AwobP1EIjEtNMuSPfkEe58w3?=
 =?us-ascii?Q?RWWkE76KweJKF6EwT1kPrCjaFwxhSkKctrkkvIkCPh4KKiScRUJxLJ4rrW5Q?=
 =?us-ascii?Q?/u4zEGALAp06clDlkLffmqE1tdpfXYk6tGSTlHKEUCkPPfd2a8IYfviv3TsP?=
 =?us-ascii?Q?xII3zeFkT/L+lUkvltK6+FbsoYOARCgmXJ+91hL2542eZu01KwUyd0sdZUYM?=
 =?us-ascii?Q?K/8deX8v2Vr62R7ImCjx9fVaMs+61IwsfNRwlX7u1UE1gIjwF9+pOFRZLr9S?=
 =?us-ascii?Q?BmTE/ksYJk2cjrjBw/lvNkjs+ofC8bYVT5xDXAM1lRZPlKL/EdlT6Ys53Hur?=
 =?us-ascii?Q?21bhMK0rB5W38bdzzUukgbER2eBkJY4O3pRkNVSFAKwJHG5BpyTo3owPFw0+?=
 =?us-ascii?Q?rbzSbz5+UiR9cg4Owzm+1kRb2THUF4Mu9tIVwMtvlrrw+RjGN4plPuBvsubz?=
 =?us-ascii?Q?+wDH7WW7wbRS4u9Sno44lkO6ZZPYPS22GhM39PNlrBRO/K6wrMqwBVVngVXL?=
 =?us-ascii?Q?NoKukijhrfqHS2D8+zIsIF0xM8D3TUPzgqnt11Ybyy+aV5bX6lTyeToXMLSZ?=
 =?us-ascii?Q?aZ5HY32x9NQOtJhFly+DVMk9tPf1zXlrKEMVQ8qBz/yow+EV1bDNdo5c6tXh?=
 =?us-ascii?Q?NyT8kLEwHePQYUv3dBhke+68J92/iuceYnP+H8+tnfEk/V7pUdQ9PDWGAmYL?=
 =?us-ascii?Q?Qi7LYLrfcFY6uMXJJQebmdhnRENRaF1DrExedcIWFL6CTeJjlpFa8oXFBNXh?=
 =?us-ascii?Q?mvW+vUtvoubKLobrhzb5vUQFCdC4/4JRBdiSASKmmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f9w0xzEs5z0YEw82YD/rXFksSeOnSuadavPXasMVNvEumtLGSrDnqjizOJGv?=
 =?us-ascii?Q?DWq8ZbC53arcl1+RrmxXLyd2BDx7earHK7P3g7jndr8iO5zr37Iox779VmwF?=
 =?us-ascii?Q?YkxdlTZWCKsZloO+goma/DJXH7W5ZvN3vobv5ymynpRj9XpiEoiDoNayW5BU?=
 =?us-ascii?Q?idKICO0l48eBoL5p1VFq0XjENsMrY13iXBcFfml+IWfWF9/q3zz1S4Xap0cn?=
 =?us-ascii?Q?CfDnjOFka4dzfUISTsWst6GQtUVGqUAnWjNbwAztdu7IIlfEs837oo/C/zG5?=
 =?us-ascii?Q?xvX5r06ISqz9zVq18kdAfJISxcXzPaTOvrBjcIe06wCK5+BRZGTrR4hw4HRN?=
 =?us-ascii?Q?9I6k0F6Tt8f+FaxJmki66MrnGRE/0aDoVtaKKhUpS53NHfmMNrvafwH/n0K9?=
 =?us-ascii?Q?REb83TmuzrRZIVLBn1T+5YyL6KyrDNecNjRL783CaJrN7lIEjeG5ChrtKjgm?=
 =?us-ascii?Q?jZEh+qu4n+nt9YeESr3z6/aYL2Msq4iXi8gCG8NS5ErRS7w+59QEffvqQA48?=
 =?us-ascii?Q?ZFnC6npXh2QIaQgwleIf8rfp/X217bVLITKwkyZOIwpTbB+zwOcnhFonkagA?=
 =?us-ascii?Q?JXh8hOHl5F9K2bteVEyXvhO5A80thJ3ihoWiBeRcnqgdwHCtbCFfaV4QuAPP?=
 =?us-ascii?Q?qzzM2qVPAT5ywRGJ5M75JGEOU5WGYoyxCjpAOLgO5qQ6nDPL6eWhBt0RScx+?=
 =?us-ascii?Q?a1T9dM4fE8JGsMUaaxXPsa9J1Cl9wmBEQK1dNSz7NYkpViWxEdkPYzLAdeII?=
 =?us-ascii?Q?krArmUCzzmq9vUh1UNuVp5X3TRRGPDwv41cqqEwgFO2cMSTYNETrSUvSGpwb?=
 =?us-ascii?Q?VJ4/2LqTpYGEVNm6vV/8uo0jGD1i/mERhJL8bSOkd519AsGjTvLVN/JlPLgR?=
 =?us-ascii?Q?06UAHhrGC7bqMus8OwHdU+t9fpMOHgdc2MaKGT/EDnWAeFI1gdh3NKAckvy5?=
 =?us-ascii?Q?Dnyixen9/AFnysTVZ3ZO9SXLHPwO1NydB2uRENqCwl1StRMQoWZ4wFvtew8w?=
 =?us-ascii?Q?3u6sciDCDyjZpAbdx3ELsMtGGFWgZqPOuKVjHcCCrJKvfEVxyFSVeWa+R7LS?=
 =?us-ascii?Q?zf+EFSVRadx5bjY26J/Lx8TFgM5+20YocaJuMQIZfqdGfGEgxgGG6qwSeDKP?=
 =?us-ascii?Q?8uzNpVZNrMfKvhk1BGF0KYEv53Faqw29bmGoBDU11ej2Cgs8R7ToiUv2TmYZ?=
 =?us-ascii?Q?RXHNYssAsUMT7m5LIpkY8u3KmpfflnCZ3oV1R0wZSbJA4b7IOfdiBPy9e1TI?=
 =?us-ascii?Q?FGCyd6/cHzu7lkOmpj2dLMWS3MFagXOS1i2Oa9rVDtSReHShqJPYS4SD4o0w?=
 =?us-ascii?Q?brKvRRjqTWOs+l1zX9lTeJyhE6rAeqoyzxpsUnu4gCQ9TzcZYagi/1e3Cqpa?=
 =?us-ascii?Q?eGG/VSe71Hxgz0SZXYuPeErISQNGLDyquZWK9ae7QAPv6Qafv3/3QrVMXI4b?=
 =?us-ascii?Q?WRxfqQUvTG0CeVgsoL+QmB6jMPJG24pcsPc6LZsfrNxgAXeoeE+2C0Ynqfy3?=
 =?us-ascii?Q?4ExMwxziZlgXU5tPenVINOJ/G7dl5RA+ry7oFs0G+LMJ3hk6qJBz0xepT0/9?=
 =?us-ascii?Q?RowUs5Q8taZmJAYD5mugy2U28gGeVvLFIbrqzS+T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40af9eae-f0d3-44c3-c0ea-08dc68baff97
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 02:12:34.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONWhZrT609pMwk1rf5HPqW48/pwAvcp5s0f3MuW6Ifcgu3G8EPYNreE6ejW+A+E+7NU6gwZWAAk1xnC0u2ma3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The length of Physical Address in General Media and DRAM event
> records is 64-bit, so the field mask for extracting the DPA should
> be 64-bit also, otherwise the trace event reports DPA's with the
> upper 32 bits of a DPA address masked off. If userspace was doing
> DPA-to-HPA translations this could lead to incorrect page retirement
> decisions, but there is no known consumer (like rasdaemon) of this
> event today.
> 
> Use GENMASK_ULL() for CXL_DPA_MASK to get all the DPA address bits.
> 
> Tidy up CXL_DPA_FLAGS_MASK by using GENMASK() to only mask the exact
> flag bits.
> 
> These bits are defined as part of the event record physical address
> descriptions of General Media and DRAM events in CXL Spec 3.1
> Section 8.2.9.2 Events.
> 
> Co-developed-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
