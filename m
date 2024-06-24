Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19E1BC2A;
	Mon, 24 Jun 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262269; cv=fail; b=OQUrWsrtlkXlu2ICASHg/U1kw/kuRORaRvp07ulivFTIThfTRpAHDJ62zXu1IgqD4Q6Nypt69ftRMiz4EHOSf0jyZFC8WcQtmsdlAr16Kdmi8GDrHl/ZgE3z6jpgXLteix0nd0IwXjwKj9fZJi4pJlixXAEGlSZ4Et02ROrRZ/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262269; c=relaxed/simple;
	bh=1RVy7WC4aVUEY8OVlLuFDASOX9C3Q1o2TrzOKkZsejE=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o/Y5nFwiMF91bp6t+2egIrd+5Ob3P8CIcix3HmO4+0PxLSA1QEHp1z1tBig1AZXnF3XUEN3nx4YKDWMbXtZkftOZotqLDjHKvdy39Y+iwOff1aim8K5kXQ9spu15Ar53Msx+QSQB3oslQCExZ+nA+Ad0aSJ1qhojkXwVdNJoPfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aoh/Lf14; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aoh/Lf14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719262267; x=1750798267;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=1RVy7WC4aVUEY8OVlLuFDASOX9C3Q1o2TrzOKkZsejE=;
  b=Aoh/Lf143oG4fsEpJqgAoXmlelMcOgyW5OAMV8HvjZ0ACD9wOIrzxk3K
   4tFOx1bf2Rfl0p7trTFqFq3sGLkcH/7ob66F7uiSDPXFVrVXRC/Jqv+yw
   SoBW7aZe6qBwhfcgNxyZ9/KR/q17lsYZX6j/cC+Y6chrCNJIBjIqFl1W4
   QVg0SisaZMDG012hx+x7hxBbHRT+AVR80lNyCCUMExj4wH8rAjKCKLT/u
   Z6Qw9YfxFS0k4j53w6GwfE5JG+17d/6A+4qf84kkBvIf+nzuUkMkzuf1U
   wRkJB3F5Tw7jgSSfhmC7dGhUGWTxxxwxl/NV0aa1RT6cxp4UTWzvxr7SD
   A==;
X-CSE-ConnectionGUID: JT4Jin0dSimu0WDEioQWng==
X-CSE-MsgGUID: wB/qZ1tXQACRHGQl+vgd3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="27664881"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="27664881"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:51:06 -0700
X-CSE-ConnectionGUID: uyVbtAhPRL+nweXrjfh5DQ==
X-CSE-MsgGUID: gM3SohPRSrO1EZphsfbAkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43228178"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 13:51:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 13:51:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 13:51:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 13:51:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVgoAZTYqm0CJSSgaF4zQzRBUG4D3ne0t2uk50P7kQu+jpDFjwqb7dup2KztEZz1B5iBavSHo217WUU66RtpR+aQyFZb/83W/dCszvBxhnYqg+6OSITQuAmUACvIwZit9oS7IPjFp/b+nX7ytYnQJiZ/siXWHET2ZWF9HolkXZIpBnN3p+4Bc1xmkE6qlIYhWa4pDfVKrtqODw/cSUa+7z2npSu2wLQz+eTBOHz6WHbKWPm2ult4OUOrLakfi9yQniwQT04qcn/PXrzoQAuAa9huyIr5/i7+cKP3EIrc0QMJTPC1exJCwqKCUXMxVFeKjG48cR5YVpWAvR35JMtXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpB7dXwnz6lP5jVol28R/FNIrgseMQ3LZkVFhJY1Qp0=;
 b=f/F2rSP87cKgSRs2LD1PdupgTkOE8bZvsp5jhBZvf5BdaAe88GD93UVDsy19X0LVqKeOxmnZTVKSfMt4Iy35v8FHsy3NoK80HK7pV5UbMYc2LVQEJ8WMc3UoqhCROVJw6OgnDEHCYYWNKQwzLKAJThuPX02Zn+i6oYeoxF4gkW6sFvaDXR/mSmdIyBCk3LHg0McCI0/vOPSP67L94jWXieowH9v0VrWvSR9Xmr0N+z8OCzN2/FUpdtQcqqKjyhl+h/e3HByX9T+boc0ZumTO0fzRXxJUAJRtg+/HrP4PkmS57fxJdl+VQwZhMFgTW+7k7UMOUpA/2zQ3mHy9AdP4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 20:51:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 20:51:03 +0000
