Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45DBC54E94
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 23:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjAYXwd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 18:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjAYXwd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 18:52:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1476D5E521
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 15:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674690751; x=1706226751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wog/L/IgscHOpVrC6Jr+AZsEBc01coS/ENwGLoWRdao=;
  b=O961TiQcPloK/2nhkfy5vpwQwphJb+Ny7lRUfektQZblQ3P5XGjNnIC6
   9Jg5MWlAaJikhjCKDfzRTHTxhvsYGqmGZ3NsEV5UgfOf3ItYAbzs7sQjN
   pZiqUPwQC53+Z+iPLkt84bZCnnskxqzyg528Q+I6NbUHB2/R9DI++b3t/
   mP/EwojXJhC7Qjbpfmf/Uoh1q84PfzfvTYIST7Z5hvpiiIU8fbJDFtUJr
   HCGy+Rgpu8evnAiatXC0NFmcIAxjSBPcjtpIitSS0jJDjC8zP7SPnG+Ki
   m3vCTtImi0kylBJY+/wZtOnhf5AoGbFyrhpYQa7XNNyeckqBMBP0RLfly
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="314617263"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="314617263"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 15:52:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="662664172"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="662664172"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2023 15:52:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 15:52:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 15:52:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 15:52:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH3clcJpKmOdRGhduAEnCEaKfg9cSa+vhh9HVW14YcgGoRMgVVXnwJxZnh+SiyGk4PdmwXt9JUGFLT7jpAf3sbJn0EkloX1ZNUpF1eScFv4yYUZ4JoO3v/mKo308HcHtparVGWcon36Z9tLWt0oezADQwUnUydZtUKvYZvnF7IgLvJmk29vIIhN40vKtaUJtR275N6go3XnrHBLETWtUnJd0Ejd1AuLEllhKXx6Cgr1XSlDDQW3Fiz1jTMOhtxvulRNjNfxxG0BURiny4jsQBmwFipaOEg0eilut2mYCp5ITaTQ2k0j/d9IRUbiJBFcEyAtMbkpvfN5pSR+yNtVa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Blrde9+AmraMTr2cZWiiazBdqJkdrMEMiXqXfqVRZU=;
 b=Ggnok+ylzcFTiXurmnGrNUFBD0hdL1W3/1MDql5y3MPmCp3cdWVyFuL3tar99JSpfue95vOqj8scCA332egmE/GH3pk1JheyJefvk71ghPsdhilndj6uFVr4ceisvi2nnjoIbn8HgPeC83BlkoxBk00PePyWP1fi0JRvjWjB4xEZlcXuMclc4XC2UxJi9rs7MXAe72iT2ahzT/bthWCdiMeXpxFUQhXS5n4VAC4j1Nmmg+rFKkYQWTqfwg1WMGwMI67cpjtGQyNlDPl7tzrft4uvAhDvMn54SrGVrEdsa+2YHQmvXoU4du5rVPqj23r0l4AgoKRJIGTpd0021A6pTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 23:52:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 23:52:27 +0000
Date:   Wed, 25 Jan 2023 15:52:24 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: RE: [PATCH] cxl: change 'cxl_nvb' naming to 'nv_bridge' to improve
 readability
