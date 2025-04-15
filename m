Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60C2DFA20;
	Tue, 15 Apr 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752584; cv=fail; b=SnxWcwSBgs19YRhslR89BXCLF0l23Pk7RRMG/8o42QCQjeDdNz4XHEHrLy3Ce+NseCAGcwSv0Da0y5RdsbXLWlFkndpaYBoZxlXerlw7qCbkyS2LsFpxfRe/KNjb9mSSL4JzMt9Tv10ePVKeCftQiY5Am+tLxEMRtVMZxOX+bXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752584; c=relaxed/simple;
	bh=8hvOxXM7Y1LrHSkha8FAtO50f6QFmf7SEDwErK0OHAM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d8+8xaRXAtk3sa8EHWSFANsJugqs2DIHsrYygh1njuOVMwlEcgvhrv7ybTukf2tG5goZRhN2BM79DhjLmIPQ8NoOa4oqpbaxgZaCfRxH4Oq0PyQrt/yezat5zPptuwwVOAidxgVlpUBT5VLAXjh24jcZ7eEVndptF1rSqwarAqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjXL3p+q; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjXL3p+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744752582; x=1776288582;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8hvOxXM7Y1LrHSkha8FAtO50f6QFmf7SEDwErK0OHAM=;
  b=WjXL3p+qVSlYiqGm6qUzvUqHnO1kyYE2SXcbeVDsX4utan+8dD5Raae5
   Ei7suPSfHdQfEwkwVALDVUJ3t5OIHnt/1Hizol1wRTBBhDvfd9+yjUYTx
   S5TC1auUe/YyCgQENmLHYb/EdXxpDvCoK8nQVxitggV8/ftM67MdY2fyD
   A2FzyASPZvro/gWKSsLA8J0QW+kk74thB1R2g4fHXHlnKpaOi3PifeSPb
   6OE0P70FmTUkyYpQoDGPfsqOPZvaRy7gzjz3W4gB+D84hpwGKX0BP3JZy
   fS+AfnmLaSkqaEIceM+9rlwHbkJB0RSQA3gyxtGAH4AeDeQrTL1xckW0+
   A==;
