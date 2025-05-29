Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DD193062
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532731; cv=fail; b=b4SS7M34vmx0a29qmUKZiRk3/IaV+0T84nRBzZetmbeN6x8AJY9SD2kxpjXjp9gU/HJDny0NYWDuOrkXphGvuV5VRRTrDHgZNxh3i41FLG0nTTdCQmnRyZG5aUS288plVq6WEQRHkcXS7ZMovn88lwEvoVsBP+2cxp8wi1WqsV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532731; c=relaxed/simple;
	bh=0Plg+lQXGz69WsXOlGE2nsdR8KLtHldwqNa24Uw/KJM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dKEgNk2sBD/Jt6FqDE3l5QXdBiITaVaot3YbfANuVzyxEX64Nsm7LjIl5NGI22fQzPDh/BbbhaW2UxKANHxtpMA4ALpgTxSZa9TsQ0M46yjjJOVUEEcMXZcRqiac5ciLeyBz9XQGZPHxT5lNz+2KcqdadHAvlFcvR3Sqp+dwM+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lT0rzGfC; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lT0rzGfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748532730; x=1780068730;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0Plg+lQXGz69WsXOlGE2nsdR8KLtHldwqNa24Uw/KJM=;
  b=lT0rzGfCoEodD5P5COeJnjdV0UQySdor/it6JjoREIQHLaFwIuNEbT3A
   HSK4ovCmPskB2R3vozyRMwdb0lG/fuhdCSrS2wPxTPdEanMBBcDw4J1kP
   Z0EmHO3oSZQFoe4iw+Yw2giyteE7mZrqAcnMwYKBwlHWM+D2amrGBSPiS
   moolTzj+iVdUpkt45v+paHPyZ5XVOOLc6rJpPnrKuSBDpbC8gEW4y+SWK
   MCzrPoSpajiG+65urcG5NV/sObGYPczx46dt/e0uPSaq/rYFJ6pnssmoI
   sNuvc84nHkMFaaVvQ9XiWUVVrSpWJGtko3950+UsSyiEJkFy6K5YGGxTJ
   w==;
