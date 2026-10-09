Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75937F011
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572634; cv=fail; b=FiQfcS+icCWFa4X+TVF0yue8V3ep3g4FcYXEV9isiAo3gD6FptBFUuTmuEGLi195+qStPdm5E+W9ae+M9Ve4fv8KiWzH2n8JWEQPRAPRSTE7lYo5yxkXxt8zqyYrMctrzzoZn+9Q7KIFuJw6YkjUY6z1MYmPfMZWi4H/Ta8JZoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572634; c=relaxed/simple;
	bh=HWwvuu3QY4tSpeopiAHGhmDiZndB9czMU5PvYi0UbxE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=inx2OsPx5NRYIGyhjlaGuVZruBchIAgry/wkNOavRcWP3Kl2aWT7nFrKC5v0s+Nd6ox8H8MdQbtjvMc0BZQD6iLCNCf3Es0LovdtXvENED6XF3K5Z/Lr/5gk6pDbiEyMPVJ0S5y/we/5YTMfwWhRRXRVhdO1aDssmIvssyVAo84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCc7kXAx; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCc7kXAx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791572632; x=1823108632;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HWwvuu3QY4tSpeopiAHGhmDiZndB9czMU5PvYi0UbxE=;
  b=gCc7kXAx9EhKff07vAxwXPs4iKtLQbfi6w3FRiCWYzRu24pyXIjouCkl
   E+VKxntrxWfGUpGl6hPLLcJBqy+YmvFPOnsFOf0BPhSzO2kgLshi2bzxN
   NQNzqGPt/0nzYUAr8gOHEFVd9JSLHBYwRlBK1JQq9A6O/Zp9CiK6sGO4Z
   9MZ2bAUCW/5VhAGkjcceFXI6gvOYy0vQGNU6R47E88QogYtvjR9eBFfFo
   9vaY50As0rNbhg33DEmXIdAPBOdXFJjsyiULaDnXRRbxGOA4Nh8r5+btF
   9/hqXI8bbM+5YzB4LNdYkLjYqLjQ+e7+idhk44utClvjoqC8T6C+5CHAh
   A==;
X-CSE-ConnectionGUID: pJc/hteIR2SOqPjBNMoxFA==
X-CSE-MsgGUID: SfPkwONHTcWuY0RIJd6tdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="392175"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="392175"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:03:52 -0700
X-CSE-ConnectionGUID: 7Rz1Vj7zQlmefqUwObBlFQ==
X-CSE-MsgGUID: 6Y5pCFcRTL65NJ+wzjuxHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="833213"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 12:03:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:03:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 12:03:50 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 12:03:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hr3r5y6hzwYuxvFhYOKNFSVbRi2JOU+7VoaXyPbqcQkG8QlIn3/QN2cBvYRDlDMOjIxRn6PZfDwnD0I24P1PJAgexHc6nyjWSwzVqKI15zqOonH7KTJY3fADWxIKJwqI+Xj356ZAb/sXq7rxJIzEApeeLDwU0sn9IoVUEGDXJACY4ScAHgXhcNjXbAj6db2utLwhEF7X2zy9TCUtuBNmJ2CDsW+knpw2lFB22oHtwf87kMhboS9DI6MM2sn42c1mACaNv1H8sYfvbbq7Rf8OXkgMK7aMbNja4sk/8gKcKP/oWz4lYMLJ6w06DNsvZk7uFE/1GCrib1m/25LR80h87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILvak/RhP7zWtFjDSeL2V6aZzNu1wbaZYjOC9ZLz86s=;
 b=jgX509pD2jfrJHfdQyxuqmhgFBZMBfU6UvWIPwU2xJkjmTQM4JwsXDEWOZbT9Sz2IUbt4VNVjTj3RWJcZKxwq9KK6lKtbnYP49o/jqicol6WGSMWDU6qZUPjvoICl/SPAP/8vz7ATLv75ymXkyE+cXev6Nbaqjl5LcnzS3/psE/fM8miAmp22OY/0enslke0/uxYbdd68lVa0vjHlPhzPOWXNyBEvrcCvX4hC8eOVNoNhICWpTcbSroikjxL5D1MjcKn+6cz23s41cK6RQlhaWt6l4u9SBrwbcNwn2xugcqQEIZcIiDkHDHDDZ7nw0V6ADKEdQZGKpjDHfXMRDlgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 19:03:46 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:03:44 +0000
