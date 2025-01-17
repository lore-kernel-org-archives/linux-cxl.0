Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A33BBD8
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080954; cv=fail; b=ocessHJoRYLkDNIULMpAQz0x44vxgLaXT/dvvQQoRNTj6IYtk8tahetb3sm3nZzCwkgdZ6PtiQ0eRjxzZQ7WFNJsBcw+u1E9d2NrZC4NOuPNCF5qoU3nYiEsJGxxGnOKUt+xcOXmKdGis4K7P7Z7Y3NvG/OZbmtC6qqv3MxcSuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080954; c=relaxed/simple;
	bh=4D6WgIvOeb7ImuAsbq/xwmB+q2F/SazRGU3K9N5H3Xw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tim/1QHAZ7WgCWaoiuwT4kYO7uhtC/qat7a3IZL08LOWrg9D7LqTgCjjNlA4lnvpWFx2NdOyEbk4MTEmTfUzPwLj1Ijv76YEfhS99sexwG5knpaJ2b5LtwyVoY39+8gq7OxyhIGKFTJoLJAGWWD1LqzSHwlzGIWlCkWh9miuEMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZizMr1D+; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZizMr1D+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737080951; x=1768616951;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4D6WgIvOeb7ImuAsbq/xwmB+q2F/SazRGU3K9N5H3Xw=;
  b=ZizMr1D+4XXulM2AfEo+WT/7DWmiyUH9qBAekjKr0gURPP/7M7MpNuFt
   OYYLiQbplafMFMoU59pB9QkzW5fZfpFVnjbRq5LRLAMBtF3ssG8iUztFk
   LKoKomrM6vpuukAyK4zWgkDGICo+FajyfO6Yj6TmXbZu/c4sJ3KTygo7X
   HhTsbOmW68FsRqZU5xNi1LaK6XrkYTE6M9K0fHlcq4Cygijj+WpLIeI7t
   lvzQdUjoXjUc0ZL0LgHWNqGFGVgGQdWyn9COJShwEWvEmhcRpbW1FMFMl
   qJlaITjZjY7mJCBDS/rJPiINNk3CeUtpB68yObkl24dp1QTCwe6MJr+Pd
   w==;
