Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71014F12F
	for <linux-cxl@vger.kernel.org>; Thu, 24 Oct 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780491; cv=fail; b=TrdFRtOKwaQV8e33BKU5tw0vShdF48AzG7YLd3NPZ083xIjufokLcXGHO8c0VacpkmluV508K5EfOkdqSbsf207F8gUX8/NA11KblVK3n8DiQwEX61A6k8wXnKl/pvHGoGloVzBFuU3wGFYa8dC6+B/mCsWBSCPn6yHD0O0zTb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780491; c=relaxed/simple;
	bh=zXO1JL8vd5+AikNQm3wJDa3ypsafJIH340dlLBRt8AI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rmHyTFce8jauDTuRgUCnpxB0iHkftQQrR/DWL9PSwja4xUk/HqV5DxV/BZ4TlKKf4e8QmWYRRvOmmosYUzhbVHtq6hV3oqmtGUwjWczy0tw2X6L4OG/QirTIwAYkYqSTZk03nTKQEc2K1zYfJj+hgWiJHPrU2SeJUD4edYd1I2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvD5I1UY; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvD5I1UY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729780490; x=1761316490;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zXO1JL8vd5+AikNQm3wJDa3ypsafJIH340dlLBRt8AI=;
  b=jvD5I1UYvHgofZ6GRSsUfT4Hi/vmGNjlAp2SyyoP+2jUqIRXCrH+ikJc
   EDwavulL5sQZ0iv9s2ymt1lboLNyEwgE3WPHg1d31YgC1Stl/MWTMCz0E
   7TxGgSLunfFqfojtwejX6YabSLSzpLbzZt0RxozmbQK8j+87wqxeqd3pM
   ncxBYyL2G8fCxDPNTswH09wcIycyNnP5rhXHPpnLzotDhXMX0f3OsMPpp
   yGC1PJbOtEr78BN5uYsGwXLxfl1NuK3PMJGynf+dO0/gO4hblq7Frz6ZX
   pXDBDLhtug+4fMFocYa3LDKjEEtl6fBLT4BQuslMvAULxfZvXez+8iD6/
   w==;
X-CSE-ConnectionGUID: 8c8XMb5yQ3Wgxvcg3vKlqQ==
X-CSE-MsgGUID: zrX6tSxwTWimAu3Gt9ktaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="33210257"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="33210257"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 07:34:49 -0700
X-CSE-ConnectionGUID: uOi+ll2gQRa/S+Wns1uajw==
X-CSE-MsgGUID: PLucWPNFTIO09an+ap0jJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="81040549"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 07:34:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 07:34:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 07:34:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 07:34:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jpe1OISxcMia7cERq/NYm6FtOrqiSqKFjJFcJwCXFBeTydum1WE6fe6zGQzQkWFI8Uv6UPbikH8KQMxMtjnxvOiFsTjMMKxKuuttLAK+XjZ7Yncr5Uwa1rLv/owmhnEgi9KwNWrIBYw7pRPsRvhJq6m2FWh1Fjd2/ykNl/eksnXzfa0WYTx9wz/Fa8XjxPJBoSVK/bGqToCzRDmh0uah9QFsG3KIvUz3zVqHKjVIGR4qO/2Vo+Ntp7G3Ws9AGDYut3btFnvq76gB0ENNCEhyPlDYbeThGPVGmOMzP/FXV8AtlV5mSXJuVnRV0LXUiErgoZqd4uvOFU11bUX7e2UKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFK2jBCwy46RVczptLEjSmtpIwugjTnLwLZdS/eBVnU=;
 b=vBAbEuXwm32GS5itbJsmOPX32DKxFAy+WCx+Zr92ftbG/mIVKwOuJBJtg9EIVmEqe7xwMmXwuomGlYxUE/5rFdI4i5IMIwNNY4jPIjHIu59mMB/FgOZvStovhN2HdJ56rQMBr4U1oyawDbe78rSJQXAGceRgvIFQ2dQbHQSTcj1vQCt+4uPJ5RVBNgkaR/iEOSsYxzQx5N3/Q9eQ4wquwCn/O1UYRRflI/o3QIFA+bXGU2JCmssFjGWIvR9qNqWG8KMzRXVizdqAXUDuBgFjf/i8EdLNcX44YG69HhM0a0iVbGRXspEjKg21mP/g/H7jVgZ8mbU8r3PRLIUeHM9WKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 14:34:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 14:34:45 +0000
Date: Thu, 24 Oct 2024 09:34:41 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>
CC: <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] cxl/acpi: Ensure ports ready at cxl_acpi_probe()
 return
