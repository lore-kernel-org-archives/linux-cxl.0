Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B01BDDF
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jan 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnD9KNjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704300365; x=1735836365;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ICMXQQbG5KUzqOaqDyvxyjmAyBtRKbJRgs0b4ukBeeg=;
  b=AnD9KNjR+spwvFY4nxeUtLElna1X4whMAh6gYHAh2fuXlcTRUJmFBrdi
   VWOz2Gr1ept7i3QVAMUZxXgsxNdnZU6f1tVrkATJ4YV9U4v8cDbrtD6nJ
   ehVv0VTVMJufCiPN89Q07Kb7dlKw9Fv7zX8M+S2Chal0mIEh4V/nstY4r
   nYqlg7wLWMoX6mIvK8MolKEPJvE6ahPTBxMkXIXb8GUzflwqUiXJFXsW0
   FcRRb34i/JF0J40J6z8rnL+0uiTL1ydYg6pkmZZZtdovAwE8rXf8YEuNY
   e2XhzATQnDFdhi+DGJyS53tk0MS9Ir/Ec+nXvedfnD2s7OSp2OCNnaaqg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="399806872"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="399806872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 08:46:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="808882587"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="808882587"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 08:46:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 08:46:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 08:46:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 08:46:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 08:46:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF34f2HnI8AngLCRdpviRehtQKQW+6eyCwbe7GBxqDHmF7Q6V84J700WwC+PluK3hsbBVtj/L/Y1327Whi312pmiHjYSXuGznK9gTrWmImxaH5p25Qhaz5/l2xBjgq/ixGKPJT8uWgAqD/+rT9W3o7FXtbxqsD24ptq1S/1AwgRBHaiJ5GkCbFuYcF9USCihCEcsFfZmtAFvyOCwIonBfLe4eRCWzFin2JrZYKdaOQZzu4h/gr1rcUrjJI4wwcKUX5h4l/JjogOfaGULN9AtUdnfPzlBdzxtBI9d5hgFwiseOC6r6Hbzo1rKUgsfMuFFGDajI0BcirnZcp88mQw8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d30y/ceHDWjze2Klocz/c03eJvrgNTS+WSagas0IGOI=;
 b=lYu0IphQlHRyfs0W6JgwGMUt6ztOoNIqZjOSQqJDlxut7715Dmqh13NFJwbInBGNhqzPeSsCzutfgB5a9EK03aGlYNmq15y+Ja/qkbQgy0G2Up8yrHryZs3V7Fsxjg9+BXny7yWX7Xf06SODy86YjW3htx9VyjstLxdNYHlkJN3vOQePr1GFiNkO6ZbeNiXT/g1LWGxdTRhwWjTKZfODCFO5lRAtpjcTPWU/MJYKAcQ/V4tcg04Y/9UZWrt0szrljT6UjdhUn61ABQbIVE4M1dOFM0IICE+qFkLVVD60YfpLvA08+xR/pp1l/Gwepgn8WNE8Z/nEF4coy9e0F2+fOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 16:45:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 16:45:59 +0000
