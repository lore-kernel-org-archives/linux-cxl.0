Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FCF320CD9;
	Wed, 18 Feb 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451713; cv=fail; b=Zw8ARL6IMiQ4yIVQQcPyNPTgha/gWGFevJiU9ofAXmS5SKCcNZ/ROV/UZCyBJZ5l975T+Gyrh+9nQwIg8Uk2nS+pOslqtkeTuGw5Lii5LlIlZYLKNDkMXKXGuUp5KnBE7p9zpOU16afbMF27BCWout95xvfrlouQElPqUjyOFCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451713; c=relaxed/simple;
	bh=jiQcdJsQ2Py1M+IwgYoyrUZvQ48tr7aYPkeD5PwHQOI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gDHZ2ipGL+ijR5iQ7KkGxo36fgFXbff4oSxvCRmISYUmfR5EH6vBAyJIyB5PmTbjM3hjIHz9iwlngmFvFe0/CKXct/DLBk3xQa0Eg5KWv/CQNA1H2TegZudjQFktcSSVJvYqu8IrhqzlorRVVjSmTa2jTX1pMMSXNKQcymHPzgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7YUQLov; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7YUQLov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771451711; x=1802987711;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jiQcdJsQ2Py1M+IwgYoyrUZvQ48tr7aYPkeD5PwHQOI=;
  b=V7YUQLovcdMo5VK/getyAXTDu+SBBi4zmmh/INAfYez1TjrekcQBYvvP
   SJpgptqeIoJZuwbr2gv14eNgZ0p7NmyT2GWZrSmvdDIPovCRP7dCDysyT
   uvV6a8txBLV8Sb5JZgaEveoL9GtNsl3R3tTB7z/nYOzn8KzzjTZI1vafe
   Q4+5xgEME42V6aHa9DLvinuevzf7PH0Dk3dhwU713YDmI4NP9Fec3syRQ
   izy9Gj/jH6OngoavyiiG3IaIJmQQnFCN/6JWs4T+9uXUcegXRXd9hSYc8
   NnRK8JfMEIZ4u4kHFGx2GomJhmhFDxfKpAUKQKm0eymxaCQndaB+QYNDa
   Q==;
