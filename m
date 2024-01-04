Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D71EB21
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3/ybePU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704350250; x=1735886250;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=P+7GznAjQJQrsFQA8pOHnTfnZAqVgwG0E8SZCbt4K/c=;
  b=J3/ybePUUfI7dYHUfc44O0HG+RGNp3AKYfbtNgUdMrVk7+k9qCPgLM9/
   J5I5RNRzFSs9C8bqvER6rHuxdiGX2rOUA2xiwcTZik1R24Oc4dmO/VTcT
   zI92h9DjfQGD9RK93NjKMxD/TGTYuOUWBbOBNoVWkyrqLr0g2AWVd6GF+
   KZ3CssQBjyPsMAIWVPRSb2ZJydL80zREyeX4jnNQEJjJ7tk5a8+UqbJHj
   afwxjzZFFzeQub/WgSHfy+vJfPSr9f5BcBUqQf3mDjUjcDBGnm4lZvSAU
   OqPLdbpJFPY86bNRnVxYVXbpBzAvKjoQb/Pmn44v9gnB0Hz+5IAAzeJQS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="396017752"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="396017752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 22:37:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="809098718"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="809098718"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 22:37:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 22:37:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 22:37:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 22:37:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 22:37:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIGGRoXMVkpvszSxvUYrqNKBEUxPLEY5nMapdJHT63cao7moGEeN3mk799osE3JfOesDazBgN7/fsJjLFpDQdw6Z6frMlj16ufTcLL0zrNAtM6JLj1ZwFF77rCFnZruRNXDnHTVuddbXCRyeeZFq763pyjx9Y3Q5qJxsmTz9zhXrXjnaDU4rKsqNZ6R0kKOa25o3Xipa/RLsBUqVzRAKhLZ75bpcFIUfkyGxdnHlcmWnGvw4fFhoR9GzpJ3lN6SDo7HHsUibXFaNnJmwpqg8bzzOb3l4laINDcs6Rfby/D/ErRRbv5L0hktY4+qmaG9xjUG1mmjFX6UnFom/8ZE40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aBaRJi8gEG93lUWwbx0zb49NJGLgLhhwhoqQWqmG7o=;
 b=PBKvOwEhf42NZTbsRM4OQBs83andBqgIVE100Sv2g5gI6cqemKpxPD+LbVYDV4es3IgeChQA1c3Zj8D62DYNH6zuFthk4dVrNGhSTa8giJXnrjxVMJD85bLyk27aeEMG+Atr/pqYZXL+wzRgRpmEBQ4wXQhGrVVUCsYXjnZnI6B3romP6K49PWx30DsQ2hXBhkDNomLPFSWDM9RVGQnaMXNju4zXogjPr8UyY+GUUWarDWWL0Iac6UdlgGGm9vd4yl6LgpAghRRLUvSt8rsdhp4cGGJcgYACabG/xE9z/66HSZie6F/f5Th3oJ2mhFVSw1y+DF+A5cSGlY9qb3LoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4959.namprd11.prod.outlook.com (2603:10b6:a03:2de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 06:37:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 06:37:11 +0000
Date: Wed, 3 Jan 2024 22:37:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jim Harris <jim.harris@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH RFC] Add "uunit" unit testing framework for CXL code
Message-ID: <65965214f008e_8dc68294d0@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20231204193337uscas1p24b1959cf528b02b8172736a61807fff1@uscas1p2.samsung.com>
 <170171841563.162223.2230646078958595847.stgit@ubuntu>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170171841563.162223.2230646078958595847.stgit@ubuntu>
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f77e03e-f9cb-43b7-c1a3-08dc0cef94a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULe2QTw3rBRWmVCNdjVeagF79Aj9o7w9ElFrfIEy05yE1SKMxQEsJtm8scmqrosA5/3cJevIML7miJCN7XsUMCkJBsLvNuAo0WRojEr632WJim40SA9rst2JMqUJ+uiBNxaw0Ho720GRgXnwbrEk12QEam9/6Ltq6yIGjjOlt49h8Ov4nIyfIocpcjFYF1Y6q3D3sX/5VcNIYek2msNI7cUQeniEmtp1AC1ZziUKIclPN8nU6bbkd4ryA27peysX3GpWWlCL3XPkWo01sQB8x2K15FCCtUuCHQKuv4SwZhQbfCRnnTz6GU/w3hQPZt9vpU8TfjQ37ukDCm6JdUvkB6wqP/2Id3AshyYx2WOXQ0xRsCPFu79zColbLGb3GljzlKE3o5U7eckyt/zqLutwdbMdVC+I2o1+/qrR2KEL9K7ubTYn+37BQnIZJZ8ZHE257Ap/FtyTx2mRqANvZ2IkxeGy1D0dxRakL3+Wl4JrlMzj+9en7s0iWqx0JUbePl0DMquteH9h4CR0ddoShFzQPF3X/cgLwLV6A0JHhW7COmj/OPILNtRCTPexHz74QX+VcRI/q1XGPteFB79GP+QH3il26M/ULRkrqCqIyKkDH4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(8676002)(8936002)(30864003)(2906002)(41300700001)(45080400002)(478600001)(966005)(9686003)(6512007)(6506007)(26005)(83380400001)(316002)(110136005)(66946007)(66476007)(66556008)(82960400001)(86362001)(38100700002)(6486002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NCPN2wWl42YEKlLPo2NHgZNQjv8w0bhExwRF+AawhResfuo1yAFVfR7gTjUP?=
 =?us-ascii?Q?5HH2vyq+ezYR3J/fT1YEgpOwW6g+72v5zOHOwqfxNmTD6uYGrpADIZjDauHI?=
 =?us-ascii?Q?0IRixr51l08GUu3r3wffUpJE7MM9mhTEdcswvtgAKZni6zBq7WpJ7fUKopBr?=
 =?us-ascii?Q?gI2MM+c3latH4RNXUPzc/T57UfwUu3UMGK6wFb0OfZPMcoqce2F24sEAR/1h?=
 =?us-ascii?Q?w6BPJYSkaLwk6IcJKNZOc/NXImv5jHY6Qj5q0+p8fBevTET1p2XqOzxdCoE6?=
 =?us-ascii?Q?gJraqaAYnMxt5fZwsTLQu0hqb2svRDESsvdVuYyv2IjL8BxGbb3L+7Wi3zKD?=
 =?us-ascii?Q?SAQWs7InwOWPWeGwYs/q4O32g2yTIB7RUJQZ/lN8fPhQzaO4oQY5xSQVnpkk?=
 =?us-ascii?Q?FHotF2CtAuiZRFfcHbejwK7iqtcsfzBxvKYgkOpbsgDWw7uLNKQ4qFDot5vK?=
 =?us-ascii?Q?8qWZ1Sd6Tq7wcjj/XnRzF57v0nAibboARomo+dVa3jHR5WpqeqdDnTZbmbuA?=
 =?us-ascii?Q?C51160/DNPhdbcT/chUv8UC4VVlHaqDd/fSptQdK10BN57iR3pb2GxymzFRO?=
 =?us-ascii?Q?pgcwpqZsFg6Bw1ePZcFwYxvdDyjpwmVwSolzBj79GAbp/jNj9e8lrmOqUY8c?=
 =?us-ascii?Q?AxIegYSx1bSoQ2MNgi+c5BCMtky8wXfoyPNcIOFbK8PzRmtX6CpwgxGClQsO?=
 =?us-ascii?Q?ih9DL9hnsX+fsFUspzqlH+GHk2sWxHKIUNKC+3q4jeG7Ydy0owNly7mDwTTw?=
 =?us-ascii?Q?+Uxz5cfe7uSvYYz+2ELN36TY8LaVg3Q0du2YvxkJdpP2h0FkboYowRhi+hyh?=
 =?us-ascii?Q?vVRfuwQ/z+1pdOheLeocXHx5dyvL7L3YSBeSDqlrGBLcUoovfe4YXoFwvxSD?=
 =?us-ascii?Q?yskXuK9ZsGKH70bxrNHrFTvyLEyadXfP/uIc/Gdg0v6WwTNqCBQjvy6oCEw9?=
 =?us-ascii?Q?WXKzcirwPJfLxRhywMNKoYoX8Exe8bKNWPZQY1v+h2OqERrSuTUewh0w0wk+?=
 =?us-ascii?Q?GX/ZEcfUeYE8nP9ldqc1VTvsqccWaO0Phcuw74kBi/tGmtpN9VkCNtffXMhc?=
 =?us-ascii?Q?uSsqzMUdg+xbhFq8kH2NopLQ9nCVvRI1FIfTL0vsoU5c54HrY3Qfv07qU8oe?=
 =?us-ascii?Q?woAyTJzEd/Ypy7kxKyt5QmmtwxBfhJClagGlTEX/mK4FIaBd/r6ogST6hJgO?=
 =?us-ascii?Q?EAaGBLQlnuGvdrRF1VCiJcvhQv43m2TjA7lSjJCdIcFQiMdjaGfIYzmSrLb3?=
 =?us-ascii?Q?fzUiAkHs5PvQBE9WZgWT3oMZ90Kz6swT1JWoCh3WGtGWg8yt1xva4/IY9mVI?=
 =?us-ascii?Q?G+LuwaBx4pnPoBrdA1JvUkqVedc5QNXmrTqP0/U4Ej1ngP2+fgNl8VRonLN7?=
 =?us-ascii?Q?ZXH88d0RNmDvt84tSacVRFCcGYtpR0bO4vWwDuG9qedKvqXPYrwsB+DEezHi?=
 =?us-ascii?Q?VYTBDV9rBy1+1qR4LngnBt17kfOVC7RufVHN1W91gEhkbejlBgG0p982sNlv?=
 =?us-ascii?Q?HM1atAKGHVAZ0I3VAG6UYnwIbeUT5iEntYkRwpwAebzoeyvqhMTgtnEgO7wV?=
 =?us-ascii?Q?43QbJMeKyhALUwHwWLcg/SUi20wmOQn/+jQ6nxB8aoZFqo/FwoG4sWJzAMyV?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f77e03e-f9cb-43b7-c1a3-08dc0cef94a5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 06:37:11.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Hi+7M8lOyAFVpp0eGefBa/e8IoNzmjMIEk4SUZx0yoYUmmTdOAOCFytKciIS4vvwmxXfXNT5Qz6K9GelZNunK3ncEGOEtCr0+PPapu/CAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4959
X-OriginatorOrg: intel.com

Jim Harris wrote:
> uunit (userspace unit testing) generates wrappers for kernel source files
> which are compiled and linked with necessary function stubs and executed
> fully in userspace.
> 
> Existing unit testing frameworks (kunit, tools/testing/cxl) have some
> limitations that uunit alleviates:
> 
> * mock referenced functions without requiring modifications to those functions
> * mock register accesses
> * does not require execution in a running kernel
> * no restrictions currently on CONFIG parameters
>   (Note: some CXL code cannot run in UML with kunit due to dependencies on
>   CONFIG_SPARSEMEM)
> 
> This RFC contains some complex unit tests for core/region.c code, as well as
> a simple core/hdm.c test showing how register accesses can be mocked.
> 
> This RFC depends on CUnit, which needs to be installed on the system prior to build.
> 
> To build the unit tests:
> 
>   make -C tools/testing/cxl/uunit
> 
> To run the unit tests:
> 
>   make -C tools/testing/cxl/uunit runtests
> 
> There is a balance currently between creating stubs for referenced functions,
> versus just building and linking the referenced source files directly. For
> example, CXL uses xarray extensively, so we just build and link the xarray
> code directly into unit tests rather than creating stubs for xarray. See
> KERNEL_SRC in the Makefile for which kernel source files are directly built
> and linked in this manner.

Explain that balance a bit more, is it mainly just a "hey I want that
function, oh building that new file is going to take me hours to work
around a bunch of new dependencies, I'll just stub the one function I
need."?

> Stubs are in uunit/stub.c, and are grouped by the kernel source file containing
> the real definition. Those groups are listed in alphabetical order.
> 
> The build process has five primary steps:
> 
> Capture kernel build flags - use 'make -qp' to pull LINUXINCLUDE,
> KBUILD_CPPFLAGS, KBUILD_CFLAGS from the top-level kernel Makefile.

Did you look into stealing from tools/build/? I don't think it includes
those variables, but I suspect it includes some Makefile helpers that
are open coded. Reusing tools/build/ likely helps with selling others on
this uunit approach.

> 
> Create unit test build environment - remove thunking, fentry and
> stack-protector options from the kernel build flags. Also provide
> KBUILD_XXX strings.
> 
> Modified headers - some kernel headers require modification - don't
> modify them inline though, create a copy in the uunit/build directory,
> modify them, and set the include directories so that the build will
> pick up the modified copy first. Explanations for the modified headers
> are in the Makefile.
> 
> Wrap and build kernel source - kernel defines many functions that are
> also in libc. Kernel also defines some data structures with same name
> as /usr/include data structures. So we wrap all kernel source files
> with uunit/include/pre.h and uunit/include/post.h to do some
> pre-processor magic to eliminate these conflicts.

How much of an ongoing maintenance burden do you expect this to be? I
guess it all depends on how fast moving those headers are, but I worry
about bitrot unless we can get this into some automated environment that
notices that new changes heading into linux-next are breaking the uunit
build.

> Build unit test applications - found in uunit/app directory, and named

NIT is "app" idiomatic for CUnit? I would otherwise just call it the
"test" directory for where the test executables end up.

> like core_region_ut.c to associate with core/region.c. The test
> applications include the stub.c file directly - this will enable future
> use cases where stubs can be configured to return specific mocked values.
> 
> Note that this framework is not CXL-specific - it could be used to unit
> test a vast majority of other kernel code. Proposal is to just start
> with this framework in tools/testing/cxl to meet CXL-specific needs.

Certainly all the pre-work you have done to process kernel headers is
generally useful work for others that want to adopt this test approach.

The scaling challenge comes when there is disagreement about
stub-behavior across tests, right? Or would a test just override the
default stub?

> 
> Todos:
> 
> 1) Integrate with tools/testing/cxl Makefile

