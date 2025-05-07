Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD5214A7D;
	Wed,  7 May 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602607; cv=fail; b=sDPizxzYNJD+XFN9w9nDilaz/Bt0zgBwB897s1vapR8mQlTBGxTLCRtShYumUlRFNgWZeh2D/FnJMW/Lcx3xBiK7Y7ehBkV+cpBDJVZx3twnYsodjrn+bqSEBcb0I38OLqNvl2z7IYlkkrpcI4OjY6XiYkonxsrgCDiQLXM9ATw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602607; c=relaxed/simple;
	bh=1d6QmGpcEbBsaG3g/MsqjnHTGx0gHhMibkumcVybBiU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O+ZxrZrUWeZ/cNEK6ZWRyxdjyPZxGmul0WYL7VRsJpSq3V4zVcqokzd+9CM98uGHmmh69+Tvo9pt0R9s/rtsZ6v9s8ekWCPVmSYol/L+4COcSLA4sZ7fpRjz8k4sowXBICDZhrLNCZ6SefoDIgiMzbJJ27f7moCYtzZz/UsRYtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbJ1HJP2; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbJ1HJP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746602606; x=1778138606;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=1d6QmGpcEbBsaG3g/MsqjnHTGx0gHhMibkumcVybBiU=;
  b=lbJ1HJP2gPtfrM2z5qGWi9pJyKcPVX+8mTdlm/Ng49tHOzlIjNDqRJkt
   DliAEp24nXm2dmZ2FnN3ZygmWPMqAOhyVwbWQa4IH6KQx+j7snhe7Seg0
   IfJOcfKcL1avzxqUNaQ7Lhza+jGqvIRCPexaUcIHGxHHHB1wXCD5Z9vzC
   Yoot0X+LttLVorKgA2sXfR428xm49YIHrWfcv4npgS3GhD08qBNgSv1ez
   pfu8qsDEUySDv/0N5TEODqAGo2WzQpnmukQCCqFh7FDKIf4xkCza1LpSs
   GZ/iT37w4fCnjMfZmWLU5yqwPeU6Q1O3+F1f8HJLrCUWhPFUqxJDpqzWJ
   g==;
X-CSE-ConnectionGUID: to2M0I0GRKu21Z5cMrtzpw==
X-CSE-MsgGUID: TP4FS8MOSJ6UZAiw5G+9bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47564230"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="47564230"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:25 -0700
X-CSE-ConnectionGUID: 6hK/jbBoR6eq+wIJcUg+iQ==
X-CSE-MsgGUID: nOj86PNdTTyaPT6Ifarbgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="140984974"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:23:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 00:23:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 00:22:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib/bO4wUfeAK/tLDCBwjnBYYlVGwbPxyzqSuh+9tg//f8fsXNlufXceYbE+41rn+LkNcp4adUhfElXY9dJuBZmtKOaMrDWW8T2fXSGTmNqthf1NwqmltZRR8ltYsu9gkbzEctLolTPwA/GlBkQ+KQEFH+5IXgliGmXL73/X3KVaaUBEJaS2LNZBCYKLcOZafx+JGcaGV/aWxWM0wAQUX1zawQ7bXuGqQK7SmnvR/lDqo7xc8JsTPRiy3r/Zuc0qmkridpZ12vbWOn9fqcx+kAtQkrrwnGz4ybF4bDltxiPfPk0mQcvmGC2yEjnrD5yY7u7YLE6eMgAESnutjVdW/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCSVGZAPDX3WMSGzStLOnz410VlgNT/qKRyHvix+D4o=;
 b=WFh9sbxQ1eXKQPlmCxG7vfjT29Jve5mUJfItevx5U3FbX+c0yoNd9qpHEUUt5ROAmzWmysRI0is8qSAVBbWTa0FGyCFkpeFlSyMd3xe85CFiQXstwJJEThPWBQvqqxKi9vnmaHcMnpMhNQwBheX6hZuuywGPqzTKavApc9P62BAaGoXArgoCPVhS8AS7/Z4L5hJI2Q4tAqA7SABgQpj5Kkjpn9BmAx34AdlarFoB8I6MSKaiy7aGTBVYlE/CPislk0sloHJdhLS4Ve5A3DltKQptxPdSCFOk9vcOY15tOWoydgrVGWg03SOyf0rl1/FqVcBBDBTDCk4FFQBd8pQLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 7 May
 2025 07:21:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:21:48 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>, "David
 Lechner" <dlechner@baylibre.com>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio
 M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, Ingo Molnar
	<mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/7] Introduce DEFINE_ACQUIRE(), a scoped_cond_guard() replacement