X-CSE-ConnectionGUID: 8eqKdXXmQ4K0C/DgjQXAQg==
X-CSE-MsgGUID: cLW3EvFlT7m0b6JojpKCag==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72439624"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="72439624"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 13:55:11 -0800
X-CSE-ConnectionGUID: j5ZUJGfrTzCJjXadirWcow==
X-CSE-MsgGUID: X0ca/ECnRoWGVEEeapTQLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="219332395"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 13:55:11 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 13:55:10 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 13:55:10 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 13:55:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnLfrdLQg+u+S85+BPNZRLNnJjasK5E7aqM5rCuL/FlWT+2hb/pEgx2MTrWl8G0gshSYKyYFDNGSlrozL48/G2sACKcN0BHi9CmZBjdakkY5oBn8EDfDMaj+ZTfFFcYGmQVOcGiAvdw+NfkZ0p1bMH36Lf8YYUyYEW8pMnYxTJWofZkFjh44ofZuO1SmmB7/LuT3ZTcCDbl+59f5pgxEzTwD9R9xgGtaTsSggDbfEEvUdNk7tLPGr16rvYbNdUhYDpE6ND35zxYSa93xm+JgRHUUXCtHjTBnRjxkK6IHFIa4GGiTG6cSM4rBfUR+99frNYifEwrIw8u6RZvgzBLJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yutQOU7UwxyGJ+oMA8wWqwAXxrl/Z3htsRqOZ33qA2E=;
 b=pN1c7WZIabRL+dR0abuJPiFwKdm/15Bkc0PeX2sR8iZdIyLMsSy+Wks/hnz4kggveNaho7oJhUBqX1ZnrbH+D7wR+3Dq35c6bQZFuPLFXMwmwuHFw7N7wuenc1alxqe+SXFiL3KzB1A+5q2t5+Tq9P7H8F9AH/en2U7b97bGg+q/ZtDWwqcwTaM/tYZzMgytnj52FUAV8qMEVes02ILpQG+pL/JuelXL8W4BkXz4X9VCf83yEPGkb9mc4kOdpC3N+7EJe6Xp4iyFryKA5uXeq4alNcXy9kQdfFOq7FzE7GZdNSLxdBvvurtsOtNdA8IwulcFUpRAajHenD/EkN2wIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN0PR11MB6035.namprd11.prod.outlook.com (2603:10b6:208:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 21:55:07 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 21:55:07 +0000
Date: Wed, 18 Feb 2026 13:54:59 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
CC: <dan.j.williams@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <lizhijian@fujitsu.com>
Subject: Re: [ndctl PATCH v4 RESEND] cxl/cli: enforce HPA-descending teardown
Message-ID: <aZY1M_7MbxaZqwGp@aschofie-mobl2.lan>
References: <20260217082705.2475753-1-pawel.mielimonka@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260217082705.2475753-1-pawel.mielimonka@fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN0PR11MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 46df52c8-f144-41ef-bd09-08de6f38613d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Guyo/ymxMnOQZVEBS3l5jJrHpDHjVUm+V5uGrjkf7tsOvrbpOJO1JVV8yefE?=
 =?us-ascii?Q?6YKeI78CJxwAiBX9dC98/wRq/FyLXW5IHUB+XCB6xO62XSo7fCBsmK5WR6d5?=
 =?us-ascii?Q?NVN4v2nwifzVHdrxH30h+6sP9kzwIxXTwwMhV/l5Fn4DeJi1vFQF7Z3kBqdr?=
 =?us-ascii?Q?SKwrMZ58SmeYAzD0iCMxSLEhEPMs+SXycJquPTjeiE2A4XZZm/0K5qu2lypN?=
 =?us-ascii?Q?mM+Up6QB/XkNkKmx5/rd7EMieQ4H3B+vr/9UogrF7Zz3bk0RmP8M2R8wiVYd?=
 =?us-ascii?Q?khZRVpFti8iIgSn1QkyjRQGQ9oSQyBlML1GlYWO+ZNRAsw/X5/v6XkaRPZOz?=
 =?us-ascii?Q?UcOMP7GVqfn6lgBIan9hD3gmlggINAw5UatrQMgNFKtSsUiNKy9zkx9cT6ds?=
 =?us-ascii?Q?GCHmTySMptBVUuIyq02aRj1C3DqYOmMhkB5pR3ie6GXsw5zkDC45WssU6jaJ?=
 =?us-ascii?Q?eEkaqv5FaWW/PEsQVcJro9FyoQrdHQHYkktIlUA2ReyFkbMnyNGpzWDazHEi?=
 =?us-ascii?Q?mTwEdqAh/q26ll1dAr1uB7+UXyev1A+wDvr6xEUjDRV+H04ZntFe7ekunw+M?=
 =?us-ascii?Q?Tvas8ix2EktGVOV32/6gxgGzWbbqMXwT4LevJw+rx7mOnuQottRwCrgvFSeT?=
 =?us-ascii?Q?9eNjOtFMCEKwAxZzBbmEsNiMT6wHffovP3UxanJjnyh5K1iNTYMfj1T0dWbC?=
 =?us-ascii?Q?bSFqUdR9Kibb1f+Jw0VSs/HdG8zYkMhlaktV/ydCyieblKxw48VlYoImLyOS?=
 =?us-ascii?Q?Vy90VKqrIsVnJtDEuuULlr4cjvr++1ZqsA1UgR6fc9x3OlB1o4h7Vyg2neo1?=
 =?us-ascii?Q?WpKHIhglFHY59mepWBbdAI3RkBrb3BLqIwW6Ajj0WBkQaHxqjUZuhd2vwUZq?=
 =?us-ascii?Q?5IU0JKAq+dcPJwhVwOa94mJTYc6sdUAvg3OlFsYQzuZBiZ8gSXnmmQDB5qFC?=
 =?us-ascii?Q?ZMwmxt+GVFri8UMuNb99pSHjwx9sZmeqZayybDoYeck9PPOx9ZJvmvyShIaV?=
 =?us-ascii?Q?WQWeAJf5bVxNrf/0Q3fOrneqpP8rRwU282MYhmYDB+RtO0SVaVsGPTVPhmqn?=
 =?us-ascii?Q?dUegJOas33p03bcVJZRd5GtQvBbtdRiZ5UC7ehoeA5Ac4CMvD26qmiavP2FC?=
 =?us-ascii?Q?HtBJuy6d49FB0jjD4dPVpQ8E37DqZ8NL6KCakzDOM03rjQqiqXlJAxPyYlkr?=
 =?us-ascii?Q?c4A1rtQyuLJm5fk7rpMBZjwdc/BVB8dJSAKtB5J7fDAzA6oBXH6tuZ/BI6XO?=
 =?us-ascii?Q?SldGhJXfToWk8ugT6egURV6YI3bR62TDhIIQoCVvhmZE6TQjAWo1B7L4N4Ux?=
 =?us-ascii?Q?owDG4f2rdYc08W34qcnzhreP/uOwuR4Zsm80eIgTGzQJhrEOvV2tNnGzZrSx?=
 =?us-ascii?Q?9pnXo5yYkoxULgPUtXEQmavmlYki24tTBKxwdYQqxd0QY8MC5C4et6Mij7mP?=
 =?us-ascii?Q?X2cQXvWu27uPV2zHM5FYAugqKkrfl3DYbff1yHk3upsa6MgYOvyObCZlTvEc?=
 =?us-ascii?Q?y+geKZvbwWHop5oFaqBIwuuJXhPS9taRYeLMJv/YqpjB+TY/3hJk54sD+IZo?=
 =?us-ascii?Q?QoEpVDiEPknEJwLJT8XjIO8TTVHO6rhAKo+3F0iO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OCkP835dzWyrdNS4uyWvxCk4ET17RUyZuFVaj8TQXYWQdunAikRPDWrnA9uj?=
 =?us-ascii?Q?BI0yzOXWyBLwzU88W+6whBube6CeurGH0rCakWkzOeMojMhyifCgzHzWfdbG?=
 =?us-ascii?Q?KY4vpDZLmxUvDvdDDDXO5TVD+rfqR4qwDCr3/kG7+ij+3ex8nXBiJqZ1XvsS?=
 =?us-ascii?Q?cfeZE40UbK26XtA9uuYhjB7ul2xucoqlAZL6D7V2LYzDAEEZE+lV+xaNc1cY?=
 =?us-ascii?Q?zSRV+4mCgLa0VeqC7RPVPGsbfXwNf+23Gd7o1SYhumz8+Uyea9D7TjFOlkYx?=
 =?us-ascii?Q?x2eD5XwCC/xg1DpYeetCBBeYQfpKZ1zLW18SmmPYc3OKr8UxAro6XXkT91Bf?=
 =?us-ascii?Q?fwcGcqFSTGd2g/Zu33ZQccsl4NRZCr1FAcbHRhTY2WD2r77bl5h8h50I+G5H?=
 =?us-ascii?Q?4KLtC5NB/zSqjgnc1i1kP4strOjToD6xI4M63gzxTmr5rDCCLg5AeC51FIQO?=
 =?us-ascii?Q?7BurC9GBkAmO3m30WCS4QJS0qCgXxnAHUY2/JuggWrgiEJhoKFhnQwj5qdrd?=
 =?us-ascii?Q?XroD1KURuvqfrIUOGRMIv0A2LVBpzgdOstqoZdjB4TU6jVIX/4beoXCzQM81?=
 =?us-ascii?Q?idM2z9hQQEtW6URAGaiNfnE7g1ZSiX3DTr+RpotZ3FyhBSl61OBM9zJSB4R2?=
 =?us-ascii?Q?Muk1Aw4j7RdQl9U/rJ1QuYFBNPulX/G3F6secSeXAFmUojjKcsy9ziNq/NXM?=
 =?us-ascii?Q?Kq6zbOrXEl44gwwWK5L2Uo6My2kijZZSmK68MuHRxLK41VfJp0h9iMuK5L7f?=
 =?us-ascii?Q?bXgLTVeOSn9lATCs+TM5Vz+BuE9F4YqkLBqkoqVjxDeRju4yVv8VOlYhssjA?=
 =?us-ascii?Q?69j8zIVzvfT7j/f3wroPCrtG0tldz2KYFaQhTg+ChGY6UsrF0MZXSSyZxT+i?=
 =?us-ascii?Q?79DmihqzaOAaPwrOitZ70URNL/sBmcVubwUY8EOMt/7XTPEYQbmOrcL178pK?=
 =?us-ascii?Q?0Ul8OfmMrApDR3CX+HxS3gHq+MZX0QQQVd+fGmqLryC+AqPy7tUPgL5/DZL2?=
 =?us-ascii?Q?I2vend4SOaEvXBjIFhUMqU45P6mi2C+2FUlB/nxbEulHf1FolBNFQ+aqdicM?=
 =?us-ascii?Q?elS5TA6T385eDZhC4LwTlIC94Ioqx6dvNe3uR9PP1/YQtlxxQJmPPCY7VkVj?=
 =?us-ascii?Q?FmDfLvnY25SBnMrsMkuj/8AtF139DOkC7Vobc8ZG5XFvGTaZlF2cbRr2aUKU?=
 =?us-ascii?Q?QTlu0yVNnvG0OS0OAsEF6dK61J7dLx8FBwFJ1G0SxrERZnRBd8gqYgD+obIi?=
 =?us-ascii?Q?TBYqREwXMgOq5/xh9s8v+PAe3/93lMqqlSinVhZUmSSP74HsCh9eO1LRJpBg?=
 =?us-ascii?Q?n2RwyqPc0DP2DrZPlT1H5zkyr/qoK1rhBfAsNFTeZjWXbcb8Knd/QnWXrvz9?=
 =?us-ascii?Q?//Ye/jamnQEi5jkBXgNSKTIhbq84HJduZX7DB+bc2DRTAGZ8nJlm2DmLOTZu?=
 =?us-ascii?Q?v5pK3ksrFPdz5TLn6Vn0KcUkRGD0FFpKwF4ZujIWM/tWbP/ICd3sA4TilnnK?=
 =?us-ascii?Q?FyIJyb9VrAEjOphesBY1+5jtxIKgFGDAHsiBoiPfos040jNA3x6X1NGB/kcN?=
 =?us-ascii?Q?PtqY7cl2kBgUPJitAuJtdXRKGFay7SQGgdFHule4ts2gmJ+oLLnrhplrc5sk?=
 =?us-ascii?Q?8Ur57lMJ/kZ02AsuhOt4j2AHq+DTdswV2QWrqvTSSlHKRpRsKlXXe0H0TRGO?=
 =?us-ascii?Q?KGI347e3O65J40pjBqkSmP6yJB+lmzKLD3OQh1hysPU4Ppib79lHhv1SB9I5?=
 =?us-ascii?Q?bxJAg/oqkn550wpFkXPMeBTYNQNFGUc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46df52c8-f144-41ef-bd09-08de6f38613d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 21:55:07.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5iB+SqkMi0ek1x2NCL4jXZgkysIzA+RnhG4W7FuC9rYE3C7JVF3yJcY7b1g7fuVq6A8IN5JY41QM2vsWbHTN9A9J+nKrH6j0JCDhkw9Xn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6035
X-OriginatorOrg: intel.com

On Tue, Feb 17, 2026 at 05:27:05PM +0900, Pawel Mielimonka wrote:

Hi Pawel,

Thanks for the revision.

This patch needs to be sent to the nvdimm mailing list.
See here for ndctl patch sending guidelines:
 https://github.com/pmem/ndctl?tab=contributing-ov-file#readme

> When destroying CXL regions, users may observe failures such as
> "set_dpa_size failed: Device or resource busy" even when targeting
> valid regions. Afer such failures, subsequent destroy/create cycles may
> become impossible without a full system reset.
> 
> The current logic does not guarantee descenting HPA order across
> regions, even when each region is mapped to a single endpoint decoder.
> As a result, a region can only be destroyed if it is the last one in
> HPA order.
> 
> Alison observed that the issue extends when a region's mappings reach
> endpoint decoders under different root decoders. In such cases, the HPA
> descending order must be considered across all endpoint decoders that
> share any of the root decoders involved - effectively covering the
> entire bus/port. Without this global ordering destroy operations may
> fail unpredictably, and followng create operations can also be blocked.
> 
> This change does not alter the underlying kernel behaior or decoder
> programming rules. Instead, it enforces the existing ordering
> constraints at the CLI level, preventing users from issuing destroy
> oprtation that would violate HPA continuity required by specification
> (section 8.2.4.20.12).

This commit log mostly describes the problem and failure scenarios,
until the very last line above. Maybe you are scaling back the offering?
Describe what new region teardown support this patch intends to provide.

> 
> Link to v2 - Alison's findings:
> https://lore.kernel.org/linux-cxl/aTTKRCUmbNC9jIrG@aschofie-mobl2.lan/

The issue of v2 seems to still remain as the sorting is per decoder only.
Please take the draft unit test patch, update it to align with the support
this patch provides, and include it in the next revision.

Thanks,
Alison


> 
> base-commit: 4f7a1c63b3305c97013d3c46daa6c0f76feff10d
> 
> v4 updates:
>  - expand the commit message to include detailed description
>  - add references to prior discussion and failure scenarions
>  - follow guidelines for subject and formatting
>  - no functional changes compared to v3
> 
> v3 updates:
>  - fix iteration to cover all endpoint decoders under a common bus/port
>  - collapse series into a single patch   
> 
> v2 updates:
>  - sent by mistake from wrong local branch, does not compile, should
>    be ignored
> 
> v1:
> https://lore.kernel.org/linux-cxl/20251125143826.282312-1-pawel.mielimonka@fujitsu.com/
> 
> Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
> ---
>  cxl/region.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 125 insertions(+), 3 deletions(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index 207cf2d..d86e45f 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -831,6 +831,72 @@ out:
>  	return cxl_region_disable(region);
>  }
>  
> +/*
> + * cmp_region_hpa() - Compare CXL regions by their HPA.
> + * @l: pointer to the first element (const struct cxl_region **).
> + * @r: pointer to the second element (const struct cxl_region **).
> + *
> + * Comparison function for CXL regions based on the Host Physical Address
> + * returned by cxl_region_get_resource().
> + *
> + * Return:
> + *   < 0 if the HPA of the region pointed to by @l is less than that of @r
> + *   = 0 if both regions have te same HPA (not expected)
> + *   > 0 if the HPA of the region pointed to by @l is greater than that of @r
> + */
> +static int cmp_region_hpa(const void *l, const void *r)
> +{
> +	const struct cxl_region *const *left = l;
> +	const struct cxl_region *const *right = r;
> +	u64 hpa1 = cxl_region_get_resource((struct cxl_region *) *left);
> +	u64 hpa2 = cxl_region_get_resource((struct cxl_region *) *right);
> +
> +	return (hpa1 > hpa2) - (hpa1 < hpa2);
> +}
> +
> +static int collect_regions_sorted(struct cxl_decoder *root,
> +	struct cxl_region ***out, int *out_nr)
> +{
> +	struct cxl_region *region;
> +	struct cxl_region **list = NULL;
> +	int nr = 0, alloc = 0;
> +
> +	struct cxl_port *port = cxl_decoder_get_port(root);
> +	struct cxl_decoder *decoder;
> +
> +	cxl_decoder_foreach(port, decoder) {
> +		if (!cxl_port_is_root(port))
> +			continue;
> +		cxl_region_foreach(decoder, region) {
> +			if (nr == alloc) {
> +				int new_alloc = alloc ? alloc * 2 : 8;
> +				size_t new_size = (size_t)new_alloc * sizeof(*list);
> +				struct cxl_region **tmp;
> +
> +				tmp = realloc(list, new_size);
> +				if (!tmp) {
> +					free(list);
> +					return -ENOMEM;
> +				}
> +				list = tmp;
> +				alloc = new_alloc;
> +			}
> +			list[nr++] = region;
> +		}
> +
> +		if (!nr) {
> +			free(list);
> +			*out = NULL;
> +			*out_nr = 0;
> +			return 0;
> +		}
> +	}
> +	qsort(list, nr, sizeof(*list), cmp_region_hpa);
> +	*out = list;
> +	*out_nr = nr;
> +	return 0;
> +}
> +
>  static int destroy_region(struct cxl_region *region)
>  {
>  	const char *devname = cxl_region_get_devname(region);
> @@ -895,6 +961,59 @@ static int destroy_region(struct cxl_region *region)
>  	return cxl_region_delete(region);
>  }
>  
> +static int destroy_multiple_regions(
> +	struct parsed_params *p,
> +	struct cxl_decoder *decoder,
> +	int *count)
> +{
> +	struct cxl_region **list;
> +	int nr, rc, i;
> +	bool skipped = false;
> +
> +	rc = collect_regions_sorted(decoder, &list, &nr);
> +	if (rc) {
> +		log_err(&rl, "failed to allocate region list: %s\n", strerror(-rc));
> +		return rc;
> +	}
> +
> +	for (i = nr - 1; i >= 0; --i) {
> +		struct cxl_region *region = NULL;
> +
> +		for (int j = 0; j < p->argc; j++) {
> +			region = util_cxl_region_filter(list[i], p->argv[j]);
> +			if (region)
> +				break;
> +		}
> +
> +		if (!region) {
> +			skipped = true;
> +			continue;
> +		}
> +
> +		/*
> +		 * If current region matches filter, but previous didn't, destroying would
> +		 * result in breaking HPA continuity
> +		 */
> +		if (skipped) {
> +			log_err(&rl, "failed to destroy %s: out of order %s reset\n",
> +				cxl_region_get_devname(region),
> +				cxl_decoder_get_devname(decoder));
> +			rc = -EINVAL;
> +			break;
> +		}
> +
> +		rc = destroy_region(region);
> +		if (rc) {
> +			log_err(&rl, "%s: failed: %s\n",
> +				cxl_region_get_devname(region), strerror(-rc));
> +			break;
> +		}
> +		++(*count);
> +	}
> +	free(list);
> +	return rc;
> +}
> +
>  static int do_region_xable(struct cxl_region *region, enum region_actions action)
>  {
>  	switch (action) {
> @@ -902,8 +1021,6 @@ static int do_region_xable(struct cxl_region *region, enum region_actions action
>  		return cxl_region_enable(region);
>  	case ACTION_DISABLE:
>  		return disable_region(region);
> -	case ACTION_DESTROY:
> -		return destroy_region(region);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -971,7 +1088,12 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
>  			if (!util_cxl_decoder_filter(decoder,
>  						     param.root_decoder))
>  				continue;
> -			rc = decoder_region_action(p, decoder, action, count);
> +
> +			if (action == ACTION_DESTROY)
> +				rc = destroy_multiple_regions(p, decoder, count);
> +			else
> +				rc = decoder_region_action(p, decoder, action, count);
> +
>  			if (rc)
>  				err_rc = rc;
>  		}
> -- 
> 2.47.3
> 
