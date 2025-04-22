Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CD426A092
	for <linux-cxl@vger.kernel.org>; Tue, 22 Apr 2025 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352769; cv=fail; b=vCA+Wlyrd+f83d9F6vJwMG8hQqEfV5mHRhXMviDXX/hhnA7yADPbrVEKUfHTTwUamPpCSyiMPGxZQdGuysHwU1PoOluMqBbaw8A0mQjyT2ZRDUGldU/S+NTSVe2FFW0IwAUbvv6+wIAW2VpX30ZRKlXWjIJl/waBHvl+8FwccVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352769; c=relaxed/simple;
	bh=jS97ckzvgHQdGYgJNhTAAgn7qfNmIqzSwtRlJCieUUw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tabZK+oAbTpOOIoNNFnBAwr5IMcEcAR6gpzzSirmObVmLEZpZSkPDlVncV53XcDCW2N7ywViq4yv7VUkjMpZ6RGBQIemqlmJayXV6w1moeMcFUN2sWedZ9UdIYwx32SSM/St2xiQWAaswnMr02GO2N/VrrvtMT5xuyrtt8TOFD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/domwET; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/domwET"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745352767; x=1776888767;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jS97ckzvgHQdGYgJNhTAAgn7qfNmIqzSwtRlJCieUUw=;
  b=Z/domwETV9qkulMHoYpeUNvw103HpXQzJUa3vok2GF/d4cGokwPwq7sV
   89C9uG/uwetPTpDSR0dHU0rhGl+EvEJwaDU4ocUurNscq9RYpbcfHIueQ
   tMVy1Z9cMCtoM4cuQ/cfpR9gLwAwI5WdKVY2kWXlyWxfzJnSU8uNeBH1j
   VNZcAkHOpT6wbiCpUFgfgm2mQyZaB4rOka6QewdmSwV2i3g6w7CkdQRpo
   Oq0RT1evxMMyXtVUHLcQ/XqKALuU1cD64PUWR2k3sgb589s0lI8AnT4Be
   VbcqX4i7OKeydiYOVQ9lj/CnLVTmHorPjW6ZDQe8IL5mcjjlfIJaZliqR
   A==;
X-CSE-ConnectionGUID: 7W9zEGdITxy0htQQPASfFg==
X-CSE-MsgGUID: 09DM6LSASQmBHAvMHMFHEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="49594124"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="49594124"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 13:12:47 -0700
X-CSE-ConnectionGUID: fBObiESGQLilT7sJ+jZNTg==
X-CSE-MsgGUID: srrLzkinSXCq1xXjgxGQVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="137188507"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 13:12:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 13:12:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 13:12:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 13:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8L4YB93qR97KEla0An70JtbLymrdvrLi/+TeUiWcNgOr6GbeHcP4yzEyCZoXLjBn3hCSA2BfYTiFYBFoNpZzTLFMHi7VE/Yzqt0hn9qpPiEmvamLlxUuuBfrXhk2aBc2O+hgIY3QbwKGjFo2tDdunO5jfkFjWnv45sEnc8IjpQpP2QPRfF+Z0wEfl18Tr+K1hj9CZ/+3OR1x3Cwlwcwd4Wyu9X+WWQvA0okiRa28wX7aUv7uZUgKI0ncrNGa6KiTRCqtSuB5CoAUlCb309Mgg1akz84PQY0+t3ufDs0XYs/JlCzQOuxTp/ljbJSsv+9V0MAd/800q+GFYb6B0f9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F1nY8FkiU4fJdu0Q+6cdTD6oWzcc1cOhBa+jrCnhu8=;
 b=OH9RN66lwQHEaLXN/frFhA2w5G0IVIcMu9UixRvehToCoOHW5NcK0k52a05988gRRfbZPaz8N4cm1k768oFGEKAsrIwIc32PzEyyElafYIFx9OkkeRS1tpQsXWBTCjLK88M5WL/1h9nfZFTM9IkOKqGqdQx3fDqmmExzJA1RK1zDDkv/hJE/vti+lggAL/oeuq1QDs8WzXxvPpc214JIMmJiT06DNHrN/X8YNoszDn6ztmv6SxrwIh/K+XPSu29v/BfJwpMjWzvURUULVIfUGOYjcalBWmiiD4Lnlv8XaVjdx5WPwx+60pEV/iefeT9wL8ufQT+6CoQNN0Ob/TuMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB8828.namprd11.prod.outlook.com (2603:10b6:8:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 20:12:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 20:12:30 +0000
Date: Tue, 22 Apr 2025 13:12:27 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH 2/4] cxl: Defer hardware dport->port_id assignment and
 registers probing
