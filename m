Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C420E6;
	Wed,  9 Jul 2025 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025344; cv=fail; b=UB7rFVXcNQOVnfo5VqzaENuv+gAYDbQHYaq5c0JrvOHAoeBgC9/Q6q43fp+0bHv4deha90l1AjI9bjTYPXXr6VSHximn2lY2NCRwdlJyPuvDKxDDkMFaNBJg1vE4tqFp1sBINlMH2yBZGkX4dw2nzrYBxHt5CVykbUTCwsKPKB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025344; c=relaxed/simple;
	bh=CWaPV6K/kJAjKwIFBSovuV6PYQnOYbWk6KfyfuUByj4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=twt7vKRVf9Rii69G4B1gpLlqaNeoG2vMsDQZREuOKi9lWM6qbk5QKsf2Jn2qglKkCc7ZmpWXosbyulJKElqZOnAYL+9LpAevqaoQcXzvkvlHK37aCRCtrS//WknH8bVZKVF8X/2r43LCajVy2DMZRSXRbGed6hc9WYIex6txSL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuChxm5Y; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuChxm5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752025342; x=1783561342;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CWaPV6K/kJAjKwIFBSovuV6PYQnOYbWk6KfyfuUByj4=;
  b=cuChxm5YOF9dQ1D8T2Yek46tbCG+KIPPnNWUlNokb1yESkx/9BVmTH3F
   uQJpPCK/UF5vA/y6CyGo63R5XBqUCGzdNWHr23tCfD9TqIPp2NtCuuLm2
   pSDfbVEK4cFTfAD5bBL5d3Upkyv6HzPNNNHZE8022J6f1iVqamJrAd7x7
   BotQBZMTnvW0wxnA2eBaSShR9EQmvHXE252DH4LhVdlcqpoK6TUA/s6/a
   kpruPvTlyS6HJbUPawMgIYy+NwnJ4Tg5S3QmgLgjwZfD0n/up+IrdV7qF
   WEEn0XBICcj9QKssYpAoFvCs4hjvTdvnsNr8vFnTgi5fqnYMfD0qRWtbZ
   w==;
X-CSE-ConnectionGUID: BfN6vE7fRu+MX7xA8aYyuA==
X-CSE-MsgGUID: iLYWLY0ORXiTCkoVwtV6kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53489315"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53489315"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:42:21 -0700
X-CSE-ConnectionGUID: oLs4L7CIQFGr0+o0RakD4A==
X-CSE-MsgGUID: yJLuBgj2Q1ulUHLR9mDYMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155055668"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:42:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:42:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 18:42:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.83) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:42:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjpKf2nFGHhrJSmp+yq5LEdWLK4MMRYiShSNkqBd8vIboXb+Ct0ZVNW1phhVyu2bSjasbGJBXiV303ZKb5isyOyC6YzuvAkWMdCJf1PmzJ3ujNO6ypEQmyRg8f5KLIWF3s5wEkKRb/hK3itZSSx9cofzvuk6y2e/Q0OYBQ7m61IfhWgjXL3zFVIBFUqW9kSTDv7UifuVTS8Hv/CZKePMmFTo32RXNcfWLsbkqe+70Dx7Y77z+Ks+EHR03JqchSN43lCgTbzTi1bpfTSI3oikqPq4XA2XGP7lCnoE5v7VYAho5TY98qmCwQjfba39zBxA/XF80/NGTHxYjoaeBQZJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYdDDzBS5OMJ5mUBWd82HqN6C6P3Gwo6Dyq8iKjRdbY=;
 b=XNpPaebLURhqCi6xJp0fgN64GBOHssrp6ShMv5b9OeP8vjVlDAoJiIh5WDCc4ayyIL14jZtlAcxsqNSbYtGtHB1qWFO1OF67Ly/UwxEJ5kF0ZkKWbfxGL3B/Rx2pJAEnHsu17+u0P9RwOIsQlPrWKwVrkLwZD90lrU2hfSc8JXPx/bi1gVWpSjg4F8HwmLqFBYBptD2S59WKAlRopQCoE1GosUJqeCyUUBlmOWUfEWTa6ay2K7erzyQ6OQY3XGP9vVNcI+uHuWLphvX1sGUcXj0qCVFIrkOGmXie45CHUOa2WWU3e6vPlvJlNslMFFevj3JgnOARrEvRDnEk4Dyfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 01:42:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 9 Jul 2025
 01:42:18 +0000
