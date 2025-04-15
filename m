Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0D2222C5;
	Tue, 15 Apr 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759445; cv=fail; b=ZmI/l+nTMZr+cKPD+THBOvXbeNYdobSR4fNbJBBwQHPke7tDcQFCoIby/nPlhZSsHhsgKZDcRc96aRAcVinBItEJMP+onKFZClXqzURKbScFc5pKKTl7ZNPoeYjeGB8BPC3+pG3FXyuF7z6PPf4NIk6BDKh0b+KjfoJtBNvt+LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759445; c=relaxed/simple;
	bh=1OaVA7TjvbfyzojMLJRaL6d7Lf2MChVzqFtXhZeR9SU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NlliLjzwYZnjJAiTyFzr9TvmjFaPlVX4DdoXI+pA9NAU4Ppf3FBfdRZsqTGgJBbTrJiTCc2CkCP3e5shcEggl5PxA32QMCW3mW6V4jdjqhSxXmqZj+hBuXy/O3U9W14bY5SCRtPY1GTdHFIBXve2ct4qYKmwFVHirEX0GvJCqGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuyC2kYf; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuyC2kYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744759443; x=1776295443;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1OaVA7TjvbfyzojMLJRaL6d7Lf2MChVzqFtXhZeR9SU=;
  b=VuyC2kYfjuMsxOJJoya6QOtl6ywu152KvcdLTUgeX44O+AH+2/s/PV0u
   +DNlk1qxhw5KE3JLzS9scUkdFB2drkWe/asfz7XRZ1oni/kfkN315DCHj
   AiGjRaQiUoo9s4+SnYiITyJs5EZsuuf/ppVCh4fgcUpFvIQIYMMri45YE
   h4CWkIqKeg4Q5GSlG4hiTi81riycx7iq4bl579erVzGDtfjb4fhsE+gom
   wcb8WqXbBVDcdouePPMowUO46+WAoNI6SCn7633C2w+gBVeFoR1fmKAhP
   0PGO6eHXGCRy3wLGRHhzOHz4SfYBY++Zqf4wyck5XGyfzJ4LydsD4x6MM
   A==;
X-CSE-ConnectionGUID: z001BHoUSXKSjh5qdOvTdg==
X-CSE-MsgGUID: wnMOnmWtRdWySho0x0CxYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50113362"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="50113362"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 16:24:02 -0700
X-CSE-ConnectionGUID: 1dOhTLFfRsSn2zWIaVEUGw==
X-CSE-MsgGUID: sl1McA+mTKauKxetejs1Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="135060438"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 16:24:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 16:24:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 16:24:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 16:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJoPxGisRIjpo3+P5c1tLDtXlIjV6/GyY4+LbWtjUdfbjYHxufHyD5QeCuu1zeC8gei04YIcodYaftHb+utaoxR/5WzMgaFZ0z8XBbyXhskRII2/HC4wH2x52Lk82D15nSqY29o/wPV2Ooj/0QIEz3yjciFEUB/XAKfAoTet79JmYcHWKaahCxVxQSOp5oCmcPm/iiB+J5gL9QPv80qwneSrUyFaKX35GorimtKUuY7Sa9QbFsBYzVtZLeE42zJUGny9ecPN8jTTOj4iU/pGvGSrNYb/dSoknKjiwtfrGhTdbHLsOrssjCaQBMYiemY5dtcSbNulVzcJTR0BkHeNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yg7bylPGnQfwmvLKMncTTzzPzPc1mzSemGJXl0WUyw=;
 b=ao4kea3SY+KS9cwwx2AfoAufPqZz5IXUKhMpojzRQ1v1TQ0/tALxz9drWNt8YFD6jnbnRV/JS4+DV7CYgRjEelYxCSXy6AErJ9R9TZ49vUiGGt9FVrc13gJ3mwLqqpwqFvtWfwkm+gwmK96GjTjJDN7OGDKNu/yGQ+DwOOvlM6RBye9dELeKmEDMpepTE+OoHbBX4roVkFXozhhTpeIH1H1nBIhNJ3aJznm/DmbvL2+UZ/iGZ+x4EoE21+/cHklOP6LGwZFHcCuAZTrYvZ1bvCDf+hPxnSdcVXGKAFYIVn1R12JARWR05yeZIP4SfbcOvx+iJeI7XOwtRLLoB5xqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Tue, 15 Apr
 2025 23:23:54 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 23:23:54 +0000
Date: Tue, 15 Apr 2025 16:23:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 00/14] cxl: Address translation support, part 1:
 Cleanups and refactoring