Message-ID: <6807f82b60c6_71fe294e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250404230049.3578835-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: bb51f703-cb72-4650-31b5-08dd81da0247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Ve/z72E92F44HuBS99Lqff2BKmYQhagOUUSsrD7Ml7s8kGuHhzjXxrKrAh0?=
 =?us-ascii?Q?4l31oPBsOj1fn2i6R9xTMHvE6DjB03ICZj/7MrW4+e4OcpeJhMYgyv8Cw3ay?=
 =?us-ascii?Q?E9HtTOVO/BtiNvn+P0WRbFViyIceBOVL03RupNr/18dcxc96yMTt128vs1Jz?=
 =?us-ascii?Q?opLGXpRlz/dvfj/Ucx1SKFQJxl043L187cjQgunouMQb2PKbW1o+KvvNGNhg?=
 =?us-ascii?Q?A9XexGko5EqHJ5A6LmXvMqM1b5Nvb8zedTQWvNG/RS7lA4B0o88mgFZYXmub?=
 =?us-ascii?Q?GT/G0yuw2QVwmse0TLzzpb0A4xt0t2R+bCFuWIe+qXfiDEUUgjwfY86h63PD?=
 =?us-ascii?Q?oNMHCdsM/VFh7ArpSRS4aJof6SshRBro5k+FaPVKAsGNpFexqyTNcOzYHFau?=
 =?us-ascii?Q?5ImZjzELlNeZcsrqioxWV2jdntJJ6+gdSpOIvbkI5gWb424R0mRzk0Sw+bD7?=
 =?us-ascii?Q?2KwiW7BdqtmoNhfrMF2x5X65kKgM1Vd/cCyoxJ5HUKWWO6EzS8Jw7k4AT7bF?=
 =?us-ascii?Q?gahcyD0NFemcJbEsHxB+Flw/f3uxtdA4odockP4y54IzljkerR7k0MT1GFRy?=
 =?us-ascii?Q?I3J2tGVUYwNEtTTLLqDbRfQztlpyNS7A04f3YBD/mZEfqo3pJclGzduEIFx7?=
 =?us-ascii?Q?NvRRF8cixHrEjjuUEp4Ia1VYW2axV2MBE8mFHvpufH3qrAuFdlLDyxADcm9U?=
 =?us-ascii?Q?2OyzuvWhb0WLkx9JTw4ViEm1fiCPPWYiVTo47PN5RLpc3HuxaT6B3t8hmWRr?=
 =?us-ascii?Q?BFz7Gved6UErSchM91vfTmFkTEIWSoDsHDt7iedyNjhC2w5D1S1SJDsNyyJ8?=
 =?us-ascii?Q?d4IJPNukG37s1VM7CjERD6xxbWnQIZzbGCJCeuwp/WVbTwTrR73dw+Wb2DKv?=
 =?us-ascii?Q?kfdkFwl3xxMwN1qIOGtoMSj1g1snbq90X8Re0j4tmpQqXfGo4Y9OEfJJsY5f?=
 =?us-ascii?Q?RM7DPoX0yMjgcPnuiNLI+yt/2br4YMestp+QelUdzaTBIR0Qy+eko2c0R+s3?=
 =?us-ascii?Q?decrTwQUetXWaXJGq73s3+xy+th6h+363+/2ySRa14foNPDk6XdCqh+B2z9+?=
 =?us-ascii?Q?g8vK9ywgfVPDHluH1RUzJ+HdWiEfWDi4K18T/URgoyovDXnPwijnzhUv08L9?=
 =?us-ascii?Q?wB7bGiwo2TqIGhZxojeZ8wYOitaEnlUXRGrqZPtlDG4FcvEnlfZCUmzD1Wz3?=
 =?us-ascii?Q?Ghunw/I4vFP6mvIOFs9/dwlcJKXmJAGBsnN87ejBxkLLM15hcuun76fGWf76?=
 =?us-ascii?Q?YKrXMihMH9E0ODElclmT80nrWHlvhfQmthpE3V+X31ziEpr1V8FIlKK+5R7X?=
 =?us-ascii?Q?inZCt4gBbD7sjvl1c6eHjiTptH2tlwGcCaPx9eDmBpw7ZqCIk33f6voRrRUN?=
 =?us-ascii?Q?CuKTEyl2PLEBT5moOGrpPbyyEIw1Soz6OaTN2TDvxIsiL25PwbYRO8diGeAj?=
 =?us-ascii?Q?5/+T9g64CwQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kH4yjXBgytdeb8pgA6fn0KzDJKOKUSY2sT1XOYK08U0QWY8k5KM2on2BTDvu?=
 =?us-ascii?Q?RjDH3SFwymxbc9FZMeSZFsOWsflK5rirDSHkuNIyj3Tqe/DByxgL0EC+U3ME?=
 =?us-ascii?Q?M+Xkzqz1GcHdw6R2D6YmXT/XVHd1n5HKg6iPeGf8kwJL6drzzPJMIksGuRxt?=
 =?us-ascii?Q?tFm2oRjxCcHP+kNUBUkmhpnMDEO+52zUNl9LeaeCgTtRODLn5R0usMJPMMwV?=
 =?us-ascii?Q?BoZ4B7Frgrzoqug0sOKMuBd68/C6mopKeTSuabUP5g46m+DdCHAW+MWZO8wN?=
 =?us-ascii?Q?5x3Z00PRB0tq+BDGteDjhgMfNFOIjfgYFpKZ6FChLhyMdesT/Q9HOGUDuHck?=
 =?us-ascii?Q?JZYmXw9AtsGnSi6mTjdERlDOLVpi0SNiynzCYUbuSpCY5AJXaLKJXRevGDOW?=
 =?us-ascii?Q?EakpfkS2b9QspIO8sMLJZOi7HAv51GTnWQi3+9GfsM8g2uTGBEXluLRJD/CK?=
 =?us-ascii?Q?dLjmB7O5QeILlkwYdlI2Nl+4L94urJuv/DOYBWWkVTKbzmgZ40h4HBV4nHxj?=
 =?us-ascii?Q?5wQpLqPbO7l+zueH+yL3exmz1TmO1iMoP8bLsNaSmjISgwPd3tMgj/BZ8nq2?=
 =?us-ascii?Q?3OVAc6IFKo7pHgFwkDvlHWwZLb7gQQE6VIZcvbPIKkywfLocEimdkWjnsaid?=
 =?us-ascii?Q?ISNBZCzuZAeDaMfGLJWPgni8bcJQFvZm7DCZ9jqRlTIJA0h2WJzalPjZTnT5?=
 =?us-ascii?Q?1F4DjwYg/T0FevvsM8xqBCQdA5tLy117tWnqveDDPvHve+vU4+tT+AQdTaNN?=
 =?us-ascii?Q?1gMzhNgUgxrhnxnsy9yFsQLln3V0eS+Lok9t3LTcE6Mn1zw5WaOEuuOJPiin?=
 =?us-ascii?Q?FhqcQ63P5LL/vYjIGY0dls8fQOBQGMQJ6uwCPC0ZCFopAwDXE/tm62n+hbvt?=
 =?us-ascii?Q?eOXS18NySlg/7k34/Yp56b1yZpNPf7QCH2jU5Eui1SdwzIqFUBZBebG/D/gO?=
 =?us-ascii?Q?m+FvpTcqVN9b/eufPuXz2aGSCPqnCB1RfOm796Xhu0aPuyKN9G++6NbH1qhI?=
 =?us-ascii?Q?umIsZ6rYltMsuw9fbcL0+4O3XiR+P6Yb46Ix2Pgyeexog7cnV1IaBxsvhc0g?=
 =?us-ascii?Q?mYlvsOwmtG+hPS2+rYsnc3IRoMxy8mlWVVM+YHYZiI6EYU5Ua5OxftF+Pw6o?=
 =?us-ascii?Q?SnNaXn+wQyTlONcnfUoykvg/XWb3LrTtzKDcoy2B+Lnr4GZ9JuW/h+WobcUX?=
 =?us-ascii?Q?/N67WfV/bk83BDWc46Q8wunBpDMsf/AI27Fay+efNbxIT4ofzWo8XJR9su46?=
 =?us-ascii?Q?fviDbO/VSU1b/9TAGhslB5063TxvGiN2peaEeHLsbHVxHSzfEQbNLtOBlPVi?=
 =?us-ascii?Q?qkrFFRIwS/FoAzGiuDWg/0IPTJ1uWJDUyzhk7H3DqrQ8018M1qMRspfg9DUi?=
 =?us-ascii?Q?V6EEhwjv4lxTPwYg0qKamagWPWg4wjgEy6+YZKDKSocSKc2uavNsoTC555Ue?=
 =?us-ascii?Q?xM5+ukfuf8DmGkW0W32u+a4Anw84sGvwJrD4IKD6u+lbn9Ygbafz02RI3F20?=
 =?us-ascii?Q?JejFfv9HlzSfoIp3NBmah0DevVzxNmfhdAvaAH9x9U2S0K+j6xvTRaguIc//?=
 =?us-ascii?Q?0m51jAW3TTHmS9je+7xtS+OHNZ1BcepwHdp5zui0MxqySwSOXK6Z0b8VRcGa?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb51f703-cb72-4650-31b5-08dd81da0247
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 20:12:29.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/VPcnRujiImum/ngTgtfb5qn9r348yWQ9DZUhWwKsBCstHYFcHQa1NQf8WHQHdDBfsOi5b85c3L4mv6D40071ghJfHZu/n/BFlEPqPEPbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8828
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Current implementation only enuemrates the dports dupring the port probe.
> Without an endpoint connected, the dport may not be active during port
> probe. This scheme may prevent a valid hardware dport id to be retrieved
> and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
> dport id assignment and the register probing to behind memdev probe so the
> endpoint is guaranteed to be connected.
> 
> The detection of duplicate dport for add_dport() is removed. The port_id
> is not read from the hw at this point any longer. The port->id will always
> be unique since it's retrieved from an ida. The dup detection thus become
> irrelevant.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h |  4 ++
>  drivers/cxl/core/pci.c  | 74 ++++++++++++++++++++++++++++------
>  drivers/cxl/core/port.c | 88 ++++++++++++++++++++++-------------------
>  drivers/cxl/cxl.h       |  1 +
>  drivers/cxl/port.c      |  2 -
>  5 files changed, 114 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 15699299dc11..e2822ead6a67 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -134,4 +134,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>  
> +int cxl_dport_probe(struct cxl_dport *dport, resource_size_t component_reg_phys,
> +		    resource_size_t rcrb);
> +void cxl_port_probe_dports(struct cxl_port *port);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 96fecb799cbc..a47dd032abd7 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -24,6 +24,66 @@ static unsigned short media_ready_timeout = 60;
>  module_param(media_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>  
> +static int probe_dports(struct cxl_dport *dport)
> +{
> +	struct device *dport_dev = dport->dport_dev;
> +	struct cxl_port *port = dport->port;
> +	struct cxl_register_map map;
> +	struct pci_dev *pdev;
> +	u32 lnkcap, port_num;
> +	int rc;
> +
> +	if (!dev_is_pci(dport_dev))
> +		return 0;
> +
> +	/*
> +	 * dport->port_id is valid means that dport has been probed and is
> +	 * setup.
> +	 */
> +	if (dport->port_id != CXL_PORT_ID_INVALID)
> +		return 0;
> +
> +	pdev = to_pci_dev(dport_dev);
> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +				  &lnkcap))
> +		return 0;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc) {
> +		dev_dbg(&port->dev, "failed to find component registers\n");
> +		return 0;
> +	}
> +
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +	rc = cxl_dport_probe(dport, map.resource, CXL_RESOURCE_NONE);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * port_id is only set if the register block is also probed
> +	 * successfully.
> +	 */
> +	dport->port_id = port_num;
> +	cxl_switch_parse_cdat(port);

