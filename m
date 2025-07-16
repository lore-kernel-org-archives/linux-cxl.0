Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9316171CD
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631146; cv=fail; b=diDkt0MvKyugt1AGYaxzK88h4ofoaGXxV9l4V889YstSoUz/tbQeIIfIQH3gy9fwXNbDw1SMknHJ1db22xaBjye/ilzujiJVTTQRxOwvRSDQgOW86ui4+PZhqyRLLZqusB+yp1conIzyiZV0oqXSP3nyrkhss5sIABctyBxmy4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631146; c=relaxed/simple;
	bh=0CrLpiG+la61H//Xde/DiURmy+ka3bMqg3j6hLhYZRE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e65jCecKZ12akydEkqXcIiXr3PD1SwxPl31+AFFGVT+oNWvRd+nSDQi0mZQcsY8bF40TqgM+dgco27f89VEQkI811GpmetRmj3cRQqdX1ejP+LATA9RaRtqvdLnGbWvnD9BPUkMKUtTNaBUjTSUycy6NJBAcEA/Lpp2ycTgMAAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOLhgLZI; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOLhgLZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631144; x=1784167144;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0CrLpiG+la61H//Xde/DiURmy+ka3bMqg3j6hLhYZRE=;
  b=FOLhgLZIVK2oaWaUFzDWY1jS3tN9DvDsC/dmdVwyC3uUA5feQD8VcYhw
   I8X34gKP49aUGvd92MWheIymFwW6PirjVcsileBE74+OGwrrBS5WZ6xUX
   D63gCesR7/jbxftG0Oj4NjfxHqDhJ0/tFwbVRL8eu/+Enndgo/QwWUIIt
   jTSewA+EqD73o9IAdKSCJenu4rblO5pOBYrd8BcgdLHWXds5hbbnGpeRk
   qlnt7GRNFcR3IViXGgzq3NKnuXHsBoX5Db1X5EBhEGBdKPplx2SPD2num
   MIbcsvI4YjW+uIVgPH/j+CstvHU+aYqX4jlAmtqUuecnAU15nMrtRDJkG
   Q==;
X-CSE-ConnectionGUID: uAY4nR6BSLe4A3VcEel/PA==
X-CSE-MsgGUID: 2hGybGgmR8SmZjp2QJM9JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65435854"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="65435854"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 18:59:03 -0700
X-CSE-ConnectionGUID: 2JmmFgx2RTyXcpRScdoZXg==
X-CSE-MsgGUID: YYKvfXoVTa+KAn9GE400wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161684332"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 18:59:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 18:59:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 18:59:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 18:59:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbLelMoWJRJ6u0ls/PYF4Homt8PIdBrivddoK4B75CCky6GgaUCpXWyAuW7hHDITYXQbuNx2N0Z7GSiXlnAiuBvxZkfP+91y7adBlwLulI0qeihk+JcssIJ/knY+2X+lyrePMmDFapiZfTMIfBVx89Sk9L7egoE12su/cbm9b1N0mQGvJsJe0jdL2ysPsxgdLTDKAgV+HOQDIWHJtGsbMwQPN1/QzQNYBXx1zAKcVv7tkLpcXMQtfJCyPP9zqYzReLJEmk6tIYvXJ69CZrSYDiZ11O6lpsH3Og6aKWrng7/5sy+GmU6fl5Lxda6dBMXs3wXl/hgdktKfe3NmYQ1Iqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm0RZ1tTzT4OtZELAl/sYojaDN8XjRkOv7/ZxLnPHOA=;
 b=YTpOLP+71H4j6AquGEMGblrlsLyaVPgjQ2JOUlyj0vR5nh+M+2HYYw4DKkivh3BavgarhcTG7zgm5yUUsT9uWrvGNa4BVcmdPyQaBH0J9ix647p5syXiC9zdXVaRkz4q9IkACfFn8duAo/ecmhmYVtkBy0YBU/z2A0fizSj5UyjtPapsVPXTmPC/+Y3eiRYmNxpRPErkOeKE+1nB2bzuFs2aIUOH8aL86tGA3s3XRIZ9pLqpDVXM71S5UbTdfY0LFnf/fPuDYKCWNNb1lJo5INaItdMMQ881HYTCu1y4PgD+7JQKMOPpWWNC05jXBxCnwSILpR8LBLJBjHA6/woeew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN0PR11MB6205.namprd11.prod.outlook.com (2603:10b6:208:3c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 01:58:26 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 16 Jul 2025
 01:58:26 +0000
Date: Tue, 15 Jul 2025 18:58:22 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v7 02/10] cxl: Add helper to detect top of CXL device
 topology
