Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A632F8BC3
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589845; cv=fail; b=Vfj91D1CDQ/igQVXIG1qCxEMdyM9YvWf1NCAYtdabXV0QvZ7Ce91TqTYefrojWygQ4aKlZDg/qgPEm7/w0PCPtkrz7bleLMrmLKAHJs0kAs3LQ0xs1Em4B8kA53AiF9p+kAQPRczD7XBs1GDjKrWR4H9DzJa9O4b0UYuyee9EvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589845; c=relaxed/simple;
	bh=qJPclW2XNLJqd3oKkmJnymTwWFXXl8kuoxzdJHadeVk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FnX14xfbxC7e5r5w7hW8iuHLkgIF4vImQ4ZwaDFAIoY3VEkp6AOzUqdEj99uxYAsCuLkTve3+iOG+YQsxDrGDWj+wXRYvH8KFjWn5eIGYLnNHXxCYGcAJOZeA2eG+5MdQVXfxki9CpwNmv98ygDa2lda1A1XcIL8rvowpA5yKA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E64SUciq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E64SUciq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780589839; x=1812125839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qJPclW2XNLJqd3oKkmJnymTwWFXXl8kuoxzdJHadeVk=;
  b=E64SUciqEZnNxC3w2IjvYf8gsrR+SxucSWBN/CBE6qa9iMCkervrLeDE
   OHwN89Jn/uzpA/p63yC1HQKjSs9n6RbkfBg/1c8eRn40jSoleFNX5QAl2
   L5Qk3jmzbR7qWkvByL9QE4ihEVn4rzxflnDKxELOXPPFZI3qycXWAAqCE
   KmvfoDXlGmrVhD0wkEud7x17+wYuI/TpvRDFsD8+EJ7Fk3Tmt8kEiWQ8u
   r0eCbu3NERuxH7QYyZfqYFKMHRxy3HD+XrUHs0IbfFKoCCA5fMaXsQIhN
   DQJGun1rbIupLUxaj+f8Um7hYswiMPt+1/CgZUBICGzY8dHdNllmXgvwb
   A==;