X-CSE-ConnectionGUID: 2TJn0uWBRnewHyxB0ULIsw==
X-CSE-MsgGUID: y1eucoq8SlWyCROgkVebBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50488018"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="50488018"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 08:31:50 -0700
X-CSE-ConnectionGUID: J4Vak5CfSSiFPwuYjpnzQQ==
X-CSE-MsgGUID: e5ViWjwcRZKsqAh8qmeTcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="143572976"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 08:28:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 08:28:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 08:28:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.84) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 08:27:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdzIlJbXA9m0Xs/uUj9ZbvUq1vHW8RhcOITnj+oK5pE6sGICskrsx7K6p1lZoc3YmXaPGyrYCPMr/YHUOgQvieDkqoPcjav+hT2VnvSTejLPogqpr9WYjv5GpjRPGjucAVeZ9eU5rXs/gEdAw46j+asfplJ9aiNDE82156uNVpjIssK5Bqk0qwVLeYL5BRq02CaFnvOSRjob07b6rPWZ71Xc3yDTTlbo16k+TBatjvwv36gFPceMbYRul8T5HFuuby4qxP7u/X3I3BNn/KTPxQSeSeVd/mOt91NqQ1RWGpMawI74byECMqIjBhsOWQ0Upv3RbKWYwk0+thJ1xp9+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIQV6cB0v2zPoBfjNfS3rNC2mRmLXtLsOV+c7BAFdGk=;
 b=B8ybpQvE8LCrrMm1iyM1VhN9Kp/qRfWVB5Kpu6FSOFuIkd+m2AZIzlWpBlpgqJxJHEwyGceXQlLjeKljBXkXThqjOLFdSQiizME4JTvPynDMhSclsnUPXT2DA3RVGVI+rm0NgM5Qm6BJoNnSAWxJF+l3NdULP6+ZO4WS3upuXgBkYbFEegymbC2Y3MM0rVfkXDjqL8+YYyUAJb98W5KTfWKxe/7Dpn+6sQ1Hh61/LY93DEEeQqqRWZQLNlGHJVxtLtGzqrm0qWLAteMy7Kcqt9+ZauFl0Xt8x1sEPw0KUEg8slvCLCueG+ncojBhHvE1atDhee0blkNq3D6FSqfKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM4PR11MB6288.namprd11.prod.outlook.com (2603:10b6:8:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 15:27:21 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 15:27:21 +0000
Date: Thu, 29 May 2025 08:27:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [BUG REPORT] cxl: Incorrect mutex unlock pairing in
 cxl_pci_mbox_send
Message-ID: <aDh80u_QoyZXEVlw@aschofie-mobl2.lan>
References: <0d2af1e8-7f1b-438c-a090-fd366c8c63e0@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0d2af1e8-7f1b-438c-a090-fd366c8c63e0@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::11) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM4PR11MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: f3febd4f-a251-4453-8c03-08dd9ec54deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NE112B4+ME4JWdiMQ5qYk57h1XEy0nOd8HQCMWkBLtq4s2X1BNfSFd0Rvi2p?=
 =?us-ascii?Q?lmp9aIQa9jDqBZKOlmWrwqwnGVrl/ACODgPTucUXVlud4tAQWHF3m2iOWxjf?=
 =?us-ascii?Q?xHaHWhNNqruNQ3RtTFvkDSGBeb8UqytilfC7MmiSOPmzLPGdc2xnEu4klQiF?=
 =?us-ascii?Q?5SXY5tV6QyTn9rtAWbNG038Kdq5+tNqeco6BPYoQ5nXlmBDkKdIVsw7J986w?=
 =?us-ascii?Q?IyjIpd+74DqFxUW2TLO90za5AhiqGnC2Wz3z3DAqwyYxfPUMPqrm7NTeMR6H?=
 =?us-ascii?Q?xaMZTEINiW6UxlNZOXZIOG1fSaXQvj+a9DxkLhRW4fH5IOLpNZvcaNJspwMZ?=
 =?us-ascii?Q?G0YVVUcasNdzSXsxcMcXXNu4LKdEfgzAKztw+tyBGG7zh77irjHuvBpBf0My?=
 =?us-ascii?Q?jvCr14fNSrtnybPIAQkH0IsDsayE9PCI8iAhRpJuclB4tChWgWvaoHnAOxTm?=
 =?us-ascii?Q?WG9tkYx63oYmz554PDg0rnG8Ne2C3+n8zp8JgW7+8PpIxRETafTkuHVnyURj?=
 =?us-ascii?Q?jPPMzmpqZXxRynD7840zVrpCOwvadab03iRfhUrPyhsKYIjmMJUP5yGkrP1x?=
 =?us-ascii?Q?PF3X9PYtb7XVXS38vVWt90HQMF2YCgc1KfAAsxERkkxIRzv5ZatLfr4Epoy/?=
 =?us-ascii?Q?qaeja/WoUT2KCDKuE0NgNdM2CQCCS0G/h4oYomPja/iyERA/l2FT19Mv2UfV?=
 =?us-ascii?Q?tN31zJUNj2n92omW/tLkfrHNQLD+Y3H0bIQlFLEJBuPTKEH4T/q8tGG2Gcx5?=
 =?us-ascii?Q?5Lm8dWa0DRiKIfBuRMIEt1CjbrCSCq7bgjuXKy/KSanv/6IwtidAvhqTz0mN?=
 =?us-ascii?Q?QzWnh0sv3OLipPtgC2MY+Mnt4drIgnb0wcWPySy+9c3xPqmV8bmxUZj4Zn3l?=
 =?us-ascii?Q?tjH0vbF31hSWVADGtycRHFJcC4aK+FGQP3M2gpnGMLslVrWdgvki77mm9e/u?=
 =?us-ascii?Q?rIjo0u7BAkXCMo/WMNtgsAMpgVFAf7e4k8bZpXD3GAWmM59k0ztpjah19WO+?=
 =?us-ascii?Q?1c+o6Qsfoo7JvLOKLh3S61c/V8jXiBLN3tFJui+EJDFbkYrz0Y5fTcaH57o2?=
 =?us-ascii?Q?gulycOamjl9rv4hlHuUF54u61YKgRajcw37Pl1vFz4AeWO+Xn1Zm++4jfzsI?=
 =?us-ascii?Q?gWA8+KJIq2U0/ek9zvExmqUS8bIM+BUqy+D26qw5Rk2UK+Q1l5pSJ8Guwc08?=
 =?us-ascii?Q?ijeVqe2cAJ5FUPhK/50OpogkZWUIBGNjVw9UABwODTrGQQ0Sq0otg3lQdOMT?=
 =?us-ascii?Q?dBCZePNC+iYhYpFFUpefMT4ebDM4f5GoyF+Y3mVz3GKPf7xYJf6U3sDOgW0q?=
 =?us-ascii?Q?Do5vsZHZQYidkewLRm1MyVr4KYpdkRzqajQVOkDKZWIBlU3aTHk648qEExcQ?=
 =?us-ascii?Q?nEl4lQSrXidQTKTpYVXXnVa42IozvZthk8ViqvkSOW9glTfTDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XQX4CEU84/u2xaC6otxGI7cwCU/WvrYcsPbgSUqQkfaxDX1KhZ7Hs/7kHERV?=
 =?us-ascii?Q?omVYMZsQgVBnw4D/1sjbN945iA3evgcCGPHI2DTZinM/XY+MsVBfF1ErrSI2?=
 =?us-ascii?Q?NGBjWiQPnW8U+alUMOEnHaY2ejCljnn+xtmDJQTIpmVnAEh/bGZ9ZM/Kormw?=
 =?us-ascii?Q?4uXi4YplCih7no1ToschbozoUYQSIvb4czBpuN2rnkvBhLt+Stsmbd/HQ+as?=
 =?us-ascii?Q?/pLU6zgzrXE7eKSHpfcQ4BvdbQjxireyF3STiWvbL6LxkqV6JF/S+ZsglMKR?=
 =?us-ascii?Q?C5DPi9jEqNgWhU5aB0eYzIDFaxm8rcUNuWKapg9cWsAnQBYzE6DzpriaKo//?=
 =?us-ascii?Q?rk9aQSfPfIcYK/HpAS04Wxl229deIuO237eNXUUa+St1TB4xn5BAOORzri3j?=
 =?us-ascii?Q?nIjbGDyMeRf+R5cX2RQnRFCeKs/jpnU9wgaZsBrgOPYBss0kcwR7EwnNVBNL?=
 =?us-ascii?Q?z54E5R43cAZ1Ygl55/HEA0zB7QDmgeG5/6n8nY0I31bMnPdQnd6bhNhhk24B?=
 =?us-ascii?Q?eVflCbYPvV3MJLUql1JBzCYx9WMRCwjE/DYC4Ti+w1gKukpXa/sQeVgGqUMD?=
 =?us-ascii?Q?GBrVcecoKtNgIfACFAwuKT4p/ChMJp2VRFgWWsq77/9KBxbusybowtVZg5z2?=
 =?us-ascii?Q?t09YFWsz3yLzcypXxOaTSHZVVbZWmg2LDfYoWmfBNBkQetRNDSLR/bjXrdzC?=
 =?us-ascii?Q?W2yiypkJiN7kgfWGLEx3KSp6SuSMc+wCKSCeO55S/bGgn0gNNVjHQG+AzFW/?=
 =?us-ascii?Q?RoQgdthvsYOAhxWWIjrXmpauTxNerIrrGz3UcuyszePP69M4acq5ZA30L8u3?=
 =?us-ascii?Q?7YdVKzSjOEhewhCYu6j3fLuUMYCv2IlzinjaVc+/qAlEP2HAgddHIDOzdFvN?=
 =?us-ascii?Q?mZUDhItzXxwe9V3dKUWNZRCSPog1V2SULN3FbicuEdQ3pQdTIn2Fw8F8z3Bn?=
 =?us-ascii?Q?NIRbSccUkpYgohPW8kg1aPZEcFZpofVrVCC0fOMzsbEpfkqYo5Q7gp/ow7bq?=
 =?us-ascii?Q?e1/mk1Xh6egMI8sODxfhBl4R1GTqK7ye2/JKqgTG+LjeIdurR/Pf/iN8Yim4?=
 =?us-ascii?Q?IlFrdTYoPesgGQH0vQT/NypSXxnQ63Zy9foJIv78mgWIyZ7nmjINLkYR7Bcr?=
 =?us-ascii?Q?MhO3cTVr4SXic4NQX7jjYulQpE+aS7unNi/ytsEDwaX1nwijLkEUF1/zuM9a?=
 =?us-ascii?Q?HImURTvGnSUzYDeWHtPgcEiV+WPZOKEpL5R+8lvRUZpA85UcsOIBK8VSGg1I?=
 =?us-ascii?Q?nf30C2NRThrxc+ET2QDbLtOdaKjdgTLomAJrnKbeZ4hPI3MCFkK9FXJ8/VnO?=
 =?us-ascii?Q?vwxaTnRTRKVpUFhhHTdx2sJVx8maSpCCaoQkfDEDu/2wKyQ3hwQ0Am+N2m0X?=
 =?us-ascii?Q?5RWv57G0BpkXZrzOWDFKnZEukoHzTDQ3v0CPEqASx2VpLu/JZADIqnbTW8kb?=
 =?us-ascii?Q?BCf9t5s5HMK+8C8aTJSg+5xTuCwt4ZFnSNpci5MUtRsjDQm1TBs1R6VLHCAF?=
 =?us-ascii?Q?THDeUxJbEsLqA6vBttNjRa3yUdZZEfStpa6+EgVGWIwEq+PNMMGBcFDWADbx?=
 =?us-ascii?Q?3MIcRn4qDIFtyNa4qtOOAVQgcwjrhVVqmuIe9TR5Uo77uTRrXbE7JqasotTo?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3febd4f-a251-4453-8c03-08dd9ec54deb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 15:27:21.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31DpN+bHB3wqYhkhjaAaWbFEalg+8bS8iFLcGLs6+6m1obL5SsTj9bryfvvq1KMaZ6N5ApKsfHC81Ep69hUljIZO+tfh6wg34KRm3DHbxvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6288
X-OriginatorOrg: intel.com

On Thu, May 29, 2025 at 07:26:58PM +0530, ALOK TIWARI wrote:
> It is locked using mutex_lock_io() but unlocked with mutex_unlock().

Why is this a bug? IIUC the pairing is correct. ie the unlock is
done by mutex_unlock() for all flavors of mutex_lock_*()


> 
> drivers/cxl/pci.c
> 
>  377 static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  378                              struct cxl_mbox_cmd *cmd)
>  379 {
>  380         int rc;
>  381
>  382         mutex_lock_io(&cxl_mbox->mbox_mutex);
>  383         rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
>  384         mutex_unlock(&cxl_mbox->mbox_mutex);
>  385
>  386         return rc;
>  387 }
> 
> Thanks,
> Alok
