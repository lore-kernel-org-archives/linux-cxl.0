Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465861CACF6
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669059; cv=fail; b=C1WcB5a+3gc4z1Kk28V2WFqWzNJCCQ90xESiAErFAndxTCeQOQLQTrUK7QOcDaYxMyONNRilbsirdi/DzHaX97acRWbwARp5g+UKAM33VeWdcqAXy5s9cHSCABsst0V1uA2u6qUI6kugGmmiNId9SLflkpx5drJhALWu6Y3o9VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669059; c=relaxed/simple;
	bh=cgZXrIfKBPLnAnDz3/c9ldtJmYIL2P/FQLNN/wR9SNo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oUD11ZWGoCG876GzXZ1jq1hEHB0foDc8hVCwv9x9AgaAJwabGtaKgwENQkhSoZC6X64amNQUZOGbZRyAadDPUcndT3yt+Y3XJu1V+3eOKM/iywoFpH/zlBX7Zx9PdcFXycER61Cm0fBvQcQydwZW8liuEbMJJCXzCm0tEMDMXjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KH24oa5o; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KH24oa5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737669057; x=1769205057;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cgZXrIfKBPLnAnDz3/c9ldtJmYIL2P/FQLNN/wR9SNo=;
  b=KH24oa5ozg6atn7Nhsk2TDWaE8hRZk5/3dnTMh7hE6H7aQLgYHTwMump
   MWwiFpdAZLV0yjgcgMOWVAchNe+jX0hyjjsAyPoymOuWkmR4Yp7Bah7dv
   N/Y3Hfqby2hePpKVCds8I3xP7hbpLKcRVYlfs3Id5Tw1caVuaPCdZBfSm
   B8Jn62+wWTW2X3UWzM2QJ1ZAKr1WPZiXsHxtvVlkZ4gN82ax52dGJATVB
   GI22zPOcosyVuxzxxbQXtqwcdgBdIIzv0tLwg1rin5jZ4TN6T9WBVqXJO
   /FEkpeP+TC3wuVF+ELatenL/icJaw5Sm4OAFfgPIP2Ei3WpU7287olfG2
   A==;
X-CSE-ConnectionGUID: 0usupf+yS766B4jWcABx8g==
X-CSE-MsgGUID: wn9oWIthSniOVbHOJO82Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="37450222"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="37450222"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 13:50:56 -0800
X-CSE-ConnectionGUID: N1+VWgR8Qv2a6OQtca+iPQ==
X-CSE-MsgGUID: HR5J9uHER/CC991RBGbAtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108021065"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 13:50:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 13:50:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 13:50:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 13:50:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8Nc2DUvzbLrMe92DLJkkDVbaW7kulIQLt0vTiFPBNRJsLVKQ0zPQwguqhimBuTXxBWwozPBtXj1JRFm/9S6gAvel4KJvo69V/1OkG9AxmbqxHyy/osk/7NfT2Uoh3WgkOMAs9cbq37LiKqJyarDooRiPi4iAhd65XWmsnrcmZG8JOnDTRtuQQBuZ6coo3xpy4khsljzONMxvacTcqWJiN3bYKgouzKsGYLU/S5aZZxNkqO5WNDJkIDLc6T/Vcqzy4BLbAR+qbO3uBeCVv4cIHK32bYk7dcGlDZ38qRjoiudkQZ4jKQKN3S5wFJLoYZBVGQFATptF1/JjRemSUFGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGxZXuxIftpG9im6daeuN/1iC3MNyMtf2uir8ZGLoBw=;
 b=Cm29qRygdXLAHOL0AenRziiimbFGasBigbqzJ/q7jIQw1uCP8zkgH547zSbaKCZoAUZG5fCL2llQu27X+fCTXcTb9N0hkxKmsPuOl/WlderRJISn20bOgkC0RH2JfGiyyEgAnSkqnS1MjK63UDedso/MPk08japOrDmlZpOCyza6t80QQVxMD+sfXRdEGyrRyNX67hiX4cJFI5BtVCnFjHPlPbhI/87vnUZv9MmCJYmQaZQAPt+hmM4jQ8vod/9gGdLUxozb8CAJiLeFcl/M8gsq24gSBk/K8VMsiLGPtnpBtCFJvR0cp8+1DPBI7PRsmL0o6hBcRKkO/PDJGFPmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6916.namprd11.prod.outlook.com (2603:10b6:930:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 21:50:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 21:50:54 +0000
Date: Thu, 23 Jan 2025 13:50:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 5/5] cxl: Kill enum cxl_decoder_mode
Message-ID: <6792b9bc1d25c_20fa294cb@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
 <20250123165103.00004379@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123165103.00004379@huawei.com>
