Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA021228CBE;
	Fri, 11 Jul 2025 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277794; cv=fail; b=YAj2Jm7RZBx8QKbgRarD3v+LM6iJo6HpC/UcjBwfWCI20+PvE2NLjGS93AFK+I233UcuO2FwXeI8SShSa8PcKJ1XEKz99kRN2yC4bHn7K2KDdVUHrDID5/1mFpqpvKQcvYPbZgZbJjiLDqOW3mZH7W1gtRv7YDWECphwQbAx/Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277794; c=relaxed/simple;
	bh=Aqlf3qzHa+n2Si4SGi2n7LwFtvacg5fZzZIr+yAt7xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7Lmeag4tt9Ng68Qz9wpN2j8YFiLmktqVhdaOwQFXtJbz82ZeRVVSqLVBBFqXD6yKl4LHrWqgOWAZxhnIoNxmzj+JUJyzcNEWtvm4I/MtCOAiVcyBnneok0Vkomd3GyAbuk4CTnNvhNPP3kEeNfQgIRvvfQElqEwpYZV4U0PVqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5LRlPMW; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5LRlPMW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752277792; x=1783813792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Aqlf3qzHa+n2Si4SGi2n7LwFtvacg5fZzZIr+yAt7xk=;
  b=A5LRlPMWpnmCxkxXkkiLzhwHcO75MQ6Tw/OxCL4AifNviUH9U5cdabi6
   +XyAV4T6Ey6BAY6PAN2oxC/gfrm+o2xcTBs+RqovOHYPBLBGDmg3d8FCX
   9y7JRr21l0ZW6IjvvcMCrShnPh9D8BV6vubtJiPeSd2sD3yxrFkaUiH4q
   XHBU33iNj7W1pmgxtoYne9KWzWbujqU/nEwGtCm7bjlh/e61VXdrPllnB
   /Eov9KE8UGfvXuMpUB3B8UIZ/IRIOsPpsNOP+98QqknD3Bexi1UQ3sR0L
   9ywrn7/bi+Tl3WEgnL5ilfrfi8y6dfOLyS/lAQ4itqediQCtKyUoGuVqU
   g==;
X-CSE-ConnectionGUID: M7S2X0UhSkSuVCXF3hEY3A==
X-CSE-MsgGUID: hEqIASWnTrKDc8Bx0S2J1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58344035"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="58344035"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:49:47 -0700
X-CSE-ConnectionGUID: fco6GQ8nSzuoVeGQQ/NXsA==
X-CSE-MsgGUID: 4BtzcbY4RSayJ2MTZXRhSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="161030718"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:49:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 16:49:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wz0XAzk+xCtWcn8wa5KSi3FWTCEcYIwuyNZ4aHmivhcbEVM87khztIIUAoUcEtn3E0EDN/k+5qi+x+vlSLz+vpIVcPWNZQvQlKE2IBxk2nuZT4bgTQOP5YGC0RDkjbOj5PbBR/Pd5Po+7y0SJqem/tfWVYOjFo0FQMHoP0+lmk+E0cLnvnDaTubWOkCt1wxGUpRUxi+544TqFnYFr9O48NVGBZRVwSMIIdfxeG2kPqAscrxyyYUuH8AaUEQ/bxswrQGZSKBP2bFckXTx3/PJUduN+RPekR6G+ERUpXDKTz43BER3r8L86mlgcDF+3aiOwFDy53oW70945ZdllUxWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0xjif2dCgYbvzbmNRm5ldKc8nyHopFwfB8A99IEz2E=;
 b=XvbR749gC+sfmeChUH3YhKj6JQixigKfiuN+5XUDGi5d5wIBqyjcHmh3YzkZC93W6eH/GlVZthpKQHMTPpTR1+IwLNJkyy8l09KxXIrxEdZts68mPXkez51i6c0RkC6jiyQwBP/mTWl4VYKXd1x8uEtXPmd1KcWBk09qGdEDBLBGt78YuMhcf2rlsOGaPpum9KIY2/g9uDymeolnFbtnT6wsLuHuvcHIPvB5hOs3xkY3QyMWfVyuDEGMRC8ENvQ8vGgv6BOmmi0KSBYS15mTcmjz0hnTVdfK56Gw3L5m+ZpIRytorUeozDOBY3GPe7FkheGktatKlQz02k3YunKWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9352.namprd11.prod.outlook.com (2603:10b6:208:575::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 23:49:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 23:49:41 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v3 7/8] cxl/region: Consolidate cxl_decoder_kill_region() and cxl_region_detach()
