Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4367424169E;
	Thu, 19 Jun 2025 05:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309483; cv=fail; b=Ui65phHIfScoktSW3YBvUSPbedWvuMXiy3duQEFR9FI+ymzv7lWVvjPXlIT4QJcTTq0l68dhVfMg3W2eWpwEshasyeGLxFSGP8xA03/skswhJItWRugl+HfeaWpH8+hfQBqlAjgN2NEzqklzcQ0uufp9U506Sh3CopqHQNAObtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309483; c=relaxed/simple;
	bh=HW/MG0raKPsFrd0M7A4J/+A3eZkrc0D15fSxP5inygA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iN6X0iqhk/ACXkso4eZMfV1tyi1qFqAOD7GwD+NTh86jzkPSo5ZD+Rn5qb7wO7W5GYdm/xDUBT8JLyisqDzr4Ii8ZF8Bl+46k44ePmgqPozAq7V4494usK93tu69+nP6P/Q8ewdA4EM1LAout6RaEzvBEC+QIiVWWjvD2hY9rFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqIeFJ4E; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqIeFJ4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750309481; x=1781845481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=HW/MG0raKPsFrd0M7A4J/+A3eZkrc0D15fSxP5inygA=;
  b=aqIeFJ4EKIe/aQ+S6yr+4W5yDZPBiMTS8SpBg9d+oUIr+qtbPKNVpLKn
   RYN6Qe3FajS16Qcc0vY7gt36QmURcLu/lVYvEFqKe/chiC71oroNqGFL0
   lnP9tmBBg6oeVmFIdwNG4+m+JXeox+/1xAtvSJdnGjbkqT5cQ6l0Ty4L/
   XVfO2+Z1MeMIw0eg5npPi4fhsQHsLhr37iAYOkAwpFMZBoy9ODLkNqdmT
   1xDJHBM/qQH/1qFHtzhx//CItkcpNOqITMuKXA3MFm3jLFTPOkeKkzuc3
   K8CvNT84rMDJ/LKU60dbT4krvDHbdA5Nb3kW45THvnl+mswRq9MMpDEks
   g==;
X-CSE-ConnectionGUID: foKntaYHQPGcH3As2vWFHQ==
X-CSE-MsgGUID: ejHWxIfYSuGqedUlwHi3pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52702195"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52702195"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:34 -0700
X-CSE-ConnectionGUID: VaddhshTSSG0SaTwOfDXjQ==
X-CSE-MsgGUID: xzDO6vI+TtyrZSAyktxWnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="181373553"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 22:04:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRSyJeEO97uv9BPiUMmZ/VDHLOnm8pKWJiwvIl+TId5MNAEzdj07YVCfLlN/TZ6Lhyst8GFJT8AypKmNWlHl+3N+QLe7Iy6A/IS+RBpViQM7SeAJsach2UAvupavPkVBP8yGrojLA4rI1YxgR/4Y1L6JPYb0bMLU1FXRz8IDcKfrvDGCiRa7Hv9ZFoKt/uDnZhU05GlRrTYDbdIMgXVU8eVaUBKi3cIEVsFYqgK0EpRyZEvQY2hIkiyxcj1APPtGOKfvjCQ01DdOo8y13EnZRJlFeiMxTGtwP9f2pdzoFtJNtrOFynvF2QRL9AfsybsWis1ifXLv65QVgGaN75DKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVsAcbC8xBB1mDBu/bGESO+3nCdprI3TV0D56evqbZ8=;
 b=TsjnPD4/iyPJULw9NtjGL1WWvPTDoiQg4fGbx64tVHbXSZQGJdNMBXtp7yabxfAuHn6nDzAVMDWZNnBhW4F+xf6Z2s8kwXHxe6rtddr9GahTn/kjytNZC+2w/a7xN/do1H1IL4wLwCmleUOFVl0F3n8YsLOzDEVVbA0GDyI+Mo+M9+G5qLcPYR/enXpnOGalwM8KVZkA9DhcUpKtd+OdnfP/XBRh6kl4ezvcaCInom571ocCGFju2Lyvrl+LIZiXnLHQdI5RzcMt3lGXJ2gLjDJI7SZTDj6cio9qZBnEtsd1NBG78giVed9QXJLvEVY1/m39LPvJAMA7Jr+/TW++Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 05:04:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 05:04:23 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 3/8] cxl/decoder: Move decoder register programming to a helper