Date: Wed, 7 May 2025 00:21:38 -0700
Message-ID: <20250507072145.3614298-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: e80839cb-d0e7-42e3-9ef8-08dd8d37d481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KdiI/wJfiCXshA9QH+Bbm9MYea5VJlXo/wcZqRxVsCQKdLxjwLfI0h0NB7Lw?=
 =?us-ascii?Q?ckZjG01C1VDmFkQYzf6bk7OeVuLme2Db5+g4EwOTugsuJ4UpDWhgwYUx1fVd?=
 =?us-ascii?Q?lfZSFvu0IPczIRVeNUVcWH8xQ93cvQ/5QoMMvl9oZDWypUV9ZdLuLZlD/Z1c?=
 =?us-ascii?Q?zKlHPP5DOI4xSgVpDgYJZQo6OF34ImqL+0BTk/Q+NPgHngmIzFHgNyDFp57h?=
 =?us-ascii?Q?tVQWH4UXpq/jt2IpL4NRYYQTt1hYdxoHr9olxHBh7wHhn3JDHpIKtUE0Aj+O?=
 =?us-ascii?Q?yWNvLObTN7TYhQqIb9y5QFxrAoVEmSZuepGoYt4jTwAtJMrC4IjZsJPqvocS?=
 =?us-ascii?Q?n55HtuUNPRBwZ9u+/UqH2n1HeHFko2HFeEmYhqNARB+tZWAGdw4i0eKqGfVh?=
 =?us-ascii?Q?aw9EueYgvGoXmy0rMDbsiUn7ypLiD7kPKOFD6CcqOO22Zcw69vx96EqxoLJB?=
 =?us-ascii?Q?MSVlCzpSBHX2Yw4RqTD2VjnvFz3fd1ZVMNUzzCQw+6wiVlQmLqz/25x4be+G?=
 =?us-ascii?Q?qOlGa4lqviXDsQCxD5Vpqu5dyswFtJmr5p8+876ittRmQ/K5SmUcWlL+fago?=
 =?us-ascii?Q?cJDIzSNiXns01pIV2vFbKN6dsz1JLdAjijNLmvYuFV+3iT63ltx+zx61eD8Y?=
 =?us-ascii?Q?hNTAYO9NzCo08a/B/fBwpiYJz5xfv1M316m9y772sWQbDV5pBto91vv1YFfI?=
 =?us-ascii?Q?r1ZmTN/bK2oDQRxE3xJx7oSklEr/XggCgp3OBf+YQB5mY7P5Q+oqgMX+o3ve?=
 =?us-ascii?Q?76jxjRe03VplRp2MlZ1FDbnmQHNeTvBLs/gOpm3gQVoi65v7cfwfRc9Zlpwc?=
 =?us-ascii?Q?nMgvY6uCj5k9jFgw8NdHWLLLI/7/2131Obwd5Q++fkTcrPqWXf/Tm14MOXXD?=
 =?us-ascii?Q?dRFr9+eczsdmzkltSysk6myYT+wzr7LKm4GrqqMjBKSGLSdrfNiMUJo7kI5M?=
 =?us-ascii?Q?4S/CgT79D7muYPA4DrXwyo9RuKs51JiYaPffam5cZyC0GXDodvuzdTkoF+p4?=
 =?us-ascii?Q?6CaUX2HuicG/jv7vEnixILDrXGN8q0FczksPGE0G+Glx0qs6au3VOxv1tVKp?=
 =?us-ascii?Q?q6f3xUC2Nt2nr/o/8dYHWZiRxF+OA9YnzdIajt26VvaQRWMeoXJTMV36HmmW?=
 =?us-ascii?Q?eobQjqZF7weMiieryGnzfHPo9E9vUNR4oepNdeoRql2MJy83Mwt5R4VtgMvz?=
 =?us-ascii?Q?vyo0JZbOwsfStezpikpX45CrfxR0nlqVZA4NIHqYP2EdrDr8mHkyGctnXPlb?=
 =?us-ascii?Q?gBU1T2+6F3oEuYzXO9fLp7YF3fjG/9HuDqYfdLXHq19rcl3rGVym+OZY8QGm?=
 =?us-ascii?Q?zg0gEyIVarUGQjBk8krBswJYBvKS2rphpBohQmDfcVaOEji5gzj0dmDbOK2B?=
 =?us-ascii?Q?jpr3lN7S8qGSoyBjebdYsegl6jOBa/p8Ff6ayICsY4pQO5lWMnyhkuFA8/dX?=
 =?us-ascii?Q?+gAI1UkUCA0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dxV+U7Adw08a6c8mwFxDCVXQIGnZbsLIz6Ld7OVhcVnRQWhHo1Vy5WgLZPwb?=
 =?us-ascii?Q?lV9QEPPmmyoO3E1hUL7tI6vLz5z+S4ruR9W667/Ot4N+yEybyKNVO+jopUSb?=
 =?us-ascii?Q?2CPB1p/qRW6hseu5lXVsrlsd2Td3pkG8y1z5U/h+P+uoRW86yTOCp4zIiVor?=
 =?us-ascii?Q?EbL7SNuEI2oaW3xZS3KzzmJS92tZhip98/g+rjqji57YsHl4x4Q9mgol0+2H?=
 =?us-ascii?Q?Ho9lmUq878KO9jsC4PUZ0DENbDmp2ws7RyVIwzRnGClZYO9RrVRN1WKaIFSQ?=
 =?us-ascii?Q?QgOJ1lXzVMbRIysr3OTR74/iOvNiiNLyxBksWTExO0FpeLJ68gGflNpEcmUO?=
 =?us-ascii?Q?+kmMwAg4heg2H6KmP2gxEafYCq7KJ4W719LpcRUUF5xifTUIsJwPOAugjk/u?=
 =?us-ascii?Q?zNwA0XFMOm8wtFQWjaR28jImrhSPpG4b2a3dK8xTpbAMeVY2LKrFp0kFQlvR?=
 =?us-ascii?Q?uOLeqyOXor0Y2L52wsZpc5j9v40odCrT63uaj9TU0TvxKx+4alcSBFw+5tOa?=
 =?us-ascii?Q?8cJFfNAzWZhdjsrV11twr3SC39k+nYa0YbMUSGDEkcZVsuzGm20DQ2Kx9eg6?=
 =?us-ascii?Q?M8kUsLKTNjLcSGtfJolRr3wHzG33Ny/qlILy7anXfyMKsaCua1O/263Kw54A?=
 =?us-ascii?Q?tArayja4R5I0oKS1xxI3YFGM6L5+eIqJF7eGVrqU9ouRhNpuf3RLLHqclwpb?=
 =?us-ascii?Q?2YgGb/zO+Z1fEyfXgod7469xUWZfp+TUWhGtk8jDEoJewdZpbGgiL67R+GKB?=
 =?us-ascii?Q?N5HX9J46P+2vZebNuyCib0u5EMBeqkh5qkTYPYxTpLdipQFIco7jW5T6ZKUp?=
 =?us-ascii?Q?5KRTGZ95cvHK3o6lrwlCQzOP+QwLuVrtjBpv5NhETxrTqQ8mjrfFHbVngVi5?=
 =?us-ascii?Q?YWpvk++mFn+d6Xax/ogR3fBJIjajQIC3gJzdxb7G2d7wWnpuWjG1mznHv/Rb?=
 =?us-ascii?Q?E8FcLKU79l0Umk/qHHcUS1ymSZKSUqiJSIivLvPh1nz+0Kw0/P/YDd51oJXn?=
 =?us-ascii?Q?SlNOuzzMq5xYT5v1IGIKUV50gvZ9o46rl/AQZ1Wky2W46re0H+OUQHfIxqRR?=
 =?us-ascii?Q?Lx6EKvvTys5zgckLCK30z049QF6qTWCrSOtJrXSYdIi1gYG1+fsK9b/VazBU?=
 =?us-ascii?Q?sKX96H/FUG7NuDW/0ITSLXzZDRAZgqdAzPgXMUmI/XhEdgcyqVnYTWvYh6Vj?=
 =?us-ascii?Q?cZBRcT0KeahEUri+YAKwwyMese+ors57e16NofQ/v7M2YtLAqEMBFLi5/aVo?=
 =?us-ascii?Q?3KBywlyLnpi+lwa445XQJLfwXJfj7XQV+hYLrU9UPeRyrjgO3buE9gmCwUsK?=
 =?us-ascii?Q?sVk8sBDMjUN+jeg046OTY8xSjKUE2XI9wJhhf7d5xcXoswaXpzp4Q/pxfLgQ?=
 =?us-ascii?Q?Y1fNPdc9uwEEg7WLa/zU9Xzl+wWxb0/I865grrcPCmt6XHZhTWHEH5NkNnnC?=
 =?us-ascii?Q?/L6DOwdNoD7y+V2K3t/5xuhZcXItVvGR5uu0rBSpaVdrv4dVBp7MiuQeT0aS?=
 =?us-ascii?Q?McZUW3Sf/FnNleZjzrO0zVKVGamApxMBej+9pYJBNpg3cjv9krQy1mD32850?=
 =?us-ascii?Q?dtrx7v0A9kkLfGJ7IQ/W1KiJwQ60dWijXKyr5BtiDybsm8rSDptNDKBU+MPL?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e80839cb-d0e7-42e3-9ef8-08dd8d37d481
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:21:48.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAo2+/bvVmpCWxnMhMGBL/hfv8uEqu+VX6AWvC4r953Tdg8WYJPNQTQGE1Wtp0cgwdgypzOJTi4EztuL4Tf8BR7bw1txIpBYDTJCebCCE3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com