X-CSE-ConnectionGUID: 6lE5GUwjQ1Sb8doeo6Lt9A==
X-CSE-MsgGUID: /WgDZ532T/eqUi3O/jAmMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48161550"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="48161550"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 18:29:10 -0800
X-CSE-ConnectionGUID: b56pDEseScKmqZZ4f8RqCw==
X-CSE-MsgGUID: aMtq95lLT6SzELnx+LbPCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="110660571"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 18:29:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 18:29:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 18:29:09 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 18:29:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwf7v/Sa52SbcN8Sro7zcVJBPwyfjUDCfS0wScRCLVYDgnRuezJDNMLiiGBRIhE3SQntjjQKRy940l8FiTA0FNT+fiXiB6QqPbsbzQaq7Fmfqv/mUPy2U/1qvyu9lS7v8QmGgXgTpHQdHYQHerMJ2OPmcanwkJjmZB34pKWHbJ/OMAvNo+LPTG+ln4zQFpz9Ziiz+dMIrI/2jmAExa9z7aNrVB+gANusiH73R3qcuWRYHYNcp33Hh3Va/G0LYuLBmWfptNwfaZNEl96Vc+hHU5VYf8k9kxMJgo2JxnsHk1RyBitqroDyOWnLg9oxs/+4QkFYHWUvB1N9aAgSwHYrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRrfkVuRnC3XMM21EH1Lxt8mGm2sEweWdU1vWOMR9Ds=;
 b=fb8wfZzTPD4inLspnQiC0soZ6JPB7IXwPY8KoEDeI5AFeWK1UuujA8FuAm0QtsbrHPj4u3kzV6DJdRSKBOIVClh/qldLhcw9wbT8ftPBfyCZ97jA0AFUkSb0CetB3BWj7+q4tRx8y3DliJZlVbOExI2NgJzsZkmjVjkIXV5fGId6nZBZ4o5H9ksEpj5Xv1tCfPlj1+YfuASKd7q3vcX2reEAY3lA63j61N5EBPVzES7xHm7GjWA3p9yfjv0z6giOals/QBBeqWd1cjd8NaxwsObBkcCxv7ki77f7mbP4R9gxJu0PdwMxH+NU2/84OnlyRKOIuOjvdeYS8vncKys2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8423.namprd11.prod.outlook.com (2603:10b6:a03:53b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 02:29:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 02:29:02 +0000
Date: Thu, 16 Jan 2025 18:28:59 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>,
	<hch@infradead.org>, <a.manzanares@samsung.com>, <fan.ni@samsung.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC 1/1] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <6789c06b84028_20fa294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241220164337.204900-1-dave@stgolabs.net>
 <20241220164337.204900-2-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241220164337.204900-2-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:303:8f::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 47349d9c-dc79-46c3-59e3-08dd369eb49c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7gqYxwojKG08J15eMl29fzaqH+OhqKLNRptdOLXM02YrPD9bV8yN3sZrinT/?=
 =?us-ascii?Q?NmrOM4M4HX4m2LxlaJvDy7aAWF2DqX+iMaRZXmtb/XaspQXrgbdB6mf5zoVa?=
 =?us-ascii?Q?oqzImI0X/qUucqz3c+zcW9GWWRd9ag4+1I47e0fM7bCWc2yYZZ9MS8QQKixS?=
 =?us-ascii?Q?GfZ/tWnfDNOZALDZ7vKJ8K2iYOIRCSwoJUo0Fj7ldQYoyrYyuZhK/M7HfaIh?=
 =?us-ascii?Q?gb+cwG9hGjgUP4mo1Ka7nYR8c7LRzIhKjLJn9XZhNKym6Q6bLJIB3BliC4wt?=
 =?us-ascii?Q?ynM2k6G6dDjd2pF6+myKkZ3wUb0T8x8RSWZf9iJbV4GFOOPppGfj/v9UWYzm?=
 =?us-ascii?Q?1es+IZ8lo4kgChgBrTq6ZQf3sRxaOPDoSFrZ+IUhhXA7oSFevtqNKdOE2BCR?=
 =?us-ascii?Q?urrUHcTzWkE7A4TJPSeEI9adAB0Ar4Uai0OB2TNpQa4pCy8eCo/SEV86x9BS?=
 =?us-ascii?Q?fXcuMhtduv6oHE5pO3M2oJi50Qnq2/ZfS3Qav87FKkIbGIxbQ2mKUxTVWFy2?=
 =?us-ascii?Q?tu/qpcBvFhl8dW7pC3p1ppOmeSg6jZ9bAaOvC6XNmDUpM5fr4v2kgt4JBUks?=
 =?us-ascii?Q?9kv+ElRhrd6Of4/iLDOw9t6s02pR7oprc9DYrMJKumeRqOcwSA4AY2/4TJYq?=
 =?us-ascii?Q?ytaAqbjXMaFJ/tD/p8ZQITHG82rW88l9JdYrtf4BjrMTfbf+PBF25m2zTUNO?=
 =?us-ascii?Q?xz+ZDm4Y6YPo9KA9vDlZvG3q8utffIHEdWopA7GGLb5NJHVk+w/apVsNybIs?=
 =?us-ascii?Q?ZBCk7U69Grc1fO0D8Da33e5w5TMEM59ZwJQ8ZMyTZqMvWoPGw9lS/OHfJIv/?=
 =?us-ascii?Q?7NW4dSP7w/+g97Gw407jFW5z0qQ023I6DgH2DZLyIVxECTXslb/cBQFqDz7f?=
 =?us-ascii?Q?eQenQXrow3XJB4yaDHEMN0EyqpJ96oCCB6sjBB+W1rUCv1e8Xm+CP4dybRb3?=
 =?us-ascii?Q?/18aHlotJLmMuXshhXoUeZeKjuuANN+PegZcQtMvzUHintLdIgYrzFPG4LDC?=
 =?us-ascii?Q?gkILQKTT59/EbjL7n3BcDS8czys8WK8AycQvy7kdGZe5AA8WGCB6Q+W/nayM?=
 =?us-ascii?Q?sB6k+pMNJDuI4U1iQ5OPejKj1PHr8q+xXrjqxNseYNlUhRc4un55XZy+sbCu?=
 =?us-ascii?Q?fCbBea+a88zxfdehMcmgShkVpJxYd0B7COGU4qDjZa1LHwkH4HyU6xprBADN?=
 =?us-ascii?Q?KPG2ook3LTHO5+JbCkxZBFNODns32POFIA4JR+lVm62zWEuw0+azdfO3h/Uu?=
 =?us-ascii?Q?RZ+m3Qw9QFzzpmKvXmw6AuchWobrcAvInQ7ZViw8i1ABgqsERBfi3P3LQcDS?=
 =?us-ascii?Q?pFhXoabvrnlNsS3uw6fddE8PpipUr1+5Tiru5Z5p/xbsAiLHd1Y8z2JrLb8F?=
 =?us-ascii?Q?HEO8UF+2ZyJqCWeq6xDusgIq4x0e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/KMIKum+FupJxmnyvu24PQnyVYUZ+xfTOsPaG114k1F0i1J3HiWaklq+1fsV?=
 =?us-ascii?Q?MP5/UGwcFiJDtGBPidRVVn7hvF+HcfPyEMIBEgP/hssIKUMIFX2waUQnPoCr?=
 =?us-ascii?Q?BY/3Rt3b+kDcqkm8AOdZ5AyX4/osLUj3TWGJQjKp5aqakQEciT22I3SGe92K?=
 =?us-ascii?Q?7DI6CYNlhx4CjwZF7KDaRvBOjiPV44XqTRaNWqCfF002xnuN7ykjlZa+Us97?=
 =?us-ascii?Q?Ype+3TqWafjwaoxV8uibBnBO4+WlBnUr4UCrTb7YVFQ5XdrPaI11OC4aea9I?=
 =?us-ascii?Q?d3ljuHAg8hE4RR1TQvntADRaFK3L0NeIZG0TVSeJMp0t3eJ9MRC4vfZ8cIQ7?=
 =?us-ascii?Q?zPc11hKLuW3ecgx7wGRl/KKzKdvipKIRuqVWNqYa2d5C4dqUp2GH3O9ieCgm?=
 =?us-ascii?Q?IcRXL6c2Zpg3WkHsf48HvsBW7Mp5w6Wx6XYP9wT4g70VkBhAHHB3lh1EnJDn?=
 =?us-ascii?Q?Ep3gLhW9gP6i/4CD3RC8eUTZqj0YQZHPqXL4aGNLKhZy5+C09lyWFsrGl9nX?=
 =?us-ascii?Q?2nMisTfYbPU/gjlFoFp2H8DkFOK4NT5WfPpfC5SYNKkBa/B3YSrPIRX5pTr8?=
 =?us-ascii?Q?xR4gs+rMkYe8xJvXdEUWI7Dni4c1dYrVPwu7eHbG0ZZeQkzBfx3n8qcqc3Vb?=
 =?us-ascii?Q?qGT6sXSb5Udl8xwkw331T6yPMVAYIVn/ra837YfnBn+WRrdmRpb5lQcluyzu?=
 =?us-ascii?Q?0cBe6b6qzwSy8xZG7/y+Ziw6OTvr4IhtlzY9fSgoqH+5Rv701xJsXz6h6aGd?=
 =?us-ascii?Q?+zwFmm3bXhQA7qlHWT6mZFkr14FkA2FUVtodozqeQ5/EuNa1NAhvrZkAQqK8?=
 =?us-ascii?Q?KMRhhiLBDMPeYgOhAzpTgLzmLV+9YlBi4lQi5v62ge4v4jeCT2AhL+cf/IYH?=
 =?us-ascii?Q?9Oy2X4XDNdLS6od8bC//jqRmidPDqv/03UN4LGp7ZJpKEm8PzCl9oZwAmcyI?=
 =?us-ascii?Q?XB1WJU+qBgcc9vQUmXHgjGOuN7LqxZQ2bwKzfr+GB3bPGV6Z09E7FltxYAXR?=
 =?us-ascii?Q?/odT1Z+v9GdO3UjBbV7PU0v2PVziA/MNHne1lAGIcS3QpzLVJo3INZpl3QYu?=
 =?us-ascii?Q?SVa2C2g3acSXX9vUEU2Bk5D4Ld6NHvTtrzuIOjai+rrjMaV6TNKQfnw6P6KW?=
 =?us-ascii?Q?lka8qlmeUTXeF+Ha/rkdzzr5sz5VOlJ8sht6kuYq1Wp8zQMv82Ecq9cuizMx?=
 =?us-ascii?Q?7fA6+Fy/xeBhF9JzOob/sDN55A6QUqpdKQyQvIU4CTS2hJAWs8ZJfff6pWff?=
 =?us-ascii?Q?tAXZBwuajTQRdCJRNfV5qwSIE1UWE8Onojon/N1JmKK8n4E5mOAElUobw9Fo?=
 =?us-ascii?Q?gj4JBHYSV5yYe7imjyApTHYGCXZ6zmXb1J7yMbef/rK2Hjez8DaGkPbTvHAl?=
 =?us-ascii?Q?JAHkhH6gF6IJPCgTcgMC3YiHcxgsakOeKCYT0DyiYilcprW3jp/ul6YMTn0m?=
 =?us-ascii?Q?fRGzMd6WcX9xm6KYMZBqPpFCqJR1l1ncI/GxFDd7HmF8+tmzVunUZc+3XoIA?=
 =?us-ascii?Q?MvkltYYCGy7YDFqAqjOFcVZEojo+i2t93/pevp6QKzr/4L3FKPCryCtNgFxM?=
 =?us-ascii?Q?ByKiNfE7M+M3NhFmFZZEO9iPbtQ8G3kkfJXISVdPr6UjWdeEp7cCUpKkNJPQ?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47349d9c-dc79-46c3-59e3-08dd369eb49c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 02:29:02.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckXYBdADrIWKVRQImgFAJj1vUE554jd0GawdXPvXtNU6RhecgwqFVT4P1B9LohayvpMAMWvnFqNMeOavtyDz+I2yFAulUHZO6NbWQIzc1v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8423
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> Add support for GPF flows. It is found that the CXL specification
> around this to be a bit too involved from the driver side. And while
> this should really all handled by the hardware, this patch takes
> things with a grain of salt.
> 
> Timeout detection is based on dirty Shutdown semantics. The driver
> will mark it as dirty, expecting that the device clear it upon a
> successful GPF event. The admin may consult the device Health and
> check the dirty shutdown counter to see if there was a problem
> with data integrity.
> 
> Timeout arming is done throughout the decode hierarchy, upon device
> probing and hot-remove. These timeouts can be over-specified,
> particularly T1. Set the max timeout to 20 seconds for T1, which is
> the NMI watchdog default for lockup detection. For T2, the policy
> is to use the largest device T2 available in the hierarchy.

