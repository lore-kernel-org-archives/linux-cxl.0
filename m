Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FDE1E98E3;
	Fri,  5 Jun 2026 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682411; cv=fail; b=nRnYicrPfC8Kf5wmHtK3jfloD2knu5wUwi57APSgoX8ASzb1xjswaDXzA3csW7LgU2VririL7GJR/izL24yE/3GgVcbjWzAXJ9gc8rolVAIVQ2mgqCFhiWLA5B4/g+uE3V4biPQvjP0dwUBcZK4V+O4JP7VssdL75Ols7r7MCDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682411; c=relaxed/simple;
	bh=G5hJca7GKm+knfAWqznvf4pwe+lNGE1Yov03YtOKcE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qwNN5iDLcqmlK2j8dJBoRX4ghOKnAZPKhVGrpxbfpJ0VJa0PLsS7YQkGBDT0CRiFkN8maG4JT7mhdQKI3Vad/WBmMztEhe3i39WX1ckUQcKRL+J27e7gDOZ2nH15YEKyVP05uo8dhmuPAh67ggWrUEnzyu5J3oUizgmIQbGt+VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gw4vI43n; arc=fail smtp.client-ip=40.107.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gw4vI43n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stF4OwHbYT+xkUwlB4L6T8XqVg6EefENHWE83yzWQkoQ7AGvkWlZ8Qjh/D3f31FvZfWcfkHQ83skki2O31qjIcMFw0OXfdr1NIGu7l6FiLmeQMSNRxZK5vV3hgZ+QYbGg1ewbCz8zKzzwIhnTn5qYUGs5Y2/Y74c29enQI14P5ahrocqn6LtoBOjrCnlHwMHFOm4ds290XnZPKYX5K4BqZvb9c2f0fB87gQFgHLsnnKoif/34B4HuH0GiH0l/hYhcqJW59lR/VRgpI4XC4t+Z5okGcqcmoXlQ1DHN6O28tB/k9pnVGO1UJGQXuiTW7Uzj+/cZevVk9CDagOvj1FvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdZj9PXKqeSUdf6HTwQVxJNgki9EUiKDdagFn51EJWE=;
 b=yDRsCHdf2QgbSlLCSpBD+OjPklDPmiLfz11qTTXRual2v8w7wxtAQiX5U2ZFH8mO0hYSKkc1Xeqvt72Jcs+c5Esc8Afzcj1hdz2/GGX4CKRzNjxacNdr1Z23wd8RJtPeOBk3MaLjtqRtfnxXhIqnEu2jhe+6GNKfHDdEvqALHZptIjBt+u2G9kPmfO3wFnHMUwvK6iekms5MwYBm3aqQun9IoGMI/drpT1SUuko3enbR5nulJF3EsLuwCW9HDr/UWVqAuJFGVgDSEgw95Z12knjDbNgM/FxRLURneFvqU38OMnBpD9fTamWSlhUIsEoXhTQIx7nFkgC6kSiBDuSMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdZj9PXKqeSUdf6HTwQVxJNgki9EUiKDdagFn51EJWE=;
 b=Gw4vI43n4+3G5nqiSrmsS2rDQYhcF+5VijKrNEOgEQAFg9xjvJrcaHaRgDtFKsZ3+fxAaQRFAlQ/yL4wSjhb/GNTsO+I9gXjU8A5duxZ/A4GPe2a/frETfkqNSm2MUDmFG2+YJh4D2pJzMLX7MpUBB5GJEv7z+jgGYFgz9ZZP6d32+JhONfzj6or9/XCO32o3430gCdkrnsi8G877AWHVxdsypZmF2Wk9bU0RrQLyc20o+THosu5V1cQx+f5qRkFV0XlGzbRGTAgTNQ7NKIt1dmqj4hsahZs/AtpfsU5lnq7GRxktAFLhyIBhAWJEpGpJsWTcrZi3V8Ms5Z3EaCvxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:00:01 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:00:00 +0000
