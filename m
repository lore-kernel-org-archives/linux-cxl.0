Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601110FB
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PepDi34g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EB710E
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698260844; x=1729796844;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zaJLIcLMtK8x+n9gXgEUnUjU19frTH2l3GG8Vn8WffA=;
  b=PepDi34gSQl955uSAkFZgEocXKhFz79tMfIe0QE19h9q5IeCtvklJfWM
   32VFDdH/DkwbXbTCSS6UqBrZiJMJ8Lanku1m4d4f0mSZAYxS9sR90pdgE
   qS94005aiOdVus7tU6ZfyJVH+Cd+qO5ZOKzalGqDNp4H5asN5prTm634A
   rhSi6Y69tQFoqh/aw2kE3yHJvXNpN4/WwSpH5feCNDt9BLgSbUu/RMMLC
   IMUc1QtqAyhERlufVjrA6HkTRROpLtjM1i3rxy3EuoQNkFVoJBMQ5og4r
   ls0gOTRhk99oe72FKxv3/jgqZqXBBJN7ANTcfuYcaK+mi1cZYmwVsaT6C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="5998381"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="5998381"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 12:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708788620"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="708788620"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 12:07:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 12:07:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 12:07:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 12:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp5gPVUW5dMrC/FQRsUUnfqc3OeP1Li6Dvc6xNBcyN3O0nMSkWgXm+dKg/qdn1MEjQvpxuhDiY1u3N4KvTVhQGCM5bzzqmsxPvJdqfdDNIc1e+x8Y0uCfLGZcTGzGuda6KOG63+oYr69bSewmYBkmggwO9a63hC/I3NKj6LBsbvArKav2IFkyGuyD4iR7+goq5gTkAKCa0tjgUDqtffi3Ggq0BIc6KFnK3UCQyW+cuklgKEx7MVyWd95yrOI5MtCQol3rEcDLhaGeedAhYilxzzZXE8utgFeWAcI62aRlRDMlwiFsZLD1M/kMR45dnwN9nBFKWDfR8L16Ih/89A7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8umJK7kMeLq4qiQ/CnDwZ0eBnYPIRtr0W2KABSe0LU=;
 b=mnxBVn3g9Cb/z8wvmpMA4BmKD6iooYkRi1WSQlG2KCWgWUP1EnmHlw9mMeyG2A7Ed0w9l5HrOnCWv9UDzzZwJl2zx39HCR+iWysB+4cVW/iWRe5p1RUxcGKyMuctwHHu9Zxr2Ad4H3y11jpQnBIqw/9tPFCzJcu5L1RpwX8WB1JSYFv4PA1q0c3lbafCBqDAVzYpoKPdHWdEA8IshGKowCwtJ8bJbchDjeKq2LweorqKIAlk9GRePUpxOrVVSNHqm0AXMJKvahSJYxWxLbASohZZWefTG7NSWlyzt955adUQ7KT5dMqILstPMZzTs8hs6qPy+rA0x75XYmH2MoE1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5499.namprd11.prod.outlook.com (2603:10b6:408:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 19:07:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 19:07:16 +0000
Date: Wed, 25 Oct 2023 12:07:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>,
	Jim Harris <jim.harris@samsung.com>
Subject: RE: [PATCH v3 3/3] cxl/region: Use cxl_calc_interleave_pos() for
 auto-discovery
Message-ID: <653967621243c_7258329474@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1698254338.git.alison.schofield@intel.com>
 <843f38822178791cfe7b49d53e143b69fabfa530.1698254338.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <843f38822178791cfe7b49d53e143b69fabfa530.1698254338.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:303:b8::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e5fa07-6a9b-4649-42e9-08dbd58d9a84
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYUm8KTriPRgaiidJ+lF0iDms7FhSu4DkFqmBaWSOya/dBHpJY79X7oqlAxQWdlVKZzKEAkODyRhJ/ns9Tcqi7Y8E5sQIFF/llE8ZBx4sWdEas4oEMinIB1UV+9/t+/MsSBftuZEqsWn8edESvSAuGtdZSykGzE25YayfcTZxWYEq+N42si7YgQ4Bv1tPmKnJQKMx4PwKl0Qpxphhpq0iMYJ6ZL8km3gEsN4LJH2mlyanQkM7T6SXVkveiaCsFlshVRlRhmXjLCQOmjMlCJNJSUnzCCsriXxda+ve6/zjAiic4J2qeJRlbwajwcsT+wD3oqDCAC3iUWES0iuJzniqFvjwGfwZ1y7YTTZp9Qh+o0uVVDt3rD4mGZwD8p/OGEkDOGFeNZ8q+vP5i/S12Pi/HdJxChaTp7cv+ZvXwGKMtd117IQL3VW9YML2nwFdgqjf5d9iwnJRZo0Zw1Z54E7dlkATDQINs1YrLE61r+lDctc39/q6HIcdiXbdisbgfru22J6w5hDBCPr73zoJJF8B0bagGo6bOPrKbJdnchgPqa1mM/EF/mVbq3gtssav53+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(6506007)(6512007)(9686003)(66476007)(66556008)(66946007)(110136005)(54906003)(316002)(86362001)(6486002)(26005)(82960400001)(38100700002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dks7PcFBxEnLIoZbzmfnUQYtG0R/4k+Gy5JyaARDLQ6d4Y9K0A6VEqy1bNWH?=
 =?us-ascii?Q?c12IlotxTXZDqkFszahuReQ6it5FLKlED2LlWRHT2TeUiAiC9YPgdegryEKC?=
 =?us-ascii?Q?WfEhH/f5p0g4UkYDdrMMYxy27GD2XqGaqlooNFblkfX9cZCVzl8H6Q7cwFFD?=
 =?us-ascii?Q?iWF/KH/EqvzY8MKs0KW3HFSzy5UblX2l3nxG9WyW7vusKvsU1Tj7hq/DjIYO?=
 =?us-ascii?Q?CiL3dJSW4nAtECo+6n8hioe/VujCbfIMAKo5XhpDUja1o9moEZYbkFWD/5qx?=
 =?us-ascii?Q?zIBTy8jwG4h/2Hv5DwSb/FcnjGpSMIepU4jJPCaq+DyC+nrvy2lMRB3DFwHf?=
 =?us-ascii?Q?fgyto+ErVVTdGNxgifrb6zkLbcqCPF2L7v9HMrFaBhpw4549jflnZYglCT5g?=
 =?us-ascii?Q?aQgl3/KHXEgcmHtSkm5JlSsrScRlll74eXIr93HbAyqZojp4gDcjG98QHWAO?=
 =?us-ascii?Q?uXpUI1dtcc6ZYjPdatqnMxHlYrcvRYHwNQgucbKdzEJBEpCU2Bq5vew9ZbmR?=
 =?us-ascii?Q?Odg97ftJtgGJzItV0KGZF/74c5fISiPmTtxU2deeCHQtjGWhgsKSM/WcYNqS?=
 =?us-ascii?Q?eBQYaw9dicFozTTYRnRIyGurmFFmn8jrG59AgZtBhQkvcToQN/Fb2oIZOgCe?=
 =?us-ascii?Q?FoFUjuLKXbcdDCBynUsCbN91WvH+CBlZX/MuISBSsVJ+DW0z3UuRbktBtFF3?=
 =?us-ascii?Q?eRsn7atDLBLeRejQDE2nG8NVUMLDkEbM+8VZVsG5g5RjKckvUi3lA46biCT5?=
 =?us-ascii?Q?NMyHblBmLSKaA0AazIINsDIsWaYbeSYYPBSHpJHweoaUcQYZSHX6W/heZwLv?=
 =?us-ascii?Q?PBX8SUYAmYucms3CyGykW9jzF9UOnwEhzYsfQ4EkGYB+1Mx2+MUr5Z8iOCTX?=
 =?us-ascii?Q?uEflqqTPgzOaNhm1AZqXDDrKPlwme0GhdhOBreyH9q+tJqlOnYpiYM6r7NM/?=
 =?us-ascii?Q?rp/OmIVcwLk8mHRd02PL1WD7A6p7SFpOkgYF68N7gB13YBBsXdmwzaJkaXbt?=
 =?us-ascii?Q?jjo3cgIx53UTtoCKHtQp8TO1d7Vr09ekAZFXJo4KiD6wqybllOmNDA4Axlzb?=
 =?us-ascii?Q?kLShHwiU/6cXNmlHX7wFdscwe/D57d2tdNZ99KwXMPMIWKJHqqLmv3//V5Mg?=
 =?us-ascii?Q?89tsMZaH3TrnqRG5rZE5t/5lq0fSruJVHF1BXMluX4kexEChi3ahEZvjJ3SB?=
 =?us-ascii?Q?AJRzcls1gsp0WOp8cIrerHMNcJ5I8dZcTOz4X2Cop9+cyUY166ihtBWQex9i?=
 =?us-ascii?Q?g5Rc4AuQExZbfh6wmSQptX8lhjGw7XGi7abavIphHzwpY5knDdTZkAqR8DUj?=
 =?us-ascii?Q?LrzJagNB4YgrK5B2UfTJ2ybtH4XJEkqk+SaJuCtN6XclFIR4ndHv7XYU18Vp?=
 =?us-ascii?Q?2OcZJYO80AeU4OvHe1Q9QqLlbgYmsRsw1I924IY2qSQ0CUmONh8eBJb7mJdL?=
 =?us-ascii?Q?x+LFySJaGuURPj+CEQd/u43Xj0Zp8obmX7L24W/SHg8afDo2jJuGxjtpGmVf?=
 =?us-ascii?Q?79mCc1hnNWVOplwhSZYGPMKf7Dc9wsBgMo26qF/mxZW6aXvZwIQEkEW+hCRE?=
 =?us-ascii?Q?j4hYjI5wSgiFIkPFXlvxDsnmFkCyotVz9+ajOSnUK23EdI9m/ptpgvi/aTz7?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e5fa07-6a9b-4649-42e9-08dbd58d9a84
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 19:07:16.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFfehm4cruZZGOFBFgPMVP9CdnMTrMj9uG2GaAO/RlNMTZfDv/BT3Mx7BurHbvWGeyx978MrhTY1RpfWBkJBtFTT9uFtXVGKlhjNnMUnSJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5499
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> For auto-discovered regions the driver must assign each target to
> a valid position in the region interleave set based on the decoder
> topology.
> 
> The current implementation fails to parse valid decode topologies,
> as it does not consider the child offset into a parent port. The sort
> put all targets of one port ahead of another port when an interleave
> was expected, causing the region assembly to fail.
> 
> Replace the existing relative sort with cxl_calc_interleave_pos() that
> finds the exact position in a region interleave for an endpoint based
> on a walk up the ancestral tree from endpoint to root decoder.
> 
> cxl_calc_interleave_pos() was introduced in a prior patch, so the work
> here is to use it in cxl_region_sort_targets().
> 
> Remove the obsoleted helper functions from the prior sort.
> 
> Testing passes on pre-production hardware with BIOS defined regions
> that natively trigger this autodiscovery path of the region driver.
> Testing passes a CXL unit test using the dev_dbg() calculation test
> (see cxl_region_attach()) across an expanded set of region configs:
> 1, 1, 1+1, 1+1+1, 2, 2+2, 2+2+2, 2+2+2+2, 4, 4+4, where each number
> represents the count of endpoints per host bridge.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jim Harris <jim.harris@samsung.com>

Looks good.
