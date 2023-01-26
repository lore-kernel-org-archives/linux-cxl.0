Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D65AC54E94
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 16:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjAZQez (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 11:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjAZQeo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 11:34:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FEA3EC43
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 08:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674750882; x=1706286882;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5I+FiGLGwiJUms+Jvew1QbqRgCu2kz1sHQocMgs+vbU=;
  b=eEGm3r1sBbNPkMFBXyvYLpxrzdPzj3ZuZOF5xynsXWc3h/bAVeQP0jJS
   kpUyZN2As/Q18WuZt3Bit+az7osxPu36s9bE/dd0LxvlcFUhR8DkcYSLD
   r8DgqCUeNNVgFlLKUbfPQFNUKipPuHJqa/5kMfNPTAO4AHuftchaqj0sT
   50j27xRIj7rcXu4OG6zhNJ/w79zS74hYxQCBTa0Kd+HbR9/dQYGj9zTm8
   kYF3DRq4+3HlF6gPVCpDvX8w9qQVo2PPj314G0C46R+QKjANLJtSkOPHK
   1S/ZLW+g5qOs+1FVRmjL9IjXQR0sIn/Bvmoff5R15KiPVHTxzlLvIqh2X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354157909"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="354157909"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:34:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="786892433"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="786892433"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2023 08:34:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 08:34:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 08:34:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 08:34:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSDqerhtW0KF/uMXl8fX0236v7kz/wEQwwGgJM5kbjPQOLC3NtlDbO2+y0HAVHUW43VYwZTK+uxbXsxe9OqPoLHDEUmJY6kTgGNHFdKeEoqP0hPZiQW1ZX2DSz7gVlxTJXjaMrGrShA5Wb3d+mYbSF1bsnPH4WI1EmQ7gA74h4T2juNzoZhY3+assZeWWNdD222H0IfHNRP2O+MP8C6nEAA6N8p90j6e32yLo+krvK8ojxYXaCZFRV3q9qzHf7rvkam7wKLyiAsuZbiQB8ke3wpzs1Fn0n48qwzvY4urLnEcfy8tagZ244QO9FJklFQY8BHRY9IvKYW7ks8eT2HOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GQ323p+kkhWJyte/m9PKTVAY/sb8Al66QBzrNwbwos=;
 b=FgeNYbcGgSb4EbOguSqAiWlMWBTsCKMdOuAQH/GDQxbx7bgrtEqf6e2DrWxbq5+9eoBilJu+uzZI9nKwUIXVle+++pUiFGisBW8+KeG6w+JiJx+uFmz1wv7rhUU9t5rGxg2ZkU/KkrzVo9GWY/CBrkjWTDY7ZjG4LbFd//vPcBcY4ynpcY9Q85OFtiqEQJMRHbTcNKksc7gUnF3V3v2W27J1t7gLdosEzDpNNtj1i/6LosTPxPTSvLsi+N32qM/bzdiEekbYOPTsXCdPX/qyI8XFU6Tbwo+7vI4qBT257Q6oy/3/hrJ15t2Hu0mcKjx0rhwoc/tO8zqdYmw2buXXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 16:34:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Thu, 26 Jan 2023
 16:34:37 +0000
Date:   Thu, 26 Jan 2023 08:34:34 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] hw/cxl: Fix event log time stamp fields
Message-ID: <63d2ab9a96dd3_60173294d1@iweiny-mobl.notmuch>
References: <20230125-ira-cxl-events-fixups-2023-01-11-v1-0-1931378515f5@intel.com>
 <20230125-ira-cxl-events-fixups-2023-01-11-v1-1-1931378515f5@intel.com>
 <20230126114130.00000b98@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230126114130.00000b98@huawei.com>