Date: Sat, 6 Jun 2026 01:59:52 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net, jic23@kernel.org, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, smadhavan@nvidia.com, 
	vaslot@nvidia.com
Subject: Re: [PATCH] cxl/pci: Fix out-of-bounds read of the RAS Header Log
Message-ID: <aiMOX1Yu8MSa0F2m@MWDK4CY14F>
References: <20260605041602.37944-1-icheng@nvidia.com>
 <951d3e9b-f9f4-4d16-8119-1543ed9e44f1@intel.com>
 <aiMAVuHbjXQGaCf-@MWDK4CY14F>
 <57003a84-45c8-4966-ab8c-d36f3076bee8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57003a84-45c8-4966-ab8c-d36f3076bee8@amd.com>
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a83e30-a664-4f80-3e4a-08dec32c42f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|18002099003|22082099003|6133799003|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9Atdbf+RL4E6pfrixa3eRGXZYzINLizNZICE54XnQfi084GPPqA8grOC5Fp0nKGPkIrn9z0DJjNsg4KFJNS1BaM6jsL9HXuimzBWBPhCzjLS5YMB+tDGrH4JMktd4/ceC69Oeevi5h85Te+H4R+J9cKadVw5wh9VOontGqpDTggmfXB46lAGgGzjR0madXJZuQPelR47GbCdm3ZKebG6yY4CifgBLpxUWc8y0vW+pCHUSGvPcTzpKd+v6CtAchEE3Yz8sTJXr/K0tN9Pxs0f4fuLFifrYplIQt1rAezZIXTFiRD3en7RvlE3qJsmT4cn3ZAsbVtcPbnzQbSpmT0oxkWHmRiNWvGuDZXRR6Rc1PzXHuoXWn92QyapZ4l1nVmy5XS3Tq2eqcUUmwitWbRHrMXjY2B0hRfgV68Y0ekni8Rl2cjIflgP39CH4v55ZiVPIArs7Evh8DFqIu9jo3H5QI4egWD71fo2FROAp6XTiHSVEWE7IRqZZsS1A4jA25grJfSxZzXgBwktpKxZ5lyaKdqzlgsD+KY/9oKUxCiFIm9gf3bgv8zvUoEpJG1RQU/qnct/mIA/cu98OYYMw3vNlhNywixuMXonOjao0udV622fZ7wiNlBBES/nz15wWL9TNAJcq3q+r/a/79WI2txrGWC3ARcKrIwdsKjNrm8+MN/pgCq5rys4NL/56fuia+j1rYM2EhQof7W1NKvNXYvLng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6SYFdqInXHhezInyyDmGkSTTiva4Ri0c5vue7rNkLiaupw1djrm8SIOAJGcC?=
 =?us-ascii?Q?i7leZCQ/xMlnSTisAarbRJSrnJ2/gQEpBS1oAE3sCdqKh25HJRkmbP8wqV72?=
 =?us-ascii?Q?es6B1N050Dmnq9PN8uemGI4dQ21eDEF5HBTsVdp2ta2VxZHBL+gsHkfHF1nF?=
 =?us-ascii?Q?C38E9aYF/+r1uSkUb/3+AsUn9FKCCq5zdTs9/vd3TnLCrdae8FyjOUCRWSu6?=
 =?us-ascii?Q?s/GvFVK5xAkT3YXz6xqAWXGVvroWOJHFXsFdAuzF/NzyTUkrLT61uoENRak2?=
 =?us-ascii?Q?ctiv3rKhKy6wo7vKU84PZp7j9n9w6YGEQBd9oy27fwE4IWvnCJvJVdi1McKn?=
 =?us-ascii?Q?zfBZym1wowJMVageMhqtdcwjHljARnMfEzj+tZAXTf2MBd+/uX+eF0hvBiNI?=
 =?us-ascii?Q?u/tUSLnBgLKvt4QcpDinLPY/QeyUmYPFPhHzxkPw78AEjeIiDnbjMxVy5Qgv?=
 =?us-ascii?Q?ljY5K/RdrlAqTNv8Ej9G/HcrkTNrt3tw81chF+BLKe3ATpov8o4KQnNYNWGs?=
 =?us-ascii?Q?pWqlHrBI86rxCM9+BAOvqpz2SnmrOxKUe7xKvmUb0GWYqtAs7d9r/aLC/YNp?=
 =?us-ascii?Q?2CRvhejAHoOmdGHtqlgGOqyprDYx7JCCpvTRC/Ap69TvYjAXQaxDwx47Wpl5?=
 =?us-ascii?Q?5abvaFcgMNimEFW+Dwi50I/KD6TShpxF+yma83RvfWRYTkZygCO0knzt+k1c?=
 =?us-ascii?Q?dVNubQ/ltocjGiOaDpEuPOKtODVwGQU/9AW+wotfcDNuVmmmtYeJ6/1WU/Ib?=
 =?us-ascii?Q?Hb4+HrXdnG4HM91mHv2CjQTWis/GOgsQJ1dhLUrvX9sS44hgEtiUWhwYHnNw?=
 =?us-ascii?Q?XjPl1s9Rsu46JOXBx6BPW/w9vITmRiF/2+ZAyVGk3n7NHSdp3qDnmwamTKOj?=
 =?us-ascii?Q?o4E3uS10i8B55xwUafl2yMvXA5EKfwK07Zx/jdLXxUL8neQbGiebd75xhQCE?=
 =?us-ascii?Q?WOl6qRoM8kQ6ZDNI+8aemy7vTxhSIJAMw4fiutA4f87LDW4dgGyOPV5ZPiVu?=
 =?us-ascii?Q?m17fVdmb6OOBRqGYtK0q+WfuZBHEvhc2QgjfZPPZ34PE6niX9m+PwIaI5C1V?=
 =?us-ascii?Q?HWbLHamlvGEiDksQZ13XLeCBGNvDJRhHmDwJHNJiKRD0rdQce+xdPIFpcAfT?=
 =?us-ascii?Q?TEzIOKoRlPdg+zn8J9JLWMBIEPjabyhI2SJV+U6nAmorSPrJ4/g8+lEDlkbs?=
 =?us-ascii?Q?8HYr/cfjbyKmhsVmRTiia4hlFU/nZlaekcOdH0W2a//oSN/RYFjFB2HXXDcp?=
 =?us-ascii?Q?+sTGOyrvGa8Z9R/OzeOgND8o4J8QMRhnJlS7S9enpWQDvFRJDKvlCbevUSB/?=
 =?us-ascii?Q?bsS1UD0wd3opMqcSSAbtPHpxX352Yx/bxWjfahrYH86Nlx7cAlJ6MjWwexdz?=
 =?us-ascii?Q?3qfY9Gl70bNGDEYbsUp2e0WnIWBcg/296Dti6ZOdSomhRCD7aEspNGa7yvcy?=
 =?us-ascii?Q?BE7vj9jO+m7pxE/GZLFt3WLRcnpvsWH5k4PtC1U4H5W4f0Cc6OLJFgTsCyJ6?=
 =?us-ascii?Q?d6b+1ew+pMJIvOcD0IrxqxqEYHjgiUGhVz6xGKDHiNvhCoBxPJTOrBOdvgLJ?=
 =?us-ascii?Q?pTdhAHAJoLmFHlQ0B1bMx/m+ZB2y05UzoKr3c6HXagUyM0ibHEh32XVrusPp?=
 =?us-ascii?Q?43QVR4A95CD7oGijUY1Ge5dAxkC0QpbDwotw3l/WEd+cL1e3BMtryF9IMchZ?=
 =?us-ascii?Q?FZJHNr5EjnXPnBJlnZ0PJKH2an3rSKrraD6zu0eQLHp/T+q3hSce7OLvKhwb?=
 =?us-ascii?Q?lhqs6taKcQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a83e30-a664-4f80-3e4a-08dec32c42f8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:00:00.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hq8NqjseWPAPAeWVQj7rjCdwUTRODIYhnoFtwdfC0iIul4g1PyADtLJ4k0XbeM/0CRztHij/Q3f3VXHmsfLD/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699

