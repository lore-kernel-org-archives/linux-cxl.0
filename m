Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228C2B9AF
	for <linux-cxl@vger.kernel.org>; Wed, 21 Aug 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277682; cv=fail; b=gGSvGK+1uChKjCv54zKIEovXnK9BhUfzySqWd8mh0CEZ4O5GsmlwdjiQ7lTXcALDyck9KBVsCyys/lAIl4Vpng7YBjlQBWsPu1wxXVm5iU6odqLtcpgvwUexskhWcZXV5oh9SnVNiPSxU+ByaPl1zwfqcFC3iBoFiLm3sWRJNKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277682; c=relaxed/simple;
	bh=2qb+oydCjAH9t5yJQBRGqwfwjOE+Mh7NLBZasR1uTL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QProPguKY96b3LzZnXBK4i1wdcwVtHzAsq4mWk0Q3lek6IzEHmaybcdwP1bIOxYIumh4QT1PQq/V4Y2P5U03xh/Rj8hw95xDmyj8Q+KjdYHuhDqyWN8gDRIL5Sir4KT/JVkQGRthECFlyrmhZcjc/mqzq9ZX6qHheKkEmRS+2Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adpXhA5V; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adpXhA5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724277680; x=1755813680;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2qb+oydCjAH9t5yJQBRGqwfwjOE+Mh7NLBZasR1uTL4=;
  b=adpXhA5Vn60g3I/lL4bkXjAjpUA9LN5I3arNwNiejDOcGsLjIiI+buwM
   s3/mMzda67/MsSsS1UW0R1QutjhJ1TnvRUC0fonAYyA7kIFjNq0P+KCVA
   ALLfacWcWXjvDyMHiDN0jkY0rN/CTfNeYmY5IVm7E2q5M50mzQI3GdegH
   4pzmVeJRXfbAwKsd6gD8j9t4tydN3BUeRHKxxLGmvvVxkpiXNyy+ecnaS
   jboq130wiAVr1OS8YZac3L6dqW50k8r4TKj3y8k1PmZDe6L5e0jjGInz1
   fSsbKmnrGAoSkYeoKwzfqd9uFRHTL5AQscoTBFPIR3eKKB602VKGM1dqm
   Q==;