You convinced me offline that there really is no downside to software to
maximizing the timeouts. When these timers are running software has long
since stopped running.

The only downside to maximizing the timeouts is that it means that any
misbehaving device can block forward progress of GPF for all the other
devices. That may end up exhausting the energy budget of the platform.

However, the spec seems to assume that moving on from slow to respond
devices is a virtue. It is not possible to know that, in actuality, the
slow to respond device is *the* most critical device in the system to
wait.

A well behaved platform will be built such that all devices always
complete GPF within the energy budget of the platform GPF flow. The
kernel does not have enough information to pick anything better than
"maximize timeouts and hope it works".

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/driver-api/cxl/maturity-map.rst |   2 +-
>  drivers/cxl/core/mbox.c                       |  17 +++
>  drivers/cxl/core/pci.c                        | 104 ++++++++++++++++++
>  drivers/cxl/core/port.c                       |  68 ++++++++++++
>  drivers/cxl/cxl.h                             |   3 +
>  drivers/cxl/cxlmem.h                          |  24 ++++
>  drivers/cxl/cxlpci.h                          |  64 +++++++++++
>  drivers/cxl/pci.c                             |  97 ++++++++++++++++
>  8 files changed, 378 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index df8e2ac2a320..99dd2c841e69 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -130,7 +130,7 @@ Mailbox commands
>  * [0] Switch CCI
>  * [3] Timestamp
>  * [1] PMEM labels
> -* [0] PMEM GPF / Dirty Shutdown
> +* [1] PMEM GPF / Dirty Shutdown
>  * [0] Scan Media
>  
>  PMU
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..c82cf1547027 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1308,6 +1308,23 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
>  
> +int cxl_set_shutdown_state(struct cxl_memdev_state *mds, bool dirty)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mbox_set_shutdown_state in;
> +
> +	in.state = dirty;
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_SET_SHUTDOWN_STATE,
> +		.size_in = sizeof(in),
> +		.payload_in = &in,
> +	};
> +
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_set_shutdown_state, "CXL");
> +
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d58ab9d33c5..9b1e110817f2 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1054,3 +1054,107 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  
>  	return 0;
>  }
> +
> +int cxl_pci_update_gpf_port(struct pci_dev *pdev,
> +			    struct cxl_memdev *cxlmd, bool remove)
> +{

If the timers are just maximized then I don't think there is any need to
pass in @cxmld.

...there is also no need for the remove flow because either the device
gets clean in time or it doesn't, or someone else that knows better
about these timeouts can reset them after the kernel has stopped
running.

> +	u16 ctrl;
> +	int port_t1_base, port_t1_scale;
> +	int port_t2_base, port_t2_scale;
> +	unsigned long device_tmo, port_tmo;
> +	int rc, dvsec;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	dvsec = pci_find_dvsec_capability(
> +		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PORT_GPF);
> +	if (!dvsec) {
> +		dev_warn(&pdev->dev,
> +			 "GPF Port DVSEC not present\n");
> +		return -EINVAL;
> +	}
> +
> +	/* check for t1 */
> +	rc = pci_read_config_word(
> +		pdev,
> +		dvsec + CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET,
> +		&ctrl);
> +	if (rc)
> +		return rc;
> +
> +	port_t1_base = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK,
> +				 ctrl);
> +	port_t1_scale = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK,
> +				  ctrl);
> +	if (port_t1_scale > GPF_TIMEOUT_SCALE_MAX) {
> +		dev_warn(&pdev->dev, "GPF: invalid port phase 1 timeout\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Set max timeout such that vendors will optimize GPF flow to
> +	 * avoid the implied worst-case scenario delays.
> +	 */
> +	device_tmo = gpf_timeout_us(7, GPF_TIMEOUT_SCALE_MAX);
> +	port_tmo = gpf_timeout_us(port_t1_base, port_t1_scale);
> +
> +	dev_dbg(&pdev->dev, "Port GPF phase 1 timeout: %lu us\n", port_tmo);
> +
> +	if ((remove && device_tmo != port_tmo) || device_tmo > port_tmo) {
> +		/* update the timeout in DVSEC */
> +		ctrl = FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK,
> +				   7);
> +		ctrl |= FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK,
> +				   GPF_TIMEOUT_SCALE_MAX);
> +		rc = pci_write_config_word(
> +			pdev,
> +			dvsec + CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET,
> +			ctrl);
> +		if (rc)
> +			return rc;
> +
> +		dev_dbg(&pdev->dev,
> +			"new GPF Port phase 1 timeout: %lu us\n", device_tmo);
> +	}
> +
> +	/* check for t2 */
> +	rc = pci_read_config_word(
> +		pdev,
> +		dvsec + CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET,
> +		&ctrl);
> +	if (rc)
> +		return rc;
> +
> +	port_t2_base = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK,
> +			    ctrl);
> +	port_t2_scale = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK,
> +			     ctrl);
> +	if (port_t2_scale > GPF_TIMEOUT_SCALE_MAX) {
> +		dev_warn(&pdev->dev, "GPF: invalid port phase 2 timeout\n");
> +		return -EINVAL;
> +	}
> +
> +	device_tmo = gpf_timeout_us(mds->gpf.t2_base, mds->gpf.t2_scale);
> +	port_tmo = gpf_timeout_us(port_t2_base, port_t2_scale);
> +
> +	dev_dbg(&pdev->dev, "Port GPF phase 2 timeout: %lu us\n", port_tmo);
> +
> +	if ((remove && device_tmo != port_tmo) || device_tmo > port_tmo) {
> +		/* update the timeout in DVSEC */
> +		ctrl = FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK,
> +				   mds->gpf.t2_base);
> +		ctrl |= FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK,
> +				   mds->gpf.t2_scale);
> +		rc = pci_write_config_word(
> +			pdev,
> +			dvsec + CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET,
> +			ctrl);
> +		if (rc)
> +			return rc;
> +
> +		dev_dbg(&pdev->dev,
> +			"new GPF Port phase 2 timeout: %lu us\n", device_tmo);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_update_gpf_port, "CXL");
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 78a5c2c25982..0bd09669af68 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1370,6 +1370,73 @@ static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
>  	return port;
>  }
>  
> +static void delete_update_gpf(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *port = cxlmd->endpoint;
> +	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	struct cxl_memdev *max_cxlmd = NULL;
> +	struct cxl_memdev_state *mds;
> +	struct cxl_ep *ep;
> +	unsigned long index;
> +
> +	/* first calculate the new max T2 timeout */
> +	xa_for_each(&parent_port->endpoints, index, ep) {
> +		struct cxl_memdev *this_cxlmd;
> +		struct cxl_memdev_state *max_mds;
> +
> +		this_cxlmd = to_cxl_memdev(ep->ep);
> +		if (cxlmd == this_cxlmd) /* ignore self */
> +			continue;
> +		if (!max_cxlmd) {
> +			max_cxlmd = this_cxlmd;
> +			continue;
> +		}
> +
> +		mds = to_cxl_memdev_state(this_cxlmd->cxlds);
> +		max_mds = to_cxl_memdev_state(max_cxlmd->cxlds);
> +
> +		if (gpf_timeout_us(mds->gpf.t2_base, mds->gpf.t2_scale) >
> +		    gpf_timeout_us(max_mds->gpf.t2_base, max_mds->gpf.t2_scale))
> +			max_cxlmd = this_cxlmd;
> +	}
> +
> +	if (!max_cxlmd) /* no other devices */
> +		goto clean_shutdown;
> +
> +	while (1) {
> +		struct cxl_dport *dport;
> +
> +		parent_port = to_cxl_port(port->dev.parent);
> +		xa_for_each(&parent_port->dports, index, dport) {
> +			if (!dev_is_pci(dport->dport_dev))
> +				continue;
> +
> +			cxl_pci_update_gpf_port(to_pci_dev(dport->dport_dev),
> +						max_cxlmd, true);
> +		}
> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		port = parent_port;
> +	}
> +
> +clean_shutdown:
> +	/*
> +	 * Device can still dirty the shutdown upon detecting any
> +	 * failed internal flush.
> +	 */
> +	if (resource_size(&cxlmd->cxlds->pmem_res)) {
> +		mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +		if (mds->dirtied_shutdown) {
> +			if (cxl_set_shutdown_state(mds, false))
> +				dev_warn(&cxlmd->dev,
> +					 "could not clean Shutdown state");
> +		}
> +	}
> +}
> +
>  /*
>   * All users of grandparent() are using it to walk PCIe-like switch port
>   * hierarchy. A PCIe switch is comprised of a bridge device representing the
> @@ -1400,6 +1467,7 @@ static void delete_endpoint(void *data)
>  	struct device *host = endpoint_host(endpoint);
>  
>  	scoped_guard(device, host) {
> +		delete_update_gpf(cxlmd);
>  		if (host->driver && !endpoint->dead) {
>  			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
>  			devm_release_action(host, cxl_unlink_uport, endpoint);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f6015f24ad38..a83f8ed8d80b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -911,6 +911,9 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_pci_update_gpf_port(struct pci_dev *pdev,
> +			    struct cxl_memdev *mds, bool remove);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..670cf4f91c6a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -450,6 +450,21 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>  	return dev_get_drvdata(cxl_mbox->host);
>  }
>  
> +/**
> + * struct cxl_gpf_device - Device GPF information
> + *
> + * Cached Device Global Persistent Flush data (Phase 2).
> + *
> + * @t2_base: Base component of the timeout.
> + * @t2_scale: Scale component of the timeout.
> + * @power_nwatts: Required power from the device.
> + */
> +struct cxl_gpf_dev {
> +	u16 t2_base;
> +	u16 t2_scale;
> +	u32 power_mwatts;
> +};
> +
>  /**
>   * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
>   *
> @@ -477,6 +492,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @poison: poison driver state info
>   * @security: security driver state info
>   * @fw: firmware upload / activation state
> + * @gpf: cached Device GPF information
>   *
>   * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
>   * details on capacity parameters.
> @@ -503,6 +519,9 @@ struct cxl_memdev_state {
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
>  	struct cxl_fw_state fw;
> +
> +	struct cxl_gpf_dev gpf;
> +	bool dirtied_shutdown;
>  };
>  
>  static inline struct cxl_memdev_state *
> @@ -693,6 +712,10 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +struct cxl_mbox_set_shutdown_state {
> +	u8 state;
> +} __packed;
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -829,6 +852,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
> +int cxl_set_shutdown_state(struct cxl_memdev_state *mds, bool dirty);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..fe7d92ef538f 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -40,9 +40,20 @@
>  
>  /* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
>  #define CXL_DVSEC_PORT_GPF					4
> +#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
> +#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
> +#define	    CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
> +#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
> +#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
> +#define	    CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
>  
>  /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
>  #define CXL_DVSEC_DEVICE_GPF					5
> +#define   CXL_DVSEC_DEVICE_GPF_PHASE_2_DURATION_OFFSET		0xA
> +#define     CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_BASE_MASK		GENMASK(3, 0)
> +#define	    CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_SCALE_MASK	GENMASK(11, 8)
> +#define   CXL_DVSEC_DEVICE_GPF_PHASE_2_POWER_OFFSET		0xC
> +#define	    CXL_DVSEC_DEVICE_GPF_PHASE_2_ACTIVE_POWER_MASK	GENMASK(31, 0)
>  
>  /* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
>  #define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> @@ -129,4 +140,57 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +
> +#define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
> +
> +static inline unsigned long gpf_timeout_us(int base, int scale)
> +{
> +	unsigned long tmo, others;
> +
> +	switch (scale) {
> +	case 0: /* 1 us */
> +		tmo = 1;
> +		break;
> +	case 1: /* 10 us */
> +		tmo = 10UL;
> +		break;
> +	case 2: /* 100 us */
> +		tmo = 100UL;
> +		break;
> +	case 3: /* 1 ms */
> +		tmo = 1000UL;
> +		break;
> +	case 4: /* 10 ms */
> +		tmo = 10000UL;
> +		break;
> +	case 5: /* 100 ms */
> +		tmo = 100000UL;
> +		break;
> +	case 6: /* 1 s */
> +		tmo = 1000000UL;
> +		break;
> +	case GPF_TIMEOUT_SCALE_MAX:
> +		tmo = 10000000UL;
> +		break;
> +	default:
> +		tmo = 0;
> +		break;
> +	}
> +
> +	tmo *= base;
> +	/*
> +	 * The spec is over involved. Do not account for any ad-hoc
> +	 * host delays. Ie: propagation delay, host-side processing
> +	 * delays, and any other  host/system-specific delays.
> +	 */
> +	others = 0;
> +	tmo += others;
> +
> +	/*
> +	 * Limit max timeout to 20 seconds (per phase), which is
> +	 * already the default for the nmi watchdog.
> +	 */
> +	return min(20000000UL, tmo);
> +}
> +
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6d94ff4a4f1a..37d5616b6fc8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -900,6 +900,101 @@ static struct attribute_group cxl_rcd_group = {
>  };
>  __ATTRIBUTE_GROUPS(cxl_rcd);
>  
> +
> +static int cxl_gpf_setup(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct cxl_port *port;
> +	int rc, gpf_dvsec;
> +	u16 duration;
> +	u32 power;
> +	int device_t2_base, device_t2_scale;
> +
> +	/* get the timeouts for phase 2, given by the hardware */
> +	gpf_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					      CXL_DVSEC_DEVICE_GPF);
> +	if (!gpf_dvsec) {
> +		dev_warn(&pdev->dev,
> +			 "GPF Device DVSEC not present\n");
> +		return -EINVAL;
> +	}
> +
> +	rc = pci_read_config_word(
> +		pdev,
> +		gpf_dvsec + CXL_DVSEC_DEVICE_GPF_PHASE_2_DURATION_OFFSET,
> +		&duration);
> +	if (rc)
> +		return rc;
> +
> +	device_t2_base = FIELD_GET(CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_BASE_MASK,
> +			    duration);
> +	device_t2_scale = FIELD_GET(CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_SCALE_MASK,
> +			     duration);
> +	if (device_t2_scale > GPF_TIMEOUT_SCALE_MAX) {
> +		dev_warn(&pdev->dev, "GPF: invalid device timeout\n");
> +		return -EINVAL;
> +	}
> +
> +	/* cache device GPF timeout and power consumption for phase 2 */
> +	mds->gpf.t2_base = device_t2_base;
> +	mds->gpf.t2_scale = device_t2_scale;
> +
> +	rc = pci_read_config_dword(
> +		pdev,
> +		gpf_dvsec + CXL_DVSEC_DEVICE_GPF_PHASE_2_POWER_OFFSET,
> +		&power);
> +	if (rc)
> +		return rc;
> +
> +	mds->gpf.power_mwatts = power;
> +
> +	dev_dbg(&pdev->dev, "Device GPF timeout: %lu us (power needed: %dmW)\n",
> +		gpf_timeout_us(device_t2_base, device_t2_scale),
> +		mds->gpf.power_mwatts);
> +
> +	/* iterate up the hierarchy updating max port timeouts where necessary */
> +	port = cxlmd->endpoint;
> +	while (1) {
> +		struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +		struct cxl_dport *dport;
> +		unsigned long index;
> +
> +		device_lock(&parent_port->dev);
> +		xa_for_each(&parent_port->dports, index, dport) {
> +			if (!dev_is_pci(dport->dport_dev))
> +				continue;
> +
> +			cxl_pci_update_gpf_port(to_pci_dev(dport->dport_dev),
> +						cxlmd, false);
> +		}
> +		device_unlock(&parent_port->dev);
> +
> +		if (is_cxl_root(parent_port))
> +			break;
> +
> +		port = parent_port;
> +	}
> +
> +	/*
> +	 * Set dirty shutdown now, with the expectation that the device
> +	 * clear it upon a successful GPF flow. The exception to this
> +	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
> +	 *
> +	 * XXX: For non-fail scenarios, this is cleared by the driver
> +	 * at hot-unplug. But, what about reboot/shutdown case? Is this
> +	 * done by hw if no data integrity failure is detected?
> +	 */
> +	if (resource_size(&cxlds->pmem_res)) {
> +		rc = cxl_set_shutdown_state(mds, true);
> +		if (!rc)
> +			mds->dirtied_shutdown = true;
> +	}
> +
> +	return rc;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -1038,6 +1133,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (cxl_pci_ras_unmask(pdev))
>  		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
>  
> +	cxl_gpf_setup(pdev);

I would not expect this to be called from cxl_pci_probe(). A more
natural place for it would be cxl_port_probe() because then you
naturally get coverage for every CXL switch port and endpoint port in
the system.
