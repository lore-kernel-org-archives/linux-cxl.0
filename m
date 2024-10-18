Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816B20E31E;
	Fri, 18 Oct 2024 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214409; cv=fail; b=WE4ItO+J64rvE7oIoI2H92gcUP9rVGhkpXBMEuRQ58ESrIIOHJAWk/bBOxkV4BFdLVO2c72sQXmguWzdG/bhUan2EI+AG/iTfwfXr1wv+2gd665KrErl/eLEjd4WWa4Wg1fxoikcDfjn2s6Z7bCDLcHL4cpfMQ5+3UMi0/zuHyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214409; c=relaxed/simple;
	bh=JjxeKBHzDLttvCKVELBpx6c97ePmV7FPBqIhX4rPLH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GogtrvwQZUgxMhwuz7en0blxH218NBIOz2QGVsZjeH93ttI6zRhsO6t4w3oZA95KOvfQIZeANrlWNYCB3NpzF0zi6t50OSSsLLik4G+n7WgGLiA/0eSaCpmwcQQP6My/SQz0ZVTkkdk+XwuqChYb8+7hCzxrce35jjXzV2WZw8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2FgNcwS; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2FgNcwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729214407; x=1760750407;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JjxeKBHzDLttvCKVELBpx6c97ePmV7FPBqIhX4rPLH4=;
  b=L2FgNcwSi56spcfHNHA45MqKEMeatu+2eOAmp3e13vrf1F8KuRUNZRzC
   dQNnQ7fSzs4PRBIlEMY2vZzQ0m+Cwh/PZUc6vOYJhRPIl+RuXDi4LrILb
   N6YRfGYZW37B+bOQ6Laa1J/kO+/HMTZx2TwzsD6ZfXW6RhW6QKHOU61Yo
   IsOaW1WhaEWb2cg18LsplrDVncuCADWtL+seGStlD/lHroc9YEVo16hI3
   +JP15VvzBWIhJrdELHkmbZ5jMgBWaxFp8V2pQQXKQHYUSH8ojfX7F1zgq
   Ki+cYWCdeAauX2+4WZbPp1cB0JMRM2AHiG2dAA2TzH6bAkJEze659Lhb8
   w==;
X-CSE-ConnectionGUID: 0sDYgNcESh6CN1ocoXqGQA==
X-CSE-MsgGUID: GLXqNqMDSUy1N/8a7o2GOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32416424"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32416424"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:20:07 -0700
X-CSE-ConnectionGUID: y9DiDb1/R0K6F6b8edhvqQ==
X-CSE-MsgGUID: 28vRlS/eSzWChwq0dMtrAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78387051"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 18:20:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 18:20:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 18:20:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 18:20:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 18:20:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZZx1vSHBl44fPgLVItCHQl0oGrJ2F70YagNDdFMJQxiidyAiRaQVETnlNfXuTXqjmhNPfpAaJcQOv1tD8Rznn0DHM4Vy8m/Z1NsQTxmTMnP2f0BxHOZIhnTgK150/NL11GMBvlpAsaAGQV6qLLfDEO5GhpPpTIkFhUawED1AZUxIIqaM0wAuDSIVY/83aHq0roa/tw0m7304am6Q3/O2Z33J0fRhd8HaBL4RnG1y5DQyBcpYZZoENqe60llnumJMwnDFehgQ2K5nestcuoiHjrxjfSMrEqx356SWLvrHEEjcJ8noAJ2+ECdJzup5AMQjohhsRsVt/jRfDmXYHSZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lqxtmc78MldX1HsEjD8eg+MXyboLdPa1LA1VayK5Bhs=;
 b=e9q5yC86hgCT+aioZRqW/MDLf0tTa14pA2RcwIn4AwaaPLIZfPkiaM6Zl+Y2ZBus0Y7eTHsa6saBHKAPeSV18u8DDnmG4p3Nr9dapZoV27Tar/+EHNdmvk5f2Gjxww6FI4I8PX62pR/lTdawJvDRkD5zShbkHCpgAgw40TRn/wrKYsO8o8dgE9wKnLtH8JwHqeS/jrZLR7CzzUloG04KA4y+dazgd50ovoW9EShqoMJTeX3JlUMTEIY0hfN88E3yBY2cl8+/4E4iFOJ2NsOanf5VlgoYrkPAkocGEGzdMXZMSz0/nWltjC02davZGJiUPZ1ULawboiRqgWNjATx/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 01:20:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 01:20:03 +0000
