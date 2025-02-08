Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0F1F16B
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977055; cv=fail; b=qdGutv1stktbpdW8bU9Zyc+rzNwVjupQQbk5SX5U2WYfGbjwiywoct/th8L+Mn9zeYaWCqSoz1fAsSrlQmtCtK5OhJGzcmzHGBPDVMPKWIAqWdIA2AF0K1rn/DVP1V2SnXht0Ug9eUqamyylGrZfsB4K+9cw4S4912b8qwoLGVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977055; c=relaxed/simple;
	bh=VRvltinKQxzWjKCl3j0STiaUhUABdGV7NNLF9ef/CCk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wn/U5RS5NINRCEQzC7dAQUNkIrWApkwlgRwyw2ZlA/HuQaHkW1ZfmQyDKsTYRPJdNKpdfaSxSYPFJfPBCtyawamv6wuiK7MqpMhveqDLW3EQFPRHFZ5D5E3lWoZB991xFDFAu/K/G8wd+yxVnMSbVZ/idssGFTpk5kD1Is9Yjho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ae7+/R61; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ae7+/R61"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738977054; x=1770513054;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VRvltinKQxzWjKCl3j0STiaUhUABdGV7NNLF9ef/CCk=;
  b=Ae7+/R61LvYB7oaVKACvjv1dEyrS7L92vDGKmnw9oBf/7/+1DhrUBMnZ
   dNQTU8VdzVOu+4HiRBq31eIsr+LLcwJGi0kNxQN5+UMTXs+Yj38zvV/gg
   7Ll5uKrwO44yBkYKRJx/XMu23WcmgIaKyjO3nBcz7xxSIEnW+//nEBQIm
   RQvZIgqO2r+f9XJz9yBB3SULRWqA/2SRe9OD64tc4hk6t+DYPguNy8sdt
   Qaq0B0O2db7K2EWN8c7vYi7XONPPPdmAtc6Oo+9i+FTKXRw9R2fTnx+YY
   zXbcya9Q9mDJBadz7KfHX/5BsLJ01mu+WNtg5eiQ1KW4T4CmxpGK5UgAu
   g==;
X-CSE-ConnectionGUID: lAP8XMI1QvGets6WBxpe2Q==
X-CSE-MsgGUID: vjtC4ENzRBuMAAM85J9Bjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="62105651"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="62105651"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:10:53 -0800
X-CSE-ConnectionGUID: hF2f1GVsRc+zwPIWL3w1rQ==
X-CSE-MsgGUID: 3SKiYZAqRTGHYTE23iwGkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111618920"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 17:10:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 17:10:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 17:10:52 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 17:10:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2Rw1Lt/j62p5e/KK+ZEZzWkUgiB5jAhzTGLAawriAkRCLkEBs8ae6oZX/mMJblODZehMLmqLLYW8MZSSDsDoXwLx6pDYNWZe5uc18kgCFK8zwlLu9jC2DvFdzqbQSYcKxbbqCBlfwGH3Tj5nvz5i3CU51+LOjjXKU3mjub2vtuTQdLnyomYruHuO61SFQOTa2/53xOwmQk19fZ+yDTI63VDIQ9JhG9VV0+wwlUOk7pliG/cOwVk49HGuWh6FXQ1tft+owSk68T789s20DaMVbR+WMawHNlJi0pOd8xLjt9JrIsnjjxXFqhruY8PD/qol8gATL+3yZTT8mgETUQ0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRvltinKQxzWjKCl3j0STiaUhUABdGV7NNLF9ef/CCk=;
 b=VOo37PxYSVZF0z76enoZ7C79qnXcS5Jl2hOcJhaMS8pSr81Rw4U7VtdVWZ7DAxaVOwEy+0Be3irkxXZpeqXf21JhXSI/OQXqkcFiogLUSDqqwtfuB3vaZKm3rbgNoqBhTMrldQy/0+QLaKp0SAacbsaUjPix+d9IQbdcWmuYxJCCGEVbTebyvNTXCKnX0HQIsFZJ17xfkq4VMmHpzF2PMJZMQoEkirhOQRu/nwLiQRL8cMT7KAIzHUsvFe9XQz8ahfAYwSWAf6DCshKSp/DHC600kbOxxE283EL9sgz67CykCddIu/daWMjjBIhixmOkkNYSrsjHKqiUTFb9GUD/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7515.namprd11.prod.outlook.com (2603:10b6:510:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 01:10:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Sat, 8 Feb 2025
 01:10:49 +0000
Date: Fri, 7 Feb 2025 17:10:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 06/15] cxl: Setup exclusive CXL features that are
 reserved for the kernel