Message-ID: <671a5b01a8d9a_f5b20294c6@iweiny-mobl.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964781969.81806.17276352414854540808.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172964781969.81806.17276352414854540808.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4743:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b27ea8-25fa-4e16-32c7-08dcf4390178
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JPp7eIBP1WHPjosXhYnKL3TTpcQa8q7MR+FJv0crNHBZ1OuuH0D5sAM56/8T?=
 =?us-ascii?Q?64axHSOi7ZwyRjquSBALPN0oTY4lGw94qwm3WpV+bybCPZ1yARmA9QnRntN7?=
 =?us-ascii?Q?m71hC4pZLpbicMlakEBk6oI3jLe6X7jJkuFcDsIindbELAtr86ylszM5B5aD?=
 =?us-ascii?Q?8RN5UdMzijIs6y/Us+iAaOUEKu+4PHiZwULoACB+fHt4/TqjQ5/+78ihuwjv?=
 =?us-ascii?Q?mQqr2tpueV8zAB8+tJRXgT0x5K8pRs7ezKxPQelii3vAJO7s6boKP+OSblaX?=
 =?us-ascii?Q?fAxVAHISJIX7yRwQYKurZF/kSerLSPVp38h3PT0k/2xdDl7SZg4v4FldoaMf?=
 =?us-ascii?Q?C1u7pmnJLnHCilT4sMarwhVRXfoiLyWxoH+eDhRYGtXngwXW0qfQNA1YTVZn?=
 =?us-ascii?Q?eQOjKpD3XNX8Edc4Nr8/0TwuTwsJsktL4CQhYeCZJL9xPVHN+f59OcYrzDU1?=
 =?us-ascii?Q?gTjs+mBMVMWBOGRcb2/vqYhYjtgGISqbVJ5zDLo6KRNvgqWkSkQdU3FZqhCS?=
 =?us-ascii?Q?jjbPzKJmXpSCRfKXxuLLTiUoj67GzP5FD9qPnLBXdhw/Lho6pqRm2TEy1itL?=
 =?us-ascii?Q?L+ni/ZWYt3jP99BbO6JOAakHCshp1uLZnmT+Q711cVB1pOlMODXN8vgtD9A2?=
 =?us-ascii?Q?RJGhNojtN4iEXBcu/q5t/i3zC3L5wAkM0thryoU9StQ/jNsjoBsoUtwN6FRU?=
 =?us-ascii?Q?3mDmBCKWqMKSI55CsGOEG20JNTiN9MW0z0WZ2S+rI5F4b6yybDTjvjEfy4FG?=
 =?us-ascii?Q?Q2bkahjUYnC9WrFMbAs93+sXCmBBqrkz+RRuWREZ+PbHqWq3bD5nWfD5BCGM?=
 =?us-ascii?Q?xh9kJ3GRwkx8J9s4OrkEkDfwLs7R6zAl6GJqWkXrFz+h6AGzCHV3g85/EXo5?=
 =?us-ascii?Q?f4R5UzVkziYsgW7qI4nVzq8GdWJMm3K7o8bTvOeCvDZivZ8Iz+ebJMZE6tH6?=
 =?us-ascii?Q?fziSatcH6Sm+WSth7b+B7F73fWKeZ6PETB9yvZ5+44kHyDmdxwXvd1fqVaqp?=
 =?us-ascii?Q?Vd6tgqe5LwcG6rWQsxr2kPPqWLHb5hgVab/KHIgerQ6iTZBuLPak2GVFCsrb?=
 =?us-ascii?Q?qsQknFLOXdoXLkB1fqvctq088tEkvVS4p88kD+Gtp0287thmDmWEs/UimZi4?=
 =?us-ascii?Q?qafe5w6CxjjzdK+xiExCLO/SmE3E+BwlyjoCS/mc6ET03pGN4i2SRFz2n19k?=
 =?us-ascii?Q?6G7cQu42DxXHWXrmDUObA//2bDx2XzFerVOQ5hBDRNDqtZBSCc9RlHm4stBU?=
 =?us-ascii?Q?mMKOrOXlYYPLVX1jDq+++Q3Zir+07KBoTaOqupTRUtEGNX93X/ZSWsWrSgZ7?=
 =?us-ascii?Q?T3nkevRECYU0qMUYkIbQ5rW7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qu6o5fMF5v52VpYWBJKbGCAR8671WGkpmhmkopaz7bCq3zinuS0b6JOVwqkA?=
 =?us-ascii?Q?a1XZm1O1yE8jX9FkxifjFHMPU/MExl6ZQaaTxKHLYc4rc5ZwwIWNn05EPu/7?=
 =?us-ascii?Q?GG/C7fxlYHSpHGae6aeQhWx3fWUWbJq8q3UpNsH5vyYTo3KX4DoMbkny+moh?=
 =?us-ascii?Q?QdXugcWiXJFglmSpELKQzi2dG/FuSlBmY8/3e+YU4fc4NPM+ET4gw3V5W7cI?=
 =?us-ascii?Q?We/P90HgDCGDGZOgEtcBQ6KBMk+7U8JtBJNktrQdrS2hFNc6IQPJ0B/MqPY6?=
 =?us-ascii?Q?qxQiQYVE9rRXvt1KnvsrYusBOt0JJ0FgYuLtOt9sEazO2IylgUmDraCstbqL?=
 =?us-ascii?Q?0nPbbvBeQrMIqlWSUv5EbGINTXZUiQJw0Fx7gqszu0bcqvPf+2htCqcHA2zb?=
 =?us-ascii?Q?MiHr8ZCOjTsH0p8T/GDr4n5gb0DsN/olMhx1vCQlD22wwmpNLcsbOQnJYeD2?=
 =?us-ascii?Q?P3b06vNxawmzQdzldZ65kyKOMSwOd6RazyJovNruQP+q92YIL7p9/24VNjVt?=
 =?us-ascii?Q?o2NciWLh+n2C8/31wC3ks/uMipq4I9hsBbNNap/qhAMvC/LTEC/WTDWS4Ci/?=
 =?us-ascii?Q?kMQJL2cZC8R5K0rV8vcr2/J8/atzJTANE+8vaeZFk8+RCs7pcKjle3kE0IB2?=
 =?us-ascii?Q?lZq1Zwp9B2CH8rzTjMiUEfXXcOyfkpy83FNdXZDgL2zYCuq9A40WGoF/s2I8?=
 =?us-ascii?Q?6k44UvFXxMIF4IYFZQWhGb/c/OdjlEEvS/HIgmc92UHKfkX3JjG06G9yibPL?=
 =?us-ascii?Q?5enCydpPGoxquXwPUYwCzXnWjkNLJCCU2wOFhvhwtImr9AsrpDDEaVYynZb6?=
 =?us-ascii?Q?Eg9fSTqczjANetKGoN3MEuhlwgEVZSQfRuOALuhwMr/ps/Z1plGx0DtiiWUK?=
 =?us-ascii?Q?PQx329eTbE8BqotbMa18B1cHf+KHS2nXRJhM/4hu594W+5o5LGYsmBW0OcDw?=
 =?us-ascii?Q?lAWXLfWj8QgzvQxfYPdmLv6UJZ1WKawA85AOaEAzLbW5pQ5fhypKljS7lYLQ?=
 =?us-ascii?Q?pRivAmZ2vq6GItuyoyfI8cvrfLDYIewFNveVibzkp0KI8kiJTHT22HgGZ0my?=
 =?us-ascii?Q?Id8+cWHXoX7TijDR0kkRBB0AWQxHa1RLkKG4P6C7QO62cFFfhPHQZCesOfiH?=
 =?us-ascii?Q?ZDUfh9n6JPL5BbWz01qvGdZsuNgeUMMuuSPeptpUcCIJcSypzCz9OIybRKVy?=
 =?us-ascii?Q?oPFYO/ZjphWFXeazUvr39n5nvvVty61Jjb1yDNRWYUx9JdhUiwKV5v80DMtB?=
 =?us-ascii?Q?skR9GK7TGHMda2D79B7weizmfsR/Cif/vnNNZSyJn6WFEr/xoPj3vrbqvOiM?=
 =?us-ascii?Q?2bl44xusCBj6e+jUuOqhcRzEa3FGyV3fBRRd5DDaP+azMTE31f1ohaNeJNGG?=
 =?us-ascii?Q?j6Ri9hxY7hRuuB2G/qHwqgytEK9oG9xLKZICDSUKQ58jdMZy1zalsbIhQset?=
 =?us-ascii?Q?0feBs0nYE7ZLtHMJQk0y257/mlXCAdACN37zMCTFlbBb5C1+kDEbaxZVhf41?=
 =?us-ascii?Q?WXLBOjG/s1F+2wGvcbUk1Nah6uXI9tM2NGI3/E4m/Kx+U43tG1z2S9YSSUes?=
 =?us-ascii?Q?G6OwWm7855I+ToBZmCLaY0NCVmiG/yiFSrvjHR4H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b27ea8-25fa-4e16-32c7-08dcf4390178
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:34:45.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sInjm6Bh/p/JECCjM4eOgGsFjcnfI9AngWg+pOZuWpzuo28IPFH2eTu82YLu2Zf/0IvjvTjXoGZDWLui2412DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
X-OriginatorOrg: intel.com

Dan Williams wrote:
> In order to ensure root CXL ports are enabled upon cxl_acpi_probe()
> when the 'cxl_port' driver is built as a module, arrange for the
> module to be pre-loaded or built-in.
> 
> The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
> is merely by inspection since the bug that triggered the discovery of
> this potential problem [1] is fixed by other means. However, a stable
> backport should do no harm.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
