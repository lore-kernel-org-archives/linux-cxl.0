Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208A27146C
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631472; cv=fail; b=u8R0GLyf9X+YxUKOBv6XvbZa1DeTtedn38STS07oz55pbqg1LysmFmW24dYEXwigxz57t8WG6mo/14MhlFUVQFo60PeHflEURI7NPn0otP2lkpymxVg46Aw+fV8WFapvgRSn4rvZs02dH1lvpRip0RiuvKJDP6LbbAewGcrL6Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631472; c=relaxed/simple;
	bh=LxI2Cq9yKtt/G3Pfem9Yq5Cawkwoe/NP6PMt6fLRlJU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EqucRQHXxe5CwgREYXM6m7PBB5b/ttMrFcARnEC0nSL9IswvOUoV4mVDxNYR/PF+C3G2ByiN5SfyPiSpCAe5mMt/ReDoojqaxjk/2iXub4/nPH1pIWahuJTeXDYJTeLE+HjykxdRe75IF8YmaM8YW0W8OSTSOIEhQlKsS41uO2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPgWpIpU; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPgWpIpU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631471; x=1784167471;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LxI2Cq9yKtt/G3Pfem9Yq5Cawkwoe/NP6PMt6fLRlJU=;
  b=EPgWpIpU6ZcqKNxWMTBIf4nG3twkrTRCvqzpl+XHjFziuiRu1EDSyTpN
   J3NsZ5TSF8uQdpvHaVh2R4t061f8s/wjq0dplNd6KydiHze9RpDREwxQC
   GJjsjII9IAE4jIjHTG3km1POisxTOstMm4aJm3cOGUYvmVhiQofU8e3m/
   a5q14LrI8CvtGAaec522i+E4EUHhB3RZam8imGa47yMnBY66cuxjEZtNh
   eUlbcg+WWYiTn/Jz42MPB9xxdtX+AQLZReKSFsXS3Fk9Q+LrK9M5oaFkz
   BBxgeyEPoM75fiqgWk5Gxqg5Wl7As3CGNVxVno+dQ6V54nPL+c3p3ZMwb
   A==;
X-CSE-ConnectionGUID: SzmMIyAWQByMFki/xp07GA==
X-CSE-MsgGUID: EbDsAYrzTtuxNsu8ITdG1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54839139"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54839139"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:04:29 -0700
X-CSE-ConnectionGUID: 4RQb90CsQvSmPg/gMtcqkQ==
X-CSE-MsgGUID: QvV70TX4RxKGUObgDb5i9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="181061573"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:04:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:04:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 19:04:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 19:04:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mq9TJ5sgSe2J9jw+IC/Ir3XYo/ayf0/74fI1CgbDMsSg4/qiCd+nP29Vo/NrznobFknbij/MW8/ocQhmc7QowrveLg0qhOtrEnxXgrN+la7fLgw7vhDm3UPCM0a05zvcX19PsDH30qY38oBjF19o8KISI7sNtzpfjEQNLi5rwio6/lRgGtGIIsRWQeMFUVOndDueL/sz29F+x4v7DbyEpgv+rqnIJH4sAxTwM7v6W//+cc+/zS/k7NBRF4N2gtFpA0wBcVqk4n5ESb6a+knDtJzx2ePUdXp44pi92l2y8WZo/JCJXOTxv29iNitJcaPdHTpcpCaj1iAXhqMojv4+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrxiwIxl3ntZYGWIl+bMqvNwFaCjf1IrzdSPSB8dIzQ=;
 b=mwXo9CpTd8pJpABtmesFgNll2kYQWJrNiyn+O+pUXULBFI40cxldzLM53YZS9YITwbXCLV4sZN6/Udt9UVsBjkvr8FPl8lxCqm0HNDvCuQl37aG/OvYh0zOI877daBY17AP78/3dbACv9/U89tlpbTiQ2XypkOF++ZzXsTS+f2TUgK0hQHjYxMoB8h+ARU15bjgVgfW1qWYArz0aa8zOssP0ke9Ce0sQoB7TetdjoD4r8lOj/ESXmKQOPlWo1vO7tSyJFTFWDTkuKJlAX6K447iaJ07A3ajQh+h+dEAG8dX97tJokPluR6Y05DF+5KrGHXB7ch7B656Sk23XUvllyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA3PR11MB9087.namprd11.prod.outlook.com (2603:10b6:208:57f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 16 Jul
 2025 02:04:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 16 Jul 2025
 02:04:18 +0000
Date: Tue, 15 Jul 2025 19:04:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v7 06/10] cxl/test: Add mock version of
 devm_cxl_add_dport_by_dev()
