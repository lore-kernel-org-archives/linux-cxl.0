Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6041DA21
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446415; cv=fail; b=XhqXL86wC0UdFvy6+JssFtAAgIQWPVtwMXUXByC8KSUoh7MoboY14PnCUQSGIMFvLQ/9Gst5lKM9Z6cXiSjW/mfb7Wi6fwwfwDX3HPg0T8uHCD8Bu+lAMKyWUQ0ZfnsUxXevNFc2K8nXeV6u8CJXtuRCkjZUHiKmMEtYTWByELs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446415; c=relaxed/simple;
	bh=HCOSXyh3wn30Oqvcr2PU+IMU4AzD9Z1EL3n/zvB1/nw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eMiEuUu+TFjQ12S8EIy4WmyejWE3aCJztQrdMQl+L1rKJZtl03GenaeyxYZFeXK7HT619xVgvR2Oly/Vt9SXB/ZzzyRTBlHPTGaFI9egGGijJnZ15NdXm2IldLbFH37OxEIKNx3YKVrtGvLi+74RsBmn3rCBqlKp6yR0AGcPYT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrQhOJqI; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrQhOJqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733446414; x=1764982414;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HCOSXyh3wn30Oqvcr2PU+IMU4AzD9Z1EL3n/zvB1/nw=;
  b=LrQhOJqIzG44o5PgYWPNg7LZcryQ+CS81EdhGzrQKVA6Hb7aHXtdJmrc
   wQDvbCfc33N635CWe+3m+5fcBIQ9DdaqrgNFT6XScrl57Utc4uCGNpmt1
   7avEPIpM0vCLt0Qe4Z765c8XLfBGTG/I1ldaoy0Bap9NaV63YhKFjnR0W
   Q/0IV1iEB3SlZOEjMc3NyLkVBWC6oiyYnPnMyBlj6fA4R56gLFUc09Dkb
   mACj9JjsDcplz9mwTOYTCwQD1/jVficIYtkEY71UBYnN4TjtVA2DiP0g7
   tTPPZD2dEYhdNJZukhiWfdvTQ/ihz3ajeoJSB+UqP36qXYfc5lVAEDLeD
   Q==;
X-CSE-ConnectionGUID: 6PhDGAS+SU256rrZQhQ9iQ==
X-CSE-MsgGUID: akIOrLvhTzGYqn8a0uuE4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="45179654"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="45179654"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:53:33 -0800
X-CSE-ConnectionGUID: 8yWNIHsNStyx38oSovcwBQ==
X-CSE-MsgGUID: 0cFpqmqiSROzLmXhzBi6Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="98705878"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 16:53:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 16:53:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 16:53:32 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 16:53:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6iAzlr1OgTraHC3LSpyH5637Jj6J+Xf6CNFyMNbmp8j5WNK9CC7kzuxPT3M0P/xU9puqaoOFGzcFvYObtCzp/f2yYDNIa8hDWYau0xlJqR+Kd/zuGjfSAy389y3CeH4NpRJnTMWhR0g5Qj1I4DHLIfriGsg2hIliMNt+4mW0OeRBziY6JshjJIF2Xm+CNeNdlEU4aPXVq2sh6+mUyV5sc/jB2i6fW7MzCA+2ImCE5cU3RTnANeP73cQIzxp5QkOoUH0gEmDXi9lD+Akv5VDWOoyoyh94j59S+PnsSFZUtnb49jXfooMT5GHocBtLxQxtONacuLVfnMtmzZDDayp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeWV5/fwgkHwOw0VCAtAiCHOWN1uJQhi0J1LNvd9Ky8=;
 b=M1O5pNmHQDimQT+wFCox8SCi5M7rHerVcAcMDqoqoWyrntreuE/JMfsPuTasx6qe/0AvxXrs6IJ4dcJ4YHS9rFljswzZucvEjfHJntMtmaeS4b0vIRc9TSdBuqWD85avgkimGEHnSGMIPwwWxp3Wri624frNT3bnluEbL5ydNwXCJM2j5WKBjOedrLgRdp0Ll/NkjisdRxknXp06KlWsIBSc/HtkZjUsnI3IxMBP5QeMJb2umlPsGDuXBVlxoob2xVIevJ078PuQtfOILKo8z/zkBeyE/L3m7W87+uEHjS1oI9nM69KILKGr3nwRnbqgo/GioQeWAalbKZ3uFCDFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 00:53:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 00:53:29 +0000
Date: Thu, 5 Dec 2024 16:53:27 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 07/20] cxl: Add Set Feature command support for
 user submission
