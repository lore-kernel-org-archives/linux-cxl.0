Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE326F295;
	Tue, 25 Nov 2025 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042129; cv=fail; b=BUh4lcUjNBHyAqvJe+VL25TbC/xhdrQSHRi0f06sdn943zNSn/d4CZmUk81mvRLN6sLWdoICkzSshgCoHEsY33o71TNQbiiVcNwoR0Ir/L+tV5xq8jjaxhCkNvcfRWwxQSDVAdt6jZkM1DvzRXzJMXuyra07XqE9Wp6KGM/vlGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042129; c=relaxed/simple;
	bh=evAsuSKtstAQKRAmhTxiPeYUXEOtKmDq/L8uDsFVt8c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LUBiVuWooX7691dSsPlghZ1or0uQaD87jPGt8/yDmm6mXcaZHTEThp1DOzqDNJjzUr+NhciZbvG5jnTV1D8Es3Dgqte9aKGhi32+34/NTeR1aesYYhdYgUzgh/GmCDO3GUr4LE6RnvZznB9gMDfuQ1A5dU1J5wAeJpayZObGIBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gF/eH2IC; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gF/eH2IC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764042127; x=1795578127;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=evAsuSKtstAQKRAmhTxiPeYUXEOtKmDq/L8uDsFVt8c=;
  b=gF/eH2ICGSXxeP38c6M3BJYYWIAI11SVQDgnTWh8N70QybSLhyXOv1Lp
   WSFpunb3YSXVejUK+mQavJY33XJay8apCjQlTnPptCPIT2BxjqB2Acy7Y
   TxmxqZhZnx3ZoscXakonUiqRCMFozgAljqGqaf+XRbhkeMY5IgIx2ocP4
   FUx2IAH37Izh63duRRdx2zH1DS1ykPK9qZv7BW1BHifJMlmIe6T/15i/p
   xtvOmKXmlZ2TowtKtbPpk6UF9gzrZQ1SYc9q6R4b/O/5X5cvvFkr/IRmp
   7GApuHMIPxsf521bDIZ5EuyFfFcPW5/d89bExcKyY0/rfscRtX2OFB/Qb
   w==;