Some commentary on why it is safe to re-run this over and over again for
each found port might help future readers. For example might this
disturb already published data for this port?

That comment likely belongs as cxl_switch_parse_cdat() kdoc to clarify
how it is used and re-entered for a given port multiple times.

> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_port_probe_dports - probe downstream ports of the upstream port
> + * @port: cxl_port whose ->uport_dev is the upstream of dports to be probed
> + *
> + */
> +void cxl_port_probe_dports(struct cxl_port *port)
> +{
> +	struct cxl_dport *dport;
> +	unsigned long index;
> +
> +	device_lock_assert(&port->dev);

This also needs to check if port->dev.driver is non-null otherwise it
could be mapping resources onto an idle port.

> +	xa_for_each(&port->dports, index, dport)
> +		probe_dports(dport);
> +}
> +
>  struct cxl_walk_context {
>  	struct pci_bus *bus;
>  	struct cxl_port *port;
> @@ -37,10 +97,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  	struct cxl_walk_context *ctx = data;
>  	struct cxl_port *port = ctx->port;
>  	int type = pci_pcie_type(pdev);
> -	struct cxl_register_map map;
>  	struct cxl_dport *dport;
> -	u32 lnkcap, port_num;
> -	int rc;
>  
>  	if (pdev->bus != ctx->bus)
>  		return 0;
> @@ -48,16 +105,9 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  		return 0;
>  	if (type != ctx->type)
>  		return 0;
> -	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> -				  &lnkcap))
> -		return 0;
>  
> -	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> -	if (rc)
> -		dev_dbg(&port->dev, "failed to find component registers\n");
> -
> -	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
> +	dport = devm_cxl_add_dport(port, &pdev->dev, CXL_PORT_ID_INVALID,
> +				   CXL_RESOURCE_NONE);