Date: Fri, 11 Jul 2025 16:49:31 -0700
Message-ID: <20250711234932.671292-8-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711234932.671292-1-dan.j.williams@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2e4df1-c802-4b81-d593-08ddc0d59ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X2xuSEBRTYux3E029dkIKe/YKv/ta14plx01368fn54O7GmvRSVtUi+fBQBu?=
 =?us-ascii?Q?D7cqhMm0VcLsyAjvB3Xnp0QkUC3hk4b3MI1tFNnFU1cWJDxKv7AfMqi2rmow?=
 =?us-ascii?Q?I2uJjerwnBpZAWHl1/LJHXMZ5/YQiAR6R6GVcfH1ya0QQllr0xeWFV0W/U6m?=
 =?us-ascii?Q?z3RV87S/+zA5flEfbuaBDFdJZ/F6PC9OqBEe2n/UtZ6MTD5JjAekN0rCkBQW?=
 =?us-ascii?Q?0urFU74tSh5RBR4J1ua9KCiRkdwGjiPBAWzBFNdepylJu829LVif7SKLBfdQ?=
 =?us-ascii?Q?CvTmPd5qchodRb4leUTwaqHWhej45lJZZ6MX+zccBCgk716voHYd3EMB7JMG?=
 =?us-ascii?Q?SnCNS2DuD4EJafZhPUrVNBEebXPXObxttZIUgRBn8qocae1EWf35n8RIH7Yq?=
 =?us-ascii?Q?dMFtj/q7UWmhwGvVkawwKOVDPJmsooCcQEahFssOSBdFEejnF2g+GL3DBACe?=
 =?us-ascii?Q?PpXiKDKK5THZTORlhwuNks9ClQK1Bw8+afBwkozSFcOjSIiKYwH+HEqymNo8?=
 =?us-ascii?Q?MEm18EBCbTH4eQXXpAie7oAUrFF2Grw2Ffk6lS9nWeKSOXrkL11HPDX+utDc?=
 =?us-ascii?Q?4bhy5L4T1Mk9WASOpEYa0Rptyv4R+ZzZNOTIpWLh/Yns9wg0PO8QtoTNxtgf?=
 =?us-ascii?Q?BoQwE8+ilb5cLCftn0tZUUw5oybap0ZXADszuF5jisHm2Wt8sKL9pCIynNYY?=
 =?us-ascii?Q?EJVBifB4nOvhbGa23YVyK7Tzc3R9IJGBQ8mEnXMlIAY1ZByxsHf+s2JtBeyq?=
 =?us-ascii?Q?Jo79kEWlAT/U7nDLg2CoYscKKGgIAC5fCLft9aZFQLedevhtAdYYLeprzKH0?=
 =?us-ascii?Q?Ckwok0iagGKrxj7F457otn493fP829OCs3Ji134E2rRrjR116nm1YjY0Mche?=
 =?us-ascii?Q?KTVKNOIbgkjCw0XQ0RiQSRb6XbCj3/6T1BFGO5hT2u0/V1ERHx8ljxDgflHG?=
 =?us-ascii?Q?ow885/IfhCkhhzAj3Ja9ygO3cWjOjoJNoeyKng5ZGygTLJwCLppF4p3LmwrE?=
 =?us-ascii?Q?++FcYBwj8Tj9yqw4x1AA+TahVuKe+yO/Pl/KS/DtT9Xm2EWJO92RXlCZSWND?=
 =?us-ascii?Q?RHy+n6imMQNxrxa6cVUES6sN4y7sa3UiuKnTgphdAndCt+IUueeLHdxuH+Y3?=
 =?us-ascii?Q?C3P2wHmXKE76IUT3E/Sop58cNwAo25qZAwx3DAGCl/B2uZ3nBQlIwDyHCbdH?=
 =?us-ascii?Q?KESf+6JDyCZO3h8oIob1J2xVljL202PDXFkL+zJ8/jI7LKordJxfRp/uKavf?=
 =?us-ascii?Q?7n8LnMSDHGLCggeeCg4oA3EWgIMylpSESVf6rR214YJ5q8XbAZVgMD7wbTfw?=
 =?us-ascii?Q?+DbJwKu+OY7zDqt3OJvdMxeVXbeCpef4//KzOIeqqRI3yC3NXSGxuvwXWLot?=
 =?us-ascii?Q?+c5R0Dr2iFfwVhn2PT7kGisyfTlUE+pIYDrGnOKVEzpESoM7GahR6Se8YTrO?=
 =?us-ascii?Q?fM9FuhOrwhM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z5k1FLj6bZirsQpxAeB5DNGEompSilRga3LA41F8Ex10/FmrSUFtgC2/7fUJ?=
 =?us-ascii?Q?Syt95ht45NWdzPRFAY6jGYfH8BhfbLKmw/5jC8JfclyYB+cjlbOEzHS6r/ho?=
 =?us-ascii?Q?8ATcTQChLAL2qxvTLLqn5M1jOeEcSHb0G4OCyfSGZg2p8rIkEH3r4K/UDTYt?=
 =?us-ascii?Q?g5vblZH3426HYb6qX/8LlAdGK87trRcLY5yZvu4Y8IDok4g5nu1uPuPqohz6?=
 =?us-ascii?Q?pFpypWSvFNXbL3Nl4+TzUp4dT2TQ9QWJKOo/jDr1CNyhjwmn0zb3PLJSBBix?=
 =?us-ascii?Q?QbXS2VRWihjdkwEPR12bOZUHed1dauZ0ingfAbIeFXqRDDRBTlAHGH76etnD?=
 =?us-ascii?Q?wvT9PKFkiH2OaFc/tN6K3NdYaXx0BQiegVxf5p/QGPBJPrk0NJBDJf+UN2W5?=
 =?us-ascii?Q?kXEMwWtv59EkSKatVrAhgoLfeRRdoJn6Tj4L/XL3cDzlNHY2Ix3/a5NqOpqm?=
 =?us-ascii?Q?+jc/sK0qqeNW7O9nSqVvGt4G0fUcVvjemnL5dQeDohK24q0S2UkwPyMxSQcv?=
 =?us-ascii?Q?uPjP1GOdmllsqFrpPk4js/A/p13ceDjuQ4lLftd2RDM1x5IeCXJI5x1/w4CA?=
 =?us-ascii?Q?1o1QN6v9CT2LSWVtdf0c/Pb5Fh7IOVCXLcAHke9gQn5updwAxBJWcq+oWyxH?=
 =?us-ascii?Q?vgRBPX33hSOBDG+PoM/5anoZc0ok3BiM1zXVAOouF/lVWxSOMwD3xx+BOS17?=
 =?us-ascii?Q?wuzCFrgGZavdvl6C/qSwxEfvA7vWDKk7h4bZ+Qp8s1omYEr73oCDiczU7zfc?=
 =?us-ascii?Q?93J+/DCb8DqzguVx6NB89+3TqIFedrSns3d00zhMMt6B5k8fd3/JT/f6f+/G?=
 =?us-ascii?Q?T3CH+arm2EVh8S1lh6ttz1XukbPlyST7+lLUf/9tGqEw3KwcQk+g6VZyJFyN?=
 =?us-ascii?Q?dFM1oopusz66yNvxAd8GbM/64QW/4Ex5jumB2bZWUJDPkx1oWFEUGRJ4ioIn?=
 =?us-ascii?Q?6oFDgijh011sHmXNqFSWfXqt8olcpen9GLNRlCShOJUsLd58+Ufcs7V0CNTh?=
 =?us-ascii?Q?8YuGMGsdBVLwTugqFIF4w6XD4DH1f+GoLmYZb2w6Rq6NiU7MbMKr+2kNNWMd?=
 =?us-ascii?Q?kEwnL+CuKqvpiHKsxYxxE9/KC3z/L1tkvqaQIHRjb3LqKmXW4UmzfuMetr0Z?=
 =?us-ascii?Q?LzGfyChwVQLlvQ7FdgoWo6BgfXBi1Qcwb130JLdn1Cew4dxS4P6GeiGAhS4p?=
 =?us-ascii?Q?cSl3ysz516ar8kMoou8KD1uE+paJTyfd3fE16s38UxvObhCMq59sqvgorXg5?=
 =?us-ascii?Q?H2C+x5+lc4LGO7Gaq3J0qTHULZWpuAkeNN2UAgae+CoYvsiXZVRn2+/e/BoO?=
 =?us-ascii?Q?dxwS6JvnkhhN6RPC3RzgL3TyScxXWjjF8qoFV8/oUrssxp4F/IzxlUFRm1sz?=
 =?us-ascii?Q?aYkAw2hmBl1slz2D5lmgxVA+Vu3E+Sm2aHZZggruJTP31OfDehzMu1i5Tp0j?=
 =?us-ascii?Q?aUqAgqYUiZr2LbOF/hgko4xS/a4/Dj7m6CMsJPTdPM9qmqIYYQso0Wtx+aYV?=
 =?us-ascii?Q?9elk8vVWYLheV0ORXpUyS0tpflpFOv34EDPSXXv+3EQzxqW10MZLLmQ7d8DW?=
 =?us-ascii?Q?XxEu5uqA/Muv1OlNtiji4WZm5kF3oCLgUX/S7eOL21hsI4kE0WUKNr6GNyoI?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2e4df1-c802-4b81-d593-08ddc0d59ae6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:49:41.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cmnebn0YOceP618KG2/fSTmAYIFdcXJXgE6U5lkKGcyQakDDrXXUqtFdIB84nATkt7hrzL4FaBAjyy5KJd8U/2lp8cPOISdP97idhN/7l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9352
