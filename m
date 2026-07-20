Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C93612F4;
	Mon, 20 Jul 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564951; cv=fail; b=O0VcNi0+KrDOoyFjLM7mvyvTHSK7Ef8rvvhJvIN9jMjo1sI7s+zQWtu8YUDQlB8mVaSECrFbUshCptFNP+wxo9ZIbtlZ5+M6H9HUaM6n2gc7YdF62nnEzvAlV6ANah3ZjHRazgv9UPozu4u7ovyadMXu/PV2GyjSgrocdI4RM7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564951; c=relaxed/simple;
	bh=C7NJWbWNqD8PHyb9rgikY9t+PPVsGDs1pIN/HVSBlMw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o7BtayFNQx+LbIqXxPDJq5hqZ0NyCA4I2OkiRR75ZpnZYqnM1+pqlhpeSVZhU25XTN42jooW/x/YCAnI1YfPYyvRFwP60+7i7r4b1KoGDyalbjEXGVoSfnCVDwFzzYbagaDYqLf/LoCxBBNuy2suT4PNxcXNRadeH/3v6U7kJKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IylPntI/; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IylPntI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564945; x=1816100945;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C7NJWbWNqD8PHyb9rgikY9t+PPVsGDs1pIN/HVSBlMw=;
  b=IylPntI/9JVPV7YRkoIXvNVHKycRxBoRGrXJTfSZoksqOAEOj10wOVqt
   MZvdJG9uhddVAMi/65N/VnoOBgxQgrI4kpdI1eY+9flh7E4tC9Ei7I96r
   EVCOw6tqCpisHgAj4e+qKYZO+yM2RRHwSpcwyDytovu95hLS19+8MaifU
   jrEtsvJf20zW5JunfL7oVZDTrypq5jDHMIu43FAwJs5UtqwZ0c+evE94u
   FEh6Bicj6t5c/pA/fOt5XO5IbxPQY7YdxeEDG2ue7f3MKyiLG9o+VejeV
   U0N9784b920NYTvZ943Layg7vUajlyiiHh4NARCh0LHzvBg4hdcqq123C
   g==;
X-CSE-ConnectionGUID: 5SSKGeagQu6WVPKcvzIXpA==
X-CSE-MsgGUID: 0L/d67SIRhOqeRoHw3sqcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87690164"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87690164"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:29:00 -0700
X-CSE-ConnectionGUID: jbAbhByFQpaUnbzUpYXONQ==
X-CSE-MsgGUID: 0ab3Me/SSL2yV7VqeELA2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="256316708"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:29:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:28:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:28:59 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:28:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvHI2rihmnYIPVc3IxdSTTPScFP3q+snnVPOyyteyQy6N0mtRcPuS0AgTIcKR7irY/y4usxA3Oa40dqS+sC2/gRafoxxG40U4W03Cz/g4BA80IhmLaIMiJHipstHmInGeD7SWDh5mgtUIGjLS1CETni+YKbMlkn4zOd/QVqfVTVsokQSqifzG9bqBDKcwsg+DNPGD5yUcdp+nhe55hE/T5/krgIrvRQg9bg+guZGhU3MR3+jakvhn72bXxwMQDjSPrB0gFIW1PFF61yEtbjgSHfNebNqSRvdx1hGw8vIXA6ynXgLEHONd27P6gwlFYeWmDZcEfRbjj7ewmX1JiDqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmrTtYVJe6C8lvVz82LpHjnuSQBy7iAvTUbN/3ztCac=;
 b=BK/5NMi0SGpq5sknpMkJR5rm6zSC3SW7oL1tB0N+53YE5USSyM03LWVX2f3XTKokMvr2VQFAm7gIF4JVJImPrZqHBhbd0WCXo9CW9etZbp1SQOXYO9ugwL4nBWlLE7lST7fTxzryiOL9sRFRI7bR/ZmgyZf85F2vkD3KHDRbfalc7sUTNuHecsLa+UfUqm5AI9EAj5Z5YZ2bOJxkmNyCTGRKHzes05rmSemLNM4qjgHULkSyC0uC4oQOD/DOZQ5WPazcV80qRW4EMu/SDwM7CgZTaT2T7djJ2z7EIMZxghSS0TiuWusxdbjK1SBKwMg95vrAMTzCLsw3ePlPQ1QuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA4PR11MB8992.namprd11.prod.outlook.com (2603:10b6:208:56e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:28:55 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:28:55 +0000
Date: Mon, 20 Jul 2026 09:28:51 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<terry.bowman@amd.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 09/10] ACPI: APEI: GHES: Bound AER info copy and
 sanitize software metadata
