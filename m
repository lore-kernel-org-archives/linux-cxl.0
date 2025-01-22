Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A084A3E
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585327; cv=fail; b=XvpZm6WL1k9buiHUIZS7XX3ICDlJbHFFs6utpGVtfF5sCjpbg99tho7gJWkUeHOGltaAQW59wwHiqYu8VwundHpILtk9x0wUP/CUx7s4Renjc30kCBuPtEAzI2GrBKbCBTdxWP3aMbUCJFCXgRjGwOBrxbyey36nWtfjMiOpI0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585327; c=relaxed/simple;
	bh=vbtv4Mn74ZYVjRlAAvoSg6RU/JrZGlSFp3JD1kY9DP0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AGm6Xc4Ikzi2kBu5RPWuHueG8INZJid5Xga/5HmaXpFJn5yaMfLc26NLHJUS5iDqd6WvmQm2jfa/6wcAoc2AMyUfeSLfNUAJpXf3qb4apSo9VgHpI9j+511M3VxAaYHWO5lzvyUbxH/5h9SeOcdQ+lBaGUrxqqP7wZHInYX/vFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOoIK75b; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOoIK75b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737585325; x=1769121325;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vbtv4Mn74ZYVjRlAAvoSg6RU/JrZGlSFp3JD1kY9DP0=;
  b=UOoIK75bTRfMiwBxAm45ekU+xd16kfZsM685KBRflc9/cXgZbKZvHUPs
   oIfTmXkHQoWsP/1jm/nAqUnQmAEOpleFcoSPVWBRyfjolGnQiPTjWtrOf
   FVxrX65QsI8ybqZIHxIB2QzkFosTnmf9e2Jum2JaqB/FMjEHKy8H2nANr
   MlhBuWieL8/gv0FrJvpR+cTgmiVuL+HSn7KdX33VO+6qVFCxDijnWqel2
   tENqt1OQ/Eh0Rl2TRgkIw9Jy/WJFeoisCnqNAXL+ovryfQiuDq7euFvkw
   kjpsJVkJZSZyQNtqRgH/3nJzQCahoYEWszg9EyDI2CNKOb1jdwMySBF2s
   g==;