Date: Wed, 3 Jan 2024 08:45:56 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>
Subject: RE: Some thoughts and questions about CXL & MCE
Message-ID: <65958f44d67b7_8dc68294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <46c10608-fd28-45a6-90bd-28c1b9678af6@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <46c10608-fd28-45a6-90bd-28c1b9678af6@fujitsu.com>
X-ClientProxiedBy: MW2PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:302:1::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: d184b461-26b4-44e3-7163-08dc0c7b76c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bz9ZH7rSbuT2qO6b9pdstc4J6UPNixCd7hHa2aKG7Ie58TRcsEjj5DOCUlofLPV8sefYbjr/4/MK5vyoLp3r0NgecV6Hw9SMX1qC9YKnMSDsNx1kqvIeqS+O7HroBG+nP2qP9DvtvgBDA692fcj/wGBZiMNML7ivHaCk3vc6KDXQl3rQqmjNO4frv+ltiq97eLgkvjHKwi1FLSH9zKiiDWC/81hgJ9PaPWvu4XY0CBHOtAaGt9ZB9w1vtNSXefX4cD8VYBBWH1azwYVw/PqMuxtiW4GW0eGPaS33nOsEdQkYQyCBgD7sb7fPYqr8e8VPU8PanqgaUQMgn8R9x4DLh9bNwvQfOW02f6x78DSg1AUXW7tW8Yx1rp+8JeqOHatBek9hP/pfq95gmqlWQfYYdRvemMjUcTBBstKSzt4wIe8CvZUJAlAg9SZkrtEDWrHmsth1LNYbBobzxTmMqPVwJB/rURGcgv+ScPbsQwNfWa/ZM15rgsuh/SCm1iNe6zQ+GRi9Un6jGFHFoNV8x1t8uFBhaN1X5RDx3ddETAgPz3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66476007)(6512007)(6506007)(66946007)(6486002)(86362001)(38100700002)(82960400001)(41300700001)(66556008)(83380400001)(107886003)(26005)(2906002)(5660300002)(966005)(4326008)(9686003)(478600001)(8936002)(6666004)(54906003)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yg/ReqcrSEo3k5/OHVho5fX6/235cShLH/C66fKHnihY/21WcB1T5tYuTcsm?=
 =?us-ascii?Q?Vke+88iHR8Tu25FLxBdAkCBWGYZXc8+ZVLb+mUGdlGf3zmYze9NxHTtk8H68?=
 =?us-ascii?Q?gXwpyu42KeTdFmyW5bM2sLwHDstkxd+iB5qBJ+0fK/VIEBPF+QvDBcVuQ85w?=
 =?us-ascii?Q?wTXgLwOSFGrB5xzxwMLw/UlrLwcJzkN/Q2TIIM36jnfEECpwOeZG7It/at5E?=
 =?us-ascii?Q?v68yQHw1uslle4SFiG9IF5AGOmn1e0QJ2vJpaKkHABAS7N+s2ZKLwFKWGi9X?=
 =?us-ascii?Q?LNh8sK0oqtdzfUJ/vcy9yyWr9G1aYcxo9EX4Fj7/yqHc0il3GBbkN1L4sK8+?=
 =?us-ascii?Q?NplrpKm0kWAtN8a6vhG1rUFQ/Vr3J/BVfSm3db/MQZd76Q7JiC79QSwkgmDT?=
 =?us-ascii?Q?avNLZrWtW/npOlItx5zRsxcwHfFuVE94OF4MxEmfTID4fP1ZzJbvbR8XBBhg?=
 =?us-ascii?Q?TmcWhC6dbGVgWnvjX/bBp4ai12IJkzVHdau8pAGSdzNJass0L27ylkyWPC2g?=
 =?us-ascii?Q?DFs+MJEfdYvl0kqRi4CEHqPfw60i0tH0m7Vb5JrtCRLcLsP7LnIt7aSwquVt?=
 =?us-ascii?Q?fC5bpgwEFI4m1lp86xDpHqqJaQmTHcVUih3oWQjbTNYXnOq8nGKglCN5Upx4?=
 =?us-ascii?Q?mOjrVH4Ohd7jYoHu9BxB/QsdHVbxk0pJ8gSur3P4jmtPuGZXYILqBumQI1uY?=
 =?us-ascii?Q?NBN/g6U9YrHfTjpB+tUHZWELpiU7RBdKxFme5/PTAPgDodxGl09kKwMwCFBK?=
 =?us-ascii?Q?E1K4NsnhtgZFvXrrqriBqUIbCfStd4OXFrPaH8RDchb3tLS7uXRPmSZVlRKu?=
 =?us-ascii?Q?L8uWAsYLGQR1E2nab0/+78TCsgHVOQci+z/Johs9z5mFSMGmBWIZ1p/ig/pz?=
 =?us-ascii?Q?cKDDiyEOHtNJBRqyQp+a+y4xjVA1k61g4UY6iwD+T8yG6g9m8T8qc8un4VlQ?=
 =?us-ascii?Q?02zmUH5yST07rMiJKE+8Cx7ITif7FArP4RwyV2icAvrqUHe4REL0J+e6Man4?=
 =?us-ascii?Q?D3RfF8mc0qH/nKdsA4qn8oXNI0uh3l04tvvQljOMBQHITKv5T0Wgv8ASiGGv?=
 =?us-ascii?Q?iJALridINWGpA6ah49up2FN4GB4c/+nhU4LVA7RMwvTocwtZlF2Wer2FXd/v?=
 =?us-ascii?Q?QxvlxBRf7ybm3PLxF/QN9WN6Dj0MWB1i+/DbmdZTakaxpxNQEkatMEkZSJtF?=
 =?us-ascii?Q?biHrglROtU9mmZFhyb3TgSXY4cV9YOJtMCaX8PUaCBYzvzLJtJePB1/kj8Hz?=
 =?us-ascii?Q?eheoe1cTPnGxccY+F43d94rXMiQH5FbqGNoZ2Z7d3Svkj+P+wzOJf+HEulgv?=
 =?us-ascii?Q?Ho/8QpPGLMtIPFDvPJWiUWifUMA/qAVUTWqoivKSdQvUpfuPiL+IpGduJ3hS?=
 =?us-ascii?Q?eVnspqmdUPwlhCuDAaiIknKBY2fAPexeq5gcicvb/pOU51DsfRgClppn1gZQ?=
 =?us-ascii?Q?s57VyPYyRkusVJZ104PKJesqNKm3ogkmOHTjBDar7w5Y8FT14M8GpTyH0YL4?=
 =?us-ascii?Q?fMFTRzIVmoQ4JhIF7upxg7Rd5/5sTjLBMJUn8ZFGxYwhb2Z3L6arpCuedAMQ?=
 =?us-ascii?Q?2qmKWephsFw+kM0PZCfTEtFkIz2gpU2y1fUYiSYFzGWGGaqMbK+5rgQz3NhX?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d184b461-26b4-44e3-7163-08dc0c7b76c1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 16:45:59.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQHBxMYn0Xyl4cstzB5kRhDqSGEZKXCX7JvThfXEkKXDBN84xGWrN0mGjtihvOwI7BHVUM676zAbqHXZCDlnUQVu1+m8liQYeACGGBjzdow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6025
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
> Hi guys,
> 
> I have some thoughts and questions about CXL & MCE mechanism.
> 
> CXL type-3 devices can be used as volatile or persistent memory, so a 
> poisoned page on them should also trigger a memory failure, to let OS 
> handle process using the page and let device driver recover the page.  I 
> am now investigating this.
> 
> Currently, CXL RAS is under development.  We can now inject POISON on a 
> CXL device by qemu (qmp commands), and then `cxl list -L` could show 
> those poisoned areas.  But the POISON injection is silent, I think we 
> need a singal here to notify OS to handle those poisoned areas when 
> injecting.  According to CXL 3.0 spec Figure 12-5, there are 2 methods 
> to send the signal: FW-First and OS-First.
> My understanding about them is:
> - FW-First method:
>    a. CXL device report POISON to Firmware
>    b. GHES calls CXL driver handler[1], which will handle the POISON

