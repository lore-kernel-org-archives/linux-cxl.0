Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C82AF12;
	Thu, 20 Feb 2025 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013477; cv=fail; b=IORjZrEHt7n+UEmNeadnLh5r5lVnycp2wEdMF9DaHEcb7/nJIB0BFe+c64rxUEKSz0KlNNKymGYUg7ZiZNiOfLUc5TU2GH7h88rJPRG8FvlTMf5NMnQeS4hwj8WZJXf1Ek/sij+RgaFanXVKuAp5BhMumGNZdkuKrW6DtsntxvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013477; c=relaxed/simple;
	bh=u31sxDonHx004T4Nuab2dl1hWjl2zFE1BUdLJxL6DGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TurxNQcNsg3oU/ZN3nPlCf1Da4Tx+J4nOdlEtZxnwcWldOjohy00rCTOjM3Ukivq2BnZLyiA118SF5E6Rm6uRG3HFAuJaX4alSCNbsJ9ROwfNTsM7p9wHerObXDjtb7A+HULaXC+7V9jIxTGJWZjBJp4iE1RBgY3YD4fh2e01Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1xDdQJ5; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1xDdQJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740013476; x=1771549476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u31sxDonHx004T4Nuab2dl1hWjl2zFE1BUdLJxL6DGo=;
  b=P1xDdQJ52n/EtJeiuTCuZuAwYsvwUo3qWmLzIMJRT/0b2L5KRLaM19Pn
   3t6D6eLArmUkv6ly8B2R2l6P5uTqj/XcoXAX1Wdhs/uuHCCwuEWxZe4io
   hAYHrY4Qmb30MuQyL21yimTS79FQG639x4183CIh+UapG5UXo8mTnuEcg
   qZv/Znr/4JxMgzmS9nwTSczuzNBZiihhwurAhQXiy9+HJ56V187xTUmbm
   eJS9c1dvcmzwK/tl6ly3lVG/4dnsBQoAjS0Zum6NquuxsjR2K7tdSr6N4
   o03s4OYabzGdMpinIyEeuzFlW6HGsCcEa5DYWMgVfCQgGcy/SYGIOqCc+
   g==;
X-CSE-ConnectionGUID: 2tNMhUNlRm6TugsIk6afKg==
X-CSE-MsgGUID: mn2PTavKSfCfhv2rw9y46g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52209998"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52209998"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:04:36 -0800
X-CSE-ConnectionGUID: aU/MuNo4T3aOCk0d5vJ85A==
X-CSE-MsgGUID: lWQzJDFKRlOTESgyZigKPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115787185"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:04:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 17:04:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:04:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:04:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0eNmgR5KCf6ZF0wwSWXdmJosZP+cX6p8T1xrpMPTaO09Fsq02eFgQ02zb4YF5xwvzBgTWTYfOMjtXr8rHFzdIlbBWs8ar6KBbNT8DpmZv4I1pZjMvPDRE5rwyb3BB9AC8KfvmPzCKfYdAh2bJvvascuQoly8P+rqJGk9Oez14fxv3PZ/Bke7pa+NzJkwIpTXeSkUDMYXBw+J8fX+i4B+SYmIf6dj0wS7sG+UIo/07LpLGQOUEKiNQ/i2/KT2sUwNL4sORR3aATpL+gm2xC2c4oAX7TAtVJGsW9ltpAL8N+siesNpOQcCqMYYjbf7tYKxyBMWr+G9/yn0PCU6Lj90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maR8JmSCb9m4neMy9sxlnLzjyhup8ZwOyI4XYzagxUY=;
 b=K083ItcPAuhxbe8gazh0YIFfc5Px7/zN8TKA2nEau7oDG69vn+iinCMhtBvcxxldqGhINhKtTIPncMO0yf+Mvb4nKcltpwlANs/+/fAJUcdXex5crfQZraO8cVGLTHR86NizMX7D+QBcCgYE1Z7xkHAqEIWKsWIYCwXows8Y+/PeP/1DCY2I/mV09MnCapJ1Y903oWia0gUDLPswsAnwiTqP/qL+Qa48hWx6Z56Lt1oxQTF4+Cr3MUYDHVFweC4cSs5HsrB2gVfO8UnMBR7TfTEeFWkT1PFpubA1/WgmtFL1t9hyLPioG3XHI3/oIjY07Xt29TA9UDWllgJES6njnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 01:04:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 01:04:31 +0000
Date: Wed, 19 Feb 2025 17:04:29 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v2 7/7] cxl/region: Drop goto pattern of
 construct_region()