Message-ID: <63d1c0b89ce33_3a36e52947f@dwillia2-xfh.jf.intel.com.notmuch>
References: <167467326134.935137.4655746929377717768.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167467326134.935137.4655746929377717768.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 941cf4ec-e048-48fa-a6e9-08daff2f3682
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cc4TBnxRQgQFgTBlt7GxqQiWvcvgg5Gw1CQDfIszPok3Q5ulILtdzdZhYx9owUX7xN8RsBZWMiPBK4GgTvuOepoxiT6rvjE5CnfJYZlwknLlvC48bi98dKuoW2CuqcEGy4sFF5aORZ6Hs64M8dKwY5LZuTD+xf/OfXU466nu9KajVrxAxj9y5pobUgJyF/hsHVl2qy9Imv1hxTr90jRl82HgITamB4Ck7CY2WAXf04zgnqBBCfoC+Lbv/MNGSLG7t+i7013avnbHYwPunTFv2Bm6N1/VizdWUuEXloYNSjO1TVkw20oZAfrPNrrnKSFtD+LZ5sW2r583LSwYzV3unxSgy8PvljtwLMrgnCVa1a2dWB/n3QioKchVn9EqZdlQ3saWNsxYzl8nFIhhEdYEyoJlVRIpuoPg3gLjL5dEFlN+NHRNXzmEGLOHG4TnUF1MEsa2gbPO4ijdqJu+Kc6awbO2U/AdZyJpgWd2ouNwIJjOiq4DZw5eSiXDSK3ntRsznvYjTO7hst0S7H9HVXwRlCb4VMIsWFAk8ZGQRle0QU9SMYXr9Y0Kh4Yu74xxIA5Skf5CGcqtVbVWjc2UIwelBH/VpTKMGsr345ux1rjxA7u/+i75QJ3pnaOIJ+GDpLvXBHCvufIvddiJQW39RusF7vbMogzcb74bkiRqMg7MGll9HZvS6u9eNEqMqkMORTr61MAbWgms/QxY+/moLGWp1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199018)(26005)(186003)(9686003)(6666004)(6512007)(478600001)(316002)(66946007)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(8936002)(966005)(6506007)(53546011)(86362001)(6486002)(83380400001)(82960400001)(30864003)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Huyb2+HeFCGX0cwfK9FjNEslVCzcsafIAYOk24hobW5rFvWAEKbE5Dx/3/yB?=
 =?us-ascii?Q?xnBlTngkUAGFnF1/Eavgw6VMtdJtySSXSd6OVyalcu1o6W2B71fKKfjllupw?=
 =?us-ascii?Q?nTjq4YNvWi91UR9WaIIFPwq5hu2EDZkqHvabs7PzGk54n90wp++mz2iAmvnA?=
 =?us-ascii?Q?NkwrfcnI0BXcWDUZjllUwJKoznPSj2VpNgjrUudB2AlzhhV93VGLsZxAchJW?=
 =?us-ascii?Q?8Vie/MArdsvma9mtJB4v+JuamCzUsT9aKuoTLRnbkJNQoMlwtaI22hyAcdCq?=
 =?us-ascii?Q?h1dG+CUmKXHTiCMrwAHKf1EuAAcdGXa+dE9pqeZolI0YHlgtSxHpt6mEg/gm?=
 =?us-ascii?Q?uCp9ukPImJqV+wALg3sZW569d+1cvXwdPxYVCxOeZWE00wJxT8Q44cZpK7MO?=
 =?us-ascii?Q?lZztW1iwyM6zyMDDa6e98knlh53eejqZnD/WRZbt8u8wx9wqJVXEjrnm2L7h?=
 =?us-ascii?Q?iYkrcitU2njTAH0CJu8YxgtzBytvjcuaYDZdXPCbwDc/WSmviUQp1za94EUE?=
 =?us-ascii?Q?Dhss9lG7jTEDKFdVlxsBZh94uEjoDhwi9lO5ozLIECRAJUAsKCeQBoZZ+o8r?=
 =?us-ascii?Q?e6EI5FS3ZjKSpvv01gVc6kZbwPTbp2jlsfiqMB6gedmduwy6+lhogWH1mCox?=
 =?us-ascii?Q?17uyoG5pn5ExaSfx+8ixXUu0ZjWOWD4tOCy8aU41jEphUxJRDGFIm4H+6FtH?=
 =?us-ascii?Q?yS36cL/1MHICosnRR98N2A4PBuy6jn7ZSmXCsyzjdJrVcqdUfgllMx9Pagbw?=
 =?us-ascii?Q?YR/63SpzAYkkcaL4ANdDwgRw3u4SVkOsXttPLqSuk5GRYqgpNu/bVgg96bKz?=
 =?us-ascii?Q?9e6x62vUwMJ+sgf0JGFNafN/6r8J6OJKAOWhkFx4esDeavXoqSjShFzEOE7C?=
 =?us-ascii?Q?ALRXfNjdRmJ3zQez640IEfxyKICnLF/IqO5syNRM+efFuEYWI65AiWsTj5t1?=
 =?us-ascii?Q?bVSz1QlGGN6OMXqkTzk1rjR1Eb2YtDkQf4n3XQSTxy15qsOi+RCitRG0UsbV?=
 =?us-ascii?Q?wO91ulQf+2fIO9mhaX68lK6Ey6rtgftXQbKgptdQQ9JikSWCqVELGyaFVkNd?=
 =?us-ascii?Q?EAZ3k8Nv3mdCN4AICmnlLmR+QT4s8OLkZ4BwM3uw9XS+U8theStPg4l8G5ON?=
 =?us-ascii?Q?GPtI7B9r76ezeJRRpZpMuNRZOirH1r7mMAYqaEFw1pd+XIyIF2xXbVSqhAdM?=
 =?us-ascii?Q?lQgwGCK1igwtSNnDdVftdo2P/LMzrSDpLmxwWIv/Bg8Pl6C78rua/iUxbQOF?=
 =?us-ascii?Q?LfP16OKRUx8scr2ErcGohWADR++yeFKkaPqZiEPLnSz/hYwcJYiFKEuKJhgp?=
 =?us-ascii?Q?Lx52Cj53zz5uUiKTCx81ZBaI+CohRxRqx+CB13mkwrJ/uA7Z6uw1D7b1hgdI?=
 =?us-ascii?Q?UdDxNz2lLrdq8MxSDmDs7+7L+48/A2V+TTwQ2zjOHmeK0EkhvgqVewIc3x2L?=
 =?us-ascii?Q?xwuDnIyDijswcVDb/1r156gdAfXrEIxebcNwb47Ry0e/nAeMQBSrfA72O14T?=
 =?us-ascii?Q?YZvLlWX17x/a5pMvIKQIDunH5KHzmGAOSfJZUIRg9NBsih2mQHiTsqvIxrWk?=
 =?us-ascii?Q?BWHwL6Nz8WyFhZvLF/g81Rn2FO9wsm4VbFrrTzhugLKP/fWd08zVoRMyXkfl?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 941cf4ec-e048-48fa-a6e9-08daff2f3682
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 23:52:27.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi4KT/8DgmMJoDKLPDo++atfvJ+0Ozr0HeCOy3r9+bMGNzlyRBKS7sO/4I0AiYWgUVjpDSbX4Ol7d9dLH/hyyLQ615nRmS3/KR7E89c2FWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> In CXL code there is 'cxl_nvb' for CXL nvdimm bridge and 'cxl_nvd' for CXL
> nvdimm device. Having both in the code causes confusion with code reading.
> Change all instances of 'cxl_nvb' to 'nv_bridge' in order to improve
> readability.
> 
> https://lore.kernel.org/linux-cxl/20230124164453.000029c6@Huawei.com/T/#md44f8d931541fcfa990d8e7e30404a9d37902d9a
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/acpi.c        |   10 +++--
>  drivers/cxl/core/pmem.c   |   84 +++++++++++++++++++++++----------------------
>  drivers/cxl/core/region.c |   42 +++++++++++------------
>  drivers/cxl/cxl.h         |    4 +-
>  drivers/cxl/cxlmem.h      |    4 +-
>  drivers/cxl/pmem.c        |   28 ++++++++-------
>  6 files changed, 86 insertions(+), 86 deletions(-)

