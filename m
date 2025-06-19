Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3456241CAF;
	Thu, 19 Jun 2025 05:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309484; cv=fail; b=llnZHBlm9CX9sN60ruX2bxhWB2VjaL2Hh9CnFEW54spg0c4d9xhaiAwSBReAhwfdNsvLKOPyzHsjGgJozRzmrkwvg/L/m27Vc0PEHxPSCWZXqquLNWr33kbLUGZ/3V+UWCc0sD0Z1yq6InfZw2V2vJGjJtuIdFZ/3il4y1Z+F8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309484; c=relaxed/simple;
	bh=4DnHF9A1A21E9R797LyRWfdWr7Y7mTgWEwtPm5/lAlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7TyH7B15YqSqf41jZGpVArr7otKHTDk57dj8iGTO8AGoJt6FCKki+z6qNHEIBMR1uUvVwlN3sYQeD3r2AmbHK+a/lmhHXkROMUxuPD4M3swgvK8P2xHmzqXTa20tpJnSW5m317vJXeWsczSzIBZZEzW43cNmI92KENavp7nZAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiEEXAnv; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiEEXAnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750309483; x=1781845483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4DnHF9A1A21E9R797LyRWfdWr7Y7mTgWEwtPm5/lAlo=;
  b=QiEEXAnvaBH/iZJ8ReTu08rjYf5y6B88axdb9zQTWsVqi9fmibrd4WtX
   4tjileCOrKaekxVnAbkyNT/+8XnWAVriccx7YZK5jci0GHLnng0+HHjr3
   qKsBo4In7wrj3EFGOcaBLaLOoWsUAsL1HFYg6m+votBdmdqSLJl/HWvmU
   mQxwnUo9ogOk9fxFcDzJPMLAVgGcvVXDvoNmnXNec5xwP2aYt/olomKhm
   gxHMg8diWmPikcJUdiGielChUiJ2tjDPLo8KrgYG1V/sE7jwCzQ0D4agf
   UHsAys6yGIUvWAA/o8aJqkV+gE1fhixlYmm3sycWWHzLCsVKvDzo4hzii
   Q==;
X-CSE-ConnectionGUID: smN9DhWoRFqskIneO6zgLQ==
X-CSE-MsgGUID: OFy6xqEMRW6Lcn9eDMSj0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52702213"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52702213"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:35 -0700
X-CSE-ConnectionGUID: DlMnD3qbRvqNLNjE3/bXNQ==
X-CSE-MsgGUID: Qumzr6iPQTaQzJXt5c+duw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="181373565"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 22:04:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzaZlKbvCa5M4cWNEJ/6EktEh/AZBVyVPCxlT8X9i0YTJVUjKdPhgiV3r3+F+fQp3oTGcn4tdWejNnaBXwJ7vsoku75yFK8ZH59Ncy2AojZO3tvAS+QEAEu4vTW2DNGuhLhzc5KiFLAPNfan0joVz3/GpLL8Ei5OQeAMHcZUEvt7BrhLf34cEC3XWMzjkSSRTdwe0+dfYmwhZwCqvE11GUIT+OfVZNDxY9aOximjY1ymbzk5DpHXkh2UV+NC3pKhh3bGnkiusJUADlzVzdO+hM3gbV0BQ98e89gMiJkEzUJjXrQnGXzy1z3c4aXjq8OMEd29yeuR5eoXz1NHoXaMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEgGnD9q0IkaLjzWWz87pka+kRKJlVvJFHmzQjKwD6U=;
 b=ySOs+cjgaWpUJlK5ar1FR5Tsp9jms3V0p5jbss5tABncQ7dQCWtIXDIt4JqauyB2Om70HNSB6AxeTcXqzCLzfKiCB3AGbiVMM4WCyIcsyiyooBmWs7IZg3XBkmJOuMCsWuXTtmnbZ3p6eBgvK0iCTaDZxDlja7Bw74oXkVv8V0qDEK281Eyd1Isut6k1bRyfmV528F4l1kYDG4HJLCYpLlqDLBhtJAYH4V1TVzgRy6tGOG9xLcSXF8XnRZN9Yq6hkxMsDlinJe+VmgpBlUQElLFR22QDBXd05Dy/X55kEU+AjMjUU4JawGcPNcLJsFNRBnrmnAWLIK7bjRv9EIn8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 05:04:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 05:04:26 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 6/8] cxl/region: Move ready-to-probe state check to a helper
