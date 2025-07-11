Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0F28DF27;
	Fri, 11 Jul 2025 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250843; cv=fail; b=SK9Ap6Q5Zccylvh/yXkleP5llw3pQEJPQN2kkNDhhB0kIgZii7wW8ASlFOaMnmLJ5kZ3SEN7O8wynBQQx5t/VKI5SaMHZ7L+keyd66chGEwmLwg1s46MVqWpcCNjKtQYqkjbxqzMZKQ2+n3pQ8u3bFbolPi3XMjUjGNOKv/+3+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250843; c=relaxed/simple;
	bh=TYUwfF+VhOnVtQt3n631oFEEbxrlUYEJpwcTqBoBPNo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p8EStIMhiv60Xwc8zNh01jtRycyhIVZ2IsbGi/g6jA8/dqRoR3bGC61gYJKh0tOASfN5j3GEUkZcWkq8k3+ABk2q5pqCXJo4/+ZckIz+CwKBmOL9duhafl+MwO91vy5TJ28OEwwg5Yi2Cbu3PaTqzdPbu7XCgMvRlhX67tgz428=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1qEXuXD; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1qEXuXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752250842; x=1783786842;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TYUwfF+VhOnVtQt3n631oFEEbxrlUYEJpwcTqBoBPNo=;
  b=T1qEXuXDyb4/jOWAcAc/e5pN0Jfkd5kmAbNmWiWmeYjTEG1gd3UkkXaq
   ZdjfYuq2ix2EyLu2XNeEXWcNHMCxebdC9hA9gCpx8e8OzJelrkVCs/U0O
   Q8vNu1jG8gxPTQ8RLw6f7KP5hsJlcd5lZJwFxl1C7lUFHnwfXnJvTNtDh
   m1pamzl9mkjyUhn0HAKb5cJOmc/dB5ORMnnhC4pYNout7Gd3EccMrsmiZ
   RISfFVw4pZGUEIDWPNYS+xoFwBCYBSbsBK9rBe2SfRiCBICDR+1+bBVkV
   robJYJdmfK90ElPcsSyKcA8Zr0+bO30k7oFWemJYC3UPqyizuM61Lcp81
   g==;
X-CSE-ConnectionGUID: xsZLXbJCS5CKHyZ7kNeLVw==
X-CSE-MsgGUID: qeQBI1a3TRWyXGyvrQag7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54409338"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54409338"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:20:41 -0700
X-CSE-ConnectionGUID: S/2b5Ka5QuiMoqXBBrC+ow==
X-CSE-MsgGUID: XTJQJO8vTYC6aL8CJU35dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156737979"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:20:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 09:20:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 09:20:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.52)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 09:20:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9SyuLs9mcMm8Ymb2hA/PcepQqvgiFkFH9EeM0AXe7qsG0W2/K3WgxhEKmUsJqtG6KstHJsWBaQMqaeV+p8GB3ZVw1e4AaxGzpTUzO/7au9UclQwRcPyIqVD3fhp3vvWI869YTcGYuciQ0KlgbUl8qvnnOlCzRhTwmbA4gX/aDskQQE0BJr7O/fw9cH+XDWMpGNJQX6bOUD88C1P4uMaIQ3Wy+wPEwndTYE5g3wuDvfX0MAATyc49ygjOtNJz6uQfHvctj8i7kc98Esr6yK/KdeMEkzQQHhlTvH+se8uUqdXs1V7b7Md5gh8tsIxl9o0U62odlxOqBQxH/Osv89ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LhRQzvbub7inyxCGnN6YlWVpgssP3V98AvMHXq0ktU=;
 b=WcS+pgrRQB7kI8xCrnwMYJOYyYz+vw2eTD7q/JKtE0DGBO1T9CHIkM3/ULV9S1sZS05FAhyqgeVMjm1OFVYO95pnVu5uBikQTvhZd22GjESzXg5o2KqttUprCf12UTQffHmUWEk5XoJN2pJQcfHPRZI5i3xrNiQ+h2vIl1nu2RC4xEfkoQuDb8XBCRZoUnvD6S716TX0By9Wq3d2B4OGCs6ji4rxyCNrBpQrCKj1kty2flKhryJKcFlXiTQMbuMO3W89y2tv5wrDY8fCkqnfGylKPjECFk8ZJtzp/60a0tbPkoyXS5D5mQQw3jGncNpjehdzaxzsPXoJidhBTiP0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB6889.namprd11.prod.outlook.com (2603:10b6:930:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 16:20:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Fri, 11 Jul 2025
 16:20:37 +0000
Date: Fri, 11 Jul 2025 09:20:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] cxl/core: Introduce a new helper
 cxl_resource_contains_addr()
