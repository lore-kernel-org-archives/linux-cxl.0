Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF24207A03;
	Thu,  6 Mar 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295244; cv=fail; b=QORtYujivgzhS1tzYEU+Mjl1+GmsJbGBb9iuGLh4nTNfxA7oGHyPWarSWpsuDJYUr2zurm1joJcCxmROrgRK6XALFrqsA1tv5y1wpYiq14nOJc7Xw3L39RyN+vXulgzj/BsP4N7IlgvKRhm4lWU7QS33/Zdbo9zrlQsIH3LMPm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295244; c=relaxed/simple;
	bh=k/rClhCJARta9mdHkkHsROt62genFkpTRjVvGhWZyas=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jMB+PYa4vMNGEuch9c16KfhS3Gtq+MNkMiuT1E64f7Ur8kWtPXxLF93fdVC1gRoNWbnXD+KOwGWZgJvFev1d0LnRu/fdnLf+Hi4oUTvYn8N6dlyH9DqUXtRM8FtsbMxbZwp1JUICSbCGjf0gcFqzgNWCIEhxfGaAUpORz0VvClM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtVZtq8L; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtVZtq8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741295243; x=1772831243;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k/rClhCJARta9mdHkkHsROt62genFkpTRjVvGhWZyas=;
  b=VtVZtq8Ll+8I2h1EnAcSDILJmWezfllcILk0R6Lxj1/k0w/Q4Bw5X3mi
   GiCos5jluh/yEZlj+mk0SJ7VakZOtuIf3wlX4vlhGYeCYpHUrooDZd9u6
   ev7tNubD3VyLyll+RHzT3QIsg6ZVQCMwTOYwLXsxtmZOCydsilUbBdGV7
   SWEzKMa5Y+Lwh22JoqEMIVJ1XcIgUAxVouiX1Xwtgpqsi85v4np07Q0yA
   kjbfHNlisnlikeoELFAXODEpAvtZxeWL7uwnmitKu6ltn8GXNRn0QWqwI
   JMBHeiRXYRm5giHjy7a9Z7zaQlPxN4GSfdHzGoBP5BKUr9mTju3StKBOW
   g==;
X-CSE-ConnectionGUID: RXOokEK9SxeKNX0BPGNQeA==
X-CSE-MsgGUID: 29wawfWnSwyarVH2gnD6aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46102647"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="46102647"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:07:13 -0800
X-CSE-ConnectionGUID: ruWrgEKyQ2CD8cBsU559cQ==
X-CSE-MsgGUID: iHYigo8yQg23TbkP/j2HHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="123733681"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 13:07:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 13:07:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 13:07:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 13:07:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dM6oqKBx5Otr1xOnpfva/ZlsUE0Onb2mN6tgFGg/YX8vK37b58Iw5199F9zzJKBCoiyeyeri5knzCDPflcEXV8zyp7Qk4wAoV5fIFTZz46zo4U7fV/PtnU0/He2+CbK8zAfWTiJP0pW+5I2SVnQIsIV6i4j50KiRFGM7qM44rJuNUmLPd7iVDnSjhk2eaYUXTf86M/wImM3jgwJH/Qa/b1qlW/6JrySG6aK/mu3mhknbSsNW2z7pOCsEkc6lHCGR7kUowuqqcwylGWO1y17fsYFgygair86Mo4t0c6Ultm5PpF0ixh4ynKOArjBzDY9fVYik6MWKUK5P1LYFrEqGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI0kxF/h+Z+0CRuSVY2KASi7ZS8wwAhhfcQa5rLnP1s=;
 b=xSVFJm2cAfh9S7BzeijmLyH8X4hAEoYaqhmlldYAZspXB66BMv+x4DKECTaJ1N0AdnThVPzwseR+YPGKLw/hrlmvLeCX1PKMxu87frWiActRXukpPHcJ6DaPgtBh137MNjMMLXkXmijfYBGu0vqrl2wkzXif9/0+6E6gV0gWFecy5W5RQV9awN91G+44bhhx2swXKr+kvu4UZBtEGLQ5P4MEaWbUd5FcFWsLkUkdAo81/wOV/Fga2dri+Fa/Baej2rdx4u71m1tv6W/5FufLB++OJBxTjxTVAv9MSQnDGJcHoP68kTkj1/GhotqKGWQNBIMUDufdQJqcpjr5NAw93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 21:06:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:06:23 +0000
