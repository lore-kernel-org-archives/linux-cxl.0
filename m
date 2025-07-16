Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201A24293F
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701216; cv=fail; b=mfysZd/tRHq+2SjmCVFFQLA7bzKgXMQtjoRjS5iCGi/zvs0N4nHOtoBVyY7Ba3gj/L6mGS47l4TB4nGfRD6XBB30KdGgUC8Su0qL2cNQnznpsbr/Kfu5SzTTa74ybnnk8QQvlZ6BB0kucpLCg6YLhQ6jhCkI2HuYP6TgJikgQDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701216; c=relaxed/simple;
	bh=XJhuH7CedOPSWKAyltuGeZ9m9Gg1W5p3JN6IhMxFyiI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4y5/hTSp6pbFsB8YbSgJPmR8duEnYEaHaUJepkqy9/A+yaPHuu8WkZpZE0cDdd8XLhAl6Myp3cI/zq0E55vjF0j078v5kdLt+2jorjwPgfEyKiRkNPYl66TYSjRkGrEq3La94FsIYtbVtlZiGNSrh3/vT6D2oYp17gLqKLkxmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fh0RqFlN; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fh0RqFlN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752701214; x=1784237214;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XJhuH7CedOPSWKAyltuGeZ9m9Gg1W5p3JN6IhMxFyiI=;
  b=Fh0RqFlN05/cFX08cJ+4SDR3WzpipEiC5wY9h2LPZ0I5N0yQXUzHIRJp
   0H4tPrBQ3s2K0Hbyn3hGz2cYMKx/DqjA3LhrrHOBX6cTmazJ+y1cpDXsR
   mKFnEGr5GZEVmnwaCGRLUZe4b9EaMwtRZ8zBHDaVKIwMDp0sKSFWwnYDG
   ykR9OOHfhkWRyQNb2FMpMXTibwaQnqN7cJQ5YUL8NMFkLaRZREpysyNnL
   AWjFg7MoI8BoN16c1zcLWw2wiEnuwhHR/OaVLwOyM/FvDlimelTWJyxgc
   txNqN0ffk2HFX12Jgycf7f204t50T8PXGXqaK/6/I7hqS5EqvMXtA+t35
   Q==;
X-CSE-ConnectionGUID: IxcE57r8QvWuCA8dnPkgLw==
X-CSE-MsgGUID: 0+b6P80DSv+hfAhGdDw0wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54071294"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54071294"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 14:26:54 -0700
X-CSE-ConnectionGUID: YpE2ttOPQduDKeb/D4f0gg==
X-CSE-MsgGUID: NBLVzvW5TVON7m3mG9VQSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="158325902"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 14:26:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 14:26:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 14:26:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 14:26:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk4JdL2e8LKZuEkuyUP46dPTBwiyxZAyBjLCl84NhYFt1Tfoz+xnxnku7IpridGq4+6y416swlI3zG7rE4fspUTssVHQDjNRVoZyr3AHrIH26UrhMu6wpkk7zVMtqY4cwkXUxsbkwxxYmzBcY2KVIeExRy+n0q+TqVqXj8Yv1j5KEZ18e7jnzYHGBpAdGwlExD+iBr6wFEkzWXUpW/Q6dECxvq4MJRVCx73TvYKDAJ1QzSwIkia2cK2V5g+myjkZbUiue99L0eGhIoz3RjrJoWqXmXDY1NlVxg4pJOk/q43DNHoQ02gNzTnLV3Q92jUXMbZFfAwVuqnuNGqEV6J9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9jqFnIWdu4pSR/E8SFXGmscWeruYgyioHuQnnSSNu8=;
 b=URIsGRgr8lBzoqkT71Cnpw4fEOHg2UexjQyIcd5z3YUjpGmA7vT9n6a+PObdbTdB36WLax8VEF1+muM0k6xPcYZvAOECQ+Gc0Je/9dbSwC0pUWVr+gitTrrZAwOU2jkcLkSIxYrH7v7Y30K2X/QFJEYoMIXEgBuxl6sGo1AbB5qSv+jbQJsrfIvHwdC97DRy/q1aYdCrJuH3yDTJMk2uoiEQ7pMzELI+AIgu7sdmVbKBiHHf2L68OsAyTw05yHt6gA7n+FKYb0hKEVsC2t9jn3uRgPfkNVVN/eYhVH42qzjDWU4f3OML4xJyy+UeHPCouAb7DtCFRaHVa/fXHJJ0HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by DS4PPFDA283F46A.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 16 Jul
 2025 21:26:49 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::6bdc:278b:bb01:2da6]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::6bdc:278b:bb01:2da6%7]) with mapi id 15.20.8835.023; Wed, 16 Jul 2025
 21:26:49 +0000
