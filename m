Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580BD1DE4EC
	for <linux-cxl@vger.kernel.org>; Mon, 30 Jun 2025 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751313999; cv=fail; b=Hf2DzBd0CTfDyelnR9uyNE2qw+fCxvj7MBmjhdL/OOd4MeZqSC3S6rxLnoX/rZCC9D90b5n9gY6GInfBKApY4mdwtxxQz3BtkGM6NkMpJ1igG3QdLdpXCR2BGOSlf+FwgYKggNjgQDmVK149b7WjNCXcDrhgj/ztAB4auD0xIRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751313999; c=relaxed/simple;
	bh=dZCOw8xgyV40VSGQdxZdXusWRnNUckzf74cHLk4xic4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aT3SazWQgzUeg6AwMPhw9PRTMZ90ANq2LtOQ1EYNOeAylghVr4/HiiYz0iqUrq4w3C6WXDDKlrlcJKqvrS25eVdy8GyWc2tkZ/OA7aEPGd72ZEivQDuvx/sJoRLyVuyCGURXPzyEV63gjp2wZlYGaayNfeC3/4Wq3N94WPgXX2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPyWnx4/; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPyWnx4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751313997; x=1782849997;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dZCOw8xgyV40VSGQdxZdXusWRnNUckzf74cHLk4xic4=;
  b=NPyWnx4/npSwlueX1yV0gxwlvmdkRs+wuRVC6AQ6y3/TcmJcqn5fnm/D
   KoHfmrIPv27hDr7kdfURpOCyQtB7Ioah8yVCYmkaLlpn2JwYnO9H5OEVH
   j7p0lh1Gg83HS7uaReFc3QT2PhG8JbBTZgTS8uPkhtVOu3dfDTsHCZ72I
   Mu23dtLSgmEEdNfEiwA+l1aU+/D67+ARXG1cnUFBkjHaLSmQtaZP3eHb6
   b4dA5vcFtx7z0wy2D4Tr4C9nTXGD/+Jiofe0xg0B+ipJONHumu+Vc1e3C
   RshJtpPYQI+rEwpoO8QePj15wf0tWWH4nBjjCuFMuTXktjx1OM4lkd8LM
   Q==;
X-CSE-ConnectionGUID: VetF5wkTScmsi3mvjgEbTQ==
X-CSE-MsgGUID: xXWJh2YjQlKCuhh4tLwkeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64153943"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="64153943"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 13:06:36 -0700
X-CSE-ConnectionGUID: bK9s7hkzSwCVuhUl8QNL/A==
X-CSE-MsgGUID: a56+O/chT6yK9hbX59ggZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="154021624"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 13:06:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 13:06:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 13:06:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 13:06:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muE5f1VLSjJRrH+DaPdTxeu8UHxuWcC91y15az9xZT531FVC8cHdb0FPvsNQeAoe+rEsBxLlmu0V+MHBNWcsQbSzvI0uOBAeTC7s4bvKKmgYbg1eCfMQxEmfOFtU0Wz7cD49R/gKVAmozQHdcyDl+i/1zXUJ4jrqZ59XAFGtOwYDsPHljD2NIOxSkqNrShi2DzKH685pKzg9iPOiGjWRFPCBY3AunpgHpo9QeOsoUENaEh13SrE3UMFdJjB7vLl69Os5mk23kOL6x/JTG+5/Y0600yuGNaZrV2FKIgRP0pbKZy1B4j6tHBzxIKcnrZwXPMYNn8dc88O0mSPY+N0Q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu8btsg12+p30vE2wnidoJK43sXrB2/tiopEizXPP2U=;
 b=TzXQ3jjdLJGV45c/Jo+fccd35ddNpjx9B59DVXyBVTFbf05kxv78SL996bomk37pnpi1CpMKzn+3pt4TdjUVkb7zC/piFStYcBsjQTGuG3/LzLFsU5d00btYvP033c6S6fWaNwaBNAoIG+6/p1yPLqQr5hXvZ2n6nG+FV6kvyoKRDtszybmIG6AG5cE3Czxdgx2tET0CixQLIFYruFmIYxDWq9t1WSjWolUIbFJL3aop3pZcvbf5afGs4NGSG8jYl6gMHikLeHn+mtCm6NLzZkKXq1lRz7oJkzxgVxczIHAYTyVi6hfUIVEBw/ImU74pjy3jgSlO+dtt1wRYZJFWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 20:06:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Mon, 30 Jun 2025
 20:06:03 +0000
