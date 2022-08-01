Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200C2C00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiHATtZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiHATtY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:49:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B362030F49;
        Mon,  1 Aug 2022 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659383363; x=1690919363;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rm0U2jvbCtuae/+lGPkPN7x34u9M3q3DZrJtFcYDThY=;
  b=g5N4VL+90TGeViL6dkJgsIN22/mAbBPJuaxC5tFjivWKGLTMpNHF2qf4
   qkVr6voSYvYTUAOdQghPriQjDLW40/kEE428pr1mqp8/HeCWJzAdymbS9
   Samg7S7TlN0E6mdYo0L71+5CDWu4SYhyLUFq2v4GtDeNBMBZOmyLv8BOD
   YH8xWIGRn8GwLtDbFyVhRO3lqmdC+zGpaU/VSBDrQeqCT+irtRRTPBSCs
   2MMTL4jTyDTccHISsm140s7w+4OVpZnC3kbzw/hlrxgTU6aZWPkwQgnSl
   7TXzqNH58y0BPR4dOs/kv6vLwfm9F02SKwwMKYWHRfdo1yXG5V3tQ+bLQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353236022"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="353236022"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="691583694"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2022 12:49:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:49:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 12:49:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 12:49:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/R5KNf6O7u8cqNWHnPsA+5oRdnBulPupwEHdVDo11K1HstPyGjmfkD6OLrZ2H8aHf9xdS9lRvx9p3COIs3WeOixg0in4P0lfQ96iIQSt12TW7Y0k+yJG4/VXfJbeVbyrvgxfHclG8ArYwXY5N0wyS/s95LgOpRJHsEGPzAC/3ATWsqyx5K6TFOjKeQrZV8XtO5HGPYbM3zpav3n9SQvV+tC5/UZ1BTrzEg6dTNua5RJTFgsVXzjm6CSEu2+RzDp3mUU2RVwmFgFNkgBCQxD/cjgr5vPgv5kCife8fdIivfOmAPG9LqA4VGO7GbqM4w7MFU3oDf7Q8FSLUVWBrG+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wgx9UWowwiMWjWAtHhU+BuH74hs9GFN4n+7zZRK9B1o=;
 b=jWM8pgr7g7SsMtHJpfZDHtaQv0l0T3DSQ4BiJhaHxJggvX15Tx7IPEBpncaFHoU7kZqXnVM4YViP/wtJP2FxXhUT6OLCZzFGjztOimE5aXQFr73bYX45N6CRxu+5Rr2o/7pwJ+k42biD70yn6N2CycfdoCw/ws40bsyBDoR9rJkuQXx8JY0mdwGhqe/NKO6wk1iByi+qWAbps+kDJIpSW2MroBBL0Njp830OrvpS6FhvQ4gYCWVrhFjDq6Hl7qNxP5fF77I2/nLpvxvyY8TQYwgmq+yEMYTH8nui4zRrIs2gEApkNglAipd2ZKFUCB4+rQk9MLEE7oedVKpkXSjWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2661.namprd11.prod.outlook.com
 (2603:10b6:a02:c5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 19:49:10 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:49:10 +0000
Date:   Mon, 1 Aug 2022 12:49:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/region: decrement ->nr_targets on error in
 cxl_region_attach()
Message-ID: <62e82e33cfe46_b075294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <Yueor88I/DkVSOtL@kili>
 <YuepCvUAoCtdpcoO@kili>
 <20220801105626.GC3460@kadam>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220801105626.GC3460@kadam>
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b497879-a85a-4c95-a1b2-08da73f6e6dd
X-MS-TrafficTypeDiagnostic: BYAPR11MB2661:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dw/3ad1oLHgOlo1IhTpk2+iMBjf6AYXhv7eapwH92TsJUPyPCDsrDH8JGJYpBq0XO6HJ3ErYOEnEUY8KzKSMm4ex8rnCX7LqfsINl1HjS4fCJ8UK3Us3HFFipoNSo8cMVv42xOdtcM9STIFfpVzzf8g/vCSPkAlA5DWP+q22+gvXjiqULhvD1igj9+r6ze3s+0zgxZkZI2n39Dg5RPrdg5WYbFqBZ1/X97WDEdVIE7emRbthLYmBcgxgaHBhjMOxFHR2B4rm34Zt30zLlrVFV1k7Yud0HYHXzLBhuEvr84RwySoCUx+lMsfjczWnd5uRDk7U8Y0HhwEcGVIfuZ4GtSuDlgYVJhTynHBDnsB0kyRfXO0zNbDvvYlFC7mAHCSQi40EJ2HyM1Jiq5V755QE6ZfL2Nkrhufh5Qg4S5bOCPHIsghJCECL5ZydH4fmSbcZS5UPgKekJ66Bt0Xu7aK6u3cV4quG3YjECr6dcH9l05AVPZP2248L5JMtqGfTmblSNJ2ebwhW8PlFT0v+bXXBSJWuLsRtqwmv0OsStIiDlPtUBbBNRl4tDThxvbs4EtTPJY6GMteJ6aPqEO1ix42qOGeX/BQhJI+xTW7fBJOZd8RVAJ22Q/T6sI2gQlSKCKQCyWfa78ZBiP/Z9GvnzEp0XeCYjG32U+NxLIUZ9qB53S8WVU1fhgYjqOoKYdo8ZkBwtgUBkTU5vMcHpUupQWW1mOmb2S4pxfg+LOWxbRu0LhQWx4O9Yfs1fFGEn5v2Vss+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(136003)(346002)(366004)(186003)(2906002)(6506007)(6666004)(86362001)(41300700001)(9686003)(26005)(6512007)(38100700002)(83380400001)(82960400001)(316002)(5660300002)(8936002)(6486002)(66476007)(4326008)(66946007)(66556008)(110136005)(8676002)(54906003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bn+DsjmgRG5fLASSO0WGLctKT2oPuaiAvks4dU3DAd5SeAHorlp0fiCSJn5f?=
 =?us-ascii?Q?Ji5JW8/xeQ00hGbYYr/uwsiEmSbq6CO7WczfPMYPA9L/s+3OOCOQMPzoXnXF?=
 =?us-ascii?Q?W1Gm1gOaq80lvRwx/gf1A/FSkGHKzOH8aOCeJKAE/KRtvUPkK5cVZZh+BqVo?=
 =?us-ascii?Q?h2HTWfE94SOVrEUK5fMFvY60j4xqLzCOJibst/EotjwYgZad/lI/FoACesMP?=
 =?us-ascii?Q?QeY85gVyVn+bz+dk/EzX/o4ZvggQOCnZp30d1WtK4vakweVsv0wkIbUmkvYx?=
 =?us-ascii?Q?4wNnUGClfyGYP9GKvpwYdxLNuBQpgeLV2L/0zueIA7+q46wMiEqVvOf+axgT?=
 =?us-ascii?Q?bLp9V0/LjCTJpYgX16/wmkhDi8wMfVGnfdFuB+RPBgwV2x2jUcMPUAyPSNCS?=
 =?us-ascii?Q?uopRp4PxU1zBiNxhIqyu8yS9VxOBOwWHQ4Z/QLwvwug+tJbeme610obSf35U?=
 =?us-ascii?Q?f3JPiPwd/mHnOlSyImE8R6U5gYFExu7ap3Z2hXbdlmgxyM7U/OfNj3i2ahkP?=
 =?us-ascii?Q?IFGw2J30/MuqtphXbHpq4McsNXlKTJDQp1TVf/WK0eTmgOTLYJZabo8jT0Ol?=
 =?us-ascii?Q?Cy5WzvyJPNAUYgimD9nvvhOXULVelvhPxTPjqD1RGYZSSPQiL5fQrhIMHFUB?=
 =?us-ascii?Q?EdechHSi31KR1gdjHqM+hyHv2Dp887HUjFW+rwrtOUyVgnifowfclANMtqzT?=
 =?us-ascii?Q?vu9wjRq3/+hbxu8M8oCgUZ3YbdUXYWX35q7D+WclgeY+zLksfXb5FFO3Eu2o?=
 =?us-ascii?Q?C+CvY3c3HcVsTgrB0m/HzCmHQ4zk6DKF6LHEEjG8LQ15P7EzylHRf9LjTH/Q?=
 =?us-ascii?Q?BFJLYypVn67AkGXCZkb0MFIoTqTRoyOdwQpYULOCd6/vfVgQR50aaC94pxPg?=
 =?us-ascii?Q?2KIzPUPtIuZ1jsRDaZB7T2/ICCiJqa8YFyPrdE9f0WD3msfzv8OBpmitGgJS?=
 =?us-ascii?Q?y+Sba1Pavbye48G2nN12wqurExV2/wg+7tvv0AP8ypB6se65rwiLugBpcq6r?=
 =?us-ascii?Q?E5XcJs5SDJea5Pc1dK5xWYehbw7xnA5seKP7Yp2ue41PY4ASePUh3qnWV0D/?=
 =?us-ascii?Q?+8M2mgOIs/emz7L0Xe32L7MoUii05aP4khOq3LnWvFg0bzYAwDY8E1NsPFkc?=
 =?us-ascii?Q?6NS+BTGVysUW+tbA6ND2jAB/RdPMGUfd2Av5umvaLNm65lIPwGBGWFuEBIZu?=
 =?us-ascii?Q?4OUlpVycQu6H6P5zxKufGSAxz5ng/MzQV/N7geo/tRgFNQoTsZqiPdSR+saW?=
 =?us-ascii?Q?cuJ6HTIw/nq8XFD2xNZ1OXplykkXGddkxvu0P9nWU8I1jEj0NsyQ0Q4t4nYA?=
 =?us-ascii?Q?bamK8cSikjtcDDNH2SF1pGGOPPcVkNYkoPBmJr6M/GWTcrginj+Q5QRGtxj+?=
 =?us-ascii?Q?Hr2cErya0bJKtNrfeVQ0ZQorC2bpArFQ5ZN46RfOyWD0wYakaq09ZLEhaphc?=
 =?us-ascii?Q?643jcWl1ppFZ+Y2CY5G3aXvBXPIC1UEC3Tr9jb2NsM8QJAr+D0sXWXEPM7gi?=
 =?us-ascii?Q?9KtJx8R1nxRiBT2l81mcCXYy+Sm7PLo0Vj07Hoi2j6XbyjN5kQfXXO2lMcnU?=
 =?us-ascii?Q?iavZx8o6CKmmUzfombhNP20hz8fAb2jW1qSFucUhT8JU6mzxH2xfkZFq81XR?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b497879-a85a-4c95-a1b2-08da73f6e6dd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 19:49:10.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PxXgPjaKjYy0J9MpKObgXAY1tgfAZqHGEFVUT+Pet1y2Vw3cjVP1p+PtPf2zuzlj6xfuE34ZE+4O5D4dBdqY6WG0ZT8ak85OA51XiGy/ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2661
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Carpenter wrote:
> On Mon, Aug 01, 2022 at 01:20:58PM +0300, Dan Carpenter wrote:
> > The ++ needs a match -- on the clean up path.  If the p->nr_targets
> > value gets to be more than 16 it leads to uninitialized data in
> > cxl_port_setup_targets().
> > 
> > drivers/cxl/core/region.c:995 cxl_port_setup_targets() error: uninitialized symbol 'eiw'.
> > 
> > Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> The error handling in cxl_port_attach_region() looks like it might have
> a similar bug.  The cxl_rr->nr_targets++; might want a --.
> 
> That function is more complicated.
> 
> drivers/cxl/core/region.c
>    740  static int cxl_port_attach_region(struct cxl_port *port,
>    741                                    struct cxl_region *cxlr,
>    742                                    struct cxl_endpoint_decoder *cxled, int pos)
>    743  {
>    744          struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>    745          struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
>    746          struct cxl_region_ref *cxl_rr = NULL, *iter;
>    747          struct cxl_region_params *p = &cxlr->params;
>    748          struct cxl_decoder *cxld = NULL;
>    749          unsigned long index;
>    750          int rc = -EBUSY;
>    751  
>    752          lockdep_assert_held_write(&cxl_region_rwsem);
>    753  
>    754          xa_for_each(&port->regions, index, iter) {
>    755                  struct cxl_region_params *ip = &iter->region->params;
>    756  
>    757                  if (iter->region == cxlr)
>    758                          cxl_rr = iter;
> 
> Should there be a break statement after this assignment

Indeed. If the port already has this region attached it means that it
already passed this check previously.

> 
>    759                  if (ip->res->start > p->res->start) {
> 
> or do we really want to test every ip->res->start?  This loop is
> confusing...

Let me take a shot at reflowing this whole routine to make it less
confusing.