Date: Wed, 16 Jul 2025 14:26:41 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] cxl/region: Introduce SPA to DPA address
 translation
Message-ID: <aHgZEbvyuf4h0Kk6@aschofie-mobl2.lan>
References: <cover.1752365427.git.alison.schofield@intel.com>
 <28eeffc8905e658dc3ed62a7c52e030cbcfd5158.1752365427.git.alison.schofield@intel.com>
 <20250716115226.000067fc@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716115226.000067fc@huawei.com>
X-ClientProxiedBy: BYAPR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:a03:54::34) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|DS4PPFDA283F46A:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6664d1-9df0-468c-466f-08ddc4af7958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s1KvEPOFUG5BBnJAlrFMQo0szdo8Irtsu5ejVHWBFN0AjihhcQahSbKI15cE?=
 =?us-ascii?Q?4+RxH1aOdEBJx1YIrVLmuLMtNe+bcg/yreNQatFzqTdkkLANIJ5cv8HFpJ9h?=
 =?us-ascii?Q?f5p7ZRm7s8D1u9EU2+Qe7SWQhPLaphjMCh4fwR9UTf22MopmUikVuVEbYpCl?=
 =?us-ascii?Q?ssW5cIYSvGwUZPStiHXKuEb7Vidb6LqeyhKKY2ZdLpoPAMRbD8OHhvkNaBHp?=
 =?us-ascii?Q?Q6fja+KTqbioN0Z+7TlqzyBGPrknjq2SAXeE1WWMGAeUFDFRO5xW5pCj0hAy?=
 =?us-ascii?Q?7i2A1iBxegxGCfnwfWpXOYW2VLIUfEDdvbqRjQjxXHpwf7rim0GuaBHIVa96?=
 =?us-ascii?Q?YKXW2AR3rMA5o7ZMTCT5cv32UAbJGzUbu2FzhHDN79Y90rwJUBN0/aGwGvzF?=
 =?us-ascii?Q?ERMAEt9YduJUEilMqGYXjMpLdR3RjF9pnQrcnZ5QnfcgzQA57CuYR9JJ0aTg?=
 =?us-ascii?Q?FJeI9KcmhvJqt8nFPQpDxHMrt9XaWVtkg4248HI7ACB6uEve8W44gGzgfswe?=
 =?us-ascii?Q?T0+WfAbRo8ehF3RJXVwfp41yWnsQeTAkfD57UkuNJA63J2CzKBK0qHN9Ij7G?=
 =?us-ascii?Q?M4b85JF2kq6gZs/b6gxxdPhdLdwFox841na/gKe+9sWLBXaGMcaSmYTD1yow?=
 =?us-ascii?Q?U937DjXYvIeOQGKTlCEVAOH/e9T3qE+eDGF2YVlepvEbd6JkuzryjTizWo5P?=
 =?us-ascii?Q?ebj0ei+hRyVQd4D4L6PVT6jKytmWjE7zojt+1fGH6HlQEdYxKVCFvyIvttqy?=
 =?us-ascii?Q?pr/ZsxPQl68ylay6+tvCA7R4z/KmQNUfGq3WDwuFdtTsLBv5jAe9T2n/RjCS?=
 =?us-ascii?Q?NVxIzqyDK5ojhx1C6P43TnwWGioJTPozKcan8c5Lnr50gDt4k9A8WjT9Yw/l?=
 =?us-ascii?Q?TYK7oQxUos7WVp5B+jskEuQUQEhQ23SyvCEhTlDu/njriMl1zIf5wtVBjs0S?=
 =?us-ascii?Q?TxcNDAjE4Xi0cUU9xspJ+kzD26zhD1O9xtv0/ZIUIjtTarEZ/mX7Jx2t94XH?=
 =?us-ascii?Q?OaF7EK38EAKQ9Ey3GN16O/mvSfsbsRhBFiWbrkvFWHJO47vpIpgFG5vumbWr?=
 =?us-ascii?Q?Vi7I7PBRagd7Wtns+VOtrmYc86zB3l+roLjlRjcCKUFmp/g1trBGVP5Jl7Sx?=
 =?us-ascii?Q?eph2mw2l10II3xOV3nAU3k/K2MLSHn5FQfUH89mG/+DbBPwLoqfFs4YMU9LH?=
 =?us-ascii?Q?iK366OlttzF1ZXA4x1GKTDUWAwJQ6v73EOs6GPglx0/uQxLzPMdFo3qK5ycj?=
 =?us-ascii?Q?v6BpbtPsBdmuHGG7V37STKXp0phphhN/5yJfPh3ZW6KoOm3/DCN4Qul+F1tQ?=
 =?us-ascii?Q?oeZjD2ar3Ohq7Yf5qs0srCPQTWZS7Y4oTEfmdEH39Soxe8ng4CVvjhNfR4IH?=
 =?us-ascii?Q?nlmYNczbRIELb5Krq5bH3O+F89x2j58HJTSzxzzw7olMEvpr6CIp2wXiiCcg?=
 =?us-ascii?Q?20s1HLTBmtA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qjiEOEOpcKxAk2UhDlALjoQIbQiJt2rHIkhTkLeOeKQ7/tnRmUys4h4hU/MI?=
 =?us-ascii?Q?EPX3RsdPlRVK5tzIRHdMA78UaE4UW8B61Fo1H5+YJB49sPesvh+EcnnwgcBs?=
 =?us-ascii?Q?0DiVMb92rAZSxBvHv2LrFFlLDs86jgYXMl6JqorniulXxB1wNhkPKiwfkQk7?=
 =?us-ascii?Q?xhQ+cTnPKQxjdkQGukqIp1Gb1tzfkffuwQG0QSI+87Ox08JpQodlA3cAGQfH?=
 =?us-ascii?Q?spbMUy3ZCZmY//hqAY67/3VBu84RO0d3SoH/t7uaYXwrK/JmAq8jVuFpPqvX?=
 =?us-ascii?Q?6Bqxo0PnXDhEuflsLAqt83L+OUdvBJbQ1AeMh9q4RhahVpNkOchweQN7zMX+?=
 =?us-ascii?Q?I6PZ6hmqo83M0jUob8MYjEG10iPCc64GYAH9xfv4pm3xL8YOExxTnDMkK5z0?=
 =?us-ascii?Q?fWT+WFcHEs3yYotG3Pc+hhq4gQ0kIePiDeUKgJE4NZdL+iUhZk6e5SpOKxE7?=
 =?us-ascii?Q?wrCyZgQFDZ0tJyfZreqIbuJMhWM7/QXwiSQ9G0b2/pLDXRgf55Exgkts2b+A?=
 =?us-ascii?Q?RkgL5M0X1erOlCP/F1fSAcEMZfIxk5nUVCK9ZmfbvfYX9TgjJhP6MGCEfa1e?=
 =?us-ascii?Q?ddwxSvywkcdJiNVZJEpTcDi7otiFmbBUM6YVfqFMZzgGkYqy45hYj9OUzVg8?=
 =?us-ascii?Q?+jeLQsychUxvKIOd6ZnxU8MA1WqWRE+vKWeCWG6JWtLBMxvHr+J/3jm5EHq9?=
 =?us-ascii?Q?iiItsaoAriw5py6YkdcyYIyPiyd6pjSMxcqt4hbGzGi1+H8x3/wHfNIDJXbr?=
 =?us-ascii?Q?a//8gSwGYA1zMc4CMT8SBH4oKvZELUdMDHasgtADBHKstxu+Rhq05zmrKrFf?=
 =?us-ascii?Q?U86hZAQS8aQobMVL7LJs024f6oqAnf5F/BsO/IqUxmhwICOf9waeE3VN+Zxh?=
 =?us-ascii?Q?080weC233Bkp+KzeinpVMUK9mnEVS/eUupD/itq8ePL/Mj/oXxplEcwkoVa9?=
 =?us-ascii?Q?1JuCij4cqly+TLe9iqMSX+unlK3SKczIPEQeNZtLOIUFXuthzbTcPzFHUfPM?=
 =?us-ascii?Q?TnAYpAMUOU8Nh+llcmWuW+Wd2jc8tgwFBeABfbTqY+aPuaDGHoKMapdIPTyv?=
 =?us-ascii?Q?4b74Uk+KvSIX4cQh1hpWATFuxd6MZFwHxz+Mz9JhspQ8Cp4++9aDD8mECQ3J?=
 =?us-ascii?Q?VLisaL7Z434Dut5TUjmjuMd+6nlsWH4KrujJ982yMUO44VgPZVcnfFRcH9YH?=
 =?us-ascii?Q?9F2K8imAKqrYeMIvHOp4TcC4q78QPY8E/n1q5bp/7LcSg7WVnciMgbwhBiP0?=
 =?us-ascii?Q?Be1kTwiz4OjmDzx7a1AuOIJBebJZAbrzg5zcJ7lqI4f926Vc9aK9vncxSpea?=
 =?us-ascii?Q?3wOoAEgCUyxMIC15oCjsz4ucVgGrfnQflj3aLYihTxhEE2DEcQIN+SxBInwi?=
 =?us-ascii?Q?BmX7X24s4j8BAqOYtMEZJnuTJzbIpX8aUV1SxUPMVKrR0wJuh+lwTYDY3uej?=
 =?us-ascii?Q?8mt3rnORVnhVVNigxgRYDxISceXYDdKkQ67RyYF9Wt/37QjSXBAXrr8FzapH?=
 =?us-ascii?Q?dktmt3fLPcpy6M88ILZgkOlArQ4cdieCMOfnX/PFvBm/T4RKQbkwxhLlV2DB?=
 =?us-ascii?Q?Dcrh5mdeI36b/sS8VJN2Io0SC2enc5TaaX8p1x+xi1Qffb1m9DQSFX7sm9MU?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6664d1-9df0-468c-466f-08ddc4af7958
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 21:26:49.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hn8UCqgF3jbUru4j3PIbeqMmtCFWssbfmDF7Lszoy9AARAL8I9blYdYPMxieYkBb5TP0TL/yEL/9R4jDZNitmbijXFhDJMs9vy2VHPL6gp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDA283F46A
X-OriginatorOrg: intel.com