I am ok if this stands alone. As I mentioned above reusing tools/build/
is likely more important. tools/testing/cxl/ is building a kernel
module, tools/build/ is there to support userpace executables built out
of the tools/ directory.

> 2) Break out CXL stubs separately by source file. This will be required as
>    we start testing more and more CXL files and need to exclude stubs that
>    are defined in the source file under test.

You mean like in cases where one test wants one stub behavior and
another has wants a different one.

> 3) Build common library for building up parts of the CXL topology. For example,
>    see everything needed to set up ports, decoders, etc. to test the
>    region.c code. Much of this can be simplified in a way that various
>    topologies can be built without as much boilerplate code, not only for
>    region.c but other files as well.

Do you mean de-duplicating some of the logic in
cxl_port_setup_targets_test() and cxl_region_setup_targets_test()?

> 4) Improve cxl_region tests to cover error conditions and add extensive
>    comments explaining how the topology is being built. This overlaps with #3.

Some comments on the simple tests would help too just to get folks
ramped about what's going on.

> 
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---
>  tools/testing/cxl/uunit/Makefile             |  141 +++++++++++
>  tools/testing/cxl/uunit/app/core_hdm_ut.c    |   82 ++++++
>  tools/testing/cxl/uunit/app/core_region_ut.c |  237 ++++++++++++++++++
>  tools/testing/cxl/uunit/include/post.h       |   21 ++
>  tools/testing/cxl/uunit/include/pre.h        |   22 ++
>  tools/testing/cxl/uunit/stub.c               |  335 ++++++++++++++++++++++++++
>  6 files changed, 838 insertions(+)
>  create mode 100644 tools/testing/cxl/uunit/Makefile
>  create mode 100644 tools/testing/cxl/uunit/app/core_hdm_ut.c
>  create mode 100644 tools/testing/cxl/uunit/app/core_region_ut.c
>  create mode 100644 tools/testing/cxl/uunit/include/post.h
>  create mode 100644 tools/testing/cxl/uunit/include/pre.h
>  create mode 100644 tools/testing/cxl/uunit/stub.c

