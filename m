Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC7D271
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720661708; cv=fail; b=IUlYez9ru+FO8zzHsI1/t/rWUep1ybRej+lhHKSrB8AAATZSDfyVFWQf0Vp04kysoyB1mKNgNkHQxIeErxNoqEVOz4IwHGMXPYVrQz2Eo3HK8FBUbXk08LGmpy0ggNKRBZcxUSpJ3gcYvRYOC3Vx0Kkyb5PMsQgmUR7vrjQXbQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720661708; c=relaxed/simple;
	bh=DigZhLDdDLe6Ak1m1GnSP0pIhlzCyj+bx2p+EYvWj2M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j5mX0kdaSMmY04sw+cfe3UXCQBEeVPYyX0Xx1wTD6E+6bRGhBYylFRxdCfNSBjEvqLntrb6kmFCRwXq/V7aynBNp0CUEW3x+SXTkK8Qx9m9k9UnUZFyS+4R1AmWcLJix0DdcLAjXvUMjnLr3wR08tzpWn5zL7dJhwF5z+Pet65U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llwth2bD; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llwth2bD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720661705; x=1752197705;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DigZhLDdDLe6Ak1m1GnSP0pIhlzCyj+bx2p+EYvWj2M=;
  b=llwth2bDZ6vQpriBlcF06VHzCbvkfh44UBtm5evNRGW+GExw6Qle5ntn
   GjXT2aWY8W0F7gCpxGORRn/JhZwE9YeFy8fh5yphd3OZ6CTJ5pf5nWkrd
   OT/kSqcd6qD+m7JB3ygkn6TvofX/50KsQInyU8K5DhzU/Pq06SKxKFHfj
   BMadQkl9gtWq5V2hXKWj5jk01Y5ny5UBlwPtmYudaM002IdUNbK++arEa
   GiKSTQyunVQU1pgU6celp6D+YDmpaFuP39qtYCFTGmxDCH9Hc5wK9Ji4K
   D7Lvz9Lw+UfKJMYjJYJcUjD52c7xMOP+uQ+D2pW/VMt64hvkkIDLnOagx
   A==;
X-CSE-ConnectionGUID: 8rzauIBbTxit+6tZangDog==
X-CSE-MsgGUID: +8f9gRwVR4CpdrqHvUm4Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17890318"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="17890318"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 18:34:59 -0700
X-CSE-ConnectionGUID: ScLzVSO1R3y5Pn+WEoh4fA==
X-CSE-MsgGUID: 7mcrYFzvQJSgPZageRdUJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="52999912"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 18:34:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 18:34:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 18:34:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 18:34:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIlDATc+4LSqzTEwVf8x4LAHXA/aJEauHIm/4j1H1FHWqMwEvrNT36Gm42a4PVCrN3g55Z97vIvjn9Fge4R351+2r2jP/rfbGakvQM7pyPDN9WQ1Pmr1AYXdOxItmfDXpznBp64A5OY81xdgBdZmyJ8TpqQccbD3sdB4z9vZe7jLX1+xg9NmEVnpO6qkahw1m8+goXLONREEXIAWlDKJVU4r+DbobyaS1vrwveXJjcYY5V/Tfb9AHXHVUCCQ0NiT8lw5fpu/FNgv6+4WkEi64iZujOfAp+bBLBEOBeTC+7zfKEhiX4AqeWkcZnDQ8gx9VSqI0MekJh29nQVu3i9iOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUHWi1E1SPJmZ2yh3LJ+Rn6iEZG7YlpZKHDIfO4RX4M=;
 b=SG6kiXllCaxXBJilbCNn0iA1auItyEmfNrFsitcTINQnsgVah87hVqyAXdFCHY3RWJcQPbeIAmb3YJydcdUJ7XmZyKdU+YR1YiE4e3lwJpHJ0b2Y3BUdhgx7TvkvCgObH5M/q8lUFVQDx0HZTiCkYVySc7CyjpD4oBKNM3hkBAnDHUJslvZrL84wlGP0A6kM4HyF5pmjoZzEIKYQA/YcrzfUu/aQL70FAWH4Ucgb1DWS0FvCq/p4TiZjHiBLI6iQ//QHu1kzJyy5s2MYGhvHiJDtvlx4Zlc1a8JzNGESS5UdpA637HorpAsB9+wRrbi5YTTtRd+SWY1DPXYn3sewhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7336.namprd11.prod.outlook.com (2603:10b6:8:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 01:34:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Thu, 11 Jul 2024
 01:34:55 +0000
