Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8893D34BD
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603612; cv=fail; b=ZIbmrQF+ZGPfz9Y8UPqTQgrL2dxelQLDDAIGpRJW0EoOw8IUQUWgE4+daSsKrwtlHo9ZNNZaz8tl75f5briAcaZsjO8tnBC1qM/o+Bwdx54/h9vqJJ5IQR2RCoJ2YGC3OIR+wC+nsw6FZlZdlysl/T74XncGv5JZFsDXhRnJ5LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603612; c=relaxed/simple;
	bh=ZMUyq7bt6uef6PHR7SwLxGBqFVsVfs6NhgvFO5QfJcQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pw1CxjVjSkWb6pzMrDFz/Y3r9jcwxaI0qQgkMW9Q8ffRCbhn7YnzbIfLpj+oz30MqYQT8rSd3STw9hZCRFI8J3zFRHMZvlcwtRCt9IaQZO3mvPhZGF+ileJhs30Ad+yzLdz+kU+g3uzJafqP2eH2PA+vf/EhwjEDHws5W3k6YbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPzEe1+1; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPzEe1+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780603609; x=1812139609;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZMUyq7bt6uef6PHR7SwLxGBqFVsVfs6NhgvFO5QfJcQ=;
  b=NPzEe1+14rM5HH3rCiaWnqMSTZFc5HrRpzgtkTykRSTyG5zaU539Xnmb
   bVmFuYEg2VT9xVPs5apRS9u2iagMvxipitZ+FiWjyKGQbkw/0ydCSxh2y
   dcBv4yVmpvvMA8eKIfE6wqLTmz+YkuC/zWZqb6+2vSy1ld7LJFksXBk+O
   1wiWQTPTb0eLvwAfblDlLen4Stcitwe+38N8JlZEz/sqVyLmTsMb6kn+S
   8xIX/wbR/LsAfwGOeivXMbHIXUprGSWRChW58v6yde7YJ4d5CORGzwBTl
   qqrDGe/H7RSn1xk4topr1gofVRjz/3dVS9e0UjBvaOyOXq5Xuoz9riCtE
   g==;