X-OriginatorOrg: intel.com

Both detach_target() and cxld_unregister() want to tear down a cxl_region
when an endpoint decoder is either detached or destroyed.

When a region is to be destroyed cxl_region_detach() releases
cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.

This "reverse" locking pattern is difficult to reason about, not amenable
to scope-based cleanup, and the minor differences in the calling context of
detach_target() and cxld_unregister() currently results in the
cxl_decoder_kill_region() wrapper.

Introduce cxl_decoder_detach() to wrap a core __cxl_decoder_detach() that
serves both cases. I.e. either detaching a known position in a region
(interruptible), or detaching an endpoint decoder if it is found to be a
member of a region (uninterruptible).

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h   |  15 +++++-
 drivers/cxl/core/port.c   |   9 ++--
 drivers/cxl/core/region.c | 103 ++++++++++++++++++++++----------------
 3 files changed, 75 insertions(+), 52 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..2be37084409f 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -12,6 +12,11 @@ extern const struct device_type cxl_pmu_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
+enum cxl_detach_mode {
+	DETACH_ONLY,
+	DETACH_INVALIDATE,
+};
+
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
@@ -20,7 +25,11 @@ extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
 extern const struct device_type cxl_dax_region_type;
 extern const struct device_type cxl_region_type;
-void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
+
+int cxl_decoder_detach(struct cxl_region *cxlr,
+		       struct cxl_endpoint_decoder *cxled, int pos,
+		       enum cxl_detach_mode mode);
+
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
 #define CXL_REGION_TYPE(x) (&cxl_region_type)
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
@@ -48,7 +57,9 @@ static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
 {
 	return 0;
 }