Date: Wed, 18 Jun 2025 22:04:11 -0700
Message-ID: <20250619050416.782871-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619050416.782871-1-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f89187b-a4d6-47ee-c142-08ddaeeec188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yX48kTV3Ywz6+RLOcNQnwDS8DJu/rx4W6JQvbbspWy7MGZ7ZltTa9YRDDGQP?=
 =?us-ascii?Q?mHpRpDk0I4AoSu1d8v9zNCDJPUiURa3d6vjhrsc+nlJxA6BLXUaxdkZX6OVE?=
 =?us-ascii?Q?9blWRwO9kt2K08pAjaV545GD4SoW6Y3JN/ZZKHgel0vvuO6X5iTARjUIBueg?=
 =?us-ascii?Q?liazDPutnXv9L9p3Hp+HP3TltcWNUeqqQ53TGlBZBb6ooC3JwAP4Ndc8UEtv?=
 =?us-ascii?Q?wf5pZxxbLO8PQXz4tpAEfUBUUOi2F6wAY4w40DS1G97j6jaVnCQhMZmY2xOT?=
 =?us-ascii?Q?4GiZ/EmVgw+secB3cRd332oLgUP/ANzL41mvgJeyhTCbRJTsifAYW9OH0Akk?=
 =?us-ascii?Q?6giLxUPiKVo5ndgYJuVOxpdJyarcwcERYMMGBwsUDsYAy7weT6sAqncOZhFQ?=
 =?us-ascii?Q?/jKeGcr9YTzp7ohEgazTbK8ndo2KMp7KzicZQ3YGLd5u2kESB8kgKDK9cKrF?=
 =?us-ascii?Q?BU64a39IFISFPS14eakjIOcOrpeoDnkrvKAlKhR/pgbvqNsaqVboio85lrDi?=
 =?us-ascii?Q?h7C4V6t3G6lmzoBA4yONE4gb6+A66qfCzBHR/O+KXeN4at+/mhnnrS9ixELi?=
 =?us-ascii?Q?HK/J26xlY7Fd57+jHubjX6w5GG1hFOkc/l/f9mHgw0qGF6qXm6uk/HEz/WzO?=
 =?us-ascii?Q?L2elwpHOH5Soa0MaWrwXENCoR0NeiB7XSsvDk3MAJbP2PQVWVqHn44yk79SI?=
 =?us-ascii?Q?MTLbdQ191aJDkM0uibIS06hIzJ0Dq3Gx321DQsOdjZNDsCArtOW5D4RCmmiD?=
 =?us-ascii?Q?8rNRv1GXy8gKoHrTM6IetvfHbKp/9LhkHE7zUAG/CcQD00fR8ZrUOulkVKP8?=
 =?us-ascii?Q?Qxw3xCYm+fKep5FJds/fREUzJe+0Nb/sBvOP8LBhIwTT1PSYav+VE/CjG5Tb?=
 =?us-ascii?Q?DKDI9EwhLLfbcWlUkqc3mIw8nni8JHXNeBU5uBpMUoxmvy9Ta/nYjN5DciPQ?=
 =?us-ascii?Q?mIeCgY4zJnOq0DATNHk2Lm+Lw2T6Nvn1UiBUhURYyu6ebe1E2NUiIHwVlS2q?=
 =?us-ascii?Q?FvS605X9LaQcVG6x4OGqsc+rCvLIAF6bqxW1xjszgGLnFjm0iWfK7TobbPsE?=
 =?us-ascii?Q?r6uIuIKHc+pngoXvl6iGm73CgBjfpQfhd+aM46wXeutz/Y96kEfoW8ylMQHY?=
 =?us-ascii?Q?rskn/GtTKLP/zKy70ACFXBTmqDvALqky+UqtdWuZBj3Y9znVXXppId7yqW1z?=
 =?us-ascii?Q?o95hsGyah9Wem0h+yImKTzwku3rl/jKPJ5FyVQO0kvofP0XdOxYZ52rYX+tC?=
 =?us-ascii?Q?Xuhjx7oGtmcUx/AHCJ5p5m/CH4wz4qhHeNvDGHZo2HKcJb0uhsSm7O2b68pi?=
 =?us-ascii?Q?YglCoD5rEE+tuDMECt2FoRVkk2i4uQ0xaHp1zSz3qLVM/dXRHr5tlqxosSgf?=
 =?us-ascii?Q?VIwiV95xp5l8qnVc2vdROo0cerGqXbI/59Vxa2O7VqjPxLt1wJ67ZF0NbJ9V?=
 =?us-ascii?Q?kF+WKGO2kO4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZNPBQ7HPUOeO5r972sZ7mbDUj0xrXgy4Qzu7Cl7CSNvzwKP5B5fY7mo++bz?=
 =?us-ascii?Q?edpRIHL5zOsfvz07yhRxQZv31kBnZ9FhB6VBa9CG/3lJTZt7MxoKjzYcEKvX?=
 =?us-ascii?Q?pYUpk9C/wCL5FWXllJfX86pzmHLawxrP5bkLvAoYovlsKCcPX67iBffhlhr6?=
 =?us-ascii?Q?/49uBWNveBhOp75iLA5QERjQJUg0UWhMrpnjxNJNwxg+fNyqLskl7TL6qSve?=
 =?us-ascii?Q?X3IUW/nqxCrgVfz4/jIpJnYYo5Y2u4yU5Gr2Lil3LQHJBNPq//o6sKmlH/Lu?=
 =?us-ascii?Q?BtiEEXbPbXT2BEu6/5rjWiTEatjb7wcCx7sjdko4Y1x4C54vS5Sg5h5E481z?=
 =?us-ascii?Q?kAkHRC/7Lx0omx1c1mK33Jo0WHhcVxbH2064AZ5DkFPOvde8qP6StoHRN8ee?=
 =?us-ascii?Q?Ec46+47Ue10Tj4mmfLg9b9cJiMy6+/7IxoL7q/shFPRo1DBDzIrax072tWpC?=
 =?us-ascii?Q?q0LrRr/xjutjjmi+iklnOTekrKJ4SUZHiIlptverQh2Pzi5Gm7WUxVNNfL7X?=
 =?us-ascii?Q?L/UWn8NUl/+uRlMOuXzuKx9uHn9hErfIdk4lxs2KhDr81P0RY9APyFlcndbe?=
 =?us-ascii?Q?a/jxacA3C9UIGnpJfPYIxXl0Seos8cVFb1/Wbwxd8NpFUwlhb76QILkSanjo?=
 =?us-ascii?Q?nnVvXXg20FWQH1NKQ6DBfu/Lf4yEacF9byWQYjZuvAuzwDonrOPhtEflgd08?=
 =?us-ascii?Q?e7PSCbUkpbohemCD412uJwphmuCRzbIjGX+TewhItc6w9mCcuuC87RD7Jy6M?=
 =?us-ascii?Q?dsRTkI01elYoC7NkBmoQe6TvYkArSmC8mY0Bvdj+52nYojk7AfyMcREtw2OJ?=
 =?us-ascii?Q?s7p/paT258pMox7OpkDjn+yk8yTqLeVa1AAV+O277bz3/whpq+P8rEKiIkI4?=
 =?us-ascii?Q?tXG0oqkB+JCOYyhdbmJn/flF8mNBDSO/Onl9aNSVj+UPeXkuRSzG5pFDkkjT?=
 =?us-ascii?Q?VrbH23zbRH08Q5v+aNjfSE7a/VWJqIJyHgmGHqNit01gX4zHqRqs6lTbKWvz?=
 =?us-ascii?Q?DgA8jHHFO4/EjGOmX9YrK6kTHhGns38Dw3c6W4InSlC95kAadB9hq0dXoqIZ?=
 =?us-ascii?Q?t0395/HgjmGsk/tXjZrlf0Kd2y4gFcmJr/yu71hanM1PeVkCG9+/9goSMgq9?=
 =?us-ascii?Q?xRZt6nt6c4X+dPFMQ4dpHfEEf5YlfYe/ZSlr08Xf5oGCzdzDWxME0TOLP15v?=
 =?us-ascii?Q?Exdy3dDVb6jQuLJVd5Do9QyyccwjDkC95tHKACnnPO5vRTK0HRxp9IsBIv5/?=
 =?us-ascii?Q?Aycp4Fvil3DTPlTdiiiQXeY+Uu6gv7p87d+tvyxXMsTVbrdYU0DhE9EOZeEL?=
 =?us-ascii?Q?OWUMn3VM2S/6qwMxfB/Iz5pq3tFQLqch9Qaw9+wzUSEjetBGScb8Mko2tps4?=
 =?us-ascii?Q?HXvdffF3S/8RQSLuALspja+bExqnH70u5e0NnK7Meqlvat7G4JtO554CM881?=
 =?us-ascii?Q?G2DkeEN6kL5cAxaSs4cPUyNBPIrRbb/j9a2lnVpU4LSfmrChKNBhtiOWi2Tx?=
 =?us-ascii?Q?DaWPbdEp2wfedVBx+kTX7j4nYnV6dOZ6qVKjD9UP10oNvtxU6yMZMxWIIbfE?=
 =?us-ascii?Q?z3QSGLXa384qwL5HBCjXzf2dkXl1g/hztH8YM53+0fvPAH3D3nWRtJQVEiyX?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f89187b-a4d6-47ee-c142-08ddaeeec188
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:04:23.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Zs6OfOVjHmlR/BMIJwA5R3QC2Thk05uWl4/X6Hl5vnszLuMtEJXHB9bAVhoVfZQNJCfYqdb1AjXGloJSwrml6TM9iqJEdmGcfTITKonnro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