On Wed, Jul 16, 2025 at 11:52:26AM +0100, Jonathan Cameron wrote:
> On Sat, 12 Jul 2025 19:37:55 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Add infrastructure to translate System Physical Addresses (SPA) to
> > Device Physical Addresses (DPA) within CXL regions. This capability
> > will be used by follow-on patches that add poison inject and clear
> > operations at the region level.
> > 
> > The SPA-to-DPA translation process follows these steps:
> > 1. Apply root decoder transformations (SPA to HPA) if configured.
> > 2. Extract the position in region interleave from the HPA offset.
> > 3. Extract the DPA offset from the HPA offset.
> > 4. Use position to find endpoint decoder.
> > 5. Use endpoint decoder to find memdev and calculate DPA from offset.
> > 6. Return the result - a memdev and a DPA.
> > 
> > It is Step 1 above that makes this a driver level operation and not
> > work we can push to user space. Rather than exporting the XOR maps for
> > root decoders configured with XOR interleave, the driver performs this
> > complex calculation for the user.
> > 
> > Steps 2 and 3 follow the CXL Spec 3.2 Section 8.2.4.20.13
> > Implementation Note: Device Decode Logic.
> > 
> > These calculations mirror much of the logic introduced earlier in DPA
> > to SPA translation, see cxl_dpa_to_hpa(), where the driver needed to
> > reverse the spec defined 'Deivce Decode Logic'.
> 
> Device
> 
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alison,
> 
> A few minor things inline. 
> > ---
> > 
> > Changes in v3:
> > Check return of ways_to_eiw() & granularity_to_eig() (Jonathan)
> > Collapse a header comment into pos and offset blocks (Jonathan)
> > Calc pos for 3,6,12 using actual ways, not always 3 (Jonathan)
> > Mask off bottom bits in < 8 offset case (Jonathan)
> > Wrap code comments closer to column 80 (Jonathan)
> > Use a continue to un-nest a for loop. (Jonathan)
> > 
> >  drivers/cxl/core/region.c | 93 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index a2ba19151d4f..404f69864d61 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2956,6 +2956,99 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >  	return hpa;
> >  }
> >  
> > +struct dpa_result {
> > +	struct cxl_memdev *cxlmd;
> > +	u64 dpa;
> > +};
> > +
> > +static int __maybe_unused region_offset_to_dpa_result(struct cxl_region *cxlr,
> > +						      u64 offset,
> > +						      struct dpa_result *result)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> > +	struct cxl_endpoint_decoder *cxled;
> > +	u64 hpa, hpa_offset, dpa_offset;
> > +	u64 bits_upper, bits_lower;
> > +	u16 eig = 0;
> > +	u8 eiw = 0;
> > +	int pos;
> > +
> > +	lockdep_assert_held(&cxl_rwsem.region);
> > +	lockdep_assert_held(&cxl_rwsem.dpa);
> > +
> > +	if (granularity_to_eig(p->interleave_granularity, &eig) ||
> > +	    ways_to_eiw(p->interleave_ways, &eiw))
> > +		return -ENXIO;
> 
> Why eat return values to replace with ENXIO? I'd prefer
> 
> 	rc = granularity_to_eig(p->interleave_granularity, &eig);
> 	if (rc)
> 		return rc;
> 
> 	rc = ways_to_eiw(p->interleave_ways, &eiw);
> 	if (rc)
> 		return rc;

Ah, I should never have tried to appease you with a shortcut.
Let's revisit.

In v1,v2 it was this-
+       ways_to_eiw(p->interleave_ways, &eiw);
+       granularity_to_eig(p->interleave_granularity, &eig);

And you asked to check the return value. I *should* have said "No, the
input validation ensures these are valid. That is, when storing these
values in the region params, we do eiw_to_ways() and check that rc
value when storing. I'll note that this is not the first instance of
using these functions without checking return value. 

How about one of these:

Original:
+       ways_to_eiw(p->interleave_ways, &eiw);
+       granularity_to_eig(p->interleave_granularity, &eig);

Original w comment:
+ 	/* Input validation ensures valid ways and gran */
+       ways_to_eiw(p->interleave_ways, &eiw);
+       granularity_to_eig(p->interleave_granularity, &eig);

Original w caution:
+	if (!p->interleave_ways || !p->interleave_granularity)
+		return -ENXIO;
+       ways_to_eiw(p->interleave_ways, &eiw);
+       granularity_to_eig(p->interleave_granularity, &eig);


-- Alison