Yes, GHES conveys a CPER record to the OS and the CPER handler forwards the
record to the CXL driver for address translation.

>    c. CXL driver handler translates DPA to HPA, construct a mce 

Close, an "MCE" is the native notification of a machine check exception. In
firmware first the error is translated to an EDAC event via
ghes_edac_report_mem_error(). That also gets translated to an mce_log() to
support legacy consumers of that event format.

> instance, then call mce_log() to queue this MCE (? not sure)

CXL firmware-first events are all reported in terms of DPA. The BIOS can
additionally do the address translation itself and emit the generic
memory CPER record, but Linux is assuming it needs to supplement CPER
records with OS translation.

> - OS-First method:
>    a. CXL device report POISON to OS by MSI
>    b. CXL driver will handle the POISON
>    c. same with the c. above
> 
> So, I think:
> Firstly, and obviously, we need to add a signal when injecting POISON in 
> qemu.  For example, call `cxl_event_insert()` after injection.
> 
> Secondly, implement a method in CXL driver to turn POISON to MCE and 
> push it into the mce_evt_pool for decode chain to process, then 
> mce_uc_nb on this chain will finally call memory_failure().

The driver needs to arrange to emit the event via existing memory error
record communication mechanism which is ghes_edac_report_mem_error(), or
one of its helpers.

The EDAC memory error reporting ABI is well established, and perhaps CXL
memory errors can skip emitting legacy mce_log() events, but depends on
what userspace remains that still consumes mce_log().

> And a question:
> How to configure the CXL device to choose FW-First or OS-First singal 
> methods (methods for qemu and bare matel if possible)?

Honestly I am not sure it is worthwhile to have QEMU support firmware
first vs just have a way to trigger CPER record events. The goal of the
CXL QEMU enabling is to test OS enabling and the virtual device does not
actually need simulate all of the Firmware-First mechanisms, the CPER
record result is sufficient.

> I don't fully understand the CXL spec yet (it's difficult for me), so 
> the above ideas may be immature, but I really want to figure out how we 
> can make CXL & MCE work.  I'd really appreciate it if you could help me 
> on this!
> 
> [1] 
> https://lore.kernel.org/linux-cxl/20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com/T/#u

Following this work from Smita and Ira is the right path.