Message-ID: <67524b0767a75_250732944a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-8-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-8-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: e17468b0-136b-4b5e-faaf-08dd15906672
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0MiK5Z9RFtQe2mI55T8gRtnt7vcOWU0bduVXZE5t4pu+w+4vImyeY8reMKBI?=
 =?us-ascii?Q?6NdrSNc1U+1VTpbcHO4dxebV9cKpLZ8K0bat6Bc6x5r2P02ZRzU0iYZcCJx1?=
 =?us-ascii?Q?NSXlTkVcZUI9XAtp9s0r04HHYQcxxHXQLmP36DTZ3KZ8ydZsJAqZIzuGdUJD?=
 =?us-ascii?Q?ukUSMT6XaByMkobZtiin95pB7XdfxzoK6AnHjFEvr3k48PW3y9nFXvXWpy7X?=
 =?us-ascii?Q?0R49oIw7nDh3dwONDGAK+uxFa4y1pVoR1QauNinyfEjIgmKS2uhq0RJGW74B?=
 =?us-ascii?Q?YKuCWOY78Mg3Sv+yV8ksezoKoIozdv/aTY9ygerIQ+EQcq94dGTtgZ/2Fxe/?=
 =?us-ascii?Q?m01bjfGsfOzlmctqlVZgFAgz8O6RNfLpCYUH9Z9D5wZ37E7eiZ5jj7ANILQM?=
 =?us-ascii?Q?teXFh9REW38Yx1x0xn8TzdX+YHWQybLum6rM/qfiUdPp1eVnplNLu32lAXY2?=
 =?us-ascii?Q?bEi7F7XsGIG86XUeEZ+gGzNHEjhrReEExO4CUsQRNF9IzuxsVEphm6e2MnTp?=
 =?us-ascii?Q?5A+kOlqCrDpIeZHIwuu74SLTYwDTDgSV/j9ImG2UqFF2J98Lot+PEasbp+3Z?=
 =?us-ascii?Q?OhKMbVNy6H3ckHtqQcDBQNd5EuXOh6j32B8TQCNEuehrXmb5ndSu3w/xT2mj?=
 =?us-ascii?Q?HInhFki9L8LPBamPKvj/xSb0Wyzp6pr1wMVZfdzuhB7kwXUhY/WJAL5CKAGu?=
 =?us-ascii?Q?0wOpRcK2roZ2BlZ7JK1ZTNNGbBGBBXsV4tyOY2j3F3cs3Posp4aEf9UjKkKl?=
 =?us-ascii?Q?wYI3FBETvODMpoSe7g102KFVf8HQK4QgTqS3s7sHpMvNQM5qeayjErBaytdx?=
 =?us-ascii?Q?5xa7niO786hhGhoSFre6muAc4GFl/GJ5xaAEdvKEM1NTy9pjwv7VPQa/ATWg?=
 =?us-ascii?Q?mX1lZ6gbx7OSMMJ39ALv5tKW8ivUqk6/IUdIS0QrJumVR1PXgmRAZtgrC1XT?=
 =?us-ascii?Q?D608ycR7bTTIY2h+WoC5zPhe6tc9Pcq5xbTTrGM0gJWeX5RfASA4Zau6AwXr?=
 =?us-ascii?Q?2yN0+8hV+bdmMijtZs/TiBPlQ1rT7VPzKETt7XKUc4GfwR+TlYPEX3EslSyG?=
 =?us-ascii?Q?dHDMjl46uUc+AcfOyzSv2HaKW2/ncIEGFFRvUZH6RDfuGlBI+gYapeLJ9sSk?=
 =?us-ascii?Q?oJxOJ/U+lbQkzsJbVaDyz/5IZ55Pg/3o87AXWTs3o7PJxzVG6wfMPTDIihl7?=
 =?us-ascii?Q?wo4Jk3+Oo04+01qJR1qyUUWCFf0gWopVjDi8RzckU5px5YeAIWo/2XSkaPNL?=
 =?us-ascii?Q?RIZbSQDOkA3yEiOlGDz1BWlgnEKSHPk+q969GiBr7KKTsP2yC2zK80m+5qln?=
 =?us-ascii?Q?am7LwXoBsGsqJ+/Be7Re4EJjzvv+hYGyjb/HCedQjrvc0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9RBxRoUHsG4Y45B2F6OhzwqHf5Ph5B9gK1BufTuBlCnMjCSEGL/PJAeFpvM+?=
 =?us-ascii?Q?hHk+u0Th7k5Y2Da7QAE3znKZYPVZQkDl2VxwRQXB5q5WGX2TOkqGdWpzq9K2?=
 =?us-ascii?Q?SFZx4r+vRiTxtW9pyYtsXCLi5RwCl/aEF7qL7P1miXa0me0umWQa056RYQP3?=
 =?us-ascii?Q?eQXYlj1+m/ex/1PgJbVxFmpq0diIvHJodQvH4lwsPDsVaCb7G/jAnI13r5Cj?=
 =?us-ascii?Q?LYZFfMV6pk7jvXnqZ+fpUnjE1P8+PKp/z1j5JfdTLqwvr8/1S/5Y5aSd59Re?=
 =?us-ascii?Q?nKaNibZzlDzzCsV2B5Yx3trdToFTde0EypOJ/3zKyNtWQRrkUt3VJzsXd3Yw?=
 =?us-ascii?Q?VVAt8ilcJ3iPAbektkWzTvq461PU3xU6RVfl7oUy3IXee+W5zpytipA59Grk?=
 =?us-ascii?Q?tH3RycIgSFL4Oxvc1fzohWYZc4nce/ROBZJkZcJOzVq98jVeAWSWY7wQ5RYY?=
 =?us-ascii?Q?m1gmH9xAdlJnPa51spncZxVkDLcijo5idOz0w+7b+W3nMoaTOd+dLdI8HTmF?=
 =?us-ascii?Q?7+Vh77e6a/HFS0aAIe96dkZX0H5uXK3+KaReYrS+hG4BqOCcyqCsTk5KgvjL?=
 =?us-ascii?Q?ZeNN1w8eiidmJNUuepUsFu8bgBuiE+OK+ddM/gyo7B1oAl2pFwGr7BIUUvUT?=
 =?us-ascii?Q?fExiWGO1zRirg9guJRBHzza5SH2f1jiCQm+EGf4Qz7LEcbwwxkTePoGhC+u+?=
 =?us-ascii?Q?yQOzUyTeyelnhup+lEJtZFXGCEYIyTk6ypsmKDQLQ0KxVVeq8CIe9EbbOaLl?=
 =?us-ascii?Q?50a0NBLdoDCdEnCXCvVUbGZqwNIXpH0FcJZpt9xaVh7IV95va4Eg6QED+TLn?=
 =?us-ascii?Q?KjMMEIdcD0tsrWlCzT8eyvAnp2ogwz+LNgeAr0VPybrK8hkfNm6CNdzPEsWt?=
 =?us-ascii?Q?kGRUjPGAvnA558hKwxPot0i5c3DdsQkTEBdj5l2Wd3yfoGRTENZ1mN0me96M?=
 =?us-ascii?Q?4yxMcZGqRDhavhxBFA4OEDg8/no3nhQjL3cXjt7jy9qvkxOc2mIpBrCTe6j/?=
 =?us-ascii?Q?L0e4rESaNX0agpjsDNAvNmQQFrliUsa5WhG3UHYjYvpugFkv6naoUG6w3w1d?=
 =?us-ascii?Q?dELJjMOwBqdZSg9U97QCG9o0NjsIAZEpFbCEXeK3xTw1fK/0nPxFpoRdYxhj?=
 =?us-ascii?Q?i11IWCFYagkHPRWxoFbYJtm539KtF5SHG02XWU4uLOdfjfqljdMly7X5A0SF?=
 =?us-ascii?Q?TUcwJvSj2mz1USTfXxuE2j9L+5iLaNq4fLCKAQfC89P1ZknuPaWVSRdiIe2G?=
 =?us-ascii?Q?kCnj2tng4+YgBAykLfxpKQpD0dPDh4Q/xH1z7bC0nrzxpgm9cfVlyC7NqsGi?=
 =?us-ascii?Q?GDUJRMwfIQis+eqsGWIY+APzxgCKvfywpZxxI5I+K2UVW3hhAN3bIeGnNj1/?=
 =?us-ascii?Q?oaoq2CCOt42Gt6EjKWsoQ5BkPWUyMiPIu+Q/FzQkzZbJ0Dhj+HSKJzjRgs9O?=
 =?us-ascii?Q?a5o2ATvgf8WNDTS/sDpWwvctk+s2iUWaXwH8DiagrlVldn0YXJWR3nAxpA6W?=
 =?us-ascii?Q?jsFl7rmg930BdgLXRnqPAsDTUfOrxkjGa1bietaaBqLDsq1yMWpwxkb6nf4d?=
 =?us-ascii?Q?ychauulFVHf2dTlYhRaLc5W4QL9tF4rOYf5zfCK3jLgyNz65PGKGCQ1hVEAm?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e17468b0-136b-4b5e-faaf-08dd15906672
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 00:53:29.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMt180GOyRpo5bVJsiCNajGiLqd1av4t/v9WD9jUqSyfJChxLSeMHFM6Rs6AZBv/QMIYaVVV1Av8UCbwPjpu6F2ewYG4wWBtC6bANcqNnZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add enumeration of Set Feature mailbox command for the kernel to recognize
> the command being passed in from user space.
> 
> CXL spec r3.1 8.2.9.6.3 Set Feature (Opcode 0502h)
> 
> The feature requested is identified by specific UUID.

The changelog needs to be more than "thing exists, enable thing". When
its enabling a "forever" ABI there needs to be a story around why Linux
cares about the new ABI forever.

Now this story applies equally to fwctl support for set features, but
that at least has built-in support for a security model which saves you
from needing to tell that side of the story.

I assume we can drop this for the purpose of fwctl enabling?