This overall looks promising, the tools/build/ question might be the
only consideration for merging in the near term.

Some inline comments below:

[..]
> diff --git a/tools/testing/cxl/uunit/app/core_hdm_ut.c b/tools/testing/cxl/uunit/app/core_hdm_ut.c
> new file mode 100644
> index 000000000000..cc2ff52d916c
> --- /dev/null
> +++ b/tools/testing/cxl/uunit/app/core_hdm_ut.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "pre.h"
> +#include "drivers/cxl/core/hdm.c"
> +#include "post.h"
> +#include "../stub.c"
> +
> +#include <CUnit/Basic.h>
> +#include <stdlib.h>
> +
> +static void
> +add_hdm_decoder_test(void)
> +{
> +	struct cxl_port port;
> +	struct cxl_decoder decoder;
> +	int targets[8];
> +
> +	CU_ASSERT(add_hdm_decoder(&port, &decoder, targets) == 0);

Likely wants some commentary on why it is ok to pass uninitialized stack
variables into add_hdm_decoder().

> +}
> +
> +static void
> +cxl_settle_decoders_test(void)
> +{
> +	struct cxl_hdm hdm;
> +	char _regs[0x200];
> +	void *regs = _regs;
> +	unsigned int msecs;
> +
> +	*(long *)&_regs[CXL_HDM_DECODER0_CTRL_OFFSET(0)] = CXL_HDM_DECODER0_CTRL_COMMITTED;
> +	*(long *)&_regs[CXL_HDM_DECODER0_CTRL_OFFSET(1)] = CXL_HDM_DECODER0_CTRL_COMMITTED;
> +	*(long *)&_regs[CXL_HDM_DECODER0_CTRL_OFFSET(2)] = 0;

Can this be made to look more like idiomatic kernel code? E.g.:

    writel(val, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(x))

...so that code sequences can be copied from the driver into the tests?

> +
> +	hdm.regs.hdm_decoder = regs;
> +
> +	/*
> +	 * With just one decoder, we should not see a delay, since all decoders report they
> +	 * are committed.
> +	 */
> +	hdm.decoder_count = 1;
> +	msecs = g_msecs;
> +	cxl_settle_decoders(&hdm);
> +	CU_ASSERT(g_msecs == msecs);
> +
> +	/*
> +	 * With two decoders, we should not see a delay, since all decoders report they
> +	 * are committed.
> +	 */
> +	hdm.decoder_count = 2;
> +	msecs = g_msecs;
> +	cxl_settle_decoders(&hdm);
> +	CU_ASSERT(g_msecs == msecs);
> +
> +	/*
> +	 * With three decoders, we should see a delay, since not all decoders report they
> +	 * are committed. Check that the delay is at least as big as the spec defined
> +	 * 10ms commit timeout (CXL 2.0 8.2.5.12.20)..
> +	 */
> +	hdm.decoder_count = 3;
> +	msecs = g_msecs;
> +	cxl_settle_decoders(&hdm);
> +	CU_ASSERT(g_msecs >= msecs + 10);
> +}
> +
> +int
> +main(int argc, char **argv)
> +{
> +	CU_pSuite suite = NULL;
> +	unsigned int num_failures;
> +
> +	CU_set_error_action(CUEA_ABORT);
> +	CU_initialize_registry();
> +
> +	suite = CU_add_suite("app_suite", NULL, NULL);
> +	CU_ADD_TEST(suite, add_hdm_decoder_test);
> +	CU_ADD_TEST(suite, cxl_settle_decoders_test);
> +
> +	CU_basic_set_mode(CU_BRM_VERBOSE);
> +	CU_basic_run_tests();
> +	num_failures = CU_get_number_of_failures();
> +	CU_cleanup_registry();
> +
> +	return num_failures;
> +}
> diff --git a/tools/testing/cxl/uunit/app/core_region_ut.c b/tools/testing/cxl/uunit/app/core_region_ut.c
> new file mode 100644
> index 000000000000..770ec200c87f
> --- /dev/null
> +++ b/tools/testing/cxl/uunit/app/core_region_ut.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "pre.h"
> +#include "drivers/cxl/core/region.c"
> +#include "post.h"
> +#include "../stub.c"
> +
> +#include <CUnit/Basic.h>
> +#include <stdlib.h>
> +
> +DECLARE_RWSEM(cxl_dpa_rwsem);

