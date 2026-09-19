Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF881379C27
	for <linux-cxl@vger.kernel.org>; Sat, 19 Sep 2026 00:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779365; cv=fail; b=XCbvx3qfV0/nZvok3jME3ZrHQ1fbVYYFtJvrTcvEKCZ/JwCTrNWe/igGPy5rzhGYnVQ5SJCw33ZFjtUZq21g12RYojGEHTnT+LjOn3td95N+pl/6EeKELkjs2KMKMk2pFWLWQb8ZFN0yL/LaykHQ5mgmw8DkZjP9BdS3cMYKnQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779365; c=relaxed/simple;
	bh=8TVsuTxXZnoWya4g2aoBkt8LfkKNtBT64BY1oyd5xfc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mbt4bDv4o82gxT7Rudu9GkwYYYhKYvnR7XjnsTYU7y6dXBhDH136r2bVqF65WpnYecUebuHYkpXYkQei2YsX5oBPV3nYw+0hHi4c9LZuS+dW/939CAgm4+V/hBSiCo9GzxYq4WL+Pfnn61/Wq5gEAyN+tu1Vc/fj/5WD9R2OFz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXV2657i; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXV2657i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789779356; x=1821315356;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8TVsuTxXZnoWya4g2aoBkt8LfkKNtBT64BY1oyd5xfc=;
  b=JXV2657iv1tED1awlvz59LmhJr8dZJHnRSG0yZnsnxp0dQzcZVTrWWEE
   pz6rQ9yaowqeD0OPk3pISmJwVq75F4vhnvjCrWJxWQmGAqOqJGrilUO+i
   JmokKPWtq2Cwj9ALVX7lXxYWhG3bB5V41TScNMB8naLkYtK8CrPGabk2z
   oFUTYI0nIhLUNt2Z5Mmi/YIfvHEpc8TKAeoininL/n46hA9Y2pDCUnK50
   6yU8oz4bJwGJRIzjCeQhT1TUEVBZRkXVvSGWMl2snm/YMkgbpibovxEUP
   RRDl+D0k7NCvEnHKlFRvPiTQzdBZ8lmp3Jep6hlX7h9xUS5l0gcCnpD1U
   Q==;
X-CSE-ConnectionGUID: RZvcpsntTvWn0Olc+xglKw==
X-CSE-MsgGUID: pJZB8yP+R+6Y4MN9fSaIgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="107821527"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="107821527"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 17:55:51 -0700
X-CSE-ConnectionGUID: wNQEwKIUTQijvhFDbppLMA==
X-CSE-MsgGUID: VOxFJUU4QHe45wRrc/nqFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="298094593"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 17:55:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 17:55:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 17:55:50 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 17:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYoXzx1SkAQ21qi1XZ8ryDi9CzovOWeJkm2Q2biHJCIRIGa6qlQavoBZhvgjHwtAyTFI9m/QIlULIAlxbeqVFuiJH6WDIGspQoGZzFUzVxfN/C0Gj6KPUojTdbcbu/uN7om5KQgwd+6O11+XqUsRHoDQrZCXM5DFOo6+MVFnwbrZVopBP0Axt+YW0Q0Nz390SlBF2BF+ZWEP1JGUo2CfdcB3FIHMbnCKCttf6jgkQjbyiZ9UM3drXnh6Uz5LaPTHxRnny7zPFuwLAn2CS1trh/IO8+U8B8/c8SBU9ZqhAgahBdGuT08TUB4cP2wvfWrxxxQSFckzpzAVsraXLrwRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tuOlPmfhc63422qwhPesGDX9c+p8ogi4Ai1h003yIw=;
 b=tmtlw1TnX0IdEv7JFvB3m3YJ8mOs4ZgSmOBTnWVueR5XmoTyusyFDIKtolcsoErGEmC/I24l9DbL/KAXp2JbCg48wGEKXnepjO48gQ/Qx2a+BQjRthucrMCN3vY6gKeOxbqTKEox4UODFXNaAvPHADGE8DipmpdS2dVBv4rWrw4uFTTXwLRBHCyYvbQPCgSuZcPfX6HtHZBDiupOQJzt3+KV9jPdcV5CP/6pxoAMMxWVBNKSDXEwoe714O2Ea4xYXgDQvMC3IOg7/GojWF/mS63BlM7OruCsuyvNuE1cgs+2NGQ283SKsVrdRBrhc/uH6SwAJ1KW0VszZ+IVAbHfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 00:55:47 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:55:47 +0000
Date: Fri, 18 Sep 2026 17:55:44 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/7] cxl/region: Name the interleave locals in
 cxl_port_setup_targets()