Date: Fri, 9 Oct 2026 12:03:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] cxl/pci: Update only the Port GPF timeout fields
Message-ID: <ask6jMPLO7XIvnOG@aschofie-mobl2.lan>
References: <20261008034619.28059-1-kanie@linux.alibaba.com>
 <20261008034619.28059-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008034619.28059-4-kanie@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee581dd-cb6c-4cdf-dc3e-08df26380a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|5023799004|56012099006|4143699003|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: xXaHJ2spz5jKSLhUwB8ZUlTeYCS4HvRydDspf3ExxzUh6fZjIkTjLEF+qdHeftDm1YcsKhumTOzghjxriuzSp3IwZW0yFgRGn7wGkBkVzwLG37KEiTiYndsFslbLThpzEDyeRyJLw0zAuZbdUDGTaSlV1EU32rRCmVfSVZoVxCzwuW6mtUrJ93xcgTMSdKExl2BFd4xXCj0QpveiH1m5dfRey97gNXqshoWS5g9i7YeNckRes3SIfzfAXAtBtDAKMSRKUexEVMkeV2noH3UD1fZ0zbxkdBM1zWHcFi6e/dyzzZhuVmk9aQGe/LJUWlLcpN8iIp7e1iMW5eBIhM08rQDt/D+2seqzIAq3++1hTZinmL+x2qGwf3obIO2/6HLOJd2ZIncA/7hITcW5rtynH0clT8C1D5bKptEw7MrGYMGjOedabcvtfPBVujcxZafHWGK5XHiojebaSmGpUctZ5a6eiIJqbCdEEfJnGr2jl272jn5p3rux338Cz3hphKCXxkfHLjBrdpT7ssGYC3enrD8wzXyzzjmBIpoff2jpDyfhGB6cZKCMSkqd90xkP8rX6FGemcB/u1w55SrQKnjP7mCIHfwKhw1cOaPUBzEHbdH9fFfFZMUTOJH3pXGB34wboriOk5O8B45JgSVbN6w0IfaPr7/zVeQQ4bk8ExbEvHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(5023799004)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M9TjApCPk5f6KKqIDrQ1vBSfb0oMIcb5pCgvRaivqNg50E+4FsuirnQ6JGRV?=
 =?us-ascii?Q?/8gMAjyb+t0yZ0dugwXgl4XDtsPuGIo62TTsebUWZDJl0wpTRMLmHAVcAb0o?=
 =?us-ascii?Q?lC4xGo5c3V4841/oAPRUGhZbHcS9asNwhgCi/3eATdD+yHjyj0nki6U2M0IO?=
 =?us-ascii?Q?rkfqprIkoGqOgpj2OHbmG7GaxgUK/HWEYaKacTvfZtl37JvfJylmj/8ZEQZk?=
 =?us-ascii?Q?G42cuZ+W6I9AUyU0qC9/ekOBEjc0uK37JTpEZuYDbKIKJbxo1OCj/E7K7SNR?=
 =?us-ascii?Q?98CGinuaxjL1m4ntnjbYsL23JwCwzVzkVxS4FY+Sn4zjD8H3kX+g4kbLy83f?=
 =?us-ascii?Q?jc8IoxDXssuVUVM640Q3qEbZcYXFnA148QsP6kG4SoobwvwW4cVm6ejSCFcP?=
 =?us-ascii?Q?3vfX0/xRw6X/7VszqyObEi80h9Xlt+elkBhegh4u5nkSXR8fr2KCtxEK/0Fv?=
 =?us-ascii?Q?Gi+/c4i4On2U6DQSLjrOiYjejA473jDdPOm0zf7eToD2jzCcKk9FCyXODzEC?=
 =?us-ascii?Q?Xh/nvevM5TFXe33fCuzh8aci+y8CI+NDEM5dWZmK72rvvf6qLAfq3V4NaFnL?=
 =?us-ascii?Q?Qt3myzCMneI67f3POVEbF1xujsj1pMHqfunItU6jW0CQrbRD7XucxSfzus02?=
 =?us-ascii?Q?84+aDBxQn686u/LKi9q4zk6VvKzwb+LsSAljfgTLFpShr/FEZoWGOrHVwTf2?=
 =?us-ascii?Q?VOCedETu6lQGAhO/hkdc+KeDnAgBO+iB/TqtwnkVV9w4KgqNsWQ494FYP5WD?=
 =?us-ascii?Q?3SWkjUaMJ3KP4jK/4sVZowkVH7jnt551LwYou9x7HWnl1W83Rb+EnelMou6q?=
 =?us-ascii?Q?c96xSQHH8rtkGivoNeuEV8/ihYvKN/N/yN+l0JcSC+EWOqEsfOnyoaiseT6O?=
 =?us-ascii?Q?w9oY2GgBzePBwETSbrqS6QjTK9vmxyBSzoKvpuh/XoI7Ss3rfDlyJYtpo5gV?=
 =?us-ascii?Q?BJH91ukcbl3UJehsEK2JWBHPQeYNQoThKYrGwQ66HcSHEKh7o+FUweLTS/BH?=
 =?us-ascii?Q?pIDnuuHpHCnVvlAK7alBKvKzjgBGN+HnDlLTOWcILm2TVtSAs/BMoo4mb/pn?=
 =?us-ascii?Q?NSPYYIHBTba9JDsBAUOr2y2QARcYfhCj7rma2RNSoh+l4PxC0BTTzs/6QfUc?=
 =?us-ascii?Q?QHEnzOf/dTQb1jxjy2Vpoi/tTpfGpGrEr81BelN/oYesRsCPFXIDQwTeCj3H?=
 =?us-ascii?Q?Ww2EELSgS6hO5rN5JpFjvBlPt15I/KWXBZDUAFUyYJJJyHmro2nkcmKsvi78?=
 =?us-ascii?Q?WX5hpVred/uYcYyH7A/ZzMJ2nJ+9N6j2DfvpQuuvrIxFPjvsKilkx/M2thy/?=
 =?us-ascii?Q?Q/vIAcGDssEvTsnwxOo4jM9ZqAKe/NOH6t7VgLPd33kEiWUWwsJ2655Zb1tz?=
 =?us-ascii?Q?r/61h/pCc8PEiHb+tKUoJrrC8IDWJinek97K99chNpCxUbJxhBSjrp4anL1H?=
 =?us-ascii?Q?rPu2Ue6cUZwfDO9ezzBg2ewx+LgFNtbZVuwvobrTPmkcwUZe9Z5aMMLE/xYi?=
 =?us-ascii?Q?7Se8/NPHhd9Wj1eDEHI4n7dB9Ma37XeaXCkxu12V8vsoFts0j0G8rq3Lmsjy?=
 =?us-ascii?Q?QvZQhD4qxCk7ZgLmuewF1p6V3gJ1UUNWrQjQJONNRFLN8jJ9R6FbbhYRPWoC?=
 =?us-ascii?Q?qILo0icHWepOqUJaWyHjPsqJinOMwBiEM6C1+zg7HZG0N+dpvyXI2BIqkTjc?=
 =?us-ascii?Q?Td8HqaA0A4M6KU87U1+4I0ypCajF7KNrzQZmU/YjdIHLhiWf8g3jb9FDoAxi?=
 =?us-ascii?Q?UsxMmFZ/ZYTvXgL4DCfp0SbQvaLWEK4=3D?=