Date: Mon, 30 Jun 2025 13:05:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/region: Introduce HPA to DPA address translation
Message-ID: <aGLuI5dsgbY-N93Q@aschofie-mobl2.lan>
References: <cover.1750725512.git.alison.schofield@intel.com>
 <4c4a1a52a4651b726ef66d9020e71e731b74cb5d.1750725512.git.alison.schofield@intel.com>
 <20250624152716.00004c0c@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250624152716.00004c0c@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d86754-b4be-4cc6-2e0b-08ddb8118a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7WNQReIhC/QsUTJAM1LaCMnVeowKzu1hpWC//9oVxLzCPXBzU13BU1CQKaY9?=
 =?us-ascii?Q?D+UZ1AI3lrBV61SdZ3TqOs9mOuKLw56NI4wGxzoCMGlm2yoqXr4JjR5DPUPm?=
 =?us-ascii?Q?FhncsB/toehk4p8ygTIREFcczOWmeau/lJZOY17jhuOhBqKgq97LqGeC5kko?=
 =?us-ascii?Q?w5O0Cm4ztRju291dlonOO/ZNw6aN2VvRR0e77C9Ym4FF0PBl7Nd/KzP+0/vF?=
 =?us-ascii?Q?FirKb02tpfybcZ5Dx79wpYL3Ku/xL3zevUoFpD8epwxh6B8Lqs3xB6jXdSs1?=
 =?us-ascii?Q?D34XgC2LXrHlhtHLC2TBFHbEfdx5hBcg7SsyBcYn7EItfsLmChzGUPgmtxCT?=
 =?us-ascii?Q?t4wcM40oR0L3NvEGNU+rVFx0h1K/nZPuMbc6z3j6la4QhPWG0b4ic1a8y/Kp?=
 =?us-ascii?Q?1IT3Bipb0+XQN/Xu7r9wbQbp067L2nVT7f6xYsuGgLlnTUQVml0Nxw1qAZco?=
 =?us-ascii?Q?RAOzEmL92//wuzpiL3cRElWrlrRlkYcOkpnKeJt6OPA3p9rlnshel9Vty0Hq?=
 =?us-ascii?Q?Q0LtHcUNp59X2SCb0H3GIriUQxm/xkft/U3+YSVE/3jvbF2YEYnCZZhoVf2+?=
 =?us-ascii?Q?6iKQQoMGWDHblpfctVCMz80PSjL+gr59DEkFjvoCyr24hD0euOdbRfueEvIh?=
 =?us-ascii?Q?WlIjTkvFp51tPSt0Xe+vkwRZUFLchgjUM6DK+4u9Cjk+TsbyrMLEvNmPo3O2?=
 =?us-ascii?Q?tIxPoggodg2OFKAHHYGKj1RSRyZtiXY4tFSK5Kt3SzSGj0sORMPNpM4DfZbT?=
 =?us-ascii?Q?WHiwklPFUmw0vd4qizOp7tr7sPKgHaM14+c3GUnuCAQ6avyZGRoXDe4uk1bi?=
 =?us-ascii?Q?F23dNiREuC7YSaKTni7pUlFD7HJ+xE7tPB8LdKOBuF0oGy7lyamsvWsKmH/m?=
 =?us-ascii?Q?nrKQkak0LqYnNB9DhkzMoqkK1+4+WB1UUG9NIK7wzAXRlKJrFPmEne2MdnNh?=
 =?us-ascii?Q?TanWBsHk6ND1gwgaAMGuCkGHxdOhTu97MPzJrBX/hwAuVbKkr3u9wmGWm66I?=
 =?us-ascii?Q?xhdeJPoya0wA3cEMtnutQW+WXMcRaW95sJg6jJ8VnYTGGflK4IDPboRr/YPq?=
 =?us-ascii?Q?JftrHqPkGLUuj4qJGNxw8dXoopz7bxzmjhW13WfagFRjOFJgdrrQdCwa858U?=
 =?us-ascii?Q?T1pMcqgYox4gKMsQeVh7+r1Qef8lu/g2YpzelbalYCn4YCYcL3UcpHsSR+BH?=
 =?us-ascii?Q?7JlHoj4on0hm0N1m9/iO+7eTQfbvw5840Z6VHwObyCVBLyDM2VzOz3V8NYCJ?=
 =?us-ascii?Q?8G9emtG2JJHeYW0UawV5e/XzoHSVYi0F45LCyxKFzaJ0kBlu/xXsiba8QrZ+?=
 =?us-ascii?Q?4vywPr4S/3ceq5EcN2jD24HpxXmZuoy1E+DnjrCe+vyQexFu+RsSPOYoqnHK?=
 =?us-ascii?Q?VARROEaAVB2RvgOL0vmPlgNUXNVLzIVrRR8P2EJRMBSVJiwrr3jpz+sdLOxE?=
 =?us-ascii?Q?sSHgQPoF7aw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MxsubLtHgsvASiSwGc95XXxt/HfhULlr5dN7eOCZH/8HQB0CswwJ8KZa+UlJ?=
 =?us-ascii?Q?DrXJ+d33D0gyZjyzRda+gxkk3ZGSIg65FVU4qQCSzG/TDmjMUJWMdAjpksxI?=
 =?us-ascii?Q?2YTd9r999ctyPw0FGXFW4m7vHePt1sr95a5FXZGyeRkwq+j7/MqB6bq+AGg6?=
 =?us-ascii?Q?yff25W2y8JKowSXAF6HOIumQCRiwdS6vpKP5QrlAauxAOgdA7bTw7jpjpX1s?=
 =?us-ascii?Q?oboaYa8Xmi2MljcHpTcOMM0oFYfmLOPoxc94qlO6Yh3blcaOxNVY2On86ZTZ?=
 =?us-ascii?Q?KMfpcXiaGscsbZmRix94QVAgyk+pebBATPkwPbWIH8YiJib64WoQYetu9nNd?=
 =?us-ascii?Q?O97MJ5MzlkIkwMdJsuFMrIl0GCyWjn/C0AqlulgQQ/Ya+7q9bABH/6rfTE1r?=
 =?us-ascii?Q?vfiuZFoexEOMJD5ejVO/oMuIvPwh3wKAn8Vlu/P8bMpVvAWmI/n6uj+Xuyor?=
 =?us-ascii?Q?prj+fX8u1EmL0pbRqXOqoH6fe4hqUM+9Kn8/AMXg8RNgnR+fZaJ8d8/ORCfJ?=
 =?us-ascii?Q?sWQk/WMrmJMb02kS1qNIjYGC1TJQh6lLubH0NWxQLpXDW1pzCIJEE8rTpPBL?=
 =?us-ascii?Q?lCGk/g9lsbmkNrzngeCJBKBaRlYM1iqvTG3WJN+DOods/046GT1rLOEyYS9/?=
 =?us-ascii?Q?V8seC5QVYGwVrsdCywx8peFDwZPNphgXbSsd+jIoKu8WL8wNRUlqSHSjS6Y9?=
 =?us-ascii?Q?X+/dYQhabV6jjmy1ABdiMlMdiF85yrZkqjhdwW8IZJGnEzG3O0U4S6ceDNot?=
 =?us-ascii?Q?XN6elnemOpqSh9Hu5kM79FnJkpEJJp/kbKd1kYDjOiybUyIsT3vysQQjkehc?=
 =?us-ascii?Q?aYKQaA59QvH5DDkUzW+1dx8fl/64+CoYr/uEsaBhIJ91KhEpDin99G4D0Bnx?=
 =?us-ascii?Q?POcTviiLLZeC+Gbu94CzV9IK2k57AxuIvKYte8o2v+DlUrcOUQi6HR1KHE1a?=
 =?us-ascii?Q?R1qJ8rSs23OfO52UZEO/asjtupZVx42Q0MNf2dobwBSNshTThay2ZJy5ADnD?=
 =?us-ascii?Q?2+aeeRo7OcoolAY8EIj57rIn/+6RPILavQJKxZEDxVbNo7RvS2IEKNuWOh8X?=
 =?us-ascii?Q?QGaPfN7v1cOnAVWZFqeO8sWRD7T2JtUnGtS0w7Jqm7y+UbCH272j0I8Nwndc?=
 =?us-ascii?Q?fY8njq7H7bfMJyH5liQ4lyhfreUQGMfz0ux4MdnC0gvSSyu242JFHh1qD5Xr?=
 =?us-ascii?Q?CFd6eLBEXug1urYBHwOE2bxMM+7R0jO0QW/5Ydb6MsHqQfug/uSvdK8231hZ?=
 =?us-ascii?Q?tOPZBmUMnK63LLRMjglKaj5eWPHYXxEU8UgHzu4ndTrHv8HxwS1KCvggdagU?=
 =?us-ascii?Q?+DZMoMs0bpvHHzuoAMzW1ouIyj1A4qrgwBjYVucOoxU6aYLdWf7nRpJyfUCT?=
 =?us-ascii?Q?vN7j1Yhj0jTvBbq4WaGvVAEhOwrPIDoEAxhCsyKrReHkh/20BJq4vzqeFa6X?=
 =?us-ascii?Q?ubMoNN3ES/Ai43kA6Kp2siSvlyPWrSltgoXvSc/CiQfLHCUqrgD1bJAe95+/?=
 =?us-ascii?Q?T3oPrMmJeQgIPeGt2QSyanTofm5GlEKDm3gerVgvlEvkOH6sECyVTbTc7cf6?=
 =?us-ascii?Q?8y+rA9tJ5oHpS0CCXkQ7TNjycjdevpR6yN8KLitPEam9hQImFHAzXl8zy11L?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d86754-b4be-4cc6-2e0b-08ddb8118a82
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 20:06:03.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcFMYxIUjl0sN/ZGsho3UdeO+1BO2ysCaGMZucawtNTk93VZQL25dA+VXWRTiU903kvdqg4RyaOrbIUnxGwSlRUojJS+MA6MoGO+RylH3EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6219
X-OriginatorOrg: intel.com