X-CSE-ConnectionGUID: P74hYYf1TS24Tg2vnxWruA==
X-CSE-MsgGUID: MJvpmC/lR6mRDT7cr21G+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81183015"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81183015"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 13:06:48 -0700
X-CSE-ConnectionGUID: tVsSpjgeSbaiPDOZEd4ABw==
X-CSE-MsgGUID: Hhe9MnMBTsan6jDo3fmBfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="241654128"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 13:06:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 13:06:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 13:06:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 13:06:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsMe7Nz/tGBmAasG80dXauAhCkynvHs6+X8zHQ98yc8yTffKubB1eAdfEy21BUy9iBHK+4BeQuwDnbz5m+ioyZ2wdiVkNhsnVM/7YQz6sJ5c363QFrlFE025h8Z7JObb+I5TrbKyESzxrMMcSYbvUepue1zVyZK4ADZIaAfvJUc7ORGmHXj15SAWNCBjqewP4QPl+csInA09XHvbCySrYWuIgdSH0nV1BEllBXAMk3WYhyf9wXi0I3h6KHmdXORY/55YvBAiLuXO2aXE4sSoKj6qtCJioN0cIRfrzx+QHzBQYuZlVzLnit94TK8nVwabn/Pc2QMKUBiO7/vxGmJ/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Fr0aH4uG2ntJ8F6MQx7oluTQ+AWDz+tOolNx3j89v8=;
 b=a3UAlIXkQEI8KVBVZ5QWsz+FZJb7GWSZgsVIP2+KL7tsTqzsCq13jDAGYG730S0vadKEtrIZ72aCLdFo2JSymTtwBhHZCUmR8i3/7XnHRDQqH8mKaQEF30HD+OILDIx9/W54EAaz/KJRdaAXJUB4KXHTmD0qek/94s4oMMg6fRx/oXZLJwuBIzWjFL1xNtpnfZ8GXm5BKPN4oD9854C4I8wtDh6asw7CR/lj5oTjmGKKXiiU6IlPoa5pf41LChgAy7vk+516Ub/z9SoUwtjyXoSpCu93TUNK3cZkpwWf9HDeLbUC0x0UxUTJBbVumt+wwn7XLNSnS9PvDm2mjpkFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7668.namprd11.prod.outlook.com (2603:10b6:806:341::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 20:06:43 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 20:06:43 +0000
Date: Thu, 4 Jun 2026 13:06:39 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<djbw@kernel.org>, <icheng@nvidia.com>
Subject: Re: [PATCH v2 2/2] cxl/pci: Convert PCIBIOS errors to errno on DVSEC
 config accesses
Message-ID: <aiHazyufVUgQI_UP@aschofie-mobl2.lan>
References: <20260604180154.1925149-1-dave.jiang@intel.com>
 <20260604180154.1925149-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260604180154.1925149-3-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8891cb0a-505a-4988-8b9c-08dec274cc0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: QHaNg+XB4nLFCl6P6C0uD/1C1SfI9Kbk5TMRxz8gRYLthBApCMp5euTm1bK0ugnSgZiNR94SLoxmcLtNa/DToWqsU1iOwOBAI8T/UWBMAOVt8GIUmZmyWucGq3KX7nqqlTvsFzbdksCswBVurSwbCEsiPHyS8x9ZBK5A7z8EYCs+JPPKwapq/EjrUk0LJTty8z0fTptV5tE+YXUjUjAZJZvfG66VZAAc95fywY3dzmmBcSOn7lpw3CmrGUstFvQ9/Tv/cPNtS/MaiSQHf5yrjCKCwL9HandYdUwRUpoHTemuu0ani95IpDmCFZPpzsK6IGdVR+IfKgm9qN3kc/4AzlA9JOFtCo07GvhR0RcVvaOBMIH78etIvSbPl06d0fHnV8p2iEfkCXZj/f9ZuIx6yREM5iuxI0kNHkAzgPmAraxbkd+Exh9B8m/C24Khs+RrIdLLh4p+4L6ibmBkBoJJXUU0BGvGs3z7FKl55ToY4DWuaidE3GnM3w1toVGuKPmdsstt63QcYswoCeTNvXbp9CHwuXyQLws0ZDXGmKN2zHGdp9oFXzfd6cMN6SalyRtIAmWKd1rCfbrYTvT7tYy3OB/Hfl55Vrj7rB3pxKwBWxVt2Dirz56T1tg8u6W1CsoR6DiS9rNme7jPlt03f4PcLAg6r4EfN1EMJcu32EvoNRFGoH5j4WyNrSHwfqwdpbx3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6SuTEKNOBIYElYxTUx3wnGbytj/WHdKBjHE5d5WFPGpGpXpJGnx6nuZy4GOd?=
 =?us-ascii?Q?JM5ANGUo53OSxuuKRJzfGqma3ZB+dfWoMC1QoiNGV8QP6KrhYvQI7cStAFJY?=
 =?us-ascii?Q?McRvPuK2i487qN1H1sl1+2aCPD3Gp5xK8OoeKr1AzId30kyIrsKh85zRrs79?=
 =?us-ascii?Q?zcgzw4DjuRYg/Zf0Wh9QapHrDyFfYD11/eVu03o+n1rbGdp/Jn4hqMpKThn4?=
 =?us-ascii?Q?mWkbq5BOatVB7M1yerxX5nMvxdZr8GA8BzSkQlBtivYnw9FHAtxqiSgIuqXA?=
 =?us-ascii?Q?75mH9MmpUx+1QhwZMZLmRZSg3tGi3ntQNWuavhrLlHKRz3OKFSoMXS6vOUo6?=
 =?us-ascii?Q?APPxJBc0KXWnbbgiokURTkQpgZyN6PghREndnNTdWFoc2+pwuiWpKxRA0mDO?=
 =?us-ascii?Q?WVXDSlucp04wCpvLsKYKb0UIv3JVM4eyJ6p6u6we3Ko+RDJ7MbMp3ofKXuqO?=
 =?us-ascii?Q?U4c6AFSbkK0I2UxNiXTPAgnmUqpVQefuAIYYpvLHCPFlACLBoXEqQIQ/nYdp?=
 =?us-ascii?Q?67tFX3U+UhquLkRtTlgaq4r3N1Gaxgo6cv8YQgsdWwmJARZ2KoMh3CC4oXoY?=
 =?us-ascii?Q?9+OPqWbmcBNlYvmpLHHET7wNw6jIW9/rETU5MWgFYxcqSgFAmkbdDGh8+SKk?=
 =?us-ascii?Q?ISjOD832nZvX+u4ral0IKEa/NFUSnoMvaT95z5oDXQImJAKguIl9fiMfiaZk?=
 =?us-ascii?Q?+CfP09y5POHwAChNd3wyP8IrPPRm1JKyM8pMAg3sFznp2Ltt2X+S2kF5D/Vs?=
 =?us-ascii?Q?GI5gVb4Kym4YVzVHdDIY+DfHp6HRLlshtTaZ1pImnfIPej7/C1k+Rv0BcITz?=
 =?us-ascii?Q?TsjtAbjAEZLOcfs8e7wE5N2K6S/RfdJtASXWWiUY4zSCYS8WRDeZxOPdHi+D?=
 =?us-ascii?Q?LnWHiDPb9DFhY9h9DOzLttYHmpcOitC8G7c2i9jjSlgtnKSC3RzDyb8vDhch?=
 =?us-ascii?Q?RHrERasaxdMl+gaIC7k7zcdkoLArXXknTqCOr2zSXq1O4Davt7E4wsDFDhVQ?=
 =?us-ascii?Q?lOLq4VBReKtARUY3mRJn4pQAZe5dWU5ETlC2TfvPICTJZjeaDjHdW1eg6u1V?=
 =?us-ascii?Q?rUlNF6+6770EiyzgrtMoio7i4tEYTx0R9kYi5wwC+hIFa/mGjJG50T4+xTrw?=
 =?us-ascii?Q?dLLkEn0JV5kz9qbQefmw7p5U4dk2kEBPC0+DXNm1gga3zb5a7lV/Y/XGbG25?=
 =?us-ascii?Q?gTFkkAX1AMY3gqeOPu4CdWD0z3B/0VJaw+xQ4nCMW7eM9IZl+Tk9yjSe7WTb?=
 =?us-ascii?Q?gesSDVsH+7ZlOouT9cuXnfH7xeqR/Ujxv2KXgo20jY0YVIalUwlaL/M+qfWe?=
 =?us-ascii?Q?0kg8TUwrudMVdAoJThtKStEfnkLc5AYVTSVYHfjr32jz90l9Tsf1LR2oNU2n?=
 =?us-ascii?Q?K3ATtxgHKm0OGV7SDvxNYjYTSkjjvp2PIOSzGY9USB7WrOOjW7OpVt4U/mKN?=
 =?us-ascii?Q?vlwZcxxdV5DwVC+kUhOWuEEM+CMyLrK61E5Tauz0t2Q7TYJsLgPh2IYsxry1?=
 =?us-ascii?Q?sBLVVBf8fd0vFGvNEYSugkg7gB076noNoDPecn8BC2U4iizBxRHRNR3vAh9p?=
 =?us-ascii?Q?BZ3lvlnYsN7NMoLA7Fwd64dViSOFmCAiUpa37O76HRxnzNEbhRMJTZX1Xh9f?=
 =?us-ascii?Q?pguPEXWHEEqE8/EgiMAoKzIOUOrxkktW1WYBS6gvLkB4gXIFKOUPRuu73PCw?=
 =?us-ascii?Q?qRRpWXYU4OStRIYe1wtKcieBZ2YY9ztRkeo2lDVWJdkl1JmK3RXJCmd/xVfd?=
 =?us-ascii?Q?BS0GcL/qIBjfECJk4U1+eG1iYtjpF1M=3D?=
X-Exchange-RoutingPolicyChecked: sVO4p1g541XF/BU3Fk+nZfvgYK6xPhew2VwPKX6jh2By93THmSoRPJogrwrfGDKiUbHWzgs0mFn+Gf8S9ZR/YrgnOOAZmfbCrbR2Z9tL5vi/WPt78Et+CyrWQAZ8AwrY0CgRVLq5CjeNijZQPjEg6NEuVKFhy+ZDW2Eg20d+/tm+hIL1rjC5ytEAPYNlYBeDE7WufVq1bdNpoCWfKjylHNvPAAuvj7q3cCAPd95AxF5Hw9ZkO3DhV8dYtfFuH64R5qoDYEHxuCRpISCu9GtI2iEIFiunS0ITwnKHCRqlFepQ6ygrzm73slFDUq7xtQpTMs2TfXHX5Sc5bg3QDZwwoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8891cb0a-505a-4988-8b9c-08dec274cc0c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:06:43.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unyfSlflfjGSxydX7OufkBr6x4eXCx3TRSzf+yCnK4wVwUxWx01JM1CAfc8eGGbh+wAwqXQzUZE/39BoGsaX/dTBel32CWVw9coqyWj6jyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7668
X-OriginatorOrg: intel.com

On Thu, Jun 04, 2026 at 11:01:54AM -0700, Dave Jiang wrote:
> PCI config space accessors return positive PCIBIOS_* status codes on
> failure that are positive integers. Several DVSEC accesses in the CXL
> core propagated these raw values to callers that test for failure against
> less than 0. Thus silently misinterpret the return value as success.
> 
> Convert the postive error values to negative errno values so the checks

positive

> are correct on error paths.
> 
> While the chances of a config access failure are low, fix for correctness
> and to avoid confusion in the future when more DVSEC accesses are added.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