Message-ID: <Z_7qhcoDwIz2GJW4@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-1-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:303:83::11) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS0PR11MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a34aedd-081f-4c79-7488-08dd7c749645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?egqD+hea4h4dMt4yJV4thnPlberbPkQ1eH10FOw6H9Uh3sMybNraRoNrMjfz?=
 =?us-ascii?Q?fsc8RKf+NDpxciEcDw6IcUZMheaozVUqr3wg8gDLSr1AqWQQEeHlcp7ncSXk?=
 =?us-ascii?Q?CmkfBflzNEECDk057aGzbgh/0qBA4ZRkepsyKtQjBWIDHw7heT/R3SekZvVa?=
 =?us-ascii?Q?zDHcoE1MvnjJ/1j9ucawCkejvKGbfLQcINszJqMxc3AWxZhmw0z8by0GCCBh?=
 =?us-ascii?Q?oTTR7LAXq+Lccn2SSkOXUzumZneeJnhpvQT7W8LDL0/HsRwMK/D8LB4gR3jF?=
 =?us-ascii?Q?Rj/t5HYmJE+mGj0nOxnanMybjfgBLY5QfQQrNv9pQ/RbMQte7jVMr2Hk26NB?=
 =?us-ascii?Q?4TTYnVzBbGpe+8GeHlNtXRuikYrSq2WxXjxGsm1TLERpC9jb5UtiRxUSkC9m?=
 =?us-ascii?Q?lKsqI0lu7meibgQ9ZifvlKctXHDbgORloEkyayViGHOrDzENvKk7enzSwWcS?=
 =?us-ascii?Q?2Lc3hMZhXZnHvtU2Q9eHx0Otct+0w0tmV0+AKGoiHHMzce4WAEjHWpJcHeRZ?=
 =?us-ascii?Q?n2VfYdkoFDWwJ/mTLrKxfZ40g2TU15OufN7OEW9dheJSZpGiiuhZLxNHfwqM?=
 =?us-ascii?Q?P0mfaiZKirBUsH2DXcJ4rHsjhpe+9dM7TGn6CJ6kQZFtJrvNXx04Ag6phM7/?=
 =?us-ascii?Q?3w83pTTxJZY/qSXWANkmBtd3L3nB02E0XK/pVd/HhXXGrU3dQt1qf+ENib6g?=
 =?us-ascii?Q?5tOrxKe/0bo173XpbQwK++LisY0OTb8j/aPLtpsfhYd+EFJzxJAb8kzUm4qu?=
 =?us-ascii?Q?q7FHniW55P8xU1E6rF2ofE23U9NOLdyh8IfeMNjQmBa6XerZiWg29fWaEUXy?=
 =?us-ascii?Q?MKFtiQowUInxhTRBWrqqkXO358NbBiKwDBs4uBF/mSqFkP5qguYfc6kZxEiJ?=
 =?us-ascii?Q?yBraxFAWSFmtyaiZbwRbTWP39gKmpbpxrwKK4i72KuvcwcHPtUCz1O8e+5ds?=
 =?us-ascii?Q?8JKQp2ZLiyeKgIUeKZOhtA5RRwrnkEI3btrBGZD458in+0t4SoiH3pSaCY9s?=
 =?us-ascii?Q?iQF664p+FgPHJh2bwdBiO2UbpXGdvM3M1UnUuDFH51QxUIcqXSjX17mYwpdx?=
 =?us-ascii?Q?VIlZ1C2Bj6oyJLEZlEpua2yk46l2ZalAeleyurdG8etTVlfWF0fdGos9cCnj?=
 =?us-ascii?Q?eRE3NmpnvE8B7ZYzJxh2rFhcS3JJXK6v9YNTEh9PnKeGB7znSiUGDeyEbzJi?=
 =?us-ascii?Q?FqtFkphmz58Q8HB2ysRd9+7d/UWYuGSjKklerNErZ0yQnmlL+1VzguqpbNxg?=
 =?us-ascii?Q?Iw8acYHRQ66IAoqjnpeQQcAEM459iaO97yI4UQm2l4+8sBFZn/PhpUX5JS5b?=
 =?us-ascii?Q?c4f0FVw9IGvU1ruk4tAsP9ZT8V9p6QqGJjkvTc5RzN6Q6Hiq8Jn8KcjJ6WxI?=
 =?us-ascii?Q?GD7arDZvQy688zD8ZDMCgtMFyPrCGzxMiD1UjhGSTyf8oIrIXq8wIjowMAgr?=
 =?us-ascii?Q?yWxBkwi0P7o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QvYO7Fh3W5t25jde+F5E+7xSc+L8VvYjK3yKDG2yKdH05gylyVgj3nn/S8O9?=
 =?us-ascii?Q?hEGFTSKxOKVDk56Lb6+3TSD42qiulpNfx4PVYS+dU/TAuwmjz5Qn5+Fqrjda?=
 =?us-ascii?Q?4s3j0JIEuUu9yJm3sTo6iS1MW+qSfs0J7JzoxkwozgBxnAEQG13SiMCdqJV0?=
 =?us-ascii?Q?QSdEQ3l/XnC1hClINDHc9n4bQQes5e7WfEVlTBL/sTagiZQkX20cvGi6h7Fr?=
 =?us-ascii?Q?VXpmUPJIvWn3/dbO9P+mN8sz9JaHhPH1iZH3yO9X3GjCsgJ5zVqpWl6LMU9M?=
 =?us-ascii?Q?rpEFlMMwZFkA0UGwnT5xXHmd/TJrWgd38V2+5iJxOyWut8SrY8AXoJtUwJOL?=
 =?us-ascii?Q?q5i5+J9Iyvs7lNH8DrRdZNnU3SuPFRaBd86HesmlkcTyuR+RgxVbdp+hgn+s?=
 =?us-ascii?Q?3fL5W0Ltr9RbuaVrgKYeHSBFPM6Ho2eIF9EZGlO6423p6eD5bM/s6f8yffro?=
 =?us-ascii?Q?UlK7aURQVR7H9jFVlLiB6eIYwvtNp/VpwHSVIQwtiN0HpbdJaEY0AZKYwaAD?=
 =?us-ascii?Q?2psflprU8ngsgORuwiTYhYQZG2AajfXz/taHg3jL5VJ36uj3zRcREopEuFVA?=
 =?us-ascii?Q?bxng0+hKU3XVrgwuZGspE9qyAJuRCmS78cAlNGiwRm9Ee/n2JVx8ZNse91aV?=
 =?us-ascii?Q?lIpF9Vt2c9Jqjk5Rw1B10b2m1BQvmHVZCOKWjKkhUTWIzoYfDihVuQzrFzTy?=
 =?us-ascii?Q?b4wBWZj26eeShVpRYg1SBBJRuHF5f80M2AkvFkPorKmp+ArdOTen7ZhYS+u1?=
 =?us-ascii?Q?2kWIhtNGX2qNDR//yQ07Nv8MitKyX7o7//GTUPIRvgTScMco72eMfLMgrKvr?=
 =?us-ascii?Q?sh2Df7odte4uHFSxNVagcPKOKrlVREIMBXbWYUZh8viJo9Es5fcTGbw+jRnn?=
 =?us-ascii?Q?bEKp+r8GriaJ83IpGIECL30zsdRjWIfZlT6wOf7jHdTjJH8/MvrBRmCyaiJB?=
 =?us-ascii?Q?Gc9kIbEY5AX9HvmUp6MD30W+ZZlFVsIToXE5otPY1jjb0A+XAgiXTLchMlUN?=
 =?us-ascii?Q?+8LtP27X4vC/66rwxRmATqGbpBc8/wfhkJ1W+TPgw/67rQ/yTleytVTGgyUt?=
 =?us-ascii?Q?7IwbZGRfTWchtSLCirxMNpe0kJoi8rF6vSCGtiALMeFItxk1aq0c2z23jTR4?=
 =?us-ascii?Q?HnQecavgs6NJIUNcqqJnQ/2FplgbiOwrGyPH0R+Hi54h4GAJeCOF9ty3L+OD?=
 =?us-ascii?Q?VcA8gcyy29VzSmuxWKhOa0mkeAKps07an5nbOSy7uNzjNm5NnRQhmAm04RNv?=
 =?us-ascii?Q?kTy6xkZu1ioEjoe8qQeke7ANrBS4JyOGCCWJ5yhX6mXijNgXmScWz0qrlr+9?=
 =?us-ascii?Q?iBbFk5ti6fqITFIyuTNF9AQxhYCJ2FAjknC51sVa4yg4KeouFEQtMIaW65R9?=
 =?us-ascii?Q?AedbbBilSt6gHwynSKudMjgGqacua78tm7PTLD7ZocwhjcOlkXwRHOKzy/yJ?=
 =?us-ascii?Q?wlYJGqWYmVX5MbAbGjKULIdgI2t7O4QVPr8uoDyMW14QlRl+amG1or5n/9j2?=
 =?us-ascii?Q?7QpVSHWRraBaB9iKet/d1XUB7mw2IjOUW+zkqtEqEpNBwecv8yk6TlZq3kNA?=
 =?us-ascii?Q?EXTxX1K9zu2a1J7N2dMje/3GJQdfghVqGm8fxFIvmqdGr7e7YgQJVy9WiaN3?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a34aedd-081f-4c79-7488-08dd7c749645
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:23:53.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FMmFN/8CbRTfFVTjUHZxIE/oHRhxCYRfF6RVLjgUOk7VZIdPjVV6BgmhI09/jBBj6A5G5TEv46V4SSGpMzaIGOp5Vq/WN/PKeM7pUaqh8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:34PM +0100, Robert Richter wrote:
> This series is the first part of adding support for CXL address
> translation. It contains cleanup and code refactoring in preparation
> of the actual implementation that will be sent in part 2. Cleanup and
> code refactoring have been split in a separate series to reduce the
> number of patches of the series. Even without address translation on
> top this rework improves esp. the region code, cleans it up,
> simplifies it and adds debugging messages to better analyze region
> creation failures:
> 
> Content of patches:
> 
>  * Patches 1: Remove else after return.
> 
>  * Patches 2-3: Cleanups and comments around cxl_hdm_decode_init().
> 
>  * Patches 4, 5: Adding and modifying helper functions.
> 
>  * Patches 6-10: Refactoring of endpoint decoder setup.
> 
>  * Patches 11-14: Adding and modifying debug messages.
> 