-static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
+static inline int cxl_decoder_detach(struct cxl_region *cxlr,
+				     struct cxl_endpoint_decoder *cxled,
+				     int pos, enum cxl_detach_mode mode)
 {
 }
 static inline int cxl_region_init(void)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index eb46c6764d20..087a20a9ee1c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2001,12 +2001,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
 
 static void cxld_unregister(void *dev)
 {
-	struct cxl_endpoint_decoder *cxled;
-
-	if (is_endpoint_decoder(dev)) {
-		cxled = to_cxl_endpoint_decoder(dev);
-		cxl_decoder_kill_region(cxled);
-	}
+	if (is_endpoint_decoder(dev))
+		cxl_decoder_detach(NULL, to_cxl_endpoint_decoder(dev), -1,
+				   DETACH_INVALIDATE);
 
 	device_unregister(dev);
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2a97fa9a394f..4314aaed8ad8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2135,27 +2135,43 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	return 0;
 }
 
-static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *
+__cxl_decoder_detach(struct cxl_region *cxlr,
+		     struct cxl_endpoint_decoder *cxled, int pos,
+		     enum cxl_detach_mode mode)
 {
-	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
-	struct cxl_region *cxlr = cxled->cxld.region;
 	struct cxl_region_params *p;
-	int rc = 0;
 
 	lockdep_assert_held_write(&cxl_region_rwsem);
 
-	if (!cxlr)
-		return 0;
+	if (!cxled) {
+		p = &cxlr->params;
 
-	p = &cxlr->params;
-	get_device(&cxlr->dev);
+		if (pos >= p->interleave_ways) {
+			dev_dbg(&cxlr->dev, "position %d out of range %d\n",
+				pos, p->interleave_ways);
+			return ERR_PTR(-ENXIO);
+		}
+
+		if (!p->targets[pos])
+			return NULL;
+		cxled = p->targets[pos];
+	} else {
+		cxlr = cxled->cxld.region;
+		if (!cxlr)
+			return NULL;
+		p = &cxlr->params;
+	}
+
+	if (mode == DETACH_INVALIDATE)
+		cxled->part = -1;
 
 	if (p->state > CXL_CONFIG_ACTIVE) {
 		cxl_region_decode_reset(cxlr, p->interleave_ways);
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
-	for (iter = ep_port; !is_cxl_root(iter);
+	for (struct cxl_port *iter = cxled_to_port(cxled); !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent))
 		cxl_port_detach_region(iter, cxlr, cxled);
 
@@ -2166,7 +2182,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 		dev_WARN_ONCE(&cxlr->dev, 1, "expected %s:%s at position %d\n",
 			      dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			      cxled->pos);
-		goto out;
+		return NULL;
 	}
 
 	if (p->state == CXL_CONFIG_ACTIVE) {
@@ -2180,21 +2196,42 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 		.end = -1,
 	};
 
-	/* notify the region driver that one of its targets has departed */
-	up_write(&cxl_region_rwsem);
-	device_release_driver(&cxlr->dev);
-	down_write(&cxl_region_rwsem);
-out:
-	put_device(&cxlr->dev);
-	return rc;
+	get_device(&cxlr->dev);
+	return cxlr;
 }
 