X-CSE-ConnectionGUID: rETtXg8nSdea4erduMRCZA==
X-CSE-MsgGUID: PVhxSE14Q5O+q2B7TjhWqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77423727"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="77423727"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 19:42:05 -0800
X-CSE-ConnectionGUID: yogLYb1SSTGDf9nfPemYdg==
X-CSE-MsgGUID: FLKte2iTRAu/NDityiU31w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="192403897"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 19:42:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 19:42:04 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 19:42:04 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 19:42:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kpc6CJxrKTNX0aOlR7+s/KjuY70JvyLyJIRRSRkdUeYMPZeFD2v6CYDDXOw8bBajEU2Fpo6iv2g38CIszMLSXpFZ9jXybLjBGO+aq+ObtOTTczMPAfzknoh3bLYaIz2Ms6ZniNXVwy9TXijQIv/smcqdnN70fwifOxGoZqdpF2rNti82P2oIuOc03XoPGiEt9PtGW3rErjy1MtOIccQR0O4EPFlnupMG3amuUzrExabaEYe6+g/vcHUvPQG2aGVvq5w0Dt2xpvy1XGmyx1c8DYsdE7pfg2jwoppS9N+V/Bkb7gX3dvUady2AqBUN4CL9TWfRlxbrbDqaz5hBrsnEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NmoTd1EH/rzmgmoTdi8Gi6YGinOLHSD8oqNNmmLjEM=;
 b=X4N9tseSmtpZGZt/FLk96ZB82PVQWG8hQpcromG4uRJfcphYRuqeHFcsJvdsOg4JxecgcgcpLpVK+MXWB2SWDJzYw+k12i0K4j2H07Ilyu0IIAKs4xSUKamFy0ISlP1xp+Xo6adoju9dk2tG/RMhRlc35k1eYlpDIO0CV2LOMXr/gCrIwuehqzA6vf0Gtjmuw6EqQ7WLZCX4+ulcUAwAyzxhODgK53nebzVREt9qU53YupTjkiqybJ76UfiA1GyKZGWOwVSupl8Hgo8xx3DwO7JpN1RoWW37MWzSRGrbJbaxGxaD+BYYmANRZcQovW0WIofvj8SlMkBAwrD0ktws+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SN7PR11MB7705.namprd11.prod.outlook.com
 (2603:10b6:806:32f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 25 Nov
 2025 03:26:58 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::2cfc:dfd4:ebf5:55e0%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 03:26:58 +0000
Date: Mon, 24 Nov 2025 19:26:51 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: Robert Richter <rrichter@amd.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v6 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aSUh-9fXFGsK_Z1_@aschofie-mobl2.lan>
References: <20251114004021.1310661-1-rrichter@amd.com>
 <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
 <aRs4ILR8EEwnfOtQ@rric.localdomain>
 <aSOxXX7xX4jYqqvF@aschofie-mobl2.lan>
 <aSS7n40Hmiaf7ibc@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSS7n40Hmiaf7ibc@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::26) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SN7PR11MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ad43e2-f59f-429d-52cd-08de2bd27d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NgHdfqv77i0FpSIWDr5m6jmJTO0b5J0iQlpqQsC+KQsfcI6velDBTLcZt/X3?=
 =?us-ascii?Q?3hNgiDigNR7nZMMJ+xgvj0t0w+ghrJ9f/aPwlSZx39ZTfaulqWNt3X0aY6V6?=
 =?us-ascii?Q?gHFf6qwP0tz4c9I0TK0112H9FgrTJ1quKFqWa9u699VnE8BcXn7WOwa8evHS?=
 =?us-ascii?Q?msYh6sj/M07/NZw9AzNbD0LzVXg3Fba3xJhtL/kA6PMeJV8NqabvM7KrkgD1?=
 =?us-ascii?Q?QkYP9755mp5YxCB1gE07Q33abVQG96gYSKDiIVass82zL0sGiJwAbb1Qfa3T?=
 =?us-ascii?Q?tfkHktkWa9IQbmMUW13kq9k609cSkCWJh9YGUS8imk00BJ2dpJ6h3V0WB/ii?=
 =?us-ascii?Q?TO8eKom5q/e9xn5MIaEHXzYIKvzIuu3f7VQhMaM7fLs8i7mDiioM8hj+/PjB?=
 =?us-ascii?Q?zyFgdow5yoFHbfYXsfM0yYznHjtYU2f2lk4hSvEX2Kq8s4WEs0lp8vuUO0zG?=
 =?us-ascii?Q?B9vIy8Kt/+lKcIDxQF5o/NS6wqkh1ualc4BZ78j3LV/3mDKjoFeCsvou66fZ?=
 =?us-ascii?Q?sepBiM6ouXG6eehkTsHSsQUUx4U7MbcMmwX9ghSc67sCLS/Bv6M1icICHCPe?=
 =?us-ascii?Q?6IVPn/kFRRNzBvbkcVTW3IAJR82wFlHJ0Gz7KaZKLJc7jOnGQviH+VHhnQo6?=
 =?us-ascii?Q?d/tli4adwh2+xVOrZYTxTE2tydMAidtKqYVrO2RNN3M3d/YJAtFKST7y7y0q?=
 =?us-ascii?Q?DkdGH2up/Vjrgmi+jc0T/XWjewckjIl1Dd/kRFuDNt57OuFpi+txVsvOo88c?=
 =?us-ascii?Q?4TaXDfykgraQyEeJhbHSx3c7dE50grcRdNZBY8l2h9u2Yg68iiEAXmMfu/2c?=
 =?us-ascii?Q?MhsFRwcgEAEX4vv/M9JNgoXX7200QFSOA9lWkJNXiIoF20N5uomnOaT0lN/6?=
 =?us-ascii?Q?kIvBF7Dd2Gm75ppCbNv/zdVAsA2w7V9FjmCfoOwHnMfbwMYxHjljEEXU2Hw9?=
 =?us-ascii?Q?1OeWZC9wg85G3tAx9GpQVLqXXiQiPzHhlWR1pOGbT/wq69nqIHxPQzJu/A/U?=
 =?us-ascii?Q?KHOMvRP1NWrXmAjEYlppxNJUNiVqSzPlAET3hDb6OGvr6sn5mQbivcD8SYnd?=
 =?us-ascii?Q?6G85KnqvfPT8titIFXHp6Mh0+Tk08LZpvHsxb7ZaAk7sGZKogv1vi+XtWUOW?=
 =?us-ascii?Q?vSrgTgj9E2ic6kfanIOCNX0se0uEsHwViu2Sw3zi3NwiJd55Mr4hoi0fw9RY?=
 =?us-ascii?Q?insxW9a0N0temzhSeX6pX30zBambxNvPdR10FsIOBdqOAP7UZ9VyOcpTz0pI?=
 =?us-ascii?Q?6NMaQzlL6hqi1YDVA9c5E5MU2Mn3HvRv3Ked1St/KRsnXdCYkBzyy5z6dRc2?=
 =?us-ascii?Q?ujCCo0KxaAw9JXstLkN44tcZQMjQNyz2KCBdLu9Ic7+Nee37NKRqxKuo6j+h?=
 =?us-ascii?Q?HrRlsE4OaQBrKGySfoujRQxiLSYZSl46IehRNlfZJV4ogp69k/Q4Uupr027w?=
 =?us-ascii?Q?IlG5JH+9HSMKzm9anfwCIrVj/BJNSfQ5nvj4y8Z2jO0HCi+87kkmyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?85Dh07oYIqa82Nz9M7rdx3tj2mfXOLTmmYHv6UC7rEFfVeVekthY4eQUVXXF?=
 =?us-ascii?Q?nJGyxhaSQPwypQA2JQlxQcI+GVxzmqyI1J8QxwSrkElXDfwmI9bBbMtL/3kI?=
 =?us-ascii?Q?Netnn5qaGAPHYN24GvSADuBCUwbo5zXpyv5uYB1aC06s5Y8f0+ZsAGly5iEk?=
 =?us-ascii?Q?3QncTYT4xYIbJ7dXMtt5T25xOco3HdiW28eQk5dz0sNw9aImr6T7nxudAPPg?=
 =?us-ascii?Q?9SlDXsO/S1S1eeRRUa8xeGb7H34hkqg80/KYQmVXYvcWSZO7fMKy48vdVlUJ?=
 =?us-ascii?Q?5OI+Yd8/O8NEUKl4RTy6csuUvEvsy7i9CeGRNWf1JI0U0LLBR8slYk3Yry1G?=
 =?us-ascii?Q?o6I3oCPVHq58A44wJ+uZ4qtHZspLGbYF7Yo5vOa5BfEA4d/KAGyZoawiZwGB?=
 =?us-ascii?Q?zTtiCvaa+N3yAfGijjdTR/kMWhd5Z3MU161DzDaFlyWjnF1jODz01nhjhxeW?=
 =?us-ascii?Q?kN7x3rV/aSfHOHlZHzHHEjnOsuONAvpTSNmOA1yzqo86PPLpiDSL9Rga2XrD?=
 =?us-ascii?Q?IdeC2vAZHrYkKyDCo5F/H3TFpRc3mJ7h7Q/MOmFbVnDtVZc8ffAulbfF7QP8?=
 =?us-ascii?Q?tZusD3dzSn3YlQY7M+a56LRIOVmvssm5YvXgc8y2WZSa8N4M9GSK7ECjhyBI?=
 =?us-ascii?Q?Af2LFOTwmbX7ETXu11TsdL3lgSwqpaV6ulWked2DLlBhWKNdTiMDXyLhSd2R?=
 =?us-ascii?Q?i4IK1S63g/FyXpWWU1bGhitmF/sjdlPphf2cDIs8WTP3OW07B3+Of08IN1KF?=
 =?us-ascii?Q?84tHWW9LvpBImR5vFBaTsgxuKkY/hOXBrwcVX7PS5NDlhBQiLnim3k0nhKLW?=
 =?us-ascii?Q?KTL2TiJMWeDuB4sg75qamItcnS0xaSKmOtmR8VvOpPYUgpLi/y2j4WtIRihC?=
 =?us-ascii?Q?nPEJouq2LYMo+5P9sfmqn7cicu2dRfSuuVoLjYWriNaAuHE7o0szR5ndm/7J?=
 =?us-ascii?Q?RbcnN0KUvWe6Jq4M83KUZr+oARuE/ief/hoKhNH4k1j/diZ+fDQ6uyKybSLj?=
 =?us-ascii?Q?CNLiC39odEvSj38yoCSK+J+5GGMGZfJiJrckInIYLAainWMY2wk5R7gXwEE7?=
 =?us-ascii?Q?dEfAOKyAwOtW8uxWWnURHlq4jypzsaoUr56YSQ6riAIBriYbPBDQK1aQLY22?=
 =?us-ascii?Q?LUn+CEQZVaa3pq9eaWXyj3yw0J5yHHkdVsN/c75GOt/kGlznmJs2JwfyfpEY?=
 =?us-ascii?Q?QgnmASwhv7TguoJlKsE1kvt2jOTp3njz98fepdUS9E+B4ssRj3cGtaA9c95v?=
 =?us-ascii?Q?q6LWycwwq+/xxZHzrKPrlq3iY5ANyUlJlosPiqRnmraVKYqOW+a2W9zw2L/u?=
 =?us-ascii?Q?ZJZQWyg526J5+YHSwan7kCPfb5zsd+wU061gts1PRcjFdFCBLDptQBd/LYLb?=
 =?us-ascii?Q?Zvqm0y1Zm/yfAohg6FnrM6OffJVvz5xRRrU1zxdFTMrWpy0kferoZyCIeYWJ?=
 =?us-ascii?Q?Za7onlXbcQJAL/ueo/7Q7ASqFb2mgE5c4ETDOleqwOmKTjqw9vYXBqV/hJNe?=
 =?us-ascii?Q?7trL9ZJ2rgiA5t254fwJHKKqlTVIJzRsfsN/OFyxRhXGvrXa8pCQ9P9m/Ka5?=
 =?us-ascii?Q?aKPdVArxgDcIjjplACJj2sxCeS+Tggkn/A9bJnMr7auF1S5ejwRevCL+TiRy?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ad43e2-f59f-429d-52cd-08de2bd27d7b
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 03:26:58.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f/FX5b8R/7098TerL4QT39XRjRwvI5KzpIVny8nOHXgd3IaWLauj72fVGhvaAEKXLj+TIxKJqqUjESN1N96u2xsfPhS8elyqfzobDG1nUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7705
X-OriginatorOrg: intel.com