Message-ID: <aHcInuWRLg9dcNqu@aschofie-mobl2.lan>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-7-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-7-dave.jiang@intel.com>
X-ClientProxiedBy: BY5PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:180::37) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA3PR11MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d716dd-6723-4140-6102-08ddc40d1264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?35sViPZPsey7AbbLG72GbHCigtCC1kCss9UEmxtLHECThU8A6H4FYKJI5Koo?=
 =?us-ascii?Q?UqaVuvfewr8plA/7frcbGYDj/qWUjWige4bps/qG/rMiI2NLojdRXIFnn7tH?=
 =?us-ascii?Q?ysbKTWYUoIghLBlnK3wSJBrTQYCPnmwJTxCsJBwvF0L3Bj7F1zMIUoda8Epq?=
 =?us-ascii?Q?MLD7U/+qgO/vSgIv3z6tqXen1gVyz67h/GGjz/tyiqRLqRHU77m86JPyzCr8?=
 =?us-ascii?Q?S7d3G/RtthJpXXxWhjHcnRrqTGx+WLx/CUaLFsS4xD8+XPRZ+ttM3kI13j1g?=
 =?us-ascii?Q?6kLVKOFKUc/Yd96F3jIaYKCj3jWre52AhcBVhlM3WfZPca3RIR9kl/IKS/zp?=
 =?us-ascii?Q?ubtN8ak9Jx0m84jnjNBFZvtBj98CF/jH/s63CYU+eXwIf0h5zHUtF7ajevJb?=
 =?us-ascii?Q?uUBAZzujv0cq5gGZOznMrECaQsqmvpoDY4DoBSBj1EuwoaL5Mnnh2B7fOa52?=
 =?us-ascii?Q?Ge5WdFhmdXvQqgFeHv/MHMGKRV2eJNcusO5Ofx96lwZphxs8p0Kqk3EOfQhg?=
 =?us-ascii?Q?v5jCHsBH2Whwl59ehWaBOO+kyYCCV3ixXPW5Q4txMX9SStobPORKeDprdK+r?=
 =?us-ascii?Q?LDe9pNrRZMTjpV7S5XuJzoVbiWqXnPh8szbQFUi4k4TRsbuqSUIdvpmKlVIw?=
 =?us-ascii?Q?kImdU4lIOFz+S4gy5lQNB2A8E6gB9KyJCUr8LfwTAmwvMz+ufG2q0+25cNID?=
 =?us-ascii?Q?PG/rZeUUcHkYeRamvqWYMcsNK4oPYgtESTVwFMMBi2sVwTNClIhRraFBfnz6?=
 =?us-ascii?Q?A2f+S2loTPDGFr6Mxxr7lrwyvIzF6f3ptegkDHaKmDJ800+DjHuqCT8stEEj?=
 =?us-ascii?Q?lF4fmCAQy4/RyRJayM6A2HPr1BZK2FA+amGpjrQqI9Xo0E6PtpX87682awd5?=
 =?us-ascii?Q?7MQLrHuogoxZ0bRSVwO9yaHBXhJJ8idnpn5EoQZnyYdvvGx+5jry7LZ/TxIA?=
 =?us-ascii?Q?klnj3coY6Gi65hl8Hj7D9ZJZrKwoJN2osDDreBoAXALrmD18TnAdK2J1EU1I?=
 =?us-ascii?Q?QCWmYdbK0c9fSWoeTj/BSZ5GMULOGvmV2GuOrwXtJLCpmzfkGsswClOMBqCU?=
 =?us-ascii?Q?Nq22yALARaswDNH1oOGulLD7LMKKIP4uUifBWGdEMHm9hSh/QYLPEgiSeva8?=
 =?us-ascii?Q?yfwAvYwGEcqfmkCZZpD27F/bbsn5M7Hd3Udql09uL1YjkpC42tl32i6ffPb/?=
 =?us-ascii?Q?oWKXtGsecF9NmMD8KkM7XlDqksT0+3T8g3c3JsxmkQhH8kiZvy9DESgfFnrn?=
 =?us-ascii?Q?wxaTVtOxuQrOLJyZpiyUqI03FHb82NCc6ppoIfvEU7HuV9BRsJ1r1QuNNiAo?=
 =?us-ascii?Q?3VuXHIDLAvSSwaCn6ea2ko2xQNR7lEUbUJClOdIOBP05CB2h+QzvukDUC/sK?=
 =?us-ascii?Q?1pBFh+Lib9VCxYqFAZR8TYVvDMFthEeXyVMwZn2BVeikD0t2KNq2vcDYn3T5?=
 =?us-ascii?Q?W6KHEq+Hz1E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A+qpyAAgBQw9tlshMdfkWtUyBAv8rd472Cd9Jwz07CWKxty7lAOSGcnHWKOr?=
 =?us-ascii?Q?1E6b73Fs9cUc3IOrSRxHHazRr60CMlCQdZmQAHAIgJV9XILPDq6+LnG/8PbJ?=
 =?us-ascii?Q?nn80hofna3T519SD93rtX31ccDb1APSTJJk1nsZXmyyJLaMp67z7IZBnOKky?=
 =?us-ascii?Q?rswPzhfxumXtug2GKs9iE+cdBykW9RhDsg/BJ/jKJMXFozQTdzeLlYw7kjRJ?=
 =?us-ascii?Q?1rHoYgj8NtXn+3XtDcHJytHC/B+wsubiTcQSNWoSk6wSfL8BAYElkvGe9rE8?=
 =?us-ascii?Q?iM99Sg3SVIKuwX6Fa1oYjyY7r5uvURJ5RVvpxVDPk2LHy2bNdQqYEHuGY8tB?=
 =?us-ascii?Q?0bkN9MaOdd34AkcP48DKHHqHBCVFra99wbME+Oce6+A2ZyWTHIgOXDmau8vg?=
 =?us-ascii?Q?Ahluslp1KY24tqM7PoxO12f6wcvUk0IPxF5Cej6ACbUWR4QgnlomSceVYzgU?=
 =?us-ascii?Q?JU7cP84Q5bKBWDY7kSVelwvgP8oxrv3ZuLGEv1P+gidmLOxTWyuwyvMCXcuK?=
 =?us-ascii?Q?QFrCM6JKg3C3dLANCNERryIQpMOd4jMW68FG00ulF9ENrDyzwYVuRQzWlrmH?=
 =?us-ascii?Q?F8gS+nC/C5cIiR5MkpefnKSQGClG2kazL5FsAyTqaxCVUsJ9Sw8DKeFyCMGx?=
 =?us-ascii?Q?ugFxzKm7knywAK2ZApDIue23Rah+CHfC4XNvVHrMc9F6sMhndzD5KEkJrXhH?=
 =?us-ascii?Q?3ym77nrpVMgOVE5EGarKCKhbDO4c4aKN2+jkpQaWeLtp38brHqsg6cUxGw34?=
 =?us-ascii?Q?1ZWZ6c+o6FVXE3+Zyj4qQWGq20CEtJUgoIKc/3DPzA4itAPmegWqYrm+ISBu?=
 =?us-ascii?Q?UWnzeu6WAYO85C1KAGRAIwgkqUsRDnw/ABV9eripMCmqzayoIcSOCbxtdPhS?=
 =?us-ascii?Q?JOng0SP424BhIbOVW5OC0CeFhCemWh6JHjitaOFYmy3EiXoXr/twIsA6pFRL?=
 =?us-ascii?Q?AhBklyiKaT+PnrpiWqAMnlCJVCdn1plY9oLMMHNUsw6W0CmYMqTf9D4DNrsp?=
 =?us-ascii?Q?2wc4dz350uRKPZQF6sxrEViROCTptQ/3c8oXdV72fO9yHzmfp6nA/GMulXQy?=
 =?us-ascii?Q?uZ61GlPjp7Gf8H3ZAD57hFMkk8t4u3/amo18kPe103knSUjxHrf9Xvp53bKF?=
 =?us-ascii?Q?kUjGra1Hy5HUS1wyza1e1JEjMUnkoQLG4mzC/4tIvMqxpRnvIS9nLz6vtm6G?=
 =?us-ascii?Q?Z9D/CaaxX15EPmE1mK5AoL8tcBwMC6b3JKYEfB/f2S5QtDpmdqGO3yWxli46?=
 =?us-ascii?Q?yMWHvCc4bGDLykaieeF6k3/G1wuscGIS0M2sMAfjFxoZkH+vlNQyqLyXQNcB?=
 =?us-ascii?Q?oz3uWLyftMWdBq1zSpjMlIcrp3cnc6wk9o51nSeGQsAJoHhK4bcmhwI72YoN?=
 =?us-ascii?Q?a1q01tdWVOHvU3qbHQ4dhdsNiWRAl9DU/52MROUtiC8QFENBr/Q4IsG6Ilkc?=
 =?us-ascii?Q?cELzIlI/n4Yl5VXqeCAmSFN3YKRgzfhEDn/CzLybCZ5llR+8PcJYxBr8o6Cx?=
 =?us-ascii?Q?JQuw1a4z/ZkJ6rBS41Et9/e3ZHEw/jtyb2cx9lbaRmAFq3eMzpZ8PhW+PQB9?=
 =?us-ascii?Q?MNUZnUSa0nSq//pqURCP29EneaQZ1eI+gc0J2d7wNT8vwA/zW7Vww7qoj9WD?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d716dd-6723-4140-6102-08ddc40d1264
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:04:18.1623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2s3+aLS81FxKc7T/PdIFivIu7MUVxOfwdT9CDvo8J89nuRgFBMiwYp17yKrmGNQ205s51KYyt1QnQkwWETTPx+4nEOXQM6tQ9l2Kkv1Qvbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9087
X-OriginatorOrg: intel.com

On Mon, Jul 14, 2025 at 03:35:23PM -0700, Dave Jiang wrote:
> devm_cxl_add_dport_by_dev() outside of cxl_test is done through PCI
> hierarchy. However with cxl_test, it needs to be done through the
> platform device hierarchy. Add the mock function for
> devm_cxl_add_dport_by_dev().
> 
> When cxl_core calls a cxl_core exported function and that function is
> mocked by cxl_test, the call chain causes a circular dependency issue. Dan
> provided a workaround to avoid this issue. Apply the method to changes from
> the late dport allocation changes in order to enable cxl-test.
> 
> In cxl_core they are defined with "__" added in front of the function. A
> macro is used to define the original function names for when non-test
> version of the kernel is built. A bit of macros and typedefs are used to
> allow mocking of those functions in cxl_test.

This is a mock masterpiece!
Tested-by: Alison Schofield <alison.schofield@intel.com>

> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