On Tue, Jun 24, 2025 at 03:27:16PM +0100, Jonathan Cameron wrote:
> On Mon, 23 Jun 2025 17:53:35 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Add infrastructure to translate Host Physical Addresses (HPA) to Device
> > Physical Addresses (DPA) within CXL regions. This capability is being
> > introduced for use by follow-on patches that will add poison inject
> > and clear operations at the region level.
> > 
> > The HPA-to-DPA translation process involves several steps:
> > 1. Apply root decoder transformations (HPA to SPA) if configured
> > 2. Calculate the relative offset within the region's address space
> > 3. Decode the interleave position using the region's interleave ways
> >    and granularity settings
> > 4. Identify the target memdev based on the decoded position
> > 5. Compute the final DPA by adding the decoded offset to the memdev's
> >    DPA base address
> > 
> > It is Step 1 above that makes this a driver level operation and not
> > work we can push to user space. Rather than exporting the XOR maps for
> > root decoders configured with XOR interleave, the driver performs this
> > complex calculation for the user.
> > 
> > While not immediately apparent in this diff, broader examination of
> > the region.c code shows that this work is basically the reverse of
> > previous work where a DPA is translated to an HPA. This is notable
> > because it demonstrates that these calculations reuse existing logic
> > rather than introducing new algorithms.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alison,
> 
> This maths still gives me a headache, but I don't follow at least some of it.
> Also I'm missing the application of the XOR Map referred to above.

