Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3FBC77B60
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 18:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjDWSrY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 14:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWSrW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 14:47:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48601A8
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682275638; x=1713811638;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KihHAol4QUsnBlFanHElyA9ib1NR3FyHlRjkCfPyOHw=;
  b=ReEa/6H11NN3ylCmCxVhDUqM1BzweF0UvpvgZdpXU7NsaWipGUMBPWh9
   N398AG6eo5lO+oVUiPYSDoCgBRyttMI0FI/OL9tozXBxI2bwl6Erm5+nw
   CVYdLLZ1cO2L5c2DpZ93hrJI9W2/mxSwcH5UzVqhDfAb7C1bs13eh15AZ
   MYWdD1i4RZOnY209EV5Zh34Ttb+LM3qTh3LwM08g+zYVPJ0IBKihdeBPa
   JeXh2CxZ7VR+pcHRoIPgg2mzbyKvEWBOvdjIaqKHC/L02Nb2RwjiOpaxv
   7kwkvzFpa1dXxrfp87N41SusdGNxGHzNtBeR+m/uL6OlrAgAORYO2YTI8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="348214477"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="348214477"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 11:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="867256037"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="867256037"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2023 11:47:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 11:47:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 23 Apr 2023 11:47:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 23 Apr 2023 11:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyScsN0PeerNMZS4iDRDA0/auzk8+l8ozX4aU4EmNdPkvH8lu7vU58rC/0gRO4aBzmkTlOoSZJ4EfQypC2vS5y2zeNcrd9gZ23BWGWRPo1Z3TsWr1Yl8bhqayZx7H4/AYezd9RBJuk53Ripxb/AVmWcsCUWpQASa4SjWd+p4y0fl2UI6vmlvYbdLnrm1P1r0CmkDl7ccqY/GydmfYb/Kf8hVkIweiaK8nW5M0bSyd0omkgfBq+ypY/INn7Z+eKkk1Cau9pebXUelkR2WtX5CQB3H4aLCb8UQDPyam95MsomGuY0ws7KhdYyOpkQyS1njiB8KJW6AU6PElQRpNn6nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCOJuD7BWu2cDrKX0Cvds2fjDP7s9pP0uv68WWk2pHI=;
 b=bP8yRlZqg+fsNuSXdEFEFjsbIT0M1Co7kkQyx562pjf9zLPdKosJ2Usb1qtQjbwgNMdaRHn2cauFBep83IM0F4eFOwh+p2YrPw9DFmBzERz+WlMqBzezcxOA7UFq5PIZwVqZLTk5LFo+U3I9f/0Mb4rrC2nC0RcHnqX0FKxTAIqyut/IWZLr3GWfwxeNzTjD9ilqd7tr0MoOvj8ND0e6GWtileovH9EQyWTIfPDrd/BF/COkLEuxG92GHPnpQuy85hDJNOb5pY/BDqo8im3wK3bjeUTeItbYLr0qOvr9yuealWiTNoTpbR7MNhPzfOkb8XZ3dTc5G2xL/9XDqAT02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6041.namprd11.prod.outlook.com (2603:10b6:8:60::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Sun, 23 Apr
 2023 18:47:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Sun, 23 Apr 2023
 18:47:15 +0000
Date:   Sun, 23 Apr 2023 11:47:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v13 0/9] CXL Poison List Retrieval & Tracing
Message-ID: <64457d30bae07_2028294ac@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681838291.git.alison.schofield@intel.com>
 <20230423163011.00004b45@huawei.com>
 <20230423164126.0000687a@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230423164126.0000687a@huawei.com>
