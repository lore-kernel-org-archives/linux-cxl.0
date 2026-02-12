Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09585245008;
	Thu, 12 Feb 2026 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929634; cv=fail; b=lknzaZrD9s5ZwbG8Gjo/GWC+FzWbPcq/MvQ0Jl37660hMCV94+4nRad1dLIEaQHFWzhdmXw4cFOBXLtAI4hgGEssgs6I07RgL2CIyuScqGrJwwXlxHLa7NKYD/0tY2mNNPwG/CWuAFw46lnVnt/4i+asrcND7t0NZvKzjHsjhAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929634; c=relaxed/simple;
	bh=DicUo8yF38/R8RkmHOdn/aQsXoJKhGW1Qls5slYCOdY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JA8NJcJAS7st4swZXTObvhUSO5TcmXU0XST0HeKgjqvxJitkVVBM77TbjaHuxv3O7Glkhf6PLKTMzMHR6GbKp+0svanHwLHqOsNlfVRnVBDUBdFXQMUAWdpbeS0FboAzJ4lIvd8UMb52TnuFSXocOXoB/tDaFGXwCLnyPL4vW2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyotIqUu; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyotIqUu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770929632; x=1802465632;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DicUo8yF38/R8RkmHOdn/aQsXoJKhGW1Qls5slYCOdY=;
  b=AyotIqUuQMjCe8aguli4K11eeOFWEG69XQbxy7wxdkbom6OtJLQqIL5O
   QGfYJj7T7vWGGYdeyDhFKnNlsn7TL098UixvQtCxkZgsCOZkP6AZWod9+
   49CDqwgJCbq4fiTD9GiFylqA5AHb0g2x+5PxeMtt2+zozRn0atoSExF0d
   PMykMI7F8CaUzKiS88nyzSyZz3U9XzR1k8jAbRi5HpBC8RIG85dHVebbD
   Lk9A/Z/8KFVMAqP2/OvdCqUiJvJZwVmH9dGKCin6vtm7CID07UmRVymUV
   0kUD4Inlq8XvHJGEbd6Dpfwx0+ujZBTq5uVDriMRbqzDHn8AU0nWyD4zi
   g==;
