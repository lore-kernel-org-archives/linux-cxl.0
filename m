Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274EB10F2;
	Tue, 15 Apr 2025 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752740; cv=fail; b=Aj1L1pVtKV6yYzXjEexB6ElNZnLJetOTFNVsy53uLMr2XLr4dIyCbkCgt83eimHs2bImRW7cS2ZtSCq7an9sS+zuvmHj30hpVLspsWGkeZ9bYdWhRa5O3+ajbQjnYzQGgKBlb7ZXy+8KcSCOVUIqodfe4spGZSJvzRUca6E1A9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752740; c=relaxed/simple;
	bh=7qyX4waKAp9aTn8s6UYdx+eBj7isQMsfr1I3vsqMN+U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=epkOrY1l8ri8kqQZ18AL7ZGQYg64fBSXvz17L5tpQO04DAJG2sFxs1ruim/erIUE/xxnwlBQFD/OTEPXEwhNK9l3ezgWAT8R63I/nhkShtxCLhJxs2yES1YTcixy0XAxuJP/2vuF40kX5jmET2rqaK0tvvVbcIcphNoyp672Gl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrS2fxwu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrS2fxwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744752739; x=1776288739;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7qyX4waKAp9aTn8s6UYdx+eBj7isQMsfr1I3vsqMN+U=;
  b=RrS2fxwugkm8wz4H81l8+ONkKIaIzSP0cSkHZA5Eu/Qnpv+ddj+UtFBF
   sMokUiGWj+u2m/0gMwKL7I0pDlIjOb3putGz/PehdgBOqwf1y4SMj6zyP
   lIDdhVlVl/3HASJAOJgzkxw0Qk7Nn/VR1P/Be5VGnTkMpNNV+J2wWxnJy
   KI3oVsDdrR1bB4AUjoDuQ2euQWY5hqLSEeeuAv3BR5DBdZiNcL6fy3FJP
   PrsFUzf+Yk8C/jVguOhEIuCLTE7DY4tggTD+UC/n3dGZqH9028KkpH9hP
   7YR+5K21WrhPZN6tZUjRkrkFohoH+N32kqHvp4fQC/rARPt5+owlDHuOx
   A==;
X-CSE-ConnectionGUID: rgwTPU/+Q/KRlfCO+vHBwQ==
X-CSE-MsgGUID: 7tM8Ln8AS6mDFEBt+9qc1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="57668937"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="57668937"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:32:17 -0700
X-CSE-ConnectionGUID: e5U36qNDSQOFVGp11drr0g==
X-CSE-MsgGUID: 3qK1cIk2T6mPv/aUC0L1/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130197832"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:32:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:32:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:32:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNKn/XiArGUPQtkl72+Ib8MymQRBuZHHVVeQkiL1cpuR/l250yB+U0u9p+jTAbYmJDAYiXp45gyli5Vw1LnakTtRhpvZ22ttD1hzL4rVXVK5RRO4rGx5VnFH3GeZBcSBXyhv4t3c8gZ7k+6PgTy9vPDC9ffYzs7z67nH6T61yRGw8AgkglBswfih8OINkYCWE3mPilaCff2PC0entA6dgfH7DHUFDGPeLahZGiMSyXFhm5D1+FYgr7rs3YuvmhzV3FEsw3TiabOPNc27MJUvDQqxZZQhWp/zf1yTpIPL4tlPcSMGrnRCQp5HoZhE+m5HA9RrudIc2A8HWTCN9ys9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQJPL17ecUg6JXURkTnILzBeWLWpO6UdF2TnumYxtGw=;
 b=bwAyDA6cLFR/Z3dwkrME5JM61ve95uWypdc2dItXaxBEEjzEvp8ywu9sw+TKZ/bPe14+Jm6nip0c5lF6/ApIzu2tdCKatwbzABJ+QbIqfGgArnAzkyicdOdE0Uw2mkRb43s+QYeoY1X/M9XlgvWTJYgRRjEc+QH8v+/NXlT3yp/zua82vzB+j/23hthsoFlABf1HHxfNQSYrzqg2JIP1nxCTd2i3aifQx8muI/+f7urq4T4hHe4Xe78CYkKsIGpjqoqLwDqGnum1nnWXY4CTjjAEzN2MJL53/RabAikk2HmnRz5nLoRaEUVC94YQ2vC5jWIKwv+j53Oj6C5opYeLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS7PR11MB8827.namprd11.prod.outlook.com (2603:10b6:8:254::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:32:11 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:32:11 +0000
Date: Tue, 15 Apr 2025 14:32:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 07/14] cxl/region: Move find_cxl_root() to
 cxl_add_to_region()