X-ClientProxiedBy: BY5PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:180::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: d3da6edf-7729-49a4-36e8-08db442b27ec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfNyYlv4vR6dpQ9R4GhR3r5n4UMDlYNo9smgrrGDZabdmMBCd90v0IiC1l4uXyqPrIckp+G87tnzU2SMQ31mNOKwdui0CakqNpmMZ7WZ7ebqxUo9CZJUxQn6rLGndZ9mP8viJ1kDb+73ob2T8IFmvJWVfU9ySaUDeumESiHyOftRX+D53j03oOlaktF0jT9XZYB+wyOqdR5swpZyztQ+PpkxIIkAMaY+kJgp+Ukcf2ACXtBiGHGedKSTZwUzQvNir0mFcS+aXCcYuOY2ZxeR4kXUn3l5RXiMv5kxxb03J098OsZ2OK4JFQQN5YE8qY3k6kkFBv5s767CBwFoJAIOZM8CLoMRi5PnfS33LyUqFJplyztlf9Y6A+Lojw/dgJzoszQPNEs3VvthX68mOOmpEPwp3FMvCMD/pH8EQKaLVgnG6hAEtauQESAmh/w+wTCHVGQ7StN/EEvjvtB+PX1dnGrmO6xUnqZDN7UGz469L8gNXje76lW5UkQLoZexeckb2Pb3/OWt+n+TchPe7g9DOiG48H1El8b7z5r/5pN7pfdyQFGfqlvaOP15EnE6PegW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(9686003)(6506007)(26005)(6512007)(186003)(82960400001)(38100700002)(66946007)(478600001)(86362001)(66556008)(66476007)(8936002)(8676002)(6636002)(54906003)(5660300002)(6486002)(41300700001)(4744005)(2906002)(4326008)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iu6J7Yfnkq/76GWfp5Fvn9AN72pk82absI0pZQjaKRZ5GuGrcKiR8giyJpC4?=
 =?us-ascii?Q?FNU/pFvQdmF+HE0bC1hgfEu2R7bfY2qoj+mDh7i/G5Uq+PsAncndCjfMqxQf?=
 =?us-ascii?Q?YEcfZtxNLvJgptJL+KDu1sBOXuIHKnfHwuc5vfixdLEJgmYH6GmcU6rJJkvM?=
 =?us-ascii?Q?1rfz1TqXotOPxC3JiqoCLWk3LEA9aprTJEzYWfzLKT5s2N8TP/35NHLPsV59?=
 =?us-ascii?Q?NlzV1s9GJ9A9awkrYTsoLxD4Y8jSLJOiUoVAAVvNCSRMQL5B60a5ay3XH5Hd?=
 =?us-ascii?Q?vkYtDGcVnG7Pe/5S4agpogGLrJRhEBE8lm0fj32gcFivDxKWHAO/5pcTn7Wi?=
 =?us-ascii?Q?H/v1CXe8mlzASETF3SVw9SH3fszDPk8vDszKDdU+BKOt/1XAh6mKi3kvgrlt?=
 =?us-ascii?Q?YXNkz44pSF8QF68thR1OnR8TQaTwzxS1uV3CiDQyKM2p9Vi0IOAh1T3/13FN?=
 =?us-ascii?Q?vwTd1CxSTVnacNU375kMuPtCqnkvKhhxkN5V/p9n6B65eLIAfFu/TfWUmAVD?=
 =?us-ascii?Q?F973+7klzR8grldvcXfHppNUUDJFdizH+ykP5lgtTlOZimZkwsyfanA2ae8r?=
 =?us-ascii?Q?HhHUqSKhES883bafASdMthKGizpXDVWJPQ/e+VNzHbmj1qbhBkNJayqoF5k3?=
 =?us-ascii?Q?xuaeWSAJPaBu/FvZZg2Z8lOS8DZABIXErqkSOevnyvHmHUEEMFW83NCxmfI5?=
 =?us-ascii?Q?AKIa3SHB0iuIyK4hAuHzpyKL5KcrbNF7X08llIH2Ry+jJyuKJVf+WBB6RTuv?=
 =?us-ascii?Q?2a5a4gzG7jieS8rMQTRvOpxk7+SOjA9rL/R8HpgWVW1BtFsXJK/3yOp15IsB?=
 =?us-ascii?Q?cbfYTtXMbtVyZqGlK31qPl+caZCd7sFCJytAAZgY1dqn0bw9WpDueWU+VUeR?=
 =?us-ascii?Q?yRGPEddP4+mMZwnHSUxOzxaY7d8xZ8PCcRGW7g6ZnD+QdejhjEet1F1qGsej?=
 =?us-ascii?Q?MKuD6rW+9VjruovcjNvHcybuh6JwHPQMYHdkk7BdsNBishMr/uGcl9iAtrR5?=
 =?us-ascii?Q?/YTzXW7Twj6I8GoBg8BQ3x2CfsI4KXlFxrhZR3qy09KF2uE420hfncmMkQGl?=
 =?us-ascii?Q?e+KViPNYoBLnLu0WNEFHfG/Ek3rsAUHZChPqlYPdp60paK3Mw7yYsMo/inlI?=
 =?us-ascii?Q?01oXNBY66qxwKP8kWHVYlhCPQW7nBAc3CKTOgSSc9vWv1zlHvOMrmJnghgKJ?=
 =?us-ascii?Q?Uvgv/PtLydCLjUuFXhiOR7qmX+/4Xb4fm3/DbwcJIeIDBCIeZkSv2OGzwsWV?=
 =?us-ascii?Q?RmzHugobqxlPE63b8rDWbvv6btJte3eUvkRpq5WfSDtyPCen5e4lPpUZ9w7k?=
 =?us-ascii?Q?oCPqeNZ+2k1WKAGv8g37a9SHPfDxfjd/TKkrA4fajprAIfvpYlYxfxFWkOMQ?=
 =?us-ascii?Q?35Lhnim8qpgLRblwT3Gg+ioTOrYpYGDxRNCL9GLLs4p1skFZFA25jOpVDZFz?=
 =?us-ascii?Q?OR2H8bX+88QJyyOj8O2qPLXnXyYzfzLgN2QsydGPszSdzDSe0cIBumYMPH7V?=
 =?us-ascii?Q?oqCZLkFGVPBN3KD8aLEj/d90Wziw16MRsOVyHm3pAy63wOnSJ04iv8iJ+xNO?=
 =?us-ascii?Q?FxEKiEXvX2x0VMJHykUiEAuPXxTKzH/18M10tqvLx3jeb9lJciWuczEjrwPf?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3da6edf-7729-49a4-36e8-08db442b27ec
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 18:47:15.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9aQsK3Uwdm1bn2kU7YYsGwByS1fmZ0FE5sdJw275OMRYGw8nhdav7C436tTjLLlPkKZGVmeo2UIJjxaKqZhhqWyP/GCiQ9FHt1v1X+uU24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6041
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 23 Apr 2023 16:30:11 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Tue, 18 Apr 2023 10:39:00 -0700
> > alison.schofield@intel.com wrote:
> > 
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >   
> > 
> > FWIW I've just been hammering the QEMU emulation for this to test a new
> > version of that, but as a side effect I hit ther corner cases with this as well and
> > it all looks good to me.
> > 
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I should refine that slightly - doesn't cover patch 9 as I didn't
> try the mocking.

Thanks Jonathan, I've picked up your test and review tags.