Date: Mon, 24 Jun 2024 13:51:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <Terry.Bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 0/9] Add RAS support for CXL root ports, CXL
 downstream switch ports, and CXL upstream switch ports
Message-ID: <6679dc345fd4c_5639294a5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <6675cece52eaf_57ac294ea@dwillia2-xfh.jf.intel.com.notmuch>
 <f4dffe22-b383-4118-bd3b-a3afb2df835e@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f4dffe22-b383-4118-bd3b-a3afb2df835e@amd.com>
X-ClientProxiedBy: MW4PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:303:8f::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4796:EE_
X-MS-Office365-Filtering-Correlation-Id: 891cd948-99ba-4870-2b53-08dc948f5c95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011|7416011|921017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8Lnu66Lb5NEEkaFi6CTzcFcmwaF19nrQZJLFcK7a8XvxsNW3HYscYVuxNDtz?=
 =?us-ascii?Q?7b/5tOjPNxNZ+WbtivftGQUh9XS6lTjLWa5kcx38+efMDpKTLAM7Oh7L3ZtE?=
 =?us-ascii?Q?bG+BrXMqGWQsIz6z6U77TX+cXQvhJMZE729gPyV+jHAr+EKstoY0vtpScxpj?=
 =?us-ascii?Q?Vhe2dbvYTJ8LF8UgrDlf+4rjHKe0+ztR8nVepuCEGgmlNo3Z9ihnhikxPBzX?=
 =?us-ascii?Q?C3Lhg2m20FU8jXF59bzOoeOtMN6N6x/BHUymYlHrolqPuFt5Qautz1rQBjHz?=
 =?us-ascii?Q?gG0U7BAi5/I1afL0qzXLUAMk8Zt9HKGWM8RAUgX7UhY5ELlegtw6DY3gNAFB?=
 =?us-ascii?Q?bQvwPiIvcqDzu7ENwConXQFd8aFrzdev4NNtVRvdQAFkBo9ojnm3iUeHEwaV?=
 =?us-ascii?Q?iSBX8OMY7VUr3VNIH8AkNB82INwZ5otvsHBFlzR2t69iUkdO5aL0JaPFQKk/?=
 =?us-ascii?Q?SUPYroPs0V9HfrlkgBCn/RSHQfG9QxLLNCXjZjlQizsFvuGhrQYLGrAF6+7w?=
 =?us-ascii?Q?vujJdsnaO+sUxdWcYsPmA2v5tO10FIAfTxncI5IPSfm6YePnBL7cH/bGFO0E?=
 =?us-ascii?Q?mb6gPdXL0i+vWZNO5Tu59JUWZlk71UPK8g+N7lfRR1maX81FxlCtKnQ4iwKY?=
 =?us-ascii?Q?QbmJnAGGTYw0d9b7gxDKF65Wwl/GqjokHnRn6OzvC4mnHRSID6f8WCZVjULv?=
 =?us-ascii?Q?KjWmJdg27WLmh5CTjvXISFHTu0f4YScP87Xx/cnO3Zd1Cy9DhVIzm9ZTbZ0H?=
 =?us-ascii?Q?h5QyX3MXYGbEZEyyG7khCVIYI06XITD4OUPL14KCrnnbInrWwrwavoqlzSYu?=
 =?us-ascii?Q?ciJ4CvizvUL6qAbSI89qrWE/RbAoF+H0j4ODEvdcf56vcaoHPBlrTw0Z9D/8?=
 =?us-ascii?Q?8klyBKVt5AVTaxfD1fBXmtxPxiemSOIZiS9HgaP27WBfoInZnICgDFzfcBuD?=
 =?us-ascii?Q?dQjUKN2HKe1ktWkKktkqbtr8alxGwxZ9BYLB98NUuRBZVyMHB01PU53hYts3?=
 =?us-ascii?Q?VkaKrUXs8wwiI6uPtTiC/OtlT1OyZyOsFETwlLHFh1AHTo7VSMKUzZ2fjai6?=
 =?us-ascii?Q?ahK0Ez0s1g7eNV7f0RELAQRHojgmIHkJHe/k3xP2UPy8KiCCxMtYsjUnry0X?=
 =?us-ascii?Q?ftu8W9mYEj9bOpKP5/NzIztGmIvN411E2IAXIiZWqdb2yzpmoTvfqfZW69TH?=
 =?us-ascii?Q?0Hqi9E4AlSfgx8acmKs0pw2ywZFY1aXzygqF5jxaPI0jG8edIdO4PuOUN1d9?=
 =?us-ascii?Q?5NSZKEGw5Bn/eExqAmPuW0bDHxcg27wCpCQVPP8kdfo3qgtRq/UXt2EoDPXa?=
 =?us-ascii?Q?xLS7Pnhu1ytjrJw4wMkFpFMYa2763PaKU5W+gEhoFMDISJ5lPBBa1zpyQdGr?=
 =?us-ascii?Q?wmhDqIs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(7416011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cAiy0696ynQIg+s9Hdbjn5Jzq2raJipz9as/c52EX6Slc6G3toWwGwVB+w9X?=
 =?us-ascii?Q?VSNV2TwsnO97SmsYwptc2tDiv8wuWNHjhXLIGWZkqFCQRfQlmACS7JCYIUCe?=
 =?us-ascii?Q?GRcHzu4dh7Y3U1rz1N7J9xJOUW5mDJQ7SpTjTMwon9X4JoRaiklgM6cy0gmT?=
 =?us-ascii?Q?c6oR6RCWL3SzFw/RSApDR+jLW7Do4WD1jB7/L4g+U3KqilsCH1lo48c/kJ61?=
 =?us-ascii?Q?JHp9zVsVmr9/2r23tmQX5CXpcCi3TOGOosP5EZQeXlsuZiGtHR66VjqCSW+U?=
 =?us-ascii?Q?YcNW5qfZb672CAsTw/Lfd29OtGmUgAc4thUfLXaRSphD8Yyi5zqX/ECZY0xN?=
 =?us-ascii?Q?zkCLhGKT2tW7ILGeyPVTaJxem6BPlfGEKrU/DNbTbHJ9DWQeK1qBM1+OFp3z?=
 =?us-ascii?Q?K7696GWM4GBZV6JW+ilh+1eLhboHYJLtklfJajWn+9lFSRaWJpAw0jnq9INF?=
 =?us-ascii?Q?Y3hIu+7zIKd2EsZqboEThsdIZyPcyaIgp3yrSZl8gEd7GW3AmK0gnqtfPfna?=
 =?us-ascii?Q?43nv3wnS//ljEc4Q8ZMKEqIi0KIOK4MJKzVukSBiRQOvyDPmwtKFi35QfsMw?=
 =?us-ascii?Q?dkPgtETBQNY9yMluuI0C5hhWlQ1gBZZHa6SzBU/XOHOGjNvaMUoRJlhsuaET?=
 =?us-ascii?Q?9UFS7ND2xeGjh+3hrdHxsu4UHo1tBSTwhbz3km661iSUHiHAitnTjm/Wchxm?=
 =?us-ascii?Q?fPHScxtEjNrki63wxCbdcxx5Gy85B3Qw1zj0idX/fXQO/3JmCydRGUs4rMeG?=
 =?us-ascii?Q?IkhIlaNMs/ABQxB6oy1WhhueYop/6h9IDApz9uZdI92Em6E30zOkObXaME3u?=
 =?us-ascii?Q?k8EQFpPklgRJqKXHznZu6R3ZKJhosDTvK6oezV8YMkNJYX6RHVFZHZfCEEqS?=
 =?us-ascii?Q?tB9yIJf+ScOZ8BZWZMQdgfHJyiRc91NvsBl2CEfihfiUOG8wm70VwemShvD6?=
 =?us-ascii?Q?QY0EJh8Pxr1x1Cit6otiGoxui8VlmTctYu+GEOrNQQbpBbF5t+hRoLqLUmfv?=
 =?us-ascii?Q?yBluVk+7VFWsswRhihvdEv+CulBfYXnl1l7fXrGxkSu1bEwXlN+ydnctRIYp?=
 =?us-ascii?Q?zKhxhfC66ZYeYpuTgj8DiEqtw6vTXsocI2ERxWvH8IwC09txN+3lLI4zaOgp?=
 =?us-ascii?Q?bLCPaxeLX33LIccUFWZpXACqNpu9akef/Vdby4ALVAlkckJQxgaF4g5jne7l?=
 =?us-ascii?Q?+8V/L3a7Rj5hy9UAWdPk4CzLrWDHnV3LsryHEO48mxuq9X9htnOpt0iJkysK?=
 =?us-ascii?Q?S0lTMSdN4X6rASWfqBUYbNN5RuA4XObr7iCZSvPVTLe+SNgmUho66RKRqVKi?=
 =?us-ascii?Q?AtQTKoz8MNmHUzG8CNsdXoB1frSqYRmNn3KFCbhTNsu1SsrT3TSBwoZ4wX1g?=
 =?us-ascii?Q?sme5f4y+q63dWzblgACUVExoV9ktx47wiqDpS2Ll5sWEZpuouwqo0CdfnlXS?=
 =?us-ascii?Q?pXfAZGDP7AqFYUJoCEeThRRhS4X88a7GEMc9YlHLP8zZb8d939+Z0glLCo7l?=
 =?us-ascii?Q?W6Qf6amyjQKx8jQdB2RQmvklFUIVkC7h7uatTYXIe5rgehw5lMCrt3hXmlTP?=
 =?us-ascii?Q?ocGffJ0NkZpkXcyJMHW63wrU+FWoU5BnBhIQIbxfH4qiCOOQ3vzYfSj6KdvX?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 891cd948-99ba-4870-2b53-08dc948f5c95
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 20:51:03.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOsupbD3DUdIiHx56LNtjbSNMzVbK0HsB+6+Ma+4hYb6pDiKH1KYnP4e1Ykl7iFBLITYxsYEtWud9rn/gSGvP42/M+MevTdp0NCYoDFZbPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Hi Dan,
> 
> I added responses below.
> 
> On 6/21/24 14:04, Dan Williams wrote:
> > Terry Bowman wrote:
> >> This patchset provides RAS logging for CXL root ports, CXL downstream
> >> switch ports, and CXL upstream switch ports. This includes changes to
> >> use a portdrv notifier chain to communicate CXL AER/RAS errors to a
> >> cxl_pci callback.
> >>
> >> The first 3 patches prepare for and add an atomic notifier chain to the
> >> portdrv driver. The portdrv's notifier chain reports the port device's
> >> AER internal errors to the registered callback(s). The preparation changes
> >> include a portdrv update to call the uncorrectable handler for PCIe root
> >> ports and PCIe downstream switch ports. Also, the AER correctable error
> >> (CE) status is made available to the AER CE handler.
> >>
> >> The next 4 patches are in preparation for adding an atomic notification
> >> callback in the cxl_pci driver. This is for receiving AER internal error
> >> events from the portdrv notifier chain. Preparation includes adding RAS
> >> register block mapping, adding trace functions for logging, and
> >> refactoring cxl_pci RAS functions for reuse.
> >>
> >> The final 2 patches enable the AER internal error interrupts.
> > [..] 
> >>
> >> Solutions Considered (1-4):
> >>   Below are solutions that were considered. Solution #4 is
> >>   implemented in this patchset. 
> > [..]
> >>  2.) Update the AER driver to call cxl_pci driver's error handler before
> >>  calling pci_aer_handle_error()
> >>
> >>  This is similar to the existing RCH port error approach in aer.c.
> >>  In this solution the AER driver searches for a downstream CXL endpoint
> >>  to 'handle' detected CXL port protocol errors.
> >>
> >>  This is a good solution to consider if the one presented in this patchset
> >>  is not acceptable. I was initially reluctant to this approach because it
> >>  adds more CXL coupling to the AER driver. But, I think this solution
> >>  would technically work. I believe Ming was working towards this
> >>  solution.
> > 
> > I feel like the coupling is warranted because these things *are* PCIe
> > and CXL ports, but it means solving the interrupt distribution problem.
> > 
> 
> I understand the service driver interrupt issue but it is not clear how it 
> applies to the CXL port error handling. Can you help me understand how the 
> interrupt issue affects CXL port AER UIE/CIE handling in the AER driver.