X-CSE-ConnectionGUID: 4iqFBv70SX+rusvHRukRpA==
X-CSE-MsgGUID: tzqgRJfzR3eQure0xArIFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="38318774"
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="38318774"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 14:35:25 -0800
X-CSE-ConnectionGUID: i83V76l/Qwqe8tNEqPaDDQ==
X-CSE-MsgGUID: 83zn+n9NTFejAwJG+4yoPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112248887"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 14:35:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 14:35:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 14:35:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 14:35:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8mBNd4sJIbaK4X7+ys3tyJvfxDrNzA5iXiRDc+d1eUGoPuMlyujvqFYIuLtQM87AELZqfGU93gIKCzym34TyJ32GnBq9IOAydeQWjtLjXJA1Urc1CBkWQeip76n9EkubFlwTtXzBjhWrm1RBW7j7VGrf0sFoJRYJSOjooGU2cWFjWN9m3wCyBS2vY2q+mlnkJ+yHGcAAR/qjCdH46DdcwWP7JbmOKtuw3MmBNck5OtgkTDSb3mzfT1+NamcZt4lZKhTU91Umso/1OVYFEJi5vcSjP8xMC6sxyWD+f86DMvkyuccJ7qKOgQJbHFtLUiG5Yl7RYfACCDIMWA7PJtQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZE/d8wTaCi8XgmVhrG2btgsTyk2IKcqkQJs5C/7+vQ=;
 b=brJ/RzWiUIA9A/exYygPj0vi6mKh5da22QyNx2Xxa/7XOuyN2C3qGWXGcL5su3by2bveJEvn9UHXJU7S/tvAYNQGNX7D+NUqk1Z+ipgLA11tCYQ7JcPcQg2NmJ9vTUU192xVKrn763Bkuop6w2fkZobTCpxXu5Gc2py5x3VSShg3nJfBh+Mp1dAFqUrwFrnIbg4KwosSSA3sIvQf7DiWQBVERKXXVKEC84YxlJkJNkagZ7C1HKMKi1OBEz9HtzLtbv2sXgQY8gg6sWt6StKPM6CgEI7kwnyT/WeAkt4Bfr0kwyMqDihXFdiDf5eEeDVXHjc3QBRyUx2pgH2ZnQJ1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8839.namprd11.prod.outlook.com (2603:10b6:806:467::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Wed, 22 Jan
 2025 22:35:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 22:35:21 +0000
Date: Wed, 22 Jan 2025 14:35:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 4/5] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <679172a7ac00f_20fa29442@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
 <67911d0578ce9_1eafc29428@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67911d0578ce9_1eafc29428@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fce8d20-7683-46a8-8978-08dd3b350e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jAEdVfFOBTKS54EHc5AZqrCKkfn10CtP4ENg7H7+pi47+g4pBGCEPR0d2RkN?=
 =?us-ascii?Q?DC64mcpzD1xKXwDWWcmSnwLT4QXROhbo49DOelRSnQwlRtktNLYiXPVyRvcc?=
 =?us-ascii?Q?04D+Fi6RISG2DbMRPnywGp7Y71t9YHn+zcIGD8F5NO89Ay7Z1947K8OpJ4UU?=
 =?us-ascii?Q?mKK/H4SuFO9TYJMtfuhuRVj0LvnwDZK2ESZCamC1hmMvBcLP2l/KoHfCHimT?=
 =?us-ascii?Q?NjiL6a+Lf1Kt4nw5x76NpBYWW1ZtZlesR6suVWOZC9jCDMI2sAan/WNY2jjh?=
 =?us-ascii?Q?UJT2Plc/j7mTu+zaoN+tIqvmiReNpienfLKglr6hBEZxJB6qPUtoH7n+U0JV?=
 =?us-ascii?Q?iSaAA+W9e7Han6CECkF8+SJZSGrciNkNecpygb0OR1lPDdPHBW+O5Mj42fH1?=
 =?us-ascii?Q?w6h2azx1268YIaJrqPmd8uA7QdDLIfBhUmR9YAEyYCFCgBlcpERfB6AazkHL?=
 =?us-ascii?Q?1zncIBzBKWPqjAvku/uvm4suGsiy2kA51y1OR98/q4vf/rue9WjUGESyM7Sv?=
 =?us-ascii?Q?NOr0tnaWGbrkuiB3KB9SsF6w7Dvc+V5+gmOswsJjPAAOyZ56658xGWe8S9Oc?=
 =?us-ascii?Q?uUH3WxKSADC2YkSGwB46epSh9mfDtsQNtWhKx3Y04i8fXe2aR26PFSxdy2G4?=
 =?us-ascii?Q?l4xWk6YNt+rX/1Evg5DvHxPzELz7qKUzu/9Rjvb+/DOFQz0ESd+tTBX+lYMW?=
 =?us-ascii?Q?jNd4EwMA79wY4dCdz8O3y7ZwgiM54d4tMwZNODaN0+OQGZG6SPm1yTkaUPYZ?=
 =?us-ascii?Q?jxVPgUzvWbjaP+ykf9LanWbG4eYuuFWTKKWy/oPDAjTI7FIQ+jATq1YNVaFz?=
 =?us-ascii?Q?+124GQ2yjxFnsYNF6HYeL8SpUTxc88wO20DfwWxOnqnCvO+uV6yOLGeUF+B0?=
 =?us-ascii?Q?EVt4jIKYsnJxo7fec5wpSjMVpcDPqKCuovVMbczmM/1nEASPTrklTsuAIuxp?=
 =?us-ascii?Q?Hvg+heQB4a05SZVX4kaXZq3TKtJWEqd9Ntf+BiqsGs6hX8Pxm9thE8eXZisW?=
 =?us-ascii?Q?5ZkstuYASRmHd9RRc7prN3oBNPsbpIEK35xbTQV3+joNNCNQ8+4HPZdNR6ut?=
 =?us-ascii?Q?x24WRFShgInsk0t6WY2yaNDi9XbgQ76vUlNJNmwyUMlDhq2HsopDbiEjej1U?=
 =?us-ascii?Q?/NDQH2oUg+3vWWZFKHHHEtSezelXf9UguXH5kXJ4QS0EfHCxA8ina2F0oGjP?=
 =?us-ascii?Q?aDBbKsh7SUXPT371lWNx0ZQW4p+xQ6JBCLimVfDPzc4+hosROmDqxzVpZVeb?=
 =?us-ascii?Q?W+gi/bZP3WzeOXJue+oxa6D9daJ9bx0BRYgotmHFXSdFW5q7RNJkFqswoJk6?=
 =?us-ascii?Q?Uv6Rz+nL9YqAABd6yeP5dVaTsoGN58AwltytRUSiRKDF5S9O6247MIR6iTkv?=
 =?us-ascii?Q?0sm38aTjPL/65Tb+RQAeFs+OYMBW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FLlB6CA7BfDAKrR2FS3ez+en5X/5f3qBLm/KrMKBvOgAAM9aJGwFP/9ebA0l?=
 =?us-ascii?Q?EjYL6qUQfXdK5Y2RdCwRyd/Z4nOXA4odh6O8C7z6c6MUP7EQesIFUT1v8OKE?=
 =?us-ascii?Q?ypPCPrxTOU7itqwhZLOeewpvQo8s3/bqItKCeoWeyaZr4YwaBOR2V6RHIz6p?=
 =?us-ascii?Q?NEar7bWyZDas/S3BpgWpmqdbG/RqAYMOdgIOhqYP6a0hDbCrHEcyawhgwRAM?=
 =?us-ascii?Q?42U7bbbqNDfQPmiXpzZlqPUdC9EZZK3u3hqJ7vxzmjt25THKZHVCsCtpIokZ?=
 =?us-ascii?Q?b+5H6m75Ky7g6hMiqyHUdcSqrbiTwSUnGOUeifHVlLIzeJyGlHxhxbw7Qh4N?=
 =?us-ascii?Q?zURYZbFKxjhz5b9vCrJSODMhbL16+aPJez6iSPKavOamePanO9evG6rR6Aa8?=
 =?us-ascii?Q?hofOV0iAy1iQz6kIeeVLgr4otDYk7S0knc57pfCuAImz4cNeSZWqvku3UrKK?=
 =?us-ascii?Q?B7XnSpoNEBEu/Fj2HEDPl+TqLpLnyi0o0zSDEn2LKKJki6usTsuEZgry0yFl?=
 =?us-ascii?Q?qbx2ocKNJG6QVc172Uq59bauL+4gUXyUCcv9rTUlaXpuoOxDz90UyvA2Up3G?=
 =?us-ascii?Q?Ri6RQyxCXvy0vh2N3gnOOrQbpwCJKYYN/wGSD19nOAdy6Tq3f/zMRE62hhcK?=
 =?us-ascii?Q?sos2lHph2S0r0gfbGdTc2W1K57D3MXsO0kOpDqZh8iArf2WASBXE9WJl5q4b?=
 =?us-ascii?Q?KOdGwAEj+EvxhFhWEAiL/FOSJ84IH9HrBzG2ZUWMZN1nUwo7Qq0QCVMw5nZu?=
 =?us-ascii?Q?qQJtK+HPMCAL6hIZcgwq8yajli3+l4CnRTrFjrVy8ElUkoPdjrIqsokqhzDC?=
 =?us-ascii?Q?gsRcCtQluo0gB4BVzk+btcaw10wiQeJ6pBljgFef4VYPZ1hbU2DW+PnCgvt5?=
 =?us-ascii?Q?PF7mRUjMQ55gRLNzKj1AGKe16M+jcdOw1mBp1qmMzWYUaKPgT+hDDSasqPk6?=
 =?us-ascii?Q?ZUgKQnGH7BW11FtNbmByb5Xm8smiAItK3l9GSHbyfKkMASdDthO00nWqGbi+?=
 =?us-ascii?Q?CT2BLNYD/qxp1M4yRuuLlvo2M5l4ebP+9E331MoJsmCzZDLu9gvLvan/7mfO?=
 =?us-ascii?Q?vP5Oi3rejg8mtp96Hb1vKanTtG9VRf8+Lf0sgo3sC2DDUIHxVedBiqKDXG0Q?=
 =?us-ascii?Q?Zcd9vU0p+OlI8Hu/TjGkTORxe4alZr3rXQoysHx6YfYtJIZWrPsmsl4qdcn0?=
 =?us-ascii?Q?PzpldkUEM9t8Q4JpVtF/yI5i7KV0Vk05UVGx2MDVVqqjlb4C1Eijv7+xfslm?=
 =?us-ascii?Q?xas6FLEyAIMHhITDbQF+vvAY/0AHwlc1Y8Q3zB5q6kFvS7XdOxi2qcRCK38Q?=
 =?us-ascii?Q?ySGer324dXdQ7jmHNYwLXo/MKlw96avxp9VbzPH2+5YpUqaCVNQc8fuaE4T2?=
 =?us-ascii?Q?f5f7bDlcgg3D4mdE/WeDqTc5UKRnCOCz//wYlogh6Ttm504dcwAw9bVtHnlj?=
 =?us-ascii?Q?lj0NcHno5ypJ2+aRAdOkX82qYJCQDB02qjlxUQ9hGut7T6t//WNhFPxi/gnB?=
 =?us-ascii?Q?8LqTRVLpDTf9nfpeKAgqn8pTNKd8xQes8AE/9pW65l0z3KiYa2ow5X16IeSG?=
 =?us-ascii?Q?14XhQ/lkw7Nvig/Ve0eXfzhERaBurS8Q8j4V00CmnOwZkXHyvKHVIKq2FsOo?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fce8d20-7683-46a8-8978-08dd3b350e56
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 22:35:21.7680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7875kfRxQ8yhEA0WgsBn0zH0QgPvmqleOlSZwVC/enCRP4H3K2lvmyqZL8m4KDb1Vw1oa+pDIWX6KDuczKEAM8qCYzu/L88RqkyJUASFSo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8839
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
> > allocations being distinct from RAM allocations in specific ways when in
> > practice the allocation rules are only relative to DPA partition index.
> > 
> > The rules for cxl_dpa_alloc() are:
> > 
> > - allocations can only come from 1 partition
> > 
> > - if allocating at partition-index-N, all free space in partitions less
> >   than partition-index-N must be skipped over
> 
> I think this is a bit deeper.  The partition index must also correspond to
> the DPA order.  The DCD code verifies the partition index's are in DPA
> order when reading them from the device.  Therefore, that code will add
> them to cxl_dpa_info in order.  But general device driver writers may miss
> this point.

