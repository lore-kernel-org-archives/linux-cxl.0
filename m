Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E41E1308
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699164; cv=fail; b=qkmKgY+EaYF9G6ZH91KyFPANfgsrwEVDIm5kC41oUoiheONnFY7C6HYxQCCi48WJ+oQY7DJzVUVwVMsYowUxIX22uLdFnlz2JCBrF+OwtMt0HptYYruNkKDiTKWjfuJbMXXrI08Yq8Q+4qzD0Fnn+t5x5N3E4BYPvyvc2b4K4L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699164; c=relaxed/simple;
	bh=GB5C9n8bYkKI6TokI7kCvVlGzza0bKrn4QxUVcgSFlI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2wr7nDQH8hsDbKoX6+STG3GbZ4qmy6be3yBhqAeebupkymLCl/9go2oBISJhQGgaJGwkM+kX7lL4EHYAPGLiSW0A6CPKYr0dAa6QPH0ylKDZtT0bOp/ezsxiyZZRC7cFv7wVJWfTmOOqhPx8kiLbrf+Xiy0qOulX6qFyjcWxps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsCmNxKS; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsCmNxKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731699162; x=1763235162;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GB5C9n8bYkKI6TokI7kCvVlGzza0bKrn4QxUVcgSFlI=;
  b=UsCmNxKSJ8FVk2TF4RvHAHvOV2EigWzQOL4TGMKYwW8sB5vbbcPQdWuU
   eGUzHGn9uRV4hlwT64tOjwj4lvMG5uwtJOJoqFTwqnYNu3C1LG8u/lNAL
   fknL2Dmi7YggDkHIS4qFsv/b3uc5Yk7RP3XxmKZ2jMpoTZaINagfDr3m6
   M/d5ZoAb5EnfakTCn2xInIr3i6PKPp1Rqds6pIl+lup+YdqiLMEtR82mF
   g6JE3w5CSfxJ42j+0i4FXL/JkYoJRbCJ9a8A8JF/vv7VuTS/+Xy8vRAmq
   OTVw0acTlyvbYdjcClWEWis9z9bE1SWkxFJUg4GOUqshsAR+LykJfmcgn
   Q==;