Hm, why pass in an invalid id for the common case vs make the static
case just manually "probe" after add_dport?

>  	if (IS_ERR(dport)) {
>  		ctx->error = PTR_ERR(dport);
>  		return PTR_ERR(dport);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e90e55bc11ac..1c772c516dbe 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1059,18 +1059,9 @@ static struct cxl_dport *find_dport(struct cxl_port *port, int port_id)
>  
>  static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>  {
> -	struct cxl_dport *dup;
>  	int rc;
>  
>  	device_lock_assert(&port->dev);
> -	dup = find_dport(port, dport->port_id);
> -	if (dup) {
> -		dev_err(&port->dev,
> -			"unable to add dport%d-%s non-unique port id (%s)\n",
> -			dport->port_id, dev_name(dport->dport_dev),
> -			dev_name(dup->dport_dev));
> -		return -EBUSY;
> -	}
>  
>  	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
>  		       GFP_KERNEL);
> @@ -1120,6 +1111,45 @@ static void cxl_dport_unlink(void *data)
>  	sysfs_remove_link(&port->dev.kobj, link_name);
>  }
>  
> +int cxl_dport_probe(struct cxl_dport *dport, resource_size_t component_reg_phys,
> +		    resource_size_t rcrb)
> +{
> +	struct device *dport_dev = dport->dport_dev;
> +	struct cxl_port *port = dport->port;
> +	int rc;
> +
> +	if (rcrb == CXL_RESOURCE_NONE) {
> +		rc = cxl_dport_setup_regs(&port->dev, dport,
> +					  component_reg_phys);
> +		if (rc)
> +			return rc;
> +	} else {
> +		dport->rcrb.base = rcrb;
> +		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
> +							 CXL_RCRB_DOWNSTREAM);
> +		if (component_reg_phys == CXL_RESOURCE_NONE) {
> +			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
> +			return -ENXIO;
> +		}
> +
> +		/*
> +		 * RCH @dport is not ready to map until associated with its
> +		 * memdev
> +		 */
> +		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
> +		if (rc)
> +			return rc;
> +
> +		dport->rch = true;
> +	}

