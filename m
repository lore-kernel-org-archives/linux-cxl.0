Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1C1EA80
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jul 2024 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720485768; cv=fail; b=JF0SkzNzf7edaE6RxtFLz1U+cNo6E62s6JuqsfEMfU6eljDLRBF2uWZpAdPSi+jPEjni9rx/4RWOjbUiczjCK73o+huq3eJ2SH1uJ+fEfx3/yK8WVQmlSiPRzxyt60qL4TxyiPvxqe77YNPJExz7D0RfuQ25Qk0xrjggP9L9vnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720485768; c=relaxed/simple;
	bh=4Uf1BLMEqHRjDm2kpgEfv7CkouHVN2MgQOMFGIyzBN0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OWVOkpk8fS/VUb4Xu9O0sHBH+IgXFNGRox84DpVeIK4Pgh6K3+q7OESPJ466zqyj+gN5d1sUqtZqA+EfOYHnSfTFuHXkxeqGULFdg7fWDkpbDwnH2aa3Aam+Zh2oXvC2HqZDwW9WEUu1SzWzZzrcYAUuCQ/gUMQEHi/XH42kbjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRrVtF9p; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRrVtF9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720485767; x=1752021767;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=4Uf1BLMEqHRjDm2kpgEfv7CkouHVN2MgQOMFGIyzBN0=;
  b=YRrVtF9pOZ84xiFewXan1HLlZWY5x+qG7pCp+GnRLqDCkziY8IbYZUcC
   c5+kSDv3olfG77Uf2z6JSbifYOAEe28aMgV2Y7jKlL1xx72jg/yqUY6R5
   Sz6lbLPvUBnlEvHC/m+HenB/9SsAu7ESejqeDlSpaM7GYuNgyNQ/N1XFs
   lEIFgGMC+NEwExXHIerV7toIOxQcSXwaFSj9ClTO/Mg5tu1Qn17uPKobM
   TCmuZbXVhcnG8bLtyA+I9MprPS+8MSGTJLOE4JbHjfY89uMIEvsnLjXB0
   8USXSURg7SOu7QTNqoKY73ULaFljKlXkaz07LHAF2MFyra4nT03HVHCkq
   Q==;
X-CSE-ConnectionGUID: akeQ6g+oR766KQhC/v3h3A==
X-CSE-MsgGUID: 1Qp4FfukSdqN5sM1lxinag==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17848717"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17848717"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 17:42:46 -0700
X-CSE-ConnectionGUID: 7R+b+BWaQWqI5jVFECg4TQ==
X-CSE-MsgGUID: fzxxRYytQTqTcBXMTUkueA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="47600608"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 17:42:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 17:42:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 17:42:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 17:42:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 17:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuEi5ELveephjAj9yEj+k5yxicoQC6rBOUIt+V+SNq7is4/sHNzsgFLImrXNR+m+dNaLHqgionqItpalN3n6XvdXeqY3HxelkHbEfs4ffSdMkoHXQIpvnQMgtyDy2xSTi6L/5YuFDOvmzx9eMpe0cb4eNRnK4rg6+DVEvpsXYgX1dn8TIbcMvtEgHHsVkl7Y2ILVpA2YgFDPwmQ4fE4t7Z1Zm+HhTOjjdY34+fhovinVGQVkDeUBoGrgG45hUJ1q7dFpN7hVlocvQM4mFTBc+JHN0R0ofaBpsA2ZPY8q2pPWZZP5rApDrWItnW244XP3ry7TxwQSz8NXmSHjLJQ3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hnk67ytMLipOKwmamIjLKVD2QB+/lrJ1XfkIuMjSfII=;
 b=hDm3X+cSopR8ndpw0fvc5uNZm6GPjdHPVbXZEVg84DzxIlACgg4PnWbqDTbHsygLWHxK8I2SD73o3ijEDRfvLaW3wcRLCyXld7sWKjN/6FsAmXNK2vCCFLEi3taFVGaSVUvdvt3nIpvpPJqIAqe77IBtkBMdmVseMWuE+vVvoMDXSaJe3AFdkTdo9QGGLdWBIKNTmND2QI4e7Yi+k9d+5POCVpFCWfXoRkMVo/zw+WYE8kaNwn27GHfzeRteH+LvKYl1AKF8U/qim4SgdbrtI7KiIfbAmeY8JseTx4ieh5OsWnr0yd19gC0i52hQzQpUnEVkDeLMQQZY+aH7FDv5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 00:42:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 00:42:41 +0000
