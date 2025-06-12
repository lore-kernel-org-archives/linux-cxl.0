Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D326FDB2
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740387; cv=fail; b=kZN6KWUfviFUVVsU4nZtuCymRC9j6Dm8NpbBoDeG9+lp37gb9BRNVkLvsmX24Qwovh93Qf/akWCHv4cuMmBVr6LuvjcmP8Vafu8/AYuqYV/IuJyf+PcXZaEMGSnQ8pLqkn6966bJZHKF/ZDiq37/wkJpRPAjyLh+qtWKiSTTEZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740387; c=relaxed/simple;
	bh=LrHPff2cUwHupxUZlQQT01YUifLLS9VBW0jsh8JH1Zc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MD7pKk643w1A/sOzCVj8y7SPfDn0l3PxhCtc4ZRwS7Rgjlnn4MGwvLhvW5URoO8shJEqvwLqBsO82LzbnZ5AZioDZeG3QNThMJ0SpxL4+C9No/SO+DTaSWU7v92k9mxGC0XpXG/IqWrwYDpf14+SJo9w0SLwWhrlWGQz0NJE4xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4Zvv7SH; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4Zvv7SH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749740386; x=1781276386;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LrHPff2cUwHupxUZlQQT01YUifLLS9VBW0jsh8JH1Zc=;
  b=c4Zvv7SHOtUw50vWv7th1hQS5nK5IGZYDOkyN1Vk3SQb6ogy1p92lGDs
   6+4rxOlNrzaiujOD2g2TxuS06VaXD8FptlpWNo6LCKNZjQHInpgyAjq3g
   /zjMXDFRNJ97KDCN9R2HRixNbDMBCct/E0Bx3n15OWvUiTpO2G/tez+eP
   dAlcb94do5EBMvvdPz86PIKcLYJ0CirehqcNmqhXnPJ9PbKAavn63i8ez
   +JsPNdisCuMo1mvJY2+E8HWP3+Ut7hxP08gBYQpsZTtObRewv33U6VRmG
   5xyZv2q+08gHHjdrgVZQQCQyZgyeN8WjHuo2I1EZyy3DEUhGXKQQH7nlV
   w==;
X-CSE-ConnectionGUID: wwC0RG9yREugOR1EYizJVA==
X-CSE-MsgGUID: qAnVS9KpRd2XRMVnMWGJyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55727377"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="55727377"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 07:59:44 -0700
X-CSE-ConnectionGUID: N7LT9DOKSD6rEE2hA6mbDA==
X-CSE-MsgGUID: rWHTmdKISyOYC0DxblUgpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152312672"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 07:59:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 07:59:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 07:59:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.50)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 07:59:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFgxpqtu4Bj++EtFl48ennUO8cMJGH8tPUs+M7mRHNQ98XN7XaOSwIdQr73W4OR0Y0IFLI7jvpAZGqQGhnQPy1sFfrb/CaX5PImnn3Gb+dZbBF+omNA3vFJaOrAQ2wqnANNeG1KtmTVWksdq1kZSr/i99WpLx9c2nPVZ5PaOcm0LVyA+1xN3OetxXA6+CWI18+uTk8HYUDNe/XgOiK+kiEFgFoa9+Pl58g6y3YXKNGV+LrabwI8smsQLNAKp/GMPse1tscvCUIO0/QOxV0SP3kwTZJl1jfhb9SRp6Je4Bt3oFqgkMbf3PI+1ZW7U1pLj/vud5PUk8xOzvY4mQ6i4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvZoCV5Esj8Pz6hcU+eq8n1vubotSRF85ntrkCQC/Gc=;
 b=bkIn3zMgwoD6ww1/QL6BungFO9AMBR8bcBXzaiiNTNzQj/n6u0dSnggGaHujI6AAYfs72Cu6dPn1c/7gHrbfOduoM/HQbTE7JRn/kjAtnNYvXExYP/NZ4rUlJngbT74r1ZnxEXGokjHCjhRZVGetZZhUcwS1DecMRlUqH2zyyQNg7ukwJlBYBaj8QPcfDTXarFIU8KM1J3tAmN/sbmkVHuf8xysjN8Nrg1/wyTTwQJ9gy197XvUGxKfu44vUQ8ACZTOJ58bfcu1RtM/PkcgcmHUUHRoiuUy+lb3w4H6Sezlno6mtiT3egQEj76LqiIAJcgDJEg1DNYTo+OlAasIP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 14:59:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 14:59:25 +0000