This is here because core_region_ut.c is not allowed to use stubs
core_hdm_ut.c?

> +
> +static void
> +uuid_show_test(void)
> +{
> +	struct cxl_region region = { .dev.type = &cxl_region_type };
> +	char buf[128];
> +
> +	region.mode = CXL_DECODER_RAM;
> +	CU_ASSERT(uuid_show(&region.dev, NULL, buf) == 1);
> +}
> +
> +static void
> +is_cxl_pmem_region_test(void)
> +{
> +	struct device dev;
> +
> +	dev.type = &cxl_pmem_region_type;
> +	CU_ASSERT(is_cxl_pmem_region(&dev) == true);
> +
> +	dev.type = &cxl_dax_region_type;
> +	CU_ASSERT(is_cxl_pmem_region(&dev) == false);
> +}
> +
> +const struct device_type dummy_region_type = {
> +	.name = "dummy"
> +};
> +
> +static void
> +is_dup_test(void)
> +{
> +	struct device dummy = { .type = &dummy_region_type };
> +	struct cxl_region region = { .dev.type = &cxl_region_type };
> +	uuid_t uuid = { 0 };
> +
> +	/* non-region devices should always return 0 */
> +	CU_ASSERT(is_dup(&dummy, NULL) == 0);
> +
> +	/*
> +	 * uuid matches, indicates the specified uuid duplicates
> +	 * the uuid for an existing region
> +	 * return -EBUSY
> +	 */
> +	CU_ASSERT(is_dup(&region.dev, &uuid) == -EBUSY);
> +
> +	/*
> +	 * uuid does not match
> +	 */
> +	uuid.b[0] = 1;
> +	CU_ASSERT(is_dup(&region.dev, &uuid) == 0);
> +}
> +
> +static void
> +interleave_ways_store_test(void)
> +{
> +	struct cxl_region *region = calloc(1, sizeof(*region));
> +	const char *str0 = "0";
> +	const char *str1 = "1";
> +	const char *str16 = "16";
> +	char buf[32];
> +	struct cxl_root_decoder *root_decoder = calloc(1, sizeof(*root_decoder));
> +
> +	region->dev.type = &cxl_region_type;
> +	region->dev.parent = &root_decoder->cxlsd.cxld.dev;
> +	root_decoder->cxlsd.cxld.interleave_ways = 1;
> +	region->params.interleave_ways = 0xFF;
> +
> +	CU_ASSERT(interleave_ways_store(&region->dev, NULL, str0, strlen(str0)) < 0);
> +	CU_ASSERT(region->params.interleave_ways == 0xFF);
> +
> +	CU_ASSERT(interleave_ways_store(&region->dev, NULL, str1, strlen(str1)) == strlen(str1));
> +	CU_ASSERT(region->params.interleave_ways == 1);
> +	/* interleave_ways_show appends a newline to the value string */
> +	CU_ASSERT(interleave_ways_show(&region->dev, NULL, buf) == strlen(str1) + 1);
> +	CU_ASSERT(strncmp(buf, str1, strlen(str1)) == 0);
> +
> +	region->params.interleave_ways = 0xFF;
> +	CU_ASSERT(interleave_ways_store(&region->dev, NULL, str16, strlen(str16)) == strlen(str16));
> +	CU_ASSERT(region->params.interleave_ways == 16);
> +	/* interleave_ways_show appends a newline to the value string */
> +	CU_ASSERT(interleave_ways_show(&region->dev, NULL, buf) == strlen(str16) + 1);
> +	CU_ASSERT(strncmp(buf, str16, strlen(str16)) == 0);
> +
> +	free(root_decoder);
> +	free(region);
> +}
> +
> +static void
> +cxl_port_setup_targets_test(void)
> +{
> +	struct cxl_port			port;
> +	struct cxl_region		region;
> +	struct cxl_endpoint_decoder	ep_decoder, ep_decoder2;
> +	struct cxl_port			ep_decoder_port, ep_decoder_port2;
> +	struct cxl_region_ref		region_ref;
> +	struct cxl_port			parent_port;
> +	struct cxl_switch_decoder	switch_decoder;
> +	struct cxl_root_decoder		root_decoder;
> +	struct resource			resource;
> +	struct cxl_memdev		memdev, memdev2;
> +	struct cxl_ep			ep, ep2;
> +	struct cxl_dport		dport;
> +
> +	ep_decoder.cxld.dev.parent = &ep_decoder_port.dev;
> +	ep_decoder.pos = 0;
> +	xa_init(&port.regions);
> +	radix_tree_init();
> +	CU_ASSERT(xa_insert(&port.regions, (unsigned long)&region, &region_ref, GFP_KERNEL) == 0);
> +	region_ref.nr_targets = 2;
> +	port.dev.parent = &parent_port.dev;
> +	region_ref.region = &region;
> +	region_ref.port = &port;
> +	region_ref.decoder = &switch_decoder.cxld;
> +	region.dev.parent = &root_decoder.cxlsd.cxld.dev;
> +	region.params.interleave_granularity = 256;
> +	root_decoder.cxlsd.cxld.interleave_ways = 2;
> +	switch_decoder.nr_targets = 2;
> +	resource.start = 0x1000000000;
> +	resource.end =   0x2000000000;

Spotted this just because of the recent debug adventure here:

http://lore.kernel.org/r/6595c10982cf_8dc6829433@dwillia2-xfh.jf.intel.com.notmuch

...where that resource.end should be the exclusive "end" of 0x1fffffffff

> +	region.params.res = &resource;
> +	region.params.nr_targets = 2;
> +	region.params.targets[0] = &ep_decoder;
> +	region.params.targets[1] = &ep_decoder2;
> +	ep_decoder_port.uport_dev = &memdev.dev;
> +	xa_init(&port.endpoints);
> +	ep.dport = &dport;
> +	CU_ASSERT(xa_insert(&port.endpoints, (unsigned long)&memdev, &ep, GFP_KERNEL) == 0);
> +	CU_ASSERT(cxl_port_setup_targets(&port, &region, &ep_decoder) == 0);
> +	CU_ASSERT(region_ref.nr_targets_set == 1);
> +	CU_ASSERT(switch_decoder.target[0] == &dport);
> +
> +	ep_decoder2.pos = 1;
> +	ep_decoder2.cxld.dev.parent = &ep_decoder_port2.dev;
> +	ep_decoder_port2.uport_dev = &memdev2.dev;
> +	ep2.dport = &dport;
> +	CU_ASSERT(xa_insert(&port.endpoints, (unsigned long)&memdev2, &ep2, GFP_KERNEL) == 0);
> +	CU_ASSERT(cxl_port_setup_targets(&port, &region, &ep_decoder2) == 0);
> +	CU_ASSERT(region_ref.nr_targets_set == 1);
> +	CU_ASSERT(switch_decoder.target[0] == &dport);
> +	CU_ASSERT(switch_decoder.target[1] == NULL);
> +}
> +
[..]
> diff --git a/tools/testing/cxl/uunit/include/post.h b/tools/testing/cxl/uunit/include/post.h
> new file mode 100644
> index 000000000000..231f5bc15c3a
> --- /dev/null
> +++ b/tools/testing/cxl/uunit/include/post.h
[..]
> diff --git a/tools/testing/cxl/uunit/include/pre.h b/tools/testing/cxl/uunit/include/pre.h
> new file mode 100644
> index 000000000000..1eb88e51740f
> --- /dev/null
> +++ b/tools/testing/cxl/uunit/include/pre.h

These last 2 files look like a lot of hard fought meticulous magic,
hence the question above about expected ongoing maintenance burden.

> diff --git a/tools/testing/cxl/uunit/stub.c b/tools/testing/cxl/uunit/stub.c
> new file mode 100644
> index 000000000000..208dab1e7d6d
> --- /dev/null
> +++ b/tools/testing/cxl/uunit/stub.c

It might be worthwhile to let clang-format do a once over on this and all
the other files if only to keep the automated coding-style bots from
tripping on these files.