As detailed in patch1, scoped_cond_guard() has some usability warts. The
"if_not_guard()" effort tried to improve upon the situation, but was
buggy and difficult to fix.

It turns out however that CLASS() already has the necessary semantics to
address both the scoped_cond_guard() and if_not_guard() problems.
CLASS() can be used to define an auto variable with a constructor
(lock()), and a destructor (unlock()). This is what guard() does with a
hidden variable for unconditional locks. For conditional locks, the
variable is simply unhidden and evaluated with IS_ERR() to determine if
the lock acquisition was successful.

The proposal goes one step further and forces conversions to this new
scheme to be type-safe. So, if a subsystem using a mutex wants to use
scope-based unlock for mutex_lock_interruptible() it needs to convert to
the 'struct mutex_aquire' object and convert the entirety of the
subsystem to using CLASS(), guard(), and/or scoped_guard() helpers.
Note, scoped_cond_guard() is not defined for 'struct mutex_acquire'.

Reworks to accommodate type-safety enforcement is what makes this series
7 patches instead of 2. It converts all existing 'struct rw_semaphore'
usage in the CXL subsystem to 'struct rw_semaphore_acquire'. That
requires cleaning up some "reverse" locking patterns and "unlock in the
middle of the function" patterns. The result is smaller and easier to
reason about, once familiarity with CLASS() is established.

Dan Williams (7):
  cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for conditional locking
  cxl/decoder: Move decoder register programming to a helper
  cxl/decoder: Drop pointless locking
  cxl/region: Split commit_store() into __commit() and queue_reset()
    helpers
  cxl/region: Move ready-to-probe state check to a helper
  cxl/region: Introduce CLASS(cxl_decoder_detach...) consolidate
    multiple paths
  cleanup: Create an rwsem conditional acquisition class

 drivers/cxl/core/cdat.c   |   6 +-
 drivers/cxl/core/core.h   |  49 +++-
 drivers/cxl/core/hdm.c    | 115 +++++-----
 drivers/cxl/core/mbox.c   |  15 +-
 drivers/cxl/core/memdev.c |  62 ++---
 drivers/cxl/core/port.c   |  18 +-
 drivers/cxl/core/region.c | 463 ++++++++++++++++++--------------------
 drivers/cxl/cxlmem.h      |   2 +-
 include/linux/cleanup.h   |  62 +++++
 include/linux/mutex.h     |  24 ++
 include/linux/rwsem.h     |  37 +++
 11 files changed, 491 insertions(+), 362 deletions(-)


base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.49.0

