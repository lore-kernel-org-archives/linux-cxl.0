Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99551229B2E;
	Tue, 24 Jun 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785124; cv=fail; b=g8I5YBmT+alRz2M+KF0T+eRAMh6M93wZgzXaPWfOW7zII2lFOrmeyymtat5P61g2QIfO2kALNU0dLwN3awj/KFf9QBcSfbB3UY1LL11EBRCIAvdrhWDLAFwWerZzmE6tXigw7TnExmpkaA34fO1j1EdF/+fULuPiSU0l3rcQJww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785124; c=relaxed/simple;
	bh=USJBONAXzVppwDVLbqKObn18/XecAtI5wqI1++EBx3E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LP1qhgXJLGcv6IDsXC6AiMqYftFRIjWbwV1r9QZ/Ze3+LJkI+X6H2UBs7i+k00uzYzaQvVxBRvTaIkcdnA2SE201rVjCUU6d5lrL6USzCN7F1jG5OCE2qxt75uZt5OspZMGWA15syClPVHUi9NoA611QrtNZ1PbIIXpXjo4Rvbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rcqr38//; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rcqr38//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750785123; x=1782321123;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=USJBONAXzVppwDVLbqKObn18/XecAtI5wqI1++EBx3E=;
  b=Rcqr38//z8bHZLD9bcnoR5xJBf5j94TWRIYR5cr08cbteFSMQPsehbop
   1VD13COlcN+mqs6/9jz7tNzkhUfce0g1AWl/4s2djX0KHeR+SD7pR1+Yo
   a2U8x+UMn4KchVxB75vuClFKE5KON2zbOf6LxR2H9Yj2xTkOkr6H6k6lL
   HjNcYJwWY4Ufywa+i0zqd5GiTU/drXL6sumZnJFQwmif9nJTf5EvU/2ak
   qeRplz0Z+YbMzwB6SzOrhCOLG/hUTDx3CzF8sGN15ONLSLLb9RhUUF4NB
   B1zNJEKR9xLuyhrNSONwSKyy4P1qP0blQ/HUiJyBXIFXoSnkxRdrYFVDo
   w==;
X-CSE-ConnectionGUID: FIINYQN/QFW+WtZzpN30iw==
X-CSE-MsgGUID: 5w+hCm1iSz6wPkojqzCtvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52905011"
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="52905011"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 10:12:02 -0700
X-CSE-ConnectionGUID: 9oeiDDWjQ8iLpFIWqW8cEQ==
X-CSE-MsgGUID: o4dNz7wqR8KRbEhJwSx/iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,262,1744095600"; 
   d="scan'208";a="151720350"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 10:12:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 10:12:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 10:12:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 10:12:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs4wEMkoTs6XipMYR4nsDJKGipTFfkP3rt8wfZ3Ik65AAczag3fjpbKmnUOJzPYbmTNfDpYCUBNOGEOgAMU+i4XF1WxoBE9lpM2HXqOnr0RgE5Z8NlLLeBEhshkuZmlNbvFS5JL5/o9erG1yc7ripXSuD27VdJzXFCiFxhfgu1HuYTxg9AOEV7XXtZhZxIpMTHmn7ObzyGQ5sOlKCpzSn237nxExRY9GI0+jW/SrRJLxyR0jOcIPpnmC7hBxPHRkk5cgEGTtfTYNc7qBvDBqPrG1iqNi06BcJXf9xFCU5/ObaeePZSojFRLF8rk9WhaugIias6sv2hqIK+MnvVh6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USJBONAXzVppwDVLbqKObn18/XecAtI5wqI1++EBx3E=;
 b=wLMANoik8C4duURYjKGv1faKRjxMQ0KIiqvlpr7feRlWLaVqCgC+q/l6oNP1lCGn0c3dQ42p1UDCwN7o7XKo8/vGUklY9ivIw1nIojTcEB/n3E67nbwHoa7DtewVbRBIpNzNlcJNaGqa8g1CU4Gy//lrt6mWKNrtE3Y2RXbYURxiKM2a14uXJ9I9BDqzCOYFPDIDgYTdE9bKiwrgunspPifgmdOPqhS+mYeTyysfl03BFJjq7a2WHn3Tb728gDMn8WO44rb5OdyeHGufjPQdRNXszcXOcDVl6Bp+k92Gj9rB2f1klafX6JP/khi3/Uhmu3+ZPzq8TrFJ+me8QeHuzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7783.namprd11.prod.outlook.com (2603:10b6:8:e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 17:11:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 17:11:45 +0000