Message-ID: <aHE50H_sex8kjkfU@aschofie-mobl2.lan>
References: <20250711032357.127355-1-ming.li@zohomail.com>
 <20250711032357.127355-2-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250711032357.127355-2-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:a03:333::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9c5335-e2ba-4304-2ffb-08ddc096deca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uEQpcHMSzGppf71ytoFtMlD0oYroo7+bRSTSCA5Rh3auX3jMikX4yol5OZNJ?=
 =?us-ascii?Q?ACh37n6IqehCDo3Hl5U6LhAK7uqbGrTKdKFl7a1qu/i8+bQYH3cssbVA/VxS?=
 =?us-ascii?Q?AaFahGF8zDphBjgSBVouSfI7vDG6kJweiXFD+jdKS8wOwIiuDK1shBxrE98I?=
 =?us-ascii?Q?DBz0U1g1rx7oC1t5u4Te9QHk5EfX3tU7elIAMOzOyW3oGsuGsiH/sEFqhv1H?=
 =?us-ascii?Q?dUP3IrOaJULb7mo8iRfR32HRa2qYtM3o9IpP00oHOd8DXIRE5++kXqTNXqoy?=
 =?us-ascii?Q?rTS8ymPdbH1ATdrdAXA/27dPs6lQoH8CNekM+OjVB6dTTfRJKx72tFDTghfX?=
 =?us-ascii?Q?qwihxs44fuWlNZI74XDs/AavJIxROuGmw5K2dLuTtoGmmrjA3Mv7LTzb8Q7m?=
 =?us-ascii?Q?+rHcG2QrT+n1iChcjBf5lS33EYYNqGcPKxxc4fbGBzy2XF+GthFt8yYqu5Kb?=
 =?us-ascii?Q?IM1+AbCeWOU39Zv+vwT1NkFVBuQLm1jXtSLiCCAB9EFaXgL1PY1YSHBtCKOd?=
 =?us-ascii?Q?eqNLDCTfJasWsFrY2VoWpKnCIAB7eHOhNU61qiBS33dijoqdKyccMiuIjNif?=
 =?us-ascii?Q?vlFdzyRlceJiMkFFaxwhJDseYRBOFSj6MQSjQ9HrL26wouw9Kv5VUHWABMdQ?=
 =?us-ascii?Q?xeLJCzCirTkQy+NAcJHcpVQs9vUgqZwwMUDRo7Ork1kXJBWcv1N9hAUjFoKg?=
 =?us-ascii?Q?UKr0XENa/4MY8OGE5rd6UhPDi4pxJDFgtExbiNdnwVGLvsr2WG9fSl1897tq?=
 =?us-ascii?Q?rfa1UwYqpZFtwckl3gV/zknsCCa+Q8aL/mHEXNeVmwfhIJG7+GhDqhBjVFr0?=
 =?us-ascii?Q?yFHDtL6G0dl4L8fQLB60KRczaDbnplBCDO4vowJepVjXP3vWUz1+nim0JewC?=
 =?us-ascii?Q?M2+naigc1VM6eLJ3uoybBJW4zjAFSV8KAdp1BKZlCZCVKwEdmXj3luwzU0at?=
 =?us-ascii?Q?lUec5LBKWFQYNup+Z7DroZaQr+QOzDEEvQLJknJ5HE1KGV9hRptGWlOzkh//?=
 =?us-ascii?Q?wlqM5QYxbcuiRm8D3XWuq7Z/HO9j192pVk55IMPMgB2GbUjlK0rG6fe4Q6gT?=
 =?us-ascii?Q?aDD8Xd80hsj1m8dTiwsnCY62C8e64zmlOfRRQiSFECtSlEb+ZslW83Sb2zbV?=
 =?us-ascii?Q?L3gjAOxOi7XZEZv/IJFvKcfY+g3DpiK9mnDmIY8qvF9xvvqUNcBZp9BPXgBw?=
 =?us-ascii?Q?hGhvBig7W70vzBxohVRy1pUaTDHEwF4EaUMSmk+amBIzjljGTz7STAeAZrg+?=
 =?us-ascii?Q?kmyiFfYpk4S8SC2V98nx4cKrsp6KadvTdiA+hrxTUOQawonXdXsILu5uHUCf?=
 =?us-ascii?Q?wXBLOy166XrvSJS6dcnpgowPMNEQX/Epxm+MwCjiMWKrOiUDK0MwwOcHESYT?=
 =?us-ascii?Q?9Lgxj59ZFmR3C5U7sg0vMf6tzg6sviD+VjF4RyCyDbYFH6lE1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lzmWvGWBKKwKopebfBpwDLL6xjYK6UbLp0sPY1DIDNOo0/4tpqIgdpT4U1kX?=
 =?us-ascii?Q?OefpJIJROU6PWZhEvCWfD5v1qUAkGrHjSDiAOCI94AXuzEFxVV5NuFbV6whg?=
 =?us-ascii?Q?4gm9u+ps9t/X3kOvMed0WhN4WqW3rSM0gUf0WfKlkiEhHNwGIr//WvYH3oEg?=
 =?us-ascii?Q?LFfP+e+Aipx7ESTewNJoMKFfA5Pm6/YhREZNSOyleMdkybBL99BvKPFjg/8B?=
 =?us-ascii?Q?zihH/n+N0MhJXQKUD3tE/zngEoUi38d6B62Sk1g62jJAQrfXd8j/Abwo223l?=
 =?us-ascii?Q?7e+G0t9HB3CFERm0T/z4hU6+3yw/b+TKqvVj+2eylY9N7HGGtLTaSrOHSYSG?=
 =?us-ascii?Q?m3592iqY5FUW6nSwUth688incv1kpO6e1f/WJffL66Ny9XftjXI/Cu25Frsg?=
 =?us-ascii?Q?YwgIjJqPDrFLWJ5mdposdd1If8hTuT25Qba4DxeJQZoxVzlshBab04va7H6/?=
 =?us-ascii?Q?EMxvSVqh4XNB0R2sJxuCOWHhJ9BrX8SeFlaqNrggCb83fcEB/bUfA/vfwTgS?=
 =?us-ascii?Q?GmlNTj68yrUvX3A+9DwesTc41kekAzHkyDDlkkRP5XEp8hW8+TUq3Xuuu4fd?=
 =?us-ascii?Q?PceuVIrP2U0FS8F4HhsGqKxp6I3Too7W+qGIhiEGNXvbxnJrqRlzuYWiWEnG?=
 =?us-ascii?Q?/29dvwDqW9n9mzJXE5pain3+rq2oHSnKAy8OeFwN+0NNgBDO2wlHTvXBsfVZ?=
 =?us-ascii?Q?5ZMU+nlV7f9NUp9jrmII/wbwQwVLpxbzTteVRc/5ZhuWGU6JxMP20xTNRBRR?=
 =?us-ascii?Q?yd3gcGG56SpS4zIU1wDKS2rvEt4QDcmT0/zdKbAvdjZL7l5dwlJAYmhco0Wz?=
 =?us-ascii?Q?4wXSil7Q6QFfa2jTB1skpX7/LVy3Klgar1Tsr1fhhhr+5/I9dUsoq0C45kYK?=
 =?us-ascii?Q?NlXcMMwOPWE2o2SRpOy6cbrioaVIJAY4nAAzvjWfnNKsB8gi2mehLwXdTfwL?=
 =?us-ascii?Q?JtLA+OgnLnyRCCndAcSlRvtwkZwgvMPP1Ts2u+8WK62WYqD1MMjl5b2F8alh?=
 =?us-ascii?Q?/H4ZLXMqJgpqdhZjVVxZpX1dYwBiF25UG9Dlr1PvjsK1nFLRhjwp6YU40emX?=
 =?us-ascii?Q?oywPlv3EjauSdPBXSn5DvN0q9ymANl3rIIVuPVO+tTGVaWvUgyO3bRwYHerf?=
 =?us-ascii?Q?CjUTMLVGo1AC0q47FJIf5anZRQTAXTQpNJGLi1NYNoW48DGkErvDzbIntJjC?=
 =?us-ascii?Q?UgFosgNvfYBy9sNkEiBTYtEW6WUL5TzYyeN4p1ubek2iRp7anZH5SWcGJ3vY?=
 =?us-ascii?Q?X/gurFld+5DILiwlUcz1nlM8lxCl00zNnSShYN5ZfaY7PxoAqabTD+l3U7Bs?=
 =?us-ascii?Q?OqKXzvU6lqxIGzSADrp3gn4+W5bjONUaqt/zBAwZEoFIGwAZjAhRxwFqWAO8?=
 =?us-ascii?Q?O7IL4OmFFw3fOtAcbZvGTtRWHCP/Upzn4zdUt7BW+5FOQBn/6SI+GdAA1dSH?=
 =?us-ascii?Q?Cx615VMDv3Qk+qonXwCND7HVDDNLG//RBNX+HmWqeuFYogWRkA92Z4U/+gPZ?=
 =?us-ascii?Q?ng5xiqy/fFx7gEtjuNMkOpcBJEWpmh+DKN060OjfYUioMA08FN1jNpjMAgbM?=
 =?us-ascii?Q?p0anU1bMvz8Q8xpQszzFlXMdmr07eIUvTfMY7ge9AhdSm3Fffljw3eQuU1iF?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9c5335-e2ba-4304-2ffb-08ddc096deca
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 16:20:37.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAwUADWDZ1QsYBnqxnEP2uVGSriUeZvsVQa66w4R+E+OYBLFR74/kIm+l0eDnXKs10GVUSsK5BhDXetnwUJNnBoB6KwGW6RIIMJkOkx0BCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6889
X-OriginatorOrg: intel.com

On Fri, Jul 11, 2025 at 11:23:55AM +0800, Li Ming wrote:
> In CXL subsystem, many functions need to check an address availability
> by checking if the resource range contains the address. Providing a new
> helper function cxl_resource_contains_addr() to check if the resource
> range contains the input address.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