X-CSE-ConnectionGUID: LYWJT76oRJiDUa/Hc3AwnQ==
X-CSE-MsgGUID: DgxgRMVbRnGyiuMb+HJRmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81397103"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81397103"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 09:17:19 -0700
X-CSE-ConnectionGUID: VLqNR2ThT6O5SEipu2Z0ew==
X-CSE-MsgGUID: EyzvjcK1QkOjPcorJpkE7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="274827033"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 09:17:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 09:17:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 09:17:18 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 09:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzX2cv8HkmNESzjsFjoOXmpRYkopw/rGt83OhyDPaBgrZBiLgsLLuHTOLtLvLH3oc5lqBxFazFnmeCj+OhdCqu1qBaYhydZoGtpLGZ1EFh7ex1ciSlz94xTpT2mm9S0wl6LU/CQxZKd1ET0pY2LooabgM70wkFzG7HATUFtzb8zpKcR1L5FtNmgqNV5I9y7JsZTiBY/Db2oRJy9ldsi5arzyVWWkFSzD8ot/4mUCR08V2A9Kr3NMN1Q6objBY8UrRnD+fhudG3XmqcpGFtlKwexRLC4yVEkdhjVBCzTaH04XRc3Ng3V5iUFx3NR4QOZL46Om9Qckz77Vw7FuxnwcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZRKYnl27B6hMEJI08ImeTN/E4s1VxK+4oB+CisB3dw=;
 b=QT2XzVmh8qz7Nx4oJ/0QfiKcHvotADJVHHj1g4SMhzQ2Z3b1smImxBsQA0b4Vkzf0X4Bu0WMhRd4zTIpPZKVeXp4KY2fCIix5W+neUyZn3j5FiQh71Yv8iPPOAm8RidwwAHkusgbWjqC5Gaz38N78yOtIGvEePmmImeUfISSL2mk6bbouGq0VOvFXEi6JwKWPuPgFXPCN6/DLdoCm3najw+SiRbcwWp8ld+QIw9dU9kfyTnqSqvQuZNIBei6Z8phSylwzILaYmjmrfTqQkB5ECsRWhlNIanhiwBGfAJC6jg56SfXS6wNBJFMsgpLekPMuHdntIDOs6696+UNvMTxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB6265.namprd11.prod.outlook.com (2603:10b6:208:3e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 16:17:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 16:17:15 +0000
Date: Thu, 4 Jun 2026 09:17:12 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<djbw@kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Fix the incorrect check of
 pci_read_config_word() return
Message-ID: <aiGlCEkMNDq0GkYo@aschofie-mobl2.lan>
References: <20260603185752.4149725-1-dave.jiang@intel.com>
 <20260603185752.4149725-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603185752.4149725-2-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdcae71-c1a9-45a2-f327-08dec254bdee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: tEqf922IzYaghGGZjKbOUfF7knLirvi6PV7F38YelpKUP45/9LsbYZhz7RDPJxjnqOxNisSovM8BzKX/X9l6Q43ChPgpAllKGIs8IPZzv1UlxEGFq92Fzu0Wcb7URgIoaLdqUlugSXyF6+FUXppQ913APlfw4LEiw5S4YvKeS7tuiwOVC42QoTk767Qi/Cet2EzyULznOSM/wyr0x+hj/HnMz4fx/eMmxr8+3kmhSiyrpne78Om5uilUe/K67HLgKb317tRGqJHiDVc7uxpTp5T5hueYzojvRHkJSSI456DUcEKLL1oEHZLweXuLFqVcipnyj3W3JCQPdGcB7WfuYnqJYZuTGWNEZpCRm2/En2gG6iPR5pByefNpvzDuR0hR0HjALNLNUbpVKILKWNh+jvozd7mFnHzFo8tC1C7SAN71xXlPAZ1aQgUu/pIV+hnr26bb3zj2focZYhNVLMg1o+my3Di1mPg/WIkrLB+QVq7VPzWJC9d3Msbq6b/KVSIck/B5NxSvF7geOw0FVjojm4ERUvfD2fofgn0sGEwJl9nHvLzx178Yhr3rcrlqxc6JA0f+cYPfn9pLweKJZlkE63XWQPXH8mQkTxeWGLMcmzOx+azoSG0w4Vd0O+q12qMGtyPtComxb/pW6OZoGWOCi317CHIjU0A96I9HbblxoBGAoO94iA5d9imj5Uq8WO+o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pi7Hqd6VXanC3/mXkP1yaeFiQK7FBeJj6CMTvVh+ueUnBZMh321nCuDJqsWE?=
 =?us-ascii?Q?/b3mpFa9VeAqEzdR+CvOZbkqc4qduSM6zTLH34ZPOR2nW6inLDgm+4dcSr85?=
 =?us-ascii?Q?3VHOJ8rC+nYpERCM+1N5d14yBGrtA6Wc/Onsa82WcGKqfM9SCsImS5e3Kf1d?=
 =?us-ascii?Q?uTOVNOvhWCD1qPTjUhadzv8iK1jO15rrBq275li2kdc7fsOJZmcIJGienLa8?=
 =?us-ascii?Q?WO+FaIbwlhp/p0RYzXPDdSs7Fn4EvXXxNIB3ptYQ9lRKMtSa12Qm9iqfVXaD?=
 =?us-ascii?Q?AiFrRvQmxGRmr9HTmIRs0vmGVhJVEWqV4z+ghvSeZ0BS94VIEanFMtmnbd8v?=
 =?us-ascii?Q?YXmzSRlXDLlcfsbreVN69vSqIDgGwPaeGV3ZE2VdtecJmNTVbeMQH1TIu9So?=
 =?us-ascii?Q?4fd1KQBbcDAw86C1ip5QWO567epWIiEROPzSHZd0tmeXICS+82+5gVI6CXej?=
 =?us-ascii?Q?UsQ4aGlBOOduL6NtnLBgHivvWZUSi0QF1YBF+FaEr7BvPlGndaguRFMjwtF4?=
 =?us-ascii?Q?vSSt5CiXnfDnnQ0K/Shu6IbQypr4tn3tuPptqxiVJQKLTqh8oe3f+N+x+5zA?=
 =?us-ascii?Q?lAf3Ndzd9EBsxwwHxjwWplyqoeHlonQiyijkn6RDIAephb0kX2jFF0GXYRTS?=
 =?us-ascii?Q?xwQK9X+Bq900p6bEU+GKMFaiRYmS7wadd9rnxRmr9FHOYGVLMKhfNCabJMbV?=
 =?us-ascii?Q?bWFEl+rBPlMNYwbMzPJs9J+V5C8CVZimoz/Z6FireIzZWYL27IR9Sri4KofO?=
 =?us-ascii?Q?Ha2kW3VcPGSm0MrXD8qm5dUt/umvnTNXJmyvC9esJBSt0BSXP7CGlvpLd0f0?=
 =?us-ascii?Q?59t0rGKsJnMPmfHkSq/uJARG+22fPD/1dFVH30D/RkPVxvElpu2bquL2fpr4?=
 =?us-ascii?Q?KSGaKVeDNAoDhCrT4T/PgmhC45QhqdV4Zs2QmItQCEyR7t7gLGKp2OIKIg8t?=
 =?us-ascii?Q?F6WvBb2AV1g+x638OcIMrDzPa858SDVYFx41xuE23V26K0AC4KocitP0dHUg?=
 =?us-ascii?Q?EScjkk9ub2QnoXmZHWUgx9P4P81mQL2AtSGVx1IgsAVnOYLM/IkWqg80e705?=
 =?us-ascii?Q?S8JPW4US5L7m1oXLkKZnVf7m8J6BMMt894XVAkp96vhLFO7ecCpZCX8fjPDw?=
 =?us-ascii?Q?Km4b/Oh5pWlGZiIlpk4hAzLcExXAiBvRumK8oHcjq6u5xfsb3HTTVkSMcdta?=
 =?us-ascii?Q?81zBH4ELj7UVCn2AjS1sYpM8EAc/WR6ff/JrPU95PFwldy2x4hVl0sRi7Ui4?=
 =?us-ascii?Q?9DMkSs55EKp1UsQwiUufwHdAkmZWDYeX/kn4UY3dZXS2V+1+dSmhsF5o+1pp?=
 =?us-ascii?Q?O4WEawS7+JmEa1/DXlybCpMbaVAKoFBsvpky0olo0q/mCE+pRxLXmfDEYYUs?=
 =?us-ascii?Q?PjxWFGmVISHEdGpV40Vf0dY8J+qkOw9jHtzb0eGKC0cXaHI8GnbRY59dDqQG?=
 =?us-ascii?Q?P/gF9ACn+zW/Sy0Y+0Dm1P7LHKj6IwRdqIso14Q3WSY/Zz/dhdHhMb21B5rQ?=
 =?us-ascii?Q?7TZai+aAJGUjvAwtklVj5ddCIbQ4dvH8wn7ocFy//jE2CM0kaIS+d54rmU/B?=
 =?us-ascii?Q?04puYqF/7IBEuls3+G8mVCRFbjBQoGCe8qLrCEmeYlWSp4rz8vZ11uUhVpuH?=
 =?us-ascii?Q?istQhrL4lJfznMtZvX+SfZ4yo1HxgcGeuHcrpg0O7fv4HYl1ZCJ8ZPA09LQJ?=
 =?us-ascii?Q?TO3rlrNROHdDlAKTeO1MubRlp9U43JvyxpFiSTxy8lD5ohiFXKlIPPoY4OvA?=
 =?us-ascii?Q?QMuifg+OtSSerpuFF4GqQJjPrqlGVaU=3D?=
X-Exchange-RoutingPolicyChecked: HzkR4rNaBpeGXqIsiwmX8reCKnlgz8pJhisTd7JTBh2Sd5IuF0kcER1h3qKS/9uTzZcBGnsIQNs+PEFrzquW8rFYuHirt/L5Tn9XtTi71HnlneiU7OLNVy6kBbVKgI/7tNUKjpBv4/8ODxlwOutwLjDmRqIa3RDurfuITki6gs67G4qepXipw7umB60PwXQm/PU8GejdsUCPWfnlQsVkBrDFV0ZnzsJR6Dxz0UVQM5sM9KU/VlQ5wLsaufG8B6jVb5C1Shy9OtAJA81C+8UNlG9zGixw/AeYo8OFmnfenM4rwo25Ndf5gJHNVL6p6RwQ2TExqOJHTOonHR3TDg1UTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdcae71-c1a9-45a2-f327-08dec254bdee
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 16:17:15.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ydftYi6mvbhOK900qI0njrtrmZuu9nbnRODdW4AqdPw4dDpq9QV23I6f6/NX6QDpAgAjQ1WlfC1mmaYNsalDtp2XoKida0L494bOqMImYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6265
X-OriginatorOrg: intel.com

On Wed, Jun 03, 2026 at 11:57:51AM -0700, Dave Jiang wrote:
> pci_read_config_word() returns PCIBIOS_* status on error which are
> positive values. The check should be for non-zero values to indicate
> error. Fix cxl_set_mem_enable() to check for non-zero return value
> instead of negative value.
> 
> While fixing this, also convert the error to negative errno value when
> returning on error path.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