Message-ID: <aHcHPhn7FtjlmJGf@aschofie-mobl2.lan>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-3-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:a03:80::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN0PR11MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 585dae25-07a6-4729-1323-08ddc40c40c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0CH7MLTza2HDq1HOL4GwVPOnfdUonndJQB10TFszL1IF5BMrvR7F932afxTE?=
 =?us-ascii?Q?bTBWagJip/WxOGzdh8rGSYALA3ms1h1ZhS0r3MtP58d1C/RBjncVq9Mw25NO?=
 =?us-ascii?Q?9B7/KTrTgHSSEivLzLUQix9xToLw0d0kVp54YHboAovhSISMWXyZzHr8pUzm?=
 =?us-ascii?Q?IyG7klcfXCP/jnQ9x+cQ8K5uCFtEqDpURlcqqmE/YgU9RUfs2v1zl7R8qO8d?=
 =?us-ascii?Q?r+CQ74OkVMRZzTXOzVm4+yBEmGa4pofnCrYKHeKnOtRVGcI/sc0tr66AgDPi?=
 =?us-ascii?Q?tcI7iVQ/lBfHh3ikTVsw2c0dKnwOqq1+XHkz7FuQAAvwRLLaLeqD46uoKemM?=
 =?us-ascii?Q?UF+7z/MA7bT2WWmyn2m9mcNt8SbcnBlYfrb48+LZVHsDk8EFAIjNhsqb9ITf?=
 =?us-ascii?Q?Fd0SDcME5bmHMwuytnZz5pF5Y7vRSRQJ11KlHjZyb1AFIqJJUGxm2/nUPeQh?=
 =?us-ascii?Q?8nO9rGGLutShDOOuWAu5TVFvB5wYeuSkU62XcO7YgEElrBhrmcLtQpbVcuff?=
 =?us-ascii?Q?balKuBaXwtHjmQsCKnXIqoId9heW7cxgBzTpS+8jV4+IdiDnfJCcA/iIzDvT?=
 =?us-ascii?Q?V9m7aHXOgnBqufErvgGoAjAWEFaeIXmDMNAvxpTD+FEVcmqlULfl/Ud8T2js?=
 =?us-ascii?Q?Oz+KNlmU9xAy1Hb1MK19sRGA39HHW8vWTK3XJBzpOslE0EMkuivBxumUdhF2?=
 =?us-ascii?Q?3jEd4ToxTyJTof3FSN1cnpR94wCZB20Z31rg8zaGOl+wLZ0TGqzO8tEf6tLW?=
 =?us-ascii?Q?iH2poYG+Pq2lzsdsJ1YmAvb/KoHGxfbLIO+vtUeO7U27rtbHf9q/x3h0Pn+8?=
 =?us-ascii?Q?VAegnpCA1Pv87TmY2CVeR7934cFAGqrpptSJUQVoyufvJRdBykC6AoWY08vG?=
 =?us-ascii?Q?tMYKKD35g6ZvERQ1m5kN81E5lHC6URe2yeM2MWAPjMippgtM4KI2xCgP6N1r?=
 =?us-ascii?Q?y82IY4D1fk/xAyLbffUIgtWEPh+VWYK5pPFtrhkunc3zluF+KNQtYtD3MAz9?=
 =?us-ascii?Q?j/lzFBoNXKgWfIdnu5ZDyZmptuSmzLX410YIR05xALZW4Ou+6gxXi7XJXONo?=
 =?us-ascii?Q?7NOiIAnFwnA//q9JwTgs3ma+zV2TsurBAFeGdqYWAf+fB6hjoeepuBlYO5Et?=
 =?us-ascii?Q?R0XgU9eUBdHlhZedFZH+951nARxzxUJdfiq34GChOXHz/61PZfDUEyuaWeOp?=
 =?us-ascii?Q?xv5knRSzMs5zShEf7V7lD6GsWGNZ+a2cMLQKrH12HBl6xnoLoicpHrzvFH0B?=
 =?us-ascii?Q?BtDnVlQvGG8VGe81vwlUF02sc7SAmBd7FUGWhWyMM+EYZ9prz/uRmsI8Su72?=
 =?us-ascii?Q?OZqBRKGLdujUtOoDO5/Wxe4VG4GBiWEKWYTSee0ILEsKVtHAjc3TlqXighc6?=
 =?us-ascii?Q?aYmACC1lsTaDJpqs29cEIyasP+phn4Db8rX53rKG40hNf0m+dA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4UiIBjK1QVAH2tZ/w4SspxJpLRYTRtU/knTce8uRPOrOGd/pe2AeOh4SQvWG?=
 =?us-ascii?Q?7nclpxmA15VgdxIOaJh3mSYjO9TpzRGlJ6GeIE5tqatDJr9tFGdF7uKUsPs3?=
 =?us-ascii?Q?BmvluGCRUYWBTnvTYfu3fW9yALkTYR0u4d/p8BbN3etdkzNEoCTBywdUktMR?=
 =?us-ascii?Q?jlg/3BMrZcVVnLrwG/2J2hglvMbdvfEsoAvRkSVyoQ7bJzif2VaC+a6YghFU?=
 =?us-ascii?Q?kSpzHYtA3Y0lEjSB8WS432MGau4eTkELk7/qUMtRmSaL1OZkJygWr0FUz4zn?=
 =?us-ascii?Q?h32Kp6FAKl7+7KU+Fnwb3VLFIFmLOmNBDFfmDvvXwugdTQOaJuuLgYSm/YkE?=
 =?us-ascii?Q?tfIX54tCEsik6GMVGD4vmwsmTc0xoEDFC6ByidBmISJHss1v5KArNns/NgYe?=
 =?us-ascii?Q?oC4t10cgSVq31/1QPZgQgNNF6R0iWyK8LxsBJpp80aXtACtGq3H0oVrcZH2+?=
 =?us-ascii?Q?76Ug6E7GZDPfIOtUwyRLnMyqvarz3+IV+UxDD+UaPBPvh6at+rl4Yrx/IDuA?=
 =?us-ascii?Q?sGXu95otQ1j8r0krrodtXFwmjD/vB3g/cqTWOnNxwBTtAtgzSNDW/32Raao+?=
 =?us-ascii?Q?XMzuvRP1LrQz0Ypz3544O2Aen8QTplXmlSZEFsykiqNhPcF3/7RcCfYOsZhg?=
 =?us-ascii?Q?DB/+tzY9M/oG5Sc0Uj9g00ah+Nd6yaJV4mj6gASIsvJCWlCRYzVWcMJ3hlIe?=
 =?us-ascii?Q?icFb1RvQvyRTYuP9FT7iQpN91fHE6cXyGmsYfsAGFUYqEszPEoddWRlsyKHY?=
 =?us-ascii?Q?HJMSidGw+R83qNDuB0xwITwx/p1vnnvFL7cBX3F5mJjv2F126TYwhuxVqnjm?=
 =?us-ascii?Q?ZGCJGcxYi1gDictzrDYJhK27yZMZ88Uq9gKdj3heqlINWXIfgxz7c1qNDjlf?=
 =?us-ascii?Q?fMe1awWHcYbixIE2j/CRttil15iLls6Loc+WC0bEDuVPlfJJ38zxZ7Qh8Ji4?=
 =?us-ascii?Q?pUzla8KYCEYS0aBo0lb+yrri+NOSL95Eh7UdDBUkmkGYZfCBMUhsrGZYYNQf?=
 =?us-ascii?Q?IODJfcaOEs9o1/Xj9JxLKHUWPb9WnFDa0cVgd7MyYP53go+VAS2EfgVN3L2t?=
 =?us-ascii?Q?pEAllKfoPFx3IrDG22M22OxG0ianS4URL84uLgDPZNbBSee1Z/oz6WDz/+0b?=
 =?us-ascii?Q?9ELvUKF46Cic4OHFDM9YngtIP9x+Q3BsAjb1R0koUE8Si1pKlOq415DVdeI8?=
 =?us-ascii?Q?FOSBzgyLfxzeVKOvTaNRL3hmdiJ68E80BWIHX2Tq3zwg0p6QYW1hc3RSBExu?=
 =?us-ascii?Q?OsB6z8suauYE2ONp/mUhJBQUJ+5E9+Q1+3uZY81zfPiiREHKAdZB7MNVUGFd?=
 =?us-ascii?Q?hhe/6MKqCiSgvUSmkys2XWcAc8ujTDIXJcxsGGblwVouXyienP9vSE0hIHYT?=
 =?us-ascii?Q?VuvRWy/3z4zdAphb0lSaPiuM/2X5zyZIGrYWOUp2NmkS67mCijOigx06Aenc?=
 =?us-ascii?Q?jLbTyMMXQX9iMAoyCHTpVuxFYS4zgbaJu/n2SxlVuiQswZ4hxAd540qPUK6X?=
 =?us-ascii?Q?KcAPVKn8oN0XWaxgKnWUPwSG0TP5AamuYJ58dWe8zVnvQaIyBRNvh8M9a4mZ?=
 =?us-ascii?Q?zXT3G3mLN3V4GdA7Y58BBMHeLKrv4cPzAY20u6VTQ765Buuq0aVhvMjH1T9R?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 585dae25-07a6-4729-1323-08ddc40c40c4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 01:58:26.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6DlKn3U+l9C1o23IvjRIrpNGKcNrU8iL0X5aQGqSblNOBZcvk+jQco+BPfCRtQzXMad6l927K3gya0cDVTZb0cG9EHp6ph1Jy+lTEZaj50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6205
X-OriginatorOrg: intel.com

On Mon, Jul 14, 2025 at 03:35:19PM -0700, Dave Jiang wrote:
> Add a helper to replace the open code detection of CXL device hierarchy
> root. The helper will be used for delayed hostbridge port creation later
> on.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