Date: Wed, 10 Jul 2024 18:34:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>, "'Dan
 Williams'" <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v14 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Message-ID: <668f36bd17043_1bc832949f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
 <20240618042941.96893-2-kobayashi.da-06@fujitsu.com>
 <668df392f2036_102cc2949a@dwillia2-xfh.jf.intel.com.notmuch>
 <668e256583728_6de229444@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <OSAPR01MB71829D3B273E919435A1A86BBAA42@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSAPR01MB71829D3B273E919435A1A86BBAA42@OSAPR01MB7182.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:303:6b::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 880b9a98-8077-4d0c-13c9-08dca149ab3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZmDo/fCvjXQDzzjnJYiHoDJRhm64GgX6onXIqVRnwMDQ6ovYl+cRvPdoxvUY?=
 =?us-ascii?Q?NZ/K6VrhG16F8nrHtYeO50BD9QVzIz++K1Cd0keaYTvY0NRBc7nieuO8t2V4?=
 =?us-ascii?Q?t8jTWwEXqj60+0OrxHn8lfkGBLOmbKrMZTRcmFXbVrTZUknnHwpSLTFI1Fgi?=
 =?us-ascii?Q?av6EroJ9pe3P1p3yPRPMnVWr5kat9YwEvNsvNVCfBAjijXhZkCjMrnlRrzIW?=
 =?us-ascii?Q?hTfE+hlwiPfreXX27adcxbLZ5jij95QLF+QXCFl4bC5XQLL8HbFTAJovRLEN?=
 =?us-ascii?Q?KSscnNYnc+03LP4hDmWzIEWq5uKuFYS2wAWqLGzNTAx9vIstw5E6JIWbJbtv?=
 =?us-ascii?Q?w/UaneJDA58Q1/iqK8MDDWdSPzdF1I5tbbDKBU5Q9vWerQqRVa/39cYPtQtj?=
 =?us-ascii?Q?H4KO35ImU+LymMsyZbhyzbNYvF/j/tY08Am8Xj4fEnKK7FGWITS9A1ZyhuXo?=
 =?us-ascii?Q?DrYITjIwWY26u1PRm10TpyyjQV6iVoi5WqMd3184wz4Ioe4uCA06LaMdJE2Z?=
 =?us-ascii?Q?aqd8lsTmXjouAMGQHdZnY8NrKrWIujbDdkiofaJW/PnsT5oqltz52QXikHGJ?=
 =?us-ascii?Q?61FrJTwvhynLUSj8kVGIBYdvJmHoF/MQbADpZDBBq31sAsYkbZ5AwQwSlXTW?=
 =?us-ascii?Q?17hL2q+9EtMrXBD0q/y4Kje6qd38ZTCqjXlN5Qo/yUYC00I0LTMVDUhvZ+xz?=
 =?us-ascii?Q?+wsQJ3RqClHHo8KbwlpPZC/4n61ctKa6pj+f1RuJPk8AVTThSxrkxZm8JZ6m?=
 =?us-ascii?Q?5lXiyrYKpCiVjBWT3ZucFHSRd4CCJP0ENcPTVVMPcgeszg/sIM5hSEBQxPX5?=
 =?us-ascii?Q?PYLDWjBrlqEZ9LRf/ak1eoKJsy5nYNkwptbMuAz52U0AuoRYfohOCnnD6PQz?=
 =?us-ascii?Q?r94DrIMpbVdExIYmq8H/DIux+iufS8J2v1khLCZN+/CwMAV0ZECAvtEXZvj+?=
 =?us-ascii?Q?p+dWZ1rhQ3Y56fjgejCIXZRAN0h5ibozTJwYbBf9rNP1B7cJU/uYRMsTlsVt?=
 =?us-ascii?Q?lkae9vBH1c7GohUj8R5R0sLqe2p7k2mT0T7X+AeuFbJKtm7V7QH/DnzD5OrH?=
 =?us-ascii?Q?IuOtJrhvZelgIB5UYz2dIYbZRh2zBLhXWZykbd1LfteLjtFWY3vxy4i3f0uA?=
 =?us-ascii?Q?u80PGVpWf/l7PVIkD+9zNGqHwb4+0qDRtQa7fOY/Vd3uZCq1x4SXNN3XgAFn?=
 =?us-ascii?Q?kqA/O9TkdT0vyMEZeCCvo8S3KUKOYEqppOVwVl/HvolDdE0Ywp7719cmnuqN?=
 =?us-ascii?Q?92YKIbmsHDcgm2ajTrRCkMNyec6QPFOQqgNi6imxHVIfeUOAh4XIYbSnqQqU?=
 =?us-ascii?Q?CfKljCNWRLkm1peRUNeUXRAaka6Ee4u4v+VMMbW3hAuzLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?27FjtPRTX3R7SqrxpdTO9oze2O90gmzl5d26QHEmhbQu7jC+LHfd+KkJzUos?=
 =?us-ascii?Q?3CRENpPOJDyHWR+eGx1j34xFQOSJenVeGNMI0En4PqYi9idPF8qj9NiQ2EbK?=
 =?us-ascii?Q?y9JMqfCfS7gvcqp1IlwSc+GWIq/IUG9qaerLkBvZXu5QKiqpsQiWbnshOpuh?=
 =?us-ascii?Q?3BVrzF2yC6YZlGzO9HnWWYzVUVq2e4aeU0j2dmaIkB+XPwotRVQuNgmroGDc?=
 =?us-ascii?Q?7Io587DZQcZjbBw9ueEGimMX9KYi9eOeE/I+MACQqoDFN3+sVgJ+Ct3zBmg8?=
 =?us-ascii?Q?ZUjpwKMp4sD4MFRAj03e8iMHHtV/hO5eMQ1m3G66WLRCgwdJgpIQu/WqfQFj?=
 =?us-ascii?Q?dhXbZJSdZ3fgBk3RWSdzTYUvYlK8LVJj0lnuax8IdvStdy/xe0g42QKsAYlp?=
 =?us-ascii?Q?AxbgwN2NVf0+UhNW0ZF4CrDSUJWvyjCY8QdzzsR7iyy4kUww+Q5gTZbu0vxw?=
 =?us-ascii?Q?HrW2XxtBPNpJaOQO0PiAdOOBCWGpWmaNZd4JF7+NBLQKRXIpckxGoOPvOrbw?=
 =?us-ascii?Q?2mvRBrWQULuVlaF3O6SF/1gwlXPxQZJp+8CKCFk+ymLLYNBq2g5Ut0gdfMFV?=
 =?us-ascii?Q?J/VQBLu3IWELVM2xY6SR1587mxP1Z/VpINwO6yaRpDzEIbGAHY3wai89D1RJ?=
 =?us-ascii?Q?nMWtf6t/eXKQY5Wnd3mDBWngsX/SaHOrlRTvsKA7JQRkiiIWAdQV0PvFD4Bw?=
 =?us-ascii?Q?mKFuOyHqcy4F10x+DsitZuOvuL2lkqLy7GwqfI5Dq8SWucRe3RjG2z8K+TVr?=
 =?us-ascii?Q?+EUyW6gOFQc2Nr9Id+7GzvWZbh3Gz3pXZjewxD+81ydCwG7WNmWWwC4hnemN?=
 =?us-ascii?Q?0NzyIWP2DvR4UqJgT+jRF6s9L32kT597wU7dJiXjbnX/eQvnma6P5B6Xv1I0?=
 =?us-ascii?Q?EYjeE+LV7KBuuZHSQLCyd1qIOJvgB+9c29/msN7Q7QfmUtI7x0zNo2QgvNIO?=
 =?us-ascii?Q?xsa8K4p6GaTGe+R/AgQKnRLo+tE4kwJCCENftRkSH93wAy5YTl/2xzbGLxaX?=
 =?us-ascii?Q?pJpFOsoGgBNqOOL0bRbcXhBblPJw0+kdhPvFaXGOWAG5Aa+PhjtSbriwzEal?=
 =?us-ascii?Q?XgIomZL+6ebLVFIXLnG0odTuLdkvaYxUEGSyE5UnVB7t/S39jko6Ogaer3qh?=
 =?us-ascii?Q?pgdAhxsTO72KZV+c7u69GGKLTJakV1df0mZLKoEa/h+9eeZhn0HoqxQsLow3?=
 =?us-ascii?Q?KByRFbcG3NXB7fCh6Wms6HwXkX5+d3oJeol/xYN6DZ23WlzRmp77Wf1f2fRB?=
 =?us-ascii?Q?pZvC3oCgGYbV39CB3XJeBUoBc6sxyIJoPkz+S48yH3prtj9yDqayderkXiNz?=
 =?us-ascii?Q?2tm6VeauvLnea5G7m1RPs8MNumOexW4nRFmwq14fUbtB4GlB8HQ9P78+9pbl?=
 =?us-ascii?Q?mHbKrQNASfV5o/aAtzSkTXjVnCwmV++Qhr9ji/7krBGpbv7QheSv6oTQJyIn?=
 =?us-ascii?Q?Ruonv1vncvYrzmWFrdTVjGK6PjyOHDBht7gy4J8vzwIri8HEwGAOGNScBP/U?=
 =?us-ascii?Q?YILhrTE5mOwGMhbfQEK1m9rGtJhcTEolhzlkbCqTotQhEC/cmolHedUQb49v?=
 =?us-ascii?Q?t6gL00MI/uVQGCT1b/8jfPAWzwYN8Ff4xwJa80fx9zXL0BmDItHg5FBf1UWI?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 880b9a98-8077-4d0c-13c9-08dca149ab3e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 01:34:55.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbxiAoCe8RckCGzydFIuobM8meGIg+H4sOSolWOyi2ZF2Jw90Ha40zWyhtDSkrcdjHG3suwhQeHiB5TsxpGHuaOq0rG1DjaiKaynEAxIe+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7336