Date: Mon, 8 Jul 2024 17:42:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yee Li <seven.yi.lee@gmail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: Is there any plan to support CXL GPF in Linux
Message-ID: <668c877f86daf_102cc2941b@dwillia2-xfh.jf.intel.com.notmuch>
References: <CALX8JfQ1F+DJ1woPP=gFvnEyy4qHqGkN+94CKG5ONQy+L3C5_A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALX8JfQ1F+DJ1woPP=gFvnEyy4qHqGkN+94CKG5ONQy+L3C5_A@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:303:b7::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: a79bdea5-16a5-42e0-8899-08dc9fb00a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?isLQpf/Q9ECRF+AMtsvd3+JazJaXjgX7xy6jl/X7iytDvvWB9PXMk5+A5F2k?=
 =?us-ascii?Q?ZNauId3M6NaygLvIoLPacf5SLhAFDeBd19FrQD7CDe5RqvhxY2iNtycbCe+n?=
 =?us-ascii?Q?zibPYDhDlNFj4e5UF7DDjB/OfLwhmALv/S/x9BpzG35bCIjhNsADlS5qQqix?=
 =?us-ascii?Q?YgnHReVYQRGcUwE5DbZi78OSFp6Ap5oIYozHNEI+MpBuqiGtm1W7zDSbwUxq?=
 =?us-ascii?Q?j8Zl2YVpqDbdhjyZiMxwvPArIGw9HIF5QNngiXFzd8gHqDJrh1TMy88keJq1?=
 =?us-ascii?Q?x8u3nrHoK0XZS2XRAsS5hENuXwQg+lGertsqTvfSyiDhXd62waLKpd0CTCBR?=
 =?us-ascii?Q?+/krXfstKF6dgF+hGxr3VEV7exm2Ioqy8hBr5zHkCPXNGrvTd+1R/OHsQuoz?=
 =?us-ascii?Q?/9jO3Yn581M8ZOGHWfPdFV4qCAyLvnNoEjaFmCdfjrowF9I6hbTBNjG7EPDW?=
 =?us-ascii?Q?l21l86iifoVORX750qtFJGildJN2lGKA1BuvsvmG59FbklnyCtHZ7fdPQ8JS?=
 =?us-ascii?Q?DXM7w50XNarM3lEHNFl+L89wxmsCk/CHd+fQrkgquCpmdec98aMFhAM3P9D8?=
 =?us-ascii?Q?gZJCUgZwURY/4/Cv4SfBLHVdu3V8vqMrltFO76z5LB57bmUptze3qOTuIsLJ?=
 =?us-ascii?Q?mbxo+O98bG/bXAD3FtPXznrLFuqsFCPVGJMOEL8g4Zh3gx+tMT8+Odogj5tg?=
 =?us-ascii?Q?OrjIzhtdDJzG2j2vppIwdQlQ9x4VYhktaA6rfJCy846nEr898t8414bGJvr6?=
 =?us-ascii?Q?8JWg96lcHnDC6aq656AAYAZLst4RW4ejfIxgs2tBmrNe2L5PpHAadzodPzAP?=
 =?us-ascii?Q?OirPCV6WoyYhdYAs43BVkLWZa3/u6kGM14pgyVEbrxAJR/BalAjOiddoaixA?=
 =?us-ascii?Q?mQsAW/5bS6QDnIA1TKG7erMqpsukN6jffoUccBidbGsqPmD86Xd2S0vXLMbC?=
 =?us-ascii?Q?rMahds+171urEvV4ursppJgCXtSDY8ywkF4kNRfzlYbEvZLgbzrJx6nv6+/7?=
 =?us-ascii?Q?VXzEXVWnTLGB3cCfU89lT6DKbuLwCJC3wTtQZ49K1fJTkRCbv2pNKzjViTk/?=
 =?us-ascii?Q?jsI00YHkeHDEDB2SQxm1CsmkK8IRW+so0QeVGWlDJJEureSpMGz9LpfZz4WJ?=
 =?us-ascii?Q?n91Qi1lvh9dPl9Q6T2hphnRePEqdD9ruasSn5jYs3bBxKEW7lGPX9y9g/YVP?=
 =?us-ascii?Q?EPrZ2K+G2dnjxl73iBPZ0wRpN5KEitNUYVGrT6oJxi3yawPrgzukJUw0HJhp?=
 =?us-ascii?Q?xwujv1w+uCD2MYHCb+NDnhPneOq8yXZ16g15VvABVXl72w8ageD68aruBK2i?=
 =?us-ascii?Q?3wI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CrAtdsDiVstHgiyCXGi6xAPlUVBWeRPJRRL1ZGnDTlS+JACLxLVTHLJgEvFX?=
 =?us-ascii?Q?VxhPp9V3vxFh288seBAGbfgHE213YQlx4k1jgpFnEEBJzmpI0IRiVF/DKh51?=
 =?us-ascii?Q?pn4wTtyFFj2U6DSCnq+RDKD/B62eJ0gCnUf4q+gvvVeexao/tt+tMKkiVZkn?=
 =?us-ascii?Q?fCASYA5wFpNKRJtltMobYZVtDlaGIKZAw0ccsdsDqQaLUh0rCPY53yyBvqWE?=
 =?us-ascii?Q?pYbduRrqC+WtOS0vwmPYq25Iev5q8Ia8+kLKnoyM/2tYmguunHo0B5OWRIxJ?=
 =?us-ascii?Q?UzrWOuYY11khYdikvxopSPfL0CwYwlP/va9PuiP9TwaBP2rDpAc+FJoTG4rw?=
 =?us-ascii?Q?uv9HigLZWSxU+U21D3NJ0fCjT8cQl0BreYKBFDkUapTJasfXFwT0E13tlXLM?=
 =?us-ascii?Q?khzrVnTLSvRCVzXu1Q7tZh6yJPw9vatKLQxzwSJVdKqDboJTJYWjU19evgvz?=
 =?us-ascii?Q?zLJJWO7c6Pp5U8Mdnw3SLa601iFe60U0XVw31uZm9gxkas1a6LbBekiURVsp?=
 =?us-ascii?Q?M61nTng75B2EhNhFP76H/kBni8gJyG7QNZSOVx3/8iML/x/IfqXs3Q6+gxRE?=
 =?us-ascii?Q?LFJUS/Tb10zj6FujI0cGc+A9XuRD/BgYIeYqviOFL49S7ENlLqXmCp9/dNw4?=
 =?us-ascii?Q?DH4U6EjAQO/+nYrRzZsCbijBVyaNiZgmHjLk4i8ZDUJfJkNXjcV+FEhAb6Ia?=
 =?us-ascii?Q?eWgL9t2WFV5NBgCWFgSJAghtekiT4ee6JIrNpOOTRZ5b+KDlOx2Th1WEea2q?=
 =?us-ascii?Q?soLwcHaJXrb3jF29J8rSt/lI8+3wsm2v+krEj6vlNUKblkr9jp0exxIAkDhR?=
 =?us-ascii?Q?tNeR1qJC5z6ttXwXDFYho0Rd3QOixEmjlG4vyK8nO6AMUen3BBEPaYgAs+WC?=
 =?us-ascii?Q?2LIo1q8Xr+n/2F11pogYm+WKy/t0u66DatUmPU0rCQ8ClK3VlPkTMwz07fV2?=
 =?us-ascii?Q?Mdu3WG0zYflRsy9bgS4pLFho8RUkhVTM0FRjDKJAqf2R8ZClry8Jg82ghieb?=
 =?us-ascii?Q?sG+Ngrzt7He6cSdJzipCyUFEU8uVbBxrOkmzovPdWZxo2zxUhYhQh6Tv09F+?=
 =?us-ascii?Q?Vi+hr8E87TYVE6Bg9Loyp+POKdhoY7K4KlT13G7ZKF12UFBdO2qgQKF0NzIj?=
 =?us-ascii?Q?J8hKYuGGafUTpYV4aM1H3f38o1I1XRhPRQQ9bAuedZRTbPZvJ81IUyLHUZoI?=
 =?us-ascii?Q?R0IV1RJjZBFoJeVU5opctpXLfucFThRGJaSjRp2v8Uy5kfzkWu25+6Orb4kf?=
 =?us-ascii?Q?lv0IF0Ze2temOMzHpD739RruoOo399rySNF4EExGIpjCWfg1kbwtL/Jtq1zw?=
 =?us-ascii?Q?hLdvFvpBF7sFn7YkZiaVbtDFvDXzIa2Gv/Yoqw2Ll7k4V+AHGk78/N4xt/Zm?=
 =?us-ascii?Q?/y6d2p08Pq2gQkowjcuwX5i+10PKHnUL5N7zWqnrgcIUNB1pUrFXw2Kk/om3?=
 =?us-ascii?Q?OSVBpN7KjsN0+dL02vXaUXD++L8Z80JPuvpMydV2TWY3S3/SG9fiZiISvf+Z?=
 =?us-ascii?Q?GdsuobCPFOOKDBOiZO4mgxt+yoBVJWJazOLrIBeWFYPkSBjjFuOfDI6afB+R?=
 =?us-ascii?Q?P+sxvDwRdsllFmcs+siQpPPaLJSmh1k1ND1T21ORGcFDCcb9BP21npgP/hWQ?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a79bdea5-16a5-42e0-8899-08dc9fb00a5b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 00:42:41.7795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9SgrW4VI1pzNX7xjHZJEMwrT+x4f01pz7+eZtSueMoEXs2wxBohMlNXvnXo3Z+zLPdeFlhZTtDip1vxYnFAkevn2B/kObcwEYC8l1ssn3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-OriginatorOrg: intel.com

Yee Li wrote:
> Dear All,
> 
> Based on CXL Memory Device SW Guide and CXL Spec, the OS driver plays
> a part in the CXL GPF sequence for persistent memory (like Samsung
> CMM-H).
> 
> So, is there any plan to support CXL GPF in Linux?

See the "Maturity Map" [1] document for what the driver supports.

[1]: http://lore.kernel.org/172005486862.2048248.6668794717827294862.stgit@dwillia2-xfh.jf.intel.com

In terms of "plans", it is in the "patches welcome" state. While CXL
PMEM was an early focus of the kernel enabling, no PMEM devices
materialized in the market so focus moved elsewhere.

> Including init GPF DVSEC, flush data to GPF domain, etc.

One thing that guide does not cover is what should OS software do with a
dirty shutdown failure. To my knowledge there is no specific plumbing
for handling NVME device write-cache failures beyond: "hope filesystem
logging and metadata checksums can recover a consistent filesystem".

I do agree that the driver has a responsibility to set switch timeout
values, but that is more an unfortunate complexity imposed by the spec.
Just set the max and rely on devices to minimize GPF response times to
avoid the worst case wait times that those timeouts imply. In any event,
enabling that is "up for grabs."