Date: Thu, 12 Jun 2025 07:59:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming.li@zohomail.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Alison Schofield <alison.schofield@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Tony Luck <tony.luck@intel.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/ras: Fix CPER handler device confusion
Message-ID: <684aeb4a1870a_24911004a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250611171721.2048408-1-dan.j.williams@intel.com>
 <f85041bb-bbda-4b7e-8584-7fcb271a5378@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f85041bb-bbda-4b7e-8584-7fcb271a5378@zohomail.com>
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2cf473-8af7-43bd-53a2-08dda9c1b8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jVYUMC4CamOvs0iLuvhZDP9ggUnDaq/sl8amNzyDEU74aNqVpEY80NHSgfgW?=
 =?us-ascii?Q?qooyiOuh4/WlnUl8ijincLhNtwY6pSjOqfTa8LEUpzdJLb0EA1uphwLC7E/A?=
 =?us-ascii?Q?xCJd5verGi5EAfrmr5iypLNVoAxwRd1y231Egv7YKDSQ/NwqS492Vq9TTCb4?=
 =?us-ascii?Q?L+n4k4dr37PxwewfVDDeNdlM3TN5g90CDKr4zlx8BOffPqvlzZ2K9tI529xC?=
 =?us-ascii?Q?iDAYgQiqNoVbRzZiKl6FYrD9hwbPsm5w3vtAg8YBkFS8WZK9eiLWZaPWYdGu?=
 =?us-ascii?Q?+6+x/e/4v8PuVwAMJdR8y2cVnd8T3DfTGlJIQFyxuE5ZS1JsPv5vpUzsX5hl?=
 =?us-ascii?Q?ss2/InTlUaL3lQ1ypdinI4GIRQ+onzLKS1HJk6PSsGPuwm2fp8PczsoAW3xZ?=
 =?us-ascii?Q?2N65rHGHHfivT3mcK8Y3j1MI5ZFWrS9jaaJse0xbo37IWWN9FbrAU7F82RHt?=
 =?us-ascii?Q?ipavJTdtpMvTgrR+owWr9kKOX5T4CGyzoTadfbQTU5k4ckqlJZ/FTVYGMaqw?=
 =?us-ascii?Q?Lro7DHxsOpP7xH5iJszb/Ch53nQPGVbispl1PJRP1affohRXJFYsY9tatAvP?=
 =?us-ascii?Q?HgVWuoCDs5fDcobg/P+pYdLsDdq0qZWIfPK9gQnRXREVPVcj/KguEFy6JO2D?=
 =?us-ascii?Q?ya6Z+5bqGUjwRRchkIYezs5cH295mh/IzyCGiYs+zYRRv7BH5HrVIrb9ikRc?=
 =?us-ascii?Q?gM7rKE41QAsuaoJsxunQSDusjEZr2kekw1cKV3x/+1Fmmi9qxLfmB6D6CTeI?=
 =?us-ascii?Q?ljGRu36Fm6oDv8loS3usJ64Bczop9VpRwodsbhAMtJRKtGwpX+aFbzJq4lhl?=
 =?us-ascii?Q?1qW/j9MFdLDS9domzzZmgAaHTb5fPXGRhsbVAZOrbzFf1IxIjMwlo6Vifw1s?=
 =?us-ascii?Q?hMBovRhK/0RMRUyC/f6vC2iUr6nibLc+ZnAzjUMK5NhX9S7cdm1GElogC5pp?=
 =?us-ascii?Q?PA0/O0+s8Am3UR3PCdWxfwDVK+Yhp1ZTQ8j4ggHQlJqxtq44DnMLdaEmWnH1?=
 =?us-ascii?Q?LNwmmZ4DlKo6ATc4/9s2BhDLqO81Qwf3YYrm7nOmCZCjiAUZimIV6NOKA8Z4?=
 =?us-ascii?Q?ta/z4o8TM63XP6jugVa0X9D6KfIfQMF26S4kxZiCIT3k5nGB9fNeXn3sgIRd?=
 =?us-ascii?Q?VDigx0NL0zil9hYWTUPcwBZKQgWi5IQZtcCrLjmSgsSxnzIoPkuRKspvnU5f?=
 =?us-ascii?Q?coY9c3KXHonE39yclBqIPG4ErVnRK3Wtb/7HKMUac6/dclW5Xq8mmGN8TAs/?=
 =?us-ascii?Q?/SanqMCJS2KPiv9FM6VU6LJa54cKcz8pXKyW974BMVlw9GVIV2TLhvdaIp34?=
 =?us-ascii?Q?PB88JtR0zpKgwr8K6wKA7Biu7ItKyLn4Duu/m80zXbD+VwRZwh5pEg326eSj?=
 =?us-ascii?Q?P3iioF01Y3aXqg6wPjqgbsBOjuawNz9DsGjnoMQQta8wi9EA+gElVEBycDUC?=
 =?us-ascii?Q?+5kZdHHRBH8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CIQ51ygX+agTN7+34wpRBuGWdkucoQ6OoHFsWKo602Zy8465YrSktKama84A?=
 =?us-ascii?Q?hro30tCU9BvN//cpGHxNm1SU9hf0mIkaIhh3JNcSx2eXOYQPVUIM+xHCir0F?=
 =?us-ascii?Q?nc17avEc+lKPlXNQJY4Rgq9CCWDgla89jBt6VZJrxRPMMJN+xnTLlDM1d6lP?=
 =?us-ascii?Q?ZC/KFn/ip4C6mzZpXUxjIWcZD++9vM+MWfA8zuBi9CKNzirJLfnI4i/rMyZh?=
 =?us-ascii?Q?zd2ie4WLk4x/yaOXJ2y4KHkBBQxTh3oDbzUxeP7x27Plgi5dDLjFuYhRyPvi?=
 =?us-ascii?Q?rbNclF8vVTYj7hj7QqNvUIEinir3m8KTKs/Xvr+nF1oMBQSpnT0LgRMR9XV2?=
 =?us-ascii?Q?wvUXDNW930ficAItmRQ6/LsFH/Xpce8Zzcri825JOZCNh8Hr9heHrUSNkQyR?=
 =?us-ascii?Q?+E5M0+/y3tDI75aZlI/nUKDy2SiMrat3rJSD/XQ0mcf98t456663TPZgqHdB?=
 =?us-ascii?Q?zNE7uaxjg1Ro/1lAMafaqKVXQ4HA91zQ4h3LNNb716st8VoFmumzUpjgS4N8?=
 =?us-ascii?Q?kCAPc0eW1EqRD2pEJiCmOYosZGEKrQhCD0zLe6jz8BbLJfGOFxvWe6PFegSt?=
 =?us-ascii?Q?jvo9pMFUfg53/gmj7melUnXO66y1k4rfXO3/XWON7iK4NU/FQF88L7vZHBlE?=
 =?us-ascii?Q?ODPjk0CBZZR/Ip40DBpr567T77wJ4YlfpCgMCUMN63DNTkDd7Le8VAGfMUDV?=
 =?us-ascii?Q?9QXsNCN5nKW14Sg1BORa5CZz0lFbszEH96cDnvuqorEN8D1lXlOtNMMwnsUP?=
 =?us-ascii?Q?vPvdLg9SGK2dRK7uiIwZTZRNbzzraQKnWSuJuoC3DpD8KtW7i8cu+UEzR9YY?=
 =?us-ascii?Q?dPMhw1Wkf8G7uBG7clcxSYS0CXkaDMvaPmke+cAZzcLfODiU8gWL8zyqVZqQ?=
 =?us-ascii?Q?QHWZ74TRMdcVJlZP/TnkX8SaxPcuBqCg6AmWlF1K9qsDa+k8Anui8ltKJ7J9?=
 =?us-ascii?Q?O7/DxAw20YmDrGdSAxfIlu7RUKNwTOs8bqln3Wv5UOiVttKC5cumCJtETQgi?=
 =?us-ascii?Q?dV2DpU7J0GoEoG5Dnhx81mFl9zTCCLqiAoxHYqP1GhN6Q7k9Yp9eWXabKvM1?=
 =?us-ascii?Q?YxNwICcb1ujRS6MFsX3uP7UAsReyEUX4/0Nd+jrf+VXkV5H2fThRd6FJ8lBp?=
 =?us-ascii?Q?YMhhylL3ZuS2VYQ/A9C/GYbYIOiZX6d41ATivEGDEKxJUSrn8tMRq3IQTrq9?=
 =?us-ascii?Q?5pCfxo2Y0AVKP5S2pR66XMXQsBErl2B2t9DGcw7yyNzaVmja5HVyDbVjAOKI?=
 =?us-ascii?Q?cU0KCGUMTWu/ljQlHVt65XJ3CR5olSY2AUl9BwzqoGzPDExOdHzwZLfVF+6r?=
 =?us-ascii?Q?XMMKGqgsQlCbE+qAZuFQJXKECw5ZvqfYaYYjOI3QrEXcg1oosZlf9b3QucJw?=
 =?us-ascii?Q?2setgxLbJ3xQn/6+DoaInJvY9CmHE9hRv1utcYCqLjmqllcau3g7OmzRKybh?=
 =?us-ascii?Q?M4nBdCG0AIEYDrmP7OCmTnMMCHbElqfK8vQ+ePqO/A45ah1D1vckcST74iOK?=
 =?us-ascii?Q?3mJcMypZ/lGwu8wHKpNl3NVibbIirz0zMPP+OP5LGb5ZmcDY+MVKTSJDCKfr?=
 =?us-ascii?Q?I+htHquizkpiC06wx4/Eif0zGVPkj/dmYBhWYY2cSYHTMKYLs3E0n05/RQxm?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2cf473-8af7-43bd-53a2-08dda9c1b8d0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:59:25.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6mlLxRUpM6MVSahnnDREDo0ZoLLHNCKLVE0unaVLsrtRAcwIaYNlF2fDlj9sRP5vXMpsG25LJ7MVKcIGb8ugFdx1gj7Mzb3rrK801MODXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-OriginatorOrg: intel.com