In preparation for converting to rw_semaphore_acquire semantics move the
contents of an open-coded {down,up}_read(&cxl_dpa_rwsem) section to a
helper function.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c | 77 +++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ab1007495f6b..81556d12e9b8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -764,14 +764,53 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
+static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+{
+	int id = cxld->id;
+	u64 base, size;
+	u32 ctrl;
+
+	/* common decoder settings */
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+	cxld_set_interleave(cxld, &ctrl);
+	cxld_set_type(cxld, &ctrl);
+	base = cxld->hpa_range.start;
+	size = range_len(&cxld->hpa_range);
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
+		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
+		u64 targets;
+
+		cxlsd_set_targets(cxlsd, &targets);
+		writel(upper_32_bits(targets), tl_hi);
+		writel(lower_32_bits(targets), tl_lo);
+	} else {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
+		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
+
+		writel(upper_32_bits(cxled->skip), sk_hi);
+		writel(lower_32_bits(cxled->skip), sk_lo);
+	}
+
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	int id = cxld->id, rc;
-	u64 base, size;
-	u32 ctrl;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		return 0;
@@ -804,39 +843,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 
 	down_read(&cxl_dpa_rwsem);
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
-	size = range_len(&cxld->hpa_range);
-
-	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
-	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
-	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
-
-	if (is_switch_decoder(&cxld->dev)) {
-		struct cxl_switch_decoder *cxlsd =
-			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
-		u64 targets;
-
-		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
-	} else {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
-
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
-	}
-
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	setup_hw_decoder(cxld, hdm);
 	up_read(&cxl_dpa_rwsem);
 
 	port->commit_end++;
-- 
2.49.0