Message-ID: <al5Mw9VFKws3PpUY@aschofie-mobl2.lan>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-10-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717161647.1493259-10-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA4PR11MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b861d5-b0de-429d-50e8-08dee67bfe26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: H5MNyV9XlQrvvmuR+wA5ytLkOGG+rHrYUJGzjkFUV/pb+CX2X8LtF+HbnBlqcgJrF6rekGb6600D8z6OPTfq4H3oEnfo3qAN/QsXltfyTU6lFtsLe09YbZAJmnR18dWMPWrf9bDlowN2jy0Ba4cT+dq1DxTnEm/t27EaQgZXZ6SXguASrW9k7XhHZRVkFqKvFJZCBXVCxGWrupeo4d2ad9kN8dulV1RouuIr+QXcjuYaXURIoMTUZBhszQTY0z67tbTqokXhKs6GsGggwOw7WzzSWfh6PHG1hJxVAchEvXEczH2MNCcReiPVh1rOXQa6HEblcJUseXnsnlMPCFgBxz99KA06uGnWV5f21Efm3vYDzLtIdptYFYF9JPlB84ErmkI+APQd8NffsdgU7rjMf+uB4SUQicvJygB7l/Tg6uym2CBAHrwcjMrRJk5q6i1Dscv6PVcOK+BXHy3d2kNQi3rerfq8HFVbtLXsNrA41JeA/FHhjHMXmCZqKQJA0qsRBgRNa/qWdoH44KP48e8iQ7gQ6wnnXqKGLel7leQqD7wSRt27kTZtmgH6BjVJCoCiwu1gs9KE2ne122AENkNrmR2EiszdaTEdkcDYLE+i7KM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XgxfsB1rJ3uofMnmn1tzkZVE4hxANTX5sY8tvOE7cS96MAQf92iHuNJ1tIC8?=
 =?us-ascii?Q?o6h1jM8+KlVsLvmyMN+By6mrGM9hy+JGdAkfMq8dXhtWkA2qww8nunDbr4S1?=
 =?us-ascii?Q?a0Istnw0gY1bUsUfqK1Uz0CNNUEP2sX3rHKCr1+OVfeDsCqcohIYSpMUT0jb?=
 =?us-ascii?Q?NFamcJ+ty4jrZtmJnbZ90AfYfAmFK8LN7VLZ/LuUn2b5aTqqfC3kgBwIBYxP?=
 =?us-ascii?Q?X/DyL4kTBUL4uGq5hjultB0uzDhmGwCyjQt8vqsqyAstn5upBc03/+VBKdS3?=
 =?us-ascii?Q?xfFaWockTnDkiAK5ZdQdM3zpt7XP9LsWI7gCNIb5Xm/uJ0uKlbGZm8JoKyLt?=
 =?us-ascii?Q?x9Wl6feEvh0Czq78sEQJjDZtnqYBRat3af1kK6kNg6kE9kZVnZf6iTlItg3r?=
 =?us-ascii?Q?YL/7VYzZ6xGbTlHE/eFuHC58E7kbAw8v0Gj6ayK7ZOA7n1FNJALV6M841pWQ?=
 =?us-ascii?Q?9TDbnYPS3l7eMo38WzWcWAPlUbB2C8OA8duhMgw8dRXyDbXtoAYRzqXYIh3p?=
 =?us-ascii?Q?cmkkIwnxZj+tYG5fjlMmSDYK77nwHqtJkLTQMORGxn4aoRRmcuGEzzDCJuT0?=
 =?us-ascii?Q?7/8yujL/i++3iHaUvGmeXX8QR5Ua3GKAfl3b4XXZssMBPguDebH1wPuHaju0?=
 =?us-ascii?Q?neRH6DoFVHllFIesdTb7LANdCpvnL05rrCPxqykFaRK53EsEDdPbEj3Uf8gP?=
 =?us-ascii?Q?cypRXP+c3byrBNy9gorX7rMoxIDxSi0hGyQCeHQXB5/26aZ2rxMnA0b8LH7d?=
 =?us-ascii?Q?Eml94ouPbZglvw72jU1Y1T6zjPWhjUrJ5hwNR/mv3qEttluBJbGl+CJfkx1W?=
 =?us-ascii?Q?iyYcQvVWliKfBNm7Nrc/5hM6nnF7L7ColWOvKNFASxEeHP+0qkgWwElJOzvk?=
 =?us-ascii?Q?Wv1yj9KFK9SYKSrFyvBGqwKL4pKkN+2U4nfyNObT5rcvcoIFFcsm0xRuTbwv?=
 =?us-ascii?Q?H44b47gsSSsUcsbui7g2B0UCjpvvzMtopqwDmDcmfXIjksp/PTai9vlZxO7p?=
 =?us-ascii?Q?yFw3pkW+p6/VsufKIJ/jJC30iLc3IDR+gPNgl2mYhA8RvHpyIo++Q3hTfRbN?=
 =?us-ascii?Q?uJlwepSXgDSA48tRCSSyjLPdNVljV246fPATBVGSId35K9PHOucWZGYFVSNO?=
 =?us-ascii?Q?2eGl3+sk/+1UtmmJyAGvVcW+UpCAciXmRufuSxCmmtDWiX5Keg6P/qkF63Te?=
 =?us-ascii?Q?gVQdRmLIms2AyAfHA4RyWDnk8K7h576mV/+4X6XbAANYYTzhy4UC/Is1bSj7?=
 =?us-ascii?Q?RinFEq0F1Ahe26OTjBqxAqlVGxgUt+gbbyPGHWg3eEUCOfN5vczmk8KgMCKS?=
 =?us-ascii?Q?s07TLNTmaH7zXIgGjjTakyz1Ua6Al0cwexSyFKP8sCbqMKIUb0VFC6gkaMkX?=
 =?us-ascii?Q?wdJoDAt1tU2PRI9KtMULI3TAKP/HlI0P2p4kTZ9jrYYHDHCERxRSpEpcH4So?=
 =?us-ascii?Q?uKR1CEPdPSLWJqMP5SsDdb/XzjW/O4vB/swTZavrwSSZ7FK9c60OjNkD6Isl?=
 =?us-ascii?Q?n7wJqQqT63eHxagseKpYrqAlaWHRsr7SvbvOIpKDpWIKPx8Ep6WGgTx0R/Gx?=
 =?us-ascii?Q?O2H2229mV1X3380CODnLlwUbAM8tEJ0pk8oTN/nUw+y02SsjGrJRVTXtZPBY?=
 =?us-ascii?Q?avINfKLFCGr1eNV+60XCv0X5nbhD8hHk8/OKMJ1RaMkzojkxuPO2PULMXSFh?=
 =?us-ascii?Q?4kTLfMMjmBU0MZRVcgEY7OvgRbACwloPzd2Jrumn5QfuxT/JZF8YcqZxTgEJ?=
 =?us-ascii?Q?XrCnJw2fbomS53wR29zDNJ7SiujlZzk=3D?=
