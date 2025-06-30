Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764133F9FB
	for <linux-cxl@vger.kernel.org>; Mon, 30 Jun 2025 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315966; cv=fail; b=UnXK7yih68QDD0TPJWuAEdLeuiAiC6GmMxEiCGCTYAk3K3BKgSVL9DP2h39w5gkmja3OH3GeQPBnTnQSun4xFmdRi8t17YpBZxtriLptQA8RYnRXhv2Mxn817mvnSW6nzBncM6ehn8mOU8iT5tR/UW53/J7u07ScNpyuJ5yOnOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315966; c=relaxed/simple;
	bh=5t5FLGhud4NJ8fr/1OPECXgtaQjFlAoMbXYEyINmOEA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uss/elu79tflvESDZZx+Q5O/0j3wU3idkjbBZI5dBgDP02mD8SS0+Bh26+kJ3HKF/Td1jnK7ITj9XTeoOd9SFKI8fHYHm/ilobWU+fDaVdM1vTj0w1BfZLLTbQ9LAEDff/+obfsGQSBH49KkZjRfCHLrWww8y4+tof1WFaAYL4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aE/tGmWy; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aE/tGmWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751315965; x=1782851965;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5t5FLGhud4NJ8fr/1OPECXgtaQjFlAoMbXYEyINmOEA=;
  b=aE/tGmWy2lVnI8Zxb/gQaSzUppvVzMVfBUUqRQW7ijQWFqU9VnLx6DcR
   0OnraoWtjVp8RhCOEYXNbG5aeWaah80BsKMXHIgtHE97BsEdF+KI5Vvd0
   kRAAVJ4uW/KDYyxTLrwcf8v/3Iy8tzL9bHIjN1FNTGOgA5BEsm/0qdsV5
   BiHk0zOyuqwVNINJxEcY3wDI6ng33p8suD7MD+h9zmLw0nxTkONbTnrEV
   Z1dGknkWZ2GcEbjrkK1uhCWxMddo+bf+En+EjOTDrlX0boFMGgfP9gUI1
   in68Dx2f+bc6I5qFjlN+8HyBDCikWEQ9Ji+2kvEdg7nPwe6tB4DovfMu8
   w==;
X-CSE-ConnectionGUID: CvhB1x/USDy4QNbca2S3Pw==
X-CSE-MsgGUID: VLz0MbZQQCa1I96SuFUkOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53430112"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53430112"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 13:39:24 -0700
X-CSE-ConnectionGUID: zWOgLBg7TaauLVAjHKei3Q==
X-CSE-MsgGUID: yggMZeEzS96C6H/xGutcNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="159276900"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 13:39:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 13:39:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 13:39:23 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 13:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRNqJijKSbr5gfvg6wK9uiNtBjd63hu/Hhkb5yjRNQARP+bY+E8/LMYjf7KqA8/4U6nJC8l0LQ/LINUosPCmaiKKp7todGboV0sd2Xrbvs7Gvi6hyfqlF7QbcUuvWQoMZOMjz3kKQMO/9vKjfJyQILhXyyqseK9uKTOoD4kYOl2cvlvuSc5lF9570Ip8yVpuKHmehsTSUoXJXP0siHAGpmHZz3Mq5pawHLmNK0cXJdg+m8F2dXaklV8yLchYhbrR7y3fDOXPFRz+3eSjlNiXSocuvTUHYHoCdvE59Re7mF0eJ67YFnNtCEs6Z3JDcSInY0GE9cD8jeCKHLfjyixgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTcVI0Kxg/Hj/+JHglIZiV2nReUsUSlCYboNk0CwFw8=;
 b=nXbAI7Dlp43VNG7xqz57ZaCFghCqZnsiJkGipis3qTyxB8LQLyVnbVnbEFHSXUMvPnPaHrbCAGPn0EbEhX1yn0gAn4tnw5xoqYUqpt+kde0wYhP6uuS1WLCVh0II1ZQkHLMloXGHHhY4G48fj5NMqreI1zAmZgzieQsL2ySsUw0/76AtNy78/jd3aN2yZ//nlrptMdiUVkeaKGzn0mkNQmrYwLRif6aSDo684qPalSyAZtuciDXu4YOnPrmnTkcIokeGPU+qKrODxxwtlu6oPJlZoNJHfa5iJS9n1U13+gRdkNvNC8U/f/OHLO5oMvxraVk/aeD1Qsulxzpz7jn0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH3PPFD01EAC3BA.namprd11.prod.outlook.com (2603:10b6:518:1::d4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 30 Jun
 2025 20:39:21 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Mon, 30 Jun 2025
 20:39:21 +0000