X-CSE-ConnectionGUID: 5zdbVnBDSu6BSvMh0BxORg==
X-CSE-MsgGUID: QV7YpmlrTRmlQ/0x9EkorA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72186991"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72186991"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 12:53:51 -0800
X-CSE-ConnectionGUID: kRVnUPmzSwuSzye+E46b1Q==
X-CSE-MsgGUID: zOlo9psaS8qq2LOJFBr+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="243311703"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 12:53:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 12:53:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 12:53:50 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 12:53:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUGz0S8La202c2QEK7J7ClJHBv4ZmBbl+exOj3GORNHVMqnC3JHqPNFyojn+55JBEST+F2ePyOoeb2YQgCBLiSuOC3FS7GTUq/6Dwp08lKNSMa5idPYagEwbhB2C1wO10eCqJRGvj3gcuDS0fcYJM+D+46l2fkUx/9MJb66VP5X0n+WC/njdoZ6CGl3dE05QtX2pjAJwKOjce+xfS4HUR0Ns7PGsUK42ysFlTa40r+tR8TMxCW3Z0xB26XoNjN1nHylVc/iBsDh65udR2WTgOp0kxGvqTvmC0Pz3hgLW9c7We9NHI5U3+Qs2uT5Euas3dphqZXb3+jM5Uy0puLxi1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DicUo8yF38/R8RkmHOdn/aQsXoJKhGW1Qls5slYCOdY=;
 b=dPNrFmQNQTjM+FCSaCBOhHNSoQBltCyh2DSEo37SUIphw5zZFn5jD5cVAA6qJwHToLlJA6torEiIN7f+NZYUXK0WYNCBNVo272qNYhj1ZEv9dJLvGVIjQFpOUJYRjvYsclHxOgrb96t7CzLxf3w1mS4RwRdiQbXfmd3SN8FbQi5rRmaeeZv0oe8Ek3LgH7bwmulIGEV/Qf6EkiG16uar9ZX3XL6Ky/D92pMiiRsHLuu0xTffWZxBEuTqiQEljy9KFjL2IhLIBLmKpCg57cJUGORvx2UZle+Jr/67t6RsHjuhhPC3K8SwCqhlxhTKKDWcCzWyn9i5QQjfYElQ+k3peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB7645.namprd11.prod.outlook.com (2603:10b6:a03:4c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 20:53:47 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 20:53:47 +0000
Date: Thu, 12 Feb 2026 12:53:43 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Fix port enumeration failure
Message-ID: <aY491_3vC1ff803O@aschofie-mobl2.lan>
References: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 92caa88a-2d96-4a26-e44e-08de6a78d118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0X1nsbRnRzXarK/f/W25AFFq34b8sstY/F6OkjgjeF3GTf2UWqkvIxAArm0u?=
 =?us-ascii?Q?p+8CdudGHX4XUoBwrHMDBDR9oLhJzOoKtL7pMx9178lX/Drz8GsYIJ5R2e/E?=
 =?us-ascii?Q?EXdbV4kMEGXXOcU0tPVC7leClcZTyyYSikfItL34AwvkRlYLsK0tNbVUCg5v?=
 =?us-ascii?Q?FKdt7INzRWFv4fxR9QLUdhg9jvpjPK10C3rIaUoteatjBSe8DmkSN9i9+27q?=
 =?us-ascii?Q?REcQFt4X32cYNG0PCHPP3noz0LHv6U8hoIcUds6x8r2pktn+CcQAYNzgDup6?=
 =?us-ascii?Q?JREs5yC3xVg297nU/RQLTQ4VwZroYZ3inV0npqcAKZ3oPt901LwAlqHDyEGf?=
 =?us-ascii?Q?Ooj2TeatwlTLJhMOWGW33Rp7wHj/TdrrxRV4MJB8XUtHnqY7wopdB/XnnTI+?=
 =?us-ascii?Q?yQbA2rIp+dgyYl7YI5K7FmlvakXuEEeNtwojHPnYNW3h8yUh9PsiD/5JetJf?=
 =?us-ascii?Q?b7qSyxYWctbvmcLUE65DWeYcPSqaHXT2lakQ5f8Oz2l/k8ZBBXIR2bzhYorI?=
 =?us-ascii?Q?j70iOvJfn2ki2Sc7YOo9XE/nY5DFCbGRUMtFy2JEUgz08U0hW/DlNp/CaHMB?=
 =?us-ascii?Q?Nz7nfdReRx7TtLi3FRMWpDVOE20E1FK/w7DsnwlU79E1svY/TXWpePM9hBWW?=
 =?us-ascii?Q?vBvWZglvg6HPGclACV6lCxwiQTDWQvPsNJ6OB7GdMUFkf/4OfQn5VjzZ8ceu?=
 =?us-ascii?Q?Ge8yMgVWS1hA5C8x5sFxhFB2a/ummq2A3AlintoA1mYHpetuMSOq9b0TyIzn?=
 =?us-ascii?Q?99Uz7U4GXJ982x8yYwtwTg25P8mjASH3HUEEvEMRImLkBkLxdp87XAWqibYn?=
 =?us-ascii?Q?e9tF07Si74GNgD2qZ7ZPEhrln/ThVQ+0We1FokQ7f/SfqklWC2Vv5v9JMmKb?=
 =?us-ascii?Q?Q6KdmdmtP7MrTlwl4nzbHygvv3/spLdEluGOUKTM5IKx33kBSqbK7SBkDcgu?=
 =?us-ascii?Q?7lklrsem89I/hbj91ZuCMXuRJ1RpRHsMx0ASzcts4VEif0jwwwql+l+hS8zx?=
 =?us-ascii?Q?i6op1wtpDLMj848lKTeon6rnMP3rpPNbuuYKWR01aAXyzGvyefjFlXWiGUXs?=
 =?us-ascii?Q?j5l0gxluyeaBSbv6p99D9Kb5HWTdtQkRZeJbKo0v2LvpRdojtmDBCSih7RbQ?=
 =?us-ascii?Q?2sZRVocx6OgsecpzRItKFf2jpkrj3VevGhBDQGzWZVbSAsu5aITUzPJhJLz/?=
 =?us-ascii?Q?sp+5HzwXcatkaCgpxUEjIWN3iOBvgWb6inoMnJoXz+eKTUfIwhAiL9Vy5HTR?=
 =?us-ascii?Q?J01vU/T+13ZHj3sDHhzrOwoiOzZz6M5E6JuH/0SqztSxsLqtLKsNO3ClQycl?=
 =?us-ascii?Q?ioR8DBDNCDQq9BPU1FtxSd8BkRTdDh3l2HDZ8uanvgKVEicHw8ZEr4Kr2fv9?=
 =?us-ascii?Q?QVhtIRHkVcLIP2Vw6gvjB3/KFwxjIj0pg4OW0IsEKdiDkFGjOOI4kYfGz/QB?=
 =?us-ascii?Q?OflwGkh0PSRAihB6tcOlQzvtLA+zp3tJ26nPTX3TJYzDncLKQ1QA8eZ5ocwM?=
 =?us-ascii?Q?21zcqkxVxzfyY+dHM0bK/wZluh3RmREIdGi3sGnXpnsXDe4dD0cMt10W4xsm?=
 =?us-ascii?Q?EmU7Yjy4wT66B2z8kFM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8lwqB3MHEWbyprJSR97TOs/Z7BhQCWGv1Xt+nQCuAXP8+gisTyFtumAT9ZTL?=
 =?us-ascii?Q?WBjGFUuxo6T60lqHZA200mVhsHugIRaHLcTbYJLm0GT1lLg7JWKgcIt6zcLa?=
 =?us-ascii?Q?qsS3KulO8IaCJhFzVqSdD1ksxKPbvJZsWSmJ4xNfzR8K56jHqJJsKLc4bRz4?=
 =?us-ascii?Q?nutq/Q91gIradSRpHoILDrRPSGUoORMKU2SCfge6j/BipvJIdydcq73ZsMbw?=
 =?us-ascii?Q?voOa3dfxvabCiKPYoXg1P5mW6liLNO8X5nSSxJ6Ut5ox8DK3QsxGfAB+xzwK?=
 =?us-ascii?Q?N3/pq91h7gYxjMc1aX1vKaa7JsdUMASWbII4Lro0XNiPb+zzeMY3Nt/t2Ozy?=
 =?us-ascii?Q?1b+2m7jhpokst1wxYF4V6u4HmGtfXZBXRHrzfEWvQS8jBTVK/UFIyETvzB8H?=
 =?us-ascii?Q?/OMqTsBgQJGI+SctMb8kDTlQMaq5E6xXoidfy+fe/VXwSfAZk20gWhVvbagm?=
 =?us-ascii?Q?oJiZX7uoUIFrLmfQqYK2j3U4K+ci0QuX57IfBGcwXZPmu3qvEC9qdoQsZ1kE?=
 =?us-ascii?Q?Ix/42cw6z+X81EhDY7BPdK+NlrGvElP7ea0AjnASJmo54ystNDCoI2eq3Yim?=
 =?us-ascii?Q?zBHSokumHIkjeasmG1po686HLNSBoO3AGx80irYFNWNN7PY0szS1PDpEniDY?=
 =?us-ascii?Q?X0+GscIRM5uyX5td2JcjZY3tAim5xTuO5flPC/P7dVKzsQdliJlC2Cdo+BMx?=
 =?us-ascii?Q?jrLWn15kAdDM0gxn51kjimVSlIqGz1nR6W2WLsry/TpKkoQMn6YpwpSQ4vA/?=
 =?us-ascii?Q?bipTxksnpnOmAGSdWNjeauEw6u/o/8QbLdJAO0A0O9ZFu2F+MQBFSeir4aWV?=
 =?us-ascii?Q?6zRt0N1pTRklwaHFxQwffpW1dnjvhmBBIMV9Is14TwPedqx1e+8z+tr229Dg?=
 =?us-ascii?Q?VzYmdiBQqbBuQX7PLJv75G3Qyuloed73vHifXPwTI6Retec8J3HrcDljLtK3?=
 =?us-ascii?Q?xdKddlLPMPix4htzfgBuoOoNPObsY02THBv3E4ZkW3E/OaxwcYVqNLMe7ZCz?=
 =?us-ascii?Q?qJNGHiB8bewqqlolmlJlElNco6yVQsMhErH9JCgu+Llr+lbPlVRz0hFHrnaQ?=
 =?us-ascii?Q?+s9YxVnXZY3EPSSi9QEqTCXnEjKEPJFTGHBvOvlISC2+VwNXzAF1Slh5/Pk8?=
 =?us-ascii?Q?8fY0ngH3vz0Km+MLs6pILga0wrDdpdd6AAomeuoVKV9trpXtxTDq4WsVQEcb?=
 =?us-ascii?Q?yRCGp6ccvabDL4xujLZ254CfP1hX+2uZ7Fwo09xld6FTG5IQaaOMzE0lcHIe?=
 =?us-ascii?Q?YOWYq8rYGeSJBqTwTxtFplXn01Er/Lm7bThMMBcX1Vz+5K1kHLagethVvI/v?=
 =?us-ascii?Q?ilPgbjjN7E3n2ZKh1ebQjIf/iD/gyHOLesZ6l60Jic4L/O2gbhfLfcm2cApA?=
 =?us-ascii?Q?66+BBtfeHTajdxzbPTCNpn5FhLvkOvmES/brKXEerhxRTk/wBE8VcX5zOjYQ?=
 =?us-ascii?Q?ouO7DWmpYTAyhjqIVIDXmpbLsgjQYTUNCkRQnObhOkVeCXEAKbaVsoXxQSBL?=
 =?us-ascii?Q?3VQDXm6Y0I2EabhjEzTi4uu1knIxAXhcTZSckOg6boScUvpw40cPxAEYjxGS?=
 =?us-ascii?Q?7pXppAZY/dO0T5GOuu7WAGV5FltM6RbqF5IaFZ+K9CqUsV3QHpQkWRiATxnV?=
 =?us-ascii?Q?klUQgisc7M4KaO8tRXV4P4ZGmVYIx1WxvR6CNMWv3Baax0P6WaXqrvZyxjeG?=
 =?us-ascii?Q?3hALWr5xr1bILi+xovMebS4XCSHtQlS+fIJfzbJsBXxqHTeQFRu/L+v7xWl0?=
 =?us-ascii?Q?iSfB93O+4Bcwuebg6VCxKNOO10lbrtk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92caa88a-2d96-4a26-e44e-08de6a78d118
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 20:53:47.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zi3p68rocXg7GwUQcpo8zvYFleV6RRvh0Wf58Cq6zKhQEZj2zRiv2fLxpI2eR/EPcr23zpJlaSfDTrUBzhFH4SMKlfuWGmpHWJgvhwp8tA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7645
X-OriginatorOrg: intel.com

On Tue, Feb 10, 2026 at 07:46:55PM +0800, Li Ming wrote:
> I ran CXL mock testing with next branch, I usually hit the following
> call trace.

Hi Ming,

Without a crisp reproducer, I just beat this up and it ran beyond what
it had 'before this patch'. It survived 100 --suite=cxl and 500 module
reloads.

For the series:
Tested-by: Alison Schofield <alison.schofield@intel.com>

snip