X-CSE-ConnectionGUID: gbhGnpmgRA6nkMUASyO8iA==
X-CSE-MsgGUID: uCQt5tfOTfuXzueKbwf9fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31561104"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31561104"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 11:32:42 -0800
X-CSE-ConnectionGUID: Xq/TmAeQS32SOsbyVCOitA==
X-CSE-MsgGUID: XOjKWGgNQoyIIE5+drNN6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="89054831"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 11:32:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 11:32:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 11:32:41 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 11:32:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSv2iePQLctdBgkU2U/XtabKwZKizG9FcsmhgTU1uR/9oAoI1gZbTWzdMWq1oU1aTg3fXV2Ef+9dBTx6EMP6SITpTzJ16vZ182eWo1RSGVI7xtFddfKb+zRYp29FVPYoExc2BX/egIwhciHiYDG1Q+KbGfxf9MxJEQSJdv1vt0Zu7Rq/R7TKC8lwCzjZTp9Tr9vrJrfK+Pfngz1kg8VBrgq+ChO8rllBbQilaw/mkEhHVCMtnzPUpLxgxsSo6v6vAucPulap+yn0zqXsfqZSMxDXiKMrQtdaZZMSiI/2D/EG0E7RvYSWLhCH9a0FNjsnDZvbP53DvtRswt7kDT6rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta6B62D7UV4i6dDxToVSeoHcgMqmvTpTwxsNwOhc0oI=;
 b=lZLFmw/aVBSNJgW7+RWgirNaCWQ0IjEeGI09AptVpGSzDrRSf7Hjk9RdJCm0CWPmUgiaGHDJA1pC1HPk+x41ILVaHRmfN3LUswy7/veCURbMKXmo+GzVsVqec79n5fzk2ojvvfYrmqcq+J3+0QbpZz2FWWAEFk0fQkcWC5Th7rduh+nic22onbEq5aU6pyfSm6LpYaWX4fCitXB5MWZvwF8Tdfv9M/pBJ4kqsY7rStGDAadOWWOWP6XzpPwIoQ7qnai/vcDhrnudHArTLVcBmWqma0KujlmfHgsPf8JvsEoFc985fnX4PxWJeiv48TgicjfKHeKbvdTFtaR6c0XcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8465.namprd11.prod.outlook.com (2603:10b6:610:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 19:32:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 19:32:08 +0000
Date: Fri, 15 Nov 2024 13:32:04 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/pci: Fix potential bogus return value upon
 successful probing
Message-ID: <6737a1b43a3c0_29946a294e6@iweiny-mobl.notmuch>
References: <20241114213439.6022-1-dave@stgolabs.net>
 <Zza4YONsVxWa8rpL@aschofie-mobl2.lan>
 <2eau46txsxb7l4fgmaeope7i7odsjbipjjsjc7mvjiqzhg4llw@iiobkioccdap>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2eau46txsxb7l4fgmaeope7i7odsjbipjjsjc7mvjiqzhg4llw@iiobkioccdap>
X-ClientProxiedBy: MW4PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:303:b9::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: c75129c5-ae2c-40a6-296b-08dd05ac318a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i/04avWnr3mk3rzC6r22n4TzEoKsGf62sfUdQdmac/QLkK4upmZ3wfNg7i2C?=
 =?us-ascii?Q?JNR1BOGq7wD9RZ0yLZc9BnOlkNa0gnNLa6VlNCjiauw0VN6roVlMu9dahoIq?=
 =?us-ascii?Q?RE0vbpItTfXnFv7RmSyZRZqoIdrb/wnxC684+K98qsWX9NucPY68hFm4WhZI?=
 =?us-ascii?Q?jCf6LBW7JjUhrAVTcdp/mIG4XRj1TkRFcAPqb2xky39fy80cyY7vLBu8dcTi?=
 =?us-ascii?Q?/g3wG9X4lQO+BYpFh7U/CWjjWyea9/CPcvyynMib1smFxHZK7RvITCtRVUHT?=
 =?us-ascii?Q?1nUuDYOgyEca0VtLetwGz6+OT9YieU9/5zRxAygefrwNFPdtIX0bgPjfIRq8?=
 =?us-ascii?Q?d2Boy5ytT5GdLw+HSxZjoBfGPYeKqWNyRIy5/l2YF1D5GAtVK6swRwb/5FCd?=
 =?us-ascii?Q?FipfH9E0pBSi9wlJDDb103CFt54KQOR8fHfT9K4wWuDb5isJvPWIs7IVdWaU?=
 =?us-ascii?Q?6XgXNdQY54jtzbX3bas/JXECyXiZJhJkmsp7CmWlKtW8PFql4NGpN5P8j0bE?=
 =?us-ascii?Q?8LolpOqB+ygjmzEragX3Y4XehFjAE7X60UWNaJ5j3GgqAKePWXBviTQN5sjc?=
 =?us-ascii?Q?xByZ8ozXACfakZSUa26r8hogbKFJ28lKan0B2XudY06y+XYP5goRctT1oGSa?=
 =?us-ascii?Q?l7041uNVOgUDnunpCCseUlOyLsM5hc85Wc+tJ7DuRrPnauhg9dgfDJlt8nXE?=
 =?us-ascii?Q?wRbzdQi7ZIXlJKcfht/GeRQimMJsqZbMlQlr+EgTq3+CLCUyRrsnIBzM4JIw?=
 =?us-ascii?Q?OHWPN/GEJLpNTYt0QZhTciJtmeccXVYpxtz+PluTJIKJnfe38Xd1RrfWh/qF?=
 =?us-ascii?Q?p1UbRRsNBOHWdEj7RU+RCJ7iGgmKghJBsUxjT9xMkHffO0FhGCn92ralfiVg?=
 =?us-ascii?Q?RwLqowCP1DeLAIkpbvip7q7RTVfoF/81qrKJ6vmAjvxmxEmXgPT47Bs4SGJD?=
 =?us-ascii?Q?xHKV9R6oEG1d532qoph1bQUVDWBJYlmyJ+MWbkaenyvj8LGkLeID6JWbu186?=
 =?us-ascii?Q?HBQjxBJ7MttBX+Bc7/mma0XqovmQVKMm9hb+Y4qNiH5Mx2m28Vp0NkNc5ovq?=
 =?us-ascii?Q?Ilzud92bEcJQJHIAmfylkrOmgBZ6rV52jQgCjPzNhGLH0VEQii+KTKvZdF11?=
 =?us-ascii?Q?x7EAx6TVrg4oZV4O2CA88eUbuvXFwQR4TafHr+SzxIHqRAFlfewbYKm1OeG9?=
 =?us-ascii?Q?FKSdSQLvhvrkAByKxRTc1o2fcRixOmH8bo8DbRDrT+uSsw0/PxlV+GPSnYWf?=
 =?us-ascii?Q?Sy5S+/C0YgZK1L2cViPnHizURt4YIv9v53Pplymye1UPguYHCXT0DTbEomT2?=
 =?us-ascii?Q?dP4rARqE9ZSrwGOIUxwhIhla?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jaKQfQrriy/lgIinTG8wBFX0GuNQSHyaUH1ThcUrqqrYn4Ppkm595+hrbpw9?=
 =?us-ascii?Q?ZSUgnKvRKHNZ5OR0dIq6pqIcuGMKxV2NmTk/iKMwcLAY9gOMW1jopHIVaQYY?=
 =?us-ascii?Q?4cVAWXwhvysf2H1MLQBMR44gKn/IwmrjFjedzg9bffLaglV/Tgd5Th+czVe1?=
 =?us-ascii?Q?x6f4p9ZohVj/3KHGgGg62UNHRxg8bZCkIlAoSvmAVxetCS2mIyBc0fd9j23o?=
 =?us-ascii?Q?UmOHNvgRh5lh2sd4KNxYInte8iY0fxLwNIbdBaHYcb54ll8uZPLKBSvuJ3RO?=
 =?us-ascii?Q?ItfS7EtWCIuf+bF15hex/tx1xc51dIly6lkn6U+lqlSTvao+oMZZ6h/XVWJq?=
 =?us-ascii?Q?POGjf5tXgaX1koJyOxlT/YxL7UAlOiGlK5meTh9zWDBC7GAZhP8ahdAZEBCK?=
 =?us-ascii?Q?zKe7w2EPzZsDJF0SW+7p4eXxIIQVvQRMLcz9sTN/hCSmRZU403RiD4qgdWnM?=
 =?us-ascii?Q?lg8qIMYMqOQ9e2JR9IZGWQb11XgxJpnuovmePvC+OG5pGjRfXyEg9inPSflL?=
 =?us-ascii?Q?iIryxqaVcF9lF+zMd9HazXYV5tPSHV52DfNDz/nMjBn6MHMpgIjrWStMPD8Q?=
 =?us-ascii?Q?q8l37aeMB5wMuuYSaG7E9MKf9liMsyXius3kViEBiQQ3L79YkA/v3qyDs+QM?=
 =?us-ascii?Q?E6HPzbJxLMBJeoQYR7pPJeTcaOfxMRMmoHqLbdHadPGpGQn/DRKI8PlANUhI?=
 =?us-ascii?Q?ughSM/rg8N3yhi39kPcs4R6S7I8MJKUfwQqLurCcICVpo4cwczWjNNrSR+Mo?=
 =?us-ascii?Q?N8IvQ9ez/Mn/4OKpLWxFNFuM5YyZk6r52xafTvi5q0/SoM5h4CARIiqfK7Dc?=
 =?us-ascii?Q?3sXGZ3ZXyRm66R/9nGWn2vcNfxeyrFHXgAUX5i5qNMhtYxPM4KejkxFB7qwI?=
 =?us-ascii?Q?3eLxs6Wlu+oZfMlrlgD3XaX6QnloIBbxHEsKnP9kWFhGEGnE2aZqHPwHwUg/?=
 =?us-ascii?Q?fB23j3Z62K6hfvHa3kSoMZ5uMaNSo2+Q1EX7QeKmL9283xPZV4YOTEnUBIqf?=
 =?us-ascii?Q?CBjoBILWZ1U2ddoX2jnzzlzmD21p+/Xc4XQUO4trbZMLrtgNmD41ilm9x646?=
 =?us-ascii?Q?HY8w5qDs0sXBhgN99b8GkPcKKNV8PdqFtxMolQHboxekv2CdHwbjakdvKX+q?=
 =?us-ascii?Q?wrgC21X7fVl3OarLhXtT4zXBJ27bBLw14MTCJkuuC68hcdF2JHdHTY2rFvxx?=
 =?us-ascii?Q?+R76VEcq6rnYMdWMMwBYhrM6KI/0QMYuV7PDXGfz0aJubIs/npLbArVlXzHN?=
 =?us-ascii?Q?NgG4jjre3WHkoKjHRtlYNTaT4IFy8b1xkjqXS53vhz2OMMFXgSL3dj/Ad1qY?=
 =?us-ascii?Q?FdFLzCI31oT7gd7OKHj/53qbSdV9lM52BXu+shoYzlLlo4ItyXOnMKmunykb?=
 =?us-ascii?Q?iah7vVmXGsCs3q+ehToMK10TMzo7ExtHLTUkAuAhpUSdKPG883Q7DOJ5sdt8?=
 =?us-ascii?Q?UajZtlbRSpkTBEyMy3Nystapcj4TzqkBvazM3Eo9NQZ5hProH9GTY0lcViVf?=
 =?us-ascii?Q?0ma3vhXmnoOG5iNaesbShjAYdCrELwEiVKfF9gx0lUN1iRYjjbw7erBIFaJ8?=
 =?us-ascii?Q?8GhygaK6I6mCOivNSGjfdDvJsuXzDhhH2sTQOLYm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c75129c5-ae2c-40a6-296b-08dd05ac318a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:32:08.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W++bjTxpwRmpk8KZI82yDezxlklsxXwJ6hWj3erChYSWdO/TE9klOq/gblUaPpusBjttc+8XmFICsXG2gHIgWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8465
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> On Thu, 14 Nov 2024, Alison Schofield wrote:\n
> >This can be:
> >
> >	if (cxl_pci_ras_unmask(pdev))
> >		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
> 
> Yeah, it later occured to me that this was better. Will send a v2.
> 
> >
> >There are a bunch that follow this pattern in that function, mostly in
> >the pmu_count loop.
> >
> >How about tidying up the rc pattern throughout the function?
> 
> I think since this is an actual fix, any tidying up can come later.

Yea that can come later.  Sorry if I implied differently.
Ira