Date: Thu, 17 Oct 2024 18:20:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Li Zhijian
	<lizhijian@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, "Huang,
 Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] testing/cxl: Fix abused pci_bus_read_config_word() on
 platform device
Message-ID: <6711b7c0c0b53_3ee2294a6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241016015213.900985-1-lizhijian@fujitsu.com>
 <ZxGqYPGNaVWoLuP6@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZxGqYPGNaVWoLuP6@aschofie-mobl2.lan>
X-ClientProxiedBy: MW4PR04CA0349.namprd04.prod.outlook.com
 (2603:10b6:303:8a::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 1681a6db-f6be-46c4-7741-08dcef12fe1e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XfKYt5fYSNMM2jZfrT+M8Q3BmsU4d2gRnAGsTwVY/uDLuE84Bky1uJKwuGLb?=
 =?us-ascii?Q?FAOcGPIPjY7uFnx4bJyvPFYKhfQhZC9OLY+IH5yhEf1lEATa0x7Ksx3V3fXE?=
 =?us-ascii?Q?c3RYrbijlLLCLNGwadmpuAio9VX0ydzmJ7gDvySdNi8o3G3g2ooh4oFC0xmf?=
 =?us-ascii?Q?/aHh7oSjVotFQWyyFFKRAcqxOhBBt/lLhuw6wormWTqkzDkWn0U7r1WpBFWL?=
 =?us-ascii?Q?BRg75UKMGDOTu38+HBUNAeCLKMkKQdG5BW5edHQWJQFbdsUQ3MCc6GBfyn8k?=
 =?us-ascii?Q?gYT9+W8V3SGnRJWlmU/f5WptWMhK6YXjVzMoqXYOoQdH6zm77WJd3yAvNX3R?=
 =?us-ascii?Q?nvcOot3w18LuvopkXPNxyqGO0b9caWdTK62bzigDuCx0nF9CN3POa+03RusY?=
 =?us-ascii?Q?WnZI6i8YpLjq0n6mNsyCGm8DnXpg56jQ3gMF9+1LIjTOzZSoD5a+znHUG5cC?=
 =?us-ascii?Q?0b8ErOqotgo46MKuvtk3wsYs9SNsouIrDq4X3WJqD3lFZ3SounAoIsxWWei/?=
 =?us-ascii?Q?BKpcYnOjKmDvwAyNpQQPPfvrfDEXnFy74rQFCzdVDjMbjR5b4UoJoUafwgLH?=
 =?us-ascii?Q?hznaBiIaCZmB04ehvxqX/5WNSNGuLbnIPPhkFPpUV6/sr4K3Hz3F/KS6JdVz?=
 =?us-ascii?Q?9qLfW4b+VXHawKyYIAGJKdnbpPSt5ioAojP+4VF74R7VYKfuZClnWHrupJ2L?=
 =?us-ascii?Q?YhB1c1VCVdM4OH/xnkIRmrVQfVgeurlJY2jX5/zvD0yUWlO6JvUjmLZDcrSz?=
 =?us-ascii?Q?Nz/zujtdQqJVHQ+Uov7HzWDS9nmFy6xKu9dA3VwSe1FoOnfTpVJKDRDTJ9c4?=
 =?us-ascii?Q?uk43ct4P1jPtCirrxOsUp282DL9sVOlFV2dNuMoTPktXOApnogaV5JQKDS55?=
 =?us-ascii?Q?aBOsgWBPwZCikQX3yHGxx0bWIzaOp8A7X4rINbsaOPMkN6gtcxOGGJ5NYUK8?=
 =?us-ascii?Q?fKeIQXJocnZPNGJQWA1czrQPbZOghVUNfIDtRkO1Llw+T04BPMj6NeVuGCHD?=
 =?us-ascii?Q?M7hT4vk/LujYy7L6c5tKL1853NqZb43stmHVBOf5oJPdG5Kz2N/Xdu8bzCnz?=
 =?us-ascii?Q?YbElqjK7wLjYQ06YjnNmlO0kbL+/O9n3sBfUtBQvCa0BRTi1QKBaVZ2L/3T9?=
 =?us-ascii?Q?wr3sgU2fwL3Do7fWhesEUx3dU5ga+RwVRQsd+qr9b54PkRpD/+BFfCokfXIT?=
 =?us-ascii?Q?xPakUxBy3Pq1HiPm7LtC1MVvwkYwlG7lsiUpTv6m4+FYcY9H6QNX+p8nIfEA?=
 =?us-ascii?Q?Q6ZvdR/g4BYjylTzsmqA7KDRNsbN3XlGe/zqXGzSv6lDP5vSamY56sYh0dKF?=
 =?us-ascii?Q?WvZi3PYEvUPQ+wZjkXZoMDW5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5NgfZbJC217oqIKsuo7WwaECx0Je1286MWGCf50UMU+fAcPDKEIuPWonuI1f?=
 =?us-ascii?Q?wm6fDDKYT7/I/AZl+t+KX2jb/QjTzLq/ZG1Jd+KrUR8ITafXNODMOIEqzHdR?=
 =?us-ascii?Q?DBlXTC1VWqPWdAypv17hz3nLEaMvrthuxH0LWefNzhNrDwQAP8SCafy0Kc/Q?=
 =?us-ascii?Q?apvXdtUxyh/UdkpuAzxwctwcDHxaEsM7bPTas5rREMNalObO5/I4/MsVpa8j?=
 =?us-ascii?Q?NF4sYy2rXIuWYUEUNNTYnRrugAEQhDI3+864/78Hk02n9hmEFuU7Rh5UTGpY?=
 =?us-ascii?Q?slO8AwP3pgZFDO+xIbpXZLjx66J1u9GuxkbeTvmL2GN4PVHhhcMNeeWSCL7a?=
 =?us-ascii?Q?uWzD+AG4a1IQBsMaoApwLRbq6kQIW3v//zbcpfdfpMR81ueLm97W/+rRnfsD?=
 =?us-ascii?Q?+/Uyyb4BR9Tt4piZIhP+cE3I3vDXwTGRBScZ5SJEEOjAZdNzMihoalIvz7M5?=
 =?us-ascii?Q?cy6VmbamjaEJI9TGAZ+lsKH93h8BsZpYHL3QwcBkDOpYwQEYI6J/SWocr7Hs?=
 =?us-ascii?Q?1RIOOZGzwtAWeuIA1e7hp/NS3oY5fKElLYnpcdaRYomsOEYiqlz+M7G/7BZD?=
 =?us-ascii?Q?+w8tKec87aFaNMA8aepOidBQmT+JX74oephnLwtS3N5mUtboD43pYjEiXQ0w?=
 =?us-ascii?Q?qVJzyRZNeCtmPU1LBRr2nfMXnwDSYFIMYCTI/4HnIzBpH1HChmrdZv0be4Aa?=
 =?us-ascii?Q?yvHFT5sI63ycd7cwBUu037rGLOZAK/r9xBeKol7HH0MfBupu/y+R2WGdttfg?=
 =?us-ascii?Q?y9LTVyY9B2AozHPKa3ArVIvg5dTvSy52QuEdmZuxDjA++MJlSfgNkNV1T336?=
 =?us-ascii?Q?IW/8VUDxA940eykoJjbW8LvYIclzsWnfPs5IQ92cmlzfYUKthM2wlXJwBJk7?=
 =?us-ascii?Q?ziBocDVy7URpw6dp0UnI2Y4w+vK1z8+o9UupRhN2YkZmJIaDtRJUm3OuGc02?=
 =?us-ascii?Q?tzVaiHlJf/qoOGZt00Px8pSIXAZqHYaI6wt9jx6crHWR+KAH0x99hUAjTBdg?=
 =?us-ascii?Q?vvKLJfJulfPhj2WNtjrF0b/yErwlQhbQpZqQwwu+5fosngUF0Bd/H1+26MiY?=
 =?us-ascii?Q?86f4iJlGpI20OiOMGRzbw35eg2r7y11rtydV3h5oV6kZ/gmFreJN6DP7oy+H?=
 =?us-ascii?Q?1PhvEEJInWIRdkI1hEnwQSwwSqz8COhtbve20Q0XawjXm4E8nPd8ZbEFRDXh?=
 =?us-ascii?Q?MN+dHIYyVm9OT8FukOdayjq8sDZ/RjvkpSyL9jKc2/bqi9xH+OYb+TfikGwc?=
 =?us-ascii?Q?/OhG7h4OECv3j3c4rWHJyYSj6Pti1B4BFakeTLNXFW/JXjnPxJRz1MUCGBwK?=
 =?us-ascii?Q?vbB+u1fFReUNTSdzM98peBcNYSEhVGlJfgAJ4NOUuUDc2NXOIObwgerE/hFw?=
 =?us-ascii?Q?0t48V2ln+leYW+b/LyH3z7jnxOQyi9OdT/7GSNghs5hIEKZUOH5UeT9m/tSA?=
 =?us-ascii?Q?Gm54/3Q3SW7fN6fC8badhadx/CFjFBT+naoR3IdfnMW+pmAa6nF4ulhJw/fp?=
 =?us-ascii?Q?ezVn4Vz7qN1jCJtww/ELG3HFo5IgRBFhMmsJAnZKw+iLH8jbT4ngj44yS3Y7?=
 =?us-ascii?Q?XR9q2vMkil28rNlXJ8QBb4L6gKAdj0zbp6UlNu//byA3HPw0x0Z6PIcwDBVD?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1681a6db-f6be-46c4-7741-08dcef12fe1e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 01:20:03.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUP1gM0v07SZS426gzZCpLRLi1l7E2dSBlIFC06S6YG5ZighiTcOtEP4sAmhdoScx2e3441PIcLDDIjK+lUdMRkcm9H2nWs4fTnpAjvyWa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Wed, Oct 16, 2024 at 09:52:13AM +0800, Li Zhijian wrote:
> > The cxl_region_shared_upstream_bandwidth_update() in clx_core works on
> > PCI/PCIe CXL device only while cxl_test was implemeneted by platform
> > device.
> > 
> > Mock a cxl_region_shared_upstream_bandwidth_update() which does nothing
> > for cxl_core so that the cxl_test goes well.
> > 
> > Abuse cxl_region_shared_upstream_bandwidth_update() on platform device
> > will cause a kernel panic with calltrace:
> 
> snip
> 
> > ---
> >  tools/testing/cxl/Kbuild      | 2 ++
> >  tools/testing/cxl/mock_cdat.c | 8 ++++++++
> >  2 files changed, 10 insertions(+)
> >  create mode 100644 tools/testing/cxl/mock_cdat.c
> > 
> > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > index b1256fee3567..ed9f50dee3f5 100644
> > --- a/tools/testing/cxl/Kbuild
> > +++ b/tools/testing/cxl/Kbuild
> > @@ -15,6 +15,7 @@ ldflags-y += --wrap=devm_cxl_add_rch_dport
> >  ldflags-y += --wrap=cxl_rcd_component_reg_phys
> >  ldflags-y += --wrap=cxl_endpoint_parse_cdat
> >  ldflags-y += --wrap=cxl_dport_init_ras_reporting
> > +ldflags-y += --wrap=cxl_region_shared_upstream_bandwidth_update
> >  
> >  DRIVERS := ../../../drivers
> >  CXL_SRC := $(DRIVERS)/cxl
> > @@ -61,6 +62,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
> >  cxl_core-y += $(CXL_CORE_SRC)/hdm.o
> >  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
> >  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
> > +cxl_core-y += mock_cdat.o
> >  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
> >  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
> >  cxl_core-y += config_check.o
> > diff --git a/tools/testing/cxl/mock_cdat.c b/tools/testing/cxl/mock_cdat.c
> > new file mode 100644
> > index 000000000000..99974153b3f6
> > --- /dev/null
> > +++ b/tools/testing/cxl/mock_cdat.c
> > @@ -0,0 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2024 FUJITSU LIMITED. All rights reserved. */
> > +
> > +#include <cxl.h>
> > +
> > +void __wrap_cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
> > +{
> > +}
> 
> The addition of file mock_cdat.c made me wonder why this wrapper couldn't join
> all the other __wrap's defined in test/mock.c. I tried, as you probably did,
> and see the circular dependency. I mention it here in case anyone else has a
> way to simplify this.

Yeah, unfortunately symbols can only be mocked across EXPORT_SYMBOL()
boundaries, but since the caller of this is internal to the CXL core it
is not amenable to the wrap approach.

So, unfortunately what this patch does is break the expectation that
cxl_test can live alongside and not regress any production flows. I.e.
what this patch does is replace 
cxl_region_shared_upstream_bandwidth_update() for all use cases, not
just platform devices.

Compare that to tools/testing/cxl/test/mock.c which arranges for all the
mocked use cases to call back into the real routines in the real device
case.

Given that I think this puts the device type check back in play.

However, instead of checking "dev_is_platform()" check "dev_is_pci()" to
be consistent with all the other CXL core internal functions that exit
early when passed cxl_test devices.