Date: Tue, 24 Jun 2025 10:11:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <ming.li@zohomail.com>, <rrichter@amd.com>,
	<jeff.johnson@oss.qualcomm.com>, <peterz@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>, "Pranav
 Tyagi" <pranav.tyagi03@gmail.com>
Subject: Re: [PATCH] cxl/port: automate cleanup with __free()
Message-ID: <685adc4d1487b_1608bd1009b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250623091929.366357-1-pranav.tyagi03@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250623091929.366357-1-pranav.tyagi03@gmail.com>
X-ClientProxiedBy: BYAPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: e97f14e9-bf56-47d9-09e7-08ddb342323c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HLY95YMZvTh7b9DS384wFDmtF6BW2zIC7paZuW+zwYkSxDFp1JC8NujfM3zY?=
 =?us-ascii?Q?3dn1G8C752SaJtmDIoFOa/Jk2BGBSiVU3lr2CFRnFSsd1QmF2sRmggACKpA9?=
 =?us-ascii?Q?OsmWV4GS6We/KnK20d4upe7odrEJhikuwG4iSPM1CspCxKHi3iGfcQQtnxBk?=
 =?us-ascii?Q?iZwm7NkjoSW5QmALvHD6iud+DYzM+UlcwJbH5LxXahFpij67daocfOvu4hlR?=
 =?us-ascii?Q?iI6FwrgPwJfeVNHaDAed6x5/uDkkhq9789W87kNg9HphsmoUr7PKlxQoZxEa?=
 =?us-ascii?Q?J3YgyFFgecE5BvAGCVnh3QITU/hLeIvmGObHuRWJV3l6C9gQvgnaCb9SMVye?=
 =?us-ascii?Q?uSHKEzWF35P6X8ecNYoLrJXf8YQqSd12fBfGff8Qw/ha1QWjgIJ6yoMtQcjn?=
 =?us-ascii?Q?y3MkgKblQW+n+xCxYxP8Kk3Xy1uUfUlaIbK6rTBtqxVLpRYnXj6Mo1PymER2?=
 =?us-ascii?Q?itVz/7JO8cN3Ak20JwNvbSpJ0oV1jwzZWEC4aprloUZgwxAl426jQ7oOpxYY?=
 =?us-ascii?Q?WDdmPy9nRB3PnKG7xzqPGhyZbpGgvR/pQ+5PxyoPmMZu3AqcgKoo+J6z/ZcN?=
 =?us-ascii?Q?YK9N26yKg4FFT4tn38/FvZzMvZdM+7p6vGJDzuZBaaDQsMUgpQi3jqj7P0Vo?=
 =?us-ascii?Q?C9CM4kiByd762fM6R2vrf+j/F7cfqvuw8q7EjwwfqcP64/X2yuxRupdQbqr6?=
 =?us-ascii?Q?mg2YR7sBCCkIzSQTv2+oxRGkfjyqniLzUdVU8QtPPTQR/i5oPQpyYTFkNL9b?=
 =?us-ascii?Q?Zjlb4RK9BO09c23sVC6emYIB0wI2PyFNv+iykMfY+idvkayYDSh5w3jaXpzu?=
 =?us-ascii?Q?+h0oJ+/c4VmU1Dn1yalXWjX2N+CgfMm1c0q08S9M3amOVzhporQmGJAUGJKS?=
 =?us-ascii?Q?XqUeWB0e3wdvWYxe4Z/Q9A+/DGZh5yJgdZ8CnCl2//aqRGdExpyHABPscjZ0?=
 =?us-ascii?Q?YmcimkqRGdp1aqbxYv9eFOdetF/rnfBWhO7vKCV717OAEOD1zQyqCP8ZVmXh?=
 =?us-ascii?Q?fOlHm09WYAkAUbyBGgOaZahYYGEM8OA7SqmQQX4vZJocAqKh99mtrO0aoecu?=
 =?us-ascii?Q?cz8WEZFRL+nv2RwmQZs9TUFv7e9R0XsZEL2PL7IcIjA2eJL0rGHMuRYKHpwF?=
 =?us-ascii?Q?aSzT3XTpnUZ1vMBZtqIgaNNOKoR277vsjAYRdrdoWvAyX+/6A4TuyQiLbCrW?=
 =?us-ascii?Q?rfoWiWVpDoh9tBHU59t+fRPA/xcLa/Wi8rOYJdzQPgCmxHCtixoc40ryGyLe?=
 =?us-ascii?Q?k9ZK5M9Vwoa8x7cKgktP8Wy1fn0mLRc6MmEW4RF0nu2lFtpZN4bgRMA48CjL?=
 =?us-ascii?Q?+yl1sApVysuAMDPQbqWJpBZZE3t/k1Xs6DqSrrtEROx5qbBrDfd9qZS+uU0/?=
 =?us-ascii?Q?3BnsnziTbko06tvRJOV8gLmn018sWGyxgX0OCqNhqZB7/7TQKYR/54diV+B4?=
 =?us-ascii?Q?HUmSO6mBR7E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqZ0c6ueOKUPm9NUDuABtUl2vldGDD+AE+Yo0b4mX8KFVQkHFwcjrDGeHzXf?=
 =?us-ascii?Q?UpwagRORNp/n1NrGkGPM9fFz8hwUAnEwwiPUU+3jyDgPabCt2Xl01ggUi2Wn?=
 =?us-ascii?Q?8hDFPL5yClX/SELm0kvjLyIJ4cszTQr0Iz9Yj+V4o/6i9lVjkoOAZ4bJ5yGn?=
 =?us-ascii?Q?tfokdiscibtnut2GHwVvA9wPmjmrnUIStv6XFXj/RniYSDIgj3jG8yG8AEGl?=
 =?us-ascii?Q?6Si0kRmB8TR7XSZ5OK7yGNCMMgz7KftmwD3vc13NYn/CmGy/woDSH1HOnV7f?=
 =?us-ascii?Q?fCQ1mMac83abVQxIli9aEQg2tfvQnJeZkNoyohDHXQNbz1wpqNJx0QuvZMbL?=
 =?us-ascii?Q?0/w2oZtbBNfvtR05J1sA9uLUQQIaZICrK1i9Y/A1qTUnZrFGVE/MK+zAORYE?=
 =?us-ascii?Q?9JVvr4AOaNX1zrvp7K9KIkbdhsNxHaJYZgXTVab4zHPnv/GYfx4OuGDr2sLX?=
 =?us-ascii?Q?364QlJEigmlg8EbuZsiFvHxt1VwLBuxVZikVKaVfO+YFTIgSDi7aqmmro53k?=
 =?us-ascii?Q?Gdx7qWh29wf9+vRyEpDeAVieor78N13xwAHExVXoEQwGjBXxxtUC0Pgx+ShB?=
 =?us-ascii?Q?P0P9NQLJxp5YCm0PPsmzvGidbFKVIyrMoj4vd2txPWVMAhdbzPIp2GckFNR3?=
 =?us-ascii?Q?I9ZNRoDzIwit+HjD9nlm5+YuUEUBhdfyiD753cEklNgzcMjfy8L4N+bc3spQ?=
 =?us-ascii?Q?FCeIyCkFFeu75xRkW+oBZozKxICL8O0fZERaCnN5hImV5dDjpdw8rCFbtneh?=
 =?us-ascii?Q?F/CjZX1OWKLJGK7Vh0jBdmad6LYWtEfCd++YmIbOO3xSo681+LR48ECOWwL1?=
 =?us-ascii?Q?a9+ms3HJ6PYuIk/tfpI5EyBPl0PxxSChIKKNtxcjlb2c4nlRga9OhRoa++qK?=
 =?us-ascii?Q?UvkDZRCCMsA8EWhuFwbx+EL/+GAeHxk67h9WwVMDEiUcu7JaZSPFf1Y1/sjj?=
 =?us-ascii?Q?aMOZ4XGPDsw9o6zBUAbxwBkanSuQrXBBOigVqeMOgr97Q3JfwWBlqVl6CWnA?=
 =?us-ascii?Q?f0HnT7yJ2V/5SNtzjDq0IfRystRpF/sKurtohEfV9CFrs3mH5LkGdsnNLF0o?=
 =?us-ascii?Q?bdClP/JdaIegYa8OZuw/R9yxQhIRd1NmIowII8TqqIGGudp+hPFsB4saRPtY?=
 =?us-ascii?Q?7icpJtTMb28UEyNdzNMrWxMDcLe7MOdb4pFz0IbPdzOuIf5RP/6LZa74ZANw?=
 =?us-ascii?Q?C7xCKRgYevLo6Jnhed3FAETorICZm3beNgYAu4eQ4gB9tdMBdr7U5XRBBUBZ?=
 =?us-ascii?Q?8VmxKLcERz2QCZdZ4ziNLIObr6lD0ez5JMHWWwUUi8C8rblOAguZiIuT9x/P?=
 =?us-ascii?Q?xpJXVSEIJZhbUSS12RkSLY76WKeckAbInOiXohbXFsv/128KQNKgDHyGZH7o?=
 =?us-ascii?Q?CFDXFsVhY04B4um8iGNd4dOQ3f6hDLb7891jBNLovbFfDwEWrTKWNWbBml0t?=
 =?us-ascii?Q?8G3pZe2FauzHR0RnYUvhoQPuYrf22ScFOsZ/P6OZbutyKbmsSVVXd9IKoATw?=
 =?us-ascii?Q?KYWYu96RvvJTwdwX+bE51RNZVU7BSmoAvfOTN/vzMVBIMYKPKyo1/d+BPbSY?=
 =?us-ascii?Q?JCjyyOZjmy2PWmG5HcLhQjUnwT1mFkOOG6JkrjZ8E5rQlnblvoEsS4djN+lT?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e97f14e9-bf56-47d9-09e7-08ddb342323c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 17:11:45.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SnJ9bGrhYhrgbKYMazVrUB0B485NRAo+2B0W8K+b9pi9ujb4N/M1Ux4hoy4QcBAbfGF2DFXoZHdJvKiZqL4bcsVv58vJD7Rgv6vaTF7SNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7783
X-OriginatorOrg: intel.com

Pranav Tyagi wrote:
> Use the scope based resource management (defined in linux/cleanup.h) to
> automate the lifetime control of struct cxl_endpoint_decoder. This
> eliminates the explicit kfree() call and makes the code more robust and
> maintainable in presence of early returns.

I do not want to review small standalone conversions of individual
functions for no other reason than vague claims of improvement. The
reasons to convert an existing function to cleanup.h helpers are:

1/ to fix an actual bug

2/ in the course of refactoring the code for other reasons

3/ to eliminate goto trickiness and bulk

This patch does not make the code "more robust and maintainable", it is
just churn given how easy it is to verify that the kfree() is correctly
paired.

One quick way to identify code churn is when the diffstat does not
result in a net reduction in code lines:

This patch is "3 insertions(+), 3 deletions(-)" == "churn".