It's there. You mention it again below, so I'll comment there.

> 
> > ---
> >  drivers/cxl/core/region.c | 85 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 6e5e1460068d..d2d904c4b427 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2972,6 +2972,91 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >  	return hpa;
> >  }
> >  
> > +struct hpa_decode_result {
> > +	u64 dpa_offset;
> > +	int pos;
> > +};
> > +
> > +struct cxl_dpa_result {
> > +	u64 dpa;
> > +	struct cxl_memdev *cxlmd;
> > +};
> > +
> > +static struct hpa_decode_result decode_hpa_to_dpa(u64 hpa_offset, u8 eiw,
> Having a function called hpa_to_dpa that takes an hpa_offset seems inconsistent.
> 
> decode_hpa_offset_to_dpa() maybe?

The naming and the layering didn't survive my v2.
I replaced the whole shbang with region_offset_to_dpa_result()
and collect the pos and dpa_offset pieces inline.

Let me know how that flows when you see it.

> 
> > +						  u16 eig)
> > +{
> > +	struct hpa_decode_result result;
> > +	u64 bits_upper;
> > +
> > +	if (eiw < 8) {
> Could add a spec reference. Other than that, this block looks fine to me.
> > +		result.pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
> > +		hpa_offset &= ~((u64)GENMASK(eiw - 1, 0) << (eig + 8));
> > +		result.dpa_offset = hpa_offset >> eiw;
> > +	} else {
> 
> This block isn't lining up for me with what is documented in step 2 of the
> implementation note on decoding.
> 
> > +		bits_upper = hpa_offset >> (eig + 8);
> ignoring pos calc as that is confusingly in a very different place
> in the spec, we should have
> DPA_OFFSET[51:IG + 8] = HPA_OFFSET[51:IG + IW] / 3 
> 
> So I'm missing a shift by IW somewhere.
> Perhaps some more comments would help relate this to the maths.

A couple of responses here -
- yes this shift "bits_upper = hpa_offset >> (eig + 8);"
  should have be (eig + eiw). I've added a MOD3 region to the
  unit test to catch this case.

- in v2 in addition to fixing that up I did a couple of changes
  that I hope make it easier to align with the spec.

  I move all the work inline, well that just makes it easier
  to read, and separated the work of getting the 'pos' and
  the work of getting the dpa_offset.

  I also spit out the spec comments verbatim as I do each step.
  I discarded my original mindset and recommendation to look
  at the dpa-to-hpa translation and see that this reverses it,
  because that is actually harder to do!  This is the translation
  that is documented in the spec - so no need for any reverse
  thinking.

> 
> > +		result.pos = bits_upper % 3;
> > +		bits_upper /= 3;
> > +		result.dpa_offset = bits_upper << (eig + 8);
> 
> 
> 
> > +	}
> > +
> > +	result.dpa_offset |= hpa_offset & GENMASK_ULL(eig + 7, 0);
> 
> I wonder if it is simpler to keep a copy of these bottom bits from
> before all the manipulation above.  They make it through untouched
> but we could avoid the reader having to figure that out.

Done.

> 
> 
> > +
> > +	return result;
> > +}
> > +
> > +static struct cxl_dpa_result __maybe_unused
> > +cxl_hpa_to_dpa(struct cxl_region *cxlr, u64 hpa)
> > +{
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> > +	struct cxl_dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct hpa_decode_result decode;
> > +	u64 hpa_offset;
> > +	u16 eig = 0;
> > +	u8 eiw = 0;
> > +
> > +	lockdep_assert_held(&cxl_region_rwsem);
> > +	lockdep_assert_held(&cxl_dpa_rwsem);
> > +
> > +	if (hpa < p->res->start || hpa > p->res->end) {
> > +		dev_err_once(&cxlr->dev,
> > +			     "HPA 0x%llx not in region [0x%llx-0x%llx]\n", hpa,
> > +			     p->res->start, p->res->end);
> > +
> > +		return result;
> > +	}
> > +
> > +	/* Apply root decoder translation */
> > +	if (cxlrd->hpa_to_spa)
> > +		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
> 
> Is this in the right direction?  I was rather expecting opposite of what
> is going on in cxl_dpa_to_hpa()
> 

For the XOR root decoder translation, the existing function is
self-inverting, so this just works. However, the root decoder
callback is not defined as such, so I've added a complentary
root decoder callback in v2, that looks like this:
in struct cxl_root_decoder
	cxl_hpa_to_spa_fn hpa_to_spa;
+	cxl_spa_to_hpa_fn spa_to_hpa;


> Perhaps separate spa and hpa in here to improve readability with
> spa == hpa for the case where we don't have a transaltion.
> 
> > +
> > +	ways_to_eiw(p->interleave_ways, &eiw);
> > +	granularity_to_eig(p->interleave_granularity, &eig);
> > +	hpa_offset = hpa - p->res->start;
> 
> Given people will line this code up with cxl_dpa_to_hpa() maybe a
> comment to rule out subtracting cache_size?
> 
> > +
> > +	decode = decode_hpa_to_dpa(hpa_offset, eiw, eig);
> > +	if (decode.pos >= p->nr_targets) {
> > +		dev_err(&cxlr->dev, "Invalid position %d for %d targets\n",
> > +			decode.pos, p->nr_targets);
> > +
> > +		return result;
> > +	}
> > +
> > +	for (int i = 0; i < p->nr_targets; i++) {
> > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +
> > +		if (cxled->pos == decode.pos) {
> > +			result.cxlmd = cxled_to_memdev(cxled);
> > +			result.dpa = decode.dpa_offset + cxl_dpa_resource_start(cxled);
> > +
> > +			return result;
> > +		}
> > +	}
> > +	dev_err(&cxlr->dev, "No device found for position %d\n", decode.pos);
> > +
> > +	return result;
> > +}
> > +
> >  static struct lock_class_key cxl_pmem_region_key;
> >  
> >  static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
> 