Message-ID: <67a6af169d221_2d1e294ae@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-7-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207233914.2375110-7-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:303:8f::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d98844-1e8d-41ab-6c9e-08dd47dd6c82
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AkY40UPZ3pAjY7fMw923cdDoaE929dbcgjoZmi8ifN57j2bRHQ4ITTgQAiGk?=
 =?us-ascii?Q?hPX+j+cTFzOH+TZlPixWIIulE5shnD0VSXQXHu21ZpaFRzq1T822V0ZXi1Ay?=
 =?us-ascii?Q?CqpN3KQsBV0wenTM3yEdteQOqkhjI0t2yKrumljIc5CyzQ4A7MBcEzYQWQJo?=
 =?us-ascii?Q?tpU/6fZxs/aAqbPMT23BOHsKP1OAt72y0QPLTStKdAyxdIDyR4HXEnnrSocs?=
 =?us-ascii?Q?ghtutJQLDTphJegl1V6kOpHFrt+0oLLP2vm5ndO5MXzJscTXFdpEUplNwf1C?=
 =?us-ascii?Q?rTgIcAs4jFm0Y/4gXW2rMMnhZow532MBqCyWe0m61PeG7T5+Aew0pUOby5HO?=
 =?us-ascii?Q?eN+oxlFRy5R+uMm/4OE/1Hnpp3qY5K67Xx31hRyiBPjQzkKNB1HDj9OEcga+?=
 =?us-ascii?Q?JE4v76BsAxT7xKp2zkEMSkWHrhV2loVBkMdG2qOG+F15ZG9zJaisZw1MiLEs?=
 =?us-ascii?Q?fLfVTap/UI4NtZrdlJAveFiS6yRuEYFykKIqdd2eUxtEktGi3LXvEFEYVuYl?=
 =?us-ascii?Q?2SXXrNb6FS/Tk9VggrjdNwLsEhediOrTZVNLJVD2nb23/dTtcaYjTO6Z7+qR?=
 =?us-ascii?Q?ekBIq3B4t6K+FFYmpBDqhSY7nYrUh8bfsTKnW6CRkm/9e/5E/ZST3o9t/nIu?=
 =?us-ascii?Q?Pizsf4UJC7D6UY6zNXqg57JzpbKZTJaOHW5hRB3ddIi6s5tZzZxzNYzIwRxq?=
 =?us-ascii?Q?jjlmHF+2oGptbWDxTp9iwslEXDGjJgI/YqI0NfmWD3/35AHIoNBAvVCRhUtu?=
 =?us-ascii?Q?S4V0nDXM72A1usWr5JbJALPrYPQLvboXlomnXrZZx1zmbLo+Bcv5k58Ncf5U?=
 =?us-ascii?Q?TkxbzIVsmKjy43diAIr/nm7ndVJidv9DEXc7l1+2+jGV4AmaCq0gdAB0FzFY?=
 =?us-ascii?Q?UuCh1WxRvx5qqcwXh4BPN/qhrD4fR+FDAT4lWA7fWte0SY+s0Z2CxcNqf2pA?=
 =?us-ascii?Q?Ite1T6h+EJtc/Ds3aOFbEJyIwZCB2FUnTX599YzBKntBgFo4tRUFHr5nSLbY?=
 =?us-ascii?Q?lgRKBLzSn4rOiknxF9vmJgDs/qvYWpO4lHzBCn6k/h+PSKJug8wgrmnaMk7t?=
 =?us-ascii?Q?6QDFrYcCcUGJeEnr5H7VM32mulIqvWef8osTv8yVYYwMXQ/nM/xK310OhU9M?=
 =?us-ascii?Q?xTbe4mm3cghnV5Gplp+AzDqM2TQjIBznnnKgwCSgp3YDCdeYYsPxFxrhc5qW?=
 =?us-ascii?Q?m66Z6ms12D2DCI0VNEoxjG8DHTj0UvlMndXYd/TFu8N5y78P1wC/9Tefs5Jz?=
 =?us-ascii?Q?/Jez3PlBNLLovxxPBTRVjVw9iclVZNlUAAQXF0zPfPmIvm80L2/k6SSuuqE9?=
 =?us-ascii?Q?9a0+NNFJl6gTUd1Xvb0xC12i9qHPPifBnZXfzUV8dOJywHjudwbkUZiUTOqW?=
 =?us-ascii?Q?3hJRjrIzn1AYxWXOBNJKk9/OcneD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HTpxjZL2sHvSL57plUcQ/P0DzQZlhrR0enhUl3t3SMus9z/ITmtS6s9JoNOk?=
 =?us-ascii?Q?6bYY8oJYZoov8wD64DXvEGw3avj0tYhaud+DNzRKi18k37TGUf4gnXXodefb?=
 =?us-ascii?Q?8z+DwPmcEj9qYbaR5ggk1gKK2hnqDuddkmO/VodeBX/kCkRuOS1k4QlUiHRP?=
 =?us-ascii?Q?gFXiTnrRU4ItNoaDWVvGPVn9ebfPFnSEhzz0gCwoCKDBANvKVoK1FRjgP6ti?=
 =?us-ascii?Q?9+nZsw39/VzvoO+Xgz5nX7DdqTSnGvXE/aTtXDgcIm8CfEvVX7jjN6RXw5wK?=
 =?us-ascii?Q?Rsotw7PquFSd/AzcZLJ8BhRgqlpdGY/mfwmqCYuAfSZpxr+QPcp0XyoMcTp+?=
 =?us-ascii?Q?m2vP2AQZJJEFbVQ8g1xdATvhMR4cx2mKa1QySW4VmERCtFhhUjF62QyPkVdk?=
 =?us-ascii?Q?goeVD4h8vbAHWMNlJva7KilnDX+ZJzLx0SfMWxxPsEoTffFdfekF2WO31qna?=
 =?us-ascii?Q?FqPEQfqOrIhz10bjea6cOHRBAOoB2AG8kbuLUyCjSOUbPS4Vb+vCrz8A1l6I?=
 =?us-ascii?Q?sDQ1vU0Ot3mk71uyKW9wrH+0KRNEeboDXUcRdVmfMxOSyramh/9zMa8uWJxI?=
 =?us-ascii?Q?86+CNzm+TBxCt6QlojRA4B4DLTLyz/QURAc52RfHUBw/IOYUQQ5RhdkFGOq9?=
 =?us-ascii?Q?wfsEYpGNXiV34frFnxA2YrQUr74fUeOv3hnHwSV/wbv1OWWtSaKl2E4Ggq7R?=
 =?us-ascii?Q?dP08YjA6wvpjMy1vkwX7xvYnkvdotswpfqiZARo1fSs0/8sq6EFJkNcEFB3/?=
 =?us-ascii?Q?28Z0EnfT3coevahdHObNOWO1phIDH4h8vHLHYuk+SK0tZXcrYFWg3gZQQjPV?=
 =?us-ascii?Q?0m0wVGF5o0LQOU0oGmInq8oWSf3wbGdVxFseQnQwQ3yPGrFxf+Ho3t0X+Prb?=
 =?us-ascii?Q?8VWsgwdp4ZP05RNSxpluMVNlGOHfIBimIql1FZQkmAp71C1CZTUau6WvGawV?=
 =?us-ascii?Q?EMnWDjAu8TS00krumgfAaFsOJ+1iSWCIAkJMx1GtYlC0hNS3ODz+Bg14OpjX?=
 =?us-ascii?Q?6CTRq6QFh7ZBMVrj0l83O4mw8y8XANeIAD7XSNcxwgiMF+DUcvqlVU9llKqX?=
 =?us-ascii?Q?lJGha6sunLUNpgtPwtAreIh9E+RMdHQdN6tJvZgeUrzr9EQTOCyGYw1QNw+6?=
 =?us-ascii?Q?kTrWyPvzY8DB4oOUTv2zF2kp9Js5dW5aLQgIsAhYW2913W9SN01wZEZTfLBQ?=
 =?us-ascii?Q?ZZ2Qymww41s2Qq8Qsz4rrqrAUcP7vFfxhrO/nyda3wh54kUXvaAKzEpMMtRM?=
 =?us-ascii?Q?1rgQAzxVU6sZ0Amsy7w/CLdNls5G4gbjeEuXzIJM9I7w+O+pXt807Exj9VlY?=
 =?us-ascii?Q?7pJ9oDIFRY8Kr3f+DSbe626LBVHwTiD4dTVgMnLnqeBRW1BvNu0I3fuUqaue?=
 =?us-ascii?Q?pH8vBY5esdJSc7+HqolPTL/OFooV8VCXlcqH3ngP1sxU0Q9J81iAT7jY08bQ?=
 =?us-ascii?Q?fGmilWHofO3VYGCXKtd2hY450TFnuUo8bgzq+2N+MxfWr3Q904W5mZMAol7l?=
 =?us-ascii?Q?MT1E89bc4RxuKIq89YWn1LGHy7T+MJodw7LQ9J/uQmw0nfpzxZwf3AN1ftvi?=
 =?us-ascii?Q?pQNA/Cg70ZkxWi8FPlk/cMvfp0pCHvrCSW3y8XTQRvJY2ltc3JGFWGR6MlkQ?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d98844-1e8d-41ab-6c9e-08dd47dd6c82
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 01:10:49.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWGijv9x7CzbChYJ1zVauKQyRZCL15CgOAT1UxG4ycJqHObuZJH+iTq1lwXqxqkJGAdjq2egeAoQ6CgbbX0wVh0IaR/fhvmpVfM7xsRufbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Certain features will be exclusively used by components such as in
> kernel RAS driver. Setup an exclusion list that can be later filtered
> out before exposing to user space.

This last comment is stale, the list is not filtered in v4.

Other than that my tag still stands.