Just the case of the AER MSI/-X vector being multiplexed with other CXL
functionality on the same device. If the CXL interrupt vector is to be
enabled later then it means MSI/-X vector enabling needs to be dynamic.

...but yeah, not a problem now as we are only talking about PCIe AER
events and not multiplexing yet. I.e. that problem can be solved later.

> 
> 
> >>   3.) Refactor portdrv
> >>   The portdrv refactoring solution is to change the portdrv service drivers
> >>   into PCIe auxiliary drivers. With this change the facility drivers can be
> >>   associated with a PCIe driver instead fixed bound to the portdrv driver.
> >>
> >>   In this case the CXL port functionality would be added either as a CXL
> >>   auxiliary driver or as a CXL specific port driver
> >>   (PCI_CLASS_BRIDGE_PCI_NORMAL).
> >>
> >>   This solution has challenges in the interrupt allocation by separate
> >>   auxiliary drivers and in binding of a specific driver. Binding is
> >>   currently based on PCIe class and would require extending the binding
> >>   logic to support multiple drivers for the same class.
> >>
> >>   Jonathan Cameron is working towards this solution by initially solving
> >>   for the PMU service driver.[1] It is using the auxiliary bus to associate
> >>   what were service drivers with the portdrv driver. Using a CXL auxiliary
> >>   for handling CXL port RAS errors would result in RAS logic called from
> >>   the cxl_pci and CXL auxiliary drivers. This may need a library driver.
> > 
> > I don't think auxiliary bus is a fundamental step forward from pcie
> > portdrv, it's just a s/pcie_port_bus_type/auxiliary_bus_type/ rename,
> > but with all the same problems around how to distribute interrupt
> > services to different interested parties.
> > 
> > So I think notifiers are interesting from the perspective of a software
> > hack to enable interrupt distribution. However, given that dynamic MSI-X
> > support is within reach I am interested in exploring that path and
> > mandating that archs that want to handle CXL protocol errors natively
> > need to enable dynamic MSI-X. Otherwise, those platforms should disclaim
> > native protocol error handling support via CXL _OSC.
> > 
> > In other words, I expect native dynamic MSI-X support is more
> > maintainable in the sense of keeping all the code in one notification
> > domain.
> > 
> >>   4.) Using a portdrv notifier chain/callback for CIE/UIE
> >>   (Implemented in this patchset)
> >>
> >>   This solution uses a portdrv atomic chain notifier and a cxl_pci
> >>   callback to handle and log CXL port RAS errors.
> > 
> > Oh, I will need to look that the cxl_pci tie in for this, I was
> > expecting cxl_pci only gets involved in the RCH case because the port
> > and the endpoint are one in the same object. in the VH case I would only
> > expect cxl_pci to get involved for its own observed protocol errors, not
> > those reported upstream from that endpoint.
> > 
> 
> The CXL port error handling needs a place to live with few options at the moment.
> Where do you want the CXL port error handlers to reside? 

I need to go understand exactly why cxl_pci is involved in this current
proposal, but I was thinking it is probably more natural for cxl_port to
have error handlers.