Message-ID: <Z_7QVgS2GaZKEJgA@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-8-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-8-rrichter@amd.com>
X-ClientProxiedBy: MW2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:907:1::42) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS7PR11MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 806b6f8f-8438-4bd4-70b7-08dd7c64fb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jASIblmscv4PQ9cUsrhsvGaJT3O2x9hhAbMDIS+/2xi7emdUijCFSp3Ds2Vl?=
 =?us-ascii?Q?iyXq16786BFNZPeRWOdIU4tpCp52V24IlezA6SSkw5LiqJuOGQpEYo2zndYP?=
 =?us-ascii?Q?o+TmFGOWbKd/QxpvC6+TcQXOmVp338n4M068MgjwYAEdmyWcxfKUMAav4zDW?=
 =?us-ascii?Q?l74aas7RZ3QCc7nqp08pDZpgWkHx6WfEtobBunvvSliPA52eESayjvzJxLFe?=
 =?us-ascii?Q?qpZybokzTAAYi2LnInBJ+JjZ8maimFTIkglH0PcQmTa8w6OoSNryixO7zfdB?=
 =?us-ascii?Q?ftX818xS/ZC73h261QZypNFSjgDGgKF8+4oZREYjASZXDHb88z3l7ih/ySms?=
 =?us-ascii?Q?WLXW97FlDTgMZrU8l4tAWcRoQ0aNIrYGuKsHsirDr0YCa84/qQRij3164SDB?=
 =?us-ascii?Q?96AeQkA1eCaWip7jSCXE0XJwXaVaqp+z6vnZzKquEXgGq5iqE7ZTUO5HgYkY?=
 =?us-ascii?Q?TMiyHams+eN+ABv/5kqB5d61KT0VX/GRQMb7Orc4bBCWf65K8G2wCWuxIaYS?=
 =?us-ascii?Q?HtjrhtTdT/CLEyhcOcUeMviZ11ROyABqy2ErsVezkL7FM2jXeyAsAeGfKPNF?=
 =?us-ascii?Q?jmtPw1yMVTsmhldUt0HtUwuTPt1rI1pMAVfg1d8qVILLJpfGCHuDttJerZnL?=
 =?us-ascii?Q?4EdyimoXuWcZ3IprHlJmOKlG8mh+lUbv7e/gQepsGLBtrE/hld+J4tLSomDJ?=
 =?us-ascii?Q?n3DJLaFngM9bCZahD7zyoEbDLJnz6C4RRIsAjloy3Km99+YQiwX4KMxaF0bl?=
 =?us-ascii?Q?/j0RTt7cxoeQXOto+FgmhJP2WO5SNR/+Iyfo7j8UM50GGhz8fRP+cvOvv6Ms?=
 =?us-ascii?Q?jqBikIsh6zOhHkwkWPXROwoqAHP9OSA0kqVQy9O6EqPl9+xNoKfbvmeSI24+?=
 =?us-ascii?Q?ekbpSI7lH7E3BFQWpw+CaOG+pJt/5uKRIka0Kp+iD+gdUYyjbqKocNRKFL0O?=
 =?us-ascii?Q?kDXkvE1cAFv0IJsViUqyf0ThjguU4kY7u8u3LItwwsqlYahmP41I4WVOvhjE?=
 =?us-ascii?Q?S+imH6MAw1/wCpcjY3s09vLRmQ65GygLngm4g0OvF2AA5JEIROVDGsYevcUQ?=
 =?us-ascii?Q?P9fKPfPNKlCHVcLict02BncmqdpFiMtuQtn5abfKTwbl3D4hnSfxIsuqBBvr?=
 =?us-ascii?Q?BTyvyCFK9S3n1opwEwcJT0MoubCf5EimXpylBY2YNH3dyELxbMJkehxkv+MF?=
 =?us-ascii?Q?53iHWLtMX+iChl9ww7PiyA4DE1g0jknjsS+m7uaGYQDklrgN71ZTSnOxhO/p?=
 =?us-ascii?Q?eAV4X1+Roh1CwXxtmIU4t1brBQXjg8/gUhwU5AIjoairo4lqtbwlOBCyRZ6X?=
 =?us-ascii?Q?rLCJcGq4mXCNi0fZkHZGA5YxRB68WFr3fidwBY9ftw5aD6UQnAcpD38I2GY3?=
 =?us-ascii?Q?C+kN3FNqUn25xlDRoU2mL5seTygWOzlM1MLqmLioBA2+UNt4iaejXRZhWpGE?=
 =?us-ascii?Q?LlPXGfnfhHk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqdji86m98c5aruxLbXlnOPdp38gurltBjFJMYPi6cbWMC7E0dxcb4p9npmk?=
 =?us-ascii?Q?zWWPM5C09tjT7X6KxXnE+jj0uM50F+9DTo6bswPTEe+kMnYLqwDlDNYt/5F6?=
 =?us-ascii?Q?ZpKHmvnyFuclqbCcnLxqdDXBWoIl4VTjdWt/IA6Mbd2M7dp/xHIWFbaFjIZ8?=
 =?us-ascii?Q?6NnjHVEd+1yKbwDyopbJu0hZLkgBW971wd55u5jFcCTGEetKs0C+h22OxU+E?=
 =?us-ascii?Q?Reul09q9NLr7Jwk6WbzKtx0SplUTcSztwHDcLo9S8ypJKxXbmwNR2Nm6gFwy?=
 =?us-ascii?Q?nPUROx7MTKOkFufymUTh8xBtvhiMSTUaEhOpvpmlE0QnMwUoJ2rb7M5znk/o?=
 =?us-ascii?Q?xfbJaOrePtQFTqCESdhZI7+AEGv6rfCKKU9jyGsdrfYVTbDLv9bk0/AA+z5c?=
 =?us-ascii?Q?JRdIwlotzYF0UzDcS+5VxkufqD0v45AXiuTyOScwS0CW0MXx5lIGb665CG2t?=
 =?us-ascii?Q?7uaRhu4NpM9CfUSgurecj+dR/3tuTiVYW2+nk1wReoMSDtHIs9GlVt73m/2o?=
 =?us-ascii?Q?4Vdr4EpUVTdOPmr3r1Sf61d5I3ff+R1rJ4qMMDcRMnXekDrQQtFBFpiuTT+g?=
 =?us-ascii?Q?38xqTVLcXI5cS8ZwZzbMwZijDZ9v5JjctnIEs2pcqIXae0CsLI+5hxrryQvJ?=
 =?us-ascii?Q?VwBZioLVRMgC3aLafWS3OXXgyFM+zIAESYYHCt40pmhpHklFnsHnWqLcgeYi?=
 =?us-ascii?Q?6d8kh7+Pr+8tYdvoOW7INugCRgdN8Fq1H7m5HmdRy6JzXmqrzKgCEAX1SdBY?=
 =?us-ascii?Q?09113Fb1P4tKRwUdw2PYWUVe4nX+AQ1I86QscMFXSX+jlRy+6nGomF2VpTZi?=
 =?us-ascii?Q?IjtPIXg4e+sLRHTejsCjtsykMd7eg4+XlqeJ48xE9Ru7J5weJxB+2yLBj50s?=
 =?us-ascii?Q?HvLSXs2aXqwS33skxGWiCY67Fs4WaSE48NaTgdfDUn+aCv5qtgK4G7H2mBQZ?=
 =?us-ascii?Q?3FC4LtiVqVkrABkOXTN90ys1Qs3YRhTxOJcn1l/2ITUZJdQwQ7r1+1HF39PL?=
 =?us-ascii?Q?Rgc1ZCBAf3oygqS+4287lsYhDm6tWPN9RhKyMvchaqfgA+6VHLjl8DWrPrQN?=
 =?us-ascii?Q?JeWU7pPRESye9sUW1AvEt9ht4Racb3VcTTCmyLN7ernLWF3z2lldjAAY/nMI?=
 =?us-ascii?Q?YiNYZubP/BrALTn7hzVdp91o45RRKXyvI/iNt0NRan+Eg/9KHtPvGBDAei8q?=
 =?us-ascii?Q?tNkljEbPLOk9uFREsX3aZ8D+cjK0WbPm+AxL/GG5/fQNY9We+KXnAKwIeo/g?=
 =?us-ascii?Q?3MWosSokTvX7WaQS8i3zQLEQ2zfAbK6mif8ZIPVSMxJZ26PPfM8axs6gLwPE?=
 =?us-ascii?Q?ipRvgg5ac3s1gs9DecrFhIpuNCBEi8FOmACNiuZXVa70wLWjM3QDUWTxPlK9?=
 =?us-ascii?Q?0VcJurvUH8UzrnPCETMxazjKmJctiLzWcQ8F7TYdA3UQrWmsIK1NMFPQp99e?=
 =?us-ascii?Q?G/QS0oCq0r1cCozzodu+yXPoJMHsJAbv7CPTZCtn86HNzgeV1okJ0WCjhGow?=
 =?us-ascii?Q?5nCVoSJTmySgFykoFTa4dpR2iTpgUkSft78g0M8wk0s3WYyYnNJ6T+wdia4l?=
 =?us-ascii?Q?ltKXqR37eOUxO2WYZAnmpqzPmKrrfWJ20pjgUBGDv1q8u1P7T5XblRn18dTK?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 806b6f8f-8438-4bd4-70b7-08dd7c64fb13
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:32:11.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlaO+RJ1kePRRT3X2C9jPy34Z4IizF0DNYcm4jWz8+aeue29XaTnvW2j95noVvibJfNpP5IdWFkP+Oe5GhukQh7Kp08lKlVO9+MB0ANKpX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8827
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:41PM +0100, Robert Richter wrote:
> When adding an endpoint to a region, the root port is determined
> first. Move this directly into cxl_add_to_region(). This is in
> preparation of the initialization of endpoints that iterates the port
> hierarchy from the endpoint up to the root port.
> 
> As a side-effect the root argument is removed from the argument lists
> of cxl_add_to_region() and related functions. Now, the endpoint is the
> only parameter to add a region. This simplifies the function
> interface.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

