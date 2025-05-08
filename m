Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328F1946A0
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734959; cv=fail; b=tPTgKz6Sh2FS2je3OPwTbu/PyyfGO5w4N+uePPwtXVTnMboomwsIevlg4gP3SbWSlqmgaq3QIG1rkoWPdcoNcFKjx6AT9NHfZWNFQ2swJ+9w9ZO0Tn11fMq+K6iksGXp5Tn1k2SiRSukkMg/kYd5NFC//9ZXEYBXgG6kPFg2X58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734959; c=relaxed/simple;
	bh=+Sxp+yOZmITw96E0egpBky6+w1hLJMcDMdQZ+ayV5AM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VA9qggWcMat44EFNUKmYufdbJh8TS1jfWfx+Rdq6YcM/LxcvlGxDqkYnEPtXV3Pr4coaYbPe7sz9TlDL29w7+ei7r5sMygw4KkUkxxpTXsoIS2Mrmc8eAKlbSaZgWHaVMz7VqaRZtNJCWGCT42AtzFvxPytuJquYS5i5Zwt6pdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1o+ILDW; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1o+ILDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746734958; x=1778270958;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+Sxp+yOZmITw96E0egpBky6+w1hLJMcDMdQZ+ayV5AM=;
  b=a1o+ILDW02GA7x452ONVHRrCF0t7SmLOD/sZ/UwJoFNVvcxL01CZoxAh
   IKBfsbVbHXdjbR1SNTE/FBy3lmvwaTs3Il9cll2TTsfDQX9OTjTjfhyLK
   mlKNqN7pftjatzI/lkULiN4sfKDsoA9Wr2ro0wg/tvH8wGsl4N0GAaWOL
   /wo542/NXAtq6Otlzl4pXTa0ZW6RMiEeomNTsQqp2AfwJht2ikvH1iVOs
   mhYRHLGfnmEgIDZtWVTKaDPeCjaZjxwJsMiytsr3V58Q4Gcs1YAVrruqL
   eQCoVg8uj2+THU4L3BVM4P4A7eekgNCKL9YLevmOCVgZ8rT7UAr3Yv2rZ
   A==;