X-CSE-ConnectionGUID: vHL0of4SST2IArFBarKGYw==
X-CSE-MsgGUID: D4BTx8hYS2iPzEOr5VCigw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22475759"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22475759"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 15:01:16 -0700
X-CSE-ConnectionGUID: vh4U8AnPTVSFcZMgy3L1Tw==
X-CSE-MsgGUID: +SbjgF4kSAC3tiI5NWwFqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="92011923"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 15:01:09 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 15:01:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 15:01:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 15:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WY9fSVSTICbHSxUq2FbJxOit2y805ANXQWGfpyl9xWbGVgsR0dt9+OqIp0QGYOzLcdnx17JdXL3PcfneqrVNx2MCdLaSHN+1c72D177DFLB12jNyEqBCoOi47A+G6lBSKG4XPwloFcvkCKMX+vlTNyU2y4u3cwQTHPSljaYCEf1DK1mxGm08J3+Gdj3wIZIly0SCrwgnrjxHIRmar624J1RDKIYHK/Ss56ZNbHDtnRzjF9Qu8hEqMKNcZF7u0u1pbJkxwh1OLuvJA2zGOQ8pFnjCFWda6woxVoDduO/YwE57kvdHFbHQOApLjKRyTqKdtbAi+GVl1qaI7uiei10m3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RnuADnENCXEuozj9U2tjy390ja4xTfTG7aGcf59GPg=;
 b=ygA9fo++DEOz8CNi99QNMgOqlb99TtcU1VZ0HOkJmbglqmTd5dzdn9dVUeEZ6svJP4rr9+sMIHvK2UzwnexAlsSG/iVJ9LPqND75g2O+GdevgOFyJtB6AcNz0Cn1e15OprR1LdXeqGJzX94Pl7aOD8VMUHQDpgk32+QjyIzTvYSEKhvUkm4plnYFt0lQDoGJZ4DH/MhW6d3wpUHjfIkf3d/NxSIDQPC8rSJMpOzTAFfbWW+PWEmpY861bcGbQ0zrqRgmvcHpZL5g3SDDvIQXqH7r20o9BveRkn4CZcua2IYOekQsfQs9XEZyQ5ZVeFeRqlhe1h+Kuh8Sw0m5seWePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8188.namprd11.prod.outlook.com (2603:10b6:610:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 22:01:04 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 22:01:04 +0000
Date: Wed, 21 Aug 2024 17:01:01 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming4.li@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Li Ming <ming4.li@intel.com>
Subject: Re: [PATCH 3/3] cxl/port: Refactor __devm_cxl_add_port() to drop
 goto pattern
Message-ID: <66c6639d14237_1719d29489@iweiny-mobl.notmuch>
References: <20240813070552.3353530-1-ming4.li@intel.com>
 <20240813070552.3353530-3-ming4.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240813070552.3353530-3-ming4.li@intel.com>
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f0310a-83ca-4a20-1707-08dcc22cc08f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NqpTSutoSmcc98wPfOnth1f1gUCJ0s3uQHzH+ewt3aBefCJYdzLYlvIhcJtT?=
 =?us-ascii?Q?g/LHqDaITcgKJIduq4+9tw2/Sy/ZnXmO62eXMoVeCD06SUA8cgqUt4NP36Dv?=
 =?us-ascii?Q?ptIxrNCEONIfj7tFZ7vTX0hZ2BfFQaBeTAw75TbcpCPm7/sfLEMPAQe+LHvT?=
 =?us-ascii?Q?IrNXOnNPId0wBDY8LUnfVmpkHMf+tk2idWZdnOoM2l06zU+7ExwdEG2KkLpo?=
 =?us-ascii?Q?J1Qppu2AmnjSH6E6aVer1Bo44ItbbuqpALx4spoVRBDuqwCPs4RiQQ/jur8f?=
 =?us-ascii?Q?CY2mFPAjLAZCjsJOwAklAOmu1hBwfHQ1ukmcnRYScnIV5Glv59Zzy+AwpFHj?=
 =?us-ascii?Q?3wlWUl9jTrhcwkF1lPx6gNhQKzKAY1aUBuug7DcRiWvc1oVH9kcy5Li8o3qL?=
 =?us-ascii?Q?nTPme/TTXrLfKAuT1wNNSCnp6jmRCbuzuwa9/kIAUQqsj/apAytpBMJrWtVE?=
 =?us-ascii?Q?YHcWMta4V8II6vAP5Ox79taurdPDfwN+Ie3r73dBFtTpWpDzb+1Ym9krHXUE?=
 =?us-ascii?Q?dd+X3wIjCMudlBFhXqU3NGHy2wxlN7fNh1Z44wgBlB+WTqGuTEc2/+3QSvwR?=
 =?us-ascii?Q?dFkBzrnO/CgZOp4XuGrtbeJ1dLI8HYvLFfonXljrrQq1FgzeaN+UAEPjsGJw?=
 =?us-ascii?Q?XjgEnBYFFKY/NrYaTNmVFPrUpE0vKPT4sJDb1Pg82/2nIcKBK49cvP/xMGKB?=
 =?us-ascii?Q?J2q0Un6HpEOjgmWjR13tVwrh5nEWwOiJZyfeGz2V6GRc+kL8DEr4A0Esza7t?=
 =?us-ascii?Q?9GZnUPFmpLXgQdE+WQRmwI1sIAgvK8K6yf9zAgUEN/NhBI2aanCIVVLZo5KW?=
 =?us-ascii?Q?kgRIC+pNKJsk+IgJG2d90jVHRasrsBCUpiPA52mTz6JpJr6px+YQFnbB/bG0?=
 =?us-ascii?Q?aL4wTRXxDJOHWuqMqwWzKvw5N+QudOi4vFqkLnHZzDgDye8yClmOITyOt49M?=
 =?us-ascii?Q?SdNwYhIq2mmvG/M+eAjFSg8YUy/QKuxFW5PhInCpz7SrKRnz+eq96uU0UFHz?=
 =?us-ascii?Q?er2R736TSE7dvobBJSWxoiwbUe7U2h9RXNVMZx7YKUC2GcY2FRpZekCgOZs0?=
 =?us-ascii?Q?ALkAscSjfBeBO0bLzhg4IpMm0Z6O/wi3NemXBfCUdGVvjwpKZx8FhbDzbdOj?=
 =?us-ascii?Q?lMklovXyjtx6CccF25U2IouF18TlxiH3jbY4QeBTHwYZUKjpCZ8hjPTuMo7K?=
 =?us-ascii?Q?zYfrQ7+CQw4h2ZInxRD72o5OF1okcwVi2lLtSQNElM0g8M4Fi9Xb8r3Mjx20?=
 =?us-ascii?Q?4ooyqSLqRPWM+tJmywwr5ZGQz9PzeG7uoYzJjUdWcLBqTNbMN5jx0Fpe5AAN?=
 =?us-ascii?Q?a5rFUL5BoCGvLz0U9OMg1kT+6N7AOVyTNYTf0dtqA5fU/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7soc2GIYNLBu+JXNShZmdtwiRJTzS9TN4EdwgBvMDGstz4j6o7Tu4yP6s34K?=
 =?us-ascii?Q?V9aKR6X6aKy/c2rQyijhZEbswow/ZG0UBzFNrQ2mwNtvv962pi/IPl9f2NJb?=
 =?us-ascii?Q?VECcKvrZ9/K4+Kjjy4ZXGVRpqXSjm0uOdXtFA/p/M6C9tCVHEa6L3K97vhvt?=
 =?us-ascii?Q?PVJ8ahuhzBgYm22yrrYenNRWQVyxRKqy8HEN5g3fKWymTDAfdmU/107yO1cR?=
 =?us-ascii?Q?D+JvwKVGxX5U3Ve+EtvKWDSz5/ZPzKfzGPW1VDmdsPcRff2trIQ6KRk7Tgec?=
 =?us-ascii?Q?mMWpa8YgHf7PQEZGCOYLxf58k1wplIwTEA0VVM9rmbEFUKZ5SHnGKUAyeDeL?=
 =?us-ascii?Q?vEPSArScFKGaDNPxW7mq76ALixjU5yqbpm/q38/UcwW6qO0fgjvTj2qC5fCL?=
 =?us-ascii?Q?LqMQTBMY1bg1FMyQRGsKUw+CA3KL9oANlO7D6YDjdddWGhZuIJz18UYPj981?=
 =?us-ascii?Q?5VhnD+DA7O1Bc0zFRv1vx0IwoD5WF2LoIctmYcd+DxycO4j6IASE9FWjqLRC?=
 =?us-ascii?Q?5mEfJXL80pLdrwvZHd60y+S3byg80590Y7sdqQz7KA0SMYGYdjfxPoB3MiIL?=
 =?us-ascii?Q?zQuk/K0v6B0CkXRTKfKAkpe4Nxkn9ifFmDsa92SAZXy7pLt6iKstgahFixqR?=
 =?us-ascii?Q?gv0psplJmoH/i8CKfkcy6Xwvl+wlY2IzVOnbQRa3ciVtINgKOy/sW/fr++6I?=
 =?us-ascii?Q?VMMgpE3pyk1G7KzbSF2lnvxZ78UJ+hQTQBCnEHPbbJF2nK1/PpQ/CmsMZA2+?=
 =?us-ascii?Q?evtrDDoR2McluZ8cg6lSvsyEgpspEE3Fz7mCNWO4idnglGr6c/rIOMkUTbRd?=
 =?us-ascii?Q?uj/l4EfY2lKCKvtbsnZpKQA6sYLcwNlYUEj+Sx0mJNAqK2G3vjNS979QaWCd?=
 =?us-ascii?Q?2GnaocsF//pwkliA6kWGnJoz2wKq9yo0TzY+vWO2bR2KvlItVnV6m3ojjukx?=
 =?us-ascii?Q?E/0EFB7yTA7EuCbZFEDNlp9PZnTRO9QTfPnm3zKZSjibQkgWVmgDKM57Rqqw?=
 =?us-ascii?Q?/B59tpsP64Uf4r+6BeD8f1X74cvzBNuY4udd2RWh1jTzxwgrYR4UufN2JSi6?=
 =?us-ascii?Q?1QoX35DGUPUDR5QcK/tUyq2LzCRN1j/4OMmoj79mD/Fy4YU32lr3cbN3B4iZ?=
 =?us-ascii?Q?SugPcVLW3u7ir0n9WrHFsNimFmnWXAg63Rr8g8BE4m6rTne8of+kUpIsQKGe?=
 =?us-ascii?Q?28Stu7MQIaZPEAkNUCB8vPgm3Yw3f4ZFTKLiLkDcgn45aMxPj+0Yo/7vncZP?=
 =?us-ascii?Q?897RGqqz8Kl7WUUCC6BrlyNd+/hF3X3BMic0GTPWjNcceVcIOH4bQ/MxEd2L?=
 =?us-ascii?Q?3vEWnRi91U6aUk1oqQncMn6NZQER/+EJKIAKPCNtSBIOofq5s6PwL8S8MHsg?=
 =?us-ascii?Q?nZir5diANDakcN/fRExLu1+lB1We3GKctZE8QAjj/AfQXfYsiCCaicmfFlSc?=
 =?us-ascii?Q?4QmA4dtp1uLOOi95TjkLmI/G/5qm1af3o8dXsGdhYS+bISwYbfW2OdViwxdZ?=
 =?us-ascii?Q?VS9YsNjddYiQQEx5n3+ckMqvytwNT2/QMScTgzaWqi3rmoRMLnpUxGIr/A0e?=
 =?us-ascii?Q?QcIf2ipTSqHHf1pW4PyzeTPQW7nfsFx1FGMREhQ8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f0310a-83ca-4a20-1707-08dcc22cc08f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:01:04.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1sndCvlCPNHPfJ47HzLTWOZTzGIAtoYIrSLUWd1n53V9JZiKWiKT5+X7v8TogQtUwQ8ag9mwJP88FaPz5OAyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8188
X-OriginatorOrg: intel.com

Li Ming wrote:
> The "goto error" pattern is not recommended, it can be removed via
> refactoring. In __devm_cxl_add_port(), there is a 'goto' to call
> put_device() for the error cases between device_initialize() and
> device_add() to dereference the 'struct device' of a new cxl_port.
> The refactoring is introducing a new function called cxl_port_add()
> which is used to add the 'struct device' of a new cxl_port to
> device hierarchy, moving the functions needing the help of above
> 'goto' into cxl_port_add(), and using a scope-based resource management
> __free() to drop the open coded put_device() and 'goto' for the error
> cases.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/cxl/core/port.c | 59 ++++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 53e2593daa95..a886b16b2610 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -828,27 +828,20 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  			    &cxl_einj_inject_fops);
>  }
>  
> -static struct cxl_port *__devm_cxl_add_port(struct device *host,
> -					    struct device *uport_dev,
> -					    resource_size_t component_reg_phys,
> -					    struct cxl_dport *parent_dport)
> +static int cxl_port_add(struct cxl_port *port,
> +			resource_size_t component_reg_phys,
> +			struct cxl_dport *parent_dport)
>  {
> -	struct cxl_port *port;
> -	struct device *dev;
> +	struct device *dev __free(put_device) = &port->dev;
>  	int rc;
>  
> -	port = cxl_port_alloc(uport_dev, parent_dport);
> -	if (IS_ERR(port))
> -		return port;
> -
> -	dev = &port->dev;
> -	if (is_cxl_memdev(uport_dev)) {
> -		struct cxl_memdev *cxlmd = to_cxl_memdev(uport_dev);
> +	if (is_cxl_memdev(port->uport_dev)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
>  		rc = dev_set_name(dev, "endpoint%d", port->id);
>  		if (rc)
> -			goto err;
> +			return rc;
>  
>  		/*
>  		 * The endpoint driver already enumerated the component and RAS
> @@ -861,19 +854,41 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  	} else if (parent_dport) {
>  		rc = dev_set_name(dev, "port%d", port->id);
>  		if (rc)
> -			goto err;
> +			return rc;
>  
>  		rc = cxl_port_setup_regs(port, component_reg_phys);
>  		if (rc)
> -			goto err;
> -	} else
> +			return rc;
> +	} else {
>  		rc = dev_set_name(dev, "root%d", port->id);
> -	if (rc)
> -		goto err;
> +		if (rc)
> +			return rc;
> +	}
>  
>  	rc = device_add(dev);
>  	if (rc)
> -		goto err;
> +		return rc;
> +
> +	/* Inhibit the cleanup function invoked */
> +	dev = NULL;

I'm tempted to say we should use no_free_ptr() here.  But I don't think
there is any magic we need in there.

So.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> +	return 0;
> +}
> +
> +static struct cxl_port *__devm_cxl_add_port(struct device *host,
> +					    struct device *uport_dev,
> +					    resource_size_t component_reg_phys,
> +					    struct cxl_dport *parent_dport)
> +{
> +	struct cxl_port *port;
> +	int rc;
> +
> +	port = cxl_port_alloc(uport_dev, parent_dport);
> +	if (IS_ERR(port))
> +		return port;
> +
> +	rc = cxl_port_add(port, component_reg_phys, parent_dport);
> +	if (rc)
> +		return ERR_PTR(rc);
>  
>  	rc = devm_add_action_or_reset(host, unregister_port, port);
>  	if (rc)
> @@ -891,10 +906,6 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  		port->pci_latency = cxl_pci_get_latency(to_pci_dev(uport_dev));
>  
>  	return port;
> -
> -err:
> -	put_device(dev);
> -	return ERR_PTR(rc);
>  }
>  
>  /**
> -- 
> 2.40.1
> 

