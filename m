Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB821C168;
	Mon, 31 Mar 2025 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743465018; cv=fail; b=Nhos+BYSDamJjcGQVll7gtlWW7ETfOMlmxihl3qIE9Yydowk8/jjEsYd4zcGkKivc4y8n+5QzQZD3kcTUM2aDkL7am7TvRgCMxLXUBqRUErPxe5BvQVGKuLIEvmyyI3old5i8VrwyDqReBrAfyy7KxxZKcwwIC9Dpq3QDbtky1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743465018; c=relaxed/simple;
	bh=QvSUfcabOogjfyquT5nRKJ58JkJEiJMsu/9GR22GCgs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QPxs6uupUSlEmu6ywCpn8GxJ0cVS2fqTM7+uGqNLY66+novlb3oVO72fvqX2BossTjEjCApBuv6wlIoKH4CVEaaS4THvjFUNi+NqP17PvjrmXWh0FGAKu5qQVrNpNq7OAQ/TjlWUnzKE/MBFxiywU+XqUHGpUsUthLjux+dvlL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bW/wlAzT; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bW/wlAzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743465016; x=1775001016;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QvSUfcabOogjfyquT5nRKJ58JkJEiJMsu/9GR22GCgs=;
  b=bW/wlAzTm2cRgmKa+fe7mqhy2U4rFiWwX4vpCaIbgJNdGFuCaOk6HTT3
   6rpSRquVPryDgxcyrXNQaYVnsylCgGViap34xfZOKEiDB7pLKvs/oxX9F
   EwOjpAjugnoUNukhq4bEJqSpYuqC1+DxfpQk0s/bx7MGbCJcJrPW41C57
   wNFoyguf4/jkN+JnGpcV7QoTfeA7IXoWtKaM1eCe6lvsosM4LNlNzfUfR
   U319yxPkwsnH0eeIzkkq4zwGTA66FJFFbeJ99ttcQ9Ko5qyE5ZU3duTDn
   khA2hT62JONc6fHt9/kmTA51WDm8hSmqBXIShB+9lKR5xlXnsZ1xopoUu
   A==;