Looks good, I rebased this on cxl/fixes that has the pending stable
backport and massaged the commit message a bit:

-- >8 --

From d6d961c1216fd1bff60c17c15757a71099eb79c0 Mon Sep 17 00:00:00 2001
From: Dave Jiang <dave.jiang@intel.com>
Date: Wed, 25 Jan 2023 12:01:02 -0700
Subject: [PATCH] cxl/pmem: Rename 'cxl_nvb' to 'nv_bridge' to improve
 readability

In CXL code there is 'cxl_nvb' for CXL nvdimm bridge and 'cxl_nvd' for CXL
nvdimm device. Having both in the code causes confusion with code reading.
Change all instances of 'cxl_nvb' to 'nv_bridge' in order to improve
readability.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: http://lore.kernel.org/r/26633055-4e38-01c3-19a5-ef83fd57b533@intel.com
Link: https://lore.kernel.org/r/167467326134.935137.4655746929377717768.stgit@djiang5-mobl3.local
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c        | 10 +++---
 drivers/cxl/core/pmem.c   | 68 +++++++++++++++++++--------------------
 drivers/cxl/core/region.c | 42 ++++++++++++------------
 drivers/cxl/cxl.h         |  4 +--
 drivers/cxl/cxlmem.h      |  4 +--
 drivers/cxl/pmem.c        | 32 +++++++++---------
 6 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 13cde44c6086..212ee7bbf318 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -480,7 +480,7 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
 {
 	struct cxl_decoder *cxld;
 	struct cxl_port *root_port = data;
-	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge;
 	struct device *host = root_port->dev.parent;
 
 	if (!is_root_decoder(match))
@@ -490,13 +490,13 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
 	if (!(cxld->flags & CXL_DECODER_F_PMEM))
 		return 0;
 
-	cxl_nvb = devm_cxl_add_nvdimm_bridge(host, root_port);
-	if (IS_ERR(cxl_nvb)) {
+	nv_bridge = devm_cxl_add_nvdimm_bridge(host, root_port);
+	if (IS_ERR(nv_bridge)) {
 		dev_dbg(host, "failed to register pmem\n");
-		return PTR_ERR(cxl_nvb);
+		return PTR_ERR(nv_bridge);
 	}
 	dev_dbg(host, "%s: add: %s\n", dev_name(&root_port->dev),
-		dev_name(&cxl_nvb->dev));
+		dev_name(&nv_bridge->dev));
 	return 1;
 }
 
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index c2e4b1093788..fc31b9eb8f51 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -25,10 +25,10 @@ static DEFINE_IDA(cxl_nvdimm_bridge_ida);
 
 static void cxl_nvdimm_bridge_release(struct device *dev)
 {
-	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
+	struct cxl_nvdimm_bridge *nv_bridge = to_cxl_nvdimm_bridge(dev);
 
-	ida_free(&cxl_nvdimm_bridge_ida, cxl_nvb->id);
-	kfree(cxl_nvb);
+	ida_free(&cxl_nvdimm_bridge_ida, nv_bridge->id);
+	kfree(nv_bridge);
 }
 
 static const struct attribute_group *cxl_nvdimm_bridge_attribute_groups[] = {
@@ -84,21 +84,21 @@ static struct lock_class_key cxl_nvdimm_bridge_key;
 
 static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
 {
-	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge;
 	struct device *dev;
 	int rc;
 
-	cxl_nvb = kzalloc(sizeof(*cxl_nvb), GFP_KERNEL);
-	if (!cxl_nvb)
+	nv_bridge = kzalloc(sizeof(*nv_bridge), GFP_KERNEL);
+	if (!nv_bridge)
 		return ERR_PTR(-ENOMEM);
 
 	rc = ida_alloc(&cxl_nvdimm_bridge_ida, GFP_KERNEL);
 	if (rc < 0)
 		goto err;
-	cxl_nvb->id = rc;
+	nv_bridge->id = rc;
 
-	dev = &cxl_nvb->dev;
-	cxl_nvb->port = port;
+	dev = &nv_bridge->dev;
+	nv_bridge->port = port;
 	device_initialize(dev);
 	lockdep_set_class(&dev->mutex, &cxl_nvdimm_bridge_key);
 	device_set_pm_not_required(dev);
@@ -106,18 +106,18 @@ static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_nvdimm_bridge_type;
 
-	return cxl_nvb;
+	return nv_bridge;
 
 err:
-	kfree(cxl_nvb);
+	kfree(nv_bridge);
 	return ERR_PTR(rc);
 }
 
-static void unregister_nvb(void *_cxl_nvb)
+static void unregister_nvb(void *_nv_bridge)
 {
-	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge = _nv_bridge;
 
-	device_unregister(&cxl_nvb->dev);
+	device_unregister(&nv_bridge->dev);
 }
 
 /**
@@ -130,19 +130,19 @@ static void unregister_nvb(void *_cxl_nvb)
 struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 						     struct cxl_port *port)
 {
-	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge;
 	struct device *dev;
 	int rc;
 
 	if (!IS_ENABLED(CONFIG_CXL_PMEM))
 		return ERR_PTR(-ENXIO);
 
-	cxl_nvb = cxl_nvdimm_bridge_alloc(port);
-	if (IS_ERR(cxl_nvb))
-		return cxl_nvb;
+	nv_bridge = cxl_nvdimm_bridge_alloc(port);
+	if (IS_ERR(nv_bridge))
+		return nv_bridge;
 
-	dev = &cxl_nvb->dev;
-	rc = dev_set_name(dev, "nvdimm-bridge%d", cxl_nvb->id);
+	dev = &nv_bridge->dev;
+	rc = dev_set_name(dev, "nvdimm-bridge%d", nv_bridge->id);
 	if (rc)
 		goto err;
 
@@ -150,11 +150,11 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 	if (rc)
 		goto err;
 
-	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
+	rc = devm_add_action_or_reset(host, unregister_nvb, nv_bridge);
 	if (rc)
 		return ERR_PTR(rc);
 
-	return cxl_nvb;
+	return nv_bridge;
 
 err:
 	put_device(dev);
@@ -197,7 +197,7 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_nvdimm, CXL);
 
 static struct lock_class_key cxl_nvdimm_key;
 
-static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
+static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *nv_bridge,
 					   struct cxl_memdev *cxlmd)
 {
 	struct cxl_nvdimm *cxl_nvd;
@@ -231,13 +231,13 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
 {
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct cxl_nvdimm *cxl_nvd = cxlmd->cxl_nvd;
-	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge = cxlmd->nv_bridge;
 
 	cxl_nvd->cxlmd = NULL;
 	cxlmd->cxl_nvd = NULL;
-	cxlmd->cxl_nvb = NULL;
+	cxlmd->nv_bridge = NULL;
 	device_unregister(&cxl_nvd->dev);
-	put_device(&cxl_nvb->dev);
+	put_device(&nv_bridge->dev);
 }
 
 /**
@@ -248,21 +248,21 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
  */
 int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
 {
-	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge;
 	struct cxl_nvdimm *cxl_nvd;
 	struct device *dev;
 	int rc;
 
-	cxl_nvb = cxl_find_nvdimm_bridge(&cxlmd->dev);
-	if (!cxl_nvb)
+	nv_bridge = cxl_find_nvdimm_bridge(&cxlmd->dev);
+	if (!nv_bridge)
 		return -ENODEV;
 
-	cxl_nvd = cxl_nvdimm_alloc(cxl_nvb, cxlmd);
+	cxl_nvd = cxl_nvdimm_alloc(nv_bridge, cxlmd);
 	if (IS_ERR(cxl_nvd)) {
 		rc = PTR_ERR(cxl_nvd);
 		goto err_alloc;
 	}
-	cxlmd->cxl_nvb = cxl_nvb;
+	cxlmd->nv_bridge = nv_bridge;
 
 	dev = &cxl_nvd->dev;
 	rc = dev_set_name(dev, "pmem%d", cxlmd->id);
@@ -275,15 +275,15 @@ int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
 
 	dev_dbg(&cxlmd->dev, "register %s\n", dev_name(dev));
 
-	/* @cxlmd carries a reference on @cxl_nvb until cxlmd_release_nvdimm */
+	/* @cxlmd carries an @nv_bridge reference until cxlmd_release_nvdimm */
 	return devm_add_action_or_reset(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);
 
 err:
 	put_device(dev);
 err_alloc:
-	cxlmd->cxl_nvb = NULL;
+	cxlmd->nv_bridge = NULL;
 	cxlmd->cxl_nvd = NULL;
-	put_device(&cxl_nvb->dev);
+	put_device(&nv_bridge->dev);
 
 	return rc;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 02f28da519e3..f03e42db7c6e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1814,7 +1814,7 @@ static struct lock_class_key cxl_pmem_region_key;
 static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge;
 	struct cxl_pmem_region *cxlr_pmem;
 	struct device *dev;
 	int i;
@@ -1847,12 +1847,12 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
 		 * bridge for one device is the same for all.
 		 */
 		if (i == 0) {
-			cxl_nvb = cxl_find_nvdimm_bridge(&cxlmd->dev);
-			if (!cxl_nvb) {
+			nv_bridge = cxl_find_nvdimm_bridge(&cxlmd->dev);
+			if (!nv_bridge) {
 				cxlr_pmem = ERR_PTR(-ENODEV);
 				goto out;
 			}
-			cxlr->cxl_nvb = cxl_nvb;
+			cxlr->nv_bridge = nv_bridge;
 		}
 		m->cxlmd = cxlmd;
 		get_device(&cxlmd->dev);
@@ -1880,7 +1880,7 @@ static void cxlr_pmem_unregister(void *_cxlr_pmem)
 {
 	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
 	struct cxl_region *cxlr = cxlr_pmem->cxlr;
-	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge = cxlr->nv_bridge;
 
 	/*
 	 * Either the bridge is in ->remove() context under the device_lock(),
@@ -1888,7 +1888,7 @@ static void cxlr_pmem_unregister(void *_cxlr_pmem)
 	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
 	 * lock).
 	 */
-	device_lock_assert(&cxl_nvb->dev);
+	device_lock_assert(&nv_bridge->dev);
 	cxlr->cxlr_pmem = NULL;
 	cxlr_pmem->cxlr = NULL;
 	device_unregister(&cxlr_pmem->dev);
@@ -1897,15 +1897,15 @@ static void cxlr_pmem_unregister(void *_cxlr_pmem)
 static void cxlr_release_nvdimm(void *_cxlr)
 {
 	struct cxl_region *cxlr = _cxlr;
-	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge = cxlr->nv_bridge;
 
-	device_lock(&cxl_nvb->dev);
+	device_lock(&nv_bridge->dev);
 	if (cxlr->cxlr_pmem)
-		devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
+		devm_release_action(&nv_bridge->dev, cxlr_pmem_unregister,
 				    cxlr->cxlr_pmem);
-	device_unlock(&cxl_nvb->dev);
-	cxlr->cxl_nvb = NULL;
-	put_device(&cxl_nvb->dev);
+	device_unlock(&nv_bridge->dev);
+	cxlr->nv_bridge = NULL;
+	put_device(&nv_bridge->dev);
 }
 
 /**
@@ -1917,14 +1917,14 @@ static void cxlr_release_nvdimm(void *_cxlr)
 static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 {
 	struct cxl_pmem_region *cxlr_pmem;
-	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge;
 	struct device *dev;
 	int rc;
 
 	cxlr_pmem = cxl_pmem_region_alloc(cxlr);
 	if (IS_ERR(cxlr_pmem))
 		return PTR_ERR(cxlr_pmem);
-	cxl_nvb = cxlr->cxl_nvb;
+	nv_bridge = cxlr->nv_bridge;
 
 	dev = &cxlr_pmem->dev;
 	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
@@ -1938,25 +1938,25 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
-	device_lock(&cxl_nvb->dev);
-	if (cxl_nvb->dev.driver)
-		rc = devm_add_action_or_reset(&cxl_nvb->dev,
+	device_lock(&nv_bridge->dev);
+	if (nv_bridge->dev.driver)
+		rc = devm_add_action_or_reset(&nv_bridge->dev,
 					      cxlr_pmem_unregister, cxlr_pmem);
 	else
 		rc = -ENXIO;
-	device_unlock(&cxl_nvb->dev);
+	device_unlock(&nv_bridge->dev);
 
 	if (rc)
 		goto err_bridge;
 
-	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
+	/* @cxlr carries a reference on @nv_bridge until cxlr_release_nvdimm */
 	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
 
 err:
 	put_device(dev);
 err_bridge:
-	put_device(&cxl_nvb->dev);
-	cxlr->cxl_nvb = NULL;
+	put_device(&nv_bridge->dev);
+	cxlr->nv_bridge = NULL;
 	return rc;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1b1cf459ac77..1a795a2ddbe3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -426,7 +426,7 @@ struct cxl_region_params {
  * @id: This region's id. Id is globally unique across all regions
  * @mode: Endpoint decoder allocation / access mode
  * @type: Endpoint decoder target type
- * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
+ * @nv_bridge: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
  * @flags: Region state flags
  * @params: active + config params for the region
@@ -436,7 +436,7 @@ struct cxl_region {
 	int id;
 	enum cxl_decoder_mode mode;
 	enum cxl_decoder_type type;
-	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge;
 	struct cxl_pmem_region *cxlr_pmem;
 	unsigned long flags;
 	struct cxl_region_params params;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..f1322f779346 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -35,7 +35,7 @@
  * @cdev: char dev core object for ioctl operations
  * @cxlds: The device state backing this device
  * @detach_work: active memdev lost a port in its ancestry
- * @cxl_nvb: coordinate removal of @cxl_nvd if present
+ * @nv_bridge: coordinate removal of @cxl_nvd if present
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
  * @id: id number of this memdev instance.
  */
@@ -44,7 +44,7 @@ struct cxl_memdev {
 	struct cdev cdev;
 	struct cxl_dev_state *cxlds;
 	struct work_struct detach_work;
-	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge;
 	struct cxl_nvdimm *cxl_nvd;
 	int id;
 };
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 08bbbac9a6d0..7b3b24a12d6e 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -64,7 +64,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 {
 	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
-	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge = cxlmd->nv_bridge;
 	unsigned long flags = 0, cmd_mask = 0;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct nvdimm *nvdimm;
@@ -79,7 +79,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
 	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
 	set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
-	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
+	nvdimm = __nvdimm_create(nv_bridge->nvdimm_bus, cxl_nvd,
 				 cxl_dimm_attribute_groups, flags,
 				 cmd_mask, 0, NULL, cxl_nvd->dev_id,
 				 cxl_security_ops, NULL);
@@ -238,7 +238,7 @@ static int detach_nvdimm(struct device *dev, void *data)
 		goto out;
 
 	cxl_nvd = to_cxl_nvdimm(dev);
-	if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
+	if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->nv_bridge == data)
 		release = true;
 out:
 	device_unlock(dev);
@@ -247,34 +247,34 @@ static int detach_nvdimm(struct device *dev, void *data)
 	return 0;
 }
 
-static void unregister_nvdimm_bus(void *_cxl_nvb)
+static void unregister_nvdimm_bus(void *_nv_bridge)
 {
-	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
-	struct nvdimm_bus *nvdimm_bus = cxl_nvb->nvdimm_bus;
+	struct cxl_nvdimm_bridge *nv_bridge = _nv_bridge;
+	struct nvdimm_bus *nvdimm_bus = nv_bridge->nvdimm_bus;
 
-	bus_for_each_dev(&cxl_bus_type, NULL, cxl_nvb, detach_nvdimm);
+	bus_for_each_dev(&cxl_bus_type, NULL, nv_bridge, detach_nvdimm);
 
-	cxl_nvb->nvdimm_bus = NULL;
+	nv_bridge->nvdimm_bus = NULL;
 	nvdimm_bus_unregister(nvdimm_bus);
 }
 
 static int cxl_nvdimm_bridge_probe(struct device *dev)
 {
-	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
+	struct cxl_nvdimm_bridge *nv_bridge = to_cxl_nvdimm_bridge(dev);
 
-	cxl_nvb->nd_desc = (struct nvdimm_bus_descriptor) {
+	nv_bridge->nd_desc = (struct nvdimm_bus_descriptor) {
 		.provider_name = "CXL",
 		.module = THIS_MODULE,
 		.ndctl = cxl_pmem_ctl,
 	};
 
-	cxl_nvb->nvdimm_bus =
-		nvdimm_bus_register(&cxl_nvb->dev, &cxl_nvb->nd_desc);
+	nv_bridge->nvdimm_bus =
+		nvdimm_bus_register(&nv_bridge->dev, &nv_bridge->nd_desc);
 
-	if (!cxl_nvb->nvdimm_bus)
+	if (!nv_bridge->nvdimm_bus)
 		return -ENOMEM;
 
-	return devm_add_action_or_reset(dev, unregister_nvdimm_bus, cxl_nvb);
+	return devm_add_action_or_reset(dev, unregister_nvdimm_bus, nv_bridge);
 }
 
 static struct cxl_driver cxl_nvdimm_bridge_driver = {
@@ -306,7 +306,7 @@ static int cxl_pmem_region_probe(struct device *dev)
 	struct nd_mapping_desc mappings[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
 	struct cxl_region *cxlr = cxlr_pmem->cxlr;
-	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
+	struct cxl_nvdimm_bridge *nv_bridge = cxlr->nv_bridge;
 	struct cxl_pmem_region_info *info = NULL;
 	struct nd_interleave_set *nd_set;
 	struct nd_region_desc ndr_desc;
@@ -395,7 +395,7 @@ static int cxl_pmem_region_probe(struct device *dev)
 	ndr_desc.nd_set = nd_set;
 
 	cxlr_pmem->nd_region =
-		nvdimm_pmem_region_create(cxl_nvb->nvdimm_bus, &ndr_desc);
+		nvdimm_pmem_region_create(nv_bridge->nvdimm_bus, &ndr_desc);
 	if (!cxlr_pmem->nd_region) {
 		rc = -ENOMEM;
 		goto out_nvd;
-- 
2.38.1
