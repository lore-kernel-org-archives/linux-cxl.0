Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D61336AEA
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOwoZITz"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB6F1A5
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698435554; x=1729971554;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KZhJn9nrt5+oow8+aS6fEocz/u1hhXCdG9YrXFLvmAQ=;
  b=XOwoZITzrTYGGkz0pUlVbpc0HaPEH6cPfVgb7pyGzotm8uEjRQmbMS2R
   8UYXbLO1EQ5Mn5Drf7WnFkxqtQaw/PEJizKMwgiafN9b7GKhAIZSHX3ft
   3e1q9abB5rq8bx/m0b0jd74biPVq5m/RaqucERPVhlwDTGTD11T7TYPRJ
   AqxCHHfRtrdFqmVi4SVaFDHEaeWbchwa9x+vM3XYMVRumnZZcV7IIwP28
   Il4mJaU3qah+1tjpdAmhuwP6c93WnfTyKwNONJHfB6+AETiMiRP0NVq0Z
   LAAb3Z5xHuyinxvGoKgY1h0voVx+7kR1dcBCcZNtaqCuIj8bWIGiun3go
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="385047079"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="385047079"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 12:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="709502425"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="709502425"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 12:39:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 12:39:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 12:39:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 12:39:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQ/ax5eg6xxW20feMg0rKYo++vOCWUT26s5APyZjTeaEF4i3GpZ/Y5nCdMjQjlT7l2txZR7fapRUjMYgeYgQ5si24sO7QKQyM6dYWqv4lhJNDY3VOp5pB++T0vNyoU3Xwe8p12MZPZOmQusdKZDUM8/9HGyC1MOjXWndJOTCSh6iwlgr8a9MjnjiQV1Jk5DuT6x/SQuUXw5iEnYew2j5TYgPJz92iZ6NEeIENN6D1LJvmnrD442tjdqWF6BqHpFkZbjEkConRCDKRC852I8gAFpjouF+yrxpD0nlXgh4pfdBe2NjQI0Yr/f0ipJUp9rqihydsVsUw4fRwUWG7IW55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVMil/TYuu/QXCHePIJUiQAV9adoSfm7gjxTvcZ9v/A=;
 b=VM7k27JZEL8Jw1t5z8ZKf9KMFNGTp0A/PKpzx00N3sI6Sqz4EyBODVGrVPr0XH6T279yOeOl/CFhTXcEJlBISxRXcAsPHDsx7JW0PzVHNBBe1piJLrmapQCbt1K/Xs7KFJ0UMOmVXyknna7hut3kJRFqUJGm+3KJCYZn7vGNjmxCCWaqNRl6NXli+tDcg8GRZmfmeblXw/nHwTG4GHUXCBz6bjKiRcnxZOfh7Q0qDqoYooJ3mHTVJ40Bvpvbz/7iBRgjCUBjjfTOE4w5jDLxFYrWQSyVShBJv1UTRv3xkXpSxVLafhN2FaqyCBPwy5kcfGR2bkkKxkChBLAerRQtmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 19:39:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 19:39:11 +0000
Date: Fri, 27 Oct 2023 12:39:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] cxl/region: Calculate a target position in a
 region interleave