It seems a little bit awkward to maintain the RCRB code in this path.
The whole dport mapping problem is a CXL 2.0 complexity. The CXL 1.1 path
should probably be separated from all this deferral logic to keep it
cleaner.

Keep in mind that devm_cxl_enumerate_ports() early exits in the RCD
case, so I do not expect this code ever runs if cxl_port_probe_dports()
late in devm_cxl_enumerate_ports() is the only caller.

> +
> +	if (component_reg_phys != CXL_RESOURCE_NONE)
> +		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
> +			&component_reg_phys);
> +
> +	return 0;
> +}
> +
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> @@ -1162,40 +1192,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	dport->port = port;
>  	dport->id = id;
>  
> -	if (rcrb == CXL_RESOURCE_NONE) {
> -		rc = cxl_dport_setup_regs(&port->dev, dport,
> -					  component_reg_phys);
> -		if (rc) {
> -			ida_free(&port->dport_ida, id);
> -			return ERR_PTR(rc);
> -		}
> -	} else {
> -		dport->rcrb.base = rcrb;
> -		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
> -							 CXL_RCRB_DOWNSTREAM);
> -		if (component_reg_phys == CXL_RESOURCE_NONE) {
> -			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
> -			ida_free(&port->dport_ida, id);
> -			return ERR_PTR(-ENXIO);
> -		}
> -
> -		/*
> -		 * RCH @dport is not ready to map until associated with its
> -		 * memdev
> -		 */
> -		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
> -		if (rc) {
> -			ida_free(&port->dport_ida, id);
> -			return ERR_PTR(rc);
> -		}
> -
> -		dport->rch = true;
> +	rc = cxl_dport_probe(dport, component_reg_phys, rcrb);
> +	if (rc) {
> +		ida_free(&port->dport_ida, id);
> +		return ERR_PTR(rc);
>  	}
>  
> -	if (component_reg_phys != CXL_RESOURCE_NONE)
> -		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
> -			&component_reg_phys);
> -
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
>  	cond_cxl_root_unlock(port);
> @@ -1684,6 +1686,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  				"found already registered port %s:%s\n",
>  				dev_name(&port->dev),
>  				dev_name(port->uport_dev));
> +
> +			scoped_guard(device, &port->dev)
> +				cxl_port_probe_dports(port);

A comment here would be nice to indicate why this port did not probe
dports before.

The comment would likely also answer why this is only called in the
"already registered" case, and not the initial port creation case in
add_port_attach_ep().

> +
>  			rc = cxl_add_ep(dport, &cxlmd->dev);
>  
>  			/*
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c942fa40c869..0e61b76f5c13 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -345,6 +345,7 @@ enum cxl_decoder_type {
>  #define CXL_DECODER_MAX_INTERLEAVE 16
>  
>  #define CXL_QOS_CLASS_INVALID -1
> +#define CXL_PORT_ID_INVALID -1
>  
>  /**
>   * struct cxl_decoder - Common CXL HDM Decoder Attributes
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index a35fc5552845..30c0335089b9 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -69,8 +69,6 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	if (rc < 0)
>  		return rc;
>  
> -	cxl_switch_parse_cdat(port);
> -
>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>  	if (!IS_ERR(cxlhdm))
>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> -- 
> 2.49.0
> 