Message-ID: <aq3dkCq3WVYnFVDD@aschofie-mobl2.lan>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <b3ceb52dfb0da2f164b941adff60d2db6aaac9f1.1788475206.git.alison.schofield@intel.com>
 <aqqpBBtJ9CWYGQDT@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqqpBBtJ9CWYGQDT@rric.localdomain>
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: ac719184-7d16-4d9d-66e9-08df15e8be05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Ee0NRf7Grv0L80aIwdGFo45H7IfhRqiO2dE3ya0UNRHdJVuoHvqaqurwVUXgxgq+LSUHuV//ka44+QOYcu5Ybq4kXCLt/Y+QvLxSRcEOhKoWjm6dDksPGv6XW2qKTbdOs0VcP9IZ4392L+H0ZOvo7itlSqqOjhixaLxCx/M0kZdwZjajUXRSZDlDcUHhu9AtzJkphgmiVHY7a7nlmD2PmGYS2RIO9a66kVm1rv1FluygP4AJgi1QYUYJyxwz56B3CtyG9+BUW+qOFsRLDK9TlIbP/i58u4Mi94yq1jBQ29YsTBeqispraQjFjS0BKQGSEuT0vrGJA88P9EtOl3rIpBkvBb24kyk6ReCAdRX+iVRq6+h8dvvhKF+J9Eo0ymqw5Yj8KxKwSkaaOpqiIJYSa2BMMRxXuhOsUhqWWnBFDO599PiyCo5uGi3RPoa/4Zy/AFtOCuY5hKwJ6kJ9UxIqutB4xauSe0G/kM4WE9A7fBbXcjp5n/Sd5aGemTF6qGQ2hv5Jmn3IEWykwDk9rujbbKpW7lGXEsEVLTnJdrW00g6n0Uf1iF0J3ZB+vXZJYUMKCziPEN7INrpUH9ngCGX9nfx25tDSXqJqAGEpDXjhuIdnfzhx5mA5CdWBObCelneNIdvz+kQQyK0vygnamzvEGg/CZzxL0H9B06A5Q9Qt2JA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zWe69GXGHh4/3FS1kn0VD+NCnKW75pBAZNYXkUOJDNtv4IhfstXHOvq0VtYX?=
 =?us-ascii?Q?XjynZ8JYhn7+HYtY7JK4kLkzUGugaIST5Joo4lHJ4nvNbzA9V8DzUpydngud?=
 =?us-ascii?Q?4UUvszs7U4u0b/ZNs42BMFScuQrSbZIDgP8LfCCr7w3IVLWQ5tq8vogxLNTp?=
 =?us-ascii?Q?GaRVuwMSKJlupiYo4LfqUob1ALwHOqHlaQ9BUvtlkeKlF+KAmqWTMH9ouMzI?=
 =?us-ascii?Q?9ShWuMSDw2SzkXsgYyikeyk0MZ53D6e0fd8aBDWPdOeHgjasuwPOjXX/9HPn?=
 =?us-ascii?Q?griWlz5jIgC98XwZsZUSVxB0wTrBbwGWHcCgiRyTym/Zmeg4Ry+AFGSe2E5D?=
 =?us-ascii?Q?9SDzSh5+mJ9dAhKE+ITAWHPndNF4YjGOiBkAYpVHSp3g0PWgHe9lKUySL3t3?=
 =?us-ascii?Q?BOeNqVCbcecRyL5zmZzBhK28D+wepF1JZwAqeQT5A0PqKEd6AKk9fumu6bMo?=
 =?us-ascii?Q?6/37q9ON+ch0F1IskvJPqHKirZQu4E37hsonJbY2u1HSE5reQNrrsQzMf5MZ?=
 =?us-ascii?Q?ecgaHZ9a2At96OvSDgQkNOjgUIr3O+QKV3iKZ+wCVgwfUB2IPpmYzyHWakhi?=
 =?us-ascii?Q?OgMYh5Zxzaom04Pzka4V2+ZbnmfKopt/bmgydc9q5L2vN/wTGnPQvz3DnbIJ?=
 =?us-ascii?Q?RWKSpwJxumte1BeofQ+jKBxtntjOkeh+zXxvLP9UUJ2GVth5YOGv0iRuTVWl?=
 =?us-ascii?Q?7flpnMV0ynr2ESFfllIwcucA3k5LpWtL4maGzaC/EpUHgbI6CO4YfT4/vw2l?=
 =?us-ascii?Q?+msVlLm2SGNifl7DekFNJIwphjWRbjTBrN2qhybrSj9SSOxOh3YMJXQvEpqM?=
 =?us-ascii?Q?foIA+LtuBLoSNNETcRKDU5GyzAMSjJeWobn1Hs/c27c1dnwnurhM7c7+IkEw?=
 =?us-ascii?Q?AyUtJBYDNS4qCbmPv5gon+jDxtNBg52nBCWsc/G/CfjCFI+fyu2+CgGAB+Kn?=
 =?us-ascii?Q?nvzGkEZsqb3eL5BNC82en2INkP1BFdVN+kjL4HBGz575MLhnjhq1fAfl5F80?=
 =?us-ascii?Q?4EVR0O/cvZ68vSBSOaZZTQNV1xXaUKA4h+CT2q3XnrCaKLcepsnq4oDvX6Ho?=
 =?us-ascii?Q?JtBgJ9q67dyg8B5+lGJkznsDF1jDvq7+/SHtSJ1D/yfv+/o8TDr/ZZPulhUi?=
 =?us-ascii?Q?BKPbmyEXAdHDB+R6sde1GcOK665Ns8BiDEpGGvA5BdBPPbEewVxLXRYK67MH?=
 =?us-ascii?Q?rr4xoonytg9PWpsxbStUJQYUOylYzbxZwwiNoBGEHOw80/NFdvH3VbbiiFru?=
 =?us-ascii?Q?rrjmdmzveLl77joI7ZEXTHSKFz8clFoVbNIjVJUWTLLyTnmV+OVs9rWS6eh4?=
 =?us-ascii?Q?nbxW1CmGev7hGvAeTXo/DmvnU20nt4uPImE408HNR4GSopCIV2t8egOcRK4k?=
 =?us-ascii?Q?GIU53b2uK3zopgopzh6/elIDocAIwv66zDGyYJ6Na9Dc0xyptYIQVMQu1Pkd?=
 =?us-ascii?Q?ijfBdO/KD7eKJxuolB3QjkXspTZtKbPJBvJw0ErmOwYWg22VuiyJG142zP1Y?=
 =?us-ascii?Q?X4VQUhONmfTrP9xFH/vAqLMtnvHDVEBDbPqc+zoaghs8YH5o/G3P9AHaSgDe?=
 =?us-ascii?Q?yISUv/UwREX26Rb6y6u/Aspme9DzTr+rZPnpse+4humhviFV1v986PoBfbg+?=
 =?us-ascii?Q?v2wiEMe8S8WX9s3JVKDoggIR5dOdBoqX3xamjB3wc00zu2lRZNu9oqmtNsui?=
 =?us-ascii?Q?EuVCVay7GF+goA7ReZuTlyP+T7cQRFo/NtWNoHmaAK7vfJlmRik32PKOprPT?=
 =?us-ascii?Q?gS8mRR1RlUZMAH0iZ1cFz6J4WMxChGU=3D?=