On Fri, Jun 05, 2026 at 12:41:15PM +0800, Bowman, Terry wrote:
> On 6/5/2026 11:59 AM, Richard Cheng wrote:
> > On Fri, Jun 05, 2026 at 08:30:55AM +0800, Dave Jiang wrote:
> >>
> >>
> >> On 6/4/26 9:16 PM, Richard Cheng wrote:
> >>> The CXL RAS Header Log is 64 bytes, but CXL_HEADERLOG_SIZE is SZ_512,
> >>> which is 512 bytes, not 512 bits, so the kernel treats it as 8x times
> >>> bigger.
> >>>
> >>> header_log_copy() reads 448 bytes of MMIO past the register, and
> >>> cxl_*_aer_uncorrectable_error() tracepoints memcpy 512 bytes from the
> >>> 64-byte header log. On the CPER path the source is a heap object, so the
> >>> copy runs 448 bytes past it and leaks kernel memory into a trace record
> >>> that userspace can read:
> >>
> >> I think Terry raised the same issue and this [1] is what Dan suggested for the fix as there's rasdaemon (user) impact.
> >>
> >> [1]: https://lore.kernel.org/linux-cxl/6a0e33507e961_1717cc100f6@djbw-dev.notmuch/
> >>
> >> DJ
> > 
> > Hi Dave,
> > 
> > I see, so is he gonna do the fix or I can send a v2 with the suggested approach ?
> > 
> > Best regards,
> > Richard Cheng.
> > 
> 
> Hi Richard, 
> 
> I will send that fix today.
> 
> Regards,
> Terry
>