Date: Mon, 30 Jun 2025 13:39:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/region: Add inject and clear poison by HPA
Message-ID: <aGL19pYRtEwYkXMr@aschofie-mobl2.lan>
References: <cover.1750725512.git.alison.schofield@intel.com>
 <50bd42e0db1ed5979a00e6f5a43147320a1d5b9b.1750725512.git.alison.schofield@intel.com>
 <20250624153359.00006dbe@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250624153359.00006dbe@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH3PPFD01EAC3BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a47b6c3-f9cf-4e87-8033-08ddb8163172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?smy8d6fZ1DZ6YIfkyQYfXXkEusYkJNblom1afTXJnwe6DEROGVJwoOlQufDy?=
 =?us-ascii?Q?P4ZV/o4yBA8/0AbCEgQ7JAi5MMWexuLGaCtqSFf5yLlJfajWqY7OM2kUs033?=
 =?us-ascii?Q?+wpVA2s+LHpZ6KH+wvOGeZqSExfDv+XMKxLEjhph2+WPjkCBuONmWSCbxm74?=
 =?us-ascii?Q?3VRbrz/89EFuTup+QdpsWU7yGImxXjKJKe8g7AAdyjvFlDAxb21VlUZuGk7H?=
 =?us-ascii?Q?pdyIxGke18T/US8yPSH1DTiwyx5kEDtcM4Xmcxw5udVIyf6EN71mvhv7YxI9?=
 =?us-ascii?Q?nXyywpFb3wlkYe2fsrYDTGJV3aYaCvYpUk5rPsKzEPOPaeD+nCH53s+4Kdy9?=
 =?us-ascii?Q?PwoWs9R445funZE8b9TVPStyYTZ1E+5UHx+gZpUjeSLfDeQ8Afd1wb0YOC6f?=
 =?us-ascii?Q?N7Fmd5k/CAz/rGpYyaKJtdD22kOpzVwQoyWad8CyXbbU8ey7xISKDlBzQD3w?=
 =?us-ascii?Q?VpWG0WmzQNnd1m6E39Zud6KaRcPYMFPTtgj0pW2QT1uJ2BpLZ5DJE4ynhaSu?=
 =?us-ascii?Q?K67j9iQzTHqI3judD7LPsTGnNiRsz/v5F2LHr6imygj7qEEq0UKrl5JN2XEU?=
 =?us-ascii?Q?R2QF8isCxYyuHUlZewNHnX4BE0S42pVO3HOTeJL5Tcg+RaPoRRi130N4vjNm?=
 =?us-ascii?Q?UnOGN1bilQ18fPMeN/FQ+Mi098Js8RuMaGFWubL5AJsHXCWImDRplpBTt2uO?=
 =?us-ascii?Q?kdJnZ3K5CV5eq2VaDAZUWtS3mZ0tUnY7f7IkRZryKXdMvA/J454TVqY2f2L5?=
 =?us-ascii?Q?vG7S+/X2jn4Ifs7Ej03db1ssMKe8daIfj4Jf2jd4ZhAIKVeYIRtsXXbDoUvg?=
 =?us-ascii?Q?o+rl1ZYBynPlxlJDmjbIue2idY/GjFPg63+JsjwVZoai17HNnH99YdndLVAj?=
 =?us-ascii?Q?/fM1RKaxQi+K4NpJ2pywTdPkhwyRUfGjz6+yhIZBj20G4kHLf+FTFA35hoP+?=
 =?us-ascii?Q?gj5CbpWxtaSDBlhGChtKoqgpwV/NhRcwfYOlIB6hGOc7ht9GkFvBMzbXPLgZ?=
 =?us-ascii?Q?+O2Dfc8Zj6zug6Be+TdHgjq8eMyZSQLAfhfqoheEdD24WgmDoxC/ks4jXH6s?=
 =?us-ascii?Q?Sg8nG3nm82FSlPYR4K5+ZHJ+7xDTs2Ly4y3nAg81mZRdSS74ogcahyoejw8v?=
 =?us-ascii?Q?xAEIc8Z6TDoS99NWewrZXeEmV9eifZWDvEhb9Weryiqdu5zHUVOe9/1HA9Gf?=
 =?us-ascii?Q?W+dPUmuqYLnLUesGN7erTAggNrQf2ZzKZuLocd4MethfiMlipdOyuBxR4fy7?=
 =?us-ascii?Q?A9erFi4bPedn1jhNLJjRrWbGlWfA1V4kJGzUQ1IMV04DRlesGvmxafutujZj?=
 =?us-ascii?Q?yG8nM9YbrmOuCEbrgmFJTcFJvyt4uJW0np8KqPkI6wOEMpR+Y0YWsGZzoYTO?=
 =?us-ascii?Q?y+P23OvMqZ79A7frz9BSAJC8FEBtimqiPQ+ENFyOlCo5fig1OY1R2dLl7V+o?=
 =?us-ascii?Q?8t+Bc/2ZQzE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WBA5wZj1YwvZc9wfpclCCjQjRpem1I0caNZaeZHm1gI+rG/P8hEBZqTW04IP?=
 =?us-ascii?Q?YwEDxIdfapP2TZu9Ktw7cBhFbjnvZr8ykw/+dLissZuf5DDxhvYO9UoTn8KS?=
 =?us-ascii?Q?g/P24Z4s0DDva67bquLmmb+sjIzgOxOCjte2mJoqAVn/+rNGF1EboHUz+tMJ?=
 =?us-ascii?Q?vFqxhHqpS+MnW79Ivo6oMp1fkkvbKyqqd1KjdgRmby0XpBhyKWCS9TXRO20N?=
 =?us-ascii?Q?jAvX9BpTUNJATQq+r/9fDbQLpxNFccZ14UPtZVKqwcPnc7KkpAtcDnytY0AJ?=
 =?us-ascii?Q?zyawpNqt05Z5LqlvA45l/4zoQg/IuF7Ua9OZJoHL51MOzBoeu5wBv5JpJq8N?=
 =?us-ascii?Q?DSjsN+IqNexI/LFLPCf+pb/KL5DcDPOaGYa9eU8JfHbmv7RQ4Zo41MrjqckF?=
 =?us-ascii?Q?fA6SVyjpEGgAoESViEYO5x0z9ZMJrIu7fIe+EtPDZmxQsyknEvZUDT1FqvbH?=
 =?us-ascii?Q?JUMKjCWLdtLACAq2iiqU8lH+SDDjO8Otnm2LAvgFqzuSPWI+UrEdHpYXCdm8?=
 =?us-ascii?Q?484EbcfuY76mqhPO6s+bPqL7RHcxGhmpoVXa0dYqSdCclA2GU/x0Uq3H46/1?=
 =?us-ascii?Q?H9gHP2vXbGXsNlyaBVQLWsepf33uAtOdECqCwRllPmYDsNcv/VDLqDESrcEp?=
 =?us-ascii?Q?lsQaDlNB4CQeBhq+9Vm0ldI5SGJwk67u8K0HKtj7SxEmngD9G9mifXO34g82?=
 =?us-ascii?Q?h8eF9JGP2SXYYkgfspF9cDR6vQxBAXH/nYzM7FLZS/Ozb1vhyn4o9joUXHR6?=
 =?us-ascii?Q?tM/4wtxIM1aDLxKU5dFzYTZOAJ7ad0ZXopr0mcheFSnLoQ3qI5ZkRdvnX/OZ?=
 =?us-ascii?Q?q9/1zN4uqVTPNJDcAKblKssJHIIgZxqVfsScYdrA+jlEfHutfO/ybpTUmm9Q?=
 =?us-ascii?Q?ymg1v3gYIUvY42R6/GTLLfkp3KQ00p7eJZazxkgdVo0JvQZ9lvoud/ZBNz+Z?=
 =?us-ascii?Q?4iaot4pIU2MaRC2FEOIJMGNyfaTJT/hiZoP3SiWkO2Q12uEVJlOltzJ+vTqD?=
 =?us-ascii?Q?+QuhVZAlvEYOwJh6QQgemTt5a+AqwGL3BOjE4uRb/2enZPUWbCNXNBC0l1Eo?=
 =?us-ascii?Q?5KlPRCdeyuoDYk1cSr+yQEU6jOzlgdN/PvcGrzWBsQ2He33AhybQtQz40TmE?=
 =?us-ascii?Q?ZvRMUuAJzIroS2wXtXK6TWqQPUHYIZak1LJUVUbIXDa5tYFP+4r/U1SyDTaf?=
 =?us-ascii?Q?9EY5y+inu0h8x8h4+f1R8P9wzTj3s+TtrHW9UOKRIB1ALMv6t12hEZXR92oh?=
 =?us-ascii?Q?HkqUiospKiGKqL6jLR1rhV8JlR6ErX5Y6RgxiWr5XROa1Simt9Q/MZmdaJ1O?=
 =?us-ascii?Q?eRepAsHolBUZvsU6q7TUT+nbo21sAc0SDQhBzKwdBu50OZNbFIkfle3qVAsi?=
 =?us-ascii?Q?0H2P8TtiwAftPVLgPCEhRy7uYV8TFlrASgZLK2ruU9Cw3UNw5BWJN1UmFjN5?=
 =?us-ascii?Q?/giKv8ae7NiDReSDQxBrs6zpfhvsaH9B4Du8l2ZcuWoDHED38fsMdQGfVfjv?=
 =?us-ascii?Q?NEhAzg1apDn/RAdB4J1xVcxJ0hbJJTXcm9zZp4AcL6JbGURiASbzOHnjzf9L?=
 =?us-ascii?Q?jQGfr03HZ2Ud3SfUWb9Wcp3THrQoD2Z9nwxu+olOjUc21uC0ngYNqbHmWiEa?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a47b6c3-f9cf-4e87-8033-08ddb8163172
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 20:39:21.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOaNb86RdPK9JICKvC/0WQ+FhUav6F3rczKWJ6rt+/nJahDRXxC6kcEh60LgLu2OTv3kWYW74QsAZ1z70KfS9tSUdALris9CBItiIZMpKXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD01EAC3BA
X-OriginatorOrg: intel.com

On Tue, Jun 24, 2025 at 03:33:59PM +0100, Jonathan Cameron wrote:
> On Mon, 23 Jun 2025 17:53:36 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 

snip

> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +
> > +	if (test_bit(cmd, mds->poison.enabled_cmds))
> > +		return true;
> > +
> > +	return false;
> 
> 	return test_bit(cmd, ...);
> 

Done.


> > +
> > +	rc = down_read_interruptible(&cxl_region_rwsem);
> 
> This can use the new shiny ACQUIRE() tool letting us do
> early returns and generally making it more readable.

Done.

snip
> >  
> > +	/* Create poison attributes if all memdevs support the capabilities */
> > +	for (int i = 0; i < p->nr_targets; i++) {
> > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +
> > +		if (!cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_INJECT) ||
> > +		    !cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_CLEAR)) {
> > +			poison_supported = false;
> You could drop i out of the loop and simply use the early break to detect
> that a match occurred.
> 
> 	if (i < p->nr_targets) {
> 		struct dentry *dentry;
> 
> but maybe that's a bit too subtle.  I don't mind having a variable for this.

Left it as is. (I have gotten similar feedback on this pattern
elsewhere, but here I really like the clarity of it.)