Hi Robert, 

cross-post from Discord here:

@Robert Richter @Dave Jiang (Intel)  I sync'd my work on top of Roberts
v4 Part One, and then walked thru and tagged most of the 14 patch set.
Can a bunch of those go onto cxl/next now?  I saw 'hard' no's on 5,6,10
and a couple of maybes 2,3,9 but even if you omit all those, we could
get 8 patches simmering on cxl/next now.

In the collab sync you mentioned working this set. After using and
reviewing today, and seeing I'm not the first person to suggest this,
I think we would benefit from merging part of this set while you 
refine the rest.

I believe they all have plenty of tags, so it's based on what you are
willing to let fly!

-- Alison


> v4:
>  * rebased onto cxl/next, commit 0a14566be090 ("cxl/Documentation:
>    Remove 'mixed' from sysfs mode doc"),
>  * added tags to SOB chain,
>  * reworked comments in cxl_hdm_decode_init() (dropped moving comment
>    and updated patch that modifies comments) (Jonathan),
>  * reworded patch description that removes duplicate call of
>    cxl_find_decoder_early() (Jonathan),
>  * moved some patches out of this rework and cleanup series (Dave,
>    Jonathan),
> 
> v3:
>  * added tags to SOB chain,
>  * fixed NULL pointer dereference in cxl_find_root_decoder() (Alison),
>  * updated subject line of patches that add kernel messages and
>    included example log messages (Alison),
> 
> v2:
>  * rebased onto cxl/next,
>  * added tags to SOB chain,
>  * move patches with cleanups and refactoring into this separate
>    series (Dave),
>  * added patch "cxl/acpi: Unify CFMWS memory log messages with SRAT
>    messages" to improve CFMWS log messages,
>  * renamed endpoint decoder functions to cxl_endpoint_decoder_*() (Li),
>  * reworded patch description that moves find_cxl_root() and reworks
>    cxl_find_root_decoder() (Terry),
>  * small changes to cxl_find_root_decoder()/
>    cxl_endpoint_decoder_initialize() (Jonanthan),
>  * updated comment in cxl_port_find_switch_decoder() (Ben),
>  * cxl_endpoint_decoder_initialize(): Simplify variable declaration
>    (Jonathan, Ben),
>  * cxl_find_decoder_early(): Added comment on function usage (Gregory),
>  * reordered patches and reworded some of the subject for a better
>    structure.
> 
> Robert Richter (14):
>   cxl: Remove else after return
>   cxl/pci: Moving code in cxl_hdm_decode_init()
>   cxl/pci: Add comments to cxl_hdm_decode_init()
>   cxl: Introduce parent_port_of() helper
>   cxl/region: Rename function to cxl_find_decoder_early()
>   cxl/region: Avoid duplicate call of cxl_find_decoder_early()
>   cxl/region: Move find_cxl_root() to cxl_add_to_region()
>   cxl/region: Factor out code to find the root decoder
>   cxl/region: Factor out code to find a root decoder's region
>   cxl/region: Add function to find a port's switch decoder by range
>   cxl/region: Add a dev_warn() on registration failure
>   cxl/region: Add a dev_err() on missing target list entries
>   cxl: Add a dev_dbg() when a decoder was added to a port
>   cxl/acpi: Unify CFMWS memory log messages with SRAT messages
> 
>  drivers/cxl/acpi.c        |  12 ++-
>  drivers/cxl/core/cdat.c   |   2 +-
>  drivers/cxl/core/hdm.c    |   3 +-
>  drivers/cxl/core/pci.c    |  50 +++++++----
>  drivers/cxl/core/port.c   |  15 ++--
>  drivers/cxl/core/region.c | 170 +++++++++++++++++++++++++-------------
>  drivers/cxl/cxl.h         |   7 +-
>  drivers/cxl/port.c        |  15 +---
>  8 files changed, 172 insertions(+), 102 deletions(-)
> 
> 
> base-commit: 0a14566be090ca51a32ebdd8a8e21678062dac08
> -- 
> 2.39.5
> 
