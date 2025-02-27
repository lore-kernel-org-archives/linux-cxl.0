Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19808197A76;
	Thu, 27 Feb 2025 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671857; cv=fail; b=SMSzGCv65wRfgW8ONrvps5+/OpnsMf89wIfWZjDNe9FNNEpQ6hQB1SYhI1ENVSdhHmsC2VC0p+x5c2SvDnrgyDFShpxX6TgPnlfwUoqnGj2rjX+an+4L7yXprg84W5isjBjWSOPcXK3Ov8yj9D9yYZAWmIBTFNHOSDlFv/VC+So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671857; c=relaxed/simple;
	bh=3kThPrExOjhdXrHa0fA+3qIkGP+WZHMqjl4f/H3HSL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DzCt4G+7RhDwIBuPEoQxpQ4QONng1X0SSORhXN8cIShFr9T1Vm/hrNGl0gAriWLbBVvYDGOjHIZjlS/lMH73BO1htGVosG4Y+MeBxP+eZKm2NZ5QwsXi5Cm3FiyyFxenBddysfbXophFMtyW9Euck87s2amPy+Wwx5hlKeMrID0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKBE7wrM; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKBE7wrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740671855; x=1772207855;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3kThPrExOjhdXrHa0fA+3qIkGP+WZHMqjl4f/H3HSL4=;
  b=XKBE7wrMjWlsAKiDIgw+VzE6GfTxG2nyjBmotQp+h+lvtuml0iwWQu8X
   zsQJ1UfTICK2hrD2SXTmC3ogpnK9GkBOkPp9tGKebbd2Zl/YVgmh5ZJeZ
   17Hcbmds922Ucu6M4IoDY8tFPSOqckczPFLBtpMd4f60mBk5pUwBb/naF
   8hLjDpP6r8fQKN96Y0ZbZgl8uv2lmi7nT8ks6ef+BHQEVRWfT5hcE2Zj9
   sHvHZ1p+WuoGEgAR3nHz5mBg4p6+UW4i+krttDE6cZRoQbaRdKQ80tPhG
   55vJAcaYba3+JWxTycyqPEkl7TaKvnL7aum0QfOStBurLOFtR8fnjgxpG
   g==;
X-CSE-ConnectionGUID: GgsLu96hRUqcQVc4XaMJWA==
X-CSE-MsgGUID: 0rOoBJnpSzahQ4wWXZSv1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41273974"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41273974"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:57:32 -0800
X-CSE-ConnectionGUID: +UtQI9MbSxe+yUPlzlyYTw==
X-CSE-MsgGUID: Fv2jtx1iTfmZSOG+WI7XuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121190517"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:57:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 07:57:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 07:57:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 07:57:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ykgedm6v7aPo4+Eg5yGeBBQFmWCjtEPouxOP9St7gqA2yeSOk2QW1C88NSW0WgSaKvs+Ks7LJgiiFDZPFNlGEqKUXYc3QXCJSVWBPjaWsMItScG7Utu9stAicaclTQc1sFR3UYMD/mkNPuT2v3De8829AvjQa2l/4NydySPWqIrN2y7ziReB0b6jhbqd5ZSHSPoc+0DCKbH5RLYfsx5at736ZyrlOlD0sHzHqF4K+eJXuXFYOi5w/ysHFKaH+/HNLUu6cfkFR72fLkjkC3iUTs3Mgjtr3x8w6IFyjMmiUGOqBZy8yIpOCnm5KlqjASiRshoyzD+ig1SZi6iEPy7IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2/BjG4O/yuZoVH6tafylqq9jZ2JFw1LJWmICPlrFn8=;
 b=OoZ4UZnZdx76c2FUj9TnQ0d3ENdaWZD7CO7Eh5iXPYF8InKlqj23byXgiK9KJUsYbuUMvmsLEYv+V5XeDlah1M+ZagK1WPAJFVLFbX6tmTer0gMl/qfwClR41QWezFIGvxTuswa1Os0vFtdsaA4q0aeSxSXJByOO5Iw9QLpovjIUGKykYFJE1/2+Y9Gph9dECmSSbDip6uAx9N2Kbb2ub6ApNJGPR7WHrUXTvMzNJ2DSpwmNKdNZLNdBCujWEJarKsGtJ3R5KcicYJURS6osCVlEqdXAWdXz2xCdH00XDmAcpqtnj/usHf6SqHa70erFrQgE05pB1dgvMYXKLIp/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.26; Thu, 27 Feb 2025 15:57:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 15:57:09 +0000
Date: Thu, 27 Feb 2025 09:57:12 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v1 1/1] cxl/mem: Do not return error if CONFIG_CXL_MCE
 unset