X-Exchange-RoutingPolicyChecked: hUv+jl3UHHblTz9AfRbHHjMMNAT7uBQsl3WsT6kE5ByStlDe6uzuQvIez80br7XWPwz8YodgNzZXxOaSFjTzAlDko21QoXbWvknarn66wnWWHBJVqQ4hgSWkwEJex1GljfvBHL2L8sGdl5QBDzu1S66l3dP2jHuwaYR196b6bnjdxy/ZI5M83eOn/h4pIRuF5WTUIHRynZwfUqCaBicZUc1lvNBSa62lFspTeUipr4j02O7lfyy7+bMegOk1+uoHbYV2LL8Bpa9fmNiaZh0p15iTWwe55CDTcBZQ6eIWGx1ZmgbCqAdBSReEiRPgqMKSXZEXackrYh/21S2CjxZ/Fw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b861d5-b0de-429d-50e8-08dee67bfe26
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:28:55.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BE0t/+mYFa73vMxPvi3EvUHMFCQoJ5l0Q3gypaVzWW9gZp5UrRVZShApqYU7Xsqor90stukFuw9rNrjp7fsqiHu94B6hkXP9+wHVVGicD6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8992
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:16:46AM -0700, Dave Jiang wrote:
> sashiko-bot flagged that ghes_handle_aer() has the same unvalidated
> AER buffer handling plus a 4-byte over-read.
> 
> ghes_handle_aer() copies sizeof(struct aer_capability_regs) from the
> fixed 96-byte pcie_err->aer_info, reading past the section since the
> struct is larger. It also fills the software-only header_len and flit
> fields of the embedded struct pcie_tlp_log from raw firmware bytes;
> pcie_print_tlp_log() uses them to bound a loop over dw[], so a large
> value walks past the array. There is also no check that the section can
> hold a struct cper_sec_pcie.
> 
> Validate error_data_length, zero the destination, bound the copy to the
> 96-byte source, and clear header_len and flit. This mirrors the
> extlog_print_pcie() fix.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=3
> Fixes: 7e077e6707b3 ("PCI/ERR: Handle TLP Log in Flit mode")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