X-CSE-ConnectionGUID: rBAMgwMSRZKMusguIb5tcg==
X-CSE-MsgGUID: PHR54MdhQRWvAWoJfzU8bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59885650"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="59885650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 13:09:16 -0700
X-CSE-ConnectionGUID: wL11OwKVT0+wTQGee7KVmA==
X-CSE-MsgGUID: CYKaPlfhQPCe+ht5qm69Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="136283878"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 13:09:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 13:09:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 13:09:16 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 13:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGBLvvB6Li3df3IXHFKRntzJpGxGiM23k8zkanr2/lcdFyCXtlW9qZTmwadnkoYQ0sglySkXqcThj56cIWnRPT7dO8kB+jGNPc/wKHzufi4eY5tAXdTzz0Ty+8/i+8bBTunrFxHZrBcVftmiHavyof8ooW2W8Vwqv2gKWLUHdyB7Ddh0bNsIn8zxEvJ54DMtbYI3j436BL93GXYkA2zX7Iz6aA/wk4yfutWOyfmWyx5eOuc/oJ4IBMKh7K8OO3KtKkqoWKV3VJW7qGHgaDwdhAemSPqkPuDdxK9mjWLkOwJUhHES/oSxJBftCn+dWmDZC+TDvCY37xHyYZvoOesmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Sxp+yOZmITw96E0egpBky6+w1hLJMcDMdQZ+ayV5AM=;
 b=UdOyOjsIE+whbKfCM49CWfzjyzFkc64MXEE4w8WIdyippPbzrWEIQmBb3vHjLxcBq35uR1HnCIQUDlFTaz9XBFv5fwLf/HoY1CG7zxRm/kG4hmjXMtCNsAIjlYtAjhhKEC9z/EEMJFW50U8vbcj/8BW+hdVH5RQNtmO1i2jvuzwGBBpOLhH2TnGxiAuP5ubbJ1RVR+wQR4sf9LW08ueGtibBpK4aTJAfOyMS0zzLGd2I5XbUbrivUM8naJh4pBM040EbzDJDg5DSwSMMrh0UrsRzxaPdSSRNv/DQQJOHdtgn+ZvdM84BcKvdvhzsmSW1TUF3M+Pb9TyjLjA7tzF2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by MN2PR11MB4726.namprd11.prod.outlook.com (2603:10b6:208:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 20:08:31 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 20:08:31 +0000
Date: Thu, 8 May 2025 13:08:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 02/10] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
Message-ID: <aB0PO6n2Hr4ZFt9G@aschofie-mobl2.lan>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250507004310.3536991-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|MN2PR11MB4726:EE_
X-MS-Office365-Filtering-Correlation-Id: 8321e327-0658-4bda-c5b6-08dd8e6c1a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?evQohTa8seTDKYzZT0/lUUmAfM01Fj6CuSszhf2mGscQ/gidpsSi0sTaACHO?=
 =?us-ascii?Q?+LQAzebO8YTpnd65K84vX2Y6YLubVdIoB8GWa6mqp1xzwaCky7gPnw7cSuAT?=
 =?us-ascii?Q?TVWyvOYcVdH6vdBxod3pDn4r30vbDTiF7O3/5KI3B+fw1BNiXDdV1kmu61Dr?=
 =?us-ascii?Q?lgIyDMkCxRQona2LwtdAOa0ytRVWXOUOEZruMokWDUGjKb7/5O/Op2QAUt0q?=
 =?us-ascii?Q?8Dw8GlnJstb577kU9mEToWjDDMXMPUlGKemmxcw62iDNCCpi2GNagGin32gq?=
 =?us-ascii?Q?keDGZI7C8Uz6Iv03Wuq0l/ner7WA3/az4HoaFLXcQb4xdvMOTsFLWtce/3yB?=
 =?us-ascii?Q?1+D6cdP3OpMfqU+6IC1PoUOoompNsYEdDl+yG+dClrUYKFzk4kifexOZQXKf?=
 =?us-ascii?Q?Wr4cNNPdBGDpl201L5baInaqs4ubRuRBJofBzoUuaCB7eseuTlhCoDV9vqd1?=
 =?us-ascii?Q?vgu3YOYhy8TrI/AwhdOUHHMBu37curX4kmpravLw5z83dTySwsu/Tk7iPxxJ?=
 =?us-ascii?Q?t1w4/UBanGKKrIuWpghhakiGV72MAcaGOUykTog/TyZ5VpPdHaRNBMz4f8AA?=
 =?us-ascii?Q?IX2uNKCsX73Lrur7ulwhso1o1gJ8uXYBGIGRzLSXu9aN2ekYBgv3Eh13I+BX?=
 =?us-ascii?Q?/sXK6fsw/kZwkwc+QMMdObLYPsujGiz6e4LzIcfUX4P2Jp5oq2V22ys+hSlI?=
 =?us-ascii?Q?jsXqPQHLYwOHK+OXAu7e6MwF8g/J56eBkS/PIUy3wrdPGUGhqWne4tDkuveS?=
 =?us-ascii?Q?4Wlx+wt/aQOJXCHPQl/FKtbslocxc5hTWLY2GVMIYt8bsDKzYjW2sd7Ubaop?=
 =?us-ascii?Q?AwTIKLULJrqcwunGVuRtWu5cVeNOyF9WfWRcM3zicz4SI818/gePUpR5ui4d?=
 =?us-ascii?Q?rDYevZRuy72eJ/psDpXCi+rqTBEkJSC79osa++WFNGkCZ7Ja3risV6Jprq1q?=
 =?us-ascii?Q?luay0SVLRi6tIviM/pWFYo/qBO3HNxxqQ3HQtHo+Qj0hg9cjV3Br5e2wfsDe?=
 =?us-ascii?Q?n+yNALJ5i1fU1yBnf4jR6nJka0Re6Ny5OWz3vk6pHdjbEkj1YkUh0Z+WD5He?=
 =?us-ascii?Q?3g7r42jy9x9CmgDh6RykyIKRcR8xLyJvlB+QIEKoinfOmOZWo7PBaY9t/rEC?=
 =?us-ascii?Q?1pGsieEYjj3G9aPvVr0SHPiMjWQBKyWg5ymz0npVH1U78yP7WtsvqHXspIR4?=
 =?us-ascii?Q?wVhWJTBySwOMnfYrQo+Df2pjxCoOeIBNaLZGm0HhAIlBsZMkqjZ1l35d07Ac?=
 =?us-ascii?Q?cgZ2BrQvHITfZGI+DGt/bu9j7cTKLkj6hi7vvMU/Q6mGbOQuaKM3wvV2l75i?=
 =?us-ascii?Q?mCXMoLURra7g/O17j+XtIgRSuYWhoH7BOma4YaT/xpfoC3tEZK5+OoYY7Jbs?=
 =?us-ascii?Q?mkWwbuIONIr70pe/MLfWNfNYnC88YSs96XH/OxM1y13JzvJqM0uWobphqnlN?=
 =?us-ascii?Q?Jcn03cPosDI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EZUq5w61n83DaJRfxPtSxWqYjy5ZOsRA7I05Il03Uh7d2kunVs8LuVl5OsEW?=
 =?us-ascii?Q?v4oIlinNP6A3Wm4h8FGQI+cMXRYEV5Cr0ruAVYTHAOYmGOoYEK1IsG1cXSDI?=
 =?us-ascii?Q?W4QecdTATSvqMWv0z0/06K829oj09BvsC0JTuTdzyYIDvmCMoOCtdexJW5Fi?=
 =?us-ascii?Q?idGwEG+7pYp+HkBlMzOd5FWgnhOkIbOOsZ+P+d2L8NcspopWxUeNQu6P4xtz?=
 =?us-ascii?Q?YP73WtD7NHU8JqqgZSEOboEYzvwLxEMvYqoTWbhmbFtuDMMGXoYIIGwRujZc?=
 =?us-ascii?Q?Wy/8DT09U3Tnxbcm6nG/v7YcggTfIAL9Vi7YGbH1leOCldCagCCLCK+G7o0A?=
 =?us-ascii?Q?pCBhIscWR4zF+nzUpTHqhgtV94unXK39jQmC7DbhRLxuUd1Vu+fQ9474wAqP?=
 =?us-ascii?Q?xsD/rpPgMGIkW3PyHYfH1Xsp5ALKietIIdUoZZ4fcQ60sC5T4NY/zcohgC1g?=
 =?us-ascii?Q?ffOXsIQY9Q4T6uxUpJCsvN7XF3jgGdDOqZC68+BLlw9kZweJTduT9vDJ4MJg?=
 =?us-ascii?Q?v24BdAiRCtecpjxEenc8weuU0s/OR1Mg5UWVM6t13SLCn+NE00zXGgPTeYf3?=
 =?us-ascii?Q?emlAHcvX9Eeba5jHcvDAuX43PeEAFdQbxC/dsEWnBTZ/kK02BK5b/HCL8dxJ?=
 =?us-ascii?Q?IjPwIQ1KNuQebzNHYQWgDn1h85tqrTwaaVrxuBGmWj4BqVeeddKxBMAGs1Yk?=
 =?us-ascii?Q?lnszdaNYq3NtrFF8iWgaL69Eg/7xb0l3o9/8Xbbx74S+gC3IohTFgIrs4Qt4?=
 =?us-ascii?Q?C9Pk6kZmO7980dWGrxgKl6KYVvCOwA4c0zF+mGlHsx5VEsCDVfMCUa3exPc1?=
 =?us-ascii?Q?9+O/kodj072lsgyqX8Il+dshFvl6oRR5OdfL5u2pvdj6vyRVz23Nw0bLBYib?=
 =?us-ascii?Q?Lt5mXcKgF3b/PXpeVuzeNICwDwlWULA3HJDLyjI7J7NYp8pB17zWTSzoY2xw?=
 =?us-ascii?Q?sMnGmbu12AXKkONUHB2hdnKuwdPUFu0SvQAcb7nNNK+ufu4w7Ur39pwE3FHa?=
 =?us-ascii?Q?g6RnyIE2JNGxsxkqsQloMyK2GIDeV3pviyhfl+hscUAQMn/OTTuYFRPZ/BRG?=
 =?us-ascii?Q?c1hHCSag5PIjeKCoBjb7KIM3KeRk7Dut6JqKKnI5BvEeUE7W1AQ8UHkhk+fL?=
 =?us-ascii?Q?21VvmQ1ENwFcpj1hPy55yku5xjyJXgeK8sBMGB+LkCZoHozDIxFxX91ultwg?=
 =?us-ascii?Q?qNo/UD5GJNslUKuqHB/ks7sIpJSWLF375o3gCJ5sjTE+WiUI7ZU58YMuzszw?=
 =?us-ascii?Q?j1Ywj2m5yfVAeTFrd6E0qtxQjrrs3bQV/sGAQTUVTFi8y79/XFV/BNGn9kJy?=
 =?us-ascii?Q?O+WzLPvEdrOuey6kpnqryTVgUvnh7MBed89dPfCITC5teQ13V9zQhAGh5jJ9?=
 =?us-ascii?Q?iM0xLqi+poV950NyzNlWmN8gdrLS13VMqrHpNv3Kk2wp0+1+rG3uhMXBgjaf?=
 =?us-ascii?Q?0pfJeEAihHBHgO7SViKYf350Tlkj8uJvI/12UBcwoC/bKw0bzd9KD7CGac4Q?=
 =?us-ascii?Q?mL2tc/kyHmB+GkU4BTf9RTGEastAKoTXkB2H2dqEg0d5aL5SGwcxoWvkmZ9p?=
 =?us-ascii?Q?v7dE4D5Kb81K+5qyenLrXjWJwylagpVSzCvO1+eJ+1ESwoU+wplAqXBsJGhG?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8321e327-0658-4bda-c5b6-08dd8e6c1a75
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 20:08:31.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7PVZBcGH97ruXxFOr5W1mfC7kg7fGNDhAUGC9ODOPDZjp2iZYJJJvIhzCcn150Dw4yc3eYKUjVwrWQdNlNS56rDGW3VaqMACEqfQRYYi4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4726
X-OriginatorOrg: intel.com

On Tue, May 06, 2025 at 05:43:02PM -0700, Dave Jiang wrote:

s/saperate/separate

> In preparation to allow dport to be allocated without being active, make
> dport->id to be Linux id that enumerates the dport objects per port.
> Keep the hardware id under dport->port_num to maintain compatibility and
> introduce a dport->id as the enumeration id.

I think the 'and introduce...' end of the second sentence is repeating
what the first sentence declared an can be omitted.

With that-

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