X-CSE-ConnectionGUID: gdZ08AIaTrmPPjYfaARCNg==
X-CSE-MsgGUID: kKTtc1DSQ1qcL5F7dcxHTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="48558413"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="48558413"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 16:50:15 -0700
X-CSE-ConnectionGUID: Y6giiR/bTCKRdRDfMTUyAQ==
X-CSE-MsgGUID: lMpXCBAQSvK4I7+FvQcU0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="149414435"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 16:50:15 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 31 Mar 2025 16:50:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 31 Mar 2025 16:50:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 16:50:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RM7MQxvYsdYQQ3pvv8W8ZTremJQnt7q4U0iwJrHFPcuGCFKBXSiSbdsz0VViIpBR7xLl5MiLjQ/HQpXNaDLge+Er1K6AAhYenFIdt8ehIcdc5xJma9ZIZ4TODLgFD9aciK7JvA+jDJQQyxB1da3XAahSrkDs1UjpCbxRGpX/D1PSkzD9rwQ1QV7Py4WeegdiNVPz1i0gNxZ0ZkV//MZQkMm86oMoix0YFr1u+VPOJm+Ocrh7eX9krZzFCQPgTKpVYseRs0x8wnAx/6LTM1A9hlNb+eEZN6pcdhojUC/iZTxKnpcNH+4fMp5YOYXNtOFpYdAw88auaBc1EEnrmOdRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CG2khEzZICoGJH6N3HE179qCPYT6OGQlrQ5ToyLhTw=;
 b=fK+hue4QMOMhIsf4e1RAMwd4H3E2xRZ5u4ReAVegGU57nA4egiUEccIpjvdumlHp0OjI3DWXTwXo0KunDzR5br2ifDfeHVGns1EcsM1VcwdRjCcoOhaW7kvB41fyi/pPuzRJOyOFWFfMk2m/SYQbFEFa0XRt4ZuVuLT6XL37SjwjxkTn6rc9hEWpJmaVWlvkJC+DqmIosVnmkchF2HTHV1Pw6K19me0fUxNdQ/+/6PUa/QVzsPi5WQImcUZWTd+RphYDNiIjekNZw0SUzKPFI0VONtWP0ELLUdNzwnFOd76sRPktXa2crzFK+qMjOSE7TS/ihckzRJIlTmJj6uQE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4755.namprd11.prod.outlook.com (2603:10b6:5:2ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 23:49:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 23:49:45 +0000
Date: Mon, 31 Mar 2025 16:49:42 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, Dan Williams <dan.j.williams@intel.com>
CC: Yuquan Wang <wangyuquan1236@phytium.com.cn>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <lsf-pc@lists.linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux
 Resources
Message-ID: <67eb2a1666a9d_1198729477@dwillia2-xfh.jf.intel.com.notmuch>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <20250313165539.000001f4@huawei.com>
 <Z+Ubvvrj9DovVs71@phytium.com.cn>
 <Z-VGN79KVjuRg41K@gourry-fedora-PF4VCD3F>
 <67e550f39d57d_13cb2941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Z-V-jXYsOfQDvCzc@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z-V-jXYsOfQDvCzc@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: cb444d5b-9461-412b-0b79-08dd70aeb6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4zC1op/yI/HtTd8y5F2XfA67mvrQ7Ibf2cW6NAkk0YyCRjAcEhcmFowXar0H?=
 =?us-ascii?Q?Emmt8Y0e/ZCdmlV0dFVDse8Me9S3iTM6ZZNtu5bmLddzFwtDh16Hhl7AA3qR?=
 =?us-ascii?Q?YKQOcKvPG0xIOmyeSyBzYvFhNxGEuCILmV8To/bHEdntSsyfmuMqzn50LTCF?=
 =?us-ascii?Q?3zZSvPk0tOnk1W3H7Y7y1w5qw7IGIgjMFFcMxNFLroVRk8oKcC2Kb26ew7x+?=
 =?us-ascii?Q?CSMBcMjxrbrFUxPMiNpjA2LA4ZHTCvgC63I0soF3qGlOzboMA3ykeeOKQf+q?=
 =?us-ascii?Q?DN5M03B2i6hzzeTM3tWXEIfxnGzE2uyHbMypziN2H/1hkRhWpCWW6YfKJg5G?=
 =?us-ascii?Q?5d4bE437Eahh3DsQ8QaFyWkfp86Za2eBd3k5eo5mgTtIthB5MKgCMfsdez9S?=
 =?us-ascii?Q?vg77e4i8DcWZ9YEYsrH0qVFZbjHizGvlsaFQ4GkWzGFht6sg2214qC0z5khW?=
 =?us-ascii?Q?llpV9yYtMUuuxu0tnzinlMdv0srqNey09xxRDAm+qFIJwlpVvWvlTWBbi8MC?=
 =?us-ascii?Q?CrNY9qJM0IWNQID+fqp6ZrxYYzZZkVgbtCzfzes4a31Cp3SKohe9fR+ukraB?=
 =?us-ascii?Q?ymA4pKtgxeGMr6HDsyzHgriQh5tHuoBKPPJUSUoakxpbwcmbMdXTXFP/FzsA?=
 =?us-ascii?Q?u4+yVU8gw/z4+czR+XHwsUOFvT/0EzwXcVvjFEBOrbLZBSBV14Dvjz/HcpQW?=
 =?us-ascii?Q?Ni3CyalPa40Z4f/ZX1iZJM6OzTbj7kXvRBhEd5IrH9vhkIovLRNDzDezV9LS?=
 =?us-ascii?Q?RRsT8mVYtzeJaJgbXjT0tCTE3o8NUUI5g7LBb2cqafG0gNW1CwzvFTxoyWPs?=
 =?us-ascii?Q?XS76Gh/Fr2xt6oA85reriwXVvCRhoIS5GAkGUfM7g9mJFK8k+hkuPnSE8YDv?=
 =?us-ascii?Q?P8rYSknS4DNzhwgXFFlQdmU6HXDv7M4xtfPZSazEKVxHFAl3jSWXSJqJ5tch?=
 =?us-ascii?Q?ALH5007/hh4Bkf76bph/twTBGKUHiNeZvKPMP5OCpcz4zBtCjfGPUN5lnvwW?=
 =?us-ascii?Q?jtOVsDGB03dI6zsro7gA0d37QFQNLaiww09Gt1jfNZe5ktUWBxBmJltokfnc?=
 =?us-ascii?Q?nMIRRAlgs0R2FMfUGWtp7HzQGFGAQduMdXd4cNHvbIS4nWF5M0uj3gKh3GpP?=
 =?us-ascii?Q?8cZYWig1gUtoMEvk15/VugSokx8F6JGPQmHo95TzS1AyS+hzhU8q6wHDbNdf?=
 =?us-ascii?Q?Q1DDwTLz9na893a/3vBzyAc1OAV4ptA1sIB4NPkzKtG/e1zPv996AQspv7vA?=
 =?us-ascii?Q?Ss8cp3Lc1G/o04KFeZC3kg39T27UxUPhX3Si5kuWdEcZ3WQ+g9UUb/bjaryn?=
 =?us-ascii?Q?8v2x1UoEpXImBhubS7LVb7YIhWhTW1G9MdsmcNczDfMssO/NkKJSpt/Z34jv?=
 =?us-ascii?Q?E+lzuNq82IH2wi/6ntvpc1lmTDLduX5idkREvdoiotyqkZJuCbcuoIhdx1dM?=
 =?us-ascii?Q?UbUZj5xWeYg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MMvXayKwHY+KNSGeSMvd7dgbE9InUyMt9hgC0yYCaKvvIwNVVeqOirJk7JQ8?=
 =?us-ascii?Q?LGLcKnqHEa4Bu2JdLkMrnVkIIgBolP4yQ2hCxBF8azxR8xaBt/SKJMdYm172?=
 =?us-ascii?Q?y85mlKp4KQCfxIQjYVsNyNXkMZtJBwfcVLgZjm7kMOJvXJCPUaNUwbgqlskv?=
 =?us-ascii?Q?C+U+wKG8h9nDtudeJY8WlmDR8UFf+1Fxs0w+ZwRpz2lRsiacxX9RzW27HbDd?=
 =?us-ascii?Q?lr8fzV58hanDI9V4QRudlK+r5VrSLVmruZPo/m2SADz2djuVpM9bBdmCMXXW?=
 =?us-ascii?Q?f+1cPMQiYnXX8ClFw4hA5HjlLy/5Um0xXnnN56i0YuKPmo5eBn8s7pysOSQX?=
 =?us-ascii?Q?Vr7R7JYMgoRvLBKH5C1adpMpYG9e4UVZRh5OmQBphI9LTAtFURZ12+3Jg/u6?=
 =?us-ascii?Q?+B8m8z+AcZPL1ZRnLJF6Dg0OS9sO8D/mBL0QxnRupKpUOIK4sL9av0IJ9nVq?=
 =?us-ascii?Q?o0eE/ZEPwltT8gw7MCiOf2AeGkwEcQ/9FGimTjf6Vqppe+5zoTieS0IK/UmO?=
 =?us-ascii?Q?6INVP0izbMTcMFjM1e9Hj93ajQ5rYFQY5la5HHvmsE5JkN2gzn8HrcUmspda?=
 =?us-ascii?Q?nOnsP6v+8kqrJv0nsWsSnAD8KlLZWJuVV6/6sQw83q9SHOHtjFENBfQDw0t+?=
 =?us-ascii?Q?7KVWF9MwheKfJPbaFxAMuRDMDCwHCdMugdYNuRuK+mUtK2GoV9TJNDMycBOX?=
 =?us-ascii?Q?7IvGkJQa2ulcoV9FtaMQfhpgvTFLlzEpfZ2D+3AVdQzeibGmmiTsBmxZ94jx?=
 =?us-ascii?Q?d8qh7ViGHx+HrHjWcq+XhwBgR9DFCCDr6uNl3Sy5q5+ka4mli6UDyLcWi+ph?=
 =?us-ascii?Q?5EA0JhGLsjh75uy8jpj2bAgCY0uZuwSDGnbPDwBH8NIpZNGEFQoj3Qbzu7xJ?=
 =?us-ascii?Q?ZnqHTcf0VyVO8zrgffDJI73BZppKmqoZ27/w2B338Vl1kjlqC5lHdl6ZfCTE?=
 =?us-ascii?Q?v+L746yKwnvpIlFyQc8QSnHVgbumCcppwbMQVEgLGO5Ma4ZbWlaRKa+aVxJW?=
 =?us-ascii?Q?MJp/0JBSvhO+W/xsUzZML3Lu5kDetOnSaXmfLcp3YC4nZ9+JEBkVTi/SQ3Jz?=
 =?us-ascii?Q?uvxn64HBkWGiFxT9Mm/cI8Hk2GuV/CWk+3OcOFXowlBtYG1D+GZeFMdEQ5Rj?=
 =?us-ascii?Q?Xp1x1Yb3JoU7b48W86F4BSEsqqHJPDZFXeZqcrxos+K1gWNEvd2Ww7pK3JxG?=
 =?us-ascii?Q?EjyYCwmUVJJK7O3C9ksFAIBX60GEaXgQHYdrYbnNnCIIlnlRR4gegzdAkPHw?=
 =?us-ascii?Q?4LHWHIax0nIE31qSW0vp1xgrOC5TpROuZrCgfcjT+dhbqxLA6+S9oPOGzoHC?=
 =?us-ascii?Q?HGf0uNpdAecTaBRsCMQzaAa0QKTkutDe7linhR10VDZNg1EQGdBMehVjFUPa?=
 =?us-ascii?Q?jHkQ5slOvML5J0mKYS1rhZo61iHRE8wQ2EZhsDo4UJ/Gy3rpkpaA8/huSiki?=
 =?us-ascii?Q?f4FpBva/AeYRpO0JnVmTOB5eiAy8h8sP+4A3wtL7IINYn9l7jvFLhymPwTj2?=
 =?us-ascii?Q?WERJX3vy9V1n0wVUtjholn/DVh/HdoO+EypFFwb3kAiz65lPVT+Ul/t+cTAL?=
 =?us-ascii?Q?SPxFJnAtIYwC7ob+MqqS13W+Ti9Mhg7dtf9IkF1Ftq10s6Lj0HoBA5qkod9n?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb444d5b-9461-412b-0b79-08dd70aeb6ae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 23:49:44.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiRTnuO6xihI0jD0NskVk0y0a+ndKdlp3mNP8BP21ADlAlrBQtEmi4POiiqUrpPvo2cUjUleML//ujiYJ+6rtObjduFuD095P+FaFWM3BXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4755
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Thu, Mar 27, 2025 at 09:21:55AM -0400, Dan Williams wrote:
> > Gregory Price wrote:
> > > On Thu, Mar 27, 2025 at 05:34:54PM +0800, Yuquan Wang wrote:
> > > > 
> > > > In the future, srat.c would add one seperate NUMA node for each
> > > > Generic Port in SRAT.
> > > > 
> > > > System firmware should know the performance characteristics between
> > > > CPU/GI to the GP, and the static HMAT should include this coordinate.
> > > > 
> > > > Is my understanding right?
> > > > 
> > > > 
> > > 
> > > HMAT is static configuration data.  A GI/GP might not have its
> > > performance data known until the device is added.
> > 
> > The GP data is static and expected to be valid for all host bridges in
> > advance of any devices arriving.
> >
> 
> Sorry, just shuffling words here for clarity.  Making sure I understand:
> 
> The GP data is static and enables Linux to do things like reserve numa
> nodes for any devices might arrive in the future (i.e. create static
> objects that cannot be created post-__init).

Small nuance, the CFMWS is what Linux uses to reserve numa nodes, the GP
data is there to dynamically craft the equivalent of HMAT data for those
nodes when the device shows up.

Recall that the CFMWS enumerates a QoS class for each CXL window. That
QoS class is decided by some (waves hands) coordination between host
platform and device vendors. So there is some, opaque to the OS,
decisions about which devices should be mapped in what window.

See "9.17.3.1 _DSM Function for Retrieving QTG ID" for that opaque
process.

Linux today just reports whether a device has any memory capacity that
matches any free-capacity-window QoS class, but does not enforce that
they must be compatible. This follows the assumption that it is better
to make capacity available than perfectly match performance
characteristics.

> If there's no device, there should not be any HMAT data.

...beyond GP data.

> If / when a device arrives, it's up to the OS to acquire that
> information from the device (e.g. CDAT).  At this point the ACPI
> tables are not (shouldn't be) involved - it's all OS/device
> interactions.
> 
> I should note that I don't have a full grasp of the GP ACPI stuff yet,
> so doing my best to grok it as I go here.

Again, no worries, this documentation is pulling this all together into
one story.