Message-ID: <67b67f9d670d1_2d1e2947@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-8-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-8-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:303:b8::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df67b4f-6c8d-47c9-2d88-08dd514a888d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iGNaHtLOpV+0eanM80AFKJNDEFeYlEAl8XNPvAIakoFVe+lWQ4jgvIVJHmMD?=
 =?us-ascii?Q?jWFdWGDusnbyeOCeeU9y7RWoUU+xNC6/aTgt4/WfPW1kbKDNvuMwDLYLH1dR?=
 =?us-ascii?Q?5ALAWKb7y8PR/A8n6I9zGeu+jGCLX933D7reC2Bly2MM2JpPWzGaiOPNHGNm?=
 =?us-ascii?Q?1c3QoNJ4kZviYuU5yUyTJ9GO7Lc2WFBzCUWWOFQvAz782edJgCwfSL37RKNr?=
 =?us-ascii?Q?NjjYMuBceRlaiGmX6Oa8/nI4NgBJQWFKiJcZaH+tHzIa87alGmMFgUCyDj3Y?=
 =?us-ascii?Q?YWjK/u73k8H4I5vFvZ33JgryrZgDUJOlvLZhtPsU4AXIEgIdK/pEySviS6ob?=
 =?us-ascii?Q?CTFB02TXmKLKlgN92AO61y1zYhAsoq0zObxDshxJ22mJEw8T5dfXZ+IxRmPA?=
 =?us-ascii?Q?xfqJUJCNHQsoHqIk58jfzWltV+uAHjxi0XW0+JOHrdIoAPkNjpqMQ0JJNC8Z?=
 =?us-ascii?Q?4q7e7hzf0B+Ey14yVunR6EiLDjFIOvzlQb0jhEi8Ju3gf1jgnZEoR8IkqSJr?=
 =?us-ascii?Q?YBc7B4l8naM6Yh4ppPcvxpWu9yA4LEn0VzOmyVT03cih7Nl8u4cxamXZ917F?=
 =?us-ascii?Q?LaGeDOkYhGmOHgVg/qbmRUG8HfByvza6bdWyBlfcP7U1QwMsgOGRl50CQ/aw?=
 =?us-ascii?Q?YUjjSi2S6sQbM6qqis989ePjh1nCdQNfdu7VGyxtqtTTRnuMjpawQhS7Mmiy?=
 =?us-ascii?Q?rwFaoaRlbuWTMcQBNEPA6hh0E8TK+nNUaEuv01IQer2AdGYyYbkaE4tbqFAQ?=
 =?us-ascii?Q?fe0ddjNiKmVwtATxGT1a8m64zqdlXprSmWsrXdEN8CE58SRDkUPZvpPrNL66?=
 =?us-ascii?Q?+USdP0iTsn8lFS3xEbTHnfNEmLw3wcjv7ObuXgGA4wIsYin7RloRBi36dHwr?=
 =?us-ascii?Q?CWfLjaPonRqy5lcItkWZgR0YPdvuL1Y/vNzMV2gYnkr3ePDX6OYZqHVmNowR?=
 =?us-ascii?Q?xyywSCMQoBvjOYtcanFROf6BmjUccXaJXO4lcPuOXDX/7vtG5nLQMD0o2uGG?=
 =?us-ascii?Q?iFYI9dVZ88VaYcIzcKP8a9RknkId3JJEIwIad6H7k37YWI1ounuWLqWGyzc6?=
 =?us-ascii?Q?ZoSLpK23fEpHz3BYsmFBHOOupXyFuttMZJEW+2qH7cLaHO+y0lCQ59xeutJG?=
 =?us-ascii?Q?72DvuRuIb44J7Qqs9dmUXSpr3dPrcXEGzipkkhPlHkTzEdg56T+dGp1tIOD6?=
 =?us-ascii?Q?w6vUISNBpziuIz/MRe8Istn/T3t0zM/nLZcJqB2tPXGWBxJ758DD8Egn81hB?=
 =?us-ascii?Q?xcRhWCwMBHuUkt6Ldh59nI9OzFXNjw0xXpOOpf60O1oaEoViyjRgxhOwZ+Z+?=
 =?us-ascii?Q?fCS5BbqTLe4HQhz2F6lHZiFGSuqIohBLcJAotPMK3LpqiSy8Mium2o09v5dH?=
 =?us-ascii?Q?ZEfYD/ODdBnXLRaHyPN5BZuFrS6+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6N+czE5EBY08cGbUCejk0KcV3GCFor6FtDa+NHI0m+Qcxv1jP+yhHFu0iCh5?=
 =?us-ascii?Q?29VUQZwPEz82xQF2HWH78UDhwSFvJnxS/Z06r6cJLcerphS0e9uRquCYP7Ks?=
 =?us-ascii?Q?w2jmzjeFS7NFaFnvVVaWzjGwpwsA7hDUHER7B1x0Z2c7dCCmSn7v3/VCTOzE?=
 =?us-ascii?Q?yc3V6Edx6FOu1wPI0LGkPpKeAGY5Nfh6xj3+eeUUdVSqvrFTauWMxf0+t8kP?=
 =?us-ascii?Q?n/m5U8rm/evNby/Z4TcQIPEr0/aBondWaLMnm29RTRZpvNMfMEbrxTBhmBNT?=
 =?us-ascii?Q?ehsJV/6Z37IAtbZcr/6H4Cm3Pcb6IVq1L0NenBdFBSEg7u9FQuL8XSvJ1yom?=
 =?us-ascii?Q?frN7Gj51S/Pd5BogLnR7DCUCl1Q/LdvtsibbI3QmPpvxbQZpCEs5TWMwz1Vy?=
 =?us-ascii?Q?GkCmbDqm3SeaPAnyoM+Xxac2vxBL8YkC0e8xqIYsJPFH1QhFyzFb7tDYZzGW?=
 =?us-ascii?Q?CBORoXNtWCNvv/n73Jnzgoo7CE5lY4St+vmucNO1J2pICqHPD6pBvKk575Pe?=
 =?us-ascii?Q?5aBQbDWa/eiA+wlh0Cs5Mx2KWYSb4mpVCDEHP41GhTs203YyQ8gLiOBgrbZl?=
 =?us-ascii?Q?SiT9Hq/A/vbnoT/JrbP2JIXabkwGRZcQ8Ehay5SH8ICvg1OJ+7AsLGMP6/lX?=
 =?us-ascii?Q?mWHoR7KTz6ZK0ulL3CouOaPsrcCOxH588uzHaR+CqpSXd8+NgUiBs8GgJUjv?=
 =?us-ascii?Q?OhPuZsKA4fLpYwdApEvcAJQ7F+3dWHv3a9/G3yN0UTJJi+HGFkAmMxELzo6G?=
 =?us-ascii?Q?E+lVOTwSuJmEyvjBx714K4HbiZNpxrkKsE6D6SkSylu0+Esq/7j8RwLc5tMr?=
 =?us-ascii?Q?pVAC/TF04G+vCZmv5qhdAGf1DpWwWFctlqIi06wcv1uQtIXb9xF8nNQS3qOI?=
 =?us-ascii?Q?c/aC022IoPuBitGRApxeiefxwmyrP0tlYTmHB0Zfx/jLdpbUga2nQdt8mL1Z?=
 =?us-ascii?Q?NmtCOlUuux/Z/xJBo09sRSo8RzjT/sfZplPKQoi0FJ982Cjk5DVlHxTtvQtG?=
 =?us-ascii?Q?3ymSD9+RgKM4RvUkJE4ykP4UF13JO5yfFICdNTGsp3LvfKuT8qS1xPRU4Q1B?=
 =?us-ascii?Q?2roz1XCMoFnwK4Ea1iMfujffWJ69aqdG8L+AZUZmxBhQososSeNLUZgrlAYm?=
 =?us-ascii?Q?qIV9+SV5sVhpr0qfTa0PcRZ5yOW/MC09FVgpj6VGbgfeXVIQ64QwNMHNxV3I?=
 =?us-ascii?Q?De7+oJ6ccEHsyTW1HzBtjWau22avhdER1D4NM6InRoDJnr37esDSEwvuvJBl?=
 =?us-ascii?Q?2L43UqS8O5jIU/3YyyshgnTgGFU8kSLTbgwB9/BFqVWScDqpg7fshihSCeYd?=
 =?us-ascii?Q?9KuaXRx6jaO3+0RZqkI5ub7SJs1U2GU6vdecijQ87K+38sx3CZGiWGGGaOD7?=
 =?us-ascii?Q?G2KVFbo+NNhB73uPY7MyOMLM9+c8Jtoe2sRPdokb088hc2ti+WPJM6M1e1mu?=
 =?us-ascii?Q?YsKOA2AevakFn7dCuQtv3fl/sEu82uGEt7wTYTPbk5jTgmNHieqnERsW4QAI?=
 =?us-ascii?Q?cIAjB7vI2wCpFq3TQDRMkB8/QnQOEhThYjHOo0SkVxE1jpCIgI8k4GtLxq20?=
 =?us-ascii?Q?TiCxoELxzN/P7NfHLnLfn0yPSUYeXvQPuU0TziSAgKPEHQ4FxamsTM1RS3D+?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df67b4f-6c8d-47c9-2d88-08dd514a888d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:04:31.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzS20Zkl5MWQg8RaNFVA0bVNZKuV9+YAEokbcFXpocNMvkqIQ2xfV/+qqjklqdON2Om15Bth4FUeUYyCmf8pMpGoKN8TO+EQfd9LmfE6RLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8282
X-OriginatorOrg: intel.com

Li Ming wrote:
> Some operations need to be protected by the cxl_region_rwsem in
> construct_region(). Currently, construct_region() uses down_write() and
> up_write() for the cxl_region_rwsem locking, so there is a goto pattern
> after down_write() invoked to release cxl_region_rwsem.
> 
> construct region() can be optimized to remove the goto pattern. The
> changes are creating a new function called construct_auto_region() which
> will include all checking and operations protected by the
> cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
> and up_write() in construct_auto_region().
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> v2:
> - Rename __construct_region() to construct_auto_region(). (Jonathan and Dave)
> ---
>  drivers/cxl/core/region.c | 71 +++++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 320a3f218131..7a9e51aba9f4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3216,49 +3216,31 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static int construct_auto_region(struct cxl_region *cxlr,

...probably would have called this __construct_region() since there is
little distinction that merits adding the "auto" qualifier.

Other than that, for this and the others you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