-void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
+/*
+ * Cleanup a decoder's interest in a region. There are 2 cases to
+ * handle, removing an unknown @cxled from a known position in a region
+ * (detach_target()) or removing a known @cxled from an unknown @cxlr
+ * (cxld_unregister())
+ *
+ * When the detachment finds a region release the region driver.
+ */
+int cxl_decoder_detach(struct cxl_region *cxlr,
+		       struct cxl_endpoint_decoder *cxled, int pos,
+		       enum cxl_detach_mode mode)
 {
-	down_write(&cxl_region_rwsem);
-	cxled->part = -1;
-	cxl_region_detach(cxled);
+	struct cxl_region *detach;
+
+	/* when the decoder is being destroyed lock unconditionally */
+	if (mode == DETACH_INVALIDATE)
+		down_write(&cxl_region_rwsem);
+	else {
+		int rc = down_write_killable(&cxl_region_rwsem);
+
+		if (rc)
+			return rc;
+	}
+
+	detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
 	up_write(&cxl_region_rwsem);
+
+	if (detach) {
+		device_release_driver(&detach->dev);
+		put_device(&detach->dev);
+	}
+	return 0;
 }
 
 static int attach_target(struct cxl_region *cxlr,
@@ -2225,29 +2262,7 @@ static int attach_target(struct cxl_region *cxlr,
 
 static int detach_target(struct cxl_region *cxlr, int pos)
 {
-	struct cxl_region_params *p = &cxlr->params;
-	int rc;
-
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-
-	if (pos >= p->interleave_ways) {
-		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
-			p->interleave_ways);
-		rc = -ENXIO;
-		goto out;
-	}
-
-	if (!p->targets[pos]) {
-		rc = 0;
-		goto out;
-	}
-
-	rc = cxl_region_detach(p->targets[pos]);
-out:
-	up_write(&cxl_region_rwsem);
-	return rc;
+	return cxl_decoder_detach(cxlr, NULL, pos, DETACH_ONLY);
 }
 
 static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
-- 
2.50.0