Date: Thu, 6 Mar 2025 13:06:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 13/14] cxl: Add a dev_dbg() when a decoder was added
 to a port
Message-ID: <67ca0e4cd6aed_1a772945f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-14-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-14-rrichter@amd.com>
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 062fda91-2183-4252-e381-08dd5cf2c02a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ww2fydXQh7cH7lB6WGfZfrUwzndwKSZwbFqPcqiXV/gj5UdC0QuvjbtzqGH+?=
 =?us-ascii?Q?e3t8/7JZTLhnfBdVv9B4twO+JVVMPb7tmGQDKQHyo5AnmlQ5C6x8XlNoto0q?=
 =?us-ascii?Q?xRnmw0RQ8UP3izOWFguazU23ozgjCUt6W5Q6tieZ18wHhdwyHMpx6E9A/Nw7?=
 =?us-ascii?Q?95ctt8pqXL45mEks/y+dNI/07P8yDeflDLljRro6nWmJ6nAUpefrtNhRR718?=
 =?us-ascii?Q?FQD38hPD2kCf7vbKUmGmtJ0ubENxNalaeiaT04muBMV+HwFBO9Y4J8aGWpem?=
 =?us-ascii?Q?pat08+r64keJaZWTXVB+guOuOarjqBuLCPJ0jtLK+BL3nLFVl6T1lNkB1XR0?=
 =?us-ascii?Q?yKff2CllPmI2lyjniGv5UozNa7fXmG8DBm0Dlvggo3JdtkMz9W5Juw7+CBJq?=
 =?us-ascii?Q?XkjXqD2JBeyeop0c3VizA/rpGVdHs0qFLiFx4f+pMWTjhSx+Re8XdCgeyL5h?=
 =?us-ascii?Q?HHcD/hSkAc2zrPwlalhoG+VjfVjPUCkRYhQXuk7mravuqwJdPe5h8Q5QUJgk?=
 =?us-ascii?Q?AVYGIrEa4l3/zWqbaKb7Lu0ogejQUxlNTvuS/xLtPxDpSEak1v9JFfOcPSsL?=
 =?us-ascii?Q?ZNK4XoFXiQ7mmruwoS9COWQKiddxP4TlUVqdZJbwavdskOEmvuL8KFK900R6?=
 =?us-ascii?Q?wvPDrlMg9PZi0yoJ+LwKM8NpF1OGK3kTyxOPGWImOoPxwKTdS4LAe+Hdrhi8?=
 =?us-ascii?Q?QNz6wvcArbzeSFsNR2pgpjCgp3wqOcfciFzTj+j9gC7y4nIO+oK3PE/y6vCQ?=
 =?us-ascii?Q?wW65vb4AgDrBdZkl9UGlWWpCuNDjR/5q7gwRTgEWINwW3qwsHclN66yXHcMs?=
 =?us-ascii?Q?zsJlU1R+XRo6qsAmD9BEj9qPrp7PmRx2AwPti+ZCIqBmL4GYAkyv3YFWoXmb?=
 =?us-ascii?Q?DQZxCwO30eCofjYegij7zswZnk+7AfGb85ZPPPv/4kRhw2k5Zv1ysRH8dMC6?=
 =?us-ascii?Q?EYuNhbvFO5y92OYahmxPy1Y9sbsLlrmqoQ7obwGlXAHOLxVD4qSLIYQoLKf2?=
 =?us-ascii?Q?NFA0z9fmcW9TSIRPSOgKBBSQk5PLLTMshQrCPlB/tcEgDJlqbQW43pi48hAw?=
 =?us-ascii?Q?/W3DpX+1BWpLY/c9WF0jeY8plUUVnyn9v3YsMu5dyEGGF3+q2FSImvEBIXce?=
 =?us-ascii?Q?jzI6E+f4BbiIrX7g2SVXfGYsR3fdUdM+l5tCseFS/LBIaX4NmJHVDgqZehHF?=
 =?us-ascii?Q?rS6dZvd78x1W/HBp8i5rEsKmY8+7rpVEFaZDjg0jNsQcqOZco/DcLPdyvhSs?=
 =?us-ascii?Q?jmKEq0IevxKweVNlZip/XhN/n0TvVuHzJbBo0ptkmIfByqOR9xtjAzC83ncZ?=
 =?us-ascii?Q?aKmvVjSw3IkQ099LZv+izfapmWceIocuuBK3+6yUAPolKmiLzUI2zJtfLp5U?=
 =?us-ascii?Q?YJZQkJkZ90DWLSniCKSskm9Nuhdy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8hAhBqvLYMw/8XWKA37PKVrh+KRAXFyX0tv+yQwIjcIFASye4KYvkihpW4hj?=
 =?us-ascii?Q?ufVteFZ0IUsklFbpFjBTueXYVo06crXnK7SBZzW4ctTMiAQh0gw+DZZpH541?=
 =?us-ascii?Q?rbgOThV5U4I2SfZN+QNaPvGkzjTja7roEgCmbKdsc/wf7Wv3MMB10CWI6PvO?=
 =?us-ascii?Q?LrhvC1ZrGwGgkkv/QeMMYE0VouO3+ab23K4nZ4Y4t9J/5eAUjfQ8x/LlIpNC?=
 =?us-ascii?Q?xNMd/fwICA+iPWLoXSXZ+AgGm+cXsLJXPKOf5YmaJGg+d2+jXngkwSWDbNfj?=
 =?us-ascii?Q?VkQJ2zsnuAORLK7wnvPFByildQDsh8YbveMPMIVfLdLRQtYq4G8Ta4MGjv7g?=
 =?us-ascii?Q?s0aQrp0vjHkyo55dTh5MRdIeOeLkSvxdh/E1k8ojkNnCSR/7AKHjQHp+9ssu?=
 =?us-ascii?Q?3qIUQMxQk9+HKffMt7pxoabDd4Qs7EsEIbOd6Tn3KnV3S8UuRbDAHtY/Gkrk?=
 =?us-ascii?Q?0pmWK2JCEXn3VQd25aDRGWzUj1JFKcJNxSRMgzjkccHAW6M5tB38U7uY5tPT?=
 =?us-ascii?Q?JctQ6Qgn458zO+JKa2mhrUzihVaOuzBN14a2N/r1Pb7/krIH6xhu6HNZ21ru?=
 =?us-ascii?Q?gHzHO2bHo5RNeUVwY/ElJ2fI4ESWPk6tPje+kHoN7GPLE7FjDQKFtjwW+yuE?=
 =?us-ascii?Q?kuKUCdnlDLxN+fSC3Un2XdA0kA2O75QwuiiGYAdAQ18A2DsDG1bbrT8w2SQa?=
 =?us-ascii?Q?rv/IJLFPl4t9Q1WsqBqPh2L01v9reAbgdkVWrvMWR/idN81OLiZkaQmGQtj4?=
 =?us-ascii?Q?sCz49KkSZP9sHn9ZV6OKVVjiRpsJ+P9OfnZPWsuXHbxu2IAz43Q/NcQL/iZQ?=
 =?us-ascii?Q?LFKJCMPO5msy9P1tOb1M9pCeBgSnnNBe+/rDjWwB7uO5SKzNofqjZjJOoMjg?=
 =?us-ascii?Q?snwnju8e4LP83di69IdL98I2z+RS3q7uVcJzUmUj7nDGarm/4olcaxLbpg6g?=
 =?us-ascii?Q?0WHJmF1uDwPAjvIdRvbY+VpSqaGDc8sHoSfaVYIXA0ccy54IyQAl1N6KCXIO?=
 =?us-ascii?Q?G9wXdpFSKlXHZtAw6hw7RnW9sy573+uyJYGw0Cc9ayyZnMhtDrhrjNXOoKZ/?=
 =?us-ascii?Q?NimjNl8EnCyuOAPdFUk+N6egyM2uPiuInW+P83nWGttVjfc35ORi7MjUd6t4?=
 =?us-ascii?Q?Eong4h/z7WXSnGld1hdpKEr/Pm7eZws7xqgJbr+v0Z6FV6hQhxjZF1b2ZO7L?=
 =?us-ascii?Q?8v9BAcLSYWr3zeKp2B/pGcG3vkLlEXPgW74L4R/9axs3NvlMB0Cw7WYpUWs2?=
 =?us-ascii?Q?dv8v6eVNdcdLLX5riF+05KRNMXDTAE++DGy3OLR8jxaW12P82pzqhMNXEIuZ?=
 =?us-ascii?Q?LPvRvQK+oGTJhWotlOxpBGvtDD4I3zL/py/hQxLeP81/3fStNbQuRbpSc4f+?=
 =?us-ascii?Q?UIyWMKyft+bZPls4Ft9tcHT4Hn6C/RPz+0LzPDxNsj3OqWiqEONdfJFRAvaI?=
 =?us-ascii?Q?+8bLqiYxCWvDsO698ojZ0qPN4rR8WglWUwXUFB3MA1+0BuWIztP20sMDt6Qq?=
 =?us-ascii?Q?Adm0JIBBASCJp7ix9zXF6EPlgA1kO1IM0hnrHJczfyFfct6duSGL/sx8Nr8L?=
 =?us-ascii?Q?m0QLND9yrrRbzrpqmGSqvnZwqayJxX2WcwjzUpYiQ9bhjts+LZCNlMGL2rET?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 062fda91-2183-4252-e381-08dd5cf2c02a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:06:23.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4IltHZQeqKbSeftGtppo3ZkVvD+qGTOeUecdk/kbPVqtHr00wQVuQjDLc9qNfk6e8vCAU3nViF5r/fMt9kKlK9Q1yxwXaChvxrex3GTVkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Improve debugging by adding and unifying messages whenever a decoder
