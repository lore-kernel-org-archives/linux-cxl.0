Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E74133987;
	Thu, 27 Mar 2025 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743047071; cv=fail; b=EWde42+yVpN4XjMAfbzst52eyfCj5bQ/yaavjOjN9PbvsPke1a2aetvRBx7lPf8KqutaanP5xKJ4m7Jvqfnb9dztpc5DCLJ30W2ipN7bFzGKSKxe483B1IirVuEYC1MUfx3nr8Tiuk4Vy7IzrVg+47z74K1B1otm3JyCfELaus8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743047071; c=relaxed/simple;
	bh=6mue6xMDWD3QqpLm5YzlEpyRyUTHfUIPs8S+SdS5VAM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S74k6Blb/JfOLCA9W0ThXp9QjF0elnriE6SFO1en3QssmgXGRj1fH30HPX2MOptWTeHb1hdNq0SYruAs/4pC/YZgtBVieSKcox32fscF4VXwGZLamLf0h1EC9n9zR/e6zwa/quAO+mQnE7ET5HVVElxKIPriFufppAg1ZNQEddw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQSJOV1s; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQSJOV1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743047069; x=1774583069;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6mue6xMDWD3QqpLm5YzlEpyRyUTHfUIPs8S+SdS5VAM=;
  b=OQSJOV1sZU7U5wI1jHWMP600I3sqvwHp4c96G9SlW+kmawM5vJTncXPl
   a3Nc+DAFhyJgeDQDWHOOKZJwOVj6Ch8NGpTa9vSqx2LymfOcKxXamp164
   /yOSBc0RlHs+hiFjnpNKFPEW142gvwFKhftR6nfrMHtK6v9mksotBOWur
   NACLsotkwdT6DurQ2lPJB0rmw8mi8AdDg0DCw4C4hEk7u7RBarp0KJWJo
   FwvMI8ZXXV/MijpCr2iP85P60OLsfWokfof4KbbkQpyfgUYwcKPqqVPay
   v+RURorTUbGHVMdNN8ogppj5VJrl2mcFVwmeUlo/PzgNuMrlovgROLNHA
   w==;
X-CSE-ConnectionGUID: HJ3ysrTuQMWfUqnoJxktLw==
X-CSE-MsgGUID: EsZMg8knQ5SRS4UMKJXBsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="31964681"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="31964681"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 20:44:28 -0700
X-CSE-ConnectionGUID: FxW8Qnw4RIe+WoAijt/s3g==
X-CSE-MsgGUID: M46hMrO0T9SRT0+uGFvcbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="125209988"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 20:44:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 20:44:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 20:44:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 20:44:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFi1baZt6qmpIC0VHZ2sYywc8vWQhBEvTqti/OFSAL9qrBHYJPRYFUkEDA3ZTqo3f8waobsv2qDVw/7SuQPzLZIrJ9xtHIXpKZTx05GlXR8c8ROHSVcTl+w8i9g9AkvTTMolcMbRjJrXRMIr2Xj8HEcNoNLPwk8DXcpGAPzv8AwS51qVqu/NLWtyhjUXYvZZcqqymyoGSFyZzOzKdDzCXgG9TO/moBIwIrH9YnOF34eonPfHWUT53SW2ZtKDzinfxFtZKLIJWvp/Ccc2DGGl2frsZg0fE4yRCHEpdL4UxjiiH+QD13a0oXEyhCsPPInWCRnVUJ2Xn8tlVG/blyxL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7v69DyZ82et4+9sFoAWQ+/6BmADyqBmddGn/wJY16/w=;
 b=L+q3Tfiq73dv+bgMPzc2qDTNJ8VLKvD90n3cd0BnN9DVv2Z0ngycHkQ0OnAxTteLJCQTCTcRAof2gOPIlvMPo7ffeXJb9FIx5oeh/WGvWNiEr8OGDm9CwMYObyxUDZ79f/9AczhvvN58/D+Qyqr1F9k/D1Belh5HtSQkuoqKilkq1YpQ+tfRnxMcRtoJd577XLUDQ6dantszsebk9d1PprJJKcdmBFQNS1QTtRjrY1jClR3jOmPDG76+p99pA6J05cEmGfrJO1fMUEYwrnh5ye5B9ktCSGbAC/GpUrQDHN/ZM63tgmJ284TqC4IDhhFVyCdQIMZMJGW/d1huEu4OXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 03:44:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 03:44:25 +0000