X-ClientProxiedBy: MW4P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 605b66bc-0c2c-4378-e13b-08dd3bf802c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ubj/oWuMg79ZlAw81kj/ySPvoQvGEi/VH74VmffImuzZRQmNkyNcDw0cRUms?=
 =?us-ascii?Q?mtvk2G2d0hQt1P9bv+vdinQGK7rKbz9xtibgBfmyUvCHBWNH5icRYsuho/9v?=
 =?us-ascii?Q?F3kdZnBBObufiAE93y0BidQmpDxl7BPQEW3YIsjJo4TMLsF2RMvCg3O+isq8?=
 =?us-ascii?Q?sRQaPA1f6MnVq1qBatXdGWhThLSWZ9UjfMAUAHSRaXfJIFdkE+A1VIoo85Fn?=
 =?us-ascii?Q?ymk2Vj9tDfG8nCZhOT3XRmsnxuSJxIx1j/BTHTbDNFRlJQVw9qr3uOBtGTVf?=
 =?us-ascii?Q?wfdVei3s3CL9Wt8yu54867xRKKTxnuEMRH15N+g3Ovqvm9pHGm8tT4E8YqYz?=
 =?us-ascii?Q?DGPr64ySZ7rwGM7+qbqUaL2X/pdMy1WGWgETca//LQOXDCmZni9kDKMfLbPT?=
 =?us-ascii?Q?IbT0V12l/ToSvY9Lw5rnXVFcoTMEB97az9FibH3eIch6Oi5IBEHkrN5CCDKR?=
 =?us-ascii?Q?DaffzZbZbalF2WmRMRYRv0UeNtHyuUh6333lHjro8llC2Sa9GNHPVdRG0+yk?=
 =?us-ascii?Q?gpTQDO12TEX4hnCeq6c0zfcmIZ/MIyTyahTymAXRmpJo2X0T5q2B0O4b6zMn?=
 =?us-ascii?Q?hfMCb9YXHg3922jKN9hfB8YW4W2tuCVXWwqNlD/DgIVbn+qfaq19NmZ3dOsZ?=
 =?us-ascii?Q?yxMqW4Nj/0TgqOgRF+y0dpEW70lXaIaqA6J1tn3lSHuSNg6zEm4Z4ULUZ2iM?=
 =?us-ascii?Q?RuLCZHZ6f1NEcn4EZk1+DIZSCPTUDRJcUwEZEzggp/LRPXCLCLLkoR6+nbTm?=
 =?us-ascii?Q?b7aY9OFS992ZbfhJ2R+AQETGdgXGILl3n3IXkxUFmYYWPOYuNXrQW8k+zzAI?=
 =?us-ascii?Q?h4sfw4c3+8PzaWTLALKh5TKrEq0UkOFcVUTxmXyQd5B/SAYYLHtXzaOfFikX?=
 =?us-ascii?Q?k/STGdOa9X9erIvkeXnHs+FUgbyBAbz8bDQTrdpqrkSTc6woBRRjthQTG3YZ?=
 =?us-ascii?Q?i3sWeCT+fp9A4ttkUNjNF/9r3Zz6BKejr0RYpVxCFa2tfT0v46jiH1nGx+UO?=
 =?us-ascii?Q?23oQBtq07z3PpiHBpWbHY6eMdIrTfM+Xo8Rmn2G7XIQvxOiLu1saIq95Qk7x?=
 =?us-ascii?Q?zvRBeyTbG3vuNzqEnYAFA7xyyINfIbCttPlXB9qRPAoE4/W2sIjzTk/KPP+C?=
 =?us-ascii?Q?qu4Dq+p1GjS7CaCH8Nm2REiZdBdzQsKoxlWtzHAn3GgWYKA7HInuegylAqn3?=
 =?us-ascii?Q?+r0LYOK2sXuFSzijddKYcBbrnGL22HtTx392K2D2lyBg0vZqm6SuP/aK7FY6?=
 =?us-ascii?Q?ruLEBkkGI/0i4Uf49DWNXtkn9QLuXBdyvgkjklpHPfyYfpTJ2Nh8Gb/bq5Uw?=
 =?us-ascii?Q?nl8WH8CtqM3NT8lMjpXxPjH5cOeHx1FyfHS2Yz/qyI1qclIXhSvIVQAbXHZW?=
 =?us-ascii?Q?TOhfr/E0JTTvS0Zs6LPwDyyxAW+f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KpqHQOVuaqPGH3CoXIk3KMuwMJxbkCJWB9esLNc8zVkP2KZRWtoq9i3lPi+q?=
 =?us-ascii?Q?UFx16QpMH8iU/ZnP5OksPmemRBsfo7Xzl3PfW2OGFKYJRPfVRVg0BZBZWPdx?=
 =?us-ascii?Q?V2HpLyf4WNdlIOlBckwvlDc2PecHz/nxJd5PXCW0v8/l46joZqcJgaxOnjvD?=
 =?us-ascii?Q?eu1NJt3avQOGKgzxYcQc09Xmy6wrnqCoOH4wTI0fXPalOOwk1M8THpF30jPP?=
 =?us-ascii?Q?Zug2ohVm2iUYs+jmMfdjSA7Bzm9Bbqekca/40XK/ogg9ne0QQkfvDYu3Rubt?=
 =?us-ascii?Q?Whp98zA/mYLB5RpRa1V4s+hIMvdrsCj3eFjFVtJ90TtOTkHMOOWQhGemo/Rw?=
 =?us-ascii?Q?vwSuMKOEfUdYEJFdLSnrwMyvcBRPFiGU9FILr0QGEII3y4+GDzbqTiO9X1DG?=
 =?us-ascii?Q?tEV39c/FKrjudqUjxQabVLfcblzdgOEZZ61ueR6Vw8CgkiuF1lv3TWl//74y?=
 =?us-ascii?Q?bODLjpah7Q7wP93/jzy4s1dYVq4UrhIEhr32sI+iYsyJMmJt5OTplsWCXjnp?=
 =?us-ascii?Q?qn5D0oAFZcpO11RYijIH16w7Alqo2PFhCPxCZfDJF9bkpCCmNx/MjwlvYCso?=
 =?us-ascii?Q?vXfQdFwyHDUkFxBv5Y8FzNDN8FtwrsAcIZ0v+5hO+OECY7y24KPE9GQssHCb?=
 =?us-ascii?Q?ZUHbEzl+YxWC1Jpxkgecqn2hAeqkOpFwsGo75zYf57JnMTD8+PkqiW2xyloe?=
 =?us-ascii?Q?+T2o4xPEQHDUJXhwpkkposyQom7PA5B1Hjh/ZGrcpenqmwkvlHNTGJWMoxtR?=
 =?us-ascii?Q?pXdR9b3q2XUfZ9Ui+Ank/3QHQtmhQODApHPi9YYjCDlr2FmwQEM89hx8wqqo?=
 =?us-ascii?Q?ajs1OaF23QrEyUpEynlF/dnu2qPFCd1kph6OLF4CS+aoIzN2sZ6CthuVafPO?=
 =?us-ascii?Q?78826/zKcpIXQAOAsm2Ol3d6e9YNPJykghP8nXfrf8kCbLNR24pJPLtJkMzn?=
 =?us-ascii?Q?UHtQNOmEa5Rk+0erzRrOd4yAiq1LC0vQopFvg/yLm7MAHDiOHkZ7joUIYP2P?=
 =?us-ascii?Q?w8Vatnygqnud0vmEm5j9/TgXSpx4rhkTL/eXITp2lzYpAOebBCRuO5/ngtZ9?=
 =?us-ascii?Q?IQDicH3Qd9LOoInb6oH2r3vQZGTxrcDR+GC36WY1mprQWQTTMzMSdX9ju4ME?=
 =?us-ascii?Q?88NZm02+0zqwayVfwnpIL/ybUFNC9M+NPw0uRpAhYgcEohxrxOr5nT4lxBFW?=
 =?us-ascii?Q?d4jzQuBRbo31NQR9GTWqPYe2hd38/bNU0mNP61+tsGsu2jakm81jtzMMvEHO?=
 =?us-ascii?Q?gf7XTlkhw6UN5IHffd6gY9jaZA6iMU1lRMh3kjJSjnI/KZpq97E97d2LfPVE?=
 =?us-ascii?Q?E84H0rke3ktEdnnSueuW45VtFLTJjvmhdixWKOMxE41PBer04Wkz9s5ZA2Y+?=
 =?us-ascii?Q?4LbvYsCgZpTHKO5oO6QqXQMgjtzjtmDwabrqmWQuAoIWRFd+KHjXJCdxCtIP?=
 =?us-ascii?Q?BFY/9qroHsnMdnOka/GbSkH/95byBgPp7lPqHL7hprjew15xPbrkvm+e/MFz?=
 =?us-ascii?Q?cNH0wdHoZdmDRyd9JHfwBhSRTtKE7p0Z9Hg5m3Am8JYBMs87e7n5mfJI9Z3k?=
 =?us-ascii?Q?Fflfv3ev8mxoMYxM9uSbiH4Nl5VmYnsbybJDjn6MKULXlF+2dFlbf2kVbGOG?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 605b66bc-0c2c-4378-e13b-08dd3bf802c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 21:50:54.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLb4iN74p5Icuq3dZvefjCLr3FucXFeG6LItnyDJo7wa2KZy6Imb2X4krtaG8AJljYAg09P8qbFgBl0zer2l9m3O5uUXmDSYVYerHcEStCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6916
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 22 Jan 2025 00:59:38 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> > tracked in the partition, and no code paths have dependencies on the
> > mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> > can be cleaned up, specifically this ambiguity on whether the operation
> > mode implied anything about the partition order.
> > 
> > Endpoint decoders simply reference their assigned partition where the
> > operational mode can be retrieved as partition mode.
> > 
> > With this in place PMEM can now be partition0 which happens today when
> > the RAM capacity size is zero. Dynamic RAM can appear above PMEM when
> > DCD arrives, etc. Code sequences that hard coded the "PMEM after RAM"
> > assumption can now just iterate partitions and consult the partition
> > mode after the fact.
> > 
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alejandro Lucero <alucerop@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A few things inline.
> 
> Jonathan
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 591aeb26c9e1..bb478e7b12f6 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
[..]
> > -	/*
> > -	 * Only allow modes that are supported by the current partition
> > -	 * configuration
> > -	 */
> > -	if (mode == CXL_DECODER_PMEM && !cxl_pmem_size(cxlds)) {
> > -		dev_dbg(dev, "no available pmem capacity\n");
> > -		return -ENXIO;
> > +	part = -1;
> > +	for (int i = 0; i < cxlds->nr_partitions; i++)
> 
> Similar to previous comment can use early loop exit and
> part as the loop iteration variable short code and no magic i
> appears.

Yeah, might as well.

[..]
> > @@ -2728,11 +2733,17 @@ static int poison_by_decoder(struct device *dev, void *arg)
> >  		return rc;
> >  
> >  	cxlmd = cxled_to_memdev(cxled);
> > +	cxlds = cxlmd->cxlds;
> > +	if (cxled->part < 0)
> > +		mode = CXL_PARTMODE_NONE;
> Ah.  Here is our mysterious none.  Maybe add a comment on what
> this means in practice.  Race condition, actual hole, crazy decoder
> someone (e.g bios) setup?

I just fixed it up like this:

@@ -2724,15 +2729,18 @@ static int poison_by_decoder(struct device *dev, void *arg)
                return rc;
 
        cxled = to_cxl_endpoint_decoder(dev);
-       if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+       if (!cxled->dpa_res)
                return rc;
 
        cxlmd = cxled_to_memdev(cxled);
+       cxlds = cxlmd->cxlds;
+       mode = cxlds->part[cxled->part].mode;
+

...because there is no such thing as a decoder with allocated capacity
but no partition set, and an endpoint decoder will never be zero sized.

I also thought about adding a lockdep_assert_held(&cxl_dpa_rwsem)
because this function is a few calls away from that context, but will
just leave that alone for now.