Message-ID: <653c11dcaf694_244c8f294fc@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1698263080.git.alison.schofield@intel.com>
 <0ac32c75cf81dd8b86bf07d70ff139d33c2300bc.1698263080.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ac32c75cf81dd8b86bf07d70ff139d33c2300bc.1698263080.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:303:84::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c46d6e6-1b1c-4bf9-48c1-08dbd72464ab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baFlhJRvi1CKi+x24P4xaPFl9bZj3y/GGGZ6na1TE9cLsCA32uxw033eW5gdGpULt9VQLg4y/SPuMUKPndERcbPyXqTxxSh6lWp+LkRTmE1bEqDr6HWn3dQfOkuQCZBgAAktw9AI2feF+zltmGljxukhsa9cUQgvdCvdNV13tyf4QcA3NQ8lnkuJlvbNHCaGB73QG2trozeiIM+fFD4X+XOc3EJFa7DzB62Oc/ajCRksgnaG2rECvK51y/gtn5d55p13nBsDz0DgqQrSTuf+LflyZF6nW5+5GcRY1OmLKiAotEoMAv9+exLl3ltqporFd9g7nUuVjT2izXl5+3IpRyZ67JB2e6szLsts0P4yrj0aLhLh6LWHzxfW3oo8VMMQld8+MzWBX8wzsNvP5eQnRD9MjXl90DOey57XPISqOMpC/+8ik2QA9AyuWdRRrylSFt7lwuiE8zmcLVGZR2R0PI4tEP+ZzcRrDb56zFNMe+qDXi4IGJATanuqxkXbuysK3KSuC4SmqHYNwD2F7tiTkHH2DLglkN0ygBKzN/3zv4OXaKv8G1GNQTAFcFotHhsh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(6512007)(9686003)(26005)(6506007)(478600001)(6666004)(6486002)(83380400001)(5660300002)(41300700001)(110136005)(8676002)(66946007)(4326008)(8936002)(66556008)(66476007)(316002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A64Wk7e2+4QVGI9aCKn0r2Mx2T4SoNDG2v+P0aXnUTAZq8ZEw+y6JY01t747?=
 =?us-ascii?Q?wSrSwL+9BJeysgodNWCiE3akcCIFpdnDN7KhcNubFuUT8YicFqM12poVvLlf?=
 =?us-ascii?Q?9e6Y83mvHp64BIZYvGJsmX0UWK03NCnmU52lm9ZpiXhPAFMxrFzurCUlUZTF?=
 =?us-ascii?Q?yTVQDU0AWB0PlvIhsKotMHXvPrpPp/WDudMH5R+eV9mF8sVr3BNf9KXK4+TT?=
 =?us-ascii?Q?uREFn2pDXWLOy7n/TqB0qCyIJcAgXQ9TsBzHedrYKaZx4K8nGQuIsUs+4cVA?=
 =?us-ascii?Q?pGrSNrsey5Xb12Sxv/2hLQAheZ/VZMHxPbpDi391qHbSF4Czw3+aGXb4bhqc?=
 =?us-ascii?Q?Nz+SH1ZGu3fM9cx5hSsmdu6S/p50dkZ9BvPNtlf4Pr1vs09txo+Kl6yNnLq9?=
 =?us-ascii?Q?6/15Lw94FPGfMuKnKJpWqAzWR0TGiliXzuBwAXOwCQjLoYFWSwi8u+arpwla?=
 =?us-ascii?Q?y7TPdJC2IfdTFQsUiQLlVn+yEIdbdNW8A/cdsZ/kWPQceMadzL6Uz6uiyyQL?=
 =?us-ascii?Q?1TVz3wcA3hI6IE4jalqHqrJXjxGNe30JFiIolfcxQ8hskplpIs2lc7m2vczB?=
 =?us-ascii?Q?vgHobmxkt46SEVifAT2Il8nJPdNpUclRaU/0Yb8qgdVHf3NuAxqUvJyRYI7J?=
 =?us-ascii?Q?1KL4WUPCN5HAOU+tRQs1CXpCTcthWVH0IjU27mIqSshxLQlKlsvOGD3lTKXa?=
 =?us-ascii?Q?OmTciCFGpFBRIbVB8VqY/nHc3l4hnBMJPOA15Y19TZDrF2l/KO/3pOtPEZFQ?=
 =?us-ascii?Q?K+3B3lpOH1IQrMgE6byMQZMSXVGkRXmze6arLHY2eivimaKi+I4CrUoXoQgr?=
 =?us-ascii?Q?+uUCTCtiKN4eteLBodO0wWaA6yOgJmG8tuN6++Nd3FWlfqV0e5XNnDLThqKB?=
 =?us-ascii?Q?MEvEC3UMaHM8BYzyF0jheLUG6QGVZNCktXQ3baeARvJEpblM/U39/s373c6z?=
 =?us-ascii?Q?pca6L49y6srcGsOL8YfP0cNrdTxHNnNC4y2T8cfALccNgikUz1LclP2Jct+b?=
 =?us-ascii?Q?zJMtlHQ9REgSteq+4L+3Iciwrz+JbzOSlA+1og6FEVg59CyuGpJ9dLJBbKN0?=
 =?us-ascii?Q?GLu/K6KxA8i2bdnxrwURWQGDh0cEUeONs1akz1M8BOY8GACCHMQ4FAaBRdlB?=
 =?us-ascii?Q?OdE9mnq4vUU0uNyYPgQY8n1c3OgJH7yxhjqlr3wQnlETyZMvBVfiUr2IdZJs?=
 =?us-ascii?Q?wCgfvhKbmvmP3ZI0KmHDxJY9TLLLQobsX7IqT9jOaRstNug+Fp3MwNsRcx/N?=
 =?us-ascii?Q?Us11WEhmw2Bmtk9pZrQpZltcvibnVuOb/7kLMitQIL0VzSQLOju2sKZrjmrW?=
 =?us-ascii?Q?nIkBxsdE1/E2F78ZMiJ6H6xbTlz0lZVf69nvQHKxoF4YDT5TSaglVVK7UUbg?=
 =?us-ascii?Q?Yi3vEmClX94VvsTZZC85seawsE6/oegeHXcHycU7/uNurqOTVvtlTb/OwRF2?=
 =?us-ascii?Q?P9IDjot27ZnFokZhBXm4WlG20nKqq6xCsJs4DyBYZ8iT1QYTFB9mm0kr4b53?=
 =?us-ascii?Q?BaCMW3Lrf1+6cofP7sQEiZtUi5F6wyGcTvn31rMdT2H/duRGCQU1v0mJ+URa?=
 =?us-ascii?Q?vY0VEdeUvqbpKVVVLQTLvceBvHlK0vUPrjOp8dUvbg6s2tbufdFX72kpkZ8U?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c46d6e6-1b1c-4bf9-48c1-08dbd72464ab
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 19:39:11.5096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIeo2eln4RDJjZzpByVnn2UguQ40050xsCAdfNRT11AqMWtSM2V+/J0KAuqHxLRqmZvpDCMa+LHS634jEflEBps8fdDYtBSw9+w7G2XMuTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Introduce a calculation to find a target's position in a region
> interleave. Perform a self-test of the calculation on user-defined
> regions.
> 
> The region driver uses the kernel sort() function to put region
> targets in relative order. Positions are assigned based on each
> target's index in that sorted list. That relative sort doesn't
> consider the offset of a port into its parent port which causes
> some auto-discovered regions to fail creation. In one failure case,
> a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
> puts all the targets of one port ahead of another port when they
> were expected to be interleaved.
> 
> In preparation for repairing the autodiscovery region assembly,
> introduce a new method for discovering a target position in the
> region interleave.
> 
> cxl_calc_interleave_pos() adds a method to find the target position by
> ascending from an endpoint to a root decoder. The calculation starts
> with the endpoint's local position and position in the parent port. It
> traverses towards the root decoder and examines both position and ways
> in order to allow the position to be refined all the way to the root
> decoder.
> 
> This calculation: position = position * parent_ways + parent_pos;
> applied iteratively yields the correct position.
> 
> Include a self-test that exercises this new position calculation against
> every successfully configured user-defined region.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
[..]
> +/**
> + * cxl_calc_interleave_pos() - calculate an endpoint position in a region
> + * @cxled: the endpoint decoder
> + *
> + * The endpoint position is calculated by traversing from the endpoint to
> + * the root decoder and iteratively applying this calculation:
> + *	position = position * parent_ways + parent_pos;
> + *
> + * For example, the expected interleave order of the 4-way region shown
> + * below is: mem0, mem2, mem1, mem3
> + *
> + *		  root_port
> + *                 /      \
> + *      host_bridge_0    host_bridge_1
> + *        |    |           |    |
> + *       mem0 mem1        mem2 mem3
> + *
> + * In the example the calculator will iterate twice. The first iteration
> + * uses the mem position in the host-bridge and the ways of the host-
> + * bridge to generate the first, or local, position. The second iteration
> + * uses the host-bridge position in the root_port and the ways of the
> + * root_port to refine the position.
> + *
> + * A trace of the calculation per endpoint looks like this:
> + * mem0:	pos = 0 * 2 + 0		mem2:	pos = 0 * 2 + 0
> + *		pos = 0 * 2 + 0			pos = 0 * 2 + 1
> + *		pos: 0				pos: 1
> + *
> + * mem1:	pos = 0 * 2 + 1		mem3:	pos = 0 * 2 + 1
> + *		pos = 1 * 2 + 0			pos = 1 * 2 + 1
> + *		pos: 2				pos = 3

As 0day reports, kdoc does not like formatted text, so I will fold in
this fixup:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9c714b53908d..f6be4164dfbe 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1534,43 +1534,19 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 
 /**
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
- * @cxled: the endpoint decoder
+ * @cxled: endpoint decoder member of given region
  *
- * The endpoint position is calculated by traversing from the endpoint to
- * the root decoder and iteratively applying this calculation:
- *	position = position * parent_ways + parent_pos;
+ * The endpoint position is calculated by traversing the topology from
+ * the endpoint to the root decoder and iteratively applying this
+ * calculation:
  *
- * For example, the expected interleave order of the 4-way region shown
- * below is: mem0, mem2, mem1, mem3
+ *    position = position * parent_ways + parent_pos;
  *
- *		  root_port
- *                 /      \
- *      host_bridge_0    host_bridge_1
- *        |    |           |    |
- *       mem0 mem1        mem2 mem3
- *
- * In the example the calculator will iterate twice. The first iteration
- * uses the mem position in the host-bridge and the ways of the host-
- * bridge to generate the first, or local, position. The second iteration
- * uses the host-bridge position in the root_port and the ways of the
- * root_port to refine the position.
- *
- * A trace of the calculation per endpoint looks like this:
- * mem0:	pos = 0 * 2 + 0		mem2:	pos = 0 * 2 + 0
- *		pos = 0 * 2 + 0			pos = 0 * 2 + 1
- *		pos: 0				pos: 1
- *
- * mem1:	pos = 0 * 2 + 1		mem3:	pos = 0 * 2 + 1
- *		pos = 1 * 2 + 0			pos = 1 * 2 + 1
- *		pos: 2				pos = 3
- *
- * Note that while this example is simple, the method applies to more
- * complex topologies, including those with switches.
+ * ...where @position is inferred from switch and root decoder target lists.
  *
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-
 static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
@@ -1579,6 +1555,35 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	int parent_ways = 0, parent_pos = 0, pos = 0;
 	int rc;
 
+	/*
+	 * Example: the expected interleave order of the 4-way region shown
+	 * below is: mem0, mem2, mem1, mem3
+	 *
+	 *		  root_port
+	 *                 /      \
+	 *      host_bridge_0    host_bridge_1
+	 *        |    |           |    |
+	 *       mem0 mem1        mem2 mem3
+	 *
+	 * In the example the calculator will iterate twice. The first iteration
+	 * uses the mem position in the host-bridge and the ways of the host-
+	 * bridge to generate the first, or local, position. The second
+	 * iteration uses the host-bridge position in the root_port and the ways
+	 * of the root_port to refine the position.
+	 *
+	 * A trace of the calculation per endpoint looks like this:
+	 * mem0: pos = 0 * 2 + 0    mem2: pos = 0 * 2 + 0
+	 *       pos = 0 * 2 + 0          pos = 0 * 2 + 1
+	 *       pos: 0                   pos: 1
+	 *
+	 * mem1: pos = 0 * 2 + 1    mem3: pos = 0 * 2 + 1
+	 *       pos = 1 * 2 + 0          pos = 1 * 2 + 1
+	 *       pos: 2                   pos = 3
+	 *
+	 * Note that while this example is simple, the method applies to more
+	 * complex topologies, including those with switches.
+	 */
+
 	/* Iterate from endpoint to root_port refining the position */
 	for (iter = port; iter; iter = next_port(iter)) {
 		if (is_cxl_root(iter))
