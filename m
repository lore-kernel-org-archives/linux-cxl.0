Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214FF86324
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136552; cv=fail; b=qNWKL03/D4GNLj57r6a4PnCEXOh6tJVV1I/1ORdIwEAJGeDJ0i41htnCjuL40qdZSCo7tQd8qwI13G3r2m8aXy0uGmGemQxr+pmGc0xdpHor8oBsBozBmNx/PV8xOJ+bTG0v5ZnaPn7CwB+p7GcVPl6NHy+jK3Rv/E/HXmh2Iqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136552; c=relaxed/simple;
	bh=fJL2bA43gfSfLn7Mf1DHPZYk6g0DbMTYKZsufjr7Qfg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ry0PTVqJEA+9+cVg9aLamahWrODEjlOrmH2GYf+73TI1gmoJGyDnYz76oDHPmVCAQ3Jsm3tB7CB0ywfe9Jfo2P5DVU9oCiLkZ5H2bx342mwvlS3IzptoCnbbuRvFMwW/YV5zn6Q2xyli4KOu/aUvi+AYzytt7tVy7RcfYeoPQQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7WMfkmq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7WMfkmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737136551; x=1768672551;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fJL2bA43gfSfLn7Mf1DHPZYk6g0DbMTYKZsufjr7Qfg=;
  b=X7WMfkmqtQAyawjRthMx5FWGC69LX/Z7vvpifLEvi0rFievSOhSinlJV
   e6toguFpnx1MkQJeHbt8gAgldbjcfpNav6HATpbWAN0RFFDxIFx1uXVGn
   uYqL9EcXnlxlwDh+Dj96c4varYGANQC3E+lIBVz09U4/9t3n/KHXoh0c1
   s6E4KLLGlmDZ0oxIYGRdg9rKcMh8lTudmEq1bkFxCjJJX2df2EjAJrW4X
   9b2nEmPJvHcbStp5AgoLiVJVjVRUtAD7eup9DubD10/wKxoJaB4H3nBJ8
   +Wc0O/ESKqpAFgtyaHwOMlcnxQHXwQRgtoPodm6EAk/zAPP5Dw1+AxZl1
   Q==;
X-CSE-ConnectionGUID: a5UD5zB5QkCDDbaP6CONbg==
X-CSE-MsgGUID: Pt2dEv7eS8Kgv8e8c94VgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37458818"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="37458818"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 09:55:51 -0800
X-CSE-ConnectionGUID: TxJs6VZrRxeLtY66ZeqSfQ==
X-CSE-MsgGUID: dsALzO4rTHKu6gUtW3yYRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143148204"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 09:55:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 09:55:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 09:55:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 09:55:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSZLaM57HZTzJCDSqlsLQLoAfuVKD/7VXzb4RUMCOEWQkMjtEcKo/601X70i3CLUB5j/n/USgCSzgkNm3rBOJEZjlrmiiagpw2QOIY96lT0uqXdF+yd7qNs05pvrGFYEzScMkyHEciqYphz+uH8yHWjemGQLqXlKnfJh6TWkCmxO8/Y2jG4yCQAf8hFOdBnxXxnfkxvqq0kZYT2rYQk9Yb439Uz2BcaB0YygkNO42SXiltjX5tAX0f/e8TZmYs9eZUkekkbbSFeleRE3ga0dBpn1lIsL0O68IvdcXTv44BDyQmMTOV+Lf9i81PuU37xSQvqqvwMPbJ74cEgXctHS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le1EBAGDzvvhIO47UrFJEKKVAydkd+kpCh1q9Pnipxk=;
 b=cuarxv5zbjCX8UXL3X7tyTq2BpGZt7deURosjKAlhR64iWrDn/hM4G4VEVxevslTbl1ED/Jq8tPmLWWt7nBw4N7zE4icURVbpJIn9ni9AlxmqCzRXt+IdsMEdQKjaE9y/+eHT8fi2lnj3ZKFoi5o3TOZUoSThjNiB5lMejU0gwHw1VUX2gl/3iFXVJFLdxEx7zFlYXBWOhHrnUagZmS+4DF2iu864OFjDOWlw+rKr6KeHLA5ZLvnqm+LnmawU5qCHosHO+Jjg7l4FPxhHE8TdaYxnk5tS91MwSUByPrb6EDmjqU2ptsA5tkrArXhUTlxDxCi4J9iukEtsU0gT1hI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7442.namprd11.prod.outlook.com (2603:10b6:8:14d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Fri, 17 Jan
 2025 17:55:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 17:55:43 +0000
Date: Fri, 17 Jan 2025 09:55:41 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 2/4] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Message-ID: <678a999d1b352_20fa29426@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709423850.753996.572292628436250022.stgit@dwillia2-xfh.jf.intel.com>
 <20250117102056.0000793f@huawei.com>
 <20250117102342.00007766@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250117102342.00007766@huawei.com>