X-Exchange-RoutingPolicyChecked: RR0zpmwYhljUcEUGaj3AHXRgvXJeFdYH4sPy7d4vXJu3TP0Wowy6VfSBPb+5DaOyj4AZVC+bNh6QzAivRl2e9dl5f7i/9wcJ+OjQCHou4prN4zDX3zhXMUF1MhHT3YV6X9qEOHXWnaxjiGGzXP79l946OlSAA6ni15vc2U3AI0CUUuLyMbwXlzQJ983SwMzzGuLk04QLBuR1iVK8KSe02GCww4js2r7c0bLetYbooDRCQM6aWezAm+tisifJ5K9LYOmlRYupYebretNmLv4OrmQSP8Q0r9WINPz20O+yGjyAH+tKBStLC4D2bvHxYAyGMaBMCOl93ndsHV+QRfEQyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac719184-7d16-4d9d-66e9-08df15e8be05
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:55:47.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipUGleOpPe5lHuGtt9Bq2Oqo9Z//rz0083Ag7VSd4sdcx3/gWJtKUC2UYdqaZOpP/nXwn4wzgOx4RoRR4Ojb8JtxtaecwiS3BtUQv5zBx50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 04:34:44PM +0200, Robert Richter wrote:
> On 03.09.26 16:23:46, Alison Schofield wrote:
> > cxl_port_setup_targets() derives the interleave granularity of one decoder
> > from the granularity and ways of the decoder above it, and takes that
> > decoder's own ways from the topology below it. The values from the level
> > above are named parent_iw and parent_ig, but the values being derived are
> > the bare iw and ig, so the reader has to work out which level each one
> > describes.
> > 
> > Rename iw and ig to child_iw and child_ig to match the parent_ prefix used
> > for the level above.
> 
> Aren't my parents my child's grandparents. :-)
> 
> I fear that does not improve it. iw_up/_down? Unsure.


Yeah, child_* isn't a great name here. Those are the iw and ig being calc'd for cxld,
while parent_* really does come from the decoder at parent_port.

How about keeping parent_iw / parent_ig and using iw / ig for the values being calc'd
for the current decoder? I'll try that in v6.

-- Alison


> 
> -Robert
> 
> > 
> > No functional change.
