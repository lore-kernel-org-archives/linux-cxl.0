Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786DBE936ED
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Oct 2023 00:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbjJEA1H (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 20:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjJEA1G (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 20:27:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A502C1
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696465623; x=1728001623;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RT6FJNGFmeV/kh7f33x6Q3T7sAQOTPYhADzI++1ZipM=;
  b=KtAwOUTncCTTbjtzuNp4pPhwHKhwf07CmooeF0ZuautoaoOm4K7WmaYm
   MyhJfwFl1kZHZgmPTRGCcd0drJHhShnrEaEh6cZoJcK5x7/pIZruBHHji
   ul861LKZxqI0e35kq+uYq08Gw1YPo/7I+HNwR6y5yTY5rvwq3mBw3WR1V
   thouIzLDakJyXoI9PpMdDmJYPKGjCDR2eLHnnP2wgiA8pkjHDr2QM3JyU
   Gzeb5Y0tla/N+B2eOknmw/pKc0Nt3an1uBuMwSAQw8ufKoTXWDh+9sULf
   Gw/uXG1Nhe1+S9nPD9b7xuJlyJ8pP6tmgCr8hb0RGjUg/2xt2pE+FwUde
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469623678"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469623678"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 17:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="895223530"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="895223530"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 17:25:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 17:26:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 17:26:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 17:26:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 17:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fkv5WfzgIcWqSRjbRQQWRNMs0mxsoXstiuXKvQgtb/GUfy3iCbTaHELjcBGSNOKqa4MLUdTRh2BeoL4f1//HTvhAbKR+lHXfWNM2GEz40/PcfB+EUXAkSaDhNHjK5cOy7s/UDDNNs+x4E0zSCrZJtO7PmIJtEFv1dly1xGrD30uVrEoGFvObpUPUEVmBGxkS0OnCC9A4Oz8Ex4VPNpv7MsvnaSUL43yqD290bPQ6HBfPdBP3paLXZh17WDphk8kxH6V+NtGv7WJQqekHGzYIOLd/ghQKHsNdpn+pPgjKmog6P1sHSWqpMB3jgz+jeXZiCA8B3Eqas/rD6arH2x8QZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvIBWUOFCbANm+qqZRpeAmsz+9M7lD20KQl8TCdcCTM=;
 b=TM1RwBJ2oayXdmn3b2ngu9pP0eMB+sfQspbCHBs76uZ370FB+PXQtOclsXFu0zBC6spd4hwgGFDcXQ4XSpGf6YUrErYaltfSQTJCHtzea/yOSuT8xaHoQxdHSWFso/T+ye7siHLljQSD7+J/YFVfdInKnO77yB/WNLAcgthGiF1axAaB2sYuOOmK/cW78Y3977qXRERyhYIUsyW4GL3DX01zuylcxCcUjYGjGtnXOifpyhRFEDvs6TTEbJU3nBql0Z6Z3jw+5KEhaTpoNdw5MMpQUbbBWcMSZpHhQ77XWrnIyKXNmdKNRgeqpWTbW9/PuP4oUOLVUvBz652MARQYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6805.namprd11.prod.outlook.com (2603:10b6:806:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 5 Oct
 2023 00:26:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 00:26:30 +0000
Date:   Wed, 4 Oct 2023 17:26:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: RE: [PATCH RESEND 1/2] cxl: Add cxl_decoders_committed() helper
Message-ID: <651e02b2d8603_ae7e72943@dwillia2-xfh.jf.intel.com.notmuch>
References: <169645700414.623072.3893376765415910289.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169645700414.623072.3893376765415910289.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9c41fb-b8ea-4d44-53d9-08dbc539b8a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: et752p3djUamXk7oK5IupIA/rf7/t80IoHAbBaAsImLwK8JFgR1RBu0+Z0XwO5VF9QgbR0nSOkbHeX1q62FsQMttfHqIcUj/ocA+vqgaYEm4uet/lUsQiXNtde0oICKWSLPdhDaxEOQ9HsSyaNNworhKosPZJf3zyt51YpulLMbfhzNhp/jlwB/NkCnrVHMaMgpRz1TNu9hbhkwoqXJCLutrpEDE9QU6EweVk3g3ym7K197xZraZoKQpptdjmZ7ha9oQPRIfLXgGcSKOWscp5BIoWxOBRamnuuDNBkPVvzydoQscvVFCckuG16/1d1+6QR2YsUVBhiya7Wcn5HTJAeuKywiWZs6Oe2PvN/FG8J0ozsu2/TZiouCTJPzMDFRvyayh79IqfvyA6hiT9plr32mWT8IsF726vnjbF8WnXESfgy1Q9iXqzvkqxM52VsPE9LT7UrOLu2kr03Vm1CC2/pS4utiyBVowCM8YV6rqWHjL3v/xD99V3o5XiPMUpQ/eiq+ResnZHH8Cij7SkzpAMty1EMrA7TM++bZV3z7nZEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(966005)(6486002)(6512007)(6506007)(6666004)(478600001)(38100700002)(82960400001)(86362001)(41300700001)(107886003)(66946007)(8676002)(5660300002)(26005)(9686003)(316002)(66556008)(4744005)(66476007)(4326008)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y8ko5Uk7oFda4/FcMj2Vu5B9Ze4facP2fQxug81gMg7IThGFIGcZaSw8eVSW?=
 =?us-ascii?Q?2VOflG4yvJuG1RMd7k5u3m3m6ccD/OUho8NScYtF0eSxe5ssC82l/dZeVRYH?=
 =?us-ascii?Q?u1NG3VcGJoH8Cd1hCK2FYundXba/xIN5LeVCKRLMSQ/VAbS4U+dXhFvI6rFb?=
 =?us-ascii?Q?fqUADX6jl1tKFdkDuKaKVjoni/Ks/JIIt42Sh0YGoorww5ipgRFzaHPJcw6I?=
 =?us-ascii?Q?Tvk3zYmemf+pIlPRLfXkvKhJwvC+cr0W1UhV/XVOhjh4WnDd2/ve1MYW82y8?=
 =?us-ascii?Q?IfgVOCuyA6p5mXZtVXBcUotD/3SDixO8B26xOjJq3StZR8iF9AhtriSOj/3j?=
 =?us-ascii?Q?+yhSZAvlUsfLEGlYEjDfIHSGL1q3O+cvJR91HLhBUUxYtep+jUJQENreNhza?=
 =?us-ascii?Q?a73RoWqhBogtADlCnCtprvJIHhKTkP9P2QGWak7nFB32xmS1xeOW8PfyYGbb?=
 =?us-ascii?Q?YyaRgBzpHvS3fLfiDnKDcwkdB3Jg3fgDDP+EofTjozHeVBTgizrtSPXemw2P?=
 =?us-ascii?Q?eRSDfETi7G+J8YRVRzZZ1Yy+GHJib8EhBjGDi9+sTVVcWP7duFhBwggAklF3?=
 =?us-ascii?Q?2jpifmHz5mCJRYQ9p9A/637hF3RWhvM90SklDaCTED3uRMGTc9cEVmhuyXtc?=
 =?us-ascii?Q?LWH1H8T+mQ/SwJFXC8TX5ko21wjpkqs3anTidL8Xr1+YM5+zUR7WzfY9Y67x?=
 =?us-ascii?Q?HIPkJRqgX4xejpnGcKSFJcjrXhG9jFnJ1rNyKC+hUgQ/xiDVmgtJD3iTBsm4?=
 =?us-ascii?Q?GQhe168UT936626zvaoUg1oMq/vYlP9k6nACUsG3+3HD1UPQEE1v8JLdd3qB?=
 =?us-ascii?Q?a5eKECuC02gbQKeRfvC+MJZFo+4Wdi2n4RDT7JOn7mYJi7hOBZyPRFv70/G/?=
 =?us-ascii?Q?37wedvY44dBNMe0BPHTGx7mTRk4Lfc0ro6RG+Uf/zRYrrCkW2vTaDj8+Ii+k?=
 =?us-ascii?Q?Hx/fFSW6bTIeht5dDoRzdi6PVY0Q1K9UIW0hiR4vBm0+g94CaYlrf47hO1SJ?=
 =?us-ascii?Q?Gx1Ha+00TcLa8rKqsXzF8UqeUAITzDl0HcDX8Rh77/a5toOFpo5eN7yAUzbD?=
 =?us-ascii?Q?ZTawfGUBXKuqL82/0B5vGLvlWvUX8Hd7ozQx2Nap/SIn7OYAMGwYrPcQUitL?=
 =?us-ascii?Q?sYO96sDbBhsXO9BYWUQiAKZ2La8hDc36TaQXy6J7CrlhFDnIi6czk4vErpoj?=
 =?us-ascii?Q?JwuezhF/4RvNHEp+pUITp6lXVIilM+iEuNKPRni09eos3vcg7loqsVmmAzGW?=
 =?us-ascii?Q?WwzLgY9DloBVr9VsXaRD6uZsMNrAy3RT4KyyW8bKyCzDmXgbSxiWCY/cZg7j?=
 =?us-ascii?Q?wTUbnXUha0uxhWCgdfnHwDXqNDNY3KqntiJ9XzetgbMIOj4p9zoJzv/rdI4+?=
 =?us-ascii?Q?7Der8wXdlvpCzPy1Kzcg2+r46buJccupdY9yh2EAzU79XJkjE1R1jKTSPJUG?=
 =?us-ascii?Q?3bwnmkD9P8LNpnDOvFauuV9i0o8GW+2/PRbEe9+A5SZduPqYfmS2DQSx0YQy?=
 =?us-ascii?Q?JKE1D0gdb9179oAR24eTVRtUBTeKYSDDmvoD78uY+dp1ziwfj0FdHuXLG1kT?=
 =?us-ascii?Q?DdEb8U+uuPdc0WE8Ht1SuAYPySJ+iPh8J0n7aBNe5lSL+BzNkx0KygR3qaxP?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9c41fb-b8ea-4d44-53d9-08dbc539b8a1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 00:26:30.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnKmxOgH8aCPfiM8Lkp7KJcaqIkjyTer7yGotsIwBXrwNk7Ev0LWfGwPAZ5njBImlYpaRM3F1gbdC0lyBztbKkpenixctPW4hxzgA94d6iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6805
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Add a helper to retrieve the number of decoders committed for the port.
> Replace all the open coding of the calculation with the helper.
> 
> Link: https://lore.kernel.org/linux-cxl/651c98472dfed_ae7e729495@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7ca01a834e18..16efb68eacfa 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -31,6 +31,12 @@
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +int cxl_decoders_committed(struct cxl_port *port)
> +{
> +	return port->commit_end + 1;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_decoders_committed, CXL);

Why EXPORT_SYMBOL? None of the consumers are outside of the cxl_core.o
compilation unit, right? It could probably just be a static inline in
cxl/core/core.h.