Date: Wed, 26 Mar 2025 22:44:42 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	"Li Zhijian" <lizhijian@fujitsu.com>
Subject: Re: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Message-ID: <67e4c9aaedd08_138d3294ca@iweiny-mobl.notmuch>
References: <20250326074450.937819-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250326074450.937819-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: d923831f-b64e-4b57-20b8-08dd6ce1ab3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ewS9aBm9LBaYYPNZXZK87lAE7YmmcbaBZZM77Vx92bYhW2ipa0QFvuOG2Mp?=
 =?us-ascii?Q?GrZpDYxi4yAbXvZnRC8bCzy2sNrSXf4Y5+wl3wJ8SsNB8zy+u5xuEuRdqoT9?=
 =?us-ascii?Q?InPNDlwPSOt6Z3v8H+buwa92GB5iywItm6yH88HpF2STCjJL+gniW0TKRoMr?=
 =?us-ascii?Q?vqmPRWljrCQcq7uQbt5hndW+s2f3aA1ePvw+Az0Bvd2WyzczGx8Q2+LCOW4h?=
 =?us-ascii?Q?aWk3ANWAl/KZixBULxwUBZbTAoG4UELzRJaByA5n0WO5Ne86y8ysonOpKrxX?=
 =?us-ascii?Q?Tw5H8my3z7TGYbNt7rgkhXtUVHj5Nt4bdTtD8UTVo28TasxnqFvBj19MMWy8?=
 =?us-ascii?Q?jMrFUlSnQXgHJVvLuIlXq86wqi04XE7OtsCQWQEy39T6dR5NNk6UhMdTrkzN?=
 =?us-ascii?Q?2pS6/Xmip7eTiMgQc13n1S3E+pGr3CmkjyjTr5O0vAbs1cDmhmOXC68+CTez?=
 =?us-ascii?Q?E05iwqkqAkdIlN7HSgryQ9HoYbK8O1wqPgD5d8D9pT/Soul3QdyM65h7xNWF?=
 =?us-ascii?Q?h3SzYmgmA3iexm2lweVmDiWIYbDPc1J6sOclZWwML54hXhQsetfdZ2nh3sC4?=
 =?us-ascii?Q?AC//xesjOEgkKHmkteEW1ci93Hgzp+Md6R7s+VIvvEGQdyo7qvAv3peN6JhS?=
 =?us-ascii?Q?Y7tqbBPxaCEzfsQdQdIkFbBjlTZRwJbd9FdG2trlSbdeXaRJQH28DokOUTmX?=
 =?us-ascii?Q?ts8+6u7ZYmerj7kEn/bMuoMBJelKF+iP9TvzmIQtu+vzPmguDhJp/2mrSniD?=
 =?us-ascii?Q?r/M1/He2B9rUKghhW6lcUYgjZAp5VKPzUQP57vSBpuDq6fKQ0Rlukr1VYUlP?=
 =?us-ascii?Q?zIz6ohEE5zLJPT+v3aFlk47avKiVAQXS7F/ujrRf0LGNq8sLakpWKK4Bkwj/?=
 =?us-ascii?Q?pnK0ZNWGWBQOqWUjfxOIwKeuU7R4l1guxljZUWZL7pC0WiizmQTLN4yXhBYD?=
 =?us-ascii?Q?35Ft4o1VMBJJL6d3iqPGnhehrr/Yx1Xvv6KssdvQhhGvZFVI536q/mUcPjEp?=
 =?us-ascii?Q?/09K5PvGtZ6Q2unZeWA16wpICXj2AuePWCkqBKJ3U1jh5eNPLGitcR9sfdo7?=
 =?us-ascii?Q?T3Gnr+NzuzePtUwn+bztc8ijGAOcAJwvys8bnWDFaFC+4jL2uM3nGR2zthmF?=
 =?us-ascii?Q?cvCXNU6lsS9BMaLXr2L5P9ULQyZR/b9QgSCOBGg61WLFBmpumMkrkmHEp4Bb?=
 =?us-ascii?Q?VnRoCcp/Qj34517tKYapA8xstD4GBPHP/Jp0fF9/+d65nQKH9UiyxB1n+DEZ?=
 =?us-ascii?Q?ZwEJY5oxLkTY0gk79KOUtYSoVMxsOU58PqHOIQaz7L3Cay4UijkbQmBWLx88?=
 =?us-ascii?Q?TBFG949BP4cyTMmHeyosD+oilbNnuC3T6thf1dWFDLX++A3/9KXhgfuChA/i?=
 =?us-ascii?Q?UiNKlcquOAQqwLsXS43dbP2xvYBh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQ1O8+bKEUixQXNEnfxcnb7amv7CPCWWP8kR2b/km4hwoeKQsescFj5ZijTY?=
 =?us-ascii?Q?4VlE4nqtgQ48jBegiEDf9aPWIjqcIIaTd3Td8kOfOdDqL6pTMPLywc3OLL5c?=
 =?us-ascii?Q?U++/ckEIH3CkcN7+tNH4rU5ZofOXsuYLr+3QG69k992ZPVHLGkYmF5T+qow5?=
 =?us-ascii?Q?0bPzeInXaSu9PFHPH0arWhjgbJeCq8+U2+juA7OlmXIdZXzBHfOYdRqDk8Xe?=
 =?us-ascii?Q?T26CEdIikdwgK4jIIrW9ENWCjUksuMPXeH9BIqZdnP3NMVv4F8XfIc1P53rj?=
 =?us-ascii?Q?AGYl4foPTdh1OetQk0rHrBg4r/WqHlhT45SQdGnJFsaAqNkENO1DgZtFcap9?=
 =?us-ascii?Q?U78Sn3UvjPff4B6QISahMJ45KgkfryaIo9YMtVdZ9nlcJ5BjybgzriUMDjRc?=
 =?us-ascii?Q?h3z74IFKJhZYW7cf0AmNvgC+nU/1/jyAM4idGJSGj8EAJDpihvOsbFitJ3r5?=
 =?us-ascii?Q?v1KNzvooUbrDV+8J9WUpsKfkr5iucz/+MeG74p5550GAq7cSzOqGd3Fh+9mq?=
 =?us-ascii?Q?IzDj3FXQEhdtiu5B5uHBCRMWqFfjqeKC+jCubRr6JxbIiRS+LowBg9RRmibN?=
 =?us-ascii?Q?TyLeb5hs4A+QnnoM/iKL/3EJPM1vRSoVa7idj6+26c8LDlpJRwmnq1ROnJmX?=
 =?us-ascii?Q?hA9AEiddPJ5r70FaHParga4dUaoWUQnsrWUvn6WpwCCueadlMaXFA9/8+0aT?=
 =?us-ascii?Q?qHAy80PCnJMmXyN3RSJujzb/zFfdbI9OtfDiiAXYJB3OwH2vdpsaeoz01kpL?=
 =?us-ascii?Q?7wim6sZX3NknSA7Bws91gQSkG2yaXYOXYnSnmFdDzvLQKvd46BUI8ogk6PfA?=
 =?us-ascii?Q?OwoNr4X7f16tDb6QMqLVVSjEyUegxY/6ZzC7bzLKX+J83V2VAY+WKftxmMBs?=
 =?us-ascii?Q?3O80SlubsZAzoWN/jPSdmCF3j3mKFCzCf3Tv+CEbD2PeFTSaklEDE/P5ZdMP?=
 =?us-ascii?Q?HzgN0U78ZIf7yc9EpNTcEFFW9TMd198y64AXONzNaZegeZUXVQF48514+TEs?=
 =?us-ascii?Q?CPUJkLLGW/TLOo6YuW9UJ6VjRamJwhZoIf2kok4w7uxZtKKbGGU9htv2zXBW?=
 =?us-ascii?Q?tpc+/Mppf3p+/8x91b3AwjfY2dIA6zO4Uh4VYJ4vgXgKqfXm24/9MXAQOn31?=
 =?us-ascii?Q?25DSFQ/0ovgCV9341Xl3kW/u6mOoJhFhb1/Vg/o9SgU8x2E/Uk1rJsFhrfv9?=
 =?us-ascii?Q?fMoYF+hx/+I8naxPNfN+5bUjrdX+f1F+qBzPKzDBtTkEiYuCh8Y1v+/b4+Jk?=
 =?us-ascii?Q?SWfkLpIvSUtHBYwdOmXJ/jWbk8bxwK9pFadHLUknBYV4vcsPFu5JdHt/g+rC?=
 =?us-ascii?Q?c3YteYQKSBUFH+49+qbqiE9EdfU5afQpltAe9h2aUbGI9ASy0LDUsC4T1rPq?=
 =?us-ascii?Q?tU59DTxXWDHaiBccNh0uXtbfA/eUvc16MIt+FztxNZV5IxW8FIGpHZz3a6Gr?=
 =?us-ascii?Q?4plnhosMN91n3jvVXYWHH+xXaen7l1FAa/0QLsyc82lK0WFCLJTiOwxjftUj?=
 =?us-ascii?Q?WWKahs9hSg52A60yzJ91Js8Pur7X8sXZKsshRH3CpYSWw+suX3/GmDRySUAV?=
 =?us-ascii?Q?HdZn/iXJEstdNDXuRdqiySunKPRIYw+qXzzYOImP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d923831f-b64e-4b57-20b8-08dd6ce1ab3e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 03:44:25.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eZECoRc/wQEWOGtkV8CODChPP++8RBfLLgKYj25P/kNYxaCF4zZMJc9F7im4kMx3YBy+47D6GuE/Tx6oDhBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com

Li Zhijian wrote:
> Per CXL Spec r3.1 Table 9-21, both CXL1.1 and CXL2.0 have defined their
> own length, verify it to avoid an invalid CHBS


I think this looks fine.  But did a platform have issues with this?  Does
this need to be backported?

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