Date: Tue, 8 Jul 2025 18:42:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
Message-ID: <aG3I9ooPm0eJnMPn@aschofie-mobl2.lan>
References: <20250708051536.92119-1-ming.li@zohomail.com>
 <20250708051536.92119-3-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708051536.92119-3-ming.li@zohomail.com>
X-ClientProxiedBy: BY5PR17CA0067.namprd17.prod.outlook.com
 (2603:10b6:a03:167::44) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cb8968-8e57-4e58-1a6e-08ddbe89d691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?okVQ7oZd28w5etnNQo0n+tAVMFykypdaJIcA/gEuVdY/nprG1FNrVxRpoyfO?=
 =?us-ascii?Q?evB+gNGsrUty5E33Pn541CXFHhCBs7yb66Sd41yz5qyE9cZFGpOS0IF+0dsu?=
 =?us-ascii?Q?0HECuRsUug9e0JtmUVGJ/9ekEm/jezk36KXIzIOLdjleH/o66QDjpShPTyIp?=
 =?us-ascii?Q?P1WTbkua4kdmjma549LgD7+HHW7A9Mw+BNfLucVHYJ73Ef2nJxNx12njP84L?=
 =?us-ascii?Q?D/BBljY0j7PZ7VCpQ7DtX5+cfOKeW0iOVO2eMY0rOeD9Wo4cgf63GMlXl/2q?=
 =?us-ascii?Q?MKHb8uYMNEusIjOOsgPcDPAy/jzT7+hIiMr8VdBwwOqQ7a9Lgt6Zoz9q9MR7?=
 =?us-ascii?Q?MOLvn1vOASzGdkkkjlz0U05hE5U76GqE+7Zpu7co/bgx8qImUPOWcnK6Ii1M?=
 =?us-ascii?Q?Owjw1JBTKSnlr+ci6wm+sV3Z3l9kvkdJv+Ld0ZeTIVSEQSAUROujb+PrUeJx?=
 =?us-ascii?Q?Fm5tIJ9iY1ytqQ71wz/APk7GqHU26dLki+ArBo4HfEGeojUgRR09vAUAB6TK?=
 =?us-ascii?Q?ReYAGZOY4fnMec9Zj/RVYdr513EJSzTu9s86Hr+MItBlVzAOs8RR8linbsOH?=
 =?us-ascii?Q?Tlw9htajVkbKoqCmKb+aoh62AFepWjfmwTe75UgSzYTVZSkG+aoFSjLluI3L?=
 =?us-ascii?Q?aVWTG0fRx+h3LI7LmoKbOcLhgn/YfYrbpy+YEkSPC9dJ6+dQ/2m+L77MZ2bV?=
 =?us-ascii?Q?nS+vrECZjsVv0KrgLnRrjf14rCBnA791hZ7+USn0PcVlNlsFszzaYOz3n7GX?=
 =?us-ascii?Q?CGktcKpZRfnDDPoGmV0gOfpRLOJZaBuKM3pvD4WChBfOcJaZ+4nqhhltyg+t?=
 =?us-ascii?Q?rJpKAwfWOvteOAuMR/oCkVsvRnX6yVqJuGdg67gk/Aah2B59OlMh0J8oE1wq?=
 =?us-ascii?Q?pjv3eitQD7sJPzoW4zTMw46H4Uq7nlZa0EKQJ7vjNVU7VDXsrruw1ZN8qz4H?=
 =?us-ascii?Q?7UDz3BMj42zmvWo8hC2gKpLKmM8vFRg5dW6qUYQKBFBSNc22H/qz2PQxYo1r?=
 =?us-ascii?Q?FcF5iFfZP1JWJXCWEhOofrjyWPeNvMOt3XR6vhqSf/Tx/8BOWDJVFz0cnbiB?=
 =?us-ascii?Q?CIwL/huY0eXs4xCT5eyLb5jMVw4ZbAWrR1CV9gAdWUqNYG/l0zv/caGlMUEl?=
 =?us-ascii?Q?PUlC+G4mcX+g+r+xi3hg0EKEKjsUVmfjyN0/floz8GoJL6DJU1ceJ4nV5QwT?=
 =?us-ascii?Q?sZ87BhXMH5D+xjLg8ZxVkJ0eOdnYDgwNusKaR3i2nTV1NPfBgrBPTswOAvXZ?=
 =?us-ascii?Q?7WsTQ/IOS7Q84wK/pDNlAq7XYVBvcAJ1/zH24qmrZOZyXtLH+hgW4r+6KgzM?=
 =?us-ascii?Q?oxhb+ehDyO4HMSDrRPKpuIW512ieKT2ecy2/vHx+Ba6KEWK8HQd9Gm0vTimy?=
 =?us-ascii?Q?7r2HhWI4crArJst/EqEeaOFaAGCM8eQ0DFHxxGSjGVGXdkGJ8gHjJnWxf14/?=
 =?us-ascii?Q?PJV7TtWUecU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lc6LjujS37vtsx20y8JSmpQIn0W9HvXsniMCd+1sG/yW66fjs6/phfK22N3V?=
 =?us-ascii?Q?TFcp+arqGjS1V8AvSa/JuamUDbEPe6vlMwpakt7S25w6GQbWzMYtfLJ0HLCJ?=
 =?us-ascii?Q?6HeyLMgEgzSnfJNFDJMt8TA4Czh307DVhQ+HZJbkDqsWpF40SRlbwkxdbCRp?=
 =?us-ascii?Q?HDLnnP483TCt/kadVAFQ5bd4QNyEu9G4XsttwPyOmicpo2egKO2l9qzWNazR?=
 =?us-ascii?Q?+Qf4RqcTvT08XXJWG8aQr3O9l6VwkRULNpnxhaPSz34uR5LK/1tuHntRniZ9?=
 =?us-ascii?Q?D3+Q2ooH83GFHhJqe2ODcsHIzHPojVoEe2OlwWQeWMZVVnJJ4Btgh4Htj5z8?=
 =?us-ascii?Q?TyhdEbdSHP/4iRUrH372HYOXruCFdqLr3utOVcjMxBsVpWg2Ih4zbq6ODxKu?=
 =?us-ascii?Q?LIGyQN0ySC5swuxYqBl7FVkVbwITyf78Xn1DfgUxfZudpZ9tTnhg1VnXNQBk?=
 =?us-ascii?Q?SbVhf5FOrETSV+TYMuydD/w+qIY2wOc1nAVhI8PD4YSbeVoHycH/4ScaqIOa?=
 =?us-ascii?Q?vtwc52czVVqWGynCCNAmNp3eWG+LO4OdjIwOCsNBsNh5zPqjbyoyHTjy4VhO?=
 =?us-ascii?Q?E3ErCM/RhFXXhf5/zG9k7aSa4CDKotj8TYZHMWMRBNcpRuL3M0Skl6RhEwfq?=
 =?us-ascii?Q?nDpL6eJyfdiuTFkZRBFwRVSbWh8xNKq8mq3niCzEA2E5EhRyNk5vSMsxl2Qd?=
 =?us-ascii?Q?ylHzg32mYri4Q/Z8vrn04TCuzkZuHbwAjNFPD8/06gF4jcPM9fNgXNpFjxqP?=
 =?us-ascii?Q?Gry9WTwtHld9zY51LPUsQcFzhjx+/by1D9RRQtfjGRQb8D0KZLYhXPQK8qb4?=
 =?us-ascii?Q?pB0H5gYdT4+E6CHgKE/IP0LgF0ePWpUyZ6YLIqxHJM2xNAULGVYI6I7PV2SK?=
 =?us-ascii?Q?H5Y2boO+u3Rrj8O2W9CtR4c3n9WXWGBQAfk2jIaOEaLo5cHyFBLpApibholO?=
 =?us-ascii?Q?+8rlU8Zf94Ct/fowS9krGJWmgZTJ+rrX3gUTh+5oN0wATPhDBXWTNnuJXKVs?=
 =?us-ascii?Q?Jcd6Knqw/2nHaKWwmhxDmqeu5ixhU1Hb0TZsBvFRN1m2TkhnC6K0H4k6QSar?=
 =?us-ascii?Q?bUKvaHG2ABKf1Dt/6y//O4axmzInqwVrLhW7zh26w1wvI2a0uVW9x1O+xnXZ?=
 =?us-ascii?Q?OfDdKhV/fxaIszVhMBCJ72XkSpujVghCJl6qrNjZ7WJ7PbWZksZEVSLPNT7w?=
 =?us-ascii?Q?3dYr8SDJMCW3zowrZBWnaxmnMWBw6Jmfne3t+azQ3/GnZ0Z0rKgO6sNdp8XL?=
 =?us-ascii?Q?L6JyJ0i5t8l5sHiC2wspUCRIfdiUE0pV+WuGx+FTP90uNy737lNceXGZNgcC?=
 =?us-ascii?Q?yMpGLsW5to+YkIJDxumTKAUasJgoWu5+ynmeG+vVW34GLZ11qDQEgcOzQLAw?=
 =?us-ascii?Q?iscA14ZPFAcWjgCetS6Lq2OBuX86NgGQA9N2IL1192acJNhYjWQAfSRhXk13?=
 =?us-ascii?Q?rLcv6NhXWMXGyz4bwE0viyfSqKZCB5rTqX+B74nryH6VzQerRvkfLZfWZsee?=
 =?us-ascii?Q?mbhQ4TDSodmjYNqTtHU2OgvcrEtTpRn3MIDMJb026GxUruVtQpCoKa4al3bW?=
 =?us-ascii?Q?D8V/FgeT6tEloOESjlVeM587iU7ABf1aWBXTpZeFp3rix+X05DRXBgqZh4Te?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cb8968-8e57-4e58-1a6e-08ddbe89d691
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:42:18.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxCKFzvtnAC/8oPZbI8gWRona38ppdyzENHxweN1d2/RyRgdzWKpv//SIB8QISDRAxeSLSDY2KAdr3lz77gy7hNBKsAbdIJ0InDtrlzUW/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8066
X-OriginatorOrg: intel.com