Li Ming wrote:
> On 6/12/2025 1:17 AM, Dan Williams wrote:
> > By inspection, cxl_cper_handle_prot_err() is making a series of fragile
> > assumptions that can lead to crashes:
> >
> > 1/ It assumes that endpoints identified in the record are a CXL-type-3
> >    device, nothing guarantees that.
> >
> > 2/ It assumes that the device is bound to the cxl_pci driver, nothing
> >    guarantees that.
> >
> > 3/ Minor, it holds the device lock over the switch-port tracing for no
> >    reason as the trace is 100% generated from data in the record.
> >
> > Correct those by checking that the PCIe endpoint parents a cxl_memdev
> > before assuming the format of the driver data, and move the lock to where
> > it is required. Consequently this also makes the implementation ready for
> > CXL accelerators that are not bound to cxl_pci.
> >
> > Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> > Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > Cc: Terry Bowman <terry.bowman@amd.com>
> > Cc: Li Ming <ming.li@zohomail.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> > @@ -92,10 +90,20 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
> >  		return;
> >  	}
> >  
> > +	guard(device)(&pdev->dev);
> > +	if (!pdev->dev.driver)
> > +		return;
> > +
> > +	mem_dev = bus_find_device(&cxl_bus_type, NULL, pdev,
> > +				  match_memdev_by_parent);
> > +	if (!mem_dev)
> > +		return;
> > +
> > +	cxlmd = to_cxl_memdev(mem_dev);
> >  	if (data->severity == AER_CORRECTABLE)
> > -		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
> > +		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
> >  	else
> > -		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
> > +		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
> 
> missing put_device() for the mem_dev?

Yes, good catch!

A thinko on my part that I forgot to add cleanup for that.