X-CSE-ConnectionGUID: ggIxKX96RgK10/tymZ+clw==
X-CSE-MsgGUID: NzKSUzZeRLOrepX2hZBNBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56944966"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="56944966"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:29:41 -0700
X-CSE-ConnectionGUID: lnbu7J3JTyuWqmo5pkJSmw==
X-CSE-MsgGUID: 3XIl8g1DT+SjrCrrrpLtJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="134355461"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:29:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:29:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:29:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JolEukvkkUpvi9wFZI8ugmLppSu0dhXK0DUYkVyxPG5b+WAY3YOvKciTJaW7AcZ0jFxU1KAyo8dnnw03SDVORYWBFh9Re8tBXFYfStMpHHf52wnBTVyjZwVOtwyJIx6QQeFGYqU/pOTZcxoguQXCIL/jn9djG3alXGKsx+Dz7NA8CeBCBgTOo1brAGBiruqn4j2RF8cjuYAs+Xlzkq6LEn+Y9URB+jt086hM9BNFtZi14iO+fVEMnG/uSz/ZyPIIJ4sf76RNISdbkZQKj7jF4intGCdvustB8O7gRhYJhNSbQBDjx9MJxAXmEN2l0fzac4E9ULKNRCj9PC51qWr5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adRdjFWQR0M73cDx0a6b/C5roxnTjMKAKfDY38R0pRI=;
 b=HRbRasrmipw8eoGZBR5Lpg5/kw5b9CClSh/REzrZzrNAoH/tWnDzaSwq9RWuvxpJfNAD8KgtLgxpoQJKyPuxXlEhYb0zW8BlixgY0rfslEAeDSx8snJ/thGvNEkdQSGXICAkxs3fApJzYNIReuxzGvyadYn418uG2G5U50ParnSTsrxRERIZrrWYQK+vpwkKUq6VShKuSlgADeCXVaeLRZoobwMZLGSiiR9Im4MGtj33pRlcpndhGz/pCX2wuo4VRewpX9KVd7oWFovTwJ6CRLf0UAB1eVW0snkl+lxeWrd3sWMmLTKgXNXm/I0PPCcEZOrOSI5+vuk4IBXVPAzbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS7PR11MB8827.namprd11.prod.outlook.com (2603:10b6:8:254::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:29:38 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:29:38 +0000
Date: Tue, 15 Apr 2025 14:29:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 02/14] cxl/pci: Moving code in cxl_hdm_decode_init()
Message-ID: <Z_7PvuqR_C2i6tLk@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-3-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS7PR11MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a17039-95cd-46c3-61c0-08dd7c64a012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?89gxP3LKYlmsbPzrJVLd5k+YB2rUtZmup7cW0gNJlP1PYzuIYHKIkiJknGXN?=
 =?us-ascii?Q?zO4ZsK9FvvF3JDLFL01T6n4YGv/nmtYQR83cd8J7msI7Isj78xQfnDkiN/xF?=
 =?us-ascii?Q?pVh9cPQa5Ab0BiLhBPy8JrId6pbiDNM7yuYpgYRqsc+X7SiNdc1CYGhH9hrP?=
 =?us-ascii?Q?d4P1wv9/2E+L14c8F7h+CP/Hr6HVC0jmXun8otYDAICyEnfCmlB2etOgJ9oZ?=
 =?us-ascii?Q?omMt0mDHSkMsEqfhmxS6qKvVSqgSe+l9K1TiZxZeFd3WQCsKl+MizUoLR3+v?=
 =?us-ascii?Q?EVWHTAZ6tFyWWBImh2NlSa7m6s+zqZQhHDoxLk0tiUuyukc4xY5/gP4vBi5i?=
 =?us-ascii?Q?wVplQrGVYQg0LRaGl8knJ13kUfDFtSwgyroQqtH96JhfcuM2W08XxTJBt0+J?=
 =?us-ascii?Q?vsR0505CkeorUHXDMNjVbe+3hfVj9pQ7dqglOuKp87LG1X5bvFf/03t6AqM4?=
 =?us-ascii?Q?0CASJBM2vMoQNU3xgyvU9hKVZtPQlq8oYXxkoaW5yaTQt8Y88yl4MGLnhwgh?=
 =?us-ascii?Q?eFyt27Y0pB/V9RDhpC/+nElHObgkAHmaJ/5kzeZSuFOHqRdJHGXd98011f2J?=
 =?us-ascii?Q?T+CDFMDiFSh4msylMrrGpweHlqVm+xxnO3++p/2LKaTDxM159a0OOwX2pcJW?=
 =?us-ascii?Q?ZGbgrRivRRlQXjf3vViUIjtj+2oXsEcAPUF6i1LPPy0Vh/yirPXNkjicIM8R?=
 =?us-ascii?Q?4HRCzKiaJCdkDS59mV10PMkGmzq4sgr1dUPk3EHVx+ASINdPMh2M/xEAmxHL?=
 =?us-ascii?Q?tP2CT8fOycTF7eCdxRnHi8iTeGIycpyZFoEG19rvTb7XILfBgl+AG0iTATYz?=
 =?us-ascii?Q?K0tNHvMLXdW3jGhF0tuU729X7gP9MPU4VuYDBoYS/QRU1i0+Q31zPOlty88U?=
 =?us-ascii?Q?8kiacZLPlkUi/tEpf2/JYNUudjRRWIY1OZ3+d/lSrjoBu1LRLKkcdZcrduW0?=
 =?us-ascii?Q?KWOdd0eAWDanQtvZZ/+k6XH/V8FyO1PAXs5COuVV/Q2zKkBu2lcW0LJmDoXp?=
 =?us-ascii?Q?SNiI7ieR5HXfyJEMB9E8NKzrhtPX2763F6p0X7WN7h5M1bP2kRgj8EirmLsM?=
 =?us-ascii?Q?k1C5x0rYtY8td0yP8HXozLXxPBNVyFiLJrzt2YMjN8zMmGk83PxOyuAa6Tv6?=
 =?us-ascii?Q?wD5ZrQIpNSJeQ0DfZShbrwvxueUmTiYAFUMUdB0JA4rq3u/InNHFh5cg0zfw?=
 =?us-ascii?Q?Xu5d3NNJd748aFbBIla5QsIyZ2OKB6WfHm5Lcng8pWAhi52Chbi5UzshlvKd?=
 =?us-ascii?Q?RoxVYh4PGuxpAkk9LNYccVqJO6CybShvroxwXR/jMNsi7yBHpdyLH6ixsPoW?=
 =?us-ascii?Q?Cb1ArMSwdHbbquseO2srXJCYlk7hZ2mmiEpp+lNq7ohbgwjR2mk49GzCSYzs?=
 =?us-ascii?Q?WEgkseCbr8Qa6wjs9yAo9rrnJFQVoaUIwFwVcCOBlz1Q91J4npoJ15ch6InR?=
 =?us-ascii?Q?bQOswlM8g4E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zw/mMnVVmSbIGwvTmgdTEQD46ODsd3LjMmZpUddBmk3ScUjk50q5QahQ/oAx?=
 =?us-ascii?Q?lqFjGMNXO/Ytrjn5r3j0yHvT13Ye9PrjSYFb7WRRinr0JxFh1ftrDKG2KvJ3?=
 =?us-ascii?Q?us5gLxRR/5WgM6WQKMqM5wiC458ZK9Wni/ozA0JvJzw4oTbOLgIgA3ock3gW?=
 =?us-ascii?Q?Nd11nttYW+m0c6n2fOMfrtxRPEWDKo25K/dEmmd/phNk9MvFHHx3++4ws79F?=
 =?us-ascii?Q?M3wPDe2YkwuFqwcS3GJ6UizpnhXFv8J+4/lFqnyxfr5uAE9Yrh+8ic70/hHw?=
 =?us-ascii?Q?1Nat3ymFC4b4O0kb8e78CMjaTxApa2dZD/g804yN0QAFN94PXiwuLL++e4JO?=
 =?us-ascii?Q?CvvPNIIY4uzZDSYWURvxT08JRwsJYZnyiYaAQVqZ9Lb7rpV7Wiwzs9A67g0J?=
 =?us-ascii?Q?wzwziUxg7YFFzD7+40P5nCSjZeYRwbHJmhdG7g+/cFnzHYRDnW19rIiPOGwl?=
 =?us-ascii?Q?wzRg5A72/o+RTn++fkephaxWlVWESzSD+m0U/B250YUVeKcXhMxvac4g6EL3?=
 =?us-ascii?Q?deB6KctuQNB6ZHqFP6EcQdcL/qiiyDIb52C3u7KAcU+bmfjCMVNg9PyeVcJo?=
 =?us-ascii?Q?c7vtLHEGOOMg3+ZlSx17ZPjqaxtbmljeDrg1XIxtKlJJdkA6gvFTWODJ6ydv?=
 =?us-ascii?Q?7exwJ/q6w8g52JGSSdW3O98l34nzJeUQ+6eq+by3ju4LO6/87SYN820w0dWA?=
 =?us-ascii?Q?3bfLOn9NUvcDSnED8boKyieeXnTDaJVRwX9J+1Y2tIYfR25wrOGRIyVubKgM?=
 =?us-ascii?Q?xORquCstKN7/eyA3LcqID6GL3IRy/ez75zmRY4foRY+daTkBzYZhhhXyTKmu?=
 =?us-ascii?Q?/ANmKCYgK4UtpgI7z0Lzj+/fDVTm4Odi6nZZufnZ9A5RIfrLaIMYmgL9THX7?=
 =?us-ascii?Q?NqaEZksVrzfvVKL7KEQ6WroJZYV6uMTXbRxnhd0cPbFxsQmwobkNLu5TVqlj?=
 =?us-ascii?Q?PG5f5JFkMHMbf0DPUTQ3uZzg+iMed0e5nH2IWpDwLUxfpbQQOPEwDTQ7Hngr?=
 =?us-ascii?Q?29Zl5AMsWwGLAi5J2Pgr9EBi7jFuu/fRFL++96wF8BwU37nhjCwb8P9SPiBK?=
 =?us-ascii?Q?6q/31M2ryYoApNO872fhqsbgSfqvLVO/aZ3Sl6xRu62HK9Dxgi9dzP86XHhJ?=
 =?us-ascii?Q?IKUeD1QVtw/ngMQI8aY93Jt5Hy8sKvzrEwgjsZYVYSBgmeTiWXRu4fIu71YX?=
 =?us-ascii?Q?JyZZNBZqORiZXqMiCJQMLN9HZpNY4FPV1llLzG6YfKb6TXH/gqN/c7hyMC0n?=
 =?us-ascii?Q?pvuVlEWL/VnTpOyNmhezyJTb18ONAEdnu++HNwOSMP7Ticr+pQP4V1nrSXdR?=
 =?us-ascii?Q?oYmq8TPXNb7dDCd5xRK/PE67AK+eAEP5v38WrkiqEg2lmmFyZvHJbxpb9qP2?=
 =?us-ascii?Q?TTY8wNxZ5cSEd1DRTz6BAX5PYs4J29g7n27STCm3PAJsxI7AGO1HwRajceB6?=
 =?us-ascii?Q?BckktrOE7J+avv0v85fkzuzZ9vO5p6gWVQ2SvTk/PJ1K+fT7vt+x0YmxgGGs?=
 =?us-ascii?Q?BEZnP5Q+ai0PEZSskYx/I2YfP1W3CfiHpolWUkIwn+3HCBCkkIMGWnIDhOht?=
 =?us-ascii?Q?notzV3IiUs0uzvNBLcWmPhhNTSeNNYHkhRvhG64L2NmHkvFXmbxM3wH3GNLy?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a17039-95cd-46c3-61c0-08dd7c64a012
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:29:38.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPnvy0z/pBd/KR023PH796ZhHtN79pDispqX2s3RL300jX8RB5Vifvckoyr66pcplrDQkKZhNKABu/4Fe04ClnBlbbrNK9ByhSchbhgymJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8827
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:36PM +0100, Robert Richter wrote:
> Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
> cxl_hdm_decode_init()") changed the code flow in this function. The
> root port is determined before a check to leave the function. Since
> the root port is not used by the check it can be moved to run the
> check first. This improves code readability and avoids unnesessary
> code execution.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