X-OriginatorOrg: intel.com

Daisuke Kobayashi (Fujitsu) wrote:
> Dan Williams wrote:
> > Dan Williams wrote:
> > > Kobayashi,Daisuke wrote:
> > > > Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1
> > > > device link status information. By caching it, avoid the walking
> > > > memory map area to find the offset when output the register value.
> > > >
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > > > ---
> > > >  drivers/cxl/core/core.h |  6 ++++
> > > >  drivers/cxl/core/regs.c | 61
> > +++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/cxl/cxl.h       |  9 ++++++
> > > >  drivers/cxl/pci.c       |  8 ++++--
> > > >  4 files changed, 82 insertions(+), 2 deletions(-)
> > > >
> > [..]
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index 2ff361e756d6..bbc55732d6c1 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -512,11 +512,15 @@ static int cxl_pci_setup_regs(struct pci_dev
> > *pdev, enum cxl_regloc_type type,
> > > >  	 * is an RCH and try to extract the Component Registers from
> > > >  	 * an RCRB.
> > > >  	 */
> > > > -	if (rc && type == CXL_REGLOC_RBI_COMPONENT &&
> > is_cxl_restricted(pdev))
> > > > +	if (rc && type == CXL_REGLOC_RBI_COMPONENT &&
> > is_cxl_restricted(pdev)) {
> > > >  		rc = cxl_rcrb_get_comp_regs(pdev, map);
> > > > +		if (rc)
> > > > +			return rc;
> > > >
> > > > -	if (rc)
> > > > +		cxl_dport_map_rcd_linkcap(pdev);
> > >
> > [..]
> > > Ugh, I was going to say copy what cxl_mem_probe() does around locking
> > > endpoint_parent before attaching further ports, but that also appears to
> > > not handle the same race. I.e. I think cxl_mem_probe() needs a fix to do
> > > this as well. I will copy you on a proposed patch for that.
> > 
> > I attempted to add the proper locking to keep cxl_dport live, but that
> > runs into lockdep issues.
> > 
> > So I think a better fix is rework dport lifetime to stay alive until the
> > final put_device() of the port. In other words dport instances get added
> > dynamically to the cxl_port, but only get destroyed after all port
> > references are dropped. Then the @dport result from find_cxl_port() is
> > not ephemeral.
> > 
> > Given this is a latent bug that affects all current
> > cxl_{mem,pci}_find_port() users, the planned fix is to just make dport
> > lifetime longer, and that I will not have time to do that rework before
> > v6.11 merge window, then I am ok for this lnkcap code to introduce
> > another instance of the same bug.
> > 
> > So, just make cxl_rcrb_get_comp_regs() and cxl_dport_map_rcd_linkcap()
> > share the same port reference from one cxl_pci_find_port() call.
> 
> Thanks for checking.
> 
> I'd like to confirm my understanding of the comment. Are you suggesting that,
> due to time constraints with the current patch, cxl_rcrb_get_comp_regs() and
> cxl_dport_map_rcd_linkcap() should share the same dport reference as a temporary
> workaround for the bug regarding the dport lifetime?

What I am saying is forget the bug for now, just trust that the @dport
result from cxl_pci_find_port() is valid until the put_device() on the
port.

> If that's what you mean, I think I can solve this problem by adding
> "struct cxl_dport *dport" to the arguments of the two functions to share the reference.

Yes, that's what I want for this patch, but to be clear this does not
fix the bug with cxl_pci_find_port(). That bug needs deeper work that
you can ignore for now. Adding another cxl_pci_find_port() user just
increases the urgency to get that bug fixed.

To be clear it is definitely a use after-free issue, but it needs root to be bringing
ports up and down during the "cxl_pci_find_port() ->
put_device(@port->dev)" window.

I expect you could trigger a crash by a "modprobe -r cxl_acpi; modprobe
cxl_acpi" loop while accessing these sysfs files.

> In this implementation, I'm planning to run cxl_pci_find_port() in
> cxl_rcrb_get_comp_regs() and share the dport obtained there. You said
> that find requires a corresponding put_device(), but where is the
> correct place to run it in this case? Or is it better not to run it in
> this patch?

So the ordering I expect is something like:

	port = cxl_pci_find_port(...)
	if (!port)
		return -EPROBE_DEFER;
	rc = cxl_rcrb_get_comp_regs(dport, ...)
	if (rc)
		goto put;
	rc = cxl_dport_map_rcd_linkcap(dport, ...)
	if (rc)
		goto put;
put:
	put_device(...)
	return rc;