Hi Terry,

That would be awesome !
If you don't mind, can you add me in the cc list ?
I would love to learn from your approach.

Thanks,
Richard Cheng
 
> >>
> >>>
> >>> """
> >>> [  297.704020] BUG: KASAN: slab-out-of-bounds in trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
> >>> [  297.704032] Read of size 512 at addr ffff0000dd6ee118 by task bash/3078
> >>>
> >>> [  297.704038] CPU: 116 UID: 0 PID: 3078 Comm: bash Not tainted 7.1.0-rc6+ #1 PREEMPT(full)
> >>> [  297.704041] Hardware name:  , BIOS buildbrain-gcid-sbios-45660680 Wed May 27 08:27:58 AM UTC 2026
> >>> [  297.704042] Call trace:
> >>> [  297.704043]  show_stack+0x24/0x50 (C)
> >>> [  297.704049]  dump_stack_lvl+0x80/0x140
> >>> [  297.704053]  print_report+0x100/0x630
> >>> [  297.704057]  kasan_report+0xb8/0x130
> >>> [  297.704059]  kasan_check_range+0x15c/0x240
> >>> [  297.704061]  __asan_memcpy+0x40/0xc8
> >>> [  297.704064]  trace_event_raw_event_cxl_port_aer_uncorrectable_error+0x318/0x4b0
> >>> [  297.704066]  __traceiter_cxl_port_aer_uncorrectable_error+0x90/0x108
> >>> [  297.704068]  cxl_ras_inject_set+0x278/0x3d0
> >>> [  297.704070]  simple_attr_write_xsigned.isra.0+0x198/0x298
> >>> [  297.704074]  simple_attr_write+0x44/0x88
> >>> [  297.704076]  debugfs_attr_write+0x78/0xd0
> >>> [  297.704080]  vfs_write+0x1f4/0x960
> >>> [  297.704083]  ksys_write+0x100/0x220
> >>> [  297.704085]  __arm64_sys_write+0x78/0xc8
> >>> [  297.704087]  invoke_syscall.constprop.0+0x150/0x200
> >>> [  297.704090]  do_el0_svc+0xd0/0x210
> >>> [  297.704091]  el0_svc+0x44/0x138
> >>> [  297.704095]  el0t_64_sync_handler+0xc0/0x108
> >>> [  297.704097]  el0t_64_sync+0x1b8/0x1c0
> >>>
> >>> [  297.704100] Allocated by task 3078:
> >>> [  297.704102]  kasan_save_stack+0x40/0x80
> >>> [  297.704104]  kasan_save_track+0x24/0x58
> >>> [  297.704105]  kasan_save_alloc_info+0x44/0x88
> >>> [  297.704107]  __kasan_kmalloc+0x108/0x110
> >>> [  297.704108]  __kmalloc_cache_noprof+0x1bc/0x588
> >>> [  297.704111]  cxl_ras_inject_set+0xcc/0x3d0
> >>> [  297.704112]  simple_attr_write_xsigned.isra.0+0x198/0x298
> >>> [  297.704114]  simple_attr_write+0x44/0x88
> >>> [  297.704116]  debugfs_attr_write+0x78/0xd0
> >>> [  297.704117]  vfs_write+0x1f4/0x960
> >>> [  297.704119]  ksys_write+0x100/0x220
> >>> [  297.704120]  __arm64_sys_write+0x78/0xc8
> >>> [  297.704122]  invoke_syscall.constprop.0+0x150/0x200
> >>> [  297.704123]  do_el0_svc+0xd0/0x210
> >>> [  297.704124]  el0_svc+0x44/0x138
> >>> [  297.704125]  el0t_64_sync_handler+0xc0/0x108
> >>> [  297.704127]  el0t_64_sync+0x1b8/0x1c0
> >>>
> >>> [  297.704129] The buggy address belongs to the object at ffff0000dd6ee100
> >>>                 which belongs to the cache kmalloc-rnd-09-96 of size 96
> >>> [  297.704132] The buggy address is located 24 bytes inside of
> >>>                 allocated 88-byte region [ffff0000dd6ee100, ffff0000dd6ee158)
> >>>
> >>> [  297.704135] The buggy address belongs to the physical page:
> >>> [  297.704138] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15d6e
> >>> [  297.704140] flags: 0x17fffc000000000(node=0|zone=2|lastcpupid=0x1ffff)
> >>> [  297.704143] page_type: f5(slab)
> >>> [  297.704147] raw: 017fffc000000000 ffff00008001c1c0 dead000000000100 dead000000000122
> >>> [  297.704148] raw: 0000000000000000 0000000802000200 00000000f5000000 0000000000000000
> >>> [  297.704149] page dumped because: kasan: bad access detected
> >>>
> >>> [  297.704150] Memory state around the buggy address:
> >>> [  297.704151]  ffff0000dd6ee000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >>> [  297.704152]  ffff0000dd6ee080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >>> [  297.704153] >ffff0000dd6ee100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> >>> [  297.704154]                                                     ^
> >>> [  297.704155]  ffff0000dd6ee180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >>> [  297.704155]  ffff0000dd6ee200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >>> [  297.704156] =================================================================
> >>> """
> >>>
> >>> Define CXL_HEADERLOG_SIZE as SZ_64. The trace record's header_log field
> >>> shrinks from 128 to 16 dwords, but only those 16 were ever real data,
> >>> the rest was always junk.
> >>>
> >>> Fixes: 2f6e9c305127 ("cxl/pci: add tracepoint events for CXL RAS")
> >>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> >>> ---
> >>>  drivers/cxl/cxl.h | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> >>> index 1297594beaec..f322d7c79ed2 100644
> >>> --- a/drivers/cxl/cxl.h
> >>> +++ b/drivers/cxl/cxl.h
> >>> @@ -158,8 +158,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> >>>  #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
> >>>  #define CXL_RAS_HEADER_LOG_OFFSET 0x18
> >>>  #define CXL_RAS_CAPABILITY_LENGTH 0x58
> >>> -#define CXL_HEADERLOG_SIZE SZ_512
> >>> -#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
> >>> +#define CXL_HEADERLOG_SIZE SZ_64
> >>> +#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))
> >>>  
> >>>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
> >>>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
> >>>
> >>> base-commit: 6f3ed7fec72fc8979b2a8c7219c0a9fcfc8d07b5
> >>
> 