We could save them from themselves with some paranoia in
cxl_dpa_setup(), but as Alejandro said accelerators are typically
single-static-RAM-partition devices. The risk is low that someone builds
a multi-partition accelerator *and* builds a driver that messes that up,
but I would not say no to a comment that notes that expectation.

> [snip]
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 3f8a54ca4624..591aeb26c9e1 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -223,6 +223,31 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
> >  
> > +/* See request_skip() kernel-doc */
> > +static void release_skip(struct cxl_dev_state *cxlds,
> > +			 const resource_size_t skip_base,
> > +			 const resource_size_t skip_len)
> > +{
> > +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> > +
> > +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> > +		const struct resource *part_res = &cxlds->part[i].res;
> > +		resource_size_t skip_end, skip_size;
> > +
> > +		if (skip_start < part_res->start || skip_start > part_res->end)
> > +			continue;
> > +
> > +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> > +		skip_size = skip_end - skip_start + 1;
> > +		__release_region(&cxlds->dpa_res, skip_start, skip_size);
> > +		skip_start += skip_size;
> > +		skip_rem -= skip_size;
> > +
> > +		if (!skip_rem)
> > +			break;
> > +	}
> > +}
> > +
> >  /*
> >   * Must be called in a context that synchronizes against this decoder's
> >   * port ->remove() callback (like an endpoint decoder sysfs attribute)
> > @@ -241,7 +266,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >  	skip_start = res->start - cxled->skip;
> >  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> >  	if (cxled->skip)
> > -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> > +		release_skip(cxlds, skip_start, cxled->skip);
> >  	cxled->skip = 0;
> >  	cxled->dpa_res = NULL;
> >  	put_device(&cxled->cxld.dev);
> > @@ -268,6 +293,79 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >  	__cxl_dpa_release(cxled);
> >  }
> >  
> > +/**
> > + * request_skip() - Track DPA 'skip' in @cxlds->dpa_res resource tree
> > + * @cxlds: CXL.mem device context that parents @cxled
> > + * @cxled: Endpoint decoder establishing new allocation that skips lower DPA
> > + * @skip_base: DPA < start of new DPA allocation (DPAnew)
> > + * @skip_len: @skip_base + @skip_len == DPAnew
> > + *
> > + * DPA 'skip' arises from out-of-sequence DPA allocation events relative
> > + * to free capacity across multiple partitions. It is a wasteful event
> > + * as usable DPA gets thrown away, but if a deployment has, for example,
> > + * a dual RAM+PMEM device, wants to use PMEM, and has unallocated RAM
> > + * DPA, the free RAM DPA must be sacrificed to start allocating PMEM.
> > + * See third "Implementation Note" in CXL 3.1 8.2.4.19.13 "Decoder
> > + * Protection" for more details.
> 
> I think this is a great comment here.

Appreciate that, never know how these things are going to translate.

> 
> > + *
> > + * A 'skip' always covers the last allocated DPA in a previous partition
> > + * to the start of the current partition to allocate.  Allocations never
> > + * start in the middle of a partition, and allocations are always
> > + * de-allocated in reverse order (see cxl_dpa_free(), or natural devm
> > + * unwind order from forced in-order allocation).
> > + *
> > + * If @cxlds->nr_partitions was guaranteed to be <= 2 then the 'skip'
> > + * would always be contained to a single partition. Given
> > + * @cxlds->nr_partitions may be > 2 it results in cases where the 'skip'
> > + * might span "tail capacity of partition[0], all of partition[1], ...,
> > + * all of partition[N-1]" to support allocating from partition[N]. That
> > + * in turn interacts with the partition 'struct resource' boundaries
> > + * within @cxlds->dpa_res whereby 'skip' requests need to be divided by
> > + * partition. I.e. this is a quirk of using a 'struct resource' tree to
> > + * detect range conflicts while also tracking partition boundaries in
> > + * @cxlds->dpa_res.
> 
> Another great comment but it does not actually cover the DCD case.  This
> is because in DCD the partitions might also have skips between them.

I think that "just works". The allocation will be bound by the
partition, and the skip is calculated from the "end of last allocation
in a previous partition". So, the distance between "end of last" and
"allocation start" will naturally include inter-partition holes, right?

> That said the update should come with DCD or if type 2 devices may have
> the same loosening of device partitions.
> 
> This is a good clean up though,
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Appreciate the quick turnaround... I will endeavor to do the same with
the next DCD posting.