X-ClientProxiedBy: MW3PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:303:2a::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: a6759e07-38e8-4493-a18d-08dd37202991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bDtiBYa3zqNonEN8cFl0yWybt6u22fqaRgPgND7ZIoVDUBcU411P61w8Jxjw?=
 =?us-ascii?Q?uq7bKPBI5Vwta/Wi5D43Vh4QcdWeIv/KpP/n29UXl5pnpfngCSAJY+wd227U?=
 =?us-ascii?Q?fP6sPj28RK59O5B5rD0KSNWl08hFIBaGiB5oOhHJLXyILDWhw3+TSi7EryaZ?=
 =?us-ascii?Q?sYWlUxkiD/nKm8YRmOqCVSrlp2uapumfUyrdknEJiydKQ1j0nrTTuoUm9xtp?=
 =?us-ascii?Q?etnfu5R7LmeKeAYp6dX1ZZUQSfKq4PFoifM6u1mnKhr75mWAG4Tqh3cnpsJ9?=
 =?us-ascii?Q?0DpinouxS4csrhulbYU1JJa8oPN9tuvjJs/kY7A4aEPcZ/VjoYG/R/oVDbP0?=
 =?us-ascii?Q?BxBfvmwGXZ8oK1zkqUZCuLNtK58M1n/8S4OHWab8ZXnGL307eZ+TMDKNf1y2?=
 =?us-ascii?Q?hDbQYHlRZsylxCPXyOpGghx7BKJZjFF7RdaezVKgo2U8NTrGgiLjcdWBCtL0?=
 =?us-ascii?Q?MOlF7J6KxXcxIT0Ip3cKAH/NBUTvs5yapLvN4v9wCujQKg7RfmpM80mSpzLK?=
 =?us-ascii?Q?B0q3C8gYFRYHDtdxQMW6unW+qLE5JHIs8P7PomPs9wXN7yWqKF5mpf6JO/nf?=
 =?us-ascii?Q?r8mzPNoxKBpuIGtrTYWJudgiaZFKUYOHaA4ZcCHIZ6AIa3TQ3IiPNXHXPxZ6?=
 =?us-ascii?Q?dX7ZPFIkBmOLSiagr3YHM8+XE4ZAXxrfNFSA2R+tCJedJhaB1GKTU8jVz5mh?=
 =?us-ascii?Q?h4/JieDZyW2q2rSTsAv3Rj6WRpFoDnJzACfag8HHZC6Ky7gsiXcOFq0CU0Gv?=
 =?us-ascii?Q?b1BYfaAQzbU/iZAhXMVd349H329aG0AOQw+OZGA1FBon+45ttTzvBZSbFiSE?=
 =?us-ascii?Q?IwdYKItotztvwC/NbhuTXITZoOoKL2pZ/7rvAgTzGAOhrgJIKR1RDv+M5JmI?=
 =?us-ascii?Q?0X+PQhopnqtJLZzzvQRxgVIXZP98R+WL8JrztikapFc4iH198s9ZRzjv5AgO?=
 =?us-ascii?Q?qi9i4Y1nRhUC82dRk2P+kRY0gdOu41WaK+uMZNMsSR9nBompMkqPgQlXNedF?=
 =?us-ascii?Q?CqkQP2Z6c4whsfpTAm6ooYNYo9nJ76i2v56El4T2SR2L2WyqX8UPp1qWEWad?=
 =?us-ascii?Q?v7rDeENGZCwhtzeTaNoMVSEWF9OVeRKc2hdZ4nFyc6eEgLS08VWIXyCCMV0a?=
 =?us-ascii?Q?kcrUMoevRmIz1u/0zofzwaMVoVn/DN+77ZZ1Msp0HZJCpr88CmNqqyCam06y?=
 =?us-ascii?Q?hVv2eFJZYWIvMHnSs4DVSeqp94sieWnigcbabM/sKrr/dYw136dNNXJQc4+C?=
 =?us-ascii?Q?ITNxVxgN6D4aqon9/1m6t0nML2KZHWdqFsFra9e8h+21vHlktfskQEfOVDO3?=
 =?us-ascii?Q?lHMpCfQAtKKP+nWpRFYEryXL8/XwJ8F4BRM42RoQwcAM7BQRsJLW6hkT4mOb?=
 =?us-ascii?Q?Q6H6O3VdrWNsmK+Tu6a97vAToHeQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oM3XQKD+lBsFa8rNtTNn4xFYQx9QJY24p3jW7G9HKMXgOt/R4T94HgYYgkCg?=
 =?us-ascii?Q?5YC1D93aEnW9C3yn68eCFN3AHhsxkkhQ0Gvu+cZR/LF/CV+bVOumWDc/UJ+a?=
 =?us-ascii?Q?Gr9RlgBnWXWxCiyTmZEI00pMpYXL3eqEpuFMrX/5h7teLzN8cKb/Vfxi7yi1?=
 =?us-ascii?Q?nNefPr97ZY4+N/277rfw9Iko9bDHWMee7ASKNjNRvwg+c8VvT6m/jYNgCZBK?=
 =?us-ascii?Q?fIWif4t1OW+62jM8UNBfG5kgEx/d9Jc7SfJ3M/5Ba/5pkffvAC0iwDI0xc1f?=
 =?us-ascii?Q?MZOGPnlt8B+C1E42Z5jAzHi8BK/pfQay9/+Vx4XZBOGGDImNwyaE/+PWyrK+?=
 =?us-ascii?Q?6bxMx1//8pOU8q/gvNcFBPbiI6qg3w1Cz7rGwhl6l0GRQugNuDLqbkaQmZa7?=
 =?us-ascii?Q?uyeMG3D+q1b4GgsVV+/oAryG3HOP7DhIyQ3yfRPs4DNw3m/BrSg+vab78n1x?=
 =?us-ascii?Q?xsbzw0MqaeOsnyDWilhB9eiPW682rlqb95RZ93JdxLStmFODw67QOwKpywcc?=
 =?us-ascii?Q?vLWKbRnmnByPrdrpAH/gdLil+J9+gVzq+XtzCSgO6/O4/9KB8Y45OUy2gwWp?=
 =?us-ascii?Q?UVLZMPVmyygvagnZRpGJVwtI549BZdmSxiPQjIqYh56JpexPCK49lOnlElfd?=
 =?us-ascii?Q?OsRXhvC1ATN54mxYZ6rDZQrwFgfqbixH7xaUhSF6mNjvQoNQbz/FBVurkYH0?=
 =?us-ascii?Q?O4kpfPhb3BCYNaiovEboTDRq2EtL45bd81C/qWFmtLmxZUfoBoUl0NlTHkXj?=
 =?us-ascii?Q?sPkWQLCXxsDsy+/bR2iSUEmhYkfLLuoggCjkK536E4uZ3Q7u0jwmiSa+2E7U?=
 =?us-ascii?Q?7n5Q1qcEOBf7CLniKeP7y9crAUh8/oh1nyE8rgk46/Bu9iXetkQGO2Jr39M3?=
 =?us-ascii?Q?x+qHuQmUK0REdSLdsXx8skMh9/Dx783IgoSnVBej4bMrAZ5uc0C/79D1hzaR?=
 =?us-ascii?Q?Ct+o+GzjlzZeFoXzUmUy0dG7A60/nv7ZaipRo4hCDNKej+ZUwroDaYLObOy4?=
 =?us-ascii?Q?a2mxfzEy/8q4GFV6xMP9/lNukwpmrGKxHY4VbY21n/tOBchp5VICnkU/RSa2?=
 =?us-ascii?Q?GOZ1djtK75JlsQp0ZXLL+hQXJo4oOqmF3Bwp0DXjgYTx3ZtB3fB+wjZm0H8x?=
 =?us-ascii?Q?m0UN7s4s3lMBjpX0u9BNe/Nm2H9MnFao7lKdkWaN1h5mJmNHwEo5dvpiDuEE?=
 =?us-ascii?Q?MrqDfvWgvwyR8xO3z6Ry9MByxBXfVUymKtRyRrk32PKJjT03aBdZI6wgZPJA?=
 =?us-ascii?Q?EpfkCrK1nOcI9nMCRiGQ7EM6V/A9MdEglT+XcqG1Eg767YiBXmgHvNnGlzSZ?=
 =?us-ascii?Q?1dDR2PJBQrBVhX2vOntEx7h+JGUv2If55G2fKjs76cXT3aPEC7mW1c0CM729?=
 =?us-ascii?Q?jBxOj9NqtWiRC5JrQM4o2U3IyVJk+VIujU79Lw2Ml6Y1tNNl9Ikzbi6bu+HI?=
 =?us-ascii?Q?+w268cU88xk1CMjtgHXkr/TtCirfA/vPEQW116d7JkFrBX5HSZTS5OwMLxSY?=
 =?us-ascii?Q?+KXnsaGKFMmoK1mAjLjDtWCeoXGqhsvwkbnIxOix/sz5txSlDzGTKJPeeJa3?=
 =?us-ascii?Q?c24/OutH/3h2UHI63ZyBXUjUQgSJ6ZmGHLvh+e3Q9rPqKA3YTvkY4C96YxyI?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6759e07-38e8-4493-a18d-08dd37202991
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 17:55:43.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0J7K3+xy9qrso8aVFoXaUgLsYOy9ueltriz9mxey2vxBisD52jlaZne4GzVuizpeMFwOeZiqqC8qrSJxpbxDbQbdG5kY6aLu4M+FwYNpDkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7442
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 17 Jan 2025 10:20:56 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Thu, 16 Jan 2025 22:10:38 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > In preparation for consolidating all DPA partition information into an
> > > array of DPA metadata, introduce helpers that hide the layout of the
> > > current data. I.e. make the eventual replacement of ->ram_res,  
> > > ->pmem_res, ->ram_perf, and ->pmem_perf with a new DPA metadata array a    
> > > no-op for code paths that consume that information, and reduce the noise
> > > of follow-on patches.
> > > 
> > > The end goal is to consolidate all DPA information in 'struct
> > > cxl_dev_state', but for now the helpers just make it appear that all DPA
> > > metadata is relative to @cxlds.
> > > 
> > > Note that a follow-on patch also cleans up the temporary placeholders of
> > > @ram_res, and @pmem_res in the qos_class manipulation code,
> > > cxl_dpa_alloc(), and cxl_mem_create_range_info().
> > > 
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Cc: Alejandro Lucero <alucerop@amd.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > 
> > I'm not that keen on wrapping the size but not the base.
> > Leads to some odd looking code in places.
> 
> I seems some of the code I didn't like goes away anyway later in the series.
> So maybe it makes sense from a churn reduction point of view.

Yeah, I tried to clarify that was a temporary side effect of patch
splitting until 'struct cxl_dpa_partition' could clean things up
further.