Date: Wed, 18 Jun 2025 22:04:14 -0700
Message-ID: <20250619050416.782871-7-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: bfff6430-d117-456a-a5f8-08ddaeeec346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2d1chWbAVdyK2zzdp4H6zfeX/azLT8zUGowqy1EKKzQyOyOhVMghcFbZJnib?=
 =?us-ascii?Q?uDNuS46ImWttaCqL9rsSygMa1bYKJMM1V4MIAMV37e3QLevhpTBJQndbDBJo?=
 =?us-ascii?Q?uxULXEu+oIn3ujFEc452n6aqCyNu9xc02/ks01F65WMEptDYpJOGmPptUIwW?=
 =?us-ascii?Q?a3bI4sIO0o0JPGjprFPSKN3A1Faq92xot7khSoE0T0Q0w2ZEXJHd+Swkj3mF?=
 =?us-ascii?Q?NwKU+S1X/v9nVUj8ZLNrn7zRknBqriWGQ3z1wjoEQHbFtdS2nVzkMOFoP9Po?=
 =?us-ascii?Q?T/z6pm8OTnQFGBiyu8bzZnvIYAZURxsZ30XSoaJ7Ld8rSoXHrIlBWPMPn8TW?=
 =?us-ascii?Q?OR5m66lZwsg2d1CNiOgzuCGESDqpKXTKd0UFucw/GBN28CEmuJtUAn/vOT00?=
 =?us-ascii?Q?lHg1LIabjKmmF3N6Yx6GkjJJTzX/uvDFA/XAdbG2U5ioYDUp0gtqjpUs7xVi?=
 =?us-ascii?Q?yrhchsoo/rZVARqPqrNwFQoZcX30vrks9I+Dg89J24qYP5XF+M8v5KBBTJYT?=
 =?us-ascii?Q?ADVYt+lgM98zAOdwsji539MfQsvXf/WSyZ9oKXHsNR4vi68IBrHk7rckHTxH?=
 =?us-ascii?Q?7bG39lWDRyQyQDR9Esmwg7d9FkayyKk9qGq6NBxidMGfhtw3PNOar8Z2+vys?=
 =?us-ascii?Q?6UYlmWdgw2sOL/fqkd24CabGg5s33gv+sPd3a9wjgJHhxqD8Bshs/miD8iPX?=
 =?us-ascii?Q?wqsoJmsHt0iWY7fUdMXbPhZc+qjbO0Im5iDIp6YaVF/QkHv3Utq4cIpuj+r2?=
 =?us-ascii?Q?Hxc6ZJXpwJBXZxB26/CVPx4/kba5YLYcaZ+0PGQMCCcPREuPVyT8ObKggoMo?=
 =?us-ascii?Q?va5DaED1fHtb7GffSZFcb/kyxCxoY4vELB1XwQU6LT0gQIp50flZZWqYfmNd?=
 =?us-ascii?Q?WGI04F84sj5OwZznn7EG9pUDOm3riX7LxOfKSmNNsjPXAfhzRtIdtP6/ybc7?=
 =?us-ascii?Q?TuBNtZ/+akY5Qswzg42ejQs9p78MrTG8rPTj01Rp1g0/KixcJ+ZnyAjSb+sv?=
 =?us-ascii?Q?RRCUrMnGm78FR/L8Yg3O1dfkYDZTNF4oj+n/BwcbpDr4Tl/qjGf0vYamEtH8?=
 =?us-ascii?Q?6Sg0LiZofI2HvZFZ8Wo/sCibbvEHBclci95KsTEiyM2v1r61hC6OyTSMQO+e?=
 =?us-ascii?Q?n0i5Q3PxP/h9JxtqiFKDXKOuJ9bedR2Bwhkh+Jwr6Cq42OI9dFLgixbEXkbL?=
 =?us-ascii?Q?hjMYxBurmpb/G/mgSk9w/5mhxTHSgNXeEDlgE94jn1yBm0sIh0Q+/S0kNnvr?=
 =?us-ascii?Q?UzyrCTCZv59ce8i1/oaFbWcJt8cjTSWz3CZwuBLF7LXQes2OO5DYeF1nkiRc?=
 =?us-ascii?Q?wuwzwtZJEYaUdL+v0+QecqdwMuvRZQpC6dn3BDS5Hqap8CcbgDjXBO2fxgYK?=
 =?us-ascii?Q?SdEl/K5BvwaDVfOSTrj2mKz1OO/vGOnbHHhdsa6rxarSahYgaZvn8IOFca/5?=
 =?us-ascii?Q?WYvDVqZr5k4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jPWY4xV3BjRX1Hjw1/t7Bva1hXZFfpv0SIf713ao+WfOZsNVil671LFOBVeV?=
 =?us-ascii?Q?BEY41OBTawPJ7/Bz49FJFpTb8Fwunmzplqi40OA7PhZUcWKp7NXilaxCWGfx?=
 =?us-ascii?Q?ofGtEkDX7aokbhpntLq2cOuyKi0VzO4pI13rcuY8WmtV3PsXJfkh6gqHqH2q?=
 =?us-ascii?Q?FE0WU62D3ZjpWhe2EIVaaEFSqWRTxJW/0e6h3RkbIncRsQlQP6GdI1TL8U2y?=
 =?us-ascii?Q?c52i8kN8Lmfj/e78rpQohiY4mmmvIktCnTGoS5Cl+BOh7HcjnwUsjUmjItl2?=
 =?us-ascii?Q?N/jpv/dP/2+u/i2PFbR/oGRWLSGjDswZgbGuUrB7OasfsvSBvEtspaIIxy7O?=
 =?us-ascii?Q?Ch/Wtn44wfqZG8QWZkVfDs3dSyQXwtpupqug8323iX+5PaY3f54ahHJWUORn?=
 =?us-ascii?Q?KM7A0MRqMDYgyCxzxhZiHBpDk/VHzGIkj9TtZWjAZX+3J8jzTWPxzOcWVJuG?=
 =?us-ascii?Q?xHDsvT45uc6djv7NgBi4Ca6wLvOCHnKuaG2mWJ3uD97USleX7KYAAt8aPHNV?=
 =?us-ascii?Q?UN02EVDBhzwqi+Sdehtm08ghg0zusgJxCiQI3lAZHCu8u6GVhP3SOJ3p64x8?=
 =?us-ascii?Q?AEi7s2z1rc83pZhEeXnAq9SKc8SPARuPvLKS7KCZscqNbiX7COrHbyeufWr9?=
 =?us-ascii?Q?d0YdJYmh4sLciKCB3GzVXwW+3FmLy+ByrrO/WdiLx6HLZSuT+QC8W0fQqj8z?=
 =?us-ascii?Q?DiYMykVjkbVZ4PNYlPjZS+uL/bqplkD2crol2vglOxbuxGAHjVFEpxclG/M/?=
 =?us-ascii?Q?RP7hncFm+0x1cPehiSyUG4hK14uznS5gxwhmivhLGMxPXmPlE8NL+83P8/b5?=
 =?us-ascii?Q?H8sPn0sH3dM+AB5XXVza/nqeNPLI6GSODj1UjFW1lEkaQHa/bbD9L0TpvrtK?=
 =?us-ascii?Q?nsB6+2sT2W/mRZtURjvtt7OItyKDQpNLnt41kdxE/5XQ6yPzjhogpRdLZ3hF?=
 =?us-ascii?Q?sHVQl0FvnOa94s8HgYJT6epXCaQwGBKGLvoeZVm/UbmDGhY7dm2ublxro6x2?=
 =?us-ascii?Q?YB2KBbSzqXau2WmsJVumBGLp2xWd07BvAD8aBU9GDRqB4V8yV0/m7wIvVWxd?=
 =?us-ascii?Q?BRL+hpNdPIiIhOG5WrRG2ukeuSWQRrJzxQ+eKSfGJni3nq6w9w6P66dnuRUO?=
 =?us-ascii?Q?zTpPLuhgtXyjN3nxcqk8VfCRg7h9gszt93cyFgirvaX3bzDw0m/H/hZYNuun?=
 =?us-ascii?Q?DXDHwPB8tZZJ6j4oJWBBLsY3cwszz9OY00eW30Xe0vEI89fPOlpA25s/x49z?=
 =?us-ascii?Q?gJYuLTXMNfyq/VngvpdSvapPK4IHzydZOh4ODsz+ldFDDGqmeDSnBQ6eNN0X?=
 =?us-ascii?Q?RBkia/F1sxZ7CiXl2u8PrvW2+PvsfIbMVb3pm9TOrqj5Xu7nu6RJgqG3Kuqg?=
 =?us-ascii?Q?1hvtMM5v57Zjw6/PZif6zMuPxZuLsrjE1Pp7f1AMhbCZluy8hjs9xAgtTS5v?=
 =?us-ascii?Q?5vtnBCI2IOcdlMOisFsK9wPdSD3tLjV+PE2p2p6hESupSKxb6+Plv2Oi8ZWS?=
 =?us-ascii?Q?XDD7P2zq5ZXXqvi5wOSMELFd83xwAIAK1sjolI9Qjbm2hndIY0DJT/YjOdsM?=
 =?us-ascii?Q?ESTdM/Tj4X6BRpqwPFd46tnF4/eN3236QpM/RpTRVrOPscLBGS1r+RFZYKLW?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfff6430-d117-456a-a5f8-08ddaeeec346
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:04:26.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 930Lh1xrpRufmaMwl6Tv5ME0Zd74VZCVF2AejbNUFtDVjjIzAg/u1WecQp/g+aHUvjimubRwQeh7l2hXWMZP63Q+ksbSLtJkAbjDoyejSio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

Rather than unlocking the region rwsem in the middle of cxl_region_probe()
create a helper for determining when the region is ready-to-probe.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3a77aec2c447..2a97fa9a394f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3572,9 +3572,8 @@ static void shutdown_notifiers(void *_cxlr)
 	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
 }
 
-static int cxl_region_probe(struct device *dev)
+static int cxl_region_can_probe(struct cxl_region *cxlr)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
@@ -3597,15 +3596,28 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
-	/*
-	 * From this point on any path that changes the region's state away from
-	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
-	 */
 out:
 	up_read(&cxl_region_rwsem);
 
 	if (rc)
 		return rc;
+	return 0;
+}
+
+static int cxl_region_probe(struct device *dev)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
+	rc = cxl_region_can_probe(cxlr);
+	if (rc)
+		return rc;
+
+	/*
+	 * From this point on any path that changes the region's state away from
+	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
+	 */
 
 	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
 	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
-- 
2.49.0