X-Exchange-RoutingPolicyChecked: RBCa8UV1tZWtiKtf528A2H+ha0LniS9Rn6jUzNPgbysaCFEMKMheUpzFgJ7i9I/Z+z3GGc1dakLSWY1pAR0UJ0I5rsIUbIUyK2MhvYckDgGeze/nicmgEPdscOHXtl1VXR1PJBNv1+IJjg4sHaoQbE3u2vSFt1lAjAaLnXus/dJ/t4/7Il/SahKfcTLgYYdHEm2KrfrwyvpCUI90bvLeNL4tDOfH2lkTjlLXO6ueAoPTKYPobVzbQWrrmfnSDhpYPFqQ7FY7+QtzBAOy1PRCzcJJ1XO5JYMtYlTupGqDXNKV+q4m85zkhM3BVVQSmbPKk/p3Xf9n42MazPQv/Nl59g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee581dd-cb6c-4cdf-dc3e-08df26380a57
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 19:03:44.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ST9ugXYusNQv+S3YNIG23cGEhniGPPJPIO1BIv/SKymFzmmneutn04rfyAcjmFf67MM+agcInPHWAcKMA9OFR3gCy4z+8fvAan1u+BiHbUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 11:46:14AM +0800, Guixin Liu wrote:
> update_gpf_port_dvsec() rebuilds the phase control register from just
> the timeout base and scale, so the rest of the register is cleared by
> the write. The other bits are reserved today and nothing is lost, but
> the full-register rewrite would clobber any field the spec defines
> there later.
> 
> Read-modify-write the register and change only the two timeout
> fields.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