Message-ID: <67c08b5857c0_b295929481@iweiny-mobl.notmuch>
References: <20250227101848.388595-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250227101848.388595-1-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1ad2e1-3986-4cd1-419a-08dd5747647b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ak1dm3n2NXzXZMJ+rEPgbu5xwEyImNPkHNt7kq8Qob0KdurekVq++e0JO649?=
 =?us-ascii?Q?dph+5/onAEaFyebHL2Bzbi6YR+XfVWft4XTFw215LqHxOez7hYg1xrUk4vEM?=
 =?us-ascii?Q?xfTDJnKW9fvpJZqju6sDwY0M37KqqPBpg1IfPRTrdpMVb3SvB6S7iyI7zpAT?=
 =?us-ascii?Q?ssYcbKN+bvrO32UOYQgdFe6gK5zda05XnwvkElWZBx5vcf6UYnKUGpaTvvra?=
 =?us-ascii?Q?mXxi0eqS18+n5ynpiyOorqX/6bLabfOwlNNULw0SE1UZTqhIy34i7uyjqPzq?=
 =?us-ascii?Q?mo3i/0LUjvth3myxAJeiVVh5MiXMeCAj0Y2oCs8ZAAWqhCzxFO6tbMM3SaA7?=
 =?us-ascii?Q?mthSA14ClML+C0yE7HK/2kbD7+lTy+tU7HbmDavHwcis6r+bjBCzEojDROv2?=
 =?us-ascii?Q?1GVrRbZ+Nhj0NHsHwRgF57lY/Mv7odWHUPLtiq9E7LUz5GJCsW5Ilcp/c/Ku?=
 =?us-ascii?Q?bn+rbd+xA8j5Il6v73ph0f/RyRbJZItrNGMmlvL6Ox3HNRog7zldTG4kmjGo?=
 =?us-ascii?Q?I5K3TDyf8wbMtNGE2P/Fgx25InVr8PDNVcvPlY5Jm4DfB8kvdoO5ttXOiYIo?=
 =?us-ascii?Q?vG8AXOthEnJES+5BnVJjqLpwNVeMkId+puuWj5YtkbMj/2B/+JSV4uIGa6qz?=
 =?us-ascii?Q?byaj0PLLRCjE9guOCxjC7WVSQMJEv6qOtYzmWRdGh9qNUQv7yFU7X70rO9nP?=
 =?us-ascii?Q?/AQIh67KvZ5E986xdzDl11FRMXBEGfo8nzRtDFQkNFHZ7ySU3P945iCx91qp?=
 =?us-ascii?Q?CUJAFC9JODfo5nnaPg/y1asytfyzWAymUG7lDpw60bFyfTGGPm+mYgNbTTrw?=
 =?us-ascii?Q?0qIrmyRMrYqqP5MF72zO6qA1sUAIPA4MTurV5yXln3beyBNkajKnai/mD705?=
 =?us-ascii?Q?P/Z4RcZQGMfWbxuBlnOLO/tjrMcTKKCjwr6o2Z/8kD5knu02vK2ZBebPSQuD?=
 =?us-ascii?Q?F9JAVOYIg48bbl69tmnh9kVgr1uZm0+0+Rclu09MpsdiLQkLd1EKwkDE9n4N?=
 =?us-ascii?Q?n21WkPFG7qRt3sT/SNx/JyhbYYIcdeXWs/MKprPMMbt/HNnND5o8wHw3uTCe?=
 =?us-ascii?Q?p3YGb9UfGhnbQ79Hjc0ys5QPgIHZRodMPwruXoAcDX8qtMQ1mgzQfHzleHjz?=
 =?us-ascii?Q?Dlsg5epwzyGzRYJqf7zS2chKr0VcG2ej0saUxNh++Raw8iHKeBi0B90F6Im4?=
 =?us-ascii?Q?iLgsAh3tI0A/qne2k4Equ0k2YS9AG8X6Z3pbZ0loNE3fv6QqEUvtXq35zv8I?=
 =?us-ascii?Q?Mtz2sxUCS0zaxYg75ekV/U/Aw+eCkEZ5uTImLqaXrnJXcxjfwBr3Hsz374y/?=
 =?us-ascii?Q?uZPEdKjY5nI94wZAJTviLpdqNQvl51onzdNmyd7n3YiBXaCyi0AcAJ+eZHTv?=
 =?us-ascii?Q?KgdfnuziENx2VjCvAEBmBAMi6agW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0nR/mxvKihp6Hu355+PX3p68MR+f0qKcdXqzDIvusxxLX3L1Bg6jo+viQ4uv?=
 =?us-ascii?Q?0lPo9GBurRcDi3tCKPsMteR1idnz8PMYDD5nhcNX1cJq+3hFJOuo6tRFKMIQ?=
 =?us-ascii?Q?DGLZ9CRrxupc9CGSsm1Xzn3q1m0NkDVL+B97QBrkLoozPfQJdy+q00iN1BRW?=
 =?us-ascii?Q?xdXB4CFK6kJ06dSPxwzngXeez4W1WJDHSVLTa9V7AclznODnqyGc9Neg4KNj?=
 =?us-ascii?Q?S/EiGMm00axurvZ4/dUI4Nm2Wy3Czn7s13u5eTtav4dvxZZWIEqu0em8PJPO?=
 =?us-ascii?Q?NkrgOGzlRnQIpRhT16YghiZXcsKgyUOVIl/huqyHvcsp+lvL4xBcM68yT5fL?=
 =?us-ascii?Q?veHttgLB8+HxTY4WKHWQwT4B6TFTt1Sa5+EeijVXUXvgEB6y0M0UqN8o/Rpd?=
 =?us-ascii?Q?Kcgoy4SINsnCdDruy+etUg3OC1wDTaPc/FE8KA/TyFK4zYiarUfUWwCZQSWW?=
 =?us-ascii?Q?bS49+7iDPNrkuNfyFgcwnNlVQ4wnJxPp7oKXci4YVAKF7is4/m0QiVauWP20?=
 =?us-ascii?Q?/tpxsu6z84ioF73yb/eDSFku13wlbT22Pzeo1X0fMZSgFqOtye5wPdFZR+JQ?=
 =?us-ascii?Q?K2bTBFuAkyQ4fM9VXiRbG4vFUlFLXLmPXQLp6gfn1P0Gu1mPU3xMOf01gsXi?=
 =?us-ascii?Q?5M7kLNzP29LbhSXdKKkWhlRwJGnTwf7Q4PSYKRnbombSCa326Kne4drqQcDP?=
 =?us-ascii?Q?eorvWdOT1h76z80etenqsBCI1Ha1HFOsdwZIlUpu9LGNRe3l4VNPEHNpxcc0?=
 =?us-ascii?Q?4P00g1wfchBfxtRTBxf2Gk1AHWTMKnrXK00PKlgmxFdoHGtvhbrDll6BisBV?=
 =?us-ascii?Q?tgZ7+Yaok9bLpWRk9GfyI9xCeOmiRLGXXyt32z2lPMFgnZvUqSsHX4LKgKaz?=
 =?us-ascii?Q?i0pD+CjzOSE/uSREhTzqvIxSVh5xPeVbYPaUKXwSTz4FnSo6B1DAGhCbA6yu?=
 =?us-ascii?Q?AqPCLdCHIcEbAkDyWyG8vxX36nNFGqoxXqDGFP1yhjOWnYBqu4Tj/6QPne8Q?=
 =?us-ascii?Q?S6e+l/Weyvk4DZKdj0wU/qH/YpU1ZbqGLH9brVkMSFbUpgn4gEVO+wT8x0AB?=
 =?us-ascii?Q?IyRRPEZiqcD+mgWXXmx+m7qE2a16abxyCN15hQ97/41qOtQhgIBRy3xw+3f0?=
 =?us-ascii?Q?mx6qOykzLNrxdm1iUTpL9gOVdGDzYu7OfFs0rECTsaWa7G8zR26YmtXyCBWQ?=
 =?us-ascii?Q?yLU2IsTJTmrPZVmBY5e0++391F3nDPRBCKmRYMSuAJDr4+4w8tKePx8vdkQ1?=
 =?us-ascii?Q?2R+vrXAXTa/6IcPg+hiD3Tn79amYJ5ISU6yafqtGq9XIA9yRUV2R29YvMXNq?=
 =?us-ascii?Q?Lcv+BTXFJ1+zP30IsEnts3Krq+VtZPx1ZQh+wr8elwwi6GVoXuZQ7WiWQi2T?=
 =?us-ascii?Q?0YXvkx17EFkKSSgX+38vzSFqpaQwiffJ+vjHDh1LGhE3wWb4kBh895gvVpCy?=
 =?us-ascii?Q?s8sLq/vOJ9AopZip0H3bHgJMUAEXHmT6BLVOcMmME4myiFPyTXwp6H09fgML?=
 =?us-ascii?Q?DPnPJi6LkoYZtgprAlMwrFjtD4f5+nnowL18iQMeaJMNkwqtc0GTX8Z9/AaT?=
 =?us-ascii?Q?LcAT/1GF01Hs/zsSMPO9Mtm154F11Mg0XhvV1UiS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1ad2e1-3986-4cd1-419a-08dd5747647b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:57:09.8302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyGpuEcTLbU2Hf/8+fq6Dlr8bwRKUT5GoJirJcX2xEwA5u1SvIQ7g7DKsnQs86hAmTgQYBAxCrYkJ/haQ6/GRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com

Li Ming wrote:
> CONFIG_CXL_MCE depends on CONFIG_MEMORY_FAILURE, if
> CONFIG_CXL_MCE is not set, devm_cxl_register_mce_notifier() will return
> an -EOPNOTSUPP, it will cause cxl_mem_state_create() failure , and then
> cxl pci device probing failed. In this case, it should not break cxl pci
> device probing.
> 
> Add a checking in cxl_mem_state_create() to check if the returned value
> of devm_cxl_register_mce_notifier() is -EOPNOTSUPP, if yes, just output
> a warning log, do not let cxl_mem_state_create() return an error.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