> was added to a port. It is especially useful to get the decoder
> mapping of the involved CXL host bridge or PCI device. This avoids a
> complex lookup of the decoder/port/device mappings in sysfs.

I am not opposed to this debug statement, but I hope that most use cases
for associating objects are handled by tooling and we don't need to keep
extending kernel debug statements for these queries.

E.g.: show all the decoders and targets of port1

# cxl list -PT -p 1 -Di
[
  {
    "port":"port1",
    "host":"pci0000:34",
    "depth":1,
    "decoders_committed":0,
    "nr_dports":1,
    "dports":[
      {
        "dport":"0000:34:00.0",
        "id":0
      }
    ],
    "decoders:port1":[
      {
        "decoder":"decoder2.0",
        "interleave_ways":1,
        "state":"disabled"
      },
      {
        "decoder":"decoder2.1",
        "interleave_ways":1,
        "state":"disabled"
      },
      {
        "decoder":"decoder2.2",
        "interleave_ways":1,
        "state":"disabled"
      },
      {
        "decoder":"decoder2.3",
        "interleave_ways":1,
        "state":"disabled"
      },
      {
        "decoder":"decoder1.0",
        "interleave_ways":1,
        "state":"disabled",
        "nr_targets":1,
        "targets":[
          {
            "target":"0000:34:00.0",
            "position":0,
            "id":0
          }
        ]
      }
    ]
  }
]