X-ClientProxiedBy: BY5PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ebef97-95fc-4373-4a03-08daffbb3701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgI6g7gH6qTVE9eehko8VMO2sUNF5g+YpuUhPrrRgQMm8p1A/AavxWuPP0ax+xQ2StMcIa9eS5aq/DYhoEXTg8mftl2bfIiWmT96wPeijmx5usbBRnMudCoTWO3guUKJMx14ATs35HTcz3fPLH7jiLmMoEIqqr8ilKlJFuk5Hc7A0iDoqkBNQDgFMKut5uh0Z7jnr/qIoW4nIjy4rGw2B4BwfB+befrhemHOsk5iwJGIt5DKioyW3VbgsC+zJ3fVx65urCx/FxRait3kTtZMF1adpD5KkInWInPHg48i5D0JFBHvFVtLTxf0mULp59AY1W+l1jzfPUg69nWReMMI6bnyBVZRMnbCc8sf87+5n5mB+ZPeASSHnjgKy3lKV1viRqJLWMxOPxcAhx/Y+Jm3WKDKIb6WDp18Vv9O7LmSSzjR7sNlTO1NxYUgOpPynmZzkCou+jBLbCJKt28SNZHWNs0kFgbhMMRv026D36Vb4imMBoW6y47PApYwbMho32lIYCNLvMtWQvBpYJBpBHtqPRHCVWfu5xZkD29U88IsTvV/dJQtJwyVHNPRQTnxNgVlEKBdzRo8VAsHgiE/5DrLuYqYzCTi1EIQC0DveAQQT2hxhoj32mCd6IpRdWbFoMxdozcbUWS6JZw8ceGFI3wZFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(66476007)(8676002)(66556008)(4326008)(8936002)(478600001)(26005)(66946007)(83380400001)(6666004)(6512007)(9686003)(54906003)(186003)(6486002)(82960400001)(44832011)(86362001)(5660300002)(110136005)(316002)(2906002)(41300700001)(38100700002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NFAyCCVzC9hioUdA9sFvzCSlyKDorrxDC3qp6jyrhQsexj32vlHDL9I5Agdu?=
 =?us-ascii?Q?20n/phZmaJ//0v1giY9E4PWd5DnbjR+m/ovbmep3A1NlsAlfzWH3yj/hpGc/?=
 =?us-ascii?Q?vfc0ZQDY0XERMPBA/6/jky49inwiyjCY86/4yF80QMUDIuwHxUVyncZQTyCW?=
 =?us-ascii?Q?RcA4zxACMadWMaGk6+DqEj7uRersNTzwOsg0Ar9EsryeKolLx5g4P//wAR25?=
 =?us-ascii?Q?JbKf5bvZbf6XzpCszVu6bAGOiLt5JFedcWO8ZQKcRFBAqu/t6MgvUeAoNBYh?=
 =?us-ascii?Q?EEMLPeyuiTrYlmGzXRm26UNTyMaDKPZE3ljn4kD4wmwzSbRwgfNintqKQEjl?=
 =?us-ascii?Q?I0d2q8/nHglWJPE9eu6rgmykjNDMcuNVEb3wD1LqzufwT8UBDJ6vyOiKDZoX?=
 =?us-ascii?Q?DfOsFX54Jn7h24OXwvNtNuWyjV5J3bGA0Rgmi5Bl81PxwZclBLgXmeGRiS2y?=
 =?us-ascii?Q?k84+/Wf7tFW0piDA7PhCUP1ehchnlMcMAGYzHr8D/lcXq0wB7wHWTCZvonJP?=
 =?us-ascii?Q?fWjQ80mqDwAgjHSihjdLaDjiD/c3v1V5mSLYNGaFj/Msy8olC4UEknKgWtfj?=
 =?us-ascii?Q?1UTtydS4G6BX5vh/dZrBTeE+nw/yRRyZeiNzzITatnUBSj6/pKJrlKz2gtJQ?=
 =?us-ascii?Q?qw85zthZ/ZOoVmEWLAz6TEDA2JiM0fbHwT1yOlsIwCT6OCm0YHmSjb1tsVYF?=
 =?us-ascii?Q?7haDV79EmUZFBGq7LnUGsHgDiF8ddqg/SFJdgTRMjdd1Uq01zvnAuJ5gh+74?=
 =?us-ascii?Q?kLJ+s3f4py70trD3QYVJ/sZTFVDFvMePQ2r9a+4xkOxEa8tqId/zOG993KQi?=
 =?us-ascii?Q?8QboI+OgwjnkI70HlJbTeC86nHs53CVGS8eyCkBxadFdlpsxo93v+hUdJeiE?=
 =?us-ascii?Q?xxhqW5t4qepwA/CeEBz6UI+x5X1+VqdqmNGK26p2pMIt2gD7NhgKEUXy+eyv?=
 =?us-ascii?Q?ytTIN2eiieyy1it1ZCXz+riM9QwDV5b1lpyib/TnvV3HVllu+Aw0h2GswwTP?=
 =?us-ascii?Q?5xMBi0b1rwYvd9/fK92mT9azyrGIP8lFRKj4VeXJ7Ygig8JQq7KU3MdJDi5T?=
 =?us-ascii?Q?ZYBW9tmYlXkXvG9ySDHdYZcTzzCg69GMGg8+9zIbxTIHGZqmMS9nH3gn6RT8?=
 =?us-ascii?Q?w50RLjeHb303WxkRq+AvafkscwwKRR5Ywt25VfmNSC57bZy4o1BEu7RHeJok?=
 =?us-ascii?Q?9+/Q9Yq4xfVrfzSJqYBQBpTngyndM5HWizsS5uTpnICjlY9BD4vgvnEKomTz?=
 =?us-ascii?Q?WjOWwNpYqSB+bp1W75jHzfJgoHkv3l9L3ypI1lN7rjPMoUq4kwFbj0nvu/7O?=
 =?us-ascii?Q?RtULfB1O82S7p4look+iLAUrxyrIRTHf+a731y0psm37+Xb0mz6sqXFHnRwi?=
 =?us-ascii?Q?8krFp5qICPK+TMwDz1b9rrleegZEvl5YyjC/aM533dVxBG6J+Vr/nNVETRNe?=
 =?us-ascii?Q?0QYOReiBuef8ql5VwRgr7jfMOwwNDsl7PVXl+dTztOjYeKIuK+fAJ+ggpb4G?=
 =?us-ascii?Q?uCMwkFkCX1ZCMJ1E6LE8kom1qXtMBrkK+jZUs67sbLC6BWVLh2XIEGrfuGx+?=
 =?us-ascii?Q?DvPxLoUlcPozlU+cBSwfFtCee04FvMu2z7T/dHNL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ebef97-95fc-4373-4a03-08daffbb3701
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 16:34:37.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7kOIP5wpbke0Vgumu2t2P1htKqHAXhgq4pkf8K/pKBT6x3D1Nsyg717RhkSBqgBFInE6g747CZy3He0N4rW7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 25 Jan 2023 21:37:27 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > CXL 3.0 8.2.9.4.2 Set Timestamp and 8.2.9.4.1 Get Timestamp define the
> > way for software to set and get the time stamp of a device.  Events
> > should use a time stamp consistent with the Get Timestamp mailbox
> > command.
> > 
> > In addition avoid setting the time stamp twice.
> > 
> > Fixes: fb64c5661d5f ("hw/cxl/events: Wire up get/clear event mailbox commands")
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Hi Ira,
> 
> I'm going to split this patch as I am carrying a very similar
> utility function for an updated version of the poison list code
> and I'm not sure what order everything will go upstream in.
> 
> So I'll split this into:
> 1) Patch that adds cxl_device_get_timestamp() - adding the
> use of this in the GET_TIMESTAMP mailbox command.
> 
> 2) Changes pushed down into the patch you mention above.
> 
> Given all the code is yours, just split up, I'll keep the SOB.
> Shout if you mind me doing that.

That sounds great.  I'm just sorry I did not get to all this sooner.

Thanks!
Ira