On Tue, Jul 08, 2025 at 01:15:35PM +0800, Li Ming wrote:
> DPA 0 is considered invalid in cxl_do_ppr(), but per Table 8-143. "Get
> Partition Info Output Payload" in CXL r3.2 section 8.2.10.9.2.1 "Get
> Partition Info(Opcode 4100h)", it mentions that DPA 0 is a valid address
> of a CXL device. So the correct implementation should be checking if the
> DPA is in the DPA range of the CXL device rather than checking if the
> DPA is equal to 0.
> 

If it needs a fixes tag, doesn't it also need a user visible impact
statement? I get that the PPR won't happen. What does that look like
to the user? Is there a user level error message we can add to the
commit log?

With that, you can add:
Reviewed-by: Alison Schofield <alison.schofield@intel.com>



> Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/edac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 623aaa4439c4..1cf65b1538b9 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1923,8 +1923,11 @@ static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
>  static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
>  {
>  	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
> +	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
> +	if (!resource_contains_addr(&cxlds->dpa_res, cxl_ppr_ctx->dpa) ||
> +	    val != EDAC_DO_MEM_REPAIR)
>  		return -EINVAL;
>  
>  	return cxl_mem_perform_ppr(cxl_ppr_ctx);
> -- 
> 2.34.1
> 