On Mon, Nov 24, 2025 at 03:10:07PM -0500, Gregory Price wrote:
> On Sun, Nov 23, 2025 at 05:14:05PM -0800, Alison Schofield wrote:
> > On Mon, Nov 17, 2025 at 03:58:40PM +0100, Robert Richter wrote:
> > > On 14.11.25 12:01:29, Alison Schofield wrote:
> > > 
> > > > Does this work 'as is', no changes required, to support DPA->SPA
> > > > (used in CXL Events) or SPA->DPA (used in poison by region offset)?
> > > 
> > > The PRM handler could be used for to-SPA translations, but it might
> > > not fit well to other users such as profiling, tracing and error
> > > handling. Those users are executing in a critical path from a
> > > performance or stability point of view. Performing a firmware call
> > > could cause problems here. Since the to-DPA translation is missing
> > > too, a different approach to solve address translation might work
> > > better, such as examining the region parameters. The kernel's address
> > > translation library could possibly be extended and used too. That
> > > needs to be figured out. Also, my main focus for the patches is region
> > > enablement.
> > 
> > If address translations are not supported/supportable, a quick exit
> > on any attempt (DPA->SPA or SPA->DPA) with this config seems needed. 
> >
> > Better to fail and report ULLONG_MAX than leave open the possibility
> > of adding the wrong address to trace events or using the wrong address
> > in poison by region offset action.
> > 
> > Maybe you already know that it fails gracefully? If so, then it comes
> > down to documenting the limitation.
> >
> 
> 
> IIRC the to_spa() function wouldn't be populated (will be NULL) if this
> is the case, so you wouldn't even be able to call the translation
> function.

The hpa_to_spa fn defined as a root decoder ops is an additional layer for
arch's needing HPA to SPA translation. It's optional. If there is no
hpa_to_spa fn, then it is assumed that the CXL HPA==SPA and that is the
'final answer'  added to the trace log.

Sounds like you are on one of these systems, so maybe you could take a
look at what happens. If your devices support, try to inject and/or
clear poison and see the resulting kernel trace log. There is an
example for that here:
https://github.com/pmem/ndctl/blob/main/test/cxl-poison.sh

-- Alison

> 
> This was hit in a prior version of the set where I saw it fail on a
> system using System Address mode instead of Normalized Address mode.
> 
> ~Gregory
